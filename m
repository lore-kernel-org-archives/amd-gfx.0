Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC07C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8D10E6C9;
	Tue, 11 Jun 2024 16:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1uCbBof";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E0210E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6yLKtmskYmGC7nvZaAQoQLax4hkkeLs1Ms8K16uG4QmxhMS+/WY/kWeUl44DjxTxS/ev1yk8+IdT1OqkB7jyf82Fp3MkcKgjfKQTqiF4Z+uvJrdZPUYiREZIt5VVlPRR27s5XFkkdoEyJ/8qB/kV4nvubwOHmqiqHMu85f2JFbnQmgQRcCe0PoOBriD+ew2KER00jYo51/Bkxvac7hoAS1AlFW2bRr6/n1/3wx33C/jGXKT3lUR/XYW9nmsO6QnFpHAQX/XlJ7JV7ZmWUS7R/Tap32GN10izOaPUmIV7vcm1wPPaK2aOTWiMxgMjRttVDM7Ln1ljX60GYN1N7actQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be2J6UL1vFzvag+8W26Uwk82FtXKlR2ow205SPBii7c=;
 b=iWPZCZZxkPjf6QX6IXSWR9PI7h++rz+WkEjzLL/HP8NeBGU9kLY4zN/K3bDGqlWKIGzyBj2/RiaK7PeL6ZpecyqNsBMs3pSHUylQB5IG8qUmlqyfzI9zTLuEY8A4KTIQcDncPtp+waPvulVgQCCc7vRQdTi1/7G+Zuxl+ujWR9vfuVR2YAuvc69tQSbAuKDp1KEHN0AjlT+z+gipMwpuSYS058xG82NLcAsmMChyG6wocQDT9VNZ2oR+clC5jzFLmCMpb6LletNskq0I4vlmnjjhySd5GfjXzEggP+tBRZMWp1iWzoQ2pxNRJ3jLLEHlCVh5mnwe3aQwfJiRjC/BIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be2J6UL1vFzvag+8W26Uwk82FtXKlR2ow205SPBii7c=;
 b=s1uCbBofGrdopuCYnflbEm2x2rZLGUmmWUWfHZvrVbvRlmhWcLOzEM5CnxkcuZHMHODHYrGvjhj3iGrlmj9HN0+tlstxc0z/+2H+GMGjpx6uSqBqiSMIbo1nxZipmdcnHqwzeayIlqqxOW7tpXVtThHN6faxX7fzQel0qUZmtJA=
Received: from BN8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:ac::29)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:24 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::36) by BN8PR07CA0016.outlook.office365.com
 (2603:10b6:408:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:22 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Ivan Lipski <ivlipski@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/36] drm/amd/display: Remove redundant condition in VBA 314
 func
