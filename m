Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A946CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5A910E671;
	Tue, 26 May 2026 14:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqkSbIdu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB6610E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJUERaeJpWBPXS+1zM1wJ+lWr05vW642RF/ZXxELmryHkpWNMIrB2HXq6C5DzfLLthkccBAS4XSWadPgmkRneB/tKZBVCz3seTuOwB8Khsk8DyxMPG860SEApPzuymumPhAlQlEFWkWsgpMjXcxQptHDgMPhcphuCAHpf2DoMIglwjwJWxFwmx7wS9Ty24rad4NujTdoCzJmqpsIhDMUtH62VihpvyOYgxWWqWyv+JNOaw0ZSxLNfaXT2I42uhZIRnTGCbbvpUZX8/ExqlnaXg/04DP0x1/TgBqwllQHN6UjNwq/KxE+oTh2uoI+7UFfplOFRWXhlVtSKEUL4WXpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2Zw/EMlbvTBX6GSv0H1QHsJme23lSHqx6C0L/HDvWs=;
 b=ljMZKsZE5G1u101auvyFEiuxLBUxP4hSijRHzkn9PQbD3yupChSxiRhvX7C2Q/8GRQgFHnslFpz8kOLEc6FmW5ikKnwN/UeO4YEBgiN5snXx0nkapyqtSg3gbkOGAiMtn8SOx9zfMN/0Sv0Di9mPib0SxrVP99oKAkBofPgllnPLsrvYTIaScTt5PrN7cAhy7b7+r/mvyFJH9r128GypqN53ymHeXCoMM5R4993VN26l5mBDn1H8tFLeF7j0/En7NANj+OVDHx2Rkk4GMIkpxRwJ/UMYNspvChTOubQo/acF2EjYdNBsrs6MhmIzCXRrvSLviBskGgSTJ263FFExGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2Zw/EMlbvTBX6GSv0H1QHsJme23lSHqx6C0L/HDvWs=;
 b=ZqkSbIdux3IclFiG1oQQKNyKM+pJKTuW70Ckoyo7ncFrPFCg81NC0sSqEz93n7Yry+e4KZbzd6QhmyuBrvv3XK5QE+7EZL9UUs4lCy7lFckw7W79qUJlwpkRCkIQxB6ekL/FMw5drg5tqcWkEV9O48PtcP5yUItMFYS34SV8KXE=
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:11:55 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::82) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:54 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:51 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 04/17] drm/amdgpu: add UAPI to support profiler/SPM
Date: Tue, 26 May 2026 10:11:16 -0400
Message-ID: <20260526141129.592886-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ab869e-3bf1-47cb-023e-08debb30bdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0KhA4AghrqIoYyd1+E2RoMj0RiolGTxTDgbC0Z7eWL+sawM9SJuMu14tkJWDjPLNZ0nRqTx6abR5TIehTdrG3qVtUtoZzX95DK7erGTIZ0c78EJ34lnUBqpKt672zp60uLs4FIoD7u+/UwmgUnCew2/d1sK48lX5voUE6DyjhI7uHxoMTVRys2uz6fGuCkhPnNmcFdZQtl4IncwjdrTLOtPb7O/9lpaOQvStakdiwnVSyritghXYFwjQoWpN8runxO6zhtjBoLJ6icG/a+BHH7hxvRua+LYxe1OfBAI09aJBnf3x15p4U4WNB/odng4F/5Awk/vmVw9Nwjn0vX1rRczX3WbU5upwSCZt2Bbpaq2rScA0EO96H7Qlr+c6zMihSPkWNwU4ueSUeJK3/MndBjVoBuXi4Vaj5ERcaBFAktsRiGvtaTDU8W4wZ/4s9A+nK89pswhA8kXk7fi4qQJDezwIneNpnTufhyrcUIBw/EMCUvUGJbRho7y/q3ZHEVRLb6PLc8cskqVM2XsF3UCg5MDexseTzxxWAfvM1Qmg5WVzhYBv27z532bBrcciul5WA2JbgSHsm90LI0ccNcw8t48BuTxHrCjwqAo9KbeGaFU1jrVRKF0dntPaxFYN0jekR8pY8sIWzeFJ0BVM6mR6OewHNxZI6mP9T4ZlCbfPJDaCvHCnbQz1Y4IN/6LgpMpzOtHsDFoQ3rFVzRI8GhEBx5YkKR1yvNr3U4Sry/B6v1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ExaGInRseWlsrp4Ni8ec27EpnmrOlN1FreDMg0jZJtiGX2XLw0+uA1hgK5TrDG+ZRxQlwxDBzMxAFuXH07JozgqEKD1PhipABNTYSO7LYuPwj9DyjXm9O6+AXNWTZqgwQDwD2mCCpoBItCWH24RU2Hw1yucdxOwjeRj69nszgDtJJPZpkrZmtgDHeZyiAtuoF61Q/HjczqENkz8YbbHbjp57HCv5WNyvPwmISv9ecFEEhT7e/pIabRE6xPUfB9tTEJ62JZHaQ1TqOJhXuo+owMRH5iCUEPD8Uj3HeeAR0psC5ErPA5U6sNeykS7csd4ybYQI69ejXFtIu+9FpJgTMGPnjD5gdUhzhu/8+IYrPYSphmv9xDUtp3+rxedYOK0Wms0DHgUqgjPd9mDE9+uhfydLwlM7AxsJ7WPRjUr0oHay3vf59jmG6RLoDvlzCCA6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:54.8932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ab869e-3bf1-47cb-023e-08debb30bdbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

