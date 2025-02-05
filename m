Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65E8C0219E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D1810E39F;
	Wed,  5 Feb 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2C8cNAjF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0DA10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8Ui9ueddX/HsCLkaxUwSXWQE1Vm/tN5o402vQUgnCaoJ777hmk9hOceaMbqfwkSqqtqBGbF3hJwmoegTHnn1/2ahytkS8hOxafPy74v1Ec01sPguN8+Zv1XZb62881vNmKCc9+nsVwyWY6n7SMrNuKgcgWMfREhOS5qrveAAaDtL7ssvEdOCTc+czXhoNhq9Az40P1hSttMafDuh1DsjGl5aTTUEnNpzae2h3LaY9XITjEHtSHngbnpE0NJ/p8cDcb1PPVOjePoGZq0m+bDkiP67Gf2IMuQ1V6NWsAY0EWXE7E7sySi/hbwUxoLkbouYuvX/0x4q14wuEAJhGJn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZM2G1rYa6Ak4CB0891oE0kb7aISJbOpM0kjuc4RM/E=;
 b=K9s75skQm3xgiP9MMQVS1wnvqOWX/KFX5hhEcm1yAu1mwPR8g25o8ZPxoP8TZMGss+/pgSqGsibc0g0C4twJ46/GJKqDXmg5eAePffAsfj/n+tqMRaMpijWp8TisVXA7aPR+MKGVCBJQZuKay2UY5S86v50MFMsMKxoqHRsPCuT3wA6y0qfnRU6wG3d07c1lhXIlUcC43Ymb+kDZX9h6V7c2hFrxvtCiPCHHXTQMYdaGdgqqbmG7XtgB25zHKsjy+dkYNarkUp5jTCJaGh6KNFZEGELZVCFtRdAgVEdzyaWiMnTWQBbeBDydu4R1NJ52oHZdbJTmVI+4VR/fK4FIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZM2G1rYa6Ak4CB0891oE0kb7aISJbOpM0kjuc4RM/E=;
 b=2C8cNAjF+wKMJwx+D/DeYk4Op9W3vpFZ+VSDhR7ddmJJYVMNUkURKsmvuYn4ZxgbHX2WuyxEy+7wbeh9wzmN1YcImyZCHLatCP6AnXiPYj2E1p509M1keZ/dy1XtT4uFoebZ5rcuMUAGzod8OUHsnaXLyRcoYsiY3GLS/oUFHpg=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.28; Wed, 5 Feb
 2025 18:41:17 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::1b) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 18:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:41:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:41:13 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:41:12 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 13/14] drm/amd/display: sspl: cleanup filter code
