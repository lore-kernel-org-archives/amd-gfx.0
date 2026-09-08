Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0CEC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BB910EB1B;
	Tue,  8 Sep 2026 11:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iegLFatq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7CB10EB1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPd17s5+DfMda0YrN/o2yd3s+gohZFyKPkZwImOBuDPY9JTBxmZ5LkIwaRUTeLyR+NfzIRRZTnuPvlty1MC5DfLiLOecu8+0WbKRrw0DgzVKkGMXW4TAXtqkhwziJwCmzK9JYqo5mzxSG2ps8U7G/bFtzxh63PFyDhAkj+Bqx3ixLUnMpT8QmElHyinDbFyhUC3nGd8RAC4VwbLX5AGBAu0WtjFsc4EkTjQ9RLA6QsTvNEUDHK0qNLBSaMfme4h90fucyr5meWSKeC4XDaJNlMGi8B/KF3gPIhhH50Gz+PXzNFwHS7TTkQT9RJu5SdK/5PJ88fr1QxSWc9kNEC07NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vWxLR1J92mHTDpucW0DFILxwi5vcuNHMbVto86JNVA=;
 b=b9e20qcurPKb4mJV6G4ssd59KNo13XzuTEiD3yhY4ytMOOrj+qpINGw4x4CfsI8//PepZvvbBTeue+6Iduk+48vYqX2fZWpVSmgiqdJqUg5E34S4XIQi3FsqDdEbQaFECJoT7wdjMph2P5w2RfTkADwp9+pfYE8jg/MtM33yzhzRWycPp1ic23qt8Yo4UXtyFm3K+ZU/hqhpEKg305L5V0+LRrJnfBIi6gnkJ2xDLCyAymSnCaDloWEAWxoB8kUwOJuC3CGCir0ss4LDbl2Lz4yaHEQKADVMI6W1w0PqjZNPlqGMPcs0OtcorrJ020yUiifI+0mJQ7JiI9QJtc9+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vWxLR1J92mHTDpucW0DFILxwi5vcuNHMbVto86JNVA=;
 b=iegLFatqMPeum9/4UAkiTaDlKQeH45GclQFm+PEcKu0inaNfEbtx8Mmh+gFtWBbMox6PhJS/iBaLczKS+GFkph0PPCiCHFXC3yjup1sF6LcQqq8LIhAtsKPVaVu1iCgsqEAc6YhB/O3JYjscnYaBV/J6stO1utqGVqhfI+J6IMA=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:34:33 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::80) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:11 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:03 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 03/66] drm/amd/display: Refactor RMCM into a separate module
Date: Tue, 8 Sep 2026 19:30:56 +0800
Message-ID: <20260908113338.2433445-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: a49ed38b-0bf5-44a0-7c31-08df0d9d274f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|30052699003|82310400026|6133799003|3023799007|10067099003|11063799006|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4LrkkpdGKU8PfnV8QDY+Lu33L6tT9LgdswMyO6dF01fcreGXXDav8f9RANMNo1eYZ9R+uqkqskYhvE6I0d2vAWMUXj8qR51gO+SD36NMeUskz+fGE77QTsEheN5V4Kd+23gLILOsbTbGkYB2qk50iwY89P4EhE1FO7Me3XXH1Ku8YBXeOX3UEWZGkgZ8yBQ+dlgI0JHEIgImLhzpXnkX33worr/JM1YLv/YtgPU73biLqb305lEYnINBBt6SqrYHfnt/GjqAcX8T3FUM9VSFf2r83N4YLW8s0sRuMmETncpTgrpUO9bgK+Ggx6TpMuPxfm2EmYkRhtToiv/7vGol4YPv7fEnR17xLddBlSCUIACFOQRP4EPh3zi69yl37GO0R2nmTvqQzA2gfBTWVZ4zyGjliJQVUqx7Qq70GGg+LnUi0/U+hBVlWrkm60ecoWI99CSWOlo/hQayXApVG/qxytAN/M4+nXoeSGU9lZpM4QztdnZg62ZGGmY4NTQFFi8sTJmAmq1DRBTyGOykkzkT2xTA6ZbKdWmoqbdRT+j0NsrpU4cxFi71tZ3hEgHpVedG2UPmKsJVvLscEJ1K2OQ6qVjn5q5su8X+786gEOITYaZpSzPNJguFKD+f86t/iaUjtpUsHS4JTzVA/CKux67yiDxY7fkcwqV6tfzfaKf2rLJrrMI8hzf9duIOsZpIXDsHPy3q6vwIMiTf2ybUyis1ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(30052699003)(82310400026)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UoC6UHw4drmN4HB7jE9cQ4LwYjLSMlNy56u5Ycj1sX+G1ELE8MTLP+QHSOPXfuU8gU53hZM7ffGEPsJHgIcaSRW/bGfCeVhyhpIYidDi16OjWGpmM7rdU+C+CB207FzFfF6n8W9oKkW+WB+eS0fmcq0qCGl80A7ByzMWxWLmDN8AMcVZduiUFVxki4TMaiPpmyD2NvTFoUWF1IU7P0gz63PfXFniW67UfpNLX3O7N6YJgnceL+QyiQPPj+//6Xe3nn190fhZVAcXRlcKpHLPr54uihVdMdSiNmDnlbx6DqF+WG+S+qHpfDxoFDUiqLxq1tf6jyrA0W+RNq7MqJD/Suio+/SFX44CZlmAKIPEYjFrX5kDh+SIGF0jghy1BgthD5UrGi4ZNP+W7Fe++RT97NtpA/tjc0m7N4yJstuI6cK/tgclEuKDJyIDLqvzSCcc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:32.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49ed38b-0bf5-44a0-7c31-08df0d9d274f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[WHY]
The RMCM logic was embedded inside the MPC block, sharing its source files,
functions, register definitions and other logic. This tight coupling
created several problems:
- The RMCM vtable was bolted onto struct mpc_funcs, making it impossible
  to instantiate RMCM independently of MPC
- RMCM resource acquisition had no tracking - there was no mechanism to
  allocate the 2 available RMCM instances to pipes or release them

[HOW]
RMCM is now a separate module:
- dc/rmcm/ directory with per-ASIC implementations
- new struct rmcm with its own funcs vtable containing shaper,
  3DLUT, and fast-load operations
- removed all RMCM code from MPC
- added RMCM resource lifecycle management in dc_resource.c:
   - resource_assign_rmcm(): Assigns the instances for a whole context, so a
     plane that is only now asking never evicts one already using an instance
   - resource_release_rmcm(): Clears the pipe's allocation.
- updated resource pool constructors (dcn42, dcn42b, dcn60) to create
  RMCM instances via the new dcnXX_rmcm_create() and destroy them in
  pool teardown

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 -
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   7 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 101 ++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   2 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  66 --
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 -
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   1 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  65 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  22 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   4 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   9 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 270 ++++--
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  15 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   5 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 122 +++
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   7 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +
 .../display/dc/hwss/hw_sequencer_private.h    |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  64 --
 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h  | 140 +++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  15 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 679 --------------
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  | 714 +--------------
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |  40 -
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h  | 238 -----
 .../dc/resource/dcn42/dcn42_resource.c        |  56 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |  57 +-
 .../dc/resource/dcn60/dcn60_resource.c        |  17 +-
 drivers/gpu/drm/amd/display/dc/rmcm/Makefile  |  44 +
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.c    | 867 ++++++++++++++++++
 .../amd/display/dc/rmcm/dcn42/dcn42_rmcm.h    | 717 +++++++++++++++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.c    | 251 +++++
 .../amd/display/dc/rmcm/dcn60/dcn60_rmcm.h    |  35 +
 41 files changed, 2711 insertions(+), 1962 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 0084a8d55254..96242bb2f97c 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -42,6 +42,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dwb
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hpo
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mmhubbub
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mpc
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/rmcm
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/opp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/pg
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/soc_and_ip_translator
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 6ddf4cbda714..27d60493254f 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link dsc resource optc dpp hubbub dccg hubp dio dwb hpo mmhubbub mpc opp pg
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link dsc resource optc dpp hubbub dccg hubp dio dwb hpo mmhubbub mpc opp pg rmcm
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5b9cf0bb10a3..8e8d221c2bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -993,8 +993,6 @@ static bool dc_construct_ctx(struct dc *dc,
 	if (!dc_ctx)
 		return false;
 
-	dc_stream_init_rmcm_3dlut(dc);
-
 	dc_ctx->cgs_device = init_params->cgs_device;
 	dc_ctx->driver_context = init_params->driver;
 	dc_ctx->dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 4b8af67ff4b5..7262596c470e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1489,7 +1489,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 
 				if (current_mpc_pipe->plane_state->update_bits.lut_3d &&
 						current_mpc_pipe->plane_state->cm.flags.bits.lut3d_dma_enable &&
-						current_mpc_pipe->plane_state->cm.flags.bits.shaper_enable &&
+						/* RMCM drives the 3DLUT without a shaper */
+						(current_mpc_pipe->plane_state->cm.flags.bits.shaper_enable ||
+							current_mpc_pipe->plane_state->cm.flags.bits.rmcm_enable) &&
 						current_mpc_pipe->plane_state->cm.flags.bits.lut3d_enable &&
 						current_mpc_pipe->plane_res.hubp->funcs->hubp_enable_3dlut_fl) {
 					block_sequence[*num_steps].params.hubp_enable_3dlut_fl_params.hubp =
@@ -1510,6 +1512,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 							primary_dpp_pipe->plane_res.hubp : current_mpc_pipe->plane_res.hubp,
 						.ipp = current_mpc_pipe->plane_res.ipp,
 						.mpc = dc->res_pool->mpc,
+						.rmcm = current_mpc_pipe->plane_res.rmcm,
 						.mpcc_id = current_mpc_pipe->plane_res.mpcc_inst,
 						.stream = current_mpc_pipe->stream,
 						.plane_state = current_mpc_pipe->plane_state,
@@ -2368,6 +2371,7 @@ void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state
 				primary_dpp_pipe->plane_res.hubp : pipe_ctx->plane_res.hubp,
 			.ipp = pipe_ctx->plane_res.ipp,
 			.mpc = dc->res_pool->mpc,
+			.rmcm = pipe_ctx->plane_res.rmcm,
 			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
 			.plane_state = pipe_ctx->plane_state,
 			.stream = pipe_ctx->stream,
@@ -4644,6 +4648,7 @@ void hwss_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				primary_dpp_pipe->plane_res.hubp : pipe_ctx->plane_res.hubp,
 			.ipp = pipe_ctx->plane_res.ipp,
 			.mpc = dc->res_pool->mpc,
+			.rmcm = pipe_ctx->plane_res.rmcm,
 			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
 			.plane_state = pipe_ctx->plane_state,
 			.stream = pipe_ctx->stream,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 593c1fd537ae..b3889abab6b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3389,6 +3389,95 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 	return true;
 }
 
+/*
+ * resource_assign_rmcm() - Assign the RMCM instances for a whole context
+ *
+ * RMCM is pre-blend, so every pipe asking for one needs its own instance. Ownership is
+ * tracked per instance in res_ctx->rmcm_in_use[]; the owning pipe is the one holding the
+ * matching plane_res.rmcm pointer.
+ *
+ * A pipe that already drives an RMCM keeps it, so a plane that is only now asking never
+ * evicts one that is already using an instance - it simply gets none when the pool is
+ * exhausted. This has to see the finished context, hence one pass over all pipes rather
+ * than one per appended plane.
+ */
+void resource_assign_rmcm(
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool)
+{
+	struct rmcm *held[MAX_PIPES] = { NULL };
+	unsigned int p;
+	int i;
+
+	/* new_ctx and cur_ctx can be the same object, so snapshot before clearing */
+	for (p = 0; p < pool->pipe_count && p < MAX_PIPES; p++)
+		held[p] = cur_ctx ? cur_ctx->res_ctx.pipe_ctx[p].plane_res.rmcm : NULL;
+
+	for (p = 0; p < pool->pipe_count && p < MAX_PIPES; p++)
+		new_ctx->res_ctx.pipe_ctx[p].plane_res.rmcm = NULL;
+
+	for (i = 0; i < MAX_RMCM_INST; i++)
+		new_ctx->res_ctx.rmcm_in_use[i] = false;
+
+	/* incumbents first, so a later pipe cannot take an instance out from under them */
+	for (p = 0; p < pool->pipe_count && p < MAX_PIPES; p++) {
+		struct pipe_ctx *pipe = &new_ctx->res_ctx.pipe_ctx[p];
+
+		if (!pipe->plane_state || !pipe->plane_state->cm.flags.bits.rmcm_enable)
+			continue;
+
+		if (!held[p] || new_ctx->res_ctx.rmcm_in_use[held[p]->inst])
+			continue;
+
+		pipe->plane_res.rmcm = held[p];
+		new_ctx->res_ctx.rmcm_in_use[held[p]->inst] = true;
+	}
+
+	for (p = 0; p < pool->pipe_count && p < MAX_PIPES; p++) {
+		struct pipe_ctx *pipe = &new_ctx->res_ctx.pipe_ctx[p];
+
+		if (!pipe->plane_state || !pipe->plane_state->cm.flags.bits.rmcm_enable)
+			continue;
+
+		if (pipe->plane_res.rmcm)
+			continue;
+
+		for (i = 0; i < pool->res_cap->num_rmcm && i < MAX_RMCM_INST; i++) {
+			if (!pool->rmcm[i] || new_ctx->res_ctx.rmcm_in_use[i])
+				continue;
+
+			pipe->plane_res.rmcm = pool->rmcm[i];
+			new_ctx->res_ctx.rmcm_in_use[i] = true;
+			break;
+		}
+	}
+}
+
+/*
+ * resource_release_rmcm() - Release an RMCM instance for a pipe.
+ *
+ * Marks the instance free and NULLs the caller's pointer.
+ */
+void resource_release_rmcm(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct rmcm **rmcm)
+{
+	int i;
+
+	if (!*rmcm)
+		return;
+
+	for (i = 0; i < pool->res_cap->num_rmcm && i < MAX_RMCM_INST; i++) {
+		if (pool->rmcm[i] == *rmcm) {
+			res_ctx->rmcm_in_use[i] = false;
+			*rmcm = NULL;
+			return;
+		}
+	}
+}
+
 bool resource_append_dpp_pipes_for_plane_composition(
 		struct dc_state *new_ctx,
 		struct dc_state *cur_ctx,
@@ -3414,6 +3503,12 @@ bool resource_append_dpp_pipes_for_plane_composition(
 					pool, plane_state);
 	}
 
+	/* Idempotent, so the last append of a commit leaves the final assignment behind.
+	 * Releasing is driven by the MPC_RMCM_CNTL mirror (see dcn42_release_rmcm_from_mpcc).
+	 */
+	if (success)
+		resource_assign_rmcm(new_ctx, cur_ctx, pool);
+
 	return success;
 }
 
@@ -3428,6 +3523,12 @@ void resource_remove_dpp_pipes_for_plane_composition(
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe_ctx->plane_state == plane_state) {
+			/* Release RMCM instance for this pipe */
+			if (pipe_ctx->plane_res.rmcm)
+				resource_release_rmcm(&context->res_ctx,
+						pool,
+						&pipe_ctx->plane_res.rmcm);
+
 			if (pipe_ctx->top_pipe)
 				pipe_ctx->top_pipe->bottom_pipe = pipe_ctx->bottom_pipe;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 1e4fe2f941ca..edb50c23ce24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -467,8 +467,6 @@ enum dc_status dc_state_remove_stream(
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	dc_stream_release_3dlut_for_stream(dc, stream);
-
 	dc_stream_release(state->streams[i]);
 	state->stream_count--;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index c05428f52d88..8d3aacc7b96c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -1038,72 +1038,6 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 	}
 }
 
