Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036BC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123F210E4CA;
	Mon, 21 Sep 2026 20:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GY4SmfSi";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650D510E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU3qP7QB6GXrtNhqSK17GEwQZczgEsit/lE759uWer4jn2Hn7AVDRJcmrl8UERtMxEdp84UiiX2vb8STiDOtfq16TleJXM/ZeYY1amzl/Ld9fyytuUzzMi+jRkyCHZVehrhKESoJN6RlgQNfwKEDm/UmHjpCBl//0xC41+e/kmd4jFB1qoFgPpZkkhQaqo0yvnNWYn8PJ+b2odkUSsUlQ3CpQbZmR2NlhKys739Wn1GPovrN3XtQ/bNCHjfXYRt8cFsBDtpwEmtsoqx090jMIGk8WzrZQObh3OH++pui6eI3FMX5URwspwJ2WWvRTR0EaVq1hLecrtXugHR9+p8B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+9hA2hfKo7Icd8fgiy56Shmy3Th/KFDnqvJ4ZwwvVo=;
 b=KmfLq2B9Z9iT5or9JBSLIZg+3Dpk6xq5AUzGX7qbgYg8ohxDLjyDrsqxuOz+x2xIj3OTW0tzRxQbQo+ovhN18JObfexqW5+CmXts96nFqoMrI44yORDvrv2hy3B1z5DOHUuK+whhrcWasBtz0DKJUP6f0OEnfZVw5Nmys36wj7c1dK0BTEIte+ZGhIEfRsFZ48u1eH8IpkkyF++d7cO6HxYr56Ze7eu+G4z5wYYp6tw7WhGJM0rQvkog1PzctXLQApSlK6kT1x8rgsQqDLt2kvX3BEA82YRTZNcGIhLXO03u9rFCgRBmrP6b8q1ayG3WpQEZPsbRfv0utdXLBc1evg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9hA2hfKo7Icd8fgiy56Shmy3Th/KFDnqvJ4ZwwvVo=;
 b=GY4SmfSigewue70wW7mzNHCiKqfzoJySrl4uQ0vwNTBK1bHC1T12Y6mS7Mq0nwYo3EpkB3KhvGwV/9WC3dnLBeJ1fnfkeICEL4hx7QwccjAJKYoxUs7bkmCyfHvh6xd46agCtyHQwxiwQErhB5Xt1goG2qwfpeXNpr9AuyJnFXs=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:08:30 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::e) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Mon,
 21 Sep 2026 20:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:08:30 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:01:06 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
Date: Mon, 21 Sep 2026 16:00:50 -0400
Message-ID: <20260921200101.859141-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cdee69-394b-4f47-1144-08df181c1b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|3023799007|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IXlHjgBt3jCeticPvGolijcYyxZwoVd63WXWDHNe75wrVoT6OsQwq2Wpr9rmcS/BNiYSkEwsODtK5dlUShKfIWoCMGFfJZyBJ0c3W06i1G3GWeizvC7xY/rt+EL5UemuCqkab2phYCs7SPWvJWCGeNKnLZe+BkYNESiOj6cmPr+rBDVhUO8mQS2IvWWWlLG4rWeLC8fIYHfcWFxxc5sERMsVWtSdg8CKLwT1a6eCCLJz6Wsll/WiIIUsA2TfFmT/IJMyOejxBkQrfZTdsipGivscoFuzBf3KPtyZY+5L7YtD+Y5DPyRK9WSimf04EXIPkSJ2N/JNwnPhkm4DsdeHb8Rr9Tw63MZJ91lr+ISOE6/dP9dyiZbQEWituBK/QJzKMUlNW4J9+Zd9LwLKlxxh0p7zntUXWph+Yy+kJj56mX+YJJGTVRvfQ7fd0dj1BXZ6uE4sZxPGFr2by9Gyfgs3a2o4D6jDrAf2N4P6iOBnrYXjsFLadzDtvBoYll++b5KXJz02YCl/oPcEpAEPsUX7LoFXpikHWmB4iHfD307z7tJ/DaOyb937nBAngWAdO7RUK+fmVKToj5RCJWiFfsttSyQIOb3BXiqHw+5KTaitT2LhvG0gfW3X1+9ROMaDrxrkwtDlWRneRKwu51Mh/BuLpKwMzjZ0jdPl9WXm2WBP8AZIoEtvq7hLQMo62krsrtnbDpLMCmm+8OBREYGkHf1iCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(3023799007)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ccgSZmhDRwCDT3YDl70nZe+4wxG4B59yJpcltT4v1wwjaa5GnbNmRzSgnVOc3BruODfZVLEBq/KO/PEx4BtXnvTWcmec0hq45xi4W037QlsRq2mXXHitBGHs1O0oABcox7NFlWkO+0zloFi7NwEC2g/fzNfOkPb1cNn044LDHFgHTludjkU8XSukzonUsz8xsVLUpd/n+oC4tuQDbxl3vLXuqujIqjMvp2QVhaBqtfDJe3TTPAS4M/cyShOEaNdODuBxINcHLVZ7zCpko/7/q2FRre4cTo8/1xk0fgJvTgSeHKBLF+HOeLRdsJXKL3pkIbjrR0C6vMeKMMWK/fBrX28jekfwhiaYsP9R9YBtocOBbE5772C/yCb87QIvYNu66pw0AeZr5D+KcxN1kG9m1NPgIg1OBRzsXSzz/nrr6jr83oaAOPt7b5ZfLKiPmvaq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:08:30.5686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cdee69-394b-4f47-1144-08df181c1b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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

Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
UAPI for GPU performance monitoring features such as SPM (Stream
Performance Monitor).

