Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDC1CD98C5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C7410E914;
	Wed, 10 Jun 2026 12:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RrKy7H9+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D705F10E55D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwnHLGk+90Irh780ki/IChU3uGVUcuLFsZSAniQ+dMQLWswLKiAk/+uoObOmdykpP/WpFUFcK7YiG4CxvzskrBu8pprSdMCME0q2Cbj6tN6aRYh/WLwEAKabLOJA7/u9MA0fl78Bf8rSx1FwXuscmzVbMjFJnH1exsV9juyfBrEhxklhIbZfu7XgGHxJ8d0Z/RrRlhU9o54HP0nipi8y1AT/mH+ZFJLMTUUgKeRBhVYjJTOd93nUCLm3KRWxXSUyxfJl1oLsP7c+bg/FbTbMRWMCRiKO4cxTeaV15x7r4wOi1e9KPR/oVqZBsqhanDs1uCRj2KoqMyFvR8nPGxN7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LqNuKq6wmdlL8O2sAcvqAhVTl9pz+L8AKUkE1iRth0=;
 b=pwoTW9f1JBBpV4a64Y8aTrWpvyrpwsYSFliojD5P/ma9XpAIy9K5Jwk0xgb6sirFk2uysx77Su35pl6FmKwWMTJeLdQ1IM0O+0xNFOzI21oVMUaZtDWaawz3zwO5pPQRAPHUMzfj5/VXwVDZBqecm1+fTjTMSV+YSkpVo5bNAyHdhF4nILp5RJR/vU7aKqatOQiX4k8sQsDNiFHP+NeguW/RaRIGMg4RE2OJhm6XJlPnD+Hd2CW0Qww6LIq4TKRwFPEWJ33kz/05TG2lJ7COlJC6Fsy1+BcAq/ZNEnW7krUy6sdzTR7//4b2JtnTrxUru0Mg0CCEEmb1Ht9b10NYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LqNuKq6wmdlL8O2sAcvqAhVTl9pz+L8AKUkE1iRth0=;
 b=RrKy7H9+uX7eYMZx7crGTOKnBNefPkiJNcP5k3wPkcXA3mvz+Khrnv0tVjy6ce0bmwkr/J/iu7IOV2QzFjEGcoBg46JTzzj55xMv2Mj/T9sohjHcPJuAg2zY/UqaALO92OCsxrjo2cY4Lmc9+Dw1bQnIbsJw44Zh0AsVYJIfEu4=
Received: from CY8PR12CA0067.namprd12.prod.outlook.com (2603:10b6:930:4c::7)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:11:48 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:930:4c:cafe::96) by CY8PR12CA0067.outlook.office365.com
 (2603:10b6:930:4c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 12:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 12:11:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:11:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:09:50 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 07:09:47 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1 metric
 handlers
Date: Wed, 10 Jun 2026 17:39:41 +0530
Message-ID: <20260610120944.124040-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610120944.124040-1-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa70629-1b97-4433-5ee6-08dec6e97275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h2o2/KJNey0fgdJPRn6B0/1Et/IdhSx82jZRkCMIKpQxVyLlaIIjXgo04EcqZJmcTw2WNmdJQAuHSrkBZb1gcWU7HJHjHNluBnIhC6GActO4QATpj1ygUsM2Nz2nck3eBE9lbjr9lsMCxO2q6sBDOgr5plkk9P5e9A904Y1mKF02NsOFQ7Y+AXVyI8tv8WY7MDEMe9hDDKMyWeXelZ7Z3QhlEsWvehRQ+UeQzSwvs5yrjMesTckrEFU5uegtEouw5gcJZKk0TA5KORyxXhxnWyC6YF8Hww3DWts1jil79IrGuFTQU8kVBH+96xLsIH0jHi5v20Lumq4HN1dB6Jl5DuRSGTXvEfg0tSHz4XTIfIOsMN0SKkhAKa54rxN5DYlStvkX9fi1G2CB1VqZsfXapiBlXpPHL2Unti5lEkualKu5BRgiw04BMUtdkZRgwSq0BqUEW3TJ14xIflvBQWNw+rTRwv4Y0idsRtQYBMNE9cbtpcUcLDXK8lnxLLM6K3q09In7UhZzYZM+AVH5S17jr9OPZH4xf80hZRpDEGNY796eNY/kYN1hDCrDcym9hATF4OqMT1+OVLa4nANmp+CmRns5eyUBTDKV/CE2VlQbIaBUqfYu4At/5JOfVokR4x853NzYF+ryWqK1nKgU6tFEeRWaj27GfkFimKqdRp1OhChCbz/2pEo2UeDWYKtFTp07ioc2vdNUXwsCQhqsxxcINeiPZK24IioypVfS13A4Bdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2h9mG+U9ehXrp/qujvTRWfQkfDckRx0AxFLjQ2RxH2MDfyfGg5LlPMEsjx9nuBbQv+5GbiTonxu5mffm+0QMrHW/M2G+AQ1fYsFgVuXX5jtST7vrhpNhiOs4ciR2815s5BjEvispNOkyKBHZ6m7bYFAsfl6ClSTAz7Oa/GLN6TmQY74KD/lf+KLO0dWMWw86edqUUvAFETuU1iMSbDj6Ml8ssK8E8dsgkAvuKisERWvY6RKhSvEcHeYycQuYgMVbDVLWcRalRIH/Vvr6ILFNSEdqtdPUUT5ecvDagzPR3Dd8QvLjzJsOEgQzFxefeewQzk8A5UnZ1g/YZR4Cgmi//neI4V0BMjr72LT+G6opyTNkcxq55Um7IGp0dcHJFrvxmdDuUWTSAjPvxRFGRNY0FLdZfFcqrNMPqON0GqMiANHNcHTb1bWgKuozEUGYTLQ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:11:48.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa70629-1b97-4433-5ee6-08dec6e97275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
fall-through case mapping both to VclkFrequency, since SmuMetrics_t
has no DclkFrequency field and DCLK tracks VCLK on VCN. Add
VCLK1/DCLK1 metric handlers returning 0 as the struct has no fields
for these, avoiding UINT_MAX default that causes N/A in amd-smi.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 2fe006de927a..c977681d8946 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -281,9 +281,13 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->SocclkFrequency;
 		break;
 	case METRICS_AVERAGE_VCLK:
+	case METRICS_AVERAGE_DCLK:
+		/* No DclkFrequency in SmuMetrics_t; DCLK tracks VCLK on VCN */
 		*value = metrics->VclkFrequency;
 		break;
-	case METRICS_AVERAGE_DCLK:
+	case METRICS_AVERAGE_VCLK1:
+	case METRICS_AVERAGE_DCLK1:
+		/* No Vclk1/Dclk1 in v14.0.0 SmuMetrics_t; avoid UINT_MAX default */
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_UCLK:
-- 
2.43.0

