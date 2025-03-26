Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D0EC36011
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9274E10E735;
	Wed, 26 Mar 2025 19:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jtDNOK28";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2286510E03D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc/HDgfkDfDzTVl6JkaeLI4vl9pJOtMNuZm3J57++/V3cAeSAGan9+xemqsHQVm1COBbOjofoy1SrO+NwHsGwod8xLJeCROsOhJANS9E+wmWmjYfdU6VUF4anwj6e1SinUfvy4iZuNkpVxfFCcNn8tgA9h17AyEPQyXSzialqbn9GpLptrQmQgaLDfknONI/vZ0T8E0R+QrYv+GUhUMmeCRsQ338kJhapPXbvrMmBYzVl8VZwahofCXr3Fs3P4YlTwDtI2XXZ0Fc7zHfy7ZMm40jpWzUAzrzielcu1TkVBK/erwMO9Jk/msdS/35Qg73Y9Ohp66Y8NadAom+NFfS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnByaz96J+HmuoqlAA/Soz5DpBlZgj1W/cWIO18VC4A=;
 b=QAC+gNiDCfsalYAklDajACOb7UWVxUsBcgG7wthP/JxkG8myCIBqQEgRHaULCW86xfJIEBISJIVNkmV0sgNkJEstdWut5I2HcMig96ay93oT6L+tR5jXuiMKjLQ6Itk/k5K/D6ilrh4M2BQAwWX1HFu6rU5dWrMdfAk1cNo/ztgLBQNhOZufBUO5WiMqTO1Sj6YdWUQXwgG/ZCqxCxP4zhdLhrzpT08uCLdUYdit1CfPQ2sDAhIxiD3FKs7EBwRctsFTyTMQShMNn1omMfkhAR9GXj0RjUo5/5gfHORRaJ3/RXVZZl0JrMBb0bFQJ2FtzzYJSNs4s7D13RCYX7KD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnByaz96J+HmuoqlAA/Soz5DpBlZgj1W/cWIO18VC4A=;
 b=jtDNOK28x3PP4YnQD3VNHO1EMN2cDQ9SAAL/tsZxshsfTnBxCIgTOwtNDUznXpjKUX9HadRKkzbwaTfYCMslt0vy/NVgCLW9fapKZpEbT7vNsgWxM3Em5/K38uZ7q6gCrPzMj037rlKVNabeHYoUzubpad5gAleKY1y+F+5poxk=
Received: from PH0PR07CA0089.namprd07.prod.outlook.com (2603:10b6:510:f::34)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:09 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::ec) by PH0PR07CA0089.outlook.office365.com
 (2603:10b6:510:f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:07 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:01 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 00/17] DC Patches Mar 24, 2024
