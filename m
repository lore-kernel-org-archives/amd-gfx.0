Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70665ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0048910EB46;
	Sat, 27 Aug 2022 02:27:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE0310EB43
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHBkvRaO3jy2UqlhgkKRhcfq2LwOAr1IFvL3sAa0tgvSm6nz/S2Z3ZG0H926HUr9vzdElHRdxqL/G1RtQh4cCdsxr0MfLTdwHB82ZVVU1n1xYjO3Y1yd9nlY6s3Bbu5lvhqC9xb4na5VHC6zHdHENYSulBEFTmdr//8VkwL+abg/1FgIGmfGY2tNoGXqNeANJB44Qyg369MmTTXj5/Q3l1N7WeWx8pKjbfxZOFqLn0VAlPZjY801YYgZBpxbbOz9z0k6XEUjcKajaJVj3MIUd9AwEs7gdgMTVKquRsf03Fw5R/Z0CGgj93Q0kr7iM8e2YSl7wNbWY00nTtW76MoJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO5SV1DgCDgr+6OJQ99v3z4Cc1p/CdOQ6xMOWDAQZpw=;
 b=QLuz1soty/0NU+waGZyn7k6JKVyI+FXG+JgR++nbuAjCR57hUUKzJATNXriFxM6Hg7APPPDi+OkUa+0dnGR625msdL5yXIg5hJa2eI71qmFsgi3/5p1PIydhKQuzL31pLgWRDJPML6R3EGF7rwZFQhsv7hGkSuGlXnd6BN5H6r89Rw7rjYUxcEn3PzdoGuDkJDywAGyciDp4UkzdxNjDIB/mM4W796JHNc8RKoQtHaH7TB4s8wxVylgagtV3vnhQUjg1Gp47gdaR96f+k+M61o9GbZk5XjUth0oWDo8R6KmzaWoOnRuwuyX4XcjoRU/3YryZTXPWTyH3YwcEsIWN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO5SV1DgCDgr+6OJQ99v3z4Cc1p/CdOQ6xMOWDAQZpw=;
 b=DIjM7HXPbASxjlOke/R8QqF/YxWHo1uT2/tUeDUxplf3gNxDroOaZgrOisDQD7AropX9FfIooXy4lnSktWSul+lITGKTI5caiDjd1Ds29WW3YoJwQ1pwcs50bCTizoZy5p49IEUK/4gRD16zJCHVtXa25SHNl9Ny23LW52V9J0A=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BN7PR12MB2785.namprd12.prod.outlook.com (2603:10b6:408:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:26:59 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::33) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:26:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:57 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:53
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Fix OTG H timing reset for dcn314
Date: Sat, 27 Aug 2022 06:26:54 +0800
Message-ID: <20220826222722.1428063-6-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e358f19-d7cb-4829-9aa2-08da87d39e63
X-MS-TrafficTypeDiagnostic: BN7PR12MB2785:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FICwYMJHWJ1l8OKLN3efQ1cxGwVIBJhK2eP280IWxqtdPdV3P/NZkX6TBsLYtWFigDCTsOwTtT3nSBih683hhbqVqqBAfc3kHTafxqEvs3GSWhcvfry0NbDMvq6YlgRPNrV4S2o80UX92HcTao+88YrADkIoxwsBdkXauRzQaltjB7nK532ewYVBdoJ5d8l2DLkn3M9BjnVyRpFmE+OADjJTmYgOWZCUyqZWsw1tp7wR0CP1IV7rB1HVtmLrpDacfvIp1Pp4RoxOuB9NQxcZli8uxllJ04EgEtJfT2khzSJeAb5yK1VkkX50tSUmBmjRdtELyK4gzbWmam4UQjg0IDc3RsegWPsh1tPhPPlRshz/Br2ljHiMUmEYVg44eAUhE5LixtFc3V3233PXkA5u5YA0txOEdOGMfljRg4Mch1+/BkjZIUCZWLlpd2W5Xu7aO+fyyfFn9EvNs9Y9eam9p8A31Ele1HR80o6zF5Z5L+fYxDTgCq9VZV0kpczARFAqkNSqMn4F0ImbH+lBsx2vDoM2+ywTQ1FGOHACtArrLNdLOtxnUUzk2YXqpuxh7crMjEzVvAZUcjfwXAnHwMphkQ7pYPPf8U6fRgwz1zg1jM1HiLkVKr1vRrfJVYEFM31QXZ95ic07hBZdZG2NehyiJLyAEoZDhnKQpTh/9UGOdRHdwYpTwPdaO43oDgy1BFDwPjuSbXU3VIYkTEeXpajKp4aV3Bp1JEO4O/XUysTMZ8iQHtFxBHhxH2z6ld9x/WZI04sJXyyy3HP+yEkx80eyjSZ+9zgBMC1lhmlryptvVGL33dvWRv84imcy6dNpH+58vBzMI+JoWcvWg61hNuFW4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(478600001)(41300700001)(426003)(7696005)(83380400001)(47076005)(26005)(5660300002)(186003)(1076003)(336012)(2906002)(2616005)(8936002)(6916009)(40460700003)(40480700001)(54906003)(316002)(82310400005)(8676002)(4326008)(36756003)(82740400003)(70206006)(70586007)(356005)(86362001)(81166007)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:58.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e358f19-d7cb-4829-9aa2-08da87d39e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2785
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
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
When ODM is enabled, H timing control register reset
to 0. Div mode manual field get overwritten causing
no display on certain modes for dcn314.

[How]
Use REG_UPDATE instead of REG_SET to set div_mode
field.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 0c7980266b85..38aa28ec6b13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -98,7 +98,8 @@ static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id,
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
 			OPTC_SEGMENT_WIDTH, mpcc_hactive);
 
-	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
+	REG_UPDATE(OTG_H_TIMING_CNTL,
+			OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
 	optc1->opp_count = opp_cnt;
 }
 
-- 
2.25.1

