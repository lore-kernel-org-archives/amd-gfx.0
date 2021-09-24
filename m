Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1FBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877F4610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 877F4610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121366E219;
	Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3A96E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzKvtWcj8QOGbIIO1g9PM6lQDQz5u1ZH9kkaSvPUaNz8PwGz3eEOeKcGSepBg1u+xGOoOhuk0KmSX7YC57m78t9VE/xMJPRNqfdx4BkBDOPanRp6RbS6Ydn9S3FrvnIZwY74ZNRczQ7n+AzMknxma5+e1ILRwETpFZ1X6bwnragGAMIvAWp9keyxFo2zekMgJoSCfpvJBK6dSV6KPzpjDiohM5yy1c0AFi0oAlGiFYXSjsuSsSJtzfTLgcxyu41xgq6HqWqtTRLYcPcNk79DMatshUfulDeRLDfjf5pjlFURDnnu389q5KvHKgQDTwG+0Xl7iPtbFPtkWfNzPwAvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UNFoDOTA6pgIIuLCansU7XmpUMCobHZuQDmkiRtVdbU=;
 b=G32qj2hZmgCyeuS6gha/Xk/r710uv6mYbpWM/hTXAAWsAfk+ECLHmb22Qzt0fqAmrIWCdWTyd45AK1SKHOvWOYBGwtMNxtkjdYMnXoUuo4f0+LgpiJmjYvudS9N+VvJntWPRWq6MCTDpMjBRK5UN9nKD2uejVOX/dbxwXxZJJ6wpW8SG7vxKn6/SonXsBOjZ42vJI8FRltcMKVZa2dcXbRRbzRZ9DZsTXC+3RqJ9sANG2pLAeNRg4KibJKUuS5vA99R4gOB4bC6R3E6CZlpGWQlREcs8kzytDGhgiIZHFIyiCHMBYtB4E0wl0KSOoL0IqQVVzu9r6qlkHxfGsvU1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNFoDOTA6pgIIuLCansU7XmpUMCobHZuQDmkiRtVdbU=;
 b=WTMy8UxCq2H4VVPysxX9vzI9c89AzC/hk53l0XfTnOLWPw6/pv24o9mzDwgqS+tQyK6cfkr/zgeId1cz4oBBPyaVpFyXorTHY5Ny1hp/HrOa7rs3DZkLnk2KkiVTZmfDA26qIZ8wgCocksa7nAOHsFloZNeF7pO55xX9uPc0IYA=
Received: from CO2PR05CA0085.namprd05.prod.outlook.com (2603:10b6:104:1::11)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:11 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::4e) by CO2PR05CA0085.outlook.office365.com
 (2603:10b6:104:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:08 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:07 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Fix for link encoder access for MST.
Date: Fri, 24 Sep 2021 15:09:22 -0400
Message-ID: <20210924190934.1193379-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f06c52-fbbf-42b9-7ff9-08d97f8eee69
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438174FC54FBFA97636E33CEBA49@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ipls6ZONWzfVJ78Hfcz3ETlAqHWcKXIH4iIcnhJEWhwpvYCfOSuFpwqL48oIORv6IQBARYjX3vT1tk+oEsCYCKLAyE85yP29Q1ZuU7h5Bb4v8tMyh6z6MPPcjwEUigqbY/PxytZiQxnvipItOKdlnc1cP6XcpVQW+QOZDOaTGrgYmpvSCkR1O1Hjg3zLcQHLt1aXsnfVwZ4ZYllSHWBzsDs6in62Ar1HZwR12cLupNr4+b6u8U08gGktPwprC6QAi0j7C50VYXtGfl4cce/Ij2UWAvfHln5z8TkKvw/vdKU2uPAu9PhnnynMOHKEAtVVbL8xQGN2bPIIvpVdL3hPSGY6BycAKyjcls9rB3f1ZmtPnnWBv3b+OpP6adtnMDQ5WlspCTa9SMf8VdqsP8O3SY1yfI5ha4toxVmmY9VR1P0022PQ2xM9opVXelNMiUBFgH7Enfh/33GZE2tAXnJ+lQ7AfcCKkWT6TDpqfRbuL3C6Lca58CXK72ODd5Fl+xrphoI1iwo5aIctiXXiiUJtgV6FwDJQcOxw/NlFDJohHUEN7HBAqUravYyItPfY0eM4+k5+FGLZMFyMSX0sMyIlqtXk7mhbdrIYiK3v0/exaIg1gNgt4cSbZm9rMfoQRvQ8N11ykYJ7N7jRnyICdeCSJO/cyg2lx0bDiTwDhvgfcdyblWGrBCc3TKyte5BSCFlfltjqhBuwLSX7iG1G/Ex7KFLCoRPPb6mPswiWmW/52Qw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(36860700001)(26005)(1076003)(47076005)(5660300002)(6666004)(508600001)(2616005)(186003)(8676002)(6916009)(336012)(86362001)(70206006)(8936002)(316002)(2906002)(81166007)(83380400001)(82310400003)(54906003)(70586007)(4326008)(36756003)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:11.0081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f06c52-fbbf-42b9-7ff9-08d97f8eee69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Link encoder in the link could be null for certain links.

[How]
If link encoder in the link is null then get the link encoder
from the stream.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cab7993b4cc5..f3a1219c0bb9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3305,7 +3305,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct link_encoder *link_encoder = link->link_enc;
+	struct link_encoder *link_encoder = NULL;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp;
@@ -3315,6 +3315,13 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	enum act_return_status ret;
 	DC_LOGGER_INIT(link->ctx->logger);
 
+	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
+	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+		link_encoder = link->link_enc;
+	else if (link->dc->res_pool->funcs->link_encs_assign)
+		link_encoder = link_enc_cfg_get_link_enc_used_by_stream(pipe_ctx->stream->ctx->dc, stream);
+	ASSERT(link_encoder);
+
 	/* enable_link_dp_mst already check link->enabled_stream_count
 	 * and stream is in link->stream[]. This is called during set mode,
 	 * stream_enc is available.
@@ -3392,7 +3399,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
-	struct link_encoder *link_encoder = link->link_enc;
+	struct link_encoder *link_encoder = NULL;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
@@ -3400,6 +3407,13 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	bool mst_mode = (link->type == dc_connection_mst_branch);
 	DC_LOGGER_INIT(link->ctx->logger);
 
+	/* Link encoder may have been dynamically assigned to non-physical display endpoint. */
+	if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+		link_encoder = link->link_enc;
+	else if (link->dc->res_pool->funcs->link_encs_assign)
+		link_encoder = link_enc_cfg_get_link_enc_used_by_stream(pipe_ctx->stream->ctx->dc, stream);
+	ASSERT(link_encoder);
+
 	/* deallocate_mst_payload is called before disable link. When mode or
 	 * disable/enable monitor, new stream is created which is not in link
 	 * stream[] yet. For this, payload is not allocated yet, so de-alloc
-- 
2.25.1

