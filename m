Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5ECC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C284C10E61A;
	Tue, 10 Jan 2023 16:58:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB1510E61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQOttPt+dfWA2mWt1WTLi22GN/kG4zGDb4og8cT43bZl/E9lg+vc+00F8oWwCNyymm15fcoKp5Ttw26KB8ggFwSOCPY9KXIEs7Fzd6nI3M5bMiCRWR5pFo+UV+t97SiVBcfhcli8MGIpViP3jgxVMVhw8ySXBo27/G51W0rBqJWkj+jBKWmtOCAKZtJRQgVBxuGEO4vHxtrP5IFiXL57uiUw5BkSr2WsTuoeG/sDj3N8H+Hcp3d5DXerFAh4sD14DxQLDZopoO+xPufo64LBpRwajVOL6O7MZrbZ1MSHNJ+6qjW/bfrctkFxrJkrRWb1Xak9b/wOXkeV3fVgUUO8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9W+BAb6zHHN8pE7b8M5eZobQJ0blpn15ngobUrtwFM=;
 b=fAfPLKpyCYYkxy0jMI3N715zViYBSTai/cJhgMkSs+Ntn/0Ye2Ig/4PNIkY3w9iV3Nnbkk1Fu+e1kBYJm5/7UsMGkPmBHgHh8N41ZxmGefLcN+8q3i8h8Wcg8dq14TnTtxdkLAtZpmnOh5VplL3Ztod/qlqyeaKHe2oqh/+SjaUvBkvy1K53GJeHy6wLQV8VSUOnCfM1NC690c22bvT5f5a8N1DJ/3yGGQhoQPBSUwKRlroRcRMCvyNG6d62ycuU2biHzzeaIz+DO4dvNfZipNWqDvl/iuk6xFGJ1MKfYR/ljhvFwW6Lj5OGmePoPGhsaKWLmFmav82dIaW0W0Q6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9W+BAb6zHHN8pE7b8M5eZobQJ0blpn15ngobUrtwFM=;
 b=IsC+XlGKd3gjkCf7rNrbTJAB6HDijjF5Dcs8+1EJ/uhsPENTPsFYkogzSMsHv/OUeHuxWqCNm+mnJhKVBQS2GY0TatjDj7jcq+EuWIdeV4tXQia9m8m5TU0yaQiO7LDJLalQDmL2V5Jjzzz23QZjt7rvyHhP2wG72qastfOD7J0=
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:26 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::28) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:25 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:23 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/37] drm/amd/display: Optimize link power-down when link
 powered externally
Date: Tue, 10 Jan 2023 11:55:22 -0500
Message-ID: <20230110165535.3358492-25-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 49350232-010b-4ef6-f674-08daf32be3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foRZg6AHYDH8/YnqSsbH+UzmrbVm4vK6+d7mpQiJdwC3MMyzn4Ybmg4+dLaK3V/tWkajdT5792hCn4t0RwW6x1sjx/Gio/esIRSCw2m/rXSTXyhgQPTEDiSbQ+xaDRHgpZV4n9cGOL0WbW7Q9S95erYZ0z1iS3Z/7tEU5wJtA5mRFjT9fREUUEMm9WjRVwzFHewTEPZ8Q0r56xT08VMNEtKMMf9SmwCoAa3FhpFgnK1k3E/r3MysNIDpXDdNJ+EyPkZJYzvhPEbH3tbWU74DmiwsS8A0Q931ZrPjpnkNiSJoV/5eSSrOWYWiJeQgBKrxPYMUhDcgXBF67jJqflNMtqqTR4zM3ke8CwfkaeFemIiQSQKRMadQSO4HyDYtcD1VVjPcwqaJ2XP2Yi//xtarDBtPViGuz1XLehgIoG0GL1u+0qxJjHg8yjorP8o3SxlqTomK235vqk3RS5YMVBCHPos97YmruDH39WhfgS1eeMyySKnPr/Zu511PEAa3xjHsd6zmGCTsUxTvGseffmoWw8CXf5SnrqtsAwqc00SIJRt0F5jJK24G2gV1ulUA+z4zi60Cn5PNcny6EcUN0nnSBjeYc+/W19AFwM7ViKZpB+AMAIUiTeXaVVbaCWlam9mKxAe5nipGR0SFqwUUhx8LmPFiMolQZWphY1XNLq4K99xabeDQjkE0m+W/Am+PrIVk5E7H/9bhAULZEPavdLEqp/uIg92c55TOnjTPrf39/84=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:25.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49350232-010b-4ef6-f674-08daf32be3b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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
When an eDP panel is powered externally by a different GPU, we don't need
to wait for hardware sequencing delays when powering down a link, as the
display is not dependent on the GPU being powered down.

[How]
This commit adds a variable 'link_powered_externally' to indicate when a
link is being powered by another GPU.

