Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71217CF3964
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2434810E762;
	Thu, 19 Sep 2024 18:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1a9ksvYa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9398110E762
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKcZ05VkZOxMM1+BAXQOKTol8wAFYXzT+k8UMqxTSXMUKWCLW3UrkEMUlxL6go4s5fkMYfonrRuiOBJ11XX2F2IxrFScb9wHJgarC3nITBPuoW5sp4+mQWTnqCOHWbTECd0XhmBgPekgYArej6sxSryesSotQqdQX6R9XR4kcocnzC2BsPXKKA+ytN0DDgLB215fvdonTqsxBMPBC4DLjEt6Z0Tr+uOnsp1ooKQctlov9auWC36L5VFs++AMJNiKO8KY5E8IRik5Ld14HE6KlnmQ/aBIIoZvDWtZAhPYleOedEDBH3BwTPkGl7sFpqw+lwwk3FfHRfO+4c+6PSkGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSX+RMgkS5pBE8CjwxdGVdfdUDfjxphaRmymYfqx+mw=;
 b=kzXshuOolMv98JLE+GTrrJ0OifMtg4ko5Gl7tNpgiwXvAcPiFO7cItCy3wd3LDRLKrcgwTWpTLsM032D9d3cBzyxaAMxoW8aoOa9Q1rY1G+2vYpWiluuvjgB4au+NvqodmF9ttbayiegqrXrQhnEu88Aj/fPTxsxkB/nf0EmKZSUVxnYHsPXAdMp+m9grKVyZQ5obwoZFhNXA8JMB0Lnuh1Yeyniilv2qC/eA9DSEwNWZ1deUDui00onFTsPvIwjz1yZDjZHGvr6QfaI1wj3shahVORWg96X25EmFGLTBgk9bl2UHKtE5Bpa8Apr5jPgX+vU00ArZrtvLMjAUTCWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSX+RMgkS5pBE8CjwxdGVdfdUDfjxphaRmymYfqx+mw=;
 b=1a9ksvYavcc7CTXAiXLlRwsFvX8QaQVFLel54Tacn7D5874oxGSDs0LUtkxQYp4GkVj0JOxSE7R44ImAw5IxAvcdESGQ9R4EAUjurLbrJTTM1AEW6S4AtIzVvEaBzNvd09Lq3qcyqTqCGnqOOn5/CI69L9I5bxesYW9a773acQQ=
Received: from MN0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:52c::16)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:35:01 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::1f) by MN0PR05CA0021.outlook.office365.com
 (2603:10b6:208:52c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:00 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:59 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 14/21] drm/amd/display: fix static analysis warnings
