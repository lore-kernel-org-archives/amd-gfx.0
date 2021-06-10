Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A168C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 23:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D52B613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 23:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D52B613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DC66EE14;
	Thu, 10 Jun 2021 23:29:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F3A6EE14
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 23:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtNyJYbvn3mujS0Tu4o/LMrLQR1hjlelD1KzatzpYAs/fnyEyXFU8VXQ/QDInD7RNxYgwhlHuk44cEmGG7DfkMt+SaqaciR5J8HBst2tvTL7km16Buh2Dv2NhJkhYlhq+jhnkYNHuxtdAowaakRPy2omFNbXtt1WmhUi0a0VhFuYqst4gWPSCAtxlyYoGonQ7I0acvVo68VNeGcgrj4xZhsy4m3HLfao0sbYFIwh1lgfw5qHLXKzFclLHpAfZwRE9KoiT9sGACk/FjpUaYcR7EUio81qMWTU3yUjLBp1ZLxE4RkyQcBgmEu6RDlXGAonszdwiEW+HoNdoHQhVcoKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Tm+h6ZHHFPyOpQd9vaj8LV6F070l35/rJ3SfgkyvY=;
 b=jkhb4qsjeLiqBxyAkAOBk2ZPCFOIx9GdtcNHdgBKGYcy0BFCuB+7YmfqiiXzRiC5ok6dnBY7ZCij8+qs9qm8KwWTajGm7fRS/vmHUTB8ffdic6pMkU8k/WGV/7C79p41ksGpX10w70XGUk8CO06S3cCMmyCCMZ1tWrky/yBdYfQSVAFXb+fR5bTWtZfjCTEVR7BWnG0/Z9MdWUmMxUdBv69k4R8Co3JJjhwRGrJ3hmiD8k5BEsUbsFYh0L46zNRSSRk8mHRcP254qCJucm7RG5pj13k85hn/hOQTiUmbb4Y4MwQYzdvhaBXATT0GvHbvWpc5tZMYIun60Yu/eA3wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Tm+h6ZHHFPyOpQd9vaj8LV6F070l35/rJ3SfgkyvY=;
 b=q9ip5LmlxRNOSPqmYcY3ILVk9AxD3bj2tXzr1R8MaF2xRzFvIyYwz4ASdnU7CVYWBO4n6V8qo/v3WKebtLcclShEqzWjWoy+nNX/DAaA6Q/YivkTJIShEm+CmG2Jw1S63pI5KtTp1zB38ftlryZah5++rso9PLVIy/4NhHtx7eE=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 23:29:39 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::36) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 23:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 23:29:38 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 18:29:38 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Disable SVM per GPU, not per process
Date: Thu, 10 Jun 2021 19:29:16 -0400
Message-ID: <20210610232916.23748-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcedab85-7d2e-4fa9-abb8-08d92c679dbb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4925FE8C56D524DCDE3E1D8392359@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCvonG3T7vjojHambpA5BkpWThA0vHHSknFktyXq04LiJhq0ZS6bdTzGyg2KhWHWZ+D/DqOoMLljHbfCYdR/T+c1lXTXhz3V7DStVQM5ysJQyXdKy+afeQCtx4vN3lik5mNkiJHj+Z3/LVd2wz42SYYz465I6tPoyd91pi2S6hnhoyzGfomTPyvcZkTZWnJIwoe3nYEk1Evl+UjHoS9QBsSpPJz/jpGb7yNcgYB+PmbwQhmNDkiTucLW0nV/ce/wKKSUTsmJJ10tvbyGWz5kFE+7YeR0S6A8EIzIq2C7DWWsdeR8IoF3Ou6X/9lUNxS7Z8psB+mLi2vFM9XrTRPBIicYLWsivHoNPQuP2NTi9hh6FNLZ6g/Y5yxKgQA/LG6ZYQPQOi+qrEGXj8aJM5pQOScldLlt7Nfz0PZiTOObToRlRmKvl7BNQMHKUmaLtOpM6C5Wr7k5W08fBFSWtDBls09P1my+rII9c/CiKclYLH60adQxCjn/EFF0l8T7Q0wsdCzIidCIxduZWvLs0KJz2/+dhzp08CqTJWwtcE7JF9LvPY2MGSNkkmABnzDKsmRr1/m3B+DGIg12dQnOmfYZF23c1+DmmxoiXIuP8uLX7VQsHXa9Di1OD/hSmdL4xyPu1vNXR6g5CvBp6Jnlnm79//4Q7qa+OthmmgKe8VQQAjy9zcdn8qZ0Wa6AVNujrOoL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(46966006)(36840700001)(186003)(83380400001)(26005)(16526019)(36756003)(81166007)(316002)(86362001)(356005)(2616005)(70206006)(82310400003)(426003)(336012)(5660300002)(478600001)(1076003)(70586007)(8676002)(6666004)(4326008)(47076005)(2906002)(8936002)(7696005)(6916009)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 23:29:38.8791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcedab85-7d2e-4fa9-abb8-08d92c679dbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: alex.sierra@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When some GPUs don't support SVM, don't disabe it for the entire process.
That would be inconsistent with the information the process got from the
topology, which indicates SVM support per GPU.

