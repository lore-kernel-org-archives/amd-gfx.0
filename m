Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB74EC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E6810E573;
	Mon, 28 Apr 2025 13:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bk9hhFrc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E1510E577
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QenVNSgssqwFiJ7EUmh3vGLZxeNSct21Lzdxhqv5Rf4SY+BNsBakBveh9/Q/0kFre8tAGWI2daCFju3/sKqjvTauyGCSD32BT2Db91XlK4Kt1rt2YfojtMR2hoUNaveokAReBeWijo/rypiJVMM0dIc4h0wMuJ06/IOOhdZMUNrjfrS1dTOnVf2CimbcY3pyDlqcsFeVX3KSBqMa3yjqtHbYJRm57eXjLfMdIKlT714EVimONminRoWZXjbo4lCAXTA/+ik9UAj10KJKtV+6iJPTz8yhhE6PDTpWtzzb83r7/Sl3/a3n2hrdMdRKWlgQd6SX9ORa2fTKA+4oBRe0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrOfZL20u7woW5RzHawdVVikJ28+iLf2Pv1S69KC/8o=;
 b=PLl53Zv5t6K/pRQ+5N8GiXK9EBx3uWEqG5+WWNVoNyhPzz8rKxzfVPFyldXAEFUz1qz1Iv98jXG1JiTtWahLSMqeB47n3nMpL79SfG2uHpzr8TMxKr/slD+6kPP1KTHjaik/xCP0QqPV0QonaHdEt3IftmddI616LazBuVjmsHLBCsXKAu5jyOtF9q9ymV3Shfp9yVtff7pAMVN8YmyagMVEVRuSYHSKkdifxw3i7ivcIv52dht701qW9N6eebuuejLXIS0dFF7lr8QIhAFYLcgezK8LOoo8HDUSa1oARLxPlwMj8RmsF7K2cyUcwpGopLwJajBnnGPPT+MdO5zgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrOfZL20u7woW5RzHawdVVikJ28+iLf2Pv1S69KC/8o=;
 b=Bk9hhFrcU9qgzJ5UgUmmXW4FnitJPVxw+r/ap/gyFYmysOW3qlQEscXWv3SN3oKPZnDP0aGMFoJexmQyWLRAgRgz/HLkCYcGozP6WNqrTyM4dl6WV/g93X+/n70BwlwIif2Rs+pw7Ze+USdhMAGtbQBTbtg42X2nq1papxq/5Ys=
