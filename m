Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F9CAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4170610E3E3;
	Tue, 16 Sep 2025 19:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4oTNhiU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D59410E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQZTQkADjdEfJSHt4fGWSBcseZ3fIwU1zyN5WRAIGPaWWOaZ1jtQ14a1qNje0oj5uS/SHXE8ijrLF+vPIuMw5NRtfAz0nyXsLay2T6rX3rzAa7HLcERn4gA99NO2cdS00y/oS/EJkT6VC1N6mVSCXeh8LXXWWof69Ny1WmeEjUhPqbpeZ0tuFN/IdUxI9lsIz7gtRaoVHycGMcRBm6RYQVydyai+5YF4CMBR9Z0nMl2aFsgeovA5EM9nc8al11w3FrK4F6pZ1LzgBXddXlaJqe4vJU4Y5cB/+L8sEHXuCntKqHor4ePss+IM9EkGEnFttzZIz4WpGf3WoybcWngDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdxtTm0I/VhvMl5tDoay83eEh6cBJMDP3pc63vQvh6Q=;
 b=rmC5ylCLDh/GZDXZPnXgF+VJtDzEHn6C0WfQm2RRdUqw2v2CQTowV1yAr8Kf27h2V5ea+/4GvVPyM3cjk+M68T/wOne/MvklCNcnNQJviI/EE8foXsvOoIfvJYeRfRfOjHrM9z7bCTYX4CIjd0YZhB7/dn0c/bAUAHL+sDEeJvtvJWdaLcHllOSmRNmepDlzNrNKIGqMLyPOYFF101zYMoB3E2gngbWt5ksf2s4FWUbGDYbQjv5+9xBQyKzVBKbmUXGyoZZo81nnowd0gZAISqT3ks3kh3uFybYsMqMU/L/FS8T3OLOp5hsQkevZKxFe1qF0er++8rPhL4JEGctLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdxtTm0I/VhvMl5tDoay83eEh6cBJMDP3pc63vQvh6Q=;
 b=j4oTNhiU4dkqJuAvubu7BS/6nBM434XH1nK4++i7xWKXaS+veX22WTMfKi6LNXhJdc9JuWJCDV9wT3f6fyHhsIlCjbDH1xlPjabV5cevNlzR3NX1UFq6N/5w+kHsZnNu/FkhNBLby7KGXNg7vaZk+e6ZNJMwzQ1+kKp9Bx5VNCE=
