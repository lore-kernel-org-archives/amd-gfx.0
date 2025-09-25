Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFA1CAC5B9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF3610E9B1;
	Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mZw654Q8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A0610E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:51:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A15EA60622;
 Thu, 25 Sep 2025 18:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE810C4CEF0;
 Thu, 25 Sep 2025 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758826276;
 bh=N9xmDtQS3dATzW1PaWQLaB6jOOpl3g+2kQS9I+rJQSw=;
 h=From:To:Cc:Subject:Date:From;
 b=mZw654Q8+XZdehU6FkONM7g+d+2uwy48gI33mkxrM98rY9GKVWrD9eEE/YjTf/cwJ
 smhRrxLTvg1SUBwMz70t67zej+P/heEJDFJk8WEUgOZKHWZRkd76PU77q2WwvANzwR
 mMjV77IeuGpFrThBqvh9BE481KMUKeBPYfpCy5K+x9b3lCPRmBFT8ySQcVwdpxuyXd
 Zw9QHiTsAQb0wKMLBTsRYk9qehDIZQ5mJeQP/FAKa+EK5URX70/83vFJ9MDmsNMO6F
 MMxnnnR9S7n2OvP7QspGFQEqpl+H1CBx6QOfi+1EJ579V3MFPK5U8zPxxhMW/3qE4t
 X6/HI0nsOxvFA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Fixes for hybrid sleep
Date: Thu, 25 Sep 2025 13:51:05 -0500
Message-ID: <20250925185108.2968494-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Ionut Nechita reported recently a hibernate failure, but in debugging
the issue it's actually not a hibernate failure; but a hybrid sleep
failure.

Multiple changes related to the change of when swap is disabled in
the suspend sequence contribute to the failure.  See the individual
patches for details.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

As it touches two subsystems it either needs to go through linux-pm
or drm.  Patch 3 has an Ack from Alex, this should merge through
linux-pm.
---
v3:
 * Push all calls for gfp mask changes into power_down()
Mario Limonciello (AMD) (3):
  PM: hibernate: Fix hybrid-sleep
  PM: hibernate: Add pm_hibernation_mode_is_suspend()
  drm/amd: Fix hybrid sleep

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
 include/linux/suspend.h                 |  2 ++
 kernel/power/hibernate.c                | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.51.0

