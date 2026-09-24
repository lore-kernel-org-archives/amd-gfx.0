Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C5C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4890810F743;
	Thu, 24 Sep 2026 18:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zqubyh4Q";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624EA10F73A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQGntUd3A7ZDvy4nUB9GEj1W7YNjU0Ifye+8yES22S5WiWqLm79mJQ0GkV7NqCB2y+5mrw2rC2qoGodUxsMbFkqMdT7xZrsp/JTUEvKMcYakTBCYiIw2Quop5vaY+zUDpeKrv/G2vU8cf4NbtGayKBQYLu4OpzbbUh4Lv9S5vNkyZvE2LjIze4TgS+0YUpn+aW0gtf53ObvoTw2Zo+3fNXwFCBiM7aI+0jAszGepB6wkcnx05EarGW7SrfXqH1N2fQNkJCzDFW7aQrsiSezharYwbFsTrebA9/4gRpvoWqAQ8VF/qGzH9YqIEStloI8dWwnnduJ+iWoPXWSH+qZGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEcX01zxt6LuaSrvmeCiGqwYEWLfzPlawdjqzIYe6qE=;
 b=NCr1QvQECy33G8m+Iofrj3GsTeLfLA/ajX97diNGdl+jj4KEX3a3nZlSeDfppA/MmWbW9cpbCxWhJyQWZIBfXzFUSX+tWyFma6qZsEvR4dBIrG7gQvXw/7PfhZYfS8jNGSahfY7R+drU0juCNgWrdkfRGe5avAyMLINm13KcQkAE8ew52vkeptrFsU+mFXMCiL5k5+GtM2V1OzRSTKmNwgm7017VAiduqzQEacelqPjRnSa22NQR1vzMOBxHnEipg+E/vRODNMT7CAhR/lHStJqstAHGVlAU+Hn+nVNEKlJg6vw9aY2kZWi7lFHiarxwKs2ZE5N9y889DJ0KBgSj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEcX01zxt6LuaSrvmeCiGqwYEWLfzPlawdjqzIYe6qE=;
 b=zqubyh4Q8GQhCW/QTsx0c5Mn+LeZ+URJhus0lB+0CNyvivEfC4sTDloKDM3pUHvsdKMnZ6fRg40VhApF+XP801iQn/lb7NGKSupgdY2b5aK1/6bpZHv5IXvZvfOEr7S1vnYQyN1pY9+QeAYeH1V1t6XcMZAhv3F1MkwzZvJDvkk=
Received: from PH8P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::29)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 18:46:39 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::19) by PH8P221CA0026.outlook.office365.com
 (2603:10b6:510:2d8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:39 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:20 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 26/34] drm/amd/display: Add urgent watermark override for DCN42
Date: Thu, 24 Sep 2026 14:45:39 -0400
Message-ID: <20260924184824.596894-27-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f258ebb-12fb-4a7b-33e5-08df1a6c2b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OUOvLQUCC8lTRx9Be5sQ0n7LlGX9UcJuPlFuQ1OS+tihawDp4h0kIFuAHGX6HirhRrrvKwzeObd/zFFvvpt/rI0IW0NN27kqD9NtLJEXi5D5yh+C4GMkA/YtjukAlLBJpWWWc/c/EcXOtn6Dh6pnVnBhCf4Eis1EoISXru1ZiKfVCnDMB6NYuOmEUx4AO1Op4xbkzKSkmNLeWDD4pFUNA4yNiHUbiYmE2kxVayaj8nVVL9m4um8JdblieXleNoh64ntk1rJP14GsGe5yJxKpICmyLZgjW3gKWjCC56SuMSjGBAbqrvr1iAkm7aKpUJj2jTWhBt4kh82CyCEaT1TQZr/ZZk0ZhsWmkQMAziTyvUFewPuVNqt8dlaG52A7LKIv0mSRKwyjXDniVdcJcTK15L/zE9FTI9amLuakXaVk8k36m12KG444xVgJ12xvcMzJq6zM/3Y8Wjvctc2oFi0T9tF5QUnn514hYQMUnoBdlt+iyCi43YltIDdYAyaAj/N2M/ADRtyCNeVyCNawglWJnG6O5g891tdfQOjx0DCJaihLzxfnTzm+gxFHwwyRbM4mF+o7hxfCznIa/DoSO+ZMykqs2VwI5wuEFzQ5U3y0PvQHSKeSabrl2/V3Q11KTl55031iplJHXVno8W5BgdLiCYIEkfWa+fwL3VMv6d5+rpwVVWV9hRqhZH8mESnF319Vh7RdJXxJr6J0ir9HWyg+AA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1sAvHwE2p9sSdFjWn7Y8JCIipH45emYyPKvLBPK6RWEEap/1eoBzOo6duV7rBBTB4Qhcz9xQERzXMCQ8iMUEXm6rf21xULxa0/Mujd3B0wZ8sNKwYpuuTJsg2R/qAkFUkPutLuFWbj7e91mVOc3BtaO0RAruyY+0Pdr9kacrCfhxVcYY9y5UaPF3w2B5v7OS4JWl03fP5Pl3Oen8dKa+2qEFFVAHaLWhMoULeXrPFJ/js4YGNqvLipxGST7ewxuLrXfNnAOtk85oUg/ac5OlonlaPzBWfuA5FB2YM2WhUJcT9WfoSrIs7UXIVngNt+VLD8iMIaTxOSGksZPC6qbjqCeVlyRDDcV9VaGjtlIeQHC1iPJ1JotHzyPeY2tC+ikLnjmlJOvdr79CebT/J7Lh2n2U2uSZQL194TFZkcqae7XNrq0HDIJdESRIETfgO4M8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:39.2009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f258ebb-12fb-4a7b-33e5-08df1a6c2b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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
Out-of-urgent bandwidth delivery to DCN is very poor under workloads.
Even after asserting urgent, empirical data shows urgent return BW
delays of up to 100 μs. Override the value when programming
watermarks to avoid modifying mode support. Maintain the DML's calculated
value as a floor.

Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    | 41 +++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9c8e55715e47..b7c04d7cea3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1314,6 +1314,7 @@ struct dc_debug_options {
 	unsigned int auxless_alpm_lfps_t1t2_us;
 	short auxless_alpm_lfps_t1t2_offset_us;
 	bool disable_stutter_for_wm_program;
+	unsigned int urgent_watermark_override;
 	bool enable_block_sequence_programming;
 	uint32_t custom_psp_footer_size;
 	bool disable_deferred_minimal_transitions;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 036276c17562..244f3f2824ed 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -30,15 +30,24 @@ static bool hubbub42_program_urgent_watermarks(
 		bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	const unsigned int urgent_floor = hubbub->ctx->dc->debug.urgent_watermark_override;
+	const unsigned int urgent_a = max(urgent_floor,
+		watermarks->dcn4x.a.urgent);
+	const unsigned int urgent_b = max(urgent_floor,
+		watermarks->dcn4x.b.urgent);
+	const unsigned int urgent_c = max(urgent_floor,
+		watermarks->dcn4x.c.urgent);
+	const unsigned int urgent_d = max(urgent_floor,
+		watermarks->dcn4x.d.urgent);
 	bool wm_pending = false;
 
 	/* Repeat for water mark set A, B, C and D. */
 	/* clock state A */
-	if (safe_to_lower || watermarks->dcn4x.a.urgent > hubbub2->watermarks.dcn4x.a.urgent) {
-		hubbub2->watermarks.dcn4x.a.urgent = watermarks->dcn4x.a.urgent;
+	if (safe_to_lower || urgent_a > hubbub2->watermarks.dcn4x.a.urgent) {
+		hubbub2->watermarks.dcn4x.a.urgent = urgent_a;
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, 0,
-				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, watermarks->dcn4x.a.urgent);
-	} else if (watermarks->dcn4x.a.urgent < hubbub2->watermarks.dcn4x.a.urgent)
+				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, urgent_a);
+	} else if (urgent_a < hubbub2->watermarks.dcn4x.a.urgent)
 		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
