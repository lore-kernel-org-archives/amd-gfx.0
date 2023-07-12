Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F71EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6987710E5A1;
	Wed, 12 Jul 2023 17:12:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AC510E5A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKbYvDRhwvbh0kmtyYPVsH9kNuSlsKONObe8iSOv85PTPHr+kfxp2bX2eVlVn16dwrNOOoJzpVRO/QSMn/of6iL1ft+M2VTQRdgXXeEUCr7ul0a9ZkvjmnX2gzwTZxPvF9mLl5aVw0thor4g7Nw6BSA+SKFGOxdNoNfaFTaNU8jpM2TuFJMzC2L3WmkbSDikB8a/orWjeqUE6evMVgT84Ztf5liMRfTYahvRpS9EH0s+dZslUFBKjcOCSWQR1Ma9zo8KN4UZcjVmvngOXYwXquEn0cqLcnZ6X5rkV4R5G5/3FIY2XVVXlKpWT+zu2PshMBJXnWMNlpx57/x7yHtAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCIuiLcJiD709FkJPXKE9HINJQKSiJ0xdgBZpZdJ9y0=;
 b=UTcR+EzqW6wKqVZSPe5Y6JW2jL/5CtZzFWKpy3yVMcGmlp202VsRf/XVUO3UOyKuPPb+OwFrgpJER8rAPp5W7LjvJDyGyn7r3Iztk18uVU54w96+JOsuCU/Xm6OfmkRx1RqtmbmgjvdYrJo4egnOrqqAWLzJt42yQqbk+jMSuknASbcld0f94OCzgfiLiVzKHcIgrSlNal3usmb1+nCjTo3TDT8E8K5OAnIa8hfvvc6Vi70cPQcyiVyms4IZiP5kPPghOdyVvVowxBncp+fiiMsN4OFSYXTRa+BYI9mUWHckVU78S0J2jxUn6DaWyreHECsMhubuzHjo3nX4rk0hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCIuiLcJiD709FkJPXKE9HINJQKSiJ0xdgBZpZdJ9y0=;
 b=DNl4bP5wuNknoG+CDA20wlAWQsCWFORpodGsnWc2tcyEb4iHmnS+pcoHvwUY/VN7Fa7NbkK874m8lx6Atf2ckbbxWAsv7bResNb5m7uQG7CTfaC/ukpfnfoiRacbIPvR22Q5vWq777xdaWa4WVtKV4Z7w4oFRGiDOplRR7hl6P8=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 17:12:14 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::7f) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:09 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:06 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: Re-add aux intercept disable delay
 generically for 2+ LTTPRs
Date: Thu, 13 Jul 2023 01:11:07 +0800
Message-ID: <20230712171137.3398344-4-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d369483-fb47-48fd-b47e-08db82fb232d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FivC+ePioX0RRNBugsnrdlh6BWBVhUHnxNq8uiOppD2iNTF5EegNfUvg98UbtYjkDylnqAsOsNDBa5fkQlLYkP6n4xZ6mCJ53GL9MSdByeJQy/VNX9DM8ktCDuh0AN2PM+7iIznUuduVna7JpzzlvWvIHZdteHi8K0Ul5FNRjaXpD2db+viVt95LcxFHkYEokATmsxgW+eC+EPkaZOna+9YpXcDoKtKZ+c5bRlppAzmVg2/KENYCzkBLixOMfL/Nf2VCQJuucEJp+N2jwa+PMwe9r0gjjHOzhtQu6T3T4Tq6V7DEfIZ5Tgo/GJToxt62GA/lVlr84mTRpgrSgpOFAW+T+h6JAulkHJsVHAYCnXxmCloUnI5oy1sjcXkWY8D39JFBYqGy5OXC/7Bs7tY/z0YipF7vyW5H5zCr4SwlNmitiNczntTTbNYR21AQLU7BY8mIZRC5gjtaio+lyJeDXJi0HGrSMechVX5KNQxEpOdpfd0GTOSaY8c0gBDbsuImv4/TYR8C00AiD+jQPF0xT4wspitByQO7tlInAVi8Kd4Y6zjaWzlT3DEjPZy5+azW3KwC3IadFE9QffH60TjeS88z7UuUcXPmaKGVA61y9aWEzOOaKuT7sal2qABSU806sr+SRwzlK+qbOz5aqefuAiajSCE00f9Zh5skBRwVNXTxFkMBdCSQeXyXomHU+Ik1Gt4Dyh3X1l+hycdfvkyVhadU8C6S/y9yZ8Gs0L7kWmSw1r7jSWi+2tqcpUVgOYXItytZPjW96bGfruYyQHBspA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(81166007)(356005)(426003)(82740400003)(41300700001)(316002)(2906002)(8936002)(8676002)(5660300002)(82310400005)(4326008)(70206006)(70586007)(6916009)(40460700003)(36860700001)(47076005)(7696005)(83380400001)(478600001)(36756003)(54906003)(336012)(86362001)(1076003)(186003)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:14.1188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d369483-fb47-48fd-b47e-08db82fb232d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Issue not display generic, required for multiple 2+ LTTPR link configurations.

[HOW]
Revert monitor patch change and remove delay for single LTTPR case

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 -
 .../link_dp_training_fixed_vs_pe_retimer.c    | 25 +++++++++----------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 358cfa86b7fa..194f185e7798 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -861,6 +861,7 @@ struct dc_debug_options {
 	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
+	uint32_t fixed_vs_aux_delay_config_wa;
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
 	bool allow_sw_cursor_fallback;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0ce7728a5a4b..0564f55aa595 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -189,7 +189,6 @@ struct dc_panel_patch {
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
-	unsigned int delay_disable_aux_intercept_ms;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index 15faaf645b14..2a4f70acc7fa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -244,10 +244,6 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
-	if (link->local_sink)
-		pre_disable_intercept_delay_ms =
-				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
-
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
@@ -260,10 +256,13 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	if (offset != 0xFF) {
 		vendor_lttpr_write_address +=
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+		if (offset == 2) {
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
 
 		/* Certain display and cable configuration require extra delay */
-		if (offset > 2)
-			pre_disable_intercept_delay_ms = pre_disable_intercept_delay_ms * 2;
+		} else if (offset > 2) {
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
+		}
 	}
 
 	/* Vendor specific: Reset lane settings */
@@ -596,9 +595,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	const uint8_t vendor_lttpr_write_data_adicora_eq1[4] = {0x1, 0x55, 0x63, 0x2E};
 	const uint8_t vendor_lttpr_write_data_adicora_eq2[4] = {0x1, 0x55, 0x63, 0x01};
 	const uint8_t vendor_lttpr_write_data_adicora_eq3[4] = {0x1, 0x55, 0x63, 0x68};
+	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
-	uint32_t pre_disable_intercept_delay_ms = 0;
+
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
@@ -607,10 +607,6 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
-	if (link->local_sink)
-		pre_disable_intercept_delay_ms =
-				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
-
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
@@ -623,10 +619,13 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	if (offset != 0xFF) {
 		vendor_lttpr_write_address +=
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+		if (offset == 2) {
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
 
 		/* Certain display and cable configuration require extra delay */
-		if (offset > 2)
-			pre_disable_intercept_delay_ms = pre_disable_intercept_delay_ms * 2;
+		} else if (offset > 2) {
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
+		}
 	}
 
 	/* Vendor specific: Reset lane settings */
-- 
2.34.1

