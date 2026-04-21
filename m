Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE86F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927E610E91F;
	Tue, 21 Apr 2026 18:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHerz4hQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DD210E925
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mka0xm8O5NhyipGULVGLVRs9HL3A8Obxm0arFsUaFQsGmmqdmMNoulMoPD067PRMHx3HBIxmo4cF+xzhsMe/h9YRFjUUYVINDN/zHAOTZXQgrKRhblhDW01hFnR7v9rcPTTpqzLtvIOpbo/K0fwgDtVXLBIjDd0eEWNI36jNosKH+CqnvFfYtVxHTKryGjbuiuWCCRZoquyC5X6b/isCc2AriLjM2ZALATl1KYvFlg8tLhQu7QEcY4mBAI2s4Is3Ts5vd4Rq4Nxb9HC+byeaQWFHp3mKUWmkrw5K9s6HApkv7wiz5gKNbP6f+rbhWF671fE+71HyaxeCs8TudbRG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=ECQqBp4/hxlCm+XL6WUfhwnKzmIa5KhI9USs9rsJPCXBcLtNpg1rOvFa5QPXhgVc4EwnD54JTEeGt6kFwgQWM3qUuZODgS4Pel6dJe4U0Ojno7+8oYRBok4YzqFz6vJ1Iu5zOwV71G5yGk6xQVBBRrYMnlqOaCFfagTuAl0hm2VjFzGI9P84YK84onhkKDfitCpVQvgYOjkvY+F+Pv7rORdJTgIZHpHegzeIJELHGyEMNqfq3avLlKHapxkiGLY/UvUL3uCyFoxwHewB7SxITci2YrN66WmMHd1eKyiBA6QYr+7GuYyYRsYy1ObEY5JS38Hq81R6/0yoAeNMAVitVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=ZHerz4hQAvW3FUEy1SGcZXh/lMUXeIRn4xsl/Gz2M2pr1nmr8e6OrY/d3qDpKa6M6qYMOk9pswxnlfbam6VetUq5yZtvaWp77xWYyTWCSzdcAdO9Mx/yaerBXMpA0k/RyACpV/YA3q7YxCf5yp1mQggwzhSYipvey7/uClKh3Rc=
Received: from MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 18:06:39 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::ff) by MN2PR15CA0046.outlook.office365.com
 (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:06:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:06:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 01/11] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Tue, 21 Apr 2026 23:36:17 +0530
Message-ID: <20260421180627.2402093-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: dba31aee-0d43-4420-ae10-08de9fd0bc4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m0TPClXuLx5YpBYbaF+eCVD3hGkqE6rtgYwbf1cM/bsOXHS9l2tPaJ9smLlsB8DgaGak7EYK1pA1hS5DRfMBroZeNXu2krQlnVklaZlqHNGvutlNmfLpiZhpUO8xmw8OiNh1q8fafENMjgi66GyickER+zKYQZfdLj6Tx4w7VvQ386f2CcP5i4TxQrW8zuXOQye9qcsNAqJFRfJYb3rg8wsopMFbn4lP31fahTAGxElsN64YgVBHXWXLD877xlr7jEcijyCiCbDddFcJM0/mxmYVdSyo6aPkTN8IC2ujScgGeXyjBB22nz5A3I2t+mRL98yHMhJfWGiipNy1Z3Kyz4ekTmd59sVeppPE8NiKhBH89jADIhxuAQG/6HLBN0ih/oOW15t1bIDsfK4iSIMOBjbvH/tXJ0L2Loe1cH0ekBH8/06rx1OACT9QcR+ynDPhQSFRh/PKBf3627Nyl+mKwW5LpFHodSrkkOe3o++4rCilIx565vmKVj43V/H7c+ANj7q/yqIa3bQstQrFeSAlHKw/BrbUuJmACzttQoX1m0jG4Fp85E6QHf2pSZR6TpVB60Ze9fInPkPIXcELAuAJvX1v71l8gTRvMEN3o4hi6DG8RUB08+KQtDJ1RzTOx6Ag8s2x9C6WlrgYHOFyE5EBWbemNeHj6MxGCltWkiZWYIMGjMPYvmZ1/H1yTbM6xHBFTu/J0GuhxdbePDQ4PSrtRFwA3O/c//wEb6ihTutOdin9YV4+dRm9owUB6tNB8h9cjBmZWwwfZDsS2rUfCADNNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Xl1uatZMS5RPl7ApdtR3ABetcD8NZLLLQjye2BmK/vZZB1cxptjc4080fNK+t2FakbGhCNzkdfaWwAAp/gq6rjzzdvY/y6OGjBSpvXQWhiVsyQH86uz8jAqfG89MDh6O6If5v+1adh6GSIg+uos4I3TufVaTrlJOFstQM58KLX/elHD++gSuNI06xaSJfguz1pz3pCAabq9oVFr3lKoPhrleI3A+IdXxiglXMbQhMxoBQccONWN89Y1jVwEhIxDqWJPHJak1qhu+j5svOTp19Sl0v3R8OfV2TWow45hzfywmYqkU+VaqPzpSPjQqumqHTbp7oEudlr+EyDigRzjwRlgG+AQ/gCGwVcbwWuCIHW5SUtuQo5lg7Irq06qk8532FZrNuIyFoOAWEtvuNOOqRhzvswEysRB3LRlF82IhJqX+9VWfIgCKFex5A9Ro5DK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:06:39.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba31aee-0d43-4420-ae10-08de9fd0bc4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

