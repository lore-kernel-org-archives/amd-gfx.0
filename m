Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB8C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE7110F1EE;
	Thu, 23 Jul 2026 20:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nve3xL0F";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA82910F1EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl619pY3/lEIs1y3IUCKVGeMvTpWdLdXNvjgpHZr+jH8G4UrtOjmZ9s2B/WKT+8c1z5z8apAkMZG5RQxPf72rjarH2sVRTVH1pF8OU1MTUl7epQvcxJEHGYT0L9vxAPSQUthK7+Jgr5Kx0YK69g97lbwsp+v0USHI2JsC6NYsrMDPZIiQxHssLKQvfSYrhZtMqSJNaC8jQlsE71Js+SlJD4+jwou0WoqSsh7fwJmZcbln/cYxDHGQWPJKl3pj1ECagMVKlVcrgXeg3hpwPSFKUnOkkyD1/FhfC3h3yOJSyGsJhXEExriYP5NH26QIUceG3PAb1WMcw/8g46azEanyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E8KL7ZDcsuO41HNy09LmrKm4/11pg0F5kn9KxcPDrk=;
 b=Q7p963pWt/b8A6XXUIGz4WCfPK+1yGqzxgW7evae7Xyi8L4wcEWGvDl1OSV32sTRjwQED2QkGc72/Ta8TlpliuEf0zzh+8dH4sMTTQCirLYJE1ayOmLCmZIiA7WyNM4eaPBjm0HFGlYeeonvsE4jpEKpHbINm3/rALdHKzGypNDDOjdU8xVBKqlmaf72qTuvcqkC4q2w2J/ocAhhvun8eau+74BZYA37Re7kJWP3B+tmB2T7kf6UoZJH11UhoqNiEsct4x8EHML0Pa1SnL7Db9GX30cbvNhw1sG5cB3ukOb1xND+gGFwKf7Diww0uQFNW0E3SecRJB5mr+7OPsoscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E8KL7ZDcsuO41HNy09LmrKm4/11pg0F5kn9KxcPDrk=;
 b=Nve3xL0FzWVMuA9I1ECArFwqenwzL8mXZ1VCpgt1RT7c3MpIttLRWhHFB4COz0GsTqD9dFOH2Z2X/sKqh6w+L4q0uxw2bUJvygDH9vZcf+6msFGZB7+iKQb8E+EpPoSLCBCg/vZRgA8a4sccRgOF1rgJ3iKqiUrV3pAuRzWc3Cg=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:48 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::61) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:48 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:18 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 40/49] drm/amd/display: Fix divide-by-zero in
 calculate_mcache_setting on zero viewport
Date: Thu, 23 Jul 2026 16:13:48 -0400
Message-ID: <20260723201908.373300-41-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 97416dd4-1660-4664-d0dc-08dee8f7be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 1stMmuGubTh1iVBwHyf+ZPQ1soNPyYb9FZ1L8LLlE4GyORuCpN8qrSLPQpaxF30V78cedfHMdVqVN5xHg6sfaUZMPa5okJzQACuStDzQGdO8fvzjNuy6gk8e4qsq+rmH1crDLLxH1fIZyKKkVrvtGYEfJJwGnIE7Uf/GyJzpZxAetMKpa3eq3QcHSN2J7bB6UCEgv/YdfPkXmntseWcPDooyQrCuocTAKl/gj0fR9Ut1ucz37VmXI9CT5H1UlvShyFNoPCxRDO8mfr4bEZ8c3+D3q36qowA5WLV7MA03FyZ6pjh4Z9Snb0vJtfu4e+E3NiZUJAnxG9B2dLzaIwrraqe7EpsNCZ1hdyM/ksUjPGEyAxQUfI2GrZQHuOCvYCO4efRLwayfH+xNjtdwMGpuMz2ufHvJqua0RImp2IP5mw5mr5MrlTvveXX8Jr/HCYs/2ZB6+jMiw8nRCzeHPiHAELMG/ajj3jFa3Zs1Jc04bDai+nIakWjflU9Or6Cj9aa91QEcXl1vpOPaT5b+8naQANJM/cGKZjePdgCBxZB1wp5j2Qq8tGXvo0UVIg7C5fT4Y9ldfHfTGAhGrT5I/LK07j4uaHO4CVaKBYlPlxCMQrUDiRRxqPKG2RuFwWeEwRxNUDexU8IjfWFVp1KeQQuZGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zEPnANdXFZse9ggGJKJgNfOdWj71xwiz9bsFU3m81Ot61ecPF8+//6Tk5USWs2+0vAZTth/Etk1K4/UIIUI8KdtA4rUQUEe7vdc1Vmv2lpPhOSUyNtW4yfMKogjIf1kMmuVGiYPdfG+Ktxq66DppmzdC2OwOfs3NBx5QY9sHiC9xho6ymGS+nLW8YUozObvOpxlYzVB8wut2TOMciIKDHNZ4hQPKN8hh3XCfJqM5V94BnN24+RO9szNlPV5Zw9n4CBbku84rUVzz6TlB3lKnRXEQmeSYosjEyZeBR7Dc+X+uF4Xyff1E9l4Xjh5aDEYIn88USl0nRHE03Z6QBB7hcrGN8Is4iqyIxaGXTBRhR+0XMiMt6FxaWsIgN9VCqgysOgVRt4OHJ63IQ2ZRaIMPrAV1swxO1iGvPVpW23krVbgqfK/JZIQNh7qjFSa0Tsv1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:48.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97416dd4-1660-4664-d0dc-08dee8f7be65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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