Instead disable SVM support only for the unsupported GPUs. This is done
by checking any per-device attributes against the bitmap of supported
GPUs. Also use the supported GPU bitmap to initialize access bitmaps for
new SVM address ranges.

Don't handle recoverable page faults from unsupported GPUs. (I don't
think there will be unsupported GPUs that can generate recoverable page
faults. But better safe than sorry.)

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     |  3 --
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c         | 55 ++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h         |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c    |  6 +--
 7 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5788a4656fa1..67541c30327a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1797,9 +1797,6 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
-	if (p->svm_disabled)
-		return -EPERM;
-
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 91c50739b756..a9b329f0f862 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -405,10 +405,6 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_POLARIS12:
 			case CHIP_VEGAM:
 				kfd_init_apertures_vi(pdd, id);
-				/* VI GPUs cannot support SVM with only
-				 * 40 bits of virtual address space.
-				 */
-				process->svm_disabled = true;
 				break;
 			case CHIP_VEGA10:
 			case CHIP_VEGA12:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 329684ee5d6e..6dc22fa1e555 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -743,6 +743,7 @@ struct svm_range_list {
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
 	struct delayed_work		restore_work;
+	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 };
 
 /* Process data */
@@ -826,7 +827,6 @@ struct kfd_process {
 
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
-	bool svm_disabled;
 
 	bool xnack_enabled;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f1f40bba5c60..09b98a83f670 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1260,7 +1260,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->mm = thread->mm;
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
-	process->svm_disabled = false;
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0f18bd0dc64e..420ca667be32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -281,7 +281,8 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 
 	p = container_of(svms, struct kfd_process, svms);
 	if (p->xnack_enabled)
-		bitmap_fill(prange->bitmap_access, MAX_GPU_INSTANCE);
+		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
+			    MAX_GPU_INSTANCE);
 
 	svm_range_set_default_attributes(&prange->preferred_loc,
 					 &prange->prefetch_loc,
@@ -580,33 +581,25 @@ svm_range_check_attr(struct kfd_process *p,
 	int gpuidx;
 
 	for (i = 0; i < nattr; i++) {
+		gpuidx = MAX_GPU_INSTANCE;
+
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM &&
-			    attrs[i].value != KFD_IOCTL_SVM_LOCATION_UNDEFINED &&
-			    kfd_process_gpuidx_from_gpuid(p,
-							  attrs[i].value) < 0) {
-				pr_debug("no GPU 0x%x found\n", attrs[i].value);
-				return -EINVAL;
-			}
+			    attrs[i].value != KFD_IOCTL_SVM_LOCATION_UNDEFINED)
+				gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
 			break;
 		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
-			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM &&
-			    kfd_process_gpuidx_from_gpuid(p,
-							  attrs[i].value) < 0) {
-				pr_debug("no GPU 0x%x found\n", attrs[i].value);
-				return -EINVAL;
-			}
+			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM)
+				gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
-			if (gpuidx < 0) {
-				pr_debug("no GPU 0x%x found\n", attrs[i].value);
-				return -EINVAL;
-			}
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
 			break;
