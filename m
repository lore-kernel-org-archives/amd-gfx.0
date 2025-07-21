Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA9C83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 13:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2661710E25A;
	Mon, 21 Jul 2025 13:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3atlvoq8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B178110E53E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 13:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/vif3xmV4P1SfPFRzuPn/ANLd2NLrWTvxOri53U07NDIDCfYGP39Q1eCwoj6ppo0hnhzGepnbbdawu9aBTUhvtPQ6wt/ehai3EJ4CNKeJKsu9s+FcjIeC2o25URdEaxZRuyg9qy6ej9AM1tjs2nID+HNFTfsDhUEdGSjiZKQ4DlRTzE7evjpyb+QbgVODdIsgbdgN/shNruVjEOYqIsRoIdEZAj21ARta3F1N+n+S6GPWkFfOxADYIJMf6St0wqx2cJdhH2BwbgXGVqnZTPW9lLnE5OpFt/NnYwuowsnC2Vm6Ld+Zwa8Nz7VW8DaY9zen1rhiJQlTksKoD9ookluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xb4dkcCNq1oFwH/9HhBirSZ8f0ZvNl6XbdsX7IKOI0=;
 b=GoDK4tqWFMEQKcQs1n1mT4NgNcoYGovRawomwycBav2TP3CpLhxqUZbBxo5QZiZnGYNWeEYGCHkak6TmJh+pqpmXPTqSXqTZCJu/lzbNZB3SbosZt0AbXZCf8ORldiBicjGwI6F+2D93+tIWHjfaFfzFuPEoTVjavCFVasZnRraAJunKJb26TOdPlEQTS9HHSrR5zWerhftUed0VYXEwb6+WeD9H+RVEB3oQzTbiUWlsoZqEooCTwMC2mwniduIBLXOGa+2umakuNAQiW2vxIdtsJj4a4hyp5T2AUcsRLwMLjkCAyhLPXPd/sNeN9Un5OCw1bzJJpQ+DOvbXbFEVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xb4dkcCNq1oFwH/9HhBirSZ8f0ZvNl6XbdsX7IKOI0=;
 b=3atlvoq8DU1XeW71xmY7s4M6JdWZoBXhTAWEXxEskO7XnTh/UVnbOmmyBW1Ye2wxiqwY3Tt5yQFnYCpxw0RkdKkcAYoit85Ls4TjfYNBYCoFEOKb4X+jEyO/bAXsaDlSey4KtDQuFQtLVscyYYEnOWNDkvomQf5L/jW9STu7A7A=
