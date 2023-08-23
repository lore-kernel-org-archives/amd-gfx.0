Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46448EE49A3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B797C10E466;
	Wed, 23 Aug 2023 16:04:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B46810E463
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgwar9RgnCSoE9ziozXqTKj8QOvK/FuSTJQMFHSVwLVK2b9cu7lqU2GVHHvu0rrfdvToMXZBPfkMjY5MLz53os1loqHJsCVsSJxPB2bN+TKdF80sHuSrSSV4nT/35mF9wOQgMt+2wedEtzLJV5v5e5zbbNNMGXyvePaQTi1MFtzEnjoiso0P+R5SyycgK1ZxGhXnvZTKEBy3F5OGMwnq6LTX0tFWzyq2mLxAQUWrCiZpmb2RkDunYL40qb+zUUWfaxnPbeYpoKVd6un/gZtcvC8lQV1kEvKo9+RtlsfLxES9WMecaC5A6m5Uu9PPALgzdLpqEP4Ud544K2/YZfctvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVRamB80UDu7HFpQ1E/RRjDtouKmc8m5iqcuis2xXDg=;
 b=SPpH8ppTL9L08Atgqs32UBVogeqb6lb7UpmV/SXdPOUPjbMqcI7NdQknuLzxKkGyx2qdLt0P3FiBOCuIfEI5AoyAdGjBh7EvdWpDlsoRidkK8n8dZflUX9ga3Wb+MIuPGmLQpW+h4G7h7xDofiefDixSZRCfl3tk8yAi1c+EU1TAQHUk4zUIYMNb20Z+mfxdllTZH2XBRdNiAI8WdHurdTY6RadKJz7ZxMPOWBorBxRQy2e8mYqmNG2HKTcK1yWfi2xQTFAzSlCmwKfgnlqo578/1A2/gHlLlaPekWCUK0Zz/m2m7QqiL9kFJb7ujhXnxMB6KAd0wM5djAQki7ammg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVRamB80UDu7HFpQ1E/RRjDtouKmc8m5iqcuis2xXDg=;
 b=q9/WMyxq50CUm9ac3KTX6MOh5ap7c80sZ+59lj/8MmDYQbm0uiYg3+Nzdgm62l6g0eKBK6igFIrl+GJ9easK3eM9s6i5twyXJWuPhXKjZwC/lia9VIy9BOzDZzQo1T0ZoHd5/XC8C/IwpaAOGKom9HDpRaGTNWGJpTy2mTm9d6w=
