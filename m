Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F328C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 04:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7D410E2E1;
	Wed,  1 Jul 2026 04:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMHffZWQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF03B10E2E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 04:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJsOE95CQrKzSHr7ZEW63P/e6xyi+x0x9ja0l8Wh2Z2CdN6eJhyqHkb6dwt+j7jDdcFxxfaoqq8mfEWG+sdKnVk7th14R9tezsUPjqu05cVspbppylBCDSC48tQA8O6t1+kDMgOGH9/bYokTHUd47aMwHnKR4qyiy1F7o6Yzky1MWGeW07TsTlnd92C5rmfXdgd8lNU+9VIGAa8rExGjYKCW4+nF41rt2APTRMVvWMaOD1VmC6PHF+fZ0NkyXgoaHXOZrBwfRrlj7WSZnE9qp6kCWlg+obgvUlzax67Zoyd5BGG52YG33hFO1bSbbQbwCYnmVobJ7Wg0KBTJNqwREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73+OTDS5RrtUjoWxah7WFbVvKgzCldzHi9NcMvP3o2w=;
 b=MY4DULkIlkjFpZppY3ckEKmY9G8GNectlgDnLCD/L6OInFwRL91J9N/irMWnSR2GVGNHRcUCnoryUeppmiIXmxMnrnRYy8XC/8ncvFDCdOjIgDAr8ggvTekUwqV5C+98QizdVx+lJTXa7IllHLKQKx6/yRzOHPDGglRjARKwLoKFCfVgvVO1AaIoNqOMDV45dwm86ON0s53LuG7AcVFa29iG6UrvPMVHZdxY22X8iFdIfp9tusY9UagcrmZeH7YnENYYYIMMoE1B7hxMbSdDP/L40Wi1C/uIdUWuoCTm9ImTAoHAyLl6twbdsHgZehicJLnwO1VAHNRCfh+2GbOOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73+OTDS5RrtUjoWxah7WFbVvKgzCldzHi9NcMvP3o2w=;
 b=iMHffZWQ/aQQyX14VydaZS7/1BOrSAF9akzHL8GfqYuZRhtrbKG6legS7W479TzWMIhG7g4boHOWtOcXvyd7UkiqYbgBVfhbgfst07vyI6UL+huIRdXFL9tMB1XYCSTt6GHxCLmeJlSBcNmKV4HM3uA6ldbpXZjVz9QtIeUJg1A=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:07:07 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::ac) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 04:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 04:07:06 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 23:07:04 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: expose pasid of secondary contexts by debugfs
Date: Wed, 1 Jul 2026 12:06:48 +0800
Message-ID: <20260701040649.8836-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1acde0-f6de-40e9-0638-08ded7263731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: mCQQ6s/dhbCgNd+i2bvaSC9rA+zyu0zzZmJRdVcgBefq7V+yjBUkgkiYuhx97h+3CQp28iuulw0YaBvs1SXaEZNp3sZjFtBN4MT+nH1nmp1DC8q2gpKH/ot69ZavEEjV/cg1KDiIIQRelepdQ/zwwTM7XlwLssv0G61dm5FMTc6vHSbzHvIYIrZ5GWgvKm6Dx5tCh+FblMytULsK0Nw/XHJhLn8HHIVaBXE0l4onOP7MRbegFO+MjkUY4mQoONmyoJQuFY0Z3bmmPzErhAVPiwl3nmkalQy1HZKg8pReqjTw51ikQBsZpt3aC4MqRqStlfYUPZaiTW2+xjNhn6tWQNVYizBSmU/mz3KO+7EgZ2fs7Gny9GIWeHSDTZUeftbm4ps0dQLhyHn910gagM48QBNZj0dXtNctHCGyTuCPsGyP7rj5zCmjL5+r8li4TAa5vlae7t1sfaZStP1ECwTgrnHgnu15HoTRyAkzEpwy1djkHWUOVlk6KsBYMsodMLRkJmEY47b2bWgKL7FhzvP3WYN4ibBORG1aghKSKGb2LKk8nUnXDvqvbimsEs0a+3y4pqXH/UpuKht5JZIqlBAiJPql8QUKY88cZc9LnHD+dNnyik5L9OuLfptVn1LOIDXS3IvDFt+hQ6VjSk5T0ocnJhofQ7VjyetnjReaHPwcqgkZGYnMqcGn4pMvTyirygpqHw+z22bt2TKQyq5qkUv9tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8x0m2xkoZO6KyMrLOsAIpJIENgyD21cpkCyJG7t2mDZZWfNIpTlQagBtLIeWoTqTvJ2PXU1yFl0Z/qiNC4OMZFv7sxQLeCZYWyOdCFfH+5kUEvCI5swYCJHJpKAlY05+NE6zNKSzC88dQIeMuS2HYNh8LMiuaATmoMbhSh9b5Fgrtj6odZUaABUdcpbAylr3ny3oL5ae5YKHH4YF46fDP/QmfGQRop40PexHsBJ1Eq/WVOfsns0Z4C0RyrU9W2Oo/7KRnxpQ1nCMdYHlJreoIgF4/pW0dNRHeZU9if+0eir8OLSUFTaqxEkh8r7K0BkRwE9CXGyanaEWnr24vO9hAsUpMhH5B4SnXjaT5L+emdy1v9W0z6PvNT4+yP5GlmvC4+RWMYR1SvKbfSg2lFHapr/MibaJpKMCl0cZNOCF3u/qe5Q09udR5p8Zc3TrkF1d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:07:06.7132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1acde0-f6de-40e9-0638-08ded7263731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Current kfd debugfs interfaces only expose pasid
of the primary process, this commit exposes
pasid of secondary contexts by debugfs

