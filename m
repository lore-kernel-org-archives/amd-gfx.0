Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E44C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E5310E61D;
	Tue, 10 Jan 2023 16:58:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1C710E61D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2XiCnugJeC/Gv0uIqzTv37c+1MtFcDMiYoY9NlGCib0cXgf7hvoEsANoOl+MCD8DcOztWk1r5ZE5Wu/HvGKe9OMrHjEePoD/LktjYHHrOJxq8aQvh2HBbM4FgXXC1a9lewOaMFnNpBamRJ4l7Lua9zlDLCANjSA025KW/qNaIzrtarCq3N9Nk81E39kKuQCwaxF8KU/RYWcLgXALTgJ8nylgKBDUxNVNaWNTLsUX3QkEyrZu6nvTXJMOH7VHNFm3/D4m/qLr3MywsdRpvr2UGf7haaHFmZDXxpSU+0P8BtsqN+30uws+/kqAdmd6KAtJF3p/DrGUkVTZ0YQ/C3l5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXx1LQe5e3Y/TiL+Jn0l+2SCZ/7RWs11I+mzKaiYk4g=;
 b=EmLRSJKJljoro7DRIENpxCy4x6S0KGEI8bJUrpi+j70FIZVDaAkocynXi8b5PfqzlW+J9sGdI5sMVvWyg/8fXpuyFVjDwHQ77Nnd0VCq5cChrjW2lo+0+vTNExfkK5GPjinDe8cYHmdq/nCRovRaqZwHtnyFBVLAXGA7mu6fTbEVmCG2evNeZYPzs7e+BGYFG/qED8fWGUNXebMez9+N88mMmO5Fd6QgADHot2M9VA/l4zWlBqkKBDZmQM7Nx8KzQPcbGQx0nSftE/H3NCqFnvD8PmlXsWr5XIR6jML6bNobW4/oZgJDvxehVWcZQNHSfLV/LATiT1+Tw2xTnlWhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXx1LQe5e3Y/TiL+Jn0l+2SCZ/7RWs11I+mzKaiYk4g=;
 b=OhhFzIolMuxchv4O98tzhzv8IlyWyXJjl1wrNaEZ7mL3gafV4rQT3tEfrAefgwq9sn2TOEOIS1GrUux2wDaPET3wf6H5fhhzAIbgmsmLR4bZEsm/EX3HSUfEN0+//6hqpsDRQpwjGplh8VSAhKk9zOpAZpLfnl80cQs1I9cBlI0=
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:53 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::b7) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:53 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:51 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/37] drm/amd/display: Skip backlight control delay on
 external powered links
Date: Tue, 10 Jan 2023 11:55:28 -0500
Message-ID: <20230110165535.3358492-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a91e6a-2af6-40ff-cfb6-08daf32bf450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvKi9ntPd1aFsdB+BbxGhIrt7i4pAFiK/1VxnCUo68zGsjEd3zWUP3YDmyQHIq8DuQL38gzeupnBWQ539SoPiVJ4FPChpyejwM25JnC3zEWtlcX6+cBz1VSLu2IYocJVgSa3KusNggINzNFsJM01Jv2S7S+S88jrdeJmWK2AsEKzhOuG+Tn0q6lKWminGEJYMetgKqBNsOTRfWZ+rbE3MFYrItTWreuANVNeGU9hnbuqVBc/YXV0atB3u9xjE4ynqUdbUvAMz6BTGax2F6akTx/UqlOHX0c7HhtdjH9Y7jO8mHiZzNcs9eojCawuj9KJM8Uzts+07jyn0MCp26WyPAzpV9p0a3CTMTslDzvTfOYpwrCbJUsNBzJObHeUvkXk3MvT4Z2DfgMGugyoi75SsUHagaaw93pX0zxY36g/8kpA5Eun67or2/8HNiVAaHVhfr65Wx86oVDToce8LGTdil19lJvfV6RMNFw8lQPKFObIU3cBQrVQjhhjmZW/H9w5XJYf0IoK161IFj9e/6Rfh2xHHcANxjhnSipawZLDybHf5QYqDvYWSrTJ6Prs4/3IP76OdPy9cmNFd+yf43ZhwjNf6QLWJb3q+eXXNKh7CRLoGay8hDwJqKNWSy9aa+gOoy9rJ/h4fOvsIW71r7bTfcy2zaZ24YRBg4PNydtJ29N4HLOR7EwBu6n+7/dxBi3AXYIYWnvShQjRQ4JlJ2f0Wrot0qhwTEEmBE9mWHMb2kyHgkvx8SpAJvtKgP1ADd3owyboKa2vd4kjzTL8Xmej6uj3JWjR75dnBAL0MOS+Syk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(26005)(16526019)(7696005)(6666004)(478600001)(186003)(54906003)(2616005)(336012)(70206006)(70586007)(36756003)(6916009)(41300700001)(8676002)(4326008)(316002)(40460700003)(47076005)(426003)(1076003)(5660300002)(83380400001)(8936002)(82740400003)(40480700001)(36860700001)(86362001)(82310400005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:53.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a91e6a-2af6-40ff-cfb6-08daf32bf450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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
Cc: stylon.wang@amd.com, Felipe
 Clark <felipe.clark@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Tony Tascioglu <tony.tascioglu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tony Tascioglu <tony.tascioglu@amd.com>

[Why]
When an eDP panel is powered externally from a different GPU, we can avoid
waiting for hardware sequencing delays when switching the backlight on/off
as the display backlight is no longer powered by the original source.

[How]
This commit extends the 'link_powered_externally' variable to allow
bypassing hardware delays for additional backlight commands and force the
backlight on/off when a link is powered by another GPU.

Reviewed-by: Felipe Clark <felipe.clark@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tony Tascioglu <tony.tascioglu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/bios/command_table2.h |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h       |  2 +-
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c  |  9 ++++++---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h      |  2 +-
 6 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 9f11dcf67c28..2c278b626256 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1698,14 +1698,14 @@ static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
 	uint8_t panel_instance,
-	uint8_t bypass_powerdown_wait)
+	uint8_t bypass_panel_control_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_powerdown_wait);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_panel_control_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 91adebc5c5b7..1ef9e4053bb7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -987,7 +987,7 @@ static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
 	uint8_t panel_instance,
