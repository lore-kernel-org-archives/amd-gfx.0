Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87929FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A5210E69B;
	Wed, 15 Apr 2026 07:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYUsUOai";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDA910E699
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzUj71UmtzCFAWtKQ+ceWn0Df/XJYUdzCEQXs45zLmNpfjjt8J1ryd9vz8CgoGfUmQmtd28G9L/zPKo2Q3mpnaZgMpw7k5fDMZ3Q+bf7bFppjAPEFUVOA9KEhygqrx6gT2G4kQIn/2npSq/Qc3MS4CmrSfFM+zdQBDHFqM5yI+bgo7fQ0UfVzFwjtb3+pOUwv8OZQLslwxQONJGWAKijy3ehDIQCuLKeXplQW1kSjxWJLO6hzd2d2eVrfhOyskHmAJr6Hv8ZEg638lTNFVtWGCtGQjWcWVBXZsCB0eK88+l1G9E19XMXXFQGYyTtcPl486fmQIbAuMVbQ2wacWXoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLx/uldZFOYtosQ+IOOTvnU9m1DW3GUVPcNFJQdqqLE=;
 b=fIy1t9342lnRVYI8yMhl9LLSBuYSwJrq7GCTXR/VMf8fd69ZwJ8s35/0CcjqzAOvFfSLfUsqbeUhVpezWJN5WSTDwovOSiKoSVqPPfRevXcj6VJxytK3JaGf/kVf/UGvqy84VKnDk+P16J+yEBbAjBsu8mOJ+PTkv7/XzZfU4orgdVUEVwi8LlhKeWlw8Fe0kG3LDGFFgaF+ZJYa7gTRYn69/yGk3uRlapFzAvFEdzCB7rCb9equfIb5rvkN1ung6nvG9AR2UonzW+h2JnQvIp+fBskXPumSp2DM10pCdiJksm2+48+xjOMSu1Z4Qc6COfWCJxsgfKM2pQo6K8U2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLx/uldZFOYtosQ+IOOTvnU9m1DW3GUVPcNFJQdqqLE=;
 b=ZYUsUOaiQhEbxOhpk+pbTOw9RSWV5DLcfb9v3nAqUwv+dfto/tBv9UsXsKF6bVb+MBLXGSQViFlWqFtJT4ofRQK9OfzqjVVfiXXytrKt1nzvUHU9vX30QaHHJaaLOUs0apLZAlvX7iD6IxevLyWKJAF/xz1vqqgpCFPCrfaZwjE=
Received: from MN2PR04CA0033.namprd04.prod.outlook.com (2603:10b6:208:d4::46)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:43:18 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::d8) by MN2PR04CA0033.outlook.office365.com
 (2603:10b6:208:d4::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 00:43:15 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:12 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 06/19] drm/amd/display: Fix implicit narrowing conversion
 warnings
Date: Wed, 15 Apr 2026 15:39:45 +0800
Message-ID: <20260415074223.34848-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: e9569f4c-3aac-4b31-c807-08de9ac2a8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|10086099003|20052099010|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xA9NrMKI4O8dEpKvspSsiBozRTqaQ758h4NB142DD14Gr8joB/iz+mBB2e0aimymrfndDpB1HUbWkyexpcDwJmeEit7Bt8Cq2dzYqBDBSy6pgeZKtGwIkPiZzLj3srAKHD5IY1EKezOhByd8koK4IYfcgH7EH1cHkL4smB5/o2wHmyQaM1xBGDEQCiPVrffexiqbAAFqeII+I5u9A9DdD0FA5TipvlAXkYDI+HupGu7Ndp6OV4+6rvpkyxIqx6MsCb3Wm6byrR5Jr2yZv8W6TsUaRjYpWmF74w3YlbsU3qwpcUTkpru8RPMR4dDCiVED2vsTPEkcSY3lBvzrR5s3Pd6YsRXGanG8kJqrZODyDl3jmpwSUF6579iy6vtoytW7IJoxHyGh97wRK8sf2sAXv96aEZDE90bd735Ma/y3EM1YG/MmxxV9iE+CJ1nG/RzQ8wP2Lo0J/ue+r5KGZ2tT3dt9a0OflE57/zlDktPH6sJvYAV0ezG4hlTYS1+o9ZXmygMGJ6EdV4Qpox5n300OjnRsk5mnRZAS4l65rvUTtESEr6HLY1/+HjSRB3Auto9rEsUv/5Cu/I9GJ/ubhbTEe2wOdIkAbl3xvgnlntNnyLrQ38XYAXD7DlUWC5FIBfuA2lt8uYqVBpQp38bkDe/5s4LQX74VOMMFPFOBulOg8VTY77CuathWNHqDMSJOWureuLxEBa8xiL1hxMhQ/56xCSarpy9G8N0r2Mm1CP8BkwgT6PbhwCxamXKjlZkHOxC270QR56k8XD6YAv7a2QrbGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(10086099003)(20052099010)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FAYs+qurMDi9gip6TKLUBtNd3FP5cwkaRA9ZOtR6fbIlxVQ/6ESydsoyt7mOAl7PdiU6QEFcu6ey0s+KVkYaEKO6cQ8m/wbOsACtBLgwIbnmthpNXuNh4ApgBZs6VFB4D/lnrAc9vf3r6HjxaURENEYvHfnQ8LNMuye2umSUOWOa3IPQhSYTp52v/VreHD6NN/feb6dAwY9m9aWpBx9qAjDdjFsndMWhh1YEG3W5RJZL98hda7cXrryOvAetkC4f+qeqrFa6NgQdyUi0wRqrbL/UB2KkbZ4OhS5j9aXUoPl8BZ28CLflK963hKLRRSLSDrfQ5OeQzu1/O+1RNQgYCbIUjHaY82yBxBmTX43orgY7eDKw3vHMI2+/2ZK99M9wYjlehs4ao2s6Femp821lx+jgLoocFP79G62pviiAJOsbCb8T0ZdSORwW+DKOqcSx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:17.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9569f4c-3aac-4b31-c807-08de9ac2a8a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Multiple display source files contain implicit narrowing
conversions when assigning wider integer types (int, uint32_t)
to narrower fields (uint8_t, uint16_t) at hardware register,
protocol, and storage boundaries. These conversions are
intentional but undocumented, and accompanying runtime assertions
add noise without providing compile-time safety.

[How]
Add explicit casts at all intentional narrowing boundaries across
display source files. Use narrower loop variable types where loop
bounds guarantee safe range. Remove runtime assertions paired
with narrowing casts, inline single-use intermediate variables,
and revert block scopes and braces introduced solely to contain
those assertions.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/basics/custom_float.c  |   2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   2 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   6 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  20 +--
 .../drm/amd/display/dc/bios/command_table.c   |  12 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   9 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  39 +++---
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  11 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  12 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  13 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  13 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  43 +++---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  14 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  40 +++---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  68 ++++-----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  90 ++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  52 +++----
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  20 ++-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 130 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  12 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   4 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   4 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  24 ++--
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   2 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |   4 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |   8 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  14 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  12 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  23 ++--
 .../display/dc/dce80/dce80_timing_generator.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |  16 +--
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   2 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |   4 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   5 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   7 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  37 ++---
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  12 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |  30 ++--
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |   2 +-
 .../gpu/drm/amd/display/dc/gpio/hw_generic.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |   2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h |   9 ++
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |   2 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |  16 +--
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |  28 ++--
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |   3 +
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |  12 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  12 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  12 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  29 ++--
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |  12 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  16 +--
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  18 ++-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |  37 +----
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   4 +-
 .../drm/amd/display/dc/link/link_detection.c  |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../drm/amd/display/dc/link/link_factory.c    |   6 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |   5 +-
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   4 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |  23 ++--
 .../link/protocols/link_dp_training_8b_10b.c  |  10 +-
 .../link/protocols/link_edp_panel_control.c   |  38 ++---
 .../dc/mmhubbub/dcn20/dcn20_mmhubbub.c        |   4 +-
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.c        |   4 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   4 +-
 .../dc/resource/dce110/dce110_resource.c      |   4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   4 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  24 ++--
 .../dc/resource/dcn21/dcn21_resource.c        |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  14 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   8 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   4 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   4 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   4 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  20 +--
 .../dc/resource/dcn321/dcn321_resource.c      |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   4 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |  28 ++--
 .../dcn42/dcn42_soc_and_ip_translator.c       |  14 +-
 107 files changed, 733 insertions(+), 704 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/custom_float.c b/drivers/gpu/drm/amd/display/dc/basics/custom_float.c
index ae05ded9a7f3..d313584335d3 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/custom_float.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/custom_float.c
@@ -90,7 +90,7 @@ static bool build_custom_float(struct fixed31_32 value,
 	    dc_fixpt_lt(dc_fixpt_one, mantiss))
 		mantiss = dc_fixpt_zero;
 	else
-		mantiss = dc_fixpt_shl(mantiss, format->mantissa_bits);
+		mantiss = dc_fixpt_shl(mantiss, (unsigned char)format->mantissa_bits);
 
 	*mantissa = dc_fixpt_floor(mantiss);
 
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index 070195c5393e..fd19b6470628 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -3078,7 +3078,7 @@ bool bw_calcs(struct dc_context *ctx,
 		}
 		calculate_bandwidth(dceip, vbios, data);
 
-		yclk_lvl = data->y_clk_level;
+		yclk_lvl = (uint8_t)data->y_clk_level;
 
 		calcs_output->nbp_state_change_enable =
 			data->nbp_state_change_enable;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 7fcba9f3c5af..25c94962e141 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -803,8 +803,8 @@ static enum bp_result bios_parser_dac_load_detection(
 	uint32_t bios_0_scratch;
 	uint32_t device_id_mask = 0;
 
-	bp_params.device_id = get_support_mask_for_device_id(
-		DEVICE_TYPE_CRT, engine_id == ENGINE_ID_DACB ? 2 : 1);
+	bp_params.device_id = (uint16_t)get_support_mask_for_device_id(
+			DEVICE_TYPE_CRT, engine_id == ENGINE_ID_DACB ? 2 : 1);
 
 	if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
 		device_id_mask = ATOM_S0_CRT1_MASK;
@@ -1382,7 +1382,7 @@ static enum bp_result get_embedded_panel_info_v1_2(
 	info->ss_id = lvds->ucSS_Id;
 
 	{
-		uint8_t rr = le16_to_cpu(lvds->usSupportedRefreshRate);
+		uint16_t rr = le16_to_cpu(lvds->usSupportedRefreshRate);
 		/* Get minimum supported refresh rate*/
 		if (SUPPORTED_LCD_REFRESHRATE_30Hz & rr)
 			info->supported_rr.REFRESH_RATE_30HZ = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index d2fb9c0162e5..dd45cc170fc7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -157,7 +157,7 @@ static uint8_t bios_parser_get_connectors_number(struct dc_bios *dcb)
 
 		break;
 	}
-	return count;
+	return (uint8_t)count;
 }
 
 static struct graphics_object_id bios_parser_get_connector_id(
@@ -401,7 +401,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 		return BP_RESULT_BADINPUT;
 
 	if (id.type == OBJECT_TYPE_GENERIC) {
-		dummy_record.i2c_id = id.id;
+		dummy_record.i2c_id = (uint8_t)id.id;
 
 		if (get_gpio_i2c_info(bp, &dummy_record, info) == BP_RESULT_OK)
 			return BP_RESULT_OK;
@@ -1228,7 +1228,7 @@ static enum bp_result get_disp_caps_v4_1(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = disp_cntl_tbl->display_caps;
+	*dce_caps = (uint8_t)disp_cntl_tbl->display_caps;
 
 	return result;
 }
@@ -1252,7 +1252,7 @@ static enum bp_result get_disp_caps_v4_2(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = disp_cntl_tbl->display_caps;
+	*dce_caps = (uint8_t)disp_cntl_tbl->display_caps;
 
 	return result;
 }
@@ -1276,7 +1276,7 @@ static enum bp_result get_disp_caps_v4_3(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = disp_cntl_tbl->display_caps;
+	*dce_caps = (uint8_t)disp_cntl_tbl->display_caps;
 
 	return result;
 }
@@ -1300,7 +1300,7 @@ static enum bp_result get_disp_caps_v4_4(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = disp_cntl_tbl->display_caps;
+	*dce_caps = (uint8_t)disp_cntl_tbl->display_caps;
 
 	return result;
 }
@@ -1324,7 +1324,7 @@ static enum bp_result get_disp_caps_v4_5(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = disp_cntl_tbl->display_caps;
+	*dce_caps = (uint8_t)disp_cntl_tbl->display_caps;
 
 	return result;
 }
@@ -2585,7 +2585,7 @@ static enum bp_result get_integrated_info_v11(
 		info->ext_disp_conn_info.path[i].channel_mapping.raw =
 			info_v11->extdispconninfo.path[i].channelmapping;
 		info->ext_disp_conn_info.path[i].caps =
-				le16_to_cpu(info_v11->extdispconninfo.path[i].caps);
+				(unsigned short)le16_to_cpu(info_v11->extdispconninfo.path[i].caps);
 	}
 	info->ext_disp_conn_info.checksum =
 	info_v11->extdispconninfo.checksum;
@@ -2790,7 +2790,7 @@ static enum bp_result get_integrated_info_v2_1(
 		info->ext_disp_conn_info.path[i].channel_mapping.raw =
 			info_v2_1->extdispconninfo.path[i].channelmapping;
 		info->ext_disp_conn_info.path[i].caps =
-				le16_to_cpu(info_v2_1->extdispconninfo.path[i].caps);
+				(unsigned short)le16_to_cpu(info_v2_1->extdispconninfo.path[i].caps);
 	}
 
 	info->ext_disp_conn_info.checksum =
@@ -2954,7 +2954,7 @@ static enum bp_result get_integrated_info_v2_2(
 		info->ext_disp_conn_info.path[i].channel_mapping.raw =
 			info_v2_2->extdispconninfo.path[i].channelmapping;
 		info->ext_disp_conn_info.path[i].caps =
-				le16_to_cpu(info_v2_2->extdispconninfo.path[i].caps);
+				(unsigned short)le16_to_cpu(info_v2_2->extdispconninfo.path[i].caps);
 	}
 
 	info->ext_disp_conn_info.checksum =
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index f6e22dcecf29..0df84394a325 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1521,8 +1521,8 @@ static enum bp_result adjust_display_pll_v2(
 
 		if (pixel_clock_10KHz_in != 0) {
 			bp_params->adjusted_pixel_clock =
-					div_u64(pixel_clk * pixel_clk_10_khz_out,
-							pixel_clock_10KHz_in);
+					(uint32_t)div_u64(pixel_clk * pixel_clk_10_khz_out,
+							  pixel_clock_10KHz_in);
 		} else {
 			bp_params->adjusted_pixel_clock = 0;
 			BREAK_TO_DEBUGGER();
@@ -1571,8 +1571,8 @@ static enum bp_result adjust_display_pll_v3(
 
 		if (pixel_clk_10_kHz_in != 0) {
 			bp_params->adjusted_pixel_clock =
-					div_u64(pixel_clk * pixel_clk_10_khz_out,
-							pixel_clk_10_kHz_in);
+					(uint32_t)div_u64(pixel_clk * pixel_clk_10_khz_out,
+							  pixel_clk_10_kHz_in);
 		} else {
 			bp_params->adjusted_pixel_clock = 0;
 			BREAK_TO_DEBUGGER();
@@ -2662,8 +2662,8 @@ static enum bp_result set_dce_clock_v2_1(
 			!cmd->dc_clock_type_to_atom(bp_params->clock_type, &atom_clock_type))
 		return BP_RESULT_BADINPUT;
 
-	params.asParam.ucDCEClkSrc  = atom_pll_id;
-	params.asParam.ucDCEClkType = atom_clock_type;
+	params.asParam.ucDCEClkSrc = (uint8_t)atom_pll_id;
+	params.asParam.ucDCEClkType = (uint8_t)atom_clock_type;
 
 	if (bp_params->clock_type == DCECLOCK_TYPE_DPREFCLK) {
 		if (bp_params->flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK)
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 17ef515c6c69..88625daf5378 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -929,8 +929,8 @@ static enum bp_result set_dce_clock_v2_1(
 					&atom_clock_type))
 		return BP_RESULT_BADINPUT;
 
-	params.param.dceclksrc  = atom_pll_id;
-	params.param.dceclktype = atom_clock_type;
+	params.param.dceclksrc = (uint8_t)atom_pll_id;
+	params.param.dceclktype = (uint8_t)atom_clock_type;
 
 	if (bp_params->clock_type == DCECLOCK_TYPE_DPREFCLK) {
 		if (bp_params->flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index cd4c45516616..13296c6ec08f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -127,7 +127,7 @@ void dce110_fill_display_configs(
 	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
 	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
 	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
-	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+	pp_display_cfg->crtc_index = (uint8_t)dc->res_pool->res_cap->num_timing_generator;
 
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
@@ -151,7 +151,7 @@ void dce110_fill_display_configs(
 
 		num_cfgs++;
 		cfg->signal = pipe_ctx->stream->signal;
-		cfg->pipe_idx = pipe_ctx->stream_res.tg->inst;
+		cfg->pipe_idx = (uint8_t)pipe_ctx->stream_res.tg->inst;
 		cfg->src_height = stream->src.height;
 		cfg->src_width = stream->src.width;
 		cfg->ddi_channel_mapping =
@@ -189,7 +189,7 @@ void dce110_fill_display_configs(
 		pp_display_cfg->line_time_in_us = 0;
 	}
 
-	pp_display_cfg->display_count = num_cfgs;
+	pp_display_cfg->display_count = (uint8_t)num_cfgs;
 }
 
 void dce11_pplib_apply_display_requirements(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 09e83097a623..79eb5ae8ec6f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -462,8 +462,10 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		ranges->reader_wm_sets[num_valid_sets].wm_inst = bw_params->wm_table.entries[i].wm_inst;
-		ranges->reader_wm_sets[num_valid_sets].wm_type = bw_params->wm_table.entries[i].wm_type;
+		ranges->reader_wm_sets[num_valid_sets].wm_inst =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		ranges->reader_wm_sets[num_valid_sets].wm_type =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		ranges->reader_wm_sets[num_valid_sets].min_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 		ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
@@ -476,7 +478,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 				/* add 1 to make it non-overlapping with next lvl */
 				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
-			ranges->reader_wm_sets[num_valid_sets].max_drain_clk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+			ranges->reader_wm_sets[num_valid_sets].max_drain_clk_mhz =
+				(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index c7c849b04a50..bf7f92fd41d7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -78,9 +78,9 @@ static const struct clk_mgr_mask clk_mgr_mask = {
 
 
 /* Query SMU for all clock states for a particular clock */
-static void dcn3_init_single_clock(struct clk_mgr_internal *clk_mgr, uint32_t clk, unsigned int *entry_0, unsigned int *num_levels)
+static void dcn3_init_single_clock(struct clk_mgr_internal *clk_mgr, uint32_t clk, unsigned int *entry_0, uint8_t *num_levels)
 {
-	unsigned int i;
+	uint8_t i;
 	char *entry_i = (char *)entry_0;
 	uint32_t ret = dcn30_smu_get_dpm_freq_by_index(clk_mgr, clk, 0xFF);
 
@@ -109,7 +109,7 @@ static void dcn3_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 void dcn3_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	unsigned int num_levels;
+	uint8_t num_levels;
 
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
@@ -234,7 +234,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCEFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCEFCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
@@ -265,10 +265,11 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 			if (dc->clk_mgr->dc_mode_softmax_enabled &&
 				new_clocks->dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+					(uint16_t)dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 			else
 				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+					(uint16_t)clk_mgr_base->bw_params->clk_table.entries[
+						clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 		}
 	}
 
@@ -281,20 +282,20 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 	if (clk_mgr_base->clks.p_state_change_support &&
 			(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
 		if (clk_mgr_base->clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
 
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PIXCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PIXCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
 		update_dispclk = true;
 	}
 
@@ -323,7 +324,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 
 static void dcn3_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
-	unsigned int i;
+	uint8_t i;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	WatermarksExternal_t *table = (WatermarksExternal_t *) clk_mgr->wm_range_table;
 
@@ -363,13 +364,14 @@ static void dcn3_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current_
 	if (current_mode) {
 		if (clk_mgr_base->clks.p_state_change_support)
 			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+					(uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+					(uint16_t)clk_mgr_base->bw_params->clk_table.entries[
+							clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 	} else {
 		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
+				(uint16_t)clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
 	}
 }
 
@@ -382,7 +384,8 @@ static void dcn3_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
 		return;
 
 	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
-			clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+			(uint16_t)clk_mgr_base->bw_params->clk_table.entries[
+				clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 }
 
 static void dcn3_set_max_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
@@ -392,7 +395,7 @@ static void dcn3_set_max_memclk(struct clk_mgr *clk_mgr_base, unsigned int memcl
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)memclk_mhz);
 }
 static void dcn3_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
 {
@@ -400,14 +403,14 @@ static void dcn3_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memcl
 
 	if (!clk_mgr->smu_present)
 		return;
-	dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+	dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)memclk_mhz);
 }
 
 /* Get current memclk states, update bounding box */
 static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	unsigned int num_levels;
+	uint8_t num_levels;
 
 	if (!clk_mgr->smu_present)
 		return;
@@ -480,7 +483,7 @@ static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct d
 
 	if (max_phyclk_req != clk_mgr_base->clks.phyclk_khz) {
 		clk_mgr_base->clks.phyclk_khz = max_phyclk_req;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, khz_to_mhz_ceil(clk_mgr_base->clks.phyclk_khz));
+		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_PHYCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.phyclk_khz));
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 57ba7bc4d16e..caa15cfba7c3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -385,7 +385,7 @@ static void vg_init_clocks(struct clk_mgr *clk_mgr)
 
 static void vg_build_watermark_ranges(struct clk_bw_params *bw_params, struct watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -394,8 +394,11 @@ static void vg_build_watermark_ranges(struct clk_bw_params *bw_params, struct wa
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -409,7 +412,7 @@ static void vg_build_watermark_ranges(struct clk_bw_params *bw_params, struct wa
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 89fc482947ef..1d94c4bae9de 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -114,7 +114,7 @@ static int dcn31_get_active_display_cnt_wa(
 static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int i;
+	uint8_t i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -424,7 +424,7 @@ static struct dcn31_watermarks dummy_wms = { 0 };
 
 static void dcn31_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn31_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -433,8 +433,10 @@ static void dcn31_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -448,7 +450,7 @@ static void dcn31_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index b08a70a2f571..1814ec248dab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -149,7 +149,7 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 				  bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int i;
+	uint8_t i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *pipe = safe_to_lower
@@ -495,7 +495,7 @@ static struct dcn314_ss_info_table ss_info_table = {
 
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -504,8 +504,10 @@ static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -519,7 +521,7 @@ static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 3a651c1a866d..382e1b891c47 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -100,7 +100,7 @@ static bool should_disable_otg(struct pipe_ctx *pipe)
 static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int i;
+	uint8_t i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -384,7 +384,7 @@ static struct dcn315_watermarks dummy_wms = { 0 };
 
 static void dcn315_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn315_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -393,8 +393,11 @@ static void dcn315_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -408,7 +411,7 @@ static void dcn315_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index e9d492d8c8d4..a162a453447c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -103,7 +103,7 @@ static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int i;
+	uint8_t i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 		struct pipe_ctx *pipe = safe_to_lower
@@ -350,7 +350,7 @@ static struct dcn316_watermarks dummy_wms = { 0 };
 
 static void dcn316_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn316_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -359,8 +359,11 @@ static void dcn316_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -374,7 +377,7 @@ static void dcn316_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index f427154a54f8..8773a8321735 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -132,7 +132,7 @@ static const struct clk_mgr_mask clk_mgr_mask_dcn321 = {
 static void dcn32_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, unsigned int *entry_0,
 		unsigned int *num_levels)
 {
-	unsigned int i;
+	uint8_t i;
 	char *entry_i = (char *)entry_0;
 
 	uint32_t ret = dcn30_smu_get_dpm_freq_by_index(clk_mgr, clk, 0xFF);
@@ -409,7 +409,7 @@ static void dcn32_update_clocks_update_dentist(
 			 * floored in Mhz to describe the intended clock.
 			 */
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK,
-					khz_to_mhz_floor(temp_dispclk_khz));
+					(uint16_t)khz_to_mhz_floor(temp_dispclk_khz));
 
 		if (dc->debug.override_dispclk_programming) {
 			REG_GET(DENTIST_DISPCLK_CNTL,
@@ -456,7 +456,7 @@ static void dcn32_update_clocks_update_dentist(
 		 * floored in Mhz to describe the intended clock.
 		 */
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK,
-				khz_to_mhz_floor(clk_mgr->base.clks.dispclk_khz));
+				(uint16_t)khz_to_mhz_floor(clk_mgr->base.clks.dispclk_khz));
 
 	if (dc->debug.override_dispclk_programming) {
 		REG_GET(DENTIST_DISPCLK_CNTL,
@@ -680,7 +680,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz) &&
 				!dc->work_arounds.clock_update_disable_mask.dcfclk) {
 			clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 		}
 
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz) &&
@@ -715,13 +715,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					 * frequency.
 					 */
 					if (dc->debug.disable_dc_mode_overwrite) {
-						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
-						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)dc->clk_mgr->bw_params->max_memclk_mhz);
 					} else
 						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-								dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+								(uint16_t)dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 				} else {
-					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)dc->clk_mgr->bw_params->max_memclk_mhz);
 				}
 			}
 		}
@@ -755,9 +755,10 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 				!dc->work_arounds.clock_update_disable_mask.uclk) {
 			if (dc->clk_mgr->dc_mode_softmax_enabled && dc->debug.disable_dc_mode_overwrite)
 				dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
-						max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
+						(uint16_t)max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk,
+								khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
 
-			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		}
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
@@ -783,7 +784,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			 * floored in Mhz to describe the intended clock.
 			 */
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK,
-					khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
+					(uint16_t)khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
 
 		update_dppclk = true;
 	}
@@ -803,7 +804,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000)) {
 		/* DCCG requires KHz precision for DTBCLK */
 		clk_mgr_base->clks.ref_dtbclk_khz =
-				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
+				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, (uint16_t)khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
 
 		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 	}
@@ -822,7 +823,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 				 * floored in Mhz to describe the intended clock.
 				 */
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK,
-						khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
+						(uint16_t)khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
@@ -968,7 +969,7 @@ static void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
 }
 static void dcn32_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
-	unsigned int i;
+	uint8_t i;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	WatermarksExternal_t *table = (WatermarksExternal_t *) clk_mgr->wm_range_table;
 
@@ -1002,13 +1003,13 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 	if (current_mode) {
 		if (clk_mgr_base->clks.p_state_change_support)
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+					(uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->max_memclk_mhz);
+					(uint16_t)clk_mgr_base->bw_params->max_memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
+				(uint16_t)clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
 	}
 }
 
@@ -1020,7 +1021,7 @@ static void dcn32_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, clk_mgr_base->bw_params->max_memclk_mhz);
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)clk_mgr_base->bw_params->max_memclk_mhz);
 }
 
 /* Get current memclk states, update bounding box */
