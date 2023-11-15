Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF53C5AE4A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B8110E578;
	Wed, 15 Nov 2023 19:44:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C8F10E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APLjZz3g3muZD6vjvBxkoehFcUeDWttl4eqTzXUMaqpJ7irdOLJIMaXAeX/i2+ox0ATuiIUligxNBpgIvwM1y+tQT7RRin+ANlFSkEk0VLQq2bA8bxGSeB+8XZeQZaM6QyLmlGF3oRWdl5vAAXNqbgIcuZ1PN30LdW8uAXDvZv0tiAu57PqG0XiOtVhhYuBJ7WgcB3jB6YOex9u37Va3aeW1Mh+w+44hL8IPlNMwhoCPJ/5OJr2qSQCx6VKZxuQLOP6uaSuChZrdox9xAXSz+UrXPVsAcRJd6f1+jraDMRgwO6sPLZKEXJhoIDDl7nc2vv/fFfHodWhyhSC5GzbKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmWTivbzFhCbbPRPorb6NRss5oQIIOaBWg+piicUCDA=;
 b=X41KxrZ20dpoRFQZLvhBEErG29rx1cY+GxtQyfx646btEJiueWjNDN/hi/gTbrrpzivIJLsVqBzm1uKuE3aOy1epT3vFcmQkZ6MECN35E2v1AsR/mxnIXWpY7xh2nFAPcS4PxKfdxzmYCuc5wd4xU8hvj4XmRqKp7ZGO5CsBtawpXl2FBjU7M9chcLcgVBDeqcRAfgw0DWR2uGcDT2Vab5FIv1w+EFQwTHpp0JApvJTlI4thD9KGfY5PsXy/UELaYSe08l8vC6/ysM35e0t//s2Xee6n8bq0FX6IJ8g/oYGwQ/kEanGW6gQ8ojMrfuUa90m4CynD1rHC4kyaoRz4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmWTivbzFhCbbPRPorb6NRss5oQIIOaBWg+piicUCDA=;
 b=h2VgKeLg7hziloNC8bNp5seNRP0atAKLfyY5bWMpNezYaPKLoBu+0WcxJ/fOAqHPdH78fLSOyGIDEeEpPECCX38GsCYy/JWGUc0XRcTpfKZAonQUj+qGjiOFfZYyJ54/Y6PEkNhhQSIX2QIS8LQBlu5vIiRkuRjph+1l+Sd7Vqo=
Received: from BL1PR13CA0099.namprd13.prod.outlook.com (2603:10b6:208:2b9::14)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:19 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::bd) by BL1PR13CA0099.outlook.office365.com
 (2603:10b6:208:2b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:17 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/35] drm/amd/display: Add Z8 watermarks for DML2 bbox
 overrides
Date: Wed, 15 Nov 2023 14:40:22 -0500
Message-ID: <20231115194332.39469-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 18417a25-45d3-4ce7-5a1b-08dbe61341f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6ELb7YdGoQMAs5fxe79Roo9Q6MJxVSDppp/l+oCL39OE4RkFnz5p5T+FR4oBNox5Vf8N8rZCDI3E5sCpPLJdXJCfJYpTqcfktB5kg7RPEr2zuzTHluUKtcL4GjZSxR7pbeYC3Yb+EZpzmfnSeR2kaR0e5JTvEjn5+NrKTOFzZnn5vlR8vLgVfzJYvmuLQbnrtDdiVuo2X88OIWfpGMwB7pIQ4d7o/GOYDwweznvJ16N940yQ0AaxSl8ru7OTF/WWQh5oMc65j5o3J9D5LVMxtwt2EypxlqVBgYSNAO1JI79Kk5COI9X9KuxBaWKCWfJElTvIKfNFHUMhUuBCPa3NWad3sMHFz79zefrEzY0mG/9fZsJRZz73dBcsZrwO2WnOCxkSIq2nGe97MBRxtzRZvEvyuKrnM0XlIQMCb2Qg8Rtx5OM+ZXUJBm45pibxtPI3kqnH0IHlTMJ0AdQA2Qk2prV33bRu1pfLX/hX1r3De8uB14ZWAGie95DJA6ZHoYu68UtorIY7ixtPdeSVlFzsyPhyt2qPT/ybdU386ZluViURrM1Zp1m8LqwurXLSmsDPhaqsi5KNLz9Z6QJP5JhDOTKc7bb/4WFD8ZTWcG8ShGA07FZJRIYcA49ngt1XmI3LloHt+RpmC0AprifZ+jwY4uqR0Xx4gJeRHFAVvbhoCTJUuQbgeKEVrkotYXM8Q8MtkBH/tcgIBvxGmjIKt4vEBLrsbfEOkN5vdtl/Dx2e63OfLzB0ALXXyOFAR3YugiGARF/W2VE5i7YanZWnU/MiirEVqVFQqMCLUUIaLDwEcM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(426003)(36756003)(41300700001)(83380400001)(336012)(36860700001)(356005)(47076005)(40460700003)(4326008)(86362001)(40480700001)(1076003)(8936002)(8676002)(44832011)(70206006)(70586007)(5660300002)(2616005)(316002)(54906003)(6916009)(16526019)(26005)(6666004)(478600001)(2906002)(82740400003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:18.7444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18417a25-45d3-4ce7-5a1b-08dbe61341f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We can override SR watermarks but not Z8 ones.

[How]
Add new parameters for Z8 matching the SR ones and feed them into the
states.

These also weren't being applied to every state, so make sure that
we loop over and update all SOC states if given an override.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c | 47 +++++++++++++------
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 75171bee6f71..2b9638c6d9b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -341,25 +341,42 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		break;
 	}
 
