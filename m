Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502D2C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED7910E2D9;
	Wed,  2 Sep 2026 05:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCjXt7ye";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6DE10E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLMMZ4dmiVAOl/quckzJ7v7IKGCW5w14XYC9xG51XU3pyponjxV5zjpFS6b/yT0G2Vges946j04KuPf2WopfhqqXm9nz+liqrOJga40tIf7zCqAWfDeOCfaOzh/krpcIBrOp8iOhUjdQS8F8Daw5M7ouW5Oket2OgUQSUxWs04ZsagFIosA1kx1HZCY2COeQkx3nwg3pBMqi902tqGwCEOuPzvqn5Z/OJziqQEHsoP9fN8vY1b0DtB9/vZ3MVXwxDmaEBHcOumCrY5zI/YMvJQL8tvS73QQQNeiTBv9tbWacJAqWrZCBr9D2jx+KEIG2yaqRy55hhBavu7LDSnEmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXOOkk+IGgVK08SYkEiNwFkQfz+GiqG+/wqJpxpD8gg=;
 b=kcoE7v1mAwN/UauS/7NiZBZjwfziKfPxo1Dw312DcXBoZNNi8LoE4DFft09P2CvGOIWfE/KDSGJZTzs4QVabXOUg8yydCaDNXxu+Eo3T18FXzslUdO4YEUNuiLBSSO8NY/j5uGq5Q4AXIgJ/IVQn6ou+98qmUmwlBXA+OhlhgRbNSNs/XItHgezLS3j+sJHOYYJYM2oBDHdSW+MgOYWLJ7KlQ5oUMSHc8DlkSo1tA+RPhYMCJknAyIVmCDmb3SwJjjJ1J32y/XA+QsC0jrTJP1EJUVBCyTE0EJwXgc75psgJvSsLjFd3F32At06t1edRtWQWWwhRCUWuetWo4uVwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXOOkk+IGgVK08SYkEiNwFkQfz+GiqG+/wqJpxpD8gg=;
 b=NCjXt7yevpf0DUkth4H/WSWqwU5Fh5wSPAqdCJUDISR6eWWvPO1DdQ8k0U5pHsF5z64HLqo7uucOaB5dqFHfwrart9CW4vPo+ZKjed/sZkaOQl6iH663DqMk+gGtGoHAm9ywURSwdlTv6frS9v1556W4nJLf8ndk9et7kKQdACg=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:04:20 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::22) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:04:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:19 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:11 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 00/40] DC Patches September 7, 2026
