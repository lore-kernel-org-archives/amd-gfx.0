Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771ADCAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA9F10E2D2;
	Thu, 25 Sep 2025 18:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jsubHOPr";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738CB10E2D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:54 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so1203923a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825954; x=1759430754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqhKQitx3suNajogTS41/OLcw2v5ZXyrHHWgG/Zex1o=;
 b=jsubHOPrwO/Kb7FCD6KQu5XTob/rPDUDo90c8kDMttKqyKsG+yiOsGVo5DuI7FfcAx
 FtxPFdL9+IZ8x0rrLIT67o/jq1LOIqScOEUwxDnDgJ2AUTwIp38dOxRR27wWLP7tB9If
 ta3dVUiOHFOTBVymx652anLD+mQchmQbEhxVTmeHHmJebUkeCl/EC1gBwp06lFDz4wfl
 +QlmGDUjBI8xNwdxyrpdTkZ5GRUDIpB8o2xe5hLz+zTS4ij1vs7kGqy6eZUEJKH0TfbN
 6TrRMst75A+DL4+L4P0gQ88z9MJu8Vc2ef+krqF3vVgCh4AKNoS+hYxLjMyesYhlnKd9
 FBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825954; x=1759430754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqhKQitx3suNajogTS41/OLcw2v5ZXyrHHWgG/Zex1o=;
 b=eOCoV2C5qPaYlAblToyES/ZYcU4Y1cTYfAjybn17whOVgTYCZ1cUTENLLk6YLcNZX7
 m2cBvI2+mzdV+ncQX332BKGf3d9AB0mZMegcT77Cy611XP42RXwOknkuwcdH4/jUG9Di
 ZQV/XkLhh/T0CbwVFQbBeII1azwJGJ1hZSwC/AqhahcpNswTIUv+gzkky5vJMYNlIEkY
 xWCFk1vg0jXBLz1nOalCEuHQm74/GvvZRNYmjeYdLD0p9FDoZJ1+6RPsOubrMc9GzjuR
 D5AUweh03dwCX8GXZ4zzm13e/r6lE1jxvn/NpI+yM22tWjsT7kMpeaEM1gFRYb5IUQ90
 dmag==
X-Gm-Message-State: AOJu0Yz3szOxB4ts4j0+qIZCTHImg4x/6Y6Uc5f4XODIJ39na4UkPKQR
 M+48VDJv5NMk4lfoN7XDEnq43utzAYKuHCAFJBC+ytyoPVaEFt70qNhpAhovlA==
X-Gm-Gg: ASbGncuyruUdkC589KjK8nTVQxnMB0CDmpq/unD4TBUGUArSDdcAX9T+I/HIWQt+bHK
 eNw7rPskuocsppHbU0EwPXx2hSZJpKnM/YBGtVo8KUfk7ft093RBzAeeiE3DV8eyy79PJMMoaSy
 HqUZlMAaKozFJ9Wl5y4UCLBeuMjK8m1qeComOZZMa1XuOz9wPq78Fn6KIvPRTent5Or6VMOMunA
 T/7aZbEX1f4cLTLEwAio+gaMvEcTH3iM9vq1rrmOIWIunMw72VF+PPQLW5ABXk+Ul12AXH8zL8N
 pXZgtMKZvUTN41Im348y+ZVpg8qrrcvapYxSE8Gs+bApc7jntqV4FzPaKBlvtSSX56pwTFpwV/K
 dTFxdyazPINxWWjWuyBWnOex8hh87Op/+Qftw5nQfEwQOO1cqTxmr73rwUNbzW2bDd2F+4kHZ06
 fbXJjM3jvBIeYCxSeJrATzQcfWHQ==
X-Google-Smtp-Source: AGHT+IFP1fk8Bmw1ombA/UKUtH9aZdRO6HkjoYzZHlPif1S4+WFl4GhGUzSAc3KwpBVdM16msfhY7w==
X-Received: by 2002:a17:902:76c8:b0:267:af07:6526 with SMTP id
 d9443c01a7336-27ed4a66f88mr36343765ad.55.1758825953943; 
 Thu, 25 Sep 2025 11:45:53 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/display: Properly disable scaling on DCE6
