Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544BDC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 07:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F8310F0D6;
	Tue, 12 Mar 2024 07:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUCVK/Qe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B7710F0D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 07:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0xmIfgapc3JRWPjFdz9UVdusZ0o6yVLzAs49FXyX6dXDJLS97CBbbfg47ryh9YNMfc7HFKKJV+QLjhVVwfLzbZDZ/n/7wb47Ygjv+52emnNz/uChwncA0nFI8R2Fj2iedtRbKzEPJ4P9dzal3DL0GsN4FeJDoXKLSKzuWTGpheKwsD5jVVD1r6fXDVKdjf5Erqsuap4jESzlqtPASOQAMi+pMUJ/LognSc9utSUBB+riY3ye2F324tBI7YpDoE6KkVyi6XKiA+TPWQQuRB+j9Hl/astDKzPl3laR7O1jfN565CLSGj9pBLD3Fb4z0/Wz8GkqBdfAI/1xMsfawpxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKoJS7sdoskfmSMhXeq4G1ndCC0s+L6q74+J3NiNWuo=;
 b=D6//6jpi2e6/zzND2ldwgevLZ8ZK7F4Ok4ar7U/9F+bzIg5gTedI11LFpK27C0QO/ulBNdutbcOrsRTkiX7cvf8Ei/Z98uI0Mh0haOqm5561pAaCPLPkVWjsToaQFa2QhtGS7i06iior0Tu5xZ72j4VtbH8d18hrb8RhMFGhQo5o9VRKV9uyky0SgxpNMaZGyilwWgLAFdSkECZbJhQ/DYAUXkgvny8WbC6ro0OPwnYkk3zg5LMuguHDfoWm+Zj8MqxBbGcaUltEMdW1uYEuWPkPJiPKVZ4pjro478b0lWuSvaAgHvs5z36s5MCKB0kp6CjtEfR1kMDqBNa7fDCpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKoJS7sdoskfmSMhXeq4G1ndCC0s+L6q74+J3NiNWuo=;
 b=hUCVK/Qezue2p2/DXVfiKMsUBea1CVKimU/7IWHYeBtt0tw1+d9pguTdI21g+fouaLQewr9zUBi09J6hAnL7xquQjdQvQ89s3eDew2KXbz35Rvd5cK+O5zHfVzXGYZbGWJM3jt77fn3FqCTFncOoAAPbCV0RoHrkL8zImDa468A=
Received: from MN2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:208:a8::30)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 07:06:11 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::90) by MN2PR12CA0017.outlook.office365.com
 (2603:10b6:208:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 07:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 07:06:11 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 02:06:08 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <leo.liu@amd.com>, <sathishkumar.sundararaju@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <alexander.deucher@amd.com>
CC: <srinath.rao@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: enable vcn1 fw load for VCN 4_0_6
Date: Tue, 12 Mar 2024 12:35:50 +0530
Message-ID: <20240312070550.2455243-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6e5270-3431-4229-96ca-08dc4262e605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGo39pIl+B+vwmwECMZaNQVq/sey1p7auidbbpQPeym0A/LOQGXKnHEeaEqfNJwx0Duu1IAd/ex4Yg2rhl2bcBnAD4lIhiMHMWljKyMYaomOCzob/Tbio3NPjFD7E8HFJa7EBRfbyuW4tLlpUtiTi8pKsy+Pb9Pj1hVqR/NYe/H5msLxNEr9SsZ4NKhQGxkRrfySKMpj/vOQvwLCB19F3EHbgHTUvFFWuaNkTKSALSg60ic1ju09XBp+yFdGvuEnCvyjmPBDLwP28yEV8QOx2GEEuKZMeArhZi5DAM7wAevtED4iVZZ10rqQbg5Mwc8Q188eAyKLFC20qPU76HYb85Ft+zy89VPK39C6a/6jKijQz+dW7rfvOTkK1cndSvp6nboE8MLK5Zuh3gOi4b9RRYQtZB78o/a67pLooI+dbIDNflzya0ppNRcupP3vJA1yCU7WMsusUMk44VkZ8qZOTjxY4rJ9//DLT64qGnXM/xuxVGcrIpo8c5XjJmC943DhcRYUDeA3ycdlAH6kSvN69d9hV7EZWzb6oWNUvqwuNnm8etrNLReXzSQqvde3eLJl04XTRTWITURyuFRbXKeJc9/1za6lThtN76j166VgmemdL3/xt1RcjGSYuNcnCeqe0r0D70nvuug1yPjTMF6j8GtIH5ABQ+S9ikPY4+f++PAx6db8cTzMZbYeh5SmyFoZYUTfa4PtAn+ftXuRyR90s/7bTBX1hPCvhbmWcJNiu8VNhUa4IEwbxxCmcTZcD2QJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:06:11.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6e5270-3431-4229-96ca-08dc4262e605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

v1 - update the fw header for each vcn instance (Veera)

VCN1 has different FW binary in VCN v4_0_6.
Add changes to load the VCN1 fw binary

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 38 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 +++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 +--
 10 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b2535023764f..9c514a606a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -60,6 +60,7 @@
 #define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
 #define FIRMWARE_VCN4_0_5		"amdgpu/vcn_4_0_5.bin"
 #define FIRMWARE_VCN4_0_6		"amdgpu/vcn_4_0_6.bin"
+#define FIRMWARE_VCN4_0_6_1		"amdgpu/vcn_4_0_6_1.bin"
 #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -85,6 +86,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
@@ -93,14 +95,22 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[30];
 	char fw_name[40];
-	int r;
+	int r, i;
 
-	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-	r = amdgpu_ucode_request(adev, &adev->vcn.fw, fw_name);
-	if (r)
-		amdgpu_ucode_release(&adev->vcn.fw);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6) &&
+			i == 1) {
+			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
+		}
 
