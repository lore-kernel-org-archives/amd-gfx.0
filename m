Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7619AC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDE110E9A9;
	Wed, 28 Sep 2022 19:40:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2E510E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOJIFUwabdq428tfQOPAzz8E4mcDtQIruPephbRl93CZgaYWCRmEx9IaJItz/XY81FFNU3aYCx6dOHG24DUINmMROPaqiyzapC/F3+16SS4DzE0ClkOfI/Rdzl3krIEj2JECTmvVdQtpBBcyk5P3gl3TJlyJSjl8vu0LGSDBP4zgtlbhgl5Dl2hnJRE8eVG4X8EQTQSsf0V+wYw/CxZ7lR2QPPmG6sGhf3zAbHnULxPmSuJ+mi8zQjDn4wluXAkos2w/QKMefDLdGfcREL3RusijD4ZpBLaIIbhX8JTw10+ApzVzTWTvbno7sZYkUg0/15lS/zhl469ExBqkAYhSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT6w+Ig0xzby2NFBxNvrp1xTGK9kzW/o4KM7ALazZ40=;
 b=leOlt/1l4r925h8qITATK3VNCuOkdQaKbeQAubConsKAumM6ViRh5uJImGsMDFqNuSLo27nTm3heDODHPsyDghPYqMGej/6lY/86vl48NvqihXm3aaLMW9khUjkdmQweFQ/ymfKu2/84juUPxNecZg3cWQqxXJ5rM/Hc+tKouCqHf0uux4t/HzXB8Ckui/Yzc3rf8qYF9H0j/IM2bcWqLEFQy7Lm7ezfLyBXzP1NvZ0NT+aLJNO+DWm/QVt6gpoQoaVW4eFuMuqKbCFGhDlRi+KTUkRXViCwWTdVA4WMsMRpegGSPH4icPMx65I01Gqfg6++5OHZOfvGeqe+XqTC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT6w+Ig0xzby2NFBxNvrp1xTGK9kzW/o4KM7ALazZ40=;
 b=nICO6QUFlWnFEiqCMn/2xoTadCMi/yg7jUwGek07+J9Oa9zwUDsNs17Poflm6sD5BIpNIWNokJA8Hp9+/RdPff381gA5xUKWYAaKPa7DzU4Uej0mXkTFGjzamckKwtpOf9y1I7AQ4OXfOOvk4+OXHPQzHNUb6ltvLx1mAeWEzMw=
Received: from BN8PR15CA0051.namprd15.prod.outlook.com (2603:10b6:408:80::28)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:40:47 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::37) by BN8PR15CA0051.outlook.office365.com
 (2603:10b6:408:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:47 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/36] drm/amd/display: Reorder FCLK P-state switch sequence
 for DCN32
Date: Wed, 28 Sep 2022 15:39:54 -0400
Message-ID: <20220928194028.144879-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 89507a53-e319-4b1f-13f5-08daa189573f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkPsAze2s74WbMvLX9WYlHMvkxPVopgytAWq65jmUaGelE3h48u4pvDyYgjZSJtyP9Zhfn9UwGCYezAfm7YMbz38HY+khYOHqcGP+zWdneWRARJcds8XfJGWjdffpygbuKUWKJAFoWU9Pb7cvQQSEdTz3yAUe8IhpPLP8mluCX871m+Ev6TznRrelm009YdGfGqJfdUm6obtL9y3KxHKOwuu5J4RWyiJ+9ODwUetBatpoohw7bA41nUwYfIAojxPyzoIohcr1SGFe9parAg1tNltvjCA4jNDby8RmyVc8eU67hRAk/Eo2KvEyc+25xG1gNImBqEF09UHHeZKNlrWD43sWHOxN2w+qgAPCEXlqPR5ya8mVhbm6qu0tcMKAeRGE/NAfmncAv59GDsB31X2TlFNhLLos3WVMl75jiIyKkoUS2aSCwvsJLeIlQolvXpQTZplwIhHn4hHtD+JssdBX7gMdFwYsNdm9OJUS2DRXqQtQQy/VUz3PvqZzvJQ23XtR4O2jsVvszc0ALi943X/MJICHyixwS8qoKwAVefjQz/RhxWNN1MrgPbBWNjqPT6qJQxHXEiDk7gsCxtdbL1zSi09bUTizqqCqw1nnAX5wsdpCL7y+4AbAaLinsF+6f7PD7Ee3mucELSyfw+WWd1bWyQ/x+X0JAmH67+0u/3AWmo6q4S7CxitkBBLPHD+yJav2/6bqVrotkx13M/wKsPdMeyM5kH0k4BsHRFZ9hI8Soj3Z1bBQVz8tNNOyyEM768BqtxPDYs0HvWVNShZZyS4E2ddJKyTQQTP8OAj5IkW8cEkYBeeyUf2xWMhyyxhgcDP3rsaDAqeXyG2IY/d/qImtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(70586007)(44832011)(8936002)(36756003)(41300700001)(4326008)(8676002)(2906002)(81166007)(316002)(54906003)(6916009)(82740400003)(40460700003)(5660300002)(40480700001)(36860700001)(356005)(83380400001)(82310400005)(426003)(86362001)(1076003)(186003)(336012)(2616005)(16526019)(26005)(6666004)(7696005)(47076005)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:47.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89507a53-e319-4b1f-13f5-08daa189573f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
In some cases, DCFCLK hardmin requests are not acknowledged by SMU as
the requested clock does not have a compatible ratio with current FCLK,
and it cannot be changed as FCLK P-state is not allowed.

[HOW?]
Allow FCLK p-state change prior to changing DCFCLK hardmin.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 44 ++++++++++---------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index f0f3f66629cc..96d5e0d5b3ce 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -333,6 +333,21 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (enter_display_off == safe_to_lower)
 			dcn30_smu_set_num_of_displays(clk_mgr, display_count);
 
+		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
+
+		total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
+
+		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
+
+			/* To enable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
+			if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
+				/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
+				dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
+			}
+		}
+
 		if (dc->debug.force_min_dcfclk_mhz > 0)
 			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
 					new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
@@ -352,7 +367,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
 		clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
 		clk_mgr_base->clks.prev_num_ways = clk_mgr_base->clks.num_ways;
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
@@ -361,9 +375,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			dcn32_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
 		}
 
-		total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+
 		p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
 		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
 			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
@@ -373,15 +386,14 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 		}
 
-		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support) &&
-				clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21) {
-			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
+		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
+		if (safe_to_lower && (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
+			update_fclk = true;
+		}
 
-			/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
-			if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && !clk_mgr_base->clks.fclk_p_state_change_support) {
-				/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
-				dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
-			}
+		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && !clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
+			/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
+			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
 		}
 
 		/* Always update saved value, even if new value not set due to P-State switching unsupported */
@@ -390,21 +402,11 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			update_uclk = true;
 		}
 
-		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
-		if (safe_to_lower && (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
-			update_fclk = true;
-		}
-
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
-		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
-			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
-			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
-		}
-
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
 			clk_mgr_base->clks.num_ways = new_clocks->num_ways;
-- 
2.37.2

