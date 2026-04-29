Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047F0FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9706210E45F;
	Wed, 29 Apr 2026 01:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVX/Yo4o";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7523010E45F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRhjR2F2/9GL9C2PvYisDUD1ScTXnOJa3TjeVVqo8h1VLI0MTACLPZpBL5Rs0uAiYr6AycdApWIRd7VqSuRoGln+kjygDi3wKjllOoi8ztVDYK5Mpo7t88I0+vZisa7+CO0nclfnnnXAl43ZstlAQ3dJLwrTFTMMRH16AbHjdI59E2C0y2r1UUuNJCCoNjGwbHlYabA21tuhSBTutMgmF/3U2k/W2V9kT8HcZ2KCzVaHr2ppDOP/aWEAqUrPLM86On/PAf2SVoOg7p1iO0Ju85mTyFJmDC6cv9YWVZW94oDXebWCx9ekGHX2Wcts0JA+4DvRtYGJqolqoQVl0V6kSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydo/Rl15pwj2oMqMdMSa5WOKlKWmtJp1O+26f6oorXo=;
 b=n3i5ss/IS6zUdm8nmLxx9F3rqz3Xug6f3c8mWhHVgyTbBLM68PmLCIpOc1AvTFDbrx8ZNC9pkGGNLEOq7+Ubzt3JkT30xi5AXTWhOK13xVDsVmpjj5bQY+VU4JyV4RhzXoDvcu3F1qLpSG/rYGgazZsPnTyv0BkctG6nWahFxw/j2t6zoKRP3j+/uoBDXqPseAay9AkBkw+1k5mpe8VY9/flCuYmU4Dvg0EMjZno9Gs/LiiX0Q/Xz1in9pyJ3y8eJ6/rNtdiG3OsE976uiuyAaZ643KoZYggLTk7JfZMHTrdc6w6HV8CdsWMgVYyZ6nqeiFDGfmumnJjFSLnPbo+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydo/Rl15pwj2oMqMdMSa5WOKlKWmtJp1O+26f6oorXo=;
 b=zVX/Yo4o6wavIIeB4RPnBS336iDsnDvZGn+DDmXC5Qil2PtKkdtq8tsL3H76MPThpn9fdo3P7D30rtFuH4ua/smJpIf/kmlhlraYIRatlpia/pIojwRSFs0nwBb8jMEErcyCgofGj13HuheLU9y3AfoWOFmRyyUf19LWMvlFR34=
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 01:54:22 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::dc) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 01:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:54:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:54:22 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:54:13 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 16/17] drm/amd/display: add max bandwidth budget to QoS
 interface
