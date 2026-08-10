Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285C9C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B498E10ECA1;
	Tue, 11 Aug 2026 15:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9gx7Kyz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9E710ECA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqs4EPG7PpQvS1QJzByvq1i1Nb/SaUoGzr9ESUm/w0XUMNmUKRuVxzL/A5EkadRtDm5Tkn7MseMFWr2is1C/cp0Y2CgUGKixdACx508Or77OrhnnpZHiOpNiVHexJZswHCTGNlDBrWpyc2kpmVrZgABZ0GhDIdqTMGlwFpBq3mo3CSBkO/XZb7cPsIuE86mP828sEQ0SLoXmWaQLo+2yqilp0DlvQqzog3UhIrVpD6QaYEN/qw0zsIEEAJVqH95+BHzI/dvwdZeezQFl2GykuC/IZTUhfxoBWhr/vghvwVSpi+wrlBV5zAfHlowZ5f5ECryl7xuFEFWStm661QxijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPNcCzFUivSC6g9fdjj1+f8IOhyTrROk3EpnL5pi3gU=;
 b=KAawRxhPfc6SFuhwuluGawKi3yGSr6thJgNFZkqp0cQVm1vBmtTdHd9Xk90w5+wxwZG5rM3Y3gxnDJaJWdS1LXmy7qASkmQgCtvKaZ92Bd+PEAMVuo+huN5P3KOQezOXFpuu5IoEAouzDl9pcaAC4j4KZJM2bmfN/T6VGKolwYDI/EIuyEJdpZL/OIqnwZzErsXJbVqRiC2oGJwbKnpmhjdzZWHcsusqq3Petl38RLmbAQguczDof+eFV71G7vXwuZm7z0j5tya8f++sqB2JfpFQWTklstEP9aVLpUub+58GaXu500RjH9EwkIcAb/gVOKRo9UWXwSI69kCy8tltsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPNcCzFUivSC6g9fdjj1+f8IOhyTrROk3EpnL5pi3gU=;
 b=L9gx7KyzYG26OtfUWhukePQBwqYKPOwnt+MX0u36JLI34AbkkVbBf02ElKceiPnx8Fc1dBc4yPh3SiTNWeblIymZHg17h98yYyJyBICQMLtkkrcrgQAIOJLjXfG50MKNopyTkD+Uu1z1OY4f6Lfixl3XhUHU0DxulLH2gNkTUy0=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:50:14 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::61) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:08 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:00 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Jun Lei <Jun.Lei@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Add opt-out for DCN6
 OutstandingRequests mode-support check
