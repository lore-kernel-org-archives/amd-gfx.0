Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E54C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC9511A17B;
	Thu, 14 Jul 2022 16:46:32 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067D11A17B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:46:31 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LkL3q0V6Yz9snB;
 Thu, 14 Jul 2022 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817191; bh=XV9tkKItKKrKdxeOCrOFU/aMW2lffXNMCCQLXD35gdE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FbfidNUvZjLDgWLPCM0leY/i4NLdBJrPJoPqoddJhnntfTDYAGYWCIkJ8OifHGSx5
 Y07G8uogypDYBwjUHE1X1YNJ/Hq6yNHD1+kNuEgcMGDJMC3iLr8Kii+3MHyaT1uY4w
 Vj0tdSehypuqwjzdHREubfLkstDtZTnsNZ1ntgKE=
X-Riseup-User-ID: 4406E95CF501A8ACD5FACC26F496C7F7E4FA70E08EF19107281E6C1AE30978AD
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL3j1v9fz5vW1;
 Thu, 14 Jul 2022 16:46:24 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 09/12] drm/amd/display: Remove unused MaxUsedBW variable
Date: Thu, 14 Jul 2022 13:45:04 -0300
Message-Id: <20220714164507.561751-9-mairacanal@riseup.net>
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

Remove the variable MaxUsedBW from the function
DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.
As a side-effect, the variables MaxPerPlaneVActiveWRBandwidth and
WRBandwidth are also removed.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3043:10:
warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable]
                double MaxUsedBW = 0;
                       ^
1 warning generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn30/display_mode_vba_30.c        | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 842eb94ebe04..876b321b30ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3037,40 +3037,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 	{
 		//Maximum Bandwidth Used
-		double TotalWRBandwidth = 0;
-		double MaxPerPlaneVActiveWRBandwidth = 0;
-		double WRBandwidth = 0;
-		double MaxUsedBW = 0;
-		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-			if (v->WritebackEnable[k] == true
-					&& v->WritebackPixelFormat[k] == dm_444_32) {
-				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
-						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 4;
-			} else if (v->WritebackEnable[k] == true) {
-				WRBandwidth = v->WritebackDestinationWidth[k] * v->WritebackDestinationHeight[k]
-						/ (v->HTotal[k] * v->WritebackSourceHeight[k] / v->PixelClock[k]) * 8;
-			}
-			TotalWRBandwidth = TotalWRBandwidth + WRBandwidth;
-			MaxPerPlaneVActiveWRBandwidth = dml_max(MaxPerPlaneVActiveWRBandwidth, WRBandwidth);
-		}
-
 		v->TotalDataReadBandwidth = 0;
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 			v->TotalDataReadBandwidth = v->TotalDataReadBandwidth
 					+ v->ReadBandwidthPlaneLuma[k]
 					+ v->ReadBandwidthPlaneChroma[k];
 		}
-
-		{
-			double MaxPerPlaneVActiveRDBandwidth = 0;
-			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-				MaxPerPlaneVActiveRDBandwidth = dml_max(MaxPerPlaneVActiveRDBandwidth,
-						v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
-
-			}
-		}
-
-		MaxUsedBW = MaxTotalRDBandwidth + TotalWRBandwidth;
 	}
 
 	// VStartup Margin
-- 
2.36.1

