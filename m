Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AA606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bQDTMs3a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6512110F8AC;
	Wed, 11 Nov 2026 01:40:55 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6035710F8AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaxUfHg/nXjlPpLD/JOpUl+/Cfwv9Wy9BL30N95T/UA3k/ei9MK/QR3dQv6VEarT3OUVrb4zwj8Bb8PMPj/3WzYyE2sG0/Refw5fhH/O0ND7cQQPN0/gAhnXMQjo18lSK3qHn/rmKmzLnanZQ2EU4/qgMIacF4lReq2OqtnnRxs0ys1ylyua9u/HLol2PVay9oCuQBKjn2YTZ1bkMe66UOv1z8eTCWtMvVZble2LsNVb28xausWP0pJQ8JbCHRnMfj2zU9DgjIJ+fwrv8NuwUvR1pHoVN1EbV8ksHmiUvhW2MW8QZ8VHkRgyepgdTfGZTlV0wQAzi733sFCsYgQ6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zY2NGwQ1NIFvj7aXYOKr3LT0Yt7Rvk9agtS8H1mn9A=;
 b=OVqtW34LhjK6YJVzXrgWeaE6EwdZXU2IEFEai141zjxTq6jccroMRVqUxvo99bsCcfIPyJo0Hpm+RCGttUlDAD821+8Mf+ZGrGR5XtPMD4MsOIApvVpaNYBh4DzHzvMUngKCiOpx1ntW1yimm5refxgfP+Yah4ITYOCDo8kAFQkvRWL3NIPIJFEslH3syr1DZM8XeRtMURlK30gyauuNGG6VUvGJMrY6XQ2kHXLG+utgdEsM/6QeXS9x1OZFO5Ag37QBC9kPnWb4UdZk6/uRP74orOLiSJ8q9+Pt0diPkroKsLMIZDQqHRVr3FtXEuhZuQyd0t6GxXoz+L4CtNPY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zY2NGwQ1NIFvj7aXYOKr3LT0Yt7Rvk9agtS8H1mn9A=;
 b=bQDTMs3ayRUot/UwiXGbUoDZfp2nBjpiAc4jrDhTjdM/D+l+v39C0fX02Nokm0XZYbjn2xcBCVyYeMoQeNv42gIpFdPScLwYkgPh+gr1Dus6eefNauhEd5M4BWldGt7WgMiUQCGgfcbcnBTPN2udVB48/ioGCJ6Ql4SnaqoIUHw=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:40:43 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::18) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:42 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:38 -0600
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
Subject: [PATCH 05/74] drm/amd/display: Dispatch commit_state_hw through
 dc2_funcs
Date: Wed, 11 Nov 2026 09:28:11 +0800
Message-ID: <20261111014100.3596072-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfce6c4-24ee-4193-cb26-08df3f94cc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|6133799003|10067099003|11063799006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|56012099006|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: j9koMrRWyn/M3tv34eI9at+r9oY7sU1ZKCbibuaWkBLwqZTBLs27hjk+FCXDz22nD6ni0Gk1SwL5KQZag/qvWuk+Hzlbh5ZDA8+7szN1IbVfV8ZjRX6FRWDcIJPrcEQ3+opRhiSmp2OVz38uaC+wwz9CxV5T1frDkBbG/FwSPdfuVDiBV4bZ42/UioEb4QViq5uiX64x1lTQKcwo8exFZ4jriYlop2mcivIsWwKljJ4iMhvgYBaXb+3azcCqTUUmCI1mTXpiYCcXlQRY6NPY6djFSNSMVJI3suzwE99NjtOZwIjyXsAbGhLJexhAx8BJoOHYdJDYbgC0NJd5GtRYLZb66bNGLOoPcdHCmMupr92MkSu/1yOsYEAw6BGF3CwVzERpJgpCyVtFt4GRWXxxdTWrMGfOUXyc87CrkP0KqUtJS9B9LzPJIhTyOCHgPI+7wSNsw7QArSGwaYobQgIdz7LjL7lqqZLZY2TIIZ2hBnDQSt/9ZlSrnp55tApsXAqJLy1fl/vz9MGkUFxU7F1m0EBGuyUone3zwQj5JAB9/Nm0b1erinCH6JtIrxSDQ393GKC6B4D1+5F7XNgese15CJZL+4CKzolqQT5/6sKoBAvCG1IDcWroCBRcoxQkUInrGsUuis3fhwodpLNAx2Qn/a9CkYXkJKFhbUhAg8WSa4wyfXlNYzRftct1hfebGHnEA/bnco3krQwtDly3NTrhjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(56012099006)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: chr0nuGSiNuRQA5JStykfN+emU291Ok10D3AvJ0u14AAW8axN1f29uvlPOYLdeXX8cyJUqtL91qiRpK8u214bCVU/4H1QiCbfz6LmGf9wl+aOjIPIA3uZgQvn1a+uGXiNtKwfT4HXtBRRwzB93ZjnEeg4wQpQ6acGl9LV4/hb3ijeJGQKfiwZAx3LiHJqY413GYIa94LUwsHOekiSu8TPvJubNaFCnuE/u7GjPcM/RvCCTpPEy7Udt6j3N/g9PcVxEHwG9eFGNYYoggRUqZo++B4AiuvXBLR0O1OHLdzLcfe41Xvq5F7qKq7nx3uOH2CPytJLrsKvj7k7IUI/7QgN8Og2wG14wnqG9+J+gLSk1En6O1MvpWl217tJB07nWP2rucnrnDDFXlH9Mzv70ngkiJoRdnSKyDIfNKbxpznRdT3yWpQ78T4OBUxYDp1l2AA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:42.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfce6c4-24ee-4193-cb26-08df3f94cc88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

