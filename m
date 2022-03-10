Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EFBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A956010E54C;
	Thu, 10 Mar 2022 22:21:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B4F10E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkFTbAHyXsQZt5VT++BUPS7rLSg5r3ZNvR9a9mCmoXg0SL/gJ/OkMyAkvf08i5M7Z1j9LT/BAGnzhDtXFPYz8WtyqE74GQ+MSxDGNsybyM8IqbQvjVLz/WTvxQ4yMlEDD01avPXm0LPE9akkaQFs9a7cdvJYIkQTn9B6eIHf/iB8ZTE4ASaAgWdie94jxooQHi9G14xUekMALUG8caecHVyfkukVFrvZMhNQ/DkMtNYTCvw5eDXZTkkwNuRuSxQpy08jc0ASNQUQ67/+UsOmo5FFqOeONbvnJNmiGDFjB3Of+YEnbvGr7CA5PwGupU/jPjgGsDuthA52sDDIqDPYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIDIgugkS9lj+5Re1SpGrb2Umkyqqu3ZN+YDWi1dNPw=;
 b=jyZAJmyGofr2B5jczsaqnaVy94YamRjZ0BitFTCSpQjqJzxLxegutWolweKEcNosD/q7DUIdeIaeWnH5ULxXb/g6+do2yBlKfjYEfQr7EkBEQjNABf37fBWNGCn8G5QoXcM4aQRSKxkBBUEQjDl21sS2/jzxjX+9eHzENltx2AAy5VcD487ijTKBqPScjg7FXUyVhA1QeTAocouCd2NtbZQXWBe1TipDjWQKHTUJtrQnGsAsKPfdlXtMfxhupOD15cfUAPeAAwXoQnShdyBd6Cwp13FEbo68hoADGnqRL3mZJvVZc9Z6m6MuyjSGfMSs/QVrZVjqN422Hnfy245lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIDIgugkS9lj+5Re1SpGrb2Umkyqqu3ZN+YDWi1dNPw=;
 b=0G+r5dikbI+Ba4QrMjAHqu1V5v3C3TuTUagf351puWWaPAci9WnN7rqtnHueRRpMjhNgOrbt9/WF1PtzmR+vXr0VCTSO/FI5IoU1v3qEQhy44rOZWnya+DMO5qapdXGO9CK/OI1//jx7S9ZJ62mVAlOFzOJ0shV3zeSpnMKMuRc=
