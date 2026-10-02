Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688CDCA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F322D10E69D;
	Fri,  2 Oct 2026 19:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YHhLeTR5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEC410E69D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4tPT5Sw0bCiTEA+7HtjTyUMB44LFh+USrqO1YzOp0h/Pyemfdfy6otI0Qpj1exd50F+rQlu+9taDQ22c5ed5zYKIiVypYEPno2CBHVgpmGcF2+107ooVp+QFJKLUHVv/dHNn/X1rcO4sjnUqPBhVZoEpgdVcl6TjKNq9L7F0m2+00NI2xWEfFvlaEqbtgsqmJgAyXnGPrVoe7We34k005p3AnBgS2kBTALUhz55OH7Akvs93nzzAD6ADfmneDCEKPsmmOgjq7/mmtjMD/4B+8pVBsDOX/Ae4ZU4PesuG129LKfxTkoc/So12uIa5dv+sWsIR6OpbOX7jTpxsLhVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc28O5YCzbu6em0Yqwo3J44BEfXh1SIyYXEMsINjNYg=;
 b=b8LZ1ADU3YMmxuz5jKI9x3BLNFv3IuVhsmg12cf2iBpkApn6GrOj/jGBpvxvdSmN4kARkZEraLFI8bpeq5h4DH0eOk7w+rW16sOh+mLrmIajquUMYhl+oWzrAIX6Mkbpb0mUigNZvKSkhCVktCFLip8dNHN/AixrPudNG1I6smHGVsM1Kh08Qoq0Eg4jhZ484dGRulOEF+jSq0RSqwkwvylWX9RbRFsISvkRUoMa3dXNI+PcxFcqWOkaWv2g7jhpREWJKnq38bgKNH/HdDsTRdYL5xNXszwKNTye27emnwJribeNIsiK/rzfWTzd+aRp9UhFH+ZkKI/7oEgPK0B4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc28O5YCzbu6em0Yqwo3J44BEfXh1SIyYXEMsINjNYg=;
 b=YHhLeTR5H8fAJIoj4q+2kQFTUDFcZss3lBdBsyLcAOxN4Qmbe6T3HEdxrWrKF3wl5NjPQDyX1iJapStPlmYId+AgowfifDpX1oFH4Y4T6qTji2YU/ZfRy8nqzUWN93101LRK2Y6R2u+5PHl8x8ltErS7W/2fBeTI0oxIMTHHPOQ=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:33:03 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::21) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:32:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 00/17] DC Patches October 2, 2026
Date: Fri, 2 Oct 2026 15:32:23 -0400
Message-ID: <20261002193240.3441018-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8847c581-79a2-4f8a-2c81-08df20bbf990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|56012099006|11063799006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: /t+fpSV1jtmtoI+7cggi0i4ndhcOgK/lVqrHeD17CaFUvolxDBx9YYhopbVV8IyJU9aHvtv3zQdwo+oFmIuVdNZNtI35UD6y6eRExms5/DjeaSMW4RoBe0dOssChF2CqWR5BPPdser7z7t9H6G5dNRVvwAraG1W6OwoNe7VCOaXS5JjnIO9TyUDgkdlRHN9bNVKnG+r9ke6RsyE+I3wQktlCnXSoXOv36hqBFWdWanCucFXXth78Ubpn1af0sYPRmYdMWVyEMnoGTYLhXkS6lWyXbpCS2psdI4Q5p1oQTwEk6ImwFKPknyMsVHS18DVz4p66bzpQw8wF4xCGHr5f50gDB0Jc+yebG+hyaOW4c5tI9iGkiMD6vy7CPujjyMCkA1q0zR2z55otTsoOO9k3X3qfiL9pJpoU2xUEqDuQfbqqwaAynMEYKTQO0vRmebGY7g+SYxuADowC3J3EQYiWsXcQSJ/j1w7lQfsgcp8Aqcmjo3dU1kenSdpHaJnRNBtpS2T3od5o+TAbf0+ds+Dt1HxMy6SeZ0BFcWnjd4KRnJa4d6oDRWWGEtaef3MFmG34WUwI4DBDz7wWbWomApF2Mq/VMC7FX7VZ7lRfUZMiUwxvYjCZLJ+LsP2WH0eB/KqS4KNG2AwrSF8qkTilq1CpIDP0KZ73tYkpCVXvljtcVASgpayTjdhLfF1a3hS0lDh7SAyyHFSoBmtr8xHQ+E1cCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aGIxQGCUGf+OD0wQWCgxkHqGqnfFlrBmePcD/JhU6xej4Qr1Mxv8GB5LDnJBmG+Ys7yfaSma9dXmK5IEhYvGY3gNGSa1XvLapDdpyIiiyOMvlUl6LfUJGCVii403nxBSOqt7RTdvRPc3wPOcRvvd31giFixPszV456+xfVmNQsgIxOtZIHmtuXrDjgs+bCzutKltHLR9/VVe+Fh7FnxARTwh2iOBJGOq64w2u6CTuLb393xO8Mbj1IItUzktLzXv/vN7DUJomUryl8SmoGHDoe0xAWLWVUWIXINGl/9OCrit47mvMYrAMGYgiJ84KnWpnG7k4zDFXmNps95in1ibkIpEDTzDmKJigGJ7wRB/2O2aT9InHX1hgUlWm2mpTmA9gpq/i+r7a5ez3h8nxMI+7P8AMMP/1npfviYreLd246hCPWaeurUjEQyobnVva2bl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:02.7403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8847c581-79a2-4f8a-2c81-08df20bbf990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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

