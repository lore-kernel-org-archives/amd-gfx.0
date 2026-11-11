Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642B606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0vhYSP2a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9337E10F8EF;
	Wed, 11 Nov 2026 01:44:31 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E804310F8EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0MH/Rq6N/6JB37hIDoRMjb4DdGOdf5ttH6mb57ymOoLqo8vsOhSgmzGaEL3UJHn3h8oQ1/29UweGHvMF5QWmv44Y13+PzNbe1sQAQqtfj0k253fGDtRHnmG05NXjGrAaaH+R18gczdnSP3DfTxHf+Io39s3eDf000WJfJYBzMeDHxsICrKUiEhvr/4NH8a3Z6H+9lycIIIu38mi7Wy3zDM7hEBFNCuw3toLXbbx59EsZTUdWB9KYBhDk81hn5Ju7X9+sGR2Ra7gQLRhUnkr81b4zLncih1wsytMEAkOeAVPsRcbiqTJGKF//alzc8zHwL5je1yD4GNonATlOfmKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLEnhqkFHa8gSpVVJSAnf3Tf74HmTBjhIisfNEE7HU4=;
 b=d4VtcCZJyCLMbLQPmmx+VHmdiyBWZVdBNj2pvQRBlqHZc3jbUeAGIMBFecOBAWSLXK0IPdN1O6JYhy28Pa23yrPtGHxZw2wSrsi7nL2Q2olSJIbCfkd4LWMzQM6ss7F1ItuBXxZCDxlKYiGtRi0HVt333dxcgWhd+xtp3xTndn7uDxdgB7GIM7aJi8s5qvep6fA+o+z3cnYx9dAC7Btyf361OFeeyX3fKfZVCm4QdueZ8Ng+/iZ6dKHkpAIUlgERSG4sJs3kTfcryM6+3r9TYsqBv2koXxsMZSAcYPX4j+K7QneppJRw8r9v2tk0SkarhwUb6/tpGq3elJUfTOWIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLEnhqkFHa8gSpVVJSAnf3Tf74HmTBjhIisfNEE7HU4=;
 b=0vhYSP2aipiApXE9WG//WnlZZgNiT6GjvetKnaNcSAVF2c4YyDHlcURrtrWWplmP3UL5rczAEtJuOewfDMmEXOaNyEo17TOcKtgwKQsy3ifNT3x/dkTAHSARofIRbbvt5JFoh2hO1Vq/BHA/0CnVTXWzsz3phGJdw3BJQafdvl8=