-	uint8_t bypass_powerdown_wait);
+	uint8_t bypass_panel_control_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
 {
@@ -1000,7 +1000,7 @@ static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
 	uint8_t panel_instance,
-	uint8_t bypass_powerdown_wait)
+	uint8_t bypass_panel_control_wait)
 {
 
 	union dmub_rb_cmd cmd;
@@ -1014,8 +1014,8 @@ static void enable_lvtma_control_dmcub(
 			uc_pwr_on;
 	cmd.lvtma_control.data.panel_inst =
 			panel_instance;
-	cmd.lvtma_control.data.bypass_powerdown_wait =
-			bypass_powerdown_wait;
+	cmd.lvtma_control.data.bypass_panel_control_wait =
+			bypass_panel_control_wait;
 	dc_dmub_srv_cmd_queue(dmcub, &cmd);
 	dc_dmub_srv_cmd_execute(dmcub);
 	dc_dmub_srv_wait_idle(dmcub);
@@ -1026,7 +1026,7 @@ static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
 	uint8_t panel_instance,
-	uint8_t bypass_powerdown_wait)
+	uint8_t bypass_panel_control_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
@@ -1035,7 +1035,7 @@ static enum bp_result enable_lvtma_control(
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
 				panel_instance,
-				bypass_powerdown_wait);
+				bypass_panel_control_wait);
 		return BP_RESULT_OK;
 	}
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index acb7cc69f699..b6d09bf6cf72 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -97,7 +97,7 @@ struct cmd_tbl {
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
 			uint8_t panel_instance,
-			uint8_t bypass_powerdown_wait);
+			uint8_t bypass_panel_control_wait);
 };
 
 void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 07d996c992ed..be9aa1a71847 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -141,7 +141,7 @@ struct dc_vbios_funcs {
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
 		uint8_t panel_instance,
-		uint8_t bypass_powerdown_wait);
+		uint8_t bypass_panel_control_wait);
 
 	enum bp_result (*get_soc_bb_info)(
 		struct dc_bios *dcb,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ef5afd2a5cf7..a51bd21a796f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -943,7 +943,6 @@ void dce110_edp_wait_for_T12(
 			msleep(t12_duration - time_since_edp_poweroff_ms);
 	}
 }
-
 /*todo: cloned in stream enc, fix*/
 /*
  * @brief
@@ -1022,16 +1021,20 @@ void dce110_edp_backlight_control(
 			DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
 	}
 
+	/* Setting link_powered_externally will bypass delays in the backlight
+	 * as they are not required if the link is being powered by a different
+	 * source.
+	 */
 	if (ctx->dc->ctx->dmub_srv &&
 			ctx->dc->debug.dmub_command_table) {
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance, 0);
+					panel_instance, link->link_powered_externally);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance, 0);
+					panel_instance, link->link_powered_externally);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b3acdb53875c..06c553b61322 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3111,7 +3111,7 @@ struct dmub_rb_cmd_panel_cntl {
  */
 struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
-	uint8_t bypass_powerdown_wait;
+	uint8_t bypass_panel_control_wait;
 	uint8_t reserved_0[2];
 	uint8_t panel_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
-- 
2.39.0

