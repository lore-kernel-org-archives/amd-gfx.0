Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A5DCCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F9410F3D6;
	Fri, 17 Jun 2022 19:35:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA03810F3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7SAf8R3f0uyArhVizqJvS6KiHNE6AbbSk2FB9tQGkzFm5bgpRsupoPNZqgEyaSa+bW94OXQ7HJx/Rc2LLKkbF1Va4qkQPv0RUNtKXUCF6r62EF6Zsa6M8biKoyHnZQX+Dtm2AFlAz/1DpAeO1LIXRTfEOHnuwoXS14fQ1u/UuSxAX0iZVXPcB5fElaVQVrRmqvi3bwsNqoqxbclXKpQsidiY3TxosTBuG/ATXI35fg7om+QgAD6leZyGrtXTI6kV5FbkNLIY1jnxrVVnC4BoCoIEgmx1VPKUX5NDg0fwuC805y0jhNGP7rX9I82f7cJHs8FnYYyzh65CfDm23EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx43pbDe8lxF+PdtDNOMfoMYJdKlmIO030MbmlLPfAA=;
 b=bML9UriSqmlZ6nJnCX3/e2zXwJpPaafQekoD7KgGPEpOPAXhx6bFpN/slLlLCjKxT64KlWsef+fUt39hOaoyiAvEUMl1Alaa5j+zxF7U36sOy4M55bFRFKmnmkp9ZhWii31qe/DnH05kQQWZDoJAraqy8e6muH3lQ9iaQ7amPy46PCAcxvxeFe4tFmpc5Qfnf15ii6m9x/k6806zb8Qqq+qvLwjkKg4aJRaw23NJrxEI4uDTlc9m8SEiUW0VpQ9c/w038E8y7GaVGGSe682gfvQJSxMkW8mpI59lT9kxIFectjszRZZFlcsOQ1DsiYRV43EzavAwofQNXNSGz6oPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx43pbDe8lxF+PdtDNOMfoMYJdKlmIO030MbmlLPfAA=;
 b=zCJlLLQfhd/sf0v0hPBeT7Nip3srpopGWBPyiSdZd/Wo8ecalAQj5g+HGaSCW8yiLvAsmsouE4hz52iR/zfyA9YkfdkP9VE48iHkwCb/p3tcMKzGUG+nI1qoG9JaifoSsBZORBYd4y3w+OOmDwKKYOyBJp/Gqdt4vpCesrKiq9o=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by BN7PR12MB2770.namprd12.prod.outlook.com (2603:10b6:408:32::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:54 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::16) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:54 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/31] drm/amd/display: Change initializer to single brace
