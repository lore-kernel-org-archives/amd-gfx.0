Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F5ACD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6AB10ECBF;
	Wed,  6 May 2026 07:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X1FD0y9m";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6610ECBF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ+mkqw+XRU+SHz4qEzEFrHnAEXgbNyiQq1TTt4rwn7ym0Fb5gFqYnX3FtgCTFX7Zr+zcgOrC2yjWyk88jpNmh+swoTABOOJxd57uEO6pCylLOiLKJPKPxb+/cpXkSkGvOb74nhj20SJ9yPh2A30j/i70cGAm/o7sC6GrZ9d7bQnZRyScRhcQNgceNjd2ge892AmJzSlz+U2sUECI3FXLzxJUNbAPOiNRAuKa5O7kOuhDe2PTGhM6nOvBqYf4enWhVjkno1wca62lArdm7ez54e0UGzEXAf3RGhXZ5uxQ7CunwcZp+ftswesIZAm6sRMHR7fedE4yVCw2qoXTJiCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQJ2HuGLIlbitBJaWODAgN+OJ+qzoN/YJOdgx3QdYZY=;
 b=qfK47X5bgzRpYfqxVQiH/8SrEETUbfqllsaVWiJEzphxjKzInMI1ckdLbO/rc6kdjPmj+0q/A5l1WcfAdU0mDn5EYApcZTE5LhTCHv9wj+7+/+egAgouUKPCS/9hRslpsuTgoKmYk/bXP3sSXDF9CgQxyaa+3KZeDuYviN37uDQr+XFekSJeHDv+fgCDD0L3AISDB1fml3Wlgw0VKbxbM08lZ2t9gomzkCm8KpLojz0iw/UJCmVH+uvPVJY7puFWm+8UpjOVTlGMqJh9wpbGzUf73IJb4CZ6TJ6cJNc9zPNKF+wjhm1bMwN/GjaubdX6Qrlh1JEhETV6lar0bpZEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQJ2HuGLIlbitBJaWODAgN+OJ+qzoN/YJOdgx3QdYZY=;
 b=X1FD0y9mJ3SsMfR08p+cviNmaZ2hqI4me8kaxLeS6CBewq0f0Ig2yD3cwPjL/aBskule9kkb2XdBGOpASepR801df+ozMiSCSefCi4b1myjwLPCj4O4LPV/vYyy7oIutvtBX/Nbis3+FLDn5b8JFDvnwu3GmRN6kbnBNgvdW58I=
Received: from CYXPR03CA0078.namprd03.prod.outlook.com (2603:10b6:930:d3::11)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:02:49 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::58) by CYXPR03CA0078.outlook.office365.com
 (2603:10b6:930:d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:02:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:02:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:02:48 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:02:45 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/20] DC Patches May 11 2026
Date: Wed, 6 May 2026 12:30:58 +0800
Message-ID: <20260506043342.2164710-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4e5287-1409-4f8c-6a38-08deab3d7b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HyZLJUP33CodmLu22VuJpYFIGdZL8H20Wk+orJuGiuk682BasUuMqMxm6fuuXuAnhAH4EkScP3xzP/f0uHifgeNQLkNG99Wz/BrovSJwCsvyWmpHIQe0jX38HV0W/TfhaHwCmmK6hi76RUwRgFahcvhdIBFnukn9GDSB8oqW41NPiHaRfekZO6oIP8hRybuCefBsQ/7wGcYSKutFdrjB9G+jF42aX24bmU4CxHp957m0d158/cLIGqON+zrfGLvjxUTmaV7Vt6POhSXDwkS01URrlIYjoYraOQ9GaT0tn2yzMm8F3Ma5nhB6b/342mu1QrwBC04WTAe+NmeOrvtDHzjdwIME5A8rSRWB9QHTOImKOPker3DW6SHPMnWW4xD7RL++533MuUkyXmy+THoG24VrcYPpXjKsvl5oWNdTvBO5Ozwpz1Exj8Bnk+uhTWfBumJ6UE5LVVTh7fOldRyXd8nd9Cq3VWd+pFi0edSMaj8acBCe/JwR6rcpnlPIslYAJ7tI95UwWk0kMgGpzjqhzLlBlLuFONWL1zIzh5izualY6uGV8UWV5qnik00J27XUo7ZJ9n2fIwLjQVr0oBOT3hgx45vIVqFdwHwAicAblOKF2DE/LGigz/Axf0krlj3ws7d7lr9XSsFZG9lbESZordUIlF08nIQ/j6Ts3/bkQQvpTuEA+eJ9nyYdP5GWuij2u/KIWYSjrNDRsewrG4oSZcPXHUVeRTptwXS7/77b1IE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ru9q6ARIOUD4s1MwZX1pNPndB+Jd1WsxgjMPgRLP4KfWHOXX7Z0eupp1cOK75CQ/01kUYfr5ydMpoWrgYfH+VabCJAKitSwVtLe78lOvCnAlYnPJABZ+lPvE/Yfs9nrlvcLkX9if7xk6ho3ghvg+ubPrEDR+JmfBh5hln8fQ4gKCJEBSjOcmK3+bp64zGvBIRhj/lQi30pj4Fkom7N9bbeYkhghDJKbdTUw2oZryTTNWRySn7sO8/MRsKlCjvO5L/ol8BxMcsK01bN4LBJVPtq39NDIqxzC65HCiOEMXhI+hhW1dlBPLkkOQlZQCc3wRiRtPK2TDBirAX4S+xBJa30H5NrrMwrExBRt+vtRk/SsqH08ZoPtkykOuYpsMnwy288VKU4yBVtJMrB5B/Cm+Ur+Ap4VTsG/Yj0l5SZXOOZpuVBtkmKNwQz7oGjL5q8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:02:48.7107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4e5287-1409-4f8c-6a38-08deab3d7b92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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

