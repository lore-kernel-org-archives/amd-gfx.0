Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D8C2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 08:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C488C61426
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 08:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C488C61426
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766956ECE0;
	Fri, 25 Jun 2021 08:12:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2EE6ECE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 08:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoXlHidE8Mp3FlY4xAhoUxRgm6I8zRA5i0rkJDGxFOYoGrprPzy1BQ6vIb8X7t/YCfqx5xvv0xeJfOwCHOef0EN+IO6L64+5Bl+ks/6K3i/shmJn8CIIFkaWmNVRAGH7lXDTimFQJ2pPoQobrdp2w8sQJ0OM2R4kTEsy+hIRNO24u5x53aEn2NS36cdO7s5dviXJtkbSCt4N8wHJ/SMIfQLgb4snQjBCNvaYTa+T9mLlxQlzZurmI+JTc6lDx2LEZpG/vY84X0S6YX1sJKWq89OmvHzOKktcmGukrLICL6v6cr1UnOEqkXUxTMj3konZPM8kAIH5Vs/OR1wXQbxINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE9GNrDDP5r6EgdaBBpDDJLjUCrfwQyAevvXsmNPSeE=;
 b=hlBZprov0HpUEpWP4WjyDKWB4g8IS04cIha82sUfozEWkIsh8s1V8kSY4vvZ12kM5nQv7uVINhL5kTHolbL/OpacYE1kyUe5D4IWZzcy4n5vHhCilBwuEKPEWoKJustk53+fAns3See5uZ4a3HfeRCOhvUWFd0kI1pDc2uDd6d0AyxyWcZ+9uf7uRLWLz+LwNxhUykfjIe18HfNWEgrQahGPVerRcRbqzvf+uDEHSbgF24DvBNRSGL0I6FZsl8jBnENv1TH5KyjtrmBWZY9z4NQxaxGv9ny/QTBeK5hgk7lkTQ+SvT9gnMcZHCy+y4HSJrc3gKVxclTRDvNCD07d8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE9GNrDDP5r6EgdaBBpDDJLjUCrfwQyAevvXsmNPSeE=;
 b=dY5bRkFwRcLjrHOEr0N+olr6kKIJ/M7CZftiS3KLXKBLQ6DgBKA2kNx24zrvUedUYQ14QiKVJBKVgRWO3fhCm8sMqe3mh6AL0TOpINhOQPRvHG21B0S8wQEla09VmpO5Bpe8FkwWTBKOpYDp4jzq9NqbKvez8TXKpbR/2RvZdMc=
