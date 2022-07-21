Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C321C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 18:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C664D2A3D3;
	Thu, 21 Jul 2022 18:37:25 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5940818BA0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 18:37:24 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LphBW4PfjzDqPY;
 Thu, 21 Jul 2022 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1658428644; bh=m2webdU4jTFpk3bYvkJ9MyFirvfbb6dE57i2ooQeyXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mj6MNABwekeNjXBy67g8kTqco+ArYJHAv8HkYFT1QxViNtjYsTuSnlnGoi0QFsP9w
 MR2pYnakBnHnqjYO11tN1X5M3qptk6VpL99KIxA3Tt5P3f7RlwP3m1+/EtSxeilkiF
 NhTBLbog3gWf1o+GZt+r2iV599oqCXeBofDq9/ng=
X-Riseup-User-ID: 1A8A9C96F21F58AEC65DA76C92EF0A3F4F6A193D717DD15885453AE7430B2AFA
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4LphBP4GGRz1yWd;
 Thu, 21 Jul 2022 18:37:17 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v2 4/4] drm/amd/display: Rewrite CalculateWriteBackDISPCLK
 function
Date: Thu, 21 Jul 2022 15:36:33 -0300
Message-Id: <20220721183633.1004611-4-mairacanal@riseup.net>
In-Reply-To: <20220721183633.1004611-1-mairacanal@riseup.net>
References: <20220721183633.1004611-1-mairacanal@riseup.net>
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
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 magalilemes00@gmail.com, tales.aparecida@gmail.com,
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
Reviewed-by: André Almeida <andrealmeid@igalia.com>
---
 .../drm/amd/display/dc/dml/display_mode_vba.c | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 503e7d984ff0..df80c79d8fbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1115,20 +1115,27 @@ double CalculateWriteBackDISPCLK(
 		unsigned int HTotal,
 		unsigned int WritebackChromaLineBufferWidth)
 {
-	double CalculateWriteBackDISPCLK = 1.01 * PixelClock * dml_max(
-		dml_ceil(WritebackLumaHTaps / 4.0, 1) / WritebackHRatio,
-		dml_max((WritebackLumaVTaps * dml_ceil(1.0 / WritebackVRatio, 1) * dml_ceil(WritebackDestinationWidth / 4.0, 1)
+	double DISPCLK_H, DISPCLK_V, DISPCLK_HB, CalculateWriteBackDISPCLK;
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

