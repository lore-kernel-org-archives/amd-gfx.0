Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE975CD4F39
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 12:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F3110F1B6;
	Thu, 14 May 2026 12:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzkJ0IZS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A63610F1B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 12:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBXFUH2iYw1ZfkmwlGKBYPs3Wwf3q8lgH5Sg8aC++MyGxt7dgvKqsn5mIDNk3NlangWwKpowZrOsViJDNEBKcNZkkWlPYKcV1L3dwZh+2ZIWiRLkFLBPM+bThUsULi3iwZ/AUEmM3TEW/0VI2OaU/sdsIyJUZqLIRC6XMFCoK2e7pbs5uQmsN6P2L25sJmow9+YWdop0AfYxW0NuWWGu7V3YO388kUeEkzQrK4Je3nIHjBRfyW6EaKsYbhZjoqDW6mTNF65YMdFK8tksA05iPnMDVTWg7D8yCosHGzf8MoywpUszXrC411pLPdOC93MUiPK9Io3bo8HgRd06nxuIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03XKIQOrUEOVxvAVIplyuwAZ37TQPrUpMr2KrA28L78=;
 b=niDNrUamUhCVj1h6/Vvy1BY8FRupTUFwVgJrioMMXRD94lx5ZQXb3ABslmR+yj6yDFaHFhCgS1zN6hP+Wqu2ePuoGuLZnZ/I6+OD0s1VhwygIigere31cgKB8UbeucAuW0emk1CirM6HTGeBRV3WwzOIttTavVYq6rORyPQKln3gEOk/fkB1EN5eIHi1FPCbLz5JOntmkp5/9YzxTjQ5ehgwD/GTA0CCxff4cYt9qeTGRm5pbXc3Z/izAkXGPYINOyR1fXmZbUu1YvooL6tFzGiFQEdKd44FOturAM8Lptjygokrhnz4FYKgnSjM0JhgdnB6lwOXTREan469XMy6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03XKIQOrUEOVxvAVIplyuwAZ37TQPrUpMr2KrA28L78=;
 b=KzkJ0IZSwbzhNgbds0rXA8Lg/ROtzBL+n7YkbDdj0WHKQuS0pjlXNP2/uUdyuT9n6R2OtB3+NyHHf0JyADdQXOAgZuoZpMaUx1D85QzO5/8SgNG33U2jXOOsHSeqXGx212gOHTP3GhBD0L74P8Qw0oeKfvQzxUmSn6AHu7uyn04=
