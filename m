Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A374C352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB4821841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zuB/zSCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB4821841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA586E359;
	Thu, 16 Apr 2020 23:41:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66D86E359
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrh9/e49LzHV7Acq9RrS3LoKqTb/3oQrI7LSv6BLCBUJ+yy0WPeW4FOUmZzTrDpFJujiyN0VokAY8xKDCjPBnsnBJq5HDdKOKwK2WF3n4voNFRTnjBbAReo6YMyG94m9PZEyG8rgFAXtWMcRI64BJqSy+ftZdBQmZWbuxWGhRJ9lBdMv6vXLr8Ty/ZxKoxJlyjdTluVg3lABRLAwvkwvpZPC4wW/6WQmo1CgvVtCCgCOlk+145luzAMXQeiiKpIs4j6YRw1GdWXDe3wZChnJl/dW9WL9wMOXfmp/E/2+DyVzUjZ2hKbjCoIRhAkmZY6RHZo7lEcdA3IOiBukjTAnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COT4JAQ2MGw0Se/6a4Ymhd9WzWNpTLYARbLKGurp/yc=;
 b=kjbOg8+NvXQXYG3BFHe7jSV1s2nnyVaDgk3xrH7HrbnzU0rIhN+mGIqyqHrmCGTMG7UI1U5LLs6xS4/ISNcr1n+87fHWHihf1Z16cqIaCmmLfnHf4tgKFISxZZP581CvUsc/TgpoUG/Cm6YRkjY0ZHNmMNMwngdKsiHYO1lAKQUyHskNX9EZLm0r30kom6l/a8W+t+h/gXaqSxTdCUMdN1FH4yuI3a9URmuGbkFI9uzUFUhFK7sOuQQMWZbiK1WmJVrQrzd7He8GyCmQvvn5Ddqyg4omMa8Ka7y7YJel7kEXexyWP/dA3mbZiDlcuI7CXwqiu/LR9W9olkkn+XCrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COT4JAQ2MGw0Se/6a4Ymhd9WzWNpTLYARbLKGurp/yc=;
 b=zuB/zSCoFTk7kMChiYzTF8xLqMGeZnD85HaZiTw3GCiDVp3oXfulsWs2w+nBL2yiXFYQcNFXHZ/NuAXzh1Wxdr+6MEBublD5SrDBo9wcqyjf1VHZ8sQravagQO/AV6SU1QLsum6jowXkhvVmCOKT2EPCKmbSExFngN9i+LW1+q8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/35] drm/amd/display: change from panel to panel cntl
Date: Thu, 16 Apr 2020 19:40:39 -0400
Message-Id: <20200416234044.2082886-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:50 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b016c2b7-f93e-4f14-9a15-08d7e25fbd07
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245952278AD9481F5109FB7798D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(30864003)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/eTbsCZmD3hhUMsZ+dqLZXgn1tCW1ty5TOJ/P86MfqqHF7ZvdUNeOZ736sbCnLsdrFV48sjklEX53r3bx/0FOMstr5lpJ+GASqAQEqALRKvqkC2OOtARS4aMvUVeM9ZryUmUC50aJ9KZCi2Ynjon6Y8Ub5JBSUsQf0/TPXCD7irv+ZMJiFmQXAaSVCo+MrQIdK+beYFbtbZKQBaB02ea31Byg7IccfyLt+nO2SqkcS8Wduf1viYMIii+kfdMdR3DTT3qqCxyVBsPYik0+hfztai80cbv5k+vwJxeuDFBa8v1oapLB3pYLICBqiIHY9HM7uWwu1BZh4uziIygN2y5m8L1Fpy+dUR5x5M0nwPcttHO6HLhqk3fMs9txRWTjAACW8nAOqnqdohsHJg0eLeBvtsFh3BaVT8jMJsOyHE3Q/hWE0vp4U6q9zjogYFaoKb
X-MS-Exchange-AntiSpam-MessageData: rGFLylIrlzjV9uzmMxFV5EjJowyJ/ORe2M7xlPw9gzgD8/yNl1HT6UrSwHnSEhdvfSDsfFwTT5tPz0oiLY+wwsyUQFzphKN6LF521SOa8rl6VzA9uQtq25czCoYHG5+dIjemvnr1iQA5t/Ujb7lDvzInX4ONyqlzsicW9O8B7NQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b016c2b7-f93e-4f14-9a15-08d7e25fbd07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:52.0895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9dd4wCQ0NMS/gYyZs+gUThewvriJk2bkLMyghPJy0nz6HI/P9EHFUSRDBf58GGrwsDFhWwKDmLF1E3jNROmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
it doesn't represent panel specifically, it's more like the control
logic for the panel

