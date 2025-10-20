Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB75CCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 21:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201D010E51C;
	Mon, 20 Oct 2025 21:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VaPX4oOa";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379CB10E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 21:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGi6bFUFfsjypqavdhqtKVJXsjx2O36u6OeuIE4Nd7srpU74Yu1FjNqaCCvQFjLdAy+/1ZPHfYzSMiehblFNkmuntESmso1QrsurzEGVh4+88K1/IHK6CQk6UL1juAiSyN7GAgdCi4yrJa7zsiTsyt2u/XJt2jDzkcqs/ZKrIqRjnfovRKB0T0WJJCbMMycdYBbvqAYiAnbIqt9eDXnZpiDrJm4ueVIa/4Qd33XL0JBcwtUvg3w30NUoDWC2ikVpToj/eOGFftL8cu5k58gywkaL7yrz4vc2RQaD7lC1/BxpkjDbw35AvRNkaS0c5c8xs+wvDKi3Bs4NeWY6TVD17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n4kjdQuAUQ1zwSZIbN4F+LJpbPUNL89AJbCidn3noU=;
 b=Yz/0M2Dq+lPVRi7DLC8nwXsjlGxSeUhHungs2x9kTTN5lCoU5QIfioRzXH2N+jpc6wRSwK3YrTgVZSt2cAWAeYWn6Oah6OtqHYTswDPTgR+0G+ejIJNNt6YvRfzeYbaF6YPntSEw8NKpl0AhvEb4XVWGd+Ea6jtYl4RY/zAqn0O0XdrnBDDUdtc0wnZMINTNRyISU/Q46P0KJf66Rb34/Y5dikir3EjLfSdhIzx5yFOT7SGTG+KTxyKsmDvQN10TI4fVHfbq8GmDgRecDbm/ruZeEp1Wrhum3CNvtsSOlJt5wo30Pbybcag/xc5pZ41Zd/kKl386BXtVzNJvRZsKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n4kjdQuAUQ1zwSZIbN4F+LJpbPUNL89AJbCidn3noU=;
 b=VaPX4oOaBF8dzmwksyf3ijbiO46vBCJmT3PaPPqaGipTK8owgEJQGqBW+o3had+mh07K5nBom+xAuoc7QsCRTy9nDTGqqpYSf4/eFN/L4dSGHf/eTAhs3CHQzX5mqLaoZ1Mz3hYHkyt9Vbf5x4Op+YAgHxis4BAx5g/8P6W2hBo=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 21:25:51 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d2) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 21:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 21:25:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 14:25:50 -0700
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 20 Oct 2025 14:25:50 -0700
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: An adaptive data migration scheme for page fault
 recovery at svm
