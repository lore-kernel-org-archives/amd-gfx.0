Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3A0C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 17:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720AE10EFB3;
	Fri, 21 Jun 2024 17:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VXY3/ZHN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A115D10EFB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 17:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBRFpYPSdzfow7vw1/g5FCLWsBzp9Gfj4Uw2TziMfm9rQ++na4OBWDvQY++WdizlolVeieIEiZiZvGysl7FjQiWjspnGPzLcwEDhRzlY5wHlAoS/pJvKxLipf6Q6ZSfc0GbgIYxDQ8HaXvvuJNQ8Eom6NLVQ5duB7BKD18deuwWFjVDxqTX4HpNDn1+k40KuPCsInWiqAmu5BZ94lRTQ/GWqN78deakAjVRisU2YSBr4fXJiKatYP1Zw4KtVIEPX3mQXYFZIeFS0nYsCPZ9gdAgOnPUajwW+q4n9nMeaXa08PJnUmDA6wyySpdkWlDdJvi/Q2mIqGs8mgEiRX7biwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFkrWoDtMFaL8Rsjn5zy6HtKz6ZDZHxq69ypULx8B2I=;
 b=Z4hHduTQU6Upv9aaYMIx+n35ijbBb4IpxbrLC/M73UHnMn686vM0xd0OmqUaK3FoP2v6yualldm5KYNwWRrs5YJRmfdbaAHom5ApjsV8SGMuv5nw0t5dBfYQtY9XG6sk8a4Mo2X7h3gKcBTjLJyZi5WODPEBvxsHh5uFBzrhcS4kA8aExDAqbGmfSqyL0DzMVdxqSVPODaGL6sFno1ZIHsq77nGgn4TxSZOU4oZS19hPxnSJhY3KSgV14AAiiQGXYYHgUjN4SHtCFju1m7eid0txQXuiRFlkmeu5q6vSyM5IpTyCPTzG/aqNDxyFxyILewX3yuAUMd1hzDH/Jg8vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFkrWoDtMFaL8Rsjn5zy6HtKz6ZDZHxq69ypULx8B2I=;
 b=VXY3/ZHNiBus3fEZuXoX+lf1FwN21Mcdcw6bogjhVObC6aLyBElGUM6FRi6bDH0DaqTn2uetpIJ3jQoVS96BH7Chdl/zZlRG2fuURdbi0xgfKyygIS+SthcvLAy+9QYOAnVdsqB/mIS5sanP2lSps4DTX1Nn6NoTH20BkXE+X2w=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 17:26:19 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::13) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 17:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 17:26:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 12:26:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 12:26:18 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 21 Jun 2024 12:26:13 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
