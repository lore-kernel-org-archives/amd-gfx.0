Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1224EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE1410E46E;
	Wed, 23 Aug 2023 16:04:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD92E10E469
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHKkdfEbpyOmzTOW1WcYLI2co/4Bvj4f+bcGgVOknu9A209xlm3nIoizv6CSC+wWGGoaobX6Cuq35lhlF7qFq83nuYrryFu6cVBDq+q3TsWuqepiggxkYR3te7PH6jqK4cM2Pc6MTt0wLTgNZwKrjU8y3gP2U5VDVZGhI1a0xOxWcnKwMCzpyu1mNhDnlNj4W098CHoT+46Fa++9n9b1hFEGaDL3eTWPMAracCqxRF4dkqHShRh98aJQfLpHUmLRtUmAXtqMuD98peA32hsyebIOQdSSXGK/erotyPbFIBGIkpc5iGUQgT1AWvAUMRkijU8HpH0ZUEs+dSZb517kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQVcFQ0qwo0coGrrHV8SWNYTSm1+LJaj6I6yBg16sDQ=;
 b=EVcqsOAVzfOXtCEmYHE5sp2CKqrAiqAUIF1cLwYZRS3yd+kNkANhrPOS/fslu2SyqUD0BEFgtv+0yufdB6ymqXo/mJz3FGuJS04wBbbBxeaTNS7yb/l/3MlFIQF/JIB4q7COTJYW0HvUtPdrr3KbPhfOenUaLlFblGthHnS4/yaFhHc9uYfjWLDF/nVsOns3Mz2er/GwdVjbfyqeUY19dmummzxwVQ5BUfDAPbK8C+dfHZtSuLti2YHO1pyMMc4tBmLIIITNNG/a2MV0e3gE8qLDM0D670ofJBR9lAzv0uw9Y3+Gsa7g/iLpf/PF6faZHRzRX337CqkWQiUAdwUdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQVcFQ0qwo0coGrrHV8SWNYTSm1+LJaj6I6yBg16sDQ=;
 b=f2zGj2o72N0qqhVMEVOIrKzLPVzguOq1kS9pSIYWW5gjzo2I7b8U9tlTmoPu11yRJvsOR9r33NHbtwLzJSHtJLjx4lfMG0J02WU2TSpqiUL0MJWNzhC2f2LLGkOc+gcgZdUzedKpTw8p1cuh7C4x7K2Z6mplaQwLd3zgdDqKnac=