Add a render-node WAIT_EVENT ioctl for waiting on a specific kernel-defined
event type and copying event metadata to userspace.

This ioctl is the metadata-carrying half of the event interface. It is
separate from the EVENTFD notification path.

The UAPI supports:
- event-type selection
- optional queue/source selection
- timeout
- metadata copy to userspace
- single-consumer delivery of the first matching event

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3dffd9e581a1..d2038d38645a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -40,6 +40,7 @@ extern "C" {
 
 #define DRM_AMDGPU_GEM_CREATE		0x00
 #define DRM_AMDGPU_EVENTFD		0x1A
+#define DRM_AMDGPU_WAIT_EVENT		0x1B
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -82,6 +83,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_EVENTFD \
 	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
+#define DRM_IOCTL_AMDGPU_WAIT_EVENT \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_EVENT, struct drm_amdgpu_wait_event)
 
 /**
  * DOC: memory domains
@@ -247,6 +250,106 @@ struct drm_amdgpu_eventfd {
 	__u32 flags;
 };
 
+/**
+ * struct drm_amdgpu_wait_event_queue - queue-scoped event metadata
+ * @queue_id: queue selector
+ * @status: event-specific status or error code
+ * @data0: event-specific payload
+ * @data1: event-specific payload
+ */
+struct drm_amdgpu_wait_event_queue {
+	__u32 queue_id;
+	__u32 status;
+	__u64 data0;
+	__u64 data1;
+};
+
+/**
+ * struct drm_amdgpu_wait_event_memory - memory exception metadata
+ * @queue_id: queue selector if applicable, else 0
+ * @fault_status: device-specific fault or exception status
+ * @va: faulting virtual address if applicable
+ * @data0: event-specific payload
+ */
+struct drm_amdgpu_wait_event_memory {
+	__u32 queue_id;
+	__u32 fault_status;
+	__u64 va;
+	__u64 data0;
+};
+
+/**
+ * struct drm_amdgpu_wait_event_reset - reset metadata
+ * @queue_id: queue selector if queue-scoped, else 0
+ * @reset_cause: reset cause or reason code
+ * @data0: event-specific payload
+ * @data1: event-specific payload
+ */
+struct drm_amdgpu_wait_event_reset {
+	__u32 queue_id;
+	__u32 reset_cause;
+	__u64 data0;
+	__u64 data1;
+};
+
+/**
+ * struct drm_amdgpu_wait_event_scratch - scratch event metadata
+ * @queue_id: queue selector
+ * @error_code: scratch-related error code
+ * @requested_bytes: requested scratch size
+ * @available_bytes: available scratch size if known
+ */
+struct drm_amdgpu_wait_event_scratch {
+	__u32 queue_id;
+	__u32 error_code;
+	__u64 requested_bytes;
+	__u64 available_bytes;
+};
+
+/**
+ * struct drm_amdgpu_wait_event_data - returned event record
+ * @event_type: kernel-defined event type
+ * @queue_id: queue selector, or 0 for GPU-scoped events
+ * @flags: reserved, must be 0
+ * @reserved: reserved, must be 0
+ * @seqno: per-file event sequence number
+ * @u: event-specific metadata
+ */
+struct drm_amdgpu_wait_event_data {
+	__u32 event_type;
+	__u32 queue_id;
+	__u32 flags;
+	__u32 reserved;
+	__u64 seqno;
+	union {
+		struct drm_amdgpu_wait_event_queue queue;
+		struct drm_amdgpu_wait_event_memory memory;
+		struct drm_amdgpu_wait_event_reset reset;
+		struct drm_amdgpu_wait_event_scratch scratch;
+	} u;
+};
+
+/**
+ * struct drm_amdgpu_wait_event - wait for a render-node event
+ * @event_type: kernel-defined event type
+ * @queue_id: queue selector for queue-scoped events, 0 for GPU-scoped events
+ * @timeout_ns: relative timeout in nanoseconds; negative means wait forever
+ * @out_ptr: userspace pointer to struct drm_amdgpu_wait_event_data
+ * @out_size: size of userspace output buffer
+ * @flags: must be 0
+ *
+ * Wait for the selected event and copy the first matching event record to
+ * userspace. Matching records are consumed by a single waiter.
+ */
+struct drm_amdgpu_wait_event {
+	__u32 event_type;
+	__u32 queue_id;
+	__s64 timeout_ns;
+	__u64 out_ptr;
+	__u32 out_size;
+	__u32 flags;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.34.1

