Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4320DC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF7010E38E;
	Tue, 27 Aug 2024 16:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gVDCYOr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D130210E38D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnFRzTlwcEm2r1KNNWDDlAVKLnrv093/i6WSIYfg45k+AUaSwPqXE92vhpC/lSYy7q0/sLOGnHEjSy2oqESItKGio0hdH76/7P3pxs5okcEUjogUHiemG2FGdXqlKEC/elOHETHb13d0lfe3kiA7U43YRoWcgx0ZJ40BEQ/gE3VRc6DNptE33phs+Kp1KwSzQUxAUlV5JZ7QyyvdpuGCIAl+Xewq6SpSgDZi2xA1GGk1CJ7L344nwxlyTYyuOGMCXYLWx771ZsMw/TXzEuc3LJ46nN7OhIKSDsOrb0wgaNmrtlY5dwRsEZ4DGSM1SSH1oJ2erI5lcl9mvcg86SyeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2N89G5N/GiBYINz9mNxRlfR6PN+kyGmrAURxGZm5j0=;
 b=xjEv1pXjK38CDxaYH9+1QNU1NMhfp/rN9kvm6l1xZg+kJKG8StuDNCV1bMnBKwvKD7WSkxCs+DwXGwH8GDdSyzKyzVCXNczn3cJ4wIYc4xTf/DK0AG3IGepvO79nt/uXDd9VAV8oyjQSPWCW1S/n4tfUlcCwCouz6NSj7h31vXoj64gn4ExJh/mWqDQv0ZBbDC/FNIyKLli09wMp7hCj6nXgbW6+AkGbfX8MjPBZ3Tf/ZdUS0/S6hyyoRFSxNBYVRRzGz4kx9/j7nyCKaDdSqHCs1WFWGuXpv+J9AltwjRovAEISgyOVYw6J/J9yaReOAHnwf36MB7j2h6mQlP76mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2N89G5N/GiBYINz9mNxRlfR6PN+kyGmrAURxGZm5j0=;
 b=3gVDCYOrgkQj/uXx5oDdzvJUnDrho9+wyP4PjaETpo/A2G9zOeCpcVvWVzRJbcFVuZUzf8YAcd9XSeLQGFtFnCNNS/pxFGH2ARoHqUyeonakVgnxvqGBR1SvWo7uAKWDn6ng94y7t2Izcg2sJG0yCyW9sO3bZ6PSlRIbfz/tv20=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:41:05 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::4b) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:04 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:02 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Susanto" <Nicholas.Susanto@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Fix DCN35 set min dispclk logic
