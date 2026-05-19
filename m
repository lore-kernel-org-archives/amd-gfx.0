Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ABFCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AF810EB68;
	Tue, 19 May 2026 08:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FKmy1tRv";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9374D10EB14
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:06 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso20132675e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180125; x=1779784925; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHLk0edh/Ay9/heyZKDPmNy6X7yR0fUCIgeiLMGJb0w=;
 b=FKmy1tRv4jcSUzh6L+QVVPkqi4RSifFarxpnpe01Mn4/xOI9p0p7it0dWKAeiSCzFc
 CWHCusvllG5PBv07tpve+ZCWLQunr1zwvPLVt1dXdDRtzEcBbEzFviI7pFjPBXoEtavz
 XzcdGrh8ldf5SBCe3HqQ20VWr5YO1SqR1sy168337tMUB1X/7YCoYicM2FpSo7h2AnKB
 gCGaSe/fFYnDrANPPk8YiRFDoYBceiWA4yVFlEOHYSvQleP4094X5u5WvKwDgJQ58yQy
 cTtIjgXTm7he7iC9scO0sDYOzKUcaPtaNCPhOEh6jOX8ES/5Fg89duvHp4pjEhspvUaM
 Fyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180125; x=1779784925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CHLk0edh/Ay9/heyZKDPmNy6X7yR0fUCIgeiLMGJb0w=;
 b=VxLgmRzvxq5CX0H3fNY/Z9nbC1l6aLgT0UHmSqEUwO1AfOd6l3igUoOAnwTEROyru3
 wJC3LOyxtp7t3DuHJUUzc7SVgXkjnSmMChh5WQWGtYGP0AjRUntDsTgkIW2twDj5FMhl
 +P5wSzkD5h55+eWneVX72l7zg0HyJQP2K3kO64uf+v0/367RGzdLPwbPvB5n4xQsuCzh
 mYWYJHoH+FZA4CHdxMoiTO5ax89QXIfanOQ80Ozr0R7O50BS1OAFoVVIUCohK3byPuCi
 AVuVsYokdnnYgeTLzrOxBepDdpGDNjC/wNr4fVyEeJrWGii8O/2tkhnDLNlcPlY40kI5
 PNRQ==
X-Gm-Message-State: AOJu0YzLF+fmaBUsHMoO+/LA+WkH73kmdm7H9x2PHnhUG5kbX+0O/YUE
 Cv5jIMRPGvjzsC/rMQln1qT5yEPhadEFIkV/egc9D1dCNemS2tKgs9b0Yxn06g==
X-Gm-Gg: Acq92OFTBT9fRwGLxqaIiW5wLnqsRU0TT/PXNXGMT8ELiu5iD7qFP8NZWFVdAPJBQgV
 lqtow0OrPaD+yB4w0ysVyvDe089e+sSgk/12dUsGKnsc2AVXCMPp3gbBe4t1GtuS+9AI2iXl+8j
 zDIdMSaCvD/w5Oeq9k1Q0F11n1XEcrfjoCDAlk6bHibMkvNVHW85HT7RMuJj7QyKfyYyS0yCOGI
 liVQUiPxcWK1WI3ED5mdjOtbuFVruu8nyyDNIf4Dx50aKshBU9ZCmnj66c07BPm7o+E7Q65mOoH
 xmIZbxuiTkeAAWeCQF2R3OFuFs6iLjye7tU+7/frrL+zJmbPzDudpOV12Tr9MRlhP/i8uYZPLVj
 7fM+LbGwixY40+1sOYfzRjoIuAtdK6+NI+0ZE/3J4BmO5m0x6OvyXNlV9U/bd2CocJxY12sKJVi
 OJXIH6NfrkcCLP0SZl3RUVlHydJctijkhawJ6/k7vbnmyzo8Fx8qMsHP9sNKeq3Rk/NB/SKAPB5
 90=
X-Received: by 2002:a05:600c:8901:b0:48e:526e:1040 with SMTP id
 5b1f17b1804b1-48fe63021f9mr268636465e9.23.1779180125040; 
 Tue, 19 May 2026 01:42:05 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm141935945e9.0.2026.05.19.01.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:42:04 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/pm/si: Fix updating clock limits from power states
Date: Tue, 19 May 2026 10:41:57 +0200
Message-ID: <20260519084158.72960-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519084158.72960-1-timur.kristof@gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
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

From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>

VBIOS can contain conflicting values between:
- the maximum allowed clocks and voltages on AC or DC
- the clocks and voltages in power states on AC or DC

Update maximum clock (and voltage) limits for both AC/DC
and take the highest value from the VBIOS limits and
the performance/battery power states. Previously this
was only done for AC, but is also needed for DC.

This commit fixes the behaviour on some laptop GPUs,
where the VBIOS limit was set to the lowest possible
clock frequency, so the GPU was stuck on the lowest
possible power level on battery.

Some affected GPUs are:
FirePro W4170M (Dell Precision M2800)
Radeon HD 8790M (Dell Latitude E6540)
and possibly other laptop GPUs.

Co-developed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 5afe42918497..04f3ba5f8f46 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7240,6 +7240,7 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct  si_ps *ps = si_get_ps(rps);
+	struct amdgpu_clock_and_voltage_limits *limits;
 	u16 leakage_voltage;
 	struct rv7xx_pl *pl = &ps->performance_levels[index];
 	int ret;
@@ -7299,12 +7300,30 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 		si_pi->mvdd_bootup_value = mvdd;
 	}
 
+	/*
+	 * Update maximum allowed clock limits.
+	 * VBIOS can contain conflicting values between:
+	 * - the maximum allowed clocks and voltages on AC or DC
+	 * - the clocks and voltages in power states on AC or DC
+	 */
 	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
-	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk = pl->sclk;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.mclk = pl->mclk;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddc = pl->vddc;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddci = pl->vddci;
+	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
+		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
+	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
+		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
+		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
+	else
+		limits = NULL;
+
+	if (limits) {
+		if (pl->sclk > limits->sclk)
+			limits->sclk = pl->sclk;
+		if (pl->mclk > limits->mclk)
+			limits->mclk = pl->mclk;
+		if (pl->vddc > limits->vddc)
+			limits->vddc = pl->vddc;
+		if (pl->vddci > limits->vddci)
+			limits->vddci = pl->vddci;
 	}
 }
 
-- 
2.54.0

