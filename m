Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A030EE01E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 16:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C572E10E471;
	Wed, 13 Sep 2023 16:43:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EDC10E471;
 Wed, 13 Sep 2023 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H2QuD87LwlcNawx9SyTEfgN8REI6zl7ok20ilXADWsE=; b=Qculs8X4zO1m5IKtgTVSQSmfWA
 fwEIpHHq97ctysi6fUuHjbs4gZWSeJ4CRVNyueyRBinSYTAGVZPMtFl+kginR8avuh/AKHtzst2pt
 0BVZ8AiqOxWwrn3NKDw4oUB4EwvPqBsNUe1I2ZnX3mBzW1/gMKYfN4G5tOBx3JPXMT1KroF5MKM9G
 HVMgTI/H6TGbIrsoSmPPvriBqu4nqhSGFfVLpDoEqZy5fqQaEBrme4EQotH4XExdqL/DVkrCJKKZ7
 Sdra5nw7lulPbwrQpu1tly/Xz1wr1BSxtX6G5AQuhrH+WtilQhR12VI9l6CSmyZuhASN2248I5phT
 KaGRu+2Q==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qgSxh-003PbD-65; Wed, 13 Sep 2023 18:43:33 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [RFC PATCH v2 1/5] drm/amd/display: detach color state from hw state
 logging
Date: Wed, 13 Sep 2023 15:43:25 -0100
Message-Id: <20230913164329.123687-2-mwen@igalia.com>
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

Prepare to hook color state logging according to DCN version.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 79befa17bb03..a0c489ed218c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -279,19 +279,14 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 	DTN_INFO("\n");
 }
 
-void dcn10_log_hw_state(struct dc *dc,
-	struct dc_log_buffer_ctx *log_ctx)
+static void
+dcn10_log_color_state(struct dc *dc,
+		      struct dc_log_buffer_ctx *log_ctx)
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	int i;
 
-	DTN_INFO_BEGIN();
-
-	dcn10_log_hubbub_state(dc, log_ctx);
-
-	dcn10_log_hubp_states(dc, log_ctx);
-
 	DTN_INFO("DPP:    IGAM format  IGAM mode    DGAM mode    RGAM mode"
 			"  GAMUT mode  C11 C12   C13 C14   C21 C22   C23 C24   "
 			"C31 C32   C33 C34\n");
@@ -348,6 +343,22 @@ void dcn10_log_hw_state(struct dc *dc,
 				s.idle);
 	}
 	DTN_INFO("\n");
+}
+
+void dcn10_log_hw_state(struct dc *dc,
+	struct dc_log_buffer_ctx *log_ctx)
+{
+	struct dc_context *dc_ctx = dc->ctx;
+	struct resource_pool *pool = dc->res_pool;
+	int i;
+
+	DTN_INFO_BEGIN();
+
+	dcn10_log_hubbub_state(dc, log_ctx);
+
+	dcn10_log_hubp_states(dc, log_ctx);
+
+	dcn10_log_color_state(dc, log_ctx);
 
 	DTN_INFO("OTG:  v_bs  v_be  v_ss  v_se  vpol  vmax  vmin  vmax_sel  vmin_sel  h_bs  h_be  h_ss  h_se  hpol  htot  vtot  underflow blank_en\n");
 
-- 
2.40.1

