Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 08:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704766EA15;
	Wed,  8 Dec 2021 08:25:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9626EA17
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 08:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHxOnFcglnjACtSZ2yG+uGms2bGv+gkM7L10UX3O8Bxo9AWgl4sh+bVEJX7+n6bS1xrWQVpbyPTUB11Eh1G+zg9kj4u582iZdSCqx9dz5yXv+8vmnsNlIuOkBnotw7HvUj0lYIXuPCjD+Vtyxnj3MHvyxcjkZBWQzQdQyB/fmQlrkb3QvRj+3e5sZUX+r67G86KdOs/1ZaDluJodDpSaGnlGY08aU78/B+Yee593hzfhOCWR6oiOKU+lQzglRUexaN2+F34h00b/2ZuZeGyUe2C54cIFDP+nA0Aa0jQZAird4D7f6m9RuDQeg2bHM1EaTWDBj39cErCTRaah5B8ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msBXhPZDrMFnxQoDQ/79Pe7RkgL8yZq6244P3EZW61o=;
 b=OfgWzb1ZM69R04kcUw2Ja3A56DHrDGCaYPlWu5wq9MJciqtF8mKPy4DYIjQSVCcYzgyFsBe2WMvRrfYMiRnh+3pBXcXrOzizDeJP6urGSYyKl11qaa4YWz6bxQWipPaDTFIglxWOQR7AGCYzTQWmMUpROCfvShSmtCXUIJm/+aBGYAGaWxUvuIxanofTWtnQXdoWGS3pRvmQGQjoE3m9Xt5sTChQ1k+OYXObGaASwNXAS1xtu7TLosolXru35JZUnfJzBAVznupFF6AWi0yDYYFVr82/2l0Gz+VoD6znjXIqagviAPhE+gz1pWnwYqUGCHOmbBvHC4Hllg7I6US1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msBXhPZDrMFnxQoDQ/79Pe7RkgL8yZq6244P3EZW61o=;
 b=QuFnHd9LaON1LBMwgBhBqBli7GlnLGq6kcB7ZLFvQjaIqjTKDqHESrgd7nAV07GKKZGfLQdIK+leq/9+jJxUHI+xOYIEpe2BgtqFtflvt3Iwzbh07cVm+UzLjaQbH5TYx555MH3AykX9P3+laX+oexxBwWnPqCS7mCryjeLWDV4=
Received: from BN6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:405:2::14)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 08:25:14 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::c4) by BN6PR11CA0004.outlook.office365.com
 (2603:10b6:405:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 08:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:25:14 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:25:13 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Don't split unchanged SVM ranges
Date: Wed, 8 Dec 2021 03:24:57 -0500
Message-ID: <20211208082457.918004-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208082457.918004-1-Felix.Kuehling@amd.com>
References: <20211208082457.918004-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031adb57-f962-4615-2c21-08d9ba24425d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB255955A342E30824E63C70F8926F9@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIvJIx529fQhDwbMw43mZSqcc9dVhGGOrsMBzVuw2KphFRatQxtEWyGcSnmNyum4J4cY3ViNunWRfp5G2tuIRsqTYC14PWsyOe4m8vWLTI34Vsc1BLql/hQ6qpmS2h+/5p+6xnvWbnDSoFvbyRtJxv0WjarqUV3lyvxk7H0MV2pR4rlveV8ldQ0Z/7hTvWVYxbY97oRtChh0M+dShNjKbSzZKX0h0J5karKWbccq+23eayHlp52ICkZkFSLMAiCwMCE9a0AmrVfN7njW1eZuUOY8d3YaKGIk+oRZZXz1h0m+uKAve9BcnCQqCtkgZavHSmNdJUBbmLZhFNh7J+ucYtwygj/aYaes9yrFl7hygB9nd7g1wags9Ns/pIGxZJCTOgluivJHUeo+C5HueVaatlRWkR9nSlWDbGVrrzmuW2e5/81i0i5pu81I03X5GVHDD1jZiKmhKMM4qgtx2xsFponaApEjmauviEf10WXm25jujG2O9Ap1q7w7BNbr8QBbilmNCpHf7bZxrtwYEZRowd+mCiBL9YFTJBWx7LYhCbhvliWZTUqe3688WTCQKGteh34+Bj/SjK1rwhfiPCOjJFlcCnhHYRoHsc91blC/yzP5btHT0CgnDWSKD5C/7tS0c+wtG0NCCirHcDSrrAg8vHhUEJJ333B2q3tYadHBBE0Gz9MvGGTx8O6VSF8HIEJlC8rl6iX2zwtHL48/4iwFGzkIFlz9UQB+3bgROht4PENN+FBbWqnetSoq9jxo31Dd8xclAphPszNU2bOcCJNJ/IpDW0mir61nVDh97wd87P0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(5660300002)(508600001)(47076005)(70586007)(6916009)(16526019)(8676002)(186003)(26005)(70206006)(36756003)(2616005)(6666004)(426003)(336012)(1076003)(2906002)(8936002)(7696005)(54906003)(4326008)(36860700001)(356005)(81166007)(82310400004)(83380400001)(40460700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:25:14.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031adb57-f962-4615-2c21-08d9ba24425d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
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

If an existing SVM range overlaps an svm_range_set_attr call, we would
normally split it in order to update only the overlapping part.
However, if the attributes of the existing range would not be changed
splitting it is unnecessary.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9ea3981545e5..c93a26e6318b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1853,18 +1853,24 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
 		struct interval_tree_node *next;
-		struct svm_range *old;
 		unsigned long next_start;
 
 		pr_debug("found overlap node [0x%lx 0x%lx]\n", node->start,
 			 node->last);
 
-		old = container_of(node, struct svm_range, it_node);
+		prange = container_of(node, struct svm_range, it_node);
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (node->start < start || node->last > last) {
-			/* node intersects the updated range, clone+split it */
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+			/* nothing to do */
+		} else if (node->start < start || node->last > last) {
+			/* node intersects the update range and its attributes
+			 * will change. Clone and split it, apply updates only
+			 * to the overlapping part
+			 */
+			struct svm_range *old = prange;
+
 			prange = svm_range_clone(old);
 			if (!prange) {
 				r = -ENOMEM;
@@ -1873,6 +1879,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 			list_add(&old->remove_list, remove_list);
 			list_add(&prange->insert_list, insert_list);
+			list_add(&prange->update_list, update_list);
 
 			if (node->start < start) {
 				pr_debug("change old range start\n");
@@ -1892,16 +1899,12 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			/* The node is contained within start..last,
 			 * just update it
 			 */
-			prange = old;
-		}
-
-		if (!svm_range_is_same_attrs(p, prange, nattr, attrs))
 			list_add(&prange->update_list, update_list);
+		}
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(prange->svms, start,
-					       node->start - 1);
+			prange = svm_range_new(svms, start, node->start - 1);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
-- 
2.32.0