Date: Wed, 2 Sep 2026 12:58:22 +0800
Message-ID: <20260902050411.3473916-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: d50dccfe-740d-4b7c-0f21-08df08afa5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|30052699003|23010399003|376014|18002099003|56012099006|3023799007|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 41rVHh57sw+ay/KzRLTpL6gHnmqDp2osQ9jqDwsPmpjXGLFwvaocA6p2MW1icB2xzxFOxlIcr5eUiAbhU4w41wA9fRDaVuUKHwuBGBr6prfEHNSilw8hIxUBKglSL3BU66acGtf1xoY0CnmSR4/twPbmihgGWIeXCZty4ErvtKex+GCr1PPDYiSjQ+nd5ay1mzfmeaG/xdB5v5K7p9wBss6/1Xa6S5JBB/8SOhHFxVUdB6jn/qV9T04Qtu6MhBepT5I3d1cgabYqrJr+myQHQUKXQBa1tdm1mCRaCM2vM3rhfavOUfUGv06K5Uhx3qTU+yCNB+h7hZ8FG072jmcvP60f0DIaXXM6YpowsImFbtCJPaRrOWF1S1SQZir/WY+zi3CY0JL7YxNYmOq167AhxlcnUEoqqXwiV4tjsSCEDn75wXjeke7gDVNDROC7wsbtXVzr7OcG2aLSZlC7qnE+VXGnlHdfRd1cWI6/hI5zz4TOE4QN+A6wnSpFUZsDjPqhM4Pw4rNlJD1PhmQh2mcL7BeSwhBg7l6OMorJv6wsFw9Kh1X58duOuhbVY6mwH5/wuabJ1Zey9LZYtVMV2P2/o8t+CaTN6hsv/w4YQZpbfGH7jtyYs8Ps4rn5erhEdM+399xbY3tYN5wNq30IlX2MAnGx9Vd0KH/4emsvoCteLSuvznWkxLLJFXLftEVGLrR86KQyHX4zeh2AqQKKhy4CYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(30052699003)(23010399003)(376014)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wwg+BXz8/84PSSTrfCn0DqtKpWKfaB/7MHY3jqBvgub45cJozmy4fi5LtVRq0i/IS1KmEXF+dCQGXo8qlS8dVzBaJ+SFmbXfA8jn9ZnzOxOCtX5lsXID6r59oYdHeydUmzdFRcDZ+pN+Q6aOjlqZkrplooi83Oca+qM7EnWPC8v1BY+enTnB6bjsHnR5//2XnbP4HdXAPf4vNa9DAAPY46kPkdtMvMuGKfG0pS+tlGo98pPYB3F8sNI2gZQ8gPRGVG1zxCVHeexQfw3jq8RJGon7gE6AYo15YHn4EHETaMAmxc+5BCUtXnzIEqULaj8sQk2qx6tSfmZYfwhRvr67XekJG7lDO6tS3nCJy3MW688GLS44d2brWbPEs/qYB/uKZOET56yGdXhpCpDwr4tTTa9Tw+xCh2R+P388rRUQuxOF3YwRRaNswf7BfN2kodg0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:04:20.3394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50dccfe-740d-4b7c-0f21-08df08afa5cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Ensure requested LSDMA bandwidth stays within the SOP bound.
- Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop the pipe_ctx param.
- Add an override for LSDMA bandwidth in the QoS table.
- Expand amdgpu_dm KUnit coverage across vblank IRQ, self-refresh, GPU
  reset, plane update, MST resume, cached suspend state, writeback
  transitions, atomic validation, connector-state restore, EDID CEA
  parsing and DM IRQ source handling.
- Keep streamclk gating off when enabling streamclk.
- Set mpc_tree_params->opp_id during OPP resource construct.
- Add override capability for UTM table params.
- Add immediate restore to FAMS2 for DRR.
- Fix missing APG registers for DCN60 HDMI.
- Exit IPS before connector detection on resume.
- Fix HF-VSDB DSC bpc detection to be cumulative.
- Fix unused params in flip schedule.
- Enable the FW locality check in DCN6.
- Fix DC Hub reference frequency assert range.
- Dump clock registers in HW init instead of SW init.
- Validate the IRQ source in the DM IRQ handler.
- Revert "Fix CalculateFlipSchedule Calculation".
- Assorted DML updates.
- Update urgent burst calculation to account for unbounded requests.
- Add a stressed peak-bandwidth probe with DMA contention.
- Revert "Unify CalculateFlipSchedule Logic".

Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Alex Hung (12):
  drm/amd/display: Test vblank IRQ handling
  drm/amd/display: Test self refresh entry
  drm/amd/display: Test GPU reset helpers
  drm/amd/display: Test plane update adapter
  drm/amd/display: Test MST resume guards
  drm/amd/display: Test cached suspend state
  drm/amd/display: Test writeback state transitions
  drm/amd/display: Test atomic validation guards
  drm/amd/display: Fix unused params in flip sched
  drm/amd/display: Validate irq source in DM IRQ handler
  drm/amd/display: Test DM IRQ handler source guard
  drm/amd/display: Fix signedness mismatches in cm3