This DC 3.2.401 patchset brings improvements in multiple areas. In summary, we have:

* HDMI: RR and SCDC skips, link-training timeout behaviour, VRR metadata in the
  VTEM info packet, and a TMDS output regression revert;
* MCM shaper/3DLUT programming and DTN logging improvements;
* DMUB: fast-lock sequencing refactor and FAMS2 command update;
* DSC configuration preparation and DRR reprogramming optimizations;
* Replay/low-power, eDP link-bandwidth, cursor offload, and virtual link
  encoder handling;
* New DCN42b project ID.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Allen Li (1):
  drm/amd/display: Skip link off frame count for general UI

Alvin Lee (3):
  drm/amd/display: Set cursor_offload for all pipes for a given stream
  drm/amd/display: Assign alt wa bit in fams2 cmd
  drm/amd/display: Add debug option to override low power SR latencies

Aric Cyr (1):
  drm/amd/display: only reprogram DRR when v_total values change

Ashwin Santhosh (1):
  drm/amd/display: Promote DC to 3.2.401

Dillon Varone (1):
  drm/amd/display: Add dcn42b project id

Harry Wentland (2):
  drm/amd/display: enable shaper when programming 3DLUT
  drm/amd/display: log MCM shaper and 3D LUT mode in the DTN log

Ilya Bakoulin (1):
  drm/amd/display: Add HDMI RR and SCDC skips

Ivan Lipski (1):
  drm/amd/display: Send HDMI VRR metadata in VTEM info packet slot

Joshua Aberback (1):
  drm/amd/display: Revert "avoid to write signal specific for tmds"

Martin Tsai (1):
  drm/amd/display: allow skipping link bandwidth clear

Rafal Ostrowski (2):
  drm/amd/display: Refactor DMUB fast lock sequencing
  drm/amd/display: Prepare DSC configuration before BLS execution

Relja Vojvodic (1):
  drm/amd/display: Update link training no timeout behaviour on HDMI

Sridevi Arvindekar (1):
  drm/amd/display: Handle virtual link encoder

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   1 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  26 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 101 +---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 522 ++++++++++++------
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  36 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  12 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_cga/dml2_cga_factory.c     |   1 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   1 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   1 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c |   1 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  48 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  13 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  34 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   5 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |  41 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  99 ++--
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  12 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  67 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  16 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 108 ++--
 .../drm/amd/display/dc/link/link_detection.c  |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  17 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |  17 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   1 -
 .../dc/link/protocols/link_dp_training.c      |  20 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |  12 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  18 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |  39 +-
 .../amd/display/include/link_service_types.h  |   1 +
 .../amd/display/modules/power/power_replay.c  |   6 +-
 59 files changed, 853 insertions(+), 563 deletions(-)

-- 
2.34.1

