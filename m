Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0944BC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEA910EEBB;
	Sat,  5 Feb 2022 04:33:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D20E10EEBB
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvYhg7SRv2SlK6T5Vi1V7/hZJEPPfiFtAaAoFmnfb+lvaLFPuzvfdaUEoXR7vIGn0WWlOybO+aZPxZ2A+OiWdlhklrChJayWuzACroWixGqdxMIBUtwX1mvccWkhwNLUQssa1X2NLl11b0atsHuJQYdeveHNdSMewAYrmon+jGsZVakkGce3gXq1LO41wr3CZzqwnAWRo4y7TpLiYcdtOAlKh8K13xbT7VJ/MFkpHeZkbI4otrWcebfd3TbeuVdz6X0DMcEoMoVXvclc8WiTj2i0DDLAJnTMjz0k9ib5ehXcpCtITisEOoL9SicaLNfYvBs3DhqlO2UR2pkJV4NCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8jrGdcWRcyueJoK1GToS/dFcsP3q6brjdQmiKyfSXY=;
 b=Ssj+y7vxgRfHXGqebRyAA56yRt1oN10lyo5oP4A5AUq5n0f4x557s995WUcz/sP01HbCId5KNGC29eu8lMm/76jUGYjuoIxjX3tvIEBSV4rux0ezDU022tUUUJg47ddd/keIcpitK0W7FoVy/xaASeOFwCgoXyt6hmUhm4Iz0u8WwQEgzQqXdOaawze05CJCLyCeHYrP22iE+8iBJLQCj+dfuMLGWpq2obJJI6+Vgwi+6/4pC44B/EaX7lPoas27/GSeMNMGFA00+nMI42m8/DoaBe4BlYk38K1+X8Zqu61lDmBsEuJtplgu8EWAay7e0GoRPS4LFNVq961s5dh+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8jrGdcWRcyueJoK1GToS/dFcsP3q6brjdQmiKyfSXY=;
 b=aK6qR01uKtOXS/drPmGoa8wonU2EYL3kWOD5frwb1QOH/dRIvR0wFDk0GxnV0r3H5NRl9QKqvrfSdp+ViRR/svv6fXvSy3vYLGc6O3yk0h1aZkG77mvoiXyFJ7AWykf2MYDr+NfIKP1Nf+l2m0lfSGQlqhQEZERMImjO+C+Y7oM=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 04:33:42 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::aa) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:41 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:37 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: Basic support with device ID
Date: Fri, 4 Feb 2022 23:33:10 -0500
Message-ID: <20220205043310.165991-14-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d87dfa18-bde2-4d99-5fd9-08d9e860b01f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4142:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41421EDAEFA16CB23512059AFB2A9@MN2PR12MB4142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Hc8C3imj155s5fr4NwvLi8BmXOCUja2VzjH84kjDQmo+c/5wd5GT6+BGzJPcbPB/x1owjyJSAqheAjW1TN0adqQvV1Zx2XAMQhWxDA1/4RidWg9ywRxXMeZj4+h9yJlVet59NX96iucynxGD1xUP5GNE0y8hEybxpxEcABEimpxdyNl/8YivULPo1QrtanH14R5cT5xIcjNP71sfnF8b96tGHEBuNOqmzF4LZN+U+ofLg0xRqbdx01jIOITzkcw9FkNWVovKuwTEWX06mbz8fheVREG/Rb0miBWpUih7EUPxZ4mHtkxv9dI4Ns9KnumCVNJRHm7mWydV3W9oD03VwKq4S+/cJ604EGSV6hUBewPZcbJRYd5wCvlBgNNTssjD3TT0VT+dt7HDBNygqffnIptPPh29RiqDevlt2mHZjLJvWa91k6UvTy6JltcGkDUQN5HZ/7ZT1YRI/92suT+oqwQ2MtQ7i3qyRI29LcfU62+OhuJvQbGvH238KrjAREF+Yh4fPuNjchmvMjXZaqARY2OklAAuFgRMwJ3vGTHz+5YPErwHhbaYXKXIlM4rgn3LTfKr+Zf02lVe39gJUvUwLKRsRa8fOYyO7ByT4j/UxqTRu1kcK3HirDHXgP2kSN2U87a6G62e9PB4G8f6a1a18MrW3sz90vtGlDs1TXfr2yPKkmHDSAw4Irni06PNrFelZuhCzD/cECJKdXzWTuSYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(40460700003)(508600001)(336012)(47076005)(36756003)(186003)(16526019)(26005)(83380400001)(426003)(36860700001)(54906003)(356005)(316002)(8936002)(81166007)(2906002)(4326008)(6666004)(6916009)(5660300002)(8676002)(82310400004)(70586007)(2616005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:41.7111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87dfa18-bde2-4d99-5fd9-08d9e860b01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 ++-
 4 files changed, 26 insertions(+), 5 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b36bae4b5bc9..318d381e2910 100644
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
index e4a2dfacab4c..37ec6343dbd6 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -211,7 +211,8 @@ enum {
 #ifndef ASICREV_IS_GREEN_SARDINE
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
-#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_NAVI10_LITE_P_13FE          0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_NAVI10_LITE_P_143F			0x143F 
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

