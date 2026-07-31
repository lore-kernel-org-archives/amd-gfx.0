Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27924C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A7B10F417;
	Fri, 31 Jul 2026 21:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uw4uNmzI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A772810F40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN4jUx19YaZN2nmOBDW2YkKacLG1xwjvvDlRJuStE22bsrna7z3KuE28C87kEpCVflkjIJkjX63Uq9fbuIJUKW2Juw28Kq11171+5+DQuQyvkoldz2RJIkKBwaOMQYO3LPjLVFWYceiePwQaHL9hKBDxqlPbn1PQj+5mG/xhvBpT9zWjh7Pjzwo2yuHUfO0Zg+19InymI/sSfcIm+8iA73Yd1t+o6LyUoaRea+0B3Z5aqwBPyvWxx+RMHgP+y3NDgbtG8HbaxHp+t4YW9OWV7wkkOXhpU0i/dzmzEhcWLVRjmSyaxzCobVSx/HhR8enChjIXklLBpjyERKzb+EfLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHRMx/Bz59QIWcF2DckCO8RSQ5q4UmfobDeLdXcAtJQ=;
 b=Jsoc1EScoDVA4xj+sUuvkeuu3ayriznD8j/aCj+XQzkwW5vGpn3NN6o87NygmBBZhjgtvVwjt2Wv3af82BS2Pupueovm4F0NXBvC4aze4Fc5BXEFjn2lmsay4JNoUOrE1cF9oWhGIMJ0p93Dk8ZvfneIygH9ZZ8rX9MusOARp9fb8/D8pUy5Ev3+6UlOYVv/C06jkXUmhWDIggLylQIVI+tUht+jKwDGLNpjxJfhSsDY+U8vVdEaWYbF4GtiuUjOP9BInXC27qfGMrl9qF8lIysgW83eNcZD5sGoGIxMBF/XSRA15e+/5CP14sJe/k7IBot+c6Twy7VWLmJcj/1LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHRMx/Bz59QIWcF2DckCO8RSQ5q4UmfobDeLdXcAtJQ=;
 b=Uw4uNmzIp2ynNtCAk+3EdRaF3JkZUgjDCKBJp+rdGwDlrLM7uM4MnMcdlGrVLOSqUNsx+bBpGWEwZdd+q/wBAvyVUpCQVi4QUPTBrC5wxa0BeRmyg8cfweXQJaAg4UJTTxlLAD98GSdz+VNg8/yTLVviKxrQIweztyz4zFScifc=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:13 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::3d) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:12 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 34/41] drm/amd/display: Fix CRC engine 1 enable/disable on
 DCN3.1.2+
