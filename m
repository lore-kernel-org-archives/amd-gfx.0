Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB3CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EFA10ECDB;
	Wed,  6 May 2026 07:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ve2F8fNG";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B237210ECDB
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJX+00+9ZSRtLg8954/dMNUC8nNImcKJplU2KQDEhHHQ05QMYtk+K/pXsfi2QfwE7lu/2FxqAAE9YQ2A/yooOryAtzpDhQFH6oS1z3mig/5TEtf9kixMROR3osLAn9U1v+ZFJXsWcY9SZ0LnIKMFgiZq8F32E5XvRAjf1aAhysIBkfdSWv8DjJ77sOAZVickdVV3qET4gecn4CEHuS5VfaAqe9NLjJb6N7SwqzNEX6eyaNMfY5MzI8zTf+cLFF1RP2jFx1XcOFjNHRqfz12iKCKll5lmJjTgVAGp9U9+KrTRw3JX/q4hcsffSvM5DOa7CfZZmohTSMTU08mA5v1aCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TwB61rX3UIRl8No6ZlPPRpH+brmxQnj2qYDrDDzvaU=;
 b=VqCs4Gc1Uy1OjRkuoCypucD9ydbQ1HYzzrUwo/9FEC+KzfcAztctL4IdQIi2N8QjDUUnP2eHoxv4+GfmrAcCjY5FgutVzlbnmvqaLgzRQUJqG8u8FZBYwVp65+vmmB2CpvCuU1oCkbs2eXcNdeWCOlc2r5+GjNz6qCwRuCNECq1bhQNI+LbhXaUd9epQjWXO1nrM8CD2R2seECEzWUaO3rnC421MfrrBQHCJmmk7ITdMJ7VVf9jyjwt07YDO0SAz84nPcW89CO2g7Tk6OG+4snAN9U9XK9FzuMHfvJ/Qj/73SP+LyDnIKmsu7AW65FUpDzMXaW93ZRGZ8wghyN84JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TwB61rX3UIRl8No6ZlPPRpH+brmxQnj2qYDrDDzvaU=;
 b=Ve2F8fNG9U6dr/0XIdF88DxpjkAlvOckPR/zn9zal1BMY6eoFu+1YmeUT5jHtWb2fHYn4DRPYNNCCL/2QaeP3mm452kfO1wuyf13ag7Fdhb1yL1ohfWtdKxY8HIylVf8PkmnwozRlk+ZdqEqnhK1k8FRsyfgIYrkaZ3u1JqHDP0=
Received: from MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::9)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 07:03:46 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::3d) by MN0P223CA0015.outlook.office365.com
 (2603:10b6:208:52b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:44 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:03:36 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 05/20] drm/amd/display: Fix compiler warnings in dml2
Date: Wed, 6 May 2026 12:31:03 +0800
Message-ID: <20260506043342.2164710-6-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf02696-8bdb-4d99-50e7-08deab3d9db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: J612enfTrcJnoi7upfKks35sJzxpkj2CotpErBn4afTMgzaQQ4j04UvfHuv4wXQns+IGr0JG094TK8dap+HjSGfJgMX4wuhAb5jpDLVQK54266Y73WJjeOG1SQ4qOguYOKaKYDKzTQLq3jNmuctjmIxErYXLLCo7PfB3xxdopuEYIwlamqusxzyjFXkEjq+gbcWofyQcsC/9k7cGZOg/okUFE8EVKsOTONEmnxYjShm+h1Lp1mariQ/hEEDoLfqxyBVdsR8l8ztkE/HRkwQu0fFskV6MvH1fZJ/fXRgxENRmIFBAkVmhiSxtcHGiIpDqXkhzJtS+UXO3eniaNgEe9nPmFoHQH4UxLyQiJD0MCMnompLlMZVmsmAWAPa9mP693DFsesYDEamqjxHKGFnhNMnZIte5kyaJvrGA6bxV4jOflgSOI3817UzHgFfT05YGNKQQvo/TCafpKwrPFFnUCpMydToL7W4bhvOyeSojDCEwnbKJ/HYhbbBNEVhu9RLGasuvQNPAzLb3xu7KNOefasAtXLYQxMsT41ulSepk3MY1MXCu+mZJNo9vu6luB3MNZGjjmPqU4GxbCu0Fzs3Px31CJa7dTVI3iDPvZIxMcO/rvyrz1jbPhphth0P+mJ0Dyc1bVaso5w0vRoYMKG/ulXpPcKuJEO0ugPzqo2bKNjMdToqX6i5rhKGHDkEadGJJCk/Un2j2JhS4BD6+OPJ7sRUUKDFGNFudHLWGeMJjnaA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fxK7eZ1B2PJZVxDlvgJWovlaDnfa0zdX2fPaC33vpTb5X85FKl008r2up9bUqcMeqwSTA6wMANwiFB9uBBTsH11lkp3edZ9ag/nq8XSHkkUZwvQhyTkZldnuAOWEtF8LPqR/yMCAt4qPrBxbdYxIwCcwPv2jehGctRsCjm9375gT9/ZakC7jwyVkL++2kohoFbYfEzavjv6O0LkcdmnsH5hzquDfC3zKnkUxvhxk6Tz3dNqqRX3owflX7R0pqWkA4we94pF96tH4UlkmU2tFY9o+0tDRlkUrbtmgVmr2J0CWNMYLuaCYhQhbhHXv8hqT7igejgKV1ObIXgiIfa+mQTy9EbfjiyGZxyxra+7UiL7R5h3X0bC7ZUIJkaYW4MvJY6gUpND2GIrFbNTmgWgeERIZW0GTDKQgpEE0AZ5sVuKKBLwUd60Buvf2S6q7PK+I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:45.9888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf02696-8bdb-4d99-50e7-08deab3d9db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why & How]
In dml2_translation_helper.c, rename the inner loop index inside
dml2_init_soc_states() for several project cases
to avoid shadowing the outer function-scope index variable.

