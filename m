Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC50CD128E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83EA310FE85;
	Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKfiDYFu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2459D10F4F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S83T+0WTiye+iWopIYSaykmn1V/LcQ0WBedyWC18nXBHSHRHeAukq+DbCVSiGklR9OjZEMJOFgvyrGl9hF54J80oiNoDQi5U3XOq4ToIRGeNnu1tGY30hH4kAFQGsUquWzLTSLmWNI0c60TG+AThzv9F7XKqgHL8r4rd9PbkswAM7uyg/IPI6NBGn+I2MQLnJi8tQkan+zR+qPwCIS5wTkBmg4PvTitALRmwpHhTi9rau4d2gZzo9uXL80S73cWKGEsmydJc6lNwfAzOtI6V2eeiIgzKo03wdyrhAh1GVtzj3wYIRERLMSb6oQlDjstMMInKsTalXZNc9dpZApIHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIMCRvZaxdMmMTvLiHbifvu1nYYpGRcHz4Ynv1wUgHY=;
 b=NidShM2GkCw5zRQ3118EcMiw9h8Wn23UBfSZg2TDurDzqI+gUW2pZH3EuKeOh1ITsskBdO+Xb6YpGn62w8HJYGg77P/0v4MRP78CngGCXdHzgC8exKa0BVFJl3GksN10rMVOUb7jzVcJqUejHAGJEOr0nt/w46b8r0CpXKL+Xsn9RTwTLREFfSsSTJpPz2JCKiS//m38g59WvuDaB2LPnOPc3xUqGUHO3uXEb5Pdg9ceqJQm+F9qm6B6iOi6CaYkqHTmP3zESZTsRNWpAExUX4zJ4sSatnO9fN/E1xwaBfrxtOPgYVwSm/hPwJoXLKG4/P6nIS8m3jTHaUVm0FDLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIMCRvZaxdMmMTvLiHbifvu1nYYpGRcHz4Ynv1wUgHY=;
 b=uKfiDYFuzl8J4uVLZP/H2DabVSouwqqzEf11OSSRGCBqq7WsNLkCVc40LOkaJZ8qX2lklcyY+sGDrn7nXRlH6hl6GND88lPfJblJnocLDjyphKVSRc32fKMOOQeOv2IYZQuDs7ii3xK0DKnUQEPF1l3zEvA8HszjrnKq1bEqARI=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:37 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6c) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:35 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>
Subject: [PATCH 08/43] drm/amd/display: FEC overhead should be checked once
 for mst slot nums
Date: Thu, 28 Mar 2024 15:50:12 -0400
Message-ID: <20240328195047.2843715-9-Roman.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 14276b70-dcd6-4433-5c4d-08dc4f607aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZVRhSg/2bW+/vsh1MIRn40OcOM4xC9cPvbRgHj1rGY7JY8Ew8Kow4xvCWPEBWZSYv++NMJXPhtIaQyuIqrzwwGZg/aje6TVgWBt94pEClwBSZSz/e2iWCXfBooDRffODLtY9cd1qECDUvEN75ZSsJ21qkk6Oi+VTf4q5aiankAI+/XruBTZ3CmVMeSx5drNhxQxg5hLZVVaID9dLHkEJz8WGt4Ywx7Xp4sK07IdU6WYf2W47vFaLUcGTkSdsotO5aQMrIEAfESmXr298slGnYbsl2vOZlLgSzxj9Y+7RCV+u6kaHB47TZVWcWtPx9xQqhuttp7osj8wtvKH+XTccHV4sPC530KvG2iRFNbTsjtcMyydv1TjqDcX1XMTbv/nm23EEfc6SLvYQwqdFulxR8WD+GIPklAcC5B/fKyIlkNR2fcv54tezXnIVv9FkrY6NZJSmbZSiw5Fl+Q23Cgro29LoyWRl/UPeaOIVyXmzLZECzR5gu/4Pgv1oJloajLHm4pOYLM8DVf0aA7ZxBG+y/vmUrsSc2dlaqRxPkMpAbFqPnjQ/EkTHLCcN3sqXU3Xl3JjQMuh9ihHRVjC54vqHaEixwSvSuIRpdHatJahtbeIRulK8Xm468FXQr40T9Tb7IC0H7x++NE1O4tCj40nVtN6ak5IXKffJEsRehUDqt7pEMyaYNPOZdfXfJ5wdwC0r5DmuV186TbZ5knz3SyJirvChuvDSaqt7QP2jvXugiiF8OmUsGNAXsK98GUN8hC/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:37.3117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14276b70-dcd6-4433-5c4d-08dc4f607aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] Mst slot nums equals to pbn / pbn_div.

Today, pbn_div refers to dm_mst_get_pbn_divider ->
dc_link_bandwidth_kbps. In dp_link_bandwidth_kbps,
which includes effect of FEC overhead already. As
result, we should not include effect of FEC overhead
again while calculating pbn by kpbs_to_peak_pbn
(stream_kbps).

[How] Include FEC overhead within dp_link_bandwidth_kbps.
Remove FEC overhead from kbps_to_peak_pbn.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 37 +++++--------------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  3 --
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ad3170b72a47..0b03e659fdf3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -791,25 +791,12 @@ struct dsc_mst_fairness_params {
 	struct amdgpu_dm_connector *aconnector;
 };
 
