Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B05D29F9D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 06:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA7A10E041;
	Wed,  6 Nov 2024 06:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HSus1tVM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F6010E041
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 06:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiIIKtlnELrnDHgxf62dTF1F2uD8UMr20Jjj2/7JFJ5sLZQV5T2Ce5HUYngBWpYiZwj8lOkzQzEWkupO+Hs6Cm8FjnB8+3HrS6qwrnd321MUqnKW4bzV7JD8JTPtIa1AXL45W6A4NN+ELn8wHtk6/Cf1Ifj3OMPorFG7A5dvA/e/L/bm6SJXyBkBwAvRUk53xXxfEdju1jrcJrES6+SWFs4fWYJvuuzX9/KPQLaG8UhjVbOvuVG9x7zZPr9Hx4ysQD7jXLB/Xrb38jbU1TR1cElGIiZyKPfJHAd8W2GHII+Wrz6DtsIfmbBaOjDAQBGHBazgasec3R7D9JqfOvoQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMfh7BvDrIB6YX1c5LAkrGus0FdUCCrScfs+Y+94so8=;
 b=IlQlt4iF+Cwv2Y7uvHp/hZn6R9eWeLs5eqneHHEaIUNb5kktRM2jYTlJz4SUZJvJu0udoOXZSIb6mKv0GMkjXDdr+nm9klkSV38p8x4LJ178h9SmSCZi5CIJ1sMgW9jeJvoINrcT6HkEKq4jgYuJH+j+hibeoywF1A0RB49wZivBaUzkyWg2oaVkCfWKoF66KhwJGkjf4972ojvoymQBEpso2ILmLB87GYy5QYsZ5Dt/YphltQ6KCGlGQyrf1teTApxVp7Nx2mB1844xREjKzoG5dYl0qvJeeA3OwVzQdXMomZWxL/PCE4PbMs7NS2ZZ7MVv5f8nL/KkCM4vG9BD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMfh7BvDrIB6YX1c5LAkrGus0FdUCCrScfs+Y+94so8=;
 b=HSus1tVMiaHUnXmFEMgOeBM4r+1Ry2ZjW03dBTupQJaKWYM2ThNdwxLm+zzc3sC6YrrTlhVyS5bp+2Gp4R7oIC9VOWuapfEPENZ8l1gARdDv6OBpbOo33zKVrno2jDyWpuWxAH/WS9x1SLMKMpANcdu7vJ15cczOm0wIOjtx+nc=
