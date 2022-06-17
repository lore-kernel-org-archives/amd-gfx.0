Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57002C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F3C10F3F7;
	Fri, 17 Jun 2022 19:36:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A913A10F454
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knPeLD9xarneAe9P8mOg+3Q+76fCx1fIk6/mPaYXLzmevhxyuaZ9wV3auHJD4k71g82+H7SLjx65nPNi/ZZy1bmtwuh46Mu7C13qnqks/+dnCdYgLvaWqVRclMl0n+LVokJHzVhemp5+FV32/eTrZkrdWbCszVbfsyMqY5SktFvziSDOv0khGZSZLF8jCmFoMn1RHsIwnOM+CrRpDJMOHDoh8xY9U3kTG4PC4uyAhlWdN4sck8mi3GHOwSgl/2XNXAAVevSpY+zBARJWkzQ6JUk2DgIB8fw0hp7iaz/2snNYEs9VwYw3kl+AZ1RvrCSsbffbZGjX38lnhuSczojc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khEO36kbuQOV8S9+6027VAyI7uisqDyDIdY6ddy0+5s=;
 b=lehuMdF42OxeYa8Lh3G8li8UFgSu+K8vfFYGiKfQ7MsEoVTJn7pnIwiAlCdwyNs9bVHPoi//EuOGTI6x+K+waUsmSsYJRbjSbsSUVdUIy79ioXwHYMoxcTCeauRlKlatvFVr0LjCWCW8h7ckuFCbbI3WZU46vXyeyGht1/HGc/WOw/Mos2tLy3j47CPdjxw4cnCocee3mdSHKKTNq113mXANV+3CIZCwk/OprNf1Elz/jYn0orONkz0IUo3PSo05lxlYQDr6vwCn2q+jKnZ54+anLq9V0+Ktc5WF88SfD0BGF1lp+Kzg1GaFCFt0J3gKDTC6k+2sZVzdV7TNplPOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khEO36kbuQOV8S9+6027VAyI7uisqDyDIdY6ddy0+5s=;
 b=qCyr1LU+U+H2RWGPLtyhQVpRp2um7LrnsqBZcnHfl13OVOhN12Qhxp09Y+55M/8OiafNgKQJO4MDZom5e6hCWtbZib4wLNiXs5j3qVqKeZooouVa00Sh858PyfW1Ada266KIqZrk7//LKOYyNqg4uhp93knjIty5eUKVowXXNVU=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:36:08 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::22) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:08 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/31] drm/amd/display: Update SW state correctly for FCLK
Date: Fri, 17 Jun 2022 15:35:07 -0400
Message-ID: <20220617193512.3471076-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea5d8dd4-e46b-4342-7c25-08da5098a04a
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5407708FFD26708631A69BD398AF9@SJ0PR12MB5407.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqCx4DHoFiGtVpYyQZDN+TUOLtweS3/2ujLHrx4sx87x4Msc6HQTRraEvSwb6wwBzF3PNdC6stpRfLJWbMNLAyCHo1zxwGhxXoJgTIy16kgW3QY1RRXS5Bu2c5rCPe2eHqa486N45YSyfmW0Qj2AnBq59wgHZT49ENetaNX8MhTjkRWZpH2iRWjCh3TG/H/vexSgbKPJcNruLeKiVk+2LszGk/VF1ZA4eQNJqarhmkTt9ttgUEw+zRj/Dt80a8KH3+42LYHGNS+TWwH9fgYW4BxheXEDHt1NB/hCjMHK0MxpHdQ05BKagkXnCjSEwv0roCOM07+GiEi+MM8V//I13+pgDgmBf7N0lyRcJEh+KTy9jZAek1WBqDAzgbZFtqn+JPRb3eG+OxtFW4MvQ77p1xUpgel1a62TgIQfEq/qMJhVBITOYs24PPlG242c74WysTYOeetauohZzBXJl6F+6dA1t8KWXHQIVxhHjBB9whguG/M2BCzNcgYvRhRyN5S6+T/EwBrbPHFYss25wv2aHzj/U/MAFJayBWAZadsy6JAB/NOG7tg/wjptbFoUu8nU3M4u765SlDeLW0+Q5Cg8T7l1OBQ3p+Ufr/+Mk4S0y8qCQpkvDskHl7et/OnP+4RhdvstwmdiEXtYk2NDj2vU1AHuiZjTnAUVpDeS4B5GYPnHaIuQoL8qqhj2WzA5z5Ywn3xBai91+ieFPGuIc9jR9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(70586007)(36756003)(8676002)(40460700003)(70206006)(4326008)(16526019)(81166007)(336012)(356005)(316002)(54906003)(36860700001)(86362001)(82310400005)(8936002)(7696005)(5660300002)(6916009)(26005)(2616005)(426003)(1076003)(83380400001)(2906002)(47076005)(498600001)(15650500001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:08.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5d8dd4-e46b-4342-7c25-08da5098a04a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

FCLK not supported for DCN321, but still need to update the software
state accordingly to prevent unneeded full updates in driver

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8ece88ddfb5b..90ba9576a6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -431,12 +431,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 		}
 
-		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
-				should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support) &&
+				clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21) {
 			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
 			/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
-			if (!clk_mgr_base->clks.fclk_p_state_change_support) {
+			if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && !clk_mgr_base->clks.fclk_p_state_change_support) {
 				/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
 				dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
 			}
-- 
2.25.1