Date: Mon, 20 Oct 2025 16:24:14 -0500
Message-ID: <20251020212414.1890907-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 868c0bd6-ac81-42df-c84a-08de101f3e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nASCPdQuYX+KHOIWf95siZ7EKBSbuUpin7oxyUw0HEMVsAZWwZFscassNSrJ?=
 =?us-ascii?Q?R/lry+tHP5///mkR//o9ckkxRW6+vgG+bV99vn+qt6wG+r3TZSk6Tko6Wlz8?=
 =?us-ascii?Q?TkoHUjpny4QkHJOP6N5qDtqiarVkmGPtX5E+1DUs9P4G9Q54qMdSi42i9qjh?=
 =?us-ascii?Q?wz0BVqe3IXXWM14MvBUXT8Nlle+2psY4zTTobgmf/Y9PWsvAKWO4JiTt/LVa?=
 =?us-ascii?Q?kdzC9oJWnAGjinpXXXYEAbZk0VChOvjieGFytT++yPxSkcSY5tPW8STe12Df?=
 =?us-ascii?Q?zspffRGAUkNhrsPEXUyE+Dz+bFRpQJ56Jwyu0Rs1XwzddAJF9yliUqbfeWVs?=
 =?us-ascii?Q?Aw++dEWpQHHhjhUUnPbgR4dmpZ5zBdn4U7W6GhWFKMVfS69IFBxsV/e3wnc2?=
 =?us-ascii?Q?kJQ7JZwhPSaJf5aF0Fj05LoJHzVEbPH9+s/vtlA8ocYwU0sZ6VVUlPlZ3lPQ?=
 =?us-ascii?Q?3eY5jWIac6cK75qUxxuVwW4tulPli9yM/TRa1t/TRsUaJz7gY9Qe/f5HxKAV?=
 =?us-ascii?Q?5XzxzLsOhYYgIdmTwEKf8ts/JDk9VC04yDTzGy/qD6MzlAt6vaP9hLvrQAhS?=
 =?us-ascii?Q?/IzO4mIUJ5y4tVWzL/sYMW3PjFeNA7J/evgta0JjxImW/JbLWUtpblpqJCeL?=
 =?us-ascii?Q?nE0SaorADfIKehVK4YVk3WQOIpkNIiz5iC1sbMvLQ7ogBDVWAPoL4cEX/X9O?=
 =?us-ascii?Q?fyUuUN+y28FGUJp3iPrGtGGgygBBQwhIsV/hr3RkX0znQTRdMKNR7aqggZ1t?=
 =?us-ascii?Q?GdgOFkHoL+sVbHFFE2rAj73xVG91N/DExdMeAQkojWxx9C927R6MXr1q/A2N?=
 =?us-ascii?Q?cOsjK5B3v0KyZW9iNEWm+QXkLEMNt+DSqFhMHlwfQqUK5CYQR7L30cmeJ+bF?=
 =?us-ascii?Q?upFRJpasADycFmPLhHQ8nOvQhdLo9m0espwbihaYqFHeS4tSwf4Z8Dwpk6t5?=
 =?us-ascii?Q?grJyuVFHm/xHYVVm6ipYOyyEAvlFWw1GqQD2RyZWRxLnZZzB9BNrzYkxiq4w?=
 =?us-ascii?Q?EtgDq8EGyHJfCFViA24mBhiIjAOUsXgwIrE0+n9xjyrtP45fxGFdaEfTUj4Y?=
 =?us-ascii?Q?j+JKLbLULGWbIxEinUSBLIlzewv9RbKsUMTH/fbURqIcWFS53d9F6Cp3hn89?=
 =?us-ascii?Q?bBgVAynqaVlgR2s5lYCCfe6hLhb9rX2zjusZmJHKRFKQsZH/wiCOjUFFsaeU?=
 =?us-ascii?Q?djJfbCldYKG42lBzYf1JDpEu1ImAYHUBsW1gdAyNdUZ6N1/dUq1n3/FK+b1J?=
 =?us-ascii?Q?pJCm9TCzT6c9QOz5E2Q1d+mYTX/aur9H7US2Qo+RajKzLogIXWMRJR4QbTKB?=
 =?us-ascii?Q?wKULJGnzbhdcIdRTnEUpKB3LGFfgBAtuFmEHXsKWGkDUzuddxEtTCXYI37nP?=
 =?us-ascii?Q?4ICyFOoctBI7xsNGjcYDhV5/mxj3yZGOVHh1qUJ78hVRbeqsYldRGeKf8dfi?=
 =?us-ascii?Q?0waPGeU8HbRhSE71qGiKO63ZcjlhOe55HaJEXdGECrqkpPxs6KvRwTzuaQ77?=
 =?us-ascii?Q?mw2tnRIb1zYQVO6v/V1f/z3IpkdWuXjI9TO/uLO/Zx+XEvLJpliiI7esWWhf?=
 =?us-ascii?Q?aDm1UVz4W6x8IRb8aSs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:25:51.3018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c0bd6-ac81-42df-c84a-08de101f3e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

Data migration between cpu and gpu or between gpus is a common operation at
kfd/svm during page fault recovery. Certainly, it adds overhead and consumes
bus bandwidth. So, becomes crucial for compute performance.

There are two objectives that are considered mostly during data accessing:

1: Locality:  move data to compute devices local memory which is fast.
2: Zero copy: not have data moved, compute devices access data remotely.

They are usually conflict: local accessing would require data copy; avoiding
data copy would have device access data remotely.

The new scheme balances the two accessing patterns by using statistical samples
that driver records from previous page fault data to predict what data accessing
pattern would be for future page faults, then use the prediction to handle new
page fault.

The scheme behavior is also dynamically adjusted by following application data
accessing pattern overtime. The new decision is based on most recent page fault
handling data that are saved at a ring buffer.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 102 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 212 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 151 +++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  30 ++++
 5 files changed, 473 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 9bde2c64540f..d495af31fa3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -38,6 +38,9 @@ struct debugfs_proc_entry {
 
 #define MAX_DEBUGFS_FILENAME_LEN 32
 
+extern uint32_t num_pf_sample;
+extern uint32_t data_migrate_rate_threshold;
+
 static int kfd_debugfs_open(struct inode *inode, struct file *file)
 {
 	int (*show)(struct seq_file *, void *) = inode->i_private;
@@ -50,6 +53,80 @@ static int kfd_debugfs_hang_hws_read(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int kfd_debugfs_num_pf_samples_read(struct seq_file *m, void *data)
+{
+	seq_printf(m, "number of page fault samples per svm range: %d\n",
+			   num_pf_sample);
+	seq_puts(m, "echo 'num' > num_pf_sample to change it\n");
+	return 0;
+}
+
+static int kfd_debugfs_data_migration_rate_threshold(struct seq_file *m,
+						      void *data)
+{
+	seq_printf(m, "data migration rate threshold in 2MB unit: %d\n",
+			   data_migrate_rate_threshold);
+	seq_puts(m, "echo 'num' > data_migrate_rate_threshold to change it\n");
+	return 0;
+}
+
+static ssize_t kfd_debugfs_num_pf_samples_write(struct file *file,
+	const char __user *user_buf, size_t size, loff_t *ppos)
+{
+	char tmp[16];
+	int ret = -EINVAL;
+
+	memset(tmp, 0, 16);
+	if (size >= 16) {
+		pr_err("Invalid input for num of page fault samples\n");
+		goto out;
+	}
+
+	if (copy_from_user(tmp, user_buf, size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (kstrtoint(tmp, 10, &num_pf_sample)) {
+		pr_err("Invalid input for num of page fault samples.\n");
+		goto out;
+	}
+
+	ret = size;
+
+out:
+	return ret;
+}
+
+static ssize_t kfd_debugfs_dmrt_write(struct file *file,
+	const char __user *user_buf, size_t size, loff_t *ppos)
+{
+	char tmp[16];
+	int ret = -EINVAL;
+
+	memset(tmp, 0, 16);
+	if (size >= 16) {
+		pr_err("Invalid input for num of page fault samples\n");
+		goto out;
+	}
+
+	if (copy_from_user(tmp, user_buf, size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (kstrtoint(tmp, 10, &data_migrate_rate_threshold)) {
+		pr_err("Invalid input for num of page fault samples.\n");
+		goto out;
+	}
+
+	ret = size;
+
+out:
+	return ret;
+}
+
+
 static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
 	const char __user *user_buf, size_t size, loff_t *ppos)
 {
@@ -99,6 +176,24 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
 	.release = single_release,
 };
 
+static const struct file_operations kfd_debugfs_num_pf_samples_fops = {
+	.owner = THIS_MODULE,
+	.open = kfd_debugfs_open,
+	.read = seq_read,
+	.write = kfd_debugfs_num_pf_samples_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static const struct file_operations kfd_debugfs_dmrt_fops = {
+	.owner = THIS_MODULE,
+	.open = kfd_debugfs_open,
+	.read = seq_read,
+	.write = kfd_debugfs_dmrt_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 void kfd_debugfs_init(void)
 {
 	debugfs_root = debugfs_create_dir("kfd", NULL);
@@ -111,10 +206,15 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
-	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
+	debugfs_create_file("hang_hws", S_IFREG | 0600, debugfs_root,
 			    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
 	debugfs_create_file("mem_limit", S_IFREG | 0200, debugfs_root,
 			    kfd_debugfs_kfd_mem_limits, &kfd_debugfs_fops);
+	debugfs_create_file("num_pf_samples", S_IFREG | 0644, debugfs_root,
+			 kfd_debugfs_num_pf_samples_read, &kfd_debugfs_num_pf_samples_fops);
+	debugfs_create_file("data_migration_rate_threshold", S_IFREG | 0644,
+			 debugfs_root, kfd_debugfs_data_migration_rate_threshold,
+			 &kfd_debugfs_dmrt_fops);
 }
 
 void kfd_debugfs_fini(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 5d7eb0234002..8c9ffb258062 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -39,6 +39,16 @@
 #endif
 #define dev_fmt(fmt) "kfd_migrate: " fmt
 
+/* threshold of data migration rate(per second, DMR) per svm range
+ * in 2MB unit, so 512 is 1GB */
+uint32_t data_migrate_rate_threshold = 512;
+
+/* nubmer of most recent page fault related data driver keeps per svm range
+ * driver uses them to check how data got accessed after page fault recovery
+ * then decide migration scheme for new page fault recoveries.
+ */
+uint32_t num_pf_sample = 20;
+
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
 {
@@ -476,7 +486,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			unsigned long start_mgr, unsigned long last_mgr,
-			struct mm_struct *mm, uint32_t trigger)
+			struct mm_struct *mm, uint32_t trigger,
+			unsigned long* migration_amount)
 {
 	unsigned long addr, start, end;
 	struct vm_area_struct *vma;
@@ -554,6 +565,10 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 					prange->npages * PAGE_SIZE,
 					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
 					node->xcp ? node->xcp->id : 0);
+
+	if (migration_amount)
+		*migration_amount += mpages;
+
 	return r < 0 ? r : 0;
 }
 
@@ -778,6 +793,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * @last_mgr: last page need be migrated to sys ram
  * @trigger: reason of migration
  * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
+ * @migration_amount: return number of pages got migrated after call
+ *
  *
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
@@ -786,7 +803,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			    unsigned long start_mgr, unsigned long last_mgr,
-			    uint32_t trigger, struct page *fault_page)
+			    uint32_t trigger, struct page *fault_page,
+			    unsigned long* migration_amount)
 {
 	struct kfd_node *node;
 	struct vm_area_struct *vma;
@@ -856,6 +874,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			prange->actual_loc = 0;
 			svm_range_vram_node_free(prange);
 		}
+
+		if (migration_amount)
+			*migration_amount += mpages;
 	}
 
 	return r < 0 ? r : 0;
@@ -881,7 +902,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			unsigned long start, unsigned long last,
-			struct mm_struct *mm, uint32_t trigger)
+			struct mm_struct *mm, uint32_t trigger,
+			unsigned long* migration_amount)
 {
 	int r, retries = 3;
 
@@ -893,8 +915,11 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
+		if (migration_amount)
+			*migration_amount = 0;
+
 		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
-					    trigger, NULL);
+					    trigger, NULL, migration_amount);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -902,22 +927,179 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
+	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger,
+				       migration_amount);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
 		    unsigned long start, unsigned long last,
-		    struct mm_struct *mm, uint32_t trigger)
+		    struct mm_struct *mm, uint32_t trigger,
+		    unsigned long* migration_amount)
 {
+	if (migration_amount)
+		*migration_amount = 0;
+
 	if  (!prange->actual_loc || prange->actual_loc == best_loc)
 		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
-					       mm, trigger);
+					       mm, trigger, migration_amount);
 
 	else
 		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
