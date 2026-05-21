Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B3BCD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 09:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312B710E179;
	Thu, 21 May 2026 09:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zDuZxqFF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4491C10E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 09:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP7n2oGdqkyqYoLWKWUEi7VRzgBzaWhHnTavaIbqSooah1AO6nwoSVXxB4mLQPy58PHlPu1fy7H/vjvqIee0YORjfQYu5I15mLb81tWdp6v2G/fxIP+agBY8yxNWl7Y9uBUUV4GnxwAA67Ay6JpBJ4MKpy7GlmT31jxr2pRAFnuchJyvb5Rb4nmT1FdCazx3i15BtU6E7NTRVEAHVz5nUuzbKuW960PoKJBqznxhkNDWsOzhmy1UcvK15imRUqdoCjSkz+TWESW9RYM/a5eBw+pnH5agVchBCuwIbvlN7LCsINNRTBR4isNfIv1+AMzuApknfxoFwIacgsqsOSjHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=967qMHnwaeTZkuVJbccAn9z/ov6Raa4BwlflzlDgOXM=;
 b=a45rhI5DsVZK4rBI+OL5voXPo33rMHtcninax3/z+VDAO0ItgIQBbo3jT1m3kX9/i41Bc+KeLSOI+IE4SPmyupHHy4fzfbSXqtLhbRoOWQ4MfWIqxJUpypLZbY1ilHL1IIG8MKFfbFx0B1EWgLv2+U848FPLPIYIvJL5SYKGFiceIRQ+6vHJRnvQ9kc/FjCLDc2pXwPaY3b+i9GcmBHzdbiMk1fKznUHJsONF/rEZQ9Y102VmSGMaXERk7ipMOGDQy9ho6ZmpLdU42999MaWU6yzCvmz7ueb4bTzRAFPKQW4yJnDmIwLY2+/cedJDnqzaPx14m3rA1zgG8Z04CTaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=967qMHnwaeTZkuVJbccAn9z/ov6Raa4BwlflzlDgOXM=;
 b=zDuZxqFFtK2zmJ+bqlVff7DTxETFWvnfYeyTasPKw9sNwdFfUKua/dSf0y8h4sRggcWCgiyW7Vo5afcD9zbuwk3TEUU1q0wVuKpQdBJzY0CIwNQlzUBc/Ww0wOQ2zeW+T92Uhi/vX7GF1P0nwfavuvsuPuPDwwlwvG9NLwP5qxM=
