Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E79DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE70D10FA4C;
	Thu, 30 Jun 2022 19:14:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E4711A21C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBoAr+Y1q9PSZcCRRJ53HAL5e+R9Q/+Fn4UgSk+2lqBHCF+yXGCnzJwkHugC3TjriF/Lxkoul0DmJgNi/zQmydgCscNaua99B8JM3G8J+y0wvXe+pJkGZdsjeiEpRDmmBdoySNkaJaeV19K2rExgRP+qwXmqL4fA5EQ3wD0Oe1NHWeOw1Y8+zKRaOeLGP0vZOtlDTEku+JEF0tFKJJ3btIz0vOaolQrd0OEk80fNutnL0YASixojXuoZcDCbX5svKx+UrnOpjFBIMP+529a8TxR+4gVjJmJWtgnwZ4tTzz433NuUMlpUV87Jt3xo/xfOkDQWjgq8cCgbOq7IlD/BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lspxXFQZO3PGsAgfXJ6tbATap3a/BfeYrwXQ6xe+fcM=;
 b=NqolMUJYOIMZP5wwtIYupb6hxy2YBUW9CATMBEuiQDwFtmLkcSk8h40xD4Pa5R5l6O8PvgZmlhizYE20ZEkjgR8DiFNR7NZKzA1aFs3EAiNpW5dTkOvE6q8J9Ta27xPCHlWFR1Jy/+oC6qjj42+XbqHxTkiPZy7ZaHv600oveAtTjtyMz4sqkp1VssCenvJowVuTJ9NPO+Aqy95PjI6rSmGmCVuaA2/3mUwsb9Dif1xWc0t79Rp8pz4KAnjVm7jzEOWe6EeoYuNIF4+N6efJV6xUyldidg4Rnt1V99OfTSX7Ui5CkhgQc/CdNSVWBfstvhxBqWVhmEstyKYj1KTyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lspxXFQZO3PGsAgfXJ6tbATap3a/BfeYrwXQ6xe+fcM=;
 b=z9mmTCMh+7D3jNAi1SjsxfSDJWsQJM6BnrmdvxIclB9CUrsXxgNWP+hMuT2fd5R9eRrKWqbvdYleJhMCmnuphE8eRxhFQ32DY6SMowMb11YHLzfCrohjmFA07RAi0uRNzWsUUuxm0dy6U6MGUtK2aprZ6WUsfDygbYpVA65Dry4=
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:00 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::e4) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:00 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/40] drm/amd/display: Make OPTC3 function accessible to
 other DCN
Date: Thu, 30 Jun 2022 15:12:52 -0400
Message-ID: <20220630191322.909650-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18430c94-317a-44be-ddd3-08da5accb042
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/hLcF36I31KeaFWWnypLpfSiZAu+EjuExWul7NPq/HeRyr9QPlJ13NtT2gOoLkOdV9PwlG3UEP9xmaScDf9Ftk8tCelWxveSUqMMFwyhWzKiStIzwMQA2/Zv30Ek+/rPdY5gopL6ciP/PaNiPsT7UzwGsuKA3XfvisPuelsYUoM6LPvIkqy5kEFealwCyUAwV7YZb2F6lpPFzhIKnRG68kLOdKmmeefvRQVupo7+qURoKbBnykGZ6cZ1x7VLEkPlLiV40MZi4eBuQTPT0pUPMk1xMY8DPVG6oLBkysUpKxbIjO9kZhRop4E8k1gZ/+bGUX0lmLNwgJcuLDshiL4LoyrhSIfqFCyspyqUxqXOR28KnSy/jHfhwB5FtQo3N4jH1QjeipXsxs3BTJ2UfBc2grmOOb5SWIUMAl3jDuzOtbsyoid+PWZWQTMOiRLDV3AfiesHTzN7K/HqQa7l2VoLWK4XW0qlO6cNCiuKvCYos3nfSXYxZvajDR75WYpakekxiReuL2JaWWOZlb5GhIRJ36PCgpMtRLDLiiMm0U4BoHWjrzD1syxFl8ZRoM7C2lJRIoV+o9ja4Pbs+Sxhl4C200lLg1ytEWOtEYIzwIZTXS29me40cNG1wVFgONGtfS6cm/x5qxMdkvlXNRrK+i+VCEtYXX/A+bL8W7eH7zxqMLXXQz+PE1u0nxnBJMZRDaIC7pXABq0QdGAwwWw+mUUY96XOt1KfqHUt62Jq4w5WOocV3715LGCRCvnYs2YtyF8zQCIAmky0/ZD3OtjtVup6pYnRKuRhdN5rVIjCx8cGtgLFJKb77+lbrdEl8JdAJZ4GbPKVuWPH3zreRdJEFDrguUYvkOH3eQ0RTeCSipl+8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(426003)(36860700001)(82310400005)(40480700001)(83380400001)(70206006)(86362001)(82740400003)(40460700003)(36756003)(81166007)(356005)(6666004)(41300700001)(478600001)(1076003)(2616005)(26005)(336012)(16526019)(7696005)(47076005)(186003)(5660300002)(8936002)(2906002)(54906003)(6916009)(8676002)(4326008)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:00.2721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18430c94-317a-44be-ddd3-08da5accb042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why]
Newer DCN should use optc3

[How]
Declare optc3 vmin/vmax function in header.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7fa46e35bac6..629cd76b97c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -440,6 +440,7 @@ struct dc_clocks {
 	bool prev_p_state_change_support;
 	bool fclk_prev_p_state_change_support;
 	int num_ways;
+	bool fw_based_mclk_switching;
 	int prev_num_ways;
 	enum dtm_pstate dtm_level;
 	int max_supported_dppclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 9a440ae8f865..80136b5d7e48 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -293,6 +293,11 @@ static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool e
 		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
 }
 
+void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
+{
+	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
+}
+
 void optc3_tg_init(struct timing_generator *optc)
 {
 	optc3_set_timing_double_buffer(optc, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 30361ebe7d22..c279a25ea293 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -58,7 +58,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
-	.prepare_bandwidth = dcn20_prepare_bandwidth,
+	.prepare_bandwidth = dcn30_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 88275ea4193c..00ff21458a53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -223,7 +223,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.set_vrr_m_const = optc3_set_vrr_m_const,
 		.set_drr = optc1_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
-		.set_vtotal_min_max = optc1_set_vtotal_min_max,
+		.set_vtotal_min_max = optc3_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
-- 
2.25.1

