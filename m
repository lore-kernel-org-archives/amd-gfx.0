Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E3DF433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAEF10E7E3;
	Thu, 16 Apr 2026 03:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSx8Wov3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2872B10E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh6dL9TlSQZm5A7PuDJwcqlxjFckdN+pM9eYq7Rh6eKiwGhdSwqPNUk9nUcylJ8+nQxXw2MXrw4CUEvdB0hbErf6dGDICBAsO8kzLnI/x/sdHzD7nlnfsMaBRsxOyMGhxP0TVtqojJqB+oS1C9sJcSjUjTX4ErnQLVPf0iGZn/w8lvZSnnPau2j16Kz9aht2yJFwAKCEqUwePVT3yg08rj6H8SCVKuvvCaJPa8G3DleDG5xfMfTPeO9czsYuEHMVVHAj2G4a/3EFfDlsQEaOe1B1xRs3NxN+R7/VMh6XQfFD4bfU/QYMxajnqjsWIaoDN2Euaul8exw3smvJ0t8Gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W34XZrKWCYBNagvdSxFh8W28a65LXehpKNjqt+dmZ4A=;
 b=KEquuE34sitKGCoZNxTGmZEzD3PnrNIaJuctWu8aJ+Wj1ZQznl1M7Q6z/ZXiud2bH0Spr8AjlVki8qFTrHR+VYFHugbBY5v3ZCWsxJ4FDhaaLwl9lYddEixNpb+wNmBExogBkyuBzybXadfFfuRoUZbgn/yavB1ctG/XyJcNKnx83Y0dv0VZe/HTwD30WyRYUxjG5atI1jKdQ+gtsdZtfx8JqdAjzSNhufk5/ROqmHPuzlR64aBUKSXkjSEnV23xljYHI8te0K6oGCKLCe3OVxA3mzN+lMZ6jro0GEliOz6GD/0qnK7lWs7Tisr1dh3wwgOnKrwIhKChjr91Wlk+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W34XZrKWCYBNagvdSxFh8W28a65LXehpKNjqt+dmZ4A=;
 b=VSx8Wov3D8zyWVZZkTjaJHhTEKGy8K8ZvlOQY1FbB+VGvpBOnghWrKoW6L5x68qdGjkJAauWmWFpD26cfvcE46OcMc6Fz+j9bGQcDzkzd2UffN/CXdP8Cu0dvabdjLmnYmYKq1QUIfFpYVIvUrxgaqRs7am9YDI1eW6y73M8eOs=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:27 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::d5) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Thu,
 16 Apr 2026 03:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 04/10] drm/amdgpu/uapi: Add unified EVENTFD ioctl for
 render node
