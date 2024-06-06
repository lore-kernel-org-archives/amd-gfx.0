Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A111DC27C6E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A33310EAF1;
	Thu,  6 Jun 2024 21:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIpPCqBW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999AD10EB06
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+0IGiqAvhegXe8svRHzdWQmodz/2sBeXxhKRI3PQBPUMyjGZF/6mUTQZh3gqMkKq4Yaqc1V1BXHFK35/NsLG2isirGou++DCVbE5UnzaypDMttZjBx1F/CWK9RjQqv3d9GteovdG01B8o7VP70qEr/3b2R0/hLqwMwe+oLj7or4pfGz76MiqCIRfu/UUAyHQni3yyExwNu+MKjsZnVBXtDINkIVXhVHf0lwTmKimB3306q2Jc0cgCqMpLUFsTbERriIKt15DExnxTKO6Zn3SSMXurKbLL5FuUZvGHF7c1BRkOsksWiUVkHi/kui/vCSLXuGnAm6vSMcVrhwgsh3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2ECOOzoTNcwEb8nf7GoB72XcMkShmL6IYnKTKDxNxE=;
 b=eNy4BBoott+sxCt+q4w/Z8siwnnoIrDqvmywfvHyLPVk15B8ZnrDgujpjI+O220pXhpK1jO/vq/TdCxQ4g3uVfu1dkMR1wro5YBokzCrIpp5qfcNNENTcV6N4rwMyLdBkB4o01XDQLx6st8MR99ipEdJmmHTnfKLbWrHpl0gyrF76ywxxz0XF8d4R3x25e8HWKvmLnQKEpicm9TccDEhNcDwmoBkOTZsD/+3iQYzGnuWjH2Sl9WPkA7TGLBjU2FMyc6ajMGeHRTXk34Tnx1NKGAywIv06+p388rqFbNISI0I+vBde2AWQdTjhq8droeRodPVncWUzkgN7h3qs1MmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2ECOOzoTNcwEb8nf7GoB72XcMkShmL6IYnKTKDxNxE=;
 b=fIpPCqBWC/Cr+uAz+P5iLn6TxCKv6iQ+rIJzYoYN9DXX7dJsbOjOQhcfBcXlUMn7lAKGcBr06ZSy8u/bLcdZHZdb2U3vFOEsSXaprONGl3H6GYslJzfnFGF0kgjlhFameTN61G4KkYprMxuFaoVdCPEPiX209W/94ptYvsqc7Ko=
Received: from MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:57:53 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::85) by MN2PR15CA0037.outlook.office365.com
 (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 38/67] drm/amd/display: Refactor function
 dm_dp_mst_is_port_support_mode()
