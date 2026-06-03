Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A7CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941601120E7;
	Wed,  3 Jun 2026 16:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eo8jr8s8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63EE1120E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/VuSCsskr//0hn0wv5yflyZiRKqzmZeZk3bfViS4xS8w5hqBALFgEq2fQ6zFwq1y7nYigi8yXFusSNQ7yBoqsM64QC2IBg8yKi5uZr8UL5cMkxPHvr6zJh17IQ71Bj9vFqH9Gp8IrjroVh37uzo8AIujbZACJ46WaTXfzGDqZwWoiB392cvZbo+OvoxlqtUKa5j2W39Rmotg4stZ4ge+p5hMlu3QamhIJ0e/V8WXRg8BxsqPx3gWB3mjN6Oxj2j4LWuQrRwahg2EudHa+oaj8Lh6lbz+HDddHZYpZbIrnaO7Wruwded3TAZpRIJB2MI6eBShiYExdmUBvDOSyBmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG7TVdzSeO2OiVZMzoubXkNNkPNjeDJ0JCXJ/uGrumQ=;
 b=ZdocDHX87PfuP3ZdOOJM/DkSjj+UL+kb8mYRqJ8e6qFjZrrvG4t57309g4W3v6KauEbuuaNk7+CSn+ZtO31AeZFCwJhnennAu2FekeUq0jsNN3MFWeZUk4Tk/FBJmgUNOYvx8Ql3PfyEZ++STwykcPTWdMjQO6AXdt/vEA+kgBhD5I9yB1F4gMteuXV/Uj54eAgJ/jamiRAcd+nnSszRbtToXoHqQ5laX02bgsQUykwTrMeMkuvMgrmPQLcooKPe0rEiFYmJgVajivGJGVafDrwJSWxuUE70wIGDN+6pKi3gakyqEhHe+gaSAWCmGIGLYtQxnpSfJ0vfDxCXHc+mDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG7TVdzSeO2OiVZMzoubXkNNkPNjeDJ0JCXJ/uGrumQ=;
 b=eo8jr8s8fqZBYgFSj9stMCkySdU2zfgwKpYGFedxxg6h16O52Zz08YNokZzrgOdv5Bl0eULrpNreGG70KWHY13o1ybSvb4VJWbDDKIXb9JHjg0lE/jMS9DbZ3sbgV7yDnZ/zp6P+sRCC0EcZri9DnZ0kRlScNiv/nA34Z9CRpGI=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 3 Jun 2026
 16:36:18 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::27) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add debug event fd core
