Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A0C43217
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDFE6147F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FDFE6147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4226EA4C;
	Wed, 29 Sep 2021 12:01:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9BC6EA4D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ6NAyL7huIqXuhSDLPazu+oBbEx4SfBBfCCS1deZ3J1ujJ0YbLSPEyN7csG6DBCp/3e9DFiwrQZ2hg0FGnJFEnE/oVEisuY4+XSNNB4rZvB/Ck6jswYWTnOI48mYYUjmmPCHzLF0bEAGZBbu8KCCJm8kZOVwsMXHiEmf416N29YDww6Y/JGWAcw04mIQbSiGIky4Vk1XUhc2aWFyxc/4Xibbgz1ologAF90gJeFMY2R/DBNuuzDTAw2yRDPuW3nx/gCIdfl4cGXh2Xw7jHKyPxp1vNr3cmw/AcOJd3ITxXcqWwmlb9/P9epvXbgYLV/mV2WsPkxnKionHaMRfDB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GSV6ncxnz6DvqPHj5SOA0jKfQTe8mUvU4eVsUJv9lDg=;
 b=IwkTcbYkWcrz4nx1OMbQbLpYvLwMHcx0+h5airTn0zn3ZNuQ4KD1uB2Lyor4Z3x1bDS0vxjcgI+SCoIVFu73J7LK7evQ8zHHU/9nOhgrGNbz1mg+sFjztDYkYLjcKfbVWBsQPQK3YS9xfhb4ZwzwPQ/P9kvU/bAHGKv5CnhBe1urr+mBgoV/YW2lDgKYOsVfkp6pGE2n6ja8NUd9SQdag+8Fmc1PWBBsHaTIYfu/Lmjf4ugDf9GbIZbMNBTmWIxXCfFsbsHpWvgEbdJhJ4vpILCf+M97o/0RUE7lQyaJ38RcJ8W9h4FlADRnrhvkX69ubbvqbDaD+bTQPwA11jmi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSV6ncxnz6DvqPHj5SOA0jKfQTe8mUvU4eVsUJv9lDg=;
 b=V37bw1BrOBRTrUH+bkp7MSc80T+MKIlCh89cOMX3LMOcYj9J7ZbnxDTXlwk4LTHPKQCP9++RoqUw3CeHNs9Ysd9BDGvkH8IRh73LzBFhM6FhxrafubiuvMibu3Sgpz+NOPH5onDMKZ1SIaJo9HpGdDVH4EJG3xy0Ob0OI20PCFU=
Received: from CO2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:102:2::30)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 12:01:09 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::d5) by CO2PR05CA0062.outlook.office365.com
 (2603:10b6:102:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:08 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:03 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v3 04/16] drm/amdkfd: CRIU Implement KFD dumper ioctl
Date: Wed, 29 Sep 2021 08:00:26 -0400
Message-ID: <20210929120038.6485-5-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b53dea5f-846f-4094-1ccd-08d98340d2c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4234:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4234E0598DC84E8C7589E6F795A99@DM6PR12MB4234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5omUsagt5NCWSdJRNns0x0I1EA6gERrnvBfVwnjFAILBIacwpFv/HkaKhs5EkKGbDLkOh9/WH/x9ljqALUBuvszoTpD1HYqZ7xJuRvDNEpKaV1sTo4v0zWzspsg/ZOsZ/1hU1Gur+F8fu/nyr21fjka0AgzqICShzeky1pAZ/DhlCvwYPuS1CoaDk9XB4CCqM3OyL3QyTjHEWO7NJYocVGRnWa8gPiguAf8bjOkOskE+MhPiM2ES2Ls9dajTKt7N0sI/uyR80CMUWRT8zHJlDiSeE+Ek8IdApxxg1QEy3Yvn/3zYZpXPd+Kk6/gH/ApCWLDkwSb1pPB+W1KeRVFbt5am3R+66+kFOHRf0/Ml4qz6YiNfrIqT+wxUEyQLT9UD1hnlkC5s6XSW43WKQ72dJiHs7Ju7Gk3BnNmtLOQDQ6UUT+gQyUcT8RGP+mdYpB6ZmOlEgDoJJDHEvWsk/la4EgAPY6tUOxx4zv3uKdz+Ipj9XHVz4rzKgltBhmbFMWZTSrTM+IqdjyjSpPaBAsFT0lYGW1jF6iJAbbFStW7Ld1obj+XjU5rBC6M+EKPfMAZWAvpvHxXe2pU077p0CiBK/riIutui1DWJ2K4NfFtg0czlXCsNEmJQnhFekI/9In4TZtft1a5mO1rEn/DSVRwKwnLmKNKE6vGfxmbjmUtwsu8i31bJqMtshjI8dwBurqQ+u/MLB/qTh37oRenTgwmatK1waVtqFp5lAqJUf20ygas=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(26005)(8676002)(83380400001)(186003)(16526019)(8936002)(1076003)(47076005)(82310400003)(6916009)(70206006)(70586007)(6666004)(5660300002)(81166007)(356005)(36756003)(54906003)(7696005)(316002)(4326008)(2616005)(426003)(336012)(86362001)(508600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:08.5506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53dea5f-846f-4094-1ccd-08d98340d2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This adds support to discover the  buffer objects that belong to a
process being checkpointed. The data corresponding to these buffer
objects is returned to user space plugin running under criu master
context which then stores this info to recreate these buffer objects
during a restore operation.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  20 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 188 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   3 +-
 4 files changed, 211 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e2896ac2c9ce..5d557180cd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1160,6 +1160,26 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 	return ttm_pool_free(&adev->mman.bdev.pool, ttm);
 }
 
