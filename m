Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7C6C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD4C10F0D5;
	Wed, 15 Jul 2026 14:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhkRCce7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8FB10F0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNkQgQWX2sAY+SDInc+ivgqIHajzjQJR3RLAmtMXG7B2mLN7HofxpmxAC/03lAHCGN8WoCmeucAAN2aaJewlqql0lFyY5bapDWt4ohcOu1IaB/I8axANVYMsa+HSaNCJnFCVdd9cXFzwbgdxS/aqYKFn77gPcQxKgjUnYMiAArpTDJQOGQSMKOVsSwKRkvFoP31WRHAQJwviUGeAR2rPZNBiW/lgcl1f0ol/NjTenogWeho5S/7MGAnFeE1QWwEubUbNUl9FE6l++03BnV30C+ekZPQIXIllaZVSUyET3zUopYBm+aKLAByZbrpUCjF+pRZREo6NvpYGAKVErDHaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy/TmENczJNjdBaC66W1Bd2CZRBtPVoxNg/GR3ixUUs=;
 b=WLaVbPddVWzQeh82XJkdwDCqj4Rbqlu8yAJSrE6+OyUAwP3mA+hud89NnvsB8UIpz06kDlAIPz/h6+NG9LHt41ZojXOdHl8Y6X3TAFOwGcOhxGXqxX72P7brXdjW5g4H9by5nISr+Lmh3DOD+30O1AfYIekCxopJ8e8ewylA9+DXT5FTURLvfAJdfWVW3eKPMrdoDKUpkGQUNiJ1j2FHVyihdkFPlrbyojwwcYl1JySgzrEigndYX1JViuMEZBFmkFEUoVhEDLHA25eyy4BP8AA2mIOZ4R9W9LF6n++ZwaHr6KNz7dCXy2lmdbcqEqn9uXKif86Dwky8JM65QWDerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy/TmENczJNjdBaC66W1Bd2CZRBtPVoxNg/GR3ixUUs=;
 b=bhkRCce7RVO2YWBnCEVNcNOkYMyrzmWicqg1yVkt0k6Y6/IBne1DX5/Bge1YqHNHGxAelI8O4BE1gxzo5FbG9qKBwvvd5Xs/AxSGUwB4BI07vjX8PrvPCwdEBRv+ZarUoymaobrryJHm/Loh9q3SGLaWTtqeh8+1UPY5e5tnHRY=
Received: from SJ0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:a03:331::15)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 14:25:59 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::55) by SJ0PR03CA0070.outlook.office365.com
 (2603:10b6:a03:331::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:25:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:25:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v11 1/5] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Wed, 15 Jul 2026 19:55:38 +0530
Message-ID: <20260715142542.3475265-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
References: <20260715142542.3475265-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b929c4-a4e2-46e4-c642-08dee27cfdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jHnqylzoVz95wS59qeE+SuRCPLCDsDj85+BtmpaMeOF2tmSeSHuBNZDG4JVSMKydqGFEexcGgiykStnp/Y5yYuYZO5JeKUNVWCTGgCa7mw8JgGqC28iV/p9JhxsuAm3n+KYt4t3EvNp6hx8/9aBfggZQCNdgJUJ24qrtfpmFxWMzG5kZ9qplq1ywCqd7jItnSXsgC1nle5lSYu1jNgXKr6RJD5SqfdDGX/K0jwjX+5tU4YoSgzFh1ImWTtnd0nmr8SOrf60HKtCCu67rID38GAkqDMMRCb9z/5fT9yAoQAc02H2mMfhsqX1ONuGowlTzovbWWrtVDbkDQ9wWB9X9fDf+LlnrrC0IevnaIdip+jG8IgDNb4AZURUhp+fIkkF/6zOVJFymCGoqN9w5gO5dRkyTos0o9qYhdr6FY9nwx1K6U1SxVO0uydmxRbMI5/JCr9CT2nvHCRPebfIEs6epVUlGR9QzQlqukqEvUdHr0SmSbHnCVZOuA6ZGZAe6HbaM8F3R4vFjWZaWwNDgzd5orG/LuFNPLjiWNvT5xspclg6pukz4YTrufWw6TFILh8gQFR/3fBAVpaGCcA38Y7Bl42UK82NHXXPqOOa/WPz+1vURycociMvSPHY69lg97llt8KTkvSBwsYATihEBDVV79FPtlwBJ5a5m7HxJayAk8OPM8uyJuEh256QpV6NcCHe5AirWHocKEhdu8dYWfrwBmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: csRriKnfnwYpB6OHgrGqUB0kpPp4zTWFyh/wYcOGAepGBScQwQo80u9qpsLSckrtLEk2Y/kts0i/SPvIMyXsFPVDADuK2h3KW3tO+V7yYjKVh1TgUd3EAEFucEY8nIcFlDZerTf32+l0IYzB7nezqzb8CwbaGAdDtHHUNJ0sMs7YeRcNqW+sKkWiWfR9HjUHhnq2sFldH0K34EgWqd8fESzWbnUcWz8/zDNy9hzL7mK5zGuonx/+7soDL1oUUxdbcDk9x7ijkFTit627D6BDaTaojxZr5xsGb27foyH9alnBvlNTgh9/YBZYeJiwThlm/4jsZcqNGZNBagTNHsdk5kE+56H6xzjtwCtQEhIn8AJvbvSNIeL2lt/wNQCDVUCEz9O6E80xIhXM148xXcBpepy1FNvRvAwTanrPRSVpgkY2ceDDaQroZqZaDYZQcM+A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:25:59.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b929c4-a4e2-46e4-c642-08dee27cfdc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

