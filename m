Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FEFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914DD10E992;
	Thu, 30 Jun 2022 19:13:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E4511A19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrnS45irgpHVBaPDii5NGR5CmIK1sNOWswmJQKIPbKqmGsXCLM9GHeLXdjUk4UCoLfE23+EeO7AseNwWJwJiyBkN8MDyE79JDx5LQ4/x+iD7ou5Xh6os6dPYa0VL52yKmkqpm/H+QT+h3bwNeO+HgZq1g4cugGtawX1dKYsf/TnE8o02jSTpIMJfAZISTZ79x165lKXNYnQq7xQ9N5RPnUgEmsO42Xl8tQm4Pvcu8Cg/ibeaq4bD4QuQ1Czmr+f4TUT9SI3oG20S7YBlwvMh/Q0NuBec3lMMDwJsdA2a9MPgvxjgdgQT9vSKfFGdOBkiX0kKBXl8Ij91/1GlWQmTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4+E1wjklfyXjDplZXcZipS3bUaF5Bg8h73MhX9E4ko=;
 b=SOoQrtpsZ0lpw0rX5/J8N4C1ZbegSqiuVBGpDyJBKz93gqfPu7OUrXewM8NlR2INydaAqGWDKkd4TvEDAVzdhNuIgjrP/UY6ktIx/dDmzjoD9yYx5COUdIWkNOtchVTohZveTGu6UxZKazEFxAJVQyy1igdxrtZ4en5hsIxhzGAW4lFRwVBHERw3uWFDZoutPF+OnCnXH1rgws4vA8zxrKuCZLvi2rxzLlkaVR5Ba2XM6hzFz/DEUKowVelQyVKYf608M/yyZBQ5D/SWc8cVD5asWhJrULSGj1YZ2Hex0SeHrGKdyWYSPps023RTJnoFHEmRy3iwLzUOabbnvfhvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4+E1wjklfyXjDplZXcZipS3bUaF5Bg8h73MhX9E4ko=;
 b=j1IzT95J/b5aYwR67FsUHgosUmoCH94p1bzRNsouEV2tGQEyfZ97sBUIztDuyI69WqRk8ZrxTR6HtAPlVeAgj8ThgbfmCP9GVcUgDBoFdTsR7YdbWyrGKnvDRmBQk/nFHSNB+eCYu0jb1lvkBpFrGhekzmwP5btvFg3m/gd6tA4=
Received: from BN0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:408:e5::31)
 by MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 19:13:49 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::5e) by BN0PR02CA0056.outlook.office365.com
 (2603:10b6:408:e5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:49 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/40] DC Patches Jun 30, 2022