+/**
+ * amdgpu_ttm_tt_get_userptr - Return the userptr GTT ttm_tt for the current
+ * task
+ *
+ * @tbo: The ttm_buffer_object that contains the userptr
+ * @user_addr:  The returned value
+ */
+int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
+			      uint64_t *user_addr)
+{
+	struct amdgpu_ttm_tt *gtt;
+
+	if (!tbo->ttm)
+		return -EINVAL;
+
+	gtt = (void *)tbo->ttm;
+	*user_addr = gtt->userptr;
+	return 0;
+}
+
 /**
  * amdgpu_ttm_tt_set_userptr - Initialize userptr GTT ttm_tt for the current
  * task
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e69f3e8e06e5..a7c0e6372339 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -177,6 +177,8 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 #endif
 
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
+int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
+			      uint64_t *user_addr);
 int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			      uint64_t addr, uint32_t flags);
 bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1906ded40698..cc3d8fd1d26f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -42,6 +42,7 @@
 #include "kfd_svm.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_object.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1841,6 +1842,44 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return -EPERM;
 }
 #endif
+static int criu_dump_process(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
+{
+	int ret;
+	struct kfd_criu_process_bucket *process_bucket;
+	struct kfd_criu_process_priv_data *process_priv;
+
+	if (args->num_objects != 1) {
+		pr_err("Only 1 process supported\n");
+		return -EINVAL;
+	}
+
+	if (args->objects_size != sizeof(*process_bucket) + sizeof(*process_priv)) {
+		pr_err("Invalid objects size for process\n");
+		return -EINVAL;
+	}
+
+	process_bucket = kzalloc(args->objects_size, GFP_KERNEL);
+	if (!process_bucket)
+		return -ENOMEM;
+
+	/* Private data starts after process bucket */
+	process_priv = (void *)(process_bucket + 1);
+
+	process_priv->version = KFD_CRIU_PRIV_VERSION;
+
+	process_bucket->priv_data_offset = 0;
+	process_bucket->priv_data_size = sizeof(*process_priv);
+
+	ret = copy_to_user((void __user *)args->objects, process_bucket, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy process information to user\n");
+		ret = -EFAULT;
+	}
+
+	kfree(process_bucket);
+	return ret;
+}
+
 uint64_t get_process_num_bos(struct kfd_process *p)
 {
 	uint64_t num_of_bos = 0, i;
@@ -1861,10 +1900,157 @@ uint64_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
+static int criu_dump_bos(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
+{
+	struct kfd_criu_bo_bucket *bo_buckets;
+	struct kfd_criu_bo_priv_data *bo_privs;
+	uint64_t num_bos;
+
+	int ret = 0, pdd_index, bo_index = 0, id;
+	void *mem;
+
+	num_bos = get_process_num_bos(p);
+
+	if (args->num_objects != num_bos) {
+		pr_err("Mismatch with number of BOs (current:%lld user:%lld)\n",
+				num_bos, args->num_objects);
+		return -EINVAL;
+	}
+
+	if (args->objects_size != args->num_objects * (sizeof(*bo_buckets) + sizeof(*bo_privs))) {
+		pr_err("Invalid objects size for BOs\n");
+		return -EINVAL;
+	}
+
+	bo_buckets = kvzalloc(args->objects_size, GFP_KERNEL);
+	if (!bo_buckets)
+		return -ENOMEM;
+
+	/* Private data for first BO starts after all bo_buckets */
+	bo_privs = (void *)(bo_buckets + args->num_objects);
+
+	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
+		struct kfd_process_device *pdd = p->pdds[pdd_index];
+		struct amdgpu_bo *dumper_bo;
+		struct kgd_mem *kgd_mem;
+
+		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
+			struct kfd_criu_bo_bucket *bo_bucket;
+			struct kfd_criu_bo_priv_data *bo_priv;
+
+			if (!mem) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+
+			kgd_mem = (struct kgd_mem *)mem;
+			dumper_bo = kgd_mem->bo;
+
+			if ((uint64_t)kgd_mem->va <= pdd->gpuvm_base)
+				continue;
+
+			bo_bucket = &bo_buckets[bo_index];
+			bo_priv = &bo_privs[bo_index];
+
+			bo_bucket->addr = (uint64_t)kgd_mem->va;
+			bo_bucket->size = amdgpu_bo_size(dumper_bo);
+			bo_bucket->gpu_id = pdd->dev->id;
+			bo_bucket->alloc_flags = (uint32_t)kgd_mem->alloc_flags;
+
+			bo_bucket->priv_data_offset = bo_index * sizeof(*bo_priv);
+			bo_bucket->priv_data_size = sizeof(*bo_priv);
+
+			bo_priv->idr_handle = id;
+			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+				ret = amdgpu_ttm_tt_get_userptr(&dumper_bo->tbo,
+								&bo_priv->user_addr);
+				if (ret) {
+					pr_err("Failed to obtain user address for user-pointer bo\n");
+					goto exit;
+				}
+			}
+			if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
+				bo_bucket->offset = KFD_MMAP_TYPE_DOORBELL |
+					KFD_MMAP_GPU_ID(pdd->dev->id);
+			else if (bo_bucket->alloc_flags &
+				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
+				bo_bucket->offset = KFD_MMAP_TYPE_MMIO |
+					KFD_MMAP_GPU_ID(pdd->dev->id);
+			else
+				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
+
+			pr_debug("bo_size = 0x%llx, bo_addr = 0x%llx bo_offset = 0x%llx\n"
+					"gpu_id = 0x%x alloc_flags = 0x%x idr_handle = 0x%x",
+					bo_bucket->size,
+					bo_bucket->addr,
+					bo_bucket->offset,
+					bo_bucket->gpu_id,
+					bo_bucket->alloc_flags,
+					bo_priv->idr_handle);
+			bo_index++;
+		}
+	}
+
+	ret = copy_to_user((void __user *)args->objects, bo_buckets, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy bo information to user\n");
+		ret = -EFAULT;
+	}
+
+exit:
+	kvfree(bo_buckets);
+	return ret;
+}
+
 static int kfd_ioctl_criu_dumper(struct file *filep,
 				struct kfd_process *p, void *data)
 {
-	return 0;
+	struct kfd_ioctl_criu_dumper_args *args = data;
+	int ret;
+
+	pr_debug("CRIU dump type:%d\n", args->type);
+
+	if (!args->objects || !args->objects_size)
+		return -EINVAL;
+
+	if (args->objects_index_start != 0) {
+		/* Partial to be implemented later */
+		pr_err("Partial dumps not supported\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&p->mutex);
+
+	if (!kfd_has_process_device_data(p)) {
+		pr_err("No pdd for given process\n");
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	switch (args->type) {
+	case KFD_CRIU_OBJECT_TYPE_PROCESS:
+		ret = criu_dump_process(p, args);
+		break;
+	case KFD_CRIU_OBJECT_TYPE_BO:
+		ret = criu_dump_bos(p, args);
+		break;
+	case KFD_CRIU_OBJECT_TYPE_QUEUE:
+	case KFD_CRIU_OBJECT_TYPE_EVENT:
+	case KFD_CRIU_OBJECT_TYPE_DEVICE:
+	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
+	default:
+		pr_err("Unsupported object type:%d\n", args->type);
+		ret = -EINVAL;
+	}
+
+err_unlock:
+	mutex_unlock(&p->mutex);
+	if (ret)
+		pr_err("Failed to dump CRIU type:%d ret:%d\n", args->type, ret);
+	else
+		pr_debug("CRIU dump type:%d ret:%d\n", args->type, ret);
+
+	return ret;
 }
 
 static int kfd_ioctl_criu_restorer(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 914306209c9c..5940d594b420 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1042,7 +1042,8 @@ struct kfd_criu_device_priv_data {
 };
 
 struct kfd_criu_bo_priv_data {
-	uint64_t reserved;
+	uint64_t user_addr;
+	uint32_t idr_handle;
 };
 
 struct kfd_criu_svm_range_priv_data {
-- 
2.17.1

