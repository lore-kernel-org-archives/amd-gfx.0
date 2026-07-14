Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243FEC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98BA10EC4A;
	Tue, 14 Jul 2026 08:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fv1cx74w";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3840910EC4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCZAqBHmlFa+D02lY9zh3b87ZrVnUQeLw8a6IYccKUF5HNkf7DIKSlfa/GW93DPSHP5PYo4cBuHS0Wdf/aRaHBqNocEOj4dPdP0UdhRPCG52MEspsfYI2OxzbIxwBYYypNy2OCyxgOIpk3dzWIkkipXQIssaugn3+Ve68TLYYRvv0uVqmS9C4aQ5TJLTlDo59CX/MRDvQjJK/yBTCzfq7xoi7S+YqJIdNa1fm1vM61rntKZwdx17OymBSmFEkWKIrO6bVMqx9I11bsW3an9ct/10YAY8l7MF9BCYiya/kx4LtfaPvlFYuqm8P6guWbYdTBgyQ2dytnso72pHiw7txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBphtBLMNLLLtbOMnEeRd5U11Gc1n+hqLfZhQcHFyb8=;
 b=nrqotVnuoiENxcGeaxqkaq5mzN0HOD+WQrr3rNVZezYoRutqMnzhXJzLXdSlo+ooBzvCByhKGQWFaJ7psmOmNj+AUw4itB0IhsPVASQG00uzNlQt1tVeiB9/oQPSU0s0IqKudnr1MsNVvKMOhTu7/63nfd4J94A/ctJdUvuIj1K3tG3p1nQ7/aljFo/1ULBZIT6doF1vuuA/fzIG16RHCOTy3fGdrcfbQiKgDQvlE6qjbU33z4GIz0t2FdiO/fv/BmrhVeewp1IerCGG3Mh4JoE/pAiCkXthQa+mu6P/OuGKXTBT6Os/BcoBQEvw2wjjSZCaFvPgVQJHHYlGGJu6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBphtBLMNLLLtbOMnEeRd5U11Gc1n+hqLfZhQcHFyb8=;
 b=fv1cx74wM4g89dUT9h3Jtkd4Zq02Fz599VxHCcp6Ul7UmK0cUWVJNr9bFOoJIP3eRzH9rR/pQI1e5dKLv7DH7zuDQoUNTUMuV6yCMNirkv5LoZoOXdFyIv5rtvuAMzZPgXgcugv6uvpKdDWOldtT9DnhhiK7SYE+P64Ni2HZ49A=
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by LV1PR12MB999282.namprd12.prod.outlook.com (2603:10b6:408:2cf::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:10:37 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::74) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 08:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 1/5] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Tue, 14 Jul 2026 13:40:19 +0530
Message-ID: <20260714081023.3395485-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|LV1PR12MB999282:EE_
X-MS-Office365-Filtering-Correlation-Id: 1600625c-1053-4f67-4975-08dee17f627c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: lVGB9QRma7OrNwkpkm327Ke/s2qySxz5nUkjWxAFuUJrq550VCcjCFSOy2DgOjAOGZE6jschODifU2R8krFuTOICXm57nl4omd7L4v256DW83BL4MEtdUYG/dRvxxZeiNlMsMnr7Tt1f5JdSYe56G0pHa2BqAhLjcT9q5gFlW34sKngKyiWiO+ppLgNsxT4q+EEfRIXo7QII8TNkCL0TJxlhiwBkKLdrEhiQgJ/V8jxk/q3QZOb09yyyxRPIVctqffwUIDlcs96tECEwT4ubt5VbyeSISKc5DJ89KmWlWSL/eeUkfRXCPlk0xRNjMN3U5375URnSasAFsNIpherEldfQkGl54wxqixyfz4ov075+2gc5q3Y/3ivZsdxnQg2n6eio1u4krtmtaJqK58/v+2SrIEG45wkJmFGuACxfakb4TUvKAhQATijbDdz2e4HiMWfalNxHIKJSCnPAR8Sb7batDOOYUhQYUGx+cT+wbzSd9LvdLBD4hR2hdMisKXC9Z3/nh0OgAJ7IHPUAFUVfCcvuiiE91fSd5es+dh82Igx6MciqLdLU5JQAvVTqgcahsU7+R1xIFYn3aRwXEynnPk9LrBSavhBUISyjCH+Vfw4Q2ri+zZRjGViC0S7e3Gvt0g2LAfAJKgjHpYbuXE4DLuhiqyj/6Qbo5lFiXPZ5Ra/zNd3oEKPTZC1G3DJOnO01DcfbutMAeZ70nCbAPVDN3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RLQzGk5RQdSvhcBQHvlE3sTGoU0bSKCrEgTLnybkY/Djqhw7nAZRrq5Hk7ezya3oo/rL+zkE02bMRbFEfQ+YwMJxpvYMez/pQvgo/EimpPRKy0NHQ7+rmMxEHKM0+1aZOlEQrjkuwIZTS6edp6Usj/OBSk9DgB53i0lSDLZWKUVw+Ic0icc2GfxJ+rjs0RAvEwU1RNUpXrEt9G7bhxFdHp35cQpGcBqwIWF2GOM58eyXwwq6PhPKUB+zypuodDVPIvIT+k0pzXrFo3xFXtBDlSEWQoen16xf7n8tKPJ8L5KbvWasJ+oe2Y4ZfLvPmvFtZtr8gg6hvc4H5GpAFB9bZFr8x3Eo89H4NZ7BinzC/sUW/S17bzDktApPUz3HpldEuiaZ2kQrasv5BoNNXTWlvKrL/6pITDSWEWQNW3rwiLJaYo1CSbRz9Sx8H94mgNnL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:36.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1600625c-1053-4f67-4975-08dee17f627c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999282
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

Changes since v8:
- Clarified that queue_id identifies a USERQ created through
  DRM_IOCTL_AMDGPU_USERQ, as suggested by Alex.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bbda6ffc498b..2ec57f4975cb 100644
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
@@ -251,6 +254,112 @@ struct drm_amdgpu_eventfd {
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

