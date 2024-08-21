Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C474EC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDB410E702;
	Wed, 21 Aug 2024 22:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47/BkCAI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC6710E6FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMhk1WNnehfjLZ15c2cm5nDRg9JhP+fY+aHdXhI6o98sZmMmNW43Thvnv+rsQx5YuIMAI/zk2zfmXVPcKlmWvCwXMRNj9LHFGAx10iXnOmCSje5A3AVjwKiujnIR3z+rUeak5WYMbfqQms6qQGRBPAZhWxRCPke12plwDQU2udtLLpdVB7BGOKoqQEdFbbzUN6lbFhvkWrxei+CuogRSXM4IuAeviCc+DoowR2xJoozeuvsSoyMkA3XVZtqIOB4L5j0qk1ObqO8IYzN71t2TzrMXbRTkdbp/AhyTufuNYZGPymIdwlw8kvbdfUdcuYVsqpBolqnlByILVq8GRF74xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hixErtSbp9C8wJciO0hk5POUDdz6WlZLv6Rj+SF/3Gg=;
 b=e0SDLmBpQ0Kda7ZKPALHIr/eoD3ZMhd4uN67bzrCxlrcVskBYOS9vGj+x0ghVlM/5xWFfLEGmuYwtMz197E0rhNcOx/EcNLKgAcciLJEUGnEQ5h+Et0473YQd8viJlGM/+QH9AvO09NdCjjCSJSpjbeMslrGgERXIXvHtVHG8kqBrbDwmRRhZXSZJLClbcLdw/2D0zSLZsZNrfLiCGD9fQwboEsxndjNqeu6gKJS7JHyKoseLCo1Zy7Ql/dOxbfvH8xz8WAz5Gbrn0wh18zVoGH6yvrbQIceXQKVPRapjxkkWwXiYD9ysk/0gYdAVGS9boLhFJhLCsqOXJymWZ7+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hixErtSbp9C8wJciO0hk5POUDdz6WlZLv6Rj+SF/3Gg=;
 b=47/BkCAIHo/Ux8MVaCE5xzMUzEF25jC6/7DnQPVokhUBmP7LynjmaERTxeKoeEXmGYJo8b4n2ZkEJUf4026Z9pImZwLahfenrp9ojNZ8Mq0D/iI07tanmIO9lZvlyBDUH/qX2K9BAVe7OlCuSICvCQS88FowXvbjEVqXSUYFZQg=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 22:04:38 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::65) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:36 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Sa <Daniel.Sa@amd.com>,
 Nicholas Choi <nicholas.choi@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Resolve Coverity Issues
