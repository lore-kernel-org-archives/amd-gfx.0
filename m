Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31413CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7D910E142;
	Thu, 11 Sep 2025 17:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xw/DZVk9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD0C10E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 17:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMAnyS/I7hIynTQyY6p8CzC5BBDcmLEfMR9nKWF1O5V/Xu+o033NjHsJ4p2UY7lPdMnvE/UXDIw6VQOQsDK6xLn92WgnkoSgDIia6VBo6Lj+rXQPLH+3KcYfHWw3mjQ1dt0krUoIlPmiFZE9jhrmK4jzoDYlB+a0dE+DynYpfF5890/uVuZU7OOylexlerJTOBqgtTHhVew0lMdt3/NAxaywN8m8dtbUuKgTeIguE/z1FTqbgjHwP4gO5Cnvcc3RL0xXkE8GvuCa4T7ML0cGfTJeIRusdIMvyrUo3/P42iG6g9A46TczmseepJnSq6o3bNxLk4STfgVobRuZkB6zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMXRpkBn7wf/oN1Ba3+bnkwhGiKdMVrMesr/uL1kCCk=;
 b=swBJiagdHgznzApvS18A8+OMYnW3zwhlDLmKCq5nfRcxx70j1IWfvjRY415V/OAJCvGyJN0CRRhMNCaZeQdZU2sHE+jjLnEW7E6d42l70xKGSlskyRa0m8T/+rIXtDap7dCUWL0r8ObH5ktyTup6qXq+/kCRli0bqzdXWRBRYUNQ54GQl1IcKHOnqgt7fl/h5O0k4xwyAGoP4GwvLl2KZdfOUhdnVPCS7Orr4KeV/OJdfm0KaG0+G5iE1uYWGlHgd0lGdIkzKyRkuS/OQn/9NXnZXIxCB5p+ExYD+z3F73TJzfhic/6WY9LltgM52xF/cI1wNO/bcnCN7BOCrdKGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMXRpkBn7wf/oN1Ba3+bnkwhGiKdMVrMesr/uL1kCCk=;
 b=Xw/DZVk9wAuZATGabEzGiLcb0ValCVOCEUziv2JgPo6/gWrGQpg9QczQuZSFYMkAOXG3AD91aMdcK/HXQR2/7K8m/6al6Cfsxred5/4FmYjcyfzFTjhvuqSON9bN3/4r4PQKsz8FJQTuXOhvdIe9Uce634tiDZLEpt3TZVtFdY8=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:07:14 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ce) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Thu,
 11 Sep 2025 17:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 17:07:13 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 10:07:12 -0700
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Date: Thu, 11 Sep 2025 13:06:58 -0400
Message-ID: <20250911170658.584379-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f53b84-79c7-4d60-196d-08ddf155a732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lTOWLYFmmRPH/jYszjvXvgeRQ+7nPh38bjEyUlit3rgaazJfTiInmiJCgYHL?=
 =?us-ascii?Q?klz6heHSW3kuG0i3jYbV4X/yjW/vKImntn0bnMFyE8MjnYBNf1y1QzdgQ6F+?=
 =?us-ascii?Q?YaFnQyvaM99P+lQxD12AWuwtSnf+TXLUmXqn2vyhRM0D4PkEdY0CDxoBdA+5?=
 =?us-ascii?Q?ZlBh1Ytnlml0gxRI/XgK+FeP7WkBLNy0HiVokMyTPxZiLKSsmheXrf4waQ8a?=
 =?us-ascii?Q?9CFcwW7cHOreGpRDr2CHyl19mFAu6CIzdMpKItAPDAhUfExZnQHprqFw2m9Z?=
 =?us-ascii?Q?5cQFbmBkh0iTSnI/4DVkWm4V6taNgshHGqJxrB2VLsxDOZ3RL+REinHPJNEJ?=
 =?us-ascii?Q?lWtv/T+B3lUWXtQRDQ+f1X34ZJPwBH8ewCmJEK1Tup3HnE6g7ugbMb3pyIV9?=
 =?us-ascii?Q?OJLFTwOhgK4z3TmQ+KQdQI0EKx9oq7Ej6CkOrbZjxwkM3NauqMMs61m62kXy?=
 =?us-ascii?Q?44kczDxaQJzGW9zXlG9T0g6D3pVM6u2feYAn2kjncG77j7IDVG9ygBmFDnti?=
 =?us-ascii?Q?JX+8ZrzxWpus35b2bUxL+d7csBU+qQjHbpW+WmHJK3rCj5MdISxjg1jCY9Nh?=
 =?us-ascii?Q?Jkj/1v8M4krSr7TiNeiwb/kOkkByLTHVXtHEak9nDiE5fxSOYNxIoxllq6W7?=
 =?us-ascii?Q?kQJUTG2ZqliX+l6RRi4iw0ojb/yhKePs6UMVlULLZhsuczqyEnk5ZQlpzRgL?=
 =?us-ascii?Q?vDK8T4elai+F8XN8P3kzQu/i2UtBd8vK/g6AshD7RJ8foE2FFBMEMTFe28Pe?=
 =?us-ascii?Q?hICL+UiPe+y5z1dJH5CXDqtIWL01Lmw45MvU71p8YLktHp038dfrnqrMEPV0?=
 =?us-ascii?Q?nY86SG+7AE+1+CmZLE3p8E9lNScZcab2/M2xSsOUnb0JhLLf7QvjJuyg0ouX?=
 =?us-ascii?Q?0lV1QuymF21cFS5g1zzi5bQMJfjprU/YEJ/0kw/Aw5HuEKPqPpCEHEKvMDgq?=
 =?us-ascii?Q?CsndBWY+tfkH3Tv5OfELkZlMovfRX50nS6pENDNqp61AApZhZOwZkSNeRHQ8?=
 =?us-ascii?Q?aayniNnm6aFUlGnhenvS8XHZgXdEzMDUh+Syn57bfNPuiB8DcdCL8vL6KztR?=
 =?us-ascii?Q?5jKG9M2FHvHFsRTZcKsgTi6Bnfr5+MlWRntAg4nk98GFTtLzg3DI1vx5gs6v?=
 =?us-ascii?Q?AuQKJz+xQJtJfiobEXBpFSu59n5p7buP7Uc5+JHe/gIsXdhQspbF5fCPRS+Z?=
 =?us-ascii?Q?ZluzC+ljB26tzdp8YJbC6kFVBlt5S0B2aKYMf3QOAEkVJ0XaRW7x2zhJK8iG?=
 =?us-ascii?Q?u89IqLcSH2fFdrgMW7mhJB2CE6Qk6eYX+SsBiQx9+m/vkEAn704aQkzxRDp6?=
 =?us-ascii?Q?5P8Nu0bLWBMjVrEdCZ9n+BUN8ZqaD5Hlk0rnSlk35CJDGLDJT3VkMu3UJ6Hu?=
 =?us-ascii?Q?ve1oTCC38BmTM8S79KKo7Ri91H/M0vVHbDYg6zfF5vYm1XvfoOAQsiWFPU59?=
 =?us-ascii?Q?1BCyR1VQHkOmf0M+hC1lQjNgSYDdrdce3iNQHeY6Q/fe00WXPZLQyVaFxL5q?=
 =?us-ascii?Q?iZ1XY+nAQNCZfGv0lyA9jtJT9o/nouzowczTUuts5vnIXOz5C233ckdyCokU?=
 =?us-ascii?Q?hwb4r9b2UuoTG5oFouA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:07:13.5428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f53b84-79c7-4d60-196d-08ddf155a732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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

MES pipe0 will do VM invalidation with engine set 5 when assign VMID to a process,
driver will submit inv_tlb package to mes pipe1. It might run into race condition
if both pipes use the same invalidate engine set. From MES version 0x83 it will use
invalidate engine set 6 for pipe1 to fix the issue

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 76d3c40735b0..7cc16af1868b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	int vmid, i;
 
 	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x83) {
 		struct mes_inv_tlbs_pasid_input input = {0};
 		input.pasid = pasid;
 		input.flush_type = flush_type;
-- 
2.34.1