Received: from CH0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:b0::12)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:57:08 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::ff) by CH0PR03CA0007.outlook.office365.com
 (2603:10b6:610:b0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 13:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:02 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:59 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Austin
 Zheng" <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 20/28] drm/amd/display: DML21 Fixes
Date: Mon, 28 Apr 2025 21:50:50 +0800
Message-ID: <20250428135514.20775-21-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 32381c11-97ac-4826-a1f8-08dd865c90bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cvncCGJy//4qmHg7tiZ9YQ/xTro4TBs9QxGf8bOTnMgUI0o54hqW3L0/lHyw?=
 =?us-ascii?Q?d6hR+ghyI+rgcLd9v6ZWzXsRCRAV4tcASChqgr826PoTDdZLFdq0EGjlbWYr?=
 =?us-ascii?Q?hdxYJD91cqFxhraaDdrgc1wf+yS6rp8xed5zTVCrDtTaseJnwjEtYMEUEzw9?=
 =?us-ascii?Q?lFI8yVSuiCWw1shH/ejc/gUqt+xnqnE/EopyRerSJ9Q2OI8q0wY9NTyzxa/p?=
 =?us-ascii?Q?R1M7fBHpF1BxEuXp1c3i2IkvPEPDQLcHSVWKUpFCoKUm8lroRl/HV5FXcHsL?=
 =?us-ascii?Q?4yBnlj2NktQtNUskgd7Je6b9ujjRVmx9Wq2mNvrQHgAHPR7A6JZzBwe7vO2o?=
 =?us-ascii?Q?/qzojD69UfYmctm4R5tAZ8yIubKdZxSI1wa7VYHYCku/aflgfZeJOt9CqhRj?=
 =?us-ascii?Q?15UjQIy6BXktvOuLlqv+Xn+IZXqGqfLhmkzNWqwazE6MDW/AgN39PZM7xqKY?=
 =?us-ascii?Q?pCefJXQf+2Q+g1a/mb8y1WaEVrhn21hw06GRnbj6Z7fbfPDPgx6lyvD2zt8R?=
 =?us-ascii?Q?VqcV6APG9LURTi3blIQZLd2Bmc9xbWUGz7uflokLKLZRr07Kows674SOYHXZ?=
 =?us-ascii?Q?xZlsysahNPTTScIwfRFw5psqEk/mEa7qttZe0YRb27xt1+39P8fnHocloSwE?=
 =?us-ascii?Q?gUP1cD4ttsFiLo7ZEVdRQkfSBaPGNeXPD41oda7nTYKmDslNTfQDfZPOjoSt?=
 =?us-ascii?Q?fhi1vS+bvqIXusu5fKuBUQop3+F+TOd0iJdxrFi/lAgIYD9JaZA+KqQsTVWO?=
 =?us-ascii?Q?3BETZPGY3XM3LWL/yr5RSyyzwARkVBWpCTXzzF8JHaNRHs5InHDwK2YJvnQd?=
 =?us-ascii?Q?2vcW8PmzQEx0zEPOCGX/RIYLCgD3OiEfZUjxLkaUoAcEmyrTdq/VYmW7tAsB?=
 =?us-ascii?Q?z2f8qlfCNgcqD3b2XPpxu1Smp+XAuAdO/A8p5nYK+oR2kiCG5slVlM6gKkOZ?=
 =?us-ascii?Q?YtiXwichCq51TO2+ANw4CglDN+bDMGeeBtudMjsNuVNe23EotD1uYcEsjS4l?=
 =?us-ascii?Q?eHBIyWhMN+ZKlq9fF6M8BtD1xa/pGRYwqZMse69etUPo4vF1pw0UTP/knauc?=
 =?us-ascii?Q?W5SLjp2Zg9LnUyRN8QP4Up2zDOjlgfCy6U9iQNXGaDwesQKKUQ2M0dVPuX70?=
 =?us-ascii?Q?iiYVU5VTN814ay6nKEBm9iGiNR79cMWhhrh7icHEUVLcl+FhUSg6bFi9qKqh?=
 =?us-ascii?Q?zNzURJiaoqG5t8RcTd3wwkxnLVC47lEyf6ntFIi+ZxV7dbEMfinNcqESOljU?=
 =?us-ascii?Q?qdlxg0RFwdIJj5RnXh2LMz7oe4JLPBq3n5tzIy8SSR0uYkh3xJ75w5ztI8si?=
 =?us-ascii?Q?juiK2GTvys4svGu7rkDjkZrpAm0frF4Myt5U9gI/p4c5WiWAUNavjQABA6CX?=
 =?us-ascii?Q?4YbSWdEE8tn4Y4eXQU293DrLXSnHusI33EMV2lQMXdrRMR2rYu2+4P4GKV5O?=
 =?us-ascii?Q?wsm5tN13VuNXPF2KbkSyjqWXcj+Laovgz+4xTaVrEt8oTr1pCROBRTA+GmIL?=
 =?us-ascii?Q?9PI6e0vKAqTis8QwEpznrAxD16XRON6XiuWm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:07.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32381c11-97ac-4826-a1f8-08dd865c90bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

From: Austin Zheng <Austin.Zheng@amd.com>

- Store state related info inside mode_lib.
- Fix bad DCFCLK deep sleep
- Update FAMS structure in DMUB header

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |  1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h | 10 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  7 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 82 ++++++++++++++++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  3 -
 .../src/inc/dml2_internal_shared_types.h      | 10 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 +++-
 8 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
index c047d56527c4..a64ec4dcf11a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top.h
@@ -43,5 +43,4 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
  */
 bool dml2_build_mcache_programming(struct dml2_build_mcache_programming_in_out *in_out);
 
-
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
index 5f0bc42d1d2f..047f47e48ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
@@ -130,6 +130,7 @@ struct dml2_soc_state_table {
 
 struct dml2_soc_vmin_clock_limits {
 	unsigned long dispclk_khz;
+	unsigned long dcfclk_khz;
 };
 
 struct dml2_soc_bb {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 0dbf886d8926..bcb99a155011 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -279,7 +279,10 @@ struct dml2_per_stream_programming {
 	} phantom_stream;
 
 	union dmub_cmd_fams2_config fams2_base_params;
-	union dmub_cmd_fams2_config fams2_sub_params;
+	union {
+		union dmub_cmd_fams2_config fams2_sub_params;
+		union dmub_fams2_stream_static_sub_state_v2 fams2_sub_params_v2;
+	};
 };
 
 //-----------------
@@ -674,9 +677,14 @@ struct dml2_display_cfg_programming {
 		// unlimited # of mcache
 		struct dml2_mcache_surface_allocation non_optimized_mcache_allocation[DML2_MAX_PLANES];
 
+		bool failed_prefetch;
+		bool failed_uclk_pstate;
 		bool failed_mcache_validation;
 		bool failed_dpmm;
 		bool failed_mode_programming;
+		bool failed_mode_programming_dcfclk;
+		bool failed_mode_programming_prefetch;
+		bool failed_mode_programming_flip;
 		bool failed_map_watermarks;
 	} informative;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 6f71b7221384..71789b7783d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7905,6 +7905,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 
 }
 
+
 static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
 {
 	struct dml2_core_internal_display_mode_lib *mode_lib = in_out_params->mode_lib;
@@ -11880,7 +11881,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		}
 
 		//Maximum Bandwidth Used
-		s->TotalWRBandwidth = 0;
+		mode_lib->mp.TotalWRBandwidth = 0;
 		for (k = 0; k < display_cfg->num_streams; ++k) {
 			s->WRBandwidth = 0;
 			if (display_cfg->stream_descriptors[k].writeback.active_writebacks_per_stream > 0) {
@@ -11889,7 +11890,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					(display_cfg->stream_descriptors[k].timing.h_total * display_cfg->stream_descriptors[k].writeback.writeback_stream[0].input_height
 						/ ((double)display_cfg->stream_descriptors[k].timing.pixel_clock_khz / 1000))
 					* (display_cfg->stream_descriptors[k].writeback.writeback_stream[0].pixel_format == dml2_444_32 ? 4.0 : 8.0);
-				s->TotalWRBandwidth = s->TotalWRBandwidth + s->WRBandwidth;
+				mode_lib->mp.TotalWRBandwidth = mode_lib->mp.TotalWRBandwidth + s->WRBandwidth;
 			}
 		}
 
@@ -13243,7 +13244,7 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 		out->informative.misc.DisplayPipeLineDeliveryTimeLumaPrefetch[k] = mode_lib->mp.DisplayPipeLineDeliveryTimeLumaPrefetch[k];
 		out->informative.misc.DisplayPipeLineDeliveryTimeChromaPrefetch[k] = mode_lib->mp.DisplayPipeLineDeliveryTimeChromaPrefetch[k];
 
-		out->informative.misc.WritebackRequiredBandwidth = mode_lib->scratch.dml_core_mode_programming_locals.TotalWRBandwidth / 1000.0;
+		out->informative.misc.WritebackRequiredBandwidth = mode_lib->mp.TotalWRBandwidth / 1000.0;
 		out->informative.misc.WritebackAllowDRAMClockChangeEndPosition[k] = mode_lib->mp.WritebackAllowDRAMClockChangeEndPosition[k];
 		out->informative.misc.WritebackAllowFCLKChangeEndPosition[k] = mode_lib->mp.WritebackAllowFCLKChangeEndPosition[k];
 		out->informative.misc.DSCCLK_calculated[k] = mode_lib->mp.DSCCLK[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index bdee6ad7bc59..5f5b15b478e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -329,6 +329,7 @@ struct dml2_core_internal_mode_support_info {
 	bool temp_read_or_ppt_support;
 
 	struct dml2_core_internal_watermarks watermarks;
+	bool dcfclk_support;
 };
 
 struct dml2_core_internal_mode_support {
@@ -350,9 +351,11 @@ struct dml2_core_internal_mode_support {
 	double SOCCLK; /// <brief Basically just the clock freq at the min (or given) state
 	double DCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
 	double GlobalDPPCLK; /// <brief the Max DPPCLK freq out of all pipes
+	double GlobalDTBCLK; /// <brief the Max DTBCLK freq out of all pipes
 	double uclk_freq_mhz;
 	double dram_bw_mbps;
 	double max_dram_bw_mbps;
+	double min_available_urgent_bandwidth_MBps; /// <brief Minimum guaranteed available urgent return bandwidth in MBps
 
 	double MaxFabricClock; /// <brief Basically just the clock freq at the min (or given) state
 	double MaxDCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
@@ -473,9 +476,19 @@ struct dml2_core_internal_mode_support {
 	bool RequiresDSC[DML2_MAX_PLANES];
 	bool RequiresFEC[DML2_MAX_PLANES];
 	double OutputBpp[DML2_MAX_PLANES];
+	double DesiredOutputBpp[DML2_MAX_PLANES];
+	double PixelClockBackEnd[DML2_MAX_PLANES];
 	unsigned int DSCDelay[DML2_MAX_PLANES];
 	enum dml2_core_internal_output_type OutputType[DML2_MAX_PLANES];
 	enum dml2_core_internal_output_type_rate OutputRate[DML2_MAX_PLANES];
+	bool TotalAvailablePipesSupportNoDSC;
+	bool TotalAvailablePipesSupportDSC;
+	unsigned int NumberOfDPPNoDSC;
+	unsigned int NumberOfDPPDSC;
+	enum dml2_odm_mode ODMModeNoDSC;
+	enum dml2_odm_mode ODMModeDSC;
+	double RequiredDISPCLKPerSurfaceNoDSC;
+	double RequiredDISPCLKPerSurfaceDSC;
 
 	// Bandwidth Related Info
 	double BandwidthAvailableForImmediateFlip;
@@ -538,7 +551,41 @@ struct dml2_core_internal_mode_support {
 	bool mall_comb_mcache_c[DML2_MAX_PLANES];
 	bool lc_comb_mcache[DML2_MAX_PLANES];
 
+	unsigned int vmpg_width_y[DML2_MAX_PLANES];
+	unsigned int vmpg_height_y[DML2_MAX_PLANES];
+	unsigned int vmpg_width_c[DML2_MAX_PLANES];
+	unsigned int vmpg_height_c[DML2_MAX_PLANES];
+
+	unsigned int meta_row_height_luma[DML2_MAX_PLANES];
+	unsigned int meta_row_height_chroma[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_l[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_c[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
+
+	unsigned int pstate_bytes_required_l[DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_c[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_line[DML2_MAX_PLANES];
+
+	unsigned int MaximumVStartup[DML2_MAX_PLANES];
+
+	double HostVMInefficiencyFactor;
+	double HostVMInefficiencyFactorPrefetch;
+
+	unsigned int tdlut_pte_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_frame[DML2_MAX_PLANES];
+	double tdlut_opt_time[DML2_MAX_PLANES];
+	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
+
+	double Tvm_trips_flip[DML2_MAX_PLANES];
+	double Tr0_trips_flip[DML2_MAX_PLANES];
+	double Tvm_trips_flip_rounded[DML2_MAX_PLANES];
+	double Tr0_trips_flip_rounded[DML2_MAX_PLANES];
 
+	unsigned int DSTYAfterScaler[DML2_MAX_PLANES];
+	unsigned int DSTXAfterScaler[DML2_MAX_PLANES];
 };
 
 /// @brief A mega structure that houses various info for model programming step.
@@ -548,6 +595,7 @@ struct dml2_core_internal_mode_program {
 	double FabricClock; /// <brief Basically just the clock freq at the min (or given) state
 	//double DCFCLK; /// <brief Basically just the clock freq at the min (or given) state and max combine setting
 	double dram_bw_mbps;
+	double min_available_urgent_bandwidth_MBps; /// <brief Minimum guaranteed available urgent return bandwidth in MBps
 	double uclk_freq_mhz;
 	unsigned int NoOfDPP[DML2_MAX_PLANES];
 	enum dml2_odm_mode ODMMode[DML2_MAX_PLANES];
@@ -684,6 +732,38 @@ struct dml2_core_internal_mode_program {
 	double TCalc;
 	unsigned int TotImmediateFlipBytes;
 
+	unsigned int MaxTotalDETInKByte;
+	unsigned int NomDETInKByte;
+	unsigned int MinCompressedBufferSizeInKByte;
+	double PixelClockBackEnd[DML2_MAX_PLANES];
+	double OutputBpp[DML2_MAX_PLANES];
+	bool dsc_enable[DML2_MAX_PLANES];
+	unsigned int num_dsc_slices[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_l[DML2_MAX_PLANES];
+	unsigned int meta_row_bytes_per_row_ub_c[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
+	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
+	unsigned int cursor_bytes_per_line[DML2_MAX_PLANES];
+	unsigned int MaxVStartupLines[DML2_MAX_PLANES]; /// <brief more like vblank for the plane's OTG
+	double HostVMInefficiencyFactor;
+	double HostVMInefficiencyFactorPrefetch;
+	unsigned int tdlut_pte_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_groups_per_2row_ub[DML2_MAX_PLANES];
+	double tdlut_opt_time[DML2_MAX_PLANES];
+	double tdlut_drain_time[DML2_MAX_PLANES];
+	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
+	double Tvm_trips_flip[DML2_MAX_PLANES];
+	double Tr0_trips_flip[DML2_MAX_PLANES];
+	double Tvm_trips_flip_rounded[DML2_MAX_PLANES];
+	double Tr0_trips_flip_rounded[DML2_MAX_PLANES];
+	bool immediate_flip_required; // any pipes need immediate flip
+	double SOCCLK; /// <brief Basically just the clock freq at the min (or given) state
+	double TotalWRBandwidth;
+	double max_urgent_latency_us;
+	double df_response_time_us;
+
 	// -------------------
 	// Output
 	// -------------------
@@ -697,6 +777,7 @@ struct dml2_core_internal_mode_program {
 	bool PrefetchModeSupported; // <brief Is the prefetch mode (bandwidth and latency) supported
 	bool ImmediateFlipSupported;
 	bool ImmediateFlipSupportedForPipe[DML2_MAX_PLANES];
+	bool dcfclk_support;
 
 	// Clock
 	double Dcfclk;
@@ -1028,7 +1109,6 @@ struct dml2_core_calcs_mode_programming_locals {
 	double dlg_vblank_start;
 	double LSetup;
 	double blank_lines_remaining;
-	double TotalWRBandwidth;
 	double WRBandwidth;
 	struct dml2_core_internal_DmlPipe myPipe;
 	double PixelClockBackEndFactor;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index f486b090bbfc..22969a533a7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -389,9 +389,6 @@ static bool map_min_clocks_to_dpm(const struct dml2_core_mode_support_result *mo
 	if (result)
 		result = round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.dispclk_khz, &state_table->dispclk);
 
-	if (result)
-		result = round_up_to_next_dpm(&display_cfg->min_clocks.dcn4x.deepsleep_dcfclk_khz, &state_table->dcfclk);
-
 	for (i = 0; i < DML2_MAX_DCN_PIPES; i++) {
 		if (result)
 			result = round_up_to_next_dpm(&display_cfg->plane_programming[i].min_clocks.dcn4x.dppclk_khz, &state_table->dppclk);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index 00688b9f1df4..d52aa82283b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -202,6 +202,8 @@ struct dml2_core_mode_support_result {
 		} active;
 
 		unsigned int dispclk_khz;
+		unsigned int dpprefclk_khz;
+		unsigned int dtbrefclk_khz;
 		unsigned int dcfclk_deepsleep_khz;
 		unsigned int socclk_khz;
 
@@ -446,13 +448,17 @@ struct dml2_core_internal_state_intermediates {
 };
 
 struct dml2_core_mode_support_locals {
-	struct dml2_core_calcs_mode_support_ex mode_support_ex_params;
+	union {
+		struct dml2_core_calcs_mode_support_ex mode_support_ex_params;
+	};
 	struct dml2_display_cfg svp_expanded_display_cfg;
 	struct dml2_calculate_mcache_allocation_in_out calc_mcache_allocation_params;
 };
 
 struct dml2_core_mode_programming_locals {
-	struct dml2_core_calcs_mode_programming_ex mode_programming_ex_params;
+	union {
+		struct dml2_core_calcs_mode_programming_ex mode_programming_ex_params;
+	};
 	struct dml2_display_cfg svp_expanded_display_cfg;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 76e9dcc15466..52dc731fa094 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -104,6 +104,14 @@
  */
 #define DMUB_MAX_FPO_STREAMS 4
 
+/* Define to ensure that the "common" members always appear in the same
+ * order in different structs for back compat purposes
+ */
+#define COMMON_STREAM_STATIC_SUB_STATE \
+    struct dmub_fams2_cmd_legacy_stream_static_state legacy; \
+    struct dmub_fams2_cmd_subvp_stream_static_state subvp; \
+    struct dmub_fams2_cmd_drr_stream_static_state drr;
+
 /* Maximum number of streams on any ASIC. */
 #define DMUB_MAX_STREAMS 6
 
@@ -1998,11 +2006,13 @@ union dmub_fams2_stream_static_sub_state {
 }; //v0
 
 union dmub_fams2_cmd_stream_static_sub_state {
-	struct dmub_fams2_cmd_legacy_stream_static_state legacy;
-	struct dmub_fams2_cmd_subvp_stream_static_state subvp;
-	struct dmub_fams2_cmd_drr_stream_static_state drr;
+	COMMON_STREAM_STATIC_SUB_STATE
 }; //v1
 
+union dmub_fams2_stream_static_sub_state_v2 {
+	COMMON_STREAM_STATIC_SUB_STATE
+}; //v2
+
 struct dmub_fams2_stream_static_state {
 	enum fams2_stream_type type;
 	uint32_t otg_vline_time_ns;
@@ -2068,7 +2078,7 @@ struct dmub_fams2_cmd_stream_static_base_state {
 
 struct dmub_fams2_stream_static_state_v1 {
 	struct dmub_fams2_cmd_stream_static_base_state base;
-	union dmub_fams2_cmd_stream_static_sub_state sub_state;
+	union dmub_fams2_stream_static_sub_state_v2 sub_state;
 }; //v1
 
 /**
-- 
2.43.0

