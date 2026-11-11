Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2F606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jsJ1zKqc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A130010F8C0;
	Wed, 11 Nov 2026 01:41:35 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1021710F8C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL0S6uw4rb5oxCdymjomlnJJyHOqAXOTCkrrEIpBi9YVNgGxAN9l7KYyxcVhg4dLWgxFMetVTS+VNuy+ZSs50xPhUhumGtN7ZXd7AbgI1iyuUp9Taj5QxLWYrMSq5NQAGSwKILwhB2wmzJrFBB1ysvq1Ar/zq1jwmm74jlt2ovdwBlYAkGx23RhLhbslMnnrM3XEzCKErjlrF7380b7KB3u7qDN2pQteCfcFYT5XtFniCMINq2eO6IFi89OehCFcUv8rJSfUhai1fXhW0o5090TlCpZb7VCqWc4cvFFG6U0zE7+MxbD4N06JhaNHMqQTjtT9RPlBCSvq69MhvliYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1IwqkG79pf0m+h1CjPKUjomf8TeD7jEnkR3UHEZVy4=;
 b=SINMZFuhBNVWiU8mMoxDJuYEmo+hjqDy6DBBcaU49ilsHW1NaDzkeTzcT4//a8LR7Xkkaf4Csm1TQ521NkieyJ9LTtrjuFKicHx2EFik4ASFk6Zi8PW9uCGIZtNO7rqQr2is9kxKHsc8H8Vw9FSymiEjdtg8NcPHWbz+XxeTpq30QvwKaBsPmfnBSbEKf76BGDM5hHqo5xbeQ7i69CK99my1Lvefngo54JdIHHfhlZh9MXnz7SQPi786X3jSXtImyxBGPZ9/7/weFM6MAkhBOuKcKohEYLvRMZGbVG/Ko9LYyWlxmYf8eCMi0UtrzmtJxijXIrvDpIqX5wwhVx5AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1IwqkG79pf0m+h1CjPKUjomf8TeD7jEnkR3UHEZVy4=;
 b=jsJ1zKqcO/HBxbEuAurkBvCB54oQ0ShPCxo4wo0C84Dbht2bI0WBZC7geLwpO5OnCct/MgPS237RSO2b4/6OCQqqFjwQoM8bdRGR04c4VC5AFl3n022Ryz1W2CuWjS4X8l5i2oJ6PPC7LDF65Qs7eOi0GD49IevKtkwEmP/a8U4=
Received: from SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:41:24 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8c) by SJ0PR13CA0083.outlook.office365.com
 (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:20 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:16 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 15/74] drm/amd/display: Update indicate pstate enable sequence
