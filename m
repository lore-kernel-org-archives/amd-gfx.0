Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AACC77B78
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B082610ED5E;
	Thu, 20 Apr 2023 23:50:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1DA10ED53
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBRbNNOFHPjqFh++wqscID5hRbRkrqOJFinoXWmuI3ARBEH4x4OAMu70/d0mU1z3y60FF4soCjjiLe11/MVKSjfoyx9BS92eflXtCDoHSGkmmp7+kGsxE5WJ881+iJ2vX7qrM6xJk+tJzuHeTHA1TpiWcMhn58ec74GTS9RVqt+sI3qRWs4s1UbauBbmzyXSER06vcIW4/1kgLXeC+wC/GPzS6gEOVDWkB4hqEckk+njbBwhH6Xb3Gh+ZQexWmycLKuFva0L43AJwrVwd/Z8dJRR8/NIOwGauQ7Dj1ibIOuNFJLdWEweGRP0E187efBtVZIYOBdvTRVLkBgwI5rFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh2MyEewqsleS1YMh0SggPfYsNp5oRyfyQcFPlakbIk=;
 b=XjGaz/CnmyYdu/QF9JavvovpSUz2hgUQkilveQQkzhBotYm+6p6IUEurtg248vDEaXucEKQxLfUxWZf0xojUibe7G8HfHEy9XK8/awSlVHJn2T8Cd2BbSOO+N0NMfG8gYOUFzGT1yS9NNXuJpx7T3gK2W68khAayiQ3kPjd1sDA/9Gp7zHud4LOtBt8AYLK1CabZTLx8GjWWeUKe4JmwHavNod3VodbdTGa53rAccxg0iTN96yD9tz5QykfdHHM6Xn1cQB8gWNQccz5WsHUELlHTMF6T+TQxn7We12dvHP8gf1IPRX9Gq9/7dK1tYnszuq81Yycqukl9hL48Mu1xyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh2MyEewqsleS1YMh0SggPfYsNp5oRyfyQcFPlakbIk=;
 b=m0rgUUCJIjuL78Kb226JzZRf5AfnvnD1PURlAK/dZ+HIE9fDDU0we85qbQhNZK2UIhov84SxL7p5ZG+vjcQ3pQ7X0pWayDpPWzvTUot0A28aqu+u9QzQwg7CMg31Y6+Mvl7fiXGiNr4Yw4cnIDxmyXw+lTJn60im7BQNHMUtB9M=