Date: Wed, 3 Jun 2026 22:06:00 +0530
Message-ID: <20260603163602.2678435-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
References: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba67832-e522-4abe-bf0d-08dec18e3ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099006|18002099003|3023799007|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: yZmdnKD1IX+jw3EoI/90Yly1qw84ZL3aVrAaR8xfWy7aV5PR78Xrtu3/dxcDHmepRPdJeUkRADqQzulqjsul+A/q2ztYDa70qzJXLEAVkH3SVpNW5YxHgz2tsjey5934oROERNwZQv+tEmQ1QReAEPeLshdLVcZoCdCuuBR/88uLBLoHX4LIVvDXrrDhlhqgwoWsx3ob4dn6wyA5IVfa8SlM2tBmav/Q+IJ3szn8SZkQiCSF+SAmwjHho8UA+CpmyeB2weqBRj7xFKqjhfuo+RGjJr46CWVc3g0Rsw7lC8TDrqZLLRyIkmiJyWrIPPX/CzNRyk8HlH0XVZKeOa7fbZqtt0zuXWcdFmrf4940wV7eHzZC7RaLCD3sdwG78Su3xHV063KbIJxNgHgOnzRVln33urxmafxc5OUE2ZlIZtCOUKexdCstNUbB74vCkKjI6L/v05TVekz06amszYDggG3hN2byKDrOTta6+gzWYh7ov11+Lcyf1FUeI3tHTkaE/8ICeLWgHOcxIOIoZYYalU2voMFLDjnn8eHRFPK621vXdPdrwzZw0Ttw2wNc2ylcd80NTtNYLgkABMLF8UpeouBVyIxVqkpJqv248NVoivlbSTGF66/Qk3rN9a0zFKX8E0Mo32tOdfrerLNvV7wgf6nzeDZk7mPGCiU1ov40/dpKh2Gup8SFrZ/7wfDFnOPmUlRR50dcowVyI28X6eaHDJr2nOyyIOviul7E/Sd6k0I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(18002099003)(3023799007)(11063799006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q5kcyMTtuwWwoa4to1UITtAV1Ut0GsRnTlrSzjYQ8qScAObtRxYFFleZXkQ1ISYebdMAov95rFfZ8DJw2AQzZHZZLcOKZVoc829Dr/6ojSVt/YUhb+AarAW0h8QHNexcV9VYqwSQv57DY2R2PsJBUOn5FG9TfTvKk8dA7eYjyUb/Zzw7ed7FxrAB80+lbM0Vq886aVtWagKbUgPMqTIMe+jbPiYsq6VgeN3o3rTl6yIoCuBc5NmEzzOV2r42oYOIAl6dtPFjU9/D0M1qnVlkDtWDHfDdNzI8vhwsKHdtZelxgk7prZ1z3K9D7Wki/VVvPkpllIwj+XNz5FvQW2irfk8JHbN9u3MR/4oFacEWziO+4Re22GH9TuhheG1AfYoHFu4jzto3S2lg/pINIPXHOfFS7JJXr1t8EoNdEnkMIHSx5tw3JDH3TWmiX2N73k7A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:18.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba67832-e522-4abe-bf0d-08dec18e3ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
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

Add the core infrastructure for debugger event handling on render nodes.
A debugger can attach to a render-node client and receive events through
a debug fd. This introduces a debug fd, event FIFO management, read and
forward operations, and support for attaching and detaching debugger
sessions.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_debug_event.c   | 408 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_debug_event.h   |  52 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 5 files changed, 465 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 0d3b08e4d9c9..71b700173a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,8 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_eventfd.o \
-	amdgpu_wait_event.o
+	amdgpu_eventfd.o amdgpu_wait_event.o amdgpu_debug_event.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6edd3ea5cbd2..b42cff392f34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -106,6 +106,7 @@
 #include "amdgpu_aca.h"
 #include "amdgpu_wait_event.h"
 #include "amdgpu_eventfd.h"
+#include "amdgpu_debug_event.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -460,6 +461,7 @@ struct amdgpu_fpriv {
 
 	struct amdgpu_eventfd_mgr	eventfd_mgr;
 	struct amdgpu_wait_event_mgr	wait_event_mgr;
+	struct amdgpu_debug_event_mgr	debug_event_mgr;
 };
 
 struct drm_device;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.c
