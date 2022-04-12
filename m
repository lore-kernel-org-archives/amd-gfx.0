Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D900C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 16:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DD710E0B6;
	Tue, 12 Apr 2022 16:04:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C529410E0B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 16:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPJWn+5hT1A9TMzV5hQR7vlzWgr9e8fBhkVhrvwWmDNyhhH7NsUqx2c9AOfpKLplzOfZ/3/ZtdfbN2Wm7guSqt9kFhtC7EsUlx9bIC7gIJw8xxR50HyGgJe9/mecu51DwpUjpxGKUDzAXcg2jYMgDMeo1ARMbhu3xE2hA7LnRjDPeJdh0zecxW2aUcWgT02e2IJgLQsJJWJO+YcEqhKV+MFnFgbu8wFVwHD6KpZOLfHgQTOpjIKXEu61tD3kuydaIiGVSFKF5M1a+ecCNFWRABS38QxQa0YKgVs8yhFElstxeGo6drp6SA8JS7vEo1EjnGQBa9qKcwjGwZEnW3ItJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMQZD7plXdtFtulWpWWIcQieGNrG/0LSXU2eyOsIkxA=;
 b=Y9+2jWplhpPRQNj8gchUH0LaKiPR/LUrctjHDR8lA1TaMBXExtmq4fvkwVzISOLFeA67sJBD1ZpOQmjWoLZr3WwQwZ6WHSE10QWRRmz2LszzXsz+iqGSZWRcb1KDAmNBkQ/G7sJZ9rk9+FSUrS9pnDxiCE/EwmtPRUjkzTP1EtzqV1oRZZ/z4fl4BnEcVbj9Die6DN+CJ9L3qPbkyyCcx0sTRSL02cbdFybzaRpepN9ZyPzh1eL73ywDAtumAUxzP3SDZxVzqwUccPi00o2GVEkgU1pDv1yUpGrGOhKit2rB+EcAGe5OouH+UMTYsWQSBLj/NmSHuBSPoQ13AVwtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMQZD7plXdtFtulWpWWIcQieGNrG/0LSXU2eyOsIkxA=;
 b=jyMgsxe2z2YGwPCPWEc9BbRr1ikgOc0Qcuzmy+ayzMzjJ1i8TqQy5I4WAkYcWEyEnCwQftb7Ka67kdJ1Xowljk5OE3n/dyQqMEKvZIuegEG+sul6cmlcbm+lNBiNz3IKXWUpakJ3TekIbwsRkzVmx19/eBYcq1Duj8jM5gMVxHA=
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by BN8PR12MB3473.namprd12.prod.outlook.com (2603:10b6:408:65::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 16:04:21 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::c7) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 16:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 16:04:21 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 11:04:19 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Update PF2VF header
Date: Tue, 12 Apr 2022 12:04:08 -0400
Message-ID: <20220412160408.128949-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d280ace8-741e-452c-62c0-08da1c9e1b39
X-MS-TrafficTypeDiagnostic: BN8PR12MB3473:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3473E62CD2C98431111527D1F4ED9@BN8PR12MB3473.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRmH2ip8KXg0Ac9C6Py2plciGuK2gEPMmvjlDsbiYgqLUC+gJSz2QWU1FnA7gBdPYgnjk0xkCYZMSy7nN88UBtZXV+IL/og5X+OA9QhGPuahRxDXcMTHI0IBABKdn10cNSgQCNPu3tJ14ytpHThwRx1ysXr4t7vBDkFf2pevDmA0zelSBGvtuhtFWZL6A9cMrrkgAIocABQSbapsc0SElh3htwfT6JPt4qZ2X7Qjfa2jmq5PL5HxAEdHWBVdM0vxb6xoCpGQnhBhUcoISdtfnnnhkV0O/dCiITv/pOrpr9oFyBA3TYqh/doXvu8ctsRVVLnnftXg9umAa/qUsQ+x56/GXM+KKlDnYs+nuabR9bokpomq/3IESu9rsrfn1yxmKnnTuXrLzy88Ra8InD6F5i+js2uue8KH8iFP7p47bjb/vYh09Byna3vpdgEuRC5Pfe1hkl0Yd7B0tKCiXau4U+PBcg2DPseHfo7pySp+6HRjpFvCBCEBmg/gCtubJeOM1XNNQrjMJRhJhJa1dHKGHfYhI/RlgMDWBr/jHjp5tzRSjeoPe0hv0yk9+ASYH/nPO0KAJDSS3tJryL/CM4dwYHkkFeB7022Xc+0onIJx+xI1UepQKX0aRhXnWhE7TzwRF6ZDwhX3Z+zVAmt9Hu2C1MA0qKszvpou0irYo6OM46HZ/rhG+LmS1gzECn/sen8SPJL/xg/lCuj7YsTcJ7bLYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(47076005)(82310400005)(6666004)(36756003)(356005)(15650500001)(40460700003)(2906002)(83380400001)(508600001)(2616005)(316002)(36860700001)(1076003)(86362001)(426003)(8936002)(336012)(70206006)(70586007)(7696005)(6916009)(16526019)(8676002)(4326008)(186003)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 16:04:21.2721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d280ace8-741e-452c-62c0-08da1c9e1b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3473
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add proper indentation in the header file
- In the latest version of the header, there is a variable name change.
  This should not cause any backward compatibility since the variable is
  at the same offset in the struct.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 101 ++++++++++----------
 2 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2e0a81831e0..14c5ccf81e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable PCIE atomic ops */
 	if (amdgpu_sriov_vf(adev))
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
-			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 	else
 		adev->have_atomics_support =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 7326b6c1b71c..43dc9026ef7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -1,34 +1,33 @@
 /*
- * Copyright 2018-2019 Advanced Micro Devices, Inc.
+ * Copyright (c) 2018-2021 Advanced Micro Devices, Inc. All rights reserved.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be included in
  * all copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
  */
 
 #ifndef AMDGV_SRIOV_MSG__H_
 #define AMDGV_SRIOV_MSG__H_
 
 /* unit in kilobytes */
