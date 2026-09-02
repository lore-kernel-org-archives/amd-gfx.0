Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951B0C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA8710EFC3;
	Wed,  2 Sep 2026 05:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mYl7GUw5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9712210EFC3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIeyS1pArPdLf6Zp5xupTYBsgLmXZl2vI99SoyD6WoQERfbmdDDIT7O1DhIFsDlnhX4H/sm93Mw8y+2CPiXkSgD6XzpDKn7EDGT5wsoe/jmvfRFnMH5OkqsuC4HyR80W7aohzMBsb9jLZ9fQgBrk+JzyO80H4+Y9Czhd0Q3poV1XWwmc9Ei4OOk+9zpbQsYQ1BCjPb6v6D4bQDNb+bEoUcnwWEe+LboMl55hn4OsV1bGoxHjPYOhvSzfjghXpySoP4sH2mp4joRQ183u2iTk8ZXTVYyhD1RN7hCqGyny3RuZuy75Sz5Bw9V93XGC8vwYuj48HO4LUqimgXBP2iTX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NabI6QdJ8EoCks9iKQm0+qRKK3umyVYIZX7ZaccTAJQ=;
 b=bpQiHCaLYwupGrSIR7l2dTmXB0iGHyC93dGqotb3CUpprNWCrWkUOQvCXW/jWTsAdNvMH3NeYn9awvcADIuwlGtbRNyd9CXh1yE/+XUoSkocypgPZbIKvMIpo1VuXA5Nk6C6KVXgXpSa5Pyu8QL4KpLfCieOSc79d8SANWw103EVslWufF6q4iC5aD+pQmaE12IPoxkaM6QUtVAJ6UXXQWLGv/TalS+q9BJU4SbjAV80czMWClojEG5Jhsk+EMtJBXLKwg8LiXAZYFaadDhB8A9/sF7Vy4jFMmsiBoyHbiJqEqIe1ly3tkWzpOE+OcYPit9QY8u9IPGdkOtQg7cJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NabI6QdJ8EoCks9iKQm0+qRKK3umyVYIZX7ZaccTAJQ=;
 b=mYl7GUw55aS7aLsuSoBuxTnzMC/9gnC6aDxn8pPzMYoRymU3gXLKEn0a+eHL0BRKUvwojRhtRpyzh/20Lq/H8qUKB3/izww34FIHQ1hS+wzJuih9mM2T2mWoHKtBA8bd7ga6bgwnlGpTAWvsfeogi00a5+5VQZPr894joKb3UH8=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:07:09 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::a0) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 2
 Sep 2026 05:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:04 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:56 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 18/40] drm/amd/display: Add immediate restore to FAMS2 for DRR
