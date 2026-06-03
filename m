Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63D7CD6E6D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228211120C7;
	Wed,  3 Jun 2026 16:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="baC72nwi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828251120C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nygzVyPr+4IAdPv/yzAMvlo2YKyt/KoGiH7e19HUyZRZemyhOUVQqDpSTqJKqrYg+rth8MhIhuyukkJMoysgI5Ufx+E2I2fnN8ov52RZ90XZhJNYH3sH+aWInVv9G8eROACkTlrYNvga5rQJcnpSKZQ75EqYqcQ+ZIkblyPlqWYbF5549vEMQ/Knj2cMzeJeeBzg+HaXioaG5yVQKuNAjf1UK3thJcoqPtskLT3qjosKkQbFia+cafzvqcVDEzAM3u1OIMTrcCYSSCCgCOypn/N9sOCdqn5AH7WpwyOlG+CtvsViX096xDnfgOcooa4+Q77taCIVQ0hhaaw/zOw8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT9fgb0Y0jhSd2/CA5nI6IqLNmSWJw/zaNz3nURiPiE=;
 b=xAF2UAm2Ps0G0cZxjOj7MQYOHSfHxw8J/Sg14HoiGBevsD3P7dPPKV6z8NbFEqbr94V/AbrAe+y4k+tud9fk5PQ7AWMbyCCxxDTLxO475woYSC/ijZ6Za20thelGBtJbJ9Z8/Nx7emEEQIayh8q7b3nLD/6pkednmAQSLqf7Nl1KM4LNldIheNUOvvI6MXqAbTGJaYuEMzunzhm2VtAdNKp/G/Sq1gRVUN3v+Zw2AeqDXRlmeHQrEAsvAl/SE+kKfk9RTeXUj4bjjr3XIv40h2kfnmGLPNJHNGjy+1BP1AdqVTx4Q7J0ZUSWfRvfU+rdkufN6bIm2lvf1cNyIyo9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT9fgb0Y0jhSd2/CA5nI6IqLNmSWJw/zaNz3nURiPiE=;
 b=baC72nwijSDy7WiGvqQHVC2w99NSdmT+1EVuOylMLrZPOfp+eORqFGe6maisi8guskxSH5WcMxKolF6rfI7bMb2jtY7DDhSgCBIwAdqq9SJNxHOk3qPvh8DK6UkxrcZa6yN1EUr0Bs/9ErwWC+1z3wL7T6T7lpr0dtEuMEarTgA=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:34:16 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::5e) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 04/11] drm/amdgpu/uapi: Add unified EVENTFD ioctl for
 render node
Date: Wed, 3 Jun 2026 22:03:43 +0530
Message-ID: <20260603163350.2678309-5-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: d587eb6e-ee08-4566-308b-08dec18df396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dDmmrD+Ulc5fEvW6Qr2aKoaIzKNu8ezziaeP3TFmf/ogSyU4RLgGdKCC6kgv+Xg+iGC3WNTpmZCQgW2teASrpLIU2TZwHh8lHpJJVP9Jj93nIPMthduW2AR7Z1bT56ZLattTs8Uh4I9yFQmYilS4KIkf21yoEXPLa+DaTCOW/nHeOcw3wwFN8qtYsDflSVS8vQsWt0j/kor1BIQWzd3AQR+UPFcCHHiAXrg8UMiOVi1pxbb/koiASYtfoZvQ5Q9Z5XtWMTChKDwMl3xRsvHGQSWrHw0rRn6Xpl04Lf+SaMPeV/r+xtQnYR1h0jTvKWuuJYUget1LDPXXzoOWCUufjJcbQGM89Y/jym+T+DGlk3xob5c5nrBlvedtD8d78taPt8341WkBvJRR3WRYaGlkFI29pqYq3BowymPVFaTUA4XcATA7V4j6GPtYJnAk4rsv7BUbTt3uSKPHtDoDj4V7FGilCcTSXd7K7ScPf6r1jndI8/UiklX2Bknee9Aso/14ZnMrrvG7sdzewDRV0XHdqbhVK1SJPIwq5sbkZnItJRYKC9QnRCg3K3dA1xpoNj2lyjQ3uBLLpUEYUZFf6uPB9J5Y3sH8nXTFxgUp3n+StkgKVTtOex7XYEDeOooAhrs77rxaK9YiPLY2smPmbDQuWYfQMA/nYcT4RITZCJ7xMpY1DnP+fW+UejN8liuO8iE9dbHyp3i/qz3Gq1skM5zWKU7ZelGaHVEhOQcJ0Cg2m7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nxe0MpWHeDcVXdyFl2fckgV/ayrJvoTZugih6FVDVzKFoom0dxD8AfLvngbZwlxRp2X26SxWQxCfJXMiRY2iw/tmEmjaCl8jZrCtt56kMMXdvNlCltcWvgrdR0xpyl7L9jBrNLXbTY9NbyrSd++kVIkrbuw/LCKLMJc1tSc+w6oSD3H5tnOq/8pS69Ybrel0otmq6gHIkCiWGRtBtaQOG0/QGZu5ZdWKGy0zFPiEA1s5W1GJvpbKbWGMYJi4z+d7bjoSY+abhCsdyG9h7LvBr+TPHA0kWVeNJUVcDwSBUZpfFl5QneL00X8i5Pocy48Im+hwveAVqkhsgK39NdqFWq3eKLFb7tPIv7TUaZxn8jMTcvnXZJVWdgMgtZfUwzGfVRRNlxBgH+s7uxgma9eYjqF8ykqZFOd1R1pYRHwA4K+OoWXglc3a7yawatWZR2nF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:15.4021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d587eb6e-ee08-4566-308b-08dec18df396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 33 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 30 ++++++++++++++++++++++
 4 files changed, 69 insertions(+)

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
index f5719500527f..cd127a271c19 100644
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

