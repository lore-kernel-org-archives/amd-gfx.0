Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A050AC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E4710E4D5;
	Fri,  8 Aug 2025 06:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+Enbw2C";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BD610E4DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5GZoHCI2EvNTmyC12ow6cnsJXGHHf8NlG/6ir3Se1So+pnX5BNFz9+m8RxpGp/c7pbZdy3GLmWVg/alypYbFrXGAsVXicQEn5XXgqUNWtX0U9IXinNRFmihNGL+qyLmewpG6/cro6gxcjhDMVbUHMlqmdSvpdaK8bJaPs9q9pSiPg9C6q9/Ile6RuGTkErmXWjDjxXbNjgn2Zt90xQU+oUgyKDmKS02tBZ6tRLzalybYFm4BUmB3ic+gopDsFxvnR7c6Gh2ARSOiv8HDRb+5H9TL6kf1hTJ3bw1EBObzyfi79Sxf8M7NsFQ6gY4csmTG7P0vbXzkAHV3epJTghCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=x6BTD2kiKV1tREfr1qE9EvLklLQMm7GS9fqy5zyk6ZgniYEVRCsw7A22soMsQpRDgUQuWFBNRkbDRBmL0AfByeiMGGEfcWE4Xp2UbWwllYvFtsyDw93Vxv6yU4lW1p+1x+ef8nzq6Y+y2Z81zPlt8BY1XvQvHlFQ7eXMZJV3spVad5bC9n994DY6sDMapd/jcntW2j8hehl4A63hAo6dmaYmfPiIcvv+rP7iL2IloI+NXoFOUmkHMFYSFhMl7gdcBcMm/LX7cUDEW/PxZprX2QRDeQBpA15TNJc7aw5R0vfWTWHx9qseLwOL3WmVLY48yRMHWhwdHIM1j/8wI5xePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=z+Enbw2CHhOOL/0Nh2e5i0l2wdYG5OLEG/Atcb6ixBfMEp95zgcDgYlYq/oOH4ReHG+32UaYinFoUIP/duCLmxHPq7mnAdK9sP382rbICuGRzn7hTp7LA5//dp2KV8GDgYhqE/4ids2RZGEXqsSc949uyI+bT9tQpHtfx+71UDg=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:29:42 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a4) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:37 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v8 07/14] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Fri, 8 Aug 2025 14:29:03 +0800
Message-ID: <20250808062910.1613453-7-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cf0528-3425-4880-8c9f-08ddd644f553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2cVphZGdesibj3ghFgMbfiWa79Pl4ZfkhKg3PV4CG7vi31G44ADvJRRn4tzv?=
 =?us-ascii?Q?zrZuZHyekEfKLnwPQa1lvs58o0mtugCSlaBGQBCgBw/pTVIJ5q51C3kWXhZL?=
 =?us-ascii?Q?Dc/kBuew5OFWWxLSkxnnrU+aKwZI5cSDrZEUhQ0ckyaMi7mUL/UwiJnFLnaj?=
 =?us-ascii?Q?DXr550LZX39kWyDy5CEtQKItx3gyyGwateAdaZj3twXHs/dW9cIdgrqt/VEi?=
 =?us-ascii?Q?V0av2iLJ9qjTjp9+at3yHpRy1j7s7JQ3Ni517hSPsIQHBZ5A8pON2m8bsZM4?=
 =?us-ascii?Q?hxPcUCVT7PR37qtpBHBa9rDABOOJNoKIrVkoy8GeP3y/BTy7zxkdyqDobbq6?=
 =?us-ascii?Q?Fb5XCbT8qg/Mn+u3MNDmiC5DoaUCq4n6gOzC48xFWgNUScQomBdOdJjFhfmn?=
 =?us-ascii?Q?bw3kOqxxqiLww27hsh5J8x2KPvT0I5GAexytxI3izzuuFC5g0oh04GMbmAXQ?=
 =?us-ascii?Q?pVsgsEjs0Z/P70i7M+lG2RmqPFpJlsovxP1EwBj8UWYSFGbgrON6U3YjjCrg?=
 =?us-ascii?Q?/PCbbYITd8GIYupS3DkO+ObO0/sZEq+/e8O8xsf8L1Gv35tx+95M/5ZQTIg+?=
 =?us-ascii?Q?2UoBXLfQEMNazgFTgydxEm1QPcYLY1L+U5TG+4hERb7AHfo6XRKItX/QhI8o?=
 =?us-ascii?Q?LG7wSgmryFkN6pCeCcEqPjtFXju6tx62B5jJv9Kv0YyDxS1xsyH2ae+GwZxn?=
 =?us-ascii?Q?qc9gCy5OOffZv4s6PYye+/HZseTmvFTWkW6GGyW9AwBeP4h89iCqpHy6N1wn?=
 =?us-ascii?Q?kMVgYW2BS538y9Wa4ewYAwvE5LtoX/MOrdA6v0CDDGwwixmBc2Sg8q4HCIOl?=
 =?us-ascii?Q?sbGlHsTT14dEl0MJGdtbWkP4pfZkVNLbrKqWTZwZf4SVgvxDYGg4WdrIcb/S?=
 =?us-ascii?Q?7G/+KxxVuHjU6zVGkRUwKa4TGWm3iFNHoRMRQjtq44oJO/O/MXhWucj1YdwJ?=
 =?us-ascii?Q?afxPl/a3RPm2xkeJPvbCpqleVAypIejSywwyFcrIdV3Il3/31ihJpLd/KcL8?=
 =?us-ascii?Q?N9AdLPxpnvnL4ohcmObYdAEhNHtTZJzybYQvAYvHZPVc3VPf60OX8Kp9xBch?=
 =?us-ascii?Q?67pMkewj/Km3FSrWQN00PcGUev78mv7Cu64Lkz8zGdznManIxITc9Ylcug5D?=
 =?us-ascii?Q?s9vAbIc21fap+dI9/zXn0Ast4nBamaf0yBjJDejCYgFRAwuCMUBafCil8vCm?=
 =?us-ascii?Q?KLVWqW6MU4kzHhLGWd9D2evNC3DexnImiBhBiSL7rtyXXq/jDgIRfqBgKQNI?=
 =?us-ascii?Q?iWImCLS80/vyVtLdQJUJALu3FV+4OwMbzOah9qHZm+qulH7KMyphMJ76YfWW?=
 =?us-ascii?Q?xv6EBc+w1LiOkGMbgho5cs5pvK8+RqbdYdD3h0E1pi0tFCRp8+NwFIrdf0Ul?=
 =?us-ascii?Q?pTRnU6ChkGHF0ghw7KvThLwQFV64rZpF+GmhtJWm6NCBFU12yOfW7CuuA6s4?=
 =?us-ascii?Q?gQjU+s/30xiNSB+kdL48dXDR9FOjIOR0z+hIsTntYYR2goFv39tjaVSg0s0+?=
 =?us-ascii?Q?Wd5wGsFTcz1uqeWKhfPPfgZe5scVdHVLeBki?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:41.7151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cf0528-3425-4880-8c9f-08ddd644f553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

