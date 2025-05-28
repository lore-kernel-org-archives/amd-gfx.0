Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD6AC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDEB10E0E8;
	Wed, 28 May 2025 02:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJ0fci8Q";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EFB10E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1l27dvHnkIki2S3yb8U0lDee+3y4IpSuGXHnYkP7pKRCdQvv+Qr2mS7/fVvK3bosqM1F8KHGJRRHyQn+7HazExugtkeYwf/3qcojxy04J8aZasMbb0Kmgewap0TFi9Syqthp1/tfcfTKpSdOPvhgQraYTI6IHaDeZbV405YWN0kJ0aEVSoAVx5R2w/VHpehV2n/sfxcaPgtua+RLS9TsSUl+O5NzUsVE87AI4azqmLMBOlyCOnm2N3CBZl1WixHNUs7uTGPBr36mjb8tX9uxVfIsj5lFfqxhHwgFHoX+NXroISshP7d0I1yYWieuYu1yn0BZ3wLHiRHYa9WGe7kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Y2dzeK0V1ii8dnoRj0BN1S1cIlbzs4e+4vpT5LZGk=;
 b=Bne1IHFevFeudCZGYVK3B6aeAqvxo8x0lnGLeFxRJVYhy0K3pBjjjjkeSJD1Z/wfNbm3Tgyq904Po+2VAaKUlSVgrCW+nEd5iVXJXw+sgbnWvodIA5744F5BwebO/bX+VZALT8wK1CvzFLMYPh5jTtNQYQgHk6AfPDZyXrO22SvQ9d0W0qLIa09n549dftYGcO/PfvyMUFg0sMqFj8Otq1tKkLUNo0pXpiEvGEUW9CxXDAhlPZabMOjQ1ydivBAs9WjxrjlP/ZKt/vkdvqWaJMbLTOVHd/mQabwb0uE20quQX9WQKXln3+j4FMQT85Fe3qQYb/ixAc35khEbH0SSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Y2dzeK0V1ii8dnoRj0BN1S1cIlbzs4e+4vpT5LZGk=;
 b=KJ0fci8Q2H+Kg1EyuO93xrrtcXIshsIFaLJXHciaDzVmHEERkrctRsR0R0Z+WRnP3pighWyHl3Bg/Ma1wNln2890GHx0qOe2Kq8fGwwy8wbE4Bp0afa0PIUTOoxluCakpXyfkHgqp9m9fTpWmuZXc0npqFCYsf9HzDNXzRnIA7Q=
Received: from CH3P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::30)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 02:52:19 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::c8) by CH3P221CA0018.outlook.office365.com
 (2603:10b6:610:1e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 00/24] DC Patches June 2nd, 2025
