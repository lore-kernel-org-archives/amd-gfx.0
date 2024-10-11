Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E49DD0D79F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 14:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128CE10EAF4;
	Fri, 11 Oct 2024 14:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lz+BsSez";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431F310EAF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 14:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Amp3RgVBeuSgz85Is22ilzs3AdS5q3a63HUQPR5KmcYkCx6OIf25Xm6hQbtWMgBP7OAuz6igG6z11iTsLZKM2v1iHmy/Lisk0DFW9qFmptAZ6Le5CpfFTbXdpRyVCBluf9JIUglbU72AleCwCtTen0bnGDDIR+P730XUAUkGCdlCtHa5+823RVY4reJtJhlrzKcAiW8kSSzgESInrtVvJnMx2w/uq/8UO7zFSAJR7yNUS0/BLm/brxsObiiQHlajoA5WaJfyHqM6Oj9kohMX+Ti15kiY/mT5hfWO+Cwuul96D/Fqpbavi3pNmh92i9Sq/Yy6EfZPCBbzIrIjYr8aBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxSQWNVaI8lUmxVE7m1XG+sZY6FZuBnKFrQuOBibXoU=;
 b=Xe4hvPwogz+iSu5Z9cKbz0nDdzowShzvZCuiJIsq8Y+OzLXkoDiJx4NFICjmtMbOjwPShbDhlOSYGmdRNmBRLi8nq7DD24hGVG8MK4K53741jaAUQYvN1unlVEK37QQ+DtfJ+MxmlNgEiAU0uZPhbGpchU5lnEM4E/RyoF38e5KgqZF7XfOn4UIMhYQ7O1QLFabjatd4GZIJR+tRHetqSkKw1cKGQuHuTjj071zm6tBTnF9z/m2IuotaDh0HmWKWLqYrZayKvWP6ta6rcJr626T4HL3JY8E/mUPp2fRRglc2p04pe54liDjkHoEd3Jx520XQOjjWqBdIL4JFB9bMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxSQWNVaI8lUmxVE7m1XG+sZY6FZuBnKFrQuOBibXoU=;
 b=Lz+BsSezVaJKfLCZ/vVpFMYSMhsFZVJzjJS6Km0z+W70Mv/kbf/h8hmUfekUu0X2x+BJO8z32MSYkozqup0SEO4LWypyC1omF6Lw7RlEXTyG1slPcxmy64BohZG91dr/yKkghRoDtgN4JeavUvTnJoYR7ugX2RE999JIvDzDYTA=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:39:22 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::6a) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Fri, 11 Oct 2024 14:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 14:39:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 09:39:20 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Oct 2024 09:39:15 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
Date: Fri, 11 Oct 2024 09:41:55 -0500
Message-ID: <20241011144155.120290-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 796e0d84-a77c-42d7-20ff-08dcea027ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1LIVU+spZJugzJPJ3suK2NiQqEMNwgLWQ83ks8Z7EJ6cHTEH8uZwVRZhfmlv?=
 =?us-ascii?Q?XYggj1US93LjLYyr4laGAkYZOZPYDgB4Vkh/x3JhSXxZdh4FVDUCLgvMpL0v?=
 =?us-ascii?Q?dSxNb4mpjvaC7HgOEFjC3IHNppVpTGUPOEzaAgICkrOh2YpY/BfRHWjEaxUa?=
 =?us-ascii?Q?q7fOjHmXF4WtTsgNhOs9D/uITESy4zLIoCTLHDN36ECwQxej5bW+Ui5DY6i0?=
 =?us-ascii?Q?s0t6DJyxUYjhUJt6QlyMT+28nBMBBK7Mlszm5U8U7DdSkjoTyuxCxeytgPwv?=
 =?us-ascii?Q?DpPE0NDwSSI0BpyRurulyB8uT+FF+S6zqFnnPXOPCHVhI0G4tgzghivjr7o9?=
 =?us-ascii?Q?E0paV4wFMDWnVfIBUsDbSEdUXbvoI14WgMOegTSJhCCuZVmVITs5o+7WQBaf?=
 =?us-ascii?Q?cLQ2F2dTxcPby9mSh1q0j2Mvt4nbK/rF1BOyF1s/RMZPK3sp+odSl8Jigp9g?=
 =?us-ascii?Q?ABz4LTKO0d77Q6FGa+l1DJXJivfAgHwJXK7xh0/yEibVu8Vlft/t85NXOnvM?=
 =?us-ascii?Q?Yeedt5RQEe6Jf0FVKlgfUBmWQ/qntcK70yU6337Jdxm4UYTYnNQ7SIaTyR5r?=
 =?us-ascii?Q?SFdOS8odvMmRDRf/xxCluc1Evfy2FqK/pkHocvKAW+YYBbHq60Ik+4C93gKK?=
 =?us-ascii?Q?lyn+F3xUucKy06qkQZOVC9bcVhJY1tLter8R6nepV4+CGEwghxJux4+i/KWn?=
 =?us-ascii?Q?5xadavAq9jtg09PsiyGdA8/B8FgWVGj6QDseeLWKwjeryWaJDf9biAzWLSWB?=
 =?us-ascii?Q?F1oFmQfRoglYASX6NnXEOpczal2JH1hb+irIG0dHpjyNHATUxKGPjLdH4oPg?=
 =?us-ascii?Q?Rod2dtKCKcaoRN1Ju0WgRMAg3iLY0HL9tYaHXePEPBZRo3wQ7ho7+eje0C2Z?=
 =?us-ascii?Q?aFhaLWH1YUlUYZ0ROoTd/b5HNE7Eyidzq6CKfrDsfAyHtInqR3uVWh8KSIiF?=
 =?us-ascii?Q?v1esxTMjoG4L6IkmXZOAsomnXrGMY+XzN12vwDeCCkvXOkDjAN2Xzca0lkWF?=
 =?us-ascii?Q?AWObsUUSdJohHOapUVrwO51W4rw6QhD/sNIX22wV6WtxrALbyJi/dBONG7i+?=
 =?us-ascii?Q?cDRoKrWhkv5anRr1jFTC3SNVGTnN/c1mRjmJPWCKEaShB+VP8azT/IGLg6hT?=
 =?us-ascii?Q?/nRd2UenOPcQHhuhu1OO6rduMNNhUVVKppQ0r9jkrP007LfET3bYAlz20Yas?=
 =?us-ascii?Q?R2mby+wxBGZwUlFzJDgptkuvIVNImmkjxs1pxNRhu+kcVLou+srNpsaTTq7I?=
 =?us-ascii?Q?Pg4QXkon10W8wN/R9XddfHUacMjnyoOdXyQw05FQg07WsZZyQ16wOnAf/JuE?=
 =?us-ascii?Q?e5DBdU4UJDpBQddDDHcRel6m/dqbcE7xp2Vkntizm9nJZtzXOx0MQD3wkIai?=
 =?us-ascii?Q?VXE8aab5E7kgjkYbxqWn+dNtb3GN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:39:21.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e0d84-a77c-42d7-20ff-08dcea027ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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

When user process opens kfd node multiple times the kfd process kref is
increased each time to balance kfd node close operation.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..78bf918abf92 100644
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
 
@@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
 
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 
-	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
+	if (p) {
+		kref_get(&p->ref);
+		return &p->mmu_notifier;
+	}
+
+	return ERR_PTR(-ESRCH);
 }
 
 static void kfd_process_free_notifier(struct mmu_notifier *mn)
-- 
2.25.1

