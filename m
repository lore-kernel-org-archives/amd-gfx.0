Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 21:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0870810E7E7;
	Tue, 12 Apr 2022 21:31:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6117910E7E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 21:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOgXNfG8mQpoUCcIX5IpLxkyXnufxK2pajB/WHNbQ4dOtYEQjJIvK4cwjcIdprXgmXGNoneNKWRWexWhRT0Ku7gV056yMf3g786e3ZSElF47E+Vigo5KkOQRAwGRwXDl1q+LHOSBfiQpozMY/MU90640J2v+ZsCF3pA632jf+Ow7tjWADRfCfuao161oqq87rk+jkFMaRAAaRJZeA0kO+T92HFDrNAmR9FkQ5o3QvndRZ2x7+mzywc+Qwcda//EqKjuWWD67XYdnacYaqCG0xtMR9qRJQvq99O5xPRhnUrajUA7Ba5TxabVNuRVpRlyzH7a5OuRQbCgU5kUUmUKbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j46ENCsUGvLCmMubUKiOgvxSvLT2y8MumePvTxG3Bv4=;
 b=MqW64ssJK+refQ27NjAZsKpOHR8UMtAawm0NBdVCH9W4ivGEB3YD8OX2vUOg1m23xTNVocKdnJw6wtsaETnRgBAvvxVTPvPld9sVkG3CBBnISA3AcKVI7AThUiQJovzQIYqxc3hjye78LB6lX9lhSA94Kqgxau53GX1oPeLR9SYIgcr4HmBCoTSlJD2oJNzq7dkg5FsNe7fx4lgdyRhOOhl3Cs8dxs75/M8/dvX79IKHvcdiRwAcGvAlv13tC99sR8JrE4hH9OUMPd4Yek6eY4TmeyA08tphHW1ZcEKr/3sAb5Z5pswWJq65L59j2gYt6D4Pl7ywwvCpZ2/yxg6AUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j46ENCsUGvLCmMubUKiOgvxSvLT2y8MumePvTxG3Bv4=;
 b=wydAbrGB1WHbaMUyklza4Fo0hGL/jKyeJx0ld3U46DlYsIMFrYZiZ1OBuSZy844SUhEEP3/yLoQS97NTvM9UyPXjii/KWaJKoqkuLWRCQ0p6oMQ9qDFNwUlqTFcI3a/m+HVm84g4KFpBF1MWdE9XxmIh2jUqjmvTUNb+ypk9AqE=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by DM6PR12MB2793.namprd12.prod.outlook.com (2603:10b6:5:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 21:31:18 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::e6) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Tue, 12 Apr 2022 21:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 12 Apr 2022 21:31:18 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:31:17 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: Update PF2VF header
Date: Tue, 12 Apr 2022 17:31:16 -0400
Message-ID: <20220412213116.131578-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760c68df-059a-42fc-559f-08da1ccbc7fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB2793:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2793275B7D01DFD50DD35600F4ED9@DM6PR12MB2793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufABe77x+j87woaVEs9EGDYpkuYmhXRPwZejGQYRLaKpOn8gX1wpBqad013KSZw9hHvCa+LqJoscpg2YsOQ4k368Dky/990DpERUE+J0BYG/LlfDmn1vMrTY+lWXECAaRVrnjRkUXJFy78u9ro79P1jR//H30l5Ybv0Qn+/H7cqcJ8PlTTDCyAdGmhF4FLJh1Z3Btn97dci6dcykd7XzRMnxKLUQZ8YI91CwFQzEoEkunHCizrv/vyQq7cf/bmETmjBIJ9qrLsZFgKF3w4tU/JqREIcF1QDN/Nm0uahG/8/30VpoUvHqQRe8cMvcb+PrmQTUUZZ9WORyJyhyppqcYQFiVn9iiAc7iU4IyfbAhO08mtXL3OI6Jb+75XFaEhrPZJk/tg8/Uv8v9dNPM09kxWqaFhSWqOHOWIgq2M/2Q8HYAs1muQv+zaGkakSCGu8oqSN2cYc9ZuTiraceQ6/8pPoPf7udj8ByN4KBCEejLbGN7HbyFqFdV7lkPalcjXRmYyRU+A+foM76Pnigv3wavcKCgVMi4wTigtJI9GxSVa/CjKsy9fv39Lk+oD5QXcsH321TXvk7R91336HtTHS86xz3Ij+tPEK7Y8czJz/eyVGj5Cnyh/BNXs4Oc9bBFlTvT1OHVwEVTouMU1D9fqNo6upv+FTG6KCIPiJ5JHVKqNv4Hrt5A26/6TXphgEOs8rfc1TM083sGKNP25TeKCswZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(5660300002)(82310400005)(2616005)(4326008)(316002)(6916009)(8676002)(70586007)(70206006)(86362001)(508600001)(7696005)(36756003)(16526019)(8936002)(83380400001)(426003)(36860700001)(186003)(1076003)(336012)(26005)(356005)(15650500001)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 21:31:18.4263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760c68df-059a-42fc-559f-08da1ccbc7fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
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

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 95 ++++++++++-----------
 1 file changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 7326b6c1b71c..65433cbb00c5 100644
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
@@ -204,7 +203,7 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
-	/* pcie atomic Ops info */
+	/* PCIE atomic ops support flag */
 	uint32_t pcie_atomic_ops_enabled_flags;
 	/* reserved */
 	uint32_t reserved[256 - 48];
@@ -224,7 +223,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct amd_sriov_msg_vf2pf_info_header header;
 	uint32_t checksum;
 	/* driver version */
-	uint8_t  driver_version[64];
+	uint8_t driver_version[64];
 	/* driver certification, 1=WHQL, 0=None */
 	uint32_t driver_cert;
 	/* guest OS type and version */
@@ -258,13 +257,14 @@ struct amd_sriov_msg_vf2pf_info {
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
+	uint32_t reserved[256 - 70];
 };
 
 /* mailbox message send from guest to host  */
@@ -276,7 +276,8 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
 	MB_REQ_MSG_REQ_GPU_INIT_DATA,
 
-	MB_REQ_MSG_LOG_VF_ERROR       = 200,
+	MB_REQ_MSG_LOG_VF_ERROR = 200,
+	MB_REQ_MSG_READY_TO_RESET = 201,
 };
 
 /* mailbox message send from host to guest  */
@@ -298,17 +299,15 @@ enum amd_sriov_gpu_init_data_version {
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
@@ -319,13 +318,11 @@ _Static_assert(
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

