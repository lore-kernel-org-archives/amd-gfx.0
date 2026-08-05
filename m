Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21AC561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CE510ECF9;
	Wed,  5 Aug 2026 06:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZaLuUg9M";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E32610ECF6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYH4+9k72O5TXeo5FY+poy/ml5RETqg5NdBZOFa0PtZmucMInr8V5B0DIRTeGgRzTvWLwCyhJ8+GNWDIg5HraXGMnsH5yHLz4HrgCuvbL0TuP1EqUdMZhaDNjwAGxig6tycLqkAOB4IS1blWOxJYuWW6EqCCOOrvnO/brq0INDJTx/ZDY8JX0ujlfCdYG9AIFPwasB5WmQmAOrPGmHjjSYg745XgNTuSDp15MN/a6EAPUallg/NtzDvqshJ7edt4AFvV6HYA9GEfedGQ++nSRuwMhacpG5Xrf8Z1dazX+2qVoCQhQkbtQuwqPh55P+XDrBpZj75CTA47HNskwaysTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HwIezfCvn7ffz42IN8FZoUGtuhIND/huL9wr5qYWA4=;
 b=deQQ8suZ+N1vjTlSlDMMkIv1MJxJfvT2s0jpzht3HqcXB5g4bGLzmazTUO0YoL7DDaDTPlHgBZNBPXs6LPn1yf5J6RvNTtd8qjnUTBXXBDI2X/6oU6fRQzrgSeT2+VO50cWYknxLlAFdPD8f2Rp9AAAnj8yqns+LiKw6bnwshdwHf6rqLucnHZhni0Smk+eR4mZqJucq9YMGLxUNYKQQ0e38c/E7oL14xnH+KJHQHY6U4blBn3rAQJIzlAQsq/wynJeo9s2GU9qNDsYJ/r2OM6tfXXdfMIaDIHKgj11WjW7tX/N4Ui7CICZs/KuNnK0BYbu/M4U8JjN82SoKG4BllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HwIezfCvn7ffz42IN8FZoUGtuhIND/huL9wr5qYWA4=;
 b=ZaLuUg9MLaCosrWPF2oPtwS0C8aN5EbCG1GJmnyFiBzGnm8IySw3NVRv7cxVLTL+uJAG2WHQ0FypgRxi98/901Vi3o7mmv+psSqXY54oNMWGeL27qMXGc48pmcwpY1etmsxhDsi5ZtXrwK5CcJmidlEHOfgIS8TlbByS34pp+0g=
Received: from BY3PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:217::23)
 by CH8PR12MB9839.namprd12.prod.outlook.com (2603:10b6:610:274::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 06:39:54 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::34) by BY3PR04CA0018.outlook.office365.com
 (2603:10b6:a03:217::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Wed, 5
 Aug 2026 06:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:39:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:39:52 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:39:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/34] DC Patches Aug 10 2026
Date: Wed, 5 Aug 2026 14:36:12 +0800
Message-ID: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CH8PR12MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: 039059b5-ff9e-4c01-c4d1-08def2bc5bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: DE7tiTT3Hq6YNKVfX2TlqMlLwG5wiCh1n87EWI1vZGVbqs5+6vqSwNw78ORmy2TW5Zbeze3aYZhg0LfgEV91bVXlWthUo99GL6gZogcQ0rQ6dWMR9CtE1r1tK0lnamKzr0Ppw7jFEKClOPHn88woQW0VJwWp2JVIpeolN5SfdwHLp0zNk6+ZyhpYhPUz4/jxq+clk3y9i2Yqy5X0krvuGuSn/jj68CWYu2ZOKMvqUeOzTJHWS04xWZ34Agpe4aNH2sRSUf5aBfc9C8YR733Q7Ox24SYjnuJKvDYUK6BTrmtaZjJ6w17mHh1lY2TbXJyxgYsPvJJP3+HXPEF/Lj3NPDaue4UTciIgg68UBK1qBbH5wTtIl7rUek04FZnmzeAfxtfGHEMXy/KNbv/e6pW+vk6QA1blZAxacmIhqFYdOWxZ8Dz1w7hyzEVZr+P5SQcYPjnKltg3+Cm/UCA1npY+kPmDk67m58gwTPZVpsLPkkM92okAFD2GF8PfHK8Rx8ter/iKpSGkr4gqLkFnYSw0Zfs4zfYbjk9RhmEEsyTR60HGCbW6yuKypG8yK2MzgeyQL/gJ3Qcc8gCfCyJK0gdOqVTHF9dWajLfP0IpbCIUtSZ0K4lrgSHoIxGt1JJNMBCXa4SVE9d5E2bI1DZqVAnpww6jURb1aZ/O6juV6gpGE7wYHaEy+FzNf0qswZ/BCq5zqrvVoh8khHKVtzLefwLCEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: THlOvCvV/HDxdciUzGM3rTmIFCSSaLHB3+r/MKHTphDy2H5l/f5pCvBniOhOK9Isej+Y2a2oDXmU0tvkcM/zjW254smVK2Gzn1u+NDMhJjav0z7j8ZcblaZaqGUhwcLpmcl9u2kBgnEcMdM8B32+hYfKBpKpk0+mSwOoC19Cxq4CR5ki0iBW7Dd/iIgZ+oX753UT5KaWja2NjKgsf4NxjdrCNKC/Qq07QjDeYxjfxkEukS6sU8mN3HodIq+NK7CzyBkX4oDNn81dy+yjgDvvJhWglcDDkPFl53pDpLF8jRql2McYRqw5J2sOK1lOgpqddZfyrFH+la09U8o/pl0c96gSrs15smLW5KdkVlmpJbtAPIhmu53br7N9k0UkP94SQO2IfMGkR3W6zN1hJycwkS3PWQsVVop6xti+bHOps/3yFBklIoUe94WwHC78TFKo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:39:54.1874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039059b5-ff9e-4c01-c4d1-08def2bc5bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9839
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

