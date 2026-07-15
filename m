Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B25EC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC3A10F0AD;
	Wed, 15 Jul 2026 13:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtbfpUKf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273AB10F0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN5qzJ4Iok0YSppm9JxWjqaDPWDGfSuP15Hhktk7KiY1RM2xlnMdMcqbE1sUkfkzYeUPhcqdFcy36FtkTYXdASVDxQH/ktqbbSsvivnpAYwEBsBi5nFeBGOA2LseHpgzZ9DtKSQpQ5tmFq3DflU26EV95OqdPaf5FQAQdy3JFKxH62ghVkGsFTUAtGIHQt2mSAxJtsnN+fMlOOEqGgeW+PJ2C1WJ0XRu/KfyOMTUNz0H47oMJZkoPMxBtr+u7UIcerWtIbo9q70J/95jz/G9EPqI2LWZ75DNgaiD9GOW6fkf64DnZob2KX8zsBoNNtNZDsZvbIeoUYkOwUtPLXEfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsrFCqSBXO1nrTFcQAas+6Q6YjirsMZLW6XJ6171+Q0=;
 b=wKQQ8F+GigKL08l+q3oHeSHJ/CTaAQnqREboazLYp9Evgb8kO3i2rHLxKtKun8Oluz8OqnO1zqrmycxvT/4XnqYmDdivqNF1NYBxj8o07AGw+Ev8zDT/vDmM1jKNhanWSLY5MfAUdnKRsw8IJiiKPtIxXwTuHQjs93zmOa+rINgRviLLc8fKewZlbj2B5q4WQBTYTJc+CaeLDaoPq6p9bn5gBIHWAoOLA8vfAlZyiIm4elKP5Q3HBA0nD5i22/rWoWZ8OG9INt73yfRTVR9qa8fL3RtqeXQ/w4nUTgXTgj1yLJ33j3QvwRsycSSFaKAm7wxl0DAF3MvdHgQugozj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsrFCqSBXO1nrTFcQAas+6Q6YjirsMZLW6XJ6171+Q0=;
 b=XtbfpUKfPtuE6xXlgouZIVNX4CihlwmMULAi9GNDPhKkAkojhoTvXV5L8ua3+pBzaZZEHHJeqPIS5OfZb5DJSAUYVRbiIu6lsh0zcsFGZRaqHKmAQHVfMWBlohnH4gDqhyP0UjejVRxkZN3V67nu8MiEkiqv7Om3TzFIIR7kT6E=
Received: from MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) by
 BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 13:48:46 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::59) by MN2PR01CA0064.outlook.office365.com
 (2603:10b6:208:23f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:44 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:41 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dyllan Kobal <dyllan.kobal@zetier.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 61/70] drm/amd/display: fix wrong register field in
 dccg35_set_hdmistreamclk_src_new
Date: Wed, 15 Jul 2026 21:38:11 +0800
Message-ID: <20260715134432.1975118-62-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7fbe43-2966-42aa-0173-08dee277cabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1xtF1sde/7jsV58nT4yqU1EpuGIisIFfsoK7NreAPMQbTHg/H6pnTOBd8+zSRMtvw8byrg+2mI1RO3LRNmg0UxoUKIIC7/MlmfWDOJMDlx5Uh0LFTLC7N5Yn0sHl5ltLtfZz3/xgfmPcksQz7feWihTr2uzj4Uiq+/o1vwp5/sqZoqWtOZg+MYM7LFpSu52mnZm3kND0jzZA5MoxujZaZPbYeybtwh6LE7x/MCbrcA5k8DNgY6IvKR3b+AJoWeyaLmM/F0mkpZy/Dd4ZssG6IpkTkVTDbwm2nnhXkCkd5vUL+xT3NUhyJxqjfS6gHQZikNdgdUrHpiFuXgMwjbD/DgDEfS+Nsm9t6s0Q03NZXU8QwkpKVa1Tyun7U7PiSGAtVSbEN2vpVS1B3ZBSa6xri+Mv6dha/xPyXsUVSOzO12WT1XsdM2a21IKgiH4iuZpnPN49JKZ4Qmuu2JcplFvsmcVg1uhT+xhFU8Ti9xZV1648uq6Hjj8O/RxTQoFteJdDCnhFgC9nz8laL2g1gEg76ywLj6Ygx7Qs715Qa0gPuvWPdSYUaHbnKxPswFVl5DOy5pOorcFCz85406Ezy1SNKZpErD6NwvJUlzyzu7BseYTBCT3eLKD4wzS0BCSI/u5EbejOxQU/r3mIRFVupQstQ64S3fuqI4WVIjnP3AsPPKCPciSOWa9t2Sk2STBmGAYHiw9uR+zoTaH0HhBCPtnABg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EwqqI75YPQOYRkwtAA6MieHC0nyzAd1/jvHcY3SGpeVXdWe7YuOyPrd+CqR/Lw43ZN5xASJ9eN2sdgnD4KD9XvfEMxjEwt4O6h8MTJnJtkr4SSR0JuSEUQeVjcj/jBwOaPMtsvagiQ/pru1AKiY5GuawRa81Hs7o6vlKQTEJumDcjAXpGjdqdHAqMlGl3k/8+wEUFrZREZxlnBRNDdbU2yVnmFptN846d0YUCqyQJFl6g0qfFLIrpPTEzRuF5zvLh0ewDvtinT/YVRSUR1z+RYcWPdDq2CdkrZZnxgWfxVb3D0SJwNUfpKxsrb89gMBz48/kwgWhrYMfxtkrJFszw4m0S1KK4qRVh1J+ZtxW+iO3O4zXEF00wcNI3soCbACG7a9Kfi+Vkk+DQWevbehGc0Bvb8hWL7GeqT0rYSfqBelxXWvUvY3QUgb8e8v9OdcP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:46.3059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7fbe43-2966-42aa-0173-08dee277cabc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

From: Dyllan Kobal <dyllan.kobal@zetier.com>

dccg35_set_hdmistreamclk_src_new() updates HDMISTREAMCLK_CNTL but
passes DPSTREAMCLK0_SRC_SEL as the field identifier in the second
REG_UPDATE_2 slot.

The current behavior is harmless on DCN3.5 because both fields share the
same bit layout, but it is still incorrect and could break on future
hardware revisions.

Fixes: d36771a03412 ("drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL")
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Dyllan Kobal <dyllan.kobal@zetier.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 95ba9baa5102..a7db8a5194e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -572,7 +572,7 @@ static void dccg35_set_hdmistreamclk_src_new(
 	case 0:
 		REG_UPDATE_2(HDMISTREAMCLK_CNTL, HDMISTREAMCLK0_EN,
 					 (src == HDMI_STREAM_REFCLK) ? 0 : 1,
-					 DPSTREAMCLK0_SRC_SEL,
+					 HDMISTREAMCLK0_SRC_SEL,
 					 (src == HDMI_STREAM_REFCLK) ? 0 : src);
 		break;
 	default:
-- 
2.43.0

