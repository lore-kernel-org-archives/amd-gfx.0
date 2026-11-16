Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E3606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wCbmvdBJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC5110E499;
	Tue, 17 Nov 2026 17:12:24 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E0E10E499
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRClqGwnk49OnilpZO/1THabFUgd28rhlsWThGW3QMfKoH+WPu/a3+w9S/jgsWbuMzjpoM//O7DhS/G7Aoppu1xMEhYQ0Pps3BXE5YR/LESfAQqtPf13YntgU9KZiQy/9eYXWB9z1qW1Xw5fxzt1z2gj/JOUgXIAjwRgYhyjj/C7doE2uLlhAMQBTu6aN2QdZyOfP8ZFiTPWHCjkRZMwLlshGVnkol7c/LFu4lzDVYEDYa7wwoL0yhM+1ZFPRQnyppu0gYqTl2FBIpGQRgyB5OqeDAC3W/7EI7Bz9cxSb/1lOhPcBmmqCC8K6UvOgP6CqFni6pSH4swQxXZ3ypNakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl9m21tZ2EdoWYkV0mPsnYz3F1H/Xh4u66+sPN1sRrA=;
 b=p72dk0DrlOI+fmoTThPA4RiR2evgNd6YusDRMKyqyMo0Txw4Hj1+A/1zy9NDinCTj4QH9lr0PxFt09B5pyE7+Mw9PiXW7TmLf6jP0tPTMeo20u7+hp0VayY9wSeQcvfqXD9CRw3N9DfdQBfEX0nefIXryDzn/+rJsWgt1u6oFTTaHnK7jHqef5ZtwtnzaAh5F8zrA4jqO9jTCQiexNM3gjilfi4Sjg+uhwpNTmTOsyN+3Wn1P4UavjxxqMtpT/m5RjJ9j5vNrXJ2fEbra4Qmq3fxlmym9H8TLKTe2ztbmsNpq0oYCDdXOMfMWFGeSzf8uiof040DhU3Y56c4C9m+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl9m21tZ2EdoWYkV0mPsnYz3F1H/Xh4u66+sPN1sRrA=;
 b=wCbmvdBJHiu8/1lvKx2hl1BFaXG6ChhhW40h54TIi2FfEIDKyWPb4t07/PyCC0Qs2VoJ8pZNECRKg/37jo3OO6F0PvvnqFFEyX7d5V0hZoBPu0myUWDiR7kEPEW6lp45jyMYn5Iu+v4Laa1s14Eb09ESP3Mi/IX/LvTQXuPHBjo=
Received: from PH2PEPF00003850.namprd17.prod.outlook.com (2603:10b6:518:1::72)
 by LV0PR12MB162361.namprd12.prod.outlook.com (2603:10b6:408:3ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:12:11 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2a01:111:f403:c95d::1) by PH2PEPF00003850.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:12:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:12:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:05 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:12:02 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/33] DC Patches November 23, 2026