Date: Wed, 5 Feb 2025 13:39:28 -0500
Message-ID: <20250205184036.2371098-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c2193c-7cd1-4c4e-ab1b-08dd4614acb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mVtczXRi/hLbcYHSCYhuKWyLardJc3O7LBXBdACmdmlXN6FIAPfCpmNdtTla?=
 =?us-ascii?Q?+SfWBpwXWxCOkti0NKA+pFNFTawBA93/Gj1/pWkExYH10mdhq+GoP9OqFUht?=
 =?us-ascii?Q?RUkueqr4OPyNUIV6vxMfVMlBwj0PO3sAGJOwg0ZYvBtHkHRBkY0ST8hCCBgA?=
 =?us-ascii?Q?jzWJZC5Cb7edohK4Sjn29uOmTpqbuqZ7iGUjTq92BUwFkKqTXXyEa3EHjliQ?=
 =?us-ascii?Q?ZePGZE63spTKYBsmJTJNtUqqIgB8Ok9syeoYroX2ZK4C6WYoA+pIpO2f/UsM?=
 =?us-ascii?Q?FQfQZr35YOGcZdkNVAzT+/T1ptN2zU2toF4qnFoWGOAbrFV5iuYtkWuP56Gv?=
 =?us-ascii?Q?RsdqnkCPVmS5NLqSzqe8yJ/JRWmyfMlOVqK2KTGu90cvSFGpDFGXY1Pf/eUq?=
 =?us-ascii?Q?zuqbbSgDRwtSfkJtWKVqprEHw1x2ScI0v39vOKiHhPjFKX4wvLlVBhpotD1c?=
 =?us-ascii?Q?jEMeMuZTTTALA4LZs7rPbQQxlP8kcYTVWbU12pJhS7OrWmv83XfoSDcz3HvE?=
 =?us-ascii?Q?v/npw4jkpqrK7TP87Sjl2hiHJ1YZnmRsIYp78LdkXPS7Vrwj7eczOQqjnEOg?=
 =?us-ascii?Q?ibThDSpW/c/sMwjQP1dezSbXANzZbSOjtNbCbcOqsMFgjBywzLs5bNFqHAxc?=
 =?us-ascii?Q?7wgyAbc/E49gMNC1Kpc87uWOfyfFf+G+n+cP2iXiJOtSunsngWp8gcCwrqMt?=
 =?us-ascii?Q?UvmZYtKQKn3CKPmo7/BmaQFNYWIOTbQB3cRr2zy/jrSlNFWJWDjkKjsAqHJl?=
 =?us-ascii?Q?N+oFJF0hxKOHTm7etMV7qPPvA3dedTY9DxKuztmAWHoFDFjN14XvHso0mXYG?=
 =?us-ascii?Q?ylN8dPjCq6IrbyKXzcDtpBC+b8GBEf0jZLzXy1QQXcSZEv2MvOmdPAcjR7Uh?=
 =?us-ascii?Q?n9l7iTdsHEtRe5uyBQhHZYNuu61PojrfI+ieIlWE3Teoi1L5RTAJrETklYr2?=
 =?us-ascii?Q?W+SFWcUFlPOoywbtooh5FBI4DzfbG1sd5f/AdqNm7Cl6o8p3x6MZh4F3RHQQ?=
 =?us-ascii?Q?0h1G9L2cKtlPXbQvFdrQ3WE2/pesypvaS8jbhifKjzI2wcMKi9IajvcTWRiH?=
 =?us-ascii?Q?CoPJPY2GmgWbwn/IR2W4LAdkdRwdOdg7hpYIUxy9iA//auKpxk9vU7QB3kMF?=
 =?us-ascii?Q?GnKcYHBSGmCAMrd6etbEP5N2SBYMYoSpAwiHF9qmJR6ppNWuGBzPjYOe/yKf?=
 =?us-ascii?Q?2qRQp8bagLrd7qi451LdOatTtXdf+o3ptFlAUhaRzKRC6W+ciO3Jq7ll8VtO?=
 =?us-ascii?Q?DLpaNGmybgsWtATJ5oDX8ZIq83MfJczVH/BFxgU6NJyJE9apbRkU8RfiOb2A?=
 =?us-ascii?Q?gC4dNrjzzoeuNS1EatOHbpXy73UQAdYMhxrWpRXamt+jC6aBtaB2rR86tSYh?=
 =?us-ascii?Q?1MFqosz67mJJO5dA++hQfnWm0AA842bMnv5pRRSP7GNE6OxuktjLiSqnp5zm?=
 =?us-ascii?Q?tU74dZxffdnBdRC8IxX5LS8v+cszCTrpw9rX77OZ764OZmjFYTA4AcfDUxMZ?=
 =?us-ascii?Q?6OUVS2RSTXMgZ2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:41:16.5793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c2193c-7cd1-4c4e-ab1b-08dd4614acb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Remove unused filters and functions
Add static to limit scope

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 .../display/dc/sspl/dc_spl_isharp_filters.c   | 321 +-----------------
 .../display/dc/sspl/dc_spl_isharp_filters.h   |  18 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |  39 ++-
 .../display/dc/sspl/dc_spl_scl_easf_filters.h |   9 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  | 232 +------------
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |  11 +-
 6 files changed, 40 insertions(+), 590 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
index 060451bf90d1..12acdd34e6a6 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
@@ -6,232 +6,6 @@
 #include "dc_spl_filters.h"
 #include "dc_spl_isharp_filters.h"
 