Date: Wed, 26 Mar 2025 15:48:57 -0400
Message-ID: <20250326195202.17343-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 81edd608-7457-4629-0404-08dd6c9fd4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r+3JNBk2ez7SLR8eJQAJ5xddQcoezCfrUWsjnQw+D8RijriR0KYXx+2iqTKn?=
 =?us-ascii?Q?P7gwkf+wqQKATXfhLr4n8UZ6Fb4OpTgiGK39GWepNyMQvGDKEwu2kNd4uAwC?=
 =?us-ascii?Q?iQweg1KCs9XmnfvJmX0l7syHfX5kHkuKbzpOfgaMLd25FmH1uJ++04ukjJTE?=
 =?us-ascii?Q?bnsLarX+WuQM6gxJfkGFh302418/ccYYq0DWA/dWypoaFK2CIS+KQ9X92kSB?=
 =?us-ascii?Q?8OjuN18O5YWGoMPqCZtatQUEivyoY7XYegnYDzEy+1XpfCey8V+1ksJt64AY?=
 =?us-ascii?Q?2RYyvC0QKabJlAaQdqn7++nzbYYDIU8kkRWQfXxAqm8dvvxyciVf1odM7SmL?=
 =?us-ascii?Q?rmlprS5RsnzmQyD7DkOem2POwHtag2xp5aPvS9aORrOZV0pDUzb1L34evFIM?=
 =?us-ascii?Q?L2mUDsKO4DvyEVIHVJPjf7fdynkp/WUhvyZmMj9hiITm/Pr7HNbOUIZq80ux?=
 =?us-ascii?Q?vJs7rJZNII0LkC7Po8uvnTAzlpXV2PsIPRiOnukkYdtZjQoOIXGpJ//16HAB?=
 =?us-ascii?Q?Ozfqd+SyEoiMsJJpqwdq4svwNo+WHLBiJxtfg3xmrVKwwSwgO1jR+7iJa86Z?=
 =?us-ascii?Q?lZcMZO50hOlGmOfZxm7Xp6SvN4TQbG7xZdnqwz4Pol+glfJGkFiiVRYr3/sa?=
 =?us-ascii?Q?4ZbbJVXAkG3mnz1461E7/c4FoZ1+68bqcDCb+XJBfwzK73rPNxPM7d2vOrfH?=
 =?us-ascii?Q?r1V3iWk8X4oWLG4R26n4uiFs4sISG9SblGym1BMcXjPppgpAro7ZdX7Qq/M8?=
 =?us-ascii?Q?G+ub9QdeCV35mpygOqsNLY5CUec6+eiJIOcDszDEKBSZeItoyNvEKewkqshw?=
 =?us-ascii?Q?hKrPOnL7lp3BfxqDevitbXnn7V3m0EmnsP+jQ8AWbezYAZ8RFFx75aNMZi0N?=
 =?us-ascii?Q?iHC/B9S7ilb17WwtY87Cnb2ZF0ENHuaXFzlFBLXSCVL51Jw95UGrYhFOhbJZ?=
 =?us-ascii?Q?BUGbmWic+ut/zvsE2OSx+mH2y70eYf39PDE7K91/NT1Vj9pjGvaQtpaIdzOt?=
 =?us-ascii?Q?rBO/bX5xvpiK/XBR6S82TtOgcYxGRknMixrDmnoSHrJ4lVwbNMTEi03UvSHD?=
 =?us-ascii?Q?5kPRewI5Fsr7sOPpx6ow5ggmLnU3DMHswSXBwowy1R3FTQr7gRTxvyNIQ2SA?=
 =?us-ascii?Q?CjujixEjZHq0Ws5B0D+a+Z+mClr8c/2/KQHNgfC3gYjUedtGkCdktgfRvril?=
 =?us-ascii?Q?aH6mlCJxsLqroTLFcyEhqhi+9msnqaUncPGw3Hvp2io/NkQUAfsLs20/EaSg?=
 =?us-ascii?Q?mHFkTI35V1hFCyqdLbB4eG8bWFKXetCWV6bzlVPIZP/G7RYDbOzWrSkrEcuX?=
 =?us-ascii?Q?MjetZZs0Et5nEEjY5aepWvrXprzPtAw7TE190dJh1AHc3Y9FKr31bNcD7ujH?=
 =?us-ascii?Q?wtPbCJNRkCuYBC7E/AGisq/A0vLxw3qCu6Suwa/NU00HhH7mjnQ4luMBML1d?=
 =?us-ascii?Q?hEXRM0suDSIxz46TXZXS7iOIf6Vo4+0eECCOU0jamVHstDrLUOvQxap+4hPb?=
 =?us-ascii?Q?y+kAPbr1XnSnWG4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:07.9763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81edd608-7457-4629-0404-08dd6c9fd4bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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

Summary:
    
* Improve vrr for replay and psr
* Rewrite drm debug message
* Fix clock issues for dcn32 and dcn401
* Fix mst dsc mode validation issue

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.327

Aurabindo Pillai (6):
  drm/amd/display: convert DRM_ERROR to drm_err in
    hpd_rx_irq_create_workqueue()
  drm/amd/display: use drm_err in hpd rx offload
  drm/amd/display: use drm_err in create_validate_stream_for_sink()
  drm/amd/display: convert more DRM_ERROR to drm_err
  drm/amd/display: use drm_info instead of DRM_INFO
  drm/amd/display: use drm_warn instead of DRM_WARN

Austin Zheng (1):
  drm/amd/display: Set ODM Factor Based On DML Architecture

ChunTao Tso (1):
  drm/amd/display: Add a Panel Replay config option

Dillon Varone (4):
  drm/amd/display: Consider downspread against max clocks in DML2.1
  drm/amd/display: Add Support for reg inbox0 for host->DMUB CMDs
  drm/amd/display: Fix VUpdate offset calculations for dcn401
  drm/amd/display: Fix Vertical Interrupt definitions for dcn32, dcn401

Fangzhi Zuo (1):
  drm/amd/display: Do Not Consider DSC if Valid Config Not Found

Joshua Aberback (1):
  drm/amd/display: Use meaningful size for block_sequence array

Robin Chen (1):
  drm/amd/display: Enable Replay Low Hz feature flag

Tom Chung (1):
  drm/amd/display: Do not enable Replay and PSR while VRR is on in
    amdgpu_dm_commit_planes()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 296 ++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 185 ++++++-----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   6 +-
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |   4 +
 .../src/inc/dml2_internal_shared_types.h      |   6 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  24 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  44 +++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |  61 +++-
 .../dc/irq/dcn401/irq_service_dcn401.c        |  60 +++-
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   9 +
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 +
 .../link/protocols/link_edp_panel_control.c   |   3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 132 +++++---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 121 ++++---
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 297 ++++++++++++------
 31 files changed, 858 insertions(+), 478 deletions(-)

-- 
2.43.0

