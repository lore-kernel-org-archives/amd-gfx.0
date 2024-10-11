Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74DD0D7B3
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFD710EAEB;
	Fri, 11 Oct 2024 15:01:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07TB0zrP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF73010EAEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvj35SjDPY6rrk5ku/yA6xbZLwTsfTSHWfcVs8o61LG5kff9StZKDfjdy84ytap4a1Xd2QS4F/rv2N9waWWUSiwIs5oxdbx5iexDReB/4s9cV/v4gnZlP58fD9txmuWbXZJu1OkewS+mPLUVxpMyuDpt/FJs8nIVyNkCIBiF7egZK8CAPABygFmOLJkM1QKFLxvAnE+6REcGljJIinQikSR2OgKwlQ7Sbnkr0w3WHh0yeHBEPO9D1I+zqx0jWO1FwAxNnamhk2T9YVYXPa9fjV8PYhEJ23CvR2rZsBXrD8zmjTzNDZExUqjwebkOmr9EK396EZx/7csCbklYScIh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDm+TQ/FDJguIRHdwaVzED0oiIdmaoNocYtA62Hgb5A=;
 b=dqOeUakeIQNHLBcIvjp0czJJ53r8/nQdOaHk5yj4s56digzUWGMoUI9l8qx3td7F30luciVyoCdnhMPSwU3+36Psbxc/0UjeW2MwGmD5MgJmLhptIbdIxs0vf/4GEBzqrBbDG+lOTwf2y4YZRJvBSrL762KG5ouVxkDTzNIX1DV8jGcMyWWjtIUXOJjxx721ftCrTS245DtlDyJRiaQWh56Eez5fnb4fToWR0kVajRd/PIiAxRBJLDSz1bLdbCV9tU0aOThLVYJp/j34HsrUtOkaFkBytEdc+CTYn2x9MtKQpqNAHMCnDvqrVcxfzyUlC5/+zL3vjg1ZefnBb98Nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDm+TQ/FDJguIRHdwaVzED0oiIdmaoNocYtA62Hgb5A=;
 b=07TB0zrPydqeHf0xXR/H7P7ZmMT+rKQ4krO+akHalMYXL6GnSqsW37UPtCGd03ZsqzqX5bZGOmOsaoyOHjD34+yg8T/HvCpMVdDve1TDI4/p+tVa5UPQJwZ2HW8TYw60pZY5hKc7XziHANFeuuHxzjrmn+9Icielo80GdCLBXrE=
