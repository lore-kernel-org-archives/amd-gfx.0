Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31288C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250B410E4F0;
	Thu,  9 Dec 2021 16:53:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B0289ABE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbKEeQiiCDEtCCzf+q+JtRBJzgHgdqgUfCgPTLs2P9r9NACE1ExeGutp7QfKEVH02MUNwxYNKuXOyFjdbiM5ux3iUSxBBNVDjZPr5mhEdpLEP7j+XQDlhb3mmNt+ojL8wX48CtV4fABcyCxiEvNGXqsQos6ZlysKp+vt7Tpid/EmL7mUIGkKFsFajkhN6pCfMKTGPtrdRPK4wTtekRZiU3Ck9lWdlg9xKJx5sMYdDGSKByQX3uobOtHzCXDOJSvlORdStzPlHwl88crERFgLkjjssyANH3K4LnFDcqNj1FqoOe1WWgUuGE/kpNfNUuIfk1GlRGGN8Od63YYl1HM5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzQeprX6hYXLCCCZKtJF3WzFwbtBRFtrUgcYDP1wzxQ=;
 b=eX+qc5O2gO+cQoPWVOHEc+pokL7Fw/OFm3awTutysa/ifnQMF/RuiwUmoJ3Nytj/FKleG/Tfq6n8FOaSSCmHfPUB9OswueUebyZEvkS4N0NHuFe69fNBohyeX/wktmNZcReIAN3gIdjoyfQ+LXI9uyBTMtbg5RAOcdwXIJe5euT3yU2NOqApn2AXaZkZeFsofdnBn6u+jGBeZj5wlU0Cz4fxOOTLsopcMXcSFis5cmASvg1agPkGf7fR+c2xWP2gd2v9G4CRHr3KzNwzuV8Ymyl1aPxR+Q1OIKn81JdBhdEOiebUGJUuCgYKHVahIVSk/7ocEJrudu6VYKzEjxRSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzQeprX6hYXLCCCZKtJF3WzFwbtBRFtrUgcYDP1wzxQ=;
 b=AgePxjm/Q/0qn4f1eRQyS55v+9kiCkGpQUU1jSmfOVHjoc/ix5/dEgXGlNeSp9BUZdHmZe9KgAQ9SStDz2jOlA4L4rTNLGHUvE7u/cDTvCd9Ul8CqT1oCLmeCRERBEwDFoYm1wgWO62sI7kz4kVux57czavfUUyOh92ZzinBDeQ=
