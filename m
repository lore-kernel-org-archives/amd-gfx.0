Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB1CCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C806710EB63;
	Fri, 17 Oct 2025 08:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Iu5iOjL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC08310EB6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0x/Vu82PFL7K7m3Xz5obFOoGwKvtytqNfnfox6PHEvnpBY4kFpXdKXLT3c9vgNHnaB0REEKaBE9JEej+G+LD/im8c8XW4MI8BcnCZpAhQJv3Sd2dn22Qg29NkJHZWjVNYZccib2vq4n7D1ATY43nuP2/cPOmMbb4puIPrv1PNunBTx8lfvwzyvMpeUZLmRwXNSSauBfw7SOa0egmGDH3DVz/6L7l3b58FZbjhcSuGrOjKeR/Ge8fUb1tNz3coWB/v7AiiZPoZEfAS2X8UI7H6jpjcNYXLeIBXp7Z9xsibl0iBdIJ7mgW9vAhZIsGMezCPdXVhBuo+DlfEzBG2Q7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGYQ5ySgokqY8QW6CXlW8YrNmHAT2g9hboCV/nWcwWE=;
 b=qlgcNBurR1kXBLenHLKG4UmLqQyJxLmFGo2BVtNqX/2mJgIwJfa0U6IhxpNCRXNJfyQ0vMlIIeK97fgkoU7Ckn7ypYH2e3O6jgVyqLwpSEF02HkBhB8UqPjHAcS3kx2GlpKnVAkc4yKvtEu6cBn6Y5ENR7Oe+X8MzFOca7B9mM3N1+0EAHx3m8AObDM8jflpYPpT0diiiPqvqTfGZTESJqbgSfrEafl1/jclaHa9ZK8vJP6RfzYR6qUwZ21MTynMkqONBgH9OOTL2tglgNCDbT96LowlFu5wFW3v8uqrLNLf3ta8HHNNOxl0bhlco2d1OYZnkciQrvZ2xXNXk8WCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGYQ5ySgokqY8QW6CXlW8YrNmHAT2g9hboCV/nWcwWE=;
 b=3Iu5iOjLMManW3oroYGB5hHdoMA1vR1UnqTMDmKXSiRxbKct20MgU2CsbbYAYPw+DiWvtyiNADrqHlVzPvNlHmxzc/LAQTLriOblNb43YslvqAsetIMSnvVKWlfLeRzkdOZ+HD028KhyjJBZoXfixvE31m6CLGQtVrtVhvWhsFY=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:43:28 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::24) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:27 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:25 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 11/18] amdkfd: process pointer of a HIQ should be NULL