-/* TODO - move to per plane ownership? */
-/*
-*	dc_stream_get_3dlut()
-*	Requirements:
-*	1. Is stream already owns an RMCM instance, return it.
-*	2. If it doesn't and we don't need to allocate, return NULL.
-*	3. If there's a free RMCM instance, assign to stream and return it.
-*	4. If no free RMCM instances, return NULL.
-*/
-
-struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
-	const struct dc *dc,
-	const struct dc_stream_state *stream,
-	bool allocate_one)
-{
-	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
-
-	// see if one is allocated for this stream
-	for (unsigned int i = 0; i < num_rmcm; i++) {
-		if (dc->res_pool->rmcm_3dlut[i].isInUse &&
-			dc->res_pool->rmcm_3dlut[i].stream == stream)
-			return &dc->res_pool->rmcm_3dlut[i];
-	}
-
-	//case: not found one, and dont need to allocate
-	if (!allocate_one)
-		return NULL;
-
-	//see if there is an unused 3dlut, allocate
-	for (unsigned int i = 0; i < num_rmcm; i++) {
-		if (!dc->res_pool->rmcm_3dlut[i].isInUse) {
-			dc->res_pool->rmcm_3dlut[i].isInUse = true;
-			dc->res_pool->rmcm_3dlut[i].stream = stream;
-			return &dc->res_pool->rmcm_3dlut[i];
-		}
-	}
-
-	//dont have a 3dlut
-	return NULL;
-}
-
-
-void dc_stream_release_3dlut_for_stream(
-	const struct dc *dc,
-	const struct dc_stream_state *stream)
-{
-	struct dc_rmcm_3dlut *rmcm_3dlut =
-		dc_stream_get_3dlut_for_stream(dc, stream, false);
-
-	if (rmcm_3dlut) {
-		rmcm_3dlut->isInUse = false;
-		rmcm_3dlut->stream  = NULL;
-	}
-}
-
-
-void dc_stream_init_rmcm_3dlut(struct dc *dc)
-{
-	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
-
-	for (unsigned int i = 0; i < num_rmcm; i++) {
-		dc->res_pool->rmcm_3dlut[i].isInUse = false;
-		dc->res_pool->rmcm_3dlut[i].stream = NULL;
-	}
-}
-
 /*
  * Finds the greatest index in refresh_rate_hz that contains a value <= refresh
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ecd5699ac5e..7ca5355dbad2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -37,6 +37,7 @@
 #include "link_service_types.h"
 #include "grph_object_ctrl_defs.h"
 #include <inc/hw/opp.h>
+#include <inc/hw/rmcm.h>
 
 #include "hwss/hw_sequencer.h"
 #include "inc/compressor.h"
@@ -1514,11 +1515,6 @@ struct lut_mem_mapping {
 	uint16_t size;
 };
 
-struct dc_rmcm_3dlut {
-	bool isInUse;
-	const struct dc_stream_state *stream;
-};
-
 struct dc_3dlut {
 	struct kref refcount;
 	struct tetrahedral_params lut_3d;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 934ae381e730..d9d79788a92c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -611,17 +611,6 @@ bool dc_stream_set_gamut_remap(struct dc *dc,
 bool dc_stream_program_csc_matrix(struct dc *dc,
 				  struct dc_stream_state *stream);
 
-struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
-	const struct dc *dc,
-	const struct dc_stream_state *stream,
-	bool allocate_one);
-
-void dc_stream_release_3dlut_for_stream(
-	const struct dc *dc,
-	const struct dc_stream_state *stream);
-
-void dc_stream_init_rmcm_3dlut(struct dc *dc);
-
 struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
 
 void dc_dmub_update_dirty_rect(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index a2e0bafb711a..2acdac35a382 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -126,6 +126,10 @@ static enum hubp_3dlut_fl_width hubp401_get_3dlut_fl_width(
 	enum hubp_3dlut_fl_width width = 0;
 
 	switch (size) {
+	case CM_LUT_SIZE_999:
+		ASSERT(swizzle != CM_LUT_1D_PACKED_LINEAR);
+		width = hubp_3dlut_fl_width_9;
+		break;
 	case CM_LUT_SIZE_333333:
 		ASSERT(swizzle != CM_LUT_1D_PACKED_LINEAR);
 		width = hubp_3dlut_fl_width_33;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 86e49eb84a54..96d3310e2c3f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -732,7 +732,6 @@ struct hubp_funcs dcn42_hubp_funcs = {
 	.hubp_program_3dlut_fl_crossbar = hubp42_program_3dlut_fl_crossbar,
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
 	.hubp_clear_tiling = hubp3_clear_tiling,
-	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
 	.hubp_read_reg_state = hubp3_read_reg_state
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 5a163711498a..fefc9dea7054 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -41,6 +41,7 @@
 #include "opp.h"
 #include "ipp.h"
 #include "mpc.h"
+#include "rmcm.h"
 #include "reg_helper.h"
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_hubbub.h"
@@ -565,31 +566,32 @@ static void dcn10_log_color_state(struct dc *dc,
 		"OUT_OFFSET", "OUT_SCALE", "FL_DONE", "SOFT_UNDERFLOW", "HARD_UNDERFLOW",
 		"MEM_PWR_ST", "FORCE", "DIS", "MODE"};
 
-	for (i = 0; i < pool->mpcc_count; i++) {
-		struct mpcc_state s = {0};
+	/* Read RMCM state separately - RMCM is a shared resource (only 2 instances) */
+	for (i = 0; i < MAX_RMCM_INST && i < pool->mpcc_count; i++) {
+		struct rmcm_state r = {0};
 
-		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
-		if (s.opp_id != 0xf) {
+		if (pool->rmcm[i] && pool->rmcm[i]->funcs->read_rmcm_state) {
+			pool->rmcm[i]->funcs->read_rmcm_state(pool->rmcm[i], i, &r);
 			uint32_t values[] = {
 				i,
-				s.rmcm_regs.rmcm_3dlut_size,
-				s.rmcm_regs.rmcm_3dlut_mode,
-				s.rmcm_regs.rmcm_3dlut_mode_cur,
-				s.rmcm_regs.rmcm_3dlut_read_sel,
-				s.rmcm_regs.rmcm_3dlut_30bit_en,
-				s.rmcm_regs.rmcm_3dlut_wr_en_mask,
-				s.rmcm_regs.rmcm_3dlut_ram_sel,
-				s.rmcm_regs.rmcm_3dlut_out_norm_factor,
-				s.rmcm_regs.rmcm_3dlut_fl_sel,
-				s.rmcm_regs.rmcm_3dlut_out_offset_r,
-				s.rmcm_regs.rmcm_3dlut_out_scale_r,
-				s.rmcm_regs.rmcm_3dlut_fl_done,
-				s.rmcm_regs.rmcm_3dlut_fl_soft_underflow,
-				s.rmcm_regs.rmcm_3dlut_fl_hard_underflow,
-				s.rmcm_regs.rmcm_3dlut_mem_pwr_state,
-				s.rmcm_regs.rmcm_3dlut_mem_pwr_force,
-				s.rmcm_regs.rmcm_3dlut_mem_pwr_dis,
-				s.rmcm_regs.rmcm_3dlut_mem_pwr_mode};
+				r.regs.rmcm_3dlut_size,
+				r.regs.rmcm_3dlut_mode,
+				r.regs.rmcm_3dlut_mode_cur,
+				r.regs.rmcm_3dlut_read_sel,
+				r.regs.rmcm_3dlut_30bit_en,
+				r.regs.rmcm_3dlut_wr_en_mask,
+				r.regs.rmcm_3dlut_ram_sel,
+				r.regs.rmcm_3dlut_out_norm_factor,
+				r.regs.rmcm_3dlut_fl_sel,
+				r.regs.rmcm_3dlut_out_offset_r,
+				r.regs.rmcm_3dlut_out_scale_r,
+				r.regs.rmcm_3dlut_fl_done,
+				r.regs.rmcm_3dlut_fl_soft_underflow,
+				r.regs.rmcm_3dlut_fl_hard_underflow,
+				r.regs.rmcm_3dlut_mem_pwr_state,
+				r.regs.rmcm_3dlut_mem_pwr_force,
+				r.regs.rmcm_3dlut_mem_pwr_dis,
+				r.regs.rmcm_3dlut_mem_pwr_mode};
 
 			int num_elements = 19;
 
@@ -600,17 +602,18 @@ static void dcn10_log_color_state(struct dc *dc,
 	DTN_INFO("\n");
 	DTN_INFO("===== MPC RMCM Shaper =====\n");
 	DTN_INFO("MPCC:  CNTL  LUT_MODE  MODE_CUR  WR_EN_MASK  WR_SEL  OFFSET  SCALE  START_B	START_SEG_B	END_B	END_BASE_B	MEM_PWR_ST	FORCE	DIS	MODE\n");
-	for (i = 0; i < pool->mpcc_count; i++) {
-		struct mpcc_state s = {0};
+	for (i = 0; i < MAX_RMCM_INST && i < pool->mpcc_count; i++) {
+		struct rmcm_state r = {0};
 
-		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
-		if (s.opp_id != 0xf)
+		if (pool->rmcm[i] && pool->rmcm[i]->funcs->read_rmcm_state) {
+			pool->rmcm[i]->funcs->read_rmcm_state(pool->rmcm[i], i, &r);
 			DTN_INFO("[%2d]:  %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x\n",
-				i, s.rmcm_regs.rmcm_cntl, s.rmcm_regs.rmcm_shaper_lut_mode, s.rmcm_regs.rmcm_shaper_mode_cur,
-				s.rmcm_regs.rmcm_shaper_lut_write_en_mask, s.rmcm_regs.rmcm_shaper_lut_write_sel, s.rmcm_regs.rmcm_shaper_offset_b,
-				s.rmcm_regs.rmcm_shaper_scale_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_start_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_start_seg_b,
-				s.rmcm_regs.rmcm_shaper_rama_exp_region_end_b, s.rmcm_regs.rmcm_shaper_rama_exp_region_end_base_b, s.rmcm_regs.rmcm_shaper_mem_pwr_state,
-				s.rmcm_regs.rmcm_shaper_mem_pwr_force, s.rmcm_regs.rmcm_shaper_mem_pwr_dis, s.rmcm_regs.rmcm_shaper_mem_pwr_mode);
+				i, r.regs.rmcm_cntl, r.regs.rmcm_shaper_lut_mode, r.regs.rmcm_shaper_mode_cur,
+				r.regs.rmcm_shaper_lut_write_en_mask, r.regs.rmcm_shaper_lut_write_sel, r.regs.rmcm_shaper_offset_b,
+				r.regs.rmcm_shaper_scale_b, r.regs.rmcm_shaper_rama_exp_region_start_b, r.regs.rmcm_shaper_rama_exp_region_start_seg_b,
+				r.regs.rmcm_shaper_rama_exp_region_end_b, r.regs.rmcm_shaper_rama_exp_region_end_base_b, r.regs.rmcm_shaper_mem_pwr_state,
+				r.regs.rmcm_shaper_mem_pwr_force, r.regs.rmcm_shaper_mem_pwr_dis, r.regs.rmcm_shaper_mem_pwr_mode);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 4e7a005d27ef..0998106c1da0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -719,6 +719,10 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	/* Clearing 3DLUT fast load writes to HUBP, so it must precede hubp_clk_cntl() below */
+	if (hws->funcs.disable_rmcm_luts)
+		hws->funcs.disable_rmcm_luts(dc, pipe_ctx->plane_res.rmcm, hubp, pipe_ctx->plane_res.mpcc_inst);
+
 	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe_ctx);
 
 	/* In flip immediate with pipe splitting case GSL is used for
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 430966af3808..5de38b86cb54 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -579,10 +579,24 @@ bool dcn32_set_input_transfer_func(struct set_input_transfer_func_params *params
 
 	dpp->funcs->dpp_program_gamcor_lut(dpp, pwl_params);
 
-	if (hws->funcs.set_mcm_luts)
-		result = hws->funcs.set_mcm_luts(params->dc, dpp, params->hubp,
-			params->primary_hubp, params->mpc, params->mpcc_id,
-			params->stream, plane_state);
+	/* MCM and RMCM are mutually exclusive - tear the inactive one out before programming
+	 * the active one, which then owns the shared HUBP 3DLUT fast load.
+	 */
+	if (plane_state->cm.flags.bits.rmcm_enable && hws->funcs.set_rmcm_luts) {
+		if (hws->funcs.disable_mcm_luts)
+			hws->funcs.disable_mcm_luts(params->mpc, params->mpcc_id);
+
+		result = hws->funcs.set_rmcm_luts(params);
+	} else {
+		if (hws->funcs.disable_rmcm_luts)
+			hws->funcs.disable_rmcm_luts(params->dc, params->rmcm,
+					params->hubp, params->mpcc_id);
+
+		if (hws->funcs.set_mcm_luts)
+			result = hws->funcs.set_mcm_luts(params->dc, dpp, params->hubp,
+				params->primary_hubp, params->mpc, params->mpcc_id,
+				params->stream, plane_state);
+	}
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 16526c66c2d1..942d3f3d9f25 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -872,9 +872,13 @@ void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
  */
 void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
+	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	/* Clearing 3DLUT fast load writes to HUBP, so it must precede hubp_clk_cntl() below */
+	if (hws->funcs.disable_rmcm_luts)
+		hws->funcs.disable_rmcm_luts(dc, pipe_ctx->plane_res.rmcm, hubp, pipe_ctx->plane_res.mpcc_inst);
 
 	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3a5dde5c8120..c76754df2c38 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -457,6 +457,9 @@ bool dcn401_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 
 	/* 1D LUT */
 	lut_enable = cm->flags.bits.blend_enable != 0u;
+	if (cm->flags.bits.rmcm_enable)
+		lut_enable = false;
+
 	memset(&m_lut_params, 0, sizeof(m_lut_params));
 	if (lut_enable) {
 		if (cm->blend_func.type == TF_TYPE_HWPWL)
@@ -483,6 +486,9 @@ bool dcn401_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 
 	/* Shaper */
 	lut_enable = cm->flags.bits.shaper_enable != 0u;
+	if (cm->flags.bits.rmcm_enable)
+		lut_enable = false;
+
 	if (lut_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (cm->shaper_func.type == TF_TYPE_HWPWL)
@@ -514,6 +520,9 @@ bool dcn401_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 
 	/* 3DLUT */
 	lut_enable = cm->flags.bits.lut3d_enable != 0u;
+	if (cm->flags.bits.rmcm_enable)
+		lut_enable = false;
+
 	if (lut_enable && cm->flags.bits.lut3d_dma_enable) {
 		/* Fast (DMA) Load Mode */
 		/* MPC */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 23d4786ea246..c152941c34f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -402,112 +402,226 @@ void dcn42_program_cm_hist(
 			plane_state->cm_hist_control, plane_state->color_space);
 }
 
-static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
+/* RMCM is per-pipe and reloads through its own HUBP, unlike MCM which is shared by
+ * the plane's pipes and always reloads through the primary one.
+ */
+void dcn42_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx)
 {
-	if (mpc->funcs->rmcm.power_on_shaper_3dlut &&
-		mpc->funcs->rmcm.fl_3dlut_configure &&
-		hubp->funcs->hubp_program_3dlut_fl_config)
-		return true;
+	struct hubp *hubp;
+	bool use_rmcm = pipe_ctx->plane_state && pipe_ctx->plane_state->cm.flags.bits.rmcm_enable;
 
-	return false;
+	if (use_rmcm) {
+		hubp = pipe_ctx->plane_res.hubp;
+	} else {
+		const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
+
+		hubp = primary_dpp_pipe_ctx ? primary_dpp_pipe_ctx->plane_res.hubp : NULL;
+	}
+
+	if (hubp && hubp->funcs->hubp_enable_3dlut_fl)
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
 }
 
-bool dcn42_program_rmcm_luts(
-	struct dc *dc,
-	struct dpp *dpp,
-	struct hubp *hubp,
-	const struct dc_plane_cm *cm,
-	struct mpc *mpc,
-	int mpcc_id,
-	struct dc_stream_state *stream)
+/* Takes the MCM out of the pipe. The caller programs the HUBP fast load afterwards. */
+void dcn42_disable_mcm_luts(struct mpc *mpc, int mpcc_id)
 {
-	union mcm_lut_params m_lut_params = {0};
+	if (!mpc || !mpc->funcs->program_lut_mode)
+		return;
 
-	struct mpc_fl_3dlut_config mpc_fl_config;
+	mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, false, false, CM_LUT_SIZE_NONE, mpcc_id);
+	mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, false, false, CM_LUT_SIZE_NONE, mpcc_id);
+	mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, false, false, CM_LUT_SIZE_NONE, mpcc_id);
+}
 
-	bool bypass_rmcm_shaper = false;
-	// true->false when it can be allocated at DI time
-	struct dc_rmcm_3dlut *rmcm_3dlut = dc_stream_get_3dlut_for_stream(dc, stream, false);
+static void dcn42_detach_rmcm(struct rmcm *rmcm)
+{
+	if (rmcm->funcs->update_3dlut_fast_load_select)
+		rmcm->funcs->update_3dlut_fast_load_select(rmcm, rmcm->inst, RMCM_FL_HUBP_IDX_NONE);
+
+	if (rmcm->funcs->connect_mpcc)
+		rmcm->funcs->connect_mpcc(rmcm, rmcm->inst, RMCM_MPCC_ID_NONE);
+}
+
+/* MPC makes an MPCC bypass RMCM once more than one instance is bound to it, so drop every
+ * instance that could still point at this MPCC. One the driver has not programmed yet counts,
+ * as its MPC_RMCM_CNTL may still hold a boot value.
+ */
+void dcn42_release_rmcm_from_mpcc(struct dc *dc, int mpcc_id, const struct rmcm *keep)
+{
+	int i;
 
-	bool lut_enable = false;
-	bool lut_bank_a = true;
+	for (i = 0; i < dc->res_pool->res_cap->num_rmcm && i < MAX_RMCM_INST; i++) {
+		struct rmcm *rmcm = dc->res_pool->rmcm[i];
 
-	//check to see current pipe is part of a stream with allocated rmcm 3dlut
-	if (!rmcm_3dlut)
-		return false;
+		if (!rmcm || !rmcm->funcs)
+			continue;
 
-	/* Determine the LUT bank currently active in HW and switch to the other
-	 * bank to preserve double-buffering (mirrors dcn401_set_mcm_luts).
-	 */
-	if (mpc->funcs->rmcm.get_3dlut_mode)
-		mpc->funcs->rmcm.get_3dlut_mode(mpc, mpcc_id, &lut_enable, &lut_bank_a);
+		if (rmcm == keep)
+			continue;
+
+		/* An instance the driver has not programmed yet counts as bound, because its
+		 * MPC_RMCM_CNTL may still hold a boot value.
+		 */
+		if (rmcm->mpcc_id == mpcc_id || rmcm->mpcc_id == RMCM_MPCC_ID_UNKNOWN)
+			dcn42_detach_rmcm(rmcm);
+	}
+}
+
+/* Leaves mpcc_id with no RMCM in its path. A NULL hubp keeps the shared 3DLUT fast load
+ * untouched, for when another block already owns that HUBP.
+ */
+void dcn42_disable_rmcm_luts(struct dc *dc, struct rmcm *rmcm, struct hubp *hubp, int mpcc_id)
+{
+	if (rmcm && rmcm->funcs) {
+		/* HW blocks 3DLUT writes until FL mode is cleared from HUBP on VUpdate, so
+		 * tear fast load down while the HUBP is still clocked.
+		 */
+		if (hubp && hubp->funcs->hubp_enable_3dlut_fl) {
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
+		}
+
+		dcn42_detach_rmcm(rmcm);
+	}
+
+	dcn42_release_rmcm_from_mpcc(dc, mpcc_id, NULL);
+}
+
+bool dcn42_set_rmcm_luts(struct set_input_transfer_func_params *params)
+{
+	struct dpp *dpp_base = params->dpp;
+	struct hubp *hubp = params->hubp;
+	const struct dc_plane_cm *cm = &params->plane_state->cm;
+	struct rmcm *rmcm = params->rmcm;
+	int rmcm_inst;
+	union rmcm_lut_params m_lut_params = {0};
+	struct dc_3dlut_dma lut3d_dma;
+	bool lut_enable;
+	bool lut_bank_a;
+	bool rval;
+	bool result = true;
+
+	/* No RMCM on this plane, so there is nothing to program */
+	if (!rmcm || !rmcm->funcs) {
+		return true;
+	}
+
+	rmcm_inst = rmcm->inst;
 
-	if (lut_enable)
+	/* decide LUT bank based on current in use */
+	if (rmcm->funcs->get_lut_mode) {
+		rmcm->funcs->get_lut_mode(rmcm, MCM_LUT_SHAPER, rmcm_inst, &lut_enable, &lut_bank_a);
+		if (!lut_enable) {
+			rmcm->funcs->get_lut_mode(rmcm, MCM_LUT_3DLUT, rmcm_inst, &lut_enable, &lut_bank_a);
+		}
+	} else {
+		lut_enable = false;
+		lut_bank_a = true;
+	}
+
+	/* switch to the next bank */
+	if (lut_enable) {
 		lut_bank_a = !lut_bank_a;
+	}
 
 	/* Shaper */
-	if (cm->flags.bits.shaper_enable) {
+	lut_enable = cm->flags.bits.shaper_enable != 0;
+	if (lut_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
-
-		if (cm->shaper_func.type == TF_TYPE_HWPWL) {
+		if (cm->shaper_func.type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &cm->shaper_func.pwl;
-		} else if (cm->shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		else if (cm->shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(
-					dc->ctx,
+			rval = cm_helper_translate_curve_to_hw_format(params->plane_state->ctx,
 					&cm->shaper_func,
-					&dpp->shaper_params, true);
-			m_lut_params.pwl = &dpp->shaper_params;
+					&dpp_base->shaper_params,
+					true);
+			m_lut_params.pwl = rval ? &dpp_base->shaper_params : NULL;
 		}
-		if (m_lut_params.pwl) {
-			if (mpc->funcs->rmcm.populate_lut)
-				mpc->funcs->rmcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->rmcm.program_lut_mode)
-				mpc->funcs->rmcm.program_lut_mode(mpc, !bypass_rmcm_shaper, lut_bank_a, mpcc_id);
-		} else {
-			//RMCM 3dlut won't work without its shaper
-			return false;
+		if (!m_lut_params.pwl) {
+			lut_enable = false;
 		}
+	} else {
+		lut_enable = false;
 	}
 
-	/* 3DLUT */
-	if (!cm->flags.bits.lut3d_dma_enable) {
-		/* RMCM host (non-DMA) 3DLUT load is not implemented; fail fast
-		 * instead of silently reporting success
-		 */
-		BREAK_TO_DEBUGGER();
-		return false;
-	} else {
-		if (!dc_is_rmcm_3dlut_supported(hubp, mpc))
-			return false;
+	if (rmcm->funcs->program_lut_mode)
+		rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_SHAPER, lut_enable, lut_bank_a,
+			CM_LUT_SIZE_NONE, 0, 0, rmcm_inst);
+	if (lut_enable && rmcm->funcs->populate_lut)
+		rmcm->funcs->populate_lut(rmcm, MCM_LUT_SHAPER, m_lut_params, lut_bank_a, rmcm_inst);
+
+	/* NOTE: Toggling from DMA->Host is not supported atomically as hardware
+	 * blocks writes until 3DLUT FL mode is cleared from HUBP on VUpdate.
+	 * Expectation is either option is used consistently.
+	*/
 
-		//seems to be only for the MCM
-		mpc_fl_config.enabled			= cm->flags.bits.lut3d_enable != 0u;
-		mpc_fl_config.size	            = cm->lut3d_dma.size;
-		mpc_fl_config.select_lut_bank_a = lut_bank_a;
-		mpc_fl_config.bit_depth		    = 0;
-		mpc_fl_config.hubp_index		= hubp->inst;
-		mpc_fl_config.bias	= cm->lut3d_dma.bias;
-		mpc_fl_config.scale	= cm->lut3d_dma.scale;
+	/* 3DLUT */
+	lut_enable = cm->flags.bits.lut3d_enable != 0;
+	if (lut_enable && cm->flags.bits.lut3d_dma_enable) {
+		/* Fast (DMA) Load Mode */
+		if (rmcm->funcs->program_lut_mode)
+			rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_3DLUT, lut_enable, lut_bank_a,
+				cm->lut3d_dma.size,
+				cm->lut3d_dma.bias, cm->lut3d_dma.scale,
+				rmcm_inst);
 
-		//1. power down the block
-		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, false);
+		if (rmcm->funcs->program_lut_read_write_control)
+			rmcm->funcs->program_lut_read_write_control(rmcm, MCM_LUT_3DLUT, lut_bank_a, true, rmcm_inst);
 
-		//2. program RMCM - 3dlut reg programming
-		mpc->funcs->rmcm.fl_3dlut_configure(mpc, &mpc_fl_config, mpcc_id);
+		if (rmcm->funcs->update_3dlut_fast_load_select)
+			rmcm->funcs->update_3dlut_fast_load_select(rmcm, rmcm_inst, hubp->inst);
 
 		/* HUBP */
 		if (hubp->funcs->hubp_program_3dlut_fl_config)
 			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
 
+		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
+			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
+
 		if (hubp->funcs->hubp_program_3dlut_fl_addr)
 			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
 
-		//3. power on the block
-		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, true);
+		if (hubp->funcs->hubp_enable_3dlut_fl) {
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+		} else {
+			/* GPU memory only supports fast load path */
+			BREAK_TO_DEBUGGER();
+			lut_enable = false;
+			result = false;
+		}
+	} else {
+		/* RMCM has no host load path - its 3DLUT can only be fetched by HUBP fast
+		 * load, so asking for one without DMA is a programming error.
+		 */
+		ASSERT(!lut_enable);
+		result = !lut_enable;
+		lut_enable = false;
+
+		if (rmcm->funcs->program_lut_mode)
+			rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_3DLUT, lut_enable, lut_bank_a,
+				CM_LUT_SIZE_NONE, 0, 0, rmcm_inst);
+
+		if (rmcm->funcs->update_3dlut_fast_load_select)
+			rmcm->funcs->update_3dlut_fast_load_select(rmcm, rmcm_inst, RMCM_FL_HUBP_IDX_NONE);
+
+		/* HUBP */
+		memset(&lut3d_dma, 0, sizeof(lut3d_dma));
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &lut3d_dma);
+
+		if (hubp->funcs->hubp_enable_3dlut_fl)
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
 	}
 
-	return true;
+	/* Connect to the MPCC only once the LUTs are loaded. Teardown is done by
+	 * disable_rmcm_luts, at plane teardown or when the plane switches back to MCM.
+	 */
+	dcn42_release_rmcm_from_mpcc(params->dc, params->mpcc_id, rmcm);
+
+	if (rmcm->funcs->connect_mpcc)
+		rmcm->funcs->connect_mpcc(rmcm, rmcm_inst, params->mpcc_id);
+
+	return result;
 }
 
 bool dcn42_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
