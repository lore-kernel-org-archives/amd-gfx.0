Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBA3E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84DB10E32C;
	Mon, 13 Jan 2025 01:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MTXt3Pg4";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14AB210E32C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732543; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=eQONSrRmu5iaQM0a1vQyreeInqCNvLmJTx9vmddoQXE=;
 b=MTXt3Pg4OCIboscFabVRtaQunK0FrjSr94kK4bejs5UXTflQyxOtEqwN8h+2TJfcosLLBghzG7ZMHnqw4GMz7V3awE/shmZ/3TDkByONrfJYgCrOvHiEVSKDlaDY/yZoK/UFz0Ld0uivW9sbZME//g0Teb35C/i0R2vRBQmznpo=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NDe_1736732542 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:23 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 00/15] Enhance device state machine to better support
 suspend/resume
Date: Mon, 13 Jan 2025 09:42:05 +0800
Message-ID: <cover.1736732062.git.gerry@linux.alibaba.com>
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

Recently we were testing suspend/resume functionality with AMD GPUs,
we have encountered several resource tracking related bugs, such as
double buffer free, use after free and unbalanced irq reference count.

We have tried to solve these issues case by case, but found that may
not be the right way. Especially about the unbalanced irq reference
count, there will be new issues appear once we fixed the current known
issues. After analyzing related source code, we found that there may be
some fundamental implementation flaws behind these resource tracking
issues.

The amdgpu driver has two major state machines to driver the device
management flow, one is for ip blocks, the other is for ras blocks.
The hook points defined in struct amd_ip_funcs for device setup/teardown
are symmetric, but the implementation is asymmetric, sometime even
ambiguous. The most obvious two issues we noticed are:
1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
   are called from .hw_fini() instead of .early_fini().
2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
   match the way to set those flags.

When taking device suspend/resume into account, in addition to device
probe/remove, things get much more complex. Some issues arise because
many suspend/resume implementations directly reuse .hw_init/.hw_fini/
.late_init hook points.

So we try to fix those issues by two enhancements/refinements to current
device management state machines.

The first change is to make the ip block state machine and associated
status flags work in stack-like way as below:
Callbacks                    State after successfully execute callback
                             AMDGPU_IP_STATE_INVALID
.early_init()                AMDGPU_IP_STATE_EARLY
.sw_init()                   AMDGPU_IP_STATE_SW
.hw_init()                   AMDGPU_IP_STATE_HW
.late_init()                 AMDGPU_IP_STATE_LATE
.early_fini()                AMDGPU_IP_STATE_HW
.hw_fini()                   AMDGPU_IP_STATE_SW
.sw_fini()                   AMDGPU_IP_STATE_EARLY
.late_fini()                 AMDGPU_IP_STATE_INVALID

Also do the same thing for ras block state machine, though it's much
more simpler.

The second change is fine tune the overall device management work
flow as below:
1. amdgpu_driver_load_kms()
	amdgpu_device_init()
		amdgpu_device_ip_early_init()
			ip_blocks[i].early_init()
			ip_blocks[i].status.valid = true
		amdgpu_device_ip_init()
			amdgpu_ras_init()
			ip_blocks[i].sw_init()
			ip_blocks[i].status.sw = true
			ip_blocks[i].hw_init()
			ip_blocks[i].status.hw = true
		amdgpu_device_ip_late_init()
			ip_blocks[i].late_init()
			ip_blocks[i].status.late_initialized = true
			amdgpu_ras_late_init()
				ras_blocks[i].ras_late_init()
					amdgpu_ras_feature_enable_on_boot()

2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
	amdgpu_device_suspend()
		amdgpu_ras_early_fini()
			ras_blocks[i].ras_early_fini()
				amdgpu_ras_feature_disable()
		amdgpu_ras_suspend()
			amdgpu_ras_disable_all_features()
+++		ip_blocks[i].early_fini()
+++		ip_blocks[i].status.late_initialized = false
		ip_blocks[i].suspend()

3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
	amdgpu_device_resume()
		amdgpu_device_ip_resume()
			ip_blocks[i].resume()
		amdgpu_device_ip_late_init()
			ip_blocks[i].late_init()
			ip_blocks[i].status.late_initialized = true
			amdgpu_ras_late_init()
				ras_blocks[i].ras_late_init()
					amdgpu_ras_feature_enable_on_boot()
		amdgpu_ras_resume()
			amdgpu_ras_enable_all_features()

4. amdgpu_driver_unload_kms()
	amdgpu_device_fini_hw()
		amdgpu_ras_early_fini()
			ras_blocks[i].ras_early_fini()
+++		ip_blocks[i].early_fini()
+++		ip_blocks[i].status.late_initialized = false
		ip_blocks[i].hw_fini()
		ip_blocks[i].status.hw = false

5. amdgpu_driver_release_kms()
	amdgpu_device_fini_sw()
		amdgpu_device_ip_fini()
			ip_blocks[i].sw_fini()
			ip_blocks[i].status.sw = false
---			ip_blocks[i].status.valid = false
+++			amdgpu_ras_fini()
			ip_blocks[i].late_fini()
+++			ip_blocks[i].status.valid = false
---			ip_blocks[i].status.late_initialized = false
---			amdgpu_ras_fini()

The main changes include:
1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
   Currently there's only one ip block which provides `early_fini`
   callback. We have add a check of `in_s3` to keep current behavior in
   function amdgpu_dm_early_fini(). So there should be no functional
   changes.
2) set ip_blocks[i].status.late_initialized to false after calling
   callback `early_fini`. We have auditted all usages of the
   late_initialized flag and no functional changes found.
3) only set ip_blocks[i].status.valid = false after calling the
   `late_fini` callback.
4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.

Then we try to refine each subsystem, such as nbio, asic etc, to follow
the new design. Currently we have only taken the nbio and asic as
examples to show the proposed changes. Once we have confirmed that's
the right way to go, we will handle the lefting subsystems.

This is in early stage and requesting for comments, any comments and
suggestions are welcomed!


v2:
- remove patch 1 in v1, it already got merged
- convert status bool flags for ip block into enum
- introduce iterators to walk ip blocks
- refine the way to define status markers
- split amdgpu_dm related change into a dedicated patch
- add patch 13 to walk ip blocks in reverse order when shutdown

Jiang Liu (15):
  drm/amdgpu: add helper functions to track status for ras manager
  drm/amdgpu: add a flag to track ras debugfs creation status
  drm/amdgpu: free all resources on error recovery path of
    amdgpu_ras_init()
  drm/amdgpu: introduce a flag to track refcount held for features
  drm/amdgpu: enhance amdgpu_ras_block_late_fini()
  drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
  drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
  drm/amdgpu: make IP block state machine works in stack like way
  drm/amdgpu_dm: enhance amdgpu_dm_early_fini() for PM ops
  drm/admgpu: make device state machine work in stack like way
  drm/amdgpu: convert ip block bool flags into an enum
  drm/amdgpu: introduce IP block iterators to reduce duplicated code
  drm/amdgpu: walk IP blocks in reverse order when shutdown
  drm/amdgpu/nbio: improve the way to manage irq reference count
  drm/amdgpu/asic: make ip block operations symmetric by .early_fini()

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 109 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 504 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 142 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  50 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  51 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  22 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +-
 32 files changed, 668 insertions(+), 460 deletions(-)

-- 
2.43.5

