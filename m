Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A106C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ADA10E292;
	Tue, 11 Aug 2026 15:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2C085+e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD3810E292
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/avE/WmXEvhKn1YoX270tWaOucQ7D6LRoU6Q+83qA4+vV3NdtvwJBs5wKDsPIIFScT44Od5GUrPADBNmVgKfWa/InX5Yjuy7sx+OBPVO3hbo/OQ93h/1g+EQ27VZxL3Lsx1kcLm28NvyO0akN6JBptsZ0DfP5KNZXGDuG/1nh9cDAMS0jDuouuB9j65fivegbUb/UfAVSQHCdVAp2sS8A0iAN0x37DXTjlN8CEUq0ULgSqV5S17u2OT1kXyGfHyJJPPBLV3fHBsZm3LoCs2od4B50InvNPqQp3h9+fBTglVhYpd1aEA7CzYEzOCCVPj5VSRGI3mISbboIPlVsNM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJrgoJvLvXgyoBdE8XhykMnuWiPivQDCmHSHQssJ794=;
 b=Wt1EqsSYE+mLOpCHB06CtvyDVaS2e1DQSDhxgKDWtEzf9SLJTs0mMtsknmDQ4+RW2T1sTzlA2+/Triq+JuFi5oiFIevqJfADpZ383umerLNDJIAX7239g07GsVy78E8xuxhqPHQxlvgqnL69YbMr0EOv4J4BLf5BBVx7PeNiqumqTboAmlO09kh6WvNqdFf+VL8CcBf5zd/TsyNsHJG/rUTdcWxHzfoJUKVuazGy3fErfBBQSZK7uY56gaDARH3kzD3EoV6tY/FU4FuLMrD1LE2k/mpMiqTV/0d1yerjJs4uZd1ksLMEv9zlLXot6OQ8160K0h7guYJDOT9PoPUK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJrgoJvLvXgyoBdE8XhykMnuWiPivQDCmHSHQssJ794=;
 b=U2C085+ehpQG4IyapV3iTAeh6Mo6VST2PXkdlV5+yYPwWo0Ow+EAGLtbAAGGnFtURbwhSE4yD2uNUXjawJY9C/9JsE29wIlX6hQqmGFF4zc+lNJQ01BVFcE8Ui7XWHQjjj8Vy2Y8+pJOwPNR40SiL5oxv9MoEzqIT9lui0KBb/w=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:48:08 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::83) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:05 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:02 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/24] DC Patches Aug 17 2026
Date: Tue, 11 Aug 2026 05:28:34 +0800
Message-ID: <20260810213010.1703162-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2476f9-0571-4478-a2cd-08def7bff0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|10067099003|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: jMxMx99hJ2ngQVJyr0rLv3MbFFabPxR/ZViAMv2P85YxA3PZ7DpavKDG56dWMWrFcSHjIN/fLde45Qnf2nODIXvuhTswHwmTA+hyevwOBs+O1k3v8QDUiGjAGwWbLcG68pYKdmu0YvFO2wsr9OxoZOTviuDEsTsvpArxVq88p5ET7hBe978n/2K4sQBVczdLWmMA09zPLOQs8b3ZnNKk8ruJndNW2H5CIi/Q6QrcdwZPS+nJF9T+U4oCklN+qZgUpfcRtz3M9ppQS+x4wCC5x+Q9a/nbBa52J8Q4MwFXlqTVV0BRnp16opJs8gy4GuYRpOUT6IRx6uzToD8FYGNP6S3UmGc4PIrcjexRoujGpv0tZ4Iz827hBGDt/9x5CZEO6KbqEeBKCJcs3N+TrSDbUwDzyXO3ASmhmZdqSalKVY9/tvtVfrq5f4jd+cZnO2gYlQQ9U4y9hygGF/Mg8WRh9rvGh4BO3KoIcGO1BlXPUM2Lqf3KMzRdx/St1fBS9MKmYXEMLUgC3bKPW/Qv/tFkGXwtMig3lMEb4UGJv3F6fwuaSNiCp+b1m7TVR3FSxDSVi+QVTegfX1ZDwHlm4CDpHZrv34Fql5M6/H29LgELxZoAeXOtmBNkJ8+n44LiQC34RvYpVMRKwxq4yL9ss3xzwfjPlBugj4OoP6WZnuIvtRnOl3XS6bo4Po1He/i/VVpeXkVrHwsQTQ6nvOffSNcPdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uq3fxpDsj+BhI2WuHZInSgEK/ujXczwERWVEiCQFqVXcPL8wsF7tl6e57Ph6H/T3GJhOURrQ9Ph10jb0LvVSYuAWzicW9mi0na2XQv2QHCgUOG77p/UzdtoL79/Z1J5RvuJ5FJ6/kJgItoX47SosYZZa1UaFSg17w4XblRG+huk6M5EkerTiuCA9IOSBAMpruiQFjQaL4fftqq8RmSrVGwBRKWWQq8AnrkLAuA7caHns9zbyiZG0gVQue/Co+AieKXoZHfDANyKHPYu4LwT+gd/TWjxwVGz/QTbxqDyaNd5TUbmTmvtIIUdGnLEf/EXyJffooTStz+HwT30BTK5pV+h2arvVSgqKtWLzeeOhUhvTcK8VpmwYdazmmLwzOeQ9wVzWiSLdZDluSe6Z5Gnj7/doRtTkBY8agdZMHF1/tjAHa6CPBSbuD9sXXHCeWZF+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:08.2072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2476f9-0571-4478-a2cd-08def7bff0c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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

