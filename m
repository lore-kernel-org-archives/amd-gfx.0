Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C91C0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 03:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3AC710E543;
	Wed, 25 Oct 2023 03:50:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D74C10E543
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 03:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocnyy9mPuzvAmOifL+93XkeJtX0wGyYfnduOwvNeLVL+BBVq3PyPYwqWBt7ITzxnbSDksoeG22BWzuPOk/EKvDcsTVfMadbvH3kRyXKbmqfdsbEbZpqiYkO7/tcwr7V3gtXh7sSOdthHSVrcaFs8SkC+eJsWscbGHH0/rfSpoMBihmQoveLjWxqT/mUYImF6xI8zUbA030SgAhYBgpJVlo/LYL06igIgZSaR5zMftwzal8FLoNpQ73vxamZEf1NXf/LOA1FsnLpFfJA+XDsXRzp0CoFehw9IL2bSgOJOFFyF1WT6QcRVhBIUSd+HRyqXZ3pDeVppAVGZEP7bP9aD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e86OxvwM6HlcKMLMvP2wlvYXC/cutEs8zaWuS0S2aD4=;
 b=lBq87DzRpn5N4XsmyzOSagplumSB4x5zahI2PxVP/tNw++aU7gGLhiIX24igmauNLoZ24tnsijwR6A73FlDjVvLnQYj3b0wCBzF+3Y+And9AvUR7L44SewIBCcyxkeO/OqBS5RsqpFpfJOgKDmu+kAuMH93E0SjNDbYdzb8QSu94uNWxr/AcWdQZt3z3dLPj019duGhqzRscXERno5P3pEl7Vg9ugaLOLNM6wsE/S/+vCo9rxM+iTKuZmKPKfKvYyu80nya1jyZ+obMCH0Q9RAYrZsUPopwBS9kR55jHaYh3WpP/bICL0w4BG5jAj+EdzVGFzk1UL6eepKN73bC1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e86OxvwM6HlcKMLMvP2wlvYXC/cutEs8zaWuS0S2aD4=;
 b=5GDzzhPFGVyYy9WcFU5F72C6x1Pc7n0j1te9PMzTkIc9JrS9I/LHwGIBD1rRS3BY/kx+9+d1oBa88j8jFUSGpGyA6XY/xs6v4VNXjYoSxFMfd6zysrstwpI50rCHTbMNihQhxRW4Jjrif1zZN9cjDUfDjvFJxH65RqjcZJ/2aow=
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 03:50:39 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::2c) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 03:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 03:50:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 22:50:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 22:50:38 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Tue, 24 Oct 2023 22:50:37 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Date: Wed, 25 Oct 2023 11:50:35 +0800
Message-ID: <20231025035035.766947-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d1b2e3-57bf-4d15-122f-08dbd50d8dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voKqiFi06aazZPl6ocWhyUU33oJ/0jQm09klP62z1JlZ6ijT3LN7KR7atiJkCG3LsYnD6YO11odnnzomHqSJBROFFqLJsmvzx9cY9T9Ty5gp4B9QRQPFkiBgYzzoY/IG1yV+QSAuoqW9TUFXTXKyOhuyBBxdIE607drwAIkxK0GP/jd2ef+eDUGWAwawzTTVUWrsAwHwrEFg8hjXq7zPrr7TQUTh1k3wZyEDSpWWnnd+QzkpZzIcAw6EteVqNJR9cmNvhPQzOuVjUlLyhRGakQ1m+x9r5LOeQLuoPoRE9buOcGzACp2LLNMAju2/k8ihIvqQ/SToLDS3PQvETh4ydI0/Rj3fWR+xRgTNi8xOYWlloZyxOX3bWdg1/+jucWeLR3qhGEYD3dVMCyrrK+0bt4JxoaGJojYd6vR8YqPwD+xBldgy+asyOyW/NYWfpqJcWGQrP3EvbqaDVRsZzWVV6C1Vf1nSLQY9g52GznDJxYmbVCaOOIGru8+UgZwRoitZ1ctIWxUbyPTqzxUKxzuwg83RLXdZZp7jJ5yW/aSBvaOHsNJy6d+IOzSFfTVG2ceFtadIFC7TaGos4DNULL39YHXpetspNDMZH9X31y9Dd1LY6OZVS3zngliN/AddMfu8+lT8fl0O0JTLtrUl2H6Vcsv+r7BBrV9opNnDCL8jImfDxPZxiI03r3mcc2EPRS4yvaMCcs1MlQKjqmuE2J7nkVWpYeEL0+SN1Z16chUCcYSNb1MJJsqtE56LPVjwzrPczbQ9WpPBrOtXPlbCKvmOel7HrdauGDp69pVa/rGAetU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(41300700001)(44832011)(4326008)(316002)(8676002)(86362001)(8936002)(36756003)(5660300002)(40480700001)(82740400003)(81166007)(54906003)(47076005)(6916009)(36860700001)(356005)(70206006)(70586007)(2616005)(26005)(83380400001)(1076003)(7696005)(426003)(478600001)(336012)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:50:39.2175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d1b2e3-57bf-4d15-122f-08dbd50d8dc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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
Cc: Alexander.Deucher@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the high voltage and temperature issue after the driver is unloaded on smu 13.0.0,
smu 13.0.7 and smu 13.0.10
v2 - fix the code format and make sure it is used on the unload case only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
 7 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31f8c3ead161..c5c892a8b3f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3986,13 +3986,23 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
