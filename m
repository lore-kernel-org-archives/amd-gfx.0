From: madhuparnabhowmik04@gmail.com
Subject: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h: Fixed a documentation warning
Date: Mon, 28 Oct 2019 11:34:43 +0530
Message-ID: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following  warning: Incorrect use of
 kernel-doc format:          * @atomic_obj
by adding a colon after @atomic_obj.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c8c525a2b505..80d53d095773 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -128,7 +128,7 @@ struct amdgpu_display_manager {
 	u16 display_indexes_num;
 
 	/**
-	 * @atomic_obj
+	 * @atomic_obj:
 	 *
 	 * In combination with &dm_atomic_state it helps manage
 	 * global atomic state that doesn't map cleanly into existing
-- 
2.17.1
