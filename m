Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD668E77182
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FCC10F077;
	Fri, 13 Dec 2024 15:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KVjUnN3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B466E10F07F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/pXtPeTtqLqMbgAAmdESdMlDkgerBcprsC7Dk6T5xgylmG6T9fKPgHZT7T8+vv/EYMCYrv9BcJ2QmkrKsLfKXU5h+Fiv0pWaBMfWJzailov9sJLZ+e1Z+4dQ0ssVn8QMIyJUv4vpHBx3cfASz8HGT2a8kIw1abfCPHlg2x/yU4yPXIw9gVLBwKvwQiTKASrhQ9lrv/15IjwFDYz8CTt7pIRyTjrSSka3+UbwEZgQfI7evvO54Qrum/XUC08+gM9bXSo3NVugnbDqNm3J4kiNSCQPOhgbLun/mSmn2dHF2dZukoJTJd0NaJi41noji0qOBECrWuPiLDAr4YLyhYIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3uVOIeLTu0smiaOnoie/JztivlHyedwccu0rPsTLTI=;
 b=ya4svwSOntbAR0G5VP52qfH2ND4mYGglncI6MNT6PQbkf5o7eO338ZqDKHrzVW1x08TFIN8EzyIvsYb5kX9PI4zDGc2j1WvWtYdft0TqQgbUQuJ//phh4CkktWTSllqv36eYbBX19+BmikCuDFLq4hHI2aswLULilnaqCcM8IcTK4tWRVhVdU+OaFXL92NOetGUBSwlOk2dh5N+IVjDuM9Wn7yt1hh9eJKQaslPkuhb1IRrKsWGkKF5C6y1H9hOl9Ve5uW6WHK6NGngGAFHGrV7xievKOISPm59E6hcQclw8rH86x8remD1z5AUtnhlmPW+beBstX7EYA7LwvXhYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3uVOIeLTu0smiaOnoie/JztivlHyedwccu0rPsTLTI=;
 b=4KVjUnN3Dhfzsyeec6VdukapU/lc2LRtBGCtcSOSubceQWGk+4O3K7QxR/5WQGjhNimzFpw1h6tGE8LtykimLxOAU8gbnKCbRn2GUuhGPiIWYXoY+gNGksrLos2x1R3itLg6x66zTfGX+yI7Pe9dOlxuKvjaLLgonyDG4lyLMh0=
Received: from BN8PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:70::43)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:55:13 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::5b) by BN8PR04CA0030.outlook.office365.com
 (2603:10b6:408:70::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 15:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:13 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:10 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Chris Park
 <chris.park@amd.com>, Aric Cyr <aric.cyr@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 14/17] drm/amd/display: Block Invalid TMDS operation
