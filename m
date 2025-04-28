Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781E4C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1873410E1F8;
	Mon, 28 Apr 2025 13:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogf1G+jD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086A10E1F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvGwux3O0UZaQDxr3rzadVzS25dtXSxjd8fnqHH4/HDilce8GG7qEbgLacsbV9/cK1iaZL7FlI/EV0RCwWX0Arv3QYC2E6KFieAJv9CRrcFsOHRTCVEt9/QDSbOHP9MvstywCFK21lID3E2j5lMNr6d0bl68sHfqPxecsbSmcighzUpJ215QSABTRgGJVOUY5VxBOsgA7z9pzT46A4cm+4MhgNJqvfpwO0Zu1tr3QuEQFAP7RGXX8Eroo0VEHcB1KYgiIzZB6jutqZzlenNdrN9qTfqIVkaolku1Nxba4c7pK6CihtzvxdXHLr5KLJwIPsash+oRCyANP1kNCaWjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzKNyTn60PN/9K+uBqyrr0o06HOyLcVbPxaQKFQ3fSs=;
 b=XWnDjN5RJiCaVvRM/fe61ArCkMQmjgPDBhh0NfG6jOcnufiLfUQFhYZHYmrOtV9lILk7+SRn+erU4rgQni1RQj1OM107bT6aqVEtyuoC7hkBwImnjSCUmOuqR93jOjRg8zM+8c//WQUG5zM6dwm+ahxLDRq3LtdsbOtWcN7r5MfiWeAIgzFht9kA2hwNHpxaDLJXGOCVGJq7xTK7te4J/PiidrPASIevO7kHjHE1lGNW2+XqR0xZYtYWgKEv/Ehr1xFt+Q4Xvq255BtcfzB9Q6wej/gwGyfgYuedq/YeQ5fRn8wPH+sPXTAO+0Hftvregx7nSRDXRiZpoPMSsMThwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzKNyTn60PN/9K+uBqyrr0o06HOyLcVbPxaQKFQ3fSs=;
 b=ogf1G+jDubIvx6l/dxMvE82FStz852bWYObZIdoy1rgZlceZWKOjuRaLZcIhRdm250luusoIqZwZWUM7nTfaNKjlFUZewZl4AOhQPa8afHkRJjG5QDvPAbemJYE/VhjmhTKQvw+75r31Da8P/WI+ccD+tuazZrTu/s5eUqPyMQ0=
Received: from CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:55:32 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::8e) by CH2PR18CA0048.outlook.office365.com
 (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:55:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:55:29 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:55:26 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 00/28] DC Patches May 05 2025
Date: Mon, 28 Apr 2025 21:50:30 +0800
Message-ID: <20250428135514.20775-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d82d79d-d42b-4e75-03a1-08dd865c5746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ntMOQ6PATr7rB22UnMdd30looa9B7DnnTws5hqPEaehdO/C4ywk+K/KUrmQ?=
 =?us-ascii?Q?U0hwYnMa7rtwA7Dp5DSo4VputnMye0Sg7AAS9hJuG9wcTBzfrjw7/8GRs5cH?=
 =?us-ascii?Q?x1HKTVF6kcZX6hN85udgqpCOgnusbpMq5PAjmZe+zMVAGz2XLYo9Xks2D1/R?=
 =?us-ascii?Q?QnGHIYZXFpzEK/zyaKWUkDtoJOHEBMv/9XyNvSlmABP1Y4VUT5VLjnlGKnkH?=
 =?us-ascii?Q?1aPq+M40CCSP3D2B27Q9lRJt9JLnCZ7AubEJ+7FAub0ZAx1Ter+4L93NO3uF?=
 =?us-ascii?Q?eynk4B/mi+120kLpgT+ZfHtdpuD41050QTwwt0Kknyagc4V1fndXFxIp6p3D?=
 =?us-ascii?Q?2TE1rFq2w9Fd+eDZkPQJWeLDSSEbd4J6SeFJi8pc9MaysRS2Wtb3xstvAYPy?=
 =?us-ascii?Q?N0vAswoMzlQsrS7i3x8QYSPDfPtHV2c+nj9tLFLBpGJPMZ89MFndvj7yz0sD?=
 =?us-ascii?Q?hJIXiLZKyybxXY5vRlqWpLasi9yXgF8PNoG4Ux4x0pz7jSxV7qTbsLNQGPs5?=
 =?us-ascii?Q?77MSh+2g8ofblacJnDXebJ3H9J9pmo2oiCSq2H3whDg4PIcqEsv5P8QDQlls?=
 =?us-ascii?Q?3/e5WFAsboKjRtmoT4/Jx2CzZ8RfykFnK84i2niXMrMA8ErIRTSScL3IjYE5?=
 =?us-ascii?Q?/Pgawex2iDw4jPsMIuELTmmHxnH6BGOlyjIH0Bwd8sxy/h5YFdAxreMkki5S?=
 =?us-ascii?Q?ve8O7FudkLleTBMcEOB6souwb0Ze2I7+sZyVMqwK+u/OGy2rr81yARuc9e2j?=
 =?us-ascii?Q?pTRJAZSOtAHQQvLWRPfsGoWqJRvwErWVLY3S5iGPy+JbCm6OX+XyqIb8aFer?=
 =?us-ascii?Q?hYfeDzUiZYQpfrztdFhBpua1wstls1H5ArXYHXPX351QctA5I/rUqCZa0ouZ?=
 =?us-ascii?Q?lJHCXI0gXMHOljcYbK+y9Zznbk+vCHnl3fvPy2fWNxlwJv8EJRbAmhSLkrPy?=
 =?us-ascii?Q?gkMIo5hDVQgn0DmG7wcPKTMbCC+FdFFONI9h+H9DZEHfIU4jvXYLrv2qpA4J?=
 =?us-ascii?Q?nh7KLyIbl9pYvuoUZ5EUrwV02qh5J4BIq8Wgh45HXjDqiIFiYNOPdX+tb5iM?=
 =?us-ascii?Q?Utef5zpW1v/4qFuSWDobp2bCldYfB9sbZCO4eEnOuVD8pWmSCOARNOiaw2QU?=
 =?us-ascii?Q?kXuocj+QdwKXJ489a+5e4yDYA9xn9XYvdybmgIPRV17q4Z+MR86KqLTYMsP2?=
 =?us-ascii?Q?6sVP8S4W/M5GZnqvJ5xujSenbz+bPkVkbJKa5G104ZstavBKa2+lhWIfufnQ?=
 =?us-ascii?Q?/JI0O9RPKJILo6EJJDMY++qzeQLKeX+pSYTrFIYjqhQhuYXjuzOr/DvN10yW?=
 =?us-ascii?Q?BtBs2DEzQHZprRtGXsyLXuyF2fTN5aIU8MPE3lptBJxJsB+eGPWpjHqXZ4Ny?=
 =?us-ascii?Q?YhZlHDHxr8DkIvRmaSHr1+plxAAo6SJO019ZGXVkwjpaWiB4oSLor92SiEBk?=
 =?us-ascii?Q?l5L/+8U0JrVdyJ4GntrrD2nKlYEjrGMU8gm2hBTDxH20aw7UnXpMopm0CZvY?=
 =?us-ascii?Q?6kaolpD6ZqspPx9me3ZAEyiOF8dla8SqRY0J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:55:31.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d82d79d-d42b-4e75-03a1-08dd865c5746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
