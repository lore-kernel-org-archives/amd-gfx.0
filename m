Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2BDD3B9AE
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044BA10E63B;
	Tue,  9 Dec 2025 23:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f9CIEggB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1029C10E627
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKB13KYGviyD2OzS2r4L/Khr56E1UsyQC1T8EyUQSsXNPZltU1ne+B206FEvrhpNOHTJT5VIu9j6egjmmwNfuAQE41YXTSmpGD+eBaDInXKcZ1D9qOcaryhu0uW8Zrx+WFJoZ1b8NCozCCvWu4P/41pjSElYvFM6yldzo//0QBsqry7gKYxYSKY6AQdaUu8ilizbD1SdR+J5IntiTs2VKsF7Je/THNfqVn5FxUzOChUSGOfAPXGBjx2uuzNI7cuPZG06zn6ct2cWp84aRi9ND/5jPcWGLyLClDBZu5Zj4I0CpV/rX9piMJSw59sUJ1Y8vKm/QYH/k445p8/3z9adzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eQrRoU2mAYo7aOTC6QB8rp5MOqpAfUKXOuvO7qrO98=;
 b=tVHzwFNWhZ8LTpBsPEqhLExS/43DU3AFTwwVnrdj8XgzNBodd87IxKHaFm44ppHUXC/yPGDV+CyJgwFiOpbOD/oDlBFYLULOekJBtwzAQwc1AUGSvDpnMC1k8IETMvYYUzKc61u/YNzywdbYj8NqWuF8kYiGSD9KJzJrNrV27AeQvC4d9LnkYjdc1X4kYCmNN4DIg+9wXnEtPJLanmmvlG6UALfeLFDRnUp/g9K7m8NpzsoFgYPOOqNOkfaqXt3UbpxXSfV6QQ2fWPrc5+RI/SmHH8DgkMyA2+L73SHtg/p5ha2bOfUTiPLGYM0LaapE3azLxNJO9MNinPg/jaL9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eQrRoU2mAYo7aOTC6QB8rp5MOqpAfUKXOuvO7qrO98=;
 b=f9CIEggBGxiD92RSi+sRhofICNVrYoC3150Xo7b/Joo8vj8KiD1V6NO+PWY6FUtdE3LB+ubDD/dUYriCy0UQ8JHmfq0MmhIPqI6S1AnrQ76lOH+rCtwqLAL2dw/gUgEBULS7BRG0iGgPfsUDbBnnmmPsNorqxe/h19jaQAclWBs=
Received: from DS7PR03CA0186.namprd03.prod.outlook.com (2603:10b6:5:3b6::11)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 23:44:04 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::c4) by DS7PR03CA0186.outlook.office365.com
 (2603:10b6:5:3b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:04 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:03 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 3/6] drm/amdkfd: Add domain parameter to alloc kernel BO
