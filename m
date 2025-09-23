Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B6CAC5B3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D5710E582;
	Tue, 23 Sep 2025 07:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTi+iTGO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D3210E57C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQAfHl1r8OGUM2ykeIVFBROaWwQ2aEegOlAY5U63wew/CoU/2ss+H5aMa0JVHzow6/OKAx/p0w3oyUCDDtdtKL5oJlSK8zkQBr+mXDw3136kXGNMkBenQRVlV4LUNB7d20f+5jA2lbP8imNsI6/I8IyIDvuLziGvqk/BwMVDN7nQRFUJdbg0XatTXhTN4471oA1opOsfqSog7hVA7RaC4+HeTh1BRJpuBV3fQZB58tLGyVprSPnY6vTXqLtolZxRKZGIJP74OzU7fWxF1dAt+0Tek5kG/pbEV9HjIR68V8wLC2Z/yRKKQpgD2gQ21nD5uJFCEDqXFpG1seapApiQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57NlERcCI2fFKDNKNLO4+3PhueLoG0fY2bum1pBsGQY=;
 b=MpKbIjhP/DYyYSSbaeNupe0BxNcOccC7DTb06r5kBYIhInJoYkUOzpsvrTLU+KULQ7m4sjkpZPurJNZ8S7yx70cevwKvXyJ13NOzL64HuQeYnCo21ymyoIn6cOoxbBGgHYm6/kXyKSrZF/0yL54krzglNF19eaEvFd2FpJ+Fqex28uhdqx5RII9FSyRErtcyYgzzml/1RHM8Y+K6xsrtR6Ybg9YAs8H4ExQpUZ80FxBmLN4ErTOaJIHXNair/+0GnJgHoZ/Pp3WpzK9W5DGXWSGqvjffqBIjoHyfxp16jZwKSiEgOZasXYyUh537KfV6MrhlqPBHT3B7OEbAKdKbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57NlERcCI2fFKDNKNLO4+3PhueLoG0fY2bum1pBsGQY=;
 b=XTi+iTGO5CJ44igQVLc46HO9/QOLJKm2j0W74/EN8dedQGjF+A9AnPThJFqC9LUlgkMK/hZxIQF2Wm9Dt1Z8Use2qROXgCOCPaP+FHMDgZ7o7OuEyVcpYqjO4Ou3NDm/y6GcMJuOYCfExWR2dh9Hm8hYNQpUPT1zs9yRBqLNwBY=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 07:26:54 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5e) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:53 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:48 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 11/18] amdkfd: process pointer of a HIQ should be NULL
