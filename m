Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B071C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FBD10E3CD;
	Wed,  2 Sep 2026 05:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dz29dFMx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6850C10E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRBtzI9QHVeYXa/GkvdIbZNhAUFWrbCXTo1cZq39CBBoq3umuQZreWjLqhjGgNc7p/y0vpUmB2IZafNUSbO7tNqMdPhR3NpkB3el3rlZpreuGNMBHQDCm91XB6ACyQbWiATwect5OiJtlNgkXBmZAncP7ZbhvMsXZCo6OIquDt9kYDO60p0Jn51Uz9IkzQB2pB+PHX3ovHB4wceVbffnzDt+sTXUbsmxGT+cCx9S8nEX2FhxiWkwCN419ZdTbFb/f8BDqpwgu6g6xE+xVDiT037iJWIChBBuDe6ktEAR97KZfnEjZNa/Arbk1uXT1GkwfmWg3EXKVqQebPKNmpgnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQql36+8iORc43lF3eWG5Y5GTZNA7vZJxH40E2afPtY=;
 b=IunyNIuHPJIcQxBZ7KZ0vErpuX/tv8y1Wqlbf/xL98pGmgIyiH439J0ZVOiI+u/xhieqNxD7K91eGfM3xXdwvof+gIfmVVjLsiHO9U4alscn3qLXQW/vDctp5z9zyEluci0+l5cDIp7IzGYOvOr6UmUuHEmsfu4+oj2TA75MiMKZoF+4v4vMEX2ToEpA82MXlZHVPvMfDzEa/I0HQuLtVHvnbsPeanYRQy9z3x8+YKo7/iid8nOkt1vM8vQy7m2oKt+Wnx/ASzH3wJpsc/YjJSOBSKpvNbL+MmxTWH9YkdXXypl12HF8qH1X2qHxjnnwJKZzlDWVqHdZ08ed3qIrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQql36+8iORc43lF3eWG5Y5GTZNA7vZJxH40E2afPtY=;
 b=Dz29dFMx0tLKdn0MxZa71CEZBvrDdHk7DgtKP6QAinj34+KT85GCwZAdgihho6NgdQVPNylj5Jf2utb09VqQs5ob2HbnnbCExpzEw2XOc6yrG5bQirX+Edt5BUtubVLLw3v5Cq4ZEkpBAXVrBvOnEpZT8MYIYtGvCTMQyLrLA7E=
Received: from MN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:52f::25)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:04:33 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::34) by MN0PR03CA0012.outlook.office365.com
 (2603:10b6:208:52f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:04:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:32 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:23 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/40] drm/amd/display: Ensure requested LSDMA BW is within
 the SOP bound
