Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D1C352A4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE3A20720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V77T6kOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE3A20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F3B6FD13;
	Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329B96FD0D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I30djD8GpvauzFptkk4+DJpCALVD/XpnY3dgZxuUud3IZPA6ZPy48YfztVezsT72C7s37MUxJ5dMJGvFcg/jH/lkI/ygtRz3c/QvIl8BdhdglbDpLEct+6ld9zjFwT20X0qXd4Cs6fJ6KrEwMjd0MFKnWPurfJ/BxVXecLg3EhfCUAcvShWCZWfYHCXiUNhrvq70C3ocdtypn5mMr5wEi5P14mPhNs6oOJ/no6JPSnXwT1JCifVQ9FiDyWA/B0955zc/b2+prbfJIla38p8aH0og83Xj4+Tqcbhn7tz8aBVTOweF1ljfGGqgnsG/GhewrxStCts8IUKF8KtOyhmohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65vL16ymJp0UM5cxZ/j9VLt3U/Egzt2GXFmA+18lXuk=;
 b=gchCi5OAJFDEDDvUn1SG/8tlMZr+IF+6ENQhH5kkPz/9xhFDld0aYIbLX/GvFfZRZKya4b6ywgl7KHVWdk3mZxd5xSNGCoI67FUuMu7jqroziuRe9xPOWDEo+iEtMbK+vcmH6YdidjvvjftD2DNyJLAGPUVY+4Ku6ZURyAUGnaEsQZd4vywvL6erPCuW1QNVjlyopU2QqEt4HCbtE+kD4Ee6oDKMSDZhQtN2WSd940FHCahB6pEZcNk4/lXCDw6k5ixRmrXsNcA2eHxEO2vgMYniiuuQwYriRBMjTpK4NJc8+uxV86T4cHyC+hGFsjK6vvPAMCjZxzVOyWaI16JQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65vL16ymJp0UM5cxZ/j9VLt3U/Egzt2GXFmA+18lXuk=;
 b=V77T6kOxCMTTys8qfRN0RSyh6Kd386hhLhr+727gdbhzbn5oNIlLltP8OxAm3nxCgLN2zB05nppoC1ZebhSDBCoshW32OaMtdPHGG0v/XfYzV2Q86hY6E+Kkpv6NeoZblMaI2KNvCCUW4OLgci9Oif2cZGNgS0bvaLz76wLdosc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:50 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/17] drm/amd/display: add odm split logic to scaling
 calculations
Date: Fri,  7 Feb 2020 10:50:05 -0500
Message-Id: <20200207155010.1070737-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cca77faf-f0f6-4d13-f391-08d7abe5807f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440DCA68AC7BFA3AA3A6EDB981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(30864003)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSluQttRbhysLUaDg2gPCJ3OsFzFYhaz1AnlgG+B3+NYkrM2spyddJ0OY0lAb2yW1ilRoFLXN1M3c6rtGuXQWa4SfGZ1qWnCtu/8FLUC9b9DYYtBxAdrqCadxs8h1gCNmtGdcAotVEfl81GZdbSzbwRCvJSQGgqGjzaKAx18FlE4C9/FV7vcdqgRdf5v5yEcBxXh8giIXZUmv5orFLQ76JuR+2+zKOYf62SbL1sMO5+27jfGPhrTK5P0fbK3LYYNZrBxzBeNn/58bMQND3qLUIRfVFL3t0e3PEf7l7QCicUHZeSiq2O/gLQxhXkuANWWVcxaTBi8zYgtRS1YIuPuS3Q0Bt2aml+ugzikWFrubYJaIZJxBmTf5E/kt6vcHx2MyZ8hmMSEeme96Jajg5adtzAGw7QRxSEp9qMqWJOh7RTRBHpYu2IBfsBq4kwpLAIL
X-MS-Exchange-AntiSpam-MessageData: QLEdHFs6bh+TRB+q2KJQUS0lI3IfQqF0EMuCc68HD83GzoU0T17xCmnMu1qeZQTWYUxNmpwFogGbHI/laq4cJEW8AzAR6lNjKUTMXN6KrJZbOqCGS3PeEpsmtHrwR/5pFVBaVc9nPKFMySKoTYqGyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca77faf-f0f6-4d13-f391-08d7abe5807f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:49.1462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zjRKCFBGA3tL8bhCsrltXNQCRzcyEIEyJa5rCynIp7+NPlZNGbXnmRzE5i8VcfPetgE1TeLlULy7O2yuq4uCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Michael Strauss <Michael.Strauss@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Currently odm scaling calculations are only done when adding initial
odm pipe. Any scaling re-calculations will mess up odm because of this.

