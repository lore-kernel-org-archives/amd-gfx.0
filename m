Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44B4C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB2010E2D5;
	Wed, 16 Aug 2023 06:09:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB4110E2D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moqlXRiKcQJoxMiTRCOyKAkV80PEFH1XJv1ek+9SB85Gpb8u1dr4aRf3wPj6uuN7Acp/KcCO1VB3O9CG41TXrZDEUMbbh7k1YKU70PA7efXEFv6VqYscdln37mpikP51ZFR9bkva6HE4Dy5DApIDAQlupUIYnAk/vHSe1uFBPm+31XBVRPt+1uHHc3+eLbucVfO9wR0Wgx6Po0YPpcYrk7HxaNw8hf0UWeIXqhEg61RmztuTukmMkNLRWQEqfs1u9zsUR291bdmb7GRxoKbIUeoWmFkg0OfoyKdH0dmOIqjBc+yQu2ToCYGTeIHcDvgC4acrIQZS60SIwZMyOEK9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLVNatDMGKto/19Z44KP+jQ1RDbC6pLJ6jDgXxVCbjM=;
 b=ORRSCyMkONiwKANPvkzqT1+vT1trTFGC77JGr6ulCUXBUH+S0sFNFQDms27E2dmP3KnPbWn3h5oaNecp5uN1po0z2DfX+5n40TIjQMpdQTuTKVsNiHFpzijkYcM7xHbb0Eq2T17fYCwKZcKdeA2tT5UNyERd2my1oM7Zx5QlICdHnQ7bSj22X8k1c5nWTaGiiLLKtLfwZLWzgeMzDa5n+qa4h6OommP54CHNsA8MR9RHoQSgX9v5ssucZUf7lwDZxybd2ltuUDbxjVvDQ3ObPgrXA1NTNG1UXQDrnHlXT/8+MSJT60L/Mlze7opGym67Ttve2WDAKsh0eIK2jpgudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLVNatDMGKto/19Z44KP+jQ1RDbC6pLJ6jDgXxVCbjM=;
 b=Tnly/Z3aGBvfPF6685p9iYJWZ2zPYtyt/xN+GwoMq4IAQKndbzDyF37w53bRh5HfWymQYW0CNJZZi67q7PUhWCbwAWvck8wzld2qVQ07KlrH4UQaHXjbbOBFrou4y/M/AFL4govX8LhJhVb6tEFoax9n2AIJbum9SPbBdeiBZDM=
