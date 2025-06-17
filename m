Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1196AC7115F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C797110E534;
	Tue, 17 Jun 2025 08:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMmSABr/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD96110E534
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckjoQZMFKzTTCXnND2yKoLGiduiUifEOF3zq+Scl1+u4m4tLlZYjdUuC6/EqrdAvVdkRwUK+A/Ys9yRV8udrZC/65OGIadB3X2ohM0IowwTGFfHxFwcWimRcsllUyPcK3PZBcoJo7rqRgFpoNIsHQtbC2uK2FWGDaVO07OK/Oq3+CO9Q8Oav3iulAbYHbww6uivYk9+uVBy2L4ALS644TbkjwvLJWJgTOXjcP9bgAzcu31RHZBHMIYvucs803/0+Hr58m6AEhnjprcz2zs0gveLnZTcEEUPSaA/BfjJRHjriSWU9KOZw25Ff9plli0CkGBOSl+zdiuFtid7kD9wOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sAYGfY3ywFZjNnKRo2QhiqHCZxDZe4ix0mdGc9fp8k=;
 b=X653e9buXUrecInuxAT8g4ACDjtbNaZtjmnnWEQnbPoegMsa6BiYmT5kkHFo0pe46fp2eOY98cP36DEZ+5Qw1aIG56E+KHgD+w6sL3HesLg1OOVqQ/y4w52y7z8pc80e2aRCxTeYDmLJr7jULaLuoUCgGzfWRSS/LVJ610gk8vUZNx/1biGxyGPPEP+uWQwIVaQJFo+BX9ckHZh2WPCZweEFpJIMWjVLm6kDEvT8ZnEaJc3qDFJhIBUFFbKXuyF5q+YbfW75bfkvd/URn1ql6KXPDAz3Fsj6jqcT86Cvsc3K5niLSRrX9aSy2OCpE0JMsDLCmrZ3CMPAwpcLFXBZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sAYGfY3ywFZjNnKRo2QhiqHCZxDZe4ix0mdGc9fp8k=;
 b=nMmSABr/6yx9lSkucKxXq3SG5suyhxePlcvkOGw72TkqbcHG7mfPnaJSXf/ZrrKsYsWpzeI/FkRH0aQCgvkE6Z2jg5g8b1xo1DEfEJT43xFbqMm545eROfIyJuJlP0OhKOBuhZS3Y63TGN+KQUXagsSUtwgtD29dJUvIuV6fW70=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:02:19 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::84) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Tue,
 17 Jun 2025 08:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 05/11] drm/amdgpu: add userq object va track helpers
