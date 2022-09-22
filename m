Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F056C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778AA10E01F;
	Thu, 22 Sep 2022 00:18:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC90110E01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzSF72xup60u7Q7WsuT2OvkWTodDoPKi2djhx1Z5Cjj6pkgDmP1bvhgYIfZOwFsXVu1QxDqmHVBpP9Lw11KmaW6wun37eFEJ7jLv9qpm3tOqwo4RyOmHlIBGYzCFJjFpl44baQpDInfwBnURBJuE7kuy14x/+dsdTwo7s8V79W9Yefyu0qC4WN5lCcq1G1hnG2qBMLMro7bIbXQVaQD7YOaW4qpJiVkhSkxZv7A39kJfqj9xxoDE9f87HpdoHJySEsltmN/JEtCKdnRIXh5+L68n4H19TW5mosHa6iwMAYSkUiLVqQKv+8tqHm+LNORnbHwIYGMq9GHsk85DyGhFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmO1vweYc3oNN40/bSx7mo/Gjtm615ax51lZ5EaB/s8=;
 b=iYI1IBloTPtxbGzYAMqNmqCgVb0WtyBvbI86NdLOJX0ilThk9ND+0wG7bpJYpfzIVPD3jYa3+dBaDutvahWYJv81Suz8xkIjz6GRzKECD3fmvd9C/7NLRqRFWztaUtqoOYPTk9GGy/4t7KQtEBjRPB8DTGvSyNrbM/6HPYddf3i9PQLFo2SfmnlU7pikeE0woQw4wIh0ViPfbfBlv1VHnt0kOmraA/sEAavMcD+gPSKaMQObN1OHrPWVF3q+Xalt1Za/yESyidmjQqJfbJNYbs0IvkYunTEwbdUV+qQMhvWMLQ7CKe35l5pkJ/XDtM/tG2zn+o8CiAedesRQqXHYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmO1vweYc3oNN40/bSx7mo/Gjtm615ax51lZ5EaB/s8=;
 b=ovY8xlIRHmzluMNhFq2j/jzDow0oIv0mNyitVP4E5Y2siHVu7Xi/XDhIwZs1s5a7IGVehEDWgARV7lXvaLIAk7PyehX9YjaqrN8Bj6ZiBNtIYW8hS+AdmNSgk6flk/XWVxRO5tQSLZa7Ab1kmXJ9A+0kRTVf9ZCqmOCuJzy4Fl8=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 22 Sep
 2022 00:18:40 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::48) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:39 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:38 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/31] DC Patches Sept 26, 2022
