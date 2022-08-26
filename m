Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF0ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF9D10EB58;
	Sat, 27 Aug 2022 02:50:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D806110EB54
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMxput1ZxEpbSlPz7sGYSpbLAaF0AwI9yEoTranRD3H0ekzu78Ybuueqq12i6kSlmsX8AfgdmS7P2BZyYTr23kfpbggk5HkQ6RIkU1mc51CtinSJcr1iEIVi2yavf1tQoeJib7CkFyzy/xIO6+VOmusj+dOeutFYHLD1UBFcGYxoum0yVyXDqm3JP+r2jy4mAWsQcgxI98ekyIhT+xh7JWgWF2VAquCcdxIldCz7/EOfmnbPLj1aVTIw7WHp+ShvaLYy5ldzcMMvm6HJQEFqEZ6So9MmPD+wnFOWzpTyZB4qtGrfuIJ/u3uFqWw7LAzS8IYPD/rBaBexfqZybbj9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcAxQFOFIHTBgymU+Q5sD7+j1l8KuenEZki8WEmqREk=;
 b=fKJk9Bytn2nUG8IpjXjH1d3WHj0giR2G6FZ801QPDPdJAqlfBUpUXgN9znIYKy1Jf18QbXCKaZ2gYSni7KsiCtTzOJb4H276c2lICw6vLCpgai9TaYeGooW1p6B2WOJ8rU/gXitUJOwUeFqULKmcXgm/r/czw0hulgHwx10Z28POXJLCtF4bI61abaS9GiSLirnGxut/652vGUdWzjazBO69TIMJx5SlyWyK0G43F65KxDOXHmDpTajAc7lDhtUya0zHYcZps7+YaWbO+SdGT0l09Ik2OKLTLusLFExy+pD+ZvfA7PdbpZLDFQu0RrOsFpD9D3F/0R78I6pABz4yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcAxQFOFIHTBgymU+Q5sD7+j1l8KuenEZki8WEmqREk=;
 b=xoUSmj8HTaFWky2kvCthORWZ+GMmPkFdaoAqCiD5bXQykbADE8IBtf8/B5TvAMVQvGjxeODwt2K5erLPoCd5RELREXjq880qskZiJfKfFpdAISCrjDMBcH58gwicNC2VkbTmBYIYJfjrF0kQYF71q8rDqdkJGgn45+J4gOjHULA=
Received: from DS7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::30) by
 MWHPR12MB1277.namprd12.prod.outlook.com (2603:10b6:300:f::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Sat, 27 Aug 2022 02:50:21 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::ed) by DS7P222CA0002.outlook.office365.com
 (2603:10b6:8:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:50:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:20 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:16
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming
Date: Sat, 27 Aug 2022 06:50:23 +0800
Message-ID: <20220826225053.1435588-4-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3080f6d7-21ff-47fa-7f7a-08da87d6e233
X-MS-TrafficTypeDiagnostic: MWHPR12MB1277:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +llx7PWcqXHPtJO68ga8EEVM0RJY+VIj0qMEbdBXBln/Y4PZJX27WRfhmLvU5SuCWBCjmx01bQEi6Rx0XhyOgziHvTt4xQmnKIeEu/kxALV/dlVe69bDJXWTf7dRC6a2E4ItD7jLVCYntnOw2XexUnCrUnSXHfDI0F69N4iTagzhT2E4WCmFrbN5gZu44azNC4ZW3awcnfcyvK8YL9NJhLTbe+i6ah4wPiswHYAIoWwldDr6Smj7gHTCK+fzXOOsuJom2ZDVKglcmg8CMwhiOo/qm3DCG1S2UfPVNifmjAQ/ZxxZlmAe1Hewlf5LtgHajaO5MhxJM0PDi/7O99qZtVu2MTiWWtOnpXbUEOhm8QGKXxkAv8bS/oh7zD/5oPWhBDRIdeW4H1mB3lggS9HjMssZF8ke5blIRkA2+97UURzM7liBtM2hBLpYttLtxlYZ6aVShxuU85ObQdFqqiC4tum32BNRyH475afKRANLHoEOU157uFqXsXKLUv5AXQwX3e2D2Y78Rlv7PmarikiOWJrMEuZx7HVmmdhCXewwP3rPFdo2sX3jtxge++6bKPUeN9rqWUC13uatrRo/ZOKyLkWGBS8wW09kGrp/D4xirThzY9AcQvnY/5N3n4cr1BmPV4maBfhDOeGwGqsrfRVRZmFgJGhhWGV51ZcpjECvySS0Y7TZK5neQGHSCfRhRxcrjIQyW+ujkEa8Tkp8GpGm5F7vPC4AZdNxK4GIzQNgLnbPbNBnDers2xtoc7jU9YkKCXNe/5x+Grvq6hyZZ2QDomPE065uJ767HpmK40FKyTzk2ikwDI5o+J2slypvvBIS8PCKpmgKbocJQcBV5hldZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(40470700004)(46966006)(36840700001)(336012)(186003)(47076005)(2616005)(426003)(82740400003)(1076003)(81166007)(356005)(83380400001)(8936002)(36860700001)(70586007)(70206006)(5660300002)(7696005)(40480700001)(40460700003)(4326008)(82310400005)(8676002)(316002)(2906002)(478600001)(41300700001)(54906003)(26005)(6666004)(6916009)(36756003)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:21.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3080f6d7-21ff-47fa-7f7a-08da87d6e233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <Eric.Bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Each index in the DPSTREAMCLK_CNTL register
phyiscally maps 1-to-1 with HPO stream encoder
instance. On the other hand, each index in
DTBCLK_P_CNTL physically maps 1-to-1 with OTG
instance.

Current DCN32 DPSTREAMCLK_CLK programing assumes
that OTG instance always maps 1-to-1 with
HPO stream encoder instance. This is not always
guaranteed and can result in blackscreen.

[How]
Program the correct dpstreamclk instance with
the correct dtbclk_p source.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c      | 8 ++++----
 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index a31c64b50410..0d5e8a441512 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -225,19 +225,19 @@ void dccg32_set_dpstreamclk(
 	case 0:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL,
 			     DPSTREAMCLK0_EN,
-			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK0_SRC_SEL, 0);
+			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK0_SRC_SEL, otg_inst);
 		break;
 	case 1:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN,
-			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK1_SRC_SEL, 1);
+			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK1_SRC_SEL, otg_inst);
 		break;
 	case 2:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN,
-			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK2_SRC_SEL, 2);
+			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK2_SRC_SEL, otg_inst);
 		break;
 	case 3:
 		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN,
-			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK3_SRC_SEL, 3);
+			     (src == REFCLK) ? 0 : 1, DPSTREAMCLK3_SRC_SEL, otg_inst);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index db7b0b155374..226af06278ce 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -116,7 +116,7 @@ static void setup_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	dto_params.timing = &pipe_ctx->stream->timing;
 	dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 
-	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, link_enc->inst);
+	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, stream_enc->inst);
 	dccg->funcs->enable_symclk32_se(dccg, stream_enc->inst, phyd32clk);
 	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	stream_enc->funcs->enable_stream(stream_enc);
@@ -137,7 +137,7 @@ static void reset_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	stream_enc->funcs->disable(stream_enc);
 	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	dccg->funcs->disable_symclk32_se(dccg, stream_enc->inst);
-	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst,  pipe_ctx->link_res.hpo_dp_link_enc->inst);
+	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, stream_enc->inst);
 }
 
 static void setup_hpo_dp_stream_attribute(struct pipe_ctx *pipe_ctx)
-- 
2.25.1

