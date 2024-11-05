Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1013D2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DF010E5BD;
	Tue,  5 Nov 2024 14:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LX1/zRb0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F84C10E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6+GYWsfTISP/djsGZPRVLz+z0TcXq4+M26nBIOwwBMpen2nw5bz6E9iAyscI2J2ArpiiUFJAfjhwMQwehfg8O/gJGoHqQMbKOBb9eSz9GiMHzMIvyvHuoPQvg0nhDKX/keGqu2pPqolriPrR2cOXkxFMvhi93Ll4KVY2c8En1adi5taFEXS0cS4jFfjliSJQdlMpv96pMqxFijCpnPHqN9amF3slsE5cPwQ8czSa0JsFOZM7E0AkmyEHr1jvkgpliisNwTQ6yVZsKq8Q+EIUxUlDUN3tqiHOgTQZNZuJyGxAfJV56u5BY+CGp9k6lBBxh256KlGgsIcK3H27DvJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMCcYgPt2JBdfp3eUHjUJCmyTRCPdNzMYm+1JLNcZU8=;
 b=XRRc0J/XZmUNINJ5ZKVKtuz3aX7Tz9Tq+2GY1jXzQkkkYk1/XPXNv1X2qQl+pguQb+oZwrkrVmjopPGuHrtjAbUE+gapPB/2SAUD/pN3ot7Jmqi9mISgVqpDFZ6wFH2UWz9lDwaqUbfPO1Rd00XRgg02Qg1/b2/r1ezZ3vuD8g+AeueAQfjBoaKy1whSYWTXJz1K9bc14v9X6h3cuWXljaQoPPAwqdpSeoi7469xJMi5smtjmPj6XLrB7TqzkIftAiauwbKDge2S+DwYQ31Bn3v8/4pbzyn8PDlr/LdFmLW+NIarHsC7XpER/8Zq6J4Dy86UudIzggQDA+z55y1HRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMCcYgPt2JBdfp3eUHjUJCmyTRCPdNzMYm+1JLNcZU8=;
 b=LX1/zRb0FbIbiiEbLyxF29FycnsnLUjqHvF6t+MhaNlG8zV/ID8JrIR1xkEsSTzitDEBtqdHjimVY8ie/z+zGEFYQRuf6D/jIfhe0zlNpUH/ZQCNs1fihYa9TOVrvQsNgOubqWKAEL6/KvfJ21zjraBvh5nJITXIsguR6aygZbs=
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:30:36 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::54) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 14:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:30:36 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:30:34 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Update SRIOV Exchange Headers for RAS
 Telemetry Support
Date: Tue, 5 Nov 2024 09:30:04 -0500
Message-ID: <20241105143007.274828-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: f828fc00-e659-488e-70ee-08dcfda669f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWdbSnISQO8yC3o7v+P7Q/6XnMjf7OR3iQg74zhUaGIdqQq7gYh80zArJauM?=
 =?us-ascii?Q?YQyWeQjGNEgoWIp6VajgizAbr6aA86ppleJyhn6nzwGd97RaN7qVTcb3y2nx?=
 =?us-ascii?Q?0BK4TfZEt3djDhEpNyHV9dzmXBNU27MW3KwuVlSxfFm7MJo0Oif/B/NIwqji?=
 =?us-ascii?Q?/GNHrBRxuEUzU16DQPHTz/CWbXnqaUguijY6L+lJddKXWseFFt2WHvGTGrD9?=
 =?us-ascii?Q?EPJhogYCiMRAAO79v4doRcXpBCQiTOvB+dgldcgu59gR7m4ud07l+W+N8dAK?=
 =?us-ascii?Q?RN9GTFw+UrgsS79Xt5UHMRFYuCAk+G0KKgkOTKKY3aO2qc1xsT1U4vCWMNXG?=
 =?us-ascii?Q?owxgTegVyBad8RLclAsKVVaaxaKUqBpK/kivwxmmsCNcN6AQlD1vSjs03MMa?=
 =?us-ascii?Q?Xdpt5MGMG/g8mmwZ3kLM7SG8d+jgM6V0CRiTQmZulYcc41cBb83dCk4xAIbV?=
 =?us-ascii?Q?sH4BQf2UZfZ/bS9sfs9pqVy1QZ7Hh+HS6Y63ahSHEgUzI2K7p2Sh8M0Ap8fF?=
 =?us-ascii?Q?XwfjKs2WjnVqkzv0EkPM6gxdcsuefPC0tYxEDJKxmOj64ye+YDsttX33OUVK?=
 =?us-ascii?Q?JXAF5eTkwCFRZ2fmGOxp5XqubhXxfgNOwzrqzI+Yl1lCQxNftbc7MFoo2obf?=
 =?us-ascii?Q?fv42+7XVO5I1oQ3IokHGf2MF1/UQh3dAN0z5sGmwmlgt7sveS9VLy3zp12it?=
 =?us-ascii?Q?bY5nDp/aSnDiUdgPX4fm2BqZOawyePoOayPitNWXzurDvOTPGNV0rn4mRydZ?=
 =?us-ascii?Q?wd2dy4tWvbkul+/uOcDoA3iWZ6eT7Dv3YUHpCy8hVD1DjN7HO+StpRLludXy?=
 =?us-ascii?Q?QwpS6mbbohgRKI9SbNZMULWLFMYYeL67+v3YibU3yJ2jowIqQg2d893VgUIc?=
 =?us-ascii?Q?2rb84Yq/YtuWhJ4a+xx5O06vuoYOSI7fTdHlV9PI40rt2mVoS6dPnurQSwq5?=
 =?us-ascii?Q?H214QyFSDJnQEFG4Tl2YO1trtLZ3v/6wfqy4e7KSj5Xgg2BSX1wikkKQIlr1?=
 =?us-ascii?Q?yGlzaCmQPUQZBBbnZXLR9fhLC6TMdvKphot/1YoZe0Z/vY13E8ktix+g94HX?=
 =?us-ascii?Q?Q5djygdBvsSGjqN1TASsGxd82NG/wK7zalE6fTRiVIBhIb8XkXqHFJ1UD/yX?=
 =?us-ascii?Q?bQ/3dlUaf4m2ur96TRbD0aE0w2FGxwQ8PnxEnrzvYBiU1R3Gc8TI5CdGznXB?=
 =?us-ascii?Q?HFKeySdU4zkbqHm+FMGYWxh/nyBfk3Mifap//xqcNf9JYhA67eEpIqsUMzHJ?=
 =?us-ascii?Q?j3ryuggWfYmUm0jm6ALbGJmKTzgtCIaQx6G4jUC6AJs1akv5aWn16AzDQ8o+?=
 =?us-ascii?Q?n6w/bW8Lw4GCMwqex9mEAnrzSV4uJHaO7UQe6HRB074oa8ecfDR8wn1JCiB4?=
 =?us-ascii?Q?dAYbZ15ttzA++Ba5dRgG0WS1HehQrgmESPC1Ct3Yg30eHZL1Gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:30:36.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f828fc00-e659-488e-70ee-08dcfda669f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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

