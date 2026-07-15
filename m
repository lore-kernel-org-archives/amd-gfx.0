Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DAC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8DC10F0AC;
	Wed, 15 Jul 2026 13:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PfVRU1wK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C2410F0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJVjy/3H4K69fYeZK3wq4sLmcg4UkvKK43hU+KqUl29d/ZD0CBejozcCGbhVAGL6Xot1DKu0KqJm+fnWo0I7J2G1mf+pvHio0nHT3YwvrdzPjcyYr5TMv0PBgMuzkvmfjcuoVHwqMbw0GbZ2pc75xfODteO9FrZfxtThCX61AKThx4xvr2zqnK4pX8ijNlm+i991MtLxauQb/Nv7qv79NeVvvFzLAoM+EMC29wEp6lGkI0cNHuIwleP7g3Muo/7MwJZoFfaVGb4XeJ9M/fgI6w7xiTN/MHWO6ddCushdINDCuxlcc3KlYIHzS6blZmoCddjo2/afuSFa4Z0f4Tm5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDUisUm1TWXZKvGqdbteh35UKHzb55hzy+b4AjDiJbA=;
 b=nEPUTJ1k3/mHpBlQm6wDrX5IrmEw2uZq8SQWUU806DKuvvj7f0CpLA5eumvx2yNgHY0cGqVPciylqgetCjpxIzpvJz7S2kZUP8VMdHiiV0+0aj5HmH6iOp7lJfj/VwG7McB8hIqOsH0uGSJsSe2VYHaUwWDnxKc+qYa7aoxUCJ6VEj1stQLSDfYm1iHZmXH6z5mCZoBa95zf0cLJsGxLMjyWgXZrOw8nZiw5t9hyuFyzP9jvCPPODUMgWhIeFkb5rr5E7KfYjfvYmOXMdXSf/JZjWgsnn4luXyKlcMKdmBvhc+rizkWaiQPoceY1Rf0CfxzmYt3LPobawtzJYJc2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDUisUm1TWXZKvGqdbteh35UKHzb55hzy+b4AjDiJbA=;
 b=PfVRU1wKxhZ70INOU6xQdoiM7GgKaQSDkAvrTrVsvx28d2mzNZEf7pDvPwx6KTzWYm47vaNxqNyAoDhMw5n276SKllSO6X9MraI3Xwbi2535R8ndsofqbARELcbN6/Bny2r6pa8f4PFW3EnXgJELLIts+39V+Fcz5r8CR4jdYIg=
Received: from DS7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::12) by
 CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Wed, 15 Jul 2026 13:48:42 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::55) by DS7P220CA0078.outlook.office365.com
 (2603:10b6:8:259::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:40 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 60/70] drm/amd/display: Register DCN as a PMFW DF C-state
 client on DCN42
Date: Wed, 15 Jul 2026 21:38:10 +0800
Message-ID: <20260715134432.1975118-61-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: be58a567-4d03-4f5d-25f0-08dee277c832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qG5pZUtmRBhmqKKkbhQCCtggyRZSEo0+ueRCISIvPx3ev0lXUW0h7qE8Tao0Tflm/wP0Gpp7yhF8Hv+sW5mfjKrlNhbRh6gdUiqLHndn48Ox8cVu8zzg+L2jSNwyb+bh76Z55ES3r12bqR9gTWhf0Ue7z54E1nqLKPICKpn4KaDbO2ZsqETwDU1hZ5CXmzksRmyjpv5thsfvOHceA+nMtlKawduGyfT2I2ie7hu1lPxMLkOJNNrqJoInjqc0JsWKJwwWunGU0mc5Ia9crjTb2l5yllsMYFh0c5PqQ5kgepHH6iuly7w385ovJmf/yygx6GDSUeyWpHIeOdHUQIrwvWaeWiEqiTDUjaEJo6wIs/1PaldqmArpm2S+SYccOjrzp8tIh0gG74wVx433TRYx4zOFzFfikzQZyrKHGqXr7attLMexS3bleqSPXquCUrPf2rnUFIzTHLAkSuISy+fTiMJAEmRuawz8sUEN61gWKsh/bDCWhTRHpsDDE52gIjngZYyIRmG3MIXFQSBYk3HiGYjtCrdYZqRVlQOTOqghC4OaMoppcsQ8QOSe95YKl6Ufi0V1KAhskt97VmEeUyz4EB7sf3Alka9Mp4ydcoq03+B0DqRnFypfIdcfc89/fKAMIB898dGiyJesdTq7534nCYrYwNwZsNJ74hsxcpefOfwAoQ3fIXV00AzzzFSewd8p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BJZM9MJn8s8z5qFOJsAkDQ5Y5q7fHVZ5R7PxYbbDoqnQX9NA5/dHtGcBgYDEBd/+bGWogRUII+WdHtT9C6cZ9mUDj2hgpnYW1EKwkCSuYFnbRizyUv4OsvqMXrBFuhvvTEvaCizBrbjMS5Y7jvUeQNF87TjP9ILjSCbth24ugUApb3VbDl/smJCDygRav7APjsO3GJgaD62DMuIzHFpNyFlHKiqkm9BajYAttUBD4zos+sniJyS6j7ooEZJ2KxcqXmcmwvqLEgJ8NV+nJXoQ38sD9V6mNcpn117RV3/jXxqsWiZTWpxx4XB4Sc4YLdvvnIIln6TgmnbXBTLN/fRbcM0ULne3eGRoSJKZYEtffM/FQ5O2phAZ45VwtWmIQfIepdpdcIGC1WhsvTxyR8a/3TWqUWgeeXlv97vQn8CKM4RVVspJCT5j0ZoogHRr4TsR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:42.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be58a567-4d03-4f5d-25f0-08dee277c832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