-//========================================
-// Delta Gain 1DLUT
-// LUT content is packed as 4-bytes into one DWORD/entry
-// A_start = 0.000000
-// A_end   = 10.000000
-// A_gain  = 2.000000
-// B_start = 11.000000
-// B_end   = 86.000000
-// C_start = 40.000000
-// C_end   = 64.000000
-//========================================
-static const uint32_t filter_isharp_1D_lut_0[ISHARP_LUT_TABLE_SIZE] = {
-0x02010000,
-0x0A070503,
-0x1614100D,
-0x1C1B1918,
-0x22211F1E,
-0x27262423,
-0x2A2A2928,
-0x2D2D2C2B,
-0x302F2F2E,
-0x31313030,
-0x31313131,
-0x31313131,
-0x30303031,
-0x292D2F2F,
-0x191D2125,
-0x050A0F14,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-0x00000000,
-};
-//========================================
-// Delta Gain 1DLUT
-// LUT content is packed as 4-bytes into one DWORD/entry
-// A_start = 0.000000
-// A_end   = 10.000000
-// A_gain  = 0.500000
-// B_start = 11.000000
-// B_end   = 127.000000
-// C_start = 96.000000
-// C_end   = 127.000000
-//========================================
-
-static const uint32_t filter_isharp_1D_lut_0p5x[ISHARP_LUT_TABLE_SIZE] = {
-0x00000000,
-0x02020101,
-0x06050403,
-0x07070606,
-0x09080808,
-0x0A0A0A09,
-0x0C0B0B0B,
-0x0D0D0C0C,
-0x0E0E0D0D,
-0x0F0F0E0E,
-0x100F0F0F,
-0x10101010,
-0x11111010,
-0x11111111,
-0x11111111,
-0x11111111,
-0x11111111,
-0x11111111,
-0x11111111,
-0x10101111,
-0x10101010,
-0x0F0F0F10,
-0x0E0E0F0F,
-0x0D0D0E0E,
-0x0C0C0D0D,
-0x0B0B0B0C,
-0x090A0A0A,
-0x08080809,
-0x06060707,
-0x04050506,
-0x02030304,
-0x00010102,
-};
-//========================================
-// Delta Gain 1DLUT
-// LUT content is packed as 4-bytes into one DWORD/entry
-// A_start = 0.000000
-// A_end   = 10.000000
-// A_gain  = 1.000000
-// B_start = 11.000000
-// B_end   = 127.000000
-// C_start = 96.000000
-// C_end   = 127.000000
-//========================================
-static const uint32_t filter_isharp_1D_lut_1p0x[ISHARP_LUT_TABLE_SIZE] = {
-0x01000000,
-0x05040302,
-0x0B0A0806,
-0x0E0E0D0C,
-0x1211100F,
-0x15141312,
-0x17171615,
-0x1A191918,
-0x1C1B1B1A,
-0x1E1D1D1C,
-0x1F1F1E1E,
-0x2020201F,
-0x21212121,
-0x22222222,
-0x23232222,
-0x23232323,
-0x23232323,
-0x22222323,
-0x22222222,
-0x21212121,
-0x1F202020,
-0x1E1E1F1F,
-0x1C1D1D1E,
-0x1A1B1B1C,
-0x1819191A,
-0x15161717,
-0x12131415,
-0x0F101112,
-0x0C0D0E0E,
-0x08090A0B,
-0x04050607,
-0x00010203,
-};
-//========================================
-// Delta Gain 1DLUT
-// LUT content is packed as 4-bytes into one DWORD/entry
-// A_start = 0.000000
-// A_end   = 10.000000
-// A_gain  = 1.500000
-// B_start = 11.000000
-// B_end   = 127.000000
-// C_start = 96.000000
-// C_end   = 127.000000
-//========================================
-static const uint32_t filter_isharp_1D_lut_1p5x[ISHARP_LUT_TABLE_SIZE] = {
-0x01010000,
-0x07050402,
-0x110F0C0A,
-0x16141312,
-0x1B191817,
-0x1F1E1D1C,
-0x23222120,
-0x26262524,
-0x2A292827,
-0x2C2C2B2A,
-0x2F2E2E2D,
-0x3130302F,
-0x32323131,
-0x33333332,
-0x34343433,
-0x34343434,
-0x34343434,
-0x33343434,
-0x32333333,
-0x31313232,
-0x2F303031,
-0x2D2E2E2F,
-0x2A2B2C2C,
-0x2728292A,
-0x24252626,
-0x20212223,
-0x1C1D1E1F,
-0x1718191B,
-0x12131416,
-0x0C0E0F10,
-0x0608090B,
-0x00020305
-};
-//========================================
-// Delta Gain 1DLUT
-// LUT content is packed as 4-bytes into one DWORD/entry
-// A_start = 0.000000
-// A_end   = 10.000000
-// A_gain  = 2.000000
-// B_start = 11.000000
-// B_end   = 127.000000
-// C_start = 40.000000
-// C_end   = 127.000000
-//========================================
-static const uint32_t filter_isharp_1D_lut_2p0x[ISHARP_LUT_TABLE_SIZE] = {
-0x02010000,
-0x0A070503,
-0x1614100D,
-0x1D1B1A18,
-0x2322201F,
-0x29282625,
-0x2F2D2C2B,
-0x33323130,
-0x38373534,
-0x3B3A3938,
-0x3E3E3D3C,
-0x4140403F,
-0x43424241,
-0x44444443,
-0x45454545,
-0x46454545,
-0x45454546,
-0x45454545,
-0x43444444,
-0x41424243,
-0x3F404041,
-0x3C3D3E3E,
-0x38393A3B,
-0x34353738,
-0x30313233,
-0x2B2C2D2F,
-0x25262829,
-0x1F202223,
-0x181A1B1D,
-0x10121416,
-0x080B0D0E,
-0x00020406,
-};
 //========================================
 // Delta Gain 1DLUT
 // LUT content is packed as 4-bytes into one DWORD/entry
@@ -278,52 +52,6 @@ static const uint32_t filter_isharp_1D_lut_3p0x[ISHARP_LUT_TABLE_SIZE] = {
 0x0003060A,
 };
 
