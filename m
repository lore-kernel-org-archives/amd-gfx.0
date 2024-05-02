Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B37C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BE1112591;
	Thu,  2 May 2024 16:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bPYQG+KL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450DB11258E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj12LXcXmv/H4Y8ztG4H5olt3Vq2I+Lmx/UjjHGZ2nWkz0N+DSS/T37Klk9JWfMDR2+9scgO9+Jn0STX9LunSm3dciyEo8k6DTPaGf+64ZXOpM2ZViBogpexFFuHeDgEskHB6LUsCVTUIH1lHtEXfrBzEHMvCIbU1qNWhpgiJcELzBGrOlQnfzHOdZNoCIZFiLIUuXX/r8Ub38Xfl50OTe50xyAZpAEXf831XJUVW4UwVufU5SUlqvBGruidWkLuG0mzmKMGXa+v/4B7dhMuUCmfnR8K/kSBWzqRYQ4euNNCwBk3kEgZgPYJcDfNAvOQMolyFe9Hra9pIYw3wu16Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyIy9ALWodE+8AORnJr8ZarUvB7lejWR7LZix+P5DZA=;
 b=EPtyPl5eU6ywdo7FuG1ftlwOxVvI4R/bQO1p1ECvn7ZqAluO2yj5QRTryTxhBStR5y84SCfB7IAX+DQiJltpAZqm+1cdrJ7fjnYBMjm6/QmOIRI+knYyQcOW/D1IvtGtsjyVIfqH/awF8js7R93YAlWXOhT3YgpU/f7s1YhQDF1mxdccCSVh1rj0HfptOj2t8YNBiTi5xDJWsQxAvZQELXdjm3FAsG9ljGLxeeu4C3/pGjnPp6gqpB/7kdsWcM8saD8BcnKNma3J3Byzi3ApyXZyWHbg7EJYUw9X7TVYBluJRLLOjCl3gZb/yxE780Yubwl8KDEZK2PLh/By8UBqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyIy9ALWodE+8AORnJr8ZarUvB7lejWR7LZix+P5DZA=;
 b=bPYQG+KL7o//7762IMU6C0kUhzMU933/9cFdFie6Au+nj3EA1iisKOCXzS1srLx+UhU1BsE/BCR5M6eEgkedquNggQleUaTiG3ASsOVVffgtFor7+8gG85ZcY9OrLbdVkGGTnWIs4sdVhMIvj7GmZ1Uz/sNpFLjmaRb7o6K+uVA=
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 16:32:45 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::e0) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 16:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:41 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 14/14] drm/amdgpu: add kernel config for gfx-userqueue
Date: Thu, 2 May 2024 18:31:51 +0200
Message-ID: <20240502163152.1382-15-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fe82ee-f693-4b18-1709-08dc6ac57ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ejK0cR1R2iRmA5UO163lzfhPbLsyiAkYauvZQAS0gIs/1XPZWQ33PzXZlw0K?=
 =?us-ascii?Q?MyU/mz6eR4hy/nmwBBvq2t1ToHq+ye7XmZsejB3lwqXjx1Xioho+sr3eRTK/?=
 =?us-ascii?Q?P87sIb2TzWTRZ2Yi/0BlbHvPvH1WuDZlFE5wgZMt3SQNvB4wJISdrUxFQ7yR?=
 =?us-ascii?Q?EGdkkK5YLsLeTviabI0gEkK+Ljn98X5JQHFx2P5A9Yqa4wsnw6PCWM4Rn6bn?=
 =?us-ascii?Q?we8PeMPkg402evGNLK8nEfvJM2Z7TGeHal7ubUOAEld+18dT40mCrXRLSq6B?=
 =?us-ascii?Q?VqjgBJlxBnZPwpf/uiyRhAsF4Y8hBFsPncBSwQ2eVsZzpbdjHUwsQF5+gMbs?=
 =?us-ascii?Q?B8vRUC1hpYiHAZqnNAaLIIYQVtZNFmKVseOYrpjxAOUr1ovG9/tOBneb7FUm?=
 =?us-ascii?Q?XXdRVLLsXF7nbRlg7MSF1jwY6udCpHukZjESOO9xr8E5jpR2wvu81AJOZILz?=
 =?us-ascii?Q?jPf3XBXRYSckxjy+3oAgSJ2OLkBYgU7D+shiSFkNeDOiFY/lthINA5B+cUhO?=
 =?us-ascii?Q?ZXgdAV6fEXhuDsnFwcbKp9IDDzdZEpK9vhrjyH/ixtWQn4VByncsJLKgpc8P?=
 =?us-ascii?Q?+PO7SnJNZEW6QyeANszSGFWv6AiUgib6QH9NgwtRkURsmuOu/qiJ6tWr5JCH?=
 =?us-ascii?Q?C00vw93P875gID2pm3gQKBvjG/T3a4NZ5gOGh0X9VixfZ9UtLG8J9qVvOX6V?=
 =?us-ascii?Q?ZBULxGbjn3T95MTgOcIZKmQpXFsF12VVJd/Tez/N0hqh5UaTbls9kyJkfxUt?=
 =?us-ascii?Q?O/EtxbBuYetwRQtzNXvWqptHEFeVq+1goCv8hnc9P+NYrXOtPYkdK7KqHASG?=
 =?us-ascii?Q?22T+kw929eRKe4filTFAW5PbAHo/up8iAi9cTyXOasX4R2+K2823hHB1szq/?=
 =?us-ascii?Q?rjUy0yQN1SHlwRLu2hMPy21wgMaIcRRkfhsJ12MbjmPqGhxOJjkQ/2O9YQcP?=
 =?us-ascii?Q?J3aSgnfYEvfQWIs9PzSoBRhWdjfkur1ww9LmHurQy3CcxPDCdwdLuvEq/mNK?=
 =?us-ascii?Q?Agid+JQccgpjdTfZ70/9T6/lO/8nBZKs6srrHw/V+0Jart+L/5c1cxG/MpTS?=
 =?us-ascii?Q?FyC3tw4FAh2F7im02nFbuSKA0R/X2vL5tgI+y10n0KL8mzyff2d891CjcbYy?=
 =?us-ascii?Q?aOgCGKsx8QxZYWDne4ejT3v8SaFinULiZ0wVCyvM0IfPitujktsNyvy5pwsE?=
 =?us-ascii?Q?Yl/2c7Un5l17q8VzHME8iCg9VKHbXoDSuj89n9OgKCb0+wtoiGjQN+I/yQ0O?=
 =?us-ascii?Q?RCPqqiw7cGCxpUpN+dQs1rOPTePcdcDuYZ4cBahUggu9s4i2B3uhdWWLY6ZZ?=
 =?us-ascii?Q?XCSRoxxOPe+xVvQHD0jj1aS1hYe0qds4AIG5jhboWwRBCMIdZ9VzZBvsEj3K?=
 =?us-ascii?Q?qI5XeJwuxFTKjKjnGYWfWnmF/wll?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:44.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fe82ee-f693-4b18-1709-08dc6ac57ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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