Date: Fri, 31 Jul 2026 17:12:55 -0400
Message-ID: <20260731211302.3040343-35-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a512b8d-d372-4259-3691-08deef48f362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info: KCBTpFm7H7bvv09l4/Uht5mM1ju3We4DyHT7ex95HrKdwrxpekguPxXgtyYKTXIwwNu/sa0gZv7biS6Fx1Axz6xtoj3cMs/LqiC8qXBLl5AVD0fJ5u8+7GWcNjovTQlbstj8HMafnWXjc/uPVZenazW4MeEaLKASQ2ry9AaDZZYDN4Z8GLzepFaFqCnxj+iV1Q33ehBRGDMW3CoHZLhzawxPzfrixEkt5lWUh5qBC0OtvvbWPYoxTMapMPkhcx7KqUGHjYVZ1xu5uoR1jPnuGrMkumS2iPCeh5F9iO0I8QtbLLxWCeeI3z03+9sTvfdLk0HqZkHom/Q3DgEb16VyEQRhKk/3pSnrwtIDlmKJ1ZrpdvUK4mZEiKv9N23mw2/wwNlgIoi+PtWqr+T97LtH1xzaqj5aXacK01revRWkX9RJ/VnN8OF8+Ww/wh67RED/1zONagMg1j3fNoo2FmT+z2I3eks1om6lb1/sFAJNXbkoIpw7iFzW+QQU0S9UfFP1I6uXozRvKK6TtX5pgQu04e/YPfqP/jVKNjyzIMmc3YizbYEpVajCe+N27pW0fIc5WTh76mymABrBczDo/gscem6uLZStmExorLIpdHO5A4dlhleahNYlwxLCqw0v74sjDEJeY13juRYDiSwXWlGpu8zhkJT1/tD96cCpo+Nd/qZaUEAI2oKt+3g4rUu60fKBDzR+efl5kVhEBkNN2oKDmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(18092099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: les3C1s8Fo5B/PzVJi2BMKIgou1V8fgorNz0Q0VSZZ8572wCf1qfq+WV/BsuqBT48HaXPx2w9xJES/vS0jgHQQ1Tk/D7cRr/+yBpDRFHCZz1TdRtmiGz7JDazAyftiuk9sz0QH1Jr4+Y1CsOIwtRHMoecuZK/Xmi9SOdARVcmDB866p121z2zn8obT++yWDDIY0262QPlPL1KFwOxgwJyw7ERpV3MMmva2g78x2mcQqgqOvwGxdDpOrAnUIpzDU3k7WiNElCLTefDhWrlAWmqLLRT3oJ4F8h6oxrTC03FQfWFABbRTbqZJ9uMBiD+5Dz2UbmnDs4iYeHFWk+c0pLiqxqRgmQdLJbD6i/tr7O8baDvIoFQHHKeAQMfeHXha3bf9fs4orpve+pKKx+EduAnFqQFIxeFTHlRTjXzIsnpNJxFF7Zztp/UowH75PaaUcb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:13.2773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a512b8d-d372-4259-3691-08deef48f362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Multi-ROI CRC uses OTG_CRC1_EN for the second engine, but the driver
only toggled OTG_CRC_EN and cleared the whole OTG_CRC_CNTL register on
disable.

[How]
Program engine 1 via OTG_CRC1_EN where supported, disable each
engine independently by crc_eng_inst, and add the missing mask on
relevant DCN ASICs.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    | 36 +++++++++++++++----
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  4 +++
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 26 +++++++++++---
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |  5 ++-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  2 ++
 .../dc/resource/dcn315/dcn315_resource.c      |  4 +--
 .../dc/resource/dcn316/dcn316_resource.c      |  4 +--
 11 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index cf8e22289d6a..844705a0e32d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1471,8 +1471,21 @@ bool optc1_configure_crc(struct timing_generator *optc,
 	if (!optc1_is_tg_enabled(optc))
 		return false;
 
-	if (!params->enable || params->reset)
-		REG_WRITE(OTG_CRC_CNTL, 0);
+	if (!params->enable || params->reset) {
+		switch (params->crc_eng_inst) {
+		case 0:
+			REG_UPDATE(OTG_CRC_CNTL, OTG_CRC_EN, 0);
+			break;
+		case 1:
+			if (optc1->tg_mask->OTG_CRC1_EN != 0)
+				REG_UPDATE(OTG_CRC_CNTL, OTG_CRC1_EN, 0);
+			else
+				REG_UPDATE(OTG_CRC_CNTL, OTG_CRC_EN, 0);
+			break;
+		default:
+			return false;
+		}
+	}
 
 	if (!params->enable)
 		return true;
@@ -1528,10 +1541,16 @@ bool optc1_configure_crc(struct timing_generator *optc,
 				OTG_CRC1_WINDOWB_Y_END, params->windowb_y_end);
 
 		/* Set crc mode and selection, and enable.*/
-		REG_UPDATE_3(OTG_CRC_CNTL,
-				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
-				OTG_CRC1_SELECT, params->selection,
-				OTG_CRC_EN, 1);
+		if (optc1->tg_mask->OTG_CRC1_EN != 0)
+			REG_UPDATE_3(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC1_SELECT, params->selection,
+					OTG_CRC1_EN, 1);
+		else
+			REG_UPDATE_3(OTG_CRC_CNTL,
+					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+					OTG_CRC1_SELECT, params->selection,
+					OTG_CRC_EN, 1);
 		break;
 	default:
 		return false;
@@ -1562,7 +1581,10 @@ bool optc1_get_crc(struct timing_generator *optc, uint8_t idx,
 	uint32_t field = 0;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
+	if (idx == 1 && optc1->tg_mask->OTG_CRC1_EN != 0)
+		REG_GET(OTG_CRC_CNTL, OTG_CRC1_EN, &field);
+	else
+		REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
 
 	/* Early return if CRC is not enabled for this CRTC */
 	if (!field)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index bceefb5320eb..d099e05c7207 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -655,7 +655,8 @@ struct dcn_optc_registers {
 	type OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST;
 
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
-	type OTG_H_TIMING_DIV_MODE_MANUAL;
+	type OTG_H_TIMING_DIV_MODE_MANUAL;\
+	type OTG_CRC1_EN;
 
 #define TG_REG_FIELD_LIST_DCN3_5(type) \
 	type OTG_CRC0_WINDOWA_X_START_READBACK;\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 98f7d2e299c5..119a954fe3e5 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -263,6 +263,10 @@
 	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
 
+#define OPTC_COMMON_MASK_SH_LIST_DCN31X(mask_sh)\
+	OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh)
+
 void dcn31_timing_generator_init(struct optc *optc1);
 
 bool optc31_immediate_disable_crtc(struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 6bfdee3fcf5f..7b43c3ecd46b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -205,6 +205,7 @@
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 7df1ed1102d6..60c01ec28b65 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -134,6 +134,7 @@
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 9b7f9d5bbfb3..897f857db448 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -205,7 +205,10 @@ static bool optc35_get_crc(struct timing_generator *optc, uint8_t idx,
 	uint32_t field = 0;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
+	if (idx == 1 && optc1->tg_mask->OTG_CRC1_EN != 0)
+		REG_GET(OTG_CRC_CNTL, OTG_CRC1_EN, &field);
+	else
+		REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
 
 	/* Early return if CRC is not enabled for this CRTC */
 	if (!field)
@@ -275,8 +278,21 @@ bool optc35_configure_crc(struct timing_generator *optc,
 	if (!optc1_is_tg_enabled(optc))
 		return false;
 
-	if (!params->enable || params->reset)
-		REG_WRITE(OTG_CRC_CNTL, 0);
+	if (!params->enable || params->reset) {
+		switch (params->crc_eng_inst) {
+		case 0:
+			REG_UPDATE(OTG_CRC_CNTL, OTG_CRC_EN, 0);
+			break;
+		case 1:
+			if (optc1->tg_mask->OTG_CRC1_EN != 0)
+				REG_UPDATE(OTG_CRC_CNTL, OTG_CRC1_EN, 0);
+			else
+				REG_UPDATE(OTG_CRC_CNTL, OTG_CRC_EN, 0);
+			break;
+		default:
+			return false;
+		}
+	}
 
 	if (!params->enable)
 		return true;
@@ -341,13 +357,13 @@ bool optc35_configure_crc(struct timing_generator *optc,
 			REG_UPDATE_4(OTG_CRC_CNTL,
 					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
 					OTG_CRC1_SELECT, params->selection,
-					OTG_CRC_EN, 1,
+					OTG_CRC1_EN, 1,
 					OTG_CRC_WINDOW_DB_EN, 1);
 		else
 			REG_UPDATE_3(OTG_CRC_CNTL,
 					OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
 					OTG_CRC1_SELECT, params->selection,
-					OTG_CRC_EN, 1);
+					OTG_CRC1_EN, 1);
 		break;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index fa62737b5b1b..3add972ca2ff 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -111,6 +111,7 @@
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
index 4370d64259e7..fd9c2b6b8b3c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
@@ -46,7 +46,10 @@ bool optc42_get_crc(struct timing_generator *optc, uint8_t idx,
 	uint32_t field = 0;
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
+	if (idx == 1 && optc1->tg_mask->OTG_CRC1_EN != 0)
+		REG_GET(OTG_CRC_CNTL, OTG_CRC1_EN, &field);
+	else
+		REG_GET(OTG_CRC_CNTL, OTG_CRC_EN, &field);
 
 	/* Early return if CRC is not enabled for this CRTC */
 	if (!field)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
index 758cddd9e64f..bc641f6ecd7e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
@@ -138,6 +138,7 @@
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_G, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
@@ -316,6 +317,7 @@
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_G, CRC0_G_Y, mask_sh),\
 	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 7c78f8ba40ef..470f3bd37314 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -659,11 +659,11 @@ static const struct dcn_optc_registers optc_regs[] = {
 };
 
 static const struct dcn_optc_shift optc_shift = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_1(__SHIFT)
+	OPTC_COMMON_MASK_SH_LIST_DCN31X(__SHIFT)
 };
 
 static const struct dcn_optc_mask optc_mask = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_1(_MASK)
+	OPTC_COMMON_MASK_SH_LIST_DCN31X(_MASK)
 };
 
 #define hubp_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index b9d2567a4180..d81d241901b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -654,11 +654,11 @@ static const struct dcn_optc_registers optc_regs[] = {
 };
 
 static const struct dcn_optc_shift optc_shift = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_1(__SHIFT)
+	OPTC_COMMON_MASK_SH_LIST_DCN31X(__SHIFT)
 };
 
 static const struct dcn_optc_mask optc_mask = {
-	OPTC_COMMON_MASK_SH_LIST_DCN3_1(_MASK)
+	OPTC_COMMON_MASK_SH_LIST_DCN31X(_MASK)
 };
 
 #define hubp_regs(id)\
-- 
2.34.1

