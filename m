Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A033AC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C87B112B11;
	Mon, 22 Apr 2024 13:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LxIPUAR1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C973E112B10
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHjxVMML+VUCtROkqKU8yuRz3UQ5QzcPhdqjoEm6K//G9CxNdxrFsDJXeoP2yenvLmXl0GAXItbm0yu2TlSaHKTAGNO8iDmZ1yXiPrGv5kdtyux9/oSHyWhUDRwA0tqVdx6CUyJTMAgAZ91ZtbYPlo7VYCndbAXGUTOgGjioqVotFMuvHNVYDy6oIsMSm2YhqdGGYuD56iBiAPzQJbwwaWf+uGtuHNyv4lfqytvh2tk8/+Z2K5UcCjHP3aMcSVNaenWzf9sF3TTxBWUlGH4nZ7s7GjIF+c6xVt2SgrkFr2OExayg+dn085Q9Nw0OC9ztfd1s/x6QC1hHtz/Esr4EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9gEi/0V9eRxLj+/Q3QLZxE7K+858TFB6I/HwqxnJu0=;
 b=bTJ6s6+EbsnB2ZzwVrw4dydfMj8SwqkoBLhGAXtlulKc/OBRDDOevq8JXxQQHl77R34cGhV352+Z0y82PA6v+mT4eZJwbMSzV6RgJtCRD2Qkc8C6xydilWkZr2ErE4uVqsevKItxaMo5x/HxRec6/ws9vFRNVaWFrvAMwnbni3WLOg+NvJfT6JJfxNR2nHHNJcYCAdZB/CuvnZMZcPc3vq1jlUCn+37G3H2JJ8RHbgH8PBMMs1V0GTbzHHYX+Fs41dYoWuLLSY2+cFm/D3bnFHGPok3tMcHl5/QQY5bvPAmDOVLxhlFvwaMEgE1V2wgRzSv5jToa3iUY/RGjTWFE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gEi/0V9eRxLj+/Q3QLZxE7K+858TFB6I/HwqxnJu0=;
 b=LxIPUAR1VBg0Bx3oAPvY38zIcXPW1ggCBs67NxMzcdQGnkjW3yPwSQcYRNKTNuJrAiQkOACuiWYgEi1Yzc5LXj2ssV3RwPuX06j7wh1Ni/ZJypGLitRkK70yjYYJDVlCAcDNwUyfvXIOUD4jCXfcBFUMgCcTT25rLXzya6qNDOM=
Received: from DM6PR05CA0053.namprd05.prod.outlook.com (2603:10b6:5:335::22)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:57:56 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::ac) by DM6PR05CA0053.outlook.office365.com
 (2603:10b6:5:335::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:53 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 2/7] drm/amdgpu: Handle sg size limit for contiguous
 allocation
