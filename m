Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E85CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06DD10E57D;
	Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZAMy9v1B";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2340E10E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVVE15N6TVDgdIqy0TaZt2RJmhDs7bJv8E34a7W7rJ+Bcatx8oDp7ijAmyQzsynDXwVQjh9tuU+Fw2CdqAwpwHys+RmUPvrQDavhVLQlF5H4QK7D8J56UQHgP2YZ5iDVHLgXui1dGHUYrEgUBXvY0D8wB8idI9uZVjKuajHEWtOO6QzIVFv0CYCWIyrqy1qXl0X8wLSPsOkxFOQ9gnlj/BN5hM/Xy7Sed5If0+NXYdBw4kQxY1CpUU8wwDpl01JTg44CGrL3cwfRL9O7NlILrFnCX0m51/V3gsL5vH1t1jUvAjzO0lRm+PL4Acoagp4JceDrO5DnUhlb/MPPJTdCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWsPC0K5CsAwZeBQKSSeEnTu2z8nfn6W4VFaIJCAibo=;
 b=MfSnwxyZ4G52QTNFv6UgEY2KzPd3Tgrjajopyt6W5gVwXB4ng9U52iSuI0+EhLfPtLCS9mWQOffnLPCvi5qnt5WmeiwSztCclstRhE9cEPQDy9pj6S7V7d4It4rf+MUhqc2yUaJdxoJVI912YEporJ62qS5+VFRWchvB6OrxFGoLgeMNoRpRYMto/6W2qHf6r4RdGLWSSb5c6KjkYkUEmC2QGMdSG2LwheVNYxglxmaVMsAVkc0iKnecDw1ea/+2r8bBgxOoPvwCeYzbuw0tn/k6gcrReskTtjcBMPsUNKbx62nbkNh3P2OqKnFfD5Z8oR45TbKdrchB17rCbZ9cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWsPC0K5CsAwZeBQKSSeEnTu2z8nfn6W4VFaIJCAibo=;
 b=ZAMy9v1BOzV8EGcq3+HUbMbaKUiU84Br8wfvEvhlHTZv5N3tpOswPpIpJ7Ld3oNI9ZtFN8cMJ1a3mPsHY0BQ1wIUNe8DXFEa+X48VHh+kHV5yLg1mIEDxAMculR1wI4i5K4pHoxXlQkpnVD9Wyv4xQ+NeTMH6Hif5xM51FFwGo0=
Received: from SJ0PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:33f::33)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:50 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b4) by SJ0PR05CA0058.outlook.office365.com
 (2603:10b6:a03:33f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 07:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:50 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:43 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 08/18] amdkfd: identify a secondary kfd process by its id
