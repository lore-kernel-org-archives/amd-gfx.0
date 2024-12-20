Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B284E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1751810E2D6;
	Fri, 20 Dec 2024 21:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSTA1qFP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EA910E094
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cay8No0YxxEHOGwq+L8Tj7H8Uq1SS/ytFqcDaYxZ9z+AAbYFwJAM39b0pRUiuNbwka2eYzrcgK/6wbPjs9Q7YOio91Zncc3X+IPxRjksMvj8sGWBw6WGPkYYo+xIAG+0gBK05Itgd/lQBPSWXhik66XCiad2fqwW92nxyMry5kUuRefdMbAa0n/aN7SJk7a8ENgvIE0LAZAqn3ydIKpL6mn8E2bMbL8Ig4dgR+wjmwidV/ggZVTmnZ7GJ5KbXs8OTB6POzeW0pA55x9zwJ2G3WQjwQFwb8pAdMiIM6k7HDQBnTaV04kn4ymeoGREqsbpAeLEXn8IM+0lyTHf3p2lIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLj12sGX54SaO5RQgrVKEYW8ZgLwZ6O6vOE0yX2c4rM=;
 b=fPGVSkQkBv0ih7WyVwZNZ3L6la9L7+pLnFWuFEHJfpgMdDFW2y4ktgmgZyBLj5GNT+7mG27TPVlxA6UWcxQHoBnkV3KFg0Rs0tpkFBOqxewv924wJtnszn9wfRmF1/aDN+BX4BtX/ZNymAX0tugAuwrTTgmO4hByHa1waus/+vnAK1N9PiM6cL0MxrqYdWX1UOyng8oiUI/tedGiQcvKfMKtsGyqeFjQHM45IdGFCbe7/7Rxoj0/ZY1TT/GagG8sb6yIUyr+Dovi7pvQxqw1MBS38W2qPN3XXaldDGSjTtcLTbVYXzdhbcgorpPEkbT6T8DE022RU9JkyOnGFtbYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLj12sGX54SaO5RQgrVKEYW8ZgLwZ6O6vOE0yX2c4rM=;
 b=pSTA1qFPVDj9b8sK/eRO7cUmH8+/acGPomEie5B9FDicCBWyTV1Ks4dJNwf8cnYRInQDDLUouqiZfQAF/tU0mXZPSUe204ON3XEG43vnBy2QfvtSxuQOnag9Imo1ZF3bbTdzLZ7kVJQXF97SjPlvNZQyp0n6lfTYOgif9DlYgiY=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:50:48 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::40) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 21:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:50:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:50:46 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:50:41 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 00/28] DC Patches December 20, 2024