Date: Tue, 17 Jun 2025 16:01:45 +0800
Message-ID: <20250617080151.1093481-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2438f707-cec3-45db-9bb6-08ddad754848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uA1h4vlCIwPx+RFWbj/LYi7X664LISpz24Q7tyLA8phoW1iXxRgFYK6JtdkR?=
 =?us-ascii?Q?XF35YtuVca1U+6YUz1pvRvFi2uGj4BXj9oGfuNNcIArU66QYJAbxsw/DRTnb?=
 =?us-ascii?Q?QpybJdZqPwYrBAK5V+Qjd/xI1ujtbK4ocGP1Cx1pX1QngWNm9a5pWzzZuK0R?=
 =?us-ascii?Q?CSR/SXeqFgwnT7WWnj4L1qWbo3RGcOybY0YmKaMDioROwcYMrrYt6RWkt6Q8?=
 =?us-ascii?Q?pHFNjsloSou2mFv8NCniTZEhTtc30Z58ZKwhJ3yZbWdHxDgQGAvP6wOK1zTR?=
 =?us-ascii?Q?jrLFZUoFHJmLE+rBex5H1USBzZ07JBhTGTmuiwmtDTvKfa9OMEaHO1ImA3k8?=
 =?us-ascii?Q?qwKEkJZTC94rZ0vjt0p7tUQCvuU83uO1EiiWkYs4V/QGGpoJBiU8N2QuV9Vc?=
 =?us-ascii?Q?ZS+kkg1y0dZH+umlpff13DO38eAXrlFBqbkdGRFoQMoUAj1aoXlTOPO/Ru7I?=
 =?us-ascii?Q?jqV/IcBZeT58IrX2w0qYHlPCofcs1bEvh8ikA5/uh+s/gjS6cHdIMLP2Xb2R?=
 =?us-ascii?Q?pAoIcuwmeGgk1rDtE3dtGttj68WJ6X765CC4DB4L945A/CFxlUBoWBeYUzb9?=
 =?us-ascii?Q?oV4lQ5/dj1O64HvX2Y35QBmO6ZajfyZAxze2B1qRxp+PTm7dCsO6S90jvfMU?=
 =?us-ascii?Q?sVjGoBEHtvrXeFyzYSJ9erO0aUj9aaqbBp5RkUH1QHqwTBWhO3nt6XdKfiia?=
 =?us-ascii?Q?DVUraQLTEQ6cp5uYlLs0400doxUyICH41GUAVf6MMYjnpa8Y4xAMZc6AQ7KS?=
 =?us-ascii?Q?Wtxmtzz7w3vhn/786J9GmRciT3/TNP3/a176jkP8djHk/8oFgodE4bJ3UgVT?=
 =?us-ascii?Q?0C6nVYyVuNtmfMjlNzojJl5MLU3Wcggehgy2kKYpJA1ueTCBq9QbZ4lUNg7+?=
 =?us-ascii?Q?uL8JXh1hmqFckeFwvC5WTRnH5ou1tZLDKxkBm9rc1FWjmCNuPGIdAc0trUwL?=
 =?us-ascii?Q?JSycWXs+uu9z0YDmZ6R0JJPEdkBLeOP4VxP/4xLnIS91rxfrN2QJDAiw08VU?=
 =?us-ascii?Q?0+hPOE33GCIaLWmv47+GtV1QsqrHalbxJYLvDqhFYhmfS9oj3unav6lg3pg0?=
 =?us-ascii?Q?4R7LM04IrqsuBNwuwFvniHa9Y6UQuvITya+0If+UKDKEJWkFbsqsVK+7p4Tk?=
 =?us-ascii?Q?l5m81R2K/+QWI6JImCc8LNH1mTiuoW6tnKP+XHgbW1Tk6gdKpK/LgfLK2k4A?=
 =?us-ascii?Q?eNy3QYluKV6nTNIZa2BHrh4tAzREZk5BJrkAABpnybNGVmKtEEaAldGcFftE?=
 =?us-ascii?Q?B2jayy0RSL4rHGWslaBmKzlS85PJBDhVAxdpMdHIDaX2XPXquTMG10Ow+Ody?=
 =?us-ascii?Q?xFNUDPD6q0B15ulCkY0yDKJSXDark/OD2X3LKf1NtJo+G7mDCns0dMIvbIVb?=
 =?us-ascii?Q?yHU9HS9K96oSGVfTqlhG9G/XZlEKM/MHMt4YadpX/AL9nbkoaYEzAsTElvXQ?=
 =?us-ascii?Q?eoFDt1uV0NTxPnQ0j2E61oSskDsSwkgebvZbLQXjfpYm4V5gBwmG6SsyrvCc?=
 =?us-ascii?Q?3SL6Jfq8jeT/rWaTgda+mnarR/1T/JoqKoLN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:19.1549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2438f707-cec3-45db-9bb6-08ddad754848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 114 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  11 +++
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db47e90b8c83..2882ef8fe719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -76,6 +76,116 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
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
+	 *  doorbell bo
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
+	user_addr = amdgpu_userq_va_align(addr);
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
+	if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+		amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+		amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va))
+		return true;
+	else
+		return false;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+	/*
+	 * As the GEM userq bo will be unmapped by amdgpu_vm_bo_unmap() which is
+	 * invoked before destroying userq. So if the user wants to reference/dereference
+	 * the userq vm bo, then ensure the userq vm bo is dereferenced before amdgpu_vm_bo_unmap()
+	 * or unmap the userq bo VA at amdgpu_userq_destroy() directly; otherwise, that results in the
+	 * userq va BOs being referred to unbalanced and causing the failure of amdgpu_vm_bo_unmap().
+	 */
+	/*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
+
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
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+
+	return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -442,6 +552,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -472,7 +585,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 704935ca0c36..9543fbab7cc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -52,6 +52,10 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		queue_va;
+	uint64_t		rptr_va;
+	uint64_t		wptr_va;
+
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -134,4 +138,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
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
-- 
2.34.1

