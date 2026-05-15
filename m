Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA46CD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 13:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D23110E160;
	Fri, 15 May 2026 13:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="McpgN/FD";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E908210E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 13:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBU/SCRR6q7A3Sldusn+yryTvopjdQAoAC1c8Osq02Bd+IhayNurAum07Wugk7mN+HzbAcRES8V4GKK/rT8QN/iSglIrBdj0p+gC60jqWWlRz32VH3Z6J9YTxBhqnkYmpUsxR+vjSr9wB3yWaa0LjrTEwG4dcQgR8ijhNqEwB3GaNRfOJFjCCjVcF/2k46kKieBHEPGdJUMXF9nL8JR7jgBRlzl5O/2dX+0YFvnPlomv8deRB6k+CoHwgtIOncAz2Y+DkvHxjwKo34HOumnhMRG6E8DTpnCw2oVG87PYOMjX2AxabQh3p/1jE9ObZgMs10j1tkuqvWA+yblS48xJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Raz8tZk2IeziuHD6SAmCY/ZBQjMQdrqaysBcb4JyLoU=;
 b=kDLJ43hx6lrT7PfTlz5ry+Pu0hZThF4QEYq2FgM7CTvj/G92tpNyCfKWM2cE6Vp/zV0LshdlvmX6RSUaUHFPkkZnoV6UwCn9SKNTFQs5uEHl8Z2G8+5IKDX2IUHoyDSRK0+c+XZOrXk2rYvvzcZbzosfPdaOZ8oSYl6aaDfWt4/dzRvcFYZghA64WrLL2KaK1q4aTy1aHkFMjzzrGYndI9UyD8Z6HkSuFQZSjwUGd5tVgTNBtNb/C8hDAG3/6rxHGtgOMG4PTlR42xU81mb/FEJVyP1KvpQWEEvlPbN3HA3HMlXNyELh34YjTd0c9drvSLhYZqbW8VYdHcC8M/LHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Raz8tZk2IeziuHD6SAmCY/ZBQjMQdrqaysBcb4JyLoU=;
 b=McpgN/FD7CD42j/lfjXxWfSEtoq9IqGNOCc5y6t7OLadaOuXVe13BPpGdQvGJrDhayOnxEHoJ13rbL9n3ni2z6vDV/rXdV4n4xylzDawk27gZkEV15TPQqngZylNc7ilduphmwhfWi/EmubYHlsnqBbTvt2m/MaLNB6Pey+CjE0=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 13:27:31 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::c3) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 13:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Fri, 15 May 2026 13:27:30 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 08:27:28 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, <Kent.Russell@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
Date: Fri, 15 May 2026 21:27:02 +0800
Message-ID: <20260515132702.1494187-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f54353-a075-43ac-73a9-08deb285b741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3CFKc7W86p6aIpgkIFV3p2bHBB6XfZICOKmmLORY8kUly92wMEvLDUYVAN7EeqQFEYbfBDV11YJcTVkIGJdpMEdo8BBGV71xbwrfoPMxhbSx206FXLTNoEmTOkzOhEBZiKyeqA4xdHlfYrKYtXyO67THs11w9iJYLbb2oVTw81bKzYyS649K4HGHTu+uezejJEWRS0n8fn51crHkLSsdcbEajwT1jnvhPZPx5lxznj/G4d6XY/OogZ3IH7IBGGGz6yM0dXpLOoRBsXEZ9/Dj3i8NlN/KiwBfSrFFIL0zhVK/hY5E03AwBmUz96wMpKxKb3F103SUu9/q6HdiNOJEsCmbv9GsazvzQCpLNy0LOwUkNj6GPfd/Y3vg+comBeeafxOXVEXhV+n4RD1dqIgLc7F1gfBA+aV/xNw4QJJp4iXUe+fGvRAu+HjhaAnv82xEx/V8zpRQCiEXwPVbDuat2K3c7OpWYXQIVvSpBTpbdMFvVSED0+FIvHMjM9Axy2CwK60uoULGcooHT6sa97UMSCH752rWORX6agFk/ZvWohBzsbhoSsp6rUfB8hlv6YJ0CWD+2bAE4b0WUKlkJ9mzMuI+/+NfMMqF3gehSYX90V2MYcMs7HeSIlhOp4Q/YzCctzr8ev1K+waOqAGMzx2WsBgUIh0Bj4NnPqTMBpwciePF45BQbsuhx01IkoDgh43Hh9L+dgN/bSlKO8DBHaSYYh1+ULrovbkb9zXKGfzzXGA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799003)(3023799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y/k+wt+Q8HRLn926/QVi8sB++JguxW/V2KcsxkMFGzFV6AS06erxDZw8GEN2PBxDQ4snjzdDSWwAlilGTkQ6mtPBmWC7HwVu2aztA+Y/lT+Lla1BjqItNsngrERFgn0rrefxkAFtdYbW5+c1cZIS/X3N7Ug9+OVe1yXvbuAuSERhBZ9tLwuvA6KLKvPfb1JJlxwGP9spUi5THZk9qpingChGzVRAQpcRWOQS51R7bVv+PoJDPffQaDUbsaE8lAil81zI3CLBzuv9o5Dg0g1+hxaR7g86m25PCuvg+Sd2Ie0pKkT/C1/QklMnNlBTK5aEtzUZmkD7/ZJRHAw0+jByJsz2i19D76Yx9xa0ztAeX0KMgKimJ857BQfEJrkCY6dIfnfKJTxDzHdJV2KhSyh/DPC5lYIF+5bxteju2Y7Bwx7JXFesBRyVxXxUzMEKEAlu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 13:27:30.7693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f54353-a075-43ac-73a9-08deb285b741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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
https://github.com/ROCm/rocm-systems/pull/6148

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h           |  25 ++++++
 5 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..6a5459b59af2 100644
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
index 9f3090db2f16..dfc91d25c80d 100644
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
@@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
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
+			__u16 value;
+			__u16 _pad;
+		} kfd_sigbus_delay;
+		__u32 _pad;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

