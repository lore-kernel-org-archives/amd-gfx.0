Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CAC46CD2
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jan 2024 13:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968741123F1;
	Sat, 27 Jan 2024 13:39:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF141123F1
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jan 2024 13:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKDxEeM9o8kTQslOUfwts0DfK8wPX/JO/6MIlozhLhnQKiKwIcbLijlbz902EMQPc7ObqcFu6gJkm4dQlF+2CQvnlpQc/X9NEgRqunTJ9EhK7oY8E5DzXKE6J+KhtdAjbyQyKARYqRWtcR3Gc1QQ2tubsEqg6hBwHdn0MKNOjndFJupZjA0EYPuwSbM9Zb5YngbwDDVwQOCWUh8SMngGfUR58r6CTKT6iKWlXwDeT1xZNBCvn+0BUWxYouuevfySxJCeHyORXcvnF3kUhVL9M1g/AXy3O9patx1eraid/WbnlEkXWEy6RiyhpH41mOr6IKZddGocUS+9E/OQy2fzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv2m+HSe/gnI1Im2x2p1MQ96LxdxtCJY/DFK1PHtCLw=;
 b=gWfao0S9hJMHzgvCR2+iKR3juLAAF0n2UmPmeIiE6GO/F3oT1l+S6CO9JbAi4j3P7Q8GOZcAhLpsLhyKH4jonwtHY2fLgsPm2vGu+Zgl2eMDsCnBugDAVPHix3gYYmPSg+1cZm7DsVWyX9RNp9df8lpxiUBpshS2VjF7n9P7GzIMvvBSiNo8leGApdsIIwuOFRwgVJfKhEvtvx+k7sF3twUV2UyghudTc5KW7DT+umYP4uawV8FbTQURzQOEd7v631jSJAuGSB4JQ66a1miHqpxC+oiTpvFRwL6d/ohwV38hQRe2zxUpsoGZYBBIMMGA6FP67LHMll1teBBTdB9zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv2m+HSe/gnI1Im2x2p1MQ96LxdxtCJY/DFK1PHtCLw=;
 b=jVtXxbewd2DbbImpCkg88Kf5W1lgPscXWPVm4Gj+W6i4vKdcTebOpSlRrc74vzdIV0UwF+nGwK91wUrrkHdODaS0YEo6Ik8oIM80tDmPWWNx9hOxoUiGYZC7kPlRd6OI6U41ksYyhrraiuCZad9JwGsFiwamsdPMTslKZ27QVZI=
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 13:39:26 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::67) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28 via Frontend
 Transport; Sat, 27 Jan 2024 13:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Sat, 27 Jan 2024 13:39:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 27 Jan 2024 07:39:24 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix 'panel_cntl' could be null in
 'dcn21_set_backlight_level()'
Date: Sat, 27 Jan 2024 19:09:09 +0530
Message-ID: <20240127133909.1978795-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: e0469fc9-3274-41fb-51a7-08dc1f3d614c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGt702olOUWjj3xrtivn2I8/+3AIwGIdI6NGA/Nvtra+cNzcKkPES44LS0nLAhRN0/wwg2KhZ1McDTvpYfXOtuhfXd2nQkntH728cLFK3kGX3RGADDlYGFD+BlkDrOi2R/DWjXv1r3oUkV5J4vFR/FSIP3xcNP/F1hgqu3sl8ZCCivkM7ugODzneaOiPIwo89Zfs77PARuDhkH9rfjWdxCc6LiDqfIwAO6Hk5IJBB09ZUzaHGGXYJE8IDFm9TKS82rJaxXMzmxeGk4xx1y23xRJZnPBittrFQpMHp2yneqRQ6srOZL9d2A5jmqMl73BJf+QFpk4o3+Iu1n4otmSXxDWuuAxeft9mlDQ9Nh3ggobMebDkQbKGRJvnTBF4eu4pKCCO2YD6XtRxuQN2hbR/TjOiXTCFJLv3QNhDSgy9TyKnT+/gADluHO3vRVslen3jOZD8acVc8oLnBn+m5Iw3GGRHb06gixvko0J1ecVqGhoE9mcqJbv1l5yp5uphvT9Fv7YixXFBw+bRXtaYhprsIh0XZfd1FvOtA+kgZiAsrxXK8mh4/ED2bfyzX54fDzjHivjgEhafW+mixY3Xg2rY5DNy6AiZrqJE7J14FVkrWox5q7feKnt/fYMWS+dZZPDRD2OpbPWujgAa4o3XjFAuGjSimKaig8roZZAuXlUYfvH9+Ok3DYGBhtxnFVpSU93ovHaiaRoOyJ10rXj3ccMSRh/sPakweHBHvLUpobAlB5LXrfA7DEE9aWjfrFPYPGbOsYG+/QToV1IIYP1UyveMfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(46966006)(36840700001)(2906002)(36756003)(41300700001)(5660300002)(316002)(83380400001)(70586007)(6636002)(54906003)(7696005)(47076005)(70206006)(40480700001)(6666004)(44832011)(40460700003)(16526019)(26005)(478600001)(86362001)(336012)(426003)(110136005)(2616005)(356005)(1076003)(81166007)(82740400003)(36860700001)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 13:39:26.4844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0469fc9-3274-41fb-51a7-08dc1f3d614c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'panel_cntl' structure used control the display panel could be null,
dereferencing it could lead to a null pointer access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn21/dcn21_hwseq.c:269 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 250)

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..86b9265f670f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -237,34 +237,35 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
+	u32 otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
+	if (!abm)
+		return false;
+
+	if (!panel_cntl)
+		return false;
+
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
 		return true;
 	}
 
-	if (abm != NULL) {
-		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
-
-		if (abm && panel_cntl) {
-			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm,
-						otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-			} else {
-					dmub_abm_set_pipe(abm,
-							otg_inst,
-							SET_ABM_PIPE_NORMAL,
-							panel_cntl->inst,
-							panel_cntl->pwrseq_inst);
-			}
-		}
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
+	} else {
+		dmub_abm_set_pipe(abm,
+				  otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 
-	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
 		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
 			frame_ramp, 0, panel_cntl->inst);
 	else
-- 
2.34.1