-//========================================
-// Wide scaler coefficients
-//========================================================
-// <using>			gen_scaler_coeffs.m
-// <date>			15-Dec-2021
-// <coeffDescrip>	6t_64p_LanczosEd_p_1_p_10qb_
-// <num_taps>		6
-// <num_phases>		64
-// <CoefType>		LanczosEd
-// <CoefQuant>		S1.10
-//========================================================
-static const uint16_t filter_isharp_wide_6tap_64p[198] = {
-0x0000, 0x0000, 0x0400, 0x0000, 0x0000, 0x0000,
-0x0003, 0x0FF3, 0x0400, 0x000D, 0x0FFD, 0x0000,
-0x0006, 0x0FE7, 0x03FE, 0x001C, 0x0FF9, 0x0000,
-0x0009, 0x0FDB, 0x03FC, 0x002B, 0x0FF5, 0x0000,
-0x000C, 0x0FD0, 0x03F9, 0x003A, 0x0FF1, 0x0000,
-0x000E, 0x0FC5, 0x03F5, 0x004A, 0x0FED, 0x0001,
-0x0011, 0x0FBB, 0x03F0, 0x005A, 0x0FE9, 0x0001,
-0x0013, 0x0FB2, 0x03EB, 0x006A, 0x0FE5, 0x0001,
-0x0015, 0x0FA9, 0x03E4, 0x007B, 0x0FE1, 0x0002,
-0x0017, 0x0FA1, 0x03DD, 0x008D, 0x0FDC, 0x0002,
-0x0018, 0x0F99, 0x03D4, 0x00A0, 0x0FD8, 0x0003,
-0x001A, 0x0F92, 0x03CB, 0x00B2, 0x0FD3, 0x0004,
-0x001B, 0x0F8C, 0x03C1, 0x00C6, 0x0FCE, 0x0004,
-0x001C, 0x0F86, 0x03B7, 0x00D9, 0x0FC9, 0x0005,
-0x001D, 0x0F80, 0x03AB, 0x00EE, 0x0FC4, 0x0006,
-0x001E, 0x0F7C, 0x039F, 0x0101, 0x0FBF, 0x0007,
-0x001F, 0x0F78, 0x0392, 0x0115, 0x0FBA, 0x0008,
-0x001F, 0x0F74, 0x0385, 0x012B, 0x0FB5, 0x0008,
-0x0020, 0x0F71, 0x0376, 0x0140, 0x0FB0, 0x0009,
-0x0020, 0x0F6E, 0x0367, 0x0155, 0x0FAB, 0x000B,
-0x0020, 0x0F6C, 0x0357, 0x016B, 0x0FA6, 0x000C,
-0x0020, 0x0F6A, 0x0347, 0x0180, 0x0FA2, 0x000D,
-0x0020, 0x0F69, 0x0336, 0x0196, 0x0F9D, 0x000E,
-0x0020, 0x0F69, 0x0325, 0x01AB, 0x0F98, 0x000F,
-0x001F, 0x0F68, 0x0313, 0x01C3, 0x0F93, 0x0010,
-0x001F, 0x0F69, 0x0300, 0x01D8, 0x0F8F, 0x0011,
-0x001E, 0x0F69, 0x02ED, 0x01EF, 0x0F8B, 0x0012,
-0x001D, 0x0F6A, 0x02D9, 0x0205, 0x0F87, 0x0014,
-0x001D, 0x0F6C, 0x02C5, 0x021A, 0x0F83, 0x0015,
-0x001C, 0x0F6E, 0x02B1, 0x0230, 0x0F7F, 0x0016,
-0x001B, 0x0F70, 0x029C, 0x0247, 0x0F7B, 0x0017,
-0x001A, 0x0F72, 0x0287, 0x025D, 0x0F78, 0x0018,
-0x0019, 0x0F75, 0x0272, 0x0272, 0x0F75, 0x0019
-};
 // Blur and scale coefficients
 //========================================================
 // <using>			gen_BlurScale_coeffs.m
@@ -613,47 +341,6 @@ struct scale_ratio_to_sharpness_level_adj sharpness_level_adj[NUM_SHARPNESS_ADJ_
 	{1, 1, 5},
 };
 