Received: from BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:01:07 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::ba) by BYAPR06CA0072.outlook.office365.com
 (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 15:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 15:01:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 10:01:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Accounting pdd vram_usage for svm
Date: Fri, 11 Oct 2024 11:00:06 -0400
Message-ID: <20241011150007.26310-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241011150007.26310-1-Philip.Yang@amd.com>
References: <20241011150007.26310-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f43356-e505-429c-5ddb-08dcea05890d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ggdIDonV4toW+IxsPOIHmD7vNG2GNxbF6RBe9iMzxBsTDrfZ4aHX5dHWYD/d?=
 =?us-ascii?Q?pgrPUy0nkKqmo23cA67QvlHBdntLzw4M2eo7HY0CQcRDR2s9WcXrPQW3yFow?=
 =?us-ascii?Q?4pm+Xe+OuSYjWJfnxHVgQ/uFbbaKm09I0U88ZrBokBunuZAwHZUbF9MTNjCn?=
 =?us-ascii?Q?9V9uWeFoWpbyIsIQR8SucqGPW3RwIi6sGjKIiRveTBVWRT1voId4ZAEybCoc?=
 =?us-ascii?Q?uF3mHUUPHKn9Cw9aoMWMfNZq7KHDjaIT2bAnwzvwuUQzu3l6gMDg34ejKnD0?=
 =?us-ascii?Q?Lpb2AwcmDfbIDLtskAzKz2KXP1ejDE1rJyX6d+bM0RYSp/wxQk+1hFuoUHp4?=
 =?us-ascii?Q?8kOgHk44LiNLvnrqrXVbJJaYS+4T2zkNlo2kBPDBzkzLYZx7VccWJbLUVY4T?=
 =?us-ascii?Q?EC/kUCyw68QnoEc+F3OKgeVdxLWnJJz2rB6mAz4dY533fomEkO7qLfanpi7r?=
 =?us-ascii?Q?pNU/aXH+sYeR+3Eg14ek2kjys4eSn+uMBM1UNh9m86JWymhlTVCf/t7N4Fiw?=
 =?us-ascii?Q?YwD3NexYuAE0g2sa1n7hjx+vGcGSQDpQmiScz+xaoLli8Yb8+BDiqG74E+Xv?=
 =?us-ascii?Q?PMR0q3TCA69hPExtSn1Prpnen61aFKPqW3icIT9MnrLeIOWcyqVp0Oz+nru5?=
 =?us-ascii?Q?KcNY8OBT+lUTWSu9no3unf65WQpYWRimH/Euvaa6d87BbxDegmjNuh0BwPoa?=
 =?us-ascii?Q?4mj4F2Kd+PjSdXPfZB08bfcv7GYfT9SLKuKMvukun1xjFaG+mP1m6xf/ETn6?=
 =?us-ascii?Q?ucNyWVi+CkL/KnexLVbLh52kDcan4j55wRyjlEY+QDke92pqVqd7eaDl8D2O?=
 =?us-ascii?Q?CwiA+MrwuACj0FQoukL2PzFWXQuOfAVHPLx2roexpu5oOGeUwL1uinyGudaO?=
 =?us-ascii?Q?jWuwas/RPvdLwdCITIL5ZEJxAiMqp59u4h45Hx8Bm1wyt9+JavxtoK1GQDfJ?=
 =?us-ascii?Q?kFfzB2nnwPrXGefWyF9j1ymrqDfcPOGwVIpJS9RMJTaviycAlOtGhXOdwx76?=
 =?us-ascii?Q?x94bNzeyNhSoKQf9sXgWQCSjhbABBgjQHnN0+KfKWxg/PFZZjy+K3dCmStH9?=
 =?us-ascii?Q?VD+mH38BbWyWFi378f21vrreskKZQ4ZsqeNjVLe2OVeWTjTbaKA8rw/4uKzF?=
 =?us-ascii?Q?JxcY/rV0f6yvTZOykjwHJimOhRBMAr5ZMEvpjpVn7NexrzmC89AbtqeR9qSg?=
 =?us-ascii?Q?nSEhcZyWGuKc17WVnPp3auXjYcDDWKDO+XMEDFsnwmqxm61DGHB3jSqKmXXC?=
 =?us-ascii?Q?xMGNvnrzMai2FWwF7A708fijjqNPwdvAIG+SZ04CJoKUUZ3fewyGEDfRoz4W?=
 =?us-ascii?Q?j6AWtBuf/d9b8jnUoY5RN7KswLNYfNwwLvGvXaTQ2zTVB/zOjg6CI822U8GD?=
 =?us-ascii?Q?3yv6ZwF3/keg97lcYZfNYccFZTL/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:01:06.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f43356-e505-429c-5ddb-08dcea05890d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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

Add pdd->vram_usage accounting when svm_bo allocation and free, and
change type to atomic64_t because it is updated outside process mutex
now.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

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
index d40f6fb803df..ba501fffa556 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -409,6 +409,7 @@ static void svm_range_bo_release(struct kref *kref)
 		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
 	dma_fence_put(&svm_bo->eviction_fence->base);
+	atomic64_sub(amdgpu_bo_size(svm_bo->bo), &svm_bo->pdd->vram_usage);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
 }
@@ -628,6 +629,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	spin_lock(&svm_bo->list_lock);
 	list_add(&prange->svm_bo_list, &svm_bo->range_list);
 	spin_unlock(&svm_bo->list_lock);
+	atomic64_add(amdgpu_bo_size(bo), &svm_bo->pdd->vram_usage);
 
 	return 0;
 
-- 
2.43.2