[How]
change from panel to panel cntl to make it a bit more clear

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 34 ++++----
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |  2 +-
 .../dc/dce/{dce_panel.c => dce_panel_cntl.c}  | 64 +++++++-------
 .../dc/dce/{dce_panel.h => dce_panel_cntl.h}  | 86 +++++++++----------
 .../amd/display/dc/dce100/dce100_resource.c   | 34 ++++----
 .../display/dc/dce110/dce110_hw_sequencer.c   | 10 ++-
 .../amd/display/dc/dce110/dce110_resource.c   | 34 ++++----
 .../amd/display/dc/dce112/dce112_resource.c   | 34 ++++----
 .../amd/display/dc/dce120/dce120_resource.c   | 34 ++++----
 .../drm/amd/display/dc/dce80/dce80_resource.c | 34 ++++----
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 34 ++++----
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 34 ++++----
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 34 ++++----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  6 +-
 .../dc/inc/hw/{panel.h => panel_cntl.h}       | 24 +++---
 16 files changed, 251 insertions(+), 249 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/dce/{dce_panel.c => dce_panel_cntl.c} (55%)
 rename drivers/gpu/drm/amd/display/dc/dce/{dce_panel.h => dce_panel_cntl.h} (50%)
 rename drivers/gpu/drm/amd/display/dc/inc/hw/{panel.h => panel_cntl.h} (75%)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b38abd0c362a..0d8fae4e9441 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -47,7 +47,7 @@
 #include "hw/clk_mgr.h"
 #include "dce/dmub_psr.h"
 #include "dmub/inc/dmub_cmd_dal.h"
-#include "inc/hw/panel.h"
+#include "inc/hw/panel_cntl.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -88,8 +88,8 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->ddc)
 		dal_ddc_service_destroy(&link->ddc);
 
-	if (link->panel)
-		link->panel->funcs->destroy(&link->panel);
+	if (link->panel_cntl)
+		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
 	if (link->link_enc)
 		link->link_enc->funcs->destroy(&link->link_enc);
