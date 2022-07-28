Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2777EC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0099810E60E;
	Thu, 28 Jul 2022 18:23:07 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBAE10E78D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:22 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtzWx4QwyzDs0B;
 Thu, 28 Jul 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032541; bh=5hukvlPt2ChjYzre5ze2WfJX5Xbvr7tV7otABd84zlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hyodr8kwFkVVg90zz5nWUUCKq3zyQVKKQS62RHEFJJ/G+kwNkUL2Igcnsd/T7A+4f
 ICCEdXQvl3Kja9HTkEdI/Gu01/UytBOGlT9/eXaKWYjAkDbat1UYbBZX2XjM4pluYr
 2cIIBMVNHWd0FhKsr0caUCQn5ECWn3kHiPZyChTY=
X-Riseup-User-ID: 66D1C708B57EE5B17385B395AC67F948C1042C7E83AEF2D42C307DA3DCAC86FD
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWs0QJrz5vMX;
 Thu, 28 Jul 2022 18:22:16 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 06/16] drm/amd/display: Remove ImmediateFlipSupportedSurface
 VBA variable
Date: Thu, 28 Jul 2022 15:20:38 -0300
Message-Id: <20220728182047.264825-7-mairacanal@riseup.net>
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

The ImmediateFlipSupportedSurface variable from the struct
vba_vars_st is only used on assignments, so its value is not used
on code. So, remove the ImmediateFlipSupportedSurface entry from the struct
vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 6 ------
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h       | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index f199ef475ed0..e2e1d6e77902 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -355,12 +355,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			if (j != k && mode_lib->vba.BlendingAndTiming[k] == j && mode_lib->vba.DSCEnabled[j])
 				v->DSCDelay[k] = v->DSCDelay[j];
 
-	//Immediate Flip
-	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-		v->ImmediateFlipSupportedSurface[k] = mode_lib->vba.ImmediateFlipSupport
-				&& (mode_lib->vba.ImmediateFlipRequirement[k] != dm_immediate_flip_not_required);
-	}
-
 	// Prefetch
 	dml32_CalculateSurfaceSizeInMall(
 				mode_lib->vba.NumberOfActiveSurfaces,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 841a05bea57e..76cba5d7ac10 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -659,8 +659,6 @@ struct vba_vars_st {
 	double DISPCLK_calculated;
 	double DPPCLK_calculated[DC__NUM_DPP__MAX];
 
-	bool ImmediateFlipSupportedSurface[DC__NUM_DPP__MAX];
-
 	bool Use_One_Row_For_Frame[DC__NUM_DPP__MAX];
 	bool Use_One_Row_For_Frame_Flip[DC__NUM_DPP__MAX];
 	unsigned int VUpdateOffsetPix[DC__NUM_DPP__MAX];
-- 
2.37.1

