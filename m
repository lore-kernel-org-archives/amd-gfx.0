Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C2C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41BF10E4C7;
	Fri,  8 Aug 2025 06:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiVap42Y";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63A510E4D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlVNGWqQibemKtdkeAORRgb8N5pxAo6VMjZm8UErFnxHGpJimlDZpoWfz55jecN9Ms2UYmke8EUyk3Q+nlbM4QHoGPzAcYGdCKvvX+r4EhQjJM2KbS55oTbAt1/XdUMr7DroN+5kKNkrTfgq84o6jRUdWIFS9IoqBRC6N/MlzBmTGPxZIVlBj7o22YbDP1jhiWHHphDxLEb89Q6tCuvnLjCmsqo7y5d/BS7o2raw/P2X6rbrDjul8u390OP5DgXjxMDgGMFF9LZrO9v3Z+61+8574sid7rb3LDVDkik1ygY9AKsvZgs2mhULGHcWpD10XzpliaxmQG46SyQmL0pqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDgueBW6I7IXSpmpzaWRf0tcNPpFLleSGtrwKzJsV9k=;
 b=mL2V/70pQdjSkAdO/t6JzNBVFpMWYAKnWKgXVNRtelbCCWran3du4PR6BHc6IhxiZ/Smq7DI2iPs1wL9UwvkBIGWOsd9M0kb2dh3JJ2vlMrbf20TsZdP1OTEAIsrJXV/XCUshiPjXbtVIaiSGylIIlVbVt9vJEjGF6YNfhDsitLVjnc6g/km61wtOZZ8n0r7ofBvVHa5IV+6LJFKzHtPXZ9hgKRaeOPnoWcMApMCCQIIJHvTPmtzYgw+oBCrCrgYPlVC90RTA/cP7jWroBx7r3FulXmqkEeWrAoCyCzCZGe+AYuaF0DJD+i/fpx1lI7z+FrPLXCaC8kNKcg+XCbhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDgueBW6I7IXSpmpzaWRf0tcNPpFLleSGtrwKzJsV9k=;
 b=XiVap42Y6aZGZrMc/eckLkrfvsAtB4O8MCRwiBiXMgxwkbjPFNhUui3vJej2J/PZONdoyswfQI6h9jPOuhcrsN6yrac3OJwy9jDcR3jT5PWBLl7c9e5ZoKPBBX6HEb65vVWBEogspmOyar23ush2s69PsaX0tGOpiLWnL2VBn7c=
Received: from SJ0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:a03:39c::11)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 06:29:44 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::93) by SJ0PR03CA0336.outlook.office365.com
 (2603:10b6:a03:39c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 06:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 08/14] drm/amdgpu: add userq object va track helpers