Date: Fri, 21 Jun 2024 12:28:23 -0500
Message-ID: <20240621172823.168595-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda5717-20ee-45f1-c85c-08dc92174378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZTxIIk1nU9c1vVFKzJJbXj6BYSEikKXWAFEsOeSGsqU+V3Jk6enoQqddaIs6?=
 =?us-ascii?Q?opRD/sLWKndawctutep7jZlgajtovmYiJqsAUculVSArRBz4xfk/bTRid9qL?=
 =?us-ascii?Q?eOUfdOIIhz2QebEwq0/YdYeJwWirkIBUaP1Uf+ead4CHpD4kuKCXx6KLg6q9?=
 =?us-ascii?Q?IGB8bDmHxCp3Jsw5IvhAxs8OWWNMzguyh1FHea8sy5vOh2A93q37lP0NrYAF?=
 =?us-ascii?Q?qA2qeyO6zgTA3tWlCdEwmGPAmFUMuMTjS68G1ZMD0QjcHwFDB6KjzgrHodN9?=
 =?us-ascii?Q?5+4Twp3mfJVrEDTzhl7rzHRTT1mfDK1Aw5mcjs0FmWu55cWIjwpKzmFYhjeG?=
 =?us-ascii?Q?xTzQoZHlySSTad0JRg08ZHoZYCNboSms3IcoS62Wf90XYszdcMJVXVZN8M1V?=
 =?us-ascii?Q?AdEhS4A6oQSbjKal6WIrwKXRay89lnPV5jE1igh06lrkknfja+obgWpypiyb?=
 =?us-ascii?Q?1nJWW8rhIKwtfbDGiXWTF+eVfxhdsHkqjyHAQjo8EDf9KkMum1vbGW3bbYDz?=
 =?us-ascii?Q?SHvUptLWHdyGVcVLMN9XRQrnSG4ieHLQGKqGCJ383cO9o7ElVC49JtP/V2Df?=
 =?us-ascii?Q?5Gcb6MVOMOBk4vThi6Qz7xrmRRyOVKwzuyY0LWf8OMt8Wyl6/pK2FNtK+NBE?=
 =?us-ascii?Q?/u1rCy7heEma9GhaOrafTgHdVVd4lgsHQmrW7eWxjojektkKC5Mr6OFoHuso?=
 =?us-ascii?Q?HSlvEolXmDxozT696M7FCyPUalb74EvSAHp1t0FbTchr36n+xeXaagSMJ+Fv?=
 =?us-ascii?Q?hdhrYr1uos64yJLaNzfVh2q8OEtLi6s66SvyqWSyOyxnjNGr6QaofbozYAJV?=
 =?us-ascii?Q?EbrFKi2NzUoG1/ypudCXy4GI1384kRDTiE1lKZxgKEvt7TCKulznq8XnFdiG?=
 =?us-ascii?Q?cxVpp415LfGCKN55pBAVzXc6BPvQLgbEflQMnaOvcpYsc8lq3xBaWLEqOUTE?=
 =?us-ascii?Q?ZuyBDNt4rmlKw4VW5nkeYAEFJmzfaZq4eOQn9ymIxt5AHOs1b2iZwbPzJgUe?=
 =?us-ascii?Q?AUr0Ny0kY9qNWSJzWCLXcaNrlP54NU1fwZ4NNLalGH9qpWVBl1jq5u/iYftJ?=
 =?us-ascii?Q?vRN8IBpHObns2eTVUim28AWY0zy/QjF20OTqYCkmH5leMXlAikHlT6G3RBV8?=
 =?us-ascii?Q?hzy7Ao8ZwqL2ktzGBJKLkIJxjnzWLvNg9JapyHxC6gnpcSBFagk04TDPU9UD?=
 =?us-ascii?Q?4KN3fwZEGw9vM9t7jw97gOTI+UfpOC/Zm+2IahkfBnX26kmaXHc2/yuNgP5C?=
 =?us-ascii?Q?5cYXIhldWdMKdPYmi5z/OQUS21JSWbZvzq8ObKInGDIjmUMhSiPRqv35d0w/?=
 =?us-ascii?Q?jhzH0HDCUT4DFn0GGEl9yLnPUe5XxXgeklP5obRcLeIrfGZ3vACV2MZe57cA?=
 =?us-ascii?Q?SB1LMETv2b/b03Ko/R4VWvYx30JjsM6MiEquGwyu8WM1YLbfJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:26:19.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda5717-20ee-45f1-c85c-08dc92174378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When user adds new vm range that has overlapping with existing svm pranges
current kfd clones new prange and remove existing pranges including all data
associate with it. It is not necessary. We can handle the overlapping on
existing pranges directly that would simplify kfd code. And, when remove a
existing prange the locks from it will get destroyed. This may cause issue if
code still use these locks. And locks from cloned prange do not inherit
context of locks that got removed.

This patch does not remove existing pranges or clone new pranges, keeps locks
of pranges alive.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 89 ++++------------------------
 1 file changed, 12 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..a8fcace6f9a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -904,23 +904,6 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	return (void *)dst;
 }
 
