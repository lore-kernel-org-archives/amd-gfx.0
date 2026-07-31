Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77572C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB4810F435;
	Fri, 31 Jul 2026 21:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzZZEjbJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF2F10F40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQCrZuR9lA6o1Z0E5aE23hutLleTpC90QtwroME4JZmomyKe4p4X4hrPOiLOaysnV8aCBRGND+4UgU9My+AKleaEIE6D/vzRxULRcw9dtyCNB9/Vls+qChgnPEij8f+2qB/JtxsorT83/GJR5mitm+gw5peo7miSLMkGhJGx/DA9S8Yoz1l2WfY0bhZifc6rr2XXN6S/9i5rUNFT4rODpzwMolwWsmA7VZA8zwo/4rnGW6JDZmbnfAxXx32KGnnWjLA5RzsTAWkchUxMZBU2Rc3ootpn3Pft0x90yL4z2FeoOPAy9owic4Rb+e96fVM4IgWv63tYsWMLTNDGoqVJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfkEh4NqPJ/0jK2kU4oFPr+QYlWBYMR2uaiv6hQLeYo=;
 b=UanXSrK29pcbwuMu3dRBVbaN4CYstpIspqMAavCUas85DUMiTNerM3roE5ay37PoWjob5g3Uq4I4asAyVPt+GZwyCVlZJ8T7ua1PuIdiKl3Ah0Z4Oqyozur/C/ajm1kBzHJ//Z4Uygixi7ypqqhVfrtwGEvqQiUXz5AjHFY2wM/F5l2kC+xVR9+rqp4w7htDsPsxe/dv0R6KGyxCNHu2F4bQsmZ+75JlMdISQPGoEt5V6pgdm8Jz0/ouEX0y+dxCXXR1Bove1IJigNQ3Cl2d2EbeYFkMz87HXIJRLkwfjLLcPSk9X4tR1Jf8KtIvvR/d4Wnl91i1Lv4QGRC0wcBUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfkEh4NqPJ/0jK2kU4oFPr+QYlWBYMR2uaiv6hQLeYo=;
 b=CzZZEjbJj+2k04Av2lTvqgLeBgdP0aVwOev6QXzLCtHoDu2uipFO+yLf/YzWceFEkt3TPPUv2CO7jcms/luGJlLBE5Q9wVaxaWL5JvjsHJrxWyzVy9juVgGNZS7B4DralFpWG5lbtOsn1cj6Z3XW64tOn00t3VTlAIbOaSOMfbA=
Received: from BN9PR03CA0930.namprd03.prod.outlook.com (2603:10b6:408:107::35)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:23 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::35) by BN9PR03CA0930.outlook.office365.com
 (2603:10b6:408:107::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 21:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:22 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:21 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 39/41] drm/amd/display: Add FFE level defaults
