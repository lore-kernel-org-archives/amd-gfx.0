Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED55D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5132710E4DC;
	Tue,  9 Dec 2025 08:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feOpPSF3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C12410E4DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ2dcKMehEVre0kXWOodjva+2XpG2PDTYOh4LPgFIE9h317TbcB8gH7vgYARKwnMf2LfhsNPGmVefnU1A9aSVxOrDz9AP9RMIvorXmCkBpn01F1eAjOgzYLAeA7klmvoRkzCsO8+9UNPKrjfWKnbxP981VCwMCXbuEq2tRGpGWbKfWXvLV+BvQoFo1gL6EnaMsNuBTK0nyZt5tHBYlsNaBVlobA+A3qVxALjCl7g+6Lc/g7V4Xz/oKRUkoQh7d9vjN2Kguw1ls279zrblPcnX9mGG9DLxgw6JZrX5f2MjksHciJXjUXXibweHjesmpxyKehZnH+THjKjajqSdnEr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LRXeIfd+QkCvdAi3NRw11sXrWq2J4yrHqHmrCDyGto=;
 b=uC2jasYTxrbgYh7d3ghX/xSloqCd0wUzSm39A93ZKVGsHAzz4oEEhuneQGjLpEHWxjy65+Vqc+wVPVEVaB9GKlrIoD3XWp1fMk5yb+RPg9ybturYE72eHLZ+Nq1SWxSc0Z62rmUZrs/nBX3gUG/miaOxvixPwzmZnEzxp1srnfYvhggLNSj1vgq97a7yt6Datc1EeznpYo2DT1f3d0HGRMDqEJbYJJZPIZGnu2KaPgAxEI5rqrtcNhP31YswqFPGqS9OEErdrt3vO2AXnB4apG/RgVhSip0zzUZRH1qqfwSVIIH7hLkMIxY0ZeUHRabO/IxzRGHPTPyEA528WYxcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LRXeIfd+QkCvdAi3NRw11sXrWq2J4yrHqHmrCDyGto=;
 b=feOpPSF3MrSbpKuZ92ln5a7tfoSB0p2dPR+13GYPJxlChi451GVNObE7IUrAwldiJDe5VMWzFdc2J/wi47c3WqsnsIO0hU7LqtAOYSHrJ1f4U0qWTBSo5c29GMYQw1pUTq8vVc4+o1MeDNOs+DTR0NOOVJ0D6jicaQT06zEw/jg=
Received: from BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:29 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::ea) by BYAPR02CA0035.outlook.office365.com
 (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:27 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:24 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 12/15] drm/amd/display: Revert "Fix pbn to kbps Conversion"
