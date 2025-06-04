Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AE4C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E8310E7EC;
	Wed,  4 Jun 2025 19:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oev2mOmk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FEF10E7EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIowZBHDh3wmt00hxry3LXGMANGrtf1iasCrxcteb8DcF2dkibnBWhj92a+j9EgbjTluw5pSswNZM57erzbFC4GX4V00smu8+SVJ/pdYIrje7qHNYlmgSr7ZFFV35QXzH7cgaR35XJIDdnUBumrxg9xMihLjCM066NCxbREW/lx/VAApCV/boxhi5a4Bdy2jxyTEJHWGSbTms7Wk2cAlHCKESo/1aHws7cvW2MTrM2zEwEmsVZFKNvT6foY5JH7w2t3h6kPYv5iLkIPXnJMHz7+wfksh9ZekOSWqzR21ui36jgX0tN6NmzAs/MRLcTAGCYrWYV3qzOXgfAkqDCw3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXqqOoRGuL+tvxpHYD1zJLHY0G4SyQ6De06cABks4OA=;
 b=Mr6pOvimhRAq7ljkMKRi+kMrlxRTOhlYSFXiWjuCdUTodBueckQy8dLxZw4a7ezVpSpTbfxwtJ3CQx4KnYknkO+PXcssEGxGslJyBC9AwdNlht6z7PKS3cpcELLkj4fqW8PLv5c0GzCCerPlhUZeli5Kv41Wa01MC6YnVkgolm2/1pJ2qF5WRtoy+SlUiUkbvyYrnyA9kgQfXzCwDod1UdBNfU3kBl2wa2wjK15ADx1SgIVwZ7A9dsreXQlLCGWbcE/MkZOLKPMndxQGD2rDUlyYQKD+vBOhZ8bAItME0SR3hoMTkBATYfCTVRzUzCRdhLLX6iC2rd7WxLGXNVnBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXqqOoRGuL+tvxpHYD1zJLHY0G4SyQ6De06cABks4OA=;
 b=oev2mOmk43XqokoN2KwqdhIvCGpTKrkNpUAa8QuOWaiJlbJoo0QOZ88n2lluAd/BGNshMn0L7CCaTcjJ1VqaT4cPmRMoOHNO5xctCpdI3MU9rO5KBz0ufpxrTu/8HssAAspQE0uybI4N2KlM0aApPlLCudg5cBzH2Lpf2Y0AvuI=
Received: from DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23) by
 CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:41:08 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::a0) by DS7P222CA0006.outlook.office365.com
 (2603:10b6:8:2e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Wed,
 4 Jun 2025 19:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:41:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:41:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 17/23] drm/amd/display: DML2.1 changes
Date: Wed, 4 Jun 2025 12:43:28 -0600
Message-ID: <20250604193659.2462225-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 13653bea-2763-4412-4622-08dda39fc086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75emdTfmdIGUCTMy8eQ4EQWgInDkQWSnSIwt94LvOEo6UHX7YZ+OdcBYbTXr?=
 =?us-ascii?Q?fevsHiIbm4u4KwQv2RophRNNCpX1N374rldyCR2Z6ewpoCaF5uh0dkn3rqJw?=
 =?us-ascii?Q?MZBM/rUS+7uKV0ZBVDfEU5di9wfi5Llydt9BWcM9/SxbKGRApKav7XPzP+l6?=
 =?us-ascii?Q?cUtTacDkutiMR3UP14xTEdCgPh+3NNjo7sESF/Jz3UoCAV0AlDaZOmP0HNXc?=
 =?us-ascii?Q?zanoj04D65cM2EDB8tvE5d6VEtu2a1CeCKe1yhd3BBHOu7rXy2Zh+nikWviQ?=
 =?us-ascii?Q?miM6z85wSGkqZXqsw+GrhR2yZ2iNNGM7ZizXi29QT983ZYh/WmH+GEmMPn86?=
 =?us-ascii?Q?w0h3pyP4UOE0NBUcjlbf0GUW9OYQaFXpxO1VKYrXKqAJuNDThnB51j6Thp+M?=
 =?us-ascii?Q?yPrh5kPBh0cj/JnGyDb7gdsLzYI06ylWGCizauu5CWh23af6QY/z2I+jJnP+?=
 =?us-ascii?Q?DrCaB63QQ6JgaxnL3cojuvs7/P5tBNiDK4ERtfCKSj985QfRmd5YCGQqyXl6?=
 =?us-ascii?Q?gFAf2OsXjdgN4Yn37AK/PoF0ZuoUbwSvysCyhzcVrKTIKrC3gQBORCjFC2LO?=
 =?us-ascii?Q?w3xQd9xmUQTL+Y7XPE9lFqldQRMiHRilhvXn7fzyCSnI2jMRzHzCkJjMohxc?=
 =?us-ascii?Q?zqNN79ZanHsI86q2BNS03A4y04dPlV4GDt9q+aQ+AAz4plccE5dzifOlapSt?=
 =?us-ascii?Q?pTTPm+TyzNbzll4kTqJYYVR6DVVtynXazyn2G924exttsqAMs6toKzQZwix5?=
 =?us-ascii?Q?XdjesSGJC9pT3sOiGF5M7E3iMw8AtSlvAubs9funLogb7aVZS5E7/qID+Qno?=
 =?us-ascii?Q?phQ3dhp3UVYZ7Letoydssi/XEZyvKgnexifDnOsqfTlvEG5gq0W8QE/1DyS+?=
 =?us-ascii?Q?bu8ZD+st0nPn183AscxdI/63z2erbLvGdhSX8GFtggJNjp3FgsbNEdkY9ii3?=
 =?us-ascii?Q?TlGCSbPVF3zFjb8AzAr2kUXghiL7d73l+B/0NlfkPqovGQ4M0ewe5tQj5rfq?=
 =?us-ascii?Q?S5yA8VwNe2TTQNYDEmjngCud/RhKf/gl9N1cwjnZMfjC5ivLx/KSEh1L1qp3?=
 =?us-ascii?Q?cE3DnfZPwe/gY56vF8BFhwhWB36SE93gAGZANCdj9pZcSAjgiK2w26XAXpJL?=
 =?us-ascii?Q?6fAQTfBvnnm408LmO/R0whi8ThbTEJAyQGC3wf29fe1RoaXKPKs5W6o5fpII?=
 =?us-ascii?Q?ezY+wGieCd8fPH0B6we1ISdjoHNXqqXl5YUUvK1N7/fyainq7rwgPPKIbxgb?=
 =?us-ascii?Q?nIU7ST8pBke5e76otT0SqmZhSRjFxApdLXfYTIxCMVVHEkxgyqQJ8JWUV6q0?=
 =?us-ascii?Q?VRWGg1TEPXqd9LriBPIqlAOM1m7NZsOLSHA6gG7YiiJN6vAId1WP1KkuEIgw?=
 =?us-ascii?Q?akiGB8dGwVS+XymghsWnqM3hnwgJKuKDZuWhxPTOkLeTxN0flbW3QZV/tPsZ?=
 =?us-ascii?Q?iFoPjJgmt8+gU9n9PegzItS9Hzr6EgCSZSXAC+k+dQMxSudnjNXdV+NSvtLp?=
 =?us-ascii?Q?QbBVMLFOjnqthaoOAJvQdZ8W7qljKkypHMXY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:41:08.0821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13653bea-2763-4412-4622-08dda39fc086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

