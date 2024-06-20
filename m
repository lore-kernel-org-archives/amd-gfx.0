Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00F1C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCFD10EAC9;
	Thu, 20 Jun 2024 16:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmJNkpWS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBDEC10EAC9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijs05imnQyQVKhuUizirr6BhsRidulGMJPTJELu2e98Ssx9nwgzk9TltRfZ7Vs/bgLlTdXhvSt4Uzsl6+3vc0WjHcqKWkyQns1TkFKadAhT1Yn6MmdLsAh+ssEYvPwiw4gyH/z4/iAQCGvePpXNtHSza/BqAYka6cBDSafYjZiF8rEoipny7Z/pHrztyBgnM/2aJGjXpJiztR0BhcuAHsRMaL7WDIzz66Y//LI9wZQ0qKKDOPswcaff1CwCYd83cP9RKyftWjogjIl2lVxpiMNVZ02I46zI7Xn4nf3th9HdxBsNNtND+lrm36sGMk0KPYXY1CdokF0gfLgG+crgdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyLYq9mnsOYJfZsul+3xOPkw5vv0Z1uFmrm4TS9wh48=;
 b=Dr0jfE7WNkO7VRPKgz6dYPiuLbXwA4z8spPs71YB1qUfophj31tHMnSeY977/Tjo3ErQfumtzDx3OZut7LZvxHfSkNe9Fg0X6YnlRVDmy4xRxLOQc+kaLzKcmlsemwx2nPIYhwYSMnnTb3YPntUz3i4gmJWs2AlfjPgT/5KIwzMj68lxDqEqzURPN8ifDtr1Ahv8gsMSAcTb195sl1RE7pG464i48Skde3N28X/B4/RdN2nhqctna4BjvqHk0NbGColfu5te5UCAJvh7yWWqYCJ2UGJPZI8HUBKHnfqR/o6N95bjpyHFdyO7KFqvvFTCfaflQj9OMf4VMqgR1WaTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyLYq9mnsOYJfZsul+3xOPkw5vv0Z1uFmrm4TS9wh48=;
 b=JmJNkpWSNm1PT7NsnsWRHj1i1uwchb2UFky7FknVaHmdvOZhZkjtLvwZtrOL6vOUg3t+eOr5e5LZ2qDjUoaH2rgFrFNBGKhtLkbb/wvWnt2macX40rQTRewCFzuhvCahehsxkdkma3k+nKXh26s77cz2R0fSS4vIbcXrAUmMFwQ=
Received: from CY8PR19CA0009.namprd19.prod.outlook.com (2603:10b6:930:44::14)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 20 Jun
 2024 16:12:14 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::46) by CY8PR19CA0009.outlook.office365.com
 (2603:10b6:930:44::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:12:13 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:12:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/39] DC Patches June 20, 2024
Date: Thu, 20 Jun 2024 10:11:06 -0600
Message-ID: <20240620161145.2489774-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c94b66-3614-4606-6f6f-08dc9143bf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NFzwI9yED4i4mmcvjVXVJ8L9HLCUypC8HTsyWw3jo4To/6N9iEKmtIhAs2HB?=
 =?us-ascii?Q?P6dQiIM9FwW0JY0gtHNcNMwSaEzz2FUXOoPRge/FEGFm4XU+AYvjbKzE1Zf8?=
 =?us-ascii?Q?F2TYTe/OycplXW+s8OGSCx0HFHaH4mY8Xz6HMLsYOq5ykT0vHIUcPGUlvKgo?=
 =?us-ascii?Q?wVBvBUSj9qbAG0qYscws3v4sS0thKMFRK2G6SGHYxWoIHyfCiEGTEorwMFvu?=
 =?us-ascii?Q?eIzPt4Iz2sIRK8lppkeLryUEYj8DjRfaNzYeHZaHZTV8kjvsNzxkt22xRxbZ?=
 =?us-ascii?Q?KeGWZ+WQ9ymlY1Ova3XaTtiVjGZwZ+xyJuPCGTQzsLH17o+fdwPu1M0ByZBL?=
 =?us-ascii?Q?e5ks+MYtH2xJdG0mtkUJpYKtMy2OS4FzZZ6k3jLAiNMZBVn1fXsaB+0ETRbU?=
 =?us-ascii?Q?fcd+U9lfs55IgDVYl0FjkT2OCUqDiQq2eUK6ebq3yYNQhrLzK0SFSwfuVbT+?=
 =?us-ascii?Q?aLQrSexMfuNWwbClL30P5xo3qTVOLg8mzn/jVzgG6rPzukr9wciyfjLKwYx2?=
 =?us-ascii?Q?Rca5zE1fYeCtURh+DzSd45faxBkCAh2E4jaN3RQMHn7a8FMUYsgfaeWq/pFp?=
 =?us-ascii?Q?ep09CyZN4/B0IUDCzLqgq0Zya7iGqiPVi0XGuX3lkIxq9Yi5s1AOzCivZkbc?=
 =?us-ascii?Q?Flj2o9CgcugTMkI28xJuljT6DUXIFjt1R4LuIXE4J8tH1jp/Q4dy6NC3yncR?=
 =?us-ascii?Q?F8Yh2tE0EUR6hnu/YlJa8EhhM5b5GRmwsE5tIPIuj9rWpqZvSpFfy22eaoRr?=
 =?us-ascii?Q?PKbjOfKMplesv5q0RCPVIuYDQkyqceci4ue3Lp3cgR8LITkFZAzVakYBwmiY?=
 =?us-ascii?Q?mtK5VKnQ3ttO+zWQzDgHhnihOICZTmmBmnxTzudNIepnG3Lnjz8Iql63SoUx?=
 =?us-ascii?Q?cvw69v4hBrG6RIH3wq2Gbuw8CbEZmCgmsnZP5qZsLTR/czZ8iQooiyft7B4y?=
 =?us-ascii?Q?cF7+vamIllykF/0rn/dqy1R5uewBVZr7sf8TbWcWBkI8A7MhvCs4bTTRfcR9?=
 =?us-ascii?Q?cQXoFtSis/dDcQWsGi887FqsJez4OcLbKPYFfiCTPwRBN3gpT1PUfGweHj9W?=
 =?us-ascii?Q?nFIPhtSP5EQTxE9IDVEr90iDaTVTVfY5FdjD7oY4dZsZo1GQ4TjCBS8uZrMZ?=
 =?us-ascii?Q?whuUIR2JhtbkkpjyeoFcooL3Nweq//tDa4bB97o9x8z6kpPh2lK+c+SQ1MfJ?=
 =?us-ascii?Q?uTrJQU6VY3yA9kK/exRzoTnopsB8OSNqFxgGtkHkgg3KHaSlfaRPvvEz2Eb1?=
 =?us-ascii?Q?dWL3tBlhcVl6LDFsAc1n+UdvydFTZ/wA0QPopy32DNfKX1oATo19gWkxcb+8?=
 =?us-ascii?Q?ccNlWvIx4MHQtDO8n9H1/vbyEY7uQeCJ7qp4+Ms5/+6+ZoHL3S8s3Z9mAB0U?=
 =?us-ascii?Q?0AxEynBBKJJak0Y+8CXLAkA3tTvQG+fh7qk/rst/FdguTv1rbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:12:13.9660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c94b66-3614-4606-6f6f-08dc9143bf81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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

