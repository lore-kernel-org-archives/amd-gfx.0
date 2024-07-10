Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160BCC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE7310E8B8;
	Wed, 10 Jul 2024 19:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwn/Urlk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8990510E8B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWyi6Vr8G+aTB5Mt4qYZ5aBDOaNwZ9mDaWOhecemGEW9JYNuZruIZV6Zno2e69AZZxuHh5d1NyiQ+CSRBM3PJWIXGjrqyudYCQxjgy1bKf0Z463MOo7oPGYu0b7F59Fu8lfj43MI/bv2igfLexcQOBQKFy53IuxuMv1uu5tuiSHG5fgH63MPU1rImxunmyfwAOODMFEsgy/wxBt6tRDu+V/j1tDoMc3e7DlozghpZjOfp1DgfxJqC8wUkeokoC6vzKPgxSk3GT+kR+3dGti905PUKwMvNRZYsNfVxiYpllxqwdAtdiC9opWA2WtWkNU5Vnj5tnfdI2JJQbWNuMJv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBsYCZquOgb4JU8vf+wpeur4j839MjGfkG6djz0O+g0=;
 b=X5HJt0ZgFe+NTlFYrYAzyo65lzAk9YWB/Xqp4xQ6pNQje67lP0th/qKe5KbcV/hTUnDBBYbkLmaJ5XPzt0tmtLOlFDXpwygL1Qqvu/tv6h9aVP7PHN7EVi6jSa/MH4fCU8GDlV0FBoSsdwYU6hl9/7wQq1BHNRmFa7uLPT7o6sgzh/vBeE+cRQ54n1kU+STzKzusgooiCKjIsrBeZ0Gu75CTP1Hn2S9o1swlhWnqIEfc2Z+aI4tZEdn961UuT4p7qZQRdnnb7QRfNJNszrnXWY30yalVoU6OTY/6N/wfRMIBR+qcSKGFSU5GhXdFHG5SLPZKKshV06vrT8z5zc6xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBsYCZquOgb4JU8vf+wpeur4j839MjGfkG6djz0O+g0=;
 b=zwn/UrlkYIEO4AqPR4BOxub8P7Qfi5mg1WM6KcgC8njldfts+VX/I8fOJcNZ53EzZFfaQPf07QFrscID+WgJUZc7ea24d6WIBETBqMm6adMDnatQiRsLZ2IzQSCc/gDDb9nV7AXmU79cPXeYd4jMR+t7rP4nVZeueB5PxbbksS8=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:39:21 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::15) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:18 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:18 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Mounika Adhuri <moadhuri@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 27/50] drm/amd/display: Refactoring MPC
Date: Wed, 10 Jul 2024 15:36:44 -0400
Message-ID: <20240710193707.43754-28-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9a9033-633b-4ab1-c4eb-08dca117feaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTFHbGVVcXluNlFpeTJVWmo4Qi9zUGRTYzZVais5RU51ckNRS3I1ZXgzM09k?=
 =?utf-8?B?QkJEd1ViMzJKWFBDT2IzVjdOU2RHTXNJdE1GMGVVQVh3RHhUNHQweG52SkVD?=
 =?utf-8?B?ZjFTTTZod05rVjZTUHFPMUtLYWRibUZSeDlscU1IcHA3UHVqRHhpNEcxUXFS?=
 =?utf-8?B?TDM2T0M4NTV4SXJDSTdDTXROQm1Hby9DdzRmcW1YTFRhTFBQbmxvdFpPb3BY?=
 =?utf-8?B?UFZ5SHJLY3JiUUdqZ01uUmpvSjNYNnRRdW5kdGJFZzlaS0swODd3dEpTY05M?=
 =?utf-8?B?UVFtSXNkT25CWTFGWE9YTWdLc05malIyU1pCaFk1OVNaTy9qaytZNG5CVzda?=
 =?utf-8?B?NWJhejBYRWE1VzEzODFDVTNLQ2I4ZkhNaVllRDJmaytRczlBSFhnOUY0dGhz?=
 =?utf-8?B?eUdtZjI5czNoQkZ0M1RNTDNVbDFBYmxFUHJTUjNHZGtsUjBNWUJrb3JCVDJs?=
 =?utf-8?B?UHhJOU16MVd3NGNjRlNyTGZWSkhpL2tJWUt5TURZMGVEYloybFBRQ2ZiTWZU?=
 =?utf-8?B?T2IyTVkwMUFDeUZ5UWJIcENLc3hWVVpxSnBzb1Q2SDhGQVl4Yzk2Q3RkS3Uw?=
 =?utf-8?B?RHFhemxoNDZFTW45dzV0WC9iSDNwaHd0UkhyOGZHU0lmd2cydmF6NmhZN1BW?=
 =?utf-8?B?RVlKNjVvRlV4YzBub0V3ZXJrc3crUktTb0hBNVdIZWhUclo5dHlPb0Q3endQ?=
 =?utf-8?B?ZGlYWXF0dnJwZUxnUWVvelVuMlAwcUc0Skh4dWdUTGJPLzB4Mnlka1VQVzBX?=
 =?utf-8?B?VVJFYkRUU3RYLzU4WEV0VTRUOWY2NzhTbkgrbmtIdSt1enplSmdnNWpzRWZK?=
 =?utf-8?B?MTkrN0h4dHFadXpUMy9ndnVNRlBJV2Y1RVlHcXdJR050YTQzUEhDc3VzQ0pK?=
 =?utf-8?B?QzFacHV6TzU5dEtKOXZVdDUxbHRCWm1JZG51QStvTlVnSTJHN1JlSDg5WTJG?=
 =?utf-8?B?Q0pqMjBVSWRHUERvZFJrYjFLMTdMOVhJcXpYbTFuTWw3QlFudWc4cWdtZUFM?=
 =?utf-8?B?SDc3ajBJRkI2R1BEaHNMSDZITjJadmg5alBHVWQ3ZHhwWDhOWFlXUUNEZzlZ?=
 =?utf-8?B?djlkRG05akM3T0VIaVpyRHdkbVI1U1lEZjh4dG5vL2o1SXJMRURhYjhLR3My?=
 =?utf-8?B?ZlhQV1A3RG5HR0ZrektCK2VuNzBPektDV0ZZd0xFSGtMZXc3c0pYeHB6OWZB?=
 =?utf-8?B?bFVIREt3bi90QUxVeUhHaG5EajM1amFVMk53UXpIeDV6YUhWeWdPUnMzeWhU?=
 =?utf-8?B?OGFlKzlzRm1sd1RiRVVOL3VyQVI5UExNS1VZWUZSZzQ1MUtiUDB6TzY3am5E?=
 =?utf-8?B?OXZpbk1ZRmw4akYzZEJvOHV1bVZBZmZxUWZ3cmRjMWl0T1NxaC9tMHNuL3hs?=
 =?utf-8?B?dytNTVBDQzV3RUtJbUtuclppNldsLzM0ZmtGTm1GOXh5ampQbDRHcjFOS0ZT?=
 =?utf-8?B?S2NUTUkyb3djbEpXZmJ5bFBETGVEa2lXaWZNai8yc3VGTzJVWjNPYkFJZ3hp?=
 =?utf-8?B?ejluemptYjdWbkN2WFY1U3h6OVRteWUzZDJROThiekdzWXNoQ0FMTTNPOUtC?=
 =?utf-8?B?S1Vua1pLeVppcVZtMDVIY1N2ODM0NGJ6UmhHeHkzNEpSdGVDcUVCKzI0eTIx?=
 =?utf-8?B?dFM5THZXVjFObTU0bUFNWG1BRnVlWS8yYy9JT0NBMC8xdEMzVG5HWU04cDVJ?=
 =?utf-8?B?NERXaDdGOEVvR3FTT1lqcks0blNzY2JNWWVkZmF1WXo5Y3Z6K3dZSC9nSnBI?=
 =?utf-8?B?WTF1SUpJU1JvZlpFZUd3TVZHZXBsbUNIOFlWd3NYWEptdy90V3ZwQXBQZytw?=
 =?utf-8?B?Yy9wU0xnRlFNRlBhYzlyTHhJdjBoT09VZ0FrOENWQUNKQlhGU3YzTWFPa1FC?=
 =?utf-8?B?TzZ0R2VBWklGRXJaVk5JYld5NFU3VVdFbUxaTGc5aUlFbGxCeVVMY2xObVQ4?=
 =?utf-8?Q?PQSbVrBpFKN1RBd3si2vogLEtVi+f9Eh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:20.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a9033-633b-4ab1-c4eb-08dca117feaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

