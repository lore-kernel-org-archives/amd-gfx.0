Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA06DC5DF86
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1702B10EF8E;
	Thu, 20 Aug 2026 09:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kYuSUbCA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A9D10E1C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=QSbD4GEQf+gDqfFPGBRSU5gml0IKgZBPN5HzaiJSY4o=; b=
 kYuSUbCA/SY6JTB9aKH+GIKI7QornFJ+o/VnXg6Qeo3bJAORtTlJRtYaIl37htkPg2wDFQNzPVfrj
 DLHn0rs4d5FBEti9+y6WaQ1qT89gt2iMNm6aBMn8TRR2jUQgM7J9Gf3gOhhvVa4Xo+SUyAt3XC3Kc
 FOUJZdkQbcTdur9yM0UGly7NuMu3zMy/EeZ6BSbY0sxhRIZJxL5az2MUuQ19UhS8UrXCBZadzANsc
 DuZox1GJAOo9BBo2uCrCv7OUx3yduvYN63U/ypjk0slj9AadbGr6dKB3OYFHTSb3VVDHCkfyYs7tx
 G/BUYNgAUyg3Kpz/F7Jd0elZvN//35d8EA==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wwz9L-006WKe-Df; Thu, 20 Aug 2026 11:33:27 +0200
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
Subject: [PATCH v2 2/2] drm/amd/display: use
 translate_curve_to_degamma_hw_format on DCN30
Date: Thu, 20 Aug 2026 11:26:38 +0200
Message-ID: <20260820093324.10201-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820093324.10201-1-mwen@igalia.com>
References: <20260820093324.10201-1-mwen@igalia.com>
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
but the previous fix doesn't cover this hw. Change the helper used to
translate degamma/blend curves to HW points for DCN30, DCN 301, DCN31
and DCN314 similar to what was done for DCN32+ by commit 3719314af322
("drm/amd/display: use a separate helper to translate degamma curves").

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

