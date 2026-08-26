Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E191C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A51310EE38;
	Wed, 26 Aug 2026 23:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kRJlFdoS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D25610EE38
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oms0VBmqJJIcpWOOG3TQAp6u0aH5DHKa8dr+GNrc3bXGF+Eo+gtIl4CJyf8FGUk2IGKOu7cnaH68x0qzoWFVXq02iNV8tChg5bf/jZnXK6avXrv5BB2JwtqcRqxW6ZsntAnjJ3uNJrzgpqPhi1Ri/JWWSIbsjvLqRZgjBF+qGiNA2HN7lWugkVjnqI5nBBge8m3EL2fOgt3qFsUb9IEDys2Yecrhi8c/z24eVA8xJbDSWRp83HzdasvH7gYMCjjXe2ECS/ae0mMywRp2d69L9ENKS47Y764JOR2w6ZCJQijmNUh3ClsLWduBwWNC98ayLNteWhpZk7nG6R3yvqub5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPwEx4GvsCDDQXOyzWkXL9LgHteJTy+AHb1tI48BlR4=;
 b=MClQdZ55oBpQBsJmNB9Ew/QHQd331MUZZxIwtI7eaCvlS+EUxmaW2utMzw+r9OHxH3H9R+YHidNfzwpUfCT2nI5A4t1zKMsgUdGTA2EpOVj4xYO2bv2i7YMQz4R0h7xxzvV6xRe1/D5a5N3pTtywzqR0nSudTNVWTGBI+UH9r+sV9J+GII/EhfgCabgxe6xoCdObsYK7scddr0c/sV21SnYqm95dBT+w6NV5oxMuFGWoXMBLxFioLb28bpFIIlGlaWkFrM78bGZhjg7SBP1ndT6xpEGKypSHfAd3DEaje2vcpUb0VeS3rQWzRDClDWS/q6Qz3PVQQMEVs5lSbtrejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPwEx4GvsCDDQXOyzWkXL9LgHteJTy+AHb1tI48BlR4=;
 b=kRJlFdoSHNECXjR6W727Bb58v9tIBwJlKNVdw5Q3O0nRcV3BpEUTPKfiSwTjWTIKV9IPxEjgWbNItiPCRE2IuBiMj1mA/42BpjF411bzz8AU98hBZPe3G28gTGBt2anJIh3M+TNw2/XCeYac9ajllpJynCKzynVUsyKm6u8wnNQ=
Received: from DS1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::7) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:19:42 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::66) by DS1P221CA0008.outlook.office365.com
 (2603:10b6:8:451::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.9 via Frontend Transport; Wed, 26
 Aug 2026 23:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:19:41 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:19:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Taimur Hassan
 <syed.hassan@amd.com>
Subject: [PATCH 11/59] drm/amd/display: Fix DPP PRE_GAM register offset on
 DCN60
Date: Wed, 26 Aug 2026 17:04:42 -0600
Message-ID: <20260826231519.881949-12-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: a042dca6-0de5-4227-5f06-08df03c881b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Apjwzqt5sTil7YKJ5s2c140cU9O9diZQS2lg+h27yv2E8hesiZO1fKSDALDl3gIPtElxOtn90m6AnApKrPJ6CL/WfbAYRBiq4sQSWXANyqNYfUWvYa6XVvxR/WenZWI8sSDj4s3Qzb/86S2WJo30DL7iI4BEWgVQRsRWsbKUMY5HPHBWllNrDdhDKNYjopG6Mn7erPyBfqI1cHr58gQODIsFF48vUiWkLwVDlqKYK3qsBJsA61mZQuGEo3TIgwvo2z3yeyIM9qtT/tVSe8G4N6aP1BNW0S1RfgVExeIcroNHUaYdWlZ2zVi5TBCVgQmr9n/QmYEs7iICYaDc/uz6DSqMqWebfvBdhCXLDoJvlJ3OCnS0Nrlx7hDp405Zmf3wBAvEfCh0v55AH3OxxO/5OvxwFOwAb1411EPTOXDMr7gITGhAHz7hScxRG6Rr8wZ26ri2XCTqEUK5iG+nG1duelb7Gjb/0f1yiRTnq75yV3TRBE6Oh5QHo3s7GN9ONBn+aFtB738/aoxS0y9qvH4pfgvJO8QgdbPMsxjdvGiBYLE4PO5DzXXNAmPuRJ3+3Cqgxztjd69MYpEZgEGkV5I7sHtt0kIetBdjngzcU01vSi1xa20FyQ+5j+rAWXUNFuUOzUMBaz+D3evYhs6xDs6Dlcflvx6LRwpg2TRAp1xvVpv2b82i1vk9FYiO4PTzLuS2JMXB1bvh+L8oZYZFwrn0vg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHocwPQpCTrqIZ6QEkYNxvGmy2Q9LOV8d8g1aYtoyJ/SXPXrvegrl7WtGEc7sOocIx7WV5njKZK/QbzEyYQ9sAT0hmpF9ab0BYF6XnI/NHJ/L7tgchtvqzOZcVRWyaqET5+WsEuMqDT95fhfAFzY/q8DNM4wKxzPJZuCerCEL8BRISHaBvk6tLyGTGNmVILD60XX8Dmy4SJ4JPFxssA/sdcp+4p8/p4hv40WMqNMC+qpXRaup+JFhe+gDegMapBpF5by18jrvaua97br4UWQ2mVmA+LPwy8h9sGnajG4WIozMsir23JsUQqi8aT8fG29rkp1BxrRTfBgVYb9L9gqULXwkMwKElkyjwF6aqSjJ1GVHGv5nV3CkXGDtxkhq1JyeEkOk87/V6Mcq0Syy6rWmAIQHDU7z9zEr39lsCJpVMIOQdYJ+6YQtrU+VjG6/his
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:19:41.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a042dca6-0de5-4227-5f06-08df03c881b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHY]
dcn60 uses dpp50_set_pregam_state, which reads PRE_GAM through the
dcn50_dpp_registers layout. PRE_GAM sat at a different offset in
dcn50 (based on DCN401) vs dcn60 (based on DCN42), so the cast
landed on the wrong register which causes the wrong address to be
used

