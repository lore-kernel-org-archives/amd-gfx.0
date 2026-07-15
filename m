Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701FBC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF52510E1D8;
	Wed, 15 Jul 2026 13:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HvYmG2WA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8CA10E1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOyxHvyfvH21W7cZuqUPeMUZPvsmpuLb2+7jgsLZMsi9VffABWKr92PajWJPy3G20DThtnWRh4w/4j9Wd+6zE+VLGRYrfv6m/o9+ZiP2MVk/3OXL8jhI+bvaM2aEnVFYK5RpZK0kr1JchRgv2fPpDMuAl0CtPMWL/ETQgthLvce0aTHGv+al9BEZtlCHpPE3Tblemiap/fFElmZPEYolaZr5BSvWSVJevDvC2IhqbM1CH1LJChq5XIfCJ4MZKi4ivvFAaYmgcrTpxUy1C2t+aVmIfAMWwRy21xVqkcoDCqgHEj1xioshKQT57Ro4Xni5Z5OzFvLJXONaBBupdyrkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvSE+30mTe65ewe66OgX9519bkbOAvogooSLL7w8bVY=;
 b=PPRemABsGBOMuBHmJ532SIet6RwR+fz2T0NoGvLB5EC7nkAV5cQ0+GHE+8Zy0W+6q5uXCNiWMoRtik5xwr5XmgjKR7yZuqP5v9aT247lwLfJWYRSA6+QoSFE6BkNL1J9vI+dds+VIferHs6XTPyxtEmQUahZSYDOJHJcL7BchXEwVCqS2EHFo/koQOLwGe18w6+PCZa+Uem6lc/Erwe82SdBmoTOeyl5E9LROh4Us3ImkAxhVE4rta17KH5FVpwLRUh6WnjNbn7hXfykyTfRA00BnHGG4JkLndmzi+ThSBOTf6hUKCeAf73XY8URZCkXh8w1usIPhjQl3Y9I2Njdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvSE+30mTe65ewe66OgX9519bkbOAvogooSLL7w8bVY=;
 b=HvYmG2WAi5Up3Aek4532jfJIgylMhCM1Y0xMBxnqQarTVjJj55i8UKNl1mev5GV7Zg+CVL6BzUxa4gqDLZSB0Ki1K9irF/WjWeNvrO42DEJW1oczJhC6156AEeMH5nmhC0+uMjB4e2XEG1Hsuamgt9n8VP9FVrwcJ0kByyl15l0=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by SAWPR12MB999315.namprd12.prod.outlook.com (2603:10b6:806:560::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:44:34 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:44:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:44:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:44:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/70] DC Patches July 13, 2026
Date: Wed, 15 Jul 2026 21:37:10 +0800
Message-ID: <20260715134432.1975118-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SAWPR12MB999315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac7261f-b451-4aed-ec28-08dee2773429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|3023799007|11063799006|56012099006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +LtzrSFf/D3deWm2NQx4okr8LvPe4R8NQsb4Qyz7PMgXwhAwBnOou2+YWXpD8yNEUcw9G5vWZ+sJXWzuKJsHM0Xui9edkT+47jDSLpi+4GhADHBWLyC9zlvf96tR4KYHR2P+X1fmWhuHjmCK3i0eAXrMMHoWc+pHBn4JKK41CjTfjg6FR79b32V7XwdfRyKfoBuunORjrErQRMEa+9LrP5S2r9P4p8u5nDFtnqhabHPo99EmMjGKBBl5sBV/yaFWMOlQdKDICZz57NUc7FKELbQOHzeNhj7dP1aeB2FJh8xbMFmk35/XkToQKaLlBif0z7rHuuMV/3lRVQtpQAO0F1CQLVhdZB0oVgXoTWdmwrUT0UkiZBemqDs2qeGVzH9PBiKgPJi8lWOQ2Ojuk/80KATYl+W0rSY6rwzyI6xcfwKLrUmTgLq/IlvRavCKMfX3RPO9dXaRtW1RxYeZDnJcR77pSbjSI1xsqikLJqzpRGx+VqzE8xStZuOM/zkZBEm9WBiQ7w/PMsdgfElI4jIr+3nCp2pTWbzcPMJ61YJlKcBqwavn8A8NrQzqqM6lvTyT47Z4/qCisleJS+xHcts3U7T0FU6qEw4BNBcfxVoYO36P/pop26tGbabPQYs/oTyb38m6Yq9OUsDzljjvbf51Hdcp/Re+5Q25n2DttW7RfWQJSsHYwGzgJdgZ3QLgX/rSaL15lP+5j3XKerDos1eKpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aSP4d9slB2Xa5/V8qpd3Mz37obfNOrgBzxfw0CvhOze7jw1Rs+lIJ6QGkdS4j4Y5AaxOcPVS8AWwDdhHyck2zLB3fcRCgl1oqOlzs28XokWtM6a/5/W+9hWf416RROSDacyAfJ4FWhP0VDhyvwR8njhHA2s/gc59TP9Fh0Ha8y0sGWJbhDqSFV5y+6/Goj7FFd61VuDHHUhkSuzw5VKxSmfvDm0wH5xMIVh62EntJNRXfqjuIbuWRMz9F9jn+GGTY8Vvh2BOC3hxVZDPDEdavP94rUKVPANUJkWS+xlaytI3HKN+RxZi/rN2RvQ9MDKQsSuy2Or5pv4uBpnF3yb0ApbkR3/GUZg7UazWvuRQywEuWr8K1bjXKHL+Af5/VZDALIqoYaZQ5wq200+d48Y139f/IOMRaaTAVEfjpngrXtMMmgW0Qjbk9S+EPWdai1Kl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:44:33.5912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac7261f-b451-4aed-ec28-08dee2773429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999315
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Unified dc_update_state commit interface with dc_probe model,
  dc_state_get_status, and perfmon BLS sequence
