Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4399CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 22:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E71E10E101;
	Wed,  5 Nov 2025 22:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Hj5d62s";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271AD10E101
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 22:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msiE5FZ4I4DueO/YcNhzvi0qCP13iF+k2NWdjqexRvybt7f666QF2q9/h1NYeb0J4Kkm30gbeaSr0j4gU9dsfzdoupHygh4d2G63yMv/NX6W3I12X/2pubTprcidCT15q+ij6Z0jbVPJrnJfNP2rBeuyWbVXQ2X87z3FJ7eQba6RWQ5tdhj108PGn06WvlolxG300PIQxXLjMbKM4x5qaKj57PGcSD8doOUEcvKYISPdcn/hQl50HHi05HHdSMoNROLOYvG5sSzJmfsKZxWvQ8sR/2gb8sAXA30oXmAI2OlAa1gg2LKPYRZ86Lgwz0Dsr/IgsUoxOzOWn7YyNjCZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV9eQnitkVO1RlCdysA5RYNJc5qPlQ/P7k1qtdsaTGQ=;
 b=WS2ZH7LVKRbvi0BXDaywdYjV9ysj7NVnRLDsqnoAJrkpq/fvkJoWqwSaWFReY6YeKGNChYWBj+lbpWApqYPnwRwJa7krtSJuahd53D2V0iQRzprIwyCJ3SU1puTE0HLTjKB01wwSP7Puat1nlCBTPIhJ36AXAmrOAs0jYS44OVvs6Yl7pgj+X3fbGI1q/RsLAYtSrH/LRNFwfE08UvjTi3zO6kXMEb/DFvkHwPC/TSY28r9OO3UW74Dzs/u4ibM/Fml492MgTMyu1TPOrxxFnMwTu0wwoHaG9rWGyioSsFkweAL7uKWRXoPiV4UmQwvtlLc62PzxhL4+HRL2lG31Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV9eQnitkVO1RlCdysA5RYNJc5qPlQ/P7k1qtdsaTGQ=;
 b=4Hj5d62sTobiRLBqD3Xxu/sGHDiJv8AiSJmyZGXNP4FUbKdPiUnXt8daoW3/6G6rzjeROjTy2ww4x8aUWrJ6QeGKsMqvX17YVFH8ibtqvxg/lxReBY1l7uJ+UM+ZGfBAZqnMGIE8yY5YYIYVM/PSbGt49X8+VB/jSFr3BvBRsBU=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 22:51:39 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::7d) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 22:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:51:39 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 14:51:38 -0800
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4] drm/amdkfd: Fix GPU mappings for APU after prefetch
Date: Wed, 5 Nov 2025 17:51:28 -0500
Message-ID: <20251105225128.3182714-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: b35f38b9-9f89-4322-a06c-08de1cbde1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KetV4EKwyte47Oa8qUlT09P84k4x5uQG4oWqFAfKHvMu2hNT9NMiEgQV+6Ze?=
 =?us-ascii?Q?NmkJu0OFqokMc5NMOe2VUh/9vOqBop7LnHTn71L+FOGk89LNCEXC+4kX0gs1?=
 =?us-ascii?Q?R6MWHWYnsvllUklNOIjqs/rvhVoq77s/PdHKomlwI/XYSVlHmpUTZitQZcd9?=
 =?us-ascii?Q?/MIXIJ5mKk3DBfID1zkl3zQo3gVsTK+gTlwzq4yYv0vZlzDFygQhe2s8nUQo?=
 =?us-ascii?Q?xup1ChH1ryswSqZqEFFU+gawO5jvKVd3SrK25Qs0gE+eIJnrj+GKqDUnf9eg?=
 =?us-ascii?Q?ZmMWVe5n9PuvvHiQqxH32g+CQHBLdr6/SvsqhOg6ZxSFyJJJxd7fOlXFZ8NV?=
 =?us-ascii?Q?nebgmlbXc+Juvh+bB4a+NEHsA+MvLjPuEVjKy+OBbTd0r3cu4mvtURB/xzhk?=
 =?us-ascii?Q?YkVStnov3ZQo4E4uScyLORNSah/+o3xfXZFAVxsuNcsDoSh3xrG0TIjzBn5t?=
 =?us-ascii?Q?Zasx8ei7FLzEWDsczCiikqFCbBfO9WCymaHeMrSBuCvpRnp/0q8nrqZzAp9A?=
 =?us-ascii?Q?W/tW4Yz0ruC4e1RAIDa3Ns0/3FqRvHSKIGIhZZDGUzhZ5el9gbQ3ybPQDc+/?=
 =?us-ascii?Q?D8d1WCqj8hxgm/xtid1eSRr9wJt8RvYPIhrEecL6TXjlV0fBlo7P3EobHxeA?=
 =?us-ascii?Q?E9I4vJTWpGwVNchwOgxKzThGDDMcpqKhpwCqsURI8mzKn87GoPr6uTGtZAuG?=
 =?us-ascii?Q?I1V+UWF9GNjK8dmb3lSX32aWbO0DTkOF2mP0ShDDiSaCjtG+fnxPxB3lS15d?=
 =?us-ascii?Q?1fIcarseSrIGn4SDEul3P90+WMafI+5dHloP5TY44Trg6DF1QgF4hxqz2Xjl?=
 =?us-ascii?Q?2RNo2Bvyw7H6zTaBHYq63kkYh9ksjcBS6fjYGQDuy1KDl2vzS4gLN93NkfRA?=
 =?us-ascii?Q?uPjsoIGeLeZRlN0Kdi1h1bfj9S3GYmnOMEZOpiYMrfpj5eIKdgw/AB1Xpizy?=
 =?us-ascii?Q?TIpcFaLSIFcq3BUo35lsUVQm8haQ4D9YZbwbhCAmmnUjBjmgvwGZJ6jJb9sU?=
 =?us-ascii?Q?scupLjWyua0qdW2TKo8pQ0JuqVPTXreGHf8JZ1JoLr8eyOuqeIw4UcOMybB1?=
 =?us-ascii?Q?nDyyTvNIy03Uny8ZzNliw2CK4DF+k2FT+2m8mx7gKQ74xGVbt1ojLWpE2Od0?=
 =?us-ascii?Q?lwIjdylH5l50ChLnjjxzI23OWVw/UvB+g9NCN8bVk/51x8ZPk14gzysPnCbF?=
 =?us-ascii?Q?rwSHf/KBYdgAY1GhFTHcTctx2w+6zsHN4UhIrXdSAjVvvT7ty9b3n9l2Yr6n?=
 =?us-ascii?Q?OLQU8zKMfp2UHpYotlt6BeW25NtT3QSV8kdnB60L4LRp5Ty+yzV0sIRk83lZ?=
 =?us-ascii?Q?a/OVfK0xgjGMUGBexFfxpFs4wFXpCaiwocVomxHTJUZsjw+xuF34w1oAjV/7?=
 =?us-ascii?Q?HTfTAEqJFjZiNfbv87ZJCKvZdMyQWxkMh2XEjvFsz64/U5MRqMl2P/dXHecx?=
 =?us-ascii?Q?Np+XvGm0Mood29rmPNu6hoglInP8xOzemyKb38ha1/zYpiusKLCwINUPF6qd?=
 =?us-ascii?Q?VPkLHrdBpNV7U+M4fKKupYIMyrt0IiqxEZFHdT/zU0Cajvdnx24SCpM6lt5Z?=
 =?us-ascii?Q?yJM1c4i1TLAA44g7wEU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:51:39.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35f38b9-9f89-4322-a06c-08de1cbde1e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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

Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
VRAM

v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU

v4: Remove v2 and v3 changes. Force update_mapping when range is split
at a size that is not aligned to prange granularity

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..97c2270f278f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3693,6 +3693,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
+	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
+
 	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
 		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 prange->svms, prange, prange->start,
-- 
2.34.1

