Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D701EC19F32
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 17:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD2510E0D1;
	Wed, 26 Feb 2025 17:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tdU2EIRK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DBC10E1BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 17:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKxW55/Y/2K2NWtOlTRhg7ANAb6dJBJw6P3M4ly4VtKfzPo3hxE0SVDuvsu1l6ni85MJ0FMmKS73Let6Rooj09L+vaSdBqRfXaVGzwGubC7lZ/UV0CDxyHtsXeRHzT1WWUzd+jS29GmO43ncbaGAQS8fXwg7Rp+9/qh7tfy9bJH0HtTTAerSoxUwCQHFZvUwuhSGhl7S17Y6TL7PK+ZENTognPhOR0iJuBW7NR0jYLEbW4DUrml8T1n+z1IyzXC6surLrYte3ulvjKEv2ZurmTiWUWyFPUYD9j41V4SOPVlX0IMfwJ5AiLMKMUKmnbILRbL/B3zxqPN3G5HWZvkARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+faMAvE5I0aDaOanVT/EsTsCbh70q8KOUiwOv3NNGI=;
 b=QVx9kwgK0ZFNu32sZ+BQT7YfgO8wU0uqymC6dJkHuV3lHsrDTsFCwP818Bfl1Da/rX5Niy8KEetFPk8H1Fz8eLlMahe6skqIK2YRBoPSVVvDbuESMwCeejt71mE1W2nGgtvJgur2ZVh9nn8847yFNXWJJr1MMFR85fBtSmJ6dcYwqhMxXTBstcV/0mwP+eywwX5/lojgzf7FoMUze952zPzwCBhQSQ2czNZLD9+Ty6cgisRA2CPxVOqFfnAWFG976R4DIwlZxGpOiMZj4NVtKd6vj0jpXqM+zNPkwEIJWRq5FT4il42yo7Q60pXSY8PtcbtZIMl4VmCOKJm6B+2y6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+faMAvE5I0aDaOanVT/EsTsCbh70q8KOUiwOv3NNGI=;
 b=tdU2EIRKF7TrUqmIMnS+0K7t2HZoEZ7Wy7Z4diaH1Krlhc7bEFbWkl1vRzr5EMjT7GSdH5Ka4pGZnIghKWI+jXvsk8PmDUqQOYNOQKS76YZvaslx5zDBdS6WR7PRSf3xDiAHC0/yzM32Bn+D4+YkOpQtkA7th1Ho5usEecqpWiM=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 26 Feb
 2025 17:15:19 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::57) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 17:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 17:15:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:15:15 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 3/5] drm/amdkfd: Fix mode1 reset crash issue
