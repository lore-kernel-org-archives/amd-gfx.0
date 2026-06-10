Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AF3CD98C6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016D710E71C;
	Wed, 10 Jun 2026 06:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="12f8T0CK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 327DA10E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neArEOawi6R4J/hkkkwF1ZBXW28smmR4hJO875B/TlD+NPxz3v8QuPMro4vHzgvFylbOfCelkVa4zwGT23CO5qzoN8r/kLJ1sglNW77wEojyB9fI1uRhXCyWVE8UyoJ/3gfsIj6uDYNlePH0DcZgGYaK8qzt/aFvfekmn6Qu3hDg0pAu/x0RbvzUGDnhfYlvmcV3NNE15gyyGVKUV3mnf4tKVoq5ANpD57vZeKVEDNOsLhI7WmMv4PDY7QYpENTOm8fxQs5ZAm+UYES5FBJzMU9uy7f99Jlb0IEHNbhZweb8sMhbyfywY2tjggsEmgWSBfPEPhZ7WXUZ/jlb91yWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU2cpFtLFU7E0gMddKqtZuLrk9mfaZHsMVo77FJ0a1g=;
 b=dynj7IWOkXNlexr707szYS6u9rDf7GWHYxN15SkEZC5qKvG/vQz0Pu5oRjAHcfjUTjrgmTNrbynLPyije29MFunYoAYaS44Pjge1QthiOQ0xDaQ/rp0mF/i3eteALc9NjbORsWOzFpaxO1dPN+dfmtPtmTOfN9buoJEkZ2IbLEbtM9W90dcv8SqcWOhwG9Q6X2ICfWBhWrVNi6dq60jnKfeJiEVQSpCghC+YCOoA/uMFNk5Pah1KkYbPrDrzPHqhIpGTQz56TgKXPrH5KN0jJqGFoOMM2QokzVmy11KJiITPYeAg1nSjG+rLzK6zz+1bDVF8BMzqrAg1KoqDf9Ky2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU2cpFtLFU7E0gMddKqtZuLrk9mfaZHsMVo77FJ0a1g=;
 b=12f8T0CKjy/X0jT9eeL7p7b4sRvO+Wo6oVHYqnYvVDf3gT+za6K5ukjOBmZriRmVox6xp4c0IHuCMR5tyPAeobrPvxp/6UZ+Qt3K0FEjZcanPm8ZYGA883xLh9dWg1PfBrwgJApsTQ51NJ1EInbXMj4PZvRnmzqMvi8YFKVJO5s=
Received: from IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::6)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 06:04:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::6c) by IA4P220CA0008.outlook.office365.com
 (2603:10b6:208:558::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 4/9] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Date: Wed, 10 Jun 2026 11:33:57 +0530
Message-ID: <20260610060402.2769642-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3127a498-a543-4f8a-cc57-08dec6b6274e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VGlPr/FobKPzziOMO5DBNrd1LvAwUWaheXYIbda3AsRbARTOyTZMh+AC5u3Gw9BqKa7g9vjoog9aiTASJpmP9v3eE/ABxQFhpjR5QU1XDFCZv5V5Wqd21dBaCEiMOtDbdzyHeQiVu+Ou3KQoAjGjGxcxpr3PUTMEBh3JFN2nWpCEdYyY+T8cYGFuxZlorQ3jn+vTxdAKVZGbYGqsTHdlgUlcgG3NSZJDPl2dN2F5JzYUDJhWP33lEeoWEtnqepR9DWkis0829b+GhQvCfwIawO2UHhkYojRts/aBCYQi0jElwFEyQ4yj+wlBbGiHOAH4T1DtsBw83QuWfk0xs/4cEi0v1h7fzl18zGeEpPIx7HNPgRVDBWFNnG81PomSqe5k0IRutbb0XpgiK2cZnSmphZG4NjxyY5Uf2X6jRQK6L/2lYV83TQyQFBFhh8jTZ5X8TrAKd/c/U7/1LT8XNKh9I9NbyJODenURoN50sL88481yBHr81vJVXRzOIGWksdIQq0nhrKZI7KW255qGWl1BW2aDliCD+vgiIwmnoODv0qGitZiwDcgR2zJHYGGHm9KLh+z5wR9OcLG54+puD7pAzzsazOQWQe0nrjnR/X8RT3Fdor6sxCu910Gn1BzPOdjnuYMfSPTWMObkghCJLAF5UbVyZW/xOhGJvh4HomfIRODH6kEMN/i0h1SXGEkPoTVdjJy6VFSjsss1LhiThmjkFxegW1nbuws/Qx+bAxG1Kwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D5lKBykgyO2JWFb8WFJ64y5v7YAQJyv5IVW9KGjjDfPLuYvR7Ezxp2VwFwN2Qhe8JYmfTnH4WXikL51gZiOuHGrtpR1LhCudLOtOPXfQedUcDTHwvXjMl23qETU2idkWWHUGQXhrEV8q6HVzPFSCJE5oWIpKfCVnkDli4nsmzgo3GCjD6J6RLyUu1FDBaQp2A5/HSpxWxaHMFtTSLuA90XokLnRffin4guOj4XKKfVmLjBjtLoxLDpiccbCyPJzTsFaM51Pe5gnWhJDdvYWJ4xZ0W3/Rfc19ioILHP/XnmVHTkP+AFO8GrHoW9vZFFirbuh0uMdYCp/Zw1muYzDnrrB29m2RVKOkZ+NMI25ZYtRnNstbL8t377PE4Ac6FKX8TjMdILIxYPTwyfe+pM+dmWNAqzMcSU0VrG6c2DShQKT81zM9qc1KDRoRfvASVZTE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:37.8674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3127a498-a543-4f8a-cc57-08dec6b6274e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 36 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 43 +++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f5719500527f..f7c750094393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -634,6 +634,42 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
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
+	 * Queue-scoped subscriptions are enabled by the later queue-reference
+	 * routing patch. Until then, keep queue_id zero.
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