Date: Tue, 9 Dec 2025 18:43:25 -0500
Message-ID: <20251209234328.625670-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: c50c3b5c-77ed-4979-65a8-08de377cd63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Wx6RG9+GRMN3IQfhNw4gUaBLAR7eTAxGuXYdbProyyRUW26X2t4yEqwsipZ?=
 =?us-ascii?Q?+71OZu7rT4uCdhbHwH49x6J4CmexeUjFsyjrtOfhxTM8MjOzt63yHY53aZVY?=
 =?us-ascii?Q?aIILdlOlcwIz3114Eg0YZCQXKgydqr0jSF5pgYcc8CId7ggL6/IXajcVluEy?=
 =?us-ascii?Q?RBuzKGniu4kq22QI+bLrfN5879cILW3akjfo0YaFUmRLOokJ5172NDCtz8yp?=
 =?us-ascii?Q?IZukXFcY8tJo4DBKJchtfKM/pi53noAZLzxk1XT/DSQCMNYc5ZTlSx25qXWH?=
 =?us-ascii?Q?cZxw9mkZ9uNkG22eixvxHHax5v1y62LoLT+1uQ3oOtvFp2UzajCZAlvfXwvs?=
 =?us-ascii?Q?Z7DDXpagUD3UEmK6N/qrJU+ixT2RbKlg6MAJCdfAy1fSfG12JyqFtgy21u0+?=
 =?us-ascii?Q?CyaDOjUGVtJUk0YklNRish5lFB9/6uwiwAHZnMqsaz+oGZVFVVZe2OMnflPD?=
 =?us-ascii?Q?W9Ypi++I+C6pb56CEExJJc7Bp+2E1QupXx+ehW4Qye7AWwMef26mHwstUN4i?=
 =?us-ascii?Q?nZLRXqj7wQBwR8pgslA1nGJLgKXLlpuJl2dkUqsAMil2OPXZHIFFJ9Z9lJ3O?=
 =?us-ascii?Q?vOrmdRRG1qNIVawyHmWlHNEXxRUufIZwYA/kFUCq7A/5+0fC37egTCR0vT1u?=
 =?us-ascii?Q?kSmuqa+UxrR0reG8sH5NXIktdFNJzqRHR8ButlhTLiY1VyPsb4CYnv2Q89G5?=
 =?us-ascii?Q?fuChRt8jcy9dnIfSkYYw0P6E7EnrJ3l+FqnCFH885gGAPx8CfwnaBIRYrv7D?=
 =?us-ascii?Q?muoAMUvNHGIkG3g6+Rp26pcM4BtNiAtZup2abFIuHNLsatUBb+NQl69AmOK2?=
 =?us-ascii?Q?1A03p6hf4+ld6wPnfu5O+iv+BlDQbbSDaNFQ0qcRwpJYKMp8JdVnJOOl1jTo?=
 =?us-ascii?Q?70H99NRJs9TFteRB3+Q0ztawjr7A8esb4u1scdRwKAyYIx+ls2pDiAo5zKt5?=
 =?us-ascii?Q?E3BU59BdsAUoOwossQ1rbMcxHROq9m67XFqf4j/RWXFbeM1PG7Nlx0MaKC2i?=
 =?us-ascii?Q?Ryyux82T5FzoldD1M7WEksxuStDJDuTa+oq8jXlZ0mgoy2IY1FKagPXWuIVy?=
 =?us-ascii?Q?A3OmWYsAlAB91C/yzh7KJmrDhkRZq5wdVRPFcAG1xFb2B+GDLcLhJRrD20M/?=
 =?us-ascii?Q?kWJdLa1w2wpBq67AxZ4K5YsW1FoBJkwnLVVVYx1lGWP1Gm+ULgTcU9uEmPfl?=
 =?us-ascii?Q?U/P35Th0AIxwyoP8tI4VKQlhpfAKLpDmrL6/TV25JjCbJ3NCdyfjXUVGwtUB?=
 =?us-ascii?Q?VU8/lvtQse1lX5s6OUA9YLtOzGOMUubBzx710+NqAve5gHU08T7Yb+5Pn0Um?=
 =?us-ascii?Q?YrXlBtI65E5dOod1AHHAzikuOkNOWI9ZV5/LvuLmrd/evDGPbXiwpXbXxawz?=
 =?us-ascii?Q?vXluicLdgqkhrAXPfOgvtGd/x/5yVzzJE1KUnxk/cYip4X9Z003G66/7Zd8x?=
 =?us-ascii?Q?doe+ROP1a1g5fxEIU35bumBPgT9msa5nNN1kcEsu5Y0zbUJ50n78pwiNZcmj?=
 =?us-ascii?Q?3me0dSmX113YBh3zmX2UY7lb3MECxovYghEq/0bUnsOUCkS7TORaRr7ohq0/?=
 =?us-ascii?Q?9F5XLdAsKPmGP6zRQSA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:04.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c3b5c-77ed-4979-65a8-08de377cd63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769
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

To allocate kernel BO from VRAM domain for MQD in the following patch.
No functional change because kernel BO allocate all from GTT domain.

