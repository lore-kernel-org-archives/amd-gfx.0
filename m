Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B11C61DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7281110E613;
	Tue, 10 Jan 2023 16:57:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCCB10E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atzA/I5b6bR+Pjf9ZXdnLdFyekPb7dDRcruFXNwobKHexz+MCW5wNVaKsYHlj6sz0ldWiCRGTST+wYBHXrTer/6LA5pT0rbtza84S25H5oLR9+Q8Q1jSHqHns/7kSB69jFxrE4BKVRM0kxwmtt4wI54J3oBtsC2o2uLGmZlPcJbY9ROWygjXyCYsEc32f8utyEGJ3W0O0lmVKW1AtOBaQEiZCRdg87nCDaUyQC+WYuwqLKziTNL1Bk0qGhE9n+Eb0nuKRy5FJ81Kb+DMDOXIMgaB2TJLEDD63v75CvAFPm3hiqb3GzfCn7pYguCYemiftGcsXcWZRaZWLi5A2jxz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+8m5tGhdNovhTIR1LX3tBqSH8BHBrDat6p9qjXBsS0=;
 b=ERFqK4K7amAsyb4VwBqV2ViD5Uw0Ed4jd+U0l+CWiqhFl8lxQFf17RcXnHK2W9b/JFkUc/ax7deGSUQ3eyIE1HBLHL3YYRaiJ9JFnoPp0uKQGo+8Yc8yxgsXI3Blu6q/eaAETICGq/Pp4lRHjyiNFxwU786Tt6mUQ9uUx+f/GEncOcLB4BrlHHZ6na7vt7YaWeF6helw2ZjmmtGFAa9FEzo3ascB2s6/fu5ZlvSdmbodYS2Pgb3+S6wkcMA0i04vGreKeu29UF5qNwZdu2T8WyHpAXfJlVzRxFxd5sGTLWRGR8ueLpXr1rsXfn8FRj6Ms57InWokl6FLKl85xsRtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+8m5tGhdNovhTIR1LX3tBqSH8BHBrDat6p9qjXBsS0=;
 b=lPTd5/rGMy54+e2HYL7SPGXBKy1W1gXw0YfazQ0+pmIYkTWJyK0ZagShVlg5uPpgU0b+Z5JwFmQdUrtqnx74AlfM/Gzc+D142rQJO/bWOW+BrHnlknlXejBW8FUrUgQyc7++YeiU4OLHN3AwrCMBFtPdoCRzDJE0P1Gk7AX3ToU=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:57:14 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::1) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:14 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:11 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/37] drm/amd/display: add hubbub_init related
Date: Tue, 10 Jan 2023 11:55:09 -0500
Message-ID: <20230110165535.3358492-12-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 6050a52c-d3bc-4a7c-616a-08daf32bb95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVawRqTj+g6SITgbEL0Jwqm9n6/XTRXv+VUZYcgIFtXDTKf9Eoamlha8nrPLfgD1j/2/+52PMgioxi8QKwO4028zoDPAPuAQekqx3W74vMGnOSvGBioHzGRJEArMNImOX16fBLq5erb4gn+qT/uqobcyZvB0MZ7l8b643QXneMkJLrlw8QP32g7xQhB+b2XH9LKMzZmBLaZrFoQytWCrTPLk/KmIfPOlZJ0mbwBfrJP8uXuxSS20IRH8D0FVYy/AW1yWd9d1Kk0PAkg9Hg97atUKCUmmJ44o88x26qS0U4oQJ562O5zvRIR33lXfvIirstoTxMHVjDz90eWHNJBkP7XkSHWyPPyyxD2f4A7RBriTQxlghhgU+z9g/S6XKCCRjLmBAQCJaCmP22Tb5Yc/xBjKfb5JU1cA6t59WglB4NKQcHsBipL6ueuu4fHGTTqnHThDOqWpmoTF3ZGNwzvyntnQqZelyE973aHSeMV7ULM+1o9PeFPKM1UlSyPpSMXfqy/rwtHsLhDa2fE6oUy3mFlmBcptW8fpAi5IeJ7oahhKTcgLGy5HpS+NIM/Eme7xAmQjvlY3AnjG5y0/YP355v7Qy5M71CD+IwJdpgHbjcJjjAI2JddpLcZ1JmeXtyQJnejL9yCI2z4Hcd641qlPWiAJJPDQ54qOr/KISosffwAsf3houcMlcpg0xHZ263HnfS+AQ16YVT0lw5rQgtjHKHpHbr9g88XOtl8cnURy/eg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:14.3701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6050a52c-d3bc-4a7c-616a-08daf32bb95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

Required by display init, also update get_dig_mode

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   | 12 +++++++-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 18 ++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   | 10 ++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   | 29 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   | 17 +++++++++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  6 +++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 7 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index ba1c0621f0f8..e8752077571a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -172,6 +172,10 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C;
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D;
 	uint32_t SDPIF_REQUEST_RATE_LIMIT;
+	uint32_t DCHUBBUB_SDPIF_CFG0;
+	uint32_t DCHUBBUB_SDPIF_CFG1;
+	uint32_t DCHUBBUB_CLOCK_CNTL;
+	uint32_t DCHUBBUB_MEM_PWR_MODE_CTRL;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -362,7 +366,13 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C;\
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D;\
 		type DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D;\
