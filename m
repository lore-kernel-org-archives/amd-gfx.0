Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62223CA6007
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B8F10F6FB;
	Wed,  7 Oct 2026 17:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CF/Nt7SQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92A8A10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3a8i38OUX2j01ZvdVmbR4IEyGBTOHTcpD5q5FYwr6VTauhPCsBYvfrrvgflOhmcZKi8YyqQhslK78x4mEq/1GN9jCNkSgTIRALAOB3feNtx6TTdpK+h2B0+U5HQTtofi5eQs+LVe/b4InTJS7f8iuPDHnyviJhTdVe55L4gJmiy38ONI6t3v2xCXiVSu0nk0fo4TNHY5yFHb1Fe2xllE1a0YKUYNT63WOt820jgCzkulk6a58VtKS/4tl1B9agfYQzCTQj1QKzwiH+f2FbETF6uDNmr+WH/FspXzRGdS2SZ2F6S/NC6+K4649l8gMCvwgM/chUcYJ2UEgzvxHesRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhfT37P1h1yDHkiNiPWJSqMDl24uIUa/X5Hk2/Dgf0Q=;
 b=QlZlC7NkOFlBhYHVP+/rMS0m/0eTbDGWapQpnsNxqcupSWQP4CWIwOzkGDMNZ3Qkt+rIwj4Km1bkogE9kt/qIs7B4+jMTp+8E4cocAxrhoM/A0WWVv0+yLWYODfhb4ZXvozGhBjM6Zf92vIwS3gAb/PoxDGwaC4Y965OXB0sFmygH0NkSBT8X65p2vS6QV9UEHr/QTM+D4WD0J5HFdMMoUn5flYtFMYpEIKfK5D/pnT/LIY1bL/p0WenKnjq2HQsQHDsyCDqG/1QawCHf2x2XAxl16AEdXWe9MYzq3cXQZLUlFYQkm/GhIyTmtzptydfa9leYrbRTiL2E7F+z0qCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhfT37P1h1yDHkiNiPWJSqMDl24uIUa/X5Hk2/Dgf0Q=;
 b=CF/Nt7SQ+RJzM6BzC0AYI6maw624zI6F26/FEgQNbSXtw/c/NynsUB1gWZatXmlD8cskks7iqYIZrXsnYpLEeU+GjrXzZ/e9P226Nma/PsnDprRzjQtHjutkjIAqe8eHG8qSMK/3TWqOss0gsOzg3FO3vY7og77pgZOWXg+65iE=
