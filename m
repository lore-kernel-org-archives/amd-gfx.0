Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD82CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAD710E9B7;
	Thu,  3 Oct 2024 23:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8MY64PJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A7810E9B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUajqPtMPPj3p4EDa+gLnRsLfIVS6ByKKLj9yIaA2jPRjKhHEL2LDTH9CxK5JNWF9JtGCNxyIKqPsm7vWdLmUNw+EFs2MhionCZJsScIzZiO9t7cp7uwSzFAyHJdGEWed/M3WcEGTdStQhdwKt+sJc1lUtwqGWI36xKjPMmXQNLGXBM4pQr8S4+HmDKRZz1ScxMI3WxUxwLev/haVcd1bnfCxLnDnuOOCCQQq8sWd3rpMmNz7xRooSkvzHIdYkx8iYkfv92EIySUJXR+mO0f1x48CNTkV3LaP0OtEp6PDTIBxQ76yQ1rzMUMvO+YeFCXCNnUKSXTDthJM/ZaN6S3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u11aOnmjIdNgmUZtaGHdP7Y9E7vKZjexcYX4PQEyl0=;
 b=lROi7Ee4DIri+R4FAOv+z2QSCRpU6w+2hk37VuU6qrUuRQ8NluXsmU5wU+udnP0Dzpf/ZjIHGSVxbGJIZpZ1JuT5AtMM7EcyYyzjVPp0+rAgN1xBHNMsefMACdW2DzfOya6Ktq8843waUd6gNXcNg8haqipnDernirxcR2h8gYywpROi66dYQ6P2stc7G8bg7Fi0iB70X4CrdYr1NRcxxMaeuOVccJd/TujxBXVcXGqOMft+2ShJ3TX8R7v6k3kiz9U6NGMhRQSPUBgEBgROtX8xl1g+rlMvAqucXF9UJeA7VmP/1Fqx2n55X5pIVuG+95N3VgyTXSRuD+ySk3jmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u11aOnmjIdNgmUZtaGHdP7Y9E7vKZjexcYX4PQEyl0=;
 b=s8MY64PJCF5rG5pKhnwz+/Qyof8i0zcClM4trY7wWEk2S00NnMU9Nkwmw21ZYg3X4jn8WHI73qpB7wtsAWIqe+XHCesUy4JPjTJdgB9PKAIs5QIGhUAldSgdtlLPJDDkTkNzpSCVvWEgUDKYT+lt7q91XKckSufUdwM8iKbvFeY=
