Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50CDC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19BC61153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19BC61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CC56E8D5;
	Mon,  7 Jun 2021 13:45:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8471F6E8D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrhZefMkMvYzRurwhIBoW2Hk7k5PfBZt98ICWE/nYTwCosWkl3GbGwcME5uY2OkRg+5gIZ3v8xAyq/QG9/zWstUjYedlxX0udH++HryM8Ml1Xo4CFRHutyKftVZfrJJaGJyR0e8femuGGGDVC+53H4UzmDarNs1xYgzHzD1szwr5ca2OdZvg2v+ZEjigfc2QdL37CihDWYQV5YJMv7kF9wBaBFJvpY2uGUc7LWsXaj+QsMZgx3H95Bp7iCRsv3FR30Mk5BvEQFicTWKAc/yYIg+jlcepXRm56+wwvUMiqzDSMNLeFhqR985ML0ZLYQVd2w/+e+0gHSCh8g+P34BjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWq5k7b1MzcGaibtD1oFcHVQhQq5g3xKml8An8J0I5o=;
 b=IjzY/kSib4cKHRhruuryaU/5FHqQAMGmlp2Wdqa72C4UFj+hYlXTgMOIRhOYft3EciFyIRZw0bY+0y8TW/gYCYZSVDjsMmgq6P32lW4KlYWI2BSOEFMrbFD82BO4Rs+Y3jYB5vkyMF3PI9dVBIcG3eelux7pZ6UA7voeWfavmrOKhOoWgeWaYSh249NZQiyxipW6HH4+wKVAckTT6tGJXHQAq+HdJJFi96jyd1hoPNWqXaXlTcAx87AaEiYWCxZYueJw3inwlxcnIbQZyqi/daGrPbbuXOyAySkk3Asa+SDaWKAxClPQqxsAHOX0MnDezN1mk0rUh4RomQ06plFkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWq5k7b1MzcGaibtD1oFcHVQhQq5g3xKml8An8J0I5o=;
 b=HJSZLSOZ/JpZdrc08oXhxh1rjd4wVEUdM4yE3/rgO9zTIVfaN78znY3RINVdkPAt7Bh6mgDAYx72Ila9/RX60WpiA1nyBo83ejIT8yeBp41lUmz7veHUxIhfxTN7Ev/zBoU54ICA9Kn1tHcQr6i40qLZ2zojaYJ9T2+/aw5JqN0=
Received: from BN6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:404:121::28)
 by BN6PR1201MB0115.namprd12.prod.outlook.com (2603:10b6:405:59::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 13:45:20 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::b5) by BN6PR18CA0018.outlook.office365.com
 (2603:10b6:404:121::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:20 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:17 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 8/9] drm/amd/pm: Add renoir throttler translation
Date: Mon, 7 Jun 2021 09:44:38 -0400
Message-ID: <20210607134439.28542-8-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1311df60-3969-481b-eec2-08d929ba7ddb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0115B4F4526624A1FB4CDB478A389@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNHBoPlEmy7/6LVOnVcDN6mu/txXg7X2nCkulD9XCek4cGJMLrZFR+lFRHPN3V/hIVGyXg3V+aWdNw5orFJRqlQbFiG2RqKU9a5K/s/3BzkYyxfVRyQDJjOydgK7ifdKy5VKde1kCKpNe+9s/+qG+vHrtaeQozSwJyPH8RXBFqzA/0kWqoy3Ot68TRfpNotI4tLEDNyiqIQYz09kvM56TYZR/f792zPo2dILAyZuODQh20/o2oIGHFIpVdX2NbSKRz2b+ki5px+x8pVX95UZOo6KB+NtkwGwT5ezcRSjg6eFQA4waq0XkFAPciAhHIsWCXhiGz26R/+Oi0NorwLxlE3UGqa1VeoPP+VIWwehSqX8GnJ4eQNMJ+VT8/muxwshqO1/PaH5FQGnO3eKcsaJW5UQ3hszt5/oTPe6Y+kwh8jVmIR6qALCC4b6Sss4PK6RsOadzNNLBo87ziJ3EHGgbNZ7opcqbMqmMt1jVANBDT/41QFKw+NhENgRFoWA+73dkXVkovcmUQGbMRqXTW5R9FphAq9QoqDZNntu4dON+eWzXoxjvBAxh3+MLG0ejIzZo8ig9+whxp/gR7WZAxmphDBUs8PfWIJG04j90PV7Xpl8gO0BRII0KMLqFhD5DyCRJtbv4uIM5deJ2HFziuWPxky12mpFwJwTuJ9zVVjx1A5ixn7D5cUSnJOELCAHauEy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(36840700001)(46966006)(82310400003)(47076005)(316002)(2906002)(82740400003)(8676002)(6666004)(81166007)(8936002)(86362001)(7696005)(186003)(16526019)(478600001)(336012)(83380400001)(26005)(36756003)(2616005)(70586007)(426003)(70206006)(36860700001)(54906003)(356005)(1076003)(6916009)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:20.1423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1311df60-3969-481b-eec2-08d929ba7ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for renoir.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 1c399c4ab4dc..6af67d372926 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -128,6 +128,22 @@ static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t renoir_throttler_map[] = {
+	[THROTTLER_STATUS_BIT_SPL]		= (SMU_THROTTLER_SPL_BIT),
+	[THROTTLER_STATUS_BIT_FPPT]		= (SMU_THROTTLER_FPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT]		= (SMU_THROTTLER_SPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT_APU]		= (SMU_THROTTLER_SPPT_APU_BIT),
+	[THROTTLER_STATUS_BIT_THM_CORE]		= (SMU_THROTTLER_TEMP_CORE_BIT),
+	[THROTTLER_STATUS_BIT_THM_GFX]		= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_STATUS_BIT_THM_SOC]		= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_STATUS_BIT_TDC_VDD]		= (SMU_THROTTLER_TDC_VDD_BIT),
+	[THROTTLER_STATUS_BIT_TDC_SOC]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_STATUS_BIT_PROCHOT_CPU]	= (SMU_THROTTLER_PROCHOT_CPU_BIT),
+	[THROTTLER_STATUS_BIT_PROCHOT_GFX]	= (SMU_THROTTLER_PROCHOT_GFX_BIT),
+	[THROTTLER_STATUS_BIT_EDC_CPU]		= (SMU_THROTTLER_EDC_CPU_BIT),
+	[THROTTLER_STATUS_BIT_EDC_GFX]		= (SMU_THROTTLER_EDC_GFX_BIT),
+};
+
 static int renoir_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -153,7 +169,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -1264,8 +1280,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1273,7 +1289,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1311,6 +1327,9 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+		smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+						   renoir_throttler_map);
 
 	gpu_metrics->fan_pwm = metrics.FanPwm;
 
@@ -1318,7 +1337,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_1);
+	return sizeof(struct gpu_metrics_v2_2);
 }
 
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
