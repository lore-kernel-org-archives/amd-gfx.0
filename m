Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ACDC44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329D910F304;
	Thu, 16 Jul 2026 13:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOIHMJnd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B3A10F304
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frwz1xPJJ0tSRtKQ/GfgSaZjB/0234BsEShHnesg8FOhDu1T4tNawfIKKvaLjHqgqv4msiwhMMTNxv30tm4t4UrNuoBzNE88BzgSMwLJAccsVzDvnhnW854dZ2JAfIbg1dNJqP+p8g+P0QRX9zdS4qdjWank719XTLxSt8mdyDB2v9fclul4DYnMWi6ramQL8PDVl04gbhSdibtWtiK7Y+3Bg3mpxUqt7A9jkAkLxI5ErmOV8DJrq4Rb/n/3cIF4nYj4msdSrPrjw19EXjm4GSdNw5rOFI9e50n7QIGxBnS0nfUkxq2u88No+W2ptl50l8oxIG4a9aLmOIHrwpHFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsYVFT2oeObcvshNmzUWsmdBl05OsVX7jobM6cIIe2U=;
 b=XKkCcOp7o8QYeEjkbi4cmSx6PVuGKFbgBhZKzUJKPN/f1UGms56tKDF/XwfWzUcdiy2M3U+YbqE6lxVzoeUyY6zCJUz/DlgH7pA2D9sBZ4B8kHa8VVCQ6VKhP21uhcNEil/AxnZWBrXDdJNxSDPxVN2zjWf/F6AXceUvDzoQhNrh6bKMMLnwl3PQ+DdCA+MT8eWUu2KQ6hwrBxDI6Zik33bYM5QgCkeCkWkIRdQWC/4D39ZPIHC8Eg8GUF49aAv7c6+cjUN9X+7QknIPcUW5KXI+looxS54jgtwup84XoFy+0sSfCwgLKowcGMLFFp2P00ykfNjjMsCKntO7UsTGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsYVFT2oeObcvshNmzUWsmdBl05OsVX7jobM6cIIe2U=;
 b=eOIHMJndi/Jc7Lf+7s+ruyQZGbnXJowgSMMtD3s8NTDoGDb3RUo25JwZ7R1jz1LN2Z/t9OlaPwLsuIBf2TrLb7ztKQRvgSknKt75TmCxZsKOlW2OUuNZ2XcBgxTSDstwcA4iNhH9OgIq9Lgwmb3y/eCmWEAlRJEP0tgAGLXHiJE=
Received: from DSSP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::9) by
 LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 13:21:32 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::8a) by DSSP220CA0010.outlook.office365.com
 (2603:10b6:8:3d3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 13:21:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 2/5] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
