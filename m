Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56759D5B154
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 20:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C611C10E577;
	Mon, 28 Oct 2024 20:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3fsF2NsN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53610E576
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 20:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duAmW2nRjG9K2HSGmSatrzbWHbzJmwSiY+tmKZeyqe+x8PEUgPERjoA7/CabIYqtScZ3a/EwBQEBWa2Jw65PmUC1EwTr2QkqtWLpKsV/rBw2aXVjwXMA3ryPlgeHZjUxG+6CdJOTSGgIqEc5y+np+j7zcfxVQyPn3Mj/yu24hDAfpaMy8WADzlZeuhgrPNUvXTfW+bo0gfQS9LLVfkdQ4/+P5Xz6pMLtPz2uzq2i6dIChWPv5K+d4jBO0tU/SwwxrDq0Hw2wyub/XpB/LGKAuDq6oWqSY66ACQWAKaOKWls0Qo5Mq0CNNk/CtTscm9FbQ1V+i8XH8Qu2EubDyBJzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI07xfJVBWSSQw2CYKjUyRgvlgc5lAYB9Vngkkefzp4=;
 b=zQf555CxausKyYohxHRPMtoNGpUWbZDYdU9QETDUTHs21U4vMuMi9qzM/K3MmG38EFJAiiV6UEg+W4Dnuwnbf0p6Kc/gPpXoyG+afeF+um0DqQhvWR6yv1q+at53b6ws+L6a/ePcEhEozNCyzfJzDrVF8xblbYB56RYa5DPr0AGVAnAPnFkljYni54zuViHF/CemDFBeDhyGjT387dr5NXmAWAPlrbt3Bql4AHJCsQPPChdReAz9yk9UShn/ArVJopTWlkz4H1I53vkPVJsddbhzUbIcoPH5wPcBPopT4ovKUqfYT3HfgHn5uTZu9TqfoxrHNOgjbokeSMkMWsCtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI07xfJVBWSSQw2CYKjUyRgvlgc5lAYB9Vngkkefzp4=;
 b=3fsF2NsNyLOQxRvF1xosx7WaUhOxoXRCwEKDNHWUV+CV4u2V2yKDzbn+nqB/sc4cbvVVvN5iWC7zmBTa7+EzMNijvrDDlt819k8DbZmjRKNACX0hQOyylk+aRRvcGE4WpBD2zoiXnyB5shF93BO4+NM8MwmGIpVioOCDMecQLPc=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 20:43:26 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::ea) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 20:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 20:43:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 15:43:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 15:43:23 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 15:43:23 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>