@@ -1052,7 +1053,7 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 
 	clk_mgr_base->bw_params->max_memclk_mhz =
 			clk_mgr_base->bw_params->clk_table.entries[num_entries_per_clk->num_memclk_levels - 1].memclk_mhz;
-	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
+	clk_mgr_base->bw_params->clk_table.num_entries = (uint8_t)(num_levels ? num_levels : 1);
 
 	if (clk_mgr->dpm_present && !num_levels)
 		clk_mgr->dpm_present = false;
@@ -1109,7 +1110,7 @@ static void dcn32_set_max_memclk(struct clk_mgr *clk_mgr_base, unsigned int memc
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)memclk_mhz);
 }
 
 static void dcn32_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
@@ -1119,7 +1120,7 @@ static void dcn32_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memc
 	if (!clk_mgr->smu_present)
 		return;
 
-	dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+	dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, (uint16_t)memclk_mhz);
 }
 
 static struct clk_mgr_funcs dcn32_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 2798088842f4..688a4bdc20b5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -190,7 +190,7 @@ void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context
 		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int i;
+	uint8_t i;
 
 	if (dc->ctx->dce_environment == DCE_ENV_DIAG)
 		return;
@@ -332,7 +332,7 @@ static uint8_t get_lowest_dpia_index(const struct dc_link *link)
 			continue;
 
 		if (idx > dc_struct->links[i]->link_index)
-			idx = dc_struct->links[i]->link_index;
+			idx = (uint8_t)dc_struct->links[i]->link_index;
 	}
 
 	return idx;
@@ -863,7 +863,7 @@ static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
 
 static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn35_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -872,8 +872,10 @@ static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -887,7 +889,7 @@ static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index fa284523d8a4..2b7718336135 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -174,7 +174,7 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 
 	/* if the initial message failed, num_levels will be 0 */
 	for (i = 0; i < *num_levels && i < ARRAY_SIZE(clk_mgr->base.bw_params->clk_table.entries); i++) {
-		*((unsigned int *)entry_i) = (dcn401_smu_get_dpm_freq_by_index(clk_mgr, clk, i) & 0xFFFF);
+		*((unsigned int *)entry_i) = (dcn401_smu_get_dpm_freq_by_index(clk_mgr, clk, (uint8_t)i) & 0xFFFF);
 		entry_i += sizeof(clk_mgr->base.bw_params->clk_table.entries[0]);
 	}
 }
@@ -182,15 +182,15 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 static void dcn401_build_wm_range_table(struct clk_mgr *clk_mgr)
 {
 	/* For min clocks use as reported by PM FW and report those as min */
-	uint16_t min_uclk_mhz = clk_mgr->bw_params->clk_table.entries[0].memclk_mhz;
-	uint16_t min_dcfclk_mhz	= clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
+	unsigned int min_uclk_mhz = clk_mgr->bw_params->clk_table.entries[0].memclk_mhz;
+	unsigned int min_dcfclk_mhz = clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
 
 	/* Set A - Normal - default values */
 	clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid = true;
 	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = (uint16_t)min_dcfclk_mhz;
 	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = (uint16_t)min_uclk_mhz;
 	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
 
 	/* Set B - Unused on dcn4 */
@@ -201,9 +201,9 @@ static void dcn401_build_wm_range_table(struct clk_mgr *clk_mgr)
 	if (clk_mgr->ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
 		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = true;
 		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_dcfclk = (uint16_t)min_dcfclk_mhz;
 		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_uclk = min_uclk_mhz;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_uclk = (uint16_t)min_uclk_mhz;
 		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_uclk = 0xFFFF;
 	} else {
 		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = false;
@@ -604,10 +604,10 @@ static int dcn401_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mg
 	 * clock returned is less than requested, then we will ceil the
 	 * requested value to mhz and call it again.
 	 */
-	int actual_clk_khz = dcn401_smu_set_hard_min_by_freq(clk_mgr, clk, khz_to_mhz_floor(requested_clk_khz));
+	int actual_clk_khz = dcn401_smu_set_hard_min_by_freq(clk_mgr, clk, (uint16_t)khz_to_mhz_floor(requested_clk_khz));
 
 	if (actual_clk_khz < requested_clk_khz)
-		actual_clk_khz = dcn401_smu_set_hard_min_by_freq(clk_mgr, clk, khz_to_mhz_ceil(requested_clk_khz));
+		actual_clk_khz = dcn401_smu_set_hard_min_by_freq(clk_mgr, clk, (uint16_t)khz_to_mhz_ceil(requested_clk_khz));
 
 	return actual_clk_khz;
 }
@@ -849,7 +849,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
 			block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DCFCLK;
-			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz);
+			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz);
 			block_sequence[num_steps].params.update_hardmin_params.response = NULL;
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
 			num_steps++;
@@ -860,7 +860,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
-			block_sequence[num_steps].params.update_deep_sleep_dcfclk_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz);
+			block_sequence[num_steps].params.update_deep_sleep_dcfclk_params.freq_mhz = (uint16_t)khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK;
 			num_steps++;
 		}
@@ -984,24 +984,24 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	/* When idle DPM is enabled, need to send active and idle hardmins separately */
 	/* CLK_MGR401_UPDATE_ACTIVE_HARDMINS */
 	if ((update_active_uclk || update_active_fclk) && is_idle_dpm_enabled) {
-		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = active_uclk_mhz;
-		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = active_fclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = (uint16_t)active_uclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = (uint16_t)active_fclk_mhz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_ACTIVE_HARDMINS;
 		num_steps++;
 	}
 
 	/* CLK_MGR401_UPDATE_IDLE_HARDMINS */
 	if ((update_idle_uclk || update_idle_fclk) && is_idle_dpm_enabled) {
-		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
-		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = (uint16_t)idle_uclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = (uint16_t)idle_fclk_mhz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
 		num_steps++;
 	}
 
 	/* CLK_MGR401_UPDATE_SUBVP_HARDMINS */
 	if ((update_subvp_prefetch_dramclk || update_subvp_prefetch_fclk) && is_df_throttle_opt_enabled) {
-		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = subvp_prefetch_dramclk_mhz;
-		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = subvp_prefetch_fclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = (uint16_t)subvp_prefetch_dramclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = (uint16_t)subvp_prefetch_fclk_mhz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_SUBVP_HARDMINS;
 		num_steps++;
 	}
