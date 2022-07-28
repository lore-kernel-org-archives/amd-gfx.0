Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A132C19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA3810E875;
	Thu, 28 Jul 2022 18:23:07 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA0B10F8D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:27 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtzX26j2MzDrsv;
 Thu, 28 Jul 2022 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032547; bh=KxvoCK+77gkilpIyGMLDeI1tnqCfaC+2xs0CoAX0DNo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c+ZbGIIaaEs2IB114VFnSeu7cc9eBsmrgthyIzjrFX5xO1hZ/3aOUMGjza3+I1Fc6
 m+qRAM40Q7/BVek4wypIiUT4In18hQWbtH+oowbfS4dVtPk3wr6v8rAgASjpztCST1
 oLTv8FMJ1uLzDIYTg345MBA+7s1HshPvLiHlrdqQ=
X-Riseup-User-ID: 26566C790EE104442A012390CD0FCC02310DDFB0C32058388C28B4ADFA6B79E4
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWy4qZ8z5vMX;
 Thu, 28 Jul 2022 18:22:22 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 07/16] drm/amd/display: Remove
 WritebackAllowFCLKChangeEndPosition VBA variable
Date: Thu, 28 Jul 2022 15:20:39 -0300
Message-Id: <20220728182047.264825-8-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
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

The WritebackAllowFCLKChangeEndPosition variable from the struct
vba_vars_st is only used on assignments, so its value is not used on
code. So, remove the WritebackAllowFCLKChangeEndPosition entry
from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 ----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h         | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e2e1d6e77902..756a55f69799 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1219,12 +1219,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->WritebackAllowDRAMClockChangeEndPosition[k] = dml_max(0,
 						v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
 								- v->Watermark.WritebackDRAMClockChangeWatermark);
-				v->WritebackAllowFCLKChangeEndPosition[k] = dml_max(0,
-						v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
-								- v->Watermark.WritebackFCLKChangeWatermark);
 			} else {
 				v->WritebackAllowDRAMClockChangeEndPosition[k] = 0;
-				v->WritebackAllowFCLKChangeEndPosition[k] = 0;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 76cba5d7ac10..518e599d74e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1303,7 +1303,6 @@ struct vba_vars_st {
 	bool OutputMultistreamEn[DC__NUM_DPP__MAX];
 	bool UsesMALLForStaticScreen[DC__NUM_DPP__MAX];
 	double MaxActiveDRAMClockChangeLatencySupported[DC__NUM_DPP__MAX];
-	double WritebackAllowFCLKChangeEndPosition[DC__NUM_DPP__MAX];
 	bool PTEBufferSizeNotExceededPerState[DC__NUM_DPP__MAX]; // new in DML32
 	bool DCCMetaBufferSizeNotExceededPerState[DC__NUM_DPP__MAX]; // new in DML32
 	bool NotEnoughDSCSlices[DC__VOLTAGE_STATES];
-- 
2.37.1