-						mm, trigger);
+						mm, trigger, migration_amount);
+
+}
+
+/**
+ * @prange: range structure
+ * @start: start addr in page of page fault triggred migration
+ * @migration_amount:  migration data amount in 2MB unit
+ * @src:   from which page fault happened
+ * @migration_or_remote: migrate data or remote access
+ *
+ * update svm_range->page_fault_data after some pages got
+ * migrated
+ *
+ * need be under svm_range->migrate_mutex protection
+ */
+
+void update_pf_migration_data(struct svm_range* prange, int32_t pf_src,
+				bool migration_or_remote, unsigned long migration_amount)
+{
+	uint8_t pf_data_index = prange->pf_data_index & 0x7f;
+
+	lockdep_assert_held(&prange->migrate_mutex);
+
+	prange->page_fault_data[pf_data_index].ktime = ktime_get();
+	prange->page_fault_data[pf_data_index].migration_info =
+			MIGRATIOM_INFO(migration_or_remote, pf_src, migration_amount);
+
+	/* check if page_fault_data buf is full */
+	if (!(prange->pf_data_index & 0x80) &&
+		(prange->pf_data_index + 1 >= num_pf_sample))
+			prange->pf_data_index |= 0x80;
+
+	prange->pf_data_index = (prange->pf_data_index & 0x80) |
+				(((prange->pf_data_index & 0x7f) + 1) % num_pf_sample);
+}
+
+/**
+ * @prange: range structure
+ * @hot_device: device who accesses data(by migration or remote)
+ *  		  mostly
+ *
+ * Return:
+ *
+ * false: data migration rate is not higher than
+ * DATA_MIGRATE_RATE_THRESHOLD
+ *
+ * true: data migration rate is higher than
+ * DATA_MIGRATE_RATE_THRESHOLD
+ *
+ * return value will be used to decide migration scheme in
+ * following operations.
+ */
+bool processing_pf_migration_data(struct svm_range* prange,
+				   uint32_t* hot_device)
+{
+	uint8_t start_index, last_index, next_index, device_idx;
+	bool ret = false;
+	uint32_t i;
 
+	/* in nanosecond */
+	ktime_t time_last, time_first;
+	s64 time_interval;
+
+	/* in 2MB unit */
+	/* data for cpu is saved at MAX_GPU_INSTANCE-th entry */
+	uint32_t migration_amount_device[MAX_GPU_INSTANCE + 1] = {0};
+	uint32_t remote_amount_device[MAX_GPU_INSTANCE + 1] = {0};
+
+	uint64_t total_migration_amount = 0;
+	uint64_t total_remote_amount = 0;
+
+	/* page fault data buf is not full */
+	if (!(prange->pf_data_index & 0x80))
+		return false;
+
+	for (i = 0; i < num_pf_sample; i++) {
+
+		bool is_migrartion =
+			MIGRATIOM_OR_MAP(prange->page_fault_data[i].migration_info);
+
+		uint16_t migration_or_map_amount =
+			MIGRATIOM_AMOUNT(prange->page_fault_data[i].migration_info);
+
+		device_idx =
+			PF_DEVICE(prange->page_fault_data[i].migration_info);
+		/* convert to array index */
+		device_idx = (device_idx != CPU_DEVICE) ? device_idx : MAX_GPU_INSTANCE;
+
+		if (is_migrartion) {
+			migration_amount_device[device_idx] += migration_or_map_amount;
+			total_migration_amount += migration_or_map_amount;
+		} else {
+			remote_amount_device[device_idx] += migration_or_map_amount;
+			total_remote_amount += migration_or_map_amount;
+		}
+
+	}
+
+	*hot_device = INVALID_COMPUTE_DEVICE;
+
+	/* prange->page_fault_data's next index is prange->pf_data_index
+	 * it is cycular buff. get start and last entries to cal time(in nanosec)
+	 * during which these page faults happened
+	 */
+	next_index = prange->pf_data_index & 0x7f;
+	last_index  = (next_index == 0) ? (num_pf_sample - 1) : (next_index - 1);
+	start_index = (next_index == 0) ? 0 : next_index;
+
+	time_last  = prange->page_fault_data[last_index].ktime;
+	time_first = prange->page_fault_data[start_index].ktime;
+
+	time_interval = ktime_to_ns(ktime_sub(time_last, time_first));
+
+	/* should not happend as ktime_get is monotonically increasing */
+	if (time_interval < 0) {
+		pr_warn("Negative time difference detected\n");
+		return  0;
+	}
+
+	/* page fault is very intensive, had NUM_PF_SAMPLE page faults
+	 * in less 1 nanosecond, treat that as 1 nanosecond
+	 */
+	if (time_interval == 0)
+		time_interval = 1;
+
+	/* check migration data rate first*/
+	if (total_migration_amount * NSEC_PER_SEC >
+		data_migrate_rate_threshold * time_interval) {
+
+		/* check if there is a significant device */
+		for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
+			if (migration_amount_device[i] > total_migration_amount / 2) {
+				*hot_device = i;
+				break;
+			}
+		}
+
+		ret = true;
+
+	} else if (total_remote_amount * NSEC_PER_SEC >
+		data_migrate_rate_threshold * time_interval) {
+
+		for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
+			if (migration_amount_device[i] > total_migration_amount / 2) {
+				*hot_device = i;
+				break;
+			}
+		}
+
+		ret = true;
+	}
+
+	return ret;
 }
 
 /**
@@ -932,6 +1114,7 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
  */
 static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 {
+	unsigned long migration_amount_pages = 0;
 	unsigned long start, last, size;
 	unsigned long addr = vmf->address;
 	struct svm_range_bo *svm_bo;
@@ -989,10 +1172,21 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	last = min(ALIGN(addr + 1, size) - 1, prange->last);
 
 	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
-				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
+				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page,
+				    &migration_amount_pages);
+
 	if (r)
 		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
 			r, prange->svms, prange, start, last);
