Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BE606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MdkFblf9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F32F10F8E5;
	Wed, 11 Nov 2026 01:44:05 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF1310F8E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9wQsZFM4sl92og0TOwDAdd1FHx38SD1ADHXNyb8UbEMjc+fSSiw9JnYPKR9TnLZer+yChCiIvBByliLCu28j708jahPjmVYTjWM7veWKGRRjZrh+qUYPWTEJPtMNaGulchrf56iwNQFQuSLPyBi+mOCdJLu92rxVWQfwxt/n8dqN/F0g3K0O5GxDUFs/OlTGhyhaxqlmJVvtWSYkV9UZ3nabzwdCipR7nz00mjiUi0XazaaLQqRxE1y+3JD2RXzMCVWiIt0bTD/jlz/OmZ3lDEVjep31A14nhhvincmdvW3uLMOVPlohbIA+q2uvpy/XvtOUuLmXcyO2L2TeBrIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ru961AfTb1udb8nl8WJ1kkoF26OPhQPyAYFqi98guY=;
 b=viYj6cqDXTBbEZreo/mY3cP3NeMAZmsFNY6C0/MF7HYi6KNpi5w85uniejUqZvUJ7Jksk85jZdeuegHmYmkT1vo/3p5Yc9S0YRQp+6Bs0StS5/wpX76ziEmSmgzrgzlO7NpHLu2z3Ek/lCGuXwIYiwXo+j3bgHsZHGL91PDx3jPmGYR2xtnuYP2DZlMsXQ9ryRzuY4ZhxNaCnZ/OlMpsruMuupLbG3GcYLy3xr9O1FlHqaXQzknQ+O45hZDZoFpqabb6iAdW4pcoJJlTjsa4dKItBaWxGaWps7HnyIXGhu0VadFmcOps7a77oAGodOO0v09EIgsrxV/82k1G+mLV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ru961AfTb1udb8nl8WJ1kkoF26OPhQPyAYFqi98guY=;
 b=MdkFblf9l2CbYdSO74TwcUabj0FrhdWrNbzRQfyVOYnqlor1LAW+3HlBZcz/F35oqLfxZMxvDJDWDFIqnrlVqqeTNjkRZWwHwMg31frt2iKiivSUphugUDSsIpoEYmjBUS/cqknZjnFsln9JviMsPA9kPiIs0hA542F6Z8Y1FYI=
Received: from CY8PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:44::28)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 01:43:51 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::91) by CY8PR19CA0019.outlook.office365.com
 (2603:10b6:930:44::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 01:43:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:49 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:46 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 53/74] drm/amd/display: Add DC2 state facts and split the
 builders
Date: Wed, 11 Nov 2026 09:28:59 +0800
Message-ID: <20261111014100.3596072-54-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0c6f5d-519f-4eaf-bd68-08df3f953cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261021121427099003|261026121527099003|261022075727099003|261021123027099003|261022105027099003|261009221227099003|261009223027099003|261028144727099003|10067099003|261026140227099003|11063799006|5023799004|22082099003|6133799003|18002099003|56012099006|261102123227099003|3023799007;
X-Microsoft-Antispam-Message-Info: AoiyZW1mt9/poeEuTJVtWAqQ/gp4VH7GToVRPjBwSCFNW1A3/XVdlMX12LhaOiYn3oSMfSAY6itJRtgpHGSVXIRCw8Zd4yy4Gbp9JW1fEywEgcX+FTaF8MWqAOoP21H0I+yt2eqnWk6lsHp7Ix60N3//8jh5OKdv16fi5+c6yCM4qni+mKnmGNKA4G/+Af0iY1+gQN+i3oiP7BUYva+rif2yIMSnEaiVWHq44+7QFVI05bkJH7we9szaMNg0BKJod8K3ObhciOnPidk22I7NiugqSxKYUVng0t+CuCZvzdW3gMyJFdlZtzJJQCg68iNe9gP1AzOQsizRKx2rzYHKo6bpo9xIYLNwq43ZvkFkVC2T8RPq1//TneI7oh4jDot+dMp3SkqcZG//mMbwAk+UMEmwgUdzAQU5cg3CVkEKgygvbQKY7lYMOkgZ4Pu621+r5IHO72kWyKvvNs7kh5GKQ69PfgDyVR3FdoakL+BngT+3ggRmY5L2SvNnjbx8y2C1w5XnFRslHqThyAcjHbmXM1UKFoZ2h3dRZLNco4ZZTV8rXPnLEBeAgJlqoJRMA3eP8Wk1YTuuu/khzfSFLYmhAfZskYCmXRnWK8VarTn4/PwUUPpvQXiYrEqMx971h6jJxBSEPVwHg7fhzyc8oaWhoF2Siiwc7Ku9Yx6mlkP7PphvqSu7sHbqfue3yHAO1Mzfk+J5oh7gFTMqNTHM7pq18g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009223027099003)(261028144727099003)(10067099003)(261026140227099003)(11063799006)(5023799004)(22082099003)(6133799003)(18002099003)(56012099006)(261102123227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: up3e0Svts/0JY9kVl5+5HfoceqeiXd4xEMioXYLbzj4uLlrxic2FJqBFKbCHzOu9Mx6MJsFk6fLJ9J/FrXh/oFdZlwLxM4Y8VZC7uV9iSmXvGXGB0BEP2sgXkgGs31NtZaXvjP06bvtsyse9BSgfizihTQ/j615uBu3MUG1TokytSZnwZylnpJBaLEB6AFPl8xqm/mqkQmiW21/vh7+mwBpPz/s3so2fPQelZSsB32USJuo9eMaJdF/dlO7SJHwIc4dt0aTsSqr4L64CLFWBT5s4DFwwGImxfXdgdwBO4wE0pok3hcby3z9U/q1AVcrgVDxf54RxILClMcyAYP8nIWprgerJnwnMgpRbwtNoePFo3qBIfnB7p8aP6oMvyPxmFaXpBftbH/NkOdJagbhrkIyZg6oWmsO4kHfmtyVjsQUSMvBZWBo1rInUMx97/6un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:50.9163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0c6f5d-519f-4eaf-bd68-08df3f953cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
Each DCN4 DC2 builder has its own helpers that read the stream, pipe
and plane state. The same checks are in several files with different
names. The two builders also share one file.

[How]
Add a state facts component that reads a state once into trait masks.
Make the builders ask their questions of these masks. Give each trait
a name that tells what the object has. Remove the traits that are the
inverse of other traits. Remove the HUBP, DPP and MPCC instance check,
because the resource pool assigns these blocks together. Remove the
DPP pregam check, because DCN4 has no pregam.

