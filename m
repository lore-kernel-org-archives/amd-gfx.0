Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E0CCCA481
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 14:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915DB18A143;
	Thu,  7 Jul 2022 14:27:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A48D18A15D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 14:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D24FksFJzw9h+i36eg4d72NNNtAtPhyu78XnnnKVmJ621yJC8roQvwJi1/04JmTrwB8Qk3O0kPvb4q6TSaKG4jD3OIsz9dI50aFMnKtauTi831U7uWdr9RJH3sZYj55J8/I4iqBt1TwrgN5tbKT8Gq85VIOiWS0Y2uiSrZWnKPt/8qx4NFLQOXEX2p3aOQqqROCF5C+CWvTUwklB6Z439b9N/WdPq/K4lOdfTvJosrAjH/jSRtHvocjqYKZKD+FV5/mc+LmeUhxs+Yg4iVoT0//ilBX9+Tc5bgL7WwyvScLu/YkllMe8jscvJCwZ2IT4ejDIz4GgshKZJeS7KDaL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNm7dJ/D1AgdmXPYW7Lm3mJdiEFBXQKvodNyltVfu6E=;
 b=Mt6l8tsu944sLXGZjuCu0wHSEyqZzSU+87BZY1ZaEVxtWgtfaYLg76IAb6tnAmY8BE0ziqB/YcEiL0fPYWkpFakGMqbygWEUSx5BuZOUZNPtDosKj2yZXniMn3o9DL8SfvNctLY/7do11An+kZB3ENc/q7ld8eGZGGEakKiYQodfsI8UtHWtwqExhC9gf0J0jGaGI2Veh3zWlwTUPSVSyRZUFvsr8w8k1xl4nBUyaONMiLsfcrJcAcKPL1Ue4ZgrekI7+ce0Pi57NjkGhy8X0gQ2HJklDZXMAFvrmEfYua4QFYOhSU6RMdUMEM9sUKTv7nkBWggvvmrxn39l8DMGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNm7dJ/D1AgdmXPYW7Lm3mJdiEFBXQKvodNyltVfu6E=;
 b=rn5JNvRNpnYrwGxj/QKPmflLxSmsul1L0K6/jrwRy1zfB4rwmNoSXtP2VNb6DTuiK4nPZVWQUmoGwa1A1BeipLtDjYp7o5FNgj2huIVecUlpvylwRUmVQKHU+S+G2cZyWXSG7SqQqK4lyZ/OHGDBgOWbu4MIgqp7Jp4GY9N+XcY=
