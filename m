Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F034ECD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D08A10F885;
	Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlqUjual";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F24710F4F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KemirVB1kbn1L8xmATCQNv7QMMam7kyL5sUwLhW+FJjMUIS5Tqk0wJ+b/5bKRXzEuuTxEfTU3ilXe4157IevRhwA9oSwupFKLHaukVz3Dod8o9rtkvD0Q5tiPvC1DED7KepoG53v/jXGz43eCgXAPl3uEVMY22NWPGVw4fvwDRFaUKDZXv0XGhNwLAwg6QXMR8ezbrN724klBRnXWhfrQ9vur3croJ/HAWCT3ftrN7KD/tCvDtxoFp4vUPaynlE+RGHDCGxJCTs3I32xGrviXE9mGg16iKIDtKhaEsaYNvyjLtMXK0AAINtyHxjhdfy+/0gtigm3BhindGKtNRY9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL6Orm4M1sNatsWLj+Rawun+km9g7ZHODrXHXFWpBL4=;
 b=FPeQ3N3vs6NPAaxMu27mi12LGWu6gKgetr472uPtsKT8u+K+1X2pAng0NrDSxix9Ur4HmfBsDC8W9ouKL4DZJSjOzWCtwpRF9QVuFJ6R6Xw3Tl+3RNabtRZP7YVLihzkmBT1xNz+hfoVRlreUz6I8FIexHcTLX9L4qtN79o354YiKGtbuembNriQMeXwUiW8zsJ8/QZmWzUxGxNmAC7/6ntUM+PgeHGJ0BHcDgcXUwWiovNTIRRUZCWMbI3IosPghLydrdFrHp7ucg2gQSoZRn8j/aNMJw9t/+g4SAFoajsaMN8qLKS3EEE+xbsASX0zUDGFHtA/LCHscRhgUxfzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL6Orm4M1sNatsWLj+Rawun+km9g7ZHODrXHXFWpBL4=;
 b=mlqUjualdIG3CCDL2NFq9jtDlxSfUiFmb4fldUcvP+l+4k8pIK8wpNWOv6fKX7j7QsRYPU9iudZA1ACsV4LZJ3VSeLW0okY10Qj04dQwZBSobmxpid2eWFO+G+yUqX+A9ZWS8AIi1VibnNQssow+AsIE1LfKPVGmunTAjADdR5w=
Received: from CH2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:610:54::12)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:39 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::c1) by CH2PR11CA0002.outlook.office365.com
 (2603:10b6:610:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:38 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:38 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, George Shen
 <george.shen@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 13/43] drm/amd/display: Add dummy interface for tracing DCN32
 SMU messages
Date: Thu, 28 Mar 2024 15:50:17 -0400
Message-ID: <20240328195047.2843715-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9e98fc-053d-4f74-93ef-08dc4f607bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqDiHuqLbbgdYlhV3myH4PJZX2ygdyHZ/4g1aF070cvtQJqV5IMeIBsk9ceSarHck3YOqMmuEqLnmo/97LH/URVCMQ+v/Lyy2QmowIgSIU4GUvqOBpomt7nk+yzFQQ2lj12BY0KTtvPKROG8DSgO3c6nDk+DxIO6jBq8XR0nLootD/oU9AZPrJ+AbYNsXa05BmO0ygVEne2DkezH3B2nlV56rzNwVqcBk4J6gj4UEz4BLvBvqMNASyAoOdbBSdUGUJapRtriouVmcoxZM5fC456WSOGMznaamD383mJOHUyVRkYbSM58/awjCUNzwUxc0F2SjW3K3PUJUV82AZ8M0yvIN31lipTKGnupcf+osaTbYO+SjFoDTA7zvIe/SI0CkT4hig6fTwJPc27OCOFTeIwElvdjICIywY19JDUwQQ/MxErOygdhTys3LdVuJdOFtc7aaK/j8QE35VVlj/Tpc/XXngUJwMU5FC6paee+pZvHTksTPifPr72v3EOpc/0UYZiAmV1kLTJiiQsQdk+7pIw/ysz0wh6OhMns0+wvikHgggXyXPm1REI0fo5AHX9qMIZFhyMCpID4IcBPX6CtWJCBPtISy+zkC+VJbWtdD72L/OHfHJEEkoxig0OKU7TkPf6zkVP5QojFoC3LMgc9cpY1phprssewdOpyG/aEGtEg3AwH3nPq7OWLdYDGQTb0dCB8ZtaxY8261IIVZolPU/vR24/bCOc2wxFHKi5pSLqqAxY4nAJGfdd7rMTqZvUX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:39.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9e98fc-053d-4f74-93ef-08dc4f607bdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why/How]
Some issues may require a trace of the previous SMU messages from DC to
understand the context and aid in debugging. Actual logging to be
implemented when needed.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |  8 ++++++++
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c   |  5 ++++-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c   |  9 +++++++++
 drivers/gpu/drm/amd/display/dc/dm_services.h           | 10 ++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index d9e33c6bccd9..0005f5f8f34f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -52,4 +52,12 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 				    func_name, line);
 }
 
