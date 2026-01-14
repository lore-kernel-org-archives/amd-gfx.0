Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC5FD39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5754410E675;
	Wed, 14 Jan 2026 20:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJoiChc1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621E610E243
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3efIAF3WXdemi6QTjgqKIb9HC55ixcU/ODWMKkqfUoWLqRkYRHSTreQFBxfTPW5CtMBwBZkJr6+Ol1KKRk4I1b0EP4SI3lpJQir91edlhPtu0asQrxOLHE8lLosCwaKAwfDAtyAIDKCltLCsPWq4ZEx5f9FpAJEkTJbEhR0XgvuFkY7F4wubqGIIwsACJlZzxHu+K81GvjD4DA5v91xmnLuQIJeAd2CHSkH68+oa5qaBn274Se3d7q3RSQx16ouDdoAyArXOfc1pjCKJWX80ED/K2HnOzvlEPSIoxUIv/q9OWd5CsvdzmBJIPcmLqzFZU/ZiuQubppa4A/lVddrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFQCb+P6Qt6sqPlYPNS4ZSH3jYCsMOZKxiTxSaS+bFU=;
 b=BfkG3NaBE3Ev0Pi+xnXjWbLLMmH+g0Sw6MtBUTdiKJrJPsrNpGeYBnzi9RHP7/oSiP/2HAJ6nV5Ebw67VgeUMXE7+pbcp7CsJ0Qm0FeYeA+jXXxJOV7YntpWCqOnwgjubLNOzwOj2AJGqCHOdV5NldyBI3PyrqR25MVWbr1QelGEKH99nE4XxommuH7gEofVQczEXB+wYZ01rKC0Ocax7Eg/2pjqp+MGqh+9f2+n4Wx0DUUpVoZiGL2gi5+a3kzez8jEAQK/khwshmIGpWMA3ZOhNMNZKt3XLWmSX43t7vlhIRfZD4DZtAEQw9gGqWGBD8gxHpzwyiIRrRt/Sh5SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFQCb+P6Qt6sqPlYPNS4ZSH3jYCsMOZKxiTxSaS+bFU=;
 b=UJoiChc1kFpq4T0kdi6GmiJ3swI1wG10rJYZsC3fC225u1Dt97b2nu856Y+mucimjuHj8cUSnf08JTGYKDk8jIET+S2lXNMlwWVO6dh8PnWg3852S6OiJbAhrfMOHSqLD1etvXz46+CR8Zf7WuDKOvMEkZN5oFBLbjzJEZzAIis=
Received: from CH2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:20::32)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 20:24:03 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::73) by CH2PR07CA0019.outlook.office365.com
 (2603:10b6:610:20::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 20:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 14:24:01 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:01 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 01/14] drm/amd/display: update memory QoS measurement interface
