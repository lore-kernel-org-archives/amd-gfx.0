Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD380CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 07:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7F410E06A;
	Fri,  8 May 2026 07:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIGDuiMT";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920D810E06A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 07:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXmJAPM78MnclPTdyl7y6veTHgtHVn6ZSqAlG6IMBOO4E9LBFVQm9hxnz/4iFgbaOyJNbQJW83vWfRjZkCCfaXjmBBbrVIdrH2smcUwJJvgOdbH0P022j7G5h3Ehi+nFn1kvYlkDfYWwweLM7YJOyaQ6HqgK9Q5akdorIrQLhzB/ijISdx7Lf5e4ae+DmPAGRpSo/KXXO/wNYCKLqCsHoM+hPnMx1iogXwhTF8nHo5PX7azRWGLV9njHNJSkKFV7Lh8D1MLCkibvYEoBCk8/52UYF2FCw9dV8aLxYoecwBOvfJYxHDdNe6W8/NLUFldjvyiho+D/xSotfBUL3OyaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09ZlH7KIV0Q6x3aaBn7odBQGnrgxhXLWZYuiuA2qWu0=;
 b=XGBFzMv9U0J6iSud1SX0AzEt4mLE+lMtI8ODCgwMgwE5JBCAoYEKIt1FdTwUzb33aXaixBoDo/mxofWd/3cjxJzYO813WFNZaQsAIiF5qaSUeUVBSU1lwmKGrSJkaV3qZkaZt6GbTGTlnKmZlUak/5x+lrbRN+xZufQd4qSpSygrp2g/oHY3vgLpdiiA1Ym5Zl3BwqfvS7jxfmGMoamrHLXZZjiJR/FHRoDWKOappmm2wnXOYDOgZOvGMrXayzt+B1bOW7IPUryvKH/Xb6Ex9LpJ1FgQ30Xbp5I2FwsI16iaWfiTC4xYJbzsG7f7zmGrKaoh4ON/6uewwP9UFJiKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09ZlH7KIV0Q6x3aaBn7odBQGnrgxhXLWZYuiuA2qWu0=;
 b=fIGDuiMTbW++ZcDi4Z0PQSSilITJN+bXJvdY6C0PRRNsnWXnHsB1N7B0XW5xJ2OVl60rLYOQddNViMDiJhB4Kifqhyf1+FeHxPfL9kKsVdwC5Wg3149jhIXspb/709yjTfnoGMXyhopOowCYu17WKTcb7yRAlwd8bRfXNZ5E0II=
Received: from SN7PR04CA0033.namprd04.prod.outlook.com (2603:10b6:806:120::8)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 07:46:30 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::d8) by SN7PR04CA0033.outlook.office365.com
 (2603:10b6:806:120::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:46:29 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:46:27 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Date: Fri, 8 May 2026 15:46:15 +0800
Message-ID: <20260508074615.1629636-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4ff32b-f9ed-441e-7c72-08deacd5eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: TphQwenycet/sOSPim4eyeTr6RgB9NwcxxOXaU8LFQBW4Ni5diktxBp8nwtmmBhU8gg5lNT8SsrRSK1k0Tngnqk8bfI6CGzOOILya0HnM6NooN6bbAcMPZalzIdtvOKeNZVmgKOJPqbTmgc4liv3a1FzAE4UQR5zZklc7r+hskToSzJALwfu7byWijeKf00DRLRjyQF/vYvl+o+FWEGotMae2e7nCqtlUVv7N0sPJ8qhKpu/0m3A7ySRA2/b3HcKgvVzMIxjdvuCjbrZ9hUm5CJPeBQoPgfOPn9Se9M/sooEUlXpbUOpS7L5G5js88HoVp6tSslz49C+8AaSa/eDmPHxtQY2h2o39GeS50nb65o5EGFUZP2ivyVjUpCldbNLbxBE+s6HWJQdaizxcc3M9sD4Xuog1/LzRpWjwPLPirC7D1LNn4HlyIjY3/ULZwMJccrLYw4a5uncJxfbMN/itB2NcFyqRxDqVTXtj+4nNHxAXYFyy86IC6mEdVIUG7E1QGM0rK8zf3/sPZ8DUmRdrUIPDXlGtJ4E3vJpGh1A8bsz4EywosHKtQOhEdIoP6Y89vUD85xlDk/zdhksqYb+e9EbzsBWlj1MNJ/03XA4RawgP/Zgxup/Uz+f3mmwM3yZ4U447+RQLPuVApf2DUPPYqd2ATqMPdN/bXGPp7Ioq/+kKzal4qUb1Ta1Rra9yDDCgoQQk+Q8X88NgpQO128qgufPeZXjZRl8zQtTQqQ1qg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EiuRuq3AvRYqpMJPYEZmIGY3z4QraLuHOFX2tQlQMZc+fDd08HIEZ8FHLuZc6K620joIH9zuEuojGo4dGDoTJaAoaKKfw/bwa+fYhioalHtflek1WFj6At/0crdnHfxDOTQwM0tvVn4my7zyQeAGaqoLUg3qLSOVH2deJKn+iQCACTep0tddgNck0JeF6WE8uoMBQupivbC2FmtaXy/bA5OyYO4+eJgdI0QWJozZ9RpXRiSpR42O4W2ie6uU1C253FWBRKhmkue/TBJfJW2nUT7KYnTk3iAimw0nP1BCzak7xIsFm/exFsPNAx2z+Re75CFnwYkPClKLNnc0AJTXaqWI4q0Ey3G8RX350gQ8JX+is1GPlpu8mHeaA5eEgbsoxJVR7p5ert/0Ri+wJF5f1JL4yVe70rWOysyxhXfHSMF4TlPUMkvUg3Kl3FWPQgVK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:46:29.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4ff32b-f9ed-441e-7c72-08deacd5eab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

v1:
Separate DPM clock attribute constraints for Arcturus (9.4.1) and
Aldebaran (9.4.2) ASICs.

- For Aldebaran:
  * mclk/socclk: Disable write, only voltage control supported
  * fclk/pcie: Mark as unsupported
- Remove 9.4.2 from global pcie check and handle it in ASIC specific case
- Update comments to reflect correct hardware names

v2:
fix some coding logic issue (by asad)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fd2e63530e8c..0c58d23013f4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2034,15 +2034,13 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-		if (gc_ver == IP_VERSION(9, 4, 2) ||
-		    amdgpu_is_multi_aid(adev))
+		if (amdgpu_is_multi_aid(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
 	case IP_VERSION(9, 4, 1):
-	case IP_VERSION(9, 4, 2):
-		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
+		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
 		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
@@ -2050,6 +2048,19 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 			dev_attr->store = NULL;
 		}
 		break;
+	case IP_VERSION(9, 4, 2):
+		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+		    DEVICE_ATTR_IS(pp_dpm_socclk)) {
+			/* Aldebaran mclk/socclk DPM only supports voltage control,
+			 * not allow to set dpm level directly */
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		} else if (DEVICE_ATTR_IS(pp_dpm_fclk) ||
+			   DEVICE_ATTR_IS(pp_dpm_pcie)) {
+			/* Aldebaran does not support fclk/pcie dpm */
+			*states = ATTR_STATE_UNSUPPORTED;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.47.3

