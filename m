Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A56CD98CE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8376010EF7E;
	Thu, 11 Jun 2026 14:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="boGs//NT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FB310EF7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAgvArS4c15Ko5eLqezxt4jF4lj81dGKrl8e8mpZsgTuny25lLi87vVhRk+chGEeV2HTpgWKtFbaPM6ECkeWgWDj4FX8+IC9vm1G6heNh80Uf4yHDDW7AFnhfg+etmMEnNthikfQ8B95d3MiYVNRu027jid3H0BC59hbTFI47Xq1RzP9RY+tbGqXYLN/fQrQeyiCdp0aIbcIocnNYVFG9+CdkQ0T1zd4LZsNSVwmbzuT9/eLuHN8Vr/izLqczivQG5SdVa8Gbdtvx58E25anrIYoD2nIj1VFzT6Z/H4lUfbjsY15PkLqpgAaqdTvlZZa65SKrviFs5EaT+WB7ZivRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W412SgxnQrSw6l4aPd1JunSZLk/rt6qw1rF2Imld8ds=;
 b=NLmazntDeBD4DcKVJLy9JpBa5pCtSlTSK04SRXGMXSXj6eQ7DQOhleBz3p/lCz4CpTDc6gTOSuI1TmdZUCJmiGziv7VBRH4ivubnxgjp4O/lN/2Msot473uYiVbiaHfVK06rqMtKBau7AqBH5hxAVEMCmt/lSl3SFKUQgxorbYpW/cAAxwwpCufAsGWu5tvlqfkJkOrvmsJNYFIH0uQbSaBoHuTXtqAYxQGheisYTjrTuseRp0ACMTueJKxeGLHxZNc/YRb2Hz6v15f17rDxUgqXW6Ybk8NxTCefjNb0wMIxdpX1efuwCJCWaluIvW5S0BFMCc1CybqRhSTBhqPUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W412SgxnQrSw6l4aPd1JunSZLk/rt6qw1rF2Imld8ds=;
 b=boGs//NTniu7PoWCNunSi9J+U/FEn8Cw3tXGPMJ5x6EROuTWaS5us5wbJj2c8bf2H1ID6s7vosLUbG4/B+2N7j+W5bz1Xz8tthsE3IQiJglmXlWq3BZHPLUmexpUHhMH4ELG+p4S5rVtmNm/IBFLTjnURvoKLeTGqLjOwtV1xwM=
Received: from SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 14:34:13 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::30) by SJ0PR03CA0268.outlook.office365.com
 (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:33:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 4/5] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Date: Thu, 11 Jun 2026 20:03:25 +0530
Message-ID: <20260611143326.2870571-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: f69fc4c9-36f5-4925-73c8-08dec7c681ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ncCvCPnUFi4aidZnVG967dtJ4ak6jY283C+L0tiA/LLzLB2J8W1JNkr9qPC891XoPptUvv+ju1wYCUscVKMRHd0FtIU6P+U0sXi+h0T/Iy0USnu2xdc9LaX2SZoKdm5QSLH2GIdWBrhCXzdU0xRPT9YVylEQsEphe4LEVUsQM69uK3wcSZphbhM5/QWj90f6K498a5op8UG5sfNLi6OXxhdjWfbhsAgF3pV3CZcQiCeI6TNqlCe66CZMwB9Xvdg57oBje1n+DIwqzD9EXT88Egg9KSNPHTqkzNm+yzIa+0111u1dk5F5syoTvvxLlObEscxwTTq/nard2OTfL37FXWuR83Y//D72Fhgle/eGUN/XbnPss03tW3/616RE5eqeZ2UZa4qiL8OIhaTzilnBUWumHfkvG/2X1l9eAMu/djX0TxnxMw2wqsKArBcKrMO/FpdtnoaTmRGg91PAF575NALS5jc6FJ4413Hx2cfSlWsvbATv2Hc7Y3L4Qi4ERPoK2yh1DIGi/kedyyv24rMCe3RK4iVp3DJjZmE2Bh5uowF8w2yLtTIHt9xU556vtgCM2EvpQGOnTndo3O+dSD3GBI4WQu+SgDNmh9x3W+sko9Bawi79sFS8ssVXHgZB3nvBJ9q3PGsFFJNA55lnV9e1qepU+RLnt34DyW714DT2N3/SEvWYRjrPYAbOEL53/tSmiKgVBIEG+uSE3zU1ikNmEZMKWta7hLMmUZaNOc5W9Es=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j4jnGJDw6ppQ7AxRdntwyNNZ92g0qoYLy8xoixpq5SnrKRVQP/E5MTV/hvLQF1ne38mm90hAnpVFPbNiacB6zIuDus2+wsKPlrG1+8Rj+m6k8IaEVqvVvPOaO/IDHCJ8OqeAt8OL6lhOeMWwe3fuxgIkQ5zZ/Z3efScAJIRDIutsj0s1j38glivR/+6P2ZGLOz4HtT0b/TuCdIk8HO4j3dxAulYqalPoBoAu7vdU8MfzHV0bmx4CmhxmIbymUyzthNsC4iXIUe3FHKXXtGwMzWkdOSETrFZF2zKIPY6f+qYcYK7oTJ2JPD2vSSPfceNY2ipstDhbrBhsVcdZakVaGMUikJwRnon8mjAkMT+FXI0qTg1ftW2d2yYPIzwI3sCY2fuZFp8NgNi4RjP3YW3S5dybzGSrAN2Q9ZfaMfaWcCRcwAp3PItwe10JvukjNlNg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:12.9251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69fc4c9-36f5-4925-73c8-08dec7c681ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

