Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41654606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KBCych0H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C212710F94D;
	Wed, 21 Oct 2026 06:26:29 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA37810F94D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it/h3uv3F48nDT8S3wFAuIrJtipt8rjMhlXdjNmEyhqT8G8BxzBoHS42aEOZu716wqIeGxqApRMKbNHlJ0V8Szu/nXcJyD5zVZ6IOWrFzTgMhUzlcQ15qYjysUa1bCvmCgoL4O7RV+488+Sk1LM97Q4o/eiMT10Kyf1lvv/HcCb68P3m7t0e3XdTPBbD/bW5K3lJLNDSethEKqAUyNP+LPSnwPCnBPdJWlf89hGVIJvSdXoTi3PzZiiFqnZVn7xPuFSeEGL9iz+ARKMar5rh5RWWqGJvI6aO3lfb0cGvW+Z1aN1y4JmOYS5awOzmpAL45KC9xT/T6QEHzJ7Y+WYYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/9Yg4gFTxAb8l5MCX98f4JlbJqkl5tKV1zGVH5l52M=;
 b=NPNFhw1dyvuCmuxZ4l+hyeHuC7VQUb55NBZn8sOJndqwTxvaYYXx3vfC6WKrFuSghem271FRledS5Zrw82NdJPxsDmU/xSe8MwFvWuIhQlDq593fcgV3DjxUBjggZOJsxSREPN2TZ67uM28CSRIGdFIEksb480xAKBKzCMImhTiNrmmOQBrMaFbnrCY7hcaOw5f1FttXgIEwjA3f2X5mBejH8WxoDXj2WlAfNWcDB4ESDcIqrWf+rc5x+I+yHCrB9h6ojczfvLxHMR+ihi2wNIzOc3Zajr7d5PXr+QYsjS6zDwYOu4FQu85tBQABWb5iSj4nJNciWin/0IE9222SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/9Yg4gFTxAb8l5MCX98f4JlbJqkl5tKV1zGVH5l52M=;
 b=KBCych0H5Ge9X+/vEl9FxTp+sdEQ5+Rzs61WYyCJgAMNnyilz5xOzfWzChjHSDsltCr+LDJ3tx9TBIG8VvwIiiUYDsaD+Jj0UUOyjzvt+gAxRekdRL5rDihPCnCxf2f/DY31TOB6Mgqj1hbjAWyZ/qdXhKWZzsiL5jc6C2uOW+o=
Received: from SJ0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:a03:39c::6)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Wed, 21 Oct
 2026 06:26:18 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::aa) by SJ0PR03CA0331.outlook.office365.com
 (2603:10b6:a03:39c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:14 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:10 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Aric
 Cyr" <aric.cyr@amd.com>
Subject: [PATCH 14/49] drm/amd/display: Convert update scratch to memory pool
Date: Wed, 21 Oct 2026 14:22:20 +0800
Message-ID: <20261021062519.674697-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cc3962-d6c4-4a86-83ad-08df2f3c36e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DFS8jnKP0qY7Qh3f5qd6lz4Rscd1FvRP5F7gyeYvLjs5S/QfEnlCzInpohNcXoDmMeAMmgj2xOpWh5eM2tudeXpXBb1a0wP8H4kmX+DHVH9EqjgwJ0uBnNpY1pUSI8xrg0/HsAsv3VbjrwKWnLqHeP584HRW6x+V9u8HjeEMHBovLwfS4Sbs2WBRS4JSHcpZOeBOVxaSKiFMjh2niKyCPobUL1iIzSkhLLeppu5fJYWJLtUSz0LCoWmLaE2iD5w63MQHi3fdPk45R0uRgKTSbuALViyJ0M2rub2qs7OX9CqjC68i3tZgNAY8swiKKL75MxQsDzor0oBZF1jd6rEaItcQsfJ7EKPY9K1cLm4k9L2NbAeHifMtP2Y3fz/lh23NDgT4KfyTEcmHMyL4svsYv45p8CnVvW4homxEWqlAYUVqqAYqzZ6qz/Z/ITVIuJNeP8pw8d+yaMCXG7PXSjfCm6VOqrpxU78PSvLGDBhnlgXdp4tQ0Souj/0TBeZni/JdZuZ3cuzRvrsVpgxY1DIT+206KuDTLC1igASkls6M28QEdCUILcb39o3sUP4/XaLSh7+IkR6LaXrB8JJmjxF6rBGODmBBanzFCcTDMm2cO66/cC1o8gJKHyGOMmdFIPtN/XxUogPbe4KLKcpGkUOOP2zjf1+yUUz8Lxpq6ahasu6SrYYTV/q8IUpChg1j3W8v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUcQzlDPw90uaZrPuZ7fdgDXw3z4nHDwm8Z1pZRJKqt1z3gOoX2VXmdKgK/6WNUtX0BJangif/ML6IgV7pEG2uGShEWGVaP+FdXXst36dXwPtFygpaabSkxW0RP8/WJViwq+rYeZ8tP2LVLF1ivqcc/Q8VvVcgeFzS0LlcODvTnncdihplOTe9tDBLN9X65xKLyRA8S8EIxjgSQ9WYJpFU5RqAoKyi/6L917l5lEJfV9nQvPa7SghdE+xDH0Q8BtN9Wauem2KwJD0CP0BRXDfjO0KET+5CCYveWoBi/eV0aRXCz6yagM0M86HqQJCJZ7Kj/RhIRQMiKZJC/pXskcv0SYRReit34la+SZn9U/Vz8LTA9pCnKiruif2V6gZnta3cd6I1ef5FWfj5AGK5dQ/yPO4cV2d5B1gF2FZ9809427VYGOkKDsY0qUORQe7zY4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:17.4561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc3962-d6c4-4a86-83ad-08df2f3c36e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
DC update scratch space collection is an array requiring external
locking if it were to be used in multithreaded context. This limits
the possibility of using it inside DC itself, and raises risks
of deadlocks or stalls if the thread holding the mutex is preempted.

[How]
Convert update scratch from array to lock-free memory pool.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 46 ++++++------------------
 drivers/gpu/drm/amd/display/dc/dc.h      |  4 +--
 2 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f84f659c101b..2fbad6f1e282 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -944,28 +944,17 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 
 static void dc_destruct_update_scratch_pool(struct dc *dc)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
-		kfree(dc->update_scratch_pool[i]);
-		dc->update_scratch_pool[i] = NULL;
-		dc->update_scratch_in_use[i] = false;
-	}
+	dc_memory_pool_destroy(dc->update_scratch_pool);
 }
 
 static bool dc_construct_update_scratch_pool(struct dc *dc)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
