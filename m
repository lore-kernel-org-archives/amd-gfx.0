Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60B661220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C60B661220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F42389170;
	Tue, 24 Aug 2021 19:39:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D23889170
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6uLBTmt6U49SwQ0DCOHXQbZnCbg0t+JiuCQnOXCGg7f4z2deGwijtLZOuVfyCcP1Vj2DsFJC46coS8ChzorA1S3nF+EG5WDuqO+jR6N6qKjOBqtoJMTglR/R71gwg2WQsXKVQX7sCW/Pyf2GGQ/aX8IVXMw3L9bR4f7em1YZkv6XW3oC+3yqY0Owd+Ukk7is6XtDnL5Drhy8YU5BzCan3myQNhKFGCDWTZtGoUoUc/5MK4Ocuzw5dzhlF+0kEYDK4fkKeeosZcI0R36w8zBZxYVLkaCcJ88Ai2NHvBQrMO5QerxnGh736WvCsZ6dAO7Dy5/mgOEoWJ1sQ7/Daq7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnCVmGghRoGcmGGBLDM7avWfuXe+41KuH55dpuLQLFU=;
 b=ZDpfo13T5DLytyHSSrli8L/K46KADlU16frWEcFGLWDtUq+jyZEzWc1x22UMyY6ItrNGTk1m2+SljIRmfKuRHAGl4ablAY3qIrXjs2Uns/+b3ry9q7YazNvYvhxXk46rJL/zX8dyVG+DDsQ6/v/kQMe4+PYdu2teOUGicovIRnO6K0ea7MXobFFzhd4v3zG1JP7wF64tJLcy5U+8DrT9SNZ2gbSS1QewdaEtmW/FpFsi2qBFLnyRBdxs4sHgdlERgqEPyvQq4Qeq3o3N7GH+5NaRcR+Ios0jvHbMR19eJBqL7tF8B8SbvIcFPou3fo9LTxB5fubuq+TlLqDRQm4avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnCVmGghRoGcmGGBLDM7avWfuXe+41KuH55dpuLQLFU=;
 b=jMoQzzeex5hBUBEXFimoiHJ0HQdv402H23Ys6xQH/hEal07vZlSr5P7t4CRqX4cDKTjwnxm8s8mWsSj7r4Ha5tealE9HQ43O0Iu90CLvgB5jKSaupqq9nsW3k4lVYNM2NU6i8UPJXuvhJZ3cLrnZgmpcn3/vtmBok1LmSkpOdjo=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 19:07:36 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ed) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:36 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:32 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 05/18] drm/amdkfd: CRIU Implement KFD dumper ioctl
Date: Tue, 24 Aug 2021 15:06:26 -0400
Message-ID: <20210824190639.6288-6-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17cc091-3fac-4717-0eb9-08d967326f77
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121C69D8B8E4E1F546A1F0B95C59@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JCnuOZittWF6Lmk1hChdpjTznhEOOjSFfZRr2C4ZoJKf8VhL5l6oxxAFXVCUeXlFBEIZV6OMz+6j0nxlTDgbBNxW6MtfWbBpBJxc7WP/I//T/T2rgHhPgLzqzFSt8FadrWnjmmnzcq7CiSkOLWAH8BjPER0HfjVGzA/E5c80AUfVeagE2qHv1BE7TUubTJ7p4nVx2Tmyua0qDXL5GdvVQsiJMfENX8RQWRIVFNfROZJGR0NFc8FSrizZaBXuTW49f8NycUVK2dtWNxGgl7bXcwOsorDtSDnSAhRUQnFvbEXxsE9Roqg6eQ7hnXLmnDdNzW8WbnJiTGsRr4gdZwirmroFey5q3t6CvEbMCIxbkv/niQb4v8bxBMzslPrx8RfS4cAUFSTnYmhaxfruWK/13Mjiez3JrLMzPEq2+kGP8KWGcnLDB1uuvAVW1uBQnjDxKKLygEcaO4xu3zg4icFknzf/6YB6xxT+qsCMP0nG+CCoEeP0EdCakF6ydo/iv2gsQ/G2GkB8zuCHkGNc1jT7Ho1uXHMovRirbAYexQxw9iRYhBkQK51XkWg2pfY1CTphrr5t4rFcuZGlaPN1U8SeSmwF8SEFJLC9qqko7N/wcjdcWjVTYDz9sSHNxXlRStEw3Lbge1G0Upu6TaUxKAj2WYdrRtM/VFg8v8979JreYn5X7r4P8LomFCTgCIqc7uL+ObucYYXjeGvgGVOLXVtIkELlWmfoPeZcUvhYI9YXvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(5660300002)(426003)(4326008)(83380400001)(82310400003)(36860700001)(70206006)(70586007)(356005)(82740400003)(54906003)(2616005)(316002)(36756003)(7696005)(6916009)(47076005)(16526019)(186003)(86362001)(8676002)(336012)(6666004)(2906002)(81166007)(26005)(1076003)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:36.4665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17cc091-3fac-4717-0eb9-08d967326f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 188 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   3 +-
 4 files changed, 210 insertions(+), 3 deletions(-)

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
index 09e2d30515e2..40efc80f3604 100644
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
@@ -1824,12 +1863,157 @@ uint64_t get_process_num_bos(struct kfd_process *p)
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

