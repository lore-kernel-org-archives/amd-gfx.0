Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCFBC0032E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 03:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916B610E742;
	Thu, 26 Oct 2023 03:34:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BED10E742
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 03:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5hh4FdHWIgAoeBTRYVB0nSoZUye/V8Th4iS51dy83DXZvIe7MaUxKER/MEPtKmOybXuRuASuIjFe7s+9xnSaQAA2+oG9jtId9aAeH0gbX5goRd6O8XQlApWFAfqG7ucax/hVvgci2lhEmqyV72Vc9J2Pr7qhVstwTqAw0Gu8iDsr6yDk7M/wS5HlZi3zvw5CgAWQgIFzPBnoFS58Qebq1PwlhAjkw/wSOg/eHl4lx4vsY9DQ2bIw9zVznfIuBWpwT1Va145dHpcj0HV+3efx8cf4vuAZGYhmbAPZRBP/J2u6nGKyZxOutTUp20ILltPVDXigyZIj0XuVgKhKkYCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJxa4V9k/9qpXuEKD+b5jpq1RIa2fsln0XcE3Kp33BM=;
 b=fy30JkJCEO0gJJh7d8g7gDRxmJ8InFzp0sKAFR3rCCTv7dKgLL5ZUcE2Hj+0l9OxxjoVPfnzBfgIzMjJ3ppIv+6R8YXkFbHmyEVMAtqz62eHPcI6AkcMzbXfHHUac8+oeUDWOUtjioquqFnCRtl4RFjg7hP1JH+3l9lgoQRpW04+IVtJJhl/CGGnl6mHod/T/BI35waQqF4xLbW/sHV+ElYBoqIb4w0cmN2av/f5BdmzSzABy1wzddg5OF6lHv9ulHCPuRAGPvVR8dgmUYTnUIc1M37FUmL3wNOdc7Hb84HCI3d8EGIEug6pI0gTT6a7kYETMyN7aEculJP9kA5aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJxa4V9k/9qpXuEKD+b5jpq1RIa2fsln0XcE3Kp33BM=;
 b=MCEth47vO50Yih0h7CBQcwLc6gej28FUJepiCtw7W0yrBwfY1chA2zLlFUAbS21fAfkBkXu5ebYvCgX1KUeYtm8FyXD4RvTkpjNVU3YlbkZjEMb9s9iwCFucq3x1J4D9T5urc8E084J9/0VX1UhO7SPL0/PHaZGvxPyC6dMUZi0=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 03:33:57 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::96) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 03:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 03:33:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 22:33:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 22:33:56 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via
 Frontend Transport; Wed, 25 Oct 2023 22:33:54 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: fix the high voltage and temperature issue
Date: Thu, 26 Oct 2023 11:33:52 +0800
Message-ID: <20231026033352.988746-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b27253-0e2f-4978-662f-08dbd5d462de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrJrA+dsp1DYxWSWxVyUzOuv8cT0F3JaD4qxXzcVDOnav3Cs1TzEVx7S0n0ZJNdBTHImmdSrpokOF7HyQZSKXs8ChdBdvdRt7Ah9d446ENTp43PZPK99/8RaSbv0wwVb8und8zpIysuqjEkRwWUtGgYbVTgQbVGWY/O70wrNf6QbC3+L08jPbFYGXG4I2j0uFAoPbpJY2dQAqlOAkodSWzBwLxS8y/5ZKLb7HPFD2VokoiCUJtO5bwFtP5bmX3pwnHKaf+u/tvBmSN3kWXg1AFnWdf0z+V0Vbrg0+Yw3bxGORIsfJI5E7xSzpgaIM5/0EIm27y6xtoRi3Ys2/9eyCf00zTYPEEI+eJ0trif2P7nAvrQBXURUcMqdMwj+YV09KsJ5qCQcCycTp3ntaXkezgD3uweBmtjspCPny18a1F4BmcR8v6tTca1yq4qfuizqQK5EjUznbulUApeS9OfIogPYnvYp3m0O7QKDPvs/kwxI4MhaxWUkICjwTLVzeIAvFbJebbGBxCFIxRNYjm5r9EysEQNXCyXGA9XNq4EEOjFuql8bhRwzgbKGK9X+VmlHNo/Ug6ZbVOVwebtpudYevSqNPAWL84TBeLGY/q27LPz8uSN1iKNuGc/oATh+Iy9Yy1EVUJwOLnop+TKcHaGk3pnPc+Hle04tkDzb0DDGbX+lcKUgTHBkOoK5UbFCxDrjWm5NvHC7pGbn9ifgUPliXU/rBksp1mes3vfkys2RsZwmqTFTtTIa3sb6MJ8Ea1ZAzSTiMhNpr69m/bByXnGGDTd82bEwmhZIbC80A1NbEQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(426003)(40460700003)(336012)(47076005)(36860700001)(83380400001)(2616005)(44832011)(5660300002)(41300700001)(4326008)(8676002)(2906002)(26005)(8936002)(1076003)(7696005)(40480700001)(86362001)(36756003)(356005)(6916009)(54906003)(82740400003)(316002)(81166007)(70586007)(70206006)(478600001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 03:33:57.0801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b27253-0e2f-4978-662f-08dbd5d462de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
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
Cc: Alexander.Deucher@amd.com, Kenneth Feng <kenneth.feng@amd.com>,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the high voltage and temperature issue after the driver is unloaded on smu 13.0.0,
smu 13.0.7 and smu 13.0.10
v2 - fix the code format and make sure it is used on the unload case only.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 ++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 33 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 ++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 18 ++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 19 +++++++++--
 7 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31f8c3ead161..1ad0fc3f3861 100644
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
@@ -5945,6 +5955,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 		return -ENOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
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
index 47d008cbc186..02c5e7b1e43b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2570,14 +2570,20 @@ static int smu_v13_0_0_baco_enter(struct smu_context *smu)
 static int smu_v13_0_0_baco_exit(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		usleep_range(10000, 11000);
-		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
 	} else {
-		return smu_v13_0_baco_exit(smu);
+		ret = smu_v13_0_baco_exit(smu);
 	}
+
+	if (!ret)
+		adev->gfx.is_poweron = false;
+
+	return ret;
 }
 
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
@@ -2758,7 +2764,13 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
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
index b8a7a1d853df..40e8d1767b71 100644
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
@@ -2455,14 +2461,21 @@ static int smu_v13_0_7_baco_enter(struct smu_context *smu)
 static int smu_v13_0_7_baco_exit(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		usleep_range(10000, 11000);
-		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
 	} else {
-		return smu_v13_0_baco_exit(smu);
+		ret = smu_v13_0_baco_exit(smu);
 	}
+
+	if (!ret)
+		adev->gfx.is_poweron = false;
+
+	return ret;
+
 }
 
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
-- 
2.34.1

