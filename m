Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4231CC9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE60B10F723;
	Thu, 24 Sep 2026 18:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlkU2NLo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D598D10F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W72uBcJjB3PVBcwv/aOkiGa4WatvWMv8GF1XiFbe7vsLUOBFcXQ2WeDLNYHC9zR/Jco0dE2wRPMtr0oCBpz1pGJ2R+acYgVjKx75sNZPUSIyNjIw5Fq7dttxDRCPM1+gIvn/M9eiUIRE03bDskmKJFUWJF2050TuwJ3UMapvlfcPyWq9y0a+M9otkvUzmW+qqb9e8GX9VkdZ7Gwn9rHAa6jV/hxabWfvHLsWyOxMb/PSxpSphExHcxV10bBt3KiNf771aLxLNOLICY2MlHv70NTMeiFYDdJYiDWOxAKA7+TMUa9Zo8cpu8dsVSynCXP39HfEf7RdQeVE8JgjHYvPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62OXHgcOqbLY2+hDg+ukSMFzYomAjM8R8wtEP94xZBM=;
 b=hzhudPjjlHy9c3L8lclCqde0eErNTHGh2kq5s7uNoAzlMXRmu6Amh1XN4Uw2FyIEziZ0lSrFPBKdY+YvInBFCIUh0GYEsGIS+qqiCGGaBwMsu+Yd5G5h/1YxHn6nj1pgFso42hhMlsCud7uH+o7JWnOwsMr6BwkKq28kGocVS/vkWLQCCzfp4sdHe1nJ/KW3pqxRfT7feYLwoGl+KGFSmjz4KDL5fcN5h4VpsfPZAgfwNZVL5hvFoLQtzAzyXNQ84aJhSLM/pBShIFYjC+Ev6n5Y4AZCWHWdDL0GRpzIEmhNFbLj2nV2pPEpB3Gpb3T/w1umHev9oSpTra4TdRl5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62OXHgcOqbLY2+hDg+ukSMFzYomAjM8R8wtEP94xZBM=;
 b=qlkU2NLoOqfWpFFntkvavYhqS9lElmyzQ//Gb+U5dIuN4tFY/39x7gXzCfos4lMRmKHw7E4kRomHtsm1LvkFPTibUsB+ELwHu9N8xaexTGxPyjZAoI6pyqopCTEU162QY3chfWMo4omGJ2cN42nPNYl3iwITIN0/ua3CZUv3eR4=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:12 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:12 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:01 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 02/34] drm/amd/display: Synchronize UTM overrides with SMU
Date: Thu, 24 Sep 2026 14:45:15 -0400
Message-ID: <20260924184824.596894-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: a7133927-ce43-41fe-668f-08df1a6c1b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o/FFd7Y6n7c3xvVhUv7Ce+72wk1e0cnBQkdZL4tG1hokUEZ1GD9tlaf93o/hanTPjP2lC2O9DCLgqnaZUu0umFpJ1tVVXAK1vi2dxSGGIPWDX6CffIu+LpnBk2Im0zxHr8vRDnVOwuwQw+R+NtaBUPszHjHxQTVwyYYAbSbHn5XH5ufkjk+MTYIwamKMz5cgpOTlXNPCFm3zycAu9s9nfeBp10PhY3vi4IxG3OCcXTNgBRVkBbxi46syQNJTfYOFkq5tOhIUjRQqN4WnW4TAqlsRU1FtVbOCxxaGCPnNYr+TSby4dTdnlk3+RptY76JfPjrl/ia7gl3nZpKK9mjVyo57m11oO6IzLbZSEqeTfw+qsadY4AZio8U2sMQ5R5LEg7gyprJo3dHUx3jw73cAe0NHufL3n39hO0gWGKgEV5g2vRTMpi9fnMI7elCpvUosidL5woifPc7ZSrL5VtD2D98euwQoAa51PAaMouhZzAZf8UH+PbYXS0aav2wq535BENsXZ48yVgMtNkSzTNclS6+iYPif3ENCHNNAlT8DkJdYuQ86Ko5e9jlbS+bSuO1jJCsIVQGXkYOtBcm6lKD747fDsO4Sc4iHdQcYWfy0OEe3sxoezgcmvVvjbVzxkXYS9sWpsdswbCCdVNIQnM56HwEtJeLMtM8GsfALhDjdOa1hhAUFqa9jfv15XgYuvt25ht1E4R2bhkuAY7HtJlSWsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GA7Gq5j2JCoz59IasRUOaz8hJGraqh7WjybAheLo1BsAFYNfsqWCxmuLE2Jsqb75VJooEAkmUWpw9RGwqUffnJYJvb/CYiZVx7J0efA1x561A2vXcaNeqEpYlkUiwC+B7OLOEGVH+6zw3oCMA8wSqWfxZ5VioVYFxI6HIHaUVsn5rlI7AojQpj66F4crviVUBzniNPDq1v1FtJDioHkSaJq5dpxFIfRKJn4LWwOqNL4zCM6LvaUXdLZVpT3kubCCm4yrhi3TV0K4PT7ioQJgJyqQRpMRhmaOlvlVcxt0M7HH+EhY9oPyEI71O1R5usckDlenYjCWsgLzkoOF6jA15Z2V4imN7RrP660IEfHRE1r6FahqaX8AjDYpk27u1gGDxski5yA3qNrOfjJd6PzGWx/wE0aRmDYd4fPxuoZN/SOEcwgI2ikkUTX/oN3Wrbsk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:12.1037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7133927-ce43-41fe-668f-08df1a6c1b09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Keep the display QoS model and firmware table consistent when test
overrides are enabled.