The current EVENTFD UAPI uses a userspace-defined event identifier.

For render-node event notifications, userspace should subscribe to
kernel-defined event types instead, allowing the kernel to define event
semantics and signaling sources.

Add a shared AMDGPU EVENTFD event type enum and update the EVENTFD UAPI
to use event_type instead of event_id.

Value 0 is reserved and rejected by the existing event_type validation.

queue_id remains part of the UAPI and is used to distinguish
queue-scoped subscriptions from GPU/device-scoped subscriptions.

Eventfd signaling remains notification-only.

v10: (per Christian)
- Add a comment clarifying that the flags field is currently unused,
  reserved for future UAPI extensions, and must be zero.
- Introduce event_type directly in the EVENTFD UAPI.
- Remove the INVALID event type; value 0 remains rejected by validation.
- Squash the event_id to event_type rename into the original UAPI patch.

v11: (per Christian)
- Keep the event_id to event_type rename in this patch so that later
  patches focus only on queue reference handling.
- Move queue reference conversion and queue-scoped EVENTFD handling
  into the subsequent patch to reduce noise in this change.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 107 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  17 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  37 +++++++
 include/uapi/drm/amdgpu_drm.h               |  43 ++++++++
 6 files changed, 145 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a75c68195df9..54bc31ee795a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -460,6 +460,11 @@ struct amdgpu_fpriv {
 	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
+struct drm_device;
+struct drm_file;
+
+int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1781c0c3d010..aaa4dd57099f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
index 4955ee942a1c..c777d563f1b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
@@ -24,14 +24,10 @@
 /*
  * Render-node eventfd subscription infrastructure.
  *
- * This module provides a simple event notification mechanism for render-node
- * clients using Linux eventfd objects.
+ * EVENTFD is notification-only. It wakes userspace when a GPU event happens.
+ * Event metadata/details are expected to be consumed separately through the
+ * corresponding wait/event path.
  *
- * Userspace can bind an eventfd to a userspace-defined event_id. When the
- * driver signals that event_id, all eventfds bound to it are notified.
- *
- * This mechanism is intended to support lightweight GPU event notifications
- * without polling from userspace.
  */
 
 #include <linux/slab.h>
@@ -42,19 +38,19 @@
 #define AMDGPU_EVENTFD_MAX_BINDS 4096
 
 /**
- * amdgpu_eventfd_id_alloc - allocate an event id container
- * @event_id: userspace-defined event identifier
+ * amdgpu_eventfd_id_alloc - allocate an event type container
+ * @event_type: kernel-defined AMDGPU event type
  *
- * Each event_id represents a notification category. Multiple eventfds can
- * be bound to the same event_id.
+ * Each event type represents a notification category. Multiple eventfds
+ * can be bound to the same event type.
  *
  * This function allocates the container which stores the list of eventfds
- * associated with that event_id.
+ * associated with that event type.
  *
  * Return:
  * Pointer to the newly allocated structure or NULL on failure.
  */
-static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
+static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_type)
 {
 	struct amdgpu_eventfd_id *id;
 
@@ -62,43 +58,41 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
 	if (!id)
 		return NULL;
 
-	id->event_id = event_id;
+	id->event_type = event_type;
 	INIT_HLIST_HEAD(&id->entries);
 	id->n_entries = 0;
+
 	return id;
 }
 
 /**
- * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
+ * amdgpu_eventfd_id_get_or_create - lookup or create an event type
  * @mgr: eventfd manager
- * @event_id: event identifier
- *
- * This helper returns the container associated with the given event_id.
- * If it does not exist, it will create one.
+ * @event_type: kernel-defined AMDGPU event type
  *
- * The function is designed to be callable without holding any locks.
- * Memory allocation is done outside the xarray lock to avoid blocking
- * inside critical sections.
+ * Find the container associated with the specified event type. If none
+ * exists, allocate and insert a new one.
  *
  * Return:
- * Pointer to the event_id structure or NULL on failure.
+ * Existing event type container or a newly allocated one.
  */
 static struct amdgpu_eventfd_id *
-amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr,
+				u32 event_type)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_id *new_id;
-	XA_STATE(xas, &mgr->ids, event_id);
+	XA_STATE(xas, &mgr->ids, event_type);
 	unsigned long flags;
 	int r;
 
 	xa_lock_irqsave(&mgr->ids, flags);
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	xa_unlock_irqrestore(&mgr->ids, flags);
 	if (id)
 		return id;
 
-	new_id = amdgpu_eventfd_id_alloc(event_id);
+	new_id = amdgpu_eventfd_id_alloc(event_type);
 	if (!new_id)
 		return NULL;
 
@@ -140,7 +134,7 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
  *
  *   event_id -> list of eventfds
  *
- * The xarray provides efficient lookup of event_id containers.
+ * The xarray provides efficient lookup of event type containers.
  */
 void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
 {
@@ -186,23 +180,19 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
 }
 
 /**
- * amdgpu_eventfd_bind - bind eventfd to an event_id
+ * amdgpu_eventfd_bind - bind an eventfd to an event type
  * @mgr: eventfd manager
- * @event_id: userspace event identifier
+ * @event_type: kernel-defined AMDGPU event type
  * @eventfd: eventfd file descriptor
  *
- * This function allows userspace to subscribe to notifications for a
- * specific event_id.
- *
- * Multiple eventfds can be bound to the same event_id.
- *
- * Duplicate bindings of the same eventfd are treated as success and do
- * not create additional entries.
+ * Register an eventfd subscription for the specified event type.
+ * Duplicate subscriptions are treated as success.
  *
  * Return:
- * 0 on success, negative error code on failure.
+ * 0 on success or a negative error code.
  */
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
+			u32 event_type, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e = NULL, *it;
@@ -211,7 +201,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 	bool dup = false;
 	int r = 0; /* duplicate binds are treated as success */
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || !event_type || eventfd < 0)
 		return -EINVAL;
 
 	/*
@@ -229,7 +219,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 		return PTR_ERR(ctx);
 	}
 
-	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
+	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
 	if (!id) {
 		r = -ENOMEM;
 		goto out_put_ctx;
@@ -259,7 +249,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 
 	/*
 	 * Re-check duplicate under lock to close the race with another bind()
-	 * for the same (event_id, ctx).
+	 * for the same event_type and eventfd context.
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 	hlist_for_each_entry(it, &id->entries, hnode) {
@@ -291,17 +281,18 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
 }
 
 /**
- * amdgpu_eventfd_unbind - remove eventfd binding
+ * amdgpu_eventfd_unbind - remove an eventfd subscription
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @event_type: kernel-defined AMDGPU event type
  * @eventfd: eventfd file descriptor
  *
- * Removes an existing binding between an event_id and an eventfd.
+ * Remove an existing subscription for the specified event type.
  *
  * Return:
- * 0 if removed, -ENOENT if binding does not exist.
+ * 0 on success or a negative error code.
  */
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
+			  u32 event_type, int eventfd)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
@@ -310,7 +301,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 	unsigned long flags;
 	bool removed = false;
 
-	if (!mgr || !event_id || eventfd < 0)
+	if (!mgr || !event_type || eventfd < 0)
 		return -EINVAL;
 
 	ctx = eventfd_ctx_fdget(eventfd);
@@ -319,7 +310,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	if (!id)
 		goto out_unlock;
 
@@ -337,7 +328,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 		atomic_dec(&mgr->bind_count);
 
 		if (!id->n_entries) {
-			__xa_erase(&mgr->ids, event_id);
+			__xa_erase(&mgr->ids, event_type);
 			kfree(id);
 		}
 
