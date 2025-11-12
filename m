Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E032CD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FC810E797;
	Wed, 12 Nov 2025 18:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q/QrGbeC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFCD10E798
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKuc7SBk//C/t4LEHDuOvK9LD4mnQuhirCqTKD7b4YRmonTTHZ6iPHSzp4OxyC3R/J4sv9WkJkjGIZHqU+3Ycw6EDsGBdgmHNOLUW6R4n7F0FBCW81iGoOWq+izXi6hJmrJdMGzGB8mqlv7qeeNMU/KyrQWM4w2JTYbVjnqYv58LPo757oD3HxT/zj64Lf4o+fAhtLEPlQ2oj8/QmKXHN1EH25g0uLiybiGEzulA4qX3ms176eL+nhxZAkzNF0XpH+d44ArkoWlWpePPnCssNgdxCMkyyJjdm/x9c9TzahwbkiuqwYEgYZygJ8hEHZsYqGlHv331f08QsDuYCCS7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWFTUNVNgeX38Y2a3+REuE1jLdtZDNjF80ENEuP0YlY=;
 b=N3jWhsj6W2YEmS4KlZAND9rpu6lNlIt4mDykX6dqBzpx8qM3GgEwzSjfhIH+lYi25jOLxrdIBsR+Iti+J97izNn2Sh5Lux3UmUQQBVWYoT615sYKT5G500xqZWVOiSrLQX9ksF2gtSOP5ETKBSUcfkwLZUCOBcBxnEA0ql+i7fPduCkRIjsDZtI7BKWoGYnHi8bcBN2X9eEace4QRMSr4WgAjHAlHS3T39c8sHa/Wq0wk/SjXGzMZCds7n3abbp0mJ3JQ9MYdNcqZRjR9BkTk30aZzrcKvDgjprr9QKf4104+Ld3s6gowimsbTO5iEV+xv54j2MMJ4zDqMy/hL+67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWFTUNVNgeX38Y2a3+REuE1jLdtZDNjF80ENEuP0YlY=;
 b=Q/QrGbeCuxACmdSeQAnYOPrx9e9aMO3raeXvw8edaRZp8gO3/v1r7vJcZQ6qdH/JN7OjapEz7YDHpCHptwRrCOvTCXhK7HWNuRdydAmHvCrCZep40jp4RwxeCfx0eS6kvwxd7/eQGc5Z882wwxXQ1mTU0Laj+LRIgcdSgTBwtio=
Received: from CY5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:930:1e::17)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 12 Nov
 2025 18:23:25 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::cb) by CY5PR04CA0027.outlook.office365.com
 (2603:10b6:930:1e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:23:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:23:02 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:23:02 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:56 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 14/16] drm/amd/display: Fix pbn to kbps Conversion
