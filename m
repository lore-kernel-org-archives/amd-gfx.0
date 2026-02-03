Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77166E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1029C10E6CB;
	Tue,  3 Feb 2026 15:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cx8QTe5d";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA22710E6C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7EDJnkj81SfXuTBQ2aZUjME6m46lfC9ASFq/upXZBjytDn5R5e+uQGXSZUGDeSwpv7pJe67ewSQw24yFD0EXjVSb8INTyhS9KQRVrJ46LdTossZeCKn9dwT+QZ90NrrenJ2hMg5q5Uuicx/X3NVJSaUAVICbD6JNaWnR4ENokHZCJuXaAcdDA9phCFT+K/Mjh9XSQ8AEwI540YOzEtBelqKUfXzHFeA7q0kCfkorOOhB/4zOWcjhKQOvpPTLla0LgRg+QZYRXzJdsi7MLIlKG4I/rpKjYly66TJcV72gNnJFxlxIHysQNdXvhd3hPUL8VkaiQLyft27zy3sHozjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WJlf5bUmOtJ2d4HEOT4yKvMHWrTMOIouv1UHXTly1E=;
 b=uO09bPTbFn781kw2lZXTRKvJC+8lfxSUt/HXLOVnvAWP2d8ZnDr8w54BeDs2h721C7C/OlxEJ5Qx36xlV1IaoPbwmadQEHWJZ8Hp/itDNx8vHqDqfaW7+eJupE/Hp9byFEs0k3KQWIAbxxdzi+TYO/msHbpX2+0Atdljml2Qa7dJHg+xYXM/5cXg+rOAu80zsZT1V1PSyuOKTF1zIbDdQI7OOa7GexCvwo/0IDSre5bNZpZR0fai0gvF8jPW/pCOxPe9YFVni1RacVXsk3hwkJjfWBlvwxd+1Yz3TvSLYdQx7gQUripJH/uLKYc+2qUpoP+EZXuqR/oif2z+1CwNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WJlf5bUmOtJ2d4HEOT4yKvMHWrTMOIouv1UHXTly1E=;
 b=cx8QTe5dd2OFVuAgOOqqH7mbKjx/1J5EV6vsPkrmVEpxlPcRIsFHT3r59JajD0tODTDj5veC4qI/OHTQY3pQK1sOKM2zLdsjdBVTEDVSM8x9+V4iHJQKSfRR07k1bzKHCl+fGyIPMLvgHGI2tM/ORz4e3LxcBgDlpTo27hdOtDI=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:13:14 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::60) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 15:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 09:13:08 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:04 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Refactor virtual directory reorganize
 encoder and hwss files.
