Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1296C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1304010E781;
	Fri, 18 Nov 2022 16:59:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388F210E77D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQg9LEri9nXSsesFUS+SPw2Fl5sg9EuLg+brJD/DT/kVDfk+ilUDOljXI7fF1+2t4bXSpphwmAUB5Oqf+5sihVGjW10ZD25FJ0oVbphe455v+PBh+mtP0hSLTejt7raDgMwcUThqWa/nyDORHRBWPR488IdnVsuvZ1L3MimA5EMAZyf9sRofMKRcJ/3wIBM1RjGUi198ZA9nGXjZ0rSH5rlM+JOECTRRhhltr9h7q6XKY/AU+B0WePxo0Cg3riVnplKC4p51F7etK3KysuskZnxh9npULO8cdgfay40qUbSZwhfCrI+V6tyMBJ/kcuVRxg5rvJr8gYFiZnCeCMqGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDd9ZodcuQV6Bjl6+UGnDF4P8McT9GazMbM/TGvL0mg=;
 b=MGqwkkWh0lKRo1R8wuisjaJkCB39UDjA/Lwan42/zm4pLdZlp04+M48JAtUZegOQjC9uVoNJR6XOUR55HjPEs4TZ7YPUD8uGwEkP7ZS+nqV2sMenWqWuTz4N7FCI33mZ71esZZpeNSS76EVCE/YZs6hTZdtGQBwK/5mUZXOTkRzfJ0tlyPalKVXFYNHtXNCzb3sUUoCFJv5WwzFSOFwlbDh77annr7Q0fCmB8LnScnxARt16WBot5kZZlLZ9AL0BrPosVyDhTaHVZ8LNInzvibr+aEPhj2InDFt+rdLng4OCLefitdJaEPI6I/hjOewHHa9AhiYu3jY3gQduf0HneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDd9ZodcuQV6Bjl6+UGnDF4P8McT9GazMbM/TGvL0mg=;
 b=XCbTVtQHpxbULllV86xYOCAlkjeuVKernwCJHtJiPP61jyycZ5kzsswyIQtPsrthjO5oeauUvF25z0E+BxwQOpuxKFD3asr+pjaDRUwQBpVE55IldvF2yV3RjcTUK9xJnfnLcVajdGZh85sIg2xb+g8+NNNRdFDZe4wG73jj9sk=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 16:59:18 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::56) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:17 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:13
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: new ABM config 2
Date: Fri, 18 Nov 2022 20:59:14 +0800
Message-ID: <20221118125935.4013669-2-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: cd79f0b3-d6b5-4945-d391-08dac9863b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j8U/u/J4lTpk0WhDRxLXQbeJ1dQkM1LHu71rXrn3mHVokYcixRFJVccnV0KTf2jWENxizMBV3B8pj8RJ7swyndkB5X6QvQshRJj4kmB6m9wK6y/FpCbALaZ0A6uSwABhZ0KxS3KU74S+UXz2LJX3HBPLKfvmsMLSve/CddLwp/Oc/mJXCXVG+5M0le9FGsWHXTeSveQT0dydfjOhC/yGKxL57fpr7p7denyXMBpj/Hb76TKPgInGs/mI6YUYpOrYrB5kH6z4m45Nc4l8tJym1yXiBztwmFhPjNvmQTFBgh3uqEuOUApJP+HQwu3Gb9pE63KgoXAahB09WdNMrU0p873NSne7FTVMb376Ly1lhB8biuskJ1EIX9JIrXwIAOopMyPKzrzMLl0+fdqUTmsTs9oX0/MbTvuJII4V/kx91u6/v/My+iY1Z7XgO4mH7w7BkgKB7DTMWhPcM4bxcGTM+9bCqmCzar5P/PNT7VvT69+wIA0bRsLCY+BLQNIYR9a90aGa14draLQLlHZ/mHJOHicuOWiyrLl/BnlSXZAWLEORE6HZmtXbC1OuW1QOiBz+hg6FifTZZ5+t+Y9mJH3O+kD18N8cs0/JxJazBAUIvph0ZSlcTfka0+VwctNyuGnyrej1/kzzM+mHBiK2n3Ebds/9eM590gfbEPL/w34bDcodZjNHPdt6pvlSDgmdCAzufz3vrs/pXw92R0LMWEIiozaI+JBTB1oL+FBDJd2exVx/lZ7xMsjhmdzloHJQogw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(26005)(36860700001)(54906003)(6916009)(316002)(8936002)(186003)(2616005)(36756003)(336012)(1076003)(356005)(8676002)(70206006)(4326008)(70586007)(5660300002)(41300700001)(81166007)(40480700001)(47076005)(426003)(86362001)(82740400003)(478600001)(82310400005)(40460700003)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:18.0484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd79f0b3-d6b5-4945-d391-08dac9863b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Camille Cho <Camille.Cho@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Camille Cho <Camille.Cho@amd.com>

[Why & How]
Add configuration 2 for ABM 2.3/2.4 to suit customer preferences, which
is to lower the brightness curves in 80%-100% range compared to the
existing default config 0.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Camille Cho <Camille.Cho@amd.com>
---
 .../gpu/drm/amd/display/modules/power/power_helpers.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 235259d6c5a1..9b5d9b2c9a6a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -102,9 +102,18 @@ static const struct abm_parameters abm_settings_config1[abm_defines_max_level] =
 	{0x82,   0x4d,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
 };
 
+static const struct abm_parameters abm_settings_config2[abm_defines_max_level] = {
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
+	{0xf0,   0xbf,    0x20,       0x00,     0x88,        0x99,     0xb3, 0x40,     0xe0,    0x0000,  0xcccc},
+	{0xd8,   0x85,    0x20,       0x00,     0x70,        0x90,     0xa8, 0x40,     0xc8,    0x0700,  0xb333},
+	{0xb8,   0x58,    0x20,       0x00,     0x64,        0x88,     0x78, 0x70,     0xa0,    0x7000,  0x9999},
+	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,    0xc333,  0xb333},
+};
+
 static const struct abm_parameters * const abm_settings[] = {
 	abm_settings_config0,
 	abm_settings_config1,
+	abm_settings_config2,
 };
 
 #define NUM_AMBI_LEVEL    5
-- 
2.25.1

