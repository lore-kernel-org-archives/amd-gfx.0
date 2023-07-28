Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DDAC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6644E10E655;
	Fri, 28 Jul 2023 06:17:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C5610E655
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDpycpsON78X1+8ehV2a43THzQoxkTfIifsDZIvn7JKc/6324VfBAwSr2uQMJ8DIwmUiJRkzcQd36VK3S2rHyVV37LeIrGfWiin/xLPPvsItgVNlBGI3PRE2UG/kp4Z1f1bL34zFUWlDEEsmpIRpjf90wpaLvB/dO//eMp856U00YUzJhk5A9XtEswprtPEnGZZ/q750KgKLF9B7UVPNG7Gg7jhhdaam6OMChJZ7eKJSaTRqqES3CP5kYNCCIUqGYqpEdm9NOUiZGBpKn7kgsqK+C6Tg3ikQBo7Hr/6y6zIqw5bxKoisYaJOstUTgTW1U6xhvZOJwxq8HzXgNjLUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enKi6Fr/1bmMhOpMFkQUajZ7ZC8B3VtOu69jpNQceJU=;
 b=OTm7dyWc2Hd+tvSMrT9sj7akrEh7fDZeyXHhJC8s9Bji9f186k3c46WV35bwBRcs3CbSjqXZyfuvjkpLF8Q1lgH3sX+cV5Xperaz1Y87Rli7XC0krUvWvDFBevkAMvkHF90Z7FbozzaVhAzkNq1z/pVM3NoxW3ztZ4N1lX1bB/eN9SjLhQixR2cw2M4v+SKTLCLbpjLi4g7LGBFFc85EKd6+rlMf0f4m6W+xnXDLOgUsvmQa+lBaIGhiQitT4N7HCIoJaq8Dw48y0WYdPZHDJJXdquvBJIrTPIN5z2vza0av2zTL3ezp+zVqNRDOda603Xe3L+d3Bj6D1tZvt4YqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKi6Fr/1bmMhOpMFkQUajZ7ZC8B3VtOu69jpNQceJU=;
 b=FxYdSksdd3HENORnuNfpqjewbc2BhOkK/7mDCkMFT2Pxir6hEGN3klOFhcE/tGnk+/GRNKlpJHNUvw4wIbbIt7BnLmlXVR+EbS8cS937RhC/lwhXUiVIC2pJzkvpk50PBIENq83n9WL8nUoKha/1PEk1Bc6wvrD0TkTx3Zxdq14=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:17:14 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::96) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:17:13 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:17:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdpgu: Cleanup amdgpu/amdgpu_cgs.c
Date: Fri, 28 Jul 2023 11:46:20 +0530
Message-ID: <20230728061620.2694890-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e71ec53-7f6e-466d-3941-08db8f3248cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dfv4ZfwxaKbFaNJ3hJWVXpMuJRGjHukiKF/nssXipiXUIkiqQUmrFpBYr/5KgmJ9HTHyTCv/qd21CK/oggsPcrr45Sc8DHGLP5gS1IToXNJA/D1I4mf5dZ64ElYqm6pXrxcTUZZEdOHbYDqmLPy8Z0hUmk1bXHlnt1gPubzJTdZnwu5/BXfr8Bn2bPbeOIzNfGfZeLbuGszWR1x/FmI2XdTIwLrBZHFAv6h8zbke0Y8p7DcmNkUCj81it6DtKzyuoisvEC/O48A8nigPjeLqwVQcaLaoGUWJQqTJn9PCefGHKbge9kmkfzVYE7B7dy4PftkAcaBpFRcwfiB8Uo6szHGBptXvmqjqefAlYVeM6DqU2xUp9mXHrNVY3lznjiZwdocgSZKHcBDCfm9Jq6r4/No6ZqX4GP+atCOssN6ZHjnWcuRV1JEr1rd0XiUuZgelKArA3KMgLmoizZpKBCOc48Xk4SWLlAvI5Z+QFAbN9s45BaICRgCND3uSieYy30mMYajPRJCOFntK6dW3YOBNEpOP6nSug6gOR10Mswn6mbATppsi+wttxdxm/Vues+Gks3uiBoZ2haQtzBBohXWrNCHd4Mmd4WsoecBvFt0W+w4Ge8AX09r3gu858yDiN4QcQ9Q9roO5/cCKF1SlN6XboXJpvtxETff4o3li4nIq2dgIHRJiEzBCW4xUlmf6QRolPtiquZps5AQUqh58ZsJeV03vQIefJsxqbWsy6MAfYv+3kgLaV+KEPZccEoGtayJMOElIGanmIL3D11jcBDbrJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(86362001)(41300700001)(2906002)(316002)(5660300002)(8936002)(8676002)(36756003)(40460700003)(40480700001)(44832011)(1076003)(26005)(7696005)(356005)(82740400003)(478600001)(6666004)(47076005)(83380400001)(16526019)(36860700001)(186003)(336012)(426003)(66574015)(2616005)(4326008)(6636002)(81166007)(70206006)(110136005)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:17:13.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e71ec53-7f6e-466d-3941-08db8f3248cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

