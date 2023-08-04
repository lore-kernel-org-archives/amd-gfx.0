Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A3DC001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 10:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C303510E6C8;
	Fri,  4 Aug 2023 10:21:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C7F10E6C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 10:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6GM2FR8MhbOfxOPPqRbbbAU2J3at/WMq1rS52sAqHMjUNj0C0qZ61zJfeTHCbn7F01dryy4MmO1/vHfEFr6zku7bmk+pz25IOQnCi3DkTrmWBbxx0ajHxDwrl+o2LIvfCt01jfmu0n4T1epHREkY1tHg00CXFq2jofMStocbl5pLN+Css+xecG8z/Lz0zOlzdQnfY1F++SsoPEvgZh+V2+Z17SuxoNTegGEax218fAgC1OC9frbjC/lls0TtYmgiOWQDfRlFYxqRxDKTd0v4jMX7nfhWPlWTXc+T+rd/zGysX8HxUpCazFsUuPlbXCTv8IoA3f3S3rywR/EaQgIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w7FiACnCt1096GD685+A9kmKPLKmhg5edcFMEq+WNk=;
 b=dFNR3imKAlH0onxpTT2ecVNH+9pRTc7EwwIQi32MLmEa7B+JPb/aIWC3XOCy0zDobk6kFRSVWCBDl5sm5VKZtBXMAAFoB/21ErBicxNwgIVGWQOMotc0TDjePJftJuYyiY7Sf0Sq3IhGNBiWhTaa3EFk7WQQ7zkTfZIyx9CQkZYN/LYm6xjYHVL5dVcK1L7SbcaR3jJ/6xRuhe8a+y/wW3j4Vp6KPKx+tbybAFIM/3rHm2YQ7z5CPisGec6RDCPkCKLbPSSa9HjeVt+eMGwYHU2Q2T946sBJfViOx5muINAvM537YWb+Ki7a0O3yJccKqmEbk4oZbzQdqhbCCi771Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w7FiACnCt1096GD685+A9kmKPLKmhg5edcFMEq+WNk=;
 b=tV2r18hYlfR6s9PGTbKeKTyERaAdAg6TIxx6C46y6PpUsayBi/x1ADfImiKC4rAftlFJfPhQiBhmoezKs2DPJk+4hnq0QkuwniSfHva9E7KBe5dS0K4b3/mBYzbcY75H9GPA3h63koEfEc9OHoTqWO0CZncBWe8b6W32z7TsMac=
Received: from CY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:930:17::13)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 10:21:48 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::87) by CY5PR17CA0026.outlook.office365.com
 (2603:10b6:930:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 10:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 10:21:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 05:21:45 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update smu_v13_0_6 message vf flag
Date: Fri, 4 Aug 2023 18:21:27 +0800
Message-ID: <20230804102127.1681956-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: acddb2c3-4b6a-4a45-e866-08db94d49c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BmOIvQNBYf3bCQK/Ro90eank+8qWwK1Ksp8GZ19SRZvOFXqAiVnyQa7YIUNMrGncdHWiH+MKFd/oVIw7Yw+AQnFD6K1HrjBwU5V7EF3A/iu4+qLdR4xfhIc0qRGCfcJynWGiuqMfPOHU7fXkCc2ZHKWw7yCBer1FdHklKnHL39ATPwf9i8DbUc6OMiepws0UEOdKS/95gJsr0eVKq/z87x+BTipGCLSuZv3OME1vhMnZcwxJLVmIT3gxM4ZTTk3Etk9LAIPlSAck3XXtyRRygUNF0dnhzKF9FvuO/0kH1kmVUKSPY5pK8at1vSoif1RLk85XyXy2/1lt+wvmzAusM6m2AqwU0JSIo0IK3GuNbpi7dMeyAqJhtMS6Nrguept2gUTH39DLI6/XBZldacZm9WLUNBM09paWIOkOnPtbxsxhTLiatCBfx8fKtEEXw9J7uSwf0FrfX62OVVpukMKdoogxicJr9tVeM0McoOInOrKsNLSek5Hf/MBW1OlktOSeOPlZ+u+8Fl5ZbJkxxZHoDkoCJdcGmaGsHJHmM0f+oP4CyZ2i3cUD9NcZ+NbQCdrjHy+FeEl5eRQJf8Sz4OcajpK9dXgTDQw48qpLjgT3Y290UStj6yf4iTDd0ncjSWKFpJURdBMDh5ossF9iUB7dvOkOTts/o93wt4KwJJvEl6Mi/IwaEfATX7ZdXbOw+nitjDo6S9Bbx+itkL7eTDtLy5K6x2IdvpeyybT5zba3G+oQMZi2BA3Gdejmq29iU6kdX/ZCIrH0L66ZwLT3AsBQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186006)(451199021)(1800799003)(82310400008)(36840700001)(40470700004)(46966006)(7696005)(6666004)(40460700003)(86362001)(40480700001)(1076003)(36860700001)(26005)(336012)(16526019)(426003)(36756003)(2616005)(83380400001)(47076005)(356005)(81166007)(82740400003)(70586007)(70206006)(4326008)(6916009)(2906002)(316002)(5660300002)(15650500001)(41300700001)(8936002)(8676002)(478600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:21:48.0520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acddb2c3-4b6a-4a45-e866-08db94d49c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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
Cc: lijo.lazar@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
Enable following message in vf mode.
- PPSMC_MSG_GetMinGfxclkFreqquency
- PPSMC_MSG_GetMaxGfxclkFreqquency
- PPSMC_MSG_GetMinDpmFreq
- PPSMC_MSG_GetMaxDpmFreq

these message will cause pp_dpm_* device node not work properly.

v2:
the following message is disabled in VF mode. (since pmfw 85.69.0)
- PPSMC_MSG_EnableAllSmuFeatures

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 00eba3f950c6..c53c370d2a3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -89,8 +89,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
 	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
-	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		1),
-	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		1),
+	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
+	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
 	MSG_MAP(RequestI2cTransaction,		     PPSMC_MSG_RequestI2cTransaction,		0),
 	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
@@ -101,8 +101,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow,		0),
 	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq,		0),
 	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		0),
-	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			0),
-	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			0),
+	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			1),
+	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			1),
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
@@ -121,8 +121,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(EnableDeterminism,		     PPSMC_MSG_EnableDeterminism,		0),
 	MSG_MAP(DisableDeterminism,		     PPSMC_MSG_DisableDeterminism,		0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
-	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                0),
-	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                0),
+	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                1),
+	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                1),
 	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
@@ -1386,6 +1386,9 @@ static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (enable) {
 		if (!(adev->flags & AMD_IS_APU))
 			ret = smu_v13_0_system_features_control(smu, enable);
-- 
2.34.1

