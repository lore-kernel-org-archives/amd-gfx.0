Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5786ECD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 17:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10A010F57E;
	Fri, 15 May 2026 17:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyTGPcvD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F245410F57E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 17:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcCmg6L1Omb+s/BX81Mq5l8cZ/VYrho96ID0uanFBehy+L7dpDX88v12W3XTGBGMaRdbmhT6dIdhQvFrGc6t8ej4Vr8m1/zHrT5iPZjZITmObJh/AQ6Wy3dFj1LHkIq8Pt0TbILzSJ1IhkUy+UMGCjhT4enGkr2/2tMl6jHzPZm88/owd5ENPrG2ZdVpT7qUYOGH9UXU3/RKll1en2f8gRW0H4Ya+VgwUIsz33MZcUKnmLhiOxrkF29UZ18QzmehQ6YrFpOQWm+K8dp+lB474CxVPpsT/KFKW9vkLiqWjx3R1M+tAwEgyW6PGFUa6kTdGOSWJmOPVmYWc74H2qlAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY3sJwfRX4QSnut8IOXImvsAaJAN87ncOSBwgseuvic=;
 b=HZ9ba6Ico7Iv7Qzy6iMfx94COAvXvF9TBEVgh022FIiCepAury2sdUwbGl1pFPknZs5zyUQE0DzwEMJEeTO3RoDu2aBvUNK2cxXWO9j1tI4N6CyBWC66VTfcFNgoOxN7hIHsw9KEleWMoCU/cQB7lM0kKeyycuDRtDUguhfb7EORPzuQ2ciUDI+mLJNCCZtJeWinI4dSPTUtkNw9BAbMC2kJ+KMVeplVIUqARwBizFWHbG5oPwirkrGyZZbt/vQxQClEEkMIR093VmhdrPCKSKCsvJf6hZ8pHU7j6kJrqk92xaTv0jtUOmxSonJBAs4N/rFN0lO2i8qRKRPkoiVcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY3sJwfRX4QSnut8IOXImvsAaJAN87ncOSBwgseuvic=;
 b=LyTGPcvDVvyhBuGWtV2/ihqwtvAolVMLOLC/cd6Sy/1yy9xs7UPOaC0uufn2SXp8yKgpzd2jN5EQZKZLGFhWC+2Xdjw4BLNZ55wijL0GHvXkfES2Dlg12VYrRiBsoHB6231LjAo+7cVNDqacdQxkE+Ze7+Uz7jU5TPR0bQWrS9A=
