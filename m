Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B5410EA0A;
	Fri, 11 Feb 2022 07:53:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B3410EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnHdYQcBdBqDZMeSSqgZnZ2hZ8HUrLCbNm/hdu+ELDe8vPbWnZ39U7/jXTQ3UfsO2kc2xkry786YMji2fyqJzGxOxl9e4rPq+VyZCG2TVxLwU4MPJ4Y2Ofad80zzBq3ms3kYaudUf+AWW2GMhHjZ1SV0I9EtID05m6acfoRkZCdQxIWNC4a33Vk6LDyKVpsESXoxtnk8ThSX78DtoSJVBhu+SbYa9axVlXmi2BCarl4Lhl9wHFIQ5eglT+z7P2xuLRRKp1kfWxPjJWcZ1Gq3vGnxvP2BHpnAB2gsPInbaRGHUzOmbWU8F38vpYI43llh5bvdIXSrz0lJqNR85Uieew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jvut1uEtE0tO/+ksuhDpqWZniWQ5afW4wsWqqh8fi4=;
 b=CBTVBQ+Qg0kSXK7UPidXbtNBYAqFxnCiY5qn6+H/rWQEKhwQox/gbjlaVB9dY824xSNFSyDd42SfZHdzBSsccO7C3hG9TURDjvkE3o6UKcZvEy24n8Mqzj0Tdl6KLnQckfkOmCMGL/4O1pRfm5Bu+lmzxDC6YoL2Kbt65J/DByx8hrUzAhOmDslgfDeI72Gtm3sVe5yYOHsu/HdlaF70LL2eBIa+GZKgpxrrpxziACvgF94Xcvxd67VuD4cFJTIF2uysKbw3mSeYGboT8xc9liQX7mzKHKaP2KYs9jRuig74Dsd9x+gZdUW3rpC8gxJ2VsPsgaJROnZrKIo0X/rqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jvut1uEtE0tO/+ksuhDpqWZniWQ5afW4wsWqqh8fi4=;
 b=KYzkYCpJMELt1gL4oro/mSR0OHZYNNVdHlglNgdVJNvx6qe3BSkCZuKUZmpc7AQ6eCbAVPGCe4+VrZMW4MGXdCMwYub28tmXOi1c0QobltnqDPa0GerZ44/BXQGz1cz5Ys9kGozACOAfby1+Ur+6EkVQb3TyFbnCYdcApsmonHc=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:53:02 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::7b) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 07:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:53:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:53:00 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/pm: revise the implementations for asic reset
