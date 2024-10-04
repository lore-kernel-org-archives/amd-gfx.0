Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A974BCF885A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 20:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCBA10E03F;
	Fri,  4 Oct 2024 20:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F6Xgkt6y";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B761310E03F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 20:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdXBlYWqD7QnxA54POzjRhaNR+yoQ6GB6ZP8Tkuj1QRU17Qej2yJ0rP2OAlJ9/1H0aLWNnjDns5jCTo0kL552zM8UfTjH2odpcpMqzBAs0nX/Mqh2x+lDwAs38j/1BgoH71j0cPVml1VgYyWmg4olbH3cSPFaRduXtsnFMEZsMSpEvLTRxMkMe27WI1XBLa4xXhzz2idsIcOno20kXbBmbdYP3lP82TtglUJ+GwV8mjCy0AGgIB57S1Q94R945iH/hnl28BhDAgu8nNIaMmoN+aFoi2k/TncOWyn3UDLTZw5AuuI93R/XN0JBnT1BKJ+QgDZUPYnsFnqgQWZja48Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk0XpQxcL+yBXVZpEau+uwh3O3s8bpgYQko2vyYTh3w=;
 b=KdclJ99vpsCR8YsKt9Ti2MCoqOjQuQSOXPGyP763A8coK2JZPkizonBFvDecQN7sv/nGdNkTmEVPMJC5rQDE70ANyzz40U5bbmnsFYoZX9gDf9b8YOp9kWF/mz146lgbgmgj835p7hQlgYOlxoTSJXfaSZSP45dHztmC9UuKOFB6jg7/i10eDpl6bA2cCD/aDNcfh2JyBi5NSUPDVEYyVtblCEC+FUKDiOqlx7nSUKZrsHqQFXApcm19xWzEgO1NGZF0+7Rd6VrXnCignpQ37qvBjjkPcztoPW3J2jUM8AFzDI+lIY9kzpxhCDD1iU7Hxmmt8DHOWBap7UxxyuNlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk0XpQxcL+yBXVZpEau+uwh3O3s8bpgYQko2vyYTh3w=;
 b=F6Xgkt6y6b+SRlXplnBcRxgdn6CX47+/GZ6g6tePHJu0BostzD8WgIuo4tdZjWAxhMQZijzCuh/yksiKAg4w3gRLlSr4DsvmKa48ZcNMkrIge41BWeUahRqvXZNnYFnUdc5101EXGe/cgYLB4KH0++N+aHU6UDmwct9IeTt+FnU=
