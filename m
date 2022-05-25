Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5651C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C7510EDED;
	Wed, 25 May 2022 16:20:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF4610E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/3gaFkJdlFKaTeeovhDj3FNI2ebV2W9eCvuAVPeWkVK7/+et3OaN2phZSyCxN45E0hUj5KT4/oek/8zJ9ldx4rCPk4eUKUXOohDZoKjNtTi/txhmIkv0LuC82aGBX7TaDeXJGcfrnViSC8VUQBC50bIBLsxO0yoh3nF0NqEvmozzPqGqEDpM8UCRUITCqKPJHhiqm6JuEdrv5sMZ9LZND2ccbfDnqB9caGCopaST6POQtOAyQaLCA4q8mCU3013RWZlACBU7fNBQbcPVVSrjKyaNApBl7I3XOlOpXMohUECQcbofLPKkxLvjQ647xSLw7A3nnI8WCqPNHmAkCDSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4suuu+fNQqerRTTRelYI02O0UpI6/ymuizhKEWDl6Q=;
 b=M5vNcuy3EIkW9i2gfGXezrMBlIZCDLqWbn/WoUWCpZqGRpOW74f6+7qpCJ6P8Y3YwjQbvcza120wqEN9GDWZOUt1TWJpBZQMgzi698vW8GLIlVDdv9TexGDbN0zyMd32ghW9BKqNRthYF+p8oEAZXow6AFbAG+sF4sif2qo/FUpD2KmC2da0EBq3SxPS4bt8zUvquDdppubKiSGXcv8G3KgLkt1zcBd2LtIVMZyLH8CYuxjpSlsccMr+ft1Q2gHtpvo8nfcKQ9mqApGZm5OV/R62492zOmKDQn8q3OPqzrb/qwdSI2aKTUbXCJuVOGQCsLy2+2i/18Hns/e0I/P9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4suuu+fNQqerRTTRelYI02O0UpI6/ymuizhKEWDl6Q=;
 b=CLEF7hjXoBkAHdNby78cChfdfGBR0ezOgBiZM8f1PhuvVtohMPX0mfM9JQ//cGvRiBbQZ4su7Vpi+FSOKK0yQq/xAmzRNdIWsCzV92QTXzws6JUuRq5dQV8MK9lG33umkzR4gt4Dn9ClgwpIq8YUvL9rZBisN4esmAIAweowXIQ=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 BN8PR12MB3458.namprd12.prod.outlook.com (2603:10b6:408:44::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:20:09 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::1c) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/43] drm/amd/display: Add DM support for DCN32/DCN321
Date: Wed, 25 May 2022 12:19:10 -0400
Message-ID: <20220525161941.2544055-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334efe2a-5d31-450d-4dcd-08da3e6a6fdc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3458:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34588EC1FD9AF5A9A0D02D2AF7D69@BN8PR12MB3458.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqX++icG4wXGu9ppLFwwXA8t6NbFHLeLJkLW0vxOkJuvq489ZCWazPO0zEHUNdccrAmtdm+q/1rStt701mF0XBKoosxK1loHPomJ6fbwWdk8Ih2iBo1Jx1Bna4Z3UI1M3kYXOIm7Sd5ATV1qAxVNMY5sNa5RX8fhHRgvVq03eaNJE/C6b2+eMHWQHNzswNvWw939xSzM+5uH0Xmls03gW1r1NxIfxYt2VuB1K35JztQwGplZ+3JamjFtGlHWHj/HbMJDK+z7jOfIxf13Qdac4h4uxKDLzzc+5w6v89A3Y9ewtzlngSxxa4Cbhdq/lKbX2E1WZGZ1QGitlvQbbj9xKUtzYQxI1/s/eQKzY4h/RF5GmmcGeNP8mLt7MKJMxV8sU52roOBj5ydYRxFllJqJWLOulIiMpBP46eUvr57c81pZeYRV2602baWY9w/zm97qLnNDu36woIUHNJPeWF0uBYqplT2YjuNVK03GJ3wU3mTUQ1cAsMyBjfIigo5CxOj34s0GeeQ4WcDF00lRpGqV120GHi+W1L7XHbmrcevcQ1LSxkyS4Av1kzKn3/DXWrPSs0rdAjcHsBHImL3fg6Vz97OscLiZl89drIJXfyG5bF6MwfT2olqRRiILWRU+Nw8BJb+unFQEkgE+b+6R35zxxgGrYefBVDsNC7nWexvc5D9pH52BMfF3ZaBJOCp68J7+/Br8RREPfsMGdRPlgfwx6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(7696005)(2616005)(6666004)(2906002)(47076005)(508600001)(5660300002)(8936002)(40460700003)(1076003)(26005)(86362001)(6916009)(316002)(356005)(36756003)(54906003)(81166007)(16526019)(70586007)(70206006)(4326008)(82310400005)(8676002)(186003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:08.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334efe2a-5d31-450d-4dcd-08da3e6a6fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add Display Manager specific changes for DCN3.2.x.  DM
handles the interaction between the core DC modesetting
code and the drm modesetting infrastructure.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 05f34b46e109..a93affc37c53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -117,6 +117,11 @@ MODULE_FIRMWARE(FIRMWARE_DCN_315_DMUB);
 #define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN316_DMUB);
 
+#define FIRMWARE_DCN_V3_2_0_DMCUB "amdgpu/dcn_3_2_0_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_V3_2_0_DMCUB);
+#define FIRMWARE_DCN_V3_2_1_DMCUB "amdgpu/dcn_3_2_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_V3_2_1_DMCUB);
+
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
 
@@ -1800,6 +1805,8 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
 			return 0;
 		default:
 			break;
@@ -1923,6 +1930,14 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = DMUB_ASIC_DCN316;
 		fw_name_dmub = FIRMWARE_DCN316_DMUB;
 		break;
+	case IP_VERSION(3, 2, 0):
+		dmub_asic = DMUB_ASIC_DCN32;
+		fw_name_dmub = FIRMWARE_DCN_V3_2_0_DMCUB;
+		break;
+	case IP_VERSION(3, 2, 1):
+		dmub_asic = DMUB_ASIC_DCN321;
+		fw_name_dmub = FIRMWARE_DCN_V3_2_1_DMCUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -4232,6 +4247,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 1, 3):
 	case IP_VERSION(3, 1, 5):
 	case IP_VERSION(3, 1, 6):
+	case IP_VERSION(3, 2, 0):
+	case IP_VERSION(3, 2, 1):
 	case IP_VERSION(2, 1, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -4250,6 +4267,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -4367,6 +4386,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -4553,6 +4574,8 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
-- 
2.35.3