@@ -516,25 +630,11 @@ bool dcn42_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 				struct dc_plane_state *plane_state)
 {
 	bool result;
-	const struct dc_plane_cm *cm = &plane_state->cm;
 
 	/* MCM */
 	result = dcn401_set_mcm_luts(dc, dpp, hubp, primary_hubp, mpc, mpcc_id,
 			stream, plane_state);
 
-	/* RMCM */
-	if (cm->flags.bits.rmcm_enable && cm->flags.bits.lut3d_dma_enable) {
-		/* TODO - move RMCM to its own block */
-		dcn42_program_rmcm_luts(
-			dc,
-			dpp,
-			hubp,
-			cm,
-			mpc,
-			mpcc_id,
-			stream);
-	}
-
 	return result;
 }
 void dcn42_hardware_release(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
index 61d1217a30df..95b8ce23286c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
@@ -20,14 +20,13 @@ bool dcn42_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 	struct dc_stream_state *stream,
 	struct dc_plane_state *plane_state);
 
-bool dcn42_program_rmcm_luts(
-	struct dc *dc,
-	struct dpp *dpp,
-	struct hubp *hubp,
-	const struct dc_plane_cm *cm,
-	struct mpc *mpc,
-	int mpcc_id,
-	struct dc_stream_state *stream);
+void dcn42_disable_rmcm_luts(struct dc *dc, struct rmcm *rmcm, struct hubp *hubp, int mpcc_id);
+void dcn42_release_rmcm_from_mpcc(struct dc *dc, int mpcc_id, const struct rmcm *keep);
+void dcn42_disable_mcm_luts(struct mpc *mpc, int mpcc_id);
+void dcn42_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx);
+
+bool dcn42_set_rmcm_luts(struct set_input_transfer_func_params *params);
+
 void dcn42_hardware_release(struct dc *dc);
 
 void dcn42_prepare_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index aad1885cc988..b074aa9a21d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -29,7 +29,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.trigger_3dlut_dma_load = dcn401_trigger_3dlut_dma_load,
+	.trigger_3dlut_dma_load = dcn42_trigger_3dlut_dma_load,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
@@ -151,6 +151,9 @@ static const struct hwseq_private_funcs dcn42_private_funcs = {
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.set_mcm_luts = dcn42_set_mcm_luts,
+	.set_rmcm_luts = dcn42_set_rmcm_luts,
+	.disable_mcm_luts = dcn42_disable_mcm_luts,
+	.disable_rmcm_luts = dcn42_disable_rmcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 5936f389d936..443afcbce5ed 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -31,6 +31,7 @@
 #include "dce110/dce110_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn401/dcn401_hwseq.h"
+#include "dcn42/dcn42_hwseq.h"
 #include "dcn50/dcn50_hwseq.h"
 #include "dcn60_hwseq.h"
 #include "dcn401/dcn401_resource.h"
@@ -52,6 +53,127 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
+bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params)
+{
+	struct dpp *dpp_base = params->dpp;
+	struct hubp *hubp = params->hubp;
+	const struct dc_plane_cm *cm = &params->plane_state->cm;
+	struct rmcm *rmcm = params->rmcm;
+	int rmcm_inst;
+	union rmcm_lut_params m_lut_params = {0};
+	struct dc_3dlut_dma lut3d_dma;
+	bool lut_enable;
+	/* DCN60 has a single LUT SRAM per RMCM - always bank A. */
+	bool rval;
+	bool result = true;
+
+	/* No RMCM on this plane, so there is nothing to program */
+	if (!rmcm || !rmcm->funcs) {
+		return true;
+	}
+
+	rmcm_inst = rmcm->inst;
+
+	/* Shaper */
+	lut_enable = cm->flags.bits.shaper_enable != 0;
+	if (lut_enable) {
+		memset(&m_lut_params, 0, sizeof(m_lut_params));
+		if (cm->shaper_func.type == TF_TYPE_HWPWL)
+			m_lut_params.pwl = &cm->shaper_func.pwl;
+		else if (cm->shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+			ASSERT(false);
+			rval = cm_helper_translate_curve_to_hw_format(params->plane_state->ctx,
+					&cm->shaper_func,
+					&dpp_base->shaper_params,
+					true);
+			m_lut_params.pwl = rval ? &dpp_base->shaper_params : NULL;
+		}
+		if (!m_lut_params.pwl) {
+			lut_enable = false;
+		}
+	} else {
+		lut_enable = false;
+	}
+
+	if (rmcm->funcs->program_lut_mode)
+		rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_SHAPER, lut_enable, true,
+			CM_LUT_SIZE_NONE, 0, 0, rmcm_inst);
+	if (lut_enable && rmcm->funcs->populate_lut)
+		rmcm->funcs->populate_lut(rmcm, MCM_LUT_SHAPER, m_lut_params, true, rmcm_inst);
+
+	/* NOTE: Toggling from DMA->Host is not supported atomically as hardware
+	 * blocks writes until 3DLUT FL mode is cleared from HUBP on VUpdate.
+	 * Expectation is either option is used consistently.
+	*/
+
+	/* 3DLUT */
+	lut_enable = cm->flags.bits.lut3d_enable != 0;
+	if (lut_enable && cm->flags.bits.lut3d_dma_enable) {
+		/* Fast (DMA) Load Mode */
+		if (rmcm->funcs->program_lut_mode)
+			rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_3DLUT, lut_enable, true,
+				cm->lut3d_dma.size,
+				cm->lut3d_dma.bias, cm->lut3d_dma.scale,
+				rmcm_inst);
+
+		if (rmcm->funcs->program_lut_read_write_control)
+			rmcm->funcs->program_lut_read_write_control(rmcm, MCM_LUT_3DLUT, true, true, rmcm_inst);
+
+		if (rmcm->funcs->update_3dlut_fast_load_select)
+			rmcm->funcs->update_3dlut_fast_load_select(rmcm, rmcm_inst, hubp->inst);
+
+		/* HUBP */
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
+
+		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
+			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
+
+		if (hubp->funcs->hubp_program_3dlut_fl_addr)
+			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
+
+		if (hubp->funcs->hubp_enable_3dlut_fl) {
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+		} else {
+			/* GPU memory only supports fast load path */
+			BREAK_TO_DEBUGGER();
+			result = false;
+		}
+	} else {
+		/* RMCM 3DLUT is fetched only by HUBP fast load, so a host load request is a
+		 * programming error.
+		 */
+		ASSERT(!lut_enable);
+		result = !lut_enable;
+		lut_enable = false;
+
+		if (rmcm->funcs->program_lut_mode)
+			rmcm->funcs->program_lut_mode(rmcm, MCM_LUT_3DLUT, lut_enable, true,
+				CM_LUT_SIZE_NONE, 0, 0, rmcm_inst);
+
+		if (rmcm->funcs->update_3dlut_fast_load_select)
+			rmcm->funcs->update_3dlut_fast_load_select(rmcm, rmcm_inst, RMCM_FL_HUBP_IDX_NONE);
+
+		/* HUBP */
+		memset(&lut3d_dma, 0, sizeof(lut3d_dma));
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &lut3d_dma);
+
+		if (hubp->funcs->hubp_enable_3dlut_fl)
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
+	}
+
+	/* Connect to the MPCC only once the LUTs are loaded. Teardown is done by
+	 * disable_rmcm_luts, at plane teardown or when the plane switches back to MCM.
+	 */
+	dcn42_release_rmcm_from_mpcc(params->dc, params->mpcc_id, rmcm);
+
+	if (rmcm->funcs->connect_mpcc)
+		rmcm->funcs->connect_mpcc(rmcm, rmcm_inst, params->mpcc_id);
+
+	return result;
+}
+
 static void dcn60_build_audio_output(
 	struct dc_state *state,
 	const struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
index 3a34150096df..b880988ff1fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
@@ -30,4 +30,6 @@ void dcn60_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx
 void dcn60_program_perfmon(struct dc *dc, struct dc_state *context);
 bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
+bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params);
+
 #endif /* __DC_HWSS_DCN60_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 37e88d45409b..d2fae89dfa05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -28,7 +28,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
