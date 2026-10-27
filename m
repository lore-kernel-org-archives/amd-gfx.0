Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A19606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kh/BJfgP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9698E10F5A2;
	Tue, 27 Oct 2026 14:20:57 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5101B10F59F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZxzbwDrFvrl7teHPXDLIg98zZwi1bx0/RC3QcLxGlOqQ5zFTAw0MgbAx6stvkdz+C1EXHCklFoTcMH3yN4hdOSiaXV++LbCg5b4LTgk5LSo9blM6L9CYEZWVYuj5MXisyfpmCFMSUeCUMt1pLvz+kqpAcvAkOKBM5F/PyqE0RSyyeA+Ci6q5lmFq8VdP1pwACEc/j9f8SelByf01TtsnOW31Ek5q9dW+LyuYhVGcf9SFypjH4uAtfG8hz5Wc+l4gLaVLyA1MhBfJrQO8Y1m35g22bISUsnCCZaXEyjYhiCv0cOht/OGjwsBQXuOLVRLfMQclx1BT1rKUECB4eztuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc94TqwwjpnRvokeXFVxGuzohNVXAGkbOzSb0Gzo+Ug=;
 b=oXS2eleD9cAZStZVN2FcP9Fx8Z7qy+X5IrG19ketgwnIXQlJAWRkHZN6t8EWm2nVedhazpTgbSU2hnzMEmN2kkPqcDF51oyH8uDRilv/vdFQZgPjJoptkA2RK93+yHOo9iJzI5C+enKpbz2e6ggTafogKxkiNwy9Xjg0UQuCNa3thVAx7IwbnI9p5VqeyInFl/vUqgkg90HiRLcAGpqKfbHkwizgr9S/ol+fvLI2bepRQN5flmO6hIjyxiey0pE8lqj+OdvLQ827H1OPx8fjrV8rYMqE88BYKiRVzxFMrDKk7swrsfmfHHYOaWKcCXyuP8GLFnjAudaN0qgRtUNH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc94TqwwjpnRvokeXFVxGuzohNVXAGkbOzSb0Gzo+Ug=;
 b=kh/BJfgPUMk994u9C+4P8Vu8Gny8XeULnI3YeowUuZH6Dw3MevpfIh8HzJyzKycRPujnpI7YGFQL4U6k5mXGlPHPm56TjT4jga179qztDIIF4qujMS2SJGJ2TYoEFIZ/MVCKmLbYIUPt2H5G2OYlBiqacneNzSGZDdj+vpaeXmI=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:20:47 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::6c) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 14:20:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:20:46 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 09:20:45 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <arunpravin.paneerselvam@amd.com>, <christian.koenig@amd.com>,
 <kent.russell@amd.com>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH 1/2] gpu/buddy: find range-biased blocks in the free trees
Date: Tue, 27 Oct 2026 10:19:24 -0400
Message-ID: <528396fd339c6d7130c896533a621a20f709bd4e.1793108566.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793108566.git.William.Palacek@amd.com>
References: <cover.1793108566.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 694e730a-feff-462d-8c15-08df34357e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|261026140227099003|261021123027099003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sQq8IvHt60L1oqraKhpnE2HVV9CQkjinJhCaAT0EUOUiS7s1zOYlNIZF3hEszY/EhD6EusQOhoYYV0uusQKdeoQlOjpo5QMCKAIwuvrQMrb9MA7PnKFvpx3ngn2BNzA1VY/pELuiaT8moaYJSB9Je/5OGZLGfKXNKDye8bMe9Z2IWZBTieqLOIk7uFyiWSx3Uigv97lo2sy4JjPKx35jfoX/i5b6B8jEAYX6a80jAiSIVZtFEF4N+ScH03wL6/vGkzbFgAXbVkIDyVQ3BYYK9U2miT5pIrLpaibSoe3gktWq5qja+y1oFUU5cRt/gjvBIAu7zWauf4dX87yScsqQGjk0t/RuedLyzSKX8+8ZIKbnnNr50+POnmnu5xLXppxyIzhSqmxjgpmq8niLtK8UOSCiGv2rEBjCxViB5Lav1XVI4V2lipDniuzENpdbZhX6wiYmWyyLBnJNk3FTDL71iYRsKPJlrexPJdAID99thfiNZzghdAPELv9bZuYbUar9asUeTK9zWaFJoC+1dZ+KYc4tRjKBEbYDnnKkzcbSi6BAYQm7ju21BzKj5w/UeOYiCkYKC1kVFPvDYjs3s9SVxPc8niwl8wJl1QAd8t8Dd/Le9x4UrJcQnuz6CVHXMi7/gLvzFBXDYIzH/tJ93KuXHm69gEct1vIw337YU6TdkV+U2Xx0T6cSSEf29nsMBBTTo+aY4fSfpdzMnKBCjn7zBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(261026140227099003)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TaJdwbf+AiJ4CxmZNOkt+R4kxOZEP2YLCObRUNULe54whZPM2hp+y1psf8HAXJiEAFvc3wHJEzyTOMsDV/heFl+CimfCS4Fi0jffwF3MoPhD/hlDKU25fi4IXdvVmKvYhdtuD483EcJ4i0fESKW24Wko5DCRd0nKxv226cDEN0NY/G4JujLlOM0ntIO65TEaXjtY1dwjbXmtS+Py5UuEHTPhB1vwFcMW5lQ3vAlBED7VRp3iIX/s5QLeEOxq0g5x629t1Qtbu2m5tJS5l6A+PRVRPFGdaJR3xO7cj9D63F+4Gjwu0ysCCGtWqVNmPbGDIwAssxrdP4SFOpABSS60B7qaupCgITOIXv1jLYBe9CmY0bGpXkIug2puOfXWRN6Pz6C3rqKRsW/eL+oUBBDSVAnsxvOsTN80VbxmJcgJKwmExDcwNe83xf8Gf2Y0kRUx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:20:46.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694e730a-feff-462d-8c15-08df34357e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__gpu_buddy_alloc_range_bias() walks the block tree from the roots and
visits every split block overlapping [start, end) until it finds a
suitable free block, so a range-restricted allocation costs time linear
in the number of live allocations in the range.

