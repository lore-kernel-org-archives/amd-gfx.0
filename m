Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C588ECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1963D10E67E;
	Mon,  9 Sep 2024 20:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gvjVryvj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3979810E68D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+83RXm/+25RF9dgZuCan2oC7lLvXcCfnEieTceTquc7kiEXwJ6KOBcBkZBuIvcFvl8o5PLjvXFyeCEvPTvS/qivdLqBD/Ue2XLPK8UMrPQXYbbtpQLLdaeg4wECUI2GqQmp6/MGu6HJnpkiEUKzDEeq11Xy6h7b1jCtMY7pFxFrOhaIY2aN/+GgjcgNtj2J1KxlZrcLwGJUPYPhd88wQc5PvmbIuKMt4e5KW/DLjGOs9eRbrt37Kusee/jkiyOy0nkeiNe1NWm9+iECXIObMFa2Rvpyx17ayBz9TlmXJ0TXAyQqMdhD1Z9ZBGw5fQuIu1yIRWyzDG+l4nWs8y6qGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMY0UqTExVMTiWeGJCUmPvxzuJFr20DyQExKrL/UgiE=;
 b=K6q75lF8gNI6zPLgZ82kEuBMwp4Uv/FLnG3rKWaIntzyp9dCwriyRSc3pIomONzjO9gdbNHjj5J9PM6gI/0n/kmf5RF6kfmxCKn4SH9upCJxWs11e0+RAecZhKH30ZPt6rPwVx5kKTTrKA/r0BFlMpdii5se4lqLlDRed5rvwf6KR9xJMxgedEdtUu65KyBVrUd1egLbpsPhTjfSU+dSgyIWJN+k/f29jYmbtGEn/bi6xjTty7V8HtQXQfGTiXdDkLjlDd8IzRAXaTjFXFjUStSgeeXBeHDAblGMgTaTv6/CTFTiiabU004LxTe7nVMaVsZam9lNDmmW6UdAQaeT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMY0UqTExVMTiWeGJCUmPvxzuJFr20DyQExKrL/UgiE=;
 b=gvjVryvju5dqvsQvExLFr9rRhhOWIdbz4Vuzvv7CMc/19x4ed0YkGY6gL0t4Vhd3eyvPAGZBEW/JectjiFboxwFt2gT9hiRukxoikv4CkS4HoB+57IKokchWrfVApm5EVunVp83afPjWrDfDTbcOL5KTC6GiZTbmsFby+GC1DPw=
