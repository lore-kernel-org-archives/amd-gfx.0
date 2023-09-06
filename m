Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7EFEB8FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF5310E642;
	Wed,  6 Sep 2023 12:51:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3C910E63D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReNY70E4875AxTVHlAqnAUS/9UPVXHV2Qd8j49Dvj2dHaIGLxyhes9aXy5mlw4sGYYveQvqm0VByAORVL5OAsJFDum3wT0DXkMF5Wf7Boqsnhdrh/t30EUgRbAaTl5lRwoIVgyoqFCs/t0eVpCwNaBSx1enpXMHkC4ne36nQzUOQcuTrrzp9bfjd9Sk5oqUiFbGqds6mKb00UAGoTFcQqmMdrWQNt8+hX0bJKfDzwd1mXZ2n2o9mRNvWkhGpzXzJSbHCtiDNMqwW4EvMm2R8eV/bMRHBMLoZQX0dcqGYocqTiAAhmrg5rgg0JdNgO7mCiTklhJZZWzySAdGoFDnDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+0UGVn8Tpf4PAN5K1FlPJQhdfmnLx+vOdALd6wNpGs=;
 b=PW/qDsWI31S7mRVnPfp4DgnQPbFwiv92mP5iwn0m7KjMY9D78Y3Tdv9YYW2PHDcH0+qJOLmkDTf9ksfKR2kf9ClnNwOSokpaYZTgngdCTnZ5JVjBSEpvltg1OdXcUu0K6DNUhrPyU5q35Phqu3vBCgLC4OfCmgiE1FENsOqyN7KMm8z9exTDvmfZWKzzgmbpThDksL+RBe4duEhmqfZrcCprMzOfXrHH+E8Jp52tloyjZXoHH1iDqxsc1BPqLUSvqkuoLtHwbjkTUW28plrk1wQezPs8aFuHAvK63UJf+pgEWLGJhht870oL+Ei8PUaJVyGyqErcTqwjizzjeFAzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+0UGVn8Tpf4PAN5K1FlPJQhdfmnLx+vOdALd6wNpGs=;
 b=2vOQPywJGok2LnsYfvvqeaKCPoNooJqkcZ9pqNPY/dOMGXK08PkY23VPIguEya3S92KTPNNeP2UDMamgTha9h6txNQIzzlWGf2Ze5HYPrxDy2rAS2ikGL0cfPlYGjF7WRX6N+fzyX+NXsv9BKyQCLOTW6swPJunRenfM5D4jPa0=
Received: from BLAPR03CA0055.namprd03.prod.outlook.com (2603:10b6:208:32d::30)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:48 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::58) by BLAPR03CA0055.outlook.office365.com
 (2603:10b6:208:32d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:48 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/28] drm/amd/display: fix some non-initialized register mask
 and setting
Date: Wed, 6 Sep 2023 20:28:26 +0800
Message-ID: <20230906124915.586250-22-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 347f452c-8095-4414-9a4d-08dbaed808ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxiyUWOpGex0ONWMnYTnCxLhHGqAsvygCIemfXZpxmpRPREmsTaXIDBzLhqqZpLBlVTWgcx3BwRL8MMDPhfAYObW+M/NmHCKT2+y1IcDZ04PEzSAZClGby7AB4uR+gsR7kGA7T1cMoaqU8SZVb6HikUurhehZ7RIk3mq2NLvMNa89qpP7ib/3p5NJJ4Mrvua0e+KkSFLsRa1ZKCGWLxgJSolzBCtrhMfhvUoyw8M/9Hg+LYEUgC54sPNFM408pI/X2wMQNn7nNNKIJcm4eESRoomFPHd293Vlw39Q2CKjd5S3Z+8XvL9vBDqF24i5EKNB+B7yjHUKVDTEs/nCPJ2zeu91yVPDBmnHV/46BmR1U9auZy83m6+bgE04Nt/v8nn4/Ubm89bXT95ovhjihZ/E4SPCpZS1eYKMqTUeHkRUgfNzCHTOp4sglQYFQMv0ppm/kN4Y79AWfTJn07ls9HDfJe0FyRqPGGUlMoTdQbiUHcx0Fr27mBd3kqsc1xvKXM6fajbvXjydYQBgpEfvxplTKkxiCIdQYdO/1WL5ELd6M8Wf98rULmCzK1MiXPNH9EHgvhcp6p+Ms4pYUjGdmAPzWnurVERqLMacBO/cO+RjLmyDmd1CHpnf4LO2EJndfeMH8molqhQQ5qojjHYVXkTdVdk3MwtnyDOAbRqhfiJ9UtGqhn01tDyFdErTbd7CVmCE4T4j+0tceEMSz3yDxoHwSVgLe3xs3TFuuET8I7mdqRIWL21pI4mG4mVBj+eVOLLPhAjTO5U5Nhx3Sb/V66+Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(19627235002)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:48.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347f452c-8095-4414-9a4d-08dbaed808ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
fix some non-initialized register mask and update golden setting

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 56 ++++++++++++++-----
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  5 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  6 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 16 +++++-
 4 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 4fd25bb1ab92..37ffa0050e60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -53,6 +53,14 @@
 #define mmCLK1_CLK3_DFS_CNTL                            0x16E72
 #define mmCLK1_CLK4_DFS_CNTL                            0x16E75
 
