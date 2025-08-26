Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E0ECA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9517E10E5FB;
	Tue, 26 Aug 2025 07:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mh9PUbui";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E81110E5F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg5mDuS6zdZfAzOrrOf5bsWakTBgBJ4VAho1yGzI+ucJ1VXr14oazMJ5VZshVUT++7GuynpcWrQzgzGIfnh+ObkplbqwbSvHnhW/roxsiGUnsJLvF8Mv3XrTs7HbUDvJtYsjyfblHi8+PuL/RPOXJ4qmdnmtsrJGm0ZMDGrL+xOVwjYblTtzvmsdJknbE3D8PfMT2UswTIi6ciF5FxGqrYCaWXfR3z393y6NYYdRmSUY2jesxo791lyz475f3PlHG7tFUVdK+NiV7lGxzqJhpZ5WlmzoLMF4Bu4jkbnVEo1LsOjcuTPyhW7DPg1YePBl5KBi2wpZXuC1rIb9BbZHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDgueBW6I7IXSpmpzaWRf0tcNPpFLleSGtrwKzJsV9k=;
 b=Y7z65WQOrqAexN+Nu/TEY0/WjNza32Xz4Crsxg/ABV3YP9GlkUB9TzcEn8WQtA5bFHk4T9YI6hzxeX+rQ59J4EqM2kuTIqVt+SPAnHIhTtlu2Dl8w1qXMFDCQEQ7IZpFsKKSvzhzyrVjYNx3Oqbuyek3Bnstq1zumOWFBFhSkMA6sqjHnjuVFT2GpEEGc7aji8pf+5qZBxF2mtfABURGvylG+hkhWWtJJj2CW4BlRkQL+WpmSe0v0T7NYylBsWvk8ee3MgD9LUmBiSq0Tcns2ugrWwOOjsuPb7TgsnzLJwohfuushqnWOGYyXr2cZNAwg5I4AiSX4zSMp06mb/NLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDgueBW6I7IXSpmpzaWRf0tcNPpFLleSGtrwKzJsV9k=;
 b=mh9PUbuiYL9K4mtGU9HrW21pNWDBABg/FcbIqRp/X8FR9JZc4mG+uk5dtLkGZYnE9z/fL73uEq3Emm+JCUIf6CbKWM83ooogYqkPxYDZ9heASWF5vV1CEML0ve3HWdc/sWUGYtKLhAFzubVvyk//JmiGVixARCBDDqbLekK/D3Y=
Received: from MN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:52f::30)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 07:47:11 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::93) by MN0PR03CA0014.outlook.office365.com
 (2603:10b6:208:52f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 07:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:07 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 08/14] drm/amdgpu: add userq object va track helpers
Date: Tue, 26 Aug 2025 15:46:40 +0800
Message-ID: <20250826074646.1775241-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 69023b21-63ae-4889-9787-08dde474c407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNHsk8XIsAcL/bCrMcyR4M4wegfNr/YIh1CvNPhujUyYKN/NTH/LH02qTmsE?=
 =?us-ascii?Q?mHE8AAmdqtjPJgDpomVB4Bt1rtSZKPtvbtFqmAx7BDxxjaf7iHp8a7QFUoSD?=
 =?us-ascii?Q?KFap8hYTqLyNASIam9mDqUmPMgL0EAvet4TDDCTke/3+Z26xK+nv29M7D/tk?=
 =?us-ascii?Q?eOhkd320lsRMytiua71G/TrSmFjhsPc1lP5epE4THrpXQ2u3ujFaNbmaAEK4?=
 =?us-ascii?Q?5RnmRrN2T3pYBffslY9YORJE7sWzZkEgR1eEUQClWzawIrBMZsf988kIRQep?=
 =?us-ascii?Q?5VZR+fqOAT6oy3yBbnoO8R0nvujThymRl53TQSQQtyy6vUOeegqIBBUtrMGs?=
 =?us-ascii?Q?Ez0cKpQwQ9D3HhT3A93/Esk2UP7yRa8rrNtfsU4jUGNhTkdybUjDUFkXH883?=
 =?us-ascii?Q?rkI0uigFd/61FPfS05sy+/P9Pq8kVzA9TePaV4Ttku4yYlE/kmXlV8XDyw00?=
 =?us-ascii?Q?EMv/ijOGp0DaC4MJeWX84NwG/D0G2colFITYUzur1jnHv8EZZE/0ZUNmBxV5?=
 =?us-ascii?Q?7GeakrB2+BOKiH1XcnjnLkKS+lBqAq+fexGqZCblEn4t+O+qHCWC2+L8YR0q?=
 =?us-ascii?Q?pf/149SEqbPxJG5VAhCDYP0PraQ4mtBMgwd427qSIyost0VaZX8daSzCMUKp?=
 =?us-ascii?Q?nOKvY1WJwUaRvWLrKtoJtmkVvu7Ezgz4SNVLHgyHs2LUO3LZJPMkP9cQ46pF?=
 =?us-ascii?Q?JT1kyvRS3mmxnTiFZfhLUbUeKSqVVYM5iyf0U1JNXw2DVlfU1a0IrGzcdEHs?=
 =?us-ascii?Q?p1vm5rNXf3iTyaIXyXEiROF2SRXDgRrw6R4SYSQbCZXbG/LGCbcXkpV/Qlno?=
 =?us-ascii?Q?vZ5H178bUFky+XEBBXM9u++EBUgZAm1gl/7hq1FypG/JatQEQ8ByvpzeD/t1?=
 =?us-ascii?Q?DLSsRVbe5u+uKv/tuelovjopJfY9wcykbT3ZBkKw0wN38lDEo/b5+wRE/xVI?=
 =?us-ascii?Q?JNWHdWgPYMyuUyoL9n1oFOWSh4LQNGstoI0fnRoel1OjzkC/Z8RfG1udgJk0?=
 =?us-ascii?Q?WF8dxRinYeVQwiI+vBGk4yMN2c7oiJBgTCPJkTAe5uSndAqXG0jd51bgexLW?=
 =?us-ascii?Q?ZY4juV6QKDslSMINDwH6NFrXLTYvd7AAZ0Ap0MMPQA4AM7p98SwZvrDZ5kzN?=
 =?us-ascii?Q?wnn+MDU9W5PzKbiZE1oyMaZP8b3XhKFbMH58NyFARF1YteewawwUBnP/oiFh?=
 =?us-ascii?Q?IaqY7h4KbelEnelUaXQ43EReN9oKsYSxXKSVJRGS5QRwgGPsvVXNyrCsaDqd?=
 =?us-ascii?Q?IIx07fy3l49+n5n6oM1e5MsvjRSUDUaFDzx6Hn0II/cqFQINVjba47tgc6tT?=
 =?us-ascii?Q?LG1srRYvk6mvRPRugphmVkt3fuxBWG4dlW/cb5OqQGQt1ZcfPCbu+S2nPDg/?=
 =?us-ascii?Q?ott/65tGjdps3r6oq6bDLmN9cb4u6ESnAsx0mu8+04vNJ5Yiz9a0t3S6OSyL?=
 =?us-ascii?Q?evENrhhBjuJxMCF1xfrHCMGFEC3gB65VC7d0FGGqIrfmfydcZ0DriIKW+tnB?=
 =?us-ascii?Q?H8PeGaKBVeducJ+817wKLb15KPXM2ZBa6M6E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:11.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69023b21-63ae-4889-9787-08dde474c407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

