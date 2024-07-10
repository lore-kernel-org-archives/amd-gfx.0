Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58443C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934F410E2BA;
	Wed, 10 Jul 2024 19:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="irkJWuI4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D2010E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1v4vSYohZHQEVx9xdO02783aKKIvtxeYMe0zg9Yf16xGnP5QcRU8V3JBjpJV87eBWfmwRP929Ixs5TozxtSqO6mvhuuidhOQ2NjcSVn7fWsrgsT5aMYOF17kxkbVCDAW9sM474QFettLYRG/4SH/JWf9ZtC1Ab3Q8yWMhQQAEscVZZPEsPmaG6MnrgAo9O2UTXz0SArUjoS+VHAWOOSHmvlQVgcpH1ylWPA8GkSpU1KcPp6A5z0fhzQAu9lz61a64XF7v68j4WrgHkEn4ZlbGz+K//8Pn+uHQmAkBLfO2a4RYrt7uu/O8859PheSMqFwebc4L9gZvpmajT2qsu47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoZMvTAdmnquaKcYM8FAHRWvJwLGlcY0iilDGcoAypw=;
 b=OiS/3fZNHxtuL27rYhKavuK1ZDTHIaDmwKzpmiDDB0P8iYlZAbrE/ERRy1L8vYplhLQdkqUPIGiW3s6p7J8JbM3jklH7MSD1836nYMeJIllWTGuCkIb/Zs/LrIT2AuxzkTSvWeA0g3LPWl3rF3hF5VA7IsMLSmBa26qIohPo5WwOA/XZdv6HZFg3HDDR7xd1mhhaUo2z7xpW4F3gWnNXdx8cmQRqqFptPa1jxy3wAL1LJXc8LDtm1rN8Wv8l6m74FTxtXBpM0SnwnV748zrmOpRefyuB9wTyDVzoGw09BFRM+ynB0zvJ7euYmifXT12Piwmjqw5WwnCGMLL1LDod4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoZMvTAdmnquaKcYM8FAHRWvJwLGlcY0iilDGcoAypw=;
 b=irkJWuI4Gkz5P1RhJnKDQo8FBLBaotPtf1maZHfvJ0hJSaLkh+5jKxSe3nH7lUjjh4fRZsI5zTPmZ+P0BXsRcAzg5RFmvB/ioh4jpXh/AB9I6BFoDFQofXjO+Cf4KsKLxaznRdgXTccaQoXzTpX2L2PWpuKp/uRfT0UNEW8xN3c=
Received: from BN1PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:e0::30)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:37:25 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::16) by BN1PR10CA0025.outlook.office365.com
 (2603:10b6:408:e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:22 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:16 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/50] DC Patches July 10th, 2024
