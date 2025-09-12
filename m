Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC681CAC593
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC7410E43F;
	Fri, 12 Sep 2025 05:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AcobHb1C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF44610E43F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f05hDXYndSWf6ZdGakBfSthEHKDinCSYYPmcebqUBqEQuKkrYQyioUD4DFDbyYfPQ8wrHKg+vACWW4I1bT6gwA3Tr0zmpJVvxkFeJ3jSdrXAtPcWlayaUXjsoeMrOmiDHsAtXMycsClirJ4kzXVFYW/wdi/HFe4PDh80/q8Zqr9E38mPRITyg/rqxhThJpFK/tDTOfggEspbpr7eCxIrJ/R8PY+/Qp8rBZsji59+MZiqq8pfgxitLhSWG5YSeLiJ9Y8cMX7vYRztZ6fyy8FMmPJzNP3HmpO6U+PiOu3L7rAv0H3vkGUctz8PddvdfWHKlSE9nrS9SMxiZEZJZfmkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krg4QfI5CsMgFnAt3Un/p4TmXolAhY5vZkWv9A/D/GI=;
 b=ccx2YJbZ4daYezXkQajEJrzqrcVFIGUYWXWxp+g4XSr3OLbvkoptd1iH7vhMJuJU68b5XOgoDxCsDkemys0wnPmz+81FdyFdTDrYYpTfsNnOwOR5H8uO8ycZ0L4y5+LUmrWhhlEgUU/3gsj5pUAZ6tG4G1WbojTtZMdZh34L/p0Cet00j3Gs7KtNByPNr4mehNF8ERYelR04/GwFxk/r6JifJND3Bc1wIo61tGgBb/NnmekW86sFvZKWKfh8low/XrQwIK7Yasu/YidAPYAUwG4X81/Y47fs+jfgsKYOZ5S9hQod7kidwX8EVYUS4+A+nnlB6oJ/3R24DbwzBo3ZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krg4QfI5CsMgFnAt3Un/p4TmXolAhY5vZkWv9A/D/GI=;
 b=AcobHb1CDR/f//rGusOrrNjYMBLF2RX2zF60+CxY+W1EDKpnM2pqTFFgHMhQapTGyMQhdE8Om5yuhz1ND9MiiLM27IaYu71/jH3aSuvajcr+EJwX+hElw3joKeEV66ijhbQ3hwtQrCbbGtnkBYEnWPFJQt43P77tY1AecfMOtBk=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:55:37 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::7) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 05:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:35 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 5/9] drm/amdgpu: add userq object va track helpers
