Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEABCD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036E9112842;
	Thu,  4 Jun 2026 14:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wR/p5GEE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A0C112840
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxsyygSFBiv9AkXqLu57gyAQewMefYx3p1OL4q074vsOP/bpKzEl3/wX3Qtu392iOYfzBpSdIV6Bcd6BcS6EWVfP4i8QkVo3syJbuHzTgi4gpjerSrDcjS/4ad8dj0UgYYAWEYpwajlKKL1QJ9BGMnY8o3Jll1xrtMk2eOkQA+uFmegDARCc1+AtVaNyoJpPj9tiYrNpoj7Q3wpwERN9XnXNgDoOPCjbkJg4TLCW98sa6pKaDwIwDuiSSdh5no3hd6hN1kePjL5CUwunS8sLNiAVzOPCXJvjt3QrkCD1UKz9hBAgjBlAbDgTHuCgqL7ERd6CJw+qeq/nTwddsm047A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQSV0Hbi9mMS7V7jhCZMRx7w5kUfCAVCt0R6M1h63JA=;
 b=of6A7jJUcKvvAgtP/SF6DCBr20Mmi+UhNdTrvCILg8JxY20ArUJkmOIPzzU2LsAI3gOdOAWZgTSvjigQXzfrBxkePjLmwjEU0AzZOL8Bgsdq5g5hDuVlqPplKKmczbjsbbDeiaCYLhtj6JEDKEcviMCCJd1btwBdFiMzk8umGxpF/TE0Dkz1J7b1Cx9k5zTJee1m3sas1cLytLMvxPKerSI6a/BXnzZnRVzLsAgBkXmtM8ZxHwaxBnzx6zt6vHgPXAq7Pl38kGqtSc6CHcIILQUFYNloSQPWJbFt6aZoGX6OZE/CBAA/jYn4tlf/c9+RSXjk0pCrrC5cywxxtW/dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQSV0Hbi9mMS7V7jhCZMRx7w5kUfCAVCt0R6M1h63JA=;
 b=wR/p5GEEER4ER7v4kJH5ZoXEnlR2KkKCHhL+rvjaaTgdxnwAEjCQX6LFgg94bCyIDbo68e+OdbP+LYw7LAmjA0fVzkSUfU54+0uzkWdOBQuEH/0sQWmJN0DZTKF6HrPOibbfjHsyb3uGjPampc5xbAor6eXAF3iBHiNa1evehEc=
Received: from BN9PR03CA0237.namprd03.prod.outlook.com (2603:10b6:408:f8::32)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:17 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::4) by BN9PR03CA0237.outlook.office365.com
 (2603:10b6:408:f8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:05 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Restore periodic detection for DCN35
Date: Thu, 4 Jun 2026 10:52:09 -0400
Message-ID: <20260604145428.809959-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 1632635e-e507-421a-8c90-08dec2494aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: kVokZrY1LK0nOKDyV8IUYqfhFICiLii5si1J8bJnyw2ATDba+ywH7CqWMmlq6kJd4y/ThiBQj1g1BzIyLedWLCAAMkBkkTMGc49uPJdO1Mn5Q7mPSsVdVeNeTiHNkJ4FJQFTQze9p2TGGoaM4I0Bcm5Aye0Q8C7yq+G1H/hEVWCPsrnCGK1v18uMEY1+LYbFdxEgRM2PLrykYp9wWfPnZkcaUpy2V+KmmeeM2HoUrKhSi7MpkSK3j9cHG8CvBMVe7QAsxxL3KQ//wKJMRXVCCGe5npenKs7yLDmKwlwl6woIjw5K5uuM9xZIpscQTWcNLzW+n9jhqFHq9Jx7dx5wpmVXNOnnIoq/54PeBVjwp55xQutSxdllokEjrEUJ7QrdUOa10Co1Z/qGBuWG618MnsI5FGstO/Xm/9+dhKsm0xixfyMlKj/52O0MSkFoxZjWYWylEyai2y0TgfypCczWMo4opSICay0HayQ1C1bGACRqe2vUIUrpUBccMVKY/wDExuFfIHnZo1zBsSBOg2tQlBNdoajU0Fl4OdiEo2nIg5WzQj0+x+k55Uh94WAXxuY3VBrkZcURB67KoPhWEIVRNUQ7x/wSonlHhqXhllKqo2uOYg/cIKMgM34DNM1qVjWS76UE/D/a27wx5KLNgYVVnOjBnfizKr16oU5/Mnek8FF2lNOuzkSZlT8ANLSqR65h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g45H7S11QEJxj/vap91GOMp1veS8eRAeczUItrKRji18NmmoTLBtgChJjlZFR2MKUbt/zM3NlylXBnkmTtPL/xiY5r484zs2PehoRlGqaBgRWGLyPMJRqu6ovU16//5iT0NAkIzIvY8SEskPNcaVAkwwGvg1fADLBImts2tmSJ0lPKXNWlHXpY4WzeJBlthyHJdmqpPizqDv4sYkcWrmJ2ieDmPV1vrKMawtgQxSaLMVGPZCPg6TCI+3QgMNrfqUBJR9b7qiwbjxrezNnPCZx9nA+xPyqyUUwr0CIcRT+3C1gNevgD3Gnn8JqFQBL94ZyVLux7retEvhP825ElkfiUNEu/K9j+Bftr7+JvCtUZkh4gTb3k/xVHhWQRDfxH4D4WZy3jMiI1Gj7rSULR5IeZ8mOJ3+eQ7Ru13pqjdAXfDa0+irTtIi3oBKhe3roqie
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:17.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1632635e-e507-421a-8c90-08dec2494aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Periodic detection callbacks from DCN35 was removed for higher IPS
residency causing some displays to fail to recover after DPMS sleep. The
monitors bounces HPD ~1.2s after link training, and without periodic
detection the system enters IPS with no mechanism to wake and rediscover
the display.

Restore the periodic detection calls in dcn35_clk_mgr for now. It should
be replaced with a proper IPS-aware solution long term using DMUB.

Also remove it from dcn31 and dcn314_clk_mgr.c since they do not have IPS,
thus should not affect them.

Fixes: 3f6c060846be ("drm/amd/display: Remove periodic detection callbacks from dcn35+")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5318
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 00c4be7c3aa4..ff47af3854b6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -158,7 +158,6 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn31_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
@@ -184,7 +183,6 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn31_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index dd6f11ecb9c9..24f6304011ae 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -230,7 +230,6 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn314_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
@@ -255,7 +254,6 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn314_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
-			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 103013e2a0de..a69824e1eb26 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -419,6 +419,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn35_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
@@ -438,6 +439,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
 			dcn35_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
+			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
 
-- 
2.54.0

