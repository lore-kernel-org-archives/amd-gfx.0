Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0244C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 08:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3566E8FA;
	Wed,  8 Dec 2021 08:25:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020776E5CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 08:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpEk+t186uJWiFdqr73N9DnKjCHuESucO8tRjYBXtQLEiV+Yehg+pig5QgFdMWhJeJzScH4E5i7n26+9lkh2ccUDCUJ+aMtTeLAYrWlJsEb6VewtCeXOCOX5XNSk93Rx1A10Qk6oSwkAfyDj160IAWBBDI7G8YPUyAjEM7+Uv12Nhdo8SWJGBR2O06XEvsMSmvcoY/I6d+IIn/jpQncOpcmhAFbfKeyaZkwWNlIgd7ZZ+aATdQDa+czlSTsYDxKbR39rOYDCSWCO0a2K61soP14CZF6ERdgvoQ3kfaPNjyu6dNCnnO/6MFbWdzjISppgVaVeTJrQF1fjJJJdg2pX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc9AZ7GgERQgNp3ZFAo07i6l5Kj3p2dynQBGgEsUdIk=;
 b=ldt+r5IPw/iutYOVIq8riEOmU/O2Bu2aJ6zOIHDzl+ArZfh96r9aIHkhkmLzD2qgf8sBC6JZ/gqb2GYZmSLbg+k/i2BQxWpF9e41GS8ZMovLIOYbs0bMr+N5X4+gA7+RabkGL5ziewDNSnCGQ8P26VjfHwi5Vird/g6UwhKN8uBsnS0zTTTeDuh+Pg4MQ+Bo6TB0qSZzihgltH/f9c+cMsvJOQvdM9cKzHn1wag1U7Uj8tTHibLBSNWwmhsHNLZ0oC9IzGoyvL4NLBptzR/BMnMQmrj4iJ+Mmu/3ube6/Zn6BU1796q5svjp1Wnf7pU/3YWgI/OtOuTdOgq9wMqkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc9AZ7GgERQgNp3ZFAo07i6l5Kj3p2dynQBGgEsUdIk=;
 b=iR3RfaS9BX8PEGUGSx1zOwucMKHLV8xFPhAnnqR9WFlySah18BJ+bN3WivPIALvmtr3MADn1yZ6yBuk7w5T4faAUilvy+28A+EFaobXRHjjP80A6FXqwTA2LOL07PPiwBryTuEVmxylD9k396+TTyr5xqIa26SgRC/sXIUL8QAo=
