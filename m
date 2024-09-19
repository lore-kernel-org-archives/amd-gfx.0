Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A7DCF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8121710E751;
	Thu, 19 Sep 2024 18:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZeAJu6a5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73D610E751
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAzvw5XnB1Cdc9/CB8wv5xrOWIdkat2i0utYBZDjY9IeQ9TdX3N/NzdqshHrq+M2gQVLYU+RatryYnwvG7YZrUVjun4Ok7GF+2SOxwqsMg9GzhwJHH2ZmeIVEJicIqEiIMpFHaAfB9BvySrxC4xhG5NllKPxyd86Jr2Z6ZDA6WnJRPZDnDRLLAvePO/e3jxN/W7kIxzr8g33VERWV1DanLWQflnwbMUDLOiEPsxF2ORd4yqOuzpTKfjNLmZHE3vEqODMx49eLhyegnsJf2H+3UoNJL3FB+rq4x0TrKY0kqgH+Xqj4eh0q2RkspP7EHVvcsH5UVjrmp9mOHT2+eppdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+rOk4DSJF7NiODJ/iqtMtB0wbmCs3li5Q8Nre+zS+o=;
 b=OPO4qafTyu4F82ccjGe9+Pn/8U/O+QUTlspWfAbjsvGOJruXgbn9qOiFr+zsNDJ6V1n53B3XtiySgOIIu5X16O2kilSn046tGiAN4Jodnpt/B2j7vMuLpNG1J6wBkmVp+7drBtpdd0NjRRuWg1XZH/MA5k29nuNXaqO6ysUKCPIHAsp4QlKCRFkZRlJyIM5kmCjcPJ6SVza5H5/hoMjTcwYmGWbfvE0v+IvO/IP9JpsFQhFP7rrg3vI0xJY2P0FXzQOVUl4YcXJPbQQYiI9vesD0RjMK8shSxF/LfVCe74H909g2Fyufi3NvW3SXHULoaeFyyd54IoSYLnYJpRsuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+rOk4DSJF7NiODJ/iqtMtB0wbmCs3li5Q8Nre+zS+o=;
 b=ZeAJu6a5yXPbOAG2aoYXSjyNzerwdb7Nr2fS9qXw5QbEgpuALzZVom2Wo8ZRYSnEi0Q12fhquoOvSG7g84ycwZ0unYHCY32eVa8MTFvQirpMR4tR9Ee5y6bBzeMUmMEkxaPLjb+DvidXYIqvL+OD/fTdlgOv9IUVLkXiECbpJbA=
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:34:38 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::b3) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:36 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/21] DC Patches Sept 16, 2024
Date: Thu, 19 Sep 2024 14:33:18 -0400
Message-ID: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c2ec1d-73b9-4cbd-22e8-08dcd8d9b757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jskqRUUrpvH5lQhpCp7YDsRxiJvOLURJrSIttCf8pKqNirEFUHZsmwPx3YnU?=
 =?us-ascii?Q?TFb52OK4mIYtDxBI9hCkmf3quUpsuUaVlY88RP4E4QvC6EzimI/kFI0fIgS3?=
 =?us-ascii?Q?mbY8w1BxT7s0uekRUDgSaQb+ioxwdDjhVEgv6JvVwdo69BRtxJxeYYwgEFmm?=
 =?us-ascii?Q?LGze3f8Kjzn5sk1budyVv7au8vohYO9yNJPfQXCsXHWFyvpSVxE0uuXfVqP/?=
 =?us-ascii?Q?SBCs45YEJbK80/8fwPC59CRTnNsTG3cSWD7P5yvMn3Nm9KBTZLPjKStO0ouQ?=
 =?us-ascii?Q?o8FiIXT/qYE3TaXS29FE/csp1wl6EvEQ28nuMG/jl2QTRVp9BJpzohBbC21b?=
 =?us-ascii?Q?SVrrzxylRk08msnE/cnKz5rR7npc/q46HhVW7xYfnvJoNypmy232W0Pu0d5V?=
 =?us-ascii?Q?2/rHg/cz/meyxvmZEZf0/6WazuEKzSv/xsmMIEyFnCCTJGqKA3/Mvprfve4K?=
 =?us-ascii?Q?daB0W8ZzWQJd8MoqkVBuDzYuVDt9OoGMtDIs8snesxdFKRpz7iv6iivThRlX?=
 =?us-ascii?Q?JBG12i97xGV2fjG+xTapcg41dnaHgHUyB97Eav3TBI95uYjSp3u+IgV/QuMa?=
 =?us-ascii?Q?myDp+R//Yr2Sa3GDbkWfBIbSe/FHslJvxVctrXzd8voStwFmNWzXbHhGHGAa?=
 =?us-ascii?Q?4hbCiLtUdFUKPPXo27t7/LF1+XhSey0bes6UrSw8uyAGiTT7FmlQvHSPKWs4?=
 =?us-ascii?Q?vVbVrkmHJkPCs0tFDoCl9gHYjs9CsGinybFlxYqNiH3O3c8Z+FYslC4nylFG?=
 =?us-ascii?Q?kwgV+Ai4WiuTh2EOEsagwTLfiX257BDwLEO7WpnuFEATXQ5M00IO2C6j+j3J?=
 =?us-ascii?Q?UN1AvzsMPvRFgkOsg0tVGK+EahyzZDN34/SGmWbG5q9mqbrxg/ObzsQV6Euu?=
 =?us-ascii?Q?CcwQWQo4THG9hW4mFYnWLiqAsF2FVdJ+DZKduYb4IZGlUrhYxAF5ogGbzZ5i?=
 =?us-ascii?Q?96ppOP1EyHI98DBeuB1AIEuLAn/ZeEYwMjz3i4bafZnmEA59VQL2igg9n277?=
 =?us-ascii?Q?XjWjNh4q8QzvL/LAlL2tbPYD1fNnB0eUjRuvJAakX2YMtcvwc9JZ1Bq2nl66?=
 =?us-ascii?Q?DeGlkttx4OtWy5Hut/sumsFQCLu1+eOJ4H8Ew+LmsZXIL1NVZP3KXSJ0emnU?=
 =?us-ascii?Q?7OndWXyoJ54cjJ5wZbwNMr//sOPLDZquTBaS4MmnZpUQRUAgswMI5uNZLBj9?=
 =?us-ascii?Q?IqAy+4FYaYluLHC9sqT2mZ6pizDXDgZ5h8AsvUAINYQ5qkImLRu8VtfjJEZQ?=
 =?us-ascii?Q?7VsFShkPgDJ87lgEXVLXeo7u7lRFoUbNECkR5grYbuRI4ZC2kcPaS4sMCTRD?=
 =?us-ascii?Q?1j1U4/f/Ye70NP7TQRat/90pAO0YNlsxGcVhn8vF9i2OjULA2ojWbqPQJPrh?=
 =?us-ascii?Q?JU5PEEZvjCsuIib0dQj2PQ5RKpj5e4fbcvpn/DPz9P1Isn/8S0/pdwODVzv4?=
 =?us-ascii?Q?SKjejzU55hxchq09RMgrD//E++IXFCP+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:37.4586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2ec1d-73b9-4cbd-22e8-08dcd8d9b757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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