Date: Wed, 10 Jul 2024 15:36:17 -0400
Message-ID: <20240710193707.43754-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: bf71fc38-3b0f-4161-41bf-08dca117b909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oI2C8m2m+b4TN0LFlrz0vE/iTQ5B015OEOzhFpEDc9r1jhIm2zcFCjoH27nV?=
 =?us-ascii?Q?tFj11PSI3SaOG+xMV8A6tpmCxycqy9CKpTaf5fXCXhx07BC9SdEyRTE+bTgE?=
 =?us-ascii?Q?byvmUKoxxI4XzCkuVOXf4qtVxSvbVT23Gyb00x9GH8S9gmE4buyAxNxSrSRM?=
 =?us-ascii?Q?01TYfgsKG1t49YY/hUss2N9SPiL20ArM+M7S73LpwSFAy8yckXcztbTCSDDl?=
 =?us-ascii?Q?W7J2UdhkV5djSqqP2qb/tZtTnSUkhJS10z24HFplyheHMaoCo4QwRQOjVTH2?=
 =?us-ascii?Q?Zjgzatpt5DrSGslAM21U1UQb5t31VgTnnCd1+CbXRiEKxYW6n275L4iQnJpd?=
 =?us-ascii?Q?OJRi93rX3clSSCaxDLUDH/xpl78QdNShkYCBG+Tzh80EiM1VZ2eSVi0aAlZC?=
 =?us-ascii?Q?XGkQR/+QxOdu4q2yc8h02Bocyj6V0ww0jSJIpv4PBibIUgD3WI0J8DsFLx16?=
 =?us-ascii?Q?EK4ZdokWVFsmZlTFqj+WBrgC2WfKWWN+edfo/L0wP6py7v8C98TRcvwDupmk?=
 =?us-ascii?Q?Ixux5V9jL4U4xEbw0qR5l7XZZ7NUFgSNANNgPcwjCbQUqQmG04WshAiuuPCP?=
 =?us-ascii?Q?LYia+gISbygZUSBs15eWGEcBCN7WNDy5nTyZoArDIVDA16AyYIpO3hJikPwI?=
 =?us-ascii?Q?wpgwramDVpZEImjPTp1oyXDSx9n1FddGhXyM3Cc1dND8JRvQs359upBc3aIG?=
 =?us-ascii?Q?F+F7atQ9sHs8MysveD3I9thpanfVscMh1OtqSDXBl+dlCEzRf98LMS9PPKKm?=
 =?us-ascii?Q?CpFpz4tezDzIhRtYfXxXtB1p/CK0fIX3CT2PLuBD3l20vl+mkcf/lopK06mq?=
 =?us-ascii?Q?uTXKZQu4REjuwOR6C/1VKanCry9gz/gizPoKs1vk1RJWTNpXyy3f4s7lnmts?=
 =?us-ascii?Q?RyAC4QAqswgBHzWywFcUicQqxDE+t3JAVcPCcuOXPSoU0bPeHcyVTzmSbL5b?=
 =?us-ascii?Q?x521b4GWFuALH2tfFLS8u7x8G8sWCLBvRsHI3JZzaq4+HWp4ywXU/HqXkfXq?=
 =?us-ascii?Q?QfLWhUWfpKBmPlEzbKOlQIAZJkwlOXdWCtEqMJ3RqDfSe8NSxA/P6sJzZkoX?=
 =?us-ascii?Q?oO/sHzZqaTjdwb7xidqDJ/Yvhnv1ASA33TVJYN5szYyBFoVDvUreFPAIP2Fh?=
 =?us-ascii?Q?PlXcTQJvyqbYDqORKQL3gOWfHEI9nCx8oPVH+8yvDf4YI0X08tuBuXrOL2ME?=
 =?us-ascii?Q?RtOLpch2LVQoQMGIlDzJCHfWJ1yJ8wuJckwUS9cXM/UOCGb/Lz4EHrxvwZD/?=
 =?us-ascii?Q?9o6D3eZjjEMCcyIy6Z8QSQp7auN7vHeUFqUl6066EdycTZJ4hoz1ZB+yreym?=
 =?us-ascii?Q?v2QfYkdIYe6OqDmjBY98hTOX8OPkHZQCyqO2Oizr3C2Vc6fpBu0RQN4EdlRq?=
 =?us-ascii?Q?V62Y6fCyGdZYQB9mxpyy5YsvGcpey/RwGAgdet0Xz6fAsbQYH+VWe1MGIsKs?=
 =?us-ascii?Q?l3dfrLlIMq+1qGEkGhNQU/+FE2wWBOHn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:23.7979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71fc38-3b0f-4161-41bf-08dca117b909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

This DC patchset brings improvements in multiple areas.

* FW Release 0.0.225.0
* DML2 fixes
* Re-enable panel replay feature
* Allow display DCC for DCN401
* Refactor DWB, OPP, MPC, MMHUBBUB
* Fix dscclk Programming issue on DCN401

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (11):
  drm/amd/display: Revert "Check HDCP returned status"
  drm/amd/display: Initialize denominators' default to 1
  drm/amd/display: Check null-initialized variables
  drm/amd/display: Check phantom_stream before it is used
  drm/amd/display: Pass non-null to
    dcn20_validate_apply_pipe_split_flags
  drm/amd/display: Check null pointers before using them
  drm/amd/display: Check stream before comparing them
  drm/amd/display: Check link_res->hpo_dp_link_enc before using it
  drm/amd/display: Check null pointers before used
  drm/amd/display: Check null pointers before multiple uses
  drm/amd/display: Increase array size of dummy_boolean

