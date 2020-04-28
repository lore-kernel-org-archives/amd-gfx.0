Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B267FC83002
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 02:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77457206D9
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 02:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AquLS/op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77457206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3538A6E063;
	Tue, 28 Apr 2020 02:49:10 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690052.outbound.protection.outlook.com [40.107.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140C56E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 02:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckmZreIcq/ZVw1WP/6vogF+ig4EBzbcyHsznb3B+t14cP0LaYXzOJ4timdZHEJbuTbhq8TZM4P0YB79stoWP5JajYYT4aQX8isFIYl8jZyQ6yFlof853UmUnelUge8+S564S+59CMIGkfcTv3gyfY2Zql+Y+1M+ajTtSQmKEnE4PlvAohg5cqVnasRDIdhJLfv/6XDF356+OcKtpcsWWx+jPWmmSoIJOdNDeuHrcDetgBIvMRgCBSGjVT/sTTyveO5pWx7gESVDe5Nma54mkRTYvMxs3lIRpQzv5mzPaLZ0WH4mE4/SMvD82co69EK1Cs28chLgKpRkog00JlLrLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Vm1SgUTxjtheHKr8U1TWkruObR9zs5Bc5FvxZXpTs=;
 b=bhHvLaDUjBpkddn9U0neYVA2es5UUsR9SrfovdM/rhDrmr/OW+hxE/D/wWiuMVB8wTqhxrGJALGjjpJMLtNs5JJOXfoGcH/ZEDDis2CYxRBTnCOqECbemjz0pQAfydGfH2FdTIA+FM1kT+2PGS01n79qXCH6v2QgyKs+HiSsvndtBKF0iKwwPUz2s450hLS9ceX/B/e4c7scV7cWfoVkXvCPH3EoxbutL+Dl09CcaPMcte4QGNG0BP2DWV85BO5a5kGtVD/uJ6tOdPh0XdY8knyBJaAab+ZNt1OiiCBfn/uSWKbz+tUverqpjndE5lJt+8lXlavP2bqoOjNt7iDeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3Vm1SgUTxjtheHKr8U1TWkruObR9zs5Bc5FvxZXpTs=;
 b=AquLS/opjyRE3LSk+h3fZUt4oY4o45MgKMLhJ7ShV3kVyIi/AfYu5jFIiwD3xWECc0atd14f4l3dSRihITvL1EGAFUcmk7JDKMhX0Gd+4lXIykDQKZgnjIJGOp7aRoVrmG0VAzHpBS3k17IXvr0TpQAod3jSjAv8Y71Z6h+a5yo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mukul.Joshi@amd.com; 
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 by BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 02:49:05 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf%5]) with mapi id 15.20.2937.020; Tue, 28 Apr 2020
 02:49:05 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4] drm/amdkfd: Track GPU memory utilization per process