Just like entries under sysfs,
the secondary contexts are named as
context_<id> under its primary kfd process.

The layout:
/sys/kernel/debug/kfd/proc# tree
.
└── 5802
    ├── context_0
    │   ├── pasid_1025
    │   └── pasid_63266
    ├── context_1
    │   ├── pasid_1025
    │   └── pasid_63266
    ├── pasid_1025
    └── pasid_63266

Another fix is, kfd_debugfs_add_process may fail,
this commit change it to return a meaningful
value other than void

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 113 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |   5 +-
 4 files changed, 104 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ab9e53dc8deb..2635218188cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3303,6 +3303,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	}
 
 	filep->private_data = process;
+	ret = kfd_debugfs_add_process(process);
+	if (ret)
+		pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
+			ret);
+
 	mutex_unlock(&kfd_processes_mutex);
 
 	ret = kfd_create_process_sysfs(process);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 9bde2c64540f..02673f01b448 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -33,6 +33,7 @@ static struct list_head procs;
 struct debugfs_proc_entry {
 	struct list_head list;
 	struct dentry *proc_dentry;
+	struct kfd_process *process;
 	pid_t pid;
 };
 
@@ -140,34 +141,97 @@ static const struct file_operations kfd_debugfs_pasid_fops = {
 	.read = kfd_debugfs_pasid_read,
 };
 
-void kfd_debugfs_add_process(struct kfd_process *p)
+/* This helper locates the debugfs entry of a kfd process */
+static struct debugfs_proc_entry *kfd_debugfs_find_process_entry(struct kfd_process *p)
 {
+	struct debugfs_proc_entry *entry;
+
+	list_for_each_entry(entry, &procs, list) {
+		if (entry->process == p)
+			return entry;
+	}
+
+	return NULL;
+}
+
+/* This helper creates pasid file of a kfd process under debugfs */
+static void kfd_debugfs_create_pasid_files(struct kfd_process *p,
+					   struct dentry *dir)
+{
+	char name[MAX_DEBUGFS_FILENAME_LEN];
+	struct kfd_process_device *pdd;
 	int i;
+
+	/* create pasid file for each GPU */
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u", pdd->dev->id);
+		debugfs_create_file((const char *)name, S_IFREG | 0444,
+				    dir, pdd, &kfd_debugfs_pasid_fops);
+	}
+}
+
+int kfd_debugfs_add_process(struct kfd_process *p)
+{
+	struct debugfs_proc_entry *primary_entry;
 	char name[MAX_DEBUGFS_FILENAME_LEN];
+	struct kfd_process *primary_process;
 	struct debugfs_proc_entry *entry;
+	int ret;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return;
+		return -ENOMEM;
 
-	list_add(&entry->list, &procs);
+	entry->process = p;
 	entry->pid = p->lead_thread->pid;
-	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
-		 (int)entry->pid);
-	entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
 
