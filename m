Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F177EEE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B557910E213;
	Thu, 14 Sep 2023 02:01:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390FB10E210
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhTYdJpNImnn+K/8RSMqjbIDz4J4RF3UEDs2HwoCiLsxI9hOpfbv7c0bWFdPmtr2xrhSv0s12H5kvgqX7YIj+cPG0/B1UgIy+urGoFSIA+AVp772VKrh4J4gZMeqRS5g6w0JJdTv3agLvIJRewUUvilmnu7a6uuSVSVGN8l5DKOc1TYNyKBmChepFQwQbYoUuHfMnLl5tOJBamwPwl/pumJL8EST3Pcblw6MqD0dNeDP6sP7+9+qTa1+Ee7Q6lcl44XDHoDLGFaHpszeDatLMYJ25ZJV9b3PNoF8t/2rXaFPUt5Spn4TqewFFQb4TvjFM+d84NgKj9n72o7OWhJMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5KWVECgorDMIvjLrNzocYTUf93qCV8Cq1MRN7/cghw=;
 b=UNgzxoLndclc4MKRpQHQ/g2lr21aWGJ3lRTTqrkKBresYyXnmFtqDY7LI2u7J1I74nNjo7zUJkNPWqmdVurkUGSCG9GuZJKPVgjVa6U2BIUnB9waopImAYLeWkCYrYO8wjTGj5m0+KoBASbiBQ9jnw50m/9QTz6JSRLxC724Gb5Aj1DQNAnhe870YN6MqZ4n1guJNujo9YiAlNiDtT2EB2fiWELsZTE+z0VVud5SK4ElCGuwyJwZGXk+ysGzuwASIsqtBHClnwJjQSy6e3gCnqGxydkJnabkqsp+844RpQGTXNVljYZ3gtaHJ0/Yh8U7amEn22MlCIxj1Mevp0tWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5KWVECgorDMIvjLrNzocYTUf93qCV8Cq1MRN7/cghw=;
 b=rfjOpRdW3tnECYPpXdSaURNOEhP9A3xc/tGbn4sdoQVJB+6fi59qijAbySpffPUvXZQ08hIf3VWzJjXaYqOC4R/c/2dNfC1LSSp3l0Mt1Qzcq4g37dqFdgMOOyXacgvu+9tASVd5sIZX/5EvX3QwrSTRt3aZq5zC5Dtxi3zevRA=
Received: from BY5PR17CA0010.namprd17.prod.outlook.com (2603:10b6:a03:1b8::23)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 02:01:23 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::b5) by BY5PR17CA0010.outlook.office365.com
 (2603:10b6:a03:1b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/28] drm/amd/display: Temporarily disable clock gating
Date: Wed, 13 Sep 2023 19:59:56 -0600
Message-ID: <20230914020021.2890026-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b7aa2d-d077-4be4-5061-08dbb4c67ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZKF91jwEeXcKrmL5R+4pz7eObPjrB3y8Q6SSE3Dc6zfGUs0uu0KFnoW6vVza2F7W5zB43BmntsI4i8snoB9Ps9d2Ch0EOfagfYhqTWKUZsjdbsRNbpDJo33dcZBl5v5v4srfH5WkzwByWXsBg8lbFgGddV82Cji0XCzwkPIrqhe3NPjh4gzYsXnHLofMyGCZ17LNMTAKO+B7fVXt0iCCa+bSw+bBBNzBklF3fyusUhqXa4+jkCkgVCqGKABLr9Stn1EgnSVLbU52ghreaMijvb6o7UaY3lwRL6VwWheXnv1mTzC+H8iEzR0dDP8o7ym8dCDx76gKbWKX0/nq12Jf29jocJVWbY4G08G2xgaXBMks2Qly+QjH1XHsrqbuzNj93JEUOf694TQhqUcdgQf1obkTbwVwryFBwxJyLTPyMYy9+/ojWKVM4yD/R+5Pz77g/U9mK+oswrwXRiszmnL6mxjXawm233aFB0XD5afjDeSNw69J6a9ZPzfnpzL5OOLr5eDfDZR2+8L/U31kjDzK+GoflDf40oyAVe8/fI76zIWzPHFPcDkd7jvBEXEGAK0WZyN3hAoOopVH7LMaf4aUzzyYNZuL7RrUYUQFyUz/tJxOVG2HIlj03lODbW4JJ6ulyKbFRiOFpLc3+rL81jN2ciGp3Y9peM5NKBETda0RPyqjKhv8Y+Aw5nbZQFWTVevnO5qtR7KsC0u4rn3b2g2UGE+ysI+oU44/7nMkzHFRC4zFItmXPF09QECbtvN67EL3T9miMs+rEnDz/VQ0fuh/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(6666004)(81166007)(16526019)(26005)(478600001)(1076003)(356005)(36860700001)(70586007)(54906003)(70206006)(83380400001)(426003)(2616005)(336012)(41300700001)(316002)(8936002)(8676002)(6916009)(40460700003)(36756003)(2906002)(86362001)(5660300002)(4326008)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:22.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b7aa2d-d077-4be4-5061-08dbb4c67ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Leo Chen <sanchuan.chen@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Temporarily disable dchubbub clock gating, registers:
.DISPCLK_R_DCHUBBUB_GATE_DIS
.DCFCLK_R_DCHUBBUB_GATE_DIS

need to follow up with sequence issue.

Reviewed-by: Leo Chen <sanchuan.chen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index bba747667a73..957f39e1381b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -685,6 +685,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
+	.disable_clock_gate = true,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
-- 
2.40.1

