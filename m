Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BB2C54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 22:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E361125DE;
	Fri, 15 Mar 2024 22:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZLDvvrVm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72DA1125DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 22:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0vvGVD6txsK1T6FGJw6gParO3jL+Dqq2Nl9OJHAr+oGCzdprSkcbXaFPvXAmuynPubqGFaYV8lfuqJhEX+fpif3GPLz6L3hCuVjUtJ5kV+7QxtxDA50Rb6aDh+cJzsF+9+GbwN3J0cLVZmAjf0OkmU84ku8ROqJjWnBeg8kmZVo6nU8uvRwX640nSYSOdHws8p/N1vV/B0Q604CGiCAX/pMs09hJF771QGnCouOikykoKMorsrKxSpDcFwIFZB21/DjwknDrTAYagabSY64mXw6MNA9MQSZ/M0cxzDUpqMQMMf7fhOCmmhzbxwp692TJwWPPjBjtJ7KjIUr1ccreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9+i4+gW2HTKm3nl887d94fY5Jw8A0T3qOsZBq2iMoQ=;
 b=MXYAsi4GepEMAtvueZyhvSJd/FfEKlGIJzPwjvI+XW90S9/TVVLtavakmgE4JNla8BoAZb0nHGAxzbSoD9FfQF9m+dAwUll5YsbrZCe7sI7p7Q8qfPiBU8tjLkhvZOI8TPJ9D4SEjAcyXTLx7LYiUbpstmP2t9TEXNvpD6st0Fl+yWF6zFoy2bshfk8lQ89aNX9rFrH4m4GSKgMO4tU88TSSKG1X//8cgahOLrEYdLXK+iGjsF9iuY0RxRxXOUy55HgCAQvi+tz6ETSXd7so5KYroBiIWSprTxlW/8lsyPzMPY2VQRkPGZIWtnTi+e5EERtRMd2PpyOjCD7IG1kg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9+i4+gW2HTKm3nl887d94fY5Jw8A0T3qOsZBq2iMoQ=;
 b=ZLDvvrVmLVul7LA6yz8IRRWbYoMBZ0aSC95vHGZjuMl5d471fM4xLaMZafyR7kuxZiHf1WVIDAaWe69LRQelenDYC2T0lkFhWNXMgsgqwX+Lp12I02a+j/4KPKsf3g8BCOQfT1ZLxBNsbcuwPuBiRsWWFrbrG4aMaQQ2DkquscA=
