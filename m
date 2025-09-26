Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CBACAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6118010EABB;
	Fri, 26 Sep 2025 18:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0PCGOzi";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2714610EABB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso19639615ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909767; x=1759514567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/9Dt56ANeZehCIqBhPElqfiMsRWFlzDt8o7uMWcWk0=;
 b=M0PCGOzioikpV5R834yoI/HYGAUatwtYhX8dXBVY+SPr8yCqu4nGfbUp/+BqM4uqhA
 uVjHhPSKl9nDaOwzFAJNJEMWX4NdmCGu4c9CKrj5ZDZwVbLQS+8g5RFZMarlxyNLGdr9
 GoXreUQDZrPlND7kO6hyCSXyF92mul78UIgOpQUAD20xWvztcuQq7CKeBXyRQWfureS4
 sLoYdCquLJonCIrTPB5ELy+KUQcxYitxmtbC7pnsHDk5nZe2VILgA5NDyNViewmXQAzv
 48pvEnuJnVxIFUMzP7pOcvngPGi735F3Ku6ILSRUY6L5nF7edMkSRp2kOyq2TWzkIT4Q
 VP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909767; x=1759514567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/9Dt56ANeZehCIqBhPElqfiMsRWFlzDt8o7uMWcWk0=;
 b=pO0KzESbr4JJmr/C5tm0DbKTfGbtMqC8WHe4HE/G8/vwzacGKR+8VXujrkuAhCZC4w
 S44TNAGHcyAwY7i8mQmnFCbqsvgjCKQZyV8dzOt+d8ywGGzjWnrnS3EhbUsQIytXqn2d
 RFngGoBjK8hqmYKdEw7tUXNVB0SczurVArThsUERtPeoQRxiBVLh2lCgykzhGVcbqzRI
 3JOwOz6dxOh/DVCiti1lyrSj0BusWliiX83elbmOW4akO4yOERioZv8SPVD6ZGqgt6+F
 +8Lx7Q8k/VsCbkgWqIMJbBrYvlhcUnTL3igjPkuWwu2iduuBJUsiqnGN4369fGJ2MwIR
 D/Fg==
X-Gm-Message-State: AOJu0YzJ+sQf/+RAtY92m+KlcjM+5MG1LGul67XWd1bRfVew5OPwth/H
 cjY3BDOi0wss11X7FJF2HOJjCrmSrdbmS3MbqVuOikj7uy5S7X46KV9JySCF+Q==
X-Gm-Gg: ASbGncvzTdm7/IyLyEEVqrcAzOLwiDphj0Pk4tW5HzCQPV5XbFH3yzgWozEvtULkDh5
 LHD0vedG1QwY5m0F+WCzEC41V8rl2NhJwcH5UD9KjEzTe8lbbywiz7mhQQoSnjfHSeEH+2R/XpK
 JJbfmeD2e8XZyH5mvCcpbE2jPRcCaMXUj/jcFpY8DZK4xEKTfhfX8coHstqaMkLZJ1SGq6Z4v2R
 6TJCWmDU3XAOrbJvw3K7zIGsmGCE5sEP94ZbHAeTrMDzgjDIw+AlomWKb7Jjp4u+vhHjB6YCKj+
 JRjAqKLu6KzroNek5ZsK2RSn+xdJJdJH81plrSogyd/775EvJNAlT22xJ7cmOPR0wy6f//N0any
 kbKdp3s9D/I5u1cb45FUT7bnCJDYEokQ8D44/ztnkilSp80+hc2eFOLKVDcIJdAu6MykxdjlQBB
 IDijfHwJEBvN4cHUUE7T5ffaNY0Lmu4A==
X-Google-Smtp-Source: AGHT+IExnc1pCTcFQk74BpLTFaHC5JjFEU/OKmzSFPOr9XrzZHVZJ9yhQk2uslm87L9fhNbYVK67Ow==
X-Received: by 2002:a17:902:e84b:b0:267:bd66:14f3 with SMTP id
 d9443c01a7336-27ed4ad4194mr79708775ad.51.1758909766604; 
 Fri, 26 Sep 2025 11:02:46 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/23] drm/amd/display: Get maximum pixel clock from VBIOS
Date: Fri, 26 Sep 2025 20:01:46 +0200
Message-ID: <20250926180203.16690-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

We will use this for validating the pixel clock when
an analog monitor is connected to VGA or DVI-I connectors.

For reference, see the legacy display code:
amdgpu_connector_vga_mode_valid

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c           | 2 ++
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index c7875edea321..33d0ec38ded7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -441,6 +441,7 @@ static enum bp_result get_firmware_info_v1_4(
 		le32_to_cpu(firmware_info->ulMinPixelClockPLL_Output) * 10;
 	info->pll_info.max_output_pxl_clk_pll_frequency =
 		le32_to_cpu(firmware_info->ulMaxPixelClockPLL_Output) * 10;
+	info->max_pixel_clock = le16_to_cpu(firmware_info->usMaxPixelClock) * 10;
 
 	if (firmware_info->usFirmwareCapability.sbfAccess.MemoryClockSS_Support)
 		/* Since there is no information on the SS, report conservative
@@ -497,6 +498,7 @@ static enum bp_result get_firmware_info_v2_1(
 	info->external_clock_source_frequency_for_dp =
 		le16_to_cpu(firmwareInfo->usUniphyDPModeExtClkFreq) * 10;
 	info->min_allowed_bl_level = firmwareInfo->ucMinAllowedBL_Level;
+	info->max_pixel_clock = le16_to_cpu(firmwareInfo->usMaxPixelClock) * 10;
 
 	/* There should be only one entry in the SS info table for Memory Clock
 	 */
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index cc467031651d..38a77fa9b4af 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -169,6 +169,7 @@ struct dc_firmware_info {
 		uint32_t engine_clk_ss_percentage;
 	} feature;
 
+	uint32_t max_pixel_clock; /* in KHz */
 	uint32_t default_display_engine_pll_frequency; /* in KHz */
 	uint32_t external_clock_source_frequency_for_dp; /* in KHz */
 	uint32_t smu_gpu_pll_output_freq; /* in KHz */
-- 
2.51.0

