Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891DECDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 16:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDF310EBE5;
	Tue, 23 Jun 2026 16:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YKwf/Wz8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C7E10EBD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oYO76o9jNr8cmbTT9DOZQgO+n5hLWpqXw5ms/uWgos4=; b=YKwf/Wz8jLdfgO1THqvcAZLOvq
 1KoCmw+8wR8udHmBj7wWYswNmumP9LGq58Y8wNatUAeIrIO8VFwxfOPKqZqcoXDawqb528FpLtBht
 GliC6W3mGzMQtIokUf+WHeVV8+UV35T9YUfQdrR69s5wFe0Kg6VRmnjDVuPdMaQhq+RBSjrY/0Nn+
 jVJJCKFJb1gHs/P80exgnmeCxkGQzi7RaRaKMOZ9KndzvztYFwwNZgU1Sy63dLAdB+tbR+bNfMEpN
 CwZUY677dHazxYa2J6oSaytXt58cI5tPCPtHAOMN4B5W+q8sReIyS4s6qv61yVZFyVIvqRByn1CfU
 9pbm4FCg==;
Received: from 5.red-79-144-94.dynamicip.rima-tde.net ([79.144.94.5]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc3Yp-004FI4-L2; Tue, 23 Jun 2026 18:01:15 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, Xaver Hugl <xaver.hugl@kde.org>,
 robert.mader@posteo.de, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH v3 3/5] drm/amd/display: use a separate helper to translate
 degamma curves
Date: Tue, 23 Jun 2026 17:58:59 +0200
Message-ID: <20260623160112.1636801-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623160112.1636801-1-mwen@igalia.com>
References: <20260623160112.1636801-1-mwen@igalia.com>
MIME-Version: 1.0
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

In newer DCN families, there is no hw predefined curves for shaper,
blend and regamma. When userspace sets pre-defined curves for these
blocks, the driver uses AMD color module to program predefined curve as
LUT. However, it was using the same LUT segmentation for EOTF and
inverse EOTF by using the same color management helper. This is causing
banding on blend when PQ predefined curve is set. Besides that, degamma
predefined HW curve cannot be used with subsampled 4:2:0/4:2:2 formats
as it affects the linearity of color space in which HW scaler operates.

To mitigate banding when using the blend block and better support
subsampled format on degamma, use different translation helpers when
linearizing and delinearizing.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 1340f673ec3b..c2ea25927765 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -493,11 +493,9 @@ bool dcn32_set_mcm_luts(
 	if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
 		lut_params = &plane_state->cm.blend_func.pwl;
 	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		result = cm3_helper_translate_curve_to_hw_format(
-			plane_state->ctx,
+		result = cm3_helper_translate_curve_to_degamma_hw_format(
 			&plane_state->cm.blend_func,
-			&dpp_base->regamma_params,
-			false);
+			&dpp_base->regamma_params);
 		if (!result)
 			return result;
 
@@ -554,9 +552,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
 		params = &plane_state->in_transfer_func.pwl;
 	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
-		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-							&plane_state->in_transfer_func,
-							&dpp_base->degamma_params, false))
+		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
+								&dpp_base->degamma_params))
 		params = &dpp_base->degamma_params;
 
 	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
-- 
2.53.0

