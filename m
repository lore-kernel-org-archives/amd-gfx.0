Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UhGE83hG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575BA10E080;
	Wed, 28 Oct 2026 09:14:58 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE64410E080
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQM6kXnjxTUAWLceEXeKlqwtPOtKzRxyAJ3lsU/nA0J/OBFbi97zH8dYl1fE+TGHHMy6zKUQJZuWUesKt+VFOE6HxOtciDugGCxytcvJiOrR0i26+FiPGA07GhwKlgAS2pG7jAWrRs5aN8+C5HO5+1WWRMMw8XP+W7I5RTN98br9n5GxvDSFpAk40KCcIEbisFz+j7eYwM68jqO82cIjyVERaUOhsN0k+xCujeMZDlLJBmCyb6s5tCdklu2384nd/724GzfDmnLB3cC4fBAu7auca8/JO3ifHmO8wp8tlD3cxwJyBFMYoK4YFzWzc3hsS5knKQ00Tw5HATSlfs64ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS97xjXdlDhbsd0L9pnFSTX0SXdKB31pzakg08pcAUU=;
 b=QcF9DLYDQtsgmwN3AtJRC70dMgieatxqHVh4ndOT9dikh4yUKcdBMGKTqjNhvIpmnaj65fxxrUFBQKfzu+uML7NRAEP+hSlRqTEduIQNNlM4i2p9CB9ARGfbU0S0YFl5NLsZ0aIwK9S6fYnZivw6APW+GRJWBY03rkPbRmdmBJhR05UTOxZMmz9wkkeJ5w3Gc6FSrf0XvsmOcQUePStNsX1pNYxFyzAn9wKFJ3ztkJMFPVwoSJ0oi0/NxTzstXYzWO800bHo54dFt0fgOvcoCSgJdu3JJBAxEkELwh7FxZtC1wD7T+ev6yEJUiMpYVuf7wZTWEXXcSW26mTy0UwbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS97xjXdlDhbsd0L9pnFSTX0SXdKB31pzakg08pcAUU=;
 b=UhGE83hGcmHQ24xP/Xwv+sp1MFIw3onX1WiuyhsHRAY3K1aSncmStUsxHs93kEAkhjHFyd0eVSZwspjj8tm36lsEcon7lPUXwUDtYRaxIYZIENyUSWwX6Dp4ylkCVicgKtHTepwBmYeNS+RaUG8H0Me8bM1iad6YS4zssG5SnMM=
