Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8FFECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4DF10E7F7;
	Wed, 14 Sep 2022 03:33:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2064F10E7F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDgOx15IemjsURyHM5+Jk+BaTRhfBoVDLgdUUpXlsFtJVw5tEfV/NVunshv8lVc/GlTPz9i0QqX1HWI3OATdu4isNEC3F0M3MZ/lBWixD6OuGJA75+Xkkg0Iw2Pig/gj/7x6EniU/AA3eiQT6hdMiEnrvPWJcbbDBCNDz2qvA3//e20hICPVE9dsTgFP74+9kJMeMXWJ+sFMuMfNnubkytkBNRCqDlKYmLKOGep6QV2g9HOWyxTRe1EM6G9ZLWYoqJCY6pVMNCmEs0BPEjiJDlZh1Y4wgJhWrlu38Ak/yzDFta6avMR0pxRDxMWpDXjWCdIx0FtZTSCiRa0qlCL2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=clVUI7dxQduWf5a4pZ6xj1toq5cy/hNH5pjM7gSMoVVCFDpERsIaA+Pk5h9bp0HTaUaYH3x3HgtzSxImQK2fCvuUQU8okR9O4a6HDhJtpHaGy4wehgId+tSa75RrQWxtHVQ4EsBuOwIt41Yt63ub3YGfQZeR8izvNvlz3WXVHH21i+6cjO1MHhhlh9bsjzCdK/tEzGwOOh+r2wacvTdA1VdnpKuLJ3VZID9cS5MWYtczJwCFyR3w87RUUB4OFUeMdY+Pdk+cG3iLpE3ltHoJxegp3SIbRtg7jhdqKvDXcRUoQojUYONM4bmK6vl40hSMTQsULPnMlXPRF+2jP2lwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OzWDObgH4mbjr8jRVvt6Jh2kw5zWvKgAJe4L4hUiVg=;
 b=y91gjT6CH1zTyfURykIrNecQZQIqILwiDxkWPzvcajP1rySD/L0U5OYItrDip1efWnUwikmuOpSsA7sRVg7lGaWo95tudcmWv4tEjWhUnBWv2+FuUMYfUUXjyiMyKi58ZlGJ51NqN8/DTvcR9O72AlqEp0egC1FN6yhxi91xrIk=
Received: from BN7PR06CA0065.namprd06.prod.outlook.com (2603:10b6:408:34::42)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 03:33:33 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a5) by BN7PR06CA0065.outlook.office365.com
 (2603:10b6:408:34::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 03:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:33:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:33:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/47] drm/amd/display: Uncomment SubVP pipe split assignment
 in driver
Date: Wed, 14 Sep 2022 11:24:16 +0800
Message-ID: <20220914032441.1075031-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6b8322-3b74-4082-205b-08da9601e69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ji+Lq6EeTZH5jeqUSh8S5sIxpXNEc7TnNDeen4bBEnGKL6EXnGFZhIKFaqjCPM8SbwJz+EkXOoQaFHybcVS9MFH77EsWH3Th5oPstqohMS0+iEFLBbVFw5hx9QyGEZDWO54jcW77v/PQ7TLdhX1SIgKRGNrP5swFs1qASkjx5sl7VCWE7Flrioe/7REWWZrGGEpBS0wfHWUL61d4aerGRP+l3yDh3PzOFDGc9ATLy2v2LVxHGqAzu4L49dEyy1+IjL2rxvKkzLiGtjY4EopVv43DanKX0SgFXMrIqFOsN7uQe2cFG+DmS9ypryOTnxSBE3r6Vrqn24tvfICxcB6DGrzBuxyWbGr047ZZAIDTjpljhyJAfqsWtT2PmgmZTXVYE+nm+VEoWiOno2orf07bEpHc4T9Er9k7W6QMX8fst7AKt/lZSfSjcBpucsart8JPfJzh7niu17ePaA0AJrtcm16UXkxuhH2KHmYILcG5aIFhWdNseVeDULMPDmWdx1LdU0Xtn335HQEY3j9MZ2iJwVPN0mVn8U0nCIrAfueK9JwSY294FWUJJbRJJDaD+TKid5+qcK1iROhn16WsSfYL2srBPILjDfRwYCRVaJ6t4df6hSzUqUchgohFXXV77djSgzGHKI8g6lJEZbkRuIgCeXUxsXchCje01oO7a0H6MxdWCa0Ksrxm7U9vd4Gwmt77TvRXQa+E2KHQP4su9GG2/z8XIOaVHYOQzUML1qdnwhIGhz/V6r4xY+4Fkq2M/ixEmRS97XEWz77XT3A93AZNS6rOvGlfSMikjAVZZCCw5sQYfgaLaxQ7cUgvqqb7rPbc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(336012)(6666004)(36756003)(82740400003)(356005)(54906003)(40460700003)(82310400005)(8676002)(41300700001)(36860700001)(426003)(83380400001)(70586007)(6916009)(7696005)(186003)(40480700001)(8936002)(81166007)(5660300002)(70206006)(478600001)(47076005)(2906002)(316002)(1076003)(26005)(86362001)(4326008)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:33:33.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b8322-3b74-4082-205b-08da9601e69f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

