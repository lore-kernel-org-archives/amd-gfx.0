Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DABFCCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC74B10E6E3;
	Wed, 22 Oct 2025 07:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2mDYm11";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066D710E6E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5VjrkLZaiWVluPSbjS2VJ+7Cgb61091zEf0QkkAZ/LRkSue59BuWWsd+vaD719jSZ1MDA2ZYPVkCIVwg3QFjGZ9aP7DC3t58fzhB0Fr3xUeIyyVKHcXz4PrKkX7QuJ6/9En2L/Om1NNXw7f6dGUmO7qFlO5gyXb6yx3JSfJcIDloQuwN/KZHwW3KT3hzPFuKUrLZ/ylVFEret3RB57pbgayBrlLseRpmeDylW8YfP9c64ptQAnEuKCHi5octpBzfx5f5GKFdzYxoswHKPwBW3/cJKxs32euQn6wDeWZuQzwnFqUheP1e+Z/CaDJTpstbjoOhLzoJ8NX/YtItdKtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpuR/2AOaBCdbMkhgCHJAhS8Bag/aUdyL/PZ4dYFQzo=;
 b=QW7CAgsl+flpxu1ZRvNJ7BvQdtD4IzrSlQrBOVCm3Epg6kwNIe1qbRxg4QbigHmjhuBsn3xRJETVy6Bm5Lbb5buESElEDil0xJVby9XaXt0MybubRJmfnbxGMDat/zFjEPF/4aFiyEHYKjgLOMfBSbbxLu2w/UJJCjWY2CTvJ09p23dn5UVuM0pu8bcVq/chSJYv+jVyuKM00ppbn79xCIT30BPZjXW5pTRoMJ7hCMZwJ4W6p7GuUrrorXtBQtTpzI3DrAerECI3clYS8HQnpZ0IaVwu7lK36k7D2Vq5AbW5TIcCEezOyMpQgiX7ZKGjbbRKtaJ2qaDOTQCHrHseXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpuR/2AOaBCdbMkhgCHJAhS8Bag/aUdyL/PZ4dYFQzo=;
 b=O2mDYm113Y19ZnGPp64oX/IWXx1Uc/td/StABDGpXXx9Ed2I9aLRhL+InrNN9RBEPF9NO9itU0aGZ49y7fcykUNC49fPDazAtVXHXlMZV/mRyPp+oMaEaHHbOLtklAFyjB/cuLuOcnKjA0ENN9oOQcv4V0eevTA9ZUKs2+8arIY=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:31:36 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::c0) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:35 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:33 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 15/18] amdkfd: record kfd context id in amdkfd_fence
