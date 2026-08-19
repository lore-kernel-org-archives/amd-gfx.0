Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF4C5DF88
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 16:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D30910EE63;
	Wed, 19 Aug 2026 16:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Bpn1mzPM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EF410EE43
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=xwByNHtzNj9S0lDXZF63ll8KwMNauy+aLrTaIcyMnts=; b=
 Bpn1mzPMl11LjZKll0v357ZYzKrRLIlIUfBlmStR/riM9ICTnKHsjvprAhZL9cgH/9cfqnSuhfxdG
 KdFv+XQEQz5Julyl9bTodY9MoVxodRSjOawv+g88ACLTSML1oae0c+Eckv67WNBqAmkWVaE/qnu1M
 H9IVXm99fSLHqvrDKZSWWKsh/e13QRVBtg6/TtY3gq2J6qoCvYO01WiMnNGYZEIKF+3sb2ESM/cMG
 OIU821hOXrcQx1U5HANknTdhVIsR/YgtASpS/tGyayjFIYSok3XIX+XWG183Gqo/oHuXAkeXXlhWP
 kB7NKpuOg3gq5uZhWj2olVbkcp7+6snexw==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wwisp-006BRc-IY; Wed, 19 Aug 2026 18:11:19 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, mwen@igalia.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: use translate_curve_to_degamma_hw_format
 on DCN30
Date: Wed, 19 Aug 2026 18:00:17 +0200
Message-ID: <20260819161106.27702-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819161106.27702-1-mwen@igalia.com>
References: <20260819161106.27702-1-mwen@igalia.com>
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

DCN3.01 presents the same banding issue as reported in the link below,
but the previous fix doesn't cover this hw. Change the helper for
degamma/blend curves for DCN30-based family.

Link: https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/
Fixes: 3719314af322 ("drm/amd/display: use a separate helper to translate degamma curves")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index cb163902e12e..6980f622db0a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -243,10 +243,9 @@ bool dcn30_set_blend_lut(
 	if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
 		blend_lut = &plane_state->cm.blend_func.pwl;
 	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
+		result = cm3_helper_translate_curve_to_degamma_hw_format(
 				&plane_state->cm.blend_func,
-				&dpp_base->regamma_params,
-				false);
+				&dpp_base->regamma_params);
 		if (!result)
 			return result;
 
@@ -337,9 +336,8 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
 		params = &plane_state->in_transfer_func.pwl;
 	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
-		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-							&plane_state->in_transfer_func,
-							&dpp_base->degamma_params, false))
+		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
+								&dpp_base->degamma_params))
 		params = &dpp_base->degamma_params;
 
 	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
-- 
2.53.0