Date: Fri, 31 Jul 2026 17:13:00 -0400
Message-ID: <20260731211302.3040343-40-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: c29b81da-993c-47d4-8912-08deef48f8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oRE/RVDBonm0DRYRMn6AGlHQ4+P/EsMxdAHJyne8qvJvPPQOyD8ZiEDYeGyeRThJDAdnrzIx3bVGGLJhG1IbkwhVFLZaN+nEcLIroojeZcDwlHiOJxnfwkLj2iK6YWOChLIu44J0MkFhrYkG1OpfpzGOE6J7gTkBa1O3UOjNLX3Qo48Q2SNAtEmBnxD4MSBYfD6DAvwQXlDrIi8ZNnIectnXhf8mvP2dHRzlh9C40utiXnvNWuNA6+3HwajogS8Yuc3k/L5C6/bPsqPhLY+l9TVtx+Wt7Laf5R/w0udeL+bG76PUCE6V7N6OPMc16whtsADaYEOTJGdxCUG5qt+Fh0y//0grxia/5Gkgij5kl6a7Bk2LTb7r4s/zYWBlR5QALxM6sBKR3f9cd6saO5UYfCdZrfjSwM/n389ijdXa6CeFhwPt7B6fo+LZkxeJloBZDSlsBfVxRGYan4dlJVYKNuXqyLTJa44RA0GBN+h5tMimN9SvSiSjAGsU5X4i1rv+5ysUKq2i9/x3DugepiF8PG5kLeLnREn7vRFr4BK4I+TQfHyUJjgwVtwiF5Lrc1YCyAiqdp+J4CtJpYNwtl5T4aineq6GML5mbICBaO+gM3nsRHfHNo194OcLLFJa9mQY9Evhoun1kslOFePJtZYr/RvkAV7JBpiJvAr/5NLXELOz4HkzCOfr3X3RR2Oo4SG5pOrDWJnbbw25HnuumzwMwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L7puDbJIzpr5knmHu2o52X1MN+lLXvG78lmSmVOmgTYbTgBYoYlvtQNhM3qBdTdh4m2mJSRhSydeF2hGf/nzPz+qmGF5jZ92mEH+rp2O+fArCz4bO9/buSI4umyq7lhkCkgK1hCWE5qXuC0GzwA13Egt/DV17kpHqUsIWqkOaPtTH0DdqR6zhbjI+zWVHYtxHxgOe8A35/ikfToS/VGkTdTetNR0aiutR74k0gIbPtVnjZ+cXRorF5TLZkQnrBwa1ZZOIf5kgJYw39Mqqka00Qkcy3amMmVvk8OIFWspR2xtpAYHNuD91jXOOcw5oGn6OaQMs53qhD+IzH8B4hS26mMYKi4/lBpl9UyxDvmb0ZKeA0JK4yk20QBrqg6AqvJlKeiRsj4B7oQSYHUiixWq5o1KqZHH3u9t7I8ZV1jSYWrwLD9WhCMvc/QMLGcCgBY+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:22.5282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29b81da-993c-47d4-8912-08deef48f8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[How & Why]
Follow-up change to set defaults for HDMI FRL training

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c   | 1 +
 16 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index f09bbb932150..dbb8bb7fc20d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -753,6 +753,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true, //No DMCU on DCN30
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index d6b036e3933e..88dcf8166378 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -84,6 +84,7 @@
 #define DC_LOGGER_INIT(logger)
 
 static const struct dc_debug_options debug_defaults_drv = {
+		.limit_ffe = 3,
 		.disable_dmcu = true,
 		.force_abm_enable = false,
 		.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index c8598ba23dd0..50b7c7b85fac 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -84,6 +84,7 @@
 
 
 static const struct dc_debug_options debug_defaults_drv = {
+		.limit_ffe = 3,
 		.disable_dmcu = true,
 		.force_abm_enable = false,
 		.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 8bb2b8b29cbf..db56e30cf259 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -915,6 +915,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 5f08fb136b14..63f92e9da6d8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -928,6 +928,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
 	.minimum_z8_residency_time = 2100,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 470f3bd37314..15c1615c5f45 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -914,6 +914,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_z10 = true, /*hw not support it*/
 	.disable_dmcu = true,
 	.force_abm_enable = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index d81d241901b4..a5ea35e45791 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -909,6 +909,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_z10 = true, /*hw not support it*/
 	.disable_dmcu = true,
 	.force_abm_enable = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index a20ff9f0c3f8..7c2a79015f4e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -745,6 +745,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 105fba8ff171..5ee9a5a8ec3c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -735,6 +735,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index a92e0dc5ad6a..52826e96c184 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -761,6 +761,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 68a2169da0c1..e3fc71307c91 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -741,6 +741,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index ba04e8b9b569..c019a657005d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -748,6 +748,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index fff84f9ce816..aced8ff657bf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -748,6 +748,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 7507994f12d8..6296330e2450 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -727,6 +727,7 @@ static const struct dc_plane_cap plane_cap = {
 	.min_height = 64};
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 7b14d67314d5..41f0c67f57ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -785,6 +785,7 @@ static const struct dc_plane_cap plane_cap = {
 	.min_height = 64};
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 3,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 9dc6e4192943..b441d6d2d36b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -615,6 +615,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
+	.limit_ffe = 7,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.clock_trace = true,
-- 
2.34.1

