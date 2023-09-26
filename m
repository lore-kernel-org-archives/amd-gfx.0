Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36758E7F13E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C641E10E43A;
	Tue, 26 Sep 2023 21:53:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C6110E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8n8HsQQoyz2dntcF+k7ocYva7UA6z6QvHfQ7cHJPNQLatripwbNDUIcftKEhLhQsOUS4ujIpMg2JN1kWhJpgtvjaE02+NYpVPyzxnywxBF0EIiEVRrRdxeQayF5aWryysrwNcZsvHAl0AimiRngLYKI2JFhBGMcKbTzepYdKzX9Y1mcpEUlFRFKPfk2v1UcL9hmVdBPzBpCjiT1k27ti0X5tNWCE3mN4up9/4m2A4LsO1w6+WNb+JpvqQxYIGZF/9Vccw1HFdxRjldKGF1shaYLZTVZd4czXO4gWHOZX/e7cTKnGUIPj+I7oJ+iHt0MEmwGeEokCIBObJSn4DaIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IrtlREcJE7JCb8l7kvOkqu4YbSNIfCgosShMhBGY+4=;
 b=ij5UTN4okHo9mP94GeQeYhGXkUGXcwHOdovNd/kNxmHpHsITmoJunOP7DmlW3CFbN7mX62wzTeibvx/3Y6IVFZtXWdNTpqlNYmgBII0acsRAeDjFcoyKTuj+sOXosbz2cwiMcOLRHeL3xvANefOT+sG5YZYVG6CsbTK6+wueXEA6a0drUruQ2DvYjwrzAXRbpPPQFopekUWGsVoLYYjq0S6o1bE+sMkNqf8L5PUyHcDLuqcucvbJdWlf5FjGyHMRViIbPnXd37THCw/i6beOA3gypxWLIp1b//XPrGOO4UHEGSdRwmXIkv8fXBUyaaOj1AG32IFCc5zn8krCbi06Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IrtlREcJE7JCb8l7kvOkqu4YbSNIfCgosShMhBGY+4=;
 b=4BUmd8IVnFWSNOa4T3hP4tNcIu+QVWRi198Uy6VeF3mOwDaSVZVVqLFRy+4togl4ZeJgNA57RiNw2/pz6NsYVpF5+ku94FStw9faZ6RzzXjFDmq/Jp12ePkqn64PFi333mdHtjx7c3LrUiG5hKwvwbYn6Tb/PAJS5K1cyvLvU10=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 21:53:43 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::35) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:42 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: fix problems in power_helper
Date: Tue, 26 Sep 2023 17:46:52 -0400
Message-ID: <20230926215335.200765-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c60fa7-9439-4493-ebfe-08dbbedb0d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJ+OLZj/ELHpLA2Skg6zEhD6kwOn3a5plvHLOx6GuaMdD3mgHt1Yl3NJKqSp7Hmy4P6f80Iy4rsXXWrsKsLhRFwOsK+V1o/6IU2wN3DcYkKi0MD6m91pZCeFqdUF06GkjTtnmjMj7kVCNTXroR3WmUrw0pp0Dtnf7xeovn2JSL0s1YjFh5tuQCvqlAYBcyOPDP1mH52U9SSG14dcqqoMtf6XiN1lQsLyL0AReMJ2xR2v8yg6EWZdS1sZwGDjUiOhU/gHUkgDToet6dajD8fgIOpKr0IaWYugcr/Zl8dPBgNZhj0PCg4X3XD2t/6C9pKQpN0svUtUUxIw3Zd7LHObWcDmwgCjuFQZGEDdAP7h4h3XTURmXidvlO6ypZyo9Ci/aPdveQQJlqnir1Vh57fjnzFUWK2gT4OQr7+Tv2J2qnUOnlaWfGg8Hk4Xtf0UggreMTOCA44Ha+D7E67qSj4dJ+Y34MzCeMtp/8/yOuMHzXvGX1bJRnpRNBMa0fNl/u1l6al2DvevNNacQudPfwtBZCdR7ok6LczdZi216n2qGQaeGhhi3vR5tY/rhRXNAilJfoNfI/aBFdO9b0NvQSCr6jeRZIFdoaHD10DYW+ROdYsDpwc0d6bAonMHPdq+w8egf76g6ekWtGJhrozHG5zYI9DqPHdW4cf3mviNDGmdBVP797dRHAuwh0RYpCtY3eMIGWOFGZ4hwG1XTf94SLeI86TyBDDuXdPuouFa8PPd71JOYciAp6IWB6PkOcNjD1oXxfdpEeznw6jRsuShsrr0JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(336012)(6916009)(6666004)(70206006)(356005)(7696005)(82740400003)(426003)(478600001)(1076003)(26005)(41300700001)(2616005)(54906003)(70586007)(47076005)(81166007)(316002)(36860700001)(2906002)(40480700001)(83380400001)(4326008)(5660300002)(8676002)(86362001)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:43.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c60fa7-9439-4493-ebfe-08dbbedb0d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Robin Chen <robin.chen@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Fix following problems:
- In abm config, forget to initialize config.ambient_thresholds_lux.
- Adjust the coding style problem
- Restrict to call psr_su_set_dsc_slice_height() under edp only

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 73a2b37fbbd7..f1b2d8bc315e 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -719,8 +719,9 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		config.backlight_offsets[i] = ram_table.backlight_offsets[i];
 	}
 
-	for (i = 0; i < NUM_AMBI_LEVEL; i++)
+	for (i = 0; i < NUM_AMBI_LEVEL; i++) {
 		config.iir_curve[i] = ram_table.iir_curve[i];
+	}
 
 	for (i = 0; i < NUM_AMBI_LEVEL; i++) {
 		for (j = 0; j < NUM_AGGR_LEVEL; j++) {
@@ -743,13 +744,13 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
 			config.blRampReduction[i] = params.backlight_ramping_reduction;
 			config.blRampStart[i] = params.backlight_ramping_start;
-			}
-		} else {
-			for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-				config.blRampReduction[i] = abm_settings[set][i].blRampReduction;
-				config.blRampStart[i] = abm_settings[set][i].blRampStart;
-				}
-			}
+		}
+	} else {
+		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+			config.blRampReduction[i] = abm_settings[set][i].blRampReduction;
+			config.blRampStart[i] = abm_settings[set][i].blRampStart;
+		}
+	}
 
 	config.min_abm_backlight = ram_table.min_abm_backlight;
 
@@ -944,11 +945,11 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 	uint16_t slice_height;
 
 	config->dsc_slice_height = 0;
-	if ((link->connector_signal & SIGNAL_TYPE_EDP) &&
-	    (!dc->caps.edp_dsc_support ||
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP) ||
+	    !dc->caps.edp_dsc_support ||
 	    link->panel_config.dsc.disable_dsc_edp ||
 	    !link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
-	    !stream->timing.dsc_cfg.num_slices_v))
+	    !stream->timing.dsc_cfg.num_slices_v)
 		return true;
 
 	pic_height = stream->timing.v_addressable +
-- 
2.42.0

