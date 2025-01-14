Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C04AE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 09:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF1110E028;
	Tue, 14 Jan 2025 09:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dEjVb7Zj";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184E510E00A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736848505; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=qDlZUf4WgpyFKjBDvwnKoTsqCutpwLpK/EEU8tfDHuQ=;
 b=dEjVb7ZjqdIKn4MzTuVw8TpCip/ypTmzSoYsUnOKDT6dU5UUlTKwTNVKo7v7uYpdl8egENZlLc8GqQLuDmyHZhHC96GrVb30gJtaV6m4R5UsHYvJZfn8aDJImSACoVj7Sfnlhq7hPmYkppptadwNHaCaa7HhXkI3NZZNioz5u98=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNerZyJ_1736848503 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 14 Jan 2025 17:55:04 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
Date: Tue, 14 Jan 2025 17:54:56 +0800
Message-ID: <cover.1736847835.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For virtual machines with AMD SR-IOV vGPUs, following work flow may be
used to support virtual machine hibernation(suspend):
1) suspends a virtual machine with AMD vGPU A.
2) hypervisor dumps guest RAM content to a disk image.
3) hypervisor loads the guest system image from disk.
4) resumes the guest OS with a different AMD vGPU B.

The step 4 above is special because we are resuming with a different
AMD vGPU device and the amdgpu driver may observe changed device
properties. To support above work flow, we need to fix those changed
device properties cached by the amdgpu drivers.

With information from the amdgpu driver source code (haven't read
corresponding hardware specs yet), we have identified following changed
device properties:
1) PCI MMIO address. This can be fixed by hypervisor.
2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
   they are information only.
3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
4) mc_fb_offset, which affects VRAM physical address.

We will focus on the VRAM address related changes here, because it's
sensitive to the GPU functionalities. The original data sources include
.get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
The main data cached by amdgpu driver are adev->gmc.vram_start and
adev->vm_manager.vram_base_offset. And the major consumers of the
cached information are ip_block.hw_init() and GMU page table builder.

After code analysis, we found that most consumers of dev->gmc.vram_start
and adev->vm_manager.vram_base_offset directly read value from these
two variables on demand instead of caching them. So if we fix these
two cached fields on resume, everything should work as expected.

But there's an exception, and an very import exception, that callers
of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
VRAM addresses. With further analysis, the callers of these interface
have three different patterns:
1) This pattern is safe.
   - call amdgpu_bo_create_reserved() in ip_block.hw_init()
   - call amdgpu_bo_free_kernel() in ip_block.suspend()
   - call amdgpu_bo_create_reserved() in ip_block.resume()
2) This pattern works with current implementaiton of amdgpu_bo_create_reserved()
   but bo.pin_count gets incorrect.
   - call amdgpu_bo_create_reserved() in ip_block.hw_init()
   - call amdgpu_bo_create_reserved() in ip_block.resume()
3) This pattern needs to be enhanced.
   - call amdgpu_bo_create_reserved() in ip_block.sw_init()

So my question is which pattern should we use here? Personally I prefer
pattern 2 with enhancement to fix the bo.pin_count.

Currently there're still bugs in SRIOV suspend/resume, so we can't test
our hypothesis. And we are not sure whether there are still other
blocking to enable resume with different AMD SR-IOV vGPUs.

Help is needed to identify more task items to enable resume with
different AMD SR-IOV vGPUs:)

Jiang Liu (2):
  drm/amdgpu: update cached vram base addresses on resume
  drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
 7 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.43.5

