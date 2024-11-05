Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772F0D36108
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 19:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD9810E5FE;
	Tue,  5 Nov 2024 19:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YOVhFggG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A0410E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 19:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwXed6URk62ivW0XELCAR+baCZLUJBK6ngGL2sg0rhT0vQShW6kpeylm8D2qU9qJOr/2F4Mo7TYAIKUItL9rTkzDjtjv/57EonwMKTC2xiF8JPD2BNjccBeZeFlBoE0TvpBEdU8xBjMquy1HdEgl6cS7OynvQUXJvgRMafHXNgyRH7PsfkwjlyKP8raQ0UXFmeDFM0TRKG31wPtcZcC7CCIMidhHAdK4KPnROy74bF8tzKYVVVJ8BkB57pOBDKpLZuukZLJWOcaBCxNn4aG/AaGlLhTV48E03GJG+xX6wlRu0mO56cfTL5ih1s1s0JkOE9//LEszeUPhsgPAq9awGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMCcYgPt2JBdfp3eUHjUJCmyTRCPdNzMYm+1JLNcZU8=;
 b=c9U7U7vcNf28S7lpjGGlVN/2xM0DzEI2YUML5wRJ7YWP5soN1QEOS+1wVCtZ0x3bBim5AWDIgw6FdWB6fMXwhMvcCEcBMmG/nX9JjkxU2yXQIYmC+zHuY98zZQH3ZlVJ6k7EOBHuXfYUTVKYH9yIXc2SEU56zQXTEAfvFdNaaH339/l55Qr7hbbjsTszFCdvcm9cZ+rckRiqMoX7NKBU7eKtwLOsho0ZZ1QVjYcb30mhjogOsPHaLb5JGNBw0+Sne8Ufv0jJMxPcEh1sRLVAbUBWH3TIaTdTvVIHOV/z6QvuTGOhwlJjqlgLJiwf+Vm8F1o16LWwxzzrQEVgjZHH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMCcYgPt2JBdfp3eUHjUJCmyTRCPdNzMYm+1JLNcZU8=;
 b=YOVhFggG1l7LhdAhNFODCCOUkEQA412l9/reMhGhzjesaoKxRJxMlE/4HaG/3oSa8XRTI+LSQhPSUy4NW/zdgkbFRm83z3NI60DrAbXKneptWNB7Zf4KO7iLi30LltilxOomV50unsjHihwX10Nwwf3xREwoZ4kbgT0ZCgfOIKQ=
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:04:47 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::5b) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 19:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 19:04:46 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 13:04:45 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <zhigang.luo@amd.com>, <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Update SRIOV Exchange Headers for RAS
 Telemetry Support