Received: from BN9PR03CA0647.namprd03.prod.outlook.com (2603:10b6:408:13b::22)
 by MWHPR12MB1518.namprd12.prod.outlook.com (2603:10b6:301:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 00:04:03 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::fc) by BN9PR03CA0647.outlook.office365.com
 (2603:10b6:408:13b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 00:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 00:04:02 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 18:04:02 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Use prange->list head for insert_list
Date: Wed, 8 Dec 2021 19:03:39 -0500
Message-ID: <20211209000340.974954-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd431ae-d3f2-4a6d-b59b-08d9baa768d0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1518:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15184582A9C72C37CB7168D992709@MWHPR12MB1518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3N6HlMrOFISETh6pDrES2gKbCkkn2Ff5hnDwP+/ZlUp5bESglutSrAlbuw8kpOA9MSpXHP6zXurp7LKguFEFupdlrFn93L36WkjSCRGRfgaiAVUfT47vUmKsXHWFT5hNeRqyo7Z8Mgu+iiota3pJF0NAJk7kfJj3JZ3PDwk4V73Y6XkhKWIch/okaU6azobDDrq5wdIxuK3UVOz6bEHqRnSJDaGGjV9awZZK6Wb2Su5lPabzTeFn3TYnNmYmskMswm4981Thv3C92ZvsIKaYUVCiYIolNn5GDYqfa7ulkA7CHGnF2Gd0gehyBLId9mbpvcJRXvPTTWbeB+/mfXnqymIHxKftqMn6EoUeUYCwSK5cl6wdfHFgZEesc4MPJUOOa26bAoypYalxc5KQmN3BH8GUKoe6xZaUMlrmnTeLd/9OegwnttrHJYSS0Zl+Nf+GNW3+5fTpFNt4BqWyTv31biWeTN2PXaISftxlUln6QqLd1jMIZHyadPpkhzYjenl7+4TWPvwwrcwN/yHP1WaArdsVDJ8YVir7VEo+5Z2DoWN6a2Qp2cOv0m+pgMTshX5Ied355LKr/WV57Aq3IEtIAv/0enKThGc1eSTp4zGgRay64LuwRn87K6NKgNwUVncYp7wNs9Gk1Ms9fShSjQg2ZHzPQXNL+DCNK3SsUEjihAyR40ORYWs8vSqFwTBDuwYGgm3xuyq8WQEzX5iiHkez/LyzedpGE+zkpukyZ8yJNhGWLhVMuB+A5bFjDTmIIUxpvL4AVfkcgqluorwlFEYtn34E28brfNB44zB7ke2mTYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(2906002)(5660300002)(4326008)(86362001)(1076003)(316002)(70206006)(336012)(7696005)(40460700001)(36756003)(8676002)(54906003)(8936002)(356005)(82310400004)(508600001)(26005)(36860700001)(6916009)(47076005)(426003)(2616005)(83380400001)(16526019)(6666004)(81166007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:04:02.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd431ae-d3f2-4a6d-b59b-08d9baa768d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1518
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
Cc: alex.sierra@amd.com, philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are seven list_heads in struct svm_range: list, update_list,
remove_list, insert_list, svm_bo_list, deferred_list, child_list. This
patch and the next one remove two of them that are redundant.

The insert_list head was only used for new ranges that are not on the
svms->list yet. So we can use that list head for keeping track of
new ranges before they get added, and use list_move_tail to move them
to the svms->list when ready.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 --
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c178d56361d6..dea7c6236be5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -107,7 +107,7 @@ static void svm_range_add_to_svms(struct svm_range *prange)
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
 		 prange, prange->start, prange->last);
 
-	list_add_tail(&prange->list, &prange->svms->list);
+	list_move_tail(&prange->list, &prange->svms->list);
 	prange->it_node.start = prange->start;
 	prange->it_node.last = prange->last;
 	interval_tree_insert(&prange->it_node, &prange->svms->objects);
@@ -296,7 +296,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->list);
 	INIT_LIST_HEAD(&prange->update_list);
 	INIT_LIST_HEAD(&prange->remove_list);
-	INIT_LIST_HEAD(&prange->insert_list);
 	INIT_LIST_HEAD(&prange->svm_bo_list);
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
@@ -995,7 +994,7 @@ svm_range_split_tail(struct svm_range *prange,
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
 	if (!r)
-		list_add(&tail->insert_list, insert_list);
+		list_add(&tail->list, insert_list);
 	return r;
 }
 
@@ -1007,7 +1006,7 @@ svm_range_split_head(struct svm_range *prange,
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
 	if (!r)
-		list_add(&head->insert_list, insert_list);
+		list_add(&head->list, insert_list);
 	return r;
 }
 
@@ -1880,7 +1879,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			}
 
 			list_add(&old->remove_list, remove_list);
-			list_add(&prange->insert_list, insert_list);
+			list_add(&prange->list, insert_list);
 			list_add(&prange->update_list, update_list);
 
 			if (node->start < start) {
@@ -1912,7 +1911,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 				goto out;
 			}
 
-			list_add(&prange->insert_list, insert_list);
+			list_add(&prange->list, insert_list);
 			list_add(&prange->update_list, update_list);
 		}
 
@@ -1927,13 +1926,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			r = -ENOMEM;
 			goto out;
 		}
-		list_add(&prange->insert_list, insert_list);
+		list_add(&prange->list, insert_list);
 		list_add(&prange->update_list, update_list);
 	}
 
 out:
 	if (r)
-		list_for_each_entry_safe(prange, tmp, insert_list, insert_list)
+		list_for_each_entry_safe(prange, tmp, insert_list, list)
 			svm_range_free(prange);
 
 	return r;
@@ -3217,7 +3216,7 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		goto out;
 	}
 	/* Apply changes as a transaction */
-	list_for_each_entry_safe(prange, next, &insert_list, insert_list) {
+	list_for_each_entry_safe(prange, next, &insert_list, list) {
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..c3738bd35a3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -76,7 +76,6 @@ struct svm_work_list_item {
  * @list:       link list node, used to scan all ranges of svms
  * @update_list:link list node used to add to update_list
  * @remove_list:link list node used to add to remove list
- * @insert_list:link list node used to add to insert list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
@@ -113,7 +112,6 @@ struct svm_range {
 	struct list_head		list;
 	struct list_head		update_list;
 	struct list_head		remove_list;
-	struct list_head		insert_list;
 	uint64_t			npages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
-- 
2.32.0

