From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] amdgpu: make pmu support optional
Date: Mon,  8 Jul 2019 16:41:43 +0200
Message-ID: <20190708144205.2770771-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Kim <Jonathan.Kim@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Emily Deng <Emily.Deng@amd.com>, xinhui pan <xinhui.pan@amd.com>, Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

When CONFIG_PERF_EVENTS is disabled, we cannot compile the pmu
portion of the amdgpu driver:

drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:48:38: error: no member named 'hw' in 'struct perf_event'
        struct hw_perf_event *hwc = &event->hw;
                                     ~~~~~  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:51:13: error: no member named 'attr' in 'struct perf_event'
        if (event->attr.type != event->pmu->type)
            ~~~~~  ^
...

Use conditional compilation for this file.

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3a15a46b4ecb..3f5329906fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,9 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o amdgpu_atomfirmware.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
-	amdgpu_vm_sdma.o amdgpu_pmu.o amdgpu_discovery.o
+	amdgpu_vm_sdma.o amdgpu_discovery.o
+
+amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
 # add asic specific block
 amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 30989b455047..a02ccce7bf53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2816,7 +2816,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_pmu_init(adev);
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		r = amdgpu_pmu_init(adev);
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
@@ -2888,7 +2889,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	amdgpu_debugfs_regs_cleanup(adev);
 	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	amdgpu_ucode_sysfs_fini(adev);
-	amdgpu_pmu_fini(adev);
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		amdgpu_pmu_fini(adev);
 	amdgpu_debugfs_preempt_cleanup(adev);
 	if (amdgpu_discovery)
 		amdgpu_discovery_fini(adev);
-- 
2.20.0
