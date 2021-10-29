Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB2FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A58F61175
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A58F61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11BF16E135;
	Fri, 29 Oct 2021 15:15:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDBC6E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq+xJQyxe8JmJ7ED5j5BEKtRG9QWsT+lf17Ota+evPvmiVS6MyI/lnZ1xe7uZ1g7BR+NXRCG4GFZcitiJ6p/Gz7U43+1cMAyGylw7NIkFlxmHCUtogGWzgk3UZFNNSrRtz8nx2P/983J0k2/mrAlUC8TgXbKHE8TgBcTIXna+c3i9CsWzn5uzRN4hR14bkFhsOhuLLhA4di200B1v18M5H+kV4b3SLQyoALONhQS3DeU4KQr2ab5mMapZTUFjICf3p7C81fEBbgUSVXK1VbKHVEn8RTYwjY6X+gy8kzBUcoEJLlgnPuiIk1WxsdsaTnIosuYuxz+RWDljUOa5Gb5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1leyEL5JMuKOZbcUaev1ONyjOSj2U2f4nFN4lqruWU=;
 b=BvYaU8hvd1cBiZt7uvqaGzQ5p3nuyELwqrIeDtabhfG1WnYr4byPVlWtv2EzQlbfo42HHqOiYlwZbMJV3/7rFm/ckNPbpPwuiDKy29BpKRQDIQJ8yDRN4HzKpwr+zAZRjeRJUz2CirMdARBYj/mipvz1ICMq4riNG3EMvNaPAhB3lk4mF6GZNeVoMbTII4ZoXe0YN8o9ufEU930cufJOc3yQbQHWDM1T5wLowmraKmZ8OqUsxarKVIQsUU/XRhrzeDhNHqF8FhMdjd4luSTiLPYlf9T6AZJ6nSdYeD5HETTl3wJh2pinhe+5+Bdqef2GFSvUlMQQvY3s4tOQdLjI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1leyEL5JMuKOZbcUaev1ONyjOSj2U2f4nFN4lqruWU=;
 b=GC1+g5N6Xmnn8LNVMLHRYWddHeezXkHxkkKt6k87DHc+aRP72VeumBA89hcwJBf+ViVwI8V+n2u9QUxNZMGSm66g9R16802Rxk4sDem7V5wuFVrD+dT2Yt3akCrIZnpHAaGwM4AU8657oTf+iqimxn27LAaakY5I18w926fhO1U=
Received: from BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21)
 by CY4PR1201MB0134.namprd12.prod.outlook.com (2603:10b6:910:1b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 15:15:19 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::c5) by BN6PR13CA0059.outlook.office365.com
 (2603:10b6:404:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:17 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:14 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Roman Li <Roman.Li@amd.com>, Nicholas Kazlauskas
 <Nicholas.Kazlauskas@amd.com>, Dmytro Laktyushkin
 <Dmytro.Laktyushkin@amd.com>
Subject: [PATCH 06/14] drm/amd/display: Force disable planes on any pipe split
 change
Date: Fri, 29 Oct 2021 11:14:48 -0400
Message-ID: <20211029151456.955294-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61589227-432f-467a-22ca-08d99aeeea7f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0134:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0134EF6D0EEACB0DD072159F8B879@CY4PR1201MB0134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thSr2N8fxhrZB16Rgi3/Wxa8ANQYVHVkgReuuKXXYBq92SSj2mF+WPvIpsZCT5dKRz3EguTI3jGylXezgiGwdPUVbbvA0demkcRuGbdxoqFWEpCRApJOILaF1sa6FWMGchQKbNRXR6suHev1vEiMNIL2aPdNpHb+51kdIrGdvFqEizeUyqwtwYNWqoI02M0/L0kSUUvRjFapRjg4cqhHOelJVfgYaMZJdQ5JsZliU9ABjvR+Q8kPgxneka5cJEh3huG99CF3z2pTsH2vMWTSHMvsTTtBJJ0B151Z4VyBmrQHZffTc51of8e8yIXJ/cYx9sZntKTebAKImHCcm7Yx1pHPnJkxHdvpMBnWS/+BGvD41a5dfObiLRB3J9lPe5qdj1mine8/ZfiveTSe8U7WaVUUjpqOm0Zr/rmfqxrx7JVDc8fLJXOzga10Ko0sEmb7AOy0JzSx1vhLzSGno8khUxbqUW/g6rNwwMmKJtldj1Sl8IiedN2ERnkL5ivwHlGcquw4Mb5YM9qeJq8yVIIX0q6Rne6oNL27lMcezpTeW73yLl4wlGE5v57I3wKZ1fJ+fZYqtxaGbZIVMm7jDIa9PecwRcpZH6cqMD6ebhoZuNjveMxdb275wBdth3C7TLtB1PjI/dzKBOlwlE5iRqbgRcfIwR9j1vNklBoCvIJQyep2QlouMjUIVMjMyVzOEaN33ElWWeNpbhllXqLbd367UX6zGZ81JebBEzuCvWdtYgq9ZAoBUWl9OZhVb9AHXgAUBtHa0iNXjVOPHQWBHCKNMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(2616005)(70586007)(63370400001)(426003)(86362001)(63350400001)(1076003)(36756003)(70206006)(4326008)(83380400001)(6666004)(82310400003)(36860700001)(81166007)(8676002)(47076005)(186003)(356005)(26005)(5660300002)(336012)(8936002)(316002)(508600001)(54906003)(6916009)(2906002)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:17.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61589227-432f-467a-22ca-08d99aeeea7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0134
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

From: Roman Li <Roman.Li@amd.com>

[Why]
In scenario when 1 display connected with pipe split (2 pipes in use)
and 3 new displays simultaneously hotplugged via MST hub (4 pipes in use),
mpcc may get reprogram to other vtg, remaining busy.
In this case waiting for mpcc idle timeouts with error like this:
[drm] REG_WAIT timeout 1us * 100000 tries - mpc2_assert_idle_mpcc
RIP: 0010:mpc2_assert_mpcc_idle_before_connect
Call Trace:
dcn20_update_mpcc
dcn20_program_front_end_for_ctx
dc_commit_state
amdgpu_dm_atomic_commit_tail
...

[How]
Add pipe split change condition to disable dangling plane.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 12e5470fa567..11a00e4d9e81 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1085,6 +1085,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		struct dc_stream_state *old_stream =
 				dc->current_state->res_ctx.pipe_ctx[i].stream;
 		bool should_disable = true;
+		bool pipe_split_change =
+			context->res_ctx.pipe_ctx[i].top_pipe != dc->current_state->res_ctx.pipe_ctx[i].top_pipe;
 
 		for (j = 0; j < context->stream_count; j++) {
 			if (old_stream == context->streams[j]) {
@@ -1092,6 +1094,9 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
+		if (!should_disable && pipe_split_change)
+			should_disable = true;
+
 		if (should_disable && old_stream) {
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.30.2

