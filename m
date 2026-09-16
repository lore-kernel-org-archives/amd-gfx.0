Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7B6C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 04:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEB810E051;
	Wed, 16 Sep 2026 04:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SB0UMzTG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EB810E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 04:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5n8nFfQyaAYYwEEqLiz7VYhoqKEU+WUBlJMrhwnmh7P1aeA3JiqJnVcoBQ4guOWQyXthxmNl54XhlAdb/8rPsgm/tJHRSniFZ2XQB/jo/sWTmcnKTpLWExDRv2c9o7DOWsxVz5ZrV6oTkJ+kWTpQZF4mS0ZfxzM5pqYI8XpNl5P29/etUe2JRgPf1WRVDgt7Puocw8SD1015elX6Xrq4/Q1IzE01vv3szLa7WSbQNcY5G8l68ZHiAOIqpqF+AW+OSl5JInFhjG+zIahvV8wKRcwseZ4T2rL9q+Syc7h9Ll3bWE6v66qUCHlRSdr9Y5w+0lorg4ksLCH1GQY+hoopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyrW6oMq60SPuhCvYz0uk84mIgrAi/aX9Q2zSI1Dshg=;
 b=rps1IcJBwwLw+qXeP4VkYIroSXg3hdwkUrVk1MLyLB2Ytv8wu1leu9y3ozvfECHzOu8kEwXEfhS4XlRmx3zY/94yWQPLxKbH6ovVwhZskHIZU/rNon014kDP1L9Pa80thWb64JgurrHhwRQaGu9Oj4c438Xou0iX24csFab5gN+HzAmu172kjdHKe432DnwQhq099yWMh94hiVULeOgv8opD/NitXTTQOgzScKiTmtDgJ/m5/APTgIxjAPNDQFtneo17pyJ1A/UBSCZG8gjnrj61nfpYQ+p9d0uJ282sxSkhGER7GlTyuRXZZTt9Yd2ncoo6r0HLHD5ggI/uiXPQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyrW6oMq60SPuhCvYz0uk84mIgrAi/aX9Q2zSI1Dshg=;
 b=SB0UMzTGttYpQtHUkgNZA4cdSnl8UR7GbDU1+MA9nPyhSZubFMD3yeSaa16iZysrcVAd4DmcfkXsHyyYLIm6vPEQCHyGYS46vH5f0SRM9BdfAb7TyUCNCYHe8RJUzBGogcI8JaRcdvziNG2C96r94fwUJ8yAFJMjmAGR5QAGE2M=
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by SACPR12MB275847.namprd12.prod.outlook.com (2603:10b6:806:549::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 04:51:38 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::7f) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 04:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 04:51:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 23:51:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Drop redundant power_context_size
Date: Wed, 16 Sep 2026 10:21:17 +0530
Message-ID: <20260916045117.1658211-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260916045117.1658211-1-lijo.lazar@amd.com>
References: <20260916045117.1658211-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|SACPR12MB275847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8f49e2-326c-4346-d513-08df13ae3122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v4T+84BgsO1feia3MBohERGQVjt2hjLj+wImLR7THrqFr1JpKEiXN3I1m2IDSq6fTuSPFkanDqfjPesVPJXjZDbKR6MDx5lzFIqv3voiiWQI46QagQVoVsSvyO/QP1St2uXdZKvXpFcqeHAtHFh2uVvcJ9lU/4cuM/z8fuR2NOdbFmMPQwvyGIIoIDlrcD5D7A6jDZIAYabt6zp4CrnOP2ng6e947LqX3AtORxjAHCmaCLYaSNSez2T+6281pcyJWE/BHx4AYQMDcZXl3ur7G5KE4sBJRxaIF+2qf3wkxWAaQXGcZ+4ooGIydHelr0QjeVUmioVQ7N4vkVZq0+7Qg4TYqn8ruXkaNDCf5Ep8WNdwDnD/IukRbyBhQNNxiaONrtUM8Pejy05DU1gKimT3NyRbOx0COs/tG6iiDB0JUECYbfCRdBE2reSpWvtcYGmIHH/1d0dZW8/wTw6/mqZTIO3Z8hplwQmohPoUdW+PncTt55kI+Wb8+c59BFX4dAJaBqF7B5A+fpSlvcV70HSpDbtICfNQSfLvgMfYDsZQfLJOZbHXyGg4vUujo88/OOgnrJX04/Qvio9jzZCZ6MGaWROzugKaYEVf4j9eHKZNKCCR4VuZybhs5uiQWHf6PZrxk7AlMzPXhkaQgqBIP71JmyQfVxdZpHHUuqzr204sPHvSxyrMIiZlesc1sN/UonHqVIB+OxfoYZWhUkTChW9k0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kgy5fR4VoGXZx8B15SH7tyZar3LOyi8Cn/Ye+cX/sZAw04m/2QbIBAoTFnV4EUHdbMd1rfqpVky0Xg2lDf5T/H8n3BtlUyPeSSSONuZPYqoBN5iFGD2HSSKKz58Sx53c+NP9eMEdc58Df2zMThqiX5aghtouTZan8W/DYQzjaPUTeVe1blHuIwsI2tfrHMkiph/Hk8I0MP8t0NVWzPJ1kaJf7fLKxxqquBXaE9mGsFn9ee2/o6RpK0Eysfq0YpMEmMG8e9Ry1brcEJ9Nu2ooGQdc98pl6dP9JpOakfNJQs4raCvVbT7HoSOtsnx4HFXIBU+h9GMugtLT7Q5mgt6+z8ZsZdyWl8QSpjhlbSOkYtblKXQWEXN6E6wmFSV5lvPgguhvf/FBofOkh0xlJlYJ0iUGyVND5Vu2S+AKz8Ox3pXRvP2sYFUjfHc2sYE7zL7b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:51:37.9078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8f49e2-326c-4346-d513-08df13ae3122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB275847
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