Date: Tue, 9 Dec 2025 16:55:15 +0800
Message-ID: <20251209085702.293682-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 21173326-d3fb-4be8-2129-08de37011eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u3SSD+B5MtUsFb62xYSwUKq8o5zI8yE0skvXtDWDIEGJCOcBNUSaGMg88BuQ?=
 =?us-ascii?Q?/Ycf9M3XoxAtW9C8nsH+CJlWJ4Sw1eFB7m383uAP0H4+8tG5xz13U1ubx+g1?=
 =?us-ascii?Q?2sPTn2ctLzyoyL1JTsLjjeIjGbHjDdWCff8AuIi6CnGDZDTVRLvFoxFP1uOn?=
 =?us-ascii?Q?W2p+hEUtc51ri9Cgf83pgwrBPOxwS4LmxwllYaK4ROpY2ucTdLz0sgVbDeph?=
 =?us-ascii?Q?/Vq4iAbYMDhr/GtS2Fp1ztxEETB448vGoegK1G4CklgWvRy4Mn/ZNCjEyvdb?=
 =?us-ascii?Q?9pxTfuiyJbzvI/+n07O8aaZ2np7h3QC0HtOJPJGdQOMj/PcF8ayEJpku6cE1?=
 =?us-ascii?Q?ShQNIZCPeM1catMyPJxKlO2MyuKPQqI30OtIVfFhwB+y8LDVtXD9r2wFtSgE?=
 =?us-ascii?Q?IK7E2Fj8+PyuW/PfU4A0dpQcMYJilkGj0C5BPtDnD+JjN+rdCSxuAeBi5Qg1?=
 =?us-ascii?Q?Js6IjiET8Y1eATxvc1Q+K4Fg8RjTB4lGG/46iyeYYBtMFhL8jlydc+22X3FE?=
 =?us-ascii?Q?aitHOHmMCrMjgMNdWbWpr7B1Re6BV04pg+Jrh3a4WLhn0y244ng+2+u6/C0U?=
 =?us-ascii?Q?EY79IvIimV6OkPyFybGiCKxAPAYBmeSNMBRMDKwpKzDEjpXUnGthw6LiacXi?=
 =?us-ascii?Q?F6sRbO+t2i2tPxGbrji7BCM46H649v6yWF7JUzFF0YsZBCvi36gCYgdRLEyr?=
 =?us-ascii?Q?vmpmK75gbM1/ANM/PXtl/qDS/YHlJ2RjRpnlKmvqhkoTRMmCsY1IHg5jYu0D?=
 =?us-ascii?Q?891W1op3Mn6aE7bEtAGVSl4ckCxPi7rg29iMJM6j/F4rqLuEb01BZAens/HA?=
 =?us-ascii?Q?DJuBdCiEHKrZzpWMiMQDJ3cs++4nJx9atJ5qM7bjlNqyYPfuW/0zBMYFWb2J?=
 =?us-ascii?Q?JFiyTgUcex/TU/DUgpaCzayRTn4iwX9nWsXFewuzcmSFkVxEqLD+X4ssmYyP?=
 =?us-ascii?Q?wqCsZdrouuOVaDnkpMD6eBZGXdlv4O6oP4tFLfzafrkVWftv8SjMf+cibjsn?=
 =?us-ascii?Q?aK8N+fi4T1X43LNUUVLKek6tWzJuwOVvmY3Zh1x2BrdfZvUN+XZOdMR/HIEh?=
 =?us-ascii?Q?qEQkx9+jHLNXlYLBmQHUexOr19+NxRuhLUQEyQqvmRRjcAqv5nyE3tzZEDEf?=
 =?us-ascii?Q?RVyh9YS5jbzwG+OQzyT+5fHmsM6tSk3JQPSHCpAQzpmorzGjk3866R24HGV1?=
 =?us-ascii?Q?KJ34O1wyTTx1YIeN4d906wZhw8ddaAj0iakOVKhdO/OTXXyrZguia888VQVW?=
 =?us-ascii?Q?FBnYOinMIQC4ecScEOEoxoiaYe5TIOA9t2qYvZgvjkcir5VqM95j9nn+CCSv?=
 =?us-ascii?Q?hEi/PCyAu4/b16SBxVUHjQ1maukhMTk0nd9Hd0anHB4/OObLbCW0Qfm5BruV?=
 =?us-ascii?Q?xG4JvXjPSFzxlarsxYPkf071dQmSSYm3zNPjRATPWNwRj6vGGlPhIUqWsdkS?=
 =?us-ascii?Q?kz05xLNciOITxUSwxy5p0AA5osk8yzDm3ugk2zxuFdVgJD3oZQ1IRy3Hzm5E?=
 =?us-ascii?Q?CmuRyJIh6wEU9hQ4cPtwwyPotRhmROkYin69XGJdb3QQ93zn9NiAAq2qxc1C?=
 =?us-ascii?Q?sCRdY8gv6ugngL0stII=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:28.1794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21173326-d3fb-4be8-2129-08de37011eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

From: Alex Hung <alex.hung@amd.com>

This reverts commit d96c6e251830 ("drm/amd/display: Fix pbn to kbps Conversion")

Because it causes a daisy-chained DP/MST displays issue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4756
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 59 +++++++++++--------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index dbd1da4d85d3..5e92eaa67aa3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -884,28 +884,26 @@ struct dsc_mst_fairness_params {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-static uint64_t kbps_to_pbn(int kbps, bool is_peak_pbn)
+static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
 {
-	uint64_t effective_kbps = (uint64_t)kbps;
+	u8 link_coding_cap;
+	uint16_t fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B;
 
-	if (is_peak_pbn) {	// add 0.6% (1006/1000) overhead into effective kbps
-		effective_kbps *= 1006;
-		effective_kbps = div_u64(effective_kbps, 1000);
-	}
+	link_coding_cap = dc_link_dp_mst_decide_link_encoding_format(dc_link);
+	if (link_coding_cap == DP_128b_132b_ENCODING)
+		fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B;
 
-	return (uint64_t) DIV64_U64_ROUND_UP(effective_kbps * 64, (54 * 8 * 1000));
+	return fec_overhead_multiplier_x1000;
 }
 
-static uint32_t pbn_to_kbps(unsigned int pbn, bool with_margin)
+static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x1000)
 {
-	uint64_t pbn_effective = (uint64_t)pbn;
-
-	if (with_margin)	// deduct 0.6% (994/1000) overhead from effective pbn
-		pbn_effective *= (1000000 / PEAK_FACTOR_X1000);
-	else
-		pbn_effective *= 1000;
+	u64 peak_kbps = kbps;
 
-	return DIV_U64_ROUND_UP(pbn_effective * 8 * 54, 64);
+	peak_kbps *= 1006;
+	peak_kbps *= fec_overhead_multiplier_x1000;
+	peak_kbps = div_u64(peak_kbps, 1000 * 1000);
+	return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
 }
 
 static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *params,
