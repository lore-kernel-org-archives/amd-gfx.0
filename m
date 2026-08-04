Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F785C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1965E10E6B0;
	Tue,  4 Aug 2026 09:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGxM5EaA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817E110E6B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/y4fqP+Z67eQDBECShpMNYIY9xskq6UukQsubayB3mSdbwSjjcKnCT6CXe2r4qDq5W20+QAsECMh6/yzjcxrdvxO/kXHE9095kCxX6OAGLPE6y+N3rn1hKzqY+S0IkmRXKdewJu8fUK9RPAmTJE5aVake+pCMIQTu8BZPajnJNJJHx8xG2lwRP3cQDMprGI9r4IWdq+MbooDb7YLaUyBwRamM3Co4PUqpVcbu5giGWDC4sHIWmD9lkER0airJ4Te91Woit3KaoMl7GAwyfh44dk4VuvoCZEHjJwoddlNDqWmKxdqC77ppAexNb7alfl4GoG7tT9Kai4YdecOUyb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBI4XuaIY3VibrXTDUuVqtMEhmJ9DjobUhuSMsCaudg=;
 b=ynyPiGaDmy+ruy1IMDvlc6eYsxa3ZJMp6wBLInh+TlsJkSs0zS/rFUWktnQ564vybNtuI5ABk0ro/rexxMZIs720c/PH9BvrH3rwoJW3tkDM5JQgENo/CI+7uT8wCgg4oJNhME2pykn+xRLi20VZSpyt1XmJqfOCSnzeC1deHGK03hcajVOXIgNQxpb3B/xkYGfjJWGkXU7VEAN9enwf/sUrbceWQ0+WPfYk74CynubFjg9fzqFrujypGiWeoj8k7SMFjxZyLU+1hqWLbqv0+enuAu79oelLq66x4nFUlREY7ZViILTIWxODod4LaOkoxDyN8+dINgatVCVCqIchpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBI4XuaIY3VibrXTDUuVqtMEhmJ9DjobUhuSMsCaudg=;
 b=cGxM5EaANQTVWZskp1NizEOMldl0OFUcD0kCdL4vBlEYS1rgfsinJfbbA5Sq5spwIMIpBOYYu0GVsuhgoOIzpuer545DVt7bl/v0E21knhHo7psWsQJTDjiEH8QLdQjZkwzVjlXYccEy2xJkazPr8NCFPXZrzBz7/qW+nzCscVU=
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:00:19 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::3c) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 09:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:00:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:00:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Keep sub-watt precision in Q10 socket power
Date: Tue, 4 Aug 2026 14:29:52 +0530
Message-ID: <20260804085953.2947798-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260804085953.2947798-1-lijo.lazar@amd.com>
References: <20260804085953.2947798-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: e066bd0c-f9dd-4070-4fce-08def206cec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oNzQSsg7llwMSRcc3bztyTNWpF3c5CtfC1do5DftqNgnAEli7fScB5YjQb3eXqzTyDBrsGOn32ienPGbX0cQJih2LhR2Ax2KU8h9I0/XtiFYBk5GxV1A6J/1rmQ4nkRzWmxEmbxC69Mywd9Df764y67MFPPi5jqugpzfUgyBGwAI/kFv0wLYDgD/CDwBEDS5LYZeplQVhCUsvPGeKelPgJkR/+YxWIyuDgdlmwovWBmFnq93Zt7CLm05ddjECqVXoRlhgcHnXK/UK0UrMnWCzQ4tVen76ExyBZPxeK8Q/c12SGnV/y14MNXvWUN/9Wwv1aOd/belMRc2tpgMiaDMwyqd90ZwKmzM6PL1n1xK9jdqgCsEIdJPx1H/b+dtHxVz7xt3bFxyc7r+ut00aD9zVVYwsgfgxt3nhOEBh0pYxIQ1ouC2JqMkXDP9weGnfHKOXf/gMwqawwgjqLz5YEuxQr43SfE7UGfG9J/aF+vI6j57JadB+1BIrjhhycJZaeKySgWPYDND/trnYZHQxjSuu4zi8hjvvukGDLAtB62teF7dBY69IiKxvWE6XynrbTgisftrcmC/Lt6hOltRzIsqviQe4MigocQOHEqyFTW46chmlhRZMg7jlTB7gN0N0L+8o/n9S5JOVMrts06A/JtIALrNODQ/XQK7Q6Bqs4/CRoQa3BJuMDuGFsip3ssJlU+833d4Su8g+XjWKzWaDiVISQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EhxEkCyeQutJWCfg4bjjHg4m7+egruv2/PNS2MX5GLrRb1SqKg+/l2EXfamk88GvyALXP5A2FmZ6D4YFbSE468Ok8fe6rOHDm/wKz2K7mrWBfuzQ5vsAaGgNabi7FGYOrYUp6MOEsx3oNVk4xvXpiUaHYxMTPz87bsWAB7hZ+3MJSvKac9h00ZEMUIfXHX2Z6P7YHKsapT54JRodTyfkfyMJ/K68kaBkSMVeikZEKjyWI608/E5F79NIKFS1JyXYZOZYpbsAiPAxeStf1ct5gRuVctSYqWqVBwPf2asd3fJKk03XfOAjoHcCdEi9LCvmaxjcsdIir3CPTtr+1pLvZ7diizTcR+0uTh0Tnzkoq/5RO64tJjZMxOTgxlwE05BYZaYiHMzmJAWEIEBTnG5AGmHUe/nKlk4kOj3MrX0z/9IPA61wlXMXTBm9nO4vcLp7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:00:18.5384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e066bd0c-f9dd-4070-4fce-08def206cec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

