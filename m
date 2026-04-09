Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E9EA3C4A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C140710E795;
	Thu,  9 Apr 2026 10:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tpvt72ff";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2962310E78E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onX4EV3bxgas+Tih9DIRlf6Pb4FesMiU1Nq3qN8F9MlqqKNjI0Wi0VQ1F3qzJ5LoJXwMzM9+2ZyPBkT/TVm86W90IwbdBuyev6z1VyQ+uELiAtB0mvIOjTzfqudohaGW8rD+nR6Mvk3rxsSSd6Q4C2TkqUrsw61GrrIiCeB5um/69CEnFlqXRbXSzkaODu46ULIGskxXyAY5/AoIaa6z/+DhWlmmIvJLP6r6etm0RKILSKLSGwIAtcl6ajOAayZd/AQVVuRGuOUXjDhpUvkuwRq/P1Uhm9pukJXQ4hBU6mjfgdC8cJe03eU29MCw1zp/99O1gURjCHcGBEqr1G4Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epokh0TYahMpw8l5nZNtYdcXPu1FNPDbGleqe44pz7k=;
 b=xa6HVQX5tZP9MgGQx+Ibc0NygfehTtd2JwXdAzt8ZcYyW0CQIw8xLcqbmbiSdiluczssO7bHx6oIfArzZianpAvm/QVSKFtY8kOTPaPt8JCrk2s6qYGRgIbRozcTCFu712SQYdp4mSlquwfrzI75njtUq7s8WOGKe8JtG+i20mwCD0oC8k0JS60SgZ7Y6QVVoOaVaKXp3KEdkFbXahT3uirtSZNSCwdoYUOM46zN5vlSx+hI2vxZGsSDjsLiuqIza1DOnH6dD9VRnYa4u3OgjxE3k2ntA6stc4BUyCJvL76gJ2fh2j5R9gj/QUIxgov8F7mP9356o0T3rx5bCW9rXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epokh0TYahMpw8l5nZNtYdcXPu1FNPDbGleqe44pz7k=;
 b=tpvt72ff62Dg/WATiAvJUkgmEylykPVJs3RrsvhqimMRhWlOgeiI6ZEgD0qGscTvoCII80KdYt3idfbsgTcLA5dp+sv3InQ+9Z3sIwNPiw4KJiiBfS+48izMG97ztJfWPWPhre2pJoLWYoNwTXhz6qGadFv6+aX2lu58mUK9lvQ=
Received: from BY3PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:39a::31)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 10:41:26 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a2) by BY3PR03CA0026.outlook.office365.com
 (2603:10b6:a03:39a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 10:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 4/7] drm/amdgpu/uapi: Add unified EVENTFD ioctl for render
 node
Date: Thu, 9 Apr 2026 16:10:54 +0530
Message-ID: <20260409104057.2284155-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
References: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3f8366-c848-45d9-97ef-08de96248cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EzJWcknj1/CKfytwwSqXMr+jvp2e0OKzWv4V+yXP0S9djwFq0Qn89vBpHx+pGjaThTIdPaRc0r4zES+iWGDkUDV64HsJX5xLx41CgEz842QlXVBxgLtPEpQVu75DWDAQho2sSy2jYfe++quSUPajFFTe3ZMjK4hWRVOTdeQG95Da7a2ExJ7bijrOSwnaKgn9yDPjKzH0hV6jMXurhidPWu0Zm+bHgfqnRlzPfm47NbbAc7QrjLZVD+uAUu0vIRoE1H5wnqAsDBSgTqta8yUEOvaxBR1cG0ZLAwRn1/MsCw0yWRqFFjMndyFM5HjS8UTQchXt47G4cRyIVo/cNWCq5fX7PykT6/RieMAjHMdxMN7uSRKE4DQts+nJPuVhGBhSouIJtj9Qudv/z/Rw3TX0LqOogT7JmMi/2ocvvJ/6jPUERALb5sWE7ds/UhjGHWYPRdmDWyHEhnF2JIjYcgeT3PcOrqykv+O2pI0ZDixxbPyiRWxbX0XxHwxmFMHNB8mTXebj6q12X2z9oSOKTTSNvHzm4Hn3/+UlhNfjyY5jpV8AfM5YB/3BB5NdtM4+BFj8Ky+BQpPTG5oTmnSVWOt3ErTHMKt0iTo0ltKRh7+RozKvr3JM/0xvASGTSFAHBTOq7JySc5w6xj41995qXwlcsWzwHTIlFcGOOXabEIAyclCwPbLT9ZzM4L9sIc50P/HrZDIXm2/ZBy0E8ryIHem+Y3RaY5y78SuNcCWCVItlAkS8jagSs23EDwoUG68eSCxJKq0NGDOyiUTpVip55n3E3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hVKOw7+tkLJ4NlFvcLqgwMNGC/fyJ47XxHD290AtnpgM487bRDycOxVW3uCauQ5htev/CqoxcP+JweToXp3AdRl6HUAes2JNoarW1KDYZcEq20WCKQs1U2lwZvGmbsWWDh/iJiPySk0+JZsZ+FO7qtyw1UB+Yx3uOV1igCroihS2TvPGJ8zVp18+7mNKXSNLkscp3Jz3WYnEPs7MOyvE5/Jbq7wzKB1n6RlILgMrPuOJiZU2Na4wGQXhNWOKqU9vT7T6y+fjqoCwehpTxGy/Y8TQzMclkd4JISGveIC+dZzPtZDtZKuc2aLiUSGiSaKmtv18WG8x/vA2J+OxmKyWqHgbB+k/XAeQK809ASHi4PHXV/Ix4RZxF88fxtr9qZVNmqx+nN0F50EUpLPBNEvXP1DoHbtCdAAbCmtBPCo1cyU9mVz23Sf7aKOtJGPgpmqs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:25.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3f8366-c848-45d9-97ef-08de96248cc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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
index 9001ac4eeeb4..d985720e296c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -459,6 +459,11 @@ struct amdgpu_fpriv {
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
index e47921e2a9af..7e5cf9ada14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3065,6 +3065,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
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

