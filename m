Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334AACC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520CD10F77E;
	Tue, 13 Oct 2026 11:19:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB3C10F778
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9um2lfo07N19WBr5qLHeRhJByPNhxLGqUHndP64/p5JElbLk0h5p+AF/VaCFU4S8i/0UnNPyj5sQjY2NZ43PHioDNgNNswvZHbDh/qyy0fc991Om3TnQqspVMSHJ1OxjBHraGZMMxgThNs8R2iyrks8U9FMwQFr4l4azlb5a7V1c53jwfJCuff/1YNi+TCmKICjOEcn4YuJfkmkvHZcYlTd6p8uQR/ktp9jLXwttHmD9X4s3ULtzUDY9jEDUJYAOmFttKVyLE0iotBdshDuSp+Bso8t9UiibQuK64S0Tt5dz4W2r2A+pa+qLIQ1mJTrAiMekjS2cD3DfajlXqzFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAcE7AAPhgZw8BuWOFRKXs7kpordJ7sMGc5kJ/DFXVI=;
 b=RGku5I/g6J2+szFrdCgJHEM3bTOnuFiuNxjCksyQIhwo9ARnRlyPSKjHOM+j1coA4dcSjEOC3Uo/Cm+rVjpv6iq91W3UJ7dE8WvwuHlUebZGJ9LeofgQxDJ/gVwsnwtDIjFJ/8Xpm8d5ur6NOjxvczJoLpRj2XOrAFSioOhggT9ubwxYvBc8Z5fgVLPZ93nOSnf68s9cs/GtNqt295n8jTqn2j85pcNvmioNUP6R6H38yWcHH9tUGjprgnwR81KntO1umGc2+pclcykTyvkW5m3YIvagzJdIjgZ2BSx20ZNdc9S3nxrSfm9vZ7vs/vR41z0T6fLiVSEhyzbVoeY5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAcE7AAPhgZw8BuWOFRKXs7kpordJ7sMGc5kJ/DFXVI=;
 b=YfSKmub4hakblnx3riJG275jnT7wEDPskbA5R2qBMK8+DwILUw4C95eOqh1DBnGvD9feZ3Mue2fkw9PuYVz4dyoqnFiJxkWUX+sxfhoPT/NjkTQp86cty5w+ieEThZx+u86h7a6UFM9q76+7APTBOnzmwqR8zghDnq+SSoS/vBY=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 11:18:30 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5b) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:18:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:18:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:18:23 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:14 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 17/30] drm/amd/display: handle exit LS in second ISHARP
 programming block
Date: Tue, 13 Oct 2026 19:08:04 +0800
Message-ID: <20261013111616.2267344-18-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1513f9-bb3f-46ab-360f-08df291bb5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: GCtDgDkljM7MHqDD9oWdFDyGqQZ3rozuOVzCZiXgwG2jIOqAZQMI37n6CgLTz7ZYN2GtrzvlCjoCHm2mIYI2NAH5AzsKojuTyAy8ssRYr2M5yniJ+jEtlraj9y2P7T7e5JnBnA1fzGJ32oPAPs8qYH82cEyODqogpy6q+irCb6hjs6h4gDR9P8pf9klYEpi8jFMsB/gOJGBDUNuT1m6aPR3PCDgoqarnniYnaCGeTisDGSO6TOqODHydDZw6GEAOrZMRoXZxezaxQIE88k0Eg2Dt/635onrAd7DL2amZ497i+WmRUjPczA25g9pmJPDiLgeT9ARrlEiF5uugzKPOsc78shABGXBNuGMftwGEkCFTxZiNKUV96a3/zrqNY6maEc/yreMfsM53hoSmiR71QRqRTgzQzx9N1FlxntOqAuvgih33Pr35Lu/Xtq7QoAY9qGjqOn1T9BApNJ7Rk+X0M/k9w+Wpd6icaNFiTuloZijkbGzm2wTc/s3DTO3k+xjiKf/obTDz5EQISXG5I2fqkFBbsFjbGy2+OdPyzTzX4HV/HRfWOCpAgQ/MvbCYqXjlIBm3AQxsRsM0apF4E3EFiVsZqFco3KOE3w6lH7fpwEXHzWwFWCPd5drz+Ha+R3BJt5ujYJF/vnKDgnv39VhT6Zr1OXV7pWrOg2aGuM1ZidHqZkfGnECWHhl0nhHpWQ4MIJSr++0Zqn+w8k78800N/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lunWux+NitLNcCOSV26wfP+OceYsbOvFLoRVF9vx2798q+5FJHfnP8HC5pYWvDoCqsVXgdWGHnh4lt8RVRs3fORPKVuRYSAYzhSiOK01ZPoTKKldOrJole6xq8typxDSZRZHnMsWyGx+swlckKrF+eJojEVjAlrqUtQl/coZHWgwBHX28O+UgPaIYvFzu1PXrFMQqFiMoX30CTO63gIi1GBEkTsAcX0K+uQ9T70RRx3vc/l3yKDxJPIdjvKWe5yIvfJhTF8xVuUuU2aUeobQJTaBwXyPF/N6VDMnw7OOIeS0HJZiKepGaRG4mM8cxAoD3b9VN9EpeKvgB/LdX5JoS3e88WNuqnDNgkvPwGI1ydin6Tz6zUU98pk2lNvExCPOLwthimMa/e7qNE6qFrGrPoCHW4+lSNFAHqxJoxE3sX63K4z057d4PMFQHW4KAamX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:18:30.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1513f9-bb3f-46ab-360f-08df291bb5ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

