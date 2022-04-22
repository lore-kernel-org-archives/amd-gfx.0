Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 14:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E319910F78F;
	Fri, 22 Apr 2022 14:07:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AFD10F711
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 14:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Yv/15zkIGz1g1cBcFkFxCBlhdVbQ4axDVS3QvNkvqtT/mDJ+QAri4enKwIyakOvy6fis5NTO9cGTFkv6rDHYBiFvhd4AToL+tmlnrtssB1HDKYy4CFHM+uLfnkxohZahli5pp90AKfoTMV84V4TbbcOYehCRxXFfBLTjymor3GISeDDXXGzNzdTJisqVLkIERRmSAcyfvH6kQ7D2oWHqlDZprrVIaQFIPplpYho+BHfuxHl4Hd5VbF/Ur6xq7bNLQ3dn1KX+xyNtYehfubAG6p0yX2TDGvGSbNU/TltYJQBy624nOu0dwNdi0smd/RupRrrwGhZw7ObMsoSeADog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsq8hWf7puMqfHIx4g6V7+2X/zrkSCZG16AxYmV095A=;
 b=Jj/kJHhnp5GkXWV4KYSLuycwvo9J3SypmY81h3ae6gt+reB92ILiIqW7PALbI+krd9AhXjkvXCNevDCIj3iUNLyApXXvamSAU9SFmELF/4EojzOKznjadyon01xW5I4TVnEYepMD9S8jKrE9EBf0rI4rpl1VkyVnE1t38kRnbjkK/PsC4xFbi1HabXkXtS5kfBiz6giD3YLspMKwK2PvpDaswhpHfZF7sWCTX4XdXeGMrMU128K71vkifwei0gTgXivbfVAnSskVsGdOnBg1zquUs9tqEWdkEUWGSONX/JIIk329qKFsvaod+YY7J3Wok81kakrUbf8v9gq3dlKTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsq8hWf7puMqfHIx4g6V7+2X/zrkSCZG16AxYmV095A=;
 b=Q48Zy1OF7KzIIUQ84dsQFefI4gqWx0+aLmL967SqVJM5EJw0Sfohgdl/hYS31Gbp4crbl+HITz6aXD1RJQwJ0SmKroY2YAF9cKcp0IDRHev1psBYaoQNR35wfsN681mTNJ1D1JGgY1bpICdjAwdNiD9dK3J5KWI2Z91FCKmIDj4=
