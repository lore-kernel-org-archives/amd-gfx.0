Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACAC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 01:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B9061008
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 01:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B9061008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5222898C4;
	Tue, 20 Apr 2021 01:52:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F7E898C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 01:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb7Q3v+FWyWa9P7eMrEnATlckAY7sJj2OOK6wbMA0OdO1UHdUxBZV6X4UhO0fTDSJTZntYMSp85/Uyfg31D29c4EMMagya699oQx58IBE2U7Qdu+fPfkIoT6TzgAwR09iobv0WM/PhFH1h/qIL3KQKXJW/U83sX4wI8urHEK2WwHnstbEqjMHwkQJKqH1ltfQgfQIE4tiarld07MTKCEwzhzqlg/xG9hqDMvoa8HBR9X/lHOaUr8sBsDexVUR/vOv5j7qa8thl4x6KCa3fSHp4Jif9EwvDZCPBufFNvnnf8L/Tp5sQXKp3HE1i2qMKN+/4Hfd+svKp19Q3aEu4WZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HfQM0j4MdxBhK5JQBGCEt/NGCJo6BPYIwAuFY/gl7k=;
 b=ZD2Dy+qLdxVLsqldMfgzouOm5USahPivMvce6casL735QSruPlBVJLH0d6Q9BpZ5ulxgivyRrHeGU56Gb7XrpWQtPWlWc5TNJCL+HYUItGoVZN9JmOyKLWMfCxWssrGEIQRzX2su1z7B6hZ/GHh3vFDIuLxw4ugpkmv5f3wrVRzuK6feOfOTHKnY1dJ+SwtMmnlM3BjPS48jJxWbh95qUpFnTjdEHjel2IjD2BqhyhJZ8SvtFbX9NIdXFYbIC+P5Q1wQ63pfbDz+4jElCln8F/eF56vSlC+vroEGkZDF858ohjtKNvDeqVCJ+GGIn3vRp8NZfkdoqanKOVorV6c4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HfQM0j4MdxBhK5JQBGCEt/NGCJo6BPYIwAuFY/gl7k=;
 b=SXc/Dv3YD7wqJVF0/2LHlnQXlyZb6NMss//zDIglCe1btoLs+iEABSsyqnDcwNu63pKqEMqnHAXvaN8KBEv/VsBT/e9iggBXNEcQhvK1C8aeFXV4HCJVqBL5YiOPufAFO3JoQ0sN2wCbEiq+w0xTl6gKz69L4elEO9te2xbLAaY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 01:52:22 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Tue, 20 Apr 2021
 01:52:22 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
