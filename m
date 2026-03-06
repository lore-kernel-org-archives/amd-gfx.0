Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BA4F513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305D910E301;
	Fri,  6 Mar 2026 03:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tztis8eI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46F510E301
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsjeQLiG0iwQ1iJU5QWv9QAm5r5s4nCXiF7SaG9lW9dfKfbyRUZ2Lir/j5277QTYWVKTfA9t+p6UK3hID8ZuJc65dUSeDhgwfDz8onWPG9jsVRnbeKEW2GI2S/ewtCAh2nuNhQ3dWGHBp0VAIs1dWtvR9of5SjAY/cs/MFfQyvrqTzl+l50GUVoOZjQFNHduF3ggi4CsB+F55VKZHADVT6Bt8deqx/FQ13wI2TXEqyqYQ5AkMOHoTmmKHfSTZqxr4Unnw631vkgS6L3R+16KpyEuA+YmDUvIbJCSd8SAzmUAv+AX4E6fmCwLLp0V8ereQS5KkzVLQr1L3K1Sd6l1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N+6MKPqnQ6hMORotFFQ7N0mPUS8w8sMicHTVb3OKwI=;
 b=qAmnr/a78LcTUbCuurGi7iAV5BJddhXvAgKHX7OI1E0oJkXeji9+w6A0mO8dJ2JRyNYWH5G85QFQlOMlzWhCxq/V4ojutOOg4ORvZ4NqZ+6UWiY9fFjRyDSpse9fI8JWCbdM14c8jzI/lL/MyB76LRLTFGcbeCpLTsjCG0a/LpmsH5I6wCKVrHq2F2si+yXiu2qXkIs6rdo68U3ndymq8RCEOkYjTDzGLE9gaIVYdPgrsiUlBz/3vwXQqsjjGsrDcJM3cwmz3M7j9h8qAZ/UpGM+vj6NmSfN9SnDYNAuiTvgSrojweER0QB2m6qYHZBKM0v6qr/pKAwFNo1Ml7Z1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N+6MKPqnQ6hMORotFFQ7N0mPUS8w8sMicHTVb3OKwI=;
 b=Tztis8eIdFje0bzpgJW0xiejjFTU6qFyTD0tXBhBosYYnJv+XcAlXYYPHOSgbHNJ9sMul1yVATvPGmq70STwzfJf04afi+VxI1m7clAf28XSG8f08UzHUBB3lcHkagmPe4+T6WWLCjVGOaxP8ocV9cVGtDfF+mw6Dhy+hxgzs4Y=
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:26:06 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::5) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:26:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:26:01 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 10/21] drm/amd/display: Fix HWSS v3 fast path determination
Date: Thu, 5 Mar 2026 20:13:36 -0700
Message-ID: <20260306031932.136179-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7643e062-5d62-415f-e9eb-08de7b301a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: YRlNyVoJyxWt1/dGKTeZ/QtEaNnUU0iEHbmxJACZ3lJprBuLiTF8Rg6cWpGvu9/JWA3Me6BIyiy9dIWrbtbRMwOyAw269ZwVOmvv3q5PfbBxsRnUlNYw/nmg160Xwwkk8GSX668/WhnYOweEtzU7fEk5VFFz2uuU5ydwpTMcCmqD0FkKQlPItp2HBSPsh7Ivlo7+7eniykQW8qvPxUMlZiOmkT94HJhdwiRhaYRtQgEnnthjBkMZxqwkGbC+SNtEnTM5gOQCHQ1qh0mwg0+WtZ8WAaPdTUN5i68G269atLGG4Ls4lmSwa/OK0ZLXmQETyyd2FUhrRo8snJzOXxyds3wPsjJ2b0LzCF1AS2+ckiE57IpKaHatwhu/XrPm1w2XQN8HRob1s42dZOopAhS9eAEOjUGyeHD6ti3yF5sJTBrPTAopT/RTdd2cER0jBLcdq4X/ehYH/8gDIux+UT29GpD+BSd8LSEQyFUkzH5hokp8lJpLKwZqD+U8+PewFUobB4GyMhczaNNUgbzNQs/arM3Umai9mhSWu8OF6IttF7imqouGkmdQIXHiVuK3BvX68uLPJ5wd74lCTYndjRwq4UfuuO+1Lk0hwTMt510N1cW7FULRkTFJ2MN4Jqtx/uw9fJF91S1BD3bmhmVxRUBoWprJfFp657FtaS/JVjc8IY/8MZwgNRSpTo8kqISNcyI4wFE9BU4xZ7j5G5oucUEZ38BsDnbsMuzZutLFU+VqHup5tA6pdnwsqPtHvCZRg7/6JHui/FPuJdSkPstwhPbApw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BvaG/FEiMjymcjescG4hhpJi05WQUHWctNtrhtEEBaIiLzpozQ5xZqn7M3xLlZ201VkZuLboiCeVmF+4W7XGdy8gQPnORlPJze7ctkVdXk5L9t2gyfwtLGs9nZMTsOrWZAElfIezXQB+96MQCV5MUN4PTbeqZZEtCgIMz1/lU/JMbXtOpGajKloNVS21nmYPpj+d+VYn0Thu5YF2dxHP3pVF8XXclFio+XznuUtXQsudF4nvTn4ST0mDc0PR3DKbHm93s3go9GOsr8YZHuvhL6n2NLbDLRXQsuK5AFGoALWOeza70AXWBNoonHhJR3B0XcVI7otjTqJlRtqSz8ogEqhhiWWHfAcpM0XB/QXNy8s+Heaggw4JrJLW9c2wKz7WuHk+TSeTicDqe32MJMRoBepI6FnH2PbOcS2zYEO3OHxd4IyuJWsdEiV3Psacmm60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:26:05.7306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7643e062-5d62-415f-e9eb-08de7b301a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
We're checking surface and stream updates after they've been applied to
their respective states within `update_planes_and_stream_state`.