+	else {
+		/* When cpu page fault happen always migrate data to sys ram
+		 * cpu cannot access device ram remotely, record page fault data
+		 * migration amount is in 2MB unit, migration_amount_pages is
+		 * in page. If it is smaller than 2MB, choose 2MB
+		 */
+		update_pf_migration_data(prange, CPU_DEVICE, true,
+					ALIGN(migration_amount_pages, 1UL << 9) >> 9);
+	}
 
 out_unlock_prange:
 	mutex_unlock(&prange->migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 2eebf67f9c2c..160d4c1bd07f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -42,15 +42,23 @@ enum MIGRATION_COPY_DIR {
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
 			unsigned long start, unsigned long last,
-			struct mm_struct *mm, uint32_t trigger);
+			struct mm_struct *mm, uint32_t trigger,
+			unsigned long *migration_amount);
 
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			    unsigned long start, unsigned long last,
-			    uint32_t trigger, struct page *fault_page);
+			    uint32_t trigger, struct page *fault_page,
+			    unsigned long *migration_amount);
 
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
+void update_pf_migration_data(struct svm_range *prange, int32_t pf_src,
+			       bool migration_or_remote, unsigned long migration_amount);
+
+bool processing_pf_migration_data(struct svm_range *prange,
+				   uint32_t *hot_device);
+
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
 
 #endif /* KFD_MIGRATE_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 521c14c7a789..c2843836661e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -63,6 +63,8 @@
  */
 static uint64_t max_svm_range_pages;
 
