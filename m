Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02114606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X2HykhZV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AC010F8EB;
	Wed, 11 Nov 2026 01:43:15 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB04410F8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE0F5QIBQpJS8j3k9fZLEjISkKzJsGNIkgmM5x4REJCDbxTC6mO3QmU1YWFzHfVFm3rsvGzRUtsUJttReEAZS5lsh6mFlqVxWpaQQ5D9acv/031xqXYGJ6kRUwYl9OCdSlUfr05Kbr6h7vq7D/kZ/W2ByBfqfTq5Bdzi29VAb+lrQPVirH4ZlQNaZXKLssMXe7k0KXUQ5M3QBa6tFkt+hq2BTI2cHGr9BSlu5mTCxo1EcdcC46+c7CNYg2Bl7y3WwNIrpPW4Cn4iiAFtdAwTztQUKT9WspjJ8jQsUc44a+gQma+ikh0AESLRYgks2AdtY9QBrL8SBDKpVHAeunaCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmJIvItpcP+EmkZcnkzW3U9W0VDPteNznoIk9X31k9Q=;
 b=gEzkvjyqQQ8oUem3oIfs5xbaxKeLqgVVYxsnaXexglNZJxixqLLKy4BxznxcfrVtlM9CntjilWhi2GH1zF5fPwY4EV1bQa4GONo7nux/VMypkjzmEauNk0himT1m3ln/Ud56vC6AQxdt7z3KJiJp+SthaO2s0gO6/8ytNRApJ6/H726spF/1yO4Fc1Ei1vYDvczavCEBXjvU1NvHpKs/sQXJ6GPn2h3xxDWTiP4TIEMeBs7r1ueRF//KpGOpD+IrTLcqceiIcRrCztrVFfwj/gVPnc9zp9vCMaYScglX/NrwIAQCG3ocYOyNKkuScgbPkBKo2c0MNvFaQ6w/cMsArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmJIvItpcP+EmkZcnkzW3U9W0VDPteNznoIk9X31k9Q=;
 b=X2HykhZV9dHd5iVu9UrgYvKdDjkDd9GUGKz6I9VnGEJdERqdcJPoXLGxML7BlA8Jv0UU/5TKQz9H7dJ31TbQVWgeShK/9lWLR6uw0lnxrQE1EOqPk/L0RSeF5f00XSTy5K2M61da/GQTp+SZR6zZD4KRd/rWsYGon/Edra8hNq0=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:43:02 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::5f) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:00 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:57 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>