Received: from BYAPR08CA0062.namprd08.prod.outlook.com (2603:10b6:a03:117::39)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 20:28:57 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:117:cafe::42) by BYAPR08CA0062.outlook.office365.com
 (2603:10b6:a03:117::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 20:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Fri, 4 Oct 2024 20:28:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 15:28:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Accounting pdd vram_usage for svm
Date: Fri, 4 Oct 2024 16:28:07 -0400
Message-ID: <20241004202808.30740-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6870b999-fa9f-4548-8598-08dce4b32bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZmGQL9CWd3ICuIx4fFvdYb+1yy+mnWw14e75W+LOPqfuoLMIfpJiFDGTBJuQ?=
 =?us-ascii?Q?qAO4pncOnLa9xruFFxacCjNfbjJKxKT2cBVIyD3zTntqfs1BfKmiSKjnRjVg?=
 =?us-ascii?Q?9AJRGzIfThraxOOFd/NO/A+JRmStBb4/x07qFFMX50gFx3RziymYFy0IFeec?=
 =?us-ascii?Q?YinSVZMAob9MnQxQthfIq6iWRRjpzGqNd/NRXYLzpOjTWSm0P1AURK4jWDqq?=
 =?us-ascii?Q?5DF6hOWixDWIrWXzf1pcevhgTFQ738jSf/fzk7nImeXG47BJnUrYUJc8z26M?=
 =?us-ascii?Q?T4R5Hb7P2rjbwEdsVhGUZabISoAOWzQDxlhVJ+xE1qPBoMDsNz+oD55Ua39F?=
 =?us-ascii?Q?0GArGvfYkYJsj4iCUsUvhUwAX/lZ7a2AF5vFVLkvU9TnwVvj4PWkQerZ/yF9?=
 =?us-ascii?Q?5QSKln84/LkbyWyn8L2Ye27M5g89LHxfV8CFFknaLQg7KuHaenDL7iLZx7Oj?=
 =?us-ascii?Q?YBm1n27mR2rwFsYFbiI/lOfjhzjfcCqnGMcKohYpPJnGYSdtSBlagZGHbD8O?=
 =?us-ascii?Q?72nZJBezZyFPHQ5XpSGzaiQNeVc08JMj9JoJj+xn/FoZKAzHpbpbmLkPRcjk?=
 =?us-ascii?Q?q1+XP0y3cZJkPuNKpcr7s/jUiV+h1AFmXim0+EDSsAY3fgtr0ZgLLR3EwOiv?=
 =?us-ascii?Q?fedKlK7ud2Ur1xEFeiofmu2jMtA9pN4oh8GVcGJov5+7S6pNyiT1rEMKE40J?=
 =?us-ascii?Q?BTtKAmmYA5cKmTdkXGSaYP9wR62eOB10SO83RmUrgyMu5lc56P4bvXT+4ZCK?=
 =?us-ascii?Q?0ujV5ow7BXVzlSJsqR6wFChNkqTR5b/Ed5Ho22dyNirwW8k2mHc+wvqVmaFr?=
 =?us-ascii?Q?9aJiwmIJRbZL76QkjqY6HYy7LfRRxOtAHrKWSFnF6gm8tJNClnwaJkN2ZML5?=
 =?us-ascii?Q?gm/OcpaUdat9mc97kWNw2rE6SDb79Y68jIknruZyHZklDNzY7PAmOxPS2vIc?=
 =?us-ascii?Q?Xv1iGRnTUzrcsnTGu8L0lIYyZjOQf/qprb5H6HswUcL6CeIqjdMaysRom3Uz?=
 =?us-ascii?Q?QkVXHcE7tM+ke+D+0sdMLj71em5fItv4fLNLViT91bIfggP0Ys2N9Z48/351?=
 =?us-ascii?Q?dVxJKr50pTNf5+vGqe+ELO9b8askCblyG98y5XeWbOOhKOW6LpSqMlBQfqSZ?=
 =?us-ascii?Q?Vla0DoT2UfKlR10+PsWz9jx1PMMKxf41k9mpwp7x03at8JdWqNdpc0qzPcat?=
 =?us-ascii?Q?h7zn4O3nqfTM75E6p/gDGqml4WseoxaaX9Cf+vD8N0hmNxRisHN3C5Wsyr44?=
 =?us-ascii?Q?Mn9gU0NE/IwjuT5UKhGEpjKaBthGZVM8Fr1t2ym3z3RYT+dLItzPB6B3yfAM?=
 =?us-ascii?Q?lICH9WNSKoq0Bm1Abg4deXlfQGRxH3OSiZsdpdGE9Ym6/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:28:56.5692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6870b999-fa9f-4548-8598-08dce4b32bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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

Per process device data pdd->vram_usage is used by rocm-smi to report
VRAM usage, this is currently missing the svm_bo usage accounting, so
"rocm-smi --showpids" per process report is incorrect.

Add pdd->vram_usage accounting for svm_bo and change type to atomic64_t
because it is updated outside process mutex now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a1f191a5984b..065d87841459 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1148,7 +1148,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 
 		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
 			size >>= 1;
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
+		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
 	}
 
 	mutex_unlock(&p->mutex);
@@ -1219,7 +1219,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
-	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
+	atomic64_sub(size, &pdd->vram_usage);
 
 err_unlock:
 err_pdd:
@@ -2347,7 +2347,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		bo_bucket->restored_offset = offset;
 		/* Update the VRAM usage count */
-		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
+		atomic64_add(bo_bucket->size, &pdd->vram_usage);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6a5bf88cc232..9e5ca0b93b2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -775,7 +775,7 @@ struct kfd_process_device {
 	enum kfd_pdd_bound bound;
 
 	/* VRAM usage */
-	uint64_t vram_usage;
+	atomic64_t vram_usage;
 	struct attribute attr_vram;
 	char vram_filename[MAX_SYSFS_FILENAME_LEN];
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 7909dfd158be..4810521736a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -332,7 +332,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 	} else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
-		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
+		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
 	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_sdma);
@@ -1625,7 +1625,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
-	pdd->vram_usage = 0;
+	atomic64_set(&pdd->vram_usage, 0);
 	pdd->sdma_past_activity_counter = 0;
 	pdd->user_gpu_id = dev->id;
 	atomic64_set(&pdd->evict_duration_counter, 0);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 857ec6f23bba..61891ea6b1ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -379,6 +379,7 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 static void svm_range_bo_release(struct kref *kref)
 {
 	struct svm_range_bo *svm_bo;
+	struct mm_struct *mm = NULL;
 
 	svm_bo = container_of(kref, struct svm_range_bo, kref);
 	pr_debug("svm_bo 0x%p\n", svm_bo);
@@ -405,6 +406,22 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
+
+	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
+		struct kfd_process_device *pdd;
+		struct kfd_process *p;
+
+		mm = svm_bo->eviction_fence->mm;
+		p = kfd_lookup_process_by_mm(mm);
+		if (p) {
+			pdd = kfd_get_process_device_data(svm_bo->node, p);
+			if (pdd)
+				atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
+			kfd_unref_process(p);
+		}
+		mmput(mm);
+	}
+
 	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
 		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
@@ -532,6 +549,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -623,6 +641,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	list_add(&prange->svm_bo_list, &svm_bo->range_list);
 	spin_unlock(&svm_bo->list_lock);
 
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (pdd)
+		atomic64_add(amdgpu_bo_size(bo), &pdd->vram_usage);
+
 	return 0;
 
 reserve_bo_failed:
-- 
2.43.2