@@ -1010,7 +1010,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	if (update_active_uclk || update_idle_uclk) {
 		if (!is_idle_dpm_enabled) {
 			block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
-			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
+			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = (uint16_t)active_uclk_mhz;
 			block_sequence[num_steps].params.update_hardmin_params.response = NULL;
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
 			num_steps++;
@@ -1123,7 +1123,7 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK)) {
 		/* DCCG requires KHz precision for DTBCLK */
 		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
-		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
+		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = (uint16_t)khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
 		block_sequence[num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
 		num_steps++;
@@ -1318,7 +1318,7 @@ static void dcn401_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 	/* collect valid ranges, place in pmfw table */
 	for (i = 0; i < WM_SET_COUNT; i++)
 		if (clk_mgr->base.bw_params->wm_table.nv_entries[i].valid) {
-			table->Watermarks.WatermarkRow[i].WmSetting = i;
+			table->Watermarks.WatermarkRow[i].WmSetting = (uint8_t)i;
 			table->Watermarks.WatermarkRow[i].Flags = clk_mgr->base.bw_params->wm_table.nv_entries[i].pmfw_breakdown.wm_type;
 		}
 	dcn401_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 6a97ce69a562..72b0f3f8c2fd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -634,7 +634,7 @@ static void dcn42_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
 
 void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_watermarks *table)
 {
-	int i, num_valid_sets;
+	uint8_t i, num_valid_sets;
 
 	num_valid_sets = 0;
 
@@ -643,8 +643,10 @@ void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_
 		if (!bw_params->wm_table.entries[i].valid)
 			continue;
 
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting = bw_params->wm_table.entries[i].wm_inst;
-		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType = bw_params->wm_table.entries[i].wm_type;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmSetting =
+			(uint8_t)bw_params->wm_table.entries[i].wm_inst;
+		table->WatermarkRow[WM_DCFCLK][num_valid_sets].WmType =
+			(uint8_t)bw_params->wm_table.entries[i].wm_type;
 		/* We will not select WM based on fclk, so leave it as unconstrained */
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinClock = 0;
 		table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
@@ -658,7 +660,7 @@ void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_
 						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
-					bw_params->clk_table.entries[i].dcfclk_mhz;
+					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
 
 		} else {
 			/* unconstrained for memory retraining */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 534f770949d5..9ff5503d4df7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -235,7 +235,7 @@ static bool create_links(
 	 *   variants of the same card.
 	 */
 	for (i = 0; dc->link_count < connectors_num && i < MAX_LINKS; i++) {
-		struct graphics_object_id connector_id = bios->funcs->get_connector_id(bios, i);
+		struct graphics_object_id connector_id = bios->funcs->get_connector_id(bios, (uint8_t)i);
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
 
@@ -246,7 +246,7 @@ static bool create_links(
 
 		link_init_params.ctx = dc->ctx;
 		/* next BIOS object table connector */
-		link_init_params.connector_index = i;
+		link_init_params.connector_index = (uint8_t)i;
 		link_init_params.link_index = dc->link_count;
 		link_init_params.dc = dc;
 		link = dc->link_srv->create_link(&link_init_params);
@@ -267,7 +267,7 @@ static bool create_links(
 		struct dc_link *link;
 
 		link_init_params.ctx = dc->ctx;
-		link_init_params.connector_index = i;
+		link_init_params.connector_index = (uint8_t)i;
 		link_init_params.link_index = dc->link_count;
 		link_init_params.dc = dc;
 		link_init_params.is_dpia_link = true;
@@ -659,12 +659,12 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	/* By default, capture the full frame */
 	param.windowa_x_start = 0;
 	param.windowa_y_start = 0;
-	param.windowa_x_end = pipe->stream->timing.h_addressable;
-	param.windowa_y_end = pipe->stream->timing.v_addressable;
+	param.windowa_x_end = (uint16_t)pipe->stream->timing.h_addressable;
+	param.windowa_y_end = (uint16_t)pipe->stream->timing.v_addressable;
 	param.windowb_x_start = 0;
 	param.windowb_y_start = 0;
-	param.windowb_x_end = pipe->stream->timing.h_addressable;
-	param.windowb_y_end = pipe->stream->timing.v_addressable;
+	param.windowb_x_end = (uint16_t)pipe->stream->timing.h_addressable;
+	param.windowb_y_end = (uint16_t)pipe->stream->timing.v_addressable;
 	param.crc_poly_mode = crc_poly_mode;
 
 	if (crc_window) {
@@ -2137,7 +2137,7 @@ static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
 			stream_mask |= 1 << i;
 	}
 
-	return stream_mask;
+	return (uint8_t)stream_mask;
 }
 
 void dc_z10_restore(const struct dc *dc)
@@ -2482,7 +2482,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 		set[i].stream = stream;
 
 		if (status) {
-			set[i].plane_count = status->plane_count;
+			set[i].plane_count = (uint8_t)status->plane_count;
 			for (j = 0; j < status->plane_count; j++)
 				set[i].plane_states[j] = status->plane_states[j];
 		}
@@ -2541,7 +2541,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 	for (i = 0; i < params->stream_count; i++) {
 		for (j = 0; j < context->stream_count; j++) {
 			if (params->streams[i]->stream_id == context->streams[j]->stream_id)
-				params->streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+				params->streams[i]->out.otg_offset = (uint8_t)context->stream_status[j].primary_otg_inst;
 
 			if (dc_is_embedded_signal(params->streams[i]->signal)) {
 				struct dc_stream_status *status = dc_state_get_stream_status(context, params->streams[i]);
@@ -2669,7 +2669,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 		for (i = 0; i < dc->res_pool->pipe_count; i++)
 			if (context->res_ctx.pipe_ctx[i].stream == NULL ||
 					context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-				context->res_ctx.pipe_ctx[i].pipe_idx = i;
+				context->res_ctx.pipe_ctx[i].pipe_idx = (uint8_t)i;
 				dc->hwss.disable_plane(dc, context, &context->res_ctx.pipe_ctx[i]);
 			}
 
@@ -3219,10 +3219,10 @@ static void copy_surface_update_to_plane(
 		surface->flip_immediate =
 			srf_update->flip_addr->flip_immediate;
 		surface->time.time_elapsed_in_us[surface->time.index] =
-			srf_update->flip_addr->flip_timestamp_in_us -
-				surface->time.prev_update_time_in_us;
+			(unsigned int)(srf_update->flip_addr->flip_timestamp_in_us -
+				surface->time.prev_update_time_in_us);
 		surface->time.prev_update_time_in_us =
-			srf_update->flip_addr->flip_timestamp_in_us;
+			(unsigned int)srf_update->flip_addr->flip_timestamp_in_us;
 		surface->time.index++;
 		if (surface->time.index >= DC_PLANE_UPDATE_TIMES_MAX)
 			surface->time.index = 0;
@@ -3998,7 +3998,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 		else
 			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
 
-		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
+		update_dirty_rect->dirty_rect_count = (uint8_t)flip_addr->dirty_rect_count;
 		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
 				sizeof(flip_addr->dirty_rects));
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -4009,9 +4009,9 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 			if (pipe_ctx->plane_state != plane_state)
 				continue;
 
-			update_dirty_rect->panel_inst = panel_inst;
-			update_dirty_rect->pipe_idx = j;
-			update_dirty_rect->otg_inst = pipe_ctx->stream_res.tg->inst;
+			update_dirty_rect->panel_inst = (uint8_t)panel_inst;
+			update_dirty_rect->pipe_idx = (uint8_t)j;
+			update_dirty_rect->otg_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 			dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 		}
 	}
@@ -4059,7 +4059,7 @@ static void build_dmub_update_dirty_rect(
 		else
 			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
 
-		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
+		update_dirty_rect->dirty_rect_count = (uint8_t)flip_addr->dirty_rect_count;
 		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
 				sizeof(flip_addr->dirty_rects));
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -4069,9 +4069,9 @@ static void build_dmub_update_dirty_rect(
 				continue;
 			if (pipe_ctx->plane_state != plane_state)
 				continue;
-			update_dirty_rect->panel_inst = panel_inst;
-			update_dirty_rect->pipe_idx = j;
-			update_dirty_rect->otg_inst = pipe_ctx->stream_res.tg->inst;
+			update_dirty_rect->panel_inst = (uint8_t)panel_inst;
+			update_dirty_rect->pipe_idx = (uint8_t)j;
+			update_dirty_rect->otg_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 			dc_dmub_cmd[*dmub_cmd_count].dmub_cmd = cmd;
 			dc_dmub_cmd[*dmub_cmd_count].wait_type = DM_DMUB_WAIT_TYPE_NO_WAIT;
 			(*dmub_cmd_count)++;
@@ -4374,7 +4374,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 				hw_locks.bits.lock_dig = 1;
-				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
+				inst_flags.dig_inst = (uint8_t)top_pipe_to_program->stream_res.tg->inst;
 
 				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
 							true,
@@ -4641,7 +4641,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 				hw_locks.bits.lock_dig = 1;
-				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
+				inst_flags.dig_inst = (uint8_t)top_pipe_to_program->stream_res.tg->inst;
 
 				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
 							false,
@@ -6171,12 +6171,12 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	else
 		cmd.dp_aux_access.aux_control.type = AUX_CHANNEL_LEGACY_DDC;
 
-	cmd.dp_aux_access.aux_control.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.dp_aux_access.aux_control.instance = (uint8_t)dc->links[link_index]->ddc_hw_inst;
 	cmd.dp_aux_access.aux_control.sw_crc_enabled = 0;
 	cmd.dp_aux_access.aux_control.timeout = 0;
 	cmd.dp_aux_access.aux_control.dpaux.address = payload->address;
 	cmd.dp_aux_access.aux_control.dpaux.is_i2c_over_aux = payload->i2c_over_aux;
-	cmd.dp_aux_access.aux_control.dpaux.length = payload->length;
+	cmd.dp_aux_access.aux_control.dpaux.length = (uint8_t)payload->length;
 
 	/* set aux action */
 	if (payload->i2c_over_aux) {
@@ -6242,7 +6242,7 @@ bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_
 	}
 
 	if (pipe_ctx)
-		otg_inst = pipe_ctx->stream_res.tg->inst;
+		otg_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 
 	// before enable smart power OLED, we need to call set pipe for DMUB to set ABM config
 	if (enable) {
@@ -6259,11 +6259,11 @@ bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_
 		sizeof(struct dmub_rb_cmd_smart_power_oled_enable_data) - sizeof(struct dmub_cmd_header);
 	cmd.smart_power_oled_enable.header.ret_status = 1;
 	cmd.smart_power_oled_enable.data.enable = enable;
-	cmd.smart_power_oled_enable.data.panel_inst = panel_inst;
+	cmd.smart_power_oled_enable.data.panel_inst = (uint8_t)panel_inst;
 	cmd.smart_power_oled_enable.data.peak_nits = peak_nits;
 	cmd.smart_power_oled_enable.data.otg_inst = otg_inst;
-	cmd.smart_power_oled_enable.data.digfe_inst = link->link_enc->preferred_engine;
-	cmd.smart_power_oled_enable.data.digbe_inst = link->link_enc->transmitter;
+	cmd.smart_power_oled_enable.data.digfe_inst = (uint8_t)link->link_enc->preferred_engine;
+	cmd.smart_power_oled_enable.data.digbe_inst = (uint8_t)link->link_enc->transmitter;
 
 	cmd.smart_power_oled_enable.data.debugcontrol = debug_control;
 	cmd.smart_power_oled_enable.data.triggerline = triggerline;
@@ -6294,7 +6294,7 @@ bool dc_smart_power_oled_get_max_cll(const struct dc_link *link, unsigned int *p
 	cmd.smart_power_oled_getmaxcll.header.payload_bytes = sizeof(cmd.smart_power_oled_getmaxcll.data);
 	cmd.smart_power_oled_getmaxcll.header.ret_status = 1;
 
-	cmd.smart_power_oled_getmaxcll.data.input.panel_inst = panel_inst;
+	cmd.smart_power_oled_getmaxcll.data.input.panel_inst = (uint8_t)panel_inst;
 
 	// send cmd and wait for reply
 	status = dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
@@ -6352,7 +6352,7 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
 	cmd.set_config_access.header.type = DMUB_CMD__DPIA;
 	cmd.set_config_access.header.sub_type = DMUB_CMD__DPIA_SET_CONFIG_ACCESS;
 
-	cmd.set_config_access.set_config_control.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_config_access.set_config_control.instance = (uint8_t)dc->links[link_index]->ddc_hw_inst;
 	cmd.set_config_access.set_config_control.cmd_pkt.msg_type = payload->msg_type;
 	cmd.set_config_access.set_config_control.cmd_pkt.msg_data = payload->msg_data;
 
@@ -6396,7 +6396,7 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 	cmd.set_mst_alloc_slots.header.type = DMUB_CMD__DPIA;
 	cmd.set_mst_alloc_slots.header.sub_type = DMUB_CMD__DPIA_MST_ALLOC_SLOTS;
 
-	cmd.set_mst_alloc_slots.mst_slots_control.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_mst_alloc_slots.mst_slots_control.instance = (uint8_t)dc->links[link_index]->ddc_hw_inst;
 	cmd.set_mst_alloc_slots.mst_slots_control.mst_alloc_slots = mst_alloc_slots;
 
 	if (!dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
@@ -6436,7 +6436,7 @@ void dc_process_dmub_dpia_set_tps_notification(const struct dc *dc, uint32_t lin
 
 	cmd.set_tps_notification.header.type = DMUB_CMD__DPIA;
 	cmd.set_tps_notification.header.sub_type = DMUB_CMD__DPIA_SET_TPS_NOTIFICATION;
-	cmd.set_tps_notification.tps_notification.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_tps_notification.tps_notification.instance = (uint8_t)dc->links[link_index]->ddc_hw_inst;
 	cmd.set_tps_notification.tps_notification.tps = tps;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f8a6916bbd4d..a347d3ff5e6e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -347,39 +347,39 @@ void get_surface_visual_confirm_color(
 	switch (pipe_ctx->plane_res.scl_data.format) {
 	case PIXEL_FORMAT_ARGB8888:
 		/* set border color to red */
-		color->color_r_cr = color_value;
+		color->color_r_cr = (uint16_t)color_value;
 		if (pipe_ctx->plane_state->layer_index > 0) {
 			/* set border color to pink */
-			color->color_b_cb = color_value;
-			color->color_g_y = color_value * 0.5;
+			color->color_b_cb = (uint16_t)color_value;
+			color->color_g_y = (uint16_t)(color_value / 2);
 		}
 		break;
 
 	case PIXEL_FORMAT_ARGB2101010:
 		/* set border color to blue */
-		color->color_b_cb = color_value;
+		color->color_b_cb = (uint16_t)color_value;
 		if (pipe_ctx->plane_state->layer_index > 0) {
 			/* set border color to cyan */
-			color->color_g_y = color_value;
+			color->color_g_y = (uint16_t)color_value;
 		}
 		break;
 	case PIXEL_FORMAT_420BPP8:
 		/* set border color to green */
-		color->color_g_y = color_value;
+		color->color_g_y = (uint16_t)color_value;
 		break;
 	case PIXEL_FORMAT_420BPP10:
 		/* set border color to yellow */
-		color->color_g_y = color_value;
-		color->color_r_cr = color_value;
+		color->color_g_y = (uint16_t)color_value;
+		color->color_r_cr = (uint16_t)color_value;
 		break;
 	case PIXEL_FORMAT_FP16:
 		/* set border color to white */
-		color->color_r_cr = color_value;
-		color->color_b_cb = color_value;
-		color->color_g_y = color_value;
+		color->color_r_cr = (uint16_t)color_value;
+		color->color_b_cb = (uint16_t)color_value;
+		color->color_g_y = (uint16_t)color_value;
 		if (pipe_ctx->plane_state->layer_index > 0) {
 			/* set border color to orange */
-			color->color_g_y = 0.22 * color_value;
+			color->color_g_y = (uint16_t)((color_value * 22) / 100);
 			color->color_b_cb = 0;
 		}
 		break;
@@ -405,21 +405,21 @@ void get_hdr_visual_confirm_color(
 	case PIXEL_FORMAT_ARGB2101010:
 		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, ARGB2101010 - set border color to red */
-			color->color_r_cr = color_value;
+			color->color_r_cr = (uint16_t)color_value;
 		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 ARGB2101010 - set border color to pink */
-			color->color_r_cr = color_value;
-			color->color_b_cb = color_value;
+			color->color_r_cr = (uint16_t)color_value;
+			color->color_b_cb = (uint16_t)color_value;
 		} else
 			is_sdr = true;
 		break;
 	case PIXEL_FORMAT_FP16:
 		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, FP16 - set border color to blue */
-			color->color_b_cb = color_value;
+			color->color_b_cb = (uint16_t)color_value;
 		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 HDR - set border color to green */
-			color->color_g_y = color_value;
+			color->color_g_y = (uint16_t)color_value;
 		} else
 			is_sdr = true;
 		break;
@@ -430,9 +430,9 @@ void get_hdr_visual_confirm_color(
 
 	if (is_sdr) {
 		/* SDR - set border color to Gray */
-		color->color_r_cr = color_value/2;
-		color->color_b_cb = color_value/2;
-		color->color_g_y = color_value/2;
+		color->color_r_cr = (uint16_t)(color_value / 2);
+		color->color_b_cb = (uint16_t)(color_value / 2);
+		color->color_g_y = (uint16_t)(color_value / 2);
 	}
 }
 
@@ -456,7 +456,7 @@ void get_smartmux_visual_confirm_color(
 		*color = sm_ver_colors[dc->config.smart_mux_version];
 	} else {
 		/* dGPU driving the eDP - red */
-		color->color_r_cr = color_value;
+		color->color_r_cr = (uint16_t)color_value;
 		color->color_g_y = 0;
 		color->color_b_cb = 0;
 	}
@@ -478,19 +478,19 @@ void get_vabc_visual_confirm_color(
 	if (edp_link) {
 		switch (edp_link->backlight_control_type) {
 		case BACKLIGHT_CONTROL_PWM:
-			color->color_r_cr = color_value;
+			color->color_r_cr = (uint16_t)color_value;
 			color->color_g_y = 0;
 			color->color_b_cb = 0;
 			break;
 		case BACKLIGHT_CONTROL_AMD_AUX:
 			color->color_r_cr = 0;
-			color->color_g_y = color_value;
+			color->color_g_y = (uint16_t)color_value;
 			color->color_b_cb = 0;
 			break;
 		case BACKLIGHT_CONTROL_VESA_AUX:
 			color->color_r_cr = 0;
 			color->color_g_y = 0;
-			color->color_b_cb = color_value;
+			color->color_b_cb = (uint16_t)color_value;
 			break;
 		}
 	} else {
@@ -508,19 +508,19 @@ void get_subvp_visual_confirm_color(
 	if (pipe_ctx) {
 		switch (pipe_ctx->p_state_type) {
 		case P_STATE_SUB_VP:
-			color->color_r_cr = color_value;
+			color->color_r_cr = (uint16_t)color_value;
 			color->color_g_y  = 0;
 			color->color_b_cb = 0;
 			break;
 		case P_STATE_DRR_SUB_VP:
 			color->color_r_cr = 0;
-			color->color_g_y  = color_value;
+			color->color_g_y  = (uint16_t)color_value;
 			color->color_b_cb = 0;
 			break;
 		case P_STATE_V_BLANK_SUB_VP:
 			color->color_r_cr = 0;
 			color->color_g_y  = 0;
-			color->color_b_cb = color_value;
+			color->color_b_cb = (uint16_t)color_value;
 			break;
 		default:
 			break;
@@ -537,34 +537,34 @@ void get_mclk_switch_visual_confirm_color(
 	if (pipe_ctx) {
 		switch (pipe_ctx->p_state_type) {
 		case P_STATE_V_BLANK:
-			color->color_r_cr = color_value;
-			color->color_g_y = color_value;
+			color->color_r_cr = (uint16_t)color_value;
+			color->color_g_y = (uint16_t)color_value;
 			color->color_b_cb = 0;
 			break;
 		case P_STATE_FPO:
 			color->color_r_cr = 0;
-			color->color_g_y  = color_value;
-			color->color_b_cb = color_value;
+			color->color_g_y  = (uint16_t)color_value;
+			color->color_b_cb = (uint16_t)color_value;
 			break;
 		case P_STATE_V_ACTIVE:
-			color->color_r_cr = color_value;
+			color->color_r_cr = (uint16_t)color_value;
 			color->color_g_y  = 0;
-			color->color_b_cb = color_value;
+			color->color_b_cb = (uint16_t)color_value;
 			break;
 		case P_STATE_SUB_VP:
-			color->color_r_cr = color_value;
+			color->color_r_cr = (uint16_t)color_value;
 			color->color_g_y  = 0;
 			color->color_b_cb = 0;
 			break;
 		case P_STATE_DRR_SUB_VP:
 			color->color_r_cr = 0;
-			color->color_g_y  = color_value;
+			color->color_g_y  = (uint16_t)color_value;
 			color->color_b_cb = 0;
 			break;
 		case P_STATE_V_BLANK_SUB_VP:
 			color->color_r_cr = 0;
 			color->color_g_y  = 0;
-			color->color_b_cb = color_value;
+			color->color_b_cb = (uint16_t)color_value;
 			break;
 		default:
 			break;
@@ -579,13 +579,13 @@ void get_cursor_visual_confirm_color(
 	uint32_t color_value = MAX_TG_COLOR_VALUE;
 
 	if (pipe_ctx->stream && pipe_ctx->stream->cursor_position.enable) {
-		color->color_r_cr = color_value;
+		color->color_r_cr = (uint16_t)color_value;
 		color->color_g_y = 0;
 		color->color_b_cb = 0;
 	} else {
 		color->color_r_cr = 0;
 		color->color_g_y = 0;
-		color->color_b_cb = color_value;
+		color->color_b_cb = (uint16_t)color_value;
 	}
 }
 
@@ -723,9 +723,9 @@ void get_fams2_visual_confirm_color(
 	/* driver only handles visual confirm when FAMS2 is disabled */
 	if (!dc_state_is_fams2_in_use(dc, context)) {
 		/* when FAMS2 is disabled, all pipes are grey */
-		color->color_g_y = color_value / 2;
-		color->color_b_cb = color_value / 2;
-		color->color_r_cr = color_value / 2;
+		color->color_g_y = (uint16_t)(color_value / 2);
+		color->color_b_cb = (uint16_t)(color_value / 2);
+		color->color_r_cr = (uint16_t)(color_value / 2);
 	}
 }
 
@@ -2414,7 +2414,7 @@ void get_surface_tile_visual_confirm_color(
 	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
 	case DC_SW_LINEAR:
 		/* LINEAR Surface - set border color to red */
-		color->color_r_cr = color_value;
+		color->color_r_cr = (uint16_t)color_value;
 		break;
 	default:
 		break;
@@ -4595,8 +4595,8 @@ void get_refresh_rate_confirm_color(struct pipe_ctx *pipe_ctx, struct tg_color *
 		if (max_refresh_rate - min_refresh_rate)
 			scaling_factor = MAX_TG_COLOR_VALUE * (refresh_rate - min_refresh_rate) / (max_refresh_rate - min_refresh_rate);
 
-		pipe_ctx->visual_confirm_color.color_r_cr = color_value;
-		pipe_ctx->visual_confirm_color.color_g_y = scaling_factor;
-		pipe_ctx->visual_confirm_color.color_b_cb = color_value;
+		pipe_ctx->visual_confirm_color.color_r_cr = (uint16_t)color_value;
+		pipe_ctx->visual_confirm_color.color_g_y = (uint16_t)scaling_factor;
+		pipe_ctx->visual_confirm_color.color_b_cb = (uint16_t)color_value;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 00b894602423..20600455ff63 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -286,34 +286,34 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 #endif
 	case DCE_VERSION_8_0:
 		res_pool = dce80_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 	case DCE_VERSION_8_1:
 		res_pool = dce81_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 	case DCE_VERSION_8_3:
 		res_pool = dce83_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 	case DCE_VERSION_10_0:
 		res_pool = dce100_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 	case DCE_VERSION_11_0:
 		res_pool = dce110_create_resource_pool(
-				init_data->num_virtual_links, dc,
+				(uint8_t)init_data->num_virtual_links, dc,
 				init_data->asic_id);
 		break;
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
 		res_pool = dce112_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 	case DCE_VERSION_12_0:
 	case DCE_VERSION_12_1:
 		res_pool = dce120_create_resource_pool(
-				init_data->num_virtual_links, dc);
+				(uint8_t)init_data->num_virtual_links, dc);
 		break;
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
@@ -511,7 +511,7 @@ bool resource_construct(
 	pool->hpo_dp_link_enc_count = 0;
 	if (create_funcs->create_hpo_dp_link_encoder) {
 		for (i = 0; i < caps->num_hpo_dp_link_encoder; i++) {
-			pool->hpo_dp_link_enc[i] = create_funcs->create_hpo_dp_link_encoder(i, ctx);
+			pool->hpo_dp_link_enc[i] = create_funcs->create_hpo_dp_link_encoder((uint8_t)i, ctx);
 			if (pool->hpo_dp_link_enc[i] == NULL)
 				DC_ERR("DC: failed to create HPO DP link encoder!\n");
 			pool->hpo_dp_link_enc_count++;
@@ -610,7 +610,7 @@ bool resource_are_vblanks_synchronizable(
 {
 	uint32_t base60_refresh_rates[] = {10, 20, 5};
 	uint8_t i;
-	uint8_t rr_count = ARRAY_SIZE(base60_refresh_rates);
+	uint8_t rr_count = (uint8_t)ARRAY_SIZE(base60_refresh_rates);
 	uint64_t frame_time_diff;
 
 	if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
@@ -1801,7 +1801,7 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 		int preferred_pipe_idx = (pool->pipe_count - 1) - primary_pipe->pipe_idx;
 		if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 			secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-			secondary_pipe->pipe_idx = preferred_pipe_idx;
+			secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 		}
 	}
 
@@ -1813,7 +1813,7 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 		for (i = pool->pipe_count - 1; i >= 0; i--) {
 			if (res_ctx->pipe_ctx[i].stream == NULL) {
 				secondary_pipe = &res_ctx->pipe_ctx[i];
-				secondary_pipe->pipe_idx = i;
+				secondary_pipe->pipe_idx = (uint8_t)i;
 				break;
 			}
 		}
@@ -2624,8 +2624,8 @@ static int acquire_first_split_pipe(
 			split_pipe->plane_res.ipp = pool->ipps[i];
 			split_pipe->plane_res.dpp = pool->dpps[i];
 			split_pipe->stream_res.opp = pool->opps[i];
-			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
-			split_pipe->pipe_idx = i;
+			split_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[i]->inst;
+			split_pipe->pipe_idx = (uint8_t)i;
 
 			split_pipe->stream = stream;
 			return i;
@@ -3804,7 +3804,7 @@ static int acquire_resource_from_hw_enabled_state(
 			pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
 
 			if (pool->dpps[id_src[i]]) {
-				pipe_ctx->plane_res.mpcc_inst = pool->dpps[id_src[i]]->inst;
+				pipe_ctx->plane_res.mpcc_inst = (uint8_t)pool->dpps[id_src[i]]->inst;
 
 				if (pool->mpc->funcs->read_mpcc_state) {
 					struct mpcc_state s = {0};
@@ -3823,7 +3823,7 @@ static int acquire_resource_from_hw_enabled_state(
 						pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
 				}
 			}
-			pipe_ctx->pipe_idx = id_src[i];
+			pipe_ctx->pipe_idx = (uint8_t)id_src[i];
 
 			if (id_src[i] >= pool->timing_generator_count) {
 				id_src[i] = pool->timing_generator_count - 1;
@@ -3939,7 +3939,7 @@ static bool acquire_otg_master_pipe_for_stream(
 	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
 		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
 		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
-		pipe_ctx->pipe_idx = pipe_idx;
+		pipe_ctx->pipe_idx = (uint8_t)pipe_idx;
 		pipe_ctx->stream_res.tg = pool->timing_generators[pipe_idx];
 		pipe_ctx->plane_res.mi = pool->mis[pipe_idx];
 		pipe_ctx->plane_res.hubp = pool->hubps[pipe_idx];
@@ -3948,7 +3948,7 @@ static bool acquire_otg_master_pipe_for_stream(
 		pipe_ctx->plane_res.dpp = pool->dpps[pipe_idx];
 		pipe_ctx->stream_res.opp = pool->opps[pipe_idx];
 		if (pool->dpps[pipe_idx])
-			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+			pipe_ctx->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 
 		if (pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
 			int tg_inst = pool->timing_generator_count - 1;
@@ -4497,7 +4497,7 @@ static void patch_gamut_packet_checksum(
 		for (i = 0; i <= gamut_packet->sb[1]; i++)
 			chk_sum += ptr[i];
 
-		gamut_packet->sb[2] = (uint8_t) (0x100 - chk_sum);
+		gamut_packet->sb[2] = (uint8_t)(0x100 - chk_sum);
 	}
 }
 
@@ -4562,7 +4562,7 @@ static void set_avi_info_frame(
 
 	/* Y0_Y1_Y2 : The pixel encoding */
 	/* H14b AVI InfoFrame has extension on Y-field from 2 bits to 3 bits */
-	hdmi_info.bits.Y0_Y1_Y2 = pixel_encoding;
+	hdmi_info.bits.Y0_Y1_Y2 = (uint8_t)pixel_encoding;
 
 	/* A0 = 1 Active Format Information valid */
 	hdmi_info.bits.A0 = ACTIVE_FORMAT_VALID;
@@ -4692,7 +4692,7 @@ static void set_avi_info_frame(
 		}
 	}
 	/* If VIC >= 128, the Source shall use AVI InfoFrame Version 3*/
-	hdmi_info.bits.VIC0_VIC7 = vic;
+	hdmi_info.bits.VIC0_VIC7 = (uint8_t)vic;
 	if (vic >= 128)
 		hdmi_info.bits.header.version = 3;
 	/* If (C1, C0)=(1, 1) and (EC2, EC1, EC0)=(1, 1, 1),
@@ -4710,7 +4710,7 @@ static void set_avi_info_frame(
 
 		hdmi_info.bits.FR0_FR3 = fr_ind & 0xF;
 		hdmi_info.bits.FR4 = (fr_ind >> 4) & 0x1;
-		hdmi_info.bits.RID0_RID5 = rid;
+		hdmi_info.bits.RID0_RID5 = (uint8_t)rid;
 	}
 
 	/* pixel repetition
@@ -4723,10 +4723,10 @@ static void set_avi_info_frame(
 	 * barBottom: Line Number of Start of Bottom Bar.
 	 * barLeft:   Pixel Number of End of Left Bar.
 	 * barRight:  Pixel Number of Start of Right Bar. */
-	hdmi_info.bits.bar_top = stream->timing.v_border_top;
+	hdmi_info.bits.bar_top = (uint16_t)stream->timing.v_border_top;
 	hdmi_info.bits.bar_bottom = (stream->timing.v_total
 			- stream->timing.v_border_bottom + 1);
-	hdmi_info.bits.bar_left  = stream->timing.h_border_left;
+	hdmi_info.bits.bar_left  = (uint16_t)stream->timing.h_border_left;
 	hdmi_info.bits.bar_right = (stream->timing.h_total
 			- stream->timing.h_border_right + 1);
 
@@ -4746,7 +4746,7 @@ static void set_avi_info_frame(
 		*check_sum += hdmi_info.packet_raw_data.sb[byte_index];
 
 	/* one byte complement */
-	*check_sum = (uint8_t) (0x100 - *check_sum);
+	*check_sum = (uint8_t)(0x100 - *check_sum);
 
 	/* Store in hw_path_mode */
 	info_packet->hb0 = hdmi_info.packet_raw_data.hb0;
@@ -5564,13 +5564,13 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 	sec_pipe->next_odm_pipe = sec_next;
 	sec_pipe->prev_odm_pipe = sec_prev;
 
-	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->pipe_idx = (uint8_t)pipe_idx;
 	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
 	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
 	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
 	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
 	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
-	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 	sec_pipe->stream_res.dsc = NULL;
 	if (odm) {
 		if (!sec_pipe->top_pipe)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 473fe959f5c7..cca3dece08d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -263,7 +263,7 @@ void program_cursor_attributes(
 	struct dc *dc,
 	struct dc_stream_state *stream)
 {
-	int i;
+	uint8_t i;
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
@@ -410,7 +410,7 @@ void program_cursor_position(
 	struct dc *dc,
 	struct dc_stream_state *stream)
 {
-	int i;
+	uint8_t i;
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
@@ -1032,14 +1032,18 @@ static int dc_stream_get_brightness_millinits_linear_interpolation (struct dc_st
 								     int refresh_hz)
 {
 	long long slope = 0;
+	long long y_intercept = 0;
+	long long brightness_millinits = 0;
+
 	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
 		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
 			    (stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
 	}
 
-	int y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+	y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+	brightness_millinits = y_intercept + (long long)refresh_hz * slope;
 
-	return (y_intercept + refresh_hz * slope);
+	return (int)brightness_millinits;
 }
 
 /*
@@ -1051,14 +1055,18 @@ static int dc_stream_get_refresh_hz_linear_interpolation (struct dc_stream_state
 							   int brightness_millinits)
 {
 	long long slope = 1;
+	long long y_intercept = 0;
+	long long refresh_hz = 0;
+
 	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
 		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
 				(stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
 	}
 
-	int y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+	y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
+	refresh_hz = div64_s64((brightness_millinits - y_intercept), slope);
 
-	return ((int)div64_s64((brightness_millinits - y_intercept), slope));
+	return (int)refresh_hz;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 56b21059a663..15167d0bd467 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -75,7 +75,7 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane
 		struct pipe_ctx *pipe_ctx = &dc_state->res_ctx.pipe_ctx[i];
 
 		if (pipe_ctx->plane_state == plane_state && pipe_ctx->plane_res.hubp)
-			pipe_mask |= 1 << pipe_ctx->plane_res.hubp->inst;
+			pipe_mask |= (uint8_t)(1 << pipe_ctx->plane_res.hubp->inst);
 	}
 
 	return pipe_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 9cb07110bdc7..317c69719313 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -336,7 +336,7 @@ bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 		return false;
 	}
 
-	return boot_status.bits.optimized_init_done;
+	return (bool)boot_status.bits.optimized_init_done;
 }
 
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
@@ -346,7 +346,7 @@ bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 		return false;
 
 	return dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
-					 stream_mask, NULL, DM_DMUB_WAIT_TYPE_WAIT);
+				 (uint16_t)stream_mask, NULL, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv)
@@ -368,7 +368,7 @@ bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv)
 		return false;
 	}
 
-	return boot_status.bits.restore_required;
+	return (bool)boot_status.bits.restore_required;
 }
 
 bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry)
@@ -415,7 +415,7 @@ void dc_dmub_srv_set_drr_manual_trigger_cmd(struct dc *dc, uint32_t tg_inst)
 static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
 {
 	uint8_t pipes = 0;
-	int i = 0;
+	uint8_t i = 0;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -433,15 +433,15 @@ static void dc_dmub_srv_populate_fams_pipe_info(struct dc *dc, struct dc_state *
 	int j;
 	int pipe_idx = 0;
 
-	fams_pipe_data->pipe_index[pipe_idx++] = head_pipe->plane_res.hubp->inst;
+	fams_pipe_data->pipe_index[pipe_idx++] = (uint8_t)head_pipe->plane_res.hubp->inst;
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *split_pipe = &context->res_ctx.pipe_ctx[j];
 
 		if (split_pipe->stream == head_pipe->stream && (split_pipe->top_pipe || split_pipe->prev_odm_pipe)) {
-			fams_pipe_data->pipe_index[pipe_idx++] = split_pipe->plane_res.hubp->inst;
+			fams_pipe_data->pipe_index[pipe_idx++] = (uint8_t)split_pipe->plane_res.hubp->inst;
 		}
 	}
-	fams_pipe_data->pipe_count = pipe_idx;
+	fams_pipe_data->pipe_count = (uint8_t)pipe_idx;
 }
 
 bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, struct dc_state *context)
@@ -456,7 +456,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	if (dc == NULL)
 		return false;
 
-	visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
+	visual_confirm_enabled = (uint8_t)(dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS);
 
 	// Format command.
 	cmd.fw_assisted_mclk_switch.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
@@ -477,7 +477,8 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 			 */
 			stream_status = dc_state_get_stream_status(context, pipe->stream);
 			if (stream_status && !stream_status->fpo_in_use) {
-				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
+				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us =
+					(uint16_t)dc->debug.fpo_vactive_margin_us;
 				break;
 			}
 		}
@@ -492,11 +493,13 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 		stream_status = dc_state_get_stream_status(context, pipe->stream);
 		if (stream_status && stream_status->fpo_in_use) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-			uint8_t min_refresh_in_hz = (pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000;
+			uint8_t min_refresh_in_hz;
+
+			min_refresh_in_hz = (uint8_t)((pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000);
 
 			config_data->pipe_data[k].pix_clk_100hz = pipe->stream->timing.pix_clk_100hz;
 			config_data->pipe_data[k].min_refresh_in_hz = min_refresh_in_hz;
-			config_data->pipe_data[k].max_ramp_step = ramp_up_num_steps;
+			config_data->pipe_data[k].max_ramp_step = (uint8_t)ramp_up_num_steps;
 			config_data->pipe_data[k].pipes = dc_dmub_srv_get_pipes_for_stream(dc, pipe->stream);
 			dc_dmub_srv_populate_fams_pipe_info(dc, context, pipe, &config_data->pipe_data[k]);
 			k++;
@@ -551,7 +554,7 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	cmd.visual_confirm_color.header.sub_type = 0;
 	cmd.visual_confirm_color.header.ret_status = 1;
 	cmd.visual_confirm_color.header.payload_bytes = sizeof(struct dmub_cmd_visual_confirm_color_data);
-	cmd.visual_confirm_color.visual_confirm_color_data.visual_confirm_color.panel_inst = panel_inst;
+	cmd.visual_confirm_color.visual_confirm_color_data.visual_confirm_color.panel_inst = (uint16_t)panel_inst;
 
 	// If command was processed, copy feature caps to dmub srv
 	if (dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) &&
@@ -589,17 +592,17 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
 	struct dc_crtc_timing *phantom_timing;
 	struct dc_crtc_timing *drr_timing = &vblank_pipe->stream->timing;
-	uint16_t drr_frame_us = 0;
-	uint16_t min_drr_supported_us = 0;
-	uint16_t max_drr_supported_us = 0;
-	uint16_t max_drr_vblank_us = 0;
-	uint16_t max_drr_mallregion_us = 0;
-	uint16_t mall_region_us = 0;
-	uint16_t prefetch_us = 0;
-	uint16_t subvp_active_us = 0;
-	uint16_t drr_active_us = 0;
-	uint16_t min_vtotal_supported = 0;
-	uint16_t max_vtotal_supported = 0;
+	uint64_t drr_frame_us = 0;
+	uint64_t min_drr_supported_us = 0;
+	uint64_t max_drr_supported_us = 0;
+	uint64_t max_drr_vblank_us = 0;
+	uint64_t max_drr_mallregion_us = 0;
+	uint64_t mall_region_us = 0;
+	uint64_t prefetch_us = 0;
+	uint64_t subvp_active_us = 0;
+	uint64_t drr_active_us = 0;
+	uint64_t min_vtotal_supported = 0;
+	uint64_t max_vtotal_supported = 0;
 
 	if (!phantom_stream)
 		return;
@@ -639,9 +642,10 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	 */
 	max_vtotal_supported = max_vtotal_supported - dc->caps.subvp_drr_max_vblank_margin_us;
 
-	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
-	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
-	pipe_data->pipe_config.vblank_data.drr_info.drr_vblank_start_margin = dc->caps.subvp_drr_vblank_start_margin_us;
+	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = (uint16_t)min_vtotal_supported;
+	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = (uint16_t)max_vtotal_supported;
+	pipe_data->pipe_config.vblank_data.drr_info.drr_vblank_start_margin =
+		(uint16_t)dc->caps.subvp_drr_vblank_start_margin_us;
 }
 
 /**
@@ -686,12 +690,12 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 
 	pipe_data->mode = VBLANK;
 	pipe_data->pipe_config.vblank_data.pix_clk_100hz = vblank_pipe->stream->timing.pix_clk_100hz;
-	pipe_data->pipe_config.vblank_data.vblank_start = vblank_pipe->stream->timing.v_total -
-							vblank_pipe->stream->timing.v_front_porch;
-	pipe_data->pipe_config.vblank_data.vtotal = vblank_pipe->stream->timing.v_total;
-	pipe_data->pipe_config.vblank_data.htotal = vblank_pipe->stream->timing.h_total;
+	pipe_data->pipe_config.vblank_data.vblank_start = (uint16_t)(vblank_pipe->stream->timing.v_total -
+							vblank_pipe->stream->timing.v_front_porch);
+	pipe_data->pipe_config.vblank_data.vtotal = (uint16_t)vblank_pipe->stream->timing.v_total;
+	pipe_data->pipe_config.vblank_data.htotal = (uint16_t)vblank_pipe->stream->timing.h_total;
 	pipe_data->pipe_config.vblank_data.vblank_pipe_index = vblank_pipe->pipe_idx;
-	pipe_data->pipe_config.vblank_data.vstartup_start = vblank_pipe->pipe_dlg_param.vstartup_start;
+	pipe_data->pipe_config.vblank_data.vstartup_start = (uint16_t)vblank_pipe->pipe_dlg_param.vstartup_start;
 	pipe_data->pipe_config.vblank_data.vblank_end =
 			vblank_pipe->stream->timing.v_total - vblank_pipe->stream->timing.v_front_porch - vblank_pipe->stream->timing.v_addressable;
 
@@ -739,10 +743,10 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	phantom_timing0 = &phantom_stream0->timing;
 	phantom_timing1 = &phantom_stream1->timing;
 
-	subvp0_prefetch_us = div64_u64(((uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) *
+	subvp0_prefetch_us = (uint32_t)div64_u64(((uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) *
 			(uint64_t)phantom_timing0->h_total * 1000000),
 			(((uint64_t)phantom_timing0->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us));
-	subvp1_prefetch_us = div64_u64(((uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) *
+	subvp1_prefetch_us = (uint32_t)div64_u64(((uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) *
 			(uint64_t)phantom_timing1->h_total * 1000000),
 			(((uint64_t)phantom_timing1->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us));
 
@@ -751,8 +755,8 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	if (subvp0_prefetch_us > subvp1_prefetch_us) {
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
-		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-				div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
+				(uint16_t)div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
 					((uint64_t)phantom_timing1->pix_clk_100hz * 100) + ((uint64_t)phantom_timing1->h_total * 1000000 - 1)),
 					((uint64_t)phantom_timing1->h_total * 1000000));
 
@@ -760,7 +764,7 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-				div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+				(uint16_t)div64_u64(((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
 					((uint64_t)phantom_timing0->pix_clk_100hz * 100) + ((uint64_t)phantom_timing0->h_total * 1000000 - 1)),
 					((uint64_t)phantom_timing0->h_total * 1000000));
 	}
@@ -800,14 +804,14 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	pipe_data->mode = SUBVP;
 	pipe_data->pipe_config.subvp_data.pix_clk_100hz = subvp_pipe->stream->timing.pix_clk_100hz;
-	pipe_data->pipe_config.subvp_data.htotal = subvp_pipe->stream->timing.h_total;
-	pipe_data->pipe_config.subvp_data.vtotal = subvp_pipe->stream->timing.v_total;
+	pipe_data->pipe_config.subvp_data.htotal = (uint16_t)subvp_pipe->stream->timing.h_total;
+	pipe_data->pipe_config.subvp_data.vtotal = (uint16_t)subvp_pipe->stream->timing.v_total;
 	pipe_data->pipe_config.subvp_data.main_vblank_start =
-			main_timing->v_total - main_timing->v_front_porch;
+			(uint16_t)(main_timing->v_total - main_timing->v_front_porch);
 	pipe_data->pipe_config.subvp_data.main_vblank_end =
-			main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable;
-	pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
-	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->stream_res.tg->inst;
+			(uint16_t)(main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable);
+	pipe_data->pipe_config.subvp_data.mall_region_lines = (uint16_t)phantom_timing->v_addressable;
+	pipe_data->pipe_config.subvp_data.main_pipe_index = (uint8_t)subvp_pipe->stream_res.tg->inst;
 	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param &&
 		(subvp_pipe->stream->allow_freesync || subvp_pipe->stream->vrr_active_variable || subvp_pipe->stream->vrr_active_fixed);
 
@@ -822,8 +826,8 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	reduce_fraction(subvp_pipe->plane_state->src_rect.height, subvp_pipe->plane_state->dst_rect.height,
 			&out_num_plane, &out_den_plane);
 	reduce_fraction(out_num_stream * out_num_plane, out_den_stream * out_den_plane, &out_num, &out_den);
-	pipe_data->pipe_config.subvp_data.scale_factor_numerator = out_num;
-	pipe_data->pipe_config.subvp_data.scale_factor_denominator = out_den;
+	pipe_data->pipe_config.subvp_data.scale_factor_numerator = (uint8_t)out_num;
+	pipe_data->pipe_config.subvp_data.scale_factor_denominator = (uint8_t)out_den;
 
 	// Prefetch lines is equal to VACTIVE + BP + VSYNC
 	pipe_data->pipe_config.subvp_data.prefetch_lines =
@@ -831,16 +835,16 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			div64_u64(((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
+			(uint16_t)div64_u64(((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-			div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
+			(uint16_t)div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 
 	if (subvp_pipe->bottom_pipe) {
-		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->bottom_pipe->pipe_idx;
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = (uint8_t)subvp_pipe->bottom_pipe->pipe_idx;
 	} else if (subvp_pipe->next_odm_pipe) {
-		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->next_odm_pipe->pipe_idx;
+		pipe_data->pipe_config.subvp_data.main_split_pipe_index = (uint8_t)subvp_pipe->next_odm_pipe->pipe_idx;
 	} else {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0xF;
 	}
@@ -851,11 +855,11 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 		if (resource_is_pipe_type(phantom_pipe, OTG_MASTER) &&
 				phantom_pipe->stream == dc_state_get_paired_subvp_stream(context, subvp_pipe->stream)) {
-			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->stream_res.tg->inst;
+			pipe_data->pipe_config.subvp_data.phantom_pipe_index = (uint8_t)phantom_pipe->stream_res.tg->inst;
 			if (phantom_pipe->bottom_pipe) {
-				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->plane_res.hubp->inst;
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = (uint8_t)phantom_pipe->bottom_pipe->plane_res.hubp->inst;
 			} else if (phantom_pipe->next_odm_pipe) {
-				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->next_odm_pipe->plane_res.hubp->inst;
+				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = (uint8_t)phantom_pipe->next_odm_pipe->plane_res.hubp->inst;
 			} else {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0xF;
 			}
@@ -933,15 +937,15 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		if (subvp_count == 2) {
 			update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
 		}
-		cmd.fw_assisted_mclk_switch_v2.config_data.pstate_allow_width_us = dc->caps.subvp_pstate_allow_width_us;
-		cmd.fw_assisted_mclk_switch_v2.config_data.vertical_int_margin_us = dc->caps.subvp_vertical_int_margin_us;
+		cmd.fw_assisted_mclk_switch_v2.config_data.pstate_allow_width_us = (uint8_t)dc->caps.subvp_pstate_allow_width_us;
+		cmd.fw_assisted_mclk_switch_v2.config_data.vertical_int_margin_us = (uint8_t)dc->caps.subvp_vertical_int_margin_us;
 
 		// Store the original watermark value for this SubVP config so we can lower it when the
 		// MCLK switch starts
 		wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
 				(dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000) / 1000;
 
-		cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
+		cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = (uint16_t)(wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF);
 	}
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
@@ -1060,10 +1064,10 @@ static void dc_build_cursor_update_payload0(
 	payload->cursor_rect.width  = hubp->cur_rect.w;
 	payload->cursor_rect.height = hubp->cur_rect.h;
 
-	payload->enable      = hubp->pos.cur_ctl.bits.cur_enable;
+	payload->enable      = (uint8_t)hubp->pos.cur_ctl.bits.cur_enable;
 	payload->pipe_idx    = p_idx;
-	payload->panel_inst  = panel_inst;
-	payload->otg_inst    = pipe_ctx->stream_res.tg->inst;
+	payload->panel_inst  = (uint8_t)panel_inst;
+	payload->otg_inst    = (uint8_t)pipe_ctx->stream_res.tg->inst;
 }
 
 static void dc_build_cursor_position_update_payload0(
@@ -1645,7 +1649,7 @@ bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
 	if (dc_dmub_srv->dmub->shared_state &&
 	    dc_dmub_srv->dmub->meta_info.feature_bits.bits.shared_state_link_detection) {
 		ips_fw = &dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
-		return ips_fw->signals.bits.detection_required;
+		return (bool)ips_fw->signals.bits.detection_required;
 	}
 
 	/* Detection may require reading scratch 0 - exit out of idle prior to the read. */
@@ -1940,7 +1944,7 @@ void dc_dmub_srv_fams2_drr_update(struct dc *dc,
 
 	cmd.fams2_drr_update.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	cmd.fams2_drr_update.header.sub_type = DMUB_CMD__FAMS2_DRR_UPDATE;
-	cmd.fams2_drr_update.dmub_optc_state_req.tg_inst = tg_inst;
+	cmd.fams2_drr_update.dmub_optc_state_req.tg_inst = (uint8_t)tg_inst;
 	cmd.fams2_drr_update.dmub_optc_state_req.v_total_max = vtotal_max;
 	cmd.fams2_drr_update.dmub_optc_state_req.v_total_min = vtotal_min;
 	cmd.fams2_drr_update.dmub_optc_state_req.v_total_mid = vtotal_mid;
@@ -1991,10 +1995,10 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		cmds[num_cmds].fams2_flip.header.multi_cmd_pending = 1;
 
 		/* set topology info */
-		cmds[num_cmds].fams2_flip.flip_info.pipe_mask = dc_plane_get_pipe_mask(state, plane_state);
-		if (stream_status)
-			cmds[num_cmds].fams2_flip.flip_info.otg_inst = stream_status->primary_otg_inst;
-
+		cmds[num_cmds].fams2_flip.flip_info.pipe_mask = (uint8_t)dc_plane_get_pipe_mask(state, plane_state);
+		if (stream_status) {
+			cmds[num_cmds].fams2_flip.flip_info.otg_inst = (uint8_t)stream_status->primary_otg_inst;
+		}
 		cmds[num_cmds].fams2_flip.flip_info.config.bits.is_immediate = plane_state->flip_immediate;
 
 		/* build address info for command */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
index fee69642fb93..664cb4abf623 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
@@ -23,11 +23,11 @@ static bool op_i2c_convert(
 
 	req->type = type;
 	loc->is_aux = false;
-	loc->ddc_line = ddc_line;
+	loc->ddc_line = (uint8_t)ddc_line;
 	loc->over_aux = over_aux;
 	loc->address = op->address;
 	loc->offset = op->offset;
-	loc->length = op->size;
+	loc->length = (uint8_t)op->size;
 	memcpy(req->buffer, op->data, op->size);
 
 	return true;
@@ -84,7 +84,7 @@ static bool atomic_write_poll_read(
 			timeout_us += timeout_per_aux_transaction_us * (io->request.u.aux.length / 16);
 	}
 
-	if (!dm_helpers_execute_fused_io(link->ctx, link, commands, count, timeout_us))
+	if (!dm_helpers_execute_fused_io(link->ctx, link, commands, count, (uint32_t)timeout_us))
 		return false;
 
 	return commands[0].fused_io.request.status == FUSED_REQUEST_STATUS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 77299767096f..e221384f7611 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -122,7 +122,7 @@ static void set_reg_field_values(struct dc_reg_value_masks *field_value_mask,
 		field_value = va_arg(ap, uint32_t);
 
 		set_reg_field_value_masks(field_value_mask,
-				field_value, mask, shift);
+				field_value, mask, (uint8_t)shift);
 		i++;
 	}
 }
@@ -459,7 +459,7 @@ void generic_reg_wait(const struct dc_context *ctx,
 
 		reg_val = dm_read_reg(ctx, addr);
 
-		field_value = get_reg_field_value_ex(reg_val, mask, shift);
+		field_value = get_reg_field_value_ex(reg_val, mask, (uint8_t)shift);
 
 		if (field_value == condition_value) {
 			if (i * delay_between_poll_us > 1000)
@@ -525,7 +525,7 @@ uint32_t generic_indirect_reg_get(const struct dc_context *ctx,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t *);
 
-		*field_value = get_reg_field_value_ex(value, mask, shift);
+		*field_value = get_reg_field_value_ex(value, mask, (uint8_t)shift);
 		i++;
 	}
 
@@ -554,7 +554,7 @@ uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t);
 
-		reg_val = set_reg_field_value_ex(reg_val, field_value, mask, shift);
+		reg_val = set_reg_field_value_ex(reg_val, field_value, mask, (uint8_t)shift);
 		i++;
 	}
 
@@ -584,7 +584,7 @@ uint32_t generic_indirect_reg_update_ex_sync(const struct dc_context *ctx,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t);
 
-		reg_val = set_reg_field_value_ex(reg_val, field_value, mask, shift);
+		reg_val = set_reg_field_value_ex(reg_val, field_value, mask, (uint8_t)shift);
 		i++;
 	}
 
@@ -615,7 +615,7 @@ uint32_t generic_indirect_reg_get_sync(const struct dc_context *ctx,
 		mask = va_arg(ap, uint32_t);
 		field_value = va_arg(ap, uint32_t *);
 
-		*field_value = get_reg_field_value_ex(value, mask, shift);
+		*field_value = get_reg_field_value_ex(value, mask, (uint8_t)shift);
 		i++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index 42cb8b29dd47..1f5a4a8bf691 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -576,7 +576,7 @@ void dccg31_set_dtbclk_dto(
 
 		// phase / modulo = dtbclk / dtbclk ref
 		modulo = params->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+		phase = (uint32_t)div_u64((((unsigned long long)modulo * req_dtbclk_khz) + params->ref_dtbclk_khz - 1),
 				params->ref_dtbclk_khz);
 
 		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
@@ -620,7 +620,7 @@ void dccg31_set_audio_dtbclk_dto(
 
 		// phase / modulo = dtbclk / dtbclk ref
 		modulo = params->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * params->req_audio_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+		phase = (uint32_t)div_u64((((unsigned long long)modulo * params->req_audio_dtbclk_khz) + params->ref_dtbclk_khz - 1),
 			params->ref_dtbclk_khz);
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 72aaf057e775..d49689baa7ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -610,11 +610,13 @@ void dccg401_set_dp_dto(
 		 * int = target_pix_rate / reference_clock
 		 * phase = target_pix_rate - int * reference_clock,
 		 * modulo = reference_clock */
-		dto_integer = div_u64(params->pixclk_hz, dto_modulo_hz);
+
+		/* dto_modulo_hz = refclk (~100 MHz), well within uint32_t range */
+		dto_integer = div_u64(params->pixclk_hz, (uint32_t)dto_modulo_hz);
 		dto_phase_hz = params->pixclk_hz - dto_integer * dto_modulo_hz;
 
-		if (dto_phase_hz <= 0 && dto_integer <= 0) {
-			/* negative pixel rate should never happen */
+		if (dto_phase_hz == 0 && dto_integer == 0) {
+			/* zero pixel rate should never happen */
 			BREAK_TO_DEBUGGER();
 			return;
 		}
@@ -656,25 +658,25 @@ void dccg401_set_dp_dto(
 
 		dccg401_set_dtbclk_p_src(dccg, params->clk_src, params->otg_inst);
 
-		REG_WRITE(DP_DTO_PHASE[params->otg_inst], dto_phase_hz);
-		REG_WRITE(DP_DTO_MODULO[params->otg_inst], dto_modulo_hz);
+		REG_WRITE(DP_DTO_PHASE[params->otg_inst], (uint32_t)dto_phase_hz);
+		REG_WRITE(DP_DTO_MODULO[params->otg_inst], (uint32_t)dto_modulo_hz);
 
 		switch (params->otg_inst) {
 		case 0:
 			REG_UPDATE(OTG_PIXEL_RATE_DIV,
-					DPDTO0_INT, dto_integer);
+					DPDTO0_INT, (uint32_t)dto_integer);
 			break;
 		case 1:
 			REG_UPDATE(OTG_PIXEL_RATE_DIV,
-					DPDTO1_INT, dto_integer);
+					DPDTO1_INT, (uint32_t)dto_integer);
 			break;
 		case 2:
 			REG_UPDATE(OTG_PIXEL_RATE_DIV,
-					DPDTO2_INT, dto_integer);
+					DPDTO2_INT, (uint32_t)dto_integer);
 			break;
 		case 3:
 			REG_UPDATE(OTG_PIXEL_RATE_DIV,
-					DPDTO3_INT, dto_integer);
+					DPDTO3_INT, (uint32_t)dto_integer);
 			break;
 		default:
 			BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 673bb87d2c17..eee58f946fae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -321,7 +321,7 @@ static int read_channel_reply(struct dce_aux *engine, uint32_t size,
 			uint32_t aux_sw_data_val;
 
 			REG_GET(AUX_SW_DATA, AUX_SW_DATA, &aux_sw_data_val);
-			buffer[i] = aux_sw_data_val;
+			buffer[i] = (uint8_t)aux_sw_data_val;
 			++i;
 		}
 
@@ -375,7 +375,7 @@ static enum aux_return_code_type get_channel_status(
 			(value & AUX_SW_STATUS__AUX_SW_RX_RECV_INVALID_L_MASK))
 			return AUX_RET_ERROR_INVALID_REPLY;
 
-		*returned_bytes = get_reg_field_value(value,
+		*returned_bytes = (uint8_t)get_reg_field_value(value,
 				AUX_SW_STATUS,
 				AUX_SW_REPLY_BYTE_COUNT);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 321a012268b0..b97b4cd23eaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -162,11 +162,9 @@ static bool calculate_fb_and_fractional_fb_divider(
 	feedback_divider *= (uint64_t)
 			(calc_pll_cs->fract_fb_divider_precision_factor);
 
-	*feedback_divider_param =
-		div_u64_rem(
-			feedback_divider,
-			calc_pll_cs->fract_fb_divider_factor,
-			fract_feedback_divider_param);
+	*feedback_divider_param = (uint32_t)div_u64_rem(
+		feedback_divider, calc_pll_cs->fract_fb_divider_factor,
+		fract_feedback_divider_param);
 
 	if (*feedback_divider_param != 0)
 		return true;
@@ -240,7 +238,7 @@ static bool calc_fb_divider_checking_tolerance(
 		pll_settings->calculated_pix_clk_100hz =
 			actual_calculated_clock_100hz;
 		pll_settings->vco_freq =
-			div_u64((u64)actual_calculated_clock_100hz * post_divider, 10);
+			(uint32_t)div_u64((u64)actual_calculated_clock_100hz * post_divider, 10);
 		return true;
 	}
 	return false;
@@ -440,8 +438,7 @@ static bool pll_adjust_pix_clk(
 	bp_adjust_pixel_clock_params.
 		encoder_object_id = pix_clk_params->encoder_object_id;
 	bp_adjust_pixel_clock_params.signal_type = pix_clk_params->signal_type;
-	bp_adjust_pixel_clock_params.
-		ss_enable = pix_clk_params->flags.ENABLE_SS;
+	bp_adjust_pixel_clock_params.ss_enable = pix_clk_params->flags.ENABLE_SS != 0;
 	bp_result = clk_src->bios->funcs->adjust_pixel_clock(
 			clk_src->bios, &bp_adjust_pixel_clock_params);
 	if (bp_result == BP_RESULT_OK) {
@@ -958,7 +955,7 @@ static bool dce112_program_pix_clk(
 		dce112_program_pixel_clk_resync(clk_src,
 					pix_clk_params->signal_type,
 					pix_clk_params->color_depth,
-					pix_clk_params->flags.SUPPORT_YCBCR420);
+					pix_clk_params->flags.SUPPORT_YCBCR420 != 0);
 
 	return true;
 }
@@ -1059,7 +1056,7 @@ static bool dcn31_program_pix_clk(
 			dce112_program_pixel_clk_resync(clk_src,
 						pix_clk_params->signal_type,
 						pix_clk_params->color_depth,
-						pix_clk_params->flags.SUPPORT_YCBCR420);
+						pix_clk_params->flags.SUPPORT_YCBCR420 != 0);
 	}
 
 	return true;
@@ -1162,7 +1159,7 @@ static bool dcn401_program_pix_clk(
 			dce112_program_pixel_clk_resync(clk_src,
 						pix_clk_params->signal_type,
 						pix_clk_params->color_depth,
-						pix_clk_params->flags.SUPPORT_YCBCR420);
+						pix_clk_params->flags.SUPPORT_YCBCR420 != 0);
 	}
 
 	return true;
@@ -1211,9 +1208,8 @@ static bool get_pixel_clk_frequency_100hz(
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz)
-				*pixel_clk_khz = div_u64((uint64_t)clock_hz*
-					dp_dto_ref_khz*10,
-					modulo_hz);
+				*pixel_clk_khz = (unsigned int)div_u64((uint64_t)clock_hz *
+					dp_dto_ref_khz * 10, modulo_hz);
 			else
 				*pixel_clk_khz = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index fe239a96121e..05892ab4529f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -120,7 +120,7 @@ static void process_channel_reply(
 		uint32_t i2c_data;
 
 		REG_GET(DC_I2C_DATA, DC_I2C_DATA, &i2c_data);
-		*buffer++ = i2c_data;
+		*buffer++ = (uint8_t)i2c_data;
 
 		--length;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index de31fb1b6819..31a9181c6a2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -209,7 +209,7 @@ static void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
 	if (pwm_period_bitcnt == 0)
 		bit_count = 16;
 	else
-		bit_count = pwm_period_bitcnt;
+		bit_count = (uint8_t)pwm_period_bitcnt;
 
 	/* e.g. maskedPwmPeriod = 0x24 when bitCount is 6 */
 	masked_pwm_period = masked_pwm_period & ((1 << bit_count) - 1);
@@ -224,7 +224,7 @@ static void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
 	 * components shift by bitCount then mask 16 bits and add rounding bit
 	 * from MSB of fraction e.g. 0x86F7 = ((0x21BDC0 >> 6) & 0xFFF) + 0
 	 */
-	backlight_16bit = active_duty_cycle >> bit_count;
+	backlight_16bit = (uint32_t)(active_duty_cycle >> bit_count);
 	backlight_16bit &= 0xFFFF;
 	backlight_16bit += (active_duty_cycle >> (bit_count - 1)) & 0x1;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index c1448ae47366..d178dcc4306d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -802,7 +802,7 @@ static void program_bit_depth_reduction(
 
 	ASSERT(depth <= COLOR_DEPTH_121212); /* Invalid clamp bit depth */
 
-	spatial_dither_enable = bit_depth_params->flags.SPATIAL_DITHER_ENABLED;
+	spatial_dither_enable = bit_depth_params->flags.SPATIAL_DITHER_ENABLED != 0;
 	/* Default to 12 bit truncation without rounding */
 	trunc_round_depth = DCP_OUT_TRUNC_ROUND_DEPTH_12BIT;
 	trunc_mode = DCP_OUT_TRUNC_ROUND_MODE_TRUNCATE;
@@ -835,9 +835,9 @@ static void program_bit_depth_reduction(
 		   spatial_dither_enable,
 		   DCP_SPATIAL_DITHER_MODE_A_AA_A,
 		   DCP_SPATIAL_DITHER_DEPTH_30BPP,
-		   bit_depth_params->flags.FRAME_RANDOM,
-		   bit_depth_params->flags.RGB_RANDOM,
-		   bit_depth_params->flags.HIGHPASS_RANDOM);
+		   bit_depth_params->flags.FRAME_RANDOM != 0,
+		   bit_depth_params->flags.RGB_RANDOM != 0,
+		   bit_depth_params->flags.HIGHPASS_RANDOM != 0);
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 806b5709c9e7..a3cd04fc44f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -176,7 +176,7 @@ void dmub_abm_init_config(struct abm *abm,
 	cmd.abm_init_config.header.type = DMUB_CMD__ABM;
 	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
 	cmd.abm_init_config.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
-	cmd.abm_init_config.abm_init_config_data.bytes = bytes;
+	cmd.abm_init_config.abm_init_config_data.bytes = (uint16_t)bytes;
 	cmd.abm_init_config.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
 	cmd.abm_init_config.abm_init_config_data.panel_mask = panel_mask;
 
@@ -237,7 +237,7 @@ bool dmub_abm_save_restore(
 	cmd.abm_save_restore.header.sub_type = DMUB_CMD__ABM_SAVE_RESTORE;
 
 	cmd.abm_save_restore.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
-	cmd.abm_save_restore.abm_init_config_data.bytes = bytes;
+	cmd.abm_save_restore.abm_init_config_data.bytes = (uint16_t)bytes;
 	cmd.abm_save_restore.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
 	cmd.abm_save_restore.abm_init_config_data.panel_mask = panel_mask;
 
@@ -265,10 +265,10 @@ bool dmub_abm_set_pipe(struct abm *abm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
-	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
-	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = (uint8_t)otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = (uint8_t)pwrseq_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = (uint8_t)option;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = (uint8_t)panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
 	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
 
@@ -308,7 +308,7 @@ bool dmub_abm_set_event(struct abm *abm, unsigned int scaling_enable, unsigned i
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_event.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_event.header.sub_type = DMUB_CMD__ABM_SET_EVENT;
-	cmd.abm_set_event.abm_set_event_data.vb_scaling_enable = scaling_enable;
+	cmd.abm_set_event.abm_set_event_data.vb_scaling_enable = (uint8_t)scaling_enable;
 	cmd.abm_set_event.abm_set_event_data.vb_scaling_strength_mapping = scaling_strength_map;
 	cmd.abm_set_event.abm_set_event_data.panel_mask = (1<<panel_inst);
 	cmd.abm_set_event.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_event_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 87af4fdc04a6..556bae8d4bae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -341,26 +341,26 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->mpcc_inst				= pipe_ctx->plane_res.mpcc_inst;
 
 	if (pipe_ctx->plane_res.dpp)
-		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
+		copy_settings_data->dpp_inst			= (uint8_t)pipe_ctx->plane_res.dpp->inst;
 	else
 		copy_settings_data->dpp_inst			= 0;
 	if (pipe_ctx->stream_res.opp)
-		copy_settings_data->opp_inst			= pipe_ctx->stream_res.opp->inst;
+		copy_settings_data->opp_inst			= (uint8_t)pipe_ctx->stream_res.opp->inst;
 	else
 		copy_settings_data->opp_inst			= 0;
 	if (pipe_ctx->stream_res.tg)
-		copy_settings_data->otg_inst			= pipe_ctx->stream_res.tg->inst;
+		copy_settings_data->otg_inst			= (uint8_t)pipe_ctx->stream_res.tg->inst;
 	else
 		copy_settings_data->otg_inst			= 0;
 
 	// Misc
 	copy_settings_data->use_phy_fsm             = link->ctx->dc->debug.psr_power_use_phy_fsm;
-	copy_settings_data->psr_level				= psr_context->psr_level.u32all;
+	copy_settings_data->psr_level				= (uint16_t)psr_context->psr_level.u32all;
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
 	copy_settings_data->multi_disp_optimizations_en	= psr_context->allow_multi_disp_optimizations;
-	copy_settings_data->frame_delay				= psr_context->frame_delay;
+	copy_settings_data->frame_delay				= (uint8_t)psr_context->frame_delay;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
-	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
+	copy_settings_data->init_sdp_deadline			= (uint16_t)psr_context->sdpTransmitLineNumDeadline;
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fbb7ee44c589..6d19da2230ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -151,22 +151,23 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->digfe_inst				= replay_context->digfe_inst;
 
 	if (pipe_ctx->plane_res.dpp)
-		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
+		copy_settings_data->dpp_inst			= (uint8_t)pipe_ctx->plane_res.dpp->inst;
 	else
 		copy_settings_data->dpp_inst			= 0;
+
 	if (pipe_ctx->stream_res.tg)
-		copy_settings_data->otg_inst			= pipe_ctx->stream_res.tg->inst;
+		copy_settings_data->otg_inst			= (uint8_t)pipe_ctx->stream_res.tg->inst;
 	else
 		copy_settings_data->otg_inst			= 0;
 
 	copy_settings_data->dpphy_inst				= link->link_enc->transmitter;
 
 	// Misc
-	copy_settings_data->line_time_in_ns			= replay_context->line_time_in_ns;
-	copy_settings_data->panel_inst				= panel_inst;
-	copy_settings_data->debug.u32All			= link->replay_settings.config.debug_flags;
+	copy_settings_data->line_time_in_ns			= (uint16_t)replay_context->line_time_in_ns;
+	copy_settings_data->panel_inst				= (uint16_t)panel_inst;
+	copy_settings_data->debug.u32All			= (uint16_t)link->replay_settings.config.debug_flags;
 	copy_settings_data->pixel_deviation_per_line		= link->dpcd_caps.pr_info.pixel_deviation_per_line;
-	copy_settings_data->max_deviation_line			= link->dpcd_caps.pr_info.max_deviation_line;
+	copy_settings_data->max_deviation_line			= (uint16_t)link->dpcd_caps.pr_info.max_deviation_line;
 	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
 	copy_settings_data->replay_timing_sync_supported = link->replay_settings.config.replay_timing_sync_supported;
 	copy_settings_data->replay_support_fast_resync_in_ultra_sleep_mode = link->replay_settings.config.replay_support_fast_resync_in_ultra_sleep_mode;
@@ -193,13 +194,13 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 
 	copy_settings_data->flags.bitfields.alpm_mode = (enum dmub_alpm_mode)link->replay_settings.config.alpm_mode;
 	if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
-		copy_settings_data->auxless_alpm_data.lfps_setup_ns = dc->dc->debug.auxless_alpm_lfps_setup_ns;
-		copy_settings_data->auxless_alpm_data.lfps_period_ns = dc->dc->debug.auxless_alpm_lfps_period_ns;
-		copy_settings_data->auxless_alpm_data.lfps_silence_ns = dc->dc->debug.auxless_alpm_lfps_silence_ns;
+		copy_settings_data->auxless_alpm_data.lfps_setup_ns = (uint16_t)dc->dc->debug.auxless_alpm_lfps_setup_ns;
+		copy_settings_data->auxless_alpm_data.lfps_period_ns = (uint16_t)dc->dc->debug.auxless_alpm_lfps_period_ns;
+		copy_settings_data->auxless_alpm_data.lfps_silence_ns = (uint16_t)dc->dc->debug.auxless_alpm_lfps_silence_ns;
 		copy_settings_data->auxless_alpm_data.lfps_t1_t2_override_us =
-			dc->dc->debug.auxless_alpm_lfps_t1t2_us;
+			(uint16_t)dc->dc->debug.auxless_alpm_lfps_t1t2_us;
 		copy_settings_data->auxless_alpm_data.lfps_t1_t2_offset_us =
-			dc->dc->debug.auxless_alpm_lfps_t1t2_offset_us;
+			(uint16_t)dc->dc->debug.auxless_alpm_lfps_t1t2_offset_us;
 		copy_settings_data->auxless_alpm_data.lttpr_count = link->dc->link_srv->dp_get_lttpr_count(link);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
index 53c03364f5d4..20c18ac87998 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_timing_generator.c
@@ -98,7 +98,7 @@ static void program_pix_dur(struct timing_generator *tg, uint32_t pix_clk_100hz)
 
 	set_reg_field_value(
 		value,
-		pix_dur,
+		(uint32_t)pix_dur,
 		DPG_PIPE_ARBITRATION_CONTROL1,
 		PIXEL_DURATION);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index c702a30563f9..9ffc7fd3212e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -75,8 +75,8 @@ void cm_helper_read_color_matrices(struct dc_context *ctx,
 				csc_c11, &regval0,
 				csc_c12, &regval1);
 
-		regval[2 * i] = regval0;
-		regval[(2 * i) + 1] = regval1;
+		regval[2 * i] = (uint16_t)regval0;
+		regval[(2 * i) + 1] = (uint16_t)regval1;
 
 		i++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
index 6f2a0d5d963b..33a4c07a057c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
@@ -107,35 +107,35 @@ static void mmhubbub3_config_mcif_buf(struct mcif_wb *mcif_wb,
 	struct dcn30_mmhubbub *mcif_wb30 = TO_DCN30_MMHUBBUB(mcif_wb);
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB_BUF_1_ADDR_Y, MCIF_ADDR(params->luma_address[0]));
+	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB_BUF_1_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[0]));
 	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y_HIGH, MCIF_WB_BUF_1_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[0]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C, MCIF_WB_BUF_1_ADDR_C, MCIF_ADDR(params->chroma_address[0]));
+	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C, MCIF_WB_BUF_1_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[0]));
 	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C_HIGH, MCIF_WB_BUF_1_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[0]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB_BUF_2_ADDR_Y, MCIF_ADDR(params->luma_address[1]));
+	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB_BUF_2_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[1]));
 	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y_HIGH, MCIF_WB_BUF_2_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[1]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C, MCIF_WB_BUF_2_ADDR_C, MCIF_ADDR(params->chroma_address[1]));
+	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C, MCIF_WB_BUF_2_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[1]));
 	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C_HIGH, MCIF_WB_BUF_2_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[1]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y, MCIF_WB_BUF_3_ADDR_Y, MCIF_ADDR(params->luma_address[2]));
+	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y, MCIF_WB_BUF_3_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[2]));
 	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y_HIGH, MCIF_WB_BUF_3_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[2]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, MCIF_ADDR(params->chroma_address[2]));
+	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[2]));
 	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C_HIGH, MCIF_WB_BUF_3_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[2]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, MCIF_ADDR(params->luma_address[3]));
+	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[3]));
 	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y_HIGH, MCIF_WB_BUF_4_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[3]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, MCIF_ADDR(params->chroma_address[3]));
+	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[3]));
 	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C_HIGH, MCIF_WB_BUF_4_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[3]));
 
 	/* setup luma & chroma size
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 2d33ed0c062d..79d0c2896d29 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -43,7 +43,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	enc1->se_shift->field_name, enc1->se_mask->field_name
+	(uint8_t)enc1->se_shift->field_name, enc1->se_mask->field_name
 
 #define VBI_LINE_0 0
 #define HDMI_CLOCK_CHANNEL_RATE_MORE_340M 340000
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
index 65afbfcaa96b..55ddb9cf8a52 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
@@ -23,7 +23,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	enc1->se_shift->field_name, enc1->se_mask->field_name
+	(uint8_t)enc1->se_shift->field_name, enc1->se_mask->field_name
 
 #define VBI_LINE_0 0
 #define HDMI_CLOCK_CHANNEL_RATE_MORE_340M 340000
@@ -401,7 +401,7 @@ void enc42_se_enable_audio_clock(
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DIG_FE_AUDIO_CNTL, APG_CLOCK_ENABLE, !!enable);
+	REG_UPDATE(DIG_FE_AUDIO_CNTL, APG_CLOCK_ENABLE, enable);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 61553e24d53e..a95f94d6c7c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -533,13 +533,14 @@ static void split_stream_across_pipes(
 
 	*secondary_pipe = *primary_pipe;
 
-	secondary_pipe->pipe_idx = pipe_idx;
+	secondary_pipe->pipe_idx = (uint8_t)pipe_idx;
 	secondary_pipe->plane_res.mi = pool->mis[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.hubp = pool->hubps[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.ipp = pool->ipps[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.xfm = pool->transforms[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.dpp = pool->dpps[secondary_pipe->pipe_idx];
-	secondary_pipe->plane_res.mpcc_inst = pool->dpps[secondary_pipe->pipe_idx]->inst;
+	secondary_pipe->plane_res.mpcc_inst =
+			(uint8_t)pool->dpps[secondary_pipe->pipe_idx]->inst;
 	if (primary_pipe->bottom_pipe) {
 		ASSERT(primary_pipe->bottom_pipe != secondary_pipe);
 		secondary_pipe->bottom_pipe = primary_pipe->bottom_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 887744d56d6a..ed9dd2148d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1402,11 +1402,12 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 			timing->h_addressable + timing->h_border_left + timing->h_border_right;
 		pipes[pipe_cnt].pipe.dest.vactive =
 			timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
-		pipes[pipe_cnt].pipe.dest.interlaced = timing->flags.INTERLACE;
+		pipes[pipe_cnt].pipe.dest.interlaced = (unsigned char)timing->flags.INTERLACE;
 		pipes[pipe_cnt].pipe.dest.pixel_rate_mhz = timing->pix_clk_100hz/10000.0;
 		if (timing->timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 			pipes[pipe_cnt].pipe.dest.pixel_rate_mhz *= 2;
-		pipes[pipe_cnt].pipe.dest.otg_inst = res_ctx->pipe_ctx[i].stream_res.tg->inst;
+		pipes[pipe_cnt].pipe.dest.otg_inst =
+				(unsigned char)res_ctx->pipe_ctx[i].stream_res.tg->inst;
 		pipes[pipe_cnt].dout.dp_lanes = 4;
 		pipes[pipe_cnt].dout.dp_rate = dm_dp_rate_na;
 		pipes[pipe_cnt].dout.is_virtual = 0;
@@ -1879,7 +1880,7 @@ void dcn20_update_bounding_box(struct dc *dc,
 		bb->clock_limits[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
 
 		// FCLK:UCLK ratio is 1.08
-		min_fclk_required_by_uclk = div_u64(((unsigned long long)uclk_states[i]) * 1080,
+		min_fclk_required_by_uclk = (int)div_u64(((unsigned long long)uclk_states[i]) * 1080,
 			1000000);
 
 		bb->clock_limits[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 0cdd60869ce1..354641312acc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -662,7 +662,7 @@ void dcn3_fpu_build_wm_range_table(struct clk_mgr *base)
 	double pstate_latency_us = base->ctx->dc->dml.soc.dram_clock_change_latency_us;
 	double sr_exit_time_us = base->ctx->dc->dml.soc.sr_exit_time_us;
 	double sr_enter_plus_exit_time_us = base->ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
-	uint16_t min_uclk_mhz = base->bw_params->clk_table.entries[0].memclk_mhz;
+	uint16_t min_uclk_mhz = (uint16_t)base->bw_params->clk_table.entries[0].memclk_mhz;
 
 	dc_assert_fp_enabled();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index eb199215d298..f5ddf771e73d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -191,21 +191,24 @@ void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 	double sr_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_exit_time_us;
 	double sr_enter_plus_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
 	/* For min clocks use as reported by PM FW and report those as min */
-	uint16_t min_uclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz;
-	uint16_t min_dcfclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
+	uint16_t min_uclk_mhz			= (uint16_t)clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz;
+	uint16_t min_dcfclk_mhz			= (uint16_t)clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
 	uint16_t setb_min_uclk_mhz		= min_uclk_mhz;
-	uint16_t dcfclk_mhz_for_the_second_state = clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
+	uint16_t dcfclk_mhz_for_the_second_state =
+			(uint16_t)clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
 
 	dc_assert_fp_enabled();
 
 	/* For Set B ranges use min clocks state 2 when available, and report those to PM FW */
-	if (dcfclk_mhz_for_the_second_state)
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = dcfclk_mhz_for_the_second_state;
-	else
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
+	if (dcfclk_mhz_for_the_second_state) {
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk =
+				(uint16_t)dcfclk_mhz_for_the_second_state;
+	} else
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk =
+				(uint16_t)clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
 
 	if (clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz)
-		setb_min_uclk_mhz = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz;
+		setb_min_uclk_mhz = (uint16_t)clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz;
 
 	/* Set A - Normal - default values */
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].valid = true;
@@ -901,7 +904,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 	struct pipe_ctx *subvp_pipe = NULL;
 	bool found = false;
 	bool schedulable = false;
-	uint32_t i = 0;
+	uint8_t i = 0;
 	uint8_t vblank_index = 0;
 	uint16_t prefetch_us = 0;
 	uint16_t mall_region_us = 0;
@@ -986,7 +989,7 @@ static bool subvp_subvp_admissable(struct dc *dc,
 				struct dc_state *context)
 {
 	bool result = false;
-	uint32_t i;
+	uint8_t i;
 	uint8_t subvp_count = 0;
 	uint32_t min_refresh = subvp_high_refresh_list.min_refresh, max_refresh = 0;
 	uint64_t refresh_rate = 0;
@@ -1779,7 +1782,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
 
 	if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
 		pipe = &context->res_ctx.pipe_ctx[old_index];
-		pipe->pipe_idx = old_index;
+		pipe->pipe_idx = (uint8_t)old_index;
 	}
 
 	if (!pipe)
@@ -1788,7 +1791,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
 					&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
 				if (context->res_ctx.pipe_ctx[i].stream == NULL) {
 					pipe = &context->res_ctx.pipe_ctx[i];
-					pipe->pipe_idx = i;
+					pipe->pipe_idx = (uint8_t)i;
 					break;
 				}
 			}
@@ -1803,7 +1806,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
 		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
 			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
 				pipe = &context->res_ctx.pipe_ctx[i];
-				pipe->pipe_idx = i;
+				pipe->pipe_idx = (uint8_t)i;
 				break;
 			}
 		}
@@ -1846,13 +1849,13 @@ static bool dcn32_split_stream_for_mpc_or_odm(
 
 	*sec_pipe = *pri_pipe;
 
-	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->pipe_idx = (uint8_t)pipe_idx;
 	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
 	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
 	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
 	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
 	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
-	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 	sec_pipe->stream_res.dsc = NULL;
 	if (odm) {
 		if (pri_pipe->next_odm_pipe) {
@@ -3365,8 +3368,8 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
 			(uint64_t)pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
-		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
-		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
+		refresh_rate = (uint32_t)div_u64(refresh_rate, pipe->stream->timing.v_total);
+		refresh_rate = (uint32_t)div_u64(refresh_rate, pipe->stream->timing.h_total);
 
 		if (refresh_rate >= min_refresh && refresh_rate <= max_refresh &&
 				dcn32_check_native_scaling_for_res(pipe, width, height)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 6e1e759462bf..9e63d075c1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -405,12 +405,12 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 	dsc_reg_vals->pixel_format = dsc_dc_pixel_encoding_to_dsc_pixel_format(dsc_cfg->pixel_encoding, dsc_cfg->dc_dsc_cfg.ycbcr422_simple);
 	dsc_reg_vals->num_slices_h = dsc_cfg->dc_dsc_cfg.num_slices_h;
 	dsc_reg_vals->num_slices_v = dsc_cfg->dc_dsc_cfg.num_slices_v;
-	dsc_reg_vals->pps.dsc_version_minor = dsc_cfg->dc_dsc_cfg.version_minor;
-	dsc_reg_vals->pps.pic_width = dsc_cfg->pic_width;
-	dsc_reg_vals->pps.pic_height = dsc_cfg->pic_height;
+	dsc_reg_vals->pps.dsc_version_minor = (u8)dsc_cfg->dc_dsc_cfg.version_minor;
+	dsc_reg_vals->pps.pic_width = (u16)dsc_cfg->pic_width;
+	dsc_reg_vals->pps.pic_height = (u16)dsc_cfg->pic_height;
 	dsc_reg_vals->pps.bits_per_component = dsc_dc_color_depth_to_dsc_bits_per_comp(dsc_cfg->color_depth);
 	dsc_reg_vals->pps.block_pred_enable = dsc_cfg->dc_dsc_cfg.block_pred_enable;
-	dsc_reg_vals->pps.line_buf_depth = dsc_cfg->dc_dsc_cfg.linebuf_depth;
+	dsc_reg_vals->pps.line_buf_depth = (u8)dsc_cfg->dc_dsc_cfg.linebuf_depth;
 	dsc_reg_vals->alternate_ich_encoding_en = dsc_reg_vals->pps.dsc_version_minor == 1 ? 0 : 1;
 	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
@@ -428,9 +428,9 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 
 	dsc_reg_vals->bpp_x32 = dsc_cfg->dc_dsc_cfg.bits_per_pixel << 1;
 	if (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR420 || dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR422)
-		dsc_reg_vals->pps.bits_per_pixel = dsc_reg_vals->bpp_x32;
+		dsc_reg_vals->pps.bits_per_pixel = (u16)dsc_reg_vals->bpp_x32;
 	else
-		dsc_reg_vals->pps.bits_per_pixel = dsc_reg_vals->bpp_x32 >> 1;
+		dsc_reg_vals->pps.bits_per_pixel = (u16)(dsc_reg_vals->bpp_x32 >> 1);
 
 	dsc_reg_vals->pps.convert_rgb = dsc_reg_vals->pixel_format == DSC_PIXFMT_RGB ? 1 : 0;
 	dsc_reg_vals->pps.native_422 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR422);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 59864130cf83..a34031b5c9d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -72,27 +72,27 @@ static void copy_rc_to_cfg(struct drm_dsc_config *dsc_cfg, const struct rc_param
 {
 	int i;
 
-	dsc_cfg->rc_quant_incr_limit0   = rc->rc_quant_incr_limit0;
-	dsc_cfg->rc_quant_incr_limit1   = rc->rc_quant_incr_limit1;
-	dsc_cfg->initial_offset         = rc->initial_fullness_offset;
-	dsc_cfg->initial_xmit_delay     = rc->initial_xmit_delay;
-	dsc_cfg->first_line_bpg_offset  = rc->first_line_bpg_offset;
-	dsc_cfg->second_line_bpg_offset = rc->second_line_bpg_offset;
-	dsc_cfg->flatness_min_qp        = rc->flatness_min_qp;
-	dsc_cfg->flatness_max_qp        = rc->flatness_max_qp;
+	dsc_cfg->rc_quant_incr_limit0   = (u8)rc->rc_quant_incr_limit0;
+	dsc_cfg->rc_quant_incr_limit1   = (u8)rc->rc_quant_incr_limit1;
+	dsc_cfg->initial_offset         = (u16)rc->initial_fullness_offset;
+	dsc_cfg->initial_xmit_delay     = (u16)rc->initial_xmit_delay;
+	dsc_cfg->first_line_bpg_offset  = (u8)rc->first_line_bpg_offset;
+	dsc_cfg->second_line_bpg_offset = (u8)rc->second_line_bpg_offset;
+	dsc_cfg->flatness_min_qp        = (u8)rc->flatness_min_qp;
+	dsc_cfg->flatness_max_qp        = (u8)rc->flatness_max_qp;
 	for (i = 0; i < QP_SET_SIZE; ++i) {
-		dsc_cfg->rc_range_params[i].range_min_qp     = rc->qp_min[i];
-		dsc_cfg->rc_range_params[i].range_max_qp     = rc->qp_max[i];
+		dsc_cfg->rc_range_params[i].range_min_qp     = (u8)rc->qp_min[i];
+		dsc_cfg->rc_range_params[i].range_max_qp     = (u8)rc->qp_max[i];
 		/* Truncate 8-bit signed value to 6-bit signed value */
 		dsc_cfg->rc_range_params[i].range_bpg_offset = 0x3f & rc->ofs[i];
 	}
-	dsc_cfg->rc_model_size    = rc->rc_model_size;
-	dsc_cfg->rc_edge_factor   = rc->rc_edge_factor;
-	dsc_cfg->rc_tgt_offset_high = rc->rc_tgt_offset_hi;
-	dsc_cfg->rc_tgt_offset_low = rc->rc_tgt_offset_lo;
+	dsc_cfg->rc_model_size    = (u16)rc->rc_model_size;
+	dsc_cfg->rc_edge_factor   = (u8)rc->rc_edge_factor;
+	dsc_cfg->rc_tgt_offset_high = (u8)rc->rc_tgt_offset_hi;
+	dsc_cfg->rc_tgt_offset_low = (u8)rc->rc_tgt_offset_lo;
 
 	for (i = 0; i < QP_SET_SIZE - 1; ++i)
-		dsc_cfg->rc_buf_thresh[i] = rc->rc_buf_thresh[i];
+		dsc_cfg->rc_buf_thresh[i] = (u16)rc->rc_buf_thresh[i];
 }
 
 int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index d9e6e70dc394..b99a361e68e6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -36,7 +36,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	ddc->shifts->field_name, ddc->masks->field_name
+	gpio_reg_shift(ddc->shifts->field_name), ddc->masks->field_name
 
 #define CTX \
 	ddc->base.base.ctx
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
index 6cd50232c432..1bb295f6f3b9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
@@ -37,7 +37,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	generic->shifts->field_name, generic->masks->field_name
+	gpio_reg_shift(generic->shifts->field_name), generic->masks->field_name
 
 #define CTX \
 	generic->base.base.ctx
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
index f0d400972897..07651dc7e205 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c
@@ -32,7 +32,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	gpio->regs->field_name ## _shift, gpio->regs->field_name ## _mask
+	gpio_reg_shift(gpio->regs->field_name ## _shift), gpio->regs->field_name ## _mask
 
 #define CTX \
 	gpio->base.ctx
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h
index bca0cef18ff9..5b551068cdd6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h
@@ -141,4 +141,13 @@ enum gpio_result dal_hw_gpio_change_mode(
 void dal_hw_gpio_close(
 	struct hw_gpio_pin *ptr);
 
+/*
+ * Shared helper used by all GPIO register helpers that pass a field shift
+ * (stored as uint32_t) into register functions that expect uint8_t.
+ */
+static inline uint8_t gpio_reg_shift(uint32_t shift)
+{
+	return (uint8_t)shift;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
index 01ec451004f7..b81a2f2630a6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
@@ -35,7 +35,7 @@
 
 #undef FN
 #define FN(reg_name, field_name) \
-	hpd->shifts->field_name, hpd->masks->field_name
+	gpio_reg_shift(hpd->shifts->field_name), hpd->masks->field_name
 
 #define CTX \
 	hpd->base.base.ctx
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index 97ef8281a476..d683d0740c13 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -638,27 +638,27 @@ void hubbub1_update_dchub(
 				SDPIF_FB_BASE, 0x0FFFF);
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_BASE,
-				SDPIF_AGP_BASE, dh_data->zfb_phys_addr_base >> 22);
+				SDPIF_AGP_BASE, (uint32_t)(dh_data->zfb_phys_addr_base >> 22));
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_BOT,
-				SDPIF_AGP_BOT, dh_data->zfb_mc_base_addr >> 22);
+				SDPIF_AGP_BOT, (uint32_t)(dh_data->zfb_mc_base_addr >> 22));
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_TOP,
-				SDPIF_AGP_TOP, (dh_data->zfb_mc_base_addr +
-						dh_data->zfb_size_in_byte - 1) >> 22);
+				SDPIF_AGP_TOP, (uint32_t)((dh_data->zfb_mc_base_addr +
+						dh_data->zfb_size_in_byte - 1) >> 22));
 		break;
 	case FRAME_BUFFER_MODE_MIXED_ZFB_AND_LOCAL:
 		/*Should not touch FB LOCATION (done by VBIOS on AsicInit table)*/
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_BASE,
-				SDPIF_AGP_BASE, dh_data->zfb_phys_addr_base >> 22);
+				SDPIF_AGP_BASE, (uint32_t)(dh_data->zfb_phys_addr_base >> 22));
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_BOT,
-				SDPIF_AGP_BOT, dh_data->zfb_mc_base_addr >> 22);
+				SDPIF_AGP_BOT, (uint32_t)(dh_data->zfb_mc_base_addr >> 22));
 
 		REG_UPDATE(DCHUBBUB_SDPIF_AGP_TOP,
-				SDPIF_AGP_TOP, (dh_data->zfb_mc_base_addr +
-						dh_data->zfb_size_in_byte - 1) >> 22);
+				SDPIF_AGP_TOP, (uint32_t)((dh_data->zfb_mc_base_addr +
+						dh_data->zfb_size_in_byte - 1) >> 22));
 		break;
 	case FRAME_BUFFER_MODE_LOCAL_ONLY:
 		/*Should not touch FB LOCATION (done by VBIOS on AsicInit table)*/
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 5c6f7ddafd6b..053a08b6d3a3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -398,17 +398,17 @@ int hubbub2_init_dchub_sys_ctx(struct hubbub *hubbub,
 	struct dcn_vmid_page_table_config phys_config;
 
 	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
-			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+			FB_BASE, ADDR_HI24(pa_config->system_aperture.fb_base));
 	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
-			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+			FB_TOP, ADDR_HI24(pa_config->system_aperture.fb_top));
 	REG_SET(DCN_VM_FB_OFFSET, 0,
-			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+			FB_OFFSET, ADDR_HI24(pa_config->system_aperture.fb_offset));
 	REG_SET(DCN_VM_AGP_BOT, 0,
-			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+			AGP_BOT, ADDR_HI24(pa_config->system_aperture.agp_bot));
 	REG_SET(DCN_VM_AGP_TOP, 0,
-			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+			AGP_TOP, ADDR_HI24(pa_config->system_aperture.agp_top));
 	REG_SET(DCN_VM_AGP_BASE, 0,
-			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+			AGP_BASE, ADDR_HI24(pa_config->system_aperture.agp_base));
 
 	REG_SET(DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB, 0,
 			DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB, (pa_config->page_table_default_page_addr >> 44) & 0xF);
@@ -447,36 +447,36 @@ void hubbub2_update_dchub(struct hubbub *hubbub,
 
 		/*This field defines the 24 MSBs, bits [47:24] of the 48 bit AGP Base*/
 		REG_UPDATE(DCN_VM_AGP_BASE,
-				AGP_BASE, dh_data->zfb_phys_addr_base >> 24);
+				AGP_BASE, ADDR_HI24(dh_data->zfb_phys_addr_base));
 
 		/*This field defines the bottom range of the AGP aperture and represents the 24*/
 		/*MSBs, bits [47:24] of the 48 address bits*/
 		REG_UPDATE(DCN_VM_AGP_BOT,
-				AGP_BOT, dh_data->zfb_mc_base_addr >> 24);
+				AGP_BOT, ADDR_HI24(dh_data->zfb_mc_base_addr));
 
 		/*This field defines the top range of the AGP aperture and represents the 24*/
 		/*MSBs, bits [47:24] of the 48 address bits*/
 		REG_UPDATE(DCN_VM_AGP_TOP,
-				AGP_TOP, (dh_data->zfb_mc_base_addr +
-						dh_data->zfb_size_in_byte - 1) >> 24);
+				AGP_TOP, ADDR_HI24(dh_data->zfb_mc_base_addr +
+						dh_data->zfb_size_in_byte - 1));
 		break;
 	case FRAME_BUFFER_MODE_MIXED_ZFB_AND_LOCAL:
 		/*Should not touch FB LOCATION (done by VBIOS on AsicInit table)*/
 
 		/*This field defines the 24 MSBs, bits [47:24] of the 48 bit AGP Base*/
 		REG_UPDATE(DCN_VM_AGP_BASE,
-				AGP_BASE, dh_data->zfb_phys_addr_base >> 24);
+				AGP_BASE, ADDR_HI24(dh_data->zfb_phys_addr_base));
 
 		/*This field defines the bottom range of the AGP aperture and represents the 24*/
 		/*MSBs, bits [47:24] of the 48 address bits*/
 		REG_UPDATE(DCN_VM_AGP_BOT,
-				AGP_BOT, dh_data->zfb_mc_base_addr >> 24);
+				AGP_BOT, ADDR_HI24(dh_data->zfb_mc_base_addr));
 
 		/*This field defines the top range of the AGP aperture and represents the 24*/
 		/*MSBs, bits [47:24] of the 48 address bits*/
 		REG_UPDATE(DCN_VM_AGP_TOP,
-				AGP_TOP, (dh_data->zfb_mc_base_addr +
-						dh_data->zfb_size_in_byte - 1) >> 24);
+				AGP_TOP, ADDR_HI24(dh_data->zfb_mc_base_addr +
+						dh_data->zfb_size_in_byte - 1));
 		break;
 	case FRAME_BUFFER_MODE_LOCAL_ONLY:
 		/*Should not touch FB LOCATION (should be done by VBIOS)*/
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
index 46d8f5c70750..6223dfaee270 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
@@ -141,4 +141,7 @@ void hubbub2_wm_read_state(struct hubbub *hubbub,
 void hubbub2_read_state(struct hubbub *hubbub,
 		struct dcn_hubbub_state *hubbub_state);
 
+/* Extract bits [47:24] of a physical address for hardware register fields */
+#define ADDR_HI24(a)  ((uint32_t)((uint64_t)(a) >> 24))
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
index e4496ad203b2..d790d6ee359a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
@@ -111,17 +111,17 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 	struct dcn_vmid_page_table_config phys_config;
 
 	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
-			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+			FB_BASE, ADDR_HI24(pa_config->system_aperture.fb_base));
 	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
-			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+			FB_TOP, ADDR_HI24(pa_config->system_aperture.fb_top));
 	REG_SET(DCN_VM_FB_OFFSET, 0,
-			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+			FB_OFFSET, ADDR_HI24(pa_config->system_aperture.fb_offset));
 	REG_SET(DCN_VM_AGP_BOT, 0,
-			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+			AGP_BOT, ADDR_HI24(pa_config->system_aperture.agp_bot));
 	REG_SET(DCN_VM_AGP_TOP, 0,
-			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+			AGP_TOP, ADDR_HI24(pa_config->system_aperture.agp_top));
 	REG_SET(DCN_VM_AGP_BASE, 0,
-			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+			AGP_BASE, ADDR_HI24(pa_config->system_aperture.agp_base));
 
 	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
 		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index 181a93dc46e6..6a7c1bee5747 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -68,17 +68,17 @@ int hubbub3_init_dchub_sys_ctx(struct hubbub *hubbub,
 	struct dcn_vmid_page_table_config phys_config;
 
 	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
-			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+			FB_BASE, ADDR_HI24(pa_config->system_aperture.fb_base));
 	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
-			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+			FB_TOP, ADDR_HI24(pa_config->system_aperture.fb_top));
 	REG_SET(DCN_VM_FB_OFFSET, 0,
-			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+			FB_OFFSET, ADDR_HI24(pa_config->system_aperture.fb_offset));
 	REG_SET(DCN_VM_AGP_BOT, 0,
-			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+			AGP_BOT, ADDR_HI24(pa_config->system_aperture.agp_bot));
 	REG_SET(DCN_VM_AGP_TOP, 0,
-			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+			AGP_TOP, ADDR_HI24(pa_config->system_aperture.agp_top));
 	REG_SET(DCN_VM_AGP_BASE, 0,
-			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+			AGP_BASE, ADDR_HI24(pa_config->system_aperture.agp_base));
 
 	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
 		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index 3c298192f359..79cb506be5cb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -910,17 +910,17 @@ int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 	struct dcn_vmid_page_table_config phys_config;
 
 	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
