Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B640AC001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620D310E4AB;
	Wed,  2 Aug 2023 06:52:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B455610E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2TzjtW51sBZMTLdBrvJr8BtDbhySA8+rsGwRwP8kL/gBYyXI+1C1Qm+FJOQFpDMyfYvyrixX9NXs1xd6wlTDC45yv8//tfVYglTwwFv24/zHAzGlBEPzBlVSilyFAAXfBTvF5VTMvlss8cv9XmYGZwH/D7s4hSBWWmBCz2n2C/iRQi9qb0g9rfQB0cdncC3cO0AsG069G0dlAh5fJc24vF8nsJFnteMBk5igSb3SQ6emnyorg2m8L8vLd7BJ1XOIprXz5bZaXUdHztCqhXAlNjQmKDEPJqF7HuD/5m2oNQ4Zj67lqWYc9XvAq9QFiJPF/nXGH1RPEZNO2D+pC5XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNF3XgUsTBaxmKaoHD2oDZ+PP7nBGrUzLc1VjWgUDn4=;
 b=kajan4e+5dp456yG+G7m7atawuL5QcrbK84MgHaEZ2Yddat4zzBdnhjaKAw/j9lDumnTlHr4HWcS+tasuDQVt+4f1LHv5oRU8OtOBsykNytEBBQQb83IWKdbuoY1JP2wtStUOJDJSb1/ME+lfXFoeeIX5756HbpNRhbIa6SVRTfk+LObNuD1wnBRdLrhk0hgR89Kg553t5HNYR5HO8mXyfiI92ibhQgmb0QD8bYjtdCcxyQ6YxKi1m3J4/VV1zzazCgoWFjKhQ5TOLXi4c4Xgv/nQmWMd2CytfB2Qx/R7fYt1VVg3knOErTguOOKI3pR8ujHImnac21J+6F8K5WMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNF3XgUsTBaxmKaoHD2oDZ+PP7nBGrUzLc1VjWgUDn4=;
 b=2FxbDZsMWOs1bHTt8iO9Tlf0k+/hg8D9NiNdfSTuZicpRnN0E4N6pz0PCdPF/wLssmNAxlimMf/K2DUgWsDd33Cj5ANgSXOJqUSHh2teD9xh5WKIxbF/PjcwqGN8RfXPp0MQOs2H14vS4PzbyBCNopY2Ao+3N/730wB8oI9CNE4=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 06:52:23 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::f4) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:52:21 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Make mpc32 functions available to
 future DCNs
Date: Wed, 2 Aug 2023 14:51:15 +0800
Message-ID: <20230802065132.3129932-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 71932fc1-2321-4f06-b490-08db93250623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDzHceIgdidbn6TJmuJnGlcNfdYB+DgVsrzABLiJPXoPPqXFGJuPIMc1uyDA983mLiNtTHrIxZvvDbN1mGKRo0kB2DBzJfMxSAHNsKZvF2qUtOG/HGh54F5pZweIfoP1M+5RDZxEf/UM+9RBNxR1yiW0gNWrlFPt3sMQKm7T31msJUPDpNqeNn8cKXKEkPdb+wSa0MtrFilE78pf80+0/0UyhKmDoGKK2DEk0hOqC/gAbq11plxCh14gAurJsbUABUJKhGXFo47ezomUObHdSZ9vJULlAlBdcskISoaCFpxWZiD7v82+RV0N0nhID8dzB8a3X4eFW7ct/lWZ2o67x9EWnqtjApPvGSKEBcNZv1L0nh80HxiKIMmkC/IdWUg3s/qa6TvkDmCaqmjUqNLF/zhpCTFsyxILK6YmHnfgIUFhdnjYYATe8x1eyP0zdAhokGzDsKbWhM7QdSD+DjCnyhi00ZRwzoypINNnpxKDIA3Lj9cq6YfdgyFbONFY1XeVBU+Id92vbt3i8qsJbwIrorWfaK3IpPd/GPDtuLTDrohVXgbGpqzlQxZCm7gCStKT2pkDFaOFCJBiLTNNG5mrrZapRczRWDZV8VbwhCYutQczBJglyfmdSIrGqoD4ttGM1LwzwmWzI+2+r4L/P9IFTA4WRC5QvjMov8fc9fqXAHqSIpiohZ/+SWjj6iHz97UNTx3Wy5glIn74QWee8JzfX00p3p8/GVB7Wm4vR5lDUezFJJZPVowLwMqKVFxjEjLM3ymJkel/JA2s7Z58K5WVuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(36756003)(478600001)(6666004)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:22.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71932fc1-2321-4f06-b490-08db93250623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Wesley Chalmers <wesley.chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <wesley.chalmers@amd.com>