* Add a missing compilation unit
* Missing CFLAGS for certain units

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile        | 13 +++++++------
 .../dc/dml2/dml21/src/dml2_core/dml2_core_utils.c   |  2 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h  |  1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c   |  3 +++
 .../gpu/drm/amd/display/dc/link/link_detection.c    |  3 ++-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile         |  2 +-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index 157ecf008d6c..4c21ce42054c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -81,10 +81,11 @@ AMD_DAL_DML2 = $(addprefix $(AMDDALPATH)/dc/dml2/,$(DML2))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DML2)
 
-CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_ccflags) $(frame_warn_flag)
+CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_factory.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_ccflags)
@@ -94,17 +95,16 @@ CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.o := $(dml2_ccflag
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.o := $(dml2_ccflags)
-
-
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/src/dml21_wrapper.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/dml21_translation_helper.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml21/dml21_utils.o := $(dml2_ccflags)
 
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_rcflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_factory.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_core/dml2_core_utils.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.o := $(dml2_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_factory.o := $(dml2_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.o := $(dml2_rcflags)
@@ -120,6 +120,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml2/dml21/dml21_utils.o := $(dml2_rcflags)
 DML21 := src/dml2_top/dml2_top_interfaces.o
 DML21 += src/dml2_top/dml2_top_soc15.o
 DML21 += src/dml2_core/dml2_core_dcn4.o
+DML21 += src/dml2_core/dml2_core_utils.o
 DML21 += src/dml2_core/dml2_core_factory.o
 DML21 += src/dml2_core/dml2_core_dcn4_calcs.o
 DML21 += src/dml2_dpmm/dml2_dpmm_dcn4.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
index 7a220c0141c2..5f301befed16 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
@@ -464,7 +464,7 @@ bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw
 
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode)
 {
-	return (sw_mode == dml2_sw_linear || sw_mode == dml2_sw_linear_256b || sw_mode == dml2_linear_64elements);
+	return sw_mode == dml2_sw_linear;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index ecaa976e1f52..702b787c640e 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -641,6 +641,7 @@
 	uint32_t ISHARP_DELTA_DATA; \
 	uint32_t ISHARP_DELTA_INDEX; \
 	uint32_t ISHARP_NLDELTA_SOFT_CLIP
+
 struct dcn401_dpp_registers {
 	DPP_REG_VARIABLE_LIST_DCN401;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ffc5f0e600bd..a0d61df07f22 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -481,6 +481,9 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
 			width = hubp_3dlut_fl_width_transformed;
 			break;
+		default:
+			//TODO: handle default case
+			break;
 		}
 
 		//check for support
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 9655e6fa53a4..827b630daf49 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -593,8 +593,9 @@ static bool detect_dp(struct dc_link *link,
 
 	if (sink_caps->transaction_type == DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
 		sink_caps->signal = SIGNAL_TYPE_DISPLAY_PORT;
-		if (!detect_dp_sink_caps(link))
+		if (!detect_dp_sink_caps(link)) {
 			return false;
+		}
 
 		if (is_dp_branch_device(link))
 			/* DP SST branch */
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
index 1e2e66508192..5402c3529f5e 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -68,5 +68,5 @@ MPC_DCN401 = dcn401_mpc.o
 AMD_DAL_MPC_DCN401 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn401/,$(MPC_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN401)
-endif
 
+endif
-- 
2.43.0