Received: from BN6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:405:2::15)
 by DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 08:25:13 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::b4) by BN6PR11CA0005.outlook.office365.com
 (2603:10b6:405:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Wed, 8 Dec 2021 08:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:25:13 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:25:12 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Fix error handling in svm_range_add
Date: Wed, 8 Dec 2021 03:24:55 -0500
Message-ID: <20211208082457.918004-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1155002-cf08-4bfb-feb5-08d9ba244188
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2505BDC0D575351000744F42926F9@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vgid01Z3//mouqPtRuTChBzsOsWeSDym4ahjAJiTrriVsKVsUNrorGTTzDvbEJUQp5Vbnl+tFBBdSWFc3VvKFH9GUrVPHo6Pns2vodfy8APOM35ivQV8gc7nVXm6nS8PBM4vkjxMtR3eYfVgoC8ecAB8urXqK4FzYq3QFJu21rTykUN+LT3SqKYdk3uxj9sVuiU2t4/B1+TGq3hs08QfVTHxxMdOTbqb6GFfI5B9bJbKKChrRowxjsT/lWw21yJkGcqJf7rCttPNwiV65HtHaMmOTz8Dq+18w1e/w6GK8LyYIjtBvXs90jEXilFCg21IpBW5XwB9zam7z98sYYMWY0ML4vNpbluzPGoT+RhAEKBEhYxXbxqAxGev2KBPGjRR/BiuwzAS/maZB4Xh8CRq8p2vWYTG/rsDplmBfGTSLmkk32Dllc4y8R/8EJsO7GOnPlYH6pirxk/YixROKvM36LP21Gzzi6X7Jkap0GWAA2PZqHvd76JGABQBV+3reCtff4AYa5QnXXEEAP26Lqa8arkYQFPKAYCuR/KypBwxGBdfGY3VelHXdmB0wsuI08/SSy6YDFCpHafQb+enPP7WiGpG3HbopWpII+YYiU/Er/Q7DBC0EFd7YxMeod715HhuTSOFb8YCFXxkyBnARLaFW9Yda7ilJBUtQq09U0KWJyVa6yLO7B4xXo30DfIXtADxbwLA3Oiv7tRArm4r0RF+8lhdK/vcJhrOvl2ZKKARJsfAf5BA9ezvcZny9AEsQKLs7s88+/PytgKjq4oafwqoKFE3Ut6btO7mrKAcWP1du0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(316002)(36756003)(81166007)(336012)(1076003)(508600001)(16526019)(40460700001)(6666004)(5660300002)(70206006)(426003)(186003)(70586007)(6916009)(47076005)(82310400004)(7696005)(4326008)(8676002)(83380400001)(26005)(54906003)(2906002)(356005)(86362001)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:25:13.0253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1155002-cf08-4bfb-feb5-08d9ba244188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, Zhou Qingyang <zhou1615@umn.edu>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add null-pointer check after the last svm_range_new call. This was
originally reported by Zhou Qingyang <zhou1615@umn.edu> based on a
static analyzer.

To avoid duplicating the unwinding code from svm_range_handle_overlap,
I merged the two functions into one.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 138 ++++++++++-----------------
 1 file changed, 49 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2db49c7a8fd..ed4430e31307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -941,7 +941,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 }
 
 static int
