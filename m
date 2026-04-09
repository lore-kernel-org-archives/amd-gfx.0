Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C2AEA3C48
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2522110E78E;
	Thu,  9 Apr 2026 10:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JfF232w+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD3610E78E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTEQ+Mm6g6NKR83TJ8gB9tq1TkMDBP+ZjK81KNCaQTzm/na++oNjR7Pz5ABZ7SO5iFql5vfEIv+RNftUZ0y5xqCVvV1b22Gr/HNAPTJeLP+Z+qstiBMluwgVIQrB6F7B6rSxQ6j7cPrsul5k0RvIHjGGg5CBjSF55d9nzGAswY9ahjqtVmWWZAZsPlGr/oJ6inY75VWRkdDZLS64yO69AEtaUsCoQKQH7hT0xAhqu1o5DxPH4+PRse5M/v/+v1qHT3IgrgEPijxWmlTiri+PAEmeqCsWD7B+uO60Vjc4qhSkEr4OJXQZXunws9wKwkWW6BBTsYyO/R302vOVse/8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LZOTubhLaKpS6vg10PJJi6fpqyQQ3nBU/vk4wo92P0=;
 b=Cx12ukKa4t4j5u6EeyQUDHR//IhJeU4w0zlhotw2B2IBI2EK9rMWV8xDHclLiegVMQHGmeXIRvtJvrY5IIAM43dKlGCa10jgsBDXVsERcA3Ph0EwMmq466V677ssi0BCSGaifpItE97KCu3psMzUhn6YQRgLm4SHJ5+CebvBSVumiYTUlZeJ3Cp0ReSnDInM10L1U5TcBSYpNW4G6kBDVyW2nqyVcKpBHE/B6MH42RK3bepfqaWhNrqNPw3t+9kZdhVU4A398qs+vTXGAFM1Zz3qns3R1zmaBcv0DilDvd3py1EDS2KgkgkMBUeNRdmH/2ZwUC8RS2jqr0VLAggafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LZOTubhLaKpS6vg10PJJi6fpqyQQ3nBU/vk4wo92P0=;
 b=JfF232w+v+briQdtwbwf2dTCrKX6ZzkZoBy4OmroPSIZwOGlexdaHf5IuDS1BH4K4Ai/Q9R/oIPs2DPU4vwY51rDLeI8YkfJf1qR0CyIEP69BJKOTZXW3i0rRYUyTKjsnshsEAwQCELT0YpbkyO17pyj8jJYsxekP8gQLCqgdJ4=
Received: from BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19)
 by CH8PR12MB999204.namprd12.prod.outlook.com (2603:10b6:610:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 10:41:28 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::d2) by BYAPR02CA0042.outlook.office365.com
 (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 10:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 5/7] drm/amdgpu/uapi: Define kernel event types for EVENTFD
 subscriptions
Date: Thu, 9 Apr 2026 16:10:55 +0530
Message-ID: <20260409104057.2284155-6-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH8PR12MB999204:EE_
X-MS-Office365-Filtering-Correlation-Id: 6733cbcc-65d9-4cbd-5b1d-08de96248e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +ZY/131t4Qb8R+qrwlYiDNPkSSPPiBTuyw+32X+Yy5LXxl6hepNcyXGV0Q93R2uWho9ub0bNo4yo8ZMhy4U0+Tv0B1XS/QlYcbLMw4uHq8jS1/mswMn1cjz5Te8zNF2f4WamOUYs4OPLOoBAyUvfFtvf4fe05/W39QuCiNsDVr64cToFewvv2GndCdRuU85TgmrHi+kq8JkgOtoV4BqA76vSH8BHMIMFhuOr6dyGGX2BgbEvUejcN/sM47okejhk+ysNkRwbUYHKUbvbb2t6sxiwKB9/CTc+WEGt5m7ePHRwzyuu4N5bc3BSwZwcGt4cksmsccaDMEGtniKLsLXYvLhHvzKY6LJxpFl1m0mAYIhC8YOTbZZUGVjH+MexOTwmwQc93+MSeDTmvHT2vfmOlpVuMj/sNr/+viAw4dE6BWT9aAVKoTVZUP+nlbWzxDmEhsKnk5lOakbekikuwRj/X0f+3hW2HX6AeOAgAkjx0Yo9L0Kzb4KIztXIVhyJEDMlUBHJAAtt1ZRonB5ZPZCk/BSt8eLpi/+oeCLq06zEv5r9ISJVZhwynek65/v4UJtyeEDAcJ4GZX0YaI1YUVSZEpqKMG5AY8zzlZndCnL1q2aNKb6G+MEXAGYZYP4qa761zoLaGqCkel+GMHnpSyAIvJv3PPPamHMHzXqMlqx2hLhOIHsW/8RCg3Ilf0tXGS60o2K4ns/385hpmVROAbHENyletplYZT7WSAbcbeV4+aed40OUBMJxFl6xJpBlgkoDOyekrhaAnNBrlgY0ueVkAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wh76DqAL6zTxp9XI8Ge++4P/XSoRnuwHuRETzDzGZ0LctiNGToNQSyFyaHo/jzS0YgkwYa4VCQOxX7llPU+mWm5afTKHVEkz163110rCQGGjonsdnCRRDVswJ4o02OT54zfLoC3rtXWYama4cKPoqOiL5YP74JZKdwoZUDWd7CD+j8SXN8Ea/j73+RxwS1E1UbnfdNMmIiYZCq4mhLqYmftGdfaYrJkZLT6tSWRcChDlmMYRawQ3BQ3rczTLR+BVXE2z/WFrYKje2Da+IEbvsztXIBUKSczsay5Np2YbbGx1PtSOu6AA1jWh4wo9UKOD3ka58L+9C079Pb9S5Pp1EjZNc5josmj+bRy/ajoO6To6qWBAr3uTMsV0D3tR8vrvL9gZkaxeJAY5PQvLyElcFVPNQSHepl+X49tO96VmrXCOw9jenPv0H2NfW5AFj2WC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:28.0234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6733cbcc-65d9-4cbd-5b1d-08de96248e2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999204
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

queue_id remains part of the UAPI and will be used by follow-up patches
for queue-scoped event routing.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 include/uapi/drm/amdgpu_drm.h           | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

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
index 63cde4487c47..2f3834d2f523 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -207,28 +207,39 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+enum drm_amdgpu_event_type {
+	DRM_AMDGPU_EVENT_TYPE_INVALID = 0,
+	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
+	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
+	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
+	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
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
+ * Eventfd signaling is notification-only.
+ *
  * For now, @queue_id is reserved for future queue-specific subscriptions
  * and must be 0.
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

