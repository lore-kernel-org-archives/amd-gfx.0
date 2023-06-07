Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF6BC7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF5910E4DE;
	Wed,  7 Jun 2023 12:17:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C4B10E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ3/ldx8D3bTSkewvR22bmUw8WPut2QAgRUJ6SETdrWyNv0W1qkCgmZirF2maKwIc2yWU9MU1MtwHKZqEFCRdfbh43h2ny+wwDKxt1eLFkVx9X0dW72s4hkQh0aDgSgqF9TSaKfynDmmE1HFfprtnDUBv5Xq68DiBf66Ue+ibPcvJVkoW0Kd6vmX95CqqUZUy1BWEqRCOY+cNw9b5W3c5v6IRZbBftwqq3QNDwbXBDy9SOAVbRuHYqUl8NyvVzuAnc3XxujqmJJOhGkpxljSrtnr0ZM9ud0n4MRED4LVzR+tGUxjPbGh7zJHzYqmvgpuzgZv6ZcssRsnSDsurCgzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktW35BTVWmEYRqQyX5bY/BpOJvfNa9DMEMLQMy3Y6TM=;
 b=jYuo+coPD47tSSILO+CKIssJrhGVHbV/viEqwa8Hv04rhN0AwO88b5PfzhyJIq5gKZ/PfCvCkE6BvZhTOMVqBkxkU5fQoCPpe+W+q/xpzO1YPS3MS53N8oKs8kCLLzTyUX3/0KBCpa2r2bzqEaroapPoM2hNaZ7a+Zt38/poPDJvsWz6Dwb4nrrneJqFVqP+hmBSakRTdYtYOiZlm5/d78ydoBdCdefcC7mM4xAPt5DpIM2Oi4UlPhJDejxMaUsjhbgu95gnQl0NVrsyyJNsl+Te+/HbhjAzSZ7soIPZh3nVWdGPBvk43WxlMsLb76rLi5jXOksWy7j0PkWZuZZPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktW35BTVWmEYRqQyX5bY/BpOJvfNa9DMEMLQMy3Y6TM=;
 b=khaigjB4eWxEB6l3jgGczZMYeg90Jh/mrE3I/FHb4TI4pAU0ySDn9kudwuNdp69HqPuWhFP1VRw09f64pB/AG0kLohhJO+BSPDykWKUWgrcZZPr6VsqvrXOuMul98rmAyqFQvIbY7zyhQrvuzc+FinpC6NQvoexhCgssFSCpZxQ=
Received: from DM6PR13CA0018.namprd13.prod.outlook.com (2603:10b6:5:bc::31) by
 PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:24 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::88) by DM6PR13CA0018.outlook.office365.com
 (2603:10b6:5:bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:23 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:19 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/20] Revert "drm/amd/display: reallocate DET for dual
 displays with high pixel rate ratio"
