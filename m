Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956BEC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD2510E801;
	Fri,  1 Aug 2025 08:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rd/V04Qa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C4510E801
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpvnX7Pm0qeasGn9nbUXRXhB7PnrwV5jb5kraK34GjtbDIorurJl3e8POsLrtnENpJayQhjb0mG7rQ/ltiNYe9oI2zgnDDI6sQUSjU8Z/uIcd/OPkGTjyeOfuCWlBLmTOZBFP0GbIxlQt+a45j9QKM4eoPKgHycnvtkTQYdA6ZjG7XXedbTAUDpiZdlCgD4OJ/heZZu9c96rHYprVbMgXnBezdv3lSKQyC3MnIZkad0ysAIIzkWB9K/j59Y1gTFCBUUwmtVZPhR7saI3h2y8lXx6yV2TOfQWDEcjKxc95AKICkMX/lC5/o2jYaqwfdDN1xyIRqtXBG8ZKPHzfxqzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfqzsHr973BB+3MXctpy6X92HlOG7afuoQUMRcQxoIY=;
 b=nxVrsOJlWiXntq0qIUjLAKMgXkawRGrLSjqSH3RopVxNEIR5TWClwN6Jo9sEuO4C1q5Z0gYjFsSH0FNZOsdtbkFtiAd5Auxhkm7I0JI2CkXX2RuI1tkV7QK/AFHVnJzU+nBonO/Z43HSkV7FgY8omjAJxA+TEka6LnggX6GjZS0xvIFBv4BPpP/x5YWdan0CLB/ffskgDkNyLrCVeOULQdzidwXXaw/yoKuEdwMjjf6Q0AM5a2/Haxq/z3FIYK7d/5MWLmW+NTbBNUgyX1ZZDEaI8rKgZX4Tznd5gg2Q2zT7QWtSmkgBhOsjaOfwmbLQQ2G2UYdEvxXNVyeTYbCn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfqzsHr973BB+3MXctpy6X92HlOG7afuoQUMRcQxoIY=;
 b=rd/V04QaJQFcdGVzOhgTTt8ixsL24x2b+KP/pItVSHg6jzPzQ5mnIP+pek2eeUasqbO0M1iYdClDrK4xdbOKYkS5/CX48y/7bni6j1pkokAVji4vqK5sh5KwGOoiGRQZfdHqWV71zs+Eyvuyuc/wOjIjpzUtMUK8BPmDXVIjKZA=
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 08:56:27 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::c1) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 08:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:26 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:24 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 04/10] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Fri, 1 Aug 2025 16:55:50 +0800
Message-ID: <20250801085556.8504-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 8025c407-a246-4578-ea17-08ddd0d94c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rH4KfquDTKx4cx5tq5yy7PRt/ZLavHEilcnhen+z2syYgTVk8tVKN/XUKhgm?=
 =?us-ascii?Q?GNqZBYCboNfkYRFMgtZ8+1B8RLVSNUM4Y5iScorY51JP1xfZorble2rrzrDo?=
 =?us-ascii?Q?a0W6qfxAujMJWVE8NNuxSUtj8fX22m+6AV+keVk29ShiMMZzoanWEqDlL0z5?=
 =?us-ascii?Q?NeIYJZYSA6W/PYsV1+RrScAN6BgLeHiEsTCwsHjclM92cXrInaG/f3zjeXhk?=
 =?us-ascii?Q?k7ZxH+ysx6wK9hTw10QeBBz7dLJAACXZhZ+GY5lQSf6JhllK+8FQhQTi2cuL?=
 =?us-ascii?Q?T90kIf3valCLAGf0ebr9Esp7DDU3T/LkEstGwDXDq3AeF6NHyQLKjoGdvOVR?=
 =?us-ascii?Q?50jZOMA0TjGHEWJDdeeT91zhPypNCEbEbUGfOLxlxMRBz4O+ABJnJ0VqmSVi?=
 =?us-ascii?Q?ZjD9DSZxoKd7s8FS5qsnWpwvaDNFNgvNl1jmji3JRmiipXGgqvRSzOu/efot?=
 =?us-ascii?Q?yuceAioTdfse+18XsiYhvO85C5a+zI9BO4SLiub/MFzSVoWodN3XjdLd+MKm?=
 =?us-ascii?Q?M6yhB3ZJe8G/pxUIA+rrnucwfnlEtE3cPubQ6XE8FeZBTBEWXimr87NwpDyZ?=
 =?us-ascii?Q?0vqXQR+40HY2fJ1RohmOIDtQBL0FYIr0q4D/0wzxwsvMzkGWVYwhhcC8sdfW?=
 =?us-ascii?Q?N0uqglW4bclNVkaYyUntRqiPhPc8ovkvPfYK+UCKV53HHiwD9Ac3MOEIy94m?=
 =?us-ascii?Q?P7Tvp96NnlmP2VtbogsNWDEBudlMtSGSD/qTp3TOpJByk6HF6sjO0s+XMefa?=
 =?us-ascii?Q?7OTWjnNAJi9QQJ+U4kq0zSTjBU0kKHtNy2kj4IsG7QCGkRLWO2cTPTzt8qSH?=
 =?us-ascii?Q?UwO4ogEKdRQpKpoLDjI1h5jEIAzTT3W4cg/VcENh+Yav52gmy/nLAdgxjwUQ?=
 =?us-ascii?Q?63UQ+oL1mcvXY23cykTCQcltPulBC+TaOKnNZKVfc8FqvX4SUP45YgSRdN8G?=
 =?us-ascii?Q?5rt4Mv98Qt/U/m+BOsX+3CB9e6ztThkRC2byf6sU2GqyfED2D/80pDp3noiD?=
 =?us-ascii?Q?mgsuMhwufug/0E9Aplo7YY+clXmbAfcFUB+5oKXkJlewZpFBc2mt0XI6RRzV?=
 =?us-ascii?Q?t4q4F6pU4NoTbq7kzMTlcX2a/9bxL3izBdunAGnCVBwxiQlBYyfKAufdBp9r?=
 =?us-ascii?Q?liY9mJMCn78J3KzXGHEmxDyC3Oh15skX/mI6ExPvJ3N1HsHWPwu/3uGwiwNT?=
 =?us-ascii?Q?3+W9p+mmTWojyqwt61GsiO2RogzNTyHzgc+bz0q5C4NcCVjWpbVQ9ZF/q5VY?=
 =?us-ascii?Q?mNf6cVQ0VdwUZAhYNvRx49AJsgATWYSktYbutqNfivOpkfcGscqpMGmEwZ4m?=
 =?us-ascii?Q?85PTqMvYtJ7u4esKlyrHZbj6r14LO4jef/FBEMdMAIuueoEPMD6ZP37aiGM/?=
 =?us-ascii?Q?vsd69G/QtN5+014MGFNNLoqf5f65keUqhsiJYhARDKUVu3xtMfhOT1DQ93WC?=
 =?us-ascii?Q?54uR6fcU0r5Ytg25hUVGHhAbzOTvzDul6xxZW2xdBgoTsVMyPBkXidefxOm+?=
 =?us-ascii?Q?XQ/Pu/g4MsUvS63d4rvtaTS0tWUv6sbejXB/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:26.4069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8025c407-a246-4578-ea17-08ddd0d94c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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

