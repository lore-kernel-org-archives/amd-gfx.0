Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96059EE01E7
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 16:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916CF10E4B4;
	Wed, 13 Sep 2023 16:43:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263F210E4B3;
 Wed, 13 Sep 2023 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+ZMJI5Sj2Rg9CxMIiUKOPSK0emM/G0J4TLRMWorV5dQ=; b=pWWmY+LnEfGVsQBJ48hLlPaoRJ
 piQLu7k3MVlyjcs+IMlQ4hC616qGxgRNzQA4StPjZohod6t9TNsK9QhEQTSvomtILuJbuNugJnSDb
 NxgMNNcBWIIgzcCcF2LOfI1M+yFGAHGqiQsqI0MbjWA58HYRy+A9PtcE3j6dQQQ77IdEQfONKzFH5
 WC8fRePoL8OEF/u2rVgEtoFjmdS8kBnrww4qudEDhyT8+dw27tbOjI2lmM9KT1OZXfttoDWF+QkmN
 pZMA0vEo1heNkVAw+frK7QYJkLzwIflGjf+4YTyTebvml3cx9lJ2G28l3gDixgA8d7gKJvDgo2BO0
 s/+112GQ==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qgSxn-003PbD-O6; Wed, 13 Sep 2023 18:43:39 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [RFC PATCH v2 5/5] drm/amd/display: add DPP and MPC color caps to DTN
 log
Date: Wed, 13 Sep 2023 15:43:29 -0100
Message-Id: <20230913164329.123687-6-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164329.123687-1-mwen@igalia.com>
References: <20230913164329.123687-1-mwen@igalia.com>
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
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add color caps information for DPP and MPC block to show HW color caps.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 23 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 23 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9255425ef794..49285f0a146a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -330,6 +330,24 @@ dcn10_log_color_state(struct dc *dc,
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
+	DTN_INFO("DPP Color Caps: input_lut_shared:%d  icsc:%d"
+		 "  dgam_ram:%d  dgam_rom: srgb:%d,bt2020:%d,gamma2_2:%d,pq:%d,hlg:%d"
+		 "  post_csc:%d  gamcor:%d  dgam_rom_for_yuv:%d  3d_lut:%d"
+		 "  blnd_lut:%d  oscs:%d\n\n",
+		 dc->caps.color.dpp.input_lut_shared,
+		 dc->caps.color.dpp.icsc,
+		 dc->caps.color.dpp.dgam_ram,
+		 dc->caps.color.dpp.dgam_rom_caps.srgb,
+		 dc->caps.color.dpp.dgam_rom_caps.bt2020,
+		 dc->caps.color.dpp.dgam_rom_caps.gamma2_2,
+		 dc->caps.color.dpp.dgam_rom_caps.pq,
+		 dc->caps.color.dpp.dgam_rom_caps.hlg,
+		 dc->caps.color.dpp.post_csc,
+		 dc->caps.color.dpp.gamma_corr,
+		 dc->caps.color.dpp.dgam_rom_for_yuv,
+		 dc->caps.color.dpp.hw_3d_lut,
+		 dc->caps.color.dpp.ogam_ram,
+		 dc->caps.color.dpp.ocsc);
 
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
 	for (i = 0; i < pool->pipe_count; i++) {
@@ -343,6 +361,11 @@ dcn10_log_color_state(struct dc *dc,
 				s.idle);
 	}
 	DTN_INFO("\n");
+	DTN_INFO("MPC Color Caps: gamut_remap:%d, 3dlut:%d, ogam_ram:%d, ocsc:%d\n\n",
+		 dc->caps.color.mpc.gamut_remap,
+		 dc->caps.color.mpc.num_3dluts,
+		 dc->caps.color.mpc.ogam_ram,
+		 dc->caps.color.mpc.ocsc);
 }
 
 void dcn10_log_hw_state(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 47119ae80e98..f604c684c853 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -124,6 +124,24 @@ dcn30_log_color_state(struct dc *dc,
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
+	DTN_INFO("DPP Color Caps: input_lut_shared:%d  icsc:%d"
+		 "  dgam_ram:%d  dgam_rom: srgb:%d,bt2020:%d,gamma2_2:%d,pq:%d,hlg:%d"
+		 "  post_csc:%d  gamcor:%d  dgam_rom_for_yuv:%d  3d_lut:%d"
+		 "  blnd_lut:%d  oscs:%d\n\n",
+		 dc->caps.color.dpp.input_lut_shared,
+		 dc->caps.color.dpp.icsc,
+		 dc->caps.color.dpp.dgam_ram,
+		 dc->caps.color.dpp.dgam_rom_caps.srgb,
+		 dc->caps.color.dpp.dgam_rom_caps.bt2020,
+		 dc->caps.color.dpp.dgam_rom_caps.gamma2_2,
+		 dc->caps.color.dpp.dgam_rom_caps.pq,
+		 dc->caps.color.dpp.dgam_rom_caps.hlg,
+		 dc->caps.color.dpp.post_csc,
+		 dc->caps.color.dpp.gamma_corr,
+		 dc->caps.color.dpp.dgam_rom_for_yuv,
+		 dc->caps.color.dpp.hw_3d_lut,
+		 dc->caps.color.dpp.ogam_ram,
+		 dc->caps.color.dpp.ocsc);
 
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE"
 		 "  SHAPER mode  3DLUT mode  3DLUT bit-depth  3DLUT size  OGAM mode  OGAM LUT"
@@ -155,6 +173,11 @@ dcn30_log_color_state(struct dc *dc,
 				s.gamut_remap_c11_c12, s.gamut_remap_c33_c34);
 	}
 	DTN_INFO("\n");
+	DTN_INFO("MPC Color Caps: gamut_remap:%d, 3dlut:%d, ogam_ram:%d, ocsc:%d\n\n",
+		 dc->caps.color.mpc.gamut_remap,
+		 dc->caps.color.mpc.num_3dluts,
+		 dc->caps.color.mpc.ogam_ram,
+		 dc->caps.color.mpc.ocsc);
 }
 
 bool dcn30_set_blend_lut(
-- 
2.40.1

