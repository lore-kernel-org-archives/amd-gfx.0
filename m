Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72651CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C44110EA2C;
	Tue, 16 Jun 2026 11:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Ht0pgzf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACBF10EA2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toBuDc8BitQMdLN/LJnonQI8oMrYNxDCZElhvq0mDYTSNFgH8+XpNL1vYqZ1E8nalk/ZAFP0ippRxAmhDLcDZlO3+uqeq8HfYh+xn9Xm/WtbGAfVEtoACtjVZ5y2w5ZQntyFlz0HqXuCfz6WEXehB6Ik0SkyKcY9Q4efZ2C4vTK+AYftubgXcVUiu+6SPBUp1gMFicMqkbXhRqOXWjptX+KV/ln+z+JvWKbwoOmB380RcoAJeuQEARktIKCGwqr7l94lqOw6OajmB61l6EaRwaLvRpuTL4jSLAP9b1KBaoUxDUDWC/xy1IXRzYQX/XVdHR9eNlMGAxktnFz2iR4gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAdS53Zv7UtMWzJkWlbAvRNCKWNQMjJeSENYuMIjFf8=;
 b=mi0ik/v9S0DBLglD0kBL8Pdez/2QurxHXEr8XX7SERb+KxjsY1z8Jakcjdgd6D7RE08/FRtr1zK9zNfXxeTtzZDmh4ASnVZej97oOlZGtBd+pz62aJVmdm2NBiAXcRG/A4Xm/bl+s/3l0lDpnEPUUmvyEbLL3hwe/u3p3ozsr1nWjzBYq3hqGhlTousnMgxzJTB0T1SUYPqoZG8jfpH3Sn8dIqba8Z2PYewG5rzQiNdx4Z2JGUM/K+he7rvYhbGsFg3OdjXojh5ImcucILWIwG5JHC3Zp1KjRlhFSVgYFIgTfj6SNs4qCu0qWkpmYpHsIQcXv218WwJhwbFQ1gE0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAdS53Zv7UtMWzJkWlbAvRNCKWNQMjJeSENYuMIjFf8=;
 b=2Ht0pgzfc4Pyip5KzqnXNUXdN+bkqv0exvttN45cNxe8JYKKScUpSMopGAjRxwVmHjTIgAtBdMUIXzqwDXLUnE1JzhXOLsWyUHRyxZKbkff3//n5LYJqn/bqjZCqewl7TGQobv0mEfwbJ8J25VFfdaVuv46iAqwFYIikakEeYGk=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:13:35 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::93) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:13:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 06:13:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 1/4] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Tue, 16 Jun 2026 16:42:39 +0530
Message-ID: <20260616111242.2922144-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
References: <20260616111242.2922144-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb01498-29ba-4029-81ef-08decb984ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zkC/RGFT8vJIiYd0IyR0AESlah61LEmp7j5iGpXN3CVhfxl4l7kCKuWY1DR4XjhJfv2uS5v8b2EYKj8fQSWRbyTT0MrOl3P3oyWnSXY7ENQIYtsHf/qrRJwH8li19CO01aYNkbjTx906tajJgkgxEDNr5GoBkqQFMuSTBn5VlcrC0iQ8N5quSGoUvjUzR0US8g2lgzmqH3QbhMFD2l8I794aUl6gGFBI/Gu3dq7Jt3GQvZkiroEapitqWD1L5+jNFUyYcyZccDKDBa7HN6hj+6xICfKox9iaBNz5djXDLFl7gAp6r8fOxYZ1wtL7DeIyxhHltROHSYdy2gc9n223OHj66alevvk6umsrhUzTgMwBKLrDJFpjRbN52nn8BrIBi/NSXzSwwzVK9UhOIMguFSgwu1Q5tZmaj8Exz+kKuSVvBmzf12FNiFdHc7D5Lf0ZZ854sSLrG6QN9zY7bNACFOZSGFN1FykqTKP+yZYmTV+x3WvkKKV3bTORFHzfgLs0o2iWUc4RojemtILOrWqPyeVspSJbibA3XZ2jGO0RcR1zhcIcTDv8cLGLOdY6xK8uxvPDf+2SAqBG6OV3Cj/Ej0a8K1UTnzCJ9e/0aK54xRvulLnyUpgnyPRMAJAjq3GvdK7Xvl5Xa7ShdQUM9pgX57Rqqtp24XhLiASiGC6P1mlzKzIc+FbtCBuR1XkDd2Pp6DpG62dnfg3CxBAXBHcJdMZzy2E2C2w8PrRYQHtjQ+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: leP7dKJrlWloHLrVCWMEjQU1Lft4Nyku0mpm252/iD5cxfAjaENO73AICvsxX4AxD2fk3ElaU7Njvy1llID7SuUhKf4hqkfXI7kymFSzLw7XsDrUDvMDfn4SuNdRkf7EEEjgT+KWAebXdgBzBD3RHRP0Jp8NpxSlFTdPVHZHNpYf9ygDJwVWTky97DAeykrHAIEVlM45+EBNSuflxUqlVykKVl+US8/5/MEBauiGXiozemirRJePbvgr+GRkz+zojp/Pd01Bus5MtOyjuO3Zm5WTllUelO695T5r0nMKdt0ecfCFD3bo03BUd4akL0RVSZqsqqPXaiBGu/6vTp2b+SvuCxdNrHVJ1jfeUNultfxGzaTdFuImsp+5HPdCUNUmfJi7RjMORL37sP1XJ5H3EMRfLaOo0tWLx8FWSrQlhROCxSynPdgvWAj18sW16Hb2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:13:34.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb01498-29ba-4029-81ef-08decb984ea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

queue_id is a userspace queue handle used at the ioctl boundary and in
returned metadata for queue-scoped events.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bf4fc61cf0c7..5785876ca9de 100644
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
+ * @queue_id: userspace queue handle
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
+ * @queue_id: userspace queue handle if applicable, else 0
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
+ * @queue_id: userspace queue handle if queue-scoped, else 0
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
+ * @queue_id: userspace queue handle
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
+ * @queue_id: userspace queue handle, or 0 for GPU-scoped events
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
+ * @queue_id: userspace queue handle for queue-scoped events, 0 for GPU-scoped events
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