-const uint32_t *spl_get_filter_isharp_1D_lut_0(void)
-{
-	return filter_isharp_1D_lut_0;
-}
-const uint32_t *spl_get_filter_isharp_1D_lut_0p5x(void)
-{
-	return filter_isharp_1D_lut_0p5x;
-}
-const uint32_t *spl_get_filter_isharp_1D_lut_1p0x(void)
-{
-	return filter_isharp_1D_lut_1p0x;
-}
-const uint32_t *spl_get_filter_isharp_1D_lut_1p5x(void)
-{
-	return filter_isharp_1D_lut_1p5x;
-}
-const uint32_t *spl_get_filter_isharp_1D_lut_2p0x(void)
-{
-	return filter_isharp_1D_lut_2p0x;
-}
-const uint32_t *spl_get_filter_isharp_1D_lut_3p0x(void)
-{
-	return filter_isharp_1D_lut_3p0x;
-}
-const uint16_t *spl_get_filter_isharp_wide_6tap_64p(void)
-{
-	return filter_isharp_wide_6tap_64p;
-}
-const uint16_t *spl_get_filter_isharp_bs_4tap_in_6_64p(void)
-{
-	return filter_isharp_bs_4tap_in_6_64p_s1_12;
-}
-const uint16_t *spl_get_filter_isharp_bs_4tap_64p(void)
-{
-	return filter_isharp_bs_4tap_64p_s1_12;
-}
-const uint16_t *spl_get_filter_isharp_bs_3tap_64p(void)
-{
-	return filter_isharp_bs_3tap_64p_s1_12;
-}
-
 static unsigned int spl_calculate_sharpness_level_adj(struct spl_fixed31_32 ratio)
 {
 	int j;
@@ -693,7 +380,7 @@ static unsigned int spl_calculate_sharpness_level_adj(struct spl_fixed31_32 rati
 }
 
 static unsigned int spl_calculate_sharpness_level(struct spl_fixed31_32 ratio,
-		int discrete_sharpness_level, enum system_setup setup,
+		unsigned int discrete_sharpness_level, enum system_setup setup,
 		struct spl_sharpness_range sharpness_range,
 		enum scale_to_sharpness_policy scale_to_sharpness_policy)
 {
@@ -827,11 +514,11 @@ uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup)
 const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps)
 {
 	if (taps == 3)
-		return spl_get_filter_isharp_bs_3tap_64p();
+		return filter_isharp_bs_3tap_64p_s1_12;
 	else if (taps == 4)
-		return spl_get_filter_isharp_bs_4tap_64p();
+		return filter_isharp_bs_4tap_64p_s1_12;
 	else if (taps == 6)
-		return spl_get_filter_isharp_bs_4tap_in_6_64p();
+		return filter_isharp_bs_4tap_in_6_64p_s1_12;
 	else {
 		/* should never happen, bug */
 		SPL_BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
index 7d0be2fc2d00..f5e3d3ecc913 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
@@ -7,19 +7,6 @@
 
 #include "dc_spl_types.h"
 
-const uint32_t *spl_get_filter_isharp_1D_lut_0(void);
-const uint32_t *spl_get_filter_isharp_1D_lut_0p5x(void);
-const uint32_t *spl_get_filter_isharp_1D_lut_1p0x(void);
-const uint32_t *spl_get_filter_isharp_1D_lut_1p5x(void);
-const uint32_t *spl_get_filter_isharp_1D_lut_2p0x(void);
-const uint32_t *spl_get_filter_isharp_1D_lut_3p0x(void);
-const uint16_t *spl_get_filter_isharp_bs_4tap_in_6_64p(void);
-const uint16_t *spl_get_filter_isharp_bs_4tap_64p(void);
-const uint16_t *spl_get_filter_isharp_bs_3tap_64p(void);
-const uint16_t *spl_get_filter_isharp_wide_6tap_64p(void);
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps);
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps);
-
 #define NUM_SHARPNESS_ADJ_LEVELS 6
 struct scale_ratio_to_sharpness_level_adj {
 	unsigned int ratio_numer;
@@ -47,4 +34,9 @@ void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
 void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
 	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy);
 uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup);
+
+// public API
+const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps);
+const uint16_t *spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps);
+
 #endif /* __DC_SPL_ISHARP_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
index 5f4e2e36c91f..0d1bd81ff04a 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
@@ -1136,7 +1136,6 @@ static const uint16_t easf_filter_6tap_64p_ratio_1_00[198] = {
 };
 
 /* Converted scaler coeff tables from S1.10 to S1.12 */