[HOW]
Rebase the DPP macro inheritance so PRE_GAM shares a common offset:
DCN50 lists now inherit from DCN42, and DCN60 lists inherit from
DCN50. The dcn60 struct layout is unchanged, so PRE_GAM aligns
between the two and dpp50_set_pregam_state programs the correct
address.

Reviewed-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h | 11 ++++++-----
 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h |  7 ++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
index efa76579dc9b..7f5d3fa6bbef 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
@@ -11,28 +11,29 @@
 #include "dcn30/dcn30_dpp.h"
 #include "dcn32/dcn32_dpp.h"
 #include "dcn401/dcn401_dpp.h"
+#include "dcn42/dcn42_dpp.h"
 
 
 #define TO_DCN50_DPP(dpp)\
 	container_of(dpp, struct dcn50_dpp, base)
 
 #define DPP_REG_LIST_SH_MASK_DCN50_COMMON(mask_sh)\
-	DPP_REG_LIST_SH_MASK_DCN401_COMMON(mask_sh), \
+	DPP_REG_LIST_SH_MASK_DCN42_COMMON(mask_sh), \
 	TF_SF(CNVC_CFG0_PRE_GAM, PRE_GAM_MODE, mask_sh), \
 	TF_SF(CNVC_CFG0_PRE_GAM, PRE_DEGAM_SELECT, mask_sh), \
 	TF_SF(CNVC_CFG0_PRE_GAM, PRE_REGAM_SELECT, mask_sh)
 
 #define DPP_REG_FIELD_LIST_DCN50(type) \
-	DPP_REG_FIELD_LIST_DCN401(type); \
+	DPP_REG_FIELD_LIST_DCN42(type); \
 	type PRE_GAM_MODE; \
 	type PRE_REGAM_SELECT
 
 #define DPP_REG_VARIABLE_LIST_DCN50 \
-	DPP_REG_VARIABLE_LIST_DCN401; \
-	uint32_t PRE_GAM;
+	DPP_REG_VARIABLE_LIST_DCN42; \
+	uint32_t PRE_GAM
 
 struct dcn50_dpp_registers {
-	DPP_REG_VARIABLE_LIST_DCN50
+	DPP_REG_VARIABLE_LIST_DCN50;
 };
 
 struct dcn50_dpp_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
index 96ff26a5ed65..a0cc57e79ff7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
@@ -414,9 +414,7 @@
 	TF_SF(CNVC_CFG0_CNVC_UPSP_CLAMP, UPSP_CLAMP_MIN, mask_sh)
 
 #define DPP_REG_FIELD_LIST_DCN60(type) \
-	DPP_REG_FIELD_LIST_DCN42(type); \
-	type PRE_GAM_MODE; \
-	type PRE_REGAM_SELECT; \
+	DPP_REG_FIELD_LIST_DCN50(type); \
 	type AUTOCAL_FRAC_MODE; \
 	type SCL_BLACK_COLOR_RGB_Y; \
 	type SCL_BLACK_COLOR_CBCR; \
@@ -448,8 +446,7 @@
 	type UPSP_CLAMP_MIN
 
 #define DPP_REG_VARIABLE_LIST_DCN60 \
-	DPP_REG_VARIABLE_LIST_DCN42; \
-	uint32_t PRE_GAM; \
+	DPP_REG_VARIABLE_LIST_DCN50; \
 	uint32_t SCL_BLACK_COLOR; \
 	uint32_t UPSP_MODE; \
 	uint32_t UPSP_V_COEF_P0; \
-- 
2.43.0

