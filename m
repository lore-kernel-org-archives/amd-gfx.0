Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2073AC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C538F60241
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C538F60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A516E4EA;
	Thu, 15 Jul 2021 07:47:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8BD6E4EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 07:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdjNIvIoU9sku8GvXXhyhGR3iAHC008CcCr6m/1GgPRvrizypBnZREEhS6OGXP3sXR9iUVpgp/Z2MMTK7wSPzGXXqqLIEDOEwPYPIAFcrXxnWaQql6cL5pH+/pUFbAKG56Dy0QYO5Hsi+O2U4EPbrxtQ2pRiqfaRSLFQ/DSQ4IHZ4Y+ZPTfL7DyyUdNyQ6q4f453+KVxERhOrWATzKx3Lhn9pgeeGZLbtCfxEUhIzylKGgxz8Z5FHKJdmfC0FAmKqdOu4kIs7oSedRGg9xRaH0Ri8kEJzpi7pHNsErb2B24aD1uw0GKj3ShtKf8l2Sj/MNiOeMAg+heH57Z58xVOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmO+bGAA8JEC6B01MVHR4taNAykNEEav49xut2lIfM=;
 b=DVF0uVy6iQLm5y0qwd4h2/bht2ROBzFyd05H89/xN+utgf6Sr6ysVyltPYkzpUIVAHhyL9fxPJvFpQamO9jdVKypgoFfwdxSimHOSo4mNfNs8Nx7JvQuhtUHTZuoeV+ihOg3HLCfBQowEIfFTuhudSf18Diln1h5HKdfdxJt5UFTpqhh0Ius+ISzASbY9QO4VqDhNo5gnOlC9Y7ncvBIMWfEhsDSAT0pb1Ai4D9mUWx3exC+wSAiHhcctcz6/g6kF8uqbST3HwTAEofnpvKcWO9F4vQXHfG1JyuKKVDMA9if/sEHeoE4nDKEZMmfLdwyVH18Q36aX5Qh6aspSkiiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmO+bGAA8JEC6B01MVHR4taNAykNEEav49xut2lIfM=;
 b=yqlnGMyVjOpL+Ko8UldtMUD4C3Nwda4BdZ575Ni5RjAHv0edS12ERVuKEN2uDCj7zI35weUpfZwvngrq7/OaUM1cEygykZAjOm9Gx5FfWMzOpLwoN0IoZYNFI/ASyffRNCt6SDV8qyRU/ZC0DiU2UgDwtJxkWv0jlF/6AMqVdqI=
