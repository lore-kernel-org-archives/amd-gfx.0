Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D0ACD6E78
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE61F11284A;
	Thu,  4 Jun 2026 14:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwVCBqh8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610D3112843
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+lYCO6gKKpjKZVY0OTXWdmImBCkFU+WGRoZIpizoVLc9+GpuslgGJqohRJPWdJvj+ihKJeLlK2zGCEnQwtTiGQq1DY4if/JPZqLhXy4sp8o2xIIxA0g9uUpDQr18xj1Uqkk899Sbw3TDcCOoQ5orKAHb43h/JrYwlxYdI0Of+bD3hd3kkKbPYK10rAatIcwQbqPdqIaUBaOmHIfapu1mmPAwj/5h8CxB+pjtS2+jpn9tGzIXzrOAAVK77Wn16nhQfRMzBxEV4CKL/a16Qo5UqrDoOK34gjKIPITBQVrMAoXjjf5lK1syYpdTe212a8w/JGkUrSQ/th5Rhi5zYUfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDkilYVCi6NTG64xLCGY1OmKGcMru4Px8u4nqdfVz/o=;
 b=QkgNJtJg1FluyH2ckEuR3YMNNhbuji34jtZ+Yc3qr7AKq0R3LPAnFXjwX4HYs3dAMUlAnXHPapI0MXX0ElyfyI/cCsPUg9/PITc7W2Nr5y0EAPQJEYE9u6756UkXvCpln8J0BJTadyIJSQCqQCfSu1DOCJe1Roy9X0+bEeQgX4UxPFW+Thl04dlOPnPnDiQOS/ZIaMNtH3QVbAsJG2Crh5ROSy5MJ0s5SPY6VdvGUR0bYUkpAyF3h/k5Mr4qHGfhTx75JzCX7xAVKnL6Z1vwCjoEppwcDyy8xEskdxbF0z2elvkucDu+t9p34si1+RgB6DlFtfY/FSEumICdAr4chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDkilYVCi6NTG64xLCGY1OmKGcMru4Px8u4nqdfVz/o=;
 b=bwVCBqh8hOCDDyIrLpXKH20l+QSuoh4uoXtyQL10QHbN30TychsqJKyS0IaNnkSEjkUqbqHONLnDTeUCYhfVbUEZVJ+ok731AvWks/c4ek8W9myP/UewRXNj5pAV4NZdf9Z9UtmwcYt7hIK8lf8aOt1HAlAPKDU6URXsWx4N4yc=