Put the seamless and non-seamless builders in their own files. Each
file has its own step tables. A shared header has only the support
checks and the step helpers.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   4 +-
 .../dc/bls_builder/dcn401_builder_internal.h  | 107 +++
 .../bls_builder/dcn401_non_seamless_builder.c | 447 +++++++++
 ...it_builder.c => dcn401_seamless_builder.c} | 883 ++++--------------
 .../amd/display/dc/state_facts/state_facts.c  | 294 ++++++
 .../amd/display/dc/state_facts/state_facts.h  | 132 +++
 6 files changed, 1162 insertions(+), 705 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
 rename drivers/gpu/drm/amd/display/dc/bls_builder/{dcn401_commit_builder.c => dcn401_seamless_builder.c} (72%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index ec3ef6ed6ed4..a7dd6a7ba492 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -86,9 +86,11 @@ FILES += core2/dc_core2.o
 FILES += core2/dc_core2_init.o
 FILES += core2/dc_core2_legacy_init.o
 FILES += bls_builder/bls_builder.o
-FILES += bls_builder/dcn401_commit_builder.o
+FILES += bls_builder/dcn401_seamless_builder.o
 FILES += bls_builder/dcn401_init_builder.o
 FILES += bls_builder/dcn401_init_builder_legacy.o
+FILES += bls_builder/dcn401_non_seamless_builder.o
+FILES += state_facts/state_facts.o
 FILES += bls_executor/bls_executor.o
 FILES += workaround_manager/workaround_manager.o
 FILES += dmub_messenger/dmub_messenger.o
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
new file mode 100644
index 000000000000..cc531a7eadf7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+#include "bls_builder/bls_builder_private_types.h"
+
+/*
+ * Shared by the dcn401 non-seamless commit and seamless update builders:
+ * the support checks both make, and the step walkers that turn a step
+ * table into BLS entries.
+ */
+
+/* The support check allows the OTG master and one MPC bottom pipe. */
+#define DCN401_MAX_DPP_PIPES 2
+
+void dcn401_commit_check_failed(const struct dc *dc, const char *msg);
+
+/*
+ * Each check_<name> helper takes the same arguments. CHECK_CONDITION logs
+ * the reason and returns. current_state or new_state is NULL when the
+ * helper looks at only one of them.
+ */
+#define CHECK_CONDITION(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
+		} \
+	} while (0)
+
+#define CHECK_RESOURCE(name, msg) \
+	do { \
+		if (!check_##name(dc, current_state, new_state)) { \
+			dcn401_commit_check_failed(dc, msg); \
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING; \
+		} \
+	} while (0)
+
+static inline const struct dc_state *dcn401_checked_state(
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	return current_state ? current_state : new_state;
+}
+
+/* The OTG master of state's one stream, or NULL when it is not one pipe. */
+const struct pipe_ctx *dcn401_otg_of(const struct dc *dc,
+		const struct dc_state *state);
+const struct pipe_ctx *dcn401_checked_otg_master(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state);
+
+/* Each DPP pipe under the OTG master of state, top pipe first. */
+#define DCN401_FOR_EACH_DPP_PIPE(dc, state, pipe) \
+	for ((pipe) = dcn401_otg_of(dc, state); (pipe); \
+			(pipe) = (pipe)->bottom_pipe)
+
+/* What both builders need of the dc, before either state. */
+enum bls_builder_result dcn401_check_dc_support(const struct dc *dc);
+/* What both builders need of a state's stream, apart from its planes. */
+enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state);
+
+/* pipe is NULL only for the bandwidth and p-state steps. */
+struct dcn401_commit_step_args {
+	struct dc *dc;
+	struct dc_state *current_state;
+	struct dc_state *new_state;
+	struct pipe_ctx *pipe;
+};
+
+void dcn401_add_steps(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *args,
+		const struct dcn401_commit_step *steps, unsigned int count);
+/* The support check found an OTG master for each stream of state. */
+void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		struct dc_state *state,
+		const struct dcn401_commit_step *steps, unsigned int count);
+/* Each DPP pipe of each stream, the OTG master first. */
+void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
+		const struct dcn401_commit_step_args *state_args,
+		struct dc_state *state,
+		const struct dcn401_commit_step *steps, unsigned int count);
+#define DCN401_ADD_STEPS(sequence, args, steps) \
+	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
+#define DCN401_ADD_PER_OTG_MASTER(sequence, args, state, steps) \
+	dcn401_add_per_otg_master(sequence, args, state, steps, \
+			ARRAY_SIZE(steps))
+#define DCN401_ADD_PER_DPP_PIPE(sequence, args, state, steps) \
+	dcn401_add_per_dpp_pipe(sequence, args, state, steps, \
+			ARRAY_SIZE(steps))
+
+/*
+ * Points the step arguments at the states and the sequence at
+ * head_sequence, both empty. The entries point into the states; the build
+ * writes neither.
+ */
+void dcn401_init_and_unpack_params(
+		struct bls_builder_declarative_params *params,
+		struct dcn401_commit_step_args *state_args,
+		struct block_sequence_state *head);
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
new file mode 100644
index 000000000000..e379793a8efd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "bls_builder/bls_builder_internal.h"
+#include "bls_builder/dcn401_builder_internal.h"
+#include "state_facts/state_facts.h"
+
+/*
+ * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
+ * The new state has no stream, or one stream with no plane; the current
+ * state has no stream, or one stream with one or two planes, one per DPP
+ * pipe. Planes are added later by DCN_DECL_SEAMLESS_UPDATE, not by this
+ * commit.
+ *
+ * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
+ * calls in the same order, including the calls DC1 repeats. Everything is
+ * in head_sequence: the ODM double-buffer and blank waits come before the
+ * bandwidth lower, so no tail is needed.
+ */
+
+static bool check_stream_config_update(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)current_state;
+	(void)new_state;
+	return !dc->ctx->cp_psp.funcs.update_stream_config;
+}
+
+static bool check_plane_count(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct dc_state *state = dcn401_checked_state(current_state,
+			new_state);
+	unsigned int planes = state->stream_status[0].plane_count;
+	struct dc_state_facts facts;
+
+	/*
+	 * The current state carries the removed planes, one per DPP pipe.
+	 * The new state has none.
+	 */
+	(void)dc;
+	if (!current_state)
+		return !planes;
+	dc_state_facts_derive(state, &facts);
+	return planes && planes ==
+			facts.global.blend_tree[0].dpp_pipe_count;
+}
+
+static bool check_pipe_plane(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	/*
+	 * The current state carries the removed planes. The new state has
+	 * none.
+	 */
+	struct dc_state_facts facts;
+	const struct dc_state *state = current_state ? current_state : new_state;
+
+	(void)dc;
+	dc_state_facts_derive(state, &facts);
+	if (!facts.pipe.count)
+		return false;
+	if (current_state)
+		return dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+				DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
+	return !dc_state_facts_any_pipe(&facts, 0,
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0));
+}
+
+static bool check_plane_blocks(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	struct dc_state_facts facts;
+
+	(void)new_state;
+	(void)dc;
+	if (!current_state)
+		return true;
+	dc_state_facts_derive(current_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
+}
+
+/* The OPP's tree holds exactly the removed MPCCs, in pipe order. */
+static bool check_mpcc_tree(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
+	const struct mpcc *mpcc;
+
+	if (!current_state)
+		return true;
+	if (!pipe || !dc->res_pool || !dc->res_pool->mpc)
+		return false;
+	mpcc = pipe->stream_res.opp->mpc_tree_params.opp_list;
+	for (; pipe; pipe = pipe->bottom_pipe) {
+		if (mpcc != &dc->res_pool->mpc->mpcc_array[
+				pipe->plane_res.mpcc_inst] ||
+				mpcc->dpp_id != pipe->plane_res.dpp->inst)
+			return false;
+		mpcc = mpcc->mpcc_bot;
+	}
+	return !mpcc;
+}
+
+static enum bls_builder_result dcn401_check_commit_state_support(
+		const struct dc *dc, const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	enum bls_builder_result result;
+
+	result = dcn401_check_stream_support(dc, current_state, new_state);
+	if (result != BLS_BUILD_SUCCESS ||
+			!dcn401_checked_state(current_state,
+			new_state)->stream_count)
+		return result;
+
+	CHECK_CONDITION(plane_count, "plane count does not match the state");
+	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
+	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
+	CHECK_CONDITION(mpcc_tree, "opp tree does not match the pipes");
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool check_stream_not_kept(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	/* A stream is either removed or added, never kept. */
+	return !current_state->stream_count || !new_state->stream_count;
+}
+
+static bool check_link_not_active(const struct dc *dc,
+		const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	(void)dc;
+	(void)current_state;
+	if (!new_state->stream_count)
+		return true;
+	return !new_state->streams[0]->link->link_status.link_active;
+}
+
+static enum bls_builder_result dcn401_check_non_seamless_commit_support(
+		const struct dc *dc, const struct dc_state *current_state,
+		const struct dc_state *new_state)
+{
+	enum bls_builder_result result;
+
+	if (!dc || !current_state || !new_state)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	result = dcn401_check_dc_support(dc);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+	CHECK_CONDITION(stream_config_update, "stream config update is set");
+
+	result = dcn401_check_commit_state_support(dc, current_state, NULL);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+	result = dcn401_check_commit_state_support(dc, NULL, new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	CHECK_CONDITION(stream_not_kept, "stream is kept across the commit");
+	CHECK_CONDITION(link_not_active, "link is already active");
+	return BLS_BUILD_SUCCESS;
+}
+
+/*
+ * Net effect: dcn401_prepare_bandwidth without FAMS2, SubVP or DC-mode
+ * softmax.
+ */
+static const struct dcn401_commit_step
+bls_head_per_state_new_prepare_bandwidth[] = {
+	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
+	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_WATERMARKS,
+	  .meta.hubbub_program_watermarks.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_ARBITER,
+	  .meta.hubbub_program_arbiter.safe_to_lower = false },
+	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = false },
+};
+
+/*
+ * Net effect: disable the stream of the current state.
+ * - disable_dangling_plane: disconnect the MPCC under the OTG lock, then
+ *   dcn20_disable_plane.
+ * - link_set_dpms_off for the virtual signal: dcn401_disable_stream, then
+ *   disable_link, which disables the output as DisplayPort.
+ * - dcn401_reset_back_end_for_pipe after link_set_dpms_off, then the
+ *   clock source power-down from dcn401_reset_hw_ctx_wrap.
+ * The front end disconnects every MPCC under the lock, then powers down
+ * each DPP pipe after the unlock; the _dpp tables run once per DPP pipe.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current_lock[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_dpp_pipe_current_disconnect[] = {
+	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
+	{ .func = MPC_REMOVE_MPCC },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current_unlock[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_dpp_pipe_current_power_down[] = {
+	{ .func = MPC_ASSERT_IDLE_MPCC },
+	{ .func = HUBP_SET_BLANK },
+	{ .func = HUBP_UPDATE_MALL_SEL },
+	{ .func = HUBP_SET_FLIP_CONTROL_GSL },
+	{ .func = HUBP_CLK_CNTL },
+	{ .func = DPP_DPPCLK_CONTROL },
+	/*
+	 * dcn10_plane_atomic_power_down sets IP_REQUEST_EN only when it
+	 * reads 0. Every writer clears it again, so it always reads 0 here.
+	 */
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
+	{ .func = HUBP_PG_CONTROL },
+	{ .func = HUBP_RESET },
+	{ .func = DPP_RESET },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
+};
+
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_current_stream_off[] = {
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+
+	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
+	  .meta.link_enc_connect_dig_be_to_fe.connect = false },
+	{ .func = DCCG_DISABLE_SYMCLK_SE },
+	{ .func = DIO_LINK_ENC_DISABLE_OUTPUT },
+
+	{ .func = TG_DISABLE_CRTC },
+	{ .func = TG_ENABLE_OPTC_CLOCK,
+	  .meta.tg_enable_optc_clock.enable = false },
+	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = TG_SET_DRR },
+	/* link_set_dpms_off disabled the output already. */
+	{ .func = DCCG_SET_DTBCLK_P_SRC,
+	  .meta.dccg_set_dtbclk_p_src.src = REFCLK },
+	{ .func = CLK_SRC_POWER_DOWN },
+};
+
+/*
+ * Net effect: enable the stream of the new state. Between the BIOS
+ * critical-state calls:
+ * - dcn401_enable_stream_timing plus the dce110_apply_single_controller
+ *   calls around it, up to the DIG connect.
+ * - link_set_dpms_on for the virtual signal: enable_link_virtual, then
+ *   dcn401_enable_stream. The virtual stream encoder has no enable, map,
+ *   input-mode or FIFO funcs, and update_info_frame programs nothing.
+ *   DC1 skips dig_connect_to_otg for the virtual signal.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_new[] = {
+	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
+	  .meta.bios_set_scratch_critical_state.state = true },
+
+	{ .func = OPP_PROGRAM_FMT },
+	{ .func = OPP_SET_DYN_EXPANSION },
+	{ .func = DCCG_SET_PIXEL_RATE_DIV,
+	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_4 },
+	{ .func = DCCG_SET_DTBCLK_P_SRC,
+	  .meta.dccg_set_dtbclk_p_src.src = DPREFCLK },
+	{ .func = TG_ENABLE_OPTC_CLOCK,
+	  .meta.tg_enable_optc_clock.enable = true },
+	{ .func = CLK_SRC_PROGRAM_PIX_CLK },
+	{ .func = TG_PROGRAM_TIMING },
+	{ .func = TG_SET_H_TIMING_DIV_MANUAL_MODE },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+	{ .func = TG_ENABLE_CRTC },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true,
+	  .meta.tg_set_drr.with_mid = true },
+	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
+	{ .func = TG_SETUP_VERTICAL_INTERRUPT2 },
+	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true },
+	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
+
+	{ .func = TG_SET_OUT_MUX },
+	{ .func = DIO_LINK_ENC_ENABLE_DP_OUTPUT },
+	{ .func = DCCG_ENABLE_SYMCLK_SE },
+	/* dcn401_enable_stream divides by one unless the signal is HDMI or DVI. */
+	{ .func = DCCG_SET_PIXEL_RATE_DIV,
+	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_1 },
+	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
+	  .meta.link_enc_connect_dig_be_to_fe.connect = true },
+	{ .func = TG_SET_EARLY_CONTROL },
+
+	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
+	  .meta.bios_set_scratch_critical_state.state = false },
+};
+
+/*
+ * Net effect: finish the head for the new OTG master. program_front_end
+ * for a master with no plane, then stereo, then the waits that complete
+ * the head's double buffering. legacy_commit_state_hw sets up stereo for
+ * a mode-changed stream, then dc_enable_stereo sets it up again for every
+ * stream; dcn10_setup_stereo with no 3D format is the two STEREO calls.
+ * The bandwidth lower starts only after these waits.
+ */
+static const struct dcn401_commit_step
+		bls_head_per_stream_per_otg_master_pipe_new_front_end[] = {
+	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
+	{ .func = OPTC_SET_ODM_BYPASS },
+	{ .func = OPP_PIPE_CLOCK_CONTROL },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+	{ .func = OPP_SET_DYN_EXPANSION },
+	{ .func = OPP_PROGRAM_FMT },
+	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
+	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
+	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
+
+	{ .func = OPP_PROGRAM_STEREO,
+	  .meta.skip_if.stream_mode_unchanged = true },
+	{ .func = TG_PROGRAM_STEREO,
+	  .meta.skip_if.stream_mode_unchanged = true },
+	{ .func = OPP_PROGRAM_STEREO },
+	{ .func = TG_PROGRAM_STEREO },
+
+	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
+	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
+};
+
+/*
+ * Net effect: release the forced p-state when no OTG master did, then
+ * dcn401_optimize_bandwidth without FAMS2, SubVP or DC-mode softmax.
+ */
+static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	  .meta.skip_if.new_state_has_stream = true },
+	{ .func = HUBBUB_PROGRAM_WATERMARKS,
+	  .meta.hubbub_program_watermarks.safe_to_lower = true },
+	{ .func = HUBBUB_PROGRAM_ARBITER,
+	  .meta.hubbub_program_arbiter.safe_to_lower = true },
+	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true },
+	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
+	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = true },
+};
+
+/*
+ * Bounds on what build adds. The support check allows one stream per
+ * state, and never one in both.
+ */
+static_assert(ARRAY_SIZE(bls_head_per_state_new_prepare_bandwidth) +
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current_lock) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
+		bls_head_per_stream_per_dpp_pipe_current_disconnect) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_current_unlock) +
+		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
+		bls_head_per_stream_per_dpp_pipe_current_power_down) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_current_stream_off) +
+		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
+		DC2_BLS_MAX_STEPS,
+		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
+static_assert(ARRAY_SIZE(bls_head_per_state_new_prepare_bandwidth) +
+		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_new) +
+		ARRAY_SIZE(
+		bls_head_per_stream_per_otg_master_pipe_new_front_end) +
+		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
+		DC2_BLS_MAX_STEPS,
+		"dcn401 commit enable head exceeds DC2_BLS_MAX_STEPS");
+
+static enum bls_builder_result dcn401_build_non_seamless_commit(
+		struct bls_builder_declarative_params *params)
+{
+	struct dcn401_commit_step_args state_args;
+	struct block_sequence_state head;
+	enum bls_builder_result result;
+
+	if (!params)
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	result = dcn401_check_non_seamless_commit_support(params->dc,
+			params->current_state, params->new_state);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
+
+	dcn401_init_and_unpack_params(params, &state_args, &head);
+	DCN401_ADD_STEPS(&head, &state_args,
+			bls_head_per_state_new_prepare_bandwidth);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
+			state_args.current_state,
+			bls_head_per_stream_per_otg_master_pipe_current_lock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
+			bls_head_per_stream_per_dpp_pipe_current_disconnect);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
+			state_args.current_state,
+			bls_head_per_stream_per_otg_master_pipe_current_unlock);
+	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
+			bls_head_per_stream_per_dpp_pipe_current_power_down);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
+			state_args.current_state,
+			bls_head_per_stream_per_otg_master_pipe_current_stream_off);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_head_per_stream_per_otg_master_pipe_new);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_head_per_stream_per_otg_master_pipe_new_front_end);
+	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new_postamble);
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static bool dcn401_non_seamless_commit_check_capability(
+		const struct bls_builder_check_capability_params *params)
+{
+	return params && dcn401_check_non_seamless_commit_support(params->dc,
+			params->current_state, params->new_state) ==
+			BLS_BUILD_SUCCESS;
+}
+
+const struct bls_builder *dcn401_non_seamless_commit_builder(void)
+{
+	static const struct bls_builder builder = {
+		.name = DCN_DECL_NON_SEAMLESS_COMMIT,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.check_capability = dcn401_non_seamless_commit_check_capability,
+		.build.declarative = dcn401_build_non_seamless_commit,
+	};
+
+	return &builder;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
similarity index 72%
rename from drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
rename to drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 19765f7dcd11..b7f6909d69e0 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -17,33 +17,29 @@
 #include "bls_builder/bls_builder_internal.h"
 #include "bls_builder/dcn401_init_builder.h"
 #include "bls_builder/bls_builder_private_types.h"
+#include "bls_builder/dcn401_builder_internal.h"
+#include "state_facts/state_facts.h"
 
 #undef DC_LOGGER
 #define DC_LOGGER \
 	dc->ctx->logger
 
 /*
- * DCN_DECL_NON_SEAMLESS_COMMIT for one virtual stream without planes.
- * The new state has no stream, or one stream with no plane; the current
- * state has no stream, or one stream with one or two planes, one per DPP
- * pipe. Planes are added later by DCN_DECL_SEAMLESS_UPDATE, not by this
- * commit.
- *
- * The sequence follows legacy_commit_state_hw on dcn401: the same leaf
- * calls in the same order, including the calls DC1 repeats. Everything is
- * in head_sequence: the ODM double-buffer and blank waits come before the
- * bandwidth lower, so no tail is needed.
- *
- * DCN_DECL_SEAMLESS_UPDATE either adds one plane, or two MPC-blended
- * planes, to that stream, or keeps one plane and programs its surface,
- * address, scaler and viewport. The
- * sequence follows the full update in commit_planes_for_stream on dcn401,
- * all in head_sequence: the outstanding updates, prepare_bandwidth and
- * the pending-update waits, then the locked front-end programming and
+ * DCN_DECL_SEAMLESS_UPDATE for the one virtual stream that
+ * DCN_DECL_NON_SEAMLESS_COMMIT (dcn401_non_seamless_builder.c) enabled.
+ * The update either adds one plane, or two MPC-blended planes, to that
+ * stream, or keeps one plane and programs its surface, address, scaler
+ * and viewport. The sequence follows the full update in
+ * commit_planes_for_stream on dcn401, all in head_sequence: the
+ * outstanding updates, prepare_bandwidth and the pending-update waits,
+ * then the locked front-end programming and
  * post_unlock_program_front_end. A kept-plane update skips enable_plane
  * and the stream unblank. The bandwidth lower stays with
  * dc_post_update_surfaces_to_stream.
  *
+ * This file also holds what both builders share: the dc and stream
+ * support checks, and the step walkers that turn a table into BLS entries.
+ *
  * Neither builder emits a tail_sequence. A tail runs only after a vsync,
  * and Core has no wait-for-vsync imperative yet, so Core rejects a tail.
  */
@@ -60,41 +56,12 @@
 #define DCN401_MALL_SEL_SS 2
 #define DCN401_CACHE_CURSOR_BYTES 16384
 
-/*
- * Each helper takes the same arguments. CHECK_CONDITION logs the reason
- * and returns. current_state or new_state is NULL when the helper looks
- * at only one of them.
- */
-
-static void dcn401_commit_check_failed(const struct dc *dc, const char *msg)
+void dcn401_commit_check_failed(const struct dc *dc, const char *msg)
 {
 	if (dc && dc->ctx && dc->ctx->logger)
 		DC_LOG_DEBUG("%s\n", msg);
 }
 
-#define CHECK_CONDITION(name, msg) \
-	do { \
-		if (!check_##name(dc, current_state, new_state)) { \
-			dcn401_commit_check_failed(dc, msg); \
-			return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE; \
-		} \
-	} while (0)
-
-#define CHECK_RESOURCE(name, msg) \
-	do { \
-		if (!check_##name(dc, current_state, new_state)) { \
-			dcn401_commit_check_failed(dc, msg); \
-			return BLS_BUILD_ERROR_RESOURCE_MAPPING; \
-		} \
-	} while (0)
-
-static const struct dc_state *dcn401_checked_state(
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	return current_state ? current_state : new_state;
-}
-
 static bool check_dc_resources(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
@@ -155,13 +122,19 @@ static bool check_dsc_power_gate(const struct dc *dc,
 	return dc->debug.disable_dsc_power_gate;
 }
 
-static bool check_stream_config_update(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
+enum bls_builder_result dcn401_check_dc_support(const struct dc *dc)
 {
-	(void)current_state;
-	(void)new_state;
-	return !dc->ctx->cp_psp.funcs.update_stream_config;
+	const struct dc_state *current_state = NULL;
+	const struct dc_state *new_state = NULL;
+
+	CHECK_RESOURCE(dc_resources, "dc resources are missing");
+	CHECK_CONDITION(fams2_debug, "FAMS2 debug is enabled");
+	CHECK_CONDITION(cursor_offload, "cursor offload is enabled");
+	CHECK_CONDITION(dc_mode_softmax, "dc mode softmax is enabled");
+	CHECK_CONDITION(visual_confirm,
+			"visual confirm, dpg, hblank borrow, or frame sync is set");
+	CHECK_CONDITION(dsc_power_gate, "DSC power gate is enabled");
+	return BLS_BUILD_SUCCESS;
 }
 
 static bool check_one_stream(const struct dc *dc,
@@ -289,12 +262,13 @@ static bool check_abm(const struct dc *dc,
  * more than one. An MPC bottom pipe of the stream is not an OTG master;
  * check_mpc_blend bounds it.
  */
-static const struct pipe_ctx *dcn401_state_otg_master(
+static const struct pipe_ctx *dcn401_state_otg_master(const struct dc *dc,
 		const struct dc_state *state, bool *not_one_pipe)
 {
 	const struct pipe_ctx *otg_master = NULL;
 	unsigned int i;
 
+	(void)dc;
 	*not_one_pipe = false;
 	for (i = 0; i < MAX_PIPES; i++) {
 		const struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
@@ -312,69 +286,24 @@ static const struct pipe_ctx *dcn401_state_otg_master(
 	return otg_master;
 }
 
-static const struct pipe_ctx *dcn401_checked_otg_master(
+const struct pipe_ctx *dcn401_checked_otg_master(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	bool not_one_pipe = false;
 
-	return dcn401_state_otg_master(dcn401_checked_state(current_state,
+	return dcn401_state_otg_master(dc, dcn401_checked_state(current_state,
 			new_state), &not_one_pipe);
 }
 
-/* The OTG master of one state, or NULL when that state is not one pipe. */
-static const struct pipe_ctx *dcn401_otg_of(const struct dc_state *state)
+const struct pipe_ctx *dcn401_otg_of(const struct dc *dc,
+		const struct dc_state *state)
 {
 	bool not_one_pipe = false;
 
 	if (!state)
 		return NULL;
-	return dcn401_state_otg_master(state, &not_one_pipe);
-}
-
-/* The OTG master and its MPC bottom pipe, top to bottom. */
-static unsigned int dcn401_dpp_pipe_count(const struct pipe_ctx *otg_master)
-{
-	unsigned int count = 0;
-
-	for (; otg_master; otg_master = otg_master->bottom_pipe)
-		count++;
-	return count;
-}
-
-typedef bool (*dcn401_pipe_check)(const struct pipe_ctx *pipe);
-
-/* False when state has no OTG master, or check fails on one of its pipes. */
-static bool dcn401_each_dpp_pipe(const struct dc_state *state,
-		dcn401_pipe_check check)
-{
-	const struct pipe_ctx *pipe = dcn401_otg_of(state);
-
-	if (!pipe)
-		return false;
-	for (; pipe; pipe = pipe->bottom_pipe) {
-		if (!check(pipe))
-			return false;
-	}
-	return true;
-}
-
-static bool check_plane_count(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	const struct dc_state *state = dcn401_checked_state(current_state,
-			new_state);
-	unsigned int planes = state->stream_status[0].plane_count;
-
-	(void)dc;
-	/*
-	 * The current state carries the removed planes, one per DPP pipe.
-	 * The new state has none.
-	 */
-	if (!current_state)
-		return !planes;
-	return planes && planes == dcn401_dpp_pipe_count(dcn401_otg_of(state));
+	return dcn401_state_otg_master(dc, state, &not_one_pipe);
 }
 
 static bool check_one_otg_pipe(const struct dc *dc,
@@ -383,9 +312,8 @@ static bool check_one_otg_pipe(const struct dc *dc,
 {
 	bool not_one_pipe = false;
 
-	(void)dc;
-	dcn401_state_otg_master(dcn401_checked_state(current_state, new_state),
-			&not_one_pipe);
+	dcn401_state_otg_master(dc, dcn401_checked_state(current_state,
+			new_state), &not_one_pipe);
 	return !not_one_pipe;
 }
 
@@ -393,18 +321,16 @@ static bool check_otg_master_present(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
-	return dcn401_checked_otg_master(current_state, new_state) != NULL;
+	return dcn401_checked_otg_master(dc, current_state, new_state) != NULL;
 }
 
 static bool check_odm_combine(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	(void)dc;
 	return pipe && !pipe->next_odm_pipe && !pipe->prev_odm_pipe;
 }
 
@@ -412,111 +338,40 @@ static bool check_mpc_blend(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	const struct pipe_ctx *bottom;
+	struct dc_state_facts facts;
 
-	(void)dc;
 	if (!pipe || pipe->top_pipe)
 		return false;
-	/* At most one bottom pipe, blended on the master's OTG and OPP. */
-	bottom = pipe->bottom_pipe;
-	if (!bottom)
-		return true;
-	return bottom->top_pipe == pipe && !bottom->bottom_pipe &&
-			!bottom->next_odm_pipe && !bottom->prev_odm_pipe &&
-			bottom->stream == pipe->stream &&
-			bottom->stream_res.tg == pipe->stream_res.tg &&
-			bottom->stream_res.opp == pipe->stream_res.opp;
-}
-
-static bool dcn401_pipe_has_plane(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state != NULL;
-}
-
-static bool dcn401_pipe_has_no_plane(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state == NULL;
-}
-
-static bool check_pipe_plane(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	/*
-	 * The current state carries the removed planes. The new state has
-	 * none.
-	 */
-	if (current_state)
-		return dcn401_each_dpp_pipe(current_state,
-				dcn401_pipe_has_plane);
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_has_no_plane);
+	dc_state_facts_derive(dcn401_checked_state(current_state, new_state),
+			&facts);
+	/* At most one bottom pipe, on the master's OTG and OPP, and no ODM. */
+	return facts.global.blend_tree[0].dpp_pipe_count <= 2 &&
+			facts.global.blend_tree[0].on_otg_master_blocks &&
+			!dc_state_facts_any_pipe(&facts, 0,
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ODM, 0));
 }
 
 static bool check_otg_master_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	(void)dc;
 	return pipe && pipe->stream_res.tg && pipe->stream_res.opp &&
 			pipe->stream_res.stream_enc && pipe->clock_source;
 }
 
-static bool dcn401_pipe_plane_blocks(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_res.hubp && pipe->plane_res.dpp &&
-			pipe->plane_res.mpcc_inst < MAX_MPCC;
-}
-
-static bool check_plane_blocks(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	(void)new_state;
-	if (!current_state)
-		return true;
-	return dcn401_each_dpp_pipe(current_state, dcn401_pipe_plane_blocks);
-}
-
-/* The OPP's tree holds exactly the removed MPCCs, in pipe order. */
-static bool check_mpcc_tree(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
-	const struct mpcc *mpcc;
-
-	if (!current_state)
-		return true;
-	if (!pipe || !dc->res_pool || !dc->res_pool->mpc)
-		return false;
-	mpcc = pipe->stream_res.opp->mpc_tree_params.opp_list;
-	for (; pipe; pipe = pipe->bottom_pipe) {
-		if (mpcc != &dc->res_pool->mpc->mpcc_array[
-				pipe->plane_res.mpcc_inst] ||
-				mpcc->dpp_id != pipe->plane_res.dpp->inst)
-			return false;
-		mpcc = mpcc->mpcc_bot;
-	}
-	return !mpcc;
-}
-
 static bool check_pipe_audio(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	(void)dc;
 	return pipe && !pipe->stream_res.audio;
 }
 
@@ -524,10 +379,9 @@ static bool check_pipe_dsc(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	(void)dc;
 	return pipe && !pipe->stream_res.dsc;
 }
 
@@ -535,10 +389,9 @@ static bool check_pipe_gsl(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
-	(void)dc;
 	return pipe && !pipe->stream_res.gsl_group;
 }
 
@@ -546,8 +399,8 @@ static bool check_link_enc_assignment(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *pipe = dcn401_checked_otg_master(current_state,
-			new_state);
+	const struct pipe_ctx *pipe = dcn401_checked_otg_master(dc,
+			current_state, new_state);
 
 	if (!dc->config.unify_link_enc_assignment)
 		return true;
@@ -555,9 +408,8 @@ static bool check_link_enc_assignment(const struct dc *dc,
 			pipe->stream->link->link_enc;
 }
 
-/* What both builders need of a state's stream, apart from its planes. */
-static enum bls_builder_result dcn401_check_stream_support(
-		const struct dc *dc, const struct dc_state *current_state,
+enum bls_builder_result dcn401_check_stream_support(const struct dc *dc,
+		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
 	const struct dc_state *state = dcn401_checked_state(current_state,
@@ -584,7 +436,8 @@ static enum bls_builder_result dcn401_check_stream_support(
 	CHECK_CONDITION(odm_combine, "odm is set");
 	CHECK_CONDITION(mpc_blend,
 			"more than one bottom pipe, or it is off the otg or opp");
-	CHECK_RESOURCE(otg_master_blocks, "otg master is missing a block");
+	CHECK_RESOURCE(otg_master_blocks,
+			"otg master is missing a stream resource or pixel clock");
 	CHECK_CONDITION(pipe_audio, "audio is set");
 	CHECK_CONDITION(pipe_dsc, "dsc is set");
 	CHECK_CONDITION(pipe_gsl, "gsl is set");
@@ -592,75 +445,6 @@ static enum bls_builder_result dcn401_check_stream_support(
 	return BLS_BUILD_SUCCESS;
 }
 
-static enum bls_builder_result dcn401_check_commit_state_support(
-		const struct dc *dc, const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	enum bls_builder_result result;
-
-	result = dcn401_check_stream_support(dc, current_state, new_state);
-	if (result != BLS_BUILD_SUCCESS ||
-			!dcn401_checked_state(current_state,
-			new_state)->stream_count)
-		return result;
-
-	CHECK_CONDITION(plane_count, "plane count does not match the state");
-	CHECK_CONDITION(pipe_plane, "pipe plane does not match the state");
-	CHECK_RESOURCE(plane_blocks, "plane is missing hubp or dpp");
-	CHECK_CONDITION(mpcc_tree, "opp tree does not match the pipes");
-	return BLS_BUILD_SUCCESS;
-}
-
-static bool check_stream_not_kept(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	/* A stream is either removed or added, never kept. */
-	return !current_state->stream_count || !new_state->stream_count;
-}
-
-static bool check_link_not_active(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	(void)current_state;
-	if (!new_state->stream_count)
-		return true;
-	return !new_state->streams[0]->link->link_status.link_active;
-}
-
-static enum bls_builder_result dcn401_check_non_seamless_commit_support(
-		const struct dc *dc, const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	enum bls_builder_result result;
-
-	if (!dc || !current_state || !new_state)
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-
-	CHECK_RESOURCE(dc_resources, "dc resources are missing");
-	CHECK_CONDITION(fams2_debug, "FAMS2 debug is enabled");
-	CHECK_CONDITION(cursor_offload, "cursor offload is enabled");
-	CHECK_CONDITION(dc_mode_softmax, "dc mode softmax is enabled");
-	CHECK_CONDITION(visual_confirm, "visual confirm, dpg, hblank borrow, "
-			"or frame sync is set");
-	CHECK_CONDITION(dsc_power_gate, "DSC power gate is enabled");
-	CHECK_CONDITION(stream_config_update, "stream config update is set");
-
-	result = dcn401_check_commit_state_support(dc, current_state, NULL);
-	if (result != BLS_BUILD_SUCCESS)
-		return result;
-	result = dcn401_check_commit_state_support(dc, NULL, new_state);
-	if (result != BLS_BUILD_SUCCESS)
-		return result;
-
-	CHECK_CONDITION(stream_not_kept, "stream is kept across the commit");
-	CHECK_CONDITION(link_not_active, "link is already active");
-	return BLS_BUILD_SUCCESS;
-}
-
 /* The seamless update keeps the one stream across the update. */
 static bool check_stream_kept(const struct dc *dc,
 		const struct dc_state *current_state,
@@ -698,11 +482,14 @@ static bool check_plane_add_or_kept(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
+	struct dc_state_facts facts;
+
 	(void)dc;
 	if (!dcn401_is_plane_add(current_state, new_state) &&
 			!dcn401_is_plane_kept(current_state, new_state))
 		return false;
-	return dcn401_dpp_pipe_count(dcn401_otg_of(new_state)) ==
+	dc_state_facts_derive(new_state, &facts);
+	return facts.global.blend_tree[0].dpp_pipe_count ==
 			new_state->stream_status[0].plane_count;
 }
 
@@ -710,29 +497,29 @@ static bool check_same_otg_master_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	const struct pipe_ctx *current_pipe = dcn401_otg_of(current_state);
-	const struct pipe_ctx *new_pipe = dcn401_otg_of(new_state);
+	const struct pipe_ctx *current_pipe = dcn401_otg_of(dc, current_state);
+	const struct pipe_ctx *new_pipe = dcn401_otg_of(dc, new_state);
 
-	(void)dc;
 	if (!current_pipe || !new_pipe)
 		return false;
 	return current_pipe->stream_res.tg == new_pipe->stream_res.tg &&
 			current_pipe->stream_res.opp == new_pipe->stream_res.opp;
 }
 
-static bool dcn401_pipe_new_plane_blocks(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state && pipe->plane_res.hubp &&
-			pipe->plane_res.dpp && pipe->plane_res.dpp->funcs;
-}
-
 static bool check_new_plane_blocks(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	struct dc_state_facts facts;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_new_plane_blocks);
+	if (!dcn401_otg_of(dc, new_state))
+		return false;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE |
+			DC_PIPE_TRAIT_PLANE_RESOURCES, 0));
 }
 
 static bool check_pool_funcs(const struct dc *dc,
@@ -744,27 +531,6 @@ static bool check_pool_funcs(const struct dc *dc,
 	return dc->res_pool->funcs && dc->res_pool->hubbub->funcs;
 }
 
-static bool dcn401_pipe_plane_instances(const struct pipe_ctx *pipe)
-{
-	int inst;
-
-	if (!pipe->plane_res.hubp || !pipe->plane_res.dpp)
-		return false;
-	inst = pipe->plane_res.hubp->inst;
-	return inst < MAX_MPCC && pipe->plane_res.mpcc_inst == inst &&
-			pipe->plane_res.dpp->inst == inst;
-}
-
-/* DC1 uses the HUBP instance as the MPCC and DPP instance. */
-static bool check_plane_instances(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
-	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_plane_instances);
-}
-
 /* dcn401 programs DET by segments only. */
 static bool check_det_by_segments(const struct dc *dc,
 		const struct dc_state *current_state,
@@ -795,18 +561,17 @@ static bool check_no_sanity_checks(const struct dc *dc,
 	return !dc->debug.sanity_checks;
 }
 
-static bool dcn401_pipe_no_wait(const struct pipe_ctx *pipe)
-{
-	return !pipe->wait_is_required;
-}
-
 static bool check_no_pipe_wait(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	struct dc_state_facts facts;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_wait);
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, 0,
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_WAIT, 0));
 }
 
 /* dcn20_blank_pixel_data does nothing while a test pattern is on. */
@@ -834,18 +599,17 @@ static bool check_no_forced_dpg(const struct dc *dc,
 }
 
 /* dcn20_blank_pixel_data sets the ABM pipe on unblank when there is one. */
-static bool dcn401_pipe_no_abm(const struct pipe_ctx *pipe)
-{
-	return !pipe->stream_res.abm;
-}
-
 static bool check_no_abm_pipe(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	struct dc_state_facts facts;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_abm);
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count && !dc_state_facts_any_pipe(&facts, 0,
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_ABM, 0));
 }
 
 /* enable_plane programs the system aperture when VM is valid. */
@@ -859,25 +623,20 @@ static bool check_no_vm_aperture(const struct dc *dc,
 }
 
 /* enable_plane sets the flip interrupt when the plane asks for one. */
-static bool dcn401_pipe_no_flip_int(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state && !pipe->plane_state->flip_int_enabled;
-}
-
 static bool check_no_flip_int(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
-	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_flip_int);
-}
+	const struct pipe_ctx *pipe;
 
-
-static bool dcn401_pipe_no_plane_gamut_remap(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state &&
-			!pipe->plane_state->gamut_remap_matrix.enable_remap;
+	(void)current_state;
+	if (!dcn401_otg_of(dc, new_state))
+		return false;
+	DCN401_FOR_EACH_DPP_PIPE(dc, new_state, pipe) {
+		if (!pipe->plane_state || pipe->plane_state->flip_int_enabled)
+			return false;
+	}
+	return true;
 }
 
 /* The update bypasses the plane gamut remap. */
@@ -885,10 +644,17 @@ static bool check_no_plane_gamut_remap(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	const struct pipe_ctx *pipe;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state,
-			dcn401_pipe_no_plane_gamut_remap);
+	if (!dcn401_otg_of(dc, new_state))
+		return false;
+	DCN401_FOR_EACH_DPP_PIPE(dc, new_state, pipe) {
+		if (!pipe->plane_state ||
+				pipe->plane_state->gamut_remap_matrix.enable_remap)
+			return false;
+	}
+	return true;
 }
 
 /* The update bypasses the stream gamut remap. */
@@ -912,24 +678,21 @@ static bool check_no_output_csc(const struct dc *dc,
 }
 
 /* The update programs the surface and its address without DCC. */
-static bool dcn401_pipe_no_dcc(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state && !pipe->plane_state->dcc.enable;
-}
-
 static bool check_no_dcc(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
-	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_dcc);
-}
+	struct dc_state_facts facts;
 
-static bool dcn401_pipe_graphics_address(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state &&
-			pipe->plane_state->address.type == PLN_ADDR_TYPE_GRAPHICS;
+	(void)current_state;
+	if (!dcn401_otg_of(dc, new_state))
+		return false;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
+			!dc_state_facts_any_plane(&facts, 0,
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DCC, 0));
 }
 
 /* The update programs a single graphics address, not stereo or video. */
@@ -937,14 +700,16 @@ static bool check_graphics_address(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
-	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_graphics_address);
-}
+	struct dc_state_facts facts;
 
-static bool dcn401_pipe_no_immediate_flip(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state && !pipe->plane_state->flip_immediate;
+	(void)current_state;
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
+			dc_state_facts_all_plane(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_GRAPHICS_ADDRESS, 0));
 }
 
 /* DC1 programs triple buffering and the flip only for a queued flip. */
@@ -952,56 +717,37 @@ static bool check_no_immediate_flip(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	struct dc_state_facts facts;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_immediate_flip);
+	if (!dcn401_otg_of(dc, new_state))
+		return false;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
+			!dc_state_facts_any_plane(&facts, 0,
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_FLIP_IMMEDIATE, 0));
 }
 
 /*
  * DC1 translates a distributed-points curve into a LUT while it programs
  * the plane. The update programs only the predefined and bypass curves.
  */
