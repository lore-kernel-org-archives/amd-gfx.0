Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825D5EFCE43
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 03:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA01C10EAE9;
	Thu,  5 Mar 2026 03:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/KOd5QS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9498F10EAE9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 03:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn+OkasIjIVqtCVrlJ3TFQn3VsgGGi68FjOPdRhylkQyqgNFPxWLd0CPJQ4JtdoIfkVJoVGQvQfBBSNmTWPfJbGKnG2mTCFOtlj/KOklV9LXeShE+V7NrhqY4xWs43AO77CZDsB3D8/u2PPWwDlJR0AQVb7X7BLp+pojWf9sjBbygV8tdJIQNfC1j4woHOY7/uuY8o5Tnk9VYWagC0+VihOhMg9bjteWK6Zsx2siI0dS2iTWIBC/KUdC6WuTVc1gHxXdadS9zh/cPwzTgL2oxlgvhopwzTOLbzB1I07Tqy2gA749ueg8MAPdV8Ft1mxFeENlXxd9r1aNC/S80yoD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNdp4/R1C5lNBFUcjwFv9wGUA3hbfrJlfKUSPEi3crc=;
 b=JpxSdJva2JQRU8JXhnDAJoCwpfds2J3KielIP2ZzjPgI4VWdjAMsnibYs8xkm1t3gXeAP5dxs7T0Jp+fpRHmfrtgG4z8D++7SESrA38l3xIk5ZiUato8QG+7L6G9WerpZmJF0ek+ItO07zPdlhr7zmcQtyAMmlgKWdhvfKfKJnRCDcnVJdqRElja2qsO0TypsdD1NzIumarq7pbHuLTAz/svaq2jEylnuLyF/tRA14fIf/8ARMLtv3QQasixTUVs293L0xrkccPf05uTcPUbMFOrSEAT+qCfHBf+vT99IkLpHUm7GvyVbLtnNPLSuzLtUUSwmdsIN8Rmol7o0YSZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNdp4/R1C5lNBFUcjwFv9wGUA3hbfrJlfKUSPEi3crc=;
 b=i/KOd5QShF2H7GLjkye/vWw4eB8VLx3iSrpXjc7jZzZtkKyjxVtMRoDpCTcJYHy/y/1/M6Bfm7Sy6tv7JcTBIO9nYBJEIhygfIK26t4ANM/T9hKK0NUpBHXDXsS8PCObdAOdDWHaiB12m2MudcalnpYQuJVkcfX+SsHtSokEkng=
Received: from SA0PR11CA0200.namprd11.prod.outlook.com (2603:10b6:806:1bc::25)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 03:08:29 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::7c) by SA0PR11CA0200.outlook.office365.com
 (2603:10b6:806:1bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 03:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 03:08:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 4 Mar 2026 21:08:22 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 4/4] drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for
 render node
Date: Thu, 5 Mar 2026 08:37:26 +0530
Message-ID: <20260305030726.1779794-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
References: <20260305030726.1779794-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 838c5ec0-ba3b-44de-6aad-08de7a6479a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: 3Lo/Y8Lx1GvLIEPxff7703Sscf9ysg9HUhZoBQPraGmz/yYkJVBVBbi01/GZJ8uS34azMHCf6/FfQYjKooK310l+PaASf1+MNquJ4sk9mhhkIPp6t3BS6jhMuW9+eQCg3Lt8MZdE8TvxVeOeBD9TeMNlDVHYsVZ+k6q+5YIhAbodC3mzDZ4Aw/2fgUlVVgL7BiAuFRaReuvDNN+7h1hG2JdTbM9YZrByIhHC3/hTBLgny/C94ixHwUkMA0xwoLkNbMoXgtvHfJOIrKJsAuATQHpArBQgPT6Rr+IekzSDY6o8WMFc1mP5oJUDyyJQzXQ08J79Xp053ahhY0NQTMsfyOI88ZUcL/dMaSsWjPYGLiRj7pyAoHFM0UVZHFSgO3crNTB1NWW1r4a/N/jE6aVS4TfIhshDc8DPOC3BNPbZPf+faQt21hcf/R0sBFe9M9QTnMvmVT/sj5c+xChykF3VrMTi3X1F67KpkxLp+/NaT6N/RwEBBftWauQEs4DbDXmsEPWZfqMcy+FWcC2Y9w7fIrfn/mh2aYlRRMhEa2+DtK5r/7RTcXPHMI/rXqpGXPOslJXsOuEE9v45S22XVMuHe7jGMIrMP7Le48Ojpc24pql2npCwCFKaOYBxdehV8GwROpngAOokcn6jYHKx6uFhRmcDfujrES+OdgKwPMG+FtB6GMvKPYRLdpN1rnW3qs0hKXSKQL0vpzhwnTemY4RwcLcXOscG3JFDeb3oQ+Bf2w7GQkJx/wLALPdAiOreeBlQsKZz8jwOrHvh/vQnIryWuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a3VaD8rGhV+DdDkxye57JrjXMp1gCOC9qA1lOo5jBLzhLNdz9qn1MkLFrLsvhGZ5JCtTPnw1LZ6sMk35SLtOTlz/YzW7wB1eP2dONMvyRwMPnc/Vz/l4HlE8/AqUc9HbW9A/rz9molFnR+vHZOWmGf89sZ8Klcod7os8JN2Iv+zEyMLDWvsLSWPylYJuqNTffn/cEOZ30OCFzQWZBy/AGhifKbXyzmb+5iFLrBuOSDYdqgmHn0LFq39dTmU4KmmQaGQZ5hNl0kuyNTUu5lhTMwxIZ+Bjyhvmi2+EHDKAeziWV4UoA9hm3j7M7Y4TzIg69FjpEV03LYGrG7TJNB6HHJKPkOA1IXVsKXj3Bc88qOYL2a1I20Ju6SWxID3EHtm4B/QGd71tJq8twD4ponp+mZd6A8M8cpt1cTAJm5ou3iUmZJBRD50VvRCKeHDXcsd6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:08:28.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838c5ec0-ba3b-44de-6aad-08de7a6479a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

