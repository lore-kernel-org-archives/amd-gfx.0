Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50050C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0BC10E6DF;
	Fri,  3 Mar 2023 15:50:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AD910E6DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdTa+l1bAnErOe2E/eZg7kum1MKsIeszKlruS1IKcgJW+tTiN8vz4cOhZb306p/vyyOhkb5s1Nt3ku4y8ecAx2e7/ofLsengRmkTdp2T3N3mCZnnXyfQKxIALDt1RKd6+hV2BE7Y/eWleekXpnY6oMOEiQ/W+437rkMnb0h6A5xfGP/S8+S0F7rZrFir+dithxg36jTqrGNojCF9xvOG5GsgpYg0hUDijqbjPxDkB23fpG+c8MS/0J4JBDuRBaHEPtFWi2UmEtexUizvnxBicGOAq3n7uqwD1eTFCMqnkzqPVJXRwbRaxoKvkLHRIpoIq1h9xxbHXcZk9mJWvZLkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQhJx9mhZtNXdLyZycHC19NdAxtMueLGWnifCnB90pY=;
 b=G9B3QKXrNARP9kaWdlMpFU/Snqkleuusk/sE6pZ1CagOOlYM669zj210R0eNkh6NURXMqS0xuXkVsTH9QrXg4QHIILXeHyNoOLaUv2O0jbv79P1mc3uWMIGTweJSJRSGmRYjO6PItioaJqPIlwtodPCUDhZyXZ9FHf7sRhuj7GRG4P/yUaWq0IVLXUTAbhlePFHBaRXm6zOehkcA5kNAlrKoY9cPrXJ0z7l/0ChUWGZopfZX3PlEDnm8BuvnuJh0E1QSNPxEdrcTg2fhtUKORgqTkbkw8ea9ZegGNZhQAFxH2hxflq8SWYh0mCLysyPg8n5r4wA0iY5wVn6UWMbtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQhJx9mhZtNXdLyZycHC19NdAxtMueLGWnifCnB90pY=;
 b=gU+kT1zxHZqgbG5jyM+T6DXwgw4x58X0BvtqXwdL/lbJO7E7QKkS2ydlh3TgKMdK8CRJhIBDlMmljh+ZKfFEGTKqBLXovHb7QqDPv+889MYaJjqRhIFE/5l2YYQWyEHbe8lBgxie9uc9OsgmKiJC0BwQhnhGALIF4b7lk0mkEM8=
