Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FE7C0218C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 05:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A2510E8D0;
	Fri, 24 Jan 2025 05:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uTgCG4KJ";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7F910E253
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 05:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737695961; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=3ahRtewzenNBXikF3fQ+ahP0e8WetatDMTtQpfy+4CA=;
 b=uTgCG4KJ7O/mzwkqxZmpK6QBVutJLGN7EGyNKlcPAVN/9T96HIrGAtybJwkcAgmtPJYyNPdUGy/CowIblpv/HAuVHUTSuZQX2Be9TFntgEyn+zu1Fo+0GpHGms42L1bCjxgEq8rzOPdxMIszXWmyzI0ep7WsOB79kr9f3spiy0s=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WODTwiJ_1737695959 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jan 2025 13:19:20 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v6 0/5] Fix several bugs in error handling during device probe
Date: Fri, 24 Jan 2025 13:19:13 +0800
Message-ID: <cover.1737695869.git.gerry@linux.alibaba.com>
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

v6:
1) fix coding style of patch 5

v5:
1) drop first in v4, we have found a reliable way to fix the issue.
2) add patch 3 in v5 to fix a new issue
3) rework patch 5 according to review feedback

v4:
1) drop patch 1 in v3
2) split out amdxcp related change into a dedicated patch
3) use `guard(mutex)` instead of mutex_lock/unlock().
4) move patch 6 in v3 to next patch set

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

Jiang Liu (5):
  drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
  drm/amdgpu: fix use after free bug related to
    amdgpu_driver_release_kms()
  drm/amdgpu: fix invalid memory access in amdgpu_xcp_cfg_sysfs_fini()
  drm/amdgpu: enhance error handling in function amdgpu_pci_probe()
  drm/amdgpu: fix invalid memory access in amdgpu_fence_driver_sw_fini()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 33 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  9 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 71 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  3 +-
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 63 +++++++++++++++---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 7 files changed, 152 insertions(+), 42 deletions(-)

-- 
2.43.5

