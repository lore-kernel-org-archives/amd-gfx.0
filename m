Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C2C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 04:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2859510EA22;
	Thu, 27 Feb 2025 04:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4UoqaZX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4839F10EA21
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlY3B2Aikwmka5k+Ew0kBBz8VKr5VFJKqQUKenX1i8FUfaWRBBLJBzMKtGI+haFs5+RNP6QL/i3exHSICtzMOh/EB7Pe3KYotdNEIQqOq8WxD1VglohsLQQeSnaCoQrp6RQl6dAtGOBO3L5l6LclmsfnyvUoNQ0OhAPiQmzHS0I3T16m6BWSryyRw0bOQLTWWYEb7Bzx2XyGV1o4396S4YgwwDs56dWFyuheyDlFUnzRPrdeqPKUEvSSBwWrxN7jOBD3hsmZuypUA90xN73riwP0ySFoUjbP+QXluBVlSE7dP5CAnT4OTb8ofUK4UlGjIbiZnhahOurY6jmnDCXnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxYBmvtL0ttKjD4Iazguc+WkvIFRo8Fl2LEbWMjK2Zw=;
 b=O7nSnk7+9p3M8dMXDQJ7NLEjuvmd+BLVCYAejAEFgbqCOUK9VLvSVa9gWkTGQE8RqaGS6Eu0SI+RU8HAZKV8r+ww5MLdQbCr26FLHYLbp1PWvdDvftCfcHPkTNIKleVaO6bNLU2QsVlxerTFSTzJsJjNDQBjofR1MoxeZ5UcBLRtopTdfb/d5kYM0DE4yAWKGgo2tg4aqDcjUSm42XAYOJd042QHcFuO9rPmBTB1YHih5ybK8I9ulLmZrYlCzw7D7hbeBRTmI1ylZPM0Lmzd1T/nRShmBjUhdxYffQEq7nPHruQeoLeMytwiEaCTxa0/hE+ipMfeJk1rpvaetUURpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxYBmvtL0ttKjD4Iazguc+WkvIFRo8Fl2LEbWMjK2Zw=;
 b=V4UoqaZX2NMqOyAQuP8ZoaZADi4QjEp5SAijWlPc5SuDHVLMdA+XWAp9n2lVkr7hTDlZXOgUKEqvJBeu6+Y2U+TPWtUDNHV8gwA9sAQVbkuuQ0oDAoJjPNl6YOIBG1UpcJQl8mF6iGShWxS436B/jbKd33Q3AOcqvHoqfYo5JwQ=
