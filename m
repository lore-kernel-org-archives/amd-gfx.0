Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B1C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23FF10E7BB;
	Tue, 15 Apr 2025 14:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eeCjcPMV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FBD10E7BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA974F+DS3ukSd+Pv2vdSyN5mIobaqa8dpwywxNL+ZEx7EQ1U3AoSn0zf/SJsiSuRa9uh7PorU1x4mZYas7mBEre7Q8AAkXAFvSBYJ0gNj2e5aFP5tp6tF5znc2B5rFarktLv00r6h9qEgLCDIQLQ6AqbMkQYmgDirsL2dXEOsE2T7q5HM93l+CzRX+XIyfjgA0T6chLyzhknWesMgRnEZEhgCW1PreY4yvQ/hrxFq/nFyPnfivFCps3Pb4Z9s9bsc66ppiUoLxYN1D5i+mz88V3adXQvQcWvqTwOYUtrAgrHAjBACIRi9yM5bts+KGrbjBmHHAgxu+6w6o3YrK3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB2oQyfAGKUsIIP04rLkiGHB/TH/F4DCZ/zr/z++fH0=;
 b=GOOHcyyAx6BIH/qGuul47xDcimTAUFgLbs/AM9fgEjnptTz471Ua0uSMLukcuIX0kKZEE/tpvBBIXGCZEn4ICSttndVSmdEaOWgvANaiyA2Ro4bZGBlRwUvQ5wxSx52qYoNEf83/fwf/Ue+PACNKpaqvWIPOu9pxu4/GTP6Tc7lj6ptZzZ4VzsG+xgCnK1mHT/kYFQnE7yUij5KBeqROdQDJit5BmCELkEKmsBAsBPCjzbj0YH2FAGFGUDunedZG2jDYFkcOVyoR6eGu9brZ9Gb1ULyOk5ldR5m5+ZtlbwL4342hkyA3lUkHSaNG5eB+wV7r16IW4cdIyLuKNMLmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB2oQyfAGKUsIIP04rLkiGHB/TH/F4DCZ/zr/z++fH0=;
 b=eeCjcPMVWomQGKoNjOIbxpjzKHxc0Scedwly/lUGhxeYI+pmbd2S8nKjj7IlccEoRpCvJdTzYJAS1hvm7PwIk2M1V+gwuXPyUo6uxb1cAB4ocFasDh+MAcWB/XDzg1yfymV2EsHT5h9Puvws41aVlVqmtKXpCnnVr/8Tr6J5mBs=
