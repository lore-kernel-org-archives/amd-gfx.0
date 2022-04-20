Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39CAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 00:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151310E182;
	Wed, 20 Apr 2022 00:48:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C4E10E182
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 00:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU7rDBmKjbozGgsT/99lQmCOlxcT4KRPIyrBTWvw9EN8od0Iv24FwiF8i7NvXCDpCfQkDn0GJ5cugsDf5EmW16Kz6h/0UXcnhZvJm+30c/nyoJ65vfG9yhnCO6qe11q5KtSalUlrEUX43XGUf3axJ+Uz9ct7UtqtNqrM1HwV/Dv/x7t1xgMZ7PvZZ+ECMwzc65k/w355ysikfiYpAjrK2HpQWXg3c6DrtqrqfiMCDMalXTHRcEM1JdenWBzAfcbc9hoVZuq8xM1Mip9VliUMNS+cHHNyReV6HmyOLWXDJkdq8dzk9xRQV/otw44GGchYIOHDe6z4MBUv3CmXGz5iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nre+XDAxErkQdUuwLjASXgxXosGwb7y0sk9FceT7Tw0=;
 b=MBN4rSmRtVHhYj6ZMphuBk9yYYKiURvHyyrcu+hEP5cEospgzWHfxw7DOtMiRJDubZ9e18te9C4wlLdr2I1VZoqDquceML2Sbj2a0BX0k2QvKJewRCmzLCsRkV2EenDXVxDjJHwi5ZmgZoVgydhfQ4K6POZf/Z6pKlxKClco2hOEXNRQ8teHL/mQQioJrI6qYYj6apFFDhZ52GJJtiyB1J/qGQ35HewyvpDvM36/9sPFXj2dbjWKdErbLcAODmIpKFT5zipwSnaMxGMH6L4ciErnBeK6BBsRmuePkzKcibyoedt4P7ufIDh5J/1qiQMJdJm3Spnkh5hBvwMYVghcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nre+XDAxErkQdUuwLjASXgxXosGwb7y0sk9FceT7Tw0=;
 b=4GoyHTjmid4OxD+AEG1cUjTf/AEhIEB1UkE5ihjiWNGyOQGbI0tRFpVHqfy71Y0Lv1IS27hbhour7BCwTtFPiuyuPPMl2ciVAKHQ7F6S5Xa+6GLafxwIolvHvB2h8q/Zbzo2rYlWr5gM8uzvd39ImvGi8zSSmDDfv5swI0khR90=
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 00:48:23 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::c5) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 00:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 00:48:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 19:48:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Update mapping if range attributes changed
Date: Tue, 19 Apr 2022 20:47:42 -0400
Message-ID: <20220420004742.8780-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004742.8780-1-Philip.Yang@amd.com>
References: <20220420004742.8780-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 812128c0-17b4-4e80-1493-08da226778c4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5252:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5252C83E83E8EC3A7126A036E6F59@CH0PR12MB5252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nliisa7qW/BqYeh8pw+R1he1PKJ4f1TjseKEweNcD3H119gQ22C3uHPftqImvjFOao8Ejgeq3cwyHjJav9STjnHzpEk87G0dGiuqQJM6dJRFUpDNdY6qzFCc9zBG2nHLGO13LRPxSV4O3w4RJer2xp+t8AU99X0SLCApREfwGvnhTQhX98B14groX81+cN2jqn2cFbCSwbw30AzWTB0XBHiWgGxuIt0r0ovyxB+bSasHAsSlcbJWZ2HRkKZMQgNz7fzviD8RgaiFTeQKOELLrirIupKn0+ZP2raSwPz+tyYwGy7tMEKDUw7w7cGigOyBPz9+9fv/tNVfwR7yUnHmJW7+R9MsDrtI3T3cIuLTmpDEz+x3OsEOzBcE2qXZ7vLatJqvrygBw3i7aGY3k9I3SbXp0AsPw+0mD/CYPA296BQnrFq60c3D/TUSupwODKYu3fG1Ch5LM2lFwe2Mo25pd3dvEYYBgg5jnMHwvYOo3pfWJYHrljg9vJkiqc+eSRdb+of02KFkXPIPDO31uSxICL6FefBhpNKjpFYvobNWxKp7bKFyyTLHBC1uoRZO14TlLjme1+dPvMJes+KECm4A5DHOWqfDDfsgC9Vd7pvPINWYKQO4JtVF517yUmm6e/o6OANRoiIiKMqmlTQogivNrLpiltNawj3bw8aHkAg3tGZaIIsNi8I+0QwyGFbNqKFPj8s+MULL4/n5JCUKEfTD1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(70206006)(36860700001)(2906002)(15650500001)(70586007)(36756003)(26005)(2616005)(6666004)(7696005)(82310400005)(16526019)(83380400001)(1076003)(186003)(426003)(336012)(40460700003)(6916009)(316002)(8676002)(54906003)(4326008)(8936002)(356005)(81166007)(508600001)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 00:48:22.8969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812128c0-17b4-4e80-1493-08da226778c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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
mapping, and pass flush_tlb flag to amdgpu vm.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41 ++++++++++++++++++----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6be1695f3a09..0a9bdadf875e 100644
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
@@ -1253,7 +1257,7 @@ static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		     unsigned long offset, unsigned long npages, bool readonly,
 		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
-		     struct dma_fence **fence)
+		     struct dma_fence **fence, bool flush_tlb)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
@@ -1291,7 +1295,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
 					   last_start, prange->start + i,
 					   pte_flags,
 					   last_start - prange->start,
@@ -1325,7 +1329,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 static int
 svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		      unsigned long npages, bool readonly,
-		      unsigned long *bitmap, bool wait)
+		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
@@ -1360,7 +1364,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
-					 bo_adev, wait ? &fence : NULL);
+					 bo_adev, wait ? &fence : NULL,
+					 flush_tlb);
 		if (r)
 			break;
 
@@ -1481,8 +1486,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
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
@@ -1521,8 +1526,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1594,7 +1603,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx.bitmap, wait);
+					  ctx.bitmap, wait, flush_tlb);
 
 unlock_out:
 		svm_range_unlock(prange);
@@ -1690,7 +1699,7 @@ static void svm_range_restore_work(struct work_struct *work)
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true);
+					       false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -2828,7 +2837,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
+	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
 			 r, svms, prange->start, prange->last);
@@ -3241,6 +3250,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct svm_range *next;
+	bool update_mapping = false;
+	bool flush_tlb;
 	int r = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
@@ -3279,7 +3290,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_add_notifier_locked(mm, prange);
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
-		svm_range_apply_attrs(p, prange, nattr, attrs);
+		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
 	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
@@ -3312,8 +3323,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
+		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true);
+					       true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
-- 
2.35.1