Received: from CH0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:610:b1::11)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:14:45 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:610:b1:cafe::61) by CH0PR13CA0006.outlook.office365.com
 (2603:10b6:610:b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Wed, 28
 Oct 2026 09:14:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 09:14:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 04:14:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 04:14:41 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Tom
 Chung" <chiahsuan.chung@amd.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH] drm/amd/display: add missing CRC engine 1 registers
Date: Wed, 28 Oct 2026 17:14:53 +0800
Message-ID: <20261028091501.191108-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: ade8aebb-2c56-40dd-9a1a-08df34d3e80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261021123027099003|261021121427099003|10067099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: aa5g0ry9B7qs2iRZ8oa5XGxi1EjTUx11BTg1DWi+AjupA50fipjM/Iu+3CD7w+AG1Tyn9LMSy4hZwjXPn0Vje6S7x7aSWFjr1RKxGn5Kh6wV4Ca5dDn7p05bIupVDNVOTpifIHSOtEiOanh5EkvmSuQopYhU/6q1QrskP075wwlN/hHMYUbGBfkKeT/J7Hrk6PGes9epgrDA0DvWQeLUp/7WQdzpJPleRE806uEsB3zAw/f6rNn8PX0uyHH+fs564p/xXDOxhBfxsZLqL9AlVuejp81oobyM2mAl40xhPHe4gu4Eg0aVnVdawQtUo1Fv7xEz17DK50eSh5UwTtneE8GUbtGEAtmPvpV8dT8q0edXddeznUGAepitZKNHBaWWJc62EMd84QEt5sblhIjZQ+IVPSkWGnOJ0FoTh8fdVrwjRXNPJmz5OY0eOLPRV0NH1kOlI9KOKZZHLieqKKoGTlIIBUiDh+gOv48ZdoQNax+GMNxb1NYElCP+vmAr1m7mbrrL4DZ8eizHKBsWq+uPnhgAFA/ruQlclQwb19GJQzhun/1JWwNq+s8ozeulG0LX+zfvrbnxU94Sbu/Jb5GCMLkcfdd0esnDxUIux1T9Zc/jOH24ybXYngNRZmOwMJWs6fzEZMcMPpmuLzJu2iROvP0f2Iis9gYPkgGJvG81JLU1KAcQNscUi7BtoE5hyRt5wRHjr4iykUcKnY5UfqlUCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MhAnt8WffE2fb2XI1s0auzBGwzigEhYdO1IJHZINyQuyPdYoiVyJVSWzODoxWI2/nCZplag3yJAlDKhouzrvOzlP6QPhratTAHnRmXyBiaWR5G9p2O4HdRgjTQeJoZDxDfxHunawf7n3M64uhAkeSACRR15BEEVdVimZuutbqJb5UCt5yEcliqJZcy+gV7HMGcohS0QYOmpzLlpmoRu0C6hFSYBsSowKlMRfT26POwAXMXuWPNXUTWmSRJsvAHCr83EDP1YSss9igDuTOmYvF+sqnFwhF7Zv9UH3OUPSubwh9wJwndHYgMKc1XbFrGZ8v5KABplYuBqhXOAE5uqVsvzQhJisPzJKZkU4UFB5QO2f5To0+neZ1MgWVo3HVR1FGnhaUt/1t6FjesNQHTUiEGLuYoWZvdJVshXRoYUPpe8TY09iL7z39An9vi5htJpd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:14:44.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade8aebb-2c56-40dd-9a1a-08df34d3e80b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[why]
Opening the CRTC CRC debugfs file programs every CRC engine. On
several generations the engine 1 window and data entries were missing,
so configure hits a zero field mask and WARNs. DCN4.2, DCN4.2B, and
DCN6.0 already had those entries, but configure still writes
OTG_CRC1_SELECT with no mask check. DCN6.0 also lacks OTG_CRC1_EN, so
optc1_configure_crc() writes OTG_CRC_EN instead. The ASIC headers
already define the addresses and fields. The driver tables did not
list them.

[how]
How the missing entries are filled in:

1. DCN3.0 through DCN3.0.3 use OPTC_COMMON_*_DCN3_BASE. Add the six
   engine 1 addresses and the window, data, and OTG_CRC1_SELECT masks.
   These headers have no OTG_CRC1_EN bit, so that field is not added.

2. DCN3.1 uses OPTC_COMMON_*_DCN3_1. Add the same addresses and masks,
   including OTG_CRC1_EN. dcn_3_1_2 defines that bit. DCN3.1.5
   and DCN3.1.6 expand DCN3_1 through DCN31X. DCN3.1.4 has its own
   list. OTG_CRC1_EN was already on it, so only addresses, SELECT,
   window, and data are added.

3. DCN3.2 and DCN3.2.1 already had OTG_CRC1_EN and OTG_CRC1_SELECT.
   Add the window and data masks in the OPTC header and the addresses
   in the resource header. DCN3.2 fills addresses at init from
   ctx->dcn_reg_offsets[].

4. DCN4.0.1 also uses optc1_configure_crc() and was missing SELECT,
   window, and data. Add those masks and the six addresses.
   OTG_CRC1_EN was already present.

5. DCN3.5, DCN3.5.1, and DCN3.6 already have the addresses and program
   engine 1 through optc35_configure_crc(). Their mask list included
   DCN3.2 and then repeated the CRC1 window and data fields. Drop the
   duplicates.

6. DCN2.0, DCN2.0.1, and DCN2.1 are left unchanged. They inherit the
   DCN1.0 lists, which already name engine 1 window, data, and
   OTG_CRC1_SELECT. Their headers have no OTG_CRC1_EN bit.

7. DCN4.2 and DCN4.2B use optc35_configure_crc(). Window, data, and
   OTG_CRC1_EN were already present. Add OTG_CRC1_SELECT. DCN6.0 uses
   optc1_configure_crc(). Window and data were already present. Add
   OTG_CRC1_SELECT and OTG_CRC1_EN.

Fixes: ef45aaf73717 ("drm/amd/display: Configure all CRC engines in pipe CRC source path")
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Assisted-by: Cursor:Grok 4.7
---
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    | 18 +++++++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    | 22 +++++++++++++++++--
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  | 18 +++++++++++++++
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    | 11 ++++++++++
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    | 11 ----------
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  | 12 ++++++++++
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  2 ++
 .../amd/display/dc/optc/dcn60/dcn60_optc.h    |  2 ++
 .../dc/resource/dcn32/dcn32_resource.h        |  6 +++++
 .../dc/resource/dcn401/dcn401_resource.h      |  6 +++++
 10 files changed, 95 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index 16c5610b49ac..b801989f10cf 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -91,6 +91,12 @@
 	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC1_DATA_B, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
 	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
 	SRI(OTG_DRR_CONTROL, OTG, inst)
@@ -229,6 +235,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
@@ -245,6 +252,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 19d90c65a22b..c56512455338 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -83,6 +83,12 @@
 	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC1_DATA_B, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
 	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
 	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
@@ -205,7 +211,9 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
@@ -217,6 +225,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
@@ -264,8 +283,7 @@
 	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN31X(mask_sh)\
-	OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh),\
-	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh)
+	OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 7b43c3ecd46b..956eecf0a43a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -84,6 +84,12 @@
 	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC1_DATA_B, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
 	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
 	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
@@ -204,6 +210,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
@@ -217,6 +224,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 60c01ec28b65..492760779226 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -146,6 +146,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index 82e0818c8f9f..196596cc9fb6 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -32,23 +32,12 @@
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_5(mask_sh)\
 	OPTC_COMMON_MASK_SH_LIST_DCN3_2(mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_WINDOW_DB_EN, mask_sh),\
-	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
-	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
-	SF(OTG0_OTG_CRC1_DATA_B,  CRC1_B_CB, mask_sh),\
 	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC2_DATA_B,  CRC2_B_CB, mask_sh),\
 	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC3_DATA_B,  CRC3_B_CB, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
-	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_START_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_END_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL_READBACK, OTG_CRC0_WINDOWA_Y_START_READBACK, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 3add972ca2ff..9e4e9d75400a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -110,6 +110,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
@@ -123,6 +124,17 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
index bc641f6ecd7e..bdda94489a23 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
@@ -137,6 +137,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
@@ -316,6 +317,7 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
index ba207c0e498e..ec40c9180030 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
@@ -109,7 +109,9 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_G, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 68e7140f1505..fa8cc89cb3f7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1054,6 +1054,12 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
       SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_DATA_RG, OTG, inst),                                    \
+      SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
+      SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
+      SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
       SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
       SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
       SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 8e3473f86490..3cfc1a39a103 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -535,6 +535,12 @@ int dcn401_get_power_profile(const struct dc_state *context);
 	SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
 	SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
 	SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
+	SRI_ARR(OTG_CRC1_DATA_RG, OTG, inst),                                    \
+	SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
+	SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
+	SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
+	SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
+	SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
 	SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
 	SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
 	SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
-- 
2.43.0