Received: from SA0PR11CA0204.namprd11.prod.outlook.com (2603:10b6:806:1bc::29)
 by CH1PPF0316D269B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::604) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 21 Jul
 2025 13:02:52 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::e1) by SA0PR11CA0204.outlook.office365.com
 (2603:10b6:806:1bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 13:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 13:02:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Jul 2025 08:01:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>, George Shen
 <george.shen@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Mike
 Katsnelson" <mike.katsnelson@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Reduce Stack Usage in
 'dp_retrain_link_dp_test' by heap-allocating 'audio_output'
Date: Mon, 21 Jul 2025 18:28:25 +0530
Message-ID: <20250721125825.1291218-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb227da-d3fa-4922-d06c-08ddc856e64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OKDMAP/hePyyK0lNq+5meAFMqKrJvz/pT/4sjXQ3dAvDN+2YMuV3xyadqcl/?=
 =?us-ascii?Q?A70W1LFv3EVaO8aWORUSApWZoaIWJJBdW/Y1nXV/I4LtLtp94gfoB2kf5uWy?=
 =?us-ascii?Q?RiMF4wDeloHt7WRdtZv0h6vTHjqDFmkzzV6q49AJl0xTw+OTSY1wjLNFB654?=
 =?us-ascii?Q?TWxbFaREoSpjtcaIrB/PVbt5JQ/BFxSf2dwZXjMlmmvQ3SI1NdkTigjZpueA?=
 =?us-ascii?Q?BvLHnJDe7usSKVhvHKtVjX8o6tIwzljfQcEWMitpDf4RlKhPUlixvEVvHwBl?=
 =?us-ascii?Q?MkP9wBrqD3+D/4QoQ0GFkTnXduVLU6qpGdpM0pytoP2ECeg+E+nEZTZVdseR?=
 =?us-ascii?Q?/57QuimlxUNPdPgfDG353ht5YVz8XrTz3qd7YpuxaaG8FEcmUJClaO133yZ/?=
 =?us-ascii?Q?z8zO8fEBwPQv6WyNOyaTqaGf9saj8SoAvTSRoC/RnyGXk2UaVR7Z2JvoO2gj?=
 =?us-ascii?Q?M35yI66PyZO+OqIDjMS53M3wYZFqq8CjP1rczMNc9CTxZe7gCxDNAUmqp/0Y?=
 =?us-ascii?Q?CNxd9zaMHLSXnFnvCZ6SfRnPHNLup6cVQM3/GshryNY5hyC56n/G65oLUxK3?=
 =?us-ascii?Q?XXoI26Xywr3pog2W0j0qG/s90l7acyQnw3R4SEEWBQyZQ7TgVtWAZGg4IIJ0?=
 =?us-ascii?Q?AReZVhCk0ydWREr0JkJhLzVg9ioLhEn84k8VN4/QdSVag+dQtUwD6+Jk6Xi9?=
 =?us-ascii?Q?t9/IMrnTG8wqUIrXtnyQenNNdy6eSwrfvvq8jmcOCAOEEh+X/xhBzkzwd2HN?=
 =?us-ascii?Q?GolqEMgiRNd4ARqlYV2aJnP4Wrr9VsWNtCtPZ4IXY9CAJx1r527ALTeiDJxj?=
 =?us-ascii?Q?1KOQhEMjlOdyix1b+YmETRFMUocteyAxxI5Dj3M6ZJHwbZiIzt+1H3I+v8xR?=
 =?us-ascii?Q?GPwNfxNC7zyj06JpBYlMvBIwnJ56uxzfFHowassai1DxepfQrX+i6FVylMU3?=
 =?us-ascii?Q?I9mHQvHCjk8BtzKcPOV2goHQhbg927FScxnj3hSoD229RrzGtych6YJOn1dw?=
 =?us-ascii?Q?mhY7asUZyyESzCcs4qN53XpVH8Olk1UZFgsDuDkV9uXqQspMjGEjqodPrpKM?=
 =?us-ascii?Q?7udxoBwKcsN6W+WZr8E6b3WCDfq4hTYP3vjvvBm0rDcvDaQVrnr2iQbHnekE?=
 =?us-ascii?Q?33ojLtqevRfra/w1wP6ZN6SubeYbEHsGKhrxbKpKOZAp9Cn8iUPlce6pav7w?=
 =?us-ascii?Q?fn7dXEtUJJHobdLYTNMoj9Ke+ZOxoPCs+L8of9mm84ZRTKLJCpKlnydZ7eUs?=
 =?us-ascii?Q?/gFKowv8NGiItKinbrmo4JK5NuWGF+p5qwMrA9SJK17r8PHd28ExA66Ym52l?=
 =?us-ascii?Q?0uNk9/Fa8g9H5IzHmlXZCFdP0fMbcvA5nb95YiacJpQXMDAjSl/Ci0ZJDQYr?=
 =?us-ascii?Q?TAO2Alsw35c3RICaI5O5Hoq7629gRyhMXhFe8GmnwO/yTiB8emknr9LgcS7Q?=
 =?us-ascii?Q?j7W96j635vqp1MzrCSKDD4DDb7JPa1RoBBXDHhPjdLcaq6U22LaAAh1NiLe+?=
 =?us-ascii?Q?4QJnT8WU503nReSCa96TAkAYUzJanXEyfIEw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:02:51.2199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb227da-d3fa-4922-d06c-08ddc856e64c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

The function dp_retrain_link_dp_test currently allocates a large
audio_output array on the stack, causing the stack frame size to exceed
the compiler limit (1080 bytes > 1024 bytes).

This change prevents stack overflow issues:
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack frame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe-larger-than]
static void dp_retrain_link_dp_test(struct dc_link *link,

This commit refactors the function to dynamically allocate the
audio_output array using kmalloc/kfree, significantly reducing stack
usage.

- Allocates audio_output on the heap instead of stack
- Adds error handling for allocation failure
- Frees allocated memory before function return

Cc: Wayne Lin <wayne.lin@amd.com>
Cc: George Shen <george.shen@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Mike Katsnelson <mike.katsnelson@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/accessories/link_dp_cts.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..c4db61cb5079 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,16 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-	struct audio_output audio_output[MAX_PIPES];
+
+	/* Dynamically allocate audio_output to reduce stack usage */
+	struct audio_output *audio_output;
+
+	audio_output = kmalloc(sizeof(*audio_output) * MAX_PIPES, GFP_KERNEL);
+	if (!audio_output) {
+		/* Allocation failed, handle error gracefully */
+		DC_LOG_ERROR("%s: Failed to allocate audio_output", __func__);
+		return;
+	}
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -144,6 +153,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 			stream_update.dpms_off = &dpms_off;
 			dc_update_planes_and_stream(state->clk_mgr->ctx->dc, NULL, 0, state->streams[i], &stream_update);
 		}
+
+	kfree(audio_output);
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
-- 
2.34.1

