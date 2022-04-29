Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112B2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE6D10F28E;
	Fri, 29 Apr 2022 17:47:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29CF10F119
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H58jGNwhFR9t5HnSoCYHHf5C4C0oe++Aj8HtO9X8uGLW/ycD4o9bDPpZlbv/OJILK0wiCoyFWVhBta/Q5Qae8sNNdaRQHLJwnlH7WEF4OFiKdrBEjaBog7s2Q89w1/fhnh5txJo2QLX/MMsBb5UjqJDBD3YRHCK/10RzcRTYdZxocXSrcXSVvbWSrqFa3lEMsHDqZQNq9lywmiWFiSBcKmt78ghR8D96rRv8zjGN3qoyk8azHFI8GrG8UwPzmwm2jHd1baacfNyU2TsT4yvG08YWVs56g/YWItkQctP+BHAMY238VY4Vmm9+hqrKhbh0OzLIR0IBaMEwuS/nPvhEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXUXT0/hA9SMyWIg3neFVt4r3pzNGuX1sfnmjIXD4/0=;
 b=MTVCbgP3S4SUcbSocb/aL9p/gDdlBmY4AJ9kGiTSJuTpdKMuee1yI2H44yusKdhH+TEZX1+yTRJzbJyYFR0aDzNEswjB93m3UzUtxLebGmhkbqALuPwSR4/LfN/5lfwwq+kpOHXKa+1QHUYpbqRiqcZIXortF8g9rbNqom5+O/FyF8v3XNayn0aoh3mKf+VK15iLYhXKzAtsCf6Jvl5R3tGtIeYcvF1KD0nAOBOPFlBYf3nh76nC+hEtZPOmau+MSJ91mJKzXu9++DGzzR56kbrSDg3H3PhR3s0yRB3SCVzxIj5cL/JkJr//ulM6CY1/bs8FLzntr78Yv87RsN2DsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXUXT0/hA9SMyWIg3neFVt4r3pzNGuX1sfnmjIXD4/0=;
 b=FnVzmXeWPNb82C547OGglNcZh2ls1jhWDv/26ByHtLrL6O/cYimgAW0M4xS483TVVpAflDr9ymlNQqL3ygzCOb1WrZabAH4v+MKffHbImj4foLonmCNeEv1kGwboOqCgj/RAz0pq2sQWZ3mHZyz/S5gfoDwxmavXlLQ8jE3NiUA=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:46:49 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::af) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/73] drm/amdgpu/mes: extend mes framework to support
 multiple mes pipes
