Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4013CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6346B1120CF;
	Wed,  3 Jun 2026 16:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DF45bLck";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3A91120CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy9o6aI7eX8gxANFe4ZZbEQzB4HrXZ9d5aaCU2pbOkMWjxajyGn7yzcfrsZq8bW9ALncM1GfWVdKoZHIsHay/6wXIwhogWTN3qHVwcdLQNgm8BKRd0bWJ5LIEm4uaZOHuE2iGknP9oV7SZiGJ+qgEfdeg+umjQAjFa9gaAMZbkUpAUoXatIWF2NGSRXDqkjcb4laMHWv3MAdstb3JWty53VWUT1RuBSu9j1xTgJ5nREK9e7XJdb2mPFKg3ydET+JEMVxp1HC7y02o0eB71/uPU4P4zhZxrfCHO0fygQcqJeyzzGCPwGHa/xpE6L2QAM1x8g3pYPHWOlihTDNjWcoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=J3P2LelE3fR9DGsmLO8c26n2UYK3bYCWh7LA2sHabt7jp8xoi5J0u35Olipol3pmcFDovU9TfFCkfITdLIas1U4aPmRAYMZlOveRF/QpCxNFYjpTGpmDv544m97uFwIPZaY4WuU02asixiNPGZEGx/zT/7khh/zuKsg5I7Q4mYtJ9eGjVLRsCZZixdJc8wyMwvdsAMgiV4fxy+KE6nPhVEnj4YIBuGItzayMWvu9wIhSu+xFeTaGijb7WwfsvvPDzNZW3dfcTLWglMBlpP9Dav9QK7F/lmGqoyXjuUXGNrBOoZQpjNDhjvZF4XAtxbqo7EK2KqUIp1Mv66syC9C9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=DF45bLckKENNaCGMb7OkFpBSr4nCzwvoQ0IQo1HbFhL7JjMSn8xqK7hZVjAzyWk98HM+eE/n8aCL7yoOkT6xDbSAr5+WmSG3Hcf7auq2z8/nv+wVrks0F57eEZOW2S+O8VWiPgftXtIAd32RVrbkNlWhUlRJtqYwTF+ATeAfJas=
Received: from MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:13 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::26) by MN2PR03CA0029.outlook.office365.com
 (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 01/11] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Wed, 3 Jun 2026 22:04:40 +0530
Message-ID: <20260603163450.2678374-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de3e979-62de-42e3-6e37-08dec18e150a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2KkQwEY0cvmjkQknv5HDYSmZOUb+MhjuBAO8lKG2MceDvlNqrNDe3lQM8g7PfdKC71YI9OfPGqH6nbH/LttZdmNZxhRprDjz09c928uKraQ2t6sFEW0bTQoPjPxt4Q4wW8vtyW9cKPNvbua/KpY7scfChNPVl17dOhKPw7KJR9zm/TdtkX52OOIIwGYwa/4MWdwyFv6+45ZlNfjH3p5zbctm1679P/OHIJk+GVjvwsazB07Kth00XSluEwu+M7/ZrPfUssma3Whg4GC9EY5rpR5B5rdaoW5E/P0mt1f/9bV5raNHyfK/ooWJvKMJmlm8R58/n5vUM0/u95XBV8esslZywGrGhZ9RF48yPmNRhfpqAZ2QKCoX8MaXM2MHHUnmkrp5IYx4JzhNDrAOEqxEbtfv8x8tSuFh/PX6VGE3sxSgkci/Lit8LBNnIZWmt2Hkba7/HYH+d0jL30IvxRmPBEAWsGn12nHX2GAL/AAyAAgd0cx+XWMWCBUHC4BB3jbRPMEg+YGm3zc55VVOrk9JGISiafVvuzkuRV+o2T6DXWF2Ju6VO5Px+n1ql39DCi0znVy/MXJ7nQoxC0rtBe3m8wSrnT4KGhGPVhMlKHF7TDcAUWujfbF8OWcnV1hX1qu95RbUHp8b+d/3fUEhrKLh269MxarX9kIhcDF/rscNGuECq8kUNDQfu0htCR6LE7891gKY0ShcdSzf0KbuW1Btuyvz7GXMZGFK4YG6im1s0ds=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +t3LfRqMwYXi1KXTiKO3zmlTsy2AKKoIjooQDVn5KOibKu2/mSpuJbuf29Nw3Kc44v3OUSTQ0Wto23RRPCrAcZhzyrLpxVSVWcFZb2DOlOcT4dKULoT2kmts5hHE/vBQDokEbE7FjRr7+fmgeeJ+oZ3chK8vliEZM1dIxggC2VXmGvsr1chFmcFQdtt6AstpQ/yey26Lnqr7NoaYU9AqNV1OfC+NFf/JPm5gzvr+jolqtaI+Jm8yG2VvTLj8GkeM3KOKK0WctTImvW7Gk03dIoOQuJL4EvqYtL9/Vy+qZTjnnFwEUcOJPKB8tpUL1h2xMsJr36uTXb7jzKWEoRiJIoInenkGlA/PlC2D4oux8FowN9NVdEv7j1VAsmIVl0qksTVDX63f/g9vgGMLznFDWoGx3dObdNGymv8hVswMii8+x0tlSXFtQpw7HqRju3yB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:11.5283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de3e979-62de-42e3-6e37-08dec18e150a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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

