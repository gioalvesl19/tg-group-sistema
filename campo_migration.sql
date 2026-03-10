-- ================================================================
-- CAMPO MODULE MIGRATION
-- Run this in: Supabase Dashboard > SQL Editor
-- Project: teftltzskdtypfjctmlk
-- ================================================================

-- 1. Create field_activities table
CREATE TABLE IF NOT EXISTS field_activities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  activity_type TEXT NOT NULL CHECK (activity_type IN ('visita', 'reuniao', 'entrega', 'coleta', 'outros')),
  description TEXT,
  location TEXT,
  activity_date DATE NOT NULL,
  km_start NUMERIC,
  km_end NUMERIC,
  status TEXT DEFAULT 'realizado',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Create field_activity_photos table
CREATE TABLE IF NOT EXISTS field_activity_photos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  activity_id UUID REFERENCES field_activities(id) ON DELETE CASCADE NOT NULL,
  storage_path TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Enable RLS
ALTER TABLE field_activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE field_activity_photos ENABLE ROW LEVEL SECURITY;

-- 4. RLS Policies for field_activities
CREATE POLICY "campo_select" ON field_activities
  FOR SELECT USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'gerente'))
  );

CREATE POLICY "campo_insert" ON field_activities
  FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "campo_update" ON field_activities
  FOR UPDATE USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "campo_delete" ON field_activities
  FOR DELETE USING (
    user_id = auth.uid() OR
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- 5. RLS Policies for field_activity_photos
CREATE POLICY "photos_select" ON field_activity_photos
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM field_activities fa
      WHERE fa.id = activity_id AND (
        fa.user_id = auth.uid() OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'gerente'))
      )
    )
  );

CREATE POLICY "photos_insert" ON field_activity_photos
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM field_activities fa
      WHERE fa.id = activity_id AND fa.user_id = auth.uid()
    )
  );

CREATE POLICY "photos_delete" ON field_activity_photos
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM field_activities fa
      WHERE fa.id = activity_id AND (
        fa.user_id = auth.uid() OR
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
      )
    )
  );

-- 6. Create storage bucket for photos (optional - for photo upload feature)
INSERT INTO storage.buckets (id, name, public, file_size_limit)
VALUES ('field-photos', 'field-photos', false, 10485760)
ON CONFLICT (id) DO NOTHING;

-- 7. Storage RLS policies
CREATE POLICY "campo_storage_select" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'field-photos' AND (
      auth.uid()::text = (storage.foldername(name))[1] OR
      EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'gerente'))
    )
  );

CREATE POLICY "campo_storage_insert" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'field-photos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "campo_storage_delete" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'field-photos' AND (
      auth.uid()::text = (storage.foldername(name))[1] OR
      EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
    )
  );
