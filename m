Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACE2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F10460527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F10460527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8777B6EAA3;
	Tue, 21 Sep 2021 18:08:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7906EA90
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWxdXTiFp4mYSTCct3uz+Zs2Omsh0ydvsj5G9fuRtJfBMI+7PLWjZqotLvLDCtKHoLH6Wwjv0qiH7vmvQkCjRnC6UFGxZB91/utSxDSPdghDrAhipamlc6Vpp+xk88JFLbKwxXsJk4FjOW0oipiTa5uC8uR9oGtFRUaDc6r+2C175ybYSASVb7erOmw4G6EWSj1e0h7bQE74UZImBl87ATqxbEYUw+O1KLE3btE8psPGYL3SCdK6do7sJ7EbK26h50Tjoso8on+yQvEU+vkU2pMUSSwNvx4CpeMt72jNyEuegt1C5GSzHkOCd6ureUEAyW9m7WvwL+RLpVl2Fi69/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GElFE9BaBnoz7+co8dbCHl7VHbeEuyLq/00vjbKflXc=;
 b=ZCRT/z18BhI7UHqEl6d49RMXRzTacngUG5nR/x5JsnX8L7Vdzng3Xwa0f7X3JmvbKaZfRPwHTwwsqZJHEDgAsMarjsLdbVDQ2rqprq+2tuvZwozRtJ2Pu1vS1TAqsLaPbw0zmA2i/GNQarR49BSPrFOwj+E2UfrqaPor+tqNOKzn344CtdgNCA4ady36o80nbIYsyocA0jFDF6WgjxNe1E+yiToSIvQSiBgZZDUK058n60xvtiW+BfzktokcIOv/EiiEg9uwOJ3ERYxcWYYEgeAHtojAhLIe+fDTSN+SAPWYJerPx9WptIy+q2HgSwBapvBFAMzWZ/bTerUY9PnBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GElFE9BaBnoz7+co8dbCHl7VHbeEuyLq/00vjbKflXc=;
 b=obc3IvycoXtldO9nTvN51MtpAmThjiTI3Rf9CL2PmIfVXMQlFczFf6Jhl4zsrBrTU4Rr9Z5xfmRrOBsC8biYKw9aEnBeixCirHg/CKENCtocJcX3/z1PwX2B0R5f+//uZv32pSUd9kzZ6B+VqMHZb3ubKvp3/R4JOJsZyyIrl2o=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:55 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::f8) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:48 -0400
Message-ID: <20210921180725.1985552-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25c31c1-3b1f-42b4-c416-08d97d2abc65
X-MS-TrafficTypeDiagnostic: DM6PR12MB5022:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5022E623C5EA6E7AF37B478FF7A19@DM6PR12MB5022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Cdsgp+cv4RgaqZ/1yWs59Ul2GcHxNKZ2zESLkWu0t6QwmO06VDCBcsvAfPrlKLFxUPO5Ov5A9SJfOuZsJgzXRYiYUNGh34pp4zbqhNg+b8pbiyLrzjbG5OAESVNM0FF19Y6OZk6ab8TzfDtZ3dtNv96U0xuowQ8y0OnbAhVu8Zw9qENQjwNpt0S8zs46or2NHprfEyeWydn1CH7UIdC1ffIbHzy8VFJ8HhuInArLkqv8UyKpzNV3zeAM61SRZD8Xy0hNaoZSVIJstedUX0ezrq4A5EXfQrPqMj3X2sFAzsNVygbDpmoUXPGQNXnXLommiVpzrSuOW3VhrpEMY5ROtJm0BiSAJPxjzkomRALbXRmXdKerQicKLOkgMBO6F1c5bjOGcUGh81Do3O8UNQe2IVFQ4jrYrMZzBt71ywvWTkV/1kdVNduBLLrszrTj3Uv5tsJ+htVP4xQkPf1RBYFWWvQ3+fR47aeujT9JZZ3isnSv29B50r/fqeJ11oSq4do8smdPKqh5QUTZ1YIZxex1r/rrGcDUazCaWUd+8vUHWNFsL7U8QPkgDlfzHCzgk1j+YqS/8N/p18NQifsWoWf2xyKPuCpRkXIeLr2ZKN2Y6aWAh/ndlpc+Bn4BFrZSGc/4fQPPkniYKVU7QAVtvyIZrCR2gVBqxyunjswBq4J2lmRs19yfLh4T0cIEMQ21nsemF8wbHod76t90pKtS+CyPZaBwgVTkI0It5gFoH3akeU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(8936002)(356005)(36756003)(186003)(26005)(2906002)(426003)(70586007)(86362001)(5660300002)(336012)(8676002)(4326008)(7696005)(2616005)(508600001)(70206006)(82310400003)(83380400001)(36860700001)(81166007)(6916009)(47076005)(6666004)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:55.1730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c31c1-3b1f-42b4-c416-08d97d2abc65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 194 ++++++++++--------
 1 file changed, 109 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 07adac1a8c42..e189d72f08e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1342,16 +1342,23 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_RAVEN:
-	case CHIP_RENOIR:
-		init_data.flags.gpu_vm_support = true;
-		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
-			init_data.flags.disable_dmcu = true;
-		break;
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
 		init_data.flags.gpu_vm_support = true;
 		break;
 	default:
+		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(2, 1, 0):
+			init_data.flags.gpu_vm_support = true;
+			if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
+				init_data.flags.disable_dmcu = true;
+			break;
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			init_data.flags.gpu_vm_support = true;
+			break;
+		default:
+			break;
+		}
 		break;
 	}
 
@@ -1442,7 +1449,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #endif
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >= CHIP_RAVEN) {
+	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
@@ -1637,15 +1644,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_RENOIR:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
 		return 0;
 	case CHIP_NAVI12:
 		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
@@ -1659,6 +1657,20 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 			return 0;
 		break;
 	default:
+		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			return 0;
+		default:
+			break;
+		}
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
@@ -1737,34 +1749,36 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	enum dmub_status status;
 	int r;
 
-	switch (adev->asic_type) {
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[DCE_HWIP]) {
+	case IP_VERSION(2, 1, 0):
 		dmub_asic = DMUB_ASIC_DCN21;
 		fw_name_dmub = FIRMWARE_RENOIR_DMUB;
 		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 			fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
 		break;
-	case CHIP_SIENNA_CICHLID:
-		dmub_asic = DMUB_ASIC_DCN30;
-		fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
-		break;
-	case CHIP_NAVY_FLOUNDER:
-		dmub_asic = DMUB_ASIC_DCN30;
-		fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
+	case IP_VERSION(3, 0, 0):
+		if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 0)) {
+			dmub_asic = DMUB_ASIC_DCN30;
+			fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
+		} else {
+			dmub_asic = DMUB_ASIC_DCN30;
+			fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
+		}
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(3, 0, 1):
 		dmub_asic = DMUB_ASIC_DCN301;
 		fw_name_dmub = FIRMWARE_VANGOGH_DMUB;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(3, 0, 2):
 		dmub_asic = DMUB_ASIC_DCN302;
 		fw_name_dmub = FIRMWARE_DIMGREY_CAVEFISH_DMUB;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(3, 0, 3):
 		dmub_asic = DMUB_ASIC_DCN303;
 		fw_name_dmub = FIRMWARE_BEIGE_GOBY_DMUB;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(3, 1, 2):
+	case IP_VERSION(3, 1, 3):
 		dmub_asic = DMUB_ASIC_DCN31;
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
@@ -2063,10 +2077,9 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 	 * therefore, this function apply to navi10/12/14 but not Renoir
 	 * *
 	 */