Date: Tue, 5 Nov 2024 14:04:26 -0500
Message-ID: <20241105190429.323478-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 51371f51-e705-45a5-3c59-08dcfdccb72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHtiamjbM7qGdXaRirKm9adDzUjRFGTaMZn/6svFnI801I5ymSwIXttenScf?=
 =?us-ascii?Q?BYm37RBPgUmUEqANhTFAJCq0uD7wdjZy2CSCCnipCL+XbXJbN71X3NLqJseD?=
 =?us-ascii?Q?F9d75o0lxfGMjIZLV/CPltgjdjdYqYkkiowJKRpt4P0ZUaf7ZH3oTUPdx5jj?=
 =?us-ascii?Q?k3ZIJNK4HV/j8bql0bP5lXpZCVW0T//QIRu6+DYzKWDCbVF+PyMZqunjkxGi?=
 =?us-ascii?Q?VUtghxrUq4Bz2xCBewImehSA2Hmmm52GYLNRDbPRuS3eoBUsE7rIxMXj+Y77?=
 =?us-ascii?Q?2kN2pPKszHJzXf/dfx0ocHDfxCp5ZbexSlRLZPf3uhUhxPxLYQEqHA3xja8T?=
 =?us-ascii?Q?HNZ8+07d8mi8nqdXxRmTeJ4Pa2HOmpAbKNTXfzRkpP33jFK/puH6YEOZVgKo?=
 =?us-ascii?Q?/8TzhfZK8+sJy2mBrmckSCxFMczs/kr6oimmSYyDZCg6YpCtBUClrXb6Hqa+?=
 =?us-ascii?Q?vqh2ALCtyrLDRdkV0hHkEw/GKhdMHlw01LNWrlEzr/cf7VdD8Z2NA6PwHoIa?=
 =?us-ascii?Q?LHEuTUmV2fIIyqcFuy9yGp6/y3CP5qcH8AicP7J460Vqd+rG75jQlVMGi+HK?=
 =?us-ascii?Q?1zscyGUfP/BIDIApACmPy9O/7mreOtJUP9d5Ej8ekQoIcmGKApm3JA3nELxr?=
 =?us-ascii?Q?RaBPaN+UMXOnphEXFGtwtu908dIHGPh+1uJfqt14iG3jeUH4bK5OE5UUO8yy?=
 =?us-ascii?Q?OY837OUq7I8zJTkHGlEmaNdSBCbse/DH65s5tkStUm3yx1Z8Xdx2v1E4qrwE?=
 =?us-ascii?Q?+enpscAw43jeZ+to0FYzRtY/5jvWqSzFjOsEHt/rYoeDw+O10GeVQNIAlTLf?=
 =?us-ascii?Q?9X+VWn5eTZYDopHeZHU6ZonrVLVCV3xU0o5Nf2Jgl2eqWSiTU5TURsVtn5ky?=
 =?us-ascii?Q?CcdNWWWQi+bFZTFWipxRLr+yIbmjnYP49HaCpGJ/fwiAgllMHzfteUfYR09s?=
 =?us-ascii?Q?ZJxSuX8f99zJRlbg+WllPEGc7Mbq93kjdxBw+NkyS07yK9Ui7oONTiqxZy49?=
 =?us-ascii?Q?/t6PJp0z8eid4FXstIsQqKVlNsAj4Bh70EKBKdH6ns/7imfiscS+gmx5lQ0I?=
 =?us-ascii?Q?QJS44LEEWHuSDkwysv7TPWexPOC0DzbQZrnPQd7qyoQzpLcqJ5OjyMtBZO+Y?=
 =?us-ascii?Q?vFD8jVb+YqCRK7BCAN5dZ0itdBKqq+e5ENTzAbLZ2wJGoTyrmC0dR0GYMDeP?=
 =?us-ascii?Q?XUhJT62ejhYQ/UkwiSDDGTt+FxkYVGNbt/4kiLQSyU/GrBTwDBZx9V9z8zIs?=
 =?us-ascii?Q?jbxffqNqv3Me6dLW6T/i+QkBhMYqiskvspgT5hjGik2R8owNCOY5+nRZTt/l?=
 =?us-ascii?Q?JClq9xO8q1eHJJBQQceChK7RP+B2sAo48MwFrgMmBpOkJsxdL9kmVe3xBAzC?=
 =?us-ascii?Q?i2X0AdND+tczv/65fr3umwfRgE70+jw4MOPcDrKAc76XawJBKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:04:46.7140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51371f51-e705-45a5-3c59-08dcfdccb72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

The SRIOV PF/VF Data exchange is extended by 64KB for VF RAS Telemetry data.
Add Host RAS Telemetry enable capabilities bitfields.
Add a new VF msg REQ_RAS_ERROR_COUNT, the host response data will be populated
in the RAS Telemetry region.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 131 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       |   2 +
 2 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 6e9eeaeb3de1..b4f9c2f4e92c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -28,17 +28,21 @@
 #define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
 #define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
 #define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
-
+#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
+#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
+#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
 /*
  * layout
- * 0           64KB        65KB        66KB
- * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | ...
- * |   64KB    |   1KB     |   1KB     |
+ * 0           64KB        65KB        66KB           68KB                   132KB
+ * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
+ * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
  */
