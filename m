Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D589C2B9F7
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 01:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3FF613F6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 01:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3FF613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866546E4E6;
	Tue, 25 May 2021 01:25:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F419A6E5C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 01:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuSYwKhyrOaEtU/aNzRJvqilkiVs7s6mL6GOCfUwTrmtSzjnSKfN0N9HW70oOp3lILElHPu87AE73Tn3OFeJWyNtQaZQ9F6h65DK68W+Ja0EitDIBHfdbHmhrqtphPpxoYxm64uzgF5x9FPiLc/Y4LQFCOxEVZ4JWE+I8pez9LT4A3h7jMeLg3k/DmCUvtfDKGSuLBOEJ53+AflYX52xlVM3FdPTZWiHm2ocoUlMEMEyOgKzAiSKv0LBI4p/tT1+TAupSe4wKGO4z9vE/YQ/DX/KfBdDZAErsa0de+b/vUP7uY4hdWZhCm5rZW782yMh4saok5G+BRGbMH9A4ksz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4nGkzjlSuKXuT0OfgxgPmgLxyygecVdof6uDlxSIdQ=;
 b=SmNyvjtW1TENWbLdjkk0I4EssGud693Bbrv7iidEaUr0uE5q7f1R2Qy4ABYA0RTr/RsiLFhvaxIf/Ay4+wVrQsreSG79nF8BEHpBjC2Y9KsmriyeimAOVE96TNdaD3RFKvsDl0isO6LMJvJF2b4hawVb3tO5U494Ei2EMxCqMGpBE9j16uinrhpVfY8cr0tHR9jzDq1o3LsJmlUp5O4tcBSpmfEvlLz4KOvUFCN6bhhgmgzfdbzxQL22Cd8UgpmCkNcq5r44Ga49OKOXja/ZqFNLey3miGWXxMSzJXErKqAskxaQ4sTkQKBXxvYQtxqB6C+lqnncmteQJET4N8ZBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4nGkzjlSuKXuT0OfgxgPmgLxyygecVdof6uDlxSIdQ=;
 b=weeKSNCUq+e4aWCzAHQIURDX2VsTe7P9yHf2BT4fPXXJDE05epL94dnHgQsR5JGNqig536nXPDDoj8A7t1tEWCF2sXNUZbIXePCvtDWT1ozuycn2JrUOiTyAsVAdsXwdLfr882dbORLiFxewzm0OkZRlIkT2bGTu6tis4ZVV930=
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 01:25:02 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f4) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend
 Transport; Tue, 25 May 2021 01:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 01:25:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 May
 2021 20:25:00 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: bypass the internal power limit cache for
 Aldebaran
