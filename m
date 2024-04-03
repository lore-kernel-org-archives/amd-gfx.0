Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE4CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599E2112E70;
	Wed,  3 Apr 2024 19:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cnVvANXo";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCF2112E70
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF1MuKovGSKPHsu9YY+wc23Ag+S7DXGMrOxaprh729Tnk2f6Tr0ueg03XihZMWVlomKkg1L5SsYVZETVEuDVULTIazRDn2RfX4VjJhnxbr/wl6GORF/1RUmJYWKO3jknYz2PjW4GNtaXeSB4JKPcWZmcnloUJMm3DiRwpPCmLsjDxwPMHn1oe0dr2H94Tjj1ObwLJITwlEZdBiNY/bgNRQ7bQXFDgIlsg3tvQtCX+8jI7VK0oxfb4wAWG55griEMy9cYEY8gDqjpUqLX2sOsD1wL8cn532zrbE4TMvLFTSZpKhuJ17RfpBwjGJptuPOBRjaWmnulNp3H52Ig+ygxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTpk2vrGs33A7Sci1ZRILPgJFcsF6CwqYmEFFg4eJ/I=;
 b=kih1rcRKbiHYX5dijFVIjPi6M8R+BqQ28QNlAUh/DbW6HQAAt38dSFSceMXP0TD2AcSvxyNoVO2SkY+TGAkYdxPUzEx/ulW6ShjqXRwOe5Sn2YwcQzVeOjirLUQonHDiPt/3dAV0Sex+/2ihqY7S2gq517GpjYns8LWqkhhPG8WnfwJUBR7U5b1jAxFOT/4yuVPkyKBVrSw8U/wMpCQyljnexAqmtIOOx0qCZVKrVwpclj0kFfclyEfygbCrmdZmpIDX5RgSlHlIG3Y8at7FCy8rT+7KqNi8tv++nsVYNcoSlj9iSXR1xg3NEdfia+7BR45bzKKMxJH+KtKPDm6AMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTpk2vrGs33A7Sci1ZRILPgJFcsF6CwqYmEFFg4eJ/I=;
 b=cnVvANXoRjfU3TWahaL3o5i8QvmZKWzSVj2yo3imlhUMtR/hqzkOxuG8cMAfyxiWRVNJUjF/rUMk5M2aGXNObBDAvGjO8UQJyWAXQ68I34tLYB9nK4ziVfSmrYFZ7LGz6H63s6o/I8y7iDLux9Diz+GI1pYS1h176apR46/tnhY=
Received: from CH2PR12CA0022.namprd12.prod.outlook.com (2603:10b6:610:57::32)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:31 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::6d) by CH2PR12CA0022.outlook.office365.com
 (2603:10b6:610:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:31 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:30 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/28] DC Patches April 3, 2024
Date: Wed, 3 Apr 2024 15:48:50 -0400
Message-ID: <20240403195116.25221-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d12749-7856-4668-dcd2-08dc541775a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSBG4WzJdpyBaSQeOmvSkdbz607gvEjsw9p7QZxtdm00g++aDBo1zkIb6BFFbXF7NcqzD91nCFGYwXw3VZxcPaC2hdMuvV/5qhASMCBf4h5HphZT5N72mvZwNqiTRbHKTaIZ9xe9oKM3hD4G/Qca48b4WJpQJmNO/vqHMCirbTOF/JzZjwZPqm6HjMV1Sng1oNla3x72ohpY6VTwEOLD6k8bRn8WyS3JlhWHIuKOiAmz13iRutHYl7bkmKnbABQi5mJ1jm2TN/e8ycW9O19fbqOkAhXcArqCEa3+2y6ygnnbn/zjnF7fHEmHy498s3GpALTuCRWYhSff+J44mY7SnOZJG4HTPvP26JaNjVjIjpgXyaJ5uogxsN9ZbLJobmTaceaUICTQB2GTTjmoEu1I878OBHH/Yh0+IdhTdFET8vt9ffDzDIy1RadalURG1/Wi0gkV1F5XUITxe8ViM1nB+uue/9/v9lfSY3I8PUyhf+g6dieOPp7Hd9wAaOtBFOTwDC4HN0nH9/7BRrWDLXzdtHl0N6/0dwpysAzmQaq7jyZVyDn1a9Xb0F8kp4zpT5IacL0iZXrQjc60fC0morlY++pJIiOMueDEsV7WbxGBXYoByGmzBF07AqkKoRPA9Gn5WVMhzLbjfWzYQeU9K5MefQt57iLmk4+0exBpKL8KD4KgBasJeI1z95WX2hG2s2Dy1y6le29qv/4Je7OCjW2kv7nCfFxEzDHngIAyBV0h3xP47Gyzl8vW4IWYv7KIgfC5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:31.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d12749-7856-4668-dcd2-08dc541775a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Return max resolution supported by DWB