Received: from SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:59:32 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::e1) by SN6PR01CA0019.outlook.office365.com
 (2603:10b6:805:b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.31 via Frontend Transport; Tue,
 15 Apr 2025 14:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:32 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:29 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, yi-lchen
 <yi-lchen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Yi-Ling Chen <yi-ling.chen2@amd.com>
Subject: [PATCH 01/22] drm/amd/display: To apply the adjusted DP ref clock for
 DP devices
Date: Tue, 15 Apr 2025 10:58:47 -0400
Message-ID: <20250415145908.3790253-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: e56afc5e-1e6e-48c6-8fd4-08dd7c2e2132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kANkkf/f8YWaSkIOyFkx7rL+Azseo/nEBnv8m/R4CtYmR693S9XYFcd4Iq4m?=
 =?us-ascii?Q?vwatz7MdWU3rdQy6LNV375bE7TZVP7oes/mmdFPyH+RLKCws5r4lU69AY775?=
 =?us-ascii?Q?7WvuPLwQfrMg+HPR45DSGqmrqD0VtIyYIjMIa/tQsWMBNadNGRAhm4hbeydi?=
 =?us-ascii?Q?spKwwIfaL4Bp2Odo0D1ufwf6Ix4jwoiin7z0U+0N8j32TcYPJYeCz3WMPYJz?=
 =?us-ascii?Q?ZL/UapL1+RVJfokdFHqPaWh3deT+p4R49uxO+Hm2a1wPU1nAEGTW4nSEl5gM?=
 =?us-ascii?Q?8iKcApYaotiAdMpqIsKc9nxnSHXzNTwOmlFjOn1F8acGrh2g3tD3WwXjnUlc?=
 =?us-ascii?Q?UaFUW3nNRwdX2nof/iXx1B3cf0NtI+FZ2wnaVxzLgOgcOGoTSuYGgRGbBVhU?=
 =?us-ascii?Q?qCwMXqCKLJw6mTzxVFX0/7IV+DwbrReJu5GdfPJedq6dKGyYw1hyq1ZDKqt4?=
 =?us-ascii?Q?tAHFfiyZx4bIWSuj4xYc6YhpRVnGeRZuY8vnWpbzUTD2LDH8S6vbOeyB1IQM?=
 =?us-ascii?Q?0bUI/zUf5t/HSXd9/Y/GIKLchL965UO7xcjkfSRYXiHd+B0PXUv4Jaj+lGh+?=
 =?us-ascii?Q?xAbPCvfOrrPMtLcoCahPjmVNNjKS77WH64XCyuvUCxupZv02RUDVIx2k845G?=
 =?us-ascii?Q?eqFZNDptfI2IBSK2Ej2gLao9o6nk7ppxatz1rJU3DXN18pPGcI66QQ8W1eUz?=
 =?us-ascii?Q?ZQAj1QN53Y2Qd3e60VD7LDOpOnmotJvQigVz5iPgE0vkZfpyKYlK5OhK4/4U?=
 =?us-ascii?Q?+SUFXku5QFaS+OqeLLEVHD0dip5ftzmRdIhCN6F8B1XwNApuy7XnUtYfis6H?=
 =?us-ascii?Q?mJ07UuLS5DyMnsBJOvKVaHxeH6S7kholC2hZlze0JW5TRe2vWHIDceHmfeEC?=
 =?us-ascii?Q?aIjH8YDmf2U/7Di0QYduKJDbfg0KTWRmjSrLYkpaxLWE3iJwIOR6p+AnreL1?=
 =?us-ascii?Q?S+9meofZtvbQoAy9yBUE0Hjh6Hg1QIHOb3uOuqshKJo740ucghtDgCjzz/NH?=
 =?us-ascii?Q?QFq3LqDTsATCJQ1Llp+25rgPpYcjuEa0KTix7NCgpPBeOLG0iAJcIPeBUF49?=
 =?us-ascii?Q?x1J4p9+um+SNSl03ebOeD9JLunohfrwXieCbQiCTSm3+er8K92y5ATOKEQ6w?=
 =?us-ascii?Q?dznnClquWOMIkepxp2lFT50tyXn6n1dSMqEDGdgXGii/bYsUfFavHmizJuUF?=
 =?us-ascii?Q?YXmKsnCkSv94sC0hOkj15kWT61KSkGtnl1CqfOoM7feK85OpJUEgqY+5jxqe?=
 =?us-ascii?Q?l0hDS23vGZiMMODg0y2Ag7fPeHbiJySS65Mwhb1EGChTs4QipIUrL97Mx3le?=
 =?us-ascii?Q?49si8fZXilaw/7B5a0q4zh1w7Fzfb8+gCZJBi4EX7UkvuWbXr3jbywiKI0u7?=
 =?us-ascii?Q?e151uQGx8LDgJo25wl/f3SfKmxlRc3JI+CWN1d8HDfQnc5YeP/+N5EcBDnus?=
 =?us-ascii?Q?dOEyTkN5hrK/mrGqLgCoD3kl/JQRBPGWH2MvbGSM+nkES7Xb+rg5bkp5TA2T?=
 =?us-ascii?Q?K7gvVffZ4qvoQW8uRAg2Vgob5Nrbj32bcwxy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:32.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56afc5e-1e6e-48c6-8fd4-08dd7c2e2132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
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

From: yi-lchen <yi-lchen@amd.com>

[Why]
For some pixel clock margin sensitive external monitor,
we could not keep original DP ref clock for the ASICs
supported SSC DP ref clock.

[How]
From slicon design team's comment,
we have to apply the adjusted DP ref clock for
DP devices.
DP 128b (DP2) signals uses the DTBCLK not DP ref.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yi-Ling Chen <yi-ling.chen2@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 077337698e0a..b4f5b4a6331a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -976,11 +976,12 @@ static bool dcn31_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 
-	// Apply ssed(spread spectrum) dpref clock for edp only.
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0
-		&& pix_clk_params->signal_type == SIGNAL_TYPE_EDP
-		&& encoding == DP_8b_10b_ENCODING)
+	// Apply ssed(spread spectrum) dpref clock for edp and dp
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0 &&
+		dc_is_dp_signal(pix_clk_params->signal_type) &&
+		encoding == DP_8b_10b_ENCODING)
 		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
+
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
 		if (e) {
-- 
2.34.1

