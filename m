Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E77ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC9810E80D;
	Wed, 14 Sep 2022 03:53:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C6810E80D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGWHg3K2xdVGmAHh8QmhYqk98s83lFYj+BMjBCAjQTojewjA/8zybj0k9mG1JElsA8ZJhqr8eJjbN7B1rg5oXR/jk0nIEdJ1nGevdod4ttFxos9q26T28uf/ax5495lcH0JZWeHvqO7VbrT24RFRDOFXxLzNB3VxjQYfy4XvEXxePixeHry+HlLkaBcHQPPLw5NcOdyzoUVCBHAcS4C0iMxz4T2kBPBnrUuZIfqGxSeYMkbXazju2pHwyThiuaTPexfdzht532si6Gv61baKGN7bcRx6si72SPlOQj/CbNf5kUaWTcbE1f5CBc3jw51eRqIcx5AK7DfEmjmdCnPW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=kuSlBs2q2AJThIWYG+Cg8rqX1t7XxP28wU4GnSL3jcOrDNynKTmANuHxn18TNDa2caj1FpgNBaFHXDIAn5tWcy70CIugFLzf9pl+OeLKf7wA7x+3mloLEoiiM9DO3wpx2ogGKO2QYSX1mKMAe4zOM+FHk70rSiU3IWP60G4SLUa/NL3fx7bidP8Kc/qfzde0dsZL9j5BCu9UmGEG20ZSmAWGUBESq+bpITpAbIAqi1wDsHTcYpB/GcCYZZnjesL4HZngG6nXmjBLNxTl+Q10R9uN0TUmVz21UHucM5XOCf6Azi/S7EZr8uGwhCKFR1h4+hZIjo/ZSpnTPk5v9tc9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=gmYFbqKqm2Oi0MUuDfx/V8YhhdFF47Ixsc14NuFGx7WQWhvR9mK5m8FOv3iRBzVWtWB2LtNN86f/yRm6UIPjXsGZTS6p3NEwJ1+HFmfOLPlhf5fNDKhL5/R2I7V88sqQVCi+XCLHDYyA3ozsLyYMCEbsjAg0p+hM7m/kzsqDQeA=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:53:10 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::fb) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 03:53:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:53:08 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:53:04 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 21/47] drm/amd/display: skip audio setup when audio stream
 is enabled
Date: Wed, 14 Sep 2022 11:47:42 +0800
Message-ID: <20220914034808.1093521-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|BN9PR12MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c85c81-7b73-49a6-d13e-08da9604a3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmbH8yYJJh05SrBuZFVwcYd7XbI9g0tFWn/Iizt/gXlvJiCAE3fwPSkjwxcJyBL6qx2ux13tdX/SEpu/qvhxCe0k2jQb4+hZ3LT0jAepsTt8+54T1yNLzwu9r+gilfe3dig8QtX3ieWfdFAlwZe4qcIK5ghR/onKhYJHU1V+dP5E1JNLgSkW2ooDuftnKVAXm/iuHjU7uxfx0VrfDdjbsJZe6g/Z+CcglHKdfbmz3fwHMGM+GpPGZYabTS62XbNsgMFeN/FF2OtGI+H/jOmOTMGx8Xwk9X5Mc52Xytc7J9tfXbgpSb8I5EHZxyAProyd3lAGcRPQ6rvyBJ+HKvcsDoYmX1wIuCt48g+XKdaC44Rdo/CBS+U6I2UrcWNQK6e+aLUtuEjVo6nL1WgYDWlveFNpH2t1b1lG+jbiV6iQB1IimSlMn4zT6cOSulLwTBTh2gYFs3IEOz/gVAg+pALvnNMsnDZMgOxrxzuOwJSXIz07b9VV42oHHVst97Rd0t8CuE5TikzuNW/h4ZKHAoWz47097sjoAb7k99yMGIQEOMZd1cdsOOHZfK8j/c3tgbrB8JhC0+Znqe95axwcAyuZMHu6aReQtaF/cXN9pyriqVqCNPp0j51rroOo8meLvfbdM1jbhUHy22fH84lvgvWeF6LuPgeyLzIyEOtkW+6TF7iUStoQ4V2MeL1Hcn/NrWR0PmnbCl9t6DMOy3QLKbAn+MtGyj9+Mc12D1I8uYXC4R7A/San+vQDpqzn3ufbFkYutTTjDdj2RbtSo5QFz16a70Va35xQdXSmRknurrfMkqJmc9V1j/a9ABvLzE0FkEvB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(7696005)(54906003)(5660300002)(6916009)(86362001)(6666004)(4326008)(336012)(70586007)(426003)(36756003)(41300700001)(2906002)(82310400005)(82740400003)(70206006)(26005)(40460700003)(478600001)(36860700001)(316002)(81166007)(8936002)(47076005)(83380400001)(356005)(8676002)(2616005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:53:09.7528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c85c81-7b73-49a6-d13e-08da9604a3ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, zhikzhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhikzhai <zhikai.zhai@amd.com>

[why]
We have minimal pipe split transition method to avoid pipe
allocation outage.However, this method will invoke audio setup
which cause audio output stuck once pipe reallocate.

[how]
skip audio setup for pipelines which audio stream has been enabled

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: zhikzhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 70ac0b31baba..55c98dbfcc1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2178,7 +2178,8 @@ static void dce110_setup_audio_dto(
 			continue;
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-		if (pipe_ctx->stream_res.audio != NULL) {
+		if (pipe_ctx->stream_res.audio != NULL &&
+			pipe_ctx->stream_res.audio->enabled == false) {
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
@@ -2218,7 +2219,8 @@ static void dce110_setup_audio_dto(
 			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
 				continue;
 
-			if (pipe_ctx->stream_res.audio != NULL) {
+			if (pipe_ctx->stream_res.audio != NULL &&
+				pipe_ctx->stream_res.audio->enabled == false) {
 				struct audio_output audio_output;
 
 				build_audio_output(context, pipe_ctx, &audio_output);
-- 
2.37.3