Date: Thu, 6 Jun 2024 17:56:03 -0400
Message-ID: <20240606215632.4061204-39-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6524e4-7fdb-4fdf-d3a8-08dc8673b73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6jiqYnBmd6SVJFd7DKJbirwXFoNRSznj+3a9E1BNX3OZX+JA6hS7aQLCGhJV?=
 =?us-ascii?Q?Gq5OhA1kIr4a3CDV4q7vgbKEgCc22xl0+LcR1xt2rC+UNXCXD9qpZY7nx7x8?=
 =?us-ascii?Q?oMyZ2s8LigK8+mnPtWhY1YHufGFoKtEBoDZh15S0Fn12MfC/CG4BSDu3KB31?=
 =?us-ascii?Q?6ekwon5LU3Uo2c5I6pUXD6ulktBRR+3p2SC1kFfemiG5kwmfceE+zhMwHDc0?=
 =?us-ascii?Q?quQVYyRF4oqXLtfrHnuLwQl7p5ojrWIYeWI4FNikm3APu9gP/HrJrQeBw4P+?=
 =?us-ascii?Q?hbRMnSipAfe38uP/tyxxG9bqo4QYTzhXrq7hUcRbNOTEYb1Ls0pyw9ZSjyOd?=
 =?us-ascii?Q?qbC6yM1IWntFBbGGdlD6OTmZDpGHyu0rYeKsIdsBGcXL/iLanP2qwv30XGfU?=
 =?us-ascii?Q?6lZURimbjCiRAmLthY3PmYifaGtxUo7a26pHakOzlgztSfF/lt+7oqIoVUo2?=
 =?us-ascii?Q?3voR0f56zpLT8r7lSx1B2Ys2SvX6SawnStCpZzpdXsB+b5up6Yqrjo7aevxG?=
 =?us-ascii?Q?pW407mY6yR/hheR+kCqX6qM0vNX5WVpzY4Vq9TcGcOnewkGx1dKWklVNpdA8?=
 =?us-ascii?Q?/N73D71q5HemaYhEemEhawZkxJ7esfQNy4qIftUn87V3WrznbiBZnBD2QkLj?=
 =?us-ascii?Q?Eja6K/8CdLuMDlkR3qp6pTVZapm5l2rhKxOooc6noTyuy+TVN0l9MRPJRJCq?=
 =?us-ascii?Q?YQ97yN+Vut3A/GhILK+uC3kCKkf6pz0Ih7Kgughnetq70w81SmHx+O3BwLqZ?=
 =?us-ascii?Q?lnjdApePgFv4whcYsD1ZoWNUV58EvuaSI/2BTPqZprJkXmmKxvHpm3KjyX8U?=
 =?us-ascii?Q?gP3hTS/qNYVABKEK0I7qo9ERL0N+bdWSmj8u4j00l0c7IteCrlQwEJlemItg?=
 =?us-ascii?Q?kIMIGuzSTbZas3BHK8sJrpDJSyYjzKBkf2VX6Cb4IgxjOuV0mZe0TDgwh0ZV?=
 =?us-ascii?Q?cMihiIW8UvG0VOgI/uDVVkYz2KI1YI4sD6dwkbT4YD0ME4XLX0FgpoUQL0n7?=
 =?us-ascii?Q?+HwxNtC4lpWvZlNNCoWf14TsJUfzRLnV2hWuxjvyIsk7tnfDQw8xjX2Kv2Cj?=
 =?us-ascii?Q?koou/PsXcqWT2B0YftfzW3L1xONgZ1DpcP6oX7YPZIV0E0XnMisOwoTJWX9b?=
 =?us-ascii?Q?I5gzCRIgvi/shXJ+x/J8PncX8diFRBNB9nsJc9j2VZz3acLXR4pCcDK6ZUTd?=
 =?us-ascii?Q?12yPIfwfZGnpmDd6Az0nBgyBjSNmtjvJOIzBZ697CR3Cnx/l4YbhYzC4KZzm?=
 =?us-ascii?Q?3XWukQ8+JW/86b1IahhyUfG+Kyp0oiSoI4wmCRl4iECuapvCVzZPZ+iQ2ZFe?=
 =?us-ascii?Q?zduzvmnrkjVbezi5TUjP/BeI7VIv/Gb2HXVc3DDm/Bmud+dwu0mobZ/LN3YL?=
 =?us-ascii?Q?F/v185Et+NR1oIAHTSg2ARm2cGTuwW4AWyu+8Miamothow4/kA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:53.2720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6524e4-7fdb-4fdf-d3a8-08dc8673b73c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

From: Wayne Lin <wayne.lin@amd.com>

[Why]
dm_dp_mst_is_port_support_mode() is a bit not following the original design rule and cause
light up issue with multiple 4k monitors after mst dsc hub.

