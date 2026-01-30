Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FFEE6BF3C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 23:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CE210E0F5;
	Fri, 30 Jan 2026 23:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9cABMTN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CCC10E079
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 23:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2lGlmnFK2aUPUN1pXW34fOH4PdUXB3ULoIyK0h0vaL+Z+3R9CHPFMvlypAHrDGs0wIGToocVhzr5Zy3z/v+ADX7QlMFq1FyYHaRmIyKhsMQQ4mZcTOYmYc7KSdCn7ZDfo25OQHWen4UssGt4nzG6x2horNeaq9u5Jy+/0rrmtAooI8qyCf1x2bBGAxpL8YbRZNh/9GD32acsbg8xye+Uw2YV10QUaBWBuERCMuyBpw0B2Cbm0WzU6RYGVZFKpBCAssCHo9cGZXdXM34BcNwwUhx4QpogMca5Yk1bYiGcjJWdlC67q7SG+FkyJ5e/XCOES8MZOFWRkLuRAX8pEri/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhfQFoM220uvi5qrva4kXUrpDubMAt8OK0NVWqDEXuM=;
 b=KzGL+L6Yiv+LilLyPxnSK3SH5iwDYMzv8fCu8bhZBrj5E7QEoIxBjl+iXWgA3nZzPTiFMpMkwDOZp3r/L3rJnwfDJEegM4WaJK+iT5dWOKGyb5O61XUjIgamc/HlF0vjX2Zzaa8v9kl/LYMhQsio3wTH1VuL8o0XCAvbhnFTWJX0KhVRKhiBPOTrfZacxHk5x9RePvKH0HAZsOZs1dqNYpjWA9pCkTwZoxfhmvIgmhd4um53mb6PpXTqagT3hlAZvOyA2L5p2iMOQf6312HwXNWe6iXBPNZ7vOnkD1yL6rnrXB8PgJ9+ZFh9atXRgbJlDqYm1ZhyrvjroiVORnFnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhfQFoM220uvi5qrva4kXUrpDubMAt8OK0NVWqDEXuM=;
 b=R9cABMTN7KqboTJMryJTcC/uTiAYtcjDY1PTiI15VsFdLL3NzwGS0iGey1a2l/JrRNxwVM5qDteB5Aa4OJdjldHfd1d7XV4Z31eub55xLbQL/kbMkbCEcXJZQiwqPWAeqstpi2hnM/Y02HlyJiq7p3jsc/njaYEf95swjceX75w=