Date: Thu, 30 Jun 2022 15:12:42 -0400
Message-ID: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2507aac2-f99a-414c-839e-08da5acca9a1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vf+yyfW5VaG0SwfWehrdjuOtGB35zcZDT2hPFw5k1xfUvy6OCABToWD3fuTokYgagqhMWM38UcOx7poImXHDyGUbmfInnUSFshi55dteQdHTyjx4c3CS+L4kb0rTyOpr4H2r3xIN2vOkHEjSBCa9V27l7oLxzBnj8uM4xCuNgcmJwCr9MHBlT+qBDhcRb1+PpC5cGTw4v4+mC6EfZbmRz8Y9QKfJV50PKRfYE13bwRQzrSj/1LFD2KdQA65juo8nc9TBHs9VZSpddrp6ei0PLQ0QaJQqCK7K4HKGVKDYxhizNSjonNznsxIwplYPz98bAnChL6AHdsZ6ndKk76o/E+pS7lk0lOKHteZDHTrS7XeiYPlouGz6kkvdcj0BmUzpa3aVm3OSrEtXNlRxqdvky/zW9GKoR2oESf1Up2oTbMYM8AObgcMie34sR+nNh9V9ZPfrGqNLdn6htN0zNNozra25c13a3Fk0QCuqH6asLhboSS1zVW+ef/DMfjFC74hu2n04Ck8WpBdPqF4xDpmbnvrl4BjJYGJiluG/95PRY4RbiPy6WOW9iGfq55KOEvc0rBwSajOkz1OFBSpqhwfZ1Y8FYV6ky3VECOXAZUleOi8aH4HDQkU3Y/ylXiApvoJX3TWA7lC9RLRajzlbbwgHePEZPVLlxiDGR9h66dO8/bfZpRcZy+DLYcTIX0oFRkr7SlYhvhfnIaBkfuy80l/FzRXHRzi8xLb+6OwlaewOiRS2s8KvzDzswJ7v87Rf1dSmq5RP9nw1PANts9dbiTt8vhVSZ1ZnPFyW/xrNhHpcP7bnf5Fj1Qg5ce+NF4oDvHV3yVP5EUHaM3aCji8II3hhNmUiaJlGgcSv/qiw/kRw1Js=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(40470700004)(46966006)(36840700001)(1076003)(6666004)(478600001)(4326008)(2906002)(41300700001)(316002)(40460700003)(86362001)(186003)(16526019)(2616005)(8676002)(70586007)(8936002)(83380400001)(82310400005)(70206006)(36756003)(40480700001)(6916009)(47076005)(54906003)(81166007)(356005)(7696005)(82740400003)(36860700001)(336012)(26005)(5660300002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:49.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2507aac2-f99a-414c-839e-08da5acca9a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
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

This DC patchset is a large one that brings improvements in multiple
areas. In summary, we highlight:

- Program ACP-related registers
- Fixes for DMUB, DPIA, PSR, and others
- Improvements in the pipe split
- Add SubVP code
- Add basic setup for FAMS support
- Improve BB capabilities

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alan Liu (1):
  drm/amd/display: Program ACP related register

Alvin Lee (5):
  drm/amd/display: Add SubVP required code
  drm/amd/display: Change DET policy for MPO cases
  drm/amd/display: Make OPTC3 function accessible to other DCN
  drm/amd/display: Don't set dram clock change requirement for SubVP
  drm/amd/display: Maintain old audio programming sequence

Aric Cyr (1):
  drm/amd/display: 3.2.192

Chris Park (3):
  drm/amd/display: Switch to correct DTO on HDMI
  drm/amd/display: Indicate stream change on ODM change
  drm/amd/display: OVT Update on InfoFrame and Mode Management

Dmytro Laktyushkin (2):
  drm/amd/display: disable timing sync b/w odm halves
  drm/amd/display: disable otg toggle w/a on boot

Duncan Ma (1):
  drm/amd/display: Add flag to modify MST delay

Eric Bernstein (3):
  drm/amd/display: Add function to set pixels per cycle
  drm/amd/display: Update gpuvm_max_page_table_levels IP param
  drm/amd/display: Fix null timing generator resource

Evgenii Krasnikov (1):
  drm/amd/display: add an option to skip wait for HPD when powering on
    eDP panel

Fangzhi Zuo (1):
  drm/amd/display: Fix dmub soft hang for PSR 1

Hamza Mahfooz (2):
  drm/amd/display: enable PCON SST support for newer ASICs
  drm/amd/display: rename hdmi_frl_pcon_support

Harry Wentland (1):
  drm/amd/display: Move all linux includes into OS types

Jimmy Kizito (3):
  drm/amd/display: Maintain consistent mode of operation during encoder
    assignment
  drm/amd/display: Disable TBT3 DSC work around by default.
  drm/amd/display: Fix uninitialized variable.

Jun Lei (1):
  drm/amd/display: Extend soc BB capabilitiy

Martin Leung (2):
  drm/amd/display: Prepare for new interfaces
  drm/amd/display: guard for virtual calling destroy_link_encoders

Meenakshikumar Somasundaram (1):
  drm/amd/display: Remove configuration option for dpia hpd delay

Michael Strauss (1):
  drm/amd/display: Initialize lt_settings on instantiation

Nicholas Kazlauskas (4):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal
  drm/amd/display: Guard against ddc_pin being NULL for AUX
  drm/amd/display: Remove incorrect ASSERT check for link_enc
  drm/amd/display: Guard against NULL link encoder in log hw state

Rodrigo Siqueira (6):
  drm/amd/display: Add missing registers for ACP
  drm/amd/display: Use two pixel per container for k1/k2 div
  drm/amd/display: Add basic infrastructure for enabling FAMS
  drm/amd/display: Add SubVP control lock
  drm/amd/display: Add minimal pipe split transition state
  drm/amd/display: Fix refresh rate issue on Club 3D

Samson Tam (1):
  drm/amd/display: Apply ODM 2:1 policy for single display configuration

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |  27 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |   2 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   6 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   7 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 384 +++++++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   9 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  58 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  32 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  32 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 -
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  27 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 416 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  24 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  13 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   8 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   3 -
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   2 -
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   3 -
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   2 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   5 +-
 .../amd/display/dc/dce/dce_stream_encoder.h   |  14 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   2 -
 .../amd/display/dc/dce110/dce110_compressor.c |   3 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  10 +-
 .../display/dc/dce110/dce110_opp_regamma_v.c  |   2 -
 .../amd/display/dc/dce110/dce110_resource.c   |   2 -
 .../display/dc/dce110/dce110_transform_v.c    |   2 -
 .../amd/display/dc/dce112/dce112_compressor.c |   3 -
 .../amd/display/dc/dce112/dce112_resource.c   |   2 -
 .../amd/display/dc/dce120/dce120_resource.c   |   2 -
 .../drm/amd/display/dc/dce80/dce80_resource.c |   2 -
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   2 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c  |   2 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   3 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   2 -
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   2 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   5 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  17 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  44 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  12 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   1 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   4 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  22 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  | 106 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   5 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 172 ++++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |  14 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   4 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   8 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 245 ++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  21 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  12 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  | 236 +++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  | 117 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 680 +++++++++++++-----
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  20 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 260 +++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   | 522 ++++++++++----
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   6 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +
 .../amd/display/dc/dml/display_mode_structs.h |   3 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   5 +-
 .../gpu/drm/amd/display/dc/gpio/gpio_base.c   |   2 -
 .../drm/amd/display/dc/gpio/gpio_service.c    |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |   3 -
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   2 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |   2 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   6 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   7 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   5 +
 .../dc/irq/dce110/irq_service_dce110.c        |   2 -
 .../dc/irq/dce120/irq_service_dce120.c        |   2 -
 .../display/dc/irq/dce80/irq_service_dce80.c  |   2 -
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |   2 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 -
 drivers/gpu/drm/amd/display/dc/os_types.h     |   5 +-
 .../display/dc/virtual/virtual_link_encoder.c |   2 -
 .../dc/virtual/virtual_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 114 ++-
 .../amd/display/dmub/inc/dmub_subvp_state.h   | 160 +++++
 .../drm/amd/display/include/set_mode_types.h  |   8 +-
 .../amd/display/modules/color/color_gamma.c   |   3 -
 .../amd/display/modules/freesync/freesync.c   |   2 -
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    |   2 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   2 +
 113 files changed, 3502 insertions(+), 573 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h

-- 
2.25.1