Received: from PA7P264CA0108.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::8)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 23 Aug
 2023 16:04:32 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::5) by PA7P264CA0108.outlook.office365.com
 (2603:10a6:102:34c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:31 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:29 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amd/display: add more pipe resource interfaces
Date: Wed, 23 Aug 2023 11:58:13 -0400
Message-ID: <20230823160347.176991-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: e44f7cbf-5a1d-461e-7d7e-08dba3f2a2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: md5+A29tr9uliR2YlHg0OSEdNav2J9kBQFbpEBJObR8gZgeZVxneV+0+d9SQ2dq+/2/SVCAspBGA0Y6ovlZgyD7ZSPZKNx8iKB9w1Xgr02B5vydVe87hIZpbYj+vVlJ6Xtu1po92RKBAGu4kvFarSXYwnNBV0TNsjmlk3nZ9f+IO4Bga9wGki7fDLtjFjRhy22Y79FOEgsKIWMXvk30P8TW5Fm0Wzj7x4tGbRpdkWd9zuQLNmG+RIkhEjd4KYcI0rzvl8U9HRTDvL8xbzvTLYQ9/B7aRQ6MFl6edM3zc1+FuWkEYuYrjCOTTdpV8ZNKymZp3xwSPlhD0y/EuVQ9f8rrn/vSta00NQ1xXJxCUOtOfEaMUcEzlnh5omQKyTcCWbVNFu6zCmejb+QwvYiIExuBMJXNY3JGVJE9OJWkf/5Uh36SshKuJ2m/0KsD+bUHHB5vvp6Siy2jIVY4coIi8j9mWjkOOCKesmt7bUBauFKmkOG4WZGuh1ILokYT1JGY2tRYFugPoLncTjRyqWIgEpQ3an2qICa8My6FOpDeUopRp5dKSu9ySC0LxfyUnPHy5H/WYLRPyv6zZaSEwbzBBOM7beOUvf+6V9F5hygzGUfuusQcFC65kporWTj0v2D0/2RIOqXs5mfvC2baTP2p8gUEESLFuTh7GScxiiP9mMtstZhhu3CIU+Ey7PYWW/EtIRuVAVEi9Mrd2/ehiUhGQGhqDeAt8CFeEANyu/aG/tgLP9kj4/Y2EULxqnYIo8FchmLqTRWaYRShA4Ep+buPxC2tpuMO8H6JUWTboKqDBA7wOOjj7tVzAmm6JTqvxZ/hG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(336012)(2906002)(30864003)(1076003)(36756003)(26005)(2616005)(356005)(86362001)(6666004)(36860700001)(81166007)(40460700003)(478600001)(83380400001)(47076005)(16526019)(82740400003)(40480700001)(54906003)(6916009)(8676002)(70206006)(8936002)(426003)(316002)(4326008)(70586007)(44832011)(5660300002)(41300700001)(16060500005)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:31.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44f7cbf-5a1d-461e-7d7e-08dba3f2a2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Redesign pipe resource interfaces in resource.h file. The new interface
design addresses the issue with lack of pipe topology encapsulation and
lack of pipe accessors.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 951 ++++++++++--------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  22 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   4 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   1 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  11 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 278 ++---
 18 files changed, 740 insertions(+), 545 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b7ab357d1b9d..84db7c5fb852 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -732,66 +732,6 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
-int resource_get_num_mpc_splits(const struct pipe_ctx *pipe)
-{
-	int mpc_split_count = 0;
-	const struct pipe_ctx *other_pipe = pipe->bottom_pipe;
-
-	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
-		mpc_split_count++;
-		other_pipe = other_pipe->bottom_pipe;
-	}
-	other_pipe = pipe->top_pipe;
-	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
-		mpc_split_count++;
-		other_pipe = other_pipe->top_pipe;
-	}
-
-	return mpc_split_count;
-}
-
-int resource_get_num_odm_splits(const struct pipe_ctx *pipe)
-{
-	int odm_split_count = 0;
-
-	pipe = resource_get_otg_master(pipe);
-
-	while (pipe->next_odm_pipe) {
-		odm_split_count++;
-		pipe = pipe->next_odm_pipe;
-	}
-	return odm_split_count;
-}
-
-int resource_get_odm_split_index(struct pipe_ctx *pipe_ctx)
-{
-	int index = 0;
-
-	pipe_ctx = resource_get_opp_head(pipe_ctx);
-	if (!pipe_ctx)
-		return 0;
-
-	while (pipe_ctx->prev_odm_pipe) {
-		index++;
-		pipe_ctx = pipe_ctx->prev_odm_pipe;
-	}
-
-	return index;
-}
-
-int resource_get_mpc_split_index(struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
-	int index = 0;
-
-	while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
-		index++;
-		split_pipe = split_pipe->top_pipe;
-	}
-
-	return index;
-}
-
 /*
  * This is a preliminary vp size calculation to allow us to check taps support.
  * The result is completely overridden afterwards.
@@ -844,8 +784,8 @@ static struct rect shift_rec(const struct rect *rec_in, int x, int y)
 static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	int odm_slice_count = resource_get_num_odm_splits(pipe_ctx) + 1;
-	int odm_slice_idx = resource_get_odm_split_index(pipe_ctx);
+	int odm_slice_count = resource_get_odm_slice_count(pipe_ctx);
+	int odm_slice_idx = resource_get_odm_slice_index(pipe_ctx);
 	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
 	int h_active = stream->timing.h_addressable +
 			stream->timing.h_border_left +
@@ -962,8 +902,8 @@ static struct rect calculate_mpc_slice_in_timing_active(
 		struct rect *plane_clip_rec)
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	int mpc_slice_count = resource_get_num_mpc_splits(pipe_ctx) + 1;
-	int mpc_slice_idx = resource_get_mpc_split_index(pipe_ctx);
+	int mpc_slice_count = resource_get_mpc_slice_count(pipe_ctx);
+	int mpc_slice_idx = resource_get_mpc_slice_index(pipe_ctx);
 	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
 	struct rect mpc_rec;
 
@@ -1699,7 +1639,7 @@ int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 
 		if (resource_is_pipe_type(cur_pipe, DPP_PIPE) &&
 				!resource_is_pipe_type(cur_pipe, OPP_HEAD) &&
-				resource_is_for_mpcc_combine(cur_pipe) &&
+				resource_get_mpc_slice_index(cur_pipe) > 0 &&
 				resource_is_pipe_type(new_pipe, FREE_PIPE)) {
 			free_pipe_idx = i;
 			break;
@@ -1763,14 +1703,9 @@ bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
 	}
 }
 
-bool resource_is_for_mpcc_combine(const struct pipe_ctx *pipe_ctx)
-{
-	return resource_get_num_mpc_splits(pipe_ctx) > 0;
-}
-
 struct pipe_ctx *resource_get_otg_master_for_stream(
 		struct resource_context *res_ctx,
-		struct dc_stream_state *stream)
+		const struct dc_stream_state *stream)
 {
 	int i;
 
@@ -1782,6 +1717,75 @@ struct pipe_ctx *resource_get_otg_master_for_stream(
 	return NULL;
 }
 
+int resource_get_opp_heads_for_otg_master(const struct pipe_ctx *otg_master,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *opp_heads[MAX_PIPES])
+{
+	struct pipe_ctx *opp_head = &res_ctx->pipe_ctx[otg_master->pipe_idx];
+	int i = 0;
+
+	if (!resource_is_pipe_type(otg_master, OTG_MASTER)) {
+		ASSERT(0);
+		return 0;
+	}
+	while (opp_head) {
+		ASSERT(i < MAX_PIPES);
+		opp_heads[i++] = opp_head;
+		opp_head = opp_head->next_odm_pipe;
+	}
+	return i;
+}
+
+int resource_get_dpp_pipes_for_opp_head(const struct pipe_ctx *opp_head,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES])
+{
+	struct pipe_ctx *pipe = &res_ctx->pipe_ctx[opp_head->pipe_idx];
+	int i = 0;
+
+	if (!resource_is_pipe_type(opp_head, OPP_HEAD)) {
+		ASSERT(0);
+		return 0;
+	}
+	while (pipe && resource_is_pipe_type(pipe, DPP_PIPE)) {
+		ASSERT(i < MAX_PIPES);
+		dpp_pipes[i++] = pipe;
+		pipe = pipe->bottom_pipe;
+	}
+	return i;
+}
+
+int resource_get_dpp_pipes_for_plane(const struct dc_plane_state *plane,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES])
+{
+	int i = 0, j;
+	struct pipe_ctx *pipe;
+
+	for (j = 0; j < MAX_PIPES; j++) {
+		pipe = &res_ctx->pipe_ctx[j];
+		if (pipe->plane_state == plane && pipe->prev_odm_pipe == NULL) {
+			if (resource_is_pipe_type(pipe, OPP_HEAD) ||
+					pipe->top_pipe->plane_state != plane)
+				break;
+		}
+	}
+
+	if (j < MAX_PIPES) {
+		if (pipe->next_odm_pipe)
+			while (pipe) {
+				dpp_pipes[i++] = pipe;
+				pipe = pipe->next_odm_pipe;
+			}
+		else
+			while (pipe && pipe->plane_state == plane) {
+				dpp_pipes[i++] = pipe;
+				pipe = pipe->bottom_pipe;
+			}
+	}
+	return i;
+}
+
 struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *otg_master = resource_get_opp_head(pipe_ctx);
@@ -1801,6 +1805,66 @@ struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx)
 	return opp_head;
 }
 
+int resource_get_mpc_slice_index(const struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
+	int index = 0;
+
+	while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
+		index++;
+		split_pipe = split_pipe->top_pipe;
+	}
+
+	return index;
+}
+
+int resource_get_mpc_slice_count(const struct pipe_ctx *pipe)
+{
+	int mpc_split_count = 1;
+	const struct pipe_ctx *other_pipe = pipe->bottom_pipe;
+
+	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
+		mpc_split_count++;
+		other_pipe = other_pipe->bottom_pipe;
+	}
+	other_pipe = pipe->top_pipe;
+	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
+		mpc_split_count++;
+		other_pipe = other_pipe->top_pipe;
+	}
+
+	return mpc_split_count;
+}
+
+int resource_get_odm_slice_count(const struct pipe_ctx *pipe)
+{
+	int odm_split_count = 1;
+
+	pipe = resource_get_otg_master(pipe);
+
+	while (pipe->next_odm_pipe) {
+		odm_split_count++;
+		pipe = pipe->next_odm_pipe;
+	}
+	return odm_split_count;
+}
+
+int resource_get_odm_slice_index(const struct pipe_ctx *pipe_ctx)
+{
+	int index = 0;
+
+	pipe_ctx = resource_get_opp_head(pipe_ctx);
+	if (!pipe_ctx)
+		return 0;
+
+	while (pipe_ctx->prev_odm_pipe) {
+		index++;
+		pipe_ctx = pipe_ctx->prev_odm_pipe;
+	}
+
+	return index;
+}
+
 static struct pipe_ctx *get_tail_pipe(
 		struct pipe_ctx *head_pipe)
 {
@@ -1902,97 +1966,265 @@ static int acquire_first_split_pipe(
 	return FREE_PIPE_INDEX_NOT_FOUND;
 }
 
-/* For each OPP head of an OTG master, add top plane at plane index 0.
- *
- * In the following example, the stream has 2 ODM slices without a top plane.
- * By adding a plane 0 to OPP heads, we are configuring our hardware to render
- * plane 0 by using each OPP head's DPP.
- *
- *       Inter-pipe Relation (Before Adding Plane)
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |               | slice 0   |             |
- *       |   0    |               |blank ----ODM----------- |
- *       |        |               | slice 1 | |             |
- *       |   1    |               |blank ---- |             |
- *       |________|_______________|___________|_____________|
- *
- *       Inter-pipe Relation (After Adding Plane)
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |  plane 0      | slice 0   |             |
- *       |   0    | -------------------------ODM----------- |
- *       |        |  plane 0      | slice 1 | |             |
- *       |   1    | ------------------------- |             |
- *       |________|_______________|___________|_____________|
- */
-static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
-		struct dc_plane_state *plane_state,
-		struct dc_state *context)
+static void update_stream_engine_usage(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct stream_encoder *stream_enc,
+		bool acquired)
 {
-	struct pipe_ctx *opp_head_pipe = otg_master_pipe;
+	int i;
 
-	while (opp_head_pipe) {
-		if (opp_head_pipe->plane_state) {
-			ASSERT(0);
-			return false;
-		}
-		opp_head_pipe->plane_state = plane_state;
-		opp_head_pipe = opp_head_pipe->next_odm_pipe;
+	for (i = 0; i < pool->stream_enc_count; i++) {
+		if (pool->stream_enc[i] == stream_enc)
+			res_ctx->is_stream_enc_acquired[i] = acquired;
 	}
+}
 
-	return true;
+static void update_hpo_dp_stream_engine_usage(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
+		bool acquired)
+{
+	int i;
+
+	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
+		if (pool->hpo_dp_stream_enc[i] == hpo_dp_stream_enc)
+			res_ctx->is_hpo_dp_stream_enc_acquired[i] = acquired;
+	}
 }
 
