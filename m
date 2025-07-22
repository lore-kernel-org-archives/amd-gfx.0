Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48695C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 12:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DFF10E681;
	Tue, 22 Jul 2025 12:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iF1Ta72c";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B741F10E681
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 12:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTNsq5wUm5y3rg/AuU4wYiWcdfkZpe8VDSC7y8DZ61KqwuXbdUDMayPLWLe1I6yU5UL6hR2jwxRbEc1kIcDLOt15yKyIL58Su4bDXfplNNhCf4RxNirsy6KqshE3G3dMhlhAnfsdoCM7lnHh3RCXkFI/Nc7HuZnEJlIGqO3iHIaBZTRrliOerhTROWBdZzbQEZs/ULpPi2VuoOdLddbBNbPx7ek4XMe40G/y3gabaWuShCtZXGoqmpbUiaQuGsDO6pvskdCkEyMIlZxl1t/noFxj7VOyKCgzUOK5A53+F1GNC3MfeDpjI9374k04fv9FLJu1dfkCVCmMbBLy+TPrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=Anl+kSsy2tLmn5TpA3LXqn0TruyRWjsf998wMOkACQQ9sYkMm+TtRmZu6KsYFit6qoHNPJdJJlXkUVSx9l3Jf+09U5+Cfu865zAxm3wJtbjMtruNL1CTvb357Lr8kOl5uPb4Cnmw8Tsh8rYBtF5tjVkB/R4GiMn4TzrikgOOLUDUkJvdirTUTgK+oEAYKRyLaFmsHr1zHHSdggqoN4vm6Suz+ldbyfxCR595j7qR8Ba3Xp9fd5Kikbm8KNudsipva4ZDDzOXBkZbbSYDvWW96YxePqN2z2zYFVrf3PtW6C3ffMs7B2B38d09IODg/+MJqM38/BnWmBS8XfrAUjtzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=iF1Ta72c3xhTkw1vLydZ6dMzAhoaabHAXbFWHvbuIGkpIRXy1C0JXAdq2lScfUYdxjIVzSS8jTBnxE2dacR6fLxxrhLkL3ywhdmUdszi9aOR4vgo/T/6ClkSqw+k6UBeeTfoiRzqRyR4kMdqxcT27jeFgwztwB/KUzyt370w1ec=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 12:49:37 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::61) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 12:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Tue, 22 Jul 2025 12:49:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 07:49:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 07/14] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Tue, 22 Jul 2025 20:49:16 +0800
Message-ID: <20250722124916.1471130-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 63717b17-db30-46c9-fc25-08ddc91e372c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zcJH/uSMe6PSoTpwKAq02QWhjNBNsK6wGc5Shc86r5gAW2myQj02utlDGeIL?=
 =?us-ascii?Q?Ie0H17loYGUjYmYkAvsSXfzAgluKS7M+OmQy5zVZdrsW9vDRZ/3sh9Dxuy46?=
 =?us-ascii?Q?b7SR/vORVQK8UtYOaIZAXROuiJc5ZByhOFDdcqQf+9HwQmjHezFP6daLEzzD?=
 =?us-ascii?Q?JBcP8EqDhAUU4HIO/PQmDACrnMhBdTZffNweME7q7EDe6vlnKVtFoNtX1WG3?=
 =?us-ascii?Q?66Z3oqIIgjDF7YCts4pq/SyMtNsYUwmwk/3/GEDyvhN4PhpFvCgwhrDekmUx?=
 =?us-ascii?Q?kuI1aZYtAl3HyJToj68uMqeop7lAT2ZD+mRUXcdk7X+qRu9gQeFDOGd/iemo?=
 =?us-ascii?Q?fmt019xv57WLdZnlaF0vumZ/Z+fFffBtXJIfgkOoaxmS1cTKEtgBQ7jof+7u?=
 =?us-ascii?Q?eHpL4EZJNr3x2yzAW6CFL5lTT1QApj1XdRBjU3Q7j5koqudTcS9tHtDb6dI5?=
 =?us-ascii?Q?4ze/jt9uCHmw6M+yUn8JEXBbg4M8N+AzqyNo0mhyKnB5p66Djc8EWZYyy206?=
 =?us-ascii?Q?ZLiY4AZizz8tJ8nfzav8vfM6oIBqG5DKXdS6r4wiJObx6ohoOKmsrhg+2OBZ?=
 =?us-ascii?Q?pSPYJGYiIycidPncKVEWaX3qDZDISMF/DTjiBYb2enWaHyen/yK9m5XBZhZr?=
 =?us-ascii?Q?mqIOJhDBXrFUKB19JFh73Iqc4emxtjeiiucGGbbkFDVp7NlPaAnP3VkEiJJ7?=
 =?us-ascii?Q?nuqH2UVLpbjRlY0eTNkae5jACV5Ze4Wy/JKVHhjntbgK+8EecB0u8e5kyQOO?=
 =?us-ascii?Q?PmAcB/I1qJoTgUoJ99PKc7g5lsOv4ye5W+mlwbeJOGh+9hUnjHhqtAEGu4oq?=
 =?us-ascii?Q?6KJvHCMh5dnpm3vMIoa1MzauDvSyDGRyuTF28+AAB6TqgyKfaQwsba9EKsow?=
 =?us-ascii?Q?p4tCoVeoWa9zrFig06JmI8JfCMDymIffukgL2OMSgk7c44S4tG7hu7SdwqIz?=
 =?us-ascii?Q?QjjKL0B0rWuOE9pzdl4z1X1nrAinYRqQ2hana3INHNXhUnU3uRjWa3Za8Skc?=
 =?us-ascii?Q?OVnmmEBJB5wAeLNDGhrJAQ5z2KpdASrR+BZKgIV/rsnfm9TLcytTh/ltIKrS?=
 =?us-ascii?Q?fIHPVPpXxRsyPuMpUm/fuoaoinvmfvoSzDWe2rHryOE6FijU8V418kTbmtH0?=
 =?us-ascii?Q?YrtCc5O8wwcVHB3vXczJqYOsHhzHCZIpeWqFAV56yra6sUJdqsj0vb/yQOm6?=
 =?us-ascii?Q?7sWwpNvGpQDg82ikY+M1XwI5oXHXRNLWQbpGT+1ri1j0edK0+nS37x0Yg/hf?=
 =?us-ascii?Q?R0l5NMdHOM7+zNRxb14A5VWPVW/lP8YXpX1U/oNBzseCg3k0ueQL9h4Ek4Rg?=
 =?us-ascii?Q?Sjuc/tjVQZootSJnKL8AqT9eq3FuHzlvTUtwQyEZY5XaHv7LmoKZ3VagdD3B?=
 =?us-ascii?Q?1IpGoEIthCYGoZBmYsDfKI8J7f+2snauF5HHmWrLWWtCV2MT4IZSsrLUwtze?=
 =?us-ascii?Q?KKJlPXwvaEno7q7JuKkBp/g4NY8ad/Gj4z7BZ9G+mNwkNgM7AEpZs7TCn1EP?=
 =?us-ascii?Q?w7Ur7B6mp9SiLUxMYVaQbtgMnerxod4K/udd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:49:36.6959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63717b17-db30-46c9-fc25-08ddc91e372c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b670ca8111f3..0aeb7a96ccbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,38 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+				u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *va_map;
+	u64 user_addr;
+	u64 size;
+	int r = 0;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!va_map) {
+		r = -EINVAL;
+		goto out_err;
+	}
+	/* Only validate the userq whether resident in the VM mapping range */
+	if (user_addr >= va_map->start  &&
+	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_bo_unreserve(vm->root.bo);
+		return 0;
+	}
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -399,6 +431,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -ENOMEM;
 		goto unlock;
 	}
+
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+		kfree(queue);
+		goto unlock;
+	}
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 694f850d102e..0eb2a9c2e340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -135,4 +135,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..6e29e85bbf9f 100644
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
 
@@ -247,6 +250,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE))) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
 		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
@@ -274,6 +283,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size)) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +307,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size)) {
+			queue->state = AMDGPU_USERQ_STATE_INVALID_ARG;
+			goto free_mqd;
+		}
+
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