Received: from BLAPR03CA0177.namprd03.prod.outlook.com (2603:10b6:208:32f::30)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Thu, 14 May
 2026 12:43:02 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::4c) by BLAPR03CA0177.outlook.office365.com
 (2603:10b6:208:32f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 12:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 12:43:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 07:42:59 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: clean up userq iVA mapping after removing
 userq from MES
Date: Thu, 14 May 2026 20:42:49 +0800
Message-ID: <20260514124250.3833711-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b85b39-57c9-47ee-7444-08deb1b655ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wd7AzKQ22ZrO/upjoOW5+1toA0Pm257QSGpWyMvMB9c4iSxyqDS10xCza5qCkjMrslRU1UldHttnB0kgYEJEC1zcsx2/R5sYonxUhMKa9P00DRGzHHd+AWuH70BoYFo4TvEQXpbbp0VKJbFSj+IYuXaE/Vp2sft+xzhxkthk+2ZS6j55jDDuru6rxje0uxVKX0o1D8E03D4+KYSFBkvWTIn42Sf29HHcunF8+BXiV8s/YSLM4vtkp8WP2+U5xuOVgNItlqBm4jlEodFNKyh2D1Lnh7umuU1uWT8KNiBHS17lFKLj4VRUIJYpwZDEEbnaq2J5uXvL+kTh5RpSkZdD5RlUQnwJK13hlTym+TfJ45rxKvl+957QnHA3EEgEzroinDeM24ONGU+syrnwcCEs2LOgagps1n0VM/qcIv4bZ60bdfJhM4zARvXHhJfMzT3AAXVgLLAoQ/iNmpirWlxXhRzrDi+bmalaSxBWK9BaZJVdrdpJdGMgL8ukOEcoDqe4RRK7IkrTAXie0dUmnlG0TXxdeC94hjNnh7zyTCA53bINACIThdsMf+xZx/78A5PyAaR8P+PQgWvl6MxD7qvKOKTMaboaoxlTj/wWzoO+cRxEiuPJ9PbtoDZcvRUdhrnDFsbJIiBvklLPY/rHdkOBLcTqHL/V8teEBS81LoSJGYzfp284JFkI65XKO5eMB7hpEHzo137ci4PU+Kzrnd+OGNp5ETQwy99ZGXtWKbA6SGc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: susNFXYZXcVT0YS+tHVv4AF1nHxzqoaSJXVqXodkREu+K8KGR8m8sgl9UOiOD1bs2zWwkPzeYYb9KaKCFnkewD4Fk/M9ikqxWREKKhCs0zP/QIsEWz/Gf3GZzOu5bdfR2zHTBiZpB7U1AcAUC5+yMcY3nWWWkbKUIYFuEwAOt7X6vZFDqeh7dNrg6+ADHn6e5eB8fY14zgyDK+6c0quaUP20A/KZtLUedSiTlEs+uXcDeTqQkpG2zpVgLYtAGagymMqD6x5RkWNlqVySasoQLx69hA5AsiYX7QdfKP5Z8Z8eh0APh0RgU1UGVcnwML8V1rZFpR6yRdyl3P0RvJFdQnTQXBQB1XUJbhc/XWqTJ9+Ysusij/24DDZa3VPBj1QQ1CLWQZhHutioMf9gv6qz8bRPfhFkIxux8UGnkAjY7+qx0BpfdOWuPyj3j4engiM5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:43:01.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b85b39-57c9-47ee-7444-08deb1b655ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

User queue destroy removed the tracked queue VA mappings before removing
the HW queue from MES. If the queue still had active waves, HW like as TCP
could continue accessing queue backing memory after the VM mappings were
removed, resulting in gfxhub page faults.

So, that needs to move queue VA cleanup after HW queue unmap. Meanwhile,
if MES fails to remove the queue, then need to run reset recovery before
freeing queue resources.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 83aee0810513..2e3edb6dd506 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -625,8 +625,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_vm *vm = &fpriv->vm;
-
-	int r = 0;
+	int r = 0, tmp;
 
 	trace_amdgpu_userq_destroy_start(queue);
 
@@ -635,15 +634,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	/* Cancel any pending hang detection work and cleanup */
 	cancel_delayed_work_sync(&queue->hang_detect_work);
 
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
-		trace_amdgpu_userq_destroy_end(queue, r);
-		return r;
-	}
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-	amdgpu_bo_unreserve(vm->root.bo);
-
 	mutex_lock(&uq_mgr->userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
 
@@ -651,6 +641,37 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
 	r = amdgpu_userq_unmap_helper(queue);
+
+	if (r) {
+		drm_file_err(uq_mgr->file,
+			     "Failed to unmap userqueue during destroy, ret=%d\n",
+			     r);
+		amdgpu_userq_fence_driver_force_completion(queue);
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
+		flush_work(&uq_mgr->reset_work);
+	}
+	mutex_unlock(&uq_mgr->userq_mutex);
+	/*
+	 * Drop the queue VA mappings only after the HW queue is removed (or
+	 * reset recovery has run). Removing the mappings first lets active TCP
+	 * waves fault on queue backing memory while MES is still trying to
+	 * process REMOVE_QUEUE.
+	 */
+	tmp = amdgpu_bo_reserve(vm->root.bo, false);
+	if (tmp) {
+		drm_file_err(uq_mgr->file,
+			     "Failed to reserve root bo during userqueue destroy\n");
+		if (!r)
+			r = tmp;
+	} else {
+		tmp = amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+		amdgpu_bo_unreserve(vm->root.bo);
+		if (tmp && !r)
+			r = tmp;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
-- 
2.34.1