Received: from PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::34)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 17:15:02 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::25) by PH7P221CA0054.outlook.office365.com
 (2603:10b6:510:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 17:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Fri, 15 May 2026 17:14:59 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 12:14:59 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <Chris.Freehill@amd.com>, 
 <jamesz@amd.com>
Subject: [PATCH v2 2/2] amdgpu: Add Streaming Performance Monitor (SPM) data
 collection interface
Date: Fri, 15 May 2026 13:14:46 -0400
Message-ID: <20260515171446.3704735-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413192947.3145878-2-James.Zhu@amd.com>
References: <20260413192947.3145878-2-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ce036d-ca5d-4ada-d7c7-08deb2a57ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: X6GFgJvPa0CSW8SYeoVNAEME8Uv61IZEuZ/ZmVzro/edBdoXYnhIShgA0Nv03mRs0sSPK3nT0V+IJsXfzgjlFsu5AwSYejyuPg2cmgQKXYeXRlnlncOb3j9ptdHXJdkAyrcDoKZHvtZEPKOO984lHyxUQgVal03BcWwyj43PklFmz0k++ciQpEKkSBk36Hlu9KdFQiF24GqFjiO78/xyMwRNIXy4TyFO+tifX90e24CTA1vrEMOPnrhWl9lCNPtM6WLl9G2ZaBlpObZF6/B/w/9km3o1emDZgdVvTtCV7h7+Dqfk69sy9NlRQwEmuPTDUcEKx4fC6mwDQOVIhjizkadmfIXh8voaYjEmhY/AU3oRvd1Czdk4X/Yr6W7tOCyQDeBOEoa74J/9i/iDF5GA6fIfw5T2H3wUQOezWYCZLObxaUjy6r6n5pE/KQ8kim9/4KTsKGybzYrfmqgB6gVuoX43X05CyQ1cYUVj0P3YOKSXqD5WagnscWy7uYBOMGBWwfQZxdzxHiQ0IYmiU6EI7RsVZe9GPe5cWo3TCXGGMDB7ryJU6FJHrYZpC2uJlg6da421AROeWsa/zjZ2ol/r8siJBtTF0Xu4KkjRmVs9FHZLROkpDOi2WXnUa0iB+WRc0yuIJYGObTl/FgLZXHPBJ5cHI1XpBniyJeMwvgbr+N9nYKzBpGRi0gOpkJYKB7ioL35jWodZep4cSH9+yIthvL9y+t9OvMATNUSTyGdbqYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OeNdttGg+bZvpZOEMXe5Vp31aabFODyNTaNo3qTljoo107/PRTDxXK91lhFaAFzEDSPRJdgjRDDix92Y1X61w3A6hH0gdl5CSDFImEmjcgWQdp+6dsmACSIs2lDW5Td0f2SieRi8dhv94QV+cR0BQyl6rz2vARPVYXJd/ujTpPVHdqWEd8U+a0RVJPI/Mse3YepO1Xx7RlCTXhpDY4+8NrqNqroa7hN6CRf1br5U22F1HD0ofK4nXoJlOEsu/c4pZA1YHCzoSDEw87VM/OIVuP0X6wQo+6qb80IcVXqA+0xP3zHXteRl65EVKa8/WRISiqViV1tqDyZbv3IeQTLLsbbL4IBkabIahp3JOIjYDOpB4icV2xGLtwLPNao5wloQTBwbPtgKr5y5TEVOpF15DnvYVd8k/IpaORijzwqv5MTA4XSAhlyRAW84hvZ2vIAe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:14:59.9930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ce036d-ca5d-4ada-d7c7-08deb2a57ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

This patch implements full Streaming Performance Monitor (SPM) support for
AMD GPUs, enabling real-time performance counter data collection directly
to userspace buffers.

The implementation provides three key operations:
- AMDGPU_SPM_OP_ACQUIRE: Acquire exclusive access to SPM hardware resources
- AMDGPU_SPM_OP_RELEASE: Release SPM hardware for use by other processes
- AMDGPU_SPM_OP_SET_DEST_BUF: Configure destination buffer and manage
  counter data streaming

Key features:
- Flexible destination buffer management with configurable timeout behavior
- Automatic detection and reporting of data loss due to ring buffer overflow
- Support for partial buffer fills with explicit data size reporting
- Detailed kernel API documentation with operation semantics

The amdgpu_spm_setdestbuff() function allowing profiling tools to efficiently
collect performance data from the GPU. The timeout mechanism enables waiting
for a buffer to fill completely before switching to a new one, or immediate
switching with partial data preservation.

This enables performance analysis tools, and profiling frameworks to access
real-time GPU performance metrics without kernel-mode overhead.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 amdgpu/amdgpu-symbols.txt |  3 ++
 amdgpu/amdgpu.h           | 38 ++++++++++++++++
 amdgpu/amdgpu_profiler.c  | 68 +++++++++++++++++++++++++++++
 include/drm/amdgpu_drm.h  | 92 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu-symbols.txt b/amdgpu/amdgpu-symbols.txt
index 69840193..e09e265a 100644
--- a/amdgpu/amdgpu-symbols.txt
+++ b/amdgpu/amdgpu-symbols.txt
@@ -89,3 +89,6 @@ amdgpu_free_userqueue
 amdgpu_userq_signal
 amdgpu_userq_wait
 amdgpu_profiler_version
+amdgpu_spm_acquire
+amdgpu_spm_release
+amdgpu_spm_setdestbuff
diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 1519fe4c..0fdf5589 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2130,7 +2130,45 @@ int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
  */
 int amdgpu_profiler_version(amdgpu_device_handle dev, uint32_t *version);
 
+/**
+ * Acquire request exclusive use of SPM
+ * \param   dev               - \c [in]     device handle
+ *
+ * \return  0 on success otherwise POSIX Error code
+ */
+int amdgpu_spm_acquire(amdgpu_device_handle dev);
+
+/**
+ * Release exclusive use of SPM
+ *
+ * \return  0 on success otherwise POSIX Error code
+ */
+int amdgpu_spm_release(amdgpu_device_handle dev);
+
+/**
+ *  Set up the destination user mode buffer for stream performance
+ *  counter data.
+ * \param   dev               - \c [in]     device handle
+ * \param   size_in_bytes     - \c [in]     size of the buffer
+ * \param   timeout           - \c [in/out] timeout in milliseconds
+ * \param   size_copied       - \c [in]     number of bytes copied
+ * \param   dest_mem_addr     - \c [in]     destination address. Set to NULL
+ *                                          to stop copy on previous buffer
+ * \param   is_spm_data_loss  - \c [in]     true if data was lost
+ *
+ * \return  0 on success otherwise POSIX Error code
+ */
+int amdgpu_spm_setdestbuff(
+			amdgpu_device_handle dev,
+			uint32_t             size_in_bytes,
+			uint32_t             *timeout,
+			uint32_t             *size_copied,
+			void                 *dest_mem_addr,
+			bool                 *is_spm_data_loss
+	);
+
 #ifdef __cplusplus
 }
+
 #endif
 #endif /* #ifdef _AMDGPU_H_ */
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
index b3d119bc..8f6488a8 100644
--- a/amdgpu/amdgpu_profiler.c
+++ b/amdgpu/amdgpu_profiler.c
@@ -47,3 +47,71 @@ amdgpu_profiler_version(amdgpu_device_handle dev, uint32_t *version)
 
 	return ret;
 }
