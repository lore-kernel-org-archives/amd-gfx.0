Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E08C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5ED610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E5ED610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AE56E951;
	Thu, 19 Aug 2021 13:37:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9658B6E94A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOBSETo/HLnu0NCH2CZ74jUaZEd6CSPy1ciBONf9kAnqybj+D2shlZMXuorvpPJeIYXKVgC1nms2dpWVN0c9+v+1DbbPA1HkLmsrL23aJrTFJXa6vIZExpspSfBdvNPiOiCuj/YV9D0C+Ub8bDtaPleiEfpMGMzQ571tGJat7aw7npwWuysDJYVMAGXr2NG2G4CY9TfM4gghtOekbF4HWDSNuzAql+kF40U7QLjTi7H4aTupUdqckBlk7PDA7OYcuULmGPjnH7VXP/g3aeF0MbO2ngYXFx9Vfh4N2T8plEoJf+khDpHchu+/skRXC+52GSumPExrOPu/Pp7vXInhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8Y9h78tz1g/l5egFWeT61WJph7v8Ia88KncmE1MqvE=;
 b=lIbF7Y9DA0lylS5irfL2+HQDjCHfS5xdPY9fFgkaJPVQNlrm3jjXWsF2L8DK8r2kwWJ2VVE1l2dS8GufD6lnTlqhI7kNJSMz0E5mNWaAVEstH8j2JGpYADxLNlI3K4iIxrqflUcWUr/iKsr45VMeSWHFlttWuQjXXqX59RE2Xy43c21Ax2hbG3HjgXEEMIZf8KUNOzj3WkCVbWzhbbAyTv6xcOuIJpXL2QnXQubYrxLi9wts4aztdMsdN6WubvmSk5tcdFINOdhVqBKA9mtQhTXMtNt3lx0Nx9d6ugpl699Ld4oh59cww8+C0BFmYGDJ6t7sZFckvIdVfUdUaSrh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8Y9h78tz1g/l5egFWeT61WJph7v8Ia88KncmE1MqvE=;
 b=RLOimdBvrH6nrB0StO3Ys5mt8KnqiML3xl4wK2Ubeeft3gmRUVoYC2DW3Ajus/finIa0Se5fUnaWHyKkdJNswckjwBU68r3bP2+MBfUBSkVe0uTnJGMEUWnB4Bfk1BDL9u1T2yJQWvYmjf2StBvwYdHMIAJyYJjL8o+s5Teztm4=
Received: from MWHPR2201CA0057.namprd22.prod.outlook.com
 (2603:10b6:301:16::31) by BN6PR12MB1395.namprd12.prod.outlook.com
 (2603:10b6:404:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 13:37:50 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::80) by MWHPR2201CA0057.outlook.office365.com
 (2603:10b6:301:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:49 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:48 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 05/18] drm/amdkfd: CRIU Implement KFD dumper ioctl
Date: Thu, 19 Aug 2021 09:37:00 -0400
Message-ID: <20210819133713.4168-6-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47381168-6e37-40cc-f5d0-08d96316899b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1395:
X-Microsoft-Antispam-PRVS: <BN6PR12MB139563B13E40BBCEAD8BC31F95C09@BN6PR12MB1395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkVGSkXhIHwLbtrc7WjZR01Eyf/zfpXeodp2D4NzCtA95apsQqGEAG4drc18lwsmcYcJ0OG401kN8aWEJNBT5rX1KvSoFg6oQ7a+ZQQqPKipI+nFocTAeSC3woh2kAS6ly7gtHWES9tvWmuwTY6sDfePNWpIkt39PYEivdDKtp+RAMo/QgpsEJAoHaUhvUvUbNeJQneacptQFSRPtEM38rgNGQzXDmVcbTLcoGpHp94ncPR2SCGhbQGPMiFzlrXbV/FfwM3YuhtdRVYQvK/89q9EdSWx/39KpQjX2ZJeoIt1oRuV4tdpL8ip96b/rOtXBExJYMSO9JwEhfxrgsxYxk/BY+DDIyNBWaQ1s01HDfvNmlJB3lvTFvdg3d0JvvilJLQu+LDUcxbkBOMabavmzWps2PmFLNChvhFTgIlCEAr/QJ5SYO3FmCE+wMly0xIWuj/wRITb9ySYtdoe2BrMmoE4sdrB2oFtCMPzpphk3RsXfkXyqCNSKNEq+ZLSqboyCtU8HAzxz/UEollKdvu9eEivUDZwO2TNf5CgILyerYI598eIwBfl0hqPaT2Yj1IwAFWUhdLvnMC70VwRdwcYeCgl9AT567X+beZY/nXbrCPfP7ivFYn1caXD33OXoktnbC9CvAlprMjbrTKpolybHKO7lDWikRA2JlENkL0pXCdiewnt5D9vKAfEI69frSsva9AjuaPe3cYkmC63Fe1TKrZbrvB1JAm1AJHNKw4H3olkaLAt9q8Il4I1MtEjadR2AsJLXfRSVyVpdIsowEV/Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(16526019)(26005)(36860700001)(7696005)(82310400003)(336012)(186003)(8936002)(426003)(2616005)(5660300002)(86362001)(8676002)(6666004)(6916009)(356005)(70206006)(82740400003)(81166007)(54906003)(36756003)(2906002)(47076005)(4326008)(478600001)(83380400001)(34020700004)(1076003)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:49.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47381168-6e37-40cc-f5d0-08d96316899b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1395
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
(cherry picked from commit 1f114a541bd21873de905db64bb9efa673274d4b)
(cherry picked from commit 20c435fad57d3201e5402e38ae778f1f0f84a09d)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  20 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 182 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   3 +-
 4 files changed, 204 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7e7d8330d64b..99ea29fd12bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1181,6 +1181,26 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
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
index 9e38475e0f8d..dddd76f7a92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -168,6 +168,8 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 #endif
 
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
+int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
+			      uint64_t *user_addr);
 int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			      uint64_t addr, uint32_t flags);
 bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 09e2d30515e2..d548e6691d69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -42,6 +42,7 @@
 #include "kfd_svm.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_object.h"
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
@@ -1804,6 +1805,44 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
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
@@ -1824,12 +1863,151 @@ uint64_t get_process_num_bos(struct kfd_process *p)
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
-	pr_debug("Inside %s\n", __func__);
+	struct kfd_ioctl_criu_dumper_args *args = data;
+	int ret;
 
-	return 0;
+	pr_debug("CRIU dump type:%d\n", args->type);
+
+	if (!args->objects || !args->objects_size)
+		return -EINVAL;
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
index 4e390006b4b6..8c9f2b3ac85d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1031,7 +1031,8 @@ struct kfd_criu_device_priv_data {
 };
 
 struct kfd_criu_bo_priv_data {
-	uint64_t reserved;
+	uint64_t user_addr;
+	uint32_t idr_handle;
 };
 
 struct kfd_criu_svm_range_priv_data {
-- 
2.17.1