Date: Tue, 27 Aug 2024 12:37:21 -0400
Message-ID: <20240827164045.167557-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f7e95d-19d1-41f1-3426-08dcc6b70b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?728pjqSs29hpMOT/5w0HwSWuAeYJgKSWiqqh6ZvHSysnshmM4ZVzRUUBpJLg?=
 =?us-ascii?Q?XUT60oDP7pRWy2DPzIFOe8x735/T3PCnY16WFbbHn/hadotM0gjlF5QN4auL?=
 =?us-ascii?Q?rDN996fjtWt7ljXq4+qCLUizwQITYPkCuVIkvt5JrA5pxQq+STAyupCo7q8k?=
 =?us-ascii?Q?Dl/ieK+wdWL2irr6N4SYBFiE1tTEyeCptpNxi7dMDhHG4FqvGmGt1owuarCY?=
 =?us-ascii?Q?zY1+9kfZkQHmp3yRQiTMTRJXyzWFXwqgpFP8Y8ZzS1GasI8bD/YVbpUzqZbg?=
 =?us-ascii?Q?X53PlbtSersstED4Eb3DeobvK2jcSWHDmYvAVVsTNw6th4JWy9he3MVltNO+?=
 =?us-ascii?Q?yVbWJbnETW/5/yxOKTqeDnIY3EREoPz0HnNAwWEI242AEfOImsr3RwVacxtT?=
 =?us-ascii?Q?uD0xZmrWIXhf71pD64b3jLyg241FeXSUmKVHnPlLH6nKRJODTyeciT4BmfvO?=
 =?us-ascii?Q?DVRWMvWQaYJXdDF1v9VgoxgcB1+ICxl3OJ2URn7mlyulNsTtlnaD2HbgnoNi?=
 =?us-ascii?Q?0VzfxawSuDwNW4Q6FEXSuloL8uBWXgppvwT1FT6yA7bCIsAmLOCiWhkxQ1Ie?=
 =?us-ascii?Q?u7DJEzkta0M1P9mLpiy3BIXxgoSmvQoGmyQDyrx20EDsHTFOc5F8QP2s1gmD?=
 =?us-ascii?Q?SJuZtq0q6bleur8/ASt6Awxazt/c5+VrZ30OeFJCvuJi/iGfiwQGMq6wlt0c?=
 =?us-ascii?Q?SlfW0yJnTqZc8/y2xrSPsRwhRRfoMVA1RaZmlv0hH/5wpKwtFPWbR4rdJo49?=
 =?us-ascii?Q?Bu2Ow5f35SwlOF1Xd2dv6ttaLjlDj5wRkRUk5QxmtSwkkN2pJybByKF8IFku?=
 =?us-ascii?Q?WFKutYASv1IzQ2BXckTsoXYevavrrQZMIuvjOS4DBV/3YmgGOz011fy1CHM5?=
 =?us-ascii?Q?7Xha9SxKZvhyarsFYrJK4xGzyuPUJZvFQb25wUf/lyky/6h9bjf7dwYJMDjD?=
 =?us-ascii?Q?uCsh0DhQ0PWwWGDs/SgG3kNXvPqnbrUKzuT70P4D24TsxZb90OC2Hw5wIwJr?=
 =?us-ascii?Q?iiFRGu/VTGfaWcFyHT1auOorebO6Pi8z3LMvU24PW4RHJh1wVJOMTEEHDMoW?=
 =?us-ascii?Q?G1UNzSoaxnHS2Fe7LS1sgeV8Xd5pYJwIUp3xwzNl/6EtVVWl0R461pZ6nate?=
 =?us-ascii?Q?bCkC8RQ0IhTZwbDch3QdWaoEFl1CTeG3PbDsRqG8HAldAIV3CkonR7e5hNTX?=
 =?us-ascii?Q?1MOOM4TJnt0ccwh+9R9lCzsUbNzwXJo+KnKG0ZK27nA+aH0TG8sWpASRopYW?=
 =?us-ascii?Q?JvOh2i/42xM0yEFTiWqPTr92hBgj+DRx1ohZhKAoPGSzc9l14R72o1i5cdFG?=
 =?us-ascii?Q?Zlz02+X32yzDboZQ9PWzfccj1vWxJI7x/yhK4ckvGT3fuCq2LRLjzFFp1tWG?=
 =?us-ascii?Q?hWDE5e/o9F+K6QA1avebGIfLGfb93H7j61hG0LY/AJFmf7REsA4wp5mtr061?=
 =?us-ascii?Q?7nuxclXLUuMzPqDHqh/FgohFNtMHbHEY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:04.5872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f7e95d-19d1-41f1-3426-08dcc6b70b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

From: Nicholas Susanto <Nicholas.Susanto@amd.com>

[Why]

Setting min dispclk to 50Mhz outside clock lowering function causes
unnecessary calls to SMU to lower dispclk and causes dentist hangs when
there is no stream on the pipes.

[How]

Move the set minimum dispclk logic inside the lowering dispclk if
statement.

Fixes: 2dd29403b206 ("DCN35 set min dispclk to 50Mhz")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Susanto <Nicholas.Susanto@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index f50054089da7..97164b5585a8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -305,9 +305,6 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
 
-	if (dc->debug.min_disp_clk_khz > 0 && new_clocks->dispclk_khz < dc->debug.min_disp_clk_khz)
-		new_clocks->dispclk_khz = dc->debug.min_disp_clk_khz;
-
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -385,6 +382,9 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
+		if (dc->debug.min_disp_clk_khz > 0 && new_clocks->dispclk_khz < dc->debug.min_disp_clk_khz)
+			new_clocks->dispclk_khz = dc->debug.min_disp_clk_khz;
+
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
-- 
2.46.0

