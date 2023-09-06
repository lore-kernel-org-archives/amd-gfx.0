Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF71EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A59E10E639;
	Wed,  6 Sep 2023 12:49:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C5410E639
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW6IF8qFUoM6Oll5W+hKCYVj9THkEIlUfLR6EupKges777L9b64ObVTTXHIlRhv0bbXhXcwtudcivdoU659Y4Ik92XkR51qb7SLP9yCsbzLxfFdYZ7PWYNit0K5ArgET0fMZLKUaCHooKntCnpjaLUgOAJxHJmjTkhTDa9FtTj6fb+KAH5A3Ir/KDpVbN1higPUS3d/xtzcvep/yWZHO9KwlbOLYlPYRJv5AKX3ik9dfSnUO3qI8eZb1oC/I4rEUK4MqZrtrEGFC1KM0LTqTCG3uy/9uXWiPc79MFeLYmnDD8q/ev2UyA4XXunU/DV5a+WmrKdcvPGOvKyuNMXMcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/h1RoeRQsaOquE37F7+nx6Vs6eu6kW4FlMhGROeGhs=;
 b=g/QNd7MooIJ4yZBANaD5juBtPtfdnDCqjBvXhVJys+2+ZFybBJN9SGLI2GrSwZJl4kqW4iitslZuFG7+Thbq/UNOfFIcXqy0kp+nWOlCaY+izZff2pXdxz3ieLv26CN//YJAylJVBcgzEPAiCaZ8Tl1jlqaKTkeicim2cszU21KdJWX+xYrxrTH3JFWKg5+mcSrx7XNlOdewKC8DyBWYLyev8Octn6K6RvZbu/Vj6d1GhnmNGpYnxQd/zGNOyNFS4fD5EucisiRY78sbcsBCHmOF5dynGGnP9prilo2SwBO+Pr2V0m9WsbXV2tnPFoqQb0IxyCHBqDehMRI6aJXgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/h1RoeRQsaOquE37F7+nx6Vs6eu6kW4FlMhGROeGhs=;
 b=FIzzQnDTe8IiIf090RZP0K2tZX+ZOQ7OCMYz1H95EL4p3Z1T5UFQU+8CEQD+3G2TB7m0qRMVsmaJBBsNLjyVDKid38khAcGpi7tu+aHz0AhsBvmwiVh4tD0/zel63ArlBFqlOHCZ7Lj02ZlssqpEgjoJ6vPtWO7SkOsYGmP6R3I=
Received: from CYZPR10CA0019.namprd10.prod.outlook.com (2603:10b6:930:8a::28)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.35; Wed, 6 Sep
 2023 12:49:51 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::48) by CYZPR10CA0019.outlook.office365.com
 (2603:10b6:930:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:50 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:46 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/28] drm/amd/display: Add new logs for AutoDPMTest
Date: Wed, 6 Sep 2023 20:28:17 +0800
Message-ID: <20230906124915.586250-13-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: ee845cae-1558-49cb-c097-08dbaed7c29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irb15JuGORx/wRA8ASMQxT6rPPxfzKVnRNwCKWS/2hEqXTtigwrXF7ZXTzFHNiYHfn6G3uXqLuoiDZZrCiTVkAh9vWgnB5DJqR4xdj+OZ/8+O3pcCPgImUhL4USM4W9WcvZ0imqJM3gvUvNGE+DZgBNL2VsaWCjktpebqB6SIlziQGMhWoc9GEWcUfBHA0lhJNEYfvUALO1Xf22iSyWBWPod2Pg/jt+TmGb3amk5oP52kMs3gS3/sRYocu+7LALNf+wTl0MEzCIZucns4fDa4MgNEnqWXcN0MyNWAl/CjFeqHoMzyNtevyhANFr2x+sIwYVgq2f9uGS9s50leEAuPkx9g4OowQcwo5SNDpdzDchC0jHGrayzrxAuQDlvozzzJmDdTZ/5GyB3UxBWUJXB3XJiABFUY5BL+NffQQKTruHJGay5EJsTRigz47IZGnjKCJNjJNB1Rry1KwcWdHK+tM2hyIC7K3TK97CMu7mzPFIAy95JXSLXB3bdV7n+l9h/YROYgLWsWEAdxde23drFMyFWOVxRLQxo7LbZrQQ4RRhiZ1MR9PfvHKA8wzBRnIv5S6FFVwEAdm/xoMsFq6CXsNXslk6p23kxjGWWDlQ6fUHa0XxjV2t9/pUKKZ7sK9hhFdejOag16diqzVnGcdoQnEeqSRYUhIUhSmNU6KY/NZgu1JIIH5znGeqAb7XxpnQcfafz6p2HAaulRMShC5wKYLSsnoUb9mPeQIZkfuSj121lSHL2igzct/6w7HVCRiEBxF2Rlu4v23MJpX3tor+4mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(83380400001)(26005)(1076003)(2616005)(426003)(16526019)(336012)(2906002)(44832011)(6916009)(54906003)(316002)(41300700001)(70586007)(70206006)(5660300002)(4326008)(8936002)(8676002)(40460700003)(40480700001)(47076005)(36860700001)(86362001)(36756003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:50.8243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee845cae-1558-49cb-c097-08dbaed7c29a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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
Cc: stylon.wang@amd.com, Ethan Bitnun <etbitnun@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <etbitnun@amd.com>

[Description]
 - Add new logs to be used by the AutoDPMTest
 - Enclose AutoDPMTest logs in settings
 - Add logging definition

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/include/logger_types.h    |  5 ++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 984b52923534..4fd25bb1ab92 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -450,6 +450,38 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	return 0;
 }
 
