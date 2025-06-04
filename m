Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C330C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D70F10E7E0;
	Wed,  4 Jun 2025 19:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zl8DtfLH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA28510E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2HB3i6XzvtmqxDHpUGAZ/xALLihKZmRg5ud67lPxgexQrpGXuEAhDQQnQKTQtd7NKmAtf/smn2unBd8VHLy2tAx4YzqjQztR6SY+zdg2JRIGrQAU5DjZsi0t6/9mCUtMONhbFU1XWuIPdJVVnEfC1/1mVjEhkSIwibWL8OU+ZIzPk7M5b3alz3dXEk52wh84FBgD0hMDD08v7VnoaRuynp9L3lZkXirHGwAgFUrD4SLZQ6kbW1cJQB7q4Hj2kr1SebGqeyeo1VkyJdUj2ERIgB2CkzPEQatOVk9K4nRvua2c272LUBVHt/FY6tkLtO5tYMa3M7EvHdKnjD8FjPXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPB4xD+X/67kMJ1N7SnxtkF4OY3fXvuKlJd5dfxFKqQ=;
 b=WpCnXgbNc4RuZaDhJ3qwK+1Wrns1FpB0KVZ68SnP1saB2LsQ1R1dbFxgpIlER2jy5ORlur3Zkkklq86nItrY5k0/iPVGD7HgjmI7QJw4zrs9vufhjLYU71Rqk2OK+NUiqsYyDHMG08/VckXJhoO6PCrBCQ86Z4KCFcdrZ4XYDSQkSaJD8Uh/Q5H9NIPhJg/NOFU4Yd8YvmUZ1RDLFZIMZsT5JRErtvslfqJ1xGzBO1pAvMQQeL+9EVZ9j5QMUf2OCm/cVuAlaUB1h48Au9xQwM2wY0ailSFJmVEZUz8/DpkLxIKX8BsfY/gXxl5tjabFty+6h8QnhIUzmXhr7m3uGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPB4xD+X/67kMJ1N7SnxtkF4OY3fXvuKlJd5dfxFKqQ=;
 b=zl8DtfLHpuZ7XbySTZIo89UjA1JGffQCcA9LefBgiEzHuqmRtfl+4a6JB/w4lL92gZospcS7TwHBn9NNc9eIDlNd1LvBGIobaGnAuRw55Y/cmP2I7tsdzSovrz/zOTTnrR6sApx5uTjgxSijVh6KSQZ/sfljXl24E+0RcS2jno8=
Received: from DS2PEPF00004556.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::510) by CH0PR12MB8487.namprd12.prod.outlook.com
 (2603:10b6:610:18c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:40:41 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1003:0:9) by DS2PEPF00004556.outlook.office365.com
 (2603:10b6:f:fc00::510) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Wed, 4
 Jun 2025 19:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:40:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:40:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ausef Yousof
 <Ausef.Yousof@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 15/23] drm/amd/display: Adjust dto fix coverage