ERROR: switch and case should be at the same indent
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Block comments use * on subsequent lines
WARNING: Comparisons should place the constant on the right side of the test

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 76 ++++++++++++-------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 456e385333b6..b8280be6225d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -41,13 +41,13 @@ struct amdgpu_cgs_device {
 		((struct amdgpu_cgs_device *)cgs_device)->adev
 
 
-static uint32_t amdgpu_cgs_read_register(struct cgs_device *cgs_device, unsigned offset)
+static uint32_t amdgpu_cgs_read_register(struct cgs_device *cgs_device, unsigned int offset)
 {
 	CGS_FUNC_ADEV;
 	return RREG32(offset);
 }
 
-static void amdgpu_cgs_write_register(struct cgs_device *cgs_device, unsigned offset,
+static void amdgpu_cgs_write_register(struct cgs_device *cgs_device, unsigned int offset,
 				      uint32_t value)
 {
 	CGS_FUNC_ADEV;
@@ -56,7 +56,7 @@ static void amdgpu_cgs_write_register(struct cgs_device *cgs_device, unsigned of
 
 static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 					     enum cgs_ind_reg space,
-					     unsigned index)
+					     unsigned int index)
 {
 	CGS_FUNC_ADEV;
 	switch (space) {
@@ -84,7 +84,7 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 
 static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 					  enum cgs_ind_reg space,
-					  unsigned index, uint32_t value)
+					  unsigned int index, uint32_t value)
 {
 	CGS_FUNC_ADEV;
 	switch (space) {
@@ -163,38 +163,38 @@ static uint16_t amdgpu_get_firmware_version(struct cgs_device *cgs_device,
 	uint16_t fw_version = 0;
 
 	switch (type) {
-		case CGS_UCODE_ID_SDMA0:
-			fw_version = adev->sdma.instance[0].fw_version;
-			break;
-		case CGS_UCODE_ID_SDMA1:
-			fw_version = adev->sdma.instance[1].fw_version;
-			break;
-		case CGS_UCODE_ID_CP_CE:
-			fw_version = adev->gfx.ce_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_PFP:
-			fw_version = adev->gfx.pfp_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_ME:
-			fw_version = adev->gfx.me_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC_JT1:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC_JT2:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_RLC_G:
-			fw_version = adev->gfx.rlc_fw_version;
-			break;
-		case CGS_UCODE_ID_STORAGE:
-			break;
-		default:
-			DRM_ERROR("firmware type %d do not have version\n", type);
-			break;
+	case CGS_UCODE_ID_SDMA0:
+		fw_version = adev->sdma.instance[0].fw_version;
+		break;
+	case CGS_UCODE_ID_SDMA1:
+		fw_version = adev->sdma.instance[1].fw_version;
+		break;
+	case CGS_UCODE_ID_CP_CE:
+		fw_version = adev->gfx.ce_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_PFP:
+		fw_version = adev->gfx.pfp_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_ME:
+		fw_version = adev->gfx.me_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC_JT1:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC_JT2:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_RLC_G:
+		fw_version = adev->gfx.rlc_fw_version;
+		break;
+	case CGS_UCODE_ID_STORAGE:
+		break;
+	default:
+		DRM_ERROR("firmware type %d do not have version\n", type);
+		break;
 	}
 	return fw_version;
 }
@@ -205,7 +205,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 {
 	CGS_FUNC_ADEV;
 
-	if ((CGS_UCODE_ID_SMU != type) && (CGS_UCODE_ID_SMU_SK != type)) {
+	if (type != CGS_UCODE_ID_SMU && type != CGS_UCODE_ID_SMU_SK) {
 		uint64_t gpu_addr;
 		uint32_t data_size;
 		const struct gfx_firmware_header_v1_0 *header;
@@ -232,7 +232,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		info->mc_addr = gpu_addr;
 		info->version = (uint16_t)le32_to_cpu(header->header.ucode_version);
 
-		if (CGS_UCODE_ID_CP_MEC == type)
+		if (type == CGS_UCODE_ID_CP_MEC)
 			info->image_size = le32_to_cpu(header->jt_offset) << 2;
 
 		info->fw_version = amdgpu_get_firmware_version(cgs_device, type);
-- 
2.25.1

