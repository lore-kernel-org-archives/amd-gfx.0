Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7616CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743E710E587;
	Tue, 23 Sep 2025 07:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J5MsqYr5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F1010E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh2BZSrgbby4b6+sf8TakbsVQINhaepscIyaom5RK17Ea5Eyuy5lvWLQgBh9Z/4Ce+23vDYdnA9aMdypdPgbtBfXs2JMTb4qb1v/GEm8gbocvwsCwQsFUfqgHMwOV4FOjzOPG/ZjDItOGVOMHhd92IN8Txwrb8FRqFBbG+lL/Xks80F4qtDsEKJut4VQ8s9H6cUIwHKJjwlnIwe/KSg382RlVK/WryjLDJvhOlrRVQQ5c0JcMCA2ubgyoMGhwUFLQiNLjLCnZZeThqWpgGVhCBP8BQgd29np/stpDKwsAAnD480+cSgRQafIMDsPz3IXYrrPjdCWnpjw6BSi1OCtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjdJuP3P1qEf+LazIsX2VJURCfLjg6qGnTqbq9AUtqE=;
 b=VMXigxzf6JAdWk0PrZJGxqwRTcasT5K9Xu46XKnZRokYLgRYyaN5RHZEsmXox4sefSdH8MYwXB0t/+oMyIBEK99q8bJ2nbw+QBNjHq0lSqBfd83poLWLo6bLq6YWN+9M6DJTvERVCZGoNxk4i5NV2lstR7jUCSlGwyVEKgEd8I/L01VEf2ANlvtkq996U3mFiikdhpyj0BdGsSUEd8ncmmFMqrZhMQHLtm+WByIyS80HIFNgELwALTMHwyrKw+5uQfl+UBJpaUdIt0XvRl1dH5n58lAZet8TTbz/1381yAwJrL9rJdeInxWN0rpP+FpcO6v6KN3kO57rmsDPZQ+Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjdJuP3P1qEf+LazIsX2VJURCfLjg6qGnTqbq9AUtqE=;
 b=J5MsqYr55u5Xz6uDCTueqbxMfU0HwuVQGTnHG9orwOhapl5e2y/iQjEqawP7OHiVwpN3w5v8LR2vWSoBPo+DunjuV6ZOzspNw1URuRoNO8he5ZSWT/YYVHNeyXFffiEUHFF32kSLIW+8Mb+x6YDC8AOyc3eJR07+2+FtJ8Vjb4k=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:27:00 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::d5) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 07:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:59 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:56 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 15/18] amdkfd: record kfd process id in amdkfd_fence