This change resolves the problem by updating scaling split logic to
handle odm.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 171 +++++++++++-------
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  40 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 +
 3 files changed, 132 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cd80d8249d14..a65a1e7820d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -532,6 +532,35 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
+static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *split_count, int *split_idx)
+{
+	*split_count = get_num_odm_splits(pipe_ctx);
+	*split_idx = 0;
+	if (*split_count == 0) {
+		/*Check for mpc split*/
+		struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
+
+		while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
+			(*split_idx)++;
+			(*split_count)++;
+			split_pipe = split_pipe->top_pipe;
+		}
+		split_pipe = pipe_ctx->bottom_pipe;
+		while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
+			(*split_count)++;
+			split_pipe = split_pipe->bottom_pipe;
+		}
+	} else {
+		/*Get odm split index*/
+		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
+
+		while (split_pipe) {
+			(*split_idx)++;
+			split_pipe = split_pipe->prev_odm_pipe;
+		}
+	}
+}
+
 static void calculate_viewport(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
@@ -541,16 +570,16 @@ static void calculate_viewport(struct pipe_ctx *pipe_ctx)
 	struct rect clip, dest;
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 			|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
-	bool pri_split = pipe_ctx->bottom_pipe &&
-			pipe_ctx->bottom_pipe->plane_state == pipe_ctx->plane_state;
-	bool sec_split = pipe_ctx->top_pipe &&
-			pipe_ctx->top_pipe->plane_state == pipe_ctx->plane_state;
+	int split_count = 0;
+	int split_idx = 0;
 	bool orthogonal_rotation, flip_y_start, flip_x_start;
 
+	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
+
 	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE ||
 		stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM) {
-		pri_split = false;
-		sec_split = false;
+		split_count = 0;
+		split_idx = 0;
 	}
 
 	/* The actual clip is an intersection between stream
@@ -609,23 +638,32 @@ static void calculate_viewport(struct pipe_ctx *pipe_ctx)
 	data->viewport.height = clip.height * surf_src.height / dest.height;
 
 	/* Handle split */
