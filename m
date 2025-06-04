Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5312C5B552
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369E010E17E;
	Wed,  4 Jun 2025 19:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dNxj453f";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111E210E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxl4sGPtob3OZt+zv61n7639W/3SGxrKADTnXd9q1ax2IZfCspOPFW3Lt3llvJBLMH6fgN5i90zsZw+JTb6pxP5fYUePtpTB90qPIT/S6Mg5NBJhYznjZJjhY1UDMGwtF+Il/J5/2pAnewcTNRDgtY6/dOwUZ+RxYYq4wYiyADUD9sTjEij0uzVu2urzIFpD86WP/LvFpmJQGQmF0SsQIAnC2xsyLN8dohaMFrYda4kpuJ7MiH6hlSO/kpexp9qk6727gG1uckWeR+Kc384Y3dVtypq2COriYRkAdsB9cYs2uWRKp+yfEiZqGOlJ5EfshnftJsBl7qBCUKsn7GpBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh4XO1eGkDxcxQE+XGgVcn6+pjNLuo0JPew/GHeGasU=;
 b=zBDzq04QRoBfah7Net8j4wVsxLCjAwmM6oI7SWVy1BPBtx9DxwcOtAfAH34wzLNaM+XuGFo8D5Qj1Uv0ew3gkcP2XmWhiRLjprE5cGGig9AGcZ6ar7SUkBL5UK+KGVCcvnadgPh7mo4VYNPHhmH4g4RVWX4/57oKSaiKpbtCs3pzwrJrg+Yc3FXi3TYXffrtHMAJfLkW5MHuI4ZwwTGg2bBp90uVTjrvkUS1+L9xukX6kwyW4kriFNkkuaYRyJZngWffvtbuhg8ZYkGD/W0lMZEH7fCeo4guJLCOtdzLk0GssqOlbZvbLx8vgnwnWzggd/HztvSzaIhtpwqOmKoWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh4XO1eGkDxcxQE+XGgVcn6+pjNLuo0JPew/GHeGasU=;
 b=dNxj453fQubeK4Yd7m69UnhCkPwUOaz5tjX1aQaOdvghdLcm1EYujOWiKLxHOvp/JWcL3jKcIlryqAPh0lV8jeIEeqoirRcLTgdh/6oaa05m9qLEhz48oh7S3ziz7fVUbewa1o1C7+22RJCRE3o2d829fDjPfPRcls+zvphiC5E=
Received: from DS7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::30) by
 MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:37:26 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::9d) by DS7P220CA0044.outlook.office365.com
 (2603:10b6:8:224::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.26 via Frontend Transport; Wed,
 4 Jun 2025 19:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:37:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:37:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 00/23] DC Patches June 04, 2025
