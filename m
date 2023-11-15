Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB0BC5AD4C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A521710E16E;
	Wed, 15 Nov 2023 19:44:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C2E10E16E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvThnGeAApEL/+LIgAiKirXn/u3W2pl0mR3HQ0PcIaFjOWpzzsddPLpBKNuHW07zDTSoazmUMNlsFuwj4Kg1+tvQODszUgEXUDI2ox2hiiLo/4GNSr7NNtPzHWA48MP4Q9rQq+gA0/DUwAahHRIaGfoQPeaRC+QK0WznLGI3C4h58xtR0Zq1F4cf78xzq4BpgeuSx+p4mBMkYLC80bObKbx+hOIhaoVHp18IgMySds1yB1TwavsRNLmwQHmFmMfnvTEZf9ZI4Z8R1d4jx6V5m+JG6wX9YhOhdmD4pr3GaGeuj/CUiQ527nyNMhftWy1f7klzWzSpH0fR4VE/6AYuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btIDGr/sessn4BOYJu92krY0OyNp/eMKwrGkGQjDHIc=;
 b=Xavhvc6feQxPEtgY8fvSpftliKJJQySldpCpJG/clHFgP2e2L9gtR5vI0ToXiPrE5BS5ZEmRTtWL4HTt+o0TjaNrCRqFMPU7Fz9NNO17LpbUX55fwv6uBJrCoYx+uRmYlcxEe5zaDTNDVuSzgaeVAkGXLKMCqY97E0doszSqIsAbkM4jebW6KaNZ+0H7W9qUa0oHFwC5YTowq7zzjnskc9ryDWez9fQ3pifSSf/358UHTfWiTqAHsr27K2LdadpBi7kofb9xctPUtNLGYzF0lxs+xOtNfMnEHS8Amw20jX2ZdQVqhktz1WZkIuTi/Jews5xyxn1QiFwJrnRZ0tgkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btIDGr/sessn4BOYJu92krY0OyNp/eMKwrGkGQjDHIc=;
 b=lpeD7AhQ52MWnHT3ewWR1Oydy1+aHCFK6tqevcyyhk5r9skTrVYM0XiVHOMAZz2KxCoD4DbhjKXu+NCrFXxABgEt2vKXRdMjVMMDjHKTTH1VusSgrXhAXSMwzNmo2dItfa8GUMLhmywUSX4OH45v6McsXlywuERFaH6E5F0Yeyw=
Received: from BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) by BL1PR12MB5780.namprd12.prod.outlook.com
 (2603:10b6:208:393::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:02 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::b8) by BL0PR1501CA0036.outlook.office365.com
 (2603:10b6:207:17::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:02 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:01 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/35] DC Patches November 15, 2023