-	if (pri_split || sec_split) {
+	if (split_count) {
+		/* extra pixels in the division remainder need to go to pipes after
+		 * the extra pixel index minus one(epimo) defined here as:
+		 */
+		int epimo = 0;
+
 		if (orthogonal_rotation) {
-			if (flip_y_start != pri_split)
-				data->viewport.height /= 2;
-			else {
-				data->viewport.y +=  data->viewport.height / 2;
-				/* Ceil offset pipe */
-				data->viewport.height = (data->viewport.height + 1) / 2;
-			}
+			if (flip_y_start)
+				split_idx = split_count - split_idx;
+
+			epimo = split_count - data->viewport.height % (split_count + 1);
+
+			data->viewport.y += (data->viewport.height / (split_count + 1)) * split_idx;
+			if (split_idx > epimo)
+				data->viewport.y += split_idx - epimo - 1;
+			data->viewport.height = data->viewport.height / (split_count + 1) + (split_idx > epimo ? 1 : 0);
 		} else {
-			if (flip_x_start != pri_split)
-				data->viewport.width /= 2;
-			else {
-				data->viewport.x +=  data->viewport.width / 2;
-				/* Ceil offset pipe */
-				data->viewport.width = (data->viewport.width + 1) / 2;
-			}
+			if (flip_x_start)
+				split_idx = split_count - split_idx;
+
+			epimo = split_count - data->viewport.width % (split_count + 1);
+
+			data->viewport.x += (data->viewport.width / (split_count + 1)) * split_idx;
+			if (split_idx > epimo)
+				data->viewport.x += split_idx - epimo - 1;
+			data->viewport.width = data->viewport.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
 		}
 	}
 
@@ -644,58 +682,58 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	const struct dc_stream_state *stream = pipe_ctx->stream;
+	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect surf_clip = plane_state->clip_rect;
-	bool pri_split = pipe_ctx->bottom_pipe &&
-			pipe_ctx->bottom_pipe->plane_state == pipe_ctx->plane_state;
-	bool sec_split = pipe_ctx->top_pipe &&
-			pipe_ctx->top_pipe->plane_state == pipe_ctx->plane_state;
-	bool top_bottom_split = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
-
-	pipe_ctx->plane_res.scl_data.recout.x = stream->dst.x;
+	bool pri_split_tb = pipe_ctx->bottom_pipe &&
+			pipe_ctx->bottom_pipe->plane_state == pipe_ctx->plane_state &&
+			stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
+	bool sec_split_tb = pipe_ctx->top_pipe &&
+			pipe_ctx->top_pipe->plane_state == pipe_ctx->plane_state &&
+			stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
+	int split_count = 0;
+	int split_idx = 0;
+
+	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
+
+	data->recout.x = stream->dst.x;
 	if (stream->src.x < surf_clip.x)
-		pipe_ctx->plane_res.scl_data.recout.x += (surf_clip.x
-			- stream->src.x) * stream->dst.width
+		data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
 						/ stream->src.width;
 
-	pipe_ctx->plane_res.scl_data.recout.width = surf_clip.width *
-			stream->dst.width / stream->src.width;
-	if (pipe_ctx->plane_res.scl_data.recout.width + pipe_ctx->plane_res.scl_data.recout.x >
-			stream->dst.x + stream->dst.width)
-		pipe_ctx->plane_res.scl_data.recout.width =
-			stream->dst.x + stream->dst.width
-						- pipe_ctx->plane_res.scl_data.recout.x;
+	data->recout.width = surf_clip.width * stream->dst.width / stream->src.width;
+	if (data->recout.width + data->recout.x > stream->dst.x + stream->dst.width)
+		data->recout.width = stream->dst.x + stream->dst.width - data->recout.x;
 
-	pipe_ctx->plane_res.scl_data.recout.y = stream->dst.y;
+	data->recout.y = stream->dst.y;
 	if (stream->src.y < surf_clip.y)
-		pipe_ctx->plane_res.scl_data.recout.y += (surf_clip.y
-			- stream->src.y) * stream->dst.height
+		data->recout.y += (surf_clip.y - stream->src.y) * stream->dst.height
 						/ stream->src.height;
 
-	pipe_ctx->plane_res.scl_data.recout.height = surf_clip.height *
-			stream->dst.height / stream->src.height;
-	if (pipe_ctx->plane_res.scl_data.recout.height + pipe_ctx->plane_res.scl_data.recout.y >
-			stream->dst.y + stream->dst.height)
-		pipe_ctx->plane_res.scl_data.recout.height =
-			stream->dst.y + stream->dst.height
-						- pipe_ctx->plane_res.scl_data.recout.y;
+	data->recout.height = surf_clip.height * stream->dst.height / stream->src.height;
+	if (data->recout.height + data->recout.y > stream->dst.y + stream->dst.height)
+		data->recout.height = stream->dst.y + stream->dst.height - data->recout.y;
 
 	/* Handle h & v split, handle rotation using viewport */
-	if (sec_split && top_bottom_split) {
-		pipe_ctx->plane_res.scl_data.recout.y +=
-				pipe_ctx->plane_res.scl_data.recout.height / 2;
+	if (sec_split_tb) {
+		data->recout.y += data->recout.height / 2;
 		/* Floor primary pipe, ceil 2ndary pipe */
-		pipe_ctx->plane_res.scl_data.recout.height =
-				(pipe_ctx->plane_res.scl_data.recout.height + 1) / 2;
-	} else if (pri_split && top_bottom_split)
-		pipe_ctx->plane_res.scl_data.recout.height /= 2;
-	else if (sec_split) {
-		pipe_ctx->plane_res.scl_data.recout.x +=
-				pipe_ctx->plane_res.scl_data.recout.width / 2;
-		/* Ceil offset pipe */
-		pipe_ctx->plane_res.scl_data.recout.width =
-				(pipe_ctx->plane_res.scl_data.recout.width + 1) / 2;
-	} else if (pri_split)
-		pipe_ctx->plane_res.scl_data.recout.width /= 2;
+		data->recout.height = (data->recout.height + 1) / 2;
+	} else if (pri_split_tb)
+		data->recout.height /= 2;
+	else if (split_count) {
+		/* extra pixels in the division remainder need to go to pipes after
+		 * the extra pixel index minus one(epimo) defined here as:
+		 */
+		int epimo = split_count - data->recout.width % (split_count + 1);
+
+		/*no recout offset due to odm */
+		if (!pipe_ctx->next_odm_pipe && !pipe_ctx->prev_odm_pipe) {
+			data->recout.x += (data->recout.width / (split_count + 1)) * split_idx;
+			if (split_idx > epimo)
+				data->recout.x += split_idx - epimo - 1;
+		}
+		data->recout.width = data->recout.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
+	}
 }
 
 static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
@@ -832,6 +870,7 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	const struct dc_stream_state *stream = pipe_ctx->stream;
+	struct pipe_ctx *odm_pipe = pipe_ctx->prev_odm_pipe;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect src = pipe_ctx->plane_state->src_rect;
 	int recout_skip_h, recout_skip_v, surf_size_h, surf_size_v;
@@ -869,6 +908,12 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 					* stream->dst.width / stream->src.width -
 					src.x * plane_state->dst_rect.width / src.width
 					* stream->dst.width / stream->src.width);
