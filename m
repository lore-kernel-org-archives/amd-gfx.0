Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FAC433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04F26509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04F26509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AF56EC46;
	Fri,  5 Mar 2021 20:05:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A896B6EC41
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLUuTlgTwMIGB+rcxIt7qMz4qMEGgWa2ZlAoMvZZCucm01wZDq4r97ZosVAvJ9HZS1IVFrua4jsQNQBwPkPzDVvLS2F+CxOh1DZwKjznMV0aEJerR34iPqEhSt2s8NGQ+UPS0YNT56aQI+lqUEyWQMSmOt0ZWLFp9+t8F9sy6zsVzIH35vn1wC35GTbYtBWPxc+UsakX+Swou2115AoezoBb9Qw4Id6Ra02btSNFmduFvsEClXDxUb8A+UpBZ5aqLlMivpW4gFOB5E6tYX1OdeR9zkumuIA9uPYHqfWfkHDclF414J6XPElsq1KigaR6hyRyRZPSyoXYA1udN3KjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM3fOJjh+brT/IubipTkozErEME2Yt+sV9eiSMtTCHQ=;
 b=XEP0AuIVn7mzfL1hE092js/cIsJ7LmYW2FnILA3hT77L+ztVJhaL6zAeaPDwZLqTEqGVOruth4NAuldQ92ib93GP7chih/KwreltGXEhTPVyPSm2dM58q+eshINI/7T5IB9AXOSvb9+GkbFmZ6W5doGAQhGIsrLkIiOWJbrfAzzRsJzyaZkBWNfnKbCQEY/xYvQkkeSoLZo1+J6Jhl0bWSp8x4gnh8oT/Tztgqvz3nXakmHDVsOMh2b0tpW1Gk1cOwCPgv+tTH2Ep336orJSXtbVu5x/zpSBQm3KS2YWqc6skj0GEurWvHhCB68W2QkhmaTrAKSzR9M3ptYPkSvrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM3fOJjh+brT/IubipTkozErEME2Yt+sV9eiSMtTCHQ=;
 b=Stuut5Ypq/M2+5oNSzX/pB8xzs5M2eXmiY/ehTQbbh3ga07nWxfGSqJsZ+E/5sn4dkVKBsa5xLjYWXsKcepCLuEzAHQ4toTLM2+KiBqId38iCJif1TAbuDVEbzbDujHMQo7AyVwcHHKUtnQaltc6yDH1rY0yRwuyLrB657jOP9I=
