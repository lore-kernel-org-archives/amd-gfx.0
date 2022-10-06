Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F48C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD7610E8BE;
	Thu,  6 Oct 2022 21:28:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FC010E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRewjSE39pJO+5RGcMbMmJw/fPDFbtlfyymRXe3yZg4TOurwaAUSMoWReSyl2XA5mNys5ERDS79DqSFCK+CGAK9KwBVQr06vN9rE9alN3+njjFc1FS3+zq5AFRP8JWty9TlzN2QhJXdSufnX42wuYcl6HLVFWT230os8QrLelW4zOQQiozgdBzlE2VJTfTrR6K9itk0Cwpm2i6dpzNmKXbSc9B24fgEDWJ2I/Kf5WEyXjGvCm73YNCtUCJaNIoLbnU2MHN/DXk7+ie82dqD+y390erxXV8y0aDpOXa8jUSyiAHmKXmUGE2y3lL+r5PLGxPsr7mEdqA5Xu0QMGL9v8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrp+SOuivmjz+h6YLe7U06taDwbbDzdkH/BsfgY1BrA=;
 b=ewHhL19+weBMhKrx5HZ8Z5Kz66d9Gf622FtE2eKhtms6yyHx5SsWGxZcTR8aKFkH0LjFJC+Fj/6dQfwreCdfp/dZ5ZqiXW0egFuN10+7K81Jb7EZtEZFviRkx4O4tR6uRGwe9MNSGmKPvw0Aa+09POorh6zUZ+V426CWyBgz4ZenkzSqqWMnOpZdwGp41M02mh/fyA4I/X1s2B4/jVTGYoY1+yctCrzC+j+uPNTrLWdFQuvpwJFi5XkBwzf4Y9M7LvNbl9dTQoLHKITUi54gLZoGsRoZjmc+gwN5jiMr0O47lfjqAd7KpcwcfQ1Qtj6pwN1SdpPFwJrH6E5ErXC4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrp+SOuivmjz+h6YLe7U06taDwbbDzdkH/BsfgY1BrA=;
 b=BUZnTVLd0qrlmbCSaSF/k1CO/39CmH54Ys8/z0rnas3KdvSxu7o+n4xBEw6YGQAdUQ8XF2cRO1JM3Az0rKla1/Hp4gHJljrwZnldLhfgtaoS54Sfy92uA5QpijAPrEHlTEn8jfVr13jMBtK64ku38Mm0mLaHPwj2zpc4RRSujX0=
Received: from BN9PR03CA0099.namprd03.prod.outlook.com (2603:10b6:408:fd::14)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.36; Thu, 6 Oct 2022 21:27:44 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::e9) by BN9PR03CA0099.outlook.office365.com
 (2603:10b6:408:fd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:43 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/23] drm/amd/display: Fix bug preventing FCLK Pstate allow
 message being sent
Date: Thu, 6 Oct 2022 17:26:39 -0400
Message-ID: <20221006212650.561923-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f282ee9e-a1ab-4c94-1698-08daa7e19b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yy6DVDpc2U4Z7rT68wrxyiZ6Ud+rnRCJm5c6srL90ljkHD0aaEU3vbzxmpujug5oOUYGcdOZvvvxH82FVyESck4/+7YzEADNH7UHc7q+py+Nr0vMbC2DjPkfowkSLAnY47W9WnRRbrcTFs/jVrXtSrrZLkuyqtzaOC2wiEdgn5NO0NlhZy3siC26mhd+yK6H2BPed7hbMI2iAjKo7/6rLILaWMinKx5i+xV6Em6fskW49CxjxrweG4MTPbg5oDX0M2RSNjEL3Ld/ZxprBH/U3cXGAmWm3UrXY76EsYfTFsllxRaL+HQ/4i716qeADfWEHffkGEtepKtNzqZ0NdpKK174/HdW3rAWTuFM4g/z9cyTPmLEGxmMwvTFUJuIJFpbgiTLHb+NZrgT9WHPFH+UD4vRdIiMSCdq5pisKXTQFFooazVbDoi851iT6eDn4NlACfCVaRagt0n8kizo2mkO2ZDP7Bltm4c056zrPtj3od3AfvO4WFbjRRUsyaWMJKgbM9jQAO0aaySE44xg4hIcsTD7z+4mqSiC7D1TDpYrR/BxbnJAb0ifGpqANThD4u1y2Wv7Hh3KG15vvMUi5V7iNf35DAgjUWUAoMfHCm4ve8LFd+dqxZVxbrCgdc/04kK0y9UweSrDi6pm2Q1MxrjSjh1OEpZLMryyHgnIxR7eHU0TP0EHybIbqzGZunnNAbk3Mw3WoX55Gd1SMYzgV98IX4eA/COgfPYlrKSPze9XtH50E0cl4GJI0jWOgfWuSDoD+fg9rKgjbhGV3DBBWLJnXoUuXUdBdkpOfyRvv8lo+z53e8j+n20i0zvaxzgA5MqO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(40460700003)(70206006)(70586007)(6916009)(82740400003)(4326008)(8676002)(54906003)(44832011)(316002)(81166007)(86362001)(36860700001)(356005)(478600001)(47076005)(426003)(6666004)(26005)(41300700001)(5660300002)(8936002)(2906002)(2616005)(83380400001)(186003)(82310400005)(16526019)(1076003)(336012)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:44.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f282ee9e-a1ab-4c94-1698-08daa7e19b9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why & How]
FCLK pstate allow message should not be
dependent on local "update_fclk".

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 99ae3255dcb9..1c612ccf1944 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -342,8 +342,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
 			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
-			/* To enable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
-			if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
+			/* To enable FCLK P-state switching, send FCLK_PSTATE_SUPPORTED message to PMFW */
+			if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support) {
 				/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
 				dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
 			}
-- 
2.25.1