Date: Wed, 2 Sep 2026 12:58:40 +0800
Message-ID: <20260902050411.3473916-19-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: de69004a-527e-41d3-32e8-08df08b00857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EZvWniS/kvaTTSlS6o6gw65hwNbnFgY8pcEYFYNxdep+gD0AJ1KpEmmKuZ64MZRdml2mjsrD3PaNRI42dLyQya9mpSy12ebknAO9fsdgiQM9jx1wUSQinA5Ch/oIZuAP0Cu2UWpfwX9OLGmqy88azcCzsfSMAr1NSU8fsGHAUkFR/dwef2ml5QXIJ6MZ3gG+GR8CjP9c9VlqTy58K88q6p0rlC14hGtYbqvjxl093JgIYjNw7q9hFxEcjqI6fFDhbFRpvNAkD1ZyEYXZF8aeRSgh9H4ca9xzJz6wTt/R7eaAya6x9fFsj05izVQOkuhYnYw1PNw6K2LgC3q9g6PsvZhUhL4MWYT6fu0LwOfMwC+O86SGS6BWerPsoWtXak4iKTTKDhrjv8CchYkbxntw5XDmaqZpTiGQ/jqJc6JWn9HG7uHg5+ejcJ2/HbcObdpU4bS8oaGMhlZSfBDBE2iTU3KbekZaj4jGDsuC1ByHW0BFL0G6XaZOCsqYASSLNoC1ekUqlr4Sf7e5w02P2ogki/URPoveZrB9uU61gIq1X4/J9no3L+qJJ6VbVSm/qqijxJC08KsJBPpRhb2oHJIXY99KeqK92CDTiEAurGizrLH9m7eOZdEYldwoyDIzVF3e3jbcG+mRsEI0+AqTpgjUJHyLJbtxEHbCzgzwtD7WQXc9Get+N2mF+EvjGeP6Zdi1SMXRI2Nsa1zTrUEIl3MJ7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4HKaf3D7SKyxaiimRG4O57cGe1IbYIM3c2QY6l17a/KpFc56KiJObFx2zRMDTCrBj1Ss1vUlqB9NCWG5WQ/wxPmRyvyFYrcwhdFcDwiVIW4ZwyuG6YQTRpGNyN5Vt5gu5q4xBS+L9/ltd9EA/apHr9BAngjPObekPFpEgzMWvXC/jvKsUlBusQXLZutSHGU3dsCRThHIbdf2RH/2gEKXrXnXqi2ahjUwE4lrJ/WS5XyWni+0fUGGhkAmD7WKgvFhgKCijz6ErsISgGGcfztuAAsVovoy/gPqjZYEyiUBItVzfzO/zMQ8YtW0KTxZvJAseHH2m+08v5OM6LLwq8E8xY+KOO03SRF2kEAgA+2gnjm+8JFCOtGx6uRcthSbK8DKerRjhbOW6XPEyw4dHmSniUAhrQd9j2hiPcISlMQHPUlyMZUla+E5H3Gtj2m0phN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:05.6703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de69004a-527e-41d3-32e8-08df08b00857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693
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

From: Dillon Varone <Dillon.Varone@amd.com>

[Why & How]
Adds toggle to immediately restore FAMS2 streams instead of waiting for
DRR VTotal changes to latch

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c      | 3 +++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9f64bea15ea1..8879196b2675 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -711,6 +711,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
 	adev->dm.dc->debug.ignore_cable_id = true;
 
+	/* temporary enable immediate restore for FAMS2 */
+	adev->dm.dc->debug.fams2_imm_restore_drr = true;
+
 	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
 		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e1f1b0602b6d..4b85727aaff9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1288,6 +1288,7 @@ struct dc_debug_options {
 	uint32_t dml21_disable_pstate_method_mask;
 	union fw_assisted_mclk_switch_version fams_version;
 	union dmub_fams2_global_feature_config fams2_config;
+	bool fams2_imm_restore_drr;
 	unsigned int force_cositing;
 	unsigned int disable_spl;
 	unsigned int force_easf;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 143facdbde54..d08dd372179c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1847,6 +1847,9 @@ static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 			memcpy(&stream_sub_state_cmd->config,
 					&context->bw_ctx.bw.dcn.fams2_stream_sub_params[i],
 					sizeof(union dmub_cmd_fams2_config));
+
+			/* temp override */
+			stream_base_cmd->config.stream_v1.base.config.bits.imm_restore_drr = dc->debug.fams2_imm_restore_drr;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 105a0f8762e8..a4043c5f22ea 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2777,6 +2777,7 @@ struct dmub_fams2_stream_static_state {
 			uint8_t is_drr : 1; // stream is DRR enabled
 			uint8_t clamp_vtotal_min : 1; // clamp vtotal to min instead of nominal
 			uint8_t min_ttu_vblank_usable : 1; // if min ttu vblank is above wm, no force pstate is needed in blank
+			uint8_t imm_restore_drr : 1; // does not wait to latch DRR vtotal on restore
 		} bits;
 		uint8_t all;
 	} config;
@@ -2809,6 +2810,7 @@ struct dmub_fams2_cmd_stream_static_base_state {
 			uint8_t is_drr : 1; // stream is DRR enabled
 			uint8_t clamp_vtotal_min : 1; // clamp vtotal to min instead of nominal
 			uint8_t min_ttu_vblank_usable : 1; // if min ttu vblank is above wm, no force pstate is needed in blank
+			uint8_t imm_restore_drr : 1; // does not wait to latch DRR vtotal on restore
 		} bits;
 		uint8_t all;
 	} config;
-- 
2.43.0

