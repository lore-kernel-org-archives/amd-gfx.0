Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC225D111B7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C9710E73A;
	Wed, 26 Nov 2025 23:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3IIFJCfH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AC410E72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4xzJCWC5ULWbUHZ1+d7eOOBfjXdGXKcVjnU/r88j9msqR0AV3aMSqBZOWjWjIbT1U4KPN8YDK21BntFKfcR21K/DKHqfz0V5Uv4WIzPOyVLFHK/eLzvezcYzpc/UHvYrNZIsHe9SRtOcsVnHudmuren+adiHPfKVQ1qUsAJpLkdi2li3tGws6RjkurNW/sQ2OBLv9M+YnOi4UsSE29I6PqmBccpG5c58pUIyYdqE4VlIDqbnj1eyS5Q6Lb4s8vvYvZtR9GwEOGo7zfPYOy8ymPdsUbYAgApVjkPpAti9bg1A1BbdjqFi3xH/mIUMO8g+HsoIplBVOg3H8MkB+cVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGua+OdzWTrbhrDMC5lDC9pxv1JZuIXsqauW5Xurf9w=;
 b=IMANckBGv26TpnNtfiKMx7KkW9zcGFeagoI4r1EvaUvrzbFn7kTZuT6FOjTyoEnPoN5ZNWj1cZN5++ZXqTdtGW1zg/vLE/dybSW2VIoUT7YWMQmYHRlW9JFgBdPltn1kCVeNl81n7lStHTFfBbQiwYNrOWEOQQl3KS3q+pfrzZFhNOMp7L+WrA5W6WVg5QMJYh8pqZmr1IU1WZPCc1T8NX82bWWMJTufu4AfRJ6JONsyc/6cMdvwTT1TrypW2mW05JRHmbYJpmQZhfRQ4c/8FtpIh6xtWuM+xL2/PF1qKp8FN0nmWb5vu+yJ8x39+2MQ7OVOH+j1zdRXywK6AMt1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGua+OdzWTrbhrDMC5lDC9pxv1JZuIXsqauW5Xurf9w=;
 b=3IIFJCfHlksbTOSryOWYCKGRE0q4ek+6/hUZzIenqcEBHaWu9eL3iYP6orYY6FRUJ2ILZ1gQuatBj161f8O/czJhwNae36Uiub4LndFLipUSIStYVY7V1i5ES3jTfR6JSrulztm4OOWa+1vRmFsQeMLQQq+xdOzbStJGLPsJVkE=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:39 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::4a) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 23:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:38 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:37 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 07/14] drm/amd/display: add dc interface for query QoS
 information