-	/* Override from passed values, mainly for debugging purposes, if available */
-	if (dml2->config.bbox_overrides.sr_exit_latency_us) {
-		p->in_states->state_array[0].sr_exit_time_us = dml2->config.bbox_overrides.sr_exit_latency_us;
-	}
+	/* Override from passed values, if available */
+	for (i = 0; i < p->in_states->num_states; i++) {
+		if (dml2->config.bbox_overrides.sr_exit_latency_us) {
+			p->in_states->state_array[i].sr_exit_time_us =
+				dml2->config.bbox_overrides.sr_exit_latency_us;
+		}
 
-	if (dml2->config.bbox_overrides.sr_enter_plus_exit_latency_us) {
-		p->in_states->state_array[0].sr_enter_plus_exit_time_us = dml2->config.bbox_overrides.sr_enter_plus_exit_latency_us;
-	}
+		if (dml2->config.bbox_overrides.sr_enter_plus_exit_latency_us) {
+			p->in_states->state_array[i].sr_enter_plus_exit_time_us =
+				dml2->config.bbox_overrides.sr_enter_plus_exit_latency_us;
+		}
 
-	if (dml2->config.bbox_overrides.urgent_latency_us) {
-		p->in_states->state_array[0].urgent_latency_pixel_data_only_us = dml2->config.bbox_overrides.urgent_latency_us;
-	}
+		if (dml2->config.bbox_overrides.sr_exit_z8_time_us) {
+			p->in_states->state_array[i].sr_exit_z8_time_us =
+				dml2->config.bbox_overrides.sr_exit_z8_time_us;
+		}
 
-	if (dml2->config.bbox_overrides.dram_clock_change_latency_us) {
-		p->in_states->state_array[0].dram_clock_change_latency_us = dml2->config.bbox_overrides.dram_clock_change_latency_us;
-	}
+		if (dml2->config.bbox_overrides.sr_enter_plus_exit_z8_time_us) {
+			p->in_states->state_array[i].sr_enter_plus_exit_z8_time_us =
+				dml2->config.bbox_overrides.sr_enter_plus_exit_z8_time_us;
+		}
+
+		if (dml2->config.bbox_overrides.urgent_latency_us) {
+			p->in_states->state_array[i].urgent_latency_pixel_data_only_us =
+				dml2->config.bbox_overrides.urgent_latency_us;
+		}
 
-	if (dml2->config.bbox_overrides.fclk_change_latency_us) {
-		p->in_states->state_array[0].fclk_change_latency_us = dml2->config.bbox_overrides.fclk_change_latency_us;
+		if (dml2->config.bbox_overrides.dram_clock_change_latency_us) {
+			p->in_states->state_array[i].dram_clock_change_latency_us =
+				dml2->config.bbox_overrides.dram_clock_change_latency_us;
+		}
+
+		if (dml2->config.bbox_overrides.fclk_change_latency_us) {
+			p->in_states->state_array[i].fclk_change_latency_us =
+				dml2->config.bbox_overrides.fclk_change_latency_us;
+		}
 	}
 
 	/* DCFCLK stas values are project specific */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 317f90776d97..fe15baa4bf09 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -139,6 +139,8 @@ struct dml2_soc_bbox_overrides {
 	double urgent_latency_us;
 	double sr_exit_latency_us;
 	double sr_enter_plus_exit_latency_us;
+	double sr_exit_z8_time_us;
+	double sr_enter_plus_exit_z8_time_us;
 	double dram_clock_change_latency_us;
 	double fclk_change_latency_us;
 	unsigned int dram_num_chan;
-- 
2.42.0

