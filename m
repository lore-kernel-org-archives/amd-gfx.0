Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98575C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5FC60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C5FC60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC70D6E1D6;
	Wed,  8 Sep 2021 14:55:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845886E1EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDhx6dRlIWn4QA1Iza4iGb2F0o8ceLJnNW+X/Dn6oLzRljMj3bCQznYMR9iZTobtRh3PrANe14NeZ2U/hzER6ifJ1WxUclFK1Aez5WczyARfg8s4oCrM43PRZ9LWpAT+j3asTgBm4WPjc3aq9lj/PtGAjKcnN2ZeQ38xBVopkuyfsRzEhMqmpSaHtAf5TNGNtxAwpPugWERkxaH07QKMd15NJ2vCqj7Em9pS6xfKgmjEZrvgR7RwLp3V39WCl9ww+YTz2gYZEOAPfJyd8+SyeRJVkn2mgHOXYCIGgu7Q6oduByHNc2Cz60vvlvEAeOFyxLDBOm2G4fBF/RI3HOWN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c9+pA+lbZFFkuVRgZJS9xY+8Mc3qpGpq9XV0vrlmi9c=;
 b=Rxc2MeYy1QKCtFS1gFew2Bj1EVgyn8FKKB7CCvdqJ11TCLXwZHO7QQu4zt4dC2xq2M7dzJ+7KGM99MRSN2F05WTmAw671lleJen3Ad6y9okNuZt+hlbmrOGOSFcBcWBWglVAofU1XKMnJG1nxvYqL8JlhfF3NzyduhqmgeqQUTQFw4rFMrsi1seqlJlAz6ACPwspA417Dn0DTUCAcocqPtXYyR4lQ+in3TDUiLuUW0ulMCetb9adrPc2yfY9Z7JumDot25h6j958scXprHM543pN8piEqEAL+hgORru86bc7kyP0lSPdCMT2rVtdzCY/A00Sew7GyMMvTwcf+/eNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9+pA+lbZFFkuVRgZJS9xY+8Mc3qpGpq9XV0vrlmi9c=;
 b=I5qRRc2nBmULC51ZWsti1gl9wrdtLxyj2ioTZp2NeBPFXqY4a6nPJeEZNw1Y2VJg84CWK6mqVoKKpkZMu37pC1Ch0DCUDNWmZifxH+bvkdq2iEiwsTXmbfU8QS7HZoY/cao/aO8hI7u0JZKx1/nKSu+i3wggOYKfeYSB0N2pO9Q=