- DCN6 fixes on GPUVM calculations, HostVM and SOCBB VM config,
  clkmgr interfaces, and peak bandwidth measurement
- Unified fast update classification paths and inbox0 HW lock on DCN35
- HDMI FRL fixes on LT timeout behaviour and cap restore during
  non-destructive link verify
- Greatly enhanced KUnit coverage across CRTC, VRR, and cursor paths
- eDP panel polarity control, FreeSync range quirk, and Z8-based
  zstate support
- DCE ASIC code gated behind CONFIG_DRM_AMD_DC_DCE for DCN-only builds
- Fixes on HPD filter programming, DMUB DIG PHY wait, dcn42b
  force_min_dcfclk clamp, audio tests, and UTM client QC profile override


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (7):
  drm/amd/display: test stream VRR updates
  drm/amd/display: test VRR IRQ parameters
  drm/amd/display: test VRR transitions
  drm/amd/display: test dm_check_cursor_fb
  drm/amd/display: test native cursor state check
  drm/amd/display: test dm_plane_color_pipeline_active
  drm/amd/display: test amdgpu_dm_crtc_get_cursor_mode

Alvin Lee (2):
  drm/amd/display: Update dcn60 clkmgr interfaces
  drm/amd/display: Apply workaround to limit SopCount for now

Bhawanpreet Lakha (6):
  drm/amd/display: Cover crtc duplicate_state stream and null guard
  drm/amd/display: Cover crtc destroy callback
  drm/amd/display: Add reset_state existing-state branch test
  drm/amd/display: Add amdgpu_dm_crtc_late_register test
  drm/amd/display: Add amdgpu_dm_crtc_init tests
  drm/amd/display: Add KUnit tests for
    amdgpu_dm_crtc_helper_atomic_check

Charlene Liu (2):
  drm/amd/display: fix HPD program filter programming
  drm/amd/display: add a NULL pointer check

Dillon Varone (1):
  drm/amd/display: Add support for overriding UTM client QC profile

Fangzhi Zuo (2):
  drm/amd/display: Force FreeSync range minimum on quirky panels
  drm/amd/display: restore FRL cap on non-destructive HDMI link verify

Gabe Teeger (1):
  drm/amd/display: clamp force_min_dcfclk to dcn42b range

Gaghik Khachatrian (1):
  drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE

Harry VanZyllDeJong (1):
  drm/amd/display: eDP panel polarity control and test support

Nicholas Kazlauskas (2):
  drm/amd/display: Fix crash in DCN5/6 calcs when GPUVM enabled
  drm/amd/display: Fix HostVM init and SOCBB VM config for DCN6

Ovidiu Bunea (1):
  drm/amd/display: Decide zstate_support based off Z8 global support

Rafal Ostrowski (1):
  drm/amd/display: Unify fast update classification paths

Ray Wu (1):
  drm/amd/display: Align KUnit tests Makefile license header

Relja Vojvodic (1):
  drm/amd/display: Update and revert FRL LT Timeout behaviour

Sridevi Arvindekar (1):
  drm/amd/display: Fix audio test errors

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.393

Wayne Lin (1):
  drm/amd/display: Extend DMUB wait for DIG PHY programming commands

Wenjing Liu (1):
  drm/amd/display: Fix DCN6 peak bandwidth measurement overshoot

YiLing Chen (1):
  drm/amd/display: Extend inbox0 HW lock support to DCN35

 drivers/gpu/drm/amd/display/Kconfig           |   9 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |   6 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   4 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 645 ++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 694 ++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 407 ++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  17 +
 .../display/dc/bios/command_table_helper.c    |   7 +-
 .../display/dc/bios/command_table_helper2.c   |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   8 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 ---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 --
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  | 181 +++++
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |  29 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  30 +-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h | 344 ++-------
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 115 +--
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |  17 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  | 220 +++++-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h  | 167 ++++-
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    |  76 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 246 +------
 .../drm/amd/display/dc/core/dc_link_exports.c |  22 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  79 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  42 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  54 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  27 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  10 +-
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   2 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   4 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  15 +
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |   1 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   2 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   2 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  11 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 206 +++++-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    |  19 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   6 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  46 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  15 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  16 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   5 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   2 +
 .../dc/irq/dce110/irq_service_dce110.c        |  21 -
 .../dc/irq/dce110/irq_service_dce110.h        |   9 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  28 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   9 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   4 +
 .../link/protocols/link_edp_panel_control.c   |  30 +
 .../link/protocols/link_edp_panel_control.h   |   4 +
 .../display/dc/link/protocols/link_hdmi_frl.c |  32 +-
 .../gpu/drm/amd/display/dc/resource/Makefile  |   4 +
 .../dc/resource/dce112/dce112_resource.c      |  62 --
 .../dc/resource/dcn60/dcn60_resource.c        |  10 +-
 .../dc/resource/dcn60/dcn60_resource.h        |   9 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |   6 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   5 +
 82 files changed, 3357 insertions(+), 990 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h

-- 
2.43.0