Alvin Lee (5):
  drm/amd/display: Ensure requested LSDMA BW is within the SOP bound
  drm/amd/display: Add override for LSDMA BW in QoS table
  drm/amd/display: Add override capability for UTM table params
  drm/amd/display: Enable FW locality check in DCN6
  drm/amd/display: Dump clock registers in HW init instead of SW init

Austin Zheng (4):
  drm/amd/display: Set DISPCLK per surface in DML
  drm/amd/display: Update Urgent Burst Calculation To Account For
    Unbounded Requests
  Revert "drm/amd/display: Unify CalculateFlipSchedule Logic"
  drm/amd/display: Update DML fields used for mode support

Bhawanpreet Lakha (2):
  drm/amd/display: Cover dm_restore_drm_connector_state
  drm/amd/display: Cover EDID CEA parsing helpers

Charlene Liu (1):
  drm/amd/display: Make sure streamclk gating is off when enabling
    streamclk

Dillon Varone (1):
  drm/amd/display: Add immediate restore to FAMS2 for DRR

Fangzhi Zuo (3):
  drm/amd/display: Exit IPS before connector detection on resume
  drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative
  drm/amd/display: Fix NULL deref of new_stream->sink in VTEM guard

Ilya Bakoulin (1):
  drm/amd/display: Fix missing APG regs for DCN60 HDMI

Joshua Aberback (1):
  drm/amd/display: Remove unnecessary includes

Nevenko Stupar (1):
  drm/amd/display: Fix DC Hub reference frequency assert range

Ovidiu Bunea (1):
  drm/amd/display: Set mpc_tree_params->opp_id during OPP resource
    construct

Samson Tam (1):
  Revert "drm/amd/display: Fix CalculateFlipSchedule Calculation"

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.74.0
  drm/amd/display: Promote DC to 3.2.397

Tomasz Siemek (1):
  drm/amd/display: Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop pipe_ctx

Wenjing Liu (4):
  drm/amd/display: Add stressed peak bandwidth probe with DMA contention
  drm/amd/display: Add dml2_core_dcn6_calcs function pointer table
  drm/amd/display: Route DCN6 mode support calcs through function
    pointer table
  drm/amd/display: Route DCN6 mode programming calcs through function
    pointer table

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 141 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  50 ++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  10 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   5 +
 .../tests/amdgpu_dm_connector_test.c          | 514 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |   2 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  45 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 676 +++++++++++++++++-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |   2 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 210 ++++--
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    |  44 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  86 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  21 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  45 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  14 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |   2 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   8 +-
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  |   1 -
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  |   1 -
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../dml21/inc/bounding_boxes/dcn6_soc_bb.h    |  12 +
 .../dml21/inc/dml_top_dchub_registers.h       |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  13 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 172 +++--
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   8 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.h    |  23 +
 .../dml2_core_dcn5_calcs_display_pipe.c       |   2 +-
 .../dml2_core_dcn5_funcs_mode_programming.c   |   4 +
 .../dml2_core_dcn5_funcs_mode_support.c       |   4 +
 .../src/dml2_core/dml2_core_dcn6_calcs.c      |  63 +-
 .../src/dml2_core/dml2_core_dcn6_calcs.h      | 468 ++++++++++++
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  35 +-
 .../dml2_core_dcn6_funcs_initialize.c         |   2 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |  52 +-
 .../dml2_core_dcn6_funcs_mode_programming.h   |  31 +
 .../dml2_core_dcn6_funcs_mode_support.c       | 312 ++++----
 .../dml2_core_dcn6_funcs_mode_support.h       | 324 +++++++++
 .../src/dml2_core/dml2_core_shared_types.h    |   7 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |  13 +
 .../src/inc/dml2_internal_shared_types.h      |  18 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   5 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  26 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  25 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   9 +
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |   2 +
 .../dc/resource/dcn60/dcn60_resource.c        |  25 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  26 +
 62 files changed, 3148 insertions(+), 470 deletions(-)

-- 
2.43.0

