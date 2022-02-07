Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3AAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14B410E2D1;
	Mon,  7 Feb 2022 16:34:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3AD10E2F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs1RbEtJCDlp69fG//cwXAktyOBmO71zYeI57Vha3o6gxTbyarW01+rGfy5TW+ctdhqxYuEP6ERc84DqzjZzoU6jbGKo5+zqRWlMtIzNP2gca56DkgXL6CDJLWgQppfLYLQeggOSl8kiBuX9YLmTeTgmdQfG6MempWdbv44J1LoolWnf+E1nHiVNO+PLr1ByTlCIVJ/L1DSymzeVgnZ28L0iwMHb51zXkkG+uz38T498OEPmYCzYAEOFloBlKEC3/ewYuiXBgBs8VUgGjtm/zxzB8duoCJV3Z73TJpZ7Tst7XgWUIUpmjrf0+DwHJNCJ7D1jf+ir8HV7QbV15CZ9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DL/HEBXmyOle9JgV4rhNleGjLLX10O00Yc5An3DCjU=;
 b=RD8Nap3/6jLdFp/rJv3rVczKo1gDSY47Xoe2h7N96Z/0UsAm2p6LM/l1nQ+R6lqCb2+FP8rW8Uz2ToRaTHaJ5z/aVDJblBCx2TMHC35VLenoLcIe06WvWD1+2q+4XeFP/pJbygN3zj9YqmEX1qVeiLTt+I36LekySK3DJvLamQgCleY5yo6ZgDKZ++GwjhFuq3zKSCmyXUWNHpGlKxkRrkrfZCO60gR1KC5hZ//Wah4Wf9KQ4Ea3G7GKMJh070zqnXV0NfSGN54l3v1ooE4wrjIcW+u0lOK98cgjTZ+fB87xyofG6DuJoigBVRXgjWKUvrNmFrmcpV79Th4NXOh39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DL/HEBXmyOle9JgV4rhNleGjLLX10O00Yc5An3DCjU=;
 b=kj5NVkhYBtU0qRpho2jSDvvVnuGWIwpvm4fJ9V0P32qypCmYZ6wHLAoL4retKMIs0j+klbWt6K3O8ctHWPiYpnwYRzV8z4QZL2HAD/GUdd8uWdEW1pIWbGxeF+g78Y+J/O4syXbBTU7QU5VnvideCA2yJGGfhfST3XOSLaOt3Ng=
Received: from DM5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:3:151::34)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 16:33:57 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::11) by DM5PR19CA0024.outlook.office365.com
 (2603:10b6:3:151::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Mon, 7 Feb 2022 16:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 16:33:56 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Feb 2022 10:33:54 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amd/display: Basic support with device ID"
Date: Mon, 7 Feb 2022 11:33:43 -0500
Message-ID: <20220207163343.39557-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207163343.39557-1-jdhillon@amd.com>
References: <20220207163343.39557-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b348d9e-03b0-49f4-1dac-08d9ea57a31e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3363:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33637296C6BA4539089D38B0FB2C9@BN8PR12MB3363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siRuMCShLfqjXjA3B0+zXLQ5KhGUC0SOYgWPDz/gDduCkaV1ie04srOyurYP3r5/pyDFaSA2N1+otedZ2LmTzRiXLcs9Db4ClXg0llwb5kZ/IDVI8M8OfrnnoZWQm8zoK8JCACNYyrGGcjOO/01prj1+E9w+G/+0U4PbTw5dXH1ieBzT6EAwQjau1AJrUf/oNyX4bPFnfqeMz1x5M3UobX9dFAbeRanAs15PPKHRwNVq7A+NoPcHBRbW7k9kY2JR5N+J6aD4A/0W+mWdqixwg8Ufo8nJ0T9GHG+QE4pnlgGE3ZMsKX2eqvjBK1w36hyteOHI1/aeFLfXgvH3kTbAVTME+ra3VFE5mpErfVjKED7affhINxKI4aNQxhP4vnk+oXtsmGMl67lkaYVl5xmP1nm7/HTtF7Ub8yNiM6TkocZd/dHPZQnE3d5O3u0Eo8qYjzObIlUxBTw1kUin1ndzfC8/r/uG2TWZR7Y37ytCvv8zDpbHuLx19xdCPep3pmu96geRAhZvyoEhM/78u+OK8zO/C5ekzy9GIPVe0F/9RtdOoo1CNg3EF1K7OXICAXdDacnNwbh42xJ7THwYIcg+hAIJIeNtCLgRMZW9OGWcxSXp9lGcpwzyqdzdMXNEfTIPcVZSHjzzgiunNAEt0RnddMBiDasKwkJuXFmaVvA+a3gH6olCQrrz01mdaG0CVCxDcH0LlsqfA7X8/Z9o2zMQkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(4326008)(1076003)(426003)(336012)(186003)(2616005)(36860700001)(5660300002)(26005)(81166007)(356005)(47076005)(83380400001)(70586007)(70206006)(8676002)(8936002)(40460700003)(6666004)(2906002)(82310400004)(508600001)(316002)(36756003)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:33:56.8256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b348d9e-03b0-49f4-1dac-08d9ea57a31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 733a212f20dfa14fa20814f21526fb180f25fdd8.
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +--
 4 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f5941e59e5ad..8f53c9f6b267 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1014,14 +1014,6 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 	}
 }
 
-bool is_skillfish_series(struct amdgpu_device *adev)
-{
-	if (adev->asic_type == CHIP_CYAN_SKILLFISH || adev->pdev->revision == 0x143F) {
-		return true;
-	}
-	return false;
-}
-
 static int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -1057,7 +1049,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	if (is_skillfish_series(adev)) {
+	if (!has_hw_support) {
 		DRM_INFO("DMUB unsupported on ASIC\n");
 		return 0;
 	}
@@ -1479,10 +1471,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		default:
 			break;
 		}
-		if (is_skillfish_series(adev)) {
-			init_data.flags.disable_dmcu = true;
-			break;
-		}
 		break;
 	}
 
@@ -1789,6 +1777,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
+		return 0;
 	case CHIP_NAVI12:
 		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
 		break;
@@ -1816,9 +1805,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		default:
 			break;
 		}
-		if (is_skillfish_series(adev)) {
-			return 0;
-		}
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
@@ -4529,12 +4515,6 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_dig = 6;
 		break;
 	default:
-	if (is_skillfish_series(adev)) {
-			adev->mode_info.num_crtc = 2;
-			adev->mode_info.num_hpd = 2;
-			adev->mode_info.num_dig = 2;
-			break;
-	}
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(2, 0, 2):
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 13875d669acd..e35977fda5c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -82,7 +82,7 @@ struct common_irq_params {
 	enum dc_irq_source irq_src;
 	atomic64_t previous_timestamp;
 };
-bool is_skillfish_series(struct amdgpu_device *adev);
+
 /**
  * struct dm_compressor_info - Buffer info used by frame buffer compression
  * @cpu_addr: MMIO cpu addr
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 318d381e2910..b36bae4b5bc9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_13FE || asic_id.chip_id == DEVICE_ID_NV_NAVI10_LITE_P_143F) {
+		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 37ec6343dbd6..e4a2dfacab4c 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -211,8 +211,7 @@ enum {
 #ifndef ASICREV_IS_GREEN_SARDINE
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
-#define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFISH
-#define DEVICE_ID_NV_NAVI10_LITE_P_143F			0x143F 
+#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