@@ -64,11 +73,11 @@ static bool hubbub42_program_urgent_watermarks(
 		wm_pending = true;
 
 	/* clock state B */
-	if (safe_to_lower || watermarks->dcn4x.b.urgent > hubbub2->watermarks.dcn4x.b.urgent) {
-		hubbub2->watermarks.dcn4x.b.urgent = watermarks->dcn4x.b.urgent;
+	if (safe_to_lower || urgent_b > hubbub2->watermarks.dcn4x.b.urgent) {
+		hubbub2->watermarks.dcn4x.b.urgent = urgent_b;
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, 0,
-				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, watermarks->dcn4x.b.urgent);
-	} else if (watermarks->dcn4x.b.urgent < hubbub2->watermarks.dcn4x.b.urgent)
+				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, urgent_b);
+	} else if (urgent_b < hubbub2->watermarks.dcn4x.b.urgent)
 		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
@@ -94,11 +103,11 @@ static bool hubbub42_program_urgent_watermarks(
 		wm_pending = true;
 
 	/* clock state C */
-	if (safe_to_lower || watermarks->dcn4x.c.urgent > hubbub2->watermarks.dcn4x.c.urgent) {
-		hubbub2->watermarks.dcn4x.c.urgent = watermarks->dcn4x.c.urgent;
+	if (safe_to_lower || urgent_c > hubbub2->watermarks.dcn4x.c.urgent) {
+		hubbub2->watermarks.dcn4x.c.urgent = urgent_c;
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, 0,
-				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, watermarks->dcn4x.c.urgent);
-	} else if (watermarks->dcn4x.c.urgent < hubbub2->watermarks.dcn4x.c.urgent)
+				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, urgent_c);
+	} else if (urgent_c < hubbub2->watermarks.dcn4x.c.urgent)
 		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
@@ -124,11 +133,11 @@ static bool hubbub42_program_urgent_watermarks(
 		wm_pending = true;
 
 	/* clock state D */
-	if (safe_to_lower || watermarks->dcn4x.d.urgent > hubbub2->watermarks.dcn4x.d.urgent) {
-		hubbub2->watermarks.dcn4x.d.urgent = watermarks->dcn4x.d.urgent;
+	if (safe_to_lower || urgent_d > hubbub2->watermarks.dcn4x.d.urgent) {
+		hubbub2->watermarks.dcn4x.d.urgent = urgent_d;
 		REG_SET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, 0,
-				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, watermarks->dcn4x.d.urgent);
-	} else if (watermarks->dcn4x.d.urgent < hubbub2->watermarks.dcn4x.d.urgent)
+				DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, urgent_d);
+	} else if (urgent_d < hubbub2->watermarks.dcn4x.d.urgent)
 		wm_pending = true;
 
 	/* determine the transfer time for a quantity of data for a particular requestor.*/
-- 
2.53.0

