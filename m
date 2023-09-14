Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA77EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D17D10E239;
	Thu, 14 Sep 2023 02:01:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DDE10E239
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chkoE8Npsqn41AeovH3pfC6XZQbjniiUpKiMToLDCA9u3OvXjOJsE+IHM98wh0bjNil52MpA+qTzcTNMCumaKtcv76EehMFmUNFs645sKTggTtHEjIu0p4kqfkChEnjnv3Lkg5NqDH/1BVL5JCNrABvJXO9BiFDN99pPA5IrD8Xjo6iCFR8rMVuXIFK/iJ7sdp9fML8wght3Z6tg0xm8IHnOnJ47HggL4LOos8UYHkH4ucWK/fSvCGahblttoglLNoqqOIFcvBRBPLch5z8nYhJTDyNY6H1IX4xK8TrzbPvqPcGlizRlkqJglLiyx6s5XPtLVnbjRMiJ0rII5vfsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdaPCVkrIhDfFgs6QixM7gL3Wt0ubH5shyvn4UcOw+M=;
 b=FAlJz6Fj3ExEqIpQhUFJwuqXTwCm3wAwq2SM+altBbjQcl9kDRbkEgVRtswwMuYmMw45g4tOHDGazU16TtseyTW34Y5flmt1I6iB41/XtOCpWiQsYyUCFROjC0hzJo0I5613nsEFQ/9BKfE4SWFDMX3fzUgq8kx/UWyTdiNvATEVGsJjlk5w1yc3ttG2zRGrg9SjA4hGFsGfZeJyhHBpU5Dq61P3ADTlvkhBD5W7jSelzOqw85X4bIxDb85kQhsK/n9fUtpSIhTSZ7I0/ifQbWgTV5a++KJ9OI/uQ+bY69S41doIxyg4XOM/TKTwhH7IMU5XpW8Hm9/NZjqfWaJKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdaPCVkrIhDfFgs6QixM7gL3Wt0ubH5shyvn4UcOw+M=;
 b=1PM1jAZR1Tl1sXqKxOG0pRStAGBWxdJk91kE9Ak8H0lVSSir7IM1sQ7S5LfwuhshLvE+L5zXY6OYWyyZJJFWE285KrMJPqaZciuZo2U8YN9IGYv7pEpSFtsYA6XEFfBqZZL/H71g7mOYN6RklAmuu1La3pTZEEMMfAt7VM8DefI=
Received: from SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) by PH7PR12MB5926.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 14 Sep
 2023 02:01:49 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::6d) by SN6PR2101CA0018.outlook.office365.com
 (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.5 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/28] drm/amd/display: Add IPS control flag
Date: Wed, 13 Sep 2023 20:00:08 -0600
Message-ID: <20230914020021.2890026-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 70be03e0-3f4a-4261-9bdf-08dbb4c68e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BewUB4U4oUVnUWqL5llUdaz3r0sXviHfhT07RQzhvOvRnbG9pYfDuy6ct/mGqIdxaMbp4U34B0WY/zj6gIMFKUdk79cXzqyDb/bOlKDMp/Ck5I7zg4k0UfLheWDtZ9SL4Ec7hYY8toYP/i1C3G+09OcpUNvwUVeTODQccTHwaY6efwnciDzPpthncUwGu1GAH4VfD0lYVbUMC4ag41TUnlaP6oIpCk3LjxVYQ82gwUM0YspzlO6tutAQKZSwDCY5H2e8n4V09rIXnxzW1uduvDWKkKdfBroHoK4TFrOABtMTSwpCYOTZL0PWpWAChlZHjhtRhEhKwznor3JCD5lpag8Xcn0Tk3PRnVPFSah05z8f1t8zWgtPm9OwjKSVtQP10ixSEq4hs/0mzfsx6/oQx8Ph9Hv2nz5cV8lVz/QWMJmNGta2m1VWzUsl1Lu104uv5DguBlRf3VtNt8MQeXVSXvLNnxl6B5cRneZCaH+T/i3OyOEnA9/GjYZiePlFjyaHxZXZVJ97R71J2HGeDozHFremtW4ZIZcKABCYiInpySogzOgB1ASmqJbyQUP11TWZnO2Y2uS+4RAcaC74pu974TzoQOBmhWIuNlFxuPXUGP0cFSNeS/iEgVpvipzCSZsBcvLroO/TB6juS1iA5t+kpLIZnhoBdXAxdyiJJSCgVRi9uB7eiRIc40YQWaWFk1VjzUjUsVAc2SCatzOo1tFaLMRJ/lAlmMIjjBH00am3MwLUzOhDiMF7puEEK+qxeSneEMZsbQ/A6GeNsZ3iYSAneQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(81166007)(6666004)(40460700003)(36756003)(86362001)(356005)(82740400003)(40480700001)(36860700001)(16526019)(1076003)(426003)(2906002)(336012)(30864003)(83380400001)(478600001)(4326008)(41300700001)(8676002)(316002)(8936002)(47076005)(5660300002)(2616005)(54906003)(70206006)(26005)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:49.0213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70be03e0-3f4a-4261-9bdf-08dbb4c68e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Currently, driver is not aware if IPS is supported. After PMFW helps
implement new message query functionality, driver will set IPS
capability flag.