Received: from CH0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:610:119::17)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:42:14 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::43) by CH0PR03CA0368.outlook.office365.com
 (2603:10b6:610:119::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:13 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:10 -0600
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
Subject: [PATCH 29/74] drm/amd/display: Read accelerated mode through a query
 builder
Date: Wed, 11 Nov 2026 09:28:35 +0800
Message-ID: <20261111014100.3596072-30-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3f5e1c-9d27-4745-0513-08df3f950309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261009223027099003|11063799006|56012099006|261028144727099003|261021121427099003|261021123027099003|261009221227099003|10067099003|261026140227099003|261022105027099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: O02bcHe2ZgLnSBb4cKFz3msU6B6L1aqSw0UxjmIVbhwsJ8NicgQcNAXQ8pdr2ygtsCv1Gkz9ImkFzBFRy40PBLO2H0PgqIMvOOlt92oTlF6vwzKdfTkXIE0lKfI2RdGj/VRYa115Y9vZZTqxtaKXKYUoTH0Z5D6FdQbBT6GLGS1DVPSOCSzBihoPrCKb0d/Zb0oVKL19F+K0J99/luFbrE4V7dqdgbCVQ0E8g6H7WA6OgxbtoeGxV0I2CyB0JQ4C2OKLMbf3NZJbFNl+06ILtl/An2jNY4AXfsoJQp+9rLCVgFo5YpgjAO0fQ8ej7GKMaglBtH8rJB30Yni08pEKZ91R8b7iECXHYu6r+hc6Y1sZOlZA/52/h4YREsFTdAVHOsKv0B4wlMU0g7gXQ6jz0OBXv9JklgX4Lttg4gI3Wmc5Eqxsb6hFzmgC9yAZUwL3gFl2bWtDRNIn1+A6B2se9yjSvksRpMJHeTp2fzWaXe7C057XLHRqfl407hqu3s9YezYP6rUpuzioj0E7EZ/lYpeM/lnzzZSsvtPWx/o5UI4Tsm2fIjn/Iak0oGf5/qNqGC3PjQr7n/1BMB00FaN9A6QfeXpjFDeSv/z28O6hIkUiTHmjARPFCXrNuW37EXEK53lJ7AN6nYv69wRFtES7Hy/BmmpQqas7wmb6wKTFSvFE0/uHQPOKXKNiCaD6P4H7qwWLrtR0pxxIVSiLBZUqmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261021123027099003)(261009221227099003)(10067099003)(261026140227099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Myr6JIoF7ycifcWrqmtVOh7A2GnirwGpdGR6g5tlszfV3k7Kvd2EUgu9HRbEJtZR41UN5tc3aN/av5lIJv3WA8fAtyKRuFTG5wBuNU4mJzYIj6omPjfvKyKXucd+8BVqtZcDYRts3vInY1EUfoMwu/MMTGWLM/I/oqFJp/FPP51uwwFB5Poi5QRRzYYX9bDyM+IoyKeOCuTgWlB3eauAXaFvGyaNNpVl6k/4yH366ZiUhAzG7RDHPtWnLxkzBZ+1roPtFhJknjc9JdYKRSGczLrcjWSA1ZswmV+QNLdpriu+oNTBOskj9C8gUifP6jB63f4xotVmV4ZpfVw7KB6ECSjzl3n84fdL+HKouY9wv2Nl4ZGQbsl+QZAVeaLZQjbprDi0XYHbyJaMvvryoQq+6t8kk1KNBfsohyEd+u0c9Cc19VbaFJAQhoixbUmJu6B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:14.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3f5e1c-9d27-4745-0513-08df3f950309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671
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
DC2 read the VBIOS accelerated-mode bit with a direct BIOS call. The
core layer must not access hardware.

[How]
Add a query builder that emits one accelerated-mode read into an output
target. The core layer builds and executes it in place before it accepts
a commit or an update.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |  2 +
 .../dc/bls_builder/dcn401_init_builder.c      | 32 +++++++++++
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 53 +++++++++++++------
 3 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 954adc590ed4..9a3907bf950a 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -26,6 +26,7 @@ enum bls_builder_name {
 	DCN_DECL_INITIALIZATION_LEGACY,
 	DCN_DECL_NON_SEAMLESS_COMMIT,
 	DCN_DECL_SEAMLESS_UPDATE,
+	DCN_DECL_QUERY_ACCELERATED_MODE,
 	BLS_BUILDER_NAME_COUNT,
 };
 
@@ -51,6 +52,7 @@ struct bls_builder_output_targets {
 	union {
 		struct bls_builder_output_init *DCN_DECL_INITIALIZATION;
 		struct bls_builder_legacy_hw_init_info *DCN_DECL_INITIALIZATION_LEGACY;
+		bool *DCN_DECL_QUERY_ACCELERATED_MODE;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 75fd4be3690a..1dc502c0839c 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -386,6 +386,31 @@ static enum bls_builder_result dcn401_build_initialization(
 	return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 }
 
+/* Reads the VBIOS accelerated-mode bit into the caller's out-target. */
+static enum bls_builder_result dcn401_build_accelerated_mode_query(
+		struct bls_builder_declarative_params *params)
+{
+	union block_sequence_params bls_params = {0};
+	struct block_sequence_state sequence;
+	struct dc_bios *dcb;
+
+	if (!params || !params->dc || !params->dc->ctx || !params->out_targets ||
+			!params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	dcb = params->dc->ctx->dc_bios;
+	if (!dcb || !dcb->funcs || !dcb->funcs->is_accelerated_mode)
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+
+	sequence.steps = params->head_sequence;
+	sequence.num_steps = &params->head_num_steps;
+	bls_params.bios_is_accelerated_mode_params.dcb = dcb;
+	bls_params.bios_is_accelerated_mode_params.out_accelerated_mode =
+			params->out_targets->DCN_DECL_QUERY_ACCELERATED_MODE;
+	if (!bls_append(&sequence, BIOS_IS_ACCELERATED_MODE, &bls_params))
+		return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+	return BLS_BUILD_SUCCESS;
+}
+
 const struct bls_builder *dcn401_bls_builder_create(
 		enum bls_builder_name name)
 {
@@ -401,6 +426,11 @@ const struct bls_builder *dcn401_bls_builder_create(
 		.check_capability = dcn401_dc1_initialization_check_capability,
 		.build.declarative = dcn401_build_dc1_initialization,
 	};
+	static const struct bls_builder accelerated_mode_query_builder = {
+		.name = DCN_DECL_QUERY_ACCELERATED_MODE,
+		.kind = BLS_BUILDER_DECLARATIVE,
+		.build.declarative = dcn401_build_accelerated_mode_query,
+	};
 
 	switch (name) {
 	case DCN_DECL_INITIALIZATION:
@@ -411,6 +441,8 @@ const struct bls_builder *dcn401_bls_builder_create(
 		return dcn401_non_seamless_commit_builder();
 	case DCN_DECL_SEAMLESS_UPDATE:
 		return dcn401_seamless_update_builder();
+	case DCN_DECL_QUERY_ACCELERATED_MODE:
+		return &accelerated_mode_query_builder;
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 052f29df1797..295d2d8b277e 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -53,20 +53,6 @@ void core2_destruct(struct dc *dc)
 	(void)dc;
 }
 
-/*
- * The VBIOS scratch read legacy_commit_state_hw makes
- * before it enables accelerated mode. The commit has no accelerated-mode
- * entries, so it runs only after init has left VBIOS mode. Remove when a
- * BLC exposes the accelerated-mode bit.
- */
-static bool core2_is_accelerated_mode(struct dc *dc)
-{
-	struct dc_bios *dcb = dc->ctx->dc_bios;
-
-	return dcb && dcb->funcs && dcb->funcs->is_accelerated_mode &&
-			dcb->funcs->is_accelerated_mode(dcb);
-}
-
 static struct pipe_ctx *core2_otg_master(struct dc_state *state)
 {
 	unsigned int i;
@@ -105,6 +91,43 @@ static bool core2_run_commit_sequence(struct dc *dc,
 			result == DC2_BLS_EXEC_CONTINUED_ON_ERROR;
 }
 
+/*
+ * legacy_commit_state_hw reads this bit before it enables accelerated
+ * mode. The commit and the update have no accelerated-mode entries, so
+ * they run only after init has left VBIOS mode.
+ */
+static bool core2_query_accelerated_mode(struct dc *dc)
+{
+	const struct bls_builder *builder =
+			TO_DC2(dc)->builders[DCN_DECL_QUERY_ACCELERATED_MODE];
+	const struct workaround_manager *wam = dc2_workaround_manager_get();
+	struct bls_builder_output_targets out_targets = {0};
+	struct bls_builder_declarative_params *params;
+	bool accelerated_mode = false;
+
+	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
+			!builder->build.declarative || !wam)
+		return false;
+
+	/* 256 block-sequence entries; keep them off the kernel stack. */
+	params = kvzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return false;
+	params->dc = dc;
+	params->current_state = dc->current_state;
+	out_targets.DCN_DECL_QUERY_ACCELERATED_MODE = &accelerated_mode;
+	params->out_targets = &out_targets;
+
+	if (builder->build.declarative(params) != BLS_BUILD_SUCCESS ||
+			params->tail_num_steps ||
+			!core2_run_commit_sequence(dc, builder, wam,
+			params->head_sequence, &params->head_num_steps))
+		accelerated_mode = false;
+
+	kvfree(params);
+	return accelerated_mode;
+}
+
 /*
  * dcn401_prepare_bandwidth's optimized_required writes. The Executor ORs
  * in the watermark and arbiter results.
@@ -196,7 +219,7 @@ static bool core2_builder_supports(struct dc *dc, enum bls_builder_name name,
 			builder->build.declarative &&
 			dc2_workaround_manager_get() &&
 			builder->check_capability(&check) &&
-			core2_is_accelerated_mode(dc);
+			core2_query_accelerated_mode(dc);
 }
 
 /* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
-- 
2.43.0