Date: Wed, 7 Jun 2023 20:15:46 +0800
Message-ID: <20230607121548.1479290-19-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 430a312a-d3df-4d30-8688-08db6751268c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGbS+O905ZUppuSuijSjTI3hcO0e/rLHDAdsP5lvKrHp+ugDSJcWPLxnnIOmkXySvhZdCqYvG57TC6ZfkCslH6gRR5cdknhIQllBphz65eF7GWE5s1i/gCAAMgFJ4FFeZkFSgAZGyi5/6B72w59ewEPMPpS7ZMZX6DzloOqKeWRlNxCD8skMFMF5xlbtWh48sqn5fH4u1aERokQ+MnVZQ5KtyeGWSkbbr5PYfr9slpVzSSn+h9sDxsx6DQDRTI5u7F+6/rdbxZw01EPf47obpwChHL4JDfqRQN1AdljZGW4/SCO1dn27QZJ2Ibzz/SC5JbLLKwJqQBnNoJ4p6bnYjJlYWjDi0aW5Xq/HwnLht1DGB9sHBz5rvUBsADopiwDiA+wamJ7nI3m62Oy6bPAS4A5Mk9Fi5BFw3TOILeBNbHBIUTZ5ab+VNFl0cnvPBnLl9Hsvv7/VYzlKgwJwCrRVpRBo1RH3BmuImH6t6ArtoXYaZKi7wFfIX+rXwCXjIbskhrZi2DnWPwfzFgBBVc12c+YiBB7B+euhx34Yt77JJhNfcXFCpnqaKqoeb3YTAO1lJbX+UL4d1rvBNaiZuAiA+wspjOxjuFcX1/7LbK15tV7kt8upcXfAFSHi5hEDHAv4qB4tTIrlMOWbMzBKVYCKgwNvOaYEsn0sjKrLh3N54XkRiYMOb0ax+KTTy+H6uzXtnBiewuuP0CAtUWPBQP3ulDu0p2ZcTXO01SopI80WMiN4DN9kji4cSf8bk95CB30bOpRv9C9QL9PB6EHzOCl3pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(36756003)(8676002)(8936002)(5660300002)(6916009)(4326008)(6666004)(54906003)(478600001)(40460700003)(316002)(7696005)(41300700001)(40480700001)(82740400003)(81166007)(356005)(47076005)(44832011)(1076003)(26005)(16526019)(186003)(83380400001)(426003)(336012)(2616005)(36860700001)(86362001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:23.8875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a312a-d3df-4d30-8688-08db6751268c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

Revert commit b957de69c4c8 ("drm/amd/display: reallocate DET for dual displays with high pixel rate ratio")

[Why]
Previously had modified DET allocation algorithm to allocate less DET
segments for lower pixel rate display and more DET segments for higher
pixel rate display.  But noticed it is causing underflow when higher
pixel rate display is not displaying at higher mode

[How]
Roll back change

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 51 ++-----------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 7eec39576e2c..4882c3684b82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -255,8 +255,6 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 	return psr_capable;
 }
 
-#define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
-
 /**
  * dcn32_determine_det_override(): Determine DET allocation for each pipe
  *
@@ -267,6 +265,7 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
  * number of DET for that given plane will be split among the pipes driving that plane.
  *
+ *
  * High level algorithm:
  * 1. Split total DET among number of streams
  * 2. For each stream, split DET among the planes
@@ -274,21 +273,9 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
- * Special cases:
- *
- * For two displays that have a large difference in pixel rate, we may experience
- *  underflow on the larger display when we divide the DET equally. For this, we
- *  will implement a modified algorithm to assign more DET to larger display.
- *
- * 1. Calculate difference in pixel rates ( multiplier ) between two displays
- * 2. If the multiplier exceeds DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER, then
- *    implement the modified DET override algorithm.
- * 3. Assign smaller DET size for lower pixel display and higher DET size for
- *    higher pixel display
- *
- * @dc: Current DC state
- * @context: New DC state to be programmed
- * @pipes: Array of DML pipes
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ * @param [in]: pipes: Array of DML pipes
  *
  * Return: void
  */
@@ -303,31 +290,10 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	uint8_t stream_count = 0;
 
-	int phy_pix_clk_mult, lower_mode_stream_index;
-	int phy_pix_clk[MAX_PIPES] = {0};
-	bool use_new_det_override_algorithm = false;
-
 	for (i = 0; i < context->stream_count; i++) {
 		/* Don't count SubVP streams for DET allocation */
-		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
-			phy_pix_clk[i] = context->streams[i]->phy_pix_clk;
+		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM)
 			stream_count++;
-		}
-	}
-
-	/* Check for special case with two displays, one with much higher pixel rate */
-	if (stream_count == 2) {
-		ASSERT((phy_pix_clk[0] > 0) && (phy_pix_clk[1] > 0));
-		if (phy_pix_clk[0] < phy_pix_clk[1]) {
-			lower_mode_stream_index = 0;
-			phy_pix_clk_mult = phy_pix_clk[1] / phy_pix_clk[0];
-		} else {
-			lower_mode_stream_index = 1;
-			phy_pix_clk_mult = phy_pix_clk[0] / phy_pix_clk[1];
-		}
-
-		if (phy_pix_clk_mult >= DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER)
-			use_new_det_override_algorithm = true;
 	}
 
 	if (stream_count > 0) {
@@ -336,13 +302,6 @@ void dcn32_determine_det_override(struct dc *dc,
 			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
 				continue;
 
-			if (use_new_det_override_algorithm) {
-				if (i == lower_mode_stream_index)
-					stream_segments = 4;
-				else
-					stream_segments = 14;
-			}
-
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.40.1