Medium updates under the HWSS V3 fast path that are not supported or
tested are getting implicitly if they don't trigger a DML validation
and getting updated in place on the dc->current_state context.

[HOW]
Fix this issue by moving up the fast path determination check prior
to `update_planes_and_stream_state`. This is how the V2 path works
and how the V3 path used to work prior to the refactors in this area.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 38 +++++++++++-------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c17f065a88d4..fc94c002bd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7296,6 +7296,23 @@ static bool update_planes_and_stream_prepare_v3(
 	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
+	/* HWSS path determination needs to be done prior to updating the surface and stream states. */
+	struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
+
+	populate_fast_updates(fast_update,
+			      scratch->surface_updates,
+			      scratch->surface_count,
+			      scratch->stream_update);
+
+	const bool is_hwss_fast_path_only =
+		fast_update_only(scratch->dc,
+				 fast_update,
+				 scratch->surface_updates,
+				 scratch->surface_count,
+				 scratch->stream_update,
+				 scratch->stream) &&
+		!scratch->dc->check_config.enable_legacy_fast_update;
+
 	if (!update_planes_and_stream_state(
 			scratch->dc,
 			scratch->surface_updates,
@@ -7311,26 +7328,7 @@ static bool update_planes_and_stream_prepare_v3(
 	if (scratch->new_context == scratch->dc->current_state) {
 		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
 
-		// TODO: Do we need this to be alive in execute?
-		struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
-
-		populate_fast_updates(
-				fast_update,
-				scratch->surface_updates,
-				scratch->surface_count,
-				scratch->stream_update
-		);
-		const bool fast = fast_update_only(
-				scratch->dc,
-				fast_update,
-				scratch->surface_updates,
-				scratch->surface_count,
-				scratch->stream_update,
-				scratch->stream
-		)
-		// TODO: Can this be used to skip `populate_fast_updates`?
-				&& !scratch->dc->check_config.enable_legacy_fast_update;
-		scratch->flow = fast
+		scratch->flow = is_hwss_fast_path_only
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
-- 
2.43.0

