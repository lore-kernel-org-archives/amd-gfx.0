Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E09C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CAB11345A;
	Tue, 23 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6E0UB4R";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADFE11345A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYq7r/VX4F05V9ySgEdLVu52hOjRb7KKBf050uMAWZbnfLpiAk4+87OYSW/OE40dpiZCQE4lspio0egm9BFUIJlfhw6ZyEuYJPAvccLS023Q7eHWNIu/8XF7mlgV3NYdjtdEtX89snaWFPghDLf3m7g8DX3SzVUfCj7mCS6t6uupLwJt8pGLe+pHV0yQgRXcnZmIV9y0+dsYBhmgP56ccfB8zDbE1dhjl3DpK4bENV3jWjq0V2ZYOB0wuyJyduxeViMIQ8TD5CrFwOXbll8OiCDnytNTm6CigJ8t2GjxdDthSDU0bY6nRJhEUReiYmApj2dtqJBpvk/4rP34NEbXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=fiAzSKQCMRLLG0L+R0P6MkPSSbA4LhcyahPMn435xaJKlH0Vl/8/c7W4307OA/PSp8zCKeQ5vOSx8uVc6H3KvG2Y727G/R4frODIe9HYSs7NhQIMRLf/UIhq2jBx21MF/eJsCPUq5cE8O7+3avNfKsDwCyTyTSkInnwJOo7P5DE6JPskzVtRyTHqRF/YphmmCY2yjOFyJvKr8q8LK2VBmKCVPQ9wd7C55YmAx9h7SEnwTkk5M03nGkNaLwTHBYZ/pL32g1nrbNWx7TGwrgoL4Bfqc/aYejPW00HWq2Ffs/zaZQnqaYKnyXJ2/UeOzEQNK6exU+TFHEK8DUXSlEzUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=i6E0UB4R3ibxai5u2VQz9VI0iqtWB0Ovtw2tRYbem2mtykw7o0SUMBsvc7J69wa0cLDWCZ8DyMwusqw+roIlqQlg3F0snQr5cjAcB2zgOVlNq5etER/3pYOwupVU/0peDmHjwYyG2v9pstSxIKtzrUgrtpsOMhoXeOTbSrGQudA=
Received: from BYAPR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:40::18)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:35 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::44) by BYAPR04CA0005.outlook.office365.com
 (2603:10b6:a03:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 3/6] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Tue, 23 Apr 2024 11:28:57 -0400
Message-ID: <20240423152900.533-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423152900.533-1-Philip.Yang@amd.com>
References: <20240423152900.533-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 81dd31dd-c443-49f2-8bac-08dc63aa2e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWq9ztObm7NstV/9lB9w40aKj3krYpy0yHPKOGp9TayFSSxjs98GtXS9zD14?=
 =?us-ascii?Q?0ozSkWzgCjvjA7ZtzGvnT6bkMN0RvHQHytMKzLzIw+G7HoSECIWiay5mK+ZY?=
 =?us-ascii?Q?5ZOezEhKXexFKlko7gogOI/rBR5IM/JjdwHhnczMrLQO8YDh1P/t74o2RL2P?=
 =?us-ascii?Q?/uNvqLaQTcJM4c7+vSSxWSpBIBAibDrHsMOUjOeo3l50UUs7a//6y5Il0z29?=
 =?us-ascii?Q?UkoLd3peRPheFT4h10Qwo8cYbQkIHcotOXMaENM4K57C6VznpUzSXPUChqpM?=
 =?us-ascii?Q?7UxQ+XXVqweEM/dhMg5kN7N0jhO2XA5LN2Y88LxH6UtTCprItXWqBU37jBr9?=
 =?us-ascii?Q?VHEK07UinLtFlUxVvVY+3l6CQlDrEvc+ajnfR2gZpilIyFYz3NiI/5jtUqAR?=
 =?us-ascii?Q?n5m9zLn+0oKstbq5QEqNqcUlcWGqavA8grrqCR+MndxarpOL5bnMK+qzElRr?=
 =?us-ascii?Q?2xWVadUCoxhz3RK6TRwu+fpC6gD3Zkl79QYzbJ58g0Sk1S4dYDZa1YFrb2Mo?=
 =?us-ascii?Q?ZZ9gdniV4/2xh46tlBOsyY3/pMa8FR8EM6ub4zZ9Mo5J2di7TOveSEEH03iF?=
 =?us-ascii?Q?IZlzSEOIqvUdoOAqlFQbMVYPu05M2BmCFvORXDp7Ckla01V1/HWd9gHbkIoF?=
 =?us-ascii?Q?a/vh+aZhMZGuMpy8nJ58/dCoUgVAVdAZPaystBoc4yv38OOKqhIfCLxSD/xV?=
 =?us-ascii?Q?4jRbg+JCwt3wNEVPVPFX4hn1jAKcgAQxFaJEKGdC2lD5NrSxnB4Ag8dBC+VC?=
 =?us-ascii?Q?Y3d+tj9kCKDdvsbxE2n80qEg4q3tCHX9c+wuJyMK9Oq1DBqqBmxN+tuoyE+y?=
 =?us-ascii?Q?tJzPCzrHIp9n3YHwboh0KIWVgc16rURzw3A1FLBoUJuMLNaONzaW4h8WSEQg?=
 =?us-ascii?Q?NxKTl1v9dTNNBbmMr3bMpRDoXhJ3FI5yuStVe7Y4/H8ONK/nbb0vbpfjgT/X?=
 =?us-ascii?Q?XWoGLsPtmedgy6TGQzm4q5ax31zKVXYQQcxbrILVYLYkgMAp6VEzQJpH7IGS?=
 =?us-ascii?Q?VQXwi5Tfls/hiSyHH1LfRLYq45seECebRsHYkOS+IiCy5EOnT6HiLu8RKTzf?=
 =?us-ascii?Q?IHBAMlfLQqI0v8NNrSgt5Kil6qqSjtYbp+o1N42BcdVjK0TefCDAJXzV9Rsk?=
 =?us-ascii?Q?838ISJe0hvBoQiKLIbNQLwS3INlHffBxMm1sGcuEPU/BAQGvY1ANVh50/05g?=
 =?us-ascii?Q?4TkXtxITW7f+H2dyK9VCcuqAuVBM/7EvB40He0d1Pw7P0M7pB4gdM6C+4GaV?=
 =?us-ascii?Q?SzWq6nO+uKC6xoNpfI1qRHRYyxM1NHXHq/a/JLq9gAT5pQMa4AhAd/c/pxxM?=
 =?us-ascii?Q?xRqwbA9yJx+3hV/cw1PUpnFw/LlV4S/hhE5oxjbZfs049OfnDCEyTG4gF5C9?=
 =?us-ascii?Q?0LL8LkoOjyP2u4c2ljjPcnMt9MC9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:35.0654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dd31dd-c443-49f2-8bac-08dc63aa2e4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
memory then retry the allocation, this skips the KFD BOs from the same
process because KFD require all BOs are resident for user queues.

If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
TTM evict KFD BOs from the same process, this will evict the user queues
first, and restore the queues later after contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 851509c6e90e..c907d6005641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1398,7 +1398,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

