Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BADC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED056142B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED056142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898656E9B1;
	Wed, 21 Apr 2021 19:41:10 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6466E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm8+PeuAJUpkIo+9TKGtrXqYRKHi3h9138EIS4oJaN5+eYpLhkz4btBrnuJsjFvaQh8JhzNvfioQ9fI45BFUiwZduRaJQg4eb5euYQS1kd5k0DAGgL80hCGSwH6hlg0bO57qGlBdI8qnys3DnGA/lVHuJm1/kWm7YdKwR/TtO+fMntl1FyDO5Aeym5xAxasYk/lclLWrvQuT3zgrhx6xkVQ3HC00Jvq/xNJK7Vx3HmH1mCVpGcf8pYFOOQMWUICAwmGy1PUJ5/CehPIRewaDBvpMjdCMydVjQR11CZgAJK9jIE69RodUaHbpWwkqox6JFEZLaFgXNau2oRUOZ4jj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHt1cZQyWLfKUfH0Xg1HqNkjZRvkouGApj3JK6Hk+HM=;
 b=mj19HHVyExuBtNNZoJWoWBE9jmDY+Tfvmh2Vo7J+ttUSOa+abyP8xTbrmZTBZvgpoczcDZ9ZEphdEcajME6Y09+q872Y3TQrrCIsIfsId82iRV4zsBEvAObYtZMLXFSBYDFQx25SmIrdGl2YrSsuE3y/5CBqOfAZ2duYBz2xUPpOMPvzMrrP9jZroF1sTDJ8bSUC76tBlNqyMeCBB3BUjg+KeBnheAtZUrfMCYStTUXOsf6KZTvfO6oW6Ku2m9cMj2Pv3nhS7B+PpgZ6x+bif4BL8WdqhM0QCRWRsQPrRy9dbj1DM03btrTCXxcYd3fAjv0Pk3bnMxA6Z3Aym4O+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHt1cZQyWLfKUfH0Xg1HqNkjZRvkouGApj3JK6Hk+HM=;
 b=NEKw5FHHtW3revZLIEQEmLjXs8JeIalFjrfPDZemXKcGnsB3Q88mc9tFvNsn2niYbotRZZpgvtN5gNo6vN7aDp1+wwBuPl0f+B3cj90OuARoJC/HVhsph6UgQRw1gyYEkXibf6vO08MpZB8TDWXq9EWQz5c/nIyDN3YNhdBwLV4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 19:41:07 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Wed, 21 Apr 2021
 19:41:07 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: svm ranges creation for unregistered memory
