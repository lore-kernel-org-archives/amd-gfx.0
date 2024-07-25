Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F70C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6213410E264;
	Thu, 25 Jul 2024 18:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1MKWz6og";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D8710E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftXw1WYHAzHreIFoPz6LLNywnBOOdsReeQp2lYWLMaC16mJoC20hIm51oPP7kvuQfpHZqbAv/ePDmhkB/lmnlTlK7MFuDeFN2dOasZvLwQK4wvbOu7Z1jKme09rnViU2hQqS7SQk1kvHRdhgsB7A2z6lvkVGF0AE5ZzYx7Xx09SFGhjCIH3CqDZI2wmfJ0DzprUAshf1dMRtJA1tne1iRykA4ry8hhoUv9SMK4lyq8cI+nZTukDvTi8UwcW3jK4/UgkX/rKrZz+Bcy01H/PrXoVdeI0qweKN0+S87VwZ37ZSAKPRuT4UFaF2PAVktCejrpZ+EMqPzw/xhGlWUe304g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ges0Y4kN3Ytx+kqb0mCEAvNjFRj1+xmTbll/jfHe4w=;
 b=lx+7Qu+w/wWdvfLKMpynSGuaMJIPtFzrVjpGpJlUw1FJd04RoS+1lUB8zyf7yWv/kUUkyGv0BOQR31naWpCLKljeCTwUeJTbmSTIQXphVyqlOtU3ol/bNJLVcIsE9WcP5ksYdaqKRFo4pyEdHbt9TP0Ig9hCOFmXkMiIMMVJBpBU3Aiy0qBEMGzFM5a/9GdFgrXv42dCQAmHL4LgB5paQdAnahd1JNBLQa/YqCwTTpYSmYXWS5Vzhkn/6+Qud6Fq8hcxbWOjxFwhjZGR4Rpdb3mTY6IxLdZIROYuZvDPCzD9AF+gW0/W3BIknt8BIQ3uYtfJvTmdN5Mh2doB3XmUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ges0Y4kN3Ytx+kqb0mCEAvNjFRj1+xmTbll/jfHe4w=;
 b=1MKWz6ogV/YjZNzNKTz18mOeCBWhXnowELJnewcBe0VsuH2dSg4StQ6JlboEL1ihm73U77ZTLcj/uIjNsko6NYRHdIuD8MJHbpmLjn7ujmUrNk54j+p4bx+IEQbFvyofTWCKGaUy11looak2if1FRFseKJQSyujciYpx3AbigS4=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:03:35 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::6e) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:32 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/39] DC Patches July 25, 2024
