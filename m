Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFABC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD18D10E1BB;
	Fri, 14 Apr 2023 15:53:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BDB10E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0w9jMfr+0rkGYAuLmvIuJacxmON03SIdoSnq+qOKUmivRd+MljtZNfTOZQ9GMYQITgmLTglC0ysf8BoKvJoXpafsIb4x0GBL0RyGztwibinQkWlBVC6VWU3NmtvKZi0V7bMxMmzca3gEpihfi4RFO55+v0cQkbywmAPulWt1GM0OMw+wDucW8aUVQg2AmCEB+BdlKyYxA1HBZ5/a8YTFUhxCh50Ir2Rnzirg7R39OJQ4MQs9wUgjSQp0ZN+PFKk4rdP7CFdol0D9KGSy6wM8kixVeM9TU1/6uZG0qIBvooaGlZ4gyhsA8BD4EADzeiE4FxYan0otQogoThWQrqF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ooad/jOMz07MAr6s4pS5IlKqkpdTWbdBzLV/15AhRQ=;
 b=SIVU93GxQhHQPGxuyyuuAziUAqen2WVftuiBZAvrkdcR+x7nOWo7kSWxogntbhg6PI66sy3J68hzHOF3TsFjbdgKSPGMVk0eqbM85e8tyl/UPy5UbpMG01jFty6dvPdDYKtyEOsC27dinKQWGcl5A9/sTz6rsQOlpsP/sKaJTjBm8ruJXNC6xh7UTxTOal3QO5RmZP1Ro48YLhMb2YjjmfIoipc5ZqZ4siV92KCgb7GbV1XvizeuSLIHhUm9GsJvcjFC8w4zJ59iWvX7+Lq9G17OCOk22HIvvZooumWCYveL1fmM+Lr20cyHQw5dTnT2bS7Bop9c7t36vSfMb/v4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ooad/jOMz07MAr6s4pS5IlKqkpdTWbdBzLV/15AhRQ=;
 b=zBbkdHi0GyjHnnukj9bTIn6mBTRmsZWJQphSW+tKe42z37szNOnn3KU5WtjWYP3YLCjxcKF77QXxuyDLGhc1d9Dqelznw5moX6RegAMiBKoVIjC1HbdgeqWO7sWD/LOKmrHwl2oYYrJq41x8bLvtM1GzzPR9u4t+L0Z+pk5bAMI=
Received: from DM6PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:100::33)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:53:46 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::d0) by DM6PR03CA0056.outlook.office365.com
 (2603:10b6:5:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:53:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:44 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/66] DC Patches Apr 17th, 2023
Date: Fri, 14 Apr 2023 11:52:24 -0400
Message-ID: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6d7e75-44c1-419d-3ac8-08db3d006e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLEFBCjUN6Hi0T+JQVnUb/SV/RfmcYE1oDxcG54yKDGOiBlmF1jNpVyw5L4Y/lfj/FPEMVvFbXZuN/ICDnw4H5Jei7Dtb1DXOUmbTIzdE9ed3itVVOmrMmxymSx6usdMhxWgzwdMjGVcI5N/Agnj6LIfMqYwoFLrh3VmUl0PAcvla/3go9sm6p1cdvv3Fatr7sye3dOmYYvL8nk4sP+C+SlqXOlbzaVcRUOe77QvTG24BEX2idj6+ORm1o1pbgkyBiz/aEFTFOxt1Ai2tyaJLGZpmLZpCscG2/DNADbdl+yoqvhV7bttyL30d9rlpyUBobGg+Co0rtww5bvN/echaf/zxTVkmdfjfzUH4ffmQFOE97zMRlTBfu99SSsx+Nb0/k9cv2z/sXvq4GLHqZfqDVCngvSOFeE24xkOGna4UiqWB4qW5owajlZQAkCb6UMpt/S+1LM/VOnWzp8kO0MvDSL9l1QY87VdPIki458Y+gqJgc0v36A/0kdfkhk+Z9UC3AtqkFEQKEYWm1Z4i6rVFFlber1cwC+DzkrmWA5prS5IrJsUDcKt05UXKfOCu3gQSU+3AHrMvUF+/UVjQFN8re+BCRDauJC0aSqmPTCqaHcr+ULc5KCxHmtmridnt4FmmVHRCAlVXagDQwmLFXT7nf63FFwXgaNb48dU2LORZRKiOMwtwU5umMW8HBaQJ5ejUgJrtTqXEUy8MeqznrL1eFDXyfbA3pYVWI+I4TLeqJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(40460700003)(36756003)(40480700001)(478600001)(36860700001)(6916009)(4326008)(8676002)(70206006)(70586007)(41300700001)(316002)(54906003)(426003)(336012)(47076005)(83380400001)(2616005)(6666004)(186003)(16526019)(1076003)(26005)(86362001)(5660300002)(81166007)(82740400003)(8936002)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:46.3108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6d7e75-44c1-419d-3ac8-08db3d006e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- FW Release 0.0.162.0
- Enable FPO+Vactivate
- Support for VESA SCR on OLED
- Refactor DMUB commands
- Fixes in secure display, modeset, memleak and more
- Picked up missed patches in history

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (1):
  drm/amd/display: Fix in disabling secure display

Alex Hung (2):
  drm/amd/display: allow edp updates for virtual signal
  drm/amd/display: fix a divided-by-zero error

Alvin Lee (5):
  drm/amd/display: Only consider DISPCLK when using optimized boot path
  drm/amd/display: Reduce SubVP + DRR stretch margin
  drm/amd/display: Set watermarks set D equal to A
  drm/amd/display: Enable FPO + Vactive
  drm/amd/display: Update DTBCLK for DCN32

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.162.0

