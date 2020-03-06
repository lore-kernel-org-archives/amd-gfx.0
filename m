Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA55C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 23:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D43206D7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 23:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D43206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3938D6E235;
	Fri,  6 Mar 2020 23:31:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F4A6E235
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 23:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jawA3MAGSMZoGtpk384Sru7qUXpgF+1xNovLnSVPEojJkxUXyY4dV9YmptuoagpRnH1khfIb3GqG4OgWTtTo9CyzxDXHQ6gEzSMri6/UmY4BuVS4Vm0asBVGW+L/05dfzr9guAnD76JbN795nUnASKYe3hbzJq0bQwV9d+OY4tGwS2j4OTzHgt2RcoqxxS3RhFA9L9dOjJgSknej4zSodTKdy5LypWRojcfRiNIxzFrcOd6sMaGtwWBlRp2TfNQ0t5ZKgOd+S+w94ebIAbYtMNEV3YvwNitIjMuAziZk2UvgoSywI3zmLMszg6uKgCGP0+nctLYm69F37TevEEmMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EPHHd72Gu73JNiA22top5bPJH+khCONBq5O0XZup1A=;
 b=SB+c0mAf3YGfdW5eu43DaVgBAtde0nQZvcn3dBi0EGghakmIVoMkXr92Odi5ILtCdW4cVQvO4RVhLrT+mAV6gJ7pebrfdMV7poE8CviMJhn5oHbKP7XkHKrcN0U03hVMEGZ/xLXia3KCTs9lBzRNTLx0V8E0ewQeNOcqrDIi1RuHzsqbbFxuScvd9eA0eBgZbnevkQBEQqXSv6bkGVTYTOVPdMBm8sJB4o2yhUfhrfXe+wRPwfsklci3vbPB6/eY7ZdtiRRE8lhZa00wR1SJCYYDY+Z5SLDqb1Q91L1SqlUfz1K22OmNqBy580zgbdIORfDzQy0NbTdCBRbskRxQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EPHHd72Gu73JNiA22top5bPJH+khCONBq5O0XZup1A=;
 b=PelZwqkN4uQ+ACfJDDz7qi0nJtDtnxbpCI0K50feaKxZ7H3dSxwWlB5si+vkmu8PsJHDDbr8JnU/40NRAq9hrfihey76COdB1TpIhbEJZ3oA6iFftCwidBbcWm/NElDAFqkes8/av6CtXtM3B2ACVqh80jRaG/J2xZoJMfL3+/g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 6 Mar
 2020 23:31:13 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::8c06:4379:c755:dfe4%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 23:31:13 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Consolidate duplicated bo alloc flags
Date: Fri,  6 Mar 2020 18:30:59 -0500
Message-Id: <20200306233059.26546-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Fri, 6 Mar 2020 23:31:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e57964c-8b1c-420e-8b48-08d7c2267521
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:|CH2PR12MB3832:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3832AC08ADAD1E0A56CF795BF0E30@CH2PR12MB3832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(478600001)(16526019)(2616005)(186003)(26005)(6486002)(1076003)(86362001)(316002)(956004)(81166006)(6666004)(66476007)(6916009)(66946007)(8676002)(81156014)(8936002)(66556008)(7696005)(52116002)(5660300002)(36756003)(4326008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3832;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+WyQY6DKVSAz0em1KMnnt9If5OCwoZfg57my/2OR6nLItcN5nJsBOaiZ4PrZfi/MLFJtUbtnAON50n7LX/rCVbJ5AeguKOclkhmgeg8744dvWtRoRLjyAUCd0YMHBQMbLKkrcDGoPfgRSV18yXHj50zYX+8sKomNBTqokV/zs/mWZ315xr1J9qGj1Pk6phXv0N+g9Mca7jcZQo18neOxD4VU/HKEVW8tob8DbOy4Kc4nm2tg4Mn12txRC/uZBLkVY5osSg/Js4jBpJ/U72BzKQFlIRpM2VQGy4uRmrcx0aA7pCEXbxEuSSy4El286PSRIGuBnhZs9UfhZNZ48C7EPmKkG7px/zmoHITV+/+ZADlO0rdf9q1CAzJFueWhXs/1ApuETfSsAxskzypv53Tef0d4p0HY2d081yRwGm5pzUZARWpzNlV6cRCsPQTdeCA
X-MS-Exchange-AntiSpam-MessageData: c7Bh1F35TTgskDaSjrUxzxCFJMRE2SYVGpEytYTk3Fxc+f//VfAqK++1qNxcYde72gv7zL8hIIRQk92UvFODpYb6sckpWOSVJehRftRfmCoBRASLGqSCcgUXDL7eOgCV9nQxV3fG+WF+cyIUmqy0zA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e57964c-8b1c-420e-8b48-08d7c2267521
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:31:12.9690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4EJNgjf4EmNpu6k1oNK76uXu5HtiVh10JD0giHRGDJ8KQykV+xE2tZx7PBzf8ei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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
readability. For example, KFD_IOC_ALLOC_MEM_FLAGS_COHERENT is not
referenced in kernel, and it functions implicitly in kernel through
ALLOC_MEM_FLAGS_COHERENT, causing unnecessary confusion.

Replace all occurrences of ALLOC_MEM_FLAGS_* with
KFD_IOC_ALLOC_MEM_FLAGS_* to solve the problem.

Change-Id: Iced6ed3698167296c97b14e7e4569883859d619c
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 29 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 +++++----
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 21 --------------
 4 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 726c91ab6761..abfbe89e805e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 static const unsigned int compute_vmid_bitmap = 0xFF00;
 
@@ -501,10 +502,11 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 					   metadata_size, &metadata_flags);
 	if (flags) {
 		*flags = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
-			ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT;
+				KFD_IOC_ALLOC_MEM_FLAGS_VRAM
+				: KFD_IOC_ALLOC_MEM_FLAGS_GTT;
 
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			*flags |= ALLOC_MEM_FLAGS_PUBLIC;
+			*flags |= KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC;
 	}
 
 out_put:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e4481caed648..9dff792c9290 100644
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
@@ -1680,10 +1681,12 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 
 	INIT_LIST_HEAD(&(*mem)->bo_va_list);
 	mutex_init(&(*mem)->lock);
+	
 	(*mem)->alloc_flags =
 		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
-		 ALLOC_MEM_FLAGS_VRAM : ALLOC_MEM_FLAGS_GTT) |
-		ALLOC_MEM_FLAGS_WRITABLE | ALLOC_MEM_FLAGS_EXECUTABLE;
+		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
+		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
+		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 
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
