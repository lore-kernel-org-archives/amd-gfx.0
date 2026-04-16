Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D90F433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2110A10E7DF;
	Thu, 16 Apr 2026 03:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ltEQJL7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648FC10E7DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx3Hl8xnY0BgB7FXiFKqAWw6T2qkxQWUITcHpfpnT3eEaCNKkPOFu2KxUp3VuABauE8w1V6xFymglQk/ysTqzQnNWPVbLT1lozI786Mc7v839jbbDNj6evunnidD3QTphWQeoN2r1P0+1ZLaG46sN0doRIQhuGT15RnuoZM4iBNq3bYFc4VjFPJ5dxE69sXBUE7OUEEpSiMKBRSDe5YK5EOe3PvLo2EorLCdXTJ0L5Oj/xPoWcUrzEaKBx64mh4z3QRDqEitpCnh7+I3QKuWsBbXpoGoXX80MvKUfV6wTNMx4wQGig+VRDdWBM/jmNxkArqbQLaYGUkK4LQFAPcmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=dcrfV3+srRh2AtDbqrUnxbU1IvqWwFQDsRl6WbKKYGSa8tMvDhbdign3/i+kgM1Dd3AxZvNfyxFvrCaHo4G4DpI/gia7sNNV3W0QKtTzAJwn3CwGQf2YU+zHHExuCz/BgVjIGQ6TzeqjXzwu6tgJHBqlfn259De07fNQ8Ki8gJTl9+ez+L5uN7u+tZmANyB/75i304k9DoKqin+ex4bfumUfQq4CuqC/tGuzBQXzEo9U+hBaMFdj6x3QGSO2WHPqJz+HgEIlt9Zq1xOegbXHmlgehrUEW6rhyo8LzeOLGqpj6i4lxPIsMjBKOQBrEB0W1ohLRMn+VJp9fDV+rcwoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQkGpX/mxy6PgJoGBwYFwC29SnyC7sA/fE5LWDMOOXY=;
 b=0ltEQJL7lG4PpzaimMmQwkoJS886nzOhPZCQVsVM92VgtwXDBHKIzoaofdd7mf7cgpjcPbtT7PtKmsbWj28KZLQruosOOfeXaguBl2/2oQCCp0c49nmobhdFvRozBjGzcitciqoQvH+4qmWVdqvBGY+jyhbVnfBcrPzggeiHUk8=
Received: from MN2PR19CA0063.namprd19.prod.outlook.com (2603:10b6:208:19b::40)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:45 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:19b:cafe::cc) by MN2PR19CA0063.outlook.office365.com
 (2603:10b6:208:19b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 03:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 01/11] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and
 metadata structures
Date: Thu, 16 Apr 2026 09:14:10 +0530
Message-ID: <20260416034420.2368152-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: fb45c559-b580-4742-7f96-08de9b6a7f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: maWvS4UikdDhT0RAxC4GWYAKqQYOGXcL3N7lJ2KXJwDN4W/vTyV4UDIesoDzVTvtgJJOUcW06pFxi8QEnLEx+QiXJHp0DBYjb2WwnZktMVaj8I11LZ+MJKXlJ6+UrFT0MzMQIUtsK/MkQMRDSQjQvbr+UrxYLHgMG65x6SG1eSrb8qFUr6MIlenkyh86anzCFRxiCiONGzq/coy6HFBnqs7Ddh91E2RW4jeCupDA/pcHG1VBQfXU2x4dpSfW6eHKlwgDdx3n4VPi6SKleKHzcQ1qsHVpBM0p8HLhzgZXxfN7HZCQCngWAhU3sCrgLZBfE8gLgdCKyjxdOyyGMfqSFGlWSQ7fRCgoQ8nKnKe4Wg7V1wbUpTzKCkAo2hc/arGWrzG5nGorzaPuy/sjkn7GOyC+29r6LAtBoOWTZ6RJfcsR32jKGOdUtIHg49hYZ55x2iXl/0DoF3Q/ej6jHfqpvscOdHWQxdcpZi8i0oXfuHbJUvGQvCve3zesRdDDyAMpx/02mCb1yBfmJtkwoEW9Iihp0TOYiesRAT8qv/unSiH6dAoLy+3N8Wny2OUUjleZtkQUVMKFAAQukN8BEElSiChb1NYFLDVVLgZTjsQTXsszjiyzQYphLEoVUw9GagvicEvBGRUxvaoazostFdzGNFmvfvNd2nidXQ2ScMe+C5ulWiFQpcnx1pw/zxaDLz3DQ/T82Pk7+KfjHj2dZi7vVlLf1574Q03NOAilEtEZx8cw0LvMxJuB2xrTOMmbm0snGatdEyVgPojQ4nnBRSEARg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f09bdYpWzQQ1hHvzbvlpMvEDrcqO0Hv9WSM7lTnDDcjMT6veI9BopwCd2dpaN04C6zBjbPfHZJa6/FPNh7gZGOnwqZt64Wp9DAc/r7p26z6jva9bSeqvsW+t6za+cTyBv8jdDiG6nY4tQQ7cDj26rOQMOV8n+sS5gf+jxPJvN4BYNCT8NSTGiMMu7E6YhZz4zkUAPC0ls+SQ4OwfkC8E5joKgVcKYc15zOMkeLChA3WG4juF6BFZzbly0m0tmmZsgScBq3QSI+KvA01GsktlOznqLPqZoug7C4S+adHmBK7xPq5rZs7LqQaoUIssi/tfpQAp7KZ/m+jUZNkP5uMfCjKs8fGF3moFModWbo6E19mguXRuOfPHM7jYqD2mJaM8zEAT3G3+VNrNGOdJ26FvIOonI3sZH3mdL/Ye4FJJWiIZ118H4P5nyyoJ632Kq/C2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:43.8413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb45c559-b580-4742-7f96-08de9b6a7f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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