Date: Mon, 22 Apr 2024 09:57:20 -0400
Message-ID: <20240422135725.11898-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: bbad8b6c-b7a9-419a-ae6b-08dc62d4363d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H/QuaDZP4EF8V7DIO4oy2rII/tL/IOw+sNJ8J0zgs0BK+IHGQBDujmrI5oRo?=
 =?us-ascii?Q?noeSREn82Kwo08FYy3x2Kn2aYIlOPuY5yoBObYupg1cBmDhnx9IrNYxgK53v?=
 =?us-ascii?Q?ABIx+n9k1UkhJ4h0jAvfxNGTnFoc2ioK4Om/UMqMSxvSlwBRQydt8u3YNcF1?=
 =?us-ascii?Q?7B3/oNUmWEW1wPZscjH007pTwMVsvGqwpjWuLfk5RqIgqXwLcDuljtD0tr7g?=
 =?us-ascii?Q?3ka7wHIQFOnEYAhJXMR8JW1pCd5v43Yb/lnMz7Gk9+vzYjuoGRuK0Dt23yHK?=
 =?us-ascii?Q?oIf5yfEaFKDApa91qnQP3/YANWidYQQqPRwFne2FZ4bmYMJpVsJIuUeCUb/p?=
 =?us-ascii?Q?U3mna7GCEJs3OLvU7PEnDo0Bk+fhN96Bu083PP20PNFgH/Pta5r16cqMD8TT?=
 =?us-ascii?Q?/+OFs7OJTFozXPxlLvOB6UeHNSySeOLtucfhG9TdDpp21GRewoWi3yWgC9Lg?=
 =?us-ascii?Q?yGopcvSyJzOQTnO/3kA+DpF7003rxFYKHvXHlfcZFidcOdgI0gDBcIzh5nTL?=
 =?us-ascii?Q?FZ+nXlrjbS1b0ITaQUKq2ADlKzFGhmhTFKLBUh8tQioxXEiidE6elO1aKDJL?=
 =?us-ascii?Q?ITUbyFxnfcr16/QmHGV4tNe3dVCTsNEKQ+K7fOhhel01fVDjTyrbVu1FtRKm?=
 =?us-ascii?Q?mXOMZYu7qMhf2LzidP+Ejcbf9siVULBUTCAzT1JgxHYi5ta29s3+kS7/PSWO?=
 =?us-ascii?Q?2qoG17zSbsWVQWihdSfooLtiCA8WRcfgWoK5E7EnBVLzV8GGSJB4KwOLR2uq?=
 =?us-ascii?Q?dDDhs6OZ0/GXSqXO2vMGbIpbvvMUhut9mv6/eY1JI4AdSqSG145rtWZo6M1T?=
 =?us-ascii?Q?mIE8cmeDOuJx2h2Uk3py8yqkY11+OOMs2FWrBBhx8c7ybsdoITxv6q6rnAhQ?=
 =?us-ascii?Q?sNx0ImTauYOf8ZZp18Q4puC4iAHF2MoIU/Tse7LwKO9NOv+c7/3Cw8StU8fq?=
 =?us-ascii?Q?Q8JT+cVL181595CLOJIO49tQA85jQS9+pAyMc4wNFdelqftxVfQ3aN26fQJs?=
 =?us-ascii?Q?EH02A0NSeqnhSAA99elKvyIIc2Q35TAwEu1qcwLgrwAACpwCZflBO9A0jKXZ?=
 =?us-ascii?Q?VIqFFNv0aesT988D8mHQC2ZKMAVILZDZiemxF6QZd1nKl5Gxove74hLS/WHN?=
 =?us-ascii?Q?ICAs8fSMilOOpu0xIFHb2qvNf+LTsRy7zrSeeq85ffctny3CL3pNUZDYiv/W?=
 =?us-ascii?Q?GygGzvw0DV4pkRcxmw+AjE3Qy6vGWnio5Sh8P+WFyBaaPNEL3DgLP/DAlGSh?=
 =?us-ascii?Q?XwrBuK1ZapRw2Pls9KpNz6o/VLWKOzveSqGJeWiD1842vS28uLo0oODYOn9N?=
 =?us-ascii?Q?G0r7XuKi/mksO85ZmgiBRREheEjeji7KRHJ7nGPziwfd+EynGBsl5GLhHJ9P?=
 =?us-ascii?Q?fbhXvJzpsYy2PjPmA/xAXnLB5I/v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:56.0024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbad8b6c-b7a9-419a-ae6b-08dc62d4363d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

Define macro MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist length
is unsigned int, and some users of it cast to a signed int, so every
segment of sg table is limited to size 2GB maximum.

For contiguous VRAM allocation, don't limit the max buddy block size in
order to get contiguous VRAM memory. To workaround the sg table segment
size limit, allocate multiple segments if contiguous size is bigger than
MAX_SG_SEGMENT_SIZE.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 4be8b091099a..9fe56a21ef88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -31,6 +31,8 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+#define MAX_SG_SEGMENT_SIZE	(2UL << 30)
+
 struct amdgpu_vram_reservation {
 	u64 start;
 	u64 size;
@@ -532,8 +534,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 
 		BUG_ON(min_block_size < mm->chunk_size);
 
-		/* Limit maximum size to 2GiB due to SG table limitations */
-		size = min(remaining_size, 2ULL << 30);
+		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
+			size = remaining_size;
+		else
+			/* Limit maximum size to 2GiB due to SG table limitations
+			 * for no contiguous allocation.
+			 */
+			size = min(remaining_size, MAX_SG_SEGMENT_SIZE);
 
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
 				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
@@ -675,7 +682,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	while (cursor.remaining) {
 		num_entries++;
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, min(cursor.size, MAX_SG_SEGMENT_SIZE));
 	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
@@ -695,7 +702,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
 		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
-		size_t size = cursor.size;
+		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
 		dma_addr_t addr;
 
 		addr = dma_map_resource(dev, phys, size, dir,
@@ -708,7 +715,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
 
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, size);
 	}
 
 	return 0;
-- 
2.43.2