Date: Wed, 29 Apr 2026 09:19:25 +0800
Message-ID: <20260429012055.2065869-17-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc3fb5d-5fa2-49a4-8fa1-08dea5923c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: f2kJ6Ri9MjNNVdimDoKOG2aRyDxHwIj01J9pzrrJhmUFOxDedO1LMh5F6sMWJTY3ANI3UnLXZ3+0fP3MBFLCQF8M2UpfjPc+UQJNHB9zOaEqYKk3ItkvxZe6AnUF1HlV1omR5oGoAbN4rb0BAOaCZyt5gUe/rQOw7lC7oOJaA/KowvV/+OIv8Yhbs1Xz2Xxtdy3L2VJVAYoAdoqUtwAUp1sxZy/ixMwU/o4y/mHNO+K54QxSk+DvCzOabKhB8N3UYc3t64dCsGYfkDh70veFBfPClEFmdHJ9CIr8lq14pUEdDNMY0il5xv3w3N4zKzIZnhdCWYf+KY2h2xREv8fuHT7aAj2mD/aT80AXGoC8NDZmSwShRnQj+G7u3wvFMmZCS2xRuZTeWmlfRtMc47fvOKZ7AIntfIHiIX7omxy4hTtL+y02UbJnFNAYE3yfX345cy0dFsQB0QF3U9wHHjDaT4T3YlTTEbYBu07pfVduH+gN5CULOmHD463z+YbBpP91OxY9MGSjydppObnjxL3K9QTL0rZp8h3YPrw/2zgxhU+gpGqr/2GFP1qJ+3LqKn17l8pDEk8KI9X4yc94PnZXBwskbkRd2MdLrdQPpKyCPHNWKTJ+sNkZg9hBzkXEqBRf7pnQjzrfuF7q+vhj13Isxnc34KCnQuQlNOgOUTA2rhEKHj9P+1KApc+7wVgzk36N0Mm3FH0tsWG1k+yFOeuSS3ETqIowSGWkaggVMMHtvn+GCNjcO1wNAqmtwSAY4iwUv5Km77yBlph0VQBHAN4ntQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dzewW1l10Ke1+QUNM86oG56dZqdGfzZJdT3afNYD7J10Hjw9aCX+SekfcwLFT/SeOS34BJszDYhARyNTQkd3AR5Oqp4ypzK+jnstyGXQeaSeQs5xsxzjIj7Ye2iQF89U21JzXQz7Nl46NdDfwJ42MKITYcVtuTAzK/s78b7Ur4jgzR1bt8pkudB/jRu0hgYLkAv9EvfathqqPwb5JKAKoazDfJtLvt0dENHT/X8B5APXeIWzKC+6Xy7RKzU/ibhztCX186Q0eGRPFwJ2cSueKYvVLJ/fs5sbOeSkKtnmfryL2vMlq2jkR3J/CYJn56sc4K/eI9SFTxNiK4dSDtHpmXlYGLCE1tmJ+RygGX5kT6+oWfH4YezVaiWszqeMjpxshiJZhB1a5gVvEuqdG1feBfxxUiXynwUjBca7EhPEOiLf4QaLcb3WzJbV5FxXhetj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:54:22.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc3fb5d-5fa2-49a4-8fa1-08dea5923c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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
The QoS reporting interface lacked a field to expose the maximum
active memory bandwidth budget. Adding this field allows callers to
observe the effective bandwidth ceiling.

[How]
Rename struct memory_qos to dc_measured_memory_qos and introduce
a new struct dc_requested_memory_qos holding bandwidth lower bound,
calculated average bandwidth, latency upper bounds, and max bandwidth
budget. Add a get_requested_memory_qos function pointer to
clk_mgr_funcs. Update dc_get_qos_info to call through the new
function pointer and populate all requested QoS fields including
qos_max_bw_budget_in_mbps in dc_qos_info.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 28 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  8 +++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 10 ++++++-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 10 +++++++
 5 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 222053af63a0..09868145d2de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7602,7 +7602,8 @@ void dc_log_preos_dmcub_info(const struct dc *dc)
 bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 {
 	const struct dc_clocks *clk = &dc->current_state->bw_ctx.bw.dcn.clk;
-	struct memory_qos qos;
+	struct dc_measured_memory_qos measured = {};
+	struct dc_requested_memory_qos requested = {};
 
 	memset(info, 0, sizeof(*info));
 
@@ -7611,16 +7612,23 @@ bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 		return false;
 	}
 
-	// Call unified measurement function
-	dc->hwss.measure_memory_qos(dc, &qos);
+	dc->hwss.measure_memory_qos(dc, &measured);
 
