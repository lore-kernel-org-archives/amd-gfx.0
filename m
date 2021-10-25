Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F8160FBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 10:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F8160FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE4089CD9;
	Mon, 25 Oct 2021 10:01:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300C289CD9
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 10:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeCc+92Ofo9IXYZo01bkYyvk2GGE4mMqc+vzqTWBMRBYXey9jrrxZVIInl2kmoCPlRKon/B7zY9pG7UIC3eqeabLAyn7MUOKpsastsLd+IazTVUpZ7XzKMd1SwR4t48o0kMqU4fWzbaps7NxUteZX+8hUcE0kkcQRkFEosS091DfsOgav0yMicYoPaw6P1BRw3iBx/8M9yRWlkhlLnoXcKWRFrka6sjYj75X5o9Xdb5xF+d9jdD/JziqmLEbHtsrYSNY5heY6B7LQ7sn+9heQJ3hFPhmIy0ById4AuEUH1HD1Pz4R+/pcQLeGAna8UjdSDgHPfwK4TtwQ7mAJjAGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUALu2g+rh1CGNSO3VlE9fU7jb2lDT/yFjWnc5/ktHc=;
 b=RgegNOetN5QiyBXDSItBQVZASyWa569bNz1E2qhYQZUlBBP43qTk+fgiW3wTFNWovR/zaQo5QJ9+AJgngMEoY2nYCRdQNeqe/GQbU0osVIttLRaG2LHMhapFQjHDLDx9Ot3fbzoaDLkg9Y9Hj9MTbjgRFcGG1NNEk9equrq+CavccrDBBZ9MJmEGBeR9RQwXqm0keJzAFjEQVLQaaG7Y4R3WQTXFxB7KC9KDRVCkr0hWt3KcqWHoj4yieQspQtRsIQ6OXGYBr3oKvdA+lLL6jO939G55hCVGCIyezYVuHMvJEF3HMR6KJ6am4l3mdeXBqS3/v/8xFmh3adKWWVH5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUALu2g+rh1CGNSO3VlE9fU7jb2lDT/yFjWnc5/ktHc=;
 b=GF/z+hSVj5YpUEBz0cDUM0KvIi9LuNJ8kMEkzOjuT6ZN8KRWcPXsOlVmQXaf4J1KO6HrZL7dRE4rmpbxPpFe7e+1Dly1CeQsewop5sTKdfdlBvibXDkn/Ra8Z0A4ABa+dAoaQIQviaDfIqrkqccLOYdlodlgodMJ4FlI2hSieXI=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 10:01:09 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::e6) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 10:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 10:01:08 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 05:01:05 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Remove cu mask from struct
 queue_properties(v2)
Date: Mon, 25 Oct 2021 17:58:22 +0800
Message-ID: <20211025095822.207721-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025095822.207721-1-lang.yu@amd.com>
References: <20211025095822.207721-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86800ccb-d9ec-4c5c-259f-08d9979e5e02
X-MS-TrafficTypeDiagnostic: CY4PR12MB1158:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1158EF9E482A1D4E7F7BA474FB839@CY4PR12MB1158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mAloKM/IVUl5uqOLiLwExPRN2BZdRwWW8fHDrIvA3/49KgwMeGHeEyfByxwNyLM1WfotWnySSwslf5TR87EGoxPlhyR/eNTYm00+tLRcKwRPTVaB89F/cVEKRtx2GWcYriHG75LvlbD7WCDOVw5aZKv9+tWAdRFwLdNookvokJpR8X0A3+IY8w8g39NhIQ8xc+1+0vRdo+KdcXMt4jg7lvK5djTgPUtQq48/SoHrwbrFs2mpZVg1hPlVfz7eiarYIiyoAjoK/ny2WY61tCzYdaIuo6I/hcFCtsT3NN3hzY6f0AQ5VhYD+Zw7hVXWH8iKoYAbcrXLIWt/l2c0Zo6H+eNrKOVGxtt1a0247P98cz4VOZkWqx4wjoG+qBAj6W3hHGeY2+dNWbZxGplijKYF/nm99R96hMCUXD/oAkfMjiv3//eshE1jdW34dRsRG6mIXPGC/V/RlJnzad4CuFFcnP99QjsIiVBfmsqybCqr/SoMi9Ahv+pTs9nXS/Qe1L+0gPUWWNNgquRbEoE3O5uO1MKAxb+qfoOjH+ObECjZ4E1dUYjN3grK0CeC29rVGqgdV9PEXzZ05X0monj+o+Om6v8rsVFQJB5vA8wlF5EA4QtTgnx8t3RPO7iBBRd/QjgVA80XVMeh4RlnRY0r/3Jo4EmDk9v0A6+aDTfwYbpzv/y59z3Pdws9YhScdZTU8u4MkL5QLXqNGbwKz8jnBn14F5qwNk2RRc9DSD46Y36KRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(83380400001)(36756003)(86362001)(8676002)(47076005)(36860700001)(44832011)(6666004)(70206006)(336012)(7696005)(70586007)(508600001)(82310400003)(4326008)(2616005)(54906003)(8936002)(81166007)(110136005)(30864003)(186003)(6636002)(5660300002)(16526019)(316002)(26005)(356005)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 10:01:08.5832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86800ccb-d9ec-4c5c-259f-08d9979e5e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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

