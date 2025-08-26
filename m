Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73808CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E311910E5F7;
	Tue, 26 Aug 2025 07:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JdugcenD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3F910E5F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJhaB35GNCSjCdAsU6hSdQubVIqDJwcM+Q4ku5b4TgRSpvJ7VRd3njta32BDy7Q79t55ojYGkVKnlMXUhFdZwM4SN7XpBAWhZw4lZ/yPZ9wnz+EdH6i1Eaahu4ms0o2oTaE2Rf312gDkAe4gpUjJPftumiGJ6QBqw40PA+KDw9VAccB0ABGNIoYzryjFKXVxMammNJ0EyKrQ+y46Pjlwe/5hefDupIVHfWGQcIjyF8e/judBj1f/FBK0Jrj1IODALCex/dD+rUMmMIkxR76lA0zhv0hE5WTVjFIzlk5QQaFGvUn5IdrMJXuE/NjhIQUyq1OGEesMzLNasVG75F24cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=jzD2aYzD5VEgloKfUMtETIhlNN/Bcdsl7KMpjqIReJHSdB6JFjhr41SBbr03W8ScOUSyqxfWYdexnxC6VCTCu1H07O+YhWLAg8rPb6G02dm03hHLGrGAZI9NQIXWW2RCOmFPJq4M7E/q1+MARBCgvMSG5sKXZhjtwCyOvDJAlE8dbZAX6WvcOE1H9KN438t7Ypr3b4G1yi+KudZ0rAhXF3QpIuOuLNI5Xjqaz+B+DtZj0+EYn70NgMk5SanvFF3vL4tAUBYGOSlG60cLIgB5wzv2RohJBoyTrQOMXViIv+AXnxyoao16cZjaTjhtqtopkxCbEYG6FWpggjCzaND9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYbFps5qXNn+oWzzRAP4mjALxQG8PfoBesCUDA978g=;
 b=JdugcenD2fSzzeIlFYZ6znmwlU6QfFu8VxbsYFLafSJR1buqpHrprL5s+bRjZB6NGYJySGxq1IvQNuyoR6bKQ/5p+iORhWbgpaQzhQj43VTuzNkxSwWwTYh4+Cr0o9IipFoRVz40TEaEZb5BRC9ym0MaCAkay6uXugHjKtWSsmQ=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:10 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::c3) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v9 07/14] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Tue, 26 Aug 2025 15:46:39 +0800
Message-ID: <20250826074646.1775241-7-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f77529-b637-4025-7ed5-08dde474c3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wz5gLfzsBuf/TtOjOAVQlsTI6t3DF1uUXjX59V7POEsmUXpXGnin0WpJwH01?=
 =?us-ascii?Q?NvzksXySFxnWYwEB3kmAHbUMYqyT/GO7PhLQ17M9kOAmDWsKvsakgFp2h6OE?=
 =?us-ascii?Q?r1HMbk7UBAM2p/406YPBLc18IekiVTvWGEiLf1oH5MJrGfejdk83004TEbw/?=
 =?us-ascii?Q?s7gILzc5ZgGM49N4rmpXj4AsVQgq9XTAmceEpRYjuvk8SIpg77jUHon9dy14?=
 =?us-ascii?Q?hxQqfk88ThH4paJoGaGnMl33zOwooZW9i2ez02WiXlVCPADk/Eff5ItDL1nC?=
 =?us-ascii?Q?tWtb7GCoc8I9rrSYYYy0T8ZmBRFV8cA5OvU+U4Qg37DzrqbXbv/1f8i6+Tsh?=
 =?us-ascii?Q?3GRhnvhgt0FUX4n4RfdogWA9JwKaV69dldcope6VJmfsrxrvA899VyOFINg5?=
 =?us-ascii?Q?K5Ix4/9iipUOfdeJLkUYHvfK2vtqDvrFcda0Vy+ZLXV6MYo3EdG9CLuHYRAp?=
 =?us-ascii?Q?jZgZBMsmn7gpPyE7IPKHLguJUYYs93RDGAXPBilO4fMms5tI3OtjoXGH44js?=
 =?us-ascii?Q?d9tUZhh3+pStQrCl1iuCW/Dd1on28+AdN6kykomQeBwXLYCjwI9toLrMjjTz?=
 =?us-ascii?Q?gVsKZ4lx4fgmIVZJMOHiw+TsWMuxlns1yjLf3Xwpm1HNOMhsHmvz8Csqa+KH?=
 =?us-ascii?Q?jh7qiX19GDJPCEUFNOaaUBiWpdxzXXSHjQLY5hDoZSMKeEnpvatEU3Q1E1rs?=
 =?us-ascii?Q?/+4seuAjOGw5A+4EswF9AhzIdQZJfB7h+OoFlS0E2MNwT13dYrjaDzmvYfYn?=
 =?us-ascii?Q?nYWZexfswazwWW709rjFBD8UPJLBIcNDs/bvKfrzWOnhouIi9hW4hiWv/FjG?=
 =?us-ascii?Q?PNN6VX9hZtTwQRNJz0OK25RIjUIliIO0FzWhGIiFYsrp1n4WMzEVVyCnmcaa?=
 =?us-ascii?Q?CFsnb7vMp6Jy+8+7BVi4hKSsQt7j0Ib2kBIwttrlbP6zQ10YVAmn3bEMk9k4?=
 =?us-ascii?Q?JMv+3SetUuP2/9TEx71rPAD0irj86caSZbe9sklnneU0M+pnBXxAoN4fcaOl?=
 =?us-ascii?Q?jiR4juw5bMZu63IOeRRWPclP+6UEZmXKxUmK7j62CSEqGVp/vbQFF6V6SoGW?=
 =?us-ascii?Q?yu1mgd0tJ38rqrIDRN8ZucAX3856gcQLKgI0CJg4+OpwcTvLRcF4zsO/QQtc?=
 =?us-ascii?Q?c69GDLmNWvLfqGlzOx5jNiYslPq/eF23yzXV8jrN2z8riK57QXBLlxwPHCsS?=
 =?us-ascii?Q?iYpdILp6lpIQZea1nCcE49XqKIrXU9P5Mp7uj3H7d3ReCq8Y+IUBBvs/3C/Q?=
 =?us-ascii?Q?tHjceuJImBGuneV3LGW91OjR6iFBAwAs6temOjO4cO+wPY5lft6qV2rtuqBf?=
 =?us-ascii?Q?de9uQNIbhaOSTlTavyGlHCCOAtXoYCj3NA5zWJREfwy/VgTu3guOyyfB+LAT?=
 =?us-ascii?Q?orDSclGaeHslGeITVYpHM9oQ6ER5hZVRtAGj5XkREr/PoZyYlmBX14a/GoeQ?=
 =?us-ascii?Q?ZYO5wk016mDX9+edd4FklUTcFYYyI5GzfQfy/MaNmzGf2+IzcFTjBkOkpaje?=
 =?us-ascii?Q?05+HWan1nCxFNyG7/FNBT72AQUAlItGwZUBe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:10.7147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f77529-b637-4025-7ed5-08dde474c3ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

