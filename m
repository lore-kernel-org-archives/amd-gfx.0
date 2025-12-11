Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA6FD41D57
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 15:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F9110E097;
	Thu, 11 Dec 2025 15:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klNL7esc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3DB10E097
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 15:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdCDadFmAKfExS46meMIjoqd3tfOhzjhhrS3YNW6sWmFPvJMHIsJRWjNh5No3WK7/HjUWHZfSwJEgOA2WbByR2LDN2JEJ3etK5gdI3Q6Bau4kbMk6ROefHbcUOVZ8i9hHk6FEfHlGwiKlwH2nwq+QSHPEI+m+biMmNy2z+0zPrVjL5ifm/tu61NK4Jx5IEuTisH6UO0vTvj9HWQ69oBeuLnb8OV9M5DruG+fn9DeCDPeht1o62sblY9qaR8YqzTgME1s0IgdxZItFLbkGmXuGkEEztawEZGfYBzhaCk6gJxG25UvoO5BsTbsNyA46j/JNoGbO5M3BSuQpYvbK1QYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/Snj7YElgbIzHFqQ8MGJCDOLSsjKBStHOM07EacqPY=;
 b=ermZJuk9f6Ez0i8B6cWmlw3N21WOi1C5iPCojV9U5l4guAGuASULyyYalMEvZ8sK1LBy7snP3s+asxM1bOW9Ml/YzJRdfYMpM1V5oUZ1FbfisLVt+RFZbeHyeP76hF7tYFpjBVl9OQuv/IospGz1GWUy6quvbBIyLWrFoXw70lqgdNbqApbm4TUivllNYQR9wxJD/7ofTtoFusHzTzUWD1sLMOqIt6V8ybFog+FYAQFSNTg1kIv1e/yt/RWldFoE0L09LAxU6VXLXlGd6TUQn7aFM9cCKQeV6O7+h6uf5uE+01f9nPji7eWGR0tMCxJ9o5Qn1lDgmgDek9KmCIJZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/Snj7YElgbIzHFqQ8MGJCDOLSsjKBStHOM07EacqPY=;
 b=klNL7escaaH1V+FKmDXxrYgNdFvNWVK2IwAL15/Oy+zNw1sZ8LXqVQ50WT7jtT6zzKXEb0MT9sPk+WrRXipJwtVO4G75fndHIiCB+xhjurMCsiqNUZVfpYj7nHA8PeqeQKs89BKtCUkkDUymEkVSTdQDvlZdiDOt0uvjFAHo9Wk=
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by SA5PPF530AE3851.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 15:22:14 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::47) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Thu,
 11 Dec 2025 15:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 11 Dec 2025 15:22:11 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Dec 2025 09:22:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Resume the device in thaw() callback when console
 suspend is disabled