[How]
Serialize the overridden QoS values into a dedicated transfer buffer
and send the table after clock initialization.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 125 ++++++++++++++++--
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   9 ++
 2 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index d6db6168c3da..00d96232a013 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -120,6 +120,9 @@ static const struct clk_mgr_mask clk_mgr_mask_dcn60 = {
 #define TO_DCN60_CLK_MGR(clk_mgr)\
 	container_of(clk_mgr, struct dcn60_clk_mgr, base)
 
+/* Temporary UTM override used to unblock DCN6 testing. */
+static bool dcn60_should_apply_temp_utm_override = true;
+
 static bool dcn60_is_ppclk_dpm_enabled(struct clk_mgr_internal *clk_mgr, PPCLK_e clk)
 {
 	bool ppclk_dpm_enabled = false;
@@ -627,6 +630,74 @@ static void dcn60_override_clk_table(struct clk_limit_table *clk_table)
 	(void)clk_table;
 }
 
+/**
+ * dcn60_copy_utm_qos_model_to_soc_table - Convert a UTM QoS model to the PMFW table format.
+ * @dchub: overridden DCN6 UTM QoS model
+ * @utm_table: GPU-visible PMFW UTM table to populate
+ */
+static void dcn60_copy_utm_qos_model_to_soc_table(
+		const struct utm_qos_model_dchub_v3 *dchub,
+		SocUtmTable_t *utm_table)
+{
+	unsigned int load_level_count = dchub->load_level_count;
+	unsigned int sop_count = dchub->sop_count;
+	unsigned int ll, sop;
+
+	if (load_level_count > UTM_QOS_MODEL_V3_MAX_LOAD_LEVEL_COUNT)
+		load_level_count = UTM_QOS_MODEL_V3_MAX_LOAD_LEVEL_COUNT;
+
+	if (sop_count > UTM_QOS_MODEL_V3_MAX_SOP_COUNT)
+		sop_count = UTM_QOS_MODEL_V3_MAX_SOP_COUNT;
+
+	memset(utm_table, 0, sizeof(*utm_table));
+	utm_table->Header.LoadLevelCount = load_level_count;
+	utm_table->Header.SopCount = sop_count;
+
+	for (ll = 0; ll < load_level_count; ll++) {
+		for (sop = 0; sop < sop_count; sop++) {
+			const struct utm_qos_model_dchub_v3_sop_entry *src =
+					&dchub->sops[ll][sop];
+			SocUtmSopEntry_t *dst = &utm_table->Sops[ll][sop];
+
+			dst->UrgentRampPs = src->urgent_ramp_ps;
+			dst->TripPs = src->t_trip_ps;
+			dst->MetaTripToMemPs = src->meta_trip_to_mem_ps;
+			dst->MaxReqLatencyUrgPs = src->max_req_latency_urg_ps;
+			dst->AvgReqLatencyUrgPs = src->avg_req_latency_urg_ps;
+			dst->MaxReqLatencyNonUrgPs = src->max_req_latency_non_urg_ps;
+			dst->AvgReqLatencyNonUrgPs = src->avg_req_latency_non_urg_ps;
+			dst->DfResponseTimePs = src->df_response_time_ps;
+			dst->UrgentBandwidthKBps = src->urgent_bandwidth_KBps;
+			dst->NominalBandwidthKBps = src->nominal_bandwidth_KBps;
+			dst->LsdmaBandwidthKBps = src->lsdma_bandwidth_KBps;
+		}
+	}
+}
+
+/**
+ * dcn60_override_utm_qos_model - Override the UTM QoS model.
+ * @bw_params: clock manager bandwidth parameters
+ */
+static void dcn60_override_utm_qos_model(struct clk_bw_params *bw_params)
+{
+	struct utm_qos_model *qos_model;
+	struct utm_qos_model_dchub_v3 *dchub;
+
+	if (!bw_params->utm_qos_model
+			|| bw_params->utm_qos_model->version != utm_qos_model_version_v3
+			|| !bw_params->utm_qos_model->dchub_v3)
+		return;
+
+	qos_model = (struct utm_qos_model *)bw_params->utm_qos_model;
+	dchub = (struct utm_qos_model_dchub_v3 *)qos_model->dchub_v3;
+
+	dcn6_test_initialize_utm_qos_model_v3(qos_model, dchub);
+
+	// Override for lsdma here is redundant with the above call, but this may need to outlive
+	// the test_initialize call for debug purposes so keep it here for now.
+	dcn6_test_override_lsdma_bandwidth_v3(dchub);
+}
+
 static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 		struct clk_bw_params *bw_params)
 {
@@ -654,17 +725,8 @@ static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 
 	bw_params->dc_mode_softmax_memclk = bw_params->dc_mode_limit.memclk_mhz;
 
-	/* Override as needed - temporary for debug only. */
-	if (bw_params->utm_qos_model && bw_params->utm_qos_model->dchub_v3) {
-		dcn6_test_initialize_utm_qos_model_v3(
-				(struct utm_qos_model *)bw_params->utm_qos_model,
-				(struct utm_qos_model_dchub_v3 *)bw_params->utm_qos_model->dchub_v3);
-
-		// Override for lsdma here is redundant with the above call, but this may need to outlive
-		// the test_initialize call for debug purposes so keep it here for now.
-		dcn6_test_override_lsdma_bandwidth_v3(
-				(struct utm_qos_model_dchub_v3 *)bw_params->utm_qos_model->dchub_v3);
-	}
+	if (dcn60_should_apply_temp_utm_override)
+		dcn60_override_utm_qos_model(bw_params);
 }
 
 /**
@@ -922,6 +984,32 @@ static void dcn60_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 	}
 }
 
+/**
+ * dcn60_update_smu_utm_table - Send the current UTM QoS model to SMU.
+ * @clk_mgr: clock manager instance
+ *
+ * Return: true if SMU accepted the UTM table, false otherwise
+ */
+static bool dcn60_update_smu_utm_table(struct clk_mgr_internal *clk_mgr)
+{
+	const struct utm_qos_model *qos_model = clk_mgr->base.bw_params->utm_qos_model;
+	const struct utm_qos_model_dchub_v3 *dchub;
+	SocUtmTable_t *utm_table;
+
+	if (!qos_model
+			|| qos_model->version != utm_qos_model_version_v3
+			|| !qos_model->dchub_v3
+			|| !clk_mgr->utm_override_table)
+		return false;
+
+	dchub = qos_model->dchub_v3;
+	utm_table = (SocUtmTable_t *)clk_mgr->utm_override_table;
+
+	dcn60_copy_utm_qos_model_to_soc_table(dchub, utm_table);
+	return dcn60_smu_set_soc_utm_table(clk_mgr,
+			clk_mgr->utm_override_table_addr);
+}
+
 void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -947,6 +1035,11 @@ void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr->dpm_present)
 		clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 				clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