Subject: [PATCH 40/74] drm/amd/display: enable DF C-state vote on DCN42B
Date: Wed, 11 Nov 2026 09:28:46 +0800
Message-ID: <20261111014100.3596072-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 876eb35a-7603-47d9-ae59-08df3f951f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261021121427099003|56012099006|261026121527099003|261021123027099003|261102123227099003|261022113327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: RkUReI7YQjZNu579iJpxKMBOf4vi2z3NIUtuCO1SOLIYOohqPlDDpiTahZHcUdoQjop1V1B+h1/KrIec0d0k5LdJ2sAA1Q5E6iHEPRdmCg+gWv4RZnJGe7SVs30JcteBPT+vV+YB9Fa9/wpdaHX/d2ZEqxaOCIx7FgtZPAoH4FMmNQ4UUBHEwi5fJCukQ5ySOfDdC4CQDZQUIq0W76FOtTSI1MesGLCrduHYg+TuZ7vfdJABRn1KoP89kXJ8SyvDVTAclBcNNBuVVY16gov244kB/QYnXMsBbxC3LMM1iKu1VGzK6jdc/VrwT0K8Ub5YokSp0/P7K/bLx4Fv5GejdCE9vHNI64Z5BWykG8BHg1nnfjPT3fW2InB5CAP47F55588AObhW+q4bg8nc7/iM17dYfKg4kefGV2wWOIIQJJYnNGFWcXPzEbWmWyqnKu8OZ4Ka/1l19oOyGV1jzCS0gwVTQKsJPdrnazPIncVk8Cel9P0VYa9BYqDKECAUI42CONqJu2IoZkdZm1hAQ1A8tdIc+M37+noBFeAjWhQ3KlGTCSEtDvhpDxKFBC3ZUNF5u6moURpRMtDss3VE0x29nzN+Oqn+gnxs3cESxOzMDdLHOpF3jJK5CW6M2g7hhSkqm1p7zfGfTHUd1EKu+HbAVJt9T6/iIC5GDUSlOENDrL0+yDpOLZRmQJBTGQgWtywLlBPWQlnbXYR0YPnQXa2tZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261021121427099003)(56012099006)(261026121527099003)(261021123027099003)(261102123227099003)(261022113327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vxJlKyapYVoa9iXYqWdLwpkb/RrOpvgSo26seOOWE9SjcVyw6lGoPGlgkuilhu1fwK22XSu2XjumcvfV9fSWb0Yx1tVkkXNIxpQCm2lMy99CWSiQKxZVvrfBFy6OHke9KL+I+v/WIBGHpLIvcJdsBH7kONOz8UemaaJN22ryGyS673fn5hDsFvIq9jCgyULoy8YE5e7ZHrqATryu1RjpOU0JzlAPkAGTNDNpsfpWz5LUjyRlTyjiZmIBECG6esw1hmaGvOYsVqTu8+S2z5e8d32/sODcCTDHGXWsBiEtWOiGDIN30r6OR+fgBy6PB8I+3By9uDrMSbYSx72lhqh8bmVB2ti1EAx3JZBOXm7ivXRFmYmKFLUteSXgMuRWWQ6WfUrHg8VI8MutJ5qxqJ6JXt5n4cIykx9bczkj9WsDFbOVWvO7FyQpUK4xgevo6vxp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:01.9095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876eb35a-7603-47d9-ae59-08df3f951f71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

why:
DCN42B shares the DCN42 hardware sequencer, so dcn42_prepare_bandwidth,
dcn42_hardware_release and dc_power_down_on_boot already try to vote DCN's
DF C-state policy through clk_mgr_funcs::notify_cstate_disable. The DCN42B
clk_mgr vtable never populated that callback, so every one of those call
sites was silently a no-op and DCN was never registered as a client of
PMFW's DF C-state arbiter on DCN42B. The PMFW side of the contract
(DALSMC_MSG_DfCstateDisable) is now releasing, so DCN42B can join the
arbiter instead of relying on the local DCHUBBUB watermark force selector.

how:
DCN42B already reuses the DCN42 SMU interface, so no new PMFW plumbing is
needed - only the DCN42B clk_mgr needs to opt in:

- hook dcn42_notify_cstate_disable into dcn42b_funcs
- clear dc_clocks.cstate_allow in dcn42b_init_clocks so D0 entry resyncs
  DAL with PMFW without sending a message, matching dcn42_init_clocks
- record the newly shared function in the dcn42b_clk_mgr.h reuse list

Also reword the DF C-state comment in dcn42_init_clocks, and its new DCN42B
copy. Comment only, no functional change.

No behaviour change for DCN42 or for DCN42B parts without SMU, since
dcn42_smu_set_df_cstate_disable() is a no-op when smu_present is false.

Cc: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  4 ++--
 .../drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c | 10 ++++++++++
 .../drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index d125ea196cb2..b1fbadd0d885 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -628,8 +628,8 @@ DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 	 * DF C-state policy
 	 * D0 entry must NOT send a PMFW message, but must unconditionally clear
 	 * the cached vote so the next allow-side transition (prepare_bandwidth
-	 * or dc_power_down_on_boot) is guaranteed to issue a fresh
-	 * DfCstateDisable(Allow) and resync DAL with PMFW.
+	 * or dc_power_down_on_boot) always issues a fresh DfCstateDisable(Allow)
+	 * and resyncs DAL with PMFW.
 	 */
 	clk_mgr_base->clks.cstate_allow = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index e18d705103ba..57291c10c917 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -233,6 +233,15 @@ DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 
 	init_clk_states(clk_mgr_base);
 
+	/*
+	 * DF C-state policy
+	 * D0 entry must NOT send a PMFW message, but must unconditionally clear
+	 * the cached vote so the next allow-side transition (prepare_bandwidth
+	 * or dc_power_down_on_boot) always issues a fresh DfCstateDisable(Allow)
+	 * and resyncs DAL with PMFW.
+	 */
+	clk_mgr_base->clks.cstate_allow = false;
+
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
@@ -433,6 +442,7 @@ static struct clk_mgr_funcs dcn42b_funcs = {
 	.get_max_clock_khz = dcn42_get_max_clock_khz,
 	.get_dispclk_from_dentist = dcn42_get_dispclk_from_dentist,
 	.is_smu_present = dcn42_is_smu_present,
+	.notify_cstate_disable = dcn42_notify_cstate_disable,
 };
 
 typedef struct {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
index 52ab87cdc7b6..ae871d43dbcf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
@@ -13,6 +13,7 @@
  * - dcn42_get_dpm_table_from_smu (identical, only SMU calls)
  * - dcn42_are_clock_states_equal
  * - dcn42_enable_pme_wa
+ * - dcn42_notify_cstate_disable (same DALSMC DfCstateDisable message)
  * - dcn42_update_clocks_update_dpp_dto
  * - dcn42_update_clocks_update_dtb_dto
  * - dcn42_build_watermark_ranges
-- 
2.43.0

