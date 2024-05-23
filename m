Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8666AC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114C610EE32;
	Thu, 23 May 2024 18:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ps8qLFwu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA59A10EE32
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMDJIJEUxa6NmCBBL7RnlRWpnME6DO+vN88akNk0uYEDfGrA/LPINVsmsNXLwpo28iXu32Q/MokdZ6nH4RQ9wNvLDpb84ZDXza/WB2Unu1i0wM070pgnUlpf6yQtsbFjoLwDIOwMzNx/SqjxbXfyGzqX/iT5VCBS0sBx+5lYFPgthkcTBfXIzECv2lmZjvI+d4dsb1FvHbGtPmSsBFFVoiRC0aPY/CI5RBBAJV8lfK0ToXhvzHEK9Sl46Kr7T1jdHyOfg4A2QRzrdPW58x8R1sBKlRcE16NQ6jsRGKRxXpZP3a4OYSMfUXoS16k47/LOWhXuXSzCihCivDGy4BtTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNBALMKrYm8KapKMWyFiVJB4NXxRtPxn9KTcfL29Tas=;
 b=aoW9rjMJ/uCUFeX0ULpzrZn+FyqyovIdo/4S3yqJ45i1wR7kA61LNUxp0kqEk/YTS8k8NReP9L0yMTS90P9AhLzQMsIHZJXk66H30dzFeGtZVDkCzvT86wKt1X0QIZoChdrsKe0Gb0r0kOFU4dsOsD0ukxIA1mXrLevWg2I5jk4zlTDMp7A7bPP1vXGZt46Gh2X9FgzroPSjXh5wewAR/d+mHEHYcpNKA7xVbzdI/W3DxBe2wHa8oeC7l8vJ3TewTefvBtAOIhsf5gKrvY1L1xSSA7W2JnUM2C2LBJ4RJpEDXR6TKVjTc4SPTe/j9vPk2CBtJjzeZp+rPnIrXqeZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNBALMKrYm8KapKMWyFiVJB4NXxRtPxn9KTcfL29Tas=;
 b=Ps8qLFwuMp+jSOAak6TCDgoiopd7bREUEh+ct8LdvPWcoHxC7X/5zTBzSt1Iytq0q3S8BomJYjuUv9yN5FRkaOvVepL41pyf0ZG1uB44bCC+QtLdlS9tL/0d4V/jqH6vjfV8Gl3szkVol3OCHAmRPhgTEuDZgK2/yO1gbk+7qdU=
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 18:39:12 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::22) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18 via Frontend
 Transport; Thu, 23 May 2024 18:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 18:39:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: simplify APU VRAM handling
