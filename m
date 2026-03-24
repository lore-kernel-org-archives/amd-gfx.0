Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C93FFEC118
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E768910E11D;
	Tue, 24 Mar 2026 21:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ko42y6z";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60D510E11D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adi9XBnyOXUsRBmcfVHM9A66lao7RGswGyaIBEfoD3ET84gFPjetRydcVixrtjFsa9aXW6LR6YkdAw6F/P+MqoWLE/pFvJ5QrFLT474rHifZyAreoen++U0Y0inpJGSD/FqPlwuX3zV/pRvKFJDNG9FSmNzwpGaoaN9BZ0DNcwLcP99QlK/hREL0mQ6ezBC8tN9n+CMqKkQSPZIqZVqLUsJoA7hCody+C5/QdDUyufIt8OSZDtrHeAh1jMxwGGoereABDHzL1sizC39+hdkz5vJI2NpdcZqzysyMASYETZMbamHe2E8Afnws9rwRw30jfiSaCBpGdbXj+uM8HZtvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm/pJy8PoCo1cPlN4ga5OkMGBJOnTmokYwJRhiwS/uk=;
 b=dsU77AgZ+qZuk+FSWXQQKfxLdHVxkfRPxCzVZ/RcHdWyK75vbxlwmYB+Oxt2M9IRSaIqHmONZ+8Xi2cfZeb3+Pkstg0gypiKvvYERHfQbtDacNfioxIuyLDLwCST/tULy8Z7ZuPW4//IDqZzaJVxjbuZYgv6lHcytaK6wqCxmLg3D7X6AOYtSP6ZTTIPE+Zyfh6sUV9bZS/7ecJpN6XPC4vvUv7I8MYpctI2siqHG846gBHWv2xaFzOw41uGsGdbUqakHS4VtcfLdE7iWXJnH5VV8M/Wk5t+r9lG7jkxkviaR8QDFz5f15m3CWWI9PWdQj3LNaC1lAl/Ijr1vla08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm/pJy8PoCo1cPlN4ga5OkMGBJOnTmokYwJRhiwS/uk=;
 b=3Ko42y6zMlLI7pyVwaKIP5n5kuAskfP1/A4LmigWKPp4BaV+g430udowVFpeKlZIlVAyIU+XYXaAlnObv1Lxi4PHgBSmZB6R1EEs6H01jDLhU82CCGL7JnnXyosbjWPu8xsU+J3dlBJfRzAFredPc4kDnuV8G4hiSqqEs31V83w=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:46 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::1) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:44 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:42 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 02/17] drm/amdgpu: add profiler manager initialization and
 release
Date: Tue, 24 Mar 2026 17:20:15 -0400
Message-ID: <20260324212030.822932-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: a58c8f36-cce6-4618-954e-08de89eb35d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iIEXW6jjB6hNxL/c7EtPSp0jw34NcMt8gpT1V7gLqrt/FYcfNNW9/LJEnh8M9xbvGV77Wy6vb5M404gT8iOyJkJUGvoWIK/PkLgUnzwTsyscP78lt3vZuN77i7aP/9o5IR3Vg0eSC3K7+kZJTV/Ke5KslMiuCH6B229vDLKWOl690GafgbthaWoVAVz9iQa0y2aIPzbmNqPXmRMtuwXkEoEOYGOYL97JAQYsKVPOgxGwjF7NFfwWnIbez4+3v7r2Qy+DggoAgRu7OGUgH7ivpfdUsf7kpyvdvPicP1nXVOPizZDVsXj8WFCwyHJ/vkGzCpDdHv0hK4izl6+ZYtrQ+/92yYru4ACsbHLStNbH/RkYPPuoK5QRjDg+qP9UmJPtfaNjb5f9/9fFkb8UytNULk9ZzRwaWD3MNP+NjxsvOIA5kdatfiC5M/MEKQW8ncwYAkJExfaQ0dP+3B1NAql/B9+XJ5JK8/q09UUHAMJ2g97zWz/ZOKH0cc62/96RGbeZcEoEL1EgecDMEhsbLp3VAVxPlt+qRU2eJUyf4b1RqwNyuRqKQ/6l6jTEXjggbXvM8SfNi+kvHgAWKrRUAtMtnsV4rTiPuFV5J2bFRrJnXz36+g+p64FDdQIzX7HiZaIi7qBh2T87SsHHu0U2EK5XKAsvSQnzZusheZS4tAIlf1/4iJdGX4aakWSXdWGv7xdlAtSdkFRQHZefKhgWOU2vrRl90nr1fhM05DqiI25xQBIVetkLqD6vkCqi5zrMaoBOKAvf5It117B5dv4B9kjhXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZhLIiAk8ZsOBXEpVtMiLAk584mcFgX7B65f2hQQthdqWfadCHPrjQAL7w245FOh15Fhl2dFuFcQF21vG9OoXvEGeAhROnPBDrXJKdeZHCERLHLa1mIyBqA48Gw5HiXOfP/htv/yaA44Wyh8P1Sql+LjqNcDEO/KFKFK582hvPUa9pnEEHzjboibkZT/9rQOsEqzNBzGRTIVN617bc93kXZs/f8gJUdXVuy9zaUEify6fKU7VWcLzOFk9skGI63yfXI2C2kJbZcwxEFae/xzQBmDvST607K2Hsb93aGGPxPdkP/HCw8swmww9QWapoFh2NvGZ5bK95aUXAGK4hMOT6UFdq6St+8oMrncYKXBgK+Ji8LFy1ESCRlPhn0XtTuI/V0MEdd3FqmzPgzntdtKjQDtMlUz3X4LUmsUbl+gQ1EFSEbDuZQuxi9BDnY8WLQe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:44.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58c8f36-cce6-4618-954e-08de89eb35d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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
  the per-XCP manager is destroyed (mutex destroyed, is_init cleared)
  when the last user releases it.

Non-partitioned devices uses XCP partition 0. Initialization is skipped
when fpriv->xcp_id is AMDGPU_XCP_NO_PARTITION, which indicates the
device has not yet been fully initialized.

Signed-off-by: James Zhu <James.Zhu@amd.com>
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
index 000000000000..2dfc0b1bb207
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
+	bool                           is_init;
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