Rename amdgpu_amdkfd_alloc_gtt_mem to amdgpu_amdkfd_alloc_kernel_mem
Rename amdgpu_amdkfd_free_gtt_mem to amdgpu_amdkfd_free_kernel_mem
Rename mem_kfd_mem_obj gtt_mem to mem

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 13 +++++++------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       | 14 +++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  9 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 12 +++++++-----
 12 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8e..090d17911bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -316,8 +316,8 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 					     &adev->kfd.reset_work);
 }
 
-int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
 {
 	struct amdgpu_bo *bo = NULL;
@@ -328,7 +328,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.domain = domain;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
@@ -351,7 +351,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 		goto allocate_mem_reserve_bo_failed;
 	}
 
-	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	r = amdgpu_bo_pin(bo, domain);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
 		goto allocate_mem_pin_bo_failed;
@@ -388,7 +388,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
+void amdgpu_amdkfd_free_kernel_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index da4575676335..274a99eb6d44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -240,10 +240,10 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 }
 #endif
 /* Shared API */
-int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
-				void **mem_obj, uint64_t *gpu_addr,
+int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
+				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
+void amdgpu_amdkfd_free_kernel_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6585b8b9e709..b029a3e218b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2214,7 +2214,7 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
  * @bo_gart: Return bo reference
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
- * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
+ * unmap the BO, call amdgpu_amdkfd_free_kernel_mem.
  */
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba9a09b6589a..63b870918f93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -357,8 +357,9 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 		return 0;
 
 	if (!pdd->proc_ctx_cpu_ptr) {
-		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+		r = amdgpu_amdkfd_alloc_kernel_mem(adev,
 			AMDGPU_MES_PROC_CTX_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
 			&pdd->proc_ctx_bo,
 			&pdd->proc_ctx_gpu_addr,
 			&pdd->proc_ctx_cpu_ptr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index cf640c9d19bf..0f824bd08fe1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -808,12 +808,13 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	/* add another 512KB for all other allocations on gart (HPD, fences) */
 	size += 512 * 1024;
 
-	if (amdgpu_amdkfd_alloc_gtt_mem(
-			kfd->adev, size, &kfd->gtt_mem,
+	if (amdgpu_amdkfd_alloc_kernel_mem(
+			kfd->adev, size, AMDGPU_GEM_DOMAIN_GTT,
+			&kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
-		goto alloc_gtt_mem_failure;
+		goto alloc_kernel_mem_failure;
 	}
 
 	dev_info(kfd_device, "Allocated %d bytes on gart\n", size);
@@ -937,8 +938,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
-alloc_gtt_mem_failure:
+	amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
+alloc_kernel_mem_failure:
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
 		kfd->adev->pdev->vendor, kfd->adev->pdev->device);
@@ -955,7 +956,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
+		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 39800280543c..4ab51ae64724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2905,8 +2905,9 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 		(dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
 		NUM_XCC(dqm->dev->xcc_mask));
 
-	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
-		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
+	retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev, size,
+		AMDGPU_GEM_DOMAIN_GTT,
+		&(mem_obj->mem), &(mem_obj->gpu_addr),
 		(void *)&(mem_obj->cpu_ptr), false);
 
 	return retval;
@@ -3047,7 +3048,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d9ae854b6908..f78b249e1a41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -54,7 +54,7 @@ struct kfd_mem_obj *allocate_hiq_mqd(struct kfd_node *dev, struct queue_properti
 	if (!mqd_mem_obj)
 		return NULL;
 
-	mqd_mem_obj->gtt_mem = dev->dqm->hiq_sdma_mqd.gtt_mem;
+	mqd_mem_obj->mem = dev->dqm->hiq_sdma_mqd.mem;
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr;
 	mqd_mem_obj->cpu_ptr = dev->dqm->hiq_sdma_mqd.cpu_ptr;
 
@@ -79,7 +79,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size *
 		  NUM_XCC(dev->xcc_mask);
 
-	mqd_mem_obj->gtt_mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.gtt_mem
+	mqd_mem_obj->mem = (void *)((uint64_t)dev->dqm->hiq_sdma_mqd.mem
 				+ offset);
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr + offset;
 	mqd_mem_obj->cpu_ptr = (uint32_t *)((uint64_t)
@@ -91,7 +91,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_node *dev,
 void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
 			struct kfd_mem_obj *mqd_mem_obj)
 {
-	WARN_ON(!mqd_mem_obj->gtt_mem);
+	WARN_ON(!mqd_mem_obj->mem);
 	kfree(mqd_mem_obj);
 }
 
@@ -224,8 +224,8 @@ int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
 void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
-	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
+	if (mqd_mem_obj->mem) {
+		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
@@ -280,8 +280,8 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
 
 	offset = kfd_hiq_mqd_stride(dev) * virtual_xcc_id;
 
-	mqd_mem_obj->gtt_mem = (virtual_xcc_id == 0) ?
-			dev->dqm->hiq_sdma_mqd.gtt_mem : NULL;
+	mqd_mem_obj->mem = (virtual_xcc_id == 0) ?
+			dev->dqm->hiq_sdma_mqd.mem : NULL;
 	mqd_mem_obj->gpu_addr = dev->dqm->hiq_sdma_mqd.gpu_addr + offset;
 	mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)
 				dev->dqm->hiq_sdma_mqd.cpu_ptr + offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 06ecc86fcb4c..22f51df6f174 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -370,8 +370,8 @@ static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
 {
-	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
-					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->mem = (offset == 0) ?
+					mqd_mem_obj->mem : NULL;
 	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
 	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
 						+ offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 2e9b6bcf2704..d234db138182 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -135,11 +135,12 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
 		if (!mqd_mem_obj)
 			return NULL;
-		retval = amdgpu_amdkfd_alloc_gtt_mem(node->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(node->adev,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			&(mqd_mem_obj->gtt_mem),
+			AMDGPU_GEM_DOMAIN_GTT,
+			&(mqd_mem_obj->mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
 
@@ -665,8 +666,8 @@ static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
 {
-	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
-					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->mem = (offset == 0) ?
+					mqd_mem_obj->mem : NULL;
 	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
 	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
 						+ offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 12f640a9370a..29419b3249cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -251,7 +251,7 @@ struct kfd_mem_obj {
 	uint32_t range_end;
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
-	void *gtt_mem;
+	void *mem;
 };
 
 struct kfd_vmid_info {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aec7522407db..b3d7c545f7b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1131,7 +1131,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->kfd->shared_resources.enable_mes &&
 			pdd->proc_ctx_cpu_ptr)
-			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
+			amdgpu_amdkfd_free_kernel_mem(pdd->dev->adev,
 						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5f8cda4733f9..232103742712 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -209,8 +209,8 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
+		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
+		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart);
 	}
 }
 
@@ -264,8 +264,9 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	(*q)->process = pqm->process;
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
+						AMDGPU_GEM_DOMAIN_GTT,
 						&(*q)->gang_ctx_bo,
 						&(*q)->gang_ctx_gpu_addr,
 						&(*q)->gang_ctx_cpu_ptr,
@@ -297,7 +298,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	return 0;
 
 free_gang_ctx_bo:
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &(*q)->gang_ctx_bo);
+	amdgpu_amdkfd_free_kernel_mem(dev->adev, &(*q)->gang_ctx_bo);
 cleanup:
 	uninit_queue(*q);
 	*q = NULL;
@@ -367,8 +368,9 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 
 	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
 	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
+		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						     AMDGPU_MES_PROC_CTX_SIZE,
+						     AMDGPU_GEM_DOMAIN_GTT,
 						     &pdd->proc_ctx_bo,
 						     &pdd->proc_ctx_gpu_addr,
 						     &pdd->proc_ctx_cpu_ptr,
-- 
2.50.1

