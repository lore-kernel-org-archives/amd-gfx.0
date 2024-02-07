Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B770C4829A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFA110E4F0;
	Wed,  7 Feb 2024 20:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qa3u5lMl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5881010E464
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kudta3ZTpqulQblWk8z7vt7XM7HWrOMbVN+pxLddOJ+WSviysZWlmVHupwp6pEqa8we2OVSykIeoEl3s+rxjouNT6BTCoanYc0DTDHbQqyVBMQuUjWLbJ8QdLEEbDLtTrX3GbIA9E6G6FQ1YlVotNTbCVTdG1y8Yi6J5FHxSYxdl1GU/xnyVPHUfGHPGtc0rupCsJQw7ySK1GqJ0teLxgawH/lZFghIEXfR7I3yBdCDvJsP8F62PNWIo3BwxkRxkz0tC79FPqnZWE4eC91nsTh8X6zVRSHUPcbUiSNRZRIGNhz62xcJu2PhLFcZNxZIFu5oMH82XU4KsPNbksduIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIr9X36PzEOr01KQT/VNaYxFF3ET/i6izyCHTfe7UOM=;
 b=JFsdiIj5fRIL5POZiSB4w4aZfLbdMiT50aDPf3JR1uodfxu2xpirKHwbmSFR+QYn6kT4gSOYjauLki9O4v35pDmxR7gWYM6WUR2fAHJolRwzd9MP8WRB/P9cdgCV4EDrrdyNtxv6HlUJMCQWtgN7DpawUdbzbWwl4YrRCA7fLOfO8nOQz4LCFtW8pg3PMw6VVNFA1+qguiZxXQoU0U3AVO0nufc4xEWs5+LP0E9IYcaZZneRKPvG9ObLMAdP+ClqfFpjom0cSbBHTiXhy2QTHwRjILBqqW70+2wWtDZS2ejKLAh1CzesmNB6sysX+tm84xuV0zcrrnznG6mqZatopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIr9X36PzEOr01KQT/VNaYxFF3ET/i6izyCHTfe7UOM=;
 b=qa3u5lMljhpYRIa1K/uVsRjE0OxlDnRxeKkWWCWg1tK5iBHnqqgUMiMDyuReE/Aw5Rljza7mRqA70MuBx4/nyO8BLiCcE15fwYRjPBt7S4Tpygu2ifPYJ9mJdpSHz21CMPUsM9myOip8IM5kAfnIIciKd69F8XMzG29LT3APOXg=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 20:52:23 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::75) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 7 Feb 2024 20:52:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:15 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:15 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>, Sung joon Kim
 <sungjoon.kim@amd.com>
Subject: [PATCH 11/15] drm/amd/display: allow psr-su/replay for z8
Date: Wed, 7 Feb 2024 15:50:46 -0500
Message-ID: <20240207205200.1608684-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 649630da-955b-4a08-9536-08dc281eaede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4bGbLen62Qp5LrFD/XbgwJbtsG/BFn1/1glAAjZnNAejHUpClg91KK9u5oU891rcZpDlVW8FmkmJ2fYUOC1gFw0QKEacHyLiUU+07z+KRx1wp/Zg4a9PDVptSfRm9fEqpAyCcuBmbunqMHgU22m6Un93cNyDJ2krlX+yKLNYRqYRPAq014gUU8gWIQp52L2ZZ8HFR9K47j6HG9o1BTMOTTVPyW3qWSjecf9oVESAsOe6DjlIV3xBLIxpth933QbmKVP095KuNIf4JCHKXn3vhmm15726nqtZWy+qhpkVcngEpPggIjUBTSfl2Zr4BiMM8nQiXb4FA4sQty1PZpxKaUGK4FwbYtc0dF1SFRGp+K3TmnbklEjynT6gedyVb1Yt0xbMUFwaqOTew42Wm2bhWqKnRRvwHouIvJvT6KBjY5Pjw6lYrjL6EhnrYEMfnl6Y5r48qmQNm5O56xNUNQoKe2Lvo//p8xMkRbYSvrhJAXr6cCHHlPzocZCaS8UNk1V8P22r7r1YMfkoQZVo03jklSrvqF28oqovtixJbW56W85puziTMBY6Fjuqg2ckHrVfzJbW3gQ8DHkltL6MJN9ZyvJKBjpfAeJSFsyyJ1dO5U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(2906002)(426003)(36756003)(41300700001)(356005)(81166007)(2616005)(82740400003)(1076003)(336012)(6666004)(26005)(83380400001)(7696005)(478600001)(5660300002)(316002)(4326008)(54906003)(86362001)(44832011)(8676002)(70586007)(8936002)(70206006)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:22.4751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649630da-955b-4a08-9536-08dc281eaede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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

From: Charlene Liu <charlene.liu@amd.com>

[why]
allow psr-su/replay for z8

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c |  8 ++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index a07f7e685d28..9e588c56c570 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -361,32 +361,32 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 	case DCN_ZSTATE_SUPPORT_ALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10) | (1 << 9) | (1 << 8);
-		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW, param = %d\n", __func__, param);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW, param = 0x%x\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_DISALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = 0;
-		smu_print("%s: SMC_MSG_AllowZstatesEntry msg_id = DISALLOW, param = %d\n",  __func__, param);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg_id = DISALLOW, param = 0x%x\n",  __func__, param);
 		break;
 
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10);
-		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z10_ONLY, param = %d\n", __func__, param);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z10_ONLY, param = 0x%x\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10) | (1 << 8);
-		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z8_Z10_ONLY, param = %d\n", __func__, param);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z8_Z10_ONLY, param = 0x%x\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 8);
-		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z8_ONLY, param = %d\n", __func__, param);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z8_ONLY, param = 0x%x\n", __func__, param);
 		break;
 
 	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
@@ -400,7 +400,7 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 		clk_mgr,
 		msg_id,
 		param);
-	smu_print("%s:  msg_id = %d, param = 0x%x, return = %d\n", __func__, msg_id, param, retv);
+	smu_print("%s:  msg_id = %d, param = 0x%x, return = 0x%x\n", __func__, msg_id, param, retv);
 }
 
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 912256006d75..80bebfc268db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -588,7 +588,9 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 	} else if (context->stream_count == 1 && context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		bool is_pwrseq0 = link && link->link_index == 0;
-		bool is_psr1 = link && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr;
+		bool is_psr = (link && (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
+								link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) && !link->panel_config.psr.disable_psr);
+		bool is_replay = link && link->replay_settings.replay_feature_enabled;
 		int minmum_z8_residency =
 			dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
@@ -596,12 +598,14 @@ void dcn35_decide_zstate_support(struct dc *dc, struct dc_state *context)
 			dc->debug.minimum_z10_residency_time > 0 ? dc->debug.minimum_z10_residency_time : 5000;
 		bool allow_z10 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z10_residency;
 
+		/*for psr1/psr-su, we allow z8 and z10 based on latency, for replay with IPS enabled, it will enter ips2*/
 		if (is_pwrseq0 && allow_z10)
 			support = DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (is_pwrseq0 && is_psr1)
+		else if (is_pwrseq0 && (is_psr || is_replay))
 			support = allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else if (allow_z8)
 			support = DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
+
 	}
 
 	context->bw_ctx.bw.dcn.clk.zstate_support = support;
-- 
2.43.0

