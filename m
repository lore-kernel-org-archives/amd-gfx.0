Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE12C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C41A10E876;
	Fri,  1 Dec 2023 13:28:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AD810E879
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DytLQd4WLuy7GuvOC+GYFT5HLwkFofT19gXmCBgDT/69IByu14H3MzivSoaFWluS7ZSR21L3qxN8RboDrEGTyWEKHh7Q85R22wqOKs6W3jAOw2SQhIfrzSYOkmcZx2/e+8s1i4FQtAlgqEljF0KIK8+b4EdtdpHHe5a4TZhikKm63d2RrtdOKa989iXg4Dw6VvY2e44ENRLf3J9eesd8O8W+CWvCKkLQOdt4m2ZHHVmLe6Fs9K3ZiUt6lrYo/6NCxgcjuTMmlFhur+elYbK6iBaFAZheOSymVrD8DbAkBV+rvzKsGT2Ty9Fx0smk/YNZ5yFwe8BIC2qupmMUoHEslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV7Y0iFRWe9gXdjBhb3/BuqUHrDrcnJTudbKlFm3ucM=;
 b=ZGl7yOPgiQfMXOf4AHkhzcovEZcgYAuD+zZEfoJTxJttopB0DRiDCo7MYvXT0wSmWLX78fT9excRZ9WT+wA9rAyD6llLYOaSEgbXHE3FHz8x0EzNKH0yJTyhResz1eMi30fxvK/9BPX5H6tzY4IdvD3nW5psICFSfxlPzX1KLeyushVbpPSuHDdqxn+ipzKrIT7kygxIJyGN/+D8bga+sV+h6HKEKTP+KtmzQsqELq9lJ0k28mSStutRtZ97NnZ+UFaF9OeWqy0o+ASy6wQp9GHmXjUFWdUGraDX7xVCmYyoSfvHTxIZG3U3X9YBb3DH7pUvc3DV1QUCH+vhYC5vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV7Y0iFRWe9gXdjBhb3/BuqUHrDrcnJTudbKlFm3ucM=;
 b=P4l2EONbTlgEGIxnNR+7nnlcIcwM66GGOvkdIFI+Dby3TYYckC0Y1tX80vk8rrRMOAF+h9TfbnnJTyKBf6Y6AJ4Xkz04XRkb+gkvaO0nYnn2VFEEeVYxx6kbhc3qyGc3BVkL4tLViN/j+gVCT/ZQti+KHH1QdFXHSDQgAecq6VY=
Received: from BYAPR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:40::22)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:28:08 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::35) by BYAPR04CA0009.outlook.office365.com
 (2603:10b6:a03:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:04 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/47] drm/amd/display: Pass pwrseq inst for backlight and ABM