Received: from CH0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:610:119::34)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:01:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::93) by CH0PR03CA0374.outlook.office365.com
 (2603:10b6:610:119::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 04:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:01:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:01:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: remove unused functions
Date: Wed, 26 Feb 2025 23:01:16 -0500
Message-ID: <20250227040116.234478-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 55108680-7d2a-4d78-d02c-08dd56e36aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvg/7NJZKRkdVoKbh8f9ayM57lWqCdfD82OrDMG5MnbIqQWUSBmnEqtYyAnn?=
 =?us-ascii?Q?NtEZFqrL29rraTDffNxMdaNM+1+R2yu9Mni8O8NEsxugDuZcBNe6Yc9o5V9/?=
 =?us-ascii?Q?iynPxudwy49nkUU+E0dSJuUNEF4W0oDmrnZw31UW45q+WTfPlgierv2WkMv4?=
 =?us-ascii?Q?ThWsBAY/2j/qcEP9lMEB+btZtSMECiWQKpy0T45w4HFuMKGBYAcRfr6fYgE3?=
 =?us-ascii?Q?ux/WqPkux1Ob0yR8mlaeNTHRIufWsipG84r8WtsHYRgnHesqctQGs/aDUH9u?=
 =?us-ascii?Q?ZO1dmeyI/qHLOTGgDrDyGmoVzZyINVFDDptWSZEv7xnqaooobpAkoEFpciVF?=
 =?us-ascii?Q?7D53Vr1/Vwx64gUCB6eS7xxzQyNjZk/SzVXT3NczVM9mOu5t8kdATmPfsHUv?=
 =?us-ascii?Q?phj51YTYyfoGyzFUe+45fFkXnT3xKyRKt4Or1UGA96qPD7ZY2m0WtkmZtsns?=
 =?us-ascii?Q?/XSEng32GE1o75GOIb4AJL+3OOBPqpeaPe+xJvQ7v7xPYoFwZdkpIQJ5FaUE?=
 =?us-ascii?Q?u8vftQmaU3ZEQK0ukSfJdzascnazxqzwvAhhaGBuaMSSEgf31URcet0O1COY?=
 =?us-ascii?Q?Gjdsm2jyEU1mywNTbjoZLJ3TqNigXwzwhhlxsz2T/Ky956GOcD9Ou2MTRbx8?=
 =?us-ascii?Q?puyvcSk7XOgYOwd749PKd1s1WGW7yMg8yBsEVr2zpHcMcmMqf7lECPj0bqvs?=
 =?us-ascii?Q?V0IxnF20fzcRliLuxsDhAPZd7AsMJ29g0yHb/i/8JT9ZPD9YlPPJ2e369Ugt?=
 =?us-ascii?Q?AHLVO9Er3jZVSnD9ecIEBgd9yxnG84GTadJmpmDmlY42t4VqYQULZoiWBiIL?=
 =?us-ascii?Q?fkp0Sm3DwHJhptyKc9BhWrH/jO7FWtyLqCrXb8BTbvLgtjk/AkwjpxchTXWi?=
 =?us-ascii?Q?ofbWjROfcfacyflub+hiFtXAcXkJfosf/6077h/t/gfKtEqYZqvWbKI14HOI?=
 =?us-ascii?Q?bQKxOPZsX3NYlIJNqIuNRtS5wBP9xBwpA2zBfRuACHjK/yeTsmAuJD7ErbS5?=
 =?us-ascii?Q?UM2tHjuM8OMBXzpBQeZeGL8CHYs+2j0IltjcBpX+1w32tfLcScUQOyCoJmHl?=
 =?us-ascii?Q?E99kwBmo2qggrphHlRHhuTWUAl6EKTwZ1XpxihLsmYh5osqgN/fQUAOemSQG?=
 =?us-ascii?Q?1z+MnonggkI6w3853WYF3KIPENtu4TM96yPTrVlQsfa0iQBzA/4nOPZi+qQ1?=
 =?us-ascii?Q?JX1FrVyQP7y3rZ5vXvdLDi1TCoHNXl8/L128C1J/HfsbiFzoONUNH3PA1+ez?=
 =?us-ascii?Q?KgrBFn84L/EKbaZvXmJiCcdQwAeKpwxYwMPGtP2pK/lmxAFLbONDf36zCTNQ?=
 =?us-ascii?Q?Zw/eXFAmY92vddE5/8Jj81eulDgDaKLFBLvTznYp5T31sWyWpYg2io4sZj+p?=
 =?us-ascii?Q?ViIgw44WNyCjJhukqWKfppPH0+e84ER2TBYiBBjNHgZKkH37PwBcBtH9NIs+?=
 =?us-ascii?Q?htBATaknJA5MMP1Nl0cpJWx62Wz5QuxuaOWkVIhKxj9x/uORwL+JQg7lZMBX?=
 =?us-ascii?Q?kkaa0WVHbWxC3hg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:01:30.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55108680-7d2a-4d78-d02c-08dd56e36aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
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

Leftover from the MES self tests that were removed previously.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 800 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  41 --
 2 files changed, 841 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ca076306adba4..6f5e272d7ded3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -39,42 +39,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 		       PAGE_SIZE);
 }
 
-static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
-					 int ip_type, uint64_t *doorbell_index)
-{
-	unsigned int offset, found;
-	struct amdgpu_mes *mes = &adev->mes;
-
-	if (ip_type == AMDGPU_RING_TYPE_SDMA)
-		offset = adev->doorbell_index.sdma_engine[0];
-	else
-		offset = 0;
-
-	found = find_next_zero_bit(mes->doorbell_bitmap, mes->num_mes_dbs, offset);
-	if (found >= mes->num_mes_dbs) {
-		DRM_WARN("No doorbell available\n");
-		return -ENOSPC;
-	}
-
-	set_bit(found, mes->doorbell_bitmap);
-
-	/* Get the absolute doorbell index on BAR */
-	*doorbell_index = mes->db_start_dw_offset + found * 2;
-	return 0;
-}
-
-static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
-					   uint32_t doorbell_index)
-{
-	unsigned int old, rel_index;
-	struct amdgpu_mes *mes = &adev->mes;
-
-	/* Find the relative index of the doorbell in this object */
-	rel_index = (doorbell_index - mes->db_start_dw_offset) / 2;
-	old = test_and_clear_bit(rel_index, mes->doorbell_bitmap);
-	WARN_ON(!old);
-}
-
 static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -243,244 +207,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->mes.mutex_hidden);
 }
 
