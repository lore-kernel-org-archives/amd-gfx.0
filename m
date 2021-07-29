Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B5C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 13:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6764360EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 13:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6764360EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51D16ED34;
	Thu, 29 Jul 2021 13:56:15 +0000 (UTC)
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
 by gabe.freedesktop.org (Postfix) with ESMTP id 265F16ECEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 08:34:08 +0000 (UTC)
Received: from BC-Mail-Ex23.internal.baidu.com (unknown [172.31.51.17])
 by Forcepoint Email with ESMTPS id 003B523FF937B0D4569B;
 Thu, 29 Jul 2021 16:18:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex23.internal.baidu.com (172.31.51.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 29 Jul 2021 16:18:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 29 Jul 2021 16:18:21 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Fix typo in comments
Date: Thu, 29 Jul 2021 16:18:14 +0800
Message-ID: <20210729081814.1738-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex27.internal.baidu.com (172.31.51.21) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Mailman-Approved-At: Thu, 29 Jul 2021 13:56:14 +0000
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
Cc: Cai Huoqing <caihuoqing@baidu.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the repeated word 'the' from comments

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 +-
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1596f6b7fed7..7f12ca902f7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1030,7 +1030,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 	/* Timing borders are part of vactive that we are also supposed to skip in addition
 	 * to any stream dst offset. Since dm logic assumes dst is in addressable
-	 * space we need to add the the left and top borders to dst offsets temporarily.
+	 * space we need to add the left and top borders to dst offsets temporarily.
 	 * TODO: fix in DM, stream dst is supposed to be in vactive
 	 */
 	pipe_ctx->stream->dst.x += timing->h_border_left;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 799bae229e67..2091dd8c252d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -488,7 +488,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	log2_meta_req_bytes = 6; // meta request is 64b and is 8x8byte meta element
 
 	// each 64b meta request for dcn is 8x8 meta elements and
-	// a meta element covers one 256b block of the the data surface.
+	// a meta element covers one 256b block of the data surface.
 	log2_meta_req_height = log2_blk256_height + 3; // meta req is 8x8 byte, each byte represent 1 blk256
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
 			- log2_meta_req_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 6a6d5970d1d5..1a0c14e465fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -488,7 +488,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	log2_meta_req_bytes = 6; // meta request is 64b and is 8x8byte meta element
 
 	// each 64b meta request for dcn is 8x8 meta elements and
-	// a meta element covers one 256b block of the the data surface.
+	// a meta element covers one 256b block of the data surface.
 	log2_meta_req_height = log2_blk256_height + 3; // meta req is 8x8 byte, each byte represent 1 blk256
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
 			- log2_meta_req_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index dc1c81a6e377..287e31052b30 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -482,7 +482,7 @@ static void get_meta_and_pte_attr(
 	log2_meta_req_bytes = 6; // meta request is 64b and is 8x8byte meta element
 
 	// each 64b meta request for dcn is 8x8 meta elements and
-	// a meta element covers one 256b block of the the data surface.
+	// a meta element covers one 256b block of the data surface.
 	log2_meta_req_height = log2_blk256_height + 3; // meta req is 8x8 byte, each byte represent 1 blk256
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
 			- log2_meta_req_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 04601a767a8f..0d934fae1c3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -549,7 +549,7 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	log2_meta_req_bytes = 6; // meta request is 64b and is 8x8byte meta element
 
 				 // each 64b meta request for dcn is 8x8 meta elements and
-				 // a meta element covers one 256b block of the the data surface.
+				 // a meta element covers one 256b block of the data surface.
 	log2_meta_req_height = log2_blk256_height + 3; // meta req is 8x8 byte, each byte represent 1 blk256
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
 		- log2_meta_req_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 3def093ef88e..c23905bc733a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -563,7 +563,7 @@ static void get_meta_and_pte_attr(
 	log2_meta_req_bytes = 6;	// meta request is 64b and is 8x8byte meta element
 
 	// each 64b meta request for dcn is 8x8 meta elements and
-	// a meta element covers one 256b block of the the data surface.
+	// a meta element covers one 256b block of the data surface.
 	log2_meta_req_height = log2_blk256_height + 3;	// meta req is 8x8 byte, each byte represent 1 blk256
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element - log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index 414da64f5734..8f2b1684c231 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -456,7 +456,7 @@ static void dml1_rq_dlg_get_row_heights(
 	log2_meta_req_bytes = 6; /* meta request is 64b and is 8x8byte meta element */
 
 	/* each 64b meta request for dcn is 8x8 meta elements and
-	 * a meta element covers one 256b block of the the data surface.
+	 * a meta element covers one 256b block of the data surface.
 	 */
 	log2_meta_req_height = log2_blk256_height + 3; /* meta req is 8x8 */
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
@@ -718,7 +718,7 @@ static void get_surf_rq_param(
 	log2_meta_req_bytes = 6; /* meta request is 64b and is 8x8byte meta element */
 
 	/* each 64b meta request for dcn is 8x8 meta elements and
-	 * a meta element covers one 256b block of the the data surface.
+	 * a meta element covers one 256b block of the data surface.
 	 */
 	log2_meta_req_height = log2_blk256_height + 3; /* meta req is 8x8 byte, each byte represent 1 blk256 */
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