Received: from MWHPR08CA0057.namprd08.prod.outlook.com (2603:10b6:300:c0::31)
 by DM6PR12MB3145.namprd12.prod.outlook.com (2603:10b6:5:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:47:43 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::75) by MWHPR08CA0057.outlook.office365.com
 (2603:10b6:300:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Thu, 15 Jul 2021 07:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 07:47:43 +0000
Received: from lijo-u1804-kvm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 02:47:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Support board calibration on aldebaran
Date: Thu, 15 Jul 2021 15:47:18 +0800
Message-ID: <20210715074718.31681-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ef6e4a-1e4c-4a79-d582-08d94764d46c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3145:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31451F1763DE52C62D07D1F697129@DM6PR12MB3145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5ju3b6EDTuJJ2oEdf6tKHYK+ku12/FvcdFKLrZWPabkb//uOeHiVL8c5IOs2pVD/Q/eOjcN96sMv3V8o8Y9sCAjdY/qaKS6EGy4YdmGp26JMUD51l2X8IBLx7ZLbZssTmJmXNAUGo46bV6QgqM2kjUaUgNAISlWLSchZZefIvveAEZHkYJdLEtfhUS/BOufjfFXaqJ8uYYXszNZgvBkE91st2eYhtQc0rXfzAE0JkTQsHrSO67B4YZzL96Qc16jves7vRkfM2ablVyIqu0shUNsrca1XRS0ZjqFTG8edy0P5LzaUKOH5rnma7c5SPsCTTuxSHqCeaum9Jm8h1J65dJdEWKl6IHRYvL4YP38PsV1caw6r1eAGLG/A8yN6eCRaPaKQfP4AutBbLLa6+s+OWtoz/z+XmCFVe62lnaSm7szeiJMwBhuN3Uhxq1Wap88i85IXpsX/czf4/SUWpvsL15HKg6gBQuO9i8znCC1Yisg0gf5yfqHKZ9qsCX76tEKm6YyQISBGJ0aWTg9dodbi6d/qw8D0PxuFtAlbOCaQYO8HwT5lQwR7XMgPBF9JGUC3aXo1xNBdvp9IpPL9DZoM8HwAkVSUxAbo0/tE3WTnYjLSeEQRbZkz2Dn0uFk0EtF+eE5B3Qd7TwAnfFH4DkbdmOYujVaFLMiwn1T7aJ8jCw9Y2GF+EFETjmOvFftezxQwUtJXjnaE18WqxfOI1TU1X0iLBj4cYCUA2KuI6ZO3XY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(8936002)(26005)(4326008)(7696005)(70586007)(47076005)(2906002)(6916009)(426003)(44832011)(36756003)(336012)(70206006)(83380400001)(5660300002)(6666004)(66574015)(356005)(81166007)(478600001)(1076003)(316002)(82310400003)(86362001)(8676002)(54906003)(186003)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 07:47:43.4170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef6e4a-1e4c-4a79-d582-08d94764d46c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3145
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
Cc: Kevin1.Wang@amd.com, Kenneth.Feng@amd.com, Evan.Quan@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for board power calibration on Aldebaran.
Board calibration is done after DC offset calibration.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |  3 +-
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 42 ++++++++++++++-----
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
index 610266088ff1..35fa0d8e92dd 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -101,7 +101,8 @@
 #define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x41
 
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
-#define PPSMC_Message_Count			0x43
+#define PPSMC_MSG_BoardPowerCalibration 	0x43
+#define PPSMC_Message_Count			0x44
 
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 89a16dcd0fff..1d3765b873df 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -225,7 +225,8 @@
 	__SMU_DUMMY_MAP(DisableDeterminism),		\
 	__SMU_DUMMY_MAP(SetUclkDpmMode),		\
 	__SMU_DUMMY_MAP(LightSBR),			\
-	__SMU_DUMMY_MAP(GfxDriverResetRecovery),
+	__SMU_DUMMY_MAP(GfxDriverResetRecovery),	\
+	__SMU_DUMMY_MAP(BoardPowerCalibration),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c16ca0c78e93..1400ccb3bf52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -134,6 +134,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(DisableDeterminism,		     PPSMC_MSG_DisableDeterminism,		0),
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
+	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0),
 };
 
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
@@ -440,6 +441,35 @@ static int aldebaran_setup_pptable(struct smu_context *smu)
 	return ret;
 }
 
+static bool aldebaran_is_primary(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_die_id)
+		return adev->smuio.funcs->get_die_id(adev) == 0;
+
+	return true;
+}
+
+static int aldebaran_run_board_btc(struct smu_context *smu)
+{
+	u32 smu_version;
+	int ret;
+
+	if (!aldebaran_is_primary(smu))
+		return 0;
+
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version <= 0x00441d00)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BoardPowerCalibration, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "Board power calibration failed!\n");
+
+	return ret;
+}
+
 static int aldebaran_run_btc(struct smu_context *smu)
 {
 	int ret;
@@ -447,6 +477,8 @@ static int aldebaran_run_btc(struct smu_context *smu)
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
+	else
+		ret = aldebaran_run_board_btc(smu);
 
 	return ret;
 }
@@ -524,16 +556,6 @@ static int aldebaran_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
-static bool aldebaran_is_primary(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	if (adev->smuio.funcs && adev->smuio.funcs->get_die_id)
-		return adev->smuio.funcs->get_die_id(adev) == 0;
-
-	return true;
-}
-
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
