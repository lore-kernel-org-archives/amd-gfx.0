Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C2D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C5210E5E3;
	Wed, 28 Jan 2026 01:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qqy4bi4U";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5C310E5E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKd6PU1OvgHArX18syfRa+2/mGpP0UZZuM9iSzx/lZCCImdR4nT89yEb43Y5fO3zGdztaQ8TLMwLRylzupKXm6ypI6MKMt1yOd+HMihn5r6XqONR3I/FFjklyfKNzc+LHjPlgWjcpWjQ3yRgDuE/UmPS/j0hYNzv6DkJ9cyn+zaK9pXNJ6xBfULmpyKdZqvVT37sQunkdEF7W5hAH17hFTUxEmc0l5Y0UhM88RJlfYPLZNVLS/+dUq8s5KaHlZ2BvnxlIuKq+rBY8f1Nv/nVnrkECmrZyONfI3x88yunslbXydEI3XwjIeisJEXDX5okYUg9wMJefkhx6J9lLtS2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3egK3wz8SvLnspFDrwddnH8o1NVTneJavytALN/Qi4E=;
 b=uO0j6Jjt2BvjwVUegfNfgWL2mHh6Zz8PXfSYKhMv+WUMIBVn64qxKB+4+Rt51m7Jc64mCRPalKmtUlgnn4tPBnYUQ+fLGGlhGSWkJAvgV3FPCSEAkp6vbPh6qoYhORN1gFspiFXTOjmaMMEJATf+pD8MSSQHj2O4q6K85gdcozTphJp+Z6+PQFNpt/hUB1tyNwpEpOsm4X/K22WAoH9BTnB3XzeAhJ+b8BqR7vV9FOkHZ2gOA5aHMGgn/YnJf4jZhzHpXW3GqV2xl1JU6lzFf6b/qCyxmdUGxSTMOV+HUF26f3cPCm6Rij7YVzGwdEWTEEVwRbbxpzpcy77U6kXSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3egK3wz8SvLnspFDrwddnH8o1NVTneJavytALN/Qi4E=;
 b=Qqy4bi4UKu2AdYKQ5zz7SS0s+O0INfGvOefSOgo8FjCBQfF3aKNmcC0lac2Mco+OrxM0CN39x2XmWSJ9nLnbkg2c9ocKv3udSr8f8iOgJ4uBqiE6jv7cdl8mKyJDXB3dvKqlagyvippsxWRorJJreM/Y2Z4mOUzrrJ1YRAbCi/w=
Received: from MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) by
 SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 28 Jan 2026 01:59:15 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::f8) by MN2PR01CA0058.outlook.office365.com
 (2603:10b6:208:23f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:14 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:11 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti <bpinnint@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 01/21] drm/amd/display: Migrate DCCG register access from
 hwseq to dccg component.