Date: Thu, 11 Dec 2025 09:21:37 -0600
Message-ID: <20251211152137.2954347-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d47a365-9fae-4932-f2a5-08de38c90e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lTpn0/wUtfgtOs0gqQAtWED0tSmwHVZmcV0GHn3xso9Bl/acX601cUqMrYF6?=
 =?us-ascii?Q?QvaNBCWhJC7mI8Pqatr6uKQu6rz6LGV3pRwWZWjpTUbJEXxrhWrvbIjH4i1y?=
 =?us-ascii?Q?zXgmKgtgfhD1zegHn7yILwfqPttAgVroDIZ26tn3POCM5LwO1LSeV/5uPxMK?=
 =?us-ascii?Q?jJVtDxgvSEAl+SUfSYoiReGGmyqboqkDE7dLbcC3ixFvnCv8VOjKj0XDCoT8?=
 =?us-ascii?Q?wL+krbYgUPCYf/STzDFHLG4eSklZCtuWQapSnGY7lPXGoUDy2+SJGbGWEjZp?=
 =?us-ascii?Q?ed9aag/V+f0WFrMLWWFZQ/5h3u4862/01vwobJ9Cf/YnZYxwcUjgoUNZe0Hy?=
 =?us-ascii?Q?REkMcYH2RcZwxfPoIKbQ1Ca8azGQuo4+Zcqt50bxnzGwZ/XE0m7IM5kpKcLn?=
 =?us-ascii?Q?7emytnhBUZ9vmPqhmT/3GhH1yjsQZqUYj2eX3vQAqhpZPhc7IdvooHPUgXY5?=
 =?us-ascii?Q?msHBNr3u2AWS3GRTNL+Jgpla4r0Mqz3HV/nZAdn24ZLgMB3HJWcmIMPDHPU0?=
 =?us-ascii?Q?VrMdD1a1yGwjGA0YVMZqFz2LCtHOKpQ8qDb6D81ZgF/cZ07pRwsGy00RzG19?=
 =?us-ascii?Q?PBmiZMikyDIgJk+hN5dZOF4q3LSTBWw9t4GC/JTLk/ycAUtXp7dStIUXWUgS?=
 =?us-ascii?Q?BYiYIeY46oRNGDhhbL0kySLU8exgrmiE/TIDgV1Avik1sytZsefKX55CeWGU?=
 =?us-ascii?Q?ZZqwwKH8VEbNUACzy4DA6iGRpKNO8T6c0b3zRRUExvijdY+4xx3n9D9otuc0?=
 =?us-ascii?Q?1XGVOsFsKyT/3RNBod2WpyLr+j+RzbMPLIVLbGFF3zRNX70aGPu1umXwLv8i?=
 =?us-ascii?Q?MD4DRjgb+op4xubcd+bctkkilSGdlpyULt+i5irOHu4mWwfXYEYEh3NZLZDl?=
 =?us-ascii?Q?3/0Eov0gLZwaE02uw0fkO3mG/J+/JEsnBb66Hy997X7maLIGYc3noY00j4DD?=
 =?us-ascii?Q?O09sapeA3+cp6pNeUlan31NMLpAsuU/4Oco0ge2Kh2201mPszy0hzVJns6Ff?=
 =?us-ascii?Q?dcktz4jYj2bAZwTwPvurElKLX2TG+m7lz1DFX0Nz1YMoftGPFqF/TudjEHhb?=
 =?us-ascii?Q?lxByxZjNeh2whspSNMXM+2povZJptBzFOVqmiepfDCbFLwJKElYEuU5aBe7N?=
 =?us-ascii?Q?ogOe10d3CLq5iRg01CGhFuJOQXjxHvKdt1YMsZ8B/Wlj/EsOBjYugIkhWUPE?=
 =?us-ascii?Q?IUILupASV5s0b8v1pxkxNgAUbmw5gzD0eCls++2YH/hoDKJ7nQEw0iSh49AK?=
 =?us-ascii?Q?OlrQlvBnKrCq6DhCfgyoGL/Ojuiq1Ix2E2uOOBTa+sWErQz5Wb8S+thalLyw?=
 =?us-ascii?Q?kA7rgSy21P6ww1uHprnOnGi5kveYpjGydkY2yzLsbFd7YIusfHSMXHw2/9Qd?=
 =?us-ascii?Q?PebdFXKXMF2lYn1ACDOpAc4TovMjjwwmGua7qV7EYbZtv34DLWtCp4/5e/SI?=
 =?us-ascii?Q?dOUO2KDm2eXzuki0zLX2est98Ow8zMzgUQdQCgmE/x+gtsxNN++ZjsVL6OvF?=
 =?us-ascii?Q?uP1n3/EQazbtGCGqGyaZWIQ09nzGBoulBBpc2kOr8wosIttuQVy3BbfGw07y?=
 =?us-ascii?Q?A4FHP3pdeujEhYvhWlg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 15:22:11.6416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d47a365-9fae-4932-f2a5-08de38c90e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

If console suspend has been disabled using `no_console_suspend` also
wake up during thaw() so that some messages can be seen for debugging.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4191
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7333e19291cf..5de79e0df26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -33,6 +33,7 @@
 #include <drm/drm_vblank.h>
 
 #include <linux/cc_platform.h>
+#include <linux/console.h>
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
 #include <linux/mmu_notifier.h>
@@ -2685,7 +2686,9 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
+	if (console_suspend_enabled &&
+	    !pm_hibernate_is_recovering() &&
+	    !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
-- 
2.51.2

