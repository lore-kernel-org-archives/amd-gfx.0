Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8FECA0FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8709C10EA23;
	Thu, 28 Aug 2025 15:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JB+NfOcU";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC8D10EA1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so6617985e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393883; x=1756998683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6Hsh/FIJ/nn1TxvDUsCcf7pWg9Y7hVjMQb7MQr91HA=;
 b=JB+NfOcU9DEaagRTbpRPqhrOvcNoqVdAAttsiu3XmiZin01V/cjAlxjL1TWLQ/WhVW
 ncOTKHLXrO9p3jU+Ha+f4gsdNaQtqHsxLjkhUwIg7gPoWI1pZZxvyASUe9zHqRPrTFYN
 2dzvv5ELARJc4ap859FFIevigTqaJdiNMuyYGZz0K4QrTw0zXPhVwYsvrE7fu8QBT/gc
 XuT7oHP4z+Mi+WseV08EbHDQQfkrHQ432r2f39/e+Z3pe8oPfDbcwXgM4vboiuKbl0tZ
 qUN+gIiw6bOpkfuj1qDxsIyOrG3sEZwm+XkfkPSeNo+EcCJ3aRCnx2UJJQ1ZEzbSsPyN
 yFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393883; x=1756998683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6Hsh/FIJ/nn1TxvDUsCcf7pWg9Y7hVjMQb7MQr91HA=;
 b=wkq0YNEMBLPqU+3HE4fj5bAcXh0/3AWEYWNaU5/1Q7mUibCLj7r5kEb3RNP8bVooNF
 VtlKtwGYP0e/cs9E4hyevdQhstceLpzqmphPpMikf6npV47i1V2SGMiset5CJIjL5oYN
 MWHL/tatMaBax2DviX+zKlh6J+uQDv/4aBjsdkV/aLBfLpO2tyzdaNIxolgNSiZf4ofW
 NHE6nMIyKjXT/m20mdJmUyA4jmmqvY+bItIsqVKr6H3LcuwS5xp0wQopQAM1mnGe47g/
 +nVtkZ0JZLofnHKXmNJm98CzKlDD4EAgvNzfEakuUY8jAVLTO/f7gNUof4PUz4yEVgJU
 tqtw==
X-Gm-Message-State: AOJu0YyNucmxVh/QXkIqZ+EcxxMtaFVv0voaIx9jkl6zXUeDm4B1PPrZ
 Otpc0mCISA2+z8JeedTDAjFmwlg9lgNHX6s1V+spl8XnW96Sv+31trWLykKdXw==
X-Gm-Gg: ASbGnctXraF/zPdMuazh1nsQas85PQzfRGBwgVLFQfsv4i9JKheyjWmbPi+kYXrRFYn
 YKJV1+IGvTu0vVZ94JQZRGyN9i/Y+h1f2sZL8dXhC8UD32hmuj+9CnM0GiCQz8LAhrYvkasON8W
 A3FB1NeTfXj/AaRVx1ktK7Im5HigDsCoYLfWTdQ22ZtFufI1ZWADoorZXj2g5yRKcdDjG3R0DB8
 hYBdY2LFlDdO921RiIQwYii9dbuGqCc14XGn+dd80/w8tVN9CsO1Uus45UqNI9Uui/EIH6uVpGV
 KDNQQafHDACvBDrKfb23IFtbRrDbcD/HtrBDLVlPffoFr8TapZggfRHk7SmIGsIiBuszHIEsJ7/
 X31MXCaM+1sD1p2neIWfss2eLCmRnu70QoUTMUqDw/0DHZx2bB7MSIYw77opIAMDYV4M3SXlk3s
 xMWk3pWQfcuqH2sgzixW970A7HljCZ+7HmiHsII9AbtegAvxk=
X-Google-Smtp-Source: AGHT+IFFdDVhTaCbDiRxK0pYTfL7RzDHRT4gdaG6n3Hxv6cE84wvC7I56pE0Y6bqBxRLFD/LhPyq9Q==
X-Received: by 2002:a05:600c:4447:b0:456:27a4:50ad with SMTP id
 5b1f17b1804b1-45b517ea940mr217134195e9.33.1756393882266; 
 Thu, 28 Aug 2025 08:11:22 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/10] drm/amd/pm: Disable SCLK switching on Oland with high
 pixel clocks (v3)
Date: Thu, 28 Aug 2025 17:11:10 +0200
Message-ID: <20250828151112.15965-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

Port of commit 227545b9a08c ("drm/radeon/dpm: Disable sclk
switching on Oland when two 4K 60Hz monitors are connected")

This is an ad-hoc DPM fix, necessary because we don't have
proper bandwidth calculation for DCE 6.

We define "high pixelclock" for SI as higher than necessary
for 4K 30Hz. For example, 4K 60Hz and 1080p 144Hz fall into
this category.

When two high pixel clock displays are connected to Oland,
additionally disable shader clock switching, which results in
a higher voltage, thereby addressing some visible flickering.

v2:
Add more comments.
v3:
Split into two commits for easier review.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index c11c4cc111df..4236700fc1ad 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3449,12 +3449,14 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 {
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
+	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
 	u16 vddc, vddci, min_vce_voltage = 0;
 	u32 max_sclk_vddc, max_mclk_vddci, max_mclk_vddc;
 	u32 max_sclk = 0, max_mclk = 0;
+	u32 high_pixelclock_count = 0;
 	int i;
 
 	if (adev->asic_type == CHIP_HAINAN) {
@@ -3482,6 +3484,35 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		}
 	}
 
+	/* We define "high pixelclock" for SI as higher than necessary for 4K 30Hz.
+	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
+	 * Find number of such displays connected.
+	 */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
+			!adev->mode_info.crtcs[i]->enabled)
+			continue;
+
+		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
+
+		if (conn->pixelclock_for_modeset > 297000)
+			high_pixelclock_count++;
+	}
+
+	/* These are some ad-hoc fixes to some issues observed with SI GPUs.
+	 * They are necessary because we don't have something like dce_calcs
+	 * for these GPUs to calculate bandwidth requirements.
+	 */
+	if (high_pixelclock_count) {
+		/* On Oland, we observe some flickering when two 4K 60Hz
+		 * displays are connected, possibly because voltage is too low.
+		 * Raise the voltage by requiring a higher SCLK.
+		 * (Voltage cannot be adjusted independently without also SCLK.)
+		 */
+		if (high_pixelclock_count > 1 && adev->asic_type == CHIP_OLAND)
+			disable_sclk_switching = true;
+	}
+
 	if (rps->vce_active) {
 		rps->evclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].evclk;
 		rps->ecclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].ecclk;
-- 
2.51.0