Date: Fri, 11 Feb 2022 15:52:09 +0800
Message-ID: <20220211075209.894833-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220211075209.894833-1-evan.quan@amd.com>
References: <20220211075209.894833-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92035ca-edf6-4570-1d37-08d9ed3387e9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878ACC7E5F6F0958C9DC514E4309@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0W6jn4ErVT3mHier6+sGCEJTaiJtwhgvJTOrs1BwQ1YQuF3AYPMJHmtd6CeXJqBw4Bbfc5Qf5i71nkVrOmKXhenIUSX48ByGgFRIYSm75T8lk2vJO70bpFtmQPH8HIBQi8ytO75DOnzWn8vtDQK3hpYc/M+QBluLbK8o27PezXJDnHHBTRUvUevJpRpPbMRcFIyeZ/zZEaQqgnVuElMHGg2mow2EVdXeJQr53/SPGkfw67gS4OXantJnksclMRwJTt+f4z8PT+ixNIyolVPrUuVnegvHYHCtUElJNOis5qiUMwP1UQRcjkMqw+J4y5YUHD7VjTaL+WEf8mf9CS1UWfuFzFDxFEVWvjlxWaW8yCspgrvSa0i5A6ZLTL/+Az3gnv6lNhFoQ3Uax7sKgf9uBuX8HQZm2LBq4sM146zA1SG/+g3OphaCAfBYhLw/df92Fbl+kSO1UnUtnMP3YfudqwRzHmAR9qbm+EFSF/ITLRtN+m6vJJeAeBxecvCt/et8ZTMm1+kbpCFGwQJ22cEzkr2JeZmoNYdZZslHy22mVpF8FA/fBMzTIDec6Sk9kHaHPTaT6u+w0vufADvVoKk5I2Gm7Bo8blgVUbFJBZf+Sf6yK2JLs1oQ6C38F2Dr/vgT79TEVHwHtNM7XSLCngG4Pv6S3PD9xxex3L542Emv+QbmvYemd3IzRSGWOziD5i5xj9va6ksM650LUpDsDoCWmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(336012)(426003)(1076003)(2616005)(26005)(7696005)(5660300002)(36756003)(82310400004)(16526019)(86362001)(508600001)(44832011)(30864003)(6916009)(4326008)(70586007)(83380400001)(36860700001)(70206006)(81166007)(8936002)(8676002)(47076005)(54906003)(356005)(40460700003)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:53:02.7858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92035ca-edf6-4570-1d37-08d9ed3387e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, rui.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of having an interface for every reset method, we replace them
with a new interface which can support all reset methods.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I4c8a7121dd65c2671085673dd7c13cf7e4286f3d
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  13 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  12 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   7 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  89 ++-----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  13 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  86 ++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 126 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   3 -
 12 files changed, 180 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index a545df4efce1..22b787de313a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -128,7 +128,7 @@ static int aldebaran_mode2_reset(struct amdgpu_device *adev)
 {
 	/* disable BM */
 	pci_clear_master(adev->pdev);
-	adev->asic_reset_res = amdgpu_dpm_mode2_reset(adev);
+	adev->asic_reset_res = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
 	return adev->asic_reset_res;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7931132ce6e3..b19bfdf81500 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4504,9 +4504,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 
         amdgpu_device_cache_pci_state(adev->pdev);
 
-        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+        if (amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_MODE1)) {
                 dev_info(adev->dev, "GPU smu mode1 reset\n");
-                ret = amdgpu_dpm_mode1_reset(adev);
+                ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE1);
         } else {
                 dev_info(adev->dev, "GPU psp mode1 reset\n");
                 ret = psp_gpu_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index f10ce740a29c..786975716eb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1380,7 +1380,7 @@ static bool cik_asic_supports_baco(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
-		return amdgpu_dpm_is_baco_supported(adev);
+		return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 	default:
 		return false;
 	}
@@ -1434,7 +1434,7 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 		dev_info(adev->dev, "BACO reset\n");
-		r = amdgpu_dpm_baco_reset(adev);
+		r = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
 	} else {
 		dev_info(adev->dev, "PCI CONFIG reset\n");
 		r = cik_asic_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 494e17f65fc3..2e590008d3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -414,7 +414,7 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 
 	amdgpu_device_cache_pci_state(adev->pdev);
 
-	ret = amdgpu_dpm_mode2_reset(adev);
+	ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
 	if (ret)
 		dev_err(adev->dev, "GPU mode2 reset failed\n");
 
@@ -458,7 +458,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 13):
 		return AMD_RESET_METHOD_MODE1;
 	default:
-		if (amdgpu_dpm_is_baco_supported(adev))
+		if (amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO))
 			return AMD_RESET_METHOD_BACO;
 		else
 			return AMD_RESET_METHOD_MODE1;
@@ -476,7 +476,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	case AMD_RESET_METHOD_BACO:
 		dev_info(adev->dev, "BACO reset\n");
