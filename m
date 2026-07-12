Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA8C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 17:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811B010E49D;
	Sun, 12 Jul 2026 17:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H8D/Nsla";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACE210E49F
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 17:39:36 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so15569315e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783877975; x=1784482775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WOobe09MyrxwBug2a6cZBTDTEVHgzQPghee9LDuzqUc=;
 b=H8D/NslakbBlamn7Yy3bDhVgdz4w3wBJ5dU1VjgNOZz/a4lhJMrmbzKtvXCjtdnC2q
 nKXrhRgGR/zoqmMynyqdIwxrjqHp815HejxAgEnz9GkGW7kY4//PFvlp+R4/49YF207V
 FMX2slmz7XaOJ8JdcgE93V4EIQ3b0+b4HiOCRnSNytHC3I0E4av5faMiFOhrjVR7gr6K
 axxGuRuFsKfDrzjoLkIbloXir0gQ3EoiBzQ/fDvhAm3+bO4ppR9qKeOgIBZFAxlfvBdN
 DizYSeNhb3hmjEEGeYGABSPDcJto9OeaPc9D0G8trvOE5hmfATvfH4c2XwluQo+jF7oD
 herA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783877975; x=1784482775;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WOobe09MyrxwBug2a6cZBTDTEVHgzQPghee9LDuzqUc=;
 b=fzCRc/RqAxbTLqNGMhD3yxYdysyWKUc9mu3dsPklNDcrHFIJQcmwInBwe7YwRYy99Z
 Oct10cvZzPlUgizmChfFCEFvpw/TXuQCIfrSixS9kQygjvDsCOwraUkADECwvOns2IbM
 XVDbXSU4OluGGAj/mbqyI6w9Q/yUOQfeXCdQ4oFwnFak468fAsSKnp+7SfReGK7ukfqV
 5f3xTXL5KmJ/O2KNn5VFVSkhySZ2J5Ky0knOZM0KixiNZ051QhqGCnDbBq+/YW6JDmGH
 lUcN3LskZJq5qYMgkdYZCueEWgaylKSXhdJRv+7KZkJ4ZLtClTgZrbOObtWxp/LOV/vO
 6Vjw==
X-Gm-Message-State: AOJu0YwuU3o7X+oMekqJmEFRUDZnPGamVOA6Hw2dYvGjFUscwsyGr3E0
 NWcLDQ4oU6aDtEHPGPkmAeR7Fjfi2lYUYMebhNRphyexqlh5EtzFXQbYwb6lFQ==
X-Gm-Gg: AfdE7cnPohSWX+dAndlXWFxbKMjumTVKF7oUF5Og3K+xhF91pDZK+ZCnlABhk2PAVlW
 b7znHgd9wgvX0lVMUdBRfRchZvfDjJb8FU/4y6kNW5EIrLmvbyIQnumvEHk6EZnTcfP55WbITTf
 Xo/bEFWiyFX7yhgh8CoAUU0nLjDSs8J/gxU3vYD25X0pq3oh9WAA2XmNzAkSc898e8jRLGUKRX4
 +/ScQheWGX63r/+lbX3b1UBwVX8se5ouqtsV8HikoHmT70wbvvv+v+dEE32AL5r8v8wrsmJV19P
 hGr4ocXNmO4rkQUI9Dram/mO8by0BkB9qaBxxXW1X+tjHHbFce5rIWRu+LEKwEOzV8eb5tD/AY7
 58rUVmMI08i9J16CAaVm+YyTT49UP4Rt4kx0llzz/fOfTME77BBEwHvN2Gx8+4DAbAsC8bQU4QW
 r8ik2sFyUfH+9HKkQbc59jkdV5qU4uf65obeMaLtIwM52yK50fvxl9Ptj7fjLV+kLFajNgLkU1A
 uW+QlaUK64=
X-Received: by 2002:a05:600c:1386:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-493f87e5a46mr62020545e9.12.1783877975002; 
 Sun, 12 Jul 2026 10:39:35 -0700 (PDT)
Received: from Timur-Max.home
 (20014C4E24E4950000951480CE1AD54B.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:9500:95:1480:ce1a:d54b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493fbae1cdbsm119128965e9.10.2026.07.12.10.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 10:39:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/pm/smu7: Fix AC/DC switch notification
Date: Sun, 12 Jul 2026 19:39:28 +0200
Message-ID: <20260712173928.259701-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712173928.259701-1-timur.kristof@gmail.com>
References: <20260712173928.259701-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There were two mistakes in the previous implementation:

The check for AutomaticDCTransition should be inverted.
We recently learned that the kernel should send
PPSMC_MSG_RunningOnAC when the flag is set, and not the
other way around.

The clocks also need to be recomputed, because the code in
the smu7_apply_state_adjust_rules() function selects
different limits on AC and DC.

Fixes: 96da0d86614e ("drm/amd/pm/smu7: Notify SMU7 of DC->AC switch")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index be824e3d276b..17ac4c0eb8e2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5887,15 +5887,19 @@ static int smu7_power_off_asic(struct pp_hwmgr *hwmgr)
 static void smu7_notify_ac_dc(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	/* Check if the platform already manages the AC/DC switch via dedicated GPIO. */
-	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
+	/*
+	 * Check if the platform already manages the AC/DC switch via dedicated GPIO.
+	 * Otherwise SMU automatically notices DC, but needs to be notified of AC.
+	 */
+	if (adev->pm.ac_power &&
+	    phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 			    PHM_PlatformCaps_AutomaticDCTransition))
-		return;
-
-	/* The SMU automatically notices DC, but needs to be notified when switching to AC. */
-	if (adev->pm.ac_power)
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunningOnAC, NULL);
+
+	/* Recompute clocks with updated max_limits. */
+	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
 }
 
 static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
-- 
2.54.0