-			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+			FB_BASE, ADDR_HI24(pa_config->system_aperture.fb_base));
 	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
-			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+			FB_TOP, ADDR_HI24(pa_config->system_aperture.fb_top));
 	REG_SET(DCN_VM_FB_OFFSET, 0,
-			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+			FB_OFFSET, ADDR_HI24(pa_config->system_aperture.fb_offset));
 	REG_SET(DCN_VM_AGP_BOT, 0,
-			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+			AGP_BOT, ADDR_HI24(pa_config->system_aperture.agp_bot));
 	REG_SET(DCN_VM_AGP_TOP, 0,
-			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+			AGP_TOP, ADDR_HI24(pa_config->system_aperture.agp_top));
 	REG_SET(DCN_VM_AGP_BASE, 0,
-			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+			AGP_BASE, ADDR_HI24(pa_config->system_aperture.agp_base));
 
 	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
 		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index ceee5165fd6a..244d4462fa9e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -68,10 +68,10 @@ void hubp2_set_vm_system_aperture_settings(struct hubp *hubp,
 			DCN_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB, mc_vm_apt_default.low_part);
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.quad_part);
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.low_part);
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.quad_part);
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.low_part);
 
 	REG_SET_2(DCN_VM_MX_L1_TLB_CNTL, 0,
 			ENABLE_L1_TLB, 1,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index 08ea0a1b9e7f..67828505939a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -238,10 +238,10 @@ static void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
 	mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.quad_part);
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.low_part);
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.quad_part);
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.low_part);
 
 	REG_SET_2(DCN_VM_MX_L1_TLB_CNTL, 0,
 			ENABLE_L1_TLB, 1,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index e2708e30eb1b..3e5ae0eae39f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -55,10 +55,10 @@ void hubp3_set_vm_system_aperture_settings(struct hubp *hubp,
 	mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.quad_part);
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR, mc_vm_apt_low.low_part);
 
 	REG_SET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR, 0,