Date: Wed, 26 Nov 2025 18:06:07 -0500
Message-ID: <20251126230614.13409-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c082ff2-e90f-4f59-9789-08de2d40748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BULQ56jp1+f2jdmU9Fs94p8mb8Dk/Vr50/eLquTqzi/jy5vFNJKZe9aMisLy?=
 =?us-ascii?Q?Icil/fpquz7YOv0RJSCfIKTWIk3hkMWU9m4GX3BweRNvyghHucbTlxqO9yky?=
 =?us-ascii?Q?aZRH39UOX7BlDG0cWhd6tTEB82bUzotFCQSiT7ArLE8OzvCc43YVbXeQFehi?=
 =?us-ascii?Q?LUV4VYQ13cosShyjEp6iI9SvoNn93WeBUUTVR24e6+n7e/Wgvkz/DFRJvYE5?=
 =?us-ascii?Q?aPnXOFOhSZTV6tKmcGiGBEZTIp6i9WcN8sAcIQjsvXQBdOA56dU2S8UgbboU?=
 =?us-ascii?Q?elq9muy+7Zv8fRxRVCuwStpKubCyo+jBce56daGn1ZHYAXZ/jtmenZoAzcvT?=
 =?us-ascii?Q?yIaYwP8qacTV7pb9tlHpdaczYkF2zK3f9J255uujt+iZ6ifyH77KqhfnybIU?=
 =?us-ascii?Q?SLm7i1978gl0j5NBbvOGBxRZF8hqoBGUO0AiWeNM+ruTHy6yCvDjWAiEL+u+?=
 =?us-ascii?Q?+Gc0DaDt2+YAduFuK9BemiNrCcgQRBYh0vsrAGpx7Kmwq8c8hb8WbGpyVxKM?=
 =?us-ascii?Q?uG87WEgxqLBFD4oeqce4KGNkmNm01w5tBWjeeejcCVsZ2Ag744hrTlkB7Cst?=
 =?us-ascii?Q?GCUSsoWS3+qkY0aEtcJ4N5Lf9vh3bTl6YlUoRBJDwsv6yH6nrFPHoE3NjyB6?=
 =?us-ascii?Q?vQkcNDWBiZTJs6sAxiwvZaZdj9XHf8LYKQceyTgm8KniorvlolOj9EnoW0Kr?=
 =?us-ascii?Q?NY7RAjdBJLeq8JCM23JKyTf2tRnV4b6/5//YyzT+czWjtBxfLbXJvz33eFub?=
 =?us-ascii?Q?hxuuIxRARZ8ZKKxsqON9NFqxWJVvs/yo8R0qbfBPaGS01E0XnutKDM8zjbNi?=
 =?us-ascii?Q?KtIPt5YMc9fKYyZmiFeOVrUOFsfxg+gkvDOzWa9IQf+OIZQkUfQKHDYdNncG?=
 =?us-ascii?Q?cGj2b2Cq/nbCYMcQ6Vnk8DDAkyOOSjdG9pkHKD2EmDHg7LWYdAwG94M16VOl?=
 =?us-ascii?Q?GsvFDOE+/qQodoFqfipDQIEY10xQCH033FClSK+nFpI+2GkSqSJEcfHWJ0j0?=
 =?us-ascii?Q?ikA1RPso6w53Lx2qIs543rdxpRU970mQqr43smVBntw0yNZmUgg7KUZZbZDT?=
 =?us-ascii?Q?7bwnglmK+akZqzNkOuI+xNWM5id6es/AJKJHQRhRRXF+gdr53/yCfUFRgAGH?=
 =?us-ascii?Q?sPFvFwLcZ3GFDLLdU8fF/WSAJAzXvL9U41btFJuJO1lWePhZuOFCey3fityv?=
 =?us-ascii?Q?xrGHLIVhTRpa+GTnIU/eCyTAA9RJQCmXX6PKhLgiYZlG1E/+ePn66FJe+tTM?=
 =?us-ascii?Q?/UpC3RJ5k1IwlrRbLtobhr8VNgUiKar4OWh0IN6ECt68r4F7su4lE/hRf39K?=
 =?us-ascii?Q?wI+onsOfOa4seTVZrcHdDcuWRjREALqvGsl0nSqhz4klYHZCD9Dm8wHTgLQY?=
 =?us-ascii?Q?DF5F27qXctn4jC5R+fRkwrIqVkvro3seyOCppFh1ZffV0cEq4pz9vEzm4eum?=
 =?us-ascii?Q?TyzZkwlQAK/nR4WeqBIHE1jeOGqgq2VnxKEKF0iJOP6eNF1xKm3mc6Bh9ctg?=
 =?us-ascii?Q?wcfSr6Wu+jA5wbX4KsN40sllUUGac7wr7Lw1UZ6A4vMkIwdxcBAY8Vh351iw?=
 =?us-ascii?Q?Tks/eHHQpRl82S7VfgE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:38.9422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c082ff2-e90f-4f59-9789-08de2d40748d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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

[why]
Add support for retrieving Quality of Service (QoS) metrics from dc
to enable performance analysis and bottleneck identification. This provides
benchmark tools with real-time bandwidth and latency measurements from hardware
performance counters, helping diagnose display system performance issues.

[how]
- Add dc_get_qos_info() function to DC layer for unified QoS data retrieval
- Implement hardware sequencer interface with function pointers for QoS
measurements
- Integrate QoS metrics: peak/average bandwidth (Mbps) and max/average
latency (ns)

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 36 ++++++++++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 37 +++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8be9cbd43e18..1e7c61b975e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7091,3 +7091,27 @@ void dc_log_preos_dmcub_info(const struct dc *dc)
 {
 	dc_dmub_srv_log_preos_dmcub_info(dc->ctx->dmub_srv);
 }
