Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2A7CAC5B1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6FE10E2DD;
	Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pIh1lUsp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3BC10E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 15:59:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 659216110A;
 Thu, 25 Sep 2025 15:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F081C4CEF0;
 Thu, 25 Sep 2025 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758815965;
 bh=yhOhJkZZYMouooZCDf68+qrRmrCaon7hXJObEYatR+M=;
 h=From:To:Cc:Subject:Date:From;
 b=pIh1lUspaOok0glq7a3NwhZEtia7yCbFCSfMfqSf7M9225UNmhEdhJlSxmwxCsxv0
 LQ5xDsWs8Mp9cXzjKZnDUqMpYZYURZ5LwvqesXoNxZuuR8UURMM1bP9dawUn+gcPoR
 soLi5VEgSbel8LbTSs1Z9YD8LRdWJ5zgqyQopPA03FGuHaDdFa71ce3N314xnZGC0d
 Anmft5EYlvvgSr4kcPEg5jfcz2FGY/lJjUtGUpzJu688CRwjtuof76oAYcbmK4QnT1
 zdPSCSj5GPBiZ4xsczw9IALvSTGiBwrqNKFReqptnNH1tUeQDqARKrEPb3tdz4AhVe
 Dpq/engWHZglw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/3] Fixes for hybrid sleep
Date: Thu, 25 Sep 2025 10:59:15 -0500
Message-ID: <20250925155918.2725474-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Ionut Nechita reported recently a hibernate failure, but in debugging
the issue it's actually not a hibernate failure; but a hybrid sleep
failure.

Multiple changes related to the change of when swap is disabled in
the suspend sequence contribute to the failure.  See the individual
patches for details.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

NOTE: I realize this is super late in the cycle, so sorry about that,
but I debugged it as fast as I could as soon as I heard about it.
If it needs to push out to the next cycle it is what it is.

As it touches two subsystems it either needs to go through linux-pm
or drm.  Patch 3 has an Ack from Alex, this should merge through
linux-pm.

---
v2:
 * Fix LKP robot errors without CONFIG_SUSPEND
 * Add tags


Mario Limonciello (AMD) (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 22 +++++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.43.0