Received: from DM5PR12CA0059.namprd12.prod.outlook.com (2603:10b6:3:103::21)
 by DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 20:04:58 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::15) by DM5PR12CA0059.outlook.office365.com
 (2603:10b6:3:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:54 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:54 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:48 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: Added multi instance support for panel
 control
Date: Fri, 5 Mar 2021 15:02:58 -0500
Message-ID: <20210305200301.17696-12-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f71d4346-d2d5-412f-9984-08d8e011f317
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0025680929FF5D07458E3108E5969@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/pE+hzijNyDc7CwQuWMNOqzOOIS3x3hBgnXbxEWHFS1xtGfq8wQw6OtMb2vR7sFfXyHwAyYNjuBLtdj1HVv87F5Vv+HJ/6LVW5xrwuyCIxPsmSt1XLhb8BlNz2szqj45Y/VpM434lM4BYI/demWYkh8XE2uK83dvvnGsT/ddyB4lLwgahh1fcsa3PCs0nbdacPMsNBQBU2hYIXMj/K1NswsCvsVQzPDqou3CD97j98XT3A50653MS5surIsm5MYQwHjegJEHK6/iZA5iEloM9EVm+FCmZKrIXqositSeGd1L3NIydXyFuQZP9XJ7iu3RQhsBcaHlJaPy+annmzB+3BCOc0uuG0H2mrugnaNknkpVkHC1x5e3xg5qxuIaYRp9/9Gyu+OxsbPUJFFG3SnXCh0RgCngNZNiuKMo9Szc9Axck8RjXfRpStAALkoLIdaFYR+hyakIS/6lOsm+BFbWS3LLPrOMPKapv+sxr2OjeWIJVeT7/CPsleUU7m5YEn2oYhwb5Mvl/xBZ1QkqS20+pyjIOUSudggN2gb6yfEM7b+f5QPMUUgEnwa55MfygJ1+nU9BPJICQ5pcw61hKTUIQwKaqnIjNq7biogg+q6zSxtlYOQ8S3K27moxu7bc/B2OPFVZBU3SdaJYhU8O7PkqFBmbYZNHN1wO0F4wqfDcgIw1iBkWof1DZ3Ve+c+4sm6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(478600001)(5660300002)(316002)(1076003)(47076005)(86362001)(54906003)(44832011)(336012)(4326008)(426003)(26005)(186003)(2616005)(70586007)(70206006)(81166007)(2906002)(8936002)(6666004)(82740400003)(356005)(83380400001)(8676002)(36756003)(6916009)(82310400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:56.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71d4346-d2d5-412f-9984-08d8e011f317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
Panel control always programs instance 0. With multi eDP we need to
support multiple instances.

[How]
Use link index to set different instances for panel control.
Refactored LVTMA control to support multiple instances.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  5 +++--
 .../drm/amd/display/dc/bios/command_table2.c  | 21 ++++++++++++-------
 .../drm/amd/display/dc/bios/command_table2.h  |  3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  3 ++-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 17 ++++++++++-----
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9f9fda3118d1..b208f06ed514 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1180,14 +1180,15 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
-	uint8_t uc_pwr_on)
+	uint8_t uc_pwr_on,
+	uint8_t panel_instance)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance);
 }
 
 static bool bios_parser_is_accelerated_mode(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index fa5271a4598e..f1f672a997d7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -981,7 +981,8 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
-	uint8_t uc_pwr_on);
+	uint8_t uc_pwr_on,
+	uint8_t panel_instance);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
 {
@@ -992,19 +993,21 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
-	uint8_t uc_pwr_on)
+	uint8_t uc_pwr_on,
+	uint8_t panel_instance)
 {
 
 	union dmub_rb_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
 
-	cmd.cmd_common.header.type = DMUB_CMD__VBIOS;
-	cmd.cmd_common.header.sub_type =
+	cmd.lvtma_control.header.type = DMUB_CMD__VBIOS;
+	cmd.lvtma_control.header.sub_type =
 			DMUB_CMD__VBIOS_LVTMA_CONTROL;
-	cmd.cmd_common.cmd_buffer[0] =
+	cmd.lvtma_control.data.uc_pwr_action =
 			uc_pwr_on;
-
+	cmd.lvtma_control.data.panel_inst =
+			panel_instance;
 	dc_dmub_srv_cmd_queue(dmcub, &cmd);
 	dc_dmub_srv_cmd_execute(dmcub);
 	dc_dmub_srv_wait_idle(dmcub);
@@ -1013,14 +1016,16 @@ static void enable_lvtma_control_dmcub(
 
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
-	uint8_t uc_pwr_on)
+	uint8_t uc_pwr_on,
+	uint8_t panel_instance)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
 	if (bp->base.ctx->dc->ctx->dmub_srv &&
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
-				uc_pwr_on);
+				uc_pwr_on,
+				panel_instance);
 		return BP_RESULT_OK;
 	}
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index 7bdce013cde5..be060b4b87db 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -95,7 +95,8 @@ struct cmd_tbl {
 	unsigned int (*get_smu_clock_info)(
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
-			uint8_t uc_pwr_on);
+			uint8_t uc_pwr_on,
+			uint8_t panel_instance);
 };
 
 void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa9a62dc174b..1bb2be7465ad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1506,7 +1506,7 @@ static bool dc_link_construct(struct dc_link *link,
 		(link->link_id.id == CONNECTOR_ID_EDP ||
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst = 0;
+		panel_cntl_init_data.inst = link->link_index;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 509d23fdd3c9..86ab8f16f621 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -139,7 +139,8 @@ struct dc_vbios_funcs {
 
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
-		uint8_t uc_pwr_on);
+		uint8_t uc_pwr_on,
+		uint8_t panel_instance);
 
 	enum bp_result (*get_soc_bb_info)(
 		struct dc_bios *dcb,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ddabc205bcfc..08047802d040 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -797,6 +797,7 @@ void dce110_edp_power_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result bp_result;
+	uint8_t panel_instance;
 
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -807,7 +808,6 @@ void dce110_edp_power_control(
 
 	if (!link->panel_cntl)
 		return;
-
 	if (power_up !=
 		link->panel_cntl->funcs->is_panel_powered_on(link->panel_cntl)) {
 
@@ -880,15 +880,18 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
+		panel_instance = link->panel_cntl->inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
 			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON)
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-						LVTMA_CONTROL_POWER_ON);
+						LVTMA_CONTROL_POWER_ON,
+						panel_instance);
 			else
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-						LVTMA_CONTROL_POWER_OFF);
+						LVTMA_CONTROL_POWER_OFF,
+						panel_instance);
 		}
 
 		bp_result = link_transmitter_control(ctx->dc_bios, &cntl);
@@ -963,6 +966,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
+	uint8_t panel_instance;
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
@@ -1011,6 +1015,7 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
+	panel_instance = link->panel_cntl->inst;
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 		edp_receiver_ready_T7(link);
 
@@ -1018,10 +1023,12 @@ void dce110_edp_backlight_control(
 			ctx->dc->debug.dmub_command_table) {
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-					LVTMA_CONTROL_LCD_BLON);
+					LVTMA_CONTROL_LCD_BLON,
+					panel_instance);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
-					LVTMA_CONTROL_LCD_BLOFF);
+					LVTMA_CONTROL_LCD_BLOFF,
+					panel_instance);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
