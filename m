Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A509CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0848A10E95F;
	Fri, 19 Sep 2025 08:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSC7KZQn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F7810E95F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnweEpqH9nXQuBIL8HrDw1hvSNpK386JeothS+sx5c7A4EZdyww7kgTRSb7daINa4ZgxzkXbUJA3pjlFVqdLVCk47MQgB4Wi5Uc43bTpRJn0gzt1Cj1OAH2HrHD6QAr+NOQXueMg+Q3BY/u/IkYRhCzZqdlxuBMBL6W1rkNI8NULgfZJXXFrjGFXw3yU0kdbZsNjDjL2EzuRjpDjjIIy/KjbyJT+k1H6LiZmRuG26GjFXs3do9Y85puJh8VSevEW2D5WjpThF3ShcGPA4jlQfa1t7Yu+GrKni455asLd/4KMsov2f5H3lLfL47w0q7HLdxgiBLMy+FnYDDrbJ4vDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/50WvNB8cd4S/3M6HQkpsp2hD3oOC2u65b/ThdflTY=;
 b=YNNbwn5hcYZUXgwKpNuT1JrxhojnVjq1TnX1SibSX3snMZ1XZV4yrX15kMg7APHa/TjXuouhth0uahr7W1yiT7ZvSX0DDPYdO8rlFPt68zrJRqqMdgnTlbg2hG20MORyLfNyBj5e8K1hS8SYEd7i9V5naCSkfTC4SO5cteLE2yRz2rRaTXjDn558hxl0BNH6Ffuyf16K1O70NuFaNgyWMrXtDRstnBjjUAfrkrSpMf/sfwHDQiIKbdj/6foMw9PM4hiQcSY8sAHQaHh9W5K45HnXqQ4YDqM0Ce0pAt8v3my4HCtTOy92goCLsuAd8OM2obYeiGjj4e72awiv8uSrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/50WvNB8cd4S/3M6HQkpsp2hD3oOC2u65b/ThdflTY=;
 b=QSC7KZQnIZGL3+nMfz6tA1vL0m3JXbB4YYxegfu7/Se4Ff/B4wI3K/DkEGo/1a97gJ7zNZQq/GGYXkcdlCO9gbxTveuncoTYy/Xdq/x97UIJ4i2JybSg5GTtnDi+Z9r6tDnKfXT4S7m7uITqfkNPpEjDW6fF4CTqbO7se5ezGaY=
Received: from SA0PR11CA0069.namprd11.prod.outlook.com (2603:10b6:806:d2::14)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:11:26 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::7e) by SA0PR11CA0069.outlook.office365.com
 (2603:10b6:806:d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 08:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:24 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 02/10] drm/amdgpu: add userq object va track helpers
