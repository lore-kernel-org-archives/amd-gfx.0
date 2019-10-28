From: Wambui Karuga <wambui.karugax@gmail.com>
Subject: [Outreachy][PATCH 1/2] drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
Date: Mon, 28 Oct 2019 12:20:04 +0300
Message-ID: <20191028092005.31121-2-wambui.karugax@gmail.com>
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Declare `amdgpu_exp_hw_support` as extern in amdgpu.h to address the
following sparse warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:118:5: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
Suggested-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4d9041ef430..3610defdfae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -140,6 +140,7 @@ extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
 extern int amdgpu_vm_debug;
 extern int amdgpu_vm_update_mode;
+extern int amdgpu_exp_hw_support;
 extern int amdgpu_dc;
 extern int amdgpu_sched_jobs;
 extern int amdgpu_sched_hw_submission;
-- 
2.17.1