Date: Tue, 23 Sep 2025 15:25:58 +0800
Message-ID: <20250923072608.252345-9-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 01618eff-92a3-4f16-913a-08ddfa729023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2qYSVXP3i/bZCqcaeFL+R7/V2EKInuXQVHomu/rdBO/JnPVeGs+ri1vtqmw?=
 =?us-ascii?Q?rFBNDBiCSORbGB2d4KvH/uXJa3LGP9K6F4LAfwaCIgEfVy17C0J+7IpjR+JL?=
 =?us-ascii?Q?d8hlITI8iT5wTaCghff+h6p8IV+z4EYRoS55kUWVClscCkYTIJQIKuMtbjOv?=
 =?us-ascii?Q?vqCeLzc9EJZuU4qAysdT+t2iXl/YBPWesQMe91ScuCt2yNliIhUHf8GLily5?=
 =?us-ascii?Q?XozjBgSvvM3saisGlF8hT6Ouj87eD4fj7xGM7seuz5jLi4mR5k1JBwgNozbb?=
 =?us-ascii?Q?FGHvHOJgsAbloWE8krxTAWSXwH9mn9ODEKAMALDnTO2lOz4hU6L46qaWCfKH?=
 =?us-ascii?Q?n0/nU07zdNFnl/6rtwqt3FAZjLfGmnbYYJebUuyeF8cjv+A6UNHdGjeVe3lS?=
 =?us-ascii?Q?7m8qrovvik38qu2kmJMBVBPcT2Pv+bz2jjqic7I/MJM4Ig5MhexQdXqLbfcE?=
 =?us-ascii?Q?vhzH+nueYTzQHAT2g4W2TYFQEY9SFXcsPvFSouXjVyyPPLP7I2PaE2wro8L/?=
 =?us-ascii?Q?KjNzZ6k1Q65u5x+IHeI9K+QAcB4e3g2mSgJw4kqVkEgh0SJPeIjqE1a3akBh?=
 =?us-ascii?Q?xUEO599AWsoN5HUZ7jIBak4W38hD7T8/IaNC2X7wsw576KZXC6J840YyEtln?=
 =?us-ascii?Q?SUyryeQQ1MrowRRWcdX0NHEc3nWvzhL6xsJRNkrW0VyBiRjG78cYf0rcq56k?=
 =?us-ascii?Q?974KxNNBodkDh391ynsoFupB/Ro55X3uh6WQVFEcuS4MJP5O0RvtvuzhbHIb?=
 =?us-ascii?Q?0oCxf0LKujvLpB3THpjsleXgPOLb0qNq091L4da818NYeU0zY0YeTuOFLTZh?=
 =?us-ascii?Q?rjrWnAp6v0ooVBVA2Ff5DaHzc4nI412yvnmzXChKhNCzO00Kx4vIkPnroksx?=
 =?us-ascii?Q?DDgqjGfskznSwaa2XWPIWCgqlNqXMpJgDc9DWWU5WI8pn4PItEZgfiYOKbFG?=
 =?us-ascii?Q?SEymamB8DVz0wWR2a4Gq9Q7BwCgKhtezPMLDKMr+AvZ9RRk1Vc/QdVhC3/qP?=
 =?us-ascii?Q?4dzo4mcCZ0rxQHP7rRDfWPNn6kwoQcVmrdu3H6e6cnbxOHLwMH6kmZ5+7sFj?=
 =?us-ascii?Q?bRqrvQMULYXdVk1+tTEn4vIy7kKSZFDWTg+iAjmSjP7uiyWbdMB9sbQAzEzP?=
 =?us-ascii?Q?nqRMdxc5xfqO8SkTmA4C5z1aRH6BuI2aqeqY49IbT6FdHsP1tfET87Fx3Fk4?=
 =?us-ascii?Q?pJkgtO78e6GDlFKyD6mlKlv/esFrnPT2fLD7uf2/E085gZ7TpXgjgXoAZC63?=
 =?us-ascii?Q?xLHzq/p2cW9OF9tizphTJflCb5TpOBnW59t/jLEtWGW9BLtOp8y7UeAhN37y?=
 =?us-ascii?Q?oS4fBAvRAMSDwWEe211fO6Tv5HLEuS9uGs8flmvjRNwfC1o1y2s0NjGju6J+?=
 =?us-ascii?Q?pQz6N1H9spOGiMqHDLIvVJz6nKG+N2NRpGDyrzK0ptL7oG7hpHrUz7aX03RS?=
 =?us-ascii?Q?JGgpTtZtVRuizwe8OsYx5aZ/w/We2uEVxE8Tg1l8MBq575P6M+5mzO56Tso9?=
 =?us-ascii?Q?h1MxB6huspUZ6Y9HHIfJYUXsp9ZMYrFIT+tJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:50.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01618eff-92a3-4f16-913a-08ddfa729023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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

This commit introduces a new id field for
struct kfd process, which helps identify
a kfd process among multiple contexts that
all belong to a single user space program.

The sysfs entry of a secondary kfd process
is placed under the sysfs entry folder of
its primary kfd process.

The naming format of the sysfs entry of a secondary
kfd process is "context_%u" where %u is the process id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d1436f1f527d..d140463e221b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -998,6 +998,9 @@ struct kfd_process {
 	/* Tracks debug per-vmid request for debug flags */
 	u32 dbg_flags;
 
+	/* kfd process id */
+	u16 id;
+
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
 	bool queues_paused;
@@ -1012,6 +1015,9 @@ struct kfd_process {
 
 	/* indicating whether this is a primary kfd_process */
 	bool primary;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5d59a4d994d5..8e498fd35b8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+#define KFD_PROCESS_ID_MIN 1
+#define KFD_PROCESS_ID_WIDTH 16
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process->kobj) {
@@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn("Creating procfs kobject failed");
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process->kobj, &procfs_type,
-				   procfs.kobj, "%d",
-				   (int)process->lead_thread->pid);
+
+	if (process->primary)
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   procfs.kobj, "%d",
+					   (int)process->lead_thread->pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+		if (!primary_process)
+			return -ESRCH;
+
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   primary_process->kobj, "context_%u",
+					   process->id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
@@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	int ret;
+	struct kfd_process *primary_process;
+
+	if (process->primary) {
+		process->id = 0;
+
+		return 0;
+	}
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return -ESRCH;
+
+	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
+	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	process->id = ret;
+	ret = 0;
+
+out:
+	kfd_unref_process(primary_process);
+
+	return ret;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process->primary)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&primary_process->id_table, process->id);
+
+	kfd_unref_process(primary_process);
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (!p->primary)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&p->id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 	process->queues_paused = false;
 	process->primary = primary;
 
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err("Creating kfd process: failed to alloc an id\n");
+		goto err_alloc_id;
+	}
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
+
+		ida_init(&process->id_table);
 	}
 
 	kfd_unref_process(process);
@@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 err_process_pqm_init:
 	kfd_event_free_process(process);
 err_event_init:
+	kfd_process_free_id(process);
+err_alloc_id:
 	mutex_destroy(&process->mutex);
 	kfree(process);
 err_alloc_process:
-- 
2.51.0