Date: Wed, 21 Aug 2024 18:01:47 -0400
Message-ID: <20240821220156.1498549-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 389bde8b-88eb-49fd-cab4-08dcc22d4009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FiQwiySXUD9fVie5cMzhOBoVcWU3IrIXdfBLOzPgw35TLlPwpVOv+Qvzr4Yp?=
 =?us-ascii?Q?TIWq716nFQgs2NkeeQHA+xZjZDN513XVoiSxtvLsP3i/pNWM8ngo5wmNqIVb?=
 =?us-ascii?Q?auWpgrls1FLfM1wOz7rIw39Tu//MzVpop3i6EUmDfg/iMHr/556Dwge9N+SI?=
 =?us-ascii?Q?sA1/B7fcv2XZ/8cPP5iA5MQmDJLs2qv+ShWQPLcCUXtVGmSXk/+x3Ux8e9zy?=
 =?us-ascii?Q?eElOFIP78qVpjJ6yBL+T4Dv5JBSxpVWq3p2W7liqdpVMqQ9tmRU/M/ah00oK?=
 =?us-ascii?Q?dGvAZyfxRL4jBvSwcX3do7PiJfg2wRURgozcASkKrZKs0DV9QAbIWAppM2YY?=
 =?us-ascii?Q?7NxL4x5k2jEnx+Zbz/OjiUFgSdkR5xrjbkedFVa1fvdtz7ZwhUxoj4FCdR75?=
 =?us-ascii?Q?6dSWL4oHNCgRRIwVwJpf+0sclsQiFl5juaeqB/CbTRWHfxEx4fIAVyDEM2mS?=
 =?us-ascii?Q?FhdY5HuA+Ugbac8jlYEtZudDerK0aP1/G0re24YptNBasOaSofXBXeoA9+vU?=
 =?us-ascii?Q?IgJfRcc6cpG5lJFnxt1bwkVP3qBGpYGE1/v82iAidH53J0DeuIRxT9Lrnnxk?=
 =?us-ascii?Q?0UPENkBDIvW0F1oCXsI49dWN3OiRYx+/j7BwQehaqvwaA0bNwOjjUpAlHkBB?=
 =?us-ascii?Q?U5F9dJymFWXKinMf5l9LcScjS4sIkKhX5cueMIvj7yziAU13TwgVSFRqHeeh?=
 =?us-ascii?Q?TGWJu3wyIvucuttMVEuABEYBYGk5PWNC5dfoSBiezeYhfFQECCwwdcOEuwLF?=
 =?us-ascii?Q?ldzJY3NB2FyYGbEOHZY1PhhLERW6ZXK/UW2Q2+8hjQkzVZKSOA9NK3Tm4E4G?=
 =?us-ascii?Q?akzwuHdGKPPFRbhdrOcoxwYmbRvjuI7Gros9fsgWqZhbTPr9MI9f/3ZZeZRf?=
 =?us-ascii?Q?nGwedddsmejB8nCEmT+FfKkiKekxI53QXkuCW8/IoYfVqieNaDWSf9z/UG3A?=
 =?us-ascii?Q?UZx67CbzGYwhF/tyMMCfxJct8WANXgJg1iy2Aqy/LThjeJNhDjTAkXrXAApb?=
 =?us-ascii?Q?LYVIC1or2iFOhPaTTpz4691a24znV6CcOHDiq3hD2vk0PX9r9xAbwOElHVOm?=
 =?us-ascii?Q?qFJ8KfdTicUIwoZ01MlO0+/a6MsNMlfe6rhOpeUsCkrfqnlhQNdmxm279/3V?=
 =?us-ascii?Q?POxcgl/hAMWr6p+5roo/BV1ucuU+c3W622yKymkp7lgtfaHfWgC8mx1xtalw?=
 =?us-ascii?Q?0HqtmphXXeWgAb/8kXj2lbYECEN+XpmJ0NR7GjWikBfjB5Q9Q3uq9dNKDAEA?=
 =?us-ascii?Q?pIhKbN6h8iv2Eu5ld2vhveScRtpFLLIXUm252f1SesPdefGlXigT4ewOuy9w?=
 =?us-ascii?Q?jq0i1vJjPqDuYT40oucpFQluyOd3DPPJgSOMUCvEXDI8jqAC4rnjPIgCbj7w?=
 =?us-ascii?Q?Q48fYX1IM1OQVPD1TCVB234v/yeToPQ/P4NzTuR21nsVy0TB0nkvCKBKBuBN?=
 =?us-ascii?Q?XIwQGIinRbEQWunzcFf+EH3a1x8pnkXl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:38.2686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389bde8b-88eb-49fd-cab4-08dcc22d4009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

From: Daniel Sa <Daniel.Sa@amd.com>

[WHY]
Remove coverity issues that were originally ignored.

[HOW]
Ran coverity locally on driver, used output report to find existing
coverity issues, resolved them

Reviewed-by: Nicholas Choi <nicholas.choi@amd.com>
Signed-off-by: Daniel Sa <Daniel.Sa@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 21 ++++++++++++-------
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |  3 +--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  3 ---
 .../src/dml2_top/dml2_top_optimization.c      |  1 -
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 1c773bbb9992..eeb96c455658 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -5,7 +5,6 @@
 #ifndef __DML_TOP_TYPES_H__
 #define __DML_TOP_TYPES_H__
 
-#include "dml_top_types.h"
 #include "dml_top_display_cfg_types.h"
 #include "dml_top_soc_parameter_types.h"
 #include "dml_top_policy_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index b158b2781239..1ef4ca323820 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2085,7 +2085,11 @@ static void CalculateDCCConfiguration(
 	unsigned int full_swath_bytes_vert_wc_l;
 	unsigned int full_swath_bytes_vert_wc_c;
 
