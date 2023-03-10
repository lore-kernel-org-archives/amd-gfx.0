Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127CFC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD4A10E9B0;
	Fri, 10 Mar 2023 09:33:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDD410E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgFrV1nEqgTcfNRDxApGHIGVQwlWMnBEYdCt2Esml/HCRLjGUWYYNtDoU/3I4uXA2Dk6RsD19Zwlt1Q66USfjCk5NBp3nveU+KBNmPuI1tKt8GFKKNDvchcLt/bPT+G2YzmqW+F8eENpkj+KHnh3ZkqOjZlOPPrupLgs8RahN5i6QMtPlnILWUmQeutzAuy0RWd9+V6yQ55VKYoqIuU36cqj/GGHARYyxZdNwULDN8NSRUwFz6h3JBevCnx6OjwnA3syn9VpYufZ7qgOjDWrdNQHtu0qeWsC9T9G+zwrOuXcs4QrPqTzBok90g3eSitWYKGvXlggJYo9l0G65FdOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaOBD78m+/XzVcmBnBtelpAmnMdL+LDZRA9z0iigZbs=;
 b=BKoxaEqWaNHVrd3OzIGmUeZ87ZzYo2CfBgRFw3zpm+DrXcofM5OGSLDfLioQ/Y9e36IrBDBELYDR95hnw8cRGHw5TXe5KL5u9w5xf/HiRmeeeRf3NNcougTRIkCznFXRYTeIeoJbiXK4XPzQ6K4b5wa1fo6AUNHRVAriikWre8VWcVE0boBnANybluhUTSSQH6Bk+xDq+vtB7f8nZHC6wGrjKm4ktV2UtIHMZfFLg2rBX5mX4ywLK5Ewk5An6+OufPDR5gBbMkjOdk1TEMDladIxIq+ONvUa4PSnW3znGh+5vAWKFkO4WF6x0Ck4+n7Qe/qM2PRd968SlNoDYCDz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaOBD78m+/XzVcmBnBtelpAmnMdL+LDZRA9z0iigZbs=;
 b=LhE0M5xBzdcz6ox6pjlpG5O8IRQsGd1p7uRdo/tAijzXnKJh4J/0m7Az9xg579mcbNFI8hOxzT/jHr+08DabsT417HvAe1iWShi1JJL+Gtn6gl5G9htqCFkwo9Pf+4VfMOBz0CTwFJay1YSIFB+8sJLtsSAD/R3ctK7xCSztx6E=
Received: from CY5PR19CA0074.namprd19.prod.outlook.com (2603:10b6:930:69::23)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:06 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::97) by CY5PR19CA0074.outlook.office365.com
 (2603:10b6:930:69::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:06 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:00 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: reallocate DET for dual displays with
 high pixel rate ratio
Date: Fri, 10 Mar 2023 04:31:12 -0500
Message-ID: <20230310093117.3030-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c9da94-ac57-4ac8-559f-08db214a7449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnMig7svZdUKUiDRDAMrkl9X+y+dFwLdYmrRrXq6tXunlQw0z+XqeV4mhHO9iUWkUOIuyHCml3kHO1JR7M5HTRbkTlWPPNYPTFMpw9DOeiU4qtdvLX5rNzo7uNc0UMB5RUAULIVxciPccC372LIP2C4fEriTj0mCJDDjgi+jgW5qPHQKkI2dsoHMzAc259j0G0PJ9L594t768eKeiL+o71meXZwrvvY8W8KdDVQtAZbca9cWov70BGEzcDzSSilW2md/QzotzDMAIsjhaUJENqKBsqAZIyDrmNSmxViKhbDwlw7DxuMMbwcYBZYe0MDQTEuC4kwI4fkiUiKEzEcTqEf1qdOteOy6OcbEVrbj5Y8ONbol0vDBDihB8bpuiiophEuNzpnFxWB4vQA6B/wOGYrRcYFlNJ2x/SZ8dYT0hi3DKnsEaVycfcPLA6fehiy9x1SICn/21hHHGstQ/JzcWPYhkoryWBYZUqt6/FO4gAgT+/iT1Vy2YrTldvO/zl20dSOKVdCE27rCp51psj639T6JwuZ9dhA4OsBGldBrm6ODoendHxgiCHpwlYIJ/kDR/ytiXLPmCeqgGg0Gk6jqw37Nqymmd8DeFIFgVKmUkkGICAefASdO4IW0+690IvGu/Mh87SvwkV47Fx9fdIR1N1RTnrzfKKztRB44xPcqK9ygdOaFqO3H5VG9iYGiqZfF5vIhIGJ9Sxvsoqic2z4O9oVDgVAegcSvvGQRnPC8EeU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(336012)(47076005)(426003)(54906003)(36756003)(40460700003)(356005)(36860700001)(40480700001)(86362001)(81166007)(82740400003)(26005)(1076003)(82310400005)(83380400001)(186003)(6666004)(16526019)(2616005)(316002)(5660300002)(478600001)(6916009)(2906002)(4326008)(41300700001)(8936002)(70206006)(8676002)(44832011)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:06.4222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c9da94-ac57-4ac8-559f-08db214a7449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
For dual displays where pixel rate is much higher on one display,
we may get underflow when DET is evenly allocated.

[How]
Allocate less DET segments for the lower pixel rate display and
more DET segments for the higher pixel rate display

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a616cf078cf4..adaf330716c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -257,6 +257,8 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 	return psr_capable;
 }
 