Date: Wed, 14 Jan 2026 15:21:42 -0500
Message-ID: <20260114202421.3654137-2-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: d6247c06-dae9-47a3-679d-08de53aadc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ctJ3t00jBH7qrmhklWnRpmY82QI5CIDM+5IZsT83SfQQut+ZhPm6Q8sZPdU?=
 =?us-ascii?Q?6MpXgvo7iImcJ+RDIMap03yIB1kovoW1u8TsQfLDBqqmuvUjsSTyA/wUSIYP?=
 =?us-ascii?Q?MSHPFdhCTW02pnQgMWpLv3Y8dSp0S+aC+aCgj8/AIb2Z1ttgf/3bGS+UxmGK?=
 =?us-ascii?Q?7/BeoUaCzEsx+nh9iPgixuDhdRXxjyzLt6uhHhFUEmC2KRd60z96EKLPccNK?=
 =?us-ascii?Q?VlU+0CiIh+0FzZY4NOSIVzKVXUMdPHdHccJnXxufi7iof/iCnHK8Lu2xX2sn?=
 =?us-ascii?Q?PsPBtENmSrpVwh02hR9g2juCcSpA2FDZgCUhoImq+ma5yGmwsvKq4yQar/M6?=
 =?us-ascii?Q?c5/8mdgfa8qMv35LE4OqwaF4V9G5w0udQxEZcJXqDDb73yQpZdN8JwE3VKIN?=
 =?us-ascii?Q?ydM/67ZZkarxTaoxIeOMNBg08rktQuw/tpnQ+rarPYwvyPdfxr+ANJC2yyyG?=
 =?us-ascii?Q?8K9pJ+4WBheoQz6/PYYxPvDrhNvDkiyYyMgHFkEJjxPkOP7VmZ/+52F+vEIa?=
 =?us-ascii?Q?b2CdMUHasbOqGWeyR+mTDVx+Uw0/dDW+Qmn/it4sL8UwS5K27pNVYYYM94i2?=
 =?us-ascii?Q?5OEK4B/OsOhKv6zo59ZkGb/5Aky1U41YzmZEDbcE1kBRDtg23HGjylpNGn48?=
 =?us-ascii?Q?Nwikzql6A9+hO8xBgt3NglNqm4mR8mv4HmeSwXwn2M8G7KsutbIODnqayifk?=
 =?us-ascii?Q?uHWgiJ2ybX17Kr2NQg1NnUTXPDYv+6Sy2J+cV9N3UVwcBv1ZL0H+WaqkL/Ep?=
 =?us-ascii?Q?8WvK8zzIqQM6MVQ8bxnYJRBdoKtuhdaJmprVhcswDmUkQCEQt7ccaG3S/vNH?=
 =?us-ascii?Q?mA4HAvBQrB+Sbvweme6P81y0mdtFbMidEA2YBDw/oX/dyDXJtHoo685ZGdce?=
 =?us-ascii?Q?7cO/JD6eVoDKsyCeE3Q5teTkuH61UiavgFGvIQgc36DVyBFlT052jR9Dvhfr?=
 =?us-ascii?Q?s8fJSNuj0YQUADSt3S/HOLxOs5vbeAwTiTK9jTpdz1cIzrGwraDyUaYA7npl?=
 =?us-ascii?Q?3jzQKeFeeh5h7Keq094hDNaNX599cVBxxpFRocJ8ijfKoK+9VhSe5Ae9zdJb?=
 =?us-ascii?Q?w6fIXeXoccoI7T3BbtdDUm/Qw1nmjih7dTCypKFMAHgI/o9vQzFxG7srhq/h?=
 =?us-ascii?Q?r3OYGSQJYJA7rMrHp9b78F5n8Gb0/eM0Go24gD7QTd4L8MldQsGrlBSVCiNI?=
 =?us-ascii?Q?v1VA38JHZijeprElV0pYQNlFoTKnZfAuKo/6t7WMNbDE2/6//JaQY4RudFfZ?=
 =?us-ascii?Q?td/2HYuSdZECGmiI0i9k/GWsgG4a4KFmvb1TKe0sdiomsgd4mtsgBrjqMCWJ?=
 =?us-ascii?Q?QB79ouuu4F0utnEtgQib7QWviaf3b7vobkOrljcZ0Wk+lQNv8lzKWcKyNzkZ?=
 =?us-ascii?Q?hAlxEk1QQRPq8WoMCAz6VrDoynDw3fHfluYLAKFMj67x9H1L3EIR917/Jrv5?=
 =?us-ascii?Q?be9Fp1qQQHlgfzJ88VzjvYMcqWfZsuC1IMBNHQwAX2lmTsoTrGRpC9wHktzb?=
 =?us-ascii?Q?vArnM7lEARkBkixuRmylxALw41WFOAG0DB01ouxamwWruc3H6roVzrNaxnJE?=
 =?us-ascii?Q?Dol7mvB7wNVkmRuCHhpmrRdjHWvN4wIkSin1d+ssAmjpwRV4f9RGKGVXLOF5?=
 =?us-ascii?Q?kPF5WuEqljAQ5K1Lh6z1c2iWWdKfoEgVnXmxSOMA/qvGXUi2JnDTKBwd9FgD?=
 =?us-ascii?Q?z59svw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:03.4464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6247c06-dae9-47a3-679d-08de53aadc10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

[how]
- Consolidate memory QoS measurement functions into a single interface for
  better maintainability and usability.
- Update function naming for improved clarity.
- Unify latency measurements into a single function call with update
  programming sequence.