Received: from CY5PR18CA0056.namprd18.prod.outlook.com (2603:10b6:930:13::23)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:08:58 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::fa) by CY5PR18CA0056.outlook.office365.com
 (2603:10b6:930:13::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 23:08:56 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: add check for PMFW hard min request
 complete
Date: Wed, 16 Aug 2023 14:06:55 +0800
Message-ID: <20230816060658.2141009-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8729ab-2340-4583-b3dc-08db9e1f471e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvJNKaBjZHNjY+tmhBDB1c4hspljF38r8lNaJltCGxZTFBcTwnR11VNBijag+6wOLDzLr/cqmLP/9IoVsJh1BcL2Dlc3zF9bXB6HILi/Fj5ickSWjqNf7vFlOQWViKhGyurakgkdXh3387j4YRiZJQCslqE0kn6rwFedmf+t6l9Oher9OdILPUbDqJ/P5F4m2uLBxZ64cBS/NPP/3kV/XBc59WKUpN/GL3FZbWbuR9kpm16EAw33u+GsS98Q5ze/dehxE6QIJaIutJZ4yZqUVz/xLP1v97Vdr9Pch9N9dI3lFDQethxPC72E+5iW2W/3ioNccX3qsNfjXHQnaffULI604hdoqOepQcOc/mZ1f4d7ZDKqIiReQ/7rv11YoSglkAYqEp2eo0pKqjY0oBL3LxgynywAnuvRST3u6BsaOm7C46QoLrHyiZFlwBYqk4yRLWrWy/Pv513Ziwy9l80Kl23L99SDwdgUhsHc1hLsIZiAbQMVpOdVSAh9tmht38oBOq6SeLd6OxBOUNhzkJcMW3eaJmI5l/otuExLx5uIPz3h3Y67VyLoHBFZ4AzOHxEnY51FEA5cvr31odDuQqqjy4XRnbXglaCclSp1VsEPTK2NpoDvD0jdIJIy2yd6MR2c0a19Q2hF5PnbwSEzmc/ct01+P208MnjP6XdYhblUSKNP757JCwvpo83zk9N4KEF6z8a5biYfqEB4fK4lC1m410TS4OuAk0XGSCBlq9UiHrkm3fECNDIFy1dUCHyUfnlapHpp4oBMgpc96NLoFgvcwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:57.6332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8729ab-2340-4583-b3dc-08db9e1f471e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
When we issue hard min request to PMFW, the ack back does not
guarantee the request has been fulfilled.

[How]
Add new PMFW message to check if the hard min request has been
completed. Returned bit mask indicates which clock requests are
completed. Check PMFW version before using message

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h |  11 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  | 154 +++++++++++++++++-
 2 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h
index c427be6add8a..724a508b0adb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h
@@ -55,7 +55,16 @@
 #define DALSMC_MSG_SetFclkSwitchAllow             0x11
 #define DALSMC_MSG_SetCabForUclkPstate            0x12
 #define DALSMC_MSG_SetWorstCaseUclkLatency        0x13
-#define DALSMC_Message_Count                      0x14
+#define DALSMC_MSG_SetAlwaysWaitDmcubResp         0x14
+#define DALSMC_MSG_ReturnHardMinStatus            0x15
+#define DALSMC_Message_Count                      0x16
+
+#define CHECK_HARD_MIN_CLK_DISPCLK                0x1
+#define CHECK_HARD_MIN_CLK_DPPCLK                 0x2
+#define CHECK_HARD_MIN_CLK_DPREFCLK               0x4
+#define CHECK_HARD_MIN_CLK_DCFCLK                 0x8
+#define CHECK_HARD_MIN_CLK_DTBCLK                 0x10
+#define CHECK_HARD_MIN_CLK_UCLK                   0x20
 
 typedef enum {
 	FCLK_SWITCH_DISALLOW,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index 700ce42036d7..df244b175fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -90,6 +90,64 @@ static bool dcn32_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uint
 	return false;
 }
 
+/*
+ * Use these functions to return back delay information so we can aggregate the total
+ *  delay when requesting hardmin clk
+ *
+ * dcn32_smu_wait_for_response_delay
+ * dcn32_smu_send_msg_with_param_delay
+ *
+ */
+static uint32_t dcn32_smu_wait_for_response_delay(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries, unsigned int *total_delay_us)
+{
+	uint32_t reg = 0;
+	*total_delay_us = 0;
+
+	do {
+		reg = REG_READ(DAL_RESP_REG);
+		if (reg)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+		*total_delay_us += delay_us;
+	} while (max_retries--);
+
+	return reg;
+}
+
+static bool dcn32_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mgr, uint32_t msg_id, uint32_t param_in, uint32_t *param_out, unsigned int *total_delay_us)
+{
+	unsigned int delay1_us, delay2_us;
+	*total_delay_us = 0;
+
+	/* Wait for response register to be ready */
+	dcn32_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay1_us);
+
+	/* Clear response register */
+	REG_WRITE(DAL_RESP_REG, 0);
+
+	/* Set the parameter register for the SMU message */
+	REG_WRITE(DAL_ARG_REG, param_in);
+
+	/* Trigger the message transaction by writing the message ID */
+	REG_WRITE(DAL_MSG_REG, msg_id);
+
+	/* Wait for response */
+	if (dcn32_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay2_us) == DALSMC_Result_OK) {
+		if (param_out)
+			*param_out = REG_READ(DAL_ARG_REG);
+
+		*total_delay_us = delay1_us + delay2_us;
+		return true;
+	}
+
+	*total_delay_us = delay1_us + 2000000;
+	return false;
+}
+
 void dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable)
 {
 	smu_print("FCLK P-state support value is : %d\n", enable);
@@ -122,10 +180,98 @@ void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
 		DALSMC_MSG_BacoAudioD3PME, 0, NULL);
 }
 