Date: Wed, 12 Nov 2025 13:20:32 -0500
Message-ID: <20251112182212.559007-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7911a43e-3b8f-4a68-cf8f-08de221891a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IqJhTFpD9XPno7/sHU2NcRtY6vP2mzOnwq3Q5T9wyiN7jMjZmzjtQwMd5qVn?=
 =?us-ascii?Q?xnxC9JHZUCGw4UYYLM7eVswYB7YBw44oDB4JXoSkXZBcEn440x8O1sEBnnvN?=
 =?us-ascii?Q?f9A7ESJt0bQ+27fbRC53wm1lkKIWBRun4ep1sdwvZfhszNPih3zqUmH4eFek?=
 =?us-ascii?Q?d5k3tWj5J6k7Yt35I9e0Gdv27BxaMzKDgP7aZ34u28ZECogIe+nKXuqTuC61?=
 =?us-ascii?Q?usFsACNABVQubFgcfgBLgtwWFA1rDel+9HuxDMRvV3ut9KfaXmBgh4xcPQBm?=
 =?us-ascii?Q?l91lHOdcaPk90lRU+htWa3VSkXBmLA6YsrTNYCnz1yz+5qLxZ1jjLza7NDVM?=
 =?us-ascii?Q?Hv/ZZcXoFREFnYgfnmky0qGA851Zfkgd9iggikT88IGfmDhgBxpyiwDWshUa?=
 =?us-ascii?Q?7+v1OBgFtImA+SHWI8HXeeljSHHA2lUCyWNgNagH/Z0XL4QBuybicdTc0+cN?=
 =?us-ascii?Q?CgEL/URR+S/bYV+sOtzF3iu9gs7VbDaVhOMkfJVKa+sjezuX0S8/c0D8X4zL?=
 =?us-ascii?Q?yH8p/MG8BKikdkEBcEPRRXWgZv7CWzBmuGF+W/41Ep+FQicvY2oP4QINFS3e?=
 =?us-ascii?Q?zQUci0AvtlE9idXDWosZirTSrJvL+1+S78kEMbljNhHhW2V4pjFlYSrouUdF?=
 =?us-ascii?Q?/MZMjma4l8dzSQSwzIHJDXrmyjuWKq/LrWiwHrG4UQeDEsdU7fCY+ImK0ede?=
 =?us-ascii?Q?4CVK7BBPRVRtxc1gmkJFpe81ViYxorcAinUY3l4z/qaD4XYLOK9+zAk+9WGu?=
 =?us-ascii?Q?QhAcjMZse0KM54olGV5zD/shV4If5hGra5rDJavRpN7gmL8kSRCQZD4XCl8C?=
 =?us-ascii?Q?8iASB/3tVA20SQT9BquUZlOyyTJ0hhNSqniTt100NCqaChyQavEIr53aZldD?=
 =?us-ascii?Q?1DqDFsUIRDvzt8Z13xQzvGSj9fbbopNQTDHG/0U8DZaj9UXDkUibpDt0OBxy?=
 =?us-ascii?Q?DExfC7VEQdxYXwfl1nT9/2rSqYwuBK/PMelNFyXeRiALzAG+vUvDstHEWsYY?=
 =?us-ascii?Q?vP7ctqs0BoTV3LesFT1S3T88H750ZLyD6Tuo0/QIaznUczZNnXspoeXKt+PH?=
 =?us-ascii?Q?NOjs8vFphtc7LEnxK3f8XF9AAM4DxR72KEKH/tARW2qGpengn1vOEv+zlQbQ?=
 =?us-ascii?Q?+nb11p161v7VMaI/ZqsBYeAfDMkzgk449jBr9hgfnd18RaUBrsjGkxwTIn5l?=
 =?us-ascii?Q?a29QTBjjX/JZg0ekaoJ9bG2vLanAgWq3+mwpT9cbVhL2sHV7Tm9DyWTwpGri?=
 =?us-ascii?Q?K0XWElLz+41IYLKjwN3zbOhq0O22exoPya5YT4v1Xm5RYhwhaDVS7e7PhKMW?=
 =?us-ascii?Q?qJwuoEtSHtb6GSd1IFusxYxhREpnrM+U2AOE2H1mjw09U6YjzoEOHu7JiCuR?=
 =?us-ascii?Q?kQ4hm+R2d5cLetmVIk4PujsZfYfusN+jD9dsK87RVJRSEST/ipYKQ1nddmK8?=
 =?us-ascii?Q?zw8zgocFdrEICZYYpfwpKVDcZm6gFqCBsqfLDKhF8+qgvPFq3AeVtQY0HxWS?=
 =?us-ascii?Q?RhPz605Hdbe8cBDfFCCyzE6CClCQDqQl0JeF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:23:25.0552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911a43e-3b8f-4a68-cf8f-08de221891a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
Existing routine has two conversion sequence,
pbn_to_kbps and kbps_to_pbn with margin.
Non of those has without-margin calculation.

kbps_to_pbn with margin conversion includes
fec overhead which has already been included in
pbn_div calculation with 0.994 factor considered.
It is a double counted fec overhead factor that causes
potential bw loss.

[How]
Add without-margin calculation.
Fix fec overhead double counted issue.

Fixes for:
https://gitlab.freedesktop.org/drm/amd/-/issues/3735

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 59 ++++++++-----------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5e92eaa67aa3..dbd1da4d85d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -884,26 +884,28 @@ struct dsc_mst_fairness_params {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
+static uint64_t kbps_to_pbn(int kbps, bool is_peak_pbn)
 {
-	u8 link_coding_cap;
-	uint16_t fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B;
+	uint64_t effective_kbps = (uint64_t)kbps;
 
-	link_coding_cap = dc_link_dp_mst_decide_link_encoding_format(dc_link);
-	if (link_coding_cap == DP_128b_132b_ENCODING)
-		fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B;
+	if (is_peak_pbn) {	// add 0.6% (1006/1000) overhead into effective kbps
+		effective_kbps *= 1006;
+		effective_kbps = div_u64(effective_kbps, 1000);
+	}
 
-	return fec_overhead_multiplier_x1000;
+	return (uint64_t) DIV64_U64_ROUND_UP(effective_kbps * 64, (54 * 8 * 1000));
 }
 
-static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x1000)
+static uint32_t pbn_to_kbps(unsigned int pbn, bool with_margin)
 {
-	u64 peak_kbps = kbps;
+	uint64_t pbn_effective = (uint64_t)pbn;
+
+	if (with_margin)	// deduct 0.6% (994/1000) overhead from effective pbn
+		pbn_effective *= (1000000 / PEAK_FACTOR_X1000);
+	else
+		pbn_effective *= 1000;
 
-	peak_kbps *= 1006;
-	peak_kbps *= fec_overhead_multiplier_x1000;
-	peak_kbps = div_u64(peak_kbps, 1000 * 1000);
-	return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
+	return DIV_U64_ROUND_UP(pbn_effective * 8 * 54, 64);
 }
 
 static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *params,
