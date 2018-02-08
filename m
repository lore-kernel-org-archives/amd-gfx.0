From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/amdgpu: add new device to use atpx quirk
Date: Thu,  8 Feb 2018 17:46:01 +0800
Message-ID: <20180208094601.26215-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: amd-gfx.lists.freedesktop.org

The affected system (0x0813) is pretty similar to another one (0x0812),
it also needs to use ATPX power control.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index e2c3c5ec42d1..c53095b3b0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -568,6 +568,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
 	/* HG _PR3 doesn't seem to work on this A+A weston board */
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.15.1