Date: Fri, 29 Apr 2022 13:45:31 -0400
Message-ID: <20220429174624.459475-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ab33f9-e5a6-44fd-f75f-08da2a083cdb
X-MS-TrafficTypeDiagnostic: CY5PR12MB6105:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB61050ACF5736D3836202AF89F7FC9@CY5PR12MB6105.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Eja0Txw67x5gYOOGWWQgZPlinq3erqoaXd6evgdBQV5faSwK1A6OwM59r90osgnarZSsMSMfXI2npCAao9bIhS9RuKAio/SxjmlKyozF/SOTWREM3u7LDFT4DX66/++T/UurE1QzqVPMv09oNPaNOQuXJe0tC+ui8ozYMKHYUudQzOauKhzsGfi+LW/KpSQiDa5m4yBt0ZR4a3OVXL8AlfdGeUJnwX8AR5pIY/8S3oDWcMISJaAkcbtrwVHW4DkY/1vWTtOlwIWoj0VMn8asRr4cyaNR2999HMlpYCLNAKBjw9zoHzvC00SCKqxWCCIlb8dK2fOezWbEnFBLSnca3zuWyvSXXVMdc5r0mrm1PpkFu+NrUdndnSPMyDFCOJHwlTRzX/5YMWc3/zRSKQPhz1bRXneLErJR/mQTF+72uEN1IePKFfKC1YQdh4lZQUwYLSji+Q/LmqyNkv6Azvk7l2QwuTnYuRLiajMww0ZlagU/ze42P3CtkjShx5rVHg73Xu2YB9e2T/a0Gf8kFcgfPQzSTknsAz7rFNLNEKfgI0aluMO77a2TbUBpsytFnxEgBahTn+Or5OI++EVp/jJVeAQXbY2oE6eb83Vfw+u8hUfBg1+5U9L4E0ZoDt/GDEgwmqWn7b93b+VhB2OlywKKJl8QujRwcD35kSKYBMkeT9nbnYi00uiPehA4D0zkdQ+Jfx1iWgIc1a0nxszf6i00w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(8936002)(5660300002)(26005)(70586007)(81166007)(86362001)(8676002)(4326008)(70206006)(316002)(54906003)(6916009)(7696005)(356005)(6666004)(1076003)(47076005)(186003)(336012)(82310400005)(16526019)(426003)(36860700001)(40460700003)(83380400001)(36756003)(2906002)(30864003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:49.4562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab33f9-e5a6-44fd-f75f-08da2a083cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add support for multiple mes pipes, so that reuse the existing
code to initialize more mes pipe and queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  35 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 215 ++++++++++++++----------
 2 files changed, 149 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 52483d7ce843..91b020842eb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -46,6 +46,12 @@ enum amdgpu_mes_priority_level {
 
 struct amdgpu_mes_funcs;
 
+enum admgpu_mes_pipe {
+	AMDGPU_MES_SCHED_PIPE = 0,
+	AMDGPU_MES_KIQ_PIPE,
+	AMDGPU_MAX_MES_PIPES = 2,
+};
+
 struct amdgpu_mes {
 	struct amdgpu_device            *adev;
 
@@ -67,27 +73,28 @@ struct amdgpu_mes {
 
 	struct amdgpu_ring              ring;
 
-	const struct firmware           *fw;
+	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode */
-	struct amdgpu_bo		*ucode_fw_obj;
-	uint64_t			ucode_fw_gpu_addr;
-	uint32_t			*ucode_fw_ptr;
-	uint32_t                        ucode_fw_version;
-	uint64_t                        uc_start_addr;
+	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_PIPES];
+	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_PIPES];
+	uint32_t                        ucode_fw_version[AMDGPU_MAX_MES_PIPES];
+	uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode data */
-	struct amdgpu_bo		*data_fw_obj;
-	uint64_t			data_fw_gpu_addr;
-	uint32_t			*data_fw_ptr;
-	uint32_t                        data_fw_version;
-	uint64_t                        data_start_addr;
+	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_PIPES];
+	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_PIPES];
+	uint32_t                        data_fw_version[AMDGPU_MAX_MES_PIPES];
+	uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* eop gpu obj */
-	struct amdgpu_bo		*eop_gpu_obj;
-	uint64_t                        eop_gpu_addr;
+	struct amdgpu_bo		*eop_gpu_obj[AMDGPU_MAX_MES_PIPES];
+	uint64_t                        eop_gpu_addr[AMDGPU_MAX_MES_PIPES];
 
-	void                            *mqd_backup;
+	void                            *mqd_backup[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_PIPES];
 
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0819ffe8e759..f82a6f981629 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -269,7 +269,8 @@ static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
 	.resume_gang = mes_v10_1_resume_gang,
 };
 
-static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
+static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
+				    enum admgpu_mes_pipe pipe)
 {
 	const char *chip_name;
 	char fw_name[30];
@@ -288,40 +289,56 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin", chip_name);
-	err = request_firmware(&adev->mes.fw, fw_name, adev->dev);
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
+			 chip_name);
+	else
+		BUG();
+
+	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
 	if (err)
 		return err;
 
