Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ECFC71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3C110E5C1;
	Thu, 24 Aug 2023 21:32:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4DE10E5BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7IKNnIqDfDyBP8wB28TpPi5L9IixQsOiISemI6Vye/OGzHlnItIfQRBO8182S4MnvWtfhImkyx4iuLXDfeZyKcnuvIGaW+gxagEEc7Nlm5JqygVBqbTu/WFM1ZJDIUg88ZNYq8AQRzvpnp6dQiIK9BRUM2V1hMYHcWJH+2ZVLNcHtHRy+fKDbGbT72mLAFQ36ajJGIfQK2jetzlNKu6FtXzfRoHuIB6zFtxDuRkGsJsmSrmL1JX+JZqJPvfdMki7738/BFPMgSqdkKbED6+GM9dn9bTkMSwjQMVl/ynUUI54pJnz4nMxPYlyklyXIMZTEvp+0jLgdrJLfsBH4DQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO2boHg1XMvkeMbu+FMgxz7IwjuwWlBn/81crwwkMpM=;
 b=Pty0ovpRFNmgtNRtTkWgjpwA+Pdt1ITX/YJzpY8tsiajDQmR+1vJW95Yd/Py8AMCSyuU0lJreF/GHQz6LvE420O0llhImug+Yj/m/Ef0FLharigj1/JMKTfP4fyFK9KnvQ3/SIcORwGDJ7Wg3AWtesLUvrz/lvJKd6YkA/mIa4yDYtCelPJsMVq82yuahOmKlwco6X+DoBaDWSybdza21Mjb3ZCvJ3cL6d18yKS3G058bAai8e1tMfSKMUsOu/2WhLXqTSGfyNDNEe+H8jrKvk5laHsPf7OM2TUhl8DTOkw4H7Y0GJE7IKcO6xvVCdrVKxCYk0GggtG4bzo/UzCClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO2boHg1XMvkeMbu+FMgxz7IwjuwWlBn/81crwwkMpM=;
 b=lnr5V8zFCX+tuq6fWqYTfbRDtRF9fJA4fY9sE3S0ATx+KqJN+MfpI63UFWSWpd5hoDz6SJSB40kAsjwVjzDntgfsSMSDi+BNN/2h20LRibfPX1c4LSnU2mkSr903OxHvXyHCVZfDAEol1lugQCEXa59nJfZh1jGFBZsTM9u5jHk=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:55 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::50) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amdgpu: add PSP loading support for VPE
Date: Thu, 24 Aug 2023 17:31:24 -0400
Message-ID: <20230824213127.2725850-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM6PR12MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adb0601-b8b4-4cca-8842-08dba4e989a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mXGKW+gSk2H1sNhQ0WbuH+jt0hMgk/M/HINs3N39+UQfy+crzFfKslT9HZKvuuoNjb0bTiCNdWpqxgPNIcRFHaOr4dG2kX16yas5SknwJkeVq7QFFQp4ZbpFmzOg1uoG/RKcsPfnCrtnFQ7t66KXLjhPY3z15oQKge2vHJccg0s9VeLReMS1Ky+nEwJRtFGQMkdSo9nN2iBWun5p/zMkeCJIrsiS7eu0RbC09Fl421ppHZWD28eo6vyR1Eh9ndBa9dPhdS25Ebz9A/tdaCI+zEhp55/8Nf0+UPPTPWjv/4XrVwezF0TRVFGgL9U7aT4ZBFahXXW2WNAA4BY1RGe5bZfBXirDEfcKkIQ8qJNNylHwkxULc53gujlvN68bm9S/ALMiECwSfigUEQAp2a8di/KeEtL+jC9PvRfEfXo/yF54su/eu6/R2iotG3C34TrdBHdBqkprpUHEHco3sTAG2sGmEdw4f7cFjViCppeOgJ0e7PSzyBE6YLIijWn3z9QE2m2nuKTSxyA90WE6RsM2Rce3r86SPQ12DZgZsqXejhYltxK6lqXD65KUBvOU1ieDhE/zZCI+vVzmEa8N3JPU7UaKKL4CAWlTALWf8BZealL6s5vx60nlx3HBNnKIHwRYCeUgFzkR91nCh2vF/Wrums1GJoPxmXjIMOqDl1FrB0gT4PlV1W6bp/XMAQwvNa2HuULTk9tF6ZC+WTaHBBubHmErF8Pc5ry4NoPiPDwnOc+caBsN5MQYeRxVvETZjbr+lU54MLTOLgNsWLcfHRAJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:54.5025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb0601-b8b4-4cca-8842-08dba4e989a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add PSP loading support for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c   | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 75be1ca6155c..e3b52f4436a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -749,6 +749,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr = NULL;
 	const struct imu_firmware_header_v1_0 *imu_hdr = NULL;
+	const struct vpe_firmware_header_v1_0 *vpe_hdr = NULL;
 	u8 *ucode_addr;
 
 	if (!ucode->fw)
@@ -768,6 +769,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
 	sdma_hdr = (const struct sdma_firmware_header_v2_0 *)ucode->fw->data;
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)ucode->fw->data;
+	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)ucode->fw->data;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		switch (ucode->ucode_id) {
@@ -950,6 +952,16 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(cpv2_hdr->data_offset_bytes);
 			break;
+		case AMDGPU_UCODE_ID_VPE_CTX:
+			ucode->ucode_size = le32_to_cpu(vpe_hdr->ctx_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(vpe_hdr->header.ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_VPE_CTL:
+			ucode->ucode_size = le32_to_cpu(vpe_hdr->ctl_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(vpe_hdr->ctl_ucode_offset);
+			break;
 		default:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index f573a44d5d87..a84e03a9b0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -56,6 +56,22 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 	adev->vpe.fw_version = le32_to_cpu(vpe_hdr->header.ucode_version);
 	adev->vpe.feature_version = le32_to_cpu(vpe_hdr->ucode_feature_version);
 
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		struct amdgpu_firmware_info *info;
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_VPE_CTX];
+		info->ucode_id = AMDGPU_UCODE_ID_VPE_CTX;
+		info->fw = adev->vpe.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(vpe_hdr->ctx_ucode_size_bytes), PAGE_SIZE);
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_VPE_CTL];
+		info->ucode_id = AMDGPU_UCODE_ID_VPE_CTL;
+		info->fw = adev->vpe.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(vpe_hdr->ctl_ucode_size_bytes), PAGE_SIZE);
+	}
+
 	return 0;
 out:
 	dev_err(adev->dev, "fail to initialize vpe microcode\n");
-- 
2.41.0