dc_commit_state_no_check is one function, so Core2 has no place to
run the hardware span of a commit. Calling that span from Core2
would put a DC1 helper on the Core2 path, which a native commit is
not allowed to do. A Core2 display therefore cannot be lit, and a
native builder has nowhere to attach.

Split the hardware span out as legacy_commit_state_hw and dispatch
it through commit_state_hw on dc2_funcs. The shim calls the Core2
function only when DC2_SELECTION_CORE2 is set. Every other
selection keeps the prologue, the legacy span and the epilogue,
including the early return when the hardware span fails.

core2_commit_state_hw returns DC_NOT_SUPPORTED and does not fall
back to DC1. The builders a later native commit needs are created
once in core2_construct and stored on struct dc2. Hardware init
reads that table instead of calling the factory again. A DCN with
no builder factory keeps NULL slots.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 46 ++++++++++++-------
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 17 ++++++-
 .../gpu/drm/amd/display/dc/core2/dc_core2.h   |  1 +
 .../drm/amd/display/dc/core2/dc_core2_init.c  |  2 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |  2 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |  7 +++
 .../amd/display/dc/dc_api_dispatch/api_shim.h |  5 +-
 .../amd/display/dc/inc/dc_core_interface.h    |  5 ++
 8 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8344d821d2e8..6b90c88b6cc3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2348,31 +2348,17 @@ static void determine_pipe_unlock_order(struct dc *dc, struct dc_state *context)
 	}
 }
 
-/**
- * dc_commit_state_no_check - Apply context to the hardware
- *
- * @dc: DC object with the current status to be updated
- * @context: New state that will become the current status at the end of this function
- *
- * Applies given context to the hardware and copy it into current context.
- * It's up to the user to release the src context afterwards.
- *
- * Return: an enum dc_status result code for the operation
- */
-static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *context)
+/* Hardware span of a commit. The API shim picks Core2 or this body. */
+enum dc_status legacy_commit_state_hw(struct dc *dc, struct dc_state *context)
 {
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	struct pipe_ctx *pipe;
 	unsigned int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
-	struct dc_state *old_state;
 	bool subvp_prev_use = false;
 	bool dmub_locked = false;
 
-	dc_z10_restore(dc);
-	dc_allow_idle_optimizations(dc, false);
-
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -2564,6 +2550,33 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, true);
 