+#define mmCLK1_CLK0_CURRENT_CNT                         0x16EE7
+#define mmCLK1_CLK1_CURRENT_CNT                         0x16EE8
+#define mmCLK1_CLK2_CURRENT_CNT                         0x16EE9
+#define mmCLK1_CLK3_CURRENT_CNT                         0x16EEA
+#define mmCLK1_CLK4_CURRENT_CNT                         0x16EEB
+
+#define mmCLK4_CLK0_CURRENT_CNT                         0x1B0C9
+
 #define CLK1_CLK_PLL_REQ__FbMult_int_MASK               0x000001ffUL
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK              0x0000f000UL
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK              0xffff0000UL
@@ -452,6 +460,26 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 
 static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr_internal *clk_mgr)
 {
+    unsigned int dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
+    unsigned int dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
+    unsigned int dprefclk_khz_reg   = REG_READ(CLK1_CLK2_CURRENT_CNT); // DPREFCLK
+    unsigned int dcfclk_khz_reg     = REG_READ(CLK1_CLK3_CURRENT_CNT); // DCFCLK
+    unsigned int dtbclk_khz_reg     = REG_READ(CLK1_CLK4_CURRENT_CNT); // DTBCLK
+    unsigned int fclk_khz_reg       = REG_READ(CLK4_CLK0_CURRENT_CNT); // FCLK
+
+    // Overrides for these clocks in case there is no p_state change support
+    int dramclk_khz_override = new_clocks->dramclk_khz;
+    int fclk_khz_override = new_clocks->fclk_khz;
+
+    int num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
+
+    if (!new_clocks->p_state_change_support) {
+	    dramclk_khz_override = clk_mgr->base.bw_params->max_memclk_mhz * 1000;
+    }
+    if (!new_clocks->fclk_p_state_change_support) {
+	    fclk_khz_override = clk_mgr->base.bw_params->clk_table.entries[num_fclk_levels].fclk_mhz * 1000;
+    }
+
 	////////////////////////////////////////////////////////////////////////////
 	//	IMPORTANT: 	When adding more clocks to these logs, do NOT put a newline
 	//	 			anywhere other than at the very end of the string.
@@ -466,20 +494,20 @@ static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr
 		new_clocks->dcfclk_khz > 0 &&
 		new_clocks->dppclk_khz > 0) {
 
-		if (new_clocks->p_state_change_support) {
-			DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk_khz:%d - fclk_khz:%d - "
-						 "dcfclk_khz:%d - dppclk_khz:%d\n",
-						 new_clocks->dramclk_khz,
-						 new_clocks->fclk_khz,
-						 new_clocks->dcfclk_khz,
-						 new_clocks->dppclk_khz);
-		} else {
-			DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk_khz:1249000 - fclk_khz:%d - "
-						 "dcfclk_khz:%d - dppclk_khz:%d\n",
-						 new_clocks->fclk_khz,
-						 new_clocks->dcfclk_khz,
-						 new_clocks->dppclk_khz);
-		}
+		DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk:%d - fclk:%d - "
+			"dcfclk:%d - dppclk:%d - dispclk_hw:%d - "
+			"dppclk_hw:%d - dprefclk_hw:%d - dcfclk_hw:%d - "
+			"dtbclk_hw:%d - fclk_hw:%d\n",
+			dramclk_khz_override,
+			fclk_khz_override,
+			new_clocks->dcfclk_khz,
+			new_clocks->dppclk_khz,
+			dispclk_khz_reg,
+			dppclk_khz_reg,
+			dprefclk_khz_reg,
+			dcfclk_khz_reg,
+			dtbclk_khz_reg,
+			fclk_khz_reg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 085b269c654f..c429590f1298 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -577,7 +577,10 @@ struct dcn10_stream_enc_registers {
 	type DIG_FIFO_READ_START_LEVEL;\
 	type DIG_FIFO_ENABLE;\
 	type DIG_FIFO_RESET;\
-	type DIG_FIFO_RESET_DONE
+	type DIG_FIFO_RESET_DONE;\
+	type PIXEL_ENCODING_TYPE;\
+	type UNCOMPRESSED_PIXEL_FORMAT;\
+	type UNCOMPRESSED_COMPONENT_DEPTH
 
 #define SE_REG_FIELD_LIST_DCN3_5_COMMON(type) \
 	type DIG_FE_CLK_EN;\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 580fea4fde52..46312a7b8c2b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -45,11 +45,12 @@
 
 struct dcn3_clk_internal {
 	int dummy;
-	/*TODO:
+//	TODO:
 	uint32_t CLK1_CLK0_CURRENT_CNT; //dispclk
 	uint32_t CLK1_CLK1_CURRENT_CNT; //dppclk
 	uint32_t CLK1_CLK2_CURRENT_CNT; //dprefclk
 	uint32_t CLK1_CLK3_CURRENT_CNT; //dcfclk
+	uint32_t CLK1_CLK4_CURRENT_CNT;
 	uint32_t CLK1_CLK3_DS_CNTL;	//dcf_deep_sleep_divider
 	uint32_t CLK1_CLK3_ALLOW_DS;	//dcf_deep_sleep_allow
 
@@ -57,7 +58,8 @@ struct dcn3_clk_internal {
 	uint32_t CLK1_CLK1_BYPASS_CNTL; //dppclk bypass
 	uint32_t CLK1_CLK2_BYPASS_CNTL; //dprefclk bypass
 	uint32_t CLK1_CLK3_BYPASS_CNTL; //dcfclk bypass
-	*/
+
+	uint32_t CLK4_CLK0_CURRENT_CNT; //fclk
 };
 
 struct dcn301_clk_internal {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index cff5fd55a0ad..9a595246824d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -163,7 +163,13 @@ enum dentist_divider_range {
 	CLK_SR_DCN32(CLK1_CLK1_DFS_CNTL), \
 	CLK_SR_DCN32(CLK1_CLK2_DFS_CNTL), \
 	CLK_SR_DCN32(CLK1_CLK3_DFS_CNTL), \
-	CLK_SR_DCN32(CLK1_CLK4_DFS_CNTL)
+	CLK_SR_DCN32(CLK1_CLK4_DFS_CNTL), \
+    CLK_SR_DCN32(CLK1_CLK0_CURRENT_CNT), \
+    CLK_SR_DCN32(CLK1_CLK1_CURRENT_CNT), \
+    CLK_SR_DCN32(CLK1_CLK2_CURRENT_CNT), \
+    CLK_SR_DCN32(CLK1_CLK3_CURRENT_CNT), \
+    CLK_SR_DCN32(CLK1_CLK4_CURRENT_CNT), \
+    CLK_SR_DCN32(CLK4_CLK0_CURRENT_CNT)
 
 #define CLK_COMMON_MASK_SH_LIST_DCN32(mask_sh) \
 	CLK_COMMON_MASK_SH_LIST_DCN20_BASE(mask_sh),\
@@ -222,6 +228,8 @@ struct clk_mgr_registers {
 	uint32_t CLK4_CLK2_CURRENT_CNT;
 	uint32_t CLK4_CLK_PLL_REQ;
 
+	uint32_t CLK4_CLK0_CURRENT_CNT;
+
 	uint32_t CLK3_CLK2_DFS_CNTL;
 	uint32_t CLK3_CLK_PLL_REQ;
 
@@ -235,6 +243,12 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK3_DFS_CNTL;
 	uint32_t CLK1_CLK4_DFS_CNTL;
 
+	uint32_t CLK1_CLK0_CURRENT_CNT;
+    uint32_t CLK1_CLK1_CURRENT_CNT;
+    uint32_t CLK1_CLK2_CURRENT_CNT;
+    uint32_t CLK1_CLK3_CURRENT_CNT;
+    uint32_t CLK1_CLK4_CURRENT_CNT;
+
 	uint32_t CLK0_CLK0_DFS_CNTL;
 	uint32_t CLK0_CLK1_DFS_CNTL;
 	uint32_t CLK0_CLK3_DFS_CNTL;
-- 
2.42.0