-	err = amdgpu_ucode_validate(adev->mes.fw);
+	err = amdgpu_ucode_validate(adev->mes.fw[pipe]);
 	if (err) {
-		release_firmware(adev->mes.fw);
-		adev->mes.fw = NULL;
+		release_firmware(adev->mes.fw[pipe]);
+		adev->mes.fw[pipe] = NULL;
 		return err;
 	}
 
-	mes_hdr = (const struct mes_firmware_header_v1_0 *)adev->mes.fw->data;
-	adev->mes.ucode_fw_version = le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version =
+	mes_hdr = (const struct mes_firmware_header_v1_0 *)
+		adev->mes.fw[pipe]->data;
+	adev->mes.ucode_fw_version[pipe] =
+		le32_to_cpu(mes_hdr->mes_ucode_version);
+	adev->mes.ucode_fw_version[pipe] =
 		le32_to_cpu(mes_hdr->mes_ucode_data_version);
-	adev->mes.uc_start_addr =
+	adev->mes.uc_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
-	adev->mes.data_start_addr =
+	adev->mes.data_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MES];
-		info->ucode_id = AMDGPU_UCODE_ID_CP_MES;
-		info->fw = adev->mes.fw;
+		int ucode, ucode_data;
+
+		if (pipe == AMDGPU_MES_SCHED_PIPE) {
+			ucode = AMDGPU_UCODE_ID_CP_MES;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
+		} else {
+			BUG();
+		}
+
+		info = &adev->firmware.ucode[ucode];
+		info->ucode_id = ucode;
+		info->fw = adev->mes.fw[pipe];
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_size_bytes),
 			      PAGE_SIZE);
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MES_DATA];
-		info->ucode_id = AMDGPU_UCODE_ID_CP_MES_DATA;
-		info->fw = adev->mes.fw;
+		info = &adev->firmware.ucode[ucode_data];
+		info->ucode_id = ucode_data;
+		info->fw = adev->mes.fw[pipe];
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes),
 			      PAGE_SIZE);
@@ -330,13 +347,15 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void mes_v10_1_free_microcode(struct amdgpu_device *adev)
+static void mes_v10_1_free_microcode(struct amdgpu_device *adev,
+				     enum admgpu_mes_pipe pipe)
 {
-	release_firmware(adev->mes.fw);
-	adev->mes.fw = NULL;
+	release_firmware(adev->mes.fw[pipe]);
+	adev->mes.fw[pipe] = NULL;
 }
 
-static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev)
+static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev,
+					   enum admgpu_mes_pipe pipe)
 {
 	int r;
 	const struct mes_firmware_header_v1_0 *mes_hdr;
@@ -344,31 +363,32 @@ static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev)
 	unsigned fw_size;
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw->data;
+		adev->mes.fw[pipe]->data;
 
-	fw_data = (const __le32 *)(adev->mes.fw->data +
+	fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
 		   le32_to_cpu(mes_hdr->mes_ucode_offset_bytes));
 	fw_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
 
 	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				      &adev->mes.ucode_fw_obj,
-				      &adev->mes.ucode_fw_gpu_addr,
-				      (void **)&adev->mes.ucode_fw_ptr);
+				      &adev->mes.ucode_fw_obj[pipe],
+				      &adev->mes.ucode_fw_gpu_addr[pipe],
+				      (void **)&adev->mes.ucode_fw_ptr[pipe]);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to create mes fw bo\n", r);
 		return r;
 	}
 
-	memcpy(adev->mes.ucode_fw_ptr, fw_data, fw_size);
+	memcpy(adev->mes.ucode_fw_ptr[pipe], fw_data, fw_size);
 
-	amdgpu_bo_kunmap(adev->mes.ucode_fw_obj);
-	amdgpu_bo_unreserve(adev->mes.ucode_fw_obj);
+	amdgpu_bo_kunmap(adev->mes.ucode_fw_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.ucode_fw_obj[pipe]);
 
 	return 0;
 }
 
