Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C06CDB479
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 16:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FFA10EBDB;
	Tue, 23 Jun 2026 16:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SVgiYRT9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910510EBB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fCOPBymXFkeicbyc26jhcEU+1nLRYu2DvZSx6Tnr9rI=; b=SVgiYRT9GR2dx0Kbq2kUlL0ZLy
 USZPN9yCAk+MsXvPWE93Ylho7fTQpBeTAM1NRnaTYm++9kKjAUsXAVhLL0a0c6As5N+s3o8snbrcv
 93l0rWIhMQRr0sNbZhI6glQHK52aYg5BdQDOa5I1Vb/EfjDBaObxeJY0B3Phaf5XXQmHSAh4eAIz4
 wmo2Eu2lWFx2e9H+h6b3qaP8dQtboZillFfgHeNJlDBlRKakTndPAalq9DcKLOV7eXBajcoU3t+sk
 2iVTjXW0LHV80IStEqZ/S1kVUt8rNFEu7iCM9qJZbSJRjGGvbpo85Aj2tOS8r6/cBnghhzsO6jQEb
 BQTrcfsQ==;
Received: from 5.red-79-144-94.dynamicip.rima-tde.net ([79.144.94.5]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc3Yr-004FI4-2g; Tue, 23 Jun 2026 18:01:17 +0200
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
Subject: [PATCH v3 5/5] drm/amd/display: use halving distribution for PQ/sRGB
 linearizing LUT
Date: Tue, 23 Jun 2026 17:59:01 +0200
Message-ID: <20260623160112.1636801-6-mwen@igalia.com>
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

When linearizing, the input is an encoded signal bounded to [0,1] and
PQ/sRGB EOTFs are steepest near 1, requiring more precision near the
bright end.

Take the 8-bit sRGB case as a reference: 256 possible inputs and 256 HW
LUT points line up, so the LUT acts as plain indexing. Float
representations don't land perfectly, but LERP-ing between two HW
entries, when input is within a small epsilon of one of them, doesn't
materially change the result.

Replace the uniform 12-region distribution (16 points each,
192 total, range [2^-12, 1]) with a 9-region halving distribution for
the PQ/sRGB pre-defined EOTF: 128 points in the top region [0.5, 1], 64
in the next, 32 in the next, and so on, down to 1 point in each of the
two darkest regions. Total samples grow from 192 to 256, with uniform
1/256 spacing across [0, 1]. The dark tail below 2^-9 is no longer
sampled separately, which is acceptable for PQ/sRGB.

Suggested-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 70b7bc3494a2..66fe7f313ea3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -303,8 +303,6 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	return true;
 }
 
-#define NUM_DEGAMMA_REGIONS    12
-
 /* Linear interpolation of tf_pts entries, where (i >> 4) is the integer tf_pts
  * index, (i & 0xf) is the 1/16 sub-position.
  */
@@ -345,17 +343,34 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 	memset(lut_params, 0, sizeof(struct pwl_params));
 	memset(seg_distr, 0, sizeof(seg_distr));
 
-	region_start = -NUM_DEGAMMA_REGIONS;
-	region_end   = 0;
+	if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
+	    output_tf->tf == TRANSFER_FUNCTION_SRGB) {
+		/* 9 segments
+		 * segments are from 2^-9 to 0
+		 */
+		const uint8_t SEG_COUNT = 9;
+		seg_distr[0] = 0; // Since we only have one point in darkest region
+		for (k = 1; k < SEG_COUNT; k++)
+			seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
 
+		region_start = -SEG_COUNT;
+		region_end = 0;
+	} else {
+		/* 12 segments
+		 * segments are from 2^-12 to 2^0
+		 * There are less than 256 points, for optimization
+		 */
+		const uint8_t SEG_COUNT = 12;
+
+		for (i = 0; i < SEG_COUNT; i++)
+			seg_distr[i] = 4;
+
+		region_start = -SEG_COUNT;
+		region_end = 0;
+	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
 		seg_distr[i] = -1;
-	/* 12 segments
-	 * segments are from 2^-12 to 0
-	 */
-	for (i = 0; i < NUM_DEGAMMA_REGIONS ; i++)
-		seg_distr[i] = 4;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
 		if (seg_distr[k] != -1)
-- 
2.53.0