-
 static const uint16_t easf_filter_3tap_64p_ratio_0_30_s1_12[99] = {
 0x0800, 0x0800, 0x0000,
 0x07d8, 0x0818, 0x0010,
@@ -2001,7 +2000,7 @@ static const uint16_t easf_filter_6tap_64p_ratio_1_00_s1_12[198] = {
 0x0064, 0x3dd4, 0x09c8, 0x09c8, 0x3dd4, 0x0064,
 };
 
-struct scale_ratio_to_reg_value_lookup easf_v_bf3_mode_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_v_bf3_mode_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2013,7 +2012,7 @@ struct scale_ratio_to_reg_value_lookup easf_v_bf3_mode_lookup[] = {
 	{-1, -1, 0x0002},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_h_bf3_mode_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_h_bf3_mode_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2025,7 +2024,7 @@ struct scale_ratio_to_reg_value_lookup easf_h_bf3_mode_lookup[] = {
 	{-1, -1, 0x0002},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_6tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_6tap_lookup[] = {
 	{3, 10, 0x4100},
 	{4, 10, 0x4100},
 	{5, 10, 0x4100},
@@ -2037,7 +2036,7 @@ struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_6tap_lookup[] = {
 	{-1, -1, 0x4100},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_6tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_6tap_lookup[] = {
 	{3, 10, 0x4000},
 	{4, 10, 0x4000},
 	{5, 10, 0x4000},
@@ -2049,7 +2048,7 @@ struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_6tap_lookup[] = {
 	{-1, -1, 0x4000},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_gain_ring6_6tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_gain_ring6_6tap_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x251F},
 	{5, 10, 0x291F},
@@ -2061,7 +2060,7 @@ struct scale_ratio_to_reg_value_lookup easf_gain_ring6_6tap_lookup[] = {
 	{-1, -1, 0xA640},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_gain_ring4_6tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_gain_ring4_6tap_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x9600},
 	{5, 10, 0xA460},
@@ -2073,7 +2072,7 @@ struct scale_ratio_to_reg_value_lookup easf_gain_ring4_6tap_lookup[] = {
 	{-1, -1, 0xB058},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_4tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_4tap_lookup[] = {
 	{3, 10, 0x4100},
 	{4, 10, 0x4100},
 	{5, 10, 0x4100},
@@ -2085,7 +2084,7 @@ struct scale_ratio_to_reg_value_lookup easf_reducer_gain6_4tap_lookup[] = {
 	{-1, -1, 0x4100},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_4tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_4tap_lookup[] = {
 	{3, 10, 0x4000},
 	{4, 10, 0x4000},
 	{5, 10, 0x4000},
@@ -2097,7 +2096,7 @@ struct scale_ratio_to_reg_value_lookup easf_reducer_gain4_4tap_lookup[] = {
 	{-1, -1, 0x4000},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_gain_ring6_4tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_gain_ring6_4tap_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2109,7 +2108,7 @@ struct scale_ratio_to_reg_value_lookup easf_gain_ring6_4tap_lookup[] = {
 	{-1, -1, 0x0000},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_gain_ring4_4tap_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_gain_ring4_4tap_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2121,7 +2120,7 @@ struct scale_ratio_to_reg_value_lookup easf_gain_ring4_4tap_lookup[] = {
 	{-1, -1, 0xAC00},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_uptilt_offset_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_uptilt_offset_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2133,7 +2132,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_uptilt_offset_lookup[] =
 	{-1, -1, 0xA8D8},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt_maxval_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt_maxval_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2145,7 +2144,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt_maxval_lookup[] = {
 	{-1, -1, 0x3ADB},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_slope_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_slope_lookup[] = {
 	{3, 10, 0x3800},
 	{4, 10, 0x3800},
 	{5, 10, 0x3800},
@@ -2157,7 +2156,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_dntilt_slope_lookup[] = {
 	{-1, -1, 0x3B66},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt1_slope_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt1_slope_lookup[] = {
 	{3, 10, 0x3800},
 	{4, 10, 0x3800},
 	{5, 10, 0x3800},
@@ -2169,7 +2168,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt1_slope_lookup[] = {
 	{-1, -1, 0x2F20},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_slope_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_slope_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2181,7 +2180,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_slope_lookup[] = {
 	{-1, -1, 0x1F00},
 };
 
-struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_offset_lookup[] = {
+static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_offset_lookup[] = {
 	{3, 10, 0x0000},
 	{4, 10, 0x0000},
 	{5, 10, 0x0000},
@@ -2193,7 +2192,7 @@ struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_offset_lookup[] = {
 	{-1, -1, 0x9E00},
 };
 
-const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_3tap_64p_ratio_0_30_s1_12;
@@ -2213,7 +2212,7 @@ const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 		return easf_filter_3tap_64p_ratio_1_00_s1_12;
 }
 
-const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_4tap_64p_ratio_0_30_s1_12;
@@ -2233,7 +2232,7 @@ const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 		return easf_filter_4tap_64p_ratio_1_00_s1_12;
 }
 
-const uint16_t *spl_get_easf_filter_6tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_easf_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
 		return easf_filter_6tap_64p_ratio_0_30_s1_12;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
index edc2b5d25c13..321ae22a04d4 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
@@ -13,14 +13,9 @@ struct scale_ratio_to_reg_value_lookup {
 	const uint32_t reg_value;
 };
 
-const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_easf_filter_6tap_64p(struct spl_fixed31_32 ratio);
 void spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
 	const struct spl_scaler_data *data, bool enable_easf_v,
 	bool enable_easf_h);
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio);
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p_s1_10(int taps, struct spl_fixed31_32 ratio);
 
 uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio);
 uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio);
@@ -35,4 +30,8 @@ uint32_t spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio);
 uint32_t spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio);
 uint32_t spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio);
 
+/* public API */
+const uint16_t *spl_dscl_get_easf_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio);
+const uint16_t *spl_dscl_get_easf_filter_coeffs_64p_s1_10(int taps, struct spl_fixed31_32 ratio);
+
 #endif /* __DC_SPL_SCL_EASF_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
index b02c7b0b262b..5e52bdf1ad44 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
@@ -4,194 +4,6 @@
 
 #include "spl_debug.h"
 #include "dc_spl_scl_filters.h"
-//=========================================
-// <num_taps>    = 2
-// <num_phases>  = 16
-// <scale_ratio> = 0.833333 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = s1.10
-// <CoefOut>     = s1.12
-//=========================================
-static const uint16_t filter_2tap_16p[18] = {
-		0x1000, 0x0000,
-		0x0FF0, 0x0010,
-		0x0FB0, 0x0050,
-		0x0F34, 0x00CC,
-		0x0E68, 0x0198,
-		0x0D44, 0x02BC,
-		0x0BC4, 0x043C,
-		0x09FC, 0x0604,
-		0x0800, 0x0800
-};
-
-//=========================================
-// <num_taps>    = 3
-// <num_phases>  = 16
-// <scale_ratio> = 0.83333 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_3tap_16p_upscale[27] = {
-		0x0804, 0x07FC, 0x0000,
-		0x06AC, 0x0978, 0x3FDC,
-		0x055C, 0x0AF0, 0x3FB4,
-		0x0420, 0x0C50, 0x3F90,
-		0x0300, 0x0D88, 0x3F78,
-		0x0200, 0x0E90, 0x3F70,
-		0x0128, 0x0F5C, 0x3F7C,
-		0x007C, 0x0FD8, 0x3FAC,
-		0x0000, 0x1000, 0x0000
-};
-
-//=========================================
-// <num_taps>    = 3
-// <num_phases>  = 16
-// <scale_ratio> = 1.16666 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_3tap_16p_116[27] = {
-		0x0804, 0x07FC, 0x0000,
-		0x0700, 0x0914, 0x3FEC,
-		0x0604, 0x0A1C, 0x3FE0,
-		0x050C, 0x0B14, 0x3FE0,
-		0x041C, 0x0BF4, 0x3FF0,
-		0x0340, 0x0CB0, 0x0010,
-		0x0274, 0x0D3C, 0x0050,
-		0x01C0, 0x0D94, 0x00AC,
-		0x0128, 0x0DB4, 0x0124
-};
-
-//=========================================
-// <num_taps>    = 3
-// <num_phases>  = 16
-// <scale_ratio> = 1.49999 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_3tap_16p_149[27] = {
-		0x0804, 0x07FC, 0x0000,
-		0x0730, 0x08CC, 0x0004,
-		0x0660, 0x098C, 0x0014,
-		0x0590, 0x0A3C, 0x0034,
-		0x04C4, 0x0AD4, 0x0068,
-		0x0400, 0x0B54, 0x00AC,
-		0x0348, 0x0BB0, 0x0108,
-		0x029C, 0x0BEC, 0x0178,
-		0x0200, 0x0C00, 0x0200
-};
-
-//=========================================
-// <num_taps>    = 3
-// <num_phases>  = 16
-// <scale_ratio> = 1.83332 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_3tap_16p_183[27] = {
-		0x0804, 0x07FC, 0x0000,
-		0x0754, 0x0880, 0x002C,
-		0x06A8, 0x08F0, 0x0068,
-		0x05FC, 0x0954, 0x00B0,
-		0x0550, 0x09AC, 0x0104,
-		0x04A8, 0x09F0, 0x0168,
-		0x0408, 0x0A20, 0x01D8,
-		0x036C, 0x0A40, 0x0254,
-		0x02DC, 0x0A48, 0x02DC
-};
-
-//=========================================
-// <num_taps>    = 4
-// <num_phases>  = 16
-// <scale_ratio> = 0.83333 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_4tap_16p_upscale[36] = {
-		0x0000, 0x1000, 0x0000, 0x0000,
-		0x3F74, 0x0FDC, 0x00B4, 0x3FFC,
-		0x3F0C, 0x0F70, 0x0194, 0x3FF0,
-		0x3ECC, 0x0EC4, 0x0298, 0x3FD8,
-		0x3EAC, 0x0DE4, 0x03B8, 0x3FB8,
-		0x3EA4, 0x0CD8, 0x04F4, 0x3F90,
-		0x3EB8, 0x0BA0, 0x0644, 0x3F64,
-		0x3ED8, 0x0A54, 0x07A0, 0x3F34,
-		0x3F00, 0x08FC, 0x0900, 0x3F04
-};
-
-//=========================================
-// <num_taps>    = 4
-// <num_phases>  = 16
-// <scale_ratio> = 1.16666 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_4tap_16p_116[36] = {
-		0x01A8, 0x0CB4, 0x01A4, 0x0000,
-		0x0110, 0x0CB0, 0x0254, 0x3FEC,
-		0x0090, 0x0C80, 0x031C, 0x3FD4,
-		0x0024, 0x0C2C, 0x03F4, 0x3FBC,
-		0x3FD8, 0x0BAC, 0x04DC, 0x3FA0,
-		0x3F9C, 0x0B14, 0x05CC, 0x3F84,
-		0x3F70, 0x0A60, 0x06C4, 0x3F6C,
-		0x3F5C, 0x098C, 0x07BC, 0x3F5C,
-		0x3F54, 0x08AC, 0x08AC, 0x3F54
-};
-
-//=========================================
-// <num_taps>    = 4
-// <num_phases>  = 16
-// <scale_ratio> = 1.49999 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_4tap_16p_149[36] = {
-		0x02B8, 0x0A90, 0x02B8, 0x0000,
-		0x0230, 0x0A90, 0x0350, 0x3FF0,
-		0x01B8, 0x0A78, 0x03F0, 0x3FE0,
-		0x0148, 0x0A48, 0x049C, 0x3FD4,
-		0x00E8, 0x0A00, 0x054C, 0x3FCC,
-		0x0098, 0x09A0, 0x0600, 0x3FC8,
-		0x0054, 0x0928, 0x06B4, 0x3FD0,
-		0x001C, 0x08A4, 0x0760, 0x3FE0,
-		0x3FFC, 0x0804, 0x0804, 0x3FFC
-};
-
-//=========================================
-// <num_taps>    = 4
-// <num_phases>  = 16
-// <scale_ratio> = 1.83332 (input/output)
-// <sharpness>   = 0
-// <CoefType>    = ModifiedLanczos
-// <CoefQuant>   = 1.10
-// <CoefOut>     = 1.12
-//=========================================
-static const uint16_t filter_4tap_16p_183[36] = {
-		0x03B0, 0x08A0, 0x03B0, 0x0000,
-		0x0348, 0x0898, 0x041C, 0x0004,
-		0x02DC, 0x0884, 0x0490, 0x0010,
-		0x0278, 0x0864, 0x0500, 0x0024,
-		0x021C, 0x0838, 0x0570, 0x003C,
-		0x01C8, 0x07FC, 0x05E0, 0x005C,
-		0x0178, 0x07B8, 0x064C, 0x0084,
-		0x0130, 0x076C, 0x06B0, 0x00B4,
-		0x00F0, 0x0714, 0x0710, 0x00EC
-};
 
 //=========================================
 // <num_taps>    = 2
@@ -1318,19 +1130,7 @@ static const uint16_t filter_8tap_64p_183[264] = {
 		0x3FD4, 0x3F84, 0x0214, 0x0694, 0x0694, 0x0214, 0x3F84, 0x3FD4
 };
 
-const uint16_t *spl_get_filter_3tap_16p(struct spl_fixed31_32 ratio)
-{
-	if (ratio.value < spl_fixpt_one.value)
-		return filter_3tap_16p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
-		return filter_3tap_16p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
-		return filter_3tap_16p_149;
-	else
-		return filter_3tap_16p_183;
-}
-
-const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_3tap_64p_upscale;
@@ -1342,19 +1142,7 @@ const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio)
 		return filter_3tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_4tap_16p(struct spl_fixed31_32 ratio)
-{
-	if (ratio.value < spl_fixpt_one.value)
-		return filter_4tap_16p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
-		return filter_4tap_16p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
-		return filter_4tap_16p_149;
-	else
-		return filter_4tap_16p_183;
-}
-
-const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_4tap_64p_upscale;
@@ -1366,7 +1154,7 @@ const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio)
 		return filter_4tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_5tap_64p_upscale;
@@ -1378,7 +1166,7 @@ const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio)
 		return filter_5tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_6tap_64p_upscale;