[how]
Create new SMU hook function to query IPS capability. Based on the cap,
set appropriate flags to false for power-gating purposes. This will
avoid keeping SMU busy and offloading tasks to DMUB/driver.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 18 +++++++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 13 ++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  1 +
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  | 53 +++++++------------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 5 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b258eb37a859..819d273f011d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -747,6 +747,16 @@ static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 
 }
 
+static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	bool ips_supported = true;
+
+	ips_supported = dcn35_smu_get_ips_supported(clk_mgr) ? true : false;
+
+	return ips_supported;
+}
+
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
 	dcn35_init_clocks(clk_mgr);
@@ -833,6 +843,7 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.notify_wm_ranges = dcn35_notify_wm_ranges,
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
+	.is_ips_supported = dcn35_is_ips_supported,
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
@@ -988,6 +999,13 @@ void dcn35_clk_mgr_construct(
 		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				smu_dpm_clks.dpm_clks);
 
+	if (dcn35_smu_get_ips_supported(&clk_mgr->base)) {
+		ctx->dc->debug.ignore_pg = false;
+		ctx->dc->debug.dmcub_emulation = false;
+		ctx->dc->debug.disable_dpp_power_gate = false;
+		ctx->dc->debug.disable_hubp_power_gate = false;
+		ctx->dc->debug.disable_dsc_power_gate = false;
+	}
 }
 
 void dcn35_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index 9bd1e86901ec..f42c0a727dc8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -86,7 +86,10 @@
 #define VBIOSSMC_MSG_SetDtbClk                    0x17
 #define VBIOSSMC_MSG_DispPsrEntry                 0x18 ///< Display PSR entry, DMU
 #define VBIOSSMC_MSG_DispPsrExit                  0x19 ///< Display PSR exit, DMU
-#define VBIOSSMC_Message_Count                    0x1A
+#define VBIOSSMC_MSG_DisableLSdma                 0x1A ///< Disable LSDMA; only sent by VBIOS
+#define VBIOSSMC_MSG_DpControllerPhyStatus        0x1B ///< Inform PMFW about the pre conditions for turning SLDO2 on/off . bit[0]==1 precondition is met, bit[1-2] are for DPPHY number
+#define VBIOSSMC_MSG_QueryIPS2Support             0x1C ///< Return 1: support; else not supported
+#define VBIOSSMC_Message_Count                    0x1D
 
 #define VBIOSSMC_Status_BUSY                      0x0
 #define VBIOSSMC_Result_OK                        0x1
@@ -448,3 +451,11 @@ void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 		VBIOSSMC_MSG_DispPsrExit,
 		0);
 }
