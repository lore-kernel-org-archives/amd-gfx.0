Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35EDC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAB610E4D6;
	Wed,  7 Jun 2023 12:16:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49C510E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyY9+3vchjjMNHfgqB57BE9S6yOZ7BIgmH7kOK93c/9eb+Km4qM1dpUUzCGt9/i+KtN+y40+IJoxmi9aiJC6mQJXiPbGSxWbAIjTXuO1LH7qQ779Izsr/ruuhMQw4Vmv2cGP0XOvmFW6ujs7iCK0QSSM9fw0bz95cJZJOR91dZvUG19GyCJh9H3RHQyRIqBekSa5ochuXojaHC7oMxnLIOBv1PrpNO284aVurQmLdu8nauzwmmsKLmTmqz0tAX2dXD6g/OwI908GEJRzfN0aXUGJFeXm90WBA9wyg5G4QbtoK+ETR08r7uMVwmSPVpgN9wv7KNjZG7OoQyDhXYlE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtqyDxAdzQ7zZ9J0EC52oSZ3w90jUyjEbPsYsRbtF6k=;
 b=jSWrg+5mwnkFTwtLh7/cYo6isRSo8Y1RZ3qXZz0QUXppBU+iafIDVixg7F3w9yp6QlahaVCbuGcDY7X16YWufaiSHLQ58zmOPZdwTUHz8gbPXZFen3qbWg+MDEpLmWluG61ZaOhfgwbs5cB671EZsdU8UsbK66RD7hT46h/qk5Y3+RK9BUd9iv3KNufTgqhjbLL5dwX802Qd/g6zcBIIE5GlPz3BPNO5M3TlcvnKgoGz37QTzzY1YNCSy8wJND+dbeckGvlt0ogcu37NVZIcZI+GElHbKWQLigHLIQnwoA2Q4whRfFyXIzem1ilJ833AV//BayWSu4yR/Y+rFW3oPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtqyDxAdzQ7zZ9J0EC52oSZ3w90jUyjEbPsYsRbtF6k=;
 b=tXJaTnHvIb8yOD82Ut4Mz+dwfRUEwql97V5jeQY/P0gXfT2eYfkGh96MN+xwXzjWzAQVlhGj+s5KrAi4/lLiFfEmh3MXEkcvaT7MTxVME7IEbjYXLGi8vvs16qtAmbxLrsPY2z8TVaxDsG/fON7H1iRDXY3R1a6qjWDvIyuQaKs=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 12:16:48 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::93) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:47 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: Re-enable DPP/HUBP Power Gating
Date: Wed, 7 Jun 2023 20:15:37 +0800
Message-ID: <20230607121548.1479290-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: afd32fc5-f9af-43d9-e4fd-08db67511106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3qs3ZX9Rcr3fB3j5rOb8OylwDpQwiJDgqRmRLGVe0oLcge/rhELnvMBkkVs8MAKDGky00Apcw1U/G1TkzdxUbYvXBHB+Ri7PpjtFnAb6zYudT6574LXwCXP0JvevhJkUXwN7HfbS/fmxoVExjJgz4aE5hgaIHA1gxH/bR1u6AnYL2tAurgycO9eVTCcw7GbKhMIyMyriENOn4Uh5ppP6cLoTc5bVW0+0UNokfBnpnhl+4XOTbqUCdZIp6E6Rm5VOUGC34jeH7sKHMykv9FLD1X2ZWd1HnvfslihHDH78ilfMZ9RciR+S4kNhODdiYI+799wdeotG9/0KjnXQrcCtCRZt6GdGUv9cCtSCj0EKGltYqbfP+FmJ6bn21CfMl4l2aIyNpzoUEOZSR9ZnxZIhQBNCV1XaI8hn5QLb1vpqAXf4c2YY/KfttM1dVU1zySHQjnv6Q96sjBDm4mSEXlu/NcxE/YiEOJuf1xjht7s9USAQyoNcFjT3lwPGHqsWxZrlxyZDbeuBjV4Eq2BvAD0enXGWwBrXp9hV1tdyV28VWPwXDSh0Uu6ksL8y0LhIv5JYvOuo+FiWNvxe5ENQkznDd73WYrz8RI8hm1mOJzw+97IJ+/cpVO4SCfPiGnyaRv0Iz8e44Cjn4HwF/o5Qk9WEayNVz+rSr6YCgHAQ8131ALSHUS+erZNJv9TCavsZH9ipEx7x3lKcTtAeWkV3RCRWE0GzlzLtFWrn7INzQ3XHgXEJvDoRxzonXnw4X7lHu8C5acnrCA3RhkWaaTi/mCI3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(26005)(70206006)(82740400003)(70586007)(6916009)(356005)(4326008)(7696005)(2616005)(6666004)(82310400005)(36860700001)(47076005)(336012)(83380400001)(81166007)(426003)(478600001)(2906002)(36756003)(40460700003)(1076003)(41300700001)(40480700001)(44832011)(54906003)(316002)(8676002)(16526019)(8936002)(5660300002)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:47.7796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd32fc5-f9af-43d9-e4fd-08db67511106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Bugs preventing DPP/HUBP power gating have been addressed
so this should be reenabled on dcn314 for sufficient
hardware rev versions

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 7957ad4d6a34..a840b008d660 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -874,8 +874,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_abm_enable = false,
 	.timing_trace = false,
 	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
 	.disable_pplib_clock_request = false,
 	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
@@ -1883,6 +1883,13 @@ static bool dcn314_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+	/* Disable pipe power gating when unsupported */
+	if (ctx->asic_id.hw_internal_rev == 0x01 ||
+			ctx->asic_id.hw_internal_rev == 0x80) {
+		dc->debug.disable_dpp_power_gate = true;
+		dc->debug.disable_hubp_power_gate = true;
+	}
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.40.1

