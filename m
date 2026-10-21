Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E198606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kYIrzyZA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22A710F969;
	Wed, 21 Oct 2026 06:28:13 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C573E10F969
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDDvuk35+ZTG7/Hbw+H5X729Ko3Xe/7amSLZ4BDYNeUdysDt0pLbUSPsvsmfSpd456MQPDWwbxmVukpg5NkPRbyCeQoU3LYQFoBQPZSKQg2uA1cnvWVESNQS6DVCVY7kGpd6085S9z8Brli6kCN/7huqVQEMKcUoR2PaiJjEreTYFnQ4OLkUHXzdN/iZnO6KCPCrr6JL+0JRwVsRf3pawLJ/1ad1BtzEeUO4rDBw8HyxvZeK/wKqNpgPbphG2qnsFUeSwCAu74PYGOL5E5mycR/UmNSbYRi+gHNS0c+iu+P6hf8pzpBy+rED8mqrB3tv4oQMZXm69oyZ1epNULcV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cMA4XUwE+SKg7bvZ5Bad7AodYxzRDhEUzZd3FCaGgg=;
 b=sVB19m9tm1UKiJobivfWqpXXISb2YefYG941Uwk7rHN+PAcUV+/2nCdMdMvKvtrY6sn3AZOTLAj2RcDdvrhntQTYxnNky5/8YPeAVlu/vRr+COpjTjQSuz8TiuCJebk+n2zlR639m4R57I0BbiVQEbXkGaLBKyYkRFTiMecsz/SPS9yUxgDR0Km4SG87bUa8dbxkbtNjT8WcjVI4XQPcnAHHRB6VNPqETrv14exkHBhZ7mFBKi0OJqkMU+n0Qnv/U5fLIlGPFtUXyI3V58f5XsAlgni84HGfM9V7wVRSp7hy4xxyuMZf4K78uWMn6Dqz+Y0a2AxHM9SQnEVI/CdwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cMA4XUwE+SKg7bvZ5Bad7AodYxzRDhEUzZd3FCaGgg=;
 b=kYIrzyZANsxTqOQjC6vt0GnLuhuud2wox1qNwl9iwvo1RjPNyZNubwNYL4KV8l8oWm9YOPa+MZuri7dOsVXtqZAxqz1TUP3YWOW4KHDVL6xSMKTevCqsvEa3IzDnZPnbiEJcbN1eNaBN0zMvdzj8RheHHRrH5JXdo2Ie2q+s7v0=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 21 Oct
 2026 06:27:04 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::42) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 06:27:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 27/49] drm/amd/display: Run DC2_DC1_Wrapped init as staged BLS
 builds