@@ -352,22 +343,22 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
 }
 
 /**
- * amdgpu_eventfd_signal - notify all eventfds bound to event_id
+ * amdgpu_eventfd_signal - signal all eventfds bound to an event type
  * @mgr: eventfd manager
- * @event_id: event identifier
+ * @event_type: kernel-defined AMDGPU event type
  *
- * This function is typically called from interrupt context.
+ * Notify all subscribers associated with the specified event type.
  *
- * All eventfds registered for the given event_id will be signaled.
- * Userspace processes waiting on those eventfds will wake up.
+ * Signaling is notification-only and does not carry additional payload.
  */
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
+			   u32 event_type)
 {
 	struct amdgpu_eventfd_id *id;
 	struct amdgpu_eventfd_entry *e;
 	unsigned long flags;
 
-	if (!mgr || !event_id)
+	if (!mgr || !event_type)
 		return;
 
 	/*
@@ -376,7 +367,7 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
 	 */
 	xa_lock_irqsave(&mgr->ids, flags);
 
-	id = xa_load(&mgr->ids, event_id);
+	id = xa_load(&mgr->ids, event_type);
 	if (id) {
 		hlist_for_each_entry(e, &id->entries, hnode)
 			eventfd_signal(e->ctx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
index 248afb1f2f14..e13b86240afc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
@@ -28,9 +28,9 @@
 #ifndef __AMDGPU_EVENTFD_H__
 #define __AMDGPU_EVENTFD_H__
 
+#include <linux/atomic.h>
 #include <linux/eventfd.h>
 #include <linux/xarray.h>
-#include <linux/atomic.h>
 
 struct amdgpu_eventfd_entry {
 	struct eventfd_ctx *ctx;
@@ -38,22 +38,25 @@ struct amdgpu_eventfd_entry {
 };
 
 struct amdgpu_eventfd_id {
-	u32 event_id;
+	u32 event_type;
 	struct hlist_head entries;
 	u32 n_entries;
 };
 
 struct amdgpu_eventfd_mgr {
-	struct xarray ids;          /* event_id -> struct amdgpu_eventfd_id* */
-	atomic_t bind_count;        /* total binds across all event_ids */
+	struct xarray ids;	/* event_type -> struct amdgpu_eventfd_id* */
+	atomic_t bind_count;	/* total binds across all event types */
 };
 
 void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
 void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
 
-int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
-int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
+int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
+			u32 event_type, int eventfd);
+int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
+			  u32 event_type, int eventfd);
 
-void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
+void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
+			   u32 event_type);
 
 #endif /* __AMDGPU_EVENTFD_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f5719500527f..7cc54b7e3b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -634,6 +634,43 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd *args = data;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	/*
+	 * flags are reserved for future UAPI extensions and must be zero.
+	 */
+	if (args->flags || !args->event_type || args->eventfd < 0)
+		return -EINVAL;
+
+	/*
+	 * Queue-scoped subscriptions are enabled by the later
+	 * queue-reference routing patch. Until then, keep
+	 * queue_id zero.
+	 */
+	if (args->queue_id)
+		return -EINVAL;
+
+	switch (args->op) {
+	case DRM_AMDGPU_EVENTFD_OP_BIND:
+		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
+					   args->event_type,
+					   args->eventfd);
+	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
+		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
+					     args->event_type,
+					     args->eventfd);
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Userspace get information ioctl
  */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..bf4fc61cf0c7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -39,6 +39,7 @@ extern "C" {
 #endif
 
 #define DRM_AMDGPU_GEM_CREATE		0x00
+#define DRM_AMDGPU_EVENTFD		0x1A
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -79,6 +80,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_EVENTFD \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
 
 /**
  * DOC: memory domains
@@ -204,6 +207,46 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+enum drm_amdgpu_event_type {
+	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
+	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
+	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
+	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
+	DRM_AMDGPU_EVENT_TYPE_GPU_RESET = 5,
+};
+
+enum drm_amdgpu_eventfd_op {
+	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
+	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
+};
+
+/**
+ * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU event
+ * @op: operation type, see &enum drm_amdgpu_eventfd_op
+ * @event_type: kernel-defined AMDGPU event type
+ * @eventfd: eventfd file descriptor
+ * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
+ *	      device/GPU-scoped subscriptions
+ * @flags: must be 0
+ *
+ * This ioctl lets userspace register or unregister eventfd notifications
+ * for a render-node event.
+ *
+ * Eventfd signaling is notification-only.
+ *
+ * USERQ_EOP, QUEUE_RESET, and SCRATCH are queue-scoped events.
+ * Userspace specifies @queue_id when registering these subscriptions.
+ *
+ * MEMORY_EXCEPTION is currently GPU-scoped and requires @queue_id = 0.
+ */
+struct drm_amdgpu_eventfd {
+	__u32 op;
+	__u32 event_type;
+	__s32 eventfd;
+	__u32 queue_id;
+	__u32 flags;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.34.1