-static bool dcn401_pipe_no_degamma_curve(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_state &&
-			pipe->plane_state->in_transfer_func.type !=
-			TF_TYPE_DISTRIBUTED_POINTS;
-}
-
 static bool check_no_degamma_curve(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
-	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_degamma_curve);
-}
-
-static bool dcn401_pipe_no_dpp_pregam(const struct pipe_ctx *pipe)
-{
-	return pipe->plane_res.dpp && pipe->plane_res.dpp->funcs &&
-			!pipe->plane_res.dpp->funcs->dpp_set_pregam_state;
-}
+	struct dc_state_facts facts;
 
-/* dcn32_set_input_transfer_func calls dpp_set_pregam_state if present. */
-static bool check_no_dpp_pregam(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	(void)dc;
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_dpp_pregam);
-}
-
-static bool dcn401_pipe_no_mcm_luts(const struct pipe_ctx *pipe)
-{
-	const union dc_plane_cm_flags *flags;
-
-	if (!pipe->plane_state)
-		return false;
-	flags = &pipe->plane_state->cm.flags;
-	return !flags->bits.blend_enable && !flags->bits.shaper_enable &&
-			!flags->bits.lut3d_enable && !flags->bits.rmcm_enable;
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
+			!dc_state_facts_any_plane(&facts, 0,
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_DEGAMMA_CURVE, 0));
 }
 
 /* dcn401_set_mcm_luts then programs every MCM LUT off. */
