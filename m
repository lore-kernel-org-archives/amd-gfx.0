From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu/mes10.1: Fix header guard
Date: Wed,  3 Jul 2019 22:52:12 -0700
Message-ID: <20190704055217.45860-2-natechancellor@gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

clang warns:

 In file included from drivers/gpu/drm/amd/amdgpu/nv.c:53:
 drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:24:9: warning:
 '__MES_V10_1_H__' is used as a header guard here, followed by #define of
 a different macro [-Wheader-guard]
 #ifndef __MES_V10_1_H__
         ^~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:25:9: note:
 '__MES_v10_1_H__' is defined here; did you mean '__MES_V10_1_H__'?
 #define __MES_v10_1_H__
         ^~~~~~~~~~~~~~~
         __MES_V10_1_H__
 1 warning generated.

Capitalize the V.

Fixes: 886f82aa7a1d ("drm/amdgpu/mes10.1: add ip block mes10.1 (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/582
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
index 17b9b53fa892..9afd6ddb01e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
@@ -22,7 +22,7 @@
  */
 
 #ifndef __MES_V10_1_H__
-#define __MES_v10_1_H__
+#define __MES_V10_1_H__
 
 extern const struct amdgpu_ip_block_version mes_v10_1_ip_block;
 
-- 
2.22.0