Date: Wed, 15 Nov 2023 14:40:13 -0500
Message-ID: <20231115194332.39469-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b6be7f-c61e-4765-2ae3-08dbe6133846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpGOYovK4Ury7+uWLthqA8AkKySRZwDUZ1aCYRknFuLTqUbtKCo9wtcka4fd42gsLLAtr167LdC23EMo01xc5tdagN6N2pafGBaduDnGQOIr1tk3tC9d0nVMHWDi1bVN4FFceYUy3SRkiymjCZsTkDSlPWhzMmdSCldF2YvNu/IfwgQ3IioiJN2x/4g1PerYizXXmJ1zPzTyu0vCEe4Gl6N9YU2sKLBwsu7V9KlenhK0DKPCIAmFnz5n4XoZ3sLMA437YZWrWgaOkyNQ2tzE6AXU4C+B4Td5jKpRv7S3v8+dCUP+tny7bcjLOd7DOYaHal5mRI7cJCn8vKIAwbeFQtQFqx4aD7/JfTqJD7BgaMt2lTg1JA3Wuc0hLCq92yYORTp/tjSSIJkgZXzlyAJ+OEMb87wkzNgFltTx09CIzdCMbEvPoGHgSpFN0Iw6Kp0mkacaA53rMA3P40wlzfdsgSFRDwaHgN0LmRqFgM/tk/NiMVDgZ/km1EIHUTja3/gaGSV7LeC4a249NA5EEi7JVVxCOXrqFL09vucfRS293pN0OfzD//X2fDFKer+MQR61nCntkl+1mSpHG0LJT3uS/IgXu7h/v1d78wnmn//6RbW9xXh7cq9kyX8qT2Y5n/YF8gxF1YuK7GlYG9l3n9Spong5nlLF/O5VCvkihFi3sudhzoMnvvrLbCySXePlZfPeq0VstPFSG+rivyV02faS/cFZrUTwUSRqlL+hKplA91ASx8OtAYnMnc72YX6t1TWZa2f6G107uJ3rYadP7DmpZRdqbKYGzZGXKARjGUZIoG2wEu5PC+UDwFXrD4Uu7Da4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(83380400001)(36860700001)(54906003)(8936002)(8676002)(4326008)(70586007)(70206006)(336012)(426003)(36756003)(41300700001)(47076005)(1076003)(16526019)(26005)(2616005)(6666004)(478600001)(66899024)(2906002)(40460700003)(44832011)(82740400003)(6916009)(316002)(5660300002)(86362001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:02.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b6be7f-c61e-4765-2ae3-08dbe6133846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DCN314 fixes
* DCN32 fixes
* DCN35 fixes
* DML2 fixes
* eDP fixes
* HDR fixes
* MST fixes
* Replay fixes
* SubVP support for more configs

Alvin Lee (5):
  drm/amd/display: Include udelay when waiting for INBOX0 ACK
  drm/amd/display: Use DRAM speed from validation for dummy p-state
  drm/amd/display: Increase num voltage states to 40
  drm/amd/display: Enable SubVP on 1080p60 displays
  drm/amd/display: If P-State is supported try SubVP for smaller vlevel

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.193.0

Aric Cyr (1):
  drm/amd/display: 3.2.261

Bhuvana Chandra Pinninti (1):
  drm/amd/display: Refactor DSC into component folder

Camille Cho (1):
  drm/amd/display: Simplify brightness initialization

Dennis Chan (2):
  drm/amd/display: Add new Replay command and Disabled Replay Timing
    Reysnc
  drm/amd/display: Disable Timing sync check in Full-Screen Video Case

Gabe Teeger (1):
  Revert "drm/amd/display: Enable CM low mem power optimization"

Ian Chen (1):
  drm/amd/display: add skip_implict_edp_power_control flag for dce110

Ilya Bakoulin (1):
  drm/amd/display: Fix MPCC 1DLUT programming

Max Tseng (2):
  drm/amd/display: replay: generalize the send command function usage
  drm/amd/display: replay: Augment Frameupdate Command

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix tiled display misalignment

Michael Strauss (1):
  drm/amd/display: Do not read DPREFCLK spread info from LUT on DCN35

Nicholas Kazlauskas (7):
  drm/amd/display: Add z-state support policy for dcn35
  drm/amd/display: Update DCN35 watermarks
  drm/amd/display: Add Z8 watermarks for DML2 bbox overrides
  drm/amd/display: Feed SR and Z8 watermarks into DML2 for DCN35
  drm/amd/display: Remove min_dst_y_next_start check for Z8
  drm/amd/display: Update min Z8 residency time to 2100 for DCN314
  drm/amd/display: Update DCN35 clock table policy

Parandhaman K (1):
  drm/amd/display: Refactor OPTC into component folder

Sung Joon Kim (1):
  drm/amd/display: Fix black screen on video playback with embedded
    panel

Taimur Hassan (3):
  drm/amd/display: Remove config update
  drm/amd/display: Fix conversions between bytes and KB
  drm/amd/display: Fix some HostVM parameters in DML

Wayne Lin (1):
  drm/amd/display: adjust flow for deallocation mst payload