-			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.quad_part);
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, mc_vm_apt_high.low_part);
 
 	REG_SET_2(DCN_VM_MX_L1_TLB_CNTL, 0,
 			ENABLE_L1_TLB, 1,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5273ca09fe12..f2ac516b685f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -858,7 +858,7 @@ void dce110_edp_power_control(
 				DC_LOG_HW_RESUME_S3(
 						"%s: remaining_min_edp_poweroff_time_ms=%llu: begin wait.\n",
 						__func__, remaining_min_edp_poweroff_time_ms);
-				msleep(remaining_min_edp_poweroff_time_ms);
+				msleep((unsigned int)remaining_min_edp_poweroff_time_ms);
 				DC_LOG_HW_RESUME_S3(
 						"%s: remaining_min_edp_poweroff_time_ms=%llu: end wait.\n",
 						__func__, remaining_min_edp_poweroff_time_ms);
@@ -883,7 +883,7 @@ void dce110_edp_power_control(
 		cntl.coherent = false;
 		cntl.lanes_number = LANE_COUNT_FOUR;
 		cntl.hpd_sel = link->link_enc->hpd_source;
-		pwrseq_instance = link->panel_cntl->pwrseq_inst;
+		pwrseq_instance = (uint8_t)link->panel_cntl->pwrseq_inst;
 
 		if (ctx->dc->ctx->dmub_srv &&
 				ctx->dc->debug.dmub_command_table) {
@@ -952,7 +952,7 @@ void dce110_edp_wait_for_T12(
 		t12_duration += link->panel_config.pps.extra_t12_ms; // Add extra T12
 
 		if (time_since_edp_poweroff_ms < t12_duration)
-			msleep(t12_duration - time_since_edp_poweroff_ms);
+			msleep((unsigned int)(t12_duration - time_since_edp_poweroff_ms));
 	}
 }
 /*todo: cloned in stream enc, fix*/
@@ -1021,8 +1021,9 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	if (link->panel_cntl)
-		pwrseq_instance = link->panel_cntl->pwrseq_inst;
+	if (link->panel_cntl) {
+		pwrseq_instance = (uint8_t)link->panel_cntl->pwrseq_inst;
+	}
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -1439,7 +1440,7 @@ void build_audio_output(
 	audio_output->crtc_info.pixel_repetition = 1;
 
 	audio_output->crtc_info.interlaced =
-			stream->timing.flags.INTERLACE;
+			(stream->timing.flags.INTERLACE != 0);
 
 	audio_output->crtc_info.refresh_rate =
 		(stream->timing.pix_clk_100hz*100)/
@@ -1839,7 +1840,7 @@ static void power_down_all_hw_blocks(struct dc *dc)
 static void disable_vga_and_power_gate_all_controllers(
 		struct dc *dc)
 {
-	int i;
+	uint8_t i;
 	struct timing_generator *tg;
 	struct dc_context *ctx = dc->ctx;
 
@@ -1869,7 +1870,7 @@ static void get_edp_streams(struct dc_state *context,
 		struct dc_stream_state **edp_streams,
 		int *edp_stream_num)
 {
-	int i;
+	uint8_t i;
 
 	*edp_stream_num = 0;
 	for (i = 0; i < context->stream_count; i++) {
@@ -2115,9 +2116,11 @@ static uint32_t compute_pstate_blackout_duration(
 	const struct dc_stream_state *stream)
 {
 	uint32_t total_dest_line_time_ns;
+	int64_t pstate_blackout_duration_ns64;
 	uint32_t pstate_blackout_duration_ns;
 
-	pstate_blackout_duration_ns = 1000 * blackout_duration.value >> 24;
+	pstate_blackout_duration_ns64 = (1000 * blackout_duration.value) >> 24;
+	pstate_blackout_duration_ns = (uint32_t)pstate_blackout_duration_ns64;
 
 	total_dest_line_time_ns = 1000000UL *
 		(stream->timing.h_total * 10) /
@@ -2574,7 +2577,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 		}
 
 		hws->funcs.enable_display_power_gating(
-				dc, i, dc->ctx->dc_bios,
+				dc, (uint8_t)i, dc->ctx->dc_bios,
 				PIPE_GATING_CONTROL_DISABLE);
 	}
 
@@ -2919,10 +2922,10 @@ static void dce110_init_hw(struct dc *dc)
 		xfm->funcs->transform_reset(xfm);
 
 		hws->funcs.enable_display_power_gating(
-				dc, i, bp,
+				dc, (uint8_t)i, bp,
 				PIPE_GATING_CONTROL_INIT);
 		hws->funcs.enable_display_power_gating(
-				dc, i, bp,
+				dc, (uint8_t)i, bp,
 				PIPE_GATING_CONTROL_DISABLE);
 		hws->funcs.enable_display_pipe_clock_gating(
 			dc->ctx,
@@ -3180,7 +3183,7 @@ static void dce110_power_down_fe(struct dc *dc, struct dc_state *state, struct p
 		return;
 
 	hws->funcs.enable_display_power_gating(
-		dc, fe_idx, dc->ctx->dc_bios, PIPE_GATING_CONTROL_ENABLE);
+		dc, (uint8_t)fe_idx, dc->ctx->dc_bios, PIPE_GATING_CONTROL_ENABLE);
 
 	dc->res_pool->transforms[fe_idx]->funcs->transform_reset(
 				dc->res_pool->transforms[fe_idx]);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
index 0689bbf12ad8..fbe34d1bb39a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
@@ -208,24 +208,24 @@ static void dce120_update_dchub(
 				FB_BASE, 0x0FFFF);
 
 		REG_UPDATE(DCHUB_AGP_BASE,
-				AGP_BASE, dh_data->zfb_phys_addr_base >> 22);
+				AGP_BASE, (uint32_t)(dh_data->zfb_phys_addr_base >> 22));
 
 		REG_UPDATE(DCHUB_AGP_BOT,
-				AGP_BOT, dh_data->zfb_mc_base_addr >> 22);
+				AGP_BOT, (uint32_t)(dh_data->zfb_mc_base_addr >> 22));
 
 		REG_UPDATE(DCHUB_AGP_TOP,
-				AGP_TOP, (dh_data->zfb_mc_base_addr + dh_data->zfb_size_in_byte - 1) >> 22);
+				AGP_TOP, (uint32_t)((dh_data->zfb_mc_base_addr + dh_data->zfb_size_in_byte - 1) >> 22));
 		break;
 	case FRAME_BUFFER_MODE_MIXED_ZFB_AND_LOCAL:
 		/*Should not touch FB LOCATION (done by VBIOS on AsicInit table)*/
 		REG_UPDATE(DCHUB_AGP_BASE,
-				AGP_BASE, dh_data->zfb_phys_addr_base >> 22);
+				AGP_BASE, (uint32_t)(dh_data->zfb_phys_addr_base >> 22));
 
 		REG_UPDATE(DCHUB_AGP_BOT,
-				AGP_BOT, dh_data->zfb_mc_base_addr >> 22);
+				AGP_BOT, (uint32_t)(dh_data->zfb_mc_base_addr >> 22));
 
 		REG_UPDATE(DCHUB_AGP_TOP,
-				AGP_TOP, (dh_data->zfb_mc_base_addr + dh_data->zfb_size_in_byte - 1) >> 22);
+				AGP_TOP, (uint32_t)((dh_data->zfb_mc_base_addr + dh_data->zfb_size_in_byte - 1) >> 22));
 		break;
 	case FRAME_BUFFER_MODE_LOCAL_ONLY:
 		/*Should not touch FB LOCATION (done by VBIOS on AsicInit table)*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index f1fd372e3826..566edc05b99d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1574,7 +1574,7 @@ void dcn10_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx
 
 void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	uint8_t i;
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	bool can_apply_seamless_boot = false;
@@ -1677,7 +1677,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 		pipe_ctx->plane_res.hubp = hubp;
 		pipe_ctx->plane_res.dpp = dpp;
-		pipe_ctx->plane_res.mpcc_inst = dpp->inst;
+		pipe_ctx->plane_res.mpcc_inst = (uint8_t)dpp->inst;
 		hubp->mpcc_id = dpp->inst;
 		hubp->opp_id = OPP_ID_INVALID;
 		hubp->power_gated = false;
@@ -2258,7 +2258,7 @@ void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 		hw_locks.bits.lock_cursor = 1;
-		inst_flags.opp_inst = pipe->stream_res.opp->inst;
+		inst_flags.opp_inst = (uint8_t)pipe->stream_res.opp->inst;
 
 		dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
 					lock,
@@ -2383,7 +2383,7 @@ static uint8_t get_clock_divider(struct pipe_ctx *pipe,
 	}
 	clock_divider *= numpipes;
 
-	return clock_divider;
+	return (uint8_t)clock_divider;
 }
 
 static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
@@ -2458,7 +2458,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 				dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk(
 					dc->res_pool->dp_clock_source,
 					grouped_pipes[i]->stream_res.tg->inst,
-					phase[i], modulo[i]);
+					(unsigned int)phase[i], (unsigned int)modulo[i]);
 				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
 					dc->res_pool->dp_clock_source,
 					grouped_pipes[i]->stream_res.tg->inst, &pclk);
@@ -3516,7 +3516,7 @@ void dcn10_config_stereo_parameters(
 			}
 		}
 		flags->RIGHT_EYE_POLARITY =\
-				stream->timing.flags.RIGHT_EYE_3D_POLARITY;
+				(stream->timing.flags.RIGHT_EYE_3D_POLARITY != 0);
 		if (timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 			flags->FRAME_PACKED = 1;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 288e4edaa9a2..c2ea0106fdec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -235,7 +235,7 @@ void dcn20_setup_gsl_group_as_lock(
 
 		group_idx = find_free_gsl_group(dc);
 		ASSERT(group_idx != 0);
-		pipe_ctx->stream_res.gsl_group = group_idx;
+		pipe_ctx->stream_res.gsl_group = (uint8_t)group_idx;
 
 		/* set gsl group reg field and mark resource used */
 		switch (group_idx) {
@@ -826,7 +826,7 @@ enum dc_status dcn20_enable_stream_timing(
 	unsigned int event_triggers = 0;
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = {0};
-	bool interlace = stream->timing.flags.INTERLACE;
+	bool interlace = (stream->timing.flags.INTERLACE != 0);
 	int i;
 	struct mpc_dwb_flow_control flow_control;
 	struct mpc *mpc = dc->res_pool->mpc;
@@ -1452,7 +1452,7 @@ void dcn20_pipe_control_lock(
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 		hw_locks.bits.lock_pipe = 1;
-		inst_flags.otg_inst =  pipe->stream_res.tg->inst;
+		inst_flags.otg_inst = (uint8_t)pipe->stream_res.tg->inst;
 
 		if (pipe->plane_state != NULL)
 			hw_locks.bits.triple_buffer_lock = pipe->plane_state->triplebuffer_flips;
@@ -2733,7 +2733,8 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 	addr_patched = patch_address_for_sbs_tb_stereo(pipe_ctx, &addr);
 
 	// Call Helper to track VMID use
-	vm_helper_mark_vmid_used(dc->vm_helper, plane_state->address.vmid, pipe_ctx->plane_res.hubp->inst);
+	vm_helper_mark_vmid_used(dc->vm_helper, plane_state->address.vmid,
+			(uint8_t)pipe_ctx->plane_res.hubp->inst);
 
 	pipe_ctx->plane_res.hubp->funcs->hubp_program_surface_flip_and_addr(
 			pipe_ctx->plane_res.hubp,
@@ -3126,7 +3127,7 @@ void dcn20_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
 
 void dcn20_fpga_init_hw(struct dc *dc)
 {
-	int i, j;
+	uint8_t i, j;
 	struct dce_hwseq *hws = dc->hwseq;
 	struct resource_pool *res_pool = dc->res_pool;
 	struct dc_state  *context = dc->current_state;
@@ -3199,7 +3200,7 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 		pipe_ctx->plane_res.hubp = hubp;
 		pipe_ctx->plane_res.dpp = dpp;
-		pipe_ctx->plane_res.mpcc_inst = dpp->inst;
+		pipe_ctx->plane_res.mpcc_inst = (uint8_t)dpp->inst;
 		hubp->mpcc_id = dpp->inst;
 		hubp->opp_id = OPP_ID_INVALID;
 		hubp->power_gated = false;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 062745389d9a..0988369bd968 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -146,10 +146,10 @@ bool dcn21_dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
-	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = pwrseq_inst;
-	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
-	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = (uint8_t)otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.pwrseq_inst = (uint8_t)pwrseq_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = (uint8_t)option;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = (uint8_t)panel_inst;
 	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
 	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 2aa0f1de8103..2705c58a9150 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -978,7 +978,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 							cursor_cache_enable ? &cursor_attr : NULL)) {
 				unsigned int v_total = stream->adjust.v_total_max ?
 						stream->adjust.v_total_max : stream->timing.v_total;
-				unsigned int refresh_hz = div_u64((unsigned long long) stream->timing.pix_clk_100hz *
+				unsigned int refresh_hz = (unsigned int)div_u64((unsigned long long)stream->timing.pix_clk_100hz *
 						100LL, (v_total * stream->timing.h_total));
 
 				/*
@@ -1006,9 +1006,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				unsigned int denom = refresh_hz * 6528;
 				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
 
-				tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
+				tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
 						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-						denom) - 64LL;
+						denom) - 64LL);
 
 				/* In some cases the stutter period is really big (tiny modes) in these
 				 * cases MALL cant be enabled, So skip these cases to avoid a ASSERT()
@@ -1030,9 +1030,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					}
 
 					denom *= 2;
-					tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
+					tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
 							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-							denom) - 64LL;
+							denom) - 64LL);
 				}
 
 				/* Copy HW cursor */
@@ -1062,9 +1062,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					cmd.mall.cursor_copy_src.quad_part = cursor_attr.address.quad_part;
 					cmd.mall.cursor_copy_dst.quad_part =
 							(plane->address.grph.cursor_cache_addr.quad_part + 2047) & ~2047;
-					cmd.mall.cursor_width = cursor_attr.width;
-					cmd.mall.cursor_height = cursor_attr.height;
-					cmd.mall.cursor_pitch = cursor_attr.pitch;
+					cmd.mall.cursor_width = (uint16_t)cursor_attr.width;
+					cmd.mall.cursor_height = (uint16_t)cursor_attr.height;
+					cmd.mall.cursor_pitch = (uint16_t)cursor_attr.pitch;
 
 					dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 858a06b03b57..1e856ee508f1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -211,7 +211,7 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
 
-		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
+		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC != 0);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
@@ -419,7 +419,7 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 			if (dcn314_is_pipe_dig_fifo_on(pipe))
 				continue;
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
-			reset_sync_context_for_pipe(dc, context, i);
+			reset_sync_context_for_pipe(dc, context, (uint8_t)i);
 			otg_disabled[i] = true;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b45ceb570a5c..7dbaaf9403f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1175,7 +1175,7 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
 
-		dcn32_update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
+		dcn32_update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC != 0);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
@@ -1277,7 +1277,7 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 		if ((pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
 			&& dc_state_get_pipe_subvp_type(dc_state, pipe) != SUBVP_PHANTOM) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
-			reset_sync_context_for_pipe(dc, context, i);
+			reset_sync_context_for_pipe(dc, context, (uint8_t)i);
 			otg_disabled[i] = true;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f133b52ea958..894d48fcd7f8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -467,7 +467,7 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
 
-		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
+		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC != 0);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
 		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
@@ -621,7 +621,7 @@ void dcn35_z10_restore(const struct dc *dc)
 
 void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	uint8_t i;
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
@@ -725,7 +725,7 @@ void dcn35_init_pipes(struct dc *dc, struct dc_state *context)
 
 		pipe_ctx->plane_res.hubp = hubp;
 		pipe_ctx->plane_res.dpp = dpp;
-		pipe_ctx->plane_res.mpcc_inst = dpp->inst;
+		pipe_ctx->plane_res.mpcc_inst = (uint8_t)dpp->inst;
 		hubp->mpcc_id = dpp->inst;
 		hubp->opp_id = OPP_ID_INVALID;
 		hubp->power_gated = false;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 7e6bdefb5471..9c505a8a773c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1158,7 +1158,7 @@ static bool dcn401_check_no_memory_request_for_cab(struct dc *dc)
 static uint32_t dcn401_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
 	int i;
-	uint8_t num_ways = 0;
+	uint32_t num_ways = 0;
 	uint32_t mall_ss_size_bytes = 0;
 
 	mall_ss_size_bytes = ctx->bw_ctx.bw.dcn.mall_ss_size_bytes;
@@ -1189,7 +1189,8 @@ static uint32_t dcn401_calculate_cab_allocation(struct dc *dc, struct dc_state *
 bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	uint8_t ways, i;
+	uint32_t ways;
+	uint8_t i;
 	int j;
 	bool mall_ss_unsupported = false;
 	struct dc_plane_state *plane = NULL;
@@ -1242,7 +1243,7 @@ bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			}
 			if (ways <= dc->caps.cache_num_ways && !mall_ss_unsupported) {
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
-				cmd.cab.cab_alloc_ways = ways;
+				cmd.cab.cab_alloc_ways = (uint8_t)ways;
 				DC_LOG_MALL("cab allocation: %d ways. CAB action: DCN_SS_FIT_IN_CAB\n", ways);
 			} else {
 				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB;
@@ -1433,12 +1434,15 @@ void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params)
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable)
 {
 	bool fams2_info_required;
+	bool fams2_enabled;
+	bool fams2_legacy_no_fams2;
 
 	if (!dc->ctx || !dc->ctx->dmub_srv || !dc->debug.fams2_config.bits.enable)
 		return;
 
-	fams2_info_required = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
-	fams2_info_required |= context->bw_ctx.bw.dcn.fams2_global_config.features.bits.legacy_method_no_fams2;
+	fams2_enabled = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable != 0u;
+	fams2_legacy_no_fams2 = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.legacy_method_no_fams2 != 0u;
+	fams2_info_required = fams2_enabled || fams2_legacy_no_fams2;
 
 	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_info_required);
 }
@@ -1470,7 +1474,7 @@ static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
 
 	if (otg_master->stream_res.dsc)
 		dcn32_update_dsc_on_stream(otg_master,
-				otg_master->stream->timing.flags.DSC);
+				otg_master->stream->timing.flags.DSC != 0u);
 	if (old_otg_master && old_otg_master->stream_res.dsc) {
 		for (i = 0; i < old_opp_head_count; i++) {
 			old_pipe = old_opp_heads[i];
@@ -3297,7 +3301,7 @@ void dcn401_setup_gsl_group_as_lock_sequence(
 
 		group_idx = find_free_gsl_group(dc);
 		ASSERT(group_idx != 0);
-		pipe_ctx->stream_res.gsl_group = group_idx;
+		pipe_ctx->stream_res.gsl_group = (uint8_t)group_idx;
 
 		/* set gsl group reg field and mark resource used */
 		switch (group_idx) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
index d1656c9d50df..d567d4bd585d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
@@ -79,7 +79,7 @@ static inline struct bw_fixed bw_int_to_fixed(int64_t value)
 
 static inline int32_t bw_fixed_to_int(struct bw_fixed value)
 {
-	return BW_FIXED_GET_INTEGER_PART(value.value);
+	return (int32_t)BW_FIXED_GET_INTEGER_PART(value.value);
 }
 
 struct bw_fixed bw_frc_to_fixed(int64_t num, int64_t denum);
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 060460abc377..ae6ed3a52d53 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -199,7 +199,6 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
 	unsigned int channel_count;
 	unsigned int channel = 0;
 	unsigned int modes = 0;
-	unsigned int sampling_rate_in_hz = 0;
 
 	// get audio test mode and test pattern parameters
 	core_link_read_dpcd(
@@ -232,38 +231,10 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
 		}
 	}
 
-	// translate sampling rate
-	switch (dpcd_test_mode.bits.sampling_rate) {
-	case AUDIO_SAMPLING_RATE_32KHZ:
-		sampling_rate_in_hz = 32000;
-		break;
-	case AUDIO_SAMPLING_RATE_44_1KHZ:
-		sampling_rate_in_hz = 44100;
-		break;
-	case AUDIO_SAMPLING_RATE_48KHZ:
-		sampling_rate_in_hz = 48000;
-		break;
-	case AUDIO_SAMPLING_RATE_88_2KHZ:
-		sampling_rate_in_hz = 88200;
-		break;
-	case AUDIO_SAMPLING_RATE_96KHZ:
-		sampling_rate_in_hz = 96000;
-		break;
-	case AUDIO_SAMPLING_RATE_176_4KHZ:
-		sampling_rate_in_hz = 176400;
-		break;
-	case AUDIO_SAMPLING_RATE_192KHZ:
-		sampling_rate_in_hz = 192000;
-		break;
-	default:
-		sampling_rate_in_hz = 0;
-		break;
-	}
-
 	link->audio_test_data.flags.test_requested = 1;
 	link->audio_test_data.flags.disable_video = disable_video;
-	link->audio_test_data.sampling_rate = sampling_rate_in_hz;
-	link->audio_test_data.channel_count = channel_count;
+	link->audio_test_data.sampling_rate = (uint8_t)dpcd_test_mode.bits.sampling_rate;
+	link->audio_test_data.channel_count = (uint8_t)channel_count;
 	link->audio_test_data.pattern_type = test_pattern;
 
 	if (test_pattern == DP_TEST_PATTERN_AUDIO_SAWTOOTH) {
@@ -885,7 +856,7 @@ bool dp_set_test_pattern(
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 				hw_locks.bits.lock_dig = 1;
-				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
+				inst_flags.dig_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 
 				dmub_hw_lock_mgr_cmd(link->ctx->dmub_srv,
 							true,
@@ -933,7 +904,7 @@ bool dp_set_test_pattern(
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 				hw_locks.bits.lock_dig = 1;
-				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
+				inst_flags.dig_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 
 				dmub_hw_lock_mgr_cmd(link->ctx->dmub_srv,
 							false,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index dbbedeeed298..04df75114dd5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -63,7 +63,7 @@ void set_hpo_dp_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
 		time_slot_in_ms = dc_fixpt_from_fraction(32 * 4, link_bw_in_kbps);
 		mtp_cnt_per_h_blank = dc_fixpt_div(h_blank_in_ms,
 				dc_fixpt_mul_int(time_slot_in_ms, 64));
-		hblank_min_symbol_width = dc_fixpt_floor(
+		hblank_min_symbol_width = (uint16_t)dc_fixpt_floor(
 				dc_fixpt_mul(mtp_cnt_per_h_blank, throttled_vcp_size));
 	}
 
@@ -98,7 +98,7 @@ void setup_hpo_dp_stream_attribute(struct pipe_ctx *pipe_ctx)
 			&stream->timing,
 			stream->output_color_space,
 			stream->use_vsc_sdp_for_colorimetry,
-			stream->timing.flags.DSC,
+			(stream->timing.flags.DSC != 0),
 			false);
 	link->dc->link_srv->dp_trace_source_sequence(link,
 			DPCD_SOURCE_SEQ_AFTER_DP_STREAM_ATTR);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 794dd6a95918..7924fe4ab3a5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -290,12 +290,12 @@ static bool i2c_read(
 	struct i2c_payload payloads[2] = {
 		{
 		.write = true,
-		.address = address,
+		.address = (uint8_t)address,
 		.length = 1,
 		.data = &offs_data },
 		{
 		.write = false,
-		.address = address,
+		.address = (uint8_t)address,
 		.length = len,
 		.data = buffer } };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e12c25896364..f7cc419cfbff 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -557,7 +557,7 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	/* link encoder index */
 	config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 	if (dp_is_128b_132b_signal(pipe_ctx))
-		config.link_enc_idx = pipe_ctx->link_res.hpo_dp_link_enc->inst;
+		config.link_enc_idx = (uint8_t)pipe_ctx->link_res.hpo_dp_link_enc->inst;
 
 	/* dio output index is dpia index for DPIA endpoint & dcio index by default */
 	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
@@ -1411,7 +1411,7 @@ static bool write_128b_132b_sst_payload_allocation_table(
 
 	if (allocate)	{
 		avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(stream, link);
-		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
+		req_slot_count = (uint8_t)dc_fixpt_ceil(avg_time_slots_per_mtp);
 		/// Validation should filter out modes that exceed link BW
 		ASSERT(req_slot_count <= MAX_MTP_SLOT_COUNT);
 		if (req_slot_count > MAX_MTP_SLOT_COUNT)
@@ -1811,7 +1811,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 		write_scdc_data(
 			stream->link->ddc,
 			stream->phy_pix_clk,
-			stream->timing.flags.LTE_340MCSC_SCRAMBLE);
+			(stream->timing.flags.LTE_340MCSC_SCRAMBLE != 0));
 
 	memset(&stream->link->cur_link_settings, 0,
 			sizeof(struct dc_link_settings));
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 9912615d742f..765b731a12a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -516,7 +516,7 @@ static bool construct_phy(struct dc_link *link,
 	       sizeof(struct dc_link_settings));
 
 	link->link_id =
-		bios->funcs->get_connector_id(bios, init_params->connector_index);
+		bios->funcs->get_connector_id(bios, (uint8_t)init_params->connector_index);
 
 	link->ep_type = DISPLAY_ENDPOINT_PHY;
 
@@ -544,7 +544,7 @@ static bool construct_phy(struct dc_link *link,
 
 	if (bios->funcs->get_disp_connector_caps_info) {
 		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
-		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
+		link->is_internal_display = (disp_connect_caps_info.INTERNAL_DISPLAY != 0);
 		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
 	}
 
@@ -895,7 +895,7 @@ static bool construct_dpia(struct dc_link *link,
 	}
 
 	/* Set dpia port index : 0 to number of dpia ports */
-	link->ddc_hw_inst = init_params->connector_index;
+	link->ddc_hw_inst = (uint8_t)init_params->connector_index;
 
 	// Assign Dpia preferred eng_id
 	if (link->dc->res_pool->funcs->get_preferred_eng_id_dpia)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 5d2bcce2f669..ef9306686b14 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -96,7 +96,7 @@ static void i2c_payloads_add(
 	for (pos = 0; pos < len; pos += payload_size) {
 		struct i2c_payload payload = {
 			.write = write,
-			.address = address,
+			.address = (uint8_t)address,
 			.length = DDC_MIN(payload_size, len - pos),
 			.data = data + pos };
 		dal_vector_append(&payloads->payloads, &payload);
@@ -384,8 +384,7 @@ bool link_query_ddc_data(
 		i2c_payloads_add(
 			&payloads, address, read_size, read_buf, false);
 
-		command.number_of_payloads =
-			i2c_payloads_get_count(&payloads);
+		command.number_of_payloads = (uint8_t)i2c_payloads_get_count(&payloads);
 
 		success = dm_helpers_submit_i2c(
 				ddc->ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 782a45caa13d..01b3d56cdc89 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1713,7 +1713,7 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
 		// Identify closest LTTPR to determine if workarounds required for known embedded LTTPR
-		closest_lttpr_offset = dp_get_closest_lttpr_offset(lttpr_count);
+		closest_lttpr_offset = dp_get_closest_lttpr_offset((uint8_t)lttpr_count);
 
 		core_link_read_dpcd(link, (DP_LTTPR_IEEE_OUI + closest_lttpr_offset),
 				link->dpcd_caps.lttpr_caps.lttpr_ieee_oui, sizeof(link->dpcd_caps.lttpr_caps.lttpr_ieee_oui));
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index c958d3f600c8..6406fe890850 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -112,7 +112,7 @@ static int get_estimated_bw(struct dc_link *link)
 	return bw_estimated_bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 }
 
-static int get_non_reduced_max_link_rate(struct dc_link *link)
+static uint8_t get_non_reduced_max_link_rate(struct dc_link *link)
 {
 	uint8_t nrd_max_link_rate = 0;
 
@@ -125,7 +125,7 @@ static int get_non_reduced_max_link_rate(struct dc_link *link)
 	return nrd_max_link_rate;
 }
 
-static int get_non_reduced_max_lane_count(struct dc_link *link)
+static uint8_t get_non_reduced_max_lane_count(struct dc_link *link)
 {
 	uint8_t nrd_max_lane_count = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 96afce4ffbfa..e1991776c59d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -60,11 +60,10 @@ static void dp_pr_set_static_screen_param(struct dc_link *link)
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
 			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link) {
 			struct dc_stream_state *stream = dc->current_state->res_ctx.pipe_ctx[i].stream;
-			unsigned int vsync_rate_hz = div64_u64(div64_u64(
-											(stream->timing.pix_clk_100hz * (u64)100),
-											stream->timing.v_total),
-											stream->timing.h_total);
-
+			unsigned int vsync_rate_hz = (unsigned int)div64_u64(div64_u64(
+														(stream->timing.pix_clk_100hz * (u64)100),
+														stream->timing.v_total),
+														stream->timing.h_total);
 			params.triggers.cursor_update = true;
 			params.triggers.overlay_update = true;
 			params.triggers.surface_update = true;
@@ -264,7 +263,7 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 	cmd.pr_enable.header.type = DMUB_CMD__PR;
 	cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
 	cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
-	cmd.pr_enable.data.panel_inst = panel_inst;
+	cmd.pr_enable.data.panel_inst = (uint8_t)panel_inst;
 	cmd.pr_enable.data.enable = enable ? 1 : 0;
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
@@ -301,17 +300,17 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 	cmd.pr_copy_settings.header.type = DMUB_CMD__PR;
 	cmd.pr_copy_settings.header.sub_type = DMUB_CMD__PR_COPY_SETTINGS;
 	cmd.pr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_pr_copy_settings_data);
-	cmd.pr_copy_settings.data.panel_inst = panel_inst;
+	cmd.pr_copy_settings.data.panel_inst = (uint8_t)panel_inst;
 	// HW inst
 	cmd.pr_copy_settings.data.aux_inst = replay_context->aux_inst;
 	cmd.pr_copy_settings.data.digbe_inst = replay_context->digbe_inst;
 	cmd.pr_copy_settings.data.digfe_inst = replay_context->digfe_inst;
 	if (pipe_ctx->plane_res.dpp)
-		cmd.pr_copy_settings.data.dpp_inst = pipe_ctx->plane_res.dpp->inst;
+		cmd.pr_copy_settings.data.dpp_inst = (uint8_t)pipe_ctx->plane_res.dpp->inst;
 	else
 		cmd.pr_copy_settings.data.dpp_inst = 0;
 	if (pipe_ctx->stream_res.tg)
-		cmd.pr_copy_settings.data.otg_inst = pipe_ctx->stream_res.tg->inst;
+		cmd.pr_copy_settings.data.otg_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
 	else
 		cmd.pr_copy_settings.data.otg_inst = 0;
 
@@ -358,7 +357,7 @@ bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_da
 	cmd.pr_update_state.header.type = DMUB_CMD__PR;
 	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
 	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
-	cmd.pr_update_state.data.panel_inst = panel_inst;
+	cmd.pr_update_state.data.panel_inst = (uint8_t)panel_inst;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
@@ -379,7 +378,7 @@ bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_
 	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
 	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
 	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
-	cmd.pr_general_cmd.data.panel_inst = panel_inst;
+	cmd.pr_general_cmd.data.panel_inst = (uint8_t)panel_inst;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
@@ -397,7 +396,7 @@ bool dp_pr_get_state(const struct dc_link *link, uint64_t *state)
 
 	do {
 		// Send gpint command and wait for ack
-		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
+		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, (uint16_t)panel_inst,
 					       &replay_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
 			// Return invalid state when GPINT times out
 			replay_state = PR_STATE_INVALID;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 66d0fb1b9b9d..4331e032416f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -132,7 +132,7 @@ void decide_8b_10b_training_settings(
 	 */
 	lt_settings->link_settings.link_spread = link->dp_ss_off ?
 			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
-	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
+	lt_settings->eq_pattern_time = (uint16_t)get_eq_training_aux_rd_interval(link, link_setting);
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_res, link_setting);
 	lt_settings->enhanced_framing = 1;
@@ -140,7 +140,7 @@ void decide_8b_10b_training_settings(
 	lt_settings->disallow_per_lane_settings = true;
 	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
 	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
-	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
+	lt_settings->cr_pattern_time = (uint16_t)get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 	/* Some embedded LTTPRs rely on receiving TPS2 before LT to interop reliably with sensitive VGA dongles
@@ -195,7 +195,7 @@ static void set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(str
 	* 6. Begin link training as usual
 	* */
 
-	uint32_t closest_lttpr_address_offset = dp_get_closest_lttpr_offset(lttpr_count);
+	uint32_t closest_lttpr_address_offset = dp_get_closest_lttpr_offset((uint8_t)lttpr_count);
 
 	union dpcd_training_pattern dpcd_pattern = {0};
 
@@ -379,7 +379,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 			dpcd_set_lane_settings(link, lt_settings, offset);
 
 		/* 3. wait for receiver to lock-on*/
-		wait_time_microsec = dp_get_eq_aux_rd_interval(link, lt_settings, offset, retries_ch_eq);
+		wait_time_microsec = dp_get_eq_aux_rd_interval(link, lt_settings, offset, (uint8_t)retries_ch_eq);
 
 		dp_wait_for_training_aux_rd_interval(
 				link,
@@ -408,7 +408,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
 				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-				dp_check_interlane_aligned(dpcd_lane_status_updated, link, retries_ch_eq))
+				dp_check_interlane_aligned(dpcd_lane_status_updated, link, (uint8_t)retries_ch_eq))
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 4ae739dd9c7e..6aa65815af22 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -601,12 +601,12 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 		link->psr_settings.psr_power_opt = *power_opts;
 
 		if (psr != NULL && link->psr_settings.psr_feature_enabled && psr->funcs->psr_set_power_opt)
-			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt, panel_inst);
+			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt, (uint8_t)panel_inst);
 	}
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled &&
 			force_static && psr->funcs->psr_force_static)
-		psr->funcs->psr_force_static(psr, panel_inst);
+		psr->funcs->psr_force_static(psr, (uint8_t)panel_inst);
 
 	/* Enable or Disable PSR */
 	if (allow_active && link->psr_settings.psr_allow_active != *allow_active) {
@@ -615,9 +615,9 @@ bool edp_set_psr_allow_active(struct dc_link *link, const bool *allow_active,
 		if (!link->psr_settings.psr_allow_active)
 			dc_z10_restore(dc);
 
-		if (psr != NULL && link->psr_settings.psr_feature_enabled) {
-			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, panel_inst);
-		} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) &&
+		if (psr != NULL && link->psr_settings.psr_feature_enabled)
+			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, (uint8_t)panel_inst);
+		else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) &&
 			link->psr_settings.psr_feature_enabled)
 			dmcu->funcs->set_psr_enable(dmcu, link->psr_settings.psr_allow_active, wait);
 		else
@@ -637,7 +637,7 @@ bool edp_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 		return false;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_state(psr, state, panel_inst);
+		psr->funcs->psr_get_state(psr, state, (uint8_t)panel_inst);
 	else if (dmcu != NULL && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, state);
 
@@ -811,7 +811,7 @@ bool edp_setup_psr(struct dc_link *link,
 	psr_context->smuPhyId = transmitter_to_phy_id(link);
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
-	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
+	psr_context->vsync_rate_hz = (unsigned int)div64_u64(div64_u64((stream->
 					timing.pix_clk_100hz * (u64)100),
 					stream->timing.v_total),
 					stream->timing.h_total);
@@ -885,7 +885,7 @@ bool edp_setup_psr(struct dc_link *link,
 
 	if (psr) {
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
-			link, psr_context, panel_inst);
+			link, psr_context, (uint8_t)panel_inst);
 		link->psr_settings.psr_power_opt = 0;
 		link->psr_settings.psr_allow_active = 0;
 	} else {
@@ -913,7 +913,7 @@ void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency, enum
 
 	// PSR residency measurements only supported on DMCUB
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_residency(psr, residency, panel_inst, mode);
+		psr->funcs->psr_get_residency(psr, residency, (uint8_t)panel_inst, mode);
 	else
 		*residency = 0;
 }
@@ -947,7 +947,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
 		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
 			replay->funcs->replay_set_power_opt) {
-			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
+			replay->funcs->replay_set_power_opt(replay, *power_opts, (uint8_t)panel_inst);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 		}
 	}
@@ -957,7 +957,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 		// TODO: Handle mux change case if force_static is set
 		// If force_static is set, just change the replay_allow_active state directly
 		if (replay != NULL && link->replay_settings.replay_feature_enabled)
-			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst);
+			replay->funcs->replay_enable(replay, *allow_active, wait, (uint8_t)panel_inst);
 		link->replay_settings.replay_allow_active = *allow_active;
 	}
 
@@ -975,7 +975,7 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 		return false;
 
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
-		replay->funcs->replay_get_state(replay, &pr_state, panel_inst);
+		replay->funcs->replay_get_state(replay, &pr_state, (uint8_t)panel_inst);
 	*state = pr_state;
 
 	return true;
@@ -1046,7 +1046,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	replay_context.os_request_force_ffu = link->replay_settings.config.os_request_force_ffu;
 
 	link->replay_settings.replay_feature_enabled =
-			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
+			replay->funcs->replay_copy_settings(replay, link, &replay_context, (uint8_t)panel_inst);
 	if (link->replay_settings.replay_feature_enabled) {
 
 		replay_config.bits.FREESYNC_PANEL_REPLAY_MODE = 1;
@@ -1095,7 +1095,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 		return false;
 
 	if (dp_pr_get_panel_inst(dc, link, &panel_inst))
-		cmd_data->panel_inst = panel_inst;
+		cmd_data->panel_inst = (uint8_t)panel_inst;
 	else {
 		DC_LOG_DC("%s(): get edp panel inst fail ", __func__);
 		return false;
@@ -1120,7 +1120,7 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uin
 
 	if (coasting_vtotal && (link->replay_settings.coasting_vtotal != coasting_vtotal ||
 		link->replay_settings.frame_skip_number != frame_skip_number)) {
-		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, panel_inst, frame_skip_number);
+		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, (uint8_t)panel_inst, frame_skip_number);
 		link->replay_settings.coasting_vtotal = coasting_vtotal;
 		link->replay_settings.frame_skip_number = frame_skip_number;
 	}
@@ -1142,7 +1142,7 @@ bool edp_replay_residency(const struct dc_link *link,
 		return false;
 
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
-		replay->funcs->replay_residency(replay, panel_inst, residency, is_start, mode);
+		replay->funcs->replay_residency(replay, (uint8_t)panel_inst, residency, is_start, mode);
 	else
 		*residency = 0;
 
@@ -1167,7 +1167,7 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 		if (link->replay_settings.replay_feature_enabled &&
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal) {
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal(replay,
-				*power_opts, panel_inst, coasting_vtotal, frame_skip_number);
+				*power_opts, (uint8_t)panel_inst, coasting_vtotal, frame_skip_number);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 			link->replay_settings.coasting_vtotal = coasting_vtotal;
 			link->replay_settings.frame_skip_number = frame_skip_number;
@@ -1251,10 +1251,10 @@ static void edp_set_assr_enable(const struct dc *pDC, struct dc_link *link,
 
 	memset(&cmd, 0, sizeof(cmd));
 
-	link_enc_index = link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+	link_enc_index = (uint8_t)(link->link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 
 	if (link_res->hpo_dp_link_enc) {
-		link_enc_index = link_res->hpo_dp_link_enc->inst;
+		link_enc_index = (uint8_t)link_res->hpo_dp_link_enc->inst;
 		use_hpo_dp_link_enc = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
index 2a422e223bf2..2e0f07ec04e4 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
@@ -40,8 +40,8 @@
 #define FN(reg_name, field_name) \
 	mcif_wb20->mcif_wb_shift->field_name, mcif_wb20->mcif_wb_mask->field_name
 
-#define MCIF_ADDR(addr) (((unsigned long long)addr & 0xffffffffff) + 0xFE) >> 8
-#define MCIF_ADDR_HIGH(addr) (unsigned long long)addr >> 40
+#define MCIF_ADDR(addr) ((uint32_t)((((unsigned long long)(addr) & 0xffffffffffULL) + 0xFEULL) >> 8))
+#define MCIF_ADDR_HIGH(addr) ((uint32_t)(((unsigned long long)(addr)) >> 40))
 
 /* wbif programming guide:
  * 1. set up wbif parameter:
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
index c3b089ba511a..6b6f80a3bfd5 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
@@ -40,8 +40,8 @@
 #define FN(reg_name, field_name) \
 	mcif_wb30->mcif_wb_shift->field_name, mcif_wb30->mcif_wb_mask->field_name
 
-#define MCIF_ADDR(addr) (((unsigned long long)addr & 0xffffffffff) + 0xFE) >> 8
-#define MCIF_ADDR_HIGH(addr) (unsigned long long)addr >> 40
+#define MCIF_ADDR(addr) ((uint32_t)((((unsigned long long)(addr) & 0xffffffffffULL) + 0xFEULL) >> 8))
+#define MCIF_ADDR_HIGH(addr) ((uint32_t)(((unsigned long long)(addr)) >> 40))
 
 /* wbif programming guide:
  * 1. set up wbif parameter:
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 39ce4d4a61a1..c558b1d633f3 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -305,8 +305,8 @@ static void optc2_align_vblanks(
 	L = div_u64(L, master_h_total);
 	L = div_u64(L, slave_pixel_clock_100Hz);
 	XY = div_u64(L, p);
-	Y = master_v_active - XY - 1;
-	X = div_u64(((XY + 1) * p - L) * master_h_total, p * master_clock_divider);
+	Y = (uint32_t)(master_v_active - XY - 1);
+	X = (uint32_t)div_u64(((XY + 1) * p - L) * master_h_total, p * master_clock_divider);
 
 	/*
 	 * set master OTG to unlock when V/H
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index ee2877cf27c5..0138868e198b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -1151,7 +1151,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 	/*pipe_ctx->plane_res.ipp = res_ctx->pool->ipps[underlay_idx];*/
 	pipe_ctx->plane_res.xfm = pool->transforms[underlay_idx];
 	pipe_ctx->stream_res.opp = pool->opps[underlay_idx];
-	pipe_ctx->pipe_idx = underlay_idx;
+	pipe_ctx->pipe_idx = (uint8_t)underlay_idx;
 
 	pipe_ctx->stream = stream;
 
@@ -1161,7 +1161,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 
 		hws->funcs.enable_display_power_gating(
 				dc,
-				pipe_ctx->stream_res.tg->inst,
+				(uint8_t)pipe_ctx->stream_res.tg->inst,
 				dcb, PIPE_GATING_CONTROL_DISABLE);
 
 		/*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 8fc8d441a592..b7bd7344065b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1141,7 +1141,7 @@ static struct pipe_ctx *dcn10_acquire_free_pipe_for_layer(
 	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
 	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
 	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
+	idle_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[idle_pipe->pipe_idx]->inst;
 
 	return idle_pipe;
 }
@@ -1737,7 +1737,7 @@ struct resource_pool *dcn10_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn10_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn10_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	kfree(pool);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index cb155a0f1c30..038798808e52 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1523,13 +1523,13 @@ bool dcn20_split_stream_for_odm(
 
 	*next_odm_pipe = *prev_odm_pipe;
 
-	next_odm_pipe->pipe_idx = pipe_idx;
+	next_odm_pipe->pipe_idx = (uint8_t)pipe_idx;
 	next_odm_pipe->plane_res.mi = pool->mis[next_odm_pipe->pipe_idx];
 	next_odm_pipe->plane_res.hubp = pool->hubps[next_odm_pipe->pipe_idx];
 	next_odm_pipe->plane_res.ipp = pool->ipps[next_odm_pipe->pipe_idx];
 	next_odm_pipe->plane_res.xfm = pool->transforms[next_odm_pipe->pipe_idx];
 	next_odm_pipe->plane_res.dpp = pool->dpps[next_odm_pipe->pipe_idx];
-	next_odm_pipe->plane_res.mpcc_inst = pool->dpps[next_odm_pipe->pipe_idx]->inst;
+	next_odm_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[next_odm_pipe->pipe_idx]->inst;
 	next_odm_pipe->stream_res.dsc = NULL;
 	if (prev_odm_pipe->next_odm_pipe && prev_odm_pipe->next_odm_pipe != next_odm_pipe) {
 		next_odm_pipe->next_odm_pipe = prev_odm_pipe->next_odm_pipe;
@@ -1580,13 +1580,13 @@ void dcn20_split_stream_for_mpc(
 	*secondary_pipe = *primary_pipe;
 	secondary_pipe->bottom_pipe = sec_bot_pipe;
 
-	secondary_pipe->pipe_idx = pipe_idx;
+	secondary_pipe->pipe_idx = (uint8_t)pipe_idx;
 	secondary_pipe->plane_res.mi = pool->mis[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.hubp = pool->hubps[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.ipp = pool->ipps[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.xfm = pool->transforms[secondary_pipe->pipe_idx];
 	secondary_pipe->plane_res.dpp = pool->dpps[secondary_pipe->pipe_idx];
-	secondary_pipe->plane_res.mpcc_inst = pool->dpps[secondary_pipe->pipe_idx]->inst;
+	secondary_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[secondary_pipe->pipe_idx]->inst;
 	secondary_pipe->stream_res.dsc = NULL;
 	if (primary_pipe->bottom_pipe && primary_pipe->bottom_pipe != secondary_pipe) {
 		ASSERT(!secondary_pipe->bottom_pipe);
@@ -1736,7 +1736,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 			preferred_pipe_idx = dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].next_odm_pipe->pipe_idx;
 			if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 				secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-				secondary_pipe->pipe_idx = preferred_pipe_idx;
+				secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 			}
 		}
 		if (secondary_pipe == NULL &&
@@ -1744,7 +1744,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 			preferred_pipe_idx = dc->current_state->res_ctx.pipe_ctx[primary_pipe->pipe_idx].bottom_pipe->pipe_idx;
 			if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 				secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-				secondary_pipe->pipe_idx = preferred_pipe_idx;
+				secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 			}
 		}
 
@@ -1762,7 +1762,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 
 					if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 						secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-						secondary_pipe->pipe_idx = preferred_pipe_idx;
+						secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 						break;
 					}
 				}
@@ -1783,7 +1783,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 
 				if (res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) {
 					secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-					secondary_pipe->pipe_idx = preferred_pipe_idx;
+					secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 					break;
 				}
 			}
@@ -2215,7 +2215,7 @@ struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 	sec_dpp_pipe->plane_res.hubp = pool->hubps[sec_dpp_pipe->pipe_idx];
 	sec_dpp_pipe->plane_res.ipp = pool->ipps[sec_dpp_pipe->pipe_idx];
 	sec_dpp_pipe->plane_res.dpp = pool->dpps[sec_dpp_pipe->pipe_idx];
-	sec_dpp_pipe->plane_res.mpcc_inst = pool->dpps[sec_dpp_pipe->pipe_idx]->inst;
+	sec_dpp_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[sec_dpp_pipe->pipe_idx]->inst;
 
 	return sec_dpp_pipe;
 }
@@ -2623,7 +2623,7 @@ static bool dcn20_resource_construct(
 		ranges.num_reader_wm_sets = 0;
 
 		if (loaded_bb->num_states == 1) {
-			ranges.reader_wm_sets[0].wm_inst = i;
+			ranges.reader_wm_sets[0].wm_inst = (uint8_t)i;
 			ranges.reader_wm_sets[0].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 			ranges.reader_wm_sets[0].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 			ranges.reader_wm_sets[0].min_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
@@ -2632,7 +2632,7 @@ static bool dcn20_resource_construct(
 			ranges.num_reader_wm_sets = 1;
 		} else if (loaded_bb->num_states > 1) {
 			for (i = 0; i < 4 && i < loaded_bb->num_states; i++) {
-				ranges.reader_wm_sets[i].wm_inst = i;
+				ranges.reader_wm_sets[i].wm_inst = (uint8_t)i;
 				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 				DC_FP_START();
@@ -2830,7 +2830,7 @@ struct resource_pool *dcn20_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn20_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn20_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 7066db2ae8fa..89a1931b8d23 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1751,7 +1751,7 @@ struct resource_pool *dcn21_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn21_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn21_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 7de5a2ccf722..baefddd03438 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1567,13 +1567,13 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 
 	*sec_pipe = *pri_pipe;
 
-	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->pipe_idx = (uint8_t)pipe_idx;
 	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
 	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
 	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
 	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
 	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
-	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 	sec_pipe->stream_res.dsc = NULL;
 	if (odm) {
 		if (pri_pipe->next_odm_pipe) {
@@ -1627,7 +1627,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
 
 	if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
 		pipe = &context->res_ctx.pipe_ctx[old_index];
-		pipe->pipe_idx = old_index;
+		pipe->pipe_idx = (uint8_t)old_index;
 	}
 
 	if (!pipe)
@@ -1636,7 +1636,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
 					&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
 				if (context->res_ctx.pipe_ctx[i].stream == NULL) {
 					pipe = &context->res_ctx.pipe_ctx[i];
-					pipe->pipe_idx = i;
+					pipe->pipe_idx = (uint8_t)i;
 					break;
 				}
 			}
@@ -1651,7 +1651,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
 		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
 			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
 				pipe = &context->res_ctx.pipe_ctx[i];
-				pipe->pipe_idx = i;
+				pipe->pipe_idx = (uint8_t)i;
 				break;
 			}
 		}
@@ -2383,7 +2383,7 @@ static bool dcn30_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //3
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2673,7 +2673,7 @@ struct resource_pool *dcn30_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn30_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn30_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index e8e1ebe33a24..625d9ec713a9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1362,7 +1362,7 @@ static void set_wm_ranges(
 		struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
 {
 	struct pp_smu_wm_range_sets ranges = {0};
-	int i;
+	unsigned int i;
 
 	ranges.num_reader_wm_sets = 0;
 
@@ -1376,7 +1376,7 @@ static void set_wm_ranges(
 		ranges.num_reader_wm_sets = 1;
 	} else if (loaded_bb->num_states > 1) {
 		for (i = 0; i < 4 && i < loaded_bb->num_states; i++) {
-			ranges.reader_wm_sets[i].wm_inst = i;
+			ranges.reader_wm_sets[i].wm_inst = (uint8_t)i;
 			ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 			ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 			DC_FP_START();
@@ -1510,7 +1510,7 @@ static bool dcn301_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -1777,7 +1777,7 @@ struct resource_pool *dcn301_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn301_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn301_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 16220b5ed885..6f380363033a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1300,7 +1300,7 @@ static bool dcn302_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->res_cap->num_mpc_3dlut; //3
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -1560,7 +1560,7 @@ struct resource_pool *dcn302_create_resource_pool(const struct dc_init_data *ini
 	if (!pool)
 		return NULL;
 
-	if (dcn302_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn302_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return pool;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 5203f659944d..8a7f62ab98b5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1244,7 +1244,7 @@ static bool dcn303_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->res_cap->num_mpc_3dlut; //3
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -1492,7 +1492,7 @@ struct resource_pool *dcn303_create_resource_pool(const struct dc_init_data *ini
 	if (!pool)
 		return NULL;
 
-	if (dcn303_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn303_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return pool;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index fa4df727f123..649b5e7c0373 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1984,7 +1984,7 @@ static bool dcn31_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2276,7 +2276,7 @@ struct resource_pool *dcn31_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn31_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn31_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 6de67cd1c81b..6a4094663050 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1918,7 +1918,7 @@ static bool dcn314_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2195,7 +2195,7 @@ struct resource_pool *dcn314_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn314_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn314_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 3db969852c5d..1e86a5e4d113 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1954,7 +1954,7 @@ static bool dcn315_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2217,7 +2217,7 @@ struct resource_pool *dcn315_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn315_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn315_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 41569821e3ab..6369fc90f84b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1830,7 +1830,7 @@ static bool dcn316_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2083,7 +2083,7 @@ struct resource_pool *dcn316_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn316_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn316_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c2059960a6d9..6f0a3b0ff2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2306,7 +2306,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2623,7 +2623,7 @@ struct resource_pool *dcn32_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn32_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn32_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
@@ -2751,7 +2751,7 @@ static struct pipe_ctx *find_idle_secondary_pipe_check_mpo(
 		if ((res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) &&
 			!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == preferred_pipe_idx)) {
 			secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-			secondary_pipe->pipe_idx = preferred_pipe_idx;
+			secondary_pipe->pipe_idx = (uint8_t)preferred_pipe_idx;
 		}
 	}
 
@@ -2764,7 +2764,7 @@ static struct pipe_ctx *find_idle_secondary_pipe_check_mpo(
 			if ((res_ctx->pipe_ctx[i].stream == NULL) &&
 				!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == i)) {
 				secondary_pipe = &res_ctx->pipe_ctx[i];
-				secondary_pipe->pipe_idx = i;
+				secondary_pipe->pipe_idx = (uint8_t)i;
 				break;
 			}
 		}
@@ -2798,7 +2798,7 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	pipe = &old_ctx->pipe_ctx[head_index];
 	if (pipe->bottom_pipe && res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx].stream == NULL) {
 		idle_pipe = &res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx];
-		idle_pipe->pipe_idx = pipe->bottom_pipe->pipe_idx;
+		idle_pipe->pipe_idx = (uint8_t)pipe->bottom_pipe->pipe_idx;
 	} else {
 		idle_pipe = find_idle_secondary_pipe_check_mpo(res_ctx, pool, head_pipe);
 		if (!idle_pipe)
@@ -2812,7 +2812,7 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
 	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
 	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
+	idle_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[idle_pipe->pipe_idx]->inst;
 
 	return idle_pipe;
 }
@@ -2863,7 +2863,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 					pool, opp_head_pipe);
 	if (free_pipe_idx >= 0) {
 		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
-		free_pipe->pipe_idx = free_pipe_idx;
+		free_pipe->pipe_idx = (uint8_t)free_pipe_idx;
 		free_pipe->stream = opp_head_pipe->stream;
 		free_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
 		free_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
@@ -2872,7 +2872,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		free_pipe->plane_res.ipp = pool->ipps[free_pipe->pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe->pipe_idx];
 		free_pipe->plane_res.mpcc_inst =
-				pool->dpps[free_pipe->pipe_idx]->inst;
+				(uint8_t)pool->dpps[free_pipe->pipe_idx]->inst;
 	} else {
 		ASSERT(opp_head_pipe);
 		free_pipe = NULL;
@@ -2894,7 +2894,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 
 	if (free_pipe_idx >= 0) {
 		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
-		free_pipe->pipe_idx = free_pipe_idx;
+		free_pipe->pipe_idx = (uint8_t)free_pipe_idx;
 		free_pipe->stream = otg_master->stream;
 		free_pipe->stream_res.tg = otg_master->stream_res.tg;
 		free_pipe->stream_res.dsc = NULL;
@@ -2904,7 +2904,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 		free_pipe->plane_res.ipp = pool->ipps[free_pipe_idx];
 		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
-		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
+		free_pipe->plane_res.mpcc_inst = (uint8_t)pool->dpps[free_pipe_idx]->inst;
 		free_pipe->dsc_padding_params = otg_master->dsc_padding_params;
 		if (free_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index b7bed427bfc7..663e9335fdec 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1805,7 +1805,7 @@ static bool dcn321_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2113,7 +2113,7 @@ struct resource_pool *dcn321_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn321_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn321_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1315ae4adcd9..27f8f13912b3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1951,7 +1951,7 @@ static bool dcn35_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2269,7 +2269,7 @@ struct resource_pool *dcn35_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn35_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn35_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e9c0c0c166bb..d032db65108b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1924,7 +1924,7 @@ static bool dcn351_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2242,7 +2242,7 @@ struct resource_pool *dcn351_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn351_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn351_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index ae59949c58ba..42fa8883d1b7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1921,7 +1921,7 @@ static bool dcn36_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //2
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //2
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2239,7 +2239,7 @@ struct resource_pool *dcn36_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn36_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn36_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 5a3684307c6b..6aa051154f5e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -2006,7 +2006,7 @@ static bool dcn401_resource_construct(
 	dc->caps.color.dpp.ocsc = 0;
 
 	dc->caps.color.mpc.gamut_remap = 1;
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut; //4, configurable to be before or after BLND in MPCC
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
 	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
@@ -2340,7 +2340,7 @@ struct resource_pool *dcn401_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn401_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn401_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index c0d37f00fed9..d5efe1e8fcee 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1969,7 +1969,7 @@ static bool dcn42_resource_construct(
 
 	dc->caps.color.mpc.gamut_remap = 1;
 	//configurable to be before or after BLND in MPCC
-	dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut;
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut;
 	dc->caps.color.mpc.num_rmcm_3dluts = 2;
 	dc->caps.color.mpc.ogam_ram = 1;
 	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
@@ -2349,7 +2349,7 @@ struct resource_pool *dcn42_create_resource_pool(
 	if (!pool)
 		return NULL;
 
-	if (dcn42_resource_construct(init_data->num_virtual_links, dc, pool))
+	if (dcn42_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
 		return &pool->base;
 
 	BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index 1b397fa7e05c..e4811c3728a9 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -42,7 +42,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dcfclk */
 	if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
-		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		dml_clk_table->dcfclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dcfclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
@@ -52,7 +52,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->dcfclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->dcfclk.clk_values_khz[i] = 0;
-						dml_clk_table->dcfclk.num_clk_values = i;
+						dml_clk_table->dcfclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
@@ -65,7 +65,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* fclk */
 	if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
-		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
+		dml_clk_table->fclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_fclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->fclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
@@ -75,7 +75,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->fclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->fclk.clk_values_khz[i] = 0;
-						dml_clk_table->fclk.num_clk_values = i;
+						dml_clk_table->fclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->fclk.clk_values_khz[i] = dc_clk_table->entries[i].fclk_mhz * 1000;
@@ -88,7 +88,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* uclk */
 	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
-		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
+		dml_clk_table->uclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_memclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->uclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
@@ -98,7 +98,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->uclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->uclk.clk_values_khz[i] = 0;
-						dml_clk_table->uclk.num_clk_values = i;
+						dml_clk_table->uclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
@@ -114,7 +114,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dispclk */
 	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
-		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
+		dml_clk_table->dispclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dispclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dispclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
@@ -124,7 +124,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->dispclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->dispclk.clk_values_khz[i] = 0;
-						dml_clk_table->dispclk.num_clk_values = i;
+						dml_clk_table->dispclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
@@ -137,7 +137,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dppclk */
 	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
-		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
+		dml_clk_table->dppclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dppclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dppclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
@@ -147,7 +147,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->dppclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->dppclk.clk_values_khz[i] = 0;
-						dml_clk_table->dppclk.num_clk_values = i;
+						dml_clk_table->dppclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
@@ -160,7 +160,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dtbclk */
 	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
-		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
+		dml_clk_table->dtbclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dtbclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
@@ -170,7 +170,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->dtbclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->dtbclk.clk_values_khz[i] = 0;
-						dml_clk_table->dtbclk.num_clk_values = i;
+						dml_clk_table->dtbclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
@@ -183,7 +183,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* socclk */
 	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
-		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
+		dml_clk_table->socclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_socclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->socclk.num_clk_values) {
 				if (use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
@@ -193,7 +193,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dml_clk_table->socclk.num_clk_values = i + 1;
 					} else {
 						dml_clk_table->socclk.clk_values_khz[i] = 0;
-						dml_clk_table->socclk.num_clk_values = i;
+						dml_clk_table->socclk.num_clk_values = (uint8_t)i;
 					}
 				} else {
 					dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index e723b4d0aff3..16160f35da1b 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -47,8 +47,8 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 	 * for use with dml we need to fill in using an active value aiming for >= 2x DCFCLK
 	 */
 	if (dc_clk_table->num_entries_per_clk.num_fclk_levels && dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
-		dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
-		dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		dml_clk_table->fclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
+		dml_clk_table->dcfclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
 				int j, max_fclk = 0;
@@ -70,7 +70,7 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* uclk */
 	if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
-		dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
+		dml_clk_table->uclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_memclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->uclk.num_clk_values) {
 				dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
@@ -84,7 +84,7 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dispclk */
 	if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
-		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
+		dml_clk_table->dispclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dispclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dispclk.num_clk_values) {
 				dml_clk_table->dispclk.clk_values_khz[i] = dc_clk_table->entries[i].dispclk_mhz * 1000;
@@ -101,7 +101,7 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dppclk */
 	if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
-		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
+		dml_clk_table->dppclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dppclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dppclk.num_clk_values) {
 				dml_clk_table->dppclk.clk_values_khz[i] = dc_clk_table->entries[i].dppclk_mhz * 1000;
@@ -117,7 +117,7 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* dtbclk */
 	if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
-		dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
+		dml_clk_table->dtbclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->dtbclk.num_clk_values) {
 				dml_clk_table->dtbclk.clk_values_khz[i] = dc_clk_table->entries[i].dtbclk_mhz * 1000;
@@ -129,7 +129,7 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 
 	/* socclk */
 	if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
-		dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
+		dml_clk_table->socclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_socclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 			if (i < dml_clk_table->socclk.num_clk_values) {
 				dml_clk_table->socclk.clk_values_khz[i] = dc_clk_table->entries[i].socclk_mhz * 1000;
-- 
2.43.0