Received: from DS7PR03CA0038.namprd03.prod.outlook.com (2603:10b6:5:3b5::13)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 15:50:24 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::a6) by DS7PR03CA0038.outlook.office365.com
 (2603:10b6:5:3b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:50:24 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:50:09 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: Drop unnecessary DCN guards
Date: Fri, 3 Mar 2023 10:40:10 -0500
Message-ID: <20230303154022.2667-22-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: e263dc05-6549-4473-ae73-08db1bff007c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T60WsHZWqVP9+6id/439PYU5ffkqQnMGh9Vpk0T8OWtm/3kqvK4Im+WX3XDrMQ8Ly651vEEmpXtGSvZ0OHdOUs80Oxd+b7qJ6BnP2RtvLsFMRYdUS9n/6uhzGiYqvp+zYpeGUklfREID4kcaJpwvObHrV95inCBWUu1OP/3H3ZFa4KBkLua0Fvr8wROHm+sCvJeiLUt7F0Ld0iYatV1BIvyb30NHEzZGrBZyXMcPKlk6KQAgv9jKrExnIPFniSab6Tk2926W5PlkV5fabJQ9IyNkzuhiwFJfBTM5uvR7vjKS+uZQEjelkrZULsO9ALWJVtS4lzNUnrThv7kW9SOPird1ebrbLOvkypF8KT7dpdwCMORrJr+bjt1ZZn4kEkFM6Le8W8Rx/LT0wAqxIYW8KVJXp1HmeFLDFLvxQYGjDUERxSVO/AI7mbajbZSRjS1wCBcS+7GxaoCgGJgnC24dTPjdWogdgfDXOMvVVUEu5as09kBkQXW5Mfb7dlB4aXth+0n5Mq7GbWnfe7cRzuhmJhH/2lhvELt6zTJPQSlpaHykzhg/S7KKGvHNVcEvtRvP1EqwoX3dDjwPtBYggOEwA2dQish0yp9PAWr+iumrUYG739OgX/H3TxLeFNGg6ZhU+1t70byFaklct2MMNaJy2P4HtM4uSM6SrUYEVhVMZPnvvSBI81i9Y11kJRyhGg2IFi6pvQrjsuuHpRpGpYuBL9yhB/iIiKKjoThzhzmXv9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(316002)(82310400005)(70206006)(44832011)(40480700001)(86362001)(41300700001)(6916009)(36860700001)(4326008)(36756003)(5660300002)(81166007)(356005)(8936002)(82740400003)(8676002)(54906003)(70586007)(478600001)(2906002)(6666004)(30864003)(16526019)(426003)(40460700003)(26005)(83380400001)(336012)(186003)(47076005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:50:24.1057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e263dc05-6549-4473-ae73-08db1bff007c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
DC is littered with many DCN guards that are not needed.
Drop them.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/core/dc_vm_helper.c    |  2 --
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 --
 .../drm/amd/display/dc/dce/dce_clock_source.c | 27 ++++++++++---------
 .../drm/amd/display/dc/dce/dce_clock_source.h |  6 -----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |  5 ----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h  |  4 ---
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  3 +--
 .../amd/display/dc/dcn303/dcn303_resource.c   |  2 --
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 --
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  3 ---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  6 -----
 .../drm/amd/display/dc/link/link_validation.c |  2 --
 .../dc/link/protocols/link_dp_training.c      |  2 --
 .../link/protocols/link_edp_panel_control.c   |  5 ----
 .../amd/display/modules/power/power_helpers.c |  7 -----
 15 files changed, 16 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index cde8ed2560b3..eda2152dcd1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,9 +47,7 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_z10_save_init(dc);
-#endif
 	}
 
 	return num_vmids;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 7f27e29fae11..027f6ebe0496 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -421,7 +421,6 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	}
 }
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 /**
  * populate_subvp_cmd_drr_info - Helper to populate DRR pipe info for the DMCUB subvp command
  *
@@ -776,7 +775,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 }
-#endif
 
 bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *diag_data)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 165392380842..67e3df7e1b05 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -930,7 +930,13 @@ static bool dce112_program_pix_clk(
 		REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
 
 		/* Enable DTO */
-		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
+			REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1,
+					PIPE0_DTO_SRC_SEL, 1);
+		else
+			REG_UPDATE(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1);
 		return true;
 	}
 	/* First disable SS
@@ -995,7 +1001,6 @@ static bool dcn31_program_pix_clk(
 			REG_WRITE(PHASE[inst], pll_settings->actual_pix_clk_100hz * 100);
 			REG_WRITE(MODULO[inst], dp_dto_ref_khz * 1000);
 		}
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		/* Enable DTO */
 		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
 			if (encoding == DP_128b_132b_ENCODING)