Received: from DS7PR05CA0067.namprd05.prod.outlook.com (2603:10b6:8:57::12) by
 BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:30 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::b1) by DS7PR05CA0067.outlook.office365.com
 (2603:10b6:8:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: add option to use custom backlight caps
Date: Thu, 20 Apr 2023 17:49:42 -0600
Message-ID: <20230420234951.1772270-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: fa47a111-dfba-49e1-200e-08db41fa05be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WVlRN2BUocKCUxmp74RMH0b6hjaSdmTpjYhdiWITEl06GRS1Xr+ymnNcCXPrw6b7OJABhMX10REt+5VeheUxDCgYKmNIlERwCo6uXh7BX1KCMSiEVTM/l8pVYLX0P9aK8WIpTF+rhRbCkc4ZvWRPzPGgbCtnrVupr1IROmWf8QdYwhfR1zZ9xY1p5wUSMwRgVXTh5M6GfiRctnj45HVFEtMN4XPV3flVU5sS7EH6EC4qJ1fbzklRGMvC1MnQ4IAIbp+u4M/KjofaNaDCQZZs+bUnkC76EFuYaADAGjVCws+mddHeRQa8lLIujXqf8XH/iOFmJRf3k41GG3/aapipJhzBjRMh/x50NFa1BjMgFTEeFJDrIOrKVT11ViWHgeMbzPLGQkzHUp+tTJFX0eAwECa0Xk0AkNRH+eX5IS+bXQVuiKWFMnNwuVsaBVJUgr4qVw3tv7WdQjrh0EdwjATQhmu8RCcpmuFrBlxNNLdA6r9i7h3C+f1xuKbi3fyMza77I+40IGFebfjGXNLXG9NDYcPrp6TpPsWlje2SlEVTv2XKKw+qbDOeXw6UCpR53gDYThC23xkxYrc4i90xPW6htLzEnzjTlTK4esb4U/ew21ZU9+c85yUUOHWV2mZo+2McbIcEROKALFgw6m+O9IztSStMx2iaUH5l9OuoQ/HkmES4n+ilNlhaPz17U3PI50Mcw2um6NQxR9GFBI41oiGGSlaA68r2FzhQKZyNpkcac8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(86362001)(36860700001)(336012)(2616005)(426003)(40480700001)(47076005)(36756003)(82740400003)(82310400005)(16526019)(356005)(81166007)(8936002)(8676002)(26005)(186003)(1076003)(41300700001)(6916009)(4326008)(316002)(70586007)(70206006)(2906002)(54906003)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:29.6251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47a111-dfba-49e1-200e-08db41fa05be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Provide option for vendors to specify a custom brightness-to-backlight
conversion profile.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 43 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.h |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 51e76bce92ea..68d95b92df76 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -116,6 +116,27 @@ static const struct abm_parameters * const abm_settings[] = {
 	abm_settings_config2,
 };
 
+const struct dm_bl_data_point custom_backlight_curve0[] = {
+		{2, 14}, {4, 16}, {6, 18}, {8, 21}, {10, 23}, {12, 26}, {14, 29}, {16, 32}, {18, 35},
+		{20, 38}, {22, 41}, {24, 44}, {26, 48}, {28, 52}, {30, 55}, {32, 59}, {34, 62},
+		{36, 67}, {38, 71}, {40, 75}, {42, 80}, {44, 84}, {46, 88}, {48, 93}, {50, 98},
+		{52, 103}, {54, 108}, {56, 113}, {58, 118}, {60, 123}, {62, 129}, {64, 135}, {66, 140},
+		{68, 146}, {70, 152}, {72, 158}, {74, 164}, {76, 171}, {78, 177}, {80, 183}, {82, 190},
+		{84, 197}, {86, 204}, {88, 211}, {90, 218}, {92, 225}, {94, 232}, {96, 240}, {98, 247}};
+
+struct custom_backlight_profile {
+	uint8_t  ac_level_percentage;
+	uint8_t  dc_level_percentage;
+	uint8_t  min_input_signal;
+	uint8_t  max_input_signal;
+	uint8_t  num_data_points;
+	const struct dm_bl_data_point *data_points;
+};
+
+static const struct custom_backlight_profile custom_backlight_profiles[] = {
+		{100, 32, 12, 255, ARRAY_SIZE(custom_backlight_curve0), custom_backlight_curve0},
+};
+
 #define NUM_AMBI_LEVEL    5
 #define NUM_AGGR_LEVEL    4
 #define NUM_POWER_FN_SEGS 8
@@ -944,3 +965,25 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 
 	return true;
 }
+
+bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
+{
+	unsigned int data_points_size;
+
+	if (config_no >= ARRAY_SIZE(custom_backlight_profiles))
+		return false;
+
+	data_points_size = custom_backlight_profiles[config_no].num_data_points
+			* sizeof(custom_backlight_profiles[config_no].data_points[0]);
+
+	caps->size = sizeof(struct dm_acpi_atif_backlight_caps) - sizeof(caps->data_points) + data_points_size;
+	caps->flags = 0;
+	caps->error_code = 0;
+	caps->ac_level_percentage = custom_backlight_profiles[config_no].ac_level_percentage;
+	caps->dc_level_percentage = custom_backlight_profiles[config_no].dc_level_percentage;
+	caps->min_input_signal = custom_backlight_profiles[config_no].min_input_signal;
+	caps->max_input_signal = custom_backlight_profiles[config_no].max_input_signal;
+	caps->num_data_points = custom_backlight_profiles[config_no].num_data_points;
+	memcpy(caps->data_points, custom_backlight_profiles[config_no].data_points, data_points_size);
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 1d3079e56799..ffc924c9991b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -62,4 +62,7 @@ bool mod_power_only_edp(const struct dc_state *context,
 bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 			      struct dc_stream_state *stream,
 			      struct psr_config *config);
+
+bool fill_custom_backlight_caps(unsigned int config_no,
+		struct dm_acpi_atif_backlight_caps *caps);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.39.2

