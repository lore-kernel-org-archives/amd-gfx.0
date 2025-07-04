Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6061C83F05
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6B110E9F4;
	Fri,  4 Jul 2025 10:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NsfrWYLN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F93410E9F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPKRhHTqTIBpTDJOKhGoEutJ/yhF+8Q2s2PR+5LyODKwQGtjo9DN22WqwBlq7QrB1+FxW8rE65Y6G+PzmiXVaglGtDRbArYooQ/PhpcHen9DMw9lMLsIwpdl0jUqVQkbIkpQky97c0TYnsDuqpNIz6T28D4FBNh6GD4ULbiNNt8Rybq0Gshs7OLl0iTH5dJWF2I+mLbOEvtIjC0WqTET6goeXzQvF0N66sBPwom9Mi56HJOWRgSbK0TSMmtxGR7Ht+XpRZpfpK9uzXCSFpGu124QAvIHKcm4EPoefE6NZzXZ/Q7NbcfRyEsgsqqAPy5tgRKn1O9ApGqYTJEGFnYUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLQkiSaJDA3X7wlLA+l8SSLR5GOhXE0T2olKfAEKzo0=;
 b=WM4Jugs7mXmlZuXq/G9IVv0HqohKEPWRvcxAIhH1QnhW+fYb+7w3OTRvJ+T6ykQOIs8WSUvkOI6IGJqXNdOteUhqae+U8+BZ6+kxlFYCaVsDLS02pRjuGZKBhpcodWP9xVWKuVRI32x5MnCR9V5AAERju0qLK0yCFrwsD7VwNug8fW8Ic5FYA/D3q9hsn6wJ5e0mhHP3D6iXhBzi2DS52mXWHKMStcCk8Vhy/ibQ5FZhM2a+kFdAnJtcrif4Vdg769PkGsVWwpbWOfyreugNkqrHW1+au1HLBRYwGMPNI3P0Va8Z/6V+m/Z79TxQeDvczP5l03+GaIzh7NgbTk/bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLQkiSaJDA3X7wlLA+l8SSLR5GOhXE0T2olKfAEKzo0=;
 b=NsfrWYLNnhC+bOIxvwGGy67RG9SPZO9P5HwsfytVaClQ74ICl8qjV59NqfEz+2/wRYzsML0q6a3/XSHOf+47gOaez/0q8C7gbZzUuSDt/G9qJlWaPpugOeuueaVk+8+hngGQmffUG4GG9R6u9d8E9UdnHqR8aV5hNiM790SPnLI=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 4 Jul
 2025 10:33:27 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::1d) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 10:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:25 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 5/9] drm/amdgpu: add userq object va track helpers