UAPI is placed last in the series since it enables the userspace-facing
feature.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: Ibe6a3be80f6435c1fe2a3243b63e6ed2fc6391ee
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 28 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 33 +++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6d652e8ac978..0955290f180b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -458,6 +458,12 @@ struct amdgpu_fpriv {
 	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
+struct drm_device;
+struct drm_file;
+
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03814a23eb54..0393026534f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3062,6 +3062,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_BIND, amdgpu_eventfd_bind_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD_UNBIND, amdgpu_eventfd_unbind_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ad27274a9e92..e06bb19bcb12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -634,6 +634,34 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_bind *args = data;
+
+	if (!fpriv)
+		return -EINVAL;
+	if (args->flags || !args->event_id || args->eventfd < 0)
+		return -EINVAL;
+
+	return amdgpu_eventfd_bind(&fpriv->eventfd_mgr, args->event_id, args->eventfd);
+}
+
+int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file_priv)
+{
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_amdgpu_eventfd_unbind *args = data;
+
+	if (!fpriv)
+		return -ENODEV;
+	if (args->flags || !args->event_id || args->eventfd < 0)
+		return -EINVAL;
+
+	return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr, args->event_id, args->eventfd);
+}
+
 /*
  * Userspace get information ioctl
  */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 22fcf2a69134..5fdaa141cf82 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -39,6 +39,8 @@ extern "C" {
 #endif
 
 #define DRM_AMDGPU_GEM_CREATE		0x00
+#define DRM_AMDGPU_EVENTFD_BIND		0x1A
+#define DRM_AMDGPU_EVENTFD_UNBIND	0x1B
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -79,6 +81,10 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_EVENTFD_BIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_BIND, struct drm_amdgpu_eventfd_bind)
+#define DRM_IOCTL_AMDGPU_EVENTFD_UNBIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_UNBIND, struct drm_amdgpu_eventfd_unbind)
 
 /**
  * DOC: memory domains
@@ -204,6 +210,33 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+/**
+ * struct drm_amdgpu_eventfd_bind - Bind an eventfd to an event_id.
+ * @event_id: Userspace-defined event identifier.
+ * @eventfd:  eventfd file descriptor.
+ * @flags:    Must be 0.
+ *
+ * Duplicate binds of the same eventfd to the same event_id are idempotent
+ * and return success without creating an additional binding.
+ */
+struct drm_amdgpu_eventfd_bind {
+	__u32 event_id;
+	__s32 eventfd;
+	__u32 flags;
+};
+
+/**
+ * struct drm_amdgpu_eventfd_unbind - Unbind an eventfd from an event_id.
+ * @event_id: Userspace-defined event identifier.
+ * @eventfd:  eventfd file descriptor.
+ * @flags:    Must be 0.
+ */
+struct drm_amdgpu_eventfd_unbind {
+	__u32 event_id;
+	__s32 eventfd;
+	__u32 flags;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.34.1

