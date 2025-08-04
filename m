Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9003FC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3706210E440;
	Mon,  4 Aug 2025 11:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAQvIHM1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD33C10E43F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUobx6SoDTKd/iwfHmsM68VOxoZIyoCVzIhmDWD7puYKDBaHUlqm6/IVFmbvn4P5C/eqq6eTrlrRfJrFtKSCyV/ZkYpxjNoCwz5vsE6bFqh7GN3MAuIejS7zGEpfRNbHsBwWJ9vzYuUpuDrVO/VQHRvbSFKCCQrSAapvs5KBKaXFEYPqXTqqdWRCNRGuDI5bxJvQr6QC3No6S4QvfZ8Ej863TgOTo3RN4Bh1xGyExWvVSbnR0Q51/SaTyYepSmCjb7QaOxjTqfXYaY8GhF+qT8KgRwODPWxivpfSSX72eAeuCjHpIPgii5plr3oC5y1IX7KVIlkknV+efNMeSphRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtdcKkki1ymE6D63MfKP8PQejtv5Run2zqLiQf5siKo=;
 b=i0nsrnyEL9ZECKkk7KRuYMOhOmU2Tm2VBx72avwMA47oJQBzg/gPh2o+x3gRv6k19qYgtyQY97pBT87qiNzd+wcm5TqrXNcOARfxI5s/Un2YBXvIje0xkSdG1sG28M3b8a1h1cz/aqyE83d8qhtms2VZn8DFIUa0vKDGwyxgRmVXAL0qegIIRiyMLS/FAqRd5dQM9pous3zDakWgJsBoiklA9v8lBxB3qgpyLC2+vAvBTbBxWwfJXTtvzwS2ZFb+Jq/+rRBR+Zb5DcXAabYBOEZmCPPGab+kgk5Mqfgl6gdipuCmO7nm0EJuyi0RG5TBZAOGM5G3VODbJOG68kcPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtdcKkki1ymE6D63MfKP8PQejtv5Run2zqLiQf5siKo=;
 b=pAQvIHM1Z0yia6xD2xoyUtghvvniyViuYLJnWZELoWQbKyRppVmxmhl338egxx9px+61UkW1ei91P8W6NTfMPPIPw1pAImZWSfpdLU86O6xI1Pxeg6L/dh6pNlbIrU9THmdrovUqWTktHxXthvZsDX1zWptn4f/mTkawIdk0MDo=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:46 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::92) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Mon, 4
 Aug 2025 11:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:46 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:43 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 10/13] amdkfd: process pointer of a HIQ should be set to
 NULL