Date: Fri, 20 Dec 2024 16:48:27 -0500
Message-ID: <20241220214855.2608618-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b31697d-b8a8-4e95-dfd2-08dd21405d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vtRhQRm1cymhEyKcXZ8hy3rrs5rgAh9uHPg9dYRKfKSurrRXcmC+11OcNjgN?=
 =?us-ascii?Q?i8Mjd7Z2dJgZjkuPs6XzdufwlXLX368EWnwEOsxCRajBey5y0Dyh1d58G7G1?=
 =?us-ascii?Q?IpstmFwTxCymeU3dYsJtAs8TfjvVxYdG29mUjOKkiHH7v7ViJmGZp/fsrVUF?=
 =?us-ascii?Q?125vJGgwGSqKey2U9A+/D1vPLz2/y5TYe5Kgu2s8d8evTpdvAsFjZ0/Zi/nl?=
 =?us-ascii?Q?+qSoy8ITmrsuu98OTSVdmEaoplR/yqBZHF8ZJ92vzy6sBN1rX6OAT7gWjt+w?=
 =?us-ascii?Q?Rrjrfzz8qD3moLQG76sX2qjDA+aNLIIHLHfnthw3G6I24QtY4zxTC2Zss52T?=
 =?us-ascii?Q?K7wzeXwuAfZ9sVV2HTv872wGDz5LN5aC/fI0zwUIQFp1v7nPG1iIfQtsjloa?=
 =?us-ascii?Q?LHiBfyDXkaVpPYnCSiTjcZ3PGjc0CySXmOwgyyJHYxoL8HfxEQaGYB4bxXdY?=
 =?us-ascii?Q?wIovS5wnEPmyUMqVz+N0AbJZSii0bxoSuV4iVTDhTmSf7Vqx8lkZAcv2lnIm?=
 =?us-ascii?Q?iGm5NNusgt0D5869tag0RBhGHSck1qZOV+BNPSedHW8AqJkTROHXUql8vRw5?=
 =?us-ascii?Q?P0AOU/iufb/OtY1W/rst4/647tUslb2uB85p8XIXuVXpD1OCeo1ckv1kx2dT?=
 =?us-ascii?Q?j7Uoa/BUjGP4DWUBx0JLnkH/Yfn4NXaOgUZ79i6Bu0s2CRdCt+gs84P676MB?=
 =?us-ascii?Q?xIVxtPF72uPFkt0OdnQHM0E1gvsPj1NbZD5m4EkzL7GSfr78fVSywco56KwO?=
 =?us-ascii?Q?767XK7JY/R/CND697DQYakEhHTAG/Uhgmx8nX3JnIVZ3m1zZfw1q9rGkE9Qn?=
 =?us-ascii?Q?WJFmd2OkAZjfkRlswAz4UI/kTCX6FEn61K0Rau9uyFCNBFfvmxQtFfmt/Bem?=
 =?us-ascii?Q?Sqi46BXeWE9GUTyJsdyukQoYV2WVKoM2Q+a+MebuwrDPr8GZrjvv8cD9GwOJ?=
 =?us-ascii?Q?WbSY16nPXazRZqDoPTaOF2Mws/67Rmu0LtS68L9iTOty+/zynmZwPeDtjr2J?=
 =?us-ascii?Q?91BqAsRfOQaldJJuBoY9+EYsCbSuXOLxpbogKIIQdbfnTw3NDCrKeV5ewMxp?=
 =?us-ascii?Q?BR19BUVqhzShFqOdCZ3PGFaQzSBHjsj4j+GaAJPc8TuWfu56yRFmIa0RNv8R?=
 =?us-ascii?Q?mv4gpsXcGGn1+qdWLdXoJ9aBuPPnMMSrzDVOZaXOEkEUIKkGN2nlnc9eNg9Y?=
 =?us-ascii?Q?cwYmKEy1zZD01BjTPmY4tm7TFwNb1EbnMjrLOYEBFhQsmXjSrSuRTUbAA2Um?=
 =?us-ascii?Q?sVj2mgzSQCQdQd6mmn1rD+b9FR+5L9it4nvzuXeF/1CaqZHIkBYT1p/BF7O9?=
 =?us-ascii?Q?ZAnhZCeADMHbVk3JIL72QbQz2zbo7aJv8CJkPfnINU207Q3oem6E6eCJdedg?=
 =?us-ascii?Q?VEClnviVCd2r07gVYfcEpvEaUwGCVys2WhKV5sBypacvvtsH9o2v1E2G/kZX?=
 =?us-ascii?Q?QmH5NKgyPmAhTdybWs+VLhmNzv9reEDQOByqkZmnuSx6zfdojN3Csod0mtWE?=
 =?us-ascii?Q?J37+UkSk1JP0c7g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:50:47.6918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b31697d-b8a8-4e95-dfd2-08dd21405d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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

From: Roman Li <Roman.Li@amd.com>

 - Improvements for DP, Replay/PSR, DML, SPL, DCN32, DCN35, DCN401
 - Extended logging for DSC, VABC and stream crc
 - Optimization for cursor position updates

