Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9E7CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 16:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD2A10EBD9;
	Tue, 23 Jun 2026 16:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TP4TDWhY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E905B10E874
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cnSBFXCd5pL6ihoKW9sa7Vs11XeZIKEy1sP0Zhk5fIU=; b=TP4TDWhY/dPl9wuvJX1jtwXn+J
 XwYgIZMdN1v1lHdMPzbKHVWwRWW7y82ry2UTN8pghPa1q/vcOx3AC7I6/Ve7zbsJ0H+ms/1iFbH0R
 ducUhxFiite2i9PsNx/7R42tx2+xw6Nx8ZVxUgRCKpqPipuyfcxF7rMzjoULTK8nxv9fxyKw6/Vvh
 8IPWoW2T5ocEJ8qMII+BsitOFOepG2JTDAMkfYuOmrwTiFjV1CZ8sckyR7eQeAcYUidN/WV+fp2od
 WSjxtd6jmI1goyhKGhMVgmTLzaaPgztb1YBeIaeAiuysv/wCQSS5vHDaSUVX+cTNgv9ZibILkPl+A
 boU+9RgA==;
Received: from 5.red-79-144-94.dynamicip.rima-tde.net ([79.144.94.5]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc3Yo-004FI4-5l; Tue, 23 Jun 2026 18:01:14 +0200
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
Subject: [PATCH v3 1/5] drm/amd/display: use GAMCOR for degamma private props
 in subsampled format
Date: Tue, 23 Jun 2026 17:58:57 +0200
Message-ID: <20260623160112.1636801-2-mwen@igalia.com>
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

When setting plane degamma TF via AMD driver-specific color properties,
the driver uses PRE_DEGAM color block (ROM). However, this block cannot
be used with subsampled formats as it affects the linearity of color
space in which HW scaler operates. For subsampled format, use the AMD
color module to map plane degamma predefined curve to LUT and use GAMCOR
block instead (RAM).

This is based on Harry's implementation for Fixed Matrix Colorop.

Link: https://lore.kernel.org/dri-devel/20260330153451.99472-1-harry.wentland@amd.com/
Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a9a741c21663..df781788ceec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1469,7 +1469,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	const struct drm_color_lut *degamma_lut;
 	enum amdgpu_transfer_function tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	uint32_t degamma_size;
-	bool has_degamma_lut;
+	bool has_degamma_lut, is_subsampled_format;
 	int ret;
 
 	degamma_lut = __extract_blob_lut(dm_plane_state->degamma_lut,
@@ -1499,12 +1499,20 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 		if (ret)
 			return ret;
        } else {
-		dc_plane_state->in_transfer_func.type =
-			TF_TYPE_PREDEFINED;
+	       /* Check if format requires post-scale color processing (subsampled formats) */
+		is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+					dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
+		dc_plane_state->in_transfer_func.type = TF_TYPE_PREDEFINED;
 
 		if (!mod_color_calculate_degamma_params(color_caps,
-		    &dc_plane_state->in_transfer_func, NULL, false))
+							&dc_plane_state->in_transfer_func,
+							NULL,
+							is_subsampled_format)) {
+			drm_err(plane_state->state->dev,
+				"Failed to calculate degamma params.\n");
 			return -ENOMEM;
+		}
 	}
 	return 0;
 }
-- 
2.53.0

