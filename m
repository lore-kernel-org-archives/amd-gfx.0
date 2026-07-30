Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11170C54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFD510E3B1;
	Thu, 30 Jul 2026 02:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sFwFZVUY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999710E3B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn3nts3PISwy62pY7IloLcwM+MiYCETWWsZYFqHABp9rBPJDVY0f9tF3CFvVNq2M+LfAtLP0VRf+A8QeCzWbv0LBErYMBYn3uu34hipJzCT9S0n2WEWm0JnT8ijFD1bqW4n0m/NZ2DG9cc8Ln7MSeCY6mTQP0p48nKQmcO5dmhB6D+4iXNmPM45BbtGkTm/Ip79KTneNbsYP9Rtsr0nYT0veDq7PlQTOoRnKC02zx6DaS/9/PIBvmTTWCxDClGjU4brOvOSHuIHMxn08DgVaAMeAQbJvz/GsCLwCmvFn093unvr8MbzJZI5YOGErPKzS1K4kGv3hWCkmi7eAZjp6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HGVG8BAkExI/cQvIZQzDyzsWXCiM3IAAtbbBffUfAc=;
 b=fg45g//LqZlfThQukEQToaxu7H6v9PXuNEpe0T16fvkNClnr35zjqx4QRnBWPWm1NRUOs1pK+LD9F1EDG70KJx/I/JO7olXj6fKm++kTOGkwCzYrr/1GCjRZtvAZaNUdnPn4anpcotUJ2OXzqKdRtyA76knTcAaxGkKQ5gTwR0a1vcaeEVYFwo0pgVa9T2ScBD7UAjGDT7+mfLrqvqQsM3GgUfc8bqOpk4ld9dT+AxoYG7rT+LJwUpGmdvF1BasNA1DscCNMBlMpgFqPtlkPY7iUZzlqaxZcntVsIaQd+7PYIkJtq4WNE9VCWm68MS6/z7HQPfDeorDVMBiVvQzZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HGVG8BAkExI/cQvIZQzDyzsWXCiM3IAAtbbBffUfAc=;
 b=sFwFZVUYkUmLVBaLyyhcP7CD87TCdW2UkjTLmyEjAGJGYD+ZMMU40pWOK6mcaIBrvo8pEmXcHpWfV6DJDptMbiXGSDjQ5gwPLZBOw8RmVYUD2+f/PhDcdrNYlL/aMSjRakxq16+LhsjQAAag+wU/rrOF7LoF20uHDgOeVeczE44=