* Enable DCC on DCN401
* Fix cursor issues
* Misc Coverity fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (12):
  drm/amd/display: Remove redundant checks for pipe_ctx->stream
  drm/amd/display: Run DC_LOG_DC after checking link->link_enc
  drm/amd/display: Fix uninitialized variables in dcn401
  drm/amd/display: Remove useless function call
  drm/amd/display: Check and log for function error codes
  drm/amd/display: Check and log for function error codes
  drm/amd/display: Check HDCP returned status
  drm/amd/display: Add null checks before accessing struct elements
  drm/amd/display: Ensure curve to hw translation succeed
  drm/amd/display: Validate function returns
  drm/amd/display: Remove always true condition
  drm/amd/display: Remove duplicate null check

Alvin Lee (2):
  drm/amd/display: Program CURSOR_DST_X_OFFSET in viewport space
  drm/amd/display: Wait for double buffer update on ODM changes

Aric Cyr (1):
  drm/amd/display: 3.2.290

Aurabindo Pillai (3):
  drm/amd/display: Use sw cursor for DCN401 with rotation
  drm/amd: Add reg definitions for DCN401 DCC
  drm/amd/display: Enable DCC on DCN401

Daniel Sa (1):
  drm/amd/display: Fix reduced resolution and refresh rate

Dillon Varone (1):
  drm/amd/display: Make DML2.1 P-State method force per stream

Duncan Ma (1):
  drm/amd/display: Reset DSC memory status

George Shen (1):
  drm/amd/display: Call dpmm when checking mode support

Ivan Lipski (2):
  drm/amd/display: Remove redundant var from display_rq_dig_calc in dml
  drm/amd/display: Remove unnecessary variable

Joan Lee (1):
  drm/amd/display: Add Replay general cmd

Leo (Hanghong) Ma (1):
  drm/amd/display: Always enable HPO for DCN4 dGPU

Michael Strauss (1):
  drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is
    present

Nevenko Stupar (3):
  drm/amd/display: Fix cursor issues with ODMs and HW rotations
  drm/amd/display: Fix cursor size issues
  drm/amd/display: Fix cursor issues with ODMs and magnification

Nicholas Susanto (1):
  drm/amd/display: Temporarily disable HPO PG on DCN35

Relja Vojvodic (2):
  drm/amd/display: Refactor dccg401_get_other_enable_symclk_fe
  drm/amd/display: Fix 1DLUT setting for NL SDR blending

Roman Li (1):
  drm/amd/display: Use periodic detection for ipx/headless

Ryan Seto (2):
  drm/amd/display: Add HW cursor visual confirm
  drm/amd/display: Adjust reg field for DSC wait for disconnect

Sung-huai Wang (1):
  drm/amd/display: Add workaround to restrict max frac urgent for DPM0

TungYu Lu (1):
  drm/amd/display: resync OTG after DIO FIFO resync

Wenjing Liu (1):
  drm/amd/display: Remove a redundant check in authenticated_dp

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  39 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  48 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   3 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  11 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  29 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  57 ++--
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   5 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  18 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   8 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  14 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  14 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  14 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  14 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  14 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  14 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   4 +-
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |  17 ++
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  29 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   6 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  50 ----
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  24 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  13 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |  58 +++-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   3 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |   3 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   3 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 280 ++++++++++++++++++
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |   5 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  14 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  71 ++---
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  14 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  17 --
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  34 ++-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 169 ++++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  31 +-
 .../dc/link/protocols/link_dp_training.c      |   3 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  13 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   9 +
 .../dc/resource/dcn401/dcn401_resource.h      |   2 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +
 .../display/modules/hdcp/hdcp1_execution.c    |  24 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   3 -
 .../include/asic_reg/dcn/dcn_4_1_0_sh_mask.h  | 110 +++++++
 75 files changed, 1021 insertions(+), 431 deletions(-)

-- 
2.34.1

