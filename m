Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B7C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13F6610A1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13F6610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618CF6EAA3;
	Tue,  1 Jun 2021 18:14:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0116E6EAA3
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Xx28MznHvnPlZLhXibWvRUa4ic9k+mq4wbMr9G6vvjCgXwR9snECBoBYlyP6e/xBDizjXXeTQsbqTta8fsA9YhLxbUDVEIgbnVWcKamJBpWZE1RQiL8CB9fCld5w4tZgDzPvTvkFcIhUv6XPfiZSf96Ae5UwMlSYngSg815050NNQdvOicuVW8McLrocb/Duzjmb2j9SuHlT/qvV4QoLaNrIqzQ386KCtgQ1x7s9aMxyiKurQLC5DLXgplGZMCI7DIQ4rvAJhdx3FblZLa/eyQ8jDNfVG7VMLAX+dezIZnbv6fYH14ihdfZQaXQLAMC5XB6Xn3xT0xfgVkM6yXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMqv2vGi9i3sXYiIqfQT4B8PnRi2UMJJCkThlDy8xCM=;
 b=YrI404P6SW1d/JUK0njw/W79oet9nV3u6uCfrtF2K4lGlXW/tZ7stiw7K2ACiOD0Is6UmgFEqh9VsvxxyZjQHI/TlFRDX0g7VdzNsmK0woLSKCy4xR4GSLiWtSkUs5U+ptaM/YnfPGWBQBTIBBV9jacwz+aZqGmaUtfKiLDBW7GjwMRCDCn7r5BR6mXitqS0gzGyLJU5IAeKLoAHYyvpUWsWnA2PPA0ihwZveHpziH1+ReN26uW5iZyWuauQHLChAEGj4dXyHHNC8b8JzHDh+Umnj3ANLd6mk6INMXotCxdcopYX/z9B1Ar7pnaXKTwleQiqG28l10IX6+Gdmaiofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMqv2vGi9i3sXYiIqfQT4B8PnRi2UMJJCkThlDy8xCM=;
 b=yV1tbyt6vFPG4Q657F45yuzGiUWqVRQaoADT1IM+9bybDSEsUP+5/3i1+ge+5uyaUROiCUJXtsWCqH7+GyGVQyS3AkpLeOOuSJ5FRLJ0mfCnMG7Bala/xlyS453mHkYt36l69durL9waAi5DanShoJYJRX7VvBPb27uK5i1+wDc=
Received: from DM5PR1401CA0024.namprd14.prod.outlook.com (2603:10b6:4:4a::34)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 18:14:12 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::6) by DM5PR1401CA0024.outlook.office365.com
 (2603:10b6:4:4a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:14:11 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:14:08 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 8/8] drm/amd/pm: Add aldebaran throttler translation
Date: Tue, 1 Jun 2021 14:12:31 -0400
Message-ID: <20210601181231.24773-8-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee451e3-73b5-4d12-47db-08d925290eb0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3335:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3335480E66A002B3F4D60D9E8A3E9@BYAPR12MB3335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfssuTfSJpVht5GnAghRoRh3i3Rj1Ew55adtsLnDWgdX22Fp5eJtAIKAYDZCTRFRO330K9/VZaD2yThDFT8LteO5DjT0XIpAJf3cpkMTyaOP0jRoVUNJIWtNAKj/V3r4g9LyF/ArrF/hgc2TznomWNr/t3ZdGBcFN5xhzCUDT5TY9Th4hOZzwWa3oy9iO0KaLEq08dM6Asv1A87MtTWI0ejbqe6+/cvjGl+CC2GVj63LMkU/VZOURdQBl0oKzppujO5Mkue5CH6eN+e3//eIq0QyD1VTINht4UHclPapfoA3dxHy7YHj2Akkuk6Pe4rz/H5lF4H+XSQ/Z5A6BO4kk7qJTlxKFGozw8LwyC8+N8uvhk55ZpkjCyk21v/48k+LfNaEpoXL8x8sa9swNNTApbTeQPp0ERp+v+30zVVMgXo4nSFtBPP9lff6pCHJ9jxL/s8YPe+G3Mw5/KybQff0ojEDv15MIUCogt/2bhhJAB0H03FmjI2g54EOi9QuZMwF80EJZRazpiWbYf3JGuB5KCS4AHPbZPND9cB1D/P++SKoGc63HWx9yi4LkaDSD64I1gRWgOQh29QqluolRA8g+zELbCvrtC+HYNmtPmLQ1JPE3nNIoQLkz/e0juqJOvVTikt/KoCW5QN2yB27okqG+LpsNWbEBCLgSYOk1xMFwE5mldMHHZyXbd4zEgzIfp2a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(6916009)(16526019)(70206006)(1076003)(4326008)(47076005)(6666004)(81166007)(426003)(356005)(70586007)(5660300002)(2906002)(8936002)(36756003)(498600001)(54906003)(186003)(2616005)(26005)(336012)(8676002)(82310400003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:14:11.8916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee451e3-73b5-4d12-47db-08d925290eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for aldebaran. Makes use of lookup table aldebaran_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..abb8f3bcf1dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -191,6 +191,20 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
+static const uint8_t aldebaran_throttler_map[] = {
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_TDC_HBM_BIT]		= (SMU_THROTTLER_TDC_MEM_BIT),
+	[THROTTLER_TEMP_GPU_BIT]	= (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
 static int aldebaran_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -213,7 +227,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -517,6 +531,19 @@ static int aldebaran_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint64_t aldebaran_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			aldebaran_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
@@ -1713,8 +1740,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_2 *gpu_metrics =
-		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1724,7 +1751,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1755,6 +1782,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			aldebaran_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = 0;
 
@@ -1776,7 +1805,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_2);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