Received: from DM5PR07CA0086.namprd07.prod.outlook.com (2603:10b6:4:ae::15) by
 LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 23:36:19 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::f4) by DM5PR07CA0086.outlook.office365.com
 (2603:10b6:4:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:11 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>
Subject: [PATCH 22/26] drm/amd/display: Remove unnecessary assignments
Date: Thu, 3 Oct 2024 17:33:40 -0600
Message-ID: <20241003233509.210919-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b66d19b-9232-4a6e-34a8-08dce4042e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uemlxm52mOKglt1nNYfJxx29iwRbAkBuLfqQDKHyru4ipqscNi4gWci7hsOY?=
 =?us-ascii?Q?GoJYEGXzM26Hahq0ArW5BoAHnJhGSIt13p4+de0ryOAgBFykDykOk3v4tRe/?=
 =?us-ascii?Q?c8mPTN74ru1GZgpQpM3p05Kb5eLkMDFeZq/y54eO7+bIDWZSqcBkAaPJ5Kj6?=
 =?us-ascii?Q?xmLVwkN2Gm6Sj/xXN/gxxNJBi8pRPFRyXnBgCj3KIsONNJp4DTQCyJOqLV9h?=
 =?us-ascii?Q?Fb5tZdaH3f9SF2GAdHp3pmUODSYyCxcdGJNykhMGYknTwbCzKnlZ7oBgWvON?=
 =?us-ascii?Q?MzDmrO8G80l873nLorLP1eSV4MH4kBGk6HwiOtfXE+zgl0tqRhnOlkeQ/vBu?=
 =?us-ascii?Q?gqNL7sc5pFyDFrLucfR7IXUPGoJBuPJL5jbGT8mUBVpAgdZTgUrkGYVy/Q6b?=
 =?us-ascii?Q?ghBcV/qldGzsahNNyFXJJjow1loZMdZK+iUJdwpTUMw+1d7coGDQHRTQ5BK/?=
 =?us-ascii?Q?CUbjr7MTvpHLvEZcfHwKgrpbLHZSq7rdNSrol25VPWj4o8l6ZSL/ACklf1m/?=
 =?us-ascii?Q?6MW0F1hP0siBojwmFzTdZrCf5smWqyX9FHMKnNBA6t3rN0hw3ZxumInu5xSk?=
 =?us-ascii?Q?+JbeKzw7h9CLK9TCAixKpEvomdgr4rRtZyAc6cBrVbbB57hp1Q7q4HFRd09G?=
 =?us-ascii?Q?w2ZMdHWH3zpgWgWOjCqFVmGCkC1XBW1qQSJgnnVKOHVGF8NmEJlUF5J183AP?=
 =?us-ascii?Q?KarTVluhbUr4NDu9JaCAoRceIj3G3YvGaRFAd4AgH9Pek1Xy7E+wYJZn+J8A?=
 =?us-ascii?Q?ZEPVELqez4BDVoJXW7+RbgwKnRzROAcX+LSjuJPqnzaVxfGy+/Q6I7EEBNoE?=
 =?us-ascii?Q?L2djpU7Uf6g0AVZu8Mof0Yc+3k6jzZI/7tKmh/tRbioSitg+IZK7LEoP5bbE?=
 =?us-ascii?Q?tWnREoHuDaOF5ULI7Lrk6WAl5cxodamB9abb9tKlDMrv4ScXtGMS+7VjdEue?=
 =?us-ascii?Q?j/0o7pqOkOlE9XftZvkyh5KvyBV+L7maOkkdgETuJt39RYhD5BkE3h+jpR39?=
 =?us-ascii?Q?vI68QNsr932VcpGuHhTAxJb75cmXnfdeTVOgReaauB68rPfsH9DZ4QqbfOZB?=
 =?us-ascii?Q?eWyhptHzUlVxFdaO9Miqvr8hpfhTa5A3U8fman6prkM8eyeEvSLgpkxyPsoJ?=
 =?us-ascii?Q?8/9KDiwwX6kDyc3nVWXmErxRRuFf4c44KW6f+1obbc/bX+YwiFzrIDTasgZC?=
 =?us-ascii?Q?YQL3rpX1EQigWgjlGtih2157WhEWMewOdFjE/oUfYrGW2meI+s+du4C4tLib?=
 =?us-ascii?Q?bDcJSp6Jq1XhtEcWV1bYST+FwaBBQVlpTv+XKpsDIxr0iEQHyvtu+IN9rOGU?=
 =?us-ascii?Q?ZKspi8cN1ku+2rCfYTcukmi5DcAtQ+4POf+XsRvKFod+GWo2ABwy0E9sVwNM?=
 =?us-ascii?Q?qGKKk9V4LLCZZvH7Bp77fOmv1zPH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:18.4526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b66d19b-9232-4a6e-34a8-08dce4042e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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

[WHAT & HOW]
TimeForFetchingMetaPTE, TimeForFetchingRowInVBlank and
LinesToRequestPrefetchPixelData are local variables. They
are freed when CalculatePrefetchSchedule() ends and need
not clearing explicitly.

This fixes 21 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c | 3 ---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 3 ---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c   | 3 ---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c    | 3 ---
 7 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 565f3c492477..0c8c4a080c50 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -785,12 +785,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBW = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 9d6675ecc5f1..c935903b68e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -845,12 +845,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBW = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index eb3ed965e48b..cd8cca651419 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -1049,12 +1049,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 4822fad6ce3a..cee1b351e105 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1280,12 +1280,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 2b275e680379..f567a9023682 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1444,12 +1444,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index debfa31583a6..5865e8fa2d8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1461,12 +1461,9 @@ static bool CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index d92fb428ee96..86ac7d59fd32 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4097,12 +4097,9 @@ bool dml32_CalculatePrefetchSchedule(
 
 	if (MyError) {
 		*PrefetchBandwidth = 0;
-		TimeForFetchingMetaPTE = 0;
-		TimeForFetchingRowInVBlank = 0;
 		*DestinationLinesToRequestVMInVBlank = 0;
 		*DestinationLinesToRequestRowInVBlank = 0;
 		*DestinationLinesForPrefetch = 0;
-		LinesToRequestPrefetchPixelData = 0;
 		*VRatioPrefetchY = 0;
 		*VRatioPrefetchC = 0;
 		*RequiredPrefetchPixDataBWLuma = 0;
-- 
2.45.2