[Why]
The hardware programming guide indicates that we must exit LS before
any coefficient writes.
ISHARP LUT table write occurs earlier to handle case where only
sharpness level has changed.  So it occurs before exit LS

[How]
Add dpp401_power_on_isharp call to explicitly handle exit LS for
ISHARP programming
Call power_on_isharp on before and power_on_isharp off after ISHARP
programming in both cases

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  8 ++--
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 40 +++++++++++++------
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |  7 ++++
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index f1530e8805cb..e49be524b31c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -757,10 +757,6 @@ enum dcn401_dscl_mode_sel dpp401_dscl_get_dscl_mode(
 	const struct scaler_data *data,
 	bool dbg_always_scale);
 
-void dpp401_power_on_dscl(
-	struct dpp *dpp_base,
-	bool power_on);
-
 void dpp401_dscl_set_recout(
 	struct dcn401_dpp *dpp,
 	const struct rect *recout);
@@ -793,4 +789,8 @@ void dpp401_dscl_program_easf(
 	struct dpp *dpp_base,
 	const struct scaler_data *scl_data);
 
+void dpp401_power_on_isharp(
+	struct dpp *dpp_base,
+	bool power_on);
+
 #endif /* __DCN401_DPP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 6e85890e44f7..adb3f155d051 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -146,7 +146,7 @@ enum dcn401_dscl_mode_sel dpp401_dscl_get_dscl_mode(
 	return DCN401_DSCL_MODE_SCALING_420_YCBCR_ENABLE;
 }
 
-void dpp401_power_on_dscl(
+static void dpp401_power_on_dscl(
 	struct dpp *dpp_base,
 	bool power_on)
 {
@@ -173,6 +173,25 @@ void dpp401_power_on_dscl(
 	}
 }
 
+void dpp401_power_on_isharp(
+	struct dpp *dpp_base,
+	bool power_on)
+{
+	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
+
+	if (power_on) {
+		/* exit LS prior to programming ISHARP LUT */
+		REG_UPDATE_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+		     ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+		     ISHARP_DELTA_LUT_MEM_PWR_DIS, 1);
+		REG_WAIT(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+			ISHARP_DELTA_LUT_MEM_PWR_STATE, 0, 1, 100);
+	} else {
+		REG_UPDATE_SEQ_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+			 ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+			 ISHARP_DELTA_LUT_MEM_PWR_DIS, 0);
+	}
+}
 
 static void dpp401_dscl_set_lb(
 	struct dcn401_dpp *dpp,
@@ -964,13 +983,6 @@ void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 	*bs_coeffs_updated = false;
 
 	PERF_TRACE();
-	/*power on isharp_delta_mem first*/
-	REG_UPDATE_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-		     ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
-		     ISHARP_DELTA_LUT_MEM_PWR_DIS, 1);
-
-	REG_WAIT(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-		ISHARP_DELTA_LUT_MEM_PWR_STATE, 0, 1, 100);
 
 	/* ISHARP_MODE */
 	REG_SET_6(ISHARP_MODE, 0,
@@ -1049,11 +1061,6 @@ void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		}
 	}
 
