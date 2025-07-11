Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0448AC83F1D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CFB10E9F7;
	Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r40JqwUl";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2649010E9F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1HGGirwd6DiV/XQI/hK/BAjrcEjD8KilZKmAJBBu+OkUOeCVwDl58jzJXEEJYZ+8XpcuMTisDhaf/Xd5AO/GfCOTEJxCoVtp5GVQMd5lpyVrPFDfJVyvTpQn/RZybFQ+5awObV4YUhc7EQTxFB8I5VID1KvhoBEWho9l8+h/dMSi2WYL/+BChIcEim8KuB75YX1zcpRXZ/7/eS68/RjeoNqsIDOvkZsIu68BZbQRKTS/R1Jh9vMJKvYV0Q+r3GHLr6mPqffUVYRN/H1CyGhhLG9kJLUR3/xJrvyIAIc2zHCtRyneQiZWbShA8vKPfyy+vxNWxgejWyYK28O2VvNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BdtMwOkrb/BscNevhqxSwR42akVFN+kfaMLMHCk7U8=;
 b=SGMznGlJPQZxRfHXfN6n5mU9cNpOqFaJqypnGCgqrFmUs/yoZyZWkUBz/lYxVXMzdU2zO9geEJrQM0FbTF/O89nYv8buiB1hOb6yXxrKjHd6wxP1Ar7Yq+FR4pPN9mOev8OIwZWPkdNYK6qGw5rkUw66+UYGCerBYxdmrkljo8f7abPRve5whdyRBjTtYVW84RBtUdUih5kqjHDf/gqo0a0wEbs6HJyGaUKhBSQVAC062UcpjKH0oW3mHWAQe54eVxLcKzS0cwmG0zQfjCulKZbtvJC5V4byBPuCNG9Kj9eiD2BcJxZ7yrrpTSxyFAKU0GKbGTH7ZZ4/TRESQAy3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BdtMwOkrb/BscNevhqxSwR42akVFN+kfaMLMHCk7U8=;
 b=r40JqwUlSso13y+bgCbla2eGKDsiSkIVLn7qVI8R8uYBPnL7OJfQsiWcbmetXhX3/b/Ob1ST2hkveKP88PoUKEaDm05HNvG0O+VlDZsljkQXDLljdyZfOts/1oXTO58xeLUK7XCgkxn2hsyl7OXXhnnvdD34duf8JXBOS1AhtOc=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 11 Jul
 2025 09:39:49 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::91) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 09:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v6 05/11] drm/amdgpu: add userq object va track helpers
Date: Fri, 11 Jul 2025 17:39:24 +0800
Message-ID: <20250711093930.1411470-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 9186b021-630d-415c-ea9b-08ddc05ee0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3MVeEkXx4VLLtB0nfRf0NJdhr346uLrXNOTk1FDd8/Idyhe3uP+cwcwEOpyO?=
 =?us-ascii?Q?erG+llPvLtbq6N8G+I/uH5VvhizcVHBKzJVd078EZ3/ofK3EO5B205nLZlYS?=
 =?us-ascii?Q?y4OABj5dKKxOwe5zXsfwWSgDx04vggoehzH6RHkk8K9W6hGL1b2tlF7HN35N?=
 =?us-ascii?Q?FTyFtvUNeQINSl3+qer1Bvi6D3CtZcSQ82X3ZcqT86CZToqp9ALu+HbogJyC?=
 =?us-ascii?Q?GQUzhWR8QiSEB22F/ZY2w7wdJJXAHS950KWLF21tt++glFDFt278bhebbhyy?=
 =?us-ascii?Q?cxw0glJhIy63sUF0ZDcxXCXGuGa+QhdQpmJ9ThsggKYngqt77amXf5QGPQhS?=
 =?us-ascii?Q?FtrzISAw1LC1B+Cx1IhhKwpIqFV+MeAWR5hx4ivFzQSBXulc00VXvSt0KTug?=
 =?us-ascii?Q?tWb3i9eSOB1pUZfoBHIugmm9JIX/fdGztSx55KolPL6tsb3HtKaMa9cZ3FlB?=
 =?us-ascii?Q?lgsE5h7EhGacEjoBUaRH5P7eD8ChLQH0kDW4geHZv+WGIklr3AdwVai9k2s9?=
 =?us-ascii?Q?UEkwaqsoKPtqvdIYsWJHTevII/GLGeLiURGtOOtTVlN/OoZXEKGwb7oH4k8d?=
 =?us-ascii?Q?v/+gRZ5+0f8WoxuJhRxGkC6quJ6/gKn6dGgHg8giVzUuCpYl/3fhBFXaaEMX?=
 =?us-ascii?Q?cw4K4qdVdUcYIP9RjOr8GQzTXYWsrJDnqFKxVt0fWIDEhekfJbRvkA0MeOT6?=
 =?us-ascii?Q?GbVTzQfji2KIHxJ0lrGVEJhj7Poc0nWnwwLT2fhcKpnkZY81gjH5KkPc8G49?=
 =?us-ascii?Q?Rg+RX2r0xFnTo/Xuwt2GlIKemE89eMBgIgLlelsPPlAdBCae5MaZc+vVj9dw?=
 =?us-ascii?Q?qqn01Mhk8vizWaQTiHRsa4Gx8a4G0iYHiu8TDzQ6szMeppPqnH2Ek/343ANX?=
 =?us-ascii?Q?ikSnUd/CHr8SLBf4z5gLBKQv6M62qtV9WK7LaP9iG4ZQ8J9CqyWfSdr9NxUb?=
 =?us-ascii?Q?x4S2HPCTY02BFdd3tJwSCGkf1mS6xHrFZg/7PUgp2PMiI6d8tMZbYEEJhfzF?=
 =?us-ascii?Q?PrYPFIsxPJ03/iX3A4xDGSJUCmZjolpK4+chjBpgY8MPi3SB5aB4jDD+WXTR?=
 =?us-ascii?Q?xydbSHKkhg+YhSTRHPYNv4S/5XkLXFx0cKj39fRgBG4+SIQRwS8i7wzKMj4z?=
 =?us-ascii?Q?EqcV3b0OGXFeXVqhLz7AyIlDGeViL9RpYf4YaCPaVOSP0i0LxEuUhrRLq5nb?=
 =?us-ascii?Q?7jMp/+b5vCwzoUS3JGCy25rP621jIQSvOWK5n+JWXIGCUhUEOZuBG5jkAzQW?=
 =?us-ascii?Q?iDwXdX23ktwRPIsNk+rl/HjD5H9zCgM1NerY+qWcs8dXoOopk6xvxZFPNwAo?=
 =?us-ascii?Q?rYkZ/3T3g2amUBhdI8RfHC4KiSW+lrW7ibi6R2iln/Pb0yY2bWQu2ufPrfGa?=
 =?us-ascii?Q?7XU/Cumefa6ooJxTb8vY+g5HJ8vROi9ZWw+19V8kg7u1sjxPGyFDUxAcy9XI?=
 =?us-ascii?Q?hR+aC+B50YpY6q7D6B0KI9OozRvTbUQq9AvcH0K8Haf+yx572B/CbFROsiSV?=
 =?us-ascii?Q?37eqaFZtGiQTQ9oNwvtRS4r+mKo1ySakH+qx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:48.8545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9186b021-630d-415c-ea9b-08ddc05ee0f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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
index a41dd38b0adb..2856c2506bee 100644
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
@@ -435,6 +603,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -465,7 +636,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
index 75b9a6294b53..8c86c4f4f28c 100644
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

