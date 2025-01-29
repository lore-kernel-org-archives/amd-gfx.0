Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B96BC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481C410E732;
	Wed, 29 Jan 2025 03:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsRtTMXa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE62D10E732
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAiyn15WiOI8F6P7IT6muxCfNhBP89BL+vRQhL3pyhdmQ2I+nGgmxtaFG2+NC/HkAzf3kpiPMJ+ga4I133SwiERkg/CaajvLIwNXIjtmmSWDORLdcGG566Lh8HUxpKhelglG8s/Owf/fq+66/y4VbbM2lLI8GJgpWFFGUC/0lho6yH/dak/4/QWZAYEqxshANC/ZiIhhBp33Jmljj62IhB7owXlcxm/g2UemrX2NZUZSNFrwuo2NcVAZJVRFzNdQ3cZ7DRJvqZQpkCSVcm0yYcuEnJMjGqtHC0XUrtaGUrnIx/7IsHGhvUCG+9YEtD4r7KpyFPgBNcLuc0a40/i9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRvE4NOnVLUCKVTwayupwbqEF5pU5gdXJyxTPLGqK2o=;
 b=YYriWAqRuBlC26Jb9AmluzYRWgKlqMEPjURNL9JHS7r5mUpTKA91cM6At1UVOtjeronH3Tc/C5MuXEhAEbpgBVhlG4d7sMp/MqEhqjf8cCkKADIpP2wn2FQ0kuCuAjVLyxhEjS2TX0vU8zIV6K7HJBlcI5npwutihYjwFUjfKUN8Q6nNA2vbJFndHl83OZC52SgmjEbxYQuXwAR3VpnshHAjEwpUXa4mKWL/HHtgsz2qkQJ9erGRLnVfqbzqzq+5Zd7SdfTOMT1JJF/vIdo7JCpFuFriGt/UXu2mh3kNl5qPcez+PjxdxMkcrNhvK+CP3tlHRn6k/EL+7pXy4OQfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRvE4NOnVLUCKVTwayupwbqEF5pU5gdXJyxTPLGqK2o=;
 b=jsRtTMXaDI5Hut8dIKEGBUCE35SZb3tyIWcTP2DadjolZsMIGL5IzWt+eBqSDcCPhcVzuLnKN80NqYnm7Y8qJrZ+8FPXL71wqGH11HRk+rLyC1UQpyuKE1idvc+mDZvlMRd2Md3EsyceenGngTQJ1nXhi3uSihtMdiAQUnSLYOg=
Received: from BY5PR17CA0011.namprd17.prod.outlook.com (2603:10b6:a03:1b8::24)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 03:06:57 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::29) by BY5PR17CA0011.outlook.office365.com
 (2603:10b6:a03:1b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 03:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 03:06:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 21:06:54 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, George Zhang <george.zhang@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/10] drm/amd/display: Move SPL to a new path
