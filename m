Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73861C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B9E23B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B9E23B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30D7899D6;
	Fri, 18 Dec 2020 22:30:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A627989A76
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+eGUvoPLnBul3Mx4CqDAgXdUsoOZIvgEtGA+73Ac15JZ0vqHUDF3JSlHjirWLh2WB6f9jArNdarb1ckvv2XEXcAnGBa5Kwbw7XacibaJ1tJIAAfRs89m848bfI11Rx1EKUsKUy5oKIaOV+VDWc0CZ3CNeGYrumkO0NDteybGftrz8W6NaBtzc7AYBIkku8/41Umw4G4oZMgyb19QTc4uaR9gW/tBRz3d7yp8qW6sZVSeKmT/VaPjm9w9/2Lf0zu5cSbmRwQMYWOxPBE5/dM4HbsSQEQwYp3x+s0591dM50X7UfBASWEaXucHZUneRO1GCc9wGE0S2P+I1RlCeIRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGFuGxNaL1ddI9Rt74jyk5JFZCgFWrCHz8Zbi9wnads=;
 b=O9jTbcudG/gpVHi7nVMSOdzjQVvARbYeCUxAnFjbyYPhlZQz6DaUiPbv9jxIDtQIXn2PgSHhouPLMSDcI9jfxffvjwtq3mTt3m/ShSy+Yt/fV1y3vjzOviV7ddjTFCFYgmfJlNZIt2Ens9/iZlUdWT6FUZP/yDu+e3FIZeSceyqmY5eEVzMe5tTaI/AYzWYaI9oP/3YG0qzK5CcGUydth1SLD7ma44pDjtUToXi/EwGDIH18Gsz3u0fXYz3L+AOsGk99g79Tg2Rp/PUpBDzG4WcdepO9WVII7Aag3K5JP2y/kaTQe5hU1suGl1asUaIViXdJYXBe37L0dI1yNNCXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGFuGxNaL1ddI9Rt74jyk5JFZCgFWrCHz8Zbi9wnads=;
 b=bOE/bu9Dgug1ZI/6PNTXaic4XeybjS316BODPUf7ms4GtIMdl6hcYcHtMKfWTWQjIiJ/0i2/jks70OjZgW1SEgAZewFcwIU4t5IfUBpF4A49bD0Qqo/tfH/+gGFbsZNuVmtB7vnThi9QIx8Jwn8+f9v3uknbxfll6H4g1QF50aU=
