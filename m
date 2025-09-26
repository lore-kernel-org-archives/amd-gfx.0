Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86ECAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD2D10EAD0;
	Fri, 26 Sep 2025 18:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eBwpNQ8j";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A23F10EAD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:26:42 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1797090b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758911202; x=1759516002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6pGl2zE/qKsZT/YQspYdsea3F+8D5zTIayZWxZmun4=;
 b=eBwpNQ8jzuG0XJ6dlLoZGxv3A0QDPoPIoNKBbV0D1aePeXnwKHPxtCH+dlu7/fZHlP
 5TyrlCsxGQ9B8m0AmelRtfsx4n8fqt529u4euvK0Sp2DK5sFw9nhBZg0hDNlgmDU6h3R
 Vx7BlLTlw5crCVlfF9CAE3yZoqzBJZ7SRIXaHABJ8Mp94mo1g5R+Gf8vEOXKQcfucDW0
 WqMyHQ4Wjq2EzmMnyQv6tx+JZMXceUXc4DXGjh7855UIOn1uIv+8aKMxkM5RkrasJqfQ
 BqvDZJw/IncMX7JFjr2AFb1vmqKaeu1DYE5ZglwiBFLbX1OezKjfxIFveCbA239zfUzn
 K1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758911202; x=1759516002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6pGl2zE/qKsZT/YQspYdsea3F+8D5zTIayZWxZmun4=;
 b=tIR3KIBT75e31G9syacX6BAUy63MujoSTRNFwxVwVGCeG0IKMOpf0Y+HtQeoraFbWE
 a3sCFKSycjfIbrfaSnVVWUwcYS5jxs1jA+Yz1FzKxeyQDtft8fgpctlDi8Xt/4MHzvR/
 Zm0afZk+OIIyNsQ0hGnjwJjxNE8ZFsQh9rbX1HX+keyQHGo0PDJKYUJ0un/pb75SO/vx
 tqhZ+m77NFu8ehJj3btMduuIYqwTLNUyutHFP8DEIs6v7V1M+m7YnqEWr7gUDFmfcWDp
 UySYZR2JP3uMnPPcwRPGFoKosCEy+4TsijXCc7Xn5h/x7x1HC6JKHp9wDDl95cQuc16A
 oj5w==
X-Gm-Message-State: AOJu0YzHjMP8AyqzchXlXGLQJ1kOdGf9YsG5ndRyAxN7gdnjM2PWXs/R
 RnrExmVUnxEnJRH5xPOLxp+F+tr4PLPi7YG6UCNRPYCRvq+gwGVkOoajUIiPawkB
X-Gm-Gg: ASbGncs5xDZzSXH68KnCFwD/4anBs08Vej3c1LWNAm2FV6rLZqSzXwbJVCKdH+qKNzl
 Ga+JbrXpwjt1YPiuohW7xQIogHaw+QqRJiXgHr6WFHXEKEGNcB1DL3kYcs7h8aRPh+K2MmWYqAl
 NjIDBK9H7wbEiBo/A2NO5psgzMSjmt7hbhTR64yiDScBisBcCZIYh8M4Az92uT+wQmU6Sgc8elQ
 vgk0VWCdCDPS6zNihVcG6CvhQ6W0XZt3AHS1drha++VgKPv8shiypK1uG4D/hAaOX4SudD26WoC
 KlYSdwehl3aE/N3u1EHlGdjrwYIZMyppSWqPvTmPSwELAhlzKcrk2UmYm83woCXSeYOxVHzO17Z
 WQQ1LBpbDYx9CpX5vm90SypacfuN8wntcPbmB/CjMZY6Q3a5IwAR6wPKTKe+X9lRqHNeMfCay4g
 XDOtIJBvzNPUfdoFLvqDe7bZ3dDRfQmg==
X-Google-Smtp-Source: AGHT+IHlKZPekWSweQv/VFhXZTx8jbCZkcaCt3FxqWdE5IibuLulglYxhtyUOQvfdI3Q+eVT0zWniw==
X-Received: by 2002:a05:6a21:6003:b0:2fe:54f7:2b07 with SMTP id
 adf61e73a8af0-2fe54f72c25mr144407637.20.1758911201912; 
 Fri, 26 Sep 2025 11:26:41 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb255sm5352131a12.5.2025.09.26.11.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:26:41 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE 6-10
Date: Fri, 26 Sep 2025 20:26:14 +0200
Message-ID: <20250926182614.26629-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926182614.26629-1-timur.kristof@gmail.com>
References: <20250926182614.26629-1-timur.kristof@gmail.com>
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

Set stricter dividers to stabilize the PLL's feedback loop.
In practice, the actual output isn't exactly the target
clock, but slowly oscillates around it. This makes it
more stable.

The values here are taken from the non-DC code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index b4f5b4a6331a..00f25e2ee081 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
 			clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
 	calc_pll_cs_init_data.min_pll_ref_divider =	1;
 	calc_pll_cs_init_data.max_pll_ref_divider =	clk_src->cs_mask->PLL_REF_DIV;
+
+	if (ctx->dce_version <= DCE_VERSION_10_0) {
+		/* Set stricter dividers to stabilize the PLL's feedback loop on old HW. */
+		calc_pll_cs_init_data.min_pix_clk_pll_post_divider = 2;
+		calc_pll_cs_init_data.min_pll_ref_divider = 2;
+	}
+
 	/* when 0 use minInputPxlClkPLLFrequencyInKHz from firmwareInfo*/
 	calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_khz =	0;
 	/* when 0 use maxInputPxlClkPLLFrequencyInKHz from firmwareInfo*/
-- 
2.51.0