Date: Tue, 28 Jan 2025 20:04:48 -0700
Message-ID: <20250129030453.2129085-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129030453.2129085-1-alex.hung@amd.com>
References: <20250129030453.2129085-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 895c960e-cf0f-4437-47d5-08dd4011fda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OpfLmNnZcXgnO/uq8i+ta9uV175xQcICAfz1oVYV4THapIXXkDBezz8yxqz?=
 =?us-ascii?Q?YbPKklO/36SwZQnEZOqJGTXUTeX3hwRapBDdV96/e68ZYnP4nMb6/1UpkEJ9?=
 =?us-ascii?Q?yERkUvmygRvf6UtrRrWwjUC7nWA1WwIV1UJJqbGX3WDwHDovL/Vdb5m0fg33?=
 =?us-ascii?Q?wLtvz6YNesUFuY8wLVTBXb9MXSFsn5EmgQFYE6/ZCPKj4qhzV02T2MHKOQA/?=
 =?us-ascii?Q?73DurqllSUSsbQ3bDGttpUbHYzHTnNtN273bEvhhfGaapdww4D4VBTt7O+fR?=
 =?us-ascii?Q?KaNUVkjMZSAmAywBvV96bsUsgtqNaHiH+xv0qLiVs5qopC1WIQWafLd28TEB?=
 =?us-ascii?Q?EEqKwn94UsFyq0ahzqVQ/VxMmFVfO27DwP/TRt6iK9+BXnr66BVDnWWt79Pp?=
 =?us-ascii?Q?T3nC6FuZ6ruxulPwZqKuijACTo5BWZOQ1YBEtzDW1zMPZwHuOfDqoEbEcON1?=
 =?us-ascii?Q?jQL8fhz7S43dZnlD2JknCjCedqZz6/1dhCUHSwbZXloJ9rJZsqzkc0+tbwB9?=
 =?us-ascii?Q?PTOBU4bPtqAvcbrEcrKJ+nGIRbtYExwz4fSAkg7+AcksP4slY5uvUv0302KA?=
 =?us-ascii?Q?NAi9xrcwZVS59fTHbTFY/Yy9zW8KmjA+e8B0a2KLwI259jH4AZKQyYWKvxwn?=
 =?us-ascii?Q?V24ak0rbBBR7KCsb9UBB8ujsEbL3+JqLajUmc1a8LeeygrTcIVW2FWM/rQg9?=
 =?us-ascii?Q?oLMQdsjykqnBvRlREhsfFdfNeLiS5X367VstFZkHtxJGV6etQy8S+w1xdtQG?=
 =?us-ascii?Q?ScQ5udbh5mqiUXUPbpiq5YKCmMWs2ZSvYBBW3uKDTtG9cSuHzlzV2riWWHLa?=
 =?us-ascii?Q?Vp/twUHcsZOR0QZYz4ovAU3b+Jb/M8pXLwhijShVUI+y2AbPYJ2jwbwXlDpW?=
 =?us-ascii?Q?2N3Ov1JrmSI/mzz3b2/cFJ8HpVo+i4VJ9r5rqTeX5TmbwMx848UgXy3YqjAs?=
 =?us-ascii?Q?42ACX5lGXCLkMz0SOpQV5CwtifyqtSXUDpJQOoe8FJEk+sLoR/WLc9wfztYH?=
 =?us-ascii?Q?br6HrWq3SdrQeO2q6IlX8g8qARbpQRzvDIEBAWnfdY1qXxCp2pLXW25+hKlq?=
 =?us-ascii?Q?kLS2/sOTuWjnSpUaPFP/d7lmoDtCES4wzJd23EGzSNYZHvCznOwQhHPCbC3J?=
 =?us-ascii?Q?S8DZtNzrSM9g2VzpM+3ceiQvm+boaJiTt6m85KMh4QyOq4Qc4PsbYemYkFM3?=
 =?us-ascii?Q?xqDFhrpSAF2Xs2rgPEv8xLbG1MHA7KbHj3CyjBFPyJQMhcm0YUJZhwoFqHm8?=
 =?us-ascii?Q?6H3oONWe8qBnzoDdA/7vgzEUGoPnnsYvo9UJnCGr8oULbm2lXCGKieuxxygs?=
 =?us-ascii?Q?1ENk9GqnSjcUZ1GLTL+roSt8NFjRFm3VyXUYhFL86Nu0goolka0GDOO9BKVH?=
 =?us-ascii?Q?2NMYzJ9Yut4poUy2Nhf3ebrxsH0/8GR73/QivnpaJHndvKeF8Cvlktp54Jv9?=
 =?us-ascii?Q?10BGe852Z//TX0oW6qcL3R/AZrdTWNYn91aksp1B5AB/ejg6EMAOla4SGXz4?=
 =?us-ascii?Q?Sx2tOKDBs9eYgWA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:06:56.8743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c960e-cf0f-4437-47d5-08dd4011fda1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