+extern uint32_t num_pf_sample;
+
 struct criu_svm_metadata {
 	struct list_head list;
 	struct kfd_criu_svm_range_priv_data data;
@@ -303,6 +305,9 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 		}
 	}
 
+	kvfree(prange->page_fault_data);
+	prange->page_fault_data = NULL;
+
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
 	kfree(prange);
@@ -355,6 +360,14 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
+	prange->pf_data_index = 0;
+	prange->page_fault_data = kvmalloc_array(num_pf_sample,
+						 sizeof(struct svm_pf_info), GFP_KERNEL);
+	for (int i = 0; i < num_pf_sample; i++) {
+		prange->page_fault_data[i].ktime = 0;
+		prange->page_fault_data[i].migration_info = 0 | INVALID_COMPUTE_DEVICE;
+	}
+
 	if (p->xnack_enabled)
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1068,9 +1081,27 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	for (int i = 0; i < num_pf_sample; i++) {
+		uint16_t old_amount =
+			MIGRATIOM_AMOUNT(old->page_fault_data[i].migration_info);
+		unsigned long temp = (new->last - new->start + 1) * old_amount;
+		uint16_t new_amount = temp / (old->last - old->start + 1);
+
+		/* proportionally devide data amount betwee new and old pranges */
+		new->page_fault_data[i].migration_info =
+			(new->page_fault_data[i].migration_info & (~0xffff)) | new_amount;
+
+		old->page_fault_data[i].migration_info =
+			(old->page_fault_data[i].migration_info & (~0xffff)) |
+			(old_amount - new_amount);
+
+		new->page_fault_data[i].ktime = old->page_fault_data[i].ktime;
+	}
+
 	old->npages = last - start + 1;
 	old->start = start;
 	old->last = last;
