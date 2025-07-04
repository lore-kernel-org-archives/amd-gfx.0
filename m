Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D4AC83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778F710E9F2;
	Fri,  4 Jul 2025 10:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vm3LNMEH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3752910E9F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+g8TKKh5L+YqM6pe2Y+uuTiU53w29KXKW4oczeCCnJz9dqqVrPW5u0sJC3VSl4/iSnTbIBeKNQdQfR844d6A9Z/uRUqr7j1vHks1kM9fPknmz7Gmab+Fn4xQa1gDTzsi7SW4Or4RNvKl6Ah8ngEr7qBP9zRKqxzbJ5Kt5slJhsKmsO6WkNoLM/aQsKFTpK5rO6CF1j0vJycwKJfe7JacNAgYZYevbXv+YJVD291bDslosV0vo4fpJe0kd1KZ8AsgH2Rsjs7My8DVts1cpnhP2VVhZidwGHwyg0fayvdvAyHhHe+xRklXHdeyciTmDbrCWlClK2Ux6sUjxoE3UMwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWS/yMzWHrIPu6g4CcxkHfxXYWLALr7YBNF0C534kVY=;
 b=s9+FIgL5gnqvsp7kBGscCncTZxefcIX7OB38ADITzgacEQELAzRQk3tEvc6pT2xaOg7Zk4B+2AKWNIz0FS7pshaEcg+BgXdR37ruN20muz7PqykLuJ45gdp/BAHUqXQt8qop+Eq97xzXjl6fFA+kULzpS6uD03U2LKqC+HGOrl9gvoQmaOsCWg6SWZ8T3XvfjDmxedDi2x5Q4fdmOsOQN2hQgXDkx3LcVGjz/BsTRebi95Qw9mDpBudDrtlUyguJclpASrKQN96CkGQOeqt/vJQTY6XFq89oLxc9QoGM0y6vJq3hSPBE3qpVZ512le3w4ZE9B5tFxu4VyY/5uOBE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWS/yMzWHrIPu6g4CcxkHfxXYWLALr7YBNF0C534kVY=;
 b=vm3LNMEH0h1O8vFGWRTWgj13cK5bLNUvhDH3vN5CqefWVIjxreF1Hz+nA7kD+VEXG5pQQCcx9MYs7S6aiyjdMp+cudtsy0xQ5pLuiWhRFzCx6YV/AXgJdsXQCOAcXbOjqbL5+6GEilqy1GPsBmJ90P+1vJhqJeo87oGD/LFX9bU=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Fri, 4 Jul
 2025 10:33:25 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::db) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 10:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:23 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 4/9] drm/amdgpu: validate userq buffer virtual address and
 size
Date: Fri, 4 Jul 2025 18:33:03 +0800
Message-ID: <20250704103308.1325059-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: d31014f9-bafc-4cac-9add-08ddbae63518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vf/tpYtnzGC8UyZSCmBfiCQy+96zADS/9SFYmMvxa34tCKiXMHy/HIrmEIOX?=
 =?us-ascii?Q?sqPtguKXPBPpcPFJo7U5VAtTbZteT46Pq5EJImIM6qoRdPCFg1WTg2nqRw44?=
 =?us-ascii?Q?lM/UyEKKV/AXtesAAMqs+uwNVxj+UqEBkwQzu1r22a7NUf1Ct7LBR6KhcF4e?=
 =?us-ascii?Q?7ZaSgTKLuP1cP3y5WFRSrPHWApVDyeZ2JPxNvmabBjM9ZefQJJPBImicjVra?=
 =?us-ascii?Q?ncETo0c5Elm3gMY89PwsLRuS34cHhOv2KTmI4VOHYv1QKPOJcHY6MhYH7lId?=
 =?us-ascii?Q?QBndhiQOVXxVQ2h26j9tgpfRFWdHQS153wzO3VKgw7f7es7CuaiqufqwuYbX?=
 =?us-ascii?Q?qH5NfIlOEJOcKABIp0J69fle6b1mrSjNWJF8U6EzqPFHego6lRYxejk8A2rq?=
 =?us-ascii?Q?NaIQo3r0Yba+Q26mKbCB8PYx8pXiThEcoiHnZLKmAWj30SpsJKxfW6yBiYVp?=
 =?us-ascii?Q?sVKIlIZQ8NQBjXUlOrrYTrxdzUpmdPB47H/enlku2m2l9LmYIz2yrAbo3R+d?=
 =?us-ascii?Q?Z6iNRviPUA/nsrnVAx91UyFkNEy3u4zKQkzs3Klvcn1kJnwg62Kxq8l3Kw1v?=
 =?us-ascii?Q?kiNXL8IE9fnA//0dixJwOXZhBZz7wBqukj1WAnci5Iq+G6MACTSFvRgjVSiC?=
 =?us-ascii?Q?LGVpHHkMvAMjYc0D/5Us2Rdjfq1Bc69VitZhYfD2egkTM9bpqxnxmlC0+/id?=
 =?us-ascii?Q?A5H6YvJH73IEEOmC6sP6Os9UfNzjAvKOiz5TeFwEWmiPhBEals4/aUtYeRqU?=
 =?us-ascii?Q?Vw8P/NR+zf0vDjtWXUH5wOEKg0DRHHl7vT6xkbK1f9LSPInWV1nkZsxrA8C4?=
 =?us-ascii?Q?L2EtwxAIS0yOByXuFlkd0P73ibyZtLQABdiVVpgihMfZDeDNm4eXfMh/+hVU?=
 =?us-ascii?Q?yljvMWNsS+odKUuQb9sCeNWFDssAX5QDUSJwpT0DzySpfmR1M3FJjwGODY1O?=
 =?us-ascii?Q?nHbYuK0J4Keq7yksQPWRyBHotZW1sMuiwRoTzfD5qMF15V8dx2zzYfqKQI1u?=
 =?us-ascii?Q?bfpi0AtYm4bL6gZMHnagyzYnomu8otnaVazv8wtV+3ybdnRPn9r2moOp/uxB?=
 =?us-ascii?Q?GdMiBXNLefv//0mKc7s9DOS9l67382CDLiKHQj5xDF8FzUJ5nLGHIX3cW6fn?=
 =?us-ascii?Q?xO4B1MNwC23WodEiR1Ht29M8CMzxwFyzeaeIbqNabBXza8bphx6JQtvxjzYI?=
 =?us-ascii?Q?IaY+zmtsNnXMEm36Gv3Ke5ccL8tCP0OE48mQkMA2Qem8xm2sFbs+DDpM9YCH?=
 =?us-ascii?Q?fhNej++KLwJX1AVzRYC+fQF3zNSrVyzM8jPv1WgW0OQ+TeR4y+Bnwya3s/8Z?=
 =?us-ascii?Q?yN4EO1JSf6Lun5x8LzRPs/fk4trPfsXaXygKG9kw5LsfFHj3QfrDt5G8Vxyi?=
 =?us-ascii?Q?KMeRPZC53a8/77tHwfAMeUnQGNXIrCygduQXnJ0+lrkRCGLPhuwKGTOweirc?=
 =?us-ascii?Q?kHgtnxOJvj0ve7vQSg1MS54XHyf+PR1RvUsjArMv7mQ3jfQYsxfne3sYeBZB?=
 =?us-ascii?Q?Q3Gu8ToAYClyPoOHuWYxIXycbBV0uTzjxCAU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:25.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31014f9-bafc-4cac-9add-08ddbae63518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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
index f1c41b1114d0..f48e53d99e8e 100644
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
@@ -391,6 +421,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
index dbacdfcb6f7b..4615d3fba530 100644
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

