Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA102C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEE010E457;
	Wed,  9 Aug 2023 15:08:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D8D10E458
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQxm27y5Qxv/FVEQM92cQcYqukdDPnCJLWkH4geqrAEI8P50o5+gtcnAuaJLCiTCLshrXNQ91zJxzyhIXA2OAlK0CnFQdghDTqJqJO90I0j4Pn4raLZKmHuLWzBT5rlACFtosdBlugbmHhVd2UOkvLwD7qtpELw+BS3j7zjjbyyJXGbUzXZZ3OTrySDgRVt2E0FuytQhAox0G/umAzQHQiVjN9BsqX9rgmyU0gK6iqNmQo0DnboOAsdH1fSscnLS3Vpt8m9baJ61i1HS0EgIEVh51RCT/9nmEQQTfEV+8rrppW6SCGw1+6sO0APr4GEnA+xhDNPjmuKJ81W6aqre1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmATQsddFE//GnTYByWuClnDQ+Y66mo4EZOaIsVg7TM=;
 b=NCLcW6qkP/cG8Dqore2BCdfhtHsPHXDaTB6DgKx4c+X+XCxrL4M8sfKyZVzOWffv3EI90m73UFSN14AE8G6OojvG3Gi8Whh+ofe6aq6VKgyQlaRlKXO9iOkNZ5frz9vRRmKkP1o6e7PwMMO3hz3ltIgl6mcpOqbqifOMOPz9Ml+QmcHZh8WZl3H3u/nYVoRbteepgn6Pw0buLGwjFd2ype4EClx9qKpTOVZP3J2CZP0TagWti0gm7kk1dLilAQSXrQtTRdeOUtOG0sszjyPHaij+Ut2uPRp9ylmzFZfyVhWT2YxI+HCFNIAu4vk1Pvdair06YBLfx8MzTEVXfqIX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmATQsddFE//GnTYByWuClnDQ+Y66mo4EZOaIsVg7TM=;
 b=pAkwfqN0L2L4CYhx/yEKoovRdd+6I7KNH84yd2TggEAK/m1e26oP9Z1vf1NEO5SdXoSX06HDWF6Om4olAWi2J3b9w5HKKP3j1G6yLC5fZb7ME07VsEc4amjMMv9o9sF6hTfsClUI3roRsBtQEAHGZFtQrc72AyP+EBSE1wxJtwU=
