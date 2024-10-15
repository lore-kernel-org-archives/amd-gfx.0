Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EBBCFC264
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 03:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6188F10E280;
	Tue, 15 Oct 2024 03:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htnUPAsT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22A310E280
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 03:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGpmXiF5Rw3nDGwqWvp134ydT+x0lFSYFXluoOEjijEWuXF0EjGptPdHZYSOGIvUMC/ZiH4X+XyEYGaWM881sYvUg8jOiG55e9PucpyOlTQOYQtLNLKPV45avB/1SrDyuyTBZneBqLrxqELMXSYu14Q4/Y7gNpMv5dky7FUd87JeqGNBOsy3FA+KNbO3YO6F2k5IyeuGV3WZ+4J2eNyRjewW5fWK7xKcAU1VcRFZ2n14P8em8DYoO/Udwuauf6WN9ZFxjJlskSL5wIxGbH0iGgO8tyUn/m8Foz6mzY8UgXUBNINFQ9/nPHiv6uHRvZDYMSemSlQF/+kIQ4vkKbNFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ8a30ep4O/4JvalPjKuOpNSv7Gyf9Sq4b3PDv5g5M4=;
 b=MQRQ0vbqgD+U4JiHhmwXMnIfvq3izapTLH8FILyzQe4ab2dKt/nP9Xhx6qMjLMzB3B6ErG7c5B12/zfGKkSZDeY+C6xfKetU/GA6HWJfJ4XPQbk9UOEHY04tu4xHDgcwnQxEDCCo/7F3S7GNjnHmtwnuRX8GsqOKN9E1DrSWVMsPBPIA+l8BAa9mlXhO9Dda+xh5kFQC3QQQbW7pZ9xWUWHpci8yhVaSPgbWtXY9PDETQnIy/5fW6xT51IbFGRaY/kBx66aUhyq+/noCfSKHrVBzepUVQmjH6zHMLqrpQdCHuTULRYCULSNwkDxW5Z8SvZSU9g6nYBFuspVJ5i/PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ8a30ep4O/4JvalPjKuOpNSv7Gyf9Sq4b3PDv5g5M4=;
 b=htnUPAsTtmLvVdiJJcHq/8jx/rhQDs5H2Nb3IlxjfPskteX1rUp+7NUzzB9H1/YB7hhPeBo2uiI7GBBXh4joJqnaF8g/3xvZtw9/Rj/Q2eYOh5vKup5Sae3I28JCDnl60oZT3xSVpIyiiBTXJmIlvOIuDcIRdLbWysVv9kg06ng=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 03:52:17 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::df) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 03:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Tue, 15 Oct 2024 03:52:17 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 22:52:15 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info in
 related functions
