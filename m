Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC7FCFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E2910E60B;
	Tue,  2 Dec 2025 10:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6uvjbGP";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8435910E60B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ2rEJJEaz1sn8T2qSh0L/vRBJr4udQr9jNqhyth8bV6gv6jx6Kr1vbBGVz4hgiQUbTky1es5wmTFMsm9/hxCeZXsmSMaE9AsHySdQNLIsVpRbhUdG9Psv+zHJQzyKKV9iJbC36T4pec47WsgoHGbIyxFWGVt9vljnm3YkAsyTn7JbK6y82I9qOYnGxMOKYxoTtPOFyqpL3z5WRV2AcKIdxrmcgyy4qWwKE5WokJPkjLn2QmlyS2MeQGPUDXcgRW8VlBwfbqQxmj8QyH3XEgNg3sKKoIcW3M7yLdE9rwNWIaaPd8NXOHa8U8ONh4ML3n7am2XRshFDrTo0GyhUv7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAwm3qPwh4VW17FDIRl5uPsv7jy0p74YkBR+opHzmC8=;
 b=VhLMCx5WSqR7y8U7Wr7KsFwDWuQA6Dm8teXF44wMDqtNJHT+VlkWl7SN4eqau1xJTDjawQBYrn4D1qD4piDDQoGzFT7HvohAmXcBZGb1H3lLxcVNAzMmXxrnnkPhayPlY8Y8mwuXNhz0gqw1tVTVWmuHm2gXZqXlkV/e4EQdQUqYMMQFdOfVmqf0QBmcR/+rHmB1dV1oPaojpEhIA141i1t8MvqOrC50lS4xnb80AsfdgJ1+rU/Z/5B/ln3fmO9i439SX6Xjhsboz7xYXSIVrgfHXLrEz7TZjJYTrCkwIv/uNNxAXqFBkP+9LqYq5XzWe0IScMn4RmEroFzuJCyY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAwm3qPwh4VW17FDIRl5uPsv7jy0p74YkBR+opHzmC8=;
 b=b6uvjbGPG+7xzjR02AT9B6Pqh2wJH/jzCMk9fLbMc2vQtAi/apG07fhyFWlvRA0ec33tf7r/+vyk6Sz2gVwrxToXJh/FEKYo2WmmP5rQckLaU2zsSJosflA5DsFyPnlXa0D3FTpuDdtczbO8ItxNx+gCn+OPo17H82QpNZvjZoA=
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:28:59 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::6d) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 10:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 10:28:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 02:28:54 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:51 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <austin.zheng@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 4/6] drm/amd/display: Refactor dml_core_mode_support to reduce
 stack frame
