Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD8C7EE30
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAF410E344;
	Mon, 23 Jun 2025 09:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EUwb/s0a";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA8F10E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFo8Md1LvYI5yLawPtxYgHz8w/LUQNv/XrXV5z/CVOEyWycfYBZEiGAsZN45D20gcX1cuiB1zwVcQZ2uXxfjRQAAS3vH+lNwqrNJbJcV9/GgGplD9goFYwlN/cntOo7I6dtH028CB/61NfbZcPNMdBYW6n5A7bj6X9epPnPVz3QNBj2m9h5Dze+7IN9A8i6Zu41+pIbYPm+yjritRKFjzDGmAjsnyPA7/aKaT60KLVFx9/08JAHKUZlxtgqkDtL0VO0xUVm6uD2ZHfSp5SO6NxuCH9bZASLf5v61eQCdgOrx2sY9BnEfY1sIWOzAVELPTDBTj/VzBOH73jfifTYexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhqSYTX8AM7UcQ4dRmvHCs5s7RkTDAab1ezXlSBH1FM=;
 b=YIGBDlrc5+c6c9cDMKhtppTwvDDXQp2ZTDTmBFzNqSc1dtOEmbratt08Gujp7zNTvah5ZIg4vY2VTJmlqgcjBi9QpRIh3XAH686YLvJB/T6DgYS4wYL+l2HgM3saEF43onjSWmVF7xCdgWMt+FPY6TyCwMsFdDGJVbWlWtzhcZqT3pGkoMWCMPeLBQ1TJ7eIoZ1nQSHWxQ7zGV1ZvN4sl0DCUmhHwqopR2PsxyYpyXPXkkJZz9ieUiKG6U2fWCNAO8Yvqqg6dY6rvdYhM3P/YNkK118B4BCXNiTG+iGBoXHqFH93Cz1v/v8/+FYDs5+7vEvsDITlh423ZleLzz285g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhqSYTX8AM7UcQ4dRmvHCs5s7RkTDAab1ezXlSBH1FM=;
 b=EUwb/s0aefN5QvXTGFqBFER5Ayc5T0avZfv1oHwZwATC/GiQb7FgWexoMuyxy1NRbTP6w9Ihiz1/T0cE6cVadyxhNj64lKsWTE4jStyY3mXzwQb/GYpdebFDmkAfs+/R6WwNVhA94mgWnaATW2gn0P8+YjYjzpqKqB183WIguXI=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 09:52:11 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::e2) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 09:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 04/11] drm/amdgpu: validate userq buffer virtual address
 and size
