Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA52ACD37AC
	for <amd-gfx@archiver.kernel.org>; Sun, 17 May 2026 05:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5893E10E056;
	Sun, 17 May 2026 05:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3D3HDhdP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D979510E056
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 May 2026 05:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J35GVbuxYfJLn/uZMKXAP6Y43dc6nPaHn2j8XfXWadHhYMXp3zsVSe5aAVXsNrYz/r0HVHmWu/zFIzb3HVSU8wNq/HdrGtNLWe67bX2DJyorIGLWgojuqNXl7eaDrI8d3qITpUneEZe1HUp51InxBknWuZEHSOhcyckC72hQUdsCIoQGI1n1i219oYGUtk/I+7V1SXBmTwE4HT9cWacqiAImx+FzsnmYoL4tRK62fqp4jJXJjUbhI14WG4WnIFBbv6STKMT84sy9hGHlVdeIVha0558gdLgc5X7AsFc3DWrBvVVfDwF/v15rnM7EL1JGEj7+OJJoy7Wq1C+LNy7OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3AfXa5M094nyPdGCVYH4nKoaCSJ2EFxW395zCDezKg=;
 b=NZxHDUn+/TsdFsI/JQvxZcBvim7hBpEEmpvRl43koZqfYgIVV9RIISgbNNRcLJrHhsewI3N41hssqaKSFAerNoMR/n8uPHSQWHPcX0+Qi7ZPIFvrMRbHcqsGggYF6E5hJk7k4nStVZ+GvAht9gGCiYtRxMY2ZmfxvkQp0TgREsEPWRdsiWMAMcrYqEfGB282SbXzaEUKQpbH88+BesCIMOHmUYACr64c0H+AhZaACobAZ4T+XDkrHmriPj1UKVt5UKU5CSfXAHJkFXlU8maFxdJnFLRisJu4VQgV1foxDFlvVXJWa7haKNjWYNZM5G2VL2Ha05q+xJZYSuL3yoJgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3AfXa5M094nyPdGCVYH4nKoaCSJ2EFxW395zCDezKg=;
 b=3D3HDhdPgthpdS37q2lg5D+DCdGdOwTcal4MMHc+JsOpm50nJ05jdIhAWaVYcHUf6enDn0ZCWej7CpAoSD2ZsuJZYGr6jOVIVRCSBeJORVu6x0xCGm53EI2PzFoiVu4tg/p75aUEvahdqdBRypdRf+7jsyXTkLPlc37PupBoxNc=
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 05:27:06 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::51) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Sun, 17
 May 2026 05:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 05:27:05 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 00:27:02 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, <Kent.Russell@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: add ioctl to handle RAS poison error
