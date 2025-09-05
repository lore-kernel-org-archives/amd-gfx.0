Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2CECA1012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 02:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6EE10E353;
	Fri,  5 Sep 2025 02:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbOy/uMj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73FA10E353
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 02:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBagg43eJJT4s0QYVrBhNWvPK958Ht1HV6LmQ19Hls2ZDY0Jk5eFKVUdUWPYsvYrBNCRE5uVBYAeSHQFAnrTfHRvrShN0zdF4rGUPNzMloB8zLwDJXK/2zdl/0/JIJEgqsFa+HwyJI2HiYdJG1gau2rxcRa/7UpiCtVip0UYhkLj+SQPaW8KlRJUEDZW97ejf+fgTQGorcge/pY1YdNn1D0kuW86XfE1uYk0JPV8/2eBd8MfzGXfy7gtA2yW3U/wQvs7c1rprwHikk4dLxUXv4pAX4PegzTt80GgN+60AJFUyl7uhN0K+ZugnSRublLgm+gsTblvVC+66Lp98JhJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZemyt85H3szxQnnuCgLZpxC+rnDtJS3fEYxCvGlWqU=;
 b=Y13bo93EEkQdaw3Xth7tAAuafFwZZ1Vp4dNX5HZhq3dxO3KeRPMSE4UHBzpPzUztnKP+S6bhTw+F8mUi3/yvSY8JZ7AnsiPeFKI5YTfU2HOSebWOPuWhGFG8bXBA/kxeNMu0/aPqIKq9gQFD8OHY0VgW5wL6dY2omge+mXBmoyilqL0jUTY8i1/QsW8p8ZFdTJrKH8ReQhc7jtaqLpwiXKrp/bheRp+SaSTI2Sbm+BkiDXgSKT4CeBIaMhctbnu6/WnkOGZh04Ku0M8IpQ4BnCp8Bg54iQIiCjJtRYfuUQsuIVGmKZrGD5gAip7jH4A+f5g4lcgfjJ/h1ptTQLQTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZemyt85H3szxQnnuCgLZpxC+rnDtJS3fEYxCvGlWqU=;
 b=HbOy/uMjROZEcght2RZh5NOMWe7Q8LNBD01+0CsvPwsuCb/TMSjTnrUoS60zOJVYuMeRXkryZU//WtVBww9IqXjqGrhS4y1cWVeOZtOMupyGkAT0o33w1eS3qNQmyskvG5c2xsddntv5uTG44CznudmAL6SGj0brJv43oUjUiCk=
