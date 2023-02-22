Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB3C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B432010E3F2;
	Wed, 22 Feb 2023 06:42:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5295810E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njk0klAhRH0IwnDj/D8jYYMgevqfuLAWh8HCpJC3XNHZ1t3nozDCCWOSX+0zq86iHYmNhZM0mwqC8TomR65WzHKHgqVf7AaPo/sUSLOzYLVEX5/KMK1jMe8sp0QBX5TrrgAky+Or+EgULI4uQIvqZ8Crl1BIs4cn5lFFQ8iH+2RinJMRVtg4Lznfk/VE+f3aPae5xMOsIUnLEJ64bCa/epClusD2qE3nzMVcjwQaGexnNejt5LId2ODI0bHkGiLBg0Kbsjrb3vu8cz8YEQrQ24etoV963Vhir28XEKH9DS+QAbq5+VjlJnYY8AmxUnciLvxsNXq/n4pjHX64LaUEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoRBaxIFKowHIfhjrAm7fHRMqX0V8f2Sb+unuT0ZOck=;
 b=U4xPAYnMjDjD8fL1X/UM6hcezzzIvhKJSzOqAeRCuJ+UbnGnIEn2npXjXzQ6Lis6Pcjz4L3YUAwNK/17lHF+m9vSF9r5dDOwRTMLR00qkA47H2MrAgOZCq9dcqCTjtMdN/OT3hHEJNVC9Aohbnr27I7l7ck/nqfmtO+6rdSG7HkzEd+WERqTC+JNVJmx7BYvWI1MCsJSL8K3asy1ZEA7LlMwsigXtcHt/5sKdizreIGA1ulVgSUmK3LRDWe+id5cdkPZL4+Yt1NcNVnql+EzeLfaL/Xzt6CfcNK8WdYV9YEyLYziPfrdb+bf2uQaQlOnek0gVC8GmrzxbrY3FOQUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoRBaxIFKowHIfhjrAm7fHRMqX0V8f2Sb+unuT0ZOck=;
 b=be3jY9r8W1TOPGqZFpnC+1A4lzPwRfZIFTTTQFIvdyW/taoC6K9bqpfT9HYHNINK6v4HlDStrlVTqvsit3z+UieAPDkO5CspUqb9glXcaa+h8ugq4iQ9v1pIeqxk8w3pcJ6uPEHnZGQMcjHf3orkSNQc6ezs8GblafdlhxQ2N6k=
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Wed, 22 Feb 2023 06:41:56 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::82) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:56 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:49 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/20] drm/amd/display: dcn32/321 dsc_pg_control not executed
 properly