-		ret = amdgpu_dpm_baco_reset(adev);
+		ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
 		break;
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n");
@@ -641,6 +641,11 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool nv_asic_supports_baco(struct amdgpu_device *adev)
+{
+	return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
+}
+
 static const struct amdgpu_asic_funcs nv_asic_funcs =
 {
 	.read_disabled_bios = &nv_read_disabled_bios,
@@ -657,7 +662,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
-	.supports_baco = &amdgpu_dpm_is_baco_supported,
+	.supports_baco = &nv_asic_supports_baco,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 	.query_video_codecs = &nv_query_video_codecs,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a216e625c89c..15ee56406bc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -508,7 +508,7 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
 	if (ras && adev->ras_enabled)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
-	ret = amdgpu_dpm_baco_reset(adev);
+	ret = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
 	if (ret)
 		return ret;
 
@@ -553,7 +553,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 		if (adev->asic_type == CHIP_VEGA20) {
 			if (adev->psp.sos.fw_version >= 0x80067)
-				baco_reset = amdgpu_dpm_is_baco_supported(adev);
+				baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 			/*
 			 * 1. PMFW version > 0x284300: all cases use baco
 			 * 2. PMFW version <= 0x284300: only sGPU w/o RAS use baco
@@ -562,7 +562,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 			    adev->pm.fw_version <= 0x283400)
 				baco_reset = false;
 		} else {
-			baco_reset = amdgpu_dpm_is_baco_supported(adev);
+			baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 		}
 		break;
 	case IP_VERSION(13, 0, 2):
@@ -599,7 +599,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 		return soc15_asic_baco_reset(adev);
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n");
-		return amdgpu_dpm_mode2_reset(adev);
+		return amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_MODE2);
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
 		return amdgpu_device_mode1_reset(adev);
@@ -613,10 +613,10 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 		if (adev->asic_type == CHIP_VEGA20) {
 			if (adev->psp.sos.fw_version >= 0x80067)
-				return amdgpu_dpm_is_baco_supported(adev);
+				return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 			return false;
 		} else {
-			return amdgpu_dpm_is_baco_supported(adev);
+			return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6645ebbd2696..de510de5e62a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,7 +904,7 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		return amdgpu_dpm_is_baco_supported(adev);
+		return amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 	default:
 		return false;
 	}
@@ -930,7 +930,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		baco_reset = amdgpu_dpm_is_baco_supported(adev);
+		baco_reset = amdgpu_dpm_is_asic_reset_supported(adev, AMD_RESET_METHOD_BACO);
 		break;
 	default:
 		baco_reset = false;
@@ -962,7 +962,7 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 		dev_info(adev->dev, "BACO reset\n");
-		r = amdgpu_dpm_baco_reset(adev);
+		r = amdgpu_dpm_asic_reset(adev, AMD_RESET_METHOD_BACO);
 	} else {
 		dev_info(adev->dev, "PCI CONFIG reset\n");
 		r = vi_asic_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 892648a4a353..8d9c32e70532 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -300,6 +300,7 @@ struct amd_pp_clocks;
 struct pp_smu_wm_range_sets;
 struct pp_smu_nv_clock_table;
 struct dpm_clocks;
+enum amd_reset_method;
 
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
@@ -387,12 +388,10 @@ struct amd_pm_funcs {
 	int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
-	int (*get_asic_baco_capability)(void *handle, bool *cap);
 	int (*get_asic_baco_state)(void *handle, int *state);
 	int (*set_asic_baco_state)(void *handle, int state);
 	int (*get_ppfeature_status)(void *handle, char *buf);
 	int (*set_ppfeature_status)(void *handle, uint64_t ppfeature_masks);
-	int (*asic_reset_mode_2)(void *handle);
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
@@ -410,6 +409,10 @@ struct amd_pm_funcs {
 	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
 	void (*pm_compute_clocks)(void *handle);
 	bool (*is_smc_alive)(void *handle);
+	int (*is_asic_reset_supported)(void *handle,
+				       enum amd_reset_method reset_method);
+	int (*asic_reset)(void *handle,
+			  enum amd_reset_method reset_method);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f237dd3a3f66..b72945f6a338 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -196,107 +196,42 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	return ret;
 }
 
-bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
+int amdgpu_dpm_is_asic_reset_supported(struct amdgpu_device *adev,
+				       enum amd_reset_method reset_method)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	void *pp_handle = adev->powerplay.pp_handle;
-	bool baco_cap;
-	int ret = 0;
+	int reset_supported = false;
 
 	if (!amdgpu_dpm_is_smc_alive(adev))
 		return false;
 
-	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
+	if (!pp_funcs || !pp_funcs->is_asic_reset_supported)
 		return false;
 
 	mutex_lock(&adev->pm.mutex);
-
-	ret = pp_funcs->get_asic_baco_capability(pp_handle,
-						 &baco_cap);
-
+	reset_supported = pp_funcs->is_asic_reset_supported(adev->powerplay.pp_handle,
+							    reset_method);
 	mutex_unlock(&adev->pm.mutex);
 
-	return ret ? false : baco_cap;
+	return reset_supported;
 }
 
-int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
+int amdgpu_dpm_asic_reset(struct amdgpu_device *adev,
+			  enum amd_reset_method reset_method)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	void *pp_handle = adev->powerplay.pp_handle;
 	int ret = 0;
 
 	if (!amdgpu_dpm_is_smc_alive(adev))
 		return -EOPNOTSUPP;
 
-	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
-		return -ENOENT;
-
-	mutex_lock(&adev->pm.mutex);
-
-	ret = pp_funcs->asic_reset_mode_2(pp_handle);
-
-	mutex_unlock(&adev->pm.mutex);
-
-	return ret;
-}
-
-int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
-{
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	void *pp_handle = adev->powerplay.pp_handle;
-	int ret = 0;
-
-	if (!amdgpu_dpm_is_smc_alive(adev))
+	if (!pp_funcs || !pp_funcs->asic_reset)
 		return -EOPNOTSUPP;
 
-	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
-		return -ENOENT;
-
 	mutex_lock(&adev->pm.mutex);
-
-	/* enter BACO state */
-	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-	if (ret)
-		goto out;
-
-	/* exit BACO state */
-	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-
-out:
+	ret = pp_funcs->asic_reset(adev->powerplay.pp_handle,
+				   reset_method);
 	mutex_unlock(&adev->pm.mutex);
-	return ret;
-}
-
-bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	bool support_mode1_reset = false;
-
-	if (!amdgpu_dpm_is_smc_alive(adev))
-		return false;
-
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		support_mode1_reset = smu_mode1_reset_is_support(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return support_mode1_reset;
-}
-
-int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
-
-	if (!amdgpu_dpm_is_smc_alive(adev))
-		return -EOPNOTSUPP;
-
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_mode1_reset(smu);
-		mutex_unlock(&adev->pm.mutex);
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 49488aebd350..bda8b8149497 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -374,15 +374,6 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
 
-int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
-
-int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
-
-bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
-
-bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
-int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
-
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
@@ -542,4 +533,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+int amdgpu_dpm_is_asic_reset_supported(struct amdgpu_device *adev,
+				       enum amd_reset_method reset_method);
+int amdgpu_dpm_asic_reset(struct amdgpu_device *adev,
+			  enum amd_reset_method reset_method);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 81ec5464b679..3edc05296e01 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1177,20 +1177,6 @@ static int pp_set_active_display_count(void *handle, uint32_t count)
 	return phm_set_active_display_count(hwmgr, count);
 }
 