From: Leo Chen <leo.chen@amd.com>

[Why]
DCN must not gate DF C-state locally via the DCHUBBUB ALLOW_SELF_REFRESH
controls: forcing a local "disallow" during MM-stutter re-entry can wedge the
fabric and hang boot. When DCN is disallowing c-state or has invalid watermarks
we should be explicit about it rather than using the watermark force selector.

[How]
Register DCN as a client of PMFW's DF C-state arbiter and signal over DALSMC
whether DCN permits DF C-state; PMFW allows DF C-state only once every client
(including DCN) has voted "allow".

- dc_clocks.cstate_allow: last DCN vote acked by PMFW
- clk_mgr_funcs::notify_cstate_disable(clk_mgr, disable)

prepare_bandwidth and headless dc_power_down_on_boot vote Allow;
hardware_release votes Disallow; init_clocks
(D0 entry) only clears the cache (cstate_allow) so the next allow re-syncs with
PMFW.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 28 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |  1 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  | 29 ++++++++++++++++++-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  9 ++++++
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 10 +++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 10 +++++++
 8 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 3baac7fa313a..c7b9bad93a93 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -375,6 +375,24 @@ void dcn42_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	dcn42_smu_enable_pme_wa(clk_mgr);
 }
 
+void dcn42_notify_cstate_disable(struct clk_mgr *clk_mgr_base, bool disable)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	bool target_allow = !disable;
+
+	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+
+	/* Idempotent: only send when the cached vote actually changes. */
+	if (clk_mgr_base->clks.cstate_allow == target_allow)
+		return;
+
+	if (dcn42_smu_set_df_cstate_disable(clk_mgr, disable))
+		clk_mgr_base->clks.cstate_allow = target_allow;
+	else
+		DC_LOG_WARNING("%s: PMFW did not ack DfCstateDisable(%s); leaving cstate_allow=%d to retry\n",
+			__func__, disable ? "Disable" : "Allow", clk_mgr_base->clks.cstate_allow);
+}
+
 
 bool dcn42_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b)
@@ -594,6 +612,15 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 
 	init_clk_states(clk_mgr_base);
 
+	/*
+	 * DF C-state policy
+	 * D0 entry must NOT send a PMFW message, but must unconditionally clear
+	 * the cached vote so the next allow-side transition (prepare_bandwidth
+	 * or dc_power_down_on_boot) is guaranteed to issue a fresh
+	 * DfCstateDisable(Allow) and resync DAL with PMFW.
+	 */
+	clk_mgr_base->clks.cstate_allow = false;
+
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
@@ -1038,6 +1065,7 @@ static struct clk_mgr_funcs dcn42_funcs = {
 	.get_max_clock_khz = dcn42_get_max_clock_khz,
 	.get_dispclk_from_dentist = dcn42_get_dispclk_from_dentist,
 	.is_smu_present = dcn42_is_smu_present,
+	.notify_cstate_disable = dcn42_notify_cstate_disable,
 };
 
 struct clk_mgr_funcs dcn42_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index 9568ca06f00f..330242747fff 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -67,6 +67,7 @@ unsigned int dcn42_convert_wck_ratio(uint8_t wck_ratio);
 extern struct dcn42_ss_info_table dcn42_ss_info_table;
 void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_watermarks *table);
 void dcn42_enable_pme_wa(struct clk_mgr *clk_mgr_base);