Date: Tue, 11 Jun 2024 12:51:09 -0400
Message-ID: <20240611165204.195093-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e261e1f-718e-4f53-812c-08dc8a36de6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSv4NuqAL9wkdiEvxxoGDG3Dx07PTE+Rvnj0HjLB5MYSnWuHaMWlApVQWp2B?=
 =?us-ascii?Q?kJ4CyUoULAy/HcxJ8J8QjsdIRpqbnrhll3P1Z/A1zEyinkHKrCpR2lsTUKkK?=
 =?us-ascii?Q?g4/65qjSNoSBbVtoJ16V2bY66hV9d5Vvl5cUyDCkM+mfhJ5jd9xFBB56W+QD?=
 =?us-ascii?Q?M1l7pT6iCepuuTWFv3NJU2g7MoWXKob9Qk6ck/9lj/rFS+X2J5m+tRA4WeY5?=
 =?us-ascii?Q?/dGhXs2G3t3go5ywJJGhhlDSNrobfpjAqRy8h1LAPVo7edfO1pX53gE+4Khg?=
 =?us-ascii?Q?Wl/hRmOAQaelb0dudxpiy7rDI4N5MDFHbzYf/Xu3sN+I0dQ5kkdQUOWYkt63?=
 =?us-ascii?Q?TqbNg4RGLI4u3/maORxkISY0KRYJW20hDKgWCZZalcMUfqOnPSsZGJ0hZa/g?=
 =?us-ascii?Q?oTytcJqUZgDmxWo6e9nAFkumyvPL0aBOybWi/GD4gyBZy3s48pXLihTd6chI?=
 =?us-ascii?Q?AmpFshWD/Vrim1O6+K/qVOJ9Z/T2yaXnxuJ112Vkr35RO4plPf4RIn6TJaJq?=
 =?us-ascii?Q?rReYxZrgOURJbtVOcFXjOngGsdndEbghST8Sn6r7J3dHXXLc8qS1ddHgK5YK?=
 =?us-ascii?Q?NUvFgDaONLgkYW/JjQMbgbjb4Y9aXHT9AZSH/GwrMM55YEri2vil67/3eP4p?=
 =?us-ascii?Q?1Q/9iJy9R4j9/t3Sn+ByYw5kVjA0H1d0y3eARwzXsKJFfdwrkerqe1RiH/r0?=
 =?us-ascii?Q?qjnxIjbGeP3A/qmPmC0RTObgkebsat5Ui7360gYQTmj6U8JpHPsf8eHgk0/j?=
 =?us-ascii?Q?ax3wTVOnMhPUCPclNFtJ+numvOgQ1hNY1feDLOCyBu/p1HmtvLWTFWCH7I6w?=
 =?us-ascii?Q?r/sXhaw5cF84j3Y72mIamicIaLcqbMNo0B/+zih9Ke9wARqA/7s9u2r+I95k?=
 =?us-ascii?Q?jlw1Lpmex9WbDuvVAX4fkg9NB30K5/tWz/QkQoa2rn8WC1Zl+938t/9IeTzY?=
 =?us-ascii?Q?Y5tgKX7sAxmPhTXtsiaBUBDIjiTm5VDmqXl9jzuH7DnfVqDs7GYQhsPlDXRy?=
 =?us-ascii?Q?1ngPgEN9q54TetDzISwnwT4oZOLkrU2Qq4DwRCtLlYQ8snZPuBL0pLInYXBv?=
 =?us-ascii?Q?YSWLxSX5eRfoDvojt8RDHsYNwppOrsXrInn2JxXaH8Qn2hZ8cCYj4nmnKk+0?=
 =?us-ascii?Q?NcHutFul0G3qUpfrg2usG8WJGQSITNKfE97FryAM/WBzwSNp2ns8x9cZVMGO?=
 =?us-ascii?Q?0xKrXK3rKqluTzYo4IjVwcDyqHHldUThYAEJHT/QyiQeUseea84wRm3eDCRl?=
 =?us-ascii?Q?k8YdorwyqTh18Tc4ojj1AHjLRuqNvJ7gSNDK3+Yi7ByMJXx2+GIsaS0E/4SD?=
 =?us-ascii?Q?k9iir9GSdWd0/eliXkfhK/K2eJxzwFo0zbr0PO9L768+/yCEa4haYRWCh5he?=
 =?us-ascii?Q?ymqFZrHzqQFSB0qOG3htoEtYubQSWK7G/NLjdWKmrCSi51UHdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:24.2453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e261e1f-718e-4f53-812c-08dc8a36de6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis this conditional code as DEADCODE.
The conditional statement is never true since
'MacroTileSizeBytes' is either 256 or 65536. Thus, the
code inside is the conditional statement is never reached.

[HOW]
Removed the conditional statement.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index f52b9e3d2bee..cb50c475746b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1941,15 +1941,6 @@ static unsigned int CalculateVMAndRowBytes(
 		*PixelPTEReqWidth = 32768.0 / BytePerPixel;
 		*PTERequestSize = 64;
 		FractionOfPTEReturnDrop = 0;
-	} else if (MacroTileSizeBytes == 4096) {
-		PixelPTEReqHeightPTEs = 1;
-		*PixelPTEReqHeight = MacroTileHeight;
-		*PixelPTEReqWidth = 8 * *MacroTileWidth;
-		*PTERequestSize = 64;
-		if (ScanDirection != dm_vert)
-			FractionOfPTEReturnDrop = 0;
-		else
-			FractionOfPTEReturnDrop = 7 / 8;
 	} else if (GPUVMMinPageSize == 4 && MacroTileSizeBytes > 4096) {
 		PixelPTEReqHeightPTEs = 16;
 		*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
-- 
2.45.1