+	/*modified recout_skip_h calculation due to odm having no recout offset caused by split*/
+	while (odm_pipe) {
+		recout_skip_h += odm_pipe->plane_res.scl_data.recout.width + odm_pipe->plane_res.scl_data.recout.x;
+		odm_pipe = odm_pipe->prev_odm_pipe;
+	}
+
 	recout_skip_v = data->recout.y - (stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
 					* stream->dst.height / stream->src.height -
 					src.y * plane_state->dst_rect.height / src.height
@@ -1021,6 +1066,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		store_h_border_left + timing->h_border_right;
 	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable +
 		timing->v_border_top + timing->v_border_bottom;
+	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe)
+		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
 
 	/* Taps calculations */
 	if (pipe_ctx->plane_res.xfm != NULL)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 85f90f3e24cb..39026df56fa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1861,20 +1861,20 @@ void dcn20_populate_dml_writeback_from_context(
 
 }
 
-static int get_num_odm_heads(struct pipe_ctx *pipe)
+int get_num_odm_splits(struct pipe_ctx *pipe)
 {
-	int odm_head_count = 0;
+	int odm_split_count = 0;
 	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
 	while (next_pipe) {
-		odm_head_count++;
+		odm_split_count++;
 		next_pipe = next_pipe->next_odm_pipe;
 	}
 	pipe = pipe->prev_odm_pipe;
 	while (pipe) {
-		odm_head_count++;
+		odm_split_count++;
 		pipe = pipe->prev_odm_pipe;
 	}
-	return odm_head_count ? odm_head_count + 1 : 0;
+	return odm_split_count;
 }
 
 int dcn20_populate_dml_pipes_from_context(
@@ -1956,8 +1956,8 @@ int dcn20_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dp_lanes = 4;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
-		switch (get_num_odm_heads(&res_ctx->pipe_ctx[i])) {
-		case 2:
+		switch (get_num_odm_splits(&res_ctx->pipe_ctx[i])) {
+		case 1:
 			pipes[pipe_cnt].pipe.dest.odm_combine = dm_odm_combine_mode_2to1;
 			break;
 		default:
@@ -2124,18 +2124,22 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].pipe.src.dcc = pln->dcc.enable;
 			pipes[pipe_cnt].pipe.dest.recout_width = scl->recout.width;
 			pipes[pipe_cnt].pipe.dest.recout_height = scl->recout.height;
-			pipes[pipe_cnt].pipe.dest.full_recout_width = scl->recout.width;
 			pipes[pipe_cnt].pipe.dest.full_recout_height = scl->recout.height;
-			if (res_ctx->pipe_ctx[i].bottom_pipe && res_ctx->pipe_ctx[i].bottom_pipe->plane_state == pln) {
-				pipes[pipe_cnt].pipe.dest.full_recout_width +=
-						res_ctx->pipe_ctx[i].bottom_pipe->plane_res.scl_data.recout.width;
-				pipes[pipe_cnt].pipe.dest.full_recout_height +=
-						res_ctx->pipe_ctx[i].bottom_pipe->plane_res.scl_data.recout.height;
-			} else if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state == pln) {
-				pipes[pipe_cnt].pipe.dest.full_recout_width +=
-						res_ctx->pipe_ctx[i].top_pipe->plane_res.scl_data.recout.width;
-				pipes[pipe_cnt].pipe.dest.full_recout_height +=
-						res_ctx->pipe_ctx[i].top_pipe->plane_res.scl_data.recout.height;
+			pipes[pipe_cnt].pipe.dest.full_recout_width = scl->recout.width;
+			if (pipes[pipe_cnt].pipe.dest.odm_combine == dm_odm_combine_mode_2to1)
+				pipes[pipe_cnt].pipe.dest.full_recout_width *= 2;
+			else {
+				struct pipe_ctx *split_pipe = res_ctx->pipe_ctx[i].bottom_pipe;
+
+				while (split_pipe && split_pipe->plane_state == pln) {
+					pipes[pipe_cnt].pipe.dest.full_recout_width += split_pipe->plane_res.scl_data.recout.width;
+					split_pipe = split_pipe->bottom_pipe;
+				}
+				split_pipe = res_ctx->pipe_ctx[i].top_pipe;
+				while (split_pipe && split_pipe->plane_state == pln) {
+					pipes[pipe_cnt].pipe.dest.full_recout_width += split_pipe->plane_res.scl_data.recout.width;
+					split_pipe = split_pipe->top_pipe;
+				}
 			}
 
 			pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_16;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index f5893840b79b..5180088ab6bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -49,6 +49,7 @@ unsigned int dcn20_calc_max_scaled_time(
 		unsigned int time_per_pixel,
 		enum mmhubbub_wbif_mode mode,
 		unsigned int urgent_watermark);
+int get_num_odm_splits(struct pipe_ctx *pipe);
 int dcn20_populate_dml_pipes_from_context(
 		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
 struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
