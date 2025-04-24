Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BA0C369D5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 20:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12B610E04D;
	Thu, 24 Apr 2025 20:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="prT2Yna1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8586A10E04D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 20:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+dUzXASMzwbzfR6PBcV/LnOOlFHMlHusPM04stjNxSZ2vFPab4ZL2gT28WElOJZKSxRJxrV7y0QzsrmQZdsUDhnG0KhA7uHuAycRxHBs4YgA8h4gs2+SNWe7XiI076y+jckBzBUpZ1YIleErsAZ9aWGubtBiP2imypD2aUgavM4Ea1Ysb7f7S2caOX1Hw3Fd3IOJXsSqYqsg103GrG3I7rRaLSpVhzGniwIb0F8HCqW4p1Xj/E0bl6CXHXQWUubZO8su4hiS22X9n1xEkQkTloT5khR2OzXI+dPB6XSyq9NcZYV7cIK0iao7Ds2dBznkb6UWswskVD0YtCn2jxYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHraCrEFSntatQ/OlbP1BdF5uStJO3XtbhrRcfI9alc=;
 b=LGv4W24xtO/OyaHwHwrBTLvcUAvFI/cdC3z6V+draZ+sibyccsLsjlChY/mjEmk9dX9ZNKgPwVneJXBtnOopttUfR+8G1oMYvEZJlVmLIduD7c48qZN68AG7AgcIm+1TXjBiOZNtD59zPnDAwqOZZnJ4OJj2UDDlaSO05W9M7xu7MYMlD6+7xh1IhR8TyP12byLZXAFMG5+EeSiwK0HYPoGj5quRfqbnum3TCxfH/0rMba2tBITZDBl2DggTff9/tFfYBC9hI0ysXU7Gvwrs3O1Gv5Ar0are9RJttYzIaboLbwq7otOSDTFUh2TJPRB8hHppdsYKIClALjMUKj2Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHraCrEFSntatQ/OlbP1BdF5uStJO3XtbhrRcfI9alc=;
 b=prT2Yna1nsNsqdIrrjXWusJG7/h7BYOFbGvCM+HIyD6p8PK52D80AEFwUcavuIa4sy5zqDYn83uF5OPfPO1VaMS6x+zJJBGcszLeeG0BLoVLAegmXKEI5ao5EKg5iLYhOTYObc0MdjngY1upBXtPwf4v8s9Z3tXOs5VQaLnyTc8=
