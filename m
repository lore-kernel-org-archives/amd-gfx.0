Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7FECAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC1210E495;
	Mon,  8 Sep 2025 08:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJ81c51D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C59310E495
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FENXu62+zdpygkrn7XtYSaI2LnAhkOKzdrwkY7q4GaPOoYxqKIZp3gTOSDoLiBzY92Wu05V4fQQKd8cNPuGWN0C04fiV41AqS2O2sNzzyj6Ya/ESV99e/RwkYKaX9f9UzcwmsqaZiSGzIa7wE3tMZkbCZ/woS5b7xU1/wsQaL+Uo5Zdhb/Gt0O+O/jChD/6qKBTqP4L2sPfYO3dndifyzwLd/Fd2tjQO5d3wdyIt2EBjT6rAxxsm6oMSH3TaI9CH1smFRlmZRfOP0CfaUQh7CI9hl/TnfzfTHTS1XjrvwJr4W8Uq0G/bQj6L+Mp4l9qhlr7lUsniqTaPSbb/SemMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpStJJv+NGVGb4Wy1/qe+oPnvJKONX51IqDVw58SHno=;
 b=tL0Z1zUCjdg44n3hAjTc6oqKeswzlas+O0Ukl23ChpZK3r1+/kNmPBlvIr0//LRDrQHwC7ZBGVnnOcYNyuuuBec8KWJHpWFr5CQGmnf/2h6woD3g6i+fDAZQNjfGzA0FrXtVy77HB6L+ybSNCIUv4rbh6uA8Jgi7e9It+xXcALaKfcMppGzwmSsOMudTQGLPK+HkaRDQsnf0L5XcA6nueYgP4pyK9pOV0talRRaqZiZfTN9y64GxLsLhnK3M1OTjwo0ltbZgTfadFm+6iXS3ygpJUzgRKgm/88+P96ZaX8r8UNGigBP5yAoV4v9YW9Vlxcl9y2XVRZ3xAofAnrDhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpStJJv+NGVGb4Wy1/qe+oPnvJKONX51IqDVw58SHno=;
 b=zJ81c51DJyJX4b4IsLNO0CimIV/6KSDtWrmDqjjwa15uE9obENh3d8cqUoHQYshtCz7UKVl6JYYY6iuz3W/mvuuH0uLJnqCRW2VB0j4YvvoP2RflkO8VNQMpB7opQ0r4rFuWIPPbavPI5gbmmMRJEfG7x7+dHVq66Zuj1dgvUCc=
Received: from SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:20 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::aa) by SJ0PR03CA0217.outlook.office365.com
 (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:10 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 08/14] drm/amdgpu: add userq object va track helpers
