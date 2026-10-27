Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04980606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lve0YVG6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB3B10F2B8;
	Tue, 27 Oct 2026 07:51:23 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1911410F2B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 07:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNonkMeFiqdVNqP3U9xCQPyr8sIaDDL3NKz0uQEMhccv1F4ChMf/4Xhu098D9qF5+PBDBLTRqPU8cehhfrdC8mhtr8pvacOK8ElJlJsBWSzUGPeEGcKNYIF0oOSnAL2iclj//s3B/sLViNkIErNg9WmR9TOVkRVqH7J3XMGG8MvZsttJhligposVguYRz481gJpZnm8AF3r6io5KuB5NrzryV2QbvwVPCa8zSpgED90Wufn6riCv3h+KPbiYaCYHh/mgD2xiyFQXOOl+dG8g8uh0H9ecIX1sDy9RRn0B161Onjq5sc0vFzYuK75ES0JzQwwv8+AWypUBzAIuhEZSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLrzCyLnG4jeLvvtjy4tJR2kHE8mo9ViaWc94u9L0gE=;
 b=h3n8vArnlK48Sv/OKV2DyXy5MQNvZC9rpMeQnkPpNWrA2CXnaAQg2oWMc9J2QCgHaaluhNNstJ/uUZqohWWoaSGHbhEttRbYdx4Iq10tysvK2CIjug7eo1MXpFJXmnV29Pmr5HNemlDDITVY4WBWVnq/xenx/K0vf7CozncRXZf/rReX202BOp80QGBRP0D1HvtTrToKpBqU7GYpRUphOri8Z6tZ8+xjWLoJM60xFzNcgMzf5C2GSUMZl21YcvaI4wV9CAW5psRi7U+/BHsCXyqw/+Ze9WNrF/TRLQUFa046GhQQTKfXuAPowtP6JA9mBAbkmWpJSawH5l23WdlaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLrzCyLnG4jeLvvtjy4tJR2kHE8mo9ViaWc94u9L0gE=;
 b=lve0YVG63kK1LHl3QO5WrqyQeM7tSUUmRvggR8KUKwoqTRsk3xg96AWevETToTfeB9z4vT5u9bLM14O/xQWAxqYG9N8xDaTluQSU/gvfNlRUcX64d/E8WBsirdsJOt++oR4ybqWs1x8cvBvvNIt3eKGNnyyB1kRbYHhNEmtIOBU=
Received: from BY5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:1d0::19)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:51:12 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3f) by BY5PR04CA0009.outlook.office365.com
 (2603:10b6:a03:1d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 07:51:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 07:51:12 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 02:51:11 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <amber.lin@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add debug messages for MES queue reset
Date: Tue, 27 Oct 2026 03:50:04 -0400
Message-ID: <20261027075017.121456-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 182f77a8-a719-4a9c-4ffe-08df33ff1211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|261026121527099003|56012099006|11063799006|261021123027099003|261009223027099003|261022105027099003|261021121427099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: R5/rS8qmng9FViuTC4+//auWeRWSLSsApuHRP0QpEUvfzmLIY5xyNzFON+5IoEXEFNjIQQHKVT0oQWGjHHH4B9X/lJ6BxR5HvIfUOpvU8Wqo3T7GmvLgY49KLm7juTbFfQ05NiViK1iQtqQgC1qBWKYsMB1LIQdCxU4XNhi7UYxiu7vIiVg5V7CNRd7YtZenuzsdqPmIAqp3FuTFyeZ5BhgrvD0j6YUTU2E29b5jnIDIgmpEEoEbGTHhpde3nAHi9Z+AtwHvszdBwaeVTJ2EpGHqStgpIfi/ucA4KUAjRQP7dG27g++vCA5LW8kv9jFQomLSh9RdrkY7T15oDCanGnHoX+w+aOesFAq0MhLftk8wllt1e09cYHeqUZc8tX2k8LBKB4ZororTdSd97fHuy7fqeHqwW7JxdYxaIR/zNsWOc1Wj3QGKotKPz7hgYmdgr/KuDibV/KNPNXShp94tRLtcPEIY6D1E718/fVxY14lAa6uRAkMCPoxxboiKtCd3T50v6x5i7oz41I30IKmV0aRoXr2LxY9Ko3Wt6KZdBY6/6VW3MVcpbbKQ2AjMM9mJMylNfTc0ZDbQXFKCtPizf7kFrR1KqDjtTj75bQFrVLpz1ESWhBTC4FZJe/8jlB3nH+Z9e3t/qEbVmI1xuic05NgqGE6gDXo11nn16WAr7A3Y8P6mJKb8qR3vXms89N3PdOz3W/E92muDgqWi7jR3mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(261026121527099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xPleXz0gX+f6YwvuoiUmRiwIJzjIGjH6yZ6IGJt/2BE53nUkHBbDwWBFfk+31K6ffK5dRB1r1iSDqwN9Z/mVkirLmQzCjlNY+QTRRRcyXQ1Loi0M3ApQiSlGTmTgdLBqvpr/cKVxGLmu4MXjh1gQv1Be5no6iJvH9xVfhgQ552gw0gixZsjq4E/axKMOY7MLaaYgFoSUnJM44iohk/DbAehQnjeMO8WYZFQ4+9jMue7jB8F7t0JXsT3Kler+jgDDGwOuWj8OIuobS2N/wYidSHaiqKxqUOkuXHsGx8Qgy6D2YaKvlQlvREthSUSwQwXlqHQKoBL3ZqsX0WlIkDlcIz7807rRtKC6FN2gGjX4DZWvSXdniORmZHExnsZ622yv0sg3hUWpTd32ax+VZRnOukTg4maXZZGCoGwxpebphxk12StybHipS6zkBTg1lFoS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:51:12.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182f77a8-a719-4a9c-4ffe-08df33ff1211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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

This patch adds debug messages to collect some MES queue reset data.

Signed-off-by: Amber Lin <amber.lin@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..0c1c8ae822d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2495,15 +2495,21 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	 */
 	r = amdgpu_mes_suspend(adev, 0);
 	/* if suspend all success, it should no hang queue */
-	if (!r)
+	if (!r) {
+		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
 		/* always reset the KCQ/userq since we need to signal the fence
 		 * and we could be stuck in a loop which is preemptable.
 		 */
 		goto fence_reset;
+	}
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
 						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, 0);
-	if (r)
+	if (r) {
+		dev_dbg(adev->dev, "MES fails on detecting hung queues\n");
 		goto out;
+	}
+	dev_dbg(adev->dev, "Detected %d hung queues\n", num_hung);
+
 	if (hung_queue_count)
 		*hung_queue_count = num_hung;
 
@@ -2530,6 +2536,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		pipe = hqd_info[i].pipe_index;
 		queue = hqd_info[i].queue_index;
 		queue_type = hqd_info[i].queue_type;
+		dev_dbg(adev->dev, "Hung queue: queue_id %d at pipe %d type %d\n",
+					queue, pipe, queue_type);
 
 		/* reset any KCQs */
 		r = amdgpu_gfx_reset_mes_kcq(adev, ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2ff1816adfc4..58766b27e150 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -557,6 +557,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
 		/* Finding hung queues where db_array[i] is a valid doorbell */
 		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+			dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x\n", db_array[i]);
 			hung_db_array[i] = db_array[i];
 			*hung_db_num += 1;
 		}
-- 
2.43.0