Received: from DM6PR13CA0016.namprd13.prod.outlook.com (2603:10b6:5:bc::29) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17; Thu, 7 Jul 2022 14:27:31 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::28) by DM6PR13CA0016.outlook.office365.com
 (2603:10b6:5:bc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Thu, 7 Jul 2022 14:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 14:27:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 09:27:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 07:27:30 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 7 Jul 2022 09:27:29 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: ac/dc change for smu_v13_0
Date: Thu, 7 Jul 2022 22:27:27 +0800
Message-ID: <20220707142727.3250944-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536755ee-d543-4c84-f105-08da6024d3dd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc/sQ6QkQw/QZVCOvHFJMKVPFTMehqJmGORpsLOM9KdyEK8aacWLg/mTsOG7aP2ofH74Vlb/cW9sSeh61DAtZg+furKBlk7H+jcws6Yr+qlQrzPaK+QTv7Zs31foc5hC2sTN7UIHaRX+OwoR2hW+kFV86VgogA/81YpwnHW7oGV6UH0ARJbCSdemFu+pbbZ9SwG6fM8SFhnze1YJeucBzNNS4YAeR6Y8n+NY01JIwOpGCbj8xEcDbmeypxSenvHKmSZSYUeKKlnpTt3zc2FvuSs7Yd+792De88KqCYkqDwvUHpuf/dCxEFNuGrySSA7urTHtJtr2gYtQeWN1ch70bLooj5/fbKGjs7vRyh7OtMjZNjI2/mUytZty88RdRzMtz7+Soc2TRQRqttzXt+vQBXsILF1MrWabQGdAAy3ib00fOngMJ83XVKohS325P0gPtbwq2Ayc/sZ6I03eMFdxmXVBkyQj+Pgr3J/OQEvDHoPhd+LavS3EADkDaaK18NN3cyEyLQuE5tfYn3KW2oETVw8i7tH5botM6rgiJawXN6a1HHQdEbrty4DIk5Q+qp8wmU25WrTaF04XEw0vzETUZTfD8UpQzHETT6NoTUe9mae27jCNmidhSZb/xZ7fzD2l24Dx9oZROiWmy1mlLqGRZSLXzqdmn/mU4jys/zRoC3njCGtFidMuwbHF1wTCAptz3nKYPW/QkJw15BrpTMGRdomZUWhk0BS1PDrgTffv0MAxnI7uD/FVeUuRkjE+upGBKLXbGerQzznzXdumKnjjRvtJ7shqildUI/GN7P0lFP2Jnf1LeAeO+pYlhKOt4jH30dkmcISOPL5g+1ePnEzcnIa+fHSS9LSKJT6vkx9AF8cHSKIowf6PsIOJ6sd6PEZq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(6916009)(2616005)(186003)(7696005)(1076003)(316002)(26005)(478600001)(36756003)(34020700004)(44832011)(86362001)(5660300002)(82310400005)(4326008)(81166007)(2906002)(8676002)(70586007)(83380400001)(41300700001)(47076005)(336012)(8936002)(356005)(40480700001)(426003)(82740400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:27:31.5035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536755ee-d543-4c84-f105-08da6024d3dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fixed the issue: gpu runs in dc mode but it is expected to be in ac mode.
this causes the lower performance on smu_v13_0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |  9 ++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 28 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 ++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
index 3f2d0a9e4745..6aaefca9b595 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
@@ -128,7 +128,12 @@
 #define PPSMC_MSG_EnableAudioStutterWA           0x44
 #define PPSMC_MSG_PowerUpUmsch                   0x45
 #define PPSMC_MSG_PowerDownUmsch                 0x46
-#define PPSMC_Message_Count                      0x4C
-
+#define PPSMC_MSG_SetDcsArch                     0x47
+#define PPSMC_MSG_TriggerVFFLR                   0x48
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x49
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
+#define PPSMC_MSG_SetPriorityDeltaGain           0x4B
+#define PPSMC_MSG_AllowIHHostInterrupt           0x4C
+#define PPSMC_Message_Count                      0x4D
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index a1cb8e73e171..19084a4fcb2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -74,6 +74,7 @@
        __SMU_DUMMY_MAP(OverDriveSetPercentage),       \
        __SMU_DUMMY_MAP(SetMinDeepSleepDcefclk),       \
        __SMU_DUMMY_MAP(ReenableAcDcInterrupt),        \
+       __SMU_DUMMY_MAP(AllowIHHostInterrupt),        \
        __SMU_DUMMY_MAP(NotifyPowerSource),            \
        __SMU_DUMMY_MAP(SetUclkFastSwitch),            \
        __SMU_DUMMY_MAP(SetUclkDownHyst),              \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0e59ab2192bf..0328bc12ca21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1084,9 +1084,35 @@ int smu_v13_0_set_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_allow_ih_interrupt(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg(smu,
+				    SMU_MSG_AllowIHHostInterrupt,
+				    NULL);
+}
+
+static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (smu->dc_controlled_by_gpio &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+		ret = smu_v13_0_allow_ih_interrupt(smu);
+
+	return ret;
+}
+
 int smu_v13_0_enable_thermal_alert(struct smu_context *smu)
 {
-	return amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+	int ret = 0;
+
+	if (smu->smu_table.thermal_controller_type) {
+		ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
+		if (ret)
+			return ret;
+	}
+
+	return smu_v13_0_process_pending_interrupt(smu);
 }
 
 int smu_v13_0_disable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 193222fdd1c4..6259a85bc818 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -111,6 +111,8 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
 	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,      0),
 	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,       0),
 	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,          0),
-- 
2.25.1

