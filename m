Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD194C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 11:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB4C10E184;
	Fri, 10 Jul 2026 11:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZLp6RWR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEB410E184
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 11:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbbHtTdMQzhdj+/w/oz2kkZF3uDoJoq2vakQie7ffGSKXjKuei7zUu5586gDompFEJd/wZXs011M+9myf4eU787ENSKuSQ5LZpiNMCjFQduIKaqITmVAbBSbBLZd0gnuX/d2vb/mVjJMGdUQd1haofzd3HDWtm1Gv6zwKhCjoY7MTATX3SSAg1lO/sueuK2y2tWGQi8PP6ahHD3DCdz+B2jThKLuHansEGrCW3ixjLido5pbpZZxdZP8Qe7D+uE0yifXL1knxFFLOszt5HP0JzbFOHLr/rGHbRDfwBaTE25WAgtQX6mgWIbBBY5CnEOLqiiLh5XdFuZZ+eb4U5/8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vppr+VU0HUdRC4oR0unKLa+4AhQZcDafRhkm9bq/Cg=;
 b=kLjvVyUjecdrHEk9NTzHzy/Mp9dXYVS59hYulLRoJ7XOILFBK9PJpBEiSknc2QrOZ9LJCoe7Wwcf6yGnSTi2IM/fCA5PLkrCwDfoyR2xy1udHUMV8kfUxq0U6hdcWymVanOETx6zyn4eH70QQTEE4+O2ysJFnsNXxNyTfx9ORBGf7RQl4lLEA5WG9NCfiCXUH/3uByz6J6LFIrV07zdPkqHc8xQwEIWQckn3Hdmko0fchKNMhEOkwzexXrsdDb0gbg6jTFyCDzmV9JxtgFlv7BAvL4kdQkXExUZSales5lqVvuR+hBIQycCq/H4m+R9QCBnhvFDP1I8jI4fscWCJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vppr+VU0HUdRC4oR0unKLa+4AhQZcDafRhkm9bq/Cg=;
 b=kZLp6RWRvaF2RK4c9bGzO+NrLji+f60u26KmcQu5OPSo0vCChgXS4D178G3A1GWyLVGDJ/X0sA6WyeEBhPf7JVZTAjtVtK+5GJkhaw3GMbyygGIDQ2Dowki8sZYXE27vHYVhAZBXTTrPyMMmILI6jJ+Ko0gy8nffh00/5Cyf1FY=
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:29:56 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::aa) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 11:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 11:29:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 10 Jul 2026 06:29:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Zhu
 Lingshan" <lingshan.zhu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
Date: Fri, 10 Jul 2026 16:59:38 +0530
Message-ID: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2e48d0-e099-413f-3548-08dede7691a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 262o9SmM3xHlG1hl20/JYon/0R/IfC3MHW7HMgzZlRhzYLSRRSVYihSxyu8OmadGsh3AP2JAPZPohfA6qVIAjalOcnzRH4U8WaS+olRKZA54EetYeq99ghm2mNMfsTDQ8LWc1IPqYObJAgpKujzZGZ45o0SdRoE7Mel88UH+vZOJjjd7BMN5EKQKt4pWYJ7icmH9zjdQ7Bdi7RkH40xIaPCBSIP8G9Hf35zTJXsK+Cm0phGkA0XJpG0IdVA55Y6AkO8eE0Sh77gPgIEMAGdZneLQCvf4WYe+jdEvoyIQL0Tj3YdqIQabLYPmVewcFdSq5+Hu8gD83PnRADdJq8QqfExyEMBBN/PwSuKyozADlZi4XHh+makORSPdhnCX/to46zV2mNMVbkVsVtiB/e/ujrcunLCHaVJRBjFEtrIrydY6d5fqNMWj1iDarIoWJrCibb38yrBqn9igVGEumvNDHdNGeR9ysK9xA9Qwr+cxmLja0WbYSzc+HXjJ/WU344ZL4PkySIF9MeOXVtTZZ7UKLjIrQeDyOMt8BqS9BY3apgK6v8xlSnOUxAUXpUyZz9JnoKvta8s5mz9Lsjjh5+7bGRmK9GKGwnaTms6LM49eJGTj6c7nueV+57HKz8K/84ZW4XIcprGw1kCrR1XqIYTdNrcpxkQ8zAUS3pS8em6HB96c8zFy7AtQj1haISQfrD6ab/7NbUuYF0ZHhRJI1Seruw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /L8iz0wHM2bKpZlgt38NscAwqHFLtkqd0wF/rYIwqa8fKesUp4LNKnGvG08sfDwdNFz51+NHoH3jfLqOxIhSaigWSB3jwz2Sxy0C2kMdovPJRvbtN4dter2P4FghVmYU/06eNw5F8VbKuoBV8/zdP5cr8hi6mWvW277itk/YNwX1c5Gj0YyLs4XncZu9pbV/gM1g17q2ey6XcHFgqsaq337vXtgPBAJelk8xPIeqpuUhGdnkCIxsMDrK8AU05ruVEgxj4+XX7P3xHQQ/Ao+jFv9tHUOXH0p/7HMsIw4SWqeaPHddhqfSYjzZsgSQS1DZjugX64tsyQq116aMV//4Jb8HqUrBKOuqnZuTvzcIRVf382aq6br5HES/WjVHP2QeMtr31jQEl6ivWwR4tyUKWEZr/HkLYYmpfeIxWJLaslwilbZzWwImON3xfrIkkpp1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:29:56.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2e48d0-e099-413f-3548-08dede7691a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

debugfs is intended for debugging only, and failures to create debugfs
entries should not affect normal operation.

Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
If debugfs entries cannot be created, continue without them instead of
reporting an unnecessary error.

Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 02673f01b448..7c5bc9c4559a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
 		entry->proc_dentry = debugfs_create_dir(name,
 							primary_entry->proc_dentry);
 	}
-	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
-		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
-		goto err_free_entry;
-	}
 
 	list_add(&entry->list, &procs);
 	kfd_debugfs_create_pasid_files(p, entry->proc_dentry);
-- 
2.34.1