Date: Tue, 25 May 2021 09:24:44 +0800
Message-ID: <20210525012444.91155-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a70605d-b10c-4299-ce4b-08d91f1beb79
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4404F540ECF4AE98175F90D0E4259@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B57uty7NZPibGSwNr1SoeE0ZlbDzVzq3lT1LoVZqBnqCdTCZ0rYpkmvzeOoSAmFFax9/qDBefYILFSoHa0VnasG7v8uGHHancjnLR2HUtFdz1lIzoKKU+IIv/EajYKvKGzNa5CRQYMpQEp/ofMTkaDg0wjGX4yquw/VRySetXc0h1WzzrxUoyMsg72Jf6H/y5JZRtn2MIannHXjeKcCymOu/FnrLKBkMt1WjwtUsTzE+YY1aL9dzx9GNUx1Y67g5MyZkEa2Jzp1Uwu5efdETiBUzILMGYhJVax74w/ZizyjdLXcDFhbeZ5pnn2n8Z+BhjSG41jV3yWYCLzz708WC1NsLyGGB9BPK3gmVLnNFeg2NKF7M1+rsuMtaIH1n9KCC2AY2DvYE5THkIbidRqsXjueRLhdzQ/axTDctOOv4LjZDzxUqDvSjdqNshDCYEDzeeAA0pHBGnfSrqtI/dCsiZmb6HSv9F0K+C2xdvnQoaadfs/kEMx1QQQlL7ef6g7dZWYh9lkB3aAx5X+v7LHHBMfPBdCVaHbzB7KTS/t/pUO5iATfDo/DWz4CMBqFLWbFL/jLFKbIxl4y/kK2c6aLsk310DWtGwaQm3JXsyxgFEqW4Euxxh3v6eYI7l4WIgfm7EEUcuJpes6yCUIr7D/MOZKQAB6jrSqOQctIsLmWTRRZgn5c38H4dfMBvv6Txawie
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(70206006)(70586007)(336012)(36860700001)(2616005)(81166007)(186003)(16526019)(1076003)(83380400001)(7696005)(30864003)(426003)(478600001)(82740400003)(6666004)(356005)(6916009)(5660300002)(8676002)(4326008)(47076005)(26005)(86362001)(2906002)(8936002)(82310400003)(44832011)(316002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 01:25:02.4392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a70605d-b10c-4299-ce4b-08d91f1beb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As out-of-band interface may be used to update the power limits.
Thus to make sure the power limit of our driver always reflects
the correct value, the internal cache must be bypassed.

Change-Id: I63450ab75ec6ceb7f345bd3704295a28db23b881
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 13 +++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 28 +++++++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++++++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 17 ++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 8 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..0b03bbe9632b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -723,7 +723,10 @@ struct pptable_funcs {
 	/**
 	 * @get_power_limit: Get the device's power limits.
 	 */
-	int (*get_power_limit)(struct smu_context *smu);
+	int (*get_power_limit)(struct smu_context *smu,
+			       uint32_t *current_power_limit,
+			       uint32_t *default_power_limit,
+			       uint32_t *max_power_limit);
 
 	/**
 	 * @get_ppt_limit: Get the device's ppt limits.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 285849cef9f2..ec277fb22522 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -681,7 +681,10 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_get_asic_power_limits(smu);
+	ret = smu_get_asic_power_limits(smu,
+					&smu->current_power_limit,
+					&smu->default_power_limit,
+					&smu->max_power_limit);
 	if (ret) {
 		dev_err(adev->dev, "Failed to get asic power limits!\n");
 		return ret;
@@ -2184,7 +2187,13 @@ int smu_get_power_limit(struct smu_context *smu,
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
-			*limit = smu->current_power_limit;
+			if (smu->adev->asic_type == CHIP_ALDEBARAN)
+				ret = smu_get_asic_power_limits(smu,
+								limit,
+								NULL,
+								NULL);
+			else
+				*limit = smu->current_power_limit;
 			break;
 		case SMU_PPT_LIMIT_DEFAULT:
 			*limit = smu->default_power_limit;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..aaeb577907cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1159,7 +1159,10 @@ static int arcturus_get_fan_parameters(struct smu_context *smu)
 	return 0;
 }
 
-static int arcturus_get_power_limit(struct smu_context *smu)
+static int arcturus_get_power_limit(struct smu_context *smu,
+				    uint32_t *current_power_limit,
+				    uint32_t *default_power_limit,
+				    uint32_t *max_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -1175,17 +1178,24 @@ static int arcturus_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..d28236ba0018 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2123,7 +2123,10 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
 	return ret;
 }
 
-static int navi10_get_power_limit(struct smu_context *smu)
+static int navi10_get_power_limit(struct smu_context *smu,
+				  uint32_t *current_power_limit,
+				  uint32_t *default_power_limit,
+				  uint32_t *max_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
@@ -2140,18 +2143,25 @@ static int navi10_get_power_limit(struct smu_context *smu)
 		power_limit =
 			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled &&
-	    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled &&
+		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..095492bd635f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1755,7 +1755,10 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static int sienna_cichlid_get_power_limit(struct smu_context *smu)
+static int sienna_cichlid_get_power_limit(struct smu_context *smu,
+					  uint32_t *current_power_limit,
+					  uint32_t *default_power_limit,
+					  uint32_t *max_power_limit)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
@@ -1768,17 +1771,23 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 		power_limit =
 			table_member[PPT_THROTTLER_PPT0];
 	}
-	smu->current_power_limit = smu->default_power_limit = power_limit;
 
-	if (smu->od_enabled) {
-		od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
 
-		dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
 
-		power_limit *= (100 + od_percent);
-		power_limit /= 100;
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+		*max_power_limit = power_limit;
 	}
-	smu->max_power_limit = power_limit;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..35ceab408a26 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2051,7 +2051,10 @@ static int vangogh_mode2_reset(struct smu_context *smu)
 	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
-static int vangogh_get_power_limit(struct smu_context *smu)
+static int vangogh_get_power_limit(struct smu_context *smu,
+				   uint32_t *current_power_limit,
+				   uint32_t *default_power_limit,
+				   uint32_t *max_power_limit)
 {
 	struct smu_11_5_power_context *power_context =
 								smu->smu_power.power_context;
@@ -2067,8 +2070,12 @@ static int vangogh_get_power_limit(struct smu_context *smu)
 		return ret;
 	}
 	/* convert from milliwatt to watt */
-	smu->current_power_limit = smu->default_power_limit = ppt_limit / 1000;
-	smu->max_power_limit = 29;
+	if (current_power_limit)
+		*current_power_limit = ppt_limit / 1000;
+	if (default_power_limit)
+		*default_power_limit = ppt_limit / 1000;
+	if (max_power_limit)
+		*max_power_limit = 29;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d62cc6bb1a30..4c2657d940fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1133,7 +1133,10 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
-static int aldebaran_get_power_limit(struct smu_context *smu)
+static int aldebaran_get_power_limit(struct smu_context *smu,
+				     uint32_t *current_power_limit,
+				     uint32_t *default_power_limit,
+				     uint32_t *max_power_limit)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit = 0;
@@ -1153,9 +1156,15 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 		power_limit = pptable->PptLimit;
 	}
 
-	smu->current_power_limit = smu->default_power_limit = power_limit;
-	if (pptable)
-		smu->max_power_limit = pptable->PptLimit;
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit) {
+		if (pptable)
+			*max_power_limit = pptable->PptLimit;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 68d9464ababc..33101dc93bcc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -82,7 +82,7 @@
 #define smu_i2c_fini(smu, control)					smu_ppt_funcs(i2c_fini, 0, smu, control)
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
-#define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
+#define smu_get_asic_power_limits(smu, current, default, max)		smu_ppt_funcs(get_power_limit, 0, smu, current, default, max)
 #define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