Date: Mon, 27 Apr 2020 22:48:52 -0400
Message-Id: <20200428024852.30130-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 02:49:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bab5b7c-967b-46e1-9ea6-08d7eb1eb76c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2833:|BN7PR12MB2833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB283330BB38C5C974488E67A8EEAC0@BN7PR12MB2833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2836.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(6916009)(16526019)(6666004)(4326008)(44832011)(1076003)(5660300002)(956004)(2616005)(81156014)(8676002)(478600001)(86362001)(66946007)(66556008)(186003)(66476007)(52116002)(7696005)(8936002)(2906002)(26005)(36756003)(6486002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5YA9ptOVkF4mBPcnoGMYyL45zo1EAvkWAWtdd7XLQL/1zK6iPPS21UdfQawKrrXc2B7BYoiiBopyWdofTeO4c+hye6pFKdMUTSP0ronTXZPDv/P2KYzZQcF34wlMmlim/Q4aJitVGc41v8L2Hvm2UjTiVonw4L19ykJhkTfLiNQ8gEnyAHTh7Y1x+vi0vGc8nMErAmTTdDYFxtW+J+TTg2+Fo0OvDt77hth1yjSiUCyipJRdDoYDnhXmN/jUSpHkN9bRtJU3LdCA/5WFICCsSoXIqxRjQhOUHY6jTS0U7ZbfjOFG0EQfqbPfvRFKshLW30rjYjkBW7aIXGTY4f1q9iYWSD7gawt40anF1hOkKMwo2YrLXBWDY3jDh6ONJyy0er0Rs29m+1q4WVkAVo0O40Hme5s61J0vnRO3ur5i1xdAnNvZXm0LSoiuC9FnbG2
X-MS-Exchange-AntiSpam-MessageData: Zo/4mMOH4ru6i+G9F5oeIPpt6h1Qmc+ZSKHV5VF/fuaY17YZTb0EfopaFOo+9GYi9yjyR8LpJEiAr7RsBzLiCpiIzgY78A8fL3yvMEMBfxbKyJA2xjkcLYsu2NiLkTseutXaFGcDw/taBJZ+7h4GnDQTSKLAmSjzKJSL7t+K/WY2dtqnGmsR8IwgZUKEEVVUCjKnDFDjbb1cdMzZ7B61vA73pLvFsS2fJel3QM9qWn3Fk+mk7xNBgeqZN3QVKVwdJCBEiign/snZIzcYyX7G5GwZbbmFp9Y7MFGqJgySTBqO3D/4c3DkDH6FImDTg++anF8qfUnQWK6eXmBwaRsV7Kg54m4xdAdSHwlUOJCh1MC5HPaxdUfpbQej1XxzfzDmzQGwjT0QVZb5nyPy50rdpgrtbin+/DyUlqdp/WLlmvsrWdC/e7Ol1COAAhMhKI8R1QsyW3NaMYT4WZSB1lcpE7VlIhCQdsF4XqFWEIUHHBbzj0uFLRj32HWiWBaDtQuwvD9apRJD56+GBfYdyI9dG2FznSALL9m7eu7/7gTK4bGI39Dxfs+opEGLdiIrvqRI9zFLA2w2wxaJLqU6K1Ov4UnawgQ7qclpv5fYFPX3Mze6+UQpHkJFNMPpkPWIdSAxZOdVG6Jmor4dSHEwUo7FeJudnh8fdmg21b1yVi21giSIPV/oyIzGDBS0IrxhuYQKdRDk4UNLIU7DDf2blFYu5CpAa7dZFr02m5ElyZcHFtSa5sr3dNx6Q6hr2B9yV906ZwCmfxngPv8iVwJYQMi0ukz4QPO+69FJ+VKqMaC1sQk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bab5b7c-967b-46e1-9ea6-08d7eb1eb76c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 02:49:05.7118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9FbJgGwEnA7bQ9R3gqLSq/tz+vhV+0uzdFdJdkVnXWTDbXXuucUHj9c6cbthsR7MO80IN7niaoVZgWOvhTBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2833
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Track GPU VRAM usage on a per process basis and report it through
sysfs.

v2:
   - Handle AMDGPU BO-specific details in
     amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
   - Return size of VRAM BO being freed from
     amdgpu_amdkfd_gpuvm_free_memory_of_gpu().
   - Do not consider imported memory for VRAM
     usage calculations.

v3:
   - Move handling of imported BO size from
     kfd_ioctl_free_memory_of_gpu() to
     amdgpu_amdkfd_gpuvm_free_memory_of_gpu().

v4:
   - Add READ_ONCE() and WRITE_ONCE() around 
     reading and writing vram_usage count.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 16 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 57 ++++++++++++++++---
 5 files changed, 84 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d065c50582eb..a501026e829c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -65,6 +65,7 @@ struct kgd_mem {
 	struct amdgpu_sync sync;
 
 	bool aql_queue;
+	bool is_imported;
 };
 
 /* KFD Memory Eviction */
@@ -219,7 +220,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		void *vm, struct kgd_mem **mem,
 		uint64_t *offset, uint32_t flags);
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem);
+		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size);
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		struct kgd_dev *kgd, struct kgd_mem *mem, void *vm);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0768b7eb7683..1247938b1ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1277,7 +1277,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 }
 
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
-		struct kgd_dev *kgd, struct kgd_mem *mem)
+		struct kgd_dev *kgd, struct kgd_mem *mem, uint64_t *size)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	unsigned long bo_size = mem->bo->tbo.mem.size;
@@ -1286,9 +1286,11 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
+	bool is_imported = 0;
 
 	mutex_lock(&mem->lock);
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
+	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
 	/* lock is not needed after this, since mem is unused and will
 	 * be freed anyway
@@ -1340,6 +1342,17 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		kfree(mem->bo->tbo.sg);
 	}
 
+	/* Update the size of the BO being freed if it was allocated from
+	 * VRAM and is not imported.
+	 */
+	if (size) {
+		if ((mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) &&
+		    (!is_imported))
+			*size = bo_size;
+		else
+			*size = 0;
+	}
+
 	/* Free the BO*/
 	amdgpu_bo_unref(&mem->bo);
 	mutex_destroy(&mem->lock);
@@ -1694,6 +1707,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	(*mem)->process_info = avm->process_info;
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 	amdgpu_sync_create(&(*mem)->sync);
+	(*mem)->is_imported = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a12add..72c5843d9861 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1322,6 +1322,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_free;
 	}
 
+	/* Update the VRAM usage count */
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + args->size);
+
 	mutex_unlock(&p->mutex);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
@@ -1337,7 +1341,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return err;
@@ -1351,6 +1355,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	void *mem;
 	struct kfd_dev *dev;
 	int ret;
+	uint64_t size = 0;
 
 	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
 	if (!dev)
@@ -1373,7 +1378,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	}
 
 	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
