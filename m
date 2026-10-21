Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0C606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WQfsIOoU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C5F10EC3D;
	Wed, 21 Oct 2026 06:25:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA33010EC3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJq5TaXgTA4FeOub4D/29K5DLyoumarESQmHTmWgkjlILkz/Z+IFeYT9r4LiUEw+u6kaqX0o3BRN45GJtjfKssdhk+n8SI1G/qp/M5HeIjfchBCLZ1udVJC2VVFm1RQP5FqvDw49aeFukR1RBnGINFwsqPvVmQDKsl52uXDhv9+wQ+Jv96KZCegKAbsOZsIWZUPnYs56gscwikiGgaU6F0AbrhkHye9aOqBXzLlAEmOsh7Rf6aaVIfK2tAkEf5O2zEjBUjdHFbnpvXI0HoP1gfJL2D7phnnfnxuZWsP7RtzjNwciqz/rZV1LQsoY9h/zHk6A+wLTS6CpCaK0sybmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN0bmrzfsrztBFKNkcfTGlGETdFLXRPF72wf437AUfA=;
 b=eHb03VcynTPt9pRB7B3qx+Xb9+zxlM3gZnLgekyZtTgBcLhthryuNPSWbPQOXK7Ta/aRNwFDuXg06WzcMwUIFootyP9hV45adOTwq0zhfIQurFqpn/dr+MDwhIhLDvYAd3zlFG/hprNs9KZ0bw5OAEQrB5G7ucW2wnPhmEqEftdhooCAgET1N/PILs1GRMeAiZx9VSOIzcZkcr8HShbwVqwN1rGa/5898YZmhVHmrdHIDvGa+bspz/7fLs+f8WxX+hTgaC4uXyy0djeXtbe7je7ddQEXxDLP2zFZaaRLkM6hL5ekpSBAZ0DMVyA9rzzdfbV+5/ku2vu9cI37eiF+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN0bmrzfsrztBFKNkcfTGlGETdFLXRPF72wf437AUfA=;
 b=WQfsIOoU5/sMoPg5IsuAXUtr7/kzmi0YdVsDPqZYQPE/dxIHegoOTZxvhUXNMW67w6Bw4U0I/fineSxbwv/2+oCeRTiKb4c2V3cR1vbqJyL/v/fxEEPN4vFxuUz9RA04iJkuy1GV4Qz+tGaDFk7kNlghgFexpcK1Gitz3kt2lN8=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 06:25:24 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::58) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:23 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:19 -0500
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
Subject: [PATCH 01/49] drm/amd/display: Add Core 2 initialization BLS
 scaffolding
