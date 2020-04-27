Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF74C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF37B206D4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dwqHEG9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37B206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBBC89CB5;
	Mon, 27 Apr 2020 03:45:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C9889CB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 03:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt8kfI3RZvW5QmCnY2katePoujWNYbANdL3lei6ip+Ms2nHj+Y7eWKQyvKAlOmFZ+XTubq+mYLjc8W3BTkP7ZmdGdoTaGdMh9eYAehSHFLD/gFmt3gjpELfzWYByiuoOFkloIOhqIT9DlLyRcXnzYplvKue9ofuFlLNY+hRPyFqKvu1Ou9XEf5HuY+5k+cAHJ4KK7Gw9s3IN+kM5gieZJ+2yyFDAaEVnVZ/PTcE+RQs7EMJcFGaXHoO+kMnfWlxbCXkj+3TNpxn3QfZ7SM71nUAuyTdDSIForeD7QV9ohkEZzudmjQZDimfTLFZ05cNt32FdEOhVi90oWwlJm/qdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN77nSaDB+BTEWG7YwG/U/0m2nwCoDShTrbX2g4uGVo=;
 b=QmsLez4+CKpWMJgCzd027XRAzgHa0eev7XIzG0j/PL1x8bYBVnTvDQL2qMd+4DV6tvgip57ezultnDnHWtVfc7NbWljpwiVMD8XkV2jIfUZGaYNmoD/av8381i/ZXEPGvIQh5LcRPsO4mvPpkAZqJ/8kGCZXjxTvF9hokl+DIGZLtw5uzBS4Y+psZVUXcYHRChCRSWWPiBRpEIiHfASKow9A+ZMWpM0J9bg1I9KkqbsSOd7iFKTNE7BLvf2hUTjhWM1axOOgmwWmkzETA295pb8ehUS460uDj0e6gWXWajhB1fLs2slTOwaxF7swYIhFtqnCYiaFnCnWvJ9giTnV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN77nSaDB+BTEWG7YwG/U/0m2nwCoDShTrbX2g4uGVo=;
 b=dwqHEG9IpUA951cRcPcE3B0Dhv6zp6imoXyrz/Fg9eAP6qUmzmPDfl7hqhiGEzA5zR1PejsuumFbR6G3oY0xI6Jwq7JLOIRdYVXddd8sAG1QkvHB1d6J7VXYIeGGdn9h0ObLkurOYHxlE9Pia+j1A3PETEsgmk8wUKX9WgpxvNg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mukul.Joshi@amd.com; 
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 by BN7PR12MB2769.namprd12.prod.outlook.com (2603:10b6:408:2b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 03:45:20 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::1d19:b77e:51d:3fbf%5]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 03:45:20 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: Track GPU memory utilization per process
Date: Sun, 26 Apr 2020 23:45:05 -0400
Message-Id: <20200427034505.7377-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To BN7PR12MB2836.namprd12.prod.outlook.com
 (2603:10b6:408:32::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 03:45:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b7e1776-b91d-4614-a1b6-08d7ea5d685f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2769:|BN7PR12MB2769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2769D8E0E3204CDC495B09CBEEAF0@BN7PR12MB2769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2836.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(8936002)(81156014)(5660300002)(26005)(8676002)(36756003)(2906002)(52116002)(7696005)(66556008)(86362001)(6916009)(6486002)(956004)(2616005)(6666004)(44832011)(66946007)(66476007)(186003)(16526019)(478600001)(316002)(1076003)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLLQHwwAvA3PP7Iaoqind9KIECD9MC0Ntg7eSKVcXCTWgXua37QAtp7bDMjYr28GeA82g5eN992UhhqrwD0IFxsfZkWZ4Eg5vsapjHwzYvMXFxvpaDD79JGnCaAiaSKmJ4c90z+ZqPYV2NPZuTJehn0kO5EVZs5bK4qiT3YSqKSjtRV9jQ/nyUKOYAOWlV9ndDg8rlyFkJJ2SrYVSxs4mEP2o74ukweyy1XtzWzie6a4DsD5BrerY1B45cFhuLsmaGpkIiB17UqjYaHT8Z+gkFAfF0B+LpuhAntiW8NJnnSxktSs+7mAGAb8O+YR4C+mnC+WmWK23ryf7yddGWO2tnyndT2wU/XIeRZiO+NzrVTyrz49ur36KpoZrxQfhICVhEFmRzBwIHtlm/1GYb7ggzQMfEedPDZ19N7MGbKTF6rP3QZhhZ0pYKHQxtCxR27H
X-MS-Exchange-AntiSpam-MessageData: g6VypdT9/qKhPHXaRAvgZ7OTShUlDg75UuvjoFIHDpeMmatrVqOcshMTycygaIMLA2fDwd044icUMserWi68xn66bFTZPWyhcJrsybqOX4iA1Wo5AX99y/DB5I7MuhEmqpP1PtxPIkxsCwwK5/e32nlhGqTIA1qM6JuMdwwMf5Uo430UIPx/l6qy9ed7QZbRtNmtPyPqYUmLecS0bY6PwPIpmx+zk4brnQ/2q9VUYCmMI3pySevpN7MpWJh/DjvjcZg6fZmOBdDSFibdW8JVPCfjYcPXeWmTfw3QyLBC6c+dr09A3XkV2XzOZAt2zJGD+GvSmS52c/D+51h6K/1RUNL57nd8ygir6G3FFWHn8b2qLSauObFo2OFVcByl6tX74Jan75Al4p3eBcDlQTaQneo4htIzCaHkXhsxHbPb5nomHGPCmE7dl4T0hfxN8LBsY+ghXGtevENSgHZpTrmfsxyTjEZQr6UVX/O0+fy7v5qONcrJuyh0kGmvRTxwUNLPenguj8XsEsBwjmR/Uyo6g2PRtStauH3MInychxk3PgNSYYgNgPtDWzOgl4y0WpUyW9T3HcNcSSD/HwcvlCul3Rbj2U0Cw9kbzeSHbCi8bIFRwJnU0NGPURQ1X102ozohzfrUJa+XXRVAOXehAVEJkoEnguk0liPwqP08AdlwIdMualVKav5SANM21KmQQ2zaeuiXPYHHj+w5S9Lk0sTNj8L1/pgCcDnQ8fs4dBtjxHrsf+wPK/zUpg9hKsIhCQso81nbG/kxcLAX0ktVEwUAbEl1pFHudHD37jUL9eabrJ0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7e1776-b91d-4614-a1b6-08d7ea5d685f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 03:45:20.1619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUrXI0UzyaKUCLQbZiTNsALbpF9xlSZZ6KMQ9YXflPi/klqLpl0LZnCh3tVsOhPNKtjYn+5U4mWxiDYAq8PkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2769
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
index f8fa03a12add..ede84f76397f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1322,6 +1322,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		goto err_free;
 	}
 
+	/* Update the VRAM usage count */
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
+		pdd->vram_usage += args->size;
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
 
+	pdd->vram_usage -= size;
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
index fe0cd49d4ea7..600759949802 100644
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
+			return snprintf(buffer, PAGE_SIZE, "%llu\n", pdd->vram_usage);
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