Date: Thu, 23 May 2024 14:38:56 -0400
Message-ID: <20240523183856.1067664-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cd02f6-0287-496a-d325-08dc7b57a3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1GMH3xG+gUIJGuy6OkOZorJoISLgi63w3SJzBf63C/f4xkwMQiEfm7X3PUl?=
 =?us-ascii?Q?yS6nI8pGNo1cjCT990R8oTsXBko+09NnvEnYTfCUB7eGlFPBvwhntVAMT6ZQ?=
 =?us-ascii?Q?BKtIj4doEgHrsK8oON79rSyv3pbz5mRWd+iwPTXI+dZMBcL0oYhb6a5NzGF7?=
 =?us-ascii?Q?xk5pXH5G/rku/EPwXf46Xeri/qvmqkQ3sv2XszWUyA4iaTmZWCA8SjCpZBR3?=
 =?us-ascii?Q?jzrnctJrqkz1Nmrohq4zMtKxQZzyGkoiw1LruBHuLvKWaQYR0qZAvvJnyyQg?=
 =?us-ascii?Q?cKBuirK9ozgCuf/l2opZsZNJ0N0xdV7HhB+FoF9v5CE3wyACS8T0H3sLDC0a?=
 =?us-ascii?Q?28uNLQlwz5uc4Xd7QWMFM2eXj3pS9Ha+Wd3NtZsdRlBathdxWmxW80HEXudp?=
 =?us-ascii?Q?mll/ZQK1zSFDrqrFti4lqGUMEwL1VbkrRzFWHdgwSOFLarr6vSuXThLBzVba?=
 =?us-ascii?Q?D+1w699FPnDz9N4ry0Vbq9KOeQdK4T4b38W0ZSvABf8Owy9wkRnu7CxmCTHS?=
 =?us-ascii?Q?XbTfducYKKdglP1PNxPsXOSRRr83sTjfpG5KB464ZFQ3bJAT96zD4djBhppR?=
 =?us-ascii?Q?Ln0f4Pou9Va9ZO3k/HnQxHmsGMDIZ5Zwj2jOZGXR8ld6QyEC3/dyfQDt62kk?=
 =?us-ascii?Q?4zmxfIt779hr/YXeBq+IdC/jYsdSjOsxBd1kHj2KscQkZixwP59O8zrUyCI2?=
 =?us-ascii?Q?/elICTI/mC93XrZcD7OVV22PBEExf5JQmGXMklVmTPfCpoaAVJwxAISp74Tm?=
 =?us-ascii?Q?jehA5H7A1+0v1g3pBcuoL1fmjhpWs8VrSs+0up/TEudij43OILlz2EIaptnR?=
 =?us-ascii?Q?qdbkTK3fxscPccGtoBVQKJDS8EQdKxu0l2XZqNB0C/SzW1hlkx3O9/cHdhOq?=
 =?us-ascii?Q?SzZhbNkVFBRT++OvPkMMJbId8peQnutdz5SCowOez8XyEb0q+e8yP8ULfBSV?=
 =?us-ascii?Q?AKbsfjqwYQzJRqYtbJx/KDfJMw9oTk1RROCVdzinbY7zYli+OE6xtaywzQvt?=
 =?us-ascii?Q?Qp2dGMYMgGb4RY2TBE4V8B2P/J5sYWsHxP8uc8n/pEGwE6FekhkiT6iNowQu?=
 =?us-ascii?Q?AagcC7uf3Nv/MgCQXYctr2VzHXSB0Pt95PSw45Zw4VIScmBg0TQQTjDkebEm?=
 =?us-ascii?Q?swACxqyDI/K3c36vQEpYvtAabwjPnkizXN+exLp/dZO7GBx1+t2IiYV2DyuT?=
 =?us-ascii?Q?3wSQ2ziVAPrJxG4o/5cx9VEs8g5/qbfUWw0v7Vg2/zIawWXX+QnXpQT5J9Cp?=
 =?us-ascii?Q?V0QR0yZ6XygxNVzVT896g1MgwlQqlOvLX+3TY+ibppthd5GTpogD7Lan2RB9?=
 =?us-ascii?Q?SLI5uvUVQvcV84pSWtq+oPaKbqOKm8ImH28xJvNsYfrrEDHh3WcdVyeLZWil?=
 =?us-ascii?Q?RPaEifx2MNuo9Z82y/Xj3wjuijmj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:39:12.1090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cd02f6-0287-496a-d325-08dc7b57a3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

With commit 89773b85599a
("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs")
big and small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU
is set for both big and small APUs, we can simplify the checks in
the code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 336eb51c4839..3af00b57cd8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+		if (adev->flags & AMD_IS_APU) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
 		adev->kfd.vram_used_aligned[xcp_id] +=
-				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+				(adev->flags & AMD_IS_APU) ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+			if (adev->flags & AMD_IS_APU) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
+	if ((adev != bo_adev && !(adev->flags & AMD_IS_APU)) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1682,7 +1682,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 
-	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+	if (adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1730,7 +1730,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+		if (adev->flags & AMD_IS_APU) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1981,7 +1981,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
+		   ((adev->flags & AMD_IS_APU) &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->bo = bo;
 	(*mem)->va = va;
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
-			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+			 !(adev->flags & AMD_IS_APU) ?
 			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9c37bd0567ef..70c1776611c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					(adev)->gmc.is_app_apu ||\
 					((adev)->flags & AMD_IS_APU))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
-- 
2.45.1