-static int mes_v10_1_allocate_ucode_data_buffer(struct amdgpu_device *adev)
+static int mes_v10_1_allocate_ucode_data_buffer(struct amdgpu_device *adev,
+						enum admgpu_mes_pipe pipe)
 {
 	int r;
 	const struct mes_firmware_header_v1_0 *mes_hdr;
@@ -376,53 +396,63 @@ static int mes_v10_1_allocate_ucode_data_buffer(struct amdgpu_device *adev)
 	unsigned fw_size;
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
-		adev->mes.fw->data;
+		adev->mes.fw[pipe]->data;
 
-	fw_data = (const __le32 *)(adev->mes.fw->data +
+	fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
 		   le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
 	fw_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
 
 	r = amdgpu_bo_create_reserved(adev, fw_size,
 				      64 * 1024, AMDGPU_GEM_DOMAIN_GTT,
-				      &adev->mes.data_fw_obj,
-				      &adev->mes.data_fw_gpu_addr,
-				      (void **)&adev->mes.data_fw_ptr);
+				      &adev->mes.data_fw_obj[pipe],
+				      &adev->mes.data_fw_gpu_addr[pipe],
+				      (void **)&adev->mes.data_fw_ptr[pipe]);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to create mes data fw bo\n", r);
 		return r;
 	}
 
-	memcpy(adev->mes.data_fw_ptr, fw_data, fw_size);
+	memcpy(adev->mes.data_fw_ptr[pipe], fw_data, fw_size);
 
-	amdgpu_bo_kunmap(adev->mes.data_fw_obj);
-	amdgpu_bo_unreserve(adev->mes.data_fw_obj);
+	amdgpu_bo_kunmap(adev->mes.data_fw_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.data_fw_obj[pipe]);
 
 	return 0;
 }
 
-static void mes_v10_1_free_ucode_buffers(struct amdgpu_device *adev)
+static void mes_v10_1_free_ucode_buffers(struct amdgpu_device *adev,
+					 enum admgpu_mes_pipe pipe)
 {
-	amdgpu_bo_free_kernel(&adev->mes.data_fw_obj,
-			      &adev->mes.data_fw_gpu_addr,
-			      (void **)&adev->mes.data_fw_ptr);
+	amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
+			      &adev->mes.data_fw_gpu_addr[pipe],
+			      (void **)&adev->mes.data_fw_ptr[pipe]);
 
-	amdgpu_bo_free_kernel(&adev->mes.ucode_fw_obj,
-			      &adev->mes.ucode_fw_gpu_addr,
-			      (void **)&adev->mes.ucode_fw_ptr);
+	amdgpu_bo_free_kernel(&adev->mes.ucode_fw_obj[pipe],
+			      &adev->mes.ucode_fw_gpu_addr[pipe],
+			      (void **)&adev->mes.ucode_fw_ptr[pipe]);
 }
 
 static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 {
-	uint32_t data = 0;
+	uint32_t pipe, data = 0;
 
 	if (enable) {
 		data = RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
 
-		/* set ucode start address */
-		WREG32_SOC15(GC, 0, mmCP_MES_PRGRM_CNTR_START,
-			     (uint32_t)(adev->mes.uc_start_addr) >> 2);
+		mutex_lock(&adev->srbm_mutex);
+		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+			if (!adev->enable_mes_kiq &&
+			    pipe == AMDGPU_MES_KIQ_PIPE)
+				continue;
+
+			nv_grbm_select(adev, 3, pipe, 0, 0);
+			WREG32_SOC15(GC, 0, mmCP_MES_PRGRM_CNTR_START,
+			     (uint32_t)(adev->mes.uc_start_addr[pipe]) >> 2);
+		}
+		nv_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 
 		/* clear BYPASS_UNCACHED to avoid hangs after interrupt. */
 		data = RREG32_SOC15(GC, 0, mmCP_MES_DC_OP_CNTL);
@@ -445,50 +475,51 @@ static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /* This function is for backdoor MES firmware */
-static int mes_v10_1_load_microcode(struct amdgpu_device *adev)
+static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
+				    enum admgpu_mes_pipe pipe)
 {
 	int r;
 	uint32_t data;
 
-	if (!adev->mes.fw)
+	mes_v10_1_enable(adev, false);
+
+	if (!adev->mes.fw[pipe])
 		return -EINVAL;
 
-	r = mes_v10_1_allocate_ucode_buffer(adev);
+	r = mes_v10_1_allocate_ucode_buffer(adev, pipe);
 	if (r)
 		return r;
 
-	r = mes_v10_1_allocate_ucode_data_buffer(adev);
+	r = mes_v10_1_allocate_ucode_data_buffer(adev, pipe);
 	if (r) {
-		mes_v10_1_free_ucode_buffers(adev);
+		mes_v10_1_free_ucode_buffers(adev, pipe);
 		return r;
 	}
 
-	mes_v10_1_enable(adev, false);
-
 	WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_CNTL, 0);
 
 	mutex_lock(&adev->srbm_mutex);
 	/* me=3, pipe=0, queue=0 */