Date: Wed, 21 Oct 2026 14:22:33 +0800
Message-ID: <20261021062519.674697-28-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d692083-342c-4428-1bdc-08df2f3c52ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|261009220027099003|10067099003|56012099006|3023799007|261009223027099003|22082099003|18002099003|6133799003|5023799004|261009221227099003|261009223327099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: DvUUmmRx60EZrd8d3q/oF3wcCVaqjGv5ACpTQOWHyKzuDpV8KeQHSCsik6o7RmHogqQRY/7zH4NI709jQtIG5xaWXRTYoyRBo1asgSSSG1owNsji+RSnV9Wk4RQeHo3Tm7e5WJMLUSaW64MgdgFPr5PqMDPK0CKM/Y3TymJ9ZD4FOKt6F+O+3FN/XNfWvTSKoIlsPbSjoetzKqGju53/3OW2hGDhYY9ANNgH35FVkhft1+sgKnPOcdLCu1eJ+c1NrDNBm794HdubpmRvxzWClCvPU8EQddxn8+3cp8vwpfD+QFqpLAg3RHg6ssof/SdEM0RyczTWZ1lMPI2eND6Wcv+GYU8ZmnAuYDXTyRA+QPGsrhGGDHI8hYMVziSvA8sSzdIJSNVZY6dqiL73yfrlLQGNAt0xQciDLd3rBid508GOqFyvBJ+3ATwa021WL+BF8Tk2TtXfn2vGZgQxhTKRJsZsKk4iPGQ2zqLmWWSHNALyFwzv/Hw+mvrg7ya5cguamyGjHAaM1+fe2gTVHIjwC7A8u2QLV/XVlH+ESoY5CzqG/wlpJCfHA+0/00pOTVOsOi4Mq9T/fXIyyecEzIaZO/r2cPuC9n3Gv1bDq8gjUDm21HP5Or9B/QjzsrtwPzRTGOksCObpfwh8iuLfX7E6Xc+5h6Gzob7kr/TFlUINAxyFw53NsBCC7g545JIM142WpRi5ystBJnQYofJTj1slwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(261009220027099003)(10067099003)(56012099006)(3023799007)(261009223027099003)(22082099003)(18002099003)(6133799003)(5023799004)(261009221227099003)(261009223327099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ptQstuF6hR7bQjKhQjfkjUGUe1SpFJ1vGOec+o7DLinCJF6mWnJTE0MoIvRlylcd7K0gJ/OYcE1ENNcUHCPH5eb7Xltn9G/NSZpTMu9Pq8uVkVFtfDHxpzW0OAFf2xFK/6WTcpW3nuZICNcBhJ8BrqCy+9/BmNwu6cgsSkH3HpRytnNBM8U/iTmles63NNp73frNy8R72JKxuxaS97OPBX/nDCNen9qUHYOhTzTeweGVZC2t8MUVq4F4J393awCwc+gixwlqIVsNH/kwpqiXoaLN2cmzHzTOumlqiVWIWb6tRDz5ubyxti04IoKt/ATgp4ed2G2qqyU32GG2KChd+98kfDa5Cd8YfPSu55aoUXyaGuIM/JTKPKMc0CteHHtSAK/9iKid9PqKVBqRFJBJm7uqOgTI4lkP9zfekylspA9vzDWNHmjta9+Xy4iwGkRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:04.1353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d692083-342c-4428-1bdc-08df2f3c52ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
In DC2_DC1_Wrapped (DC2_SELECTION_CORE2), core2_hardware_init should
program the hardware exactly as dcn401_init_hw does, but through the
BLS contract: the Builder decides, Core owns state, the Executor only
calls. Today core2_hardware_init builds the DMUB-driven
DC2_Native sequence in one pass, and dcn401_init_hw cannot be built in
one pass: later calls depend on values read earlier (reference
clocks, DIG and FEC state, DENTIST dispclk, I2C info, backlight).

The wrapped init is a migration shim, so it lives in its own files and
can be removed as a unit once dcn401 init is native.

[How]
Stage contract (bls_builder_legacy_init.h, new):
- enum bls_builder_legacy_init_stage names the twelve stages, 1-based:
  CLOCKS, DCHUB_REF, LINK_ENC, FEC, BLANK, POWER_DOWN, MIN_CLOCKS,
  POWER_DOWN_EDP0, POWER_DOWN_EDP1, GATING, HUBBUB, POWER_STATE.
  A stage ends at a read that a later stage depends on.
- struct bls_builder_output_legacy_init_stage1..12 hold what each
  stage reads back. struct bls_builder_legacy_hw_init_info nests them
  with init_done, init_success and next_stage, and sits in dc_state
  as hw_init_info.

Builder (dcn401_init_builder_legacy.c/.h, new):
- DCN_DECL_INITIALIZATION_LEGACY is a new builder name, resolved by
  dcn401_bls_builder_create like DCN_DECL_INITIALIZATION.
- Each build emits hw_init_info.next_stage of dcn401_init_hw, reading
  earlier stage outputs from params->current_state->hw_init_info. It
  writes only the sequence and the stage's output in
  out_targets->DCN_DECL_INITIALIZATION_LEGACY, then sets next_stage
  and, after the last stage, init_done.
- Each stage makes the same calls in the same order as
  dcn401_init_hw, and skips a call only where dcn401_init_hw skips it.
- The Builder also builds the IHC, D0 power state and feature-caps
  DMUB commands, which legacy sends through dc_dmub_srv helpers. The
  ones legacy ignores on failure set continue_on_error.
- Validation fails the build closed on a missing target or hook,
  before anything is appended.
- dcn401_init_builder.h, new, shares bls_append and the clock, DC-mode,
  DCCG and DMUB helpers between the native and legacy builders.
- struct dmub_abi moves to bls_builder/dmub_abi.h so that struct dc2
  can retain it.

Core (dc_core2_legacy_init.c/.h, new):
- core2_run_legacy_hardware_init resets hw_init_info and loops until
  init_done: build, apply the workaround manager, execute, retain.
- Retaining moves the stage output into hw_init_info, then applies
  what dcn401_init_hw leaves on dc by then: the reference clocks and
  DC-mode limits, link active and FEC state where the DIG was found
  enabled, and, after HUBBUB, the feature caps. For the caps it takes
  the reply, mirrors it into dmub_srv, retains
  dc2->dmub_abi, and applies the caps and the bounding-box update.
- A failed build, workaround pass or execution stops init with
  init_success false, and no legacy fallback. CONTINUED_ON_ERROR
  counts as success.

Core (dc_core2_init.c):
- core2_hardware_init first runs the eDP presence check that
  legacy_hardware_init runs before init_hw. Then
  DC2_SELECTION_CORE2 runs core2_run_legacy_hardware_init; any other
  mode keeps the one-pass DCN_DECL_INITIALIZATION build.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |    2 +
 .../amd/display/dc/bls_builder/bls_builder.h  |    9 +-
 .../dc/bls_builder/bls_builder_legacy_init.h  |  128 ++
 .../dc/bls_builder/dcn401_init_builder.c      |   46 +-
 .../dc/bls_builder/dcn401_init_builder.h      |   42 +
 .../bls_builder/dcn401_init_builder_legacy.c  | 1071 +++++++++++++++++
 .../bls_builder/dcn401_init_builder_legacy.h  |   18 +
 .../drm/amd/display/dc/bls_builder/dmub_abi.h |   13 +
 .../drm/amd/display/dc/core2/dc_core2_init.c  |   42 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |  236 ++++
 .../display/dc/core2/dc_core2_legacy_init.h   |   17 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    7 +
 13 files changed, 1600 insertions(+), 35 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 795b30b066c6..84c55a253ebc 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -84,8 +84,10 @@ FILES += core/dc_surface.o
 FILES += core/dc_vm_helper.o
 FILES += core2/dc_core2.o
 FILES += core2/dc_core2_init.o
+FILES += core2/dc_core2_legacy_init.o
 FILES += bls_builder/bls_builder.o
 FILES += bls_builder/dcn401_init_builder.o
+FILES += bls_builder/dcn401_init_builder_legacy.o
 FILES += bls_executor/bls_executor.o
 FILES += workaround_manager/workaround_manager.o
 FILES += dmub_messenger/dmub_messenger.o
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 73d985e9b04f..422ee25cf348 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -9,6 +9,8 @@
 #include "dmub_cmd.h"
 #include "dmub/dmub_srv.h"
 #include "hwss/hw_sequencer.h"
+#include "bls_builder/dmub_abi.h"
+#include "bls_builder/bls_builder_legacy_init.h"
 
 #define DC2_BLS_MAX_STEPS 64
 
@@ -21,6 +23,7 @@ enum bls_builder_result {
 
 enum bls_builder_name {
 	DCN_DECL_INITIALIZATION,
+	DCN_DECL_INITIALIZATION_LEGACY,
 	BLS_BUILDER_NAME_COUNT,
 };
 
@@ -29,11 +32,6 @@ enum bls_builder_kind {
 	BLS_BUILDER_IMPERATIVE,
 };
 
-struct dmub_abi {
-	unsigned int fw_version;
-	struct dmub_feature_caps feature_caps;
-};
-
 struct bls_builder_output_init {
 	unsigned int xtalin_clock_inKhz;
 	unsigned int dccg_ref_clock_inKhz;
@@ -50,6 +48,7 @@ struct bls_builder_output_init {
 struct bls_builder_output_targets {
 	union {
 		struct bls_builder_output_init *DCN_DECL_INITIALIZATION;
+		struct bls_builder_legacy_hw_init_info *DCN_DECL_INITIALIZATION_LEGACY;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h
new file mode 100644
index 000000000000..e9259699a9c0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dmub_cmd.h"
+#include "grph_object_ctrl_defs.h"
+#include "bios_parser_types.h"
+#include "inc/hw/hw_shared.h"
+
+/*
+ * DC2_DC1_Wrapped hardware init: dcn401_init_hw as twelve BLS stages.
+ * A stage ends on a read that a later stage depends on. Stage N writes
+ * bls_builder_output_legacy_init_stageN; a later stage reads it from
+ * dc_state.hw_init_info.
+ */
+enum bls_builder_legacy_init_stage {
+	LEGACY_INIT_STAGE_CLOCKS = 1,
+	LEGACY_INIT_STAGE_DCHUB_REF,
+	LEGACY_INIT_STAGE_LINK_ENC,
+	LEGACY_INIT_STAGE_FEC,
+	LEGACY_INIT_STAGE_BLANK,
+	LEGACY_INIT_STAGE_POWER_DOWN,
+	LEGACY_INIT_STAGE_MIN_CLOCKS,
+	LEGACY_INIT_STAGE_POWER_DOWN_EDP0,
+	LEGACY_INIT_STAGE_POWER_DOWN_EDP1,
+	LEGACY_INIT_STAGE_GATING,
+	LEGACY_INIT_STAGE_HUBBUB,
+	LEGACY_INIT_STAGE_POWER_STATE,
+	LEGACY_INIT_STAGE_COUNT = LEGACY_INIT_STAGE_POWER_STATE,
+};
+
+/* CLOCKS: DC-mode limits and the DCCG reference clocks. */
+struct bls_builder_output_legacy_init_stage1 {
+	bool dcmode_power_limits_present;
+	unsigned int xtalin_clock_inKhz;
+	unsigned int dccg_ref_clock_inKhz;
+};
+
+/* DCHUB_REF: the DCHUB reference clock, before and after the read. */
+struct bls_builder_output_legacy_init_stage2 {
+	unsigned int dchub_ref_clock_mhz_before;
+	unsigned int dchub_ref_clock_inKhz;
+};
+
+/* LINK_ENC: per dc->links entry, the DIG state and the I2C info. */
+struct bls_builder_output_legacy_init_stage3 {
+	bool link_dig_enabled[MAX_LINKS];
+	struct graphics_object_i2c_info link_i2c_info[MAX_LINKS];
+	enum bp_result link_i2c_result[MAX_LINKS];
+};
+
+/* FEC: per dc->links entry, whether FEC is active. */
+struct bls_builder_output_legacy_init_stage4 {
+	bool link_fec_active[MAX_LINKS];
+};
+
+/* BLANK: the VBIOS accelerated-mode bit after blanking. */
+struct bls_builder_output_legacy_init_stage5 {
+	bool accelerated_mode;
+};
+
+/* POWER_DOWN: the DENTIST dispclk. */
+struct bls_builder_output_legacy_init_stage6 {
+	int dispclk_from_dentist_khz;
+};
+
+/* MIN_CLOCKS: power-down-on-boot DIG reads for eDP slot 0, or every link. */
+struct bls_builder_output_legacy_init_stage7 {
+	bool edp_dig_enabled;
+	bool boot_dig_enabled[MAX_LINKS];
+};
+
+/* POWER_DOWN_EDP0: the power-down-on-boot DIG read for eDP slot 1. */
+struct bls_builder_output_legacy_init_stage8 {
+	bool edp_dig_enabled;
+};
+
+/* POWER_DOWN_EDP1: the backlight panel_cntl reports, and the IHC commands. */
+struct bls_builder_output_legacy_init_stage9 {
+	uint32_t backlight;
+	uint32_t user_level;
+	union dmub_rb_cmd dmub_ihc_cmd[MAX_LINKS];
+};
+
+/* GATING: the VBIOS accelerated-mode bit after gating. */
+struct bls_builder_output_legacy_init_stage10 {
+	bool accelerated_mode;
+};
+
+/*
+ * HUBBUB: whether the DMUB feature caps apply, whether the query was
+ * sent, and the command that holds the reply.
+ */
+struct bls_builder_output_legacy_init_stage11 {
+	bool dmub_caps_read;
+	bool dmub_caps_query_sent;
+	union dmub_rb_cmd dmub_query_feature_caps_cmd;
+};
+
+/* POWER_STATE: the D0 power-state command. */
+struct bls_builder_output_legacy_init_stage12 {
+	union dmub_rb_cmd dmub_power_state_cmd;
+};
+
+/*
+ * next_stage is the stage the builder builds next, and s1 up to the
+ * stage before it are valid. Core stops at init_done.
+ */
+struct bls_builder_legacy_hw_init_info {
+	bool init_done;
+	bool init_success;
+	unsigned int next_stage;
+	struct bls_builder_output_legacy_init_stage1 s1;
+	struct bls_builder_output_legacy_init_stage2 s2;
+	struct bls_builder_output_legacy_init_stage3 s3;
+	struct bls_builder_output_legacy_init_stage4 s4;
+	struct bls_builder_output_legacy_init_stage5 s5;
+	struct bls_builder_output_legacy_init_stage6 s6;
+	struct bls_builder_output_legacy_init_stage7 s7;
+	struct bls_builder_output_legacy_init_stage8 s8;
+	struct bls_builder_output_legacy_init_stage9 s9;
+	struct bls_builder_output_legacy_init_stage10 s10;
+	struct bls_builder_output_legacy_init_stage11 s11;
+	struct bls_builder_output_legacy_init_stage12 s12;
+};
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 6d96c5244ac9..589a950e078b 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -11,6 +11,8 @@
 #include "dc_dmub_srv.h"
 #include "dmub_cmd.h"
 #include "bls_builder/bls_builder_internal.h"
+#include "bls_builder/dcn401_init_builder.h"
+#include "bls_builder/dcn401_init_builder_legacy.h"
 
 static const enum block_sequence_func dcn401_dc2_init_sequence[] = {
 	LEGACY_CLK_MGR_INIT_CLOCKS,
@@ -23,24 +25,6 @@ static const enum block_sequence_func dcn401_dc2_init_sequence[] = {
 	DMUB_INITIALIZE_DCN,
 };
 
-static bool bls_append(struct block_sequence_state *sequence,
-		enum block_sequence_func func,
-		const union block_sequence_params *params)
-{
-	struct block_sequence *entry;
-
-	if (!sequence || !sequence->steps || !sequence->num_steps ||
-			!params || *sequence->num_steps >=
-			DC2_BLS_MAX_STEPS)
-		return false;
-
-	entry = &sequence->steps[*sequence->num_steps];
-	entry->params = *params;
-	entry->func = func;
-	(*sequence->num_steps)++;
-	return true;
-}
-
 static enum bls_builder_result dcn401_check_initialization_support(
 		const struct bls_builder_check_capability_params *params)
 {
@@ -136,7 +120,7 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 	}
 }
 
-static inline enum bls_builder_result dcn401_build_clk_mgr_init(
+enum bls_builder_result dcn401_build_clk_mgr_init(
 		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence)
 {
 	union block_sequence_params bls_params = {0};
@@ -148,7 +132,7 @@ static inline enum bls_builder_result dcn401_build_clk_mgr_init(
 	return BLS_BUILD_SUCCESS;
 }
 
-static inline enum bls_builder_result dcn401_build_dc_mode_read(
+enum bls_builder_result dcn401_build_dc_mode_read(
 		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
 		struct block_sequence_state *sequence)
 {
@@ -165,7 +149,7 @@ static inline enum bls_builder_result dcn401_build_dc_mode_read(
 	return BLS_BUILD_SUCCESS;
 }
 
-static inline enum bls_builder_result dcn401_build_dccg_init(
+enum bls_builder_result dcn401_build_dccg_init(
 		struct dccg *dccg, struct block_sequence_state *sequence)
 {
 	union block_sequence_params bls_params = {0};
@@ -248,7 +232,7 @@ static inline enum bls_builder_result dcn401_build_dmub_fw_version(
 	return BLS_BUILD_SUCCESS;
 }
 
-static bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
+bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
 		struct dc_context *ctx, union dmub_rb_cmd *cmd,
 		enum dm_dmub_wait_type wait_type, bool continue_on_error)
 {
@@ -261,7 +245,7 @@ static bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
 	return bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params);
 }
 
-static void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd)
+void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd)
 {
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->query_feature_caps.header.type = DMUB_CMD__QUERY_FEATURE_CAPS;
@@ -411,9 +395,19 @@ const struct bls_builder *dcn401_bls_builder_create(
 		.check_capability = dcn401_initialization_check_capability,
 		.build.declarative = dcn401_build_initialization,
 	};
+	static const struct bls_builder legacy_initialization_builder = {
+		.name = DCN_DECL_INITIALIZATION_LEGACY,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_dc1_initialization_check_capability,
+		.build.declarative = dcn401_build_dc1_initialization,
+	};
 
-	if (name != DCN_DECL_INITIALIZATION)
+	switch (name) {
+	case DCN_DECL_INITIALIZATION:
+		return &initialization_builder;
+	case DCN_DECL_INITIALIZATION_LEGACY:
+		return &legacy_initialization_builder;
+	default:
 		return NULL;
-
-	return &initialization_builder;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
new file mode 100644
index 000000000000..fe70971cb8a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+
+struct clk_mgr;
+struct dccg;
+struct dc_context;
+
+static inline bool bls_append(struct block_sequence_state *sequence,
+		enum block_sequence_func func,
+		const union block_sequence_params *params)
+{
+	struct block_sequence *entry;
+
+	if (!sequence || !sequence->steps || !sequence->num_steps ||
+			!params || *sequence->num_steps >=
+			DC2_BLS_MAX_STEPS)
+		return false;
+
+	entry = &sequence->steps[*sequence->num_steps];
+	entry->params = *params;
+	entry->func = func;
+	(*sequence->num_steps)++;
+	return true;
+}
+
+enum bls_builder_result dcn401_build_clk_mgr_init(
+		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence);
+enum bls_builder_result dcn401_build_dc_mode_read(
+		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
+		struct block_sequence_state *sequence);
+enum bls_builder_result dcn401_build_dccg_init(
+		struct dccg *dccg, struct block_sequence_state *sequence);
+bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
+		struct dc_context *ctx, union dmub_rb_cmd *cmd,
+		enum dm_dmub_wait_type wait_type, bool continue_on_error);
+void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
new file mode 100644
index 000000000000..e13c16920a0c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
@@ -0,0 +1,1071 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "clk_mgr.h"
+#include "dccg.h"
+#include "resource.h"
+#include "dc_dmub_srv.h"
+#include "dmub_cmd.h"
+#include "abm.h"
+#include "audio.h"
+#include "dchubbub.h"
+#include "dio.h"
+#include "link_encoder.h"
+#include "panel_cntl.h"
+#include "link_service.h"
+#include "dc_bios_types.h"
+#include "dce/dce_hwseq.h"
+#include "hwss/hw_sequencer_private.h"
+#include "dcn32/dcn32_resource.h"
+#include "bls_builder/dcn401_init_builder.h"
+#include "bls_builder/dcn401_init_builder_legacy.h"
+
+/*
+ * DC2_DC1_Wrapped: dcn401_init_hw as BLS entries, built one stage per
+ * call. A stage ends on a read whose value a later stage needs: Core
+ * executes the stage and retains its output in dc_state.hw_init_info,
+ * where the next build reads it. Same calls in the same order, and an
+ * entry is left out only where dcn401_init_hw skips the call. The build
+ * reads dc and hw_init_info, and writes only the sequence and the
+ * output target.
+ */
+static_assert(LEGACY_INIT_STAGE_POWER_DOWN_EDP1 -
+		LEGACY_INIT_STAGE_POWER_DOWN_EDP0 + 1 == MAX_NUM_EDP,
+		"one power-down-on-boot stage per eDP slot");
+
+static bool dcn401_dc1_is_phy_link(const struct dc_link *link)
+{
+	return link->ep_type == DISPLAY_ENDPOINT_PHY;
+}
+
+static bool dcn401_dc1_powers_down_pipes(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *in)
+{
+	return in->s5.accelerated_mode ||
+			!dc->config.seamless_boot_edp_requested;
+}
+
+static bool dcn401_dc1_uses_accelerated_mode(struct dc *dc)
+{
+	return dc->hwss.enable_accelerated_mode &&
+			dc->debug.disable_boot_optimizations;
+}
+
+static bool dcn401_dc1_has_dmub(struct dc *dc)
+{
+	return dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
+}
+
+static enum bls_builder_result dcn401_validate_dc1_links(struct dc *dc)
+{
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+	unsigned int i;
+
+	if (dc->link_count > MAX_LINKS)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	for (i = 0; i < dc->link_count; i++) {
+		const struct dc_link *link = dc->links[i];
+
+		if (!link)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		if (dcn401_dc1_is_phy_link(link) && (!link->link_enc ||
+				!link->link_enc->funcs ||
+				!link->link_enc->funcs->hw_init))
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		if (link->panel_cntl && (!link->panel_cntl->funcs ||
+				!link->panel_cntl->funcs->hw_init))
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		if (link->force_to_use_aux && (!link->ctx ||
+				!dcb->funcs->get_i2c_info))
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	}
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_validate_dc1_power_down(struct dc *dc)
+{
+	if (!dcn401_dc1_uses_accelerated_mode(dc) &&
+			!dc->hwseq->funcs.init_pipes)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (!dc->current_state || !dc->clk_mgr || !dc->clk_mgr->funcs ||
+			!dc->clk_mgr->funcs->update_clocks ||
+			!dc->clk_mgr->bw_params)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_validate_dc1_hwseq(struct dc *dc)
+{
+	const struct hwseq_private_funcs *funcs = &dc->hwseq->funcs;
+
+	if (dc->debug.enable_mem_low_power.bits.optc &&
+			!funcs->init_odm_mem_power)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (dc->debug.enable_mem_low_power.bits.vga &&
+			!funcs->power_down_vga_mem)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (!dc->debug.disable_clock_gate && !funcs->dcfclk_gating_control)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (!funcs->init_hpo_hw_control)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_validate_dc1_initialization(
+		const struct bls_builder_declarative_params *params)
+{
+	const struct bls_builder_legacy_hw_init_info *in;
+	struct dc *dc = params->dc;
+	struct resource_pool *pool;
+	struct dc_bios *dcb;
+	unsigned int i;
+
+	if (!dc || !dc->ctx || !dc->res_pool || !params->current_state ||
+			!params->out_targets ||
+			!params->out_targets->DCN_DECL_INITIALIZATION_LEGACY)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	in = &params->current_state->hw_init_info;
+	if (in->next_stage < LEGACY_INIT_STAGE_CLOCKS ||
+			in->next_stage > LEGACY_INIT_STAGE_COUNT)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
+		return BLS_BUILD_SUCCESS;
+
+	pool = dc->res_pool;
+	dcb = dc->ctx->dc_bios;
+	if (!dcb || !dcb->funcs || !dcb->funcs->is_accelerated_mode ||
+			!pool->dccg || !pool->dccg->funcs || !pool->hubbub ||
+			!pool->hubbub->funcs || !dc->hwseq || !dc->link_srv ||
+			!dc->link_srv->blank_all_dp_displays)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	/* Later stages re-check only what a stage read-back decides. */
+	if ((in->next_stage == LEGACY_INIT_STAGE_POWER_DOWN ||
+			in->next_stage == LEGACY_INIT_STAGE_MIN_CLOCKS) &&
+			dcn401_dc1_powers_down_pipes(dc, in))
+		return dcn401_validate_dc1_power_down(dc);
+	if (in->next_stage != LEGACY_INIT_STAGE_CLOCKS)
+		return BLS_BUILD_SUCCESS;
+
+	if (dcb->fw_info_valid && (!pool->dccg->funcs->get_dccg_ref_freq ||
+			!pool->hubbub->funcs->get_dchub_ref_freq))
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (dcn401_validate_dc1_links(dc) != BLS_BUILD_SUCCESS)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (dcn401_validate_dc1_hwseq(dc) != BLS_BUILD_SUCCESS)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	for (i = 0; i < pool->audio_count; i++)
+		if (!pool->audios[i] || !pool->audios[i]->funcs ||
+				!pool->audios[i]->funcs->hw_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	for (i = 0; i < pool->pipe_count; i++)
+		if (pool->multiple_abms[i] && pool->multiple_abms[i]->funcs &&
+				!pool->multiple_abms[i]->funcs->abm_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (pool->dio && !pool->dio->funcs)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	/* Without seamless boot the pipes power down whatever the BIOS reads. */
+	if (!dc->config.seamless_boot_edp_requested)
+		return dcn401_validate_dc1_power_down(dc);
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool dcn401_add_hwseq_reg(struct block_sequence_state *sequence,
+		enum block_sequence_func func, struct dce_hwseq *hws,
+		bool enable)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hwseq_reg_control_params.hws = hws;
+	bls_params.hwseq_reg_control_params.enable = enable;
+	return bls_append(sequence, func, &bls_params);
+}
+
+static bool dcn401_add_dc_call(struct block_sequence_state *sequence,
+		enum block_sequence_func func, struct dc *dc, bool enable)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dc_init_call_params.dc = dc;
+	bls_params.dc_init_call_params.enable = enable;
+	return bls_append(sequence, func, &bls_params);
+}
+
+static bool dcn401_add_dccg_ref_freq(struct block_sequence_state *sequence,
+		struct dc *dc, struct bls_builder_output_legacy_init_stage1 *out)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dccg_get_ref_freq_params.dccg = dc->res_pool->dccg;
+	bls_params.dccg_get_ref_freq_params.xtalin_khz =
+			dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
+	bls_params.dccg_get_ref_freq_params.out_xtalin_khz =
+			&out->xtalin_clock_inKhz;
+	bls_params.dccg_get_ref_freq_params.out_dccg_ref_khz =
+			&out->dccg_ref_clock_inKhz;
+	return bls_append(sequence, DCCG_GET_REF_FREQ, &bls_params);
+}
+
+/* Core published the DCCG reference clock after the previous stage. */
+static bool dcn401_add_dchub_ref_freq(struct block_sequence_state *sequence,
+		struct dc *dc, struct bls_builder_output_legacy_init_stage2 *out)
+{
+	union block_sequence_params bls_params = {0};
+	struct resource_pool *pool = dc->res_pool;
+
+	out->dchub_ref_clock_mhz_before =
+			pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
+	bls_params.hubbub_get_dchub_ref_freq_params.hubbub = pool->hubbub;
+	bls_params.hubbub_get_dchub_ref_freq_params.dccg_ref_khz =
+			pool->ref_clocks.dccg_ref_clock_inKhz;
+	bls_params.hubbub_get_dchub_ref_freq_params.out_dchub_ref_khz =
+			&out->dchub_ref_clock_inKhz;
+	return bls_append(sequence, HUBBUB_GET_DCHUB_REF_FREQ, &bls_params);
+}
+
+static bool dcn401_add_accelerated_mode_read(
+		struct block_sequence_state *sequence, struct dc *dc,
+		bool *out_accelerated_mode)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.bios_is_accelerated_mode_params.dcb = dc->ctx->dc_bios;
+	bls_params.bios_is_accelerated_mode_params.out_accelerated_mode =
+			out_accelerated_mode;
+	return bls_append(sequence, BIOS_IS_ACCELERATED_MODE, &bls_params);
+}
+
+static bool dcn401_add_link_enc_hw_init(
+		struct block_sequence_state *sequence,
+		struct link_encoder *link_enc)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.link_enc_hw_init_params.link_enc = link_enc;
+	return bls_append(sequence, DIO_LINK_ENC_HW_INIT, &bls_params);
+}
+
+/* Without is_dig_enabled, dcn401_init_hw takes the DIG as disabled. */
+static bool dcn401_add_dig_read(struct block_sequence_state *sequence,
+		struct link_encoder *link_enc, bool *out_dig_enabled)
+{
+	union block_sequence_params bls_params = {0};
+
+	if (!link_enc || !link_enc->funcs || !link_enc->funcs->is_dig_enabled)
+		return true;
+	bls_params.link_enc_is_dig_enabled_params.link_enc = link_enc;
+	bls_params.link_enc_is_dig_enabled_params.out_dig_enabled =
+			out_dig_enabled;
+	return bls_append(sequence, DIO_LINK_ENC_IS_DIG_ENABLED, &bls_params);
+}
+
+static bool dcn401_add_fec_read(struct block_sequence_state *sequence,
+		struct link_encoder *link_enc, bool *out_fec_active)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.link_enc_fec_is_active_params.link_enc = link_enc;
+	bls_params.link_enc_fec_is_active_params.out_fec_active =
+			out_fec_active;
+	return bls_append(sequence, DIO_LINK_ENC_FEC_IS_ACTIVE, &bls_params);
+}
+
+static bool dcn401_add_i2c_info_read(struct block_sequence_state *sequence,
+		struct dc *dc, const struct dc_link *link,
+		struct graphics_object_i2c_info *out_info,
+		enum bp_result *out_result)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.bios_get_i2c_info_params.dcb = dc->ctx->dc_bios;
+	bls_params.bios_get_i2c_info_params.link_id = link->link_id;
+	bls_params.bios_get_i2c_info_params.out_info = out_info;
+	bls_params.bios_get_i2c_info_params.out_result = out_result;
+	return bls_append(sequence, BIOS_GET_I2C_INFO, &bls_params);
+}
+
+static bool dcn401_add_dentist_read(struct block_sequence_state *sequence,
+		struct clk_mgr *clk_mgr, int *out_dispclk_khz)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.clk_mgr_get_dispclk_from_dentist_params.clk_mgr = clk_mgr;
+	bls_params.clk_mgr_get_dispclk_from_dentist_params.out_dispclk_khz =
+			out_dispclk_khz;
+	return bls_append(sequence, CLK_MGR_GET_DISPCLK_FROM_DENTIST,
+			&bls_params);
+}
+
+static bool dcn401_add_edp_control(struct block_sequence_state *sequence,
+		enum block_sequence_func func, struct dc_link *link,
+		bool enable)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.edp_control_params.link = link;
+	bls_params.edp_control_params.enable = enable;
+	return bls_append(sequence, func, &bls_params);
+}
+
+static bool dcn401_add_self_refresh_control(
+		struct block_sequence_state *sequence, struct dc *dc)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hubbub_allow_self_refresh_control_params.hubbub =
+			dc->res_pool->hubbub;
+	bls_params.hubbub_allow_self_refresh_control_params.allow =
+			!dc->debug.disable_stutter;
+	return bls_append(sequence, HUBBUB_ALLOW_SELF_REFRESH_CONTROL,
+			&bls_params);
+}
+
+/* The clocks dcn401_initialize_min_clocks requests, from software state. */
+static bool dcn401_add_min_clocks(struct block_sequence_state *sequence,
+		struct dc *dc, const struct bls_builder_legacy_hw_init_info *in)
+{
+	union block_sequence_params bls_params = {0};
+	struct clk_mgr_initialize_min_clocks_params *p =
+			&bls_params.clk_mgr_initialize_min_clocks_params;
+	struct clk_mgr *clk_mgr = dc->clk_mgr;
+	const struct clk_limit_table_entry *entry =
+			&clk_mgr->bw_params->clk_table.entries[0];
+
+	p->clk_mgr = clk_mgr;
+	p->context = dc->current_state;
+	p->dcfclk_deep_sleep_khz = DCN3_2_DCFCLK_DS_INIT_KHZ;
+	p->dcfclk_khz = entry->dcfclk_mhz * 1000;
+	p->socclk_khz = entry->socclk_mhz * 1000;
+	p->dramclk_khz = entry->memclk_mhz * 1000;
+	p->dppclk_khz = entry->dppclk_mhz * 1000;
+	if (dc->debug.disable_boot_optimizations)
+		p->dispclk_khz = entry->dispclk_mhz * 1000;
+	else if (clk_mgr->funcs->get_dispclk_from_dentist)
+		/* Keep the current DISPCLK so a lit display keeps its timing. */
+		p->dispclk_khz = in->s6.dispclk_from_dentist_khz;
+	else
+		p->dispclk_khz = clk_mgr->boot_snapshot.dispclk;
+	p->ref_dtbclk_khz = entry->dtbclk_mhz * 1000;
+	p->fclk_p_state_change_support = true;
+	p->p_state_change_support = true;
+	return bls_append(sequence, LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS,
+			&bls_params);
+}
+
+static bool dcn401_add_audio_hw_init(struct block_sequence_state *sequence,
+		struct audio *audio)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.audio_hw_init_params.audio = audio;
+	return bls_append(sequence, AUDIO_HW_INIT, &bls_params);
+}
+
+static bool dcn401_add_panel_cntl_hw_init(
+		struct block_sequence_state *sequence,
+		struct panel_cntl *panel_cntl, uint32_t *out_backlight,
+		uint32_t *out_user_level)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.panel_cntl_hw_init_params.panel_cntl = panel_cntl;
+	bls_params.panel_cntl_hw_init_params.out_backlight = out_backlight;
+	bls_params.panel_cntl_hw_init_params.out_user_level = out_user_level;
+	return bls_append(sequence, PANEL_CNTL_HW_INIT, &bls_params);
+}
+
+static bool dcn401_add_ddc_open(struct block_sequence_state *sequence,
+		const struct dc_link *link,
+		const struct graphics_object_i2c_info *i2c_info)
+{
+	union block_sequence_params bls_params = {0};
+	struct gpio_ddc_open_params *p = &bls_params.gpio_ddc_open_params;
+
+	p->gpio_service = link->ctx->gpio_service;
+	p->clk_a_register_index = i2c_info->gpio_info.clk_a_register_index;
+	p->clk_a_mask = 1 << i2c_info->gpio_info.clk_a_shift;
+	p->hw_info.ddc_channel = i2c_info->i2c_line;
+	p->hw_info.hw_supported = i2c_info->i2c_hw_assist;
+	return bls_append(sequence, GPIO_DDC_OPEN, &bls_params);
+}
+
+/* dc_dmub_srv_ihc_set_dig_hdcp_interrupt_dest(dmub_srv, eng_id, true) */
+static bool dcn401_add_hdcp_interrupt_dest(
+		struct block_sequence_state *sequence, struct dc *dc,
+		const struct dc_link *link, union dmub_rb_cmd *cmd)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->ihc.header.type = DMUB_CMD__IHC;
+	cmd->ihc.header.sub_type = DMUB_CMD__IHC_SET_DIG_HDCP_INTERRUPT_DEST;
+	cmd->ihc.header.payload_bytes = sizeof(cmd->ihc.data);
+	cmd->ihc.data.dig_id = (uint8_t)link->eng_id;
+	cmd->ihc.data.to_dmu = 1;
+	return dcn401_add_dmub_cmd(sequence, dc->ctx, cmd,
+			DM_DMUB_WAIT_TYPE_WAIT, true);
+}
+
+static bool dcn401_add_abm_init(struct block_sequence_state *sequence,
+		struct abm *abm, const struct bls_builder_legacy_hw_init_info *in)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.abm_init_params.abm = abm;
+	bls_params.abm_init_params.backlight = in->s9.backlight;
+	bls_params.abm_init_params.user_level = in->s9.user_level;
+	return bls_append(sequence, ABM_INIT, &bls_params);
+}
+
+static bool dcn401_add_dio_mem_power(struct block_sequence_state *sequence,
+		struct dio *dio)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dio_set_mem_power_params.dio = dio;
+	bls_params.dio_set_mem_power_params.enable = false;
+	return bls_append(sequence, DIO_AFMT_SET_MEM_POWER, &bls_params);
+}
+
+static bool dcn401_add_root_clock_gating(
+		struct block_sequence_state *sequence, struct dccg *dccg)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dccg_set_root_clock_gating_params.dccg = dccg;
+	bls_params.dccg_set_root_clock_gating_params.allow = true;
+	return bls_append(sequence, DCCG_SET_ROOT_CLOCK_GATING, &bls_params);
+}
+
+static bool dcn401_add_init_watermarks(struct block_sequence_state *sequence,
+		struct hubbub *hubbub)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hubbub_init_watermarks_params.hubbub = hubbub;
+	return bls_append(sequence, HUBBUB_INIT_WATERMARKS, &bls_params);
+}
+
+static bool dcn401_add_notify_wm_ranges(
+		struct block_sequence_state *sequence, struct clk_mgr *clk_mgr)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.clk_mgr_notify_wm_ranges_params.clk_mgr = clk_mgr;
+	return bls_append(sequence, LEGACY_CLK_MGR_NOTIFY_WM_RANGES,
+			&bls_params);
+}
+
+static bool dcn401_add_force_pstate(struct block_sequence_state *sequence,
+		struct hubbub *hubbub)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hubbub_force_pstate_change_control_params.hubbub = hubbub;
+	bls_params.hubbub_force_pstate_change_control_params.enable = false;
+	bls_params.hubbub_force_pstate_change_control_params.allow = false;
+	return bls_append(sequence, HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+			&bls_params);
+}
+
+static bool dcn401_add_init_crb(struct block_sequence_state *sequence,
+		struct hubbub *hubbub)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hubbub_init_crb_params.hubbub = hubbub;
+	return bls_append(sequence, HUBBUB_INIT_CRB, &bls_params);
+}
+
+static bool dcn401_add_request_limit(struct block_sequence_state *sequence,
+		struct dc *dc)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.hubbub_set_request_limit_params.hubbub =
+			dc->res_pool->hubbub;
+	bls_params.hubbub_set_request_limit_params.num_chans =
+			dc->ctx->dc_bios->vram_info.num_chans;
+	bls_params.hubbub_set_request_limit_params.words_per_umc =
+			dc->config.sdpif_request_limit_words_per_umc;
+	return bls_append(sequence, HUBBUB_SET_REQUEST_LIMIT, &bls_params);
+}
+
+/*
+ * dc_dmub_srv_query_caps_cmd. The reply stays in the command; Core
+ * interprets it. The caps apply whether or not the query is sent.
+ */
+static bool dcn401_add_query_caps(struct block_sequence_state *sequence,
+		struct dc *dc, struct bls_builder_output_legacy_init_stage11 *out)
+{
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+
+	if (!dc_dmub_srv)
+		return true;
+	if (!dc_dmub_srv->dmub)
+		return false;
+	out->dmub_caps_read = true;
+	dcn401_fill_query_feature_caps_cmd(&out->dmub_query_feature_caps_cmd);
+	out->dmub_caps_query_sent = true;
+	return dcn401_add_dmub_cmd(sequence, dc->ctx,
+			&out->dmub_query_feature_caps_cmd,
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY, true);
+}
+
+/* dc_dmub_srv_notify_fw_dc_power_state(dmub_srv, D0) */
+static bool dcn401_add_notify_power_state(
+		struct block_sequence_state *sequence, struct dc *dc,
+		union dmub_rb_cmd *cmd)
+{
+	if (!dcn401_dc1_has_dmub(dc))
+		return true;
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->idle_opt_set_dc_power_state.header.type = DMUB_CMD__IDLE_OPT;
+	cmd->idle_opt_set_dc_power_state.header.sub_type =
+			DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE;
+	cmd->idle_opt_set_dc_power_state.header.payload_bytes =
+			sizeof(cmd->idle_opt_set_dc_power_state) -
+			sizeof(cmd->idle_opt_set_dc_power_state.header);
+	cmd->idle_opt_set_dc_power_state.data.power_state =
+			DMUB_IDLE_OPT_DC_POWER_STATE_D0;
+	return dcn401_add_dmub_cmd(sequence, dc->ctx, cmd,
+			DM_DMUB_WAIT_TYPE_WAIT, true);
+}
+
+/*
+ * Power down on boot, eDP slot by slot. A slot reads its eDP's DIG only
+ * after the previous slot acted, since power_down can change it. With
+ * no eDP, slot 0 reads every PHY link and powers down once.
+ */
+static bool dcn401_add_boot_dig_read(struct dc *dc,
+		bool *out_edp_dig_enabled, bool *out_boot_dig_enabled,
+		struct block_sequence_state *sequence, unsigned int slot)
+{
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	unsigned int edp_num;
+	unsigned int i;
+
+	if (dc->config.seamless_boot_edp_requested)
+		return true;
+	dc_get_edp_links(dc, edp_links, &edp_num);
+	if (edp_num)
+		return slot >= edp_num || dcn401_add_dig_read(sequence,
+				edp_links[slot]->link_enc, out_edp_dig_enabled);
+	if (slot)
+		return true;
+	for (i = 0; i < dc->link_count; i++)
+		if (dcn401_dc1_is_phy_link(dc->links[i]) &&
+				!dcn401_add_dig_read(sequence,
+				dc->links[i]->link_enc,
+				&out_boot_dig_enabled[i]))
+			return false;
+	return true;
+}
+
+static bool dcn401_add_boot_power_down(struct dc *dc,
+		bool edp_dig_enabled, const bool *boot_dig_enabled,
+		struct block_sequence_state *sequence, unsigned int slot)
+{
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_link *link;
+	unsigned int edp_num;
+	unsigned int i;
+
+	if (dc->config.seamless_boot_edp_requested ||
+			!dc->hwseq->funcs.power_down)
+		return true;
+	dc_get_edp_links(dc, edp_links, &edp_num);
+	if (edp_num) {
+		if (slot >= edp_num || !edp_dig_enabled ||
+				!dc->hwss.edp_backlight_control ||
+				!dc->hwss.edp_power_control)
+			return true;
+		link = edp_links[slot];
+		return dcn401_add_edp_control(sequence, EDP_BACKLIGHT_CONTROL,
+				link, false) &&
+				dcn401_add_dc_call(sequence, HWSEQ_POWER_DOWN, dc,
+				false) &&
+				dcn401_add_edp_control(sequence, EDP_POWER_CONTROL,
+				link, false);
+	}
+	if (slot)
+		return true;
+	for (i = 0; i < dc->link_count; i++)
+		if (boot_dig_enabled[i])
+			return dcn401_add_dc_call(sequence, HWSEQ_POWER_DOWN, dc,
+					false);
+	return true;
+}
+
+/*
+ * dcn401_init_hw call order, cut at each read a later stage depends on.
+ * funcs append through dcn401_dc1_add_step: per pipe for the looped
+ * calls, and nothing where dcn401_init_hw skips the call. link_funcs
+ * follow step-major: each link_func expands for every link before the
+ * next link_func. The BLC trace logs only enc401_hw_init per link, and
+ * the panel, DDC and HDCP calls program separate blocks. In funcs,
+ * DIO_LINK_ENC_IS_DIG_ENABLED and HWSEQ_POWER_DOWN are the power down
+ * on boot read and act of the stage's eDP slot, and DMUB_SEND_DMCUB_CMD
+ * is the stage's DMUB command.
+ */
+struct dcn401_dc1_stage_list {
+	const enum block_sequence_func *funcs;
+	unsigned int num_funcs;
+	const enum block_sequence_func *link_funcs;
+	unsigned int num_link_funcs;
+};
+
+static const enum block_sequence_func dcn401_dc1_clocks_stage[] = {
+	LEGACY_CLK_MGR_INIT_CLOCKS,
+	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
+	DCCG_INITIALIZE_CLOCKS,
+	OPTC_SET_ODM_MEM_POWER,
+	MMHUBBUB_SET_MEM_POWER,
+	DCCG_GET_REF_FREQ,
+};
+
+static const enum block_sequence_func dcn401_dc1_dchub_ref_stage[] = {
+	HUBBUB_GET_DCHUB_REF_FREQ,
+};
+
+static const enum block_sequence_func dcn401_dc1_link_enc_loop[] = {
+	DIO_LINK_ENC_HW_INIT,
+	DIO_LINK_ENC_IS_DIG_ENABLED,
+	BIOS_GET_I2C_INFO,
+};
+
+static const enum block_sequence_func dcn401_dc1_fec_loop[] = {
+	DIO_LINK_ENC_FEC_IS_ACTIVE,
+};
+
+static const enum block_sequence_func dcn401_dc1_blank_stage[] = {
+	PG_SET_PLANE_POWER_GATING,
+	LINK_BLANK_ALL_DP_DISPLAYS,
+	BIOS_IS_ACCELERATED_MODE,
+};
+
+static const enum block_sequence_func dcn401_dc1_power_down_stage[] = {
+	HWSS_ENABLE_ACCELERATED_MODE,
+	HWSEQ_INIT_PIPES,
+	HUBBUB_ALLOW_SELF_REFRESH_CONTROL,
+	CLK_MGR_GET_DISPCLK_FROM_DENTIST,
+};
+
+static const enum block_sequence_func dcn401_dc1_min_clocks_stage[] = {
+	LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS,
+	DMUB_SET_IDLE_OPTIMIZATION,
+	DIO_LINK_ENC_IS_DIG_ENABLED,
+};
+
+static const enum block_sequence_func dcn401_dc1_power_down_edp0_stage[] = {
+	HWSEQ_POWER_DOWN,
+	DIO_LINK_ENC_IS_DIG_ENABLED,
+};
+
+static const enum block_sequence_func dcn401_dc1_power_down_edp1_stage[] = {
+	HWSEQ_POWER_DOWN,
+	AUDIO_HW_INIT,
+};
+
+static const enum block_sequence_func dcn401_dc1_panel_loop[] = {
+	PANEL_CNTL_HW_INIT,
+	GPIO_DDC_OPEN,
+	DMUB_SEND_DMCUB_CMD,
+};
+
+static const enum block_sequence_func dcn401_dc1_gating_stage[] = {
+	ABM_INIT,
+	DIO_AFMT_SET_MEM_POWER,
+	DCCG_SET_ROOT_CLOCK_GATING,
+	DCCG_SET_DCFCLK_GATING,
+	HPO_SET_HW_CONTROL,
+	BIOS_IS_ACCELERATED_MODE,
+};
+
+static const enum block_sequence_func dcn401_dc1_hubbub_stage[] = {
+	HUBBUB_INIT_WATERMARKS,
+	LEGACY_CLK_MGR_NOTIFY_WM_RANGES,
+	HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	HUBBUB_INIT_CRB,
+	HUBBUB_SET_REQUEST_LIMIT,
+	DMUB_SEND_DMCUB_CMD,
+};
+
+static const enum block_sequence_func dcn401_dc1_power_state_stage[] = {
+	DMUB_SEND_DMCUB_CMD,
+};
+
+#define DCN401_DC1_STAGE(list) { list, ARRAY_SIZE(list), NULL, 0 }
+#define DCN401_DC1_LINK_STAGE(loop) { NULL, 0, loop, ARRAY_SIZE(loop) }
+#define DCN401_DC1_LOOP_STAGE(list, loop) \
+	{ list, ARRAY_SIZE(list), loop, ARRAY_SIZE(loop) }
+
+static const struct dcn401_dc1_stage_list
+		dcn401_dc1_stages[LEGACY_INIT_STAGE_COUNT + 1] = {
+	[LEGACY_INIT_STAGE_CLOCKS] = DCN401_DC1_STAGE(dcn401_dc1_clocks_stage),
+	[LEGACY_INIT_STAGE_DCHUB_REF] =
+			DCN401_DC1_STAGE(dcn401_dc1_dchub_ref_stage),
+	[LEGACY_INIT_STAGE_LINK_ENC] =
+			DCN401_DC1_LINK_STAGE(dcn401_dc1_link_enc_loop),
+	[LEGACY_INIT_STAGE_FEC] = DCN401_DC1_LINK_STAGE(dcn401_dc1_fec_loop),
+	[LEGACY_INIT_STAGE_BLANK] = DCN401_DC1_STAGE(dcn401_dc1_blank_stage),
+	[LEGACY_INIT_STAGE_POWER_DOWN] =
+			DCN401_DC1_STAGE(dcn401_dc1_power_down_stage),
+	[LEGACY_INIT_STAGE_MIN_CLOCKS] =
+			DCN401_DC1_STAGE(dcn401_dc1_min_clocks_stage),
+	[LEGACY_INIT_STAGE_POWER_DOWN_EDP0] =
+			DCN401_DC1_STAGE(dcn401_dc1_power_down_edp0_stage),
+	[LEGACY_INIT_STAGE_POWER_DOWN_EDP1] =
+			DCN401_DC1_LOOP_STAGE(dcn401_dc1_power_down_edp1_stage,
+			dcn401_dc1_panel_loop),
+	[LEGACY_INIT_STAGE_GATING] = DCN401_DC1_STAGE(dcn401_dc1_gating_stage),
+	[LEGACY_INIT_STAGE_HUBBUB] = DCN401_DC1_STAGE(dcn401_dc1_hubbub_stage),
+	[LEGACY_INIT_STAGE_POWER_STATE] =
+			DCN401_DC1_STAGE(dcn401_dc1_power_state_stage),
+};
+
+static bool dcn401_dc1_add_link_step(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *in,
+		struct bls_builder_legacy_hw_init_info *out,
+		struct block_sequence_state *sequence,
+		enum block_sequence_func func, unsigned int i)
+{
+	const struct dc_link *link = dc->links[i];
+
+	switch (func) {
+	case DIO_LINK_ENC_HW_INIT:
+		return !dcn401_dc1_is_phy_link(link) ||
+				dcn401_add_link_enc_hw_init(sequence,
+				link->link_enc);
+	case DIO_LINK_ENC_IS_DIG_ENABLED:
+		return !dcn401_dc1_is_phy_link(link) ||
+				dcn401_add_dig_read(sequence, link->link_enc,
+				&out->s3.link_dig_enabled[i]);
+	case BIOS_GET_I2C_INFO:
+		return !link->force_to_use_aux ||
+				dcn401_add_i2c_info_read(sequence, dc, link,
+				&out->s3.link_i2c_info[i],
+				&out->s3.link_i2c_result[i]);
+	case DIO_LINK_ENC_FEC_IS_ACTIVE:
+		return !dcn401_dc1_is_phy_link(link) ||
+				!in->s3.link_dig_enabled[i] ||
+				!link->link_enc->funcs->fec_is_active ||
+				dcn401_add_fec_read(sequence, link->link_enc,
+				&out->s4.link_fec_active[i]);
+	case PANEL_CNTL_HW_INIT:
+		return !link->panel_cntl ||
+				dcn401_add_panel_cntl_hw_init(sequence,
+				link->panel_cntl, &out->s9.backlight,
+				&out->s9.user_level);
+	case GPIO_DDC_OPEN:
+		return !link->force_to_use_aux ||
+				in->s3.link_i2c_result[i] != BP_RESULT_OK ||
+				dcn401_add_ddc_open(sequence, link,
+				&in->s3.link_i2c_info[i]);
+	case DMUB_SEND_DMCUB_CMD:
+		/* Sent whatever the I2C info read returned. */
+		return !link->force_to_use_aux || !dcn401_dc1_has_dmub(dc) ||
+				dcn401_add_hdcp_interrupt_dest(sequence, dc, link,
+				&out->s9.dmub_ihc_cmd[i]);
+	default:
+		return false;
+	}
+}
+
+static bool dcn401_dc1_add_step(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *in,
+		struct bls_builder_legacy_hw_init_info *out,
+		struct block_sequence_state *sequence,
+		enum block_sequence_func func)
+{
+	struct resource_pool *pool = dc->res_pool;
+	struct clk_mgr *clk_mgr = dc->clk_mgr;
+	struct hubbub *hubbub = pool->hubbub;
+	bool has_init_clocks = clk_mgr && clk_mgr->funcs &&
+			clk_mgr->funcs->init_clocks;
+	unsigned int i;
+
+	switch (func) {
+	case LEGACY_CLK_MGR_INIT_CLOCKS:
+		return !has_init_clocks ||
+				dcn401_build_clk_mgr_init(clk_mgr, sequence) ==
+				BLS_BUILD_SUCCESS;
+	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
+		/* Without the callback the limits stay not present. */
+		return !has_init_clocks ||
+				!clk_mgr->funcs->is_dc_mode_present ||
+				dcn401_build_dc_mode_read(clk_mgr,
+				&out->s1.dcmode_power_limits_present,
+				sequence) == BLS_BUILD_SUCCESS;
+	case DCCG_INITIALIZE_CLOCKS:
+		return !pool->dccg->funcs->dccg_init ||
+				dcn401_build_dccg_init(pool->dccg, sequence) ==
+				BLS_BUILD_SUCCESS;
+	case OPTC_SET_ODM_MEM_POWER:
+		return !dc->debug.enable_mem_low_power.bits.optc ||
+				dcn401_add_hwseq_reg(sequence, func, dc->hwseq,
+				true);
+	case MMHUBBUB_SET_MEM_POWER:
+		return !dc->debug.enable_mem_low_power.bits.vga ||
+				dcn401_add_hwseq_reg(sequence, func, dc->hwseq,
+				true);
+	case DCCG_GET_REF_FREQ:
+		if (!dc->ctx->dc_bios->fw_info_valid) {
+			ASSERT_CRITICAL(false);
+			return true;
+		}
+		return dcn401_add_dccg_ref_freq(sequence, dc, &out->s1);
+	case HUBBUB_GET_DCHUB_REF_FREQ:
+		return !dc->ctx->dc_bios->fw_info_valid ||
+				dcn401_add_dchub_ref_freq(sequence, dc, &out->s2);
+	case PG_SET_PLANE_POWER_GATING:
+		return !dc->hwseq->funcs.enable_power_gating_plane ||
+				dcn401_add_hwseq_reg(sequence, func, dc->hwseq,
+				true);
+	case LINK_BLANK_ALL_DP_DISPLAYS:
+		return dcn401_add_dc_call(sequence, func, dc, false);
+	case BIOS_IS_ACCELERATED_MODE:
+		return dcn401_add_accelerated_mode_read(sequence, dc,
+				in->next_stage == LEGACY_INIT_STAGE_BLANK ?
+				&out->s5.accelerated_mode :
+				&out->s10.accelerated_mode);
+	case HWSS_ENABLE_ACCELERATED_MODE:
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				!dcn401_dc1_uses_accelerated_mode(dc) ||
+				dcn401_add_dc_call(sequence, func, dc, false);
+	case HWSEQ_INIT_PIPES:
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				dcn401_dc1_uses_accelerated_mode(dc) ||
+				dcn401_add_dc_call(sequence, func, dc, false);
+	case HUBBUB_ALLOW_SELF_REFRESH_CONTROL:
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				!hubbub->funcs->allow_self_refresh_control ||
+				dcn401_add_self_refresh_control(sequence, dc);
+	case CLK_MGR_GET_DISPCLK_FROM_DENTIST:
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				dc->debug.disable_boot_optimizations ||
+				!clk_mgr || !clk_mgr->funcs ||
+				!clk_mgr->funcs->get_dispclk_from_dentist ||
+				dcn401_add_dentist_read(sequence, clk_mgr,
+				&out->s6.dispclk_from_dentist_khz);
+	case LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS:
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				dcn401_add_min_clocks(sequence, dc, in);
+	case DMUB_SET_IDLE_OPTIMIZATION:
+		/*
+		 * Off, then on: in BOCO / BOMACO the hardware can be reset
+		 * while software still has idle optimizations allowed.
+		 */
+		return !dcn401_dc1_powers_down_pipes(dc, in) ||
+				(dcn401_add_dc_call(sequence, func, dc, false) &&
+				dcn401_add_dc_call(sequence, func, dc, true));
+	case DIO_LINK_ENC_IS_DIG_ENABLED:
+		if (in->next_stage == LEGACY_INIT_STAGE_MIN_CLOCKS)
+			return dcn401_add_boot_dig_read(dc,
+					&out->s7.edp_dig_enabled,
+					out->s7.boot_dig_enabled, sequence, 0);
+		return dcn401_add_boot_dig_read(dc, &out->s8.edp_dig_enabled,
+				NULL, sequence, 1);
+	case HWSEQ_POWER_DOWN:
+		if (in->next_stage == LEGACY_INIT_STAGE_POWER_DOWN_EDP0)
+			return dcn401_add_boot_power_down(dc,
+					in->s7.edp_dig_enabled,
+					in->s7.boot_dig_enabled, sequence, 0);
+		return dcn401_add_boot_power_down(dc, in->s8.edp_dig_enabled,
+				NULL, sequence, 1);
+	case AUDIO_HW_INIT:
+		for (i = 0; i < pool->audio_count; i++)
+			if (!dcn401_add_audio_hw_init(sequence, pool->audios[i]))
+				return false;
+		return true;
+	case ABM_INIT:
+		for (i = 0; i < pool->pipe_count; i++) {
+			struct abm *abm = pool->multiple_abms[i];
+
+			if (abm && abm->funcs &&
+					!dcn401_add_abm_init(sequence, abm, in))
+				return false;
+		}
+		return true;
+	case DIO_AFMT_SET_MEM_POWER:
+		return !pool->dio || !pool->dio->funcs->mem_pwr_ctrl ||
+				dcn401_add_dio_mem_power(sequence, pool->dio);
+	case DCCG_SET_ROOT_CLOCK_GATING:
+		return dc->debug.disable_clock_gate ||
+				!pool->dccg->funcs->allow_clock_gating ||
+				dcn401_add_root_clock_gating(sequence, pool->dccg);
+	case DCCG_SET_DCFCLK_GATING:
+		return dc->debug.disable_clock_gate ||
+				dcn401_add_hwseq_reg(sequence, func, dc->hwseq,
+				true);
+	case HPO_SET_HW_CONTROL:
+		return dcn401_add_hwseq_reg(sequence, func, dc->hwseq, true);
+	case HUBBUB_INIT_WATERMARKS:
+		return in->s10.accelerated_mode ||
+				!hubbub->funcs->init_watermarks ||
+				dcn401_add_init_watermarks(sequence, hubbub);
+	case LEGACY_CLK_MGR_NOTIFY_WM_RANGES:
+		return !clk_mgr || !clk_mgr->funcs ||
+				!clk_mgr->funcs->notify_wm_ranges ||
+				dcn401_add_notify_wm_ranges(sequence, clk_mgr);
+	case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL:
+		return !hubbub->funcs->force_pstate_change_control ||
+				dcn401_add_force_pstate(sequence, hubbub);
+	case HUBBUB_INIT_CRB:
+		return !hubbub->funcs->init_crb ||
+				dcn401_add_init_crb(sequence, hubbub);
+	case HUBBUB_SET_REQUEST_LIMIT:
+		return !hubbub->funcs->set_request_limit ||
+				dc->config.sdpif_request_limit_words_per_umc == 0 ||
+				dcn401_add_request_limit(sequence, dc);
+	case DMUB_SEND_DMCUB_CMD:
+		if (in->next_stage == LEGACY_INIT_STAGE_POWER_STATE)
+			return dcn401_add_notify_power_state(sequence, dc,
+					&out->s12.dmub_power_state_cmd);
+		return dcn401_add_query_caps(sequence, dc, &out->s11);
+	default:
+		return false;
+	}
+}
+
+static bool dcn401_dc1_add_stage(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *in,
+		struct bls_builder_legacy_hw_init_info *out,
+		struct block_sequence_state *sequence)
+{
+	const struct dcn401_dc1_stage_list *stage =
+			&dcn401_dc1_stages[in->next_stage];
+	unsigned int i, j;
+
+	for (i = 0; i < stage->num_funcs; i++)
+		if (!dcn401_dc1_add_step(dc, in, out, sequence,
+				stage->funcs[i]))
+			return false;
+	if (!stage->num_link_funcs)
+		return true;
+	for (j = 0; j < stage->num_link_funcs; j++)
+		for (i = 0; i < dc->link_count; i++)
+			if (!dcn401_dc1_add_link_step(dc, in, out, sequence,
+					stage->link_funcs[j], i))
+				return false;
+
+	return true;
+}
+
+/*
+ * Seed the stage output with the values its reads leave in place when
+ * they are skipped: the current reference clocks, the default
+ * backlight and no I2C info.
+ */
+static void dcn401_dc1_seed_stage_output(struct dc *dc,
+		struct bls_builder_legacy_hw_init_info *out, unsigned int stage)
+{
+	const struct resource_pool *pool = dc->res_pool;
+	unsigned int i;
+
+	switch (stage) {
+	case LEGACY_INIT_STAGE_CLOCKS:
+		memset(&out->s1, 0, sizeof(out->s1));
+		out->s1.xtalin_clock_inKhz = pool->ref_clocks.xtalin_clock_inKhz;
+		out->s1.dccg_ref_clock_inKhz =
+				pool->ref_clocks.dccg_ref_clock_inKhz;
+		break;
+	case LEGACY_INIT_STAGE_DCHUB_REF:
+		memset(&out->s2, 0, sizeof(out->s2));
+		out->s2.dchub_ref_clock_inKhz =
+				pool->ref_clocks.dchub_ref_clock_inKhz;
+		break;
+	case LEGACY_INIT_STAGE_LINK_ENC:
+		memset(&out->s3, 0, sizeof(out->s3));
+		for (i = 0; i < MAX_LINKS; i++)
+			out->s3.link_i2c_result[i] = BP_RESULT_NORECORD;
+		break;
+	case LEGACY_INIT_STAGE_FEC:
+		memset(&out->s4, 0, sizeof(out->s4));
+		break;
+	case LEGACY_INIT_STAGE_BLANK:
+		memset(&out->s5, 0, sizeof(out->s5));
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN:
+		memset(&out->s6, 0, sizeof(out->s6));
+		break;
+	case LEGACY_INIT_STAGE_MIN_CLOCKS:
+		memset(&out->s7, 0, sizeof(out->s7));
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN_EDP0:
+		memset(&out->s8, 0, sizeof(out->s8));
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN_EDP1:
+		memset(&out->s9, 0, sizeof(out->s9));
+		out->s9.backlight = MAX_BACKLIGHT_LEVEL;
+		out->s9.user_level = MAX_BACKLIGHT_LEVEL;
+		break;
+	case LEGACY_INIT_STAGE_GATING:
+		memset(&out->s10, 0, sizeof(out->s10));
+		break;
+	case LEGACY_INIT_STAGE_HUBBUB:
+		memset(&out->s11, 0, sizeof(out->s11));
+		break;
+	case LEGACY_INIT_STAGE_POWER_STATE:
+		memset(&out->s12, 0, sizeof(out->s12));
+		break;
+	}
+}
+
+enum bls_builder_result dcn401_build_dc1_initialization(
+		struct bls_builder_declarative_params *params)
+{
+	const struct bls_builder_legacy_hw_init_info *in;
+	struct bls_builder_legacy_hw_init_info *out;
+	struct block_sequence_state sequence;
+	enum bls_builder_result result;
+	struct dc *dc;
+
+	if (!params)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	params->head_num_steps = 0;
+	params->tail_num_steps = 0;
+	result = dcn401_validate_dc1_initialization(params);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	dc = params->dc;
+	in = &params->current_state->hw_init_info;
+	out = params->out_targets->DCN_DECL_INITIALIZATION_LEGACY;
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+
+	/* Virtual hardware only notifies DMUB of the power state. */
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW) {
+		dcn401_dc1_seed_stage_output(dc, out,
+				LEGACY_INIT_STAGE_POWER_STATE);
+		if (!dcn401_add_notify_power_state(&sequence, dc,
+				&out->s12.dmub_power_state_cmd))
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+		out->next_stage = LEGACY_INIT_STAGE_COUNT + 1;
+		out->init_done = true;
+		return BLS_BUILD_SUCCESS;
+	}
+
+	dcn401_dc1_seed_stage_output(dc, out, in->next_stage);
+	if (!dcn401_dc1_add_stage(dc, in, out, &sequence)) {
+		params->head_num_steps = 0;
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	}
+	out->next_stage = in->next_stage + 1;
+	out->init_done = in->next_stage == LEGACY_INIT_STAGE_COUNT;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+bool dcn401_dc1_initialization_check_capability(
+		const struct bls_builder_check_capability_params *params)
+{
+	return params && params->dc && params->dc->ctx &&
+			params->dc->res_pool;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h
new file mode 100644
index 000000000000..71a1cdb46527
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+
+/*
+ * DC2_DC1_Wrapped: build stage params->current_state->hw_init_info
+ * .next_stage of dcn401_init_hw into the head sequence. The stage
+ * outputs land in out_targets->DCN_DECL_INITIALIZATION_LEGACY.
+ */
+enum bls_builder_result dcn401_build_dc1_initialization(
+		struct bls_builder_declarative_params *params);
+bool dcn401_dc1_initialization_check_capability(
+		const struct bls_builder_check_capability_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
new file mode 100644
index 000000000000..1a51af6da94b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dmub_cmd.h"
+
+struct dmub_abi {
+	unsigned int fw_version;
+	struct dmub_feature_caps feature_caps;
+};
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
index a94c976f067c..69a376351df1 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -7,10 +7,34 @@
 #include "dc.h"
 #include "bls_builder/bls_builder.h"
 #include "bls_executor/bls_executor.h"
+#include "workaround_manager/workaround_manager.h"
 #include "core2/dc_core2_init.h"
+#include "core2/dc_core2_legacy_init.h"
 #include "dc_api_dispatch/api_shim.h"
 
-void core2_hardware_init(struct dc *dc)
+/*
+ * S-INT/link-seq: the eDP sink check legacy_hardware_init runs before
+ * init_hw. Remove when Link owns boot-time eDP detection.
+ */
+static void core2_detect_edp_presence(struct dc *dc)
+{
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	enum dc_connection_type type;
+	unsigned int i, edp_num;
+
+	dc_get_edp_links(dc, edp_links, &edp_num);
+	for (i = 0; i < edp_num; i++) {
+		if (dc->config.edp_not_connected) {
+			edp_links[i]->edp_sink_present = false;
+		} else {
+			edp_links[i]->edp_sink_present =
+					dc_link_detect_connection_type(edp_links[i],
+					&type) && type != dc_connection_none;
+		}
+	}
+}
+
+static void core2_run_native_hardware_init(struct dc *dc)
 {
 	struct bls_builder_declarative_params *params;
 	struct bls_builder_output_init *out_init;
@@ -18,9 +42,6 @@ void core2_hardware_init(struct dc *dc)
 	const struct bls_builder *builder;
 	enum bls_builder_result result;
 
-	if (!dc)
-		return;
-
 	builder = bls_builder_create(dc, DCN_DECL_INITIALIZATION);
 	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
 			!builder->build.declarative)
@@ -53,3 +74,16 @@ void core2_hardware_init(struct dc *dc)
 	kvfree(params);
 	kvfree(out_init);
 }
+
+/* CORE2 runs the DC2_DC1_Wrapped init until dcn401 init is native. */
+void core2_hardware_init(struct dc *dc)
+{
+	if (!dc)
+		return;
+
+	core2_detect_edp_presence(dc);
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		core2_run_legacy_hardware_init(dc, dc2_workaround_manager_get());
+	else
+		core2_run_native_hardware_init(dc);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
new file mode 100644
index 000000000000..285dfc9e6e69
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+#include "core_types.h"
+#include "clk_mgr.h"
+#include "dc_dmub_srv.h"
+#include "bls_builder/bls_builder.h"
+#include "bls_executor/bls_executor.h"
+#include "workaround_manager/workaround_manager.h"
+#include "core2/dc_core2_legacy_init.h"
+#include "dc_api_dispatch/api_shim.h"
+
+/*
+ * dcn401_init_hw marks a link active when its DIG is already enabled,
+ * and FEC enabled when it is also active. Applied after each stage that
+ * reads the DIG or FEC state, before any later stage runs.
+ */
+static void core2_apply_dc1_link_states(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *info)
+{
+	unsigned int i;
+
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (!info->s3.link_dig_enabled[i])
+			continue;
+		link->link_status.link_active = true;
+		link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+		if (info->s4.link_fec_active[i])
+			link->fec_state = dc_link_fec_enabled;
+	}
+}
+
+/*
+ * The HUBBUB stage resolved the DMUB feature caps. Take the query reply
+ * as dc_dmub_srv_query_caps_cmd does, retain dmub_abi for later builds,
+ * then apply the caps and the bounding-box update, all before the next
+ * stage runs.
+ */
+static void core2_apply_dmub_caps(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *info)
+{
+	const union dmub_rb_cmd *reply = &info->s11.dmub_query_feature_caps_cmd;
+	struct dmub_srv *dmub = dc->ctx->dmub_srv->dmub;
+	struct resource_pool *pool = dc->res_pool;
+	struct dc2 *dc2 = TO_DC2(dc);
+	const struct dmub_feature_caps *caps = &dc2->dmub_abi.feature_caps;
+	bool dchub_ref_freq_changed;
+
+	/*
+	 * S-INT/dmub-msg: the rest of DC reads feature_caps from dmub_srv.
+	 * Remove when those readers take dmub_abi.
+	 */
+	if (info->s11.dmub_caps_query_sent &&
+			reply->query_feature_caps.header.ret_status == 0)
+		memcpy(&dmub->feature_caps,
+				&reply->query_feature_caps.query_feature_caps_data,
+				sizeof(dmub->feature_caps));
+	memset(&dc2->dmub_abi, 0, sizeof(dc2->dmub_abi));
+	dc2->dmub_abi.feature_caps = dmub->feature_caps;
+	dc2->dmub_abi_resolved = true;
+
+	dc->caps.dmub_caps.psr = caps->psr;
+	dc->caps.dmub_caps.mclk_sw = caps->fw_assisted_mclk_switch_ver > 0;
+	dc->caps.dmub_caps.fams_ver = caps->fw_assisted_mclk_switch_ver;
+
+	/* sw and fw FAMS versions must match for support */
+	dc->debug.fams2_config.bits.enable &=
+			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
+	dchub_ref_freq_changed = pool->ref_clocks.dchub_ref_clock_inKhz / 1000 !=
+			info->s2.dchub_ref_clock_mhz_before;
+	if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
+			pool->funcs->update_bw_bounding_box &&
+			dc->clk_mgr && dc->clk_mgr->bw_params)
+		pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+}
+
+/*
+ * Move the output of the stage just executed into dc_state.hw_init_info,
+ * where the next build reads it, then apply what dcn401_init_hw left on
+ * dc by this point: the reference clocks, DC-mode limits, link state and
+ * DMUB caps.
+ */
+static void core2_retain_init_stage(struct dc *dc,
+		const struct bls_builder_legacy_hw_init_info *out)
+{
+	struct bls_builder_legacy_hw_init_info *info =
+			&dc->current_state->hw_init_info;
+	struct resource_pool *pool = dc->res_pool;
+
+	switch (out->next_stage - 1) {
+	case LEGACY_INIT_STAGE_CLOCKS:
+		info->s1 = out->s1;
+		pool->ref_clocks.xtalin_clock_inKhz = info->s1.xtalin_clock_inKhz;
+		pool->ref_clocks.dccg_ref_clock_inKhz =
+				info->s1.dccg_ref_clock_inKhz;
+		if (dc->clk_mgr && dc->clk_mgr->funcs &&
+				dc->clk_mgr->funcs->init_clocks)
+			dc->caps.dcmode_power_limits_present =
+					info->s1.dcmode_power_limits_present;
+		break;
+	case LEGACY_INIT_STAGE_DCHUB_REF:
+		info->s2 = out->s2;
+		pool->ref_clocks.dchub_ref_clock_inKhz =
+				info->s2.dchub_ref_clock_inKhz;
+		break;
+	case LEGACY_INIT_STAGE_LINK_ENC:
+		info->s3 = out->s3;
+		core2_apply_dc1_link_states(dc, info);
+		break;
+	case LEGACY_INIT_STAGE_FEC:
+		info->s4 = out->s4;
+		core2_apply_dc1_link_states(dc, info);
+		break;
+	case LEGACY_INIT_STAGE_BLANK:
+		info->s5 = out->s5;
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN:
+		info->s6 = out->s6;
+		break;
+	case LEGACY_INIT_STAGE_MIN_CLOCKS:
+		info->s7 = out->s7;
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN_EDP0:
+		info->s8 = out->s8;
+		break;
+	case LEGACY_INIT_STAGE_POWER_DOWN_EDP1:
+		info->s9 = out->s9;
+		break;
+	case LEGACY_INIT_STAGE_GATING:
+		info->s10 = out->s10;
+		break;
+	case LEGACY_INIT_STAGE_HUBBUB:
+		info->s11 = out->s11;
+		if (info->s11.dmub_caps_read)
+			core2_apply_dmub_caps(dc, info);
+		break;
+	case LEGACY_INIT_STAGE_POWER_STATE:
+		info->s12 = out->s12;
+		break;
+	}
+	info->next_stage = out->next_stage;
+	info->init_done = out->init_done;
+}
+
+/*
+ * Build, workaround, execute. Execute only a successful build and a
+ * workaround pass that kept the stage within the sequence storage, and
+ * do not fall back to legacy hwseq.
+ */
+static bool core2_run_init_stage(struct dc *dc,
+		const struct bls_builder *builder,
+		const struct workaround_manager *wam,
+		struct bls_builder_declarative_params *params)
+{
+	struct workaround_context wa_ctx = {0};
+	struct block_sequence_state sequence;
+	enum dc2_bls_exec_result result;
+
+	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS)
+		return false;
+
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+	wa_ctx.current_state = dc->current_state;
+	wa_ctx.builder_name = builder->name;
+	wa_ctx.dcn_version = dc->ctx->dce_version;
+	wa_ctx.bug_wa = &dc->work_arounds;
+	wa_ctx.debug = &dc->debug;
+	if (workaround_manager_apply(wam, &sequence, &wa_ctx) != WAM_OK ||
+			params->head_num_steps > DC2_BLS_MAX_STEPS)
+		return false;
+
+	/* dcn401_init_hw ignores the DMUB sends that continue on error. */
+	result = dc2_bls_execute(TO_DC2(dc), params->head_sequence,
+			params->head_num_steps);
+	return result == DC2_BLS_EXEC_OK ||
+			result == DC2_BLS_EXEC_CONTINUED_ON_ERROR;
+}
+
+bool core2_run_legacy_hardware_init(struct dc *dc,
+		const struct workaround_manager *wam)
+{
+	struct bls_builder_declarative_params *params;
+	struct bls_builder_legacy_hw_init_info *out;
+	struct bls_builder_legacy_hw_init_info *info;
+	struct bls_builder_output_targets out_targets = {0};
+	const struct bls_builder *builder;
+	unsigned int stage;
+
+	if (!dc || !dc->current_state || !wam)
+		return false;
+
+	info = &dc->current_state->hw_init_info;
+	memset(info, 0, sizeof(*info));
+	info->next_stage = LEGACY_INIT_STAGE_CLOCKS;
+	builder = bls_builder_create(dc, DCN_DECL_INITIALIZATION_LEGACY);
+	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
+			!builder->build.declarative)
+		return false;
+	TO_DC2(dc)->dmub_abi_resolved = false;
+
+	/*
+	 * The declarative params hold 128 block-sequence entries, and the
+	 * stage outputs hold DMUB command buffers. Keep both off the stack
+	 * so the kernel frame stays under the 2048-byte limit.
+	 */
+	params = kvzalloc(sizeof(*params), GFP_KERNEL);
+	out = kvzalloc(sizeof(*out), GFP_KERNEL);
+	if (!params || !out)
+		goto out;
+
+	params->dc = dc;
+	params->current_state = dc->current_state;
+	out_targets.DCN_DECL_INITIALIZATION_LEGACY = out;
+	params->out_targets = &out_targets;
+	/* The builder reports init_done no later than its last stage. */
+	for (stage = 0; stage < LEGACY_INIT_STAGE_COUNT && !info->init_done;
+			stage++) {
+		if (!core2_run_init_stage(dc, builder, wam, params))
+			break;
+		core2_retain_init_stage(dc, out);
+	}
+	info->init_success = info->init_done;
+
+out:
+	info->init_done = true;
+	kvfree(params);
+	kvfree(out);
+	return info->init_success;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h
new file mode 100644
index 000000000000..d0cd7a5cb2c6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+struct dc;
+struct workaround_manager;
+
+/*
+ * DC2_DC1_Wrapped hardware init: dcn401_init_hw as twelve staged BLS
+ * builds, each passed through wam. A migration shim; it and
+ * dcn401_init_builder_legacy.c are removed together.
+ */
+bool core2_run_legacy_hardware_init(struct dc *dc,
+		const struct workaround_manager *wam);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
index fee03a5dd596..b972ae06663d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -7,11 +7,15 @@
 
 #include "dc.h"
 #include "inc/dc_core_interface.h"
+#include "bls_builder/dmub_abi.h"
 
 struct dc2 {
 	/* First member: TO_DC2 is a typed upcast, not container_of. */
 	struct dc dc;
 	enum dc2_selection selection;
+	/* Resolved by hardware init; later builds take it as dmub_abi. */
+	struct dmub_abi dmub_abi;
+	bool dmub_abi_resolved;
 };
 
 #define TO_DC2(ptr) ((struct dc2 *)(ptr))
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 6563eaaa0c0c..695eaa5cbf65 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -40,6 +40,7 @@
 #include "mcif_wb.h"
 #include "panel_cntl.h"
 #include "dmub/inc/dmub_cmd.h"
+#include "bls_builder/bls_builder_legacy_init.h"
 #include "pg_cntl.h"
 #include "sspl/dc_spl.h"
 
@@ -722,6 +723,12 @@ struct dc_state {
 	} perf_params;
 
 	enum dc_power_source_type power_source;
+
+	/**
+	 * @hw_init_info: DC2_DC1_Wrapped hardware init progress and the
+	 * outputs of each stage run so far
+	 */
+	struct bls_builder_legacy_hw_init_info hw_init_info;
 };
 
 struct replay_context {
-- 
2.43.0

