Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C87ECD5BC9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 02:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A733010E434;
	Tue, 26 May 2026 02:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLxgpxoN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2F610E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 02:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWu+3T+wfvfkAjF1VikV6cZ6qjHCL+zw5wT2GcSYSLMgqWK56ZorTBiJgb3Eo6WG8RLmZUS4ngIlY1FtEntq2220cPu97lAoXSoFxXh0re23DD1xlzCyfKa2JnexKgG+4uYsmDiCSPotvDV4MRE/94RaOEypRFfi/iQcbLzd1k6lByuRdhlg8kvdicn84nSdOfjuPyW4BZVjA+zpS/CIALYv+MRt0JcggPKDWWPpy2Zd6AvQnI4WIihlEIjPTuhCGVXGNzScXlReVCh5DgMyxLEzjRvtwMq+4EBvpChnaR/yWcgDp1d35YgFN9h6gcOKEIl0ACxcBrf5zXRu6D738Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQOY2laO7iK74QxZ/pcjFuS6ps/8oV+UOjgE9oazCZw=;
 b=WogQTJYAEyLw4nRaFjEPm/a3w92TVI3FitiwcZwZ/PSxlqCWIkwgWJFpKTjcLlzNcJBGGtq7lFwbIKH8MmViTIK18VOhz7JajeD3ZCGAWqYAv1QBZrl3ky5De0tetiyRNlYaDnmlh8awfdljo5axVWLqYjMcgOta7FUF6EtvT0dxVv+vKyJLCH4gDvjQXVwIpRjVPIRSB1d7P1diwnRO2qERmcLHNbWsBCthjjWxy8diJjA5tWJTcP/yZbvDspDXCqvDPm38ak99gNZGexjK5tInMSVGNKcuZDcA+mFp6bRYwZzSh98dBfiPqmTtwRSIF5wWkTI6PqwSCKyOcE6r5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQOY2laO7iK74QxZ/pcjFuS6ps/8oV+UOjgE9oazCZw=;
 b=dLxgpxoNENFn4DtNDPfyi26bgzioxQgPVjo6hzK/OS18awA3zUKj9QxYug61H3ZGcWWzaezGSN7XUzVX1B4QRClzxXma7LMqq5zhPlv80E3fGm7zg/8KfV/dv81nV+S01DgmuDiWkeExyAFwdwOTFsIz2oonT8PhmqhWspYYCkI=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:28:55 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::af) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 02:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 02:28:54 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 21:28:51 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, <Kent.Russell@amd.com>,
 <Lijo.Lazar@amd.com>, <Perry.Yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v5] drm/amdgpu: add ioctl to handle RAS poison error
Date: Tue, 26 May 2026 10:28:34 +0800
Message-ID: <20260526022834.2380471-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9dbe6e-ac06-4a1d-c2d8-08debace8844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|13003099007|56012099003|18002099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: cPHKZz/9sAdITg1l2itJ6yvdMDurAHGVm8x1EaXQuOAAUgoTjae4yziRS3xzZfmEIsb256LWFkirq8Myg/kQyuu4woDhMCLuGaF0vfvy9K0C7BEpmjTL0g5H9Y7eR9Nug2Y2lbxrHtwr6krBwv15+nt7xJfj5FU354zIIZWzAhuMS5iDgsL7WuAIdfdIEbWErug/3PJ2msFB/gdQRwhfADZo2zdSU5aHHm+Qu/82oGhpFNP4nYdaisW7DcrEmtkn5lD1nuQaOIz0PScRoqiB/KgmyHKW2XMavf0kiT0gtOAxskyMZJBJPURCQIubkNuXmHzRUJ4DSrGNl5zon0R2mxOTWI2olIhk8Bn6FH7CbruSvx19Tldv8joXjoUFYW7HJD5FGrO2E6ROs3yhGoAKFO5gKzjgKY7x0w5r9BmsWJNAAq1f9l9Lj3ETvSWQn4PtmetZo8NtLiMEoXxTAdVw/O01PWCp/giOWkxINPSiXLnx6EFRAvhLoWwR71VSTbbpIIes3i8XW1Pzo/Nn9A32W1eN5S9YRxSmdrchF2Yug5y1VZdYWUAXGhpneRNNaqdzwKLJosJAajiiMBOoqRDDSfHVRz8jY78ntjtZJZ2HYKf+4d5FJknsSflfoUzvseNQ2J0tFDzpNX6Rt8bcps8hg+MKM4wAUgRH3tvYwQpg4b+ingIa/v0bw4BcouLyqzMdQ4YtXf2rOU6w0uOVSoUYb4jkPOEiLEBkEtjB1CckBoY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dvzhINCoKDyv1fjQpspN2sL3AcEKZXZ1Ueb+eZmK3+ao+3uCgLHoixdDtSdvTLPzCRsaGWuOATk/p9Q/mdTWLydiAQEVdSI4hSxCFSd/HS/i6woTT+Zo9RVXwzU8kBOZt5sV7SOUzTDCuCrsiRisk0rj8o+em+8NG4otOaD8flhQh/pA/oL08cIlCbyo1QX6SybSilAyPccBUfXDMTlK5kcUl1PW18LRJUNTtkkcBRgS7nER+qk9vYVaErBigKWGtlZ4bYBCb8Dl/K2Umn3WzjICqdHoDm+7YoEB+AADc7ZvixVs6KY+ZLoGku2tfHcWAy7psoXj6XIGcg1K/to9bLpVY3w7rG71cOHoWCW5QKR7xYEnrXn0Oalkx0WJ9ue/UTXbCJL9WEwXWb6XKXHSdzWNZENuf+j5uY6XUBfEy0faxS5JcoQ9fBn34EeY64gK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:28:54.4785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9dbe6e-ac06-4a1d-c2d8-08debace8844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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

Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
to control per-process SIGBUS delivery.

