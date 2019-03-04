From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/amdgpu: fix typing in amdgpu_virt_ops::trans_msg
Date: Mon,  4 Mar 2019 14:10:00 +0100
Message-ID: <20190304131000.17994-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Monk Liu <Monk.Liu@amd.com>, Emily Deng <Emily.Deng@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

The method in struct amdgpu_virt_ops::trans_msg() is defined as
using an 'u32' for its 2nd argument (the request) but the actual
implementation()s and calls use an 'enum idh_request' for it.

Fix this by using 'enum idh_request' for the method declaration too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 722deefc0a7e..3e9aec6f2795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -56,7 +56,7 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
-	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
+	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req, u32 data1, u32 data2, u32 data3);
 };
 
 /*
-- 
2.21.0