+	new->pf_data_index = old->pf_data_index;
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
@@ -2973,6 +3004,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, uint64_t ts, bool write_fault)
 {
+	unsigned long migration_amount_pages;
+	bool migration_or_remote_high;
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
@@ -2985,6 +3018,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
+	uint32_t hot_device;
 	int r = 0;
 
 	if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
@@ -3135,33 +3169,103 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	size = 1UL << prange->granularity;
 	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
 	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
-	if (prange->actual_loc != 0 || best_loc != 0) {
-		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, start, last,
-					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
+
+	/* check previous page fault data to decide how to migrate data */
+	hot_device = INVALID_COMPUTE_DEVICE;
+	migration_or_remote_high =
+			processing_pf_migration_data(prange, &hot_device);
+
+	/* migrated or remote accessing data rate is not high
+	 * use automatic migration scheme
+	 */
+	if (!migration_or_remote_high) {
+		migration_amount_pages = 0;
+
+		if (prange->actual_loc != 0 || best_loc != 0) {
+
+			if (best_loc) {
+				r = svm_migrate_to_vram(prange, best_loc, start, last,
+						mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
+						&migration_amount_pages);
+				if (r) {
+					pr_debug("svm_migrate_to_vram failed (%d) at %llx,"
+						" falling back to system memory\n",
+						 r, addr);
+					/* Fallback to system memory if migration to
+					 * VRAM failed
+					 */
+					if (prange->actual_loc && prange->actual_loc != best_loc)
+						r = svm_migrate_vram_to_ram(prange, mm, start, last,
+							KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
+					else
+						r = 0;
+				}
+
+			} else {
+				r = svm_migrate_vram_to_ram(prange, mm, start, last,
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL,
+						&migration_amount_pages);
+			}
 			if (r) {
-				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
-					 r, addr);
-				/* Fallback to system memory if migration to
-				 * VRAM failed
+				pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
+					 r, svms, start, last);
+				goto out_migrate_fail;
+			} else {
+				migration = true;
+				/* migration amount is in 2MB unit.
+				 * if it is smaller than 2MB, use 2MB.
 				 */
-				if (prange->actual_loc && prange->actual_loc != best_loc)
-					r = svm_migrate_vram_to_ram(prange, mm, start, last,
-						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
-				else
-					r = 0;
+				update_pf_migration_data(prange, gpuidx, true,
+							ALIGN(migration_amount_pages, 1UL << 9) >> 9);
 			}
-		} else {
-			r = svm_migrate_vram_to_ram(prange, mm, start, last,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
 		}
+	} else if (hot_device == INVALID_COMPUTE_DEVICE) {
+		migration = false;
+		/* there is no significant device, use AIP */
+		/* no data migration for page recovery
+		 * the gpu(gpuidx) will access data remotely after map
+		 * count data amount that this gpu remotely access
+		 */
+		update_pf_migration_data(prange, gpuidx, false,
+					 ALIGN((last - start + 1), 1UL << 9) >> 9);
+
+	} else if (gpuidx == hot_device) {
+		/* gpuidx(where page fault happened) is same as hot_device
+		 * move data to gpuidx gpu by svm_migrate_to_vram
+		 * it either moves prange to system ram, then 2MB to gpuidx
+		 * or move 2MB from sys ram to gpuidx vram
+		 */
+		r = svm_migrate_to_vram(prange, gpuid, start, last,
+					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
+					&migration_amount_pages);
+		if (r) {
+			pr_debug("svm_migrate_to_vram failed (%d) at %llx, "
+				"falling back to system memory\n",
+					r, addr);
+			/* Fallback to system memory if migration to
+			 * VRAM failed
+			 */
+			if (prange->actual_loc && prange->actual_loc != gpuidx)
+				r = svm_migrate_vram_to_ram(prange, mm, start, last,
+							   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
+				else
+					r = 0;
+		} else
+			update_pf_migration_data(prange, gpuidx, true,
+				ALIGN(migration_amount_pages, 1UL << 9) >> 9);
+
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
-				 r, svms, start, last);
+						 r, svms, start, last);
 			goto out_migrate_fail;
-		} else {
+		} else
 			migration = true;
-		}
+
+	} else {
+		/* gpu gpuidx is not hot device, have it access data remotely */
+		update_pf_migration_data(prange, gpuidx, false,
+					 ALIGN((last - start + 1), 1UL << 9) >> 9);
+		migration = false;
 	}
 
 	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
@@ -3535,14 +3639,16 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 		return 0;
 
 	if (!best_loc) {
+		/* not count migration amount for prefetch */
 		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
-					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
+					KFD_MIGRATE_TRIGGER_PREFETCH, NULL, NULL);
 		*migrated = !r;
 		return r;
 	}
 