Date: Tue, 15 Oct 2024 11:51:50 +0800
Message-ID: <20241015035150.1477582-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0d7667-6b6d-4dc6-96ff-08dcecccc340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nl1Yhvbs5TQMUpO1QGH/s6F10DSK87fDPZXHHPmRFdQzrzrgnmZDrZos+2iY?=
 =?us-ascii?Q?5jBYzH0nWAVWdpYCQHHzyVAsZLkhHxDLWhgrhog5Q70Gyp/i1d417seX+YJM?=
 =?us-ascii?Q?XxO4SaRJAPD5V1lxjSVQl61RNrZ2xf2leFNG7gfr7Jnt/t9PUZHzSgF+bzmz?=
 =?us-ascii?Q?aUqD1R1Oco7bc6fqFQOWb5+RU/xPVYF69p3TAyBQNg1a0xKN+PNNq4khPwvQ?=
 =?us-ascii?Q?LClenqryKwpU8hH4oMa3YkUAcpJ6NJMDKHPkC+G3ftvTX3rn1rNl7oCk2vPh?=
 =?us-ascii?Q?7LjOnO9F1kV/O6JRcxmpzmKb/jg9xcwN2Pg+iapvoNG7ex3QEuamYYC5f//C?=
 =?us-ascii?Q?JN+omrM3DUMp29jApdaWLOV9asEW1E+RR2uEpmmZKtA3htOFem0rrHEyH1B/?=
 =?us-ascii?Q?vJpB0iZg/KOBPgjNZ8MjMP0xTkQu3TrjR3VR9YKVPTNeqNUvMmRbhMeEoST2?=
 =?us-ascii?Q?U41akrBvslx5ZnyoxCGcsjfijnQC/lB/lSb3RzcjcZZdwdq6Ca2lnMnJ3Aja?=
 =?us-ascii?Q?tMwL5lxlMeRgNuxSpqG/oa+sbz+gsinxyeKLzifocr5Ca1UT1Ab27k4SbtEv?=
 =?us-ascii?Q?Y2gVLxjQQqXeStfWDgGyeHpezM9OUHEPWhMULQFiuvoYSboLR3xPTtzg5Gfc?=
 =?us-ascii?Q?DX828gsz+evtUW3smwLx97u3pgrgsTAc8G9r/h6SClhGad3dUFfYw3o+QEMl?=
 =?us-ascii?Q?icQweghwvI839au9wKFrLcWwfsOTK8rFHwmjYPK9H4Z/xv8fuzUALn8Ont5k?=
 =?us-ascii?Q?fd3FqBbU5pTSnxqqZaPKgwiaFk1uSgdLjcNnoiIkcImdhA0zcbkAw17z4xzy?=
 =?us-ascii?Q?8S9ESpnkpiTT2Vbp5SEmK6rw48HV9AVUxGYN0U4ld0mMsbqKP7mYkiR5mXwG?=
 =?us-ascii?Q?MnUvYqE2omNexUUHhSn37SAbmJKvUlwMZfZezN37pbvLSEuXSR/9t/cIZbyb?=
 =?us-ascii?Q?JyXXOjnX0+poS/oMOqZiAuZRonn8FpwHZtqspW0Ut9uiicTFK74SXwNkCZ+M?=
 =?us-ascii?Q?oWx4MwvVKh7/yiBrGZlcqL9ViqSKtoU2GpIh4avpejWEgNmZhX7beVVG4wAz?=
 =?us-ascii?Q?XD25MUOepLkU07JS3k/zj4KoUkkjGjn77PZejnE03opG1Q1LgmTLVj/RKPJY?=
 =?us-ascii?Q?fC+vaJoabojPzE7CUXnmmfOGtmRljRetvLuseYw4MQ2M1TTugF+dsbnLEM6k?=
 =?us-ascii?Q?0uHEUVQg3UH3p6+m0ezZC7YhMlLx/lG7Xik44pWocLilhjH0xk72gKNGcglO?=
 =?us-ascii?Q?84ovQ6NG4+cQwadJMUrwXVhRSwFWU6hLmnNHVt79nW7z1ucbKmzHgCDLvfSE?=
 =?us-ascii?Q?7uSut9U3FDY/6EPtFnCILsEwQToGNK4Z4vUy7758pzukHrbkmWaN6chosyaq?=
 =?us-ascii?Q?wYkEbZBIEuBX5A1frMafpzojPRs3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:52:17.2416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0d7667-6b6d-4dc6-96ff-08dcecccc340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

This commit specifies data type struct amdkfd_process_info
rather than general void* in ralted functions.

kfd_process->kgd_process_info is initialized
in init_kfd_vm() by such code:

static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
                       struct dma_fence **ef) {
        struct amdkfd_process_info *info = NULL;

        if (!*process_info) {
                info = kzalloc(sizeof(*info), GFP_KERNEL);

        *process_info = info;
}

That means kfd_process->kgd_process_info is type
struct amdkfd_process_info, therefore we should avoid using void*

Using a specified data type other than void* can help improve
readability. There are other benifits like: type safety,
avoid casting and better compling chekings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f9d119448442..c1346b8c9ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
-int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
-int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
+int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
+int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
 uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 				      enum kgd_engine_type type);
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
@@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
 				     struct amdgpu_vm *avm, u32 pasid);
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					struct amdgpu_vm *avm,
-					void **process_info,
+					struct amdkfd_process_info **process_info,
 					struct dma_fence **ef);
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
 					void *drm_priv);
