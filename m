Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB05C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD3610EF9B;
	Thu, 20 Aug 2026 09:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XFsj1A1I";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861AB10EF89
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=Sfbuig5mEW6sA2+Psk8A6QSbxAEmSHnm+N6G+mrfy1U=; b=
 XFsj1A1IO4ge0f5jYglr7WX4v+eyPdDmzLwg+qRbEFSBsq1BqU3taEsA+aLl+3FYoWE5c433ZaE8p
 4BPd+t+680UwK51MM1yLimzqw4oflSTSX2ogqRmHDDOe0qqTxwFV5qOTMr3m3dpLuHLIBSWt2IAC2
 GPNBens4uAgRjmj6ohTYNKLrEsflnx6kdG+d77Gx/wmiTn60e3jvD7CZRYqt9NGQ+Hk4Bmcibzm0u
 sfSnEoBJ1Xrmh30Ot9HSw8mLwphsHpYXc/cy0s3644eZh9j5Dl4/ojiT2aVECEaQ84GeOL+/wH2UQ
 i/41veBwAw3mYEHFUpTHLPa9nxm4WljyiQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wwz9K-006WKe-IY; Thu, 20 Aug 2026 11:33:26 +0200
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
Subject: [PATCH v2 1/2] drm/amd/display: use halving distribution for all
 encode-to-linear curves
Date: Thu, 20 Aug 2026 11:26:37 +0200
Message-ID: <20260820093324.10201-2-mwen@igalia.com>
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

In encode-to-linear conversions, LUT entries should be uniformly
distributed across the input range: non-linear encodings are already
approximately perceptually uniform, so every input code carries the same
weight. A fixed count per region does the opposite, concentrating
entries on the darker values and leaving few for the bright end, whereas
halving distribution spaces all 256 entries uniformly. This holds for
any encoded input, so remove the PQ/sRGB condition from commit
de17c6bb7072 ("drm/amd/display: use halving distribution for PQ/sRGB
linearizing LUT") and apply halving to all encode-to-linear operations
(pre-defined TF or user LUTs).

It fixes the following IGT kms_colorop subtests:
- plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut
- plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2

Fixes: de17c6bb7072 ("drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 66fe7f313ea3..62ca235cd649 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -320,6 +320,8 @@ static struct fixed31_32 interp_tf_pts(const struct fixed31_32 *output_tf_channe
 	return value;
 }
 
+#define NUM_DEGAMMA_REGIONS    9
+
 bool cm3_helper_translate_curve_to_degamma_hw_format(
 				const struct dc_transfer_func *output_tf,
 				struct pwl_params *lut_params)
@@ -343,31 +345,15 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 	memset(lut_params, 0, sizeof(struct pwl_params));
 	memset(seg_distr, 0, sizeof(seg_distr));
 
-	if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
-	    output_tf->tf == TRANSFER_FUNCTION_SRGB) {
-		/* 9 segments
-		 * segments are from 2^-9 to 0
-		 */
-		const uint8_t SEG_COUNT = 9;
-		seg_distr[0] = 0; // Since we only have one point in darkest region
-		for (k = 1; k < SEG_COUNT; k++)
-			seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
+	/* 9 segments
+	 * segments are from 2^-9 to 2^0
+	 */
+	seg_distr[0] = 0; // Since we only have one point in darkest region
+	for (k = 1; k < NUM_DEGAMMA_REGIONS; k++)
+		seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
 
-		region_start = -SEG_COUNT;
-		region_end = 0;
-	} else {
-		/* 12 segments
-		 * segments are from 2^-12 to 2^0
-		 * There are less than 256 points, for optimization
-		 */
-		const uint8_t SEG_COUNT = 12;
-
-		for (i = 0; i < SEG_COUNT; i++)
-			seg_distr[i] = 4;
-
-		region_start = -SEG_COUNT;
-		region_end = 0;
-	}
+	region_start = -NUM_DEGAMMA_REGIONS;
+	region_end = 0;
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
 		seg_distr[i] = -1;
-- 
2.53.0