Date: Thu, 19 Sep 2024 14:33:32 -0400
Message-ID: <20240919183435.1896209-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e9f89b-5d9e-4494-fd20-08dcd8d9c59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRah7uEgKDwOgo5G6OkUtSEP9vZLLWuTw2Z4yxy28E/eLfnr74E5vf51heC5?=
 =?us-ascii?Q?8OD4emJdQFTv4y4Ah3slrQFkaixxIchaIPNTSHlQzYM7MFY0cA+jBQdRpIsZ?=
 =?us-ascii?Q?a/8q8vU9H805xg8caMJWkCuwa3SOPciEcaPb5DY2+xNfmMR68JCOHsTfsYEu?=
 =?us-ascii?Q?7hOBcp4b5bIZedyLTqeRpB+gn4KM0yge7/aDhjf8fVjCUR+z+Ct9UkAMvbmu?=
 =?us-ascii?Q?u8NTda0yINmH5PneWykPwBvjmEBZDsCi5ovgZO0zNvnQWU2kL4KacjV+E2hs?=
 =?us-ascii?Q?RgOT7X/Wa6hYpY1tBhUYxMuok/MZiFfLJslnsougweJnJ+0CmhWDf9z3Jm+K?=
 =?us-ascii?Q?9oMDjs/OczBLB+unOusrvglWAYFxfd67fjpsnMpgYVUKR+cQU8uIaGyISs3y?=
 =?us-ascii?Q?oM8GTFjBBz6doV7AMD28Lt0gNeEaWvD8dUSv/QiIzf265s91/1Dwke0cu5/9?=
 =?us-ascii?Q?CVqa8OTVIXX1WK0wdk1X/NK6U7dc5jENkYfkOFWtc9YDsHkzbJMuSPLY85ZI?=
 =?us-ascii?Q?l8bzahwHjNEUjIpQB8orKU4AFz+BuECZ9n/JXmX6zVT+SKEj0VeGUfDMcZ+v?=
 =?us-ascii?Q?dSzNs3M4fiwSDNF6qM/pkqZHvOJHs2J68cXvvkJgTd/2N6em6OVbrZzt5hxO?=
 =?us-ascii?Q?LKsALiG/WRyebbegEVAne/GaAJJrs7OKuYt/cr+knsARErfO/hR2oO86lmV3?=
 =?us-ascii?Q?9QArImFeZCCn2TtlW+x+ZCTTiOdx1arrA87dpTE46uy6+cGtMS95bs4VrX8C?=
 =?us-ascii?Q?1Z16th8GagmpgYkl1Jy1COHnCareSQalXZYLtx6qcpqhi3hRuBdjDUr4mBrC?=
 =?us-ascii?Q?s69+R+ttuxLOUtPZa3N77UBSLvRAiEtpFPFGW4goBIiMz2wl0XQraFA6T2Xk?=
 =?us-ascii?Q?YLrO6Qxy8ihYTmKMvc+Yg5BQxp8V2b9cKpYSIzN55Sz0N0xGt3ee94OdDS/M?=
 =?us-ascii?Q?xphVumUnfdG7BqnRM9+XZLH9Lc2ZpFOpoq0zVz1bHdvz6O4FfDtvHTLHtIBW?=
 =?us-ascii?Q?oBoy0PuBMD8xfGbTvtwfOtsPFMqWte9X6O777rCyZKS01kjgSM5CEVod2/1o?=
 =?us-ascii?Q?oOSTba0N6Pz68X+BWnvJMbEBBBl3wWVM4LgGt87h1i60tfkb3h6g/wTtG/gQ?=
 =?us-ascii?Q?w7JDWc6CGqT7rpV0yJijlhHIkREO5b7K5FWgyanHQn4EA0Ex0Yq7vFMjXCBk?=
 =?us-ascii?Q?AyEDLSVBJhwh1F3Bnx7FbTr91T2OFdLWJM4YRYq9zDxHU5XyWCmIJ8rWMIMC?=
 =?us-ascii?Q?cIMVcj19yPfgv6mCqIlt1EIqgx5dht5tzBg6c+AyMt7mBn1kQkOeGYHUyspF?=
 =?us-ascii?Q?SzBRxzD2+Dcjm6B9c7NNLLnDLLDoEkXskGVbixSjFj3HNJCfqWC61bc0ZZWY?=
 =?us-ascii?Q?kmUUPAVuCwo8GoVYupE/gwmmFiFb/ehNLlSzf0qr9H0zvY5grgH2xhhRDXfA?=
 =?us-ascii?Q?TFKmXi7kGeDpz8cTEe4JfVnLWNhewg05?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:01.4176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e9f89b-5d9e-4494-fd20-08dcd8d9c59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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
Fix static analysis warnings in SPL library

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  4 +--
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    | 33 +++++++++++--------
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   | 32 +++++++++---------
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   | 17 ++++------
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h |  3 +-
 5 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 2a74ff5fdfdb..48e4217555f8 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -5,10 +5,8 @@
 #ifndef __DC_SPL_TYPES_H__
 #define __DC_SPL_TYPES_H__
 
+#include "spl_debug.h"
 #include "spl_os_types.h"   // swap
-#ifndef SPL_ASSERT
-#define SPL_ASSERT(_bool) ((void *)0)
-#endif
 #include "spl_fixpt31_32.h"	// fixed31_32 and related functions
 #include "spl_custom_float.h" // custom float and related functions
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h b/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
index 5696dafd0894..a6f6132df241 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
@@ -5,21 +5,26 @@
 #ifndef SPL_DEBUG_H
 #define SPL_DEBUG_H
 
-#ifdef SPL_ASSERT
-#undef SPL_ASSERT
-#endif
-#define SPL_ASSERT(b)
+#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#define SPL_ASSERT_CRITICAL(expr) do {	\
+	if (WARN_ON(!(expr))) { \
+		kgdb_breakpoint(); \
+	} \
+} while (0)
+#else
+#define SPL_ASSERT_CRITICAL(expr) do {	\
+	if (WARN_ON(!(expr))) { \
+		; \
+	} \
+} while (0)
+#endif /* CONFIG_HAVE_KGDB || CONFIG_KGDB */
 