+void dm_trace_smu_msg(uint32_t msg_id, uint32_t param_in, struct dc_context *ctx)
+{
+}
+
+void dm_trace_smu_delay(uint32_t delay, struct dc_context *ctx)
+{
+}
+
 /**** power component interfaces ****/
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index bdbf18306698..64c2b88dfc9f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -54,6 +54,7 @@
  */
 static uint32_t dcn30_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
 {
+	const uint32_t initial_max_retries = max_retries;
 	uint32_t reg = 0;
 
 	do {
@@ -69,7 +70,7 @@ static uint32_t dcn30_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 
 	/* handle DALSMC_Result_CmdRejectedBusy? */
 
-	/* Log? */
+	TRACE_SMU_DELAY(delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
 
 	return reg;
 }
@@ -89,6 +90,8 @@ static bool dcn30_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uint
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(DAL_MSG_REG, msg_id);
 
+	TRACE_SMU_MSG(msg_id, param_in, clk_mgr->base.ctx);
+
 	result = dcn30_smu_wait_for_response(clk_mgr, 10, 200000);
 
 	if (IS_SMU_TIMEOUT(result)) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index df244b175fdb..f2f60478b1a6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -49,6 +49,7 @@
  */
 static uint32_t dcn32_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, unsigned int delay_us, unsigned int max_retries)
 {
+	const uint32_t initial_max_retries = max_retries;
 	uint32_t reg = 0;
 
 	do {
@@ -62,6 +63,8 @@ static uint32_t dcn32_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 			udelay(delay_us);
 	} while (max_retries--);
 
+	TRACE_SMU_DELAY(delay_us * (initial_max_retries - max_retries), clk_mgr->base.ctx);
+
 	return reg;
 }
 
@@ -79,6 +82,8 @@ static bool dcn32_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, uint
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(DAL_MSG_REG, msg_id);
 
+	TRACE_SMU_MSG(msg_id, param_in, clk_mgr->base.ctx);
+
 	/* Wait for response */
 	if (dcn32_smu_wait_for_response(clk_mgr, 10, 200000) == DALSMC_Result_OK) {
 		if (param_out)
@@ -115,6 +120,8 @@ static uint32_t dcn32_smu_wait_for_response_delay(struct clk_mgr_internal *clk_m
 		*total_delay_us += delay_us;
 	} while (max_retries--);
 
+	TRACE_SMU_DELAY(*total_delay_us, clk_mgr->base.ctx);
+
 	return reg;
 }
 
@@ -135,6 +142,8 @@ static bool dcn32_smu_send_msg_with_param_delay(struct clk_mgr_internal *clk_mgr
 	/* Trigger the message transaction by writing the message ID */
 	REG_WRITE(DAL_MSG_REG, msg_id);
 
+	TRACE_SMU_MSG(msg_id, param_in, clk_mgr->base.ctx);
+
 	/* Wait for response */
 	if (dcn32_smu_wait_for_response_delay(clk_mgr, 10, 200000, &delay2_us) == DALSMC_Result_OK) {
 		if (param_out)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index d0eed3b4771e..9405c47ee2a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -274,6 +274,16 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 #define PERF_TRACE()	dm_perf_trace_timestamp(__func__, __LINE__, CTX)
 #define PERF_TRACE_CTX(__CTX)	dm_perf_trace_timestamp(__func__, __LINE__, __CTX)
 
+/*
+ * SMU message tracing
+ */
+void dm_trace_smu_msg(uint32_t msg_id, uint32_t param_in, struct dc_context *ctx);
+void dm_trace_smu_delay(uint32_t delay, struct dc_context *ctx);
+
+#define TRACE_SMU_MSG(msg_id, param_in, ctx)	dm_trace_smu_msg(msg_id, param_in, ctx)
+#define TRACE_SMU_DELAY(response_delay, ctx)	dm_trace_smu_delay(response_delay, ctx)
+
+
 /*
  * DMUB Interfaces
  */
-- 
2.34.1