-		type SDPIF_REQUEST_RATE_LIMIT
+		type SDPIF_REQUEST_RATE_LIMIT;\
+		type DISPCLK_R_DCHUBBUB_GATE_DIS;\
+		type DCFCLK_R_DCHUBBUB_GATE_DIS;\
+		type SDPIF_MAX_NUM_OUTSTANDING;\
+		type DCHUBBUB_ARB_MAX_REQ_OUTSTAND;\
+		type SDPIF_PORT_CONTROL;\
+		type DET_MEM_PWR_LS_MODE
 
 
 struct dcn_hubbub_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 6360dc9502e7..7e7cd5b64e6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -1008,6 +1008,24 @@ static bool hubbub31_verify_allow_pstate_change_high(struct hubbub *hubbub)
 	return false;
 }
 
+void hubbub31_init(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	/*Enable clock gate*/
+	if (hubbub->ctx->dc->debug.disable_clock_gate) {
+		/*done in hwseq*/
+		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
+		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
+				DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
+				DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+	}
+
+	/*
+	only the DCN will determine when to connect the SDP port
+	*/
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,	SDPIF_PORT_CONTROL, 1);
+}
 static const struct hubbub_funcs hubbub31_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
index 70c60de448ac..e015e5a6c866 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
@@ -42,6 +42,10 @@
 	SR(DCHUBBUB_COMPBUF_CTRL),\
 	SR(COMPBUF_RESERVED_SPACE),\
 	SR(DCHUBBUB_DEBUG_CTRL_0),\
+	SR(DCHUBBUB_CLOCK_CNTL),\
+	SR(DCHUBBUB_SDPIF_CFG0),\
+	SR(DCHUBBUB_SDPIF_CFG1),\
+	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B),\
@@ -120,7 +124,11 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
-	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DISPCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCFCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh)
 
 int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 9501403a48a9..eb08ccc38e79 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -945,6 +945,35 @@ void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub)
 			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, prog_wm_value);
 }
 
+void hubbub32_init(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	/* Enable clock gate*/
+	if (hubbub->ctx->dc->debug.disable_clock_gate) {
+		/*done in hwseq*/
+		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
+
+		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
+			DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
+			DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+	}
+	/*
+	ignore the "df_pre_cstate_req" from the SDP port control.
+	only the DCN will determine when to connect the SDP port
+	*/
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
+			SDPIF_PORT_CONTROL, 1);
+	/*Set SDP's max outstanding request to 512
+	must set the register back to 0 (max outstanding = 256) in zero frame buffer mode*/
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG1,
+			SDPIF_MAX_NUM_OUTSTANDING, 1);
+	/*must set the registers back to 256 in zero frame buffer mode*/
+	REG_UPDATE_2(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
+			DCHUBBUB_ARB_MAX_REQ_OUTSTAND, 512,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 512);
+}
+
 static const struct hubbub_funcs hubbub32_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index 786f9ce07f92..bdc146890fca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -83,7 +83,12 @@
 	SR(DCN_VM_FAULT_ADDR_LSB),\
 	SR(DCN_VM_FAULT_CNTL),\
 	SR(DCN_VM_FAULT_STATUS),\
-	SR(SDPIF_REQUEST_RATE_LIMIT)
+	SR(SDPIF_REQUEST_RATE_LIMIT),\
+	SR(DCHUBBUB_CLOCK_CNTL),\
+	SR(DCHUBBUB_SDPIF_CFG0),\
+	SR(DCHUBBUB_SDPIF_CFG1),\
+	SR(DCHUBBUB_MEM_PWR_MODE_CTRL)
+
 
 #define HUBBUB_MASK_SH_LIST_DCN32(mask_sh)\
 	HUBBUB_SF(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
@@ -96,6 +101,7 @@
 	HUBBUB_SF(DCHUBBUB_ARB_DRAM_STATE_CNTL, DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_SAT_LEVEL, DCHUBBUB_ARB_SAT_LEVEL, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MIN_REQ_OUTSTAND, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_DF_REQ_OUTSTAND, DCHUBBUB_ARB_MAX_REQ_OUTSTAND, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, mask_sh), \
@@ -161,7 +167,14 @@
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
 	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh),\
-	HUBBUB_SF(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, mask_sh)
+	HUBBUB_SF(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DISPCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCFCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_SDPIF_CFG1, SDPIF_MAX_NUM_OUTSTANDING, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh)
+
+
 
 bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index ac1c6458dd55..fe0cd177744c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -155,7 +155,11 @@ void hubp32_cursor_set_attributes(
 	else
 		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, false);
 }
-
+void hubp32_init(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	REG_WRITE(HUBPREQ_DEBUG_DB, 1 << 8);
+}
 static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 5b0265c0df61..beb26dc8a07f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -187,6 +187,7 @@ struct hubbub_funcs {
 	void (*init_crb)(struct hubbub *hubbub);
 	void (*force_usr_retraining_allow)(struct hubbub *hubbub, bool allow);
 	void (*set_request_limit)(struct hubbub *hubbub, int memory_channel_count, int words_per_channel);
+	void (*dchubbub_init)(struct hubbub *hubbub);
 };
 
 struct hubbub {
-- 
2.39.0

