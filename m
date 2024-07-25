Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50278C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F043C10E8B4;
	Thu, 25 Jul 2024 18:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="48ZMWNjq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D316B10E8B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG/yYUQYyh1h3MLQ2HpteBkNQlUzw9sBgoqbihWH4Cvf73qSBCxT9uZqV0W59ufSgsXFkKRE7tpVihXO91Bg50mHlzCwcwuT4depcqKyVxP07hxMNZ8X1NkMllLKUesKQHf6JGkqTl7EgZbw5iaMZEzmN6ujiMDJITVLugMOnvkFH2xjkaXbSNxEXmMpitD+P/wORvsNzuzB265GAVCGbWjY32S7cCTPyi7TB2Hc/7yHP1XL0b6ESideEkkcAgd64qCPpEeRmwOhowSO1nEB7bejIW2IyQ7Gs3EnP2hKPLvdoCuGbgewPJbwYnP5faZ80RPyK7f/o0fc39dS2/h30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iZlqZWvw/d90Ozyk7cuaa0u0QGuxUWaK5+7ES7GPjY=;
 b=M1TbP3aP9YZSZAxWcJCVly28TdWpOoN2lZpz0fPa+ULtCFC63lRehGLTY1mOx3+eM/ZUXFP9Jg931fQ+LXcg/gdPNtsfP3NSupwudQHIZo/q1ZVsJSHCEguy93E7Ar30OUKT3nCq4E54YcVZ3Kym4rFz2nnp1eSUSfBGxqdNH93Gu/rEVwsDFyZk3DuinIQpqYUJWmxOY6qmjDBH8fTbc/Rt+bcwsvPCZdhvarn8Wcj5X82ueV+CYok/myMm5+TipjOTkqEqhkZ1JVX8YjiDz/nKJkmz9Dp6Jybvw5LFCN+/aEqjYqFh28LZ/ISDsoi9GIsf63ETQ8OBwA2YVf7xfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iZlqZWvw/d90Ozyk7cuaa0u0QGuxUWaK5+7ES7GPjY=;
 b=48ZMWNjq8VBtlHYAK1vLCkbdYhjolYUMRGSJzhPbM+x97KYWvtJCThSOxSmb6Alc2Yt0dyNyXdE/LxRUO+b1sVJvW0NdqgzxL3In8qaX1gTymg+OciW5H5atEGyfIFeZ9T9havBwGfueXxt9/JW0zDx7y9WHxiIhGAk/SnhA+g4=
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 18:04:22 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::88) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 21/39] drm/amd/display: Initialize get_bytes_per_element's
 default to 1
Date: Thu, 25 Jul 2024 12:01:05 -0600
Message-ID: <20240725180309.105968-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 2834376b-755a-47bc-70a1-08dcacd43531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ELXWZW04F01r9REhdBDTbfxEDthGTCu0K0fbx2teudsxgscS6xTPkJz/5TAM?=
 =?us-ascii?Q?FkTe4WGBg/q1L2XUukUxJXqHhKBUXkN4vtbK5jILKtrDwnCq8Owha8kM4iUK?=
 =?us-ascii?Q?eWCddmUoTEUdOZlh/Xlx4slZv4axXgwOpHqTJ1yw93Sh3O+ElEn1N8nG3QND?=
 =?us-ascii?Q?a26YPjXOEsYdKuY1ADeAZu0auQ7zLrmdv8S4TjVZ7xbAeVAHkdJ5ViyQCWqg?=
 =?us-ascii?Q?qhY1YqDRtkjj16yY+jO5H6gJZRZCeluxnq1yKGdJ9lsijtdnCDr3uydB9lEb?=
 =?us-ascii?Q?QGx2nhRwJGkZvj42KxGn25b/dSyD4T76rGnDTBpgzoodFYpYKbqvcuQ+IqVO?=
 =?us-ascii?Q?gVe5AvsQb7mN7gqbLlAK6/DgdopjOde+IEA2dfnLHW1iJnqQhU41DpJdmtxm?=
 =?us-ascii?Q?tRV1G4CvEHRji1e+cd2R2gChDjycXZznBGPFC349oMPD875MtMm5XZs9RDGD?=
 =?us-ascii?Q?Yp8INxyANMZmll6MKrF/LAgnCq7Chow8Ly8yLFG5y6aCe69N2zA2OGlyb26C?=
 =?us-ascii?Q?gCJJ6JvawSEm0PvY0vdWeHVVv79IkCQMZyCjTH7ftJsnZW1S8s2cpWhheyBP?=
 =?us-ascii?Q?hZXmALrdMdBoh/csIZBq1gZtCHsvsoodn6cxGOAy3Ua4NICVrH394zvfPbDG?=
 =?us-ascii?Q?90j5E/+FlbVfbj7kz+tEYpAVhxK4+P6BA7Z0bgEZLDL56iGsTCbNVNM62Vn7?=
 =?us-ascii?Q?b05SnI+dwkWeRIsELpuo8Aa+2vu8aA+VPDctVqYbnEHw+CwCdpefJ8arzl6z?=
 =?us-ascii?Q?t5A/Pe+LeU1861UKQY2CWGvog8qvP/76Yr5gW44p8cDa/51WrKeHdlx+A6tO?=
 =?us-ascii?Q?ETiX5KYHuDLRtKlMWWzqBnteugZ1zJHQTJVUWJYfv3KZbm9NDJEnAVUUnL1d?=
 =?us-ascii?Q?elHcD6+InsdxJU6BpONJtydVOrA13uenW5iVsv6Z4Mx6G1Uqz8waAPRsxyDH?=
 =?us-ascii?Q?The63SNwCUMSl11BtWwUGyAQJEGzGrZsdeVO/5liPIh6sSRrAxJ7kls8271+?=
 =?us-ascii?Q?AO83YBs/eb0qhqPrdkS0XNU6sTl5c9nj3menp1JKRKnekjImweR/FudUtZIV?=
 =?us-ascii?Q?JrF448bHQrjGPIBaQ0tP+Rc27iugnRw9Q45rTkCnPV3zVA3JV0/TMykVcSOK?=
 =?us-ascii?Q?ugytkvMLiVKs2P+wsse4wXeIVNHB2cWVTE9T9RxYR5wLgM3BsoWSlWfi11dy?=
 =?us-ascii?Q?LlybJNEWDD5haJp22EhLp3VXJfNn1QxoIvTyCNf/S3a4P6gWVql1tzo/iAjy?=
 =?us-ascii?Q?G7jVdYOLgp28LXIDB6b7V1ETKDmFiNxpiS9vFd2OVMxy/afyfmIlUv0k/EdR?=
 =?us-ascii?Q?fke1/vh+nTzipqtJbBRaZQGM+nxpnM5C5neWoqK9gqsa3ywQzG4R17caRac7?=
 =?us-ascii?Q?K3I1WPpSFEuTHx6ammUXxGtXCpOu1qK0SBI4eo5nuNQ9W6q5mpIDsabq0SdX?=
 =?us-ascii?Q?xffD2wL4YU7ulcT+U4JVRGNzpYZ99eui?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:20.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2834376b-755a-47bc-70a1-08dcacd43531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

From: Alex Hung <alex.hung@amd.com>

Variables, used as denominators and maybe not assigned to other values,
should not be 0. bytes_per_element_y & bytes_per_element_c are
initialized by get_bytes_per_element() which should never return 0.

This fixes 10 DIVIDE_BY_ZERO issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 3d95bfa5aca2..ae5251041728 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 98502a4f0567..9e1c18b90805 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -53,7 +53,7 @@ static void calculate_ttu_cursor(
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
-- 
2.43.0

