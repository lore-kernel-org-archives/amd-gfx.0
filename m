Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB010CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797A210ECEA;
	Wed,  6 May 2026 07:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cwNLPPUk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F309410ECEA
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW0Ue1OyLpJvb4SsBYcxZsFAtxn1sNds8DcHO/TzMiRL/+vggz1mvfGzg5yRIqR3IU+3ZJ7jRz0aJ6CUTlTcNlGFmNxXoWsFUtPc8yLgJC5FybU5oBjF64bTUzX12rDHWoTRYPOTmSQB/zKFVjGlYCkdjAOCHOC1kBxB7UrbSehaxbb2Aq1Lzrpd1IZ2C//RWLYJmIFB3fDUe5+Nmgq1Jc2yjNszPtxpDzNytJ3q5pFY8neXF15lYgyulu6fXREUCvMRh3GYbNj4UIILi6phucHxmz3lZqcgSMEGfyKwKh0UESycDl6hWIk1Z+pTal7b2pNEciUkmr9kxWH+7U3W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IspQrSQFvxfU39FN7GsVnFz40+hdUmArqTubTaBDyfo=;
 b=PSrbuV7NBB5VM5jZqjKamUCTA6qKsZjo/oeZ7GS6eT6q95pOA1V6IlY9Zc56ZhhJwCzQLenxEKmpfV1gyhpzCtNwzuooguPXwcY5MSrCSO41eOVJsBDpy6bvT4k5nnfNTdA9KEkWMOHaIK2qWXur0i5524BvW6muRPAE9ADkfkhvoJGZ7vlrPY3kd4qK30unOpV7QMPMZxfTIJuxv23hx5lLCLvywBBgzaRjlFtaxPcTm/AEt/Fv5D/iwTCnfsa2HV4DY8U0NfpQ54YIkJFHJDTHF5bZ8yZgn5ewRYaHbWPouVgvpAdFOSv3M//b42nKqMVx8TuIgmJAba+qMl+++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IspQrSQFvxfU39FN7GsVnFz40+hdUmArqTubTaBDyfo=;
 b=cwNLPPUkNDqM6lZT2sTj2ObLPXZdRYSNjXDp1FrN0/o4p/NCK/ZyP8mWkyKSNICwg/e5vVuvtN589XrWO1N3TnSuyVBQHd7kNENZk9DGEfyLHSCCfdJWmREHImp1j5vtzq0TA59V/50fdLxbvYLgqmVaI9D6742+2wlpN+sFIcI=
Received: from BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8)
 by DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:06:18 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::c5) by BL1PR13CA0183.outlook.office365.com
 (2603:10b6:208:2be::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:06:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:06:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:06:16 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:06:08 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 20/20] drm/amd/display: Promote DC to 3.2.382
Date: Wed, 6 May 2026 12:31:18 +0800
Message-ID: <20260506043342.2164710-21-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e90f0e-56b6-4804-348a-08deab3df8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BcbhczBWfDvudcS9WEVZfLvt+668JOxMEWFS5wVjyX8SffuCG1NZd4+j11mLPl4TM35M6isN4T4gqMRKRvyIGxO8UyAXwFmePi8fvAvoAvfc9uLdcc90tHyvnmMcvs9ySsoxbQGi7cBKBGMpeXS9w5cWlYyRUZWUV5LritlkwvTB50vXz68HNET5eIMTEGmYWuLy/gnSW425uoYKxqCrzshEee/ALlwcN3cAZS/vqBsaAuKSRbzFG+KGwUKPLKhLMSa/hDFbEXq17/qZ2024CYeB+jQ7RSFixzyrFedZ8MyR2a+NiWEYr936S+lGdUKEfSyWGTdwSWGyP24aGZVpNAFaOaNBPWY30WmgCf4x3GsqauNf23OcTTdUtBYNh8fRVJfvHA0kOvT5gG6sZ38e75yRosLS/8mEhtZauGI8iOR0EwDSiHj8qYzXp5oSBIZ3wCnNzPajaqwA0kCmvaEWgmczRopa7iQRLZ/jfJQ2KqWBI/mfWE9Lvmbsw6tspS9tUIuadeO90DZhccqM+y9zzpl66CPImLLICWTmW01rESI9F14yqdG1RiOeFC6M3Tlm6SNj8JSndjccVfjb4msi0IZyfyCs2nspp7cFinSUspyP2F1AZv85eTuvylwMpk8++p06UmKSDUbzDnHNKV8FgY33z1h/s/FMpW3a9WvmVz7UY9Y60V7PKVDOcwgkwRlSx24/GO47OteW0tj+yCRIvgwLJ1A9EO0CtbD8jV87v2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XWdO2OjFcmPHx3hh4qmtPTUdg9a5xR8f4cef2zHiC85O/QMwGejggeXK/O+PObNfUlO9YfASEq4uC5jPNDDfdX6EmQnF2v2H5Jmjl9mHvIYtkIAXaJSBASd0jrS5h0Rm0wnMi38gY++EWiDtIJajWAsj9FjzTlKJPjn+eIEdLAL2XbU7qO/4sBL/i69Oo5YnUgTiGiDdGBDcX+f0/poyH1TUMWFroKs0qVmJQzcOupCR2ja9O+NyotS+f8ZLq002grnL3u/9wlE49d9SaSE5LzT3rj6TD9N5QM9cVfxAKKHfIo/80vCsCrDu5g5V5ENpEn34o3hmJQvSBiYfTmJyT2jFfwrhdKLdzGhHOCWLPH7JNmrB68ab405iAWOjx9WehYgFa5Zu3+kTxSou7tlg95ii9F0AeDornw/YVBWNuB3XKXxnHjvEOzOPyX5e5ZY/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:06:18.5508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e90f0e-56b6-4804-348a-08deab3df8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:
-Revert "Enable HUBP/OPTC/DPP power gating"
-Revert "Unify fast update classification paths"
-enable ODM 2:1 on single eDP based on pixel clock
-Enable IPS on DCN42
-Add additional IPS entry/exit for PSR/Replay
-Separate ABM functions into dedicated power_abm.c file
-Fix always-true lower-bound assert
-Refactor dc_link_aux_transfer_raw
-only call pmfw if smu present flags true
-Fix multiple compiler warnings
-Fix CRC open failure during active rendering
-Fix white screen on boot with OLED panel
-Fix refresh rate round up case

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d87bf8f4f56e..d0b6fad65bc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.381"
+#define DC_VER "3.2.382"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

