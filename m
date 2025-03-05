Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE4C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D336F10E0BF;
	Wed,  5 Mar 2025 05:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mXtqbav8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F8F10E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP62egoItpBl8EU+b/+GioIpTaj3xWvBhPjxE/hVb1vHiKQy9/M2m8XyBDIxzKGkjqzIvzLso8oCJAkZ0oD4m2P6gowk/eE8y7FvIUJ7/nPWU//E6KpECPth52KNz0MbSJzz1BXR6kGBjN1hMrFg5I3dvgcpcmR3ztCjNmc9fCTjd60Tlfk29whYPUoJyWT0HIIPz1pGD2PxvXMNZawnd6HQLYvwujz4DODhrle0wZPvU4z1pxhSipQBfA986fW4G7ZLjtarOGVsoUBqk7Vamj8rbfZUUydahl5ef1UX+sOb6FrO9/yThK/eQKKzZEi/mNlzr6lmc+dbsJanLiuD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sToEPteZIi6/e7mYPSHaDXq0FKI7B61SmEMFERqcBQE=;
 b=dvJtJYdMuQYEi+SnyaOvYz6D4ovfX3P2z++w3FVAlVQpJOa9smMJyDHvOfUMIE+UZj9brxDoAT0/Bfn9NIzSJf99aM/5H+qxLE7pOCI87cBfZ5kgF2CWOMeHY7Tnbz2u0uiQ8QUZCw+o2HWS5qrsHbw8AJjvVFNuLM2yQuCHboXg+GPLylCkmhXcn1l7HxeLporCAXUs7LMYwJ97dEFQNQ6F8xXPV5eUOKpNnDWVAVpeqtH7dVFIzYpd48WYZEZ64RKeOqabuZy6/mpDG2VAi2Vzk58m19Tm1PpTZbvQy2wzhc3g+Y0i2cxEMUiWF8H8OUVN7zVws0wb0BQPbbL7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sToEPteZIi6/e7mYPSHaDXq0FKI7B61SmEMFERqcBQE=;
 b=mXtqbav89kSyIuErPMlqJDYJD4Uo8nx4s4Bn5XbNoilRTbwUnr9Nb4x2T7LllSa6o4o9E1PjUMpRU41tUJwGL9HVdc6ypA92X3w2c4yhm/JAM+XXq9LLB8l3pkKVnrO2jCkGcdlyPaJpQlt2etNviF9+Vt+wRLbJx1VESoSAjzM=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:14:17 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::f7) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:14:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:16 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:13 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/22] DC Patches Mar 10 2025