Subject: [PATCH v3] drm/amdkfd: change kfd process kref count at creation
Date: Mon, 28 Oct 2024 15:43:01 -0500
Message-ID: <20241028204301.46168-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1a1e1b-2baa-451e-d6fa-08dcf7912bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qDUPbXKgbHwAbgSV83hZ33/KrNl45atUzcHZsmkAqiv5+Y9ogDgNwEk3+Vlk?=
 =?us-ascii?Q?fUgBJSkRuqoYrLYz/BxQtyOrng9HrC7I6ZSJzo3zxsKLoCqj6KHW/IGOo9M+?=
 =?us-ascii?Q?t5ERaldR2T3CiJkpU9AnBe8q/FvoaHQE9/ftLTtQqGb1LJAyFMf/Y5ETixoA?=
 =?us-ascii?Q?WBsvokS/cjL96548eZ0VceQ3TgXRyDs38DKssmqb1DCDgHLXpo+8PbMoZAtY?=
 =?us-ascii?Q?uZJa1WbIY3UzCmP0Izhv60fUfF8msRpd2NaDzGVqRp+MmVQbSQQZOWh6bBnA?=
 =?us-ascii?Q?4cX27hGXGihjSBUiiKC/JHYudHIyAaHcOyRnxezX3UReJWqU3XT65HCe8UGs?=
 =?us-ascii?Q?fhJr2bGsIoRrYKIP6bD4P4FvHZKVGg+DJVpV1zDYIn1pT6ny8Pza+n8sgLi0?=
 =?us-ascii?Q?33CwmsmdrfBs0mpgxo5wsVPW4f07My0CEfpHlATz71s/PGwv1uj4IO9n0ErH?=
 =?us-ascii?Q?LxLjn4BOXtHGJrEkcO47XjToshPFOUv2EM/ZlWt1MYjkj5PvvzoX+gtISBfU?=
 =?us-ascii?Q?WXhMTxnt8dIr/UlsHcTpe19s97iHodbyN9+QDTUcX24NsQdleSoUZcpMrr+9?=
 =?us-ascii?Q?jT6lAd8WfmAWw85RVqG43ULdPq6Ux5m66+xABbJSNSfJQnQvmz1eoX9xt2kg?=
 =?us-ascii?Q?tPbdAlp4SO9EiQanNF8ZzIfxM6Ip0T++FI1e91n/ctWaOKXpeQTLBQYasEm/?=
 =?us-ascii?Q?sx8U4LtOqeLqAlqwGXF9FOsGCizhpHdPZPhUQf45x1VDPM4k4hAPUFHhuaGI?=
 =?us-ascii?Q?Iy1EWMg0Zuvalm67Kp5X2RntZaNp/z6erSbn1bCsuAngTe3HgdsF80p/E0OZ?=
 =?us-ascii?Q?kxCb+93I1M83Y/SHVmBLrE1MNq4grJQuVBd+R56MdyDzc0UyciunvXiXinJm?=
 =?us-ascii?Q?UieOHIDnryUg5JH6I8eP/hha6NgCoVWm7DLxec5z1N755tSr71EKyOU5YMTJ?=
 =?us-ascii?Q?dm5lusHCPIFJpr2KEg+wVLHSShEJRHXqA4J/cXp/VMafbrCGGogrDGFOI/IS?=
 =?us-ascii?Q?K0Prz2/n08GW1WGT52S5DLuD5Qnna5IxQ5gml8ItW/ORyIexTp+me0uDprS8?=
 =?us-ascii?Q?CQqVTfG/ZNUgetdWsEaD/R0KH6H3v5NUzYKp3DP3u3QWWQZjBak8YnciVI7W?=
 =?us-ascii?Q?2jd25qzH36Ult9segQVLMJWRn/VJ3YO8NUR5pWkBIbyC9VQPp9Uhnw0U6raZ?=
 =?us-ascii?Q?2EPD6JrThKInDAQD4Tpg/l+Yx8bUD7dmYCytsoFIpyPNjkOJApG8Qf8MfxbX?=
 =?us-ascii?Q?mDrk2d7DLK3+SqPZ5lk1y8VywKRjWqG0OdB0V8G92Gb5iraxJF944dyBUSir?=
 =?us-ascii?Q?cfIAsCBNULeh/CDlzb7mMpyDZyWY95TzJkaFuZRLyEookTz8Nv6HSu5sCOrW?=
 =?us-ascii?Q?0ZL+jzHukUL4ZzjcUzT5GvAAEl/D3ui4fReK/gSvwMh+h05fPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:43:25.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1a1e1b-2baa-451e-d6fa-08dcf7912bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

kfd process kref count(process->ref) is initialized to 1 by kref_init. After
it is created not need to increase its kref. Instad add kfd process kref at kfd
process mmu notifier allocation since we already decrease the kref at
free_notifier of mmu_notifier_ops, so pair them.

When user process opens kfd node multiple times the kfd process kref is
increased each time to balance with kfd node close operation.

Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..d871d5320297 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		goto out;
 	}
 
-	/* A prior open of /dev/kfd could have already created the process. */
-	process = find_process(thread, false);
+	/* A prior open of /dev/kfd could have already created the process.
+	 * find_process will increase process kref in this case
+	 */
+	process = find_process(thread, true);
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
@@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
-	if (!IS_ERR(process))
-		kref_get(&process->ref);
 	mutex_unlock(&kfd_processes_mutex);
 	mmput(thread->mm);
 
@@ -1186,10 +1186,8 @@ static void kfd_process_ref_release(struct kref *ref)
 
 static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
 {
-	int idx = srcu_read_lock(&kfd_processes_srcu);
-	struct kfd_process *p = find_process_by_mm(mm);
-
-	srcu_read_unlock(&kfd_processes_srcu, idx);
+	/* This increments p->ref counter if kfd process p exists */
+	struct kfd_process *p = kfd_lookup_process_by_mm(mm);
 
 	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
 }
-- 
2.25.1