Date: Wed, 22 Oct 2025 15:30:40 +0800
Message-ID: <20251022073043.13009-16-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: ff57e9d2-cfed-468f-6820-08de113d0820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y5eJ9sA5j+7+t47UzjdbWzn+kQImb8wJpnTmDSHVcDpSZhl/0p4ZIG6NaK5X?=
 =?us-ascii?Q?w5BS2doL2/6if364vsDoYbWVcdinJG7pGTb1y+WN5F4bFHkl2F2z06CJAirr?=
 =?us-ascii?Q?WzXQBZySUNbiFAZvMCLthwlgm2Y2kX+UNU5MeRZtsmV/Y9gB81gCY7EOjVlI?=
 =?us-ascii?Q?bJHfhkxiKW7uw/8gG4lk0jBgmX5LAzIKnZrMr9rtLTadnhJ4E5Cn3WZo0MC4?=
 =?us-ascii?Q?NT0PF2vtfhlHorM1rjmDyR/wQCS32yo4/CzKp2vGne+UJankHtRAIpwZsmkw?=
 =?us-ascii?Q?chBqW70wR9WeCNv/c9+ytVU570olokTnfbP00qXz415AnvXgNz1+Ny4VH9Qm?=
 =?us-ascii?Q?VC3g666Z2Ohl2zyyPTy6aImb93XgKzDHotrNwYzdu50clRilMTIoKWaDfhzz?=
 =?us-ascii?Q?vqm5dLSCBuTYFioIMc2yrWK88KyEo2uYpT7KtkUJs3IPzbzhE68c9GIHCkgL?=
 =?us-ascii?Q?isALFqA3tMTqsnQQa9tUA357P5PnRK0pQjgp3H5cgPlOyiG7UbLkIxs/oASn?=
 =?us-ascii?Q?DfN9gomw83GOsRgTKjSbyxI1qIsK+Q7eNugaVBBVP70gdc3jd5obCUoMN0Qx?=
 =?us-ascii?Q?91WtH6W4RxrDDPbdhXtE/OSb4DLqolxnoNXME0mxgVf+aKIxkJJ7qb265B9S?=
 =?us-ascii?Q?acwsZ0cDeTRKgsB3lvCN7f4l4qsS+BUnBThHqloVDPM/dX5PV8PFF9hwyy5l?=
 =?us-ascii?Q?LZEROQuY1J7qMKDvX3FU9zAw5NblD1H9nk9lnG8mCQlKpdJFoQxHAlrEd2Uh?=
 =?us-ascii?Q?5375k55gcdeX9DJ98u2p+AGx/Wp0B8x2jQWClqcNHi5x5T1fk/TWbQhP+JnJ?=
 =?us-ascii?Q?hggGRhXfz9jwPUZchw6HxMBOJgD2wuym+teNlb9weoncVom9TWl3tResE+vf?=
 =?us-ascii?Q?KEAR6llqe94IlP7vnI1qti8e4qpetqPCOIqL6/AELOVCGwld3APeQewMtcAi?=
 =?us-ascii?Q?QHJy/RZzDCLf1r65nRh/xtm5rOajBI6i6xfwgpg3M3pzB3GfkqEujeQVziZg?=
 =?us-ascii?Q?y2T5tdcchx4LVP9heH4FKfbIx55wyri6EGkgbqhql7eJ1uJO3NHrRtGUW+62?=
 =?us-ascii?Q?6CginX7nj6lp9wuyGNyyCVuPSJqsckXjE+cD+iA4oPMtjAQuoXIMETt6FRqv?=
 =?us-ascii?Q?eaMYyVyb2rQ9b6vS6eWot1IP4PJ4pmWw1k7mbUPO4G2/Sh4a5Etewo7+BF4E?=
 =?us-ascii?Q?d9SgjIsCqXzDMg3bTcPTfy06+kiEH0otBGkMbcOTiUO2SimTOKkUQxxAJY1F?=
 =?us-ascii?Q?W4tuyr5hpQGkVppy1X397q9QJHJUPqg5uvip9DdRhP0lTCIv0lViYRztklK/?=
 =?us-ascii?Q?8B6UR0hd+wt8LS+kM27fCLqT8G69rgX3sXgrz4R29GOVEb0Dphkb0fzEdpM+?=
 =?us-ascii?Q?ZNmYpOeqfT6LLmbL9CnPUh06C24dO9KkCO7N5kMgj4My3cJoPHJMAfJj5wfM?=
 =?us-ascii?Q?7gzTCeifCtE26F+XuTOR0jmIOgXxKQNJZP9NfcVryC4Yk6gte6sC4x6yKLul?=
 =?us-ascii?Q?3m7Zy4bQqL71tkUW04fWUfb/QlKejrRmAFJBN+wsmyeV/BcFFfoQ69Y/qbO5?=
 =?us-ascii?Q?v9EJuryjYpeXZCu2/RY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:35.8871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff57e9d2-cfed-468f-6820-08de113d0820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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

This commit records the context id of the
cooresponding kfd process in amdkfd_fence

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 28b54d7ee1f5..087e8fe2c077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -98,6 +98,7 @@ struct amdgpu_amdkfd_fence {
 	spinlock_t lock;
 	char timeline_name[TASK_COMM_LEN];
 	struct svm_range_bo *svm_bo;
+	uint16_t context_id;
 };
 
 struct amdgpu_kfd_dev {
@@ -190,7 +191,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo);
+				struct svm_range_bo *svm_bo,
+				u16 context_id);
 
 int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..4119d0a9235e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -62,7 +62,8 @@ static atomic_t fence_seq = ATOMIC_INIT(0);
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo)
+				struct svm_range_bo *svm_bo,
+				u16 context_id)
 {
 	struct amdgpu_amdkfd_fence *fence;
 
@@ -76,6 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 	get_task_comm(fence->timeline_name, current);
 	spin_lock_init(&fence->lock);
 	fence->svm_bo = svm_bo;
+	fence->context_id = context_id;
 	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
 		   context, atomic_inc_return(&fence_seq));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 722440d62290..20f834336811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1405,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		info->eviction_fence =
 			amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 						   current->mm,
-						   NULL);
+						   NULL, process->context_id);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
 			ret = -ENOMEM;
@@ -3056,7 +3056,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
-				NULL);
+				NULL, process_info->context_id);
 
 		if (!new_fence) {
 			pr_err("Failed to create eviction fence\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9d72411c3379..04582aef1b41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -585,7 +585,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
-					   svm_bo);
+					   svm_bo, p->context_id);
 	mmput(mm);
 	INIT_WORK(&svm_bo->eviction_work, svm_range_evict_svm_bo_worker);
 	svm_bo->evicting = 0;
-- 
2.51.0

