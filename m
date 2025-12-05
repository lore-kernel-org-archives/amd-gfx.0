Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C57D374AF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FE510EBD1;
	Fri,  5 Dec 2025 21:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNzFWcsw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AEA10EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLspa7XulM/GTagu1C3Eo2vu8YxfuUlhDzXAJHpKxstI6ysySU26NHpHAROr4QbO7V7hkExA8qWtPX1+ZgJYQT1Ltox8uYpCYhxh9ftwDOGZd6gSAY9ZrI9LVtc7GuIVoeDCxphwLKapL6p+LxAkut8/X9whQe2w7p+xB6ZmX3UpoKyOepABxU4QR8TyhmdlhYPp1s3/yuKlMuV/bFaM639nZ3/jDPwgjRIeWVw7pr8BuWY5ipWj3SDcmhvSOYdhgs54urFhqDtdvszeDOOUmf6ie457YEvpOcyeX2UnGAdmXhJhUq/KRw1mtINLPHStEiWG5qFQ2HtLV8KVC4488A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrNcmWcUq3xCHiXC9L3qC2HnvudyZCylTlXMnydEd5M=;
 b=kCf4BnIFXdhbigc+1IztNNDRzUvnCCY5+Fq3zJl/j1Dc1dK3UF9GIwzHT7S7O1xLiMU6C5CuKk8M2HycVHT+/jxfiIpYayzrxQFdkdZY4Qxgyi3qKnfjJytDqOaDYWbK0prHMJoDHbGuCervretW/0qOOzfqzx/0gtO/PBDgpSXBeKwE55m0zCzQlsHNRXRRMQUwSLmvD2Q21WIdHNRB0/O4ijwEv9VwRNr+R4J0HZEntQur7kzBx48aKFNAhzyL/e3WVyG/yLhjqu/n7rIXZN183hI0/emTSWVFbOvGT2Gg6uD9tzg22KRCW75/IYcYORh6Qzbemeq1RXsIe/BC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrNcmWcUq3xCHiXC9L3qC2HnvudyZCylTlXMnydEd5M=;
 b=rNzFWcswDH/AIr5w06sDhEPZvc43G6SRmb9oEQE2KjZ/Oe05bmqZwcYeyWtEU1//yXjbDp3tW/Epu1ywg6uR7tvni9PGkWTNHVz+PwuP53UXk5Ns7Wltd8sb/Wz62oRjn+BrbTe5MRdtoGQuaNYt/qqpxttkW7VfO73E1NgV8Xw=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Fri, 5 Dec 2025 21:50:10 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::cf) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:50:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:50:09 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH v3 3/5] drm/amdkfd: Add domain parameter to alloc kernel BO