Received: from MW3PR06CA0020.namprd06.prod.outlook.com (2603:10b6:303:2a::25)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 20:05:43 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::92) by MW3PR06CA0020.outlook.office365.com
 (2603:10b6:303:2a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 20:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Thu, 24 Apr 2025 20:05:41 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Apr 2025 15:05:39 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add pasid debugfs entries
Date: Thu, 24 Apr 2025 16:04:32 -0400
Message-ID: <20250424200432.214419-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b82e3f-d95d-43d7-b115-08dd836b6418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iMYDz4Sk58ReBAOTPnv7BBsP0Yn/5+PK0h5Bh1E3Zw+8vVD086oNlu7h6lKM?=
 =?us-ascii?Q?wJlzpbLqTcMa7m3r+mABTER9IYbkmbFPTI2MzBwZGQCF4Ft0sSw6++TH5CXt?=
 =?us-ascii?Q?M3FBz/6ZLlXpkcxum8Y8N3YR2D+JHf8pwx0LUZEcE3eVfz40Te/Yq3iQGKMg?=
 =?us-ascii?Q?86AqmbSHie+qXS+krwux1ZpoIV7WhU+sKEDnajZBnR6UN1ISRxMT539PQFRT?=
 =?us-ascii?Q?952OSGxVV4/Z4RpEVSrW5IVF5F19reZM4mNVDrQ2Hd/ssA+iEo2nzxLzGkvx?=
 =?us-ascii?Q?piXOceCHrCdW7b2Geg2kSoe1UWOv0V6sCqiWMxuQig7Y68ZxDmg23ekQVs/K?=
 =?us-ascii?Q?7k2U8PVSwPhrtYWL1NojZR9eo/NuH5MjGGJSAfqE+0nLicbw5wQEP3ZTq4HE?=
 =?us-ascii?Q?ze6XCYchWURrVW/Hwx9+IJNYpvRtm6a7nmTgU3mbf9zggkkZO7KbzzI3yUH7?=
 =?us-ascii?Q?LLurbH8SoS/CkPEgMCciIzD0REUxVoRm1Qts4IaB+2JznnXky+1hkF57esX1?=
 =?us-ascii?Q?DsYLpAp/v7VI6wqC75w0/4PhZZuhKITPmgeds7IjFzHLC5R4KkUG5XyfnA41?=
 =?us-ascii?Q?U3LrJdLuu8bDFRghCK+D7qA2fmlKWQ0Yj9wE2E1p5okILqNjq1mRuQD/AvFt?=
 =?us-ascii?Q?2hIbx69p2jtDALgVbAQvEQvEWvHjqNxG5iERrpwRBgiEW+0xQGGuhCaNMQ2f?=
 =?us-ascii?Q?WRybLETdjKLN/okHmCQZr0jp2xpUwKsYWnbucKuS7hUw52nW5qNAxvi1Lj/b?=
 =?us-ascii?Q?ak6A1kipVF7rXDTX4EowDHAjPU3sl3w0EeJB8jxvwxba76Jh3t8ZvaXinZP4?=
 =?us-ascii?Q?D5TrhGSbRGTZ8ZVxUaVE+KBwnSmxP+kSvg+9E7QxKFhlW1dznrzMu9H1io9Y?=
 =?us-ascii?Q?NOwlW+ULNmMOAA6WpDdG6xsZi61sjZ9WqpbkttZeA87EPXmRnVXyDRlFnl5w?=
 =?us-ascii?Q?TBoflZbJhKJMSO8gp8FCe6q++kMREIFZQkx+Y9ajukaT5mQxkpCVdZWRG9Cv?=
 =?us-ascii?Q?cPvAG/nu+Escnr2HPhLPByySBCjibfGBqXkgKrxg6AA0Ppj0hJdJOe3Xte/V?=
 =?us-ascii?Q?HUtyyqyehCH3MCGLrLXjisQv0kvWVwWf72tnCOgLGgVgnpQDe1L0hPlkhyoP?=
 =?us-ascii?Q?ELWDP6j9/DWL67eYoevkPczvuEBmDLaeuowstkWT26s5vF6iOH8PPpQwc0rW?=
 =?us-ascii?Q?2wyV2bsv+doc+T2vEvpF8bxTcqvS7jIa0ch3monj4KJvJVq4QNQkrXi4BKKM?=
 =?us-ascii?Q?PPzonOpPpa8mAqNNq8gQgr/3A+2eYnLQT7mLHf5E90/xXfyerQeN/wTHHm0I?=
 =?us-ascii?Q?ZEOZTbD5hmJf24crtsetTAZwX1Fj0orE5vcI2JHS8WaYWO/YmbJvKauRoMja?=
 =?us-ascii?Q?105+Ri2GifIuV7i2tA90PZuERyGiVblctIV4SZAGZRIAGeAQ8Or+3rFFAVQd?=
 =?us-ascii?Q?c2pX8TBm1oC1/AonoBCxIOjqU0nMf7bSVdkhSe6qI9pa37W5qxAb+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 20:05:41.9150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b82e3f-d95d-43d7-b115-08dd836b6418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

the entries will be appearing at
/sys/kernel/debug/kfd/proc/<pid>/pasid_<gpuid>.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 77 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 4a5a0a4e00f2..14ab770fb877 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -27,6 +27,16 @@
 #include "kfd_priv.h"
 
 static struct dentry *debugfs_root;
+static struct dentry *debugfs_proc;
+static struct list_head procs;
+
+struct debugfs_proc_entry {
+	struct list_head list;
+	struct dentry *proc_dentry;
+	pid_t pid;
+};
+
+#define MAX_DEBUGFS_FILENAME_LEN 32
 
 static int kfd_debugfs_open(struct inode *inode, struct file *file)
 {
@@ -92,6 +102,8 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
 void kfd_debugfs_init(void)
 {
 	debugfs_root = debugfs_create_dir("kfd", NULL);
+	debugfs_proc = debugfs_create_dir("proc", debugfs_root);
+	INIT_LIST_HEAD(&procs);
 
 	debugfs_create_file("mqds", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_mqds_by_process, &kfd_debugfs_fops);
@@ -107,5 +119,70 @@ void kfd_debugfs_init(void)
 
 void kfd_debugfs_fini(void)
 {
+	debugfs_remove_recursive(debugfs_proc);
 	debugfs_remove_recursive(debugfs_root);
 }
+
+static ssize_t kfd_debugfs_pasid_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+    struct kfd_process_device *pdd = file_inode(file)->i_private;
+    char tmp[32];
+    int len;
+
+    len = snprintf(tmp, sizeof(tmp), "%u\n", pdd->pasid);
+
+    return simple_read_from_buffer(buf, count, ppos, tmp, len);
+}
+
+static const struct file_operations kfd_debugfs_pasid_fops = {
+    .owner = THIS_MODULE,
+    .read = kfd_debugfs_pasid_read,
+};
+
+void kfd_debugfs_add_process(struct kfd_process *p)
+{
+	int i;
+	char name[MAX_DEBUGFS_FILENAME_LEN];
+	struct debugfs_proc_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return;
+
+	list_add(&entry->list, &procs);
+	entry->pid = p->lead_thread->pid;
+	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
+		 (int)entry->pid);
+	entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
+
+	/* Create debugfs files for each GPU:
+	 * - proc/<pid>/pasid_<gpuid>
+	 */
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u",
+			 pdd->dev->id);
+		debugfs_create_file((const char *)name, S_IFREG | 0444,
+				    entry->proc_dentry,
+				    pdd,
+				    &kfd_debugfs_pasid_fops);
+	}
+}
+
+void kfd_debugfs_remove_process(struct kfd_process *p)
+{
+	struct debugfs_proc_entry *entry, *next;
+
+	mutex_lock(&kfd_processes_mutex);
+	list_for_each_entry_safe(entry, next, &procs, list) {
+		if (entry->pid != p->lead_thread->pid)
+			continue;
+
+		debugfs_remove_recursive(entry->proc_dentry);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	mutex_unlock(&kfd_processes_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f6aedf69c644..0ae794539bb0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1581,10 +1581,15 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev);
 int pm_debugfs_hang_hws(struct packet_manager *pm);
 int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
 
+void kfd_debugfs_add_process(struct kfd_process *p);
+void kfd_debugfs_remove_process(struct kfd_process *p);
+
 #else
 
 static inline void kfd_debugfs_init(void) {}
 static inline void kfd_debugfs_fini(void) {}
+static inline void kfd_debugfs_add_process(struct kfd_process *p) {}
+static inline void kfd_debugfs_remove_process(struct kfd_process *p) {}
 
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 41d7dc8c2850..722ac1662bdc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -900,6 +900,8 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		kfd_procfs_add_sysfs_files(process);
 		kfd_procfs_add_sysfs_counters(process);
 
+		kfd_debugfs_add_process(process);
+
 		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
@@ -1176,6 +1178,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 		dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
+	kfd_debugfs_remove_process(p);
 
 	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
-- 
2.34.1