Date: Fri, 13 Dec 2024 08:52:46 -0700
Message-ID: <20241213155405.393252-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8c0be6-f027-48d9-ffe3-08dd1b8e87e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vqqqaJWroWG7Qea1vBBSITzrYh94no/sA/VUndNRjO9OvZJG4vm2x8Ko9DJ8?=
 =?us-ascii?Q?8i19QZedWkx3ixjPWqV1x1saUj4G5lT5szsmBQKA5VwVhGN9oyMy6OICwCvC?=
 =?us-ascii?Q?KlGaQA8a3nD3rgGt4WiGSCXtaxqbmm8q6GRCnfF/WxLmhUVvKgjBDHJcYBZ5?=
 =?us-ascii?Q?mG9PjO6D5RX0ifqk2CTwjDCMqtxgBEyhWfnM+Azhq4L8Ez5QvM9e6ctKnnqA?=
 =?us-ascii?Q?VQSp4B4yE321YYcn4nvCyLfTX2JBosa84Px69QfjbCL5PIbEgoWoamnlR08f?=
 =?us-ascii?Q?tMX3Xzi8piD0sRkmR/XUXAdByx6XDey8P0ECt0YRtogfE38VjZEaEzbPOEqn?=
 =?us-ascii?Q?5jQUBzFq1UXN3kmGRdiKXxFS4jxbHgTFXHcMb/OKhow04TANytfMbEos+T55?=
 =?us-ascii?Q?X+b6oX2JgIVxJlaZK++zlW/yBSKGGQmhX1JO8AgKUXAXypQTKYoK3LFfcmdu?=
 =?us-ascii?Q?dKeJc8Wz3RKJCI63qnm3u5xy3dbeSRVgizfIWMKvUvX1vNAw8a5vLoLtTrEl?=
 =?us-ascii?Q?w3zGiZmi+Dedpn3kM+O90eECsz6G6Y7CemSA3TMAgIvS64v2VomsRxJoZXG6?=
 =?us-ascii?Q?Mir2doBMyce7PcWPSJ7n/55Oh03D4sx5OEvBFQoI5yQgPDv0+Vu9/F1ZIjPH?=
 =?us-ascii?Q?EGgyYCqSoqi+zxxsgPBB9gLZEz/tJi43CWWALT718hp944IyyecOYqh9HqDy?=
 =?us-ascii?Q?ilZ/7YUT/a2B/PqBv82Xw/Ot4pHtQ7U1lJI/ajwFWJnTegn5osDutBTPQcbs?=
 =?us-ascii?Q?+R7inmMWBPzVAFNrkWg/NCbZBVii8aTae7TpQOV82yU5HTDcyOwarV2eUmv2?=
 =?us-ascii?Q?SjKXYBg/dDstZj/PVNXAs0W5erW+4GnKxXYnnw45lezaTsfLTUALqrSCkqKQ?=
 =?us-ascii?Q?RY0THxu+9WeWEXhuofyLFryRICaMYE5Wo+yd7dMSGuuFlLoe8gpYjoCswcMO?=
 =?us-ascii?Q?ICQtPFEnRhCl4eu1VAgNYvEX9BXcKH7a+pFL5tmKsa6NRzzWMjoeKRH9WG7l?=
 =?us-ascii?Q?holb61oRlPVIqAsOhr+CHJQPWGmZ5MH1badJHqsYo8Fsthosxyr+bBt3C8BE?=
 =?us-ascii?Q?C8QGxHMMqv4krVDTGkY+cB1UN7P2yX6TYa/WnAhnpAIqSrc5zgZFmRJiTzgg?=
 =?us-ascii?Q?zZeepJ0wuSm9KLgJC2oaOt1YOJsBjpfn4xGsbgK25MhXSngTn1fFmKTQKV/Y?=
 =?us-ascii?Q?og7vMSMpykH3m44VuaRRh/PiXKRIr1GZkYGY7Xry31e/a6HbQkwtyjpHgcL7?=
 =?us-ascii?Q?qaXHW6AhhbQI0wWk0a4TUrW7TS8Eio3Wx4MkqyxHuCL/KnE6d4+ZJw+RWR7n?=
 =?us-ascii?Q?bIm1G5caPScrBmZ6rc5KF3mzJGlpkGjlRBm3DPGXvHOBMFv7ulxLQX3F2909?=
 =?us-ascii?Q?RqZ/iW9EhZK6NhwduHDkvzymjLKZbQD+tgB1duHHOs70nfotuaH8WU9UU6+M?=
 =?us-ascii?Q?ROHkHWZU0tD2IFHppjMp72otS15eBJYP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:13.5287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8c0be6-f027-48d9-ffe3-08dd1b8e87e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

From: Chris Park <chris.park@amd.com>

[Why]
When sink type is TMDS, PHY programming does not block against pixel
clock greater than 600MHz.

[How]
Based on sink type, block greater than 600MHz phy programming.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 +++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index b700608e4240..077337698e0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1105,6 +1105,9 @@ static bool dcn401_program_pix_clk(
 				&dto_params);
 
 	} else {
+		if (pll_settings->actual_pix_clk_100hz > 6000000UL)
+			return false;
+
 		/* disables DP DTO when provided with TMDS signal type */
 		clock_source->ctx->dc->res_pool->dccg->funcs->set_dp_dto(
 				clock_source->ctx->dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 5d66bfc7fe6e..60e64e0138a3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1953,6 +1953,10 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 		stream->phy_pix_clk = stream->timing.pix_clk_100hz / 10;
 	if (stream->phy_pix_clk > 340000)
 		is_over_340mhz = true;
+	if (dc_is_tmds_signal(stream->signal) && stream->phy_pix_clk > 6000000UL) {
+		ASSERT(false);
+		return;
+	}
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		unsigned short masked_chip_caps = pipe_ctx->stream->link->chip_caps &
-- 
2.45.2

