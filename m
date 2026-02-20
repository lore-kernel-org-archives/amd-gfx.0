Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21199C5AD57
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D7F10E307;
	Fri, 20 Feb 2026 19:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vR7UDLVP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB5410E307
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+MTR0Ag03oysgXSHxVBMLOc7Re7liPbjZzNhx4Oyd0y+NmQlvmuUhQHOjGgEIXG7Gx/KEAyrEghLetr1+glqt506/+7f+4aUZ09YUPrORHKHPI+Deforutm4378GVKEM2gWCCi4c7cRvovyWu+boAyDgraJ7uuvIMb2tPyW/NcYKkxYHUYd6Z5bvyHBiZuufUSvdXeZtF9GyeRVSNW52hblKoiWCQOHtGwk+W1loYFy/Kcw8eVtshEX2LQzo1CZ+Tx8FXw6s0KPkPy0jjN/63O90qpSHjGu6kfInhJOIoUu3ViyKzDfWT2+6wh2pC33UIlW0GNa03R1XSj40xuXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZoejbM8krkK3G96RuRIDM5+KmZ+locTF5rEwKA7R8E=;
 b=VosRMpD3lhZ9zPTnUOB8CxkODye1A6SiT52dfl34bhiyBfPkeRww3da0IkQzA0zm6yNskOnT8ovTGoTHzHv85pauKFNG3/ihgB4AKlLm1uWR5d5wKEKcFVUbl0FzvVCEX/BXLAke7DLKtee6gS3v/u8SMZxR+grg7gnA0J+D1YB/qg9zhPb0G8uE2VhR/tfxeb0a0hMR8s7kdKShVl8MzrcpAyWoQQyCfSYX5TpJW8eK2kqp26PCb7o27XPUXoLit5nvDqEbKZGdq1YWk2fjifakRHFGEDL3B2JdCI9rcxHDtPS6vqhX6x8xNzZSHtDUlDLHrMX4+se/C/XuFRbsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZoejbM8krkK3G96RuRIDM5+KmZ+locTF5rEwKA7R8E=;
 b=vR7UDLVP2H3rcOIbDYxywirNYcpfQhWoQ+1b15UZfonrXrTJaXtjoeo2Kd9G+LFk+jR401Sjb7Gq0+nzxRoViEIKjqNv2uFL3hd2wn8oqz6lA7eyLQimPh+nS9x6fnScpNJzp/HbGinceU72ukR0bDCIiM/BCIgP/QJ6wsLNK7Q=
Received: from PH1PEPF00013311.namprd07.prod.outlook.com (2603:10b6:518:1::c)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 20 Feb
 2026 19:22:53 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013311.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Fri,
 20 Feb 2026 19:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:22:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:51 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 02/17] drm/amdgpu: add UAPI to support profiler/SPM
