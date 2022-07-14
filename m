Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CD2C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0322211A2E7;
	Thu, 14 Jul 2022 16:47:03 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDBD11A2E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:47:01 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LkL4N6vKRzDrb1;
 Thu, 14 Jul 2022 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817221; bh=pXK1y13nfHFmum/eAc1D7DPmsGn+mtPUsWZPAoKOP6U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zc4q657uDfYEctwtS5/0JULSqEKSoeQoGhGrctIkTJf8/pXaD9ROA3jircH9dKvKJ
 JtCHMvVOQBrdtay7U9bGSeS383Jo3Nm6OFUQbmLM5ShLjj1qnDOI+FbaJnYMY1r5Vy
 JzpC3wjUM6idnKYak4IyxBySYu2Q1gfgNznAuQ7I=
X-Riseup-User-ID: 0FD0449652E5E53D0138AE87B18F8F852B8D4C8FB1381F26A125A0059EB257FB
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL4G4q6Hz5vW1;
 Thu, 14 Jul 2022 16:46:54 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 12/12] drm/amd/display: Rewrite CalculateWriteBackDISPCLK
 function
Date: Thu, 14 Jul 2022 13:45:07 -0300
Message-Id: <20220714164507.561751-12-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Based on the dml30_CalculateWriteBackDISPCLK, it separates the
DISPCLK calculations on three variables, making no functional changes, in order
to make it more readable and better express that three values are being compared
on dml_max.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../drm/amd/display/dc/dml/display_mode_vba.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index c5a0a3649e9a..5fc1d16a2e15 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1113,20 +1113,29 @@ double CalculateWriteBackDISPCLK(
 		unsigned int HTotal,
 		unsigned int WritebackChromaLineBufferWidth)
 {
-	double CalculateWriteBackDISPCLK = 1.01 * PixelClock * dml_max(
-		dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
-		dml_max((WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1) * dml_ceil(WritebackDestinationWidth / 4.0, 1)
+
+	double DISPCLK_H = 0, DISPCLK_V = 0, DISPCLK_HB = 0;
+	double CalculateWriteBackDISPCLK = 0;
+
+	DISPCLK_H = dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio;
+	DISPCLK_V = (WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1) * dml_ceil(WritebackDestinationWidth / 4.0, 1)
 			+ dml_ceil(WritebackDestinationWidth / 4.0, 1)) / (double) HTotal + dml_ceil(1.0 / WritebackVRatio, 1)
-			* (dml_ceil(WritebackLumaVTaps / 4.0, 1) + 4.0) / (double) HTotal,
-			dml_ceil(1.0 / WritebackVRatio, 1) * WritebackDestinationWidth / (double) HTotal));
+			* (dml_ceil(WritebackLumaVTaps / 4.0, 1) + 4.0) / (double) HTotal;
+	DISPCLK_HB = dml_ceil(1.0 / WritebackVRatio, 1) * WritebackDestinationWidth / (double) HTotal;
+
+	CalculateWriteBackDISPCLK = 1.01 * PixelClock * dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
+
 	if (WritebackPixelFormat != dm_444_32) {
-		CalculateWriteBackDISPCLK = dml_max(CalculateWriteBackDISPCLK, 1.01 * PixelClock * dml_max(
-			dml_ceil(WritebackChromaHTaps / 2.0, 1) / (2 * WritebackHRatio),
-			dml_max((WritebackChromaVTaps * dml_ceil(1 / (2 * WritebackVRatio), 1) * dml_ceil(WritebackDestinationWidth / 2.0 / 2.0, 1)
-				+ dml_ceil(WritebackDestinationWidth / 2.0 / WritebackChromaLineBufferWidth, 1)) / HTotal
-				+ dml_ceil(1 / (2 * WritebackVRatio), 1) * (dml_ceil(WritebackChromaVTaps / 4.0, 1) + 4) / HTotal,
-				dml_ceil(1.0 / (2 * WritebackVRatio), 1) * WritebackDestinationWidth / 2.0 / HTotal)));
+		DISPCLK_H = dml_ceil(WritebackChromaHTaps / 2.0, 1) / (2 * WritebackHRatio);
+		DISPCLK_V = (WritebackChromaVTaps * dml_ceil(1 / (2 * WritebackVRatio), 1) *
+				dml_ceil(WritebackDestinationWidth / 4.0, 1) +
+				dml_ceil(WritebackDestinationWidth / 2.0 / WritebackChromaLineBufferWidth, 1)) / HTotal +
+			dml_ceil(1 / (2 * WritebackVRatio), 1) *(dml_ceil(WritebackChromaVTaps / 4.0, 1) + 4) / HTotal;
+		DISPCLK_HB = dml_ceil(1.0 / (2 * WritebackVRatio), 1) * WritebackDestinationWidth / 2.0 / HTotal;
+		CalculateWriteBackDISPCLK = dml_max(CalculateWriteBackDISPCLK,
+				1.01 * PixelClock * dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB));
 	}
+
 	return CalculateWriteBackDISPCLK;
 }
 
-- 
2.36.1

