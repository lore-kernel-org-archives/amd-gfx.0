Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B9EF070F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 06:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316D210E25B;
	Mon,  9 Feb 2026 06:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AHTpkod";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BA810E28D;
 Mon,  9 Feb 2026 06:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGbRB3/eomDnXvPCNDKvcV9L2F/61BoVdWdHW0ynXRUW4rF4B+G2fhFvw45EQTwugSZqPtEvE+hmJWXBhRV1Mogb7A+u8VR9hapwqapANYv0qfx91ilPWxQ5dqPkWZgE316bjfWQT1N+2o+VhK9kVwgUci9EsJ821peYdsJYy/9Q348etys1/XDcIEybyyKoqlq3apEQOggGxfSUcvnClHv1879xX3r2I7nYpJu0pDhjFx3E6sHsvX1Hzcrl7bOshi8WNd7H6W4hZ+tsFXwvBX+zWeVza0o1fRYmBjNtcfFHAgiTUojPl+xpvpUR/rCFsHBEz6utulkU783ekI2Lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fat2crwgVVMpS8nDqnqoL80q3yRb7P+5WeN+syyubH0=;
 b=Ln8ZjgrZEzxYnSirP9o2R3Jscig5FLvVx+45jA9B8af6vnpvAyeqywHcXA32G5WSwxz9YrvxYxcYG9i5EshZY7SBvad/sQPU3fL/1TytlbJbjfbiezkXXVgCuZeJxR/gRjInw4mAcp5coUiMRIUON56CQQ8vN4j2Q0W+R6TZbX5eJPHyQZiR2XflfABuWDmoagtftkJCadlVQtzQp+QvDVi0YGe7siDE4LMPsoDTD0/UyxAg+VJ+FB/Vt+emWaax+SxaQdE2Ytjjyfkt9dHeqOEE/vA6gXIz4xj1fZ/yLTEOAbcQPQO4iNnOZ/s0xZ6fn6W7HbCmURa+fY9HN2f7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fat2crwgVVMpS8nDqnqoL80q3yRb7P+5WeN+syyubH0=;
 b=2AHTpkodr83qYDKH0VeU+usZ2cfVqTS1WYcpnbTZA67HRASNV2qdYu25cOie6EdOV6kDtr5zsYzroto+fLtQYY5Fn3qTcReRG5Mpb4/utccyH4uFNp373mO9Mvv7VTeMmD9ktiFyWZNxyB9E4lXMjn6EaWtP4kE+bIFKT/0vUlo=