Date: Fri, 20 Feb 2026 14:22:21 -0500
Message-ID: <20260220192236.3121556-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: c54ce72a-1f48-4cd6-00dd-08de70b571db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BGZc7fIyT2H0GyYwDvEb8nFgNz9Mo72oDNfeyIEwhLBfO5DAqbBtM9g6Mh+p?=
 =?us-ascii?Q?DQKs4/YDEwWgmrbG0kPlYgrCsuzFAgniq/HjrYkJO8u2TLlKoihLTK/5gzDg?=
 =?us-ascii?Q?9dZEkwVrk0zNhAj6mDx6X6UivPD3bIDf8hyLb4asA2eVg4BeWgIXyScAuIYO?=
 =?us-ascii?Q?3wf7LUDcpuQ/eAz1U+b7VZsKsoiUfBDG6W1bTy4A6y097NT/5fWyVVLw+LtJ?=
 =?us-ascii?Q?Q1SdnxRIIoLD95NgTLendMN8P6JDqe2AWdGBINHQ35F9rLj477YqhQJej2U+?=
 =?us-ascii?Q?/xNJvs/4xbnJpmQR+daTyEz/WR1CtbQrlMKLU2ZjLs376zk1qBzWS8H+e73X?=
 =?us-ascii?Q?wHe7OUNT4g1cCXrJA7pB02hMBTiBaFiaqj9/ZIyGhqI96h5JElku16ZHqvHk?=
 =?us-ascii?Q?wdu+XgU8r6rD0F/F8bIO6iO/wnwNOITLhORVy8KdVL+tKfQTd5vjAdSmoPbt?=
 =?us-ascii?Q?Tq8aUMzzqgDrVyGt1aXX2mN6by6KDinWZCrMol+aUeQwoM29MOQeNZZv2POX?=
 =?us-ascii?Q?9oj1CdA1ZO1F8KpF3vZCoZ7vPTGmOzea2Aw6FKfTDpCy0YHhs0joIhENrybf?=
 =?us-ascii?Q?gFycjc96EoJUKGil2X5eCnC769zmS3NwXnzmCaQgRanL0xfFVgVBffylFxr7?=
 =?us-ascii?Q?UVbql3X6PxU0pD3Px4ZLrkfj43eV2TX9oo68P92lQmUlRQwGaUv5MTTrIcPq?=
 =?us-ascii?Q?J7QGqTQEg/sSjFn+/9C/131I39ykx2A0vhARL84YZ5EfjWMpV+Luu9ObWCga?=
 =?us-ascii?Q?K5rhN6//4RKthdiIQ1Ht7JappuX1APgxbNzn/x50xg5EIxlEQuC2VRcEGf82?=
 =?us-ascii?Q?hMS89qIdl6CPeqaE+tNe0sCkz8i0oU3y5KWaef1Ol5xdrcKsrEvHSK3Bm6IY?=
 =?us-ascii?Q?M9u5eBeN2exKkgtRRQIjtAIcAqp8tYUqVkkF4xofXRfP59ChLO3Rwkqv0/Qs?=
 =?us-ascii?Q?pjPEgPxs9Eg5YEYxaXLuhlufFzOCILbzUYvxH7ukly4y5BAWuKV+4FxrEYJh?=
 =?us-ascii?Q?6ZlzS7qqZmseta+fA+g84i3C9N4u673w6clQ2u+hAMTcGBx64E/WXTcMSbB4?=
 =?us-ascii?Q?OUGsHT5bybf/74fvVM2sMie876HbLsMTidy0Rx/benpgkQgDpHQ6rbjRpWBc?=
 =?us-ascii?Q?RrRJfedcoBRGonMmpYUmIHDkuwNePDjnRjxFYBZMmT65QPQ7tE3cGXDY4StH?=
 =?us-ascii?Q?1QrPlLtKup7H9QvIckFkyBzuNUXuenubuUEXP+dBOUNGmhaLSWld3hYCRh00?=
 =?us-ascii?Q?MLDepSzuMUEkEEAi4EzCHoCjhYhZsQKMdkQiUEf/MaVBsLKChlTp3BohXpY/?=
 =?us-ascii?Q?LsRt6q/QrFbD6SGG1QGifHv1pfe+iStVKHxfZir3kDgIDUTI2q6HrKrxySWN?=
 =?us-ascii?Q?qkv2BcTemKxClv1QNjNsfiCcnhCqOAb83uGIkXQEexTIJ4I1qSehkvDMyBVK?=
 =?us-ascii?Q?qvXDKqCX4u+KTZ2o+XY2GYXtnIsUz2AIKVRAR2Oan81dAMOyXbHyqtZEGx2C?=
 =?us-ascii?Q?eiZGtoN2G+IaoteqtW3hCxdSqwOIbLlyPOLtbMNkDlliIsVg50Gi7XnO+aXU?=
 =?us-ascii?Q?z0nRXC72YdRafm9JFavL2CI+qpbE9mMGLe2uFkSU95/bw0UCSruxWY4Gw0pg?=
 =?us-ascii?Q?kykTx3rWKEv7Z/fw37pq8TFl5qPqunIQcWBrK+PE7vWJDMBQN6YDSZGQ9nyJ?=
 =?us-ascii?Q?hiFAeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jfV3ZDriR0XWY/DbjTFs/9XtzzEvdlftT8LPm65kRydcQ4pJCqIv/0624WTTCKCLq4x0Lyvo+aM65NQRWpyMfSf/TDcUsOHWbJdnhuhwFLQT5/atgZBFIdxLzzhNcuoxtsiaGW2LU42Tk62Fg4D0ZR9XtoFPD1Rvum+d8VSNb4xeTtAY4XIY6efbl/zlScN3GWBobxeW2yBtM6aOvop6yIh1RiniNwmWIGtW2ztNmHyQ+Gu4Vu59MOwWqcryDauM0YyBHAqVDz1eG2PcJqJMl8NuyNEXjXMsc+08XeZ3TL/lu9g4ZqVHFiAwsXYuxEZTU0LEy6en4iTR2QXtqSETMHm0yvlG4gfkKBbjlC1KVxrp7yeLXA6XVQsh8NVgkCK/eAnF8DgtwA0X4f4pgneEidCTeUHheeVEKnpvWGJUSv585M3HMWRPb90pqukTd3S9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:22:53.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54ce72a-1f48-4cd6-00dd-08de70b571db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9
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

which does stream performance monitoring.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 93 +++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index dfc98d6d98a8..83f116d61df9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1710,17 +1710,110 @@ struct drm_color_ctm_3x4 {
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
 /*
  * Supported Profiler Operations
  */
 enum drm_amdgpu_profiler_ops {
 	AMDGPU_PROFILER_VERSION = 0,
+	AMDGPU_PROFILER_SPM,
 };
 
 struct drm_amdgpu_profiler_args {
 	__u32 op;				/* amdgpu_profiler_op */
 	union {
 		__u32 version;		/* lower 16 bit: minor. higher 16 bit: major */
+		struct drm_amdgpu_spm_args spm;
 	};
 };
 
-- 
2.34.1

