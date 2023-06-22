Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B639EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8144710E5AC;
	Thu, 22 Jun 2023 21:58:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3CD10E5AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRSqoY5Hafisg4m1qqBWdf/EcjmFP+aVu1KS2Z/tUJ3RmP7RoulTCvHKl+YE+3mPoQnwafQ738MlJdlobRpDlYH2mUNpZsdwUbr2q2jjIFLZAkNlFK2pitfDT+HxKLiGvfBKBqQZTK8p2hazCRyObZx7jbzH7qoh9w+MGbmoq/KOnGKAAEL0Le9qRoRfPufaljjsZWu0KLhidD3qv2VhE0NhMJ5WE41XgII2Gd1vWtMDPZK9aUe52E7m14t9aWchozcKgkMaD7cC3XK6Swv2pbT71VclPdrYNnLJQpomoO+W+14KsSwgllGho28dhW7pXdqgJAx7p0tR0NMbwd6T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifFYoZZipc/kem+8I/uSH2EvoBluCduxTQXZqLA/hTI=;
 b=X9Qbdz5rZHqlp1Td4Oi/1q92I4fHvExraFM4lQ9akLk19wqrbvzo3lfcSN6R3ikNFWqhJhdde20IyraYQ7CdrDwNt9Fzmv5BVojIgJtmnowKcQf+nJ/ywzXiLhoeVYNWgMqrjj1hXXsvqtgyClstjCY0Z8GnTeOiGuVZeQLLoos5JvYKj93yTIfQbmLZ3s7+8u9PID9dGGxAGFaVyMF2m51j36Be5RMoJDLEmwuNPYRdoWhC9WWY4vNcWAYNwpAxBYDw0x7+vhYGMqVLoJTR4KJcRJhE1xBcf64x08Hb4DmuH73yblkCg01JOn+4JHBKwLpQMkqmEBZ/SaEsEKHYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifFYoZZipc/kem+8I/uSH2EvoBluCduxTQXZqLA/hTI=;
 b=IIuvNLcqBz/LXNSRvDofdRPKs6NTX23kZ5eE7TmgCt9px5RV3c8FKMKbw9QGpimLZhsek49VjWef0Qzvt2LoY/C39+ll9DaRhLTh4kvWCWtkTy7bVlPJFBThQ+BcqGoyndNotOijFVue1PE8XpLcaMq601gtho4IsSjqsCigVv0=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:58:21 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::f0) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:18 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: Take full update path if number of
 planes changed
Date: Thu, 22 Jun 2023 15:57:34 -0600
Message-ID: <20230622215735.2026220-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 623ba51b-a37f-4118-d040-08db736bcb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEXOEo3aZk8D8G++LMycufF91Da3zXQxHIJElcI1ZrEL182EngDk6T38VG8/Sb66cR//K50UW6QbjFAAYtYGJc2M3HArYKC0uex+RZMKKb0wuSBjkThQnTEBnEwlrBWEm71ylC65f6J0IaNzhmM7LTKQcGsG1ILgl1idKT2WHVzFNjNmLOfCP62lvFfleJ3TCcyyH2RKGzvsVucFCIko/vHESrq2bWPkiXBxhQ/Z78iYl29GZhyK2iVWjPLAm3Ndv+rBhpbUrktpBBLu/ufxGG8sRQNEiKrSeVJEAR6+5RyWIPy9kax4iDLk/GcK5l1TiTKKDPrMaBB3Xjl5Yra3KWWgpcb4nV0Ji2eh9hDqnmVyyTiqBo1gmjsH7SWlD7CjbKYdbGzcIutiU29UTcnwoCpkFsBBBe5MeBjzDfPIcoYNIfiNmY9GvJuSzq2w3+o0ptMOu4NvctEtMT9hd5k9rZcupDQLIucy/h0/5U4OWfKNm127VQ4pdL3G/3op1ewOyj3+l+rJf4CwD2ohR6p4tujY+MoIu+QX3LPz6d2YzEIAPcoIuYctF4Q3l8dJU3NmE4nRENs7LcG8hUGJTbVdAJW5zFQiKzc1J8afhKpxg19G0fBQJiueeP7z9bvQAax1vu/L98XDnA4EzH4OVqdPQuCxxcwuLfgyv/9PJRcRhxzb1NPK4ouGQalG/3WYVsimjba0Bq9b/N57UCxTIEjknqwIIYJQIhF0xLehLyWXUCPYwWAHO0eOd/AgV4DSW65b78d7hvQlqZvx3A/WNijKUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82740400003)(40480700001)(2906002)(15650500001)(47076005)(36860700001)(426003)(83380400001)(36756003)(86362001)(1076003)(2616005)(16526019)(26005)(186003)(40460700003)(336012)(82310400005)(6666004)(54906003)(478600001)(70586007)(70206006)(41300700001)(8676002)(316002)(6916009)(5660300002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:21.7178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623ba51b-a37f-4118-d040-08db736bcb9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- A full update is required if the number of planes for a given
  stream changes
- The new fast update path only checked for stream and plane updates,
  but there could be a plane addition or removal without one of the
  stream and plane updates triggering a full update
- Add an explicit check for number of planes changing for a full update

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 68eabb5f3a39..d133e4186a52 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4286,10 +4286,12 @@ static bool fast_updates_exist(struct dc_fast_update *fast_update, int surface_c
 
 static bool full_update_required(struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update)
+		struct dc_stream_update *stream_update,
+		struct dc_stream_state *stream)
 {
 
 	int i;
+	struct dc_stream_status *stream_status;
 
 	for (i = 0; i < surface_count; i++) {
 		if (srf_updates &&
@@ -4333,16 +4335,23 @@ static bool full_update_required(struct dc_surface_update *srf_updates,
 			stream_update->crtc_timing_adjust))
 		return true;
 
+	if (stream) {
+		stream_status = dc_stream_get_status(stream);
+		if (stream_status == NULL || stream_status->plane_count != surface_count)
+			return true;
+	}
+
 	return false;
 }
 
 static bool fast_update_only(struct dc_fast_update *fast_update,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
-		struct dc_stream_update *stream_update)
+		struct dc_stream_update *stream_update,
+		struct dc_stream_state *stream)
 {
 	return fast_updates_exist(fast_update, surface_count)
-			&& !full_update_required(srf_updates, surface_count, stream_update);
+			&& !full_update_required(srf_updates, surface_count, stream_update, stream);
 }
 
 bool dc_update_planes_and_stream(struct dc *dc,
@@ -4414,7 +4423,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	}
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update) &&
+	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update, stream) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -4560,7 +4569,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
 	update_seamless_boot_flags(dc, context, surface_count, stream);
-	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update) &&
+	if (fast_update_only(fast_update, srf_updates, surface_count, stream_update, stream) &&
 			!dc->debug.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
-- 
2.39.2