Received: from DM5PR20CA0039.namprd20.prod.outlook.com (2603:10b6:3:13d::25)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 14:55:01 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::f6) by DM5PR20CA0039.outlook.office365.com
 (2603:10b6:3:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:01 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:59 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Dale Zhao <dale.zhao@amd.com>, 
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Subject: [PATCH 21/33] drm/amd/display: Refine condition of cursor visibility
 for pipe-split
Date: Wed, 8 Sep 2021 10:54:12 -0400
Message-ID: <20210908145424.3311-22-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3a1b48-3438-47bc-854b-08d972d8a29a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:
X-Microsoft-Antispam-PRVS: <BN9PR12MB521042A88B4FE7DCA4E3CA2DE4D49@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+c/Cd3W6SVo+51tdUZzDdMQViBMpiFjQM3SPi9nxbjnYmBqOekc5gwD6LrQimobrUXwYLQtW7h4jhBgXbu4ePW6U01FDy7+1WAi3fv4jvrAj0Xsg1DtACQluK8AqWqn4SYQ+iF3BatDwYi1jTnBmdNcf/iykj3YOiwFwIzW2DN5KsfH5xIlwhb+V/kym+Bf0xft0tHLou9iqeyQGlYpm2lmiOKsnTfX/Jd/xbQ3t1REJ64JhC6Tjn9cS5eRcL0h3teFjcJiH+6qiaolJSPdc7goz9qW6sB4ZO3pdvtSYh4hkV11ybkpG0FED2NfpKp4PsQ34aQ5jqx6ieIVwjowGon5RSVgvovj/7Jy5wH0W1JUlwcCgheFxZ32KjezWdr3U8UfXTVybwp24jy8cN0g6bBOxC67q7f//DZFgRydO28qFvxQlScW785UZnNVADz/A4WrZ7JLkSsbQeby4bKAW6ANIlswp+HXeNO/owdkVmWXtpBgMPZ+htJY/vM05rjww1+k9U+QtFGkU4xwh5D4/UhwsoK5VRdajRnuOKza85nqUHq5PVg2kJbW9bH9wLQQRESVyubub+LxcnwGNBSlqYfdV3yWQF1Z7TQVnlw34xtmYJNJ4BlupKW2S3cw1QtJResuvOPp2YhWqciEEvFCmCH1sLl65AFbl8IUjJktknNybYx9Ukn9uVSrLTsMNuzwlsnoRspP5yBAVlCxV64jqAVSFXanCH+EW7Vw1SYaGgA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(70586007)(6916009)(2906002)(54906003)(336012)(4326008)(316002)(70206006)(16526019)(86362001)(186003)(8676002)(44832011)(82310400003)(26005)(478600001)(2616005)(6666004)(426003)(47076005)(81166007)(36756003)(83380400001)(356005)(5660300002)(82740400003)(36860700001)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:01.5214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3a1b48-3438-47bc-854b-08d972d8a29a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
In some scenarios like fullscreen game, major plane is scaled. Then
if a upper layer owns the cursor, cursor is invisiable in the
majority of the screen.

[How]
Instead assuming upper plane handles cursor, summing up upper
split planes on the same layer. If whole upper plane covers current
half/whole pipe plane, disable cursor.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index b4cf2e92694c..e1edbfa761f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3241,13 +3241,11 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 
 static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 {
-	struct pipe_ctx *test_pipe;
+	struct pipe_ctx *test_pipe, *split_pipe;
 	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	const struct rect *r1 = &scl_data->recout, *r2;
-	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
+	struct rect r1 = scl_data->recout, r2, r2_half;
+	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
 	int cur_layer = pipe_ctx->plane_state->layer_index;
-	bool upper_pipe_exists = false;
-	struct fixed31_32 one = dc_fixpt_from_int(1);
 
 	/**
 	 * Disable the cursor if there's another pipe above this with a
@@ -3256,26 +3254,33 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	 */
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
-		if (!test_pipe->plane_state->visible)
+		// Skip invisible layer and pipe-split plane on same layer
+		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
 			continue;
 
-		r2 = &test_pipe->plane_res.scl_data.recout;
-		r2_r = r2->x + r2->width;
-		r2_b = r2->y + r2->height;
+		r2 = test_pipe->plane_res.scl_data.recout;
+		r2_r = r2.x + r2.width;
+		r2_b = r2.y + r2.height;
+		split_pipe = test_pipe;
 
-		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
+		/**
+		 * There is another half plane on same layer because of
+		 * pipe-split, merge together per same height.
+		 */
+		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
+		     split_pipe = split_pipe->top_pipe)
+			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
+				r2_half = split_pipe->plane_res.scl_data.recout;
+				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
+				r2.width = r2.width + r2_half.width;
+				r2_r = r2.x + r2.width;
+				break;
+			}
 
-		if (test_pipe->plane_state->layer_index < cur_layer)
-			upper_pipe_exists = true;
+		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
+			return true;
 	}
 
-	// if plane scaled, assume an upper plane can handle cursor if it exists.
-	if (upper_pipe_exists &&
-			(scl_data->ratios.horz.value != one.value ||
-			scl_data->ratios.vert.value != one.value))
-		return true;
-
 	return false;
 }
 
-- 
2.25.1