Date: Wed, 28 Jan 2026 09:51:26 +0800
Message-ID: <20260128015538.568712-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fc2ca0-043d-492f-93c7-08de5e10d6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0WcY8lw/WmePsjfafI8JqQ6CmXC5cBtmKNSQ7/r/Ggcu2dpQRdDFbc/7okpw?=
 =?us-ascii?Q?zU1ID25MOJD1Q0PFi31JRQXo3inkZgCk57Lr9wAxlf1n+tMR2z0xZdzk7DZd?=
 =?us-ascii?Q?p9TlbLYMKwHw5HtJDhDZoy+CCPLIybgsSQtMDqerAIrHTBkKF98L93vV/mSn?=
 =?us-ascii?Q?IjN3jpkIvQ6kkxR0uxU/W/zfK4Iy+R+ulX//yO4cLnh3Ijy2IX0d+Mnc14tQ?=
 =?us-ascii?Q?DG8kPt857QbVDhvgWjltGdnOb8AWynjhlmsthJ9lUvYnE5qk8Ux7gSLTv72q?=
 =?us-ascii?Q?Xqvf5BkTM183cI4Nzz+jBa/hvGniAM+nMS9dETYIrVjdqH8sUmgPs+hnO0Ji?=
 =?us-ascii?Q?kUdCrnjtF1/dmAMbgh66FSadVhEhQs4bGPohEsrTwu5A2tFeZR/ei7XXA6hS?=
 =?us-ascii?Q?8NR3trCcB8mC3qg5YpwJnuh6HGpf2/F91rhqrrUSwi/Xpbsptiu3CpFMMSir?=
 =?us-ascii?Q?cJx7oGSCJzGRzxBgxEOLWSRuwBL0t+Ku7AFdOG1lRD7NGzV611aL1ht189ZX?=
 =?us-ascii?Q?L3mZsGlIlruYl4M/Q58QK5mi494OcQIiGIokHDZQdksHuqDjLO6c2zzQZ7K7?=
 =?us-ascii?Q?P3gqy8muYbU14EuRO5hB6F5cUyA+3FiDjv3jgrTBsMQYNGYcjyKsONwUs6nN?=
 =?us-ascii?Q?ar0CQVySWDsm30Hi9s21kUsbwelBVVPkJjhMDFYA2oyfCVgU1bWE2AEI6SPr?=
 =?us-ascii?Q?LkacNUbO/4CdfF+bgClQ6JIY7/If5wmm6l0keKB/7v5VmXI5pls9WWRC3vB2?=
 =?us-ascii?Q?CaT4Alcg7UYU2pZXF/bpdBalxFKxixhYgUroQNwtDemla0jGJLARqtWFWYtN?=
 =?us-ascii?Q?pqKuckXbymQPgrtgZN+cdXUniMdsfvVgylhjLqErDPgHVL7tkO2Wtvwx8zQH?=
 =?us-ascii?Q?C5sHQDiWWVirS9TjcTx90hPE5CLicO5wK5DQlswLqayX2tYr0wTLIMti0beX?=
 =?us-ascii?Q?rI0Qw0lJ+/VqlWZFVm8DiyF7/hNhenEjzezUWbTaB5X4UMGZw8SsH31a0UNW?=
 =?us-ascii?Q?8osLeb3SeTLsgZ1+KV+j3FYdwtDmB5gAZsfZXM0E2XhyB3/JuC9d5pwHz2Ds?=
 =?us-ascii?Q?/MV5CoyIoPnG2hmsgdaP454vuHmuPErhxIuxQLILl1izpOyx+gcnnZcHpEqQ?=
 =?us-ascii?Q?RiJaYFLPdRstfxObdvf48Pv9ouIjqVGK0Uz14gJHglpedlY6IhtsrBxLRKTn?=
 =?us-ascii?Q?FMd14mC2RnY/FK50WViWTOPGaBVejsFPnyzYCJPHDaC8ThMn1b+Zvaf9HHBt?=
 =?us-ascii?Q?T/lgL1ueWKDR90VpNiMGmkQmelOQ6z1enudlJ/DuZP4bKXc2ogWAP1ubP4Eb?=
 =?us-ascii?Q?t3Nh0XoqzQ8CR2nktyn0LztSRH6UsWpaH2vceC5Tif5cEO1oaxcCbbXewvys?=
 =?us-ascii?Q?dM4eFTEnABxtDk2zQtdzGHfP+6T7EQ+tU0IVRx3/xnA8yv7LQsWhk3FFo19T?=
 =?us-ascii?Q?AnkZ/1Zf3ftPIiI8E7EoPbaRxaLMfR4qDgPHBjgrJABgK7av4urINSZcrvUO?=
 =?us-ascii?Q?1L3vRG66eH2HPLJIB2j5OAmZeIDpSw1TKDYLEes5e1egYduBX4n3bY986NQT?=
 =?us-ascii?Q?pugW2J+hzHUInbVklRYnFHKI4p0MC5p4UYKdYaoKa3d1P46lVKMhF6s7nGMi?=
 =?us-ascii?Q?NLVHb/icvnSwmYac+hoG4Ih8Oi7sF86pLRiRDj/tLaEI94ytU+WIxTNRhxIL?=
 =?us-ascii?Q?a3g+Aw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:14.6873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fc2ca0-043d-492f-93c7-08de5e10d6ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

[why]
Direct DCCG register access in hwseq layer was creating register conflicts.

[how]
Migrated DCCG registers from hwseq to dccg component.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 ++++++++++++++++++-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 18 +++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 29 +++-------
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 ++
 12 files changed, 98 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
index 33d8bd91cb01..50b98822b6fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
@@ -131,6 +131,54 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg)
 {
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* Hardcoded register values for DCN20
+	 * These are specific to 100Mhz refclk
+	 * Different ASICs with different refclk may override this in their own init
+	 */
+	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120264);
+	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x001186a0);
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
+
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
+}
+
+void dccg2_refclk_setup(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* REFCLK programming that must occur after hubbub initialization */
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
+}
+
+bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	return REG_READ(MICROSECOND_TIME_BASE_DIV) == 0x00120464;
+}
+
+void dccg2_allow_clock_gating(struct dccg *dccg, bool allow)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (allow) {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+	} else {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0xFFFFFFFF);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0xFFFFFFFF);
+	}
+}
+
+void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, enable ? 0 : 1);
 }
 
 static const struct dccg_funcs dccg2_funcs = {
@@ -139,7 +187,11 @@ static const struct dccg_funcs dccg2_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done
 };
 
 struct dccg *dccg2_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 8bdffd9ff31b..237a684ded86 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -46,7 +46,9 @@
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 4),\
-	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5)
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 5),\
+	SR(DCCG_GATE_DISABLE_CNTL),\
+	SR(DCCG_GATE_DISABLE_CNTL2)
 
 #define DCCG_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -81,7 +83,8 @@
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
-	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh)
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh),\
+	DCCG_SF(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, mask_sh)
 
 
 
