Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3333D0EE34
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 20:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B0110E0B7;
	Fri, 11 Oct 2024 20:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydITXvjD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A493410E0B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 20:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eeb72KY+6jFQ5gQVaJN7BxxZprjfxAKdwdFgHaYfAIk9a36u4qgdEzO5ULtzLC5on5nBRSgKyDvbs4fCYhW/MCdRvekM2PZFpAoNOhEPU0hG5h6HCbrV1t6exApbCkqX2hfLddh03OggDzl/PPLBF4uAscbd9UHMHBO46L9MuzBT8uvd4xHCgFaemz6QehBQ8iQmrmu/nF7xLnHGQcr3YY7j8MMdc+Cdn+Yfe9xqmnoH4hV0Fe+7bpweN3VbmaEKUJJRobj21oPiP8EN0SItB8RYqoT+i7C0DQ523KoktwlLwPYpWzVYFoeahAN2qfBzC9gZ9hWJ0xZSJbsCExkskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K9wu/z8xX7762dbJqcpQoYEJOKu23lkJR3O8wPoDts=;
 b=xyYSTxnWIMnkQv/XSGNPuhrO6hv2I4QX+iHYwdou+PBqe5smvbmnYhhGxlBV/3Ph2GTKhCQIhu0YAkxHAIRgBNdfFD8LRHnof8ViFqXf6mxuvdt62B22/DpimyyRb0GkXDwt/y5BEbrAhuHxXzxi7zTY6jeLp6Y8WHtZcJw3xF32BtcgdlXHniFNuV7qOkNu2OfSDa3C+vVyeG3/w9wQlwIO5Mhrc9U8e1gzCRMFOZNLZmB8e9JjDloCSNPDJSSBDSinOv6GYmNuqpwPZOGHH7/BX2wrs51AmEGcAOXuSYNegfhlfyVhCcxYP7Mj/naaXOYQoKKl45HJEMoE5qmmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K9wu/z8xX7762dbJqcpQoYEJOKu23lkJR3O8wPoDts=;
 b=ydITXvjDyfgTeWzultCLvLYnVtoRIqfPVfm4XDB5aBgykbxjoeFPJk27+F5Ra9eWN9jK4OepKktkV8/FiDMZHqX904m3Hc7En7xC7LoXGE0gSmv2SkTNCvj7n2PzkhyEJMvOFRZcpyDjeyOZvpqeU5a1Fw9zkIgjpCKAM8qjLTg=
Received: from CH2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:610:58::28)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:27:58 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::ec) by CH2PR20CA0018.outlook.office365.com
 (2603:10b6:610:58::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Fri, 11 Oct 2024 20:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 20:27:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 15:27:57 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3] drm/amdkfd: Accounting pdd vram_usage for svm