-	// Populate info from measured qos
-	info->actual_peak_bw_in_mbps = qos.peak_bw_mbps;
-	info->actual_avg_bw_in_mbps = qos.avg_bw_mbps;
-	info->actual_min_latency_in_ns = qos.min_latency_ns;
-	info->actual_max_latency_in_ns = qos.max_latency_ns;
-	info->actual_avg_latency_in_ns = qos.avg_latency_ns;
-	info->dcn_bandwidth_ub_in_mbps = (uint32_t)(clk->fclk_khz / 1000 * 64);
+	info->actual_peak_bw_in_mbps    = measured.peak_bw_mbps;
+	info->actual_avg_bw_in_mbps     = measured.avg_bw_mbps;
+	info->actual_min_latency_in_ns  = measured.min_latency_ns;
+	info->actual_max_latency_in_ns  = measured.max_latency_ns;
+	info->actual_avg_latency_in_ns  = measured.avg_latency_ns;
+	info->dcn_bandwidth_ub_in_mbps  = (uint32_t)(clk->fclk_khz / 1000 * 64);
+
+	if (dc->clk_mgr && dc->clk_mgr->funcs->get_requested_memory_qos) {
+		dc->clk_mgr->funcs->get_requested_memory_qos(dc->clk_mgr, &requested);
+		info->qos_bandwidth_lb_in_mbps    = requested.bandwidth_lb_in_mbps;
+		info->calculated_avg_bw_in_mbps   = requested.calculated_avg_bw_in_mbps;
+		info->qos_max_latency_ub_in_ns    = requested.max_latency_ub_in_ns;
+		info->qos_avg_latency_ub_in_ns    = requested.avg_latency_ub_in_ns;
+		info->qos_max_bw_budget_in_mbps   = requested.max_bw_budget_in_mbps;
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2bb11296ee6a..cc288eb19d04 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -971,6 +971,7 @@ struct dc_qos_info {
 	uint32_t actual_avg_latency_in_ns;
 	uint32_t qos_avg_latency_ub_in_ns;
 	uint32_t dcn_bandwidth_ub_in_mbps;
+	uint32_t qos_max_bw_budget_in_mbps;
 };
 
 struct dc_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7f0743de1b14..4b9fcb87e60d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -53,7 +53,7 @@ struct drr_params;
 struct dc_underflow_debug_data;
 struct dsc_optc_config;
 struct vm_system_aperture_param;
-struct memory_qos;
+struct dc_measured_memory_qos;
 struct stream_encoder;
 struct hpo_dp_stream_encoder;
 struct hpo_frl_stream_encoder;
@@ -1516,12 +1516,12 @@ struct hw_sequencer_funcs {
 	/**
 	 * measure_memory_qos - Measure memory QoS metrics
 	 * @dc: DC structure
-	 * @qos: Pointer to memory_qos struct to populate with measured values
+	 * @qos: Pointer to dc_measured_memory_qos struct to populate with measured values
 	 *
-	 * Populates the provided memory_qos struct with peak bandwidth, average bandwidth,
+	 * Populates the provided dc_measured_memory_qos struct with peak bandwidth, average bandwidth,
 	 * max latency, min latency, and average latency from hardware performance counters.
 	 */
-	void (*measure_memory_qos)(struct dc *dc, struct memory_qos *qos);
+	void (*measure_memory_qos)(struct dc *dc, struct dc_measured_memory_qos *qos);
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e960ca9062ad..a99e1937f8ce 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -707,7 +707,7 @@ struct dc_bounding_box_max_clk {
 	int max_phyclk_mhz;
 };
 
-struct memory_qos {
+struct dc_measured_memory_qos {
 	uint32_t peak_bw_mbps;
 	uint32_t avg_bw_mbps;
 	uint32_t max_latency_ns;
@@ -715,4 +715,12 @@ struct memory_qos {
 	uint32_t avg_latency_ns;
 };
 
+struct dc_requested_memory_qos {
+	uint32_t bandwidth_lb_in_mbps;
+	uint32_t calculated_avg_bw_in_mbps;
+	uint32_t max_latency_ub_in_ns;
+	uint32_t avg_latency_ub_in_ns;
+	uint32_t max_bw_budget_in_mbps;
+};
+
 #endif /* _CORE_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index eab25efea76b..dcce81e3d97c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -28,6 +28,7 @@
 #define __DAL_CLK_MGR_H__
 
 #include "dc.h"
+#include "core_types.h"
 #include "dm_pp_smu.h"
 
 /* Constants */
@@ -374,6 +375,15 @@ struct clk_mgr_funcs {
 	unsigned int (*override_memory_bandwidth_request)(
 			struct clk_mgr *clk_mgr,
 			unsigned int bw_kbps);
+	/**
+	 * get_requested_memory_qos - Retrieve current QoS request from the clock manager's
+	 *     current clock state, reflecting any active bandwidth overrides.
+	 * @clk_mgr: clock manager instance
+	 * @qos: pointer to dc_requested_memory_qos structure to populate
+	 */
+	void (*get_requested_memory_qos)(
+			struct clk_mgr *clk_mgr,
+			struct dc_requested_memory_qos *qos);
 };
 
 struct clk_mgr {
-- 
2.43.0