Date: Wed, 28 May 2025 10:48:55 +0800
Message-ID: <20250528025204.79578-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e3aa62-21e4-4cf8-57c3-08dd9d92a922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uaB6MlwM/G54GHq3wvKsGkt7x/qIIzzVAtWXtUG/jYB770uYLmgh8DVxH6df?=
 =?us-ascii?Q?IrQEgTaC4Phf9dZh4IfhGcHeU86FFXocxLyPiuFQh8TeyEbwidDC8E4ybBXZ?=
 =?us-ascii?Q?ezRnYMffw2saIzAs/MkXwG53nxAY+GbRnPtHEDs66fSfEMbO55JdhcVFP8q+?=
 =?us-ascii?Q?kRhbBiOuFr4rp6eofEBbnf3RnLqXYkAA8PdMJ3ZMTt4f22fkHHUJe9x3MPEL?=
 =?us-ascii?Q?3bdxjPykUhwMd6L3H9Tr0wc44zpvhu61TkCm3nyr1F2QW13H9ZhYRRZfEg9H?=
 =?us-ascii?Q?GV+kAM5zNYr1EpMaMsM0mDgeuGe7DTnlD0KVQjJLGwnSYqdmH02f1qZL0ui6?=
 =?us-ascii?Q?MGp7T0Ws4WqhvfqI61ps8+phLieU+vNvKgYmY4RLOUtZW7jy6GlPtzqF1q3N?=
 =?us-ascii?Q?CZuxZ3rZikGkgNdGC5+qrBJtYZkDxihIMs6pcRJPuSREnvVuUSfGo+H/vQRU?=
 =?us-ascii?Q?thrCREE5/fuAyUxyhzVzjYTH+e+Uze8NFvfoJVxrdDI7cSJCA9vWQAg0/Pcs?=
 =?us-ascii?Q?t88edP+gDBciz4gDUmg3koPfvnpEZOHh++zY8FGRjy6H//RFCVTe4aQ26WoG?=
 =?us-ascii?Q?l9tyGikHTtfZsQWYTmcgi4B13ju+Hs28Dc9EAMq64xW7Z7vF3W4kHHw3Bmxv?=
 =?us-ascii?Q?Ej/uiQO6oKaXMV1HJebUKt27z+FvH3gE1J6qU8aPYp9/nyIeGOMSoo5m0N9T?=
 =?us-ascii?Q?vOKTVhuo/FFPr3LKaA8CCfuol1AoanEKRbRix7aNThu6URYrXRqLIfx3WWCw?=
 =?us-ascii?Q?qi4QoJQDo9FshpsE0IdFAf/zK0iJYeAWa9qkxbAxcCS24qsGgde1oQyS+mqn?=
 =?us-ascii?Q?spN7vriDTFivGaax2hynzETq1L+C/C4t4A+eJ3+UnAZfXsHxeu4v2RlSOhjk?=
 =?us-ascii?Q?zmbE1ViU8nBJbDCHDCKq99rs1Tl7PNbLIm6VPrts5Ta5Sf0F3yuTope1Ligw?=
 =?us-ascii?Q?O/EjykoWb3lyZw8Adsj4o+mVIH7kzNflNcHOELbwgcO+qDn3pQyVHo0ESO51?=
 =?us-ascii?Q?lPxcCi0kDrazlk6y5Snk1hCCzgQ8wW1pt1l7dvQB7zONN1dOn0hTQnN7Y6wJ?=
 =?us-ascii?Q?RpJnJR3mUkOkRQplpvd5bhCcOELa3EULgijyIo8g2Oc10ZYzB6vg29gpSBFd?=
 =?us-ascii?Q?miKLuiStfR0D58paOGnfSkNxuq/7e0v8Ue1EAEFaCYUqk8CsvhoSoLrU4z4C?=
 =?us-ascii?Q?0pu0Wo5/M5vutKJNR8YPNU58gjvIdD9Tl+5ZSdvOl5GXF4DDNTILL3OWBIu5?=
 =?us-ascii?Q?2DRmQ/GAZJR1EKoD2IK91frG0dNirgFwbwhoO2X9G2/j9xayExsStGSlXjSy?=
 =?us-ascii?Q?PH2pYDIkmGTxdA2flENqfO9gfMBI9o8tapfH6iCjymID7HSvFp8jX6qBCfKr?=
 =?us-ascii?Q?6WR43FHhL0y149NkcB83zeaimpCG2kQH9UsnQB9dX2GXy3sz5VLI4PoYkaJi?=
 =?us-ascii?Q?EGtpJzZgDFM/dM9IDLGHj63dHW1hwESKo9F4EKEoQews+f+JRc354Sje3y1W?=
 =?us-ascii?Q?UzcYZDQk7xk0HZ/V/Leq1ssvbcn2OciPdjB3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:18.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e3aa62-21e4-4cf8-57c3-08dd9d92a922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

