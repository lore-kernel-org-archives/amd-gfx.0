Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9164C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F6F10EB0F;
	Tue,  8 Sep 2026 11:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXoE5AxX";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD5E10EB0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylq7BEN9FKymR806fstXdGUuv2J0jM1N7xEYOipfILRQy6eifkxpO24z+eqpBQxHf7u0833QofzB6HmYFVnbZmIJnWP/ifYNl2Nz2tFtBDV1HJ4v4VRcPgGTUMOSoleLgxiuOLDmpPMsLtq/hMDZdfmmg/P4ty84jDT8jvfUYm7hSvPdokpvzpcP+sUZzjyR+omEcnOiR0MJ2BNHQMn2RdTlDKnLPAdKz2c3PEw2UQvYhB6kQnPLKTNekuBWO7kz/S30u+rXOtgr/FUDnQpVJBvj/YgtF2OoctHLqiBxyWih4PUB425H7iQKacaJ5wCqMPUh7J+FAPAKdO6fsWmj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsIEkq3h4O/pvAj1zhurqfsKkVAuJIeikQIWJSpLwmw=;
 b=j3is8YeIeYy2iafQ4dRKnhBWB5uzKUG7YA/9KkK2GYe+Z6ctwGPzov6MPIIJyIqCi2ZFInLpjQ6S0QV2bs8nKETWffGuaO/H8mfyGbhWU1ulwK4VWxLMGjRI1XkELVO4qP90cvbqfuSNXgTsS8wm83bpvrjO5hSpuSSQehmMYFAirQpmmZmbWEzTzEa55txaRzO7dh50lCtoof5U9PZ/fVWZrjt4bHfmKPmrSdzc3ZUzoftqrTOnb5nsWgX9mRR3DKqevogC/JiDZhOPXwxLxlUIE+e5zS5V30xZpJp+VgBn2XAM2BYr80WZMgOVYd2tOFExwyxjXAvnwoHHUZ/I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsIEkq3h4O/pvAj1zhurqfsKkVAuJIeikQIWJSpLwmw=;
 b=nXoE5AxXuXC9UIWlw6oWxw9HIy0hlTT6rLh5wTmvV7npLtHYO6lK8kxgvQ/xrnxV3CFq2QhEBAB+Nkzudn62Po6rw+FgKNxAHbEgp1fACET4+2XODRm/2tMXMoKooD2cqJPT5UE8GmK97DfV8JBacn9uuxei1eFKqawqIHS4mZY=
Received: from BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:34:35 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ac) by BL1PR13CA0348.outlook.office365.com
 (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:21 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:13 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Leo Chen
 <leo.chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 04/66] drm/amd/display: Remove SDPIF_PORT_CONTROL programming
 for DCN31/35/42
