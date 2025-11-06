Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661EDCCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016FE10E810;
	Thu,  6 Nov 2025 06:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4jlq7oG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F2310E810
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiXa4yY81Ub2a1OQ+xKgaT31OuHP0+5wb2Kv79t41YVS+86LJt3tRyeFS3YzGIuRabDpw05Ezn92Pqy9FIJ7edG5n4r1eo62HrMFjEpMvNXlCbp8SFPJ5EIrjTVz6nCJzISv8oDtacnu9QHdtUb/Pym710fraFo6/tLCXyoYR5kEDOtmhVVB1t1ad6+JPT+H2Lbr+lFeWBSSTlqimEp0j8CYP2OZvH9EVD4ZLlpqSE3/B1R5poDNV2l6QYXjFjcZ8oOpqFt/t750YmKla1FwvBjxrUzSSrSs9jNzipCUsB/xkSWWRD8YDZlsjpzlnN5UEu0XY4SoML0twoXecDqKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oYYGch2MWJip9jWEmiEMPkHlBPoNwI2M7hOS6kcXtQ=;
 b=fhaUuHUfcxKUWd4bYtaX2hmsyzFxMCO6JCAQapfapL/MolBf9gUlBzMqfcYDE8M/FtHznJWA7kDCmpbnGadt44X/DhT0Xkgb+UrdKA/GZBu0j6aqbN2E+24IbRjdkW1AWcL1SvzzVc+KmeepyMrmEg8ueP9RTmdfgL1VDO9jHZkytBTHmnUgbTrrIGiPONd7hs6TFAGXlSz4FXlLvK4cQxOFqaXcaKDc1avOA5sTD+HNnz1JyL88/o4LPYGMQrkcy5Y08yqqgFtHh34h9HLHaGFOZ37OrNtY0T30jCjEi7pzgxbO6STvn3Ft5Gk/twUbuZsstfTMXKGYihA30twvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oYYGch2MWJip9jWEmiEMPkHlBPoNwI2M7hOS6kcXtQ=;
 b=S4jlq7oGCc/gmbB6XlB6MLo1FR6ZyWOfGbELDbecV71p9CJ3gZbNY7r/vJuW91CH26hq22voWv030TR0ASCHhbzgkErpwUGnXBgqOR7HqhZaS675k+2571xqWaQ1yOixx/2CX3I4XOQeGLZkAE7MZkqIJwTf8iyQe1+BDMqPBEU=
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 06:08:25 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::f2) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 06:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:24 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:22 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 11/18] amdkfd: process pointer of a HIQ should be NULL
Date: Thu, 6 Nov 2025 14:07:32 +0800
Message-ID: <20251106060739.2281-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 674a4e55-a290-4a3e-b6c1-08de1cfae533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V9gbuqyJz9K0LCl6yyrvNhw+5r/6u5AMmImWbYYrAXyE+AbhoEjbBNjHb7m/?=
 =?us-ascii?Q?UDsw1omlbdUsjBv3nf3jjPVsA7TvSHvTqGfq/FkR9QPLOv9nmZrRsuM4dHNY?=
 =?us-ascii?Q?tRFFSFxjYimK83ffv9cuo7INvJQsFXez7cHEKcIjJ19l2njBN2RIm/psoSOl?=
 =?us-ascii?Q?RePG9gYQtBQzXWxn8SIS4tmeyffAmb82fiS84QXU8dsB8KUEXLZyIIlAFkr/?=
 =?us-ascii?Q?xISqvLcmRaI1SxU5FzU3q1AiZ7Xv2PwHKKPs8M3A7jCvrsjMWfA7rc0jojT5?=
 =?us-ascii?Q?nwLkjIufjDX/QE/WKcZ8BBJj7JNnMkVbCMhSd31eIZiKiCQeq2LjJt54Ru1n?=
 =?us-ascii?Q?X3OSU7P3v0kESGHas0WQhj31IACypZuskb0zhVeO/omJV4uH5ac6HrW8z2MY?=
 =?us-ascii?Q?vhz9EaSE2Kys2Ww5VD50BRw+yb1Fl8VyKh90Fz3rZ/6/39OygK5TfpIoU1CM?=
 =?us-ascii?Q?iDKNoR0iyYzfjlrML9JIWaTYzxfPIg74LqVqnhPo8FkueT6UJyk7KseQimPv?=
 =?us-ascii?Q?tkfACvZbPwBoRR3mjdp5jUjmJ8JusR7ZcG0Hp+BQKpKX1Oqnz4FWDh0lLrfw?=
 =?us-ascii?Q?Pzhc/W7LaT64sGcgtLQ79yTPgV0FaJg1vBm9rwj6+l90boULvMvueFRomGiA?=
 =?us-ascii?Q?LGYDbO0C1X3iuM7xlBk08kL9z8hGXaMJ/CKVXVevCfQU/ndQPGDfewp/ez2T?=
 =?us-ascii?Q?vj1rKu8ti3TnBwAUGKbLcbcEKXW7YAhoLfTSjdRMiTHOHw4Nw1ybT3KI74vq?=
 =?us-ascii?Q?XdO6dvGKHVnJ6SFJE9Ttvv01NqLaINmPmOkNDSeflxzjRAD32x50oUCIaQFO?=
 =?us-ascii?Q?95NSe2C/tRm+6W9n3rJN2aA1oVI2xMaJcT2sRwFe7IUun5gjGeyYbubXJ+NA?=
 =?us-ascii?Q?jq8MQZN/wLCZaYRfgPK/emnzMlk6sJ8C94h96e/fPgBZ16yV/iE+YgX5xM7h?=
 =?us-ascii?Q?FnIQ1asyr+AW+ovhbomfoE1hdgaAZsucWqvAQ5UO+lrrSAWnAlpIX7wAgWIh?=
 =?us-ascii?Q?Z4h8jGGflrwf9sFbo9M4i+eYb4PAo7Cu5ilRqTX6+gWKPt0noPJpSUr+yD/g?=
 =?us-ascii?Q?CkSRHj9331YHNFFzjUJli0noKvKiiwtqSc6px3B9PHCI5rme6rzDRYTAWpS5?=
 =?us-ascii?Q?sSwlC1q5u6prI5aNDQ3FFtHlLJI7hNqf5ixg+9u6c8abEvp9clU2b6A8HvSA?=
 =?us-ascii?Q?XvuIiyqecEDVd7gRCD5VBtLArTuYUbXSC3jQTjdMSOSDqiWaXDAndFrjrvvg?=
 =?us-ascii?Q?avaPgLPlsQ7BEtmZgoVru8T/mzh46eDKXcdQHDIek8SZWVzDKKcykLWf+QUK?=
 =?us-ascii?Q?RYNKLeeg97TJlu/swYY03bLem5A80Gi/SWjDfPYAottJUvSG2stb5EWk3d5b?=
 =?us-ascii?Q?wp83uGuq27lOnBQVjVpQdhiNSBja6sNEqWgKsOyABHihpCL0ayOK3qFbk7+Y?=
 =?us-ascii?Q?0TkAXmhr7sJYGEReaD0c8BSnSevIJzZnJCQlPGipHkGvakbeHW2d95kB8MoL?=
 =?us-ascii?Q?3z9sjy+D4RfxuGwP8Ca9gTD+FSUMz/V/Q+1DjPPp0lmHliW6kFlDYAA50ZQb?=
 =?us-ascii?Q?L9fl59DB/Vu+AysHDjE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:24.4626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674a4e55-a290-4a3e-b6c1-08de1cfae533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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

In kq_initialize, queue->process of a HIQ should
be NULL as initialized, because it does not belong
to any kfd_process.

This commit decommisions the function kfd_get_process() because
it can not locate a specific kfd_process among multiple
contexts and not any code path calls it after this commit.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
 3 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 7ce4531ec3bc..19ea759568a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -129,7 +129,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq->queue->device = dev;
-	kq->queue->process = kfd_get_process(current);
 
 	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
 					&kq->queue->properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8c9d02d9d437..b6ad546c400c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1059,7 +1059,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f1e8ce61290b..6b39d6314a0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -985,24 +985,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
-struct kfd_process *kfd_get_process(const struct task_struct *thread)
-{
-	struct kfd_process *process;
-
-	if (!thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread, false);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
-- 
2.51.0

