Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A251BCAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDE410E9A9;
	Thu, 25 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XzgFWPZm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D74610E9BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:51:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC628611FD;
 Thu, 25 Sep 2025 18:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E615C113CF;
 Thu, 25 Sep 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758826277;
 bh=0HDVqTQaim5C4kfGq9KY4W5ZIXHRhxYWm2ylHFBOdqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XzgFWPZmCgJEJEz7LUV6eeWebhDeF3Iuc/ciGokXiAIecx1PvZ2F+77NfGDgE4m51
 qcQLXPOjA7vL5eWratiVfMH2ktTq/rpS1vEKVzOLijXIO9oiumPnsL3BGQEDBo5q86
 Z40cqvLeYI8B2t1mOucVQ2J+Ldc7X/2l1PyzKJVtoO06UoCF6w3b7cbWc3lJoreknQ
 rRiL0/sLwRFJhD+GPFc7AKbOw6mOgrs8AgsJgEcHUOkn8cSumnXEXbHqA1twJ2ppHp
 bKubCzAop81ujVh1nIIPif10Ny4/WkIQVxUdzGSWGnHtrT2wZBilf/whgdAqP2PkHN
 ZNBqmJs+dIdiw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>, Kenneth Crudup <kenny@panix.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 1/3] PM: hibernate: Fix hybrid-sleep
Date: Thu, 25 Sep 2025 13:51:06 -0500
Message-ID: <20250925185108.2968494-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925185108.2968494-1-superm1@kernel.org>
References: <20250925185108.2968494-1-superm1@kernel.org>
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

Hybrid sleep will hibernate the system followed by running through
the suspend routine.  Since both the hibernate and the suspend routine
will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
before starting the suspend sequence.

Add an explicit call to pm_restore_gfp_mask() to power_down() before
the suspend sequence starts. Add an extra call for pm_restrict_gfp_mask()
when exiting suspend so that the pm_restore_gfp_mask() call in hibernate()
is balanced.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequence")
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/hibernate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab453823..3c6b110ee9b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -695,12 +695,15 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
 						HIBERNATION_PLATFORM :
 						HIBERNATION_SHUTDOWN;
 		} else {
+			pm_restrict_gfp_mask();
+
 			/* Restore swap signature. */
 			error = swsusp_unmark();
 			if (error)
-- 
2.51.0