+
+int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
+{
+	return dcn35_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_QueryIPS2Support,
+			0);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 793d86c33d12..4d441d6db8d0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -175,6 +175,7 @@ void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 
 void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
+int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 8b487d15c8ec..ccfd3102e5a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -84,10 +84,9 @@ void pg_cntl35_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 		pg_cntl->ctx->dc->res_pool->dccg->funcs->enable_dsc(
 				pg_cntl->ctx->dc->res_pool->dccg, dsc_inst);
 
-	if (pg_cntl->ctx->dc->debug.disable_dsc_power_gate)
-		return;
-
-	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->debug.disable_dsc_power_gate ||
+		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
 	block_enabled = pg_cntl35_dsc_pg_status(pg_cntl, dsc_inst);
@@ -98,8 +97,7 @@ void pg_cntl35_dsc_pg_control(struct pg_cntl *pg_cntl, unsigned int dsc_inst, bo
 		if (!block_enabled)
 			return;
 	}
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -190,13 +188,10 @@ void pg_cntl35_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 	uint32_t org_ip_request_cntl;
 	bool block_enabled;
 
-	if (!power_on)
-		return;
-	if (pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
-		pg_cntl->ctx->dc->debug.disable_dpp_power_gate)
-		return;
-
-	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->debug.disable_hubp_power_gate ||
+		pg_cntl->ctx->dc->debug.disable_dpp_power_gate ||
+		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
 	block_enabled = pg_cntl35_hubp_dpp_pg_status(pg_cntl, hubp_dpp_inst);
@@ -207,8 +202,7 @@ void pg_cntl35_hubp_dpp_pg_control(struct pg_cntl *pg_cntl, unsigned int hubp_dp
 		if (!block_enabled)
 			return;
 	}
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -267,7 +261,8 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t org_ip_request_cntl;
 	bool block_enabled;
 
-	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
 	block_enabled = pg_cntl35_hpo_pg_status(pg_cntl);
@@ -278,8 +273,7 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 		if (!block_enabled)
 			return;
 	}
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -309,9 +303,8 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t org_ip_request_cntl;
 	bool block_enabled;
 
-	if (!power_on)
-		return;
-	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
 	block_enabled = pg_cntl35_io_clk_status(pg_cntl);
@@ -322,8 +315,7 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 		if (!block_enabled)
 			return;
 	}
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
@@ -351,7 +343,6 @@ static bool pg_cntl35_plane_otg_status(struct pg_cntl *pg_cntl)
 void pg_cntl35_mpcc_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int mpcc_inst, bool power_on)
 {
-
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
@@ -362,7 +353,6 @@ void pg_cntl35_mpcc_pg_control(struct pg_cntl *pg_cntl,
 void pg_cntl35_opp_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int opp_inst, bool power_on)
 {
-
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
@@ -373,7 +363,6 @@ void pg_cntl35_opp_pg_control(struct pg_cntl *pg_cntl,
 void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int optc_inst, bool power_on)
 {
-
 	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
@@ -392,12 +381,9 @@ void pg_cntl35_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	bool all_mpcc_disabled = true, all_opp_disabled = true;
 	bool all_optc_disabled = true, all_stream_disabled = true;
 
-	if (pg_cntl->ctx->dc->debug.disable_optc_power_gate)
-		return;
-
-	if (!power_on)
-		return;
-	if (pg_cntl->ctx->dc->idle_optimizations_allowed)
+	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->debug.disable_optc_power_gate ||
+		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
 	block_enabled = pg_cntl35_plane_otg_status(pg_cntl);
@@ -432,8 +418,7 @@ void pg_cntl35_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 			|| !all_stream_disabled || pg_cntl->pg_res_enable[PG_DWB])
 			return;
 	}
-	if (pg_cntl->ctx->dc->debug.ignore_pg)
-		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 46312a7b8c2b..cb2dc3f75ae2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -261,6 +261,7 @@ struct clk_mgr_funcs {
 
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
+	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
-- 
2.40.1

