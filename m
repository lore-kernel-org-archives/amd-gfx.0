Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F77C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41DE20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u7j5I6oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41DE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF17886DC;
	Wed,  4 Mar 2020 20:22:02 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680072.outbound.protection.outlook.com [40.107.68.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDB3886DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 20:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Gu30BSuU2aa0KIhB6JiynNBZUObYfA9uDQxA8AswXkidsQRmbfcEHyKy3HwLD9+qM5MJrExxCKuNrbVV4GlLZ+UX2hDC3cGhuSQafgUMAz4sM6I2EgG0uCmgHcT99IC7kQsKX8lDOY8iIodE9kAfh4Sh6YPIhrGa/bfoRnZSAicOf7i51BeOmtmAVeM07anmUb3hRSYiwczxsib8T3awP8o00M1jYDNvnnzBKbng5kH9Xh/sV+Jko192vCS37I3Gz6BOcdBaXVEI3zWNaD02EbwCoIKo18PETBW0fOBJW5Dxrzm/jppoNo81rJhT8KAnXw6vJTTJga4VhTpofNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otflzVP6WUz0S46dyO17cl1R3r8G4aNcdifMxVFDba4=;
 b=SULPqIDiPgiGKpbZJ6Op27Lz19nUbrBfpu5M4FoTLK8lUkDwKII7HvVgBVPJ3iK4r5ss2GkuMIAKwoXsza0kz4FKr/KIpZlmKoTz/ds8N+w+rcm0unDSS/q2Y7AEw3uI5U9eTzC4RsxAKjia/2FhMp9biSwfeXhrmqLY6mRETwJMF0O/gUgfBjWLjgh9DHxBXjFOA2+ZnJCYT2HgFnx2BA49irpnsUM1OBZIPfFpcbFijXqqRv1I4gPtpiQepyMkCrYjI2iGIVCE8n6xiXBIqAKC2IKSR7MgxrMEnkpfW28opVRaxGc4XFMSrRrJShSSBf2n/5/Dt4Q3Dvhap8dmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otflzVP6WUz0S46dyO17cl1R3r8G4aNcdifMxVFDba4=;
 b=u7j5I6oM3rpGDJ+g9Xe/LZexzvhXxtEgxpPAJxhvgyOhQRmp+bmupmyqrVCtpNTkVHpQybN70eCervHyQUClUI84Pv23finwsNrMAfUjoKIcUCq6z1eO+iZOemcLMtRXr6y14gvDNacRbhiJKwj1rzQtMTbUuxpq8pdjuneGtiQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 20:21:59 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 20:21:58 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags
Date: Wed,  4 Mar 2020 15:21:45 -0500
Message-Id: <20200304202145.22021-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 4 Mar 2020 20:21:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dcdf2a75-ba2b-48fe-5c35-08d7c079afa4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:|CH2PR12MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4279B2C287E3FD77F4496DCCF0E50@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(16526019)(86362001)(26005)(8676002)(81166006)(8936002)(186003)(478600001)(81156014)(4326008)(6916009)(6486002)(956004)(2616005)(52116002)(2906002)(5660300002)(66556008)(7696005)(36756003)(66476007)(6666004)(66946007)(1076003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4279;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgpJS46aHR4bkQkBKhd2Mwb7WM4VtJOzoYZJ5rGUNwNSBe1zMtlDA0Em+CN4avRhiw+/L8pXJdRC4E8BRH63nWrQU3pVEAmHtwXvHsUcivEBh/zEtn2wFmV3Zb19ndQi0MQIRlWet3UYMzLta7GPEkowKLNKv56tDeS6xmhrvcmlgbueMhf/j5jnaTskxarr8GsezIrGk58JNx95jdUUNLPVV3tQReE3IKCtDldv0glfr+RAgGWVLfGNW6G7cR6MuNlA2OmlG7ws2Xieug/IjyWbxuxuqX2XS32r1Q7suCkRzQyVlzGyCDpkVpOpZI7nWFv4Z3t/eEoFvfpfrQ5oW1y6dm2fmbJf1EKVi3H9v2vx/iduJdZVi7iODHawXxXqLdvvIR84X0AIylu+/rW2w1kBDODKgcMDjgW767K9gtSJ+mnR0SsNGD2+2LzY9k55
X-MS-Exchange-AntiSpam-MessageData: G7FtYP6Dy2m7wcET22aVZya5AW95n3AfNg22YoaX7rPcHIeqFfiygIdvqvYUG4LiKewLtBjepFr9PxQSrmxe1aQ7+h56gCerrFh03UHM5bXxKqPeBYmBhPes5+PFgB7ikvCC+pqPjICZ8vAKTHBnow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdf2a75-ba2b-48fe-5c35-08d7c079afa4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 20:21:57.9947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zBu9xVyfapS9uKdrmkC5fRthiM8Y+X+jf8HNyIlN/EChfBZ9AQI4hUH3AVK+08g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ALLOC_MEM_FLAGS_* used are the same as the KFD_IOC_ALLOC_MEM_FLAGS_*,
but they are interweavedly used in kernel driver, resulting in bad
readability. For example, KFD_IOC_ALLOC_MEM_FLAGS_COHERENT is totally
not referenced in kernel, and it functions in the kernel through
ALLOC_MEM_FLAGS_COHERENT, causing unnecessary confusion.

Replace all occurrences of ALLOC_MEM_FLAGS_* by
KFD_IOC_ALLOC_MEM_FLAGS_* to solve the problem.

Change-Id: Iced6ed3698167296c97b14e7e4569883859d619c
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  9 +++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++---
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 21 ----------
 4 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 726c91ab6761..affaa0d4b636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 static const unsigned int compute_vmid_bitmap = 0xFF00;
 
@@ -500,11 +501,13 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
 					   metadata_size, &metadata_flags);
 	if (flags) {
-		*flags = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
-			ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT;
+		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
+			*flags = KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
+		else
+			*flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT;
 
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			*flags |= ALLOC_MEM_FLAGS_PUBLIC;
+			*flags |= KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC;
 	}
 
 out_put:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e4481caed648..c81fe7011e88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -29,6 +29,7 @@
 #include "amdgpu_vm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 /* BO flag to indicate a KFD userptr BO */
 #define AMDGPU_AMDKFD_USERPTR_BO (1ULL << 63)
@@ -400,18 +401,18 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
-	bool coherent = mem->alloc_flags & ALLOC_MEM_FLAGS_COHERENT;
+	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
 	uint32_t mapping_flags;
 
 	mapping_flags = AMDGPU_VM_PAGE_READABLE;
-	if (mem->alloc_flags & ALLOC_MEM_FLAGS_WRITABLE)
+	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
-	if (mem->alloc_flags & ALLOC_MEM_FLAGS_EXECUTABLE)
+	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
-		if (mem->alloc_flags & ALLOC_MEM_FLAGS_VRAM) {
+		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev)
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1160,24 +1161,24 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/*
 	 * Check on which domain to allocate BO
 	 */
-	if (flags & ALLOC_MEM_FLAGS_VRAM) {
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 		alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
-		alloc_flags |= (flags & ALLOC_MEM_FLAGS_PUBLIC) ?
+		alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED :
 			AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
-	} else if (flags & ALLOC_MEM_FLAGS_GTT) {
+	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
-	} else if (flags & ALLOC_MEM_FLAGS_USERPTR) {
+	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		alloc_flags = 0;
 		if (!offset || !*offset)
 			return -EINVAL;
 		user_addr = untagged_addr(*offset);
-	} else if (flags & (ALLOC_MEM_FLAGS_DOORBELL |
-			ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+	} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
 		bo_type = ttm_bo_type_sg;
@@ -1198,7 +1199,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	}
 	INIT_LIST_HEAD(&(*mem)->bo_va_list);
 	mutex_init(&(*mem)->lock);
-	(*mem)->aql_queue = !!(flags & ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
+	(*mem)->aql_queue = !!(flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
 
 	/* Workaround for AQL queue wraparound bug. Map the same
 	 * memory twice. That means we only actually allocate half
@@ -1652,6 +1653,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *bo;
 	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
+	uint32_t flags;
 
 	if (dma_buf->ops != &amdgpu_dmabuf_ops)
 		/* Can't handle non-graphics buffers */
@@ -1680,10 +1682,16 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 
 	INIT_LIST_HEAD(&(*mem)->bo_va_list);
 	mutex_init(&(*mem)->lock);
-	(*mem)->alloc_flags =
-		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
-		 ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT) |
-		ALLOC_MEM_FLAGS_WRITABLE | ALLOC_MEM_FLAGS_EXECUTABLE;
+	
+	flags = KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
+		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
+
+	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
+	else
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
+
+	(*mem)->alloc_flags = flags;
 
 	(*mem)->bo = amdgpu_bo_ref(bo);
 	(*mem)->va = va;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 22abdbc6dfd7..1c7bfc842f06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -327,10 +327,10 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
 {
 	struct qcm_process_device *qpd = &pdd->qpd;
-	uint32_t flags = ALLOC_MEM_FLAGS_GTT |
-			 ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
-			 ALLOC_MEM_FLAGS_WRITABLE |
-			 ALLOC_MEM_FLAGS_EXECUTABLE;
+	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT |
+			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
+			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
+			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 	void *kaddr;
 	int ret;
 
@@ -692,8 +692,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 {
 	struct kfd_dev *dev = pdd->dev;
 	struct qcm_process_device *qpd = &pdd->qpd;
-	uint32_t flags = ALLOC_MEM_FLAGS_GTT |
-		ALLOC_MEM_FLAGS_NO_SUBSTITUTE | ALLOC_MEM_FLAGS_EXECUTABLE;
+	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
+			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
+			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 	void *kaddr;
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 0cee79d56075..a3c238c39ef5 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -167,27 +167,6 @@ struct tile_config {
 
 #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE_DEFAULT 4096
 
-/*
- * Allocation flag domains
- * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
- */
-#define ALLOC_MEM_FLAGS_VRAM		(1 << 0)
-#define ALLOC_MEM_FLAGS_GTT		(1 << 1)
-#define ALLOC_MEM_FLAGS_USERPTR		(1 << 2)
-#define ALLOC_MEM_FLAGS_DOORBELL	(1 << 3)
-#define ALLOC_MEM_FLAGS_MMIO_REMAP	(1 << 4)
-
-/*
- * Allocation flags attributes/access options.
- * NOTE: This must match the corresponding definitions in kfd_ioctl.h.
- */
-#define ALLOC_MEM_FLAGS_WRITABLE	(1 << 31)
-#define ALLOC_MEM_FLAGS_EXECUTABLE	(1 << 30)
-#define ALLOC_MEM_FLAGS_PUBLIC		(1 << 29)
-#define ALLOC_MEM_FLAGS_NO_SUBSTITUTE	(1 << 28) /* TODO */
-#define ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
-#define ALLOC_MEM_FLAGS_COHERENT	(1 << 26) /* For GFXv9 or later */
-
 /**
  * struct kfd2kgd_calls
  *
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