Date: Thu, 16 Apr 2026 08:56:53 +0530
Message-ID: <20260416032659.2368054-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: abc004ca-9636-4e00-8ae5-08de9b681589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: w/mplaMZT3sbs4zadmktR13BeL7B2QtrO6pQ5vRY+fM3MpBVb3DhvcvLC5Bcua5F1B7U/5+75Gff5TPzjp5NvnTc/5Rt3mu/fUxWSYXTqngTUTHV8ltzmdnxfI4tpGG26Uk348Uldg2yLPpRRziz4pf19bauzaBPN6M5KNRaYosV1C2vanQYtI1nIwZrlSPAf3qeM+zwL9qnh/5rladqxAd+U8S42lc+Xw2L9jEuPSNxjOyh9oEKhDeFAhIWyx4Cubh+WrmDTLEzTLam/TVJcWUt3MuWq+CR6MgGWGUpNfD2PpFppGoJRmkEadoeWTfdPYxjr4e6+1uYnaK5A4zBgefcMAdqC5NyiR4C08uhx6PODjbVfv08fqdsO8MN7y1e0cU+4wLjGyTfV4QdbjXemVkjVb+Cnfp+lxbfvJ8iO67PYkiNueqxumHsb1veG85y3DxK3j10RbZAZljfGRx+Zo+VChi89lYe0FWHO9Gk4G+49aZEFjmYfJozMdd3A6YHy18JvFXEks4Oi2f0WdiLODIMYZFq/QF0ErCRXOQFMWnuVO0TN0LX3oa3KQwqLGM6S2aFyVM7wwjyTRk2MNxpYmPhItMexveUrtx/5iupgRTMff6AcgRsyGPMRmjxK66ALetqgGFVDtjVb9rG6wU2oyHKqTcdiNvKl4k2vW592ZZdhKnHYgVmlUDCNwz17MQ1ejw2UkCkGoKQtLJVNvHmvWVVosOIxVqgYRMfrL51JiKnc34pzyQFrylxsO6jj4lD8oHgfCS9LSL8m7qheyQ0Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +SQ+KPgWJ3OGVtmg1gBPYSO/fu7n7SSm6uNxvP0XiaoTxXwxEGa2iVXasUH0B4ZopMjoLOvK8Muk6PopHd2+UT4Vw2eVOhQMiiX2nFsBE7hwNCQ/w6/h6lz95+KyJyEYDC12BfpaTJLbGgwuTGYfDFh4qyQWf64E2MllieLe+u4+KlPHs78oGuQRMHj45s5tnVH+pujWsr30yRHsbyz0nSGCAnG6nawb0eljzNx/7C84C5oN2ro6YdF180DZhPG0x1Jmg9GGP7NWq++CTECpNhlBvz7pV6RL5O/8mQHxsSMhqsDKqKkT/uPp5ikLvqVQdvcJw6spkrUuvefpmVHdAHASPAkLGfXHrtnpjFGR1cSamdBID2wBRis6g/1YGb9qRIg8qaWGEl8hMkPsW5t95ZJK8l1glYS+D5t+CmCft+aVXRlKEa443V/drYNO9AGx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:27.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc004ca-9636-4e00-8ae5-08de9b681589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

Introduce two new UAPI ioctls to allow userspace to bind and unbind an
eventfd to a userspace-defined event_id on the render node.

The design supports multiple eventfds bound to the same event_id.
Therefore, unbind includes the eventfd to remove a specific binding.

v2:
Replace separate EVENTFD bind/unbind ioctls with a single EVENTFD ioctl
that carries an operation field.

Also add a queue_id parameter to the UAPI so subscriptions can become
queue-specific in a later step. For now, queue_id is reserved for future
use and must be 0.

This keeps ioctl number usage smaller and prepares the API for queue-aware
event routing.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: Ibe6a3be80f6435c1fe2a3243b63e6ed2fc6391ee
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 33 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 30 ++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a48f8c214699..30df0354f44c 100644
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
index c6546a858597..f4acb785b3fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7df0e7fb2864..57644deec724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -634,6 +634,39 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
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
+	if (args->flags || !args->event_id || args->eventfd < 0)
+		return -EINVAL;
+
+	/*
+	 * queue_id is reserved for future queue-specific subscriptions.
+	 * Keep it zero for now.
+	 */
+	if (args->queue_id)
+		return -EINVAL;
+
+	switch (args->op) {
+	case DRM_AMDGPU_EVENTFD_OP_BIND:
+		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
+					   args->event_id,
+					   args->eventfd);
+	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
+		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
+					     args->event_id,
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
index 9f3090db2f16..63cde4487c47 100644
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
@@ -204,6 +207,33 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+enum drm_amdgpu_eventfd_op {
+	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
+	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
+};
+
+/**
+ * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an event_id
+ * @op: operation type, see &enum drm_amdgpu_eventfd_op
+ * @event_id: userspace-defined event identifier
+ * @eventfd: eventfd file descriptor
+ * @queue_id: queue identifier for future queue-specific subscriptions
+ * @flags: must be 0
+ *
+ * This ioctl lets userspace register or unregister eventfd notifications
+ * for a render-node event.
+ *
+ * For now, @queue_id is reserved for future queue-specific subscriptions
+ * and must be 0.
+ */
+struct drm_amdgpu_eventfd {
+	__u32 op;
+	__u32 event_id;
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