Date: Tue, 17 Nov 2026 05:50:37 +0800
Message-ID: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|LV0PR12MB162361:EE_
X-MS-Office365-Filtering-Correlation-Id: bbec146c-4aaa-4dc0-1cb7-08df44cdea93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|30052699003|18002099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: bPVEBQyqGWg7NXwBKahWxvOR9efBDUWdP1Q0tw5t+MgHnsVN4qQnUq/1QckTgY1CFMtKaac4ElFE3Ss8VXJMu97KuHMpwYJbCadmpDlUBKDVXeJxPPuAG/HHDFdNXXpB4p4WVJoO14zxUpaYu2GgWeg/Xs+vsl4MPf9q/B2eZ9M4vPVfedQku3Zdej/WWodqnRTjXAuGNPElsI/DP0cSCHkKbDcXc1DRiMFAfhbCgF93dLw2wtaKBssDPkdrpPjZdG+VmUlMp8gd2t9uVjk01A6i4cmkXdCRN9MjHUuVkD3F0yf1haWc9AAI1R+OJoa41CLzcPgKF/T/G1g1Q8VGvUazLCXv4N+fJuFGNz0soEiFavD3cpeWwCw1jBMmj6Y1l0DK0woDlBZ4KAUPd11xB1i9sCgWCmLc9o1rWkWPDu/oM0N/0tpDsTSADfzlClEJ6jp2rrFQzr3kaS1Sm6e7ZJizl1YhHOCqYyXYj7Qn2WcC2GxlC4elVCYF1etCFuMRN50hqUoPK7FEKJxgOkdHH5sBA0ncSQI5blx3QzeO5AHM3ZPGK4cTaXVGCwXK7NQ54DZK/IQcZkL4a6fBBrVrWGJReklhXfAnrdnKI9dE4mBRVsSjimhsLL/qRftJbu63C9/QsQZQeN9Vgt3u+pOzEiQub2vw26W7YjummXF1307JOO+KyCSfvD8CCu8oVuAtZjOaKtu+54kPF4WR9/noTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(30052699003)(18002099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ir0ShodG7/k8D7HcIXP/7E8hOfhJTls2oqc6wqcfGsphOfQzoALP8vNXO10jfgVEfF9kTdGFnPYlJ/R9gV0CNM9YX11hJjTs9NJAcwgT32+qo/1QpA7EnehzINS+IcHuw2EdQsePMr5akToB6XoIciRLLFI9oyurO9nWWSVbJEfZCNE2hibGrkCTen9ltDBbahaXU8DrmaVVTnB5Irh2Nze9ptMBTdGNtMOhP9isnAdri8jDo5eaibBPwbTtBSv/PDGBvdCqykB+eV87BkcKWX/k79M+aeWxXs3a+FJ427lZfU9Gm+uGt4QtPtM7O1dDnZYFq80iyy59mquGJjUXePjgS7GjS1KkU1pGkmP79L6tpNsdTp5lGkyFaaFjaeaGLGTIerQKnp9J4KOdwJbFpYrVw/BDQIWlUumNiv0umEvLu0hctNcquEGaLEFhRUvb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:10.3057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbec146c-4aaa-4dc0-1cb7-08df44cdea93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB162361
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This DC patchset brings improvements in multiple areas. In summary, we have:
- Rename DPMS to DPMS_v1
- Power up eDP when detect link
- Add DPMS-v2 files
- Refactor DP retrain link HW sequence
- Add extra 0.25 line reserved for TSetup/TCalc inefficiency
- Use panel luminance range for AUX backlight in power module
- Read PWM back linearly with the linear backlight curve
- Add API to set brightness percent
- Pass linear brightness percent to power module
- Add DPMS-v2 types
- Always apply 0ppm pixel clock adjustment
- Add otg versions of get_vblank_counter/scanoutpos
- Queue vblank control work to sleepable context
- Fix KUnit tests for vblank control rework
- Add urgent request and assertion probes
- Fix G7 P-state aperture addresses
- Set stream min/max refresh from VRR config
- Add DC2 wrapped initialization for DCN401
- Honor the Replay stream regeneration wait event
- Disable Replay when link off frame count is below 2
- Skip DSC padding borrow estimate for zero padding
- Drop unused DC interfaces
- Let the DC2 commit replace or keep a stream
- Support two streams in the dcn401 DC2 builders
- Add a plane beside a kept plane in DC2 update
- Keep an unchanged stream in the DC2 commit
- Change the ODM and MPC layout in DC2 update
- Give the DC2 builders State pipe facts
- Add RGBA8888 surface pixel format support
- Fix DCE crossbar for RGBA8888 surface format

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Allen Pan (1):
  drm/amd/display: Always apply 0ppm pixel clock adjustment

Dominik Kowalski (3):
  drm/amd/display: Rename DPMS to DPMS_v1
  drm/amd/display: Add DPMS-v2 files
  drm/amd/display: Add DPMS-v2 types

George Shen (1):
  drm/amd/display: Refactor DP retrain link HW sequence

George Zhang (3):
  drm/amd/display: Add otg versions of get_vblank_counter/scanoutpos
  drm/amd/display: Queue vblank control work to sleepable context
  drm/amd/display: Fix KUnit tests for vblank control rework

Harry VanZyllDeJong (1):
  drm/amd/display: Honor the Replay stream regeneration wait event

Harry Wentland (2):
  drm/amd/display: Add RGBA8888 surface pixel format support
  drm/amd/display: Fix DCE crossbar for RGBA8888 surface format

Ivan Lipski (2):
  drm/amd/display: Fix G7 P-state aperture addresses
  drm/amd/display: Set stream min/max refresh from VRR config

Michael Strauss (1):
  drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable

Nicholas Kazlauskas (2):
  drm/amd/display: Skip DSC padding borrow estimate for zero padding
  drm/amd/display: Drop unused DC interfaces

Ray Wu (5):
  drm/amd/display: Use panel luminance range for AUX backlight in power
    module
  drm/amd/display: Read PWM back linearly with the linear backlight
    curve
  drm/amd/display: Add API to set brightness percent
  drm/amd/display: Pass linear brightness percent to power module
  drm/amd/display: Disable Replay when link off frame count is below 2

Samson Tam (1):
  drm/amd/display: add extra 0.25 line reserved for TSetup/TCalc
    inefficiency

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.85.0
  drm/amd/display: Promote DC to 3.2.408

Tomasz Siemek (1):
  drm/amd/display: Add DC2 wrapped initialization for DCN401

Tony Cheng (6):
  drm/amd/display: Let the DC2 commit replace or keep a stream
  drm/amd/display: Support two streams in the dcn401 DC2 builders
  drm/amd/display: Add a plane beside a kept plane in DC2 update
  drm/amd/display: Keep an unchanged stream in the DC2 commit
  drm/amd/display: Change the ODM and MPC layout in DC2 update
  drm/amd/display: Give the DC2 builders State pipe facts

Wenjing Liu (1):
  drm/amd/display: Add urgent request and assertion probes

Zhikai Zhai (1):
  drm/amd/display: Power up eDP when detect link

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  116 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   52 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  208 +---
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  225 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |    3 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |    2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   20 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   23 +-
 .../tests/amdgpu_dm_backlight_test.c          |  552 ++-------
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  219 +++-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    2 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   |  129 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   78 ++
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |    2 +
 .../amd/display/dc/bls_builder/bls_builder.c  |   19 +
 .../amd/display/dc/bls_builder/bls_builder.h  |   86 +-
 .../dc/bls_builder/bls_builder_internal.h     |    3 +
 .../bls_builder/bls_builder_private_types.h   |   28 +-
 .../dc/bls_builder/dcn401_builder_internal.h  |   87 +-
 .../dc/bls_builder/dcn401_init_builder.c      |  812 ++++++------
 .../dc/bls_builder/dcn401_init_builder.h      |   16 -
 .../bls_builder/dcn401_init_builder_legacy.c  |   77 ++
 .../bls_builder/dcn401_non_seamless_builder.c |  243 ++--
 .../dc/bls_builder/dcn401_query_builder.c     |   41 +
 .../dc/bls_builder/dcn401_seamless_builder.c  | 1091 +++++++++++------
 .../display/dc/bls_executor/bls_executor.c    |   79 +-
 .../display/dc/bls_executor/bls_executor.h    |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  267 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   28 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   38 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  142 ++-
 .../drm/amd/display/dc/core2/dc_core2_init.c  |  298 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   60 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |    1 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    3 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   61 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |   23 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    6 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   25 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   42 +-
 .../drm/amd/display/dc/dce/dce_mem_input.h    |    6 +
 .../display/dc/dce110/dce110_mem_input_v.c    |    1 +
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |    1 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |   13 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |    3 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |    3 +
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |    3 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    3 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    1 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   80 ++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |    4 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |   35 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.h    |    1 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.c   |    1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    8 -
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  243 +++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   80 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   61 +
 .../amd/display/dc/inc/dc_core_interface.h    |    6 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   12 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 -
 .../gpu/drm/amd/display/dc/inc/link_service.h |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/link_tx.h  |   59 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    9 +-
 .../display/dc/link/accessories/link_dp_cts.c |   43 +-
 .../drm/amd/display/dc/link/link_detection.c  |   17 +-
 .../dc/link/{link_dpms.c => link_dpms_v1.c}   |    6 +-
 .../dc/link/{link_dpms.h => link_dpms_v1.h}   |   10 +-
 .../drm/amd/display/dc/link/link_dpms_v2.c    |   44 +
 .../drm/amd/display/dc/link/link_dpms_v2.h    |   38 +
 .../drm/amd/display/dc/link/link_factory.c    |   23 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |    6 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    4 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |    4 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    4 +
 .../dc/pmfw_messenger/dcn401_pmfw_messenger.c |  211 ++++
 .../dc/pmfw_messenger/pmfw_messenger.c        |   62 +
 .../dc/pmfw_messenger/pmfw_messenger.h        |  118 ++
 .../amd/display/dc/state_facts/state_facts.h  |    3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   48 +
 .../drm/amd/display/modules/inc/mod_power.h   |    7 +
 .../drm/amd/display/modules/power/power_abm.c |   83 +-
 .../amd/display/modules/power/power_replay.c  |    1 +
 103 files changed, 4807 insertions(+), 1898 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_query_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_tx.h
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.c => link_dpms_v1.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/link/{link_dpms.h => link_dpms_v1.h} (92%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/dcn401_pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pmfw_messenger/pmfw_messenger.h

-- 
2.43.0