Actually, cu_mask has been copied to mqd memory and
does't have to persist in queue_properties. Remove it
from queue_properties.

And use struct mqd_update_info to store such properties,
then pass it to update queue operation.

v2:
* Rename pqm_update_queue to pqm_update_queue_properties.
* Rename struct queue_update_info to struct mqd_update_info.
* Rename pqm_set_cu_mask to pqm_update_mqd.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 31 ++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  9 +++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  9 +++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  9 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 23 +++++++++-----
 .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++---------
 8 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9317a2e238d0..24ebd61395d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -405,7 +405,7 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 
 	mutex_lock(&p->mutex);
 
-	retval = pqm_update_queue(&p->pqm, args->queue_id, &properties);
+	retval = pqm_update_queue_properties(&p->pqm, args->queue_id, &properties);
 
 	mutex_unlock(&p->mutex);
 
@@ -418,7 +418,7 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 	int retval;
 	const int max_num_cus = 1024;
 	struct kfd_ioctl_set_cu_mask_args *args = data;
-	struct queue_properties properties;
+	struct mqd_update_info minfo = {0};
 	uint32_t __user *cu_mask_ptr = (uint32_t __user *)args->cu_mask_ptr;
 	size_t cu_mask_size = sizeof(uint32_t) * (args->num_cu_mask / 32);
 
@@ -428,8 +428,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
-	properties.cu_mask_count = args->num_cu_mask;
-	if (properties.cu_mask_count == 0) {
+	minfo.cu_mask.count = args->num_cu_mask;
+	if (minfo.cu_mask.count == 0) {
 		pr_debug("CU mask cannot be 0");
 		return -EINVAL;
 	}
@@ -438,32 +438,33 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 	 * limit of max_num_cus bits.  We can then just drop any CU mask bits
 	 * past max_num_cus bits and just use the first max_num_cus bits.
 	 */
-	if (properties.cu_mask_count > max_num_cus) {
+	if (minfo.cu_mask.count > max_num_cus) {
 		pr_debug("CU mask cannot be greater than 1024 bits");
-		properties.cu_mask_count = max_num_cus;
+		minfo.cu_mask.count = max_num_cus;
 		cu_mask_size = sizeof(uint32_t) * (max_num_cus/32);
 	}
 
-	properties.cu_mask = kzalloc(cu_mask_size, GFP_KERNEL);
-	if (!properties.cu_mask)
+	minfo.cu_mask.ptr = kzalloc(cu_mask_size, GFP_KERNEL);
+	if (!minfo.cu_mask.ptr)
 		return -ENOMEM;
 
-	retval = copy_from_user(properties.cu_mask, cu_mask_ptr, cu_mask_size);
+	retval = copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask_size);
 	if (retval) {
 		pr_debug("Could not copy CU mask from userspace");
-		kfree(properties.cu_mask);
-		return -EFAULT;
+		retval = -EFAULT;
+		goto out;
 	}
 
+	minfo.update_flag = UPDATE_FLAG_CU_MASK;
+
 	mutex_lock(&p->mutex);
 
-	retval = pqm_set_cu_mask(&p->pqm, args->queue_id, &properties);
+	retval = pqm_update_mqd(&p->pqm, args->queue_id, &minfo);
 
 	mutex_unlock(&p->mutex);
 
-	if (retval)
-		kfree(properties.cu_mask);
-
+out:
+	kfree(minfo.cu_mask.ptr);
 	return retval;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index a2b77d1df854..64b4ac339904 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -136,7 +136,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 	prop.write_ptr = (uint32_t *) kq->wptr_gpu_addr;
 	prop.eop_ring_buffer_address = kq->eop_gpu_addr;
 	prop.eop_ring_buffer_size = PAGE_SIZE;
-	prop.cu_mask = NULL;
 
 	if (init_queue(&kq->queue, &prop) != 0)
 		goto err_init_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 00bcaa11ff57..8128f4d312f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -42,16 +42,17 @@ static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct mqd_update_info *minfo)
 {
 	struct cik_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
 
-	if (q->cu_mask_count == 0)
+	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !minfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -215,7 +216,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_pq_control |= NO_UPDATE_RPTR;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 7f1101780135..270160fc401b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -42,16 +42,17 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			   struct queue_properties *q)
+			struct mqd_update_info *minfo)
 {
 	struct v10_compute_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
 
-	if (q->cu_mask_count == 0)
+	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !minfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -219,7 +220,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->cwsr_enabled)
 		m->cp_hqd_ctx_save_control = 0;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 152f29b28a79..4e5932f54b5a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -43,16 +43,17 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct mqd_update_info *minfo)
 {
 	struct v9_mqd *m;
 	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
 
-	if (q->cu_mask_count == 0)
+	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !minfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -270,7 +271,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->cwsr_enabled && q->ctx_save_restore_area_address)
 		m->cp_hqd_ctx_save_control = 0;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 4a8f3a06e6df..cd9220eb8a7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -45,16 +45,17 @@ static inline struct vi_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct mqd_update_info *minfo)
 {
 	struct vi_mqd *m;
 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
 
-	if (q->cu_mask_count == 0)
+	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
+	    !minfo->cu_mask.ptr)
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		q->cu_mask, q->cu_mask_count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
@@ -230,7 +231,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
 			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
 