@@ -1009,9 +1014,6 @@ static bool dcn31_program_pix_clk(
 		else
 			REG_UPDATE(PIXEL_RATE_CNTL[inst],
 					DP_DTO0_ENABLE, 1);
-#else
-		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
-#endif
 	} else {
 		if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
 			unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
@@ -1023,7 +1025,6 @@ static bool dcn31_program_pix_clk(
 			REG_WRITE(MODULO[inst], dp_dto_ref_100hz);
 
 			/* Enable DTO */
-	#if defined(CONFIG_DRM_AMD_DC_DCN)
 			if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
 				REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
 						DP_DTO0_ENABLE, 1,
@@ -1031,17 +1032,12 @@ static bool dcn31_program_pix_clk(
 			else
 				REG_UPDATE(PIXEL_RATE_CNTL[inst],
 						DP_DTO0_ENABLE, 1);
-	#else
-			REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
-	#endif
 			return true;
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
 			REG_UPDATE(PIXEL_RATE_CNTL[inst],
 					PIPE0_DTO_SRC_SEL, 0);
-#endif
 
 		/*ATOMBIOS expects pixel rate adjusted by deep color ratio)*/
 		bp_pc_params.controller_id = pix_clk_params->controller_id;
@@ -1274,7 +1270,14 @@ static bool dcn3_program_pix_clk(
 			REG_WRITE(PHASE[inst], pll_settings->actual_pix_clk_100hz * 100);
 			REG_WRITE(MODULO[inst], dp_dto_ref_khz * 1000);
 		}
-		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
+		/* Enable DTO */
+		if (clk_src->cs_mask->PIPE0_DTO_SRC_SEL)
+			REG_UPDATE_2(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1,
+					PIPE0_DTO_SRC_SEL, 1);
+		else
+			REG_UPDATE(PIXEL_RATE_CNTL[inst],
+					DP_DTO0_ENABLE, 1);
 	} else
 		// For other signal types(HDMI_TYPE_A, DVI) Driver still to call VBIOS Command table
 		dce112_program_pix_clk(clock_source, pix_clk_params, encoding, pll_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index aaf33c79b09b..f600b7431e23 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -204,23 +204,17 @@
 	type DP_DTO0_MODULO; \
 	type DP_DTO0_ENABLE;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #define CS_REG_FIELD_LIST_DCN32(type) \
 	type PIPE0_DTO_SRC_SEL;
-#endif
 
 struct dce110_clk_src_shift {
 	CS_REG_FIELD_LIST(uint8_t)
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	CS_REG_FIELD_LIST_DCN32(uint8_t)
-#endif
 };
 
 struct dce110_clk_src_mask{
 	CS_REG_FIELD_LIST(uint32_t)
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	CS_REG_FIELD_LIST_DCN32(uint32_t)
-#endif
 };
 
 struct dce110_clk_src_regs {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
index b6391a5ead78..365a3215f6d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
@@ -23,8 +23,6 @@
  *
  */
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 #include "reg_helper.h"
 #include "resource.h"
 #include "dwb.h"
@@ -129,6 +127,3 @@ void dcn10_dwbc_construct(struct dcn10_dwbc *dwbc10,
 	dwbc10->dwbc_shift = dwbc_shift;
 	dwbc10->dwbc_mask = dwbc_mask;
 }
-
-
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
index d56ea7c8171e..5268c46ae907 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
@@ -24,8 +24,6 @@
 #ifndef __DC_DWBC_DCN10_H__
 #define __DC_DWBC_DCN10_H__
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 /* DCN */
 #define BASE_INNER(seg) \
 	DCE_BASE__INST0_SEG ## seg
@@ -267,5 +265,3 @@ void dcn10_dwbc_construct(struct dcn10_dwbc *dwbc10,
 		int inst);
 
 #endif
-
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 3c451ab5d3ca..2e5f8dc401ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -1470,10 +1470,9 @@ void enc1_se_hdmi_audio_setup(
 void enc1_se_hdmi_audio_disable(
 	struct stream_encoder *enc)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (enc->afmt && enc->afmt->funcs->afmt_powerdown)
 		enc->afmt->funcs->afmt_powerdown(enc->afmt);
-#endif
+
 	enc1_se_enable_audio_clock(enc, false);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 31e212064168..727f458f6ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1163,7 +1163,6 @@ static bool dcn303_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc->caps.mall_size_per_mem_channel = 4;
 	/* total size = mall per channel * num channels * 1024 * 1024 */
 	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel *
@@ -1171,7 +1170,6 @@ static bool dcn303_resource_construct(
 				   1024 * 1024;
 	dc->caps.cursor_cache_size =
 		dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
-#endif
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 899105da0433..d0303173ce80 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -23,7 +23,6 @@
  *
  */
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 #include "dc.h"
 #include "../display_mode_lib.h"
 #include "display_mode_vba_30.h"
@@ -6634,4 +6633,3 @@ static noinline_for_stack void UseMinimumDCFCLK(
 	}
 }
 
-#endif /* CONFIG_DRM_AMD_DC_DCN */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 8179be1f34bb..cd3cfcb2a2b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -23,8 +23,6 @@
  *
  */
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
-
 #include "../display_mode_lib.h"
 #include "../display_mode_vba.h"
 #include "../dml_inline_defs.h"
@@ -1792,4 +1790,3 @@ void dml30_rq_dlg_get_dlg_reg(struct display_mode_lib *mode_lib,
 	dml_print("DML_DLG: Calculation for pipe[%d] end\n", pipe_idx);
 }
 
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index b982be64c792..42f7081cf3b3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -53,9 +53,7 @@ enum dwb_source {
 /* DCN1.x, DCN2.x support 2 pipes */
 enum dwb_pipe {
 	dwb_pipe0 = 0,
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dwb_pipe1,
-#endif
 	dwb_pipe_max_num,
 };
 
@@ -72,14 +70,11 @@ enum wbscl_coef_filter_type_sel {
 };
 
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 enum dwb_boundary_mode {
 	DWBSCL_BOUNDARY_MODE_EDGE  = 0,
 	DWBSCL_BOUNDARY_MODE_BLACK = 1
 };
-#endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 enum dwb_output_csc_mode {
 	DWB_OUTPUT_CSC_DISABLE = 0,
 	DWB_OUTPUT_CSC_COEF_A = 1,
@@ -132,7 +127,6 @@ struct dwb_efc_display_settings {
 	unsigned int	dwbOutputBlack;	// 0 - Normal, 1 - Output Black
 };
 
-#endif
 struct dwb_warmup_params {
 	bool	warmup_en;	/* false: normal mode, true: enable pattern generator */
 	bool	warmup_mode;	/* false: 420, true: 444 */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index b29f62337ba0..2ab23bdf5a89 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -261,13 +261,11 @@ uint32_t link_timing_bandwidth_kbps(
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (timing->flags.DSC)
 		return dc_dsc_stream_bandwidth_in_kbps(timing,
 				timing->dsc_cfg.bits_per_pixel,
 				timing->dsc_cfg.num_slices_h,
 				timing->dsc_cfg.is_dp);
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 	switch (timing->display_color_depth) {
 	case COLOR_DEPTH_666:
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 4a3758ea04f5..eee1853f6b32 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -723,12 +723,10 @@ void override_training_settings(
 	if (link->preferred_training_settings.fec_enable != NULL)
 		lt_settings->should_set_fec_ready = *link->preferred_training_settings.fec_enable;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Check DP tunnel LTTPR mode debug option. */
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->dc->debug.dpia_debug.bits.force_non_lttpr)
 		lt_settings->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 
-#endif
 	dp_get_lttpr_mode_override(link, &lt_settings->lttpr_mode);
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index eaafa00a7b9f..4d78ac932845 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -695,7 +695,6 @@ bool edp_setup_psr(struct dc_link *link,
 	psr_context->psr_level.u32all = 0;
 
 	/*skip power down the single pipe since it blocks the cstate*/
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (link->ctx->asic_id.chip_family >= FAMILY_RV) {
 		switch (link->ctx->asic_id.chip_family) {
 		case FAMILY_YELLOW_CARP:
@@ -709,10 +708,6 @@ bool edp_setup_psr(struct dc_link *link,
 			break;
 		}
 	}
-#else
-	if (link->ctx->asic_id.chip_family >= FAMILY_RV)
-		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
-#endif
 
 	/* SMU will perform additional powerdown sequence.
 	 * For unsupported ASICs, set psr_level flag to skip PSR
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e39b133d05af..fa469de3e935 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -678,13 +678,8 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 	bool result = false;
 	uint32_t i, j = 0;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (res_pool->abm == NULL && res_pool->multiple_abms[inst] == NULL)
 		return false;
-#else
-	if (res_pool->abm == NULL)
-		return false;
-#endif
 
 	memset(&ram_table, 0, sizeof(ram_table));
 	memset(&config, 0, sizeof(config));
@@ -737,12 +732,10 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 
 	config.min_abm_backlight = ram_table.min_abm_backlight;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (res_pool->multiple_abms[inst]) {
 		result = res_pool->multiple_abms[inst]->funcs->init_abm_config(
 			res_pool->multiple_abms[inst], (char *)(&config), sizeof(struct abm_config_table), inst);
 	} else
-#endif
 		result = res_pool->abm->funcs->init_abm_config(
 			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table), 0);
 
-- 
2.34.1