Date: Wed, 26 Feb 2025 12:14:19 -0500
Message-ID: <20250226171421.14436-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
References: <20250226171421.14436-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f094807-4d0d-4028-96d0-08dd568924f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vZvXE49h/eVuAF3CZV/LdacTTYeMXXpHaUnzZmwZ+XIrhEJnRHyb9msnBSa7?=
 =?us-ascii?Q?6NcsjdhZj+KG/BbMUJWGF+9h2nnhYscqyslmJ/KdqZxKQYTeN8J41yiK6YVS?=
 =?us-ascii?Q?bA4KULbV/sr3LJTLgjUhz0i6RisVxHOpGEiQyTMgCXZZ4/lO0SwTdNoVEEmt?=
 =?us-ascii?Q?XwN+jzHMOQ3NgzMDMrQbxnoXSXCvMtvI+SuRqVLW0qrFqedz7P8F2SbFA5mC?=
 =?us-ascii?Q?0Q8+5+cSouMDE0FSq5axjWyT21j1mzaGu9T4ImmGH8s4qRinxqjGtOJbRW0Y?=
 =?us-ascii?Q?x8E9v87SFakhRLuyEDW2/hXO/B987IPHQKoZKKkZzGCBaftT3efdgi2u9XUO?=
 =?us-ascii?Q?tecyzfVO0CDloYCt5dg9giSXwByamqfbKR08SVHfermcZIXKmYeaaFhZSu1x?=
 =?us-ascii?Q?0eY57OODq/QadP10ug6LE7iSkc4TE3PeOmJwU/P2ZtOMBLCNE58IKJtew8Ml?=
 =?us-ascii?Q?68WaAs8Hxa9tvw6oUxh8F+Fqo1BKl5+mNge0qD0Q0UsALlISyScLyGvyWZFN?=
 =?us-ascii?Q?31uKUKNJa3O9JiYGTuGrMUHv++gQlByOxz/URXI61eBsID2GCs7Kpttnvxmn?=
 =?us-ascii?Q?GM2jEsSGXJ0fVKgJbjkm+eF5z+3sjZ5mwaV/nD+oNfopUuI4cdROnv5bKjyd?=
 =?us-ascii?Q?2Ps/MEarbpAQLRRXyI8GKXT+6rfUHIcaIzciXY/bIX0u4Li6BFrJU65eFyhT?=
 =?us-ascii?Q?8A+QsuOmO8nKFPyoFO4hyfYrWouAkKAcLs4LudpDe1ibGmhipKyjIVRs4nmy?=
 =?us-ascii?Q?jkZTO2iL1y8/Ritaz5KOXwpm2RSqnDjFS5qqk9q/Vxn+m9MCmZrhP2GDqXFE?=
 =?us-ascii?Q?UDBDMAP/XvCDV1aVI2PN0WuCSx5dNMzWp8CqFhvNWMVd0nqCgXC+MnwO3uio?=
 =?us-ascii?Q?pfpazNA57kR7MLkx+O1fn6mHm6OpIdhopw08w3m0FhYhF4u4VoE9F50PbeIQ?=
 =?us-ascii?Q?tWpD0Ro+66r6m/D1NLMG2v91JwfBSfmfsLdt8mJ5hvsh6uGW91HXF0frCb+y?=
 =?us-ascii?Q?I7ySXSjrkFrvW8IJ2jcaez9TaVN09KMyOxdYf4CPPo73OZwsVdKBbiQ9nTmq?=
 =?us-ascii?Q?ecArF6c9MByHchLjUWIXwHoqJgg+B36PKuYfopNYbPp+AJc+SZN01hshXoCn?=
 =?us-ascii?Q?yTMQixiRdPLVP9aASdJeF4SADN3bu47OPVck+fLxySmiPQQIoE/t4LXTmoO6?=
 =?us-ascii?Q?uiAW+JCGbJy0SROA5jBqnYdWUUGLLx16QyzPicwtAZmXDOneFrnRQMsH0+xM?=
 =?us-ascii?Q?gyAgzDXmixkmdVW5ofr8phd0yCrAgqLU85E09MPR5lFs/eRtNJcoNgBHF2Ih?=
 =?us-ascii?Q?FOgK3RXWjKPHGSbp6dbxIxEyTyWkzOPL9GvNEQ5vmB3virKb+765CG36PrEb?=
 =?us-ascii?Q?vHr/FlBrXoFHVcItET9MOOuorr7NdpCn8JlHth/HmfjUl9iIv+YRcYNV9tfM?=
 =?us-ascii?Q?7zMTySOGfaoChkqIvM79F66htuKMDAD1x13kf2rN+yfELUqBVRhbZR+A8sSd?=
 =?us-ascii?Q?++AQl/VcV8TBrKs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:15:18.5080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f094807-4d0d-4028-96d0-08dd568924f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
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

If HW scheduler hangs and mode1 reset is used to recover GPU, KFD signal
user space to abort the processes. After process abort exit, user queues
still use the GPU to access system memory before h/w is reset while KFD
cleanup worker free system memory and free VRAM.

There is use-after-free race bug that KFD allocate and reuse the freed
system memory, and user queue write to the same system memory to corrupt
the data structure and cause driver crash.

To fix this race, KFD cleanup worker terminate user queues, then flush
reset_domain wq to wait for any GPU ongoing reset complete, and then
free outstanding BOs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2715ca53e9da..7c0c24732481 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 struct mm_struct;
 
@@ -1133,6 +1134,17 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	p->kobj = NULL;
 }
 
+/*
+ * If any GPU is ongoing reset, wait for reset complete.
+ */
+static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
+{
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++)
+		flush_workqueue(p->pdds[i]->dev->adev->reset_domain->wq);
+}
+
 /* No process locking is needed in this function, because the process
  * is not findable any more. We must assume that no other thread is
  * using it any more, otherwise we couldn't safely free the process
@@ -1147,6 +1159,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
 
+	/*
+	 * If GPU in reset, user queues may still running, wait for reset complete.
+	 */
+	kfd_process_wait_gpu_reset_complete(p);
+
 	/* Signal the eviction fence after user mode queues are
 	 * destroyed. This allows any BOs to be freed without
 	 * triggering pointless evictions or waiting for fences.
-- 
2.47.1

