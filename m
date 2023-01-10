Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F83C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2E510E113;
	Tue, 10 Jan 2023 16:56:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9377510E12D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRjpgDJxYLmucPJAaapAV8FGREqyk7Ya44pQhuLd0thp5CLfr+O5TWjhDZ64feCO7w3osg75vZUgnl40qsrZkPquWfdoIYzi6PR8Lu0Wjhco6ButrJQxntDGsWFIbfsHzeKuymnPrIteAFzNyXUrFU95isWpT7ONIeJgZ2IgHT4bXfDEklnxsbBWm4rSIwQEX7lV4THDU2nfVq4a4wU+H6uCQdDmY+Hs2tJIQEfEkVyqUbLUrRX5YPn9fWPH+boWgpnKElgDQIOh+WgbiyLKF5VjDfDNifIKTiEHkjF92nxJJZD/GyKSPMq9J1aNgaFknoN2UT6IcNOK5a1O/CC0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80WO3U+JopUnmHLnN/zYPATdR3fufKFFfGVqe16Cmsc=;
 b=eCQYfaYVi+8YNZRKFbs2xQyTx/Kc52qpTIiy8VDkyA0O7YR9XHtPW3eyodaLOIYywhBwChGlNq1gBB9D3MwxPj3eAbO2CILIG1XxQ6u7rzNBSk0o60iJFlK13SpdzCyZ2Y+SzoDsA2Eunu+3+OJPne33VJnNX5pFMh3/DvXQlBD8iSJOySiNNoxPkaCeQGmr396d1amPFd3FUEh9A2HSGL8it0scif1dUJLyV0zaqX+DIyWgrUk6d7sGOZCt9H0AhBBFFyUgR5HQao2T9xZIMbJ+JL4b1rTMrANtI1xUtUC1XHOTlFczlNsNyThoA2qTCalYFGhoY2cz4T2rrfJ0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80WO3U+JopUnmHLnN/zYPATdR3fufKFFfGVqe16Cmsc=;
 b=bM0nJhk9Et8HdaAEr4PPBM0AOISJPOc+fMwF5cJfjlcD77tnlIvopejg9dBNUB9hE2LqHQXwX2ytEDqJ8hx10PCBCxOcaxNwO85lQfuBApUVHJod79e9iM6b/R0pB01QIfWn1zkItkARGkQFTMtvsD3HR5z3oMbqL9kuQjWS3Qs=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:46 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::cb) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:46 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:39 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/37] DC Patches Jan 10, 2023
Date: Tue, 10 Jan 2023 11:54:58 -0500
Message-ID: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f7e708-74e9-4c02-33fa-08daf32ba8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzHEafywJLiLQVuGRnPv3aNDafr/gPpcmxtpMl92AulttMOvMtIMlH1ILD1XGQ/WgPxa3DrPwCdvvhgttA5ZHIv7fuQCYVP4ohsTRKaHOsF7qitBc8t6UcSxDWz1uHAh0uWdC7SqmWiHsFwJSY6vGvf+uYnv3+ezJWD0fUmKZ+ML2WrN6ACX7jiW40OJPzxlVoBRidvDL4aHfYtgg8CCp0GP2NXB866KqYkX4No3JGlZelR2Hl43NJ5BzQCxgavw9nhWYjKaPWJ9F2j1mW9pPQEdvmAuntuiVrz3fX55RkxLJ/AtVYTegPoCwMCcGgvur+/ltoFaGYoAhkLQV4UEmFe7l2sL4DXH3ZqTB8aSmsllrB8OhArG4yrk1CnaF5spREGUlciacNKKShTuuZ4rBdqrHJAaZqEe1gcdNGU2wABvr1HQt3Wc4i/hOu3qVaDaD2Rp90cr0MXw7xwFGO+lgIUGKBBYBOsI6KmHpKLiKKSh92brQ/NMDez3W1zLYaN1+AREH7aWnMEVSdtQRv8N5TNm1lsI8GWyUcYg6eQ5zieqvOqjhGeVr+66x7pyMXvpjVdUxUAIySfxIu8sIudUiBri+LNghsFFlC3ISIH8ujzuMR9HWX28WE9VB42sVcdw8CoL7dbAV5D3IX0F8ljywB11byoM7PYrte5Q8JgAu6RhFYWEQIwe4abEumBO+JO0kYB+tsHHyxLV8SPi818Fww81IhEkK6I4/qFl1VSMW9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(2906002)(356005)(478600001)(2616005)(1076003)(30864003)(16526019)(26005)(7696005)(186003)(5660300002)(316002)(40480700001)(83380400001)(8936002)(82310400005)(36756003)(86362001)(40460700003)(47076005)(426003)(41300700001)(8676002)(336012)(54906003)(70586007)(4326008)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:46.2973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f7e708-74e9-4c02-33fa-08daf32ba8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight the following areas:
    