-	/*power on isharp_delta_mem first*/
-	REG_UPDATE_SEQ_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
-			 ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
-			 ISHARP_DELTA_LUT_MEM_PWR_DIS, 0);
-
 	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
@@ -1096,7 +1103,10 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		(dpp->scl_data.dscl_prog_data.sharpness_level
 		!= scl_data->dscl_prog_data.sharpness_level)) {
 		/* ISHARP_DELTA_LUT */
+		dpp401_power_on_isharp(dpp_base, true);
 		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+		dpp401_power_on_isharp(dpp_base, false);
+
 		dpp->scl_data.dscl_prog_data.sharpness_level = scl_data->dscl_prog_data.sharpness_level;
 		memcpy(dpp->scl_data.dscl_prog_data.isharp_delta, scl_data->dscl_prog_data.isharp_delta,
 			sizeof(uint32_t) * ISHARP_LUT_TABLE_SIZE);
@@ -1159,7 +1169,9 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	if (dscl_mode == DCN401_DSCL_MODE_SCALING_444_BYPASS) {
 		if (dpp->base.ctx->dc->config.prefer_easf)
 			dpp401_dscl_disable_easf(dpp_base, scl_data);
+		dpp401_power_on_isharp(dpp_base, true);
 		dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
+		dpp401_power_on_isharp(dpp_base, false);
 		return;
 	}
 
@@ -1193,7 +1205,9 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	 *   WB scaler coeffs and toggle coeff RAM together
 	 */
 	//if (dpp->base.ctx->dc->config.prefer_easf)
+	dpp401_power_on_isharp(dpp_base, true);
 	dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
+	dpp401_power_on_isharp(dpp_base, false);
 
 	dpp401_dscl_set_scl_filter(dpp, scl_data, ycbcr, bs_coeffs_updated);
 	/* Edge adaptive scaler function configuration */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
index f030b2a0a1f4..d1a81e5616b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
@@ -166,7 +166,10 @@ void dpp60_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		(dpp->scl_data.dscl_prog_data.sharpness_level
 		!= scl_data->dscl_prog_data.sharpness_level)) {
 		/* ISHARP_DELTA_LUT */
+		dpp401_power_on_isharp(dpp_base, true);
 		dpp401_dscl_set_isharp_filter(dpp401, scl_data->dscl_prog_data.isharp_delta);
+		dpp401_power_on_isharp(dpp_base, false);
+
 		dpp->scl_data.dscl_prog_data.sharpness_level = scl_data->dscl_prog_data.sharpness_level;
 		memcpy(dpp->scl_data.dscl_prog_data.isharp_delta, scl_data->dscl_prog_data.isharp_delta,
 			sizeof(uint32_t) * ISHARP_LUT_TABLE_SIZE);
@@ -230,7 +233,9 @@ void dpp60_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	if (dscl_mode == DCN401_DSCL_MODE_SCALING_444_BYPASS) {
 		if (dpp->base.ctx->dc->config.prefer_easf)
 			dpp401_dscl_disable_easf(dpp_base, scl_data);
+		dpp401_power_on_isharp(dpp_base, true);
 		dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
+		dpp401_power_on_isharp(dpp_base, false);
 		return;
 	}
 
@@ -261,7 +266,9 @@ void dpp60_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	 *   WB scaler coeffs and toggle coeff RAM together
 	 */
 	//if (dpp->base.ctx->dc->config.prefer_easf)
+	dpp401_power_on_isharp(dpp_base, true);
 	dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
+	dpp401_power_on_isharp(dpp_base, false);
 
 	dpp401_dscl_set_scl_filter(dpp401, scl_data, ycbcr, bs_coeffs_updated);
 	/* Edge adaptive scaler function configuration */
-- 
2.43.0