Date: Mon, 19 Apr 2021 20:52:05 -0500
Message-Id: <20210420015205.9606-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0401CA0031.namprd04.prod.outlook.com
 (2603:10b6:803:2a::17) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0401CA0031.namprd04.prod.outlook.com (2603:10b6:803:2a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 01:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6462b368-271d-442d-0d0c-08d9039ef077
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB46710D6D6ABA48EEA6E98C9AFD489@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5MWW5Uqk5TBuv+GAXQgBM1iMT4+x4sPJ9pvbAJliLVwfrsGSVJi20y4TY+3ARKi+ux2ij8SngTIOzl7kxlX5gAyM8qeUrGcOhabc9u5Ck8+m7zTxw+rHraX3qd3AIu7b2trkHaT7Vhu3zUImcWf5s4dEdKRdO+RlueLPLEbY4JfjSt7QBW8+GoVJEynT+SO15T/2AM8nvlaoSUNc7cFHlvlhuT8bIoFmbG3yoE5eIe8pBiMQvzbfhzsq7wMDNJO/PgEu5KpUcyVET0NTJJnSaTgzD+4LpEYmMiUD3ctf3/nzLVyiY10C9/roc5pROC7fg3p7L5LcD/ID7GLlJwBhIN/nZDyHHa9MuIQtuPSzFSgtZzMAnJLOsXJ5gPY7lbMqEv1TNngmXpl7LOEj9AtF0HoVTnubg22so3M6TBkR0i6Nx2cns3hcjxc+8zlDORZwAKMJyIpSPSFm7qWnswjSythXzhNa0+zEJ7JTC/26mf+iHCsB2VO9fzL/9ioCP0TNfRLgm6D4C88fdi2LIaXhwIFxkanIiR+N0IM1viMUVa0tOqq1eUlYfCStkSc+Q+qy6cOam6xGPIMKD4WFYewcyx3f0RiXuWSEnIeNT1crIM6OjwCtBXXhD5LbtWa582502XTKlv88UUy5bJ+xCUAfCnqzhbQ0pEZt69jZxfrpu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(83380400001)(6666004)(86362001)(16526019)(186003)(4326008)(44832011)(36756003)(26005)(1076003)(6916009)(316002)(956004)(5660300002)(66946007)(7696005)(66476007)(66556008)(478600001)(2616005)(38100700002)(6486002)(8676002)(8936002)(38350700002)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jAEEfOtNXRZdqakI21+XSCH4Y1LFm4G1+KWOpreV/PJROjA8imJOt3KJywQ+?=
 =?us-ascii?Q?IzZbQf/rgHMfnw6aSRnNuQHf1CLNpOANPzojBQ4r/qSv6eyzyR22oCzlDo3K?=
 =?us-ascii?Q?JQ2IfB1dHwdvfTMqLYzKl0AbYyj5jxNh0VtGC6YnVwp/gs2nhEuA2SbzNxg5?=
 =?us-ascii?Q?RzPa5LILIfNb21e7WYRZ6GrWbICQWuRzVQ3AfuGVgreucoUXyebfKTJajDFJ?=
 =?us-ascii?Q?Nn4x6QQnL/piuo6VydSiQFtONJAVdjLxMQrv4uaAXEcfVFLOVz9/o1DoU1x9?=
 =?us-ascii?Q?3KeM0v9iw/DiZO1+FAd/5iIWbD2GGwwXy4vdwAqeSSqFUrcuN9ZwOvtOmJia?=
 =?us-ascii?Q?agSrZ9OihIBvenMu6NB85OWu28Zj61/DiJjJZQDCOyiDrS+A7i8XllbFgPAu?=
 =?us-ascii?Q?Mr6bgDVg3tOXurIGM/W+nruD6F0zaxuV1GtrspGxbEAQ6KDNfGEq8zgMJ7GA?=
 =?us-ascii?Q?57v23rl/4zR/AqwqS9w+8FY0lOl5jDTq9nTSpUHxMZ236eFzgUNbpV9Pv4PJ?=
 =?us-ascii?Q?jDbD8jsUniuuVDqtS6x6gle+/sB5mr8XorTPi9vp3KSi8GIhKXC2XIsXJ/+k?=
 =?us-ascii?Q?8AbgerBI4spSHFTAGubmR8g2cYl3s9hn94xHjvXvPQn6A4baxHTFKzAbLoOL?=
 =?us-ascii?Q?GxIeM/QVq93K75Lcp6b6Po5GGQa4KCZr+wuRfNA8KJzJzEfP0qr3OVTsrMWj?=
 =?us-ascii?Q?g8LLBWHB2p7vjmMQEtYLZH637kwmkCE+3/rEb+ZF0pAp0X2yvPOaGwD8EJ1/?=
 =?us-ascii?Q?aVAv+Qu8HUUk1K4no9mUf1W8CML9DeT8VWYWmDdMMSxYXlooa+18xmUK1y1k?=
 =?us-ascii?Q?wpmh3yhgkx2/Cz8BAoFz4Tm+susJDXfONZ9wK17hlDH0zEXtZAYU8yOv6yLq?=
 =?us-ascii?Q?IYV7LNO/zsrU9nsdArlQDcd82QMdq1S+q4ja0Pedc+PlSWpP4CTruA7zDfJG?=
 =?us-ascii?Q?Q0vsQAbLm0pj2ahZMQ5Bq8HWcm0iyKo4NP6yHG2aSoPvYvK60fCO8lvvLm9R?=
 =?us-ascii?Q?wjdxEfxpyBQ8YI7XsWo8NpeigjcyTisqDtPkIdFHxmqYVqGfs/GUmIcfEEoI?=
 =?us-ascii?Q?bwKgUqrxl0qhSgHZq6E+BY3Ra3E15uqYDK9iDqmQ5EALi6qN07HcObu1+2WF?=
 =?us-ascii?Q?4Igtdfm4L75OPrLEeXtFzm0X0joxGRJ/JTW8bGLou+xkBxu1yW6VguyIJDK+?=
 =?us-ascii?Q?9X+0+ssst0Ey5w3YXg3AcCELNIjlIW9wb4nCExzaZGm/m32rFhSag2OsdmAR?=
 =?us-ascii?Q?nsIQwI4xnBfbpbHzSV0/hwwVVpvoteQYZTXMg+OZrkFPOy+SSTqXuBu+5k7p?=
 =?us-ascii?Q?F3biocx9vLRMcxcYIfCO4bLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6462b368-271d-442d-0d0c-08d9039ef077
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 01:52:22.4840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9F4BBB8DGfBp5G1aHzva66MuPwikX0h6F4HSDKdu39GZO4UIdpgVx4A/NKkKRbtYInGPMdjvVwzgpGFzouINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 103 ++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..a8a92c533cf7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2179,6 +2179,84 @@ svm_range_best_restore_location(struct svm_range *prange,
 
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
+	vma = find_vma(p->mm, addr);
+	if (!vma || addr < vma->vm_start) {
+		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
+		return -EFAULT;
+	}
+	start_limit = max(vma->vm_start,
+			(unsigned long)ALIGN_DOWN(addr, 2UL << 20)) >> PAGE_SHIFT;
+	end_limit = min(vma->vm_end,
+			(unsigned long)ALIGN(addr + 1, 2UL << 20)) >> PAGE_SHIFT;
+	/* First range that starts after the fault address */
+	node = interval_tree_iter_first(&p->svms.objects, (addr >> PAGE_SHIFT) + 1, ULONG_MAX);
+	if (node) {
+		end_limit = min(end_limit, node->start);
+		/* Last range that ends before the fault address */
+		node = container_of(rb_prev(&node->rb), struct interval_tree_node, rb);
+	} else {
+		/* Last range must end before addr because there was no range after addr */
+		node = container_of(rb_last(&p->svms.objects.rb_root),
+				    struct interval_tree_node, rb);
+	}
+	if (node)
+		start_limit = max(start_limit, node->last + 1);
+
+	*start = start_limit;
+	*last = end_limit - 1;
+
+	pr_debug("vma start: %lx start: %lx vma end: %lx last: %lx\n",
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
+	struct svm_range_list *svms;
+	unsigned long start, last;
+	uint32_t gpuid, gpuidx;
+
+	if (svm_range_get_range_boundaries(p, addr << PAGE_SHIFT,
+					   &start, &last))
+		return NULL;
+
+	svms = &p->svms;
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
@@ -2228,6 +2306,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_process *p;
 	uint64_t timestamp;
 	int32_t best_loc, gpuidx;
+	bool write_locked = false;
 	int r = 0;
 
 	p = kfd_lookup_process_by_pasid(pasid);
@@ -2251,14 +2330,34 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
+			svms, addr);
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