* DCN42 enhancements including mcache programming, PMFW DF C-state client,
  and DCCG clocking fix
* DML2.1 writeback validation plus MCIF ARB and watermark/latency updates
* Color management refactor to dc_plane_cm with plane/CRTC colorop test coverage
* Greatly enhanced KUnit coverage across amdgpu_dm, connector, CRC, DMUB, and
  color management
* HDMI AV mute timing, DP link training logging, and Apple Studio Display fixes
* Code cleanup including DCE trim from DCN-only builds and HWSS refactors
* SPL UPSP upsampling and YUV422/YUV444 scaling support
* Fix missing dc_3dlut forward declaration in color management KUnit headers
* Fix DM IRQ schedule-work KUnit tests after cancel_work_sync teardown change

---
Alex Hung (26):
  drm/amd/display: add dm_dmub_hw_init KUnit coverage
  drm/amd/display: add dm_dmub_hw_resume KUnit coverage
  drm/amd/display: add fused IO KUnit coverage
  drm/amd/display: add DMUB command sync KUnit coverage
  drm/amd/display: add VBIOS bounding box KUnit test
  drm/amd/display: Test color mod init and 3D LUT size
  drm/amd/display: Test plane colorop helper walkers
  drm/amd/display: Test CRTC color management update
  drm/amd/display: Test plane color management update
  drm/amd/display: Test plane colorop pipeline update
  drm/amd/display: add KUnit tests for DM IP-block callbacks
  drm/amd/display: add KUnit tests for DM CRTC vblank/scanout
  drm/amd/display: add KUnit tests for DM atomic state helpers
  drm/amd/display: add KUnit tests for DM stream scaling
  drm/amd/display: add KUnit tests for HDCP state diffing
  drm/amd/display: add KUnit tests for freesync config
  drm/amd/display: add KUnit tests for per-frame master sync
  drm/amd/display: add KUnit tests for stutter quirk
  drm/amd/display: add KUnit tests for DPCD poweroff delay
  drm/amd/display: add CRC source list KUnit coverage
  drm/amd/display: add CRC source verify KUnit coverage
  drm/amd/display: add CRC configure KUnit coverage
  drm/amd/display: add CRC set-source KUnit coverage
  drm/amd/display: add CRC IRQ handler KUnit coverage
  drm/amd/display: Fix missing dc_3dlut forward declaration
  drm/amd/display: Flush IRQ workqueue in schedule-work tests

Aurabindo Pillai (2):
  drm/amd/display: Adjust the structure dml2_dchub_watermark_regs
  drm/amd/display: Adjust structure dml2_display_dlg_regs

Austin Zheng (1):
  drm/amd/display: Add Writeback Watermarks and Latency Fields

Bhawanpreet Lakha (11):
  drm/amd/display: Replace amdgpu_dm_kunit_helpers.h with dm_helpers.h
  drm/amd/display: Add stream creation tests for connector
  drm/amd/display: Add detect and poll tests for connector
  drm/amd/display: Add register and unregister tests for connector
  drm/amd/display: Add destroy tests for connector
  drm/amd/display: Add encoder helper tests for connector
  drm/amd/display: Add EDID management tests for connector
  drm/amd/display: Add mode helper tests for connector
  drm/amd/display: Add i2c and EDID parsing tests for connector
  drm/amd/display: Add mode validation and CEC tests for connector
  drm/amd/display: Add stream validation tests for connector

Clara Wong (1):
  drm/amd/display: Reduce DML reinitialization when params don't change