-	nv_grbm_select(adev, 3, 0, 0, 0);
+	nv_grbm_select(adev, 3, pipe, 0, 0);
 
 	/* set ucode start address */
 	WREG32_SOC15(GC, 0, mmCP_MES_PRGRM_CNTR_START,
-		     (uint32_t)(adev->mes.uc_start_addr) >> 2);
+		     (uint32_t)(adev->mes.uc_start_addr[pipe]) >> 2);
 
 	/* set ucode fimrware address */
 	WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_LO,
-		     lower_32_bits(adev->mes.ucode_fw_gpu_addr));
+		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
 	WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_HI,
-		     upper_32_bits(adev->mes.ucode_fw_gpu_addr));
+		     upper_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
 
 	/* set ucode instruction cache boundary to 2M-1 */
 	WREG32_SOC15(GC, 0, mmCP_MES_MIBOUND_LO, 0x1FFFFF);
 
 	/* set ucode data firmware address */
 	WREG32_SOC15(GC, 0, mmCP_MES_MDBASE_LO,
-		     lower_32_bits(adev->mes.data_fw_gpu_addr));
+		     lower_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
 	WREG32_SOC15(GC, 0, mmCP_MES_MDBASE_HI,
-		     upper_32_bits(adev->mes.data_fw_gpu_addr));
+		     upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
 
 	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
 	WREG32_SOC15(GC, 0, mmCP_MES_MDBOUND_LO, 0x3FFFF);
@@ -538,25 +569,26 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev)
+static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev,
+				      enum admgpu_mes_pipe pipe)
 {
 	int r;
 	u32 *eop;
 
 	r = amdgpu_bo_create_reserved(adev, MES_EOP_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &adev->mes.eop_gpu_obj,
-				      &adev->mes.eop_gpu_addr,
-				      (void **)&eop);
+			      AMDGPU_GEM_DOMAIN_GTT,
+			      &adev->mes.eop_gpu_obj[pipe],
+			      &adev->mes.eop_gpu_addr[pipe],
+			      (void **)&eop);
 	if (r) {
 		dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
 		return r;
 	}
 
-	memset(eop, 0, adev->mes.eop_gpu_obj->tbo.base.size);
+	memset(eop, 0, adev->mes.eop_gpu_obj[pipe]->tbo.base.size);
 
-	amdgpu_bo_kunmap(adev->mes.eop_gpu_obj);
-	amdgpu_bo_unreserve(adev->mes.eop_gpu_obj);
+	amdgpu_bo_kunmap(adev->mes.eop_gpu_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.eop_gpu_obj[pipe]);
 
 	return 0;
 }
@@ -727,7 +759,7 @@ static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
 	uint32_t data = 0;
 
 	mutex_lock(&adev->srbm_mutex);
