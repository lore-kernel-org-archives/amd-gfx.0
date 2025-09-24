Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2491CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8340610E7E9;
	Wed, 24 Sep 2025 20:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jziuuazt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D51D10E7E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 20:52:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 23A874400C;
 Wed, 24 Sep 2025 20:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BDAC4CEF8;
 Wed, 24 Sep 2025 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758747139;
 bh=hY8KOOIdcLFeStFpDPUnr30X+UWyB7hNIoqZgjHszoQ=;
 h=From:To:Cc:Subject:Date:From;
 b=jziuuaztodkxEWwbzJvPzU9L1hkTITklU3j8ZBab0HOFzgjHNqcDS74Mxshzgz6ov
 VX2RTUDI3IczqfPVzyf8sx6sbM2z2Sk4qw2dujH0P/MsG9YDb3tNy+E7ska97rorYU
 Cyxt+ylCZfy6uqDPaF4C3alA1Nlm+e69cMTBagzOwv6Zj2mr90Xe5pLSea6c4O2WMj
 J5qAG+t6DONqsAoBawpVB/mWuKt7xgyJ6UelzSxQmrOiU77bn55c0mgipcYImggawR
 wSD6dO9486KTMQ2SNL07Kw845SHsgUeeERbLZyemCeziISSfd2shuTRjjF9Z35Rrik
 FPas4J9tTeZ8A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), Mario Limonciello <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 0/3] Fixes for hybrid sleep
Date: Wed, 24 Sep 2025 15:52:08 -0500
Message-ID: <20250924205211.1059571-1-superm1@kernel.org>
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
or drm.  I would suggest linux-pm with an Ack from Alex on the 3rd
patch.

Cc: Ionut Nechita <ionut_n2001@yahoo.com>
Mario Limonciello (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.51.0