Dillon Varone (4):
  drm/amd/display: Correct pipe usage for populating stream config
  drm/amd/display: Add MCIF ARB programming structures
  drm/amd/display: Add updated MCIF ARB register definitions
  drm/amd/display: Add DWB validation support to DML2.1 wrapper

Dominik Kaszewski (1):
  drm/amd/display: Split DPMS ON into parts

Dyllan Kobal (1):
  drm/amd/display: fix wrong register field in
    dccg35_set_hdmistreamclk_src_new

Gaghik Khachatrian (1):
  drm/amd/display: Trim DCE from DCN-only builds

Gleb Markov (1):
  drm/amd/display: Remove unused-but-set variable hubp from

Ilya Bakoulin (1):
  drm/amd/display: Fix DP LT failure logging

Jerry Zuo (1):
  drm/amd/display: hide Apple Studio Display secondary tile

Justin Chen (1):
  drm/amd/display: Revert Fix DMSS not triggering for HDR to SDR
    transition

Leo Chen (1):
  drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42

Matthew Stewart (1):
  drm/amd/display: Add DCHUBBUB_HW_DEBUG offset/mask

Pengpeng Hou (1):
  drm/amd/display: wire DCN42B mcache programming callback

Ray Wu (1):
  drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames

Robin Chen (1):
  drm/amd/display: fix debug flags assignment in dmub_replay.c

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.390

Tomasz Siemek (3):
  drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN4_2 from 3dlut code
  drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to drop pipe_ctx
    param
  drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop
    pipe_ctx

Wayne Lin (1):
  drm/amd/display: Add SPL UPSP upsampling and YUV422 scaling support

WenTao Liang (1):
  drm/amd/display: set new_stream to NULL after release

Wenjing Liu (7):
  drm/amd/display: Introduce dc_probe public object model
  drm/amd/display: Introduce dc_update_state unified commit interface
  drm/amd/display: Refactor dc_validation_set array into single root
    struct
  drm/amd/display: Introduce dc_state_get_status unified status accessor
  drm/amd/display: Introduce program_perfmon hwss hook and BLS perfmon
    sequence
  drm/amd/display: Wire probe commit path into dc_update_state
  drm/amd/display: Make dc_state_update const in commit path

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   85 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   33 +
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  117 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   45 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |    9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |    2 +-
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |   20 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  799 +++++++
 .../tests/amdgpu_dm_connector_test.c          | 1541 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      |  728 ++++++
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  837 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   31 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 1220 ++++++++++
 .../display/dc/bios/bios_parser_interface.c   |    2 +
 .../display/dc/bios/command_table_helper.c    |    2 +
 .../display/dc/bios/command_table_helper.h    |    2 +
 .../display/dc/bios/command_table_helper2.c   |    2 +
 .../display/dc/bios/command_table_helper2.h   |    4 +-
 .../dc/bios/command_table_helper_struct.h     |    2 +
 .../dc/bios/dcn10/command_table_helper2_dcn.c |  293 +++
 .../dc/bios/dcn10/command_table_helper2_dcn.h |   34 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    4 +
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  203 ++
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |   43 +
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |    9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |    6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |    6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    6 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |    8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |    8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   18 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   42 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |    1 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  |   29 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.h  |    2 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  471 ++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  424 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  176 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |    3 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   72 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   24 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  217 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   97 +
 drivers/gpu/drm/amd/display/dc/dc_state.h     |    7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    9 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   11 +
 .../dml2_0/dml21/dml21_translation_helper.c   |   84 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   17 +
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |    5 +
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |   27 +-
 .../dml21/inc/dml_top_dchub_registers.h       |   30 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    5 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   34 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   71 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |    2 +
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   21 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |    4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |    4 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |    7 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   32 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |    3 +
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 1989 ++++++++++++++++-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   71 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   44 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   22 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   42 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   44 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   36 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   71 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    6 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   21 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   31 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    7 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   32 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   72 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   34 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   17 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   34 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  214 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    6 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   53 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   18 +-
 .../gpu/drm/amd/display/dc/inc/hw/mcif_wb.h   |   24 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   31 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |    9 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  184 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    4 +-
 .../dc/link/protocols/link_dp_training.c      |   28 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   10 +
 .../dc/resource/dce100/dce100_resource.h      |    1 -
 .../dc/resource/dce112/dce112_resource.h      |    7 -
 .../dc/resource/dcn10/dcn10_resource.c        |    2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |    2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |    2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |    2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |    2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |    2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  202 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   58 +-
 .../amd/display/include/link_service_types.h  |    6 +-
 .../drm/amd/display/modules/power/power_psr.c |    7 -
 .../amd/display/modules/power/power_replay.c  |    7 -
 163 files changed, 10920 insertions(+), 1087 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table_helper2_dcn.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_probe.h

-- 
2.43.0

