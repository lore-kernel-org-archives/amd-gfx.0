Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51129C98309
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C358B10F00F;
	Wed, 23 Sep 2026 12:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXfG90HF";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B1810F00F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:04:00 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c293c683202so122003866b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790165039; x=1790769839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=umdpyzJHv0azgYb8oWdtgKowUVC/7OEHQcqT6d3f9KU=;
 b=FXfG90HF1hC4uWwkan7JPFROVoh78N68ejbVFOpX/P2IXYFP3Xx81sD7BFaXNRynEA
 0bRduKw4Tgeb/Pz2V+bAIlJuZNf+LT7xp07UYL9zuUPuB4xQWkpqWgdcdIdVstIqPYaL
 7uXgP0eXL/0pmKyJ6YMbvasCFpCwAYJxNTq6ffDEbLjkGJX5ghdDwIpAp5sOLr5JKwPj
 L2xUGXifDMtBD0T43hIglwoSPFMz3XaWIBiu6ZVvTpXMiNYVyDnXiNvL0ZcX6apmyNA4
 4Lxn2wJHSr0Ij8DDmooodzpBfaI0RUCHU69IcmfCaM6r4Vc0nq+8o0/vY6nTRXiamTdG
 y/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165039; x=1790769839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=umdpyzJHv0azgYb8oWdtgKowUVC/7OEHQcqT6d3f9KU=;
 b=uI5gyGUVtCn4jbe/TQb6LRoHDtfySv9RLHOIQRCrSC2wLWJsD7mO4Kke/1WarKS3Qq
 oYNxyGndJ0roiTg5ltF+kN3XWD93MgLxBPrXZF5RnencH9m6PJqb/A3nKCpJPXKye3Rq
 qzVwAMCkg6+JURNS9PIOs7FSsgaFP+TenVb4NPirWh0Vpd1GDTTRI0ZAyipG3ZP+Gdhj
 mP+s4aAJ29l3tTWUDlVsADI/xXrFxCMj4LLIdo3hk2gEhHXc1R6CMgtgIbvLiA1wTMo6
 PwXICm+JMUYMycNtCNsaDHKaU0f4vkPrxQadz4EZtSY61HkSaDOpUN3OQoDBm/ziUwOQ
 /0NQ==
X-Gm-Message-State: AFuF++kz2STa3c6EOw2bTYWhrYlG6vmw9xa06x9eBQfH/Jnl95NyTCT0
 SXMQdyDT8j4b/ysmHmJLT8afbE6CA3kpRkPglbanJsJSEUkD7nphsdO2jJnNIg==
X-Gm-Gg: AYBFou0jhFe5tnRg242SOByKcprnfVPlmz10XUsCdnod03QTkTNLKCxp30DKrD03t1O
 vfJ7+LY6JvV4FzQKz9zLRm4UYmIsZD5VGCRh3vx2rekPbo/cljRkRpA5ZNgwrVcChDcYD87Ohor
 T4s03qVOjevVcWXRkGyhqhqbN9Tq+aDXbz+8Hg1jdHlvwaMfKC8OfP5OYWwfwrcuUs1nggnp6QG
 CyU7FpHpyjGlpCIYQ5Lo+We+fZ5uVDzlvrscfB/6MkjSuJ8PM0AkHDwO6gsDUvvZ5N810VYQVXs
 QbX0gJo8jLRn1IfDxhWVIIZc4DG0D3Tz1YQ/Kw/npsaD92Hjq/Z2bPA5cx98W9SZBhyVwoW4Jk+
 hWcET/Ccv36dXcXxw3q/s2Shsof7rDr5MfiEc7zPJSE5icsWow+NfbkCSipUgu2NnaekEIPuG5g
 nvhnSnL5Rcnt5anF1vml7K2pu+UFdI620UY63nny5tZUf42TlY3hfLLW5dN5wqZ/cLGYFOjyeR2
 B/8oWkZva3TrlSwWwEy03wttgw5ik+PAoC0rZVWD4/jG9M=
X-Received: by 2002:a17:907:9689:b0:c29:5712:a420 with SMTP id
 a640c23a62f3a-c2aadcf014fmr202291766b.5.1790165038742; 
 Wed, 23 Sep 2026 05:03:58 -0700 (PDT)
Received: from Timur-Hyperion (86FF5B49.dsl.pool.telekom.hu. [134.255.91.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae658569sm107210366b.37.2026.09.23.05.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:03:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amd/pm/si: Fix updating clock limits on AC/DC
Date: Wed, 23 Sep 2026 14:03:54 +0200
Message-ID: <20260923120354.1027996-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923120354.1027996-1-timur.kristof@gmail.com>
References: <20260923120354.1027996-1-timur.kristof@gmail.com>
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

Assume that the AC limits are the maximum of all power states,
and the DC limits are the maximum of battery power states.
This shouldn't make any difference in practice, but is
cleaner and more robust against bogus information in the VBIOS.

Fixes: e6c5d36756e7 ("drm/amd/pm/si: Fix updating clock limits from power states")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index d090dcada1b4..f186aae9984d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7238,6 +7238,19 @@ static void si_parse_pplib_non_clock_info(struct amdgpu_device *adev,
 		adev->pm.dpm.uvd_ps = rps;
 }
 
+static void si_update_limits(struct amdgpu_clock_and_voltage_limits *limits,
+			     struct rv7xx_pl *pl)
+{
+	if (pl->sclk > limits->sclk)
+		limits->sclk = pl->sclk;
+	if (pl->mclk > limits->mclk)
+		limits->mclk = pl->mclk;
+	if (pl->vddc > limits->vddc)
+		limits->vddc = pl->vddc;
+	if (pl->vddci > limits->vddci)
+		limits->vddci = pl->vddci;
+}
+
 static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 				      struct amdgpu_ps *rps, int index,
 				      union pplib_clock_info *clock_info)
@@ -7246,7 +7259,6 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct  si_ps *ps = si_get_ps(rps);
-	struct amdgpu_clock_and_voltage_limits *limits;
 	u16 leakage_voltage;
 	struct rv7xx_pl *pl = &ps->performance_levels[index];
 	int ret;
@@ -7311,26 +7323,14 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	 * VBIOS can contain conflicting values between:
 	 * - the maximum allowed clocks and voltages on AC or DC
 	 * - the clocks and voltages in power states on AC or DC
+	 *
+	 * Assume that the AC limits are the maximum of all power states,
+	 * and the DC limits are the maximum of battery power states.
 	 */
+	si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_ac, pl);
 	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
-	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
-		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
-	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
 		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
-		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
-	else
-		limits = NULL;
-
-	if (limits) {
-		if (pl->sclk > limits->sclk)
-			limits->sclk = pl->sclk;
-		if (pl->mclk > limits->mclk)
-			limits->mclk = pl->mclk;
-		if (pl->vddc > limits->vddc)
-			limits->vddc = pl->vddc;
-		if (pl->vddci > limits->vddci)
-			limits->vddci = pl->vddci;
-	}
+		si_update_limits(&adev->pm.dpm.dyn_state.max_clock_voltage_on_dc, pl);
 }
 
 union pplib_power_state {
-- 
2.55.0