Received: from CH0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:610:b3::26)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 02:45:21 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::30) by CH0PR03CA0051.outlook.office365.com
 (2603:10b6:610:b3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 02:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 02:45:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 21:45:20 -0500
Received: from dayatsin-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 19:45:20 -0700
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH] amdgpu/amdkfd: peerdirect support address lookup
Date: Thu, 4 Sep 2025 22:45:05 -0400
Message-ID: <20250905024505.142456-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 3948bc4f-79a2-4224-217e-08ddec264167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/mVSMLjHF2Xw0pud3dYtEoqPXBRS2EWCVIC9PLvBFl67enfffBNnLr30AgJV?=
 =?us-ascii?Q?Byzdewi+w2p2/M9IAalpDZQKQbShvWI3gPTK+Ed7PkKXsou8nO3XjOx56qTx?=
 =?us-ascii?Q?i1gYwkIg8iq3kZgeyWmxCmXvFE0OUZAug/N4h1JkXKe+wD/8I/tFcbzxLAo7?=
 =?us-ascii?Q?i80JOU/gWBr3wn5wGm5b7ARllkfOBGhqn8rpNf85tg+2MWFoTZNWnoN9vgQN?=
 =?us-ascii?Q?8tQ17fBgSRCoSrnKpAbmMl74BXc5E5yGU4VcG4RW/0d49WJEDy0MFDXrJB3o?=
 =?us-ascii?Q?Jk5KR20ICYSO8UpEKKlSE/xO16mg+/CR2Ozl2aYldUegCQmOKyXXQkprjLNX?=
 =?us-ascii?Q?oNgP5c5x2zIseaeNg5CFfA6grFvBCcVa4ilsaGwvvixjBOYnaQdQQjXCqqoK?=
 =?us-ascii?Q?wOP7y9aGbwjbZ09j35q7OQQbXaE0uGLtRRFbCKeaSOjOY2rtNQvZsFfjGBTI?=
 =?us-ascii?Q?6QCMTWTs9LptQ1dn7q2AXcEhquj5TgSWlABh+Xc7jvDV0voGWsqFLNnyfsta?=
 =?us-ascii?Q?YYK40/Xaa+E7WnQBGsyVMIRZ1ivwWE4FwlKstynZlqVrPGjg+KzqbFxFrS/T?=
 =?us-ascii?Q?FMRVSQlj8nTHarVYG0chn8IaRmw325XMu63if12EKku42uPyK1lt7xp23P+T?=
 =?us-ascii?Q?TOBCPT/muBdTFCDBQB4W0kQ3fuUEJloIG1dKcKOuc68HURi7SncRjze7EwxP?=
 =?us-ascii?Q?NIO4zVrBHjiNIK2AuLF9l9FSeQuqpAgwX309XgvM1XMAF/V49Y0tH/PFQvHI?=
 =?us-ascii?Q?pakCGrRIbNNVohn+XouTwyfrxZR4PrC44NnrCep9TKP06n0QOdmJ9V98fj+0?=
 =?us-ascii?Q?dI4wc7tNnJiV50Lcv3DqPnrycunBr++KPBs0E8MjsIoS/NGT29ngkPk0V363?=
 =?us-ascii?Q?Jm2ZagjT2VNZDIZmE2fW4tph5s3oSZI6lXkAMpy/8EZICJPdq62aTJt//aLc?=
 =?us-ascii?Q?+WtPIWDP8LVE+LFY1pxISaMmbSTVkaNt3N1OjV3lv5sS2GQqOkNaksXq7gEQ?=
 =?us-ascii?Q?Lv+B3PcEBi6a+td7tW+E/0jxFFaNhwHG6CZsIdIsc6yO5ux+An4dGgI9F5rF?=
 =?us-ascii?Q?wYh+NvOQXhD/4Tm29q7dnFo+yS64zKXctEYPGDGt+l4u3oJwrZGYkQOMyGBl?=
 =?us-ascii?Q?ML7C3mDHEhw+d1GLt/hGiWPKaon/MeGwjBRrCotis/kopUyL0fMZxzwqQYrr?=
 =?us-ascii?Q?bipcP1q/aSfFem3+AK6ys/Pylq9JhaK0JVRcLh3nJXEXNLsn+agrdQv7Knxw?=
 =?us-ascii?Q?LwudxY8gADWlwjvcyC5bms2+FsqUojI0vJqcVcoTkFFOy9g9BZLZTcTkSRqv?=
 =?us-ascii?Q?Jujsq9eRmlGAQKXMVWFHTRIP2z+Si4KeIZVz9hcyGw9YCOl6/wu2XaMkd2m4?=
 =?us-ascii?Q?qbKFlvXfvuPIcic0WPTt3RSGe/7s4nVFrR8ZRpTflWrs4gbvyKwVHWi69k6N?=
 =?us-ascii?Q?Oo8AxDBRe4+0YiJ+J3uUwux1TTfRtda6DRlZ3k7DjSZFuTeZ0rbHxX11lnjw?=
 =?us-ascii?Q?sycT3g6qwoAz2VFuZgbjkE15cR+ctfmrewQZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:45:20.6107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3948bc4f-79a2-4224-217e-08ddec264167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

Add look-up for the BO by address. This is required for memory
allocations where the virtual address are reserved outside of
KFD and then later mapped to GPU memory.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 41 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c | 61 +++++++++++++--------
 3 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 81afeda39667..37a2beece6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2667,8 +2667,49 @@ int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma)
         vma->vm_ops = &amdgpu_ttm_vm_ops;
         return 0;
 }
+
+struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
+							unsigned long addr,
+							unsigned long *offset,
+							struct amdgpu_device **adev)
+{
+	struct ttm_buffer_object *bo;
+	struct vm_area_struct *vma;
+	struct amdgpu_bo *abo = NULL;
+
+	mmap_read_lock(mm);
+	vma = find_vma(mm, addr);
+	if (!vma)
+		goto exit;
+
+	/* Confirm that this VMA belongs to amdgpu */
+	if (vma->vm_ops != &amdgpu_ttm_vm_ops)
+		goto exit;
+
+	abo = ttm_to_amdgpu_bo(vma->vm_private_data);
+
+	if (offset)
+		*offset = addr - vma->vm_start;
+
+	if (adev)
+		*adev = amdgpu_ttm_adev(abo->tbo.bdev);
+exit:
+	mmap_read_unlock(mm);
+	return abo;
+}
+#else
+struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
+							unsigned long addr,
+							unsigned long *offset,
+							struct amdgpu_device **adev)
+{
+	pr_err("BO from address look-up not supported\n");
+	return NULL;
+}
 #endif /* HAVE_STRUCT_DRM_DRV_GEM_OPEN_OBJECT_CALLBACK */
 