Date: Wed, 21 Oct 2026 14:22:07 +0800
Message-ID: <20261021062519.674697-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: b6706a24-f6c0-4c9c-889a-08df2f3c16f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009221227099003|261009223027099003|22082099003|18002099003|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 6KhWPiUw5Qefz9KvSuG8KiAqxSihuVRpclOeXcQjFUA4GCyXZlotaZR25Sbjew2C03AbFrwk0COvRz7tCl9jqx5i77LNwHpOIAZ+GydoAmkzRUJs554dQFjMLxj/n2QjVGhSb/3x/lfLxx+LIgBHqT17s7Q1xotyvW0Z/aFJJNSMyANy1B8PNiMk1RREpebOG6eVsqxHSCUF8PqV3krimezou3PWc8LduFz2UZSsT6lEMDmBRBEUxCs6ISFDoT3x93fC+vLW1hmreZNHcEAxWgyf4uJtHISlz+zN9dcfqNbVPK5XgQGGyOArQpzU8JwTvIRapbYyLbgrlEUHnhoAZMSWrHzeMDXchqAmW9jHttKSYf6g799kcuo9lQJfcdf6w1fI9WNdNod4PJfJ5XkJVzi4iuyWia0XNVtWos88fWputle7N/R3GufzhBEblnpo9pOiZ0kSnnZhEgXJ5F0xXfTUwzOMUp9Mt58Haz9T4n3xT8sheaLU7y+reIu7W05nbwtbkSg6BAWkIDsj7FMMTWgcDeZU7UGOuVYDiOH/hoZ2bo1RIfqoLhze+DX2aZRdVwdMo4orqYfg33kgwz9tBkP5lK8/OPmWm1amT05DD2a6rLMy3xNQftqs0IjJF8ahpACJFr30N0AvhV63a5w32e1+w2V4+EYDhQn3TRLudFio8vWHNWZgD0fFdcGLBHp/rKgMUY+h4v9Hpwqc7DymyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(10067099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0TpAFkmqyTyk5Hfi8KYTNa6nOM5WFszDgsV6F3B4M4V4r2YyAI2nEpmhDqBVU3dKlLlYO/1sIl76QvshQ/nPhcj+Bk/E7Xahjt2dyj6tZvFEhLFSKna5YllFnXfdJVrcpxS3ZBoR+95xrWG4mMrKgmJA7+/Dd9XnACb+RrZrishHBFO1M2Q7QhUSgygP+Ci2lHmodsNK26zjIFD8dVMs9ODO5iG2i5+ThOC0BtM2W/8Ec3lCaqRtNeyZ0gcBv2IkMvIvqKJqFPqej2AljsI5FSkYnYl+uuHj/PiboAJW4vHgPuZ6rxal53FCK7ukxdCwG9kazAR5dl5XjgIpCYQkuVTH8tmaJQ1S4ZJodxZVKBDpDSxYFuc880PcIIRS2Il4yKjQjW9ElQFExEUTJ8afQIZFU/thILCKtbMOOEk+G5ymD1SV5IBtvu0uUbqlVB0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:23.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6706a24-f6c0-4c9c-889a-08df2f3c16f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

why:
Core2 initialization cannot safely cut over until the architected DMUB
halt, PSP reload, DMUB Initialize-DCN, ABI resolution, and symmetric
teardown contracts exist. The remaining operations do not yet have DAL
component contracts, so this parent must not cut the selectable
lifecycle path over.

how:
Keep the existing legacy lifecycle behavior and introduce fail-closed
Builder/Executor scaffolding over struct block_sequence as peer
directories. Encapsulate dispatch behind bls_builder_create and a
per-ASIC vtable, emit one explicit DCCG_INITIALIZE_CLOCKS BLC
operation, and reject incomplete initialization and missing dispatch
targets.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   3 +
 .../amd/display/dc/bls_builder/bls_builder.c  |  21 ++++
 .../amd/display/dc/bls_builder/bls_builder.h  |  84 ++++++++++++++
 .../dc/bls_builder/bls_builder_internal.h     |  11 ++
 .../dc/bls_builder/dcn401_init_builder.c      | 107 ++++++++++++++++++
 .../display/dc/bls_executor/bls_executor.c    |  52 +++++++++
 .../display/dc/bls_executor/bls_executor.h    |  17 +++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +
 8 files changed, 301 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 1cbf284bb2fd..e64a098e04e3 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -84,6 +84,9 @@ FILES += core/dc_surface.o
 FILES += core/dc_vm_helper.o
 FILES += core2/dc_core2.o
 FILES += core2/dc_core2_init.o
+FILES += bls_builder/bls_builder.o
+FILES += bls_builder/dcn401_init_builder.o
+FILES += bls_executor/bls_executor.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
new file mode 100644
index 000000000000..8ac202487189
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "bls_builder/bls_builder_internal.h"
+
+const struct bls_builder *bls_builder_create(struct dc *dc,
+		enum bls_builder_name name)
+{
+	if (!dc || !dc->ctx)
+		return NULL;
+
+	switch (dc->ctx->dce_version) {
+	case DCN_VERSION_4_01:
+		return dcn401_bls_builder_create(name);
+	default:
+		return NULL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
new file mode 100644
index 000000000000..61952f8b95b6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dc.h"
+#include "hwss/hw_sequencer.h"
+
+#define DC2_BLS_MAX_STEPS 64
+
+enum bls_builder_result {
+	BLS_BUILD_SUCCESS,
+	BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE,
+	BLS_BUILD_ERROR_RESOURCE_MAPPING,
+	BLS_BUILD_ERROR_DMUB_ABI_UNRESOLVED,
+};
+
+enum bls_builder_name {
+	DCN_DECL_INITIALIZATION,
+	BLS_BUILDER_NAME_COUNT,
+};
+
+enum bls_builder_kind {
+	BLS_BUILDER_DECLARATIVE,
+	BLS_BUILDER_IMPERATIVE,
+};
+
+struct dmub_abi {
+	unsigned int fw_version;
+	unsigned int feature_caps;
+};
+
+struct bls_builder_output_init {
+	unsigned int xtalin_clock_inKhz;
+	unsigned int dccg_ref_clock_inKhz;
+	unsigned int dchub_ref_clock_inKhz;
+	unsigned int dchub_ref_clock_inKhz_before;
+	unsigned int backlight;
+	struct dmub_abi dmub_abi;
+};
+
+struct bls_builder_output_targets {
+	union {
+		struct bls_builder_output_init *DCN_DECL_INITIALIZATION;
+	};
+};
+
+struct bls_builder_check_capability_params {
+	struct dc *dc;
+	const struct dc_state *current_state;
+	const struct dc_state *new_state;
+};
+
+struct bls_builder_declarative_params {
+	struct dc *dc;
+	const struct dc_state *current_state;
+	const struct dc_state *new_state;
+	const struct dmub_abi *dmub_abi;
+	struct bls_builder_output_targets *out_targets;
+	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
+	unsigned int head_num_steps;
+	struct block_sequence tail_sequence[DC2_BLS_MAX_STEPS];
+	unsigned int tail_num_steps;
+};
+
+typedef bool (*bls_builder_check_capability)(
+		const struct bls_builder_check_capability_params *params);
+
+typedef enum bls_builder_result (*bls_builder_build_declarative)(
+		struct bls_builder_declarative_params *params);
+
+struct bls_builder {
+	enum bls_builder_name name;
+	enum bls_builder_kind kind;
+	bls_builder_check_capability check_capability;
+	union {
+		bls_builder_build_declarative declarative;
+	} build;
+};
+
+const struct bls_builder *bls_builder_create(struct dc *dc,
+		enum bls_builder_name name);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
new file mode 100644
index 000000000000..216879c93f9e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+
+const struct bls_builder *dcn401_bls_builder_create(
+		enum bls_builder_name name);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
new file mode 100644
index 000000000000..42a648b8c065
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "resource.h"
+#include "bls_builder/bls_builder_internal.h"
+
+static bool bls_append(struct block_sequence_state *sequence,
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
+static enum bls_builder_result dcn401_check_initialization_support(
+		const struct bls_builder_check_capability_params *params)
+{
+	struct dc *dc;
+
+	if (!params || !params->dc)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	dc = params->dc;
+	if (!dc->ctx || !dc->res_pool || !dc->res_pool->dccg)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	if (dc->config.seamless_boot_edp_requested)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool dcn401_initialization_check_capability(
+		const struct bls_builder_check_capability_params *params)
+{
+	return dcn401_check_initialization_support(params) ==
+			BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_build_initialization(
+		struct bls_builder_declarative_params *params)
+{
+	struct bls_builder_check_capability_params check_params = {0};
+	enum bls_builder_result support_result;
+	struct block_sequence_state sequence;
+	union block_sequence_params bls_params = {0};
+	struct dc *dc;
+
+	if (!params)
+		return dcn401_check_initialization_support(NULL);
+
+	check_params.dc = params->dc;
+	check_params.current_state = params->current_state;
+	check_params.new_state = params->new_state;
+	support_result =
+			dcn401_check_initialization_support(&check_params);
+	if (support_result != BLS_BUILD_SUCCESS)
+		return support_result;
+
+	dc = params->dc;
+	params->head_num_steps = 0;
+	params->tail_num_steps = 0;
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+
+	/*
+	 * Add only operations with explicit component dispatch today. Core will
+	 * not execute or commit ownership until the fixed four-entry DCN
+	 * initialization sequence is available.
+	 */
+	bls_params.dccg_initialize_clocks_params.dccg =
+			dc->res_pool->dccg;
+	if (!bls_append(&sequence, DCCG_INITIALIZE_CLOCKS,
+			&bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+}
+
+const struct bls_builder *dcn401_bls_builder_create(
+		enum bls_builder_name name)
+{
+	static const struct bls_builder initialization_builder = {
+		.name = DCN_DECL_INITIALIZATION,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_initialization_check_capability,
+		.build.declarative = dcn401_build_initialization,
+	};
+
+	if (name != DCN_DECL_INITIALIZATION)
+		return NULL;
+
+	return &initialization_builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
new file mode 100644
index 000000000000..d1bb951e47ae
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ */
+
+#include "dm_services.h"
+#include "dccg.h"
+#include "bls_executor/bls_executor.h"
+
+static bool dc2_bls_step_supported(const struct block_sequence *step)
+{
+	struct dccg *dccg;
+
+	switch (step->func) {
+	case DCCG_INITIALIZE_CLOCKS:
+		dccg = step->params.dccg_initialize_clocks_params.dccg;
+		return dccg && dccg->funcs && dccg->funcs->dccg_init;
+	default:
+		return false;
+	}
+}
+
+enum dc2_bls_exec_result dc2_bls_execute(
+		const struct block_sequence *steps,
+		unsigned int num_steps)
+{
+	const struct block_sequence *entry;
+	unsigned int i;
+
+	if (!steps || num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return DC2_BLS_EXEC_ERROR;
+
+	for (i = 0; i < num_steps; i++)
+		if (!dc2_bls_step_supported(&steps[i]))
+			return DC2_BLS_EXEC_ERROR;
+
+	for (i = 0; i < num_steps; i++) {
+		entry = &steps[i];
+		switch (entry->func) {
+		case DCCG_INITIALIZE_CLOCKS:
+			entry->params.dccg_initialize_clocks_params.dccg->funcs->dccg_init(
+					entry->params.dccg_initialize_clocks_params.dccg);
+			break;
+		default:
+			ASSERT(false);
+			return DC2_BLS_EXEC_ERROR;
+		}
+	}
+
+	return DC2_BLS_EXEC_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
new file mode 100644
index 000000000000..6f45b37a3b87
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+
+enum dc2_bls_exec_result {
+	DC2_BLS_EXEC_OK,
+	DC2_BLS_EXEC_ERROR,
+};
+
+enum dc2_bls_exec_result dc2_bls_execute(
+		const struct block_sequence *steps,
+		unsigned int num_steps);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 8f4ed80385fc..48ccbc3b1240 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1003,6 +1003,10 @@ struct clk_mgr_update_clocks_params {
 	struct clk_mgr *clk_mgr;
 };
 
+struct dccg_initialize_clocks_params {
+	struct dccg *dccg;
+};
+
 struct hubbub_program_watermarks_params {
 	struct dc *dc;
 	struct hubbub *hubbub;
@@ -1198,6 +1202,7 @@ union block_sequence_params {
 	struct link_set_dpms_on_params link_set_dpms_on_params;
 	struct clk_mgr_set_max_memclk_params clk_mgr_set_max_memclk_params;
 	struct clk_mgr_update_clocks_params clk_mgr_update_clocks_params;
+	struct dccg_initialize_clocks_params dccg_initialize_clocks_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
@@ -1368,6 +1373,7 @@ enum block_sequence_func {
 	HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT,
 	HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE,
 	HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY,
+	DCCG_INITIALIZE_CLOCKS,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