@@ -130,7 +133,8 @@
 	type DISPCLK_CHG_FWD_CORR_DISABLE;\
 	type DISPCLK_FREQ_CHANGE_CNTL;\
 	type OTG_ADD_PIXEL[MAX_PIPES];\
-	type OTG_DROP_PIXEL[MAX_PIPES];
+	type OTG_DROP_PIXEL[MAX_PIPES];\
+	type DC_MEM_GLOBAL_PWR_REQ_DIS;
 
 #define DCCG3_REG_FIELD_LIST(type) \
 	type HDMICHARCLK0_EN;\
@@ -515,6 +519,14 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg);
 
+void dccg2_refclk_setup(struct dccg *dccg);
+
+bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg);
+
+void dccg2_allow_clock_gating(struct dccg *dccg, bool allow);
+
+void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable);
+
 struct dccg *dccg2_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index c1586364ecd4..f89b2f5a9bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1885,9 +1885,8 @@ void dcn10_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a76436dcbe40..87a1dc27def4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -357,26 +357,10 @@ void dcn20_enable_power_gating_plane(
 
 void dcn20_dccg_init(struct dce_hwseq *hws)
 {
-	/*
-	 * set MICROSECOND_TIME_BASE_DIV
-	 * 100Mhz refclk -> 0x120264
-	 * 27Mhz refclk -> 0x12021b
-	 * 48Mhz refclk -> 0x120230
-	 *
-	 */
-	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x120264);
+	struct dc *dc = hws->ctx->dc;
 
-	/*
-	 * set MILLISECOND_TIME_BASE_DIV
-	 * 100Mhz refclk -> 0x1186a0
-	 * 27Mhz refclk -> 0x106978
-	 * 48Mhz refclk -> 0x10bb80
-	 *
-	 */
-	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x1186a0);
-
-	/* This value is dependent on the hardware pipeline delay so set once per SOC */
-	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0xe01003c);
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->dccg_init)
+		dc->res_pool->dccg->funcs->dccg_init(dc->res_pool->dccg);
 }
 
 void dcn20_disable_vga(
@@ -3155,8 +3139,11 @@ void dcn20_fpga_init_hw(struct dc *dc)
 	REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
 
 	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
-	if (REG(REFCLK_CNTL))
-		REG_WRITE(REFCLK_CNTL, 0);
+
+	hws->funcs.dccg_init(hws);
+
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->refclk_setup)
+		dc->res_pool->dccg->funcs->refclk_setup(dc->res_pool->dccg);
 	//
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 482053c4ad22..7cd225a6cf6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -364,9 +364,8 @@ void dcn201_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index e2269211553c..062745389d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -33,6 +33,7 @@
 #include "vmid.h"
 #include "reg_helper.h"
 #include "hw/clk_mgr.h"
+#include "hw/dccg.h"
 #include "dc_dmub_srv.h"
 #include "abm.h"
 #include "link_service.h"
@@ -87,12 +88,10 @@ int dcn21_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_
 
 bool dcn21_s0i3_golden_init_wa(struct dc *dc)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	uint32_t value = 0;
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done)
+		return !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done(dc->res_pool->dccg);
 
-	value = REG_READ(MICROSECOND_TIME_BASE_DIV);
-
-	return value != 0x00120464;
+	return false;
 }
 
 void dcn21_exit_optimized_pwr_state(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index c02ddada723f..3ff15ec9dc17 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -798,9 +798,8 @@ void dcn30_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 2adbcc105aa6..91a672a46289 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -249,9 +249,8 @@ void dcn31_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 3cd44c6602b3..3f76fba7dccc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -959,9 +959,8 @@ void dcn32_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f7e16fee7594..1c7263f9ef51 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -288,7 +288,8 @@ void dcn35_init_hw(struct dc *dc)
 	}
 
 	if (dc->debug.disable_mem_low_power) {
-		REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, 1);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->enable_memory_low_power)
+			dc->res_pool->dccg->funcs->enable_memory_low_power(dc->res_pool->dccg, false);
 	}
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 86400938abd2..567ed207d7cd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -324,9 +324,8 @@ void dcn401_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 1e6ffd86a4c0..a26d31ab7cba 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -224,6 +224,9 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
+	void (*refclk_setup)(struct dccg *dccg); /* Deprecated - for backward compatibility only */
+	void (*allow_clock_gating)(struct dccg *dccg, bool allow);
+	void (*enable_memory_low_power)(struct dccg *dccg, bool enable);
 	void (*set_dpstreamclk_root_clock_gating)(
 			struct dccg *dccg,
 			int dp_hpo_inst,
@@ -334,6 +337,7 @@ struct dccg_funcs {
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 	void (*dccg_read_reg_state)(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
 	void (*dccg_enable_global_fgcg)(struct dccg *dccg, bool enable);
+	bool (*is_s0i3_golden_init_wa_done)(struct dccg *dccg);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.43.0