@@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
 
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
-void amdgpu_amdkfd_block_mmu_notifications(void *p);
-int amdgpu_amdkfd_criu_resume(void *p);
+void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
+int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..2a1ee17e44a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
 	return 0;
 }
 
-static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
+static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
 		       struct dma_fence **ef)
 {
 	struct amdkfd_process_info *info = NULL;
@@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
 
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					   struct amdgpu_vm *avm,
-					   void **process_info,
+					   struct amdkfd_process_info **process_info,
 					   struct dma_fence **ef)
 {
 	int ret;
@@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
 	return avm->pd_phys_addr;
 }
 
-void amdgpu_amdkfd_block_mmu_notifications(void *p)
+void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
 {
-	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
-
 	mutex_lock(&pinfo->lock);
 	WRITE_ONCE(pinfo->block_mmu_notifications, true);
 	mutex_unlock(&pinfo->lock);
 }
 
-int amdgpu_amdkfd_criu_resume(void *p)
+int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
 {
 	int ret = 0;
-	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
 
 	mutex_lock(&pinfo->lock);
 	pr_debug("scheduling work\n");
@@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 	return ret;
 }
 
-int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
+int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
 {
-	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
 	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
 	int ret;
 
-	if (!info || !gws)
+	if (!pinfo || !gws)
 		return -EINVAL;
 
 	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
@@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	INIT_LIST_HEAD(&(*mem)->attachments);
 	(*mem)->bo = amdgpu_bo_ref(gws_bo);
 	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
-	(*mem)->process_info = process_info;
-	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
+	(*mem)->process_info = pinfo;
+	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
 	amdgpu_sync_create(&(*mem)->sync);
 
 
@@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	if (ret)
 		goto reserve_shared_fail;
 	dma_resv_add_fence(gws_bo->tbo.base.resv,
-			   &process_info->eviction_fence->base,
+			   &pinfo->eviction_fence->base,
 			   DMA_RESV_USAGE_BOOKKEEP);
 	amdgpu_bo_unreserve(gws_bo);
 	mutex_unlock(&(*mem)->process_info->lock);
@@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 bo_reservation_failure:
 	mutex_unlock(&(*mem)->process_info->lock);
 	amdgpu_sync_free(&(*mem)->sync);
-	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
+	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
 	amdgpu_bo_unref(&gws_bo);
 	mutex_destroy(&(*mem)->lock);
 	kfree(*mem);
@@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	return ret;
 }
 
-int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
+int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
 {
 	int ret;
-	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
 	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
 	struct amdgpu_bo *gws_bo = kgd_mem->bo;
 
 	/* Remove BO from process's validate list so restore worker won't touch
 	 * it anymore
 	 */
-	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
+	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
 
 	ret = amdgpu_bo_reserve(gws_bo, false);
 	if (unlikely(ret)) {
@@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
 		return ret;
 	}
 	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
-			process_info->eviction_fence);
+			pinfo->eviction_fence);
 	amdgpu_bo_unreserve(gws_bo);
 	amdgpu_sync_free(&kgd_mem->sync);
 	amdgpu_bo_unref(&gws_bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d6530febabad..b0426a1235b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -934,7 +934,7 @@ struct kfd_process {
 	bool signal_event_limit_reached;
 
 	/* Information used for memory eviction */
-	void *kgd_process_info;
+	struct amdkfd_process_info *kgd_process_info;
 	/* Eviction fence that is attached to all the BOs of this process. The
 	 * fence will be triggered during eviction and new one will be created
 	 * during restore
-- 
2.43.5