@@ -1009,9 +755,17 @@ static bool check_no_mcm_luts(const struct dc *dc,
 		const struct dc_state *current_state,
 		const struct dc_state *new_state)
 {
-	(void)dc;
+	struct dc_state_facts facts;
+
 	(void)current_state;
-	return dcn401_each_dpp_pipe(new_state, dcn401_pipe_no_mcm_luts);
+
+	(void)dc;
+	dc_state_facts_derive(new_state, &facts);
+	return facts.pipe.count &&
+			dc_state_facts_all_pipe(&facts, 0, DC_TRAIT_MATCH(0, 0),
+			DC_TRAIT_MATCH(DC_PIPE_TRAIT_PLANE, 0)) &&
+			!dc_state_facts_any_plane(&facts, 0,
+			DC_TRAIT_MATCH(DC_PLANE_TRAIT_MCM_LUTS, 0));
 }
 
 static bool check_no_shaper_curve(const struct dc *dc,
@@ -1077,12 +831,9 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	if (!dc || !current_state || !new_state)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
-	CHECK_RESOURCE(dc_resources, "dc resources are missing");
-	CHECK_CONDITION(fams2_debug, "FAMS2 debug is enabled");
-	CHECK_CONDITION(cursor_offload, "cursor offload is enabled");
-	CHECK_CONDITION(dc_mode_softmax, "dc mode softmax is enabled");
-	CHECK_CONDITION(visual_confirm, "visual confirm, dpg, hblank borrow, or frame sync is set");
-	CHECK_CONDITION(dsc_power_gate, "DSC power gate is enabled");
+	result = dcn401_check_dc_support(dc);
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
 
 	result = dcn401_check_stream_support(dc, current_state, NULL);
 	if (result != BLS_BUILD_SUCCESS)
@@ -1098,7 +849,6 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	CHECK_CONDITION(same_otg_master_blocks, "otg or opp changes");
 	CHECK_RESOURCE(new_plane_blocks, "plane is missing hubp or dpp");
 	CHECK_RESOURCE(pool_funcs, "resource pool or hubbub has no funcs");
-	CHECK_CONDITION(plane_instances, "mpcc or dpp is not the hubp instance");
 	CHECK_CONDITION(det_by_segments, "hubbub programs det size");
 
 	/* Under the lock, before the pipe is programmed. */
@@ -1123,7 +873,6 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 
 	/* Input, MCM and output transfer functions. */
 	CHECK_CONDITION(no_degamma_curve, "plane degamma is distributed points");
-	CHECK_CONDITION(no_dpp_pregam, "dpp has a pregam state");
 	CHECK_CONDITION(no_mcm_luts, "an mcm lut is enabled");
 	CHECK_CONDITION(no_shaper_curve, "shaper is distributed points");
 	CHECK_CONDITION(no_stream_3dlut, "stream 3dlut is set");
@@ -1136,14 +885,18 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 }
 
 static struct pipe_ctx *get_otg_master_from_state_by_stream(
-		struct dc_state *state, const struct dc_stream_state *stream)
+		const struct dc *dc, struct dc_state *state,
+		const struct dc_stream_state *stream)
 {
 	unsigned int i;
 
+	(void)dc;
+
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (state->res_ctx.pipe_ctx[i].stream == stream &&
-				!state->res_ctx.pipe_ctx[i].top_pipe)
-			return &state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && !pipe->top_pipe)
+			return pipe;
 	}
 	return NULL;
 }