+#define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
+
 /**
  * *******************************************************************************************
  * dcn32_determine_det_override: Determine DET allocation for each pipe
@@ -268,7 +270,6 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
  * number of DET for that given plane will be split among the pipes driving that plane.
  *
- *
  * High level algorithm:
  * 1. Split total DET among number of streams
  * 2. For each stream, split DET among the planes
@@ -276,6 +277,18 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
+ * Special cases:
+ *
+ * For two displays that have a large difference in pixel rate, we may experience
+ *  underflow on the larger display when we divide the DET equally. For this, we
+ *  will implement a modified algorithm to assign more DET to larger display.
+ *
+ * 1. Calculate difference in pixel rates ( multiplier ) between two displays
+ * 2. If the multiplier exceeds DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER, then
+ *    implement the modified DET override algorithm.
+ * 3. Assign smaller DET size for lower pixel display and higher DET size for
+ *    higher pixel display
+ *
  * @param [in]: dc: Current DC state
  * @param [in]: context: New DC state to be programmed
  * @param [in]: pipes: Array of DML pipes
@@ -295,18 +308,46 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	uint8_t stream_count = 0;
 
+	int phy_pix_clk_mult, lower_mode_stream_index;
+	int phy_pix_clk[MAX_PIPES] = {0};
+	bool use_new_det_override_algorithm = false;
+
 	for (i = 0; i < context->stream_count; i++) {
 		/* Don't count SubVP streams for DET allocation */
 		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			phy_pix_clk[i] = context->streams[i]->phy_pix_clk;
 			stream_count++;
 		}
 	}
 
+	/* Check for special case with two displays, one with much higher pixel rate */
+	if (stream_count == 2) {
+		ASSERT(!phy_pix_clk[0] || !phy_pix_clk[1]);
+		if (phy_pix_clk[0] < phy_pix_clk[1]) {
+			lower_mode_stream_index = 0;
+			phy_pix_clk_mult = phy_pix_clk[1] / phy_pix_clk[0];
+		} else {
+			lower_mode_stream_index = 1;
+			phy_pix_clk_mult = phy_pix_clk[0] / phy_pix_clk[1];
+		}
+
+		if (phy_pix_clk_mult >= DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER)
+			use_new_det_override_algorithm = true;
+	}
+
 	if (stream_count > 0) {
 		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
 			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
 				continue;
+
+			if (use_new_det_override_algorithm) {
+				if (i == lower_mode_stream_index)
+					stream_segments = 4;
+				else
+					stream_segments = 14;
+			}
+
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.34.1

