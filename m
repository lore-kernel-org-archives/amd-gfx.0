Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3FBC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D704A10E469;
	Fri, 14 Feb 2025 15:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="09jAph6Y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF8410E469
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmW8tZIQ5zlt5dvlmym9BfsLkqeXlrABjznFhrVZx6Deb+4o6vOPLI0k0kgcrHm1bgJ2Fe0B4kfHsDqHHHL0GO/+5pbm2OPyiYIiYzyn0TG2ahcuEDf+yqCRMLjfvLUmKTPQibauY/VPX7Ol791QAoKQb0lZXWBYjWNvLHvfgeg9mUUmenJO1auQX9XYraO/fRxlCGD/Z658mLD3OWzlnl4i1hWLAblV0DJHTs0Tc+A2B/SIj0nU+n4Ef3U6HNvw6gMW3JNS8H5np/nQKrnVGJRgc1AZT7PqWUFA2hjPylsJRftikQhJ0WOG5PVN6jlvMrejZcGgtNDoMBpmGogzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyCQwqHftL3xOsZulO6OrwQt5QVoq66puaMm4bLixzw=;
 b=eMVkZufogajEj4swTut1cdT9jV0xfrJGRaxNTLrxg90EvH46+0igjOJhM8r5igKhv7zhZwwLZqoxWs/Ai915CaQ+pgwF7x6trJB9p2vCt1FvDXFItCGh5uxXZbeZ1ar+uoxzrHXjIKHZPcimrPZnd/rqk+kxw3YaKWLaKUomtCFMZ0NKIxTnP90dXZbcFj8rabN4pPcIf9C5Xrgt/GD12npayyUK0Plynv0pKP6RdfhOtIQAj6uVqTI3yL0Umy047ci91ulZwtXZ7/1DJfeawXF06MALSFxXGNDfaW6eGUY8e8Eu9Gu5KfoysTDyMYmd0cgRu+0dYFU4M8YOzooPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyCQwqHftL3xOsZulO6OrwQt5QVoq66puaMm4bLixzw=;
 b=09jAph6Ya1eV8CEsL4ty1Oh9s2jDyayEaSpAhfIKwmhwtrZ4GAeSKIgmRE+E1juVT++5tz0G79NeHnsyKFn8fW5upysi1oSCZb7Rr2dMu/d7Tn0OxytN7UQG1gvHMi4WdV7DgE4k7YNRgvOGJcaobAWgxT0aI8ZbxLqsSenprd8=
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 15:01:31 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d8) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:31 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:25 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 00/16] DC Patches February 14, 2025
Date: Fri, 14 Feb 2025 10:00:17 -0500
Message-ID: <20250214150033.767978-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b21f39-9cf0-499b-976b-08dd4d08776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9zTfezZORNVcE8/xKbLALU+NJ0jiOzL5zNsXWntcunmqu9PmCcdu/ynN1vqC?=
 =?us-ascii?Q?LSUIXPpk7WwQ5qd00scQKYRH7/2gyiLaBUX1LOD51vd+K4JJufAs0Upqsne7?=
 =?us-ascii?Q?5JPaZtdgjsk3FTJKNEdu5+w0p0qabPSLSs+Yyx/We3A/3NVVcKXCkoYFXigP?=
 =?us-ascii?Q?mrWZr/XGdnY+ucSoQeJEZVzzNaNoxoga5EF2RGRgNf9w+c+Rfqc0jlXGqzph?=
 =?us-ascii?Q?VN0iSck7a6KC2vMP4sQntwXB5BxrI2uUhGVyG9ox/qzAk393h4XbEWM9WsL3?=
 =?us-ascii?Q?fQ8K7kqbiHVS0vw+Yj4t/k/5VxH0kr3lrsqw/8oKVEdWVc0pDjr5g1dzwzRn?=
 =?us-ascii?Q?PdoD2p58zyIpqif5By539eqHytBYg8S0Oyq90den5BEV67a/81dLcQ94pf6W?=
 =?us-ascii?Q?6dLNpQv/8OwwLO2+trnOn8OVu6FEylCTXmd8zJzlMxPPA2RSTPMK1fPuPlSE?=
 =?us-ascii?Q?PrIIDmwDPKLzQFtrStaiWqlc+nj8w9/mGCjjGzIe/XARuIKZwDhXiG09Dr1T?=
 =?us-ascii?Q?Oj63InCTgD1pdIKjkB/gTFDuLRYy5jzFGLQm5t2+nbKcooChFE5Nkm3kuumw?=
 =?us-ascii?Q?gX1Aotq4KfnbOguRvE93WaP2GHmZAA0DndHbQd2P/ZI3Vj+ciWFuGvpi/qCy?=
 =?us-ascii?Q?3oV3HwYyxZ5lvALyjoC6lfuiv3+NMAbxZ3n/StUWGhPb5yzV/GiwORrKZ8PJ?=
 =?us-ascii?Q?FF4nsSVIHLroj7z98j1fUdJ2nRPiwMgPJpK0p9RAORIUAUs9pEgbb6lpSac0?=
 =?us-ascii?Q?Rqp7MhgVIlSzYOL3semdh3wV6QsC5gfd4ioJK6jLV9JHCV64ayZ268Fxken0?=
 =?us-ascii?Q?sIgkfxpbN9Ln6XAvfFKEgxL5BTtsNhTCHXKaJ9jB5qyZB8LlRG1UAv45FXZL?=
 =?us-ascii?Q?LC7LWQh2BXE+BfZp7JKm1+dDAudpph3Tj7facczjxrFwlFLA0jDxzljl1JbZ?=
 =?us-ascii?Q?e9ZGrmeZ+19DIUFUcY9GZTwygxWidjKAHLVxmaqkWxNRKOcAlTEcmNGDn/Q6?=
 =?us-ascii?Q?Y3SD2vNjC3BEnJhSeJxqebdepuNQ2ZrY0mH/rhwnjc7rPCBEeLaDm7NK4DfH?=
 =?us-ascii?Q?A3U0YBNIgP2YDEBQvJTdXU6fcHiMGvXPyiGw0arQBnww725ETud8gm89pkUp?=
 =?us-ascii?Q?4diz8+tpKdppSKd6bOIF9r5GUFq6fRaNf9CBbBEi0lDBJ/Isr68QOckDorOW?=
 =?us-ascii?Q?DwNN7jibiYY1KQMq2U1Mtq609KDl3fUY8HufTfzrchh7XXKruAL+xPNxM4fx?=
 =?us-ascii?Q?K+r96aaAnXT8W/jzcemQ1V64bUnUuSTuEYtlEyUbE10LVrZFAm0ke3m2su0N?=
 =?us-ascii?Q?w9JVSsMt5Aj29X2E7piRh4auyT1c7BLrhbDx0f0Th67XA0ImJZYQAKBiM6ar?=
 =?us-ascii?Q?gTVtjf+VrLSDfKocE7zdP7jH/Ad+WeHCKG8VOUOOgZ0D0FpjyyOvh2aFTi6c?=
 =?us-ascii?Q?Cad12A2PAyJSxeY0aAc6nhtjD8piEzLGVcJE+JXmlQ9/QADKr6RNRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:31.4510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b21f39-9cf0-499b-976b-08dd4d08776e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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