+
 #define AMD_SRIOV_MSG_SIZE_KB                   1
 #define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
 #define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
 #define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
 
 /*
  * PF2VF history log:
@@ -86,30 +90,59 @@ enum amd_sriov_ucode_engine_id {
 
 union amd_sriov_msg_feature_flags {
 	struct {
-		uint32_t error_log_collect : 1;
-		uint32_t host_load_ucodes  : 1;
-		uint32_t host_flr_vramlost : 1;
-		uint32_t mm_bw_management  : 1;
-		uint32_t pp_one_vf_mode    : 1;
-		uint32_t reg_indirect_acc  : 1;
-		uint32_t av1_support       : 1;
-		uint32_t vcn_rb_decouple   : 1;
-		uint32_t mes_info_enable   : 1;
-		uint32_t reserved          : 23;
+		uint32_t error_log_collect	: 1;
+		uint32_t host_load_ucodes	: 1;
+		uint32_t host_flr_vramlost	: 1;
+		uint32_t mm_bw_management	: 1;
+		uint32_t pp_one_vf_mode		: 1;
+		uint32_t reg_indirect_acc	: 1;
+		uint32_t av1_support		: 1;
+		uint32_t vcn_rb_decouple 	: 1;
+		uint32_t mes_info_dump_enable	: 1;
+		uint32_t ras_caps		: 1;
+		uint32_t ras_telemetry		: 1;
+		uint32_t reserved		: 21;
 	} flags;
 	uint32_t all;
 };
 
 union amd_sriov_reg_access_flags {
 	struct {
-		uint32_t vf_reg_access_ih 	 : 1;
-		uint32_t vf_reg_access_mmhub : 1;
-		uint32_t vf_reg_access_gc 	 : 1;
-		uint32_t reserved	         : 29;
+		uint32_t vf_reg_access_ih	: 1;
+		uint32_t vf_reg_access_mmhub	: 1;
+		uint32_t vf_reg_access_gc	: 1;
+		uint32_t reserved		: 29;
 	} flags;
 	uint32_t all;
 };
 
+union amd_sriov_ras_caps {
+	struct {
+		uint64_t block_umc			: 1;
+		uint64_t block_sdma			: 1;
+		uint64_t block_gfx			: 1;
+		uint64_t block_mmhub			: 1;
+		uint64_t block_athub			: 1;
+		uint64_t block_pcie_bif			: 1;
+		uint64_t block_hdp			: 1;
+		uint64_t block_xgmi_wafl		: 1;
+		uint64_t block_df			: 1;
+		uint64_t block_smn			: 1;
+		uint64_t block_sem			: 1;
+		uint64_t block_mp0			: 1;
+		uint64_t block_mp1			: 1;
+		uint64_t block_fuse			: 1;
+		uint64_t block_mca			: 1;
+		uint64_t block_vcn			: 1;
+		uint64_t block_jpeg			: 1;
+		uint64_t block_ih			: 1;
+		uint64_t block_mpio			: 1;
+		uint64_t poison_propogation_mode	: 1;
+		uint64_t reserved			: 44;
+	} bits;
+	uint64_t all;
+};
+
 union amd_sriov_msg_os_info {
 	struct {
 		uint32_t windows  : 1;
@@ -158,7 +191,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
-#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (49)
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (55)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -211,6 +244,12 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t pcie_atomic_ops_support_flags;
 	/* Portion of GPU memory occupied by VF.  MAX value is 65535, but set to uint32_t to maintain alignment with reserved size */
 	uint32_t gpu_capacity;
+	/* vf bdf on host pci tree for debug only */
+	uint32_t bdf_on_host;
+	uint32_t more_bp;	//Reserved for future use.
+	union amd_sriov_ras_caps ras_en_caps;
+	union amd_sriov_ras_caps ras_telemetry_en_caps;
+
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 } __packed;
@@ -283,8 +322,12 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_REL_GPU_FINI_ACCESS,
 	MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
 	MB_REQ_MSG_REQ_GPU_INIT_DATA,
