Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC335CD3439
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AFD10ECDF;
	Wed,  6 May 2026 07:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0V8vLUG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EB710ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqc5r83Nyyss0Z5wcW4eDureVkXa6LL2mwEYLutqaItkVAIDRjoNj7lFAjRqHza75BIeQOSKClvvDBwYx/wo0+V93uo2plHdify4DA7oN5ylYr/8PAb8kKMZB2fjmZA13JSZ22fKaPnICEPe4PDKYN0wJxqfMoxFAvH0PE6cBLe6ah0118eN87TuAlFJF+nuum2VQhvTw78elkyoTZ7UsPEp7Ku27cuFQ+rOloHcfvzRtShBhHSjkWZbNqzPVVXFyiL52tQoEj2BkjmpoaL4cFlUgymdse/0zR7Q9LrUV5kstf8vfKXnvFx0SCoJTTwZUXsEQ3yVOv2IFC8He4VE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuekFDJ44Iez4F/cuY3bYkIYfo5lefR9Ag/5/2AYYX0=;
 b=TtP84WGc+nGfc4QqirHhxmEdrIXjGeF0NIEGolzdm936qTp4fb86EULIr5thQ8dXE62VJufLITy0LsVmk5OqQX+RBKirIuUIBQiIj6gZmIj+wRxLdlL//wne0PPI/4WL9Ln+FKEgJMi3SbpAGKyOyWK+P0MSGRBVsB7kV29MenYUXJx+8Fv+xmM+gw7QAOFViwCoxgkGbTnZAi+hG5bZaD/iGs8srtsqSRBcExVxmTy8P1tJmETd1d/4t8Vgrra3A2Le+REKrQ05QZ/7gDxKKs4LVfqbT0UK3UAc1z0WSKlF/CrOdrM+2PF6e74+SlfPuwcKht3hBl6iFSe9+s/avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuekFDJ44Iez4F/cuY3bYkIYfo5lefR9Ag/5/2AYYX0=;
 b=w0V8vLUGNJ4oUr5ymzUxM5dq7sIsKcYMkVTwY7xnjPbj5VxRtMioNhMMAV583CPqc89/b1a2dXMmkX/PdhbSR28RLUNG3HRqXtNMqN1f2ZPyR71wtsVRV9jNd8SH7B+5C6X2ub6gM+w5XwkD+v639k/habJyKuI8oi+bicwewQA=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:04:20 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::49) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:04:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:19 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:04:10 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 08/20] drm/amd/display: only call pmfw if smu present flags
 true
Date: Wed, 6 May 2026 12:31:06 +0800
Message-ID: <20260506043342.2164710-9-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e96703-cc7e-4caf-913a-08deab3db214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: l0VTT7sJMHFnm5kkLWtQ7HdCfsr+K4D3SIT1U7BpEEGM1ShhaKcIVz2gKP+rwjFqXll5okYsaOqnYt89EVssYOEuZvaigLm1w37DxgS+yZwb+mHx/RWeLknCFG5ZfHLDSJgFkKA9SWz8Ht9r6pA55TSklZCFgWLvE38IwwZXx48du+gExeXtQLJBFSwyVyBj4XgKvzE6Wpjwi/HBmsPfg8e3y+ORpDslnX1g2BWBUudiRgmy5714eLQVCEi859dAJnXCYxAjNNH903ntQx6ZuGOj23Sm4wlboEgbGsPhM9BtYcA4MNKMQmVbuEOlK/jYddkKDf5/BrBfFmxFIp+b3zu4AMPS/JKnBTdETH2Z6DkWeLl0Ho/R2OoItCFRGMypF0jgcpO+1QI5+kB6bzsV4kPjGauNzY1HEU9j13tPl11n7sPFVlkSqZBbQowQH87UbJS7jXW8OHJUi3d4TcBZuqOKbxpRJctEubegUUMmOQL4S3bfU3TgDehbacJ3Odc6/0OiHGLydHgerhBhdbmmU2WdryW18Kn4Xph3f2jNGzJbn40Uoz6pS2Xs65vs24M6bKe6HEVjkNWIgtU5rL5heU9zWE28PR9ygJIn7C5tVEA1fsYA1e6H6WVDF+8g0fnY4IRiGCBBhLQmvViPUnuchrwMGfqzNmwqPLUUmeeKQFvbBI/l/aMQW7FlT/LrQRbPac5X6w1QXesAnl5JZL3CNxIeTADR/RTOQCA/4BSopEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bPJo7/0YUls3+eigoqefGs27fWSEXW391HKhZxU6zWAqKSiR7U88xcO6aV+HjaJgmeVexFwqTVd0oAXCyuKlU9pklO/lQmLFuv1nRfbdHyU+N7Dj3RgtivqniwEh5lniPnCGcjcURna1RzCO02UwX/MnI1C5BMhCrD1pdh9fBP8rv5B8rIMgRhqBTOwmr+x/mY9jV0SpLw/lFlGqwLdmL2jWw6t5vQMIE6avZ+Chb0VZNO20wqgIWKjAcChG55fi+QmeWr1qtI8aifOfT8SiUehC+rKgOtl0tTgdzsCRoMbnp6EK2D35OysSxIwfxLKR/YyaAJHnLSE8JQ9yfXNPpUIUCQk8CSlg7VWqiJfD2ESn7FAzQJ5bBILNyfPLVStepR8V6xFbzP4mL/WxgTkgQkudfCUxiLKAt9dPIub6B2Pu2EgO/8thRfF2NmkE/Kjy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:04:20.1909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e96703-cc7e-4caf-913a-08deab3db214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
for fault safe case: only call pmfw if smu present flags true
and default to 2 channle for bios intergration info table error.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 245a217894a7..d856a7a807b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -1078,10 +1078,11 @@ void dcn42_clk_mgr_construct(
 
 			dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
 			dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
-			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
-			clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
-			clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
-
+			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 2;
+			if (clk_mgr->base.smu_present) {
+				clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
+				clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
+			}
 			clk_mgr->base.base.bw_params = &dcn42_bw_params;
 
 			if (clk_mgr->base.smu_present)
-- 
2.43.0

