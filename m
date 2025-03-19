Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA45C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E6F10E1C6;
	Wed, 19 Mar 2025 17:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBteiiRP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE6710E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNyQUsUh8GMCZmPZvXwUTm8azzo580GqS7EuJOoGK2dzr7jOIo/ROsPEHr77llEab8tJUZPvPMewOVlJpZu59hHmvwW+D4SqbKCPzci0ItuEskT+co45LleUfBRi31kHoyk6vPcURctlnRNw9Y5jYtRhdxcBdnRhYMBkWjjv4fGUFLXM5WZ1Kqbiq6dZTORl+v/9l5ErgK8ea74+bxlCJ7XEO8aZI6cCZb9rpCHkf7W8wQ/Kesi11WFQLMfSdxvBrTDwvqO8uhghBEc9CQmR06RNXNnd2/BSdMjO5RKpZQ98D9PcJHtVLLIyZr6iKVQoxAWfEduxfiIGWSOcvs+P9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0X51ts3EMIeOpqtKc12F6fPLhwhHR0QUiWBI9Yt1go=;
 b=Zs3pi0GuLIrKxRzxn2QtgFEPbHAsj8QHerlT+DiwNNOpW7d8I9Nbs2OaQwGYVdfVupdFHwZoPfP3T/GYEw56KoYBg2jkD1DDWjtQICi8l51uEIj9siuUw1VymXbYaxTURxfD2LzU9xFFsUEQgi0H5NKBpeka/aDhFAPNR1QtClA+E7ER8vfhTdU0i/CioRfmbJYIBqcNsdiBbE/dTSuWgrUGWaT1tFuYykT9xZ3AGAufBHJjH+guGwAFIB/J5qWsqscDn6ncC+FpUS0Q2q1x3glqZTS0tef4uZFN8nOx+mq2fwVgthmb1+hYcuTtilKbuc70FJXE4AvQxEgZWKUm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0X51ts3EMIeOpqtKc12F6fPLhwhHR0QUiWBI9Yt1go=;
 b=nBteiiRPAd4d2K5HriVBHRCowBLF2b+9X2+WeOX1IiKRdvoyvKKvHbTo4C/2UR0yHgMzprK3OcBRMDFew8xeKjgULJjlsLjDWr130LV3ylTRSTScCgqJOTLKNJluw+E3DuBuBdwQBClXcLQwfaYNa+hG9HZUJDIzyMsNPJRj3Xo=
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:20 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::5a) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 17:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:18 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/16] DC Patches for 24 Mar 2025
Date: Wed, 19 Mar 2025 13:55:05 -0400
Message-ID: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: a58e29b3-226c-45fe-2d19-08dd670f7e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9AggeqHIiQyoyIJSHmiZnlByMq6kue8FHWdYXorCYdR4dWwSjvM02xrOkLY?=
 =?us-ascii?Q?u2I7G4lAW0L9AJnZQSl+IMUwV//MVUJHCwx5qEtJpmg2JIgAOVoyQ0+5Nkiw?=
 =?us-ascii?Q?N7vzk8CKl5BpCfeK+XuNAGoPteqYdRlEC2OR8fsfUm0sHN3g63nFkMkPhGc7?=
 =?us-ascii?Q?jdcZ0y5omfW5Vtybjavl6WOVXC9drAju1ULZDGesmDY+dqMB1x9GD8UT8Obx?=
 =?us-ascii?Q?URTMVpHLUjfJYDd9ba3M17Nv/tr3y1wg4R7r2EiWdaLywDT35Cy6Pqgrq0Ew?=
 =?us-ascii?Q?PVB183qNbdIQubwLxj40akbqu6f51s+t+nP3spDYeV320r8eyYP73Qc5uzsN?=
 =?us-ascii?Q?qwgRqdhCmQBZ+Np1N0BvUXpQzTsAk5LkGVBErR1JyqrxnbdIm5Wq9f46Q19I?=
 =?us-ascii?Q?mJGSTZGG07n246UAAZJxy5IKgQ4m+00OblTF+GEuKNo1w14p+ijtO6sFYD1h?=
 =?us-ascii?Q?vQkdmBZndcJ180LlLdde/AqvZJadua9CHaxUCkkSy5jdmBY3zHO/hcR47cV1?=
 =?us-ascii?Q?FTM/dQApSvKOkRO+6F9mMO3fVDvt0fLCal7gtH0/fs4NtkMJvnTs6QLzCyJV?=
 =?us-ascii?Q?A5iGEo2Oz3VKMScWYssQ/4FLOxrQVJcAMVAUwtK6PivPPFUZKfHud75MHRGi?=
 =?us-ascii?Q?Gnpq4bGbWOugPoKbG6u05UXMF1IfoYX+HYS4MjDOAHARx7yUO7yuLvDkgzc+?=
 =?us-ascii?Q?tYcnn8EExqf4zCvE+M1NxWH5jUkPgzjs+s6pV1iMh4W2n8+gbeu8U/7XhjUL?=
 =?us-ascii?Q?O/saKXJAkCj8AtfFLTQK6tWaBJC9xUknO2cYdEg5MI5LiPszoJ3Klg4Q7CDX?=
 =?us-ascii?Q?OmA2LXYNU748cmk1x24wT4G77RhYJogqDIS4ZzEjfBx6GN25duVSNv4fkTFM?=
 =?us-ascii?Q?Au4YXe3u67Cetj1rzi1vQUlJ623I2605VVtVrxvCHSAQ8mjSqd+UVY8OdHac?=
 =?us-ascii?Q?BVFdikl+ch55Wke85OGzMMUu+W3oYxLTCR0sVkOra7t7IatXPwtMOtPppbMA?=
 =?us-ascii?Q?ydqbIpZvV3soZIKoAOdCe4Zv8JvJQ8ClE+tXyM88x5ayBpuS4xlzveMUAmX8?=
 =?us-ascii?Q?jIDurQ3oXQGgB855BeMvRL5HWr/89gQLsAP7/p1PHJ4L/YPfKyhQ4JtA2aOE?=
 =?us-ascii?Q?Gm5h9WSFnt6et/cI3QLydPHzSjbq/vgLC60YtsevSyvMcrfoLWZQz2GdziwG?=
 =?us-ascii?Q?iIA3nh7gvsvuqEWU7715pSt1aUwGHB6WZijYD0LLVtGWOeaGBrPwn+JQPDjM?=
 =?us-ascii?Q?MMBhRXbC5pPSAKkFPTiFm7hsiMsTP13vyPOjfd1O+hxUrt3XexIu8bI7cqch?=
 =?us-ascii?Q?GPBusTA4SssZJMM/Qe+yihzN7UBq34I/Ds0IEXWTqAEd3b4+TO61p6dRtvRH?=
 =?us-ascii?Q?ZM3kFP2PRW/YCbqSZ6NovfbpTM6xbQAMVAIh3fahI1oXmQwKnfWLXmFEloJ9?=
 =?us-ascii?Q?9REF1XB+rlaQOt8O0NsQgcKiNB8OI7IYWTyFRCqcgso+bMFUqg6Pwj+tnIm5?=
 =?us-ascii?Q?RlBYCcfcz6lv5ws=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:19.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58e29b3-226c-45fe-2d19-08dd670f7e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