Received: from SA0PR11CA0122.namprd11.prod.outlook.com (2603:10b6:806:131::7)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:24 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::d3) by SA0PR11CA0122.outlook.office365.com
 (2603:10b6:806:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:21 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Add DPIA Link Encoder Assignment Fix
Date: Wed, 23 Aug 2023 11:58:08 -0400
Message-ID: <20230823160347.176991-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af85a01-b3ba-4fb1-8023-08dba3f29e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x297vFEcRXZs/cDW3NS/qNY9mi1UQkFHGPafgenmDj1tQLKVB88yzWPnwSG9xQKw9YM4FhxQJBW6Ncm0NY16kWlLO8M+jziTuHpa69u4Odw36Vlx8a45Z9fbauA2AfD+jY1pbAtckCgs1ZrDqNgDr5F/DRxXhkVQFqnHMnn+/9sqW++2gxqVRadZV0UAHYBxflVWWiJsQNH6yENYipGFtmWqqkO0obdcGU3KkcVOF/OLOAjc3ZP5Nk3ufL89kNAIKCZpIord7eWEivzzLUqBeLvg+YRDyO3BpNVmz6kAEvL76b9+aWuJ4h0u8gqAoXKidQI77SZOqm2w7D3gy+2tbTzLF0mb810iaAy7t1hxoKsk4P8u9PwihjQlwAak41RawgNGoqgW5aAlwVxxn0S+71uwmURnbPab4DGu3DJEa1mcxYVImhBp6MHxgyrMzBcgbNhVOAyteZ/b3wVFC12jigGyOi8j/NexLM0EG8oeMx6INuXVnWNJKU+LtUN55E5w05kIBKlm7YGZLqE6db838lZ1YjlYsLvHIKFRviPPKIbDELx7YJJD2KAess7W6LXJrISgE7z09agfyI/9xijEvGribNzQiIX3EeT65VkFNAxhadXd+y3FqK6LyTI5oVARUEMStCtSTBTF/XJSJ07Yp3GGKYG8UrYFcJyosFK3hNc/jetcST1fNSUhfx+bLZE24/iQLPYkm6JLISTjPmjJOR4NqjnSWjNugHMkrtM455qgRXTSc+B+IhtVIOhujZCXM80AXWnFFtj3yB5eNwfJdtb1ghr2+prWxtaS1kO6Nn7SwCCwcfwUqyHMH587YTsq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(66574015)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(26005)(16526019)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:24.0443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af85a01-b3ba-4fb1-8023-08dba3f29e95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Mustapha
 Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

For DPIA we should have preferred DIG assignment based on DPIA selected
as per the ASIC design.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 35 +++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   | 23 ++++++++++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../drm/amd/display/dc/link/link_factory.c    |  4 +++
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 30c0644d4418..b66eeac4d3d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -169,11 +169,23 @@ static void add_link_enc_assignment(
 /* Return first available DIG link encoder. */
 static enum engine_id find_first_avail_link_enc(
 		const struct dc_context *ctx,
-		const struct dc_state *state)
+		const struct dc_state *state,
+		enum engine_id eng_id_requested)
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
 	int i;
 
+	if (eng_id_requested != ENGINE_ID_UNKNOWN) {
+
+		for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
+			eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i];
+			if (eng_id == eng_id_requested)
+				return eng_id;
+		}
+	}
+
+	eng_id = ENGINE_ID_UNKNOWN;
+
 	for (i = 0; i < ctx->dc->res_pool->res_cap->num_dig_link_enc; i++) {
 		eng_id = state->res_ctx.link_enc_cfg_ctx.link_enc_avail[i];
 		if (eng_id != ENGINE_ID_UNKNOWN)
@@ -287,7 +299,7 @@ void link_enc_cfg_link_encs_assign(
 		struct dc_stream_state *streams[],
 		uint8_t stream_count)
 {
-	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
+	enum engine_id eng_id = ENGINE_ID_UNKNOWN, eng_id_req = ENGINE_ID_UNKNOWN;
 	int i;
 	int j;
 
@@ -377,8 +389,15 @@ void link_enc_cfg_link_encs_assign(
 		 * assigned to that endpoint.
 		 */
 		link_enc = get_link_enc_used_by_link(state, stream->link);
-		if (link_enc == NULL)
-			eng_id = find_first_avail_link_enc(stream->ctx, state);
+		if (link_enc == NULL) {
+
+			if (stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					stream->link->dpia_preferred_eng_id != ENGINE_ID_UNKNOWN)
+				eng_id_req = stream->link->dpia_preferred_eng_id;
+
+			if (eng_id == ENGINE_ID_UNKNOWN)
+				eng_id = find_first_avail_link_enc(stream->ctx, state, eng_id_req);
+		}
 		else
 			eng_id =  link_enc->preferred_engine;
 
@@ -402,7 +421,9 @@ void link_enc_cfg_link_encs_assign(
 			DC_LOG_DEBUG("%s: CUR %s(%d) - enc_id(%d)\n",
 					__func__,
 					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
-					assignment.ep_id.link_id.enum_id - 1,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ?
+							assignment.ep_id.link_id.enum_id :
+							assignment.ep_id.link_id.enum_id - 1,
 					assignment.eng_id);
 	}
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -413,7 +434,9 @@ void link_enc_cfg_link_encs_assign(
 			DC_LOG_DEBUG("%s: NEW %s(%d) - enc_id(%d)\n",
 					__func__,
 					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ? "PHY" : "DPIA",
-					assignment.ep_id.link_id.enum_id - 1,
+					assignment.ep_id.ep_type == DISPLAY_ENDPOINT_PHY ?
+							assignment.ep_id.link_id.enum_id :
+							assignment.ep_id.link_id.enum_id - 1,
 					assignment.eng_id);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9f9e8da3e4db..5d41a14844da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1496,6 +1496,7 @@ struct dc_link {
 	 * object creation.
 	 */
 	enum engine_id eng_id;
+	enum engine_id dpia_preferred_eng_id;
 
 	bool test_pattern_enabled;
 	enum dp_test_pattern current_test_pattern;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 1c1fb2fa0822..004beed9bd44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1032,6 +1032,28 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN30(_MASK)
 };
 
+/* ========================================================== */
+
+/*
+ * DPIA index | Preferred Encoder     |    Host Router
+ *   0        |      C                |       0
+ *   1        |      First Available  |       0
+ *   2        |      D                |       1
+ *   3        |      First Available  |       1
+ */
+/* ========================================================== */
+static const enum engine_id dpia_to_preferred_enc_id_table[] = {
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGD,
+		ENGINE_ID_DIGD
+};
+
+static enum engine_id dcn314_get_preferred_eng_id_dpia(unsigned int dpia_index)
+{
+	return dpia_to_preferred_enc_id_table[dpia_index];
+}
+
 static struct dce_i2c_hw *dcn31_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1785,6 +1807,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.update_bw_bounding_box = dcn314_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn314_get_panel_config_defaults,
+	.get_preferred_eng_id_dpia = dcn314_get_preferred_eng_id_dpia,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 7f9c75ffda18..b55848480485 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -65,6 +65,7 @@ struct resource_context;
 struct clk_bw_params;
 
 struct resource_funcs {
+	enum engine_id (*get_preferred_eng_id_dpia)(unsigned int dpia_index);
 	void (*destroy)(struct resource_pool **pool);
 	void (*link_init)(struct dc_link *link);
 	struct panel_cntl*(*panel_cntl_create)(
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 11b5ac218154..e406561c2c23 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -792,6 +792,10 @@ static bool construct_dpia(struct dc_link *link,
 	/* Set dpia port index : 0 to number of dpia ports */
 	link->ddc_hw_inst = init_params->connector_index;
 
+	// Assign Dpia preferred eng_id
+	if (link->dc->res_pool->funcs->get_preferred_eng_id_dpia)
+		link->dpia_preferred_eng_id = link->dc->res_pool->funcs->get_preferred_eng_id_dpia(link->ddc_hw_inst);
+
 	/* TODO: Create link encoder */
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-- 
2.41.0

