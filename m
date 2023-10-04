Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BA4E8FDDB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CB510E0EB;
	Wed,  4 Oct 2023 09:23:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A116E10E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMCcyCPJxHrVYy0oZpVPzg32K4aKINCr2X+Xc3zd+xCu2fKY90hptMmEsbJexbo+5lWkbWYn7WvSB9p9LopTO9wpg4Y+qH9A5tw902mHvYEZkhNdX7AMmk+cIdMyUce3a47+/24/Dg93nCKGvO2JAZ5T5/paxQaHB16lRmYw6DBS0Ah/G4b5fmc6mojwpQ3+X3MmH9Kt2MliLbPkd4KnqILO0PKW7G2iLtu2NovEgn9CwRo0aosG486cKK5U8BVDJNeSMUMPoC5IqjRT0lhr049iBY7GFVm/ZAxBORYDxtdDjXbQMBWh1ZSd63D2NICTF7iTPYl0o/frG3ChcKUl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYmNWssSHPrv5kzgK+iuHPblMhLKDjA5LigwQLQvzDc=;
 b=IIrmP5tTn/XnOTw9OXVk6NxMAvXW6kafXfbBZ7pIgGwLK8pLH/XiV02CZi12iZ/1GisVxEvuCdBg9PhbyiTdnpjquXFzmguKYQfKGq+6DpQkMloyp+NNF3TKNQwZvpzNCalRCDurgFZvfOgt/VvX1EVc/A97r/tVV1bzuC5UspXt2YwRXMjs2RTIaapz0bsWbfKPjSDxVI8LWPu08L5K25EwvFTIOTfPMSfHsJ06PdKoiK73Qo/f8eHdsGy7C4UYrugivlPbeQ6yy+XGFPa3sTkPuB7WiR79OSuCikzcb8sn5gv0HIYFSt9vyE89j4uEDMQMaWgX4cgI5x8icQl0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYmNWssSHPrv5kzgK+iuHPblMhLKDjA5LigwQLQvzDc=;
 b=BGyCUhED9JLu5JpRzFslSuXKm9rk1RhE8bBg9KuacSu3PfW25WA0e6JIcipNlxJULCNAyxQ6aiY4+7Hn0cbPkyVbNnajZb98nopUbsNNTnB/hx54FhYiu3BbG0gw3MOWUfMIXdDUMWJYr0gSShnh/MyYoj3D8efxgS1cDM6l/eI=