-static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
-{
-	amdgpu_bo_free_kernel(&q->mqd_obj,
-			      &q->mqd_gpu_addr,
-			      &q->mqd_cpu_ptr);
-}
-
-int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
-			      struct amdgpu_vm *vm)
-{
-	struct amdgpu_mes_process *process;
-	int r;
-
-	/* allocate the mes process buffer */
-	process = kzalloc(sizeof(struct amdgpu_mes_process), GFP_KERNEL);
-	if (!process) {
-		DRM_ERROR("no more memory to create mes process\n");
-		return -ENOMEM;
-	}
-
-	/* allocate the process context bo and map it */
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT,
-				    &process->proc_ctx_bo,
-				    &process->proc_ctx_gpu_addr,
-				    &process->proc_ctx_cpu_ptr);
-	if (r) {
-		DRM_ERROR("failed to allocate process context bo\n");
-		goto clean_up_memory;
-	}
-	memset(process->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	/* add the mes process to idr list */
-	r = idr_alloc(&adev->mes.pasid_idr, process, pasid, pasid + 1,
-		      GFP_KERNEL);
-	if (r < 0) {
-		DRM_ERROR("failed to lock pasid=%d\n", pasid);
-		goto clean_up_ctx;
-	}
-
-	INIT_LIST_HEAD(&process->gang_list);
-	process->vm = vm;
-	process->pasid = pasid;
-	process->process_quantum = adev->mes.default_process_quantum;
-	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
-
-	amdgpu_mes_unlock(&adev->mes);
-	return 0;
-
-clean_up_ctx:
-	amdgpu_mes_unlock(&adev->mes);
-	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
-			      &process->proc_ctx_gpu_addr,
-			      &process->proc_ctx_cpu_ptr);
-clean_up_memory:
-	kfree(process);
-	return r;
-}
-
-void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
-{
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang, *tmp1;
-	struct amdgpu_mes_queue *queue, *tmp2;
-	struct mes_remove_queue_input queue_input;
-	unsigned long flags;
-	int r;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	process = idr_find(&adev->mes.pasid_idr, pasid);
-	if (!process) {
-		DRM_WARN("pasid %d doesn't exist\n", pasid);
-		amdgpu_mes_unlock(&adev->mes);
-		return;
-	}
-
-	/* Remove all queues from hardware */
-	list_for_each_entry_safe(gang, tmp1, &process->gang_list, list) {
-		list_for_each_entry_safe(queue, tmp2, &gang->queue_list, list) {
-			spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-			idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
-			spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-
-			queue_input.doorbell_offset = queue->doorbell_off;
-			queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
-
-			r = adev->mes.funcs->remove_hw_queue(&adev->mes,
-							     &queue_input);
-			if (r)
-				DRM_WARN("failed to remove hardware queue\n");
-		}
-
-		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
-	}
-
-	idr_remove(&adev->mes.pasid_idr, pasid);
-	amdgpu_mes_unlock(&adev->mes);
-
-	/* free all memory allocated by the process */
-	list_for_each_entry_safe(gang, tmp1, &process->gang_list, list) {
-		/* free all queues in the gang */
-		list_for_each_entry_safe(queue, tmp2, &gang->queue_list, list) {
-			amdgpu_mes_queue_free_mqd(queue);
-			list_del(&queue->list);
-			kfree(queue);
-		}
-		amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
-				      &gang->gang_ctx_gpu_addr,
-				      &gang->gang_ctx_cpu_ptr);
-		list_del(&gang->list);
-		kfree(gang);
-
-	}
-	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
-			      &process->proc_ctx_gpu_addr,
-			      &process->proc_ctx_cpu_ptr);
-	kfree(process);
-}
-
-int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
-			struct amdgpu_mes_gang_properties *gprops,
-			int *gang_id)
-{
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang;
-	int r;
-
-	/* allocate the mes gang buffer */
-	gang = kzalloc(sizeof(struct amdgpu_mes_gang), GFP_KERNEL);
-	if (!gang) {
-		return -ENOMEM;
-	}
-
-	/* allocate the gang context bo and map it to cpu space */
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_GANG_CTX_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT,
-				    &gang->gang_ctx_bo,
-				    &gang->gang_ctx_gpu_addr,
-				    &gang->gang_ctx_cpu_ptr);
-	if (r) {
-		DRM_ERROR("failed to allocate process context bo\n");
-		goto clean_up_mem;
-	}
-	memset(gang->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	process = idr_find(&adev->mes.pasid_idr, pasid);
-	if (!process) {
-		DRM_ERROR("pasid %d doesn't exist\n", pasid);
-		r = -EINVAL;
-		goto clean_up_ctx;
-	}
-
-	/* add the mes gang to idr list */
-	r = idr_alloc(&adev->mes.gang_id_idr, gang, 1, 0,
-		      GFP_KERNEL);
-	if (r < 0) {
-		DRM_ERROR("failed to allocate idr for gang\n");
-		goto clean_up_ctx;
-	}
-
-	gang->gang_id = r;
-	*gang_id = r;
-
-	INIT_LIST_HEAD(&gang->queue_list);
-	gang->process = process;
-	gang->priority = gprops->priority;
-	gang->gang_quantum = gprops->gang_quantum ?
-		gprops->gang_quantum : adev->mes.default_gang_quantum;
-	gang->global_priority_level = gprops->global_priority_level;
-	gang->inprocess_gang_priority = gprops->inprocess_gang_priority;
-	list_add_tail(&gang->list, &process->gang_list);
-
-	amdgpu_mes_unlock(&adev->mes);
-	return 0;
-
-clean_up_ctx:
-	amdgpu_mes_unlock(&adev->mes);
-	amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
-			      &gang->gang_ctx_gpu_addr,
-			      &gang->gang_ctx_cpu_ptr);
-clean_up_mem:
-	kfree(gang);
-	return r;
-}
-
-int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
-{
-	struct amdgpu_mes_gang *gang;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
-	if (!gang) {
-		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
-		amdgpu_mes_unlock(&adev->mes);
-		return -EINVAL;
-	}
-
-	if (!list_empty(&gang->queue_list)) {
-		DRM_ERROR("queue list is not empty\n");
-		amdgpu_mes_unlock(&adev->mes);
-		return -EBUSY;
-	}
-
-	idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
-	list_del(&gang->list);
-	amdgpu_mes_unlock(&adev->mes);
-
-	amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
-			      &gang->gang_ctx_gpu_addr,
-			      &gang->gang_ctx_cpu_ptr);
-
-	kfree(gang);
-
-	return 0;
-}
-
 int amdgpu_mes_suspend(struct amdgpu_device *adev)
 {
 	struct mes_suspend_gang_input input;
@@ -529,241 +255,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 	return r;
 }
 