Received: from BL1PR13CA0331.namprd13.prod.outlook.com (2603:10b6:208:2c6::6)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:09 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::aa) by BL1PR13CA0331.outlook.office365.com
 (2603:10b6:208:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.10 via Frontend Transport; Tue,
 16 Sep 2025 19:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:07 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:07 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:06 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>
Subject: [PATCH 01/20] drm/amd/display: Disable stutter when programming
 watermarks on dcn32
Date: Tue, 16 Sep 2025 15:09:21 -0400
Message-ID: <20250916191142.3504643-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: be2faf60-1637-4d52-bacc-08ddf554ee97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|30052699003|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxhbBXa+CAOCO5u8U/ar6FHfWyJn3bOyxEDvGtuYc/a16rn09y6XrgMT69ye?=
 =?us-ascii?Q?lqt3i9N3BrP5mAxp1mr0ZHtX5PmHbhwV6SqwyChXCunzLrU4OJKlPiOPA0/8?=
 =?us-ascii?Q?qwa/8TDPKnhocGG2BxJaKL+2msotDmOgpKucoihIS2TT1jD9gwJz77YL4RJV?=
 =?us-ascii?Q?y7Y14GZ8bp+SN6zANnfz1bBoagjrprFN9J0f2ekuGkcZNcnv1/XWQmbVwCSG?=
 =?us-ascii?Q?iRBebtFjsbRnAw3SoKw9WPpewiZaPc1JurP2l+8FhaeWLEYnreBndB96sl56?=
 =?us-ascii?Q?zg3zkT1xIbIzLCNrBeIZkzJ7e/SL989NyiuF34ognlUGTQsU0jn/CQSICI9Z?=
 =?us-ascii?Q?/Fs43Gr10n8a7VbooNbf0XR8d2JrtEseS2rZElw1GVL6VtkZraliGPaR73QK?=
 =?us-ascii?Q?56TMhNPQ57HtT3uButubYxArbGNpwOanBUhBNJxW/DhRl5YL5Ciu55SjG7fs?=
 =?us-ascii?Q?gs2VhDMhI6Cr6gnJn4kl//A60fPsAWYPP0OKw6EnDJdvP1KA91Wgwf2wZB5c?=
 =?us-ascii?Q?tn5oWDIgZ2WQjcVIcO+lKDAU+s9KyJIjM7ZktDI6DWtDyKESA6OGmN+T+Jqo?=
 =?us-ascii?Q?lMIZJwofeEUtALlzijYbbh4yd4QeOltfLew+hDsFfWklfw7sGO6v97hZ879g?=
 =?us-ascii?Q?idkBDXTuUbiVFrIEl4N9gjX2N+TBjad5MzAPhmyY7xE9FXwmbNA73GWhLYq5?=
 =?us-ascii?Q?wneNPFYj73HVn59ZuDMFUNQZC9PuZeTEHoEc9eFvPdm/DbVnIsCQxKztFRMG?=
 =?us-ascii?Q?LW2Nmgb9ArWu/421MIjtBwKWZ7aveBF6Aec3reXQZC1X9tlmY82DAqqv4YWt?=
 =?us-ascii?Q?LHiGEd9qphzT7HbtDzbnN8E8m7y4yN9+zOH15jIi064UzuFXVLU6shlNGeDH?=
 =?us-ascii?Q?t8P5kNxoWU33SUgGwV2WiQS3f6Zz6N4gXTLCeb2P+EZjJCVfi0cssXesqQYE?=
 =?us-ascii?Q?lxzcFkwCKegu5hC5ynrnBJvZiOsO8eoQxYm1/buXcsydH4UGIZ8WRYH80zLP?=
 =?us-ascii?Q?3kPNuSbzGE6NbFlc3RWfj6p5g+t7YJa2ee0aFshC6xBw4JwA8sK3pOpIqHEk?=
 =?us-ascii?Q?IKJDWZraVv8FqZVVJ8x3oW8lXRQwrN2uTjqj73D1B4dBSgjhbhZ9SsxfUF85?=
 =?us-ascii?Q?oUWVbegmkyEtGmizTHb3EszcdXLUhcZrKbq7zG8ep51nCPFkNeeKA4lFZ0q5?=
 =?us-ascii?Q?QhV1VuzNv6vMoSV/jraJtNOOZJjT0NmypwAMWeuCjblzaf27Ntwmdqtl4SfF?=
 =?us-ascii?Q?fp2LEd0JInKTzsK6Ne14oOqWROTs4960GYvQFW9l4yC7z55rFIqiNrzFZmz8?=
 =?us-ascii?Q?jGKa7YwTfCWSfVF0ZHwNlmtMeaCoBI9YrMI6bxLF3oDUK+3DmdfJeFfK1Da6?=
 =?us-ascii?Q?5E37/Ezb61upTNFKY9X4Ge4hM8CcE23NWiAdSXtURvDFI2wvjDk/CQY/Lrwk?=
 =?us-ascii?Q?Huhl4oXAVS0CQ0q+3rj+uwL0grWh899V+EC5QwpyRLJfVpfkX+YSko1j5S/H?=
 =?us-ascii?Q?+sT+Tx+0CR+RTPjSTbvdHSk37TmOd8Q0vwnW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(30052699003)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:08.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2faf60-1637-4d52-bacc-08ddf554ee97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

[WHY&HOW]
Reprogramming watermarks with stutter allowed can cause instability on
some ASICs. Disable it prior to raising watermarks (prepare bandwidth),
then re-enable after lowering (optimize bandwidth).

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    | 37 ++++++++++++++++---
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8bee44cd4609..19c74f56aa5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1163,6 +1163,7 @@ struct dc_debug_options {
 	unsigned int auxless_alpm_lfps_t1t2_us;
 	short auxless_alpm_lfps_t1t2_offset_us;
 	bool enable_pg_cntl_debug_logs;
+	bool disable_stutter_for_wm_program;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 92957398ac0a..3b71bfaca291 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -28,6 +28,7 @@
 #include "dcn32_hubbub.h"
 #include "dm_services.h"
 #include "reg_helper.h"
+#include "dal_asic_id.h"
 
 
 #define CTX \
@@ -72,6 +73,14 @@ static void dcn32_init_crb(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
 }
 
+static void hubbub32_set_sdp_control(struct hubbub *hubbub, bool dc_control)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
+			SDPIF_PORT_CONTROL, dc_control);
+}
+
 void hubbub32_set_request_limit(struct hubbub *hubbub, int memory_channel_count, int words_per_channel)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -754,8 +763,17 @@ static bool hubbub32_program_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
