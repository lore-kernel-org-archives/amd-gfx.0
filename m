Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF9BC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1632C893DB;
	Wed, 30 Nov 2022 06:39:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB5410E292
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EomqVtRKMq4/iN+jj/TNGFeiK/eVobH3yShaw86AHaC6pYwGn4TfykDGneRjHUHN+0jW4IwqdFlMc0i5AbUXxQAv528uTlRbUtKo9dWnAyrTNqDxOfvZV+oxzhYC+iMwvfDJTLByROmB6y3ic61i6pdIPngrmMLLkrbOoBQ1aVir+XD/x94WQ42mwnngmmXzShftP6YNJvp1x9idN8VyXTcsI05yR9UrWl+MxfoB4ICvoRyf2lvtzGilacnYfyg+LLW9u151cIglryonyhea7VA/EfSOBtHFbZS5FkyxiXZnMtlI3vjl2J1C8o7VlQW9p0uEcM1jb0KAwriRWYh0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jqrqfQHNS4tBRxHYJGUofQZdZYcNFn5rf/voYZcixQ=;
 b=SvT8tbnS5k4Mbfkc1N/psvnpbO4biVDM4XYVaf7J4j1G6JNSA60bYFDMIkHm+zBNBrbgeJDsJBO/sAYZu1ZM+DSyU+AVLpRxzFES2GR/E3va4QkrpM5woohEBMt+T9ZSQcB8xdK+SB/BBWC7xrkUkXDhEBqT9w70oD5DVuyFUy/qFf8Y6ckL352625o1ZvW+W2CSwjcsoaPixzxM4IEMySuOhz5RzXVtFGEVcOL0z4FVoubgaTYlmL3WJQYuxBmtq+r+NLU1tCkjY2LEyy+76nAMWH1xHAmMyQbAxATBc1aSYG0bUZfjPWkUvlYjoAJm4izbiSeQPce1KPS2/Gj6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jqrqfQHNS4tBRxHYJGUofQZdZYcNFn5rf/voYZcixQ=;
 b=WA+G9gmq/zqVIa3WrPap/Qneg7uOgSAnX0LK9KxK9SUfDkAr1wfRy5TdCKq3Yvsc1ZXSsxExE3soMtZ6lporFp3j4l5ZeEdvge1I6GVRTPrNd2NFwIgFrk804vCEeqlgJ5rwdpfzXTiLdsSMekyyA4WTfw4UkO90IblBkDiVUIk=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:42 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::b4) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 06:39:41 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:37 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Disable uclk pstate for subvp pipes
Date: Wed, 30 Nov 2022 14:36:19 +0800
Message-ID: <20221130063627.2398341-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: feb08b90-2b0e-4e6d-7417-08dad29da91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4pUhIMo4ehJcaHlIR87qBs5ivIXiwVyvn1Owha6xWp3/SOCH5Vpe/E5l39tWMRkgJ6mgbmAkGHxTCkXxpCzNMR69iOiUkOt+pUrYF/iHzV42Wyxj1ak9tqHfDM5DWM+GAv/h0vk2dyw95kdfZw3hAB2Pn3eSPo23WAfeIOrGaKAH3G3VHK21OhS/xO5kpkTerxX4ZQ6rgMCEblnPW8/Dl3NLd6BJeKV9arB6EfDtX9/OZ0s2oi6X1zrOpCHK9pZF7SvSJAOGsjcQEqsnVOKkSMimKg2NNhqJvRQS58ue6C++qmEodMi5q/WgaA87IgFys4+uzQXlynJFpwSsqMH+bfIYAaV3oFiGY7yssx6X31zS6h20f7z6ImyQCruWMd4JDtIbeQio2j5MvKc5d6nfHL2sFbWl9WRS3+lrHcDjfdxhtQZaZHX5yj9U5MSVFBZEHfsM8dPHsLTcqzVlX8SXoxNdeK/NBl6u0XNjmFEgbLfcy7Ofh2+msGrjmrAHKevEgJCJjDg48jQY0MgmjjQ0UJZyRtMKM5Et67VJ5Yq4pSWzTRLHlX8FdNyWQBjaufXRAtxJ7U51VZwQ6LU5ZWhx0equDySfGyR+068bYGCl7jOaEC/oacqJKIhoWxWkItYZNTn/eKFsyiCncbuLcolwOd4vvsKtP8/53WIBllqNke4IUXZLIzQqFcGXOjltTlC3LHr4ny+biR6rcALX0SFH9vqgZZM+FEdFR4Ql/iKK1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(36756003)(82310400005)(70586007)(8936002)(336012)(478600001)(26005)(4326008)(8676002)(7696005)(16526019)(6666004)(2616005)(40460700003)(1076003)(6916009)(81166007)(356005)(40480700001)(186003)(2906002)(83380400001)(47076005)(426003)(5660300002)(41300700001)(86362001)(316002)(36860700001)(54906003)(82740400003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:41.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb08b90-2b0e-4e6d-7417-08dad29da91d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
When subvp is in use, main pipes should block unintended natural uclk pstate
changes to prevent disruption to the state machine.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index c9b2343947be..b8767be1e4c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -703,11 +703,7 @@ void dcn32_subvp_update_force_pstate(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		// For SubVP + DRR, also force disallow on the DRR pipe
-		// (We will force allow in the DMUB sequence -- some DRR timings by default won't allow P-State so we have
-		// to force once the vblank is stretched).
-		if (pipe->stream && pipe->plane_state && (pipe->stream->mall_stream_config.type == SUBVP_MAIN ||
-				(pipe->stream->mall_stream_config.type == SUBVP_NONE && pipe->stream->ignore_msa_timing_param))) {
+		if (pipe->stream && pipe->plane_state && (pipe->stream->mall_stream_config.type == SUBVP_MAIN)) {
 			struct hubp *hubp = pipe->plane_res.hubp;
 
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
@@ -785,6 +781,10 @@ void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context)
 	if (hws && hws->funcs.update_mall_sel)
 		hws->funcs.update_mall_sel(dc, context);
 
+	//update subvp force pstate
+	if (hws && hws->funcs.subvp_update_force_pstate)
+		dc->hwseq->funcs.subvp_update_force_pstate(dc, context);
+
 	// Program FORCE_ONE_ROW_FOR_FRAME and CURSOR_REQ_MODE for main subvp pipes
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.25.1