@@ -1359,7 +1359,7 @@ static bool dc_link_construct(struct dc_link *link,
 	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
 	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
-	struct panel_init_data panel_init_data = { 0 };
+	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
 	struct integrated_info info = {{{ 0 }}};
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
@@ -1461,18 +1461,18 @@ static bool dc_link_construct(struct dc_link *link,
 		dal_ddc_get_line(dal_ddc_service_get_ddc_pin(link->ddc));
 
 
-	if (link->dc->res_pool->funcs->panel_create &&
+	if (link->dc->res_pool->funcs->panel_cntl_create &&
 		(link->link_id.id == CONNECTOR_ID_EDP ||
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
-		panel_init_data.ctx = dc_ctx;
-		panel_init_data.inst = 0;
-		link->panel =
-			link->dc->res_pool->funcs->panel_create(
-								&panel_init_data);
-
-		if (link->panel == NULL) {
-			DC_ERROR("Failed to create link panel!\n");
-			goto panel_create_fail;
+		panel_cntl_init_data.ctx = dc_ctx;
+		panel_cntl_init_data.inst = 0;
+		link->panel_cntl =
+			link->dc->res_pool->funcs->panel_cntl_create(
+								&panel_cntl_init_data);
+
+		if (link->panel_cntl == NULL) {
+			DC_ERROR("Failed to create link panel_cntl!\n");
+			goto panel_cntl_create_fail;
 		}
 	}
 
@@ -1558,9 +1558,9 @@ static bool dc_link_construct(struct dc_link *link,
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
 link_enc_create_fail:
-	if (link->panel != NULL)
-		link->panel->funcs->destroy(&link->panel);
-panel_create_fail:
+	if (link->panel_cntl != NULL)
+		link->panel_cntl->funcs->destroy(&link->panel_cntl);
+panel_cntl_create_fail:
 	dal_ddc_service_destroy(&link->ddc);
 ddc_create_fail:
 create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 31c9706f1b0b..80fb4149f36a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -135,7 +135,7 @@ struct dc_link {
 
 	struct dc_context *ctx;
 
-	struct panel *panel;
+	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
 	struct graphics_object_id link_id;
 	union ddi_channel_mapping ddi_channel_mapping;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 144ade2e1007..f704a8fd52e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -29,7 +29,7 @@
 DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
-dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel.o
+dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dce_panel_cntl.o
 
 AMD_DAL_DCE = $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
similarity index 55%
rename from drivers/gpu/drm/amd/display/dc/dce/dce_panel.c
rename to drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index 6f9849995456..d9b0ff7eb2a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -26,33 +26,33 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dc_dmub_srv.h"
-#include "panel.h"
-#include "dce_panel.h"
+#include "panel_cntl.h"
+#include "dce_panel_cntl.h"
 
-#define TO_DCE_PANEL(panel)\
-	container_of(panel, struct dce_panel, base)
+#define TO_DCE_PANEL_CNTL(panel_cntl)\
+	container_of(panel_cntl, struct dce_panel_cntl, base)
 
 #define CTX \
-	dce_panel->base.ctx
+	dce_panel_cntl->base.ctx
 
 #define DC_LOGGER \
-	dce_panel->base.ctx->logger
+	dce_panel_cntl->base.ctx->logger
 
 #define REG(reg)\
-	dce_panel->regs->reg
+	dce_panel_cntl->regs->reg
 
 #undef FN
 #define FN(reg_name, field_name) \
-	dce_panel->shift->field_name, dce_panel->mask->field_name
+	dce_panel_cntl->shift->field_name, dce_panel_cntl->mask->field_name
 
-void dce_panel_hw_init(struct panel *panel)
+void dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 {
 
 }
 
-bool dce_is_panel_backlight_on(struct panel *panel)
+bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 {
-	struct dce_panel *dce_panel = TO_DCE_PANEL(panel);
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t value;
 
 	REG_GET(PWRSEQ_CNTL, BLON, &value);
@@ -60,9 +60,9 @@ bool dce_is_panel_backlight_on(struct panel *panel)
 	return value;
 }
 
-bool dce_is_panel_powered_on(struct panel *panel)
+bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
 {
-	struct dce_panel *dce_panel = TO_DCE_PANEL(panel);
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t pwr_seq_state, dig_on, dig_on_ovrd;
 
 	REG_GET(PWRSEQ_STATE, PWRSEQ_TARGET_STATE_R, &pwr_seq_state);
@@ -72,34 +72,34 @@ bool dce_is_panel_powered_on(struct panel *panel)
 	return (pwr_seq_state == 1) || (dig_on == 1 && dig_on_ovrd == 1);
 }
 
-static void dce_panel_destroy(struct panel **panel)
+static void dce_panel_cntl_destroy(struct panel_cntl **panel_cntl)
 {
-	struct dce_panel *dce_panel = TO_DCE_PANEL(*panel);
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(*panel_cntl);
 
-	kfree(dce_panel);
-	*panel = NULL;
+	kfree(dce_panel_cntl);
+	*panel_cntl = NULL;
 }
 
-static const struct panel_funcs dce_link_panel_funcs = {
-	.destroy = dce_panel_destroy,
-	.hw_init = dce_panel_hw_init,
+static const struct panel_cntl_funcs dce_link_panel_cntl_funcs = {
+	.destroy = dce_panel_cntl_destroy,
+	.hw_init = dce_panel_cntl_hw_init,
 	.is_panel_backlight_on = dce_is_panel_backlight_on,
 	.is_panel_powered_on = dce_is_panel_powered_on,
 
 };
 
-void dce_panel_construct(
-	struct dce_panel *dce_panel,
-	const struct panel_init_data *init_data,
-	const struct dce_panel_registers *regs,
-	const struct dce_panel_shift *shift,
-	const struct dce_panel_mask *mask)
+void dce_panel_cntl_construct(
+	struct dce_panel_cntl *dce_panel_cntl,
+	const struct panel_cntl_init_data *init_data,
+	const struct dce_panel_cntl_registers *regs,
+	const struct dce_panel_cntl_shift *shift,
+	const struct dce_panel_cntl_mask *mask)
 {
-	dce_panel->regs = regs;
-	dce_panel->shift = shift;
-	dce_panel->mask = mask;
+	dce_panel_cntl->regs = regs;
+	dce_panel_cntl->shift = shift;
+	dce_panel_cntl->mask = mask;
 
-	dce_panel->base.funcs = &dce_link_panel_funcs;
-	dce_panel->base.ctx = init_data->ctx;
-	dce_panel->base.inst = init_data->inst;
+	dce_panel_cntl->base.funcs = &dce_link_panel_cntl_funcs;
+	dce_panel_cntl->base.ctx = init_data->ctx;
+	dce_panel_cntl->base.inst = init_data->inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel.h b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
similarity index 50%
rename from drivers/gpu/drm/amd/display/dc/dce/dce_panel.h
rename to drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
index a09162440ac8..6dc6984f9248 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
@@ -23,53 +23,53 @@
  *
  */
 
-#ifndef __DC_PANEL__DCE_H__
-#define __DC_PANEL__DCE_H__
+#ifndef __DC_PANEL_CNTL__DCE_H__
+#define __DC_PANEL_CNTL__DCE_H__
 
-#include "panel.h"
+#include "panel_cntl.h"
 
 /* set register offset with instance */
-#define DCE_PANEL_SR(reg_name, block)\
+#define DCE_PANEL_CNTL_SR(reg_name, block)\
 	.reg_name = mm ## block ## _ ## reg_name
 
-#define DCE_PANEL_REG_LIST()\
-	DCE_PANEL_SR(PWRSEQ_CNTL, LVTMA), \
-	DCE_PANEL_SR(PWRSEQ_STATE, LVTMA), \
+#define DCE_PANEL_CNTL_REG_LIST()\
+	DCE_PANEL_CNTL_SR(PWRSEQ_CNTL, LVTMA), \
+	DCE_PANEL_CNTL_SR(PWRSEQ_STATE, LVTMA), \
 	SR(BL_PWM_CNTL), \
 	SR(BL_PWM_CNTL2), \
 	SR(BL_PWM_PERIOD_CNTL), \
 	SR(BL_PWM_GRP1_REG_LOCK)
 
-#define DCN_PANEL_SR(reg_name, block)\
+#define DCN_PANEL_CNTL_SR(reg_name, block)\
 	.reg_name = BASE(mm ## block ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## _ ## reg_name
 
-#define DCN_PANEL_REG_LIST()\
-	DCN_PANEL_SR(PWRSEQ_CNTL, LVTMA), \
-	DCN_PANEL_SR(PWRSEQ_STATE, LVTMA), \
+#define DCN_PANEL_CNTL_REG_LIST()\
+	DCN_PANEL_CNTL_SR(PWRSEQ_CNTL, LVTMA), \
+	DCN_PANEL_CNTL_SR(PWRSEQ_STATE, LVTMA), \
 	SR(BL_PWM_CNTL), \
 	SR(BL_PWM_CNTL2), \
 	SR(BL_PWM_PERIOD_CNTL), \
 	SR(BL_PWM_GRP1_REG_LOCK)
 
-#define DCE_PANEL_SF(block, reg_name, field_name, post_fix)\
+#define DCE_PANEL_CNTL_SF(block, reg_name, field_name, post_fix)\
 	.field_name = block ## reg_name ## __ ## block ## field_name ## post_fix
 
-#define DCE_PANEL_MASK_SH_LIST(mask_sh) \
-	DCE_PANEL_SF(LVTMA_, PWRSEQ_CNTL, BLON, mask_sh),\
-	DCE_PANEL_SF(LVTMA_, PWRSEQ_CNTL, DIGON, mask_sh),\
-	DCE_PANEL_SF(LVTMA_, PWRSEQ_CNTL, DIGON_OVRD, mask_sh),\
-	DCE_PANEL_SF(LVTMA_, PWRSEQ_STATE, PWRSEQ_TARGET_STATE_R, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_CNTL, BL_PWM_EN, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_LOCK, mask_sh), \
-	DCE_PANEL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_UPDATE_PENDING, mask_sh)
+#define DCE_PANEL_CNTL_MASK_SH_LIST(mask_sh) \
+	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, BLON, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, DIGON, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_CNTL, DIGON_OVRD, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_, PWRSEQ_STATE, PWRSEQ_TARGET_STATE_R, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD_BITCNT, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_ACTIVE_INT_FRAC_CNT, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_PWM_FRACTIONAL_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_CNTL, BL_PWM_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_IGNORE_MASTER_LOCK_EN, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_LOCK, mask_sh), \
+	DCE_PANEL_CNTL_SF(, BL_PWM_GRP1_REG_LOCK, BL_PWM_GRP1_REG_UPDATE_PENDING, mask_sh)
 
-#define DCE_PANEL_REG_FIELD_LIST(type) \
+#define DCE_PANEL_CNTL_REG_FIELD_LIST(type) \
 	type BLON;\
 	type DIGON;\
 	type DIGON_OVRD;\
@@ -83,15 +83,15 @@
 	type BL_PWM_GRP1_REG_LOCK; \
 	type BL_PWM_GRP1_REG_UPDATE_PENDING
 
-struct dce_panel_shift {
-	DCE_PANEL_REG_FIELD_LIST(uint8_t);
+struct dce_panel_cntl_shift {
+	DCE_PANEL_CNTL_REG_FIELD_LIST(uint8_t);
 };
 
-struct dce_panel_mask {
-	DCE_PANEL_REG_FIELD_LIST(uint32_t);
+struct dce_panel_cntl_mask {
+	DCE_PANEL_CNTL_REG_FIELD_LIST(uint32_t);
 };
 
-struct dce_panel_registers {
+struct dce_panel_cntl_registers {
 	uint32_t PWRSEQ_CNTL;
 	uint32_t PWRSEQ_STATE;
 	uint32_t BL_PWM_CNTL;
@@ -100,18 +100,18 @@ struct dce_panel_registers {
 	uint32_t BL_PWM_GRP1_REG_LOCK;
 };
 
-struct dce_panel {
-	struct panel base;
-	const struct dce_panel_registers *regs;
-	const struct dce_panel_shift *shift;
-	const struct dce_panel_mask *mask;
+struct dce_panel_cntl {
+	struct panel_cntl base;
+	const struct dce_panel_cntl_registers *regs;
+	const struct dce_panel_cntl_shift *shift;
+	const struct dce_panel_cntl_mask *mask;
 };
 
-void dce_panel_construct(
-	struct dce_panel *panel,
-	const struct panel_init_data *init_data,
-	const struct dce_panel_registers *regs,
-	const struct dce_panel_shift *shift,
-	const struct dce_panel_mask *mask);
+void dce_panel_cntl_construct(
+	struct dce_panel_cntl *panel_cntl,
+	const struct panel_cntl_init_data *init_data,
+	const struct dce_panel_cntl_registers *regs,
+	const struct dce_panel_cntl_shift *shift,
+	const struct dce_panel_cntl_mask *mask);
 
-#endif /* __DC_PANEL__DCE_H__ */
+#endif /* __DC_PANEL_CNTL__DCE_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 6668cb81e858..a28c4ae0f259 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -46,7 +46,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "dce100/dce100_hw_sequencer.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "reg_helper.h"
 
@@ -250,16 +250,16 @@ static const struct dce_stream_encoder_mask se_mask = {
 		SE_COMMON_MASK_SH_LIST_DCE80_100(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCE_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCE_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 #define opp_regs(id)\
@@ -640,21 +640,21 @@ struct link_encoder *dce100_link_encoder_create(
 	return &enc110->base;
 }
 
-static struct panel *dce100_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dce100_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 struct output_pixel_processor *dce100_opp_create(
@@ -973,7 +973,7 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 static const struct resource_funcs dce100_res_pool_funcs = {
 	.destroy = dce100_destroy_resource_pool,
 	.link_enc_create = dce100_link_encoder_create,
-	.panel_create = dce100_panel_create,
+	.panel_cntl_create = dce100_panel_cntl_create,
 	.validate_bandwidth = dce100_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 09891fb5239a..7d4cb7fd31a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -53,7 +53,7 @@
 #include "abm.h"
 #include "audio.h"
 #include "reg_helper.h"
-#include "panel.h"
+#include "panel_cntl.h"
 
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
@@ -796,10 +796,11 @@ void dce110_edp_power_control(
 		return;
 	}
 
-	if (link->panel)
+	if (link->panel_cntl)
 		return;
 
-	if (power_up != link->panel->funcs->is_panel_powered_on(link->panel)) {
+	if (power_up !=
+		link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl)) {
 		/* Send VBIOS command to prompt eDP panel power */
 		if (power_up) {
 			unsigned long long current_ts = dm_get_timestamp(ctx);
@@ -878,7 +879,8 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (enable && link->panel && link->panel->funcs->is_panel_backlight_on(link->panel)) {
+	if (enable && link->panel_cntl &&
+		link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl)) {
 		DC_LOG_HW_RESUME_S3(
 				"%s: panel already powered up. Do nothing.\n",
 				__func__);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 9b4bf9410cb5..9597fc79d7fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -53,7 +53,7 @@
 #include "dce/dce_abm.h"
 #include "dce/dce_dmcu.h"
 #include "dce/dce_i2c.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #define DC_LOGGER \
 		dc->ctx->logger
@@ -276,16 +276,16 @@ static const struct dce_stream_encoder_mask se_mask = {
 		SE_COMMON_MASK_SH_LIST_DCE110(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCE_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCE_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 static const struct dce110_aux_registers_shift aux_shift = {
@@ -686,21 +686,21 @@ static struct link_encoder *dce110_link_encoder_create(
 	return &enc110->base;
 }
 
-static struct panel *dce110_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dce110_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 static struct output_pixel_processor *dce110_opp_create(
@@ -1233,7 +1233,7 @@ struct stream_encoder *dce110_find_first_free_match_stream_enc_for_link(
 static const struct resource_funcs dce110_res_pool_funcs = {
 	.destroy = dce110_destroy_resource_pool,
 	.link_enc_create = dce110_link_encoder_create,
-	.panel_create = dce110_panel_create,
+	.panel_cntl_create = dce110_panel_cntl_create,
 	.validate_bandwidth = dce110_validate_bandwidth,
 	.validate_plane = dce110_validate_plane,
 	.acquire_idle_pipe_for_layer = dce110_acquire_underlay,
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 2c25e6f9beb9..4a7796de2ff5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -51,7 +51,7 @@
 #include "dce/dce_dmcu.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "reg_helper.h"
 
@@ -239,16 +239,16 @@ static const struct dce110_link_enc_aux_registers link_enc_aux_regs[] = {
 		aux_regs(5)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCE_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCE_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 #define hpd_regs(id)\
@@ -644,21 +644,21 @@ struct link_encoder *dce112_link_encoder_create(
 	return &enc110->base;
 }
 
-static struct panel *dce112_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dce112_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 static struct input_pixel_processor *dce112_ipp_create(
@@ -1051,7 +1051,7 @@ static void dce112_destroy_resource_pool(struct resource_pool **pool)
 static const struct resource_funcs dce112_res_pool_funcs = {
 	.destroy = dce112_destroy_resource_pool,
 	.link_enc_create = dce112_link_encoder_create,
-	.panel_create = dce112_panel_create,
+	.panel_cntl_create = dce112_panel_cntl_create,
 	.validate_bandwidth = dce112_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce112_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 71f8431d5ae6..9a9764cbd78d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -44,7 +44,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_ipp.h"
 #include "dce/dce_mem_input.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "dce110/dce110_hw_sequencer.h"
 #include "dce120/dce120_hw_sequencer.h"
@@ -294,16 +294,16 @@ static const struct dce_stream_encoder_mask se_mask = {
 		SE_COMMON_MASK_SH_LIST_DCE120(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCE_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCE_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 static const struct dce110_aux_registers_shift aux_shift = {
@@ -728,21 +728,21 @@ static struct link_encoder *dce120_link_encoder_create(
 	return &enc110->base;
 }
 
-static struct panel *dce120_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dce120_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 static struct input_pixel_processor *dce120_ipp_create(
@@ -910,7 +910,7 @@ static void dce120_destroy_resource_pool(struct resource_pool **pool)
 static const struct resource_funcs dce120_res_pool_funcs = {
 	.destroy = dce120_destroy_resource_pool,
 	.link_enc_create = dce120_link_encoder_create,
-	.panel_create = dce120_panel_create,
+	.panel_cntl_create = dce120_panel_cntl_create,
 	.validate_bandwidth = dce112_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce112_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index dca7f7c0b488..a19be9de2df7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -50,7 +50,7 @@
 #include "dce/dce_hwseq.h"
 #include "dce80/dce80_hw_sequencer.h"
 #include "dce100/dce100_resource.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "reg_helper.h"
 
@@ -267,16 +267,16 @@ static const struct dce_stream_encoder_mask se_mask = {
 		SE_COMMON_MASK_SH_LIST_DCE80_100(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCE_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCE_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 #define opp_regs(id)\
@@ -741,21 +741,21 @@ struct link_encoder *dce80_link_encoder_create(
 	return &enc110->base;
 }
 
-static struct panel *dce80_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dce80_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 struct clock_source *dce80_clock_source_create(
@@ -939,7 +939,7 @@ static void dce80_destroy_resource_pool(struct resource_pool **pool)
 static const struct resource_funcs dce80_res_pool_funcs = {
 	.destroy = dce80_destroy_resource_pool,
 	.link_enc_create = dce80_link_encoder_create,
-	.panel_create = dce80_panel_create,
+	.panel_cntl_create = dce80_panel_cntl_create,
 	.validate_bandwidth = dce80_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 7dd0945ff5cf..43116749af9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -51,7 +51,7 @@
 #include "dce112/dce112_resource.h"
 #include "dcn10_hubp.h"
 #include "dcn10_hubbub.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "soc15_hw_ip.h"
 #include "vega10_ip_offset.h"
@@ -322,16 +322,16 @@ static const struct dcn10_link_enc_mask le_mask = {
 		LINK_ENCODER_MASK_SH_LIST_DCN10(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCN_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCN_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 static const struct dce110_aux_registers_shift aux_shift = {
@@ -820,21 +820,21 @@ struct link_encoder *dcn10_link_encoder_create(
 	return &enc10->base;
 }
 
-static struct panel *dcn10_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dcn10_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 struct clock_source *dcn10_clock_source_create(
@@ -1321,7 +1321,7 @@ static const struct dc_cap_funcs cap_funcs = {
 static const struct resource_funcs dcn10_res_pool_funcs = {
 	.destroy = dcn10_destroy_resource_pool,
 	.link_enc_create = dcn10_link_encoder_create,
-	.panel_create = dcn10_panel_create,
+	.panel_cntl_create = dcn10_panel_cntl_create,
 	.validate_bandwidth = dcn_validate_bandwidth,
 	.acquire_idle_pipe_for_layer = dcn10_acquire_idle_pipe_for_layer,
 	.validate_plane = dcn10_validate_plane,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 6472c3a2d270..63044ae06327 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -61,7 +61,7 @@
 #include "dcn20_dccg.h"
 #include "dcn20_vmid.h"
 #include "dc_link_ddc.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "navi10_ip_offset.h"
 
@@ -688,16 +688,16 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN2_MASK_SH_LIST(_MASK)
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCN_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCN_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 #define ipp_regs(id)\
@@ -1302,21 +1302,21 @@ struct link_encoder *dcn20_link_encoder_create(
 	return &enc20->enc10.base;
 }
 
-static struct panel *dcn20_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dcn20_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 struct clock_source *dcn20_clock_source_create(
@@ -3219,7 +3219,7 @@ enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 static struct resource_funcs dcn20_res_pool_funcs = {
 	.destroy = dcn20_destroy_resource_pool,
 	.link_enc_create = dcn20_link_encoder_create,
-	.panel_create = dcn20_panel_create,
+	.panel_cntl_create = dcn20_panel_cntl_create,
 	.validate_bandwidth = dcn20_validate_bandwidth,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 1cc6da46a82a..78e6259b4ac9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -61,7 +61,7 @@
 #include "dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 #include "dce110/dce110_resource.h"
-#include "dce/dce_panel.h"
+#include "dce/dce_panel_cntl.h"
 
 #include "dcn20/dcn20_dwb.h"
 #include "dcn20/dcn20_mmhubbub.h"
@@ -1607,16 +1607,16 @@ static const struct dcn10_link_enc_registers link_enc_regs[] = {
 	link_regs(4, E),
 };
 
-static const struct dce_panel_registers panel_regs[] = {
-	{ DCN_PANEL_REG_LIST() }
+static const struct dce_panel_cntl_registers panel_cntl_regs[] = {
+	{ DCN_PANEL_CNTL_REG_LIST() }
 };
 
-static const struct dce_panel_shift panel_shift = {
-	DCE_PANEL_MASK_SH_LIST(__SHIFT)
+static const struct dce_panel_cntl_shift panel_cntl_shift = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_panel_mask panel_mask = {
-	DCE_PANEL_MASK_SH_LIST(_MASK)
+static const struct dce_panel_cntl_mask panel_cntl_mask = {
+	DCE_PANEL_CNTL_MASK_SH_LIST(_MASK)
 };
 
 #define aux_regs(id)\
@@ -1705,21 +1705,21 @@ static struct link_encoder *dcn21_link_encoder_create(
 	return &enc21->enc10.base;
 }
 
-static struct panel *dcn21_panel_create(const struct panel_init_data *init_data)
+static struct panel_cntl *dcn21_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
-	struct dce_panel *panel =
-		kzalloc(sizeof(struct dce_panel), GFP_KERNEL);
+	struct dce_panel_cntl *panel_cntl =
+		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
 
-	if (!panel)
+	if (!panel_cntl)
 		return NULL;
 
-	dce_panel_construct(panel,
+	dce_panel_cntl_construct(panel_cntl,
 			init_data,
-			&panel_regs[init_data->inst],
-			&panel_shift,
-			&panel_mask);
+			&panel_cntl_regs[init_data->inst],
+			&panel_cntl_shift,
+			&panel_cntl_mask);
 
-	return &panel->base;
+	return &panel_cntl->base;
 }
 
 #define CTX ctx
@@ -1766,7 +1766,7 @@ enum dc_status dcn21_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 static struct resource_funcs dcn21_res_pool_funcs = {
 	.destroy = dcn21_destroy_resource_pool,
 	.link_enc_create = dcn21_link_encoder_create,
-	.panel_create = dcn21_panel_create,
+	.panel_cntl_create = dcn21_panel_cntl_create,
 	.validate_bandwidth = dcn21_validate_bandwidth,
 	.populate_dml_pipes = dcn21_populate_dml_pipes_from_context,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index cb1952ea3170..c7fd702a4a87 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -38,7 +38,7 @@
 #endif
 #include "dwb.h"
 #include "mcif_wb.h"
-#include "panel.h"
+#include "panel_cntl.h"
 
 #define MAX_CLOCK_SOURCES 7
 
@@ -93,8 +93,8 @@ struct clk_bw_params;
 struct resource_funcs {
 	void (*destroy)(struct resource_pool **pool);
 	void (*link_init)(struct dc_link *link);
-	struct panel*(*panel_create)(
-		const struct panel_init_data *panel_init_data);
+	struct panel_cntl*(*panel_cntl_create)(
+		const struct panel_cntl_init_data *panel_cntl_init_data);
 	struct link_encoder *(*link_enc_create)(
 			const struct encoder_init_data *init);
 	bool (*validate_bandwidth)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
similarity index 75%
rename from drivers/gpu/drm/amd/display/dc/inc/hw/panel.h
rename to drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 6a4f7f26f04c..5a75d035f1fa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -21,33 +21,33 @@
  *
  */
 /*
- * panel.h
+ * panel_cntl.h
  *
  *  Created on: Oct 6, 2015
  *      Author: yonsun
  */
 
-#ifndef DC_PANEL_H_
-#define DC_PANEL_H_
+#ifndef DC_PANEL_CNTL_H_
+#define DC_PANEL_CNTL_H_
 
 #include "dc_types.h"
 
-struct panel_funcs {
-	void (*destroy)(struct panel **panel);
-	void (*hw_init)(struct panel *panel);
-	bool (*is_panel_backlight_on)(struct panel *panel);
-	bool (*is_panel_powered_on)(struct panel *panel);
+struct panel_cntl_funcs {
+	void (*destroy)(struct panel_cntl **panel_cntl);
+	void (*hw_init)(struct panel_cntl *panel_cntl);
+	bool (*is_panel_backlight_on)(struct panel_cntl *panel_cntl);
+	bool (*is_panel_powered_on)(struct panel_cntl *panel_cntl);
 };
 
-struct panel_init_data {
+struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
 };
 
-struct panel {
-	const struct panel_funcs *funcs;
+struct panel_cntl {
+	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
 };
 
-#endif /* DC_PANEL_H_ */
+#endif /* DC_PANEL_CNTL_H_ */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