Received: from BY5PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:1e0::35)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 22:07:06 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::b2) by BY5PR03CA0025.outlook.office365.com
 (2603:10b6:a03:1e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Fri, 15 Mar 2024 22:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 22:07:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 17:07:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: lima1002 <li.ma@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/swsmu: add smu 14.0.1 vcn and jpeg msg
Date: Fri, 15 Mar 2024 18:06:44 -0400
Message-ID: <20240315220644.4061334-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd00c60-0fab-4823-3291-08dc453c4034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f10mimq7e6iKMFOKHCAhmxJ7XU/xC9XDrrB6ZH40M5K/ZZRLsvmc0zbCLRPe5453cXLJ4rvGsmhTITCZ/mVxaHcjs1N4V9a77OiA/V2WtXHECwWAmvDw0l+HHCV48r0poyUfESxdTad3uz1thYngPgSMkBwa6GVAgzrU0F4w+lbCOnqZ+xElywkB9F4t6/SunFoxBnkg2QWAkDX3JotkkjJlrVVM2OOhFV7z91KRTXefS6cO2SrhcZcAlsRqsfuluXH1DM0meGQNV8PFc34zOwsYpWcx6ob6l1WpVTEP0i2DZ0JQUzz52lVQBSFbGA65dXziaEQTWZQHMCm81PJ8OEy/vD/pEmNe9sGDaYgrmPXaCW4vE/ckxWwdsA0UPbhW04krWes7Sc26bhHfdyjqSxUIZKCxsyYsLeoyU2+iCJ1umq1uPHxV7fpI1ybU8VpiViAuH2atgePxLFkDEH8HlDVsvQFaLz4Vbtseh+DNbpMbAAzEE8yajb+sBXIgm7P5kA1j5okvjLFEMV2GEyH7/nRK3/0DlZrzFmJgRM7PhucKCWqImNkTj9wE50pxcP39hnVfC/TRHyMhzDHVHMDcaI4zCGeQp08sexmMKo1jAZ+dRPQotjIZT1Md1PwtoPkBLvzO6nBqhaoIRoGo5jT2U6NsbfQrkKi8XpXFUFAmAtjLFcA3a9/UtoT4qVErxzjtVlbxDnOe/DdfqXJvJoq3v4TbISnwUk+qh2K1eDpN1vGy75eakxbWEzrJ1P6Qmhd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 22:07:05.6190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd00c60-0fab-4823-3291-08dc453c4034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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

From: lima1002 <li.ma@amd.com>

add new vcn and jpeg msg

v2: squash in updates (Alex)
v3: rework code for better compat with other smu14.x variants (Alex)

Signed-off-by: lima1002 <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  | 28 +++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  | 10 ++++
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 50 ++++++++++++++++---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 21 +++++---
 4 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
index 8a8a57c56bc0..ca7ce4251482 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -54,14 +54,14 @@
 #define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
 #define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
 #define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
-#define PPSMC_MSG_SPARE0                        0x04 ///< SPARE
-#define PPSMC_MSG_SPARE1                        0x05 ///< SPARE
-#define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
-#define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
-#define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
+#define PPSMC_MSG_PowerDownVcn1                 0x04 ///< Power down VCN1
+#define PPSMC_MSG_PowerUpVcn1                   0x05 ///< Power up VCN1; VCN1 is power gated by default
+#define PPSMC_MSG_PowerDownVcn0                 0x06 ///< Power down VCN0
+#define PPSMC_MSG_PowerUpVcn0                   0x07 ///< Power up VCN0; VCN0 is power gated by default
+#define PPSMC_MSG_SetHardMinVcn0                0x08 ///< For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_SPARE2                        0x0A ///< SPARE
-#define PPSMC_MSG_SPARE3                        0x0B ///< SPARE
+#define PPSMC_MSG_SetHardMinVcn1                0x0A ///< For wireless display
+#define PPSMC_MSG_SetSoftMinVcn1                0x0B ///< Set soft min for VCN1 clocks (VCLK1 and DCLK1)
 #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
 #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
 #define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits of DRAM address for Driver table transfer
@@ -71,7 +71,7 @@
 #define PPSMC_MSG_GetEnabledSmuFeatures         0x12 ///< Get enabled features in PMFW
 #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
-#define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_SetSoftMinVcn0                0x15 ///< Set soft min for VCN0 clocks (VCLK0 and DCLK0)
 
 #define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
 
@@ -84,17 +84,17 @@
 
 #define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x1D ///< Set soft max for SOC CLK
 #define PPSMC_MSG_SetSoftMaxFclkByFreq          0x1E ///< Set soft max for FCLK
-#define PPSMC_MSG_SetSoftMaxVcn                 0x1F ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_SetSoftMaxVcn0                0x1F ///< Set soft max for VCN0 clocks (VCLK0 and DCLK0)
 #define PPSMC_MSG_spare_0x20                    0x20
-#define PPSMC_MSG_PowerDownJpeg                 0x21 ///< Power down Jpeg
-#define PPSMC_MSG_PowerUpJpeg                   0x22 ///< Power up Jpeg; VCN is power gated by default
+#define PPSMC_MSG_PowerDownJpeg0                0x21 ///< Power down Jpeg of VCN0
+#define PPSMC_MSG_PowerUpJpeg0                  0x22 ///< Power up Jpeg of VCN0; VCN0 is power gated by default
 
 #define PPSMC_MSG_SetHardMinFclkByFreq          0x23 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinSocclkByFreq        0x24 ///< Set soft min for SOC CLK
 #define PPSMC_MSG_AllowZstates                  0x25 ///< Inform PMFM of allowing Zstate entry, i.e. no Miracast activity
-#define PPSMC_MSG_Reserved                      0x26 ///< Not used
-#define PPSMC_MSG_Reserved1                     0x27 ///< Not used, previously PPSMC_MSG_RequestActiveWgp
-#define PPSMC_MSG_Reserved2                     0x28 ///< Not used, previously PPSMC_MSG_QueryActiveWgp
+#define PPSMC_MSG_PowerDownJpeg1                0x26 ///< Power down Jpeg of VCN1
+#define PPSMC_MSG_PowerUpJpeg1                  0x27 ///< Power up Jpeg of VCN1; VCN1 is power gated by default
+#define PPSMC_MSG_SetSoftMaxVcn1                0x28 ///< Set soft max for VCN1 clocks (VCLK1 and DCLK1)
 #define PPSMC_MSG_PowerDownIspByTile            0x29 ///< ISP is power gated by default
 #define PPSMC_MSG_PowerUpIspByTile              0x2A ///< This message is used to power up ISP tiles and enable the ISP DPM
 #define PPSMC_MSG_SetHardMinIspiclkByFreq       0x2B ///< Set HardMin by frequency for ISPICLK
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index a941fdbf78b6..af427cc7dbb8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -115,6 +115,10 @@
        __SMU_DUMMY_MAP(PowerDownVcn),                 \
        __SMU_DUMMY_MAP(PowerUpJpeg),                  \
        __SMU_DUMMY_MAP(PowerDownJpeg),                \
+       __SMU_DUMMY_MAP(PowerUpJpeg0),                 \
+       __SMU_DUMMY_MAP(PowerDownJpeg0),               \
+       __SMU_DUMMY_MAP(PowerUpJpeg1),                 \
+       __SMU_DUMMY_MAP(PowerDownJpeg1),               \
        __SMU_DUMMY_MAP(BacoAudioD3PME),               \
        __SMU_DUMMY_MAP(ArmD3),                        \
        __SMU_DUMMY_MAP(RunDcBtc),                     \
@@ -135,6 +139,8 @@
 	__SMU_DUMMY_MAP(PowerUpSdma),                 \
 	__SMU_DUMMY_MAP(SetHardMinIspclkByFreq),      \
 	__SMU_DUMMY_MAP(SetHardMinVcn),               \
+       __SMU_DUMMY_MAP(SetHardMinVcn0),               \
+       __SMU_DUMMY_MAP(SetHardMinVcn1),               \
 	__SMU_DUMMY_MAP(SetAllowFclkSwitch),          \
 	__SMU_DUMMY_MAP(SetMinVideoGfxclkFreq),       \
 	__SMU_DUMMY_MAP(ActiveProcessNotify),         \
@@ -150,6 +156,8 @@
 	__SMU_DUMMY_MAP(SetPhyclkVoltageByFreq),      \
 	__SMU_DUMMY_MAP(SetDppclkVoltageByFreq),      \
 	__SMU_DUMMY_MAP(SetSoftMinVcn),               \
+       __SMU_DUMMY_MAP(SetSoftMinVcn0),              \
+       __SMU_DUMMY_MAP(SetSoftMinVcn1),              \
 	__SMU_DUMMY_MAP(EnablePostCode),              \
 	__SMU_DUMMY_MAP(GetGfxclkFrequency),          \
 	__SMU_DUMMY_MAP(GetFclkFrequency),            \
@@ -161,6 +169,8 @@
 	__SMU_DUMMY_MAP(SetSoftMaxSocclkByFreq),      \
 	__SMU_DUMMY_MAP(SetSoftMaxFclkByFreq),        \
 	__SMU_DUMMY_MAP(SetSoftMaxVcn),               \
+       __SMU_DUMMY_MAP(SetSoftMaxVcn0),              \
+       __SMU_DUMMY_MAP(SetSoftMaxVcn1),              \
 	__SMU_DUMMY_MAP(PowerGateMmHub),              \
 	__SMU_DUMMY_MAP(UpdatePmeRestore),            \
 	__SMU_DUMMY_MAP(GpuChangeState),              \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index b06a3cc43305..9e39f99154f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1402,9 +1402,22 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      i << 16U, NULL);
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
+		    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+			if (i == 0)
+				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+								      i << 16U, NULL);
+			else if (i == 1)
+				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+								      i << 16U, NULL);
+		} else {
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+							      i << 16U, NULL);
+		}
+
 		if (ret)
 			return ret;
 	}
