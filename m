Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F4FC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AD710E9C1;
	Mon, 13 Jul 2026 16:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEY2u1h4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F5E10E9C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsGofJoeb5PJ+NJoj5OPujpXo4jYxz6EAPFXyPAaPUb9K2yKVEQMtYl4yISCmYBkDDW4e1Vx8sjEB3zmP67O6lWq6HpG4fEnizFTYCsL1V6XPPsiGI73YK1RqeiFUOCnj5IJClxCztlAs+uhQOSk4eTXae6suksIVaDLCsvPts3GHqX6TzOh2/Pb+4GH41bRAqhlggGv0LCOvuL/xW5JnLhOPAa/QVexuRdEOgJPdCrsxHdhb8jPY7asTLZaOMV/ZgW8agxfUGECebMuYmND9soLe4xwaBfcOQbHyTVC92uNHgcPCd+HzEfODqrSLx684WMg0sfqOZrJIagMncSOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyTOJgWO8DMv7xberizjuvzKpp58nR7hWrkgLqpaogs=;
 b=dib0+QN1JqeaYPC4WJKt0F1Lef2G7g7le+82Kyi3jsu9RAFeeJkTUQM4CRWbt8+ukwJ5aj5RGFkA9Vqz94HqawD8P7Yj3MKcvYvAzKB0JueWkuBnk+u63oyhRaHQJT/jOYvfc5diq/7sbIePK3zigfC8wrUf/ABt+Xvpm84kfqyTy2OkBilCkCWRHhCzb4/OrkAs7VXN2ORctxffLtghHChQfJWZ/jj5bHqWuwJmGB7+iqffgjOpcTXZl6/4ooQSK2/c7IWntC0t1bHym8xm/4XNVBq4n18jRWpxB9R+tmQfxklIe49X5SNou6u+hnB1bAc/f2ZTrxYZFdcX66SApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyTOJgWO8DMv7xberizjuvzKpp58nR7hWrkgLqpaogs=;
 b=MEY2u1h4MLyUgGtKvk1svbio6/lC1rnR67VreNjs9b+Oe4vdRscHamdNJ5URyhK+vuylex58mObl/ByHg4V74mF+B8SVBO4g42eYrd1GmNXAgVyfqejMP2haVCcplWbRK9rYN+DE7Ej55YP4qJsfLEHHPzqTYfhTuKWoXSo/g0c=
Received: from SA0PR11CA0155.namprd11.prod.outlook.com (2603:10b6:806:1bb::10)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:43:51 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::92) by SA0PR11CA0155.outlook.office365.com
 (2603:10b6:806:1bb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 16:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:43:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:43:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 1/6] drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata
 structures
Date: Mon, 13 Jul 2026 22:13:16 +0530
Message-ID: <20260713164321.3350036-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 08be4523-0ee9-4129-6c6f-08dee0fde983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|3023799007|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: o39CLmNsJ2Jn2G6H1vZHPne5Ab/hpaKRFn6AwSXdcU48P11k+ywce0JJw6RRiSz4M95IlSu7YNRDaPyxIFGKquTBUPXCyziO6iRaVoVE2iCPM3GRptIk2gZIs77bPaDsOHoISjsz9KYR77WdiOf7XnCvLJZ5FJgSGdrxAslwy6eLodkMTKMqCZr6RA6ZpKd6aOimOAK2WNdx2clv+6rZSfyzH+om2aaiJyEd+OF5sSazV8/bV7oiL2B8FzbdKPaXB/fu5EtGd7jgIo5u40vwxVdt2LilSffj65fMH0FwtKLhYc5Iu3XGFW17T2cxkQ2kOozx+XiiQyHWPGNsl2/uhtipci56Yn6VQ+Lzq//hoFtTZAa31NPLXv9i1ocbzhYMYx5t5JdYFMzSvRkdoZurrQyqz+MJIKCMae1zwXgMROMZmK0jtcOyuiy40ZMnzSO36wDndrJFqDe1FKP6FfOCWmEYPtBns3DauC0hdcwhbrBQBmUHAmUukSeZWTbmhTENGvds8aK/vsJcp9BedCtYTREJ1rG5GlqProXGf9372NFXSV1u17gocJju1PjbTtnBrgXOWH/tGhHv+49j39R0jhqsVyiv3VCrpooWiNK0q7bLIp06bwETQ61nz561tUC5YUiYf+/Fmec+wR9ZLc9Oa3/s+Guqm/bICgenoekkyz86aq6u+G3Ukaaik+geG4pIDyHQY41uO/IAP+pOf2hNrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 40mn6Jofhi+7Nbr90zxK0FOMYAt6Re/Y9gv+vnDK0TQGS9wla53ZLo2hAoEh7z0/nhQ/ZJAB49solIvYIUzutZ7IleFI3R6BW6Kgv+qXaDDeVPr7b2otPjc4cHFKp+YMflM3zfTVsG8G+XZtzN0eHEvcKvDfx8cIoY3v9zRF+OHhKHxtnCpGdXwu0mvHRh0RW1b4mgj3EUW1x9hHgmFsQ9p1KVoMk9B3+/g1nqLkbszXNGct/9bOmKjGH/PicQq09+G/DSoTfjZPPnPfZqTOnYJtTxaGy9nr+YHQGm/0G4xNBzEfyKvbaU8wCcddbZDlIe+YkjnG5DL/NX6BuV3DKx/j3SXZcTS87Hnf4AwtvIKNdA8sDjpSVw+8uECNpOC17psoL0dNFDHCfmkVSLji4KKWPl5QQzQ3qJEwH9RjFOq0KBVqmE9gZyrB2/5r7uup
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:43:48.1610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08be4523-0ee9-4129-6c6f-08dee0fde983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
index bbda6ffc498b..8b6fddb43e86 100644
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
@@ -251,6 +254,106 @@ struct drm_amdgpu_eventfd {
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

