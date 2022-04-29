Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E43C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7432410F897;
	Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EDC10F890
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVy0wfbx0zMk2ZCcdjUOKGmR6Ka2QPGwG0nkZQtQLHdoXo5RPDO7c/qqkdlhlgIVbhTftgPM9glklfH2PMdPzuojqaMkN683GoXDSrqzVhQ8Pn09fGdFco5SzS7WQJFrkehQPUICMyrcYr2H2T5h2FCY+Jz2kzhNqKB2at8ArY2tHqcc4ggMNeaRZThd39uxd/rb4KGjHo4JmOSDNX++GJtqnNtaklYWxVCbH5BwWlUXneO1N12rLAeTKQw3BHjAawO2J1gb4IYj5vrZX37TF03W2D9UzqMfEf3T+I2dE4oYKsrJPblwXC2cOE6PjSPbbmNzeBdLiI4qyeNinq15RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isgURBdCTSPBHe28g+z9ObD/Evx5kwA7V+BwnEPcL2k=;
 b=Ux0pJPgD9c4n4lBw6EDogH8pnwL2t7p786jltnE2VDyZMF+PY/5H9k7HnO54YT3AffxNAHE9Ai3+5BPCvUMhU3vW21I/cDsWU5MyU0Xr0PcuJf5nJyM+/+OIWl1NaKT3YUC5mKBIBNkZhda89SUaTLUdn0oKgu4MPNmVrmGvq+SOGcA171AbTc7OEL85zZCQaZh35M90c6yajkfmaDdfpDjtDRQWStBQm7UfxApOGyzMG+YT15I6AwXxxHJ9V7jZ63oBHZtGXwRi8XAVktYTXDPGbvWL3RVGt5mtK1mLt5rixv3PIfhGesk1zfv8hOWN6XqJyoBaOlSK/pBO5iho8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isgURBdCTSPBHe28g+z9ObD/Evx5kwA7V+BwnEPcL2k=;
 b=l0HnlO8FJHnnrEH/GLSkQGk+lXAZNuZZK4d768cjbrCCvRHjpwcv6hKq2Qp0bvSjku0IOWjh5LypbN9wopcMcLWyjASQWVak8yaqpOuYxEpeF8NxLT5hWfwvrbzWaQmmVSTqFK1i9++XTqy1DhsXHlOIFEwkaGIYNBCVvQdWf8E=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 18:02:44 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b4) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/29] drm/amdgpu: support IMU front door load
Date: Fri, 29 Apr 2022 14:02:02 -0400
Message-ID: <20220429180226.536084-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d72f3e-8586-46bc-6a93-08da2a0a7594
X-MS-TrafficTypeDiagnostic: CH2PR12MB4071:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4071D19B67902D90602FDEE8F7FC9@CH2PR12MB4071.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vLD2mQf6IrmHCe7ZM2N5f9ZlYVeL1Cn+7wAcfvCVXD40Am0i6UEbYsVIfqh+M/YMzu/NTlWogN1/3Cc0xoS4u0oa9nOkTU5nc0xrFgeq29xVxVd04OAkAwhL3bVOI4Ewc7FrqHUzOCJgd26kOPVPAexWCyMwqbImfP8FPO6mKIQw2iBwMdviL4WV4QBPzOI3tcCrUD1tn7xWhf1+PPE0yBzTeimrGfz9BMEl7yqs+GqwcZ9wRlVz9MAlDNatnwITOuXujp05R0jNFkz596KmkQ3eIsWKc9zz116BJbALaH2SsdKrTOTxIQQfheLFrLDjb3ttQ6wL3+tsMa5dMeWksmYtbFzFH+6wJGt3X/dBdM8frgJsFsEiqZ7rcqaRqBxEOVi395pM7QBkt48fR0doug9nO/YsJ0s8iHXi0Qs8yfacZy8o455/9tzn88cck7QzjmgAReq+TKa0RTxhHvGTpgOXaO6nhOJhwk83eMCEYT8/9JlBjILyiz80GDa3yKC0NzYUagQffoiQQxp/TPoZq/X2f8IUtRrXPyEkJQaEwaagENCoenfeZULYUtfk6ulHz+ryGPgDPM8zFPhktCEwPycUSZErpcHbg4A6NNL4c5zs8KXB4BqhDIIHrV/fyn15hZSzYRGsbO9bUZmfnLNfIdsfoBIegCjzXl4ucaxUbwsqmBF8mwQhnkg9IzM3Gfck8FLrQcuQE8V2totoPaRfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(508600001)(4326008)(83380400001)(2906002)(40460700003)(86362001)(36756003)(54906003)(6916009)(316002)(70586007)(70206006)(82310400005)(426003)(5660300002)(1076003)(186003)(336012)(47076005)(16526019)(81166007)(356005)(2616005)(36860700001)(8936002)(7696005)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:43.5015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d72f3e-8586-46bc-6a93-08da2a0a7594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support for front door to load IMU firmware.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ee852bf8887b..8b42d87f55ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2283,6 +2283,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
 		*type = GFX_FW_TYPE_SDMA_UCODE_TH1;
 		break;
+	case AMDGPU_UCODE_ID_IMU_I:
+		*type = GFX_FW_TYPE_IMU_I;
+		break;
+	case AMDGPU_UCODE_ID_IMU_D:
+		*type = GFX_FW_TYPE_IMU_D;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 1c69e182242c..67619090a548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -649,6 +649,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr = NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr = NULL;
+	const struct imu_firmware_header_v1_0 *imu_hdr = NULL;
 	u8 *ucode_addr;
 
 	if (NULL == ucode->fw)
@@ -666,6 +667,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	dmcub_hdr = (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
 	sdma_hdr = (const struct sdma_firmware_header_v2_0 *)ucode->fw->data;
+	imu_hdr = (const struct imu_firmware_header_v1_0 *)ucode->fw->data;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		switch (ucode->ucode_id) {
@@ -762,6 +764,17 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = ucode->fw->size;
 			ucode_addr = (u8 *)ucode->fw->data;
 			break;
+		case AMDGPU_UCODE_ID_IMU_I:
+			ucode->ucode_size = le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(imu_hdr->header.ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_IMU_D:
+			ucode->ucode_size = le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(imu_hdr->header.ucode_array_offset_bytes) +
+				le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes);
+			break;
 		default:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index c6417778510c..127c034202a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -397,6 +397,8 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CP_MES_DATA,
 	AMDGPU_UCODE_ID_CP_MES1,
 	AMDGPU_UCODE_ID_CP_MES1_DATA,
+	AMDGPU_UCODE_ID_IMU_I,
+	AMDGPU_UCODE_ID_IMU_D,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
-- 
2.35.1

