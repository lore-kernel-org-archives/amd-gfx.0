Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874AC44501
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 17:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6118C10E49F;
	Sun, 12 Jul 2026 17:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLuG6BS9";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C19C10E4D0
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 17:39:35 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so21252805e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783877974; x=1784482774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xQ5W++sq8bCfygaIie+JPOQCwpk29GcFVWbobJGMvZ8=;
 b=cLuG6BS9/f8P8s3KaGRUhALRs6bhTGOxqH3oVz3xm3aaAeDMb1sv0iQC1fqpAPwGZo
 8Is/Lruh7mkw/UZ7/ezeaWgiJB4Xqjd/MuLZNy6CaahGKp8Wt0AmW43wpnCXgN/5PmaD
 0CeDtqwCALZWXFbCMOjoWMDF0baBinpCWGGAIgI3GHqGA6oMOmGtiGsBCmgMZzygjznJ
 BfdqBFobpS9UXlPn0AAkOsgrRMvcxs6arcuE9IidcdynGs1nqZ2u8zN95aNFRnS6UY15
 hl0x2Ox4RHFP/E8OpNE3/iAyykNVm7Q1tu//zgjcUbQ8pZXYXzShLiVs/jws+L9j2P2Y
 69EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783877974; x=1784482774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xQ5W++sq8bCfygaIie+JPOQCwpk29GcFVWbobJGMvZ8=;
 b=W7Ect1pFuE7FBZAteTBe95AjGxvxQT1bIe77z9wka4uumBGkyfeKqU2SZaWdRoVlbE
 WFkcaWZyLw5O1yzCMYHgImOIYB3t21P/TZPHVy6GevevUx3P7fNN8vevN6xgS22NS6wS
 i9xM06P1KI1IuXqhZWESAWZIJgrQ/sdCsCyVapu3LUhEQyKHSHe+l8RvPLR7Y/PW4sbl
 PaYuphkfBr68IwumDU+ZsI+qx5r5bnFwUGjYLRKQRuguIUcZG5oShH/A82k+8hnuoXC9
 50mGiyglQprvo8ngD4vvT+Avk5GVgiOPxEffQELx5AccYnBXpetEwNK4s5T40pWMXIPX
 Dgpg==
X-Gm-Message-State: AOJu0YzqJheZdKxNT1pH7ZzniuraLxIu/7dKpols9kH7SVCNsoUBwAbM
 zXO9MANgLEhX975MrJ1nYy14jT8Xe3RjaMhHGpRAGzfwAcDBwKdPk+ebfz2FWA==
X-Gm-Gg: AfdE7cm3V5ah3t/kDB/hEWoc+b9DYlxosothgcTxMWVfzSxLHaAQHxMj2x+xImPJK09
 dx8CFK3pfrmczIE8TKxe3+5ys71WnJXW42hPwXtuKIySjEk/rX/gcy1zBOyN8aEXHO1/agXG2pu
 saRfGJTHJJwdtfK4dJgHxfpS14DukZ2KupS/cjDDQmdvoxVD3FQYD2K5TkfoAhG0mvYl5/m2Go3
 uvx5tx0H/LRIJPTbPCjSB6CjGTP9Jyu5bPIYXmpuUDMBDEWHyBpckEj6yKcqSHfQiKwYkaiIWS8
 LyvwAK5zNeMT2gC32U0ExLT48+eB4E73gfsJoGP8MDHDeIjzLY75kVQMuMcwokIL8EhVzecag1T
 xeAjJlC5tJiyFMw+8Cng1z5XSg+bJqWW8Mnw/GEU3UracQqCdVAB6o9zGqAa4WXIyfGWA2IdVDH
 AFeNsAFtCumbk1a87WpjpPYLskEuoMGxnDgTbYm3/CdpNvDSIIO6WfNAgVptlg5cHjnD2PMvGsL
 RBRJhRtacE=
X-Received: by 2002:a05:600c:4895:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-493f87eb2bfmr37445965e9.14.1783877973763; 
 Sun, 12 Jul 2026 10:39:33 -0700 (PDT)
Received: from Timur-Max.home
 (20014C4E24E4950000951480CE1AD54B.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:9500:95:1480:ce1a:d54b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493fbae1cdbsm119128965e9.10.2026.07.12.10.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 10:39:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Subject: [PATCH 2/3] drm/amd/pm/si: Fix AC/DC switch notification
Date: Sun, 12 Jul 2026 19:39:27 +0200
Message-ID: <20260712173928.259701-2-timur.kristof@gmail.com>
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

The check for ATOM_PP_PLATFORM_CAP_HARDWAREDC should be
inverted. We recently learned that the kernel should send
PPSMC_MSG_RunningOnAC when the flag is set, and not the
other way around.

The clocks also need to be recomputed, because the code in
the si_apply_state_adjust_rules() function selects different
limits on AC and DC.

Fixes: 2d071f6457af ("drm/amd/pm/si: Notify the SMC when switching to AC")
Tested-by: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 6a54566d1a68..a0c28de691f8 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3892,13 +3892,16 @@ static void si_notify_hw_of_powersource(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	/* Check if the platform already manages the AC/DC switch via dedicated GPIO. */
-	if (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC)
-		return;
-
-	/* The SMU automatically notices DC, but needs to be notified when switching to AC. */
-	if (adev->pm.ac_power)
+	/*
+	 * Check if the platform already manages the AC/DC switch via dedicated GPIO.
+	 * Otherwise SMU automatically notices DC, but needs to be notified of AC.
+	 */
+	if (adev->pm.ac_power &&
+	    (adev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_HARDWAREDC))
 		amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_RunningOnAC);
+
+	/* Recompute clocks with updated max_limits. */
+	amdgpu_legacy_dpm_compute_clocks(adev);
 }
 
 static PPSMC_Result si_send_msg_to_smc_with_parameter(struct amdgpu_device *adev,
-- 
2.54.0