@@ -1152,7 +905,8 @@ static struct pipe_ctx *get_otg_master_from_state_by_stream(
  * Net effect: dcn401_prepare_bandwidth without FAMS2, SubVP or DC-mode
  * softmax.
  */
-static const struct dcn401_commit_step bls_head_per_state_new[] = {
+static const struct dcn401_commit_step
+bls_update_head_per_state_new_prepare_bandwidth[] = {
 	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
 	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = false },
 	{ .func = HUBBUB_PROGRAM_WATERMARKS,
@@ -1163,202 +917,6 @@ static const struct dcn401_commit_step bls_head_per_state_new[] = {
 	  .meta.hubbub_program_compbuf_segments.safe_to_lower = false },
 };
 
-/*
- * Net effect: disable the stream of the current state.
- * - disable_dangling_plane: disconnect the MPCC under the OTG lock, then
- *   dcn20_disable_plane.
- * - link_set_dpms_off for the virtual signal: dcn401_disable_stream, then
- *   disable_link, which disables the output as DisplayPort.
- * - dcn401_reset_back_end_for_pipe after link_set_dpms_off, then the
- *   clock source power-down from dcn401_reset_hw_ctx_wrap.
- * The front end disconnects every MPCC under the lock, then powers down
- * each DPP pipe after the unlock; the _dpp tables run once per DPP pipe.
- */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_lock[] = {
-	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
-	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
-};
-
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_dpp_pipe_current_disconnect[] = {
-	{ .func = HUBP_PROGRAM_DET_SEGMENTS },
-	{ .func = MPC_REMOVE_MPCC },
-};
-
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_unlock[] = {
-	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
-};
-
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_dpp_pipe_current_power_down[] = {
-	{ .func = MPC_ASSERT_IDLE_MPCC },
-	{ .func = HUBP_SET_BLANK },
-	{ .func = HUBP_UPDATE_MALL_SEL },
-	{ .func = HUBP_SET_FLIP_CONTROL_GSL },
-	{ .func = HUBP_CLK_CNTL },
-	{ .func = DPP_DPPCLK_CONTROL },
-	/*
-	 * dcn10_plane_atomic_power_down sets IP_REQUEST_EN only when it
-	 * reads 0. Every writer clears it again, so it always reads 0 here.
-	 */
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
-	{ .func = HUBP_PG_CONTROL },
-	{ .func = HUBP_RESET },
-	{ .func = DPP_RESET },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
-};
-
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_current_stream_off[] = {
-	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
-
-	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
-	  .meta.link_enc_connect_dig_be_to_fe.connect = false },
-	{ .func = DCCG_DISABLE_SYMCLK_SE },
-	{ .func = DIO_LINK_ENC_DISABLE_OUTPUT },
-
-	{ .func = TG_DISABLE_CRTC },
-	{ .func = TG_ENABLE_OPTC_CLOCK,
-	  .meta.tg_enable_optc_clock.enable = false },
-	{ .func = OPTC_SET_ODM_BYPASS },
-	{ .func = TG_SET_DRR },
-	/* link_set_dpms_off disabled the output already. */
-	{ .func = DCCG_SET_DTBCLK_P_SRC,
-	  .meta.dccg_set_dtbclk_p_src.src = REFCLK },
-	{ .func = CLK_SRC_POWER_DOWN },
-};
-
-/*
- * Net effect: enable the stream of the new state. Between the BIOS
- * critical-state calls:
- * - dcn401_enable_stream_timing plus the dce110_apply_single_controller
- *   calls around it, up to the DIG connect.
- * - link_set_dpms_on for the virtual signal: enable_link_virtual, then
- *   dcn401_enable_stream. The virtual stream encoder has no enable, map,
- *   input-mode or FIFO funcs, and update_info_frame programs nothing.
- *   DC1 skips dig_connect_to_otg for the virtual signal.
- */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_new[] = {
-	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
-	  .meta.bios_set_scratch_critical_state.state = true },
-
-	{ .func = OPP_PROGRAM_FMT },
-	{ .func = OPP_SET_DYN_EXPANSION },
-	{ .func = DCCG_SET_PIXEL_RATE_DIV,
-	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_4 },
-	{ .func = DCCG_SET_DTBCLK_P_SRC,
-	  .meta.dccg_set_dtbclk_p_src.src = DPREFCLK },
-	{ .func = TG_ENABLE_OPTC_CLOCK,
-	  .meta.tg_enable_optc_clock.enable = true },
-	{ .func = CLK_SRC_PROGRAM_PIX_CLK },
-	{ .func = TG_PROGRAM_TIMING },
-	{ .func = TG_SET_H_TIMING_DIV_MANUAL_MODE },
-	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
-	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
-	{ .func = TG_ENABLE_CRTC },
-	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
-	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true,
-	  .meta.tg_set_drr.with_mid = true },
-	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
-	{ .func = TG_SETUP_VERTICAL_INTERRUPT2 },
-	{ .func = TG_SET_DRR, .meta.tg_set_drr.from_adjust = true },
-	{ .func = TG_SET_STATIC_SCREEN_CONTROL },
-
-	{ .func = TG_SET_OUT_MUX },
-	{ .func = DIO_LINK_ENC_ENABLE_DP_OUTPUT },
-	{ .func = DCCG_ENABLE_SYMCLK_SE },
-	/* dcn401_enable_stream divides by one unless the signal is HDMI or DVI. */
-	{ .func = DCCG_SET_PIXEL_RATE_DIV,
-	  .meta.dccg_set_pixel_rate_div.k1 = PIXEL_RATE_DIV_BY_1 },
-	{ .func = DIO_LINK_ENC_CONNECT_DIG_BE_TO_FE,
-	  .meta.link_enc_connect_dig_be_to_fe.connect = true },
-	{ .func = TG_SET_EARLY_CONTROL },
-
-	{ .func = BIOS_SET_SCRATCH_CRITICAL_STATE,
-	  .meta.bios_set_scratch_critical_state.state = false },
-};
-
-/*
- * Net effect: finish the head for the new OTG master. program_front_end
- * for a master with no plane, then stereo, then the waits that complete
- * the head's double buffering. legacy_commit_state_hw sets up stereo for
- * a mode-changed stream, then dc_enable_stereo sets it up again for every
- * stream; dcn10_setup_stereo with no 3D format is the two STEREO calls.
- * The bandwidth lower starts only after these waits.
- */
-static const struct dcn401_commit_step
-		bls_head_per_stream_per_otg_master_pipe_new_front_end[] = {
-	{ .func = TG_LOCK, .meta.tg_lock.lock = true },
-	{ .func = OPTC_SET_ODM_BYPASS },
-	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
-	{ .func = OPP_SET_DYN_EXPANSION },
-	{ .func = OPP_PROGRAM_FMT },
-	{ .func = OPP_SET_DISP_PATTERN_GENERATOR },
-	{ .func = TG_LOCK, .meta.tg_lock.lock = false },
-	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL },
-
-	{ .func = OPP_PROGRAM_STEREO,
-	  .meta.skip_if.stream_mode_unchanged = true },
-	{ .func = TG_PROGRAM_STEREO,
-	  .meta.skip_if.stream_mode_unchanged = true },
-	{ .func = OPP_PROGRAM_STEREO },
-	{ .func = TG_PROGRAM_STEREO },
-
-	{ .func = TG_WAIT_ODM_DOUBLEBUFFER_PENDING_CLEAR },
-	{ .func = OPP_WAIT_FOR_BLANK_COMPLETE },
-};
-
-/*
- * Net effect: release the forced p-state when no OTG master did, then
- * dcn401_optimize_bandwidth without FAMS2, SubVP or DC-mode softmax.
- */
-static const struct dcn401_commit_step bls_head_per_state_new_postamble[] = {
-	{ .func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
-	  .meta.skip_if.new_state_has_stream = true },
-	{ .func = HUBBUB_PROGRAM_WATERMARKS,
-	  .meta.hubbub_program_watermarks.safe_to_lower = true },
-	{ .func = HUBBUB_PROGRAM_ARBITER,
-	  .meta.hubbub_program_arbiter.safe_to_lower = true },
-	{ .func = HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
-	  .meta.hubbub_program_compbuf_segments.safe_to_lower = true },
-	{ .func = CLK_MGR_UPDATE_CLOCKS_FOR_STATE,
-	  .meta.clk_mgr_update_clocks_for_state.safe_to_lower = true },
-};
-
-/* The support check allows the OTG master and one MPC bottom pipe. */
-#define DCN401_MAX_DPP_PIPES 2
-
-/*
- * Bounds on what build adds. The support check allows one stream per
- * state, and never one in both.
- */
-static_assert(ARRAY_SIZE(bls_head_per_state_new) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_current_lock) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
-		bls_head_per_stream_per_dpp_pipe_current_disconnect) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_current_unlock) +
-		DCN401_MAX_DPP_PIPES * ARRAY_SIZE(
-		bls_head_per_stream_per_dpp_pipe_current_power_down) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_current_stream_off) +
-		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
-		DC2_BLS_MAX_STEPS,
-		"dcn401 commit stream-off head exceeds DC2_BLS_MAX_STEPS");
-static_assert(ARRAY_SIZE(bls_head_per_state_new) +
-		ARRAY_SIZE(bls_head_per_stream_per_otg_master_pipe_new) +
-		ARRAY_SIZE(
-		bls_head_per_stream_per_otg_master_pipe_new_front_end) +
-		ARRAY_SIZE(bls_head_per_state_new_postamble) <=
-		DC2_BLS_MAX_STEPS,
-		"dcn401 commit enable head exceeds DC2_BLS_MAX_STEPS");
-
 /*
  * Net effect: hwss_process_outstanding_hw_updates on the current state,
  * which commit_planes_for_stream runs while optimized_required is set.
@@ -1569,7 +1127,7 @@ static_assert(
 		ARRAY_SIZE(
 		bls_update_head_per_stream_per_otg_master_pipe_preamble) +
 		ARRAY_SIZE(bls_update_head_global_preamble) +
-		ARRAY_SIZE(bls_head_per_state_new) +
+		ARRAY_SIZE(bls_update_head_per_state_new_prepare_bandwidth) +
 		ARRAY_SIZE(
 		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
 		ARRAY_SIZE(bls_update_head_new_lock) +
@@ -1585,14 +1143,6 @@ static_assert(
 		ARRAY_SIZE(bls_update_head_new_dpp_mall)) <= DC2_BLS_MAX_STEPS,
 		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
 
-/* pipe is NULL only for the bandwidth and p-state steps. */
-struct dcn401_commit_step_args {
-	struct dc *dc;
-	struct dc_state *current_state;
-	struct dc_state *new_state;
-	struct pipe_ctx *pipe;
-};
-
 /* enable_stream_timing_calc: manual mode unless every span is even. */
 static bool dcn401_h_timing_div_manual_mode(
 		const struct dc_crtc_timing *timing)
