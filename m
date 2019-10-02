From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/6] drm/amdgpu: hide another #warning
Date: Wed,  2 Oct 2019 14:01:23 +0200
Message-ID: <20191002120136.1777161-3-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>, Huang Rui <ray.huang@amd.com>, Evan Quan <evan.quan@amd.com>, Prike Liang <Prike.Liang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

An earlier patch of mine disabled some #warning statements
that get in the way of build testing, but then another
instance was added around the same time.

Remove that as well.

Fixes: b5203d16aef4 ("drm/amd/amdgpu: hide #warning for missing DC config")
Fixes: e1c14c43395c ("drm/amdgpu: Enable DC on Renoir")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f70658a536a9..a337d980b434 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -771,8 +771,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC)
                 else if (amdgpu_device_has_dc_support(adev))
                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
-#else
-#       warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
 #endif
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		break;
-- 
2.20.0
