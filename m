Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A4C87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D5E10E40B;
	Fri, 25 Jul 2025 02:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jb/NRj6n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FBC10E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMcGFy+DOLgOGvbKskGTkjVSJPMbAZx/hMZQO7WeSXoRknNJF8jTGCmHpj8DpQs7InztgRixNfa4a9eBW8HTmjocusGL39U7DEollmGDA4QvrHJQ8kGvS42+i7AWajdYxrk1xm347jvs6leQzYUdnBuoLZqS01nsJ7uwIBuQyHxj0B58AvOe35MVUOgo/DjIia2x/gIWC2/8CLwC8mS+TFc2WQLo8UGxvHRGqfCzhCHELKa1BRIHFptvEw8zjGauNP4fBQjvrPX65nrUf4N42DcyDHOvfefLL+aTjNeX+ldru+AZqzCDx6L8LjIqrZnC6p0EoiS1i3yIS7uMBnqvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TliW49rI7dGyBDRxveGGF0ZkqmioG/PJKcVAcmrLDNg=;
 b=qJYYn4aJpzsn91D0lBYSbrkhBkcbR97WOQ01hUyfxDMwtAzmFwymhvgujHvORbRBn5AsSzgJKOsjan5dIqzdShRlVNXXaZctThURzqBvQXM9mUsbbFa9uCBSWS7ixU/5neLjI+iWf64HuTw/4INHDTYvkVfnPVOhoMZhED4tQYvoyxenmqZhvY0ySv6EGpdjJTx/FAwjRsqtrHyOEXN7uUwWYPOmfRna7C6g/Uj750bBDFc9i5JBghqABbboMac7TW4NG1VXbSeMbrY0Ek9yhXI+Ax7aSEz7gqFCp6oDvRa3C7K6cX8xUSRPH0u1vJRAN5ouTgKrfTR9IK8k9gsNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TliW49rI7dGyBDRxveGGF0ZkqmioG/PJKcVAcmrLDNg=;
 b=Jb/NRj6ntGzFhMld+74qVQ0XLJ2Yk8ZV89jdpwZHGHclrmNXcytZycMgB5uF8DBrfJlBDVDsie5rAfeF1QbqIBBCduHO6Y/i25VE01/i0bP9LWI4PvFCQRKeRUofu/QUSgHFotIdu4oI/aiiqpu/PR8VT0JNxP/M7FZ6JpsAArE=
Received: from CH0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:610:11a::10)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 02:43:38 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::df) by CH0PR03CA0338.outlook.office365.com
 (2603:10b6:610:11a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 02:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:38 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:36 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 4/9] amdkfd: Introduce kfd_create_process_sysfs as a separate
 function
Date: Fri, 25 Jul 2025 10:43:11 +0800
Message-ID: <20250725024316.9273-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a53e5a-c0e3-453b-1059-08ddcb250ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h/8djDanmbxyd2SkMjjYIbH/4BRB3n4U75Pemdt5mNBZOh4sv+weUGGd6hF0?=
 =?us-ascii?Q?9rJOoM9mGqgghx/+SjBqRv6jZ0L+uohD9+iDMjIvFaW+Z3+bOjyxsOPUGu8h?=
 =?us-ascii?Q?CCLhnQyny2xH1B832CVo5+Eg8CgX7U0e30lca5mSSm/7e6zHDoNII9MIeU+S?=
 =?us-ascii?Q?ttcUDAC3dL3/EV+UYp55jI3oTfgwo54PdIvuU72376qYi1vVt1ppRE+rxGQL?=
 =?us-ascii?Q?OfaEVnddyi4IxduSDW9OZlM/RjCzdZtTB4mOGzehTJysduYxnvIJUI9T6h6Z?=
 =?us-ascii?Q?3VJKqlEMBrI6XeVsKpvo0rfTJcBgk8cQYw5A+rhmpKlBUCibA6YG0ll3MyNX?=
 =?us-ascii?Q?MmGsr59mmXzjblc85/Gd/SAoo9Jp0uanIs3wHPzWmWNTMrY30DJu93z1mgg+?=
 =?us-ascii?Q?W3Pgo/7WsWVJwIsCMVAUkGaT+MwZu8utYBhXhqgYXN+JzncxTMuOHmEdpp02?=
 =?us-ascii?Q?OsISfq7XukQFvJv3xfEdWHs2O1Wl2kxDp6skrAAnoGsXDQP0Y0QL5YPQ++ok?=
 =?us-ascii?Q?wUGuWz5Oqm31Ws/+VkvSStU6DZnyMk8fgJJaWA8MlvuufeqAL04FNmN0PkPT?=
 =?us-ascii?Q?U6TYMBHZQynpdA9ZuF0Q2w209rUgmzucWjYmcjHLv8kfZ9jQcAM2U6k7hxHs?=
 =?us-ascii?Q?yrwcKRsmCLLgkJU/psURtYnqr7kUtJN2m2IeMgA2MEd7WyY07tFHIe3fRv8J?=
 =?us-ascii?Q?h2YDSyrz+RY15Xxg1W1iXJ1mPccRW5Yh/SBAE1yz0tCgVDjMRT0lUXbO4Bau?=
 =?us-ascii?Q?jOIgrQKki5FqLW6+6Y5rZCS4BezWadfUu6E8TtSWv2U+rlAjItIREJiKdrBe?=
 =?us-ascii?Q?bQG5J13JavT0Q0ejzij+dJby6uX02YgzCLh7TwCxNeVfAVAGZV4kTn84yM7O?=
 =?us-ascii?Q?CQACWD61Ie0Nd8qJiEHQIPtb/qYl4W+Ms/vYBuMpD9Mtj1yDwnjyuy8c2HHu?=
 =?us-ascii?Q?7oDuo0J2OqaFREuySl1WvYhmBrOaq2lT+Lv3gNb6aJ/b4kjSQOHspff7hXZh?=
 =?us-ascii?Q?A2/VPBStfT86/1/JspUvK3mzQGhQ++YdmlR2ytPPSBxWr1X8ge6EFwUIJfES?=
 =?us-ascii?Q?0qhCysLezt22F1kHM/7p6QbMWxhyt/JanUBNbXzgx2PeiltkNjtVJ0p4oGhM?=
 =?us-ascii?Q?alUyGX/iVB9XnJcA9x5NPz2cSeOQn3Au96Auy9jjwtjZ1xGFWKOrQNogb5gQ?=
 =?us-ascii?Q?/7u+VkNMzr8iTR69IokXGj51+ABWgs494vJSbPQaCOJokI3igsCc1Zt3MHxp?=
 =?us-ascii?Q?FXjiJjG4Vvza5Mm/WRx/go3lfdB6tWiWCHzvfQf2hwugUvlvYKKqojJp0bss?=
 =?us-ascii?Q?Bm5dQIO70bvsrIK83mA7r5HffeWONgEE50YLAa/aLDhGAeVMJmHCTNS6npFK?=
 =?us-ascii?Q?ZK1xUkMDK5K0QdTHsjnoUMTLbahsjDQ9pmnM7OtmerMtGfO6Zc2UYLUR5uuA?=
 =?us-ascii?Q?+CdhzFWubO3tLjyT36C5DoXaT9GtFRbqaQtGxQmyXHJ1FB3248lqy10y9WgS?=
 =?us-ascii?Q?/w+qYxFXpaiYmD3dsDkdCOmnTZfmaS8NArIv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:38.0316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a53e5a-c0e3-453b-1059-08ddcb250ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