-#define AMD_SRIOV_MSG_VBIOS_OFFSET              0
-#define AMD_SRIOV_MSG_VBIOS_SIZE_KB             64
-#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB    AMD_SRIOV_MSG_VBIOS_SIZE_KB
-#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB      4
+#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
 
 /*
  * layout
@@ -51,10 +50,10 @@
  * v2 defined in amdgim
  * v3 current
  */
-#define AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER			2
-#define AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER			3
+#define AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER 2
+#define AMD_SRIOV_MSG_FW_VRAM_VF2PF_VER 3
 
-#define AMD_SRIOV_MSG_RESERVE_UCODE		24
+#define AMD_SRIOV_MSG_RESERVE_UCODE 24
 
 #define AMD_SRIOV_MSG_RESERVE_VCN_INST 4
 
@@ -83,19 +82,19 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID__MAX
 };
 
-#pragma pack(push, 1) 	// PF2VF / VF2PF data areas are byte packed
+#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed
 
 union amd_sriov_msg_feature_flags {
 	struct {
-		uint32_t  error_log_collect  : 1;
-		uint32_t  host_load_ucodes   : 1;
-		uint32_t  host_flr_vramlost  : 1;
-		uint32_t  mm_bw_management   : 1;
-		uint32_t  pp_one_vf_mode     : 1;
-		uint32_t  reg_indirect_acc   : 1;
-		uint32_t  reserved           : 26;
+		uint32_t error_log_collect : 1;
+		uint32_t host_load_ucodes  : 1;
+		uint32_t host_flr_vramlost : 1;
+		uint32_t mm_bw_management  : 1;
+		uint32_t pp_one_vf_mode	   : 1;
+		uint32_t reg_indirect_acc  : 1;
+		uint32_t reserved	   : 26;
 	} flags;
-	uint32_t      all;
+	uint32_t all;
 };
 
 union amd_sriov_reg_access_flags {
@@ -110,10 +109,10 @@ union amd_sriov_reg_access_flags {
 
 union amd_sriov_msg_os_info {
 	struct {
-		uint32_t  windows            : 1;
-		uint32_t  reserved           : 31;
+		uint32_t windows  : 1;
+		uint32_t reserved : 31;
 	} info;
-	uint32_t      all;
+	uint32_t all;
 };
 
 struct amd_sriov_msg_uuid_info {
@@ -156,6 +155,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -204,10 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
-	/* pcie atomic Ops info */
-	uint32_t pcie_atomic_ops_enabled_flags;
+	/* PCIE atomic ops support flag */
+	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
-	uint32_t reserved[256 - 48];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
@@ -219,12 +219,13 @@ struct amd_sriov_msg_vf2pf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
 struct amd_sriov_msg_vf2pf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
 	uint32_t checksum;
 	/* driver version */
-	uint8_t  driver_version[64];
+	uint8_t driver_version[64];
 	/* driver certification, 1=WHQL, 0=None */
 	uint32_t driver_cert;
 	/* guest OS type and version */
@@ -258,13 +259,14 @@ struct amd_sriov_msg_vf2pf_info {
 	uint32_t fb_size;
 	/* guest ucode data, each one is 1.25 Dword */
 	struct {
-		uint8_t  id;
+		uint8_t id;
 		uint32_t version;
 	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	/* dummy page addr */
 	uint64_t dummy_page_addr;
 
 	/* reserved */
-	uint32_t reserved[256-70];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
 };
 
 /* mailbox message send from guest to host  */
@@ -276,7 +278,8 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
 	MB_REQ_MSG_REQ_GPU_INIT_DATA,
 
-	MB_REQ_MSG_LOG_VF_ERROR       = 200,
+	MB_REQ_MSG_LOG_VF_ERROR = 200,
+	MB_REQ_MSG_READY_TO_RESET = 201,
 };
 
 /* mailbox message send from host to guest  */
@@ -298,17 +301,15 @@ enum amd_sriov_gpu_init_data_version {
 	GPU_INIT_DATA_READY_V1 = 1,
 };
 
-#pragma pack(pop)	// Restore previous packing option
+#pragma pack(pop) // Restore previous packing option
 
 /* checksum function between host and guest */
-unsigned int amd_sriov_msg_checksum(void *obj,
-				unsigned long obj_size,
-				unsigned int key,
-				unsigned int checksum);
+unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned int key,
+				    unsigned int checksum);
 
 /* assertion at compile time */
 #ifdef __linux__
-#define stringification(s) _stringification(s)
+#define stringification(s)  _stringification(s)
 #define _stringification(s) #s
 
 _Static_assert(
@@ -319,13 +320,11 @@ _Static_assert(
 	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
 	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
 
-_Static_assert(
-	AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
-	"AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
+_Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
+	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
 
-_Static_assert(
-	AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
-	"AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than AMD_SRIOV_UCODE_ID__MAX");
+_Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE > AMD_SRIOV_UCODE_ID__MAX,
+	       "AMD_SRIOV_MSG_RESERVE_UCODE must be bigger than AMD_SRIOV_UCODE_ID__MAX");
 
 #undef _stringification
 #undef stringification
-- 
2.25.1