Date: Fri, 19 Sep 2025 16:11:05 +0800
Message-ID: <20250919081113.2797985-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 214fcf8a-0ded-4ac0-b278-08ddf754214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CDIpWdXy3ayVftEOFxUcYtHiuSt94G6ooWFfpHK5qRJ90NLjQMDJ3h1dBkHf?=
 =?us-ascii?Q?hri2bWJVCpDFppygyw5qo/wvuo3gw17P7qy1OuW/i+6X9nt9Qk53BXJsG010?=
 =?us-ascii?Q?hZsb6fFORBrQ/4acYe7u+ZGlFY4pb6Qgd0WseXXzrz6sRiYyQOJSSYJKPINy?=
 =?us-ascii?Q?Dz2Y+hXIony4wrXGTuu+uyK3FinB4T5Q8gL33wNCG8MERONaK9RFxZ4kQxZy?=
 =?us-ascii?Q?E56yqlF//HGhMzI0PFyOqlk7gIulyUzbjsSP/RSzNVnkH75UlTvoDKMhiu9f?=
 =?us-ascii?Q?81rvsiigGSYaP72RqEmTc3sbrYY5ZPF7x8DU+4JNefDquxkbmgSACjD/8KUL?=
 =?us-ascii?Q?djj9U7RxEb7sxJOuqlhMsx5czrLVckCra7lHKIjAE/J0Gc+rU+gcNqRGbaGS?=
 =?us-ascii?Q?MM3A7KwpoMl9pBeUHSsQsa2bUCi7ulc6OMZxKjUXBkk2FfTB0vktC9+EefZK?=
 =?us-ascii?Q?5u/62/sfTpYityZ0NEDq0COBUMiikmsaFJOC0I6JHiVkRyYcnT0JJxg+b27w?=
 =?us-ascii?Q?SxOf5ZtURwzNz6JEtRgBGiqtFQjLxXbRW1aiDsGVmGkIVUaOmDmS1Imge3HW?=
 =?us-ascii?Q?+HtKTibARvYwudQuqkR5VBeCt5zDHxn6bV/YUg6tlS8U7ZLBwpScbECSpG/R?=
 =?us-ascii?Q?NXyq42VPuFLW+wXOkXIazxwqB5IwHk1/H6gOJXx6O2teHwm2Lg6grpXNwgw3?=
 =?us-ascii?Q?cQDoX/L+PYko157CaVH3boX4/r+S/IvD3su7oJX9ipnsxulSD/ReAhLmwJLZ?=
 =?us-ascii?Q?EnXYTS99oE3IpqcIS1hx+xAT7xda0drJJjAXrlH0AQK3TnWlyXga2uN54rTF?=
 =?us-ascii?Q?c7i1CZbwvTjBwcI1SToWS7u02C6B6nBSAN2GQz0ZHMZJZ5umyWXgnBnic7H5?=
 =?us-ascii?Q?CnUt0n8FBFUV59F4aIdfT0fSXp73WZEyeIAjy/UbngJ0RtI0/HiZ8M09YfBV?=
 =?us-ascii?Q?Dop0iwS7ldfT+vkWBPVmIJ7fQoqpQW+pAFYpuznHK6R9ko78e9W/kty45Fkr?=
 =?us-ascii?Q?hHzMR6we9nKeJUTmZwaqwNx4xgCEt2ejv17J6fuGYWjCo4fFMOi9Hh+tR8jR?=
 =?us-ascii?Q?dwooedRTkmCgv/P3Z8zfhqyagf0gPkCMNegviwFVW3JdvD6lQJAQ2tFLzNFG?=
 =?us-ascii?Q?frvgfaKpK4dz9WJux2iiUL/h5zVJUi0p1zpKHTXojwDcWqhown+ddqNkOUZT?=
 =?us-ascii?Q?sU4T1yh9QPP19jWkXfjaiAS9DgnyYOjJ4SxDInfd0KOcoL/mXiE2taDAKcBO?=
 =?us-ascii?Q?X5UnEv+jb0fnmp4YFrSyWhUXgn/rcfn7qh9ucQZHDeLH4zjalpCifITzQVX+?=
 =?us-ascii?Q?fVQlqPqfNn2rlMVlmZITSoKVHbj38grRne0FWa1Pw1YuxaDty4FMBfBMtYR4?=
 =?us-ascii?Q?kZa9qg7yhZF5kpXd5WzzjyRTEKITe8702OkV1vIxmXB/S61TRKoBRIIh8MJP?=
 =?us-ascii?Q?FfL5DDAYrCFzZcrCBKmdUZflKMxJ4YMlk+c7l1jLaWLRbirBdXa5p6RPyUfT?=
 =?us-ascii?Q?4N3uFfTY0Mt7SGAclRNeIrTid2PQtHYDNngS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:26.3774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214fcf8a-0ded-4ac0-b278-08ddf754214b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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

Add the userq object virtual address list_add(),mapped()
and list_del() helpers for tracking the userq obj va address
usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 71 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 12 +++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 656b8a931dae..52c2d1731aab 100644
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
index af7753bfa27d..99e51a8ff62a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,10 +44,30 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size)
+static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
+					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
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
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
+	struct amdgpu_vm *vm = queue->vm;
 	u64 user_addr;
 	u64 size;
 	int r = 0;
@@ -67,15 +87,43 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
 
+	r = -EINVAL;
 out_err:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
 }
 
+static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
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
+static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
+					   struct amdgpu_userq_va_cursor *va_cursor)
+{
+	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
+	list_del(&va_cursor->list);
+	kfree(va_cursor);
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -184,6 +232,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -504,13 +553,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
-		kfree(queue);
-		goto unlock;
-	}
+	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
@@ -521,6 +564,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.db_obj = &queue->db_obj;
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(queue, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+		r = -EINVAL;
+		kfree(queue);
+		goto unlock;
+	}
+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
@@ -546,7 +598,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ded33fe76e1c..f19416feb7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	uint64_t		gpu_addr;
+	struct list_head	list;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -67,6 +72,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -137,7 +144,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size);
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..673dfbbd95e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		if (amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		if (amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->shadow_va,
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
+		if (amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size))
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.34.1

