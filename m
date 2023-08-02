Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AF5C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E00910E4BA;
	Wed,  2 Aug 2023 06:53:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1370C10E4B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvL+DNACoF99NEP/VAPOkiipOHUyCfmrjqxke7wiWPTY6ECD2ikPnTeHRoBmkDFHKFuPTSeFwJ3TotAKibo1Wr2dklpbRBtzum/Tudv28BBMcpUtx0ifauuMijyVdCQ8DobR51WAs2XFFbRhpkZxWuPpgQLmwKlglloGE8jeJqM5hBrPnJJo8OqA16X3e3oRb9JOOEjbgzh/kKfCbdL3uUTG5gwPYwv8qAp0LHm3WDjQeZ8Dd6yOWXDedJ+jGXeD6BjF0xVfYjH8ni5gEAF6fh+ibpF8RY4JejRT/stYUVjxxQTRCzc+3cAtHhK4Iv4vlB4BpZOIquiu/jqt2lv+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMlg9jQxpPG44RffVblurc/BbnjBRpOydAVPufGkO3A=;
 b=LhjzlJUgEUAtkJcLecBgVwtDJOdgETFs34YAXCOOfrAw8DaIY0IBNx2QuhFDQWx6Pl5bZrPn1G+RAn1yaJFN/9PcabLjVhyDzhTYih/KtJI+inquvo3tYlssxkl/0HtWbB/9LCTc6wT61ZgFOFQ5MR9Dc1Q1uecHSdlTVC8f2vy+Iq2WLig3CaeVTi/2m08OIn8FKYENUrr2hUZjmrXPjdGQv0mXRVeoKz4Jh1Jb1WBTC6V4t1paI4V3ObBKoBC8jOyGi6gdijMVa3iezYZyslQpj1HIs92YnJ/yg3XU2fcK/MlsavqEaVK7uhCtMAp3CsFyWgTJq7N6nihWNYbVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMlg9jQxpPG44RffVblurc/BbnjBRpOydAVPufGkO3A=;
 b=JZzBscVSh5/IiQN6vycpFgPVJsuTGv/5FJpj6M0M/Z5xRNBDELig1lnKct5ZkhIXT5p8BuL2LjgO4ktAJMUp+8+ZFSjV6N7Pf8BwUUih74L9I6ue0GKte5g8x196iH/empa4vFknNDeRiRuU8jXlr6FeVBZ7OLolwRRp1uVB1UY=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:25 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b9) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:24 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:20 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: Use max memclk variable when setting
 max memclk
Date: Wed, 2 Aug 2023 14:51:27 +0800
Message-ID: <20230802065132.3129932-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ebec08-caed-4b61-ee53-08db93252b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9/Bzg6cs1tGhEzNEQ2I1QZeWH+I826BsTrKiFmadJHJUCn8NZBmYzj4benA1ctB2k2qIoPJz6X031GLbncmTe9qEMAboF6eXYW6MAtwdu5oPmJ4NIHFtWfXFGH90VhuzfqF8cCaCb3mlsdfcV2lD06CamtlGGgaSutLzqaw8fKKGNeDK7AbswjGN8Ei4LKyzJaKRHe4BbDiUlb3RjIO0cS2pdLQc0wjh/7zDph2EC14WsuuZPc8C5gPgiKYSLZ0LS/oslKwYGrH2eEM/nq14RAvmfEQpye+kPk0MxDsMoQZXuL4fuhY1DelRZSB91DHlKXcwo6MYRFIxmkVqR3lwj6JtUNEjyEDLbh1/EBpp4FFr4k/tba0WEtDLlgJ0u5a3fCMTaTwm1RvS+XCGGXxC+Dh58WL5A3JzzUrP+eW3JgNTCD6toxJthHGxSO+5c8TONvgqbn6KpoenLld1j6CCmSYioBjJqILQAFtZwlvbRTvkPPCoRdhUAhnoxasuDYyrT2kqIXLBW5qNPg5qfqI/8BDQiHCl4wiZqX0znzL9Xz3aB4BwtUNkySGu8SaPm+0dFs9T/zz98vrzvX2i6BvQg2ei1BMb1HGm+VgTLCyN42pgD4ORUKrA8Bi2Vqv7UUuUfgOTbGfBqbKwwxIizih23aupC80pJP7a+fidBGC21RJgJs12ztJUadWqQ+pGfEakTA7QjMXf1m7fpqWcGkYeBMj/Ba5XTVZDy/RCsqVLEKHSd4IHxip4mnJAie0i2y9xGSKBGx/1P0aWmixrzPVaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(426003)(2616005)(336012)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(41300700001)(8676002)(8936002)(7696005)(54906003)(478600001)(40480700001)(356005)(81166007)(82740400003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:25.2415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ebec08-caed-4b61-ee53-08db93252b5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
In overclocking scenarios the max memclk could be higher
than the DC mode limit. However, for configs that don't
support MCLK switching we need to set the max memclk to
the overclocked max instead of the DC mode max or we
could result in underflow.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ccd60aff19e7..2f65591d2f62 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -802,7 +802,7 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
+					clk_mgr_base->bw_params->max_memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
-- 
2.25.1