Date: Fri, 17 Jun 2022 15:34:58 -0400
Message-ID: <20220617193512.3471076-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d17858-b290-4543-557a-08da5098981e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2770:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27703A936DFABFA614A24DF598AF9@BN7PR12MB2770.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwlY2ie2CMwgqIknVJqGS+9PzMM0phg2fmHmpQFFORT7cUTb6U0Yyqu81znPxww7Ef3W61RVKbCkCrNXDF/Sphl/aoa8YQm0PMI++K1Wlsp/dcN0/ofJ7roWmd1lEz1wD0kLog3kcOVsj7wCMytBRL0HUs4Vle33yb++kZzn09+Oph+u5xUxy0RpIfHzzNdiLzB182XI9o4+4g/dyQsSDgbH9IJhjelV33wg0hrIB7JXuE/hftD4a+eBS08fJLrW+9PftM0/IhqjepLF2pRClAVcQ9H5GPF8JuRlUO/wUwYmETzhFN1zQO8n9FRrAJ+DpsXEBc61SEblC34ZlyW74uY/fG9T1bM2DxmxEoha7Ac6ugeZhMtkjuVSuOoR95pBisXfk3wo1pu7ix/1A2PIU7z+xyukz3/+m0P5A+alNFadnMfTxJ2f8Rmw7vYv2i50O6Zi7UMJlk/aoA5EgX/joTlDX+9FoewUPrJmYikO66NcUg0kPGN9eUz6U9QXF2iq8DdkpOOMaENH0wHO77Ywlw4n3nd9sf8D2fee8iP37kAFX6sRwBCz1o9NlutgHUHIe+VqYiagPHxt+ec09v7rH+T0VnSnSkoXwQp44Ihy1JxnzxZFFs/Ln4ckdNVBRb61hMvM3dv4BfXq+8QsuhENtSXiKwZFG0GqiPYll6LyYGmozI3lqQn99xUjji/PzZObxRUxFw1LANf1HIOZjtl3DFhNBx1Xf4456hJgvJvgp33ptuxqUMfI3+/5EBelaKtx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(4326008)(40460700003)(2616005)(336012)(316002)(70206006)(70586007)(1076003)(426003)(186003)(6916009)(5660300002)(8936002)(26005)(16526019)(54906003)(86362001)(36860700001)(47076005)(2906002)(81166007)(36756003)(83380400001)(8676002)(498600001)(7696005)(82310400005)(356005)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:54.2941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d17858-b290-4543-557a-08da5098981e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2770
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why & How]
Change struct initializer from multiple brace to single brace.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  6 ++--
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 28 +++++++++----------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 58882d42eff5..b021ea49bece 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1528,7 +1528,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 				     const struct link_init_data *init_params)
 {
 	uint8_t i;
-	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
+	struct ddc_service_init_data ddc_service_init_data = { 0 };
 	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
 	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
@@ -1828,7 +1828,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 static bool dc_link_construct_dpia(struct dc_link *link,
 				   const struct link_init_data *init_params)
 {
-	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
+	struct ddc_service_init_data ddc_service_init_data = { 0 };
 	struct dc_context *dc_ctx = init_params->ctx;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index dfee3ba8b234..76efac8300a9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -638,7 +638,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	uint32_t dpcd_base_lt_offset;
 
 	uint8_t dpcd_lt_buffer[5] = {0};
-	union dpcd_training_pattern dpcd_pattern = { 0 };
+	union dpcd_training_pattern dpcd_pattern = {0};
 	uint32_t size_in_bytes;
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
 	dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
@@ -1369,7 +1369,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated dpcd_lane_status_updated;
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 
 	retries_cr = 0;
 	retry_count = 0;
@@ -2164,7 +2164,7 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 	enum link_training_result result = LINK_TRAINING_SUCCESS;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 	uint32_t wait_time = 0;
 
 	/* initiate CDS done sequence */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index a29ebd9dbbcd..03f7249df1ef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -226,7 +226,7 @@ static enum dc_status dpcd_set_lt_pattern(struct dc_link *link,
 	enum dc_dp_training_pattern pattern,
 	uint32_t hop)
 {
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union dpcd_training_pattern dpcd_pattern = {0};
 	uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
 	enum dc_status status;
 
@@ -287,9 +287,9 @@ static enum link_training_result dpia_training_cr_non_transparent(
 	/* From DP spec, CR read interval is always 100us. */
 	uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -445,9 +445,9 @@ static enum link_training_result dpia_training_cr_transparent(
 	uint32_t retry_count = 0;
 	uint32_t wait_time_microsec = lt_settings->cr_pattern_time;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 
 	/* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
 	 * Fix inherited from perform_clock_recovery_sequence() -
@@ -599,9 +599,9 @@ static enum link_training_result dpia_training_eq_non_transparent(
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t wait_time_microsec;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -738,9 +738,9 @@ static enum link_training_result dpia_training_eq_transparent(
 	enum dc_dp_training_pattern tr_pattern = lt_settings->pattern_for_eq;
 	uint32_t wait_time_microsec;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
-	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 
 	wait_time_microsec = dpia_get_eq_aux_rd_interval(link, lt_settings, DPRX);
 
@@ -827,7 +827,7 @@ static enum link_training_result dpia_training_eq_phase(
 /* End training of specified hop in display path. */
 static enum dc_status dpcd_clear_lt_pattern(struct dc_link *link, uint32_t hop)
 {
-	union dpcd_training_pattern dpcd_pattern = { {0} };
+	union dpcd_training_pattern dpcd_pattern = {0};
 	uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
 	enum dc_status status;
 
-- 
2.25.1

