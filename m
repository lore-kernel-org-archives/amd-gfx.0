Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A154C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE3010EAF5;
	Fri, 11 Feb 2022 18:59:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834F510EAF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlULW4C/4DE3RKoxHIVAjCcY6/bwqbjh8PMBj+42PAsVDjgD23wU66/t83FaTEg951qS7bQkz14TWdYenpGKw0wguZjfBj0aiJk2JDBTCVqZ0Vb/9FeRDNutcHDK1RMq+QLcScO/EuJzTchi8MgCS0QnoiBkKvBdvx4VaH9ULF82Tt7B3IZxZJDMJtgqgN2dQ3/sxinhHakq5j/IrVEfFAgBPI5TzSCvQr7MbnSHj6EhOYfCL9MoHWnK7VHSp2k6J207+5PAmnjsNYMabusxtgJyc+LRFK133PmWFcenzRRXZPVQSUapRx5rWgm+13pZ2qHZoi0ee4je9E845mpmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF0vKYSaJDjAX+LgmGc7jmyzh+my5ibaXXumxnLPfSk=;
 b=UmAhaD6txrgbCsnFn4IQmc2ky3mgO2fqAjeC6jUWESUcxOxQzSgaP/icCtorCPrrQ5ES3Rm78YEB6trsrIktr62IQAqojXdO6tunlZEcZym9ldXz8U8fX/q2tP0HAwD3VKBCR9eQD8SVFdXLbp+E8eylfy5/l/VpmCzcpT8kC2tt4UD/VDFjR3kMGvAbExdfRHb5zc3dpQZPktmi0qQD6hA7AgmM3Mh34TiI4FwVDASmaoadfRj2QwPcooW4iGm7Bm9naA4ipDd3iTYwxxCV5U/mCyk5eCsZkTcxC6lKr93OTDj4drjxfenWrifcayGcf7w7JEakpvnXp/h4wrvttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF0vKYSaJDjAX+LgmGc7jmyzh+my5ibaXXumxnLPfSk=;
 b=HGCzTyX5cFLcWB9BhzgeL+tVOKWF5C9quCuwjlHGczdRBul7qUSNz1uQH88cJn+k3pSSyGAF5raz382WSUKdVLK1EKazoQcPC4ojPQZcYvZZhtj3TU3fs0S32TN1nsl6BNDN3MgKrgI6QP0i382VftofkuuXPZ9twbqd0OLauCY=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by DM5PR12MB1690.namprd12.prod.outlook.com (2603:10b6:4:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 18:59:42 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e2) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 18:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 18:59:42 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 12:59:38 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: Fix leftover errors and warnings
Date: Fri, 11 Feb 2022 13:59:24 -0500
Message-ID: <20220211185925.4178-4-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
References: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 916b37fb-d16d-4c48-158f-08d9ed90a95d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1690:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1690F4254E121E0BC61441C5FE309@DM5PR12MB1690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgIa0OV+QGdcs30wxU92NE/XjsgbxehwOzlRh4ypqyMDOHzul34lmRU3zPKCtPmJgp6vCY6jZAN4x4pGLetK1A3Owennb5Rgco7xVtntVDsH3qBnCEBMuYG5J4ArCnSmRboGyFcOnOuuP+7kmzq2Md97LLt/Hp1890BEBau8zOzbJN6wsUfRykKmtbe1TLfEsde2PtYjl56KbytJRc60Zs88bRT2bsZJPH2/qZEvwqK3kAeztzU886Tc9DIac4Lpu59zFHTssw40Xwdok28JzK36s1H29S84E2zRAEp0r0yAt7OWvqiYIXpp1MifMkh47XfT+z+FfmeAO3JJuCl+jM5hmZ5OTSIyqdu4L7+8oHUd5etr6on+n/znbKMlmhk74KwnofpeOZ992qbIR2Xs0Q0bG9ranH0nx3h/60lyq8Qt8RRFuyd1zDact4v3KvbsiPVlUSLEaduRYDyfoWQlI94QgloRiYCw0gz6CVYMQ1yH0+CTZZF3OaHes1rLK97C1tHeiFyhGYiN659iUmsFA+bLmgo56s+2QQS/rnGu4X9RjhwVlGuNLGE7RqASY3xXQfhzK4oeIrLeZZFtNT2jaTK5ki1/RWXmG5zdwgQ+YpKz8at/RpBwzfmFjqsuX/Kk0PDWhOI+7x797VumQPeRjcq/9OR8lAhpkJoHe6jUtF1tcbTymW9aAMnLyG5+PI9VjTKm08YMNwVtNDy496kaVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(54906003)(81166007)(70586007)(4326008)(8676002)(316002)(8936002)(70206006)(6916009)(40460700003)(1076003)(30864003)(26005)(426003)(336012)(5660300002)(16526019)(7696005)(6666004)(83380400001)(508600001)(356005)(86362001)(36860700001)(186003)(2616005)(2906002)(44832011)(47076005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:42.0284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b37fb-d16d-4c48-158f-08d9ed90a95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1690
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A bunch of errors and warnings are leftover KFD over the years, attempt
to fix the errors and most warnings reported by checkpatch tool. Still a
few warnings remain which may be false positives so ignore them for now.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 11 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         |  5 +++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 ++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h   |  8 +++-----
 .../amd/amdkfd/kfd_device_queue_manager_v10.c   |  9 ---------
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c    |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c       |  6 +++---
 17 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 33bd13a75bb5..965af2a08bc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -37,7 +37,7 @@
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
 #include <linux/fdtable.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_svm.h"
@@ -1133,11 +1133,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	return ret;
 }
 