Date: Wed, 22 Feb 2023 01:40:28 -0500
Message-ID: <20230222064041.2824-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc61ef5-f5f1-4e3d-d3f0-08db149fe442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vY85XzdXJpeFhT+vi0g0rEXAjYA1KY3wC58P1UuY6BVUvxOWRQhtlGDxqmp+QN5sqjoWC5KLIhr5cYZBRNt2rkBy8VMbulmqGJh3g2BR1qlOWq1R/b7bFKijtNxfc+zcfrIDTRPZ/V4nnqbAogfPop09ZdQkvbCTiXdpklQtPVHQaSeKYNd8PRUpCgnO0VOSoZW66OU+vy2+V4GEde8CXjKUiW6qRsaFqORBHLvC6RwBfSqjke9lyqQQpWk+GM9lKrMUgE6bMqaShJuIYUhFKgN2PsbyNk9GyelUHTOwrILbJTxXt14aDEbUWfMsSBP8Zg591Al9neDAXXDoS3QHesCEKHZ7U2t96y+YJa0LL7nWf4rpuxdS+lUfetI0BOlXCQ3Q274A9RQtzI89WrG5+m1DX5OZlSYUhEOEXLzcdnQFSSoiyjngqvQPyTdy9JwLat02HQ9h1cDT1BK1NzFGcwR2wyOy3FgsZM79fbR4Ly5AWYZZWHQkuBPfryUnDnkiFkhJe64OsTC7FrLXlz/8X4w7f32LQa4J940EFCbEMtG7Si/OstwQML/Z6CkRlW5JW5caks15+X9ef2uY4OWj12MCRWTYbfU2ZH1oQBehD5QTRDmd4ZFYX+N6oe7K2KWIt681AXx++wRWrZXXhkyOdR5SG5yZK+rNPMhcyDeI2aA58ZX5HfNWn+F/TLsLRkgPtF2Q+OJ1TzpmRXtN9LcY79ZOkvdd1jLbPTD5FPQwAiI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(1076003)(47076005)(426003)(83380400001)(36756003)(40460700003)(356005)(316002)(82740400003)(81166007)(54906003)(2616005)(40480700001)(478600001)(16526019)(6666004)(186003)(26005)(336012)(8936002)(2906002)(5660300002)(6916009)(41300700001)(4326008)(8676002)(44832011)(70586007)(86362001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:56.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc61ef5-f5f1-4e3d-d3f0-08db149fe442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[why]
during boot up or resume from s3, hw default value of
domain_power_forceon is 1. when program domain_power_gate
to 1 to power down hw block, hw will not change to power
off due to domain_power_forceon = 1.

[how]
enable_power_gating_plane(true) should be executed to set
domain_power_forceon to 0 before dsc_pg_control.
dsc_pg_control is already called by dcn3x_init_hw-->
init_pipes--> dsc_pg_control. no need be programmed with
dcn3x_init_hw one more time.
to trigger dchub, dsc block power state change, need
program dc_ip_request_cntl to notify hw block.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  9 +++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  5 -----
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 19 +++++++++++++------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b83873a3a534..8b5181f3d13a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -190,10 +190,15 @@ void dcn20_enable_power_gating_plane(
 	bool enable)
 {
 	bool force_on = true; /* disable power gating */
+	uint32_t org_ip_request_cntl = 0;
 
 	if (enable)
 		force_on = false;
 
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
 	/* DCHUBP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN0_PG_CONFIG, DOMAIN0_POWER_FORCEON, force_on);
 	REG_UPDATE(DOMAIN2_PG_CONFIG, DOMAIN2_POWER_FORCEON, force_on);
@@ -224,6 +229,10 @@ void dcn20_enable_power_gating_plane(
 		REG_UPDATE(DOMAIN20_PG_CONFIG, DOMAIN20_POWER_FORCEON, force_on);
 	if (REG(DOMAIN21_PG_CONFIG))
 		REG_UPDATE(DOMAIN21_PG_CONFIG, DOMAIN21_POWER_FORCEON, force_on);
+
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
+
 }
 
 void dcn20_dccg_init(struct dce_hwseq *hws)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3b4d4d68359b..0f7de972c80a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -534,11 +534,6 @@ void dcn30_init_hw(struct dc *dc)
 		}
 	}
 
-	/* Power gate DSCs */
-	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-		if (hws->funcs.dsc_pg_control != NULL)
-			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
-
 	/* we want to turn off all dp displays before doing detection */
 	link_blank_all_dp_displays(dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 16f892125b6f..f667f2a6f686 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -131,10 +131,15 @@ void dcn32_enable_power_gating_plane(
 	bool enable)
 {
 	bool force_on = true; /* disable power gating */
+	uint32_t org_ip_request_cntl = 0;
 
 	if (enable)
 		force_on = false;
 
+	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
+
 	/* DCHUBP0/1/2/3 */
 	REG_UPDATE(DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
 	REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
@@ -146,6 +151,9 @@ void dcn32_enable_power_gating_plane(
 	REG_UPDATE(DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
 	REG_UPDATE(DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
 	REG_UPDATE(DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, force_on);
+
+	if (org_ip_request_cntl == 0)
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 0);
 }
 
 void dcn32_hubp_pg_control(struct dce_hwseq *hws, unsigned int hubp_inst, bool power_on)
@@ -786,10 +794,11 @@ void dcn32_init_hw(struct dc *dc)
 		}
 	}
 
-	/* Power gate DSCs */
-	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-		if (hws->funcs.dsc_pg_control != NULL)
-			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
+	/* enable_power_gating_plane before dsc_pg_control because
+	 * FORCEON = 1 with hw default value on bootup, resume from s3
+	 */
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	/* we want to turn off all dp displays before doing detection */
 	link_blank_all_dp_displays(dc);
@@ -886,8 +895,6 @@ void dcn32_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
-	if (hws->funcs.enable_power_gating_plane)
-		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
-- 
2.34.1