- Revert patches that caused regressions associated with audio and an
  old change that checks the DCN version.
- Refactor DDC and HDP.
- Move DPIA and DPCD logic to new files.
- Updates to DMUB.
- Optimization and bug fixes for SUBVP/DRR.
- Drop legacy code.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Request min clocks after disabling pipes on init
  drm/amd/display: Allow subvp on vactive pipes that are 2560x1440@60

Aric Cyr (1):
  drm/amd/display: 3.2.218

Aurabindo Pillai (2):
  Revert "drm/amd/display: Demote Error Level When ODM Transition
    Supported"
  drm/amd/display: fix an error check condition for synced pipes

Bhawanpreet Lakha (1):
  drm/amd/display: Change i2c speed for hdcp

Brandon Syu (1):
  drm/amd/display: fix mapping to non-allocated address

Charlene Liu (2):
  drm/amd/display: add hubbub_init related
  drm/amd/display: contional remove disable dig_fifo when blank

Cruise Hung (1):
  drm/amd/display: Fix DPIA link encoder assignment issue

Dillon Varone (9):
  drm/amd/display: Implement FIFO enable sequence on DCN32
  drm/amd/display: Optimize subvp and drr validation
  drm/amd/display: Account for DCC Meta pitch in DML MALL surface
    calculations
  drm/amd/display: Account for Subvp Phantoms in DML MALL surface
    calculations
  drm/amd/display: Use DML for MALL SS and Subvp allocation calculations
  drm/amd/display: cleanup function args in dml
  drm/amd/display: set active bit for desktop with VSDBv3
  drm/amd/display: Remove DISPCLK dentist programming for dcn32
  drm/amd/display: Account for MPO planes in dcn32 mall alloc
    calculations

Dmytro Laktyushkin (1):
  drm/amd/display: fix multi edp panel instancing

Martin Leung (1):
  Revert "drm/amd/display: Speed up DML fast_validate path"

Mustapha Ghaddar (2):
  drm/amd/display: Update BW alloc after new DMUB logic
  drm/amd/display: Update dmub header to match DMUB

Rodrigo Siqueira (1):
  drm/amd/display: Remove unused code

Saaem Rizvi (2):
  drm/amd/display: Remove SubVp support if src/dst rect does not equal
    stream timing
  drm/amd/display: Add extra mblk for DCC

Tony Tascioglu (2):
  drm/amd/display: Optimize link power-down when link powered externally
  drm/amd/display: Skip backlight control delay on external powered
    links

Wenjing Liu (7):
  drm/amd/display: refactor hpd logic from dc_link to link_hpd
  drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc
  drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd
  drm/amd/display: move dc_link_dpia logic to link_dp_dpia
  drm/amd/display: move dp link training logic to link_dp_training
  drm/amd/display: move dp phy related logic to link_dp_phy
  drm/amd/display: move dp capability related logic to
    link_dp_capability

hersen wu (2):
  drm/amd/display: phase2 enable mst hdcp multiple displays
  drm/amd/display: hdcp not enabled on connector 0

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  153 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |    5 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    2 -
 drivers/gpu/drm/amd/display/dc/Makefile       |    6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    1 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |    6 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   14 +-
 .../drm/amd/display/dc/bios/command_table2.h  |    3 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   97 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  542 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 6682 ++---------------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   60 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   35 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |   28 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |    3 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  114 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   69 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |    2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |    1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   41 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |    2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    4 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |    1 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |    2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   10 +-
 .../amd/display/dc/dcn20/dcn20_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    6 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |    2 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |    1 -
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |    1 -
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |    1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    6 +-
 .../dc/dcn301/dcn301_dio_link_encoder.c       |    1 -
 .../amd/display/dc/dcn302/dcn302_resource.c   |   16 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |    6 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   18 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |   10 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    9 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |    5 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |    4 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |    2 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |    1 -
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   30 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |   29 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   17 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |    6 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  176 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |    6 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   15 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  183 +-
 .../dc/dcn321/dcn321_dio_link_encoder.c       |    1 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |    6 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  108 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   43 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   33 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |    5 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |    1 -
 .../drm/amd/display/dc/dml/display_mode_vba.c |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |    1 +
 .../display/dc/gpio/dcn20/hw_factory_dcn20.c  |    6 +-
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |    6 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  |    6 +-
 .../gpu/drm/amd/display/dc/gpio/ddc_regs.h    |    7 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    5 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    6 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  133 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  160 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  105 -
 .../drm/amd/display/dc/inc/hw/aux_engine.h    |    8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   92 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    6 +-
 .../{core/dc_link_ddc.c => link/link_ddc.c}   |  409 +-
 .../i2caux_interface.h => dc/link/link_ddc.h} |   70 +-
 .../amd/display/dc/link/link_dp_capability.c  | 2169 ++++++
 .../amd/display/dc/link/link_dp_capability.h  |   66 +
 .../drm/amd/display/dc/link/link_dp_dpia.c    |  107 +
 .../drm/amd/display/dc/link/link_dp_dpia.h    |   43 +
 .../drm/amd/display/dc/link/link_dp_dpia_bw.h |   47 +-
 .../gpu/drm/amd/display/dc/link/link_dp_phy.c |  145 +
 .../gpu/drm/amd/display/dc/link/link_dp_phy.h |   51 +
 .../amd/display/dc/link/link_dp_training.c    | 1700 +++++
 .../amd/display/dc/link/link_dp_training.h    |  179 +
 .../dc/link/link_dp_training_128b_132b.c      |  260 +
 .../dc/link/link_dp_training_128b_132b.h      |   42 +
 .../display/dc/link/link_dp_training_8b_10b.c |  415 +
 .../display/dc/link/link_dp_training_8b_10b.h |   61 +
 .../dc/link/link_dp_training_auxless.c        |   80 +
 .../dc/link/link_dp_training_auxless.h        |   35 +
 .../link_dp_training_dpia.c}                  |  308 +-
 .../display/dc/link/link_dp_training_dpia.h   |   41 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |  580 ++
 .../link_dp_training_fixed_vs_pe_retimer.h    |   45 +
 .../{core/dc_link_dpcd.c => link/link_dpcd.c} |   13 +-
 .../amd/display/dc/{inc => link}/link_dpcd.h  |    5 +-
 .../gpu/drm/amd/display/dc/link/link_hpd.c    |  240 +
 .../gpu/drm/amd/display/dc/link/link_hpd.h    |   47 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   16 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  168 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   22 +-
 .../amd/display/include/ddc_service_types.h   |    5 +
 .../amd/display/modules/freesync/freesync.c   |   64 +-
 112 files changed, 8789 insertions(+), 7854 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_ddc.c => link/link_ddc.c} (57%)
 rename drivers/gpu/drm/amd/display/{include/i2caux_interface.h => dc/link/link_ddc.h} (52%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_capability.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_capability.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpia.c => link/link_dp_training_dpia.c} (83%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpcd.c => link/link_dpcd.c} (97%)
 rename drivers/gpu/drm/amd/display/dc/{inc => link}/link_dpcd.h (95%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hpd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hpd.h

-- 
2.39.0

