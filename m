Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBCC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A45710E871;
	Fri,  1 Dec 2023 13:28:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4454110E871
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ercqnczaO++JwxeJYcZHVlrDmpBkB7bxSPVEwXLF4Y5C+4f+xYdYRvrX03/ZJpvzoKmLartEWrqA8KZU2XYhSkOhO5AWpb0MerqU8mwjJZTDrWCivgRgyGRo86VLvSJrsSIUOnHKhDOnP4cqNyzNgKb5newq40R6dCSMMOHPsDueuaXJq9a1EODleZZBIMVNOZuge+nItWcGj7npeRKKMjdmaAzO8t8Cyb9cH74kc4Ohx1hKB8nJkchP3aMRcEo/GgS9Z0ltTrIaX2JKUWZ+zneQ15B1FaeY4Xh71Ha3caZyNM6rLB/NiTPjAaUI1oacq6UKYXUzWJIFmIGuIPJB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf0Rmn+VNxPNIx2+AN9yjMh84ZgaED1wfO0NEn+LvkI=;
 b=H7FUmFCAdz4G6Mppc5j6cvCa1r8gaJTzl4zm7WDZaMNx462lOU+4E/eYUaIgg1DY61nqrR2OqmRoyyuTdb2KhOkeYi/MkJYtP92J1QQvkf/txhG6Fo47h8rEb9N9PrsxyOs+bzfHuAie5BIprMmiXZjU9F7i1L93qGm0yCUhghAI8cqIZ5isHMDEpLvvBP61uQe/3TFruPAzWGN8MvjkX307nsNZ9OC7Dkaa+VOQe6m0pFNmNO36DBm79s7upuF73hydecO6M0SMoi8FrLm5yI1/dnNMcLx7T5KtgT0gvEW06rKRGDWgAaESjnMAvjqci3nJ3rDqnH31lvz9wghiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf0Rmn+VNxPNIx2+AN9yjMh84ZgaED1wfO0NEn+LvkI=;
 b=JgxiJfFV8t7A8DaR/khdTLCFm4bUXj+zHNncWdy41m4CVZ7K0/ARaUTQYG3SRg3UZ4HrMBR99PuKyPD0d7iQccFzV1L0P9qQrOxf+Jg0hiTuTvMeeBn6Z+5MYs6BJqQgHUnwbb/yIEc7kbmWNA3yZ8toe9WiK3py5C0QEazGse0=
Received: from CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) by
 CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 13:27:54 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::d4) by CH2PR05CA0001.outlook.office365.com
 (2603:10b6:610::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15 via Frontend
 Transport; Fri, 1 Dec 2023 13:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:27:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:27:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/47] DC Patches December 1, 2023
Date: Fri, 1 Dec 2023 06:24:56 -0700
Message-ID: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4a2704-254a-4f9e-f0e8-08dbf2715337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zE2BeIClvBz+dr3S0I4F7efp9sKtw2GoGp31oynIqHGHF23jl805De84gLEg3WDoaWlReRpCYLBmIAE/KvCGtp/S/SB4Z+ZAY2OQnmKNHYPWb6WhP38JmZBWAV0a+8Y/emwJQcMvEZeaIqwPdysJkjKfGuvpgZGfiHSxMytL055EZV5qZ33/IQRSxuZryDVqpWsnc65SoDVuDRyCq1KnyQ+DHM8E4UwqpPYVw9/vWyryW/HFROHsDf1NgoG6B/GIpEa7+QHRrQJcfoo/UClVhf+IS+aLUtiUl87uhofyMsttCUbTEkOBBXx2LhhVb0AGBtOw0/Z9dPzlwOLWqAbtRnBucYdzxvCDNcQndCHHdLubUZw9mD92sylAINzTahUAWa5pyRyfYg97NQhJ29CE7kgLy6bDr1xMP/+4DiYjnbRcrJPHOBngvSKCDTLaqt9vSU69+SggqcBrwZVPSWWkH4Qj82CdfzOypu75MBNHVarM2EAHb580qBht/zoV9yLxGo3YOjGxJXvBDsTQFQjUkM5yk8YiswKvNPVqEKnkFGnltfEkw2BxxdAc+xDCyrxeZ1bG9iEa6kbGu0Now9X8OHlK9v6yqn4MkNjqiDvqskXMp+C/FAnq81QXi3KTty7F7HV4CZjox+7JyLVRLIlBUq33nYPZWpThv1gFiWyBvlh0tYFaAWSAdClOxf6qZ5+gYG5tSholkmxahKC3wPpYvWEZktcxp2qQW/fLJlAOKLl25pcRw8wsmC9dQpc6MPopPzGLnYYrDneCbjSkFyJOfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(47076005)(40480700001)(2906002)(5660300002)(82740400003)(83380400001)(41300700001)(86362001)(36860700001)(8676002)(40460700003)(16526019)(8936002)(4326008)(1076003)(70586007)(70206006)(26005)(336012)(426003)(356005)(36756003)(316002)(81166007)(478600001)(54906003)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:27:54.3677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4a2704-254a-4f9e-f0e8-08dbf2715337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Enable writeback.
* Add multiple fixes for DML2 and DCN35.
* Introduce small code style adjustments.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira


Alex Hung (12):
  drm/amd/display: Avoid virtual stream encoder if not explicitly
    requested
  drm/amd/display: Initialize writeback connector
  drm/amd/display: Check writeback connectors in
    create_validate_stream_for_sink
  drm/amd/display: Hande writeback request from userspace
  drm/amd/display: Add writeback enable/disable in dc
  drm/amd/display: Fix writeback_info never got updated
  drm/amd/display: Validate hw_points_num before using it
  drm/amd/display: Fix writeback_info is not removed
  drm/amd/display: Add writeback enable field (wb_enabled)
  drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer
  drm/amd/display: Add new set_fc_enable to struct dwbc_funcs
  drm/amd/display: Disable DWB frame capture to emulate oneshot

Alvin Lee (2):
  drm/amd/display: Optimize fast validation cases
  drm/amd/display: Use channel_width = 2 for vram table 3.0

Aric Cyr (1):
  drm/amd/display: 3.2.263

Charlene Liu (4):
  drm/amd/display: initialize all the dpm level's stutter latency
  drm/amd/display: insert drv-pmfw log + rollback to new context
  drm/amd/display: revert removing otg toggle w/a back when no active
    display
  drm/amd/display: keep domain24 power on if eDP not exist

Chris Park (1):
  drm/amd/display: Update BIOS FW info table revision

Daniel Miess (1):
  drm/amd/display: Add missing dcn35 RCO registers

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error IRQ handler

Dillon Varone (1):
  drm/amd/display: Add dml2 copy functions

George Shen (1):
  drm/amd/display: Skip DPIA-specific DP LL automation flag for non-DPIA
    links

Harry Wentland (7):
  drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC
  drm/amd/display: Create one virtual connector in DC
  drm/amd/display: Skip writeback connector when we get
    amdgpu_dm_connector
  drm/amd/display: Return drm_connector from
    find_first_crtc_matching_connector
  drm/amd/display: Use drm_connector in create_stream_for_sink
  drm/amd/display: Create amdgpu_dm_wb_connector
  drm/amd/display: Create fake sink and stream for writeback connector

Ilya Bakoulin (1):
  drm/amd/display: Fix MST PBN/X.Y value calculations

Ivan Lipski (1):
  drm/amd/display: Add monitor patch for specific eDP

Johnson Chen (1):
  drm/amd/display: Fix null pointer

Josip Pavic (1):
  drm/amd/display: Increase scratch buffer size

Krunoslav Kovac (1):
  drm/amd/display: Change dither policy for 10bpc to round

Lewis Huang (1):
  drm/amd/display: Pass pwrseq inst for backlight and ABM

Michael Strauss (1):
  drm/amd/display: Only enumerate top local sink as DP2 output

Nicholas Kazlauskas (1):
  drm/amd/display: Pass debug watermarks through to DCN35 DML2

Nicholas Susanto (1):
  drm/amd/display: Fix disable_otg_wa logic

Relja Vojvodic (2):
  drm/amd/display: Add ODM check during pipe split/merge validation
  drm/amd/display: Added delay to DPM log

Rodrigo Siqueira (2):
  drm/amd/display: Adjust code style
  drm/amd/display: Update code comment to be more accurate

Roman Li (1):
  drm/amd/display: Fix array-index-out-of-bounds in dml2

Wenjing Liu (1):
  drm/amd/display: add support for DTO genarated dscclk

Yihan Zhu (1):
  drm/amd/display: add MPC MCM 1D LUT clock gating programming

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 356 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  22 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 215 +++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  36 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |  76 ++--
 .../drm/amd/display/dc/bios/command_table2.c  |  12 +-
 .../drm/amd/display/dc/bios/command_table2.h  |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  26 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  25 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  43 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  80 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  10 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   8 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   7 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  32 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |  23 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   3 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   3 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  26 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  62 ++-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h |  51 +++
 .../dc/dml/dcn30/display_mode_vba_30.c        |  29 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   3 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  19 +
 .../amd/display/dc/dml2/display_mode_core.c   |   6 +-
 .../display/dc/dml2/dml2_translation_helper.c |   4 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  11 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  29 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   4 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  16 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  36 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   4 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  25 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  22 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   4 +
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  40 +-
 .../drm/amd/display/dc/link/link_factory.c    |  59 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  18 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   5 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn32/dcn32_resource.h        |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  14 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 62 files changed, 1328 insertions(+), 240 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h

-- 
2.42.0