+	/* not count migration amount for prefetch */
 	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
-				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
+				mm, KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
 	*migrated = !r;
 
 	return 0;
@@ -3599,9 +3705,10 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 			/* migrate all vram pages in this prange to sys ram
 			 * after that prange->actual_loc should be zero
 			 */
+			/* not count migration amount for eviction now */
 			r = svm_migrate_vram_to_ram(prange, mm,
 					prange->start, prange->last,
-					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
+					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL, NULL);
 		} while (!r && prange->actual_loc && --retries);
 
 		if (!r && prange->actual_loc)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 01c7a4877904..5e6f07eba0c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -39,6 +39,31 @@
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
+/* indicator for cpu device */
+#define CPU_DEVICE 0xFF
+
+/* indicator for invalid device */
+#define INVALID_COMPUTE_DEVICE (1 << 30)
+
+#define GETMASK32(h, l) ((((uint32_t)(~0)) << (l)) & ((uint32_t)(~0) >> (32 - 1 - (h))))
+
+#define MIGRATIOM_OR_MAP(migration_info) (((migration_info) & GETMASK32(31, 31)) >> 31)
+#define PF_DEVICE(migration_info) (((migration_info) & GETMASK32(23, 16)) >> 16)
+#define MIGRATIOM_AMOUNT(migration_info) ((migration_info) & GETMASK32(15, 0))
+
+#define MIGRATIOM_INFO(flag, device, amount) (((flag) << 31) | ((device) << 16) | (amount))
+
+struct svm_pf_info {
+	/* kernel time when page fault happen */
+	ktime_t ktime;
+	/* enclosing info:
+	 * 1: data manipulation for page fault recovery: local or remote access
+	 * 2: device where page fault happened, use 0xff for cpu
+	 * 3: data amount involved
+	 */
+	uint32_t migration_info;
+};
+
 struct svm_range_bo {
 	struct amdgpu_bo		*bo;
 	struct kref			kref;
@@ -138,6 +163,11 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				mapped_to_gpu;
 	atomic_t			queue_refcount;
+	struct svm_pf_info *page_fault_data;
+	/* most significant bit indicates if page_fault_data is full
+	 * so the max size of page_fault_data is 127
+	 */
+	uint8_t pf_data_index;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.34.1