Date: Wed, 21 Apr 2021 14:40:54 -0500
Message-Id: <20210421194055.15893-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0178.namprd04.prod.outlook.com (2603:10b6:806:125::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 19:41:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e8b508-f123-4125-37f6-08d904fd6826
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441318740A31172A52476ADEFD479@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXbHOJmXyWbJH3b59JAElgiuQuIhVDn6FBFh38pr6MRAJXqykY8TP6o5qEACHr9MduTzvsriNedrwODj3vNXgs3OJRIIppn76RyoUPypH947bvqEvxry5NsVmMsBIhZxQOHne+DFkwVG2tUSFNDvXMAgMY1Y5hfYFTcBcUCNlSDkVQyxT29FeywoA39MuDbMRx3B9CLpFzT7HJryE+S/NyAyjbZcoDyeOlCt3ZAFH16d6b+t29lsyu4dO0lFgDAMXLcDpB5FDZeoWyNaBPp1im4WLjfgd3VPsT6I2Y+F4YBfPkqrBFosULiZFk8Sey2rywkLljVoJyeTEXnfsygCEiHQODzn/8v3mj+/Y096qCr5WA/Tx6mdPxVP4EY2zVYp5hewUpcjJ3/sCmH3vH2xYW9SxyGWNOkp6x53t7awn0Jizn/O42ubSkyZsQu0vuEoo60F52izkEl++qPpe9m3+75tECR02GmIZS58zxG1WPkcaDprAIfHWQSBQ2p4hi3E8G1/JFeohURvYelIoJ4gRN2jdKgVIZkoMJF1xU9GNUuB8Ds3tYkzlTg5xq5l0p5n0qyj8jKeN1VJ72Yxjg7/U8NikVhZF5HNxT6hteo73ltgcynj6pPUFD1fSjAMdinZjHVYTcTnMm5p1ZErZW1Y/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(6486002)(478600001)(5660300002)(44832011)(6666004)(956004)(1076003)(4326008)(2616005)(86362001)(7696005)(52116002)(16526019)(2906002)(6916009)(316002)(26005)(186003)(36756003)(83380400001)(66556008)(66476007)(66946007)(8936002)(8676002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oLhbgQgaOL/9/E/RPWch/iZFQ7gPS7sUHYnHzcTVKqFj/NJ8n2mEUOnMcWGJ?=
 =?us-ascii?Q?XxM7iy27Egp+UatEKFUySE3x3/MAd3P4oFjf1UJPrT6QuW72NUxl0cPXHTpw?=
 =?us-ascii?Q?ADDhdnezSbrtyy7vKWFumqYIeSBQMRxUAtxUO8pR9kuDUXiZGQNrz5dt2Fnw?=
 =?us-ascii?Q?UbVP5N8iMmbwx+X+WGnx1WuiARzEJOasYk4+gsWCWiQj1SI4GghzOCoR8XHd?=
 =?us-ascii?Q?dojOozuaEHd6JdwaO724E5XK2tl3ygG4H0DQsoIhEq8agOKPOMaf0kkTUlUC?=
 =?us-ascii?Q?UyRk83/Qy52/tdJnSL9TfiJDLBQ7B3dsPGOOTwFUUZ4MOTS+JN4VU8fFdLUQ?=
 =?us-ascii?Q?65ynazbRLGLuqTvL9ohrAFfiD+ituJ5OF0FyNgLmj+VIpCR2n3LC9lj7Kam+?=
 =?us-ascii?Q?HkmDazZMbLEfHTT1ZfM4qMZri0mOl8qU4AgI9q6LgU2qnmucNjpLSHqFOnGJ?=
 =?us-ascii?Q?uYsQuGmRSWpTRLivKMMb25+DTEBadBRmnBrG+jUqsRL5Q5HVXrkXxS6iRTms?=
 =?us-ascii?Q?Cvg8gj4YjoHHzADRyvshC42OSDGSNCP9PSgkMQZwBKRNXb+jFVBUM5wJeTrU?=
 =?us-ascii?Q?6q+2aO3+M/69F33UCwvd4Iw1GC7SFEBXw80HyEo0HUWEU9/WHXtAdPxZfd4K?=
 =?us-ascii?Q?FOtAuUI+NJeEpYtPnDwsgOjnMd0Uqa4BgUDAPJuGqGKvJ8kHvDM6Dc4be35l?=
 =?us-ascii?Q?v01L1IMv5QXwTfPrWVHs8ylAB/vtRrvt+xZNkZ5MLzFazhBowBSHn+9y8mux?=
 =?us-ascii?Q?f6Tp9qPS5yZmBCPotzqChpaBPnxJS+3rWkEVkCcjryf1ESlSnawGCygvZssP?=
 =?us-ascii?Q?OjyLlzG5KVv5tcB3VM4rXDmsGPbNftVXEBwvZ2Sy6jfc3vjcETt9AbPJlqbR?=
 =?us-ascii?Q?a1ByZ7Uj9PlYmiMAVnbq/G+TK3CXRxq0XI1WNmsg6aPuBAWdZlvVju3kXkwM?=
 =?us-ascii?Q?4quwcCc6JmBu2w6jAUHDqayv+8pYk+KgV6oh+xaPFRsEE5lPlwHS7/h8OrMx?=
 =?us-ascii?Q?GR8rdD7KNaozR+03zXnboJ00Skf/hCYzOQmqfuppX+1j2yOEE8/9paKoe6Dx?=
 =?us-ascii?Q?e4/U3wsnD6FUy5XTxbkeXVoGW/d7joz4IutZO48de3LAiHd2nXgrpNfOiAe2?=
 =?us-ascii?Q?ABpoX+iFh/QD+K+f0nPq3l5RDq4n+Kr/lCddeqtpm629Lutn95Jvm6fTH3Wr?=
 =?us-ascii?Q?4+ILLnKvujQNQoQ2kFioT1CsQfK+WyW1JMTkM2+nQnKDKAMeZ7tGTxCc9l9T?=
 =?us-ascii?Q?ANmot/U+Rj3IXmZax4GDfNW4bFrrjm+7FsoduWaqk53dLhYBvpnMSHcgNvuZ?=
 =?us-ascii?Q?vtpV2f2OibtOxT0Ip3ctrDkY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e8b508-f123-4125-37f6-08d904fd6826
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:41:07.1870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKRyV2hMJ2tBdoym45ye9PAmQZnV8bLuPYpYZ9O/1SaVNxVi6MI9rN3I/1id4Qj0bNNJELD7pPPzpsgg8jdWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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
index 45dd055118eb..99dfbd2dc164 100644
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
