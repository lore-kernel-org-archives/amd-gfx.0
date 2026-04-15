Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD3F43858
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADFC10E717;
	Wed, 15 Apr 2026 16:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmB8s/Wq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DD310E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEHyPkq7vgTsFJbGmdooU/M9JgYdDkwyjzM8W30U+oOrJJWyiCRFiprKY4hyeuYSrPatZZHtRnn1K/ZaFfqwgG4Z74ymef5zYn1LU4ZxgguSuI5iXN9pFQfraPKsrvlpcvvAqOxqlKINkyAvU0kJegjVmtjDV8MKpJufhdu9Uol6MU8SY6JzxgncWf76fU4wEaow9hHMklxaoxgXf2vK2/1RWYjLzWmgOLu2f70OicVUEsw+lVs9U1P9U2c387he6/NZRggMRQXtWbT9stAPOAWJQrkE8iXngTfJ9mlU8p5yEAig52k8MPvqtXCs8/b49uLad6npFNOQUbbdNa+SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD3Avhepk0yRdI5QwssqyWFjOelrZaMZReYbrJLlCu8=;
 b=qZv2AlNRnXr/hc0F9WbZE6TWvlTYIykjdcfEStLAmPDwPqZNRg1xmakN12YImo0k9bRr7qzRbicQ+R3BzwK/5ku03z5aaCRvIx7mEoRX9+kdpiPcdGq5bZJzqRb2rYBTGxRVcSzyyKNfiQzWUYbaWqwUoBokH3eKhQFTtGsLz9+Eq3XK+mB4fgA28ysMFMmjY1BGsNzDVHmg2wO/RaZ/Lu6sjHXVexiHV+7PtyR0RJrlnNu2SBjIK8Ez2JZHEec4h7DpCL3ST73NV/wmCBnioP9FckErkwW3Y9n+ZjfqX41Y1sKfUG3RMYgBfhiyzZ3ElY1UhWcXICFuwKWjHZHfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD3Avhepk0yRdI5QwssqyWFjOelrZaMZReYbrJLlCu8=;
 b=lmB8s/WqjDXv0VPixGF77jRpeDTdVX/PHE4Y0/p+JdyBs/WksCn74+dD0rKo1Rc0FMp6kgVDen7sIDSR3JQlmgmapoVtjR3PbYpyzncGkD8tGx3hnsgJJJrKo+JeI5YHP4GVvHt+HwybQPgq6Edh5m3e1NG8Gs6j4LlGruJRUWg=
Received: from SA9PR13CA0136.namprd13.prod.outlook.com (2603:10b6:806:27::21)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:37 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::a7) by SA9PR13CA0136.outlook.office365.com
 (2603:10b6:806:27::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Wed,
 15 Apr 2026 16:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:36 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 01/10] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and
 metadata structures
Date: Wed, 15 Apr 2026 21:37:02 +0530
Message-ID: <20260415160711.261553-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: b778839e-b830-4d36-94bf-08de9b091c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lpQcc67SuxqjUVt0whQRFWJH1skhVKRDcuWdvyC0VpmPlOukWQ33PLLQMqGhRYuVXXg49mX/G8b3eJ8voGQji7/j1xN93gLQB03z+beSneMImfzd81OY4A1h9kdSD54WgmgPYBiqbncQgQ7LgHF/erXp67FTvpdAIDnAVRE7nqufZBLzFoFCB34vkSarRGnI9Y1SKsSDV2C1wWOeByv4fijFhocCuzHHS3em/GQ34IaU4rgGlbzNW2GA9/cLGh5gMjWzHqrLHSAKtt4gXEpN0J+6aMlsujOYjm8Y85LEWKAqGs/GbyAIlNi7grad34hBQfsBGkF2d90srpzJPXpRB5AOcKxdvSTx28wu+r+Xij+pec5gcaxztWvL3XGWcqFdXo1Te7/YB0nhl57tCb7vEnIrLNKxQRJyWld6KUer3nIEHbIiYH3ava2wXYi7K4KageYsPf5yoybSyZmMFth0OGGVyncBlJDcu/IhYXFSHDGjr2MsxufGadG80PqDjLBI8H531vaI10g9K0QXmT0Z4G6+O4knBOGawzvWMhBhyhm6uDNsRyg1w8BcgVGYalsYNbVJNwX6a1DhxW5wSZ+2H1zDVN2Tn1IX5+ocMzDA3zzeL2Fa6yITG6eQWErhuWsapilKdHtn/1liUhWwfJ4d2fUtoBoQL8N4roCfeMRJ7jDBBI/CoWn7H+uGz3omrx1pdcW1n00E5xx7eArrLGe7HXo5i/gY4KKAlAnxaGsN3Nfh4LYjsu0M5+EmVQLDnZfmbQyTzYnqos9VG2JR4tbLzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hgzRVf8Fcooi1DIE2rKr159JJdZDmH22awhSIc5oY2AOVdG5LyRH+nwunwKqk6IYHh2/J5wZ3giFz53Ti5GW8GHbHldhg5gT2zhOXIpqtuEoGVpYoEIhN5jrzpxEwnNYfMC2XimxMcry+JNZZhAQy2fyMkr+pQWcGDnx48jKIe6WhwnZAI81DO14qSTcWkWIGeyfQLCRgWCPFtTTwDsVwNVZtmcnX1vnfmlWfQwPinsRLuntxgMDY14h8A2qA7ePDG5UihkSREumQSLNOGB7JslWzeed7/rgAEfB40+RErzTTs9vuWSr4Ukk2vqXL38p2Gb3NvrKPbUJcfkfBfMkdjYbggPoczhJw1g9VgyHRzbEBkLeHSiwdD4WXl0A01M3+5wWpiio6/7/rd+LBZU8AIDtIRKrRFn9gV9KpLm3m6EdgorLYjd2m0oJHLFsJAT5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:36.5752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b778839e-b830-4d36-94bf-08de9b091c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
index 19a84a9a1cc7..f8982d75b1b9 100644
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
@@ -246,6 +249,106 @@ struct drm_amdgpu_eventfd {
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