This patch:
- adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
- moves the usequeue initialization code for all IPs under
  this flag

so that the userqueue works only when the config is enabled.

V9:  Introduce this patch
V10: Call it CONFIG_DRM_AMDGPU_NAVI3X_USERQ instead of
     CONFIG_DRM_AMDGPU_USERQ_GFX (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 22d88f8ef527..a7c85eeec756 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
+config DRM_AMDGPU_NAVI3X_USERQ
+	bool "Enable Navi 3x gfx usermode queues"
+	depends on DRM_AMDGPU
+	default n
+	help
+	  Choose this option to enable usermode queue support for GFX/SDMA/Compute
+          workload submission. This feature is supported on Navi 3X only.
+
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 987fabb2b2c6..0a64f2c57def 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -189,9 +189,11 @@ amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v10_1.o \
 	mes_v11_0.o \
-	mes_v11_0_userqueue.o \
 	mes_v12_0.o
 
+# add GFX userqueue support
+amdgpu-$(DRM_AMDGPU_NAVI3X_USERQ) += mes_v11_0_userqueue.o
+
 # add UVD block
 amdgpu-y += \
 	amdgpu_uvd.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 46304d09c4bd..5c4bf243ed04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1348,8 +1348,10 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef DRM_AMDGPU_NAVI3X_USERQ
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1361,8 +1363,10 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMD_USERQ_GFX
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0989400d0afe..f6a2c2daa00f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1274,7 +1274,10 @@ static int sdma_v6_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+#ifdef DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
+#endif
+
 	return r;
 }
 
-- 
2.43.2

