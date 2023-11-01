Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B41C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2E210E77B;
	Wed,  1 Nov 2023 20:08:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0697F10E775
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDlAp25JTnQSYi/i/sHcfpDlU1Kx8sMJ949aF+H+nbUUg9IMlsFYvfOoFJOmBsNhJjxJ/IzTZdc/xK5ub34qx3twKASZKMZ8TXz9QTMgzxrs60UgAVblCkO9j3u48rQttm5GNHFf6amqhPJobAN3an+DbK64GioO/mmx84ByqjY1bK5Q5q0+dmv9CPH5EtentifPrMc0t4oXL0dt9wDitDAzH5noY2/LTAettn6G0pM09QPED1YvFeP98LbYJJFZlkhpG7NwrsG4y6dj97phq485Xs+XlTFGpwmirxezBpeP8wB+Onin715SYH9IcMXKSAUVlyDeK+1zjrOZlV7GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfsg4yUOzUrpvdGk5mvbg8q/BQelNvOcvgKFSjAUYbw=;
 b=eaCzLCL9oyDHuAq6Ng2JPGaG9J0zOQAr82nMeI9YbrgKy9wfaPvzXayz39KtQu5dR+4AjwOHVMpA3MJN2SgCQoJQKX/1/r/0Cyq4T6lABaNhZ6s2yS4QkGRnuarrn7+IV+00cHmbXm3RnafM4tewhzfLDoFPV9gxyUQ1dRLS9eR0kzr1CPIrMLyIUZzTiWhiagTqsSbJFA1ykiOE8FdynzLrg8Tn5XSXMJq0lQ0WO/8/eWw2xzaYsjXba+G3tFYI6qLkIILL5YohYbdus4JrwwAj9sHSBocGwrs/TstbFLDI5H9CrMncsFzfScYO2R2PzGjlqH8ZFQ1RJHAsWN2u/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfsg4yUOzUrpvdGk5mvbg8q/BQelNvOcvgKFSjAUYbw=;
 b=ZQcbO+b1Hit1ADj5CC5BHuXhrQtfWKJnap0GqDaGKCRM7Owm+h53dLeLM60ys/Ty5wWpYid4i7TCVg2UlkeJX5mk+VT6KRRoBnTTHcSc1TC76RIdVCg5xjund7o0IeaANxriIPsReVa16vCQHi3DIEoMlL2Hqyp16luaWta1geo=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:08:47 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com (2603:10b6:5:1b3::4)
 by DM6PR17CA0034.outlook.office365.com (2603:10b6:5:1b3::47) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:42 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:41 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: save and restore mall state when
 applying minimal transition
Date: Wed, 1 Nov 2023 16:08:21 -0400
Message-ID: <20231101200832.995436-2-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 2974c69d-9d98-42ea-afab-08dbdb165b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xZNsCBka855JCFwDm1jlCBsL8CpJEInQtvc9jwPVaOrW7BydGgtqPRn3bgN0RhOlbmpaAylDo/+/pVT6vW6yLNavQhDp9pPGxnr/zRfEHkhQYdo9KP8onmXGAis+GZzwWaWXhZSDauuE3+poIOAY/rIEe4mO5yRaGBmWTUC2lnEatx+ujle+EBx2YNIIdOxtt8Vjpi68pbYUFoUt3KzCqH9/J+eywia7rS2KP1U6nTHSF/6wyGCDbuj/YvtLjIy854sy5wa/ZUqTulYjlPkye/70W3iJe7i/d8V8zb011WaCX2hagDSHYllw5L9Nmmd+NDngaGKzW9aPLOCTVHuQBvDAoC3AL65O9vNNNVbz3TZgtN/p1QroYiaaiZFPoTO+OtI6tQJ7w7jjuy+O1MI2tnEqZgut0ti8wckQc29YLvqLlXzRfN0iJurwt+0LuZmInBgxzhRD6uUPCX0vllxtrhH5+yRaXmOMriVZxMXOCMqxDn9VwTo9JFTA62WBEskJjfg9jBAD9o3K9b5xID+r52r61stXkmkXnTlwRYowhMXcdt6dICsFoqLwOKFeoX3vGTAOrBTOL7fz0uhoPWnENL4wJaUwPo2LiMW1ncGjWFKWzwDXTWWh+bVnTGAHtubouvMRBbyLFVaqsEB4Af86Y48bxCT5g7XPtD8sO+EfA3ySfaOiGGu+ozwQoZdKYxyn+OvqVNkzbQ6PoP/N8sHm2GOuaqPg2KKT9eX38TE5F6zY6tmHRf7Qmxl4BZ6eQPSZU24HkZYybd4ru7ze/ezSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(2616005)(40460700003)(86362001)(82740400003)(356005)(81166007)(83380400001)(36860700001)(5660300002)(6666004)(426003)(336012)(26005)(1076003)(47076005)(7696005)(8936002)(70586007)(478600001)(4326008)(316002)(8676002)(54906003)(6916009)(2906002)(70206006)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:46.8506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2974c69d-9d98-42ea-afab-08dbdb165b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a case when we are switching from ODM combine to Subvp where
minimal transition based off subvp state is required. In thise case, we
need to save and restore mall state when applying minimal transition.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index de8e5b18a12c..7b9bf5cb4529 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4116,8 +4116,17 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 	bool success = false;
 	struct dc_state *minimal_transition_context;
 	struct pipe_split_policy_backup policy;
+	struct mall_temp_config mall_temp_config;
 
 	/* commit based on new context */
+	/* Since all phantom pipes are removed in full validation,
+	 * we have to save and restore the subvp/mall config when
+	 * we do a minimal transition since the flags marking the
+	 * pipe as subvp/phantom will be cleared (dc copy constructor
+	 * creates a shallow copy).
+	 */
+	if (dc->res_pool->funcs->save_mall_state)
+		dc->res_pool->funcs->save_mall_state(dc, context, &mall_temp_config);
 	minimal_transition_context = create_minimal_transition_state(dc,
 			context, &policy);
 	if (minimal_transition_context) {
@@ -4126,9 +4135,20 @@ static bool commit_minimal_transition_state_for_windowed_mpo_odm(struct dc *dc,
 			dc->hwss.is_pipe_topology_transition_seamless(
 					dc, minimal_transition_context, context)) {
 			DC_LOG_DC("%s base = new state\n", __func__);
+
 			success = dc_commit_state_no_check(dc, minimal_transition_context) == DC_OK;
 		}
 		release_minimal_transition_state(dc, minimal_transition_context, &policy);
+		if (dc->res_pool->funcs->restore_mall_state)
+			dc->res_pool->funcs->restore_mall_state(dc, context, &mall_temp_config);
+		/* If we do a minimal transition with plane removal and the context
+		 * has subvp we also have to retain back the phantom stream / planes
+		 * since the refcount is decremented as part of the min transition
+		 * (we commit a state with no subvp, so the phantom streams / planes
+		 * had to be removed).
+		 */
+		if (dc->res_pool->funcs->retain_phantom_pipes)
+			dc->res_pool->funcs->retain_phantom_pipes(dc, context);
 	}
 
 	if (!success) {
-- 
2.25.1