Date: Wed, 4 Jun 2025 12:43:11 -0600
Message-ID: <20250604193659.2462225-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cbcbc2-0830-4589-11bf-08dda39f3bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5h5+cGz0TIto+f6zcz8xUtI0fjauYNKwEmoxOICub3ypLDNSz/UGWmATUiWr?=
 =?us-ascii?Q?TPypeDgurSeccx+V9kZYTVsG2/mg1xINJ6AULgixoxx76hlzrqCqDeelwH3e?=
 =?us-ascii?Q?w2vAsEnSL9SlKe0lINjNBwPY3BTXLrvdmfkbXcrgZ82BA3rj1g5Ip8HA/f+w?=
 =?us-ascii?Q?AFtIJq/BBsSdnpBis9cEQhqf3zFZqYPNeY9X+BJRNsxkTdfRa1LvEKuxT+PQ?=
 =?us-ascii?Q?blJa7oAcxkdFaxKtjc7N094h8JHeBhP+KefyzgxcDWtwN+4I2ssRthoCdUVI?=
 =?us-ascii?Q?0X3jCrnj286sNUM+0G2dRSCVHWbaJC/W3sk6Aq5l6mx4A86TPnJZgkmIT2wN?=
 =?us-ascii?Q?UXBZYz/M/3ZXvH/gTd3/4sfx4zik8MORhqUXEqixoNDqPXksVl6bhVfjUSqO?=
 =?us-ascii?Q?pmxOC2OCJGvK4ac82QvhSFcdNOZR5jIijuzw2j+l2kOhy11KzWKH7i9/OZoV?=
 =?us-ascii?Q?gz5nlCKX9dIrv5wzp+UKDMIV2BDuK9//zC7xBwVAr7BFy4NV9t++gOCyHRHQ?=
 =?us-ascii?Q?+uBcTmjppX3gt3SyXQZSoKPc9JKeDGrYZBLKGAM9iwK+jL8Yx3wLBlHosZq1?=
 =?us-ascii?Q?0U8c/j0iYTSbDKF/TRQ0QwTdGy2p8I5FPPqA7dVeQmWv0iFLaJM0a6ZA94wz?=
 =?us-ascii?Q?6rekOaQP3WsZEOMim0KGc3Yx4EUU6NH8sgCgQ1NfC+lwBavm+YFviDLeaiTA?=
 =?us-ascii?Q?7EfxejjZXfLspkGWL8YIdMj4XvG2ffiWK1u+a5HJAWHtpHG7F+EACyjUQTpC?=
 =?us-ascii?Q?aGvzCj4jMYL1sQ/Cm4RXjP7pN7pvYEEkrLcVJU49w9iLC42UcQGz6VdbVONz?=
 =?us-ascii?Q?MIjSYHCygwu9almQfRYclldarguU5A2+durhMKtL/O94a1eidCYJpWKrWZxP?=
 =?us-ascii?Q?d8flL4QzgZHo8v2pzbNdyJ4G6cxLiAS8wX8GmMRdnBfWu+1zW6oKF7uQMjqi?=
 =?us-ascii?Q?BvyB2VrDL0k9AXiEDy9B0IcSMfSH4IXvbisyK+jXZr/BeOcCXlW5ablJgy4w?=
 =?us-ascii?Q?iqtmveQI/PTRWV2pN8HufX5xGEJf0sfS5gKZOn4/VECxt/hs5INKN2R/NvHV?=
 =?us-ascii?Q?Lkd6AWMwJEI7tJU9gjMPmJL2i3eFHALj5iqPYwh8gOnZ0uLh5/MXHLXDN71I?=
 =?us-ascii?Q?b5C220cOgqxykz5Dr3ExqiCzIAYyEAcFfOXaNRdpS50vZg/Fp8UUVla+6h+t?=
 =?us-ascii?Q?t8+Xuqw3KeHGUrb5I2gkS/kdv6dC8W5yySPAJaOtmh9OUNeKX05qzkopD1jV?=
 =?us-ascii?Q?no5YQsP5cCfZDbiDe2+9PM215xhv0ALn/ScrZHstjfF1DueHYwSvWR1a61E2?=
 =?us-ascii?Q?3ml3iRmPCjnUm90/ZdGJPVuSTENaVqv3ST764lKePz9b2nmbJR82Y8QzcN/8?=
 =?us-ascii?Q?1fRvJpEzrUDmfywJjJ9HTIXZ0IavUkfAB4G59dINhUlzubL0tiKgklB9otH6?=
 =?us-ascii?Q?5oz9wt9/+CFf4Llp42RxcP8O+kGhpSfE/+usoMWMCh2iTg+qxsdczPCcvpYJ?=
 =?us-ascii?Q?SHH7ITenQiNtBMYouJzfD7xYoGSvk7pFMwNN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:37:25.2852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cbcbc2-0830-4589-11bf-08dda39f3bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Improvements on DCN4, MPC, DSC, DP and others
* Enhancements on backlight and brightness
* Fixes on mpv video playback and display flicking

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Fix mpv playback corruption on weston
  drm/amd/display: Fix kernel docs for new struct members

Aurabindo Pillai (1):
  drm/amd/display: DML2.1 changes

Ausef Yousof (2):
  drm/amd/display: Don't disable dtb as dto src during dpms off
  drm/amd/display: Adjust dto fix coverage

Austin Zheng (1):
  drm/amd/display: Deprecate Loading Bounding Box From DMUB On DCN4

Brendan Steve Leder (1):
  drm/amd/display: Add custom segmentation support

Charlene Liu (1):
  drm/amd/display: Add HW change required mpc gamut remap

Cruise Hung (1):
  drm/amd/display: Add DPIA debug option for zero allocation patch

Dillon Varone (2):
  drm/amd/display: Remove dml/dcn401 files and references
  drm/amd/display: Refactor DML2 DC power instance

Dmytro Laktyushkin (1):
  drm/amd/display: Update tmz_surface type to match register

Mario Limonciello (2):
  drm/amd/display: Only read ACPI backlight caps once
  drm/amd/display: Export full brightness range to userspace

Michael Strauss (1):
  drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest LTTPR To
    Host

Muhammad Ahmed (1):
  drm/amd/display: Add option to disable PHY SSC reduction on
    transmitter enable

Nicholas Kazlauskas (1):
  drm/amd/display: Add more checks for DSC / HUBP ONO guarantees

Peichen Huang (2):
  drm/amd/display: Remove dpia debug bits
  drm/amd/display: Add dc cap for dp tunneling

Ryan Seto (1):
  drm/amd/display: Clear DPP 3DLUT Cap

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.337

Yihan Zhu (2):
  drm/amd/display: Add RMCM debug logging
  drm/amd/display: Fix RMCM programming seq errors

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  63 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   1 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  87 ++++---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   5 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   4 -
 .../amd/display/dc/dml/dcn401/dcn401_fpu.c    | 239 ------------------
 .../amd/display/dc/dml/dcn401/dcn401_fpu.h    |  14 -
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |  13 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  18 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |   4 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   5 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |   2 +-
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   1 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  19 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   6 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  59 +++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 ++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  12 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  47 ++++
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |  38 ++-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  18 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |   2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  10 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  13 +
 .../dc/resource/dcn31/dcn31_resource.c        |   3 +
 .../dc/resource/dcn314/dcn314_resource.c      |   3 +
 .../dc/resource/dcn32/dcn32_resource.c        |  17 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  19 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  18 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  17 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  26 +-
 46 files changed, 500 insertions(+), 425 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h

-- 
2.43.0