Received: from MW4PR03CA0185.namprd03.prod.outlook.com (2603:10b6:303:b8::10)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 9 Sep
 2024 20:07:19 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::6a) by MW4PR03CA0185.outlook.office365.com
 (2603:10b6:303:b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:19 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:17 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Arvind
 Yadav" <arvind.yadav@amd.com>
Subject: [PATCH v11 21/28] drm/amdgpu: add gfx eviction fence helpers
Date: Mon, 9 Sep 2024 22:06:07 +0200
Message-ID: <20240909200614.481-17-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: f500b446-eaac-429f-fa7f-08dcd10b025d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6iusfNTL7VYl1wMvh4lkeRrLgWHoNmVWMwvQr+21h6u3iLmrgoFBgfn8wU0S?=
 =?us-ascii?Q?EMNsCu8UuYux10SFtjuFgQ2Ucn351jcqA2HhPw4QdKJqdSPVxVxoz9Yat7zO?=
 =?us-ascii?Q?S5fXrKXXUYH94ZKx8ZePb7/oc1HyyOaf1N9YB8H5LQAwNeE2IZvj/5whhhfo?=
 =?us-ascii?Q?p6Kk/CWHN1mx4z07Io5c7zAF9IbHcFWRdSFIajk+ZDcM3pYFPjT9NZ/lc6lk?=
 =?us-ascii?Q?q4uHqdvpDtzv1lY+xdFvDz1UVWRjPMsbjz2zzUb8i0gF4OlEBO1Rmg4ojTlL?=
 =?us-ascii?Q?LxVpiMYVFUZAc4oBlBABryUhByUOrwKwTDBi12vK2q1729k81T80KO2pYQ9v?=
 =?us-ascii?Q?z0mRKn45rgWawzLdNwwWMSb4o1oq8C86n0Z29Ie7A4P9uxfTWhKlvGiiV4E+?=
 =?us-ascii?Q?xXd70H48I4cVPYi2o1EiHpb4qwRaYwyg0u3hBkeBpNdweWFLH/kcc+E9VS8K?=
 =?us-ascii?Q?uMjNG+WIniNt85xUfEJPE037+ow/UncwtOhMDiFexnr5VxL5Uz0worjM7DGF?=
 =?us-ascii?Q?BFHwWAEFYuAlBLvnj+8Zk0LEVNrZ8VR89MEMw63j+H1UYQoum+w18FRHWJCX?=
 =?us-ascii?Q?E2EUOKTTrO1ZQ4sO/zaICmvwxYY0gOwqkPOGnE/d93kCpGKGJRhfA3O4V6Xw?=
 =?us-ascii?Q?/JU2tutBjLa5cs9sq64C910Do7s/mqjfbuhaeulvwxWg0A37Qh952oOVGujQ?=
 =?us-ascii?Q?U1hqlWgsnPk4aeTm2HcdfQURs3EZRSvhNYbP6UJpNAFKvTUG2wuN1xassZ9n?=
 =?us-ascii?Q?zT0RWAK9GEQ+ZV5weudeYbawhZQcvDvCgJjgCkVKMXQlnVPy/6Nv8EgZLyJz?=
 =?us-ascii?Q?t0iuW68ZmcCkymnLC1Ns9BSmtNevzT5rlBhh43OO+k8DvpRm6bqCaznYdO3k?=
 =?us-ascii?Q?dBV/QMmARziV6yLEYhlPTOtzU/kD1HPyZfZCjW2YEC7kBti8PqXWetlX4XKM?=
 =?us-ascii?Q?M6pU8MHOotuJV/antVRXfDwe4wol2qN8YE/nQxWvQ6hG/un9oecz6CShNsFj?=
 =?us-ascii?Q?KnBkfCGQsv1ZVkwdN4tRfDCIumu0d1ziU/DnFVIKImo5+DFjj9IoTnGW9kna?=
 =?us-ascii?Q?TKX3F3G6uyGJsFIRQt34Yb/Els2iTALjQNAitj3hI6iqHjS+V3d+QXMjzJmH?=
 =?us-ascii?Q?3tYfsbb3N2dW6/ptcsqrea6I7Hi807dhlhyab/eaXSJFqBu3+bnPGjevfb5I?=
 =?us-ascii?Q?a/w05kdIamaPFmBWvSw/NTu9aCD+nEGND4lRDjdxgAUPPDUi/U/FrJaGw23m?=
 =?us-ascii?Q?jslisfzVVennw4KYd4MDXc099V2XM/05CF6gl0/d1i3JwTwej5ZjqzfOzobV?=
 =?us-ascii?Q?TThe0uPxcTX+J1QH3jwu52tyNpbDdTWvfeQfLNzPHhKKvRp4Q1u/qgKD6WWx?=
 =?us-ascii?Q?e4IEXCJV++LHiFZbzhTswlbfd3LK4+UIrzIjOA/1lpio21t9kJQO0HAeg0tV?=
 =?us-ascii?Q?PUL/VTHtbKrDihyAsRI8qv0e9FyFle1f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:19.2764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f500b446-eaac-429f-fa7f-08dcd10b025d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
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

This patch adds basic eviction fence framework for the gfx buffers.
The idea is to:
- One eviction fence is created per gfx process, at kms_open.
- This fence is attached to all the gem buffers created
  by this process.
- This fence is detached to all the gem buffers at postclose_kms.

This framework will be further used for usermode queues.

V2: Addressed review comments from Christian
    - keep fence_ctx and fence_seq directly in fpriv
    - evcition_fence should be dynamically allocated
    - do not save eviction fence instance in BO, there could be many
      such fences attached to one BO
    - use dma_resv_replace_fence() in detach

V3: Addressed review comments from Christian
    - eviction fence create and destroy functions should be called only once
      from fpriv create/destroy
    - use dma_fence_put() in eviction_fence_destroy

V4: Addressed review comments from Christian:
    - create a separate ev_fence_mgr structure
    - cleanup fence init part
    - do not add a domain for fence owner KGD

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Change-Id: I7a8d27d7172bafbfe34aa9decf2cd36655948275
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 148 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  65 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
 6 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ff5621697c68..0643078d1225 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -66,7 +66,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_userq_fence.o
+	amdgpu_userq_fence.o amdgpu_eviction_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 76ada47b1875..0013bfc74024 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -113,6 +113,7 @@
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_eviction_fence.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -481,7 +482,6 @@ struct amdgpu_flip_work {
 	bool				async;
 };
 
-
 /*
  * file private structure
  */
@@ -495,6 +495,10 @@ struct amdgpu_fpriv {
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+
+	/* Eviction fence infra */
+	struct amdgpu_eviction_fence_mgr evf_mgr;
+
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
new file mode 100644
index 000000000000..2d474cb11cf9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#include <linux/sched.h>
+#include "amdgpu.h"
+
+static const char *
+amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu";
+}
+
+static const char *
+amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_eviction_fence *ef;
+
+	ef = container_of(f, struct amdgpu_eviction_fence, base);
+	return ef->timeline_name;
+}
+
+static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
+	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
+};
+
+int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	int ret;
+
+	spin_lock(&evf_mgr->ev_fence_lock);
+	ret = dma_fence_signal(&evf_mgr->ev_fence->base);
+	spin_unlock(&evf_mgr->ev_fence_lock);
+	return ret;
+}
+
+struct amdgpu_eviction_fence *
+amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	struct amdgpu_eviction_fence *ev_fence;
+
+	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
+	if (!ev_fence)
+		return NULL;
+
+	get_task_comm(ev_fence->timeline_name, current);
+	spin_lock_init(&ev_fence->lock);
+	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
+		       &ev_fence->lock, evf_mgr->ev_fence_ctx,
+		       atomic_inc_return(&evf_mgr->ev_fence_seq));
+	return ev_fence;
+}
+
+void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+	if (!evf_mgr->ev_fence)
+		return;
+
+	if (!dma_fence_is_signaled(&evf_mgr->ev_fence->base))
+		dma_fence_wait(&evf_mgr->ev_fence->base, false);
+
+	/* Last unref of ev_fence */
+	spin_lock(&evf_mgr->ev_fence_lock);
+	dma_fence_put(&evf_mgr->ev_fence->base);
+	evf_mgr->ev_fence = NULL;
+	spin_unlock(&evf_mgr->ev_fence_lock);
+}
+
+int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				 struct amdgpu_bo *bo)
+{
+	struct dma_fence *ef;
+	struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
+	struct dma_resv *resv = bo->tbo.base.resv;
+	int ret;
+
+	if (!ev_fence || !resv)
+		return 0;
+
+	ef = &ev_fence->base;
+	ret = dma_resv_reserve_fences(resv, 1);
+	if (ret) {
+		dma_fence_wait(ef, false);
+		return ret;
+	}
+
+	spin_lock(&evf_mgr->ev_fence_lock);
+	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
+	spin_unlock(&evf_mgr->ev_fence_lock);
+	return 0;
+}
+
+void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
+				  struct amdgpu_bo *bo)
+{
+	struct dma_fence *stub;
+	struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
+
+	if (!ev_fence)
+		return;
+
+	spin_lock(&evf_mgr->ev_fence_lock);
+	stub = dma_fence_get_stub();
+	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
+				stub, DMA_RESV_USAGE_BOOKKEEP);
+	dma_fence_put(stub);
+	spin_unlock(&evf_mgr->ev_fence_lock);
+}
+
+void amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
+
+	/* This needs to be done one time per open */
+	atomic_set(&evf_mgr->ev_fence_seq, 0);
+	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
+	spin_lock_init(&evf_mgr->ev_fence_lock);
+
+	spin_lock(&evf_mgr->ev_fence_lock);
+	evf_mgr->ev_fence = amdgpu_eviction_fence_create(evf_mgr);
+	if (!evf_mgr->ev_fence) {
+		DRM_ERROR("Failed to craete eviction fence\n");
+		goto unlock;
+	}
+
+unlock:
+	spin_unlock(&evf_mgr->ev_fence_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
new file mode 100644
index 000000000000..b47ab1307ec5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef AMDGPU_EV_FENCE_H_
+#define AMDGPU_EV_FENCE_H_
+
+struct amdgpu_eviction_fence {
+	struct dma_fence base;
+	spinlock_t	 lock;
+	char		 timeline_name[TASK_COMM_LEN];
+	struct amdgpu_userq_mgr *uq_mgr;
+};
+
+struct amdgpu_eviction_fence_mgr {
+	u64			ev_fence_ctx;
+	atomic_t		ev_fence_seq;
+	spinlock_t 		ev_fence_lock;
+	struct amdgpu_eviction_fence *ev_fence;
+};
+
+/* Eviction fence helper functions */
+struct amdgpu_eviction_fence *
+amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+void
+amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+int
+amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
+			     struct amdgpu_bo *bo);
+
+void
+amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
+			     struct amdgpu_bo *bo);
+
+void
+amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+int
+amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr);
+
+int
+amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f4529f2fad97..c9b4a6ce3f14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -186,6 +186,13 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
 	else
 		++bo_va->ref_count;
+
+	if (!vm->is_compute_context || !vm->process_info) {
+		/* attach gfx eviction fence */
+		if (amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo))
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+	}
+
 	amdgpu_bo_unreserve(abo);
 
 	/* Validate and add eviction fence to DMABuf imports with dynamic
@@ -236,6 +243,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	struct drm_exec exec;
 	long r;
 
+	amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 019a377620ce..e7fb13e20197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1391,6 +1391,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
+	amdgpu_eviction_fence_init(&fpriv->evf_mgr);
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
@@ -1464,6 +1466,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
+	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-- 
2.45.1