-	.trigger_3dlut_dma_load = dcn401_trigger_3dlut_dma_load,
+	.trigger_3dlut_dma_load = dcn42_trigger_3dlut_dma_load,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
@@ -147,7 +147,7 @@ static const struct hwseq_private_funcs dcn60_private_funcs = {
 	.init_blank = dcn32_init_blank,
 	.disable_vga = NULL,
 	.bios_golden_init = dcn10_bios_golden_init,
-	.plane_atomic_disable = dcn20_plane_atomic_disable,
+	.plane_atomic_disable = dcn35_plane_atomic_disable,
 	.plane_atomic_power_down = dcn401_plane_atomic_power_down,
 	.plane_atomic_power_down_sequence = dcn401_plane_atomic_power_down_sequence,
 	.enable_power_gating_plane = NULL,
@@ -162,6 +162,9 @@ static const struct hwseq_private_funcs dcn60_private_funcs = {
 	.set_hdr_multiplier_sequence = dcn401_set_hdr_multiplier_sequence,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.set_mcm_luts = dcn42_set_mcm_luts,
+	.set_rmcm_luts = dcn60_set_rmcm_luts,
+	.disable_mcm_luts = dcn42_disable_mcm_luts,
+	.disable_rmcm_luts = dcn42_disable_rmcm_luts,
 	.program_mall_pipe_config = NULL,
 	.update_mall_sel = NULL,
 	.calculate_dccg_k1_k2_values = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 0133c6156897..4cf61eb647dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -46,6 +46,7 @@ struct resource_pool;
 struct dc_phy_addr_space_config;
 struct dc_virtual_addr_space_config;
 struct dpp;
+struct rmcm;
 struct dce_hwseq;
 struct link_resource;
 struct dc_dmub_cmd;
@@ -101,6 +102,7 @@ struct set_input_transfer_func_params {
 	struct hubp *hubp;
 	struct hubp *primary_hubp;
 	struct mpc *mpc;
+	struct rmcm *rmcm;
 	int mpcc_id;
 	struct dc_stream_state *stream;
 	struct input_pixel_processor *ipp;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 9730f51cf3c0..b6932b9bc206 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -73,6 +73,7 @@ struct timing_generator;
 struct tg_color;
 struct output_pixel_processor;
 struct mpcc_blnd_cfg;
+struct rmcm;
 
 struct hwseq_private_funcs {
 
@@ -193,6 +194,9 @@ struct hwseq_private_funcs {
 			struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
 			struct dc_stream_state *stream,
 			struct dc_plane_state *plane_state);
+	bool (*set_rmcm_luts)(struct set_input_transfer_func_params *params);
+	void (*disable_mcm_luts)(struct mpc *mpc, int mpcc_id);
+	void (*disable_rmcm_luts)(struct dc *dc, struct rmcm *rmcm, struct hubp *hubp, int mpcc_id);
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d2cca2c97a41..6563eaaa0c0c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -308,7 +308,7 @@ struct resource_pool {
 	struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
 	struct dc_transfer_func *mpc_shaper[MAX_PIPES];
-	struct dc_rmcm_3dlut rmcm_3dlut[MAX_RMCM_INST];
+	struct rmcm *rmcm[MAX_RMCM_INST];
 
 	struct {
 		unsigned int xtalin_clock_inKhz;
@@ -401,6 +401,7 @@ struct plane_resource {
 	struct transform *xfm;
 	struct dpp *dpp;
 	uint8_t mpcc_inst;
+	struct rmcm *rmcm;
 
 	struct dcn_fe_bandwidth bw;
 };
@@ -558,6 +559,7 @@ struct resource_context {
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
+	bool rmcm_in_use[MAX_RMCM_INST];
 	/* used to build scalar data in dml2 and for edp backlight programming */
 	struct pipe_ctx temp_pipe;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 9dc9317c28a4..b97f08b20984 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -87,6 +87,7 @@ enum hubp_3dlut_fl_addressing_mode {
 };
 
 enum hubp_3dlut_fl_width {
+	hubp_3dlut_fl_width_9 = 9,
 	hubp_3dlut_fl_width_17 = 17,
 	hubp_3dlut_fl_width_33 = 33,
 	hubp_3dlut_fl_width_17_transformed    = 4916, //mpc default
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index d863f4bdccad..d19f90a5893e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -193,42 +193,6 @@ struct mpc_grph_gamut_adjustment {
 	enum mpcc_gamut_remap_id mpcc_gamut_remap_block_id;
 };
 
-struct mpc_rmcm_regs {
-	uint32_t rmcm_3dlut_mem_pwr_state;
-	uint32_t rmcm_3dlut_mem_pwr_force;
-	uint32_t rmcm_3dlut_mem_pwr_dis;
-	uint32_t rmcm_3dlut_mem_pwr_mode;
-	uint32_t rmcm_3dlut_size;
-	uint32_t rmcm_3dlut_mode;
-	uint32_t rmcm_3dlut_mode_cur;
-	uint32_t rmcm_3dlut_read_sel;
-	uint32_t rmcm_3dlut_30bit_en;
-	uint32_t rmcm_3dlut_wr_en_mask;
-	uint32_t rmcm_3dlut_ram_sel;
-	uint32_t rmcm_3dlut_out_norm_factor;
-	uint32_t rmcm_3dlut_fl_sel;
-	uint32_t rmcm_3dlut_out_offset_r;
-	uint32_t rmcm_3dlut_out_scale_r;
-	uint32_t rmcm_3dlut_fl_done;
-	uint32_t rmcm_3dlut_fl_soft_underflow;
-	uint32_t rmcm_3dlut_fl_hard_underflow;
-	uint32_t rmcm_cntl;
-	uint32_t rmcm_shaper_mem_pwr_state;
-	uint32_t rmcm_shaper_mem_pwr_force;
-	uint32_t rmcm_shaper_mem_pwr_dis;
-	uint32_t rmcm_shaper_mem_pwr_mode;
-	uint32_t rmcm_shaper_lut_mode;
-	uint32_t rmcm_shaper_mode_cur;
-	uint32_t rmcm_shaper_lut_write_en_mask;
-	uint32_t rmcm_shaper_lut_write_sel;
-	uint32_t rmcm_shaper_offset_b;
-	uint32_t rmcm_shaper_scale_b;
-	uint32_t rmcm_shaper_rama_exp_region_start_b;
-	uint32_t rmcm_shaper_rama_exp_region_start_seg_b;
-	uint32_t rmcm_shaper_rama_exp_region_end_b;
-	uint32_t rmcm_shaper_rama_exp_region_end_base_b;
-};
-
 struct mpcc_sm_cfg {
 	bool enable;
 	/* 0-single plane,2-row subsampling,4-column subsampling,6-checkboard subsampling */
@@ -340,7 +304,6 @@ struct mpcc_state {
 	uint32_t rgam_mode;
 	uint32_t rgam_lut;
 	struct mpc_grph_gamut_adjustment gamut_remap;
-	struct mpc_rmcm_regs rmcm_regs;
 };
 
 struct dcn_mpc_reg_state {
@@ -1143,33 +1106,6 @@ struct mpc_funcs {
 			const int mpcc_id,
 			bool *enable,
 			bool *lut_bank_a);
-
-	/**
-	 * @rmcm:
-	 *
-	 * MPC RMCM new HW sequential programming functions
-	 */
-	struct {
-		void (*fl_3dlut_configure)(struct mpc *mpc, struct mpc_fl_3dlut_config *cfg, int mpcc_id);
-		void (*enable_3dlut_fl)(struct mpc *mpc, bool enable, int mpcc_id);
-		void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
-		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
-			bool lut_bank_a, bool enabled, int mpcc_id);
-		void (*program_lut_mode)(struct mpc *mpc,
-			bool enable,
-			bool lut_bank_a,
-			int mpcc_id);
-		void (*program_3dlut_size)(struct mpc *mpc, const enum dc_cm_lut_size size, int mpcc_id);
-		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
-		void (*program_bit_depth)(struct mpc *mpc, uint16_t bit_depth, int mpcc_id);
-		bool (*is_config_supported)(uint32_t width);
-
-		void (*power_on_shaper_3dlut)(struct mpc *mpc, uint32_t mpcc_id, bool power_on);
-		void (*populate_lut)(struct mpc *mpc, const union mcm_lut_params params,
-			bool lut_bank_a, int mpcc_id);
-		void (*get_3dlut_mode)(struct mpc *mpc, int mpcc_id,
-			bool *enable, bool *lut_bank_a);
-	} rmcm;
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
new file mode 100644
index 000000000000..636cd0970438
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/rmcm.h
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_RMCM_H__
+#define __DC_RMCM_H__
+
+#include "dc_types.h"
+
+#define MAX_RMCM 2
+
+/* Detach values for the RMCM binding registers: no MPCC connected (MPC_RMCM_CNTL)
+ * and no HUBP driving 3DLUT fast load (MPC_RMCM_3DLUT_FL_SEL).
+ */
+#define RMCM_MPCC_ID_NONE 0xF
+#define RMCM_FL_HUBP_IDX_NONE 0xF
+
+/* MPC_RMCM_CNTL has not been written by the driver yet, so it may still hold
+ * whatever the boot state left there.
+ */
+#define RMCM_MPCC_ID_UNKNOWN (-1)
+
+/* MCM_LUT_ID is defined in mpc.h */
+enum MCM_LUT_ID;
+
+union rmcm_lut_params {
+	const struct pwl_params *pwl;
+	const struct tetrahedral_params *lut3d;
+};
+
+struct rmcm_regs {
+	uint32_t rmcm_3dlut_mem_pwr_state;
+	uint32_t rmcm_3dlut_mem_pwr_force;
+	uint32_t rmcm_3dlut_mem_pwr_dis;
+	uint32_t rmcm_3dlut_mem_pwr_mode;
+	uint32_t rmcm_3dlut_size;
+	uint32_t rmcm_3dlut_mode;
+	uint32_t rmcm_3dlut_mode_cur;
+	uint32_t rmcm_3dlut_read_sel;
+	uint32_t rmcm_3dlut_30bit_en;
+	uint32_t rmcm_3dlut_wr_en_mask;
+	uint32_t rmcm_3dlut_ram_sel;
+	uint32_t rmcm_3dlut_out_norm_factor;
+	uint32_t rmcm_3dlut_fl_sel;
+	uint32_t rmcm_3dlut_out_offset_r;
+	uint32_t rmcm_3dlut_out_scale_r;
+	uint32_t rmcm_3dlut_fl_done;
+	uint32_t rmcm_3dlut_fl_soft_underflow;
+	uint32_t rmcm_3dlut_fl_hard_underflow;
+	uint32_t rmcm_cntl;
+	uint32_t rmcm_shaper_mem_pwr_state;
+	uint32_t rmcm_shaper_mem_pwr_force;
+	uint32_t rmcm_shaper_mem_pwr_dis;
+	uint32_t rmcm_shaper_mem_pwr_mode;
+	uint32_t rmcm_shaper_lut_mode;
+	uint32_t rmcm_shaper_mode_cur;
+	uint32_t rmcm_shaper_lut_write_en_mask;
+	uint32_t rmcm_shaper_lut_write_sel;
+	uint32_t rmcm_shaper_offset_b;
+	uint32_t rmcm_shaper_scale_b;
+	uint32_t rmcm_shaper_rama_exp_region_start_b;
+	uint32_t rmcm_shaper_rama_exp_region_start_seg_b;
+	uint32_t rmcm_shaper_rama_exp_region_end_b;
+	uint32_t rmcm_shaper_rama_exp_region_end_base_b;
+};
+
+/**
+ * struct rmcm_state - RMCM hardware state
+ *
+ * Captures the current hardware state of a Relocatable MCM instance.
+ * Used for debugging, state readback, and hardware validation.
+ */
+struct rmcm_state {
+	/**
+	 * @regs: Register state snapshot
+	 */
+	struct rmcm_regs regs;
+};
+
+/**
+ * struct rmcm - RMCM hardware instance
+ *
+ * Represents a single RMCM (Relocatable MCM) hardware instance.
+ * DCN 4.2+ has 2 RMCM instances that are shared across streams.
+ */
+struct rmcm {
+	struct dc_context *ctx;
+	int inst;
+	/* MPCC bound through MPC_RMCM_CNTL; MPC bypasses RMCM entirely when two
+	 * instances are bound to the same MPCC.
+	 */
+	int mpcc_id;
+	const struct rmcm_funcs *funcs;
+};
+
+/**
+ * struct rmcm_funcs - RMCM hardware abstraction function pointers
+ *
+ * Function pointers for RMCM (Relocatable MCM) hardware operations.
+ * These provide the interface for programming the shared cross-stream
+ * color manager instances.
+ */
+struct rmcm_funcs {
+	void (*get_lut_mode)(struct rmcm *rmcm,	const enum MCM_LUT_ID id, int rmcm_id, bool *enable, bool *lut_bank_a);
+	void (*program_lut_mode)(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+		bool enable, bool lut_bank_a, const enum dc_cm_lut_size size,
+		uint16_t bias, uint16_t scale, int rmcm_id);
+	void (*populate_lut)(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+		const union rmcm_lut_params params, bool lut_bank_a, int rmcm_id);
+	void (*program_lut_read_write_control)(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+		bool lut_bank_a, bool enabled, int rmcm_id);
+	void (*update_3dlut_fast_load_select)(struct rmcm *rmcm, int rmcm_id, int hubp_idx);
+	void (*get_3dlut_fast_load_status)(struct rmcm *rmcm, int rmcm_id,
+		bool *done, bool *soft_underflow, bool *hard_underflow);
+	void (*read_rmcm_state)(struct rmcm *rmcm, int rmcm_id, struct rmcm_state *s);
+	void (*connect_mpcc)(struct rmcm *rmcm, int rmcm_id, int mpcc_id);
+};
+
+#endif // __DC_RMCM_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 9c6794f8dec0..21a6f90956e8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -336,6 +336,21 @@ void resource_remove_dpp_pipes_for_plane_composition(
 		const struct resource_pool *pool,
 		const struct dc_plane_state *plane_state);
 
+/*
+ * RMCM resource management. Instances are handed out for a whole context at once so that a
+ * plane that is only now asking cannot evict one that is already using an instance.
+ * Tracking is via res_ctx->rmcm_in_use[].
+ */
+void resource_assign_rmcm(
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool);
+
+void resource_release_rmcm(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct rmcm **rmcm);
+
 /*
  * Update ODM slice count by acquiring or releasing pipes. If new slices need
  * to be added, it is going to add them to the last ODM index. If existing
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
index 5a888e1e1cc5..0123a9fcfef5 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
@@ -63,680 +63,14 @@ void mpc42_update_blending(
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
-/* RMCM Shaper functions */
-void mpc42_power_on_rmcm_shaper_3dlut(
-	struct mpc *mpc,
-	uint32_t mpcc_id,
-	bool power_on)
-{
-	uint32_t power_status_shaper = 2;
-	uint32_t power_status_3dlut  = 2;
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	int max_retries = 10;
-
-	REG_SET(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], 0,
-		MPC_RMCM_3DLUT_MEM_PWR_DIS, power_on == true ? 0 : 1);
-	REG_SET(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], 0,
-		MPC_RMCM_SHAPER_MEM_PWR_DIS, power_on == true ? 0 : 1);
-	/* wait for memory to fully power up */
-	if (power_on && mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
-		REG_WAIT(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], MPC_RMCM_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
-		REG_WAIT(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], MPC_RMCM_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
-	}
-
-	/*read status is not mandatory, it is just for debugging*/
-	REG_GET(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], MPC_RMCM_SHAPER_MEM_PWR_STATE, &power_status_shaper);
-	REG_GET(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], MPC_RMCM_3DLUT_MEM_PWR_STATE, &power_status_3dlut);
-
-	if (power_status_shaper != 0 && power_on == true)
-		BREAK_TO_DEBUGGER();
-
-	if (power_status_3dlut != 0 && power_on == true)
-		BREAK_TO_DEBUGGER();
-}
-
-void mpc42_configure_rmcm_shaper_lut(
-	struct mpc *mpc,
-	bool is_ram_a,
-	uint32_t mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_G_B[mpcc_id],
-		MPC_RMCM_SHAPER_SCALE_B, 0x7000);
-	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_G_B[mpcc_id],
-		MPC_RMCM_SHAPER_SCALE_G, 0x7000);
-	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_R[mpcc_id],
-		MPC_RMCM_SHAPER_SCALE_R, 0x7000);
-	REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
-	REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_SEL, is_ram_a == true ? 0:1);
-	REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[mpcc_id], 0, MPC_RMCM_SHAPER_LUT_INDEX, 0);
-}
-
-void mpc42_program_rmcm_shaper_luta_settings(
-	struct mpc *mpc,
-	const struct pwl_params *params,
-	uint32_t mpcc_id)
-{
-	const struct gamma_curve *curve;
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_B[mpcc_id], 0,
-		MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].blue.custom_float_x,
-		MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_G[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].green.custom_float_x,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_R[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].red.custom_float_x,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
-
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_B[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].blue.custom_float_x,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].blue.custom_float_y);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_G[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].green.custom_float_x,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].green.custom_float_y);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_R[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].red.custom_float_x,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].red.custom_float_y);
-
-	curve = params->arr_curve_points;
-	if (curve) {
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_0_1[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_2_3[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_4_5[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_6_7[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_8_9[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_10_11[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_12_13[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_14_15[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_16_17[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_18_19[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_20_21[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_22_23[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_24_25[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_26_27[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_28_29[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_30_31[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_32_33[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-	}
-}
-
-
-void mpc42_program_rmcm_shaper_lutb_settings(
-	struct mpc *mpc,
-	const struct pwl_params *params,
-	uint32_t mpcc_id)
-{
-	const struct gamma_curve *curve;
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_B[mpcc_id], 0,
-		MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].blue.custom_float_x,
-		MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_G[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].green.custom_float_x,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_R[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].red.custom_float_x,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
-
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_B[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].blue.custom_float_x,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].blue.custom_float_y);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_G[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].green.custom_float_x,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].green.custom_float_y);
-	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_R[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].red.custom_float_x,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].red.custom_float_y);
-
-	curve = params->arr_curve_points;
-	if (curve) {
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_0_1[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_2_3[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_4_5[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_6_7[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_8_9[mpcc_id], 0,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_10_11[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_12_13[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_14_15[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_16_17[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_18_19[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_20_21[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_22_23[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_24_25[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_26_27[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_28_29[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_30_31[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-
-		curve += 2;
-		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_32_33[mpcc_id], 0,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
-				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
-	}
-}
-
-void mpc42_program_rmcm_shaper_lut(
-	struct mpc *mpc,
-	const struct pwl_result_data *rgb,
-	uint32_t num,
-	uint32_t mpcc_id)
-{
-	uint32_t i, red, green, blue;
-	uint32_t  red_delta, green_delta, blue_delta;
-	uint32_t  red_value, green_value, blue_value;
-
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	for (i = 0; i < num; i++) {
-
-		red   = rgb[i].red_reg;
-		green = rgb[i].green_reg;
-		blue  = rgb[i].blue_reg;
-
-		red_delta   = rgb[i].delta_red_reg;
-		green_delta = rgb[i].delta_green_reg;
-		blue_delta  = rgb[i].delta_blue_reg;
-
-		red_value   = ((red_delta   & 0x3ff) << 14) | (red   & 0x3fff);
-		green_value = ((green_delta & 0x3ff) << 14) | (green & 0x3fff);
-		blue_value  = ((blue_delta  & 0x3ff) << 14) | (blue  & 0x3fff);
-
-		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[mpcc_id], 0, MPC_RMCM_SHAPER_LUT_DATA, red_value);
-		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[mpcc_id], 0, MPC_RMCM_SHAPER_LUT_DATA, green_value);
-		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[mpcc_id], 0, MPC_RMCM_SHAPER_LUT_DATA, blue_value);
-	}
-}
-
-void mpc42_enable_3dlut_fl(struct mpc *mpc, bool enable, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	//if enabled cho0se mpc 0, else: off (default value)
-	REG_UPDATE(MPC_RMCM_CNTL[mpcc_id], MPC_RMCM_CNTL, enable ? 0 : 0xF); //0xF is not connected
-
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id], MPC_RMCM_3DLUT_WRITE_EN_MASK, 0);
-
-	REG_UPDATE(MPC_RMCM_MEM_PWR_CTRL[mpcc_id], MPC_RMCM_3DLUT_MEM_PWR_DIS, enable ? 0 : 3);
-}
-
-void mpc42_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp_idx)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_SET(MPC_RMCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0,
-		MPC_RMCM_3DLUT_FL_SEL,
-		hubp_idx);
-}
-
-void mpc42_populate_rmcm_lut(struct mpc *mpc, const union mcm_lut_params params,
-	bool lut_bank_a, int mpcc_id)
-{
-	const enum dc_lut_mode next_mode = lut_bank_a ? LUT_RAM_A : LUT_RAM_B;
-	const struct pwl_params *lut_shaper = params.pwl;
-
-	if (lut_shaper == NULL)
-		return;
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
-		mpc42_power_on_rmcm_shaper_3dlut(mpc, mpcc_id, true);
-
-	mpc42_configure_rmcm_shaper_lut(mpc, next_mode == LUT_RAM_A, mpcc_id);
-
-	if (next_mode == LUT_RAM_A)
-		mpc42_program_rmcm_shaper_luta_settings(mpc, lut_shaper, mpcc_id);
-	else
-		mpc42_program_rmcm_shaper_lutb_settings(mpc, lut_shaper, mpcc_id);
-
-	mpc42_program_rmcm_shaper_lut(
-			mpc, lut_shaper->rgb_resulted, lut_shaper->hw_points_num, mpcc_id);
-
-	mpc42_power_on_rmcm_shaper_3dlut(mpc, mpcc_id, false);
-}
-
-void mpc42_program_rmcm_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_ID id,
-	bool lut_bank_a, bool enabled, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	switch (id) {
-	case MCM_LUT_3DLUT:
-		REG_UPDATE(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_MODE,
-			(!enabled) ? 0 :
-			(lut_bank_a) ? 1 : 2);
-
-		REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-			MPC_RMCM_3DLUT_RAM_SEL,
-			(lut_bank_a) ? 0 : 1);
-		break;
-	case MCM_LUT_SHAPER:
-		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
-
-		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_SEL,
-			lut_bank_a == true ? 0:1);
-
-		REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[mpcc_id], 0,
-			MPC_RMCM_SHAPER_LUT_INDEX, 0);
-		break;
-	default:
-		break;
-	}
-}
-
-void mpc42_program_lut_mode(struct mpc *mpc,
-	bool enable,
-	bool lut_bank_a,
-	int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	if (enable) {
-		REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[mpcc_id], MPC_RMCM_SHAPER_LUT_MODE, lut_bank_a ? 1 : 2);
-	} else {
-		REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[mpcc_id], MPC_RMCM_SHAPER_LUT_MODE, 0);
-	}
-}
-
-static uint32_t mpc42_get_rmcm_3dlut_width(
-		const enum dc_cm_lut_size size)
-{
-	uint32_t width = 0;
-
-	switch (size) {
-	case CM_LUT_SIZE_333333:
-		width = 2;
-		break;
-	case CM_LUT_SIZE_171717:
-	default:
-		width = 0;
-		break;
-	}
-
-	return width;
-}
-
-void mpc42_program_rmcm_3dlut_size(struct mpc *mpc,
-		const enum dc_cm_lut_size size,
-		int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	uint32_t width = mpc42_get_rmcm_3dlut_width(size);
-
-	REG_UPDATE(MPC_RMCM_3DLUT_MODE[mpcc_id],
-			MPC_RMCM_3DLUT_SIZE, width);
-}
 
-void mpc42_program_rmcm_3dlut_fast_load_bias_scale(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_R[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_R, bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_R, scale);
-
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_G[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_G, bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_G, scale);
-
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_B[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_B, bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_B, scale);
-}
-
-void mpc42_program_rmcm_bit_depth(struct mpc *mpc, uint16_t bit_depth, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id], MPC_RMCM_3DLUT_WRITE_EN_MASK, 0xF);
-
-	//program bit_depth
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-		MPC_RMCM_3DLUT_30BIT_EN,
-		(bit_depth == 10) ? 1 : 0);
-}
-
-void mpc42_set_fl_config(
-	struct mpc *mpc,
-	struct mpc_fl_3dlut_config *cfg,
-	int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	uint32_t width = mpc42_get_rmcm_3dlut_width(cfg->size);
-	/*
-	From: Jie Zhou
-
-		To program any of the memories content.  The following sequence is used.
-	Set the MPCC_OGAM/SHAPER/3DLUT/1DLUT_PWR_DIS to 1 (Only need to set the one
-	that is being programmed) Set DISPCLK_G_PIPE<i>_GATE_DISABLE to 1 for the
-	MPCC pipe that’s being used, so the memory’s clock is ungated. Program the
-	target memory. Set the MPCC_OGAM/SHAPER/3DLUT/1DLUT_PWR_DIS back to 0.
-	Set DISPCLK_G_PIPE<i>_GATE_DISABLE back to 0
-	*/
-
-	//disconnect fl from mpc
-	REG_SET(MPCC_MCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0,
-		MPCC_MCM_3DLUT_FL_SEL, 0xF);
-
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-		MPC_RMCM_3DLUT_WRITE_EN_MASK, 0xF);
-
-	//program bit_depth
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-		MPC_RMCM_3DLUT_30BIT_EN, (cfg->bit_depth == 10) ? 1 : 0);
-
-	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-		MPC_RMCM_3DLUT_RAM_SEL, (cfg->select_lut_bank_a) ? 0 : 1);
-
-	//bias and scale
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_R[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_R, cfg->bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_R, cfg->scale);
-
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_G[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_G, cfg->bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_G, cfg->scale);
-
-	REG_UPDATE_2(MPC_RMCM_3DLUT_OUT_OFFSET_B[mpcc_id],
-		MPC_RMCM_3DLUT_OUT_OFFSET_B, cfg->bias,
-		MPC_RMCM_3DLUT_OUT_SCALE_B, cfg->scale);
-
-	//width
-	REG_UPDATE_2(MPC_RMCM_3DLUT_MODE[mpcc_id],
-		MPC_RMCM_3DLUT_SIZE, width,
-		MPC_RMCM_3DLUT_MODE, (!cfg->enabled) ? 0 : (cfg->select_lut_bank_a) ? 1 : 2);
-
-	//connect to hubp
-	REG_SET(MPC_RMCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0,
-		MPC_RMCM_3DLUT_FL_SEL, cfg->hubp_index);
-
-	//ENABLE
-	//if enabled pick mpc 0, else: off (0xF)
-	//in future we'll select specific MPC
-	REG_UPDATE(MPC_RMCM_CNTL[mpcc_id], MPC_RMCM_CNTL, cfg->enabled ? 0 : 0xF);
-}
-
-void mpc42_get_rmcm_3dlut_mode(
-	struct mpc *mpc,
-	int mpcc_id,
-	bool *enable,
-	bool *lut_bank_a)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	uint32_t mode_current   = 0;
-
-	REG_GET(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_MODE_CURRENT, &mode_current);
-
-	/* MPC_RMCM_3DLUT_MODE encoding:
-	 *   0 -> disabled, 1 -> bank A, 2 -> bank B
-	 */
-	*enable     = mode_current != 0;
-	*lut_bank_a = mode_current != 2;
-}
 
 void mpc42_read_mpcc_state(
 		struct mpc *mpc,
 		int mpcc_inst,
 		struct mpcc_state *s)
 {
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
 	mpc1_read_mpcc_state(mpc, mpcc_inst, s);
-
-	if (mpcc_inst < 2) {
-		/* RMCM 3DLUT Status */
-		REG_GET_4(MPC_RMCM_MEM_PWR_CTRL[mpcc_inst], MPC_RMCM_3DLUT_MEM_PWR_FORCE, &s->rmcm_regs.rmcm_3dlut_mem_pwr_force,
-				MPC_RMCM_3DLUT_MEM_PWR_DIS, &s->rmcm_regs.rmcm_3dlut_mem_pwr_dis,
-				MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE, &s->rmcm_regs.rmcm_3dlut_mem_pwr_mode,
-				MPC_RMCM_3DLUT_MEM_PWR_STATE, &s->rmcm_regs.rmcm_3dlut_mem_pwr_state);
-
-		REG_GET_3(MPC_RMCM_3DLUT_MODE[mpcc_inst], MPC_RMCM_3DLUT_SIZE, &s->rmcm_regs.rmcm_3dlut_size,
-				MPC_RMCM_3DLUT_MODE, &s->rmcm_regs.rmcm_3dlut_mode,
-				MPC_RMCM_3DLUT_MODE_CURRENT, &s->rmcm_regs.rmcm_3dlut_mode_cur);
-
-		REG_GET_4(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[mpcc_inst], MPC_RMCM_3DLUT_READ_SEL, &s->rmcm_regs.rmcm_3dlut_read_sel,
-				MPC_RMCM_3DLUT_30BIT_EN, &s->rmcm_regs.rmcm_3dlut_30bit_en,
-				MPC_RMCM_3DLUT_WRITE_EN_MASK, &s->rmcm_regs.rmcm_3dlut_wr_en_mask,
-				MPC_RMCM_3DLUT_RAM_SEL, &s->rmcm_regs.rmcm_3dlut_ram_sel);
-
-		REG_GET(MPC_RMCM_3DLUT_OUT_NORM_FACTOR[mpcc_inst], MPC_RMCM_3DLUT_OUT_NORM_FACTOR, &s->rmcm_regs.rmcm_3dlut_out_norm_factor);
-
-		REG_GET(MPC_RMCM_3DLUT_FAST_LOAD_SELECT[mpcc_inst], MPC_RMCM_3DLUT_FL_SEL, &s->rmcm_regs.rmcm_3dlut_fl_sel);
-
-		REG_GET_2(MPC_RMCM_3DLUT_OUT_OFFSET_R[mpcc_inst], MPC_RMCM_3DLUT_OUT_OFFSET_R, &s->rmcm_regs.rmcm_3dlut_out_offset_r,
-				MPC_RMCM_3DLUT_OUT_SCALE_R, &s->rmcm_regs.rmcm_3dlut_out_scale_r);
-
-		REG_GET_3(MPC_RMCM_3DLUT_FAST_LOAD_STATUS[mpcc_inst], MPC_RMCM_3DLUT_FL_DONE, &s->rmcm_regs.rmcm_3dlut_fl_done,
-				MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, &s->rmcm_regs.rmcm_3dlut_fl_soft_underflow,
-				MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, &s->rmcm_regs.rmcm_3dlut_fl_hard_underflow);
-
-		/* RMCM Shaper Status */
-		REG_GET_4(MPC_RMCM_MEM_PWR_CTRL[mpcc_inst], MPC_RMCM_SHAPER_MEM_PWR_FORCE, &s->rmcm_regs.rmcm_shaper_mem_pwr_force,
-				MPC_RMCM_SHAPER_MEM_PWR_DIS, &s->rmcm_regs.rmcm_shaper_mem_pwr_dis,
-				MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE, &s->rmcm_regs.rmcm_shaper_mem_pwr_mode,
-				MPC_RMCM_SHAPER_MEM_PWR_STATE, &s->rmcm_regs.rmcm_shaper_mem_pwr_state);
-
-		REG_GET_2(MPC_RMCM_SHAPER_CONTROL[mpcc_inst], MPC_RMCM_SHAPER_LUT_MODE, &s->rmcm_regs.rmcm_shaper_lut_mode,
-				MPC_RMCM_SHAPER_MODE_CURRENT, &s->rmcm_regs.rmcm_shaper_mode_cur);
-
-		REG_GET_2(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_inst], MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, &s->rmcm_regs.rmcm_shaper_lut_write_en_mask,
-				MPC_RMCM_SHAPER_LUT_WRITE_SEL, &s->rmcm_regs.rmcm_shaper_lut_write_sel);
-
-		REG_GET(MPC_RMCM_SHAPER_OFFSET_B[mpcc_inst], MPC_RMCM_SHAPER_OFFSET_B, &s->rmcm_regs.rmcm_shaper_offset_b);
-
-		REG_GET(MPC_RMCM_SHAPER_SCALE_G_B[mpcc_inst], MPC_RMCM_SHAPER_SCALE_B, &s->rmcm_regs.rmcm_shaper_scale_b);
-
-		REG_GET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_B[mpcc_inst], MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, &s->rmcm_regs.rmcm_shaper_rama_exp_region_start_b,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, &s->rmcm_regs.rmcm_shaper_rama_exp_region_start_seg_b);
-
-		REG_GET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_B[mpcc_inst], MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, &s->rmcm_regs.rmcm_shaper_rama_exp_region_end_b,
-				MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, &s->rmcm_regs.rmcm_shaper_rama_exp_region_end_base_b);
-
-		REG_GET(MPC_RMCM_CNTL[mpcc_inst], MPC_RMCM_CNTL, &s->rmcm_regs.rmcm_cntl);
-	}
 }
 
 static const struct mpc_funcs dcn42_mpc_funcs = {
@@ -774,19 +108,6 @@ static const struct mpc_funcs dcn42_mpc_funcs = {
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
 	.get_lut_mode = mpc401_get_lut_mode,
-	.rmcm = {
-		.enable_3dlut_fl = mpc42_enable_3dlut_fl,
-		.update_3dlut_fast_load_select = mpc42_update_3dlut_fast_load_select,
-		.program_lut_read_write_control = mpc42_program_rmcm_lut_read_write_control,
-		.program_lut_mode = mpc42_program_lut_mode,
-		.program_3dlut_size = mpc42_program_rmcm_3dlut_size,
-		.program_bias_scale = mpc42_program_rmcm_3dlut_fast_load_bias_scale,
-		.program_bit_depth = mpc42_program_rmcm_bit_depth,
-		.power_on_shaper_3dlut = mpc42_power_on_rmcm_shaper_3dlut,
-		.populate_lut = mpc42_populate_rmcm_lut,
-		.fl_3dlut_configure = mpc42_set_fl_config,
-		.get_3dlut_mode = mpc42_get_rmcm_3dlut_mode,
-	},
 };
 
 void dcn42_mpc_construct(struct dcn42_mpc *mpc42,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
index af3b90af5396..213380832087 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
@@ -196,327 +196,7 @@
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM_3DLUT_OUT_OFFSET_G, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM_3DLUT_OUT_SCALE_G, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM_3DLUT_OUT_OFFSET_B, mask_sh),\
-	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM_3DLUT_OUT_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_LUT_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_R, MPC_RMCM_SHAPER_OFFSET_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_G, MPC_RMCM_SHAPER_OFFSET_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_B, MPC_RMCM_SHAPER_OFFSET_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_R, MPC_RMCM_SHAPER_SCALE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_INDEX, MPC_RMCM_SHAPER_LUT_INDEX, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_DATA, MPC_RMCM_SHAPER_LUT_DATA, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_SIZE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_INDEX, MPC_RMCM_3DLUT_INDEX, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA0, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA1, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA_30BIT, MPC_RMCM_3DLUT_DATA_30BIT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_WRITE_EN_MASK, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_RAM_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_30BIT_EN, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_READ_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_NORM_FACTOR, MPC_RMCM_3DLUT_OUT_NORM_FACTOR, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_OFFSET_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_SCALE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_OFFSET_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_SCALE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_OFFSET_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C11_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C12_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C13_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C14_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C21_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C22_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C23_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C24_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C31_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C32_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C33_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C34_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C11_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C12_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C13_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C14_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C21_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C22_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C23_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C24_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C31_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C32_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C33_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C34_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_FORCE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_DIS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_FORCE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_DIS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_STATE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_STATE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_SELECT, MPC_RMCM_3DLUT_FL_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_DONE, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_CNTL, MPC_RMCM_CNTL, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_INDEX, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_WRITE_EN, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_DATA, MPC_RMCM_TEST_DEBUG_DATA, mask_sh)
-
-#define MPC_RMCM_REG_LIST_DCN42(inst)\
-	SRII(MPC_RMCM_SHAPER_CONTROL, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_OFFSET_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_OFFSET_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_OFFSET_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_SCALE_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_LUT_INDEX, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_LUT_DATA, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_MODE, MPC_RMCM, inst), /*TODO: may need to add other 3DLUT regs*/\
-	SRII(MPC_RMCM_3DLUT_INDEX, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_DATA, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_DATA_30BIT, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_OUT_NORM_FACTOR, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_FAST_LOAD_SELECT, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_CNTL, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM, inst),\
-	SRII(MPC_RMCM_TEST_DEBUG_DATA, MPC_RMCM, inst)
-
+	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM_3DLUT_OUT_SCALE_B, mask_sh)
 
 #define MPC_REG_LIST_DCN42(inst) \
 	MPC_REG_LIST_DCN4_01_RI(inst),\