Date: Wed, 5 Mar 2025 13:13:40 +0800
Message-ID: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 554b59fa-23bd-49a1-112a-08dd5ba493e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mDkQayCM4UkUt/4CUReB+oMYmRZPyVFafsNJORvr9P8EdCqs9P6/Y2b4a7tq?=
 =?us-ascii?Q?pHxnoiRItF+Rr857tonC1Mk6SpT1+GZ+xaD8s50lNZh69vCSEUqRxGRZzSZN?=
 =?us-ascii?Q?CYzP1vzU3e+WjovNnZi3SMEWvXJOCYorGcJChiKrnKqg2YjWeW19PLriYaVr?=
 =?us-ascii?Q?uWiKsJpglNQK/IN67ajdUP6kTyHLLvl10lONRLkBHabYPFpt8PJsxYAPT3Ge?=
 =?us-ascii?Q?CvI8tGzzTfAQr/Q6ErSohpx3b6NIB0f6I3SwZhg4upqHTucdiWNWU1PZq+KT?=
 =?us-ascii?Q?ccAsyl1xNQQKnlSN6jiNndkKX5fK3sPol7FxYXgAjw8aAKr/d3/pe+ILAlzq?=
 =?us-ascii?Q?1Eo9fiA8me5halg4r1Vd0wo4G3pYTBXd6TuW4FgB6+t/Qpu2azVIOS8g+S+B?=
 =?us-ascii?Q?kUuvdd01zSmFX0nFZqCrHU5nY2bBZoDxodBorLyw74LmvBtmUQkxHoCTJCR5?=
 =?us-ascii?Q?62/DWDz3qvHVXgUTPjXmfpOm+oeq5UDYKxtqFncRVNOMpiDpVoVE9GXu9jWo?=
 =?us-ascii?Q?u9C9ntpZjGpOyS+edAwhXmhHqWjLT8VX1E0KiE6LLr1ueOzAoa3opd2tdTUq?=
 =?us-ascii?Q?O6lPA1FcSu3pjzqTIrPaUlvWRaVV4qsE3dnxhGpjCKI1zeFZRlYhzxiDXFnk?=
 =?us-ascii?Q?DUXrS9bncP/ncGTDEAZuGr4dJc3gRl3QJaDHCSsxL1OX8wfTc+ZMyb827A/l?=
 =?us-ascii?Q?cVFXHDWTG0a7XYGtop+7jWrgb8AJHTEq45k70fKG9gm9kE2RfSrtTmDfi6ZU?=
 =?us-ascii?Q?MI8/z50PIKcb91Yaevb+BmiqNaFoJ0UefhRk4Dg0DgfUUAdEbVpxeqdhLKo8?=
 =?us-ascii?Q?PLSNJZd71WPuURV1oNmifIOcTfCphQ+/6lXqO7oekhU7klDUvG2yu6a9ZXwx?=
 =?us-ascii?Q?W/qVGHMALYZcwbtIfJVstrsTsA7mthqpNdCEu6ZSLc29bXSRklQm8UJckrb3?=
 =?us-ascii?Q?4fXoloflJcYQCt45IYY7XxebSNCnUSTAelmauOWi2I0q4qEjSvIxPUNsuez+?=
 =?us-ascii?Q?EapLI7ZgpyYkmbBHf4OSETW6D6Uy4qOB8EboA0K60doGtUleJC/67qoBUf9x?=
 =?us-ascii?Q?qtRDyHKbumfAQ3l0d9syUgMeFkTt3P6ixlR3NYP7zi8dETSvPF7KV2y2XIGL?=
 =?us-ascii?Q?/e61VKMCgX/qnDeYdHErbym4EFPzKWtihxz+8mZOvQVg0OkAkEOc79581tZH?=
 =?us-ascii?Q?RidFkEYmjLePlys/9x6K5LghHOcfaKMpJrlgsabhNo+aMO9Ij+X9FQi4xeVg?=
 =?us-ascii?Q?j0Y07JRMTxN6kJd0tlEUKlsLyBLQnmx6cRKh03V9YY9HC+73zyQZFu+jDsno?=
 =?us-ascii?Q?wTEVXP5QgvYAhoF9Oos3G1KT90LXJ0vffH9xW5bodVX84xRz+5XgxzpvHtV7?=
 =?us-ascii?Q?4K13aSP300EqGkFn48Y9dGXFJ7IdrXsogdahQqUmQrOE9om26fte715CT38W?=
 =?us-ascii?Q?NX2jajl6vzxiAQ/O7mmGH46ZRrO8swfV6L73mu8xlpxI/8H0K1M4oJ9fcOtG?=
 =?us-ascii?Q?Ykk5nRXgl2OG+mM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:14:17.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 554b59fa-23bd-49a1-112a-08dd5ba493e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

- Fix some Replay/PSR issue
- Fix backlight brightness
- Fix suspend issue
- Fix visual confirm color
- Add scoped mutexes for amdgpu_dm_dhcp

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Assign normalized_pix_clk when color depth = 14

Charlene Liu (3):
  drm/amd/display: assume VBIOS supports DSC as default
  drm/amd/display: dml2 soc dscclk use DPM table clk setting.
  drm/amd/display: remove minimum Dispclk and apply oem panel timing.

Danny Wang (1):
  drm/amd/display: Do not enable replay when vtotal update is pending.

Dillon Varone (1):
  drm/amd/display: Add Support for reg inbox0 for host->DMUB CMDs

George Shen (1):
  drm/amd/display: Implement PCON regulated autonomous mode handling

Joshua Aberback (1):
  drm/amd/display: Add more debug data to dmub_srv

Leo Li (1):
  drm/amd/display: Disable unneeded hpd interrupts during dm_init

Leo Zeng (1):
  drm/amd/display: Fix visual confirm color not updating

Leon Huang (1):
  drm/amd/display: Fix incorrect DPCD configs while Replay/PSR switch

Mario Limonciello (6):
  drm/amd/display: fix default brightness
  drm/amd/display: Restore correct backlight brightness after a GPU
    reset
  drm/amd/display: Add and use new dm_prepare_suspend() callback
  drm/amd/display: Fix slab-use-after-free on hdcp_work
  drm/amd/display: Add scoped mutexes for amdgpu_dm_dhcp
  drm/amd/display: Drop unnecessary ret variable for enable_assr()

Peichen Huang (1):
  drm/amd/display: not abort link train when bw is low

Ryan Seto (1):
  drm/amd/display: Prevent VStartup Overflow

Taimur Hassan (1):
  drm/amd/display: Promote DAL to 3.2.324

Zhikai Zhai (1):
  drm/amd/display: calculate the remain segments for all pipes

Zhongwei Zhang (1):
  drm/amd/display: Correct timing_adjust_pending flag setting.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  43 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  64 ++--
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 -
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 272 ++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  17 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  10 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +
 .../dc/link/protocols/link_dp_capability.c    |  55 +++-
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 +
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link/protocols/link_edp_panel_control.c   |  25 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  42 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 143 +++++---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  49 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  85 ++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  93 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  98 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  93 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 218 ++++++++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 308 ++++++++++++------
 43 files changed, 1111 insertions(+), 696 deletions(-)

-- 
2.34.1