Date: Wed, 2 Sep 2026 12:58:23 +0800
Message-ID: <20260902050411.3473916-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: c124adaf-9a1b-4292-6ab5-08df08afad59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|30052699003|10067099003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: S0zoWSn3yLmlGOWqvXYg9g/kVSRjddV81GbvquFe+L3QuxFNyQ5H54HNkM1e/Vv1LMkcJFo1ykLOnlCCur/13MBtK/fmeUAAkyryd+T+mW3zjnKKkxUvlE323kw+/bmZx3saiyU2Zk57qL1XudePcBObIYvPIhbUh0vbUs/Z8OvBPEWhuDeyYi5ITUPiU5/1jUMLpxlOemm+SiMCVAjKxjRjcydcsnEQL3Bt5gOW/tiyCjdsK7t8DTrABBF2QUDooChWhiAA/jkZ9+QqrNIeP4HQ31ReMhVeRm1du1xg+vhQU+FT/APfxlw+86I5ZkWQvptkFo1DZhxOZN6Af7+ESW9T9zVEIPGIeBpZ3pUPw/ahA0QNSbrHUGWcxJ1Yzoxi8Ee2OVU0mTiwR8AMTTTEiOWKSiVrRClTzFuZ6ZwzUTbzivogqM7d+wFOqugtaLtKcm7hQhp88RKs6qDpuMeP9g32E55CxeGKlJYi0UYIUDMuEXU+5lqll0t14LMBNsWFP+qjIDBDNfwqjAHI71uzYjyLSuP25jWEtwbR0oyjZ538C5flNd4FytedzJt3ZPCcK1sYj/nQCWNordYQHeSALL4CBCoRmsenn1LuG3NeGtluVG4oRTQLjxOjYuvpXAv7lJXUl4PNgxlt6bWOMd1qoovmRpleNkwdxKuVf29cwycD5/96Duka336hXuiltnVhyngugNvLtAG1FK3h7FCU/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(30052699003)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r6BRHxFzN3KDa1hyAIxRyJk5BGaEWE/IxZLeKScIoW2Q/0QSqkGl10W1Bfy8EzbQt4JnCOIiT93gdmoKROprto84iTdMB5ov7QErs+mt0MM2FAm30pOK9MDh9aw/ndEsbQrh4dEXl/rcR/TYmEjJbY8tCXnSOsqSX+5ZQZdG+DPp70Yh8zLEwRx/stURiH3SwUBXbecvq1TwAVAg7uhNmSl15ptxo17fWfSoEg+fINV9WuLQOVC0uHeBBsMMIyCgjFw80YQDLxlQ/lIQwmLwd2RQtfeqXP75VHwtpDRgqKagXMOkHGPlf2QR661AycRFSmd5BTYyGmLMNSoJ7JtNR2D7CPhqOL2ySLpC3sWsDImniRxTCDbTdfjxJv/iCbQGzY3Y1EqQZ0RTiGzUTo7quNjYHRBqTW54lA6eMp/QIVIMRhZsTJhuFWAp4Zofocqd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:04:33.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c124adaf-9a1b-4292-6ab5-08df08afad59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- When calculating the required LSDMA bandwidth, it must be capped to the
  global maximum LSDMA BW.
- Also check the calculated bandwidth against what is available in the
  SOP
- Rework code to only compute alt-ch params if alt-ch is in use
- Also remove some unused fields
- Fix whitespace errors

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn6_soc_bb.h    | 12 ++++++
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  1 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    | 33 ++++++++++++++++-
 .../dml2_core_dcn6_funcs_mode_support.c       | 37 +++++++++++--------
 .../src/dml2_core/dml2_core_shared_types.h    |  3 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |  7 ++++
 .../src/inc/dml2_internal_shared_types.h      |  1 +
 8 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h
index 19d43e5b7cc2..04292e77698b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h
@@ -206,6 +206,18 @@ static inline void dcn6_test_initialize_v3_sop_latencies_all_levels(
 				df_response_time_ps);
 }
 