-	/* Create debugfs files for each GPU:
-	 * - proc/<pid>/pasid_<gpuid>
-	 */
-	for (i = 0; i < p->n_pdds; i++) {
-		struct kfd_process_device *pdd = p->pdds[i];
+	if (p->context_id == KFD_CONTEXT_ID_PRIMARY) {
+		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
+			 (int)entry->pid);
+		entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
+	} else {
+		primary_process = kfd_lookup_process_by_mm(p->lead_thread->mm);
+		if (!primary_process) {
+			ret = -ESRCH;
+			goto err_free_entry;
+		}
 
-		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u",
-			 pdd->dev->id);
-		debugfs_create_file((const char *)name, S_IFREG | 0444,
-				    entry->proc_dentry, pdd,
-				    &kfd_debugfs_pasid_fops);
+		primary_entry = kfd_debugfs_find_process_entry(primary_process);
+		kfd_unref_process(primary_process);
+		if (!primary_entry) {
+			pr_warn("Failed to find the primary debugfs entry for pid %d\n",
+				entry->pid);
+			ret = -ENOENT;
+			goto err_free_entry;
+		}
+
+		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "context_%u",
+			 p->context_id);
+		entry->proc_dentry = debugfs_create_dir(name,
+							primary_entry->proc_dentry);
 	}
+	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
+		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
+		goto err_free_entry;
+	}
+
+	list_add(&entry->list, &procs);
+	kfd_debugfs_create_pasid_files(p, entry->proc_dentry);
+
+	return 0;
+
+err_free_entry:
+	kfree(entry);
+	return ret;
+}
+
+/* This helper removes a debugfs entry and its sub-entries */
+static void kfd_debugfs_remove_entry(struct debugfs_proc_entry *entry)
+{
+	debugfs_remove(entry->proc_dentry);
+	list_del(&entry->list);
+	kfree(entry);
 }
 
 void kfd_debugfs_remove_process(struct kfd_process *p)
@@ -175,13 +239,22 @@ void kfd_debugfs_remove_process(struct kfd_process *p)
 	struct debugfs_proc_entry *entry, *next;
 
 	mutex_lock(&kfd_processes_mutex);
+	if (p->context_id == KFD_CONTEXT_ID_PRIMARY) {
+		/* remove entries of secondary contexts */
+		list_for_each_entry_safe(entry, next, &procs, list) {
+			if (entry->pid != p->lead_thread->pid || entry->process == p)
+				continue;
+
+			kfd_debugfs_remove_entry(entry);
+		}
+	}
+
 	list_for_each_entry_safe(entry, next, &procs, list) {
-		if (entry->pid != p->lead_thread->pid)
+		if (entry->process != p)
 			continue;
 
-		debugfs_remove_recursive(entry->proc_dentry);
-		list_del(&entry->list);
-		kfree(entry);
+		kfd_debugfs_remove_entry(entry);
 	}
+
 	mutex_unlock(&kfd_processes_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ad4897f094a2..365c6289b05d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1649,14 +1649,14 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev);
 int pm_debugfs_hang_hws(struct packet_manager *pm);
 int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
 
-void kfd_debugfs_add_process(struct kfd_process *p);
+int kfd_debugfs_add_process(struct kfd_process *p);
 void kfd_debugfs_remove_process(struct kfd_process *p);
 
 #else
 
 static inline void kfd_debugfs_init(void) {}
 static inline void kfd_debugfs_fini(void) {}
-static inline void kfd_debugfs_add_process(struct kfd_process *p) {}
+static inline int kfd_debugfs_add_process(struct kfd_process *p) { return 0; }
 static inline void kfd_debugfs_remove_process(struct kfd_process *p) {}
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8e701dcda8ec..a87878aee0f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1002,7 +1002,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (ret)
 			pr_warn("Failed to create sysfs entry for the kfd_process");
 
-		kfd_debugfs_add_process(process);
+		ret = kfd_debugfs_add_process(process);
+		if (ret)
+			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
+				ret);
 
 		init_waitqueue_head(&process->wait_irq_drain);
 	}
-- 
2.53.0

