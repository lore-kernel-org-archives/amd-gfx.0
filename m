Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B502C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A20661262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A20661262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47986E8CE;
	Tue, 28 Sep 2021 16:44:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE5E6E8D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Forya2MLSoQdISfFmPd40P/mVYD+L8AM+4jaUUZw282izmVjPwiOgtxUXfY8K5a9AkgUxDxDhF8MjpBCoewa39ydtSuZ9JzlyK3PWyPazUICIJTi7g3luKbpffHYFvdaSb9GVJ1Q+1zi30VPEcReWCksIIIIXW71hmZ/HImE+Jsgn0rNN0qsAXVNQf6gncqYKGnsDkC0L+HQ2QRprrFBnZKLLAoH1DaPl7XuU/z2l0t2AO86V5/g0WLvbVzA0Y4DfA47p/XHfntdMFFd4VS1tqiyVRSkcaU77+1CGsb2EIJSdVA64r5dxAnvLbnzxGoODI7bEmZniWZYse0LRgUmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8rCaYHBAIfcbvAYPXIDgqxibMTqliqfJf5D6YaNADw0=;
 b=nfQs7WnXGzCIiq5lWnr0rxnZbwTZOI9nK5binMZlhFTbc8tIynZTtvLyVB0E04M4HIrTUxgMs8i6FVaChJwjt0m3mwIaHY2fXSRwxcmcAWp+nmYggD8TgAD/0CPK8u2nRH7JRJDkeGmpfdQcs6tA6oTPc0Y8Ng/3tu9Cc7fhUDamMwX+Y5O6HfeQ78Xu7pbwv6D3LrfF6QrKQexi9ZlH9IIuErVS0ubbRZcHvHy36OfZfdodxHP6joPTRLsLSnIUm/nk8n65azVkLkApeObgWXqdbs4x3Y5AgT4IC7V+ZXvg6flqIm0zPZIk4LDK0zcpRNB3q4JTRll+uL5kh2lCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rCaYHBAIfcbvAYPXIDgqxibMTqliqfJf5D6YaNADw0=;
 b=K0U0LBIx25DyGOeRhQJPC9BBgMiE2TrKmNPCnCBSI+BI7eJbsfSLl47kWB6T8L3ZPAjfZTYqc/jAae804U6D/FknRfO+Pdt//Jwvj+OoUO7EDtJ6ayk3PsgKugPoK3udwk1ireGv+hH3g8/SFd+fn+0+IMmpXQQQV3cE8XsvITI=
Received: from DM5PR07CA0141.namprd07.prod.outlook.com (2603:10b6:3:13e::31)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:44:46 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::b5) by DM5PR07CA0141.outlook.office365.com
 (2603:10b6:3:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 29/64] drm/amdgpu/display/dm: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:02 -0400
Message-ID: <20210928164237.833132-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44968f98-c2ea-4c09-0187-08d9829f477c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2708C507E1A20C5DCCB28732F7A89@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqxaKrrVgG/J6RSmEpqVfsgOPB5NW7wCR1/Lr4y2Q4w5A6K13vYdPVH4k6ZuvNd/C2ku8XbJnMZaOUEg3OIXNR/V/xf7UQ/jX4QhcwJcPgBEY41rwvhQtFmd12rrwzb4cmffhk7/72r2/84CnaPl6BVed0sGkxYvkYuhm3t27INy6/Oz/y+G++XqlwdOT9S5Nor82OMnCTNpnHbP/4Eej8OGncbhlw0WuZKmBV8nd7M6c7ZEMdfbaPriPzxk9Qvgum4Tvhf4nXkdcF491+vngSm2I4LKHCdVh+kZ+6lm8bv7OT5sD5MJp8fl+kHBGco2YMvSCnqfPWVFYqerkkjzc0Bvd3gC9NyxJwztzwJKBjLMZ7/607RpmmsrdMe18WEa2o4vdaU8CCLwzy/1fvjIcOdGu95JFU3tgU7KLN+hEiBVuthcIz0y+SxKbI0FFnQuA2hnZ0KbdPUK1EiX0mrvog1Kfqx0+GeCCuwpSaVUbUc9AIdPLSSyRv3tTPRJlCYHCMTZ7j1Ac/YiuC1/K56zHWY2IN3ttnyXxDn+CMH/lGr9giiIL5x3RtSIxm4w/Fmh6T8r9pe4mjgT8bUCJQMa9DIq5yGOaF/rXkU1Cg9+QR8hgXIUlMMz5ecM6G7HrI4XnbV0hm1e3pjf0SC0xJacYWML3HMaIm+9ZYavWEnH5aUWwP4lugnNnzkGec+NHMvJAJB8OLjJVETSZo8lXkWMYLbSHKgBPs/RsTxTaFXv54A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(356005)(2616005)(36756003)(70206006)(2906002)(426003)(82310400003)(6666004)(83380400001)(186003)(16526019)(336012)(1076003)(7696005)(508600001)(81166007)(26005)(8936002)(316002)(86362001)(47076005)(4326008)(36860700001)(6916009)(5660300002)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:45.9496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44968f98-c2ea-4c09-0187-08d9829f477c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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

v2: drop unrelated change

Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 192 ++++++++++--------
 1 file changed, 108 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e676d0a56d50..2c4c5905fdcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1343,16 +1343,23 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
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
 
@@ -1443,7 +1450,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #endif
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >= CHIP_RAVEN) {
+	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
@@ -1638,15 +1645,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
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
@@ -1660,6 +1658,20 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
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
@@ -1738,34 +1750,36 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
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
@@ -2065,10 +2079,9 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
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
@@ -3289,7 +3302,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	int i;
 	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
 
-	if (adev->asic_type >= CHIP_VEGA10)
+	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -4074,18 +4087,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
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
 
@@ -4173,16 +4187,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
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
@@ -4190,6 +4194,26 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
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
@@ -4340,38 +4364,43 @@ static int dm_early_init(void *handle)
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
@@ -4592,12 +4621,7 @@ fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
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
 
@@ -5038,7 +5062,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 	case AMDGPU_FAMILY_NV:
 	case AMDGPU_FAMILY_VGH:
 	case AMDGPU_FAMILY_YC:
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+		if (adev->ip_versions[GC_HWIP] >= IP_VERSION(10, 3, 0))
 			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
 		else
 			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
-- 
2.31.1