+
+
 int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 747c9669069a..9fbff8dec861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -175,6 +175,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
 					bool enable);
+
+struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
+					unsigned long addr, unsigned long *offset,
+					struct amdgpu_device **adev);
+
 int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
index ed93247d83ca..3341f40f2a23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
@@ -170,9 +170,13 @@ static int amd_acquire(unsigned long addr, size_t size,
 			void *peer_mem_private_data,
 			char *peer_mem_name, void **client_context)
 {
-	struct kfd_process *p;
-	struct kfd_bo *buf_obj;
 	struct amd_mem_context *mem_context;
+	struct kfd_process *p;
+	struct kfd_bo *buf_obj = NULL;
+	struct kfd_node	*dev = NULL;
+	struct amdgpu_bo *bo = NULL;
+	unsigned long offset = 0;
+	uint32_t flags = 0;
 
 	if (peer_mem_name == rdma_name) {
 		p = peer_mem_private_data;
@@ -187,34 +191,44 @@ static int amd_acquire(unsigned long addr, size_t size,
 	align_addr_size(&addr, &size);
 
 	mutex_lock(&p->mutex);
-	buf_obj = kfd_process_find_bo_from_interval(p, addr,
-			addr + size - 1);
-	if (!buf_obj) {
-		pr_debug("Cannot find a kfd_bo for the range\n");
-		goto out_unlock;
+	buf_obj = kfd_process_find_bo_from_interval(p, addr, addr + size - 1);
+	if (buf_obj) {
+		offset = addr - buf_obj->it.start;
+		bo = amdgpu_amdkfd_gpuvm_get_bo_ref(buf_obj->mem, &flags);
+
+		dev = buf_obj->dev;
+	} else {
+		struct amdgpu_device *adev;
+		/* Memory was allocated via KFD without address, then mapped later */
+		bo = amdgpu_bo_from_address(p->mm, addr, &offset, &adev);
+		if (!bo)
+			goto out_unlock;
+
+		flags = bo->kfd_bo->alloc_flags;
+		dev = adev->kfd.dev->nodes[bo->xcp_id];
+		drm_gem_object_get(&bo->tbo.base);
 	}
 
-	/* Initialize context used for operation with given address */
 	mem_context = kzalloc(sizeof(*mem_context), GFP_KERNEL);
-	if (!mem_context)
-		goto out_unlock;
+	if (unlikely(!mem_context)) {
+		if (buf_obj)
+			amdgpu_amdkfd_gpuvm_put_bo_ref(bo);
+		else
+			drm_gem_object_put(&bo->tbo.base);
 
-	mem_context->pid = p->lead_thread->pid;
-
-	pr_debug("addr: %#lx, size: %#lx, pid: %d\n",
-		 addr, size, mem_context->pid);
-
-	mem_context->va     = addr;
-	mem_context->size   = size;
-	mem_context->offset = addr - buf_obj->it.start;
-
-	mem_context->bo = amdgpu_amdkfd_gpuvm_get_bo_ref(buf_obj->mem,
-							 &mem_context->flags);
-	mem_context->dev = buf_obj->dev;
+		goto out_unlock;
+	}
 
 	mutex_unlock(&p->mutex);
+	pr_debug("addr: %#lx, size: %#lx, pid: %d\n", addr, size, mem_context->pid);
 
-	pr_debug("Client context: 0x%p\n", mem_context);
+	mem_context->pid = p->lead_thread->pid;
+	mem_context->va = addr;
+	mem_context->size = size;
+	mem_context->dev = dev;
+	mem_context->offset = offset;
+	mem_context->bo = bo;
+	mem_context->flags = flags;
 
 	/* Return pointer to allocated context */
 	*client_context = mem_context;
@@ -223,7 +237,6 @@ static int amd_acquire(unsigned long addr, size_t size,
 	 * by AMD GPU driver
 	 */
 	return 1;
-
 out_unlock:
 	mutex_unlock(&p->mutex);
 	return 0;
-- 
2.34.1

