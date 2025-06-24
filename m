Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8BFC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A0610E531;
	Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4a8Yj0Z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F56610E524
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKgID758/gbo9YVHu7G0RQMgnVZDwIS/J23DYxp5JVDuvV3bWtiXigktclkI5pvEL0p3t5KPIgcFNsy3t31r3+kKyotGRvM1wmT4ez/KgdfmANB2nPZn+acpiGS5z+/oFa/X6GFJn2dMJU0z4yrRbEW2o80YKcAPj6yPd954ng620a6/hUX1Rg0nWfbZe4IjxTjTwjd4zjmClhu2tPY0op3tXbFnjDGeD+lEec07kV6cGTKa4D7QOzn6AuFqcuVZ0lwyZFz3HV32OW0jKOEIdJamE3BOSez6j3MM1NjiEGuTQFFjzLQrm+IlCgMbfrSxtB5uT/pF/k860ZGj7oRIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zftk5m324CI1viEdXHLxw0SUMcCdyfQ7rKbwyz1E7Q=;
 b=d/i6QHjf6hIR+jZSf69lcFy83U713CH0GiccOrYhjJy04lKei6b/jowSle5e5czSlMz/dlOzM+mWX8n3obAwZmYCCPfWHEHY+DzbDcjwUEnrb6DlhC/4EKy4QD/AJThrAqSxE+BV8d6qKd+L8CGAKoQJ9pEOA7bPSFOpLhXXqgWO30LPcjdkBKBpv6ulSfpbesGZeh+GlupCIZqoPKNaMwxfYNGi7SpxQ8kF+3C8RZEz/5xoRsAO0mp07rRZr0NMCP2CaggzA/MczCWYJGqZ6lYFZgOrQjsKN6eak9nB0ldEogVSJWz+rWfuhJhuqC/pcbMd9WlaihASPKqHh5QLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zftk5m324CI1viEdXHLxw0SUMcCdyfQ7rKbwyz1E7Q=;
 b=n4a8Yj0ZIf/QC4qjNyXeW4pBvl7os6vIoRG5OcduSDlusfqGSNLUk1ePbGgnBZgOzvHroZpxc3BQu40DQRhU7iEXcmnoIZAbAhSs4tQ6XbYc2af6JgyVfyROSif6pweIhOObXhdDUytW3LsV7y6CyAvZj75PbyqAZxo2wxFMjz4=
Received: from BYAPR11CA0043.namprd11.prod.outlook.com (2603:10b6:a03:80::20)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 08:45:54 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::84) by BYAPR11CA0043.outlook.office365.com
 (2603:10b6:a03:80::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 08:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:52 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 05/11] drm/amdgpu: add userq object va track helpers