Date: Tue, 3 Feb 2026 23:01:46 +0800
Message-ID: <20260203151229.3673042-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 874e9c03-d25e-42bc-365d-08de6336c02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LtVCxqrL6s1+3vYwOW2HTbNwzAxF7Gr4TU0m0Sq0Lm/vegF/R2IF7E5PCgP8?=
 =?us-ascii?Q?WW+pTkOmaN86WjZ49gEy/E4L93PPUHGf6ggGuEAnm8BLaMZPnnMfUuom8hj6?=
 =?us-ascii?Q?i33oai53spTg9TwUblhtMqsCpD0vVm5pFQ9fEVqOBQ3BrVkWvvXJtytMA/3k?=
 =?us-ascii?Q?ocuGoZ/Bmls14evXGgXQ/oX9NvO0jj58weDGst29xLf7WHeFLDITA3EXVUAc?=
 =?us-ascii?Q?wF0mG19egswMHADjtHco8iP30bc/Rvd1o1uu+l6Jrw6Aw4GtaK2TJWS7g92S?=
 =?us-ascii?Q?FFed8o+p+YsrCgMayyYkU9p5jy43eY4/j4A3nR9TDjlINa7fyc7dpnm2nZjN?=
 =?us-ascii?Q?sXXy6UXX/ZzYiEWhvSlyuy9M+nbqtKig2WSarnh40ZDq9UpFtwMlIFEvxsMz?=
 =?us-ascii?Q?DWrPCXA3th8hc6cyoX/7GZBrx/UL9t7HJowuSjdWmg3UNclFpyIYCXw/3ykp?=
 =?us-ascii?Q?eUx+BPrELnQAofParmK22SQ+OmstWo0ps6FtLA4VAuUz6sljh3y2L7fSX/0F?=
 =?us-ascii?Q?v1Vb2gO7r3JK8CZd+kGhtRJz1Hgp3vW1xp/qaZP54jIffcoEGiLQz4H/FlYl?=
 =?us-ascii?Q?76J4lIHTRshuRrqTF8ZMyzlWCMwmKgSLJTT/z6VLRi30eCVY+BKw3zgylSIh?=
 =?us-ascii?Q?wHRncpPqn+EOu37jQw9zZtx6CSceSgNAXDLAStrI/Wkhw4q3EIuAc7/NPNdH?=
 =?us-ascii?Q?Tv6I9H/SPUrzbUoy6P4bc3XI+gCwTC8a8jlWegz+Gy6mN6SKo2hL/rRbSXjd?=
 =?us-ascii?Q?tGgcYid1U7uESrYjV1j3KYMY3DbRMj07XQTha4DwMU/MiODH99CrYh1Bom4S?=
 =?us-ascii?Q?FRTKeaj/Pg77m9tF0vHzvssnCtoi0gGFZl9RDFNSCUL0/o0MiJoAZNniAuMJ?=
 =?us-ascii?Q?E5UV6UsZbmHbcA1LAxCxHsxwhyINDYqRUxCGG6i4/CnT59UlN4oyguhnlWRC?=
 =?us-ascii?Q?IpRTH5NX8vXMPdtFpI3UWQGVDYDMUHDT9o4B9zUCe4QDyVx0Yd194OWqS4p+?=
 =?us-ascii?Q?bmLJW7gHehw21ZUT/M4bnDtOD2mPManqQCw52DUjZx/efa7mm2SfkpUUW2eo?=
 =?us-ascii?Q?ftiwaqW34ZDYLm8Aa/dw9y4RuCKpqWFLFXEfMRIj7V+jRbNlBkobXc+ntjkV?=
 =?us-ascii?Q?F6Z7puqoexkJEFFZ6BUeahBK+1IL01sRcQ+pkQ659TTBIoCt2PppzBZwHgpH?=
 =?us-ascii?Q?Uc108qnHn16JdZsoReSCcdAuVgcb9y5GrssGqrYZHOcWM6sHbjcd4VwxKS9C?=
 =?us-ascii?Q?MuNE+PVocb5dUt17XWTR8V0XrRtiKB6mmotjsrVkPzZTEO17L43T8fttCkNy?=
 =?us-ascii?Q?7joOx6e5qM2QBtUBT3sNp4JDvlsUhDpT8UFKkVp6tSGIbjxdO8pVPEOkpfT2?=
 =?us-ascii?Q?hM4b3UAzuLmaybghXNy8F6Y9GprXbVQBEVzMAvIeVhweSTSvjjiT3unSHC5N?=
 =?us-ascii?Q?NPTJsYIb74FyvULS8BTQ8cn/X6IkrJLfz/EmmZLHU48N28jUgZm3r8LMy1A5?=
 =?us-ascii?Q?S2kdV/rp/6AcGX6sdmnyrIyXPXH3feMq8fKXHFtHf2XI/p/uy7yESktPDi7M?=
 =?us-ascii?Q?VRiW2271C+cxBjSFcBajFPg//QP11VfGJswD8DOE4CMlbIjgW8Y5cNdBNHVL?=
 =?us-ascii?Q?nbJz+albMjL1zY3YbhZhZRRNfzR26AGtfVbandnB3aC7bALy79SArY9bh0kc?=
 =?us-ascii?Q?XTRVkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0zu3xnlHMNjmj0kI75oH+5TNWRtl4iju6Ta+KLb+szVQRIprFhoA7U7gREK7aDHwGTYY+7Tnh48OzyUy1AxIXXPL+Ds+Ifx82MDU3osYa0MMv35TPY0tylSEfDU0KGhYEQ/f270hGx3coysn22xjdN+WQfvaUTp1VjE+IcFJfjbRlzbHCBNlrLZg+p+zS1R69CbLyD6NcUFJUENfRo5UIHl3KtsjnYZfi85r/OAq7jz47ePBztWD36Lp1rDEmNylG3dHhnzZ7aqJAplrJGX65uoLD3bjHDjlc0noU8t2iX/myIMhKvEsHixhkkbYgsP77GS/1pMI1C1TxNiRatiriy/uWZjElxCvE3PgMa1VtF+TpM/69R7Molm7kznWsSG2LMPk36K51ZNDoOGHmKL0EW36C3cO3tsUkoqq6KxlRwz2OAvYKY3DEte+NcjrdIVz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:13.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874e9c03-d25e-42bc-365d-08de6336c02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Virtual encoders & hwss were grouped in a separate directory,
