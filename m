Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9BC47094
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE2861168
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 02:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE2861168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E382C6EA86;
	Tue,  8 Jun 2021 02:09:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF26A6EA86
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 02:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6ZNSnBn3pBI0ESnGnZM+Bx5Q6X/YZ9bw1nH3b5QypnOZBkrLAB7cv7lJ7A18gRzepQFprKPaM8U0u2+GuuiqIp0D25SGU2PN81xg7+7bujYb1Flfa7G1ceZw/DHvKn4vp6cM8K78uFXe1YvcsiHafWUpSCG4KV2gO0ELtNjabeTmTBQ8EUtdxwfyDo1FNgJH1QUPGYEn9IjSZ4BX8dktnI43w5TubrA+5Q+oYwYxfAxtrnqqf08ZsCBS5+kUlhYoEu7eOUVeBCalGCRry7JOOjAd8mBi9TOap4qMn3fKT20mXlKJtIpUUigYVkccileFmB0gi/7XNw/7XkKswrTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38BnAufmh2jn2hAgY6cb/fMzZ6Q8Zk1EZ6PXYn5FdC4=;
 b=nZF/U551S4U3vYMGeIaNycBUHGKn3YvyCl1fAI9sqiiDExVHGhY4MQSeAXBcwnB0vKAu1QGo4WPTJelv4+GkhNMW9bPESJzMa1NK4joQnPxwihQHg0yKwlwZ8KpO7c9JLedsmVhlU2e9WOn47v0RXS99TdtBtRNs1KwS/k6/51mWznA/C8UPyeDC9bTs4W4Awn+YFa/VzaR8Ck7+efNNNrJEIFM9Fxqmc7O4Kl3W9puVrtCHHRn63O6rn8DRW1kDzXekbMWa28bFDM80KgsC65czvsylvd4q1IQChG9L4CYGIPGyvSKLL85p0WB6Q2GSltA2mOQIYAOkNJuIpuPv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38BnAufmh2jn2hAgY6cb/fMzZ6Q8Zk1EZ6PXYn5FdC4=;
 b=dlkQj4ApeT0JLcm4pSQqoT+jcgtnCprXP4cEZBBtGcrGTa4IGn2Fqw4O76ebLrrH9Uk4JYwcv9IzZwd378/Ng+vEewcJIrbeqvjTa8Ytfgr6/vNUDytjcfjpkCe4xlSoLjlqwWfjOtsoSCJdnGJ/YxqgJ1UAUXjBBLRnaZwU0hg=
Received: from DM6PR05CA0066.namprd05.prod.outlook.com (2603:10b6:5:335::35)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 02:09:35 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::5f) by DM6PR05CA0066.outlook.office365.com
 (2603:10b6:5:335::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend
 Transport; Tue, 8 Jun 2021 02:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 02:09:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 21:09:32 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/pm: correct the power limits reporting on OOB
 supported
Date: Tue, 8 Jun 2021 10:09:15 +0800
Message-ID: <20210608020915.1568920-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aacc73e4-a505-41dc-7a65-08d92a227632
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:
X-Microsoft-Antispam-PRVS: <MN2PR12MB49905746E6145A1062E85953E4379@MN2PR12MB4990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9v85cEMKycTOVEgT7ZFIk0TZvYJ7uyJUvEWdiGH8DoXMYJgGNsZ3uAXHXIKyctV0rUXcbs/NESks5O30wkQe2fkH13sd0QCgk29353SpVKvX1bqUVPXBaGbXfSjHNInM/pLDu7UBSuvw8xeFjVL6soowp9ifKfh73gYeJB/9Pa5HKlInrXnUfeU5A1ebYNx6N5X4h51NQ5HTG+5/nYr9AaBhYxLBVhBGcXPacRKJ0YYXdZL1Ep5+T3c1L/Oieh/4o+gx3eUpMguJsqG7P5mOPcfT+PHPu+4TdnDnz7b1zDcvVn4cZW024qo650Kydhxd/8WgnUBJsMZtCsEJ02sq1z2cUVleEsYdy+R3rO36S1P4zrJE2r8vBqNgwSBlnLJeNsGc7W3XTEclCrv34Tk3QMxyHh5yIROEENfWywMkX9Gx1nNX8W2hbHblIqZyBH/hUPp3qq0KSvUN8eqfGV4emUwyeuLyEz+l/QXajHcmxpY4HR5XoiAj/MnHuj2G6yoW65ON1tNfO25Kbgf8RIM3xZVaQmgsiujioVrAO1mmJ0MfCt35qWFQuuafV4YvP3PujQ2YUKl4zvoF/Bx6V1YpO8sUWUwDtNfHpPMKFYWseiHEPD9eVbIfm8J72c2Pr10CfVBbKwFtEKEGb5Eh48OYP6exriNxn5aPxQ68sVIwvjCBebV2/TQYnaD1hmgdPE9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(2906002)(5660300002)(36860700001)(54906003)(4326008)(6916009)(7696005)(8676002)(81166007)(86362001)(47076005)(2616005)(336012)(83380400001)(426003)(16526019)(30864003)(316002)(6666004)(82740400003)(8936002)(26005)(36756003)(44832011)(478600001)(70586007)(356005)(186003)(82310400003)(1076003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 02:09:34.9010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc73e4-a505-41dc-7a65-08d92a227632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
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
 Harish.Kasiviswanathan@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As OOB(out-of-band) interface may be used to update the power limits.
Thus to make sure the power limits reporting of our driver always
reflects the correct values, the internal cache must be aligned
carefully.

V2: add support for out-of-band of other ASICs
    align cached current power limit with OOB imposed

Change-Id: I63450ab75ec6ceb7f345bd3704295a28db23b881
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 28 +++++++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++++++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 17 ++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 8 files changed, 95 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..fb7438224872 100644
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
index 6aab65c684ba..57da4dbe94c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -688,7 +688,10 @@ static int smu_late_init(void *handle)
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
@@ -2191,6 +2194,15 @@ int smu_get_power_limit(struct smu_context *smu,
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
+			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
+			     (smu->adev->asic_type == CHIP_SIENNA_CICHLID) ||
+			     (smu->adev->asic_type == CHIP_NAVY_FLOUNDER) ||
+			     (smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) ||
+			     (smu->adev->asic_type == CHIP_BEIGE_GOBY))
+				ret = smu_get_asic_power_limits(smu,
+								&smu->current_power_limit,
+								NULL,
+								NULL);
 			*limit = smu->current_power_limit;
 			break;
 		case SMU_PPT_LIMIT_DEFAULT:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5959019f51ad..dbd9838bcf5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1174,7 +1174,10 @@ static int arcturus_get_fan_parameters(struct smu_context *smu)
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
@@ -1190,17 +1193,24 @@ static int arcturus_get_power_limit(struct smu_context *smu)
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
index 74a8c676e22c..695c65767258 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2138,7 +2138,10 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
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
@@ -2155,18 +2158,25 @@ static int navi10_get_power_limit(struct smu_context *smu)
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
index f01e919e1f89..a9e35c1255f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1770,7 +1770,10 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
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
@@ -1783,17 +1786,23 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
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
index 6ee9c4186f02..1cf1efcee09d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1132,7 +1132,10 @@ static int aldebaran_read_sensor(struct smu_context *smu,
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
@@ -1152,9 +1155,15 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
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
