Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE85CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B931F10E85A;
	Wed, 10 Sep 2025 05:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4aim7Wln";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0091210E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7lJ1auyJtJOXUSII2ZO2PQMl86Ngqvrb+XWTPq4GlGzPOAGtiSjjg7vzHeiuyItz8w3a8gc7Zo2pNyw5RGG2lSwIVSbsH5BgDampvTrme4y1TM60B3IO3obbnrL7HdzoV8UNfgOb64dOqKoE9mo8uvMDFHgd1Q1ryy2rQQxhb7yrh6MkShxk46lH2D6kIh0gInzHWJDCCgUn55XHdk3sZpv2Fn7ORzRy8z4I1GesrJZF9pU+a0WZZjifmji4ZskkKSocO3e9t+rx32N3RyG7Y9JF6WNEgLfjhuy86dGkxuGFJIlF2nOGmpZWvPvZHU+3JMqR6V8xEEoe62Jc7H+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n678ulV8XlEnKhnu74bQdUXlVWlP4s7lMu7hHiyOxJo=;
 b=e0mxT4667Dq62gQcOiDlj6Q0gnfkzTGhYd7dyTnvAnERa07H8OB6kg+ntJqwcL5Ix8mVZyCzzSJovDmQnOe0pOwKxUFogOBPseMGMiYws+91lQUaVvEYozpY7t2Qik2/UFH/77oPQyg5Oo9imhU/IPz5fKRfrQgSkJP8tobwbpRA0AaXldX6tywBAWHJG6sv0R5q2dVq8K9ZWcKgw1vX3k0V1h5rPxIO7Mc3Drz1UKTCkXjDSbClMgyTKE6iiW5BRcT94PuS5m5OrpEcytblWhRLPwC4tduhvWWyw5dPh4ehlIaf+RPf7VzB+pqy9+dI7XbShrx8j2EJHqYM/0cp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n678ulV8XlEnKhnu74bQdUXlVWlP4s7lMu7hHiyOxJo=;
 b=4aim7WlnWViF82S/NvHyEEOZyFuInldj+/gtyiQajFjmmCulm7QFbrUWI2t/XwgSVis8GjSRFhh6TpDmxJhBV+1cy1YD0CG+uRup3b7uMKkikEKKfUniT+UJKLG4jnDdFAf0/F38Afo+EKAwwrHC7uSaHpWZ/RY6XHTmrkRnSos=
Received: from BL0PR01CA0011.prod.exchangelabs.com (2603:10b6:208:71::24) by
 IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:30 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::b0) by BL0PR01CA0011.outlook.office365.com
 (2603:10b6:208:71::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:28 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:33:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:24 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mario
 Limonciello" <Mario.Limonciello@amd.com>, Mauri Carvalho
 <mcarvalho3@lenovo.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/15] drm/amd/display: Add fallback path for YCBCR422
Date: Wed, 10 Sep 2025 13:30:35 +0800
Message-ID: <20250910053222.2884632-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f9ee45-3b6c-4f11-dfba-08ddf02b9371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?za66IZ6Y0kdl2J3k0zWHwe/vOQ2yv1rmB4D4BZwELlWsODA7bQOW1/jvGmdB?=
 =?us-ascii?Q?V7xwi2SYK9txqx+T+2tPAyh0szVsIQ+ppe+KFKv324VYnS890zCpTCHDSwiA?=
 =?us-ascii?Q?FAmZhjLb31aDUsUFpTWiw9NxqQ52Zm7LaH2iTDcD482bYmFa52R5v53TNihk?=
 =?us-ascii?Q?xDaqGyIOo/pb6tqp6gy/w/WhSPB+QmM1IlH8H9OW8XHJ1J3BgJDNVftAAch3?=
 =?us-ascii?Q?5iU7xs12NQA6UAABhysSQ5gbalUEWo18wv/Gp1BVfeyPtA/bzqOjdeja7L8b?=
 =?us-ascii?Q?kDjOvCTZCdW+SAHR5XGVc6dmmGo428Rug9O1VdzU3WsIjE1dsBAoy4WN8tFx?=
 =?us-ascii?Q?ltbHeKOUn2ROUuha2QJkLi/z9mflzlks2lbglw+cVNxP1om04i0rzva8VMJM?=
 =?us-ascii?Q?6f25SZJI36E1hXUNB3abPRmm0L18NqVYEz70p/elMprUO0Lhv424fbndzttU?=
 =?us-ascii?Q?1h8nAZcHbSvBYNpAhSSputIOf9qb+0XyiRUGQe2fBDCQbxOoapwhg6dZXh9u?=
 =?us-ascii?Q?JWPybAHznvYjFoSZn3uajpEV8T08iZATLXlzYtPWgTNF2ThawSUurr5ophz/?=
 =?us-ascii?Q?yjgBX77uHrwvw58NZ6vM+xwDn5wS+HcvSLfJimkV6x2euFYjQbFh+1w7RgJD?=
 =?us-ascii?Q?rd/IKJ/KDiBKDvh0KZwJ6/6nvzBgTYrrmx/sQe3GhmZ7BwJlqJaJXqSDHSQ+?=
 =?us-ascii?Q?3Hj7F088XDVpglV96Q//sGFWZeHkE9m28go1CDAJ7RZnRbC/jx1teGi9yDfW?=
 =?us-ascii?Q?Sg21BXefQQIuwpY3iOyiTwx5UY45nmUaStBKQTKKlRMoP2zebsqCqPgW5A7q?=
 =?us-ascii?Q?pKVjxZV/aMz7X/wSXRIfqt/gX3yFcKD322myxu3SO6Qe/AL+SxNISI4JHNkI?=
 =?us-ascii?Q?ZwgJyW2nwCquS0CrQ6mi5XYJiXMpmHw6ZgPQK5fbvKSt/ZFauhUkxNsYHnZf?=
 =?us-ascii?Q?PjvC1V51HF0IgCLeVbWpgbNQyFN/pVEtODfM9OOT/aqnUjXyrVVoxOqM0Xvu?=
 =?us-ascii?Q?wbmCs1LVCf974ZnC1vP3IyXujhdP45hwNscHShALG7lhrMWfOAbaRV9K8ONa?=
 =?us-ascii?Q?V+MQIkoV0JQdMd5IklGOtRKynveWXrtpTK/RtEXO5mCw6I0ZF8miUvbvEhv0?=
 =?us-ascii?Q?FUW7Kylsk3/FsNKolsMXB3pL+7OaHi/pOzB9ax3chH9AjM4cNJFtaUmRlLnZ?=
 =?us-ascii?Q?fpBE6U1TdASUqTWtKXmpat0wtPq5Ho0L36JStatZ55+njwRbYUTLRTQFu4SQ?=
 =?us-ascii?Q?UXIPsqMDZNuHprTmvIUJ4u3yHT/WRtNtJwstxvl38Sm+NVHp/JsPvUeCSnnW?=
 =?us-ascii?Q?1JJ3frAaA1XBzo/6wzTwMQJ9xNiXVNY2hTi9+j9paGMUoH6in5nat+dEdRJP?=
 =?us-ascii?Q?YXO1GCQDWcDy8SPBCWK8Cburx/rCvnWRT8JsC98EF+t8q/OTJ3hbQeO7Gv9H?=
 =?us-ascii?Q?Ng72ywqe+V6+EWYD0h5wjS7ebaK6VY5CBn1J7Hfauv7yeLr7C1tZFeMifRbp?=
 =?us-ascii?Q?MvJJMMOWcGlMOpbCFFJFLjpjlZqc024IqzqD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:30.4027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f9ee45-3b6c-4f11-dfba-08ddf02b9371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
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