@@ -2423,7 +1973,7 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 	return false;
 }
 
-static void dcn401_add_steps(struct block_sequence_state *sequence,
+void dcn401_add_steps(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *args,
 		const struct dcn401_commit_step *steps, unsigned int count)
 {
@@ -2435,9 +1985,7 @@ static void dcn401_add_steps(struct block_sequence_state *sequence,
 	}
 }
 
-/* The support check found an OTG master for each stream of state. */
-static void dcn401_add_per_otg_master(
-		struct block_sequence_state *sequence,
+void dcn401_add_per_otg_master(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
 		const struct dcn401_commit_step *steps, unsigned int count)
@@ -2446,15 +1994,13 @@ static void dcn401_add_per_otg_master(
 	unsigned int i;
 
 	for (i = 0; i < state->stream_count; i++) {
-		args.pipe = get_otg_master_from_state_by_stream(state,
-				state->streams[i]);
+		args.pipe = get_otg_master_from_state_by_stream(args.dc,
+				state, state->streams[i]);
 		dcn401_add_steps(sequence, &args, steps, count);
 	}
 }
 
-/* Each DPP pipe of each stream, the OTG master first. */
-static void dcn401_add_per_dpp_pipe(
-		struct block_sequence_state *sequence,
+void dcn401_add_per_dpp_pipe(struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
 		const struct dcn401_commit_step *steps, unsigned int count)
@@ -2463,28 +2009,14 @@ static void dcn401_add_per_dpp_pipe(
 	unsigned int i;
 
 	for (i = 0; i < state->stream_count; i++) {
-		for (args.pipe = get_otg_master_from_state_by_stream(state,
-				state->streams[i]); args.pipe;
+		for (args.pipe = get_otg_master_from_state_by_stream(args.dc,
+				state, state->streams[i]); args.pipe;
 				args.pipe = args.pipe->bottom_pipe)
 			dcn401_add_steps(sequence, &args, steps, count);
 	}
 }
 
-#define DCN401_ADD_STEPS(sequence, args, steps) \
-	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
-#define DCN401_ADD_PER_OTG_MASTER(sequence, args, state, steps) \
-	dcn401_add_per_otg_master(sequence, args, state, steps, \
-			ARRAY_SIZE(steps))
-#define DCN401_ADD_PER_DPP_PIPE(sequence, args, state, steps) \
-	dcn401_add_per_dpp_pipe(sequence, args, state, steps, \
-			ARRAY_SIZE(steps))
-
-/*
- * Points the step arguments at the states and the sequence at
- * head_sequence, both empty. The entries point into the states; the build
- * writes neither.
- */
-static void dcn401_init_and_unpack_params(
+void dcn401_init_and_unpack_params(
 		struct bls_builder_declarative_params *params,
 		struct dcn401_commit_step_args *state_args,
 		struct block_sequence_state *head)
@@ -2500,44 +2032,6 @@ static void dcn401_init_and_unpack_params(
 	head->num_steps = &params->head_num_steps;
 }
 
-static enum bls_builder_result dcn401_build_non_seamless_commit(
-		struct bls_builder_declarative_params *params)
-{
-	struct dcn401_commit_step_args state_args;
-	struct block_sequence_state head;
-	enum bls_builder_result result;
-
-	if (!params)
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
-	result = dcn401_check_non_seamless_commit_support(params->dc,
-			params->current_state, params->new_state);
-	if (result != BLS_BUILD_SUCCESS)
-		return result;
-
-	dcn401_init_and_unpack_params(params, &state_args, &head);
-	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_lock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
-			bls_head_per_stream_per_dpp_pipe_current_disconnect);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_unlock);
-	DCN401_ADD_PER_DPP_PIPE(&head, &state_args, state_args.current_state,
-			bls_head_per_stream_per_dpp_pipe_current_power_down);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
-			state_args.current_state,
-			bls_head_per_stream_per_otg_master_pipe_current_stream_off);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_head_per_stream_per_otg_master_pipe_new);
-	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
-			bls_head_per_stream_per_otg_master_pipe_new_front_end);
-	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new_postamble);
-
-	return BLS_BUILD_SUCCESS;
-}
-
 static enum bls_builder_result dcn401_build_seamless_update(
 		struct bls_builder_declarative_params *params)
 {
@@ -2558,7 +2052,8 @@ static enum bls_builder_result dcn401_build_seamless_update(
 			bls_update_head_per_stream_per_otg_master_pipe_preamble);
 	DCN401_ADD_STEPS(&head, &state_args,
 			bls_update_head_global_preamble);
-	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
+	DCN401_ADD_STEPS(&head, &state_args,
+			bls_update_head_per_state_new_prepare_bandwidth);
 	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
 			state_args.current_state,
 			bls_update_head_per_stream_per_otg_master_pipe_current_pending);
