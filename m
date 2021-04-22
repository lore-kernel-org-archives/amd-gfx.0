Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DCC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EAE6141C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EAE6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDDC6E0B6;
	Thu, 22 Apr 2021 14:47:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057B06E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 14:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq0mCS6k9uQYVub9s10JetJjads995fzccYUiYeVNRp+xxhBPq6IVSgzvT1JQipDt+4X431VX6Sr6+OuuP2kmzBBPeOmZWW0pTi7+WfJmnxdSgzmVrNexxbMb1rrs+gGqAwcM88oMT14o/pu+TZpuCvbmuH+el2SnTYHd4BL+as+OjEmNbnlqnk6xMl1Q0K7YQu23s45OWKXpMEZo88hvaRC3WZ2f1Pefh5uomboH1w/ErdZeP0yr6FwkcURpEE4lKqouVPEUfypDlS/is9zoiuINd34+YFjZu6ROueQYPZE/8M222vpgepoaaJ7bVcSbVHAINrEbCrFGP+/+S1O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP4+jqB07pXA9iwNqGU8qR0O4RXMFaj37606w8vOKm4=;
 b=b/ZSc0mdg4WrdmaCEYVGL/fhGWm5ox8nRabsX/PfDFzTrxB3az37vjStlpPL+XSVxyge8RzW5TNhI7CcF5As/CY4eZTrMnKUSOBs5JwfIc5/mT6pbsyDfCbwwLAsD8HTMNMjjlbcLY9Xq05gnGACT7ZMPLWxbCL3EfC/yINCVKDH1rsv4W6coR2r+DR/CyIXhq8iGlxL/Et1r0f5buw0uhPHt4F/E+pr5Jye6lfd9Q7Ioli7HlXs1W9qZPC8GYIVwfExAsFJYdAds7IyoaQdt/Sk1FnS8wyFSWzq4h74oSIBHKsNHKOvTi8YcJ4aKEgSEDAS06xuW3pChwLgaXbzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP4+jqB07pXA9iwNqGU8qR0O4RXMFaj37606w8vOKm4=;
 b=fF6FOmRBaOwywICG5c14nwar4uhcGj6umht/Hk73IS6z4PebQPUIk6R/BEPmQUkZyClK3j3W3qggVtMlAVEvouh41usMNsAsqXdNbtodbp5RusUshNq4kdSVpTQmRkUzFgpVLAI5jEdR5n8YB4sdxfuWRe1XpA95I3vCpHbVJMc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 14:47:55 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Thu, 22 Apr 2021
 14:47:55 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
