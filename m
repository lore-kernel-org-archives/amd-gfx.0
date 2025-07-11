Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12AAC8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436B610E9FA;
	Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJrWU76g";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E622E10E9F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWt9ab/PqxOq6Z98eHdAqsZTFvE7NqEFEEvhv/1t1PTBm1mHnzZ3naM8QR+Lv/f5faZSbJpAM/cX2SGeP7GNq+702xDBt0Vfe4KyhbiQeqYm+Pw8kQE+3BqyqzR7cxWPQv+QutE7i0rRjwZEFYxbJjNWEgCF6q6JQm8NAhpi/Apw5kTQQklgmN2ZzJlFRt0+yV22sIHotMGy8tdy546MvAqxc6Amg/Vrq+tAa5RJi3mzd/IHpoHzyljy2F715jhVFD4npiCNB2yOYhxbEZBovZ50FUo2PSFCWesQvVVMoU1Vv7tMNimOy0BGF6u7mVjp/+yUryC6zKoIset48h4ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkztTXVGOaDzxVDzYXZM0/uzR4b7OLYyEW8ARrXUSNk=;
 b=xvgBXtoPDuQPELByY8TjxD4ELdsaNdy2Ozz4crEf1SvKwFC3bKqRFAFddKJ798kwrimReIznq1tOZLuz77mqnZfXA7Wmo9XSv7xMFPC+c5OSTnTnxk/HdBoy1zeubSJl+hZV1stxgJo1N+4/7wukwcdzqjt68X/PRVyBxwN/5mAo5vc1/4xDSN9gyA92NcKTh417hdJLwJEmuE0cY1pimHDi1WT9ii8i8psnEgijwqhHTDjfj58RBytaKJK+selarfWikBbALTboWHQuMjbIpmh/KsiVZopqTH7qlKuAzfjwCi/LhB76pRwbBwxzQFss4OpIpoZwWzwrPBpQsL69+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkztTXVGOaDzxVDzYXZM0/uzR4b7OLYyEW8ARrXUSNk=;
 b=YJrWU76gTqGO3deTniAdiiSZEDPRoQ6R60YdYyeUUNClRhApHAdGqpYgYBudnz5nGRiXC1lirecEpWUrh23cDyjA0pdVJpTeqIKPJfLpo2X5sxbzA2IOehLg6alQGo8RQPzn2ozxyBZnw+4bNsndUEFfjayinnqDaNeLZ2/sNcs=
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 09:39:47 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::de) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 09:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 04/11] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Fri, 11 Jul 2025 17:39:23 +0800
Message-ID: <20250711093930.1411470-4-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dee0b4-f052-4567-e8e1-08ddc05edfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ar7ZM99P1NM7GHZw2x1K09AApiYf8HR20yqUd6R3MjqMayWh9BSLeBEXtP3k?=
 =?us-ascii?Q?az1F3An50Wkol7PECvh9rIb9SSWJ0Q+l5erFiU4iteMP4xR7BouK+NBpbwg1?=
 =?us-ascii?Q?6R0pBmfvvL/ILML2LHSYC8QQ9hCatEUAwwn4r723AIQioRD1eyzdFcc69t55?=
 =?us-ascii?Q?XFI6x3dPCKfMyRU9q0JkvQo71gUpf5pdprjHRLds56OjKwBkiaLiqp2XoXiy?=
 =?us-ascii?Q?/O20Uld+Uxhm1IbKqKBB/QlYwHbzMDeLkK8jcIttZeYwhgUEHzrWvoWlowzF?=
 =?us-ascii?Q?m2zXx1bijl9EJmzoR7ZNGjSxwkPRANbbYJgMXG8YhfIulRdgbcEGKQipCd4+?=
 =?us-ascii?Q?V74UXF/LjyA2idLq1jlxKsI/AFNT5jI4EGSTwTpfdMfExMbrTmM8Hs4P2s3f?=
 =?us-ascii?Q?X1DMTydzSKkZnzy87mBHj0BPKgr9I3tX/dcrwEjlCO+D/WOxwVbovWVFHvt+?=
 =?us-ascii?Q?1jXnMoYH1YqNOsY0hSs7noAg3EG39HFdVn+zbxGbPmnBZvqqiXyGoEd9m4yS?=
 =?us-ascii?Q?VNT+zGiv+oJWeVmqMcPhsojVuwjm5LtQq83pE4/87J0+Q2XoIb9GhzrsDjFM?=
 =?us-ascii?Q?U4PNlM+jEGeCN8CNU8UB2ixVfVL+DhJgP0tB735xAkB8NZRakblWb2G+q2BO?=
 =?us-ascii?Q?mwAxAb+9Hz8sCdgMcRhHMLLO70s/ABL/sBP5EIIwhe+I4t/UXnKRaqs23roe?=
 =?us-ascii?Q?CLqEM5/ZEihJYQ7ayiTKAwiUJWgaMVErFOPljuc86Diqz/wm/NW4JgcQP4Q4?=
 =?us-ascii?Q?6UwrbQcT43BUZHjLaYIcJQlM7jUWRkAC6+dETmgUnh2kqeHtWEK9TQvziM+N?=
 =?us-ascii?Q?ovqAP1/eBF7o10VLjVTGwb9+LIAvRBrZ8zD0zSZRuZxuJH0Zs33+BZm2AbEV?=
 =?us-ascii?Q?UNjAKlqTjE6eY+YEhRYMPh2B6rRasfk3pcgS4g2xtuW/FU0j626ARXPaAXiH?=
 =?us-ascii?Q?mZjkRjdIxkNb/hzwI5j28LHgRfI/3ELjyKWUs1sfSa5GUmQKKF/T0qbjviyj?=
 =?us-ascii?Q?QEd+7+QC9yxGDxO8a2IHMKGJSRxe9L3ErvPhfBo4qb/YWbZi7cFbM+Ya5IlN?=
 =?us-ascii?Q?wwY9fmkxDUx5btkpVKwumaOCcvws6O5mcYZS2GdLwbgTV8Of0viroR/V9/Hn?=
 =?us-ascii?Q?jWXihDsrf8PSKJIyT5uVjwUpMZK5lcogF3cWFzoQS3Nh40qhd/oL1t+H/GVy?=
 =?us-ascii?Q?E3pHI+Ay3y5Wp48Twga5vTcANzY60MlUowXnJYpxZ/ghMW9aU3YltK0MGTff?=
 =?us-ascii?Q?UztJ2Jz+uT1uuEsd3enOF3h7+4tWiowVcPlT9Tn8YSAKCIb36DKerKTm2Xiq?=
 =?us-ascii?Q?Oqf2PxKSfq9o0zgEzIX/vvEc4VWuJ6+tndX2A+18wXJkLK8lUwSXa4SxBtbg?=
 =?us-ascii?Q?7MH0koPF+F5hs9jFf6vX1cb0N8oycn31R8Sj+br9TfxwACSD2h1pPW6I3EHV?=
 =?us-ascii?Q?ZCXaFSv/VmdiLVjBo5q7hL7nyn3xiCPOYBYKuTMMLcPwety4rhNtaRk17tIm?=
 =?us-ascii?Q?xd2eHtpvLESlahevYCrp/d5QDrgy/51PAHM6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:47.1491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dee0b4-f052-4567-e8e1-08ddc05edfed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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

It needs to validate the userq object virtual address to
determin whether it is residented in a valid vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 38 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 15e833b1b3e3..a41dd38b0adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map)
+		goto out_err;
+	/* Only validate the userq whether resident in the VM mapping range */
+	if (user_addr >= va_map->start &&
+	    (size != 0 && user_addr + size - 1 <= va_map->last)) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -386,6 +416,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -EINVAL;
 		goto unlock;
 	}
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalid\n");
+		r = -EINVAL;
+		goto unlock;
+	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..704935ca0c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 15aa1ca67a11..75b9a6294b53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
+	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
+	if (adev->gfx.funcs->get_gfx_shadow_info)
+		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
+			drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size)) {
+			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size)) {
+			drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