Received: from DS7PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:3bb::19)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:07:21 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::e0) by DS7PR03CA0074.outlook.office365.com
 (2603:10b6:5:3bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 14:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 14:07:20 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 09:07:19 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: Update mapping if range attributes changed
Date: Fri, 22 Apr 2022 10:06:40 -0400
Message-ID: <20220422140640.26783-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004742.8780-1-Philip.Yang@amd.com>
References: <20220420004742.8780-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69dfe316-f2cc-41ca-0f6c-08da24696ab7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB436815E8D046BA662FC3F2CCE6F79@SA0PR12MB4368.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liytW5RhNV6YzEKTFLiBEuXRZ53ENv70H/2e5lvxe9ZuqwhvzaFCHGv6MQ1TrBOFFCQ210+JFm3/bL15IQNyjRCHvVUppPn+truZyfagWbpNyQL4xwsLN41Q9YbTotPDH0XXC9lALWLQfRjflklXgGnsUyD+Kel8satFdH4tqy4qsppmN2G0HLBK3xH5p+PiJ6LGJkV4TJHDaE1u4+1mVQ2w2P+TQOpq9FXVeqpWPb+ef1FZKHcTtbqj+kBRaGEy9x1L+sBq8tFAM1MOyuPMAdnp5zKge3d2uAATFDKbO+u+46bYKaB3VBwUynI3s85YhrH0tPbkKwIecn7VW7+VAVDTOTs9CFndJ/1+JiK7sYdFtUDXF/lvJhRWOXgpiHdEE5+Y82ejUk6cZ+GE4lC27QMHmo6XQYAMAJyFVmDH6Bp25XktjKoP0AzUb2C7L3YJCSVYlDDYYAdenFiv/j5tvUYyd1htFXm/OAHsycu2rSdDaVu3B9fFqe4b7B1PXlvy+je4/5arFItqhRIktINcCYErzeGFVNSL4DRx0vVyIKrsFmisnTi6AorNPUQtR88e3fSOBLnS4s6Kl9N1HDD7nUcvr/QOtmPzdGIYHiKhv3x5LQrZo7BlFgxvf8CVbGCL/J+RUPNAaUTKwQNi5ekEGU34y7QKA0yZcPJedUM67J0trjHhPhEvplRUzbGw+Azd8c7ucorbySt3siT7/st8pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(508600001)(356005)(6666004)(81166007)(8936002)(16526019)(186003)(2616005)(36756003)(26005)(40460700003)(82310400005)(83380400001)(426003)(47076005)(336012)(1076003)(54906003)(8676002)(316002)(86362001)(6916009)(15650500001)(36860700001)(4326008)(2906002)(70586007)(70206006)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:07:20.5644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dfe316-f2cc-41ca-0f6c-08da24696ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change SVM range mapping flags or access attributes don't trigger
migration, if range is already mapped on GPUs we should update GPU
mapping and pass flush_tlb flag true to amdgpu vm.

Change SVM range preferred_loc or migration granularity don't need
update GPU mapping, skip the validate_and_map.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8a077cd066a1..e740384df9c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -686,7 +686,8 @@ svm_range_check_attr(struct kfd_process *p,
 
 static void
 svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
-		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
+		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
+		      bool *update_mapping)
 {
 	uint32_t i;
 	int gpuidx;
@@ -702,6 +703,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
+			*update_mapping = true;
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
@@ -716,9 +718,11 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			}
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
+			*update_mapping = true;
 			prange->flags |= attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
+			*update_mapping = true;
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
@@ -1254,7 +1258,7 @@ static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		     unsigned long offset, unsigned long npages, bool readonly,
 		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
-		     struct dma_fence **fence)
+		     struct dma_fence **fence, bool flush_tlb)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
@@ -1292,7 +1296,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
 					   last_start, prange->start + i,
 					   pte_flags,
 					   last_start - prange->start,
@@ -1326,7 +1330,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 static int
 svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait)
+		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
@@ -1361,7 +1365,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
-					 bo_adev, wait ? &fence : NULL);
+					 bo_adev, wait ? &fence : NULL,
+					 flush_tlb);
 		if (r)
 			break;
 
@@ -1482,8 +1487,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
-				      struct svm_range *prange,
-				      int32_t gpuidx, bool intr, bool wait)
+				      struct svm_range *prange, int32_t gpuidx,
+				      bool intr, bool wait, bool flush_tlb)
 {
 	struct svm_validate_context ctx;
 	unsigned long start, end, addr;
@@ -1522,8 +1527,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
-	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE))
-		return 0;
+	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
+		if (!prange->mapped_to_gpu)
+			return 0;
+
+		bitmap_copy(ctx.bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
 		/* This should never happen. actual_loc gets set by
@@ -1595,7 +1604,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx.bitmap, wait);
+					  ctx.bitmap, wait, flush_tlb);
 
 unlock_out:
 		svm_range_unlock(prange);
@@ -1691,7 +1700,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true);
+					       false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -2847,7 +2856,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
+	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
@@ -3264,6 +3273,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct svm_range *next;
+	bool update_mapping = false;
+	bool flush_tlb;
 	int r = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
@@ -3302,7 +3313,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_add_notifier_locked(mm, prange);
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
-		svm_range_apply_attrs(p, prange, nattr, attrs);
+		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
 	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
@@ -3335,8 +3346,15 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
+		if (!migrated && !update_mapping) {
+			mutex_unlock(&prange->migrate_mutex);
+			continue;
+		}
+
+		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true);
+					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
-- 
2.35.1

