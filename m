Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107FC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807EE10E6FC;
	Wed, 21 Aug 2024 22:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DHfVChVK";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDFF10E6F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABZt+EDqbEc6kyxzyxb2gHMFRhBExDAn+ersdUye+zDqD0l9RtQjP7+gpSQq2r3Xy6wPYRppjUXt8Lx9qybuI4ohruS18yr0+i/bmB+QpYiWsM0RUNmZEVVOZDPnwpY5inLR7J+GftOwFp+u+xI+si6ODZ/ztgIJ//ePG40w4hVBHAFZl9jOKFHDGrnoRRJxjEbib4/D7wzhK32LTO03uw73b3kSsSTqbtbR2cYqRmYrruzRPU4eQrWWwcqgL34TeKi8tPp968eVo1nMUCulXsTs/QWaTqp/X0SZJSkFSterRYQhvkAAYj7GQxUUXlbM11POsBQqRGtDEEcJBZKH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNq8LCftx/yolwUxna5juPEg0qFmZNEAVzwcut2HTec=;
 b=IRAyYSJVWC5RUPeHNuJmHRSCThqfZmZi8PdhceHNcyG7VkO992xTpR5ONUIw7SgRDgxaiuDqe3riGKhE/YRZOPWCtubx2YuE7EfYNH67L43WAaBcklzPxqac8h+O4HqZLiWCLQDSvkAZTH2lr33r1AyiKnPFieL7tFjLyzSeyguP6jiTIyGt2vVpt4xrCsB2abz4fYSvpBGfPrNeIW+OzTZ+afO/NZFoUovnAB61tJ05HIZ/kS5Xb2NxBgr3mnawYsBNmFOiJ6wxZKkWb+oaL9zUrcneCgTSsymgudD0M+Ea24NvsKg8XVISgiC3f0twOlbckU7CXNnlGibNopH/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNq8LCftx/yolwUxna5juPEg0qFmZNEAVzwcut2HTec=;
 b=DHfVChVKPzxPHLByKKKwZhkR7VaNu/cHEJkDWpcEUQgoS4NyeRUDJqmB57oYWS3Qyb7ERr6LX4ML3ZB8n/fBo1Vn/CnLF3w/AKwKbWlQYXedLFpOz2yOwRaIFi2y3QRdvyj9HKscxf06jwZ41g1IyzZ+9f07QiHprISvdgT7c9A=