KFD creates sysfs entries for a kfd_process in
function kfd_create_process when creating it.

This commit extracts the code creating sysfs
entries to a separate function because it
would be invoked in other code path like
creating secondary kfd contexts (kfd_process).

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 66 +++++++++++++++---------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8149ce0639c0..bf4a8972e3bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1040,6 +1040,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
+int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3f4ac9122203..d8535cd47850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -825,6 +825,44 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 	kfd_process_free_gpuvm(qpd->ib_mem, pdd, &qpd->ib_kaddr);
 }
 
+int kfd_create_process_sysfs(struct kfd_process *process)
+{
+	int ret;
+
+	if (process->kobj) {
+		pr_warn("kobject already exsists for the kfd_process\n");
+		return -EINVAL;
+	}
+
+	process->kobj = kfd_alloc_struct(process->kobj);
+	if (!process->kobj) {
+		pr_warn("Creating procfs kobject failed");
+		return -ENOMEM;
+	}
+	ret = kobject_init_and_add(process->kobj, &procfs_type,
+				   procfs.kobj, "%d",
+				   (int)process->lead_thread->pid);
+	if (ret) {
+		pr_warn("Creating procfs pid directory failed");
+		kobject_put(process->kobj);
+		return ret;
+	}
+
+	kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
+			      "pasid");
+
+	process->kobj_queues = kobject_create_and_add("queues",
+						process->kobj);
+	if (!process->kobj_queues)
+		pr_warn("Creating KFD proc/queues folder failed");
+
+	kfd_procfs_add_sysfs_stats(process);
+	kfd_procfs_add_sysfs_files(process);
+	kfd_procfs_add_sysfs_counters(process);
+
+	return 0;
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -874,31 +912,9 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (!procfs.kobj)
 			goto out;
 
-		process->kobj = kfd_alloc_struct(process->kobj);
-		if (!process->kobj) {
-			pr_warn("Creating procfs kobject failed");
-			goto out;
-		}
-		ret = kobject_init_and_add(process->kobj, &procfs_type,
-					   procfs.kobj, "%d",
-					   (int)process->lead_thread->pid);
-		if (ret) {
-			pr_warn("Creating procfs pid directory failed");
-			kobject_put(process->kobj);
-			goto out;
-		}
-
-		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
-				      "pasid");
-
-		process->kobj_queues = kobject_create_and_add("queues",
-							process->kobj);
-		if (!process->kobj_queues)
-			pr_warn("Creating KFD proc/queues folder failed");
-
-		kfd_procfs_add_sysfs_stats(process);
-		kfd_procfs_add_sysfs_files(process);
-		kfd_procfs_add_sysfs_counters(process);
+		ret = kfd_create_process_sysfs(process);
+		if (ret)
+			pr_warn("Failed to create sysfs entry for the kfd_process");
 
 		kfd_debugfs_add_process(process);
 
-- 
2.47.1

