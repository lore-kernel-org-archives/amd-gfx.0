Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFE4EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F319410E5B6;
	Wed, 12 Jul 2023 17:14:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B83510E5B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMbTCdBMyZ14wQf4eHVsTXnr6Q3y1G/gHmgYBPi36Gioi5WcBBmIxtdHhUwNTko0AuAJQ4jnhABr6Zi+Cq0eRyzWfLxasC/6AfUnqTW+vp+XMFlhHI5STSmxjfiqpWc8e1v/6QMg85Fwjpzm0mQH0ZeGJmwLFa6qWzkmNL7+lNcFUNxKNV/VJbbZfWzjDixjz3Gt5ftveXGiU0Gh5Zdk2joNhazLpzM3gcwK8fRNM2qw+z4nAGq9fXt5QVqZtGnZdpibBrlh6TTps3B6lsGRkiG/cl7Mzx3G6T+VTQgci5bWJO8YYdBbO+zCS6BLY/K2TLaPlUoZF4GKESnR8Ga5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ir28XbGftjDbeptWx4F31z+gqeWFavsk0LIYRCsb4M=;
 b=CujjtnM+iSTAXTPuCvXeL0yCtete8JQ6CF/M2UB3djJ/UD5lVygHcA852p6YJg0u6glFKbIdpm9tGhSpRBmtTZsp9mwZVdOTvQBGRQmgWPeTXcffX68zkEFxUHQrnCQBPiPYHuGdRcGaIs2aq/pEuzisOLI0/jcSEP4PMztlk5JVGQl+VxNz9U52y17sa0PcoeGhMLNOu9D590PVdQA5cqbJmibNl68HESFDcWl5HddfYLtNXsTLqfZO7nY3VvCwTzfhO1rpr6wuAJlQZt/fjybzeDA9zsyz2ecPXDxIZ8G5QUdvPzuctDRASew4K3OvbJrhs5BhL5Ekz3vnBfw2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ir28XbGftjDbeptWx4F31z+gqeWFavsk0LIYRCsb4M=;
 b=D4lQRw7xfA3dttVUvJxBCD+XHPi4ME3k41Tv2G2SZPqm6eawErfTpBu1U2IqpvphTWniYzp+t2NrDWjhIYV8zRVK6DUGcfTXWfZQkTM9c+oSv1cTXkL5yhDlqDFfwDlHFHzCNC0uK3bG+f30ZpHcusA5sav9SL4LaTouSzfd1Bk=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:14:17 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::92) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:14:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:17 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:13 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: Add missing triggers for full updates