-static int pp_get_asic_baco_capability(void *handle, bool *cap)
-{
-	struct pp_hwmgr *hwmgr = handle;
-
-	*cap = false;
-
-	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
-		return 0;
-
-	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
-
-	return 0;
-}
-
 static int pp_get_asic_baco_state(void *handle, int *state)
 {
 	struct pp_hwmgr *hwmgr = handle;
@@ -1242,18 +1228,6 @@ static int pp_set_ppfeature_status(void *handle, uint64_t ppfeature_masks)
 	return hwmgr->hwmgr_func->set_ppfeature_status(hwmgr, ppfeature_masks);
 }
 
-static int pp_asic_reset_mode_2(void *handle)
-{
-	struct pp_hwmgr *hwmgr = handle;
-
-	if (hwmgr->hwmgr_func->asic_reset == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return -EINVAL;
-	}
-
-	return hwmgr->hwmgr_func->asic_reset(hwmgr, SMU_ASIC_RESET_MODE_2);
-}
-
 static int pp_smu_i2c_bus_access(void *handle, bool acquire)
 {
 	struct pp_hwmgr *hwmgr = handle;
@@ -1394,6 +1368,62 @@ static bool pp_is_smc_alive(void *handle)
 	return false;
 }
 
+static int pp_is_asic_reset_supported(void *handle,
+				       enum amd_reset_method reset_method)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	bool reset_supported = false;
+
+	switch (reset_method) {
+	case AMD_RESET_METHOD_BACO:
+		if (hwmgr->hwmgr_func->get_asic_baco_capability)
+			hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr,
+								    &reset_supported);
+		break;
+	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_MODE2:
+	default:
+		break;
+	}
+
+	return reset_supported;
+}
+
+static int pp_asic_reset(void *handle,
+			 enum amd_reset_method reset_method)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	int ret = 0;
+
+	switch (reset_method) {
+	case AMD_RESET_METHOD_MODE1:
+		return -EOPNOTSUPP;
+	case AMD_RESET_METHOD_MODE2:
+		if (!hwmgr->hwmgr_func->asic_reset)
+			return -EOPNOTSUPP;
+
+		ret = hwmgr->hwmgr_func->asic_reset(hwmgr,
+						    SMU_ASIC_RESET_MODE_2);
+		break;
+	case AMD_RESET_METHOD_BACO:
+		if (!hwmgr->hwmgr_func->set_asic_baco_state)
+			return -EOPNOTSUPP;
+
+		ret = hwmgr->hwmgr_func->set_asic_baco_state(hwmgr,
+							     BACO_STATE_IN);
+		if (ret)
+			return ret;
+
+		ret = hwmgr->hwmgr_func->set_asic_baco_state(hwmgr,
+							     BACO_STATE_OUT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1446,12 +1476,10 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.set_min_deep_sleep_dcefclk = pp_set_min_deep_sleep_dcefclk,
 	.set_hard_min_dcefclk_by_freq = pp_set_hard_min_dcefclk_by_freq,
 	.set_hard_min_fclk_by_freq = pp_set_hard_min_fclk_by_freq,
-	.get_asic_baco_capability = pp_get_asic_baco_capability,
 	.get_asic_baco_state = pp_get_asic_baco_state,
 	.set_asic_baco_state = pp_set_asic_baco_state,
 	.get_ppfeature_status = pp_get_ppfeature_status,
 	.set_ppfeature_status = pp_set_ppfeature_status,
-	.asic_reset_mode_2 = pp_asic_reset_mode_2,
 	.smu_i2c_bus_access = pp_smu_i2c_bus_access,
 	.set_df_cstate = pp_set_df_cstate,
 	.set_xgmi_pstate = pp_set_xgmi_pstate,
@@ -1460,4 +1488,6 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
 	.pm_compute_clocks = pp_pm_compute_clocks,
 	.is_smc_alive = pp_is_smc_alive,
+	.is_asic_reset_supported = pp_is_asic_reset_supported,
+	.asic_reset = pp_asic_reset,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3773e95a18bf..bab5ddc667f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2503,18 +2503,6 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-static int smu_get_baco_capability(void *handle, bool *cap)
-{
-	struct smu_context *smu = handle;
-
-	*cap = false;
-
-	if (smu->ppt_funcs->baco_is_support)
-		*cap = smu->ppt_funcs->baco_is_support(smu);
-
-	return 0;
-}
-
 static int smu_baco_set_state(void *handle, int state)
 {
 	struct smu_context *smu = handle;
@@ -2537,40 +2525,6 @@ static int smu_baco_set_state(void *handle, int state)
 	return ret;
 }
 
-bool smu_mode1_reset_is_support(struct smu_context *smu)
-{
-	bool ret = false;
-
-	if (smu->ppt_funcs->mode1_reset_is_support)
-		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
-
-	return ret;
-}
-
-int smu_mode1_reset(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (smu->ppt_funcs->mode1_reset)
-		ret = smu->ppt_funcs->mode1_reset(smu);
-
-	return ret;
-}
-
-static int smu_mode2_reset(void *handle)
-{
-	struct smu_context *smu = handle;
-	int ret = 0;
-
-	if (smu->ppt_funcs->mode2_reset)
-		ret = smu->ppt_funcs->mode2_reset(smu);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
-
-	return ret;
-}
-
 static int smu_get_max_sustainable_clocks_by_dc(void *handle,
 						struct pp_smu_nv_clock_table *max_clocks)
 {
@@ -2705,6 +2659,82 @@ static bool smu_is_smc_alive(void *handle)
 	return false;
 }
 
+static int smu_is_asic_reset_supported(void *handle,
+				       enum amd_reset_method reset_method)
+{
+	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
+	int reset_supported = false;
+
+	switch (reset_method) {
+	case AMD_RESET_METHOD_MODE1:
+		if (smu->ppt_funcs->mode1_reset_is_support)
+			reset_supported = smu->ppt_funcs->mode1_reset_is_support(smu);
+		break;
+	case AMD_RESET_METHOD_MODE2:
+		switch (adev->ip_versions[MP1_HWIP][0]) {
+		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(13, 0, 2):
+		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 3):
+			reset_supported = true;
+			break;
+		default:
+			break;
+		}
+		break;
+	case AMD_RESET_METHOD_BACO:
+		if (smu->ppt_funcs->baco_is_support)
+			reset_supported = smu->ppt_funcs->baco_is_support(smu);
+		break;
+	default:
+		break;
+	}
+
+	return reset_supported;
+}
+
+static int smu_asic_reset(void *handle,
+			  enum amd_reset_method reset_method)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	switch (reset_method) {
+	case AMD_RESET_METHOD_MODE1:
+		if (!smu->ppt_funcs->mode1_reset)
+			return -EOPNOTSUPP;
+
+		ret = smu->ppt_funcs->mode1_reset(smu);
+		break;
+	case AMD_RESET_METHOD_MODE2:
+		if (!smu->ppt_funcs->mode2_reset)
+			return -EOPNOTSUPP;
+
+		ret = smu->ppt_funcs->mode2_reset(smu);
+		if (ret)
+			dev_err(smu->adev->dev, "Mode2 reset failed!\n");
+		break;
+	case AMD_RESET_METHOD_BACO:
+		if (!smu->ppt_funcs->baco_enter ||
+		    !smu->ppt_funcs->baco_exit)
+			return -EOPNOTSUPP;
+
+		ret = smu->ppt_funcs->baco_enter(smu);
+		if (ret)
+			return ret;
+
+		ret = smu->ppt_funcs->baco_exit(smu);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
 	.set_fan_control_mode    = smu_set_fan_control_mode,
@@ -2744,11 +2774,9 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.enable_mgpu_fan_boost            = smu_enable_mgpu_fan_boost,
 	.set_active_display_count         = smu_set_display_count,
 	.set_min_deep_sleep_dcefclk       = smu_set_deep_sleep_dcefclk,
-	.get_asic_baco_capability         = smu_get_baco_capability,
 	.set_asic_baco_state              = smu_baco_set_state,
 	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
-	.asic_reset_mode_2                = smu_mode2_reset,
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
 	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
@@ -2759,6 +2787,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 	.is_smc_alive = smu_is_smc_alive,
+	.is_asic_reset_supported = smu_is_asic_reset_supported,
+	.asic_reset              = smu_asic_reset,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index bced761f3f96..ce9cd0522a40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1392,9 +1392,6 @@ int smu_get_power_limit(void *handle,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_type pp_power_type);
 
-bool smu_mode1_reset_is_support(struct smu_context *smu);
-int smu_mode1_reset(struct smu_context *smu);
-
 extern const struct amd_ip_funcs smu_ip_funcs;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
-- 
2.29.0