Alvin Lee (5):
  drm/amd/display: Disable HBR audio for DP2 for certain ASICs
  drm/amd/display: Don't consider cursor for no plane case in DML1
  drm/amd/display: When resync fifo ensure to use correct pipe ctx
  drm/amd/display: Disable subvp based on HW cursor requirement
  drm/amd/display: Calculate ODM width using odm slice rect, not recout

Aric Cyr (1):
  drm/amd/display: 3.2.292

Aurabindo Pillai (3):
  drm/amd/display: free bo used for dmub bounding box
  drm/amd/display: Allow display DCC for DCN401
  drm/amd/display: improve logic for addition of modifers

Chaitanya Dhere (1):
  drm/amd/display: DML2.1 resynchronization

Chris Park (1):
  drm/amd/display: Deallocate DML memory if allocation fails

Daniel Sa (1):
  drm/amd/display: Set Cursor Matrix to bypass instead of Input Plane

Dillon Varone (3):
  drm/amd/display: Add blanked streams override to DML2.1
  drm/amd/display: Add P-State Keepout to dcn401 Global Sync
  drm/amd/display: Export additional FAMS2 global configuration options
    from DML

Duncan Ma (1):
  drm/amd/display: Add visual confirm for Idle State

Fudongwang (1):
  drm/amd/display: add dmcub support check

Gabe Teeger (1):
  drm/amd/display: Fix DP-DVI dongle hotplug

Jingwen Zhu (1):
  drm/amd/display: avoid disable otg when dig was disabled

Joshua Aberback (1):
  drm/amd/display: Remove unnecessary DSC power gating for DCN401

Mounika Adhuri (1):
  drm/amd/display: Refactoring MPC

Mudimela (1):
  drm/amd/display: Refactoring DWB related files from dcn30 Files

Nevenko Stupar (1):
  drm/amd/display: Issue with 3 or more mcaches per surface

Relja Vojvodic (1):
  drm/amd/display: Implement bias and scale pre scl

Revalla Hari Krishna (2):
  drm/amd/display: Refactoring OPP
  drm/amd/display: Refactoring MMHUBBUB

Rodrigo Siqueira (1):
  drm/amd/display: Remove unused dml2_core_ip_params struct

Roman Li (1):
  drm/amd/display: Replace assert with error message in
    dp_retrieve_lttpr_cap()

Ryan Seto (1):
  drm/amd/display: Added logging for automated DPM testing

Samson Tam (2):
  drm/amd/display: quality improvements for EASF and ISHARP
  drm/amd/display: remove dc dependencies from SPL library

Sridevi Arvindekar (1):
  drm/amd/display: Add option to allow transition when odm is forced

Sung Joon Kim (2):
  drm/amd/display: Do 1-to-1 mapping between OPP and DSC in DML2
  drm/amd/display: Check stream pointer is initialized before accessing

Tom Chung (3):
  drm/amd/display: Disable replay if VRR capability is false
  drm/amd/display: Fix VRR cannot enable
  drm/amd/display: Re-enable panel replay feature

