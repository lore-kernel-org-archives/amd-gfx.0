Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8ACC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C461610EE48;
	Wed, 26 Aug 2026 23:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4UrT/mx+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB91210EE48
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5s3KS3Qa4QLDVUz4T0fniBv+ys0IPsyxcNJRW++FIyNOkXOWJ8sR9r/Pc5/8XJRLV3OyoojdVs8EqSrUZCcoN3Pd6hCeMzviao/x9lRy5E9WZGT0VRfjuKRJT1TUvz6juJQmENqvVOcqOutrfYBDuVic7pVS2w88nJ4IyUWfNX6UORgDcGAe89oYS0nXjK36dnrVRglBwussbn1VL3FwuGbr76hvFXxByIaarwTd5tHkLotmsIRIkSrmBh9gnAXk09XygNwLcO0Wcp//ep2OGaXVnDAJKde2RTr+dsXzQZ0WM6bE+ZU72aN4Au5flJbDwnkzZt/yWl3jLgB1mPV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkbuEqiP4kLgs45BrAYfHllwnhRolcTYJF1lIK9WXec=;
 b=lZLbKTPoEdNb0WxihviXS0v+bBXasH7fd19ctIq8Ip288TZg0bhjfQggGWuRpTgZJFl8CTiBTMIdxSaDZ05xfiFYWNnbnQh+Jz/8YFLLIIbu6+kMXaetrNB99POzyv1TWIH8bfCXTPSC8+L7lXUE7M0TIPCbLiL+EdNHNOVNY3CYECZtecKKY1SgxAPkvkaaIgUwpF3BsgVQGYJqrftCjcYvPxBNeeonZDJSk9TqDhyyybcvSo4jb+44Kh0Cd+/KaK+XKsuSw68Myd6OZ20NdLK0aouEI6tfezHVMS6MsitctnweGrl8S2patj5hFHKqiHgyZypzzAlZrXrLKvN6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkbuEqiP4kLgs45BrAYfHllwnhRolcTYJF1lIK9WXec=;
 b=4UrT/mx+SeWE+kVfSbTs/O9Gxp4Y8RxQy/zYrJE9gS7urGqUwjmnlcz69Ii33FcOv6x2kzRkePnrnUJuPwATrJemKkt5ZObr1lOhKu5UhjXfUF2j3C/WOTuOEhtlrGe1NJvsV1DqBgHDJoUnTpI+msCfo0c6D4J/ciDKEBm/MB4=
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Wed, 26 Aug
 2026 23:23:53 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::1f) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:23:53 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:23:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 24/59] drm/amd/display: Remove internal references