Received: from DM5PR15CA0064.namprd15.prod.outlook.com (2603:10b6:3:ae::26) by
 PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Fri, 25 Jun 2021 08:12:21 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::8) by DM5PR15CA0064.outlook.office365.com
 (2603:10b6:3:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 08:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 08:12:20 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 25 Jun
 2021 03:12:18 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving for
 Sienna Cichlid
Date: Fri, 25 Jun 2021 16:12:02 +0800
Message-ID: <20210625081203.978006-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9552e90-1234-4fdd-fcfe-08d937b0f4c3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5402D9E269E1D053B71D067CE4069@PH0PR12MB5402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVI4L1iAJm627ez0saDmBKMTi7exZ9P3qN0wlYjFYcmvCAYCLJGaes9RLYJ4n5hApTo+n5YUU3ozyPKAFB2ejuQ7SEJIVCE/3obi7GuX94QcjJRGEsWy08hhc9mtDX+EYwyL9yWqKAAig/lu9t7KZa+3ibj6AK7kVqih/1yiT4ljkMtVEu0O21DTxJSXFkxsnF/DcQjgXQnCZSTmAF3KI3RL4Pl52NrvTpB76Snq5lGRAghhJIX8Xi/GNaoWs3Evo/lLbp+eFWTTaTm+0YYDExpuDpIxlsOdXhVKQPeG7mGkYs1rOAA59lgaSlITTfWUfhldi0J6OtR9yMZmlH9tthOw91oARn0TjqXC0+TTDObzc1DIEaJmQPK8rEpuSN7uRcSmvBcit1miYWgaa88yg41jkjmqnAGwwOHzUGxoI0q0J+nKs7PSra/1AUI5otJvz1BvGsf3/2sqTCePTxdErOC3wIojzk0utNDR+p/6mRd8YsiE//EPEdHuUAAWISUFzAsCcMjVYc6+XxLsghTotBw+Lp472o+K6KyX+LUpDD2I8bUZx9ZfNJPNejhpWj3iqbSqvuwySrIoo+uLQl1NO+CtLW6kUuuzE1A8o7XT00UGStqwrBkIXg5QvZ+yQEt34bxSMq7pRpoW3lQghJ9pSJCJEi76a/NnK+JVlnalFSb2m4h8QrNXYijlSJNLX3xLwuYDZRkNsyHfzRprkTN8RjvrlguZblIGn5gEk30oPRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(6916009)(5660300002)(86362001)(2616005)(19627235002)(336012)(6666004)(4326008)(47076005)(16526019)(186003)(316002)(54906003)(426003)(44832011)(2906002)(26005)(81166007)(478600001)(356005)(8936002)(36756003)(36860700001)(7696005)(1076003)(8676002)(82740400003)(70206006)(70586007)(83380400001)(82310400003)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 08:12:20.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9552e90-1234-4fdd-fcfe-08d937b0f4c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".

Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234 ++++++++++++------
 2 files changed, 222 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 61c87c39be80..0b916a1933df 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -211,6 +211,7 @@ typedef enum {
 #define THROTTLER_FIT_BIT          17
 #define THROTTLER_PPM_BIT          18
 #define THROTTLER_APCC_BIT         19
+#define THROTTLER_COUNT            20
 
 // FW DState Features Control Bits
 // FW DState Features Control Bits
@@ -1406,7 +1407,67 @@ typedef struct {
 } SmuMetrics_t;
 
 typedef struct {
-  SmuMetrics_t SmuMetrics;
+  uint32_t CurrClock[PPCLK_COUNT];
+
+  uint16_t AverageGfxclkFrequencyPreDs;
+  uint16_t AverageGfxclkFrequencyPostDs;
+  uint16_t AverageFclkFrequencyPreDs;
+  uint16_t AverageFclkFrequencyPostDs;
+  uint16_t AverageUclkFrequencyPreDs  ;
+  uint16_t AverageUclkFrequencyPostDs  ;
+
+
+  uint16_t AverageGfxActivity    ;
+  uint16_t AverageUclkActivity   ;
+  uint8_t  CurrSocVoltageOffset  ;
+  uint8_t  CurrGfxVoltageOffset  ;
+  uint8_t  CurrMemVidOffset      ;
+  uint8_t  Padding8        ;
+  uint16_t AverageSocketPower    ;
+  uint16_t TemperatureEdge       ;
+  uint16_t TemperatureHotspot    ;
+  uint16_t TemperatureMem        ;
+  uint16_t TemperatureVrGfx      ;
+  uint16_t TemperatureVrMem0     ;
+  uint16_t TemperatureVrMem1     ;
+  uint16_t TemperatureVrSoc      ;
+  uint16_t TemperatureLiquid0    ;
+  uint16_t TemperatureLiquid1    ;
+  uint16_t TemperaturePlx        ;
+  uint16_t Padding16             ;
+  uint32_t AccCnt                ;
+  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
+
+
+  uint8_t  LinkDpmLevel;
+  uint8_t  CurrFanPwm;
+  uint16_t CurrFanSpeed;
+
+  //BACO metrics, PMFW-1721
+  //metrics for D3hot entry/exit and driver ARM msgs
+  uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency  ;
+  uint16_t AverageDclk0Frequency  ;
+  uint16_t AverageVclk1Frequency  ;
+  uint16_t AverageDclk1Frequency  ;
+  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
+  uint8_t  PcieRate               ;
+  uint8_t  PcieWidth              ;
+  uint16_t AverageGfxclkFrequencyTarget;
+  uint16_t Padding16_2;
+
+} SmuMetrics_V2_t;
+
+typedef struct {
+  union {
+    SmuMetrics_t SmuMetrics;
+    SmuMetrics_V2_t SmuMetrics_V2;
+  };
   uint32_t Spare[1];
 
   // Padding - ignore
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0c3407025eb2..f882c6756bf0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -80,6 +80,13 @@
 		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, field));\
 } while(0)
 