DC v3.2.326 Summary:

* DML 2.1 resync
* Vblank disable fixes
* Visual confirm debug improvements
* Add command for reading ABM histogram
* Bug fixes & improvements

______________

Aric Cyr (2):
  drm/amd/display: Create a temporary scratch dc_link
  drm/amd/display: DC v3.2.326

Ausef Yousof (1):
  drm/amd/display: Enable pipe update pending wait

Austin Zheng (1):
  drm/amd/display: DML21 Reintegration

Brendan Tam (1):
  drm/amd/display: prevent hang on link training fail

Charlene Liu (2):
  drm/amd/display: fix zero value for APU watermark_c
  Revert "drm/amd/display: dml2 soc dscclk use DPM table clk setting"

Chun-Liang Chang (1):
  drm/amd/display: Add Read Histogram command header

Cruise (1):
  drm/amd/display: Remove BW Allocation from DPIA notification

JinZe.Xu (1):
  drm/amd/display: Use sync version of indirect register access.

Leo Li (2):
  drm/amd/display: Increase vblank offdelay for PSR panels
  drm/amd/display: Actually do immediate vblank disable

Leo Zeng (2):
  drm/amd/display: Add override for visual confirm
  drm/amd/display: Get visual confirm color for stream

Paul Hsieh (1):
  drm/amd/display: Skip to enable dsc if it has been off

Yi-Ling Chen (1):
  drm/amd/display: Apply the adjusted DP ref clock for DP devices

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   43 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   29 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   51 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  337 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |    9 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |    2 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    3 -
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |    1 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    2 +
 .../dml21/inc/dml_top_display_cfg_types.h     |    3 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 3083 ++++++++---------
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  134 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    8 +-
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |    2 +-
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |   31 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |   77 +-
 .../display/dc/dml2/dml2_translation_helper.c |    2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |    5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    5 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    1 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   14 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   14 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |    4 +
 .../link/protocols/link_edp_panel_control.c   |    8 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   59 +
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   17 -
 34 files changed, 2021 insertions(+), 1956 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.c

-- 
2.49.0

