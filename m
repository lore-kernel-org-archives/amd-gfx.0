Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A1EC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 18:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8C110E0E0;
	Fri,  2 Jun 2023 18:05:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD1A10E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 18:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4b5X7smP9arRGCGHeCewoLmRbkTGo47qYkii+HeZ6wPj753oM4Jtsg4E23+49zNidWs1+KgQUJweSFBKIxWLaE3FM96cvEofP0I5/U6UeN1S64Tw6Ees4emYy0XeFpvdyiAy8zYQ2kFWxh3L4dqrF8viOjw+dFAzSkdtfIQAcdUxIQGsPdoz+HGjvOOtcRqiSMYii6R2Wr4KZDTPO8Hc0fRsKmqsS57Cwn8B9KR83S1ZLGM6YhwI73p9IDGCQe9gV4d/AEDDqp/XWgHVK8EexYelk376AGJd1ZBfAU6Qnk3jSYv49cMWoWfEijMLrvURqsA8mRk9oJI1Xxcg53zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IiEeQGJS6lxEte4XJzKSnxcvwbFg9dbJK+AMoWFz0k=;
 b=B3tj8x4C/KfSpaFY+WY2e0mCjo/6VQyA58zzj6Phj+e4ZggmljiYedALNbtTo3hG40uOGXORlIC3JapIJuK007drgbtWQgsVK7KsoNCa9m7PfMhFaBzRZn7YlXi1RU+l5zOuXETg1t2YtCAc+PC4ZTNlZhjfVonC7XJBuPYz4TPnpXROkhtb91dAO2E0O+xIKlrO92F66y++7cFpXhGl9NX5CefjNn+ZgQsAIrQMaZxsK/1xx/1BRhZoZ4ul+PPiVoOJ+KW7xxM1D7PdHjQIdvXPk6DJ84SC5PFgzXe6zO8jMzbu7BKwHRIIJ55oPKgIsEYceB0J6oJ8+6Thvr/Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IiEeQGJS6lxEte4XJzKSnxcvwbFg9dbJK+AMoWFz0k=;
 b=vb4jU6WOzuxFPi3JXgsiREIz3bL3DXTAi5h5D3ZUXKbpxj+gIBljVmy/uSHce5Z37scK7KttWrbpukIVi0evQGy1bZFO+TvUeyL6fFq/qcYYHhtaaYfJiflvpSFMg5EteCL78+a03pSCCcLnBEtTP9SWHNIvFO1mu6s4ANDjmhQ=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 18:04:54 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::5e) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 18:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 18:04:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 13:04:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 13:04:52 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 2 Jun 2023 13:04:51 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: Only use ODM2:1 policy for high
 pixel rate displays"
Date: Fri, 2 Jun 2023 14:04:46 -0400
Message-ID: <20230602180446.273195-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 600016ee-b9dd-459b-c1d8-08db6393de1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ld8+4ezDYZl9f0LP/CUjXoLz2Sjgm2RsS9ZBU+P08apaBsp2jMMlB5pCg2g6qZQZAAy8nQPbCtrN885WvGyCNb+b1XZ5HqtaIbW8WbpKWDE+loH64p4n9ZWw0u5KMUm/BcbowbF08KyP2ckF2dR/D4cvcCbDrUK6Sf8RnyJiFkBXu61HdB9pLIU6NllCT1Q+0QVYpMmkkOX2AvKN+u6wwAFmSQdmA93KxcD0qoIqFhTfFOtv7APpBmx+6z4HcAdWi7BcdtQaFUTi6FYWlMWzG/r4dkdvSHhuneaiPnS5E8d8WM/OG4SXZtgI+cH5XGkaB7HILLIY1Ni7JwS1GxogkXv/4jjZnxa3CbCGlu1JOBW9FJ1qypOr/bTgTg9xUUUL0Q4xFb/lSkd9f4xtSWbyS0RfHbgzffRMv92ThtG57VB6MZI59JB/LaPU87CxGIAPOmvdgsYCBCQo3JfBveEDVnLEcioEWwnbLMFSydX0NH6afFUSFg4sbS5iW14o7S6QbiT/pMrIZE9oiy3JUxV68qHIa1vfhKvw5h5QoYgnsNF5Wme/toUNkOlmrnvA76g+Nprofv5fD8K6jMGOTjN9dmgmh+nUwWW7gBJNLxZ+uw7px0Jm6G0FbAQXiLQ07ywczd150kJ4BAqkVqBrKwXRimXxWe4sotHEOQvWTXXJeHCsig+shyAmr9kFOtqw/AXjMwh/rusNyEmYlzYFZegAakUgwxyngN3S+UqCIqxOBQnp+JlRJwMY8s5A3qbIQ/wnxr4mG3MxXa1yQWjhtmU/iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(47076005)(82740400003)(5660300002)(8936002)(356005)(1076003)(81166007)(426003)(336012)(8676002)(83380400001)(2906002)(26005)(2616005)(44832011)(40480700001)(316002)(7696005)(4326008)(6666004)(6916009)(41300700001)(86362001)(70206006)(70586007)(82310400005)(36756003)(186003)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:04:53.9979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600016ee-b9dd-459b-c1d8-08db6393de1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 047783cdd5f604d87398236beb4971abb4d43293 since it
causes higher power consumption for single display use case (4k60).

Also, this patch introduced a 35% performance drop in a Vulkan benchmark.

* The patch disabled the ODM-combination on most popular monitors, including 4K, 2K and FHD monitors at 60Hz.

* ODM-combination can halve the DPP clock to save power, that is the reason why we introduce ODM-combination, and the PM log shows single pipe consumes more power at 4K@60Hz.

* ODM-combination has 2 de-tiled buffer involved, which provides longer self-sustained time, that benefit to the memory power optimization.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 2e6b39fe2613..8d68f02f5147 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1918,7 +1918,6 @@ int dcn32_populate_dml_pipes_from_context(
 				context->stream_status[0].plane_count == 1 &&
 				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
 				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
-				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
 				dc->debug.enable_single_display_2to1_odm_policy &&
 				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 58826e0aa76e..80bebdf43eca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -37,7 +37,6 @@
 #define DCN3_2_MBLK_WIDTH 128
 #define DCN3_2_MBLK_HEIGHT_4BPE 128
 #define DCN3_2_MBLK_HEIGHT_8BPE 64
-#define DCN3_2_VMIN_DISPCLK_HZ 717000000
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define SUBVP_HIGH_REFRESH_LIST_LEN 3
 #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
-- 
2.40.1

