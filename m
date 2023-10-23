Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623EDC25B46
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 20:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DF610E255;
	Mon, 23 Oct 2023 20:38:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CE910E254
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 20:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvG+MgV1IrYRNX/hkZywGNz284JBO5HONYtn8MzeDyL1RyuKC8uQ4v/oKM1lV9sePxnmWnboAjtx+mmJ+nWiF0T7nk6nactwVwxlyKMh5f8513GOwDu2lpzbzr9o75OPhhPPcJ0OHVI/J06IK7KI09EvJx3xInv0tQ2t0d5dql19KvoOLhHl23M/OYe0LVTDw6Qzz9kfz/zKGZcL1qfazxkuStrptV9QX0nQhcOGU5BwKXKw1cCfXoxP6/lRYYv2/g1nB4exs8qDRYaiyDofcJrLvVVNZQ3p+PAmWZRh0Zr+Bd893us+mOpZ34C4pjj8UpsJ1ucljEWgkwacXH/tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrZOLhbPlappWqIytRCBdcvL9HhD4cVI7F9LGC2TjkU=;
 b=iVK30SPoTrddkm86Xm/mH5dQHTB/9gfwCOQqKiQSgXj2iNTu6B0u4pdRicLWtfeotr1ZEgsFcsH9w/lBD+sCK0+iTV4m0Q3pm7JHqy/nflvyX95xrf7l0xP8VuhYzJHMN8BWHF80dyC/z9jX1DjBvwah8TLQMY8Z3ois3gTXTQkqb5dU6ruaB4JevYbJdaw0B0IJfo30CecsUCpgvcyTlUihkgwLMoZ4r933RZ7wgl3qX5YrZiS+/h+Rl2jE6nftYFp/hS7e9As9Z88I9WgDje7etLOExUbld+tzSm8F0iX2u/lWQWmLJJJtnhBfp4M48wxYv3R+TFY4xMKj0l5zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrZOLhbPlappWqIytRCBdcvL9HhD4cVI7F9LGC2TjkU=;
 b=eEzrcPx2nYLoJtfySm5w/SxkQnIUXtRNfRcm+k2FLY9+NBMaZ1WIycK57nhvmGFDd97yhy46Jk9o7ehFXNvZmF9h4pTXqd4tzESyjU3wwjcoPehwqaPY2baCaGU1qD7NogAuHSxnMseWWfE9uopiiEdQcWa1DWeU3uHYecX275Y=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 20:38:29 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e2) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Mon, 23 Oct 2023 20:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 20:38:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 15:38:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] Revert "drm/amdkfd:remove unused code"
Date: Mon, 23 Oct 2023 16:37:02 -0400
Message-ID: <20231023203703.31664-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231023203703.31664-1-Philip.Yang@amd.com>
References: <20231023203703.31664-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 8018a626-4864-4cc9-0a62-08dbd40803a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +h2BuwPoIiJ2lB2HupZXWJ+EvJu9pP9QL0eKC+8QwrcU3XFdJTX4YHhA5GbDNXDzl+EezMcivfNK/DI7QH5szlkomuXbUavW9f55VE+TiBLLts9m02N5ae8fdLyghbqi+aA4OClXKUs8yExJ5fyZr5X46VKZQgNA5vqgxRq6KmeE/BGLF+skCc8wyFNGin8n9EHe2FAplvP09EuG0xv5RjNl4UHeH/d7imzIjM3MNTkT3k0zH+u1rYIKakCuKW+VSqYoiML0pyOjU9Tod8MGzIz5MiSkNYjN88GRVG131+YTLsaYcgYczcOqwhmSNktIOOiJ/Jay24N52W7OyWx/uPQmeX0i2WyqO9LoOA9oBEFI9l5cX3sJ5bRliU9oI+AwtEceXRrgFC3TxGd+lWsYVwp69Sexi7zYhEIv15q+jCdllmC7jlGWwzoTIWgAjgVXYWCFMbgRlTybfyUrKQmrlguj2ByGcugSEq9HTJDb5N8/meinMHAFuuPncI427PELDfdqGumDuk+v0QyKWwfG/gOOaI7x4x/X22/tOtYOfKtn8ksOFCa/rWJaCP+0MmYSiV0KUfiGymKO6IxSfhM/O6FIId1xRdTjnqf2B8FTRP8JyjcjbCHmNEYUEbp8DEjZiYhitZcxn1O5lhKw9A6kL+UpIF4cNfeJt+aRT/nEiQ876c5G/1226TiXAYiuC27tKSFUlCXAEYAw/eX0n2eCT1m1C3YXYpYE0lwF3utYkj2BI/5kuqgRFuB+bhaliVwDxhccj1dRrznEtL0HwGcfRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(336012)(82740400003)(16526019)(26005)(1076003)(2616005)(83380400001)(426003)(7696005)(6666004)(36756003)(86362001)(356005)(47076005)(36860700001)(70206006)(2906002)(478600001)(8936002)(8676002)(4326008)(41300700001)(70586007)(316002)(6916009)(5660300002)(54906003)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 20:38:28.7534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018a626-4864-4cc9-0a62-08dbd40803a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

This reverts commit d97e7b1eb8afd7a404466533b0bc192351b760c7.

Needed for the next revert patch.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 60 ++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4d000c63cde8..3422eee8d0d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1145,6 +1145,66 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
 
+/**
+ * svm_range_split_by_granularity - collect ranges within granularity boundary
+ *
+ * @p: the process with svms list
+ * @mm: mm structure
+ * @addr: the vm fault address in pages, to split the prange
+ * @parent: parent range if prange is from child list
+ * @prange: prange to split
+ *
+ * Trims @prange to be a single aligned block of prange->granularity if
+ * possible. The head and tail are added to the child_list in @parent.
+ *
+ * Context: caller must hold mmap_read_lock and prange->lock
+ *
+ * Return:
+ * 0 - OK, otherwise error code
+ */
+int
+svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
+			       unsigned long addr, struct svm_range *parent,
+			       struct svm_range *prange)
+{
+	struct svm_range *head, *tail;
+	unsigned long start, last, size;
+	int r;
+
+	/* Align splited range start and size to granularity size, then a single
+	 * PTE will be used for whole range, this reduces the number of PTE
+	 * updated and the L1 TLB space used for translation.
+	 */
+	size = 1UL << prange->granularity;
+	start = ALIGN_DOWN(addr, size);
+	last = ALIGN(addr + 1, size) - 1;
+
+	pr_debug("svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx\n",
+		 prange->svms, prange->start, prange->last, start, last, size);
+
+	if (start > prange->start) {
+		r = svm_range_split(prange, start, prange->last, &head);
+		if (r)
+			return r;
+		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
+	}
+
+	if (last < prange->last) {
+		r = svm_range_split(prange, prange->start, last, &tail);
+		if (r)
+			return r;
+		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
+	}
+
+	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
+	if (p->xnack_enabled && prange->work_item.op == SVM_OP_ADD_RANGE) {
+		prange->work_item.op = SVM_OP_ADD_RANGE_AND_MAP;
+		pr_debug("change prange 0x%p [0x%lx 0x%lx] op %d\n",
+			 prange, prange->start, prange->last,
+			 SVM_OP_ADD_RANGE_AND_MAP);
+	}
+	return 0;
+}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 026863a0abcd..be11ba0c4289 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -172,6 +172,9 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
+int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
+			       unsigned long addr, struct svm_range *parent,
+			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
-- 
2.35.1

