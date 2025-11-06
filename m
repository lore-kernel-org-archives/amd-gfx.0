Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A38CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE28A10E80F;
	Thu,  6 Nov 2025 06:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dhiSnY3g";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F2610E80F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcu180RL4a8x6cWlVnkD6GA6yXu6G44/r8Bc5/WrlGA4liXsaZWfEiPZwzXe9xx87zH1BDrDLpJlvMZeq9qrCY+TTOyQDGW9Gup0NI49DtRgeA3EQKdjwreDiyY0+wDpOk1OIW0idjfV35mY7q6cXdXhIfG8CR1YBjs4Jz5GpqATw02Liv3QPD0blQkuimmsuz7Rr7fYxpfaNFN1XCA07kHNf2CUrzR+cFKa84Azu7Ywg+T7rNvhJtqkP+mIGQXzEwYhG8ZoaHF+tRO2wc1APL1rLDMNfnADLWKCW+jRx5RuoN6O45wafsX416P+e8CI2i1RqjhRmUaG5XPHXdVzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpuR/2AOaBCdbMkhgCHJAhS8Bag/aUdyL/PZ4dYFQzo=;
 b=k9fJWtRvfmcOFw8Fuz7Bcxh1X6llSNmk7UWuS2stU7j9alUoo9Zt/bHhnVBEjyVh7siIw5kqdLzHMgj80ioaR35ywdBfyy7Sze2zeR4PGJl86yVFuBduDk7aV33uW/fW9mBk8uwBeePmRhjZmdCkcsNRv/oz2FSYf7L8O12qjSlKDJ+W57gXett0S+M9bfkhClU9QE+2pep2KRkLQHMG8mm2MjXblxX+9S8RDwvo1kWBW/3aYqOM7L5xOLXRgmAY8yzaSf4Ilk+id1J9NabMHeek0oos6dHV2TNNYxbaUkbcm36JJhMW7M6FsgkLIaR+hdN9AZf68BDJVWg+GeIi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpuR/2AOaBCdbMkhgCHJAhS8Bag/aUdyL/PZ4dYFQzo=;
 b=dhiSnY3gDSowKzDKzqhbsNZETQfbfnMtu0SPhhtzjmDfryqlnfhiS9lglv5jMxQM2uhEPet18Hm21gNjkD5LQZ3ADUsk9lhA67OMnTAw4MeLev/Ana9T7cKipxuh6hd3bjhIdO6u1A20nmxGGvN8396bnPk5f6t5ugZKaaJC1HQ=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:32 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::2c) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 06:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:31 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:29 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 15/18] amdkfd: record kfd context id in amdkfd_fence
Date: Thu, 6 Nov 2025 14:07:36 +0800
Message-ID: <20251106060739.2281-16-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ee32be-1d73-4e3c-c953-08de1cfae9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uz8fv4dZYAZx73M5FmwjPZems7p9rbEazCOtPJ89EN/2sTE1GZflr8bqN7Is?=
 =?us-ascii?Q?d8qDp+hKxZWZRatO9gc2IHIF3CD37934f6HROHUH/f7/9XIGkL3boWnaPFX6?=
 =?us-ascii?Q?Iuv6HF2DHeMgWu95FFKMeOnvar9LC1fgt6TrqMsvkL2vAXr08dBonAGduwoL?=
 =?us-ascii?Q?MUOJbDTVI5Kc7uIfkFt1hhYLU5w3qETzl3F0/2wEuBZ07iFVpeMfy6oWhG1d?=
 =?us-ascii?Q?FEYLkIp1S+7RTMuGuNkqcuMozy2bl81KXeEhxLMB2jREiJVZLp3Xn1K4M7N8?=
 =?us-ascii?Q?EC31Z2d4u9W6S7sUGQrt+NI4gLeQMnVIsVpKgTgNEdOlBCYDuVvmPktvP26d?=
 =?us-ascii?Q?KtdpRcaJOVaG0iQuv1qDzxY2VXRc5iTkfIOszT5veyYaGmNCKt6c60a42qH4?=
 =?us-ascii?Q?37cOn+gvIAKY3vE5AWyXLiQTmWvEGBNKNIi4mjLwuDlPZQvOozZNtarc01wv?=
 =?us-ascii?Q?EAZr0ihohWyGJ0yp/WlJ52Vma+eRz55tBARkrdaGVP54hyKaBYK2xycLayo8?=
 =?us-ascii?Q?ojyNnln2LoeWGlZu98c50XcxPm/Mn8J/2tRBSxMq/JLJwZ3dgJhxg48xua0X?=
 =?us-ascii?Q?totq3IQWeMg1lMQyksSQ0joRlr3DqXaRiKWyBGyeGnWBv2NiTcewQ2FdRAth?=
 =?us-ascii?Q?cGIRlPCnhfvHK32xfycVMe141V5fv2nBTnRbnUj2aY6ccf3F1B625XXPevOE?=
 =?us-ascii?Q?BCKdMolYzDZHOj3jLuTfuuAtpcUhzuknwmsHxX/X3E5OAW08E43rDjfwNz0I?=
 =?us-ascii?Q?soq0fxg8tASWBrSxismi6zzKEWd7aJk5qq1IcdVYZj3etBmhAD51ikhssxkU?=
 =?us-ascii?Q?JI+NJru6+3JYrBfz71amZte+rvScufg8YNH+YXdiN7SoW68dC3+Pzj5WSHDq?=
 =?us-ascii?Q?mWpwETEpiF2HF8KJSTZEzeP99Xz0o6ZrashbnPNvqIZAdpkfJDDHdaE84HdW?=
 =?us-ascii?Q?gUqxrCM5kU5dxOutBT945qNVH02PoGPpPnOU+58tv6TF52UvcO+z2VwI1prD?=
 =?us-ascii?Q?3MWGA94+4VaUI+BLILLP1KJzGXkOB4Tt6bn+6i6AJBQ069gCD3W1qMP/lG0n?=
 =?us-ascii?Q?jiq3kAqONhTwA4e6PjkEV3AU86g749g+6Aq95P0DWQBIogwJQSXn41mWnntW?=
 =?us-ascii?Q?A9R1FMPCSa7aH0fMUtgad+9HOFV5pl25FaGJml4AIkiL3X9fBwstj6KqyND7?=
 =?us-ascii?Q?p6OYLGLmJiHDGmzwi0HGQI0W4qoljxHFoXgNl1RXYiuJttWH8iJbwI7N9Stc?=
 =?us-ascii?Q?B4wTXc4pJOGuY0DMbxebX2NMrDqaJxI7K6rAKJ4SQG+QgW1jW7PR8vW78o0x?=
 =?us-ascii?Q?/slV1NDbLGawEB84RQSe6e71Rw9Vqnl56UhdtunADHDYTqzOBu/KYrUcqmqI?=
 =?us-ascii?Q?vBAvolqsqpjmkJgzbvAiUiiQHAS6mWpyKVMYGvfRRoYdtyfEMCiZ/t+hT7jQ?=
 =?us-ascii?Q?RZ04o/AnXdNPDUjmBb4/uV3ko6YBbozRaSo3hVIvk6oJwss64fFbpyN9YlTI?=
 =?us-ascii?Q?sl7L8pik5SR1jo8ZgmTOi7dRjtpB0kTU0wM65r68b0bL00i5EeB66pvhwNGm?=
 =?us-ascii?Q?iDHluhbrJ9YdDqQ2TsM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:31.9603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ee32be-1d73-4e3c-c953-08de1cfae9ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