- Reworked per-DPM derate handling: refactor the per-DPM derate logic,
  update derates with default per-DPM values, and move the
  soc_and_ip_translator onto the new per-DPM organization
- DCN6 mode-support and UTM work: opt-out for the OutstandingRequests
  check, a utm_support capability flag, and a guard against an empty
  DCN6 UTM QoS table
- More DMU/DMUB offload: send DPM0 clock values for Z8 retention, allow
  DCHVM<->rIOMMU SDP port disconnection on DCN42, and add the DC_BLS
  command
- HWSS block-sequence cleanups: move periodic interrupt calculations
  to HWSS, drop pipe_ctx from HUBP_WAIT_FOR_DCC_META_PROP, use mpcc_id
  instead of the hubp instance, and add a wait stream regen event
- DML updates: unify CalculateFlipSchedule logic and relax the frame
  size limit for the dcn5/6 core funcs files
- clk_mgr refactor renaming carried DCE clock manager functions for
  dcn10, plus a missing-prototype build fix and a static DCN42 SOC BB
  struct
- Expanded IGT/KUnit validation: CACP ACE curve area debugfs and cursor
  mode tests on disabled CRTCs
- eDP fix to skip teardown while a forced PSR is active

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (5):
  drm/amd/display: Make Struct In DCN42 SOC BB Header Static
  drm/amd/display: Refactor Per-DPM Derate Logic
  drm/amd/display: Update Derates And Set Default Per-DPM Derates
  drm/amd/display: Unify CalculateFlipSchedule Logic
  drm/amd/display: Update soc_and_ip_translator To Use Updated Per-DPM
    Derate Organization

Chenyu Chen (1):
  drm/amd/display: Add CACP ACE curve area debugfs for IGT validation

Dillon Varone (1):
  drm/amd/display: Rename carried dce clock manager functions for dcn10

Ivan Lipski (1):
  drm/amd/display: Relax frame size limit for dcn5/6 DML core funcs
    files

James Lin (1):
  drm/amd/display: Add missing prototype for
    amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags

Jun Lei (1):
  drm/amd/display: Add opt-out for DCN6 OutstandingRequests mode-support
    check

Karthi Kandasamy (1):
  drm/amd/display: Skip eDP teardown while forced PSR is active

Ovidiu Bunea (3):
  drm/amd/display: Add DC_BLS command
  drm/amd/display: Notify DMU to allow DCHVM<->rIOMMU SDP port
    disconnection for DCN42
  drm/amd/display: Send DPM0 clock values to DMU

Peichen Huang (1):
  drm/amd/display: add wait stream regen event

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.71.0
  drm/amd/display: Promote DC to 3.2.394

Tom Chung (2):
  drm/amd/display: set base.enable in cursor mode tests
  drm/amd/display: test native cursor mode on a disabled CRTC

Tomasz Siemek (3):
  drm/amd/display: Move periodic interrupt calculations to HWSS
  drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP to drop pipe_ctx
  drm/amd/display: Use mpcc_id instead of hubp instance

Wenjing Liu (2):
  drm/amd/display: Add utm_support capability flag
  drm/amd/display: Guard against empty DCN6 UTM QoS table

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  68 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |  24 +++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 +++++++++++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 ++++++
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  14 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |  12 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |   6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   5 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  18 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  18 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  26 ++-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   5 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  11 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 136 +++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  18 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  12 ++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   8 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |  39 ++--
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |  25 ++-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  27 ++-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |  44 ++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 183 +++++++-----------
 .../dml2_core_dcn6_funcs_mode_support.c       |   7 +
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 106 +++++++++-
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   7 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  60 ++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  24 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |   8 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  23 ++-
 .../dc/resource/dcn60/dcn60_resource.c        |   1 +
 .../dcn401/dcn401_soc_and_ip_translator.c     |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  39 ++++
 .../drm/amd/display/modules/inc/mod_power.h   |   1 +
 58 files changed, 924 insertions(+), 412 deletions(-)

-- 
2.43.0

