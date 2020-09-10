Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B6C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885A321D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gEVnP6ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885A321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B800B6E961;
	Thu, 10 Sep 2020 13:47:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928E76E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTEkTPfANgISipz9LODc9c9bS1KS6XANezTchFqpjr2IPecd2LZ3WGw5sYl5xqNjPW9UJlvjofEJtu9J/idagc3gaiw4KNcBNBz0Cg/lx+hPH9eg2lc6CUl2q2yiIJq9ffdfurLrRtSAgvENV8R9BeECEQfZXHtJ/4d+iBUIdTjbWT1dSK/+pHOPX639LUcNX7KapmSyXxdAZD29GQDejYo5uNNKF+hAztlhS6L7VXC/4JfTn+6csZLliq+WgVWqyRaovsR3C9axNmm86ZtPOOpZPFcgMB1COm3mwa76d7RB3NiUBL0mTic0LMqTOu/8viSjpEzD0U1iDoMNFOi4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXTe6rXzoqsyMLU3mtEJ1msLHoH+PMVciE8G/MO62Hg=;
 b=QKlbDkWxCvlxAfPvxYvKWh+Bp2Cntoora4IGojX5AS/DoAstThb83O8NtzYRRgac+LTBarbL7wQE1RWcVVSCS4IDIAojR0IUqzbEdNitudSN63mxHk/AAcmsNJo1a/JLPycoYstTxxxZVy+4nZp3xEBekN2xVxNFx+0mBawTYYhJJ8c88vYjWnWmVT2BBXWpXRUPRZhT2b+GuyKdq+RA9Tgq5wpCxQf0W2pop1XJgsDRPqIL42JsLfJ1psU5mEEBOfv56aS2+Bmcb9t4aOZmLX0h8xtPzrB92z1aD0cTydQzs1bFT5Q7wRE6hiRSigxIiwc/Wwqasa/zLnH9lnE/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXTe6rXzoqsyMLU3mtEJ1msLHoH+PMVciE8G/MO62Hg=;
 b=gEVnP6oknU2WOvp4NkPxCl3LreRvQ86+L9XIYlTChMux4J5khadHwfjLboqoO969TnqFghIjCoOXV6H1PeDHYDdJFDf2kVRFVYzgUGwfwSvzxNlMZa1oOt0akTDOAZdTVf5jeZp1ZzcL04Enq7DyGwbAcAtFE1+poQtbq6etkAo=
Received: from DM6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:40::32) by
 SN1PR12MB2430.namprd12.prod.outlook.com (2603:10b6:802:30::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 10 Sep 2020 13:47:33 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::7c) by DM6PR03CA0019.outlook.office365.com
 (2603:10b6:5:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:33 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:32 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/42] drm/amd/display: Only use offset for first ODM pipe
Date: Thu, 10 Sep 2020 09:46:54 -0400
Message-ID: <20200910134723.27410-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a85881-a1f2-407d-9e52-08d8559011ec
X-MS-TrafficTypeDiagnostic: SN1PR12MB2430:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2430B42E270AFD17336C21B68B270@SN1PR12MB2430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7x1VpxqojDbFLADkCtMczgPsWTrLw8kN6hvww3O8Dea6XR7AEIQDLeJs/y8rYWVtIKa5yBD88wlX4rvM+ecO+JiL5Rmp3X3a3vgok67raX4mvnSC4yIvDSfD7/WukL0VIaaJ/dTkrdrgZn/iqUtvm9KdC3ONZohYcvgkYE/bGX8kfjVW9P63QWl5opIo8jHhEOswyIeA3lHu6AeLqAzXgx7Al/rWaBK28mdStpuXG4LnRkEIGKbQD100hstVu6dPxgw2/uO2qcufC6XHDxTRGvcj3DoJ9o5OW7z1uAsPXGyFRFN2kw1WX1bCkI7lcGPUi7zMNa+JcILToUueLPBUQkbwEd0X21mgLbWeIKDlDoRg+41M/tiZSZkkxsYKggQ8IlCbQY8srMRe7v549gZ7zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(478600001)(86362001)(2616005)(70586007)(316002)(7696005)(426003)(82310400003)(4326008)(1076003)(336012)(5660300002)(44832011)(8676002)(8936002)(81166007)(70206006)(6666004)(36756003)(83380400001)(54906003)(26005)(356005)(47076004)(82740400003)(2906002)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:33.6456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a85881-a1f2-407d-9e52-08d8559011ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2430
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Only the first pipe in ODM combine group should have nonzero recout
offset. All other pipes should have recout offset 0;
otherwise there will be gaps in the image.

[HOW]
Set recout.x to 0 if the pipe is not the leftmost ODM pipe.

When computing viewports, calculate the horizontal offset of a pipe's src
based on the current pipe's position in the ODM group, plus whatever offset the
leftmost ODM pipe has; otherwise there will be discontinuity in the image.

Since ODM combine can only combine pipes horizontally, nothing needs to
be done for recout.y.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c6b737dd8425..4cea9344d8aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -782,7 +782,13 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 
 	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
 
-	data->recout.x = stream->dst.x;
+	/*
+	 * Only the leftmost ODM pipe should be offset by a nonzero distance
+	 */
+	if (!pipe_ctx->prev_odm_pipe)
+		data->recout.x = stream->dst.x;
+	else
+		data->recout.x = 0;
 	if (stream->src.x < surf_clip.x)
 		data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
 						/ stream->src.width;
@@ -957,7 +963,7 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	struct pipe_ctx *odm_pipe = pipe_ctx->prev_odm_pipe;
+	struct pipe_ctx *odm_pipe = pipe_ctx;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect src = pipe_ctx->plane_state->src_rect;
 	int recout_skip_h, recout_skip_v, surf_size_h, surf_size_v;
@@ -988,21 +994,24 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 		swap(src.width, src.height);
 	}
 
+	/*modified recout_skip_h calculation due to odm having no recout offset*/
+	while (odm_pipe->prev_odm_pipe) {
+		odm_idx++;
+		odm_pipe = odm_pipe->prev_odm_pipe;
+	}
+	/*odm_pipe is the leftmost pipe in the ODM group*/
+	recout_skip_h = odm_idx * data->recout.width;
+
 	/* Recout matching initial vp offset = recout_offset - (stream dst offset +
 	 *			((surf dst offset - stream src offset) * 1/ stream scaling ratio)
 	 *			- (surf surf_src offset * 1/ full scl ratio))
 	 */
-	recout_skip_h = data->recout.x - (stream->dst.x + (plane_state->dst_rect.x - stream->src.x)
+	recout_skip_h += odm_pipe->plane_res.scl_data.recout.x
+				- (stream->dst.x + (plane_state->dst_rect.x - stream->src.x)
 					* stream->dst.width / stream->src.width -
 					src.x * plane_state->dst_rect.width / src.width
 					* stream->dst.width / stream->src.width);
-	/*modified recout_skip_h calculation due to odm having no recout offset*/
-	while (odm_pipe) {
-		odm_idx++;
-		odm_pipe = odm_pipe->prev_odm_pipe;
-	}
-	if (odm_idx)
-		recout_skip_h += odm_idx * data->recout.width;
+
 
 	recout_skip_v = data->recout.y - (stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
 					* stream->dst.height / stream->src.height -
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