+static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr_internal *clk_mgr)
+{
+	////////////////////////////////////////////////////////////////////////////
+	//	IMPORTANT: 	When adding more clocks to these logs, do NOT put a newline
+	//	 			anywhere other than at the very end of the string.
+	//
+	//	Formatting example (make sure to have " - " between each entry):
+	//
+	//				AutoDPMTest: clk1:%d - clk2:%d - clk3:%d - clk4:%d\n"
+	////////////////////////////////////////////////////////////////////////////
+	if (new_clocks &&
+		new_clocks->dramclk_khz > 0 &&
+		new_clocks->fclk_khz > 0 &&
+		new_clocks->dcfclk_khz > 0 &&
+		new_clocks->dppclk_khz > 0) {
+
+		if (new_clocks->p_state_change_support) {
+			DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk_khz:%d - fclk_khz:%d - "
+						 "dcfclk_khz:%d - dppclk_khz:%d\n",
+						 new_clocks->dramclk_khz,
+						 new_clocks->fclk_khz,
+						 new_clocks->dcfclk_khz,
+						 new_clocks->dppclk_khz);
+		} else {
+			DC_LOG_AUTO_DPM_TEST("AutoDPMTest: dramclk_khz:1249000 - fclk_khz:%d - "
+						 "dcfclk_khz:%d - dppclk_khz:%d\n",
+						 new_clocks->fclk_khz,
+						 new_clocks->dcfclk_khz,
+						 new_clocks->dppclk_khz);
+		}
+	}
+}
 
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
@@ -646,6 +678,10 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/*update dmcu for wait_loop count*/
 		dmcu->funcs->set_psr_wait_loop(dmcu,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
+
+	if (dc->config.enable_auto_dpm_test_logs) {
+	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr);
+	}
 }
 
 static uint32_t dcn32_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7e6f819a9952..05ab24c81041 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -420,6 +420,7 @@ struct dc_config {
 	int sdpif_request_limit_words_per_umc;
 	bool use_old_fixed_vs_sequence;
 	bool dc_mode_clk_limit_support;
+	bool enable_auto_dpm_test_logs;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 3bf08a60c45c..fb657f7408a7 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -73,6 +73,7 @@
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_DP2(...) DRM_DEBUG_KMS(__VA_ARGS__)
+#define DC_LOG_AUTO_DPM_TEST(...) pr_debug("[AutoDPMTest]: "__VA_ARGS__)
 
 struct dal_logger;
 
@@ -128,6 +129,7 @@ enum dc_log_type {
 	LOG_SAMPLE_1DLUT,
 	LOG_DP2,
 	LOG_DC2RESERVED12,
+	LOG_AUTO_DPM_TEST,
 };
 
 #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
@@ -157,7 +159,8 @@ enum dc_log_type {
 		(1ULL << LOG_IF_TRACE) | \
 		(1ULL << LOG_HDMI_FRL) | \
 		(1ULL << LOG_SCALER) | \
-		(1ULL << LOG_DTN) /* | \
+		(1ULL << LOG_DTN) | \
+		(1ULL << LOG_AUTO_DPM_TEST)/* | \
 		(1ULL << LOG_DEBUG) | \
 		(1ULL << LOG_BIOS) | \
 		(1ULL << LOG_SURFACE) | \
-- 
2.42.0