Received: from BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 23:48:09 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::da) by BYAPR05CA0055.outlook.office365.com
 (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 23:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 23:48:08 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 30 Jan 2026 17:48:08 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: : Set vmid0 PAGE_TABLE_DEPTH for GFX12.1
Date: Fri, 30 Jan 2026 18:47:56 -0500
Message-ID: <20260130234756.414348-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e723e6-c0b8-4bdb-d3b7-08de605a057d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iwMarSQuegz9gJo0drZgOu0Yc1QjMdf/B0QVxMdlriZA7FRQHSzcD/CnAeJd?=
 =?us-ascii?Q?SuKsq8KYhPdFodXRKSvZ70rJ/KfTHoGB7nvpNvFi+i206aNtIXkSgI5R59yE?=
 =?us-ascii?Q?7b5jNADRVl5ORMUgX/n4OPuJdFEglXBhXY9EJZu4Gp5paCpgDCNA30IoFZhU?=
 =?us-ascii?Q?1/gNhmKDaabCPYp0+UOQeYl+wrvO5AH1FQX4se4Q7kfgqqZ231zBnlLiBfC4?=
 =?us-ascii?Q?yQRnZOJ92rFsd2udfRmX+dP4LOdAZGvRUr6HlFJMdqTURd+0TYUoIfdx6A6P?=
 =?us-ascii?Q?JXB4VvVhqlC4V6a0AYk/WrJ0kAf4Q7PYWEducbQA1iIiNyF81BdM8vrjTRKh?=
 =?us-ascii?Q?XmNqHmaEscK2/2u5fyVjQhgIdzXHfTQCyhWIJgTMnJZpV6jEshlfRKYU8bGq?=
 =?us-ascii?Q?qriDMvu2vnMWvWYKRyVUI/yQiF02+QEOyps6mOdfzait1rvugVK+OwCtpfbX?=
 =?us-ascii?Q?GHcFeoJ9Q7Ua1h6tnS7HJ5Fw0i1dyL2EqvZKNJTsMWaDaE2zWXpFuDmYZ4UZ?=
 =?us-ascii?Q?CXQ9x29vJkgXyQkMdm1NK0aZdZWPYN3WXnII3yfBd4EaphIwOCY1tziQIyV/?=
 =?us-ascii?Q?rAkQi7lTlXy0oeZFlk0XCNmpEvMc/rQYSVDsO5ss99oR0xoBcT1dqYB8lHk1?=
 =?us-ascii?Q?47x1za1LkufCcFwmldKyFz/X/NqoTRqLUU5tPt/4nVfedHKHhHyOW2ey3xs5?=
 =?us-ascii?Q?yfO9Ny1Ld9r1TM0HcbnxlkfheNLe86nSMfWXmkR8MAB2gaRsE9KKHMzNaCko?=
 =?us-ascii?Q?yWOXjzIILn/n4PMRiIoqcm2CkASsTWpah9pTBva38bmws9TRuNlzcd7RwMok?=
 =?us-ascii?Q?STFYTt5Lq8O7uiVBZ46fUzs/jpeOEfojOh7lnu3JAtDGfROuYPId5Np864QK?=
 =?us-ascii?Q?NOdo/lmyPb1P/wVBQiICL4NjI4vcGZ7yFy6HZ537CnXTQ87+1+e/vZjkP6CK?=
 =?us-ascii?Q?bb9RyBOE5iX+1WZMDtLhHlyBRTQ/ubwmpeC/HqNNjNMGuXYAecbP0ZGBcwIA?=
 =?us-ascii?Q?0pJLiCrT/CUBp2/uxCcnHSJ71nbv9vrrUzPHJnIKvmzgBIvUd7MZVgmoDhPO?=
 =?us-ascii?Q?pzIxEQDT1cR7M64R4enFReQwZESOEvrBeRr26g+3+on3QViy+aOD61yPdC82?=
 =?us-ascii?Q?WhQXoVlDycEqDntglgYzgcnTbjluAFmgAl0pWBJdfrJLkoPXG7iUN4ZVJIsy?=
 =?us-ascii?Q?1wMR2ElIeqnwv37Q8bE6PqI1jqDGZ3IPvHUZRkSeqPqsCKKjOO0JPkLNdspR?=
 =?us-ascii?Q?lQnBnDpvTezDZOgz69giaFqTOXraOFbGyi1iljEI82nnb8YJBAiJ3bCDphSz?=
 =?us-ascii?Q?9wVypRBswTbNd601t0/kw2MlgcC54wNowpUikiBLE18VOIjPukHzsxZgc6Bz?=
 =?us-ascii?Q?2wlnZ8lS0iVBKmZ3ggEFKjqMndna+ZcJAX/mDnSx99UZN/hAQsaQr3sAPmBf?=
 =?us-ascii?Q?kqHUrSceborj0OfEm0Dj8q8wDrNXtTEpaCSajXyS+CVrHsP6Noo6/ecEUFSH?=
 =?us-ascii?Q?Psh2/1COQIOTG7dLMiQqG+/8iSlkQuqf+zz9yxqdI8U0tDSa4h/pufCrg2/V?=
 =?us-ascii?Q?kXJAzLw38nYgLevZHI+J4Y/R3S/YvHrgXLCOJv6doAIrSVlzZuQp6t3vhPnt?=
 =?us-ascii?Q?hjn32Oyo9t1MR2tdLD7bodSd8ZKjNi+EwzmBRX79qAPLEZbwbFBklrXKlgvP?=
 =?us-ascii?Q?XgfoRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hgJQJEiQSF/TQvG3XCr7nT+R0PEN9HVtAxqkvTRt5oUx4ktZdyNi50OREcoY3Kr/ms2ahgCYTUVqtoEuhx+XkfVD47zvlB4S42pfcO12+uK15PcRxDgVdiiJS4X8YSAeyCmKEdgg7lYDvAdXINgFdl0P0Lnvgy0v+vYxjWXduUiKRcEXQLhDH0M9gDKMHiii4JQG7xPD9L58hjslnGnTc9+GgBCFshitIcmVcxNvGkGdiA3CeMh8WREFd71ojQHuLdS08zq5/urUUpHDW/75FZBTToy/T2AfLG2H5xyTykr6mzW3OXdtY7GoXG3a/3Exnp84NX9di8h1LrHThCEgKS+AcuH1IhSjLzSF1M94lXTMLhtttW2qFHfiboEqIQ8Jx6j1Z9gbbjRmY8IxbJmpHCiJHMb2dLkqQfBL8u5xY+w+7X1pa6v6uPa4rjPDDbL9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 23:48:08.7544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e723e6-c0b8-4bdb-d3b7-08de605a057d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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

GFX12.1 uses 2 level gart table. Set the context register appropriately

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 7e917eb47a8c..a72770e3d0e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -395,7 +395,10 @@ static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
-				    PAGE_TABLE_DEPTH, 0);
+				    PAGE_TABLE_DEPTH, adev->gmc.vmid0_page_table_depth);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+				    PAGE_TABLE_BLOCK_SIZE,
+				    adev->gmc.vmid0_page_table_block_size);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
-- 
2.43.0