Date: Wed, 4 Jun 2025 12:43:26 -0600
Message-ID: <20250604193659.2462225-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e791df6-b127-4002-6070-08dda39fb0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pWqcRbgVLxklxHfmnJ2bxPDkDhDLNqZBGffl6Bdto3oLDWqSWL8A/93uOJbs?=
 =?us-ascii?Q?syVbi8r0ee86HoieMp+KtiWRjwBantoOIlZZtbBPU2XB3ZlRY1JyHOOcgzfu?=
 =?us-ascii?Q?QrUxW7VTYfo9t7xkcpcQxkRt1eMss7XzuUiDb3CJ57vQw89hlzP0pH9SVlNo?=
 =?us-ascii?Q?AqPxKncIlDZD5gKC9tq4cU6IHKGogQIN0GHtfza2dFVpiwqrD/wlql3+z0l0?=
 =?us-ascii?Q?oCfW/zi/yfA5BOs4VH8H1UqwpNiEPyTd2cCBF404nbRlhHe5NVNqJcUH/XMd?=
 =?us-ascii?Q?ji+IMfl8asiYwXm/oE64wc4ozGgVCJMsdZ/sh6il5vYzgOlf+oUdrcFgnG5L?=
 =?us-ascii?Q?2cQf8JKT0+qkZWXajy+Z1YQvNx56gP944jTMEY1B68JhbHRRSElBLv9QyVCv?=
 =?us-ascii?Q?a/wAEP0PSUhhFUGCEy0wR82rRUa8a1YRJGhebmV/sy90qnyVazaCMAELoZbA?=
 =?us-ascii?Q?7O77pyE5zFnIOrtUsYOOA/d7T7px4yZIxTqnDrKab81vEj2bDnQMDgy3us1c?=
 =?us-ascii?Q?K02i0iAIAxVjJPQAb6WdSE12t04NpOYMK0snU0xWEbxLsa48pCYzSo6x8EPB?=
 =?us-ascii?Q?+jckOFE/wn+oLX7yDeU/jDZ3IFpdhMfymSD1jlQ2qq6kSsn9Y0MfHBxiCQcb?=
 =?us-ascii?Q?fVfa5mG4SA5hUELvIBbV8L9SFHTFIoP858oX90vXB1WCByHzRLjl7auofjis?=
 =?us-ascii?Q?cdML4OARJ8z7wMbSmxSNCw0ipBSjDk3tMF4JUWVHKl3ktT/O37F3bUIy09Sv?=
 =?us-ascii?Q?+//ntf3k+2e9rSCLSvDp4S4KLGj7r9Ok5hPwTrNBdgCZu7+ce7M8k9MW1jfR?=
 =?us-ascii?Q?wqtmZ4Kw/dKJfUXAp9mmUxPDfuC/IE2TEu35p/PC6yauWaO2W09MOlL5Nv7n?=
 =?us-ascii?Q?5FCGm8ebh6SQ0MqYxil52mmYDDD55OQAzI1FnrRYgdNi7RX6kOKv+avN6+N7?=
 =?us-ascii?Q?fA5PPFGK6YxN19DKBi/9gbt5WTLWf0qY/xQXBn1q7bERB+f5cxgiplZLJBCM?=
 =?us-ascii?Q?JwHl9ZMpV3yNmJJ91npRmX/NUzOSBrsImeziLxqbWGnPDhiqNwZhJG6B59vb?=
 =?us-ascii?Q?51x9cKC/tciG6xnmdlnAaJrkIdVTuFIzwM1eo8GAgbLxR/GMyrIXMRmgKS15?=
 =?us-ascii?Q?8lc0mpeMR7Zu8r5f/xr1UXAAD2IMMbFjVppQ6NfhZ07hym9xyB5Dv8xn80TQ?=
 =?us-ascii?Q?KmAji9bafn8rJNo/+w2hX/Uevk88jQZsLc8fno+jvRY4YF8VMn1JFB4UY74B?=
 =?us-ascii?Q?Y7hZbKTfBBTnfMx+pCFirB2vjf6L6xBHJIMpuv0+Jdi9ci7CQnps3Cd4MRBi?=
 =?us-ascii?Q?67YlOhDuxknS+3KHu130e004Q83cfAivSvSX+UFQjNL/wcLef4cN0xMO9sCz?=
 =?us-ascii?Q?o6hYiwYiER8v1BGoetjYMjlnNIXv39wxo+9YLArx5BNHE7wlk9PN9Ck6nHL7?=
 =?us-ascii?Q?Qn6qrkhncUA9zwRAt98fZwzz+BJ6H6Jkv0/E6CtqcNHpLNVNnxEDgj0eDO1J?=
 =?us-ascii?Q?nrjvjLjnKajluwMQlKMIrZuCHzogyLFieY0W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:40:41.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e791df6-b127-4002-6070-08dda39fb0d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[WHY & HOW]
Unnecessary to affect legacy APU's dto src sel during dpms behaviour

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index a9a3001109c3..c717cc1eca6d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1186,7 +1186,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			if (dc->ctx->dce_version == DCN_VERSION_3_15) {
+			if (!(dc->ctx->dce_version >= DCN_VERSION_3_5)) {
 				if (dccg && dccg->funcs->set_dtbclk_dto)
 					dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index bc06b7b3d67d..6a00f0984ce1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2871,7 +2871,7 @@ void dcn20_reset_back_end_for_pipe(
 			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 		}
 		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg
-			&& dc->ctx->dce_version != DCN_VERSION_3_15) {
+			&& dc->ctx->dce_version >= DCN_VERSION_3_5) {
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.timing = &pipe_ctx->stream->timing;
 			if (dccg && dccg->funcs->set_dtbclk_dto)
-- 
2.43.0

