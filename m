Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B8F9D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B55010E5E3;
	Tue, 14 Apr 2026 12:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8jCR4Oq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF9610E5E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvnMa1tE3tmmLR48g3TFpg3KqDnI0LNkJqfdQwfl31MDg2BnLWiCvBEqgKsu1UYPEuHWQnJrA1KKKOrNrS1rSIGMoJR51tZPOcgl6IHXPZTmt6EtLJ6jU2o84k/+Lnqz7q5mYc6M5qnrMSJ+ZXGANrmgR2skoN72PG1ZRNQtvZbyh2xtqOLg+2LoUq9KS/Ut9578KJtgHzcisUTkidk7Yqn0BVNswb4l5qvTggawNXozON5rurH0T00h+BoW0vDF9Xcw48HTOC/wbBbHX2APd8tbglTbMU9vqV1VEGDtVBqMfev72ImBuM20gafWW7DNLnmuBO9qYztyoNqvGMvXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scX2AE9uRklkRtOwIeeUMFNxu6MR8BXKhW62rhPpN1s=;
 b=o+RGpXRL9Y08kNitabOLLR5Cr4OayOZP26cpWba9bmgv+yFWE89kU5wbr5XznolF/nprrLTlp5e6QYznRrcG2DIDvtYlFNdOp5R0QSrgU8D6vaRoEM3Csn2XYkhoMEc2LA5wAXraAMwp7VKhLd0fUavcQhtdWMTimFyySTo/65X2V02W8+9BhECL2NRlQECqPimSqK95rrpzs+gyM2Z7+t1rRW4C9wpQ6LOff8oN5PCNZZWPG3regbnCZhsJBQ2BLfFpZ0gbDZteAY5ftDbmJ7B0tSCXFofd+FT28ZSc2VrTOM8iNx5+a2mWO2/nVp1Ps4VqAglY0j5UWHNDbjMX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scX2AE9uRklkRtOwIeeUMFNxu6MR8BXKhW62rhPpN1s=;
 b=l8jCR4Oq7ETZmWo6heqqLggrtZZBzfOaCaGsuru2UZtH0bsiyI02FX+q7MbYMsjDM44UEZtckdacPsJq90Gp3nJPuSXiLxsyi5Z117NXozo8Jx21D6is9akKhRRmDM8nLiqIDuW3dHwxP7LHSgTh4y2E7fAeEEXLn2D2+2w5zV0=
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:43:49 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::51) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 1/7] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Tue, 14 Apr 2026 18:13:16 +0530
Message-ID: <20260414124322.2335906-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8113d8-474c-4f0e-f625-08de9a2379d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6JsR/Z2iaZgRQxDtJnBJ1bT7+trDKm0wv2S96fIVk22uiSn4/6pXWpeunartbiq+ZMHROV2CmY2uq1cf+S7toIkVZysxXJzFQ37AiN9OyQ/UYkyV6JRRlyK7SAWzPUjq8YLq0Khpidx3wz5yXHmIcWln9Pv4xV9d3uIikUQ6QFwjtD5k+d0kKH8sfIxrqyaVBcgHMdD4fFo7MasBegPwIiyCjHvOS+7f5cMcSW9Z5I1WtuB810xNOyG6+VHrzG64bc8svoWpQBtIKuIyXd/iVYwjG6kBpeGM8Vf4Jo7SZvG8JULxhkoCFOXM+WZ2cUAFQPHcrW9XdmHofLcoq85MF5rcITh6SG++eLMCHCmOWprGHvhXyvznnzCU06IpDKU1JFhXrRk00KtF03gUVPqQXpG0h2wE6noixW1Z9vleHgKwuruVlYc4VzT3NMY8NgQ6fdk5xGb6ZF51jGVALRmABwZNq3N/8hCRee7RF26//1IDcX6MBWtpZC4FZNW88i966sXxgq7DMuBfxbbqB34WHA/lm/uDOVu/ghWGBUZuSpOV2QP7c6mCubix9N0ub+092q0Er2VE0ZcY29WOY+W16+CmxuWOPh4k2RktSlGIogP7W58upweEkN3lpFrckEDsYKLCd9KcHmHYs2tUnFf5B5QmklZhmDvM22VTvMhjLmzhNvMKMTvbY/q7aXnoEQSX3KQSlMcElcE7zupqygOMgGmGNqi7uxrWAJU8e3n28XG33V1F98E65O+V/IMUDackPS5HMRWcDrBeIJbKDZjeNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AL+H5AOQO4qCXcIyNwhUP9l7HQVU0bFznIhydQ9a3jnHAP/dNeFSTGjMZ2zhJ7yzfcT0XWXRsIYN8vMimiG+AFrMpCVOJs/29rXZo3wbafW3ULRaIxcIPV0vNxZM0ezzW543Qv5MiWzbt0rYKIwlfiw+r8f4COzoox/fnNFN7bA8cZzWwLZr7qCOIQX8bJVW418yzIX5pYgLFSpnhasp2MLo3WdKpX6nXaAyp052uqrGzneBV8eb906aUzU3oNOJnIP6RSBKw1BN9GrbfeaERgU5MPJJGaNfRzElw0EBJ4n1Z3ptL6V+nEyHdw8usiS4mKhP7kVZjaEEq5DdWu554bgIdl/69V0jRVUwg1Dmje8TeIafJ2/pDdqvzn6eUvyUjQ9gY0u93/ogIfE4CTqzBhcR4rFS7tk8btB0r6nLYSQRekU0OxXoj0MnSn3Xi+s8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:49.1309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8113d8-474c-4f0e-f625-08de9a2379d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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
index 2f3834d2f523..1ec371f55c39 100644
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
@@ -245,6 +248,106 @@ struct drm_amdgpu_eventfd {
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

