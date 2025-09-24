Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A45CAC5B5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 20:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891D910E7EB;
	Wed, 24 Sep 2025 20:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rDLltrMr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5E510E7E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 419FC6029D;
 Wed, 24 Sep 2025 20:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4059DC116B1;
 Wed, 24 Sep 2025 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758747140;
 bh=EWCxrLxglxq/G+xYlkXSA22/IJeat/PFPXgrltaJZqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rDLltrMrPnCeJYUgfOgpgN4QcGaKFS6WjMLSItmd+UEx2aKpS9hknhTblxpIxkofo
 DrCTdMKPwADzzHB+cHTOJ2QUg+JuG9HRxzCI+15qJNkl5q0/HrfFU9fWk0OF4U+D4D
 LS80qWoJ0RdAr87goB+Q/D1J0xsPb9lkCEHxP6zet0iGtAdBMX6AqBFFd4YPJIM16H
 Hiy1R5vWR7z2u6a1xC/XjmBrDYrDtfL/YD9rXNyB84xusJkZsDQWy+nTPqDz1xVVEi
 OWbKAdTB93swpAGXqYCckZYwrg6JdQRQkR9+kL7lMqQkF8l2KTl2OKYIuXfNX80GoD
 zwvIMWsaYCJRg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), Mario Limonciello <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 1/3] PM: hibernate: Fix hybrid-sleep
Date: Wed, 24 Sep 2025 15:52:09 -0500
Message-ID: <20250924205211.1059571-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
References: <20250924205211.1059571-1-superm1@kernel.org>
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
the suspend sequence starts. Don't call pm_restore_gfp_mask() when
exiting suspend sequence it is already called:

```
power_down()
->suspend_devices_and_enter()
-->dpm_resume_end()
```

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequence")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab453823..1defe8081e64 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -695,6 +695,7 @@ static void power_down(void)
 
 #ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
+		pm_restore_gfp_mask();
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
@@ -862,7 +863,8 @@ int hibernate(void)
 				power_down();
 		}
 		in_suspend = 0;
-		pm_restore_gfp_mask();
+		if (hibernation_mode != HIBERNATION_SUSPEND)
+			pm_restore_gfp_mask();
 	} else {
 		pm_pr_dbg("Hibernation image restored successfully.\n");
 	}
-- 
2.51.0

