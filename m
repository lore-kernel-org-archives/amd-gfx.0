Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34B6C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2831310F10A;
	Fri,  8 Apr 2022 17:27:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FE110F10A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmns1JV7+bfvIm7ImI5inSnPfyloT4DZA4wxSCkxKSfel710Vsf4dsx2FsV2oZqjkSQXV8/HjfS5S643/4ME8YZd1ip3s29H1MuuPf3On6y8Zz0BwDDbaGqa6F9qbq7ImemhqFVAAMBoJvo2WdADrTbxQsQl/UzJd0kccU0auIXSjBFT/VTz6dAIltbEtqe7tnUAO/iT9Fzc21DEdWIBP8ooIaTBh9zPx45NIHaY41O2JFN8HaHYUjIxNIYai2oYiwnKOEIyPk+v6mvDq2LqSpaX/n+cKWFXXOzh/dP7kdC+oAH8nz6KeUb6letpOGt0Q2eBX7FUA5qEX4mv7ZqpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg0o+C3AAWW4N2kVht56+Kcpn7KM40oC3Li79vtypyo=;
 b=OQbRYjKxMTyTBhXPFf2g2YAK9IiL/TjhA5V1pVqFKFqmSjrL+vzziq4tvf93gsQ15hfF4d/hG7JUdjdPvig5wioaTXseOQbHeVbjNHNGWkEZP9n5/+kza/arDcP3i6soagbomwunZ4svO6OsHuEj5E7bdmCUMTlhS6qL14q5aJtZ2/JbW3r2GVksCS42KBz0cabzYGTasnLB7YIJUWlK2RGjTzLvLnoZtRK05qOleL3HPuo8Gh1COXlS7E1GsbpdGVpYCst9CZbZmBBhysTWXxWAbogUZztLtJYN3uHj+cNbLTJCbk2iuEMy7ZlevlEgq+7cjv+zLWNAZOz3v932uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg0o+C3AAWW4N2kVht56+Kcpn7KM40oC3Li79vtypyo=;
 b=0nMVQ2gWw6jgAr2NrxGOdxRI6+6Xydw5jLJSb5EcivHJOxsYyBYyrkz7tC9azZfi/ygWxHubiCPepmMjDlisaBG8JauvwnaqljrqJpQm4Hs23Me/J3k9S5Bf0FkSyvLTTNJ0LVTp0T3RJAxzDKHomUgt08a+P2pknu3sfwpwWb8=
Received: from DM6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:5:100::42)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 17:27:42 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::58) by DM6PR03CA0065.outlook.office365.com
 (2603:10b6:5:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:41 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:40 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/20] drm/amd/display: Always update DPPCLK_DTO when clock
 increase
Date: Fri, 8 Apr 2022 13:19:02 -0400
Message-ID: <20220408171911.601615-12-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d23db8-aa48-4364-e3d6-08da19851610
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB158675A7C4B913401AFE3320FCE99@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fDcqWBcDfdCOUYmi2673PH+bi4zfvgeoXsVsL60nKlJbMykCYYXf+6zwpS9EGGFZBLFyUC1fDieH6AWL7HnPdnofC+qNrH9BBTsVHMzkuoTQktxqzzPYMPiL2+J/LdLMfZ51odTXyXjAPTUrvUCEbeplOmHD5mehq29sLeTRg/v8BOFeYdKP4GcvUYQn7OELcwVtV85TulfA1qfKDyPbyR6XHDRGDHHwp5Dh1dx8AY5Mpx2A8pjwwWniEoaVYJeNk8N28iEW29FM4of0wnFq9NA5M4II7UX2i++kEYm+tgUr4g+3gPv68czu6tFVfTm7q9d5Sqr1evkJj7VdExqOLVqqQrvNJ2WGWymTXqVIYDtJ0mgWP27rQXQWWpr0ytJMvAY7FBCV8qTmFqNI2LIkDHmp6hc90yp33s6AQWvswEtdwr5O9H+Eijkb/nRLyj1CFTg9pRL4m/V7BKUuSasPg7mS2NIOhVjFScdE2P3+51qEGeUqKfTe54DjU98HMcY3B2ZMPJ6ZVtLKfG4bLmmqsJlmXMJCee1425yx+0OvXtvjJz5grHwf0JyZlJlMilI2ii2w+HJgHSlgTakPTR8hFvDlefeZruf1Jd29etnI9g+oFBgYZ9GiGScfrfaeGMN+QZsMstVodI+82JGeY8T+JQptwPcsnqbMDiBpWyRlc9Rfy1CKfBejd6UUHxUVVemvSZj6jB5j9fyelK/W6YQmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(356005)(6916009)(40460700003)(508600001)(316002)(47076005)(426003)(186003)(83380400001)(7696005)(81166007)(36860700001)(54906003)(36756003)(86362001)(82310400005)(26005)(336012)(70586007)(70206006)(16526019)(2616005)(15650500001)(2906002)(1076003)(8936002)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:41.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d23db8-aa48-4364-e3d6-08da19851610
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Need to update the update_clock sequence to a fully tested sequence for
dcn30

[how]
Removed the check to see if clock is lowered

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c | 3 +--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index fbdd0a92d146..451e8d6cd8bd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -157,8 +157,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 		} else {
 			if (update_dppclk || update_dispclk)
 				dcn20_update_clocks_update_dentist(clk_mgr, context);
-			if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-				dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index bc4ddc36fe58..f310b0d25a07 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -176,8 +176,7 @@ static void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (update_dppclk || update_dispclk)
 			dcn301_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 		// always update dtos unless clock is lowered and not safe to lower
-		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
 }
 
-- 
2.32.0