Date: Thu, 25 Jul 2024 12:00:44 -0600
Message-ID: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: ee21e297-578d-4d79-1a29-08dcacd41a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBQ+d4aJxY0fUQ1dGHbdo6olv69i1cCcC2y/8toeUL1Cz8v6cg4TjkjasC3x?=
 =?us-ascii?Q?JXDXLtuvkLACCmg3JRaF8rgB3tO5OKf7/lsXjlshy7uoC3tZ5JhmkoRaodSm?=
 =?us-ascii?Q?SuLlEULak2KzgPbNIrNgBfxGDIL1rlOfxR4HSmqfPnlhdxFbtOS3c1Y++zfv?=
 =?us-ascii?Q?t6EJ+0N9s53o29kV3r/GXmgYlO9m1YrcwDvgx35yOT0KGHTygI0dPfSOMqBf?=
 =?us-ascii?Q?j6ZEI8+GsfKvDZD9FoutGr537agh2SH4kNkA4CNb714VdqB/n+7kIdfs/pee?=
 =?us-ascii?Q?KN6n61Ac7zlkM4MhVJtMvdOFwfs/xFs9ohbOHiGvWdnfvKwP1QkFukaensVo?=
 =?us-ascii?Q?HtthWOUUrl1VmD/3C8PTDHnyDjlqe0Ypf+PFqLX9WQejonwnSxLh698qkobY?=
 =?us-ascii?Q?a+b4xIFBAkRGh/t8OSXRGPMCC6DKn4JDpXP7Kz13OGSLPaS9e/L2zYFl4H7n?=
 =?us-ascii?Q?DaAfCTswK6L21mCw73H4WXQOLxnvfhYSq/6zTr6LgjyskgIdDHvdLeeDpwlo?=
 =?us-ascii?Q?9GHx2FSydAstJusIcxPwqfSUNhCGUGU27c5GRrzDqFnVuJoWAcPfJF21YigZ?=
 =?us-ascii?Q?Fad3Cpaz2sHXy6S4Vbxi/oIMx0BQGGJkg64k3c9Qh+1uWukuulXknKv6j389?=
 =?us-ascii?Q?jqN9KUBizLU1RoLOeCKjKcMCkToURJkFjNaqnL38lCfhPzLCEcfupqJs97nP?=
 =?us-ascii?Q?FG+RoIEca3vDYXBQxHgrY0+cVxJLuq9q/bMDsVvDKT1XbpnIR/YEu5NH+1oy?=
 =?us-ascii?Q?U9K3apUSfWDYcsPxBiNnOHKr7SJElI9xSVOGATU0h5E3zLJT3mjCpbwPtuiG?=
 =?us-ascii?Q?V03JyLNb/dPt33J4uY28potFtBxXVwe4cnYJpf1rcsLcTQAokHhub34lxRDu?=
 =?us-ascii?Q?+O7f5Lql+C1sD0RTkQT+i0oM61rfTHlAoeAofs710Oba7/JEo4NwtOI+5FRC?=
 =?us-ascii?Q?qhW/s+99TwBV+0E1VZu7QrAGQNOfYORN6fGoCz6WjWwuu+B7VCjxRNNl/XgO?=
 =?us-ascii?Q?Wy9A7B0ZfM9vmby31xf5oh0aZPv73c6zOmFCPTnNJDAfqn689ChfIvmF4G8d?=
 =?us-ascii?Q?009kzutEePmRksPvU5LpENppO9pn4T13dF2Q9gzVLvLtdo/fkzcbPei3zqLr?=
 =?us-ascii?Q?tjEaXqIohliv74jnoNV6s47nbKQSdARda23UR7WHiL+OggVLA1wB2iVSoAhQ?=
 =?us-ascii?Q?OvrcmrizVNYl5FUwddzoPURiISiJUS4AioYHuEk9xrE5zKGrvowzWydhbUtW?=
 =?us-ascii?Q?/pXx6Fg6uFDcx7+KfTcGY62LTBR0J19pB0B/pThw5yy/NGb78YXy8Dih90GK?=
 =?us-ascii?Q?tO200AkF//pFWrblFJX2J3vt+PRtJ5lbqQUevH+CVKnwNqvzd1ECwvEJd9uQ?=
 =?us-ascii?Q?ypEEH4lekeHWWp0ev44vx8ZJc74FT3Eifv+JiTQqRRhlNH8PidWOJAT7LkbC?=
 =?us-ascii?Q?KvchHcj5LRMotItUlSm9jCOuXe/Zrno+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:35.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee21e297-578d-4d79-1a29-08dcacd41a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
have:

- SPL improvements.
- Address coverity issues.
- DML2 fixes.
- Code cleanup.
- DIO and DCCG refactor.
- Improve the PSR state.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Thanks
Siqueira

Alex Hung (7):
  drm/amd/display: Fix possible overflow in integer multiplication
  drm/amd/display: Check null pointers before using them
  drm/amd/display: Check stream_status before it is used
  drm/amd/display: Avoid overflow assignment in link_dp_cts
  drm/amd/display: Check null values from functions
  drm/amd/display: Initialize get_bytes_per_element's default to 1
  drm/amd/display: Check UnboundedRequestEnabled's value

