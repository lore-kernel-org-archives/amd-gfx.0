Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB9F10FCAD2
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973DD10EEDD;
	Wed,  1 Apr 2026 18:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9P5ziqi";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5794410EB00
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:38 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so12339518eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003978; x=1775608778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=C9P5ziqi3GGQvlORl+Ko0RX6eFmn/QOtAJo8qQnqHIK/v9vazmX4mGxMMmYA/98EIc
 5e8h+RQcqDGUxI3B+iG4bwVsL2GOOUeJuoYYZd/++Yf0lfMaKK6JOhjgN8hH9QPlwasm
 jUcYf9d8M4mzYI6tj08WmWhHswmhOrDtMbzfhPfvVB2r0R7zEWxSarDS9Ymr8ggkR4Or
 gT4VRMc83GKH4JVOIVvbNEjXs0jsfSz7JBLnv3NAALvxpL9T69fhU6YF7z/MQSkGdEt4
 3b4QK2VmWOdYsrLyQgtJylQp+EOEArGNoiWpQJfC6Ry7Tw73VIKJj+BAtEJJ2FgdvOWN
 PRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003978; x=1775608778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=ZOacQPYW5Gm2ta8cqLSNFKRWT65lublNBfifO9vVJVNvZase9P2JklmDQ1gnUlFQti
 s9GvNNQ2J24UHBU3+KxOO75jdMFqoh+ohTExfPW/h3QHsE5xf6c9weO7lZ0wd44gF4m7
 THvOZBSlWQoIdzxy/mFRM7gC56zAFTLb2z6+Qf0I1T1j/jsdDBGPbQPV25PuqX7ek0nw
 T1bX35I5etJsRsq8bZdPGNKakrH7wfsgXVD4daVfcOcEStP8/CIp7H1vMRYEXzcKQY2N
 kFQ7oUJrw3y38SWJprL43oQYD52o2cd0Y4eXEC6foyIQJe44yrK4U+0+QjAxpNQqtWSX
 +YVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwyFM/W7zNOORVVVJh5ZYmeMfrOcxQ1CKTUhAnYiInUmvbWLZYvoT5+hOp7kWezanJjzJq/bb1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyDyi/5C9+Cfu2hGUTsbBifcP/vVmt3W11ETGnIFgH1+kBZWSI
 YEJcrbzru6UouvInqzqij6O0g6GIWM+gP4uxI2SPWYqlElVEVyqOleDG
X-Gm-Gg: ATEYQzwpM7QRx2EEngx4MV2JoNAboSyj4ubNJtLY4wPjStCAJbXf24e4tviP2vlKQSZ
 q3szkCdU4URMjFeOJxvzibjbXenYWpwRRNZDkhTjpDckD51db6HUSNN48j8BLbByzr8gPSFRZpl
 j+mBezYSY0vpAPEb6vuPBFiBrtkVhuz5NVgRz1GqcjIvBxmuVPWrQoLNYdmQDM88wwqqBWDnn5R
 t+bCuUHg7wcnVSF3LJRDgG+Dg8PyepxDyjg6nmjUB+qjYEbfhNI5s0R0z2zysjiv/6bzcOf0Rfj
 2iY1HcEDNegpIB3GdNPKAQTydgVfw06TCgnhQ7CzJLzdJ/n7BARCRxSYBsWJjeds2SGnMHxdGhv
 IHYYSyWXc71VuR1qrf+JBzZJXGruSIHyXnBi5yRNGDtspx5g20ke5toYfpoK3fNniDzwtII2Et8
 J8pTPYGbqByjC++iSglgQnP+Y8h6yFE5JBK4kan93/paWBUU4ultdQt5/aqRqPzRySLA==
X-Received: by 2002:a05:7300:cc1b:b0:2c4:a862:2368 with SMTP id
 5a478bee46e88-2c930c76802mr929306eec.2.1775003977555; 
 Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 05/10] drm/amd/display: Keep PLL0 running on DCE
 6.0 and 6.4
Date: Tue, 31 Mar 2026 17:39:03 -0700
Message-ID: <20260401003908.3438-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 7886a2a55caf..c4d7fa60d654 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-- 
2.53.0

