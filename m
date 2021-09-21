Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5881C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958DB61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 958DB61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0676EA9F;
	Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7848A6EA79
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlvU5hOnOTauJYLaDL44A65SaSU9Yo6/OptxbE4iZESOfGsx6S/ztVYFcBzdeAUj1GdP6CfCogcYPlOI4IL97wnHcBf8aMGrFfJsGxQfEu/X2988QzzYh/zgFUipPJ8CHVowqcCMMTn0w7DYB5I84IihI9uYQbR9LddRIaEk2/wsQb9hYdn0jmSHuSn1kF1hs2Yp+KUWrL1TiLHhMsttcXEp8LBq9NRF5cGXRK2Q8QzsDEDJVPxAHC+mad6HxIDRAzg7oQR16ip5X24cvIMICeNELK5iG/27rdMGRdBWs+rYDqCn8EQrxqCOODqr9fanM8cYmq7NH4B/Au2+jnLuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=V+hYlQgt6A38g9wwx063GGbUjLytc/DDB6674c8tuqY=;
 b=QdaIQ4svYYe358sgs4mtz7ngs5KFQv48Ahgzivi6ff8LLZWs3JhI+dq6qyguUeZ02iH9Sv791QMQDDPNh70/tngsgn0EJ5XjE8KefQML8XCWJpm6He6MVLHvfg+Uc8V6APGZK097CjQ5ogPlMKixgqSb+1LhSImBbCv2IIlRZLIy4yIWloCLc6c94oggM0z2i+IDrfGdB8t2eu/4sWlipQtXliOKGSbuK83ARLo8BSvHYje/LB7a6le13zd5U1pZDwAhLeVY3ds6wwwxOeGFSzjJwNn9KrM5j8zh9hf/vugqn/H/tLiO6P/auYbdpRovnnqHUngrM3A7joEFrfAzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+hYlQgt6A38g9wwx063GGbUjLytc/DDB6674c8tuqY=;
 b=hU1lkOqXMnYzf6pfTZU/pdyRx4sDnMnbMe4bg8FhiQ13VCjt6q8wS3UUyrpzyHC7mRi0gUoDKFPy/SdNgUvs1GS6arDwh6ZjLfv+YpkyKbYOvgyGLMy1k2lrnYTCOeU/rGsVCenT4PV6dZz7ndeuIFhdVzmTV03wwJpPuAaLxbU=
Received: from DM3PR12CA0051.namprd12.prod.outlook.com (2603:10b6:0:56::19) by
 DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:00 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::47) by DM3PR12CA0051.outlook.office365.com
 (2603:10b6:0:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/66] drm/amdgpu/amdgpu_psp: convert to IP version checking
Date: Tue, 21 Sep 2021 14:07:00 -0400
Message-ID: <20210921180725.1985552-42-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: da3bf4ea-3dfa-44ec-8039-08d97d2abf7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:
X-Microsoft-Antispam-PRVS: <DM6PR12MB412303C0BEA42353C18D03C9F7A19@DM6PR12MB4123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojQcNdJFDyE1w/DrGF0XTW2gH1fwgU491ef6GsgnIzjajjcaBTOjg6ZDblW0mfjF0uX5fAEBmzUy7xzHowhkH1zaBc7tEESva1hgzHL+fyEH+8SzMHfkJymKwyk3dBrYvncA3Eg73X9JeNEyM2wh5fZEZBbHUcyXpx0H6K2mJJkYU/U/j0w3lgEg/3sxIG+8ZhlB/gIukLDiaxFK8fLYcjFZA1DIt6ydtqFmeWd7YYIWdvxKjgRgRcv5LIl3uHDLn/jpyJWQbpORW1Ruq24ec5+mHB9eTZI1js8ffL7mCZ55v5AruPC72uTIaRpKtNShtxBV8BRkHR8Y+syXkNoFYmwc2JdB5geo6qRNjtfhmS4NgUdT61oWYz3YDWYuU1E4CKDNxoegQ6llRvyi281gv5sAsN9pJXC8XpZOOJpgd38E1QgInZXJEotBqu9e0H9uCM4vkT7/a0IQ9HJa1dYWabm0r6R6BShhluHmekk7lmKrckkE7oKJP5KH38rmMmILWlkK3orFhMa59+qe+UrgoxeSuRtJQdK166v1kFLNQ403UE1Mv182XgcloyYvEI385LygLHzla3yYW1umKc2tWDt9jPtFH8g3MptolEdRZR1DodGapZbonxfdp4JwIga1i8l4JrPVlvSgKl6bRiKliiF4uO9FTPWjyTRGh5LfpuQ7oWlabw1basrt1rXj8REostG5Fc/R62wEl1o2IO6q8m+FzaSlJf4ZD9f6ZOktgN8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(426003)(4326008)(356005)(336012)(5660300002)(6666004)(81166007)(316002)(16526019)(47076005)(83380400001)(36860700001)(82310400003)(1076003)(26005)(86362001)(7696005)(70586007)(70206006)(8676002)(36756003)(186003)(2616005)(8936002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:00.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3bf4ea-3dfa-44ec-8039-08d97d2abf7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 101 ++++++++++++++----------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7d09b28889af..c47d29689be4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -71,17 +71,25 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 {
 	struct amdgpu_device *adev = psp->adev;
 
-	psp->pmfw_centralized_cstate_management = false;
-
-	if (amdgpu_sriov_vf(adev))
-		return;
-
-	if (adev->flags & AMD_IS_APU)
+	if (amdgpu_sriov_vf(adev)) {
+		psp->pmfw_centralized_cstate_management = false;
 		return;
+	}
 
-	if ((adev->asic_type >= CHIP_ARCTURUS) ||
-	    (adev->asic_type >= CHIP_NAVI12))
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
+	case IP_VERSION(13, 0, 2):
 		psp->pmfw_centralized_cstate_management = true;
+		break;
+	default:
+		psp->pmfw_centralized_cstate_management = false;
+		break;
+	}
 }
 
 static int psp_early_init(void *handle)