Date: Fri, 1 Dec 2023 06:25:02 -0700
Message-ID: <20231201132731.2354141-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 191947bc-1184-41dc-abc0-08dbf2715afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20TBMKEfCisU4n6BlbXOTZ1ZdkfmWl8pI6Z39JnqkeUCQKKL5/y5YNmn0Vpk19qZGWatCQ2I7efGe2P7BzNXJM8V/1ea1H26QBIodWmIS2sJ5qFLDZSxp/J8j8iYUDXgOjblPNP+fsgU8ZDOH5FQVe2bHrSiz1+LXbt+2fKo+wi8SZnd8PY/0QdW9Iwc0FNxUnmXjr4B1vtuoJaBh5DyZxS/TL/ccb4zv/XvRhOoNvdeldpfxVpNfhO+y41TGtQSkyROzORHBoBeqFKiMDbbchhPVhOnHBe3/2QgUF+Y0MW+jBvU0H0wbuQsokBipoS8eLObxdntSE3c88kqODRP7w39VCQCHDC7/HdHaOg6t1JYiuA5pQWWTnyIh3a/b8kkx+TaK0okDkvNu3EUjzdk7/t/RIt9t3eoh8EBtZ4E3GfWqlTiykSSU3RVMx2h2FLm8N5vzIqDlTrEBqkhz8YFvINEBEwGHGjcmw/skhY2vahgTNp9BzlXRCA9c83itBEoC2T65cU8ETOWjmjPgIH/LCL6SRSZPDaqCLy5Cc2RxjmlS/TybkB2sCCSAHB1BMVmtzC/PiAo4Cx74WXIS8QEKiNV2d02XNBL3ZEFglv5U5y0fRlFBjo9eTqIVOqNuHybtdNMTEXrld4SCst81f0fiZqOWiDl7fxIAospSVQc5a80lG+yUegHLr/oahHwWKX2RK2Ksxz+oEJirQWmGGpXETrKOLvPt6JT7JF09ZVX6n2p9kw2Rl4d4isG2MNdAkAjNVpS0WZALhZjA38p39K9vzFfayKEfj+fg+cZzf4KIevfhdVPOSI14TQDyqEqgiih
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(70586007)(6916009)(70206006)(81166007)(1076003)(82740400003)(356005)(36756003)(86362001)(54906003)(47076005)(83380400001)(336012)(26005)(2616005)(36860700001)(426003)(4326008)(5660300002)(16526019)(2906002)(478600001)(316002)(8936002)(8676002)(30864003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:07.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191947bc-1184-41dc-abc0-08dbf2715afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
Cc: stylon.wang@amd.com, Lewis Huang <lewis.huang@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Phil Hsieh <phil.hsieh@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <lewis.huang@amd.com>

[Why]
OTG inst and pwrseq inst mapping is not align therefore we cannot use
otg_inst as pwrseq inst to get DCIO register.

[How]
1. Pass the correct pwrseq instance to dmub when set abm pipe.
2. LVTMA control index change from panel_inst to pwrseq_inst.

Reviewed-by: Phil Hsieh <phil.hsieh@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  4 +-
 .../drm/amd/display/dc/bios/command_table2.c  | 12 ++--
 .../drm/amd/display/dc/bios/command_table2.h  |  2 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  8 ++-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  7 ++-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  2 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 16 ++---
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 36 ++++++++---
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  3 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  2 +
 .../drm/amd/display/dc/link/link_factory.c    | 59 +++++++++++++------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 14 ++++-
 14 files changed, 119 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 7cdb1a8a0ba0..2fb804eb5702 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1691,7 +1691,7 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
@@ -1699,7 +1699,7 @@ static enum bp_result bios_parser_enable_lvtma_control(
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_panel_control_wait);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, pwrseq_instance, bypass_panel_control_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 90a02d7bd3da..ab0adabf9dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -976,7 +976,7 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
@@ -989,7 +989,7 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 
@@ -1002,8 +1002,8 @@ static void enable_lvtma_control_dmcub(
 			DMUB_CMD__VBIOS_LVTMA_CONTROL;
 	cmd.lvtma_control.data.uc_pwr_action =
 			uc_pwr_on;
-	cmd.lvtma_control.data.panel_inst =
-			panel_instance;
+	cmd.lvtma_control.data.pwrseq_inst =
+			pwrseq_instance;
 	cmd.lvtma_control.data.bypass_panel_control_wait =
 			bypass_panel_control_wait;
 	dm_execute_dmub_cmd(dmcub->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
@@ -1012,7 +1012,7 @@ static void enable_lvtma_control_dmcub(
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance,
+	uint8_t pwrseq_instance,
 	uint8_t bypass_panel_control_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
@@ -1021,7 +1021,7 @@ static enum bp_result enable_lvtma_control(
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
-				panel_instance,
+				pwrseq_instance,
 				bypass_panel_control_wait);
 		return BP_RESULT_OK;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index b6d09bf6cf72..41c8c014397f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -96,7 +96,7 @@ struct cmd_tbl {
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
-			uint8_t panel_instance,
+			uint8_t pwrseq_instance,
 			uint8_t bypass_panel_control_wait);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index be9aa1a71847..26940d94d8fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,7 +140,7 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
-		uint8_t panel_instance,
+		uint8_t pwrseq_instance,
 		uint8_t bypass_panel_control_wait);
 
 	enum bp_result (*get_soc_bb_info)(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index d3e6544022b7..930fd929e93a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -145,7 +145,11 @@ static bool dmub_abm_save_restore_ex(
 	return ret;
 }
 
-static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe_ex(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	bool ret = false;
 	unsigned int feature_support;
@@ -153,7 +157,7 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm, uint32_t otg_inst, uint32_t op
 	feature_support = abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
-		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst);
+		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 592a8f7a1c6d..42c802afc468 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -254,7 +254,11 @@ bool dmub_abm_save_restore(
 	return true;
 }
 
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+bool dmub_abm_set_pipe(struct abm *abm,
+		uint32_t otg_inst,
+		uint32_t option,
+		uint32_t panel_inst,
+		uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -264,6 +268,7 @@ bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
index 853564d7f471..07ea6c8d414f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h
@@ -44,7 +44,7 @@ bool dmub_abm_save_restore(
 		struct dc_context *dc,
 		unsigned int panel_inst,
 		struct abm_save_restore *pData);
-bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst);
+bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst);
 bool dmub_abm_set_backlight_level(struct abm *abm,
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 217acd4e292a..d849b1eaa4a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -50,7 +50,7 @@ static bool dcn31_query_backlight_info(struct panel_cntl *panel_cntl, union dmub
 	cmd->panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd->panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO;
 	cmd->panel_cntl.header.payload_bytes = sizeof(cmd->panel_cntl.data);
-	cmd->panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd->panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 
 	return dm_execute_dmub_cmd(dc_dmub_srv->ctx, cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 }
@@ -78,7 +78,7 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
 	cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_HW_INIT;
 	cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-	cmd.panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd.panel_cntl.data.pwrseq_inst = dcn31_panel_cntl->base.pwrseq_inst;
 	cmd.panel_cntl.data.bl_pwm_cntl = panel_cntl->stored_backlight_registers.BL_PWM_CNTL;
 	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
 	cmd.panel_cntl.data.bl_pwm_ref_div1 =
@@ -157,4 +157,5 @@ void dcn31_panel_cntl_construct(
 	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
 	dcn31_panel_cntl->base.ctx = init_data->ctx;
 	dcn31_panel_cntl->base.inst = init_data->inst;
+	dcn31_panel_cntl->base.pwrseq_inst = init_data->pwrseq_inst;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 706a65a11124..abd780d92b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -790,7 +790,7 @@ void dce110_edp_power_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result bp_result;
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -873,7 +873,7 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
-		panel_instance = link->panel_cntl->inst;
+		pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
@@ -881,11 +881,11 @@ void dce110_edp_power_control(
 			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_ON,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			} else {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_OFF,
-						panel_instance, link->link_powered_externally);
+						pwrseq_instance, link->link_powered_externally);
 			}
 		}
 
@@ -956,7 +956,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
-	uint8_t panel_instance;
+	uint8_t pwrseq_instance;
 	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
 	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
@@ -1009,7 +1009,7 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	panel_instance = link->panel_cntl->inst;
+	pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -1034,11 +1034,11 @@ void dce110_edp_backlight_control(
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance, link->link_powered_externally);
+					pwrseq_instance, link->link_powered_externally);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 467812cf3368..08783ad097d2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -137,7 +137,8 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
-static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
+		uint32_t option, uint32_t panel_inst, uint32_t pwrseq_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
@@ -147,6 +148,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t optio
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
 	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
@@ -179,7 +181,6 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	struct abm *abm = pipe_ctx->stream_res.abm;
 	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
-
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 
 	if (dmcu) {
@@ -190,9 +191,13 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
 			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-			panel_cntl->inst);
+					panel_cntl->inst, panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+				dmub_abm_set_pipe(abm,
+						otg_inst,
+						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
@@ -212,9 +217,16 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 
 	if (abm && panel_cntl) {
 		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
 		} else {
-			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				dmub_abm_set_pipe(abm, otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 		}
 	}
 }
@@ -237,9 +249,17 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 
 		if (abm && panel_cntl) {
 			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+				abm->funcs->set_pipe_ex(abm,
+						otg_inst,
+						SET_ABM_PIPE_NORMAL,
+						panel_cntl->inst,
+						panel_cntl->pwrseq_inst);
 			} else {
-				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+					dmub_abm_set_pipe(abm,
+							otg_inst,
+							SET_ABM_PIPE_NORMAL,
+							panel_cntl->inst,
+							panel_cntl->pwrseq_inst);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 33db15d69f23..9f521cf0fc5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -64,7 +64,8 @@ struct abm_funcs {
 	bool (*set_pipe_ex)(struct abm *abm,
 			unsigned int otg_inst,
 			unsigned int option,
-			unsigned int panel_inst);
+			unsigned int panel_inst,
+			unsigned int pwrseq_inst);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 24af9d80b937..248adc1705e3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -56,12 +56,14 @@ struct panel_cntl_funcs {
 struct panel_cntl_init_data {
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 };
 
 struct panel_cntl {
 	const struct panel_cntl_funcs *funcs;
 	struct dc_context *ctx;
 	uint32_t inst;
+	uint32_t pwrseq_inst;
 	/* registers setting needs to be saved and restored at InitBacklight */
 	struct panel_cntl_backlight_registers stored_backlight_registers;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 6b306ea58b9b..5464d8d26bd3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -369,6 +369,30 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
+static uint8_t translate_dig_inst_to_pwrseq_inst(struct dc_link *link)
+{
+	uint8_t pwrseq_inst = 0xF;
+	struct dc_context *dc_ctx = link->dc->ctx;
+
+	DC_LOGGER_INIT(dc_ctx->logger);
+
+	switch (link->eng_id) {
+	case ENGINE_ID_DIGA:
+		pwrseq_inst = 0;
+		break;
+	case ENGINE_ID_DIGB:
+		pwrseq_inst = 1;
+		break;
+	default:
+		DC_LOG_WARNING("Unsupported pwrseq engine id: %d!\n", link->eng_id);
+		ASSERT(false);
+		break;
+	}
+
+	return pwrseq_inst;
+}
+
+
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -596,24 +620,6 @@ static bool construct_phy(struct dc_link *link,
 	link->ddc_hw_inst =
 		dal_ddc_get_line(get_ddc_pin(link->ddc));
 
-
-	if (link->dc->res_pool->funcs->panel_cntl_create &&
-		(link->link_id.id == CONNECTOR_ID_EDP ||
-			link->link_id.id == CONNECTOR_ID_LVDS)) {
-		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst =
-			panel_cntl_init_data.ctx->dc_edp_id_count;
-		link->panel_cntl =
-			link->dc->res_pool->funcs->panel_cntl_create(
-								&panel_cntl_init_data);
-		panel_cntl_init_data.ctx->dc_edp_id_count++;
-
-		if (link->panel_cntl == NULL) {
-			DC_ERROR("Failed to create link panel_cntl!\n");
-			goto panel_cntl_create_fail;
-		}
-	}
-
 	enc_init_data.ctx = dc_ctx;
 	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
 			      &enc_init_data.encoder);
@@ -644,6 +650,23 @@ static bool construct_phy(struct dc_link *link,
 	link->dc->res_pool->dig_link_enc_count++;
 
 	link->link_enc_hw_inst = link->link_enc->transmitter;
+
+	if (link->dc->res_pool->funcs->panel_cntl_create &&
+		(link->link_id.id == CONNECTOR_ID_EDP ||
+			link->link_id.id == CONNECTOR_ID_LVDS)) {
+		panel_cntl_init_data.ctx = dc_ctx;
+		panel_cntl_init_data.inst = panel_cntl_init_data.ctx->dc_edp_id_count;
+		panel_cntl_init_data.pwrseq_inst = translate_dig_inst_to_pwrseq_inst(link);
+		link->panel_cntl =
+			link->dc->res_pool->funcs->panel_cntl_create(
+								&panel_cntl_init_data);
+		panel_cntl_init_data.ctx->dc_edp_id_count++;
+
+		if (link->panel_cntl == NULL) {
+			DC_ERROR("Failed to create link panel_cntl!\n");
+			goto panel_cntl_create_fail;
+		}
+	}
 	for (i = 0; i < 4; i++) {
 		if (bp_funcs->get_device_tag(dc_ctx->dc_bios,
 					     link->link_id, i,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a365f6c096de..3c092064c72e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3498,6 +3498,16 @@ struct dmub_cmd_abm_set_pipe_data {
 	 * TODO: Remove.
 	 */
 	uint8_t ramping_boundary;
+
+	/**
+	 * PwrSeq HW Instance.
+	 */
+	uint8_t pwrseq_inst;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
 };
 
 /**
@@ -3878,7 +3888,7 @@ enum dmub_cmd_panel_cntl_type {
  * struct dmub_cmd_panel_cntl_data - Panel control data.
  */
 struct dmub_cmd_panel_cntl_data {
-	uint32_t inst; /**< panel instance */
+	uint32_t pwrseq_inst; /**< pwrseq instance */
 	uint32_t current_backlight; /* in/out */
 	uint32_t bl_pwm_cntl; /* in/out */
 	uint32_t bl_pwm_period_cntl; /* in/out */
@@ -3937,7 +3947,7 @@ struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
 	uint8_t bypass_panel_control_wait;
 	uint8_t reserved_0[2]; /**< For future use */
-	uint8_t panel_inst; /**< LVTMA control instance */
+	uint8_t pwrseq_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
 };
 
-- 
2.42.0

