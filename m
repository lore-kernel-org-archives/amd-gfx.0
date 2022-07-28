Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC4C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6036D10F20F;
	Thu, 28 Jul 2022 18:23:07 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5621510E478
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:55 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LtzXZ5v6fz9spX;
 Thu, 28 Jul 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032574; bh=zYsJAgnz9NxzI78mWEyNp5Rfrplr2HMd8zTd+2H3qzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bqjanDXJZLjlDpmvBBX3SyLO7UsB4YrhGNK/CR66sVttAal1ngnK2toLfaWxziomK
 kJjmnEln7DIXPd4MBBk7dt7iJ1Y4htGBlcqhfgXKnaaLnpQjg6dPjX7GVJ9LBtK2ab
 qRiQY9T8DOP2Zd+h4QtFNyYBEFRpdkBkA/t2uaMM=
X-Riseup-User-ID: 029433EB08767EF91F38D039897485939EFC26DE185FAD55DEA8F2F0E96F7E76
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXT3cgPz5vMX;
 Thu, 28 Jul 2022 18:22:49 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 11/16] drm/amd/display: Remove MPCCombineEnable VBA variable
Date: Thu, 28 Jul 2022 15:20:43 -0300
Message-Id: <20220728182047.264825-12-mairacanal@riseup.net>
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

The MPCCombineEnable variable from the struct vba_vars_st is only
used on assignments, so its value is not used on code. So, remove
the MPCCombineEnable entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 1 -
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index b776a7940fac..7dd51fe88d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5259,7 +5259,6 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index b338e72d96d8..2e906f01950b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5530,7 +5530,6 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 6c60731687bf..6a5b3c39ec60 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5645,7 +5645,6 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
 		v->DCFCLK = v->DCFCLKState[v->VoltageLevel][MaximumMPCCombine];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 5fce4bbb4e85..6d4907656f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3685,8 +3685,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.CompressedBufferSizeInkByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine]; // Not used, informational
 
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-		mode_lib->vba.MPCCombineEnable[k] =
-				mode_lib->vba.MPCCombine[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
 		mode_lib->vba.DPPPerPlane[k] = mode_lib->vba.NoOfDPP[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
 		mode_lib->vba.SwathHeightY[k] =
 				mode_lib->vba.SwathHeightYAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index f4d4bf7b6111..31cf144860b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1147,7 +1147,6 @@ struct vba_vars_st {
 	double GPUVMMinPageSize;
 	double HostVMMinPageSize;
 
-	bool   MPCCombineEnable[DC__NUM_DPP__MAX];
 	unsigned int HostVMMaxNonCachedPageTableLevels;
 	bool   DynamicMetadataVMEnabled;
 	double       WritebackInterfaceBufferSize;
-- 
2.37.1

