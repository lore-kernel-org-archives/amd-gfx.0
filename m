Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE5606A328
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QEbnvvxF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D3910F971;
	Wed, 21 Oct 2026 06:28:30 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDF210F96D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR59wDYKNdzQMh80/54a+nOGYkL1XxOm4CFsmdzZ5XGjF2XrPMz8qzqNXFFfOhSFRAqZRibAXZ1LZDiJznZoyK6fgLtkf9BqNKMnNBOawSGzzvNi8N48i43QXLZJP9DgZ7H4sPgHw8P/ewd0RBM26dt6mFbxogcXKI+uZrSaIjUX1LJZfM/O4Gja3iQtv1FcsCbE0bcjQSeMhld2Zw61mMH5CyI8nBJ4Wj5iAz3VtnaTuCUJD8lqWZHjlaTcsG4/4clNNhox9lWHim8JldL7S1Lb2Y9Q6M4g+2ziNouPRQ4gxZSlqLiRjoKs9PMf+AM1uowazsCr5arn0AXPPeQRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfzo5K7vprutTFrsCzVK5wSK8CgWD9ZE2KVPP/DA5MY=;
 b=L7Cc/raqHFpY4/p8axVedPpQhim71PiSjGKIM880fNho7HA8QbJaWlkHRjXlrbqvTe5HtfkQ81p1o7IYekO/3X4oaNVZ+rrcOjxx9pOS1Z29Nt+CgPbMVC5kM1N2zjPKw+JCg9VjuK5/6P1+KuPTpUR0EmZetKFIrQpAhA0ruZGVGvyLlCIg5RnJYmdMug5/z2EsWEBEUMy+kOucaYK7cSmYrkZSEfZAYWuoyVZRkX8Iwo/wF9O4kaXaqS+XBSVpValInDcIW3feHYdGJdafEjFWtgGR51f1gcJUVmQHitNGTv/+ZRyi6VulP0c5HIMmMYJgf8Dl8JDhP5d56ZSd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfzo5K7vprutTFrsCzVK5wSK8CgWD9ZE2KVPP/DA5MY=;
 b=QEbnvvxFyGsnU80VffsNHZjJenM1bJhWda8iWjgS9kgOtr6MPYOzSDLNQ5HbrZRAqWetsQB6OWZap8Go2Rra6TfOEYZLz8olArqgYkXFTOAnGDjjL9i5fTxPpzZ+x6aGXMPxfbUS/80x9cQjBdxUvSBiWVd0LHlxtjK3o/7npcc=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:28:19 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::34) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:28:19 +0000
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
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:18 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ashwin Santhosh <Ashwin.Santhosh@amd.com>, Sung Lee
 <sung.lee@amd.com>
Subject: [PATCH 47/49] drm/amd/display: Pre-allocate DC state for
 atomic-context commits