-static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
-				     struct amdgpu_mes_queue *q,
-				     struct amdgpu_mes_queue_properties *p)
-{
-	struct amdgpu_mqd *mqd_mgr = &adev->mqds[p->queue_type];
-	u32 mqd_size = mqd_mgr->mqd_size;
-	int r;
-
-	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT,
-				    &q->mqd_obj,
-				    &q->mqd_gpu_addr, &q->mqd_cpu_ptr);
-	if (r) {
-		dev_warn(adev->dev, "failed to create queue mqd bo (%d)", r);
-		return r;
-	}
-	memset(q->mqd_cpu_ptr, 0, mqd_size);
-
-	r = amdgpu_bo_reserve(q->mqd_obj, false);
-	if (unlikely(r != 0))
-		goto clean_up;
-
-	return 0;
-
-clean_up:
-	amdgpu_bo_free_kernel(&q->mqd_obj,
-			      &q->mqd_gpu_addr,
-			      &q->mqd_cpu_ptr);
-	return r;
-}
-
-static void amdgpu_mes_queue_init_mqd(struct amdgpu_device *adev,
-				     struct amdgpu_mes_queue *q,
-				     struct amdgpu_mes_queue_properties *p)
-{
-	struct amdgpu_mqd *mqd_mgr = &adev->mqds[p->queue_type];
-	struct amdgpu_mqd_prop mqd_prop = {0};
-
-	mqd_prop.mqd_gpu_addr = q->mqd_gpu_addr;
-	mqd_prop.hqd_base_gpu_addr = p->hqd_base_gpu_addr;
-	mqd_prop.rptr_gpu_addr = p->rptr_gpu_addr;
-	mqd_prop.wptr_gpu_addr = p->wptr_gpu_addr;
-	mqd_prop.queue_size = p->queue_size;
-	mqd_prop.use_doorbell = true;
-	mqd_prop.doorbell_index = p->doorbell_off;
-	mqd_prop.eop_gpu_addr = p->eop_gpu_addr;
-	mqd_prop.hqd_pipe_priority = p->hqd_pipe_priority;
-	mqd_prop.hqd_queue_priority = p->hqd_queue_priority;
-	mqd_prop.hqd_active = false;
-
-	if (p->queue_type == AMDGPU_RING_TYPE_GFX ||
-	    p->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		mutex_lock(&adev->srbm_mutex);
-		amdgpu_gfx_select_me_pipe_q(adev, p->ring->me, p->ring->pipe, 0, 0, 0);
-	}
-
-	mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);
-
-	if (p->queue_type == AMDGPU_RING_TYPE_GFX ||
-	    p->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
-	}
-
-	amdgpu_bo_unreserve(q->mqd_obj);
-}
-
-int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
-			    struct amdgpu_mes_queue_properties *qprops,
-			    int *queue_id)
-{
-	struct amdgpu_mes_queue *queue;
-	struct amdgpu_mes_gang *gang;
-	struct mes_add_queue_input queue_input;
-	unsigned long flags;
-	int r;
-
-	memset(&queue_input, 0, sizeof(struct mes_add_queue_input));
-
-	/* allocate the mes queue buffer */
-	queue = kzalloc(sizeof(struct amdgpu_mes_queue), GFP_KERNEL);
-	if (!queue) {
-		DRM_ERROR("Failed to allocate memory for queue\n");
-		return -ENOMEM;
-	}
-
-	/* Allocate the queue mqd */
-	r = amdgpu_mes_queue_alloc_mqd(adev, queue, qprops);
-	if (r)
-		goto clean_up_memory;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
-	if (!gang) {
-		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
-		r = -EINVAL;
-		goto clean_up_mqd;
-	}
-
-	/* add the mes gang to idr list */
-	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-	r = idr_alloc(&adev->mes.queue_id_idr, queue, 1, 0,
-		      GFP_ATOMIC);
-	if (r < 0) {
-		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-		goto clean_up_mqd;
-	}
-	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-	*queue_id = queue->queue_id = r;
-
-	/* allocate a doorbell index for the queue */
-	r = amdgpu_mes_kernel_doorbell_get(adev,
-					  qprops->queue_type,
-					  &qprops->doorbell_off);
-	if (r)
-		goto clean_up_queue_id;
-
-	/* initialize the queue mqd */
-	amdgpu_mes_queue_init_mqd(adev, queue, qprops);
-
-	/* add hw queue to mes */
-	queue_input.process_id = gang->process->pasid;
-
-	queue_input.page_table_base_addr =
-		adev->vm_manager.vram_base_offset + gang->process->pd_gpu_addr -
-		adev->gmc.vram_start;
-
-	queue_input.process_va_start = 0;
-	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
-	queue_input.process_quantum = gang->process->process_quantum;
-	queue_input.process_context_addr = gang->process->proc_ctx_gpu_addr;
-	queue_input.gang_quantum = gang->gang_quantum;
-	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
-	queue_input.inprocess_gang_priority = gang->inprocess_gang_priority;
-	queue_input.gang_global_priority_level = gang->global_priority_level;
-	queue_input.doorbell_offset = qprops->doorbell_off;
-	queue_input.mqd_addr = queue->mqd_gpu_addr;
-	queue_input.wptr_addr = qprops->wptr_gpu_addr;
-	queue_input.wptr_mc_addr = qprops->wptr_mc_addr;
-	queue_input.queue_type = qprops->queue_type;
-	queue_input.paging = qprops->paging;
-	queue_input.is_kfd_process = 0;
-
-	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-	if (r) {
-		DRM_ERROR("failed to add hardware queue to MES, doorbell=0x%llx\n",
-			  qprops->doorbell_off);
-		goto clean_up_doorbell;
-	}
-
-	DRM_DEBUG("MES hw queue was added, pasid=%d, gang id=%d, "
-		  "queue type=%d, doorbell=0x%llx\n",
-		  gang->process->pasid, gang_id, qprops->queue_type,
-		  qprops->doorbell_off);
-
-	queue->ring = qprops->ring;
-	queue->doorbell_off = qprops->doorbell_off;
-	queue->wptr_gpu_addr = qprops->wptr_gpu_addr;
-	queue->queue_type = qprops->queue_type;
-	queue->paging = qprops->paging;
-	queue->gang = gang;
-	queue->ring->mqd_ptr = queue->mqd_cpu_ptr;
-	list_add_tail(&queue->list, &gang->queue_list);
-
-	amdgpu_mes_unlock(&adev->mes);
-	return 0;
-
-clean_up_doorbell:
-	amdgpu_mes_kernel_doorbell_free(adev, qprops->doorbell_off);
-clean_up_queue_id:
-	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-	idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
-	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-clean_up_mqd:
-	amdgpu_mes_unlock(&adev->mes);
-	amdgpu_mes_queue_free_mqd(queue);
-clean_up_memory:
-	kfree(queue);
-	return r;
-}
-
-int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
-{
-	unsigned long flags;
-	struct amdgpu_mes_queue *queue;
-	struct amdgpu_mes_gang *gang;
-	struct mes_remove_queue_input queue_input;
-	int r;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-
-	/* remove the mes gang from idr list */
-	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
-
-	queue = idr_find(&adev->mes.queue_id_idr, queue_id);
-	if (!queue) {
-		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-		amdgpu_mes_unlock(&adev->mes);
-		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
-		return -EINVAL;
-	}
-
-	idr_remove(&adev->mes.queue_id_idr, queue_id);
-	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
-
-	DRM_DEBUG("try to remove queue, doorbell off = 0x%llx\n",
-		  queue->doorbell_off);
-
-	gang = queue->gang;
-	queue_input.doorbell_offset = queue->doorbell_off;
-	queue_input.gang_context_addr = gang->gang_ctx_gpu_addr;
-
-	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
-	if (r)
-		DRM_ERROR("failed to remove hardware queue, queue id = %d\n",
-			  queue_id);
-
-	list_del(&queue->list);
-	amdgpu_mes_kernel_doorbell_free(adev, queue->doorbell_off);
-	amdgpu_mes_unlock(&adev->mes);
-
-	amdgpu_mes_queue_free_mqd(queue);
-	kfree(queue);
-	return 0;
-}
-
 int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
 {
 	unsigned long flags;
@@ -1077,25 +568,6 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 	return r;
 }
 