Date: Fri, 11 Oct 2024 16:22:32 -0400
Message-ID: <20241011202232.3354-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: df2f896c-55bb-425d-ea5d-08dcea3331e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lVnq2secMCudZv7hu0Cdba1bsGu4g29Ds1F+kK9M+KeeJsLFMVH+HwzwCC3u?=
 =?us-ascii?Q?rdN8ueTsiagsaSlGUvfEV5vi8j3X8WMTC+ZO/yYDPle+o3LiOQfU1qcrgPnM?=
 =?us-ascii?Q?GhQLnJsYKl3KCgdVoNwinnvSgDziNEbIxVwpHnjaUySCuQ8sCL+6VhbOeVCb?=
 =?us-ascii?Q?9bz286JpiHAUpwPpvMXF3SFvm6+Hz0Du8fkMBslGWm6W+zsoqrJCydva1AcB?=
 =?us-ascii?Q?6Zxn0OSkQ/VellaewfxQKyqKO85N8zUgMPShqzknciwqnUgc/Ta39vamSdAq?=
 =?us-ascii?Q?BN174/KAAC75nDNT7/FLhAT7hicuy4gomGt+jQDsAlGWa8T7TReoZLBKK9u6?=
 =?us-ascii?Q?dJ65XsmXQ1HZuJOZL8LmrPg8q/VfcUNTE7r757jBmoMInR3TBqrEKDLo/sfw?=
 =?us-ascii?Q?ee29/TxTKhqcHGpPMX7os12k6ZrARU5ESldrFnhDPF/+vH+sgibp45Sl8sbj?=
 =?us-ascii?Q?gNAoSRnEAAI7E8OW0VJrbE41WeQlp0qDQenIB+ecjheU/e/gnMLXZ7EZxiot?=
 =?us-ascii?Q?APeulHJYAs691yFRAKoNlLI1/ZWkjEtHld/TCDnj0Tuf5NJoh/L7sJcRyHUH?=
 =?us-ascii?Q?9QT8kPKysi01Q3Djc7qKMNPHF5SlHZgoLaaFol4Bu8c0/8ACQgXNMPV/OnTe?=
 =?us-ascii?Q?GQ+/7OSa4EvQHo0AUUV6Q3Nk2p3XbyTGigV5BnRssYQu0meFLxQwHp1aj5Og?=
 =?us-ascii?Q?TvnPyGqNqKHJ9VFoOh2j4+rBRDJ4kdxFX/K0oJrLyqLriagXlJNY3mbhQhEN?=
 =?us-ascii?Q?KlbuS2ElARVkotI96TUSasLQCRJFIYzYutTtJTvZ6H3RZ1CPzVapRKJIlYLg?=
 =?us-ascii?Q?jjEdrmFgAIA+0jwPmyz/vih2GI3L+0jF/cwR1a9WuQPFFOA0weOtfT6BZL8T?=
 =?us-ascii?Q?5w31JoVjnvumfsMsg4M7HSmhKZoM9kC9UkNt1HapxrYC2gcc8Y5IL+O7es8h?=
 =?us-ascii?Q?cJO27jyOXx54u0GR/mB6ec7uGAwOZPUDkOQj6fyGVtb8k8YrGLP9Cggrc31w?=
 =?us-ascii?Q?9cHzMpRzEJ7E8Eegpl/8/ho9osuCI6Qqz6dShADzhuec4Y9OLsf60Cw1d+RW?=
 =?us-ascii?Q?rsHE8pyNZbIcPcqH7B2ytlgKRI8DyWqBXML48CP53IG1C3nInGsGKcDmETDj?=
 =?us-ascii?Q?uE/ZYqQEQClkvsMOIZZbJlIigUH42EdNsxt+4AgNCigdPuo374SPOJnURI77?=
 =?us-ascii?Q?RoX04K311udQck5mktYcxXUuJqjjugMmy622kN+TGChGy7GPkRFpmtZ5aKot?=
 =?us-ascii?Q?Giir1H7ztYgcxHNdt2H5hCiSg694hjKkZRo0kBOKwATgm0GOlB2CGIK6UFch?=
 =?us-ascii?Q?iujXCoxaGYVdmZMKLod74/WPIyUJItUBZEh5gCv8YXHfPnd6sPitboCbvuuN?=
 =?us-ascii?Q?5WzmKoNkcI2vs5fiAIsGw/0UgEeP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:27:58.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2f896c-55bb-425d-ea5d-08dcea3331e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
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

Process device data pdd->vram_usage is read by rocm-smi via sysfs, this
is currently missing the svm_bo usage accounting, so "rocm-smi
--showpids" per process VRAM usage report is incorrect.

Add pdd->vram_usage accounting when svm_bo allocation and release,
change to atomic64_t type because it is updated outside process mutex
now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 26 ++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

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
index 857ec6f23bba..3e2911895c74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -405,6 +405,27 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
+
+	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
+		struct kfd_process_device *pdd;
+		struct kfd_process *p;
+		struct mm_struct *mm;
+
+		mm = svm_bo->eviction_fence->mm;
+		/*
+		 * The forked child process takes svm_bo device pages ref, svm_bo could be
+		 * released after parent process is gone.
+		 */
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
@@ -532,6 +553,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -623,6 +645,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
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

