Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2635C982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 06:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F5310E447;
	Thu, 17 Sep 2026 06:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YVj27mVr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6829110E447
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 06:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1XLhliA85d2/v72pAVR5nbTjRxykF8Oa+nmSb8fVAR/bf5U5ydVtZN+vT3JaIZEC5J3qOJZsVzEGJLhvmOCL8IGf11CcZ9I9gVOP3kxcSbRsbQCxYM1Mupb8SB/J4LOgX/gMorA0p+/GzFKojX+ch+BFbF5l2tyITIv+p1tVFMAxM5XVYc9aKWojd/M9AcHqgZVel20EeJIOc5BI3LQkVNapnZx7Ldn7eehyYC750hgUIcBm2rMKfeBW3QBcWv2a1zspKGT5F1VebV80VxJKo20yfp4TEMcQnXbS99WYcw0YsHnl6eVOHP4MFTk/SI2PPW06NdvA0d1c7zh1/2eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgDDTXNlESAGjmYgLyautZGMjnVjTGiU8cV7pMQjDBs=;
 b=e4mYwo9l8r1gVFUDcwZ4CQQjMQAA2Z3FRJpQfIilPamNxFRXt+CFMTCORV8pv9ba7S2KrOiLtuXf4i4fVkblgYHi+ONClObao2TeGN5h+JJJ5UYrU1uCl3nd/gzycqaL+n6d3v5VhcOcfzJmJdsHelKUFSUIatSaV8/N3sJGVonxyOMl5iJFWcZ7DQHBTeAFFvIr2eVkDklPm3aweVqPIL7oWcd+Iud0PDRaTStwNUgdhWSUj1+6bg5MmhZLzmvFJtwddGXpXteETJ9qybEDAS6WN0dyw16MIGwYMk4zd9r8zv8Ng+rTRizNULMdFvcG7Wzag6ZYcgUhBgg9yjdZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgDDTXNlESAGjmYgLyautZGMjnVjTGiU8cV7pMQjDBs=;
 b=YVj27mVrVdk+ukU5kg35SpDNaLN6lsDq2b/5BNm9KaHFGkhxe2dZJ5vRCYwT2IGHDRGZwkX10mW3RRcz/IJCXJ5e91TyRNwOX/rp2N3PzIOXJYqRj/g347tbTDxaf0ELYxj/aDrA9pU8MFLsyqIwdPQWZzLcdrCUn2MDR0CgkQA=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 06:14:52 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::68) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 06:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 06:14:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 01:14:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, George Zhang <george.zhang@amd.com>, Roman Li
 <Roman.Li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix NULL sink dereference in USB4
 bandwidth functions