-static void
-amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
-			       struct amdgpu_ring *ring,
-			       struct amdgpu_mes_queue_properties *props)
-{
-	props->queue_type = ring->funcs->type;
-	props->hqd_base_gpu_addr = ring->gpu_addr;
-	props->rptr_gpu_addr = ring->rptr_gpu_addr;
-	props->wptr_gpu_addr = ring->wptr_gpu_addr;
-	props->wptr_mc_addr =
-		ring->mes_ctx->meta_data_mc_addr + ring->wptr_offs;
-	props->queue_size = ring->ring_size;
-	props->eop_gpu_addr = ring->eop_gpu_addr;
-	props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-	props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
-	props->paging = false;
-	props->ring = ring;
-}
-
 #define DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(_eng)			\
 do {									\
        if (id_offs < AMDGPU_MES_CTX_MAX_OFFS)				\
@@ -1132,284 +604,12 @@ int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs)
 	return -EINVAL;
 }
 
-int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
-			int queue_type, int idx,
-			struct amdgpu_mes_ctx_data *ctx_data,
-			struct amdgpu_ring **out)
-{
-	struct amdgpu_ring *ring;
-	struct amdgpu_mes_gang *gang;
-	struct amdgpu_mes_queue_properties qprops = {0};
-	int r, queue_id, pasid;
-
-	/*
-	 * Avoid taking any other locks under MES lock to avoid circular
-	 * lock dependencies.
-	 */
-	amdgpu_mes_lock(&adev->mes);
-	gang = idr_find(&adev->mes.gang_id_idr, gang_id);
-	if (!gang) {
-		DRM_ERROR("gang id %d doesn't exist\n", gang_id);
-		amdgpu_mes_unlock(&adev->mes);
-		return -EINVAL;
-	}
-	pasid = gang->process->pasid;
-
-	ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
-	if (!ring) {
-		amdgpu_mes_unlock(&adev->mes);
-		return -ENOMEM;
-	}
-
-	ring->ring_obj = NULL;
-	ring->use_doorbell = true;
-	ring->is_mes_queue = true;
-	ring->mes_ctx = ctx_data;
-	ring->idx = idx;
-	ring->no_scheduler = true;
-
-	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
-				      compute[ring->idx].mec_hpd);
-		ring->eop_gpu_addr =
-			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-	}
-
-	switch (queue_type) {
-	case AMDGPU_RING_TYPE_GFX:
-		ring->funcs = adev->gfx.gfx_ring[0].funcs;
-		ring->me = adev->gfx.gfx_ring[0].me;
-		ring->pipe = adev->gfx.gfx_ring[0].pipe;
-		break;
-	case AMDGPU_RING_TYPE_COMPUTE:
-		ring->funcs = adev->gfx.compute_ring[0].funcs;
-		ring->me = adev->gfx.compute_ring[0].me;
-		ring->pipe = adev->gfx.compute_ring[0].pipe;
-		break;
-	case AMDGPU_RING_TYPE_SDMA:
-		ring->funcs = adev->sdma.instance[0].ring.funcs;
-		break;
-	default:
-		BUG();
-	}
-
-	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
-			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r) {
-		amdgpu_mes_unlock(&adev->mes);
-		goto clean_up_memory;
-	}
-
-	amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
-
-	dma_fence_wait(gang->process->vm->last_update, false);
-	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
-	amdgpu_mes_unlock(&adev->mes);
-
-	r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
-	if (r)
-		goto clean_up_ring;
-
-	ring->hw_queue_id = queue_id;
-	ring->doorbell_index = qprops.doorbell_off;
-
-	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
-	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
-		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
-			queue_id);
-	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
-		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
-			queue_id);
-	else
-		BUG();
-
-	*out = ring;
-	return 0;
-
-clean_up_ring:
-	amdgpu_ring_fini(ring);
-clean_up_memory:
-	kfree(ring);
-	return r;
-}
-
-void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
-			    struct amdgpu_ring *ring)
-{
-	if (!ring)
-		return;
-
-	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
-	del_timer_sync(&ring->fence_drv.fallback_timer);
-	amdgpu_ring_fini(ring);
-	kfree(ring);
-}
-
 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 						   enum amdgpu_mes_priority_level prio)
 {
 	return adev->mes.aggregated_doorbells[prio];
 }
 