From: Mario Limonciello <Mario.Limonciello@amd.com>

[Why]
DP validation may fail with multiple displays and higher color depths.
The sink may support others though.

[How]
When DP bandwidth validation fails, progressively fallback through:
- YUV422 8bpc (bandwidth efficient)
- YUV422 6bpc (reduced color depth)
- YUV420 (last resort)

This resolves cases where displays would show no image due to insufficient
DP link bandwidth for the requested RGB mode.

Suggested-by: Mauri Carvalho <mcarvalho3@lenovo.com>
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1f9c56c288b2..5a62a1967a2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6406,7 +6406,8 @@ static void fill_stream_properties_from_drm_display_mode(
 			&& aconnector->force_yuv420_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			&& aconnector
+			&& aconnector->force_yuv422_output)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
@@ -7668,6 +7669,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 		bpc_limit = 8;
 
 	do {
+		drm_dbg_kms(connector->dev, "Trying with %d bpc\n", requested_bpc);
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
 						requested_bpc);
@@ -7703,16 +7705,41 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 
 	} while (stream == NULL && requested_bpc >= bpc_limit);
 
-	if ((dc_result == DC_FAIL_ENC_VALIDATE ||
-	     dc_result == DC_EXCEED_DONGLE_CAP) &&
-	     !aconnector->force_yuv420_output) {
-		DRM_DEBUG_KMS("%s:%d Retry forcing yuv420 encoding\n",
-				     __func__, __LINE__);
-
-		aconnector->force_yuv420_output = true;
+	switch (dc_result) {
+	/*
+	 * If we failed to validate DP bandwidth stream with the requested RGB color depth,
+	 * we try to fallback and configure in order:
+	 * YUV422 (8bpc, 6bpc)
+	 * YUV420 (8bpc, 6bpc)
+	 */
+	case DC_FAIL_ENC_VALIDATE:
+	case DC_EXCEED_DONGLE_CAP:
+	case DC_NO_DP_LINK_BANDWIDTH:
+		/* recursively entered twice and already tried both YUV422 and YUV420 */
+		if (aconnector->force_yuv422_output && aconnector->force_yuv420_output)
+			break;
+		/* first failure; try YUV422 */
+		if (!aconnector->force_yuv422_output) {
+			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV422\n",
+				    __func__, __LINE__, dc_result);
+			aconnector->force_yuv422_output = true;
+		/* recursively entered and YUV422 failed, try YUV420 */
+		} else if (!aconnector->force_yuv420_output) {
+			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV420\n",
+				    __func__, __LINE__, dc_result);
+			aconnector->force_yuv420_output = true;
+		}
 		stream = create_validate_stream_for_sink(connector, drm_mode,
-						dm_state, old_stream);
+							 dm_state, old_stream);
+		aconnector->force_yuv422_output = false;
 		aconnector->force_yuv420_output = false;
+		break;
+	case DC_OK:
+		break;
+	default:
+		drm_dbg_kms(connector->dev, "%s:%d Unhandled validation failure %d\n",
+			    __func__, __LINE__, dc_result);
+		break;
 	}
 
 	return stream;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ce74125c713e..2967cd28efe4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -794,6 +794,7 @@ struct amdgpu_dm_connector {
 
 	bool fake_enable;
 	bool force_yuv420_output;
+	bool force_yuv422_output;
 	struct dsc_preferred_settings dsc_settings;
 	union dp_downstream_port_present mst_downstream_port_present;
 	/* Cached display modes */
-- 
2.43.0