not aligned with dio and link component structure.

[how]
Moved virtual_link_encoder and virtual_stream_encoder to dc/dio/virtual/.
Moved virtual_link_hwss to dc/link/hwss/ and renamed to link_hwss_virtual.
Removed dc/virtual/ directory.
Updated all includes and build files (Makefiles)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +--
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  9 ++++++
 .../{ => dio}/virtual/virtual_link_encoder.c  |  2 --
 .../{ => dio}/virtual/virtual_link_encoder.h  |  0
 .../virtual/virtual_stream_encoder.c          |  1 -
 .../virtual/virtual_stream_encoder.h          |  0
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  3 +-
 .../hwss/link_hwss_virtual.c}                 |  2 +-
 .../hwss/link_hwss_virtual.h}                 |  6 ++--
 .../dc/resource/dce100/dce100_resource.c      |  2 +-
 .../dc/resource/dce120/dce120_resource.c      |  2 +-
 .../dc/resource/dcn10/dcn10_resource.c        |  2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../gpu/drm/amd/display/dc/virtual/Makefile   | 30 -------------------
 30 files changed, 37 insertions(+), 60 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_link_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_stream_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{virtual/virtual_link_hwss.c => link/hwss/link_hwss_virtual.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{virtual/virtual_link_hwss.h => link/hwss/link_hwss_virtual.h} (92%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/virtual/Makefile

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 7277ed21552f..93d02956c5eb 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg hubp dio dwb hpo mmhubbub mpc opp pg
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link dsc resource optc dpp hubbub dccg hubp dio dwb hpo mmhubbub mpc opp pg
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e7d2b861dedd..17ba7af0ddcd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -53,7 +53,7 @@
 #include "dpp.h"
 #include "timing_generator.h"
 #include "abm.h"
-#include "virtual/virtual_link_encoder.h"
+#include "dio/virtual/virtual_link_encoder.h"
 #include "hubp.h"
 
 #include "link_hwss.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b4e5a79e9749..639831295b21 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -37,7 +37,7 @@
 #include "dpp.h"
 #include "core_types.h"
 #include "set_mode_types.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dpcd_defs.h"
 #include "link_enc_cfg.h"
 #include "link_service.h"
@@ -45,7 +45,7 @@
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
 
-#include "virtual/virtual_link_hwss.h"
+#include "link/hwss/link_hwss_virtual.h"
 #include "link/hwss/link_hwss_dio.h"
 #include "link/hwss/link_hwss_dpia.h"
 #include "link/hwss/link_hwss_hpo_dp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 02eec03dc204..2f5619078e1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -23,6 +23,15 @@
 #
 #
 
+###############################################################################
+# VIRTUAL
+###############################################################################
+DIO_VIRTUAL = virtual_link_encoder.o virtual_stream_encoder.o
+
+AMD_DAL_DIO_VIRTUAL = $(addprefix $(AMDDALPATH)/dc/dio/virtual/,$(DIO_VIRTUAL))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_VIRTUAL)
+
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN10
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
index 1d226e0519a5..2655bc194a35 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
@@ -128,5 +128,3 @@ bool virtual_link_encoder_construct(
 
 	return true;
 }
-
-
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
index ad088d70e189..c5d2e9404d94 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
@@ -171,4 +171,3 @@ struct stream_encoder *virtual_stream_encoder_create(
 	kfree(enc);
 	return NULL;
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 84dace27daf7..0f3670e30232 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -43,7 +43,8 @@ AMD_DISPLAY_FILES += $(AMD_DAL_LINK_ACCESSORIES)
 # hwss
 ###############################################################################
 LINK_HWSS = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o \
-link_hwss_dio_fixed_vs_pe_retimer.o link_hwss_hpo_fixed_vs_pe_retimer_dp.o
+link_hwss_dio_fixed_vs_pe_retimer.o link_hwss_hpo_fixed_vs_pe_retimer_dp.o \
+link_hwss_virtual.o
 
 AMD_DAL_LINK_HWSS = $(addprefix $(AMDDALPATH)/dc/link/hwss/, \
 $(LINK_HWSS))
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
rename to drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
index 4f7f99156897..64742c24f7e6 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "virtual_link_hwss.h"
+#include "link_hwss_virtual.h"
 
 void virtual_setup_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.h
similarity index 92%
rename from drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
rename to drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.h
index fbcbc5afb47d..f6e448c89751 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_virtual.h
@@ -22,8 +22,8 @@
  * Authors: AMD
  *
  */
-#ifndef __DC_VIRTUAL_LINK_HWSS_H__
-#define __DC_VIRTUAL_LINK_HWSS_H__
+#ifndef __DC_LINK_HWSS_VIRTUAL_H__
+#define __DC_LINK_HWSS_VIRTUAL_H__
 
 #include "core_types.h"
 
@@ -32,4 +32,4 @@ void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx);
 void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx);
 const struct link_hwss *get_virtual_link_hwss(void);
 