From: Mounika Adhuri <moadhuri@amd.com>

[Why]
To refactor MPC files

[How]
Moved MPC files to respective folders and
updated makefiles appropriately.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |  1 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  3 +--
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   | 27 +++++++++++++++++++
 .../display/dc/{ => mpc}/dcn10/dcn10_mpc.c    |  0
 .../display/dc/{ => mpc}/dcn10/dcn10_mpc.h    |  0
 .../display/dc/{ => mpc}/dcn20/dcn20_mpc.c    |  0
 .../display/dc/{ => mpc}/dcn20/dcn20_mpc.h    |  0
 .../display/dc/{ => mpc}/dcn30/dcn30_mpc.c    |  2 +-
 .../display/dc/{ => mpc}/dcn30/dcn30_mpc.h    |  0
 10 files changed, 30 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn10/dcn10_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn10/dcn10_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn20/dcn20_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn20/dcn20_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn30/dcn30_mpc.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn30/dcn30_mpc.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 75e088b479ea..e1f6623d4936 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -24,7 +24,6 @@
 
 DCN10 = dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
-		dcn10_mpc.o \
 		dcn10_cm_common.o \
 
 AMD_DAL_DCN10 = $(addprefix $(AMDDALPATH)/dc/dcn10/,$(DCN10))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index d92d2b4ee015..25ba0d310d46 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN20 = dcn20_mpc.o \
-		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
+DCN20 = dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 4c43af867d86..804851247acc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -23,7 +23,7 @@
 #
 #
 
-DCN30 := dcn30_mpc.o dcn30_vpg.o \
+DCN30 := dcn30_vpg.o \
 	dcn30_afmt.o \
 	dcn30_dwb.o \
 	dcn30_dwb_cm.o \
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
index 7f7458c07e2a..5402c3529f5e 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -24,6 +24,33 @@
 #
 
 ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN10
+###############################################################################
+MPC_DCN10 = dcn10_mpc.o
+
+AMD_DAL_MPC_DCN10 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn10/,$(MPC_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN10)
+
+###############################################################################
+# DCN20
+###############################################################################
+MPC_DCN20 = dcn20_mpc.o
+
+AMD_DAL_MPC_DCN20 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn20/,$(MPC_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN20)
+
+###############################################################################
+# DCN30
+###############################################################################
+MPC_DCN30 = dcn30_mpc.o
+
+AMD_DAL_MPC_DCN30 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn30/,$(MPC_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN30)
+
 ###############################################################################
 # DCN32
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 3aeb85ec40b0..fe26fde12eeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -25,7 +25,7 @@
 
 #include "reg_helper.h"
 #include "dcn30_mpc.h"
-#include "dcn30_cm_common.h"
+#include "dcn30/dcn30_cm_common.h"
 #include "basics/conversion.h"
 #include "dcn10/dcn10_cm_common.h"
 #include "dc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
-- 
2.34.1