-int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
-				   struct amdgpu_mes_ctx_data *ctx_data)
-{
-	int r;
-
-	r = amdgpu_bo_create_kernel(adev,
-			    sizeof(struct amdgpu_mes_ctx_meta_data),
-			    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-			    &ctx_data->meta_data_obj,
-			    &ctx_data->meta_data_mc_addr,
-			    &ctx_data->meta_data_ptr);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create CTX bo failed\n", r);
-		return r;
-	}
-
-	if (!ctx_data->meta_data_obj)
-		return -ENOMEM;
-
-	memset(ctx_data->meta_data_ptr, 0,
-	       sizeof(struct amdgpu_mes_ctx_meta_data));
-
-	return 0;
-}
-
-void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
-{
-	if (ctx_data->meta_data_obj)
-		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj,
-				      &ctx_data->meta_data_mc_addr,
-				      &ctx_data->meta_data_ptr);
-}
-
-int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
-				 struct amdgpu_vm *vm,
-				 struct amdgpu_mes_ctx_data *ctx_data)
-{
-	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_sync sync;
-	struct drm_exec exec;
-	int r;
-
-	amdgpu_sync_create(&sync);
-
-	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_lock_obj(&exec,
-				      &ctx_data->meta_data_obj->tbo.base);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto error_fini_exec;
-
-		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto error_fini_exec;
-	}
-
-	bo_va = amdgpu_vm_bo_add(adev, vm, ctx_data->meta_data_obj);
-	if (!bo_va) {
-		DRM_ERROR("failed to create bo_va for meta data BO\n");
-		r = -ENOMEM;
-		goto error_fini_exec;
-	}
-
-	r = amdgpu_vm_bo_map(adev, bo_va, ctx_data->meta_data_gpu_addr, 0,
-			     sizeof(struct amdgpu_mes_ctx_meta_data),
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
-
-	if (r) {
-		DRM_ERROR("failed to do bo_map on meta data, err=%d\n", r);
-		goto error_del_bo_va;
-	}
-
-	r = amdgpu_vm_bo_update(adev, bo_va, false);
-	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on meta data\n");
-		goto error_del_bo_va;
-	}
-	amdgpu_sync_fence(&sync, bo_va->last_pt_update);
-
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-	if (r) {
-		DRM_ERROR("failed to update pdes on meta data\n");
-		goto error_del_bo_va;
-	}
-	amdgpu_sync_fence(&sync, vm->last_update);
-
-	amdgpu_sync_wait(&sync, false);
-	drm_exec_fini(&exec);
-
-	amdgpu_sync_free(&sync);
-	ctx_data->meta_data_va = bo_va;
-	return 0;
-
-error_del_bo_va:
-	amdgpu_vm_bo_del(adev, bo_va);
-
-error_fini_exec:
-	drm_exec_fini(&exec);
-	amdgpu_sync_free(&sync);
-	return r;
-}
-
-int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
-				   struct amdgpu_mes_ctx_data *ctx_data)
-{
-	struct amdgpu_bo_va *bo_va = ctx_data->meta_data_va;
-	struct amdgpu_bo *bo = ctx_data->meta_data_obj;
-	struct amdgpu_vm *vm = bo_va->base.vm;
-	struct dma_fence *fence;
-	struct drm_exec exec;
-	long r;
-
-	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_lock_obj(&exec,
-				      &ctx_data->meta_data_obj->tbo.base);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto out_unlock;
-
-		r = amdgpu_vm_lock_pd(vm, &exec, 0);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(r))
-			goto out_unlock;
-	}
-
-	amdgpu_vm_bo_del(adev, bo_va);
-	if (!amdgpu_vm_ready(vm))
-		goto out_unlock;
-
-	r = dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP,
-				   &fence);
-	if (r)
-		goto out_unlock;
-	if (fence) {
-		amdgpu_bo_fence(bo, fence, true);
-		fence = NULL;
-	}
-
-	r = amdgpu_vm_clear_freed(adev, vm, &fence);
-	if (r || !fence)
-		goto out_unlock;
-
-	dma_fence_wait(fence, false);
-	amdgpu_bo_fence(bo, fence, true);
-	dma_fence_put(fence);
-
-out_unlock:
-	if (unlikely(r < 0))
-		dev_err(adev->dev, "failed to clear page tables (%ld)\n", r);
-	drm_exec_fini(&exec);
-
-	return r;
-}
-
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 {
 	const struct mes_firmware_header_v1_0 *mes_hdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4391b3383f0c3..98b9c3738a12d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -149,19 +149,6 @@ struct amdgpu_mes {
 
 };
 
-struct amdgpu_mes_process {
-	int			pasid;
-	struct			amdgpu_vm *vm;
-	uint64_t		pd_gpu_addr;
-	struct amdgpu_bo 	*proc_ctx_bo;
-	uint64_t 		proc_ctx_gpu_addr;
-	void 			*proc_ctx_cpu_ptr;
-	uint64_t 		process_quantum;
-	struct 			list_head gang_list;
-	uint32_t 		doorbell_index;
-	struct mutex		doorbell_lock;
-};
-
 struct amdgpu_mes_gang {
 	int 				gang_id;
 	int 				priority;
@@ -404,22 +391,9 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
-int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
-			      struct amdgpu_vm *vm);
-void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid);
-
-int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
-			struct amdgpu_mes_gang_properties *gprops,
-			int *gang_id);
-int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
-
 int amdgpu_mes_suspend(struct amdgpu_device *adev);
 int amdgpu_mes_resume(struct amdgpu_device *adev);
 
-int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
-			    struct amdgpu_mes_queue_properties *qprops,
-			    int *queue_id);
-int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id);
 int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
 int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
 				   int me_id, int pipe_id, int queue_id, int vmid);
@@ -451,25 +425,10 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				bool trap_en);
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr);
-int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
-			int queue_type, int idx,
-			struct amdgpu_mes_ctx_data *ctx_data,
-			struct amdgpu_ring **out);
-void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
-			    struct amdgpu_ring *ring);
 
 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 						   enum amdgpu_mes_priority_level prio);
 
-int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
-				   struct amdgpu_mes_ctx_data *ctx_data);
-void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
-int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
-				 struct amdgpu_vm *vm,
-				 struct amdgpu_mes_ctx_data *ctx_data);
-int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
-				   struct amdgpu_mes_ctx_data *ctx_data);
-
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
 
 /*
-- 
2.48.1

