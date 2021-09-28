Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C96C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A723161262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A723161262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539546E8DA;
	Tue, 28 Sep 2021 16:45:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7556E8D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUpg9hBm0fHIOMuOW/vqcTZzM3L3QOEfr6g5l9OKsjTE6Yyc1PGKeJrnb6RrYE8RN0o5FG2m9HHqm8CQL/C2mqxVCq5807NAFmATB9uvS74HYzSQidMh02njwHXszX7KwvPyUfkvOnBVPUsklKtsHasN/8ihsrWV0ucmAKSds1rc66pySLvIX4YdzyWJdB3FEM9C3vHj7J2waKLRBCdMddcZzn9qf9daybXUAL9Qm28ws0JQAQdsVpNF6jU40alWrGQcFqE2DcP5SSf2tsLrUYrQ8MERp8zPuF7tvYQSaJzjfMLz0pzoUEX9WgeUsz8PFs3zuBs0/CtaA7UwBkmq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=rsh2J+VvWHepCigIbSeq+1sNmueTXvU0j5v4EvKanvg=;
 b=dHvjyH9r7Pdn6MQTxyKvDabugkUUYVKhruT4W29SRcFeYIYWRO/X3mPgqZAAl3YAZ4co8v+muZaWyPGPTzu6n5hc6r00ulWasOYcgw6LrMGf9YzHfmgKJse98hrbhEoTqAnAqKNUQ2PbBmrXqWeKkTiOrHzwJsxrUCiRP7r723TacX0dRxOBcD+ClMSOu/mq17D+a3O6pIq0aBPCGqXUo/TpMVTYaw8leoYJ++Ob4HjCflQ0irTx+UreuaKPv/X7ADbp4R/ylk+lNYbWpNJUn463B5BpOFPL7K/jrRNpKiGeE6vpvrUN656VEMgjmGhGwqT1y6OzDLzrmPN4a6GuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsh2J+VvWHepCigIbSeq+1sNmueTXvU0j5v4EvKanvg=;
 b=akJMYjeLCgZm0ng/T0Dkyj/ILRe7a8VfVkZCqyuEZiUv7lkMu37xcUgcJ5LVRwaQC83A9Nx0uI64KSbkgiAKeUwpU5rVsb8iRser/JJp1778CJXGiX4GkFRRjSLzplYxwA+0mG3xSVYVGlerMBAXBqihQeh9gixleJj84U4W7T8=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 CH2PR12MB4892.namprd12.prod.outlook.com (2603:10b6:610:65::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Tue, 28 Sep 2021 16:45:25 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 40/64] drm/amdgpu/amdgpu_psp: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:13 -0400
Message-ID: <20210928164237.833132-41-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e9baabc-118b-419b-48a3-08d9829f5ebd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4892:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48921AECDDDF63C924FE7E19F7A89@CH2PR12MB4892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o44i6FsF8RPdAooTjW1sHFxmjxWIIVaj7rZtA1Wt3o10xbsj8wId5JD+DhyCH0aFJL9B+yvBZcmAP1Ggnw9xuQYmhaLFAPs3RPt28oTRnXNzMqbx73fgvlYq90rrDHT7XsGSd8iry5hfZhRhwAFfteOrMBs0K2o0jo0Pn8j15COfWN5zIb1z4kLYVAQUnZ0L6hzpUJYXnFjcMwkz+JbDJdDkanugGfOISjTZjqld7csA+OzOWeGU6dFgT32BSACCPSF1s4NIVI3qw18FnZ9K6DW6RW2lre/a8BrqjZkCz6yaLR92YXJnD/iSHvJsPo5rcZHd4CSpFajEh0W5we8BIqoCGnF91sfojhSIgeiPzqTlHDB/zSXjNqINkNhRC1UX1m0l4D24c0xO9p7q6RchlzpkhpPb6WXH8Bm8fG26es/ZzgXkHq/rRdGm8Jxncwortm4o7bCNFMxnzIt2nTpWW081Z/0hx/3PDdSIZePu6yFZsCWT5lMxIq/5A5V3O/Zm30YTlQqlFPdw0Ukt97o0QvFOPzbu7Yfd4KkOBOdb7IQbcP0VE80+IXzMy0aiT7EjrKbvWWamnBjArrgb9WtX9Bvc22Q3G8AvFooX/tzXuRGkdHehVl56hA38ShBJdzVWCNSav4nffpKSiJ4PKfIw1Zhjf03DqBSnwcrOa5ElmWNNcFbav1XlPblo1w6m9IBqUuFSEo9LVl9BwK0BV6hdwva07KYOCn3/7Tg8T27Qfy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(47076005)(83380400001)(26005)(316002)(8936002)(36860700001)(5660300002)(54906003)(66574015)(7696005)(1076003)(186003)(8676002)(426003)(16526019)(6666004)(336012)(70206006)(86362001)(508600001)(81166007)(4326008)(36756003)(6916009)(356005)(2906002)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:24.9640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9baabc-118b-419b-48a3-08d9829f5ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4892
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 101 ++++++++++++++----------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f17a1036f46e..fe25a11a9b1f 100644
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

