From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: amdgpu: Possible sleep-in-atomic-context bugs in
 amdgpu_uvd_ring_begin_use()
Date: Sat, 15 Sep 2018 16:59:04 +0800
Message-ID: <f09853dc-591c-05d3-9f56-63e4b338c585@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/vi.c, 207:
     amdgpu_mm_wreg in vi_gc_cac_rreg
drivers/gpu/drm/amd/amdgpu/vi.c, 206:
     _raw_spin_lock_irqsave in vi_gc_cac_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 106:
     amdgpu_mm_wreg in soc15_pcie_rreg
drivers/gpu/drm/amd/amdgpu/soc15.c, 105:
     _raw_spin_lock_irqsave in soc15_pcie_rreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 139:
     amdgpu_mm_wreg in cik_uvd_ctx_wreg
drivers/gpu/drm/amd/amdgpu/cik.c, 138:
     _raw_spin_lock_irqsave in cik_uvd_ctx_wreg

[FUNC] mutex_lock_nested
drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
     mutex_lock_nested in amdgpu_dpm_enable_uvd
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
     amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
     [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
     amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
     amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 126:
     amdgpu_mm_wreg in dce_v6_0_audio_endpt_rreg
drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 125:
     _raw_spin_lock_irqsave in dce_v6_0_audio_endpt_rreg

Note that [FUNC_PTR] means a function pointer call is used.

These bugs are found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai
