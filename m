Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C74C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D99C10E161;
	Wed, 13 Dec 2023 06:12:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B4310E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd9RUcocIGR4g9PaWg/5YrM/fos8hjTKWFtBnUXa3z3MgfOqdsM+vqpJktQwEcQFVHaD7pv6c5IqtQpikz4KTr4UvIZze0QVRpcX2iYHLrPaGuh7zYjHQ84n1woz5iyKRh5e7/A7IsKZxjWDygwXVDpAWKCEHjuxLvDOP9wqHRaqKaGPzjrUMlie98Y2yaR0imbWFb7qMeMSJOkyihpPxL+9MKhmBYc4FOFwYtrs6WsAmEV8Tqk2maLIym1KifjjZWdX1NL+PptBEKtx2ZAaiTeQglzVy4hzO24vXEDAkCDCdQCUqOcsbF7YsuPIu3VzpK+J9uOv8MpDvxrWXvyWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY7YH5+DwuIMOH1W3h5lJ2s/sGHRcmWRlPyxX9DrCiE=;
 b=Tf5a9IjiLXNWU4Kcm4KrXzTHT4N9o6Jn/pCShJ1xQXsgj2D7035XwpLQpe5H58WUxKeL6oLFPhTW/x6jEFnnwiVtMeOo1TH8lQv7ya2fzW3Nv3eyYf1fL7I9hZ+dMMx4yCfFFCsOeeJ1c9cBtAd5I2w5yYb35GcO/7SA759+oWJDWLJxOBIXPdZ+Kexu+0o41biZNDqPxFAtFa17XyPaJEcWoxFc4DWG1MZeHhG9lf0gRnkA8D4vblCzh0NSAEMSOmc+dLGefIrBgCxWJ0u4rfyyGBCml7B3QPR0wyuEIGTQ2gC1ni++zBgJ2Yu+m1CQgK6zIV3v6LUd17MPVvX7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY7YH5+DwuIMOH1W3h5lJ2s/sGHRcmWRlPyxX9DrCiE=;
 b=xYWubm6Qcr5Ntajhqrtmo2xcZaTMw6Uyjg+O7/x9yIfPPYzclGxHKA7gkcmqZjbt3F4/Ps8QUNdoHJAxFwU76y7iAGe42UiHy4Uxkun9kQwVQAztSee9B9qCxM59Mifr+UdpPJ+asAy8p3G2TUYEj1om87deiLC7k5qWguOoSCE=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:12:52 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::10) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:12:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:12:50 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:12:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/25] DC Patches for Dec 18, 2023
Date: Wed, 13 Dec 2023 14:12:02 +0800
Message-ID: <20231213061227.1750663-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3893af-2352-414d-912c-08dbfba289d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KadxOoO3avALas/pgJg4HVCOzsmuEyV6cVWRAuomB/nv28LqEs85SiGYUFPWQuhdb0EaJE9nwwjby4Ubr6X9u/3W95kFkfleBXs9EfI1WdWHQ/HVRe8veI8OOzsxThqLKP7AILa3or/75i3evsR2mypzuSsdBeAe+NjrCgbKtHQnxFDm2Hl5maaPUaDq1lV7hTpbiRpKuyBRxFAGnzh5HjVnTWuDuxtYLvXdW15ndzfi9ooY+odKA8hU9iSRJFG5hDJen6o5wy4ItnAC3x7Du4AzZhStInub6LgnfkC0XN5AhVXGNZHucXHlce57rYcUDpIKg7mgke3kl9/TA19RmA8nopBp8/NePiPobA4OJCT8Z+UwWlbo4NEYh9JzDa99HZAxnXEdQ+iMt9sG83buV1bPnjd6ouP/Zy6oEETTukdD+1xQzRMCe5ZfuSQ5OZnXdR49EcEpejSC1zuYbX+gWtXKaxUAKWAOg10pNblgLcsPWX4oOeYRgWHcN7amRxxEGiJ+wSneQW+hNVIpj3MtWb5YlpxMyEiApIsAV+gyei/FdVpu8bWZn84JuoozopL8nunZjaKyWgPUiAqgbXRE/w3AKX+YmNAH96rURUA3Yf4tk846GGtrs4OxhzUpRkn2CXBQiQ/ugOH9BxoGGjLgKCYG+aic60hmg0D9sNbDUhNNXPwQsKVohzMdJsO4mLbTiUuS/RvGps6fpRG/TuvqxFn0DT3LlCIYHRDke27rQ+xvPn5+XovAmcewA6OjYF01WyGvDfU25xeO1nzb+6v7qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70586007)(70206006)(82740400003)(356005)(81166007)(36756003)(86362001)(36860700001)(47076005)(26005)(336012)(83380400001)(426003)(1076003)(7696005)(2616005)(2906002)(54906003)(6916009)(316002)(478600001)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:12:51.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3893af-2352-414d-912c-08dbfba289d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Wayne
 Lin <Wayne.Lin@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- change static screen wait frame_count for ips
