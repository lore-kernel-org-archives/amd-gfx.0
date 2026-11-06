Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31209606A328
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=to+rtgy7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65803112CA5;
	Fri,  6 Nov 2026 09:26:13 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962CC10E3EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 07:17:32 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso576952eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 23:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793949452; x=1794554252; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=23tdgrbhdEj0Ew1yGHRUaEBBGufmw96pkWF7xHJ9Y+w=;
 b=to+rtgy75NKeo0RJqsR4psLSn0T0G44FK+ok06dgbxWoAatyzr47lTOlAQbTk7YNDD
 s0s8e+ZtybJDJPpqtHR98WeCmAyiVmKD80hQTPyzR33SVt6mm9B+bSQryPu6LfDRHfCA
 ubnou2+Ayokbbs4kA+K1f+LStlqlVnGSVurqEqPm/Z+Arx8cz9tK4smHLbNQcJ8DJlHw
 xCwl+1FLVX3v9s+gWWVNTsZBPLagK4t8kaDD0DqyCsi+83TJHE7ch2QpWunLB0y0XdiY
 gJ57QgGJyNhxzWtmzHO+7UqzhE93EDyTMYu49uGxz8KTyLkFqZIqXbq/8cHSPHVhlFXD
 z4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793949452; x=1794554252;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=23tdgrbhdEj0Ew1yGHRUaEBBGufmw96pkWF7xHJ9Y+w=;
 b=ZMwq/7HIy8ICg36jJ7ssbL7BnBKiBAD9RQSZSRTHEe5HuuS6C3g63IHqwvTSiXtFv4
 j5gJ1853SCu6PXFBezkJfkTIHTQvnF0PF3njLxv9AD6mczWK5NdKrz3Wez2qt7tvnirq
 WI4KZAKUCtztB/0bqA878LF0ZZvCMmqR5HCaBQf/vDNBZOwdab9VAVNd5/vfsV8tMpi4
 GG8Sp3qqpeR27A6zx0mnYqZuwfLK6hq4U6HLazBx8NSV+wVBDhIWGJtOFkmDoGe24Qnp
 QdqVuqPy2EsMpi7AeWC2xtSs9PSLgsqpWySzuOQPoPrnEZR3M91Du38bk5Gd706UUbDT
 vHkQ==
X-Gm-Message-State: APuU4Z9/X4YreTlt2U3zcqSotWO7hDlQt72kR/1z97EOFJ21GjMf0ddR
 8oIgtwuByv84X6fumhwj7Rg6G4oUd2QJmLnnpmfcOKRWECUbRm9nb19J
X-Gm-Gg: AYBFou16d57Qku/cGAcDewcdaFwr6G7C7bmERp5fpijZ/TF8UG9q/YNK4XUkB59w7Mh
 h9IVZoGkyNiQ2f2QVS4qZW2vwl8pakGn6S3Fl5lODiLwQEgdA79QBx7Vf/kNrhHpr1LFU0hwPAV
 YANlUe/zD9CUi69b8Fhz+5O0ZqYjk5viSJTsq8mfLsmSYAMgSID8nSLxmTUrp/yYKITPI+abuZu
 dtJv7u8n/qaDyLe3TMVOlECAv8t8BpCc9O2Q1GGdsfNd8rtR0PgOjEMZS6wMzLiLuVmESlcoP76
 J8bMVU8xUEe3N0JOuTw4eqvj97Ka6C6M9M7by5t7UPDWv2ZVDbUGAdGDcldD+vEnmkb3mJB3+Y0
 BL9OkfyoHWWqGICrrHYsPJ48OSi5jdjRkjFwmxywv6cfu/EXFWRHQCrchel3WJAgdfv93TP5VmN
 MtQ8ai3vPb26Ue9umRpPvnkeV8emmIGcntynLM0UI0qm1ywR4FJ6PEloq9jllJ5WxxCqAOczs7t
 ZwXx43oZqBBq6KoRyBmKD7iwXZ+gDkkJh58CVqBZXfXpHJI1QxcGCoOeeahs8Pz6kicbS4RXUs8
 9x1Vb5ftczep5JcPKRtBSkCCxgYscodoVxQkNHEiQcC7Pk6Az4sFWpw=
X-Received: by 2002:a05:7301:18ac:b0:36c:a084:30a4 with SMTP id
 5a478bee46e88-36f75b1f65dmr2455761eec.21.1793949451683; 
 Thu, 05 Nov 2026 23:17:31 -0800 (PST)