Make the mpc32 functions available for future DCNs to use

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wesley Chalmers <wesley.chalmers@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  | 28 ++++-----
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  | 61 +++++++++++++++++++
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index c8041cfd594d..3082da04a63d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -64,7 +64,7 @@ void mpc32_mpc_init(struct mpc *mpc)
 	}
 }
 
-static void mpc32_power_on_blnd_lut(
+void mpc32_power_on_blnd_lut(
 	struct mpc *mpc,
 	uint32_t mpcc_id,
 	bool power_on)
@@ -120,7 +120,7 @@ static enum dc_lut_mode mpc32_get_post1dlut_current(struct mpc *mpc, uint32_t mp
 	return mode;
 }
 
-static void mpc32_configure_post1dlut(
+void mpc32_configure_post1dlut(
 		struct mpc *mpc,
 		uint32_t mpcc_id,
 		bool is_ram_a)
@@ -163,7 +163,7 @@ static void mpc32_post1dlut_get_reg_field(
 }
 
 /*program blnd lut RAM A*/
-static void mpc32_program_post1dluta_settings(
+void mpc32_program_post1dluta_settings(
 		struct mpc *mpc,
 		uint32_t mpcc_id,
 		const struct pwl_params *params)
@@ -192,7 +192,7 @@ static void mpc32_program_post1dluta_settings(
 }
 
 /*program blnd lut RAM B*/
-static void mpc32_program_post1dlutb_settings(
+void mpc32_program_post1dlutb_settings(
 		struct mpc *mpc,
 		uint32_t mpcc_id,
 		const struct pwl_params *params)
@@ -220,7 +220,7 @@ static void mpc32_program_post1dlutb_settings(
 	cm_helper_program_gamcor_xfer_func(mpc->ctx, params, &gam_regs);
 }
 
-static void mpc32_program_post1dlut_pwl(
+void mpc32_program_post1dlut_pwl(
 		struct mpc *mpc,
 		uint32_t mpcc_id,
 		const struct pwl_result_data *rgb,
@@ -321,7 +321,7 @@ static enum dc_lut_mode mpc32_get_shaper_current(struct mpc *mpc, uint32_t mpcc_
 }
 
 
-static void mpc32_configure_shaper_lut(
+void mpc32_configure_shaper_lut(
 		struct mpc *mpc,
 		bool is_ram_a,
 		uint32_t mpcc_id)
@@ -336,7 +336,7 @@ static void mpc32_configure_shaper_lut(
 }
 
 
-static void mpc32_program_shaper_luta_settings(
+void mpc32_program_shaper_luta_settings(
 		struct mpc *mpc,
 		const struct pwl_params *params,
 		uint32_t mpcc_id)
@@ -486,7 +486,7 @@ static void mpc32_program_shaper_luta_settings(
 }
 
 
-static void mpc32_program_shaper_lutb_settings(
+void mpc32_program_shaper_lutb_settings(
 		struct mpc *mpc,
 		const struct pwl_params *params,
 		uint32_t mpcc_id)
@@ -637,7 +637,7 @@ static void mpc32_program_shaper_lutb_settings(
 }
 
 
-static void mpc32_program_shaper_lut(
+void mpc32_program_shaper_lut(
 		struct mpc *mpc,
 		const struct pwl_result_data *rgb,
 		uint32_t num,
@@ -671,7 +671,7 @@ static void mpc32_program_shaper_lut(
 }
 
 
-static void mpc32_power_on_shaper_3dlut(
+void mpc32_power_on_shaper_3dlut(
 		struct mpc *mpc,
 		uint32_t mpcc_id,
 		bool power_on)
@@ -789,7 +789,7 @@ static enum dc_lut_mode get3dlut_config(
 }
 
 
-static void mpc32_select_3dlut_ram(
+void mpc32_select_3dlut_ram(
 		struct mpc *mpc,
 		enum dc_lut_mode mode,
 		bool is_color_channel_12bits,
@@ -803,7 +803,7 @@ static void mpc32_select_3dlut_ram(
 }
 
 
-static void mpc32_select_3dlut_ram_mask(
+void mpc32_select_3dlut_ram_mask(
 		struct mpc *mpc,
 		uint32_t ram_selection_mask,
 		uint32_t mpcc_id)
@@ -816,7 +816,7 @@ static void mpc32_select_3dlut_ram_mask(
 }
 
 
-static void mpc32_set3dlut_ram12(
+void mpc32_set3dlut_ram12(
 		struct mpc *mpc,
 		const struct dc_rgb *lut,
 		uint32_t entries,
@@ -848,7 +848,7 @@ static void mpc32_set3dlut_ram12(
 }
 
 
-static void mpc32_set3dlut_ram10(
+void mpc32_set3dlut_ram10(
 		struct mpc *mpc,
 		const struct dc_rgb *lut,
 		uint32_t entries,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
index 2c2ecd053806..9ac584fa89ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
@@ -332,4 +332,65 @@ void dcn32_mpc_construct(struct dcn30_mpc *mpc30,
 	int num_mpcc,
 	int num_rmu);
 
+void mpc32_power_on_blnd_lut(
+	struct mpc *mpc,
+	uint32_t mpcc_id,
+	bool power_on);
+void mpc32_program_post1dlut_pwl(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_result_data *rgb,
+		uint32_t num);
+void mpc32_program_post1dlutb_settings(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_params *params);
+void mpc32_program_post1dluta_settings(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		const struct pwl_params *params);
+void mpc32_configure_post1dlut(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		bool is_ram_a);
+void mpc32_program_shaper_lut(
+		struct mpc *mpc,
+		const struct pwl_result_data *rgb,
+		uint32_t num,
+		uint32_t mpcc_id);
+void mpc32_program_shaper_lutb_settings(
+		struct mpc *mpc,
+		const struct pwl_params *params,
+		uint32_t mpcc_id);
+void mpc32_program_shaper_luta_settings(
+		struct mpc *mpc,
+		const struct pwl_params *params,
+		uint32_t mpcc_id);
+void mpc32_configure_shaper_lut(
+		struct mpc *mpc,
+		bool is_ram_a,
+		uint32_t mpcc_id);
+void mpc32_power_on_shaper_3dlut(
+		struct mpc *mpc,
+		uint32_t mpcc_id,
+		bool power_on);
+void mpc32_set3dlut_ram10(
+		struct mpc *mpc,
+		const struct dc_rgb *lut,
+		uint32_t entries,
+		uint32_t mpcc_id);
+void mpc32_set3dlut_ram12(
+		struct mpc *mpc,
+		const struct dc_rgb *lut,
+		uint32_t entries,
+		uint32_t mpcc_id);
+void mpc32_select_3dlut_ram_mask(
+		struct mpc *mpc,
+		uint32_t ram_selection_mask,
+		uint32_t mpcc_id);
+void mpc32_select_3dlut_ram(
+		struct mpc *mpc,
+		enum dc_lut_mode mode,
+		bool is_color_channel_12bits,
+		uint32_t mpcc_id);
 #endif		//__DC_MPCC_DCN32_H__
-- 
2.25.1

