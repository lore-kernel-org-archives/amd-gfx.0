Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AC0ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD41810E832;
	Wed, 14 Sep 2022 05:14:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0F10E832
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYukDGoIjPVlba+KHbk1I5rPwK8rMRiCrmw+T1VFKOR8PyJEFgZbhkR6ZDsQ2GZ+VnJiBpLM95XxrJOtqy9zkGndmYjh30udcw6KpZF7XzcOqBzRAUk35w2rzvkqWmb17XEixXuY28C2SD+YBdokeWGa79nxxUGnC3G84b5+9S0hUBVHqSxDhgkEXzVJHAb6wcqBVw9kAcSRiADNbbnkkLhg+a3jKCT5Nl9t/oVloO7ZM5B/8rRyo0nyEJeigLdUhDV+8BTjRS2+5tm1wQe/DRjbCQSXwGca49eOYpi8BSptUr2NZz/7clw1c+Nw0BDghZWXdxIXMvN9ACY0s+vDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=R99L6f4dJ30pqcmwta/GN7zXFWw+AYKljuAp9GAZHqMoosRg/dvk5ZD9mWwByw21vsH0Q5m1k5vhn0FUPDdlOEl2z3R8vc+DzUEwCrKrxK/5HWfvGjVbpJ6hS9dA8wGEBm0g5omQ7xubdzJayQlOt4qo8E/EY1XkGlfe0Er0PVa9xjscrgqwmHXeBoED6JkFmfPly2bxAHhJFGM9/xi9crbZE4OJqJIHqqpVqCjDKnhn9UptnemBiEC8tSccF7CLbNQvpfAsAEmKc6e8oniLsxNDWm06IzTgl7eQmB/R6S0yijrZW3nWUpbro/+MJYNgeCqjNMVvVEcFWRl+wfZP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOhRbySf138h7l8a++kqxKUjWUYsB4r8XnJQ/PR6BuI=;
 b=gtKH7ePYMNviJPoLBDQS9GJO58At/VuIzeSeDSpV8PsC00NLITymf7zkWouNKh3tb9EftI8xShL+MvGE9KRa+HLnb4AZP1HBzIhcHI0O0Li9dsvD7pTooz9NCOCcFvbDWvf0Q8b1Xo5bI1iK0hOS9lxj/oeKVtNq51M0PwuWtbU=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:13:51 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::5d) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 16/47] drm/amd/display: Fix SubVP way calculation
Date: Wed, 14 Sep 2022 13:10:15 +0800
Message-ID: <20220914051046.1131186-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bb5f3e-cd20-42b0-eb70-08da960fe98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Z64OrQpdIBHRkIG15yi9gi//5M+RtVtywbtf5TJVr7HLQimZlfgmN1qpFSofWuUJttQ6+vrl7wfv3FnUfxMutFcJmuaY3SKUiGr5yaWuKnFrxr97s+bA1tL6OPlBR3Jy6hMTQixjC5byWmRuFG4hrnK/iRjQP63ODPnC5DZfDNvzWFn43co6DkHC1XXbf7EAf0M2k78FylzsahUCu1FuIf9XBKqGi4iuAB22VuU3lFZ6i+uWRGSVAHVJBLZGHXoC8veXGv5u+Rsd5j1Y6T5By3vhqLMUichXCu80XDWHiWE2CWbTSQqIoJgWnh/afqzaj2Md47xJ3LdOPSxeBX++PjbnBAqlge8BsE6hynV2IzP+6xF5EPWUd/iBE8+Iksp/kQwEXeqd1ub0HAoRRfHCn+lwMQkLAPv1gnkheIckAzVmzx89/U3k3HLiGS0k3E93qOdhqwxMmfbIQdsRY958ABwUFnelBSLBDA3g1cxRxJq42Psm1Z79CiYlC7xZw2Qpu4dVQmRfWyj7iTROKeiZq3oe9K30lxiAVftxNNw15e/uRGcpzr28n8yvWb0xKjPxrqVwx9ktQ9OohT8N3G8DGYMFGzKz7ukA88z378xDgB1i+Nq7d0kWwHTBDSG+1c+yIx7Wy+u2yqQ+pOjRxKVFgDH+U3npBnZhpcX+87Wdqs9K0zz9XpJJZ5M24+Tyla7MeSWlHyG6hiryFSRPl4q15NN7PokFwyaGsZ1+QQW3scHgZr7A1SLbwPV0Iq5HeuJPyNWDRKBUMEm9Jw/EnP0f3ayJtJhQ6c8ndb1XWMcYnrO88xbS0BMtrn050EJolZ0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(6666004)(47076005)(426003)(54906003)(356005)(81166007)(36860700001)(2906002)(4326008)(41300700001)(40480700001)(82310400005)(2616005)(8936002)(8676002)(82740400003)(1076003)(26005)(7696005)(40460700003)(86362001)(70586007)(5660300002)(70206006)(478600001)(6916009)(83380400001)(336012)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:51.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bb5f3e-cd20-42b0-eb70-08da960fe98c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why and How]
- Don't skip bottom and next odm pipe when calculating
  num ways for subvp
- Don't need to double cache lines for DCC (divide by 256)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 237f71d9304e..14787e0f0b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -66,8 +66,11 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		// Find the phantom pipes
-		if (pipe->stream && pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
+		/* Find the phantom pipes.
+		 * - For pipe split case we need to loop through the bottom and next ODM
+		 *   pipes or only half the viewport size is counted
+		 */
+		if (pipe->stream && pipe->plane_state &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			struct pipe_ctx *main_pipe = NULL;
 
@@ -118,9 +121,9 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 			// (MALL is 64-byte aligned)
 			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
 
-			// For DCC we must cache the meat surface, so double cache lines required
+			/* For DCC divide by 256 */
 			if (pipe->plane_state->dcc.enable)
-				cache_lines_per_plane *= 2;
+				cache_lines_per_plane = cache_lines_per_plane + (cache_lines_per_plane / 256) + 1;
 			cache_lines_used += cache_lines_per_plane;
 		}
 	}
-- 
2.37.3