Date: Thu, 16 Jul 2026 18:50:57 +0530
Message-ID: <20260716132100.3496327-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 691a52ca-06dc-42e5-9558-08dee33d26dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|5023799004|56012099006|6133799003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: /fPTzgg5cQADpWimSdi9Upv6N7UK8Fef5dGB3n19tOKjFeWEl3PzY5rU7P0Hj9Jynx5igMc1eU/PVnCnIJ1U+WlNkHKRkVppiySCxUTkzcPrtb+SpYf2ZFP/2Id9e3Thrmokaa6QywzJ8G9ou/eUPgvNWGa+gbhjlKzFzCK/t5o/VHO82vBGy0LbGxB8De5q4R29hZQHdo/jCg1mpgfoYcqlKoWDEObg638ypOQ0yW7i1lVnYWRCOrL2KOhCWlmFrirV4WZNCmL5oz5JOLbsc2yaXjhi8VKP7yPVpFp+RGq0uRTVXJybbE33o25Eoov2e95m/NDmZUcDZeziFV+d1uKne3Rauaxa1bJD6Htr26sS1WDrur4nIgQtzrEcVNgh4Pv7mCsKqv5eaE4M+bxuEvcBoxvpe2itjBhAxbc10qKc80iswqCo8OzhPvMH8Ean4t3HZPd5a5Coszm4RqxbEA1fejgOvwmXNDeA1x9xYUuKjvOlxODoqWy+HpeQ2cAcPT+EG4cF2Ir7aOpiahARkX+qAcrLrSDBR9mIh2/wCkGSPTR+PgMSOA1OpVggBfIZyND5J3yc8b7rWMMT8Ky2ZCQqeQhntIsPoug3pAdZwPRuPWk02h89+30NzQnx9i88E6im3tblTASvXWuChxgbzUJvQUXltZ8xbXgtOqqRW9d3gcq37SfjvjmqzCc1fRbYSNLFNDt0+FiEiKdIJovL2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QbUdVjSq8wy8PC91T1MD0vzWDAySB/bmBEVujp5BB1onVgjIlkDjA9jnHR2cjQKQsLMf+M4Ransf0D8ox5Mf1huOQTUdhTbsl9kgaE9OjXbwXMLrgu/DumBIyVd3b3sf7zh3VdfxO4qHsaIu1b7bKHc9HN3RJTTootfJFhyDvt237u/AcSYQEvTVjnizG9lecvnJgoa9Cn8slHvUU2sK2tC8sLCquHJ0WssnDNsTcvysn/1UG7oWDnQ0gYE+SRbdZCycUSDZEK2JhLdJBIZ29xxzsnQCoOfq8v3fYRt/tIeR9TS60HgwNv+mNBCkkCEBkicPbfIRBQ1fZNTXOc7rHkxrLJvSsmjlNDR77RyD5u65LQoHy9Hhp+lEQxjPRndUhWKlwbCk4SAXblVMRGUmZzwmhx/neGHRdr/8pITzncCY45bOWZSKL4wVqXH0hOFe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:31.6971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691a52ca-06dc-42e5-9558-08dee33d26dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

Add the per-file WAIT_EVENT manager and lifetime plumbing used to store
and retrieve event records for render-node clients.

The manager maintains a list of pending WAIT_EVENT records, supports
blocking waits from userspace, copies the first matching event record to
userspace, and enforces single-consumer semantics by removing records
once they are consumed.

Register the WAIT_EVENT ioctl so render-node clients can access the
per-file WAIT_EVENT manager.

For queue-scoped events, queue_id is resolved to the corresponding
usermode queue object at the ioctl boundary. Pending records are matched
internally using queue pointer equality, while queue_id remains a
userspace identifier used only at the UAPI boundary and returned in
event metadata.

WAIT_EVENT uses an absolute CLOCK_MONOTONIC deadline for timeout
handling. The remaining timeout is recomputed after each wakeup so that
interrupted or spurious wakeups continue to honor the original userspace
deadline.

Pending WAIT_EVENT records hold queue references while queued. Those
references are released when records are consumed, explicitly removed,
or destroyed during manager teardown.

Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
drm_file. During teardown, the manager is marked dead before pending
records are detached and blocked waiters are awakened, preventing new
records from being queued while shutdown is in progress.

The USERQ manager is torn down before the embedded WAIT_EVENT manager is
finalized, so queues are removed from the producer lookup paths before
the manager can go out of scope. This existing teardown ordering
provides the lifetime guarantee for WAIT_EVENT producers without
requiring an additional manager reference.

Changes since v11:
- Use an unsigned absolute CLOCK_MONOTONIC deadline.
- Recompute the remaining timeout after each wakeup.
- Preserve a zero timeout as an immediate check-and-return, as suggested
  by Christian.
- Remove the MAX_SCHEDULE_TIMEOUT special handling.
- Simplify queue reference cleanup using unconditional
  amdgpu_userq_put().
- Clarify that queue pointers are used internally for event matching,
  while queue_id remains a userspace-only identifier.
- Improve kerneldoc describing manager state, event matching, and
  teardown ordering.
- Document the existing teardown ordering that guarantees the embedded
  WAIT_EVENT manager remains valid while USERQ producers are active.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 410 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 +++++
 6 files changed, 521 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b7897f98436c..c4cee6a6bc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o
+	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o amdgpu_wait_event.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4f42888e2647..91f1dc737aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_eventfd.h"
+#include "amdgpu_wait_event.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_lockdep.h"
 #include "amdgpu_cper.h"