Date: Wed, 26 Aug 2026 17:04:55 -0600
Message-ID: <20260826231519.881949-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 721d2d30-b41e-4302-e8d5-08df03c917e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: oZhXW+zY0bnO8kO24hBjG5PvclG1V6tXQJ6Chtnj5Sb/mvwi7x/qou1PR0vJIqL8/6/dGWOZjQzff/OUn+lnpVnPT8r380yRfJEM/HhYb+uoUJV/gIhp612JGotGfrhtdvw8kkQJWBh9uvTX+CBVU+z4waiRN6MmaDwBMONAVqqVo37qhHizYiWV8GoZNdR7j0//GGmBaua+j9T6UTL41q3lo1h4t8mksvmCwtHlnaEUOLerqfs6Y18njGTRkaDFikxiqlm6/KWUbRKp0kq8lLZVPxJ3ksQksbTuX/7QtwK/Als2zH3PbSEI63UYh35IiNerIm3TOiXuwH1MynvHRz1o8y0X+Mzdmakxhc/HOLHJ5bCQI+iQfsroQn9Er6bxpupaoShBf+XVKgBplFqGE++1HU1zGR2fm0IvbmGynr1az8xqR14YI37F16KRJ9xGT7YqaOKKbCBJuakpn6D0z3J0iZoX/hzxcDj/U53qlglZwG5Eg3/5RtX+WaalM6PnlmHBhnVYWbhgu1CP51cE/34Od9TmSRM7bPbJ1kD08qxFXRfhynpmNTd8tGn+8c236IlrLmzDxaM2X54JTgSuXWoLYFuata6Kh8cq+5ySnYu7TymS9MhlJZaoSNanx5Gl65S9NgDCmzvwoV5iOqIXp0xt7Rtr1GdTov6wliDu7BLyThFzcB63vHg/n7wRWoZHYTQCGN8TH5SdUiK9WJEJpA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: amBzyf1In6ND6+OAQS0ia+ljSu13rUV/NN0ii5YXKXgAN66965pVn74ooTgWSMxMPu/F4UnE/SzzluDgQLHjQ/o3nH6Y6h96I/GUHZltdyRiHdEhbC00s5h818Pjw0Sj0esWrGD7q9A8oGI90iMXKu8uUtFh6ZHYfHPZBtFSfCN2g/PewGINAiwuJDZug+G06JsQLj+159Kkx6fhcBUf3nAnqtVAbUhHaYnLQ9bk3xWqEFkazVb3yTpS+ERfcoMsZ4QmXGDyfINpnSpM1LHnmYwIRdBkFUPTXaI/GRzJw5XBHWiZ3xYPxQhx0u8VvfiLtGJ3O3Kc24uoYbPp3QNQcI6XwbzxjqUfEeUmO/fVAS22BkAhFmEqYkoJqmBLHp6qoiJ7veIV3diC+7M+tfHfsFSqL4JaD6jFrDz/W2w3MAKoerbiG2v9afTq7xMi0mMg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:23:53.2741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721d2d30-b41e-4302-e8d5-08df03c917e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

[WHY/HOW]
Rename function and updated comments to remove internal references.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c | 6 +++---
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h | 2 +-
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index 67828505939a..0dba8ff8a19d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -74,7 +74,7 @@
  * then update the regs with the new values.
  *
  */
-void apply_DEDCN21_142_wa_for_hostvm_deadline(
+void apply_hubp21_wa_for_hostvm_deadline(
 		struct hubp *hubp,
 		struct _vcs_dpi_display_dlg_regs_st *dlg_attr)
 {
@@ -131,7 +131,7 @@ void hubp21_program_deadline(
 {
 	hubp2_program_deadline(hubp, dlg_attr, ttu_attr);
 
-	apply_DEDCN21_142_wa_for_hostvm_deadline(hubp, dlg_attr);
+	apply_hubp21_wa_for_hostvm_deadline(hubp, dlg_attr);
 }
 
 void hubp21_program_requestor(
@@ -803,7 +803,7 @@ static bool hubp21_program_surface_flip_and_addr(
 
 static void hubp21_init(struct hubp *hubp)
 {
-	// DEDCN21-133: Inconsistent row starting line for flip between DPTE and Meta
+	// Inconsistent row starting line for flip between DPTE and Meta
 	// This is a chicken bit to enable the ECO fix.
 
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h
index 9873b6cbc5ba..418a981b8c9b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h
@@ -119,7 +119,7 @@ bool hubp21_construct(
 	const struct dcn_hubp2_shift *hubp_shift,
 	const struct dcn_hubp2_mask *hubp_mask);
 
-void apply_DEDCN21_142_wa_for_hostvm_deadline(
+void apply_hubp21_wa_for_hostvm_deadline(
 		struct hubp *hubp,
 		struct _vcs_dpi_display_dlg_regs_st *dlg_attr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 3e5ae0eae39f..4f5f10f6d1cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -615,7 +615,7 @@ void hubp3_setup(
 
 void hubp3_init(struct hubp *hubp)
 {
-	// DEDCN21-133: Inconsistent row starting line for flip between DPTE and Meta
+	// Inconsistent row starting line for flip between DPTE and Meta
 	// This is a chicken bit to enable the ECO fix.
 
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-- 
2.43.0

