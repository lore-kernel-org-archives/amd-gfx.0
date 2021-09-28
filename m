Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6225C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1036101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE1036101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B8B6E8C9;
	Tue, 28 Sep 2021 16:44:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892CF6E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke12MQphnTv/W60s19u5PhONXpx9gQD9XkgjBSROovTI1ce7J4sTVh0UW7tFPgWUr9NB8TANIOEognHMnFAAYuIFHkUMCDakjn/tnaCy728jCmDh0KPQ3aKcaLbDfHgBYpu6zfkg6IoAc6uROVHS0v9QqXSg/SwkfPpFq9KCiIJB+1VrjsqDdiKfBlhUgKCai4o57RghqVZ0QHaqdvGyRgBNknNW7bcvDhlTLqc0kUrNlf6SkuN7wvY9P4upSketa1VomiB8jko/T0kxKtxHfCjpauYtxDLLRpOFGewLFms3+0aScBJE5Hn1KcpLJGACjYvJU8x7oLcxQXX6IcKTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=v4ZJj/+Owz1/x3WlMipNRfaI9pUqpKQbKxYwCT35jag=;
 b=mJmhoOrRPCXRLfRIqcDI/CwIjuKHnTCewNeWrWiHQic4VoKcQbAri2T6pfcAkYfOHk/fGFpye5OsEnz0ttmhnJ/ZP/Aozk+mcyQUHG5XK+kJSAL/Dcp+HpimRFCCpU5jhof2kq3D9t1cKXQAgvJUK4WodwjWkTQexx/HkT9tdLzamb6o0viLEpOOcXH5AtmN8nnqagn/NrzUw17k906PuI4oQqjdhWe+zOTEK0Fb/VeyYL5SzkJrHp+mIfRPUG4CL4iWJyMVmziVswm7LTNaiQe72wDy41qAcYi5M//fKek9O2D7nmXrp/s5H14r7/0VVeXV10qHOPo7WkCAFE6Q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ZJj/+Owz1/x3WlMipNRfaI9pUqpKQbKxYwCT35jag=;
 b=iNR6c7yc2gLR5cuYMAuOGWMgNpkhxao5z+pWbN/6xS6HIQ+q8zEF958WiqiHe8Jq6esubgyUmsQ06YNES1eYBru00JlGSyGHZT9hFYD8O9Xx6F67TxyyMopdraRVPS+CeDFySNNRPJ4sYDm0v6evxgDhe31VoyJ7xo7zn2Ujxgw=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by DM6PR12MB3977.namprd12.prod.outlook.com (2603:10b6:5:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:44:24 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::2e) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 23/64] drm/amdgpu/amdgpu_smu: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:56 -0400
Message-ID: <20210928164237.833132-24-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43409880-20bf-413b-b0f9-08d9829f3a95
X-MS-TrafficTypeDiagnostic: DM6PR12MB3977:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3977390B3BF03A9FADB80FCCF7A89@DM6PR12MB3977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZDcLePLNipq4hJqy32aBHbXkW12mFmF2OVhFJruZH5RlEyypltdHwoOb0fDWDPFpsqcWy9VL+1/kqOKQZq3NQAJ2o8kBbxaEk36QuCf325lYoRLkcLpb7xo+zxOCrfJwb7QeQCcV9iAG8I2pQshd0DMJhS91VFHXfw7XtCP0M5ypU/RCEow+OmjmV8l0FxML0zDFqUrrgKKcJeXoC5Qce0fF4wE5DfDG7odSc0B9lvmWl3BG3nKOcmGjUpldiR+mD9rHMdaIk0sCztxbH6mkuimEmgHjm7zQ665JKAqG+gzj9mIbw1upjzBWzyyCOFMAWaZT/Pv/qBGTUmzYf/crgmelHSQNd3uy4InFSNinyRh484CnA2hBYb9H5q/Hw8d6T4pL6K4LAAp+Fbw3pL3ahpd816Lp7zd14SaGQFJy2cwwm/UKX7B2e3Ko9cKwGggKhDUKHA6l+S5wDh3Xs2Jua5iUDLQpsk36lK3xfsIRlettSvk2PShkCuNqaP9h7hmnrHajxX/pMLSoyTVdMV9Xe2gxiXtQToQ4fjqxBXr9c3IWo+WKgIs3FK+WAUFRa7DLhKPllT25N70j7waeA3n89PUwDJ1QA60vX/dWcWxgnqL3kTMxUxmQ8vpzJ/ev13xdjafoBjVrY563e4FoKDR/EgCdnit5P1LeTvDDu1yh5NA3Jz/nNy10V3MZNh2pGWBhgGUWqAGeb0OxtToqsX2+9rVWjfEbefzJT2j2XhJuQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(336012)(70586007)(16526019)(70206006)(6916009)(2616005)(356005)(5660300002)(186003)(508600001)(6666004)(4326008)(83380400001)(36860700001)(66574015)(86362001)(36756003)(26005)(7696005)(82310400003)(8676002)(316002)(54906003)(2906002)(8936002)(47076005)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:24.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43409880-20bf-413b-b0f9-08d9829f3a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3977
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