Wenjing Liu (3):
  drm/amd/display: fix a pipe mapping error in dcn32_fpu
  drm/amd/display: update pixel clock params after stream slice count
    change in context
  drm/amd/display: always use mpc factor of 2 for stereo timings

Zhongwei (1):
  drm/amd/display: force toggle rate wa for first link training for a
    retimer

 drivers/gpu/drm/amd/display/Makefile          |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 ---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  53 ++++---
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 132 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  82 ++++++++---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   4 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   6 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  13 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  32 ++++-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  10 ++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  12 +-
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  15 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  78 ++++++-----
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  82 ++++++++++-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |   2 +
 .../amd/display/dc/dml2/display_mode_core.c   |  18 +--
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  26 ++--
 .../display/dc/dml2/dml2_translation_helper.c |  60 +++++---
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   2 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  26 ++++
 .../display/dc/{ => dsc}/dcn20/dcn20_dsc.c    |   0
 .../display/dc/{ => dsc}/dcn20/dcn20_dsc.h    |   0
 .../display/dc/{ => dsc}/dcn35/dcn35_dsc.c    |   0
 .../display/dc/{ => dsc}/dcn35/dcn35_dsc.h    |   0
 .../drm/amd/display/dc/{inc/hw => dsc}/dsc.h  |   0
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 108 ++------------
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  46 ++++--
 .../link/protocols/link_edp_panel_control.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/optc/Makefile  | 108 ++++++++++++++
 .../display/dc/{ => optc}/dcn10/dcn10_optc.c  |   0
 .../display/dc/{ => optc}/dcn10/dcn10_optc.h  |   0
 .../display/dc/{ => optc}/dcn20/dcn20_optc.c  |   0
 .../display/dc/{ => optc}/dcn20/dcn20_optc.h  |   2 +-
 .../dc/{ => optc}/dcn201/dcn201_optc.c        |   0
 .../dc/{ => optc}/dcn201/dcn201_optc.h        |   0
 .../display/dc/{ => optc}/dcn30/dcn30_optc.c  |   0
 .../display/dc/{ => optc}/dcn30/dcn30_optc.h  |   0
 .../dc/{ => optc}/dcn301/dcn301_optc.c        |   0
 .../dc/{ => optc}/dcn301/dcn301_optc.h        |   0
 .../display/dc/{ => optc}/dcn31/dcn31_optc.c  |   0
 .../display/dc/{ => optc}/dcn31/dcn31_optc.h  |   0
 .../dc/{ => optc}/dcn314/dcn314_optc.c        |   0
 .../dc/{ => optc}/dcn314/dcn314_optc.h        |   0
 .../display/dc/{ => optc}/dcn32/dcn32_optc.c  |   0
 .../display/dc/{ => optc}/dcn32/dcn32_optc.h  |   0
 .../display/dc/{ => optc}/dcn35/dcn35_optc.c  |   0
 .../display/dc/{ => optc}/dcn35/dcn35_optc.h  |   0
 .../dc/resource/dcn20/dcn20_resource.c        |  16 ++-
 .../dc/resource/dcn20/dcn20_resource.h        |   1 +
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn32/dcn32_resource.h        |  10 ++
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  11 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  80 ++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 79 files changed, 742 insertions(+), 391 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn20/dcn20_dsc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn20/dcn20_dsc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn35/dcn35_dsc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dsc}/dcn35/dcn35_dsc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{inc/hw => dsc}/dsc.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn10/dcn10_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn10/dcn10_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn20/dcn20_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn20/dcn20_optc.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn201/dcn201_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn201/dcn201_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn30/dcn30_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn30/dcn30_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn301/dcn301_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn301/dcn301_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn31/dcn31_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn31/dcn31_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn314/dcn314_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn314/dcn314_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn32/dcn32_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn32/dcn32_optc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn35/dcn35_optc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => optc}/dcn35/dcn35_optc.h (100%)

-- 
2.42.0