to extend the DRM_AMDGPU_PROFILER ioctl to support Stream Performance
Monitor (SPM) hardware, which streams GPU performance counter data
continuously into a ring buffer for offline analysis.

A new operation AMDGPU_PROFILER_SPM is added to drm_amdgpu_profiler_ops,
dispatching through the existing drm_amdgpu_profiler_args union via the
new drm_amdgpu_spm_args member.

Three SPM sub-operations are defined in drm_amdgpu_spm_op:
  AMDGPU_SPM_OP_ACQUIRE (0):
    Acquires exclusive access to SPM on the caller's XCP partition.
    Must be called before SET_DEST_BUF. Returns -EBUSY if another
    process already holds SPM.

  AMDGPU_SPM_OP_RELEASE (1):
    Releases exclusive SPM access, stopping the hardware and freeing
    the ring buffer, allowing another process to acquire SPM.

  AMDGPU_SPM_OP_SET_DEST_BUF (2):
    Controls the destination buffer for SPM counter streaming:
    - dest_buf=NULL: unsets the destination buffer and stops copying.
    - dest_buf!=NULL: sets a new user-space destination buffer of
      buf_size bytes. If timeout>0, the call blocks up to timeout ms
      waiting for the previous buffer to be filled; on return, timeout
      is updated with the remaining time. If timeout expires, any
      partial data is flushed and the call returns success. If timeout=0,
      the previous buffer is replaced immediately without waiting.
      bytes_copied reports how much data was written to the previous
      buffer. has_data_loss is non-zero if ring buffer overflow occurred.

A drm_amdgpu_spm_buffer_header structure is prepended to each dest_buf
by the kernel, containing the SPM version (major in bits 31:24, minor
in bits 23:0), bytes_copied, and has_data_loss for that buffer.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 94 +++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index e66e190b5865..4004cb973fac 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1791,11 +1791,104 @@ union drm_amdgpu_cwsr {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+
+/*
+ * Supported SPM (Stream Performance Monitor) Operations
+ */
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
+ *                      in @AMDGPU_SPM_OP_SET_DEST_BUF
+ * @buf_size[in]:      size of the destination buffer
+ * @timeout[in/out]:   [in]: timeout in milliseconds, [out]: amount of time left
+ *                      in the timeout window
+ * @bytes_copied[out]: total amount of data that was copied to the previous dest_buf
+ * @has_data_loss:     non-zero if data was lost (e.g. due to ring buffer overflow),
+ *                      zero otherwise
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
 /*
  * Supported Profiler Operations
  */
 enum drm_amdgpu_profiler_ops {
 	AMDGPU_PROFILER_VERSION = 0,
+	AMDGPU_PROFILER_SPM,
 };
 
 struct drm_amdgpu_profiler_args {
@@ -1803,6 +1896,7 @@ struct drm_amdgpu_profiler_args {
 	__u32 pad;
 	union {
 		__u32 version;		/* lower 16 bit: minor. higher 16 bit: major */
+		struct drm_amdgpu_spm_args spm;
 	};
 };
 
-- 
2.34.1

