Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE69C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74F761263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74F761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E266ED87;
	Thu, 10 Jun 2021 16:29:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581476ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw2ylrsAWk/um/TJcLJN6C09B1S04JEmmwstxJuvdZcgh7zTo5XA9eJDPNsEqvaFaga8EC/8zNvjWIYECvzV9aYQLWZrs5V1oCMPeKVyOkjHNQneLnc/24f1v908tNMP+JLXwq1XTQm/SRK5TQRL+b8p59elDZS27txofPitHT/d5+bdqghxVbKJvewiKfeX72t6tdeXdYoSV3x6xbvnme7AfKdnHoGzlsHlk/zk8ELnaI45fK42pDXafpVMVg7nslxxosYJTTRphbvRKECgBQ/Gmfu8rPxof2DvRzEgKDsde34oO41ZidVENpb09PTJan94vF3oIM8f1x89QplrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6dvA/8fp2hVyYRuS9uAYNsdM11TYaf8HZCji050EW0=;
 b=Xf9hzyRsMEgkj4NDyMA496G9cC4kh7ilKYN1wEUXkYIuM3AM7EHe0qoJZlPm0KFSVdQcDdCL9OBbirwxQ5bD40ozc0Bg3URWCZ2qsaXuRs8GUrb//W85ak1fvx4kThRenNKSzDdXfhAizbjFpgcdTrBcc+idisUkFCK2F0q/ul5ceRRzsAtR7wpCVkSomQAJCj2Pip4KCcOQG0EOEUCbqRJ8rWabvSqdV7szbr8PC0aT4lnbzGFwXd9Lo+S5PpA7LeMbuYvk+WvdcoONeug82t0u5NfSwEcDNfUmuSLgF1pep97w3zKGVbevUTgjOwHuQj3ZmWrkzkDYt0lClRYUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6dvA/8fp2hVyYRuS9uAYNsdM11TYaf8HZCji050EW0=;
 b=yyXmLVN8d6KCuFqwfe+q3a9yTaeKO5jDyn8hekVsZYjAuh7kn1MVOGmtcC5UmnDJez733tY0JQao95vtLmedt1Pqcm4i6WYmWku/erru1WH97dcImF3HNtzhFl52CoQtyV+QgmeKo61griooJ6pOGMKqkxmv6hGxBc0m5GE34WQ=
Received: from MWHPR22CA0029.namprd22.prod.outlook.com (2603:10b6:300:69::15)
 by BN6PR12MB1889.namprd12.prod.outlook.com (2603:10b6:404:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:14 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::69) by MWHPR22CA0029.outlook.office365.com
 (2603:10b6:300:69::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:11 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:10 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/24] drm/amd/display: tune backlight ramping profiles
Date: Thu, 10 Jun 2021 12:28:18 -0400
Message-ID: <20210610162838.287723-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d9ffd95-1fe7-4689-0521-08d92c2ce1c7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18896528259FE7BF0F15A2B8EB359@BN6PR12MB1889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BArPV4j81yZfH3dUxO3QeIQ3pHJqnTaeMbmLppFF3EmhAzReWTFTJw6ru3ei12NzGPpWrYKBihyBTrn7Jbj3HUWZiegMuDA2dHuJAJijkLNQnHfylOtpS3gt+5XzdERFxl7gdXQTuqXGu2wEwYW26F4ZzdGWfeb2HPD30/CjrkELzvmUkmqXIU5l7h4hNLF4mKwoHFjzN6uKc2eOwWqnjTB/eEvAHCcbGTO7rnJ9jAX/JIQYPvrEaytjKXMehxZsrPtQF1u9mvoXZ9afJhSe7z5q+i5k+jEHbgvFsZmVtaagH3kfpuetsR4SzfUUBDHzevgPrS4WlvtUHX8nCrmvmzrJQoS9znD/Z8bxvH3R5hUAnFQ85cF1Q3hVgMW7oN/L0XJ5MTL86D16PuZGLJjZYY16299gjp5CciiB6hPzPtKxwHu/WnjSVK5HZv8XjOfkz5kpbOmrdGfVw38ZkAHs+Tfa4S7wfr/cJmPuJ8SWvro6rvAmxFckRCwh8guk38N/RGaXOZkylsMLzLyBgR207gzs7A/39Lcsl+P/K1GTtyU32IR0GLJwR9w9Ee89aKi1J3XxXBvNMkOKYtjg8vfFQyJI24bHE6nsG0ero8IZ26PHU8dN1xXaXbYMcwXnClz6Q2kCuaFvVWEcwJqkre/prMxmviVwTgaDiJiOsCVtC9ewp4rlr1K8VhOjGKDywmYV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(83380400001)(47076005)(186003)(4326008)(26005)(5660300002)(316002)(86362001)(356005)(426003)(6916009)(478600001)(2906002)(82740400003)(8936002)(336012)(7696005)(36756003)(2616005)(70586007)(8676002)(70206006)(81166007)(82310400003)(36860700001)(54906003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:12.6106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9ffd95-1fe7-4689-0521-08d92c2ce1c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Tune backlight ramping profiles for each Vari-Bright level to suit
customer preferences

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 5e7331be1c0d..2b00f334e93d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -87,19 +87,19 @@ struct abm_parameters {
 };
 
 static const struct abm_parameters abm_settings_config0[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blStart  blRed
-	{0xff,   0xbf,    0x20,   0x00,     0xff,        0x99,     0xb3, 0x40,     0xe0,     0xCCCC,  0xCCCC},
-	{0xde,   0x85,    0x20,   0x00,     0xff,        0x90,     0xa8, 0x40,     0xdf,     0xCCCC,  0xCCCC},
-	{0xb0,   0x50,    0x20,   0x00,     0xc0,        0x88,     0x78, 0x70,     0xa0,     0xCCCC,  0xCCCC},
-	{0x82,   0x40,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed    blStart
+	{0xff,   0xbf,    0x20,       0x00,     0xff,        0x99,     0xb3, 0x40,     0xe0,     0xf777,  0xcccc},
+	{0xde,   0x85,    0x20,       0x00,     0xe0,        0x90,     0xa8, 0x40,     0xc8,     0xf777,  0xcccc},
+	{0xb0,   0x50,    0x20,       0x00,     0xc0,        0x88,     0x78, 0x70,     0xa0,     0xeeee,  0x9999},
+	{0x82,   0x40,    0x20,       0x00,     0x00,        0xb8,     0xb3, 0x70,     0x70,     0xe333,  0xb333},
 };
 
 static const struct abm_parameters abm_settings_config1[abm_defines_max_level] = {
-//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blStart  blRed
-	{0xf0,   0xd9,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
-	{0xcd,   0xa5,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
-	{0x99,   0x65,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
-	{0x82,   0x4d,    0x20,   0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xCCCC,  0xCCCC},
+//  min_red  max_red  bright_pos  dark_pos  bright_gain  contrast  dev   min_knee  max_knee  blRed  blStart
+	{0xf0,   0xd9,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0xcd,   0xa5,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0x99,   0x65,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
+	{0x82,   0x4d,    0x20,       0x00,     0x00,        0xff,     0xb3, 0x70,     0x70,     0xcccc,  0xcccc},
 };
 
 static const struct abm_parameters * const abm_settings[] = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