Alvin Lee (2):
  drm/amd/display: Add option to disable unbounded req in DML21
  drm/amd/display: For FAMS2 don't program P-State force from driver

Aric Cyr (1):
  drm/amd/display: 3.2.294

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactor for dio

Charlene Liu (2):
  drm/amd/display: restore immediate_disable_crtc for w/a
  drm/amd/display: sync dmub output event type.

Chris Park (1):
  drm/amd/display: Add two dmmuy I2C entry for GPIO port mapping issue

Cruise (2):
  drm/amd/display: Add logs for debugging outbox
  drm/amd/display: Get link index for AUX reply notification

Daniel Sa (1):
  drm/amd/display: Underflow Seen on DCN401 eGPU

Hansen Dsouza (2):
  drm/amd/display: Add new enable and disable functions
  drm/amd/display: Add new enable and disable functions for DCN35

Ilya Bakoulin (1):
  drm/amd/display: Use correct cm_helper function

Leo Li (2):
  drm/amd/display: Let drm_crtc_vblank_on/off manage interrupts
  drm/amd/display: Run idle optimizations at end of vblank handler

Meenakshikumar Somasundaram (1):
  drm/amd/display: Enable aux transfer path via dmub for dp tunneling

Nicholas Kazlauskas (3):
  drm/amd/display: Request 0MHz dispclk for zero display case
  drm/amd/display: Add seamless boot support for more DIG operation
    modes
  drm/amd/display: Use gpuvm_min_page_size_kbytes for DML2 surfaces

Rodrigo Siqueira (9):
  drm/amd/display: Re-order enum in a header file
  drm/amd/display: Setup two pixel per container
  drm/amd/display: Replace dm_execute_dmub_cmd with
    dc_wake_and_execute_dmub_cmd
  drm/amd/display: Add missing DET segments programming
  drm/amd/display: Remove duplicated code
  drm/amd/display: Add missing mcache registers
  drm/amd/display: Add dcc propagation value
  drm/amd/display: Add missing registers for dcn32
  drm/amd/display: Remove unused code

Samson Tam (1):
  drm/amd/display: roll back quality EASF and ISHARP and dc dependency
    changes

Sung Lee (1):
  drm/amd/display: Fix Cursor Offset in Scaled Scenarios

Tom Chung (2):
  drm/amd/display: Add a missing PSR state
  drm/amd/display: Reset VRR config during resume

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   46 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   60 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 -
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   14 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |    1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |    2 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   50 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  266 ++-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    3 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |    2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   10 -
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |   18 +
 .../dcn301/dcn301_dio_link_encoder.c          |    0
 .../dcn301/dcn301_dio_link_encoder.h          |    0
 .../dcn314/dcn314_dio_stream_encoder.c        |    0
 .../dcn314/dcn314_dio_stream_encoder.h        |    0
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |    1 -
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |   20 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |    2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |    2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   13 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    8 +
 .../display/dc/dml2/dml2_translation_helper.c |   20 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |    2 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../dc/gpio/dcn401/hw_factory_dcn401.c        |   16 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   30 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    3 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |   10 -
 .../display/dc/link/accessories/link_dp_cts.c |    3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    8 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    5 +
 .../resource/dcn32/dcn32_resource_helpers.c   |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    8 +-
 .../dc/resource/dcn401/dcn401_resource.h      |    4 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1310 +++++--------
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 -
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 -
 .../display/dc/spl/dc_spl_isharp_filters.c    |  427 +---
 .../display/dc/spl/dc_spl_isharp_filters.h    |   33 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 -----------------
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 -
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   92 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 +
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   75 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   23 -
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  518 -----
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  546 ------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |    4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |    4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |    4 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |    4 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |    1 +
 69 files changed, 1510 insertions(+), 4646 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn301/dcn301_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn301/dcn301_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn314/dcn314_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn314/dcn314_dio_stream_encoder.h (100%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_old.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

-- 
2.43.0

