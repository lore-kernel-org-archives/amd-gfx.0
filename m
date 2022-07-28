Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9686AC19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B52910F229;
	Thu, 28 Jul 2022 18:23:07 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBAB10E46B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:49 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LtzXS2Sz4z9sQc;
 Thu, 28 Jul 2022 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032568; bh=st9aPCSjCcU8sGTEUIKVJxFHPtEfVhpUBemleBVYzmc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A7+i974rqBt7BvjPNhqVkHS7tFjI2yJNb5P8chFCMxnaVCEPyVEgYUMLOTDpbrNct
 dsk3lwMqssdX9HWY+1ha2E3/gBlYM2MX9A94rJ9pGiQFg+t9DdLS0627nVjjD0KNRH
 BPi1555a9Q91eRkn4RcJUucG3xFHkelfxCj1Fzck=
X-Riseup-User-ID: 8AC2F3FC37DEDA158C3EB2EC2EDBF02A2D401933EFE23FD8C4A047370E2472FD
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXL5N43z5vMX;
 Thu, 28 Jul 2022 18:22:42 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 10/16] drm/amd/display: Remove ModeIsSupported VBA variable
Date: Thu, 28 Jul 2022 15:20:42 -0300
Message-Id: <20220728182047.264825-11-mairacanal@riseup.net>
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

The ModeIsSupported variable from the struct vba_vars_st is only used on
assignments, so its value is not used on code. So, remove the
ModeIsSupported entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 1 -
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 1 -
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 4fac83c776ad..b776a7940fac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5250,7 +5250,6 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][1] == true) {
 					MaximumMPCCombine = 1;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 9ea2d2fd56f1..b338e72d96d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5521,7 +5521,6 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index ae749d39db2a..6c60731687bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5636,7 +5636,6 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		for (i = v->soc.num_states; i >= 0; i--) {
 			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
 				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
 				if (v->ModeSupport[i][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index a88cfce3b771..5fce4bbb4e85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -3668,8 +3668,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (i == v->soc.num_states || mode_lib->vba.ModeSupport[i][0] == true ||
 				mode_lib->vba.ModeSupport[i][1] == true) {
 			mode_lib->vba.VoltageLevel = i;
-			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
-					|| mode_lib->vba.ModeSupport[i][1] == true;
 
 			if (mode_lib->vba.ModeSupport[i][0] == true) {
 				MaximumMPCCombine = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index ac8131b52b78..f4d4bf7b6111 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1132,7 +1132,6 @@ struct vba_vars_st {
 	double VRatioChroma[DC__NUM_DPP__MAX];
 	int WritebackSourceWidth[DC__NUM_DPP__MAX];
 
-	bool ModeIsSupported;
 	bool ODMCombine4To1Supported;
 
 	unsigned int SurfaceWidthY[DC__NUM_DPP__MAX];
-- 
2.37.1