Received: from MN2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:208:120::19)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 06:36:55 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::d6) by MN2PR10CA0006.outlook.office365.com
 (2603:10b6:208:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Wed, 6 Nov 2024 06:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 06:36:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:35:30 -0600
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 6 Nov 2024 00:34:45 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>,
 <felix.kuehling@amd.com>, Gang Ba <gaba@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: allow function to allocate normal GTT memory
Date: Wed, 6 Nov 2024 14:33:21 +0800
Message-ID: <20241106063322.2443403-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 65aa9d0a-d86c-4f42-9b57-08dcfe2d67e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6NijAU4rTeSodq3h2+tak/qr4eCEz95812xQg0MI8PIWQ1GR0RI2guoVf1cG?=
 =?us-ascii?Q?7s+3IXVZ7hG3cHZln1hepFQUr/sg0La5I64luduLY//3NTQrC2IaD1Ngd+Gr?=
 =?us-ascii?Q?dPxH/UhtARH6s/cXViFPHGdLtRIVHr6il1p9dO7TxKBareNdwS7jgpICxDly?=
 =?us-ascii?Q?8CSPtLiCEJtbrcMFp1WClx7qbgyP4lJAY/28LkBBN6ygGk/nDZsZSHuEwYry?=
 =?us-ascii?Q?3/+nvHdKYdMNXLbkF3LkR6jo1JAWilU76/Os2BPa17Ue0Sz6fWgZttFdjf/C?=
 =?us-ascii?Q?p/Z0cWo8HD6uAZSzutxxIjViJS7oiIAm7uoNrdzk8mVqcmRs0no8RYWpN1pk?=
 =?us-ascii?Q?y2B9fflu7U1CT/jACgJBcmF0FECAGozEI1vmpR+N2SVECm81kxZFdtzJf5gv?=
 =?us-ascii?Q?vD2jg0c91p+/o9cbGuTwBZuyAxm72mIyiUo+0rqWn2ukcrTxQneg3H5vn+/x?=
 =?us-ascii?Q?TsRSGYsEHIKqT+wW5HTscJsxxIJUpc9Jn+W9ZKSN9jvdh8G2+I9O8yp4YmhE?=
 =?us-ascii?Q?cZYPvnpRa6iOvDOZs0fV6jJ5WWJF5JCP87YxavF6gLSOZpZX+jMLKWtLANHK?=
 =?us-ascii?Q?aAb85Vp02egUcTUrrJmKGDG/o53j/myg9VXrqJ8MlhIcWS3LFXqKMYjXQZE8?=
 =?us-ascii?Q?zWMRKA/yli8AjpKopbn2/f8eKDExG8fWxztzCPqiub4QTmqNSfyM8FY+5siE?=
 =?us-ascii?Q?rpkxK6duwkD3kw4X+CskjPwVrACiMU8wO5mzn3VPeagDfW1HHrnPxOg1eLRh?=
 =?us-ascii?Q?weOheGRPASmmg1WIeOgBpYhZYvXNbv5GOMW4tunFiB0E2zTFD0UBUVdh0FQ1?=
 =?us-ascii?Q?9EdYEvggvPFYWzfLnJyoJJD2KsBGE8CvhAriN42ivy/nAqRuf2s+LutzENeu?=
 =?us-ascii?Q?ITasXOi/8NUZVClfoMRFYqISKuXnhrpJDzZZTEsSNdm7tIjHnmJWiviDtQtV?=
 =?us-ascii?Q?zlstOjwXuRHK/UJMtiqk5aPPuHBQ9Ho6ChdZF0eRBIRdvQUBYP5AhFkxnLLz?=
 =?us-ascii?Q?fpyioWcqtoNxMtSs8QvQz4sglSn4QgQxa6MjN0/3fnHwnyGg5qQGtoeNMq7I?=
 =?us-ascii?Q?tRjkhwdGXOcMXzlORE1zk2mSsqCadwxJmno7YJhQL+bfwMaYPdCW+2yVuXJU?=
 =?us-ascii?Q?D7vwMUgTPoKJYgCP6NKSQdGOdG3vGpuiDfqjQ6LCiv40nHvp5IHumHDol5NS?=
 =?us-ascii?Q?HXc2rvAyGo5OcP9A1sBfqrOrTWefSKJJjcegBIiJduSuHkEUFDQl4qgkFqFa?=
 =?us-ascii?Q?gLxd7wYYVNdVleKtflxwAi1y0eHf1dbMMx1Fi1P0wWjKU/6NXd+IdRdCDeOd?=
 =?us-ascii?Q?AJe5sjMxAYt3X+nZLFukNm9AgdlnB4WKy+IYlT/HV+OJUUEbWdCHu6hQ2MiV?=
 =?us-ascii?Q?JpjXJtSXq3Xe5ZjJAN5JCh8QV/0DR60fHVtSMEFBvISUBuLjWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 06:36:54.9358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65aa9d0a-d86c-4f42-9b57-08dcfe2d67e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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

From: Gang Ba <gaba@amd.com>

amdgpu_amdkfd_alloc_gtt_mem currently allocates USWC memory.
It uses write-combining for CPU access, which is slow for reading.
Add a new parameter to amdgpu_amdkfd_alloc_gtt_mem to allocate
normal GTT memory.

Signed-off-by: Gang Ba <gaba@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c             | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 713be49540d4..acb762855c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -294,7 +294,7 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
-				void **cpu_ptr, bool cp_mqd_gfx9)
+				void **cpu_ptr, bool cp_mqd_gfx9, bool is_uswc_mode)
 {
 	struct amdgpu_bo *bo = NULL;
 	struct amdgpu_bo_param bp;
@@ -305,7 +305,10 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	if (is_uswc_mode)
+		bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	else
+		bp.flags = 0;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4b80ad860639..745121e0dd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -234,7 +234,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
-				void **cpu_ptr, bool mqd_gfx9);
+				void **cpu_ptr, bool mqd_gfx9, bool is_uswc_mode);
 void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 956198da7859..1f1d79ac5e6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (amdgpu_amdkfd_alloc_gtt_mem(
 			kfd->adev, size, &kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
-			false)) {
+			false, true)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
 		goto alloc_gtt_mem_failure;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 38c19dc8311d..9672542578d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2783,7 +2783,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
-		(void *)&(mem_obj->cpu_ptr), false);
+		(void *)&(mem_obj->cpu_ptr), false, true);
 
 	return retval;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 84e8ea3a8a0c..c9882f1d4419 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -140,7 +140,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			NUM_XCC(node->xcc_mask),
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
-			(void *)&(mqd_mem_obj->cpu_ptr), true);
+			(void *)&(mqd_mem_obj->cpu_ptr), true, true);
 
 		if (retval) {
 			kfree(mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6bab6fc6a35d..e1d8fd11d2b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1639,7 +1639,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 						&pdd->proc_ctx_bo,
 						&pdd->proc_ctx_gpu_addr,
 						&pdd->proc_ctx_cpu_ptr,
-						false);
+						false, true);
 		if (retval) {
 			dev_err(dev->adev->dev,
 				"failed to allocate process context bo\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..3a3be0e19fb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -260,7 +260,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 						&(*q)->gang_ctx_bo,
 						&(*q)->gang_ctx_gpu_addr,
 						&(*q)->gang_ctx_cpu_ptr,
-						false);
+						false, true);
 		if (retval) {
 			pr_err("failed to allocate gang context bo\n");
 			goto cleanup;
-- 
2.34.1