@@ -427,13 +428,15 @@ struct amdgpu_fpriv {
 	uint32_t		xcp_id;
 
 	struct amdgpu_eventfd_mgr	eventfd_mgr;
+	struct amdgpu_wait_event_mgr	wait_event_mgr;
 };
 
 struct drm_device;
 struct drm_file;
 
 int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
-
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e90cf67c1cd8..b738a1bdf9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3097,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ccc9c3f8aba7..72bea83d7408 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1681,6 +1681,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1754,6 +1755,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (pasid)
 		amdgpu_pasid_free(pasid);
 
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 	kfree(fpriv);
 
 out_suspend:
@@ -1784,8 +1786,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
-	/* Drop all subscriptions before fpriv goes away. */
+	/* Drop eventfd subscriptions and pending wait-event records. */
 	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 
 	pm_runtime_get_sync(dev->dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
new file mode 100644
index 000000000000..7060828be08d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/jiffies.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+#include <linux/uaccess.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_internal.h"
+#include "amdgpu_wait_event.h"
+
+/**
+ * amdgpu_wait_event_deadline_to_jiffies - calculate remaining wait time
+ * @deadline_ns: absolute CLOCK_MONOTONIC deadline in nanoseconds
+ *
+ * Convert an absolute CLOCK_MONOTONIC deadline into the remaining number
+ * of jiffies.
+ *
+ * The caller recalculates the remaining time after every wakeup so that
+ * interrupted or spurious wakeups continue to honor the original
+ * userspace deadline.
+ *
+ * Return:
+ * Remaining wait time in jiffies. Returns zero if the deadline has
+ * expired or if the remaining interval rounds down to zero jiffies.
+ */
+static long
+amdgpu_wait_event_deadline_to_jiffies(u64 deadline_ns)
+{
+	u64 now_ns;
+
+	now_ns = ktime_get_ns();
+	if (deadline_ns <= now_ns)
+		return 0;
+
+	return nsecs_to_jiffies(deadline_ns - now_ns);
+}
+
+/**
+ * amdgpu_wait_event_valid_type - validate a WAIT_EVENT event type
+ * @event_type: kernel-defined AMDGPU event type
+ *
+ * Return:
+ * True when @event_type is supported by the WAIT_EVENT UAPI.
+ */
+static bool amdgpu_wait_event_valid_type(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * amdgpu_wait_event_record_free - release a pending event record
+ * @rec: record to release
+ *
+ * Drop the queue reference owned by the record and free the record.
+ */
+static void
+amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
+{
+	if (!rec)
+		return;
+
+	amdgpu_userq_put(rec->queue);
+	kfree(rec);
+}
+
+/**
+ * amdgpu_wait_event_match - test whether a record matches a wait request
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ * @rec: pending event record
+ *
+ * Queue-scoped records are matched using queue pointer equality.
+ * queue_id is used only at the UAPI boundary and as returned metadata.
+ *
+ * Return:
+ * True when @rec matches the requested event type and queue scope.
+ */
+static bool
+amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
+			struct amdgpu_usermode_queue *queue,
+			const struct amdgpu_wait_event_record *rec)
+{
+	if (rec->data.event_type != args->event_type)
+		return false;
+
+	/*
+	 * Queue pointers are the internal matching key. queue_id is used
+	 * only at the UAPI boundary and as returned event metadata.
+	 */
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
+		return rec->queue == queue;
+
+	return !queue;
+}
+
+/**
+ * amdgpu_wait_event_has_match - check for a matching pending record
+ * @mgr: per-file WAIT_EVENT manager
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ *
+ * This helper is used as the waitqueue condition. It does not remove the
+ * matching record.
+ *
+ * Return:
+ * True when a matching record is pending.
+ */
+static bool
+amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry(rec, &mgr->pending, node) {
+		if (amdgpu_wait_event_match(args, queue, rec)) {
+			found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
+/**
+ * amdgpu_wait_event_pop_match - remove the first matching record
+ * @mgr: per-file WAIT_EVENT manager
+ * @args: WAIT_EVENT request
+ * @queue: resolved queue for a queue-scoped request, or NULL
+ *
+ * Remove and return the first pending record matching the requested event.
+ * Removal provides single-consumer delivery.
+ *
+ * Return:
+ * Matching record, or NULL when no matching record is pending.
+ */
+static struct amdgpu_wait_event_record *
+amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec, *tmp, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		if (!amdgpu_wait_event_match(args, queue, rec))
+			continue;
+
+		list_del(&rec->node);
+		found = rec;
+		break;
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
+/**
+ * amdgpu_wait_event_get_queue - resolve the requested queue scope
+ * @fpriv: AMDGPU per-file private data
+ * @args: WAIT_EVENT request
+ * @queue: returned queue reference
+ *
+ * Validate the requested event type and resolve queue_id for queue-scoped
+ * events. Device-scoped events require queue_id to be zero.
+ *
+ * The caller owns the returned queue reference and must release it with
+ * amdgpu_userq_put().
+ *
+ * Return:
+ * Zero on success or a negative error code.
+ */
+static int
+amdgpu_wait_event_get_queue(struct amdgpu_fpriv *fpriv,
+			    const struct drm_amdgpu_wait_event *args,
+			    struct amdgpu_usermode_queue **queue)
+{
+	*queue = NULL;
+
+	if (!amdgpu_wait_event_valid_type(args->event_type))
+		return -EINVAL;
+
+	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
+		if (!args->queue_id)
+			return -EINVAL;
+
+		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
+		if (!*queue)
+			return -ENOENT;
+
+		return 0;
+	}
+
+	if (args->queue_id)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * amdgpu_wait_event_mgr_init - initialize a per-file WAIT_EVENT manager
+ * @mgr: manager to initialize
+ *
+ * Initialize the pending-record list, waitqueue, sequence counter and
+ * shutdown state.
+ */
+void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
+{
+	spin_lock_init(&mgr->lock);
+	init_waitqueue_head(&mgr->wq);
+	INIT_LIST_HEAD(&mgr->pending);
+	atomic64_set(&mgr->seqno, 0);
+	mgr->dead = false;
+}
+
+/**
+ * amdgpu_wait_event_mgr_fini - finalize a per-file WAIT_EVENT manager
+ * @mgr: manager to finalize
+ *
+ * Stop new records from being published, detach all pending records,
+ * release their queue references and wake blocked waiters.
+ *
+ * The manager is embedded in amdgpu_fpriv. The USERQ manager is torn down
+ * before drm_file postclose invokes this function. Queue teardown removes
+ * queues from producer lookup paths and drains queue work, so USERQ
+ * producers can no longer publish new WAIT_EVENT records before @mgr
+ * goes out of scope.
+ */
+void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
+{
+	struct amdgpu_wait_event_record *rec, *tmp;
+	unsigned long flags;
+	LIST_HEAD(removed);
+
+	/*
+	 * Prevent new records from being published before detaching pending
+	 * records and waking blocked waiters.
+	 */
+	spin_lock_irqsave(&mgr->lock, flags);
+	mgr->dead = true;
+	list_splice_init(&mgr->pending, &removed);
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	list_for_each_entry_safe(rec, tmp, &removed, node) {
+		list_del(&rec->node);
+		amdgpu_wait_event_record_free(rec);
+	}
+
+	wake_up_interruptible_all(&mgr->wq);
+}
+
+/**
+ * amdgpu_wait_event_remove_queue - remove pending records for a queue
+ * @mgr: per-file WAIT_EVENT manager
+ * @queue: queue being removed
+ *
+ * Detach all pending records associated with @queue while holding the
+ * manager lock. Queue references are released after the lock is dropped.
+ */
+void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
+				    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_wait_event_record *rec, *tmp;
+	unsigned long flags;
+	LIST_HEAD(removed);
+
+	if (!mgr || !queue)
+		return;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
+		if (rec->queue != queue)
+			continue;
+
+		list_move_tail(&rec->node, &removed);
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	list_for_each_entry_safe(rec, tmp, &removed, node) {
+		list_del(&rec->node);
+		amdgpu_wait_event_record_free(rec);
+	}
+
+	wake_up_interruptible_all(&mgr->wq);
+}
+
+/**
+ * amdgpu_wait_event_drm_ioctl - wait for an AMDGPU render-node event
+ * @dev: DRM device
+ * @data: struct drm_amdgpu_wait_event request
+ * @file_priv: DRM file issuing the request
+ *
+ * Resolve the request scope, consume the first matching pending record and
+ * copy its metadata to userspace.
+ *
+ * deadline_ns is an absolute CLOCK_MONOTONIC deadline. The remaining wait
+ * interval is recomputed from the original deadline after every wakeup so
+ * that spurious wakeups cannot extend the requested deadline.
+ *
+ * Return:
+ * Zero on success or a negative error code.
+ */
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_wait_event *args = data;
+	struct amdgpu_usermode_queue *queue = NULL;
+	struct amdgpu_wait_event_mgr *mgr;
+	struct amdgpu_wait_event_record *rec;
+	long remaining;
+	int ret;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	if (args->flags || !args->event_type || !args->out_ptr)
+		return -EINVAL;
+
+	if (args->out_size < sizeof(struct drm_amdgpu_wait_event_data))
+		return -EINVAL;
+
+	ret = amdgpu_wait_event_get_queue(fpriv, args, &queue);
+	if (ret)
+		return ret;
+
+	mgr = &fpriv->wait_event_mgr;
+
+	for (;;) {
+		rec = amdgpu_wait_event_pop_match(mgr, args, queue);
+		if (rec)
+			break;
+
+		if (READ_ONCE(mgr->dead)) {
+			ret = -EIO;
+			goto out_put_queue;
+		}
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto out_put_queue;
+		}
+
+		remaining = amdgpu_wait_event_deadline_to_jiffies(args->deadline_ns);
+		if (!remaining) {
+			ret = -ETIME;
+			goto out_put_queue;
+		}
+
+		remaining = wait_event_interruptible_timeout(mgr->wq,
+							     READ_ONCE(mgr->dead) ||
+							     amdgpu_wait_event_has_match(mgr, args, queue),
+							     remaining);
+		if (remaining < 0) {
+			ret = remaining;
+			goto out_put_queue;
+		}
+	}
+
+	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
+			 sizeof(rec->data)))
+		ret = -EFAULT;
+	else
+		ret = 0;
+
+	amdgpu_wait_event_record_free(rec);
+
+out_put_queue:
+	amdgpu_userq_put(queue);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
new file mode 100644
index 000000000000..9da68eb6c9b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_WAIT_EVENT_H__
+#define __AMDGPU_WAIT_EVENT_H__
+
+#include <linux/atomic.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+
+#include <uapi/drm/amdgpu_drm.h>
+
+struct amdgpu_usermode_queue;
+
+/**
+ * struct amdgpu_wait_event_record - pending WAIT_EVENT record
+ * @node: link in the manager's pending-record list
+ * @queue: referenced queue for queue-scoped events, or NULL
+ * @data: event metadata returned to userspace
+ */
+struct amdgpu_wait_event_record {
+	struct list_head node;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_amdgpu_wait_event_data data;
+};
+
+/**
+ * struct amdgpu_wait_event_mgr - per-file WAIT_EVENT manager
+ * @lock: protects @pending and @dead
+ * @wq: waitqueue used by blocked WAIT_EVENT ioctls
+ * @pending: pending event records
+ * @seqno: per-file monotonically increasing event sequence number
+ * @dead: prevents new records from being queued during teardown
+ */
+struct amdgpu_wait_event_mgr {
+	/* Protects @pending and @dead. */
+	spinlock_t lock;
+	wait_queue_head_t wq;
+	struct list_head pending;
+	atomic64_t seqno;
+	bool dead;
+};
+
+void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
+void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
+
+void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
+				    struct amdgpu_usermode_queue *queue);
+
+void amdgpu_wait_event_add(struct amdgpu_wait_event_mgr *mgr,
+			   u32 event_type,
+			   struct amdgpu_usermode_queue *queue);
+
+int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv);
+
+/**
+ * amdgpu_wait_event_type_is_queue_scoped - test event queue scope
+ * @event_type: kernel-defined AMDGPU event type
+ *
+ * Return:
+ * True when @event_type requires a USERQ queue handle.
+ */
+static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
+{
+	switch (event_type) {
+	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
+	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
+	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#endif /* __AMDGPU_WAIT_EVENT_H__ */
-- 
2.34.1

