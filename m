Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CD6C6FA8A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5747F10E83A;
	Wed, 14 Sep 2022 05:15:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E8210E83B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks8KdV7l8FKWJsz4jFYM1tpIbonEe0e+F7uuZ2CtLK7/gu6GGHxe2sN4cON6dWRKla3LT0LXPyVzP238e+DR+OTEQHTa5ChJjnwlnqg/5uVwvN/PGPdKx8Y/7vwU2KzWY/2tJmX4Md2t64zn00nBRzSmaTBGzfBsIou4ZuC3YdkPrJK/gkDwO0N6SLYnqlAnWhm75ApjY7+Nh1NtPhUcL5hgsZOlBLCsoziU5MPGTh+BQnOA7e+wIS8p6T8jsdFW4DEsG8X54J6ml+NZjBQLmGFCLyPZbxzNZqdr07p+QZqMIz9cy2Y7czGtaG6ZlfqfSGfSPoUwj+Y1hvdzV6/ZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=lvW+fr/j5wAgfk1Pfo1pjoOYIoXq/A2H4XD29Mb7TlfW8GpJk9FW5d3DMZNxo+3W8ebjtFTUiCOAcKoElWqgX3INFizKGHHliOqqGCPwCHuEUvCAGFklrKGuJzqxh4vfxSxDnnW3gsQUN76oTLtjGp++xCa/FEiWepWaZ/KVfdcsExGdDheWgEIPFaFH88IoM5apNlFqjNl4xWZp7e1ZxmADJ0u+S0z9zljKC2Ry+wVEfyZnQk6q1ZLGzhIryzzGhq927To++RpJq9EX47GAPbKKaK3cte9gaG5NtM1tJ2Eu/Xu4wbuUZdcq+8xigNaui+opFdX4FS4JiC73hF3jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=45ou+4R9DmCVgwufpBCXf2YmROr74O9VvDdwk98VeiuoNdGbMF6YwAFHQteGQPdaqRxmKhvddUYuJ2rcxDHRxHl1XrdUcKDsVPC/2QJc+WoDqoxw2zxm3Mufhh3prOa+bATpuS7jOFr9d1Aq5EBYGCWX9cpI/I2afYKI0Care0w=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:15:41 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::45) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:14:56 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 22/47] drm/amd/display: Uncomment SubVP pipe split
 assignment in driver
Date: Wed, 14 Sep 2022 13:10:21 +0800
Message-ID: <20220914051046.1131186-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdd3632-648d-4dc9-cb1f-08da96102b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buAApTyMN83a0mqk9ybTudJvPTm58CDP/tv2OyLXCBFr17BEJaPB6r9LoIbpb/MTx8VLmXTwtnAkMbsFmO9oVTYd8bLoIbvcb2qNCj30ISp8IaNdMHTj5XAmTj5n+3YXVHj5MsMk/KtV8RzATbBr6XKdakrpHjArHE33BHBvEDXqmFQx2PXBNHz8RT+nlzPS40oKZ5eOq+SUXEJvGj1QyyUXfxcr+qsp0ih9jxM6Rz5G/D8KxP0vTWAUjwn3atdCDiIgTkk9MQgEXqP9tjFviDJbiDx8ThbNIcYQSGc6qat1OYw0jdMD98mrzfnZb69H0yyOxFWcFfliCw66dBMidXYrXWiozIW384Gb+XzdQqhYzJhBZvqtF8BkFNdqyA1IjMrruHw6IToZCrRNxJSLs7jYJvFzkarODV3hVJXyyYPs7czkm9Y0X97FgveU3avBi/II6dbqklWzCTsOCw4gCKxsNm98bXR3NHN4w8uH7H7Nws+syO4aWL6AXjnekf6ysz6I2VCBvR3d+4ZjcVESmNrqoKEY6O3JN/vuOaT7jEifF4s5te3Q/c2kuawY1IULY/JsEIuvFVJJenwUzZHAc+IlOFEnfr45GrSSCvPFs6VHgm+ItAkXYeFnrk6CF7Anz/FH9T1Hh1X+UlGR4+PnadI3Rc2QQ6D0r0rJ9YHeXK+HmyNEp+qgahpFWhEDCmZaaXVOXdJKulPcMxbsf2kLGP7BMVIwuk7N+lgn34QbYCwkurD44uXQfJZSYV3Wdazz7UqdlT7zvfqR16Sfx4tu+l6mEMCWshf24kHn9xyKG21kmtDH0GQ0MkEqjLCFRtBy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(356005)(5660300002)(8676002)(40480700001)(54906003)(478600001)(6666004)(81166007)(82740400003)(4326008)(86362001)(1076003)(41300700001)(36860700001)(316002)(6916009)(8936002)(36756003)(2616005)(82310400005)(336012)(26005)(186003)(426003)(47076005)(83380400001)(40460700003)(70586007)(70206006)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:41.5288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd3632-648d-4dc9-cb1f-08da96102b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Uncomment SubVP pipe split assignment in driver since FW headers
are now promoted

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f09a3ddcf30d..89d7d3fd3321 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -675,7 +675,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			div64_u64(((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)), ((uint64_t)phantom_timing->h_total * 1000000));
 
-	/* TODO: Uncomment once FW headers are promoted
 	if (subvp_pipe->bottom_pipe) {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = subvp_pipe->bottom_pipe->pipe_idx;
 	} else if (subvp_pipe->next_odm_pipe) {
@@ -683,7 +682,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 	} else {
 		pipe_data->pipe_config.subvp_data.main_split_pipe_index = 0;
 	}
-	*/
 
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -691,7 +689,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 		if (phantom_pipe->stream == subvp_pipe->stream->mall_stream_config.paired_stream) {
 			pipe_data->pipe_config.subvp_data.phantom_pipe_index = phantom_pipe->pipe_idx;
-			/* TODO: Uncomment once FW headers are promoted
 			if (phantom_pipe->bottom_pipe) {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = phantom_pipe->bottom_pipe->pipe_idx;
 			} else if (phantom_pipe->next_odm_pipe) {
@@ -699,7 +696,6 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			} else {
 				pipe_data->pipe_config.subvp_data.phantom_split_pipe_index = 0;
 			}
-			*/
 			break;
 		}
 	}
-- 
2.37.3

