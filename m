Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8342FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1C310E68F;
	Wed, 15 Apr 2026 07:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKycKqBW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056F310E68F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ0UM8PkKpmQWy8xAshaxeN9UVf+43Qeh+k4+E09w0SlZlnASE4NqPc7fN/DfHwY07ECm/DUSY6O+pxDvAuqy7ZXr2p8xeuG8EOj2ud2UYlHRDLIHWv0xEK5RxNTVRol/1c8l0Yb+Dw1lmFKV/NPYSeNTN6SdjMLShDtx6bnzHHEnhZ+03BKaazVrGJUBN5EymrJxV4ZDcramma7GCOXUwd05bX881EB1Zl/vO3+UUraBx/QTiW7Re9UulLT4xlYSLXHXdZFricTBeS0PA72iF9wChEjcQWR6fpMlK60OL6sYokU3Z62RM3GrHk9ufxbfGJ7YQnEhZOtDNn7zO57JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu5I7FZRjEnl8QnDOuf9m0NblIexgLgiVxIbOtQFi2w=;
 b=qWyUAIL5/xh8/hOoyRtDoVb/fruzOhaObOuIviq2v9OGSZFdCDPuIJbjnm1GO1TdtTRfcYAekFy1DMPlXKT9dnsktR6sFSEHScUo3XB4oZeGtW9PmvLDrSsxYPPONZ8C7umrgGUPDJyIlsgr+GHHcrCHWyuB+2TDoPyE0DIR5aE+sqxkwwvuU5cCQ+xQ7uzs8Pxt1o6e+hX0jKoxxWy8hfp1X1VkMe7d2+zKGSRuuSdseA6b838i6BdILs/QzR8zu1mpX97Y5FYpZXmc+LSst7zJu4P7HBDXdlke8I6l7+Gw+R73aWD4OzEmDysYFa/vRG3FXw6YDiy838xauKaLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu5I7FZRjEnl8QnDOuf9m0NblIexgLgiVxIbOtQFi2w=;
 b=DKycKqBWbdOaH0A+/wlBlcR9d15WafrlxoVRSdsfLor8vgfVmmNKEfQd9k+dSl8KMbQGtBB6uZqhDO2sfwGHmwUHHrBwWrL1QTuLBTxRPtTAlA+r9pLaB7JXvhW4aRN3a1HzBH+Y/hElcCkGQ9upa94AYXhXRgxch5nIO9oZdN0=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:42:33 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::8f) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:42:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:42:31 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:42:28 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 00/19] DC Patches Apr 20 2026
Date: Wed, 15 Apr 2026 15:39:39 +0800
Message-ID: <20260415074223.34848-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 61854e1c-86f1-4ffa-9381-08de9ac28d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: LQ22d6tG+B5PX0riLFS63ljHt+ZZYEg0hIcAA02g3dZUjcdjmA5QDpAC+SDkQrUN8+vum6zbFwH2qfXkwPyO8ukQVIWkfC1Np8durWr4n/oV+dFgFbXAXefy44gysoXyPM5XGACnFekoW7ocpqVYVvEm6m1Cm8oWi68VCvh8eTYjGRC2kliploXVuH38XQ28Qrzu/SV+XDsayoMBvw4WdWVrrlLc0sjMGfgXdNo7jVbLl7Fp08cyU6X+RME2aeCIQrKbShkLg2q9iMO33D4YN4IsF1LzdrsG3+O67LKtOnCPvdBYfN+SkjKuvzZhedjk63H/e06e2XTk4LM4MFUVjU0Ee4iuc9n9woueaBdKZqHE3kNh8qcm/3fIeORx91U3h+yldO0YK9SDYog/qridzAxTz7RCrnA1O4pvojJsOIInRyCmjYSt3dCfTe6T+ocMwyiNj13Nb05ez5Wm8vlKGvsahfbgTC0QV/B1R0UmCowajNuyI+oXMq4E8yAE1tOzdW+zHD8j68wyG0leMOK2Z+tMtiHtqEJrq65mTG/blpK6TcWTnmk4/OMj3t1f7GXCwLjxWVl1K+Gf0xCUyAR60MTF3l9tApcOhphHAihVJDhFKjELYAQN7PxOQJ89ryElQvd5h8xoi2jo4u+/uJPsduvYVgkYHJHXm+5wujnD/ymjM+jeEvcbYImwZSJuKOi+RnCYCobcDScHV+vqk3isQylm9e75uY1gz6m9pwxo7HW2vqjzRH3LOC0yX7vOuZL6fnCkzzCuOwvxAuIpH+L1Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r65tkzICxJMk0zkNfHsnXKztIHrYsJNWV9haeZa2W5zyhKNGlqzOMWatJfdcoX0iKjJomQYRgW9fA0+X8DImIT6c74I1fi8mvlFdXcv72u49nqolp/mPZX7TkCcrc9Erv4odGg2SprImPjfj89s1Q/f6vlyt697bDMERjcegXHLW1/Wl9TkzK9b0G0J741Z6idMpeUMJbi7rKJ/4POWs/IHlEPYgI1u0Dq8iy8Y+2v5CwQSTV20dB3CBR5ND55DYLB3HFXV4cBYIdOCmOeCkpk1t1KXVEKEfpwFHu6DrQh34bNeXrru84CuYwQBfnes4MT/l5QlSRnhtG+TALNcgxbpLnqzvWIAt4lnZmREDxtL2JgOzA7hg4NnwQHSMin5f3QeYvQqMwEF9LFDRbCjVeMQDNoCQHz23l1X5ZOyL7o6sHoA3gajvnHs5sQhR2mXa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:42:31.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61854e1c-86f1-4ffa-9381-08de9ac28d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

 - Add allow_clock_gating to dcn42 dccg.
 - Bypass post csc for additional color spaces in dcn42.
 - Remove unused dml2_project.
 - Unset Replay desync error verification by default.
 - Align HWSS fast commit path with legacy path.
 - Fix implicit narrowing conversion warnings.
 - Enable driver power gating.
 - Fix double free.
 - Introduce power module on Linux.
 - Add power module on Linux.
 - Fix fpu guard warning.
 - Add Replay/PSR active check in link loss status check.
 - Remove SYMCLK F and G values from link encoder and MANUAL_FLOW_CONTROL from optc.
 - Add minimum vfp requirement.
 - Fix narrowing boundaries and eDP parser assignment.
 - Fix dml2_0 narrowing boundaries.
 - Add README.md file to DML2_0 repository.
 - Fix DPMS using partially updated pipe context.
 - Move dml2_destroy to non-FPU compilation unit.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Allen Li (2):
  drm/amd/display: Unset Replay desync error verification by default
  drm/amd/display: Add Replay/PSR active check in link loss status check

