Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05C4C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4532A10EC69;
	Tue, 18 Aug 2026 20:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ecYpEiBJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259E010EC69
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icpmm0TGmd0iI0Nm0mj2U0+LhKi4qKdXTvvhq1A3ntBzDqDkjt+c549xWUG4YgzDbC9sW8KZ0/yPjRUw0wjZ5bdlUGCxYGiU4nYIZ6f9anc9NDr7NBaTTsock4ngpsmq9qD+Fg4OFOb/a3Iv4BPIspS7GWI+HhHl6fxXTmC31Go1pqF+mp1LTAY9AY+2QeIaEhP6gsCGPilfYyCM0wjPK+KfLiHOA5YDWqYtcPxFNYAboK3pI3Mgp6kXV++IUmudcbMEb+mvs2k3Fy+sC9zjuz64bbyhnRuX44TTnr1lp0lyr64t/2+e1BoTPG1z+frgsnfstkq3Mak8vZenpwtY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrU68ALU6Y0ig+YSoPdgPh2rVjpdCHXboe1GnsQp+Ds=;
 b=JhdNX/7G46E6zQ6bj8LkqAcDWu+CSR8JsUWGY65UcMW83vOKVvUgWpEuh4N0pL7g0slYQPbL4aVpMnLX5cjjKGd+MCE/Pb504eBrN6v1u1HdplD8aucUgQPWNLxUfg1DIVXQycm6ytLsVxvd70vq47F9IlKC4EVnEDDx4lGbQPEcqQ17FrLJPWUDJeQlKTVMfKNQpS0HWQfTKE2bzogRDC8iYBnt4LhOLtNlQVmDFQOwXTwlqKBcjIi2cKWBhB36lnmdTkBCFBNlCGEpYno3u5hQbCYjbvoSiy7LzVQDcrMefNPtHhfh3EcfVQpGgC+McmpSUPeelPEVlt9/avxNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrU68ALU6Y0ig+YSoPdgPh2rVjpdCHXboe1GnsQp+Ds=;
 b=ecYpEiBJkAEdcQLbeqYS15i2h69xHgvPBnrhtWGuvLfyTFat7R7AKA+z9NgiGLWhefNq71ceYx0e8UkhM91x7TpLMBJD62jqS7Co6U+qfxZz5LT7Mmb8t6gYaqHAQGGt0YR6/hKDUcIYcYaK6fd+rxpiLKU/rPVgR1agzwC9iZo=
Received: from BN9PR03CA0156.namprd03.prod.outlook.com (2603:10b6:408:f4::11)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:21:49 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::90) by BN9PR03CA0156.outlook.office365.com
 (2603:10b6:408:f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:21:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:48 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/82] DC Patches August 17, 2026
Date: Tue, 18 Aug 2026 16:14:52 -0400
Message-ID: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 132404ee-be46-44c7-828d-08defd66553a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: qzx+HJbxzoKIQmo6F0IM2pysdLk/yUngctVxefK+15JKfAos+elRHPYFec79IBEbmuG2YWS/uPJZ9tNMOhk7p9LjbnCtNLeeSs4DzXOHLxtJ4YVCBDFTcDcIpNfEUT4/MZbk0FCZByCCmdEU16VQ+3S9ZbxhorlXwj2HbT2uDIz6HN9Y+iHITEj7cQzwGmoYt+AJU2zM32PAoP/QovfLFUEHJ5Y3RtdiNrPgBdAN9UatuTzH/agmiCCAARgo4UFVcU4EvDkL/v3YuFHw4f5tHUG2o58LZ+PG4XS7uU+AKmoWT6DN3HgHMhtYHEhJ5pdlC+ZMX/U7GARDjXsyUUudcWsSV/wefbjX0mWFqWBJ17ZXHuq3BcaHCX8GjTRswheZ+Wsi0fM7H5YMDBoevYFaqkaW8JlMufVNiTSEEJKX34VVbt7PyY9qeFuMHxel0NvYMtiFl1zu5bN4FXFTU5zIRLuVVYb7bjdC6lCZmOnosubIXEJsJQAOBSI76O/S6CZJRKEocRWLFJo2VhsdNeAr2FXnAl3UnZp3kVsU3/FQtOtaQXQyFJOZGqgrPFhcU5Kllbd2ZgbmSaHWaW6/6FuwhtpR+V5pTMH6NLzDyfvDKpkNty+0/vF1OCzbKgT9kk8FlcpDSCEBP9UTgQEXdoHu/U6+UU/JBHFDT1fFSMMiYcFL0Y26K/YYXIPpukwICyU5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k4K7tcgQLMTWfioWU9UsPD8ir90DT2aBEKKuLE0mTCLSfUXAEtVrykWbMZ4i5lH4MtmhCR6pnJypdOPwwMjfNXync3uhxbe3lz5DyH2Yj4eqdFiNZ3Numu7MCJaevHcQAKHZmbtLpxGN+Wu520olHvDil3RSs6meQnpWglzUO/lGysT7mapBAw5v8BTq5Ms1TV6yi3pnf9b2vyuYYFEXCIwIoguOeGoZQzK2plzTyhPzU7lTN+XxaYkT9CK1pQGkyslmCKBIqXS92VVBty1qukcg0okttfHj0cUfymZqrFp+yltMnfEcDOFF67yXm/Oal/msGbjxNAJ46IBgPPoq+iFjeCf0RiBCXKKspZPnQH5duCC/L6Q5bxXCfrnySDwdOUOOaiBcmRRDsvW2NyrXU/3hVU/Q8MoKgIv7fdcRY0TV77YFeTj+lpmprLSeEyIy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:49.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132404ee-be46-44c7-828d-08defd66553a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

     - Fix HPO test regressions.
     - Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx params.
     - Use fast update path for address-only plane flips.
     - Split OPTC_PIPE_CONTROL_LOCK into smaller helpers.
     - Fix DPREFCLK override when SMU isn't available.
     - Fix CalculateFlipSchedule calculation.
     - Add hook to disable alt-ch in PMO.
     - Update alt-ch size calculations.
     - Enable min dispclk ODM on DCN42.
     - Remove RMCM tetrahedral cube from dc_plane_state.
     - Fix mismatch number of OPP/DPP accounting.
     - Adjust vblank_nom policy for HW SDP throttling.
     - Add passthrough visual confirm.
     - Expand amdgpu_dm KUnit test coverage across cursor, MST, EDID, HDMI,
       IRQ, i2c, framebuffer, tiling/modifier and HPD paths.
     - Various fixes for Kunit tests related to HDMI FRL, IRQ and cursors.