+	MB_REQ_MSG_PSP_VF_CMD_RELAY,
 
 	MB_REQ_MSG_LOG_VF_ERROR = 200,
+	MB_REQ_MSG_READY_TO_RESET = 201,
+	MB_REQ_MSG_RAS_POISON = 202,
+	MB_REQ_RAS_ERROR_COUNT = 203,
 };
 
 /* mailbox message send from host to guest  */
@@ -297,10 +340,60 @@ enum amd_sriov_mailbox_response_message {
 	MB_RES_MSG_FAIL,
 	MB_RES_MSG_QUERY_ALIVE,
 	MB_RES_MSG_GPU_INIT_DATA_READY,
+	MB_RES_MSG_RAS_ERROR_COUNT_READY = 11,
 
 	MB_RES_MSG_TEXT_MESSAGE = 255
 };
 
+enum amd_sriov_ras_telemetry_gpu_block {
+	RAS_TELEMETRY_GPU_BLOCK_UMC		= 0,
+	RAS_TELEMETRY_GPU_BLOCK_SDMA		= 1,
+	RAS_TELEMETRY_GPU_BLOCK_GFX		= 2,
+	RAS_TELEMETRY_GPU_BLOCK_MMHUB		= 3,
+	RAS_TELEMETRY_GPU_BLOCK_ATHUB		= 4,
+	RAS_TELEMETRY_GPU_BLOCK_PCIE_BIF	= 5,
+	RAS_TELEMETRY_GPU_BLOCK_HDP		= 6,
+	RAS_TELEMETRY_GPU_BLOCK_XGMI_WAFL	= 7,
+	RAS_TELEMETRY_GPU_BLOCK_DF		= 8,
+	RAS_TELEMETRY_GPU_BLOCK_SMN		= 9,
+	RAS_TELEMETRY_GPU_BLOCK_SEM		= 10,
+	RAS_TELEMETRY_GPU_BLOCK_MP0		= 11,
+	RAS_TELEMETRY_GPU_BLOCK_MP1		= 12,
+	RAS_TELEMETRY_GPU_BLOCK_FUSE		= 13,
+	RAS_TELEMETRY_GPU_BLOCK_MCA		= 14,
+	RAS_TELEMETRY_GPU_BLOCK_VCN		= 15,
+	RAS_TELEMETRY_GPU_BLOCK_JPEG		= 16,
+	RAS_TELEMETRY_GPU_BLOCK_IH		= 17,
+	RAS_TELEMETRY_GPU_BLOCK_MPIO		= 18,
+	RAS_TELEMETRY_GPU_BLOCK_COUNT		= 19,
+};
+
+struct amd_sriov_ras_telemetry_header {
+	uint32_t checksum;
+	uint32_t used_size;
+	uint32_t reserved[2];
+};
+
+struct amd_sriov_ras_telemetry_error_count {
+	struct {
+		uint32_t ce_count;
+		uint32_t ue_count;
+		uint32_t de_count;
+		uint32_t ce_overflow_count;
+		uint32_t ue_overflow_count;
+		uint32_t de_overflow_count;
+		uint32_t reserved[6];
+	} block[RAS_TELEMETRY_GPU_BLOCK_COUNT];
+};
+
+struct amdsriov_ras_telemetry {
+	struct amd_sriov_ras_telemetry_header header;
+
+	union {
+		struct amd_sriov_ras_telemetry_error_count error_count;
+	} body;
+};
+
 /* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion */
 enum amd_sriov_gpu_init_data_version {
 	GPU_INIT_DATA_READY_V1 = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 1d099ffb3a5a..74e213e1e937 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -40,6 +40,8 @@ enum idh_request {
 	IDH_LOG_VF_ERROR	= 200,
 	IDH_READY_TO_RESET 	= 201,
 	IDH_RAS_POISON	= 202,
+	IDH_REQ_ECC_COUNT = 203,
+	IDH_REQ_ACA_BANKS = 204,
 };
 
 enum idh_event {
-- 
2.34.1

