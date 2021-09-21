Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47EEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DC161184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72DC161184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1FC6EA95;
	Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD106EA79
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/F2Q9jVlnzZictAjwOpeA0f9cecxXn7+d8l5wpPgp56DFE4JkPIeHzpAHXrwr+pympRc6xz2zgcbLzrfuSG954Kvj0/vpM+qLBslGoyGJlrGUBqQIht8uIFQHDCd6REXyAzvZ0gpYMK9dL5JYLPqjZLa13z6X3cd9YWQA1muchZdDlMkvAlDA2dZXnorI+r7ERymJQtfImtGlCIOYoNW0vsF5yY1te11YLb2NiUoMbLcKAJY4VkJJsFQwgKZxUqyV5EB9bZYrLhp8nmzMPL6wBfyMlNr3akmemQqdaQPvGZ/+rL9MCLfW/IUftel8a64MezusD/MZiEALILcLf1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dUsfJh0RILGzy4+cxQuVx8BLP22x4zaSoVAF2k5RIOs=;
 b=GLbcIfBbBg0bx+sS3uLuyOGitdlWINrRK9/hehxHodRbYSsoKrQUdl3uaioMK8qKPfTK8aZ7pFUzRS/uw82/iWPzeNbXeMfROqU8/BspwivhUUWLBx5ZTxOQKt6jJVkPtRAAp5B+fjRVzIcBkWMHHzZ9mhwe1vYMPAJjCmoSChr+msqCFHioEaLmQbIbEj133X6nOO5SJw3wreGRAsCqHPtXRz3dPF03PqUrXh1V7/qBBfga7FlMqIMUa2PyLVKDAnSd8tjDaBkqjkqWCdx8rq0f04Zp3fESQ/3z626D+mlhLxi3GdWBhtOAYevMJNBtjaKJ7X0w8xm4QDQZvsD2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUsfJh0RILGzy4+cxQuVx8BLP22x4zaSoVAF2k5RIOs=;
 b=IVtpi7LLCdfRAxASSwu4LLOkTVsmDQpJjSwu4yQb5de4hnAPpBuvsTwPHCOb9gtrUc6Sj+FCB0jrxsor5De+UxzF7Bj2tV8Q6sDzqBaE/XFp9OTlvZusF8R5W2+uoSSb5IXGcLFVMOflVD71r0qNKByfYPJq/fNXvI94c5NRaMY=
Received: from DM5PR11CA0015.namprd11.prod.outlook.com (2603:10b6:3:115::25)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:53 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::d5) by DM5PR11CA0015.outlook.office365.com
 (2603:10b6:3:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:42 -0400
Message-ID: <20210921180725.1985552-24-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60878341-6743-4009-5d4f-08d97d2abb02
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475B256AFC4D583A948DEACF7A19@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihsL0KtJL5mSEjS83cvfNTUgX1Q8CVRGx02BWr6TXG7ZzUZ5Zhc4Kpo6Brr0gSWpgdDPywZP+pyCAvk0zkzo75hSldZz2d2aAysYoWzxH/YC8t/SFlbf/BGWQkpKRUO3GM10jJQ/vTgKzNAFFsipFJMYUCJaRgvziplqc+ksG3aANy/6Hg4su49aCWQb6iWl0r9C03k4+ohTTwezazjdZsO7BOs5B9Qb9WbK320gE08OcOkrPu3YzgICN4n7U+cqJENKCc8uiP1PKj/AHJQSN8YVzbN9wN6w3hP7Lf5m5K+2AzK8xvOP5ctBjAf9Yppy508iVRO0b06O656+KhDEGoJ/2nxzpGs7/rj3KcrvnTZPocoCP6gb0RRHT49M2h0QCBhbnGbz81B8Xjmoh92CvL38CGw+P+xRX8iCv03sXXRzbTINeWpt49LqsyHWPcNEWzFm1A0fOHVXnK0wMp9qu0+PE1LzmfpLqBUNs1J83Saep3Su9VG/cWgGIo0wET58scFRxu+TtcX7PajMdLcp0ZbgAToTQdWPfTNk1v1SXm1Ecq/2ypV6zc4sM23POb5iDQKKZ66z4HojUlo6eZVzsKZJs3thzFAnMj2ruZaIW7A6JEbG/uX/6+tpRQDUmdehTGF6ZU0+CUtpvDW7fRuOVsu6M1rbBWup2qutm6H0ObTVAODzBdchrf6nospfA202YotpF5Cj4Sj6b+yzQdWVHG2teta/3+0568n6K8K8BW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(82310400003)(5660300002)(7696005)(70206006)(316002)(356005)(426003)(186003)(81166007)(70586007)(4326008)(36756003)(2616005)(6916009)(36860700001)(83380400001)(16526019)(47076005)(6666004)(8676002)(86362001)(336012)(508600001)(26005)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:52.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60878341-6743-4009-5d4f-08d97d2abb02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 +++++++++++++----------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 04863a797115..5f372d353d9d 100644
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
@@ -575,43 +576,47 @@ static int smu_set_funcs(struct amdgpu_device *adev)
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
@@ -694,7 +699,7 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	if (adev->asic_type == CHIP_YELLOW_CARP)
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(13, 0, 1))
 		return 0;
 
 	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
@@ -1140,8 +1145,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
 		/* this is needed specifically */
-		if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-		    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+		if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
+		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
+		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0)) ||
+		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)))
 			ret = smu_system_features_control(smu, true);
 		return ret;
 	}
@@ -1284,7 +1291,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	int ret = 0;
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		if (adev->asic_type < CHIP_NAVI10) {
+		if (adev->ip_versions[MP1_HWIP] < IP_VERSION(11, 0, 0)) {
 			if (smu->ppt_funcs->load_microcode) {
 				ret = smu->ppt_funcs->load_microcode(smu);
 				if (ret)
@@ -1403,8 +1410,14 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 *     properly.
 	 */
 	if (smu->uploading_custom_pp_table &&
-	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_BEIGE_GOBY))
+	    ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13))))
 		return smu_disable_all_features_with_exception(smu,
 							       true,
 							       SMU_FEATURE_COUNT);
@@ -1413,9 +1426,11 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
-	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
-	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
-	     use_baco)
+	if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) ||
+	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9))) &&
+	    use_baco)
 		return smu_disable_all_features_with_exception(smu,
 							       true,
 							       SMU_FEATURE_BACO_BIT);
@@ -1436,7 +1451,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
 
-	if (adev->asic_type >= CHIP_NAVI10 &&
+	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0) &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
@@ -2229,6 +2244,7 @@ int smu_get_power_limit(void *handle,
 			enum pp_power_type pp_power_type)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	enum smu_ppt_limit_level limit_level;
 	uint32_t limit_type;
 	int ret = 0;
@@ -2273,10 +2289,10 @@ int smu_get_power_limit(void *handle,
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

