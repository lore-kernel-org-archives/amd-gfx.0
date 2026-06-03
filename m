Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0E7CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D786A1120CA;
	Wed,  3 Jun 2026 16:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IFI2UN+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5812D1120CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP0K/XfEDy7JNXysDrXv20F/59cuXmPLeRfNnd0qlUxYAwA7sODQPlUMyMiH3nP8vARZkKNYdkdKT+IgOInxDjm+Vp/vJvb0VdAAxu/VQUaABxxo24QMV52lr1YiBoAlo+TYpsL9cs9GShX+Svwl4dsDRGXeCCf+slHdLVAFaHLkp3jScgPZ2p2BfxwxWAHuOLB7o8Skxxtx/+UcWsX7ZnwE76YNZWjTmnl+w+43eeIr8JEjywjfyvel92DL3XjwpiL8DoCYZqIy9L/j5ehQcx9AEHRTI2eN16h2HBWlxxabz7F3FWCxqTSM/WTtGccdtJ+G/10hGtHhV9TtEd9/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TyeyXcuSXxlf/pl9b7uXUq/+Qfwa4hArva3H48iQJU=;
 b=pzPJKjNd1r1LpX3/Ks6Fi6EsMFBG6d9ewQHJiQ3s2W1jfRfBj3bUJBDpRNinUgj4aZQuX92FV7uIc7EZz+TRdI9lJhIbwQlTy7Ec7ui+rtA1/mbBq49c4eUqB6PU4r0yiIiv6VHcLNMKGzraZTQjmuFw+P93VVoc8wLv3q0N5eEh9trc3oRtXV0iLg3LQazECNTtxjWNYW08Aep2o1BVLjsg07uNCO/LP3JDK7NTDoZ6dUv+jVcR7jgGVBInxK6uHcrTUwuuQsxH7rtw1536nKFQ95RuFES/VTkU7/Q7R+sX9PBSUpknCoGvPbXddggR9bqoEz4ef8NV5R1nK1RkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TyeyXcuSXxlf/pl9b7uXUq/+Qfwa4hArva3H48iQJU=;
 b=5IFI2UN+Jg9IWKePmkDbHgUpnLqfY44gVZjZU+EGNGm/xVxDplOQQYWmZ1L5Hw6MFR+p05smHryTj1DlgE3f00psRTaJEw+MvsZHtFU/bmNxvcDQ3wpSDlngKlCqKVjVnRdV/lCqCR1j3y+VDUfgugrSFU5T8T1GFRZ2wL4mqkc=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:34:18 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::8a) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 05/11] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Date: Wed, 3 Jun 2026 22:03:44 +0530
Message-ID: <20260603163350.2678309-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb980a1-697a-47c7-e7ec-08dec18df4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wluVszECoBcjhN9eWxFiMJfiFf8OqqqGvA9X7NANULjfA4mg5Q2wDP2wt3pk6l8Guno2IAtHG+ntOLDiiPfAmRmNVz8WuffS5tx6p+6mTBTcnDPKvXQU5F1mp48FJGDj5KE5dThFs5E+HmJoKullh7jFNuNFL6EWdXm8lvds1V/4UJPjmBP0ufsBFoiyVlJ9JpfXrvhQe0bV/mZ7eifj6Nog73ZKd3hHMX76lRAdJD9qo8MqdMePvqARgRYO5qljPvt10BTNLedRIsSivJsh2LUDosERCGZOl64y6ekm0Ao4U1N7HBQPKrySj+IN6+kVTB0vOgTPWkgeSeRsSxkj6UfMDgPbiGkCSTHbAjhubvxlHF1hbLu6UgYxeX8D6BiXRC8jSmJjPYZWNDi69MDCgXQnQ1hqQPAKvn05mtYvFWo+grtdhUgl81xcZnhSycGxhTHF7fDD9i7KaIDiNWPm9kTmQVb5CqtexOPdCTYHudH9f+s7FV2Vhw61jP/str9EGnFky76/qE9i6LzevEBwNKRtZDyalRgNVEjx34T3R6d6D2zzo7dZViqeccx2dRlqxwAdCJPUK1IK0jXjjNXOWbOFiMVYXr8cttqyX5In6KmdsLsPkl4fKrPuzF49eFtnHbx8ix5tmw64PruBkS6A7j5a2Y4YgpcPxTD85zs0vlH6Mt2G2d8S55ykp0WQnpFanWKOS9mTmbjr8ac8wD7ncXNevz+CEh9xqE1v7rDQe9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wQVqzA5M2bry3dA9xLD9ZEnEbZPZBpFPtZnf3MwcabL5WLEfLjJsMAJ6qH+KPePHI5Zgdy3LhzW/LYOBefqMu1+AVz/phOD5EzdO4L+jV6r9yOeEcMbPoBz4qCB5LvUqRGdrCF4jJ6dUSqPFWnJ2hj21NNxQJ9aPWckNEhcoh1OO7KpjLbEY4fSd5xwbabXp/OTBxdo4d36ug0xD6G47aVjoadlU7fUDmabif2hUJnZDn7RFKzAFBixyjMWGGx6mM0eroPb2ql7mRM2D9NjEQy0oyLcjso3Z/b3hIuZJH2yVokBM101HEgTuyVQr2hHpkxgCUskOXAcaes3x6E6LNJmbWg/weCWesj5Pn3Zzbi4vuRA3ScSPOhtGGCYygwIf9kciQ/OvRzMcBGGuvTLO4RKoJEhHWWa1C1SrhU59CTuCSy+MDaPxG2CQBoPxHcJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:17.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb980a1-697a-47c7-e7ec-08dec18df4a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