[WHY & HOW]
- Move SPL from dc/spl to dc/sspl
- Update build files and header paths
- Remove dc/spl files

Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile                       | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                           | 2 --
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c             | 1 -
 drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h          | 1 -
 drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h          | 1 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h               | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h             | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h                 | 1 -
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/Makefile         | 2 +-
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.c         | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.h         | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.c | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.h | 0
 .../drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.c  | 0
 .../drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.h  | 0
 .../amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.c    | 0
 .../amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.h    | 0
 .../gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.c | 0
 .../gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.h | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_types.h   | 0
 .../gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.c   | 0
 .../gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.h   | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_debug.h      | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.c | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.h | 0
 drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_os_types.h   | 0
 27 files changed, 6 insertions(+), 12 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/Makefile (96%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_debug.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_os_types.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 8992e697759f..3e1f5b689718 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -52,7 +52,7 @@ endif
 DC_LIBS += hdcp
 
 ifdef CONFIG_DRM_AMD_DC_FP
-DC_LIBS += spl
+DC_LIBS += sspl
 DC_SPL_TRANS += dc_spl_translate.o
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 559446dcd431..9ac299fb1034 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -46,8 +46,6 @@
 
 #include "dmub/inc/dmub_cmd.h"
 
-#include "spl/dc_spl_types.h"
-
 struct abm_save_restore;
 
 /* forward declaration */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 3518eb1b8cd1..e3a8283b4098 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -3,7 +3,6 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dc_spl_translate.h"
-#include "spl/dc_spl_types.h"
 #include "dcn20/dcn20_dpp.h"
 #include "dcn32/dcn32_dpp.h"
 #include "dcn401/dcn401_dpp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
index f09cba8e29cc..85f359b5da67 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
@@ -26,7 +26,6 @@
 #define __DCN20_DPP_H__
 
 #include "dcn10/dcn10_dpp.h"
-#include "spl/dc_spl_types.h"
 #define TO_DCN20_DPP(dpp)\
 	container_of(dpp, struct dcn20_dpp, base)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h
index 992df172378c..f33dddbfcc31 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h
@@ -27,7 +27,6 @@
 
 #include "dcn20/dcn20_dpp.h"
 #include "dcn30/dcn30_dpp.h"
-#include "spl/dc_spl_types.h"
 
 bool dpp32_construct(struct dcn3_dpp *dpp3,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 37632be09e09..d0021f25f3d8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -39,7 +39,7 @@
 #include "panel_cntl.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "pg_cntl.h"
-#include "spl/dc_spl.h"
+#include "sspl/dc_spl.h"
 
 #define MAX_CLOCK_SOURCES 7
 #define MAX_SVP_PHANTOM_STREAMS 2
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index 45262cba675e..5a1d9b708a9d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -29,7 +29,7 @@
 #include "hw_shared.h"
 #include "dc_hw_types.h"
 #include "fixed31_32.h"
-#include "spl/dc_spl_types.h"
+#include "sspl/dc_spl_types.h"
 
 #define CSC_TEMPERATURE_MATRIX_SIZE 12
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index b32d07ce0f08..042e04f924a2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -29,7 +29,6 @@
 #include "core_status.h"
 #include "dal_asic_id.h"
 #include "dm_pp_smu.h"
-#include "spl/dc_spl.h"
 
 #define MEMORY_TYPE_MULTIPLIER_CZ 4
 #define MEMORY_TYPE_HBM 2
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index c1ebc6b1c937..5cb0e0191a16 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -76,8 +76,8 @@
 
 #include "dml2/dml2_wrapper.h"
 
-#include "spl/dc_spl_scl_easf_filters.h"
-#include "spl/dc_spl_isharp_filters.h"
+#include "sspl/dc_spl_scl_easf_filters.h"
+#include "sspl/dc_spl_isharp_filters.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/Makefile b/drivers/gpu/drm/amd/display/dc/sspl/Makefile
similarity index 96%
rename from drivers/gpu/drm/amd/display/dc/spl/Makefile
rename to drivers/gpu/drm/amd/display/dc/sspl/Makefile
index 5edf3c6cf3e2..5e3e4aa13820 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/sspl/Makefile
@@ -25,7 +25,7 @@
 
 SPL = dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_isharp_filters.o dc_spl_filters.o spl_fixpt31_32.o spl_custom_float.o
 
-AMD_DAL_SPL = $(addprefix $(AMDDALPATH)/dc/spl/,$(SPL))
+AMD_DAL_SPL = $(addprefix $(AMDDALPATH)/dc/sspl/,$(SPL))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_SPL)
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters.c
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
rename to drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_debug.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
rename to drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
-- 
2.43.0