-#endif /* __DC_VIRTUAL_LINK_HWSS_H__ */
+#endif /* __DC_LINK_HWSS_VIRTUAL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index d40d91ec2035..a929e64524e5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -31,7 +31,7 @@
 #include "resource.h"
 #include "clk_mgr.h"
 #include "include/irq_service_interface.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dce110/dce110_timing_generator.h"
 #include "irq/dce110/irq_service_dce110.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index b1570b6b1af3..92890784caa6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -35,7 +35,7 @@
 #include "dce112/dce112_resource.h"
 
 #include "dce110/dce110_resource.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce120/dce120_timing_generator.h"
 #include "irq/dce120/irq_service_dce120.h"
 #include "dce/dce_opp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index f12367adf145..476780a5450f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -48,7 +48,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
 #include "dcn10/dcn10_hubp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 46985eb2a623..6731544f0981 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -55,7 +55,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn20/dcn20_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 055107843a70..90d38631f63a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -51,7 +51,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 967e813a45e5..107612595db6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -57,7 +57,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dml/display_mode_vba.h"
 #include "dcn20/dcn20_dccg.h"
 #include "dcn21/dcn21_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index d0ebb733e802..6cfdc37dab58 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -55,7 +55,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn30/dcn30_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 3ad6a3d4858e..e1d0c166b484 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -54,7 +54,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn301/dcn301_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index e853ea110310..8ad72557b16a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -64,7 +64,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dml/dcn31/dcn31_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 3ccde75a4ecb..5f0fe6e5bd82 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -66,7 +66,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dml/dcn31/dcn31_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4e962f522f1b..a8283f21008e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -63,7 +63,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dml/dcn31/dcn31_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 5a95dd54cb42..4da0e9320159 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -63,7 +63,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dml/dcn31/dcn31_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index b276fec3e479..d3b92c61b7ad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -65,7 +65,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 3466ca34c93f..d08691ea27ea 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -68,7 +68,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 45454a097264..945da8cffada 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -70,7 +70,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index e3c587165807..e660889904a9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -49,7 +49,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 1d8ca312fe1e..7582217bd06d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -49,7 +49,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 4875faffe873..f5e02a1ff771 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -47,7 +47,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dml/display_mode_vba.h"
 #include "dcn401/dcn401_dccg.h"
 #include "dcn10/dcn10_resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/Makefile b/drivers/gpu/drm/amd/display/dc/virtual/Makefile
deleted file mode 100644
index 931facd4dab5..000000000000
--- a/drivers/gpu/drm/amd/display/dc/virtual/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the virtual sub-component of DAL.
-# It provides the control and status of HW CRTC block.
-
-VIRTUAL = virtual_link_encoder.o virtual_stream_encoder.o virtual_link_hwss.o
-
-AMD_DAL_VIRTUAL = $(addprefix $(AMDDALPATH)/dc/virtual/,$(VIRTUAL))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_VIRTUAL)
-- 
2.43.0

