Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1451C79FB5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 02:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A1C10EE54;
	Wed,  9 Sep 2026 02:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/aI7RC3";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755B210EE54
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 02:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZTL9FmUQqdzBwTay2xNYimkD4GjcLbCWtbG0GoMGMdKc9kyqUyMQwxXtyN33KDpmNWThilzSiJLfyir2Z4Kl6INhf6KwGjLOupJ1MqRuB3UO1ayr6XylVVj+dgzoc9h2S1+d7tRn24mK9wl7SNpDzQ28FicPt3F5SjnF0w20XDGzRndUycnqZ7AZfBFTZ6DC9uaAyEYFija1+k7xGkLd4AkmeRt7vmG3QGT9CPavfQlK3XsT9Zxkp5qJwfPNQlUcMEnJ9cwRXsgNHPCU2kvRfNkA2CcxSiG2Pb0XuQ+eVKinmybjoCfbuYWNY00C3UFbpkv54OBPdQcb9YxTSo20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggt8CWDKb7P+U1xfCR0rXS2RCFt9mqooeFyxOJxENJY=;
 b=KcW5qvLMQg4JIeYaqfR+fl4v5yRjzGCZBayDAOMb4JeMWxcpbljeQ72ZE1N4cJVcDeA4hBLW/KyHvkT+LZiIJdNvLOOlYFFDCiKc8vBtrtiglJxcgj9Snm2sG9sX8iTZzLLHGX3tlj1Gh5WJpVE1bfw/PaZoM/TXRG+QdJClhXAY4UGh2v4joIMbnPhwp8dh66MmbBq4XK1C5u/N7lKJDhaE9GvXpM8qKUARVXrkoCtODMUbsmnFhZIa3k2ZTmpI6x/LpNJE8g9tJCwDiULzh8wmxqYi+vn7StwoqIzrweLje9yyIaWkR5rxc13fcrxMgAKuqV1rgmLN6fUFLEZzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggt8CWDKb7P+U1xfCR0rXS2RCFt9mqooeFyxOJxENJY=;
 b=V/aI7RC3belVmgefA0wQ8ijg77XxoRXK6sqBqtSlqB/j5Ljov1A1U5TEvUvJB0t++XjTQp4TfOIviTnItgsN5XEND3B5loqr8bK8SNNAZSOqP5Rplkqq52EOzIZpkb+5qQ0uxxZmm5mlM2/+H8F7jq12giF4o9/RZM4U1VoKRGU=
Received: from IA4P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::16)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:42:07 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::1) by IA4P220CA0007.outlook.office365.com
 (2603:10b6:208:558::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 02:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 02:42:07 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 21:42:05 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: report energy accumulator for smu 13.0.0
Date: Wed, 9 Sep 2026 10:41:50 +0800
Message-ID: <20260909024150.590580-2-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909024150.590580-1-kevin.wang@amd.com>
References: <20260909024150.590580-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: fa75ca9d-15b2-4ac3-9f30-08df0e1bf06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Kf6C6LEXQtjONDbPX0IpWYcD9gpFdpxWYmPHsaIg2/sVrfQNVyfKUuhcrbD3NyGW91MczVl1mzMCsF6K83KEzR37UOpIJjWxg9wyKX2OQnfNznFvWyj4LgLvdrwIl6C2Vi0n0lba6FswJG8d1vdkJLJlyCyaCPPXaJNfQR+musQYymPcVGnWOgVBDsY4iZoc4iXoAeql9XLjKohIHyl3ixx/XqX+39uU9e+N2PcqhnuIux3XHLuty76Du6Nt2iEoUqJyenbCYLlisWD7Bb/WnMqmTytl+9lFDwCNZ8taiUjunzlrke/+FEBp2Cw4id/DyUBY6am55Rf5LlJ9lPA5du2iCD7cuwYVej0fiJxdHDh1x67dg/+GeabQxMPTXL44aW0h9TftBEpamNKW3vbn2KzhW1P0M5XpgZnEkkyAs9Bbnt+DxzO6JyGZHrLWwFfC3JWqzZbr3ff4ARUU8ETFaOvllQo51ssa6e7ZuqE41ffiakhk4bbypbmyGFk/KyJZHhagAh/HadaXJcXgTIA+KXd0pSn302fjLV1QQmfGXdzI/myICi/AlVGlL/JbuGaelSfn37yS3lK/3Zg40Nq/1O6rLI6mpwna6rM6qFe/wevQ6XUBOplfXtp0BE66GO6ZIXKZYvcEg5po6siDk0tV5cB0TEBgdnJftJZoyGyWMMFnpaclXj1SjWgVEJZJszS+6dQWp1b7c8P0HomEKSo3gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L/r0Hu3d+NpeKBQjJo1BGWsPXIO2y+hC5qGwLG27SXZYv+6EVaIjAHmPL/b5x8xQY3kFr0lw1rR5OtA/yT+wLHlzuVxjdEhAnfQk3VmtnwN3jHL9J7kssT0+bv+Yw3ISBqsCzJMqyDqVnSn+insyiPOrwOiKJJfOH61oz7MZdDekVxeKD9oA6UUe0BL1uztSe1wXDgfR03OQ3o8qpywr7N63wcx52yw087PdwI7Z8pKJM4Xxh4s8Q4oBnT8WqzBjDX1TZ5xZA0imp71KRudjjwJO1q+f6jOOxSekoab3RuCW5tBylq+xflvNmH/YpC+5MNDkAD61E5LoQyBFawFi+kAgSgfK+XpfhiUMeEBPtrFtXNwQcIpfWGpgOZ9VADbe6c7JX+00ykMKmMsjQIKvTgNSE0uLaaIaL895/kaLGQclMEdhTL7dtSf+tBM3T2EU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:42:07.0073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa75ca9d-15b2-4ac3-9f30-08df0e1bf06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

add energy accumulator on pmfw 0x004e8600 and above version.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 26668cb00e0a..e868bfe1f0e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2092,8 +2092,10 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
 
-	if ((mp1_ver == IP_VERSION(13, 0, 0) && smu->smc_fw_version <= 0x004e1e00) ||
-	    (mp1_ver == IP_VERSION(13, 0, 10) && smu->smc_fw_version <= 0x00500800))
+	if ((mp1_ver == IP_VERSION(13, 0, 0) &&
+	     (smu->smc_fw_version <= 0x004e1e00 || smu->smc_fw_version >= 0x004e8600)) ||
+	    (mp1_ver == IP_VERSION(13, 0, 10) &&
+	     smu->smc_fw_version <= 0x00500800))
 		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_0_BUSY_THRESHOLD)
-- 
2.55.0