- Fixes for DML21
- Support OLED SDR with AMD ABC
- Indirect buffer transport for FAMS2 commands
- Correct stream attributes setup timing
- Correct non-OLED pre_T11_delay
- Optime boot-up consuming time
- Add support for 2nd sharpening range
- Fix on chroma planes scaling
- Fix brightness relevant settings
- Fix calling blanking stream twice
- Extend dc mode validation types to support more scenarios
- Update DMCUB loading sequence for DCN3.5

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---
Alvin Lee (1):
  drm/amd/display: Re-order FAMS2 sub commands

Austin Zheng (1):
  drm/amd/display: DML21 Fixes

Camille Cho (1):
  drm/amd/display: Support OLED SDR with AMD ABC

Cruise Hung (1):
  drm/amd/display: Use DC log instead of using DM error msg

Jingwen Zhu (1):
  drm/amd/display: Add disconnect case on dongle check

Mario Limonciello (3):
  drm/amd/display: Drop unnecessary `amdgpu` prefix
  drm/amd/display: Add debugging message for brightness caps
  drm/amd/display: Fix default DC and AC levels

Michael Strauss (1):
  drm/amd/display: Call setup_stream_attribute after stream enc clk is
    ungated

Navid Assadian (1):
  drm/amd/display: Do not bypass chroma scaling in 1:1 case

Nicholas Kazlauskas (1):
  drm/amd/display: Update DMCUB loading sequence for DCN3.5

Oleh Kuzhylnyi (2):
  drm/amd/display: Indirect buffer transport for FAMS2 commands
  drm/amd/display: Add DML path for FAMS methods

Ray Wu (1):
  drm/amd/display: Move vmalloc include to header file

Samson Tam (1):
  drm/amd/display: Add support for 2nd sharpening range

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.11.0
  drm/amd/display: [FW Promotion] Release 0.1.12.0
  drm/amd/display: Promote DAL to 3.2.335
  drm/amd/display: Promote DAL to 3.2.336

Wayne Lin (1):
  drm/amd/display: Avoid trying AUX transactions on disconnected ports

Yan Li (1):
  drm/amd/display: replace fast_validate with enum dc_validate_mode

Yihan Zhu (1):
  drm/amd/display: move RMCM programming

Zhongwei Zhang (2):
  drm/amd/display: Correct non-OLED pre_T11_delay.
  drm/amd/display: Avoid calling blank_stream() twice

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  48 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  47 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  59 +++-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  10 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  45 ++-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |  12 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  30 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.h    |   2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  14 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   9 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h |  11 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |   1 -
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   7 +-
 .../src/dml2_core/dml2_core_shared_types.h    |  82 ++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   3 -
 .../src/inc/dml2_internal_shared_types.h      |  10 +-
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  11 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  11 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 292 +-----------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   8 -
 .../display/dc/hwss/hw_sequencer_private.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   9 +-
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../drm/amd/display/dc/link/link_validation.c |   8 +
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../link/protocols/link_edp_panel_control.c   |  21 ++
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   3 -
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   2 +-
 .../dc/resource/dce110/dce110_resource.c      |   2 +-
 .../dc/resource/dce112/dce112_resource.c      |   2 +-
 .../dc/resource/dce112/dce112_resource.h      |   2 +-
 .../dc/resource/dce60/dce60_resource.c        |   2 +-
 .../dc/resource/dce80/dce80_resource.c        |   2 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   4 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   8 +-
 .../dc/resource/dcn20/dcn20_resource.h        |   4 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   8 +-
 .../dc/resource/dcn21/dcn21_resource.h        |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  22 +-
 .../dc/resource/dcn30/dcn30_resource.h        |   6 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  18 +-
 .../dc/resource/dcn31/dcn31_resource.h        |   4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  14 +-
 .../dc/resource/dcn314/dcn314_resource.h      |   2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   4 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  26 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  31 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   2 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  28 +-
 .../dc/virtual/virtual_stream_encoder.c       |   7 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 204 +++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  16 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 80 files changed, 771 insertions(+), 577 deletions(-)

-- 
2.43.0

