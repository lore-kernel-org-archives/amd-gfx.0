Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE1AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD6010E9C7;
	Fri,  4 Feb 2022 18:44:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C2410EADC
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5ScxOwjkTUMR8mlBAZAXIy5ybbIAaX/34nAuNv83Dmx6FtfvBkY1wf9O6Yb0UBIUwfirf5YtlbMNGWJFquvNj0OYUX5R9jySqJlgaeThUXV+GGFY3O0gYk2A55V7ouwL+jBEyPMw4pSmF0ymmeeMUpPjNIiMghS0dgu21OCRziiWCHx5mouowPp6/qqfYDT3aNLn2mLLF86RjOGD4sxRAOP+zAitvaNtm2XnQ4jcCIhLBh1PpH5WvO1VhqiHB5m98yia+PzIRzvbXdUMQpCGCsCPJXts8pZUbQyr6eSEWvATXquodCFqkzf8+ltYfX8dnMUFpB7f7VvuTFcSf53pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPz6/v1nrQEqZHWm9AfNH0IyVN3ueen5WHGpzV3WnnU=;
 b=Ap1qEmpOnnryyhjl5lO2iI877lsA5grNhON/y3DqzUphKNzIl5U9esc+/Pdmu2EyO14WilyEA5ZId5NzhLd7sklLCOE+1zV/pXH5/xPsP56d5TxA/6bEpSuIMfga4U9/SYZUnvJZbwpm5QQoqn8Uq8yPk1fE5O4J9NWeJ7bBz1eYG6CGl68QYCwrNGe5yzC0tBzNVQQOPoisL500Hs90Rex/JfZvfPoxS7G2b5ovMV9G89BZgd/1PmYV+DUkECxOgyUuSs698JjJnA5G58po6nw3sdSYm51LH8i8cOFlLgIIOmmFpvf6Ij7l5/RLEECLvqn/3uOK6kvlDyf2+lIeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPz6/v1nrQEqZHWm9AfNH0IyVN3ueen5WHGpzV3WnnU=;
 b=TPmto9ryc7IoYLUaR/SKqDvKgrNUx3DTghrOzOyeBeiLprJwRLKplf6xzIZofFt45vPY9J8KZJzpL0p/04H+HQK8lzAKFllhe9shxfp5ueSg79QjFiUfh3DYlEIJdKf/DWL83cpiLXus+VyTPhA8JYLsucCRcgttL/TzqXvPnus=
Received: from MWHPR07CA0016.namprd07.prod.outlook.com (2603:10b6:300:116::26)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 18:44:18 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::82) by MWHPR07CA0016.outlook.office365.com
 (2603:10b6:300:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:18 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:15 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: Basic support with device ID
Date: Fri, 4 Feb 2022 13:43:46 -0500
Message-ID: <20220204184355.91198-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204184355.91198-1-jdhillon@amd.com>
References: <20220204184355.91198-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c197ac-4196-4e83-a5a2-08d9e80e59c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32125EBBCE4C8FACCC99C5E2FB299@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXi8TrLxicsqL5gyF//b8g0lzPFAjb/OC6GCuMoqzaaH/NlLFH5birCv1OafgMf35FgEL97IvY1It8c3m127sIMEsPeGat39wSgbviHD9kYxELepH7Zo2jyYZiETKqhbbTdP18zcfDIQem90baYqRWSz+kn30wXBYLJexCpEitR2adovJflw7DCJZWvCKOsFUdENTDEwp+E29PyAc8PYGuQlGQNsBnQtLmcJPNd78wksEdnsWwmk4IbK38pPq+i0URjUiEpayRlP0DYzYVEaBlnOyIZCCr8okTIj2uF7fuMf/+36BG2ztTO6U+cxneAkufZ64Y8THtXhSuY9HXdozQPoM4qwejrzYYYeXr+MbGi2k8V0xWZwkK6eJFqR3CbX3jV/4/LRbp3i28TsHZedbwavo+DTYUbJxuSOA3m9dzj4zGmF1B3XYy+Gj02Blf5NROAOycUpog/KWZrV2dHO6a8GKt3on/TFST8GNo1KbEz4fSio4l+UjcA1hovRRAjFGE6Zi5mHME4AMYrTgZV+ua81KqPmf1Hjn3DdLn3gC1ggXGr+MmyBB1XdEVLJRFKamLD4uzthtRy/DmCOaRkH+Nac5v3YD7E7h1Uozf3RkTCiKPbsrK4FVYTMmoDQGYfOkhbWNgjZ6Txk7cs1NeQhPJ4LQt6cEAeiWm1w7U+yvoZjp34Kq2x7qFEC9Rs6AYVYoWlk8MAEoGU72JgzULXx1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(6666004)(2616005)(70586007)(36860700001)(316002)(47076005)(336012)(426003)(83380400001)(5660300002)(6916009)(186003)(8936002)(8676002)(26005)(40460700003)(4326008)(508600001)(1076003)(16526019)(54906003)(36756003)(81166007)(82310400004)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:18.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c197ac-4196-4e83-a5a2-08d9e80e59c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
To get the the cyan_skillfish check working

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 ++-
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f53c9f6b267..f5941e59e5ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1014,6 +1014,14 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 	}
 }
 
+bool is_skillfish_series(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_CYAN_SKILLFISH || adev->pdev->revision == 0x143F) {
+		return true;
+	}
+	return false;
+}
+
 static int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -1049,7 +1057,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	if (!has_hw_support) {
+	if (is_skillfish_series(adev)) {
 		DRM_INFO("DMUB unsupported on ASIC\n");
 		return 0;
 	}
@@ -1471,6 +1479,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		default:
 			break;
 		}
+		if (is_skillfish_series(adev)) {
+			init_data.flags.disable_dmcu = true;
+			break;
+		}
 		break;
 	}
 
@@ -1777,7 +1789,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
-		return 0;
 	case CHIP_NAVI12:
 		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
 		break;
@@ -1805,6 +1816,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		default:
 			break;
 		}
+		if (is_skillfish_series(adev)) {
+			return 0;
+		}
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
@@ -4515,6 +4529,12 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_dig = 6;
 		break;
 	default:
+	if (is_skillfish_series(adev)) {
+			adev->mode_info.num_crtc = 2;
+			adev->mode_info.num_hpd = 2;
+			adev->mode_info.num_dig = 2;
+			break;
+	}
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 0, 2):
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e35977fda5c1..13875d669acd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -82,7 +82,7 @@ struct common_irq_params {
 	enum dc_irq_source irq_src;
 	atomic64_t previous_timestamp;
 };
-
+bool is_skillfish_series(struct amdgpu_device *adev);
 /**
  * struct dm_compressor_info - Buffer info used by frame buffer compression
  * @cpu_addr: MMIO cpu addr
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 9200c8ce02ba..54ef83fe5a9b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -259,7 +259,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+		if (asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_13FE) {
 			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9df66501a453..8a199d661a66 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+		if (asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_13FE || asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_143F) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..c25bc4d9cd4b 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -211,7 +211,8 @@ enum {
 #ifndef ASICREV_IS_GREEN_SARDINE
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
-#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_NAVI10_LITE_P_143F			0x143F // ROBIN+
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

