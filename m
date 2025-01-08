Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D376E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 08:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D10D10E814;
	Wed,  8 Jan 2025 08:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BeUpcAwV";
	dkim-atps=neutral
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9F010E810
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736326576; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=e5brxGJHob5dErTuetC8b59c64WfD6uqfAkhrBOc9TI=;
 b=BeUpcAwVr/nkx2Urg82IeH4/wQNkFUcuAawBKx0Gi/6wydf0nhGXUSQg/I1vvRMCLSoEvQhAjgm0gL6Q5hz/FmuCbliZ+sP/YHMOw6Hky6oqo2afipDZL7yhhebek9nSkkTD3qvDHykrOGg8+DRlvwco7Vg5lNTJVlGy29gkC4g=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNDU-vf_1736326574 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 16:56:14 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v3 0/6] Fix several bugs in error handling during device probe
Date: Wed,  8 Jan 2025 16:55:58 +0800
Message-ID: <cover.1736325561.git.gerry@linux.alibaba.com>
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

This patchset tries to fix several memory leakages/invalid memory
accesses on error handling path during GPU driver loading/unloading.
They applies to:
https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next

v3:
1) drop first patch of v2
2) rework the 0003/0004 patches of v2 according to review comments
3) add patch 0004 to fix possible resource leakage in amdgpu_pci_probe()

v2:
1) rebased to https://gitlab.freedesktop.org/agd5f/linux.git branch
   amd-staging-drm-next.
2) removed the first patch, which is unnecessary.
3) add amdgpu_xcp_drm_dev_free() in patch 0003 to enhance amdxcp
   driver to better support device remove and error handling.
4) reworked patch 0005 to fix it in amdgpu instead of drm core.

Jiang Liu (6):
  drm/amdgpu: clear adev->in_suspend flag when fails to suspend
  drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
  drm/amdgpu: fix use after free bug related to
    amdgpu_driver_release_kms()
  drm/amdgpu: enhance error handling in function amdgpu_pci_probe()
  drm/amdgpu: fix invalid memory access in amdgpu_fence_driver_sw_fini()
  drm/amdgpu: get rid of false warnings caused by amdgpu_irq_put()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 16 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 47 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  4 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 9 files changed, 140 insertions(+), 33 deletions(-)

-- 
2.43.5