The Q10 socket power was rounded to whole watts before scaling to
milliwatts, so the reported value lost its sub-watt precision. Add
SMUQ10_TO_MILLIWATT to convert while keeping the fractional bits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h          | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 3 +--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 6 ++++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 5e7d80e8b26b..238dcc468557 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -55,6 +55,9 @@
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+/* Convert Q10 watts to milliwatts, preserving the fractional part */
+#define SMUQ10_TO_MILLIWATT(x) (SMUQ10_TO_UINT(x) * MILLIWATT_PER_WATT + \
+				((SMUQ10_FRAC(x) * MILLIWATT_PER_WATT) >> 10))
 #define SMU_V13_SOFT_FREQ_ROUND(x)	((x) + 1)
 
 extern const int pmfw_decoded_link_speed[5];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 8c719fff754a..f0f789c4ff22 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -434,8 +434,7 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(metrics->SocketPower) *
-			 MILLIWATT_PER_WATT;
+		*value = SMUQ10_TO_MILLIWATT(metrics->SocketPower);
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 39f5ed5da58f..fe0443a07b4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1303,8 +1303,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, version));
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version)) *
-			 MILLIWATT_PER_WATT;
+		*value = SMUQ10_TO_MILLIWATT(GET_METRIC_FIELD(SocketPower, version));
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version)) *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 01b91c9e3c28..92897843be24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -55,6 +55,9 @@
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+/* Convert Q10 watts to milliwatts, preserving the fractional part */
+#define SMUQ10_TO_MILLIWATT(x) (SMUQ10_TO_UINT(x) * MILLIWATT_PER_WATT + \
+				((SMUQ10_FRAC(x) * MILLIWATT_PER_WATT) >> 10))
 
 #define hbm_stack_mask_valid(umc_mask) \
 	(((umc_mask) & 0xF) == 0xF)
@@ -413,8 +416,7 @@ static int smu_v15_0_8_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 		break;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = SMUQ10_ROUND(metrics->SocketPower) *
-			 MILLIWATT_PER_WATT;
+		*value = SMUQ10_TO_MILLIWATT(metrics->SocketPower);
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
-- 
2.49.0