- Update IPS checks to properly include all ASICs.
- Refactoring DSC enum dsc_bits_per_comp
- Remove redundant NULL check
- Revert "Refactor SubVP cursor limiting logic"
- Disable DPP RCG before DPP CLK enable
- Add skip rIOMMU dc config option
- Fix race condition in DPIA AUX transfer
- Refactor SubVP cursor limiting logic
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove redundant null check
  drm/amd/display: Remove unnecessary DC_FP_START/DC_FP_END

Aurabindo Pillai (1):
  drm/amd/display: more liberal vmin/vmax update for freesync

Austin Zheng (2):
  drm/amd/display: Call FP Protect Before Mode Programming/Mode Support
  drm/amd/display: DML21 Fixes

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactoring DSC enum dsc_bits_per_comp.

Charlene Liu (2):
  drm/amd/display: allow dscclk disable
  drm/amd/display: disable DPP RCG before DPP CLK enable

Dillon Varone (2):
  drm/amd/display: Refactor SubVP cursor limiting logic
  drm/amd/display: Only wait for required free space in DMUB mailbox

Dominik Kaszewski (1):
  drm/amd/display: Prepare for Fused I2C-over-AUX

Jesse Agate (1):
  drm/amd/display: Always Scale Flag

JinZe Xu (1):
  drm/amd/display: Send IPSExit unconditionally.

Kevin Gao (1):
  drm/amd/display: Add skip rIOMMU dc config option

Leo Li (1):
  drm/amd/display: Allow 0 dtbclk for DCN35 and above

Meenakshikumar Somasundaram (1):
  drm/amd/display: Assign preferred stream encoder instance to dpia

Nicholas Kazlauskas (1):
  Revert "drm/amd/display: turn off eDP lcdvdd and backlight if not
    required"

Ovidiu Bunea (1):
  drm/amd/display: Update IPS sequential_ono requirement checks

Roman Li (1):
  drm/amd/display: Fix invalid context error in dml helper

Ryan Seto (1):
  Revert "drm/amd/display: Refactor SubVP cursor limiting logic"

Taimur Hassan (3):
  drm/amd/display: Promote DAL to 3.2.330
  drm/amd/display: [FW Promotion] Release 0.1.8.0
  drm/amd/display: Promote DAL to 3.2.331

Wayne Lin (5):
  drm/amd/display: Shift DMUB AUX reply command if necessary
  drm/amd/display: Fix the checking condition in dmub aux handling
  drm/amd/display: Remove incorrect checking in dmub aux handler
  drm/amd/display: Copy AUX read reply data whenever length > 0
  drm/amd/display: Fix wrong handling for AUX_DEFER case

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 +++++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 28 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  9 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 15 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 17 ++--
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  | 12 ++-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 62 ++++++++------
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  8 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |  1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h | 10 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  7 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 82 ++++++++++++++++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  3 -
 .../src/inc/dml2_internal_shared_types.h      | 10 ++-
 .../display/dc/dml2/dml2_translation_helper.c | 14 ++--
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |  2 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  7 --
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  6 ++
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  6 --
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |  6 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 21 +++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 -
 .../link/protocols/link_edp_panel_control.c   |  2 -
 .../dc/resource/dcn10/dcn10_resource.c        |  4 +
 .../dc/resource/dcn32/dcn32_resource.c        |  7 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 25 +++---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 19 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 24 ++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 72 ++++++++++++----
 35 files changed, 372 insertions(+), 165 deletions(-)

-- 
2.43.0