Date: Tue, 11 Aug 2026 05:28:47 +0800
Message-ID: <20260810213010.1703162-14-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: bd325802-f5a7-44ed-3cc6-08def7c03c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5Ex7dc3dvLdUDSYMa3/b8SQK6OR3iE2emLQuSEFY8HtBChIAInLSD1PmgAVhNCCIq5hFI5fj+48FfkHyMRjw5C/NrzxZOlADjbHV3EJIYQyjquwSu7kwjqeVK9kXADizbKKoYpVbbbH8viEq+xahl3gMoSAM3llL+kPm/2VCJ95gB0j6ud8+O6Yd7CVx8fK2cn2S+EE+RMWz2D/6/0CpUZl6YokesO/1fK3oQHeSVxS7Xov9B9LR/J02UPKHfw3lrLIuqZIrhRzqM37qIvGuFAaAuZJ3Jca5IT8rN5mTsbGy6MExvXP5TDCWpgiIkJ1lT34Eo5Eu0oCK2DzEPMTuh8fHwSMyT7hvGjp6L+K5YZcD/PZiqhaNL5Lc/Hz5yMpe+q5osfqyzyawJuPxWXPk3ltQNun+f+S2534CPuLtDLWvL1Y7CKV19DgUwtdvWE3vXBM48jafxRAABRxNiGz8GFJDVZbZ5H6XF0NZxrCvSCk8xiLlI4klQ15uFiFrqnQDgutPK52tUI3SGPrdY95HfSHecQzYhsfBBBbrmiAwA6RTQ1WKYB8NVeZrx2dRkEcUUkiUmmdU5gEaIC657XhT1iRELIv23LFTSZmv62H1Q3H9+aIiuhs9iNhVkGgzZCWiNzeu/cL15gKz+wx0zLZGwWv5yy4lgYLjKulyuTNqIREdig8XViVpcaC/kNPQNpi1/CLfysantwRpWn0x9B2ZRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3HiTfi9s+Y+pTBR6sb5E8X9RMfI6KUGA8cJTMzxprYwVFldKtgKFB7Q2u+Gf3r0D5+sKjr3V9jJttzoQz0x9YLXPpsSAnifFJm8g1bGlMLj0M4hG1z3g5AxD3Y2LclA8ubahPPECDtI+RcCoaS7CBWnpgJv62W7fgpjh5jLcxxUGYfFcCMVFGfy/DTuLhOH1Mm6X9pAcshg48EoqysbtKjXqvMvpO9UZXz10ZBGRUDqrOWC23vZWiy6+ETr7atcmTR3sJcg5AUZrm4N9u9ixSUXOhZvzIWWsqyeYOP/ZdZE2oBKSmb7cXXQgw9j+uA40mKYsr4fBhlXSDwIbGM3DnlLtWAedkTOoXPP08S7duUcFfkVhzGukHwPcErOeLx8hZeIIbDmh0mo+lpqDQ/tLdo9kt0yH52VFtInI08GGw2iNlwih8y5tvScIy2DWkurA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:14.4816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd325802-f5a7-44ed-3cc6-08def7c03c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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

From: Jun Lei <Jun.Lei@amd.com>

The OutstandingRequestsSupport check fails a mode when the
outstanding-request
buffer window (max_outstanding_reqs * request_size / (DCFCLK *
return_bus_width))
is shorter than the average urgent request latency. Because DCFCLK is
derived
from the SOP's bandwidth, a higher-bandwidth SOP raises DCFCLK, shrinks
that
window, and perversely makes the mode unsupported - so "too much bandwidth"
becomes a failure reason, which defies common sense.

When the ROB size / request limit is not yet fixed, the
SOP bandwidth/latency values are tuned to a family maximum and the check
mis-fires. Add a per-display-config override
outstanding_requests_check_disable
(overrides.hw, matching the existing *_check_disable idiom) that early-outs
the
dcn6 check with both flags left supported. Default off, so existing
behavior is
unchanged. Also wire the flag through the DML JSON translation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h        | 1 +
 .../src/dml2_core/dml2_core_dcn6_funcs_mode_support.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index f402bb933f7d..27ffe7ed11c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -487,6 +487,7 @@ struct dml2_display_cfg {
 			bool mode_support_check_disable;
 			bool mcache_admissibility_check_disable;
 			bool surface_viewport_size_check_disable;
+			bool outstanding_requests_check_disable;
 			double dlg_ref_clk_mhz;
 			double dispclk_mhz;
 			double dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index d83c7eea462b..cb3cff316b0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -2380,6 +2380,13 @@ static void dcn6_ms_check_average_latency_supports(
 	DML_LOG_FUNC_ENTER();
 	outputs->support.OutstandingRequestsSupport = true;
 	outputs->support.OutstandingRequestsUrgencyAvoidance = true;
+	/* An SOP being capable of high bandwidth drives DCFCLK up, which shrinks the outstanding-request
+	 * buffer window below the request latency and (perversely) fails this check. For analysis of future
+	 * SoCs the ROB size / request limit is not yet fixed, so allow the check to be opted out. */
+	if (display_cfg->overrides.hw.outstanding_requests_check_disable) {
+		DML_LOG_FUNC_EXIT();
+		return;
+	}
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		outstanding_latency_us = soc_bb->max_outstanding_reqs
 				* inputs->support.request_size_bytes_luma[k]
-- 
2.43.0