+
+	if (clk_mgr->dpm_present
+			&& dcn60_should_apply_temp_utm_override
+			&& !dcn60_update_smu_utm_table(clk_mgr))
+		DC_LOG_ERROR("Failed to transfer UTM override table to SMU.\n");
 }
 
 
@@ -1751,6 +1844,12 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 	if (!clk_mgr->dal_init_table)
 		goto fail;
 
+	clk_mgr->utm_override_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
+			DC_MEM_ALLOC_TYPE_GART, sizeof(SocUtmTable_t),
+			&clk_mgr->utm_override_table_addr);
+	if (!clk_mgr->utm_override_table)
+		goto fail;
+
 	return &clk_mgr60->base;
 
 fail:
@@ -1764,6 +1863,10 @@ void dcn60_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
 {
 	kfree(clk_mgr->base.bw_params);
 
+	if (clk_mgr->utm_override_table)
+		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
+				clk_mgr->utm_override_table);
+
 	if (clk_mgr->dal_init_table)
 		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
 				(void *)clk_mgr->dal_init_table);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index d735eb1e7f43..68fd92258e8c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -541,6 +541,15 @@ struct clk_mgr_internal {
 	const void *dal_init_table;
 	long long dal_init_table_addr;
 
+	/**
+	 * @utm_override_table:
+	 *
+	 * GPU-accessible DRAM buffer for the UTM table transferred to SMU via
+	 * DALSMC_MSG_TransferTableDram2Smu(TABLE_SOC_UTM).
+	 */
+	void *utm_override_table;
+	long long utm_override_table_addr;
+
 	bool dpm_present;
 	bool pme_trigger_pending;
 };
-- 
2.53.0