-static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
+static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
+{
 	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-	        dev->adev->sdma.instance[0].fw_version >= 18) ||
-	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
+		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
+		dev->adev->sdma.instance[0].fw_version >= 18) ||
+		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
 
 static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 093305534d04..24898238b024 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1382,7 +1382,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
 		break;
 	default:
-		switch(KFD_GC_VERSION(kdev)) {
+		switch (KFD_GC_VERSION(kdev)) {
 		case IP_VERSION(9, 0, 1):
 			pcache_info = vega10_cache_info;
 			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 015ada3a0d54..482ba84a728d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -233,7 +233,7 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT	(1 << 2)
 #define CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT	(1 << 3)
 #define CRAT_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA	(1 << 4)
-#define CRAT_IOLINK_FLAGS_BI_DIRECTIONAL 	(1 << 31)
+#define CRAT_IOLINK_FLAGS_BI_DIRECTIONAL	(1 << 31)
 #define CRAT_IOLINK_FLAGS_RESERVED_MASK		0x7fffffe0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 36371fb03778..581c3a30fee1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -36,7 +36,7 @@ static int kfd_debugfs_open(struct inode *inode, struct file *file)
 }
 static int kfd_debugfs_hang_hws_read(struct seq_file *m, void *data)
 {
-	seq_printf(m, "echo gpu_id > hang_hws\n");
+	seq_puts(m, "echo gpu_id > hang_hws\n");
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 8e3efb8518fb..339e12c94cff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -439,7 +439,8 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 	return ret;
 }
 
-static void kfd_smi_init(struct kfd_dev *dev) {
+static void kfd_smi_init(struct kfd_dev *dev)
+{
 	INIT_LIST_HEAD(&dev->smi_clients);
 	spin_lock_init(&dev->smi_lock);
 }
@@ -572,7 +573,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
-	if(kgd2kfd_resume_iommu(kfd))
+	if (kgd2kfd_resume_iommu(kfd))
 		goto device_iommu_error;
 
 	if (kfd_resume(kfd))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 33d8389701e0..ac5f2e628f00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -677,9 +677,9 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 		}
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				(dqm->dev->cwsr_enabled?
-				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
+				(dqm->dev->cwsr_enabled ?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE :
+				 KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
 			pr_err("destroy mqd failed\n");
@@ -772,9 +772,9 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			continue;
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				(dqm->dev->cwsr_enabled?
-				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
+				(dqm->dev->cwsr_enabled ?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE :
+				 KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval && !ret)
 			/* Return the first error, but keep going to
@@ -1099,7 +1099,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 
 	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
-	
+
 	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
 		r = pm_init(&dqm->packet_mgr, dqm);
 	if (!r)
@@ -2235,8 +2235,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 	int r = 0;
 
 	if (!dqm->sched_running) {
-		seq_printf(m, " Device is stopped\n");
-
+		seq_puts(m, " Device is stopped\n");
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 977e1d471c50..3d539d6483e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -92,7 +92,7 @@ union GRBM_GFX_INDEX_BITS {
  *
  * @initialize: Initializes the pipelines and memory module for that device.
  *
- * @start: Initializes the resources/modules the the device needs for queues
+ * @start: Initializes the resources/modules the device needs for queues
  * execution. This function is called on device initialization and after the
  * system woke up after suspension.
  *
@@ -113,7 +113,7 @@ union GRBM_GFX_INDEX_BITS {
  *
  * @evict_process_queues: Evict all active queues of a process
  *
- * @restore_process_queues: Restore all evicted queues queues of a process
+ * @restore_process_queues: Restore all evicted queues of a process
  *
  * @get_wave_state: Retrieves context save state and optionally copies the
  * control stack, if kept in the MQD, to the given userspace address.
@@ -303,9 +303,7 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
 
 static inline int read_sdma_queue_counter(uint64_t __user *q_rptr, uint64_t *val)
 {
-        /*
-         * SDMA activity counter is stored at queue's RPTR + 0x8 location.
-         */
+	/* SDMA activity counter is stored at queue's RPTR + 0x8 location. */
 	return get_user(*val, q_rptr + 1);
 }
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index d5aa4c30e87d..f1a1f5753e65 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -62,15 +62,6 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
 			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
 				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
 			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
-#if 0
-		/* TODO:
-		 *    This shouldn't be an issue with Navi10.  Verify.
-		 */
-		if (vega10_noretry)
-			qpd->sh_mem_config |=
-				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-#endif
-
 		qpd->sh_mem_ape1_limit = 0;
 		qpd->sh_mem_ape1_base = 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index c8aefeb37a38..8aebe408c544 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -35,7 +35,7 @@
 #include "kfd_priv.h"
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 
 /*
  * The primary memory I/O features being added for revisions of gfxip
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 34a185269ff6..6830a88f0326 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -120,7 +120,8 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	kfd_signal_poison_consumed_event(dev, pasid);
 
 	/* resetting queue passes, do page retirement without gpu reset
-	   resetting queue fails, fallback to gpu reset solution */
+	 * resetting queue fails, fallback to gpu reset solution
+	 */
 	if (!ret)
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
 	else
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..b5323ef4288f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -363,7 +363,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 			if (r)
 				goto out_free_vram_pages;
 			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
-			j= 0;
+			j = 0;
 		} else {
 			j++;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 3f95c4354cfb..5ac209209613 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -101,6 +101,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	struct kfd_cu_info cu_info;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	int i, se, sh, cu;
+
 	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
 
 	if (cu_mask_count > cu_info.cu_active_number)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c354d6bb7553..d3e2b6a599a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -206,7 +206,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		/* GC 10 removed WPP_CLAMP from PQ Control */
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
-				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT ;
+				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
 		m->cp_hqd_pq_doorbell_control |=
 			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 589ee9594728..530ba6f5b57e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -329,6 +329,7 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct queue_properties *q)
 {
 	struct vi_mqd *m;
+
 	init_mqd(mm, mqd, mqd_mem_obj, gart_addr, q);
 
 	m = get_mqd(*mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
index 40971c5ecced..8147395c083b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
@@ -102,8 +102,8 @@ struct pm4_mes_set_resources {
 
 struct pm4_mes_runlist {
 	union {
-	    union PM4_MES_TYPE_3_HEADER   header;            /* header */
-	    uint32_t            ordinal1;
+		union PM4_MES_TYPE_3_HEADER   header;            /* header */
+		uint32_t            ordinal1;
 	};
 
 	union {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 08df70452379..16ae6eb3ac7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -794,7 +794,7 @@ struct svm_range_list {
 	atomic_t			drain_pagefaults;
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
-	struct task_struct 		*faulting_task;
+	struct task_struct		*faulting_task;
 };
 
 /* Process data */
@@ -915,7 +915,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev);
 int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 struct kfd_process *kfd_create_process(struct file *filep);
-struct kfd_process *kfd_get_process(const struct task_struct *);
+struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9d10d0c04ecc..3bdcae239bc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1442,9 +1442,9 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	}
 
 	/*
-	* Overwrite ATS capability according to needs_iommu_device to fix
-	* potential missing corresponding bit in CRAT of BIOS.
-	*/
+	 * Overwrite ATS capability according to needs_iommu_device to fix
+	 * potential missing corresponding bit in CRAT of BIOS.
+	 */
 	if (dev->gpu->use_iommu_v2)
 		dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 	else
-- 
2.17.1