Date: Tue, 23 Sep 2025 15:26:05 +0800
Message-ID: <20250923072608.252345-16-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f000c2-4c89-43f7-d3b1-08ddfa7295ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKl66ppCLmsTqX7E/P0Rv2ZoU9YBm+soz1nlDqub5rjyuIrZ3R02uH8awlHd?=
 =?us-ascii?Q?V1GkB9EzHJHlAVu4/iep83CrTdDGkG/Hmce6v1PE1OkhC6VM+87prYNdmLAJ?=
 =?us-ascii?Q?3Uv+2mpR9dfQQPsEk5eDV2pgLQ1D0LIeijOYA8nryobzXz8YwnrLyoB+izzR?=
 =?us-ascii?Q?UBcCXSxdnbDu1HHDukArMiUC30RaETU1g3oCJ/k6ROVM5uy6IfqisjZhsoHv?=
 =?us-ascii?Q?6XWp0Zu7QAtwNu7N0zaGtTSzNw3TrGIjCwoVRBsHFxs4rI9eoYH3rZ6ygzND?=
 =?us-ascii?Q?PbLWj8+HArzeqmopfk8FrmbyblhRUJybE3oNywP7Hw8R4mujuTVR5OOZhRnr?=
 =?us-ascii?Q?+Qu1alh5XtOZ7qZ1+SlF/IIZBFBJyPPEaHSbDvejZZWa4pf/ywvt96pEtaIb?=
 =?us-ascii?Q?sjSIsptLWybTpn/59VBpjWpicdCSnaeioeaExo3EwdbeBoPXywb/DGlSwroT?=
 =?us-ascii?Q?7XKgJttfpCgr8/ziCdhDETkt/O4l8+A5ytK2POgferVOLOEiRhFaXOjlIacu?=
 =?us-ascii?Q?6AH0lvmzITHruBtNH1Q/zuVyp2cOAfEkYWgK4W7wId0LgWb/lt5s+aIyE1nv?=
 =?us-ascii?Q?9k8KUJIzD/hwIN87jq0Bxpe7QEYmF8MMlW7T3/70o66P/dhwY8K//WBfVLZX?=
 =?us-ascii?Q?uSOk+08ET7TXKP5eOp61njCWawvc17ItNorKwE8/N61DFsx5l24OdVRave7u?=
 =?us-ascii?Q?YmUy7Jl7DljMPv+i464wWsgYqgiSL4RkBdm/EFUNZww9NFTiQdTfWvwfV3HN?=
 =?us-ascii?Q?P/I9wPBQvgvVf3+lSvtmYHxd79iUjGofbq8JqnG0g6orXWX+IKpdFPHk30Ag?=
 =?us-ascii?Q?iWtsaoBHMXhMlJJs18YJuyTlhael35WCltvpjhspmL9abPZxb7TShJyV5ZY1?=
 =?us-ascii?Q?bUKO8/ftmTkN3D4Kc6/rMyMuyT5JaI+gjqp252/7GzECUGaIO/kyZR9HduBP?=
 =?us-ascii?Q?evknnlvc8WptQocXsf4M+aW8widiiM1YmOgUvUKbH3HF1hCDcAC8AZSwNy0r?=
 =?us-ascii?Q?3LugWmATi0OqFoFDzctwbPbNVeU2oPpChPlqZ/UIpi5wvtpnG/sLreBIYkz3?=
 =?us-ascii?Q?wlR02YWMJJJ8JUzXspxpqRdTFKazOYYJKwUY6+1qRnVls7AvPb1At3QiPGGk?=
 =?us-ascii?Q?GGllbNatQLBZWefOJHaeYsLZUsilsdQZho2ynd9xl5CzK2sY3srJaXxcweIE?=
 =?us-ascii?Q?vmofNVgtZelPvyZ+bDExxlZy6We+CezGT7u9qHuyQtWuUzvc9Q4HCCd4vlwo?=
 =?us-ascii?Q?nww7VgrjssGh3ADGlu81TA7q90HUogRkujXzLmMAUgxnOQn2FawM4qFMcvst?=
 =?us-ascii?Q?LZrFvb5sUpVDDgKD0NcQiSQk41yHzM6qeGGKqwQZlWZexG8IB9jN4eesCDde?=
 =?us-ascii?Q?TCakRGRXdMZayNjkpRSbhUYk5oGl7o7TZdZBg+AclGdNGpDo7FXLHUznrcek?=
 =?us-ascii?Q?P72nZbBedefvb4ZIwn8vwu/RuOnSrqYb+LNXjhfVCwf11ihzvGH6jycmeG6m?=
 =?us-ascii?Q?LSg413o/+xKx029pBUGRolAK+yL4oG6UrNz0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:59.9488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f000c2-4c89-43f7-d3b1-08ddfa7295ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
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

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d867984a68da..f3e497da106c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -98,6 +98,7 @@ struct amdgpu_amdkfd_fence {
 	spinlock_t lock;
 	char timeline_name[TASK_COMM_LEN];
 	struct svm_range_bo *svm_bo;
+	uint16_t process_id;
 };
 
 struct amdgpu_kfd_dev {
@@ -188,7 +189,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo);
+				struct svm_range_bo *svm_bo,
+				u16 kfd_process_id);
 
 int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..a6ff4d82b029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -62,7 +62,8 @@ static atomic_t fence_seq = ATOMIC_INIT(0);
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo)
+				struct svm_range_bo *svm_bo,
+				u16 process_id)
 {
 	struct amdgpu_amdkfd_fence *fence;
 
@@ -76,6 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 	get_task_comm(fence->timeline_name, current);
 	spin_lock_init(&fence->lock);
 	fence->svm_bo = svm_bo;
+	fence->process_id = process_id;
 	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
 		   context, atomic_inc_return(&fence_seq));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 723d34921c12..6eb568dde5b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1401,7 +1401,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		info->eviction_fence =
 			amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 						   current->mm,
-						   NULL);
+						   NULL, process->id);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
 			ret = -ENOMEM;
@@ -3034,7 +3034,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
-				NULL);
+				NULL, process_info->process_id);
 
 		if (!new_fence) {
 			pr_err("Failed to create eviction fence\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a0f22ea6d15a..f3e649e8d518 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -585,7 +585,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
-					   svm_bo);
+					   svm_bo, p->id);
 	mmput(mm);
 	INIT_WORK(&svm_bo->eviction_work, svm_range_evict_svm_bo_worker);
 	svm_bo->evicting = 0;
-- 
2.51.0