+
+drm_public int
+amdgpu_spm_acquire(amdgpu_device_handle dev)
+{
+	int ret;
+	struct drm_amdgpu_profiler_args user_arg;
+
+	if (!dev)
+		return -EINVAL;
+
+	memset(&user_arg, 0, sizeof(user_arg));
+	user_arg.op = AMDGPU_PROFILER_SPM;
+	user_arg.spm.op = AMDGPU_SPM_OP_ACQUIRE;
+
+	ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+				  &user_arg, sizeof(user_arg));
+
+	return ret;
+}
+
+drm_public int
+amdgpu_spm_release(amdgpu_device_handle dev)
+{
+	struct drm_amdgpu_profiler_args user_arg;
+
+	if (!dev)
+		return -EINVAL;
+
+	memset(&user_arg, 0, sizeof(user_arg));
+	user_arg.op = AMDGPU_PROFILER_SPM;
+	user_arg.spm.op = AMDGPU_SPM_OP_RELEASE;
+
+	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+				   &user_arg, sizeof(user_arg));
+}
+
+drm_public int
+amdgpu_spm_setdestbuff(
+		amdgpu_device_handle dev,
+		uint32_t             size_in_bytes,
+		uint32_t             *timeout,
+		uint32_t             *size_copied,
+		void                 *dest_mem_addr,
+		bool                 *is_spm_data_loss
+	)
+{
+	int ret;
+	struct drm_amdgpu_profiler_args user_arg;
+
+	if (!dev)
+		return -EINVAL;
+
+	memset(&user_arg, 0, sizeof(user_arg));
+	user_arg.op = AMDGPU_PROFILER_SPM;
+	user_arg.spm.op = AMDGPU_SPM_OP_SET_DEST_BUF;
+	user_arg.spm.timeout = *timeout;
+	user_arg.spm.dest_buf = (uint64_t)dest_mem_addr;
+	user_arg.spm.buf_size = size_in_bytes;
+
+	ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+				   &user_arg, sizeof(user_arg));
+
+	*size_copied = user_arg.spm.bytes_copied;
+	*is_spm_data_loss = user_arg.spm.has_data_loss;
+	*timeout = user_arg.spm.timeout;
+
+	return ret;
+}
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index 307242ac..60c73233 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -1698,10 +1698,99 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
 /*
- * Supported Profiler Operations
+ * Supported SPM (Stream Performance Monitor) Operations
  */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ *
+ * @AMDGPU_SPM_OP_ACQUIRE: acquire exclusive access to SPM
+ * @AMDGPU_SPM_OP_RELEASE: release exclusive access to SPM
+ * @AMDGPU_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM streaming
+ */
+enum drm_amdgpu_spm_op {
+	AMDGPU_SPM_OP_ACQUIRE,
+	AMDGPU_SPM_OP_RELEASE,
+	AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @op[in]:            specifies the operation to perform
+ * @dst_buf[in]:       used for the address of the destination buffer
+ *                      in @AMDGPU_SPM_SET_DEST_BUFFER
+ * @buf_size[in]:      size of the destination buffer
+ * @timeout[in/out]:   [in]: timeout in milliseconds, [out]: amount of time left
+ *                      `in the timeout window
+ * @bytes_copied[out]: total amount of data that was copied to the previous dest_buf
+ * @has_data_loss:     total count for sub-block which has data loss
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified for the calling process.
+ * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified for the calling process,
+ * which allows another process to acquire it in the future.
+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dst_buf is NULL, the destination buffer address is unset and copying of counters
+ * is stopped.
+ *
+ * If @dst_buf is not NULL, it specifies the pointer to a new destination buffer.
+ * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for the previous
+ * buffer to be filled. If previous buffer to be filled before timeout, the @timeout
+ * will be updated value with the time remaining. If the timeout is exceeded, the function
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
+	__u32 pad;
+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for drm_amdgpu_spm_args->dest_buf
+ *
+ * @version        [out]: spm version
+ * @bytes_copied   [out]: amount of data for each sub-block
+ * @has_data_loss: [out]: boolean indicating whether data was lost for each sub-block
+ *                        (e.g. due to a ring-buffer overflow)
+ */
+struct drm_amdgpu_spm_buffer_header {
+	__u32 version; /* 0-23: minor 24-31: major */
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[5];
+};
+
 enum drm_amdgpu_profiler_ops {
 	AMDGPU_PROFILER_VERSION = 0,
+	AMDGPU_PROFILER_SPM,
 };
 
 struct drm_amdgpu_profiler_args {
@@ -1711,6 +1800,7 @@ struct drm_amdgpu_profiler_args {
 	                                  * lower 16 bit: minor
 	                                  * higher 16 bit: major
 	                                  */
+	    struct drm_amdgpu_spm_args spm;
 	};
 };
 
-- 
2.34.1