- Add `start_measuring_urgent_assertion_count` and
  `get_urgent_assertion_count` interfaces.
- Add `start_measuring_prefetch_data_size` and `get_prefetch_data_size`
  interfaces.
- Update start_measuring_unbounded_bandwidth implementation to measure 200
  data returns in the middle of prefetch window.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 22 ++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 38 +++----------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  8 ++++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 28 +++++++++-----
 5 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aba5ad2a7a33..ad8ce46ce310 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7143,22 +7143,24 @@ void dc_log_preos_dmcub_info(const struct dc *dc)
 bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 {
 	const struct dc_clocks *clk = &dc->current_state->bw_ctx.bw.dcn.clk;
+	struct memory_qos qos;
 
 	memset(info, 0, sizeof(*info));
 
-	// Check if all measurement functions are available
-	if (!dc->hwss.measure_peak_bw_mbps ||
-	    !dc->hwss.measure_avg_bw_mbps ||
-	    !dc->hwss.measure_max_latency_ns ||
-	    !dc->hwss.measure_avg_latency_ns) {
+	// Check if measurement function is available
+	if (!dc->hwss.measure_memory_qos) {
 		return false;
 	}
 
-	// Call measurement functions to get actual values
-	info->actual_peak_bw_in_mbps = dc->hwss.measure_peak_bw_mbps(dc);
-	info->actual_avg_bw_in_mbps = dc->hwss.measure_avg_bw_mbps(dc);
-	info->actual_max_latency_in_ns = dc->hwss.measure_max_latency_ns(dc);
-	info->actual_avg_latency_in_ns = dc->hwss.measure_avg_latency_ns(dc);
+	// Call unified measurement function
+	dc->hwss.measure_memory_qos(dc, &qos);
+
+	// Populate info from measured qos
+	info->actual_peak_bw_in_mbps = qos.peak_bw_mbps;
+	info->actual_avg_bw_in_mbps = qos.avg_bw_mbps;
+	info->actual_min_latency_in_ns = qos.min_latency_ns;
+	info->actual_max_latency_in_ns = qos.max_latency_ns;
+	info->actual_avg_latency_in_ns = qos.avg_latency_ns;
 	info->dcn_bandwidth_ub_in_mbps = (uint32_t)(clk->fclk_khz / 1000 * 64);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4068d5baef21..6daa35cd96a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -962,6 +962,7 @@ struct dc_qos_info {
 	uint32_t actual_avg_bw_in_mbps;
 	uint32_t calculated_avg_bw_in_mbps;
 	uint32_t actual_max_latency_in_ns;
+	uint32_t actual_min_latency_in_ns;
 	uint32_t qos_max_latency_ub_in_ns;
 	uint32_t actual_avg_latency_in_ns;
 	uint32_t qos_avg_latency_ub_in_ns;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 490a6fccebff..51b0f0fd8fcd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -52,7 +52,7 @@ struct drr_params;
 struct dc_underflow_debug_data;
 struct dsc_optc_config;
 struct vm_system_aperture_param;
-
+struct memory_qos;
 struct subvp_pipe_control_lock_fast_params {
 	struct dc *dc;
 	bool lock;
@@ -1289,40 +1289,14 @@ struct hw_sequencer_funcs {
 			struct dc_underflow_debug_data *out_data);
 
 	/**
-	 * measure_peak_bw_mbps - Measure actual peak bandwidth in Mbps
-	 * @dc: DC structure
-	 *
-	 * Returns the measured peak bandwidth value in Mbps from hardware
-	 * performance counters or registers.
-	 */
-	uint32_t (*measure_peak_bw_mbps)(struct dc *dc);
-
-	/**
-	 * measure_avg_bw_mbps - Measure actual average bandwidth in Mbps
-	 * @dc: DC structure
-	 *
-	 * Returns the measured average bandwidth value in Mbps from hardware
-	 * performance counters or registers.
-	 */
-	uint32_t (*measure_avg_bw_mbps)(struct dc *dc);
-
-	/**
-	 * measure_max_latency_ns - Measure actual maximum latency in nanoseconds
-	 * @dc: DC structure
-	 *
-	 * Returns the measured maximum latency value in nanoseconds from hardware
-	 * performance counters or registers.
-	 */
-	uint32_t (*measure_max_latency_ns)(struct dc *dc);
-
-	/**
-	 * measure_avg_latency_ns - Measure actual average latency in nanoseconds
+	 * measure_memory_qos - Measure memory QoS metrics
 	 * @dc: DC structure
+	 * @qos: Pointer to memory_qos struct to populate with measured values
 	 *
-	 * Returns the measured average latency value in nanoseconds from hardware
-	 * performance counters or registers.
+	 * Populates the provided memory_qos struct with peak bandwidth, average bandwidth,
+	 * max latency, min latency, and average latency from hardware performance counters.
 	 */
-	uint32_t (*measure_avg_latency_ns)(struct dc *dc);
+	void (*measure_memory_qos)(struct dc *dc, struct memory_qos *qos);
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 5ed2cd344804..61d8ef759aca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -704,4 +704,12 @@ struct dc_bounding_box_max_clk {
 	int max_phyclk_mhz;
 };
 
+struct memory_qos {
+	uint32_t peak_bw_mbps;
+	uint32_t avg_bw_mbps;
+	uint32_t max_latency_ns;
+	uint32_t min_latency_ns;
+	uint32_t avg_latency_ns;
+};
+
 #endif /* _CORE_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 1ddfa30411c8..4307362749f0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -254,30 +254,38 @@ struct hubbub_funcs {
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 	void (*dchvm_init)(struct hubbub *hubbub);
 
+	/* Performance monitoring related functions */
 	struct hubbub_perfmon_funcs {
 		void (*reset)(struct hubbub *hubbub);
-		void (*start_measuring_max_memory_latency_ns)(
+		void (*start_measuring_memory_latencies)(
 				struct hubbub *hubbub);
-		uint32_t (*get_max_memory_latency_ns)(struct hubbub *hubbub,
-				uint32_t refclk_mhz, uint32_t *sample_count);
-		void (*start_measuring_average_memory_latency_ns)(
+		uint32_t (*get_memory_latencies_ns)(struct hubbub *hubbub,
+				uint32_t refclk_mhz, uint32_t *min_latency_ns,
+				uint32_t *max_latency_ns, uint32_t *avg_latency_ns);
+		void (*start_measuring_urgent_assertion_count)(
 				struct hubbub *hubbub);
-		uint32_t (*get_average_memory_latency_ns)(struct hubbub *hubbub,
-				uint32_t refclk_mhz, uint32_t *sample_count);
-		void (*start_measuring_urgent_ramp_latency_ns)(
+		bool (*get_urgent_assertion_count)(struct hubbub *hubbub,
+				uint32_t refclk_mhz,
+				uint32_t *assertion_count,
+				uint32_t *deassertion_count,
+				uint32_t *timestamp_us);
+		void (*start_measuring_urgent_ramp_latency)(
 				struct hubbub *hubbub,
 				const struct hubbub_urgent_latency_params *params);
 		uint32_t (*get_urgent_ramp_latency_ns)(struct hubbub *hubbub,
 				uint32_t refclk_mhz);
-		void (*start_measuring_unbounded_bandwidth_mbps)(
+		void (*start_measuring_unbounded_bandwidth)(
 				struct hubbub *hubbub);
 		uint32_t (*get_unbounded_bandwidth_mbps)(struct hubbub *hubbub,
 				uint32_t refclk_mhz, uint32_t *duration_ns);
-		void (*start_measuring_average_bandwidth_mbps)(
+		void (*start_measuring_in_order_bandwidth)(
 				struct hubbub *hubbub);
-		uint32_t (*get_average_bandwidth_mbps)(struct hubbub *hubbub,
+		uint32_t (*get_in_order_bandwidth_mbps)(struct hubbub *hubbub,
 				uint32_t refclk_mhz, uint32_t min_duration_ns,
 				uint32_t *duration_ns);
+		void (*start_measuring_prefetch_data_size)(
+				struct hubbub *hubbub);
+		uint32_t (*get_prefetch_data_size)(struct hubbub *hubbub);
 	} perfmon;
 
 	struct hubbub_qos_funcs {
-- 
2.52.0