Date: Mon, 4 Aug 2025 19:05:47 +0800
Message-ID: <20250804110550.261311-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5256f097-701a-4085-780f-08ddd34700b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y70rjdR//8gBgTVeuZzlEyU7HEv1PN9MOQ0bT5ZMIYCCsX2zUgD5zx4QG+GG?=
 =?us-ascii?Q?DjFFaY9ztf6jPn5Nq5I3Xzp65wyfgHBjBVJOCicPtkKdNVzMoKQO7ZJorxwq?=
 =?us-ascii?Q?oa5DVGPn5AYQX83WX9z+1NCl2X0NoGedkdbGxlv179r/rmAH7ue0YfL9JZar?=
 =?us-ascii?Q?0MUc8BP+6Q6UA1iq5Tsi145g1bB7xc+qlZUrJAVbK4xSIIH8Z/P/AygQjwC6?=
 =?us-ascii?Q?nwVc86uVhP7TzQs/bq5TC7E5ReQpRjIHLHXBSbhhYTp+CMUJejAToymPb2XD?=
 =?us-ascii?Q?htW/8i7BHUxxc+j64lsfGWpNlOKpNlrqiTicS59Ifb67h94fdWcOzAqBQ0Yi?=
 =?us-ascii?Q?YuacZx1YodaJxOgW5qgv8Dxgg7Z7V/HUd2Rg3aGdBVQ2Hj2liB49frFvQnYR?=
 =?us-ascii?Q?De1m6FO4o1uFa/hqtTAInxR4yjaFddgGaEFDVJeKTQOSrC9KzlhH6MYu4ZA1?=
 =?us-ascii?Q?4O4x+EZCxPgsTgeEkHfehOEUp/+ZwHwY8qilSb0Ip4qZbTDH6MXBsL6M9Uvi?=
 =?us-ascii?Q?H5A6BIymA23qO2ujv491LE7hGB7OYzjw2dnbuu2614lpsR9gE5a99SYweES5?=
 =?us-ascii?Q?u60bEQG3eFZaTon3wNXV49wCzpAMWMBUplIaIM9ZcjRgTCyOche7sOtutecc?=
 =?us-ascii?Q?ypjuTLD17OiqMmVdENHiqlbHhjIBlnzJBxZo6Qa2nvbQJNDsP3fnVnw/A6LA?=
 =?us-ascii?Q?BBd/AAOvGc/XnGPvRC6EjA62vivNd/ktnR79fwyTJDejM0KPHfjg7g3YmbFE?=
 =?us-ascii?Q?JGpOBthb2lry+nO/K2jzp83R7FyFECjTvO3QUwyz864qDRp2R24msojq8Jeu?=
 =?us-ascii?Q?C/iZjx1qw2/uOSwPlJ5qq0OaIoyZ8OILulrG0v6t/CTQdutiQuZFGWvWQnPh?=
 =?us-ascii?Q?86aTSo/w29xiLfSLa73RxK96v3k0DwVzd8nNP+kJ1zL5R4Z17//f47FxMHha?=
 =?us-ascii?Q?ljyn/gtxUUNwMXn0ymw3TjAvZZ+qnBTIJQWEPm1MlQrITzVioCv7qqxHluuM?=
 =?us-ascii?Q?f20GczReXuNaXtxObF79OBZ95RAMul3B6K8BCLHp6UQY6hO4UTisiSznk5p8?=
 =?us-ascii?Q?S7dnXExSmLLpZmQsO41Wg66vKQ0j0lpgeN6JVBJJ2+ursJWjJeoaPX/VlYJo?=
 =?us-ascii?Q?qEH3lVqI1ZoB8WK8cEnYoSKQ0MnLHCaT2yMl3KmYlygFBr5eec8e/XeLrJtm?=
 =?us-ascii?Q?ik29VsQkvIIXipgiaonvwwaZB4TDKT7Uuc8krezVKEMLgo0EtB9IdqvLd5i+?=
 =?us-ascii?Q?Zr2FbbuzDSJgflvohSTpZDahBzTaB4z18VZnj3GMnXyX/k6X5bUhOWCp+B/b?=
 =?us-ascii?Q?pwha49ay4TIro8PsD80l+KExVrAOHl9gn8+CJ/yyITgs+ObyWMw+qA2BCaYE?=
 =?us-ascii?Q?2C8ASfwiY+r/xyKv+OuSluqeEgUWRtNOl+2YuPtgZafqgKleJJ2A2dD6xkzp?=
 =?us-ascii?Q?oK6Sb7KQpxqKwT+CvTha0/BJpzjNicOoip+sfPyAb0tpKkrKYlZtZK9w/BTt?=
 =?us-ascii?Q?GQMNLZZIsBUcY07Zo7SiJnPi/tWcTLNqaHBz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:46.3169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5256f097-701a-4085-780f-08ddd34700b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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
be set to NULL because it does not belong to any kfd_process.

This commit decommisions the function kfd_get_process() because
it can not locate a specific kfd_process among multiple
contexts and not any code path calls it after this commit.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..ebee37937783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -144,7 +144,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq->queue->device = dev;
-	kq->queue->process = kfd_get_process(current);
+	if (type == KFD_QUEUE_TYPE_HIQ)
+		kq->queue->process = NULL;
 
 	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
 					&kq->queue->properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d140463e221b..25534473c28f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1050,7 +1050,6 @@ void kfd_process_destroy_wq(void);
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
2.47.1

