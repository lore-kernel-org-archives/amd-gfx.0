Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97F5CEE33B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 18:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579C710E7A6;
	Wed,  9 Oct 2024 18:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F54DvPGR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812BB10E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 18:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkTeQ+aDyD2NI1w0bOSi6RXWf8q6hsvZhw44JA0UTDZ8aUVFFIlSPY66oLC5LsWh4FA78rNGP7AQGwgYWZDO7Iu5/kErraj1kjkvqPQfKHPCLtfNEqDEP6GaaLMg6gllHtVuGqpblXbZmDQvifFeIRi9/FdXh3hYs7srw54sDRBMufWiCth8BBsLsfGAz6b+OJ7JBqL/Xfy79KdSgUfI+RzY4xJmTCZFkGQXQ3csJLIZaak5q6RYbGxE2i59wf4YFdAnBRjZe4tULO+pUASi8+ccl7xegrvADU27eaAHX5Vq19rjyEVOQXB0oxPyZCQuoZdkJpo28Cpvgt0BH7t6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAX2bkpjzwW5DuD5KcM7T3HjC7SlBbE13NG8XpyLnS4=;
 b=Bq5TfmrmcZ8gMxowEDGDLP46Y3B/WupwoWDkesFUssjw+Yzgj3z/jyb8beaOQiqHZU2WvuERs/l8pBWT5K6t6qTFHGePBgSbA5NMTsJmCIq4az2hTXlbJicJ9YXhP4SXAjD9nOfA+GQOHT9+f0rNW4P6H0esJgjBSSyDwiSD6JWNxlwbWXOb6gwZvESCMdsxey6NsIrNQ5ufpfrJjJIwPrjEkbOp9MneQCMXNHJ1CXwbP5lSxaJZzz6yLFpMqsD1qjjIOWPduawYCw2UZ07iRO+y3YNkrjgHYaeL2VSCnsuWFGjO8LpcAosPiXxx6ktu9GYn2Tty4avGkQiIA9qHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAX2bkpjzwW5DuD5KcM7T3HjC7SlBbE13NG8XpyLnS4=;
 b=F54DvPGRGQZMYlTrxvm24XH5rsIr+D2ZcvPWQ/uqrp1qk0Q7EzVhJ/2VScI7a4dwU+/EPcw/XZk4O3pSfkkRuLcOaLqveIzi44dgoBlQrC7U+GtqBfrtmHAgvHMI8TpXD8/rs5njMdLhKS98l7eQFmme4aMwvny3UTfj5y33ot4=
