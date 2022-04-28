Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF8EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D42B10E64E;
	Thu, 28 Apr 2022 18:45:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310DD10E64E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS8J4TO6RBN6OA11iQffWtEYJQFkoz+MjzGa40/InO4NUY84Vg/kZXX22SrEJZYYXQFu2NUbJqU0LKNQW63YhvGVlnSEtA4IoEYzj9j1odEhG78Fli4SR6E8wEzfhqCLxoKIsyvR3BjREfu853qgUNLAdfmcLksidNAxw8IaTP6gQddD9leHGLymwzjIboCV4sui+wfRoUb4eex7GrriDuWa4yp5Wpuv7wXZ5JFb98qokas/7MK8HmckwidMfq+DIidBYv9fBujUF28Ppr0xH3Tgu2PcTIPJHMJAGtKOl0hIXuiQ8hNMVT0aNBPbLhe4ZZ5sBpicFKztNpGASv0gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX9EcHwcQLHzQoiW5P9K/HgspJeWCRHumlU6rgrAyNI=;
 b=MiYdfwcvJxxbSLwFbsEQp4SR9ZR01TK6JX0HqtJfv3X26ngfX4ZQMUqrXjP/YQYHhBx2n5nkU/vX67wWN+y4khMnz0FHOYs7wnNOVMJ5+C69VyaGL/xZWVDQH9cMuiT0RgOeh/oAj4wxfLB98ZTmUr0L8hnQ4vT+WmeRdoh0dtipnKFuRqfLEAdeDYNB5YlfEAHHXM4f4yfCGgflv2VnAibiQ0Ftm4a6Mr0I78S5VB6xmfavlKeLqD6KzVJP2VDUL78rcL1P19rMbnP4/624RSiyiYIdfoKT4W2prulTgXkh/ODCx1zDZWyBLYhONxrVkRIIUMzl/f73L35VcYzpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX9EcHwcQLHzQoiW5P9K/HgspJeWCRHumlU6rgrAyNI=;
 b=rxOG8nguFI/5nXIDHp/MsDY9bXllIp9ESm4ECpKoIoaFMkEOgtPleUwN2FC72ehQKX0fdBlzOQg39QWnAXtfwHIeM5a0h7Tyr1NDY+xWi36CLU7a8wEjjciwd/Uax93KT48acMjH0g/q13iEbKaKc8cNXYzaKj8Ph17o6mtCcag=
Received: from DS7PR03CA0192.namprd03.prod.outlook.com (2603:10b6:5:3b6::17)
 by CH2PR12MB4807.namprd12.prod.outlook.com (2603:10b6:610:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 18:45:33 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::d6) by DS7PR03CA0192.outlook.office365.com
 (2603:10b6:5:3b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: support print psp v2_0 hdr debug information
Date: Thu, 28 Apr 2022 14:45:14 -0400
Message-ID: <20220428184520.651971-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c654cd05-9e17-402e-ec21-08da294746bc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4807:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4807CCDAE645D7C4861A5390F7FD9@CH2PR12MB4807.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baEPcpcrswye5cgyo+SbyHYPfXY1kpSHWfnw1mq32ywjNh0EjoAkagn7f1Yab8VEVIoCpY2Lurigh5DSWcE7WjFGq4WZQf+JfU3kzlJbjaCmeX014cN3AGhh7+hO2KvJYmByZc1dLeHWfb5L86P3J3yeVpjaUZLDzWtFHu98kneG+CYx0lA/qRanloUvlztizhZQMmiWJqqZW3eIPMLn7/Ylun/Z1O7AV7IDqvjE0CZ/zK4M/lvFx/wwJ0z9Cpx417x/gYz9ki691Vy0Ha0tjyws7VFe+iE+/V6vOdI3zhVy0AaAgEgfRu6M5SLMKF0ucCXwzJNcMtnMp5zsQwWv0qNIdrNH9fGhDZNhkin9kJFXcMAf7BEd3rkoEe9tH68RbQMjS076PDzNdLqMFrRioyQJ92TM1hllEGW2/sHrpjA0uS0czquhpVhFyr0CK7ylrqoB3kd+Dq3B4jhsBJkVKHDbgs0HijGhWmLc4X2/N1H98sFOCOpXaAasejjb5LYSEYoNUY9qdUqnClduxHkQ4nsBVoWrYX51ofuyeijepN5XvLrFe+sY2QNY8MHjY9NLQzffwQ/bu+ZJWEfGIUzZ+WlP7TakzirzJlpWJjuHyIEly6XOqkyY8+fn+1jroGeiBQ7JD0LnEBpR3cZLjwLFOMgi/pDGfDuJ7OvvwicvXM9PfWh8G1CspZStm0cPNtimYXuss3XS2UuSZhBaMXfQ6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(508600001)(81166007)(6916009)(26005)(82310400005)(2906002)(86362001)(316002)(6666004)(7696005)(356005)(36756003)(2616005)(1076003)(70586007)(70206006)(16526019)(8676002)(186003)(47076005)(426003)(336012)(4326008)(36860700001)(8936002)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:33.1456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c654cd05-9e17-402e-ec21-08da294746bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

print out psp firmware v2_0 hdr information for debugging
purpose

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 67 +++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 016477fa2f90..c909446c3a96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -248,6 +248,8 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 {
 	uint16_t version_major = le16_to_cpu(hdr->header_version_major);
 	uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
+	uint32_t fw_index;
+	const struct psp_fw_bin_desc *desc;
 
 	DRM_DEBUG("PSP\n");
 	amdgpu_ucode_print_common_hdr(hdr);
@@ -312,6 +314,71 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 			DRM_DEBUG("spl_size_bytes: %u\n",
 				  le32_to_cpu(psp_hdr_v1_3->spl.size_bytes));
 		}
+	} else if (version_major == 2) {
+		const struct psp_firmware_header_v2_0 *psp_hdr_v2_0 =
+			 container_of(hdr, struct psp_firmware_header_v2_0, header);
+		for (fw_index = 0; fw_index < le32_to_cpu(psp_hdr_v2_0->psp_fw_bin_count); fw_index++) {
+			desc = &(psp_hdr_v2_0->psp_fw_bin[fw_index]);
+			switch (desc->fw_type) {
+			case PSP_FW_TYPE_PSP_SOS:
+				DRM_DEBUG("psp_sos_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_sos_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_SYS_DRV:
+				DRM_DEBUG("psp_sys_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_sys_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_KDB:
+				DRM_DEBUG("psp_kdb_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_kdb_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_TOC:
+				DRM_DEBUG("psp_toc_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_toc_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_SPL:
+				DRM_DEBUG("psp_spl_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_spl_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_RL:
+				DRM_DEBUG("psp_rl_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_rl_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_SOC_DRV:
+				DRM_DEBUG("psp_soc_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_soc_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_INTF_DRV:
+				DRM_DEBUG("psp_intf_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_intf_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			case PSP_FW_TYPE_PSP_DBG_DRV:
+				DRM_DEBUG("psp_dbg_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_dbg_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
+			default:
+				DRM_DEBUG("Unsupported PSP fw type: %d\n", desc->fw_type);
+				break;
+			}
+		}
 	} else {
 		DRM_ERROR("Unknown PSP ucode version: %u.%u\n",
 			  version_major, version_minor);
-- 
2.35.1

