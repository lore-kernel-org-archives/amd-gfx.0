Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6FAC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D0610E6B9;
	Tue, 11 Jun 2024 16:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBltMrqE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E736810E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgGAZrwFsBmhiZXgDtl3q53kSLwD+MGMJMoggWSfVcBTIHljbMFkDS1t2g7QtQnV1UuAlM41oyMJFj8qSNr/0w+MjmW72PWJlfjHXoWcmB2rzkvNr5AR3VnOeKET0d3LkQmaB/ib5EHpNmzSvX577YusqNOoTwhxRbYeZKGXQu1gB1A7GT8sbJMPhEsN0Y0j8iEhcapFHqzDI9Ao7bjzoBZMSNdAX8ZlIIvc4uYIPtOYXHQJgC3qoCnAWEmrZL0ZV9Pz+f0Rl058RpIbpu/3DiCXPDl9xg9dMRd8yFrhBRasHP25oiFgPXyEn6LITjUliMYIgKDtX/dh2g3x/JoIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw85O4FeI6z2S4fKamkQQj2VFqrHhcYqGDMVE6hD7tU=;
 b=VrOjnb3YpVgJQwH+wo5tXQkzHbOg8I6iNHS92RFFgyC2l5oVMu1HwBiW1heNfx6J+RGvla8rNs+s8Hdu4lp9hZgoXnU/q0PKGe7iaZxSafW70z922UZQaWuNhzZxNxiMUHBjDg0nrnps+0/XeA58V7XylAwx5fjzCP19ouOUkXDv6dfNaDw6rhhPyJGdJ0/EhhNzXy2dFcwLI1syGHlBu+r6sMfBsGfVXHsJjbEciaf0OzOnWH+2+RQm/efeYr04j4appaM1ydx59q3s4+OJO5bWoyuI/RnruhQh/cEA/8TYt6ngSF6k3KEP30EooXnVtCyYztb/P8d8JHvzjRcaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw85O4FeI6z2S4fKamkQQj2VFqrHhcYqGDMVE6hD7tU=;
 b=bBltMrqE6NbtxrAwLOWWQ5QqOVojifqv++YbNIJHFNtQZjrY3hRWCkgqnGQLuJc+QxmgGZA0olc3YDnBC3ICWbHwKift7Wc8IsGe22musfRCNWnKjvn/mFYV3xTB3qXXeS+4srpUO4hLeaYbiKEWRTp2fvm0ayg63CA880QTBVo=