+		r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], fw_name);
+		if (r) {
+			amdgpu_ucode_release(&adev->vcn.fw[i]);
+			return r;
+		}
+	}
 	return r;
 }
 
@@ -141,7 +151,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[0]->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
 	/* Bit 20-23, it is encode major and non-zero for new naming convention.
@@ -256,9 +266,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
+
+		amdgpu_ucode_release(&adev->vcn.fw[j]);
 	}
 
-	amdgpu_ucode_release(&adev->vcn.fw);
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
 	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
@@ -354,11 +365,12 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			const struct common_firmware_header *hdr;
 			unsigned int offset;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-					memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
+					memcpy_toio(adev->vcn.inst[i].cpu_addr,
+						    adev->vcn.fw[i]->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
 					drm_dev_exit(idx);
 				}
@@ -1043,11 +1055,11 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
+
+			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
 			/* currently only support 2 FW instances */
 			if (i >= 2) {
 				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
@@ -1055,7 +1067,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			}
 			idx = AMDGPU_UCODE_ID_VCN + i;
 			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.fw;
+			adev->firmware.ucode[idx].fw = adev->vcn.fw[i];
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 1985f71b4373..a418393d89ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -306,7 +306,7 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
-	const struct firmware	*fw;	/* VCN firmware */
+	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 25ba27151ac0..aaceecd558cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -304,7 +304,7 @@ static int vcn_v1_0_resume(void *handle)
  */
 static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -371,7 +371,7 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 
 static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 18794394c5a0..e357d8cf0c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -330,7 +330,7 @@ static int vcn_v2_0_resume(void *handle)
  */
 static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
 	uint32_t offset;
 
 	if (amdgpu_sriov_vf(adev))
@@ -386,7 +386,7 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1878,7 +1878,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 
 		init_table += header->vcn_table_offset;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
 
 		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
 			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index aba403d71806..1cd8a94b0fbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -414,13 +414,15 @@ static int vcn_v2_5_resume(void *handle)
  */
 static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size;
 	uint32_t offset;
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
 		/* cache window 0: fw */
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
@@ -469,7 +471,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1240,7 +1242,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V1_0_INSERT_DIRECT_WT(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e02af4de521c..8f82fb887e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -449,7 +449,7 @@ static int vcn_v3_0_resume(void *handle)
  */
 static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -499,7 +499,7 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 
 static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1332,7 +1332,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 			mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8ab01ae919d2..832d15f7b5f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -382,7 +382,7 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -442,7 +442,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 {
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -1289,7 +1289,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 			regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 810bbfccd6f2..203fa988322b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -332,7 +332,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	vcn_inst = GET_INST(VCN, inst_idx);
@@ -407,7 +407,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -894,7 +894,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0468955338b7..501e53e69f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -45,7 +45,7 @@
 #define mmUVD_DPG_LMA_DATA_BASE_IDX					regUVD_DPG_LMA_DATA_BASE_IDX
 
 #define VCN_VID_SOC_ADDRESS_2_0						0x1fb00
-#define VCN1_VID_SOC_ADDRESS_3_0					0x48300
+#define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
 
 #define VCN_HARVEST_MMSCH							0
 
@@ -329,7 +329,7 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -390,7 +390,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -486,7 +486,8 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+		adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
@@ -911,7 +912,6 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		VCN, inst_idx, regUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-
 	if (indirect)
 		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d6ee9958ba5f..bc60c554eb32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -290,7 +290,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -351,7 +351,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
-- 
2.25.1