Aric Cyr (1):
  drm/amd/display: Optimize cursor position updates

Aurabindo Pillai (1):
  drm/amd/display: Add guards around MAX/MIN

Brandon Syu (1):
  drm/amd/display: modify init dc_power_state

Dennis.Chan (1):
  drm/amd/display: Implement Replay Low Hz Visual Confirm

Dillon Varone (1):
  drm/amd/display: Cleanup outdated interfaces in dcn401_clk_mgr

Fangzhi Zuo (1):
  drm/amd/display: Add Interface to Dump DSC Caps from dm

George Shen (5):
  drm/amd/display: Parse RECEIVE_PORT0_CAP capabilities from DPCD
  drm/amd/display: Add DP required HBlank size calc to link interface
  drm/amd/display: Add expanded HBlank field to dc_crtc_timing
  drm/amd/display: Add HBlank reduction DPCD write to DPMS sequence
  drm/amd/display: Add 6bpc RGB case for dcn32 output bpp calculations

Iswara Nagulendran (1):
  drm/amd/display: Add VC for VESA Aux Backlight Control

Karthi Kandasamy (2):
  drm/amd/display: Update dc_tiling_info union to structure
  drm/amd/display: Ensure correct GFX tiling info passed to DML

Martin Leung (1):
  drm/amd/display: Promote DC to 3.2.315

Natanel Roizenman (1):
  drm/amd/display: correct type mismatches in comparisons in DML2

Peichen Huang (1):
  drm/amd/display: have pretrain for dpia

Roman Li (1):
  drm/amd/display: Add check for granularity in dml ceil/floor helpers

Samson Tam (2):
  drm/amd/display: fix init_adj offset for cositing in SPL
  drm/amd/display: Clean up SPL code

Tom Chung (2):
  drm/amd/display: Fix PSR-SU not support but still call the
    amdgpu_dm_psr_enable
  drm/amd/display: Disable replay and psr while VRR is enabled

Wayne Lin (4):
  drm/amd/display: Add support for setting multiple CRC windows in dc
  drm/amd/display: Extend dc_stream_get_crc to support 2nd crc engine
  drm/amd/display: Adjust dm to use supported interfaces for setting
    multiple crc windows
  drm/amd/display: Extend capability to get multiple ROI CRCs

Yihan Zhu (2):
  drm/amd/display: update sequential pg logic DCN35
  drm/amd/display: power up all gating blocks when releasing hw DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 214 ++++++++++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  23 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  31 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 240 ++----------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  75 +++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  38 +++
 .../drm/amd/display/dc/core/dc_link_exports.c |   8 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  38 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 179 +++++++------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  26 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  10 +-
 .../display/dc/dce110/dce110_mem_input_v.c    |   8 +-
 .../dc/dce110/dce110_timing_generator.c       |  32 ++-
 .../dc/dce110/dce110_timing_generator.h       |   2 +-
 .../dc/dce120/dce120_timing_generator.c       |  34 ++-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |  80 ++++++
 .../dc/dio/dcn35/dcn35_dio_link_encoder.h     |  18 ++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   4 +
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |   8 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  16 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  12 +-
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |   6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  30 +--
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   7 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  45 ++++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  12 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   2 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  14 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  41 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   4 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   8 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   4 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  61 ++++-
 .../amd/display/dc/link/hwss/link_hwss_dpia.h |   3 +
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  20 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c | 179 +++++++++++++
 .../drm/amd/display/dc/link/link_validation.h |   5 +
 .../dc/link/protocols/link_dp_capability.c    |   5 +
 .../dc/link/protocols/link_dp_irq_handler.c   |   5 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  33 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  19 ++
 .../dc/resource/dcn35/dcn35_resource.c        |   9 +-
 .../dc/resource/dcn35/dcn35_resource.h        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  99 ++++----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  64 ++++-
 77 files changed, 1356 insertions(+), 576 deletions(-)

-- 
2.34.1

