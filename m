Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F41C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCA010E1C1;
	Thu, 20 Oct 2022 15:47:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA1410E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxATfjo4aSXi1jqTcPvW3fZRLnu5yAzmCycL9dKY5/bVSh17pWwrX79s6fyhhj9JoFlLWnzF61YbbG6udjnDwG33ZCsa25gy9HUuSPYpmI7TBb+tGBBV5qEiFF+XWK+Owm+MBRAmxBqpMTF8ZS6Ze++d5ZuItkt4KdcVEChP37uGs5Qxgc836Vf/Jmc2Dtma9HwfkiO/MoeVGAGYZZxVn0kQS6cVVeGSPxC58YQcBnifJDOq7RU54wEf0NlRuoGZ+yClZQjTjymYKnbqCQRU7IcdRTkXVs/UMTJSH67ITol2AXVCnbo9D0m/J7lGT51Y7lsxeCPAbI4dquX/D7aFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYtFUfKfk4POS3h8Lkan+fI1p0US603Sr8pRtS8rsC8=;
 b=MJCkhA5d0YNTkzgVQlJWia0hYeOxcpL+Qkvl5NkesAR8R8hOGtGCxSKzpBuW8BNuWRpOj38mFnW/OtIIUcgMdc3+iT/wMDHizCA3VM47iRStQlCT6HynrTy1fpTo/4CeUT49HesisdjRyb07FmewPiXEtaeZXpfEKWrlNS9kEr5YYSiEE+c+QppmnDO8ry7kYJRr6eVniiKegcQuhjKIMf+LHS3d0TObHdNqskj8siJtq9zOgdR3Xp3RAyY2eUi0X1XXPiXz0YNKeo2lFWMBb5iNPkxtqkQrwYiEsTOrl0TX86ej+G1hhM5O9qPpT+BYhG6/MKqFy/rzn8icH03fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYtFUfKfk4POS3h8Lkan+fI1p0US603Sr8pRtS8rsC8=;
 b=MS1PcUBqLvONq+CF9N0tmhjM/NsewlFa23OVprgYPcvdk9sRB6hqpUDbx+02b56FYXCU7GQ5gXkILxKTB0WN3ZHhG9IIrwhae4xbrX5/bqKtG8PVPBi4R7pNEaU1FrsAkUNIWM+/6gF97v5/1W1rVwDzoyckaohjxGTPeXQDVhQ=
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 15:47:34 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::9) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:34 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/33] drm/amd/display: Remove FPU guards from the DML folder
Date: Thu, 20 Oct 2022 11:46:31 -0400
Message-ID: <20221020154702.503934-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: baa2ebbc-7d31-4be3-f789-08dab2b267e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXXKD6QNxAm5Eoi+xm7zFMY10xk4X4EGVwue4CD4Ks4o8Nn+F9dxRQdY6QiTuUq/cfFI3tzM5P0c2lMjL7e+DWvlr2H1Oh08iSYwm+ctD6+9wockOe88BOEDRP/ORkuEmSHHY2YeYvOnZKwEt9mbo1SmRuj/WExf1Kwplqv4difH0/95F2zTemLoBkcnSV4yas08TP9FqotcBzl5kvrqeXB7Ox0eTVFQluV1FFSQjLwQFvdp4K453hyxNNAQ4xh/511Cg9FHnc0AfiiOGAM9QYEHGZ6114ZkWABa677CoHk0dLnGizTUaU7xNJYDQ8RSGv8i97e8L83CDP0jePtBpRsKEIFz/JNb8mboMxs9svW1ja0pZD86zUwc75qbvraQ6L3P4fqPwU58cVqfocoy64iz7yYvQGv5zu0WOLeEZvRwC73DuJV+eqfAl4ghq5904OWM3/FqAKwYMtM10VB082vS7nn9YEKciNBhD8wyHemMq5Oel3zAwrfj0JpDdSgLc4/c4yLI1Kmntbx16EngRx16cM09lJBMHW46krmtLwd1ZPGRx/wayJgZI/mvKdx0xlhB87wadju/cBUOLTwnfw513ZX+in338y1i1poHGp9XXW8wQS0xBxTPBk3GS8yu1RzvBZ2Apn5AolFACpegRKqwcZjY0IBxTF6oSaQ6prFXbY2EBvUqT7lCM1ZKVpXN2z5Rq1CF/yCfLNc7I+eXTEwcpMkvofCR5bH0Z1Z9hXv5wPlA8OuXzfxb6d+aLoOJNct6nACR5JpoKB7nKJ1yqtospC75zKbRsMkCA9iLGPixd1qEVvcaGAfKcvkjN3Ml
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(5660300002)(2906002)(4326008)(54906003)(8676002)(36756003)(6916009)(7696005)(36860700001)(478600001)(8936002)(186003)(40480700001)(40460700003)(26005)(70206006)(316002)(83380400001)(426003)(356005)(47076005)(82310400005)(16526019)(81166007)(1076003)(336012)(2616005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:34.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa2ebbc-7d31-4be3-f789-08dab2b267e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of the programming expectation for using DML functions, DC
requires that any DML function invoked outside DML uses:

 DC_FP_START();
 ... dml function ...
 DC_FP_END();

Additionally, all the DML functions that can be invoked outside the DML
folder call the function dc_assert_fp_enabled(), which is responsible
for triggering a warning in the case that the DML function was not
guarded by the DC_FP_START/END. For this reason, call DC_FP_START/END
inside DML is wrong, and this commit removes all of those references.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c    |  2 --
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    | 17 +----------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index e1e92daba668..d4c0f9cdac8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -520,9 +520,7 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
-	DC_FP_START();
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	DC_FP_END();
 
 	if (!pstate_en)
 		/* Restore full p-state latency */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 819de0f11012..d8e68f13c288 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1191,9 +1191,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			}
 		} else {
 			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
-			DC_FP_START();
 			dcn32_helper_populate_phantom_dlg_params(dc, context, pipes, *pipe_cnt);
-			DC_FP_END();
 
 			/* Call validate_apply_pipe_split flags after calling DML getters for
 			 * phantom dlg params, or some of the VBA params indicating pipe split
@@ -1494,11 +1492,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (!fast_validate) {
-		DC_FP_START();
+	if (!fast_validate)
 		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
-		DC_FP_END();
-	}
 
 	if (fast_validate ||
 			(dc->debug.dml_disallow_alternate_prefetch_modes &&
@@ -2145,9 +2140,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// Insert the max DCFCLK
@@ -2155,9 +2148,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
-	DC_FP_START();
 	insert_entry_into_table_sorted(table, num_entries, &entry);
-	DC_FP_END();
 
 	// Insert the UCLK DPMS
 	for (i = 0; i < num_uclk_dpms; i++) {
@@ -2165,9 +2156,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// If FCLK is coarse grained, insert individual DPMs.
@@ -2177,9 +2166,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
-			DC_FP_START();
 			insert_entry_into_table_sorted(table, num_entries, &entry);
-			DC_FP_END();
 		}
 	}
 	// If FCLK fine grained, only insert max
@@ -2188,9 +2175,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = max_fclk_mhz;
 		entry.dram_speed_mts = 0;
 
-		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
 	}
 
 	// At this point, the table contains all "points of interest" based on
-- 
2.35.1