Aric Cyr (1):
  drm/amd/display: 3.2.231

Aurabindo Pillai (13):
  drm/amd/display: Fix hang when skipping modeset
  drm/amd/display: remove incorrect early return
  drm/amd/display: Fixes for dcn32_clk_mgr implementation
  drm/amd/display: Do not clear GPINT register when releasing DMUB from
    reset
  drm/amd/display: Update bounding box values for DCN321
  drm/amd/display: add support for low bpc
  drm/amd/display: Set DRAM clock if retraining is required
  drm/amd/display: Add check for PState change in DCN32
  drm/amd/display: Remove DET check from DCN32
  drm/amd/display: Add extra check for 444 16 format
  drm/amd/display: Add FAMS capability to DCN31
  drm/amd/display: Add FAMS related definitions and documenation for
    enum fields
  drm/amd/display: remove some unused variables

Cruise Hung (1):
  drm/amd/display: Reset OUTBOX0 r/w pointer on DMUB reset

Daniel Miess (1):
  drm/amd/display: limit timing for single dimm memory

Dmytro Laktyushkin (4):
  drm/amd/display: update max streams per surface
  drm/amd/display: add extra dc odm debug options
  drm/amd/display: set dcn315 lb bpp to 48
  drm/amd/display: Limit nv21 dst_y

Eric Yang (1):
  drm/amd/display: add mechanism to skip DCN init

Hersen Wu (2):
  drm/amd/display: fix memleak in aconnector->timing_requested
  drm/amd/display: fix access hdcp_workqueue assert

Igor Kravchenko (1):
  drm/amd/display: Set min_width and min_height capability for DCN30

Iswara Nagulendran (1):
  drm/amd/display: Adding support for VESA SCR

Jasdeep Dhillon (1):
  drm/amd/display: Isolate remaining FPU code in DCN32

Jingwen Zhu (1):
  drm/amd/display: Improvement for handling edp link training fails

Josip Pavic (3):
  drm/amd/display: copy dmub caps to dc on dcn31
  drm/amd/display: refactor dmub commands into single function
  drm/amd/display: drain dmub inbox if queue is full

Krunoslav Kovac (1):
  drm/amd/display: 3-plane MPO enablement for DCN321

Leon Huang (2):
  drm/amd/display: Refactor ABM feature
  drm/amd/display: Fix ABM pipe/backlight issues when change backlight

Meenakshikumar Somasundaram (1):
  drm/amd/display: Adjust dmub outbox notification enable

Michael Mityushkin (2):
  drm/amd/display: Correct output color space during HW reinitialize
  drm/amd/display: Apply correct panel mode when reinitializing hardware

Mikita Lipski (1):
  drm/amd/display: Write TEST_EDID_CHECKSUM_WRITE for EDID tests

Nasir Osman (1):
  drm/amd/display: DSC policy override when ODM combine is forced

Nicholas Kazlauskas (1):
  drm/amd/display: Explicitly specify update type per plane info change

Po-Ting Chen (1):
  drm/amd/display: update GSP1 generic info packet for PSRSU

Rodrigo Siqueira (9):
  drm/amd/display: Update bouding box values for DCN32
  drm/amd/display: Add missing mclk update
  drm/amd/display: Adjust code identation and other minor details
  drm/amd/display: Set maximum VStartup if is DCN201
  drm/amd/display: Set dp_rate to dm_dp_rate_na by default
  drm/amd/display: Remove wrong assignment of DP link rate
  drm/amd/display: Use pointer in the memcpy
  drm/amd/display: Add missing WA and MCLK validation
  drm/amd/display: Add FAMS validation before trying to use it

Samson Tam (1):
  drm/amd/display: Clear GPINT1 before taking DMCUB out of reset

Sherry Wang (1):
  drm/amd/display: correct DML calc error

Tianci Yin (1):
  drm/amd/display: Disable migration to ensure consistency of per-CPU
    variable

Wesley Chalmers (3):
  drm/amd/display: Do not set drr on pipe commit
  drm/amd/display: Block optimize on consecutive FAMS enables
  drm/amd/display: Add logging for display MALL refresh setting

Zhongwei (1):
  drm/amd/display: fix dpms_off issue when disabling bios mode

hersen wu (1):
  drm/amd/display: Return error code on DSC atomic check failure

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  33 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  31 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  31 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |   2 +
 .../drm/amd/display/dc/bios/command_table2.c  |  25 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   3 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   4 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   4 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   4 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  32 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  37 +--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 201 +++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  15 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  28 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 264 +++++++----------
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 272 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  46 +++
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  28 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  19 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  13 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   7 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  68 +++--
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  41 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   7 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   4 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   8 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |   4 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   4 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  20 ++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  19 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  48 ++--
 .../amd/display/dc/dcn321/dcn321_resource.c   |   8 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   7 +
 .../drm/amd/display/dc/dm_services_types.h    |   6 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 178 ++++++------
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  18 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |   6 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   4 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   4 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  22 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   1 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  20 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  24 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   5 +
 .../dc/link/protocols/link_dp_capability.c    |  11 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link/protocols/link_edp_panel_control.c   |  30 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  28 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |   6 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |   4 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  25 +-
 .../drm/amd/display/include/signal_types.h    |   1 +
 .../amd/display/modules/power/power_helpers.c |   4 +
 include/drm/display/drm_dp.h                  |   3 +
 78 files changed, 1149 insertions(+), 726 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h

-- 
2.34.1