-		dc->update_scratch_pool[i] = kzalloc(
-				sizeof(struct dc_update_scratch_space), GFP_KERNEL);
-		if (!dc->update_scratch_pool[i])
-			return false;
-		dc->update_scratch_in_use[i] = false;
-	}
+	// +1 to allow updates not tied to any specific stream
+	const size_t size = sizeof(struct dc_update_scratch_space);
+	const size_t capacity = MAX_STREAMS + 1;
 
-	return true;
+	dc->update_scratch_pool = dc_memory_pool_create(size, capacity);
+	return dc->update_scratch_pool != NULL;
 }
 
 static void dc_destruct(struct dc *dc)
@@ -6027,32 +6016,17 @@ static void clear_update_bits(struct dc_surface_update *srf_updates,
 
 static struct dc_update_scratch_space *dc_update_scratch_acquire(struct dc *dc)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
-		if (dc->update_scratch_in_use[i])
-			continue;
-
-		dc->update_scratch_in_use[i] = true;
-		return dc->update_scratch_pool[i];
-	}
+	void *p = dc_memory_pool_acquire(dc->update_scratch_pool);
 
 	/* TODO: add recoverable scratch acquisition failure handling. */
-	ASSERT(false);
-	return NULL;
+	ASSERT(p);
+	return p;
 }
 
 static void dc_update_scratch_release(struct dc *dc,
 		struct dc_update_scratch_space *scratch)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dc->update_scratch_pool); i++) {
-		if (dc->update_scratch_pool[i] == scratch) {
-			dc->update_scratch_in_use[i] = false;
-			return;
-		}
-	}
+	dc_memory_pool_release(dc->update_scratch_pool, scratch);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1d95ae50f341..7280a422ff0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -30,6 +30,7 @@
 #include "dc_state.h"
 #include "dc_plane.h"
 #include "dc_probe.h"
+#include "dc_memory_pool.h"
 #include "grph_object_defs.h"
 #include "logger_types.h"
 #include "hdcp_msg_types.h"
@@ -2025,8 +2026,7 @@ struct dc {
 	/**
 	 * @update_scratch_pool: Per-commit scratch buffers for dc_update_state.
 	 */
-	struct dc_update_scratch_space *update_scratch_pool[MAX_STREAMS + 1];
-	bool update_scratch_in_use[MAX_STREAMS + 1];
+	struct dc_memory_pool *update_scratch_pool;  // MAX_STREAMS + 1
 
 	struct clk_mgr *clk_mgr;
 
-- 
2.43.0