-/* For each OPP head of an OTG master, acquire a secondary DPP pipe and add
- * the plane. So the plane is added to all ODM slices associated with the OTG
- * master pipe in the bottom layer.
- *
- * In the following example, the stream has 2 ODM slices and a top plane 0.
- * By acquiring secondary DPP pipes and adding a plane 1, we are configuring our
- * hardware to render the plane 1 by acquiring a new pipe for each ODM slice and
- * render plane 1 using new pipes' DPP in the Z axis below plane 0.
- *
- *       Inter-pipe Relation (Before Adding Plane)
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |  plane 0      | slice 0   |             |
- *       |   0    | -------------------------ODM----------- |
- *       |        |  plane 0      | slice 1 | |             |
- *       |   1    | ------------------------- |             |
- *       |________|_______________|___________|_____________|
- *
- *       Inter-pipe Relation (After Acquiring and Adding Plane)
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |  plane 0      | slice 0   |             |
- *       |   0    | -------------MPC---------ODM----------- |
- *       |        |  plane 1    | |         | |             |
- *       |   2    | ------------- |         | |             |
- *       |        |  plane 0      | slice 1 | |             |
- *       |   1    | -------------MPC--------- |             |
- *       |        |  plane 1    | |           |             |
- *       |   3    | ------------- |           |             |
- *       |________|_______________|___________|_____________|
- */
-static bool acquire_secondary_dpp_pipes_and_add_plane(
-		struct pipe_ctx *otg_master_pipe,
-		struct dc_plane_state *plane_state,
-		struct dc_state *new_ctx,
-		struct dc_state *cur_ctx,
-		struct resource_pool *pool)
+static inline int find_acquired_hpo_dp_link_enc_for_link(
+		const struct resource_context *res_ctx,
+		const struct dc_link *link)
 {
-	struct pipe_ctx *opp_head_pipe, *sec_pipe, *tail_pipe;
+	int i;
 
-	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe)
-		return false;
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_to_link_idx); i++)
+		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] > 0 &&
+				res_ctx->hpo_dp_link_enc_to_link_idx[i] == link->link_index)
+			return i;
 
-	opp_head_pipe = otg_master_pipe;
-	while (opp_head_pipe) {
-		sec_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
-				cur_ctx,
-				new_ctx,
-				pool,
+	return -1;
+}
+
+static inline int find_free_hpo_dp_link_enc(const struct resource_context *res_ctx,
+		const struct resource_pool *pool)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts); i++)
+		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] == 0)
+			break;
+
+	return (i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts) &&
+			i < pool->hpo_dp_link_enc_count) ? i : -1;
+}
+
+static inline void acquire_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		unsigned int link_index,
+		int enc_index)
+{
+	res_ctx->hpo_dp_link_enc_to_link_idx[enc_index] = link_index;
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] = 1;
+}
+
+static inline void retain_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
+}
+
+static inline void release_hpo_dp_link_enc(
+		struct resource_context *res_ctx,
+		int enc_index)
+{
+	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
+	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
+}
+
+static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		retain_hpo_dp_link_enc(res_ctx, enc_index);
+	} else {
+		enc_index = find_free_hpo_dp_link_enc(res_ctx, pool);
+		if (enc_index >= 0)
+			acquire_hpo_dp_link_enc(res_ctx, stream->link->link_index, enc_index);
+	}
+
+	if (enc_index >= 0)
+		pipe_ctx->link_res.hpo_dp_link_enc = pool->hpo_dp_link_enc[enc_index];
+
+	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
+}
+
+static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	int enc_index;
+
+	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
+
+	if (enc_index >= 0) {
+		release_hpo_dp_link_enc(res_ctx, enc_index);
+		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
+	}
+}
+
+enum dc_status resource_add_otg_master_for_stream_output(struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	struct dc *dc = stream->ctx->dc;
+
+	return dc->res_pool->funcs->add_stream_to_ctx(dc, new_ctx, stream);
+}
+
+void resource_remove_otg_master_for_stream_output(struct dc_state *context,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+			&context->res_ctx, stream);
+
+	ASSERT(resource_get_odm_slice_count(otg_master) == 1);
+	ASSERT(otg_master->plane_state == NULL);
+	ASSERT(otg_master->stream_res.stream_enc);
+	update_stream_engine_usage(
+			&context->res_ctx,
+			pool,
+			otg_master->stream_res.stream_enc,
+			false);
+
+	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master)) {
+		update_hpo_dp_stream_engine_usage(
+			&context->res_ctx, pool,
+			otg_master->stream_res.hpo_dp_stream_enc,
+			false);
+		remove_hpo_dp_link_enc_from_ctx(
+				&context->res_ctx, otg_master, stream);
+	}
+	if (otg_master->stream_res.audio)
+		update_audio_usage(
+			&context->res_ctx,
+			pool,
+			otg_master->stream_res.audio,
+			false);
+
+	resource_unreference_clock_source(&context->res_ctx,
+					  pool,
+					  otg_master->clock_source);
+
+	if (pool->funcs->remove_stream_from_ctx)
+		pool->funcs->remove_stream_from_ctx(
+				stream->ctx->dc, context, stream);
+	memset(otg_master, 0, sizeof(*otg_master));
+}
+
+/* For each OPP head of an OTG master, add top plane at plane index 0.
+ *
+ * In the following example, the stream has 2 ODM slices without a top plane.
+ * By adding a plane 0 to OPP heads, we are configuring our hardware to render
+ * plane 0 by using each OPP head's DPP.
+ *
+ *       Inter-pipe Relation (Before Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |               | slice 0   |             |
+ *       |   0    |               |blank ----ODM----------- |
+ *       |        |               | slice 1 | |             |
+ *       |   1    |               |blank ---- |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------------------ODM----------- |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | ------------------------- |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
+		struct dc_plane_state *plane_state,
+		struct dc_state *context)
+{
+	struct pipe_ctx *opp_head_pipe = otg_master_pipe;
+
+	while (opp_head_pipe) {
+		if (opp_head_pipe->plane_state) {
+			ASSERT(0);
+			return false;
+		}
+		opp_head_pipe->plane_state = plane_state;
+		opp_head_pipe = opp_head_pipe->next_odm_pipe;
+	}
+
+	return true;
+}
+
+/* For each OPP head of an OTG master, acquire a secondary DPP pipe and add
+ * the plane. So the plane is added to all ODM slices associated with the OTG
+ * master pipe in the bottom layer.
+ *
+ * In the following example, the stream has 2 ODM slices and a top plane 0.
+ * By acquiring secondary DPP pipes and adding a plane 1, we are configuring our
+ * hardware to render the plane 1 by acquiring a new pipe for each ODM slice and
+ * render plane 1 using new pipes' DPP in the Z axis below plane 0.
+ *
+ *       Inter-pipe Relation (Before Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------------------ODM----------- |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | ------------------------- |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Acquiring and Adding Plane)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   2    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   1    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool acquire_secondary_dpp_pipes_and_add_plane(
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_plane_state *plane_state,
+		struct dc_state *new_ctx,
+		struct dc_state *cur_ctx,
+		struct resource_pool *pool)
+{
+	struct pipe_ctx *opp_head_pipe, *sec_pipe, *tail_pipe;
+
+	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe) {
+		ASSERT(0);
+		return false;
+	}
+
+	opp_head_pipe = otg_master_pipe;
+	while (opp_head_pipe) {
+		sec_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
+				cur_ctx,
+				new_ctx,
+				pool,
 				opp_head_pipe);
 		if (!sec_pipe) {
 			/* try tearing down MPCC combine */
