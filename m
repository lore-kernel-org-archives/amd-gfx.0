Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75079C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E980860FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E980860FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0976E9FC;
	Wed, 21 Apr 2021 19:52:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F1A6E9FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHYZ0zPs040nwmQ3nH7d9AS8ZdXZSRez8sfPePYqitKKmsQgli4OzHi3iQtZNFT9IL1Y2kWH4qE/+UUxrydNknGN5eyDDfG5tYIOWUhl4aeBSNbikA3N8UNSEI1uUqxsOo3xyRwR7UBtrqbpTMXBzUt1GuCVb+OWwpZluNqeYUWoWKYNrUCVJ8sX294pRTEXuaBXuxjikbCWnBfxGWfjS+424ZPCWOP5DXI8hpCQLUTs97R48tvdKuxk2s5Q1Wm3vZvk+3QzbYArES5UCCOApqWjB7bQSJYu6mJC6Y+Eb2I329JkKB/9Ky5/QIVSQOMYl3KTf7C4MpDvDiE2250CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuyS5EFk8gN/OJiBK1fXl293SEXrmYbKSL+ETxhkWeA=;
 b=modPOs8s6YfLmLeSaE3fZB0sYNQmipKfQ0SjhJMteUDPj4SWIraHb4JozRzeF5Y1y2H2JQl0bscA1OB2T+by/Iy1bGz1iUOiODyHUDTHElW/JcCEqd8KFXxYZrBVohkPTl7tJHf+kXoMJe1N4T7IVdyc+uGf/ctHfAlaYVKJJYk/C9YewHfL2rF/ys6FNLQTCwWxbfRxLvOx6szGypmsah5ilrJ8lFNVVjudt7QlqaYTsidqh8P+9AJi1Xo7Z4+Ax6n46Sayckaem5KQJo6mExnr8TzGoIOuf5b/iS1KRHPcgTsaFo++WfYxbnowj71F9esKWEk8mwDXi+IYUHyUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuyS5EFk8gN/OJiBK1fXl293SEXrmYbKSL+ETxhkWeA=;
 b=jIsbAq4VZGMmkO4LzVYF4+kdMN1WNsZqDqbl4XU5BmM5oeO9DksRBp0nOV8WftQLm/c99KYc4fHiZsDFBKJ5ssFv+S3pCUNDMe0jQ9oEP7idQBwVSEhZHC7xZ+GDsk6aletBEGLnjhGMnE5vES+xl+I3LhuGBr9IJt2DtgRNWVM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 19:52:16 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Wed, 21 Apr 2021
 19:52:16 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: svm ranges creation for unregistered memory