Reviewed-by: Felipe Clark <felipe.clark@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tony Tascioglu <tony.tascioglu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  5 +++--
 .../gpu/drm/amd/display/dc/bios/command_table2.c   | 14 ++++++++++----
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |  2 ++
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    | 14 ++++++++------
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  3 ++-
 7 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 8ca50c088858..9f11dcf67c28 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1697,14 +1697,15 @@ static enum bp_result bios_parser_enable_disp_power_gating(
 static enum bp_result bios_parser_enable_lvtma_control(
 	struct dc_bios *dcb,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance)
+	uint8_t panel_instance,
+	uint8_t bypass_powerdown_wait)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!bp->cmd_tbl.enable_lvtma_control)
 		return BP_RESULT_FAILURE;
 
-	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance);
+	return bp->cmd_tbl.enable_lvtma_control(bp, uc_pwr_on, panel_instance, bypass_powerdown_wait);
 }
 
 static bool bios_parser_is_accelerated_mode(
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index f52f7ff7ead4..91adebc5c5b7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -986,7 +986,8 @@ static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance);
+	uint8_t panel_instance,
+	uint8_t bypass_powerdown_wait);
 
 static void init_enable_lvtma_control(struct bios_parser *bp)
 {
@@ -998,7 +999,8 @@ static void init_enable_lvtma_control(struct bios_parser *bp)
 static void enable_lvtma_control_dmcub(
 	struct dc_dmub_srv *dmcub,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance)
+	uint8_t panel_instance,
+	uint8_t bypass_powerdown_wait)
 {
 
 	union dmub_rb_cmd cmd;
@@ -1012,6 +1014,8 @@ static void enable_lvtma_control_dmcub(
 			uc_pwr_on;
 	cmd.lvtma_control.data.panel_inst =
 			panel_instance;
+	cmd.lvtma_control.data.bypass_powerdown_wait =
+			bypass_powerdown_wait;
 	dc_dmub_srv_cmd_queue(dmcub, &cmd);
 	dc_dmub_srv_cmd_execute(dmcub);
 	dc_dmub_srv_wait_idle(dmcub);
@@ -1021,7 +1025,8 @@ static void enable_lvtma_control_dmcub(
 static enum bp_result enable_lvtma_control(
 	struct bios_parser *bp,
 	uint8_t uc_pwr_on,
-	uint8_t panel_instance)
+	uint8_t panel_instance,
+	uint8_t bypass_powerdown_wait)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
@@ -1029,7 +1034,8 @@ static enum bp_result enable_lvtma_control(
 	    bp->base.ctx->dc->debug.dmub_command_table) {
 		enable_lvtma_control_dmcub(bp->base.ctx->dmub_srv,
 				uc_pwr_on,
-				panel_instance);
+				panel_instance,
+				bypass_powerdown_wait);
 		return BP_RESULT_OK;
 	}
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
index be060b4b87db..acb7cc69f699 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.h
@@ -96,7 +96,8 @@ struct cmd_tbl {
 			struct bios_parser *bp, uint8_t id);
 	enum bp_result (*enable_lvtma_control)(struct bios_parser *bp,
 			uint8_t uc_pwr_on,
-			uint8_t panel_instance);
+			uint8_t panel_instance,
+			uint8_t bypass_powerdown_wait);
 };
 
 void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 260ac4458870..07d996c992ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -140,7 +140,8 @@ struct dc_vbios_funcs {
 	enum bp_result (*enable_lvtma_control)(
 		struct dc_bios *bios,
 		uint8_t uc_pwr_on,
-		uint8_t panel_instance);
+		uint8_t panel_instance,
+		uint8_t bypass_powerdown_wait);
 
 	enum bp_result (*get_soc_bb_info)(
 		struct dc_bios *dcb,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 63fe60dd3ea3..48f6a5b09336 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -294,6 +294,8 @@ struct dc_link {
 
 	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
+	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
+
 	struct dc_panel_config panel_config;
 	struct phy_state phy_state;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 94be3ffcdea0..ef5afd2a5cf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -875,14 +875,16 @@ void dce110_edp_power_control(
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
-			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON)
+
+			if (cntl.action == TRANSMITTER_CONTROL_POWER_ON) {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_ON,
-						panel_instance);
-			else
+						panel_instance, link->link_powered_externally);
+			} else {
 				bp_result = ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 						LVTMA_CONTROL_POWER_OFF,
-						panel_instance);
+						panel_instance, link->link_powered_externally);
+			}
 		}
 
 		bp_result = link_transmitter_control(ctx->dc_bios, &cntl);
@@ -1025,11 +1027,11 @@ void dce110_edp_backlight_control(
 		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLON,
-					panel_instance);
+					panel_instance, 0);
 		else
 			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
 					LVTMA_CONTROL_LCD_BLOFF,
-					panel_instance);
+					panel_instance, 0);
 	}
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 328978ec6814..b3acdb53875c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3111,7 +3111,8 @@ struct dmub_rb_cmd_panel_cntl {
  */
 struct dmub_cmd_lvtma_control_data {
 	uint8_t uc_pwr_action; /**< LVTMA_ACTION */
-	uint8_t reserved_0[3]; /**< For future use */
+	uint8_t bypass_powerdown_wait;
+	uint8_t reserved_0[2];
 	uint8_t panel_inst; /**< LVTMA control instance */
 	uint8_t reserved_1[3]; /**< For future use */
 };
-- 
2.39.0