-	switch(adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[DCE_HWIP]) {
+	case IP_VERSION(2, 0, 2):
+	case IP_VERSION(2, 0, 0):
 		break;
 	default:
 		return 0;
@@ -3287,7 +3300,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	int i;
 	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
-	if (adev->asic_type >= CHIP_VEGA10)
+	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -4072,18 +4085,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Use Outbox interrupt */
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_YELLOW_CARP:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[DCE_HWIP]) {
+	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 1, 2):
+	case IP_VERSION(3, 1, 3):
+	case IP_VERSION(2, 1, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
 	default:
-		DRM_DEBUG_KMS("Unsupported ASIC type for outbox: 0x%X\n", adev->asic_type);
+		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
+			      adev->ip_versions[DCE_HWIP]);
 	}
 #endif
 
@@ -4171,16 +4185,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		break;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case CHIP_RAVEN:
-	case CHIP_NAVI12:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_RENOIR:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -4188,6 +4192,26 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		break;
 #endif
 	default:
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			if (dcn10_register_irq_handlers(dm->adev)) {
+				DRM_ERROR("DM: Failed to initialize IRQ\n");
+				goto fail;
+			}
+			break;
+		default:
+			break;
+		}
+#endif
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		goto fail;
 	}
@@ -4338,38 +4362,43 @@ static int dm_early_init(void *handle)
 		break;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case CHIP_RAVEN:
-	case CHIP_RENOIR:
-	case CHIP_VANGOGH:
-		adev->mode_info.num_crtc = 4;
-		adev->mode_info.num_hpd = 4;
-		adev->mode_info.num_dig = 4;
-		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-		adev->mode_info.num_crtc = 6;
-		adev->mode_info.num_hpd = 6;
-		adev->mode_info.num_dig = 6;
-		break;
-	case CHIP_YELLOW_CARP:
 		adev->mode_info.num_crtc = 4;
 		adev->mode_info.num_hpd = 4;
 		adev->mode_info.num_dig = 4;
 		break;
-	case CHIP_NAVI14:
-	case CHIP_DIMGREY_CAVEFISH:
-		adev->mode_info.num_crtc = 5;
-		adev->mode_info.num_hpd = 5;
-		adev->mode_info.num_dig = 5;
-		break;
-	case CHIP_BEIGE_GOBY:
-		adev->mode_info.num_crtc = 2;
-		adev->mode_info.num_hpd = 2;
-		adev->mode_info.num_dig = 2;
-		break;
 #endif
 	default:
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(3, 0, 0):
+			adev->mode_info.num_crtc = 6;
+			adev->mode_info.num_hpd = 6;
+			adev->mode_info.num_dig = 6;
+			break;
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(3, 0, 2):
+			adev->mode_info.num_crtc = 5;
+			adev->mode_info.num_hpd = 5;
+			adev->mode_info.num_dig = 5;
+			break;
+		case IP_VERSION(3, 0, 3):
+			adev->mode_info.num_crtc = 2;
+			adev->mode_info.num_hpd = 2;
+			adev->mode_info.num_dig = 2;
+			break;
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			adev->mode_info.num_crtc = 4;
+			adev->mode_info.num_hpd = 4;
+			adev->mode_info.num_dig = 4;
+			break;
+		default:
+			break;
+		}
+#endif
 		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
@@ -4590,12 +4619,7 @@ fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 	tiling_info->gfx9.num_rb_per_se =
 		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
 	tiling_info->gfx9.shaderEnable = 1;
-	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
-	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
-	    adev->asic_type == CHIP_BEIGE_GOBY ||
-	    adev->asic_type == CHIP_YELLOW_CARP ||
-	    adev->asic_type == CHIP_VANGOGH)
+	if (adev->ip_versions[GC_HWIP] >= IP_VERSION(10, 3, 0))
 		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
 }
 
@@ -5036,7 +5060,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
 	case AMDGPU_FAMILY_YC:
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+		if (adev->ip_versions[GC_HWIP] >= IP_VERSION(10, 3, 0))
 			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
 		else
 			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
@@ -7647,7 +7671,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
 		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
 
-	if (dm->adev->asic_type >= CHIP_BONAIRE &&
+	if (dm->adev->family >= AMDGPU_FAMILY_CI &&
 	    plane->type != DRM_PLANE_TYPE_CURSOR)
 		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
 						   supported_rotations);
-- 
2.31.1

