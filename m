Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D80CE77199
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 16:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FD110E750;
	Thu,  2 Jan 2025 16:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T+bQPkjP";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 02 Jan 2025 05:42:16 UTC
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3268310E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 05:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735796534; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=qw6U61fhzfsYl/KEI9vDBbeRo6AHJNgbwn2mvdvL8w0=;
 b=T+bQPkjPRbpVYgQprgrCw78FP1kKD4S8sA/F5aIvgqPRLZw9zHppYBzbBtgNrRkyfjQOQKSbrsJWfzVQaBm42r9PmIVYGOCAkHDjMxtDpYpHe4haO51YY4DHRZNMVgkaH1Z0isIJzuYe93ZRhpSqvsbMwDDaqji7KahwgxRHmDw=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMk35nX_1735796228 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 02 Jan 2025 13:37:08 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 0/6] Fix several bugs in error handling during device
Date: Thu,  2 Jan 2025 13:36:51 +0800
Message-ID: <cover.1735795671.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jan 2025 16:24:05 +0000
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

This patchset tries to fix several memory leakages/invalid memory
accesses on error handling path during GPU driver loading/unloading.
They applies to:
https://github.com/ROCm/ROCK-Kernel-Driver/tree/master/drivers

Jiang Liu (6):
  amdgpu: add flags to track sysfs initialization status
  amdgpu: fix invalid memory access in kfd_cleanup_nodes()
  amdgpu: clear adev->in_suspend flag when fails to suspend
  amdgpu: fix use after free bug related to amdgpu_driver_release_kms()
  amdgpu: fix invalid memory access in amdgpu_fence_driver_sw_fini()
  amdgpu: get rid of false warnings caused by amdgpu_irq_put()

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  9 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    |  7 +++-
 drivers/gpu/drm/scheduler/sched_main.c     |  3 ++
 8 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.43.5