@@ -976,7 +974,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	dc_dsc_get_default_config_option(param.sink->ctx->dc, &dsc_options);
 	dsc_options.max_target_bpp_limit_override_x16 = drm_connector->display_info.max_dsc_bpp * 16;
 
-	kbps = pbn_to_kbps(pbn, false);
+	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
@@ -1005,11 +1003,12 @@ static int increase_dsc_bpp(struct drm_atomic_state *state,
 	int link_timeslots_used;
 	int fair_pbn_alloc;
 	int ret = 0;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled) {
 			initial_slack[i] =
-			kbps_to_pbn(params[i].bw_range.max_kbps, false) - vars[i + k].pbn;
+			kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec_overhead_multiplier_x1000) - vars[i + k].pbn;
 			bpp_increased[i] = false;
 			remaining_to_increase += 1;
 		} else {
@@ -1105,6 +1104,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	int next_index;
 	int remaining_to_try = 0;
 	int ret;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 	int var_pbn;
 
 	for (i = 0; i < count; i++) {
@@ -1137,7 +1137,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 
 		DRM_DEBUG_DRIVER("MST_DSC index #%d, try no compression\n", next_index);
 		var_pbn = vars[next_index].pbn;
-		vars[next_index].pbn = kbps_to_pbn(params[next_index].bw_range.stream_kbps, true);
+		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 		ret = drm_dp_atomic_find_time_slots(state,
 						    params[next_index].port->mgr,
 						    params[next_index].port,
@@ -1197,6 +1197,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int count = 0;
 	int i, k, ret;
 	bool debugfs_overwrite = false;
+	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 	struct drm_connector_state *new_conn_state;
 
 	memset(params, 0, sizeof(params));
@@ -1277,7 +1278,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	DRM_DEBUG_DRIVER("MST_DSC Try no compression\n");
 	for (i = 0; i < count; i++) {
 		vars[i + k].aconnector = params[i].aconnector;
-		vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.stream_kbps, false);
+		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 		vars[i + k].dsc_enabled = false;
 		vars[i + k].bpp_x16 = 0;
 		ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr, params[i].port,
@@ -1299,7 +1300,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	DRM_DEBUG_DRIVER("MST_DSC Try max compression\n");
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
-			vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.min_kbps, false);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps, fec_overhead_multiplier_x1000);
 			vars[i + k].dsc_enabled = true;
 			vars[i + k].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1307,7 +1308,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			if (ret < 0)
 				return ret;
 		} else {
-			vars[i + k].pbn = kbps_to_pbn(params[i].bw_range.stream_kbps, false);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
 			vars[i + k].dsc_enabled = false;
 			vars[i + k].bpp_x16 = 0;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1762,6 +1763,18 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	return ret;
 }
 
+static uint32_t kbps_from_pbn(unsigned int pbn)
+{
+	uint64_t kbps = (uint64_t)pbn;
+
+	kbps *= (1000000 / PEAK_FACTOR_X1000);
+	kbps *= 8;
+	kbps *= 54;
+	kbps /= 64;
+
+	return (uint32_t)kbps;
+}
+
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 					  struct dc_dsc_bw_range *bw_range)
 {
@@ -1860,7 +1873,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			dc_link_get_highest_encoding_format(stream->link));
 	cur_link_settings = stream->link->verified_link_cap;
 	root_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
-	virtual_channel_bw_in_kbps = pbn_to_kbps(aconnector->mst_output_port->full_pbn, true);
+	virtual_channel_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
 
 	/* pick the end to end bw bottleneck */
 	end_to_end_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
@@ -1913,7 +1926,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 				immediate_upstream_port = aconnector->mst_output_port->parent->port_parent;
 
 			if (immediate_upstream_port) {
-				virtual_channel_bw_in_kbps = pbn_to_kbps(immediate_upstream_port->full_pbn, true);
+				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
 				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
 			} else {
 				/* For topology LCT 1 case - only one mstb*/
-- 
2.43.0

