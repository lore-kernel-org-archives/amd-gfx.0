Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B674C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5E310F2FF;
	Thu, 16 Jul 2026 13:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lG8iwdjV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5B510F2FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms+9/khNDrdF/grb/cWgm3RnPIlNq1vKhOjgU89jeQjTyaQlSmc0ZBD1M9aNq6+HejWZeFif1GC/4F03oNHqzZdCUDIXTilLcD7UG8pzIVS1t3dIJUYYemqgUpII0n1KfgI20zdvC4Ir5cdQq2Kon3diCJw8xn1AXF17sChDw+JBo++mDMrUniBHVUuszHyq5efhW49quG8jOsC8QDFw9LFO4Yl9ydL842Fl46SifOSCKUeVGSIxYPL6b1CCbmj54Moy5x+K8tUHSRH2OqcIiWYw9a2WcsMm2/+3ovq+hdJHQV5iKMPU8N9nix6VJ7/CJg4pWt84EQavXcF7NNTMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3trsAhmxvTN2BHjg8Rn33SEc7KxKimcFhVyn5MIFBQ=;
 b=h6CLYHozebC+glbYZ7jw0dN4VKxnvgJ1jn7xMC7PRUcd0Suljeh2fn3bHVW3vJYjPjItKeCkuiYRtfR8EwOBPO+H2he/dVEJorU8OKNSjMBOmTtdEmTWtSz4bT4uo9l9ra+Bo9WA7IWGYHXfUBAPPVOABJ3wo8xcwZteBL3HO4eoAPROdzPjQYfzwhyi+QjgxcOtN7m48bl1DpWgHPocgC9V5tF9wOrqCVkvULH4xchpalsLI1qB618NNUrtu1xYF6JIdtpntUlgGEAoqHmtuN4eLvEn5epP39Dq1SS9ueVqloIaRX6s7SDuX/07mjVMlpXHOm9XtOIdD0NvH6vsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3trsAhmxvTN2BHjg8Rn33SEc7KxKimcFhVyn5MIFBQ=;
 b=lG8iwdjV7N0N8qJ1YCIqW6lHVYKGeu/0oRH0tC5+LihCUUAEy+8Xg+7WswfKq7R3pdYZn6mj/iSPmEYe3KQg6E5CezHaMUaQADAgUt/sGl5yE0m7duEVIKC1aj/e8vYYGyC8PI3fRIiQcfHYA5a8hjeYJ/s+MNaRiyhnY+mhdlc=
Received: from DS7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::10) by
 SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 13:21:30 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::18) by DS7P221CA0029.outlook.office365.com
 (2603:10b6:8:25e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 13:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 13:21:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 16 Jul 2026 08:21:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 1/5] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Thu, 16 Jul 2026 18:50:56 +0530
Message-ID: <20260716132100.3496327-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
References: <20260716132100.3496327-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef48e4d-6a34-4c36-5841-08dee33d25b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: YKzgC7bPJpKmBVCF1yYjhNEIE9zlCaqx+hNW8lhkuGG4fqoXQQ0T8SevkkNQxRcP6HPYwPbv1eJ6AWIOb7j5rfCqV7fNAjmdexwGSszzdiIhDPzp2XkQvdRHNhTZOxiTi+9lJSfYfKpDvwB0ypaDqGZ7hL64acnrzQ9OJdew+CF/SFZkVKJ0sFwiGRDJAT2YXVe7Ag32/wmSuwkny1cCelvv9SZDELcbsFx0mskeAUpH+rVvh/T9lUX7TLmx/ETVKole5eDKsLJuXy8KElXF57RfzNDD1NUfki5WSzMC2N2SwEfkAdx6ftyB0oNIZxuZp4tCG/7Dm0j6jq86jY0G5DSnpFpNH1/8KucLAGyf2MMlTdGTDJ85I++E/GFXgVPok6Mk0OW0rGZNtXT2tnMqgl+/0sOHgXsJR3wi/iMhWRGplCKLn5XVE8reNDTmaz2mAWNXJpG/2Jh/UrrmYXxOwBdPRhmMg4oFoOVQ34wkdHgyZobjcjq4b5i4MPd6TpwUsh2KIagY5JY2H58JFXxt/1v5yZTMK1yTKc+m9SxW6LaEOFib9P2d/hpTB6VP305VvriARaoaqxK4JbnLa5A+R0g5tls4qAFSwFp5pRyW/jzwpHhf8reLxidap2fWAw2LzrFu2Xq+ol8Z3gZC3YHdHMs6Q7FMRvPJU2Kb5XoonMzTS3JebmqOnwBthJoMU7cSrt4b02ez9a5ThZ/2W8k0JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EVT4fmh5Og2+Oh6D8FAn1ZE5JlHxY34t7t80A4pj1bLW/Zq3cB2/VG4GT/uH2xyvqtEFOLK3nnSR9e6IHaPPQUu2Nn1QXYM4fi+GBU4F3YM3L/PTPBYqS+qhUz+GXDadajELALmm9jvC2q2V4wa+ApoYshGcqKur/jdqV+TXovHrrj47JB+KX1qNAoEIUVcPhJ6oTqg1n1XO5AIXC7F6KcYWejBengU0fmhbZmLNGGRCRnm+AypOUmwdDC2UvlP5xKIqvNyfCuzK2mZt6r0gFT64zhO2N5qUi3Mn1k6eQNMUJXnumh1A2IM42P8f04RoM/pZEsClH9OyEpjNy/Nic52XO0aqTtzugGdkc6XJUa9vKYr1bDN95KhWb6Uoxg5gytucieFLta7wBzDSsNShfKNqqBmDX8etMedyxwKIROD3EBqw7cqe9zVGvKUykVSB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:29.7473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef48e4d-6a34-4c36-5841-08dee33d25b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119
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

Changes since v11:
- Make deadline_ns an unsigned absolute CLOCK_MONOTONIC timestamp.
- Remove the negative indefinite-wait sentinel.
- Document that a zero or expired deadline performs an immediate check.

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
 include/uapi/drm/amdgpu_drm.h | 114 ++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index a086ff45b5c0..cd876c22b300 100644
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
@@ -279,6 +282,117 @@ struct drm_amdgpu_eventfd {
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
+ * @deadline_ns: absolute CLOCK_MONOTONIC deadline in nanoseconds
+ * @out_ptr: userspace pointer to struct drm_amdgpu_wait_event_data
+ * @out_size: size of userspace output buffer
+ * @flags: must be 0
+ *
+ * Wait for the selected event until @deadline_ns and copy the first matching
+ * event record to userspace. Matching records are consumed by a single
+ * waiter.
+ *
+ * @deadline_ns uses the same time base as CLOCK_MONOTONIC and ktime_get().
+ * If the deadline has already passed, or if it is 0, the ioctl returns
+ * immediately when no matching record is pending.
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

