Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66BEECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F2E10E7F4;
	Wed, 14 Sep 2022 03:32:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37F810E7F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUv6Xbk7wNaPprLQ9qmrL930eQ0gj63qC9w3Zs7oT63hJTojk8w5inhs7VzHjmQue0U9Xlc58WmlbyArDlBlZKQPcbf6Z0U8iseVlwXOYDVVJ9EFcBi0G0NltQRUG+nWcR7Y+2shIBw4OLv8UjDoPPtMkagS5p+9yWh85rXP8ZY6qdq6GuO56jhqf6saCRQ6FDWTCQhpLlNnLgWcnGkwlVBWzqiixTyqbo6ylr/FDoedyPuz/gC+dkUXlHGddKmm8e0+AM98ck4tynV98+VEd8uGlCJSG3uRHUpU5WLHBXt6MUQJXTkpAuDCU0GpW045m+qonzoMoz3qmGVMrcwymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=doUsSAW/8vXX0mBWo8CZkQF411nNDIRJXC3hqunugOx+JEAByFzo0ZGN12UgZELYiZ9tGSB1HIbc7SzZsvDi6+Rov5uGaC6vMX1+bTxfS/TJGRXrtPd247dnAMY+9ep6EdrLH8J+i4O3X4WsMkB3S6drBpoVAjnCWzfLeKfMrejSTB5BhbM2VnK4OP17QQT2exn+RDjsETRAxTwYIvGcTvml4KEPNKvEZTFhjkgF7Wno33ZmG0FzxZioHywisIBnoezrA2NB05oYOchKHa7lyunE3ySldxIt1dA2riJe5aTyvzrfwb+PWEgICRDTjH24iCAWlvE9008aDTg690C/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=rl7UV5udyInc0SXhSM/dYYwn1uWoGFKu8KQm8eo68Y6TFFxVpM/EZiXoewRvBFN5cFSZoeHLSpBHt07Oa4LbmccXMyhgmWzVZmrHCGY4/1t5D/WeaRAtuoN9p6yi98bGBkNcueGhBEv5v2Ln6ofmqiBHX/5kwKBdzOJp+v2ssFA=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 14 Sep 2022 03:32:39 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::60) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:32:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:32:37 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:32:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/47] drm/amd/display: skip audio setup when audio stream is
 enabled
Date: Wed, 14 Sep 2022 11:24:15 +0800
Message-ID: <20220914032441.1075031-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1fc85f-e529-49d6-567d-08da9601c673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+839b1L2JI57BURK3w5MOrz1+qYInC5/tJxr0vGGDLWr8WbZCJbJMi621gnhs93N9PBdFk4F34OLGY8P1IK7GnbOiyeZdZLieZXmvtupVyW9ab9G1X0l6kW4pvshyWpr2SUp4dRICrzdMVPuAznNnl9oc4ZURfrC5xdTV1+YKqd7SqUNFJfx4A/9Ari4v5XVg6AYlir6kOUZ7lE7j9Q89J+/IFJhiJe5GHvO9Rnoq0wZhQdJlDU79dKzyKjL8hbamOjixPHkx83YakMLmhk8S3Ts1MZe8bfZbk0W9SxplVJvIyBu5KYwkK0eK1dGhawcQPFFmsl011S2NJISvCDGKba7GZkxRW4Oadu8hvfAuvf/qfBUuj0KOT6anf8EomEPk5i7K4rYaV6Qnlm5HqR6Ym5PIdcvDYfNBvXLHOpXxrU8NGcQ7t/aKgX71VHrUvGcWQDRrg1rgUTXmJ4HfTru8Z2kmuYO+l1vc3xAGiLnrX61w/dMAegQ/omKveXfDPMas6qh1O/Oi/8+h3Ly/MxIv+QNn8AAzpzsd1tjF7mOBch8tliHRIVN0YUjV9I1Oezf2nwKDvugU3VDqH7iXuW/jXw6y4c9GVNbYALjs/uneInJ8LgUEp6Z4Fq05uJm0xA2pfF2nM/JBvH1dWPLKzn+0THm8YjYLs73lSNlVSSuW8KFpSQvq7gmJIRbSrOdoJclRl2znFedOfvdfx4c4Ykmel3ZLPPh5KodmXGLJrnJVhR9kN8EL1G2ffTgl1Y0TcxwHaM5OaXpaUDrLq2wz+Ti5Q8xQYO5TcoIwdbMSbCIDA6oTv/h9fcb+sOFBb+t6WW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2616005)(2906002)(426003)(8676002)(82740400003)(41300700001)(26005)(83380400001)(40460700003)(7696005)(86362001)(70586007)(70206006)(6666004)(81166007)(8936002)(4326008)(36756003)(5660300002)(36860700001)(336012)(1076003)(356005)(6916009)(47076005)(186003)(40480700001)(82310400005)(316002)(478600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:32:39.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1fc85f-e529-49d6-567d-08da9601c673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, zhikzhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhikzhai <zhikai.zhai@amd.com>

[why]
We have minimal pipe split transition method to avoid pipe
allocation outage.However, this method will invoke audio setup
which cause audio output stuck once pipe reallocate.

[how]
skip audio setup for pipelines which audio stream has been enabled

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: zhikzhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 70ac0b31baba..55c98dbfcc1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2178,7 +2178,8 @@ static void dce110_setup_audio_dto(
 			continue;
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-		if (pipe_ctx->stream_res.audio != NULL) {
+		if (pipe_ctx->stream_res.audio != NULL &&
+			pipe_ctx->stream_res.audio->enabled == false) {
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
@@ -2218,7 +2219,8 @@ static void dce110_setup_audio_dto(
 			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
 				continue;
 
-			if (pipe_ctx->stream_res.audio != NULL) {
+			if (pipe_ctx->stream_res.audio != NULL &&
+				pipe_ctx->stream_res.audio->enabled == false) {
 				struct audio_output audio_output;
 
 				build_audio_output(context, pipe_ctx, &audio_output);
-- 
2.37.3

