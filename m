Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67018C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A8610E8B2;
	Thu,  6 Oct 2022 21:27:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B0110E8AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhiG/cR0xRLM07sS0u46Ec5dAhqS0aFoBDAGeedM4IihvX1ovKi2Tv8I0Lb8TeAbeQC84AFJspRxmeyZOB3hp84OYs2jzQl3YQds4NTPI/kwJIsZTNGWRA83Xi03PZBDTvRQVKG+QjzSenni1+5xnjjUefyOb0bSOY7v7jPydSZrOVThOA7yLUCcJy6JxEBbU3pL0eNU7Cu0LnHJE9KIepE21R96bReiSfDTgGGzigo0o6E7WWB7xEuvHgKFWI5tpr34IPJvUT4Us5ufq8DNrrRo/BM/IGD3KAHKEevcHkZBfbGez4wglzb5vABn9d8u1UiqvZNZKb5bQVwylom2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRYpT2t2IkXvZPNRkKOLxN3iMjV+M5zOm9Ch68EFbkw=;
 b=iCRp5DANkBJ1ZNgfLKvZaOfer+ofa3EjiwhrNuCPuC9DWa+oig1030yYxejTzHzgvEbSS0KT3w1aqDQY9QKP7R/0oPNyoWHFXB4BFPl7rKH7VAgSnJBbkxzYYfCMXLiOpzIU5xeyy7PsBIvA+p4iAzshfjZ+jDc777hunSleZQDRLVaLhRGM/6O6Qxn5BnZZJVp3iT0AzzkJTboInfXiqHSvQLj91Hp3NR0cybz0QtRHSxvtajpzE9zYOUgNmuoBSaBGs+VN1sd9PZwCq05RXrnuVBt70tpYD4dpk5MvqffJw7uKKETxdtPLO7H4uusRjHmh1VypX7bqWsX9aAOoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRYpT2t2IkXvZPNRkKOLxN3iMjV+M5zOm9Ch68EFbkw=;
 b=d/mbCW4Is5dHpIfykaePk+ktrfzfoVxeDnrp7d8gqovhqZuGVkvnaurOIFuO4UDdWmLPanauFizVVPaLSC271CkJI2SAvn2b+FI9vS2JdjG8mGebCRriL8ZGKImK6JKJNQl0D4T1pX1FtB/kgPaVVsBV++DnaW9CcZ7/hZsfu5A=
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 21:27:39 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::95) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/23] drm/amd/display: increase hardware status wait time
Date: Thu, 6 Oct 2022 17:26:35 -0400
Message-ID: <20221006212650.561923-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 15683317-ef84-48e8-0965-08daa7e19853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ch9z7kInjqC8R9LRuYeeH8vjveC3LuDUQr1p/SewBDTw0J0eAcuX2yKQQx129bT5njOvPHiWvU4KRNn286fxNOgIgC5pWms4O4Z18z7xNEV2wHSyq7dSd1lk6O/uZRDRhrqPpK2RGdN+DgdEj7yhm9UsL87jEMYV8nS/EyB9DLh6etTW56PH1ZAcuBMmtrH9CU1A8LfCMB4TffTNXpOC49PCBPVCbCKMxaqvcEp5QWuqzyin4zRyNcxNWxIorUS1+tmkmScay1ZmGwr7uLy2IrFZiWdRDdIS4FOre785KIpBwO9RVsEsBbCj5s/CfpAaQy1Mwr1axmiJS25f2zf7AN0/wx6wW3+M1SEmdIyqp0jLBSpA4pwtMtATctFs4bH+hZFBmRj7NMnjm2xayAIqDLo/nFJ0r5WIezWbQyeRccxjqaC6CNoxU8J9Ui5p8zkT3wf9/Shr4RYYEEM6Y17/qkx/x1bYhmbvhfDKOcNQyrW94kNGVxhepXWtpmRvgroNpVd1eDQE0k3tS9aLVEgbrCtyja0ZtARlzhSt1Fa4w0RK4ARLwLwLV2V5Jd9y8hGYzbuxgwptHl2RuL5vlGu7fxyukiBUucLe8/yPlgA/mB4puqF52w80Q6Bws6R3wpbRKpsHcpVGqOiVetumeZviryKktM6RpeagB6S99wcfM8dE0KgTJS+5K32s9XKx9Zt7dGPao7kkFhqoagT3U1wLlvF3xow6svlzlcBu6DVliyJy1ZBs94ypHR6SkjagFh97OoliBK4kPbYPgoaZBKteoshV9tGGyhPWH88WzKG1U5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(44832011)(5660300002)(316002)(36756003)(478600001)(36860700001)(70206006)(70586007)(6916009)(54906003)(4326008)(8676002)(426003)(2616005)(86362001)(41300700001)(356005)(83380400001)(8936002)(40480700001)(81166007)(47076005)(82310400005)(82740400003)(26005)(336012)(186003)(1076003)(16526019)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:39.0780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15683317-ef84-48e8-0965-08daa7e19853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: stylon.wang@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
Diagnostics reports exceptions generated when
timeout waiting for DISPCLK frequency divider
change expires when testing ODM4to1.
Diagnostics reports exceptions generated when
timeout waiting for OTG busy status expires
when disabling OTG during ODM4to1 test.

[How]
Increase HW status waiting time for DISPCLK
frequency divider change and OTG busy status
when disable OTG.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 0d30d1d9d67e..650f3b4b562e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -179,7 +179,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 	} else if (dispclk_wdivider == 127 && current_dispclk_wdivider != 127) {
 		REG_UPDATE(DENTIST_DISPCLK_CNTL,
 				DENTIST_DISPCLK_WDIVIDER, 126);
-		REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 100);
+		REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
 		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
@@ -206,7 +206,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 
 	REG_UPDATE(DENTIST_DISPCLK_CNTL,
 			DENTIST_DISPCLK_WDIVIDER, dispclk_wdivider);
-	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 1000);
+	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
 	REG_UPDATE(DENTIST_DISPCLK_CNTL,
 			DENTIST_DPPCLK_WDIVIDER, dppclk_wdivider);
 	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_CHG_DONE, 1, 5, 100);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index ec3989d37086..2b33eeb213e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -151,7 +151,7 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 	/* CRTC disabled, so disable  clock. */
 	REG_WAIT(OTG_CLOCK_CONTROL,
 			OTG_BUSY, 0,
-			1, 100000);
+			1, 150000);
 
 	return true;
 }
-- 
2.25.1