Received: from YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::21)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 17:04:34 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:b01:83:cafe::77) by YT3PR01CA0136.outlook.office365.com
 (2603:10b6:b01:83::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:29 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:29 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Josip Pavic
 <josip.pavic@amd.com>
Subject: [PATCH 11/19] drm/amd/display: Invalidate the DRR shadow after a
 hardware re-init
Date: Wed, 7 Oct 2026 12:59:44 -0400
Message-ID: <20261007170412.1898315-12-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 17089f7b-1efd-4091-78f7-08df24950ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|56012099006|5023799004|11063799006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: XazHsdbAaOoQ7ypX3yz/GJfFGZjLQjEdo01UymxSi9lkKGuAVqS+D5X+GYeQ+GH2IH5IpbtSy21059VogVbKKlDaw87RNLbExtoohQCtFd42sEchMB8k1+1ZAhJ6OfACbDLHK+kTMTqHv1MCoa8f6pKPwpukLuOCpWV6blIg2dOkcNqSo8YEVJHFxM8f9vPc2ivc1dvgGDKgykn+5X/Z2Bitc09ohl8pwAJMd6o1XBsqbO+ZtsHxgoHGioyuAxLthqkUqZVR9yNIuzR3kNKOzIfps9Rfl4sajdIfb7Lb/WcAz7kuHnKxRDMl3/vxWTPGrYJxMekSvVOQFBIPcgzvY0Q5WqR5ebeuB0BC2d+DHZHKKJT4ug9FGou8Gzbz6+0nNiHBP6ivKugINclNjxfkp3YPWzLKEymPnYOVYBZOP1D3z0pkFdW3JPUybxRg92H4vJsIqmvrPbF35P9Bdjq/8PtKNC5arAZNXs4+0jZT2IoD1G1BaMawisYxcPKtEYG40AdyM0bXUpSBaow3QOXKMZVkb8N1Nq0KYXCzyOKKJlc/MaFymE5CE5U863I4uQpm1zN7UEUfQZ4rloM634DFaGK1Tr6PnWxYemM+9cDmnm/HilDiOdJpis6/RKlnv5Q7AzVOEJARPgQEqgjlo7x1y3dVOYYGxm0QaGK4u2PoakuxtV00mObBTOxUQ5vRv4lA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JcpC+0P5e8DJJFSAERrGOtIhpys4X1yHt9is6sFEGu5KgVlKId4q29xBV/5JNU4UaWa8vlCoZUWdLkydcKf6OFQ8NAHcHPnRakQDJApvYHBxBluwwNKUXnmrpume/SO5etv6LZdR5M3UHt9zq3dKcVhTFhASdXQZgHZTnMVHDmrCbh2/EBUm7fcjTQSGZ7xZJoKwuYdQA0JjaPiW0ZCHDv3kjWODYCTEHWTOFEQu47az/sImtSVHh2B7k+/sItuTaiMREUs51mCq64dVPKs/SSDBiJ1zoqEX/nV05gsjWIOr5OJshvOKBJ8XwdyehNAoF/iFJu8xlqYRJnbzPSruWkrQSe7m2dFoACozpQBo5pIDp1UDg8iOjKV8IYQox0ESyfxvnI0kT5jpB9xntCbZsFUWynOwAKvxKtH3ZzT4qwkS/k8a4q6ub9Usc4dMbWy3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:34.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17089f7b-1efd-4091-78f7-08df24950ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

From: Aric Cyr <Aric.Cyr@amd.com>

[Why]
dc_stream_adjust_vmin_vmax() skips hardware programming when
stream->adjust already matches the request and timing_adjust_pending is
clear. That treats stream->adjust as a faithful shadow of the OTG, but
dc_set_power_state(D0) calls init_hw(),
which returns OTG_V_TOTAL_MIN/MAX and the static screen triggers to
their reset defaults without touching any stream. After an S3/S4 resume
or a GPU reset the shadow claims hardware is current when it is not.

A resume that reuses the same stream object also short-circuits
dc_commit_streams() on !streams_changed(), so enable_stream_timing()
never runs either and nothing reprograms DRR. Replay then fails to arm:
the static screen trigger is at its reset value and the coasting vtotal
no longer matches the OTG.

The max_v_total overflow path has a second problem. When OTG v_count
halt is not allowed it stores the new values and marks the adjustment
pending even though nothing was programmed, and no later call with the
same values can clear that flag.

[How]
Add invalidate_drr_adjust() to mark every stream in current_state as
having a pending timing adjustment, and call it once hardware has been
re-initialized in dc_set_power_state(),
so the next dc_stream_adjust_vmin_vmax() reprograms the OTG.

Hoist the max_v_total check above the point where stream->adjust is
updated and return early when v_count halt is not allowed, leaving the
shadow describing the OTG instead of latching a flag nothing can clear.
On the paths that do update stream->adjust, set the flag up front and
clear it only after set_long_vtotal() or set_drr() has actually run.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 43 +++++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef876a24afc2..05e8fcc710e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -446,6 +446,21 @@ static bool set_long_vtotal(struct dc *dc, struct dc_stream_state *stream, struc
 	return false;
 }
 
+/* A hardware re-init resets the OTG DRR registers while stream->adjust keeps the
+ * pre-reset values, so those values represent has to be marked stale.
+ */
+static void invalidate_drr_adjust(struct dc *dc)
+{
+	int i;
+
+	if (!dc->current_state)
+		return;
+
+	for (i = 0; i < dc->current_state->stream_count; i++)
+		if (dc->current_state->streams[i])
+			dc->current_state->streams[i]->adjust.timing_adjust_pending = true;
+}
+
 /**
  * dc_stream_get_last_used_drr_vtotal - Looks up the pipe context of
  * dc_stream_state and gets the last VTOTAL used by DRR (Dynamic Refresh Rate)
@@ -1343,6 +1358,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 {
 	int i;
 	bool drr_unchanged;
+	bool exceeds_max_v_total = dc->caps.max_v_total != 0 &&
+			(adjust->v_total_max > dc->caps.max_v_total ||
+			 adjust->v_total_min > dc->caps.max_v_total);
 
 	/*
 	 * Don't adjust DRR while there's bandwidth optimizations pending to
@@ -1370,6 +1388,12 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	if (drr_unchanged)
 		return true;
 
+	/* leave stream->adjust describing the OTG rather than latching
+	 * a pending adjustment that no later call can ever clear.
+	 */
+	if (exceeds_max_v_total && !adjust->allow_otg_v_count_halt)
+		return false;
+
 	dc_exit_ips_for_hw_access(dc);
 
 	stream->adjust.v_total_max = adjust->v_total_max;
@@ -1377,16 +1401,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
 	stream->adjust.v_total_min = adjust->v_total_min;
 	stream->adjust.allow_otg_v_count_halt = adjust->allow_otg_v_count_halt;
+	/* Only cleared once the new values have actually reached an OTG. */
+	stream->adjust.timing_adjust_pending = true;
 
-	if (dc->caps.max_v_total != 0 &&
-		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
-		if (adjust->allow_otg_v_count_halt) {
-			stream->adjust.timing_adjust_pending = false;
-			return set_long_vtotal(dc, stream, adjust);
-		}
-		/* Nothing reached hw, so stream->adjust no longer describes the OTG. */
-		stream->adjust.timing_adjust_pending = true;
-		return false;
+	if (exceeds_max_v_total) {
+		if (!set_long_vtotal(dc, stream, adjust))
+			return false;
+
+		stream->adjust.timing_adjust_pending = false;
+		return true;
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -6310,6 +6333,8 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 
 		dc->hwss.init_hw(dc);
 
+		invalidate_drr_adjust(dc);
+
 		if (dc->hwss.init_sys_ctx != NULL &&
 			dc->vm_pa_config.valid) {
 			dc->hwss.init_sys_ctx(dc->hwseq, dc, &dc->vm_pa_config);
-- 
2.43.0