-	yuv420 = dml_is_420(SourcePixelFormat);
+	if (dml_is_420(SourcePixelFormat))
+		yuv420 = 1;
+	else
+		yuv420 = 0;
+
 	horz_div_l = 1;
 	horz_div_c = 1;
 	vert_div_l = 1;
@@ -2553,8 +2557,11 @@ static void calculate_mcache_setting(
 		l->luma_time_factor = (double)l->mvmpg_width_c / l->mvmpg_width_l * 2;
 
 	// The algorithm starts with computing a non-integer, avg_mcache_element_size_l/c:
-	l->avg_mcache_element_size_l = l->meta_row_width_l / *p->num_mcaches_l;
-	if (l->is_dual_plane) {
+	if (*p->num_mcaches_l) {
+		l->avg_mcache_element_size_l = l->meta_row_width_l / *p->num_mcaches_l;
+	}
+
+	if (l->is_dual_plane && *p->num_mcaches_c) {
 		l->avg_mcache_element_size_c = l->meta_row_width_c / *p->num_mcaches_c;
 
 		if (!p->imall_enable || (*p->mall_comb_mcache_l == *p->mall_comb_mcache_c)) {
@@ -2683,9 +2690,9 @@ static double dml_get_return_bandwidth_available(
 	double ideal_fabric_bandwidth = fclk_mhz * (double)soc->fabric_datapath_to_dcn_data_return_bytes;
 	double ideal_dram_bandwidth = dram_bw_mbps; //dram_speed_mts * soc->clk_table.dram_config.channel_count * soc->clk_table.dram_config.channel_width_bytes;
 
-	double derate_sdp_factor = 1;
-	double derate_fabric_factor = 1;
-	double derate_dram_factor = 1;
+	double derate_sdp_factor;
+	double derate_fabric_factor;
+	double derate_dram_factor;
 
 	double derate_sdp_bandwidth;
 	double derate_fabric_bandwidth;
@@ -7208,7 +7215,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	mode_lib->ms.support.WritebackLatencySupport = true;
 	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true &&
-			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
+			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024 / ((double)mode_lib->soc.qos_parameters.writeback.base_latency_us))) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 8e68a8094658..a31db5742675 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -497,7 +497,6 @@ bool pmo_dcn3_optimize_dcc_mcache(struct dml2_pmo_optimize_dcc_mcache_in_out *in
 							in_out->cfg_support_info->plane_support_info[i].dpps_used)) {
 							result = false;
 						} else {
-							free_pipes -= planes_on_stream;
 							break;
 						}
 					} else {
@@ -666,7 +665,7 @@ bool pmo_dcn3_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pstate_su
 	struct dml2_pmo_instance *pmo = in_out->instance;
 	unsigned int stream_index;
 	bool success = false;
-	bool reached_end = true;
+	bool reached_end;
 
 	memcpy(in_out->optimized_display_config, in_out->base_display_config, sizeof(struct display_configuation_with_meta));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 30767f330fd4..3bb5eb2e79ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -334,7 +334,6 @@ bool pmo_dcn4_fams2_optimize_dcc_mcache(struct dml2_pmo_optimize_dcc_mcache_in_o
 							in_out->cfg_support_info->plane_support_info[i].dpps_used)) {
 							result = false;
 						} else {
-							free_pipes -= planes_on_stream;
 							break;
 						}
 					} else {
@@ -672,8 +671,6 @@ bool pmo_dcn4_fams2_initialize(struct dml2_pmo_initialize_in_out *in_out)
 			/* populate list */
 			expand_base_strategies(pmo, base_strategy_list_4_display, base_strategy_list_4_display_size, 4);
 			break;
-		default:
-			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.c
index dc8af4dd0410..d0e026d981b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.c
@@ -219,7 +219,6 @@ bool dml2_top_optimization_perform_optimization_phase_1(struct dml2_optimization
 	copy_display_configuration_with_meta(&l->cur_candidate_display_cfg, params->display_config);
 	highest_state = l->cur_candidate_display_cfg.stage1.min_clk_index_for_latency;
 	lowest_state = 0;
-	cur_state = 0;
 
 	while (highest_state > lowest_state) {
 		cur_state = (highest_state + lowest_state) / 2;
-- 
2.34.1