+#define GET_METRICS_MEMBER(field, member) do { \
+	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu->smc_fw_version >= 0x3A4300)) \
+		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu->smu_table.metrics_table))->SmuMetrics_V2)) + offsetof(SmuMetrics_V2_t, field)); \
+	else \
+		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu->smu_table.metrics_table))->SmuMetrics)) + offsetof(SmuMetrics_t, field)); \
+} while(0)
+
 static int get_table_size(struct smu_context *smu)
 {
 	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)
@@ -489,13 +496,33 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetricsExternal_t *metrics_ext =
+		(SmuMetricsExternal_t *)(smu_table->metrics_table);
+	uint32_t throttler_status = 0;
+	int i;
+
+	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	     (smu->smc_fw_version >= 0x3A4300)) {
+		for (i = 0; i < THROTTLER_COUNT; i++) {
+			if (metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i])
+				throttler_status |= 1U << i;
+		}
+	} else {
+		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
+	}
+
+	return throttler_status;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
 {
-	struct smu_table_context *smu_table= &smu->smu_table;
-	SmuMetrics_t *metrics =
-		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
+	uint32_t *data_u32;
+	uint16_t *data_u16;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -510,78 +537,100 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
-		*value = metrics->CurrClock[PPCLK_GFXCLK];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_GFXCLK];
 		break;
 	case METRICS_CURR_SOCCLK:
-		*value = metrics->CurrClock[PPCLK_SOCCLK];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_SOCCLK];
 		break;
 	case METRICS_CURR_UCLK:
-		*value = metrics->CurrClock[PPCLK_UCLK];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_UCLK];
 		break;
 	case METRICS_CURR_VCLK:
-		*value = metrics->CurrClock[PPCLK_VCLK_0];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_VCLK_0];
 		break;
 	case METRICS_CURR_VCLK1:
-		*value = metrics->CurrClock[PPCLK_VCLK_1];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_VCLK_1];
 		break;
 	case METRICS_CURR_DCLK:
-		*value = metrics->CurrClock[PPCLK_DCLK_0];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_DCLK_0];
 		break;
 	case METRICS_CURR_DCLK1:
-		*value = metrics->CurrClock[PPCLK_DCLK_1];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_DCLK_1];
 		break;
 	case METRICS_CURR_DCEFCLK:
-		*value = metrics->CurrClock[PPCLK_DCEFCLK];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_DCEFCLK];
 		break;
 	case METRICS_CURR_FCLK:
-		*value = metrics->CurrClock[PPCLK_FCLK];
+		GET_METRICS_MEMBER(CurrClock, &data_u32);
+		*value = data_u32[PPCLK_FCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-			*value = metrics->AverageGfxclkFrequencyPostDs;
+		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
+		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+			GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs, &data_u16);
 		else
-			*value = metrics->AverageGfxclkFrequencyPreDs;
+			GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs, &data_u16);
+		*value = *data_u16;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = metrics->AverageFclkFrequencyPostDs;
+		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs, &data_u16);
+		*value = *data_u16;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = metrics->AverageUclkFrequencyPostDs;
+		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
+		*value = *data_u16;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->AverageGfxActivity;
+		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
+		*value = *data_u16;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
+		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
+		*value = *data_u16;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
+		*value = *data_u16 << 8;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->TemperatureEdge *
+		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
+		*value = *data_u16 *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->TemperatureHotspot *
+		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
+		*value = *data_u16 *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = metrics->TemperatureMem *
+		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
+		*value = *data_u16 *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRGFX:
-		*value = metrics->TemperatureVrGfx *
+		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
+		*value = *data_u16 *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = metrics->TemperatureVrSoc *
+		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
+		*value = *data_u16 *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = sienna_cichlid_get_throttler_status_locked(smu);
 		break;
 	case METRICS_CURR_FANSPEED:
-		*value = metrics->CurrFanSpeed;
+		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
+		*value = *data_u16;
 		break;
 	default:
 		*value = UINT_MAX;
@@ -3564,68 +3613,103 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
 		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
-	SmuMetricsExternal_t metrics_external;
-	SmuMetrics_t *metrics =
-		&(metrics_external.SmuMetrics);
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
+	uint32_t *data_u32;
+	uint16_t *data_u16;
+	uint8_t *data_u8;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu,
-					&metrics_external,
-					true);
-	if (ret)
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       true);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
 		return ret;
+	}
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
-	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
-	gpu_metrics->temperature_mem = metrics->TemperatureMem;
-	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
-	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
-	gpu_metrics->temperature_vrmem = metrics->TemperatureVrMem0;
+	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
+	gpu_metrics->temperature_edge = *data_u16;
+
+	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
+	gpu_metrics->temperature_hotspot = *data_u16;
+
+	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
+	gpu_metrics->temperature_mem = *data_u16;
+
+	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
+	gpu_metrics->temperature_vrgfx = *data_u16;
+
+	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
+	gpu_metrics->temperature_vrsoc = *data_u16;
+
+	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
+	gpu_metrics->temperature_vrmem = *data_u16;
 
-	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
+	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
+	gpu_metrics->average_gfx_activity = *data_u16;
 
-	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
+	gpu_metrics->average_umc_activity = *data_u16;
 
-	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
+	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
+	gpu_metrics->average_mm_activity = *data_u16;
+
+	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
+	gpu_metrics->average_socket_power = *data_u16;
+
+	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
+	gpu_metrics->energy_accumulator = *data_u32;
+
+	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
+	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs, &data_u16);
 	else
-		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
-	gpu_metrics->average_uclk_frequency = metrics->AverageUclkFrequencyPostDs;
-	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
-	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
-	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
-	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
-
-	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
-	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
-	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
-	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
-	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
-	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
-	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
-
-	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs, &data_u16);
+	gpu_metrics->average_gfxclk_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
+	gpu_metrics->average_uclk_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
+	gpu_metrics->average_vclk0_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
+	gpu_metrics->average_dclk0_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
+	gpu_metrics->average_vclk1_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
+	gpu_metrics->average_dclk1_frequency = *data_u16;
+
+	GET_METRICS_MEMBER(CurrClock, &data_u32);
+	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status =
+			sienna_cichlid_get_throttler_status_locked(smu);
 	gpu_metrics->indep_throttle_status =
-			smu_cmn_get_indep_throttler_status(metrics->ThrottlerStatus,
+			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
 							   sienna_cichlid_throttler_map);
 
-	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
+	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
+	gpu_metrics->current_fan_speed = *data_u16;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return ret;
+	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu->smc_fw_version > 0x003A1E00) ||
+	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu->smc_fw_version > 0x00410400)) {
+		GET_METRICS_MEMBER(PcieWidth, &data_u8);
+		gpu_metrics->pcie_link_width = *data_u8;
 
-	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
-	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = metrics->PcieWidth;
-		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
+		GET_METRICS_MEMBER(PcieRate, &data_u8);
+		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
 	} else {
 		gpu_metrics->pcie_link_width =
 				smu_v11_0_get_current_pcie_link_width(smu);
@@ -3633,6 +3717,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 				smu_v11_0_get_current_pcie_link_speed(smu);
 	}
 
+	mutex_unlock(&smu->metrics_lock);
+
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