@@ -529,328 +209,11 @@
 	type MPCC_MCM_3DLUT_OUT_OFFSET_G;\
 	type MPCC_MCM_3DLUT_OUT_SCALE_G;\
 	type MPCC_MCM_3DLUT_OUT_OFFSET_B;\
-	type MPCC_MCM_3DLUT_OUT_SCALE_B;\
-	type MPC_RMCM_SHAPER_LUT_MODE;\
-	type MPC_RMCM_SHAPER_MODE_CURRENT;\
-	type MPC_RMCM_SHAPER_OFFSET_R;\
-	type MPC_RMCM_SHAPER_OFFSET_G;\
-	type MPC_RMCM_SHAPER_OFFSET_B;\
-	type MPC_RMCM_SHAPER_SCALE_R;\
-	type MPC_RMCM_SHAPER_SCALE_G;\
-	type MPC_RMCM_SHAPER_SCALE_B;\
-	type MPC_RMCM_SHAPER_LUT_INDEX;\
-	type MPC_RMCM_SHAPER_LUT_DATA;\
-	type MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK;\
-	type MPC_RMCM_SHAPER_LUT_WRITE_SEL; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_G; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_G;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_R;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_R;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_G;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_G;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_R;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_R;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION2_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION2_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION3_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION3_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION4_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION4_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION5_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION5_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION6_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION6_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION7_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION7_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION8_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION8_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION9_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION9_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION10_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION10_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION11_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION11_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION12_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION12_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION13_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION13_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION14_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION14_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION15_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION15_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION16_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION16_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION17_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION17_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION18_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION18_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION19_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION19_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION20_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION20_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION21_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION21_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION22_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION22_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION23_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION23_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION24_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION24_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION25_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION25_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION26_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION26_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION27_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION27_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION28_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION28_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION29_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION29_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION30_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION30_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION31_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION31_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION32_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION32_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION33_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMA_EXP_REGION33_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_G; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_G;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_R;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_R;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_G;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_G;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_R;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_R;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION2_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION2_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION3_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION3_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION4_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION4_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION5_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION5_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION6_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION6_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION7_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION7_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION8_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION8_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION9_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION9_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION10_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION10_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION11_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION11_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION12_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION12_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION13_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION13_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION14_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION14_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION15_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION15_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION16_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION16_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION17_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION17_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION18_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION18_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION19_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION19_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION20_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION20_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION21_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION21_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION22_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION22_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION23_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION23_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION24_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION24_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION25_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION25_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION26_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION26_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION27_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION27_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION28_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION28_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION29_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION29_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION30_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION30_NUM_SEGMENTS;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION31_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION31_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION32_LUT_OFFSET; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION32_NUM_SEGMENTS; \
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION33_LUT_OFFSET;\
-	type MPC_RMCM_SHAPER_RAMB_EXP_REGION33_NUM_SEGMENTS;\
-	type MPC_RMCM_3DLUT_MODE;\
-	type MPC_RMCM_3DLUT_SIZE;\
-	type MPC_RMCM_3DLUT_MODE_CURRENT;\
-	type MPC_RMCM_3DLUT_INDEX; \
-	type MPC_RMCM_3DLUT_DATA0; \
-	type MPC_RMCM_3DLUT_DATA1; \
-	type MPC_RMCM_3DLUT_DATA_30BIT; \
-	type MPC_RMCM_3DLUT_WRITE_EN_MASK;\
-	type MPC_RMCM_3DLUT_RAM_SEL;\
-	type MPC_RMCM_3DLUT_30BIT_EN;\
-	type MPC_RMCM_3DLUT_READ_SEL;\
-	type MPC_RMCM_3DLUT_OUT_NORM_FACTOR;\
-	type MPC_RMCM_3DLUT_OUT_OFFSET_R;\
-	type MPC_RMCM_3DLUT_OUT_SCALE_R; \
-	type MPC_RMCM_3DLUT_OUT_OFFSET_G; \
-	type MPC_RMCM_3DLUT_OUT_SCALE_G; \
-	type MPC_RMCM_3DLUT_OUT_OFFSET_B; \
-	type MPC_RMCM_3DLUT_OUT_SCALE_B;\
-	type MPC_RMCM_GAMUT_REMAP_COEF_FORMAT;\
-	type MPC_RMCM_GAMUT_REMAP_MODE;\
-	type MPC_RMCM_GAMUT_REMAP_MODE_CURRENT;\
-	type MPC_RMCM_GAMUT_REMAP_C11_A;\
-	type MPC_RMCM_GAMUT_REMAP_C12_A;\
-	type MPC_RMCM_GAMUT_REMAP_C13_A; \
-	type MPC_RMCM_GAMUT_REMAP_C14_A; \
-	type MPC_RMCM_GAMUT_REMAP_C21_A; \
-	type MPC_RMCM_GAMUT_REMAP_C22_A; \
-	type MPC_RMCM_GAMUT_REMAP_C23_A;\
-	type MPC_RMCM_GAMUT_REMAP_C24_A;\
-	type MPC_RMCM_GAMUT_REMAP_C31_A;\
-	type MPC_RMCM_GAMUT_REMAP_C32_A;\
-	type MPC_RMCM_GAMUT_REMAP_C33_A;\
-	type MPC_RMCM_GAMUT_REMAP_C34_A;\
-	type MPC_RMCM_GAMUT_REMAP_C11_B;\
-	type MPC_RMCM_GAMUT_REMAP_C12_B;\
-	type MPC_RMCM_GAMUT_REMAP_C13_B; \
-	type MPC_RMCM_GAMUT_REMAP_C14_B; \
-	type MPC_RMCM_GAMUT_REMAP_C21_B; \
-	type MPC_RMCM_GAMUT_REMAP_C22_B; \
-	type MPC_RMCM_GAMUT_REMAP_C23_B;\
-	type MPC_RMCM_GAMUT_REMAP_C24_B;\
-	type MPC_RMCM_GAMUT_REMAP_C31_B;\
-	type MPC_RMCM_GAMUT_REMAP_C32_B;\
-	type MPC_RMCM_GAMUT_REMAP_C33_B;\
-	type MPC_RMCM_GAMUT_REMAP_C34_B;\
-	type MPC_RMCM_SHAPER_MEM_PWR_FORCE; \
-	type MPC_RMCM_SHAPER_MEM_PWR_DIS; \
-	type MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE; \
-	type MPC_RMCM_3DLUT_MEM_PWR_FORCE;\
-	type MPC_RMCM_3DLUT_MEM_PWR_DIS;\
-	type MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE;\
-	type MPC_RMCM_SHAPER_MEM_PWR_STATE;\
-	type MPC_RMCM_3DLUT_MEM_PWR_STATE;\
-	type MPC_RMCM_3DLUT_FL_SEL;\
-	type MPC_RMCM_3DLUT_FL_DONE; \
-	type MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW; \
-	type MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW; \
-	type MPC_RMCM_CNTL; \
-	type MPC_RMCM_TEST_DEBUG_INDEX;\
-	type MPC_RMCM_TEST_DEBUG_WRITE_EN;\
-	type MPC_RMCM_TEST_DEBUG_DATA
+	type MPCC_MCM_3DLUT_OUT_SCALE_B
 
 #define MPC_REG_VARIABLE_LIST_DCN42 \
 	MPC_REG_VARIABLE_LIST_DCN4_01 \
