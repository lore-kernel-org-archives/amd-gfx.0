From: Wambui Karuga <wambui@karuga.xyz>
Subject: [PATCH] drm/amd/amdgpu: make undeclared variables static
Date: Sat, 19 Oct 2019 10:24:26 +0300
Message-ID: <20191019072426.20535-1-wambui@karuga.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Make the `amdgpu_lockup_timeout` and `amdgpu_exp_hw_support` variables
static to remove the following sparse warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:103:19: warning: symbol 'amdgpu_lockup_timeout' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:117:18: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?

Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3fae1007143e..c5b3c0c9193b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
 int amdgpu_hw_i2c = 0;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
-char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
@@ -114,7 +114,7 @@ int amdgpu_vm_block_size = -1;
 int amdgpu_vm_fault_stop = 0;
 int amdgpu_vm_debug = 0;
 int amdgpu_vm_update_mode = -1;
-int amdgpu_exp_hw_support = 0;
+static int amdgpu_exp_hw_support;
 int amdgpu_dc = -1;
 int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
-- 
2.23.0