@@ -974,7 +976,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	dc_dsc_get_default_config_option(param.sink->ctx->dc, &dsc_options);
 	dsc_options.max_target_bpp_limit_override_x16 = drm_connector->display_info.max_dsc_bpp * 16;
 
-	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
+	kbps = pbn_to_kbps(pbn, false);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
@@ -1003,12 +1005,11 @@ static int increase_dsc_bpp(struct drm_atomic_state *state,
 	int link_timeslots_used;
 	int fair_pbn_alloc;
 	int ret = 0;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled) {
 			initial_slack[i] =
-			kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec_overhead_multiplier_x1000) - vars[i + k].pbn;
+			kbps_to_pbn(params[i].bw_range.max_kbps, false) - vars[i + k].pbn;
 			bpp_increased[i] = false;
 			remaining_to_increase += 1;
 		} else {
@@ -1104,7 +1105,6 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	int next_index;
 	int remaining_to_try = 0;
 	int ret;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 	int var_pbn;
 
 	for (i = 0; i < count; i++) {
@@ -1137,7 +1137,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 
 		DRM_DEBUG_DRIVER("MST_DSC index #%d, try no compression\n", next_index);
 		var_pbn = vars[next_index].pbn;
-		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+		vars[next_index].pbn = kbps_to_pbn(params[next_index].bw_range.stream_kbps, true);
 		ret = drm_dp_atomic_find_time_slots(state,
 						    params[next_index].port->mgr,
 						    params[next_index].port,
@@ -1197,7 +1197,6 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int count = 0;
 	int i, k, ret;
 	bool debugfs_overwrite = false;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 	struct drm_connector_state *new_conn_state;
 
 	memset(params, 0, sizeof(params));
@@ -1278,7 +1277,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	DRM_DEBUG_DRIVER("MST_DSC Try no compression\n");
 	for (i = 0; i < count; i++) {
 		vars[i + k].aconnector = params[i].aconnector;
-		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+		vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.stream_kbps, false);
 		vars[i + k].dsc_enabled = false;
 		vars[i + k].bpp_x16 = 0;
 		ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr, params[i].port,
@@ -1300,7 +1299,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	DRM_DEBUG_DRIVER("MST_DSC Try max compression\n");
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps, fec_overhead_multiplier_x1000);
+			vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.min_kbps, false);
 			vars[i + k].dsc_enabled = true;
 			vars[i + k].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1308,7 +1307,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			if (ret < 0)
 				return ret;
 		} else {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+			vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.stream_kbps, false);
 			vars[i + k].dsc_enabled = false;
 			vars[i + k].bpp_x16 = 0;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1763,18 +1762,6 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	return ret;
 }
 
-static uint32_t kbps_from_pbn(unsigned int pbn)
-{
-	uint64_t kbps = (uint64_t)pbn;
-
-	kbps *= (1000000 / PEAK_FACTOR_X1000);
-	kbps *= 8;
-	kbps *= 54;
-	kbps /= 64;
-
-	return (uint32_t)kbps;
-}
-
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 					  struct dc_dsc_bw_range *bw_range)
 {
@@ -1873,7 +1860,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			dc_link_get_highest_encoding_format(stream->link));
 	cur_link_settings = stream->link->verified_link_cap;
 	root_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
-	virtual_channel_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
+	virtual_channel_bw_in_kbps = pbn_to_kbps(aconnector->mst_output_port->full_pbn, true);
 
 	/* pick the end to end bw bottleneck */
 	end_to_end_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
@@ -1926,7 +1913,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 				immediate_upstream_port = aconnector->mst_output_port->parent->port_parent;
 
 			if (immediate_upstream_port) {
-				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
+				virtual_channel_bw_in_kbps = pbn_to_kbps(immediate_upstream_port->full_pbn, true);
 				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
 			} else {
 				/* For topology LCT 1 case - only one mstb*/
-- 
2.43.0

