Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BBFCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 08:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DDA10E590;
	Fri, 20 Oct 2023 08:16:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1932710E590
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 08:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kckFiPGZKM75aCe+auaQ6p4QVCKfOTEeyEp583hAJi/S96S5qjy1/5B3LLSuyVpsPlv6mumKK1seEcPOw1kI/j87e3IHl57HIfloQ9t8eS2N+Vr0pYVrV3HHpem9spm2SdVR1lJOJ88oabpRSBI4oIlGvCAQ3MHPl5xLpIJWFC0ZMAyEgP9EX3geZ8XSRF336YJnf0cSKk0+Vk0iipsNYdocE8A8aNrj4YieYwH4LGuubZFnI4c8C5+fhYJQoSxRktP49u5xYrCz7ICBiC+CK7TTt+mrDpw+CcFgeL8J9rmvmQeHArWgcnCZ+y2eupcxTxz8ks5V2bJM9EYQcr2Sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jtSZwM56P2m7zsiF6k+eZjTrDl2TLGYtiyvOc8yjyI=;
 b=SyaKxnJiRAgpq8wncf76zWrTk71H0XnlmQ9hhYbXi7RTk+uubFPxK87GQDX3T+Lg4kZT4XDjD8K69YL3VUO/c48RFdvLstozps2jdoOzv+4T7BvOCM6XAoJcIi1NSeqyYzMaUpoxb5XzvXdonVTFlgbbuQeNLczY4Vh6DcgUsheBn4+rUf6QVHyk6yD+EqjsmmihnpL6wxdknJ68QyO8NfoZYjpUE9zVyo+1BJMa81Rd+ZfZybHS8ThDg4e99aKnPNpAZmAEL+FtH7X4WLTiNfzmmKGBTRWX6/goqChanqI2gTAxzJYwrqbhOzBdTsFP56aNaEQ1zl/cMq0BBJIqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jtSZwM56P2m7zsiF6k+eZjTrDl2TLGYtiyvOc8yjyI=;
 b=0D5iKKl18Pg0wnV9o1S9XZO7bLe7AvgsqevWOhM7v/zIly9zQuO+KpmUtoF7vvRH1ZGMZ3bBkr5XM/QKNPGO/CmfV1Xxczl6rBRV/88a/LZ0Od0PYvBBAE2acFda6dzL4PHMA3q3D5cnmfwGVBAwpqSMCHalrxesKjfnzajAXgY=
Received: from CH2PR17CA0007.namprd17.prod.outlook.com (2603:10b6:610:53::17)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 08:16:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:610:53:cafe::3d) by CH2PR17CA0007.outlook.office365.com
 (2603:10b6:610:53::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 08:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 08:16:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 03:16:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 03:16:11 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Fri, 20 Oct 2023 03:16:10 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix the high voltage and temperature issue on smu
 13
Date: Fri, 20 Oct 2023 16:15:58 +0800
Message-ID: <20231020081558.739636-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 849fed8d-8c91-4ceb-3db7-08dbd144d287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIAwOMBd4ZpdTpKcFmXi5CNy8DIYGSl6uUQxA8EjlqV/Vb7zGfs8QvnKCYtlYAgUardsspfirmnxV/+8rphqikBiN+ZYJhjgGI2fUUPOYnAWnkYsJJnzJHW7/onFGYRxT2hKGCcJYyoXg3sFvWvG7unUgLRgdjM0SvObDRN7qsi3QGhC9Ne6Ez6aKTTJ7nY++FPrJXPl248HI/8oaLyX8FKsH/lRtnColZNlyApPFHnHT7YrGrRONccXS4C2TUQZynZ+RBC4s44mFg7xErHsVI97c0tlmlSxgAb/EXGCyFsks9FJG/utuh4OY0whS9+5gMHSH5+3gikNILnTHQhS6zUGJCJlYITf8ppJeNerYiYFNk5bns4KHlhzVhHJbbKoSSIUUrHif96q4l2kwR8lr+3YWg3wCx90jqQ9rBeGSWO2NKKBzJyNZgPex4OYJY7WB0CP+H2Mpzex7Drtr25F6apGs44p9dGDkH7QdDQ49I7UPTO+S+fHuyX4LQOhoD53PEmGCYbLh4uaIgD7HBcDexsTDFieLcEW21dvsu0h3ZaQEzCZ36lRVxoXQzOjsfGP+tryVERlbEJla6g5g+2+xn+56hrh0QRUIBBk/6hOGKNSB8i2XfZhFr5qeT7PZdMQcVkkiQ6P1X8n7Spjclzd1zkeE4EeUAcbXNXq0yBUywhODXh0dPTEySPA+ZmULfAe7/mtfWb/nA2k0HW5G0yPmXWH0hnLLV+1xBsJlgIP4QQrd95drlr1GTi6IiVg5Oz1YP599FiJxuzYiGD1qPuI2AeuyUdqx1zGHlf3Xi8O+bE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(316002)(40460700003)(70586007)(54906003)(70206006)(6916009)(83380400001)(40480700001)(82740400003)(426003)(47076005)(36756003)(26005)(336012)(81166007)(86362001)(356005)(36860700001)(478600001)(7696005)(2906002)(1076003)(2616005)(6666004)(41300700001)(5660300002)(44832011)(8676002)(4326008)(8936002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:16:12.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849fed8d-8c91-4ceb-3db7-08dbd144d287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the high voltage and temperature issue after the driver is unloaded on smu 13.0.0,
smu 13.0.7 and smu 13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 36 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 ++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 +++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 ++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  8 ++++-
 8 files changed, 86 insertions(+), 13 deletions(-)

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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 80ca2c05b0b8..3ad38e42773b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -73,7 +73,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * fini/suspend, so the overall state doesn't
 		 * change over the course of suspend/resume.
 		 */
-		if (!adev->in_s0ix)
+		if (!adev->in_s0ix && adev->gfx.is_poweron)
 			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -85,7 +85,7 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		 * fini/suspend, so the overall state doesn't
 		 * change over the course of suspend/resume.
 		 */
-		if (!adev->in_s0ix)
+		if (!adev->in_s0ix && adev->gfx.is_poweron)
 			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..30e5f7161737 100644
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
 
@@ -1740,10 +1740,25 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_reset_mp1_state(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
+		return smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+	default:
+		return 0;
+	}
+}
+
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1761,7 +1776,15 @@ static int smu_hw_fini(void *handle)
 
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
index 47d008cbc186..0a167f70f4bc 100644
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
+		if(!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
+			ret = smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b8a7a1d853df..d7a4a03b1e31 100644
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
+		if(!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
+			ret = smu_v13_0_disable_pmfw_state(smu);
+
 		break;
 	default:
 		/* Ignore others */
-- 
2.34.1