@@ -2027,64 +2259,52 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 	return true;
 }
 
-/*
- * Acquire a pipe as OTG master and assign to the stream in new dc context.
- * return - true if OTG master pipe is acquired and new dc context is updated.
- * false if it fails to acquire an OTG master pipe for this stream.
- *
- * In the example below, we acquired pipe 0 as OTG master pipe for the stream.
- * After the function its Inter-pipe Relation is represented by the diagram
- * below.
- *
- *       Inter-pipe Relation
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |               |           |             |
- *       |   0    |               |blank ------------------ |
- *       |________|_______________|___________|_____________|
- */
-static bool acquire_otg_master_pipe_for_stream(
+bool resource_append_dpp_pipes_for_plane_composition(
 		struct dc_state *new_ctx,
+		struct dc_state *cur_ctx,
+		struct resource_pool *pool,
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_plane_state *plane_state)
+{
+	if (otg_master_pipe->plane_state == NULL)
+		return add_plane_to_opp_head_pipes(otg_master_pipe,
+				plane_state, new_ctx);
+	else
+		return acquire_secondary_dpp_pipes_and_add_plane(
+				otg_master_pipe, plane_state, new_ctx,
+				cur_ctx, pool);
+}
+
+void resource_remove_dpp_pipes_for_plane_composition(
+		struct dc_state *context,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
+		const struct dc_plane_state *plane_state)
 {
-	/* TODO: Move this function to DCN specific resource file and acquire
-	 * DSC resource here. The reason is that the function should have the
-	 * same level of responsibility as when we acquire secondary OPP head.
-	 * We acquire DSC when we acquire secondary OPP head, so we should
-	 * acquire DSC when we acquire OTG master.
-	 */
-	int pipe_idx;
-	struct pipe_ctx *pipe_ctx = NULL;
+	int i;
+	for (i = pool->pipe_count - 1; i >= 0; i--) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-	pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
-	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
-		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
-		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
-		pipe_ctx->pipe_idx = pipe_idx;
-		pipe_ctx->stream_res.tg = pool->timing_generators[pipe_idx];
-		pipe_ctx->plane_res.mi = pool->mis[pipe_idx];
-		pipe_ctx->plane_res.hubp = pool->hubps[pipe_idx];
-		pipe_ctx->plane_res.ipp = pool->ipps[pipe_idx];
-		pipe_ctx->plane_res.xfm = pool->transforms[pipe_idx];
-		pipe_ctx->plane_res.dpp = pool->dpps[pipe_idx];
-		pipe_ctx->stream_res.opp = pool->opps[pipe_idx];
-		if (pool->dpps[pipe_idx])
-			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+		if (pipe_ctx->plane_state == plane_state) {
+			if (pipe_ctx->top_pipe)
+				pipe_ctx->top_pipe->bottom_pipe = pipe_ctx->bottom_pipe;
 
-		if (pipe_idx >= pool->timing_generator_count) {
-			int tg_inst = pool->timing_generator_count - 1;
+			/* Second condition is to avoid setting NULL to top pipe
+			 * of tail pipe making it look like head pipe in subsequent
+			 * deletes
+			 */
+			if (pipe_ctx->bottom_pipe && pipe_ctx->top_pipe)
+				pipe_ctx->bottom_pipe->top_pipe = pipe_ctx->top_pipe;
 
-			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-			pipe_ctx->stream_res.opp = pool->opps[tg_inst];
+			/*
+			 * For head pipe detach surfaces from pipe for tail
+			 * pipe just zero it out
+			 */
+			if (!pipe_ctx->top_pipe)
+				pipe_ctx->plane_state = NULL;
+			else
+				memset(pipe_ctx, 0, sizeof(*pipe_ctx));
 		}
-
-		pipe_ctx->stream = stream;
-	} else {
-		pipe_idx = acquire_first_split_pipe(&new_ctx->res_ctx, pool, stream);
 	}
-
-	return pipe_idx != FREE_PIPE_INDEX_NOT_FOUND;
 }
 
 /*
@@ -2127,12 +2347,17 @@ static bool acquire_pipes_and_add_odm_slice(
 		const struct resource_pool *pool)
 {
 	struct pipe_ctx *last_opp_head = get_last_opp_head(otg_master_pipe);
-	struct pipe_ctx *new_opp_head = pool->funcs->acquire_free_pipe_as_secondary_opp_head(
-					cur_ctx, new_ctx, pool,
-					otg_master_pipe);
+	struct pipe_ctx *new_opp_head;
 	struct pipe_ctx *last_top_dpp_pipe, *last_bottom_dpp_pipe,
 			*new_top_dpp_pipe, *new_bottom_dpp_pipe;
 
+	if (!pool->funcs->acquire_free_pipe_as_secondary_opp_head) {
+		ASSERT(0);
+		return false;
+	}
+	new_opp_head = pool->funcs->acquire_free_pipe_as_secondary_opp_head(
+					cur_ctx, new_ctx, pool,
+					otg_master_pipe);
 	if (!new_opp_head)
 		return false;
 
@@ -2203,6 +2428,11 @@ static bool release_pipes_and_remove_odm_slice(
 	struct pipe_ctx *last_opp_head = get_last_opp_head(otg_master_pipe);
 	struct pipe_ctx *tail_pipe = get_tail_pipe(last_opp_head);
 
+	if (!pool->funcs->release_pipe) {
+		ASSERT(0);
+		return false;
+	}
+
 	if (resource_is_pipe_type(last_opp_head, OTG_MASTER))
 		return false;
 
@@ -2258,10 +2488,15 @@ static bool acquire_dpp_pipe_and_add_mpc_slice(
 	struct pipe_ctx *last_dpp_pipe =
 			get_last_dpp_pipe_in_mpcc_combine(dpp_pipe);
 	struct pipe_ctx *opp_head = resource_get_opp_head(dpp_pipe);
-	struct pipe_ctx *new_dpp_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
-			cur_ctx, new_ctx, pool, opp_head);
+	struct pipe_ctx *new_dpp_pipe;
 
-	if (!new_dpp_pipe || resource_get_num_odm_splits(dpp_pipe) > 0)
+	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe) {
+		ASSERT(0);
+		return false;
+	}
+	new_dpp_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
+			cur_ctx, new_ctx, pool, opp_head);
+	if (!new_dpp_pipe || resource_get_odm_slice_count(dpp_pipe) > 1)
 		return false;
 
 	new_dpp_pipe->bottom_pipe = last_dpp_pipe->bottom_pipe;
@@ -2315,8 +2550,13 @@ static bool release_dpp_pipe_and_remove_mpc_slice(
 	struct pipe_ctx *last_dpp_pipe =
 			get_last_dpp_pipe_in_mpcc_combine(dpp_pipe);
 
+	if (!pool->funcs->release_pipe) {
+		ASSERT(0);
+		return false;
+	}
+
 	if (resource_is_pipe_type(last_dpp_pipe, OPP_HEAD) ||
-			resource_get_num_odm_splits(dpp_pipe) > 0)
+			resource_get_odm_slice_count(dpp_pipe) > 1)
 		return false;
 
 	last_dpp_pipe->top_pipe->bottom_pipe = last_dpp_pipe->bottom_pipe;
@@ -2327,15 +2567,17 @@ static bool release_dpp_pipe_and_remove_mpc_slice(
 	return true;
 }
 
-bool resource_update_pipes_with_odm_slice_count(
-		struct pipe_ctx *otg_master,
+bool resource_update_pipes_for_stream_with_slice_count(
 		struct dc_state *new_ctx,
 		const struct dc_state *cur_ctx,
 		const struct resource_pool *pool,
+		const struct dc_stream_state *stream,
 		int new_slice_count)
 {
 	int i;
-	int cur_slice_count = resource_get_num_odm_splits(otg_master) + 1;
+	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+			&new_ctx->res_ctx, stream);
+	int cur_slice_count = resource_get_odm_slice_count(otg_master);
 	bool result = true;
 
 	if (new_slice_count == cur_slice_count)
@@ -2355,31 +2597,38 @@ bool resource_update_pipes_with_odm_slice_count(
 	return result;
 }
 
-bool resource_update_pipes_with_mpc_slice_count(
-		struct pipe_ctx *dpp_pipe,
+bool resource_update_pipes_for_plane_with_slice_count(
 		struct dc_state *new_ctx,
 		const struct dc_state *cur_ctx,
 		const struct resource_pool *pool,
+		const struct dc_plane_state *plane,
 		int new_slice_count)
 {
 	int i;
-	int cur_slice_count = resource_get_num_mpc_splits(dpp_pipe) + 1;
+	int dpp_pipe_count;
+	int cur_slice_count;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 	bool result = true;
 
+	dpp_pipe_count = resource_get_dpp_pipes_for_plane(plane,
+			&new_ctx->res_ctx, dpp_pipes);
+	ASSERT(dpp_pipe_count > 0);
+	cur_slice_count = resource_get_mpc_slice_count(dpp_pipes[0]);
+
 	if (new_slice_count == cur_slice_count)
 		return result;
 
 	if (new_slice_count > cur_slice_count)
 		for (i = 0; i < new_slice_count - cur_slice_count && result; i++)
 			result = acquire_dpp_pipe_and_add_mpc_slice(
-					dpp_pipe, new_ctx, cur_ctx, pool);
+					dpp_pipes[0], new_ctx, cur_ctx, pool);
 	else
 		for (i = 0; i < cur_slice_count - new_slice_count && result; i++)
 			result = release_dpp_pipe_and_remove_mpc_slice(
-					dpp_pipe, new_ctx, pool);
+					dpp_pipes[0], new_ctx, pool);
 	if (result)
 		result = update_pipe_params_after_mpc_slice_count_change(
-				dpp_pipe->plane_state, new_ctx, pool);
+				dpp_pipes[0]->plane_state, new_ctx, pool);
 	return result;
 }
 
@@ -2406,13 +2655,9 @@ bool dc_add_plane_to_context(
 
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&context->res_ctx, stream);
-	if (otg_master_pipe->plane_state == NULL)
-		added = add_plane_to_opp_head_pipes(otg_master_pipe,
-				plane_state, context);
-	else
-		added = acquire_secondary_dpp_pipes_and_add_plane(
-				otg_master_pipe, plane_state, context,
-				dc->current_state, pool);
+	added = resource_append_dpp_pipes_for_plane_composition(context,
+			dc->current_state, pool, otg_master_pipe, plane_state);
+
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =
 				plane_state;
@@ -2448,32 +2693,8 @@ bool dc_remove_plane_from_context(
 		return false;
 	}
 
-	/* release pipe for plane*/
-	for (i = pool->pipe_count - 1; i >= 0; i--) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe_ctx->plane_state == plane_state) {
-			if (pipe_ctx->top_pipe)
-				pipe_ctx->top_pipe->bottom_pipe = pipe_ctx->bottom_pipe;
-
-			/* Second condition is to avoid setting NULL to top pipe
-			 * of tail pipe making it look like head pipe in subsequent
-			 * deletes
-			 */
-			if (pipe_ctx->bottom_pipe && pipe_ctx->top_pipe)
-				pipe_ctx->bottom_pipe->top_pipe = pipe_ctx->top_pipe;
-
-			/*
-			 * For head pipe detach surfaces from pipe for tail
-			 * pipe just zero it out
-			 */
-			if (!pipe_ctx->top_pipe)
-				pipe_ctx->plane_state = NULL;
-			else
-				memset(pipe_ctx, 0, sizeof(*pipe_ctx));
-		}
-	}
-
+	resource_remove_dpp_pipes_for_plane_composition(
+			context, pool, plane_state);
 
 	for (i = 0; i < stream_status->plane_count; i++) {
 		if (stream_status->plane_states[i] == plane_state) {
@@ -2672,122 +2893,6 @@ bool dc_is_stream_scaling_unchanged(struct dc_stream_state *old_stream,
 	return true;
 }
 
-static void update_stream_engine_usage(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		struct stream_encoder *stream_enc,
-		bool acquired)
-{
-	int i;
-
-	for (i = 0; i < pool->stream_enc_count; i++) {
-		if (pool->stream_enc[i] == stream_enc)
-			res_ctx->is_stream_enc_acquired[i] = acquired;
-	}
-}
-
-static void update_hpo_dp_stream_engine_usage(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
-		bool acquired)
-{
-	int i;
-
-	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
-		if (pool->hpo_dp_stream_enc[i] == hpo_dp_stream_enc)
-			res_ctx->is_hpo_dp_stream_enc_acquired[i] = acquired;
-	}
-}
-
-static inline int find_acquired_hpo_dp_link_enc_for_link(
-		const struct resource_context *res_ctx,
-		const struct dc_link *link)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_to_link_idx); i++)
-		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] > 0 &&
-				res_ctx->hpo_dp_link_enc_to_link_idx[i] == link->link_index)
-			return i;
-
-	return -1;
-}
-
-static inline int find_free_hpo_dp_link_enc(const struct resource_context *res_ctx,
-		const struct resource_pool *pool)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts); i++)
-		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] == 0)
-			break;
-
-	return (i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts) &&
-			i < pool->hpo_dp_link_enc_count) ? i : -1;
-}
-
-static inline void acquire_hpo_dp_link_enc(
-		struct resource_context *res_ctx,
-		unsigned int link_index,
-		int enc_index)
-{
-	res_ctx->hpo_dp_link_enc_to_link_idx[enc_index] = link_index;
-	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] = 1;
-}
-
-static inline void retain_hpo_dp_link_enc(
-		struct resource_context *res_ctx,
-		int enc_index)
-{
-	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
-}
-
-static inline void release_hpo_dp_link_enc(
-		struct resource_context *res_ctx,
-		int enc_index)
-{
-	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
-	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
-}
-
-static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_stream_state *stream)
-{
-	int enc_index;
-
-	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
-
-	if (enc_index >= 0) {
-		retain_hpo_dp_link_enc(res_ctx, enc_index);
-	} else {
-		enc_index = find_free_hpo_dp_link_enc(res_ctx, pool);
-		if (enc_index >= 0)
-			acquire_hpo_dp_link_enc(res_ctx, stream->link->link_index, enc_index);
-	}
-
-	if (enc_index >= 0)
-		pipe_ctx->link_res.hpo_dp_link_enc = pool->hpo_dp_link_enc[enc_index];
-
-	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
-}
-
-static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_stream_state *stream)
-{
-	int enc_index;
-
-	enc_index = find_acquired_hpo_dp_link_enc_for_link(res_ctx, stream->link);
-
-	if (enc_index >= 0) {
-		release_hpo_dp_link_enc(res_ctx, enc_index);
-		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
-	}
-}
-
 /* TODO: release audio object */
 void update_audio_usage(
 		struct resource_context *res_ctx,
@@ -2872,7 +2977,8 @@ enum dc_status dc_add_stream_to_ctx(
 	dc_stream_retain(stream);
 	new_ctx->stream_count++;
 
-	res = dc->res_pool->funcs->add_stream_to_ctx(dc, new_ctx, stream);
+	res = resource_add_otg_master_for_stream_output(
+			new_ctx, dc->res_pool, stream);
 	if (res != DC_OK)
 		DC_LOG_WARNING("Adding stream %p to context failed with err %d!\n", stream, res);
 
@@ -2889,53 +2995,18 @@ enum dc_status dc_remove_stream_from_ctx(
 {
 	int i;
 	struct dc_context *dc_ctx = dc->ctx;
-	struct pipe_ctx *del_pipe = resource_get_otg_master_for_stream(&new_ctx->res_ctx, stream);
-	struct pipe_ctx *odm_pipe;
+	struct pipe_ctx *del_pipe = resource_get_otg_master_for_stream(
+			&new_ctx->res_ctx, stream);
 
 	if (!del_pipe) {
 		DC_ERROR("Pipe not found for stream %p !\n", stream);
 		return DC_ERROR_UNEXPECTED;
 	}
 
-	odm_pipe = del_pipe->next_odm_pipe;
-
-	/* Release primary pipe */
-	ASSERT(del_pipe->stream_res.stream_enc);
-	update_stream_engine_usage(
-			&new_ctx->res_ctx,
-				dc->res_pool,
-			del_pipe->stream_res.stream_enc,
-			false);
-
-	if (dc->link_srv->dp_is_128b_132b_signal(del_pipe)) {
-		update_hpo_dp_stream_engine_usage(
-			&new_ctx->res_ctx, dc->res_pool,
-			del_pipe->stream_res.hpo_dp_stream_enc,
-			false);
-		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
-	}
-
-	if (del_pipe->stream_res.audio)
-		update_audio_usage(
-			&new_ctx->res_ctx,
-			dc->res_pool,
-			del_pipe->stream_res.audio,
-			false);
-
-	resource_unreference_clock_source(&new_ctx->res_ctx,
-					  dc->res_pool,
-					  del_pipe->clock_source);
-
-	if (dc->res_pool->funcs->remove_stream_from_ctx)
-		dc->res_pool->funcs->remove_stream_from_ctx(dc, new_ctx, stream);
-
-	while (odm_pipe) {
-		struct pipe_ctx *next_odm_pipe = odm_pipe->next_odm_pipe;
-
-		memset(odm_pipe, 0, sizeof(*odm_pipe));
-		odm_pipe = next_odm_pipe;
-	}
-	memset(del_pipe, 0, sizeof(*del_pipe));
+	resource_update_pipes_for_stream_with_slice_count(new_ctx,
+			dc->current_state, dc->res_pool, stream, 1);
+	resource_remove_otg_master_for_stream_output(
+			new_ctx, dc->res_pool, stream);
 
 	for (i = 0; i < new_ctx->stream_count; i++)
 		if (new_ctx->streams[i] == stream)
@@ -3154,6 +3225,66 @@ static void mark_seamless_boot_stream(
 	}
 }
 
+/*
+ * Acquire a pipe as OTG master and assign to the stream in new dc context.
+ * return - true if OTG master pipe is acquired and new dc context is updated.
+ * false if it fails to acquire an OTG master pipe for this stream.
+ *
+ * In the example below, we acquired pipe 0 as OTG master pipe for the stream.
+ * After the function its Inter-pipe Relation is represented by the diagram
+ * below.
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |               |           |             |
+ *       |   0    |               |blank ------------------ |
+ *       |________|_______________|___________|_____________|
+ */
+static bool acquire_otg_master_pipe_for_stream(
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	/* TODO: Move this function to DCN specific resource file and acquire
+	 * DSC resource here. The reason is that the function should have the
+	 * same level of responsibility as when we acquire secondary OPP head.
+	 * We acquire DSC when we acquire secondary OPP head, so we should
+	 * acquire DSC when we acquire OTG master.
+	 */
+	int pipe_idx;
+	struct pipe_ctx *pipe_ctx = NULL;
+
+	pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
+	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
+		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
+		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
+		pipe_ctx->pipe_idx = pipe_idx;
+		pipe_ctx->stream_res.tg = pool->timing_generators[pipe_idx];
+		pipe_ctx->plane_res.mi = pool->mis[pipe_idx];
+		pipe_ctx->plane_res.hubp = pool->hubps[pipe_idx];
+		pipe_ctx->plane_res.ipp = pool->ipps[pipe_idx];
+		pipe_ctx->plane_res.xfm = pool->transforms[pipe_idx];
+		pipe_ctx->plane_res.dpp = pool->dpps[pipe_idx];
+		pipe_ctx->stream_res.opp = pool->opps[pipe_idx];
+		if (pool->dpps[pipe_idx])
+			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+
+		if (pipe_idx >= pool->timing_generator_count) {
+			int tg_inst = pool->timing_generator_count - 1;
+
+			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
+			pipe_ctx->stream_res.opp = pool->opps[tg_inst];
+		}
+
+		pipe_ctx->stream = stream;
+	} else {
+		pipe_idx = acquire_first_split_pipe(&new_ctx->res_ctx, pool, stream);
+	}
+
+	return pipe_idx != FREE_PIPE_INDEX_NOT_FOUND;
+}
+
 enum dc_status resource_map_pool_resources(
 		const struct dc  *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f3db16cd10db..347156d02f21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -614,6 +614,8 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	memset(&pipe_ctx->plane_res, 0, sizeof(pipe_ctx->plane_res));
 	pipe_ctx->top_pipe = NULL;
 	pipe_ctx->bottom_pipe = NULL;
+	pipe_ctx->prev_odm_pipe = NULL;
+	pipe_ctx->next_odm_pipe = NULL;
 	pipe_ctx->plane_state = NULL;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d587f807dfd7..2820393d5c6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1948,7 +1948,7 @@ int dcn20_validate_apply_pipe_split_flags(
 			v->ODMCombineEnablePerState[vlevel][pipe_plane];
 
 		if (v->ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
-			if (resource_get_num_mpc_splits(pipe) == 1) {
+			if (resource_get_mpc_slice_count(pipe) == 2) {
 				/*If need split for mpc but 2 way split already*/
 				if (split[i] == 4)
 					split[i] = 2; /* 2 -> 4 MPC */
@@ -1956,7 +1956,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					split[i] = 0; /* 2 -> 2 MPC */
 				else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state)
 					merge[i] = true; /* 2 -> 1 MPC */
-			} else if (resource_get_num_mpc_splits(pipe) == 3) {
+			} else if (resource_get_mpc_slice_count(pipe) == 4) {
 				/*If need split for mpc but 4 way split already*/
 				if (split[i] == 2 && ((pipe->top_pipe && !pipe->top_pipe->top_pipe)
 						|| !pipe->bottom_pipe)) {
@@ -1965,7 +1965,7 @@ int dcn20_validate_apply_pipe_split_flags(
 						pipe->top_pipe->plane_state == pipe->plane_state)
 					merge[i] = true; /* 4 -> 1 MPC */
 				split[i] = 0;
-			} else if (resource_get_num_odm_splits(pipe)) {
+			} else if (resource_get_odm_slice_count(pipe) > 1) {
 				/* ODM -> MPC transition */
 				if (pipe->prev_odm_pipe) {
 					split[i] = 0;
@@ -1973,7 +1973,7 @@ int dcn20_validate_apply_pipe_split_flags(
 				}
 			}
 		} else {
-			if (resource_get_num_odm_splits(pipe) == 1) {
+			if (resource_get_odm_slice_count(pipe) == 2) {
 				/*If need split for odm but 2 way split already*/
 				if (split[i] == 4)
 					split[i] = 2; /* 2 -> 4 ODM */
@@ -1983,7 +1983,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					ASSERT(0); /* NOT expected yet */
 					merge[i] = true; /* exit ODM */
 				}
-			} else if (resource_get_num_odm_splits(pipe) == 3) {
+			} else if (resource_get_odm_slice_count(pipe) == 4) {
 				/*If need split for odm but 4 way split already*/
 				if (split[i] == 2 && ((pipe->prev_odm_pipe && !pipe->prev_odm_pipe->prev_odm_pipe)
 						|| !pipe->next_odm_pipe)) {
@@ -1993,7 +1993,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					merge[i] = true; /* exit ODM */
 				}
 				split[i] = 0;
-			} else if (resource_get_num_mpc_splits(pipe)) {
+			} else if (resource_get_mpc_slice_count(pipe) > 1) {
 				/* MPC -> ODM transition */
 				ASSERT(0); /* NOT expected yet */
 				if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
@@ -2211,12 +2211,22 @@ enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_stat
 	return DC_OK;
 }
 
+void dcn20_release_pipe(struct dc_state *context,
+			struct pipe_ctx *pipe,
+			const struct resource_pool *pool)
+{
+	if (resource_is_pipe_type(pipe, OPP_HEAD) && pipe->stream_res.dsc)
+		dcn20_release_dsc(&context->res_ctx, pool, &pipe->stream_res.dsc);
+	memset(pipe, 0, sizeof(*pipe));
+}
+
 static const struct resource_funcs dcn20_res_pool_funcs = {
 	.destroy = dcn20_destroy_resource_pool,
 	.link_enc_create = dcn20_link_encoder_create,
 	.panel_cntl_create = dcn20_panel_cntl_create,
 	.validate_bandwidth = dcn20_validate_bandwidth,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn20_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 6d1a8924e57b..37ecaccc5d12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -63,7 +63,9 @@ struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe);
-
+void dcn20_release_pipe(struct dc_state *context,
+			struct pipe_ctx *pipe,
+			const struct resource_pool *pool);
 struct stream_encoder *dcn20_stream_encoder_create(
 	enum engine_id eng_id,
 	struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 2dc4d2c1410b..9389bd8df42b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -1069,6 +1069,7 @@ static struct resource_funcs dcn201_res_pool_funcs = {
 	.add_dsc_to_stream_resource = NULL,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn201_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.populate_dml_writeback_from_context = dcn201_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d1a25fe6c44f..71e82692dd7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1389,6 +1389,7 @@ static const struct resource_funcs dcn21_res_pool_funcs = {
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn21_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 88c0b24a3249..da56962227fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2217,6 +2217,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 79d6697d13b6..c489ad043b87 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1380,6 +1380,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 447abcd593be..f5b8b92a84f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1137,6 +1137,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 		.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+		.release_pipe = dcn20_release_pipe,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index adf4989177f7..d59561605c17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1063,6 +1063,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 		.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+		.release_pipe = dcn20_release_pipe,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 		.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 		.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 82de4fe2637f..994289b3d5a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1824,6 +1824,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn31_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 004beed9bd44..4d0052ca742f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1796,6 +1796,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn314_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 127487ea3d7d..8e3acb92385b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1819,6 +1819,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn315_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn315_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 5fe2c61527df..9133a1ea4ca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1706,6 +1706,7 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn316_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 072c5ba4c99c..88c9dbbacbd3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2040,7 +2040,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
 	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
-	.release_pipe = dcn32_release_pipe,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
@@ -2778,15 +2778,6 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 	return free_pipe;
 }
 
-void dcn32_release_pipe(struct dc_state *context,
-			struct pipe_ctx *pipe,
-			const struct resource_pool *pool)
-{
-	if (resource_is_pipe_type(pipe, OPP_HEAD) && pipe->stream_res.dsc)
-		dcn20_release_dsc(&context->res_ctx, pool, &pipe->stream_res.dsc);
-	memset(pipe, 0, sizeof(*pipe));
-}
-
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans)
 {
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 8d73cceb485b..7d40fb6156f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1589,6 +1589,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
+	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 8afda5ecc0cd..0989a0152ae8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1305,11 +1305,11 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 		pipes[pipe_cnt].dout.is_virtual = 0;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
-		switch (resource_get_num_odm_splits(&res_ctx->pipe_ctx[i])) {
-		case 1:
+		switch (resource_get_odm_slice_count(&res_ctx->pipe_ctx[i])) {
+		case 2:
 			pipes[pipe_cnt].pipe.dest.odm_combine = dm_odm_combine_mode_2to1;
 			break;
-		case 3:
+		case 4:
 			pipes[pipe_cnt].pipe.dest.odm_combine = dm_odm_combine_mode_4to1;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 4344c5a239e1..55efd5600521 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -238,8 +238,8 @@ enum pipe_type {
 
 	/* OTG master pipe - the master pipe of its OPP head pipes with a
 	 * functional OTG. It merges all its OPP head pipes pixel data in ODM
-	 * block and output to backend DIG. OTG master pipe is responsible for
-	 * generating entire crtc timing to backend DIG. An OTG master pipe may
+	 * block and output to back end DIG. OTG master pipe is responsible for
+	 * generating entire CRTC timing to back end DIG. An OTG master pipe may
 	 * or may not have a plane. If it has a plane it blends it as the left
 	 * most MPC slice of the top most layer. If it doesn't have a plane it
 	 * can output pixel data from its OPP head pipes' test pattern
@@ -267,33 +267,175 @@ enum pipe_type {
 };
 
 /*
- * Determine if the input pipe ctx is of a pipe type.
- * return - true if pipe ctx is of the input type.
+ * Determine if the input pipe_ctx is of a pipe type.
+ * return - true if pipe_ctx is of the input type.
  */
 bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type);
 
 /*
- * Determine if the input pipe ctx is used for rendering a plane with MPCC
- * combine. MPCC combine is a hardware feature to combine multiple DPP pipes
- * into a single plane. It is typically used for bypassing pipe bandwidth
- * limitation for rendering a very large plane or saving power by reducing UCLK
- * and DPPCLK speeds.
+ * Acquire a pipe as OTG master pipe and allocate pipe resources required to
+ * enable stream output.
+ */
+enum dc_status resource_add_otg_master_for_stream_output(struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream);
+
+/*
+ * Release pipe resources and the OTG master pipe associated with the stream
+ * The stream must have all planes removed and ODM/MPC slice counts are reset
+ * to 1 before invoking this interface.
+ */
+void resource_remove_otg_master_for_stream_output(struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream);
+
+/*
+ * Add plane to the bottom most layer in plane composition and allocate DPP pipe
+ * resources as needed.
+ * return - true if plane is added in plane composition, false otherwise.
+ */
+bool resource_append_dpp_pipes_for_plane_composition(
+		struct dc_state *new_ctx,
+		struct dc_state *cur_ctx,
+		struct resource_pool *pool,
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_plane_state *plane_state);
+
+/*
+ * Add plane to the bottom most layer in plane composition and allocate DPP pipe
+ * resources as needed.
+ * return - true if plane is added in plane composition, false otherwise.
+ */
+void resource_remove_dpp_pipes_for_plane_composition(
+		struct dc_state *context,
+		const struct resource_pool *pool,
+		const struct dc_plane_state *plane_state);
+
+/*
+ * Update ODM slice count by acquiring or releasing pipes. If new slices need
+ * to be added, it is going to add them to the last ODM index. If existing
+ * slices need to be removed, it is going to remove them from the last ODM
+ * index.
  *
- * For instance in the Inter-pipe Relation diagram shown below, both PIPE 0 and
- * 1 are for MPCC combine for plane 0
+ * return - true if ODM slices are updated and required pipes are acquired. All
+ * affected pipe parameters are updated.
  *
- *       Inter-pipe Relation
- *        __________________________________________________
- *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
- *       |        |  plane 0      |           |             |
- *       |   0    | -------------MPC----------------------- |
- *       |        |  plane 0    | |           |             |
- *       |   1    | ------------- |           |             |
- *       |________|_______________|___________|_____________|
+ * false if resource fails to complete this update. The function is not designed
+ * to recover the creation of invalid topologies. Returning false is typically
+ * an indication of insufficient validation in caller's stack. new_ctx will be
+ * invalid. Caller may attempt to restore new_ctx by calling this function
+ * again with original slice count.
+ */
+bool resource_update_pipes_for_stream_with_slice_count(
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		const struct dc_stream_state *stream,
+		int new_slice_count);
+
+/*
+ * Update MPC slice count by acquiring or releasing DPP pipes. If new slices
+ * need to be added it is going to add to the last MPC index. If existing
+ * slices need to be removed, it is going to remove them from the last MPC
+ * index.
+ *
+ * @dpp_pipe - top most dpp pipe for MPCC combine.
+ *
+ * return - true if MPC slices are updated and required pipes are acquired. All
+ * affected pipe parameters are updated.
  *
- * return - true if pipe ctx is used for mpcc combine.
+ * false if resource fails to complete this update. The function is not designed
+ * to recover the creation of invalid topologies. Returning false is typically
+ * an indication of insufficient validation in caller's stack. new_ctx will be
+ * invalid. Caller may attempt to restore new_ctx by calling this function
+ * again with original slice count.
+ */
+bool resource_update_pipes_for_plane_with_slice_count(
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		const struct dc_plane_state *plane,
+		int slice_count);
+
+/*
+ * Get the OTG master pipe in resource context associated with the stream.
+ * return - NULL if not found. Otherwise the OTG master pipe associated with the
+ * stream.
+ */
+struct pipe_ctx *resource_get_otg_master_for_stream(
+		struct resource_context *res_ctx,
+		const struct dc_stream_state *stream);
+
+/*
+ * Get an array of OPP heads in opp_heads ordered with index low to high for OTG
+ * master pipe in res_ctx.
+ * return - number of OPP heads in the array. If otg_master passed in is not
+ * an OTG master, the function returns 0.
+ */
+int resource_get_opp_heads_for_otg_master(const struct pipe_ctx *otg_master,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *opp_heads[MAX_PIPES]);
+
+/*
+ * Get an array of DPP pipes in dpp_pipes ordered with index low to high for OPP
+ * head pipe in res_ctx.
+ * return - number of DPP pipes in the array. If opp_head passed in is not
+ * an OPP pipe, the function returns 0.
+ */
+int resource_get_dpp_pipes_for_opp_head(const struct pipe_ctx *opp_head,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES]);
+
+/*
+ * Get an array of DPP pipes in dpp_pipes ordered with index low to high for
+ * plane in res_ctx.
+ * return - number of DPP pipes in the array.
+ */
+int resource_get_dpp_pipes_for_plane(const struct dc_plane_state *plane,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES]);
+
+/*
+ * Get the OTG master pipe for the input pipe context.
+ * return - the OTG master pipe for the input pipe
+ * context.
+ */
+struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx);
+
+/*
+ * Get the OPP head pipe for the input pipe context.
+ * return - the OPP head pipe for the input pipe
+ * context.
+ */
+struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx);
+
+/*
+ * Get the MPC slice index counting from 0 from left most slice
+ * For example, if a DPP pipe is used as a secondary pipe in MPCC combine, MPC
+ * split index is greater than 0.
+ */
+int resource_get_mpc_slice_index(const struct pipe_ctx *dpp_pipe);
+
+/*
+ * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
+ * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
+ * will have 4 pieces of slice.
+ * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
+ * the number of MPC "cuts" for the plane.
+ */
+int resource_get_mpc_slice_count(const struct pipe_ctx *opp_head);
+
+/*
+ * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
+ * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
+ * will have 4 pieces of slice.
+ * return - 0 if pipe is not used for ODM combine. otherwise
+ * the number of ODM "cuts" for the timing.
  */
-bool resource_is_for_mpcc_combine(const struct pipe_ctx *pipe_ctx);
+int resource_get_odm_slice_count(const struct pipe_ctx *otg_master);
+
+/* Get the ODM slice index counting from 0 from left most slice */
+int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
 
 /*
  * Look for a free pipe in new resource context that is used as a secondary OPP
@@ -360,100 +502,6 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe);
 
-/*
- * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
- * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
- * the number of MPC "cuts" for the plane.
- */
-int resource_get_num_mpc_splits(const struct pipe_ctx *pipe);
-
-int resource_get_mpc_split_index(struct pipe_ctx *pipe_ctx);
-
-
-/*
- * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
- * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
- * will have 4 pieces of slice.
- * return - 0 if pipe is not used for ODM combine. otherwise
- * the number of ODM "cuts" for the timing.
- */
-int resource_get_num_odm_splits(const struct pipe_ctx *pipe);
-
-int resource_get_odm_split_index(struct pipe_ctx *pipe_ctx);
-
-/*
- * Get the OTG master pipe in resource context associated with the stream.
- * return - NULL if not found. Otherwise the OTG master pipe associated with the
- * stream.
- */
-struct pipe_ctx *resource_get_otg_master_for_stream(
-		struct resource_context *res_ctx,
-		struct dc_stream_state *stream);
-
-/*
- * Get the OTG master pipe for the input pipe context.
- * return - the OTG master pipe for the input pipe
- * context.
- */
-struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx);
-
-/*
- * Get the OPP head pipe for the input pipe context.
- * return - the OPP head pipe for the input pipe
- * context.
- */
-struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx);
-
-/*
- * Update ODM slice count by acquiring or releasing pipes. If new slices need
- * to be added, it is going to add them to the last ODM index. If existing
- * slices need to be removed, it is going to remove them from the last ODM
- * index.
- *
- * return - true if ODM slices are updated and required pipes are acquired. All
- * affected pipe parameters are updated.
- *
- * false if resource fails to complete this update. The function is not designed
- * to recover the creation of invalid topologies. Returning false is typically
- * an indication of insufficient validation in caller's stack. The function will
- * return the new_ctx up until the last valid step performed in the function.
- * Caller may use the returned new_ctx for debugging the error or it may attempt
- * to restore new_ctx by calling this function again with original slice count.
- */
-bool resource_update_pipes_with_odm_slice_count(
-		struct pipe_ctx *otg_master_pipe,
-		struct dc_state *new_ctx,
-		const struct dc_state *cur_ctx,
-		const struct resource_pool *pool,
-		int slice_count);
-
-/*
- * Update MPC slice count by acquiring or releasing DPP pipes. If new slices
- * need to be added it is going to add to the last MPC index. If existing
- * slices need to be removed, it is going to remove them from the last MPC
- * index.
- *
- * @dpp_pipe - top most dpp pipe for MPCC combine.
- *
- * return - true if MPC slices are updated and required pipes are acquired. All
- * affected pipe parameters are updated.
- *
- * false if resource fails to complete this update. The function is not designed
- * to recover the creation of invalid topologies. Returning false is typically
- * an indication of insufficient validation in caller's stack. The function will
- * return the new_ctx up until the last valid step performed in the function.
- * Caller may use the returned new_ctx for debugging the error or it may attempt
- * to restore new_ctx by calling this function again with original slice count.
- */
-bool resource_update_pipes_with_mpc_slice_count(
-		struct pipe_ctx *dpp_pipe,
-		struct dc_state *new_ctx,
-		const struct dc_state *cur_ctx,
-		const struct resource_pool *pool,
-		int slice_count);
-
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
 		int set_count,
-- 
2.41.0