Date: Sun, 17 May 2026 13:26:49 +0800
Message-ID: <20260517052649.1514840-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: f47487a0-8e32-41b4-5402-08deb3d4ef2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|56012099003|18002099003|3023799003|13003099007;
X-Microsoft-Antispam-Message-Info: 3rV0FurZ55KRBj5l40iXjBKE+tF4loEa78u+QtP0qZV9Znoc1xcZ8h8OqRcVWn6tr4HDukJFHUEp/nq2sfva9f9is18ZPnpSvikL7hCRD/6khxrLvw2AmFwFwQKhD7x/MxlTFQ2p0Ho5511RUaYGK6T4JJOoN74TIZawgN7XuKwXm57K0ac2EjgN/8CNLVVpTMVwVYsXzBARqWn9OQfDU0UMg0HCg4yT5q1Qi+mFMfFdvWvTGNhS5fc4Btb7WMxehoaoClDKwm18zEXMBM/6PjTQMCnRvKsbxfefMxHNFTrBSXub/ODBMD98QV8R988fd6sFyBWk+awAao0fzzc5cKnmqTnE8ea+abkvEU0fOq1CtIirzZ6+l7TpeR+5b0zDtVWPPAwB1nBFYRq/4cp07nH9WeoaVZWqLWFBD/PKiiX0Z4xPClPTrTZqp1dR67LjriZ1xAba97wniArrYxuzObC2QG8V6OTydYVNS4JvLwUdz+4byg0qdZoDWu0eHgO1Wmbr1rBSXRspPTiYsnIEtnJ7ZfUvtZHd3Q3fwiWSLISEO5Om4G55UD06h5IC2VYDG+EMp6j3FH7qOwxN2N7V7DUXd5impIHkNyklKftG1D35l4SWwaNV5KZ3eZgn4Dg0sS5Lov4sqjgL55B1BsHdLtlG8vV8TPdzkD/4ntitKJYrzXfGRNIx1RDmTd/EJwofJ6CzKyR6jyeaAJwEEjFlD9p/XsjgBv35qOTJAvly5RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(56012099003)(18002099003)(3023799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1BPGheTfG7MqULpsBuT+QWherkX/nZWbKgTlhVETQvH6NZ0wuC7eXy5ekLdrjy4PZUEk/HrPgt3rXNO/UekFC4xldJrboJq/90Oxp5IPTphgfXSaYxjUZukcNVPHMxBW8nz85DYHfo6ekNVpFTBzIVlPw+TDfUWu3pqZBkENt1CspQ6WY6Ex3OVr6OQoIrsqgc0DPWH3FGAF3cv00m8L+Xfl7g8bh2Bwx730z1FWAsdGxWyP88SurKlpHVdJWVDub8LJDUC9FB4OL+kJriFDf9xhMyx0IJfOgUBnyeTz26q2nvf8SLHrZzuSEBaJLpR+9oiUW4mg7IcguHv/nVh0gpBBT8oOAzS/J0q/jrXbBQ80/AKNUpK2dX4Z1/mRumXEtwGhwwMRM0qz3Tctow4tC5OgT8MsYD5WMdLLQJW5yTtLVN2nPDRvgugxHU1O+DkK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 05:27:05.8715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47487a0-8e32-41b4-5402-08deb3d4ef2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 118 +++++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h           |  24 +++++
 5 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..0408476f1070 100644
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
+	 *   0xFFFF - suppress SIGBUS delivery
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
index e9be798c0a2b..200570401f51 100644
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
@@ -1337,6 +1339,119 @@ void kfd_signal_reset_event(struct kfd_node *dev)
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
+ *   0xFFFF - opt-in, never escalate to SIGBUS
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
+static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
+{
+	u16 result = 0;
+	int i;
+
+	mutex_lock(&p->mutex);
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct amdgpu_fpriv *drv_priv;
+		u16 v;
+
+		if (!pdd || !pdd->drm_file)
+			continue;
+		if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
+			continue;
+
+		v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
+		if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
+			result = v;
+			break;
+		}
+		if (v > result)
+			result = v;
+	}
+	mutex_unlock(&p->mutex);
+
+	return result;
+}
+
+static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
+					 struct kfd_process *p)
+{
+	u16 delay_ms = kfd_get_sigbus_delay_ms(p);
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
@@ -1345,7 +1460,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	struct kfd_event *ev;
 	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	int user_gpu_id;
-
 	if (!p) {
 		dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
 		return; /* Presumably process exited. */
@@ -1391,7 +1505,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
-	send_sig(SIGBUS, p->lead_thread, 0);
+	kfd_signal_sigbus_with_delay(dev, p);
 
 	kfd_unref_process(p);
 }
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..e88d7cf53858 100644
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
@@ -1673,6 +1675,28 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+/*
+ * Definition of user options
+ *
+ * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
+ *    0:          Disable sigbus delay - SIGBUS will be raised immediately
+ *    0xFFFF: SIGBUS will not be raised
+ *    other:      Set the sigbus delay in milliseconds
+ */
+#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY		0
+
+#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFu
+
+struct drm_amdgpu_user_options {
+	__u32 op;
+	union {
+		struct {
+			__u16 value;
+			__u16 _pad;
+		} kfd_sigbus_delay;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