+
+bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
+{
+	const struct dc_clocks *clk = &dc->current_state->bw_ctx.bw.dcn.clk;
+
+	memset(info, 0, sizeof(*info));
+
+	// Check if all measurement functions are available
+	if (!dc->hwss.measure_peak_bw_mbps ||
+	    !dc->hwss.measure_avg_bw_mbps ||
+	    !dc->hwss.measure_max_latency_ns ||
+	    !dc->hwss.measure_avg_latency_ns) {
+		return false;
+	}
+
+	// Call measurement functions to get actual values
+	info->actual_peak_bw_in_mbps = dc->hwss.measure_peak_bw_mbps(dc);
+	info->actual_avg_bw_in_mbps = dc->hwss.measure_avg_bw_mbps(dc);
+	info->actual_max_latency_in_ns = dc->hwss.measure_max_latency_ns(dc);
+	info->actual_avg_latency_in_ns = dc->hwss.measure_avg_latency_ns(dc);
+	info->dcn_bandwidth_ub_in_mbps = (uint32_t)(clk->fclk_khz / 1000 * 64);
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 458883adfc28..827e0008c31d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -951,6 +951,18 @@ struct dc_bounding_box_overrides {
 	int min_dcfclk_mhz;
 };
 
+struct dc_qos_info {
+	uint32_t actual_peak_bw_in_mbps;
+	uint32_t qos_bandwidth_lb_in_mbps;
+	uint32_t actual_avg_bw_in_mbps;
+	uint32_t calculated_avg_bw_in_mbps;
+	uint32_t actual_max_latency_in_ns;
+	uint32_t qos_max_latency_ub_in_ns;
+	uint32_t actual_avg_latency_in_ns;
+	uint32_t qos_avg_latency_ub_in_ns;
+	uint32_t dcn_bandwidth_ub_in_mbps;
+};
+
 struct dc_state;
 struct resource_pool;
 struct dce_hwseq;
@@ -3322,4 +3334,28 @@ struct dc_register_software_state {
  */
 bool dc_capture_register_software_state(struct dc *dc, struct dc_register_software_state *state);
 
+/**
+ * dc_get_qos_info() - Retrieve Quality of Service (QoS) information from display core
+ * @dc: DC context containing current display configuration
+ * @info: Pointer to dc_qos_info structure to populate with QoS metrics
+ *
+ * This function retrieves QoS metrics from the display core that can be used by
+ * benchmark tools to analyze display system performance. The function may take
+ * several milliseconds to execute due to hardware measurement requirements.
+ *
+ * QoS information includes:
+ * - Bandwidth bounds (lower limits in Mbps)
+ * - Latency bounds (upper limits in nanoseconds)
+ * - Hardware-measured bandwidth metrics (peak/average in Mbps)
+ * - Hardware-measured latency metrics (maximum/average in nanoseconds)
+ *
+ * The function will populate the provided dc_qos_info structure with current
+ * QoS measurements. If hardware measurement functions are not available for
+ * the current DCN version, the function returns false with zero'd info structure.
+ *
+ * Return: true if QoS information was successfully retrieved, false if measurement
+ *         functions are unavailable or hardware measurements cannot be performed
+ */
+bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info);
+
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 8ed9eea40c56..490a6fccebff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1287,6 +1287,43 @@ struct hw_sequencer_funcs {
 	void (*get_underflow_debug_data)(const struct dc *dc,
 			struct timing_generator *tg,
 			struct dc_underflow_debug_data *out_data);
+
+	/**
+	 * measure_peak_bw_mbps - Measure actual peak bandwidth in Mbps
+	 * @dc: DC structure
+	 *
+	 * Returns the measured peak bandwidth value in Mbps from hardware
+	 * performance counters or registers.
+	 */
+	uint32_t (*measure_peak_bw_mbps)(struct dc *dc);
+
+	/**
+	 * measure_avg_bw_mbps - Measure actual average bandwidth in Mbps
+	 * @dc: DC structure
+	 *
+	 * Returns the measured average bandwidth value in Mbps from hardware
+	 * performance counters or registers.
+	 */
+	uint32_t (*measure_avg_bw_mbps)(struct dc *dc);
+
+	/**
+	 * measure_max_latency_ns - Measure actual maximum latency in nanoseconds
+	 * @dc: DC structure
+	 *
+	 * Returns the measured maximum latency value in nanoseconds from hardware
+	 * performance counters or registers.
+	 */
+	uint32_t (*measure_max_latency_ns)(struct dc *dc);
+
+	/**
+	 * measure_avg_latency_ns - Measure actual average latency in nanoseconds
+	 * @dc: DC structure
+	 *
+	 * Returns the measured average latency value in nanoseconds from hardware
+	 * performance counters or registers.
+	 */
+	uint32_t (*measure_avg_latency_ns)(struct dc *dc);
+
 };
 
 void color_space_to_black_color(
-- 
2.34.1