Received: from BN9PR03CA0239.namprd03.prod.outlook.com (2603:10b6:408:f8::34)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:15 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::59) by BN9PR03CA0239.outlook.office365.com
 (2603:10b6:408:f8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:01 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:01 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Remove dead code in dm_dp_mst_get_modes
Date: Thu, 4 Jun 2026 10:52:04 -0400
Message-ID: <20260604145428.809959-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7eed0c-9410-4cab-c0da-08dec24949b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rtQ58bxVzAqnZvaln/XBLLCnu9NboW6EV3e8nXimbdgp1vqVavhveJOtebtNZKQDHyvFdMheWzWVv8s/OF8l0HN4JJF8NNm7qiT/CX+Vv25Ty4XO/x7Tm2yKgSkRk24N+59y5N//s2Ut6qNfIaXGfeRYgI76zbVMAGLHTBjRBWBJHXsSZk2IsKvvNwlXMjHXjxnkUDZvxsbCQUD+iJdgBp9yK7nGqf5/alR+aX/LprVnbwb1+U+SNH1Rpu7IJkooVt7GlXOC0+BfaIC/lAKZyAJUwZ5ytbXGnOliYtbKlKGKx10Mt3cHIOaqtg2tAHLVo3hAv8/MR92brrNW4fFovYZB6ClxBVr0XTbfiSdnEr4l7/8z6WQx1g79oOocdRZymeyVoeVMwCtMP+igqeII6T8mlWVnh0LeA00XZQefYLcZWUDw9Xsz8yGqgikGnmkxIS1rW0wrupasrIANJ4Zw/Uh25MZGlJsm0S5A8ikYiHvOwJyIB0LmLIZ9jBezwwpRx1Prpl/PZ9Rjyk+44NHwCE1E3bK6VU3x0fXlSpB2L61GseYCc0mDKZq3jY5Fp7olTI81Omv9nhyGUY62nfT6YPNKcI1Ox6v0ibgFhz34nIaY1e+sYExC2jfLajKUqV4DgQjs1S0sQe3zNflBc8an8qX7PWgY5EOLJTQkvbxftquR9p/EXs3HSO6KtRJDN9cCy6ENud5mT36+LEzSGBKBwkmUhsViEsarHr4Ys+Gvmlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GNIdXGdjcp1cEcxcQOriaeYihRO9Q0+G4jQu6qg0LQ64OVHwH3oqro6w2dmcC8BowiyNJ4deIgkwPbcjYtQFO9GCIBv9qELKsgqYG4JejDPHog37bRVCB4srGyMox85n7GWWE4ZeZ4VE5BXAKk1Ys9BiBh7lP11nX6+ZNwoZmqt2qPaASbsD/Y9mB5hJNx/P19ARs/gvNJkv82AcKC3Wu5ooN7gUWL3Z2gZ/5eISQiW6dgOFZ8gU2+/ZYfvGwH1EPb4Cl0RTfYYQ+iig/gVAhmqoraqvPjI5i2jx9LnSd+WZ8odC0LEtql/BD+Ia+7uP9oqUfoTYrapAqnTBNfSw+I4M9bkYoL4R0EP0wl62suVe9gde0KBA2c9TK7QUpIJgLlLtz0R2uE+CxOwV24gzEM7jR9VoQesC7bjFCy5LB90LpHCTV8jHtJLBcyYBeeSM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:15.7880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7eed0c-9410-4cab-c0da-08dec24949b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Remove unreachable null check on aconnector after container_of,
and redundant dc_sink checks where dc_sink is guaranteed non-NULL
after earlier null-check with early return.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8e2a8c2c1d84..3b6433fb1345 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -363,9 +363,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	int ret = 0;
 
-	if (!aconnector)
-		return drm_add_edid_modes(connector, NULL);
-
 	if (!aconnector->drm_edid) {
 		const struct drm_edid *drm_edid;
 
@@ -456,7 +453,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		 * plugged back with same display index, its hdcp properties
 		 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
 		 */
-		if (aconnector->dc_sink && connector->state) {
+		if (connector->state) {
 			struct drm_device *dev = connector->dev;
 			struct amdgpu_device *adev = drm_to_adev(dev);
 
@@ -472,20 +469,18 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			}
 		}
 
-		if (aconnector->dc_sink) {
-			amdgpu_dm_update_freesync_caps(
-					connector, aconnector->drm_edid, true);
+		amdgpu_dm_update_freesync_caps(
+				connector, aconnector->drm_edid, true);
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
-			if (!validate_dsc_caps_on_connector(aconnector))
-				memset(&aconnector->dc_sink->dsc_caps,
-				       0, sizeof(aconnector->dc_sink->dsc_caps));
+		if (!validate_dsc_caps_on_connector(aconnector))
+			memset(&aconnector->dc_sink->dsc_caps,
+			       0, sizeof(aconnector->dc_sink->dsc_caps));
 #endif
 
-			if (!retrieve_downstream_port_device(aconnector))
-				memset(&aconnector->mst_downstream_port_present,
-					0, sizeof(aconnector->mst_downstream_port_present));
-		}
+		if (!retrieve_downstream_port_device(aconnector))
+			memset(&aconnector->mst_downstream_port_present,
+				0, sizeof(aconnector->mst_downstream_port_present));
 	}
 
 	drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
-- 
2.54.0