Date: Wed, 11 Nov 2026 09:28:21 +0800
Message-ID: <20261111014100.3596072-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3d084c-1c74-4556-a999-08df3f94e57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261026140227099003|261021123027099003|11063799006|261022105027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|261028144727099003|10067099003|10063799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: uX8kCEFBSTm968FSOm9OQC6VqMCNbS2DG+oV1J28wBP3C7dlRmEZgJXP6Kp9GKOh/dh3lZBH7Tw2lWsZ+sMLrH5WRnfO0oPUsfVzb/wbrqL6Is4Xi4jG0DY6XZKGdz70AsZVxgUXRzIoKd4q/rVRcPf14BU0/5IEY47AYk0aNSZqaqTl+5vjm9Xk4cHqKM1LS9S2UUK+hq1nvnp8vUHRk0l7riF2A2PhyIq+S7t55Y08Ry6sPPRz/kgW91ykjffRJlnOinG8FMasVDLsWpvaduYfmFMTj/ieIjwr35Bmo90j+39AWAR8KRHmprUOpzwHEsL4FCddHlza43oQRwcoOCWSu0JOBfM/MB06lWyWyKq92j4dU2TusuRlLFrShbVTB+VuspiPJMQO34R82lae6+CrQkOIZtDxm3bIwCi7tWM81Q1BEfpVhu/6xwAiW5fSpg318WzuzLdBC5qIuyOyIWjK0qjsaGW7GdVokCAFzJShzrBP8zy3VLHKELAqvsOrbYLSv+NnVggahxo+KHWthjeM9zAvCm7wrmpCl/NSjb+tzAm/BnfCrpvpPkRNC6Xk3BDJL9XEoAfZlYxLI59Ldoqz6cn12SfJcnL3QNPzooqT04Khtu4u2WnYJRJ56FPXpr7AoLfnqUC1npVKylTtjAzL21Pb3IDwM+GKi3AiUPKQQIaZ8/ihwlo9i7OdM3ifxpCr7NeXda1jRvU1r3fyvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026140227099003)(261021123027099003)(11063799006)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(261028144727099003)(10067099003)(10063799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XSbLx6pNIyax0IfTJ5m9FvtnJHBkPpKeifJAyy34vDqMbSbbhXuGb6dwINzOPH1D4Urqq6ISzt+KubyyVEJ5CrnXH0XO0Pq8V7CL1wd3vWYLEIT9RJR5imk0rVqvc8lZzOLldwJqoT2XqfqWVhZWh2Us8tFyXSGZ8wULOsWeXqAjpJRKdAsxq3v9Yz8XwOTDOqKx48ESCTLLtlgI74hS/xvKMOI0gn7AMxyFJrDedJ0wh+XCWTt7itH95irpk9YwCu0xICVhrc1XeTBPFtc/rVEG2n3B1Nc47BHU/8kNnxWGidja2oQ86dn2uETAaq/pnFYCeul+n6g58ur6e4wfGuyUJ/xVO7zfQYG3kGauPCPnT/uMTOIIzCYy6IKjDn/mML8f99UE/emHCfXbIB0eQI8pYYTP5Lb9c2mV52qJWMJFFhZW4DrkVcFq5CZFe9fT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:24.6691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3d084c-1c74-4556-a999-08df3f94e57b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- The enable sequence for indicate pstate status must assign the
  non UCLK / FCLK params (alt-ch, wait_resp, etc.) correctly.
- This fixes a bug where UCLK is being enabled (but alt-ch is being disabled),
  but clk_mgr still sends the pstate message with alt-ch enabled.
- Only UCLK and UCLK will be sent with enabled status on the first call
  because this is required for the UTM QoS update. The other status bits
  must be correct from the start

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 35 +++++++------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 98d146bc25c0..4242a4b5c902 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1370,6 +1370,7 @@ static void dcn60_make_bandwidth_clocks_update_action(
  * @block_sequence: output array of block sequence steps
  * @action: action struct populated by dcn60_make_bandwidth_clocks_update_action
  * @clk_mgr_base: current clock manager state (read-only, used for original values)
+ * @context: dc state with active plane information
  * @new_clocks: requested clock values for message parameters
  *
  * Return: number of steps written to block_sequence
@@ -1378,9 +1379,11 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 		struct dcn60_clk_mgr_block_sequence *block_sequence,
 		struct dcn60_bandwidth_clocks_update_action *action,
 		struct clk_mgr *clk_mgr_base,
+		struct dc_state *context,
 		struct dc_clocks *new_clocks)
 {
 	unsigned int num_steps = 0;
+	bool no_active_planes = clk_mgr_helper_get_active_plane_cnt(clk_mgr_base->ctx->dc, context) == 0;
 
 	/* CLK_MGR60_INDICATE_PSTATE_STATUS — enable */
 	if ((action->uclk_pstate.enable && action->uclk_pstate.send_message)
@@ -1394,14 +1397,11 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 				action->fclk_pstate.enable
 				|| clk_mgr_base->clks.fclk_p_state_change_support;
 		block_sequence[num_steps].params.indicate_pstate_status_params.drr_enable =
-				action->fams.enable
-				|| clk_mgr_base->clks.fw_based_mclk_switching;
-		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp =
-				action->fams.enable
-				|| clk_mgr_base->clks.fw_based_mclk_switching;
+				new_clocks->fw_based_mclk_switching;
 		block_sequence[num_steps].params.indicate_pstate_status_params.alt_ch_enable =
-				action->alt_ch.enable
-				|| clk_mgr_base->clks.alt_ch_pstate_switch;
+				new_clocks->alt_ch_pstate_switch;
+		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp =
+				new_clocks->fw_based_mclk_switching;
 		block_sequence[num_steps].func = CLK_MGR60_INDICATE_PSTATE_STATUS;
 		num_steps++;
 	}
@@ -1443,24 +1443,15 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 			|| (action->fams.disable && action->fams.send_message)
 			|| (action->alt_ch.disable && action->alt_ch.send_message)) {
 		block_sequence[num_steps].params.indicate_pstate_status_params.allow_uclk =
-				!action->uclk_pstate.disable
-				&& (action->uclk_pstate.enable
-						|| clk_mgr_base->clks.p_state_change_support);
+				new_clocks->p_state_change_support || no_active_planes;
 		block_sequence[num_steps].params.indicate_pstate_status_params.allow_fclk =
-				!action->fclk_pstate.disable
-				&& (action->fclk_pstate.enable
-						|| clk_mgr_base->clks.fclk_p_state_change_support);
+				new_clocks->fclk_p_state_change_support || no_active_planes;
 		block_sequence[num_steps].params.indicate_pstate_status_params.drr_enable =
-				!action->fams.disable
-				&& (action->fams.enable
-						|| clk_mgr_base->clks.fw_based_mclk_switching);
+				new_clocks->fw_based_mclk_switching;
 		block_sequence[num_steps].params.indicate_pstate_status_params.alt_ch_enable =
-				!action->alt_ch.disable
-				&& (action->alt_ch.enable
-						|| clk_mgr_base->clks.alt_ch_pstate_switch);
+				new_clocks->alt_ch_pstate_switch;
 		block_sequence[num_steps].params.indicate_pstate_status_params.wait_resp =
-				action->fams.enable
-				|| clk_mgr_base->clks.fw_based_mclk_switching;
+				new_clocks->fw_based_mclk_switching;
 		block_sequence[num_steps].func = CLK_MGR60_INDICATE_PSTATE_STATUS;
 		num_steps++;
 	}
@@ -1552,7 +1543,7 @@ static unsigned int dcn60_build_update_bandwidth_clocks_sequence(
 
 	num_steps = dcn60_build_bandwidth_clocks_block_sequence_with_action(
 			clk_mgr60->block_sequence, &action,
-			clk_mgr_base, new_clocks);
+			clk_mgr_base, context, new_clocks);
 
 	dcn60_update_bandwidth_clocks_state_with_action(clk_mgr_base, &action, new_clocks);
 
-- 
2.43.0