+/**
+ * dcn6_test_override_lsdma_bandwidth_v3 - Debug / test interface that
+ * can be used to override the LSDMA bandwidth as needed for any LL and SOP.
+ * @dchub: DCN6 flat UTM QoS v3 table to modify
+ */
+static inline void dcn6_test_override_lsdma_bandwidth_v3(
+		struct utm_qos_model_dchub_v3 *dchub)
+{
+	/* Implement override as needed */
+	(void)dchub;
+}
+
 static inline void dcn6_test_initialize_utm_qos_model_v3(
 		struct utm_qos_model *qos_model,
 		struct utm_qos_model_dchub_v3 *dchub)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 422833548aa6..80d652bab5e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -172,6 +172,7 @@ struct dml2_soc_bb {
 	double lower_bound_bandwidth_dchub;
 	double fraction_of_urgent_bandwidth_nominal_target;
 	double fraction_of_urgent_bandwidth_flip_target;
+	unsigned int max_lsdma_bandwidth_kbps;
 	unsigned int dprefclk_mhz;
 	unsigned int xtalclk_mhz;
 	unsigned int pcie_refclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index c04a4af1f3ea..c241ecaf4d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -402,6 +402,7 @@ struct dml2_memory_path_bandwidth {
 		struct {
 			double urgent_bandwidth_kbps; // kbytes per sec
 			double non_urgent_bandwidth_kbps; // kbytes per sec
+			double lsdma_bandwidth_kbps; // kbytes per sec
 		} dcn5;
 	};
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index ba0082e216d5..125ad095c2bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -458,6 +458,37 @@ void dcn6_calculate_alternate_params(struct dml2_core_calcs_calculate_alternate_
 	unsigned int fw_delay;
 	struct swath_params swath_params;
 
+	/* the alternate channel outputs are only meaningful when the alternate channel is in use;
+	 * otherwise zero all outputs and return early */
+	if (!p->alt_chan_in_use) {
+		*p->svp0_max_bytes = 0;
+		*p->svp1_max_bytes = 0;
+		*p->lsdma_bw_req_for_alt_kbps = 0;
+
+		for (i = 0; i < p->display_cfg->num_planes; i++) {
+			p->svp0_max_bytes_per_dpp[i] = 0;
+			p->svp0_max_bytes_per_dpp_c[i] = 0;
+			p->svp1_max_bytes_per_dpp[i] = 0;
+			p->svp1_max_bytes_per_dpp_c[i] = 0;
+			p->total_swaths[i] = 0;
+			p->total_swaths_c[i] = 0;
+			p->prefetch_swaths[i] = 0;
+			p->prefetch_swaths_c[i] = 0;
+			p->prefetch_hdl_delta[i] = 0;
+			p->recout_hdl_delta[i] = 0;
+			p->prefetch_hdl_delta_c[i] = 0;
+			p->recout_hdl_delta_c[i] = 0;
+		}
+
+		for (i = 0; i < p->display_cfg->num_streams; i++) {
+			p->nom_req_limit_alt[i] = 0;
+			p->min_lead_dst_lines[i] = 0;
+			p->max_prefetch_in_lines[i] = 0;
+		}
+
+		return;
+	}
+
 	*p->svp0_max_bytes = 0;
 	*p->svp1_max_bytes = 0;
 	svp_max_bytes[0] = 0;
@@ -518,7 +549,7 @@ void dcn6_calculate_alternate_params(struct dml2_core_calcs_calculate_alternate_
 
 	*p->svp0_max_bytes = svp_max_bytes[0];
 	*p->svp1_max_bytes = svp_max_bytes[1];
-	*p->lsdma_bw_req_for_alt_kbps = p->dcn_non_urgent_bandwidth_kbps;
+	*p->lsdma_bw_req_for_alt_kbps = math_min2(p->dcn_non_urgent_bandwidth_kbps, p->max_lsdma_bandwidth_kbps);
 	copy_time_us = p->display_cfg->overrides.hw.force_alt_chan_copy_time.enable ? p->display_cfg->overrides.hw.force_alt_chan_copy_time.copy_time_us : calculate_alt_copy_time_us(p);
 	fw_delay =  p->display_cfg->overrides.hw.force_alt_chan_fw_delay.enable ? p->display_cfg->overrides.hw.force_alt_chan_fw_delay.fw_delay_us : p->alt_chan_fw_delay_us;
 	for (i = 0; i < p->display_cfg->num_streams; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 5de84d6c73c0..de81815f098a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -2242,8 +2242,19 @@ static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_
 	const struct dml2_utm_soc_bb *soc_bb = ctx->soc_bb;
 	struct dml2_core_internal_mode_support *inputs = states;
 	struct dml2_core_internal_mode_support *outputs = states;
+	unsigned int i;
+	bool is_alternate_pstate_required = false;
 
 	DML_LOG_FUNC_ENTER();
+
+	for (i = 0; i < ctx->display_cfg->num_planes; i++) {
+		if (ctx->display_cfg->plane_descriptors[i].overrides.uclk_pstate_change_strategy ==
+				dml2_uclk_pstate_change_strategy_force_alternate) {
+			is_alternate_pstate_required = true;
+			break;
+		}
+	}
+
 	p->display_cfg = ctx->display_cfg;
 	p->dst_y_prefetch = inputs->dst_y_prefetch;
 	p->SwathHeightY = inputs->SwathHeightY;
@@ -2271,16 +2282,17 @@ static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_
 	p->NoOfDPP = inputs->NoOfDPP;
 	p->max_num_dpp = ctx->ip->max_num_dpp;
 	p->dram_blackout_us = soc_bb->power_management_parameters.dram_clk_change_blackout_us;
-	p->VActiveLatencyHidingUs = inputs->VActiveLatencyHidingUs;
 	p->svp0_dst_lines = inputs->svp0_dst_lines;
 	p->svp1_dst_lines = inputs->svp1_dst_lines;
 	p->svp_req_limit = inputs->svp_req_limit;
-	p->dcn_non_urgent_bandwidth_kbps = inputs->support.bandwidth_upper_bound.dcn5.non_urgent_bandwidth_kbps;
+	p->dcn_non_urgent_bandwidth_kbps = **inputs->support.non_urg_bandwidth_required_flip * 1000;
+	p->max_lsdma_bandwidth_kbps = soc_bb->max_lsdma_bandwidth_kbps;
 	p->alt_chan_fw_delay_us = ctx->ip->alt_chan_fw_delay_us;
 	p->dst_y_per_vm_vblank = inputs->LinesForVM;
 	p->dst_y_per_row_vblank = inputs->LinesForDPTERow;
 	p->DSTYAfterScaler = inputs->DSTYAfterScaler;
 	p->ODMMode = inputs->ODMMode;
+	p->alt_chan_in_use = is_alternate_pstate_required;
 
 	p->svp0_max_bytes = &outputs->svp0_max_bytes;
 	p->svp1_max_bytes = &outputs->svp1_max_bytes;
@@ -3217,8 +3229,11 @@ static void dcn6_ms_calculate_bandwidth_upper_bound(const struct dml2_core_calcu
 		math_max3(**inputs->support.urg_bandwidth_required_flip,
 			**inputs->support.non_urg_bandwidth_required / ctx->soc_bb->fraction_of_urgent_bandwidth_nominal_target,
 			**inputs->support.non_urg_bandwidth_required_flip / ctx->soc_bb->fraction_of_urgent_bandwidth_flip_target) * 1000;
+	outputs->support.bandwidth_upper_bound.dcn5.lsdma_bandwidth_kbps = inputs->lsdma_bw_req_for_alt_kbps;
+
 	DML_LOG_DEBUG_DOUBLE(outputs->support.bandwidth_upper_bound.dcn5.non_urgent_bandwidth_kbps);
 	DML_LOG_DEBUG_DOUBLE(outputs->support.bandwidth_upper_bound.dcn5.urgent_bandwidth_kbps);
+	DML_LOG_DEBUG_DOUBLE(outputs->support.bandwidth_upper_bound.dcn5.lsdma_bandwidth_kbps);
 	DML_LOG_FUNC_EXIT();
 }
 
@@ -3650,8 +3665,6 @@ static void dcn6_ms_check_alternate_channel_size_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
-	unsigned int i;
-	bool alt_chan_in_use = false;
 	const struct dml2_utm_soc_bb *soc_bb = ctx->soc_bb;
 	struct dml2_core_internal_mode_support *inputs = states;
 	struct dml2_core_internal_mode_support *outputs = states;
@@ -3661,16 +3674,8 @@ static void dcn6_ms_check_alternate_channel_size_support(
 	DML_LOG_FUNC_ENTER();
 	outputs->support.alternate_channel_size_support = true;
 
-	//Alternate Channel Size Support Check - only fail if alternate channels are used AND exceed carveout limit
-	for (i = 0; i < ctx->display_cfg->num_planes; i++) {
-		if (ctx->display_cfg->plane_descriptors[i].overrides.uclk_pstate_change_strategy == dml2_uclk_pstate_change_strategy_force_alternate) {
-			alt_chan_in_use = true;
-			break;
-		}
-	}
-
-	if (alt_chan_in_use && (inputs->svp0_max_bytes > alternate_carveout_size_bytes ||
-					inputs->svp1_max_bytes > alternate_carveout_size_bytes)) {
+	if (inputs->svp0_max_bytes > alternate_carveout_size_bytes ||
+			inputs->svp1_max_bytes > alternate_carveout_size_bytes) {
 		outputs->support.alternate_channel_size_support = false;
 	}
 
@@ -4081,6 +4086,8 @@ static enum dml2_status dcn6_ms_validate_prefetch(
 
 		dcn6_ms_calculate_peak_bandwidth_required(ctx, states);
 
+		dcn6_ms_calculate_alternate_params(ctx, states);
+
 		dcn6_ms_calculate_bandwidth_upper_bound(ctx, states);
 
 		dcn6_ms_check_qos_bandwidth_support(ctx, states);
@@ -4095,8 +4102,6 @@ static enum dml2_status dcn6_ms_validate_prefetch(
 
 		dcn6_ms_calculate_vactive_det_fill_latency(ctx, states);
 
-		dcn6_ms_calculate_alternate_params(ctx, states);
-
 		dcn6_ms_check_alternate_channel_size_support(ctx, states);
 
 		dcn6_ms_calculate_pstate_schedule_windows(ctx, states);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index df552eac0006..289ed250f477 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -2309,16 +2309,17 @@ struct dml2_core_calcs_calculate_alternate_params {
 	unsigned int *NoOfDPP;
 	unsigned int max_num_dpp;
 	double dram_blackout_us;
-	double *VActiveLatencyHidingUs;
 	unsigned int *svp0_dst_lines;
 	unsigned int *svp1_dst_lines;
 	unsigned int *svp_req_limit;
 	double dcn_non_urgent_bandwidth_kbps;
+	double max_lsdma_bandwidth_kbps;
 	unsigned int alt_chan_fw_delay_us;
 	double *dst_y_per_vm_vblank;
 	double *dst_y_per_row_vblank;
 	unsigned int *DSTYAfterScaler;
 	enum dml2_odm_mode *ODMMode;
+	bool alt_chan_in_use;
 
 	/* output params */
 	unsigned int *svp0_max_bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index 9c6892edca8a..937205f1f086 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -181,6 +181,8 @@ static bool dcn6_v3_sop_table_is_bandwidth_supported_at_index(
 			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_IDLE][index];
 	const struct utm_qos_model_dchub_v3_sop_entry *active_entry =
 			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_ACTIVE_ALTERNATE_PSTATE][highest_sop_index];
+	const struct utm_qos_model_dchub_v3_sop_entry *pstate_entry =
+			&dchub->sops[UTM_QOS_MODEL_V3_LOAD_LEVEL_ACTIVE_ALTERNATE_PSTATE][index];
 
 	if (bw->dcn5.non_urgent_bandwidth_kbps > idle_entry->nominal_bandwidth_KBps
 			|| bw->dcn5.urgent_bandwidth_kbps > idle_entry->urgent_bandwidth_KBps)
@@ -190,6 +192,10 @@ static bool dcn6_v3_sop_table_is_bandwidth_supported_at_index(
 			|| bw->dcn5.urgent_bandwidth_kbps > active_entry->urgent_bandwidth_KBps)
 		return false;
 
+	/* check if the requested lsdma bandwidth fits within the current sop's alt-pstate lsdma budget */
+	if (bw->dcn5.lsdma_bandwidth_kbps > pstate_entry->lsdma_bandwidth_KBps)
+		return false;
+
 	return true;
 }
 
@@ -321,6 +327,7 @@ static void dcn6_initialize_from_soc_bb(struct dml2_utm_soc_bb *utm_soc_bb,
 	utm_soc_bb->lower_bound_bandwidth_dchub = soc_bb->lower_bound_bandwidth_dchub;
 	utm_soc_bb->fraction_of_urgent_bandwidth_nominal_target = soc_bb->fraction_of_urgent_bandwidth_nominal_target;
 	utm_soc_bb->fraction_of_urgent_bandwidth_flip_target = soc_bb->fraction_of_urgent_bandwidth_flip_target;
+	utm_soc_bb->max_lsdma_bandwidth_kbps = soc_bb->max_lsdma_bandwidth_kbps;
 }
 
 static void dcn6_initialize_from_qos_model(struct dml2_utm_soc_bb *utm_soc_bb,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 8ddf58da2eed..4289f7f998ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -117,6 +117,7 @@ struct dml2_utm_soc_bb {
 	double lower_bound_bandwidth_dchub;
 	double fraction_of_urgent_bandwidth_nominal_target;
 	double fraction_of_urgent_bandwidth_flip_target;
+	unsigned int max_lsdma_bandwidth_kbps;
 	unsigned int dchub_refclk_mhz;
 	unsigned int max_outstanding_reqs;
 	unsigned long return_bus_width_bytes;
-- 
2.43.0