-	nv_grbm_select(adev, 3, 0, 0, 0);
+	nv_grbm_select(adev, 3, ring->pipe, 0, 0);
 
 	/* set CP_HQD_VMID.VMID = 0. */
 	data = RREG32_SOC15(GC, 0, mmCP_HQD_VMID);
@@ -842,8 +874,8 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	ring->doorbell_index = adev->doorbell_index.mes_ring << 1;
-	ring->eop_gpu_addr = adev->mes.eop_gpu_addr;
+	ring->doorbell_index = adev->doorbell_index.mes_ring0 << 1;
+	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[AMDGPU_MES_SCHED_PIPE];
 	ring->no_scheduler = true;
 	sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
@@ -851,10 +883,16 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 				AMDGPU_RING_PRIO_DEFAULT, NULL);
 }
 
-static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
+static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
+				 enum admgpu_mes_pipe pipe)
 {
 	int r, mqd_size = sizeof(struct v10_compute_mqd);
-	struct amdgpu_ring *ring = &adev->mes.ring;
+	struct amdgpu_ring *ring;
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		ring = &adev->mes.ring;
+	else
+		BUG();
 
 	if (ring->mqd_obj)
 		return 0;
@@ -868,8 +906,8 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
 	}
 
 	/* prepare MQD backup */
-	adev->mes.mqd_backup = kmalloc(mqd_size, GFP_KERNEL);
-	if (!adev->mes.mqd_backup)
+	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
+	if (!adev->mes.mqd_backup[pipe])
 		dev_warn(adev->dev,
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
@@ -879,21 +917,21 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
 
 static int mes_v10_1_sw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r, pipe = AMDGPU_MES_SCHED_PIPE;
 
 	adev->mes.adev = adev;
 	adev->mes.funcs = &mes_v10_1_funcs;
 
-	r = mes_v10_1_init_microcode(adev);
+	r = mes_v10_1_init_microcode(adev, pipe);
 	if (r)
 		return r;
 
-	r = mes_v10_1_allocate_eop_buf(adev);
+	r = mes_v10_1_allocate_eop_buf(adev, pipe);
 	if (r)
 		return r;
 
-	r = mes_v10_1_mqd_sw_init(adev);
+	r = mes_v10_1_mqd_sw_init(adev, pipe);
 	if (r)
 		return r;
 
@@ -911,21 +949,23 @@ static int mes_v10_1_sw_init(void *handle)
 static int mes_v10_1_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int pipe = AMDGPU_MES_SCHED_PIPE;
 
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 
-	kfree(adev->mes.mqd_backup);
+	kfree(adev->mes.mqd_backup[pipe]);
 
 	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
 			      &adev->mes.ring.mqd_gpu_addr,
 			      &adev->mes.ring.mqd_ptr);
 
-	amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj,
-			      &adev->mes.eop_gpu_addr,
+	amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
+			      &adev->mes.eop_gpu_addr[pipe],
 			      NULL);
 
-	mes_v10_1_free_microcode(adev);
+	mes_v10_1_free_microcode(adev, pipe);
+	amdgpu_ring_fini(&adev->mes.ring);
 
 	return 0;
 }
@@ -936,7 +976,8 @@ static int mes_v10_1_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = mes_v10_1_load_microcode(adev);
+		r = mes_v10_1_load_microcode(adev,
+					     AMDGPU_MES_SCHED_PIPE);
 		if (r) {
 			DRM_ERROR("failed to MES fw, r=%d\n", r);
 			return r;
@@ -973,7 +1014,7 @@ static int mes_v10_1_hw_fini(void *handle)
 	mes_v10_1_enable(adev, false);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-		mes_v10_1_free_ucode_buffers(adev);
+		mes_v10_1_free_ucode_buffers(adev, AMDGPU_MES_SCHED_PIPE);
 
 	return 0;
 }
-- 
2.35.1