-	update_cu_mask(mm, mqd, q);
+	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d758a57b17e2..4104b167e721 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -472,9 +472,6 @@ struct queue_properties {
 	uint32_t ctl_stack_size;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
-	/* Relevant for CU */
-	uint32_t cu_mask_count; /* Must be a multiple of 32 */
-	uint32_t *cu_mask;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
@@ -482,7 +479,19 @@ struct queue_properties {
 			    (q).queue_percent > 0 &&	\
 			    !(q).is_evicted)
 
-struct mqd_update_info;
+enum mqd_update_flag {
+	UPDATE_FLAG_CU_MASK = 0,
+};
+
+struct mqd_update_info {
+	union {
+		struct {
+			uint32_t count; /* Must be a multiple of 32 */
+			uint32_t *ptr;
+		} cu_mask;
+	};
+	enum mqd_update_flag update_flag;
+};
 
 /**
  * struct queue
@@ -1036,10 +1045,10 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    unsigned int *qid,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
-int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p);
-int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
+int pqm_update_queue_properties(struct process_queue_manager *pqm, unsigned int qid,
 			struct queue_properties *p);
+int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int qid,
+			struct mqd_update_info *minfo);
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 			void *gws);
 struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *pqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 37529592457d..3627e7ac161b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -394,8 +394,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			pdd->qpd.num_gws = 0;
 		}
 
-		kfree(pqn->q->properties.cu_mask);
-		pqn->q->properties.cu_mask = NULL;
 		uninit_queue(pqn->q);
 	}
 
@@ -411,8 +409,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	return retval;
 }
 
-int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p)
+int pqm_update_queue_properties(struct process_queue_manager *pqm,
+				unsigned int qid, struct queue_properties *p)
 {
 	int retval;
 	struct process_queue_node *pqn;
@@ -436,8 +434,8 @@ int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
 	return 0;
 }
 
-int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
-			struct queue_properties *p)
+int pqm_update_mqd(struct process_queue_manager *pqm,
+				unsigned int qid, struct mqd_update_info *minfo)
 {
 	int retval;
 	struct process_queue_node *pqn;
@@ -448,16 +446,8 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 		return -EFAULT;
 	}
 
-	/* Free the old CU mask memory if it is already allocated, then
-	 * allocate memory for the new CU mask.
-	 */
-	kfree(pqn->q->properties.cu_mask);
-
-	pqn->q->properties.cu_mask_count = p->cu_mask_count;
-	pqn->q->properties.cu_mask = p->cu_mask;
-
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
+							pqn->q, minfo);
 	if (retval != 0)
 		return retval;
 
-- 
2.25.1