Date: Mon, 8 Sep 2025 16:48:40 +0800
Message-ID: <20250908084846.1873894-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f4cb57-86ec-4fb4-38c7-08ddeeb499c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1D7YWCNaw389T1hIFfXugYthcKBjt8YIhgohv4ns8ryz3sTCmV4QEkHOMjbK?=
 =?us-ascii?Q?wUD6gnMW5/R3L8Lk148XU1xv5gIoSLUa6PA0+Om0LRT+l/T6PPkdtJomgMwr?=
 =?us-ascii?Q?/wM01gYj/N9ZkyGXFqFbTmyhUWrGwEhFZXBgdPcahprK1xmqH8F9k9nzqksD?=
 =?us-ascii?Q?DaqRihopKBppE1k6YPTN3N+5TgtuMDQCDDq5i+G+0t+Ki0CN5J8YCUhgfs5r?=
 =?us-ascii?Q?XfzsGfji7SCb4+qBZGzeTlJFwmw+YSson8YCgK2XO7Ic+k3IbCowJGz02RF4?=
 =?us-ascii?Q?D7c2wSu9MPal+p5rykOz7Dytkx7HXtzVbmlxXf5pb3W7cIrrTv33OIQeuAMq?=
 =?us-ascii?Q?+BHeYlEb9J4Y5SqiKqHHMvVMnmOiPh/QAvw5zpmzIZGAdHxfiKk9fT/q2QHL?=
 =?us-ascii?Q?H6o7v/aIrpvabj1J4+unG1qX2uAbPm4jIT2q0uobZj14VQ9fpB9dEeCVpGZ0?=
 =?us-ascii?Q?mtoWCEhCjTdElLBcCAKWqyeIUQ98S/bYhIgOZtXYiUfLbjyAQcnVde0gol9l?=
 =?us-ascii?Q?64a2EvdLJsNNNM/FvTI1x2XcfteLHs9BI5vVDZ8lj4vZYkkQh++MA7StqdO+?=
 =?us-ascii?Q?i2lsOhBjot+hqlBrkLBfCHRmTNZR/FiXaqnpjLDYhEsVJEVy+Kt+jt+6wm+H?=
 =?us-ascii?Q?EKgTuUmKOTdSKaFMm970i4PkVqBkQNCRIR3HxAbDnnF7QjAq4gol8fdnDE/F?=
 =?us-ascii?Q?tLtTf8IoNbcCkJ+Yqoo3uI4ED0rE/YpICvu0+8UP2pypHuMbLElroe77A9NI?=
 =?us-ascii?Q?hi4v9AdWY+uvU/6EEP7YO28+gU82ffzibgK0bUnYb6OkapOhlltK0lA7fBOF?=
 =?us-ascii?Q?cAdisMS7Gj+yXln9lWV6TTSoa4WOrGyqtwO/i0O8VPbexkMOTtMedYNlbMe+?=
 =?us-ascii?Q?AB8VElbHzt3PfdKIqrzDhL74txzM8tqACRSpJPa80PQFeyB/5KnOeov7YSaA?=
 =?us-ascii?Q?4fyoChCr3Uyz2RxRVytUGCNXasA8UgXAwJmOqd6y2EkRnPdjV4hCAwzVRhQl?=
 =?us-ascii?Q?II1+mkkh5TCdVK4dfWvZQMv6EFrjJI237RNXNmpdRODraqa/oWwg6xj2lhTV?=
 =?us-ascii?Q?WkpNtHlbNnuN/SFn09VoE2g2OrW5nBOtWeOTNipqD6z1P0GkplqcYCFYjcP2?=
 =?us-ascii?Q?2WhBWbfoN2ymT9jtV0H8Rid0BH0GtlUqirXvVHU/zHlwwwtzEwD2yjPHwX/B?=
 =?us-ascii?Q?Gv56H+zbYOhsNpVLLSN+0cXNCjAuHHtx7KuM5sWjZC60BQ/i128JBTq4KatI?=
 =?us-ascii?Q?ZxQ3U6T5oV8EMtZ4YkEVFxodl8vXaI3yeLLWxEy8VkGYQTsjwZ2J3GUCYNWn?=
 =?us-ascii?Q?3D2hkZbQdBRG41mgsPkbNCDZih3QNtzJtaglfz6n/W3IkNsorFj8fqbk0xhu?=
 =?us-ascii?Q?Wv1l6v0eWOEq7GJh5KGdL8UA77rpOb9qhwk7wTcpDFN1fg//zhveTTOSEP2J?=
 =?us-ascii?Q?suFA84E/Lnknj5JCzDeeWniRx5rCkrOMMXbchUTmJQIEFkBzVmUMBJxaWO05?=
 =?us-ascii?Q?fdWn93ioI1kFd9WzbmV1tjjPcqzprd90N8X5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:19.6973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f4cb57-86ec-4fb4-38c7-08ddeeb499c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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
index 739135c3f450..5aebce63d86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return r;
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
@@ -444,6 +612,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
 	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -474,7 +645,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 46e927df67c1..39d9bc6fc47a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -53,6 +53,13 @@ struct amdgpu_usermode_queue {
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
@@ -136,4 +143,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
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
index 3bf328eb7b69..431397158fe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -260,6 +260,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->eop_va = compute_mqd->eop_va;
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
@@ -281,6 +282,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->shadow_va = mqd_gfx_v11->shadow_va;
+		queue->csa_va = mqd_gfx_v11->csa_va;
 
 		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
 					shadow_info.shadow_size))
@@ -308,6 +311,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		queue->csa_va = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
 
-- 
2.34.1