Received: from BL0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:2d::39)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:23:29 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::c2) by BL0PR03CA0026.outlook.office365.com
 (2603:10b6:208:2d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:28 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:23 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Modify SMU message logs
Date: Wed, 4 Oct 2023 17:22:46 +0800
Message-ID: <20231004092301.2371458-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8079cf-585e-4e96-7c63-08dbc4bb9234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB7dZn3X9Rjir24/x0hdBb2qvSE8Yj/63Yzq5zgaB5s7b5dW/95iSUtAWooTv2HZKi/hhCVNJQ1SOe1K5GKNUOluBZUD8IBURUJf0JFogN+c3WpwvXRKofRdyBJHpDMd0LtUny0kDStiqe+Ll9mQndWWC7morCtoLgETsrfq6yeG01FOLEGffpKKYj3+yKI1xwvWDJFmBM/W7onBCk/nJibouLNBMCTNP91hHMfxbVrB5LJtkfgjeRBaFRdz73bo2D+0Uv1RTJvIznOGQBbOla22WrGykbb/NTx5Dh7fSofqBXu7D0IsJleq9e7y1XI+lG56rXGR47OpMaYtkuybzOi0yeSMFLBMhF5jwGEUECwNZVw98SokaJ/pFEysXMnZHNj/rC409DIEJn3gqWRbbJaYy724kptLwYVLyOijAzVPrGXerDOGDBQu3sD1ie9LkLiNp1GUtGT7cDH9cifeln8DXYxC8XQczrJTyHJhTIZUVyDXncZgSDy8uxQwhaSIAQ5dc8oERsoC0jkfBbSLzZKRMkGMBFuwK5i9YIfv1MyDxYBt2hsRn19W1LZgIuDanPQXKfs9w1pnYWBvzOouS+4bzOT6mJ7h7RNWJDR5bqygtrZDZNNBYKGr7WJzbG5sanoGSQeMu+A/Y/DVkoP0MJhaXgorlPeRMT9wXIDkK8Inc1HZGVERjcbFKJgM27zT1Xu0EYo1kiGvoVwDHSWtCLqMbrxHwSRU+NrQ3bwwFsLCpPPl3tgsNn3R3p9T+NwK0SkIa1NiamerVf4/TyrrgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(478600001)(6666004)(7696005)(36860700001)(40460700003)(2616005)(36756003)(1076003)(40480700001)(2906002)(15650500001)(54906003)(336012)(426003)(47076005)(86362001)(70586007)(70206006)(8676002)(83380400001)(356005)(5660300002)(41300700001)(316002)(8936002)(4326008)(82740400003)(6916009)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:29.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8079cf-585e-4e96-7c63-08dbc4bb9234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Sung Joon Kim <sungkim@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
It's important to make sure SMU messages
are logged by default to improve debugging for
power optimization use cases.

[how]
Change logs to warnings when SMU message
returns non-success id.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c |  1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/dc.h                  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c |  1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index b5acd7b01e40..21dfe3faf08c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1046,6 +1046,7 @@ void dcn35_clk_mgr_construct(
 			ctx->dc->debug.disable_dpp_power_gate = false;
 			ctx->dc->debug.disable_hubp_power_gate = false;
 			ctx->dc->debug.disable_dsc_power_gate = false;
+			ctx->dc->debug.disable_hpo_power_gate = false;
 		} else {
 			/*let's reset the config control flag*/
 			ctx->dc->config.disable_ips = 1; /*pmfw not support it, disable it all*/
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index cf74e69cb2a1..b6b8c3ca1572 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -130,11 +130,11 @@ static int dcn35_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	result = dcn35_smu_wait_for_response(clk_mgr, 10, 2000000);
 	ASSERT(result == VBIOSSMC_Result_OK);
 
+	if (result != VBIOSSMC_Result_OK) {
+		DC_LOG_WARNING("SMU response after wait: %d, msg id = %d\n", result, msg_id);
 
-
-	if (result == VBIOSSMC_Status_BUSY) {
-		smu_print("SMU response after wait: %d\n", result);
-		return -1;
+		if (result == VBIOSSMC_Status_BUSY)
+			return -1;
 	}
 
 	/* First clear response register */
@@ -155,7 +155,7 @@ static int dcn35_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 		else
 			ASSERT(0);
 		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
-		smu_print("SMU response after wait: %d\n", result);
+		DC_LOG_WARNING("SMU response after wait: %d, msg id = %d\n", result, msg_id);
 		return -1;
 	}
 
@@ -163,7 +163,7 @@ static int dcn35_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 		ASSERT(0);
 		result = dcn35_smu_wait_for_response(clk_mgr, 10, 2000000);
 		//dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
-		smu_print("SMU response after wait: %d\n", result);
+		DC_LOG_WARNING("SMU response after wait: %d, msg id = %d\n", result, msg_id);
 	}
 
 	return REG_READ(MP1_SMN_C2PMSG_83);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7d1ce58d493b..6c51ebf5bbad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -830,6 +830,7 @@ struct dc_debug_options {
 	bool disable_hubp_power_gate;
 	bool disable_dsc_power_gate;
 	bool disable_optc_power_gate;
+	bool disable_hpo_power_gate;
 	int dsc_min_slice_height_override;
 	int dsc_bpp_increment_div;
 	bool disable_pplib_wm_range;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index ccfd3102e5a0..e62a192c595e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -262,6 +262,7 @@ void pg_cntl35_hpo_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	bool block_enabled;
 
 	if (pg_cntl->ctx->dc->debug.ignore_pg ||
+		pg_cntl->ctx->dc->debug.disable_hpo_power_gate ||
 		pg_cntl->ctx->dc->idle_optimizations_allowed)
 		return;
 
-- 
2.25.1