Cc: Dan Wheeler <daniel.wheeler@amd.com>


Alex Hung (38):
  drm/amd/display: Test writeback connector
  drm/amd/display: Test GPU memory allocation
  drm/amd/display: Test EDID quirks and ACPI EDID read
  drm/amd/display: Test execute_synaptics_rc_command failures
  drm/amd/display: Test MST stream feature read failure
  drm/amd/display: Test dm_helpers_submit_i2c_over_aux
  drm/amd/display: Test GPU memory allocate and free helpers
  drm/amd/display: Test dm_helpers_dmub_set_config_sync
  drm/amd/display: Test dm_helpers_is_dp_sink_present
  drm/amd/display: Test dm_helpers_read_local_edid
  drm/amd/display: Test dp_handle_test_pattern_request patterns
  drm/amd/display: Test DMUB reg callbacks
  drm/amd/display: Test VBIOS bounding box
  drm/amd/display: Test dm_init_microcode
  drm/amd/display: Test dm_dmub_sw_init
  drm/amd/display: Test MST sideband message ack path
  drm/amd/display: Test dm_dp_mst_get_modes without a remote EDID
  drm/amd/display: Test dm_dp_mst_get_modes with a remote EDID
  drm/amd/display: Test dm_dp_mst_detect DPCD probe and unplug
  drm/amd/display: Test MST connector register and unregister
  drm/amd/display: Test dm_dp_mst_connector_destroy
  drm/amd/display: Test plane state duplicate and destroy
  drm/amd/display: Test modifier list de-duplication
  drm/amd/display: Test GFX6-8 tiling info from modifiers
  drm/amd/display: Test GFX6-8 tile mode and tile split lookups
  drm/amd/display: Test GFX6-8 modifier calculation
  drm/amd/display: Test GFX6-8 modifier list generation
  drm/amd/display: Test framebuffer prepare and cleanup
  drm/amd/display: Test cursor update and async plane update
  drm/amd/display: Refactor amdgpu_dm_irq_test
  drm/amd/display: Test pageflip completion in the high IRQ handlers
  drm/amd/display: Test writeback handling in dm_crtc_high_irq
  drm/amd/display: Test schedule_dc_vmin_vmax
  drm/amd/display: Test handle_hpd_irq_helper detect and debounce exits
  drm/amd/display: Test HPD RX, HPD init and DMUB callback branches
  drm/amd/display: Test dm_dmub_outbox1_low_irq drain and work guards
  drm/amd/display: Test amdgpu_dm_dce110_register_irq_handlers
  drm/amd/display: Test amdgpu_dm_dcn10_register_irq_handlers

Alvin Lee (3):
  drm/amd/display: Disable alt-ch until dependencies are ready
  drm/amd/display: Add hook to disable alt-ch in PMO
  drm/amd/display: Update alt-ch size calculations