Start from:
6ee9f5160ad6e0bf672329f7680398e718fc56f5
SWDEV-114487 - modules: [BACKPORT] drm/amd/display: Fix divide by zero in calc_psr_num_static_frames

Stopped at:
5e7f507891f430f50c71004b73c5ef4c13224f1a
SWDEV-2 - dc: Promote DC to 3.2.382

This version brings along following update:
-Revert "Enable HUBP/OPTC/DPP power gating" -Revert "Unify fast update classification paths" -enable ODM 2:1 on single eDP based on pixel clock -Enable IPS on DCN42 -Add additional IPS entry/exit for PSR/Replay -Separate ABM functions into dedicated power_abm.c file -Fix always-true lower-bound assert -Refactor dc_link_aux_transfer_raw -only call pmfw if smu present flags true -Fix multiple compiler warnings -Fix CRC open failure during active rendering -Fix white screen on boot with OLED panel -Fix refresh rate round up case


Charlene Liu (2):
  drm/amd/display: only call pmfw if smu present flags true
  drm/amd/display: enable ODM 2:1 on single eDP based on pixel clock

ChunTao Tso (1):
  drm/amd/display: Fix refresh rate round up case

Clay King (1):
  drm/amd/display: Fix warnings

Gaghik Khachatrian (5):
  drm/amd/display: Fix signed/unsigned comparison mismatches
  drm/amd/display: Fix compiler warnings in dml2
  drm/amd/display: Fix multiple compiler warnings
  drm/amd/display: always-true lower-bound assert
  drm/amd/display: Fix enum decl warnings

Ivan Lipski (2):
  drm/amd/display: Add additional IPS entry/exit for PSR/Replay
  drm/amd/display: Enable IPS on DCN42

Leo Chen (1):
  drm/amd/display: Revert "Enable HUBP/OPTC/DPP power gating"

Lohita Mudimela (1):
  drm/amd/display: Separate ABM functions into dedicated power_abm.c
    file

Matthew Stewart (1):
  drm/amd/display: Refactor dc_link_aux_transfer_raw

Mikhail Gavrilov (1):
  drm/amd/display: Wrap DCN32 phantom-plane allocation in
    DC_RUN_WITH_PREEMPTION_ENABLED

Ovidiu Bunea (1):
  drm/amd/display: Revert "Unify fast update classification paths"

Ray Wu (1):
  drm/amd/display: Fix white screen on boot with OLED panel

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.59.0
  drm/amd/display: Promote DC to 3.2.382

Tom Chung (1):
  drm/amd/display: Fix CRC open failure during active rendering

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   77 +
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |    6 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |    2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |    8 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |    4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |    2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |    4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |    4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |    2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  260 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   12 -
 .../drm/amd/display/dc/core/dc_link_exports.c |    2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   18 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    4 +-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  105 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    7 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |    4 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |    2 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    6 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |   36 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |    4 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  342 +--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |    2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  408 ++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   10 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  400 +--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   15 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |    8 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |    8 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   10 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   10 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   12 +-
 .../amd/display/dc/dml2_0/display_mode_core.c |    6 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |    2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    2 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    2 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |    8 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |    8 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   10 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   10 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |    4 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |    8 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |   72 +-
 .../drm/amd/display/dc/link/link_detection.c  |    2 +-
 .../drm/amd/display/dc/link/link_detection.h  |    2 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    7 +-
 .../link/protocols/link_edp_panel_control.c   |    8 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    2 +-
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |    6 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |    2 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |    2 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |    2 +-
 .../dc/resource/dce100/dce100_resource.c      |   10 +-
 .../dc/resource/dce110/dce110_resource.c      |    8 +-
 .../dc/resource/dce112/dce112_resource.c      |    4 +-
 .../dc/resource/dce120/dce120_resource.c      |    6 +-
 .../dc/resource/dce80/dce80_resource.c        |    8 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   15 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   60 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   26 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   63 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   31 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   22 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   22 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   30 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   26 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   37 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   29 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   33 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |    6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   22 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   26 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   26 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   26 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   32 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   50 +-
 .../dc/resource/dcn42/dcn42_resource_fpu.c    |   22 +
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |    2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   32 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |    6 +-
 .../amd/display/modules/color/color_gamma.c   |   28 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |    2 +-
 .../amd/display/modules/inc/mod_color_types.h |   47 +
 .../amd/display/modules/inc/mod_info_packet.h |    9 +-
 .../modules/inc/mod_info_packet_types.h       |   37 +
 .../drm/amd/display/modules/inc/mod_power.h   |   25 +
 .../drm/amd/display/modules/power/Makefile    |    2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 1323 +---------
 .../drm/amd/display/modules/power/power_abm.c | 2160 +++++++++++++++++
 .../amd/display/modules/power/power_helpers.c |  823 +------
 .../amd/display/modules/power/power_helpers.h |    1 +
 116 files changed, 3922 insertions(+), 3295 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_abm.c

-- 
2.43.0