Received: from DS7PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:3bb::7) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Fri, 18 Dec 2020 22:29:58 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::bb) by DS7PR03CA0062.outlook.office365.com
 (2603:10b6:5:3bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:54 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:53 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:52 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: gradually ramp ABM intensity
Date: Fri, 18 Dec 2020 17:28:55 -0500
Message-ID: <20201218222904.393785-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03582ada-a209-44d5-8ba0-08d8a3a472b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3083DECD89BBFABF78C3C1FAF5C30@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHQkSM5eH9MRJVdllzDVttzJreLwbsq056fGKTQ6SHR3TrjOZoMOOlYSLvbllcdga6luV26CS5xI9uG5dprvGLyY4FCeG/Xv0PRZ+wYCuZxEo/JwMGUhvFCwMGorVOVCcKl6/PB7d2QU/ssMwC6BP1y9GlaKd5BFDDZ3P4/K8UdYHLsbVGhrF3YTe6UWjJBR8497EqEf8MD7xLrxybiGTLlNKpb12gUaAmIvk/fP13LJrxJ+zJBXvDdbYDPfnbP/5LDdO2937s3q6025Y/etJHXOqrXqPsp4VwquHULgeOWagaBlTLQX2DC/HzBPXAWnPkqlE1l04vnqFcT6v4eXwMccQUEAHMfIiRLCKrB28qbai2DK/8Lyd+Xegaxju85SZLjs6ylwj7BCsKnjvkONilJ2Xwbc+3Kwdr2A1RxbZrwK4zNuWjTIJ5QUtJiVy4lQiKjIGrA37jWYN49SLCyr7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966005)(83380400001)(4326008)(316002)(2616005)(47076004)(70586007)(5660300002)(82740400003)(26005)(186003)(54906003)(336012)(8676002)(70206006)(36756003)(6916009)(86362001)(478600001)(82310400003)(426003)(81166007)(7696005)(8936002)(1076003)(356005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:56.6682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03582ada-a209-44d5-8ba0-08d8a3a472b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Rizvi <syerizvi@amd.com>,
 Aurabindo.Pillai@amd.com, Rizvi <SyedSaaem.Rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rizvi <syerizvi@amd.com>

[Why]
Need driver to pass values of backlight ramp start and ramp reduction so
that intensity can be ramped down appropriately.

[How]
Using abm_parameters structure to get these values from driver.

Signed-off-by: Rizvi <SyedSaaem.Rizvi@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 35 +++++++++++++------
 .../amd/display/modules/power/power_helpers.h |  1 +
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index cc983f662157..4fd8bce95d84 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -82,22 +82,24 @@ struct abm_parameters {
 	unsigned char deviation_gain;
 	unsigned char min_knee;
 	unsigned char max_knee;
+	unsigned short blRampReduction;
+	unsigned short blRampStart;
 };
 
 static const struct abm_parameters abm_settings_config0[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  brightness_gain  contrast  deviation  min_knee  max_knee
-	{0xff,   0xbf,    0x20,       0x00,     0xff,            0x99,     0xb3,      0x40,     0xe0},
-	{0xde,   0x85,    0x20,       0x00,     0xff,            0x90,     0xa8,      0x40,     0xdf},
-	{0xb0,   0x50,    0x20,       0x00,     0xc0,            0x88,     0x78,      0x70,     0xa0},
-	{0x82,   0x40,    0x20,       0x00,     0x00,            0xff,     0xb3,      0x70,     0x70},
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blStart  blRed
+	{0xff,   0xbf,    0x20,   0x00,     0xff,        0x99,     0xb3, 0x40,     0xe0,     0xCCCC,  0xCCCC},
+	{0xde,   0x85,    0x20,   0x00,     0xff,        0x90,     0xa8, 0x40,     0xdf,     0xCCCC,  0xCCCC},
+	{0xb0,   0x50,    0x20,   0x00,     0xc0,        0x88,     0x78, 0x70,     0xa0,     0xCCCC,  0xCCCC},
+	{0x82,   0x40,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
 };
 
 static const struct abm_parameters abm_settings_config1[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  brightness_gain  contrast  deviation  min_knee  max_knee
-	{0xf0,   0xd9,    0x20,       0x00,     0x00,            0xff,     0xb3,      0x70,     0x70},
-	{0xcd,   0xa5,    0x20,       0x00,     0x00,            0xff,     0xb3,      0x70,     0x70},
-	{0x99,   0x65,    0x20,       0x00,     0x00,            0xff,     0xb3,      0x70,     0x70},
-	{0x82,   0x4d,    0x20,       0x00,     0x00,            0xff,     0xb3,      0x70,     0x70},
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blStart  blRed
+	{0xf0,   0xd9,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
+	{0xcd,   0xa5,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
+	{0x99,   0x65,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
+	{0x82,   0x4d,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
 };
 
 static const struct abm_parameters * const abm_settings[] = {
@@ -662,6 +664,7 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 {
 	struct iram_table_v_2_2 ram_table;
 	struct abm_config_table config;
+	unsigned int set = params.set;
 	bool result = false;
 	uint32_t i, j = 0;
 
@@ -710,6 +713,18 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		config.max_knee[i] = ram_table.max_knee[i];
 	}
 
+	if (params.backlight_ramping_override) {
+		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+			config.blRampReduction[i] = params.backlight_ramping_reduction;
+			config.blRampStart[i] = params.backlight_ramping_start;
+			}
+		} else {
+			for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+				config.blRampReduction[i] = abm_settings[set][i].blRampReduction;
+				config.blRampStart[i] = abm_settings[set][i].blRampStart;
+				}
+			}
+
 	config.min_abm_backlight = ram_table.min_abm_backlight;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index fa4728d88092..6f2eecce6baa 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -39,6 +39,7 @@ enum abm_defines {
 struct dmcu_iram_parameters {
 	unsigned int *backlight_lut_array;
 	unsigned int backlight_lut_array_size;
+	bool backlight_ramping_override;
 	unsigned int backlight_ramping_reduction;
 	unsigned int backlight_ramping_start;
 	unsigned int min_abm_backlight;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