+void dcn42_notify_cstate_disable(struct clk_mgr *clk_mgr_base, bool disable);
 void dcn42_notify_wm_ranges(struct clk_mgr *clk_mgr_base);
 void dcn42_set_low_power_state(struct clk_mgr *clk_mgr_base);
 void dcn42_exit_low_power_state(struct clk_mgr *clk_mgr_base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
index 6d0012b7d6dc..5e8d979f25f0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
@@ -85,7 +85,8 @@
 #define DALSMC_MSG_DispIPS2Exit                 0x11 ///< Display IPS2 exit
 
 #define DALSMC_MSG_QueryIPS2Support             0x12 ///< Return 1: support; else not supported
-#define DALSMC_Message_Count                    0x13 ///< Total number of VBIS and DAL messages
+#define DALSMC_MSG_DfCstateDisable              0x13 ///< DCN DF C-state vote (PMFW FWDEV-193711): param 0 = Allow, 1 = Disable
+#define DALSMC_Message_Count                    0x14 ///< Total number of VBIS and DAL messages
 /** @}*/
 
 
@@ -428,3 +429,29 @@ void dcn42_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
 			enable);
 	smu_print("%s: smu_set_dtbclk = %d\n", __func__, enable ? 1 : 0);
 }
+
+/*
+ * Vote DCN's DF C-state policy to PMFW. param: 0 = Allow, 1 = Disable.
+ * Returns true only when PMFW acknowledged the vote (or there is no SMU to
+ * talk to, in which case there is no DF arbiter to satisfy). On a non-OK
+ * response the caller must NOT update its cached cstate_allow so the next
+ * transition retries
+ */
+bool dcn42_smu_set_df_cstate_disable(struct clk_mgr_internal *clk_mgr, bool disable)
+{
+	int retv;
+
+	if (!clk_mgr->smu_present)
+		return true;
+
+	retv = dcn42_smu_send_msg_with_param(
+			clk_mgr,
+			DALSMC_MSG_DfCstateDisable,
+			disable ? 1 : 0);
+
+	smu_print("%s: DfCstateDisable param = %d, return = %d\n",
+		__func__, disable ? 1 : 0, retv);
+
+	/* dcn42_smu_send_msg_with_param() returns -1 on a non-OK PMFW response. */
+	return retv != -1;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h
index 8ba7ff04dc05..10c67326ff7e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h
@@ -187,4 +187,6 @@ void dcn42_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *cl
 int dcn42_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn42_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
 
+bool dcn42_smu_set_df_cstate_disable(struct clk_mgr_internal *clk_mgr, bool disable);
+
 #endif /* DAL_DC_42_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 318c3b28e918..24a01e07a44c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6544,6 +6544,9 @@ void dc_power_down_on_boot(struct dc *dc)
 		if (dc->caps.ips_support)
 			dc_exit_ips_for_hw_access(dc);
 		dc->hwss.power_down_on_boot(dc);
+
+		if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
+			dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 743dde3d10ab..fcaa17b9ab1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -759,6 +759,15 @@ struct dc_clocks {
 	 * Elements below are not compared for the purposes of
 	 * optimization required
 	 */
+
+	/*
+	 * @cstate_allow
+	 *
+	 * DCN's DF C-state vote as last successfully acknowledged by PMFW.
+	 * false = DCN does NOT permit DF C-state;
+	 * true = DCN permits DF C-state;
+	 */
+	bool cstate_allow;
 	bool prev_p_state_change_support;
 	bool fclk_prev_p_state_change_support;
 	int num_ways;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 4376bf26f4ce..151a29bf0e9d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -946,7 +946,11 @@ bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 }
 void dcn42_hardware_release(struct dc *dc)
 {
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
+		dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, true);
+
 	dcn35_hardware_release(dc);
+
 	dc_dmub_srv_release_hw(dc);
 
 }
@@ -1082,6 +1086,12 @@ void dcn42_prepare_bandwidth(
 	}
 
 	dcn401_prepare_bandwidth(dc, context);
+
+	/* valid C-state watermarks have now been committed to HW, so it
+	 * is safe to vote "allow" to PMFW.
+	 */
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_cstate_disable)
+		dc->clk_mgr->funcs->notify_cstate_disable(dc->clk_mgr, false);
 }
 
 void dcn42_optimize_bandwidth(struct dc *dc, struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 68dc2d4ba7ca..ec678bd249ef 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -412,6 +412,16 @@ struct clk_mgr_funcs {
 			struct clk_mgr *clk_mgr,
 			struct dc_requested_memory_qos *qos);
 
+	/**
+	 * notify_cstate_disable - Vote DCN's DF C-state policy to PMFW.
+	 * @disable: true  -> vote "disable"
+	 *           false -> vote "allow"
+	 * Sends the message only when the cached dc_clocks.cstate_allow would
+	 * change, then updates the cache on an OK response (idempotent no-op
+	 * otherwise).
+	 */
+	void (*notify_cstate_disable)(struct clk_mgr *clk_mgr, bool disable);
+
 	void (*build_clock_update_for_bls)(struct clk_mgr *clk_mgr,
 			struct dc_state *context, bool safe_to_lower,
 			struct block_sequence_state *seq_state);
-- 
2.43.0