+	struct dc *dc = hubbub->ctx->dc;
 	bool wm_pending = false;
 
+	if (!safe_to_lower && dc->debug.disable_stutter_for_wm_program &&
+			(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+			ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+		/* before raising watermarks, SDP control give to DF, stutter must be disabled */
+		hubbub32_set_sdp_control(hubbub, false);
+		hubbub1_allow_self_refresh_control(hubbub, false);
+	}
+
 	if (hubbub32_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
 		wm_pending = true;
 
@@ -786,10 +804,20 @@ static bool hubbub32_program_watermarks(
 	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
 			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0x1FF);*/
 
-	if (safe_to_lower || hubbub->ctx->dc->debug.disable_stutter)
-		hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+	if (safe_to_lower) {
+		/* after lowering watermarks, stutter setting is restored, SDP control given to DC */
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+
+		if (dc->debug.disable_stutter_for_wm_program &&
+				(ASICREV_IS_GC_11_0_0(dc->ctx->asic_id.hw_internal_rev) ||
+				ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev))) {
+			hubbub32_set_sdp_control(hubbub, true);
+		}
+	} else if (dc->debug.disable_stutter) {
+		hubbub1_allow_self_refresh_control(hubbub, !dc->debug.disable_stutter);
+	}
 
-	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+	hubbub32_force_usr_retraining_allow(hubbub, dc->debug.force_usr_allow);
 
 	return wm_pending;
 }
@@ -974,8 +1002,7 @@ void hubbub32_init(struct hubbub *hubbub)
 	ignore the "df_pre_cstate_req" from the SDP port control.
 	only the DCN will determine when to connect the SDP port
 	*/
-	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
-			SDPIF_PORT_CONTROL, 1);
+	hubbub32_set_sdp_control(hubbub, true);
 	/*Set SDP's max outstanding request to 512
 	must set the register back to 0 (max outstanding = 256) in zero frame buffer mode*/
 	REG_UPDATE(DCHUBBUB_SDPIF_CFG1,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 8f80ccb846d7..3965a7f1b64b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -739,6 +739,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
+	.disable_stutter_for_wm_program = true
 };
 
 static struct dce_aux *dcn32_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 20d714596021..99f0432288b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1230,7 +1230,8 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
       SR(DCHUBBUB_ARB_MALL_CNTL),                                              \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
       SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
-      SR(SDPIF_REQUEST_RATE_LIMIT)
+      SR(SDPIF_REQUEST_RATE_LIMIT),                                            \
+      SR(DCHUBBUB_SDPIF_CFG0)
 
 /* DCCG */
 
-- 
2.43.0