-static int
-svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
-{
-	int i;
-
-	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
-		if (!src->dma_addr[i])
-			continue;
-		dst->dma_addr[i] = svm_range_copy_array(src->dma_addr[i],
-					sizeof(*src->dma_addr[i]), src->npages, 0, NULL);
-		if (!dst->dma_addr[i])
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
@@ -1967,38 +1950,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	return r;
 }
 
-static struct svm_range *svm_range_clone(struct svm_range *old)
-{
-	struct svm_range *new;
-
-	new = svm_range_new(old->svms, old->start, old->last, false);
-	if (!new)
-		return NULL;
-	if (svm_range_copy_dma_addrs(new, old)) {
-		svm_range_free(new, false);
-		return NULL;
-	}
-	if (old->svm_bo) {
-		new->ttm_res = old->ttm_res;
-		new->offset = old->offset;
-		new->svm_bo = svm_range_bo_ref(old->svm_bo);
-		spin_lock(&new->svm_bo->list_lock);
-		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
-		spin_unlock(&new->svm_bo->list_lock);
-	}
-	new->flags = old->flags;
-	new->preferred_loc = old->preferred_loc;
-	new->prefetch_loc = old->prefetch_loc;
-	new->actual_loc = old->actual_loc;
-	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
-	new->vram_pages = old->vram_pages;
-	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
-	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
-
-	return new;
-}
-
 void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 	uint64_t max_pages;
@@ -2057,7 +2008,6 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * @attrs: array of attributes
  * @update_list: output, the ranges need validate and update GPU mapping
  * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
  * @remap_list: output, remap unaligned svm ranges
  *
  * Check if the virtual address range has overlap with any existing ranges,
@@ -2082,7 +2032,7 @@ static int
 svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list, struct list_head *remap_list)
+	      struct list_head *remap_list)
 {
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &p->svms;
@@ -2096,7 +2046,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
-	INIT_LIST_HEAD(remove_list);
 	INIT_LIST_HEAD(&new_list);
 	INIT_LIST_HEAD(remap_list);
 
@@ -2117,20 +2066,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
-			 * will change. Clone and split it, apply updates only
+			 * will change. Split it, apply updates only
 			 * to the overlapping part
 			 */
-			struct svm_range *old = prange;
-
-			prange = svm_range_clone(old);
-			if (!prange) {
-				r = -ENOMEM;
-				goto out;
-			}
-
-			list_add(&old->update_list, remove_list);
-			list_add(&prange->list, insert_list);
-			list_add(&prange->update_list, update_list);
+			list_move_tail(&prange->list, insert_list);
+			list_move_tail(&prange->update_list, update_list);
 
 			if (node->start < start) {
 				pr_debug("change old range start\n");
@@ -3533,7 +3473,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct amdkfd_process_info *process_info = p->kgd_process_info;
 	struct list_head update_list;
 	struct list_head insert_list;
-	struct list_head remove_list;
 	struct list_head remap_list;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3563,10 +3502,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 
 	mutex_lock(&svms->lock);
-
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
-			  &insert_list, &remove_list, &remap_list);
+			  &insert_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
@@ -3574,21 +3512,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 	/* Apply changes as a transaction */
 	list_for_each_entry_safe(prange, next, &insert_list, list) {
-		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		/* prange can be new or old range, put it at svms->list */
+		list_move_tail(&prange->list, &prange->svms->list);
+		/* update prange at interval trees: svms->objects and
+		 * mm interval notifier tree
+		 */
+		svm_range_update_notifier_and_interval_tree(mm, prange);
 	}
+
 	list_for_each_entry(prange, &update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
-	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
-		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
-			 prange->svms, prange, prange->start,
-			 prange->last);
-		svm_range_unlink(prange);
-		svm_range_remove_notifier(prange);
-		svm_range_free(prange, false);
-	}
 
 	mmap_write_downgrade(mm);
 	/* Trigger migrations and revalidate and map to GPUs as needed. If
-- 
2.25.1

