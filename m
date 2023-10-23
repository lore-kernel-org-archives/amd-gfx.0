Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C593FC25B46
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 21:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4232110E260;
	Mon, 23 Oct 2023 21:03:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FA110E260
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 21:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMlQrl7kTnnyNUcPm8MFeXW+pBXR5/rAaeedPOB9nHAmz0XcsrtQQCpxKgud3Ekmb/zelUsXOOzxKf64to1STureAsMw0omVSklroGIeWN+mLVy1p88a2K9QkfbGOLp4zlJlJQFbr+32JVDQ+yWYawFQE2sR073r2gNaisMiOn9cq80e3R5QyKM/5+AuUGLc/Tlu0mDq1+BmyN6LdldFDh7FCOn9Uaummlrqolg4FcqbK+8T3JNxNBYTZEQQ/z/B/tXIkmSjFThNJyZv620bBvmQpb/1aG7AY+6qw4HQqSYknXavjiKVd84RvQP4zdaMfbglsQe4PZkuhq+BUvjK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB+L71qAYEtDJApOsPUScTKKoTS5O0zFCX4tlVCH19E=;
 b=jMEFicZxugA9+q73eeZ8TwCHNQw3MjAyhyno9hOVV2P7VxohpdTC9epHzTcC7Iz/eO6gxN1REqCMrRozY7Kzecah12iEgOv3Kk08/Snsr9u2HOi524AMjAOx/gLqoP7IBgyTprEMRUfDeSwLerCvXMaA+1t32LIiXrhMk3V0o/OOU0jLxU5hIt8M+0BSVqW77XmUmhBBSgB4U/Tv0zWcw7pKU92G7klYTTzz5pJeR3S4ObbVokZgzk1xwH98K5WAy4MVQ28Pb1iBAy1Rsfjwl6dkijcYGKOWY12xuiQltGUnRs+//fOkFdwcm3FPKYniEavbK+aTUsKJW0LRR7MpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB+L71qAYEtDJApOsPUScTKKoTS5O0zFCX4tlVCH19E=;
 b=cfYdbECb1TqePmXA5NlecOsagKbXm9LH3oalDgHc0zYN6YFpgaYGdsGl48caKlSOS9s3ahDHKnSioaOJkm2ZGRxD0BnAHe4E04OCRQdJ8LTmJEiaMfuGX8B1X8ZNxbH4tkwYVrhbKvjuaC4TPjdBER3gJ3BDkM6AwGc1Ms6fjW0=
Received: from PH8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:2cd::11)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 21:03:18 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::87) by PH8PR07CA0023.outlook.office365.com
 (2603:10b6:510:2cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 21:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 21:03:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 16:03:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Disable PP_PCIE_DPM_MASK when dynamic speed
 switching not supported
Date: Mon, 23 Oct 2023 15:58:29 -0500
Message-ID: <20231023205831.511-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: e7732ea7-7131-4043-9ff7-08dbd40b7aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHhDnZlykn2KXVQ/Z2lUXVW9pOmAqD6oUPRjHHsxg7+uW3eCkgPS4W2sFtgxIURrJVIkOfDPFC9ZN8D7aYACOmkCPkO8t8bgPmAXSll6i2Hu/uCKO5zyb3YH4yN4NJexU53ZAV7ZJAKBNWMFlaq0Ozckm5lHDM9f2UvnNlyRKJjYUiuD3QXBechbmVYEU+wEwWJ68nKoFcIeAeJF0a9hG9M/P/EIu03reegYPamDkaH4EOgx/Ua4nUgJF3Sh+/MYQvNaKZrb7oG57ZgsK1d5tY4MviFvot0mc/Md07BQofPzb1v/S/tW3kF/kS/XSXqe4wFug9j7ClBIPcHzE3o8Q00yYAo9yr+AikDTqI5SGWmuXMKH/YvioijmHlypiIQOSFRparLdY0xyp1tR3nCDo6CmwwvOsbjhjRdMdO+GCA8Nc+hCdNjRNVX1J9k8kpmdyNLVObCvdCdgK4V9DMyXfKTwVu93XgqI8wmQFGZkl6gvSOv8fhc7CfaBqcLngqy3brnhsGAnHhKNar8DcYmq3Zt9zcMGJApenjnFslHmNIrFkMZ0ytP1xt2hFeeOqv+Kd3iHNG1AyqZMQae2iK+eYEvRjH7zT52Q8oApKkmRLyWY0yhiFEFs6v3IP3Lui7CMGjNW8gNzSKILdSDllDGYOJqS5EkyUAZRgNU0Fkf4VEh6iCzT0lb/ly/x9he+SDaNPHia89J5cSjL8ZayZm1dSCIgrZny/C/udvyLJ7B0IdH0hy8+fhwSV6ZN8z4MQrdNCdL7ZOKzFh9V7Q7vZEYN/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(26005)(44832011)(2906002)(40460700003)(86362001)(41300700001)(36756003)(5660300002)(4326008)(8936002)(8676002)(478600001)(16526019)(7696005)(1076003)(356005)(36860700001)(70206006)(6666004)(81166007)(82740400003)(2616005)(6916009)(70586007)(316002)(83380400001)(426003)(40480700001)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:03:17.5733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7732ea7-7131-4043-9ff7-08dbd40b7aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than individual ASICs checking for the quirk, set the quirk at the
driver level.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c     | 4 +---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc047fe0b7ee..b345c7bcc3bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2315,6 +2315,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
+	if (!amdgpu_device_pcie_dynamic_switching_supported())
+		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
 
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5a2371484a58..11372fcc59c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1823,9 +1823,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 
 	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
 	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
-	data->pcie_dpm_key_disabled =
-		!amdgpu_device_pcie_dynamic_switching_supported() ||
-		!(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
+	data->pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 	/* need to set voltage control types before EVV patching */
 	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
 	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 090249b6422a..97a5c9b3e941 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2115,7 +2115,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	min_lane_width = min_lane_width > max_lane_width ?
 			 max_lane_width : min_lane_width;
 
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		pcie_table->pcie_gen[0] = max_gen_speed;
 		pcie_table->pcie_lane[0] = max_lane_width;
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bcb7ab9d2221..e06de3524a1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2437,7 +2437,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
 
-- 
2.34.1