Date: Wed, 21 Oct 2026 14:22:53 +0800
Message-ID: <20261021062519.674697-48-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 85849dda-f6b5-4fbc-2a3a-08df2f3c7f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6Sey1u7Ks8Vrt4roHq0UnXy0FDLfihlwll/I1f07n07aCHNQSFKcu8zIHbP3lWfH8VWSTTVRjLczBAzQn1gmQXQ48U4pq6Br1cL2WBc+x4hnB1tbaOlwFzRKcAJTDFde3t8ys5cuSNCjT9Kk6cuyXi7L1+mr/nH+MGeRy2StRGFFRJoUvRavLCZDQVey5/hJ5ZvR2JhA0F5qpXXkmjcO5c0CUQfp06aprt1UZtf6iX8LJo6oOjtvmb+tfVSWid7n31dMeUtCOiXq8GaNLbqc0GhVqkWKqVQsJEVf2hqW+cy8klVh3bnhPyTLAuILEYbd7pw+PxtyjiSPaZMDRJrfr3gSBR6bphYwEKSQMEJIwz7QdjSCqFXTbuYDm6nYuBgbxEwPNHwcVQLX/UI+RscQXGb7Fs8odEydUMm/dOjPiSi56zFsIqo3QVwFqT3n3MhYs/fAGpZ1WDWl7I1NAncY7R4Ygtft3DLI4DwQCpYHt8Znv2CbOUsLlCeBPlX1l0SOM7ibaf1/TxH5HIEN5VoehyeKZAH5+2rcM59xQug7EXyi5Fq5oBT2lT+K1afkkzNk+3Vz8BA+MA9n+c2GBeaYc9ks8wsW2ouzEGozTSeL+C3szTyCvt94y/V6/5JkrnkU/iNSQOYIg3ppDHjhm9QnuH0JEQu6vVMTEJiZigXczy9CDKRF4wnCIYLJQqKFZTLzP1wxFgAszgPO6Ofaf0WS8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OO/4T4CH8WuPCieozaHkcrJEp6pj3I+V/ObiVNKd1/OwpZpMq1uKjyK2SFAsapitjHlkwvrtjq0+gJalw9xSnu8XfmYLz+ELiJq8F0swQ66IGWjTmk1N3SKzLFMMZ73r/izdSum6uujyamf3Q+sdrkoTxgvh7LhlWNEn9gj6yfpYQeGQ54TOa3alOI+hACmTsL9ffIAlN8biQ1TG8SxEymhwCW8zYIntxbymMYOE2MHMopUHXzO+nUoU1PKEGumsx9gtde5qoZmQzAVb2Ed+gh/05sRGyBd+ykGggnlYO5YgrUuVmfDpjPO4fgBH/XhXhXYQw8WDTUhI5nTUfCjs0xW3L/c5LNdC+YRSMDRUrBVOSj3BCkDqn46ZZ2mJ4Sq+CiYUkf5huekTJfnVbwUA8aXV1ThvQP50Zelavf5CR8jX/nkyUleOHsEUOd0rRsMJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:19.4349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85849dda-f6b5-4fbc-2a3a-08df2f3c7f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
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

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

[Why]
When display enable runs in a context where memory allocation is not
allowed, the DC update path still allocates and frees dc_state copies
for the new context. With allocation checking enabled these calls are
flagged as illegal in that context, causing a nested fatal system error.

[How]
DC pre-allocates two dc_state buffers at dc_construct when the new
dc_config.preallocate_scratch_state is set, so the commit path never
allocates one. Two are needed because the commit installs the new
context as current_state, which a single buffer would alias and
self-copy. A second flag, dc_config.use_preallocated_state, is set by
the DM around a commit that runs where allocation is not permitted and
selects that path. On it, the v3 update flow also skips the
minimal-transition fallbacks, which allocate, and commits the new
context directly.

Reviewed-by: Sung Lee <sung.lee@amd.com>
Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 79 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h      | 16 +++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2fbad6f1e282..ae5f03a73132 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -959,6 +959,8 @@ static bool dc_construct_update_scratch_pool(struct dc *dc)
 
 static void dc_destruct(struct dc *dc)
 {
+	unsigned int i;
+
 	// reset link encoder assignment table on destruct
 	if (dc->res_pool && dc->res_pool->funcs->link_encs_assign &&
 			!dc->config.unify_link_enc_assignment)
@@ -971,6 +973,13 @@ static void dc_destruct(struct dc *dc)
 		dc->current_state = NULL;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(dc->scratch_dc_context); i++) {
+		if (dc->scratch_dc_context[i]) {
+			dc_state_release(dc->scratch_dc_context[i]);
+			dc->scratch_dc_context[i] = NULL;
+		}
+	}
+
 	destroy_links(dc);
 
 	destroy_link_encoders(dc);