@@ -1415,9 +1428,34 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
-					       0, NULL);
+	struct amdgpu_device *adev = smu->adev;
+	int i, ret = 0;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0) ||
+		    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+			if (i == 0)
+				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+								      SMU_MSG_PowerUpJpeg0 : SMU_MSG_PowerDownJpeg0,
+								      i << 16U, NULL);
+			else if (i == 1 && amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+								      SMU_MSG_PowerUpJpeg1 : SMU_MSG_PowerDownJpeg1,
+								      i << 16U, NULL);
+		} else {
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
+							      i << 16U, NULL);
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 int smu_v14_0_run_btc(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 9310c4758e38..d6de6d97286c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -70,9 +70,12 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,				1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetPmfwVersion,			1),
 	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
-	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,				1),
-	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,				1),
-	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,			1),
+	MSG_MAP(PowerDownVcn0,                  PPSMC_MSG_PowerDownVcn0,			1),
+	MSG_MAP(PowerUpVcn0,                    PPSMC_MSG_PowerUpVcn0,				1),
+	MSG_MAP(SetHardMinVcn0,                 PPSMC_MSG_SetHardMinVcn0,			1),
+	MSG_MAP(PowerDownVcn1,                  PPSMC_MSG_PowerDownVcn1,			1),
+	MSG_MAP(PowerUpVcn1,                    PPSMC_MSG_PowerUpVcn1,				1),
+	MSG_MAP(SetHardMinVcn1,                 PPSMC_MSG_SetHardMinVcn1,			1),
 	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,			1),
 	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,		1),
 	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