Date: Thu, 25 Sep 2025 20:45:24 +0200
Message-ID: <20250925184525.43290-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925184525.43290-1-timur.kristof@gmail.com>
References: <20250925184525.43290-1-timur.kristof@gmail.com>
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

SCL_SCALER_ENABLE can be used to enable/disable the scaler
on DCE6. Program it to 0 when scaling isn't used, 1 when used.
Additionally, clear some other registers when scaling is
disabled and program the SCL_UPDATE register as recommended.

This fixes visible glitches for users whose BIOS sets up a
mode with scaling at boot, which DC was unable to clean up.

Fixes: b70aaf5586f2 ("drm/amd/display: dce_transform: add DCE6 specific macros,functions")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_transform.c    | 15 +++++++++++----
 .../gpu/drm/amd/display/dc/dce/dce_transform.h    |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index e5c2fb134d14..1ab5ae9b5ea5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -154,10 +154,13 @@ static bool dce60_setup_scaling_configuration(
 	REG_SET(SCL_BYPASS_CONTROL, 0, SCL_BYPASS_MODE, 0);
 
 	if (data->taps.h_taps + data->taps.v_taps <= 2) {
-		/* Set bypass */
-
-		/* DCE6 has no SCL_MODE register, skip scale mode programming */
+		/* Disable scaler functionality */
+		REG_WRITE(SCL_SCALER_ENABLE, 0);
 
+		/* Clear registers that can cause glitches even when the scaler is off */
+		REG_WRITE(SCL_TAP_CONTROL, 0);
+		REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
+		REG_WRITE(SCL_F_SHARP_CONTROL, 0);
 		return false;
 	}
 
@@ -165,7 +168,7 @@ static bool dce60_setup_scaling_configuration(
 			SCL_H_NUM_OF_TAPS, data->taps.h_taps - 1,
 			SCL_V_NUM_OF_TAPS, data->taps.v_taps - 1);
 
-	/* DCE6 has no SCL_MODE register, skip scale mode programming */
+	REG_WRITE(SCL_SCALER_ENABLE, 1);
 
 	/* DCE6 has no SCL_BOUNDARY_MODE bit, skip replace out of bound pixels */
 
@@ -502,6 +505,8 @@ static void dce60_transform_set_scaler(
 	REG_SET(DC_LB_MEM_SIZE, 0,
 		DC_LB_MEM_SIZE, xfm_dce->lb_memory_size);
 
+	REG_WRITE(SCL_UPDATE, 0x00010000);
+
 	/* Clear SCL_F_SHARP_CONTROL value to 0 */
 	REG_WRITE(SCL_F_SHARP_CONTROL, 0);
 
@@ -564,6 +569,8 @@ static void dce60_transform_set_scaler(
 	/* DCE6 has no SCL_COEF_UPDATE_COMPLETE bit to flip to new coefficient memory */
 
 	/* DCE6 DATA_FORMAT register does not support ALPHA_EN */
+
+	REG_WRITE(SCL_UPDATE, 0);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index ff746fba850b..eb716e8337e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -155,6 +155,7 @@
 	SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
 	SRI(VIEWPORT_START, SCL, id), \
 	SRI(VIEWPORT_SIZE, SCL, id), \
+	SRI(SCL_SCALER_ENABLE, SCL, id), \
 	SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
 	SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
 	SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
@@ -592,6 +593,7 @@ struct dce_transform_registers {
 	uint32_t SCL_VERT_FILTER_SCALE_RATIO;
 	uint32_t SCL_HORZ_FILTER_INIT;
 #if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t SCL_SCALER_ENABLE;
 	uint32_t SCL_HORZ_FILTER_INIT_RGB_LUMA;
 	uint32_t SCL_HORZ_FILTER_INIT_CHROMA;
 #endif
-- 
2.51.0