Received: from BLAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:32b::35)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.39; Tue, 11 Jun
 2024 16:52:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::78) by BLAPR03CA0030.outlook.office365.com
 (2603:10b6:208:32b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.26 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:16 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>
Subject: [PATCH 00/36] DC Patches June 11, 2024
Date: Tue, 11 Jun 2024 12:51:03 -0400
Message-ID: <20240611165204.195093-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: fc79243f-6f48-49f0-ab50-08dc8a36da9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MoJK4+MTprnDKkMFKmKuMSmJIUisl36qP1LdeBNuyPQPjnoyIhYyIMTyCZ1?=
 =?us-ascii?Q?2Cd29Z7OaPcK7fe8OeM1QuKsAJKk4bnquOWHmF7GkTzi4XwmFFyWPK/WTrse?=
 =?us-ascii?Q?KIzsADRz1VD9rHXiOM+S4Lt+Vmk7s6Py12tjPqSloJAuXMPcxeYekI+tFfxL?=
 =?us-ascii?Q?Q9Mpzm4S9j17ypY5Xav65A4rU7VQawxKC0JAeOpuGVi7MveMhAakbIXEHsSE?=
 =?us-ascii?Q?caPabiG90uTMezC+io79JZmE/bUzq2CARZMOWQaXXjen/S9JHehTXtTxPCh/?=
 =?us-ascii?Q?YWUoFdDI0yULDVPRxkG6z6AfyhmjGXMFF3eaB649F8cttRECTi+E9CcT8qtP?=
 =?us-ascii?Q?Q1ezVSmtdebZQcOq5yzqgI60nyJIgcGLwegib3xVawhdebkBFihO1qnJ7j65?=
 =?us-ascii?Q?ylCavOhOVlybbUSXTb9ias6OTg6XiSGcu48eyYlwvYLOhUlmmUnsr8oQAj06?=
 =?us-ascii?Q?xcfb+veAd9/UUkhSS7FC1lyz6ehL3ny9wvQQFnZupQ7TIOWlPZDVXv/bGa3w?=
 =?us-ascii?Q?ggkbrAejdrN5eWvvtXGsULrAZjlsIzyZPeNk+IXKtw7B6Zy6TQzLj19YH9A0?=
 =?us-ascii?Q?cRsN1Jfq9LpncZgkQpkritLG4D13L1kX5h1nC6Kvltz1YsDJeX3uRqQodoii?=
 =?us-ascii?Q?Sw0Cc3zgCsTI9CEOwbQQzKSMv9D9y2h1OiS9K3SLc6hG+dwuHOR8vTIHqe1b?=
 =?us-ascii?Q?qywnoVCVdNlIxdcUJAaMAy2Qd2eeFT9Xnfb436Um2+8rLkz2TPINKaMMHAK2?=
 =?us-ascii?Q?xwc5OYI2S9YdsJeEHqdL1jYzIAitD3aX/XTDVi3Fl+qBtukEHy+tbe3jhLS8?=
 =?us-ascii?Q?InHnobbhyt9n2JOI0fPtd8p1swtjTCQiyeUxg2+jtx9UDloDKGhdGd+ZcnUZ?=
 =?us-ascii?Q?CREEWu9esT/S33qe2eZYgfxG9gxrSClrJDvapiiYuGdLCoIJzNtv3tPMb7u7?=
 =?us-ascii?Q?tU12a9p9ta0hzzOs7ppKWlMJblGExbmu3nJhKFqSxArcE7D2y8BApGBemssq?=
 =?us-ascii?Q?OhdIdf9TPmYu4Cj3UKN+ywkW+kj4JioSK47VfpCE1KbUWqNXADpArfTwSGke?=
 =?us-ascii?Q?Tx1Vr946NAx2UgYM2Rdq4A17s83Kw2WW6C7AYxQn8B126/4ZY3Bo/RhTxCqt?=
 =?us-ascii?Q?aPIbsJD2WxRdnsCgt9PdGUl7hnk+DytMq+i+m7xPyS2MMhc4eu/yc9lrfmgl?=
 =?us-ascii?Q?8Ku0YcMMzD3/+n3Ji/3rv6bCRkU08hU51oODOVavkHoDOX39ie+YX/2kJCof?=
 =?us-ascii?Q?+P4D8FaIo3qGzmrAj/cIUgMbyex41zjJRZ9PbPXvp31uiPxZbJg3qFuvLlmu?=
 =?us-ascii?Q?4by3FXI9bb1/410Mw87brxVjlk9Fl44t8deSH/PPF7ULOpr4eaK85/5tP1DW?=
 =?us-ascii?Q?XuR4rEU4JNZzgGt4JMXzoZ/weAzn4v4KfRvceyD0cxQL7eGG5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:17.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc79243f-6f48-49f0-ab50-08dc8a36da9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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

Alex Hung (15):
  drm/amd/display: Explicitly extend unsigned 16 bit to 64 bit
  drm/amd/display: Add null checker before passing variables
  drm/amd/display: Check BIOS images before it is used
  drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
  drm/amd/display: Add null checker before access structs
  drm/amd/display: Check dc_stream_state before it is used
  drm/amd/display: Check pipe_ctx before it is used
  drm/amd/display: Covert integers to double before divisions
  drm/amd/display: Remove redundant checks for res_pool->dccg
  drm/amd/display: Remove redundant checks for ctx->dc_bios
  drm/amd/display: Remove redundant null checks
  drm/amd/display: Remove redundant checks for opp
  drm/amd/display: Remove redundant checks for context
  drm/amd/display: Check UnboundedRequestEnabled's value
  drm/amd/display: Remove redundant null checks

Alvin Lee (1):
  drm/amd/display: Make sure to reprogram ODM when resync fifo

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.222.0

Aric Cyr (1):
  drm/amd/display: 3.2.289

Chris Park (1):
  drm/amd/display: On clock init, maintain DISPCLK freq

Dillon Varone (2):
  drm/amd/display: Enable DCN401 idle optimizations by default
  drm/amd/display: Add null check to dml21_find_dc_pipes_for_plane

Ivan Lipski (3):
  drm/amd/display: Remove redundant condition with DEADCODE
  drm/amd/display: Remove redundant condition in VBA 314 func
  drm/amd/display: Remove unused value set from 'min_hratio_fact' in dml

Joshua Aberback (3):
  drm/amd/display: DCN401 full power down in HW init if any link enabled
  Revert "drm/amd/display: workaround for oled eDP not lighting up on
    DCN401"
  drm/amd/display: Remove duplicate HWSS interfaces

Michael Strauss (1):
  drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA

Mounika Adhuri (1):
  drm/amd/display: Refactor DCN3X into component folder

Relja Vojvodic (1):
  drm/amd/display: Add dcn401 DIG fifo enable/disable

Rodrigo Siqueira (3):
  drm/amd/display: Fix NULL pointer dereference for DTN log in DCN401
  drm/amd/display: Fix warning caused by an attempt to configure a
    non-otg master
  drm/amd/display: Improve warning log for get OPP for OTG master

Sridevi Arvindekar (1):
  drm/amd/display: mirror case cleanup for cursors

Sung Joon Kim (1):
  drm/amd/display: Send message to notify the DPIA host router bandwidth

Wenjing Liu (1):
  drm/amd/display: fix minor coding errors where dml21 phase 5 uses
    wrong variables

 drivers/gpu/drm/amd/display/Makefile          |   7 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  19 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 -
 drivers/gpu/drm/amd/display/dc/Makefile       |   6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  14 +++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  57 ++++++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  21 +++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   2 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  17 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  21 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  15 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  24 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  20 +++-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  19 ---
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |  17 ---
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |  19 ---
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  63 ++++++++++
 .../{ => dio}/dcn32/dcn32_dio_link_encoder.c  |   0
 .../{ => dio}/dcn32/dcn32_dio_link_encoder.h  |   0
 .../dcn32/dcn32_dio_stream_encoder.c          |   0
 .../dcn32/dcn32_dio_stream_encoder.h          |   0
 .../dcn321/dcn321_dio_link_encoder.c          |   0
 .../dcn321/dcn321_dio_link_encoder.h          |   0
 .../{ => dio}/dcn35/dcn35_dio_link_encoder.c  |   0
 .../{ => dio}/dcn35/dcn35_dio_link_encoder.h  |   0
 .../dcn35/dcn35_dio_stream_encoder.c          |   4 +-
 .../dcn35/dcn35_dio_stream_encoder.h          |   6 +
 .../dcn401/dcn401_dio_link_encoder.c          |   0
 .../dcn401/dcn401_dio_link_encoder.h          |   0
 .../dcn401/dcn401_dio_stream_encoder.c        |   4 +-
 .../dcn401/dcn401_dio_stream_encoder.h        |   0
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  20 ++--
 .../dc/dml/dcn20/display_mode_vba_20.c        |  16 +--
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   4 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   5 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   5 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   8 --
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   5 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   4 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   5 -
 .../dc/dml/dcn314/display_mode_vba_314.c      |  11 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   5 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  11 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   8 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   5 -
 .../amd/display/dc/dml2/display_mode_core.c   |  12 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  28 ++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  28 ++---
 .../dml21/src/dml2_core/dml2_core_shared.c    |  24 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   5 +
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   4 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   9 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dwb/Makefile   |  37 ++++++
 .../display/dc/{ => dwb}/dcn35/dcn35_dwb.c    |   0
 .../display/dc/{ => dwb}/dcn35/dcn35_dwb.h    |   0
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  35 ++++++
 .../dcn32/dcn32_hpo_dp_link_encoder.c         |   0
 .../dcn32/dcn32_hpo_dp_link_encoder.h         |   0
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   9 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  61 +++++-----
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   2 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 -
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   1 -
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  19 ++-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 110 ++++++++++--------
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  82 ++++++++++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   4 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  75 ++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 -
 .../display/dc/hwss/hw_sequencer_private.h    |   2 -
 .../link/protocols/link_edp_panel_control.c   |   3 -
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |  45 +++++++
 .../dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.c  |   0
 .../dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.h  |   0
 .../dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.c  |   0
 .../dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.h  |   0
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  45 +++++++
 .../display/dc/{ => mpc}/dcn32/dcn32_mpc.c    |   0
 .../display/dc/{ => mpc}/dcn32/dcn32_mpc.h    |   0
 .../display/dc/{ => mpc}/dcn401/dcn401_mpc.c  |   0
 .../display/dc/{ => mpc}/dcn401/dcn401_mpc.h  |   0
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |  35 ++++++
 .../display/dc/{ => opp}/dcn35/dcn35_opp.c    |   0
 .../display/dc/{ => opp}/dcn35/dcn35_opp.h    |   0
 drivers/gpu/drm/amd/display/dc/pg/Makefile    |  35 ++++++
 .../display/dc/{ => pg}/dcn35/dcn35_pg_cntl.c |   0
 .../display/dc/{ => pg}/dcn35/dcn35_pg_cntl.h |   0
 .../gpu/drm/amd/display/dc/resource/Makefile  |   2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |   4 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dcn32/dcn32_resource_helpers.c            |   0
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |   3 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 124 files changed, 880 insertions(+), 409 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn321/dcn321_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn321/dcn321_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_stream_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_stream_encoder.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_stream_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_stream_encoder.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dwb/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn35/dcn35_dwb.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn35/dcn35_dwb.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn32/dcn32_hpo_dp_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn32/dcn32_hpo_dp_link_encoder.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn32/dcn32_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn32/dcn32_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn401/dcn401_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn401/dcn401_mpc.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn35/dcn35_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn35/dcn35_opp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => pg}/dcn35/dcn35_pg_cntl.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => pg}/dcn35/dcn35_pg_cntl.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource_helpers.c (100%)

-- 
2.45.1