Date: Tue, 24 Jun 2025 16:45:29 +0800
Message-ID: <20250624084535.1178476-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8c51f1-41da-4c7f-8184-08ddb2fb87b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?roo0nDbUiUjWI8lZGrtwwmLwdQtrTA+gGvQOd8ipMgT35g3mJTBo0aEShgNU?=
 =?us-ascii?Q?nWPqHiKeRti/d1n2oZFhC/KaCWHoiJP2uQvog+SE++m/KvCEe7ZkJi7G+DtM?=
 =?us-ascii?Q?7oUN7YMmqP2XYyzzusXfQJsdeOHtTAke81ymPPAxoXzGdOB0faXGT3BdNRNA?=
 =?us-ascii?Q?aXRyI1iutnDEhCZbMAC47LLnIfG3L077oRlNNY7klYVQr+iFR86kNHr9Jb8j?=
 =?us-ascii?Q?2aVKvD2QVkBU9uNzU5iAB0bA+JxZhR0NajNTrUjqpo2oHSZE7gFwE7CXhrBo?=
 =?us-ascii?Q?wQAA9UpUdv1TIJ+oq3Qtlaj1DJIngehcf06Gn80J8c+7zZPw1sjKNBmuSaAE?=
 =?us-ascii?Q?utxa7Ca4mNqPTw4Nwx66C8oLaXO3T0xcy78OvhKL6dO0cATqQJQHYplgrO/z?=
 =?us-ascii?Q?kLi4jwMesLrzjkmzZDGH9nfyngG6+i65K4JPdedODXm3w1+gBhZ4JnQHU+9w?=
 =?us-ascii?Q?OWaUcMcc29CAj9t+uBhIv6JtXm2eCni9E3y2L0hylMm6Uqk58U0drYKu2VxR?=
 =?us-ascii?Q?uqqKyj0S3qE//nVcWxJkgtwuV7zXz6v1WXdeoRIteflbQgfn/+f7p8zcnJ2/?=
 =?us-ascii?Q?eraBVeaJtoBvbEHZOFxL7j6RFYuNd2pT5nO9Y7OJ8o9jtZPRdZsvRM01pWHE?=
 =?us-ascii?Q?xHVBOIXeczY6fEsOO0GSSoaK63k24qO3ClYqfyOZXlNPHmaHDGNoyEcVQI6N?=
 =?us-ascii?Q?heDZCvUB3o6OG4bGGPFnJXOLc0poNzGN4Zwct9uMHRKabDcF8g1klxzZqTU/?=
 =?us-ascii?Q?9D6x+yqa1zxEpgpse/y5FuNRgjNzqwK8mAc9T49CL9gDIbvjcvZjkTF3RBWO?=
 =?us-ascii?Q?qcXYMnyCikePegBrTcVI9hF7izu3D3NfmViuCMyaLCsnO9JMN+mGRqOWh4hW?=
 =?us-ascii?Q?UHLGmn0U2QGt+OB04dRUvqsHbnmkNGBO1IXV6akBbvdccCd+VAVqoien31Mx?=
 =?us-ascii?Q?uCM9Leet3YYFDx02N64OolApdThb5z17Lmol6oqynM7OUneQC83lt7tDV9FF?=
 =?us-ascii?Q?YZV+wMY2ZrK+h7KRh6wOLKAIESroxx88MlnA9CsxVavv5BK5DFD76ZhyJ+IF?=
 =?us-ascii?Q?BVdi5kyhpECqBQq23ko1Y663lXWHcUVCaAo1d7jpndj1jJBMbSSV8Q6rkDCB?=
 =?us-ascii?Q?Ed5f3gKnOJo34R4xEN3n/pv1/si+MnGOi49zErtDZmdF7HWIySAPI8waeJH5?=
 =?us-ascii?Q?j75ZXcFreu3pRmARO7kf+wjXltuAzZgXzcq0xxyqjez3aI0PwUawTAWH+QLp?=
 =?us-ascii?Q?Oand+bj0Kc143KSp2XFZ3oEmV/t5RmAZNGpAPyyEHL7+h8w9yeHZThER59NY?=
 =?us-ascii?Q?S1LEAP2YxKNFX5J0E4Iu0i6kfZ8kjBJX3yD8rrLpnh6HuBTnqtIYnmhelFrK?=
 =?us-ascii?Q?VBj25T8nqLmbzgTtsxLK7ajZ9sMWN97GHxELDH3c738F35jKP+k9bOQXp5aa?=
 =?us-ascii?Q?pQ6VlGNWHDN3eL+tNixvZLI0ddgemDACCKwMKEdj4X9B05aSL9usIPYVOQ4h?=
 =?us-ascii?Q?teRoIgMeFDPhRbGjAss1XBSUkNxk+AaSG+rE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:53.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8c51f1-41da-4c7f-8184-08ddb2fb87b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 132 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a20f7ccbe98e..cbbd1860a69a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -76,6 +76,134 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
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
+	    amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->eop_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
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
+	 * If here refer to the userq VM BOs and keep the usage count by
+	 * amdgpu_bo_ref(mapping->bo_va->base.bo) at creating the userq IOCTL,
+	 * this reference and usage counter will be kept until amdgpu_userq_destroy(),
+	 * while the userq VA is unmapped at amdgpu_vm_bo_unmap(), which is ahead of
+	 * amdgpu_userq_destroy(). So, when amdgpu_vm_bo_unmap() tries to unmap the
+	 * userq VA mapping, it will result in an unmap error caused by the BO's reference.
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
+static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_get(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
+	amdgpu_userq_buffer_va_get(vm, queue->eop_va);
+	amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
+	amdgpu_userq_buffer_va_get(vm, queue->csa_va);
+}
+
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->eop_va);
+	amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
+	amdgpu_userq_buffer_va_put(vm, queue->csa_va);
+
+	return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -442,6 +570,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -472,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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

