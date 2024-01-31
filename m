Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95C1C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6401C10FC2A;
	Wed, 31 Jan 2024 20:14:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A1A10FC19
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZVZusoT64xq7bA+snvkyNiJM4K4ZkPnMKgR1Np8JlceLPKaFV8HCGSwvLtdoLafTrUTjqtisytGrd6HQO7qHW5mog34erdjIXC9LcP7RjcLR/0ST0HUgyDulG43Gbg+vofw/a4moEE91nTof0xFERtSB/86NZ+/+Pj7x72E9umP5W2u2qBf6WYYBhAUKDxquhkOrz2Yy/JDBCru2zVsCNHalsJjcGoLeGkhFv1LJHjp9g8V9eLSxVI9TMYEbgwEGpcuPvAZU6U46tFx4sG5GAoTpK403XvNqDCWMSd/uwF168kidEUJeDSQ8aGakuOjSdYnLc/Np4g5TZDTEjRw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QFeaMlcpjjfEKoBe7DUERmtUXaL9VlJVVUVP2tVwLs=;
 b=DGQ/Rym5ETO75FNfiNZo+tx97j63lIDpd0knMyYJgnd8uf18U3SD34xYFMN69aR14SoUoiadMIhFibt11a1Ug+vckk5cQf02rh7miQboN9SD0S0tNMRG7iSgbMBnOBQ/kEwdVf/JgkUK8Mh9cINpmXdO8dMMljfTRYsajUIK+8/a8Q976jhTxIZ8YMrKTiRoftI11y8uHD6ZQnAR4WYxAmalck3T3pp9KAiI0wzDcbKCnstCeQRE9CwvCXcCgqsHVplsJ6Cb1AT4O87+Dc+JSG9w9CSmasLlh7JKT0TMLmjeNKasrErfWaSc51tD6ADE8opt8SKelXIaRGv4ifw3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QFeaMlcpjjfEKoBe7DUERmtUXaL9VlJVVUVP2tVwLs=;
 b=KOR9wRh+UevYOMHStOxZLCncBaMt/azFHMoPo5toafUJDxhwBT/FsMX+xh4+ddsDUKbGv30iptA3E0RHTXx/kZUgRg6GBgVYq4IIHKGINmnpYnhewhXhBJ5ALdgh6RwaBrx1QecMQuu+N0aZf2zXJsA0ePYJ13kyH5mUMSPwD0Q=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by CH0PR12MB5345.namprd12.prod.outlook.com (2603:10b6:610:d4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 20:14:48 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::33) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:20 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: Disable idle reallow as part of
 command/gpint execution
Date: Wed, 31 Jan 2024 15:11:14 -0500
Message-ID: <20240131201220.19106-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH0PR12MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: d80fa78f-7624-4e6d-0a5b-08dc229945cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL7l5kgJRXGVEXfgcaGepGbBAqgy5jmU/QtyRKFhNH3g7p4+aT49sXusi2VWflMAjL06+l4Dq0jdPywOvCEJWMBbxLXi2g2F+t1U9x3YQ6KbyhG6xOcCdiyQHraV2xyhy4R0g+3fsT4SYszsyvUCc5KhjrH3OdqBVKCxh9FmCyrSJDFSNgE2PlgVggs2Rn4JCW1GrkAVcledFFoMKc9WZ2y7aRyhwN6Dfo5fGeoSwY/hbgrKaLZ5vFCHV516171ancXtP/LOwuzp92KGmtoDAeVZUM1ZX3JsNP7B8XBHzEAy3SM2aA/av31jR4KlPp8qmpGCbAdzChL3o2K7M9lgSBOJ1uri1d00G6JImL4y3xtA6sBvMPjiC6Hy90MkRRBHA9kZXFtudXcMxjg9aPbr1fc3Ug+JhLeovIM0OpPl6zERjO7CO/elVuPE8GGbP6kMGd4BY2kjDeCFGmCk6zKkd92C7YETN+awg+hIYL3G1P6AsygAXrIAeuQMEUiMykQP17xEddq0Hx6bULSE+X01NHaDwMRPoHqLK6LQkbTmN7XbyzXCOtXObScdl5RvZTiC2+FTVdgiYN+ch37OeF96YijvIczPneEBC0hSGXWknzNUFIHx6EFYMYz0r374sreamkzCHxIvZ+v6QyHnGazECmjvC0n9+QGMFYhfsjHy9RYPBNBPEsWPvJF9aSKgH6WShnmhSYERU+UntjEp+wAplvUR/AMRwIulzVt4ljVxsCFLaUm2cBF3gaqichdPur6gI4HJFJJJFGkJvX9694no4E7cFv6e6y46P2wt0sVSuosvfflH0IcdLFDdBH1jrvU0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(44832011)(316002)(6916009)(356005)(2906002)(40460700003)(36860700001)(40480700001)(54906003)(8936002)(4326008)(36756003)(8676002)(47076005)(86362001)(5660300002)(70206006)(81166007)(70586007)(82740400003)(83380400001)(26005)(16526019)(426003)(336012)(1076003)(2616005)(6666004)(41300700001)(478600001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:47.5523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80fa78f-7624-4e6d-0a5b-08dc229945cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5345
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Workaroud for a race condition where DMCUB is in the process of
committing to IPS1 during the handshake causing us to miss the
transition into IPS2 and touch the INBOX1 RPTR causing a HW hang.

[How]
Disable the reallow to ensure that we have enough of a gap between entry
and exit and we're not seeing back-to-back wake_and_executes.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                  | 4 ++--
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 53919c0eb1e3..10a5f53a56db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -987,6 +987,7 @@ struct dc_debug_options {
 	bool psp_disabled_wa;
 	unsigned int ips2_eval_delay_us;
 	unsigned int ips2_entry_delay_us;
+	bool disable_dmub_reallow_idle;
 	bool disable_timeout;
 	bool disable_extblankadj;
 	unsigned int static_screen_wait_frames;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 838c43b74662..a1477906fe4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1374,7 +1374,7 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 	else
 		result = dm_execute_dmub_cmd(ctx, cmd, wait_type);
 
-	if (result && reallow_idle)
+	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
@@ -1423,7 +1423,7 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 
 	result = dc_dmub_execute_gpint(ctx, command_code, param, response, wait_type);
 
-	if (result && reallow_idle)
+	if (result && reallow_idle && !ctx->dc->debug.disable_dmub_reallow_idle)
 		dc_dmub_srv_apply_idle_power_optimizations(ctx->dc, true);
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index d74e5c9e00ae..54249f356987 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -783,6 +783,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 1650,
 	.ips2_entry_delay_us = 800,
+	.disable_dmub_reallow_idle = true,
 	.static_screen_wait_frames = 2,
 };
 
-- 
2.43.0