v2: rebase
v3: switch some if statements to switch statements
v4: add yellow carp fix (Yifan)

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 124 ++++++++++++++--------
 1 file changed, 78 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 04863a797115..68592b055a1e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -455,7 +455,8 @@ static int smu_get_power_num_states(void *handle,
 
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
-	if (adev->asic_type >= CHIP_ARCTURUS)
+	if ((adev->asic_type >= CHIP_ARCTURUS) ||
+	    (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0)))
 		return true;
 
 	return false;
@@ -575,43 +576,48 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	if (adev->pm.pp_feature & PP_OVERDRIVE_MASK)
 		smu->od_enabled = true;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
+	case IP_VERSION(11, 0, 9):
 		navi10_set_ppt_funcs(smu);
 		break;
-	case CHIP_ARCTURUS:
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		arcturus_set_ppt_funcs(smu);
-		/* OD is not supported on Arcturus */
-		smu->od_enabled =false;
-		break;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
 		sienna_cichlid_set_ppt_funcs(smu);
 		break;
-	case CHIP_ALDEBARAN:
-		aldebaran_set_ppt_funcs(smu);
-		/* Enable pp_od_clk_voltage node */
-		smu->od_enabled = true;
-		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(12, 0, 0):
 		renoir_set_ppt_funcs(smu);
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(11, 5, 0):
 		vangogh_set_ppt_funcs(smu);
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		yellow_carp_set_ppt_funcs(smu);
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(11, 0, 8):
 		cyan_skillfish_set_ppt_funcs(smu);
 		break;
 	default:
-		return -EINVAL;
+		switch (adev->asic_type) {
+		case CHIP_ARCTURUS:
+			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+			arcturus_set_ppt_funcs(smu);
+			/* OD is not supported on Arcturus */
+			smu->od_enabled =false;
+			break;
+		case CHIP_ALDEBARAN:
+			aldebaran_set_ppt_funcs(smu);
+			/* Enable pp_od_clk_voltage node */
+			smu->od_enabled = true;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	}
 
 	return 0;
@@ -694,7 +700,7 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	if (adev->asic_type == CHIP_YELLOW_CARP)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(13, 0, 1))
 		return 0;
 
 	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
@@ -1140,9 +1146,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
 		/* this is needed specifically */
-		if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-		    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 0, 12):
 			ret = smu_system_features_control(smu, true);
+			break;
+		default:
+			break;
+		}
 		return ret;
 	}
 
@@ -1284,7 +1297,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	int ret = 0;
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		if (adev->asic_type < CHIP_NAVI10) {
+		if (adev->ip_versions[MP1_HWIP] < IP_VERSION(11, 0, 0)) {
 			if (smu->ppt_funcs->load_microcode) {
 				ret = smu->ppt_funcs->load_microcode(smu);
 				if (ret)
@@ -1402,23 +1415,41 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 *   - SMU firmware can handle the DPM reenablement
 	 *     properly.
 	 */
-	if (smu->uploading_custom_pp_table &&
-	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_BEIGE_GOBY))
-		return smu_disable_all_features_with_exception(smu,
-							       true,
-							       SMU_FEATURE_COUNT);
+	if (smu->uploading_custom_pp_table) {
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 5):
+		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 0, 12):
+		case IP_VERSION(11, 0, 13):
+			return smu_disable_all_features_with_exception(smu,
+								       true,
+								       SMU_FEATURE_COUNT);
+		default:
+			break;
+		}
+	}
 
 	/*
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
-	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
-	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
-	     use_baco)
-		return smu_disable_all_features_with_exception(smu,
-							       true,
-							       SMU_FEATURE_BACO_BIT);
+	if (use_baco) {
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 5):
+		case IP_VERSION(11, 0, 9):
+			return smu_disable_all_features_with_exception(smu,
+								       true,
+								       SMU_FEATURE_BACO_BIT);
+		default:
+			break;
+		}
+	}
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
@@ -1436,7 +1467,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
 
-	if (adev->asic_type >= CHIP_NAVI10 &&
+	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0) &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
@@ -2229,6 +2260,7 @@ int smu_get_power_limit(void *handle,
 			enum pp_power_type pp_power_type)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	enum smu_ppt_limit_level limit_level;
 	uint32_t limit_type;
 	int ret = 0;
@@ -2273,10 +2305,10 @@ int smu_get_power_limit(void *handle,
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
 			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
-			     (smu->adev->asic_type == CHIP_SIENNA_CICHLID) ||
-			     (smu->adev->asic_type == CHIP_NAVY_FLOUNDER) ||
-			     (smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) ||
-			     (smu->adev->asic_type == CHIP_BEIGE_GOBY))
+			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
+			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
+			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
+			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
 				ret = smu_get_asic_power_limits(smu,
 								&smu->current_power_limit,
 								NULL,
-- 
2.31.1

