Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897AE1073CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DB510E664;
	Wed,  8 Apr 2026 13:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWv14rrt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E981E10E664
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzy0lzWsZ41uPS/22QRYCYOv47TbZnspxhHMYosW52hr+StfbTBDc2JYlWrXY1WWjKNAoFe5xClp9CAfO9WVOehpoJG3xY63gBruAHFFeN50CAGStCLqrJSTHrERJIzTPZubLewkYwIKhKmeLsMpyo4e4ZAmMxaE8aNqrnNsIjuOapjx5AvhgrdAw+SwWz63idx2Qu5Y5DroKuZdHePk13JOkVSnF4XJIhceNXmPyM4We/bYeMW2oDtgUUtHgOBwK2+KEvd8RrJjva2nDK58XhvrjSXUupJ7H5MWzvW+3eFyXlNIJ7VWDghEHa4Lkg3ugoNyVvHHAvEm/QR+orNbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne//7b8nej87NZyDvRwBwjRLMN+zR/PkPXmmQ1zUA+Q=;
 b=ScGd1Dlxi+aLDDLjnWuhFsMvPvVLKN/wJCwVZm9vpTBuIgus3C2yG9W/nt7+o3AELYxuZfKBXbrl3+zIo7DA+8D0AwOMlJOKrIA+V10LyBVoekxwd51h5gUkbm3/ThILGeRElTFabf0iyZnrIytbD7Ypw+6Ii9l29dRgkQmjECfCeozffRfB/kcLQC+5agM7mqHFZpln3iNoEVTCuLDzPsVDAWnKEWOG8bQFTi2y/R1v7CNPVOmZ7hudqxa8SAKr+FTMpTPc3at+zAsMTL8mLlLp/uDmdX2zlqHubQY5kwBOajS/K9eUjrOKuN6UDb8Sf977VTz4h8vodL3MAUuV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne//7b8nej87NZyDvRwBwjRLMN+zR/PkPXmmQ1zUA+Q=;
 b=WWv14rrtfSYSDd52jTQsEjsvizK3ANJ8SXRPeoewxH9ok9LXJJNRx7SDwEUh0ycGxiYKFi0VpBAxH27PxBJswxFsiJJUyx4I5WiBi07Ux+VAqv9cDAj9V4N2YshIZnPjZmRkCIZdongMAv+WcPuJ8JPY+G+kRMvg0q1qrZf/b+E=