Date: Tue, 2 Dec 2025 18:21:06 +0800
Message-ID: <20251202102437.3126523-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7b1d49-b08b-4710-6814-08de318d9aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c6JTlqXrCeS/44xGPNkgWCyBCue4KqaXN6EZ9n1EVv87FTfUnNT5iRL6n27F?=
 =?us-ascii?Q?zA9/yE1Y+Lr4/Mx1nc9GLoVGu1PLc302oweXn+LpzyL2GLsch7Tjn3J8j+XL?=
 =?us-ascii?Q?IITqrVsczbvoB2XLf4KJR/lvVp01hmJ7TusWqj5Vffmn5tXkgsJ3yToNs6Gx?=
 =?us-ascii?Q?lhjUB/4XmyQl7sVIhAN7u9309wEshKB+88pee/1KDyIFEfBD5UqmXA6A1iFT?=
 =?us-ascii?Q?hEntlUX/kCuKIGedssHja3KshoxZ/UKzvfFOyWv6riUVDrvRDPl9Ve61CWjr?=
 =?us-ascii?Q?a97QMg91tXFsYax3ED2mGskjs0nl82KbST77HFxTyb4zm8w7Pav18PSgSk20?=
 =?us-ascii?Q?pVDqD1r+0BXHHUEKefjZ148HLUlrQCt/fp+siFi/WRHgb6rDGI6HdtbdVmo+?=
 =?us-ascii?Q?gaWRCW5BlRX8/XPxHRYVlUpt2TQZ/DT/4x8cMM6WYoFlGTcoHankPHLfgEQ+?=
 =?us-ascii?Q?0u9Ps3lvlkD9ssO09nVJAHPrWFI+FaVoATs4Vf3mRspnm6HgI2ZMfRpBeQMr?=
 =?us-ascii?Q?5zGDrFt2+oyFKGaN1DUnRSoz14D/bAxNe5AChDGM0qiGiic5ZCY/ArJjRB5A?=
 =?us-ascii?Q?797/7Rt6/urAjEoK2M1WIe+9HCNg9LQS4zAoWfeRr/ssw7O278d6l5ebZkft?=
 =?us-ascii?Q?mnV+Q51Yfd/DAff1MHjthTjIcQHjz04ieP5K0Ca07RTwxiAYwxYJZedDThRX?=
 =?us-ascii?Q?Ujcbxz9FTymk6cNrMhz/BWduNPnmz/nd1YBgngnOaAvrfIdWXNntcKfeEXOb?=
 =?us-ascii?Q?HdNlkdnf4waGK8kZPBsTb/je57bXRLUY6UhLWQJdcTvr0kOL4v3fryfZZWqv?=
 =?us-ascii?Q?P06OkAy5Z5rLdI0GLxsDGryMnuKw7c/+rxP0jP9iU8+pp3ihrtbI5p6hU9b5?=
 =?us-ascii?Q?KT/elgrkGtdaLLMVYoB1CS41IXCrm0IV+HuMLmBKZ40g4zUx946yy05yYsoA?=
 =?us-ascii?Q?HriJBhYjWfWyjEBhRoUf7yNcQ7BOBFJGS4ZpRisiGCXqcI1oU6ZIsFCWyaQt?=
 =?us-ascii?Q?IHfyNLHZs/sek8uD1q0pwpeoRJiRQ3OexkBvElnChY9UciT3pD/OfHAWZ7yb?=
 =?us-ascii?Q?nAm4N44TnlwJvJ6esATw3PnlhCeQ04uZN9xjCL5lvSONaWisVd3CVx8SakL7?=
 =?us-ascii?Q?uZSc5h+uDMuLR1n5BwHTo90DO94g7kIRAYYOpTu7EcaSJK/Pf0hS0qdaie++?=
 =?us-ascii?Q?9xmFLIaPbf3xqdFz+P7XQwW5E6h71Qid7NpIl+7uBpycShRyNXNffjwkcvCY?=
 =?us-ascii?Q?mxpJlAK4JL9C/GcEn3uUH4u0Ms2nR8UNc1NsdXKOI7BuK1u6fzt6otIc0Mym?=
 =?us-ascii?Q?kQlR0fBsSPlgSs+Vw/DyBo04jFyeqYtVI4Skd21Z4TrpEj1XB41/sSRk4sOu?=
 =?us-ascii?Q?9IYAmynoB6YmDKcq1lwnsfXa9X17z+PBkYbjvNCRTOqBYG+7/D/R47PPM2cb?=
 =?us-ascii?Q?ghCmMEb0W18tCZHHTs9kGWndtwsFZy2PKw8tBHwAXNhUX2+SbQ57DCcLeaTq?=
 =?us-ascii?Q?wxmhMpcMUUfJrZ9rMHgWg4Yim8stKd/JIWF6rMT0EozcXDEUWEAEsdxizLNl?=
 =?us-ascii?Q?R68OyfI6dWhRj3WguOU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:28:58.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7b1d49-b08b-4710-6814-08de318d9aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
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

[WHAT]
When compiling Linux kernel with clang, the following warning / error
messages pops up:

drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml2_0/display_mode_core.c:6853:12:
error: stack frame size (2120) exceeds limit (2056) in
'dml_core_mode_support' [-Werror,-Wframe-larger-than]
 6853 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st