+	return result;
+}
+
+/**
+ * dc_commit_state_no_check - Apply context to the hardware
+ *
+ * @dc: DC object with the current status to be updated
+ * @context: New state that will become the current status at the end of this function
+ *
+ * Applies given context to the hardware and copy it into current context.
+ * It's up to the user to release the src context afterwards.
+ *
+ * Return: an enum dc_status result code for the operation
+ */
+static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *context)
+{
+	enum dc_status result;
+	unsigned int i;
+	struct dc_state *old_state;
+
+	dc_z10_restore(dc);
+	dc_allow_idle_optimizations(dc, false);
+
+	result = api_shim_commit_state_hw(dc, context);
+	if (result != DC_OK)
+		return result;
+
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
 		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 	else
@@ -6771,6 +6784,7 @@ void legacy_hardware_release(struct dc *dc)
 static const struct dc2_funcs dc2_legacy_funcs_table = {
 	.hardware_init = legacy_hardware_init,
 	.hardware_release = legacy_hardware_release,
+	.commit_state_hw = legacy_commit_state_hw,
 };
 
 const struct dc2_funcs *dc2_legacy_funcs(void)
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index f496e4d66575..8ef078e01dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -7,6 +7,7 @@
 #include "dc.h"
 #include "core2/dc_core2.h"
 #include "core2/dc_core2_init.h"
+#include "dc_api_dispatch/api_shim.h"
 
 static void core2_hardware_release(struct dc *dc)
 {
@@ -16,6 +17,7 @@ static void core2_hardware_release(struct dc *dc)
 static const struct dc2_funcs core2_funcs_table = {
 	.hardware_init = core2_hardware_init,
 	.hardware_release = core2_hardware_release,
+	.commit_state_hw = core2_commit_state_hw,
 };
 
 const struct dc2_funcs *core2_funcs(void)
@@ -25,10 +27,23 @@ const struct dc2_funcs *core2_funcs(void)
 
 void core2_construct(struct dc *dc)
 {
-	(void)dc;
+	struct dc2 *dc2 = TO_DC2(dc);
+	unsigned int name;
+
+	for (name = 0; name < BLS_BUILDER_NAME_COUNT; name++)
+		dc2->builders[name] = bls_builder_create(dc, name);
 }
 
 void core2_destruct(struct dc *dc)
 {
 	(void)dc;
 }
+
+/* Never falls back to legacy_commit_state_hw: DC2 must not call DC1. */
+enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context)
+{
+	(void)dc;
+	(void)context;
+
+	return DC_NOT_SUPPORTED;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
index a761e85a9973..7537863dcda4 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
@@ -15,5 +15,6 @@ struct dc_core2 {
 
 /* Core2-local; selection lives in the API shim, not here. */
 const struct dc2_funcs *core2_funcs(void);
+enum dc_status core2_commit_state_hw(struct dc *dc, struct dc_state *context);
 void core2_construct(struct dc *dc);
 void core2_destruct(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
index 69a376351df1..319aa3e219d2 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -42,7 +42,7 @@ static void core2_run_native_hardware_init(struct dc *dc)
 	const struct bls_builder *builder;
 	enum bls_builder_result result;
 
-	builder = bls_builder_create(dc, DCN_DECL_INITIALIZATION);
+	builder = TO_DC2(dc)->builders[DCN_DECL_INITIALIZATION];
 	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
 			!builder->build.declarative)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
index 285dfc9e6e69..760cb25e9cbe 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
@@ -199,7 +199,7 @@ bool core2_run_legacy_hardware_init(struct dc *dc,
 	info = &dc->current_state->hw_init_info;
 	memset(info, 0, sizeof(*info));
 	info->next_stage = LEGACY_INIT_STAGE_CLOCKS;
-	builder = bls_builder_create(dc, DCN_DECL_INITIALIZATION_LEGACY);
+	builder = TO_DC2(dc)->builders[DCN_DECL_INITIALIZATION_LEGACY];
 	if (!builder || builder->kind != BLS_BUILDER_DECLARATIVE ||
 			!builder->build.declarative)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
index 3dcfde8308c5..eca9b2de92fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
@@ -30,3 +30,10 @@ void dc_hardware_release(struct dc *dc)
 	else
 		legacy_hardware_release(dc);
 }
+
+enum dc_status api_shim_commit_state_hw(struct dc *dc, struct dc_state *context)
+{
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		return core2_funcs()->commit_state_hw(dc, context);
+	return legacy_commit_state_hw(dc, context);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
index b972ae06663d..6d9ad4192296 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -7,7 +7,7 @@
 
 #include "dc.h"
 #include "inc/dc_core_interface.h"
-#include "bls_builder/dmub_abi.h"
+#include "bls_builder/bls_builder.h"
 
 struct dc2 {
 	/* First member: TO_DC2 is a typed upcast, not container_of. */
@@ -16,8 +16,11 @@ struct dc2 {
 	/* Resolved by hardware init; later builds take it as dmub_abi. */
 	struct dmub_abi dmub_abi;
 	bool dmub_abi_resolved;
+	/* Set once by core2_construct; NULL where this DCN has no builder. */
+	const struct bls_builder *builders[BLS_BUILDER_NAME_COUNT];
 };
 
 #define TO_DC2(ptr) ((struct dc2 *)(ptr))
 
 void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params);
+enum dc_status api_shim_commit_state_hw(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
index 35a6218c1285..383d14af91f1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
@@ -5,7 +5,10 @@
 
 #pragma once
 
+#include "core_status.h"
+
 struct dc;
+struct dc_state;
 
 /*
  * Construction-time Core implementation selection. Zero is LEGACY so existing
@@ -24,8 +27,10 @@ enum dc2_hw_ownership {
 struct dc2_funcs {
 	void (*hardware_init)(struct dc *dc);
 	void (*hardware_release)(struct dc *dc);
+	enum dc_status (*commit_state_hw)(struct dc *dc, struct dc_state *context);
 };
 
 void legacy_hardware_init(struct dc *dc);
 void legacy_hardware_release(struct dc *dc);
+enum dc_status legacy_commit_state_hw(struct dc *dc, struct dc_state *context);
 const struct dc2_funcs *dc2_legacy_funcs(void);
-- 
2.43.0