Add the UAPI definitions for a render-node WAIT_EVENT ioctl.

WAIT_EVENT lets userspace wait for a kernel-defined event type and
receive metadata describing the event. This provides the
metadata-carrying half of the event interface and is kept separate from
EVENTFD, which is used only for lightweight readiness notification.

The new UAPI supports:

 - event type selection
 - queue-scoped or GPU-scoped event selection
 - timeout-based waiting
 - metadata copy to userspace
 - single-consumer delivery of the first matching event

queue_id is the userspace USERQ queue handle identifying a queue created
through DRM_IOCTL_AMDGPU_USERQ. It is used at the WAIT_EVENT ioctl
boundary and returned in metadata for queue-scoped events.

Changes since v10:
- Replace the relative timeout with an absolute CLOCK_MONOTONIC
  deadline, as suggested by Christian.
- Rename timeout_ns to deadline_ns to reflect the new semantics.

Changes since v8:
- Clarified that queue_id identifies a USERQ created through
  DRM_IOCTL_AMDGPU_USERQ, as suggested by Alex.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 115 ++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index a086ff45b5c0..81ea32418596 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -61,6 +61,7 @@ extern "C" {
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_CWSR			0x1B
 #define DRM_AMDGPU_EVENTFD		0x1C
+#define DRM_AMDGPU_WAIT_EVENT	0x1D
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -86,6 +87,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
 #define DRM_IOCTL_AMDGPU_EVENTFD \
 	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
+#define DRM_IOCTL_AMDGPU_WAIT_EVENT \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_EVENT, struct drm_amdgpu_wait_event)
 
 /**
  * DOC: memory domains
@@ -279,6 +282,118 @@ struct drm_amdgpu_eventfd {
 	__u32 flags;
 };
 
+/**
+ * struct drm_amdgpu_wait_event_queue - queue-scoped event metadata
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ
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
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ, if applicable; otherwise 0
+ * @fault_status: device-specific fault or exception status
+ * @va: faulting virtual address, if applicable
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
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ, if queue-scoped; otherwise 0
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
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ
+ * @error_code: scratch-related error code
+ * @requested_bytes: requested scratch size
+ * @available_bytes: available scratch size, if known
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
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ, or 0 for GPU-scoped events
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
+ * @queue_id: userspace USERQ queue handle identifying a queue created
+ *	       through DRM_IOCTL_AMDGPU_USERQ, or 0 for GPU-scoped events
+ * @deadline_ns: absolute CLOCK_MONOTONIC deadline in nanoseconds; a negative
+ *		 value means wait indefinitely
+ * @out_ptr: userspace pointer to struct drm_amdgpu_wait_event_data
+ * @out_size: size of userspace output buffer
+ * @flags: must be 0
+ *
+ * Wait for the selected event until @deadline_ns and copy the first matching
+ * event record to userspace. Matching records are consumed by a single
+ * waiter.
+ *
+ * @deadline_ns uses the same time base as CLOCK_MONOTONIC and ktime_get().
+ * If the deadline has already passed, the ioctl returns immediately when no
+ * matching record is pending.
+ */
+struct drm_amdgpu_wait_event {
+	__u32 event_type;
+	__u32 queue_id;
+	__s64 deadline_ns;
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