Received: from CH0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:610:b3::12)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 18:07:37 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::37) by CH0PR03CA0037.outlook.office365.com
 (2603:10b6:610:b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 18:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 18:07:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 13:07:36 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 13:07:30 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: change kfd process kref count at creation
Date: Wed, 9 Oct 2024 13:08:55 -0500
Message-ID: <20241009180855.14859-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e82f54d-702b-47a9-72c8-08dce88d4195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xGifELmGuZ79GZD/fqpso30nqbIOGXTUjWXRKUTLk4/+iUNVbxCipvRqRFIx?=
 =?us-ascii?Q?z4/XODcZ4brLTq2Vyb4buq4Xz86gsRGmxfrFF1NbSj3IRI5xK7DhM04oAGZV?=
 =?us-ascii?Q?7UviuBEzH4rxvg+tblTqB3tS9PYMDwIgXD2gzN5h+o5U599AlutOMB5XdDvr?=
 =?us-ascii?Q?/vlhTo6sMBT2u+MWnk2BAyfKG/cUEbHWwzpSLIBlW/ldCfkanJZ3zizEhLo8?=
 =?us-ascii?Q?H/kO3pki9aHYwTrksXHjEaQYIdpAzLCnckP50VcbQ/edStu4/B4WOVYappUe?=
 =?us-ascii?Q?CH0daOnVqDcaJ4PwE0yqE5xYTrSiTD6sYLZ0o1Ac0IcTPcWX4MfVn06wk+DJ?=
 =?us-ascii?Q?CpPav8nV0GTqP/xUiitdsJJKZb23ldBwE1BHYoTdA5Ym4BHLWpjZrnymvLEM?=
 =?us-ascii?Q?xeLVaWNsmFu3wjr7bn8aU+CKpdV0xVCVLju8OGsWtVFbeqK93yEuC2wTYuMQ?=
 =?us-ascii?Q?dN9dt/DQBMFUl+JrV73utBxjbhZyFAM+ABXK67pVKOOMH/zj5HISMMKan+sM?=
 =?us-ascii?Q?dt9E/bzkfmSAnMtExDZ5D5UF12/1b3SfLUQv4Bz/ksj84Ur5C4dwTuxC34dM?=
 =?us-ascii?Q?l078A21EM7YCX7W6K1aspTFZX4B0ZjjHkBNckklHjVYwsEo2V48/5v9NgRwf?=
 =?us-ascii?Q?h1NDGxabE9bQsmgkFSAujjGVu6sz6UKL1JEYKy6dsF4muLiQsUqLVk2JLDbj?=
 =?us-ascii?Q?tJmzG9YHsYulApMEdB9YRzkAnNJ2s4ma6Z/MQljxd4aoQki51p9ofcRR+jxK?=
 =?us-ascii?Q?6Hnc58RDrNheNwbf7fh3Ww/cdAwcW0Aq8qMcHyvbyQY0I9NoFvX3wnt0Fx9m?=
 =?us-ascii?Q?G7CQ6wuJBwiu0NLSbfRWCfJx0GGLH0CSvABNFbP5f/7NcDpRbDZ4aF4azPA2?=
 =?us-ascii?Q?zxs1LioVofr9WRRm4Ud5DFW6a6XA15OdQo3blf4UjoGyUxJOw3/Bz9U0dzrA?=
 =?us-ascii?Q?Q5/rG0cjDhzrf7/bQRLZwqsObLKdYcxJU84sXXNpvD7k8H+sju5an8u/0hdH?=
 =?us-ascii?Q?QRuV/6crilzeYJt7RV0f0lEePsnN9ZsS0jxaHHSFQ0nw52V9H4ce6Rrj7grz?=
 =?us-ascii?Q?LC8PgW5PCx53OT8ZXvYz38OIwI+ruZZBn8099+R91oV6T9hIjj9a4FgIlpaH?=
 =?us-ascii?Q?eq2QX/cE2s10f7CA+zWqsMbOGC5DU2/Jv6f0ybQ8m57E/Ab0VTV1izMpGLyQ?=
 =?us-ascii?Q?Y6b8UUiP+j2qdLLkHKhlCslebXRlx06me1KpXVetYzI90x5RVSGuoaHBJoP1?=
 =?us-ascii?Q?tQRS6+ySUVVs4XNnILt4LlZZD4DjRTwkOFtqsBTPgM0dxd6AACkdse2MI2ky?=
 =?us-ascii?Q?E6I5RpPDth68AqdQFOvem11ueMTCrKhF7ELJTa1n3xaA9ugqFLjvCJ2CKliE?=
 =?us-ascii?Q?z5h+IMBPcqck4p6L7tVDmTtQQyaC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 18:07:36.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82f54d-702b-47a9-72c8-08dce88d4195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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
it is created not need to increaes its kref. Instad add kfd process kref at kfd
process mmu notifier allocation since we decrease the ref at free_notifier of
mmu_notifier_ops, so pair them.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..7c5471d7d743 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
-	if (!IS_ERR(process))
-		kref_get(&process->ref);
 	mutex_unlock(&kfd_processes_mutex);
 	mmput(thread->mm);
 
@@ -1191,7 +1189,11 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
 
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 
-	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
+	if (p) {
+		kref_get(&p->ref);
+		return &p->mmu_notifier;
+	}
+	return ERR_PTR(-ESRCH);
 }
 
 static void kfd_process_free_notifier(struct mmu_notifier *mn)
-- 
2.25.1