+/* Check PMFW version if it supports ReturnHardMinStatus message */
+static bool dcn32_get_hard_min_status_supported(struct clk_mgr_internal *clk_mgr)
+{
+	if (ASICREV_IS_GC_11_0_0(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
+		if (clk_mgr->smu_ver >= 0x4e6a00)
+			return true;
+	} else if (ASICREV_IS_GC_11_0_2(clk_mgr->base.ctx->asic_id.hw_internal_rev)) {
+		if (clk_mgr->smu_ver >= 0x524e00)
+			return true;
+	} else { /* ASICREV_IS_GC_11_0_3 */
+		if (clk_mgr->smu_ver >= 0x503900)
+			return true;
+	}
+	return false;
+}
+
+/* Returns the clocks which were fulfilled by the DAL hard min arbiter in PMFW */
+static unsigned int dcn32_smu_get_hard_min_status(struct clk_mgr_internal *clk_mgr, bool *no_timeout, unsigned int *total_delay_us)
+{
+	uint32_t response = 0;
+
+	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
+	uint32_t param = 0;
+
+	*no_timeout = dcn32_smu_send_msg_with_param_delay(clk_mgr,
+			DALSMC_MSG_ReturnHardMinStatus, param, &response, total_delay_us);
+
+	smu_print("SMU Get hard min status: no_timeout %d delay %d us clk bits %x\n",
+		*no_timeout, *total_delay_us, response);
+
+	return response;
+}
+
+static bool dcn32_smu_wait_get_hard_min_status(struct clk_mgr_internal *clk_mgr,
+	uint32_t clk)
+{
+	int readDalHardMinClkBits, checkDalHardMinClkBits;
+	unsigned int total_delay_us, read_total_delay_us;
+	bool no_timeout, hard_min_done;
+
+	static unsigned int cur_wait_get_hard_min_max_us;
+	static unsigned int cur_wait_get_hard_min_max_timeouts;
+
+	checkDalHardMinClkBits = CHECK_HARD_MIN_CLK_DPREFCLK;
+	if (clk == PPCLK_DISPCLK)
+		checkDalHardMinClkBits |= CHECK_HARD_MIN_CLK_DISPCLK;
+	if (clk == PPCLK_DPPCLK)
+		checkDalHardMinClkBits |= CHECK_HARD_MIN_CLK_DPPCLK;
+	if (clk == PPCLK_DCFCLK)
+		checkDalHardMinClkBits |= CHECK_HARD_MIN_CLK_DCFCLK;
+	if (clk == PPCLK_DTBCLK)
+		checkDalHardMinClkBits |= CHECK_HARD_MIN_CLK_DTBCLK;
+	if (clk == PPCLK_UCLK)
+		checkDalHardMinClkBits |= CHECK_HARD_MIN_CLK_UCLK;
+
+	if (checkDalHardMinClkBits == CHECK_HARD_MIN_CLK_DPREFCLK)
+		return 0;
+
+	total_delay_us = 0;
+	hard_min_done = false;
+	while (1) {
+		readDalHardMinClkBits = dcn32_smu_get_hard_min_status(clk_mgr, &no_timeout, &read_total_delay_us);
+		total_delay_us += read_total_delay_us;
+		if (checkDalHardMinClkBits == (readDalHardMinClkBits & checkDalHardMinClkBits)) {
+			hard_min_done = true;
+			break;
+		}
+
+
+		if (total_delay_us >= 2000000) {
+			cur_wait_get_hard_min_max_timeouts++;
+			smu_print("SMU Wait get hard min status: %d timeouts\n", cur_wait_get_hard_min_max_timeouts);
+			break;
+		}
+		msleep(1);
+		total_delay_us += 1000;
+	}
+
+	if (total_delay_us > cur_wait_get_hard_min_max_us)
+		cur_wait_get_hard_min_max_us = total_delay_us;
+
+	smu_print("SMU Wait get hard min status: no_timeout %d, delay %d us, max %d us, read %x, check %x\n",
+		no_timeout, total_delay_us, cur_wait_get_hard_min_max_us, readDalHardMinClkBits, checkDalHardMinClkBits);
+
+	return hard_min_done;
+}
+
 /* Returns the actual frequency that was set in MHz, 0 on failure */
 unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
 	uint32_t response = 0;
+	bool hard_min_done = false;
 
 	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
 	uint32_t param = (clk << 16) | freq_mhz;
@@ -133,9 +279,13 @@ unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, ui
 	smu_print("SMU Set hard min by freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
 
 	dcn32_smu_send_msg_with_param(clk_mgr,
-			DALSMC_MSG_SetHardMinByFreq, param, &response);
+		DALSMC_MSG_SetHardMinByFreq, param, &response);
 
-	smu_print("SMU Frequency set = %d KHz\n", response);
+	if (dcn32_get_hard_min_status_supported(clk_mgr)) {
+		hard_min_done = dcn32_smu_wait_get_hard_min_status(clk_mgr, clk);
+		smu_print("SMU Frequency set = %d KHz hard_min_done %d\n", response, hard_min_done);
+	} else
+		smu_print("SMU Frequency set = %d KHz\n", response);
 
 	return response;
 }
-- 
2.37.3