The current EVENTFD UAPI describes subscriptions using a userspace-defined
event_id and reserves queue_id for future use.

That no longer matches the intended render-node event model. Userspace
should subscribe to kernel-defined event types, while the kernel keeps
control of event semantics and signaling sources.

Add a shared UAPI enum for AMDGPU EVENTFD event types and update the
EVENTFD ioctl documentation to describe subscriptions as notification-only.

queue_id remains part of the UAPI and is now used to distinguish
queue-scoped subscriptions from GPU/device-scoped subscriptions.

USERQ_EOP, QUEUE_RESET, and SCRATCH may use queue_id for queue-specific
subscriptions. MEMORY_EXCEPTION is currently GPU-scoped and requires
queue_id = 0.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 include/uapi/drm/amdgpu_drm.h           | 25 +++++++++++++++++++------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cd127a271c19..75fc3a74db28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -643,7 +643,7 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 	if (!fpriv)
 		return -EINVAL;
 
-	if (args->flags || !args->event_id || args->eventfd < 0)
+	if (args->flags || !args->event_type || args->eventfd < 0)
 		return -EINVAL;
 
 	/*
@@ -656,11 +656,11 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
 	switch (args->op) {
 	case DRM_AMDGPU_EVENTFD_OP_BIND:
 		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
-					   args->event_id,
+					   args->event_type,
 					   args->eventfd);
 	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
 		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
-					     args->event_id,
+					     args->event_type,
 					     args->eventfd);
 	default:
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 63cde4487c47..3dffd9e581a1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -207,28 +207,41 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+enum drm_amdgpu_event_type {
+	DRM_AMDGPU_EVENT_TYPE_INVALID = 0,
+	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
+	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
+	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
+	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
+	DRM_AMDGPU_EVENT_TYPE_GPU_RESET = 5,
+};
+
 enum drm_amdgpu_eventfd_op {
 	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
 	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
 };
 
 /**
- * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an event_id
+ * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU event
  * @op: operation type, see &enum drm_amdgpu_eventfd_op
- * @event_id: userspace-defined event identifier
+ * @event_type: kernel-defined AMDGPU event type
  * @eventfd: eventfd file descriptor
- * @queue_id: queue identifier for future queue-specific subscriptions
+ * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
+ *	      device/GPU-scoped subscriptions
  * @flags: must be 0
  *
  * This ioctl lets userspace register or unregister eventfd notifications
  * for a render-node event.
  *
- * For now, @queue_id is reserved for future queue-specific subscriptions
- * and must be 0.
+ * Eventfd signaling is notification-only.
+ *
+ * USERQ_EOP, QUEUE_RESET, and SCRATCH may use @queue_id for queue-scoped
+ * subscriptions. MEMORY_EXCEPTION is currently GPU-scoped and requires
+ * @queue_id = 0.
  */
 struct drm_amdgpu_eventfd {
 	__u32 op;
-	__u32 event_id;
+	__u32 event_type;
 	__s32 eventfd;
 	__u32 queue_id;
 	__u32 flags;
-- 
2.34.1