@@ -83,7 +86,8 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
 	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	1),
 	MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,			1),
-	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,			1),
+	MSG_MAP(SetSoftMinVcn0,                 PPSMC_MSG_SetSoftMinVcn0,			1),
+	MSG_MAP(SetSoftMinVcn1,                 PPSMC_MSG_SetSoftMinVcn1,			1),
 	MSG_MAP(EnableGfxImu,                   PPSMC_MSG_EnableGfxImu,				1),
 	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,				1),
 	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,			1),
@@ -91,9 +95,12 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,			1),
 	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
 	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
-	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,			1),
-	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,			1),
-	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,				1),
+	MSG_MAP(SetSoftMaxVcn0,                 PPSMC_MSG_SetSoftMaxVcn0,			1),
+	MSG_MAP(SetSoftMaxVcn1,                 PPSMC_MSG_SetSoftMaxVcn1,			1),
+	MSG_MAP(PowerDownJpeg0,                 PPSMC_MSG_PowerDownJpeg0,			1),
+	MSG_MAP(PowerUpJpeg0,                   PPSMC_MSG_PowerUpJpeg0,				1),
+	MSG_MAP(PowerDownJpeg1,                 PPSMC_MSG_PowerDownJpeg1,			1),
+	MSG_MAP(PowerUpJpeg1,                   PPSMC_MSG_PowerUpJpeg1,				1),
 	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		1),
 	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
 	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,		1),
-- 
2.44.0