new file mode 100644
index 000000000000..72a6f65ddcfd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.c
@@ -0,0 +1,408 @@
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
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kfifo.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <drm/amdgpu_drm.h>
+
+#include "amdgpu.h"
+#include "amdgpu_debug_event.h"
+#include "amdgpu_eventfd.h"
+#include "amdgpu_wait_event.h"
+
+#define AMDGPU_DEBUG_EVENT_FIFO_SIZE 64
+
+struct amdgpu_debug_event_session {
+	struct kref ref;
+	struct amdgpu_debug_event_mgr *mgr;
+
+	spinlock_t lock;
+	bool detached;
+
+	DECLARE_KFIFO_PTR(fifo, struct drm_amdgpu_debug_event_record *);
+	wait_queue_head_t read_wq;
+	wait_queue_head_t space_wq;
+	atomic64_t seqno;
+};
+
+static void amdgpu_debug_event_session_free(struct kref *ref)
+{
+	struct amdgpu_debug_event_session *session =
+		container_of(ref, struct amdgpu_debug_event_session, ref);
+	struct drm_amdgpu_debug_event_record *rec;
+
+	while (kfifo_get(&session->fifo, &rec))
+		kfree(rec);
+
+	kfifo_free(&session->fifo);
+	kfree(session);
+}
+
+static void amdgpu_debug_event_session_get(struct amdgpu_debug_event_session *session)
+{
+	kref_get(&session->ref);
+}
+
+static void amdgpu_debug_event_session_put(struct amdgpu_debug_event_session *session)
+{
+	kref_put(&session->ref, amdgpu_debug_event_session_free);
+}
+
+void amdgpu_debug_event_mgr_init(struct amdgpu_debug_event_mgr *mgr,
+				 struct amdgpu_fpriv *fpriv)
+{
+	mutex_init(&mgr->lock);
+	mgr->fpriv = fpriv;
+	mgr->session = NULL;
+}
+
+static void amdgpu_debug_event_deliver_to_app(struct amdgpu_fpriv *fpriv,
+					      const struct drm_amdgpu_wait_event_data *data)
+{
+	amdgpu_eventfd_signal(&fpriv->eventfd_mgr, data->event_type,
+			      data->queue_id);
+	amdgpu_wait_event_push_data(&fpriv->wait_event_mgr, data);
+}
+
+static void amdgpu_debug_event_flush_to_app(struct amdgpu_debug_event_session *session)
+{
+	struct drm_amdgpu_debug_event_record *rec;
+	struct amdgpu_fpriv *fpriv = NULL;
+
+	if (session->mgr)
+		fpriv = session->mgr->fpriv;
+
+	while (kfifo_get(&session->fifo, &rec)) {
+		if (fpriv)
+			amdgpu_debug_event_deliver_to_app(fpriv, &rec->data);
+		kfree(rec);
+	}
+}
+
+static void amdgpu_debug_event_detach_locked(struct amdgpu_debug_event_mgr *mgr)
+{
+	struct amdgpu_debug_event_session *session = mgr->session;
+
+	if (!session)
+		return;
+
+	mgr->session = NULL;
+	WRITE_ONCE(session->detached, true);
+	wake_up_all(&session->read_wq);
+	wake_up_all(&session->space_wq);
+
+	/* Forward unread events to the app so detach does not block progress. */
+	amdgpu_debug_event_flush_to_app(session);
+	amdgpu_debug_event_session_put(session);
+}
+
+void amdgpu_debug_event_mgr_fini(struct amdgpu_debug_event_mgr *mgr)
+{
+	mutex_lock(&mgr->lock);
+	amdgpu_debug_event_detach_locked(mgr);
+	mgr->fpriv = NULL;
+	mutex_unlock(&mgr->lock);
+}
+
+static struct amdgpu_debug_event_session *
+amdgpu_debug_event_session_create(struct amdgpu_debug_event_mgr *mgr)
+{
+	struct amdgpu_debug_event_session *session;
+	int r;
+
+	session = kzalloc(sizeof(*session), GFP_KERNEL);
+	if (!session)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&session->ref);
+	session->mgr = mgr;
+	spin_lock_init(&session->lock);
+	init_waitqueue_head(&session->read_wq);
+	init_waitqueue_head(&session->space_wq);
+	atomic64_set(&session->seqno, 0);
+
+	r = kfifo_alloc(&session->fifo,
+			AMDGPU_DEBUG_EVENT_FIFO_SIZE *
+			sizeof(struct drm_amdgpu_debug_event_record *),
+			GFP_KERNEL);
+	if (r) {
+		kfree(session);
+		return ERR_PTR(r);
+	}
+
+	return session;
+}
+
+bool amdgpu_debug_event_attached(struct amdgpu_fpriv *fpriv)
+{
+	bool attached;
+
+	if (!fpriv)
+		return false;
+
+	mutex_lock(&fpriv->debug_event_mgr.lock);
+	attached = !!fpriv->debug_event_mgr.session;
+	mutex_unlock(&fpriv->debug_event_mgr.lock);
+
+	return attached;
+}
+
+int amdgpu_debug_event_route(struct amdgpu_fpriv *fpriv,
+			     const struct drm_amdgpu_wait_event_data *data)
+{
+	struct amdgpu_debug_event_session *session;
+	struct drm_amdgpu_debug_event_record *rec;
+	unsigned long flags;
+	int r = 0;
+
+	if (!fpriv || !data)
+		return -EINVAL;
+
+	mutex_lock(&fpriv->debug_event_mgr.lock);
+	session = fpriv->debug_event_mgr.session;
+	if (!session) {
+		mutex_unlock(&fpriv->debug_event_mgr.lock);
+		amdgpu_debug_event_deliver_to_app(fpriv, data);
+		return 0;
+	}
+	amdgpu_debug_event_session_get(session);
+	mutex_unlock(&fpriv->debug_event_mgr.lock);
+
+	rec = kzalloc(sizeof(*rec), GFP_ATOMIC);
+	if (!rec) {
+		r = -ENOMEM;
+		goto out_put;
+	}
+
+	rec->len = sizeof(*rec);
+	rec->event_type = data->event_type;
+	rec->queue_id = data->queue_id;
+	rec->flags = DRM_AMDGPU_DEBUG_EVENT_NEED_FORWARD;
+	rec->seqno = atomic64_inc_return(&session->seqno);
+	rec->data = *data;
+
+	spin_lock_irqsave(&session->lock, flags);
+	if (session->detached) {
+		spin_unlock_irqrestore(&session->lock, flags);
+		amdgpu_debug_event_deliver_to_app(fpriv, data);
+		kfree(rec);
+		goto out_put;
+	}
+
+	if (!kfifo_in(&session->fifo, &rec, 1)) {
+		spin_unlock_irqrestore(&session->lock, flags);
+		/* Avoid blocking IRQ paths. Preserve app progress if debug FIFO fills. */
+		amdgpu_debug_event_deliver_to_app(fpriv, data);
+		kfree(rec);
+		r = -ENOSPC;
+		goto out_put;
+	}
+	spin_unlock_irqrestore(&session->lock, flags);
+
+	wake_up_interruptible_all(&session->read_wq);
+
+out_put:
+	amdgpu_debug_event_session_put(session);
+	return r;
+}
+
+static __poll_t amdgpu_debug_event_poll(struct file *file,
+					struct poll_table_struct *wait)
+{
+	struct amdgpu_debug_event_session *session = file->private_data;
+	__poll_t mask = 0;
+	unsigned long flags;
+	bool empty;
+
+	poll_wait(file, &session->read_wq, wait);
+
+	spin_lock_irqsave(&session->lock, flags);
+	empty = kfifo_is_empty(&session->fifo);
+	spin_unlock_irqrestore(&session->lock, flags);
+
+	if (READ_ONCE(session->detached))
+		mask |= POLLHUP;
+
+	if (!empty)
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+static long amdgpu_debug_event_read_ioctl(struct amdgpu_debug_event_session *session,
+					  void __user *argp)
+{
+	struct drm_amdgpu_debug_event_record user;
+	struct drm_amdgpu_debug_event_record *rec = NULL;
+	unsigned long flags;
+	int r;
+
+	if (copy_from_user(&user, argp, sizeof(user)))
+		return -EFAULT;
+
+	if (user.len < sizeof(user)) {
+		user.len = sizeof(user);
+		if (copy_to_user(argp, &user, sizeof(user)))
+			return -EFAULT;
+		return -EMSGSIZE;
+	}
+
+	r = wait_event_interruptible(session->read_wq,
+				     READ_ONCE(session->detached) ||
+				      !kfifo_is_empty(&session->fifo));
+	if (r)
+		return r;
+
+	spin_lock_irqsave(&session->lock, flags);
+	if (!kfifo_get(&session->fifo, &rec))
+		r = READ_ONCE(session->detached) ? -ENOTCONN : -EAGAIN;
+	spin_unlock_irqrestore(&session->lock, flags);
+
+	if (r)
+		return r;
+
+	if (copy_to_user(argp, rec, sizeof(*rec)))
+		r = -EFAULT;
+
+	kfree(rec);
+	wake_up_interruptible_all(&session->space_wq);
+	return r;
+}
+
+static long amdgpu_debug_event_forward_ioctl(struct amdgpu_debug_event_session *session,
+					     void __user *argp)
+{
+	struct drm_amdgpu_debug_event_record rec;
+	struct amdgpu_fpriv *fpriv;
+
+	if (copy_from_user(&rec, argp, sizeof(rec)))
+		return -EFAULT;
+
+	if (rec.len < sizeof(rec) || !rec.event_type)
+		return -EINVAL;
+
+	if (!session->mgr)
+		return -ENOTCONN;
+
+	mutex_lock(&session->mgr->lock);
+	fpriv = session->mgr->fpriv;
+	if (!fpriv || session->mgr->session != session) {
+		mutex_unlock(&session->mgr->lock);
+		return -ENOTCONN;
+	}
+	amdgpu_debug_event_deliver_to_app(fpriv, &rec.data);
+	mutex_unlock(&session->mgr->lock);
+
+	return 0;
+}
+
+static long amdgpu_debug_event_fd_ioctl(struct file *file,
+					unsigned int cmd, unsigned long arg)
+{
+	struct amdgpu_debug_event_session *session = file->private_data;
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case DRM_AMDGPU_DEBUG_FD_READ_EVENT:
+		return amdgpu_debug_event_read_ioctl(session, argp);
+	case DRM_AMDGPU_DEBUG_FD_FORWARD_EVENT:
+		return amdgpu_debug_event_forward_ioctl(session, argp);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int amdgpu_debug_event_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_debug_event_session *session = file->private_data;
+	struct amdgpu_debug_event_mgr *mgr = session->mgr;
+
+	if (mgr) {
+		mutex_lock(&mgr->lock);
+		if (mgr->session == session)
+			amdgpu_debug_event_detach_locked(mgr);
+		mutex_unlock(&mgr->lock);
+	}
+
+	amdgpu_debug_event_session_put(session);
+	return 0;
+}
+
+static const struct file_operations amdgpu_debug_event_fops = {
+	.owner = THIS_MODULE,
+	.poll = amdgpu_debug_event_poll,
+	.unlocked_ioctl = amdgpu_debug_event_fd_ioctl,
+	.compat_ioctl = amdgpu_debug_event_fd_ioctl,
+	.release = amdgpu_debug_event_release,
+};
+
+int amdgpu_debug_event_ioctl(struct drm_device *dev, void *data,
+			     struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	union drm_amdgpu_debug_event *args = data;
+	struct amdgpu_debug_event_session *session;
+	int fd;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	if (args->attach.op != DRM_AMDGPU_DEBUG_EVENT_OP_ATTACH ||
+	    args->attach.flags || args->attach.reserved)
+		return -EINVAL;
+
+	session = amdgpu_debug_event_session_create(&fpriv->debug_event_mgr);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	mutex_lock(&fpriv->debug_event_mgr.lock);
+	if (fpriv->debug_event_mgr.session) {
+		mutex_unlock(&fpriv->debug_event_mgr.lock);
+		amdgpu_debug_event_session_put(session);
+		return -EBUSY;
+	}
+
+	amdgpu_debug_event_session_get(session); /* manager reference */
+	fpriv->debug_event_mgr.session = session;
+	mutex_unlock(&fpriv->debug_event_mgr.lock);
+
+	fd = anon_inode_getfd("amdgpu_debug_event", &amdgpu_debug_event_fops,
+			      session, O_CLOEXEC | O_RDWR);
+	if (fd < 0) {
+		mutex_lock(&fpriv->debug_event_mgr.lock);
+		if (fpriv->debug_event_mgr.session == session)
+			amdgpu_debug_event_detach_locked(&fpriv->debug_event_mgr);
+		mutex_unlock(&fpriv->debug_event_mgr.lock);
+		amdgpu_debug_event_session_put(session);
+		return fd;
+	}
+
+	args->attach.debug_fd = fd;
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.h
new file mode 100644
index 000000000000..e80111ca8a3f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.h
@@ -0,0 +1,52 @@
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
+#ifndef __AMDGPU_DEBUG_EVENT_H__
+#define __AMDGPU_DEBUG_EVENT_H__
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct amdgpu_fpriv;
+struct drm_device;
+struct drm_file;
+struct drm_amdgpu_wait_event_data;
+struct amdgpu_debug_event_session;
+
+struct amdgpu_debug_event_mgr {
+	struct mutex lock;
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_debug_event_session *session;
+};
+
+void amdgpu_debug_event_mgr_init(struct amdgpu_debug_event_mgr *mgr,
+				 struct amdgpu_fpriv *fpriv);
+void amdgpu_debug_event_mgr_fini(struct amdgpu_debug_event_mgr *mgr);
+
+bool amdgpu_debug_event_attached(struct amdgpu_fpriv *fpriv);
+int amdgpu_debug_event_route(struct amdgpu_fpriv *fpriv,
+			     const struct drm_amdgpu_wait_event_data *data);
+int amdgpu_debug_event_ioctl(struct drm_device *dev, void *data,
+			     struct drm_file *file_priv);
+
+#endif /* __AMDGPU_DEBUG_EVENT_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b768d4be7cc8..6ebbb692598d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1501,6 +1501,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
 	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
+	amdgpu_debug_event_mgr_init(&fpriv->debug_event_mgr, fpriv);
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
@@ -1599,6 +1600,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		return;
 
 	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_debug_event_mgr_fini(&fpriv->debug_event_mgr);
 	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
 	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
 
-- 
2.34.1

