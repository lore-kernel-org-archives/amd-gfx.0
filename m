Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BD8F94CA5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5014510E1F0;
	Tue, 21 Apr 2026 17:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IusrneV5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98FD10E1F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivuTY6s3k0JkzoBnntCUI3gUeFbpYGfUajVSjYCJpHaJ6lVS90MbrhSgDYKrarhzkt1D4WhUeparGhC3sbyF3c9UtoMYsYM1mWXrZMqrPp214CcKCA4PPGlktuq58bVn3cYt+uO2WqlyoIOAsYxgiIgWyCiU/zxXJ2j5B3VIhOz+/T6QbAX1OB5l4EtBEG+B/eNsEBub8Na5cv6t/J7yrqwF2Z3v9oOLZWNesQcAS5LPzA/7PPdjqiiTi5p09sAhZh8iEI9G8OrTZYmqQPT3a9HaYr2zodPpz1PiT5Z3KJCbzJ4jbUQrj2ZpoW2f9I6riR5reSHOBAB0X9Y/N+6E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbZ26uj40LtQtp+IEjgNosB6antZhSTXrIXuXIO0lBE=;
 b=xTW6dmuhEspTxvt8pkxSILwoUjzP2rBIhDwWWmpzYaUxbyO0YfnZXE4WRhr6Tx2Y4QTXwuafDbQN586Uh48Lf3+6wZnF268HIDB1wAPc5vt1rKhounvFPExbxEXBhrvgN8XNSWbCQS9vLE4CAIfAbQ7dEhkw6LSXB+f7WJmBy3AOby0kXNFT2OUMB9AohjX8Oyx5DDQj4aBWc0izJgFs5OQkLpYkU4xo3xckOUOpz/OStWn6I8aGxV43hWJ6T6jcHzF+vEpZKxnPP0lb/Z4susKlxiRNJ71zdNjF8EwKj1eJdGXw2VMvP671CZGVOSDOpRE01X3KsiQ/gFXFV+dCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbZ26uj40LtQtp+IEjgNosB6antZhSTXrIXuXIO0lBE=;
 b=IusrneV5wRQH+JAlPhgrKX/ie2HBGOzV9JMH7oRMBvPpB+q0e0vu4/uPiuc63aXSPfgW2XjDdtZz+cJdoBSiTFzDsHVr5xdyuveu2CbngbeGNEE9oRXjxbcslzxFAK3bdcW39kyW+kfU6ZPs6by3N1j6ZLs1DSQoEiEcV1Woato=
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:59:35 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::ed) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 05/11] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Date: Tue, 21 Apr 2026 23:29:02 +0530
Message-ID: <20260421175908.2402019-6-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0e92ea-381f-49de-9191-08de9fcfbf39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3VA7Do7eDWiqAnfW7YAfLTlqttBvKs0GaxLMb1l72UwiZHY1RtP32WoHv71UDxc8ZW68umAGyXWZfowoP9M9zs327P/V79K9/S9Akw8A3oqACuTTM+MTreNBDS5e3AXv3uqrlTEvjltPRXjMYOPvjjlim4opSfFYnRlVthapvM+GMGib/YydZPNdWx9k6jBg+r11jVJgAHQ2s0JoSTGrUFT2ZVouFYtMugTlGufuc2Yu3FU17+aOHYdHYC8CVyYzhJggkRi9/NUwPLS0tGALbEjbT1f08mXrruKu7CKSYd1NeRuAN61raQyj1k4cWaNOtWG6DeiWYGvYc2W1voybtTWDyuG77iL4sjIsZvszV2kzZa/T0Gng/nXx4MKEkbqBd7GFDotjBfDyxGHbvR3lgZyMROnUVypnPUIvSTKjsKXV+gv9ORoFhfmxSx4JHY5cms4Zc+EtRU5d/0a6Sa0OPIT/H9EZDopB0SEo6lGzzCKIKnUHkcXyA2ZKCLabNr609Jh4aKF4WjuBdj6yWqMYjGj1lEpSM/a7dDWTdeBPIxCUudSHScvYkBIy8YBkVp+VIuCpLhireSTrK/TmrZt09F6lqgsHKCGq84KC5ewcZFdE2l2AU76GXZ1ckUHqkg+Bo5Cl60qUgFxpQb8ZwYTPrb4K7qXQlpkiCKH4x6cfbSBl02m0SZ4XCMcc3uTSf/s1FpEcCPL1RTYONK2uZwd99cd05RZUQiiZ9SpmjIsKGO6Q/BaJrTTAEc9WU3f/+EozEncJH9/UMRs2s5mrEMb15Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJeDvqKoZcwqTiwNTiVhjkv9EVjbx85T+lsFJXXePjW5EFDe0+Aa6g3Hwu8R5I8DTCsE2Hv6bJmtE4v3YWX0AEZSx1qpG8TZzQS6FF+KgpJePM+1Qp6YCNjBdNitjmX8mZEALDEGQ5IfZyFJK75I7hCk80XpZ2gMmD3f8p0r78kCxH4Cwr/dVG47gHgvNFlO7/mnD0hdb+1fiC8taqFc/pl9WnjCZxJG7o0vEpY1yRRd5ebQQGDgCjrTa6YAVpXesUi3A2zlF/8aX3riiIhd2Jl+52CLVY0TPDgPmHvh2kC4XmEdf19+6uXLYv1C+/cpKQKy7RKyB+5c1enTpLdp/9YhGjxGhrigPqMn/46lxaSCalP+s18WC9dWlCNJeME8X/D8uJUKmLfKW40IcJJMbMiYgWEO29GDtoz7/qQYQJP8I7Qm6BGxU3l9Q+IcCWom
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:34.7662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0e92ea-381f-49de-9191-08de9fcfbf39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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
index 57644deec724..bf17619a32c1 100644
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

