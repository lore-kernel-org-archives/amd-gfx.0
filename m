Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2143C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8251710F0B1;
	Wed, 15 Jul 2026 13:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOzEmCC0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D68F10F0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPiDzudmQRYdytvSE44GSL9TjcGEEAnj8AzeHhWEd+TkkQkbuzo/YRBg2Ge8U2UyI+wTvMoKK09/hoCrWY3xz7UiCFLqna5hIHE0PVL0Hme4N8VX0XvCP2assDaN5NLlywOQI/Y8ReoQCx1n42cwC4OztTcXyXQFnX2TaNR+ZSf+UL4Q9cMe7yxSQON8MHymp9hau2H49hDvjhNotH3WmsJHTsD9OZAuoB5srGCQ2ihb+/AtRCZlP7IGt5fIy09GNoaDrNf5v8Gkeeqs8yHrI+jq7Iwx7IxRw4zqN6yusgwKbTea3/TsNXNFWxvd2ICne1bIfd7sYvTX7GGFNbKoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1H3+z/KtxQ24ztzvivjAtYRJ6G9fSTkJoc2+0FRFfg=;
 b=pws2wXp6wm5RHelHEr+hXrpOqDaGyexHyyEyOClhkM074estoybRKTjjwUQAK48NK7zorhK9Go6afcMJmrjnMyQ1OiUVDlW47dEU/RnPWnn5B81mnd6/QX5AgXi4fNm1O+Syam1gwuAR+bWiPD5AIJR5hCp+mPLjqm1lNigkbjeEOVHY8tTKvaTnkd/EBf5oXWfmOzUhRmsbjF53EmAkp78pO57WZwVDlZdU/xd9idfDuueQK5GEOM1caDesq+X3XL14t8uVPf2Eu/ENmdDLrgolI+PV8DgKBbRb/HGEKUWoROmLfuMWJ7ev20Kc3QECXw5RdbNiBJ381oAzorwwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1H3+z/KtxQ24ztzvivjAtYRJ6G9fSTkJoc2+0FRFfg=;
 b=nOzEmCC01q8r8oHle7oeCtEqL/jO/4Zlwcx8Wik4WE3RZSIPTQfv7w8zT/0udND/paVcY2waB+2aGB/lIAwD8xlK2GHaIbLbGiSEwpU5LU9UzCAnxa4HF5fuenSK/tnLWnz1+fDzeBPB3JhBSCY6fuzTGJdarXqxhpHDIdPJVR8=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 13:49:12 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::1f) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:49:00 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Clara Wong <Clara.Wong@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Taimur Hassan <syed.hassan@amd.com>
Subject: [PATCH 65/70] drm/amd/display: Reduce DML reinitialization when
 params don't change
Date: Wed, 15 Jul 2026 21:38:15 +0800
Message-ID: <20260715134432.1975118-66-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: c68da330-d0f1-4c3a-1479-08dee277d9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5wcuU+2ThyU03u/bc8Az+FXrlJxcVPNVvjIfHyOWeTQ/NJoD0WJPyvihlbtWcxyPogCDaD/AahwtL3T//hvZjk+XsDi1Ud8lQX1TNiGg0I+XjsF8EIVY7DsIH+ySFTAMWr3XtK/pkyiOyQHOZtf+YuqPPuc41c953RCgtEIodGasAVj6Yp4OGsl3NhNyi2a72FfmILEZjr/3GETKwAnwfhldfNmmA+IFbQ6RhpIULRYdqMz1zvML8Vgh7qIRrXPYu7AzL6LVWA08CrYcwq68zhWHIlM9m6noW+gWY32dtF5OIUKFqFuAsC0UhE5eMsImK0ScVLXR48A2CTQGGVE3xpUxqV38icoWtfe5F1ql/W49Qk5uzh+1ITw7iZ5FaSmVoqEmIaMAvKAwGcum2OYw5FmudY82xHnf3yAndPpEjlBNmwDSMYph3VwH60I3hrGBnomGSDUbYR6WewVkgK3IYpNjt0GjZQS+0oKN6Yva3VSZDzqxpGvqyolScG4pijjpv5EiA1g6weoM+h/ZnRtzUyRnXv1M0laW8ModNH+5qnX+Q4+QPQoKJkXBfovTRAzWMUc+YTxqn9siKOowNejsZ2mn7RHGwEaAv1o3/5Neub4l2mHBmvSOmOyt5wRCOW3yQPrIFn/wyLwiCZyKNvvP8xMrHLNMFYFZiEMnlrf38DdccwiCFcSw2p19KUcfGV1ZBOKoemuif/+VZ4LiXfKv0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vfa+npoNiX04X80do5AolfzBMiTj+9S5wriVCbiiBRBK1lS3mjAYBOFsTG81TMoLJk89+Uok61vSZeIRxNQG4NbtmCJ9dG9dGwxUQwV/maLXWl+uH3ztepfHZZKkBl5SObmt8x/3sI5xykh4MnRZ2Rlb2ExHoCY6tafFYQMprmUVC/hZnPBe5gYhvs/wBj5UG70vyyzIZQnk9jZ1/6ynXRFsSMO+X9BkuZuOmJ4LGO6gd+wWzjNmxnHWZrjhuxI6srRZFLpcL2s51SF7PYrw2u359AA9+oo350xW7NBKFZj4Fm08SAc5flfvjHeRoV7V6mNQ3NVZzJt4ykIrCfXrnmSV7zT4Rqw40Ajk3K75hqN7WDejLpICvMd34XZqvuVA9KymbVByBpPBRvO9B9G7WubSPOtGlIQ+Q28fIWNYIloO91ml4ovfSCRXdRcuDvl7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:11.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68da330-d0f1-4c3a-1479-08dee277d9b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

From: Clara Wong <Clara.Wong@amd.com>

[WHY]
Reinitializing DML causes an extra ~8s delay in gaming mode preset switches on some systems

[HOW]
Don't reinitialize DML unless params/caps have changed

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Clara Wong <Clara.Wong@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index a975d36ce15d..4e3d54c92e32 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -45,7 +45,22 @@ void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, const stru
 
 void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const struct dml2_configuration_options *config)
 {
-	dml21_init(in_dc, dml_ctx, config);
+	struct dml2_instance *dml2 = dml_ctx->v21.dml_init.dml2_instance;
+
+	dml21_populate_configuration_options(in_dc, dml_ctx, config);
+
+	dml21_populate_dml_init_params(&dml_ctx->v21.dml_init, &dml_ctx->config, in_dc);
+
+	// Skip full re-initialization if soc_bb, ip_caps and pmo_options are unchanged
+	if (memcmp(&dml2->soc_bbox, &dml_ctx->v21.dml_init.soc_bb,
+			sizeof(struct dml2_soc_bb)) == 0 &&
+		memcmp(&dml2->ip_caps, &dml_ctx->v21.dml_init.ip_caps,
+			sizeof(struct dml2_ip_capabilities)) == 0 &&
+		memcmp(&dml2->pmo_options, &dml_ctx->v21.dml_init.options.pmo_options,
+			sizeof(struct dml2_pmo_options)) == 0)
+		return;
+
+	dml2_initialize_instance(&dml_ctx->v21.dml_init);
 }
 
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
-- 
2.43.0

