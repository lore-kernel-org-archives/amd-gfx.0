Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D018CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 13:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C0B10EAE8;
	Tue, 12 May 2026 13:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/qNbfmK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B1F10EAE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 13:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmwO6LEwWAAI6Y2jQ654Z1bAT1kcjina0ddNOePaaSlqeFch5397i2wLIgUoakGiGj+p0WecR5jnZcFFiqpNspqY6iEYCf9EX3qDEL1V/p9azF9Twz8kDrXV3F9BK/kvmqXU4BrUgarEoesBu40CFbkPLyvOCMhiI5KZ7X7pM/mBms/OxtGITazysBAa7MBmp/fiywLDw4fTCsK5NX9Hbmnq9BWKc5y5QDYp1TXKhjM9lG5og4NLDF6SKnTlSf8YKpOQABW/37Nzdy7UBrhzu8z3AJm0fcfm4idaNSO96upzz5dSfUIHzs87jRyKEoAHYcv8H/758rxkXdXmrj+vWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6jD7Bl7LkWcImLpV1o+M3/60c2EJ5tivIBdsuR5tOU=;
 b=uxdEEBcZhTn5RRN6etOBwMW/teaDYqyHRYOHfY2dXFTxiKklg8rO8Uhwh7cHOOg/5pXMsLfTbYqc/GeZnZZyE6Cp8vt0WSEZyuBujroeuhwG2GVMk3oWI5aNNLF5clnXXHZkUBhCSx+ul+LbcY6XUpPqfvhB6oiyEWKFAA/nFiXWj48pYpVqmtQ+t9P5qOP/jpwl3c5FUcN5O9RpIoq4pmgXDPDVoK4NeHSL6DT9THcdEMiHkrhfb9DL0ArFsDUHZgzpmHTtb0QKk//U5Z7+j/JZdhk5snoav3s0Ys5MdgV9pI8I7mk9RqsEk4B/Rs8ddsjNup3RVchI06FyEBhZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6jD7Bl7LkWcImLpV1o+M3/60c2EJ5tivIBdsuR5tOU=;
 b=k/qNbfmKBeUXKfT1H6jbL7USRkNt+xfZkV2dIrBtsfL2dAPmFtsEhJyxMyJFiWMCAHz/X3SnA4HTuonr3zqSGSCd7sVW7nopO8Tm8bxVllDwjcTGEVturbTa/IMKMQeE4oC0SoRZVypq8RBp+94Gn0JlXGxgGr8RpLiAkYRglxE=
