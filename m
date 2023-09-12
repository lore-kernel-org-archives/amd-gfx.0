Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD038CA0EF2
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 16:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321C710E436;
	Tue, 12 Sep 2023 16:02:09 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0616E10E431
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qrSSWnHdm6vlDa/DHW2GIe+aa24s4Tha+bvsO/zWvbY=; b=CVW8VQ6onbhCZ2X5gnqMm2uyqz
 RTBgQrB6At5rlphwDpvy8Ja9fz9HG1tJFpaiHv8i2X24OUQT/F7GJgCw8p7ewvTtogxenZFv70hB1
 zsGhK/ATgrsBMC4ie6EpgzDi8mQS9F38lFS7gcJ61VDFQQst+QmiAx+wtIi/n1gncCfHK1LgfJWlL
 qwn+e70OhhDFKTV6SGmOUWVfM2Tqc5HqBig8rYEPtZIHeYw0Ej+W9fZpZeW1aGj68YvUjNcZLGGFO
 j3LbvLJ4HT+feaQ3VYX5HxuPj7j9FQPJBGgDCaEqJm9cZZ9P7UOUlGPjWV4R/qUzb5Vl5sGQCoSnv
 CwIimT6Q==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qg5px-002m4H-Jz; Tue, 12 Sep 2023 18:02:01 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Subject: [PATCH v2 2/2] drm/amd/display: Remove unused display_content_support
Date: Tue, 12 Sep 2023 15:01:57 -0100
Message-Id: <20230912160157.107975-3-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912160157.107975-1-mwen@igalia.com>
References: <20230912160157.107975-1-mwen@igalia.com>
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
Cc: kernel-dev@igalia.com, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Ashton <joshua@froggi.es>

This was never filled in and thus never truly used.

Checking the EDID for content_type support is not required for sending
the avi infoframe packet.

v2:
- rebase to amd-staging-drm-next

Reviewed-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h  | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index d4224de13138..e03bb0e32e1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -188,7 +188,6 @@ struct dc_stream_state {
 	struct link_encoder *link_enc;
 	struct dc_stream_debug_options debug;
 	struct dc_panel_patch sink_patches;
-	union display_content_support content_support;
 	struct dc_crtc_timing timing;
 	struct dc_crtc_timing_adjust adjust;
 	struct dc_info_packet vrr_infopacket;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4b44c18a61a0..e531ad3acefc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -163,18 +163,6 @@ struct dc_edid {
 
 #define AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS 20
 
-union display_content_support {
-	unsigned int raw;
-	struct {
-		unsigned int valid_content_type :1;
-		unsigned int game_content :1;
-		unsigned int cinema_content :1;
-		unsigned int photo_content :1;
-		unsigned int graphics_content :1;
-		unsigned int reserved :27;
-	} bits;
-};
-
 struct dc_panel_patch {
 	unsigned int dppowerup_delay;
 	unsigned int extra_t12_ms;
@@ -207,8 +195,6 @@ struct dc_edid_caps {
 	uint32_t audio_latency;
 	uint32_t video_latency;
 
-	union display_content_support content_support;
-
 	uint8_t qs_bit;
 	uint8_t qy_bit;
 
-- 
2.40.1

