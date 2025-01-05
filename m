Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1114E77198
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2025 16:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AE610E0EF;
	Sun,  5 Jan 2025 16:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nr1wzQ1l";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFB510E4CA
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 02:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736045138; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=EVL2kvUij9EsCRcziFKIxYk6qMRDFdWP5zGkJtoHIrc=;
 b=Nr1wzQ1ltpi7gWL6ZIwgnXpLRa6InQlRFv8eqnE6BJfT0dqHu2EFuzFKgGN/T7vFa+X7RrZadJZfDJVo7vvn1pxV3PAI1Ag5rI0HUP5nOb0gF8Z0Nh9Yk/Fx80qGJkeS/hEcmYKljsT6jXPltMpDBSqd5LhtqzdwHBsUdo0tvoc=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMx9YB._1736045137 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 05 Jan 2025 10:45:38 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com, lijo.lazar@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v2 0/6] Fix several bugs in error handling during device probe
Date: Sun,  5 Jan 2025 10:45:28 +0800
Message-ID: <cover.1736044362.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jan 2025 16:40:26 +0000
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
https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next

v2:
1) rebased to https://gitlab.freedesktop.org/agd5f/linux.git branch
   amd-staging-drm-next.
2) removed the first patch, which is unnecessary.
3) add amdgpu_xcp_drm_dev_free() in patch 0003 to enhance amdxcp
   driver to better support device remove and error handling.
4) reworked patch 0005 to fix it in amdgpu instead of drm core.

Jiang Liu (6):
  amdgpu: fix invalid memory access in kfd_cleanup_nodes()
  amdgpu: clear adev->in_suspend flag when fails to suspend
  drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
  amdgpu: fix use after free bug related to amdgpu_driver_release_kms()
  amdgpu: fix invalid memory access in amdgpu_fence_driver_sw_fini()
  amdgpu: get rid of false warnings caused by amdgpu_irq_put()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 14 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  9 +--
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 70 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 9 files changed, 99 insertions(+), 25 deletions(-)

-- 
2.43.5