-						(struct kgd_mem *)mem);
+						(struct kgd_mem *)mem, &size);
 
 	/* If freeing the buffer failed, leave the handle in place for
 	 * clean-up during process tear-down.
@@ -1382,6 +1387,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		kfd_process_device_remove_obj_handle(
 			pdd, GET_IDR_HANDLE(args->handle));
 
+	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
+
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return ret;
@@ -1726,7 +1733,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return 0;
 
 err_free:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b311c7..e7918fc3cee5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -616,6 +616,8 @@ enum kfd_pdd_bound {
 	PDD_BOUND_SUSPENDED,
 };
 
+#define MAX_VRAM_FILENAME_LEN 11
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/*
@@ -658,6 +660,11 @@ struct kfd_process_device {
 
 	/* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
 	enum kfd_pdd_bound bound;
+
+	/* VRAM usage */
+	uint64_t vram_usage;
+	struct attribute attr_vram;
+	char vram_filename[MAX_VRAM_FILENAME_LEN];
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fe0cd49d4ea7..b626062c6232 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -79,18 +79,22 @@ static struct kfd_procfs_tree procfs;
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
-	int val = 0;
-
 	if (strcmp(attr->name, "pasid") == 0) {
 		struct kfd_process *p = container_of(attr, struct kfd_process,
 						     attr_pasid);
-		val = p->pasid;
+
+		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
+	} else if (strncmp(attr->name, "vram_", 5) == 0) {
+		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
+							      attr_vram);
+		if (pdd)
+			return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
 	} else {
 		pr_err("Invalid attribute");
 		return -EINVAL;
 	}
 
-	return snprintf(buffer, PAGE_SIZE, "%d\n", val);
+	return 0;
 }
 
 static void kfd_procfs_kobj_release(struct kobject *kobj)
@@ -206,6 +210,34 @@ int kfd_procfs_add_queue(struct queue *q)
 	return 0;
 }
 
+int kfd_procfs_add_vram_usage(struct kfd_process *p)
+{
+	int ret = 0;
+	struct kfd_process_device *pdd;
+
+	if (!p)
+		return -EINVAL;
+
+	if (!p->kobj)
+		return -EFAULT;
+
+	/* Create proc/<pid>/vram_<gpuid> file for each GPU */
+	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
+		snprintf(pdd->vram_filename, MAX_VRAM_FILENAME_LEN, "vram_%u",
+			 pdd->dev->id);
+		pdd->attr_vram.name = pdd->vram_filename;
+		pdd->attr_vram.mode = KFD_SYSFS_FILE_MODE;
+		sysfs_attr_init(&pdd->attr_vram);
+		ret = sysfs_create_file(p->kobj, &pdd->attr_vram);
+		if (ret)
+			pr_warn("Creating vram usage for gpu id %d failed",
+				(int)pdd->dev->id);
+	}
+
+	return ret;
+}
+
+
 void kfd_procfs_del_queue(struct queue *q)
 {
 	if (!q)
@@ -248,7 +280,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_dev *dev = pdd->dev;
 
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->vm);
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, NULL);
 }
 
 /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
@@ -312,7 +344,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	return err;
 
 err_map_mem:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, NULL);
 err_alloc_mem:
 	*kptr = NULL;
 	return err;
@@ -411,6 +443,11 @@ struct kfd_process *kfd_create_process(struct file *filep)
 							process->kobj);
 		if (!process->kobj_queues)
 			pr_warn("Creating KFD proc/queues folder failed");
+
+		ret = kfd_procfs_add_vram_usage(process);
+		if (ret)
+			pr_warn("Creating vram usage file for pid %d failed",
+				(int)process->lead_thread->pid);
 	}
 out:
 	if (!IS_ERR(process))
@@ -488,7 +525,7 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 				peer_pdd->dev->kgd, mem, peer_pdd->vm);
 		}
 
-		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem);
+		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd, mem, NULL);
 		kfd_process_device_remove_obj_handle(pdd, id);
 	}
 }
@@ -551,6 +588,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+	struct kfd_process_device *pdd;
 
 	/* Remove the procfs files */
 	if (p->kobj) {
@@ -558,6 +596,10 @@ static void kfd_process_wq_release(struct work_struct *work)
 		kobject_del(p->kobj_queues);
 		kobject_put(p->kobj_queues);
 		p->kobj_queues = NULL;
+
+		list_for_each_entry(pdd, &p->per_device_data, per_device_list)
+			sysfs_remove_file(p->kobj, &pdd->attr_vram);
+
 		kobject_del(p->kobj);
 		kobject_put(p->kobj);
 		p->kobj = NULL;
@@ -862,6 +904,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->bound = PDD_UNBOUND;
 	pdd->already_dequeued = false;
 	pdd->runtime_inuse = false;
+	pdd->vram_usage = 0;
 	list_add(&pdd->per_device_list, &p->per_device_data);
 
 	/* Init idr used for memory handle translation */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
