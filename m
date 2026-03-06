Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09BEF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9285B10E316;
	Fri,  6 Mar 2026 03:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brSBt8jN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65B510E319
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX4sody+xsoKG2qxSrYrX5MGTkE2szKSXWS81cmYcgU6xfARJW5TKinWkMT7/ajw14jBDyqSdeFAGHeHwysE49+yDFBmHDU0bOQhiTervwkgv+txY9yeS8TuJYcxGcnDrne+Z2Nnr41O4CAUbU8674Z7LQFosqddaUfrD/+lA5QnUV4KnzErY5mq+gQhb5X+24679/wUSDnb+AZoVMa5gspkRH2sFh0Rw47d+qbgyP0WBioTgGs4AQRNmGqGh+V+kNn090CFXxtfKp+4ZLksSaD+011rhM2LJmJzhkug//ew2OU+kTShUir7nUDN2TqbAn1vwXaCyFrnDXzSb2hhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3Kw95i70m5jSi/S0KqKdNlXx0h1RHHA81PGxOgtKOg=;
 b=kWPo9KO/KqsON/5xF76x5syyZzEzEeTdK5Z0icklYhLAE9UZDkvTuuaDRZCqn8gT01xbpX86u2D4bTLXfo/bN6iqpnSmB5yJz1oSznln3NF4qBODGQPbWeiwKHkb2zoS46XkpLwpoi/GejCmc/jqQOyZfxMO+KfRFjpdC3Ro6SiRIlC3X/C+/BIgwjNgTt/CDfHFGt0D0bnH4yi1yImDGDaj3wz1nhR/NONCZyxL+tc4nlGhwT1fNCCqffuSRaQI/N1gWJ/zJ0CxVIsLrwog65ZGBUOxDzy54VFM+gVWpTkAcr4q2u8u/M3umu1Tyld+KvVOAI5Gr/uZfDeYbRjIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3Kw95i70m5jSi/S0KqKdNlXx0h1RHHA81PGxOgtKOg=;
 b=brSBt8jNPAqnyIjAH52DDH+Y+LNXTuvIuRR+CICbL27dSe5vEVprs79jwwQwMzSPoUchzPSZ1jux7dSpwFqUcZpjYih2qDbdNUIZ0WqZJbdtehnRAKqqeUDhfzXHVDjHXQSLUyhC6BUzUMwXgl1DTKlLqtoyslIbDe5PeyNrV/Y=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:43:12 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::36) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Fri,
 6 Mar 2026 03:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:43:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Mar 2026 21:43:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 5/5] drm/amdgpu/uapi: Add unified EVENTFD ioctl for render
 node
Date: Fri, 6 Mar 2026 09:12:47 +0530
Message-ID: <20260306034247.1783347-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
References: <20260306034247.1783347-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d53839d-bd64-4548-31d2-08de7b327e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: HDWacU+mVDexMfSJ7zPuYWbIhs5sIu25neVqyFnPYD/KUTUSfeylGHSFTnbjtqsxmFzKM91AL8P5eb6ZQMvCg9yfJ1WmJNL8ENeODUK+PPrhNKhvgy/3+otYYlu8sjxlw8hgVdDVd1ctVz6VbNwr8cNcCoY5xeSFaMn7rKosLgPIUzNnGKJkkOhN3zrVGTJdrbgctZlfA7nPyNW6sW51iC2is2PompcmzF8MJP2+TJA4Vp5yDFJuG9EhlNxEJuwjRErm2fRvrUeZuCymzcYVwDbtEVIB0o7y0yolpIM4WG1LsOQvMckKlgdWfshciZzaVyC3dJYd8hHRJLyXly+8LAGD1bJ9gx8gjV6ofCQyve4MD/xwS7YuofQ55lfHYolqMGGF//RlyJvP7pmgOsuD/8y4GrzEcNThVDjh47Bf0Q7udJ/9MCKhGMQCe9lxRYr5CgtKg7NPlMXmPKqrc9JQJHIrvk6mfNN16X42SVUqZ5gaRZcTEjcxJB5FoeHVO4vSuzOlSl2pDswgAZGMAoz2VKN8ZMsuaDezYXPzixoDHG53KILPAk3ckSSf33Ci/YQ2pucjErrHXIoE78GN32mn0NSkI71rCsK6z+HS63Gh+joCGQKKA8EIQKFCUioZW516ajxuzb8wfNlquVhks0sW1gxHo3oJsqqCc1yP2EO70yzjzAvsM5cfLMzREfVM+7CrRxpn4zv4Dhk8oGrMVzIWL6gI8W+ZTUMid/r3ndVsLBJ58pgPzDpB1twtHJ7h4Pxsk/pdro2b6UxPICrr9nmXeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KYvH4/L4BdkkjZHvP97xMDx9LjSQF4WnEBettbJga3dahVQBQ0XUVKB1rqObpxPzB2LgW1u8VnvADNdL4PsjgVxeCslapCAwU9P6Qgr3a6GIp68OnYaP60lHD1FtGD/pxQkWR5zAAxQoyGN9/1RY+3lkNnlZM5k/gJak5SX2LCng7xukVA6Kmbf9A1/7VV2Z4LVP5F8dsmrJ9HhqnnyJqrjuZGuuy9TMzv+rPLQU8S34zBnHkEZbyYfS9kCjOHpeY3Uv3npXKnI7om7pY7GNIq2XbM2Sk3ifvKNNBmkU8jJKVxF750CzrXRB7ST9/sypBOfei6StcPXfr5XftzB1S6xt21cv1A0J9PS1djvb39rw9KSIsqyyBb+RwjogCbDkUcgOTD+WYI5NqcsMp2piBlPAgEELt659lx8GpyEYyoXGB2QC73XxR3eHY/HAqsCW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:43:12.6430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53839d-bd64-4548-31d2-08de7b327e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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
index 6d652e8ac978..1b7c0b0d05b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -458,6 +458,11 @@ struct amdgpu_fpriv {
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
index 03814a23eb54..c73147e71566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3062,6 +3062,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ad27274a9e92..12f00620cac7 100644
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
index 22fcf2a69134..d37854d37916 100644
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