Received: from PH8PR22CA0017.namprd22.prod.outlook.com (2603:10b6:510:2d1::13)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Tue, 12 May
 2026 13:12:21 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::cf) by PH8PR22CA0017.outlook.office365.com
 (2603:10b6:510:2d1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 12
 May 2026 13:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 13:12:19 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 08:12:15 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, <Kent.Russell@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add ioctl to handle RAS poison error
Date: Tue, 12 May 2026 21:11:49 +0800
Message-ID: <20260512131149.1440454-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c709f0b-e8f7-4d7d-99d5-08deb028192a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|11063799003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: MHZlAWVb4sPOPU+S8T5wJHXZpGSB0Qh96WrRX9XWZ6KW8YBNF8bnj+jE6YwYWI2Ia7UnongUaIGIT3eIaPB9LnL6c7VtTp3XlJWd6LJfaJsX7zaPeKl6VpPZTubOywfMkMSHi2VTVvLdZLVW7/atntdR1mPzju88emcwTjytYfy92U/h40H+E0p65RX8W4dqvK7L4FrG1NxyAqUKunbj+45JCKPNXE+P/3ZRklzyxU145kv1crz2GfamvB32/3VDpdab36dKaVN4mOIprDhNMAQQIII3ZALeFVtik5sLCE5pHcxuvcKHWZ/j1iNe8FEy45Pam07FN5iqZIyVzTTh3/ScbQEToJ0NPUKgj/YvdxiClDCChJ04pI/WFQ91QSHVR0qh1dxrMubP8mXYApuKyICbpPnNgCzlCd8U/dIqomzAZJEVB8M0jjcJJouFi/k55Sf99Lv+kL81ilWeqarbN+Htn35Oy3UtPvEmXM2X6PP08svwBfeJ21OhMW6weBPGhqqYRQPw0m/I9DiFNjVs3QgKSymKxubmi/Ug5AlmxVTikM/tzhekZMsDnn8Re2531GzbW3ga35FafYY++Yi15VjSaKzCLUZ0H0zA8DZLvg9UkIC9RI422NtQSglxpIMnnvp/3APNcj3SEUWLwaCm/ykj9d0wzo2vK3BDmApJsXvIIRSySD20wlhqqJXr46vC7gR8UitzfUMiiqdYdY1xnPjEcPRK4ilKUgA1BnDX5gM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(11063799003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vp5sXUCc52YhxWeVy+DSkGRMTN25SgBjeNZwPCUQ89fJG12KjbyG+2t2I3yf4EfvHE8ujdVa7s1fpr9gAqX8sygBIr0HV0VbWstB13LWeAde2QWOEehdWKTFJ1y0ED3ScUvnnvaKlWdYBS/TYWhfHcOeqEvSMyEWqDB0kfXuzFEQnGENLIYj8845CyBZr5KTme2fA7PIbIZcKwob3DjL+/2mBf/mQtPSOqV3v9P44/qDb1dOn44HOTxjpHU7iwAaMeCz+GLzqa1HPnvXYBOStEjHRg/Ucx8ia2ImqANVidLWN4J3h9lZbrsC7NX6lErORjR++KJnXRGxsj4fnj65orXOkdhesgpqzUC+Eaw9ZShwd2cQOhOBQd9HRqlMomZoIib7k7XheTXOuOvqkfWczfJDydUY0U/a1p360K0teeO5IzUXdLMT4yxaKgkicy+G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:12:19.9715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c709f0b-e8f7-4d7d-99d5-08deb028192a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
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

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h           |  23 +++++
 5 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 80b18bbd7f3a..653a2a516e18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -455,6 +455,16 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	/**
+	 * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
+	 * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
+	 *
+	 *   0          - send SIGBUS immediately (default)
+	 *   0xFFFFFFFF - suppress SIGBUS delivery
+	 *   other      - delay SIGBUS delivery by this many milliseconds
+	 */
+	atomic_t		kfd_sigbus_delay_ms;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
@@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
+int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
 
 /*
  * functions used by amdgpu_encoder.c
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 99688391e70b..cad18bd6f8b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..7903587b8bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct drm_amdgpu_user_options *args = data;
+
+	switch (args->op) {
+	case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
+		atomic_set(&fpriv->kfd_sigbus_delay_ms,
+			   args->kfd_sigbus_delay.value);
+		return 0;
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
index e9be798c0a2b..2ff6348105b7 100644
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
@@ -1337,6 +1339,115 @@ void kfd_signal_reset_event(struct kfd_node *dev)
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
+ * Encoded value (set on any of the process' amdgpu render fds):
+ *   0          - default: SIGBUS immediately (no opt-in)
+ *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
+ *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
+ *                handle the error in time (safety timeout)
+ *
+ * Per-process scope: the option is honored if ANY of the process' amdgpu
+ * fds has been configured. This matches the slide deck's "Per-process,
+ * App set at init" semantics, while keeping the UAPI on amdgpu where ROCr
+ * sets it.
+ */
+struct kfd_sigbus_delayed_work {
+	struct delayed_work work;
+	struct kfd_process *p;
+};
+
+static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
+{
+	struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
+				struct kfd_sigbus_delayed_work, work);
+	struct kfd_process *p = dw->p;
+
+	if (p->lead_thread)
+		send_sig(SIGBUS, p->lead_thread, 0);
+
+	kfd_unref_process(p);
+	kfree(dw);
+}
+
+/*
+ * Resolve the per-process SIGBUS opt-in setting by scanning all of the
+ * process' KFD pdds (each backed by an amdgpu render fd). Returns the
+ * "most lenient" value across all fds, in this priority:
+ *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
+ *
+ * Rationale: if the app has explicitly opted in on any GPU it uses, it
+ * wants the chance to handle the error in userspace.
+ */
+static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
+{
+	u32 result = 0;
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct amdgpu_fpriv *drv_priv;
+		u32 v;
+
+		if (!pdd || !pdd->drm_file)
+			continue;
+		if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
+			continue;
+
+		v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
+		if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
+			return v;
+		if (v > result)
+			result = v;
+	}
+
+	return result;
+}
+
+static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
+					 struct kfd_process *p)
+{
+	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
+	struct kfd_sigbus_delayed_work *dw;
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
+	dw = kzalloc(sizeof(*dw), GFP_ATOMIC);
+	if (!dw)
+		goto send_now;
+
+	/* Take an extra reference for the delayed worker. */
+	kref_get(&p->ref);
+	dw->p = p;
+	INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
+
+	dev_info(dev->adev->dev,
+		 "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
+		 p->lead_thread->comm, p->lead_thread->pid, delay_ms);
+	schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
+	return;
+
+send_now:
+	send_sig(SIGBUS, p->lead_thread, 0);
+}
+
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 {
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
@@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	struct kfd_event *ev;
 	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	int user_gpu_id;
-
 	if (!p) {
 		dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
 		return; /* Presumably process exited. */
@@ -1391,7 +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
-	send_sig(SIGBUS, p->lead_thread, 0);
+	kfd_signal_sigbus_with_delay(dev, p);
 
 	kfd_unref_process(p);
 }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..e0a382673b90 100644
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
@@ -1673,6 +1675,27 @@ struct drm_amdgpu_info_uq_metadata {
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
+	union {
+		struct {
+			__u32 value;
+		} kfd_sigbus_delay;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

