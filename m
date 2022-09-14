Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C688ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82CC10E855;
	Wed, 14 Sep 2022 05:20:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CCF10E855
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqjmvqffAQvLpDCP9kt7oWpCg24HTm3ozQDcdZ9n9C+U+iKrTYcEBcKgeKixD5iuNK6bSp1ywgsda4t/8KlCctWaKnURslq1JKel24j6y9/XzGLGeN9T4uXKX6hzMUim5igv5rpAiLgvrzMqEUoEzW5pHysP2mo/yWCUlXdpSz+MCFqx9VYlJA7LF7uWjdmNm60o2/yuGDVcWC6Q5StZHKIKmsWMf4yyyP5OPuGtKLvtQukfU+xXEB6b0B31N1yrMQPTFn22IKEOfwfZ/rkov28NL+I8fM4lp+E+3iRhjzzZqwavDNCocVCBgTXiyNRAnMjI4NBK73XmGUXw+Ce2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vr3O6ekARkUcnKkLCPHtLkZriXw4kS1ft1xVq1bu3w=;
 b=a+tlFlsYaJHKlVXGgFB6SGcaEAd5E9ohiMk6UlPDizjh+OEl4wi/pNkZj3fcc4fpC9llMllL/3Ng6oYLuzJmYxnV6uXhhdAuAuMuqO54IiHvshLu2TnWCAYAjMh3svqsGG4HGDgCf5pkzDihjNKK5SvQ6P3suKsd2H4emlIQ65yTAiLsEbWc/CXQtbAY6iR6GCai/qLMsur3NeBN5QBagFOVvvpv2Q+9QjFkWe1n22/4/Qya3PFN5UECrXJQIxZi+/6e5SWIphl2MTY+CdE/OF1OfhXqga/DM0P9NUr/l3lHFBkf2RUhOdkuupUTo/sEt5fxKdwIbbTI9lagn4WySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vr3O6ekARkUcnKkLCPHtLkZriXw4kS1ft1xVq1bu3w=;
 b=nEenSrbeo2nN4fWPVE7eKO17vBX9rVkK+kuo9CnTkNKbYN5+YUpx/6cMcpQIUNvxX2374AAW7grFG25dePXh3IQ9KSbtu7ZVHh/UZGRv9vIsRmP3BP40081hcv0Snal3iB2FWec864l22I07I4cuSlKPRe6rbLOt0ko4Oy7NSdg=
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:20:02 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3a) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:20:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:20:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:19:08 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:19:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 44/47] drm/amd/display: solve regression in update phy
 state refactor
Date: Wed, 14 Sep 2022 13:10:43 +0800
Message-ID: <20220914051046.1131186-45-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fa2a99-785d-4351-ab3a-08da9610c67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwUu+z99NP+0SNMV/XALtyySFAjQO/C4Z48ZzSSOWv2CO2zoYbVbqbNAkiIqtTp4Gsgw7s1ksj7x8K1jLLB4BHhshZpH77amW4pVrAQxrt/4PoicXIMP2MqQWvR8wfKGQzzozD4uhWuZlpmQBq55p4ucDBNOI9lQhtLIc4khzfB8+HbXMJ4is2HqmhVB4uMkGi5p+QmRDi+5F2jVaeuW7ZqxoQcOS+6G4isc6Qt0saXGs6cGxl5sg2B+PtEB/eHsRsit0bHainqmfMMKyJV1AccTowNbvEOwuU3+9u4WMlkdEtEYLmrW1A9YdZwiRoyAK3vn+ah3n2iUaMS4xxTPF6akRwrxSIv34wy3DYa3tZGqwKvDvFQYG4DDlDsO0hXf3zJZJC32aEdNgn9EQtoy6vTBotsKS/gYXxrpgj07iHW3xBTSDOk0PiV5wYoNGufJpO6b9zwN9Z3kbF7DFjUf3Dy8bshxv5DfCzWrLiYsAuDW/6CMYvUOfO8ttjFufcHOHgHfjPci312wk8xvGPp4/qBDEOmtzVdj1EZtYVyOs6ah6qokLZdPWX1pcabXxJVf1nt8gnPvVLYWONqNnsrpd6G4zlrlGdH6nQ2ko454XAUpsBKal4JMo2/G3MeD4dm+Wv7/aJ0OijKM6RMUWY5Hd5lytjJWuPiHSAu6wyxdHjv535q4Aw7LaQKfESoE9F/Usol6B7DIZRiX6+ktRCz6mI945vdE41InsloM4U86ew55jJcx/jYlmyUpfnzfo+PLjOrXKraZzJ6DLC23uy7/52hI5YdOvNUHBSQtiMqAhJhiLHrxJJamnxnqR014XWud
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(8936002)(82740400003)(36860700001)(6916009)(426003)(40460700003)(26005)(8676002)(1076003)(70206006)(478600001)(7696005)(70586007)(186003)(4326008)(86362001)(81166007)(40480700001)(5660300002)(6666004)(2616005)(82310400005)(54906003)(47076005)(36756003)(2906002)(336012)(316002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:20:01.8042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fa2a99-785d-4351-ab3a-08da9610c67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
There is a coding error when moving dp disable link phy to
hw sequencer, where the receiver power control is missed during
this refactor.

[how]
1. Add back missing receiver power control in disable link phy.
2. minor modifications to ensure there is no undesired sequence
changes in dp link enable/disable.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c            | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3118e6f808f0..7842df9f62de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7073,9 +7073,9 @@ void dp_enable_link_phy(
 	enum clock_source_id clock_source,
 	const struct dc_link_settings *link_settings)
 {
+	link->cur_link_settings = *link_settings;
 	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
 			clock_source, link_settings);
-	link->cur_link_settings = *link_settings;
 	dp_receiver_power_ctrl(link, true);
 }
 
@@ -7149,6 +7149,9 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 {
 	struct dc  *dc = link->ctx->dc;
 
+	if (!link->wa_flags.dp_keep_receiver_powered)
+		dp_receiver_power_ctrl(link, false);
+
 	dc->hwss.disable_link_output(link, link_res, signal);
 	/* Clear current link setting.*/
 	memset(&link->cur_link_settings, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 55c98dbfcc1c..2341982ee0a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -3098,6 +3098,7 @@ void dce110_enable_dp_link_output(
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
 }
 
 void dce110_disable_link_output(struct dc_link *link,
@@ -3111,7 +3112,7 @@ void dce110_disable_link_output(struct dc_link *link,
 	if (signal == SIGNAL_TYPE_EDP &&
 			link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_backlight_control(link, false);
-	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
 	link_hwss->disable_link_output(link, link_res, signal);
@@ -3120,8 +3121,9 @@ void dce110_disable_link_output(struct dc_link *link,
 	if (signal == SIGNAL_TYPE_EDP &&
 			link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_power_control(link, false);
-	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
 static const struct hw_sequencer_funcs dce110_funcs = {
-- 
2.37.3