Date: Tue, 23 Sep 2025 15:26:01 +0800
Message-ID: <20250923072608.252345-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: cedf7abd-db67-4218-f022-08ddfa729220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/LeGlOQ+bdW2pWbSu5icLXpYc6cBNKjhy362dMg9H7WxoBIUNvkry6XPxy3?=
 =?us-ascii?Q?Hno8jFfl59tzePaKCJFP1khZLJTQerk5YeyOmV/zR7tD9TZdwyalpIN2FJc5?=
 =?us-ascii?Q?t3/n4Nx8SyV1shhgkncGY3l254dey2cjPF+EUbm2pdqNsi4e5fQIQUEPV8HL?=
 =?us-ascii?Q?RtiKdW8f4xGbhV45Ex5hVFcVYhdizDovJz8UjRTPKAHb9y5oPr5k7Fvj3Sn0?=
 =?us-ascii?Q?Nwe2H3mEcOUatqV7oT80OFTR3vAlKGfIt1LXuQ87kCE4ccdiCAonerO/nYeA?=
 =?us-ascii?Q?iwcVWAP6JPnwl/kXITUpZV03sPNM/IUWoLZuTJ9p9qRLC6iG8Nx/8UZAZhaA?=
 =?us-ascii?Q?XxgrK+bEDaRk2bvcxmvgomOOEg+qUDuVP/+akmLHVpoRJuBQtRBpCwfv+zhy?=
 =?us-ascii?Q?yiHV5Ti4fIZASM0Yd/G3tezwchxNMEBb5jhvdM6kFoec1eIDpg3U571nyvmW?=
 =?us-ascii?Q?XIriTXR7z1Mz6Qw0k/BYrGc4E931jth34WuZ7TOEG4lYxTyYxz028NA+drBy?=
 =?us-ascii?Q?aL7AGpvv3kgiTWwOR71/FlY7O9igoYtKP3SULyqff1IIRqmBCRlQX+orq9Qo?=
 =?us-ascii?Q?hRnksr+Rq/je7AuGZsVY1QMvFeMLKA2E6dE8q9o01qQXiICyE6Ml2jfJ4MVw?=
 =?us-ascii?Q?d5eaWeQnprwyk+xphjGxbKa3TGQX0LoLZgW+cX34KE0f0skURYk9ti5ZuiPp?=
 =?us-ascii?Q?EhQ61XVg07wvLtc1wXYMoW/VPMy8ETOdbtmAiP4/MfVYchMQhHIq6jmhSDvX?=
 =?us-ascii?Q?3exTVOVhNBxQE39N8rcxEEPeTj++XyOR7jVfbMc6hOiv5Ab8kwZZdGpM25Id?=
 =?us-ascii?Q?fzs0s/wCvQ1sts4P0E471Z7t28sJ3ciU8snDGT6NzOg1VzrhdEuF00KO0V9s?=
 =?us-ascii?Q?FPy3aDWa0RTgHRoXZFJXQ9eRcGhsquK+2xFyMy2njOV2GzoEQeO+Gk8hGXBd?=
 =?us-ascii?Q?apaTqfn7CJBBIx9dUGB6ZjIS8eg5VfyYgOWckJUSvxfLEP/EfwN4KcIsrNAm?=
 =?us-ascii?Q?mzCRPCZFp05RJ79oQOuwa91dOQMt/HVP1KGozL0nc8lCxRgoKBzrutAlWUcP?=
 =?us-ascii?Q?UbRSkAEWvVNcRFBr9Lz/jqfP3dkO0N8mMuFbE7xp+PIpBOCJnLl8g75/S3/2?=
 =?us-ascii?Q?NHqp17sCWgqx9sE/x2og6Q0tRd0qvJKvjegeEjH8yNwGjJeQlGLT/dWGqaX1?=
 =?us-ascii?Q?/EF8mA7HgDCtR4mvo87qrGq2z0uAsjquqyEoRd719pEmA7EQnm/ifoyK69i7?=
 =?us-ascii?Q?2gXQlRMtg4eFtXCUEJ3MBV3U9OOdIHj0zfJmt/qxUBeJmDuaC543lbgw/Nmn?=
 =?us-ascii?Q?+ZiN8hq9Bwn7nwBwxceqk3Qp5Yt5xRcYsLVkX+BJkO8Sja/Nv54dYb0A8WaX?=
 =?us-ascii?Q?a/7VXy1jmwPCQPy+iRPeBSZnSQ9bXMxU8ktj8iA87VuPP0DaCH2CaBVJKtnj?=
 =?us-ascii?Q?TjdlROndPSua449S7Eye2pYHpZeAeoYoQTDAfi8CWTvBIJEwHzH9oaafKblg?=
 =?us-ascii?Q?kSd/+hn7174UIZ2FAnVtjQopQ5wwFH1WLLc/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:53.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedf7abd-db67-4218-f022-08ddfa729220
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
 3 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 4c7ab7a711be..0a4f8e8dd77e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -134,7 +134,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq->queue->device = dev;
-	kq->queue->process = kfd_get_process(current);
 
 	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
 					&kq->queue->properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a2f8b1c24fc3..e09c8bd3e138 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1049,7 +1049,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8e498fd35b8c..0c3f0cc16bf4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
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

