Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144BCCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94EE10E337;
	Thu,  6 Nov 2025 06:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lJPFBmBK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA02710E339
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgYnTMW+AHawZtEMGnOTjCySq83YeQR3TAXNcNcrXKEJZI2YgiMES86uYlKl3iBF+HYiRbp0r/837kY/F2Qee3v3/QiIMjWPtWMTW9EBQdrXJo7ygNFNobLRHJzZoVsHWQ73dW/dzMTORpo4zHPsOl+G2cT6kTGok+Nl+Z2rYyJMBfsM4TLca+QFFEQN0Nn1CSWbbm8kOI694H3EswogBORQoimYGuVemOhxA/nrxDK7d32p1BZqP7YqUpAIEaYFYmxZSIzMDbpl4lYHpkKH5ip1kQlzJm+MuowbBaNHM7sQ9U3NceveTimJvXrt3GzCN1XwWgw9F0I8vPnyzUxZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=nIOjRvjaWKmwgXzVKsWKD6AzEYSbNFrgjJkKeNf+tLafjyihenRSFc+OQHXgsP8G8lc0a67ttq4te2441DzvOIMCl90tIkcS9BVWIbWQGnSiQhktDkalYKnr45CewS+jNj5Z9UN6ojlhOsruHu7kuFv4em2Aorkl3MdibU2M6awX+r/D9kSOl3vf853sXCywJUKay8ctUrcFGqz+ZS6HyZPROGxS22Pu/h6gXIn96T2zb08pnhgBh5ooDUV5ovrKfG30unw0M0YSF4FrLNjTZnF0uXdtaJkPY4VJUCsN7aYt5Iux1ghMRvW6XpTeVgphavTnmgf48wIDyKbD4+VAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=lJPFBmBKAOBOJss64D4VwXp+ajRnNFO+2JZ+OVGQBIt3cklJ/+/XMtUsAlPfKaAvo0KVH7cSmhLr5gdlgixIS38sMo1OKKDBwz6HCTjaLtNwGoqGFT4VY/tHGzAWNm5vBG7R+55bl5dNVaIMljI20xza1RShRZgC7Nf1C4RD4SQ=
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:12 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::dd) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:11 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:09 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 04/18] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Thu, 6 Nov 2025 14:07:25 +0800
Message-ID: <20251106060739.2281-5-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd896ab-efc5-41dc-75d2-08de1cfaddb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLr90Xvi1rA4EOkeT+YOXT3p4U9mgxyPVwU94q6AhhRe4HWa6hRd3snpskdp?=
 =?us-ascii?Q?dLYYwfq2+JfeaGfKVWF8J/nSnzGyh7WwEI80oTPLse9+lYXv13OYGbmunT9W?=
 =?us-ascii?Q?DF/exOUlpbQyZcHy3Ddf/bIjtbeDc9KWDv8w9F517Mc9dhU/X1bODNSxd7OQ?=
 =?us-ascii?Q?MKyQ9nhsey9NYdzJSLRSguwRU/QCOqrtwt5eIEKcM+pHNfAlS/yv12Rff7Mj?=
 =?us-ascii?Q?RYrpg0RjdW9CWEzmv+o5908OIXOXYwpZ5uL3+/NyPN0IKBIzj64mF8RHKqxp?=
 =?us-ascii?Q?aAlGhQJsMxPjAY8vHdVoUdL40ztL9vgYMbWylVHtx+UzxGZclt3F5Ep0zxFZ?=
 =?us-ascii?Q?qsTevldI6Ca7V02+pG63dhSd7ZF03dGlXlvpLsDRS8SAblRKzqxr25ZDYn/M?=
 =?us-ascii?Q?8UPvwo+QjZzwmCxv5VuGSf7o/yj0oA/Ez9z32q8z8Dl4o0QE/5Dx2Fc3zbad?=
 =?us-ascii?Q?yG7yX1yXLyLJbK7wt98UGWfqaY7VN4S089YjS0IA3HERBxnEykGGV61lWLAC?=
 =?us-ascii?Q?1B4+Hy8o3qfbc6h3EOye2BF47VlKDOAKmBrGad7g+0FB1vldUa/82W4bHSP9?=
 =?us-ascii?Q?vo7Zloif2dxjGfz6TwUInj9ctpXGDzISwwQZ8obVdFiA/rx+RhlwbGpRAwQw?=
 =?us-ascii?Q?2IUzqpX5q0RQIktYJUfg/ZGlTmVYlGmQ+3u5vfsGJtRO0yMr9AsYBVCygBJG?=
 =?us-ascii?Q?VmCyOEgMtid6JXPZcCwiOWLsgfwDOeZzftiV1mfaR3M0DFJo5fmfdJirmE1m?=
 =?us-ascii?Q?Psd/8VfVc0ZuclCIiJq2/ttcoYmr4w2JoW5EKCCh50t1oSh9Jjl7DfugkTex?=
 =?us-ascii?Q?ngCPrwiTX+mYjHVBD56/KAgLg9dabUyuQdHLHu7FSbrvFuNjJfEcKZN8CnGG?=
 =?us-ascii?Q?Gd4iMelJbeaID6GckA6yJOl0Jovh5tmA0emrKWO6mws0vGpCtpyqJOYG9Z75?=
 =?us-ascii?Q?h8VtNq/IK5bTqf8/nf3hj0ERSELbEV9+qmXKdWx0b1zY1ly20aFn7VfAZ/DW?=
 =?us-ascii?Q?DbKCgKvUNqqDCYXuezbOyFA7yISNnYuxaXJi8DplGOZSMTvQbzbagfmDmVgv?=
 =?us-ascii?Q?WwDxogTDYXQbFVRbepNNTgipOcpwaBS0HLVzVkJEtaeR0F5Jf8l8ZiowU1fS?=
 =?us-ascii?Q?RByxL4P0gkqf9YXlgqRpPnu4ngCOOUGhaug3XJVPTwUkKx6dZBqWApgIKlsa?=
 =?us-ascii?Q?zkyO+k8ciIDM29Jak2tDSAs+EJ23Yat0k17FixdZVaNmV983m9iQQeWi8+IC?=
 =?us-ascii?Q?v14MEK29s06xcBXeAgcAcgXzqMwDfY+bBuIzlOFSQ6+DfNyHfjDGjd58zm14?=
 =?us-ascii?Q?XOyjaYIyrD+QCcW/hzWgaSLJ3VJdN/AvzOR0v93iF0S4H/qJwRK/XYg076GY?=
 =?us-ascii?Q?d5CNe/71f81SfHd+ja7fS/DEzzJox+kPJNDJPUaq/owyLgzDR53qW09IGmPn?=
 =?us-ascii?Q?HsAeu8Jp+z8p7emQr6aBVYtOzdvpmcBZdEA1/KkY79OT/w4o+cloctTo2qec?=
 =?us-ascii?Q?EPLHsL7ncWVhPtCTWP3zeSkrR0A6FIVtxtH+2pQRXBhdENdJnEVk07KDPMwf?=
 =?us-ascii?Q?YHdVm/ClFuBQomSBEys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:11.8689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd896ab-efc5-41dc-75d2-08de1cfaddb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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
index 729330f8a384..cfedc0c5892c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1054,6 +1054,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
+int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 051000e79e95..83fe571b801c 100644
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
2.51.0

