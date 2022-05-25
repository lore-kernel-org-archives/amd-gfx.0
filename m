Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022E4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779C610E5BF;
	Wed, 25 May 2022 16:20:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE1C10E57E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW7Wu191UxHnpXxi7TDVcTNY3W6OQN+LHAGBaNcjUhIhgSPwdPoDgUuUdd0R+HZaGOPKH2p4q3h7F+MP3AP1dgqoM4QXQTehRDAnV3YqVroxTzmJrkQPE+XLjLXbLpNEZZTUyiztfLUpd11P6fOGYjDiV7zcgNP7J8LD2RefH67LPbHu0H+mNDiD94/yjzO7NDqixZy+pMeV9Jf0stmFTI44gblKlLMYfeli4n+61TpNJZOKql9OKRkUBA5A6M2vT0FXrJNJjdsaq/cnn6pfGk2D4Z/sjE1+AMRmcdSEwKAwxmQy7iI2IOk6KrODuO5wQ6v7pzGWIIs0wK7h92riaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiDyiQgsAG56S+VTxICUuEiyGCBBJZAtpPimH3kaIu0=;
 b=jbn4hxlcD3re22D8b2E7WUAXFsJERDACeCnkTm/xhztP/zr/MUGpeFPSK3trl4jS22JLIhl0pYu3JiDizR5B7cz6CGGKNzzkBTKva1mnmwDlemaF+VOgsIRC45VY4wgDa8Hrf5BwujIxI9kscx6JP/l0t5t7mCOx/kJ2zwqWSeBmh5LkImgAyRp8QoWow2oeRVEVmqS72GAyNmwoD0IYMtrPsq2gPxo4axxcOe/McOpuUR+Su76LVAiKcrad5QhmZhwOtjYcfQr3aU8JNF/ZH5SpKSO9XwACTP6rEyZVrCLad+ocMhicliXLbCjieP77SRS0/sghts1RM+3ktLMOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiDyiQgsAG56S+VTxICUuEiyGCBBJZAtpPimH3kaIu0=;
 b=hCBbHSp/Sct76KyoY8C8690Pcw829s4HeK/8O9BDgB1tIvjP8jCf18V/DKt/a2oto3V/jk+b8tuUHWdePhkggTgJHFiqeMtd4mV8geoJD6+Zaz4F8Yf+z+lqUWZyAP7GIFGFT+OQPIlBL9kFk1Upfb2wPIVV43NJmCVZdsX4WuI=
Received: from DM6PR04CA0014.namprd04.prod.outlook.com (2603:10b6:5:334::19)
 by DM6PR12MB2969.namprd12.prod.outlook.com (2603:10b6:5:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Wed, 25 May
 2022 16:20:00 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::ff) by DM6PR04CA0014.outlook.office365.com
 (2603:10b6:5:334::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 16:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:19:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/43] Add support for DCN 3.2