From: George Zhang <george.zhang@amd.com>

If a plane reaches calculate_mcache_setting with a zero-area viewport,
calculate_mcache_setting exits early with num_mcaches == 0 and
mvmpg_width/height == 0. This will cause a divide-by-zero panic and can
also cause an underflow on num_mcaches.

Fix this by changing calculate_mcache_setting to bool and adding guards
after each calculate_mcache_row_bytes call. If num_mcaches or
mvmpg_width/height is zero, return a false. Callers will propagate the
failure as a rejected mode, which prevents the panic.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5302

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index fa78016b32fc..110ab26a6a39 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2453,7 +2453,7 @@ static void calculate_mcache_row_bytes(
 	DML_ASSERT(*p->num_mcaches > 0);
 }
 
-static void calculate_mcache_setting(
+static bool calculate_mcache_setting(
 	struct dml2_core_internal_scratch *scratch,
 	struct dml2_core_calcs_calculate_mcache_setting_params *p)
 {
@@ -2479,7 +2479,7 @@ static void calculate_mcache_setting(
 	*p->lc_comb_mcache = 0;
 
 	if (!p->dcc_enable)
-		return;
+		return true;
 
 	l->is_dual_plane = dml_is_420(p->source_format) || p->source_format == dml2_rgbe_alpha;
 
@@ -2516,7 +2516,14 @@ static void calculate_mcache_setting(
 	l->l_p.mvmpg_per_mcache_lb = &l->mvmpg_per_mcache_lb_l;
 
 	calculate_mcache_row_bytes(scratch, &l->l_p);
-	DML_ASSERT(*p->num_mcaches_l > 0);
+	if (*p->num_mcaches_l == 0 ||
+	    (p->surf_vert ? l->mvmpg_height_l : l->mvmpg_width_l) == 0) {
+		DML_LOG_VERBOSE("DML::%s: degenerate luma viewport (num_mcaches_l=%u mvmpg_%s_l=%u) — mode not supported\n",
+			__func__, *p->num_mcaches_l,
+			p->surf_vert ? "height" : "width",
+			p->surf_vert ? l->mvmpg_height_l : l->mvmpg_width_l);
+		return false;
+	}
 
 	if (l->is_dual_plane) {
 		l->c_p.num_chans = p->num_chans;
@@ -2552,7 +2559,14 @@ static void calculate_mcache_setting(
 		l->c_p.mvmpg_per_mcache_lb = &l->mvmpg_per_mcache_lb_c;
 
 		calculate_mcache_row_bytes(scratch, &l->c_p);
-		DML_ASSERT(*p->num_mcaches_c > 0);
+		if (*p->num_mcaches_c == 0 ||
+		    (p->surf_vert ? l->mvmpg_height_c : l->mvmpg_width_c) == 0) {
+			DML_LOG_VERBOSE("DML::%s: degenerate chroma viewport (num_mcaches_c=%u mvmpg_%s_c=%u) — mode not supported\n",
+				__func__, *p->num_mcaches_c,
+				p->surf_vert ? "height" : "width",
+				p->surf_vert ? l->mvmpg_height_c : l->mvmpg_width_c);
+			return false;
+		}
 	}
 
 	// Sharing for iMALL access
@@ -2662,6 +2676,7 @@ static void calculate_mcache_setting(
 
 	*p->mcache_shift_granularity_l = l->mvmpg_access_width_l;
 	*p->mcache_shift_granularity_c = l->mvmpg_access_width_c;
+	return true;
 }
 
 static void calculate_mall_bw_overhead_factor(
@@ -9490,7 +9505,10 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			calculate_mcache_setting_params->mall_comb_mcache_c = &mode_lib->ms.mall_comb_mcache_c[k];
 			calculate_mcache_setting_params->lc_comb_mcache = &mode_lib->ms.lc_comb_mcache[k];
 
-			calculate_mcache_setting(&mode_lib->scratch, calculate_mcache_setting_params);
+			if (!calculate_mcache_setting(&mode_lib->scratch, calculate_mcache_setting_params)) {
+				mode_lib->ms.support.ModeSupport = false;
+				return false;
+			}
 		}
 
 		calculate_mall_bw_overhead_factor(
@@ -10969,7 +10987,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			calculate_mcache_setting_params->mall_comb_mcache_l = &mode_lib->mp.mall_comb_mcache_l[k];
 			calculate_mcache_setting_params->mall_comb_mcache_c = &mode_lib->mp.mall_comb_mcache_c[k];
 			calculate_mcache_setting_params->lc_comb_mcache = &mode_lib->mp.lc_comb_mcache[k];
-			calculate_mcache_setting(&mode_lib->scratch, calculate_mcache_setting_params);
+			if (!calculate_mcache_setting(&mode_lib->scratch, calculate_mcache_setting_params))
+				return false;
 		}
 
 		calculate_mall_bw_overhead_factor(
-- 
2.53.0