-#define SPL_ASSERT_CRITICAL(expr)  do {if (expr)/* Do nothing */; } while (0)
+#if defined(CONFIG_DEBUG_KERNEL_DC)
+#define SPL_ASSERT(expr) SPL_ASSERT_CRITICAL(expr)
+#else
+#define SPL_ASSERT(expr) WARN_ON(!(expr))
+#endif /* CONFIG_DEBUG_KERNEL_DC */
 
-#ifdef SPL_DALMSG
-#undef SPL_DALMSG
-#endif
-#define SPL_DALMSG(b)
-
-#ifdef SPL_DAL_ASSERT_MSG
-#undef SPL_DAL_ASSERT_MSG
-#endif
-#define SPL_DAL_ASSERT_MSG(b, m)
+#define SPL_BREAK_TO_DEBUGGER() SPL_ASSERT(0)
 
 #endif  // SPL_DEBUG_H
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
index a95565df5487..5fd79d9c67e2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
@@ -29,7 +29,7 @@ static inline unsigned long long complete_integer_division_u64(
 {
 	unsigned long long result;
 
-	ASSERT(divisor);
+	SPL_ASSERT(divisor);
 
 	result = spl_div64_u64_rem(dividend, divisor, remainder);
 
@@ -63,7 +63,7 @@ struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long den
 	unsigned long long res_value = complete_integer_division_u64(
 		arg1_value, arg2_value, &remainder);
 
-	ASSERT(res_value <= LONG_MAX);
+	SPL_ASSERT(res_value <= (unsigned long long)LONG_MAX);
 
 	/* determine fractional part */
 	{
@@ -85,7 +85,7 @@ struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long den
 	{
 		unsigned long long summand = (remainder << 1) >= arg2_value;
 
-		ASSERT(res_value <= LLONG_MAX - summand);
+		SPL_ASSERT(res_value <= (unsigned long long)LLONG_MAX - summand);
 
 		res_value += summand;
 	}
@@ -118,19 +118,19 @@ struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed
 
 	res.value = arg1_int * arg2_int;
 
-	ASSERT(res.value <= (long long)LONG_MAX);
+	SPL_ASSERT(res.value <= (long long)LONG_MAX);
 
 	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
 
 	tmp = arg1_int * arg2_fra;
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
 	tmp = arg2_int * arg1_fra;
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
@@ -139,7 +139,7 @@ struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed
 	tmp = (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
 		(tmp >= (unsigned long long)spl_fixpt_half.value);
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
@@ -163,17 +163,17 @@ struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg)
 
 	res.value = arg_int * arg_int;
 
-	ASSERT(res.value <= (long long)LONG_MAX);
+	SPL_ASSERT(res.value <= (long long)LONG_MAX);
 
 	res.value <<= FIXED31_32_BITS_PER_FRACTIONAL_PART;
 
 	tmp = arg_int * arg_fra;
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
@@ -182,7 +182,7 @@ struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg)
 	tmp = (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
 		(tmp >= (unsigned long long)spl_fixpt_half.value);
 
-	ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
+	SPL_ASSERT(tmp <= (unsigned long long)(LLONG_MAX - res.value));
 
 	res.value += tmp;
 
@@ -196,7 +196,7 @@ struct spl_fixed31_32 spl_fixpt_recip(struct spl_fixed31_32 arg)
 	 * Good idea to use Newton's method
 	 */
 
-	ASSERT(arg.value);
+	SPL_ASSERT(arg.value);
 
 	return spl_fixpt_from_fraction(
 		spl_fixpt_one.value,
@@ -295,7 +295,7 @@ static struct spl_fixed31_32 fixed31_32_exp_from_taylor_series(struct spl_fixed3
 		n + 1);
 	/* TODO find correct res */
 
-	ASSERT(spl_fixpt_lt(arg, spl_fixpt_one));
+	SPL_ASSERT(spl_fixpt_lt(arg, spl_fixpt_one));
 
 	do
 		res = spl_fixpt_add(
@@ -337,9 +337,9 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 				spl_fixpt_ln2,
 				m));
 
-		ASSERT(m != 0);
+		SPL_ASSERT(m != 0);
 
-		ASSERT(spl_fixpt_lt(
+		SPL_ASSERT(spl_fixpt_lt(
 			spl_fixpt_abs(r),
 			spl_fixpt_one));
 
@@ -364,7 +364,7 @@ struct spl_fixed31_32 spl_fixpt_log(struct spl_fixed31_32 arg)
 
 	struct spl_fixed31_32 error;
 
-	ASSERT(arg.value > 0);
+	SPL_ASSERT(arg.value > 0);
 	/* TODO if arg is negative, return NaN */
 	/* TODO if arg is zero, return -INF */
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
index 8a045e2f8699..ed2647f9a099 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
@@ -5,11 +5,8 @@
 #ifndef __SPL_FIXED31_32_H__
 #define __SPL_FIXED31_32_H__
 
-#include "os_types.h"
+#include "spl_debug.h"
 #include "spl_os_types.h"   // swap
-#ifndef ASSERT
-#define ASSERT(_bool) ((void *)0)
-#endif
 
 #ifndef LLONG_MAX
 #define LLONG_MAX 9223372036854775807ll
@@ -194,7 +191,7 @@ static inline struct spl_fixed31_32 spl_fixpt_clamp(
  */
 static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned char shift)
 {
-	ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
+	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
 		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
 
 	arg.value = arg.value << shift;
@@ -231,7 +228,7 @@ static inline struct spl_fixed31_32 spl_fixpt_add(struct spl_fixed31_32 arg1, st
 {
 	struct spl_fixed31_32 res;
 
-	ASSERT(((arg1.value >= 0) && (LLONG_MAX - arg1.value >= arg2.value)) ||
+	SPL_ASSERT(((arg1.value >= 0) && (LLONG_MAX - arg1.value >= arg2.value)) ||
 		((arg1.value < 0) && (LLONG_MIN - arg1.value <= arg2.value)));
 
 	res.value = arg1.value + arg2.value;
@@ -256,7 +253,7 @@ static inline struct spl_fixed31_32 spl_fixpt_sub(struct spl_fixed31_32 arg1, st
 {
 	struct spl_fixed31_32 res;
 
-	ASSERT(((arg2.value >= 0) && (LLONG_MIN + arg2.value <= arg1.value)) ||
+	SPL_ASSERT(((arg2.value >= 0) && (LLONG_MIN + arg2.value <= arg1.value)) ||
 		((arg2.value < 0) && (LLONG_MAX + arg2.value >= arg1.value)));
 
 	res.value = arg1.value - arg2.value;
@@ -448,7 +445,7 @@ static inline int spl_fixpt_round(struct spl_fixed31_32 arg)
 
 	const long long summand = spl_fixpt_half.value;
 
-	ASSERT(LLONG_MAX - (long long)arg_value >= summand);
+	SPL_ASSERT(LLONG_MAX - (long long)arg_value >= summand);
 
 	arg_value += summand;
 
@@ -469,7 +466,7 @@ static inline int spl_fixpt_ceil(struct spl_fixed31_32 arg)
 	const long long summand = spl_fixpt_one.value -
 		spl_fixpt_epsilon.value;
 
-	ASSERT(LLONG_MAX - (long long)arg_value >= summand);
+	SPL_ASSERT(LLONG_MAX - (long long)arg_value >= summand);
 
 	arg_value += summand;
 
@@ -504,7 +501,7 @@ static inline struct spl_fixed31_32 spl_fixpt_truncate(struct spl_fixed31_32 arg
 	bool negative = arg.value < 0;
 
 	if (frac_bits >= FIXED31_32_BITS_PER_FRACTIONAL_PART) {
-		ASSERT(frac_bits == FIXED31_32_BITS_PER_FRACTIONAL_PART);
+		SPL_ASSERT(frac_bits == FIXED31_32_BITS_PER_FRACTIONAL_PART);
 		return arg;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
index 709706ed4f2c..2e6ba71960ac 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h
@@ -6,6 +6,8 @@
 #ifndef _SPL_OS_TYPES_H_
 #define _SPL_OS_TYPES_H_
 
+#include "spl_debug.h"
+
 #include <linux/slab.h>
 #include <linux/kgdb.h>
 #include <linux/kref.h>
@@ -18,7 +20,6 @@
  * general debug capabilities
  *
  */
-#define SPL_BREAK_TO_DEBUGGER() ASSERT(0)
 
 static inline uint64_t spl_div_u64_rem(uint64_t dividend, uint32_t divisor, uint32_t *remainder)
 {
-- 
2.46.0