Userspace for this can be found at:
https://github.com/ROCm/rocm-systems/pull/6190

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 69 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 15 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 33 +++++++++++
 include/uapi/drm/amdgpu_drm.h              | 21 +++++++
 8 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..771ec0608270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
+int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
 
 /*
  * functions used by amdgpu_encoder.c
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5333e052d56d..68d83a6e6b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 					uint32_t domain,
 					struct dma_fence *fence);
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
@@ -241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 {
 	return 0;
 }
+static inline
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1781c0c3d010..4d4d21babc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..772e0fda7e14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
+/**
+ * amdgpu_user_options_ioctl - set per-fd user options
+ *
+ * @dev: drm dev pointer
+ * @data: pointer to struct drm_amdgpu_user_options
+ * @filp: drm file
+ *
+ * Sets options stored on the per-file amdgpu_fpriv. Currently the only
+ * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
+ * controls how KFD delivers SIGBUS for poison/RAS events to the calling
+ * process (immediate, suppressed, or delayed by N milliseconds).
+ */
+int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_user_options *args = data;
+
+	switch (args->op) {
+	case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
+		return amdgpu_amdkfd_set_sigbus_delay(current,
+						      args->kfd_sigbus_delay.value);
+	default:
+		DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
+		return -EINVAL;
+	}
+}
+
 /**
  * amdgpu_driver_open_kms - drm callback for open
  *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..92027c5aae61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -29,10 +29,12 @@
 #include <linux/uaccess.h>
 #include <linux/mman.h>
 #include <linux/memory.h>
+#include <linux/workqueue.h>
 #include "kfd_priv.h"
 #include "kfd_events.h"
 #include "kfd_device_queue_manager.h"
 #include <linux/device.h>
+#include <uapi/drm/amdgpu_drm.h>
 
 /*
  * Wrapper around wait_queue_entry_t
@@ -1337,6 +1339,71 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
 
+/*
+ * Per-process opt-in for poison-consumption SIGBUS handling.
+ *
+ * Default: kernel sends SIGBUS to the process immediately when poison is
+ * consumed, in addition to delivering the KFD HW/MEMORY exception events.
+ *
+ * Userspace (ROCr) can opt-in per-process via the
+ * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
+ * option. This lets the app's registered system-event callback handle the
+ * RAS error first, instead of being killed by SIGBUS.
+ *
+ * Encoded value (stored on the kfd_process):
+ *   0          - default: SIGBUS immediately (no opt-in)
+ *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
+ *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
+ *                handle the error in time (safety timeout)
+ */
+
+void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
+{
+	struct kfd_process *p = container_of(to_delayed_work(work),
+				struct kfd_process, signal_work);
+
+	if (p->lead_thread)
+		send_sig(SIGBUS, p->lead_thread, 0);
+
+	kfd_unref_process(p);
+}
+
+static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
+					 struct kfd_process *p)
+{
+	u32 delay_ms = atomic_read(&p->kfd_sigbus_delay_ms);
+
+	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
+		dev_info(dev->adev->dev,
+			 "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
+			 p->lead_thread->comm, p->lead_thread->pid);
+		return;
+	}
+
+	if (delay_ms == 0)
+		goto send_now;
+
+	/*
+	 * Take an extra reference for the delayed worker. If the work is
+	 * already pending (e.g. another device of this process consumed poison
+	 * just before), drop the reference and skip rescheduling - the process
+	 * only needs to be notified once.
+	 */
+	kref_get(&p->ref);
+	if (!schedule_delayed_work(&p->signal_work, msecs_to_jiffies(delay_ms))) {
+		kfd_unref_process(p);
+		return;
+	}
+
+	dev_info(dev->adev->dev,
+		 "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
+		 p->lead_thread->comm, p->lead_thread->pid, delay_ms);
+	return;
+
+send_now:
+	send_sig(SIGBUS, p->lead_thread, 0);
+}
+
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 {
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
@@ -1391,7 +1458,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
-	send_sig(SIGBUS, p->lead_thread, 0);
+	kfd_signal_sigbus_with_delay(dev, p);
 
 	kfd_unref_process(p);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f037062c33ea..ae6d1ecb14d5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -957,6 +957,20 @@ struct kfd_process {
 	size_t signal_event_count;
 	bool signal_event_limit_reached;
 
+	/**
+	 * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option for
+	 * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
+	 * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
+	 *
+	 *   0          - send SIGBUS immediately (default)
+	 *   0xFFFFFFFF - suppress SIGBUS delivery
+	 *   other      - delay SIGBUS delivery by this many milliseconds
+	 */
+	atomic_t kfd_sigbus_delay_ms;
+
+	/* Delayed signal delivery to user */
+	struct delayed_work signal_work;
+
 	/* Information used for memory eviction */
 	void *kgd_process_info;
 	/* Eviction fence that is attached to all the BOs of this process. The
@@ -1554,6 +1568,7 @@ void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
 void kfd_signal_reset_event(struct kfd_node *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
+void kfd_signal_sigbus_delayed_fn(struct work_struct *work);
 void kfd_signal_process_terminate_event(struct kfd_process *p);
 
 static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 419bb8086ccd..dd48ad9a3438 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -992,6 +992,33 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
+/**
+ * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
+ * @task: task in the target process
+ * @ms:   encoded delay value (0 = immediate, 0xFFFFFFFF = suppress,
+ *        otherwise delay in milliseconds)
+ *
+ * Stores the SIGBUS delivery option on the kfd_process associated with
+ * @task. If the calling process has not opened /dev/kfd yet (no
+ * kfd_process exists), this is a no-op - the option only applies to
+ * processes that actually use KFD.
+ */
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
+{
+	struct kfd_process *p;
+
+	if (!task->mm)
+		return -EINVAL;
+
+	p = kfd_lookup_process_by_mm(task->mm);
+	if (!p)
+		return 0;
+
+	atomic_set(&p->kfd_sigbus_delay_ms, ms);
+	kfd_unref_process(p);
+	return 0;
+}
+
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
@@ -1328,6 +1355,11 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 	kfd_process_table_remove(p);
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
+	/*
+	 * If work pending, cancel it and drop the extra ref
+	 */
+	if (cancel_delayed_work_sync(&p->signal_work))
+		kfd_unref_process(p);
 
 	/*
 	 * Dequeue and destroy user queues, it is not safe for GPU to access
@@ -1584,6 +1616,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
+	INIT_DELAYED_WORK(&process->signal_work, kfd_signal_sigbus_delayed_fn);
 	process->last_restore_timestamp = get_jiffies_64();
 	err = kfd_event_init_process(process);
 	if (err)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..ab71c4b4aeac 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_USER_OPTIONS		0x1A
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_USER_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
 
 /**
  * DOC: memory domains
@@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+/*
+ * Definition of user options
+ *
+ * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
+ *    0:          Disable sigbus delay - SIGBUS will be raised immediately
+ *    0xFFFFFFFF: SIGBUS will not be raised
+ *    other:      Set the sigbus delay in milliseconds
+ */
+#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY		0
+
+#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFFFFFu
+
+struct drm_amdgpu_user_options {
+	__u32 op;
+	struct {
+		__u32 value;
+	} kfd_sigbus_delay;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

