Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE06ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1331510EB3F;
	Sat, 27 Aug 2022 02:27:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C45210EB3F
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSaWRkqzNR5E+SUSQfasAbusSZuz3IkYB9G4oNdibWYjf7Qq88SxTagB5bmUwU40foKyDw1BKndV98g1kJxxw7FyAzA4WjetU+hrobm4F0qXYBOc0LTeuKob5zSHDI1NstbCIDeW6FFHtg6PKkEfJIlMZJny8QQMr7UFOQh0eX2UJPkPvV2L96HxA3SbMwCzKKtgNznYc1IpyZsy/3+1dDT1WBdHiCl6+mhe2LL+ItVumVoeaJMIEist/3EDtWFFG7Rv/7YLsZGqmRwolYBQx+NVk+OTsS0OR+//LpjPQjlCt2k5J0BnLhoeLJk9f5VKhk1vk55DpOpfEPoSfp+2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcAxQFOFIHTBgymU+Q5sD7+j1l8KuenEZki8WEmqREk=;
 b=obpmaGknK6funKPsdNOI+J+ReUspgR05xsh0hxAUV2m6BAhCCBVE6BFhH1J3IFt9ZYDLW23zVlt2U/Y1MeUhI7K1r5x8v8EXfhxXcSwtsMuQYz62o3pcU89liFkmqmitNb0FquB6UUxwJ+nxbtIxqdD1RKueKE8NLYtvAeNHAH35Z+pJgS923mMtME1t099HPg2fEApDmmPXRgXNtEFHLkHnoyzo9ahBzlAMia37PgBV2VDQZxlyL9PxHfmkKIslXS2Ve6CVI9JdfCIQexrQs5/AjikACesbpy1jLoJdeTlMXaB3P2xmvK3GreJ7UliI/gkgeDTuU+IECQK3Fyh0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcAxQFOFIHTBgymU+Q5sD7+j1l8KuenEZki8WEmqREk=;
 b=EtxMfJLXX5APkn0Qm0QFXFfXBev+02ef1tKZrrjWcaf/Qt9tpPRt9s3HvPuEB9ImyLQhzuz+mjnBjCkOdi/WvXxne41Y4jr7FFUtB7uhCwqPcy/lutW7DK4hZ5bAW+QJjBAzRCZRtNXbHH0BVBocdP0Ha1C8gzd1YaNy3fp14Hc=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sat, 27 Aug
 2022 02:26:53 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::7d) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:26:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:49 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:45
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming
Date: Sat, 27 Aug 2022 06:26:52 +0800
Message-ID: <20220826222722.1428063-4-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33d8695-ccf5-468f-68ac-08da87d39ac8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3999:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQVqvA4KoxR8qPqeItXj2ZsnHoG1lnr6kizy8CfvxaLfehG32WSrSLmq6ALR76/cH/CUa8OFHZIjJYT9g2zZKLTLNSOyMGDsUxbxjbqksTkCb9Gu7H8vTOZ8ifF6t+7SvSLrFT6yelSD9ZjO28DTSiYEARXrbue26iGvUKhrpoB7NoOhZhe+LstM4MY39eP6CSbu9h/4yd2+KSpcCgqb5p9UA4SIy3qsSihoX5PV8kKIQ/KuLgVgpE+0P4PhMFBE3XxbFRXZqfVq59exlwwM0yT7v29gRjuUoaIcyZUinw46pNlBgcqncGWBn6L90f3mewVN1XgBhDhsu/GcTEmSK8qpOqKiDdxL9XftZ2fP34n282niz03tmv51DgEAeZhKF9Ua8VXyYTUN616Dn2lePupFoQt/Nh003eT6ezFbrbPWgAXUDfyS/WvzF5KMjbsK2OQl2kdoG8FlHCvZaoYo7cmf8nG0/SuGKz8jrRI69ScjYLZWKQincb3R+NJscOUyHC0ZhYxps3SrXRkUDrwyt46ialfQyQOJAlIZgvVjdfAJrrGU6r5S/+g4PWrA9YBSeQhV0HZwC5RqKlV8rT9YZ7xtXn2CtFGOkRi+QwW6+h7fwVRtxDqvpYf6D1w4j+DnHVfYoIpJo3qwkNuk4RFlg5mqFdOV6fSZtcI/TM408Gzc7faazjVhLPk2zRFQbfvD+dUMUXIvMDsF0eLeLQq2kIxbZdWn8wxGH66jHxpftTAYztRxWYJhpK8bGS4/SgYpAEZN45Myk/WY56dNgBKa5hXHjFQpF8dgaBzyIJBEEKfThUOOPKuCA9burS+qNQaCvoo1WRV8R8f7f2IPAZboDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(426003)(47076005)(7696005)(336012)(83380400001)(40460700003)(2906002)(1076003)(186003)(81166007)(356005)(2616005)(26005)(82740400003)(36860700001)(86362001)(40480700001)(316002)(54906003)(82310400005)(41300700001)(8676002)(70206006)(8936002)(6916009)(36756003)(478600001)(5660300002)(6666004)(70586007)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:52.9146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d8695-ccf5-468f-68ac-08da87d39ac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
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