In display_mode_core.c, replace shift-based power-of-two expressions
used to compute dpte_row_height and dpte_row_height_linear with an
equivalent floating-point power function, consistent with existing
usage elsewhere in the file.

Behavior for valid inputs is preserved in both cases.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index 16514f1e4ed9..241406e9e85a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -2626,18 +2626,18 @@ static dml_uint_t CalculateVMAndRowBytes(
 	*PixelPTEBytesPerRow_one_row_per_frame = (dml_uint_t)((dml_float_t) *dpte_row_width_ub_one_row_per_frame / (dml_float_t) *PixelPTEReqWidth * *PTERequestSize);
 
 	if (SurfaceTiling == dml_sw_linear) {
-		*dpte_row_height = (dml_uint_t)(dml_min(128, 1 << (dml_uint_t) dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1)));
+		*dpte_row_height = (dml_uint_t)(dml_min(128, (dml_uint_t)dml_pow(2.0, (int)dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1))));
 		dml_print("DML::%s: dpte_row_height term 1 = %u\n", __func__, PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch);
 		dml_print("DML::%s: dpte_row_height term 2 = %f\n", __func__, dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch));
 		dml_print("DML::%s: dpte_row_height term 3 = %f\n", __func__, dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1));
-		dml_print("DML::%s: dpte_row_height term 4 = %u\n", __func__, 1 << (dml_uint_t) dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1));
+		dml_print("DML::%s: dpte_row_height term 4 = %u\n", __func__, (dml_uint_t)dml_pow(2.0, (int)dml_floor(dml_log2(PTEBufferSizeInRequests * *PixelPTEReqWidth / Pitch), 1)));
 		dml_print("DML::%s: dpte_row_height = %u\n", __func__, *dpte_row_height);
 
 		*dpte_row_width_ub = (dml_uint_t)(dml_ceil(((dml_float_t) Pitch * (dml_float_t) *dpte_row_height - 1), (dml_float_t) *PixelPTEReqWidth) + *PixelPTEReqWidth);
 		*PixelPTEBytesPerRow = (dml_uint_t)((dml_float_t) *dpte_row_width_ub / (dml_float_t) *PixelPTEReqWidth * *PTERequestSize);
 
 		// VBA_DELTA, VBA doesn't have programming value for pte row height linear.
-		*dpte_row_height_linear = 1 << (dml_uint_t) dml_floor(dml_log2(PTEBufferSizeInRequests * PixelPTEReqWidth_linear / Pitch), 1);
+		*dpte_row_height_linear = (dml_uint_t)dml_pow(2.0, (int)dml_floor(dml_log2(PTEBufferSizeInRequests * PixelPTEReqWidth_linear / Pitch), 1));
 		if (*dpte_row_height_linear > 128)
 			*dpte_row_height_linear = 128;
 
-- 
2.43.0