Received: from PH8PR05CA0001.namprd05.prod.outlook.com (2603:10b6:510:2cc::22)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 06:11:20 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::76) by PH8PR05CA0001.outlook.office365.com
 (2603:10b6:510:2cc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.7 via Frontend Transport; Mon, 9
 Feb 2026 06:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 06:11:20 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 00:11:16 -0600
From: Honglei Huang <honglei1.huang@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <Philip.Yang@amd.com>, <Ray.Huang@amd.com>
CC: <dmitry.osipenko@collabora.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <akpm@linux-foundation.org>, <honghuan@amd.com>
Subject: [PATCH v4 5/8] drm/amdkfd: Implement batch userptr page management
Date: Mon, 9 Feb 2026 14:10:44 +0800
Message-ID: <20260209061047.3881808-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209061047.3881808-1-honglei1.huang@amd.com>
References: <20260209061047.3881808-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 147ab57b-0b3a-409a-c15a-08de67a20b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9QJfp4DXzpYBgl2PjqjmoFwZjnfX88UIvEQRcUxK9wEeKT/raC02Icp4lVyp?=
 =?us-ascii?Q?1iJhgr6N/2C6rUZEf5CDn7f4PTfGLebP/5xYGW2tr9jzbYJif0oNAXF53ktR?=
 =?us-ascii?Q?MWDmNPpuaY6PLRrn7sCHwR4ZLH8tbYMsYqNT8OK4CfAUdxDVf0s2hDG5ILXY?=
 =?us-ascii?Q?bd2r/PDpB3mCN2yb/PXpA6I9brCylc89gMswwJ8Aa24PwwOKoNnbLv2GHh8V?=
 =?us-ascii?Q?H679aF8GyRND2SHk7ch3ijopJ5zxBjICBcLFBY0ZaEqfgLmA4iA/r4YQ0hZa?=
 =?us-ascii?Q?eXobs8bZj0B5ZlbakZsU9fVFvw2JCRTaFNc7wPjZDdU69VRavwmdnZIU8xVc?=
 =?us-ascii?Q?ubjqX8gcyBvfOJsGibhwuvYFxWxkYxos4fF1DJILyZp5TetoF4RL8wzh6GNF?=
 =?us-ascii?Q?x4CQb24ZrMc9GF3Ea9oKL4jCY+o/GtBG9lsJd+sB1ZnlVXrEXfO7wYE+9zdO?=
 =?us-ascii?Q?RbmCSOkCRIf+jxPRq9boquYyCUHzHbOjI6VPYHJ/BPFPjFbWEYI7cWK9v255?=
 =?us-ascii?Q?8zQtej0n/nVwgArAAVuUBjc/1aWVJiLt+r98Q0f+9WxmaQXet2SSO/LbqUSU?=
 =?us-ascii?Q?Z7KCJcZhWjmULbqpicgraTKHI92oVqKxrj0xxZaG/TgFDSUHWlXdzoCcfMko?=
 =?us-ascii?Q?Ha9iQ1b0Tz4KlcOET2u3/UmzfZNWzmzKo4GciJ5A05QVEg9zn2mMld6xsDUu?=
 =?us-ascii?Q?D/djVLIjuQv6fYZlVB44wRcLgO8i/ynMqtoOJqqvB0RQe09GX6qScJF5NbtT?=
 =?us-ascii?Q?MlBsm+q4XmIUcjoTX+7lOIYXAHUbU7lPMJ5lUfkpZ9iB7k5B2Nbx3ZWZmnpd?=
 =?us-ascii?Q?yXiHCG8KGuu/e/+kfIbanTGu69gum8AKnDjzNtBucCDnLTxIw13MriOP1+JY?=
 =?us-ascii?Q?TLlYPdbjX/8I9L7Q7Piv65W7q7iWkBsDG/Q0XH+A2iGs7Qr7iTMieBxWeUqW?=
 =?us-ascii?Q?XXhqYSu3Cs4zaebqLUNMWy3k7LcGg6lTjo/0vvrdMGQWClillTZL/Bj+I8Ga?=
 =?us-ascii?Q?utIYbZBPUHEz0B41ogaVNA+7zOXxdZ+lLDTIE3Epi1pp3heW7+47zW7QAbcj?=
 =?us-ascii?Q?G1R+K+4Z2s4EMggrTjdopVDL9kt7MHatp6Uka4pmRqBd+DrXrVCP70Endf4b?=
 =?us-ascii?Q?rrmWerDpLUErVJv4sjtgPL2huNoN+6UWxFuIx7lJ8WCvvwZat1aLgZ9wRLEB?=
 =?us-ascii?Q?7DFZYtpwKNE0RHW4jEJpLHkHnR1MHl6egmj3XVLChYPl8Bda3dGJTG3uQs2S?=
 =?us-ascii?Q?qYwTPHLAWqOnqhoZIJau/vmXDW3tNXqSPsGLYZzjPihLZp/VSX6I09IgMbFt?=
 =?us-ascii?Q?xo9PzYDzWOmBU5t/fC/O6DBKnkNT//EWal2BlhO5bcG+6aqoP9qOIHVA8qKM?=
 =?us-ascii?Q?OilOEJjvvGqDhBk2h3/HK4FQTXwaXi8UkFz5YFqwdWKDdxsUQTIU9wxa/qxr?=
 =?us-ascii?Q?Q6Q8CJxmOkrkMz3rXjbvXe+IVDj0IEFDHughigF6ITwG2n7qvaTjPQtZ2DsO?=
 =?us-ascii?Q?JAjn4se021nJyYFTP6IfXf0qHucK5wW3NMmsJyf8c8qjlkJQjbQXvU0ZMdgE?=
 =?us-ascii?Q?AdmM8BatcRU5Bs1mAJdssO948oSRM8PJFV6Rs+4skzVgt5Hl7fA2oJxgKRBI?=
 =?us-ascii?Q?di5Rl9mDA3e/d6pCXDDdp79/PZFc6YCng7ze2awEq8e8RBqsEHS8/9ZGxMH6?=
 =?us-ascii?Q?ul5+tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HxWErg1lo40DW1SIfbajB3YeuzEyYYlNMLrk6lGYhb/uHKkj/kWVpk1Tc+yu9D5yFVHrWMjPL+0HZsxcCmaPGvJsG3yehruDOQKKYUaLcgTJqSDZNHiBkxO+fAX/i1DSQVMbAlQIvkYIBMiXttEdptPgMNGeHNy38z8GxjxNB8IO52IonB89qp1RAlSOovENfhefjnnvxwO9Al4i6Rx7s/CDkZkQiv9FZmQoMVZ9+7F0ZgLhLUNSo1Sqb6JJIVDHMjdpquWm/TdYzsrAoRJh14n6uHf2Kn/7lTaPm5IAFjo3h6nQ62PCnzw7RdYssYWs+lTKn2V4Y4KDqq2LTbnc/U/WWX3qtzTeNnnzpkOxklAPiD50RlYjte6b7WMMPOZ6lQ9YH5q78olISQdkGwFFLnBe/TOJSXdJrxJ6wPYsOxI9xkZ7z2HSwbqKwFn5V+nB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:11:20.2243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ab57b-0b3a-409a-c15a-08de67a20b26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

From: Honglei Huang <honghuan@amd.com>

Add core page management functions for batch userptr allocations.

This adds:
- get_user_pages_batch_locked(): gets user pages for batch
- set_user_pages_batch(): populates TTM page array from multiple
  HMM ranges

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a22a99b8d..5f10a4514 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1202,6 +1202,51 @@ static const struct mmu_interval_notifier_ops amdgpu_amdkfd_hsa_batch_ops = {
 	.invalidate = amdgpu_amdkfd_invalidate_userptr_batch,
 };
 
+static int get_user_pages_batch_locked(struct mm_struct *mm,
+					 struct kgd_mem *mem,
+					 struct user_range_info *range,
+					 struct hmm_range **range_hmm,
+					 bool readonly)
+{
+	struct vm_area_struct *vma;
+	int r;
+
+	*range_hmm = NULL;
+
+	vma = vma_lookup(mm, range->start);
+	if (unlikely(!vma))
+		return -EFAULT;
+
+	r = amdgpu_hmm_range_get_pages(&mem->batch_notifier, range->start,
+				       range->size >> PAGE_SHIFT, readonly,
+				       NULL, range_hmm);
+	return r;
+}
+
+static int set_user_pages_batch(struct ttm_tt *ttm,
+				struct user_range_info *ranges,
+				uint32_t nranges)
+{
+	uint32_t i, j, k = 0, range_npfns;
+
+	for (i = 0; i < nranges; ++i) {
+		if (!ranges[i].range || !ranges[i].range->hmm_pfns)
+			return -EINVAL;
+
+		range_npfns = (ranges[i].range->end - ranges[i].range->start) >>
+			      PAGE_SHIFT;
+
+		if (k + range_npfns > ttm->num_pages)
+			return -EOVERFLOW;
+
+		for (j = 0; j < range_npfns; ++j)
+			ttm->pages[k++] =
+				hmm_pfn_to_page(ranges[i].range->hmm_pfns[j]);
+	}
+
+	return 0;
+}
+
 /* Reserving a BO and its page table BOs must happen atomically to
  * avoid deadlocks. Some operations update multiple VMs at once. Track
  * all the reservation info in a context structure. Optionally a sync
-- 
2.34.1