Received: from SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::7)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 02:09:25 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::31) by SJ2P220CA0010.outlook.office365.com
 (2603:10b6:a03:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 02:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 02:09:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:09:22 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: enable rs64mem for kfd queue
Date: Thu, 30 Jul 2026 10:09:11 +0800
Message-ID: <20260730020911.234193-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730020911.234193-1-Prike.Liang@amd.com>
References: <20260730020911.234193-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eecbf5-86e7-4632-8986-08deeddf9431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SyRJI1QOIbC0NmroCEH2ke9jfJ6xgKPfO4qx0oybzf1YFIW6cadEdMoeRscUDCWQ0CEAF+CakEUUdunX6460nU73eTfu4eWl3z0PdiC67zSNVt5v2FxtG2ZbT9sjA7Yz6RtMdT/F6a6na30pHqTRENyNq14u9L4Ib0FiB8BKy6zFbzrhrqtrcHKxaP9L7F8F4Y/IptYB3dJDd7xhVEFm1CzZC0enw7N91zEASRvYfbIkZmcf9v84pB5vvb2RehCYkZ89/RqJqYedzthe1doqz/f3WjAtDmO6fOaMMS3Qr27YvkHWDhpJqKbZn1+t6t/Uvfkr2ZvkMRFAIv9MRMH6QC5jsQR3RwqUurFRZUSyxmpIDb/5moilzM5n/s7Tk3gLI2Ors8J5Wlpb+3eG16fQj0TIYBP0j6Teb11HE4eCl6oJ9Tdgw4yDJf7t2fAvittYVZR04Yfj5nz+MXJRch8WyNgWx25IKq6LtMWoHFdgb0sjcc3jL6PpNrwZB20RgoR8lGVmhaBdgAEm++3BgBZGkypsWIUeN2h9PdYgIH2/Cd2c1AEuK1/SF0TnW2JvXDNyj6nhUNvS/FQr2WhIdLzU/jPcyIjhznqSboZf/RoYe/Lj8DsKfeD0WA7DO2xWO7Id9vXP6eSMlDG7bVDyWYJ4nWK/2Odf6fri+9k06jm+Eazbp2wp0pC3DahugXrAgiRf9JGV/lVCSxQmS9Hgzvzn1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vEEjITwPoLIqadmIjeZ0EEOcCq7Mj4E8AvynBHIoWowWfwmGXfv998DwlToQWwjjZVdUf7nsosJ4rNPKGhhEcG8ydZDqhu1K8cgyHIg94YmIwwYEOOzdRvCn8z2NCA3jbRRSCtNs3F8MUhxe6WKoK9NuPCTYm4t9H2+RfSLyJmWXG704mLm6/4jFNxO65x9Hwj+66qncGcEHzkvuBLAQmc0xX5fCaJbbD9DXXXaVRb0UNoHn32A6BdIbWQMbmJ2fNCMxE+c/krrQwpODoW429dFljwdzuIOBT6JH1L/4PmbghTz1AkWvFI4kg/rqSqwrNAek+gzVgvJQq+g8BE5Y4ET7ClvWXp5u2kPDNbw/xkv/HILprbwh+4t64NPIIhOh/o5+nB8gLGMyp0AFyZoYMR/4KYXe5JC5NYtl2vRdOHOZWcOx3gznE7Mzldd8kTF1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:09:25.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eecbf5-86e7-4632-8986-08deeddf9431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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

Enabled RS64mem for KFD queues by integrating
process and gang context index allocation in
the per KFD device process and queue creation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..ea9d87450eae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -226,8 +226,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	/* MES unit for quantum is 100ns */
 	queue_input.process_quantum = KFD_MES_PROCESS_QUANTUM;  /* Equivalent to 10ms. */
 	queue_input.process_context_addr = pdd->proc_ctx_gpu_addr;
+	queue_input.process_context_array_index = pdd->proc_ctx_array_index;
 	queue_input.gang_quantum = KFD_MES_GANG_QUANTUM; /* Equivalent to 1ms */
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
 	queue_input.inprocess_gang_priority = q->properties.priority;
 	queue_input.gang_global_priority_level =
 					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
@@ -303,6 +305,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
+	queue_input.gang_context_array_index = q->gang_ctx_array_index;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 88191a4c1657..3b89bcc625b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -635,6 +635,7 @@ struct queue {
 	void *gang_ctx_bo;
 	uint64_t gang_ctx_gpu_addr;
 	void *gang_ctx_cpu_ptr;
+	uint32_t gang_ctx_array_index;
 
 	struct amdgpu_bo *wptr_bo_gart;
 };
@@ -871,6 +872,8 @@ struct kfd_process_device {
 	uint64_t proc_ctx_gpu_addr;
 	void *proc_ctx_cpu_ptr;
 
+	uint32_t proc_ctx_array_index;
+
 	/* Tracks queue reset status */
 	bool has_reset_queue;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index eb508fe3ded7..0a7c1900da95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1215,9 +1215,12 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		kfd_free_process_doorbells(pdd->dev->kfd, pdd);
 
 		if (pdd->dev->kfd->shared_resources.enable_mes &&
-			pdd->proc_ctx_cpu_ptr)
+			pdd->proc_ctx_cpu_ptr) {
+			amdgpu_mes_free_proc_ctx_index(&pdd->dev->adev->mes,
+						       pdd->proc_ctx_array_index);
 			amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
 						   &pdd->proc_ctx_bo);
+		}
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8054e4fe0381..72913b5c8338 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,6 +210,7 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gang_ctx_array_index);
 		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
 		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
 	}
@@ -282,6 +283,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
 			goto cleanup;
 		}
 		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
+		/* Bind one MES gang context slot per queue (gang). */
+		amdgpu_mes_alloc_gang_ctx_index(&dev->adev->mes,
+						&(*q)->gang_ctx_array_index);
 
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
@@ -304,6 +308,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
+	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, (*q)->gang_ctx_array_index);
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
@@ -386,6 +391,11 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_allocate_pqn;
 		}
 		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+		/* Bind one MES process context slot to the whole process
+		 * (per device); every queue of this process reuses it.
+		 */
+		amdgpu_mes_alloc_proc_ctx_index(&dev->adev->mes,
+						&pdd->proc_ctx_array_index);
 	}
 
 	pqn = kzalloc_obj(*pqn);
-- 
2.34.1