Date: Thu, 22 Apr 2021 09:47:43 -0500
Message-Id: <20210422144743.4805-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:805:66::18) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:805:66::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 14:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc61901-bda3-4f02-eb9b-08d9059d9d38
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268600DA606A3666D7AB6F51FD469@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEsmRcb4mVUaiTSo81eJL7xiH+XZowB6urHmZR/icJQP5JmeM8gORQvbbwCgHnlDlfCTMEpJpNGWgV1uLrZgYKXKZJDP/A7imbDWnKkZON8NBuUeL6A/jnIiDONSLJXXQqJq1CaGy7LOQJ5N03SXpT/mmJZSoVmh+WOQIFBvnw8eAO1pUe6XpWEJN/Ap0oWZ4ae8riYWxOKz6YrQLsHDAKGvV6AJFaIPpO/XWQeCZRmWC1RdP0KWY6b1lWPqQmmwDYXKgXiynAVYfxzKzNxoz9LfHs/1BddcRF8WbIkBLfNJu7UsMhGnVHBgeGTBTHlpLx0q+hJ+L64pMLr6g3VRSsEIPaCGYrA0rQe9SbkZDaNjkaHjn8o3WyPMiENVHbb7yWv0karUTcWwijxrcZkn0OS3PvYFAbe6ZUW2bxNCEnDG4Nd+hb7z2hKiBbBSagypHc49Ku/fnScFHM43yYEthKNFU9Kc4WiEjwOdVeiMdYU695TUWfcBetlD+8wtdC1I6IiIiWfbavnq25OAXkQfrL0eQR+47v9eXeyvkLhZveCM47DrVA2wLmDdu+Uo/SwSjNQVcN4gRaDt5+OeNZuleK2qVsZIbSXnWOXBKnEI4Sqc2KimHoLdizxMripQb4LwCPIVZaOnP3yiUxneTvrxlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(2616005)(6486002)(956004)(8936002)(44832011)(1076003)(4326008)(86362001)(316002)(38100700002)(38350700002)(66946007)(16526019)(83380400001)(186003)(8676002)(6666004)(52116002)(36756003)(5660300002)(26005)(6916009)(478600001)(66556008)(7696005)(66476007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J+tPWZjz7YOnlBp9NkXDEvAY6NovthI4/p+JldyU8jws9ZLtoKfnpipJyCEx?=
 =?us-ascii?Q?qhyfmFJuMHtNeyP3dkBSM/mp2GBfLMO2XajLVKW9ctUXZyUSQCH4deYqJjnj?=
 =?us-ascii?Q?ahbnlweTngAnAclZ4UmquSvTUgFQ/WjgEjSdKCpqIgUSYwYKJEu9335GHC5o?=
 =?us-ascii?Q?Gjuwrp4yVWzGyvrzPyyP/RbzK8ti+AjOQvPKgHYL9KhN9dnS+9wtkaJvxI9X?=
 =?us-ascii?Q?ygzUYi18tly7L2tUmMIA2pRC/PGiYOMI41e/gaASqIJg+REXCg8Ms7sLPEOd?=
 =?us-ascii?Q?4dzuMKmOYACpO5ieeBkV/0fyAHQGW5TZe1OtSTLnaTiX/85vt/KjzM84XCFj?=
 =?us-ascii?Q?FNcGK16nfD3eNtcCcjEdqtaAD9cgQyPv8q81a5pqYeDK/y9+zQ7gH+eZtLvh?=
 =?us-ascii?Q?ZViettpozPxm0gcgt6ar2u49HckTvtemYw8xCGJ+lmtAwg/LJ+PNZax5kGO8?=
 =?us-ascii?Q?gG0v1+WXJ8YJGljto2zap6n9lTQ+Y3S6PhZHuqJ1zBSAsSMRwDZUwU3OD68Y?=
 =?us-ascii?Q?ZfZt5yo65E0FR9Jlsb7kyQggMiLxegMiLbMxKuqsdW9MBtwbAIGfFlVYVvvE?=
 =?us-ascii?Q?iCfsw9JIiAO99014S3FhZGr76gh8u9fTBkZY81auV3XuokK3rQKpQd0+nsiF?=
 =?us-ascii?Q?AEa5uFgqZMTv242WOWB5A7dgVJIg10Je0ycxwsBESgmfEI5LCuBtCJ15ASet?=
 =?us-ascii?Q?q2etGFXG65a3CY8JTLmRYkxwk/aPX9wNANFK+R+w9u8snxH45OjOBXkqZEVW?=
 =?us-ascii?Q?wAbImPRoVbdCgWjzTDITLQL2CUUESwODbwsXGEwMCUFiXKd0BQHynnNcr0wQ?=
 =?us-ascii?Q?s+dWdgFUiwtPI2X8OVFBquKuUwsXpSFSao//qJPiHQiHzogiMprNrGHkn9Ig?=
 =?us-ascii?Q?2tXc3lI0ERukKKC2wq4bnR/BcmIQNabvPtszgIeHjae17K915fz++P57Il3M?=
 =?us-ascii?Q?1MRprF8IhF3tLxOi2Thy2lhHv7q1UdQ1MPCQrMikjctjl0TTBHrlAfyqb6oc?=
 =?us-ascii?Q?bNBQ3YBm955HVGluVAUf9wQhmjiye/JY2zH7Nnd9cqKeKV++cdS5eZ/XdJ/K?=
 =?us-ascii?Q?p8jMVdUKnjTCwlNcgEg/aTRudFg009batncr/Z3Xl9/fbul1o6Mo4ZgWk22W?=
 =?us-ascii?Q?FyamL1BZ4orr0CF9k6TZmBzAc6jpLJZQdkb+VGAh44nInuwBy/a68VewnSli?=
 =?us-ascii?Q?P0M6zQZDUdyKTed2wqjaapwbgX+5mVfTCjw0R7MwbQ+QMWHEZH2Rmu7Hxf2o?=
 =?us-ascii?Q?S8ZQbcWlRRKS2JlizFr+xdXPJL2k5/jtCi1AK8m4I9JD7gkSliQL9RXkcl8l?=
 =?us-ascii?Q?ADli2Q3wLu1vICh4TcvKAb9L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc61901-bda3-4f02-eb9b-08d9059d9d38
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 14:47:55.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diUiTRMFi0R1C3EMy6BtpGXuW2kewtpDQLU8EszgGeQZ+oVa9kM90sE5eUOLsduFgfku0aoG61chFzoQa0zbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SVM ranges are created for unregistered memory, triggered
by page faults. These ranges are migrated/mapped to
GPU VRAM memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 107 ++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..44ff643e3c32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -274,7 +274,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
-	prange->validate_timestamp = ktime_to_us(ktime_get());
+	prange->validate_timestamp = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 	svm_range_set_default_attributes(&prange->preferred_loc,
@@ -2179,6 +2179,86 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+static int
+svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
+				unsigned long *start, unsigned long *last)
+{
+	struct vm_area_struct *vma;
+	struct interval_tree_node *node;
+	unsigned long start_limit, end_limit;
+
+	vma = find_vma(p->mm, addr << PAGE_SHIFT);
+	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
+		return -EFAULT;
+	}
+	start_limit = max(vma->vm_start >> PAGE_SHIFT,
+		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
+	end_limit = min(vma->vm_end >> PAGE_SHIFT,
+		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
+	/* First range that starts after the fault address */
+	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
+	if (node) {
+		end_limit = min(end_limit, node->start);
+		/* Last range that ends before the fault address */
+		node = container_of(rb_prev(&node->rb),
+				    struct interval_tree_node, rb);
+	} else {
+		/* Last range must end before addr because
+		 * there was no range after addr
+		 */
+		node = container_of(rb_last(&p->svms.objects.rb_root),
+				    struct interval_tree_node, rb);
+	}
+	if (node) {
+		if (node->last >= addr) {
+			WARN(1, "Overlap with prev node and page fault addr\n");
+			return -EFAULT;
+		}
+		start_limit = max(start_limit, node->last + 1);
+	}
+
+	*start = start_limit;
+	*last = end_limit - 1;
+
+	pr_debug("vma start: 0x%lx start: 0x%lx vma end: 0x%lx last: 0x%lx\n",
+		  vma->vm_start >> PAGE_SHIFT, *start,
+		  vma->vm_end >> PAGE_SHIFT, *last);
+
+	return 0;
+
+}
+static struct
+svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
+						struct kfd_process *p,
+						struct mm_struct *mm,
+						int64_t addr)
+{
+	struct svm_range *prange = NULL;
+	unsigned long start, last;
+	uint32_t gpuid, gpuidx;
+
+	if (svm_range_get_range_boundaries(p, addr, &start, &last))
+		return NULL;
+
+	prange = svm_range_new(&p->svms, start, last);
+	if (!prange) {
+		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
+		return NULL;
+	}
+	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid from kgd\n");
+		svm_range_free(prange);
+		return NULL;
+	}
+	prange->preferred_loc = gpuid;
+	prange->actual_loc = 0;
+	/* Gurantee prange is migrate it */
+	svm_range_add_to_svms(prange);
+	svm_range_add_notifier_locked(mm, prange);
+
+	return prange;
+}
 
 /* svm_range_skip_recover - decide if prange can be recovered
  * @prange: svm range structure
@@ -2228,6 +2308,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_process *p;
 	uint64_t timestamp;
 	int32_t best_loc, gpuidx;
+	bool write_locked = false;
 	int r = 0;
 
 	p = kfd_lookup_process_by_pasid(pasid);
@@ -2251,14 +2332,34 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 
 	mmap_read_lock(mm);
+retry_write_locked:
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
-		r = -EFAULT;
-		goto out_unlock_svms;
+		if (!write_locked) {
+			/* Need the write lock to create new range with MMU notifier.
+			 * Also flush pending deferred work to make sure the interval
+			 * tree is up to date before we add a new range
+			 */
+			mutex_unlock(&svms->lock);
+			mmap_read_unlock(mm);
+			svm_range_list_lock_and_flush_work(svms, mm);
+			write_locked = true;
+			goto retry_write_locked;
+		}
+		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		if (!prange) {
+			pr_debug("failed to create unregisterd range svms 0x%p address [0x%llx]\n",
+				 svms, addr);
+			mmap_write_downgrade(mm);
+			r = -EFAULT;
+			goto out_unlock_svms;
+		}
 	}
+	if (write_locked)
+		mmap_write_downgrade(mm);
 
 	mutex_lock(&prange->migrate_mutex);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
