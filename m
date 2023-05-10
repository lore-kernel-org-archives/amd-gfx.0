Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22B7C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1958610E524;
	Wed, 10 May 2023 20:49:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073510E523
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kispxu1MBn0kJo0gko9Kp230FxY8c8WPVEaikV1CFLHCSeNX+vrN8fYh/K7s4oA0jd+/KW6w9XheqgjGYO9QUQGkC5fA9tA7gBDmTiDn1RPUYTMDNomLssAYvBJC/4wvjqSQyKMmPJIyeldxEZVioqRWcni5dUpIxd3qwwhNYNCFYLiL9BwU9BUI6JICPqp/TRSzqpfAJCHBgHy7fEnqNmPf+L+Ng0dcoUK+xAzhYOg7Hn2WC+U07xi16aGCocq+B3mcSpwdn8mxpoBDYxG3niqK9S1sgQ0DRSlWWiL/9ueD2EeFEbB32VSc4saCWNsw/tIWvt8tfqLHWl8RDWKk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyfFyzz0evgZhrhcKCpmqo9cyXxOQwTu3m2GO5oBt58=;
 b=DXrGmimmPh2J+Dn8lLTJw5qFRSKG1oBou5GfTVyJGuDLn03nAQxry8ZhiJRiHGp0acMoT4Fxis+317wcwR9u+cl70IDlYLsS/uQ6w3v1GweGiY2EPj9Ikyc9TIAkhSGYGT6aDfVMABTtCuuNpAp0Bk7VxHqsinTDfpIHx4sRTvsq3r+lD31/oe4vxAR4XN2CNZhjaOZlbq0kh+PWVOBE78BT1Z1xNVYYsYruaTCDW4qQ3c2+TeVlVDbfm+UKvR7BH/w2gtbaLOdpbwtF/moxWTI4/i4O0nPS0nWs1ntrgmRx0WcOgTj/uNGt6Vf89vKog8e2gN8Ds7aGh5ed/6kBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyfFyzz0evgZhrhcKCpmqo9cyXxOQwTu3m2GO5oBt58=;
 b=QVpMXWmbgFxkT9r4NNGRVbh6YU0uauKQpnsTwd2MRqS2gRnbLLTruGHWo1gOuYOGixW2+pbQLLme1whG00xFAYa+UtJ0KJSRdOvbmD8y88gbvxq/suU9lTYzIyIUI2kOAhvfFF2K3+l/6QHtpgPb160xh4RVPbhWmAttfnKDmlE=
Received: from MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:49:16 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::6f) by MW2PR16CA0065.outlook.office365.com
 (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:14 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amd/display: Make unbounded req update separate
 from dlg/ttu
Date: Wed, 10 May 2023 16:48:57 -0400
Message-ID: <20230510204900.949963-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e92487-2787-4eec-42e1-08db5198045d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nd22+s3AVitzc41g2JEYdRSjG9OIEmqFxQxNnc37aUwz++APNVAXxJEOUdsKR7kFNjGesvfw/PTZfAX2/NaSZlba77jujy/hEYQDNcSCDUakUUTE3ymIz7tFfSRFwHnnCUOoS837jkgB0WDPivCcu0/X972hte2e+90YmgftYljTTemGTdXednT9BqCdio8ORt+qvoNPGArzUV44KKX3opD+PPXNBKdp1Uf5/+lY1i4dAQsD7VmpCnnYk/AMwreeT1bCw3JAxA8NWeDG7T6ZLzTBA7JiuHk7Y2mggUoO4JHF+vyyXHKs9K0S5e0wOO46ZcZQny5jhOb8an+l0hc8rdfYPbewUx6WbeX1coB4W+qV9x/A+Nd9Ejjl5yqmCjQXQSxBOpbajuBjUWxgEMoz6D20aBNUsRdD0sBlUmo0nVaz/BfEgV8pd5J12STvXmbSIC/QBd3fQrGraIWoZIHkulWyEcAjfF09VVAS7DP035UJ0vwDXOyn69j3NmVPfRnTGpiOfxiD6zthO5O/P93mSI3PwgmmGhZrZcrqcvjol0X88rBLFcwAYY0Tw2S61pkRvOtmTAVjRhdZztnJsYkVGJQndg+zVLY1uO25CytEjxrzdn0guaMmLgh9mRLVGNlXBreYKyqtehjTmRwzGzXPg8lTUWvxyrMUIy31kv6j2h3bX2Jtsg+SpzY0LjT7hSasa/ZNM3ME+7Pw827Kue2kUXtzbj1GLy5WXdih/JcOS+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(336012)(36860700001)(426003)(6916009)(316002)(47076005)(2616005)(4326008)(70586007)(44832011)(86362001)(356005)(8936002)(81166007)(15650500001)(36756003)(8676002)(70206006)(82740400003)(40480700001)(5660300002)(54906003)(83380400001)(6666004)(7696005)(41300700001)(478600001)(2906002)(26005)(40460700003)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:15.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e92487-2787-4eec-42e1-08db5198045d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Updates to unbounded requesting should not be conditional
  on updates to dlg / ttu, as this could prevent unbounded
  requesting from being updated if dlg / ttu does not change

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 11 ++++++++---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b3e187b1347d..e74c3ce561ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1361,6 +1361,7 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 		new_pipe->update_flags.bits.dppclk = 1;
 		new_pipe->update_flags.bits.hubp_interdependent = 1;
 		new_pipe->update_flags.bits.hubp_rq_dlg_ttu = 1;
+		new_pipe->update_flags.bits.unbounded_req = 1;
 		new_pipe->update_flags.bits.gamut_remap = 1;
 		new_pipe->update_flags.bits.scaler = 1;
 		new_pipe->update_flags.bits.viewport = 1;
@@ -1504,6 +1505,9 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 				memcmp(&old_pipe->rq_regs, &new_pipe->rq_regs, sizeof(old_pipe->rq_regs)))
 			new_pipe->update_flags.bits.hubp_rq_dlg_ttu = 1;
 	}
+
+	if (old_pipe->unbounded_req != new_pipe->unbounded_req)
+		new_pipe->update_flags.bits.unbounded_req = 1;
 }
 
 static void dcn20_update_dchubp_dpp(
@@ -1537,10 +1541,11 @@ static void dcn20_update_dchubp_dpp(
 			&pipe_ctx->ttu_regs,
 			&pipe_ctx->rq_regs,
 			&pipe_ctx->pipe_dlg_param);
-
-		if (hubp->funcs->set_unbounded_requesting)
-			hubp->funcs->set_unbounded_requesting(hubp, pipe_ctx->unbounded_req);
 	}
+
+	if (pipe_ctx->update_flags.bits.unbounded_req && hubp->funcs->set_unbounded_requesting)
+		hubp->funcs->set_unbounded_requesting(hubp, pipe_ctx->unbounded_req);
+
 	if (pipe_ctx->update_flags.bits.hubp_interdependent)
 		hubp->funcs->hubp_setup_interdependent(
 			hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b4c1cc6dc857..d8dd143cf6ea 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -374,6 +374,7 @@ union pipe_update_flags {
 		uint32_t viewport : 1;
 		uint32_t plane_changed : 1;
 		uint32_t det_size : 1;
+		uint32_t unbounded_req : 1;
 	} bits;
 	uint32_t raw;
 };
-- 
2.40.0