Date: Fri, 4 Jul 2025 18:33:04 +0800
Message-ID: <20250704103308.1325059-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: a03c0c2b-d5d3-4262-336c-08ddbae6361a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dlP/4GEUMM6WLiz0VnA59VvCgJsE8/gOnjTGT5v+CHI/pLxKuuGbWSBZS4NM?=
 =?us-ascii?Q?L9VtD7M+w1HBbqpsfykMmRy035GAdEW1UxSRJ6QMCB1WH+DBYlxIX9HkCyzf?=
 =?us-ascii?Q?/yWdsqO3JtWKTmYpyZqmM5/61ephWOBg0rcLehCOqhb1pZvXOuM0BqCBw9lf?=
 =?us-ascii?Q?M9ePW19WIE4eHOcLM3glPtRRUSyZ0TyP3RYTW89gTwbu2RjD6ZjRf62nVPhg?=
 =?us-ascii?Q?vA00KtLHqD449bEeKf0yqOZns/xfy8Tw0DgVEzS9uKZd/3HodcqkzXkylXFC?=
 =?us-ascii?Q?PRPm0kfhhXO7xyKfNN6zCS2zif7VTClJAvQJFhCRO/4LwBnYpAM91ws0xPAI?=
 =?us-ascii?Q?Fjt2ZM+EEY13HURHBJsPfKQX6FMm0K7P8u3EvtG2j0/NEyU9jWIgyNuhAN/6?=
 =?us-ascii?Q?6z+XcMGXhz1qcQhUrI2Ixkf1+SeeADApXJnctr+bJDOiXzqlGZHBjydDNbsQ?=
 =?us-ascii?Q?jOy+l7YC9Wpx2VxJi4MZNDPVQrKbzPR4XE79Q7vZcB+0jl+o5SWxo++gNhUX?=
 =?us-ascii?Q?8gtaF1Gq32/zPrbV9DUC5K7oUJXjggyAG25DZh4Q0aMZvQFYCU+FnS9X+fMk?=
 =?us-ascii?Q?cY5TL1nD50AWBq94Y7jiPNU+TzTQUy1O3dnKd7wLXVkd4cmN2+u8CbAKZJbu?=
 =?us-ascii?Q?vxor6OZVulNkDhcqZbdJH/McymVT6DSCHfHaXmpTgOLMDgNujbk1nHpZSdcv?=
 =?us-ascii?Q?j61aTu1pFVD4J4yYZ4+wMn3/FKegjeh26gABpj8dy+xHhlwnzo9kWIqzItr1?=
 =?us-ascii?Q?K5Ym/58oRnsmctQ5++Z+SrGzp8JpLTLNLz5srh2bgCZrmmhyDI4Hdi4PDCAF?=
 =?us-ascii?Q?kXBBbXM+m0aH+U4FktMRPk1NstSDhAdC61d1D6ilUDxVOQ3wXP85Ga/CFSpT?=
 =?us-ascii?Q?7mq9A+tmNvhCxR6DpR+9ZuuYbwQxpzeD7C9Idp4AnSI1wjh96wpVLYqUGHVS?=
 =?us-ascii?Q?ArQZlO1ZYPlzDvtFpCQNzUX1hMGtqQHNH0zoBnOpsD2b+AE05y4NPKi3PKr5?=
 =?us-ascii?Q?HyHKaX1lkftXU1bNhR/kdXQj/3JWFAuinKzGsFKFyXV993PNuFIK5ok3QfcV?=
 =?us-ascii?Q?EKI93TimjhhFKD/XiMW4l/gU3owIApJ/W/XFCo7rcozTc4+j0dS6ep29tgju?=
 =?us-ascii?Q?h6zG40BD/ihgG5RdGzBPuitEPRxtRz8jhU3MFwLuvcIR9KS0hiBfNNbhzHsS?=
 =?us-ascii?Q?kjJJRiuX4rUCRPYxvvc11eOQWfDGIznt1H4aYEOdEmoKK0c5KJBgVCwBW0O9?=
 =?us-ascii?Q?i07aP0eDDQP+SuT2IL/yldsT6yqTmSybS8uK7ZLfmFmJXOxFJMiK3srhzQQq?=
 =?us-ascii?Q?tP29G9H4aT+/7R8r5+sa7BQRTZ9NDczz4Aud1/C3ginfPWH4TzkVJVpqCzQR?=
 =?us-ascii?Q?9G/fixtRyoXqUQNNU1+lWYYdlFfpBZXQzV0pI19ZTzCbUNlXY3PFHEtdYrVE?=
 =?us-ascii?Q?W7YbS6X6rAaUYR4xRuGTWQ1ywXXQlrON4FlhdEf/TQoTVVngt2ikT5XRANJu?=
 =?us-ascii?Q?GNxF3bHTnef+PY1unCrnKjhCAdjW0sW7BJIk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:26.8057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03c0c2b-d5d3-4262-336c-08ddbae6361a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f48e53d99e8e..9841a0b09fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -74,6 +74,174 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+
+	/*
+	 * Need to unify the following userq va reference.
+	 *  mqd  bo
+	 *  rptr bo
+	 *  wptr bo
+	 *  eop  bo
+	 *  shadow bo
+	 *  csa bo
+	 */
+	/*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
+	mapping->bo_va->queue_refcount++;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	bool r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
+			return true;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->eop_va))
+			return true;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
+		    amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+	/*
+	 * TODO: It requires figuring out the root cause of userq va mapping
+	 * reference imbalance issue.
+	 */
+	/*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
+	mapping->bo_va->queue_refcount--;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+
+
+	amdgpu_userq_buffer_va_get(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
+		amdgpu_userq_buffer_va_get(vm, queue->csa_va);
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		amdgpu_userq_buffer_va_get(vm, queue->eop_va);
+		break;
+	case AMDGPU_HW_IP_DMA:
+		amdgpu_userq_buffer_va_get(vm, queue->csa_va);
+		break;
+	default:
+		break;
+	}
+}
+
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
+		amdgpu_userq_buffer_va_put(vm, queue->csa_va);
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		amdgpu_userq_buffer_va_put(vm, queue->eop_va);
+		break;
+	case AMDGPU_HW_IP_DMA:
+		amdgpu_userq_buffer_va_put(vm, queue->csa_va);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -440,6 +608,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -470,7 +641,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 704935ca0c36..194ec7a6b3b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -52,6 +52,13 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		queue_va;
+	uint64_t		rptr_va;
+	uint64_t		wptr_va;
+	uint64_t		eop_va;
+	uint64_t		shadow_va;
+	uint64_t		csa_va;
+
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -134,4 +141,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 			u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4615d3fba530..c9cde14064d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -263,6 +263,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->eop_va = compute_mqd->eop_va;
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
@@ -284,6 +285,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->shadow_va = mqd_gfx_v11->shadow_va;
+		queue->csa_va = mqd_gfx_v11->csa_va;
 
 		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
 					shadow_info.shadow_size)) {
@@ -317,6 +320,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		queue->csa_va = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
 
-- 
2.34.1