-static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
-{
-	u8 link_coding_cap;
-	uint16_t fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B;
-
-	link_coding_cap = dc_link_dp_mst_decide_link_encoding_format(dc_link);
-	if (link_coding_cap == DP_128b_132b_ENCODING)
-		fec_overhead_multiplier_x1000 = PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B;
-
-	return fec_overhead_multiplier_x1000;
-}
-
-static int kbps_to_peak_pbn(int kbps, uint16_t fec_overhead_multiplier_x1000)
+static int kbps_to_peak_pbn(int kbps)
 {
 	u64 peak_kbps = kbps;
 
 	peak_kbps *= 1006;
-	peak_kbps *= fec_overhead_multiplier_x1000;
-	peak_kbps = div_u64(peak_kbps, 1000 * 1000);
+	peak_kbps = div_u64(peak_kbps, 1000);
 	return (int) DIV64_U64_ROUND_UP(peak_kbps * 64, (54 * 8 * 1000));
 }
 
@@ -910,12 +897,11 @@ static int increase_dsc_bpp(struct drm_atomic_state *state,
 	int link_timeslots_used;
 	int fair_pbn_alloc;
 	int ret = 0;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled) {
 			initial_slack[i] =
-			kbps_to_peak_pbn(params[i].bw_range.max_kbps, fec_overhead_multiplier_x1000) - vars[i + k].pbn;
+			kbps_to_peak_pbn(params[i].bw_range.max_kbps) - vars[i + k].pbn;
 			bpp_increased[i] = false;
 			remaining_to_increase += 1;
 		} else {
@@ -1011,7 +997,6 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 	int next_index;
 	int remaining_to_try = 0;
 	int ret;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	for (i = 0; i < count; i++) {
 		if (vars[i + k].dsc_enabled
@@ -1041,7 +1026,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 		if (next_index == -1)
 			break;
 
-		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps);
 		ret = drm_dp_atomic_find_time_slots(state,
 						    params[next_index].port->mgr,
 						    params[next_index].port,
@@ -1054,7 +1039,8 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 			vars[next_index].dsc_enabled = false;
 			vars[next_index].bpp_x16 = 0;
 		} else {
-			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.max_kbps, fec_overhead_multiplier_x1000);
+			vars[next_index].pbn = kbps_to_peak_pbn(
+				params[next_index].bw_range.max_kbps);
 			ret = drm_dp_atomic_find_time_slots(state,
 							    params[next_index].port->mgr,
 							    params[next_index].port,
@@ -1083,7 +1069,6 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	int count = 0;
 	int i, k, ret;
 	bool debugfs_overwrite = false;
-	uint16_t fec_overhead_multiplier_x1000 = get_fec_overhead_multiplier(dc_link);
 
 	memset(params, 0, sizeof(params));
 
@@ -1148,7 +1133,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	/* Try no compression */
 	for (i = 0; i < count; i++) {
 		vars[i + k].aconnector = params[i].aconnector;
-		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
 		vars[i + k].dsc_enabled = false;
 		vars[i + k].bpp_x16 = 0;
 		ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr, params[i].port,
@@ -1167,7 +1152,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 	/* Try max compression */
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps, fec_overhead_multiplier_x1000);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
 			vars[i + k].dsc_enabled = true;
 			vars[i + k].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1175,7 +1160,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 			if (ret < 0)
 				return ret;
 		} else {
-			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
 			vars[i + k].dsc_enabled = false;
 			vars[i + k].bpp_x16 = 0;
 			ret = drm_dp_atomic_find_time_slots(state, params[i].port->mgr,
@@ -1656,13 +1641,11 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 		 */
 		int pbn_div, slot_num, max_slot_num;
 		enum dc_link_encoding_format link_encoding;
-		uint16_t fec_overhead_multiplier_x1000 =
-			get_fec_overhead_multiplier(stream->link);
 		uint32_t stream_kbps =
 			dc_bandwidth_in_kbps_from_timing(&stream->timing,
 				dc_link_get_highest_encoding_format(stream->link));
 
-		pbn = kbps_to_peak_pbn(stream_kbps, fec_overhead_multiplier_x1000);
+		pbn = kbps_to_peak_pbn(stream_kbps);
 		pbn_div = dm_mst_get_pbn_divider(stream->link);
 		slot_num = DIV_ROUND_UP(pbn, pbn_div);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 37c820ab0fdb..fa84d34b7373 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -46,9 +46,6 @@
 #define SYNAPTICS_CASCADED_HUB_ID  0x5A
 #define IS_SYNAPTICS_CASCADED_PANAMERA(devName, data) ((IS_SYNAPTICS_PANAMERA(devName) && ((int)data[2] == SYNAPTICS_CASCADED_HUB_ID)) ? 1 : 0)
 
-#define PBN_FEC_OVERHEAD_MULTIPLIER_8B_10B	1031
-#define PBN_FEC_OVERHEAD_MULTIPLIER_128B_132B	1000
-
 enum mst_msg_ready_type {
 	NONE_MSG_RDY_EVENT = 0,
 	DOWN_REP_MSG_RDY_EVENT = 1,
-- 
2.34.1