@@ -89,43 +97,45 @@ static int psp_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(9, 0, 0):
 		psp_v3_1_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		break;
-	case CHIP_RAVEN:
+	case IP_VERSION(10, 0, 0):
+	case IP_VERSION(10, 0, 1):
 		psp_v10_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		break;
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 4):
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 1):
 		psp_v12_0_set_psp_funcs(psp);
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(13, 0, 2):
 		psp_v13_0_set_psp_funcs(psp);
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(11, 0, 8):
 		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
 			psp_v11_0_8_set_psp_funcs(psp);
 			psp->autoload_supported = false;
@@ -268,7 +278,8 @@ static int psp_sw_init(void *handle)
 			DRM_ERROR("Failed to load psp firmware!\n");
 			return ret;
 		}
-	} else if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_ALDEBARAN) {
+	} else if (amdgpu_sriov_vf(adev) &&
+		   adev->ip_versions[MP0_HWIP] == IP_VERSION(13, 0, 2)) {
 		ret = psp_init_ta_microcode(psp, "aldebaran");
 		if (ret) {
 			DRM_ERROR("Failed to initialize ta microcode!\n");
@@ -311,7 +322,8 @@ static int psp_sw_init(void *handle)
 		}
 	}
 
-	if (adev->asic_type == CHIP_NAVI10 || adev->asic_type == CHIP_SIENNA_CICHLID) {
+	if (adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 0) ||
+	    adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 7)) {
 		ret= psp_sysfs_init(adev);
 		if (ret) {
 			return ret;
@@ -341,8 +353,8 @@ static int psp_sw_fini(void *handle)
 		psp->ta_fw = NULL;
 	}
 
-	if (adev->asic_type == CHIP_NAVI10 ||
-	    adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 0) ||
+	    adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
 
 	kfree(cmd);
@@ -601,10 +613,10 @@ static int psp_tmr_init(struct psp_context *psp)
 
 static bool psp_skip_tmr(struct psp_context *psp)
 {
-	switch (psp->adev->asic_type) {
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_ALDEBARAN:
+	switch (psp->adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(13, 0, 2):
 		return true;
 	default:
 		return false;
@@ -998,8 +1010,9 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
-	if (adev->asic_type == CHIP_ARCTURUS ||
-		(adev->asic_type == CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cpu))
+	if (adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 4) ||
+	    (adev->ip_versions[MP0_HWIP] == IP_VERSION(13, 0, 2) &&
+	     adev->gmc.xgmi.connected_to_cpu))
 		return 0;
 
 	if (!psp->xgmi_context.context.initialized)
@@ -1100,8 +1113,8 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 
 static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 {
-	return psp->adev->asic_type == CHIP_ALDEBARAN &&
-				psp->xgmi_context.context.bin_desc.feature_version >= 0x2000000b;
+	return psp->adev->ip_versions[MP0_HWIP] == IP_VERSION(13, 0, 2) &&
+		psp->xgmi_context.context.bin_desc.feature_version >= 0x2000000b;
 }
 
 /*
@@ -2219,8 +2232,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 
 	if ((amdgpu_in_reset(adev) &&
 	     ras && adev->ras_enabled &&
-	     (adev->asic_type == CHIP_ARCTURUS ||
-	      adev->asic_type == CHIP_VEGA20))) {
+	     (adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 4) ||
+	      adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 2)))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret) {
 			DRM_WARN("Failed to set MP1 state prepare for reload\n");
@@ -2317,8 +2330,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			continue;
 
 		if (psp->autoload_supported &&
-		    (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-		     adev->asic_type <= CHIP_DIMGREY_CAVEFISH) &&
+		    (adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 7) ||
+		     adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 11) ||
+		     adev->ip_versions[MP0_HWIP] == IP_VERSION(11, 0, 12)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
@@ -2905,7 +2919,8 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 	ucode_array_start_addr = (uint8_t *)sos_hdr +
 		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
 
-	if (adev->gmc.xgmi.connected_to_cpu || (adev->asic_type != CHIP_ALDEBARAN)) {
+	if (adev->gmc.xgmi.connected_to_cpu ||
+	    (adev->ip_versions[MP0_HWIP] != IP_VERSION(13, 0, 2))) {
 		adev->psp.sos.fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
 		adev->psp.sos.feature_version = le32_to_cpu(sos_hdr->sos.fw_version);
 
-- 
2.31.1