Received: from DM5PR13CA0047.namprd13.prod.outlook.com (2603:10b6:3:7b::33) by
 BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 22:21:53 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::49) by DM5PR13CA0047.outlook.office365.com
 (2603:10b6:3:7b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:53 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:50 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: Add save/restore PANEL_PWRSEQ_REF_DIV2
Date: Thu, 10 Mar 2022 17:20:43 -0500
Message-ID: <20220310222045.664867-11-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951acd3c-a6da-46ad-f28e-08da02e4615a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5078784B729B885676777089F50B9@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgPDIpxgJDXs3bSHC7CNEM8c2KAG/W40wV5l44QWOhdujSfVUCpAm/O/WIpCdxG6cU9k3zb1zRQnUdOH67r3uBV097drNId9XWhepRDlfS2Otl1Re8Zmllo01bK02Mzc2sHSoyMdJKCpCr5qaS+1Q286BhU+bhzMdnUl+F/YTLPKt0s+bgUm38xEeaD3+BuSY0lYsSruwN5hBuLq6gJq9vWzXmLPwHAiaJkepGUywieRbIqFkKiLVnTchWdXtJl/5UxO0f0XVMn8bC8hP86lHcEW0bJRsuK16y7UX9nhMpVW4vyN/gBn+oW3LWbVDQevXYV6iGPrzCOq0lUA6wCXaOEkXCT5c/3KK12CTnxz8jzZqRrQKdrBpz2FFxmFzwffThot0Fx38lWJWNauacUzACIgSkHUFZVf4bsKdB6qTI8XLS21Qz9wthEJDHPfdyDRin1UR6CAcrBmNdIs6RMbGeerM6I+tAkV7YXaSdf8C48UP26xlu27bYiO0JP1YNrk4wkieidM0R3A+CpQLXUG1GXFj8yomU+UQHzdI1fBEWLmLJaUfhATlNZ3dbPJaKB81TYvLwEERbFSk47jz18JcL8oWRDZENYsQ2/RRkrIkghZ4WFoBIBta7gmeIUQNcCXMIqJom0C7p3L0byByesJ6PLf2dbVEMcY/P4AUeBY1Q42d968O7/P0BnfpoLB9Xms6lU6zw/D3Gt5I9a4zy3rAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(16526019)(8936002)(26005)(336012)(6666004)(8676002)(54906003)(44832011)(40460700003)(2616005)(1076003)(6916009)(5660300002)(186003)(426003)(83380400001)(36756003)(356005)(86362001)(2906002)(7696005)(36860700001)(82310400004)(81166007)(70586007)(508600001)(70206006)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:53.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951acd3c-a6da-46ad-f28e-08da02e4615a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
DCN31 has this in zstate save/restore sequence.
need for non_zstate supported ASIC

[how]
add this PANEL_PWRSEQ_REF_DIV2 to existing panel_cntl_hw_init structure.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  5 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 88 ++++++++++++++++++-
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index 83ece02380a8..11ea9d13e312 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -83,7 +83,8 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
 	cmd.panel_cntl.data.bl_pwm_ref_div1 =
 		panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
-
+	cmd.panel_cntl.data.bl_pwm_ref_div2 =
+		panel_cntl->stored_backlight_registers.PANEL_PWRSEQ_REF_DIV2;
 	if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
 		return 0;
 
@@ -92,6 +93,8 @@ static uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL = cmd.panel_cntl.data.bl_pwm_period_cntl;
 	panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV =
 		cmd.panel_cntl.data.bl_pwm_ref_div1;
+	panel_cntl->stored_backlight_registers.PANEL_PWRSEQ_REF_DIV2 =
+		cmd.panel_cntl.data.bl_pwm_ref_div2;
 
 	return cmd.panel_cntl.data.current_backlight;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index 48eac622c6a0..24af9d80b937 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -39,6 +39,7 @@ struct panel_cntl_backlight_registers {
 	unsigned int BL_PWM_CNTL2;
 	unsigned int BL_PWM_PERIOD_CNTL;
 	unsigned int LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
+	unsigned int PANEL_PWRSEQ_REF_DIV2;
 };
 
 struct panel_cntl_funcs {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8521508af755..294717e09abf 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1450,6 +1450,80 @@ enum dmub_cmd_mall_type {
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
 
+/**
+ * PHY Link rate for DP.
+ */
+enum phy_link_rate {
+	/**
+	 * not supported.
+	 */
+	PHY_RATE_UNKNOWN = 0,
+	/**
+	 * Rate_1 (RBR)	- 1.62 Gbps/Lane
+	 */
+	PHY_RATE_162 = 1,
+	/**
+	 * Rate_2		- 2.16 Gbps/Lane
+	 */
+	PHY_RATE_216 = 2,
+	/**
+	 * Rate_3		- 2.43 Gbps/Lane
+	 */
+	PHY_RATE_243 = 3,
+	/**
+	 * Rate_4 (HBR)	- 2.70 Gbps/Lane
+	 */
+	PHY_RATE_270 = 4,
+	/**
+	 * Rate_5 (RBR2)- 3.24 Gbps/Lane
+	 */
+	PHY_RATE_324 = 5,
+	/**
+	 * Rate_6		- 4.32 Gbps/Lane
+	 */
+	PHY_RATE_432 = 6,
+	/**
+	 * Rate_7 (HBR2)- 5.40 Gbps/Lane
+	 */
+	PHY_RATE_540 = 7,
+	/**
+	 * Rate_8 (HBR3)- 8.10 Gbps/Lane
+	 */
+	PHY_RATE_810 = 8,
+	/**
+	 * UHBR10 - 10.0 Gbps/Lane
+	 */
+	PHY_RATE_1000 = 9,
+	/**
+	 * UHBR13.5 - 13.5 Gbps/Lane
+	 */
+	PHY_RATE_1350 = 10,
+	/**
+	 * UHBR10 - 20.0 Gbps/Lane
+	 */
+	PHY_RATE_2000 = 11,
+};
+
+/**
+ * enum dmub_phy_fsm_state - PHY FSM states.
+ * PHY FSM state to transit to during PSR enable/disable.
+ */
+enum dmub_phy_fsm_state {
+	DMUB_PHY_FSM_POWER_UP_DEFAULT = 0,
+	DMUB_PHY_FSM_RESET,
+	DMUB_PHY_FSM_RESET_RELEASED,
+	DMUB_PHY_FSM_SRAM_LOAD_DONE,
+	DMUB_PHY_FSM_INITIALIZED,
+	DMUB_PHY_FSM_CALIBRATED,
+	DMUB_PHY_FSM_CALIBRATED_LP,
+	DMUB_PHY_FSM_CALIBRATED_PG,
+	DMUB_PHY_FSM_POWER_DOWN,
+	DMUB_PHY_FSM_PLL_EN,
+	DMUB_PHY_FSM_TX_EN,
+	DMUB_PHY_FSM_FAST_LP,
+};
+
+
 
 /**
  * Data passed from driver to FW in a DMUB_CMD__PSR_COPY_SETTINGS command.
@@ -1698,9 +1772,16 @@ struct dmub_cmd_psr_force_static_data {
 	 */
 	uint8_t panel_inst;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * Phy state to enter.
+	 * Values to use are defined in dmub_phy_fsm_state
 	 */
-	uint8_t pad[2];
+	uint8_t phy_fsm_state;
+	/**
+	 * Phy rate for DP - RBR/HBR/HBR2/HBR3.
+	 * Set this using enum phy_link_rate.
+	 * This does not support HDMI/DP2 for now.
+	 */
+	uint8_t phy_rate;
 };
 
 /**
@@ -2377,6 +2458,9 @@ struct dmub_cmd_panel_cntl_data {
 	uint32_t bl_pwm_ref_div1; /* in/out */
 	uint8_t is_backlight_on : 1; /* in/out */
 	uint8_t is_powered_on : 1; /* in/out */
+	uint8_t padding[3];
+	uint32_t bl_pwm_ref_div2; /* in/out */
+	uint8_t reserved[4];
 };
 
 /**
-- 
2.35.1