Date: Thu, 13 Jul 2023 01:11:29 +0800
Message-ID: <20230712171137.3398344-26-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a9b57f-6750-4fa3-665b-08db82fb6cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1ejmJ/hnWvWG0vZ0fjXMLYq8g94Jz6KK+2Nj4aNG/pZ8jy/KSImxW9ad9BSaSRs43ammc+h5ZEDlr54nVo5EgaaEffqXjDSuZEnynjGT/m8hpsnzGK7ACJAfhe/D7dJdbxWbJjGyR2W1NX9vpod1k8Zsp9Ny1vusDpbygFRoBelG4HA+0t2pTqm9RThqz30EcSJcJVoIQL4YA0T9G5EMEuaZDVVPr3+hK/yssJoxcYmZl/A9fHJ6d1GqouNZHMpWLJDhcoKaJU9E0D9uLWzMTNGDrjgXznyDdzsxIAJ804/a+8bIpwo+ro0xEmtbbyf6BUAis6S4AYuBSCCsnZz5E+8kSb0a3hyPt8zEZ1ASVQYMzjlqNbLoyE77I/0XEbC1CHrkl1rx+zrDYHJT6zHcIlOf3CyJLFB+9mvZxi9a23SVwtPoHsdgThY7MWHrm2ZDboqagevtiOi6F1zFyr7ihedubzkEcyuIg3t9h0MCT99Rk9r65AhzuNqUE7VTLd36ygDkk6MbVGlgijEx/6rtw0/WeiTSIwtj0tVv1YyNQfH6hVty/VjA92t0cW9KIpZVKKYTVbe8m8PgHLOOcDml6TsT+W8ORqmMMWW0WwrDQtCPW2XJJvxuwnZluzMB4x5PBct633OnelwFs/lSt6ISypkF2gTkgWvJKTvmzglvzwD8H+MzZe2T6bZW2r2MnixgmjUi1rjjy7A+bP6pwfg6VESh8pPNIRDqbkCMN9s6NzsEAwcEYehpw/p3i00Os6CMDPXgAX+0Ss4hkjr1GBzyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(82740400003)(356005)(81166007)(6916009)(4326008)(86362001)(6666004)(54906003)(7696005)(70586007)(70206006)(316002)(83380400001)(41300700001)(36860700001)(47076005)(15650500001)(426003)(336012)(2906002)(36756003)(2616005)(8936002)(8676002)(40460700003)(26005)(1076003)(40480700001)(5660300002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:17.7101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a9b57f-6750-4fa3-665b-08db82fb6cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Full update was missed for the following cases:
	- Idle optimization is enabled
	- Plane is not in current context
- Also don't clear surface updates at end of
  commit_plane_for_stream_fast as they are cleared at
  the beginning of each flip (only stream updates need
  to be cleared in case there is no stream update in
  the next flip)

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d29b0aa6056..7cac14f493f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3584,9 +3584,9 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 			context->block_sequence_steps);
 	/* Clear update flags so next flip doesn't have redundant programming
 	 * (if there's no stream update, the update flags are not cleared).
+	 * Surface updates are cleared unconditionally at the beginning of each flip,
+	 * so no need to clear here.
 	 */
-	if (top_pipe_to_program->plane_state)
-		top_pipe_to_program->plane_state->update_flags.raw = 0;
 	if (top_pipe_to_program->stream)
 		top_pipe_to_program->stream->update_flags.raw = 0;
 }
@@ -4286,7 +4286,8 @@ static bool fast_updates_exist(struct dc_fast_update *fast_update, int surface_c
 	return false;
 }
 
-static bool full_update_required(struct dc_surface_update *srf_updates,
+static bool full_update_required(struct dc *dc,
+		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_update *stream_update,
 		struct dc_stream_state *stream)
@@ -4294,6 +4295,7 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 
 	int i;
 	struct dc_stream_status *stream_status;
+	const struct dc_state *context = dc->current_state;
 
 	for (i = 0; i < surface_count; i++) {
 		if (srf_updates &&
@@ -4305,7 +4307,10 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 				srf_updates[i].func_shaper ||
 				srf_updates[i].lut3d_func ||
 				srf_updates[i].blend_tf ||
-				srf_updates[i].surface->force_full_update))
+				srf_updates[i].surface->force_full_update ||
+				(srf_updates[i].flip_addr &&
+				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
+				!is_surface_in_context(context, srf_updates[i].surface)))
 			return true;
 	}
 
@@ -4343,18 +4348,21 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 		if (stream_status == NULL || stream_status->plane_count != surface_count)
 			return true;
 	}
+	if (dc->idle_optimizations_allowed)
+		return true;
 
 	return false;
 }
 
-static bool fast_update_only(struct dc_fast_update *fast_update,
+static bool fast_update_only(struct dc *dc,
+		struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_update *stream_update,
 		struct dc_stream_state *stream)
 {
 	return fast_updates_exist(fast_update, surface_count)
-			&& !full_update_required(srf_updates, surface_count, stream_update, stream);
+			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
 }
 
 bool dc_update_planes_and_stream(struct dc *dc,
@@ -4426,7 +4434,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	}
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update, stream) &&
+	if (fast_update_only(dc, fast_update, srf_updates, surface_count, stream_update, stream) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -4572,7 +4580,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update, stream) &&
+	if (fast_update_only(dc, fast_update, srf_updates, surface_count, stream_update, stream) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
-- 
2.34.1