Received: from SJ0PR13CA0050.namprd13.prod.outlook.com (2603:10b6:a03:2c2::25)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 13:43:13 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::f4) by SJ0PR13CA0050.outlook.office365.com
 (2603:10b6:a03:2c2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Wed,
 8 Apr 2026 13:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:43:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 08:43:09 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Align PPTable fill with non-Q10 static metrics
Date: Wed, 8 Apr 2026 21:42:48 +0800
Message-ID: <20260408134248.323350-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb3c81d-85d9-4858-9394-08de9574c788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jm/QYSHxTxyZD0po+7gH2jQiv0Wl0x43E6qpd/oBYIzjQZ9z9EEgHI64canGjKngqU5IQLO3OG4gXIaIiYZWVjcMd8Vx8MjKtr5ZLTZdt2SaIh6fD/TgVeboretYLJVHRuVkZ5KJFLPzw/JtcFG9E89mQABibwc2GlSs9akfxt7fbzYNRUYFG18Q2U5XVZEfDDkQ2ji1/imQFyzleT4iircQj46QisGGyQA8otI3QpxMOkh6pWHUy1rei6iyQ3gfA+nbnNoBqjKisUUlX8EZs0z8i5axptZZVopOj9Qr6UI6IawoXZU8h4OnboVJpfrJcKoNEvvlLvHNaagnkUSoBWdeV7KIcQwZGQkLkoCZGLrKB6N/wuZ9oyllQVtqFGSoUGf7sUIZxt1g3ScasPFAQRQxsj6xq0A2k6od7CbBe10ygChNinnWkZT4q2Idl7V2JlZEFVamALY0xbQtxkLBV8DAvSou/cT5ZEe6E5MbjmN4ryjvgBchvN4hiX/9HMHjDmgh5HOVnKQjn6C1e6siiPoXNdKoP6EAIWi5R0dmwJCT6lhC5uzkxdkQ4CSdxYIbCWZIhcSv3k7nJO4xh92ZaHDLhr/TzTTEfbTdOIU7IRZu+13zQqqAuahyDXkcjHa551fUu5poFcdzBhfQsBa5mXOWHwVL7Ai+3MKhslHI0di2FW6L05zGnTJnnWoay8AUxjZKibR1y4OuSsAK1Q2csLPOCOCtWGuNolgcZe+muPV3cPFgEa0dKD/xwzs2y4YoaS0uonsvAVCx1jPc5+mOSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UhKkjx0Y4Z9V8ZEgkJndU3EupDanFRMFGIiNrJsQVlhe9wbRrS/6nNIayhafiLtgXZF5vppL/IMWkTuU/LmU3cbx0HtaQFZcu8/rPTd6UldUFfNgPm5VzPuhTJ7Ed5nV1BE8KnsGpFujPqSYh8Gw1o27634ox7ixqxnx5O/jmv1RkrsfyCKVkRjl3VcdyXZqSkRVTCo2jwOZKTY6phSNwE4a8Z50+HTMe96xMnkZFujPHBWcXN9YZFOSSf1CzIN78LBtiZSZL8001aLy+Y7EhcP+oqC/Z9b72YN92KXwqCP2X1PnPZ7FvmXaaYThG58E6CUSpsf6q/I67Jt605cDqs8wqkUBlwcR5U7SuvEec79KX0QuIaCsTRKQN+ZGNRGOG1CJK0ZIdLt/yDHl+LY0vOhEyFrhwYT5QGgz+JpYlxlU9bQkIxJJ4zYRtqFY1Zeu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:43:12.8218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb3c81d-85d9-4858-9394-08de9574c788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

Remove Q10 rounding when applying smu_v15_0_8 static metrics
to the driver PPTable as the firmware now provide raw data

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 52 ++++++++-----------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b0faf57b0655..78bab657b139 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1065,38 +1065,30 @@ static int smu_v15_0_8_set_driver_pptable(struct smu_context *smu)
 		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
 			table_version;
 
-		pptable->MaxSocketPowerLimit =
-			SMUQ10_ROUND(static_metrics->MaxSocketPowerLimit);
-		pptable->MaxGfxclkFrequency =
-			SMUQ10_ROUND(static_metrics->MaxGfxclkFrequency);
-		pptable->MinGfxclkFrequency =
-			SMUQ10_ROUND(static_metrics->MinGfxclkFrequency);
-		pptable->MaxFclkFrequency =
-			SMUQ10_ROUND(static_metrics->MaxFclkFrequency);
-		pptable->MinFclkFrequency =
-			SMUQ10_ROUND(static_metrics->MinFclkFrequency);
-		pptable->MaxGl2clkFrequency =
-			SMUQ10_ROUND(static_metrics->MaxGl2clkFrequency);
-		pptable->MinGl2clkFrequency =
-			SMUQ10_ROUND(static_metrics->MinGl2clkFrequency);
+		pptable->MaxSocketPowerLimit = static_metrics->MaxSocketPowerLimit;
+		pptable->MaxGfxclkFrequency = static_metrics->MaxGfxclkFrequency;
+		pptable->MinGfxclkFrequency = static_metrics->MinGfxclkFrequency;
+		pptable->MaxFclkFrequency = static_metrics->MaxFclkFrequency;
+		pptable->MinFclkFrequency = static_metrics->MinFclkFrequency;
+		pptable->MaxGl2clkFrequency = static_metrics->MaxGl2clkFrequency;
+		pptable->MinGl2clkFrequency = static_metrics->MinGl2clkFrequency;
 
 		for (i = 0; i < ARRAY_SIZE(static_metrics->UclkFrequencyTable); ++i)
-			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(static_metrics->UclkFrequencyTable[i]);
-
-		pptable->SocclkFrequency = SMUQ10_ROUND(static_metrics->SocclkFrequency);
-		pptable->LclkFrequency = SMUQ10_ROUND(static_metrics->LclkFrequency);
-		pptable->VclkFrequency = SMUQ10_ROUND(static_metrics->VclkFrequency);
-		pptable->DclkFrequency = SMUQ10_ROUND(static_metrics->DclkFrequency);
-
-		pptable->CTFLimitMID = SMUQ10_ROUND(static_metrics->CTFLimit_MID);
-		pptable->CTFLimitAID = SMUQ10_ROUND(static_metrics->CTFLimit_AID);
-		pptable->CTFLimitXCD = SMUQ10_ROUND(static_metrics->CTFLimit_XCD);
-		pptable->CTFLimitHBM = SMUQ10_ROUND(static_metrics->CTFLimit_HBM);
-		pptable->ThermalLimitMID = SMUQ10_ROUND(static_metrics->ThermalLimit_MID);
-		pptable->ThermalLimitAID = SMUQ10_ROUND(static_metrics->ThermalLimit_AID);
-		pptable->ThermalLimitXCD = SMUQ10_ROUND(static_metrics->ThermalLimit_XCD);
-		pptable->ThermalLimitHBM = SMUQ10_ROUND(static_metrics->ThermalLimit_HBM);
+			pptable->UclkFrequencyTable[i] = static_metrics->UclkFrequencyTable[i];
+
+		pptable->SocclkFrequency = static_metrics->SocclkFrequency;
+		pptable->LclkFrequency = static_metrics->LclkFrequency;
+		pptable->VclkFrequency = static_metrics->VclkFrequency;
+		pptable->DclkFrequency = static_metrics->DclkFrequency;
+
+		pptable->CTFLimitMID = static_metrics->CTFLimit_MID;
+		pptable->CTFLimitAID = static_metrics->CTFLimit_AID;
+		pptable->CTFLimitXCD = static_metrics->CTFLimit_XCD;
+		pptable->CTFLimitHBM = static_metrics->CTFLimit_HBM;
+		pptable->ThermalLimitMID = static_metrics->ThermalLimit_MID;
+		pptable->ThermalLimitAID = static_metrics->ThermalLimit_AID;
+		pptable->ThermalLimitXCD = static_metrics->ThermalLimit_XCD;
+		pptable->ThermalLimitHBM = static_metrics->ThermalLimit_HBM;
 
 		/* use MID0 serial number by default */
 		pptable->PublicSerialNumberMID =
-- 
2.46.0

