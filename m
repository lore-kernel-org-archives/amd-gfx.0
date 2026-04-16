Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C7F433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7251C10E7EA;
	Thu, 16 Apr 2026 03:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzAnRbsc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30AA10E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh/Xilqlg5BxBiVQnuh/zhdmgzgoXU0HibIB4q08/Ni0yamHT+vjedo8zFQdBha2/NvGH8Qr8tmFvKrTW1zEV6FQe+yWSthLe8pYyoWA+4v9Utei6keFbBB9dFHTDmarcGje9INkbda4JT/cfmpvJ/YrIAKz/V7Z+esC4MotwntYuJxWsl8pqez/YOM4ZpysM2o76HoiK8KX5UcrlM13UYpyoZXV2QKsvoxDURgtmtyPF19wmPV2u34MisE3c2dtZ6Iw/dkBT62PN3orQji/erK9hx18hVXBibgXXkjzxskJUwyUVpvulbU7uM1t8msbE+c2WaKCpQp7qV8BNkShVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbZ26uj40LtQtp+IEjgNosB6antZhSTXrIXuXIO0lBE=;
 b=KZD5YjrEqC6ScXzJMmRjef6Nho0UnQt1H2LbdGUP4k84VCJ092o74wawHEJ9CwD1ACiDbfzsAo3zmd1Qb7lZ/SEM5F7NTM4Rs0CE/cOmM7VA+e9zSi0hWglVkRgL1a4mNkz/UfxfZz7b590hv8Nc0v+vrli47aZy1gM9jnXK+2KoE30PiPwxHQ/pSnYgY5d+xIess5k8AOAFf+ln91vZwRbg8Ivoqd4vUtDek/hkzAcxNNmX8zZk0fdIqHC9MffJOnjHKzPxY2EmfCYQNk1vyHZJc8B8HNE2TfKpzLyi72XmqqVvm6Y0Om2YqZgcABCDMYsJamkuIJS3f7/lSeEMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbZ26uj40LtQtp+IEjgNosB6antZhSTXrIXuXIO0lBE=;
 b=mzAnRbscQZtID0acL431E+XobSb0SQ/xI1q/0EOF8ZQK6SKQlNjbe3YP3x4Ku8NOQt30AmkcmbCnqZx4NIN3I5cpUcQ8K5b4ilM66N3S+5HdnXLMXSRIZocxH8hSZzLW4vxmJoCqxGPGE3SoVxifPlBEWPOmlSOpP+ZCPrcKzCs=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:29 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::bf) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 03:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 05/10] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
Date: Thu, 16 Apr 2026 08:56:54 +0530
Message-ID: <20260416032659.2368054-6-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 964d1ffd-484a-4960-d4ce-08de9b681657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: FfvN2obohlxlqJZvsJCK3mdzY1vTxDEGgMc5SIfZhsWUp5L6cU9b5J+MRG806K1xH60oDZWiKbVcXxEbly4peVNIHDT1EkNGAn1m4nXbUOHCh/4xDTx3uwZOY040ROo7wJ618/grrXi6/sV/HHv3HkqoQhB/+HG8qiwj2PNBwhGYOkdlGbZrksZOwDg7j4A4N/cXyge2Gojdj1G7bSzMV8OlpVobKCngzkXMI4zYtWI1laRIqP5dCILhAye+bFU4y7Z1QurAV4c16I3ck9wdVT8E48+DHHRUZjU6vK/hDkxYI56AM++yfTxaT/s/AJip9cVrjau/ua8MSDTdrCx91JP4t7dBYVW/1EZGj6avlduKEyVvGyPL2lRw89JNZVJFgSe20TkgZUzKMAgSB6AeMNEA0nBS4UxAaqRC75S10BK33Md5AU+I1mD0O9QYS9jUEgrKyVs9mP4gpJCduvV/KeNJ+WjIjiE8zv0eoaSoCQnqltrMameGdSmB4x6qvv+A5OL/f/6hNuBAS8AZYfduYxsrE1yg7U0wQZHLODEgxVF6gBXPExHqUZipgD9gxvof6lRl4J8dLmkf4RtF+zpq//jC1ah0vhDU+xCF7djzUis27pojDbDXejOi/CbzAl7dUhzviMmdpPOm5pboUvEqGfNTfYqstcDeFHTinsehFbo41Pzd3H+2LCEoHQYNT+7d06NONNi2jdF4n/KhxcRwbMjTPBd9scl+AXyijRNMuG+ZiXzm+KwZjiV1UtffcHC7dKj+b8ToxKodHw+IbNU4KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MxjnEh9UN6Zyp1DmFeOhJ2XO7FImglnv01c4lkwuQaRR33/54Oa8Zc2Usvv5RbgcSHEu/wbzqntn7J/pr3LWYRYStzPqZ2FziF5sAvj+Yo35DPrmJi3YLRlySzch7lWT73JjOr7p4jhDGvcoPkGQG/zVH1VX49hdigUjUDgmZWNfnhonN7phEU4Vh2wvxWHP9SBqGfUXDb5lg/9OCu4+iJEZKkGlDclOdDrenI8h5MeBGiH1qh0sEJga6whMuwNvds7wv0hnjqPOep3SAYvCJeHts+WJTCULotvVQRPTKHN0AHaqh8+ClqqsN9O06NuVVgV4agPJsFqVDa8JtvJnH85IHQCi4RQIgtghxVJJFLNfigWydVh0+CrKwJmzYvsTC9p4BE3G+vLglRHLgWZsA4EVVOTVYsP4Byp42TjNammLvH9QWad+U7xjgbgnpOXK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:28.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964d1ffd-484a-4960-d4ce-08de9b681657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