-	uint32_t MPCC_CONTROL2[MAX_MPCC];\
-	uint32_t MPC_RMCM_SHAPER_CONTROL[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_OFFSET_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_OFFSET_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_OFFSET_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_SCALE_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_SCALE_G_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_LUT_INDEX[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_LUT_DATA[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_0_1[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_2_3[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_4_5[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_6_7[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_8_9[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_10_11[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_12_13[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_14_15[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_16_17[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_18_19[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_20_21[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_22_23[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_24_25[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_26_27[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_28_29[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_30_31[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_32_33[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_0_1[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_2_3[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_4_5[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_6_7[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_8_9[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_10_11[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_12_13[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_14_15[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_16_17[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_18_19[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_20_21[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_22_23[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_24_25[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_26_27[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_28_29[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_30_31[MAX_MPCC]; \
-	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_32_33[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_MODE[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_INDEX[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_DATA[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_DATA_30BIT[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_READ_WRITE_CONTROL[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_OUT_NORM_FACTOR[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_R[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_G[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_COEF_FORMAT[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_MODE[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C11_C12_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C13_C14_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C21_C22_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C23_C24_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C31_C32_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C33_C34_A[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C11_C12_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C13_C14_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C21_C22_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C23_C24_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C31_C32_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_GAMUT_REMAP_C33_C34_B[MAX_MPCC]; \
-	uint32_t MPC_RMCM_MEM_PWR_CTRL[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_FAST_LOAD_SELECT[MAX_MPCC]; \
-	uint32_t MPC_RMCM_3DLUT_FAST_LOAD_STATUS[MAX_MPCC]; \
-	uint32_t MPC_RMCM_CNTL[MAX_MPCC]; \
-	uint32_t MPC_RMCM_TEST_DEBUG_INDEX[MAX_MPCC]; \
-	uint32_t MPC_RMCM_TEST_DEBUG_DATA[MAX_MPCC]
+	uint32_t MPCC_CONTROL2[MAX_MPCC]
 
 struct dcn42_mpc_shift {
 	MPC_REG_FIELD_LIST_DCN42(uint8_t);
@@ -884,77 +247,6 @@ void dcn42_mpc_construct(struct dcn42_mpc *mpc401,
 
 void mpc42_init_mpcc(struct mpcc *mpcc, int mpcc_inst);
 
-/* RMCM */
-void mpc42_program_rmcm_shaper_lut(
-		struct mpc *mpc,
-		const struct pwl_result_data *rgb,
-		uint32_t num,
-		uint32_t mpcc_id);
-void mpc42_program_rmcm_shaper_lutb_settings(
-		struct mpc *mpc,
-		const struct pwl_params *params,
-		uint32_t mpcc_id);
-void mpc42_program_rmcm_shaper_luta_settings(
-		struct mpc *mpc,
-		const struct pwl_params *params,
-		uint32_t mpcc_id);
-void mpc42_configure_rmcm_shaper_lut(
-		struct mpc *mpc,
-		bool is_ram_a,
-		uint32_t mpcc_id);
-void mpc42_power_on_rmcm_shaper_3dlut(
-		struct mpc *mpc,
-		uint32_t mpcc_id,
-		bool power_on);
-void mpc42_enable_3dlut_fl(
-		struct mpc *mpc,
-		bool enable,
-		int mpcc_id);
-void mpc42_update_3dlut_fast_load_select(
-		struct mpc *mpc,
-		int mpcc_id,
-		int hubp_idx);
-void mpc42_populate_rmcm_lut(
-		struct mpc *mpc,
-		const union mcm_lut_params params,
-		bool lut_bank_a,
-		int mpcc_id);
-void mpc42_program_rmcm_lut_read_write_control(
-		struct mpc *mpc,
-		const enum MCM_LUT_ID id,
-		bool lut_bank_a,
-		bool enabled,
-		int mpcc_id);
-void mpc42_program_lut_mode(
-		struct mpc *mpc,
-		bool enable,
-		bool lut_bank_a,
-		int mpcc_id);
-void mpc42_program_rmcm_3dlut_size(
-		struct mpc *mpc,
-		const enum dc_cm_lut_size size,
-		int mpcc_id);
-void mpc42_program_rmcm_3dlut_fast_load_bias_scale(
-		struct mpc *mpc,
-		uint16_t bias,
-		uint16_t scale,
-		int mpcc_id);
-void mpc42_program_rmcm_bit_depth(
-		struct mpc *mpc,
-		uint16_t bit_depth,
-		int mpcc_id);
-
-void mpc42_set_fl_config(
-	struct mpc *mpc,
-	struct mpc_fl_3dlut_config *cfg,
-	int mpcc_id);
-
-void mpc42_get_rmcm_3dlut_mode(
-	struct mpc *mpc,
-	int mpcc_id,
-	bool *enable,
-	bool *lut_bank_a);
-
 void mpc42_read_mpcc_state(
 		struct mpc *mpc,
 		int mpcc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
index 2c0b92854a9c..ae6f2f1b7eca 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
@@ -111,34 +111,6 @@ static struct mpcc *mpc60_insert_plane(
 	return new_mpcc;
 }
 
-void mpc60_program_rmcm_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_ID id,
-	bool lut_bank_a, bool enabled, int mpcc_id)
-{
-	struct dcn60_mpc *mpc60 = TO_DCN60_MPC(mpc);
-
-	switch (id) {
-	case MCM_LUT_3DLUT:
-		REG_UPDATE(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_MODE,
-			(!enabled) ? 0 :
-			(lut_bank_a) ? 1 : 2);
-		break;
-
-	case MCM_LUT_SHAPER:
-		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
-
-		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPC_RMCM_SHAPER_LUT_WRITE_SEL,
-			lut_bank_a == true ? 0 : 1);
-
-		REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[mpcc_id], 0,
-			MPC_RMCM_SHAPER_LUT_INDEX, 0);
-		break;
-	default:
-		break;
-	}
-}
-
 static void mpc60_program_lut_read_write_control(struct mpc *mpc,
 		const enum MCM_LUT_ID id,
 		const bool lut_bank_a,
@@ -288,18 +260,6 @@ static const struct mpc_funcs dcn60_mpc_funcs = {
 	.program_lut_read_write_control = mpc60_program_lut_read_write_control,
 	.program_lut_mode = mpc60_program_lut_mode,
 	.get_lut_mode = mpc401_get_lut_mode,
-	.rmcm = {
-		.enable_3dlut_fl = mpc42_enable_3dlut_fl,
-		.update_3dlut_fast_load_select = mpc42_update_3dlut_fast_load_select,
-		.program_lut_read_write_control = mpc60_program_rmcm_lut_read_write_control,
-		.program_lut_mode = mpc42_program_lut_mode,
-		.program_3dlut_size = mpc42_program_rmcm_3dlut_size,
-		.program_bias_scale = mpc42_program_rmcm_3dlut_fast_load_bias_scale,
-		.program_bit_depth = mpc42_program_rmcm_bit_depth,
-		.power_on_shaper_3dlut = mpc42_power_on_rmcm_shaper_3dlut,
-		.populate_lut = mpc42_populate_rmcm_lut,
-		.get_3dlut_mode = mpc42_get_rmcm_3dlut_mode,
-	},
 };
 
 void dcn60_mpc_construct(struct dcn60_mpc *mpc60,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
index 640a322d15c1..44ee84d74104 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
@@ -180,238 +180,6 @@
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM_3DLUT_OUT_SCALE_G, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM_3DLUT_OUT_OFFSET_B, mask_sh),\
 	SF(MPCC_MCM0_MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM_3DLUT_OUT_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_LUT_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_R, MPC_RMCM_SHAPER_OFFSET_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_G, MPC_RMCM_SHAPER_OFFSET_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_B, MPC_RMCM_SHAPER_OFFSET_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_R, MPC_RMCM_SHAPER_SCALE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_INDEX, MPC_RMCM_SHAPER_LUT_INDEX, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_DATA, MPC_RMCM_SHAPER_LUT_DATA, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_LUT_OFFSET, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_SIZE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_INDEX, MPC_RMCM_3DLUT_INDEX, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA0, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA1, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA_30BIT, MPC_RMCM_3DLUT_DATA_30BIT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_WRITE_EN_MASK, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_30BIT_EN, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_READ_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_NORM_FACTOR, MPC_RMCM_3DLUT_OUT_NORM_FACTOR, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_OFFSET_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_SCALE_R, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_OFFSET_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_SCALE_G, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_OFFSET_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_SCALE_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE_CURRENT, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C11_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C12_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C13_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C14_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C21_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C22_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C23_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C24_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C31_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C32_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C33_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C34_A, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C11_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C12_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C13_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C14_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C21_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C22_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C23_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C24_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C31_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C32_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C33_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C34_B, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_FORCE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_DIS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_FORCE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_DIS, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_STATE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_STATE, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_SELECT, MPC_RMCM_3DLUT_FL_SEL, mask_sh),\
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_DONE, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_CNTL, MPC_RMCM_CNTL, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_INDEX, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_WRITE_EN, mask_sh), \
-	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_DATA, MPC_RMCM_TEST_DEBUG_DATA, mask_sh), \
 	SF(MPC_OUT0_CSC_MODE, MPC_OCSC_MODE, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C11_A, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C12_A, mask_sh),\
@@ -463,10 +231,4 @@ void dcn60_mpc_construct(struct dcn60_mpc *mpc401,
 	const struct dcn60_mpc_mask *mpc_mask,
 	int num_mpcc,
 	int num_rmu);
-
-void mpc60_program_rmcm_lut_read_write_control(struct mpc *mpc,
-	const enum MCM_LUT_ID id,
-	bool lut_bank_a,
-	bool enabled,
-	int mpcc_id);
 #endif /* DCN60_MPC_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index bcfde21b6d79..7c271dd264c9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -27,6 +27,7 @@
 #include "dcn42/dcn42_hubbub.h"
 #include "dcn401/dcn401_mpc.h"
 #include "dcn42/dcn42_mpc.h"
+#include "dcn42/dcn42_rmcm.h"
 #include "dcn35/dcn35_hubp.h"
 #include "dcn42/dcn42_hubp.h"
 #include "irq/dcn42/irq_service_dcn42.h"
@@ -436,9 +437,7 @@ static struct dcn42_mpc_registers mpc_regs;
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1), \
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2), \
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3), \
-		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0), \
-		MPC_RMCM_REG_LIST_DCN42(0),		   \
-		MPC_RMCM_REG_LIST_DCN42(1)
+		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
 
 static const struct dcn42_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
@@ -446,6 +445,18 @@ static const struct dcn42_mpc_shift mpc_shift = {
 static const struct dcn42_mpc_mask mpc_mask = {
 	MPC_COMMON_MASK_SH_LIST_DCN42(_MASK)};
 
+static struct dcn42_rmcm_registers rmcm_regs;
+
+#define dcn_rmcm_regs_init()               \
+	MPC_RMCM_REG_LIST_DCN42(0),            \
+		MPC_RMCM_REG_LIST_DCN42(1)
+
+static const struct dcn42_rmcm_shift rmcm_shift = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dcn42_rmcm_mask rmcm_mask = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(_MASK)};
+
 #define optc_regs_init(id) \
 	OPTC_COMMON_REG_LIST_DCN42_RI(id)
 
@@ -1071,6 +1082,29 @@ static struct mpc *dcn42_mpc_create(
 	return &mpc401->base;
 }
 
+static struct rmcm *dcn42_rmcm_create(
+	struct dc_context *ctx,
+	int inst)
+{
+	struct dcn42_rmcm *rmcm42 = kzalloc(sizeof(struct dcn42_rmcm), GFP_KERNEL);
+
+	if (!rmcm42)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT rmcm_regs
+	dcn_rmcm_regs_init();
+
+	dcn42_rmcm_construct(rmcm42,
+		ctx,
+		&rmcm_regs,
+		&rmcm_shift,
+		&rmcm_mask,
+		inst);
+
+	return &rmcm42->base;
+}
+
 static struct output_pixel_processor *dcn42_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
@@ -1550,6 +1584,12 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 		kfree(TO_DCN20_MPC(pool->base.mpc));
 		pool->base.mpc = NULL;
 	}
+	for (i = 0; i < MAX_RMCM_INST; i++) {
+		if (pool->base.rmcm[i] != NULL) {
+			kfree(TO_DCN42_RMCM(pool->base.rmcm[i]));
+			pool->base.rmcm[i] = NULL;
+		}
+	}
 	if (pool->base.hubbub != NULL) {
 		kfree(TO_DCN20_HUBBUB(pool->base.hubbub));
 		pool->base.hubbub = NULL;
@@ -2334,6 +2374,16 @@ static bool dcn42_resource_construct(
 		goto create_fail;
 	}
 
+	/* RMCMs */
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_rmcm && i < (unsigned int)MAX_RMCM_INST; i++) {
+		pool->base.rmcm[i] = dcn42_rmcm_create(ctx, i);
+		if (pool->base.rmcm[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create rmcm%d!\n", i);
+			goto create_fail;
+		}
+	}
+
 	/* DSCs */
 	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn42_dsc_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index b7bc24136f79..7b21badf7025 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -31,6 +31,7 @@
 #include "dcn42/dcn42_hubbub.h"
 #include "dcn401/dcn401_mpc.h"
 #include "dcn42/dcn42_mpc.h"
+#include "dcn42/dcn42_rmcm.h"
 #include "dcn35/dcn35_hubp.h"
 #include "dcn42/dcn42_hubp.h"
 #include "irq/dcn42/irq_service_dcn42.h"
@@ -486,9 +487,7 @@ static struct dcn42_mpc_registers mpc_regs;
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1), \
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2), \
 		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3), \
-		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0), \
-		MPC_RMCM_REG_LIST_DCN42(0),		   \
-		MPC_RMCM_REG_LIST_DCN42(1)
+		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
 
 static const struct dcn42_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
@@ -496,6 +495,18 @@ static const struct dcn42_mpc_shift mpc_shift = {
 static const struct dcn42_mpc_mask mpc_mask = {
 	MPC_COMMON_MASK_SH_LIST_DCN42(_MASK)};
 
+static struct dcn42_rmcm_registers rmcm_regs;
+
+#define dcn_rmcm_regs_init()               \
+	MPC_RMCM_REG_LIST_DCN42(0),            \
+		MPC_RMCM_REG_LIST_DCN42(1)
+
+static const struct dcn42_rmcm_shift rmcm_shift = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dcn42_rmcm_mask rmcm_mask = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(_MASK)};
+
 #define optc_regs_init(id) \
 	OPTC_COMMON_REG_LIST_DCN42B_RI(id)
 
@@ -758,6 +769,7 @@ static const struct resource_caps res_cap_dcn42b = {
 	.num_ddc = 0,
 	.num_vmid = 16,
 	.num_mpc_3dlut = 2,
+	.num_rmcm = 2,
 	.num_dsc = 3,
 	.num_rmcm = 2,
 	.num_mpc = 4,
@@ -1130,6 +1142,29 @@ static struct mpc *dcn42b_mpc_create(
 	return &mpc42b->base;
 }
 
+static struct rmcm *dcn42b_rmcm_create(
+	struct dc_context *ctx,
+	int inst)
+{
+	struct dcn42_rmcm *rmcm42 = kzalloc(sizeof(struct dcn42_rmcm), GFP_KERNEL);
+
+	if (!rmcm42)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT rmcm_regs
+	dcn_rmcm_regs_init();
+
+	dcn42_rmcm_construct(rmcm42,
+		ctx,
+		&rmcm_regs,
+		&rmcm_shift,
+		&rmcm_mask,
+		inst);
+
+	return &rmcm42->base;
+}
+
 static struct output_pixel_processor *dcn42b_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
@@ -1538,6 +1573,12 @@ static void dcn42b_resource_destruct(struct dcn42b_resource_pool *pool)
 		kfree(TO_DCN20_MPC(pool->base.mpc));
 		pool->base.mpc = NULL;
 	}
+	for (i = 0; i < MAX_RMCM_INST; i++) {
+		if (pool->base.rmcm[i] != NULL) {
+			kfree(TO_DCN42_RMCM(pool->base.rmcm[i]));
+			pool->base.rmcm[i] = NULL;
+		}
+	}
 	if (pool->base.hubbub != NULL) {
 		kfree(TO_DCN20_HUBBUB(pool->base.hubbub));
 		pool->base.hubbub = NULL;
@@ -2310,6 +2351,16 @@ static bool dcn42b_resource_construct(
 		goto create_fail;
 	}
 
+	/* RMCMs */
+	for (i = 0; i < pool->base.res_cap->num_rmcm && i < MAX_RMCM_INST; i++) {
+		pool->base.rmcm[i] = dcn42b_rmcm_create(ctx, i);
+		if (pool->base.rmcm[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create rmcm%d!\n", i);
+			goto create_fail;
+		}
+	}
+
 	/* DSCs */
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn42b_dsc_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 534adb1e0ba6..4eb9f7e2d110 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -19,6 +19,7 @@
 #include "dcn321/dcn321_resource.h"
 #include "dcn401/dcn401_resource.h"
 #include "dcn42/dcn42_resource.h"
+#include "dcn60/dcn60_rmcm.h"
 #include "dcn60_resource.h"
 
 #include "dcn10/dcn10_ipp.h"
@@ -464,9 +465,7 @@ static struct dcn60_mpc_registers mpc_regs;
 	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
 	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
 	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
-	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
-	MPC_RMCM_REG_LIST_DCN42(0),\
-	MPC_RMCM_REG_LIST_DCN42(1)
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3)
 
 static const struct dcn60_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN6_0(__SHIFT)
@@ -1697,6 +1696,8 @@ static void dcn60_resource_destruct(struct dcn60_resource_pool *pool)
 		kfree(TO_DCN20_MPC(pool->base.mpc));
 		pool->base.mpc = NULL;
 	}
+	for (i = 0; i < MAX_RMCM_INST; i++)
+		dcn60_rmcm_destroy(&pool->base.rmcm[i]);
 	if (pool->base.hubbub != NULL) {
 		kfree(TO_DCN20_HUBBUB(pool->base.hubbub));
 		pool->base.hubbub = NULL;
@@ -2290,6 +2291,16 @@ static bool dcn60_resource_construct(
 		goto create_fail;
 	}
 
+	/* RMCMs */
+	for (i = 0; i < pool->base.res_cap->num_rmcm && i < MAX_RMCM_INST; i++) {
+		pool->base.rmcm[i] = dcn60_rmcm_create(ctx, i);
+		if (pool->base.rmcm[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create rmcm%d!\n", i);
+			goto create_fail;
+		}
+	}
+
 	/* DSCs */
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn60_dsc_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/rmcm/Makefile b/drivers/gpu/drm/amd/display/dc/rmcm/Makefile
new file mode 100644
index 000000000000..9dfc86a850da
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/rmcm/Makefile
@@ -0,0 +1,44 @@
+#
+# Copyright 2026 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN42
+###############################################################################
+RMCM_DCN42 = dcn42_rmcm.o
+
+AMD_DAL_RMCM_DCN42 = $(addprefix $(AMDDALPATH)/dc/rmcm/dcn42/,$(RMCM_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RMCM_DCN42)
+
+###############################################################################
+# DCN60
+###############################################################################
+RMCM_DCN60 = dcn60_rmcm.o
+
+AMD_DAL_RMCM_DCN60 = $(addprefix $(AMDDALPATH)/dc/rmcm/dcn60/,$(RMCM_DCN60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RMCM_DCN60)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c b/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
new file mode 100644
index 000000000000..952f0ade24a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.c
@@ -0,0 +1,867 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "reg_helper.h"
+#include "dc.h"
+#include "dcn42_rmcm.h"
+#include "dcn10/dcn10_cm_common.h"
+#include "basics/conversion.h"
+#include "hw_shared.h"
+#include "mpc.h"
+
+#define REG(reg)\
+	rmcm42->rmcm_regs->reg
+
+#define CTX \
+	rmcm42->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name) \
+	rmcm42->rmcm_shift->field_name, rmcm42->rmcm_mask->field_name
+
+/* RMCM Shaper functions */
+
+void rmcm42_power_on_shaper_3dlut(
+	struct rmcm *rmcm,
+	uint32_t rmcm_id,
+	bool power_on)
+{
+	uint32_t power_status_shaper = 2;
+	uint32_t power_status_3dlut  = 2;
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+	int max_retries = 10;
+
+	REG_SET(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], 0,
+		MPC_RMCM_3DLUT_MEM_PWR_DIS, power_on == true ? 0 : 1);
+	REG_SET(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], 0,
+		MPC_RMCM_SHAPER_MEM_PWR_DIS, power_on == true ? 0 : 1);
+	/* wait for memory to fully power up */
+	if (power_on && rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
+		REG_WAIT(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], MPC_RMCM_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
+		REG_WAIT(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], MPC_RMCM_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
+	}
+
+	/*read status is not mandatory, it is just for debugging*/
+	REG_GET(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], MPC_RMCM_SHAPER_MEM_PWR_STATE, &power_status_shaper);
+	REG_GET(MPC_RMCM_MEM_PWR_CTRL[rmcm_id], MPC_RMCM_3DLUT_MEM_PWR_STATE, &power_status_3dlut);
+
+	if (power_status_shaper != 0 && power_on == true)
+		BREAK_TO_DEBUGGER();
+
+	if (power_status_3dlut != 0 && power_on == true)
+		BREAK_TO_DEBUGGER();
+}
+
+static void rmcm42_configure_shaper_lut(
+	struct rmcm *rmcm,
+	bool is_ram_a,
+	uint32_t rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_G_B[rmcm_id],
+		MPC_RMCM_SHAPER_SCALE_B, 0x7000);
+	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_G_B[rmcm_id],
+		MPC_RMCM_SHAPER_SCALE_G, 0x7000);
+	REG_UPDATE(MPC_RMCM_SHAPER_SCALE_R[rmcm_id],
+		MPC_RMCM_SHAPER_SCALE_R, 0x7000);
+	REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
+	REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_SEL, is_ram_a == true ? 0:1);
+	REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[rmcm_id], 0, MPC_RMCM_SHAPER_LUT_INDEX, 0);
+}
+
+static void rmcm42_program_shaper_luta_settings(
+	struct rmcm *rmcm,
+	const struct pwl_params *params,
+	uint32_t rmcm_id)
+{
+	const struct gamma_curve *curve;
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_B[rmcm_id], 0,
+		MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].blue.custom_float_x,
+		MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_G[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].green.custom_float_x,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_R[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, params->corner_points[0].red.custom_float_x,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, 0);
+
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_B[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].blue.custom_float_x,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].blue.custom_float_y);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_G[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].green.custom_float_x,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].green.custom_float_y);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_R[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, params->corner_points[1].red.custom_float_x,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, params->corner_points[1].red.custom_float_y);
+
+	curve = params->arr_curve_points;
+	if (curve) {
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_0_1[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_2_3[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_4_5[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_6_7[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_8_9[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_10_11[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_12_13[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_14_15[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_16_17[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_18_19[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_20_21[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_22_23[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_24_25[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_26_27[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_28_29[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_30_31[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMA_REGION_32_33[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+	}
+}
+
+
+static void rmcm42_program_shaper_lutb_settings(
+	struct rmcm *rmcm,
+	const struct pwl_params *params,
+	uint32_t rmcm_id)
+{
+	const struct gamma_curve *curve;
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_B[rmcm_id], 0,
+		MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].blue.custom_float_x,
+		MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_G[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].green.custom_float_x,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_START_CNTL_R[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, params->corner_points[0].red.custom_float_x,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, 0);
+
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_B[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].blue.custom_float_x,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].blue.custom_float_y);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_G[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].green.custom_float_x,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].green.custom_float_y);
+	REG_SET_2(MPC_RMCM_SHAPER_RAMB_END_CNTL_R[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, params->corner_points[1].red.custom_float_x,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, params->corner_points[1].red.custom_float_y);
+
+	curve = params->arr_curve_points;
+	if (curve) {
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_0_1[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_2_3[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_4_5[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_6_7[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_8_9[rmcm_id], 0,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+			MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_10_11[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_12_13[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_14_15[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_16_17[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_18_19[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_20_21[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_22_23[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_24_25[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_26_27[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_28_29[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_30_31[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+
+		curve += 2;
+		REG_SET_4(MPC_RMCM_SHAPER_RAMB_REGION_32_33[rmcm_id], 0,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, curve[0].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, curve[0].segments_num,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, curve[1].offset,
+				MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, curve[1].segments_num);
+	}
+}
+
+static void rmcm42_program_shaper_lut(
+	struct rmcm *rmcm,
+	const struct pwl_result_data *rgb,
+	uint32_t num,
+	uint32_t rmcm_id)
+{
+	uint32_t i, red, green, blue;
+	uint32_t  red_delta, green_delta, blue_delta;
+	uint32_t  red_value, green_value, blue_value;
+
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	for (i = 0; i < num; i++) {
+
+		red   = rgb[i].red_reg;
+		green = rgb[i].green_reg;
+		blue  = rgb[i].blue_reg;
+
+		red_delta   = rgb[i].delta_red_reg;
+		green_delta = rgb[i].delta_green_reg;
+		blue_delta  = rgb[i].delta_blue_reg;
+
+		red_value   = ((red_delta   & 0x3ff) << 14) | (red   & 0x3fff);
+		green_value = ((green_delta & 0x3ff) << 14) | (green & 0x3fff);
+		blue_value  = ((blue_delta  & 0x3ff) << 14) | (blue  & 0x3fff);
+
+		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[rmcm_id], 0, MPC_RMCM_SHAPER_LUT_DATA, red_value);
+		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[rmcm_id], 0, MPC_RMCM_SHAPER_LUT_DATA, green_value);
+		REG_SET(MPC_RMCM_SHAPER_LUT_DATA[rmcm_id], 0, MPC_RMCM_SHAPER_LUT_DATA, blue_value);
+	}
+}
+
+void rmcm42_update_3dlut_fast_load_select(struct rmcm *rmcm, int rmcm_id, int hubp_idx)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_SET(MPC_RMCM_3DLUT_FAST_LOAD_SELECT[rmcm_id], 0,
+		MPC_RMCM_3DLUT_FL_SEL,
+		hubp_idx);
+}
+
+static void rmcm42_select_3dlut_ram_mask(
+		struct rmcm *rmcm,
+		uint32_t ram_selection_mask,
+		int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+			MPC_RMCM_3DLUT_WRITE_EN_MASK, ram_selection_mask);
+	REG_SET(MPC_RMCM_3DLUT_INDEX[rmcm_id], 0, MPC_RMCM_3DLUT_INDEX, 0);
+}
+
+static void rmcm42_set3dlut_ram12(
+		struct rmcm *rmcm,
+		const struct dc_rgb *lut,
+		uint32_t entries,
+		int rmcm_id)
+{
+	uint32_t i, red, green, blue, red1, green1, blue1;
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	for (i = 0; i < entries; i += 2) {
+		red   = lut[i].red << 4;
+		green = lut[i].green << 4;
+		blue  = lut[i].blue << 4;
+		red1   = lut[i + 1].red << 4;
+		green1 = lut[i + 1].green << 4;
+		blue1  = lut[i + 1].blue << 4;
+
+		REG_SET_2(MPC_RMCM_3DLUT_DATA[rmcm_id], 0,
+				MPC_RMCM_3DLUT_DATA0, red,
+				MPC_RMCM_3DLUT_DATA1, red1);
+
+		REG_SET_2(MPC_RMCM_3DLUT_DATA[rmcm_id], 0,
+				MPC_RMCM_3DLUT_DATA0, green,
+				MPC_RMCM_3DLUT_DATA1, green1);
+
+		REG_SET_2(MPC_RMCM_3DLUT_DATA[rmcm_id], 0,
+				MPC_RMCM_3DLUT_DATA0, blue,
+				MPC_RMCM_3DLUT_DATA1, blue1);
+	}
+}
+
+static void rmcm42_set3dlut_ram10(
+		struct rmcm *rmcm,
+		const struct dc_rgb *lut,
+		uint32_t entries,
+		int rmcm_id)
+{
+	uint32_t i, red, green, blue, value;
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	for (i = 0; i < entries; i++) {
+		red   = lut[i].red;
+		green = lut[i].green;
+		blue  = lut[i].blue;
+		value = (red << 20) | (green << 10) | blue;
+
+		REG_SET(MPC_RMCM_3DLUT_DATA_30BIT[rmcm_id], 0,
+				MPC_RMCM_3DLUT_DATA_30BIT, value);
+	}
+}
+
+void rmcm42_populate_lut(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+	const union rmcm_lut_params params, bool lut_bank_a, int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+	const enum dc_lut_mode next_mode = lut_bank_a ? LUT_RAM_A : LUT_RAM_B;
+
+	switch (id) {
+	case MCM_LUT_SHAPER: {
+		const struct pwl_params *lut_shaper = params.pwl;
+
+		if (lut_shaper == NULL)
+			return;
+		if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+			rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, true);
+
+		rmcm42_configure_shaper_lut(rmcm, next_mode == LUT_RAM_A, rmcm_id);
+
+		if (next_mode == LUT_RAM_A)
+			rmcm42_program_shaper_luta_settings(rmcm, lut_shaper, rmcm_id);
+		else
+			rmcm42_program_shaper_lutb_settings(rmcm, lut_shaper, rmcm_id);
+
+		rmcm42_program_shaper_lut(
+				rmcm, lut_shaper->rgb_resulted, lut_shaper->hw_points_num, rmcm_id);
+
+		rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+		break;
+	}
+	case MCM_LUT_3DLUT: {
+		const struct tetrahedral_params *lut3d = params.lut3d;
+		bool is_17x17x17;
+		bool is_12bits_color_channel;
+		const struct dc_rgb *lut0;
+		const struct dc_rgb *lut1;
+		const struct dc_rgb *lut2;
+		const struct dc_rgb *lut3;
+		int lut_size0;
+		int lut_size;
+
+		if (lut3d == NULL)
+			return;
+
+		rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, true);
+
+		/* Program bit depth before loading data */
+		is_12bits_color_channel = lut3d->use_12bits;
+		REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+			MPC_RMCM_3DLUT_WRITE_EN_MASK, 0xF);
+		REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+			MPC_RMCM_3DLUT_30BIT_EN,
+			is_12bits_color_channel ? 0 : 1);
+
+		is_17x17x17 = !lut3d->use_tetrahedral_9;
+		is_12bits_color_channel = lut3d->use_12bits;
+		if (is_17x17x17) {
+			lut0 = lut3d->tetrahedral_17.lut0;
+			lut1 = lut3d->tetrahedral_17.lut1;
+			lut2 = lut3d->tetrahedral_17.lut2;
+			lut3 = lut3d->tetrahedral_17.lut3;
+			lut_size0 = sizeof(lut3d->tetrahedral_17.lut0) /
+						sizeof(lut3d->tetrahedral_17.lut0[0]);
+			lut_size  = sizeof(lut3d->tetrahedral_17.lut1) /
+						sizeof(lut3d->tetrahedral_17.lut1[0]);
+		} else {
+			lut0 = lut3d->tetrahedral_9.lut0;
+			lut1 = lut3d->tetrahedral_9.lut1;
+			lut2 = lut3d->tetrahedral_9.lut2;
+			lut3 = lut3d->tetrahedral_9.lut3;
+			lut_size0 = sizeof(lut3d->tetrahedral_9.lut0) /
+					sizeof(lut3d->tetrahedral_9.lut0[0]);
+			lut_size  = sizeof(lut3d->tetrahedral_9.lut1) /
+					sizeof(lut3d->tetrahedral_9.lut1[0]);
+		}
+
+		rmcm42_select_3dlut_ram_mask(rmcm, 0x1, rmcm_id);
+		if (is_12bits_color_channel)
+			rmcm42_set3dlut_ram12(rmcm, lut0, lut_size0, rmcm_id);
+		else
+			rmcm42_set3dlut_ram10(rmcm, lut0, lut_size0, rmcm_id);
+
+		rmcm42_select_3dlut_ram_mask(rmcm, 0x2, rmcm_id);
+		if (is_12bits_color_channel)
+			rmcm42_set3dlut_ram12(rmcm, lut1, lut_size, rmcm_id);
+		else
+			rmcm42_set3dlut_ram10(rmcm, lut1, lut_size, rmcm_id);
+
+		rmcm42_select_3dlut_ram_mask(rmcm, 0x4, rmcm_id);
+		if (is_12bits_color_channel)
+			rmcm42_set3dlut_ram12(rmcm, lut2, lut_size, rmcm_id);
+		else
+			rmcm42_set3dlut_ram10(rmcm, lut2, lut_size, rmcm_id);
+
+		rmcm42_select_3dlut_ram_mask(rmcm, 0x8, rmcm_id);
+		if (is_12bits_color_channel)
+			rmcm42_set3dlut_ram12(rmcm, lut3, lut_size, rmcm_id);
+		else
+			rmcm42_set3dlut_ram10(rmcm, lut3, lut_size, rmcm_id);
+
+		if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+			rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+
+		break;
+	}
+	case MCM_LUT_1DLUT:
+		/* RMCM doesn't support 1DLUT */
+		break;
+	}
+}
+
+static void rmcm42_program_lut_read_write_control(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+	bool lut_bank_a, bool enabled, int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	switch (id) {
+	case MCM_LUT_3DLUT:
+		REG_UPDATE(MPC_RMCM_3DLUT_MODE[rmcm_id], MPC_RMCM_3DLUT_MODE,
+			(!enabled) ? 0 :
+			(lut_bank_a) ? 1 : 2);
+
+		REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+			MPC_RMCM_3DLUT_RAM_SEL,
+			(lut_bank_a) ? 0 : 1);
+		break;
+	case MCM_LUT_SHAPER:
+		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
+
+		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_SEL,
+			lut_bank_a == true ? 0:1);
+
+		REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[rmcm_id], 0,
+			MPC_RMCM_SHAPER_LUT_INDEX, 0);
+		break;
+	default:
+		break;
+	}
+}
+
+uint32_t rmcm42_get_3dlut_width(
+		const enum dc_cm_lut_size size)
+{
+	uint32_t width = 0;
+
+	switch (size) {
+	case CM_LUT_SIZE_999:
+		width = 1;
+		break;
+	case CM_LUT_SIZE_333333:
+		width = 2;
+		break;
+	case CM_LUT_SIZE_171717:
+	default:
+		width = 0;
+		break;
+	}
+
+	return width;
+}
+
+static void rmcm42_program_lut_mode(struct rmcm *rmcm,
+	const enum MCM_LUT_ID id,
+	bool enable,
+	bool lut_bank_a,
+	const enum dc_cm_lut_size size,
+	uint16_t bias,
+	uint16_t scale,
+	int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	(void)bias;
+	(void)scale;
+
+	switch (id) {
+	case MCM_LUT_3DLUT:
+		if (enable) {
+			uint32_t lut_size = rmcm42_get_3dlut_width(size);
+
+			REG_UPDATE_2(MPC_RMCM_3DLUT_MODE[rmcm_id],
+					MPC_RMCM_3DLUT_MODE, lut_bank_a ? 1 : 2,
+					MPC_RMCM_3DLUT_SIZE, lut_size);
+
+			/* Default to 12-bit (30BIT_EN=0) for DMA path;
+			 * populate_lut overrides for host-load path.
+			 */
+			REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+				MPC_RMCM_3DLUT_WRITE_EN_MASK, 0xF);
+			REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+				MPC_RMCM_3DLUT_30BIT_EN, 0);
+		} else {
+			if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+			REG_UPDATE(MPC_RMCM_3DLUT_MODE[rmcm_id], MPC_RMCM_3DLUT_MODE, 0);
+		}
+		break;
+	case MCM_LUT_SHAPER:
+		if (enable) {
+			REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+					MPC_RMCM_SHAPER_LUT_MODE, lut_bank_a ? 1 : 2);
+		} else {
+			if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+			REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+					MPC_RMCM_SHAPER_LUT_MODE, 0);
+		}
+		break;
+	case MCM_LUT_1DLUT:
+		/* RMCM doesn't support 1DLUT */
+		break;
+	}
+}
+
+static void rmcm42_get_lut_mode(struct rmcm *rmcm,
+		const enum MCM_LUT_ID id,
+		int rmcm_id,
+		bool *enable,
+		bool *lut_bank_a)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+	uint32_t lut_mode = 0;
+
+	*enable = false;
+	*lut_bank_a = true;
+
+	switch (id) {
+	case MCM_LUT_SHAPER:
+		REG_GET(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+				MPC_RMCM_SHAPER_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		*lut_bank_a = lut_mode != 2;
+		break;
+	case MCM_LUT_1DLUT:
+		/* RMCM doesn't support 1DLUT, return disabled */
+		*enable = false;
+		*lut_bank_a = true;
+		break;
+	case MCM_LUT_3DLUT:
+	default:
+		REG_GET(MPC_RMCM_3DLUT_MODE[rmcm_id],
+				MPC_RMCM_3DLUT_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		*lut_bank_a = lut_mode != 2;
+		break;
+	}
+}
+
+void rmcm42_get_3dlut_fast_load_status(struct rmcm *rmcm, int rmcm_id,
+	bool *done, bool *soft_underflow, bool *hard_underflow)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+	uint32_t fl_done = 0, fl_soft = 0, fl_hard = 0;
+
+	REG_GET_3(MPC_RMCM_3DLUT_FAST_LOAD_STATUS[rmcm_id],
+		MPC_RMCM_3DLUT_FL_DONE, &fl_done,
+		MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, &fl_soft,
+		MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, &fl_hard);
+
+	*done = (fl_done != 0);
+	*soft_underflow = (fl_soft != 0);
+	*hard_underflow = (fl_hard != 0);
+}
+
+void rmcm42_read_state(struct rmcm *rmcm, int rmcm_inst, struct rmcm_state *s)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	/* RMCM 3DLUT Status */
+	REG_GET_4(MPC_RMCM_MEM_PWR_CTRL[rmcm_inst], MPC_RMCM_3DLUT_MEM_PWR_FORCE, &s->regs.rmcm_3dlut_mem_pwr_force,
+			MPC_RMCM_3DLUT_MEM_PWR_DIS, &s->regs.rmcm_3dlut_mem_pwr_dis,
+			MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE, &s->regs.rmcm_3dlut_mem_pwr_mode,
+			MPC_RMCM_3DLUT_MEM_PWR_STATE, &s->regs.rmcm_3dlut_mem_pwr_state);
+
+	REG_GET_3(MPC_RMCM_3DLUT_MODE[rmcm_inst], MPC_RMCM_3DLUT_SIZE, &s->regs.rmcm_3dlut_size,
+			MPC_RMCM_3DLUT_MODE, &s->regs.rmcm_3dlut_mode,
+			MPC_RMCM_3DLUT_MODE_CURRENT, &s->regs.rmcm_3dlut_mode_cur);
+
+	REG_GET_4(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_inst], MPC_RMCM_3DLUT_READ_SEL, &s->regs.rmcm_3dlut_read_sel,
+			MPC_RMCM_3DLUT_30BIT_EN, &s->regs.rmcm_3dlut_30bit_en,
+			MPC_RMCM_3DLUT_WRITE_EN_MASK, &s->regs.rmcm_3dlut_wr_en_mask,
+			MPC_RMCM_3DLUT_RAM_SEL, &s->regs.rmcm_3dlut_ram_sel);
+
+	REG_GET(MPC_RMCM_3DLUT_OUT_NORM_FACTOR[rmcm_inst], MPC_RMCM_3DLUT_OUT_NORM_FACTOR, &s->regs.rmcm_3dlut_out_norm_factor);
+
+	REG_GET(MPC_RMCM_3DLUT_FAST_LOAD_SELECT[rmcm_inst], MPC_RMCM_3DLUT_FL_SEL, &s->regs.rmcm_3dlut_fl_sel);
+
+	REG_GET_2(MPC_RMCM_3DLUT_OUT_OFFSET_R[rmcm_inst], MPC_RMCM_3DLUT_OUT_OFFSET_R, &s->regs.rmcm_3dlut_out_offset_r,
+			MPC_RMCM_3DLUT_OUT_SCALE_R, &s->regs.rmcm_3dlut_out_scale_r);
+
+	REG_GET_3(MPC_RMCM_3DLUT_FAST_LOAD_STATUS[rmcm_inst], MPC_RMCM_3DLUT_FL_DONE, &s->regs.rmcm_3dlut_fl_done,
+			MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, &s->regs.rmcm_3dlut_fl_soft_underflow,
+			MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, &s->regs.rmcm_3dlut_fl_hard_underflow);
+
+	/* RMCM Shaper Status */
+	REG_GET_4(MPC_RMCM_MEM_PWR_CTRL[rmcm_inst], MPC_RMCM_SHAPER_MEM_PWR_FORCE, &s->regs.rmcm_shaper_mem_pwr_force,
+			MPC_RMCM_SHAPER_MEM_PWR_DIS, &s->regs.rmcm_shaper_mem_pwr_dis,
+			MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE, &s->regs.rmcm_shaper_mem_pwr_mode,
+			MPC_RMCM_SHAPER_MEM_PWR_STATE, &s->regs.rmcm_shaper_mem_pwr_state);
+
+	REG_GET_2(MPC_RMCM_SHAPER_CONTROL[rmcm_inst], MPC_RMCM_SHAPER_LUT_MODE, &s->regs.rmcm_shaper_lut_mode,
+			MPC_RMCM_SHAPER_MODE_CURRENT, &s->regs.rmcm_shaper_mode_cur);
+
+	REG_GET_2(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_inst], MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, &s->regs.rmcm_shaper_lut_write_en_mask,
+			MPC_RMCM_SHAPER_LUT_WRITE_SEL, &s->regs.rmcm_shaper_lut_write_sel);
+
+	REG_GET(MPC_RMCM_SHAPER_OFFSET_B[rmcm_inst], MPC_RMCM_SHAPER_OFFSET_B, &s->regs.rmcm_shaper_offset_b);
+
+	REG_GET(MPC_RMCM_SHAPER_SCALE_G_B[rmcm_inst], MPC_RMCM_SHAPER_SCALE_B, &s->regs.rmcm_shaper_scale_b);
+
+	REG_GET_2(MPC_RMCM_SHAPER_RAMA_START_CNTL_B[rmcm_inst], MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, &s->regs.rmcm_shaper_rama_exp_region_start_b,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, &s->regs.rmcm_shaper_rama_exp_region_start_seg_b);
+
+	REG_GET_2(MPC_RMCM_SHAPER_RAMA_END_CNTL_B[rmcm_inst], MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, &s->regs.rmcm_shaper_rama_exp_region_end_b,
+			MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, &s->regs.rmcm_shaper_rama_exp_region_end_base_b);
+
+	REG_GET(MPC_RMCM_CNTL[rmcm_inst], MPC_RMCM_CNTL, &s->regs.rmcm_cntl);
+}
+
+/*
+ * rmcm42_connect_mpcc() - Program RMCM to MPCC routing mux
+ * @rmcm: RMCM instance
+ * @rmcm_id: RMCM hardware index
+ * @mpcc_id: MPCC to connect (0-3), or RMCM_MPCC_ID_NONE to disconnect
+ *
+ * Programs MPC_RMCM_CNTL to route the specified MPCC to this RMCM instance,
+ * allowing any MPCC[x] to RMCM[y] mapping.
+ */
+void rmcm42_connect_mpcc(struct rmcm *rmcm, int rmcm_id, int mpcc_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	REG_UPDATE(MPC_RMCM_CNTL[rmcm_id], MPC_RMCM_CNTL, mpcc_id);
+
+	rmcm->mpcc_id = mpcc_id;
+}
+
+const struct rmcm_funcs dcn42_rmcm_funcs = {
+	.get_lut_mode = rmcm42_get_lut_mode,
+	.program_lut_mode = rmcm42_program_lut_mode,
+	.populate_lut = rmcm42_populate_lut,
+	.program_lut_read_write_control = rmcm42_program_lut_read_write_control,
+	.update_3dlut_fast_load_select = rmcm42_update_3dlut_fast_load_select,
+	.get_3dlut_fast_load_status = rmcm42_get_3dlut_fast_load_status,
+	.read_rmcm_state = rmcm42_read_state,
+	.connect_mpcc = rmcm42_connect_mpcc,
+};
+
+void dcn42_rmcm_construct(
+	struct dcn42_rmcm *rmcm42,
+	struct dc_context *ctx,
+	const struct dcn42_rmcm_registers *regs,
+	const struct dcn42_rmcm_shift *shift,
+	const struct dcn42_rmcm_mask *mask,
+	int inst)
+{
+	rmcm42->base.ctx = ctx;
+	rmcm42->base.inst = inst;
+	rmcm42->base.mpcc_id = RMCM_MPCC_ID_UNKNOWN;
+	rmcm42->base.funcs = &dcn42_rmcm_funcs;
+	rmcm42->rmcm_regs = regs;
+	rmcm42->rmcm_shift = shift;
+	rmcm42->rmcm_mask = mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h b/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
new file mode 100644
index 000000000000..caffc14fab05
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/rmcm/dcn42/dcn42_rmcm.h
@@ -0,0 +1,717 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_RMCM_DCN42_H__
+#define __DC_RMCM_DCN42_H__
+
+#include "rmcm.h"
+
+#define TO_DCN42_RMCM(rmcm_base) \
+	container_of(rmcm_base, struct dcn42_rmcm, base)
+
+#define MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(mask_sh) \
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_LUT_MODE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_CONTROL, MPC_RMCM_SHAPER_MODE_CURRENT, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_R, MPC_RMCM_SHAPER_OFFSET_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_G, MPC_RMCM_SHAPER_OFFSET_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_OFFSET_B, MPC_RMCM_SHAPER_OFFSET_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_R, MPC_RMCM_SHAPER_SCALE_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM_SHAPER_SCALE_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_INDEX, MPC_RMCM_SHAPER_LUT_INDEX, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_DATA, MPC_RMCM_SHAPER_LUT_DATA, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM_SHAPER_LUT_WRITE_SEL, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM_SHAPER_RAMA_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM_SHAPER_RAMA_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM_SHAPER_RAMA_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM_SHAPER_RAMA_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM_SHAPER_RAMA_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM_SHAPER_RAMA_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM_SHAPER_RAMA_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM_SHAPER_RAMA_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM_SHAPER_RAMA_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM_SHAPER_RAMA_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM_SHAPER_RAMA_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM_SHAPER_RAMA_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM_SHAPER_RAMA_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM_SHAPER_RAMA_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM_SHAPER_RAMA_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM_SHAPER_RAMA_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION2_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM_SHAPER_RAMB_EXP_REGION3_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION4_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM_SHAPER_RAMB_EXP_REGION5_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION6_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM_SHAPER_RAMB_EXP_REGION7_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION8_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM_SHAPER_RAMB_EXP_REGION9_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION10_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM_SHAPER_RAMB_EXP_REGION11_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION12_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM_SHAPER_RAMB_EXP_REGION13_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION14_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM_SHAPER_RAMB_EXP_REGION15_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION16_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM_SHAPER_RAMB_EXP_REGION17_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION18_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM_SHAPER_RAMB_EXP_REGION19_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION20_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM_SHAPER_RAMB_EXP_REGION21_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION22_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM_SHAPER_RAMB_EXP_REGION23_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION24_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM_SHAPER_RAMB_EXP_REGION25_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION26_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM_SHAPER_RAMB_EXP_REGION27_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION28_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM_SHAPER_RAMB_EXP_REGION29_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION30_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM_SHAPER_RAMB_EXP_REGION31_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION32_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_LUT_OFFSET, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM_SHAPER_RAMB_EXP_REGION33_NUM_SEGMENTS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_SIZE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_MODE, MPC_RMCM_3DLUT_MODE_CURRENT, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_INDEX, MPC_RMCM_3DLUT_INDEX, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA0, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA, MPC_RMCM_3DLUT_DATA1, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_DATA_30BIT, MPC_RMCM_3DLUT_DATA_30BIT, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_WRITE_EN_MASK, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_RAM_SEL, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_30BIT_EN, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM_3DLUT_READ_SEL, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_NORM_FACTOR, MPC_RMCM_3DLUT_OUT_NORM_FACTOR, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_OFFSET_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM_3DLUT_OUT_SCALE_R, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_OFFSET_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM_3DLUT_OUT_SCALE_G, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_OFFSET_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM_3DLUT_OUT_SCALE_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM_GAMUT_REMAP_MODE_CURRENT, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C11_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM_GAMUT_REMAP_C12_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C13_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM_GAMUT_REMAP_C14_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C21_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM_GAMUT_REMAP_C22_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C23_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM_GAMUT_REMAP_C24_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C31_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM_GAMUT_REMAP_C32_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C33_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM_GAMUT_REMAP_C34_A, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C11_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM_GAMUT_REMAP_C12_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C13_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM_GAMUT_REMAP_C14_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C21_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM_GAMUT_REMAP_C22_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C23_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM_GAMUT_REMAP_C24_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C31_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM_GAMUT_REMAP_C32_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C33_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM_GAMUT_REMAP_C34_B, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_FORCE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_DIS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_FORCE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_DIS, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_SHAPER_MEM_PWR_STATE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM_3DLUT_MEM_PWR_STATE, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_SELECT, MPC_RMCM_3DLUT_FL_SEL, mask_sh),\
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_DONE, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_CNTL, MPC_RMCM_CNTL, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_INDEX, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM_TEST_DEBUG_WRITE_EN, mask_sh), \
+	SF(MPC_RMCM0_MPC_RMCM_TEST_DEBUG_DATA, MPC_RMCM_TEST_DEBUG_DATA, mask_sh)
+#define MPC_RMCM_REG_LIST_DCN42(inst)\
+	SRII(MPC_RMCM_SHAPER_CONTROL, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_OFFSET_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_OFFSET_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_OFFSET_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_SCALE_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_SCALE_G_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_LUT_INDEX, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_LUT_DATA, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_START_CNTL_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_END_CNTL_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_0_1, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_2_3, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_4_5, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_6_7, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_8_9, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_10_11, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_12_13, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_14_15, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_16_17, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_18_19, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_20_21, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_22_23, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_24_25, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_26_27, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_28_29, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_30_31, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMA_REGION_32_33, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_START_CNTL_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_END_CNTL_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_0_1, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_2_3, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_4_5, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_6_7, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_8_9, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_10_11, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_12_13, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_14_15, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_16_17, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_18_19, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_20_21, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_22_23, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_24_25, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_26_27, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_28_29, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_30_31, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_SHAPER_RAMB_REGION_32_33, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_MODE, MPC_RMCM, inst), /*TODO: may need to add other 3DLUT regs*/\
+	SRII(MPC_RMCM_3DLUT_INDEX, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_DATA, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_DATA_30BIT, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_READ_WRITE_CONTROL, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_OUT_NORM_FACTOR, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_R, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_G, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_OUT_OFFSET_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_COEF_FORMAT, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_MODE, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C11_C12_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C13_C14_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C21_C22_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C23_C24_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C31_C32_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C33_C34_A, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C11_C12_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C13_C14_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C21_C22_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C23_C24_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C31_C32_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_GAMUT_REMAP_C33_C34_B, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_MEM_PWR_CTRL, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_FAST_LOAD_SELECT, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_3DLUT_FAST_LOAD_STATUS, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_CNTL, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_TEST_DEBUG_INDEX, MPC_RMCM, inst),\
+	SRII(MPC_RMCM_TEST_DEBUG_DATA, MPC_RMCM, inst)
+
+#define MPC_RMCM_REG_FIELD_LIST_DCN42(type) \
+	type MPC_RMCM_SHAPER_LUT_MODE;\
+	type MPC_RMCM_SHAPER_MODE_CURRENT;\
+	type MPC_RMCM_SHAPER_OFFSET_R;\
+	type MPC_RMCM_SHAPER_OFFSET_G;\
+	type MPC_RMCM_SHAPER_OFFSET_B;\
+	type MPC_RMCM_SHAPER_SCALE_R;\
+	type MPC_RMCM_SHAPER_SCALE_G;\
+	type MPC_RMCM_SHAPER_SCALE_B;\
+	type MPC_RMCM_SHAPER_LUT_INDEX;\
+	type MPC_RMCM_SHAPER_LUT_DATA;\
+	type MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK;\
+	type MPC_RMCM_SHAPER_LUT_WRITE_SEL; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_B; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_B; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_G; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_G;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_R;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_START_SEGMENT_R;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_B;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_B;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_G;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_G;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_R;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION_END_BASE_R;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION0_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION0_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION1_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION1_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION2_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION2_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION3_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION3_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION4_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION4_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION5_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION5_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION6_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION6_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION7_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION7_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION8_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION8_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION9_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION9_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION10_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION10_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION11_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION11_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION12_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION12_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION13_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION13_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION14_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION14_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION15_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION15_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION16_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION16_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION17_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION17_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION18_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION18_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION19_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION19_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION20_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION20_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION21_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION21_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION22_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION22_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION23_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION23_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION24_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION24_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION25_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION25_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION26_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION26_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION27_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION27_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION28_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION28_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION29_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION29_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION30_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION30_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION31_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION31_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION32_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION32_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION33_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMA_EXP_REGION33_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_B; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_B; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_G; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_G;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_R;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_START_SEGMENT_R;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_B;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_B;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_G;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_G;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_R;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION_END_BASE_R;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION0_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION0_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION1_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION1_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION2_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION2_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION3_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION3_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION4_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION4_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION5_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION5_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION6_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION6_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION7_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION7_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION8_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION8_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION9_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION9_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION10_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION10_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION11_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION11_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION12_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION12_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION13_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION13_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION14_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION14_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION15_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION15_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION16_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION16_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION17_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION17_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION18_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION18_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION19_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION19_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION20_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION20_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION21_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION21_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION22_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION22_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION23_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION23_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION24_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION24_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION25_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION25_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION26_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION26_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION27_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION27_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION28_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION28_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION29_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION29_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION30_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION30_NUM_SEGMENTS;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION31_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION31_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION32_LUT_OFFSET; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION32_NUM_SEGMENTS; \
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION33_LUT_OFFSET;\
+	type MPC_RMCM_SHAPER_RAMB_EXP_REGION33_NUM_SEGMENTS;\
+	type MPC_RMCM_3DLUT_MODE;\
+	type MPC_RMCM_3DLUT_SIZE;\
+	type MPC_RMCM_3DLUT_MODE_CURRENT;\
+	type MPC_RMCM_3DLUT_INDEX; \
+	type MPC_RMCM_3DLUT_DATA0; \
+	type MPC_RMCM_3DLUT_DATA1; \
+	type MPC_RMCM_3DLUT_DATA_30BIT; \
+	type MPC_RMCM_3DLUT_WRITE_EN_MASK;\
+	type MPC_RMCM_3DLUT_RAM_SEL;\
+	type MPC_RMCM_3DLUT_30BIT_EN;\
+	type MPC_RMCM_3DLUT_READ_SEL;\
+	type MPC_RMCM_3DLUT_OUT_NORM_FACTOR;\
+	type MPC_RMCM_3DLUT_OUT_OFFSET_R;\
+	type MPC_RMCM_3DLUT_OUT_SCALE_R; \
+	type MPC_RMCM_3DLUT_OUT_OFFSET_G; \
+	type MPC_RMCM_3DLUT_OUT_SCALE_G; \
+	type MPC_RMCM_3DLUT_OUT_OFFSET_B; \
+	type MPC_RMCM_3DLUT_OUT_SCALE_B;\
+	type MPC_RMCM_GAMUT_REMAP_COEF_FORMAT;\
+	type MPC_RMCM_GAMUT_REMAP_MODE;\
+	type MPC_RMCM_GAMUT_REMAP_MODE_CURRENT;\
+	type MPC_RMCM_GAMUT_REMAP_C11_A;\
+	type MPC_RMCM_GAMUT_REMAP_C12_A;\
+	type MPC_RMCM_GAMUT_REMAP_C13_A; \
+	type MPC_RMCM_GAMUT_REMAP_C14_A; \
+	type MPC_RMCM_GAMUT_REMAP_C21_A; \
+	type MPC_RMCM_GAMUT_REMAP_C22_A; \
+	type MPC_RMCM_GAMUT_REMAP_C23_A;\
+	type MPC_RMCM_GAMUT_REMAP_C24_A;\
+	type MPC_RMCM_GAMUT_REMAP_C31_A;\
+	type MPC_RMCM_GAMUT_REMAP_C32_A;\
+	type MPC_RMCM_GAMUT_REMAP_C33_A;\
+	type MPC_RMCM_GAMUT_REMAP_C34_A;\
+	type MPC_RMCM_GAMUT_REMAP_C11_B;\
+	type MPC_RMCM_GAMUT_REMAP_C12_B;\
+	type MPC_RMCM_GAMUT_REMAP_C13_B; \
+	type MPC_RMCM_GAMUT_REMAP_C14_B; \
+	type MPC_RMCM_GAMUT_REMAP_C21_B; \
+	type MPC_RMCM_GAMUT_REMAP_C22_B; \
+	type MPC_RMCM_GAMUT_REMAP_C23_B;\
+	type MPC_RMCM_GAMUT_REMAP_C24_B;\
+	type MPC_RMCM_GAMUT_REMAP_C31_B;\
+	type MPC_RMCM_GAMUT_REMAP_C32_B;\
+	type MPC_RMCM_GAMUT_REMAP_C33_B;\
+	type MPC_RMCM_GAMUT_REMAP_C34_B;\
+	type MPC_RMCM_SHAPER_MEM_PWR_FORCE; \
+	type MPC_RMCM_SHAPER_MEM_PWR_DIS; \
+	type MPC_RMCM_SHAPER_MEM_LOW_PWR_MODE; \
+	type MPC_RMCM_3DLUT_MEM_PWR_FORCE;\
+	type MPC_RMCM_3DLUT_MEM_PWR_DIS;\
+	type MPC_RMCM_3DLUT_MEM_LOW_PWR_MODE;\
+	type MPC_RMCM_SHAPER_MEM_PWR_STATE;\
+	type MPC_RMCM_3DLUT_MEM_PWR_STATE;\
+	type MPC_RMCM_3DLUT_FL_SEL;\
+	type MPC_RMCM_3DLUT_FL_DONE; \
+	type MPC_RMCM_3DLUT_FL_SOFT_UNDERFLOW; \
+	type MPC_RMCM_3DLUT_FL_HARD_UNDERFLOW; \
+	type MPC_RMCM_CNTL; \
+	type MPC_RMCM_TEST_DEBUG_INDEX;\
+	type MPC_RMCM_TEST_DEBUG_WRITE_EN;\
+	type MPC_RMCM_TEST_DEBUG_DATA
+
+#define MPC_RMCM_REG_VARIABLE_LIST_DCN42 \
+	uint32_t MPC_RMCM_SHAPER_CONTROL[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_OFFSET_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_OFFSET_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_OFFSET_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_SCALE_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_SCALE_G_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_LUT_INDEX[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_LUT_DATA[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_START_CNTL_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_END_CNTL_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_0_1[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_2_3[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_4_5[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_6_7[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_8_9[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_10_11[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_12_13[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_14_15[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_16_17[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_18_19[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_20_21[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_22_23[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_24_25[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_26_27[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_28_29[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_30_31[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMA_REGION_32_33[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_START_CNTL_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_END_CNTL_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_0_1[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_2_3[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_4_5[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_6_7[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_8_9[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_10_11[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_12_13[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_14_15[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_16_17[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_18_19[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_20_21[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_22_23[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_24_25[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_26_27[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_28_29[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_30_31[MAX_RMCM]; \
+	uint32_t MPC_RMCM_SHAPER_RAMB_REGION_32_33[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_MODE[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_INDEX[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_DATA[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_DATA_30BIT[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_READ_WRITE_CONTROL[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_OUT_NORM_FACTOR[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_R[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_G[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_OUT_OFFSET_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_COEF_FORMAT[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_MODE[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C11_C12_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C13_C14_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C21_C22_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C23_C24_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C31_C32_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C33_C34_A[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C11_C12_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C13_C14_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C21_C22_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C23_C24_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C31_C32_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_GAMUT_REMAP_C33_C34_B[MAX_RMCM]; \
+	uint32_t MPC_RMCM_MEM_PWR_CTRL[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_FAST_LOAD_SELECT[MAX_RMCM]; \
+	uint32_t MPC_RMCM_3DLUT_FAST_LOAD_STATUS[MAX_RMCM]; \
+	uint32_t MPC_RMCM_CNTL[MAX_RMCM]; \
+	uint32_t MPC_RMCM_TEST_DEBUG_INDEX[MAX_RMCM]; \
+	uint32_t MPC_RMCM_TEST_DEBUG_DATA[MAX_RMCM]
+
+struct dcn42_rmcm_shift {
+	MPC_RMCM_REG_FIELD_LIST_DCN42(uint8_t);
+};
+
+struct dcn42_rmcm_mask {
+	MPC_RMCM_REG_FIELD_LIST_DCN42(uint32_t);
+};
+
+struct dcn42_rmcm_registers {
+	MPC_RMCM_REG_VARIABLE_LIST_DCN42;
+};
+
+struct dcn42_rmcm {
+	struct rmcm base;
+	const struct dcn42_rmcm_registers *rmcm_regs;
+	const struct dcn42_rmcm_shift *rmcm_shift;
+	const struct dcn42_rmcm_mask *rmcm_mask;
+};
+
+void dcn42_rmcm_construct(
+	struct dcn42_rmcm *rmcm42,
+	struct dc_context *ctx,
+	const struct dcn42_rmcm_registers *regs,
+	const struct dcn42_rmcm_shift *shift,
+	const struct dcn42_rmcm_mask *mask,
+	int inst);
+
+/*
+ * Register-programming helpers shared with the DCN60 RMCM component. They are bank-count
+ * agnostic (LUT data, power, fast load, MPCC routing), so the single-SRAM DCN60 variant
+ * only overrides bank selection.
+ */
+void rmcm42_power_on_shaper_3dlut(struct rmcm *rmcm, uint32_t rmcm_id, bool power_on);
+uint32_t rmcm42_get_3dlut_width(const enum dc_cm_lut_size size);
+void rmcm42_populate_lut(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+	const union rmcm_lut_params params, bool lut_bank_a, int rmcm_id);
+void rmcm42_update_3dlut_fast_load_select(struct rmcm *rmcm, int rmcm_id, int hubp_idx);
+void rmcm42_get_3dlut_fast_load_status(struct rmcm *rmcm, int rmcm_id,
+	bool *done, bool *soft_underflow, bool *hard_underflow);
+void rmcm42_read_state(struct rmcm *rmcm, int rmcm_inst, struct rmcm_state *s);
+void rmcm42_connect_mpcc(struct rmcm *rmcm, int rmcm_id, int mpcc_id);
+
+#endif // __DC_RMCM_DCN42_H__
diff --git a/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c b/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
new file mode 100644
index 000000000000..df4d6476d70a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.c
@@ -0,0 +1,251 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+#include "reg_helper.h"
+
+#include "dcn/dcn_6_0_0_offset.h"
+#include "dcn/dcn_6_0_0_sh_mask.h"
+
+#include "dcn60_rmcm.h"
+
+#define SF(reg_name, field_name, post_fix)\
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+/* DCN60 renamed MPC_RMCM_3DLUT_RAM_SEL to MPC_RMCM_3DLUT_READ_SEL */
+#define MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL__MPC_RMCM_3DLUT_RAM_SEL__SHIFT \
+	MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL__MPC_RMCM_3DLUT_READ_SEL__SHIFT
+#define MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL__MPC_RMCM_3DLUT_RAM_SEL_MASK \
+	MPC_RMCM0_MPC_RMCM_3DLUT_READ_WRITE_CONTROL__MPC_RMCM_3DLUT_READ_SEL_MASK
+
+/* Resource-level macros needed by MPC_RMCM_REG_LIST_DCN42 */
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define SRII(reg_name, block, id)\
+	REG_STRUCT.reg_name[id] = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
+static struct dcn42_rmcm_registers rmcm_regs;
+
+#define dcn_rmcm_regs_init()               \
+	MPC_RMCM_REG_LIST_DCN42(0),            \
+		MPC_RMCM_REG_LIST_DCN42(1)
+
+static const struct dcn42_rmcm_shift rmcm_shift = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dcn42_rmcm_mask rmcm_mask = {
+	MPC_RMCM_COMMON_MASK_SH_LIST_DCN42(_MASK)};
+
+#define REG(reg)\
+	rmcm42->rmcm_regs->reg
+
+#define CTX \
+	rmcm42->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name) \
+	rmcm42->rmcm_shift->field_name, rmcm42->rmcm_mask->field_name
+
+/*
+ * DCN60 RMCM LUT-bank programming (single-SRAM variant).
+ *
+ * DCN60 has one LUT SRAM per RMCM instance instead of the DCN42 A/B pair, and the 3DLUT
+ * read/write-control RAM select was renamed RAM_SEL -> READ_SEL. These overrides always
+ * target bank A and ignore lut_bank_a, so nothing can select a bank that does not exist.
+ * Everything bank-agnostic (LUT upload, fast load, power, MPCC routing) is reused from the
+ * DCN42 rmcm42_* helpers.
+ */
+static void rmcm60_get_lut_mode(struct rmcm *rmcm,
+		const enum MCM_LUT_ID id,
+		int rmcm_id,
+		bool *enable,
+		bool *lut_bank_a)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+	uint32_t lut_mode = 0;
+
+	*enable = false;
+	*lut_bank_a = true; /* single SRAM: always bank A */
+
+	switch (id) {
+	case MCM_LUT_SHAPER:
+		REG_GET(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+				MPC_RMCM_SHAPER_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		break;
+	case MCM_LUT_1DLUT:
+		/* RMCM doesn't support 1DLUT, return disabled */
+		*enable = false;
+		break;
+	case MCM_LUT_3DLUT:
+	default:
+		REG_GET(MPC_RMCM_3DLUT_MODE[rmcm_id],
+				MPC_RMCM_3DLUT_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		break;
+	}
+}
+
+static void rmcm60_program_lut_mode(struct rmcm *rmcm,
+	const enum MCM_LUT_ID id,
+	bool enable,
+	bool lut_bank_a,
+	const enum dc_cm_lut_size size,
+	uint16_t bias,
+	uint16_t scale,
+	int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	(void)bias;
+	(void)scale;
+	(void)lut_bank_a; /* single SRAM: always bank A (mode 1) */
+
+	switch (id) {
+	case MCM_LUT_3DLUT:
+		if (enable) {
+			uint32_t lut_size = rmcm42_get_3dlut_width(size);
+
+			REG_UPDATE_2(MPC_RMCM_3DLUT_MODE[rmcm_id],
+					MPC_RMCM_3DLUT_MODE, 1,
+					MPC_RMCM_3DLUT_SIZE, lut_size);
+
+			/* Default to 12-bit (30BIT_EN=0) for DMA path;
+			 * populate_lut overrides for host-load path.
+			 */
+			REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+				MPC_RMCM_3DLUT_WRITE_EN_MASK, 0xF);
+			REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+				MPC_RMCM_3DLUT_30BIT_EN, 0);
+		} else {
+			if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+			REG_UPDATE(MPC_RMCM_3DLUT_MODE[rmcm_id], MPC_RMCM_3DLUT_MODE, 0);
+		}
+		break;
+	case MCM_LUT_SHAPER:
+		if (enable) {
+			REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+					MPC_RMCM_SHAPER_LUT_MODE, 1);
+		} else {
+			if (rmcm->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				rmcm42_power_on_shaper_3dlut(rmcm, rmcm_id, false);
+			REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[rmcm_id],
+					MPC_RMCM_SHAPER_LUT_MODE, 0);
+		}
+		break;
+	case MCM_LUT_1DLUT:
+		/* RMCM doesn't support 1DLUT */
+		break;
+	}
+}
+
+static void rmcm60_program_lut_read_write_control(struct rmcm *rmcm, const enum MCM_LUT_ID id,
+	bool lut_bank_a, bool enabled, int rmcm_id)
+{
+	struct dcn42_rmcm *rmcm42 = TO_DCN42_RMCM(rmcm);
+
+	(void)lut_bank_a; /* single SRAM: always bank A */
+
+	switch (id) {
+	case MCM_LUT_3DLUT:
+		REG_UPDATE(MPC_RMCM_3DLUT_MODE[rmcm_id], MPC_RMCM_3DLUT_MODE,
+			enabled ? 1 : 0);
+
+		/* DCN60 renamed RAM_SEL -> READ_SEL; single bank -> always 0 */
+		REG_UPDATE(MPC_RMCM_3DLUT_READ_WRITE_CONTROL[rmcm_id],
+			MPC_RMCM_3DLUT_RAM_SEL, 0);
+		break;
+	case MCM_LUT_SHAPER:
+		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK, 7);
+
+		REG_UPDATE(MPC_RMCM_SHAPER_LUT_WRITE_EN_MASK[rmcm_id],
+			MPC_RMCM_SHAPER_LUT_WRITE_SEL, 0);
+
+		REG_SET(MPC_RMCM_SHAPER_LUT_INDEX[rmcm_id], 0,
+			MPC_RMCM_SHAPER_LUT_INDEX, 0);
+		break;
+	default:
+		break;
+	}
+}
+
+/* DCN60 has no RAM_SEL - it became READ_SEL, which the reused DCN42 read_state maps onto
+ * via the compat macro. Clear the duplicate so the reported state stays unambiguous.
+ */
+static void rmcm60_read_state(struct rmcm *rmcm, int rmcm_inst,
+		struct rmcm_state *s)
+{
+	rmcm42_read_state(rmcm, rmcm_inst, s);
+	s->regs.rmcm_3dlut_ram_sel = 0;
+}
+
+static const struct rmcm_funcs dcn60_rmcm_funcs = {
+	.get_lut_mode = rmcm60_get_lut_mode,
+	.program_lut_mode = rmcm60_program_lut_mode,
+	.populate_lut = rmcm42_populate_lut,
+	.program_lut_read_write_control = rmcm60_program_lut_read_write_control,
+	.update_3dlut_fast_load_select = rmcm42_update_3dlut_fast_load_select,
+	.get_3dlut_fast_load_status = rmcm42_get_3dlut_fast_load_status,
+	.read_rmcm_state = rmcm60_read_state,
+	.connect_mpcc = rmcm42_connect_mpcc,
+};
+
+struct rmcm *dcn60_rmcm_create(struct dc_context *ctx, int inst)
+{
+	struct dcn42_rmcm *rmcm42 = kzalloc(sizeof(struct dcn42_rmcm), GFP_KERNEL);
+
+	if (!rmcm42)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT rmcm_regs
+	dcn_rmcm_regs_init();
+
+	dcn42_rmcm_construct(rmcm42,
+		ctx,
+		&rmcm_regs,
+		&rmcm_shift,
+		&rmcm_mask,
+		inst);
+
+	/* Override the DCN42 defaults with the DCN60 single-SRAM LUT-bank ops. */
+	rmcm42->base.funcs = &dcn60_rmcm_funcs;
+
+	return &rmcm42->base;
+}
+
+void dcn60_rmcm_destroy(struct rmcm **rmcm)
+{
+	if (*rmcm) {
+		kfree(TO_DCN42_RMCM(*rmcm));
+		*rmcm = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h b/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h
new file mode 100644
index 000000000000..8a8b2db2762a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/rmcm/dcn60/dcn60_rmcm.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_RMCM_DCN60_H__
+#define __DC_RMCM_DCN60_H__
+
+#include "dcn42/dcn42_rmcm.h"
+
+struct rmcm *dcn60_rmcm_create(struct dc_context *ctx, int inst);
+
+void dcn60_rmcm_destroy(struct rmcm **rmcm);
+
+#endif /* __DC_RMCM_DCN60_H__ */
-- 
2.43.0

