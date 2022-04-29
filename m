Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7174FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B277210F898;
	Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC5110F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFQmQGhu4owhahwny361DTAt55DpGbYJxE4qQr8wttQfCAmNYoN4nXeK+Pc3zA34FMW4pYOS0nbsW+t7utQxlL1AjjjVrqNWQyATapee1JErQ6qEkqmTz9DsEf1+3enL+dTMNpuedF6DEA4DbEjw42lRP3bRJKHsiwHf42hH+mVZyIv1dvXN5vQJQyT3KCr2TXMtvAmhU33gj+mZGvz0Xtl5mJSq97jrm3zyk5mrG3VPjl6xrkaTZFzjLg32apTSfgXMohACfRdOOAXDaCmxDAgevh0MSScrKywkpX5hK7VAME5vJD4DB4Q62b8VKQYCD6UUHA1ARMBioUm8CoHGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/evl4sHjeK8bMgQl9dDK9ExPyxk0pwzn6gKGAj4WGac=;
 b=ZSiep/0gn+L92rcaejsoQGt76eZWmZQV5bGUvPrEDny7MTYyTL2i5Ag50NS3BOpmlyWJEvSpu2aGjoaZnvWanlYRlO/ris9lqxqqredU1hgavsgmcba6ExNXgCv9cuG1JBVd0jfNG0MaKe8Q+7w0XQ+83/jd/Hca+3qH7Vf1Icz2oivsc0Y+vvcV8Nq2W/r5q5+8KnnqoSOI9S8REYlPANIvXcmxU4YuqPKWHJLS9OjJA8/fl3h/OQJDnbJfOobBpTkqxPZBAaheMCdOj2SzbX1h63vBSeoqvTj34V92eJXYzkkgwCTf3RS5RKOkdCTQGrRcROgMXjN7kgP3oKDGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/evl4sHjeK8bMgQl9dDK9ExPyxk0pwzn6gKGAj4WGac=;
 b=J/SpW0b4ND5CB11sBq1lcRX3bBSMkQZEQGFw1p0E3pDNDbiKQam7D40mCojGoitUr+oohav/o9W+j+3MuqnHlnfcR5XYuuFmf4isj0JzmsZ9JgDJIkUJ8NoI/0SvZu3aWxNOG2Iy1wpxXThSUhkvofRE0ovkAuImhR6G+vCKeu8=
Received: from MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47) by
 MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 18:02:42 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::bb) by MW2PR16CA0034.outlook.office365.com
 (2603:10b6:907::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/29] drm/amdgpu: support for new SDMA front door load
Date: Fri, 29 Apr 2022 14:02:00 -0400
Message-ID: <20220429180226.536084-4-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22f4946a-7ea9-48af-ffd3-08da2a0a74e3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4523:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45233B488EE32D25C914E889F7FC9@MW3PR12MB4523.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6kCxCP5UbJIPPhWVJg3YYuJtmpbLxAHvZoqrCuO2m7VIhE341RP8b5IzVfPV8/f9JoW1Bt/JO5lsa9IH9Xf0xPhN522m8Ho3i4SGBA4kflNNz+9549x5l6bs+TnS4B5P8KId8unb6fKcJoDKAH9dMvQVW958mLV0oM8FCM9ttTg3VxZld1SMvZNsKbTvfRPmMRyHrGL38JYZOlMrqb6EfvYO8jQiDkO6QEKNtebEPe7NoKZvhosLnXSsborzyvd0KTLenuvw7KIdloargcnXEwP0Ee/PUVpO4ZgGR2z5H8y5qSZ0l2DjpnYoc9hmH6ogZ+qB1yI3RYLdLKPWbdHzhi5Qy/LM8BFLQhBOSqDnrd5hSZt7sIFyYPP6tKJ/i8+k9OiFxa4nzLhzLWim3SIK9nqIjHgYg74gFp1QcjB4KpnW5NjGgul2MjnnfNuKMLWySwaQZ07GpNZU/0wOQy1eI0zIqd7HqKXSOlctozXxbApfHo5X6WY3eJIgpdySWTXO8QEU6phc0k0y1xa1Bsf/Nc7HEWMtVBX+Pki08vC7GR0jQdDsYYPY62dYkudLZsa9eqwiWyM60z01idrth914xNcVeMtdDsDL5f4lLpSJWTAJBdl7XoWZRygFCAAHvPJhJZdPELpmwJuiOhsgS+Gkz1gmNXZmdzUjPsAJRSEjXV/iUpdSRbPe6GsZsR3/hba/VWKYXgl3zM70QYyqEk77w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(356005)(2906002)(81166007)(36860700001)(8936002)(26005)(86362001)(508600001)(5660300002)(186003)(16526019)(6666004)(40460700003)(2616005)(316002)(36756003)(47076005)(82310400005)(70586007)(1076003)(426003)(8676002)(70206006)(6916009)(4326008)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:42.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4946a-7ea9-48af-ffd3-08da2a0a74e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
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

Support for SDMA v6_0 ucode front door load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4c91efb695c4..ee852bf8887b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2277,6 +2277,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_DMCUB:
 		*type = GFX_FW_TYPE_DMUB;
 		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+		*type = GFX_FW_TYPE_SDMA_UCODE_TH0;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
+		*type = GFX_FW_TYPE_SDMA_UCODE_TH1;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 8cc059482007..1c69e182242c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -648,6 +648,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct dmcu_firmware_header_v1_0 *dmcu_hdr = NULL;
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr = NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
+	const struct sdma_firmware_header_v2_0 *sdma_hdr = NULL;
 	u8 *ucode_addr;
 
 	if (NULL == ucode->fw)
@@ -664,9 +665,20 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	dmcu_hdr = (const struct dmcu_firmware_header_v1_0 *)ucode->fw->data;
 	dmcub_hdr = (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
+	sdma_hdr = (const struct sdma_firmware_header_v2_0 *)ucode->fw->data;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		switch (ucode->ucode_id) {
+		case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctx_jt_offset + sdma_hdr->ctx_jt_size);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(sdma_hdr->header.ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
+			ucode->ucode_size = le32_to_cpu(sdma_hdr->ctl_jt_offset + sdma_hdr->ctl_jt_size);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(sdma_hdr->ctl_ucode_offset);
+			break;
 		case AMDGPU_UCODE_ID_CP_MEC1:
 		case AMDGPU_UCODE_ID_CP_MEC2:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
-- 
2.35.1