Received: from pop-os.lan ([2409:4090:1015:ce03:1984:1655:89e8:63d2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36faa4b7404sm3569864eec.24.2026.11.05.23.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:17:30 -0800 (PST)
From: saad <primecoder8@gmail.com>
Date: Fri, 06 Nov 2026 12:47:25 +0530
Subject: [PATCH v2] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAR/7WoC/4WNQQ6CMBBFr0Jm7RimAoor72FYFDqFSSwlLRAN4
 e5WLuDyveS/v0HkIBzhnm0QeJUofkygThl0gx57RjGJQeWqIspL1M7004JmcS06PaG3NvKMldU
 F8c1cbFtCGk+BrbyP8LNJPEicffgcPyv97N/kSkh4VXVt6oINEz16p+V17ryDZt/3L5G7E9K8A
 AAA
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, saad <primecoder8@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793949447; l=5657;
 i=primecoder8@gmail.com; s=20261105; h=from:subject:message-id;
 bh=dr8+/Sh4e/4pnQunAQ4Dj++/sRRoqxW/WWM80cur6MU=;
 b=TedmxAlnlxjfdYO/u+QTmaiR83q5DTtntTAUn114+cmoB2aARCreQ6QbwbreQHpu+/BHKg47M
 gVbE/KB/AEOBDy2m2D6u0TJARJv09JvdJ7Jl2quDy2hWdUk3t/HfuuQ
X-Developer-Key: i=primecoder8@gmail.com; a=ed25519;
 pk=vJlTVYISGHXXppWzVCeFm0dcME82FTjmVlWBQkyLiKg=
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:26:02 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As part of the DRM TODO item "Remove custom dumb_map_offset
implementations", switch amdgpu's &drm_driver.dumb_map_offset callback
from the driver-specific amdgpu_mode_dumb_mmap() to the generic TTM
helper drm_gem_ttm_dumb_map_offset(), for both amdgpu_kms_driver and
amdgpu_partition_driver.

amdgpu_mode_dumb_mmap() additionally rejected userptr BOs and BOs
created with AMDGPU_GEM_CREATE_NO_CPU_ACCESS with -EPERM. Dropping
those checks from the dumb path does not allow such BOs to be mapped:
returning an offset does not create a mapping, and the actual mmap()
goes through drm_gem_mmap() -> amdgpu_gem_object_mmap(), which performs
the same two checks and still returns -EPERM. The only user-visible
difference is that DRM_IOCTL_MODE_MAP_DUMB on such a handle now succeeds
and the subsequent mmap() fails, instead of the ioctl failing. Dumb
buffers created by amdgpu_mode_dumb_create() are never userptr BOs and
always have AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED set, so they are not
affected.

With that, amdgpu_gem_mmap_ioctl() is the only remaining user of
amdgpu_mode_dumb_mmap(), so fold it into the ioctl and drop its
prototype from amdgpu_gem.h. DRM_IOCTL_AMDGPU_GEM_MMAP, used by
libdrm_amdgpu and Mesa, keeps the userptr and NO_CPU_ACCESS checks
and behaves as before.

Build-tested with CONFIG_DRM_AMDGPU=m (W=1 for amdgpu_drv.o and
amdgpu_gem.o), no new warnings. Not runtime tested.

The code change was written by hand and reviewed with the help of
Claude (AI coding assistant); the commit message was written by Claude.

Signed-off-by: saad <primecoder8@gmail.com>
---
Changes in v2:
- Fold amdgpu_mode_dumb_mmap() into amdgpu_gem_mmap_ioctl() and drop its
  prototype, as it has no other users (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  3 ---
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 731fe8f9e..134d2fe4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -27,6 +27,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_pciids.h>
 #include <drm/drm_probe_helper.h>
@@ -3151,7 +3152,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
@@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4ed1706d8..2a72bdf2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -644,13 +644,16 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-int amdgpu_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p)
+int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
+			  struct drm_file *filp)
 {
+	union drm_amdgpu_gem_mmap *args = data;
+	uint32_t handle = args->in.handle;
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *robj;
 
+	memset(args, 0, sizeof(*args));
+
 	gobj = drm_gem_object_lookup(filp, handle);
 	if (!gobj)
 		return -ENOENT;
@@ -661,19 +664,11 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
 		drm_gem_object_put(gobj);
 		return -EPERM;
 	}
-	*offset_p = amdgpu_bo_mmap_offset(robj);
-	drm_gem_object_put(gobj);
-	return 0;
-}
 
-int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
-			  struct drm_file *filp)
-{
-	union drm_amdgpu_gem_mmap *args = data;
-	uint32_t handle = args->in.handle;
+	args->out.addr_ptr = amdgpu_bo_mmap_offset(robj);
+	drm_gem_object_put(gobj);
 
-	memset(args, 0, sizeof(*args));
-	return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_ptr);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b558336bc..718ffe229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -49,9 +49,6 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
-int amdgpu_mode_dumb_mmap(struct drm_file *filp,
-			  struct drm_device *dev,
-			  uint32_t handle, uint64_t *offset_p);
 
 int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp);

---
base-commit: 279235273fc6c0a33df863b4a1cc52ec1e73aba5
change-id: 20261105-amdgpu-dumb-map-offset-6fa41e8d3fb5

Best regards,
-- 
saad <primecoder8@gmail.com>