Date: Wed, 21 Apr 2021 14:51:55 -0500
Message-Id: <20210421195156.24250-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:805:de::30) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.8 via Frontend Transport; Wed, 21 Apr 2021 19:52:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2f6821e-d307-4cb3-b0e9-08d904fef70e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4429D6EBC37B179AAC332A01FD479@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9I+5jgsrk4oA8J/AnHzycSAzaDn92UVPg5qTJTbxkwV4pp4ItmNVzs9SbhtpVzfvd7I19GR2YJqO/fXOgKfGpsZ67MYv+dLv3G58XfaVt8/BpMiISSYzAzjHTJciyIC/Ar303618go+pwUq4cpYe4RRI8yHGrEvFGHTVuohdIxLdMhIRuBiQt6aJV3Mqupxi1VA/NWZ7Pp6b9ut9MzJMlJqJw3XUtYr5jMDDgFzzGJ/1YvOYsw/1BJCxEv1qwDZUN2EIBQ1WUjSAR0oIRju4Sxe6ejdDCXhjZ0a51oWCgwSUd2NxwKMNsy+la7Qq/qtmd3emz1ZVHDRzyrwia+FX6/Ak4e4X7iltp9XKXKaeMgJEVdNPXFu+UIzI6icHtrpf5zQLu57nKqlvfvgyv7YtCoAHa5jcrmOWmTFKo7cEfJxn7/gQxXD+IZtRrc8UpVC/6Yhpzaz6qL+3dPft6dwROF92xGZMHk2B0wqbQWyPfB6MAi8wYdq3iMlH2pA2a/yf719AGx7OtHKELuOgda6Pj5QMWoPYxcnxNnBZhYeWALZiiqIodUa8K2aOZW0KLR/nR/v8p4fHSSQ3Vr8bRAfW4MdIWUyZKKDB9ZWnrerwWBHxvgs/IHtzEVdG6SJQthP/8nKvEDKPftMJPo+WldTVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(16526019)(66556008)(83380400001)(956004)(86362001)(66946007)(8936002)(66476007)(4326008)(36756003)(316002)(7696005)(2616005)(38350700002)(44832011)(2906002)(26005)(5660300002)(38100700002)(52116002)(6916009)(6486002)(186003)(6666004)(478600001)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S+SchS5+s7YIt+WnyZ0+UJkMy2kT2DVUylj6wb0x99jEIYTQsuD78385VJ35?=
 =?us-ascii?Q?XfMg7YUZr83gCxOsoGjB4tnLOow+/gWfE4i9n1m5ApQ5b/+zTxsMCvxT3+Fv?=
 =?us-ascii?Q?QBLDdUI2v7c0OkiMqUy8PpkxDBg9pJcVNpvwr/mdq/DxWBWFxD/UpkEVNisI?=
 =?us-ascii?Q?YwBwNWCDaSmHCJvj6BGshqtSAHgiRRHqhzsuKlAcMqtm8HmpgFnWBTh/WkkH?=
 =?us-ascii?Q?2eK/c32+qgRkSCBmEQHjtlPYY56/JMtVq7yi1+ZCYW6Kkt2HlZkhd/ID8qtK?=
 =?us-ascii?Q?3Q+jPl0YkMRgU1lQQ4eVqJe7NLAO9XHPzcGyofUskGghD0NSQiec4riS6pyA?=
 =?us-ascii?Q?947aeF6KJI3VCMDOPc4XsNySFw9qAX2rxjqv1nRTkrxN45HAlzqxXL+lx8cz?=
 =?us-ascii?Q?/GL0jlRUS7Tm2p/hCyhhEQ5s+ontlYKULdPEyZHtAzqdXfof+qpi4Z+V8HIc?=
 =?us-ascii?Q?Bc1eT9o9IIUufJPDhEenev+iD1gv6Ng+GdaVy9h+ZfkBw0r4ydToeysf/JXc?=
 =?us-ascii?Q?MXHqEF9/HwHhPfoHiBtwMk80cpXxIRSubyWtQT/xvBuyWhB57vmDWOOpHWL6?=
 =?us-ascii?Q?BUbn/NqvjguKmC3I9vzEV7iNUdQSRFMnMV/bAAvCE5SC1NxicEaSr8nf5kar?=
 =?us-ascii?Q?WtsOL6XI3vuZmNVMT8bUgE4e2GC5ioZcEfdYo6bmnAE92x5d7i5w8GGnyiw/?=
 =?us-ascii?Q?G8qJ14Giha7kP1fLREHZ1AvdioU7dPcKU4bS57sQzsJoEhtj3QatD3kS25fD?=
 =?us-ascii?Q?i7dc+nrpSrJQ5zjrWntsapmpBz9WDGHhxrAaArSpfi3d9eWayOEa8JvVJ6FH?=
 =?us-ascii?Q?dYaRgJfyKw/H8MhMvmimoE8OFidnAZUxXvPMbYEwUkMJ/iEjj26AfrNQPYWL?=
 =?us-ascii?Q?vc2ITx8xjGx4ckQC69gyO9t5QXdeIOUfk9nuLFw6jPf9rC1hNDmu4fNk2SIq?=
 =?us-ascii?Q?+Q/qiIVjG7bLFvnh4BxHTJqur8k2GdOD56WXhijJKo4a6HpoP9vsWK5qkl8H?=
 =?us-ascii?Q?zKWiBRpLAGZC+eJNf1Zk2LEyP0+t7iyT9i/jjc5dVMSWVdnO6x3tAlebamHY?=
 =?us-ascii?Q?bvWmanmxeQsJN2/jizYftxSBZRtnqp4j1gFcrBXDleMUcI04quUArpZsxR/i?=
 =?us-ascii?Q?hOnwTyUGWuisXBMrBocb2JTzhnoilfuBAbQ5G/eQv5R0ZNLKIbwwhohbro1A?=
 =?us-ascii?Q?O1DxcHWvJvNwnv3jnH/4iDAzBXv6G8aYBsWtNifLiBJGmvc4WNd0NrkMuixg?=
 =?us-ascii?Q?IIQ80LEo6hXwZ/hmdLAl3GB1n2SqQ1t+VZJGSzBhpdMnXlcW/pZAu2rX6ntX?=
 =?us-ascii?Q?dqDN/L6Q2ZXPEHqKUnqhmAfV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f6821e-d307-4cb3-b0e9-08d904fef70e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:52:16.4179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4StfNaVxIwnJoq5RCqOhDcsFyitOmCmZAo9jWVRQ+PRvgVCKF0tHQeR1e/fPD+wwA0mrW6SYkfoueebQvtKPMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 108 ++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..cb025a6f30d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2179,6 +2179,89 @@ svm_range_best_restore_location(struct svm_range *prange,
 
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
+		goto out;
+	}
+	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
+		pr_debug("failed to get gpuid from kgd\n");
+		svm_range_free(prange);
+		prange = NULL;
+		goto out;
+	}
+	prange->preferred_loc = gpuid;
+	prange->actual_loc = 0;
+	/* Gurantee prange is migrate it */
+	prange->validate_timestamp -= AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING;
+	svm_range_add_to_svms(prange);
+	svm_range_add_notifier_locked(mm, prange);
+
+out:
+	return prange;
+}
 
 /* svm_range_skip_recover - decide if prange can be recovered
  * @prange: svm range structure
@@ -2228,6 +2311,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_process *p;
 	uint64_t timestamp;
 	int32_t best_loc, gpuidx;
+	bool write_locked = false;
 	int r = 0;
 
 	p = kfd_lookup_process_by_pasid(pasid);
@@ -2251,14 +2335,34 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