*mode_lib)

[HOW]
Refactoring CalculateVMRowAndSwath_params assignments to a new function
helps reduce the stack frame size in dml_core_mode_support.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++++++--------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index c468f492b876..09303c282495 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -6711,6 +6711,76 @@ static noinline_for_stack void dml_prefetch_check(struct display_mode_lib_st *mo
 	} // for j
 }
 
+static noinline_for_stack void set_vm_row_and_swath_parameters(struct display_mode_lib_st *mode_lib)
+{
+	struct CalculateVMRowAndSwath_params_st *CalculateVMRowAndSwath_params = &mode_lib->scratch.CalculateVMRowAndSwath_params;
+	struct dml_core_mode_support_locals_st *s = &mode_lib->scratch.dml_core_mode_support_locals;
+
+	CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
+	CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
+	CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib->ms.SurfaceSizeInMALL;
+	CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
+	CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
+	CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
+	CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
+	CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
+	CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
+	CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthYThisState;
+	CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthCThisState;
+	CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
+	CalculateVMRowAndSwath_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
+	CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
+	CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
+	CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
+	CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
+	CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
+	CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
+	CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
+	CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
+	CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s->dummy_integer_array[0];
+	CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s->dummy_integer_array[1];
+	CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib->ms.dpte_row_height;
+	CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib->ms.dpte_row_height_chroma;
+	CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s->dummy_integer_array[2]; // VBA_DELTA
+	CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s->dummy_integer_array[3]; // VBA_DELTA
+	CalculateVMRowAndSwath_params->meta_req_width = s->dummy_integer_array[4];
+	CalculateVMRowAndSwath_params->meta_req_width_chroma = s->dummy_integer_array[5];
+	CalculateVMRowAndSwath_params->meta_req_height = s->dummy_integer_array[6];
+	CalculateVMRowAndSwath_params->meta_req_height_chroma = s->dummy_integer_array[7];
+	CalculateVMRowAndSwath_params->meta_row_width = s->dummy_integer_array[8];
+	CalculateVMRowAndSwath_params->meta_row_width_chroma = s->dummy_integer_array[9];
+	CalculateVMRowAndSwath_params->meta_row_height = mode_lib->ms.meta_row_height;
+	CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib->ms.meta_row_height_chroma;
+	CalculateVMRowAndSwath_params->vm_group_bytes = s->dummy_integer_array[10];
+	CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
+	CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s->dummy_integer_array[11];
+	CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s->dummy_integer_array[12];
+	CalculateVMRowAndSwath_params->PTERequestSizeY = s->dummy_integer_array[13];
+	CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s->dummy_integer_array[14];
+	CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s->dummy_integer_array[15];
+	CalculateVMRowAndSwath_params->PTERequestSizeC = s->dummy_integer_array[16];
+	CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s->dummy_integer_array[17];
+	CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s->dummy_integer_array[18];
+	CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s->dummy_integer_array[19];
+	CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s->dummy_integer_array[20];
+	CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesYThisState;
+	CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesCThisState;
+	CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib->ms.PrefillY;
+	CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib->ms.PrefillC;
+	CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib->ms.MaxNumSwY;
+	CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib->ms.MaxNumSwC;
+	CalculateVMRowAndSwath_params->meta_row_bw = mode_lib->ms.meta_row_bandwidth_this_state;
+	CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib->ms.dpte_row_bandwidth_this_state;
+	CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRowThisState;
+	CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
+	CalculateVMRowAndSwath_params->MetaRowByte = mode_lib->ms.MetaRowBytesThisState;
+	CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib->ms.use_one_row_for_frame_this_state;
+	CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = mode_lib->ms.use_one_row_for_frame_flip_this_state;
+	CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s->dummy_boolean_array[0];
+	CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s->dummy_boolean_array[1];
+	CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s->dummy_integer_array[21];
+}
+
 /// @brief The Mode Support function.
 dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 {
@@ -7683,69 +7753,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 			s->SurfParameters[k].SwathHeightC = mode_lib->ms.SwathHeightCThisState[k];
 		}
 