Andrew Lichmanov (1):
  drm/amd/display: Remove SYMCLK F and G values from link encoder and
    MANUAL_FLOW_CONTROL from optc

Dillon Varone (1):
  drm/amd/display: Add minimum vfp requirement

Dominik Kaszewski (1):
  drm/amd/display: Fix DPMS using partially updated pipe context

Gaghik Khachatrian (3):
  drm/amd/display: Fix implicit narrowing conversion warnings
  drm/amd/display: Fix narrowing boundaries and eDP parser assignment
  drm/amd/display: Fix dml2_0 narrowing boundaries

Ilya Bakoulin (1):
  drm/amd/display: Fix double free

Rafal Ostrowski (2):
  drm/amd/display: Align HWSS fast commit path with legacy path
  drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Ray Wu (2):
  drm/amd/display: Introduce power module on Linux
  drm/amd/display: Add power module on Linux

Roman Li (3):
  drm/amd/display: Add allow_clock_gating to dcn42 dccg
  drm/amd/display: bypass post csc for additional color spaces in dcn42
  drm/amd/display: Remove unused dml2_project

Samson Tam (1):
  drm/amd/display: Add README.md file to DML2_0 repository

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.379

Wayne Lin (1):
  drm/amd/display: Fix fpu guard warning

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  344 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   36 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   74 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |    5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   60 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   26 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  242 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  143 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   28 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   27 +
 .../drm/amd/display/dc/basics/custom_float.c  |    2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |    2 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    6 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +-
 .../drm/amd/display/dc/bios/command_table.c   |   12 +-
 .../drm/amd/display/dc/bios/command_table2.c  |    4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |    6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   12 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   39 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   13 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   14 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   14 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   15 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   15 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   43 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   16 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   40 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   22 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  |    1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  206 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  565 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   66 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   26 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   17 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  137 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   38 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   30 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |    4 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   20 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |    2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |    4 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   24 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |    2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   16 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |    4 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |    8 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   14 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   12 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   23 +-
 .../display/dc/dce80/dce80_timing_generator.c |    2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |    4 +-
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |   16 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |    2 +-
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |    2 -
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    4 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |    5 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |    2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |    2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |    6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   37 +-
 .../gpu/drm/amd/display/dc/dml2_0/README.md   |   31 +
 .../amd/display/dc/dml2_0/display_mode_core.c |   14 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |   20 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   15 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |    2 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |    4 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    1 -
 .../dml21/src/dml2_core/dml2_core_factory.c   |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |    1 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    3 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |    1 -
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |  100 +-
 .../drm/amd/display/dc/dml2_0/dml2_policy.c   |    6 +-
 .../dc/dml2_0/dml2_translation_helper.c       |    4 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   40 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   11 +
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   10 -
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    6 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   16 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   33 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |    2 +-
 .../gpu/drm/amd/display/dc/gpio/hw_generic.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h |    9 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |    2 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |   16 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   28 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |    3 +
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |   12 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |   12 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   12 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   33 +-
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |   12 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   12 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   16 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   18 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  138 +
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |    2 +-
 .../dc/irq/dce110/irq_service_dce110.c        |    2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   37 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |    4 +-
 .../drm/amd/display/dc/link/link_detection.c  |    4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   16 +-
 .../drm/amd/display/dc/link/link_factory.c    |    6 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    5 +-
 .../dc/link/protocols/link_dp_capability.c    |    2 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |    2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   10 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   57 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   27 +-
 .../link/protocols/link_dp_training_8b_10b.c  |   10 +-
 .../link/protocols/link_edp_panel_control.c   |   41 +-
 .../dc/mmhubbub/dcn20/dcn20_mmhubbub.c        |    4 +-
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.c        |    4 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |    4 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |    1 -
 .../dc/resource/dce110/dce110_resource.c      |    4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |    4 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   24 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    9 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   14 +-
 .../dc/resource/dcn301/dcn301_resource.c      |    8 +-
 .../dc/resource/dcn302/dcn302_resource.c      |    4 +-
 .../dc/resource/dcn303/dcn303_resource.c      |    4 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   11 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   11 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   11 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   20 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |    2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    4 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |   42 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |   14 +-
 .../drm/amd/display/modules/inc/mod_power.h   |  415 +++
 .../display/modules/info_packet/info_packet.c |    2 +-
 .../drm/amd/display/modules/power/Makefile    |    2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 3030 +++++++++++++++++
 .../amd/display/modules/power/power_helpers.c |   16 +-
 159 files changed, 5833 insertions(+), 1416 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/README.md
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_power.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power.c

-- 
2.43.0

