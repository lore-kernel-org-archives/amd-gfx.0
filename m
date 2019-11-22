From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] drm: share address space for dma bufs
Date: Fri, 22 Nov 2019 07:37:49 +0100
Message-ID: <20191122063749.27113-3-kraxel@redhat.com>
References: <20191122063749.27113-1-kraxel@redhat.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122063749.27113-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: robh@kernel.org, intel-gfx@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Use the shared address space of the drm device (see drm_open() in
drm_file.c) for dma-bufs too.  That removes a difference betweem drm
device mmap vmas and dma-buf mmap vmas and fixes corner cases like
dropping ptes (using madvise(DONTNEED) for example) not working
properly.

Also remove amdgpu driver's private dmabuf update.  It is not needed
any more now that we are doing this for everybody.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
 drivers/gpu/drm/drm_prime.c                 | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index d5bcdfefbad6..586db4fb46bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem=
_object *gobj,
 =09=09return ERR_PTR(-EPERM);
=20
 =09buf =3D drm_gem_prime_export(gobj, flags);
-=09if (!IS_ERR(buf)) {
-=09=09buf->file->f_mapping =3D gobj->dev->anon_inode->i_mapping;
+=09if (!IS_ERR(buf))
 =09=09buf->ops =3D &amdgpu_dmabuf_ops;
-=09}
=20
 =09return buf;
 }
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index a9633bd241bb..c3fc341453c0 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_fi=
le_private *prime_fpriv)
 struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
 =09=09=09=09      struct dma_buf_export_info *exp_info)
 {
+=09struct drm_gem_object *obj =3D exp_info->priv;
 =09struct dma_buf *dma_buf;
=20
 =09dma_buf =3D dma_buf_export(exp_info);
@@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device=
 *dev,
 =09=09return dma_buf;
=20
 =09drm_dev_get(dev);
-=09drm_gem_object_get(exp_info->priv);
+=09drm_gem_object_get(obj);
+=09dma_buf->file->f_mapping =3D obj->dev->anon_inode->i_mapping;
=20
 =09return dma_buf;
 }
--=20
2.18.1