Austin Zheng (1):
  drm/amd/display: Fix CalculateFlipSchedule Calculation

Bhawanpreet Lakha (24):
  drm/amd/display: Cover MST path in encoder atomic_check
  drm/amd/display: Cover amdgpu_dm_encoder_init
  drm/amd/display: Cover MST-start failure in detect_mst
  drm/amd/display: Cover amdgpu_dm_update_connector_after_detect
  drm/amd/display: Cover HDMI infoframe/freesync timing paths
  drm/amd/display: Add amdgpu_dm_connector_poll KUnit tests
  drm/amd/display: Cover hide_secondary_tile_from_userspace
  drm/amd/display: Cover dm_validate_stream_and_context
  drm/amd/display: Cover amdgpu_dm_create_validate_stream_for_sink
  drm/amd/display: Cover amdgpu_dm_connector_mode_valid
  drm/amd/display: Cover mode_valid EDID mgmt path
  drm/amd/display: Cover amdgpu_dm_fill_hdr_info_packet
  drm/amd/display: Cover amdgpu_dm_connector_atomic_check
  drm/amd/display: Cover atomic_check modeset triggers
  drm/amd/display: Cover funcs_force valid EDID path
  drm/amd/display: Cover amdgpu_dm_connector_get_modes
  drm/amd/display: Cover create_eml_sink valid EDID path
  drm/amd/display: Cover amdgpu_set_panel_orientation
  drm/amd/display: Cover amdgpu_dm_prune_primary_tile_modes
  drm/amd/display: Cover add_fs_modes mode generation
  drm/amd/display: Cover add_fs_modes illegal timing skip
  drm/amd/display: Cover hdmi_frl_status_polling_work
  drm/amd/display: Cover amdgpu_dm_i2c_xfer
  drm/amd/display: Cover amdgpu_dm_create_i2c

Dillon Varone (2):
  drm/amd/display: Fix mismatch number of OPP/DPP accounting
  drm/amd/display: Populate vblank_nom according to bounding box

Gabe Teeger (1):
  drm/amd/display: Enable min dispclk ODM on DCN42

Gaghik Khachatrian (1):
  drm/amd/display: Add passthrough visual confirm

Ilya Bakoulin (1):
  drm/amd/display: Clear HUBPREQ_DEBUG_DB on DCN6

Ivan Lipski (2):
  drm/amd/display: Refactor hdmi_frl_status_polling_work for Kunit
    testing
  drm/amd/display: Guard amdgpu_dm_irq_schedule_work against NULL irq_wq

James Lin (2):
  drm/amd/display: Fall back to overlay cursor on dcn4x when top plane
    doesn't fill CRTC
  drm/amd/display: Use fast update path for address-only plane flips

Meera Patel (1):
  drm/amd/display: Fix DPREFCLK override when SMU isn't present or ready
    for DCN315

Nicholas Kazlauskas (1):
  drm/amd/display: Adjust vblank_nom policy for HW SDP tranmission reqs

Rafal Ostrowski (1):
  drm/amd/display: Remove RMCM tetrahedral cube from dc_plane_state

Sridevi Arvindekar (1):
  drm/amd/display: Fixes for HPO test regressions

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.395

Tomasz Siemek (2):
  drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx
  drm/amd/display: Split OPTC_PIPE_CONTROL_LOCK into smaller HWSS blocks

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   10 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |    7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   28 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   47 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |   15 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |    3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   12 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   48 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   12 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   35 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   72 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |   16 +
 .../tests/amdgpu_dm_connector_test.c          | 3387 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |   32 +-
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  578 ++-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  862 ++++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 1117 +++++-
 .../tests/amdgpu_dm_mst_types_test.c          |  741 ++++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  703 +++-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |  228 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  330 ++
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   16 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  193 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   18 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   12 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   30 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   15 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |   10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   34 +-
 .../dml2_core_dcn5_funcs_initialize.c         |    2 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |   23 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |   47 +-
 .../dml2_core_dcn6_funcs_initialize.c         |    2 +
 .../dml2_core_dcn6_funcs_mode_support.c       |   27 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |    7 +-
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |    3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.c   |   46 +-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   12 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   16 +-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c   |    3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   66 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    4 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  216 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   21 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   34 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |    5 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    4 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   51 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   64 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   10 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  174 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    9 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   12 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   55 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   21 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   10 -
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   23 +-
 .../dc/link/protocols/link_dp_capability.c    |    3 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    4 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    4 +-
 .../dc/resource/dcn60/dcn60_resource.c        |    2 +
 85 files changed, 8768 insertions(+), 986 deletions(-)

-- 
2.43.0

