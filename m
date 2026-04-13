Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A1BF531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 19:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE81310E522;
	Mon, 13 Apr 2026 19:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2wCxTmT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB5F10E522
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 19:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1LeHJ8WcDe07mN6t+ycR5R4a02TZm8RO3UtZvtoqSuJw4p+EE/wPfB97LInYXCLHqsi1eaVXfvFjKQHKopIkbuIOVX0EFeGhKaBTB5tH4F1YTJIi+sP25LMlnWXNx2HCDoaVKIDfNCWR+4BQJWz83vK0jkYyX3uJQ/FEkXHE6bOJs/BTAEybEaOMsWEvukrCR8sfcKNX2mVXaXIcSFqSqmdCjChcCCgImi0J+709beXKni8LhaxvagB7cf3noklPjc5NHkv37eMN9cvzw896UOIgGnUbX6Ndde+LCj4xEHt/BWX54KJAwp3V3MvZg/vTonrPkA8O5MxKzbaNeLQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWdR4459hCZNs0IMXwtNg4hbZgV9bfdqiaolmekgl3A=;
 b=TTJsnXny6JiMeQ9rRnTw6IMSSmRvM8OFgt+Weate2vaindu9WwolKKEhnp+hS7L5LV21wMetEeGQOa3ehN6/o+OmxUm4B1vRVQLz2xAfNl6vVaSNhXxGl5qRFOc+EEfFCs5bAWnQtF7j2dSSQFkvouVAmL8iEffDlsk2fyNeVh4GSfAQJ0G9rxi2EX0Ze8G6Ed3IMpBCIfZDNWadRYcOScJDrkGz7TX88pbDJUuMg/Arm48Es19npUkYyvAuQmEZSFaSYKb2BG7KXnYFasS9O0+JaphMEkdfsTuHe0xsSDpmYQyGJ6gcjgCyKl3yF7prrQND831AOjNr0DaqirrkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWdR4459hCZNs0IMXwtNg4hbZgV9bfdqiaolmekgl3A=;
 b=R2wCxTmTWixx9lx4HzTw4EFBfbtJHxY+UQXDqfcqBOIDkUVt2sT6hH/EMvL7r3KQXieH5HYQAxmi/+epswXplqUReB5hsIEAodFQZVyhY1zOD1uwathJijSCKij5COHY+e93ZEGER6DCrP0jAaQAOatwEUcW7/zRBfs4Pj4UlMY=
Received: from DS7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::13) by
 DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Mon, 13 Apr 2026 19:29:58 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::c1) by DS7P222CA0024.outlook.office365.com
 (2603:10b6:8:2e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 19:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 19:29:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 14:29:57 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH 2/2] amdgpu: Add Streaming Performance Monitor (SPM) data
 collection interface
Date: Mon, 13 Apr 2026 15:29:47 -0400
Message-ID: <20260413192947.3145878-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413192947.3145878-1-James.Zhu@amd.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 280c0aba-0fab-40bf-a41a-08de99930c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HwLGtRZKCLJN2cmkUMPdPItepgYo9l/RO04bxA2RUXFb3JOiuI/SfePbQNIiLtKvetFFlO0u3/Lz3MtgJF4zLiQdp/ITgBfR+fWFB/wL/BMXX6vtdwYC/TrM+osa+LpkmT4y3rymDyYaVa3Tc2QgaOL9a6Kf4mucMdTitIvBQpdjKXSRrypyGEgLL2I6BSn783NcO5dSv+2CI86oKpekX+7ReLGSZyFeb5EVuw+t2eeS83yocK42iyiU1dnjMnL6l6RwBUvOMJ7QzjENSABax5nilm//hWDD3JoXKbpeGud5MTkMRB7oQyz9xd4nmqohIUNQIQ8TFaJOspAKlk2Trq+EJvyhU/p+Mi6jODOzc9pd6inOZnWFiNCLGHR2oz3aR1K1NJwg2Vi8Yumktw4uj+xB2vRIfWwYf10VmQzAMLdp1AnsWDVs1lDpq06XKmPkQWm82fLVw6WHyyJiCRCntPoyGwmvaJoWmBCNfwoibBj7ECLv47vRPGow3KCcEO0giL/MwyJY7dltR3EitOO3JqfLrU0CmiEHaJGqLcRJXqCWvWp2kt2dS5llpYzbrwKK0ETN2/zShYt7UySah1yLAXccwrb8u4F4cXebraIOGXunZpwoiTTKOsSfcO2KVzsezgEoJ3EYtt9I69GoJDquPxbaJn8cKMqIVlWg0DQvFfJCo4bxjlF1N4vX0HNUMMHpZqG4fAq373nnsh0mW8LvFwBxelRKSlSGqgpDFdlIb9CQ6+3LFIcLLvkGc0fmXharO2nJU9vQGDSbH5oskEsQWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c7NFTvrLr0dBa3BnoRalPVfn35yDtC2oQK+GzxENuCKKaWjiopXHMYbr6iqehx5utT0DNRrQkMy/40aIlCc4zNnODAr4LCkI2qk2hVh4toJVsbDh4FOpRz5KqVBAJ7YfTIxRvD6unDTl1z6yF1Tk1Zvb4bwvuONp6NeeBM7ggwN5vguDW8Op+j81A20d89YMNqksVHZMHe2jF1o3H9Js4O7utCc+fi4CZkvZmg866XLQ8x0vY/aaVQBqZ7QgOaSieyA8GdTb2GWRpHUm2xQuVd20eeSwtavAVWCAYT2SNuHwBI8E4Z5PdJzUZFnBBGo7FF8OPmAdaRCmeCYX82CKPqVdtEEMwlulkKOIzTwqZu3aOMFv4vU9+g0bmlae8COIrQokubxx0rvFYot6/JMfwthdaoP/RTjIYFsdKWnaV4W+YcUWkGqKprOWu4qP6MSt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:29:58.0210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280c0aba-0fab-40bf-a41a-08de99930c6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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
---
 amdgpu/amdgpu-symbols.txt |  3 ++
 amdgpu/amdgpu.h           | 38 ++++++++++++++++
 amdgpu/amdgpu_profiler.c  | 68 +++++++++++++++++++++++++++++
 include/drm/amdgpu_drm.h  | 92 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu-symbols.txt b/amdgpu/amdgpu-symbols.txt
index 8cd5559c..b33958ef 100644
--- a/amdgpu/amdgpu-symbols.txt
+++ b/amdgpu/amdgpu-symbols.txt
@@ -88,3 +88,6 @@ amdgpu_create_userqueue
 amdgpu_free_userqueue
 amdgpu_userq_signal
 amdgpu_userq_wait
+amdgpu_spm_acquire
+amdgpu_spm_release
+amdgpu_spm_setdestbuff
diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 4ec1f6b6..8698f26a 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2129,7 +2129,45 @@ int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
  */
 int amdgpu_profiler_version(amdgpu_device_handle dev);
 
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
index 8d4dffe4..e9d30fb6 100644
--- a/amdgpu/amdgpu_profiler.c
+++ b/amdgpu/amdgpu_profiler.c
@@ -44,3 +44,71 @@ amdgpu_profiler_version(amdgpu_device_handle dev)
 
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