The size is stored and cleared in init/fini but never used to for
anything else like copy. Drop the size and use pointer for init/fini
checks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 6 ++----
 5 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2586f9fa6589..ab43a5cd0dcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -487,7 +487,6 @@ struct smu_power_gate {
 
 struct smu_power_context {
 	void *power_context;
-	uint32_t power_context_size;
 	struct smu_power_gate power_gate;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f0b2e7da67b1..09e20d5ee044 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -345,7 +345,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
 	smu_power->power_context = kzalloc(size, GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = size;
 
 	return 0;
 }
@@ -356,7 +355,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
-	smu_power->power_context_size = 0;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index c4b2fe60da62..b250c5e41e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -427,13 +427,12 @@ int smu_v13_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
+	if (smu_power->power_context)
 		return -EINVAL;
 
 	smu_power->power_context = kzalloc_obj(struct smu_13_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_13_0_power_context);
 
 	return 0;
 }
@@ -442,12 +441,11 @@ int smu_v13_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
+	if (!smu_power->power_context)
 		return -EINVAL;
 
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
-	smu_power->power_context_size = 0;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f2e6105b0d79..5e890b56fd37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -393,13 +393,12 @@ int smu_v14_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
+	if (smu_power->power_context)
 		return -EINVAL;
 
 	smu_power->power_context = kzalloc_obj(struct smu_14_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_14_0_power_context);
 
 	return 0;
 }
@@ -408,12 +407,11 @@ int smu_v14_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
+	if (!smu_power->power_context)
 		return -EINVAL;
 
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
-	smu_power->power_context_size = 0;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index dfc1022112d5..4be864e4f0e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -335,13 +335,12 @@ int smu_v15_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
+	if (smu_power->power_context)
 		return -EINVAL;
 
 	smu_power->power_context = kzalloc_obj(struct smu_15_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_15_0_power_context);
 
 	return 0;
 }
@@ -350,12 +349,11 @@ int smu_v15_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
+	if (!smu_power->power_context)
 		return -EINVAL;
 
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
-	smu_power->power_context_size = 0;
 
 	return 0;
 }
-- 
2.49.0