Wenjing Liu (2):
  drm/amd/display: fix dscclk programming sequence on DCN401
  drm/amd/display: apply vmin optimization even if it doesn't reach vmin
    level

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   74 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   31 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   27 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |    2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   18 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  250 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   22 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  102 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   34 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    7 -
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   48 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    9 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    6 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   32 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    6 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    2 +
 .../dc/dce110/dce110_timing_generator.c       |    1 +
 .../dc/dce110/dce110_timing_generator.h       |    1 +
 .../dc/dce110/dce110_timing_generator_v.c     |    1 +
 .../dc/dce120/dce120_timing_generator.c       |    1 +
 .../display/dc/dce60/dce60_timing_generator.c |    3 +-
 .../display/dc/dce80/dce80_timing_generator.c |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |    2 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |    4 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |    2 +-
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |    9 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    2 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |    2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |    7 +-
 .../amd/display/dc/dml/display_mode_structs.h |    1 +
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    3 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |   45 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |    1 +
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  145 +-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   13 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |    1 -
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    1 -
 .../dml21/inc/dml_top_display_cfg_types.h     |    2 +-
 .../dc/dml2/dml21/inc/dml_top_policy_types.h  |    1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |    6 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    2 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  124 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  189 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |    2 +-
 .../dml21/src/dml2_core/dml2_core_factory.c   |    1 -
 .../dml21/src/dml2_core/dml2_core_factory.h   |    1 -
 .../dml21/src/dml2_core/dml2_core_shared.c    |   44 +-
 .../dml21/src/dml2_core/dml2_core_shared.h    |    1 -
 .../src/dml2_core/dml2_core_shared_types.h    |    8 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    3 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.h   |    1 -
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |    1 -
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.h   |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.h     |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.h   |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c   | 1250 ------------
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.h   |   25 -
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  553 +++---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |    1 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |    1 -
 .../lib_float_math.c                          |    1 -
 .../lib_float_math.h                          |    1 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../src/dml2_top/dml2_top_optimization.h      |    1 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   17 +-
 .../dml2/dml21/src/dml2_top/dml_top_mcache.c  |   23 +-
 .../dml2/dml21/src/dml2_top/dml_top_mcache.h  |    1 -
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |    1 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |    1 -
 .../src/inc/dml2_internal_shared_types.h      |   27 +-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |   27 +-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h  |    3 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |    3 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   14 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  540 +++---
 drivers/gpu/drm/amd/display/dc/dwb/Makefile   |    9 +
 .../dc/{ => dwb}/dcn30/dcn30_cm_common.h      |    0
 .../display/dc/{ => dwb}/dcn30/dcn30_dwb.c    |    0
 .../display/dc/{ => dwb}/dcn30/dcn30_dwb.h    |    0
 .../display/dc/{ => dwb}/dcn30/dcn30_dwb_cm.c |    0
 .../drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c  |    1 -
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    3 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   20 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   13 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   41 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   15 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   19 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 -
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h |    2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |    5 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   13 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |    5 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../display/dc/link/accessories/link_dp_cts.c |    5 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |    5 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |    7 +
 .../drm/amd/display/dc/link/link_detection.c  |    5 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   41 +-
 .../dc/link/protocols/link_dp_capability.c    |    8 +-
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |    9 +
 .../dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.c  |    0
 .../dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.h  |    0
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |   27 +
 .../display/dc/{ => mpc}/dcn10/dcn10_mpc.c    |    0
 .../display/dc/{ => mpc}/dcn10/dcn10_mpc.h    |    0
 .../display/dc/{ => mpc}/dcn20/dcn20_mpc.c    |    0
 .../display/dc/{ => mpc}/dcn20/dcn20_mpc.h    |    0
 .../display/dc/{ => mpc}/dcn30/dcn30_mpc.c    |    2 +-
 .../display/dc/{ => mpc}/dcn30/dcn30_mpc.h    |    0
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |   16 +
 .../display/dc/{ => opp}/dcn10/dcn10_opp.c    |    0
 .../display/dc/{ => opp}/dcn10/dcn10_opp.h    |    0
 .../display/dc/{ => opp}/dcn20/dcn20_opp.c    |    0
 .../display/dc/{ => opp}/dcn20/dcn20_opp.h    |    0
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |    9 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   36 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dce110/dce110_resource.c      |    1 +
 .../dc/resource/dce112/dce112_resource.c      |    5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    3 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    1 +
 .../dc/resource/dcn32/dcn32_resource.c        |    7 +
 .../resource/dcn32/dcn32_resource_helpers.c   |   10 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    1 +
 .../dc/resource/dcn35/dcn35_resource.c        |    1 +
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    3 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1306 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  426 +++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   33 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   51 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   23 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  518 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  546 ++++++
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h |   77 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    4 +
 .../gpu/drm/amd/display/include/fixed31_32.h  |    6 +
 .../display/modules/hdcp/hdcp1_execution.c    |   18 +-
 175 files changed, 6110 insertions(+), 3122 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.h
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_cm_common.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb_cm.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn10/dcn10_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn10/dcn10_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn20/dcn20_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn20/dcn20_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn30/dcn30_mpc.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn30/dcn30_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn10/dcn10_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn10/dcn10_opp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn20/dcn20_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn20/dcn20_opp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h

-- 
2.34.1