Date: Tue, 8 Sep 2026 19:30:57 +0800
Message-ID: <20260908113338.2433445-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 74198f2c-adab-4b53-7239-08df0d9d283b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|30052699003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: bkb6fweWm4tvB9b1y6m+E+t9SoUh+a6NQg1hV+nAzgoZfSN71p33KHhxtmlj2MxJY5y9ZsfvrsTp+oRtT+MPn0+DcxLcuJAyPaLAGylJ1QHj4YL8go1MoSIwvWWKEqy1ZnXblBReN6nxdz38X/ceh92Z85FnQHlegvArAc3xpIw+N0Lw1WDD9tXDP13hziOrzQP64ek2Rtsuvn44lP3UzrMG7egWMZ1xZQWSPMN2KvZOozXzV2VLdjOqj2vI4FiiwtPO7Wzq8hJxv0IBEX9GT459A12CwMxS1ks9sAmvgVJtzICFBsjtXzlLXeHy0dUlG1UuXmEO9Qf1+DeA2QrkBLFWIpbDQDY+qpPND96MXJ/erAVVmmGdqIEWuL/X+jsuFZzIW5fIJIOft/2WVAkTZbr6ctSZZKy+kUce5qx8RmGcX+bcJm8MH8YZJHdNuBeW4o+4+ZQnekdkp4HRnqY+DeP/UWuY71PfiG9kDfedDJfkzc5FiqTqZYo1FZ6KDpYAxXXeMqC7XqOhspDLpYUpcKThLNLT3pJFDyUzKA32X9blUwLR28vnzz7csaXV/4tyfztE3IpZRSwjzmq2eIDF7Qxc2IyzKbY8oYD2Fmxak0W0YoGZGcn/F9pzljitRvKiaKnRm+teVlVwv3O5IPxaEF1mg7PhoNAPK7Mv+OoxtiktXG3GCN2jyCcnkyuAH/GLB9Z34Uc3xUDhgzu9Y+3Rpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(30052699003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /eoe4SLi7kG5HifpGaYY/WzWNsHVtUGwl5cE2pKnWVjnxeRuqFY3EfydTGZgH7uVBZpxP8knDaQB9AT92YRtej3vo/+ZRmddilKT8V486Q3sDBlEN6C9C3FeSibKQ5CYgoFbKEsTvN0HREMTdMwJlsfXLYs7oXzCdMcD6ge3MnDx45ggRNDAmJhHrsILkR/wy5LEAihoJsru9phPBtGQPPU7GMFmYySFUIjlRaI7wYfVifRc7T7ile3ar/ifPsqFvE1easLDvkUkykw+TUNibrjR9r/GIAO71+D9VDw5umE7kHx3MLQl1PXkCfp/SVgHFIldOrSf/54dXXGDsr4S7e2iveB/4AlMRZAaih47gglA/g9TOcQD9O+ZunsTLBj7QM9GiN8sAbEtMNQ8ImnL6StXZAOsY4tZLjWkjYYt+6OUNRxTSL0rxJf2Q1pSyMPs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:34.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74198f2c-adab-4b53-7239-08df0d9d283b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
DCN IP team recommends SDPIF_PORT_CONTROL=0 as POR value for APUs.

The new POR value ensures that DCHUBBUB will not disconnect the SDP port to DF unless it explicitly
receives the pre_cstate_req signal. SDPIF_PORT_CONTROL=1 will only be used for IPS entry sequences,
where it will be restored to 0 upon IPS exit.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c  |  5 -----
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c  |  7 +------
 .../drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c  | 13 +------------
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index cbcd22789013..35c94ca8335a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -1048,11 +1048,6 @@ void hubbub31_init(struct hubbub *hubbub)
 				DISPCLK_R_DCHUBBUB_GATE_DIS, 1,
 				DCFCLK_R_DCHUBBUB_GATE_DIS, 1);
 	}
-
-	/*
-	only the DCN will determine when to connect the SDP port
-	*/
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,	SDPIF_PORT_CONTROL, 1);
 }
 static const struct hubbub_funcs hubbub31_funcs = {
 	.update_dchub = hubbub2_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index 53744b000f5d..466bab437e37 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -531,12 +531,7 @@ void hubbub35_init(struct hubbub *hubbub)
 	hubbub35_set_fgcg(hubbub2,
 			  hubbub->ctx->dc->debug.enable_fine_grain_clock_gating
 				  .bits.dchubbub);
-	/*
-	ignore the "df_pre_cstate_req" from the SDP port control.
-	only the DCN will determine when to connect the SDP port
-	*/
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
-			SDPIF_PORT_CONTROL, 1);
+
 	/*Set SDP's max outstanding request
 	When set to 1: Max outstanding is 512
 	When set to 0: Max outstanding is 256
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index ddfc60e845a4..71bc926c7035 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -431,13 +431,6 @@ static void hubbub42_allow_self_refresh_control(struct hubbub *hubbub, bool allo
 			DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_VALUE, 0,
 			DCHUBBUB_ARB_ALLOW_SELF_REFRESH_FORCE_ENABLE, !allow);
 }
-static void hubbub42_set_sdp_control(struct hubbub *hubbub, bool dc_control)
-{
-	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
-
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
-			SDPIF_PORT_CONTROL, dc_control);
-}
 
 static bool hubbub42_program_watermarks(
 		struct hubbub *hubbub,
@@ -449,9 +442,8 @@ static bool hubbub42_program_watermarks(
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
 	if (!safe_to_lower && hubbub->ctx->dc->debug.disable_stutter_for_wm_program) {
-		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
+		/* before raising watermarks, stutter must be disabled */
 		wm_pending = true;
-		hubbub42_set_sdp_control(hubbub, false);
 		hubbub42_allow_self_refresh_control(hubbub, false);
 	}
 	if (hubbub42_program_urgent_watermarks(hubbub, watermarks, safe_to_lower))
@@ -478,9 +470,6 @@ static bool hubbub42_program_watermarks(
 
 	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
 		hubbub42_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
-	if (safe_to_lower && hubbub->ctx->dc->debug.disable_stutter_for_wm_program) {
-		hubbub42_set_sdp_control(hubbub, true);
-	}
 	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
 
 	return wm_pending;
-- 
2.43.0

