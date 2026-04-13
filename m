Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C30DF34C5F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D083F10E4AD;
	Mon, 13 Apr 2026 14:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ez6b4Gik";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012054.outbound.protection.outlook.com
 [40.107.200.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E46310E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we6x+GVnoXGNjTwrXtHNGi6yxVKzCVXohIFKbXdSpOCr7LHeu4iRkfoKu7tKtPN8Bfm66/2e7QKckLBYtNE5QpsMghx0gObIbZPdDr3LpHR/ylGZe8Dz79N8NYcmPN0KfkycbL7w04tfSaKMDmXS0RMtzmTp4hUbSV5PBcEYy/L7gHVLxcurGSBrexZwSIMH5Po89m8PmWuKuzFdMf7KzMmrTVtr3JNzFMJSK3mV+Z+vu4v0/EKV9KW6nyfgCFIff9868D1vjr3htV16ewKGBf+RJsZcqjj3WZ3+KgIUb3kXtROhaJqd8l/EQ6A7H/nyc8a61yygsHjChuJc7tWnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scX2AE9uRklkRtOwIeeUMFNxu6MR8BXKhW62rhPpN1s=;
 b=PdczGRUk+PxvFW1dTvyEOBn9rFgJV0IhE1Qn68zRpfdSIVYqMXb8yLwyvYnhOpGWDPUJFnRoC4ClgynVENhxZbc+AOQCeKk5U19MvE9DTH4doXdkwoNjckQK433zAHb2GKjn+uBtfowsGL2sZcwoix1oM0l+vSpig8N78DVsNhZX+1qy9Cd8lzP4WMoRYi7y8cJBSmyMfKVo4BdbLDGmDZAENsRW0nwTkwqITXOXIwGYLZVIsRjY8WTVyLGpaKm4B3jf5lq9d8rJuI1jUPZcv4MtP779P1hMYyuAUYCdqQE3tksX5DYRi/Ky7OIu4gw47JyXmddo1r086dJX0LtHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scX2AE9uRklkRtOwIeeUMFNxu6MR8BXKhW62rhPpN1s=;
 b=Ez6b4GikLdBLSIVNS9ojmZ7QrZsaw1m7LyDIDQsUzbyasMi4uFNF/rbpJX/l/J7CyEes6zQM2fpE9kjlsatjIAdIqIXS2WnbucMuI6Y4Yp/z/oWNNzUmQCz6nPfuxr6c+FPgKEVbWS/tUjlbPIuVo1ax4risUbBvTcr/sLK8m7A=
Received: from DS7PR03CA0317.namprd03.prod.outlook.com (2603:10b6:8:2b::20) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 14:58:16 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::41) by DS7PR03CA0317.outlook.office365.com
 (2603:10b6:8:2b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:58:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 09:58:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 1/4] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Mon, 13 Apr 2026 20:27:42 +0530
Message-ID: <20260413145745.2326236-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
References: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: f2424029-b25e-4188-51a6-08de996d17b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: KjsfoWr0fObJ4X6JOtEbyWPD/g+qWuju5Ix6Pxx+D6CHuFMAWQA0Yy/BwMOjXWBXg3ekeFQT1qWZ/jcUI/s7I+yclGTIGMuBvDN9Owr0mEEAN2sXs6cYmorLBeCO/QHg5HTzX4ypCP73Sg8DRdCAYyROljbrdKOR6PTsMDbCVAsoTNg4CYa9C2dMDGBklrTHG/k0Ld2a7Bw8FVaWqGvEj73FmlIiTUKh75bFc6+6ixp/KH3zQzr9ejJbyaORDxhr5UjRkfgjr33vEQmYh2Y2X6v+fjRsGgER6Qn2we9SOnpD/tSIMb8oj27ydATovmIgUlCkZx7+YxrUl1t6mWCCRZOJJVwfrNfBkQc9eIScGYT72ixYCQJtYDY8hACC+i53XpLk5wo+3RoawszDkzFkKfmcQ8vxYLZA1WBUu/Np1ZwzplEt84432XjGky+n9Vb3HujLILoqZCMrt+LmsXaSKc0h0PWyuMm6K05gaqs/+UetGOQ84iHa6fjnX+plQvWfgHSZ0k68VVSEWSyBSsLgwcG4fAvdKic3uUIP/YjQCT2zoeCq/mFGhqqj5thr8kDrfl3YPasSb3w07iJiYCtDj/ewuGo4pEz5tboFuxHBPhtc6kKTzifH6RP1lDFbcJLdyoMoFmwPMUcAHjHVY8Kne8k1huewEz+Q+MeBahRyQU4jTd8YkAyOHpuymtMtZ9J4lyOko9yaPeVjZHKqN/FCcBZYIfMH2dCMzU+VFmZ1Sf0PXcByTkjG641FdvuJFfWcnJ3ouYD1cqX+NvaT53oaBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0csHpu0yTdvrk1okK37AiBvKQHr9Zpec9NpvBaABMyep9+o7Aeab9iqiVcHDHgh2T/x2ipcDWWx9H9Oudep1wUsKOxv6q5erOz1DFttfXwTEVyTALL8tlLAH7/NcFj/TyWB9tyQAKxeiiBvei1u1N8XMXxdxMianfWdbxMif3t7a3QQWQZEaQ0u2sXBKrh+G++psykLl7l8btLNLDle697+ygp+43oB9PKPb45/RbakMOBcic2PU4dT3VAmYLJBwmN6zFlvOpSxdypT1mvrIIsVgDEsmY/XsyFeUZQJycOVwy1hCIZsFkuF2Bt5DuPO6h9b3+QvcBFx+M/8Gyh1jeP9SfSFL1++70G8YZhH7liDzZA3oGvBvmpzenPnFo0vxKoaNCekC4hJPpvFc2tA2BGXDvZUTRsa9I6K0RehJ0vp3CRawElcSdWQMMHRYON1/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:58:16.0692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2424029-b25e-4188-51a6-08de996d17b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

