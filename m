Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB3C98307
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8548A10EF79;
	Wed, 23 Sep 2026 12:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDY7gIdA";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1CF10EF79
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:03:59 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a9edfc851so116246166b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790165038; x=1790769838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cFTD4ET/YtyMwDlZLEwkx1lViE4+fAtw3hvllrIbwI4=;
 b=SDY7gIdATnipUtPwsYPgTYFjnqj5fauB3UzyUW8byx0v2+KbgpAHFU8R5Tzyg0MWz4
 V/o6ClmQfxqiAgRc98YusEqjsab0a0/Gp9kXG6JcYzjh2HisBLGEsYHnbrSJcTsvKHsL
 o99VFzozhWHe6VPA4Bqfm/6iY9C3rESsOWBTrWQmaLlJWfdTl62/RV1dAhOtD4H2lRqV
 qWsZ5tesZ3w5LNMEWPDEFpiaLgi2HiTYtvNgn3bFXo5IEAG230lkEd0FUsbrXZ5Mu2Gr
 p9Bt5Q14pkzNF0TKr4T/9pf9jL95JvMrsPNQ6Y/SlErhVXf0pyFtR/ML+gVTtzwyf567
 Ey6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165038; x=1790769838;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cFTD4ET/YtyMwDlZLEwkx1lViE4+fAtw3hvllrIbwI4=;
 b=NIgD5Ab0/rv9uIqXVOUHDrsieozSPr9T6kTxeTIF93jq7xTfWekNfaNBc+H9BP/6Pc
 pBuRhERqO+4DYieW1IXQWagwfGhyev+lBgyK8v1MJaWQL9FLatATl2P7YD7P58/zPBoj
 gDXDNjqF3/DPQOCZP0RwnuKzHrwGx47BbWkg+6ZFVS762nQJakN0bjjMOXXsuZOB8m7b
 ZAGOOjUW9D3GB6TCd9dB8Jk95HD6rauUcbZUU+JieWgVa4yzQsjPT4KiMvHTlwMzvoCa
 4ZlAACkxdPPKgdgXzrjUfYus7uS6OD2Wr1YX5qbIXJUatt/EjESQI9PlrWhp6YD98ZqR
 oFEQ==
X-Gm-Message-State: AFuF++kfVbK4ajPE8E7CLnDLsiSKmrTlsr2xJUCG3HyvM9bi51jpz9/a
 OoC8QDeTZvXcO1qleTPZVXgb7IfReSQBde4YAs8ys1X+L28BqY3WAgs4fwDQ+A==
X-Gm-Gg: AYBFou2kvr/vSnFxI0+Ut1KuI4g0/CsYPVy5z/m4S2XoHYrmISNB/Fr7POmIpApC5vG
 26DuJCYq9vKmdqXUqx1QVjSMyvqkYbN6y+AMBJMqmG3O5QLPK/TLKws/QD5D+MbhdIb9yhbyG/y
 FNkvMhtjdiCLpK5HsOvasDoAE8A7yvWwGKHcPxB2bddc1BxFRDzT8YGlJaC8uXltzyVT0pjVjFL
 VA+0uwDoFE5xCPE03YjSxH2Y3s/JUIbqkEaEu6AP3f65jEBmNUdcqd/FGENb2jaXV51+oDdGOMq
 sLlPbvsB2gvWlVrT0mtY1NPBtaMAiNtA3PXQz+XTCXDzfctqCg+jTTNnSXSqOcte3EfanNNz7Qq
 uomAaJM0nga2JGK4rpNU82bfDtkv6bQlcpur1fydW/7kwbYwdFPHRIxQH0wdGnIl4R31LudH/Ql
 eFfG3KjzrJzYf+cP6LtQxsrG/5m3VnociBy0SpdwrmyasE5qF8psmIwkPLe/tFeCMNHIpQrrxG2
 ArskYivKv0jaYJnAUvF2/zIeqzaNhNAqUuXbXC1BjLWTaWNbDgc9FI/
X-Received: by 2002:a17:907:94d0:b0:c29:2646:fc3c with SMTP id
 a640c23a62f3a-c2aadd41a8fmr217162166b.15.1790165037652; 
 Wed, 23 Sep 2026 05:03:57 -0700 (PDT)
Received: from Timur-Hyperion (86FF5B49.dsl.pool.telekom.hu. [134.255.91.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae658569sm107210366b.37.2026.09.23.05.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:03:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/2] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
Date: Wed, 23 Sep 2026 14:03:53 +0200
Message-ID: <20260923120354.1027996-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Unfortunately, some desktop boards eg. the FirePro D500
have the HARDWAREDC platform flag set and also have
a battery power state configured in their VBIOS.
This makes no sense for a desktop GPU and results in
incorrect behaviour: the clocks are stuck at lowest.

We observed that the kernel driver can work around
the issue in two possible ways:
1. Set PPSMC_SWSTATE_FLAG_DC on all power states
2. Clear PPSMC_SYSTEMFLAG_GPIO_DC

We think that the PPSMC_SYSTEMFLAG_GPIO_DC flag
makes the SMC assume it's running on battery even
though this is a desktop machine with no battery,
and that's why it doesn't do DPM on power states
without PPSMC_SYSTEMFLAG_GPIO_DC.

Issue was uncovered by "Fix updating clock limits from
power states" because previously the limits for the
battery state were not tracked separately. However,
battery power state has lower frequencies and voltages,
so the kernel doesn't set the DC flag on the current
power state anymore. That causes the SMC to be stuck
on the lowest clocks.

Let's clear PPSMC_SYSTEMFLAG_GPIO_DC on desktop GPUs.
We can use the AMD_IS_MOBILITY flag to determine that.

Fixes: e6c5d36756e7 ("drm/amd/pm/si: Fix updating clock limits from power states")
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16352
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 6cc414a8a4de..d090dcada1b4 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5263,7 +5263,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
+	if ((adev->flags & AMD_IS_MOBILITY) &&
+	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
 		table->systemFlags |= PPSMC_SYSTEMFLAG_GPIO_DC;
 
 	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_REGULATOR_HOT) {
-- 
2.55.0

