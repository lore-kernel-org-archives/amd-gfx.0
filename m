Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C2DC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA91310E01F;
	Wed, 16 Sep 2026 05:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kKdrBIVX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2728A10E01F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3uxLnXaWrHV0etymZ8qRkJjxXpMBqM6B5FN1qyR2CWB4UuocrWASfCN88wexbF5LuxXadEY3Pj7YN3dSispazeJUoDo2IeJaEkOkDL0cIqBclZGdj7jyjJlBHlLbZNtHzfZd2msr5iTPyP1+cHHbx8wHvxf+Q+houx+SqbLjUX1QPuv+cbDn6i/dgnfcChWj8UGh2gLCavX6uT7zQgs3C0aco+o2UcxWrEmgrSBjtAv+E+QpvgWNAhUQ34qNX++oq3Cwe2YPQEHrFXcRsrB80gDOHU+hUl8i9kCjftOMqbgc9IM6Nw5j8f9vu9YHjr2omvYkbDpDUalTy+vgPQT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gkKGL0TlZ3G47GZIo8bPX7ZsUIYBma+gEsv8DS8RsI=;
 b=ixUR1sNvjAC3JVLwb6syJSfPJWREjbXTZpLq3reVieSpAdXlD7vq6ZfNRs5dlE57vv1HPdkYlwRoIiRQ6yROT8YrfE3L4BggLIImnD3LWjFjIKXX9XeYgFBzkwmDB4p5Xx+4H5Hw+jfXBd4Qk8N4gS4vSsNCF64jArr3gCpwCyttiMvAQZjVaPXBMljmx68oWP9MOmhCuKk2WFdlKUKujr6OTB/0i6mPYHJY8uiAx8IqdWmgQujUT4/7NrO6Zq1JrzgG4oD1BALo69qQSnvDOfpwAYOVGRSAwdR1/SR8N/tK8QZvt9uEuwIWlsuUBqmhq3FJqpTsy2IWhiS7Pg5Kzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gkKGL0TlZ3G47GZIo8bPX7ZsUIYBma+gEsv8DS8RsI=;
 b=kKdrBIVXzQWCI4ScN6Sj+c/un/acuQMSkHjgNqHb5Lp3Z5qzoHG2zvH69wz2aYijyU3m88E/zWI7ms/UJqPWfwY3jAnfzs9ZlI6zwErlM8J7Bnz4s3Jy2uyBEJNEkkCM45AIlCp64BiUhal5AVuygsbeyHutiH+WgXS5K9hxnYo=
Received: from BN9PR03CA0382.namprd03.prod.outlook.com (2603:10b6:408:f7::27)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 05:19:40 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::ad) by BN9PR03CA0382.outlook.office365.com
 (2603:10b6:408:f7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 05:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:19:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:19:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, George Zhang <george.zhang@amd.com>, Roman Li
 <Roman.Li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix NULL sink dereference in USB4 bandwidth
 functions
Date: Wed, 16 Sep 2026 10:49:22 +0530
Message-ID: <20260916051922.600534-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 550d7bb9-cd9c-46ff-1eb5-08df13b21be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: nyjeYLQisyCY45lTdYSLe4cMmeB8vIK+2Q/eQjGtVfY6I0Vj9VMb7LbEkjgjcu0n62dJWGxT1BSzE+t6C1d9DeiddCbQ7hROEtruPfQuWDSZqA+An3hhFdlhDNxcq1dbtHHQIq8yLGEkadI66PVFRnCPdmwXPuA65nslfv7refPnrK57fW6NSp0R9Jjm7o1n76eKG4NPdW0ChWlYIYI7oUmMlA8D2RwfClzis5AVYBCv+KrgD5grQwJDsZRcM9XEuzVHjpKuAr6FM6cJ45Itu/lwZa5P4xqJg9VxuIOdYDKX8FZz2cMHDZEeIpP3BhJ7wL0GomnTJhXry7UL4BZA9chtiBrdfzEBerd04pPE7779OPHaA9OuuS+NE96rAif6NjpFe9Lhbea9QxUKZ++ACLa1Kr1VQEf1aANhQwZ/Xzue1jKKCP49QsC4W+2VmZUhO3lloyU3VTq/wpury3hEkA5h1S3muLHHaHNCxS37I3VAA1vDj4FKHOeq0b6Xx1yx8Mv6KwRzXnsy04+2gwEUa+1ITFVQr+gKihjsh8j93kUJOzQK3UrCIYC8yipLqP67qfIZtq0Rqgsy36w/hLNlSfFy9v1C/mGhNBzQ1z+23axxJL5LFG/RU2Lv11D2FJqkhzHfY6U7riXTDI4ousZsMLMzfhjuntbj/RW1Q3SbQ2kF3ovAOkBxYkZtcUovsJkgBJo1qUAaJ7hqjVrBmjsRiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oAfyoCVFA76y+/6NGwB0VpTVLihgp4iKML5wkuEDR6RP8FIwadSpu0thM/Z//Q1U5Q7jgqsoG7p2NbhkJw/EDggyyPuDJoCZeeYI4FgXl1M1ovHVMxHH8MmfaHfReN8hBEjdGmucgAbLM5EUpM4uZt71ZOzT7dRMN2QQDFP+A2NTa0nSPY95dDOL1wmSEejtPOeY8AVbQwwKy/LnHG5gxSMolkl+5VLzcvsEqMX66TsqI6UOBpPwDBl4QWWl3aiTvLSp4lZnjtbdZSsdgNLQ9dz7Q87nyunasdQ+KvK0dQnUBv/GrLTv/Y0gySjCvGcWJHLMbrORUADRgsDGebpeXl0QPkBGviPCE6u1eKI9sYFGvZp/UEEQGZGUQS3bkhAu2/rlXKrgp1jWBvHpHVGF9o9dztptUx16w9kJzNIRnfB6zVazK/BozF+v5Mu8WDUl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:19:40.2306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550d7bb9-cd9c-46ff-1eb5-08df13b21be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15ab0..fad324a3e33c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2304,11 +2304,14 @@ static enum dc_status enable_link(
 
 static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int stream_bw)
 {
-	ASSERT(stream->sink);
-
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
@@ -2352,12 +2355,14 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 
 static bool allocate_usb4_bandwidth(struct dc_stream_state *stream)
 {
-	ASSERT(stream->sink);
-
 	bool ret;
+	int bw;
+
+	if (!stream->sink)
+		return false;
 
-	int bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
-			dc_link_get_highest_encoding_format(stream->sink->link));
+	bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
+					      dc_link_get_highest_encoding_format(stream->sink->link));
 
 	ret = allocate_usb4_bandwidth_for_stream(stream, bw);
 
@@ -2419,7 +2424,8 @@ enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
 
-	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
+	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation &&
+	    stream->sink)
 		deallocate_usb4_bandwidth(stream);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
-- 
2.34.1

