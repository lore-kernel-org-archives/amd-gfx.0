Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C66E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE3C10EB4A;
	Tue,  3 Dec 2024 21:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RgzXKhWT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6DF10E111
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u396YUk9d1/sV7Q6q2SqII+6kj984MKzav4qOBeFZHEqUE7nqdMG+PvUao/u0l2IH1JFWqzoM96dnX4tfAoQ8OfviW6CpAWhb2/dKBbeaUIA9Nb/hISDj5koiuBzkjGOOVE4M2sTJK4EwXe66PwWNUy4mjBWuWrRtO+76VgC3N0YY3aTWsMXeM+p7DzvBQ9APpuc20SytrkfGwqVNvDSq7BmIX/EFkUTQvM+xJexB4s+Yn1TkSRbWHfGPy5MLlSD/nR1pQ8EsgSyiaErIjayX2n0UnYVcUdQjAcH4dgPba/SWHp9x/ti8RtmBJy/KdztCLilE30CsmSphakQO23ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvKM6yTGj1DzWsMX7iHDHrXCQvSuehtwmoXeAB5uHbk=;
 b=ykshyYBEwpuMFQuoU7qB0Q0QxcZeGUC0163LbMymkz4bju21s0V2RscMlXuR0YPgVduLnVt590EXgTTNtxsxpghr1y6flS2vhFr6b8WOrHyvnsJPl2UVQINr8Qtwtx4vJqDMnTsUmJF24sHBniH6q54StoQKfUJsm7wccxn1LzGapvb/f7E7Lut9hZp8nT6c7sScI1KSOiQ5O84vmZyUWP6Hxp/tc1FWNp9M4YVQCtmGCPrzA3esV3emU824nzlxA6DKiiIdU1VN6w+VAOIRHwcwWHFUvHMtuBDgxGG6Cq4ZLZfQPF64EYaFecVidA4TuxpNieq+Vc8Y370ZyZtkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvKM6yTGj1DzWsMX7iHDHrXCQvSuehtwmoXeAB5uHbk=;
 b=RgzXKhWTPEbHjqtFiDkMD54BEoXTRRcSlpsIxX8pHrRTc+zHfOsrO0A/2ifbqxY0UseFa1eVLb42J04VTxeE8OYhQh6AhijZG539tCCbLdL4KhTZU0zA82ddsykzoD3YkDRKjDiGClZ1yFTj5CaA5wgiOsd58AkSNM05CznUuiY=
Received: from BN9P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::17)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 21:41:22 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::8e) by BN9P220CA0012.outlook.office365.com
 (2603:10b6:408:13e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 21:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:20 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:20 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/19] DC Patches for 6 Dec 2024