-		CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
-		CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
-		CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib->ms.SurfaceSizeInMALL;
-		CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
-		CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
-		CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
-		CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
-		CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
-		CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
-		CalculateVMRowAndSwath_params->SwathWidthY = mode_lib->ms.SwathWidthYThisState;
-		CalculateVMRowAndSwath_params->SwathWidthC = mode_lib->ms.SwathWidthCThisState;
-		CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib->ms.cache_display_cfg.plane.GPUVMEnable;
-		CalculateVMRowAndSwath_params->HostVMEnable = mode_lib->ms.cache_display_cfg.plane.HostVMEnable;
-		CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
-		CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
-		CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
-		CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib->ms.soc.hostvm_min_page_size_kbytes * 1024;
-		CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
-		CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
-		CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = mode_lib->ms.PTEBufferSizeNotExceededPerState;
-		CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
-		CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s->dummy_integer_array[0];
-		CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s->dummy_integer_array[1];
-		CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib->ms.dpte_row_height;
-		CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib->ms.dpte_row_height_chroma;
-		CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s->dummy_integer_array[2]; // VBA_DELTA
-		CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s->dummy_integer_array[3]; // VBA_DELTA
-		CalculateVMRowAndSwath_params->meta_req_width = s->dummy_integer_array[4];
-		CalculateVMRowAndSwath_params->meta_req_width_chroma = s->dummy_integer_array[5];
-		CalculateVMRowAndSwath_params->meta_req_height = s->dummy_integer_array[6];
-		CalculateVMRowAndSwath_params->meta_req_height_chroma = s->dummy_integer_array[7];
-		CalculateVMRowAndSwath_params->meta_row_width = s->dummy_integer_array[8];
-		CalculateVMRowAndSwath_params->meta_row_width_chroma = s->dummy_integer_array[9];
-		CalculateVMRowAndSwath_params->meta_row_height = mode_lib->ms.meta_row_height;
-		CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib->ms.meta_row_height_chroma;
-		CalculateVMRowAndSwath_params->vm_group_bytes = s->dummy_integer_array[10];
-		CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
-		CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s->dummy_integer_array[11];
-		CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s->dummy_integer_array[12];
-		CalculateVMRowAndSwath_params->PTERequestSizeY = s->dummy_integer_array[13];
-		CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s->dummy_integer_array[14];
-		CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s->dummy_integer_array[15];
-		CalculateVMRowAndSwath_params->PTERequestSizeC = s->dummy_integer_array[16];
-		CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s->dummy_integer_array[17];
-		CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s->dummy_integer_array[18];
-		CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s->dummy_integer_array[19];
-		CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s->dummy_integer_array[20];
-		CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesYThisState;
-		CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesCThisState;
-		CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib->ms.PrefillY;
-		CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib->ms.PrefillC;
-		CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib->ms.MaxNumSwY;
-		CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib->ms.MaxNumSwC;
-		CalculateVMRowAndSwath_params->meta_row_bw = mode_lib->ms.meta_row_bandwidth_this_state;
-		CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib->ms.dpte_row_bandwidth_this_state;
-		CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRowThisState;
-		CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
-		CalculateVMRowAndSwath_params->MetaRowByte = mode_lib->ms.MetaRowBytesThisState;
-		CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib->ms.use_one_row_for_frame_this_state;
-		CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = mode_lib->ms.use_one_row_for_frame_flip_this_state;
-		CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s->dummy_boolean_array[0];
-		CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s->dummy_boolean_array[1];
-		CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s->dummy_integer_array[21];
+		set_vm_row_and_swath_parameters(mode_lib);
 
 		CalculateVMRowAndSwath(&mode_lib->scratch,
 			CalculateVMRowAndSwath_params);
-- 
2.43.0

