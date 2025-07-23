Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B150BC83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6F910E80D;
	Wed, 23 Jul 2025 15:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jT4T9iQe";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF9210E802
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so70118715e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286305; x=1753891105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfCgrV4wwObRjfvsQdhH0ICtEQwPygXV8y6ZOUyIrC4=;
 b=jT4T9iQevuo82D87kyyFGDe5J+JV7hk1LcVdnlgETDSqBnW3A+4vnTNtwmitVAFj5o
 kyW7bq0XiIi7a7OLpOlxdNpjt3BtAuaUZynkxCLFNdGwJONEu50j/Q7uxxfXGLLVU+3v
 KXK8DQqxQQE1JnT/zO7nv3IcSXLH4SKYzL1pKNeSVLm37FNFMgC2cA26WO3AQbt6BFEk
 2avJsyewG7z1YvpFshfs2AupnJpVE7a59cqPY4QNSA3WIGLo7wHOQH3jkckPa5n87PLU
 mc01qfFChvpu8CAqhIwck6Ul1YwGsq6H2KJLchbxwPb15czRmYa/9M/c+Yw8cUvz8vh0
 ntxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286305; x=1753891105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfCgrV4wwObRjfvsQdhH0ICtEQwPygXV8y6ZOUyIrC4=;
 b=IA0Hk/aSS+ZfcgbM5io6dARbJMMBAE+ABdvvulPNuTdxnKChYKjTCTsnNFmTIRVmK1
 7FF4jyvi4iOtR/YG2gKC2CwJpZ0ixt0/Mi8twV58j3vMcfnxL6pGis2srOJ6+AckFTCt
 ATHo/zqiBlVht4wKoSprkzj5VnyNjyvb6yVBMs9SHJm8Wp2rjBTjHMiHQi3svNRJ07fK
 sypMIuw75l7cQ4jU5LSYConkXiYs712p+T0CkIXhHnFy8PYg+mvFcFZzh6njrNFWnkA7
 2yJ1r82wsSQNkfLh4ctIvVGIEJ/i5LM8q0RaCpgHCvir7fZJr+AVGonPfAzNCRNriDHr
 fasw==
X-Gm-Message-State: AOJu0YzxzoSzbIrjOmR0VUn7RFG6AKdceT4IzSHv8apfyH03MseXcYX9
 MrHvV//W3rs9HinOGJhME7gecU748UTwwpLt1NW9mS65eIw4qfF1jHJNLs7vgA==
X-Gm-Gg: ASbGncvdjmP0+HfpLtCQ9zpOC47VNJNURfSgnoz81LbIS3I0bvKMQnvjKHkOKUeqLrp
 R07O2DoNJlDJa3GeFCjbs8CTi3rLeXFjwQPcZipZcb/3i5pzihOIY1L6DXGbb91o87YI/X1mKO1
 FJEvNUdCptWYNZNCcjxiPr35X5l0cNQYy1w0yj8rMwoTakFb/CbWFDcdhB4w/LWCSlNllQ8gw6Y
 DxP/zhidRw2Ve3uVp1+SV5nq8z0IxLt2WXzKejkBHNpLjO39sJnSi7u0m/eJ4DXhpKqdc5W0qt5
 C0OxGR9o9cB2m6mqPB14CbCPBC7dFB5LFb6LjzPXawZazU9TD/Rxa59t2BWjblehqKq1+Pdjhxt
 noXqYQwbDON15H7Zp520PyoCCYNLB9x7kGra1is1FZihq/VjRUh6v1VguLTGTZCYgU6lKdGnxzs
 ZvOijyWnC3zn+xR9b+3jp//qwAdg==
X-Google-Smtp-Source: AGHT+IEZXIKVV9j8d5dVa+woGjsOoV6UBKF/xpqjEtg+XnCkcIrgrIqtgeRKSSgqgpRXRCdVeVtifg==
X-Received: by 2002:a05:6000:2387:b0:3b7:6828:5f6d with SMTP id
 ffacd0b85a97d-3b768c9e913mr3092355f8f.3.1753286305117; 
 Wed, 23 Jul 2025 08:58:25 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/20] drm/amd/display: Get maximum pixel clock from VBIOS
Date: Wed, 23 Jul 2025 17:57:59 +0200
Message-ID: <20250723155813.9101-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

Reference in the legacy code:
amdgpu_connector_vga_mode_valid

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c           | 2 ++
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index bfacfd2a5376..bd61ed6cafab 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -444,6 +444,7 @@ static enum bp_result get_firmware_info_v1_4(
 		le32_to_cpu(firmware_info->ulMinPixelClockPLL_Output) * 10;
 	info->pll_info.max_output_pxl_clk_pll_frequency =
 		le32_to_cpu(firmware_info->ulMaxPixelClockPLL_Output) * 10;
+	info->max_pixel_clock = le16_to_cpu(firmware_info->usMaxPixelClock) * 10;
 
 	if (firmware_info->usFirmwareCapability.sbfAccess.MemoryClockSS_Support)
 		/* Since there is no information on the SS, report conservative
@@ -500,6 +501,7 @@ static enum bp_result get_firmware_info_v2_1(
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
2.50.1