Date: Fri, 8 Aug 2025 14:29:04 +0800
Message-ID: <20250808062910.1613453-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 78689f85-5855-4088-2c52-08ddd644f6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4JphgCkv5QUa/HGEEy9L1v8pngp6XrSzitNzrovBQ7+I71Qo5L5nYtUPdd9H?=
 =?us-ascii?Q?w572n4J58kKYmUcwcYWfNlDVfg5syMpx6XWm2cjlWh+Qu3sf6VXNOvxILQ3R?=
 =?us-ascii?Q?jqCGPUHCQCWQJpy/vCsbl69pLEzK0LhwEV/LrDc/wZUzPKrYvwhsq5+VKf6c?=
 =?us-ascii?Q?e8dJ4m791opbg1sBKjw88S0i5Zg/+ARlSmjkR57FfX6FBEZfacBMzxhtENW4?=
 =?us-ascii?Q?2t7eRDhairZ5t8GbVx4A3aOKN2s0HouaeVQpojdXtWkpi/PzPiZOTd6MUW54?=
 =?us-ascii?Q?XEUVnu0zar9skBPHIIy7me1NVtrXydkpZC55b1a8n94B8OJ8qqHU1h9pTZMo?=
 =?us-ascii?Q?tdaQ/baa8s1BTLm6RzO+6gK2OcIXD27hwAqcSOd85Potk0YmWraNIHJhvuN0?=
 =?us-ascii?Q?UfN+x7fhEyZVSXFiVUGyv/igwnUFDLu60aJUhrsB7jrI+xt/SdNQiAldZQpf?=
 =?us-ascii?Q?3GtXv2UjEGba741JU6O7A8WEinAmNoQmt7MPV4RR8S9IlyMSb7FZ3GZskIR7?=
 =?us-ascii?Q?hNs/NHHAMTKbh5RKtNQ3i+roN7qzUBTdpDiA5WqpyS+wA+T7P05kWUkJT30O?=
 =?us-ascii?Q?UHVo1gQf6RTlj0oy6++hq+qZc7CvR+7m9Y33SGA/73Ojjst13PkKLUlpifwy?=
 =?us-ascii?Q?E2kfPrA8BpzBHEJJDuVOCWSSr9dH+HnzvyKEibYBFuHbZ/zAFss868yOJCI+?=
 =?us-ascii?Q?61cGXkQNKrIxRuAdyNLCimHfODhpOYMgA2v3JGTG1HlB9djIo1NjsFGWOCGQ?=
 =?us-ascii?Q?tgH7lqTb8spkLL8Whoo/DPLANkBIdHJuE4vnAC+WKpsCEp1D7e8hNQnOwFbO?=
 =?us-ascii?Q?iOiCwXyLm0gojV9bUPxl3MJsBCz7QsJTwhB+cIzagtPN2rLhJ/tzvysDdDp6?=
 =?us-ascii?Q?ZhYG39E/PpAAdwIZ4bWZJMqQgMrG542vYPOoUw44gcz0XaLHH8Tog5ZpZqyJ?=
 =?us-ascii?Q?E8Nk8ZjtE3MJ43tzGWzVS08EXrgGjBtToSN73UjNc+zURn+pY2s9vOaDPhg0?=
 =?us-ascii?Q?JN1T8WCLWBUZwZYN087aMeCoySL5Xtv9U0mUhxHbM4eC30VUPhBvh5/qrV2C?=
 =?us-ascii?Q?D54/FU/BMG4K3RNDfEieDt0xylnYsTI4Ccd/Xlye1/AsBGfM20hafOOKf5qf?=
 =?us-ascii?Q?AbYesbmQRbxGW3jNO/bw1U8TVyJbKHXso1B0b03Vc8guodgJb7xpKUOZ/Nl0?=
 =?us-ascii?Q?nFPkAL4iC9UYY5iEi0fsC76ZdOIwjDyeOjWbJPpL9AMwf9kH3JmXPK6ms2i4?=
 =?us-ascii?Q?lfxPGKYe1RvVJfVTO6c1UHyIEQzyjxmh1SYwc8BxGpzc191DpahGHHuDMibI?=
 =?us-ascii?Q?qWSmbi6Iu1r3Mg+8mxHjrAgoL9dQN2hHaB17YAkir6ZHKV2fqquTmsO3Jc+W?=
 =?us-ascii?Q?c3bXW/XLq0SYi8khghhG9LIIMM2x9XRA2AZbM8YRZphUsChUqBvJUaV4fPz0?=
 =?us-ascii?Q?N8z7HjAjiCnQzuAxqJev/H7WmggT6sPdpld0N15Mye95EcG2LsCvdq0It86k?=
 =?us-ascii?Q?0V6gQvn0lJyjL6lSbrIKO0TI0NW5CgdZCfDn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:44.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78689f85-5855-4088-2c52-08ddd644f6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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
index 0aeb7a96ccbf..562d12f9d0d2 100644
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
@@ -445,6 +613,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
 	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -475,7 +646,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 0eb2a9c2e340..30067f80eadf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -54,6 +54,13 @@ struct amdgpu_usermode_queue {
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
@@ -137,4 +144,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
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
index 6e29e85bbf9f..42d6cd90be59 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -262,6 +262,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->eop_va = compute_mqd->eop_va;
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
@@ -283,6 +284,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->shadow_va = mqd_gfx_v11->shadow_va;
+		queue->csa_va = mqd_gfx_v11->csa_va;
 
 		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
 					shadow_info.shadow_size)) {
@@ -314,6 +317,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		queue->csa_va = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
 
-- 
2.34.1