Date: Tue, 3 Dec 2024 16:39:38 -0500
Message-ID: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 081ee7ab-b811-4be2-f0da-08dd13e33a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kBc4CXQ4GMGYbNXQRZhVwwnIT4Sr4YsEPukg7MM4FXM0Hmopv7F5JMN6ol5Z?=
 =?us-ascii?Q?b9vXHy5WmmjyBBycgrw1MGk3UrYnrjmR7Lbe78ee0sU1JhHhCd8X6BNniG3T?=
 =?us-ascii?Q?G8c9LLyaLLbbqUQEtY7Z13iI1AkOcu9HdeyW3cgjD07BpckcRBRZFAgS16je?=
 =?us-ascii?Q?yBOwOYuMQQKFFVeZFdzyzYvG7/TAHZDNznew7tn0r7Eti3dccn0hfStppgcz?=
 =?us-ascii?Q?F87fZXsD0bOCniGy1heZNb93h/r9aRLcZH8HcCgMg3bPC1XS6PVUM9++Qk88?=
 =?us-ascii?Q?fXoEyyQEx5Wh767VzEdiFA1t80y2XdiUU4zXd6nIQoooDQeX0winuds56dNL?=
 =?us-ascii?Q?Xeyq3kydE2PbSzQ0ql4L3h6hVqY7OdRW2YTPDGwYepyha9kfdRQ5C7NXJxtv?=
 =?us-ascii?Q?KAZnKc2Djus8DaBMH/NrTzFaKO9b4zo5TCAPaHgiXtJiKqvURUkeKGjlbK0z?=
 =?us-ascii?Q?K7vxt7t24phFg5FY/VxszIsdTSLJ+1sfOnfoWdL4UzMo30qbHCJ7vMK0Vxsh?=
 =?us-ascii?Q?rOwm6NytSbu+lgWxhSOqkjhE9UATskhCtRWYx2A2aVJc22iu4QrNsT3Wishx?=
 =?us-ascii?Q?y9AfKeGLgBrwGnGJuidATacBWnr6fyhMCYcTXambM8PXw7V+nVtyXfihxnJ7?=
 =?us-ascii?Q?7sJ3uaVH1MLsSnAHXl4zNAHXGlPLH2hxhbQtbVjsQ4dSQbQbnYGM/Ah5XmdK?=
 =?us-ascii?Q?aa1qtRgdCXurxzWmDAGqabBSqwHeeqNzEF2MsBeb6r1tIiQGKyV75mZFYUpW?=
 =?us-ascii?Q?7856HCqL97nePHZ8ucqTkW28N7J7xfY9Tx5ngUUh3hmRka+KpuqAnEiI9gR6?=
 =?us-ascii?Q?LVNsFM4fu1O7mSC/s9icB0aTLOjSsbXNByWdEveUbipe/ye7CbJ2xLMtBRQR?=
 =?us-ascii?Q?XexZxPDixL7qRxvrt8fj0/fo1rrk3f22mjl0PBa9f8ngi3VANCJjsdfKkTzJ?=
 =?us-ascii?Q?Qco+38WG/8s9vlFcVycOEjG8IdCoQt+hBST6BVaDMokQqc5DGs5jbnJ/FKpN?=
 =?us-ascii?Q?awCw5reATbE2wQbZX5MtYNbXyy0N7LsbzzAtuLGN7xg8HKaC3IX496pX60fF?=
 =?us-ascii?Q?ww0AtUXBvjLIf+MMsp2Hx+8c7ChadSL/cRmTShTiuBJIQF6SNYeJyozsEkF2?=
 =?us-ascii?Q?6lBLVgWZj6VSVUwDL9eP0bZ1oXdRmqK/VNazVZVqScpqRrp+51v6msdACjvE?=
 =?us-ascii?Q?LXgVif3Go6OJGIh/q/zQF+WAw8FCGLsNxbbT/BzlQSi8NFdIWCc8lvdS7LRW?=
 =?us-ascii?Q?TMUXlBRM3UAYrjUZfgXkBm4z9mcCFD0UghoBl/Wb21mhED8SsVov7Lb+jcrW?=
 =?us-ascii?Q?0oQE6IVJ9jb6rchdybPh+ql1ZrXhjGX8etDn7+eQt5zb3Vik9XmxlMJcqIXZ?=
 =?us-ascii?Q?Pplo0HmX+Q/xOK8Ncgdqmfi7scp9/1WH+G7f00cYlqy9acAC0T43Moug6kzD?=
 =?us-ascii?Q?Z62+ym1dQKRTE32lLcEaPEDWXGjdxfpG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:21.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ee7ab-b811-4be2-f0da-08dd13e33a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

    * Fix some regressions related to IPS2 and PSR Panel Replay
    * Bug fixes in DML
    * DMCUB debug improvements
    * Other refactors and improvements across multiple components

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

________________

Aric Cyr (1):
  drm/amd/display: 3.2.313

Ausef Yousof (1):
  drm/amd/display: Overwriting dualDPP UBF values before usage

Austin Zheng (1):
  drm/amd/display: DML21 Update Prefetch Calculations

Charlene Liu (1):
  drm/amd/display: update dcn351 used clock offset

Chris Park (1):
  drm/amd/display: Update color space, bias and scale programming
    sequence

Gabe Teeger (1):
  Revert "drm/amd/display: Revised for Replay Pseudo vblank"

Harry VanZyllDeJong (1):
  drm/amd/display: populate VABC support in DMCUB

Joshua Aberback (1):
  drm/amd/display: Refactor dcn31_panel_construct to avoid assert

Karthi Kandasamy (1):
  drm/amd/display: expose DCN401 HUBP functions

Leo Li (1):
  drm/amd/display: Make DMCUB tracebuffer debugfs chronological

Nicholas Kazlauskas (2):
  Revert "drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic"
  drm/amd/display: Fix DML2 out_states to match in_states for
    DCN35/DCN351

Peterson (1):
  drm/amd/display: Use resource_build_scaling_params for dcn20

Samson Tam (1):
  drm/amd/display: clean up SPL code

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.246.0

Wayne Lin (3):
  drm/amd/display: Adjust dc_stream_forward_crc_window to accept
    assignment of phy_id
  drm/amd/display: Fix phy id mapping issue for secure display
  drm/amd/display: Adjust secure_display_context data structure

Zhongwei (1):
  drm/amd/display: remove clearance code of force_ffu_mode flag in
    dmub_psr_copy_settings()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 327 ++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  26 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c | 140 ++++++++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 132 +++++--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 -
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   3 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  34 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  30 +-
 .../dc/dml2/display_mode_core_structs.h       |   6 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  11 +
 .../display/dc/dml2/dml2_translation_helper.c |  15 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  20 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 ++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  59 ++++
 .../dc/resource/dcn20/dcn20_resource.c        |  57 +--
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  71 ++--
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 154 ++++++---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 -
 .../amd/display/modules/power/power_helpers.c |   4 +-
 .../amd/display/modules/power/power_helpers.h |   2 +-
 35 files changed, 919 insertions(+), 300 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c

-- 
2.47.1