DC 3.2.302 contains some improvements as summarized below:

* Stability fixes in DML, SPL,
* Improvements for MST, DSC, eDP, IPS, HDR
* Fix clock gating on DCN35
* Fixes from static analysis checks
* Other bug fixes and debug improvements
___

Alex Hung (1):
  drm/amd/display: Add HDR workaround for specific eDP

Alvin Lee (1):
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.302

Austin Zheng (3):
  drm/amd/display: Set Pipe Unlock Order Outside of HWSEQ
  drm/amd/display: Update Interface to Check UCLK DPM
  drm/amd/display: Wait For DET Update Should Use Current State

Charlene Liu (2):
  drm/amd/display: avoid set dispclk to 0
  drm/amd/display: correct register Clock Gater incorrectly disabled

Fangzhi Zuo (2):
  drm/amd/display: Restore Optimized pbn Value if Failed to Disable DSC
  drm/amd/display: Fix incorrect DSC recompute trigger

Ilya Bakoulin (1):
  drm/amd/display: Fix cursor visual confirm update

Joshua Aberback (1):
  drm/amd/display: Clip rect size changes should be full updates

Kaitlyn Tse (1):
  drm/amd/display: Implement new backlight_level_params structure

Leo Li (1):
  drm/amd/display: Enable idle workqueue for more IPS modes

Michael Strauss (1):
  drm/amd/display: Block UHBR Based On USB-C PD Cable ID

Samson Tam (2):
  drm/amd/display: disable adaptive scaler and sharpener when integer
    scaling is enabled
  drm/amd/display: fix static analysis warnings

Shunlu Zhang (1):
  drm/amd/display: Change dc_surface_update cm2_params to const

Sung Lee (1):
  drm/amd/display: Clean up triple buffer enablement code

Yihan Zhu (1):
  drm/amd/display: update DML2 policy
    EnhancedPrefetchScheduleAccelerationFinal DCN35

Zhongwei (1):
  drm/amd/display: Monitor patch to call blank_stream() before otg off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   4 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 121 ++++++++++++------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 +++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   1 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |   1 -
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |  10 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |   3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  27 ++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   5 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  41 +++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  13 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |  22 +++-
 .../link/protocols/link_edp_panel_control.c   |   7 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   9 ++
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  45 +++++++
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |  13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |   3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |   9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  16 +--
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   6 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  18 +++
 .../dc/resource/dcn401/dcn401_resource.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  12 ++
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   4 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |  33 +++--
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  32 ++---
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  17 +--
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h |   3 +-
 54 files changed, 456 insertions(+), 190 deletions(-)

-- 
2.46.0