Date: Fri, 12 Sep 2025 13:55:14 +0800
Message-ID: <20250912055518.2719533-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8d1e14-e149-4d81-b8a8-08ddf1c0fef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aV5gO8cQTOT99/3bA6EgePjwowArA84H+VHoKyp8nAjR5R2gD4tAkcWUoOUV?=
 =?us-ascii?Q?rBdO3ava765YjJT8HOqJZMTR0d2rRHo9NGrbO8m7QfJca/JmCjxe1owe0exY?=
 =?us-ascii?Q?zawEsqdypwSwu+R8KVoySE9G3Gu39Om4YhK8ZtVbsc/NNDqM7yG2hecam7dF?=
 =?us-ascii?Q?Sof4da/ynRVHFkSuJ6qch/4oPjAZZT/rE/BWBv27levbHOlzcvWXn0vz9KtI?=
 =?us-ascii?Q?ym4+4PXzuRAxMiwwSW1w2VUZQAm4s+W5aYrFXS9mEJX1jmWLjGaWrqgJb1lu?=
 =?us-ascii?Q?LWGLqKpTLfivVnbZU/VLC27BVpay2eSm9fbIaroe/5FB/9YPYjOzPgKDmvlZ?=
 =?us-ascii?Q?ezhCe6KRin3v7XUbFXdLMFizKdwik+dt6f/VBFYidylM9zunrfDiEO9DZrG2?=
 =?us-ascii?Q?3ZCT3J+dpZNZM5P7UwHjnUfw2kMX5SCANb1iuZzwqimpHzj7+P2E/00C3iNw?=
 =?us-ascii?Q?3OOWdMdc4rQmAGH7lx2alXTGm73CUaNSu4my224l98uLP/Pkt/ROpU362Fch?=
 =?us-ascii?Q?cJ+5Ww0V6O3hPeXDWDdNYZPjKiUm3dw3KQD5Yx6T1yPSkBIe9Uqju++Cces/?=
 =?us-ascii?Q?WHXvcvcQkpsd4B+s0vIVh1U32vD1ew8XUjzzEUXAgFlteh30SndmAhxspRK5?=
 =?us-ascii?Q?XjG+Mc4vhxv2rndSTeEYkizqJBki23SnF9RPg65tr5xwYA8+1JLfNpIpjaaR?=
 =?us-ascii?Q?nNLe17SNeESQbyyacAU9FpVBbHaH1V3BpFw4geWDCXElFNWIAfWwx+iVo3N7?=
 =?us-ascii?Q?Fey/VM8QrBifMVEkrBKAPpvj37eUtuzXNnSR5Oifz+RThGp5pte6SkwgKhwr?=
 =?us-ascii?Q?ek3QoSas5/A7WEReccK7EXVhvCjqQ7VWFX03enJL9BD6CmKGz4ems6ZOa4HR?=
 =?us-ascii?Q?af6hfWYzR8AQOz4AsDhrhzncYky86XuVfLY72OE6UiaPn3wOpeytmGN/nm6w?=
 =?us-ascii?Q?1NfBkaL5ZGxrDKSvrt1ocJ2hU/Enq/9u69Soa6t7Lj7KJDUqFtSw8Z3+CnPV?=
 =?us-ascii?Q?pjz6JVUP7gLrXO/9a7gLtyPXi4PELzjEINhwvYK8aCOnoxxWIgrKT59iKq73?=
 =?us-ascii?Q?8OQBXfKZWHxKEytGH8vZNrxQhK0G2kyQNSyGveKs+FDL8yu0DPPRhX139FNn?=
 =?us-ascii?Q?2mwz+QhTVeVaBBt+H778ARAGdNis/xoEyiX+8DbULcmgyRdwxt3p5XgY7+mC?=
 =?us-ascii?Q?7R6JpIGq+ktWKW2fqg1s3Lmrcx60hcaPvoZvmAnjY5lniOXF0Mpsb6vAj6eV?=
 =?us-ascii?Q?L113GPd24qctUAC3ERTurK9LoUSb/0kY2KqIOfDhl70GBrwRFTmVMKuAE1sF?=
 =?us-ascii?Q?B3hi3FpiBWJGEDJWQWapPn0zFIq8h2pvKAugpjPSQ44/uLA/kWkaAy5Jw5O5?=
 =?us-ascii?Q?1CX3sUSdyXzjQ45EoAzqEe3iTBgsubhg97jj0RgkBrAs64mDC5ASKS9JVmID?=
 =?us-ascii?Q?dVGqKJADtALRj8pMc5nswn+xLSjfg8zFDC2X26bFz3hFv0lyuzQkImgvI/bO?=
 =?us-ascii?Q?1xLreO+WjEM2eI4R64AESNQNnAB8Go3RfFgJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:36.9715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8d1e14-e149-4d81-b8a8-08ddf1c0fef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Add the userq object virtual address get(),mapped() and put()
helpers for tracking the userq obj va address usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 73 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 17 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
 4 files changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 87523fcd4386..912c9afaf9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -96,6 +96,7 @@ struct amdgpu_bo_va {
 	 * if non-zero, cannot unmap from GPU because user queues may still access it
 	 */
 	unsigned int			queue_refcount;
+	atomic_t			userq_va_mapped;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ba7be4db5a01..19a400bd4be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,7 +44,8 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
@@ -67,6 +68,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_userq_buffer_va_get(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
@@ -76,6 +78,66 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return r;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr)
+{
+	struct amdgpu_userq_va_cursor *va_cursor;
+	struct userq_va_list;
+
+	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
+	if (!va_cursor)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&va_cursor->list);
+	va_cursor->gpu_addr = addr;
+	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	list_add(&va_cursor->list, &queue->userq_va_list);
+
+	return 0;
+
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	bool r;
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
+			       u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	int r;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!mapping)
+		goto out_err;
+
+	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -141,6 +203,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -461,10 +524,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	INIT_LIST_HEAD(&queue->userq_va_list);
 	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+	if (amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE ) ||
+	    amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		kfree(queue);
 		goto unlock;
 	}
@@ -504,7 +568,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 33a582200dda..e4c2d7cabd15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,12 +48,19 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	 uint64_t		gpu_addr;
+	struct list_head	list;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+
 	uint64_t		flags;
+
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
@@ -68,6 +75,8 @@ struct amdgpu_usermode_queue {
 	int			priority;
 	struct dentry		*debugfs_queue;
 	uint64_t		generation;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -138,7 +147,11 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3a4fd6de08ce..e10e4b6a10d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size))
 			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
@@ -350,9 +350,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
-
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
-		    shadow_info.csa_size))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size))
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.34.1