Date: Fri, 5 Dec 2025 16:49:20 -0500
Message-ID: <20251205214922.1095629-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205214922.1095629-1-Philip.Yang@amd.com>
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: beb5b247-8ba6-4cbd-2124-08de34484349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQvzv3IAugw9peTGj98cfq/oHs0FnyKoDe10lCoFYDUv2hTC2ZSbfnbWIjRn?=
 =?us-ascii?Q?Ce46+Lesu3VhAezQQFgJDuCezwZ8nB80Ng0W1MmIfHcqG/dgNOWCn1Sv4+HJ?=
 =?us-ascii?Q?mqb7ct/hdJW7YvrradPDFa5INImZe85ATmf+Qg4HuL81+iPdPB0fRYJSULHJ?=
 =?us-ascii?Q?bzt5xvxbNANtKRQsfezbSe6pF6MTBLNHRaSN74NgcN+3ZTe8G1vYXo2eYs/c?=
 =?us-ascii?Q?iiyq/ckEEGYoEF/97DizrmGzdFLQsUpk3U2o/H8Ik2HzhwbyQq187mWi7xBm?=
 =?us-ascii?Q?nfSLQtZligXgslNt36C2hxFCIC0kxJnYxAWl9oZnkI69zqX3qB7l2RS9Vu3G?=
 =?us-ascii?Q?zHElzDfhNgw/vw3E25ftM+FMW/gdggPHIwmzspA+FBFyoNr9i/QxU/LGyeCl?=
 =?us-ascii?Q?yoLxG37FlE/mXqke5idaD40MuZUeeGIQYpvMtAZzap0eE948RChZtOoHqyRA?=
 =?us-ascii?Q?b2WMCTUPa2ikIG8dsPR7QWrj9D3NbOLieaCC+KcBOOaU5tyfvxyZ6kAmQGeE?=
 =?us-ascii?Q?NI5o+OFB1Gl6ikX/Al0OE1sLMqpuO8ST62pwaSoAKQYEaoIyyY9p4qEeKzZ9?=
 =?us-ascii?Q?/PClpkIELK331E9/iMd+ZGpRox6HhZSNIAdbhoU6LjTV00RIMJzEh/Y3r5n+?=
 =?us-ascii?Q?U1ksAdiHVqWcLJo3L8rm+MY9xz/7uJ70hBqeoCrKVUrzfF39VdczyTZoFenZ?=
 =?us-ascii?Q?8iMtuGrh4otl57n3l3JyLYWQ7tELRbVB/TOVZR2ZSVLh1Pn8C2Yv7Sy+MYOU?=
 =?us-ascii?Q?zpv1+PWGeigsRVWBe5Ct3Yg4WQmyJuaCgBxKJgTzOf9zsbCkp9ibEvj403eA?=
 =?us-ascii?Q?smB7pU6ZzocdHPL/VrRBT9TN2mKZ+zIgBr32kOtERNXLwfcWLNABNBVycS+z?=
 =?us-ascii?Q?E84NfZ7S+UQs0yLpfaphw+tb8JCUo2MDZnDr1lK3u3NAqM8M2Mt2mOBSv3K5?=
 =?us-ascii?Q?4oPa8oy2BObSjn+48ulBS6wC0NKWJqOQ3+7zAADNlMD4/xGCGCRm8J/4Y7iw?=
 =?us-ascii?Q?RC2/ctHVXHq3hU2FfuST6ZAf6XbWE5MSRCxQfldeocXIp9s4CLHTYpeZxMiy?=
 =?us-ascii?Q?YvC+2oV1c8T299ZCHjeAeG3w7USTluCvvodiS+Q2ddyjocMJRQ68ZPMyoKzP?=
 =?us-ascii?Q?5iRbaV6nvCsVACWfC3WAob/ezFzIEk2uARM/6ZnhP4P7NmxkUvkGsAHHKivK?=
 =?us-ascii?Q?SaghJU4ymc0+kvV+BS99QbOAhgQa6hn+hx2YXgPM3W0WhHWPvqlWFRKlyDqk?=
 =?us-ascii?Q?n7sYrm6KkAyGs48S4ARvKK26kFm+T8100N4zDQKbssIpCYBu6yA4gV0TAIhy?=
 =?us-ascii?Q?qoo9D4T8Itvhdf1c52nQ9ukBU7s3MpvOW0a9THXWcczHAE0cdviohj7Kjhjz?=
 =?us-ascii?Q?CBlcL+g2QGXQllvj5lVsL57EkbP8eRGUEtjcmmox7RIHbQzabRbu803JjLGO?=
 =?us-ascii?Q?yxsEb9JcIiEfpx+yAnW8EQOvE0ixlqTbupv5zcBhYomtmg1fkfuZEhjDLae1?=
 =?us-ascii?Q?ucMc9kiS2AF2FHbBd4ebdVACbWtRCNFOC77vtHQ6qiApmFduGjReKMvhtPgM?=
 =?us-ascii?Q?Mr/yucx/yKGCG8GbAkw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:50:10.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb5b247-8ba6-4cbd-2124-08de34484349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
index e744ce9534eb..eb9a4cf5e79e 100644
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