-			tmp = amdgpu_reset_method;
-			/* It should do a default reset when loading or reloading the driver,
-			 * regardless of the module parameter reset_method.
-			 */
-			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
-			r = amdgpu_asic_reset(adev);
-			amdgpu_reset_method = tmp;
+			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+			case IP_VERSION(13, 0, 0):
+			case IP_VERSION(13, 0, 7):
+			case IP_VERSION(13, 0, 10):
+				r = psp_gpu_reset(adev);
+				break;
+			default:
+				tmp = amdgpu_reset_method;
+				/* It should do a default reset when loading or reloading the driver,
+				 * regardless of the module parameter reset_method.
+				 */
+				amdgpu_reset_method = AMD_RESET_METHOD_NONE;
+				r = amdgpu_asic_reset(adev);
+				amdgpu_reset_method = tmp;
+				break;
+			}
+
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
@@ -5945,6 +5955,18 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 		return -ENOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
+
+	if (!ret)
+		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+		case IP_VERSION(13, 0, 0):
+		case IP_VERSION(13, 0, 7):
+		case IP_VERSION(13, 0, 10):
+			adev->gfx.is_poweron = false;
+			break;
+		default:
+			break;
+		}
+
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..2e82172ba250 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,7 +733,7 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
+	smu->smu_baco.state = SMU_BACO_STATE_NONE;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
 
@@ -1740,10 +1740,31 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_reset_mp1_state(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if ((!adev->in_runpm) && (!adev->in_suspend) &&
+		(!amdgpu_in_reset(adev)))
+		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+		  case IP_VERSION(13, 0, 0):
+		  case IP_VERSION(13, 0, 7):
+		  case IP_VERSION(13, 0, 10):
+			ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+			break;
+		  default:
+			break;
+		}
+
+	return ret;
+}
+
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1761,7 +1782,15 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	return smu_smc_hw_cleanup(smu);
+	ret = smu_smc_hw_cleanup(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_reset_mp1_state(smu);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static void smu_late_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1454eed76604..9f2dbc90b606 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -419,6 +419,7 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
+	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index cc02f979e9e9..43c7ba68eb50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -299,5 +299,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint8_t pcie_gen_cap,
 				     uint8_t pcie_width_cap);
 
+int smu_v13_0_disable_pmfw_state(struct smu_context* smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bcb7ab9d2221..0724441e53ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2473,3 +2473,16 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 
 	return 0;
 }
+
+int smu_v13_0_disable_pmfw_state(struct smu_context* smu)
+{
+	int ret;
+	struct amdgpu_device *adev = smu->adev;
+
+	WREG32_PCIE(MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff), 0);
+
+	ret = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+
+	return ret == 0 ? 0 : -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 47d008cbc186..e2a09fe29e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2758,7 +2758,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_PrepareMp1ForUnload,
+								0x55, NULL);
+
+		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
+			ret = smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b8a7a1d853df..2a0d1da18a9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,7 +2429,13 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_PrepareMp1ForUnload,
+								0x55, NULL);
+
+		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
+			ret = smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
-- 
2.34.1

