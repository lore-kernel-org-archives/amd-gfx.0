Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89AF94CA4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5076B10E89F;
	Tue, 21 Apr 2026 17:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cak9+lay";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE9110E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab+mFYvDED6/ezV9OK9lsTTLCj5Th0t59xznrpB/y/JYkX1PB6n/PGloRIAPOdXeuqjgEtv9mJcN3s7s5Gzey/8hL4uPkNyBcDOlzyxWdWgu9shq7Zjz/YNtztVIZlUhRDPC9EVCRc+piDuVmGIPVimPTaM/O7SnqZCs0J+oWcwjou8RYMLmSkzOs53h+riz5llLe2E7+/E0LbGn2tQovhnIWD8n4wl5u1MO0YocF+ER3xqXqzOPSiaxXuLbRazSYBLNtCErlD5gze1RCGzFHgjsFjBtgWyLsP8+JV+uASUX0kN6Q6XgUeqdFKEyFbvhVmRYFVxuO7dNc2mVmWsxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W34XZrKWCYBNagvdSxFh8W28a65LXehpKNjqt+dmZ4A=;
 b=R+SHUOJCzUHYnDBy/7o4b1RP9GCOMVLBCtqpGJsa5748EazzdbRTvghUaRK4pbwslEMpIsI1EBX94xYH766U/cfi2hf4oove4MIs5+IsTS09j28RZ3ZySElfBvviSlJAROBLn9U6S6PhyElrmkoLxNmg1ZDxy3k6xQS7N3E5ZjlMQ4WqA/eC4pV3kOmNyfQ3vpPBCqyqeWfSh+fZicbs91COqMERDPpkNnYAOn1+piL/YRIAvI9QiIr82ajTPtB04fFoVMT3qjQxld70Km8JBEqb1WHHgJgzUEgnquxZNlaOZMoGYPJTMr3Sp/UnvnyFHH5Z9l+SfP2eK1WOCL+cmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W34XZrKWCYBNagvdSxFh8W28a65LXehpKNjqt+dmZ4A=;
 b=Cak9+lay7u79greztkeR8gRBQhZugyT2YIzM00Tp39yvn9qNcepNpf3XSvrNkkVq8bqVdkLHhuDZ61eTvqu4hf4s0BHRJV/6rRe48p2o6nS1E6O3RV2sfC9W2A//KPpOfV/dtWXg6Sdmrr7shp9fBB3KpGTyhpFYDIz5l8uCVEw=
Received: from CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:59:34 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::5e) by CH2PR18CA0023.outlook.office365.com
 (2603:10b6:610:4f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 04/11] drm/amdgpu/uapi: Add unified EVENTFD ioctl for
 render node
Date: Tue, 21 Apr 2026 23:29:01 +0530
Message-ID: <20260421175908.2402019-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 32499553-99b9-4280-3061-08de9fcfbeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: u5yLvJNFf1c6U6CLXQ61pnBnpH3fp3IC9/dtbEY8VXwLN7mrKtnmtnvlZnwYw5osIPld+tDAHek/apCoEQ8FNCbuknj0YQaa5tc1oBXUFah5EpcdXWZ0EWo/KZBgc5AlcUsYwqHYNMnX9Nnfp9Qi4Z+0FznrIdT+eBeIG8NoGJR0sRfWmJqWXcfBkpTqsbMYjjgDItN/ETKpj7ErRzyreGQVefMgYwx+pvT/4eic1ChXqLQLIdixn50t5CtLHqNkbkNBuiWiYfyt989aERYKQrpFE4s0KdZLvNnTbzNp05UsgYhXl/VoEmigh1/BxezJNACitBNfnhvpNS8w/yjsTRpBLI933VZ72bSxf831yQZ8orSJIQDYcAL5TZxo0mvXG364CQX15EcZf8boqJ/09TFXyrB/74lrtHbCmZiE4VNP7sQSUF2RbenCdn0DUgDL30ResJyudZGGRsjO582ZdHCN9ePfqg3X3jcQCThgRLpkiHsyZTB+56qUcm4hkZVtdqiAIJNpdftlmkfdmE6W0yElEc8ngJ8N4YF27I6nlg26sskpoxMb37jX3cRkNbcS3NM6BmuT/kPyBnOjmtKFIxIb/GHBc6qtiyO/035zvpAKAIK/BtA4narUsVp1aw3xpn9LR4nEbsArYnOYQJ5sFxNUrCwbghu7LG738fKbs0YdKSJ5lbxWrS1c1DgdT+Mu5FQyTmCVjMdxjlxhp6+u90jMmhpu0Bo4XJmfZKbytRp7a+HfHuqiSTQWV9CDDGWgksDF7kadrfQu3XT98ZSSPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dGRjfXaPLDSxY8MmwePvQaDxDvPOzoN4YTlVn1t5yB5gCwUNcBHirgrLe43WW2NG/F25LYUncCmYm2uUNu3+OBB57DFJwpbIOfpCIFsSuTmo8l1FHfOWfTgT/HzbMS/BOBxW5PZ7/pkE6DYWOvfkdBaClmH8cev6TbVDvhuHiSEoChEzMCcAgByp2cUzn4KIyUHj11buQLR17BdEBeCAfY0Cwl5H6ZGZJF+FXJQW+x0oC0ZW1rKoXQngygiWfREus4gOKFcEmgNL3i6v4WQtjoQGgNP4yeRqiYJiYOEMY92QcqoB2FLM3JDhGxMphUfeVtSJFC2DiOWiOP74hMfELNxD5XvZIJkpYEWjvXlBXOu2vO3Y+C1dkfvxHdsC/LqaZEIKbiekPuysLNsIdLKS9Z/m0TB8LkYgs2xlySdRIdfEL8F3astZaRP0q3C+ghOs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:33.9052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32499553-99b9-4280-3061-08de9fcfbeb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