@@ -1209,6 +1218,22 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
+	/* Pre-allocate the states used by the no-allocation update path, only
+	 * for DMs that ask for it.
+	 */
+	if (dc->config.preallocate_scratch_state) {
+		unsigned int scratch_idx;
+
+		for (scratch_idx = 0; scratch_idx < ARRAY_SIZE(dc->scratch_dc_context); scratch_idx++) {
+			dc->scratch_dc_context[scratch_idx] = dc_state_create(dc, NULL);
+
+			if (!dc->scratch_dc_context[scratch_idx]) {
+				dm_error("%s: failed to create scratch ctx\n", __func__);
+				goto fail;
+			}
+		}
+	}
+
 	if (!dc_construct_update_scratch_pool(dc)) {
 		dm_error("%s: failed to create update scratch pool\n", __func__);
 		goto fail;
@@ -3817,6 +3842,29 @@ static void restore_minimal_pipe_split_policy(struct dc *dc,
 		context->streams[i]->debug.force_odm_combine_segments = policy->force_odm[i];
 }
 
+/**
+ * dc_state_acquire_scratch: Pick a pre-allocated state safe to build into.
+ * @dc: DC context
+ *
+ * Skips the buffer installed as @dc->current_state, since building into it
+ * would mean copying a state onto itself.
+ *
+ * Return: a usable scratch state, or NULL if none were pre-allocated.
+ */
+static struct dc_state *dc_state_acquire_scratch(struct dc *dc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dc->scratch_dc_context); i++) {
+		struct dc_state *scratch = dc->scratch_dc_context[i];
+
+		if (scratch && scratch != dc->current_state)
+			return scratch;
+	}
+
+	return NULL;
+}
+
 /**
  * update_planes_and_stream_state() - The function takes planes and stream
  * updates as inputs and determines the appropriate update type. If update type
@@ -3923,7 +3971,24 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			new_planes[i] = srf_updates[i].surface;
 
 		/* initialize scratch memory for building context */
-		context = dc_state_create_copy(dc->current_state);
+		if (!dc->config.use_preallocated_state) {
+			context = dc_state_create_copy(dc->current_state);
+		} else {
+			context = dc_state_acquire_scratch(dc);
+
+			if (context) {
+				// Drop the references this buffer still holds from its
+				// previous use; dc_state_copy() overwrites the pointers
+				// without releasing them.
+				dc_state_destruct(context);
+				dc_state_copy(context, dc->current_state);
+
+				// Balance the reference that the commit path consumes
+				// when it installs this as current_state, so the buffer
+				// stays owned by dc->scratch_dc_context[] as well.
+				dc_state_retain(context);
+			}
+		}
 		if (context == NULL) {
 			DC_ERROR("Failed to allocate new validate context!\n");
 			return false;
@@ -4004,6 +4069,8 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	return true;
 
 fail:
+	// For a scratch buffer this drops the reference taken above, leaving it
+	// owned by dc->scratch_dc_context[] rather than freeing it.
 	dc_state_release(context);
 
 	return false;
@@ -8092,6 +8159,16 @@ static bool update_planes_and_stream_prepare_v3(
 
 	ASSERT(scratch->update_type >= UPDATE_TYPE_FULL);
 
+	/* The minimal-transition fallbacks below allocate, so the scratch path
+	 * commits the new context directly - possibly a non-seamless pipe-topology
+	 * transition. Placed after the suspend above to keep the cleanup resume
+	 * balanced.
+	 */
+	if (scratch->dc->config.use_preallocated_state) {
+		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+		return true;
+	}
+
 	const bool seamless = scratch->dc->hwss.is_pipe_topology_transition_seamless(
 			scratch->dc,
 			scratch->dc->current_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 494ab208cadf..569cfe16d73b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -636,6 +636,15 @@ struct dc_config {
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
 	bool no_native422_support;
+
+	// Pre-allocate dc_state buffers at dc_construct time so that a commit can
+	// run on a code path where allocation is not permitted.
+	bool preallocate_scratch_state;
+
+	// Build commits into the pre-allocated buffers instead of allocating.
+	// Set by the DM around a commit that runs where allocation is not
+	// permitted; requires preallocate_scratch_state.
+	bool use_preallocated_state;
 };
 
 enum visual_confirm {
@@ -2027,6 +2036,13 @@ struct dc {
 	struct link_service *link_srv;
 
 	struct dc_state *current_state;
+	/**
+	 * @scratch_dc_context: Pre-allocated states for the no-allocation update
+	 * path, created only when dc_config.preallocate_scratch_state is set.
+	 * Two are kept because the commit path installs the new context as
+	 * @current_state, so a single buffer would alias it and self-copy.
+	 */
+	struct dc_state *scratch_dc_context[2];
 	struct resource_pool *res_pool;
 
 	/**
-- 
2.43.0