- Fix hang/underflow when transitioning to ODM4:1
- Only clear symclk otg flag for HDMI
- Fix lightup regression with DP2 single display configs
- Refactor phantom resource allocation
- Refactor dc_state interface
- Wake DMCUB before executing GPINT commands
- Wake DMCUB before sending a command
- Refactor DMCUB enter/exit idle interface
- enable dcn35 idle power optimization
- fix usb-c connector_type
- add debug option for ExtendedVBlank DLG adjust
- Set test_pattern_changed update flag on pipe enable
- dereference variable before checking for zero
- get dprefclk ss info from integration info table
- skip error logging when DMUB is inactive from S3
- make flip_timestamp_in_us a 64-bit variable
- Add case for dcn35 to support usb4 dmub hpd event
- Add function for dumping clk registers
- Unify optimize_required flags and VRR adjustments
- Revert using channel_width as 2 for vram table 3.0
- remove HPO PG in driver side
- do not send commands to DMUB if DMUB is inactive from S3

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Allen Pan (2):
  drm/amd/display: fix usb-c connector_type
  drm/amd/display: change static screen wait frame_count for ips

Alvin Lee (2):
  drm/amd/display: Revert " drm/amd/display: Use channel_width = 2 for
    vram table 3.0"
  drm/amd/display: Only clear symclk otg flag for HDMI

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.197.0

Aric Cyr (2):
  drm/amd/display: Unify optimize_required flags and VRR adjustments
  drm/amd/display: 3.2.265

Charlene Liu (1):
  drm/amd/display: get dprefclk ss info from integration info table

Dillon Varone (2):
  drm/amd/display: Refactor dc_state interface
  drm/amd/display: Refactor phantom resource allocation

George Shen (1):
  drm/amd/display: Set test_pattern_changed update flag on pipe enable

Ilya Bakoulin (1):
  drm/amd/display: Fix hang/underflow when transitioning to ODM4:1

Johnson Chen (1):
  drm/amd/display: Add function for dumping clk registers

Josip Pavic (2):
  drm/amd/display: make flip_timestamp_in_us a 64-bit variable
  drm/amd/display: dereference variable before checking for zero

Michael Strauss (1):
  drm/amd/display: Fix lightup regression with DP2 single display
    configs

Muhammad Ahmed (2):
  drm/amd/display: remove HPO PG in driver side
  drm/amd/display: add debug option for ExtendedVBlank DLG adjust

Nicholas Kazlauskas (3):
  drm/amd/display: Refactor DMCUB enter/exit idle interface
  drm/amd/display: Wake DMCUB before sending a command
  drm/amd/display: Wake DMCUB before executing GPINT commands

Roman Li (1):
  drm/amd/display: enable dcn35 idle power optimization

Samson Tam (2):
  drm/amd/display: do not send commands to DMUB if DMUB is inactive from
    S3
  drm/amd/display: skip error logging when DMUB is inactive from S3

Wayne Lin (1):
  drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  59 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  29 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  27 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  12 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 300 ++----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  19 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 418 +--------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 861 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  46 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  33 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 244 ++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  59 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  38 +
 .../gpu/drm/amd/display/dc/dc_plane_priv.h    |  34 +
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  78 ++
 .../gpu/drm/amd/display/dc/dc_state_priv.h    | 102 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  76 +-
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  37 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  14 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  33 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   4 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |   4 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  93 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   5 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   5 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  51 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +-
 .../drm/amd/display/dc/dml2/dml2_dc_types.h   |   1 +
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |  89 +-
 .../display/dc/dml2/dml2_translation_helper.c |  10 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  14 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  35 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  35 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   7 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  79 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  78 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  58 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  20 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  19 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 -
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   7 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   7 +
 .../dc/resource/dcn32/dcn32_resource.c        | 134 +--
 .../dc/resource/dcn32/dcn32_resource.h        |  14 -
 .../dc/resource/dcn321/dcn321_resource.c      |  25 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  22 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  15 +
 .../display/include/grph_object_ctrl_defs.h   |   2 +
 79 files changed, 2147 insertions(+), 1338 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_state.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_plane.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_plane_priv.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_state.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_state_priv.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stream_priv.h

-- 
2.37.3

