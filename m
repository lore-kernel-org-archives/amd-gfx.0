Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE6C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F7810E3FE;
	Mon, 21 Sep 2026 20:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Qtacgvw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C1910E1FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4oN0gHoMBIiWVv/Fd3j23FiREmY7zVk9nIcjhhRPTMBIpI3xKZPy6hY0lBfmh066YfOhjQrJFLzqXmyOEQibmf90hGyRGa7sm2NNr2OuvI5Dkw2vIgTdsuvkWmZ4sF4Nm21nW1UE1zcLRr8S9VJWAstzv3w2UGaUjmrCvH5i6tF7lFZMo+Zmfp8GUdpByI3yYBpfglglV95Pxd03nanntA5VsrbeNbarXPHcSIlCNKKBuMjZ0bPPdiD5HaIAnj+hTWa2YjtWvO1431sR579FCUc4NfyRJ2t0mvGDuhu7QfxW/omzFjhAygSm9KFWukMIy2rOVwlYT6hz8kM1G19Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+9hA2hfKo7Icd8fgiy56Shmy3Th/KFDnqvJ4ZwwvVo=;
 b=uZYbG0dhYcI6IukVUwVFQwdQqesgG7Qwdtuluh9KKX1I9q0vcjrBZfhLunCKMjTdqYBfEWuCLKkeKTMejhdT4JFKqgewjKxS/8dIrYP50pq4Eg9anIlvVE2uDf/WGgZVro/AeS9VdrCck9ZchZtHiAHgFaOUyxh0ZQ3Tgy6/dgL+tH4C0OY/iPtpGhjR0QoQBDiVkjKljvAkE1N7he+CZAyicG9OjneKSLZKVtSaaN7jQ2pKTeW2oz4aPQmNt0TQMYxQ89hFsDSh7ZHINRZ504+7qaccSq8O0Gk2s1yqin2+7bDRzU+p7P32+IoV0lfWL5zNvh/gZq4H3ZW6CFxkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9hA2hfKo7Icd8fgiy56Shmy3Th/KFDnqvJ4ZwwvVo=;
 b=5QtacgvwyvLh8gaKBdOWNiodgkOBrz0pgV/Ouw40FlPXDWqRARyQwA7KC/V4b2tTLSiQYm20wQxPPgccZ6PojWcejXdTzmbXwnRtsjtV2v9o4gbDuEmquYZuKEv7wJVsRbkEQj+MH77CtmD/NCQO49q9KQsEv4NSTrl1lG2d5eE=
Received: from CP5P284CA0032.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:94::19)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:21 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10d6:103:94:cafe::61) by CP5P284CA0032.outlook.office365.com
 (2603:10d6:103:94::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:19 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:19 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
Date: Mon, 21 Sep 2026 16:03:02 -0400
Message-ID: <20260921200313.865829-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e00533-ac86-4a29-7e27-08df181b6223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: L8ezxyB0jvmAg3ah0JyvKa+T7ziS6joz1kN22Ufbw6GyOcOZkaYA6vij5R4DVmzWdnIoJ4HGolh5hdBeeHVWo1P4B8IHdVk9JMP9O5XV9MwKAHCyfMmQ1sycGIwA6z0vMIT+A2XShoa1WliMOF0Hsl2669OUGl3VJlQ9Mh0i8r8Em4a1hQgTd0cvqPWgw65ddIgBibmDVHLhfoDGe+fKbt6A77Q+dYrwZY32UAEB0TOKEyrDQWyfHMf/PkeBPxhVfYgG2226zGf25R0km+aVqPXxVkPTFrKjkir+b/V2lGUhv9IHM+jaLRkpFJCJemTiaci38IHSxwmUzyDbxI/LOVtuHHtMLex9AE/vW759HH8EjyFiq7pvshJOk4/8izfKa8L1scfX934EMdtanUHmtaZ6yP3p4rjt2ASu3ZyBR3WAdEziip8iixHooBwbz52PH18Zc4JG0NzNIRvzxmvQ3sKfYuP/Zm4MmYqWULbG+1QGqWqnx3Hgaq+1kYN2jav+eCydadpNXjdMfPbWC4O4j0ppBN0PDBKtS42D6emVWS6kTcagJqqNCOVIM0fV6BN4DW8M8tsXYS7iurxDiOekc5L9gA4mJaFTvDd0ThFF27AIkizO8xv5ZGZfvsMfHJceBe7xQmnrbzyavBpt5+pbw4+mMvOmBEisw4ulZjSTkuyLyazjbVBAVVEOIhR/IRHQGquiJ858SU/umk6ITDxGOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fHpW3HA/4bc5OLMQ2Ozfh9ljq5c5JilXhVMVHMrndqt6sklMcrqjYtbqfJkZbzk8VSEKuWvooFfkyJLjwEpZqLSwf5Em5fwpOJuaAN2xT3S1sptj78mJ2YHHyQ90UZ7dv/iCFjHlWSAIZ4TUtSHTG8VZkZqB8iakl1QE9A/WWLBqwAt77HFAs4vc+7fH/vNrU9U22r/qAN7o0PJ5/TOuTJLj0H9S99xtz6RFVnyW5GB0IWcaN3iOP29O9VY+gUvSWRbAQFwtlxK3V2y+bZ6+UrK17b/KqmbNttNKGj+dChN7Ux51SDol5v5cZPxw0Z4SsaEIDhkZGKdIw+FaOR8QLDncm6S7Y5LQQunzQPR+PNm2Dga/I9aTodmLiFKN9LI36/2KxgaXjlMKi+fEbJIcHkooCd+t+bEshLVbYXPorUlsFB2m9+kY/AouOIRoJQ1o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:19.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e00533-ac86-4a29-7e27-08df181b6223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432
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