@@ -618,6 +611,15 @@ svm_range_check_attr(struct kfd_process *p,
 			pr_debug("unknown attr type 0x%x\n", attrs[i].type);
 			return -EINVAL;
 		}
+
+		if (gpuidx < 0) {
+			pr_debug("no GPU 0x%x found\n", attrs[i].value);
+			return -EINVAL;
+		} else if (gpuidx < MAX_GPU_INSTANCE &&
+			   !test_bit(gpuidx, p->svms.bitmap_supported)) {
+			pr_debug("GPU 0x%x not supported\n", attrs[i].value);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -1855,7 +1857,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 	p = container_of(svms, struct kfd_process, svms);
 
-	for (i = 0; i < p->n_pdds; i++) {
+	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
 		pdd = p->pdds[i];
 		if (!pdd)
 			continue;
@@ -2325,6 +2327,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	bool write_locked = false;
 	int r = 0;
 
+	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
+		pr_debug("device does not support SVM\n");
+		return -EFAULT;
+	}
+
 	p = kfd_lookup_process_by_pasid(pasid);
 	if (!p) {
 		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
@@ -2472,6 +2479,7 @@ void svm_range_list_fini(struct kfd_process *p)
 int svm_range_list_init(struct kfd_process *p)
 {
 	struct svm_range_list *svms = &p->svms;
+	int i;
 
 	svms->objects = RB_ROOT_CACHED;
 	mutex_init(&svms->lock);
@@ -2482,6 +2490,10 @@ int svm_range_list_init(struct kfd_process *p)
 	INIT_LIST_HEAD(&svms->deferred_range_list);
 	spin_lock_init(&svms->deferred_list_lock);
 
+	for (i = 0; i < p->n_pdds; i++)
+		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev))
+			bitmap_set(svms->bitmap_supported, i, 1);
+
 	return 0;
 }
 
@@ -2978,14 +2990,15 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		svm_range_set_default_attributes(&location, &prefetch_loc,
 						 &granularity, &flags);
 		if (p->xnack_enabled)
-			bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
+			bitmap_copy(bitmap_access, svms->bitmap_supported,
+				    MAX_GPU_INSTANCE);
 		else
 			bitmap_zero(bitmap_access, MAX_GPU_INSTANCE);
 		bitmap_zero(bitmap_aip, MAX_GPU_INSTANCE);
 		goto fill_values;
 	}
-	bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-	bitmap_fill(bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(bitmap_access, svms->bitmap_supported, MAX_GPU_INSTANCE);
+	bitmap_copy(bitmap_aip, svms->bitmap_supported, MAX_GPU_INSTANCE);
 
 	while (node) {
 		struct interval_tree_node *next;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 573f984b81fe..0c0fc399395e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -175,6 +175,11 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 void svm_range_free_dma_mappings(struct svm_range *prange);
 void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
 
+/* SVM API and HMM page migration work together, device memory type
+ * is initialized to not 0 when page migration register device memory.
+ */
+#define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
+
 #else
 
 struct kfd_process;
@@ -201,6 +206,8 @@ static inline int svm_range_schedule_evict_svm_bo(
 	return -EINVAL;
 }
 
+#define KFD_IS_SVM_API_SUPPORTED(dev) false
+
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
 
 #endif /* KFD_SVM_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f668b8cc2b57..ff4e296c1c58 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -36,6 +36,7 @@
 #include "kfd_topology.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_iommu.h"
+#include "kfd_svm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_ras.h"
 
@@ -1441,10 +1442,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev->node_props.capability |= (adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-	/* SVM API and HMM page migration work together, device memory type
-	 * is initialized to not 0 when page migration register device memory.
-	 */
-	if (adev->kfd.dev->pgmap.type != 0)
+	if (KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev))
 		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
 	kfd_debug_print_topology();
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