Date: Wed, 21 Sep 2022 20:17:50 -0400
Message-ID: <20220922001821.320255-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: a7eddd29-0759-4398-ec37-08da9c30000f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UVm2N47tqeuqJAOEGbnB757Rh6AQYjx4XY+8EgUE2tn4bhRJj52F/u4lmHILth3WWcf9Rkc7ktJE8kAv7h4Fxp2xyg2B4yZ7qMi19smqb4SDAvb7R+Lvgy9TZ0A+w0dCANqUx4plIp2N1WRyWQbMCALrsymGDkkxy6VGF6CHAQ5aQAE45MPND+EmLxHFisbBGaUqWdBuo+QO0nlXF7lxbYQ8J5ThFnBVpbWkBFqMUrYL/kG15Aef4DScsRzmWA8KX0m+lO2AI8jbb4SzzA55SlRBlE4cnfmhaelWP/I4DFmKwDUR+Lr+RmHQOA2WkAar1vw1ggkrMC6FiExrGSP9YGt5ZXUDo41/GRYbjur89/UTXSxtqaasCl5q7dNmf/UcT/m2vioKZ+4I6RlX56OZ8Iul7rYi86UIudR8iHYZXcrf121OJ/uMAMamYVNpgbSGVegHHkafYgWBcQHcv6ErxvZxvyESdoP6S/9sjz6bLAn5TZdEPAG5drvKjdLNhKyLJJ9bJZ1lP2fJYoSuBC5mGsuMuzEtuaIYomTuxVMuLGVxdSdiHE/AfPq4uhFbY+4Ox0XCcAA+tGDPZDrcQuChlZM9FrNO+a2nTRTAFadHe9sH/cW1e/cMJKYIpLaJLgvFQn3ThrjNqDV3kp7ZJoqvaHFsYccOYE65I19rDODvajjFml9SWZzCTYcO0qAMgEM9xMSTG/8cj3Jy7QD+xGMLW1R36cbswwwC8CNk3tkVNjybJw0TAflkpu7A6d/JIuVAP7UPj63N63+BhoOyytgdSoKeRgITOAZyY1Zjv/EeXGXN4fGvnlH2JWkUg7jOWcN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(40480700001)(36756003)(2906002)(82310400005)(6916009)(4326008)(16526019)(70586007)(8676002)(82740400003)(36860700001)(47076005)(426003)(5660300002)(70206006)(316002)(8936002)(336012)(2616005)(1076003)(83380400001)(478600001)(356005)(26005)(186003)(81166007)(6666004)(40460700003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:39.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eddd29-0759-4398-ec37-08da9c30000f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
 
    - LTTPR mode can be be dynamically changed
    - features able to use same interface to update cursor info
    - fixes for llvm compilation issues
    - Fixes DIO FIFO underflow and other FIFO errors
    - Partially valid EDIDs handled properly
    - Phatom pipes are skipped when checking pending flip
    - Fixed audio on display after unplugging
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Update DCN32 to use new SR latencies
  drm/amd/display: Update MALL SS NumWays calculation
  drm/amd/display: Disable MALL when TMZ surface
  drm/amd/display: Fix CAB allocation calculation

Aric Cyr (3):
  drm/amd/display: Remove interface for periodic interrupt 1
  drm/amd/display: Fix audio on display after unplugging another
  drm/amd/display: 3.2.205

Aurabindo Pillai (2):
  drm/amd/display: skip phantom pipes when checking for pending flip
  drm/amd/display: fix a divide by zero error

Brandon Syu (1):
  Add debug option for exiting idle optimizations on cursor updates

Charlene Liu (1):
  drm/amd/display: add debug keys for override bios settings.

Dillon Varone (1):
  drm/amd/display: Fix various dynamic ODM transitions on DCN32

Eric Bernstein (1):
  drm/amd/display: Remove assert for odm transition case

Ian Chen (1):
  Add ABM control to panel_config struct.

Ilya Bakoulin (1):
  drm/amd/display: Change EDID fallback condition

Max Tseng (1):
  drm/amd/display: Cursor Info Update refactor

Michael Strauss (1):
  drm/amd/display: Refactor LTTPR mode selection

Nathan Chancellor (2):
  drm/amd/display: Reduce number of arguments of dml314's
    CalculateWatermarksAndDRAMSpeedChangeSupport()
  drm/amd/display: Reduce number of arguments of dml314's
    CalculateFlipSchedule()

Nicholas Kazlauskas (3):
  drm/amd/display: Wrap OTG disable workaround with FIFO control
  drm/amd/display: Add explicit FIFO disable for DP blank
  drm/amd/display: Do DIO FIFO enable after DP video stream enable

Samson Tam (1):
  drm/amd/display: fill in clock values when DPM is not enabled

Taimur Hassan (3):
  drm/amd/display: Avoid avoid unnecessary pixel rate divider
    programming
  drm/amd/display: Fix typo in get_pixel_rate_div
  drm/amd/display: Avoid unnecessary pixel rate divider programming

Tom Rix (3):
  drm/amd/display: remove redundant CalculateTWait's
  drm/amd/display: refactor CalculateWriteBackDelay to use vba_vars_st
    ptr
  drm/amd/display: remove redundant CalculateRemoteSurfaceFlipDelay's

Wenjing Liu (2):
  drm/amd/display: add missing null check
  drm/amd/display: polling vid stream status in hpo dp blank

 .../drm/amd/display/dc/bios/bios_parser2.c    |  21 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  11 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  14 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 127 +++--
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  19 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 301 ++++++-----
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  34 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  35 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   3 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   6 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  47 ++
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  25 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  53 ++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 280 ++++++----
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   8 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +
 .../dc/dml/dcn20/display_mode_vba_20.c        |  98 +---
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 176 +-----
 .../dc/dml/dcn21/display_mode_vba_21.c        | 173 +-----
 .../dc/dml/dcn30/display_mode_vba_30.c        |  92 +---
 .../dc/dml/dcn31/display_mode_vba_31.c        |  89 +--
 .../dc/dml/dcn314/display_mode_vba_314.c      | 509 ++++--------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  70 ++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |  42 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  30 --
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   5 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   9 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 .../amd/display/include/link_service_types.h  |   1 +
 scripts/extract-cert                          | Bin 0 -> 18320 bytes
 47 files changed, 952 insertions(+), 1427 deletions(-)
 create mode 100755 scripts/extract-cert

-- 
2.25.1

