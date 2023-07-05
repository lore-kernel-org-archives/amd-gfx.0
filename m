Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBDDC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B59110E3B0;
	Wed,  5 Jul 2023 18:08:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994FE10E3AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1YWrSukr6o6MkghkY4UxwrLID9KnHq2SLu7tVPHR/mSEaOoixJaPDiY1NfDGSgOJx9U5PhZEVoY73ZKmL1h31Nb53NNevQt1ZtkWiQ4TC8uICOgYCIIRFgBCC7o7P0dClTiIKQ4+R2F5mIe8FkEwPlxy3MWXm/08o5GIJifLseLfTUyuoAhlPszIAUYuUmsqFkEfJdwnhx1j8BB5Ehf5aJ+cH+yXl1Nj0P6gHTcPK0Z1EMHsrMVH+z0DMWOAADBIaBoCsTSxleWrGOKyAKOo+J94+xU7nD9oNYR+Vn1+dY4k5CBjNAvwkv2d2R2/QtzuFkI/2lSpNULtBBGPQCJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jey9rlTRfSruXczew3fhwOm+WEzsbgg59cael3rINOY=;
 b=I6h46kfaLOBc0SBfrC1iqOq1ZpdhYaFO5kCFufxQm43Qp1nWFd6CDOxH+LjpXdihf5yUrx0Eth4/SRQJ5VDTLE2M+Vw+RPIcxDKpOI145EyRrKnIKiPT1vOQWWq9lZojnzAsAtKgmSzsWX5rdjffjCsoPWlWqhTMjWFwc51MQM6nE4TMw+KhHx+69rBN/Hvqubp289sIBfe9Tr76ItKCcp3bxnLxQUGVv9ioKK/RHtRrcc5WT2AX+am6F5B1nBZ3Mrv080EENghPNRG42zOhT6V76c5R3mjtCzfuKDP6Kzqy0438dp76e73ux5t94kD7rIur0+Kw539kuX31tlux+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jey9rlTRfSruXczew3fhwOm+WEzsbgg59cael3rINOY=;
 b=BN/GHBD7Nda4JR8acEJzREXSLMWTDzZQIUtWecNfihmE8uTjjA0X8MFnOuNttLkpGMzZv/rLCbeF4Q/aATTYhdIVggrAhDSxHhuofIG8JxH0zN4vsG4crw6eygdZylzrkBvHqrTmUgYVYHRs5Dq3Oc5RFW+Z/lLvzNzgGODrZw8=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 18:07:56 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::39) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.11 via Frontend
 Transport; Wed, 5 Jul 2023 18:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Wed, 5 Jul 2023 18:07:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 13:07:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 11:07:53 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 5 Jul 2023 13:07:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Block optimize on consecutive FAMS
 enables
Date: Wed, 5 Jul 2023 14:07:52 -0400
Message-ID: <20230705180752.2813978-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2418ac-15b3-4139-3b26-08db7d82c267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaq20HjMQtUvd3JQvbrBjePvqjC3a3lwZ4WAA5269TAdCfYukDt+n3Bitz5A4JXyCcP5S837TJ7HQ04zWDu3xYWBINuUXBsPTxzho9MCqVztyy41UU1SD+4ruSeko95XGzDq1Pqz8J4y8Me4AoYSp8Pw0BkUjAtigwUuohpUIGJV+byHrtT5EmlIGQNIe/UpskIXdHXktkg/mTkdJ7I0yq0RP8Ugb/ykXoS6pR+1sA9fLHwod2e4qN1erdPP0mp7eQgvNktKmGFLdhWhw2EPEGqncis/MdQw/m/5W6IanbBV5WOdVbaO73R4ZzO+U/J3Tzy4gW/FpTXOWwk8PhkJXB/oIG77zHHDzDBHOYicYEhv+JJqU/lg0020vE/jtmWLncgB7KUcBZ1n4yUviULIqXV/odJ73N3HxX7MgMfYxNTTVk3fXADoyLOGQSeOXY0D9fF9+j+HAxZVdn/78F7NVK08mTonDTi/7Wo5y7Ex2+WZgeIjQAqB09D0mtcF9rCkSswGlvlgUzzvLYoy7FjxZx/OJ7Xc72GBQeybpLVrcbTfi7S0CaTt6KpbvLD5qTxKMnno3NE63h0v7/k0eMjYSbTlYfkHKjuSt+dQuqjXHUEpJ3l7VvSSGzXnP4idBMxxADsnvyF8V27hxJdB7FBaTBVl+6M6cdjyd0hgQmTXgAjbga/yF1LPvMOJs7O4cpEoSlUpmLon8qq/nH+mNRhO9gmqWoA5jLZpvkeuIZIcz8XLflpHTx7hh5f0cCAayHtkWm1RNjDXIytueuhWjGJDmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82310400005)(2906002)(5660300002)(44832011)(40460700003)(40480700001)(47076005)(336012)(426003)(36860700001)(83380400001)(186003)(26005)(1076003)(81166007)(478600001)(54906003)(356005)(82740400003)(7696005)(316002)(70586007)(4326008)(2616005)(6916009)(70206006)(8936002)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:07:56.3041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2418ac-15b3-4139-3b26-08db7d82c267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, aurabindo.pillai@amd.com,
 hamza.mahfooz@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
It is possible to commit state multiple times in rapid succession with
FAMS enabled; if each of these commits were to set optimized_required,
then the user may see latency.

[HOW]
fw_based_mclk_switching is currently not used in dc->clk_mgr; use it
to track whether the current state has FAMS enabled;
if it has, then do not disable FAMS in prepare_bandwidth, and do not set
optimized_required.

Fixes: de1da2f7fe25 ("drm/amd/display: Add monitor specific edid quirk")
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 +++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 20 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index dba7eab9a2c4..5cfa37804d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2127,6 +2127,9 @@ void dcn20_optimize_bandwidth(
 		dc_dmub_srv_p_state_delegate(dc,
 			true, context);
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		dc->clk_mgr->clks.fw_based_mclk_switching = true;
+	} else {
+		dc->clk_mgr->clks.fw_based_mclk_switching = false;
 	}
 
 	dc->clk_mgr->funcs->update_clocks(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 7d38977f09a6..fb66d84b2a1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -951,7 +951,11 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 			     struct dc_state *context)
 {
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	/* Any transition into an FPO config should disable MCLK switching first to avoid
+	 * driver and FW P-State synchronization issues.
+	 */
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -962,7 +966,19 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+	/*
+	 * enabled -> enabled: do not disable
+	 * enabled -> disabled: disable
+	 * disabled -> enabled: don't care
+	 * disabled -> disabled: don't care
+	 */
+	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
 
-	dc_dmub_srv_p_state_delegate(dc, false, context);
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		/* After disabling P-State, restore the original value to ensure we get the correct P-State
+		 * on the next optimize. */
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
+	}
 }
 
-- 
2.41.0