Date: Wed, 25 May 2022 12:18:59 -0400
Message-ID: <20220525161941.2544055-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4bf4d23-d26a-4446-4c89-08da3e6a6aa0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29698725467A7C7601FA9B90F7D69@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIFC+sh+U8MrvcYEUFHO+1Eb+IVzf5dZHg6LHFj+qDMdgaCi6APi71EE65xoAN2KBbOkIiZ7vlib2CDe/OXTLEJQGEPywtx/QQrXRL8nSLCNHk2uFUwtrJFvajYJaC5sNHC4IYMKXl9YCkHx5JiTgt5fOuU2M++pl3y+CjV8nSSPeAgGiO4SotLaZZLFunhc24j80ej+3We/NffGNh80JFzl+94fzB7iVgiUNeFLnEbufhf06tDFyhfgPUrh1S9DUqWPB05c+9b3OaZcAzY10R/IUU9yxzRKa/mZA3FOv1/TTxLZcy+euweS0UckTwOQR2rRM0ealbp6U1uCTOeMsYzr4JKWjfaVb26TZ6MdcP/EmGHwVj2BcYuFgz/1kchH/O0y66e+jk07RpvXKRtSv72UYC2mgrnhEGFrJyQ2ZpmAwlZrrbskW5QMvEQ3rVF0Y8xETBXOo6XK5UYVKjGHudRIj6lICYyhsXQcsALhQOp7JrhZGZny+JJ+HczHd2OX9Ta7VAATFVAGPWLISxKzOtXPbS4mFwe5tls768JC2Zt1WPtaO/2hhR7pZwP31P6+jWBaNdKOVY+VRxpSb/a2A70AP/A5SXNeWZLhIdCvn8ZpTiAvA0BoAByPu78RgkV1nJCBISkpkFNbe4RTLDK/+zvFJMnBfpMFaQk2J2O873/fb71I8+7bCQq8ykO0qZ+6qNsByryQp8tF8m7GEeGioQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(4326008)(2906002)(8676002)(7696005)(8936002)(30864003)(356005)(5660300002)(36860700001)(508600001)(316002)(83380400001)(2616005)(6916009)(336012)(36756003)(426003)(47076005)(1076003)(70586007)(70206006)(82310400005)(16526019)(186003)(40460700003)(86362001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:00.1598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bf4d23-d26a-4446-4c89-08da3e6a6aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These patches add support for DCN (Display Core Next) version
3.2.x.  Patch 4 adds new register headers and is too big for
the mailing list.

Alvin Lee (4):
  drm/amd/display: Add missing instance for clock source register
  drm/amd/display: Implement WM table transfer for DCN32/DCN321
  drm/amd/display: Remove W/A for ODM memory pins
  drm/amd/display: Implement DTBCLK ref switching on dcn32

Aurabindo Pillai (17):
  drm/amd/display: remove stale config guards
  drm/amd: Add atomfirmware.h definitions needed for DCN32/321
  drm/amd/display: Add DCN32/321 version identifiers
  drm/amd: add register headers for DCN32/321
  drm/amd/display: Add DMCUB source files and changes for DCN32/321
  drm/amd/display: add dcn32 IRQ changes
  drm/amd/display: add GPIO changes for DCN32/321
  drm/amd/display: DML changes for DCN32/321
  drm/amd/display: add CLKMGR changes for DCN32/321
  drm/amd/display: add DCN32/321 specific files for Display Core
  drm/amd/display: Add dependant changes for DCN32/321
  drm/amd/display: Add DM support for DCN32/DCN321
  drm/amd/display: add DCN32 to IP discovery table
  drm/amd: Add GFX11 modifiers support to AMDGPU
  drm/amd/display: add missing interrupt handlers for DCN32/DCN321
  drm/amd/display: disable idle optimizations
  drm/amd/display: update disp pattern generator routine for DCN30

Chaitanya Dhere (1):
  drm/amd/display: FCLK P-state support updates

Charlene Liu (1):
  drm/amd/display: use updated clock source init routine

Dillon Varone (9):
  drm/amd/display: Fix USBC link creation
  drm/amd/display: Add guard for FCLK pstate message to PMFW for DCN321
  drm/amd/display: Various DML fixes to enable higher timings
  drm/amd/display: Select correct DTO source
  drm/amd/display: Ensure that DMCUB fw in use is loaded by DC and not
    VBIOS
  drm/amd/display: Add additional guard for FCLK pstate message for
    DCN321
  drm/amd/display: set dram speed for all states
  drm/amd/display: Disable DTB Ref Clock Switching in dcn32
  drm/amd/display: change dsc image width cap for dcn32 and dcn321

Duncan Ma (1):
  drm/amd/display: Add ODM seamless boot support

Eric Bernstein (1):
  drm/amd/display: Use DTBCLK for valid pixel clock

Fangzhi Zuo (1):
  drm/amd/display: Halve DTB Clock Value for DCN32

Jingwen Zhu (1):
  drm/amd/display: set link fec status during init for DCN32

Jun Lei (2):
  drm/amd/display: add new pixel rate programming
  drm/amd/display: Introduce new update_clocks logic

Martin Leung (1):
  drm/amd/display: cleaning up smu_if to add future flexibility

Rodrigo Siqueira (1):
  drm/amd/display: Drop unnecessary guard from DC resource

Samson Tam (3):
  drm/amd/display: do not override CURSOR_REQ_MODE when SubVP is not
    enabled
  drm/amd/display: Match dprefclk with clk registers
  drm/amd/display: Updates for OTG and DCCG clocks

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |      2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |     40 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     97 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |      2 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |    950 +-
 .../dc/bios/bios_parser_types_internal2.h     |      1 +
 .../drm/amd/display/dc/bios/command_table.c   |      4 +-
 .../display/dc/bios/command_table_helper2.c   |      2 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     35 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     17 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |     15 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.h  |     60 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |      8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |      2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |      7 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |      3 +-
 .../drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h |     65 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    725 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h  |     39 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |    134 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |     46 +
 .../dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h  |     63 +
 .../dc/clk_mgr/dcn32/smu13_driver_if.h        |    108 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |     14 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |      3 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     27 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |     24 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |      5 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |     31 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |      2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |      1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |     21 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |     45 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |     27 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     15 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |      6 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |     33 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |      6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |      5 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |     32 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |     34 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |     25 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |     46 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |     16 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |     35 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |      8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |     16 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |     33 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |     14 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |    147 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |      9 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |    106 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |     16 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |      1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |      6 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |     37 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |    303 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |    159 +
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |    294 +
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |     60 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |    461 +
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |    266 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c  |    164 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dpp.h  |     38 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.c      |     90 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.h      |     63 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |    964 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |    172 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |    148 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |     69 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |    958 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |     66 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |    156 +
 .../dcn32_init.h}                             |     20 +-
 .../drm/amd/display/dc/dcn32/dcn32_mmhubbub.c |    239 +
 .../drm/amd/display/dc/dcn32/dcn32_mmhubbub.h |    225 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |    810 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  |    213 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |    268 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |    254 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   4002 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |     88 +
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |     34 +
 .../dc/dcn321/dcn321_dio_link_encoder.c       |    199 +
 .../dc/dcn321/dcn321_dio_link_encoder.h       |     42 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2335 +
 .../dcn321_resource.h}                        |     46 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |      7 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |     36 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |      8 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |      2 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   3835 +
 .../dc/dml/dcn32/display_mode_vba_32.h        |     57 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   6254 +
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1175 +
 .../dc/dml/dcn32/display_rq_dlg_calc_32.c     |    616 +
 .../dc/dml/dcn32/display_rq_dlg_calc_32.h     |     70 +
 .../amd/display/dc/dml/display_mode_enums.h   |     88 +-
 .../drm/amd/display/dc/dml/display_mode_lib.c |     12 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |     15 +
 .../amd/display/dc/dml/display_mode_structs.h |    132 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |    171 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |    242 +-
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  |     73 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |      8 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  |    255 +
 .../hw_factory_dcn32.h}                       |     13 +-
 .../dc/gpio/dcn32/hw_translate_dcn32.c        |    349 +
 .../hw_translate_dcn32.h}                     |     11 +-
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     16 +-
 .../drm/amd/display/dc/gpio/hw_translate.c    |     13 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     10 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |      3 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |     45 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |     44 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |      3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |      7 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |      2 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |      2 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |      7 +
 .../amd/display/dc/inc/hw/timing_generator.h  |      8 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |      2 +
 .../amd/display/dc/inc/hw_sequencer_private.h |      8 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |      7 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     10 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |    432 +
 .../display/dc/irq/dcn32/irq_service_dcn32.h  |     35 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |     19 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |      8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |     26 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |      1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |    493 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |    256 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     51 +-
 .../amd/display/include/bios_parser_types.h   |     11 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |      8 +
 .../gpu/drm/amd/display/include/dal_types.h   |      2 +
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   |  14675 +
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  | 222890 +++++++++++++++
 .../include/asic_reg/dcn/dcn_3_2_1_offset.h   |  14559 +
 .../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h  |  56578 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    |    209 +-
 include/uapi/drm/drm_fourcc.h                 |      2 +
 143 files changed, 339836 insertions(+), 512 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
 rename drivers/gpu/drm/amd/display/dc/{gpio/diagnostics/hw_translate_diag.c => dcn32/dcn32_init.h} (74%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
 rename drivers/gpu/drm/amd/display/dc/{gpio/diagnostics/hw_factory_diag.c => dcn321/dcn321_resource.h} (53%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
 rename drivers/gpu/drm/amd/display/dc/gpio/{diagnostics/hw_factory_diag.h => dcn32/hw_factory_dcn32.h} (81%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_translate_dcn32.c
 rename drivers/gpu/drm/amd/display/dc/gpio/{diagnostics/hw_translate_diag.h => dcn32/hw_translate_dcn32.h} (82%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h

-- 
2.35.3

