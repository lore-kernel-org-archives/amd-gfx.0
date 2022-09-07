Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6077C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD7F10E80D;
	Wed,  7 Sep 2022 18:12:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B5510E808
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJyKSG0KCkrgoPWbBx8JQc74ASZGjVb3AsOiJRyFwHn1WSc8y6QqoWPgClBADDYYs42kO5RumHSBE1T/D3X7DrhHDl8DKoDZrnPhjAP8bxclv4SYOdTNcUDR/kkJYir7JkOxdCXyxVGo9b7JLUzC0V3GwNrcXKoRQzMcP5J5YORiNj4ZkI554ioJUK/L1BjpCG4WvqLnTgq09IjMPwPj3QB1L1S15t16LIeMmhIXp+iPzFRTN7BUXCUqdd1goq6QpAF6Dzv4Os5xCZ8AXOPi9VmE/uSxf9gnduI42mdAq5YRNgTaZRKz7ukzb35tzR2gY3z24QYT+Yku/MCeJZEA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUg6hy7iDvkL9C6c6lpQOpzin/Tce9giQCOpeEAyfdo=;
 b=GLEDJdkn6KeAToXajv2/ulhSb1a9Is1jsJS1sFpAOeQcShCQIcUBOMrr7oWf/x+pLMnDP58L23ETsZ9G07EMjrJRkZlAzb3V+UqMcNAvu/MB/VapSPYhDAlKzPTQk6a0t1pAZTQNwp+JeI95e3kOKix/qTCxBf/R/8ovERgrUGwE2QIcriQmGFjdnR2A2JzPOfqfcJ0Pt3BPe8ugZsJ3Ir8qnaHXb2nIaWrMiWCkMicWG33SCD8nJxa9vWF0H/pF3+9b7MA0wVRDjxtG8jnTgkeUpxGvO7fxWc/eYJRm+euRErEiP4s65UeBtBTWmP/YbM7XixVXF4DgujAZQ+ilrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUg6hy7iDvkL9C6c6lpQOpzin/Tce9giQCOpeEAyfdo=;
 b=mQJZwql2ahq9t0/Usy2lsXHyG5F+evUel/0wUMeYGS6VkSyEwmrQt1xQNUeT1PnZH6bWk1jYnMCkk7C0uECcaXTZWpgoreh3SwcwzeDw2nOwFJS0//5J71z8fLlDLH+2H2iRvvmz5Ntx2JQelG2/cVjbB3+nsJNMai2OQGqqyo0=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 18:12:19 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::26) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.7 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:18 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:17 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amd/display: SW cursor fallback for SubVP
Date: Wed, 7 Sep 2022 14:11:42 -0400
Message-ID: <20220907181200.54726-3-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5a1bc6-d920-4483-0c0e-08da90fc809f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PU3Cn8DWHLcw2u/Q5cI3y08ux6ThLtN7trO3zd5ytNL9kGRcOViUbVAX4hSSl0JK0iHXw3vyxiOzaPPmj6YePf2IIsgZzK33X1a4t2qixZxgQHB3bL1lozVioSZZ5xa+tNtSLUOfz76pGA6CCfS9TFVystm4U7CBPxHr+HAxzE3QVB600fgpXsZj/hp6AaCETRpmysjH4R3KNM2phqCEcJzISGL8LSyCKTRI4MYbPGs5NSPpX4DDNyUd9qLcyZHt71fI5HE3ANAjHju1aS+p+ugFWeNAYBGiXIURSseH4XT2/YfnillprcuZuaPcmVHx5QWaGSXjJGo9safjAdyVIAPdqAuS8RW/3r+F0OxLyFYrxlwvNUkNeeFK0qSxcyynZP6LHf4CBXQsC1bDjCRA7ZloLaCMY600IpvbmoW6SwAfvaT5qrGzqNpOKTYNmUJ1gVmwXO7Gnwx7hKmApIQkgFcucK6+aQSt9ZOG9Y7ZqKcYlYBZsC7ETKjNGB/cKIWQMLE0CELnGhEAz0UFTWQjeJWeeICFDnEDM85LSuXkuRY1L3wNsGxkWjF10Gb9kVn78p7L2NAx3qHVqJY0OHNPVXlawjfhxyMq3pI139QiOAwhXLGJyHoIUo9nr6xWTutMoLHK7qahUY0PSf1zO8QlQM/Z+2C6B39mYyckxode3Vpjr812NMSozDzJqGTM2cAyBsR7Chq9C6W5G0Rv1+6Oq1sVYprVkeQ8KyPGvDWUObr7tOtrt9XL1MreanKzoSHItrPzPjX2BdaFt2lSfYheq5JfifFebYmgUnYv+wYCudgJVHk7lIncqQzaQjIJNjIf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(356005)(40460700003)(82740400003)(82310400005)(81166007)(4326008)(36860700001)(83380400001)(54906003)(8676002)(70586007)(316002)(6916009)(70206006)(2616005)(44832011)(426003)(336012)(40480700001)(8936002)(2906002)(47076005)(26005)(7696005)(5660300002)(1076003)(16526019)(41300700001)(186003)(478600001)(6666004)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:18.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a1bc6-d920-4483-0c0e-08da90fc809f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
Leverage SW cursor fall back for SubVP
when the cursor is too big. We want to
take advantage of being able to fallback
to SW cursor when possible because it's
not worth it to disable MCLK switching
because the cursor is slightly too big.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c         | 5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 4 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6752ca44e6e0..0c85ab5933b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -328,6 +328,11 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 	dc = stream->ctx->dc;
+
+	if (dc->debug.allow_sw_cursor_fallback && attributes->height * attributes->width * 4 > 16384)
+		if (stream->mall_stream_config.type == SUBVP_MAIN)
+			return false;
+
 	stream->cursor_attributes = *attributes;
 
 	dc_z10_restore(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75dbc665f435..c48403d49f2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -830,6 +830,7 @@ struct dc_debug_options {
 	bool disable_fixed_vs_aux_timeout_wa;
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
+	bool allow_sw_cursor_fallback;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 5a21cf041732..5953083b76a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -747,6 +747,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
+	.allow_sw_cursor_fallback = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 8a89c28add0d..64c225ee3a46 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -750,6 +750,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
+	.allow_sw_cursor_fallback = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.34.1

