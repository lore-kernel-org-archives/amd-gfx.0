Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B87FEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4CA10E17A;
	Tue, 24 Mar 2026 21:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1HtXr+9v";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F3610E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8xWW8y7nfaebZLEhIzTJJ/a8nBLunwKtF8zhFYYsHhrn9vM+YhYkuVXAbrG+MQAYvOnFolyiKSUUl1KuwqKkVLHxNuHdnRxJqrFrqmFjUhrwlLrCtJ3yJzgHyGzGwrLOxIabY+kCqAJEhzRoa/ClAuljCL4jqb48EL39eeOLSc8eBcG2KQDkm6pD6Ow1LJqgZ98GD8fR48uStnbEux9zXm0Z2nShvFyOB4tc3+kMmEcj52hOSW25kCp33psJYTc12Jam5TXwFghgeRC/Ggt4T0E8ipggWFYAVXYdfc/kh8b9qUSd6UH61q/Dw6xlaPN963mT1l7PSMwukj1Rus8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDviCmnikajIkbRXBEqf+mF4EJlLQ+wyzCJOLjKYhxE=;
 b=PpjlwP//YpjA+7i6Z5WLdKl/wJNDePDfOpf5SI7hjjPfgQHZFG2JYlVF+skh5h+NCb9Z/MPRHbaghmAD7RuCkXSh6drx4ehQaIz7LKePczPY70cAOfRmWTMILycyg7Yn03sYjaQZa+m4Q04NwLODdIxr1is68hm/fD8E4Y+OE4rA2v8ufIL1TtSRvqGT/vNjiCj6X+acR7wcRx3HjFSlLdrcHPzb7cRirJBXzFjNAQ830Jx5CpXz6V5Oxo3SuFmz6N/MQl3NWXQ6rdZvuRFK/DJfdKINJirEZZsSumSP6lber4kGmkga6O/6SNe7JEF0j2lPCwwGMn4gML69q+sA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDviCmnikajIkbRXBEqf+mF4EJlLQ+wyzCJOLjKYhxE=;
 b=1HtXr+9vDZY/OfsQ+Cl8xYFOohtLmhYZU+4JENKm5+6F63Ku/2Gr+S8iIq65rEP+pQnHbAgi7V6p/NJnTQ5a1rF0PBV6riOOh+iPlbNkctMp2BoaWn1Co8OCvm+iymSG3CK19jKph1ARn4DGltGMc37LD3S5HmRWZ3xo6s6DZ8k=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:52 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::7a) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:48 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:42 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 04/17] drm/amdgpu: add UAPI to support profiler/SPM
Date: Tue, 24 Mar 2026 17:20:17 -0400
Message-ID: <20260324212030.822932-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 509c31c7-2f23-453c-83a1-08de89eb383a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WIkzDjsYaxnfZLg/kNI48f+iNwsDOXzr3kaR5/EUnBwYjhmlSlu77iAuyGqtVIbjH+mBLcqvEP0svYY7zu3mNLwiozkOExstMjK2zQoJhMf4c47jk0Fu5+scx+BpaPCfAX+JjkN3US3QDJmWZ3jnu0WNrmEVNsSibwwPtF3X9OlR8z8rS8zseuxT2NyWiWZXp7UNqmQbJMv5zTC3hpu2uzVb7G4+lyKt7garzOfj7fIUJnQTH/7I2XC/2V4jtkXjr9Maksaxhf46wvbFP6KMYfFWNaxTikpIdEI/QGFVf1xFoCWdJQxcITo7zXdzfQkhtq0PM35rt/g1EI0F1ATGrT3hQDx+BnXByZX0Yi7gHnruB1MdLGBuupmCU6MnCztnvixwz+S+LSCfHDJ9qEwQhGdRVW48gsFeZZ9MwsK4COGcxIf7XL4PzUReKCDmV9vgDDHQQF4qFaStX23uAQU0fVTvjkdqxA+Pg730CSGD3HAZjOQUa7m0iQtYJXOmbKrde6iEVWSL5tM2owRZ3yq70WiwtT10M3jnCbQt6MC7h7JXyg/hyZikUw7tQeado+0BqKSHG53jThAw9DWDHZbt91/cxXc1pCRx6Sr759r+J3R7Sn4v9rOAoLxQlD8mP0fPxBLqtjDdRhdja3M4c5Gqsx5ss6so82Tz1NqvwrmceBaWeqM4mYsg9IWotqkR+2Y0kc6TeW7VtiuxK9BeW/F+V4geEgrdVn3a56xDikmfIpoTIalNNmg3o9dfBvwofqtUplbw4Jq6zIb1skEOPzefog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O3yq7SmFayhYzhGiA/ymO07Y8ivziz3lK69XJBLghIPAdOyzAiB+sQog0Mk4u4rRHYtApqe2oIh2h4i8zIavGCfoqhScFW4xgwXcLsveIikglZ2kts+LZRzgYmVd6GL3CNp7FYDLElJZgXv3UZe3cmvzF+t9GN8YsdRhgd5IuuRns1L9AElA27GA5sJmYnZyx1hk6qMC5rgVeiGo/hBizpWxsIf1TOX9LCnsDWSw3U5KoRuOY07m+fi8+of3CnpzbP+7m058nqt0rorNsUThsP6ne8TcqUNnwutQzcOZ4v4mdqV4QTss6SZ2aPv7Gl9AOLZEgt2hd+J0U/O5nhh7hth+nIW4sLiq4b3ipRiIdmLWSCvzFG129CQfU7MLDU0KYIztzZqrGOjd1VuVLlF4ZB8FOV4Kx8z5i0/OCZuDEA9LnSbM+Ih7r7TO9ZfClfzL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:48.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509c31c7-2f23-453c-83a1-08de89eb383a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
---
 include/uapi/drm/amdgpu_drm.h | 93 +++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2f9a5ddfe658..fc27938313d7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1797,11 +1797,103 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
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
@@ -1809,6 +1901,7 @@ struct drm_amdgpu_profiler_args {
 	__u32 pad;
 	union {
 		__u32 version;		/* lower 16 bit: minor. higher 16 bit: major */
+		struct drm_amdgpu_spm_args spm;
 	};
 };
 
-- 
2.34.1