[How]
Refactor function dm_dp_mst_is_port_support_mode() a bit to solve the light up issue.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 236 +++++++++++-------
 1 file changed, 148 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f60d55c17fb4..0edaae30900f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1597,111 +1597,171 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 }
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_FP)
+static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
+{
+	uint32_t total_data_bw_efficiency_x10000 = 0;
+	uint32_t link_rate_per_lane_kbps = 0;
+	enum dc_link_rate link_rate;
+	union lane_count_set lane_count;
+	u8 dp_link_encoding;
+	u8 link_bw_set = 0;
+
+	*cur_link_bw = 0;
+
+	if (drm_dp_dpcd_read(aux, DP_MAIN_LINK_CHANNEL_CODING_SET, &dp_link_encoding, 1) != 1 ||
+		drm_dp_dpcd_read(aux, DP_LANE_COUNT_SET, &lane_count.raw, 1) != 1 ||
+		drm_dp_dpcd_read(aux, DP_LINK_BW_SET, &link_bw_set, 1) != 1)
+		return false;
+
+	switch (dp_link_encoding) {
+	case DP_8b_10b_ENCODING:
+		link_rate = link_bw_set;
+		link_rate_per_lane_kbps = link_rate * LINK_RATE_REF_FREQ_IN_KHZ * BITS_PER_DP_BYTE;
+		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_8b_10b_x10000;
+		total_data_bw_efficiency_x10000 /= 100;
+		total_data_bw_efficiency_x10000 *= DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100;
+		break;
+	case DP_128b_132b_ENCODING:
+		switch (link_bw_set) {
+		case DP_LINK_BW_10:
+			link_rate = LINK_RATE_UHBR10;
+			break;
+		case DP_LINK_BW_13_5:
+			link_rate = LINK_RATE_UHBR13_5;
+			break;
+		case DP_LINK_BW_20:
+			link_rate = LINK_RATE_UHBR20;
+			break;
+		default:
+			return false;
+		}
+
+		link_rate_per_lane_kbps = link_rate * 10000;
+		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_128b_132b_x10000;
+		break;
+	default:
+		return false;
+	}
+
+	*cur_link_bw = link_rate_per_lane_kbps * lane_count.bits.LANE_COUNT_SET / 10000 * total_data_bw_efficiency_x10000;
+	return true;
+}
+#endif
+
 enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream)
 {
-	int branch_max_throughput_mps = 0;
 #if defined(CONFIG_DRM_AMD_DC_FP)
+	int branch_max_throughput_mps = 0;
 	struct dc_link_settings cur_link_settings;
-	int pbn;
-	unsigned int end_to_end_bw_in_kbps = 0;
-	unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
+	uint32_t end_to_end_bw_in_kbps = 0;
+	uint32_t root_link_bw_in_kbps = 0;
+	uint32_t virtual_channel_bw_in_kbps = 0;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config_options dsc_options = {0};
+	uint32_t stream_kbps;
 
-	/*
-	 * Consider the case with the depth of the mst topology tree is equal or less than 2
-	 * A. When dsc bitstream can be transmitted along the entire path
-	 *    1. dsc is possible between source and branch/leaf device (common dsc params is possible), AND
-	 *    2. dsc passthrough supported at MST branch, or
-	 *    3. dsc decoding supported at leaf MST device
-	 *    Use maximum dsc compression as bw constraint
-	 * B. When dsc bitstream cannot be transmitted along the entire path
-	 *    Use native bw as bw constraint
+	/* DSC unnecessary case
+	 * Check if timing could be supported within end-to-end BW
 	 */
-	if (is_dsc_common_config_possible(stream, &bw_range) &&
-	   (aconnector->mst_output_port->passthrough_aux ||
-	    aconnector->dsc_aux == &aconnector->mst_output_port->aux)) {
-		cur_link_settings = stream->link->verified_link_cap;
-		upper_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
-		down_link_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
-
-		/* pick the end to end bw bottleneck */
-		end_to_end_bw_in_kbps = min(upper_link_bw_in_kbps, down_link_bw_in_kbps);
-
-		if (end_to_end_bw_in_kbps < bw_range.min_kbps) {
-			DRM_DEBUG_DRIVER("maximum dsc compression cannot fit into end-to-end bandwidth\n");
-			return DC_FAIL_BANDWIDTH_VALIDATE;
-		}
+	stream_kbps =
+		dc_bandwidth_in_kbps_from_timing(&stream->timing,
+			dc_link_get_highest_encoding_format(stream->link));
+	cur_link_settings = stream->link->verified_link_cap;
+	root_link_bw_in_kbps = dc_link_bandwidth_kbps(aconnector->dc_link, &cur_link_settings);
+	virtual_channel_bw_in_kbps = kbps_from_pbn(aconnector->mst_output_port->full_pbn);
+
+	/* pick the end to end bw bottleneck */
+	end_to_end_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
+
+	if (stream_kbps <= end_to_end_bw_in_kbps) {
+		DRM_DEBUG_DRIVER("No DSC needed. End-to-end bw sufficient.");
+		return DC_OK;
+	}
 
-		if (end_to_end_bw_in_kbps < bw_range.stream_kbps) {
-			dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
-			dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
-			if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
-					&stream->sink->dsc_caps.dsc_dec_caps,
-					&dsc_options,
-					end_to_end_bw_in_kbps,
-					&stream->timing,
-					dc_link_get_highest_encoding_format(stream->link),
-					&stream->timing.dsc_cfg)) {
-				stream->timing.flags.DSC = 1;
-				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc and dsc config found\n");
-			} else {
-				DRM_DEBUG_DRIVER("end-to-end bandwidth require dsc but dsc config not found\n");
-				return DC_FAIL_BANDWIDTH_VALIDATE;
+	/*DSC necessary case*/
+	if (!aconnector->dsc_aux)
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
+	if (is_dsc_common_config_possible(stream, &bw_range)) {
+
+		/*capable of dsc passthough. dsc bitstream along the entire path*/
+		if (aconnector->mst_output_port->passthrough_aux) {
+			if (bw_range.min_kbps > end_to_end_bw_in_kbps) {
+				DRM_DEBUG_DRIVER("DSC passthrough. Max dsc compression can't fit into end-to-end bw\n");
+ 			return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
-		}
-	} else {
-		/* Check if mode could be supported within max slot
-		 * number of current mst link and full_pbn of mst links.
-		 */
-		int pbn_div, slot_num, max_slot_num;
-		enum dc_link_encoding_format link_encoding;
-		uint32_t stream_kbps =
-			dc_bandwidth_in_kbps_from_timing(&stream->timing,
-				dc_link_get_highest_encoding_format(stream->link));
-
-		pbn = kbps_to_peak_pbn(stream_kbps);
-		pbn_div = dm_mst_get_pbn_divider(stream->link);
-		slot_num = DIV_ROUND_UP(pbn, pbn_div);
-
-		link_encoding = dc_link_get_highest_encoding_format(stream->link);
-		if (link_encoding == DC_LINK_ENCODING_DP_8b_10b)
-			max_slot_num = 63;
-		else if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
-			max_slot_num = 64;
-		else {
-			DRM_DEBUG_DRIVER("Invalid link encoding format\n");
+		} else {
+			/*dsc bitstream decoded at the dp last link*/
+			struct drm_dp_mst_port *immediate_upstream_port = NULL;
+			uint32_t end_link_bw = 0;
+
+			/*Get last DP link BW capability*/
+			if (dp_get_link_current_set_bw(&aconnector->mst_output_port->aux, &end_link_bw)) {
+				if (stream_kbps > end_link_bw) {
+					DRM_DEBUG_DRIVER("DSC decode at last link. Mode required bw can't fit into available bw\n");
+					return DC_FAIL_BANDWIDTH_VALIDATE;
+				}
+			}
+
+			/*Get virtual channel bandwidth between source and the link before the last link*/
+			if (aconnector->mst_output_port->parent->port_parent)
+				immediate_upstream_port = aconnector->mst_output_port->parent->port_parent;
+
+			if (immediate_upstream_port) {
+				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
+				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
+				if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
+					DRM_DEBUG_DRIVER("DSC decode at last link. Max dsc compression can't fit into MST available bw\n");
+					return DC_FAIL_BANDWIDTH_VALIDATE;
+				}
+			}
+	 	}
+
+		/*Confirm if we can obtain dsc config*/
+		dc_dsc_get_default_config_option(stream->link->dc, &dsc_options);
+		dsc_options.max_target_bpp_limit_override_x16 = aconnector->base.display_info.max_dsc_bpp * 16;
+		if (dc_dsc_compute_config(stream->sink->ctx->dc->res_pool->dscs[0],
+				&stream->sink->dsc_caps.dsc_dec_caps,
+				&dsc_options,
+				end_to_end_bw_in_kbps,
+				&stream->timing,
+				dc_link_get_highest_encoding_format(stream->link),
+				&stream->timing.dsc_cfg)) {
+			stream->timing.flags.DSC = 1;
+			DRM_DEBUG_DRIVER("Require dsc and dsc config found\n");
+		} else {
+			DRM_DEBUG_DRIVER("Require dsc but can't find appropriate dsc config\n");
 			return DC_FAIL_BANDWIDTH_VALIDATE;
 		}
 
-		if (slot_num > max_slot_num ||
-			pbn > aconnector->mst_output_port->full_pbn) {
-			DRM_DEBUG_DRIVER("Mode can not be supported within mst links!");
-			return DC_FAIL_BANDWIDTH_VALIDATE;
+		/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
+		switch (stream->timing.pixel_encoding) {
+		case PIXEL_ENCODING_RGB:
+		case PIXEL_ENCODING_YCBCR444:
+			branch_max_throughput_mps =
+				aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps;
+			break;
+		case PIXEL_ENCODING_YCBCR422:
+		case PIXEL_ENCODING_YCBCR420:
+			branch_max_throughput_mps =
+				aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_1_mps;
+			break;
+		default:
+			break;
 		}
-	}
-	/* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
-	switch (stream->timing.pixel_encoding) {
-	case PIXEL_ENCODING_RGB:
-	case PIXEL_ENCODING_YCBCR444:
-		branch_max_throughput_mps =
-			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps;
-		break;
-	case PIXEL_ENCODING_YCBCR422:
-	case PIXEL_ENCODING_YCBCR420:
-		branch_max_throughput_mps =
-			aconnector->dc_sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_1_mps;
-		break;
-	default:
-		break;
-	}
-#endif
 
-	if (branch_max_throughput_mps != 0 &&
-		((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000))
+		if (branch_max_throughput_mps != 0 &&
+			((stream->timing.pix_clk_100hz / 10) >  branch_max_throughput_mps * 1000)) {
+			DRM_DEBUG_DRIVER("DSC is required but max throughput mps fails");
+ 		return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
+	} else {
+		DRM_DEBUG_DRIVER("DSC is required but can't find common dsc config.");
 		return DC_FAIL_BANDWIDTH_VALIDATE;
-
+	}
+#endif
 	return DC_OK;
 }
-- 
2.34.1