Allen Pan (1):
  drm/amd/display: expand the non standard link rate for testing

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.212.0

Aric Cyr (1):
  drm/amd/display: 3.2.280

Charlene Liu (1):
  drm/amd/display: add dwb support to dml2

Dillon Varone (2):
  drm/amd/display: Add driver support for future FAMS versions
  drm/amd/display: Do not recursively call manual trigger programming

Fudongwang (1):
  drm/amd/display: fix disable otg wa logic in DCN316

George Shen (1):
  drm/amd/display: Rebuild test pattern params for
    DP_TEST_PATTERN_VIDEO_MODE

Harry Wentland (2):
  drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4
  drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST

Lewis Huang (1):
  drm/amd/display: Add option to configure mapping policy for edp0 on
    dp1

Parandhaman K (1):
  drm/amd/display: refactor vpg.h

Qili Lu (1):
  Revert "drm/amd/display: Enabling urgent latency adjustment for DCN35"

Rodrigo Siqueira (11):
  drm/amd/display: Add V_TOTAL_REGS to dcn10
  drm/amd/display: Add comments to improve the code readability
  drm/amd/display: Adjust some includes used by display
  drm/amd/display: Drop legacy code
  drm/amd/display: Update resource capabilities and debug struct for
    DCN201
  drm/amd/display: Disable P010 Support of DCN 1.0
  drm/amd/display: Update DCN10 resource
  drm/amd/display: Add fallback configuration when set DRR
  drm/amd/display: Add fallback configuration for set DRR in DCN10
  drm/amd/display: Change DPCD address range
  drm/amd/display: Reorganize dwb header

Wenjing Liu (2):
  drm/amd/display: always reset ODM mode in context when adding first
    plane
  drm/amd/display: fix an incorrect ODM policy assigned for subvp

Zhongwei (1):
  drm/amd/display: Adjust dprefclk by down spread percentage.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  2 -
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  1 -
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  1 -
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |  1 -
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  1 -
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |  2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 19 ++++--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 50 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 10 +++
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 20 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  5 ++
 .../gpu/drm/amd/display/dc/dc_plane_priv.h    |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  8 +--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  | 23 +------
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  9 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h  |  1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  1 +
 .../amd/display/dc/dml2/display_mode_core.h   |  1 +
 .../dc/dml2/display_mode_lib_defines.h        |  2 +
 .../display/dc/dml2/dml2_translation_helper.c | 45 ++++++++++++-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 65 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |  5 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   | 30 +++++----
 .../amd/display/dc/inc/hw/stream_encoder.h    |  4 --
 drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h   | 53 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  7 --
 .../dc/link/accessories/link_dp_trace.c       |  1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 .../amd/display/dc/link/protocols/link_dpcd.c |  2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    | 15 ++++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  3 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    | 10 ---
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 14 ++--
 .../dc/resource/dce80/dce80_resource.c        |  1 -
 .../dc/resource/dcn10/dcn10_resource.c        |  4 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  6 +-
 .../dc/resource/dcn21/dcn21_resource.c        | 33 +---------
 .../dc/resource/dcn32/dcn32_resource.c        | 28 ++++----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  1 +
 53 files changed, 387 insertions(+), 157 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h

-- 
2.44.0