Date: Fri, 17 Oct 2025 16:42:15 +0800
Message-ID: <20251017084222.54721-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: db488cdd-fb23-407f-0c09-08de0d593dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S7/nba/oOl7QLY+AfezBSQPGnDr0UeQqUFSGkHHhKq01WvgBw+DQemC9vOdy?=
 =?us-ascii?Q?SytWJ2t7gl0AYb/Gw+IZLOrAgxFSK7uYel1cBsotnc6bov1Kq4g/cC7SA9wy?=
 =?us-ascii?Q?KZQYmL8ofAArSZBl4s9m+xVz4nJAy9onvNaALeg5BtQ6jCVY0bnB7IASgFPn?=
 =?us-ascii?Q?HtYhpbON7T49tmkbv31yu/C3SVb+1v8tYt6hry4WoNHEypKGKr1mUXx9P9lV?=
 =?us-ascii?Q?YKvz2Ngi/QuzpvRb+w2kiTjBHxT3IU4aX12646cpMm2jdqbSTCyuaTyBTj/h?=
 =?us-ascii?Q?Za7FtxsEhjspOUwtmnXgMcJ1vfqcJA9e2qOt9P77JqUmnwLiybNqAZvAqCdb?=
 =?us-ascii?Q?UdjSgLzD8q0y1fpDbG7cSIKesLo35i0i8dRQ1g2uISZOb16j3fKuJiosuoyn?=
 =?us-ascii?Q?0TRP1GRstFfWISvAFpuHaKx237/6FLZnpQG02F0kqLachogLwuUan3aaIdpf?=
 =?us-ascii?Q?E0oOmqz0qvD5nHYJ0WC0RrnQD2hNrZUbM2fjOSnpcS6Vt3tV+YSiY7pzeURU?=
 =?us-ascii?Q?3M8/cRbxSVv3Kf/ogbnAyVJWPMR/HwyqQqRKnbPFSVOgwxOUJWMl7CLmh9Ml?=
 =?us-ascii?Q?zZpDGZZAl6/jAKQnN2OS/1Dy3VUOcEkEjsxx9CvmwvJskUw9fAAAK1zl5+WW?=
 =?us-ascii?Q?3C2vysFt1O8rUvRZOkJV6/mpROv2Zk7E8YKMd+k3/5XLCylFWONL6rV5dVB9?=
 =?us-ascii?Q?v5gWRV4507k1QpE5KOa0YKfYJQedAgBsPlDYQMHxelVkOzSXxAj/kM01/z4a?=
 =?us-ascii?Q?0h5aURqRmxVnSzahtUScNq83Wea/6YdLpWNM3PtyvjY/jx0QZID/S4Jxd9mf?=
 =?us-ascii?Q?GwMy+czhukKx/VLgVfP9zjMJfFndkHhlnDw7Yvxz4OU2jVaBmVI4wDeYiH6P?=
 =?us-ascii?Q?QSyAzCg9oksWq5rnggCYFvVJTynZokWKMBgQcWqCazQjtZJCdm/VBadFCTJy?=
 =?us-ascii?Q?fGL5on6DKjylHdLJUkAhQyCrggHGG0FQBOeUNYGq/sa6finr5ZzURRQ0qaHQ?=
 =?us-ascii?Q?nUekFWXUTfJNAmjv0RYik8fYlIDnfrZLMZWovkXzzYW26Uni2WxGa5ZY1kGf?=
 =?us-ascii?Q?l5hIbDGYISS2TC/JzUG6dRrToaMs9/dhVl4n2+574IMP8fWxutrixTgOW1Ln?=
 =?us-ascii?Q?wzHOKq62+QqyZN5nNQZiZpVaJ4Vk28qO0NRRmNrREaqdoaiNkgP5Q0H8eIHb?=
 =?us-ascii?Q?wYbr5/So0qAJZLfU+84/z9FZGBonSOtDAKqe2pdsTzF2ptjapVw2K1l15T8h?=
 =?us-ascii?Q?7aSV7JQthcyWbB37FMS41Kh3O0CY/KhQwH+b7OKc0McRCEVW0rgoOjNEhQYr?=
 =?us-ascii?Q?Jrqj6nArs6rtY3grs5GZL+mcG5RQDyiknheMc1uiiaE00q4YBmMFXsEvMso5?=
 =?us-ascii?Q?cdEWwaP//mBlkwSNgaMV5uLGUjRFjZ+G8RRf1mmE9eosTTixPpjScP0DbMZ+?=
 =?us-ascii?Q?fTN+nD0KRUEGxqEbWWjKPpOcpdq6D90Ua+dUQt2C8m6WUiGdtB8hrNe0r2ah?=
 =?us-ascii?Q?mcdfL9+kXvi1WDUIhjvU3ca5CFyBc9X1HrQtpIU58yv1ica+tc+nHsqKtwAQ?=
 =?us-ascii?Q?0cSLOYEGTICZZXES0yY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:27.2688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db488cdd-fb23-407f-0c09-08de0d593dd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
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
index 71c0cefb87ea..42b6492d7682 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1060,7 +1060,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 157145c94314..35a9e91650ca 100644
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