@@ -1390,7 +1178,7 @@ const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio)
 		return filter_6tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_7tap_64p_upscale;
@@ -1402,7 +1190,7 @@ const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio)
 		return filter_7tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio)
+static const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_8tap_64p_upscale;
@@ -1414,12 +1202,7 @@ const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio)
 		return filter_8tap_64p_183;
 }
 
-const uint16_t *spl_get_filter_2tap_16p(void)
-{
-	return filter_2tap_16p;
-}
-
-const uint16_t *spl_get_filter_2tap_64p(void)
+static const uint16_t *spl_get_filter_2tap_64p(void)
 {
 	return filter_2tap_64p;
 }
@@ -1448,4 +1231,3 @@ const uint16_t *spl_dscl_get_filter_coeffs_64p(int taps, struct spl_fixed31_32 r
 		return NULL;
 	}
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
index 48202bc4f81e..c315a438d064 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
@@ -7,16 +7,7 @@
 
 #include "dc_spl_types.h"
 
-const uint16_t *spl_get_filter_3tap_16p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_4tap_16p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio);
-const uint16_t *spl_get_filter_2tap_16p(void);
-const uint16_t *spl_get_filter_2tap_64p(void);
+/* public API */
 const uint16_t *spl_dscl_get_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio);
 
 #endif /* __DC_SPL_SCL_FILTERS_H__ */
-- 
2.48.1