struct drm_amdgpu_profiler_args carries an operation selector and a union
of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
destination buffer are described by struct drm_amdgpu_spm_args and
struct drm_amdgpu_spm_buffer_header.

The ioctl number and struct layout are frozen here. The implementation
lands in the rest of this series and the ioctl is not registered in
amdgpu_ioctls_kms[] until then, so this header change alone does not make
the interface reachable.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9e5fa6f53e59..285949d63eb6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_TRAP			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+/*
+ * Supported SPM (Stream Performance Monitor) Operations
+ */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ */
+enum drm_amdgpu_spm_op {
+	AMDGPU_SPM_OP_ACQUIRE = 1,
+	AMDGPU_SPM_OP_RELEASE,
+	AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @dest_buf: [in] used for the address of the destination buffer
+ *            in @AMDGPU_SPM_OP_SET_DEST_BUF
+ * @buf_size: [in] size of the destination buffer
+ * @op: [in] specifies the operation to perform
+ * @timeout: [in/out] timeout in milliseconds (in), amount of time left
+ *           in the timeout window (out)
+ * @bytes_copied: [out] total amount of data that was copied to the previous dest_buf
+ * @has_data_loss: [out] non-zero if data was lost (e.g. due to ring buffer overflow),
+ *                 zero otherwise
+ * @reserved: must be zero for forward compatibility
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified XCP for the calling process.
+ * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified XCP for the calling process,
+ * which allows another process to acquire it in the future.
+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dest_buf is NULL, the destination buffer address is unset and copying of counters
+ * is stopped.
+ *
+ * If @dest_buf is not NULL, it specifies the pointer to a new destination buffer.
+ * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for the previous
+ * buffer to be filled. If the previous buffer is filled before the timeout, @timeout
+ * is updated with the time remaining. If the timeout is exceeded, the function
+ * copies any partial data available into the previous user buffer and returns success.
+ * The amount of valid data in the previous user buffer is indicated by @bytes_copied.
+ *
+ * If @timeout is 0, the function immediately replaces the previous destination buffer
+ * without waiting for the previous buffer to be filled. That means the previous buffer
+ * may only be partially filled, and @bytes_copied will indicate how much data has been
+ * copied to it.
+ *
+ * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss will be non-0.
+ *
+ * Returns negative error code on failure, 0 on success.
+ */
+struct drm_amdgpu_spm_args {
+	__u64 dest_buf;
+	__u32 buf_size;
+	__u32 op;
+	__u32 timeout;
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[9];	/* must be zero; pads this struct to 64 bytes */
+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for drm_amdgpu_spm_args->dest_buf
+ *
+ * @version:       [out] SPM version (0-23: minor, 24-31: major)
+ * @bytes_copied:  [out] Amount of data copied for this sub-block
+ * @has_data_loss: [out] Boolean indicating whether data was lost for this sub-block
+ *                       (e.g. due to a ring-buffer overflow)
+ * @reserved:      Reserved for future use, must be zero
+ *
+ * This header precedes the SPM data in the destination buffer. The reserved
+ * field maintains 64-byte cache line alignment (32 bytes total).
+ */
+struct drm_amdgpu_spm_buffer_header {
+	__u32 version; /* 0-23: minor, 24-31: major */
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
+};
+
+/* Supported Profiler Operation */
+#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI version */
+#define AMDGPU_PROFILER_OP_SPM			2
+
+/*
+ * Profiler IOCTL
+ */
+/**
+ * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
+ * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
+ * @pad: Must be zero for input validation
+ * @data: Operation-specific parameters (union)
+ *
+ * GET_VER operation:
+ * Returns the profiler UAPI version in @data.version as (MAJOR<<24) | MINOR.
+ * Input: @data must be zero (reserved for forward compatibility).
+ *
+ * Design note: GET_VER is intentionally a parameter-free query returning
+ * the global profiler UAPI version.
+ */
+struct drm_amdgpu_profiler_args {
+	__u32 op;				/* AMDGPU_PROFILER_OP_* */
+	__u32 pad;				/* must be zero */
+	union {
+		__u32 version;		/* GET_VER: out (MAJOR<<24) | MINOR */
+		struct drm_amdgpu_spm_args spm;
+	} data;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