@@ -2595,26 +2090,6 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	return BLS_BUILD_SUCCESS;
 }
 
-static bool dcn401_non_seamless_commit_check_capability(
-		const struct bls_builder_check_capability_params *params)
-{
-	return params && dcn401_check_non_seamless_commit_support(params->dc,
-			params->current_state, params->new_state) ==
-			BLS_BUILD_SUCCESS;
-}
-
-const struct bls_builder *dcn401_non_seamless_commit_builder(void)
-{
-	static const struct bls_builder builder = {
-		.name = DCN_DECL_NON_SEAMLESS_COMMIT,
-		.kind = BLS_BUILDER_DECLARATIVE,
-		.check_capability = dcn401_non_seamless_commit_check_capability,
-		.build.declarative = dcn401_build_non_seamless_commit,
-	};
-
-	return &builder;
-}
-
 static bool dcn401_seamless_update_check_capability(
 		const struct bls_builder_check_capability_params *params)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
new file mode 100644
index 000000000000..d6ac474e707a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "dc_state_priv.h"
+#include "state_facts/state_facts.h"
+
+static bool trait_match(uint32_t traits, struct dc_trait_match where)
+{
+	return (traits & where.mask) == where.value;
+}
+
+static int stream_index_of(const struct dc_state *state,
+		const struct dc_stream_state *stream)
+{
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		if (state->streams[i] == stream)
+			return i;
+	}
+	return -1;
+}
+
+static uint32_t stream_traits(const struct dc_state *state, int index)
+{
+	const struct dc_stream_state *stream = state->streams[index];
+	const struct dc_link *link = stream->link;
+	uint32_t traits = 0;
+
+	if (!stream->dpms_off)
+		traits |= DC_STREAM_TRAIT_ENABLED;
+	if (state->stream_status[index].plane_count)
+		traits |= DC_STREAM_TRAIT_HAS_PLANE;
+	if (dc_state_get_stream_subvp_type(state, stream) == SUBVP_PHANTOM)
+		traits |= DC_STREAM_TRAIT_PHANTOM;
+	if (stream->signal == SIGNAL_TYPE_EDP)
+		traits |= DC_STREAM_TRAIT_EDP;
+	if (link && !link->panel_config.psr.disable_psr &&
+			(link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
+			link->psr_settings.psr_version == DC_PSR_VERSION_SU_1))
+		traits |= DC_STREAM_TRAIT_PSR;
+	if (link && link->replay_settings.replay_feature_enabled)
+		traits |= DC_STREAM_TRAIT_REPLAY;
+	if (traits & (DC_STREAM_TRAIT_PSR | DC_STREAM_TRAIT_REPLAY))
+		traits |= DC_STREAM_TRAIT_SELF_REFRESH;
+	return traits;
+}
+
+static uint32_t plane_traits(const struct dc_plane_state *plane)
+{
+	const union dc_plane_cm_flags *flags = &plane->cm.flags;
+	uint32_t traits = 0;
+
+	if (plane->address.type == PLN_ADDR_TYPE_GRAPHICS)
+		traits |= DC_PLANE_TRAIT_GRAPHICS_ADDRESS;
+	if (plane->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS)
+		traits |= DC_PLANE_TRAIT_DEGAMMA_CURVE;
+	if (flags->bits.blend_enable || flags->bits.shaper_enable ||
+			flags->bits.lut3d_enable || flags->bits.rmcm_enable)
+		traits |= DC_PLANE_TRAIT_MCM_LUTS;
+	if (plane->dcc.enable)
+		traits |= DC_PLANE_TRAIT_DCC;
+	if (plane->flip_immediate)
+		traits |= DC_PLANE_TRAIT_FLIP_IMMEDIATE;
+	return traits;
+}
+
+static uint32_t pipe_traits(const struct pipe_ctx *pipe)
+{
+	uint32_t traits = 0;
+
+	if (pipe->plane_state)
+		traits |= DC_PIPE_TRAIT_PLANE;
+	if (!pipe->top_pipe)
+		traits |= DC_PIPE_TRAIT_MPC_TOP;
+	if (pipe->next_odm_pipe || pipe->prev_odm_pipe)
+		traits |= DC_PIPE_TRAIT_ODM;
+	if (pipe->stream_res.tg && pipe->stream_res.opp &&
+			pipe->stream_res.stream_enc)
+		traits |= DC_PIPE_TRAIT_STREAM_RESOURCES;
+	if (pipe->clock_source)
+		traits |= DC_PIPE_TRAIT_PIXEL_CLOCK;
+	if (pipe->plane_res.hubp && pipe->plane_res.dpp &&
+			pipe->plane_res.mpcc_inst < MAX_MPCC)
+		traits |= DC_PIPE_TRAIT_PLANE_RESOURCES;
+	if (pipe->wait_is_required)
+		traits |= DC_PIPE_TRAIT_WAIT;
+	if (pipe->stream_res.abm)
+		traits |= DC_PIPE_TRAIT_ABM;
+	if (pipe->stream_res.audio)
+		traits |= DC_PIPE_TRAIT_AUDIO;
+	if (pipe->stream_res.dsc)
+		traits |= DC_PIPE_TRAIT_DSC;
+	if (pipe->stream_res.gsl_group)
+		traits |= DC_PIPE_TRAIT_GSL;
+	return traits;
+}
+
+static void derive_blend_tree(const struct dc_state *state,
+		struct dc_state_facts *out, int stream_index)
+{
+	const struct pipe_ctx *master = NULL;
+	const struct pipe_ctx *pipe;
+	unsigned int count = 0;
+	bool on_blocks = true;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &state->res_ctx.pipe_ctx[i];
+		if (pipe->stream != state->streams[stream_index])
+			continue;
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe)
+			master = pipe;
+	}
+	if (!master)
+		return;
+	for (pipe = master; pipe; pipe = pipe->bottom_pipe) {
+		count++;
+		if (pipe != master &&
+				(pipe->stream_res.tg != master->stream_res.tg ||
+				pipe->stream_res.opp != master->stream_res.opp))
+			on_blocks = false;
+	}
+	out->global.blend_tree[stream_index].dpp_pipe_count = (uint8_t)count;
+	out->global.blend_tree[stream_index].on_otg_master_blocks = on_blocks;
+}
+
+static void derive_composite(struct dc_state_facts *out)
+{
+	struct dc_trait_match active = DC_STREAM_MATCH_ACTIVE;
+
+	out->composite.has_active_stream =
+			dc_state_facts_any_stream(out, active);
+	out->composite.has_active_edp = dc_state_facts_any_stream(out,
+			DC_TRAIT_MATCH(DC_STREAM_TRAIT_ENABLED |
+			DC_STREAM_TRAIT_HAS_PLANE | DC_STREAM_TRAIT_EDP,
+			DC_STREAM_TRAIT_PHANTOM));
+	out->composite.has_active_non_edp = dc_state_facts_any_stream(out,
+			DC_TRAIT_MATCH(DC_STREAM_TRAIT_ENABLED |
+			DC_STREAM_TRAIT_HAS_PLANE,
+			DC_STREAM_TRAIT_PHANTOM | DC_STREAM_TRAIT_EDP));
+	out->composite.has_only_active_edp =
+			out->composite.has_active_stream &&
+			!out->composite.has_active_non_edp;
+	out->composite.has_active_edp_without_self_refresh =
+			dc_state_facts_any_stream(out,
+			DC_TRAIT_MATCH(DC_STREAM_TRAIT_ENABLED |
+			DC_STREAM_TRAIT_HAS_PLANE | DC_STREAM_TRAIT_EDP,
+			DC_STREAM_TRAIT_PHANTOM | DC_STREAM_TRAIT_SELF_REFRESH));
+	out->composite.has_only_active_edp_with_self_refresh =
+			out->composite.has_active_stream &&
+			dc_state_facts_all_stream(out, active,
+			DC_TRAIT_MATCH(DC_STREAM_TRAIT_EDP |
+			DC_STREAM_TRAIT_SELF_REFRESH, 0));
+}
+
+void dc_state_facts_derive(const struct dc_state *state,
+		struct dc_state_facts *out)
+{
+	int i;
+	int s;
+
+	memset(out, 0, sizeof(*out));
+	if (state->power_source == DC_POWER_SOURCE_DC)
+		out->state |= DC_STATE_TRAIT_DC_POWER;
+
+	out->stream.count = state->stream_count;
+	for (i = 0; i < state->stream_count; i++) {
+		out->stream.entry[i].traits = stream_traits(state, i);
+		derive_blend_tree(state, out, i);
+		for (s = 0; s < state->stream_status[i].plane_count; s++) {
+			struct dc_plane_facts *plane =
+					&out->plane.entry[out->plane.count++];
+
+			plane->traits = plane_traits(
+					state->stream_status[i].plane_states[s]);
+			plane->stream_index = (uint8_t)i;
+		}
+	}
+	for (i = 0; i < MAX_PIPES; i++) {
+		const struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+		struct dc_pipe_facts *facts;
+		int index;
+
+		if (!pipe->stream)
+			continue;
+		index = stream_index_of(state, pipe->stream);
+		if (index < 0)
+			continue;
+		facts = &out->pipe.entry[out->pipe.count++];
+		facts->traits = pipe_traits(pipe);
+		facts->pipe_index = (uint8_t)i;
+		facts->stream_index = (uint8_t)index;
+	}
+	derive_composite(out);
+}
+
+bool dc_state_facts_any_stream(const struct dc_state_facts *f,
+		struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->stream.count; i++) {
+		if (trait_match(f->stream.entry[i].traits, where))
+			return true;
+	}
+	return false;
+}
+
+bool dc_state_facts_all_stream(const struct dc_state_facts *f,
+		struct dc_trait_match among, struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->stream.count; i++) {
+		if (!trait_match(f->stream.entry[i].traits, among))
+			continue;
+		if (!trait_match(f->stream.entry[i].traits, where))
+			return false;
+	}
+	return true;
+}
+
+static bool in_stream(uint8_t entry_stream, uint8_t stream_index)
+{
+	return stream_index == DC_FACTS_ALL_STREAMS ||
+			entry_stream == stream_index;
+}
+
+bool dc_state_facts_any_plane(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->plane.count; i++) {
+		if (!in_stream(f->plane.entry[i].stream_index, stream_index))
+			continue;
+		if (trait_match(f->plane.entry[i].traits, where))
+			return true;
+	}
+	return false;
+}
+
+bool dc_state_facts_all_plane(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match among,
+		struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->plane.count; i++) {
+		if (!in_stream(f->plane.entry[i].stream_index, stream_index))
+			continue;
+		if (!trait_match(f->plane.entry[i].traits, among))
+			continue;
+		if (!trait_match(f->plane.entry[i].traits, where))
+			return false;
+	}
+	return true;
+}
+
+bool dc_state_facts_any_pipe(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->pipe.count; i++) {
+		if (!in_stream(f->pipe.entry[i].stream_index, stream_index))
+			continue;
+		if (trait_match(f->pipe.entry[i].traits, where))
+			return true;
+	}
+	return false;
+}
+
+bool dc_state_facts_all_pipe(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match among,
+		struct dc_trait_match where)
+{
+	uint8_t i;
+
+	for (i = 0; i < f->pipe.count; i++) {
+		if (!in_stream(f->pipe.entry[i].stream_index, stream_index))
+			continue;
+		if (!trait_match(f->pipe.entry[i].traits, among))
+			continue;
+		if (!trait_match(f->pipe.entry[i].traits, where))
+			return false;
+	}
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
new file mode 100644
index 000000000000..b8a8b8256262
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dc.h"
+
+struct dc_state;
+
+/* Matches a trait mask t when (t & mask) == value. */
+struct dc_trait_match {
+	uint32_t mask;
+	uint32_t value;
+};
+
+/* Traits in set present and traits in clear absent. */
+#define DC_TRAIT_MATCH(set, clear) \
+	((struct dc_trait_match){ .mask = (set) | (clear), .value = (set) })
+
+/* Plane and pipe accessors: no stream filter. */
+#define DC_FACTS_ALL_STREAMS 0xFFu
+
+enum dc_state_trait {
+	DC_STATE_TRAIT_DC_POWER        = 1u << 0,
+};
+
+enum dc_stream_trait {
+	DC_STREAM_TRAIT_ENABLED        = 1u << 0,
+	DC_STREAM_TRAIT_HAS_PLANE      = 1u << 1,
+	DC_STREAM_TRAIT_PHANTOM        = 1u << 2,
+	DC_STREAM_TRAIT_EDP            = 1u << 3,
+	DC_STREAM_TRAIT_PSR            = 1u << 4,
+	DC_STREAM_TRAIT_REPLAY         = 1u << 5,
+	DC_STREAM_TRAIT_SELF_REFRESH   = 1u << 6,
+};
+
+#define DC_STREAM_MATCH_ACTIVE \
+	DC_TRAIT_MATCH(DC_STREAM_TRAIT_ENABLED | DC_STREAM_TRAIT_HAS_PLANE, \
+			DC_STREAM_TRAIT_PHANTOM)
+
+enum dc_plane_trait {
+	DC_PLANE_TRAIT_GRAPHICS_ADDRESS = 1u << 0,
+	DC_PLANE_TRAIT_DEGAMMA_CURVE    = 1u << 1,
+	DC_PLANE_TRAIT_MCM_LUTS         = 1u << 2,
+	DC_PLANE_TRAIT_DCC              = 1u << 3,
+	DC_PLANE_TRAIT_FLIP_IMMEDIATE   = 1u << 4,
+};
+
+enum dc_pipe_trait {
+	DC_PIPE_TRAIT_PLANE             = 1u << 0,
+	DC_PIPE_TRAIT_MPC_TOP           = 1u << 1,
+	DC_PIPE_TRAIT_ODM               = 1u << 2,
+	DC_PIPE_TRAIT_STREAM_RESOURCES  = 1u << 3,
+	DC_PIPE_TRAIT_PIXEL_CLOCK       = 1u << 4,
+	DC_PIPE_TRAIT_PLANE_RESOURCES   = 1u << 5,
+	DC_PIPE_TRAIT_WAIT              = 1u << 6,
+	DC_PIPE_TRAIT_ABM               = 1u << 7,
+	DC_PIPE_TRAIT_AUDIO             = 1u << 8,
+	DC_PIPE_TRAIT_DSC               = 1u << 9,
+	DC_PIPE_TRAIT_GSL               = 1u << 10,
+};
+
+struct dc_stream_facts {
+	uint32_t traits;
+};
+
+struct dc_plane_facts {
+	uint32_t traits;
+	uint8_t  stream_index;
+};
+
+struct dc_pipe_facts {
+	uint32_t traits;
+	uint8_t  pipe_index;
+	uint8_t  stream_index;
+};
+
+struct dc_state_composite_facts {
+	bool has_active_stream;
+	bool has_active_edp;
+	bool has_active_non_edp;
+	bool has_only_active_edp;
+	bool has_active_edp_without_self_refresh;
+	bool has_only_active_edp_with_self_refresh;
+};
+
+struct dc_blend_tree_facts {
+	uint8_t dpp_pipe_count;
+	bool    on_otg_master_blocks;
+};
+
+struct dc_state_global_facts {
+	struct dc_blend_tree_facts blend_tree[MAX_PIPES];
+};
+
+struct dc_state_facts {
+	uint32_t state;
+	struct {
+		uint8_t                count;
+		struct dc_stream_facts entry[MAX_PIPES];
+	} stream;
+	struct {
+		uint8_t                count;
+		struct dc_plane_facts  entry[MAX_PIPES * MAX_SURFACES];
+	} plane;
+	struct {
+		uint8_t                count;
+		struct dc_pipe_facts   entry[MAX_PIPES];
+	} pipe;
+	struct dc_state_composite_facts composite;
+	struct dc_state_global_facts    global;
+};
+
+void dc_state_facts_derive(const struct dc_state *state,
+		struct dc_state_facts *out);
+
+bool dc_state_facts_any_stream(const struct dc_state_facts *f,
+		struct dc_trait_match where);
+bool dc_state_facts_all_stream(const struct dc_state_facts *f,
+		struct dc_trait_match among, struct dc_trait_match where);
+bool dc_state_facts_any_plane(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match where);
+bool dc_state_facts_all_plane(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match among,
+		struct dc_trait_match where);
+bool dc_state_facts_any_pipe(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match where);
+bool dc_state_facts_all_pipe(const struct dc_state_facts *f,
+		uint8_t stream_index, struct dc_trait_match among,
+		struct dc_trait_match where);
-- 
2.43.0