Received: from BN8PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:70::18)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 22:02:20 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::20) by BN8PR04CA0005.outlook.office365.com
 (2603:10b6:408:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:02:20 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:02:17 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches August 19, 2024
Date: Wed, 21 Aug 2024 18:01:40 -0400
Message-ID: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 604a6801-13cf-4867-d00e-08dcc22cedcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zUu7L+y9N2k7E2SOiVlZCZ02SXxv6fRC2LNdvx7npS5jvAUXuBNal0jj7HRe?=
 =?us-ascii?Q?wEuANfSCctRStL5DCLUzE0wnmbUPSpfVqkE9TBlY05wgeS5FW/Fl+qoHj1CD?=
 =?us-ascii?Q?OOvtY4vtgobxD/BKImJg0HiYD5p62pC8xJZO8zUqciAfOk+hom6ApiTU+zm/?=
 =?us-ascii?Q?EVQkDvFcYrJPz7SdJuONyHtBWxAIYVjugXyUuPpyutLMN1LXA7Y/QaMssDp1?=
 =?us-ascii?Q?smYdwA4NCBRMwBR58dQaQvRSeSdJNQqAxHOl/pxOrs6tYwiGY5CeJblS9OAl?=
 =?us-ascii?Q?8EU8Ux9k92J/1S5WUFrxGsXuo9hgxp/6NUBKZkiMOBwp+kHbh/GeeP+FOQgz?=
 =?us-ascii?Q?MBQOBmrpyMmt2VycQnSRUE1JTGkRpHYHfi3eRxNgyDLNjRtKWvcSOwIiv/Kc?=
 =?us-ascii?Q?8y5KviQjX7GXMbJhM+BGmgcHAyZqGmUmqbGhOhzoRiKX8wUcxXWEF7JmrRbf?=
 =?us-ascii?Q?lPxKgyyE2izfPQ+N67S7Pf4Ch8nzaZW9o+Rfb/erZhY6kgBiFu06Is5fm/Hx?=
 =?us-ascii?Q?XV7m2okUSTkxA36SJfcUJbPAM//WIffZnkRfJpmhpWv6ISCue3HCZX8aJCJT?=
 =?us-ascii?Q?iUsF0UFG+1PaRfpI1UJ/1JaDdUP95Hnyr2VTUzMnHQTxfDZj9koOnZnYoK+d?=
 =?us-ascii?Q?OOsJ/zojf4fgT4WIDqO3bFGs185xX5FpnWPB/H5AKkta9agPefQmbZ4xhAC1?=
 =?us-ascii?Q?zYsQ7sL/K3tOQhx61LZySpbMjz6cCm4zkcYL0POGLnLR3ReIBNAJkkmWy7EF?=
 =?us-ascii?Q?aYAc634tmUqH2njaA9c/NMSTr1sOEgzhH7M3tlU6vdnYh84qruSXeeAGzEIw?=
 =?us-ascii?Q?tso2KXJDK8rpNp4jA2zKdYxsxUAC2vZlR6lqvC7E8Wl4nFQbc26oPR3WIJWr?=
 =?us-ascii?Q?LZ+VEyPEBVFOfGVIbFzZ+l5jI9woFXYJxQsQJM+o0JY/wE/UqTRC9Q7Qf0OK?=
 =?us-ascii?Q?W5bh5TGpFarsRdA800tYGITVbeI3a7K1j/SFiWzLRl5X1JAB8Kv2cCKSyLqD?=
 =?us-ascii?Q?MQh37pzjbG5fgCXkDncyMNZEGR0/Zm1vTjMJRz1w5vxM0cwRWnRNYqb5B0Pl?=
 =?us-ascii?Q?UjnjuVUoLDUH4Mr2+HxiG9jz7GWNgmHfwIvn7XWCSeklzkSc7gb2RLYnfyEd?=
 =?us-ascii?Q?4UR4GrY1DmKlorGeE1C6PJMRmlRG0ypZM4FbVORrVPbQbSI/HcaYU3v80Hu5?=
 =?us-ascii?Q?h/1rnoH4O85OcB9Sg17Ip16XKXNP4XO769FNAIg008ePwbJzWjbCS62MqG8f?=
 =?us-ascii?Q?Bag9Z4IyODQqpDJFkeNMDKrl66pTfCp5kWJ0hI6ytYKlKI+q+2p9MdzSx7GB?=
 =?us-ascii?Q?Y9pvABMxWxRFi2ubStutY5K2voAfAajGBNouxyqqpErB5uTHfCURcy/OUkiA?=
 =?us-ascii?Q?HMc5kbNE3ukvHt59PeCNzqJ1tljYzbZRaNd0MatgEn+o2qqtcnskabU7/Dya?=
 =?us-ascii?Q?hJpudf43TLvLNheU0TW0f9o3k0xO622K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:02:20.2893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604a6801-13cf-4867-d00e-08dcc22cedcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix MS/MP mismatches in dml21 for dcn401
* Resolved Coverity issues
* Add back quality EASF and ISHARP and dc dependency changes
* Add sharpness support for windowed YUV420 video
* Add improvements for text display and HDR DWM and MPO
* Fix Synaptics Cascaded Panamera DSC Determination
* Allocate DCN35 clock table transfer buffers in GART
* Add Replay Low Refresh Rate parameters in dc type

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: guard write a 0 post_divider value to HW

Alvin Lee (2):
  drm/amd/display: Don't skip clock updates in overclocking
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.298

Aurabindo Pillai (1):
  drm/amd/display: do not set traslate_by_source for DCN401 cursor

ChunTao Tso (1):
  drm/amd/display: Retry Replay residency

Daniel Sa (1):
  drm/amd/display: Resolve Coverity Issues

Dennis Chan (1):
  drm/amd/display: Add Replay Low Refresh Rate parameters in dc type.

Dillon Varone (1):
  drm/amd/display: Fix MS/MP mismatches in dml21 for dcn401

Fangzhi Zuo (2):
  drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
  drm/amd/display: Add DSC Debug Log

Nicholas Kazlauskas (2):
  drm/amd/display: Allocate DCN35 clock table transfer buffers in GART
  drm/amd/display: Notify DMCUB of D0/D3 state

Samson Tam (3):
  drm/amd/display: add back quality EASF and ISHARP and dc dependency
    changes
  drm/amd/display: add improvements for text display and HDR DWM and MPO
  drm/amd/display: add sharpness support for windowed YUV420 video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  133 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   24 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   52 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   19 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   18 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   11 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   68 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    5 +
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    3 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   27 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    9 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   45 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |    3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |    9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   16 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |    6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    5 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1361 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  460 ++++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   35 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   45 +-
 .../drm/amd/display/dc/spl/spl_custom_float.c |  151 ++
 .../drm/amd/display/dc/spl/spl_custom_float.h |   29 +
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   25 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  497 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  525 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   38 +-
 67 files changed, 5210 insertions(+), 1114 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_old.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

-- 
2.34.1

