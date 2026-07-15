Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE10FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF4510F057;
	Wed, 15 Jul 2026 13:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnJPWc90";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAA310F057
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQrGvKEXtFGNJtNpQA0ei8z7+H2f+lssRhS9E6EnIbLHUChBY3x2g/dvyKrl7hHmJ7k9wldOO2J0yfk6sg3j8PN+UQKQmQEGYCfNKvtlq60sPBqgYQrExjekPM8/8ReQxXYuSAVImBDAU07uhOl375BcwzB8ZDApP9oswsL2HDOmTF/D7sQc0yGMUJ2u6egx9AXjFzddyK94awUTfPfDDqUueZXTH9LD5pSSlRi27VyNkrPQByA8n9GwQvI2g3jIwsndLDwG1maPFazkd/gm/DDxKtrku6cWhWpTL12WDQHbF6HavWvmN5EglOZySxPZRSQt9+zXy7uQvCvKrbvukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy/TmENczJNjdBaC66W1Bd2CZRBtPVoxNg/GR3ixUUs=;
 b=CzYi+s7MyUtM3FtxVocZ6bHxBM9+eJiM2tXv8qwpoArV+f5Gk/Y3yvk3qxyiB05/t+oAN3bnokyUMt0gKiOfksHcJ/MxiSEE2kLjmIO30NtaPNN37Mbc4T8RnY59GXc/uemWsqbcHwD3W+yXoYStvWGuC7N4Xnr+lETwEB9mPC1lcdnfdg3DOh+44gheTZ4mHU1ARf+PttDCNCElLe5CzQyj1NI7td9ft9aDG1hEKL4YEqdGdpmSR+kw3u7jqTHAU/99OV3fWMIprYEVo1jtXbk18GSHYbxQhuUqkkR7y0Sr/Gi7YegHgjauHifkc03UAEDxJWIsxZ7bPxoEeambIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy/TmENczJNjdBaC66W1Bd2CZRBtPVoxNg/GR3ixUUs=;
 b=YnJPWc90aZV5/ixwmNjRvMwBctILhcIGYcCV0BRuddMvX9UUs8A5RPknje+t0UivJiEnHbYDuo9uh20YUcW99oKjIFJHM85pmuD2Ql6En+NlfdWfIED+pHymyOeSqqvUGDRZy0SBfPTQACmYMagT+h9wTpJnjI/11KvQ3OL2Vdg=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:17:22 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::1d) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 13:17:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 08:17:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 1/5] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Wed, 15 Jul 2026 18:47:00 +0530
Message-ID: <20260715131704.3452312-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
References: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: fab89cd5-3157-4cf8-bc1c-08dee27367ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|3023799007|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eqXF31UcSXQY/tgLD6wC/pMua1PAsUyto+ha86O4Vl+mV+OCzUML1hpDSOf+wa4KeOqhml4mbPKhpDYqDY+DoO3Tsur3d7/0964f128yCoPdVO7XN7EYVbjh/NoTi6gfc4m9qC3OAVdCdzFt4HbT1xDorZvhLUTxoEejwVSsL06m1Ao6P32gQPJfleIXbcuqgl+joJCGg5CYGDVV6k0PF75KMLn8xUVM4J/3Vqqba1gqSrURv1afktlDpcy/VR4+Z7BF14wKL4e+x8ej5BxA0oQbTQxKtOvnRjyeVjAR7lyWJtJ9hyeSZ2nNNZmO61O5RVyMEyw0OYwdX8ADlzs6ZK+ZY780odjr5RHzEiWmSrSSNHSYRWRvF1u5gJ0qSwnb05e6t4jLkzylYKloqeWWXQYcGVHRcexyltbLTY9dHd09lxV/9XfzL19kg5NbG2UB9crRwhxBUyN2lFiQeXu3CIYjE64Kry9kfOpRYZw2u19yIb9hGG9m8LoD5Zn0I9PV+KR7G6YnvlbaV/jqmWBD5Tho2n3poKcPPHi9BDLEUgO8NnIiyJz4tv9hJulkD6BJ37XSLkyn+GL7S0Wmxy+RJ50poSb6UeZqu/ZoIelMoIZ2/lGdall2sd9s0SFERUx8oV35Gku8n5orMgWbfJCd1yX5e+fBACFQ7RpTN+RwV/oDSJ/TBN+CAqBK8ddYJFFjk5qUYRzw35Ur0shPIInVKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(3023799007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4nhfwjab/fR82I0JLMFBFl2/gjPLIyvU3FEQFlQxAbTj50Z5fTIvhLbvkAmXw2u6x3TrxTHvK4iAiWqViwlCEYZByIsK89gW3eXkjCLbgZM9/GdPiGgB+refGzv9btfo9wsSTwoYuDQ1OOnxVA1xKZDPG5KG7yJtWUTxaNGmI6H5wH8v0NilqBgCG5IBje8tPw63+qoStqBhhEl8NtxEO8bGuy/YzYPevSz8x0e0SI8p7nQyGwqTo7cGph4RrHRl5gqFMw7cByuHQ5VNTK74FGVdSGXVh7To0/Bbr5pPZ0xMpNm0zAC3qBZU8Ro5FXtEgE12offPgTRutTZsxh460JbSu8Oi/U5g9jsnKG6hb18vUJT66fj4wjdow/yf2xc7dbD0WyFIlraS7M1zFBzx4ZfzQTIKRhgyB0YPJktgUXiwBCUdVp03IdG3Zby5onQo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:17:22.1253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab89cd5-3157-4cf8-bc1c-08dee27367ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
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

