Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB9CD5BAB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 21:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709A210E54E;
	Thu, 21 May 2026 21:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mUgHQWXk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B9310F40D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 21:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9ngcyfTFvIGuOoG5WYn4u8XyrjFiWd2lCOppJCb1Ttzx8Fyuq+g7Ksv9ml3OD5GGehrtk1d9OpMh3+LW/vA5icTyOItV8AIIBH8NUoL1mQipZs5xf8PBQBvuBqHWgc/lof9z3S/kNRxpGFYSnTJIz9faZiW1nW0+c8L/xC2FwML4y4HKYF6jnlstyAn6EOPm1ZdpRPtPSS/ZSq/6fbACjxubV/gG5BYeQ1KXioXtFO34guFGA7aUNsZ/aLIO4FypttzYkLET4CRY11/7l5nsfwP3N6OJcDvtJlZ8EZAkNmU9orhZkSKDun9Fc1kaMCi5G9e+U9Qnc5QYQUwslPuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr+DRMkD4XRsYm6FvKujxQ8N4shqn0dcRSQe/6zSc4I=;
 b=aDYFeRtnS3n0ZlLU+SflOEElTxzRGCYtcNbxhNblGTosyIb2glJMwoK13YX7v4lLYJ4SOfHP9Bdd/hen7099IDcNmuEfyO5e8DqPsTYTqzZmq6eC49MT/KHf1DsX3qi/b3eZUSnJpFoXNX+9WTQxWyDlwGH0fALjxYjTyz8F3GCSfvT4Kli59qqsadeOlwLlRIg6Vf4IeAWjupwAIDNIwG+LmdRuyIATPa/8knFtRrQyACywxUAri+6+l+xV6wKzgMj8+I7gibevMwuPHuOHZBQqKeQ2E9zI1V/8ljZhw9thw7XXaq/ownU847tdGz2jojiEd/QuT5ptzi6Yti7kFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr+DRMkD4XRsYm6FvKujxQ8N4shqn0dcRSQe/6zSc4I=;
 b=mUgHQWXkjuss84t6C+nO5Y9X++VqntzZvIi9Ccz0MWZRDNu6oRQm8QkhHNRC0SmnE+RZe+9KvHL/QikMZsjSzJqqRx2JHKDEJZR8dnZOlnGoYh2sI48o4pqWJaUE9V96yCXWreaMyy2B/2DVVYnhRR4X+LzjSWImNdfhqe0SLlU=
Received: from BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::13)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 21:39:22 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::b8) by BY1P220CA0041.outlook.office365.com
 (2603:10b6:a03:59e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Thu,
 21 May 2026 21:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:39:21 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 16:39:20 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Bing.Ma@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH v3 02/17] drm/amdgpu: add profiler manager initialization and
 release
Date: Thu, 21 May 2026 17:39:09 -0400
Message-ID: <20260521213909.1933803-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-3-James.Zhu@amd.com>
References: <20260324212030.822932-3-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1b6f9e-c0ac-4ba7-4c5d-08deb7816bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: ch7QUaoSA7LAocshZ6EUguqwY24bghLBXeyQ+yYSHNNN4nH9aUqZ4nZ1qSfmp7i2Tr8Ho9XQFGENKwNL8ovOFPm1CwuScTI2Bl9bJeZmRZNLu4drZmf3lyEhbwBo6OCHkUT3v2sCmeIAEkd5sxQht1a8z99Wi+zZMQO6Io5QL7idMfRn+uDO8irP0PkS+iIxAG255VCK87VtCy7NGWZS8gVal/2qODOylJBStHV5JfeAkEiRTH5GExJcU4PpXLxgEupcRDcUyBMvwG5TmkKU2RMdL48nG6Pt3w6lA4mH27UG1cAz3vkDnQcO8oy+i7oq6KBKLFUXokCmV0JrWaPbOHfDBUa8yrw170RFefnO2lPGQYCjHyIMmyqJ6chM4kZQlINS7g+JYjGyb8gKcPeBL7FyUKw61q97s1hnKe1L+1P2sgFajcl5HqS3kqJc1/nbn/ISlBV9cNNVKJd2/y0UetSc+ORwSCuD2XYaiItCBpF+XUno+kXDvkoBOByGU/MjGVqFqK8AhsLcAuP0RFvKLBgCtsMGbAm0GQUD4h984nNoAByNpGCKahVHhw2bYtpwuLV7DIzeNxc5BEmX/aKR+rEY655BtBtcOt6F8rUzaDQ0QQu/apapulYcS8xjl3zJG4BVH6Ckg2rRNgaE7QeSdKPh6wYk7sxJQ1cp/0osV1N0Hmf1RqA5fBDvOegtevpBPCxpsD/aQOuEaZSJwfbQMEnYypUN8iHG+qsIt3HPB7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f9gM7IpjJ4a+azkSPcVoIa7oC8WtejYIhx7E1O0HhcLrjKeSoaPs6UMu1cl+LayfO4yNhty98xom7QzN/33W3JtdNkULWxV9tPRVJ4DwOZlrnKK7GsN5+9Bd3gcLMknpjJ6F96RX9KV4UFMYma/d4ZV9ZoXyWx5GjCAG6HBobENGJxuZWJ/XCSM9oQEpprIQUesLsU3PvPJAwjw9b+H80anP4gC3zmkLYQAamSFQrCfcLtH4t4X3l7gJc28pMk8zLuV+YhikMfKu8VUrqwi5mJNx+ImAW+UCBJ+z9TNPJtNGTJX7dJm2vs85akR8NGRiur3RiAZJW76OhiAWYEIpyA8zjDpBjMjYZC5jWILdNUnm5CO9trE3ZurwfOeGuVl/M0i1Z4SCmWySHbyA37JMDBZ96JYxFIg3Ufmngu2coqxo1kwRTKH/q+HfeV126uxD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:39:21.7744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1b6f9e-c0ac-4ba7-4c5d-08deb7816bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