Received: from CYZPR05CA0032.namprd05.prod.outlook.com (2603:10b6:930:a3::14)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:08:16 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::41) by CYZPR05CA0032.outlook.office365.com
 (2603:10b6:930:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:16 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:12 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: fix incorrect stream_res allocation
 for older ASIC
Date: Wed, 9 Aug 2023 23:04:57 +0800
Message-ID: <20230809150620.1071566-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6c5213-bc27-41f2-f0e3-08db98ea759d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3fFPvZiZ4/Cc18ObJ1cgO697YzQL1gntBotykXmXHGFFUPm04tb+i3kbTVQPC5LkCdrWmGlqTHsor/PUcNfiGTluhrVDr8uRdszQiGEs/HxOGYW9lchLBUpKrCfShhBcvqFueHRsaBHdvxKkHC7nXNFK6aqT5JAI1UhaKjCVkC+HyDECgaJW6zrY6V9cRLxG4TsugYe+lFcOi2ELhydR6N15xWpo/VE1xztfHNMEj8yb5YoNnH3Ver/51r4UaMz+1zT+n+/s52Nb2iHFiDjJsUJQfwaLR5HV+Et+ao5bAiGSZO134q+aiXsPw2KhrzEOO4ALXZnsZ0bL20jyh1s6tj7UEIqHGAtej7dGWPfJof+TWLgU2NF8G/BSR3qY0SWuoIW+Q/P5MCRBe/9I6LCBLE2iMNWNEmbFsAGl94j7wvwbW499ZUMR4gxrOqsaKBjm3RNp7sWsjWsXO4ooKNNVByEIFf2gOxEwJKCrBT2+QmpJaWHRExBVua6ErrX4Xorqbi7Al4kaF0MvqxJCFAtzUrMzXum0Xwb0gsiL4TisKSxw8sNcSPbugmHTwYTKsCjNv/r4AX7kIqaFF0FYvm8WiNFGlTWGh2VExaKS9inrRh6q+6fekQ/Y7cLCiNItCVe4mcRBlxKcsexfLxWjv9bBH7rIg/J8BuUEP0jpKG57UsXhtusfTATkNf2NITLACeItBOxidYSS+8Jz7RoIOvMpqCmeN6ZTgrZEgtpHgdbFrPeeHsZLtAIuG/55yjIRq/9XgAWak9kjq75vDYqAiERpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(1800799006)(82310400008)(186006)(451199021)(36840700001)(46966006)(40470700004)(2906002)(8936002)(41300700001)(316002)(8676002)(5660300002)(40460700003)(36756003)(40480700001)(86362001)(44832011)(82740400003)(356005)(2616005)(6666004)(54906003)(81166007)(478600001)(1076003)(336012)(26005)(16526019)(7696005)(70586007)(426003)(36860700001)(4326008)(70206006)(6916009)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:16.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6c5213-bc27-41f2-f0e3-08db98ea759d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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
 qingqing.zhuo@amd.com, Martin Leung <martin.leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a recent work for developing a new pipe resource allocation
policy used for new ASIC. The new code change needs to modify asic
independent pipe resource allocation flow and hook up the new allocation
policy in asic dependent layer. Unfortunately this change revealed a
hidden bug in the old pipe resource allocation sequence used for older
asics. In the older version of acquiring pipe for layer, we are always
assigning otg master's opp and tg to the newly allocated secondary dpp
pipe. This logic is incorrect when the secodnary dpp
pipe is connected to a secondary opp head pipe in ODM combine
configuration. Before the recent change, we will overwrite this wrong
assignement in asic independent layer again. This covers up the issue.
With the recent change, we will no longer cover up this in upper layer
and therefore causes wrong tg and opp assignement to the secondary
dpp pipe connected to a secondary opp head.

[how]
Always assign tg and opp from its own opp head instead of otg master.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index dfecb9602f49..efa600e46194 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2151,28 +2151,27 @@ struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		const struct pipe_ctx *opp_head_pipe)
+		const struct pipe_ctx *opp_head)
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *otg_master = resource_get_head_pipe_for_stream(res_ctx, opp_head->stream);
+	struct pipe_ctx *sec_dpp_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, otg_master);
 
-	if (!head_pipe)
-		ASSERT(0);
+	ASSERT(otg_master);
 
-	if (!idle_pipe)
+	if (!sec_dpp_pipe)
 		return NULL;
 
-	idle_pipe->stream = head_pipe->stream;
-	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
-	idle_pipe->stream_res.opp = head_pipe->stream_res.opp;
+	sec_dpp_pipe->stream = opp_head->stream;
+	sec_dpp_pipe->stream_res.tg = opp_head->stream_res.tg;
+	sec_dpp_pipe->stream_res.opp = opp_head->stream_res.opp;
 
-	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
+	sec_dpp_pipe->plane_res.hubp = pool->hubps[sec_dpp_pipe->pipe_idx];
+	sec_dpp_pipe->plane_res.ipp = pool->ipps[sec_dpp_pipe->pipe_idx];
+	sec_dpp_pipe->plane_res.dpp = pool->dpps[sec_dpp_pipe->pipe_idx];
+	sec_dpp_pipe->plane_res.mpcc_inst = pool->dpps[sec_dpp_pipe->pipe_idx]->inst;
 
-	return idle_pipe;
+	return sec_dpp_pipe;
 }
 
 bool dcn20_get_dcc_compression_cap(const struct dc *dc,
-- 
2.41.0

