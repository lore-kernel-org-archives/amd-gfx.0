Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB531ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271C910E08F;
	Tue,  6 Sep 2022 16:46:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7678410E08F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yZ+XADzHjwvGta78ZXBVQh4OGwv1Wat6G9lgsepYSyM=; b=iz5dhan26YTAJQC0mcNuzEhjA8
 LCQTujvIumZj3Zk8pMbQOgobL79W+8aG77abaRIWDRSj3zo3Y5FEPccdV0MDiDoFEfyVTkK/U/1LQ
 hW8E3GQVgEmy71ElvqRVILswHVV43d6n+tth6qPx42KNxkaGIu3tClwS7TprNesTSOJCzqt9msMAW
 caBRQRygWFDlCRHghz4/EkBS8Pm4H9EBdCC+haPypJHpwxQlGoA+2UZp+Xg6SRs2J15bvDRSgKA0I
 1mKRjnKV/kzNrfxDw9zuDLsq68oLWN8M4atHWzXgpEN7CfktTdSoOsYMv9JnGh32JBKW42n8r5fIB
 bA0EzATw==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbip-00CALM-Gz; Tue, 06 Sep 2022 18:46:47 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 2/9] drm/amd/display: add comments to describe DM crtc
 color mgmt behavior
Date: Tue,  6 Sep 2022 15:46:21 -0100
Message-Id: <20220906164628.2361811-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Describe some expected behavior of the AMD DM color mgmt programming.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 10a29d131424..b54ef1392895 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -428,12 +428,23 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
 
+		/* Note: even if we pass has_rom as parameter here, we never
+		 * actually use ROM because the color module only takes the ROM
+		 * path if transfer_func->type == PREDEFINED.
+		 *
+		 * See more in mod_color_calculate_regamma_params()
+		 */
 		r = __set_legacy_tf(stream->out_transfer_func, regamma_lut,
 				    regamma_size, has_rom);
 		if (r)
 			return r;
 	} else if (has_regamma) {
-		/* If atomic regamma, CRTC RGM goes into RGM LUT. */
+		/* CRTC RGM goes into RGM LUT.
+		 *
+		 * Note: here there is no implicit sRGB regamma. We are using
+		 * degamma calculation from color module to calculate the curve
+		 * from a linear base.
+		 */
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 
-- 
2.35.1