to introduce the profiler manager infrastructure needed to support
per-process GPU hardware profiling features such as SPM and PCS.

Two new files are added:
- amdgpu_profiler.c/.h: define struct amdgpu_profiler_mgr, which
  holds an array of per-XCP partition managers (amdgpu_profiler_xcp_mgr),
  each reference-counted via kref and protected by a dedicated mutex.

A device-level struct amdgpu_profiler_mgr prof_mgr is embedded in
struct amdgpu_device and its top-level mutex is initialized during
amdgpu_device_init().

The per-XCP profiler manager is initialized lazily on the first
amdgpu_driver_open_kms() call for a given XCP partition:
- If the XCP manager is already initialized, only the kref is
  incremented.
- On file close (amdgpu_drm_release()), the kref is decremented and
  the per-XCP manager is destroyed (mutex destroyed, is_initialized cleared)
  when the last user releases it.

Non-partitioned devices uses XCP partition 0. Initialization is skipped
when fpriv->xcp_id is AMDGPU_XCP_NO_PARTITION, which indicates the
device has not yet been fully initialized.

-v3: rename is_init to is_initialized in amdgpu_profiler_xcp_mgr

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 89 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 48 +++++++++++
 7 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3b563c73bb66..74abc061cd4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o  amdgpu_cwsr.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o  amdgpu_cwsr.o \
+	amdgpu_profiler.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 116e509e7bed..7c18640ddb59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -109,6 +109,7 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_profiler.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -1252,6 +1253,8 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	struct amdgpu_profiler_mgr      prof_mgr;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b5a5b1670fe4..09ea4f1d7e33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4448,6 +4448,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.userq_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	mutex_init(&adev->prof_mgr.mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5e784d4de81b..52423c98ebf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2955,6 +2955,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_profiler_mgr_fini(fpriv_to_prof_mgr(fpriv), fpriv);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24ecdee0d735..ead67b4c54a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1626,6 +1626,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			dev_dbg(adev->dev, "cwsr trap not enabled");
 	}
 
+	r = amdgpu_profiler_mgr_init(fpriv_to_prof_mgr(fpriv), fpriv);
+	if (r)
+		DRM_WARN("Can't setup profiler\n");
+
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
 		goto error_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..d2cf0520c6f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+ */
+
+#include "amdgpu.h"
+
+/*
+ * Profiler revision change log
+ *
+ * 1.1 - Initial revision
+ */
+
+#define AMDGPU_PROFILER_VERSION_MAJOR 1
+#define AMDGPU_PROFILER_VERSION_MINOR 1
+
+int amdgpu_profiler_mgr_init(
+		struct amdgpu_profiler_mgr *prof_mgr,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 0;
+
+	mutex_lock(&prof_mgr->mutex);
+
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (prof_xcp_mgr->is_init) {
+		kref_get(&prof_xcp_mgr->ref);
+		mutex_unlock(&prof_mgr->mutex);
+		return 0;
+	}
+
+	dev_dbg(adev->dev, "Initialize profiler on render node %d xcp %d",
+		adev->ddev.render->index, fpriv->xcp_id);
+	kref_init(&prof_xcp_mgr->ref);
+	mutex_init(&prof_xcp_mgr->mutex);
+	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
+
+	prof_xcp_mgr->is_init = true;
+
+	mutex_unlock(&prof_mgr->mutex);
+	return 0;
+}
+
+static void amdgpu_profiler_mgr_release(struct kref *ref)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
+		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
+
+	mutex_destroy(&prof_xcp_mgr->mutex);
+	prof_xcp_mgr->is_init = false;
+}
+
+void amdgpu_profiler_mgr_fini(
+		struct amdgpu_profiler_mgr *prof_mgr,
+		struct amdgpu_fpriv *fpriv)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
+
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return;
+
+	mutex_lock(&prof_mgr->mutex);
+	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
+	if (prof_xcp_mgr->is_init)
+		kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
+	mutex_unlock(&prof_mgr->mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..c33018f01d0c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
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
+#ifndef AMDGPU_PROFILER_H_
+#define AMDGPU_PROFILER_H_
+
+#define fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
+#define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)
+
+struct amdgpu_profiler_xcp_mgr {
+	struct mutex                   mutex;
+	uint32_t                       xcp_id;
+	bool                           is_initialized;
+	struct kref                    ref;
+};
+
+struct amdgpu_profiler_mgr {
+	struct mutex                   mutex;
+	struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];
+};
+
+int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
+					struct amdgpu_fpriv *fpriv);
+void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
+					struct amdgpu_fpriv *fpriv);
+
+#endif /* AMDGPU_PROFILER_H_ */
-- 
2.34.1