Date: Thu, 17 Sep 2026 11:44:33 +0530
Message-ID: <20260917061433.623709-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c25bae-9081-4eaf-3cbd-08df1482fc4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: krKmxziOYNkvSyJq32lhkECCweIFysA4NVyJS2ypLDfoFU7MbkEiXBRMv3WsKFAAEfbbZQPC+MyAIfjBdIACzQmbD/Aa9ubO9cTc1NBdEBjcA1hDD9pB8+Cr4rznoBckS2MSoiS9Y1pGHR4IjQWCVKYIqndpLNcDrgma675H9srPMXLFbIeSGk0m0v7MBDRj3vLoVAA5CEWPrY5J0G+lPR24j4jpgpvzMo9WDMAHIUQv7VEO/2FB0tZXLiocrkD4jJRvUrl+mJvTYjlxg79Ll3IHHN49RmC1hnnl667bGnv9bUwCfwmSq/F8xIeq+PZA72V/5LLUHeJiUgapQArtQYXc1Wv4cVVzfweE9lqk91jfH+y4Y5nXhXaf5LN7ORD2h5mCW/r1r/PXwvh+1ihl+Q9f8QIghI8Xpd4N0/0vsdFnjNJlv7ZCn1R7E1yWb+nAPCpEcggrxGkkkJeH2J7qpBbzlM5sXwpWFiWivfeNmON4ZXuOpuybdPQIdb7ittA1ujmCyxGZslvX8+zb5nRchuURWc+BNKbchae7z5PXn6iGiH36jEQdX1qResSOI3xDyRJbQFcF3xpVhfoUdz7UCejTJqOG9uPIzBQQTEkpPSOcA5G7uwdab0YGyEPFxp020MJKH0ECAZIfDnhudK3kUWfl/p9q02BofRkG1Z8Dc3l9kv1ZSpn5wNg7U9LBR5b2hfXS4cq952sLdQ+DBoLsTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vvPIFetOPGGkG/sZe4k0dldM5gbA64EHDuATw618bZ5iFSeoRPEnseAw+zLEB6jN+Sl0488VHNjyEXXhDD+INT2spqHkQf2o9aCBa3wUhCs0hG7NL5CKrcX6E/7nNYArdJLoCOWJ/qOdAiML/VuyraIFPz+WZ8uPXjCbD0Lz2y3h4YyFT8tXbLSt9FctKPt4kHwUqs/5OTk4u3bfMGWr+dPqisaDLBypgiPH9n2+5dHdEeDJ/kloWmGSgsraLmIbOvnpacu/a268uMJa4UufNoLbW+e6WSquQxfeIRJZ9eRyNHa4TKtCwOBccM3VZbByvX5SoIaU9nssUPdb4KVFgVLJ+NVU8GON4PCcqaW78DxoJhh1SaBT9VEud8ILfu+Nug4fAIVokW9s8O9k3rFIu7YlOBMaKtoiPen1Bzp9PPDctQzYLCmTdiCdcfTdDTkW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 06:14:52.0696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c25bae-9081-4eaf-3cbd-08df1482fc4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491
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

allocate_usb4_bandwidth_for_stream() and allocate_usb4_bandwidth() both
use ASSERT(stream->sink) before dereferencing stream->sink->link. ASSERT
is compiled out in production builds, so a NULL stream->sink causes a
NULL pointer dereference.

link_set_dpms_off() already guards two earlier accesses to stream->sink
with explicit NULL checks, confirming that stream->sink can legitimately
be NULL. The subsequent call to deallocate_usb4_bandwidth() had no
equivalent guard.

Replace the ASSERT() calls with proper NULL checks that return false
early, and add a matching stream->sink guard at the call site in
link_set_dpms_off() consistent with the surrounding pattern.

v2: Keep the existing ASSERT() calls for diagnostics (to report
    unexpected NULL sink), and add explicit NULL checks that return false
    before dereferencing stream->sink. Also add a matching stream->sink
    guard at the deallocation call site in link_set_dpms_off(). (Alex)

Fixes: 06ab8d420454 ("drm/amd/display: Remove sink usage from DPMS")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15ab0..25ec3d38a14e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2306,9 +2306,14 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 {
 	ASSERT(stream->sink);
 
-	struct dc_link *link = stream->sink->link;
+	struct dc_link *link;
 	int req_bw = stream_bw;
 
+	if (!stream->sink)
+		return false;
+
+	link = stream->sink->link;
+
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	if (!link->dpia_bw_alloc_config.bw_alloc_enabled)
@@ -2355,9 +2360,13 @@ static bool allocate_usb4_bandwidth(struct dc_stream_state *stream)
 	ASSERT(stream->sink);
 
 	bool ret;
+	int bw;
 
-	int bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
-			dc_link_get_highest_encoding_format(stream->sink->link));
+	if (!stream->sink)
+		return false;
+
+	bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
+					      dc_link_get_highest_encoding_format(stream->sink->link));
 
 	ret = allocate_usb4_bandwidth_for_stream(stream, bw);
 
@@ -2419,7 +2428,8 @@ enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
-	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
+	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation &&
+	    stream->sink)
 		deallocate_usb4_bandwidth(stream);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
-- 
2.34.1