Received: from CY8PR12CA0004.namprd12.prod.outlook.com (2603:10b6:930:4e::7)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 09:05:06 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:930:4e:cafe::ee) by CY8PR12CA0004.outlook.office365.com
 (2603:10b6:930:4e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 09:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 09:05:05 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 04:05:02 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <David.YatSin@amd.com>, <Lijo.Lazar@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
Date: Thu, 21 May 2026 17:04:45 +0800
Message-ID: <20260521090445.2292040-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c270c0b-eb85-42c1-5db1-08deb7180ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|13003099007|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: XemCZ2BCPvQYXlqQ882dBnT1gXIBDkguT1zxUQNdIt6OmjNyrX/2kVC2jLgzDIn6H+XbDwz3Mz4yB9CT7LrodFnC1av+D2epgxyPw+FLiU82C+fc7BX1v0U8SW3u4xNoYxKEvYr5gKg9H2Ujg7K/2YES1qtCx2xPOmzDfD61mzQigLdJOfltmpVlegzMPY/YYUDAHrrA0abxoFm1oMB6iPdRncVZh8ozf228rFQz1keMCfNUrN3TJQL7/w2IjDPpno6lvB8wYs4cC2Kf5WD4+tNQUbgRKxlsZraxt6vOlt8Qabvu1gBmb8EzutI5UEgQBbc0JWnxWIMOamXA4AaRNkbeANE0VHurBBM1pwpeEvxX8uICEWgMtRInJSUcr35kjPqPoWYXHta3KOrPZNVPvI+nJ0tqMRjakNoAumHCdf/hew3SN+SzdXeuDwbGu8niwhFBBnDFpstsrhJl9igGzA4zerWAfiMmKa4wXwyd6VpEvWaKXQ6CB45fw8vozkKwBZS5Ncwt8OmsLxAUwcK3WdfmeJxi+m5FIOSSVTS5PMNwx0Z5WS3BcsGw00ti9jXIF+OcDINvxVE/7CH5jOK1BxlWRGMf2+vEZ+mDx4vnxSZAN5enGww5jQes3j71ahIKK3oNcFXsXeEWeAK3ayhPKWhpTt6HECiowGRTU/snIYneL2/FYLYUg+YrUglQVPjjiA0SZbIXjVRLfEKk1Bf8/YHTMNBtlWISB5cvNe3m53g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(13003099007)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gluv5kcFtB6aMBOS1bdSzwp//UviGGUFwww3p6RlbACIYHP+GjSt3Iz0RIsiAFnfhbHZC1bd/M+0qFgYUnTKOaXurABZK8USnQ7UQGRgI3l9m+IQOcWp667GVsRFvHXoWh5t8wVha/JVOf4VGoNGoQmQ16QAPuTd9FGcWwSiFVbFVUqYjhH5rheyv6HUtqY5W82lDMTgIFSh8pFA0OtnO0Nx9lQtcAnlLmjJw0xATA5t6JifEbsJSRGq7+kCEpYMZP+pT2zgYqv1OuBP2A0+jwLk6ZGPUQizucFWKljZLRp1UKv12RpHBGCBVWDvECebCBuAq0wREtdMnjDf7CTYin7FFAQ0MwFKwqirOR+xMsUJhMXmZoB3JS5kLgaUC/M/Rxuzhvvb6TKDS/ZE1jOGxW2DOGV0g0rLSp/guJxfce88UPpnW/AMagpxMFZPOcao
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:05:05.2177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c270c0b-eb85-42c1-5db1-08deb7180ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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
 drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 70 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 14 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 23 +++++++
 include/uapi/drm/amdgpu_drm.h              | 21 +++++++
 8 files changed, 163 insertions(+), 1 deletion(-)

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
index e9be798c0a2b..e7d70e3a7f3e 100644
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
@@ -1337,6 +1339,72 @@ void kfd_signal_reset_event(struct kfd_node *dev)
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
+static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
+{
+	struct kfd_process_device *pdd = container_of(to_delayed_work(work),
+				struct kfd_process_device, work);
+	struct kfd_process *p = pdd->process;
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
+	struct kfd_process_device *pdd;
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
+	pdd = kfd_get_process_device_data(dev, p);
+	if (!pdd) {
+		dev_err(dev->adev->dev, "Process device data doesn't exist\n");
+		goto send_now;
+	}
+
+	/* Take an extra reference for the delayed worker. */
+	kref_get(&p->ref);
+	INIT_DELAYED_WORK(&pdd->work, kfd_signal_sigbus_delayed_fn);
+
+	dev_info(dev->adev->dev,
+		 "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
+		 p->lead_thread->comm, p->lead_thread->pid, delay_ms);
+	schedule_delayed_work(&pdd->work, msecs_to_jiffies(delay_ms));
+	return;
+
+send_now:
+	send_sig(SIGBUS, p->lead_thread, 0);
+}
+
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 {
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
@@ -1391,7 +1459,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
-	send_sig(SIGBUS, p->lead_thread, 0);
+	kfd_signal_sigbus_with_delay(dev, p);
 
 	kfd_unref_process(p);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f037062c33ea..d3fcf07c0ebe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -875,6 +875,9 @@ struct kfd_process_device {
 	u32 pasid;
 	/* Indicates this process has requested PTL stay disabled */
 	bool ptl_disable_req;
+
+	/* Delayed signal to user */
+	struct delayed_work work;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -957,6 +960,17 @@ struct kfd_process {
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
 	/* Information used for memory eviction */
 	void *kgd_process_info;
 	/* Eviction fence that is attached to all the BOs of this process. The
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 419bb8086ccd..dadb7cf7b072 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -992,6 +992,29 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
+/**
+ * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
+ * @task: task in the target process
+ * @ms:   encoded delay value (0 = immediate, 0xFFFFFFFF = suppress,
+ *        otherwise delay in milliseconds)
+ *
+ * Stores the SIGBUS delivery option on the kfd_process associated with
+ * @task. If no kfd_process exists yet, one is created so the option
+ * persists until poison/RAS events are signaled.
+ */
+int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
+{
+	struct kfd_process *p;
+
+	p = kfd_create_process(task);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	atomic_set(&p->kfd_sigbus_delay_ms, ms);
+	kfd_unref_process(p);
+	return 0;
+}
+
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
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