Date: Mon, 23 Jun 2025 17:51:47 +0800
Message-ID: <20250623095154.1150830-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b77c4aa-dc15-4f8a-98bf-08ddb23b9fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DAR++jFfWDHqf5B03NclIww25CdIf6GO9+qsfDOpN9likgCP+3dqWxChnH14?=
 =?us-ascii?Q?McpDWrOZaJoF7WGTYAw0RkUa9gZLv5zeMbCDsl0qRtbck0Lw414915J8Z3d6?=
 =?us-ascii?Q?W/uTeBeQ4kt5/rmkfBr5Q64ZtNkvCUPeOPzRQJ2e3yAaUU0MFEe47Q3VJ7Og?=
 =?us-ascii?Q?RgbVUlJkkH2bbmSGTz6r9fsDjguMaEmSNqh50ROJvxCkO17lb0wjc23hA8RF?=
 =?us-ascii?Q?RhEB5R365XGZLEAV6rwrxqf+ybgwWgAMlkSnuIiIjuv/7KGar5FxllBEo8Ix?=
 =?us-ascii?Q?gkm3c4HCNyfzQ6KPgmc1USl58GPyRZ22DMHvfoL4prSnRjD/F//vdzJeC41A?=
 =?us-ascii?Q?ryKgvw7jFZ2fFkw8QEW4FiLkjkmJwOyXVNozA7HjZ88sbMI5dv4j7tqpufAy?=
 =?us-ascii?Q?V5DmadE6yofLl35+jQd/jaJApjrdGa8U17JCQJ1JnZLIJSF9NiV3DyC0de+r?=
 =?us-ascii?Q?q6mTk7v3Ku3Aiv81eSRDP6E6CCB8bRmayLrrUTpMiotYXiuSJ81uVe8D3E2P?=
 =?us-ascii?Q?Cr5euUp7XfVBH0nUTz22kLzitehnMrD4l0AmvwBV5O/Jyn3XMQsnjIAgNiRj?=
 =?us-ascii?Q?sFJqruDIphj4rDTo7+I48JPKDlH6YfK6ndtPANdAnal0eeJdNZ+2v+tvpLQ4?=
 =?us-ascii?Q?aBwx8oFAYuVGjaouDmiZGf3v8lp0IIJiiACBrW4TRvbCJE5gyE9UVM2JSOYb?=
 =?us-ascii?Q?b93LCtvR0QJZ/0zgjGA8mKfNoJlV3PeIc0j5EIhKKerD2sGgHP8rJwCBiHyP?=
 =?us-ascii?Q?SWgN2BOjjsqFsHMMlgf7vztfMFX185GOPa44krTbojowbKr0rMh71XKdYbuO?=
 =?us-ascii?Q?utzCoSIsDaXOGLfqArCzntvY4E+Obcj0ZexGGs3StzJUk/9sUXUwIuQeShgK?=
 =?us-ascii?Q?gwWqE8vf4tc7+GZmIa4dGL86oXhmSIXpnWgBqdgg7MSwhrqblYq1OaVduO6q?=
 =?us-ascii?Q?/7oGEhrGcdcyXBzt7Qs95oHYfdkTA0w+3U1TKWkp8PAxkZ4e/0Qn72p2AacV?=
 =?us-ascii?Q?YG77JbSz6nFDrVQmMu0yawmJXoimepDTHwg8XeWwN/Bwc4ueEY1P0Cp3Z8qM?=
 =?us-ascii?Q?K5yIklxuQ3L8UqyF1lhZZvWqDphAdJdhWX+p/L+3BAC21PX3R4+vVNY43+qG?=
 =?us-ascii?Q?RfxSRaLRvIDAzP5yAbf0FNAQUPvmKmrCtXURDWcYSPR/SC/3EWIiYOb3BiiE?=
 =?us-ascii?Q?RimOrvgFhCdkjj5Jhp0u9zYg4Ckiuoa08quwuBpkn2P84TmdAsQSJXSz1bup?=
 =?us-ascii?Q?RHZ7UgKq3cjMajKRzx3VzA6JmQ9lHezMl8hbbzmD4odvXt2iXbWpww1chwL6?=
 =?us-ascii?Q?B01micDs8JL6ABUN7ivGvs/nAtFDw5TcAPiJn2m13HCpM+S7dyASzsH+r4si?=
 =?us-ascii?Q?Frkf7hP14mODhWnw99dPuLyo5WQ93tMuiSbEkFaDKrzrha2g39NSgskNvJ+n?=
 =?us-ascii?Q?VR9LBw2rz0sdw5aQVPZborAT3TsafyMLycjGp4/SkrDTJs6Q18Tv+tkUE81M?=
 =?us-ascii?Q?RPEpREXrhOqoBkdqAnKWUqSYggNEbUpy8F8q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:11.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b77c4aa-dc15-4f8a-98bf-08ddb23b9fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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

It needs to validate the userq object virtual address whether
it is validated in vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 +++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index acaea4416ed2..a20f7ccbe98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -31,6 +31,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 
+#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
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
+	user_addr = amdgpu_userq_va_align(addr);
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
@@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			return -EINVAL;
 		}
 
+		/* As the queue_va and wptr_va etc are the useq cpu access address and they
+		 * are also come from the user space IOCTL request, so they may need a access_ok()
+		 * check before trying accessing them.
+		 */
 		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
 		    args->in.queue_va == 0 ||
 		    args->in.queue_size == 0) {
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
index dbacdfcb6f7b..32bb9c2689cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
+	struct amdgpu_gfx_shadow_info *shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -231,6 +232,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
+	if (adev->gfx.funcs->get_gfx_shadow_info)
+		amdgpu_gfx_get_gfx_shadow_info(adev, shadow_info);
+
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -247,6 +251,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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
@@ -274,6 +285,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info->shadow_size)) {
+			drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -291,6 +310,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info->csa_size)) {
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