amdgpu pays this on every VRAM allocation when memory is partitioned
(NPS2/NPS4): each BO, including the page-table BOs created when memory
is mapped, is restricted to its partition's range, and KFD requests
cleared VRAM. On MI300X in CPX/NPS4 the compute partitions that share a
memory partition also share the VRAM manager lock, so the walk is
serialised across processes. hipMalloc latency grows linearly with the
number of live allocations, and vLLM piecewise graph capture slows down
with every captured graph.

The free trees are already sorted by offset. For each order from the
requested one up, look up the lowest free block at or above start,
preferred tree first. If it lies wholly inside the range, run the
existing walk restricted to that block's extent: it only visits the
block's ancestors and keeps the existing split and error handling. The
full-range walk remains for space that is only available in blocks
straddling the range edges.

Behaviour notes:
- the smallest order is tried first, lowest offset within an order;
- a free block of the other clear state inside the range is preferred
  over an edge-straddling block of the requested state, as the existing
  fallback pass already accepts either state;
- when no free block lies wholly inside the range (range nearly full),
  the linear walk still runs.

Filling 1 GiB of a 4 GiB manager with 64 KiB range-biased allocations
that request cleared memory takes about 1 s and 268M block visits
before, 2 ms and 410K visits after.
On MI300X CPX/NPS4, 8000 live 2 MiB hipMalloc allocations: median
latency of the last 800 over the first 800 is 6.2x before, 1.04x after.
vLLM piecewise graph capture of a 70B model with tensor parallelism 64:
57 s for the second graph rising to 113 s for the 17th before, a flat
5-6 s per graph after.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/buddy.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index a5553fcec28c..3a1fbafe42dc 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -120,6 +120,12 @@ rbtree_last_free_block(struct rb_root *root)
 	return rbtree_get_free_block(rb_last(root));
 }
 
+/* rb_find_first() with this returns the lowest free block at or above *start. */
+static int rbtree_offset_below_cmp(const void *start, const struct rb_node *node)
+{
+	return gpu_buddy_block_offset(rbtree_get_free_block(node)) < *(const u64 *)start;
+}
+
 static bool rbtree_is_empty(struct rb_root *root)
 {
 	return RB_EMPTY_ROOT(root);
@@ -846,9 +852,39 @@ __gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
 			     unsigned int order,
 			     unsigned long flags)
 {
+	enum gpu_buddy_free_tree tree = (flags & GPU_BUDDY_CLEAR_ALLOCATION) ?
+		GPU_BUDDY_CLEAR_TREE : GPU_BUDDY_DIRTY_TREE;
 	struct gpu_buddy_block *block;
 	bool fallback = false;
+	u64 bstart, bend;
+	unsigned int i;
+	int pass;
+
+	/*
+	 * Walking [start, end) visits every split block in it, linear in the
+	 * live allocations. Instead take the lowest free block wholly inside
+	 * the range from the offset-sorted free trees, preferred tree first;
+	 * the walk restricted to that block only visits its ancestors.
+	 */
+	for (pass = 0; pass < GPU_BUDDY_MAX_FREE_TREES; pass++) {
+		for (i = order; i <= mm->max_order; i++) {
+			block = rbtree_get_free_block(rb_find_first(&start,
+								    &mm->free_trees[tree][i],
+								    rbtree_offset_below_cmp));
+			if (!block)
+				continue;
+
+			bstart = gpu_buddy_block_offset(block);
+			bend = bstart + gpu_buddy_block_size(mm, block);
+			if (bend <= end)
+				return __alloc_range_bias(mm, bstart, bend, order,
+							  flags, true);
+		}
+		tree = (tree == GPU_BUDDY_CLEAR_TREE) ?
+			GPU_BUDDY_DIRTY_TREE : GPU_BUDDY_CLEAR_TREE;
+	}
 
+	/* Only space in blocks straddling the range edges is left. */
 	block = __alloc_range_bias(mm, start, end, order,
 				   flags, fallback);
 	if (IS_ERR(block))
-- 
2.43.0