Summary:

* Add support for disconnected eDP streams
* Add log for MALL entry on DCN32x
* Add DCC/Tiling reset helper for DCN and DCE
* Guard against setting dispclk low when active
* Other minor fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Print seamless boot message in
    mark_seamless_boot_stream

Aurabindo Pillai (1):
  drm/amd/display: Add log for MALL entry on DCN32x

George Shen (1):
  drm/amd/display: Read LTTPR ALPM caps during link cap retrieval

Harry VanZyllDeJong (1):
  drm/amd/display: Add support for disconnected eDP streams

Harry Wentland (1):
  drm/amd/display: Don't treat wb connector as physical in
    create_validate_stream_for_sink

Ilya Bakoulin (1):
  drm/amd/display: Support BT2020 YCbCr fullrange

Leo Zeng (1):
  Revert "drm/amd/display: Request HW cursor on DCN3.2 with SubVP"

Nicholas Kazlauskas (1):
  drm/amd/display: Guard against setting dispclk low when active

Oleh Kuzhylnyi (1):
  drm/amd/display: Add total_num_dpps_required field to informative
    structure

Ovidiu Bunea (1):
  drm/amd/display: Exit idle optimizations before accessing PHY

Peichen Huang (1):
  drm/amd/display: dpia should avoid encoder used by dp2

Rodrigo Siqueira (4):
  drm/amd/display: Add DCC/Tiling reset helper for DCN and DCE
  drm/amd/display: Rename panic function
  drm/amd/display: Add clear DCC and Tiling callback for DCN
  drm/amd/display: Add clear DCC and Tiling callback for DCE

Taimur Hassan (1):
  drm/amd/display: 3.2.321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  2 +-
 .../gpu/drm/amd/display/dc/basics/dc_common.c |  3 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 13 +++++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  5 +--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 16 ++--------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +++--
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 31 +++---------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 12 +++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  4 ++-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  4 +--
 .../amd/display/dc/dce/dce_stream_encoder.c   |  3 +-
 .../amd/display/dc/dce60/dce60_hw_sequencer.c |  1 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |  3 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  3 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  1 -
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  4 +++
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  5 ++-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |  3 +-
 .../amd/display/dc/hwss/dce100/dce100_hwseq.c | 30 +++++++++++++++++
 .../amd/display/dc/hwss/dce100/dce100_hwseq.h |  4 +++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  7 ++++
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |  2 ++
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 29 +++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  4 +++
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |  1 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |  1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  6 +++-
 .../dc/link/protocols/link_dp_capability.c    | 12 ++++---
 .../display/modules/info_packet/info_packet.c |  4 +--
 47 files changed, 192 insertions(+), 87 deletions(-)

-- 
2.34.1