-svm_range_split_tail(struct svm_range *prange, struct svm_range *new,
+svm_range_split_tail(struct svm_range *prange,
 		     uint64_t new_last, struct list_head *insert_list)
 {
 	struct svm_range *tail;
@@ -953,7 +953,7 @@ svm_range_split_tail(struct svm_range *prange, struct svm_range *new,
 }
 
 static int
-svm_range_split_head(struct svm_range *prange, struct svm_range *new,
+svm_range_split_head(struct svm_range *prange,
 		     uint64_t new_start, struct list_head *insert_list)
 {
 	struct svm_range *head;
@@ -1754,49 +1754,54 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 }
 
 /**
- * svm_range_handle_overlap - split overlap ranges
- * @svms: svm range list header
- * @new: range added with this attributes
- * @start: range added start address, in pages
- * @last: range last address, in pages
- * @update_list: output, the ranges attributes are updated. For set_attr, this
- *               will do validation and map to GPUs. For unmap, this will be
- *               removed and unmap from GPUs
- * @insert_list: output, the ranges will be inserted into svms, attributes are
- *               not changes. For set_attr, this will add into svms.
- * @remove_list:output, the ranges will be removed from svms
- * @left: the remaining range after overlap, For set_attr, this will be added
- *        as new range.
+ * svm_range_add - add svm range and handle overlap
+ * @p: the range add to this process svms
+ * @start: page size aligned
+ * @size: page size aligned
+ * @nattr: number of attributes
+ * @attrs: array of attributes
+ * @update_list: output, the ranges need validate and update GPU mapping
+ * @insert_list: output, the ranges need insert to svms
+ * @remove_list: output, the ranges are replaced and need remove from svms
  *
- * Total have 5 overlap cases.
+ * Check if the virtual address range has overlap with any existing ranges,
+ * split partly overlapping ranges and add new ranges in the gaps. All changes
+ * should be applied to the range_list and interval tree transactionally. If
+ * any range split or allocation fails, the entire update fails. Therefore any
+ * existing overlapping svm_ranges are cloned and the original svm_ranges left
+ * unchanged.
  *
- * This function handles overlap of an address interval with existing
- * struct svm_ranges for applying new attributes. This may require
- * splitting existing struct svm_ranges. All changes should be applied to
- * the range_list and interval tree transactionally. If any split operation
- * fails, the entire update fails. Therefore the existing overlapping
- * svm_ranges are cloned and the original svm_ranges left unchanged. If the
- * transaction succeeds, the modified clones are added and the originals
- * freed. Otherwise the clones are removed and the old svm_ranges remain.
+ * If the transaction succeeds, the caller can update and insert clones and
+ * new ranges, then free the originals.
  *
- * Context: The caller must hold svms->lock
+ * Otherwise the caller can free the clones and new ranges, while the old
+ * svm_ranges remain unchanged.
+ *
+ * Context: Process context, caller must hold svms->lock
+ *
+ * Return:
+ * 0 - OK, otherwise error code
  */
 static int
-svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
-			 unsigned long start, unsigned long last,
-			 struct list_head *update_list,
-			 struct list_head *insert_list,
-			 struct list_head *remove_list,
-			 unsigned long *left)
+svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
+	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
+	      struct list_head *update_list, struct list_head *insert_list,
+	      struct list_head *remove_list)
 {
+	unsigned long last = start + size - 1UL;
+	struct svm_range_list *svms = &p->svms;
 	struct interval_tree_node *node;
+	struct svm_range new = {0};
 	struct svm_range *prange;
 	struct svm_range *tmp;
 	int r = 0;
 
+	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
+
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
+	svm_range_apply_attrs(p, &new, nattr, attrs);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -1824,14 +1829,14 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 
 			if (node->start < start) {
 				pr_debug("change old range start\n");
-				r = svm_range_split_head(prange, new, start,
+				r = svm_range_split_head(prange, start,
 							 insert_list);
 				if (r)
 					goto out;
 			}
 			if (node->last > last) {
 				pr_debug("change old range last\n");
-				r = svm_range_split_tail(prange, new, last,
+				r = svm_range_split_tail(prange, last,
 							 insert_list);
 				if (r)
 					goto out;
@@ -1843,7 +1848,7 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 			prange = old;
 		}
 
-		if (!svm_range_is_same_attrs(prange, new))
+		if (!svm_range_is_same_attrs(prange, &new))
 			list_add(&prange->update_list, update_list);
 
 		/* insert a new node if needed */
@@ -1863,8 +1868,16 @@ svm_range_handle_overlap(struct svm_range_list *svms, struct svm_range *new,
 		start = next_start;
 	}
 
-	if (left && start <= last)
-		*left = last - start + 1;
+	/* add a final range at the end if needed */
+	if (start <= last) {
+		prange = svm_range_new(svms, start, last);
+		if (!prange) {
+			r = -ENOMEM;
+			goto out;
+		}
+		list_add(&prange->insert_list, insert_list);
+		list_add(&prange->update_list, update_list);
+	}
 
 out:
 	if (r)
@@ -2883,59 +2896,6 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 				  NULL);
 }
 
-/**
- * svm_range_add - add svm range and handle overlap
- * @p: the range add to this process svms
- * @start: page size aligned
- * @size: page size aligned
- * @nattr: number of attributes
- * @attrs: array of attributes
- * @update_list: output, the ranges need validate and update GPU mapping
- * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
- *
- * Check if the virtual address range has overlap with the registered ranges,
- * split the overlapped range, copy and adjust pages address and vram nodes in
- * old and new ranges.
- *
- * Context: Process context, caller must hold svms->lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-static int
-svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
-	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
-	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list)
-{
-	uint64_t last = start + size - 1UL;
-	struct svm_range_list *svms;
-	struct svm_range new = {0};
-	struct svm_range *prange;
-	unsigned long left = 0;
-	int r = 0;
-
-	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", &p->svms, start, last);
-
-	svm_range_apply_attrs(p, &new, nattr, attrs);
-
-	svms = &p->svms;
-
-	r = svm_range_handle_overlap(svms, &new, start, last, update_list,
-				     insert_list, remove_list, &left);
-	if (r)
-		return r;
-
-	if (left) {
-		prange = svm_range_new(svms, last - left + 1, last);
-		list_add(&prange->insert_list, insert_list);
-		list_add(&prange->update_list, update_list);
-	}
-
-	return 0;
-}
-
 /**
  * svm_range_best_prefetch_location - decide the best prefetch location
  * @prange: svm range structure
-- 
2.32.0

