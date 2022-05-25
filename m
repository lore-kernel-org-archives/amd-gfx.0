Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE94C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830BC10F9CF;
	Wed, 25 May 2022 16:20:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E759D10F2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVY5DjfVSHBV+K/6deVoHgKxDlzI1ktfVFKg/SgL4wqzpXeDf5r7WfXHT+zA+iQ+zFKK7xVUtFNWZ+fAb3PfFPKPwHmMhpR34M0SzB6nkepHD0/DRnYUSH5vQ/vcAS4PPFtUEiKjglk9fHVF52bnITCWZPJqrNi5f/iuyhJdGZ+SK+HlCLocGD/lN0OeMDYMIXhUnP+uFEeXx6phtQKCayJ97OmT6kzoS1VMkWiHRDUDws4Tkb7Dam1Cn4XJkDd0shRdtA9QqWb/SiLa9dJuVmd3O4N/yqAyoZVOWKr9bMLwsdIqqjjZU1MHlefFyS5dfme2pz5eb3h0n1e84Z/KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYcQDe5NM1y5H6xivdw+ygmtwtawX4V4Z1Qw9k8H/gc=;
 b=OsZDpA4jTzI9k+UESYpV1mvnYlkwLw92E+gWEbNhNOml827bQuMfU0wSzd0EUbkRp4ESDPY9BupcjWov9XYA3UuosVq7loqx/A7gUqSqoRlOfaUMoRzA7Whk1dNmWYoSkhrh6fCLPfLGtx2pDZFrq1Zecs2JGhr3JKKLNNCuTgIiQBLPfaXduCqcf155R/QLOjeO+0fJiWduGOBRIGSbtz+PSGOsJlIfylNvL69eB22lOaUVbREifWAm1TSLLdzWjFgO591UXkNoSnyscBaWNcpx6VWhQ6KgZo7oJLSOxalYMjUAP+qz2KLpdYpk149OjQ1ADgicwjH0vbjeqjEz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYcQDe5NM1y5H6xivdw+ygmtwtawX4V4Z1Qw9k8H/gc=;
 b=ijVEjj0s8EwQdrvV/jArzlqjvarIn49XZAp8lh14ay1UGmj6kviOw4OU70YeKjvySUceRaPBb5zTB7SFJBzP7zIIwz+pvgchyFxRMRm78z20QxwHqed/io9p91MehwvOXySeOIbLJsnzrZStNnecUuaxGReytcPE5nsJQtQYrNk=
Received: from DM5PR05CA0022.namprd05.prod.outlook.com (2603:10b6:3:d4::32) by
 BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Wed, 25 May 2022 16:20:22 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::f8) by DM5PR05CA0022.outlook.office365.com
 (2603:10b6:3:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/43] drm/amd/display: update disp pattern generator routine
 for DCN30
Date: Wed, 25 May 2022 12:19:33 -0400
Message-ID: <20220525161941.2544055-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279d2e53-5c2a-46f8-57ba-08da3e6a775c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34798DBB107A96EC3E093C0FF7D69@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ld+Fk+LnBLW194H+nHbcERTf7MXt4deaS+DkmDovvjIi3Hr6dZSg4OjW6jVwrqbK6rdxFL0znoCWOH5kZMwM5vxJitjnebhWSwEPLFjSnIbKeeFuCUxPLRkK9SR0ZtiPqGuZr+ysSzY/G/yBXx1JNmvkp4w9q4HbBDJrCm3/5LYUWP66WsOIAnXss4SBiGYaOPnFseB8G3MpoCMkwITy6cS1/wCakEfeMCG0E70Skrffewlsls3jCMQpOPAIyV3HiI+HNSimoMyww7DFqOwXN+Y01v4IKVS8iSbhCAXHySdD5TXMR02M3xRdffc8aUqH639qMrSF5sCJSX56RDjVsagc8Y6kGRavv8mZc8vCp7Szm+DK5SZXVIrkbRBopPLtdyhMu/ByhEiCntKQeQAp4nqJu9GLeGG2G55+XfkabZwGuq5lqW3yhqg6b2lpVA2Ki/1E2feJ2S+0/qd3AfMoDSse6nRJhtlM+vZfUqsDp7BTlE9cxU39fRkP855/FxSkXL5u4vKfYlopj5nGdNY7rVI2Uj0jt9LNdIC+uGLs0CkNih0hJdBEj8SId8c19njFhrCGBJL5AKyN3i/WPURWM17YqgkFnKAy5UG3cWxEjPX6Xq2GQ6fPd9LU4TrLx99kydkbRjdfoH3nAAlx8W0f/7s0rdT2kIOcyrizP20NE+BfhX4csQKJw90WCYlu7utOcKY3vM33IZ/N+RoWi4hFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(70586007)(70206006)(4326008)(54906003)(8676002)(86362001)(356005)(316002)(6916009)(5660300002)(81166007)(82310400005)(508600001)(8936002)(16526019)(83380400001)(2906002)(1076003)(26005)(186003)(47076005)(426003)(336012)(7696005)(40460700003)(2616005)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:21.5405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d2e53-5c2a-46f8-57ba-08da3e6a775c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 33 ++-----------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 782b8db451b4..ecdc7c781217 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -959,35 +959,6 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
-	struct stream_resource *stream_res = &pipe_ctx->stream_res;
-	struct pipe_ctx *mpcc_pipe;
-
-	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
-		pipe_ctx->vtp_locked = false;
-		/* turning on DPG */
-		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
-				color_depth, solid_color, width, height, offset);
-
-		/* Defer hubp blank if tg is locked */
-		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
-			if (stream_res->tg->funcs->is_locked(stream_res->tg))
-				pipe_ctx->vtp_locked = true;
-			else {
-				/* Blank HUBP to allow p-state during blank on all timings */
-				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
-
-				for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
-			}
-		}
-	} else {
-		/* turning off DPG */
-		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
-		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			if (mpcc_pipe->plane_res.hubp)
-				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
-
-		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
-				color_depth, solid_color, width, height, offset);
-	}
+	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
+			color_space, color_depth, solid_color, width, height, offset);
 }
-- 
2.35.3

