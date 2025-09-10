Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E4CAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DF210E849;
	Wed, 10 Sep 2025 05:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqLo57Y5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E905D10E848
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts2wZuJZZdWBku5gLzEgwyslcmXe8MKkjLXegbB1mmcnfysvcdszhLauvnD2azk7WNOHB8rwUrrcONxid1safdJWNg8Zq4ZYtWkAtYb52BiGGGasSacIjmJtk/zi2/7VZfzMp9OxWkN2yeXVYVO+VVQYWDeo16ZfWmzTR3fxw5ClmHtcT8DadmeKShEqyYpUu+uiG3GdZPRH5EssC49TguiPVv15HHTnRZwOUGa/mqMahvnQw+eVvQhtGzc2aV7Oeh6AXAT14k+xhSYvIKe5mEVHmgsxkWoqcL/rIp5ZgAkO2kjr6vD06r7uaMn3EkIukJtYA2Ntgs+WK6AI5z1aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n678ulV8XlEnKhnu74bQdUXlVWlP4s7lMu7hHiyOxJo=;
 b=faPkotUtaqgvibJmcYIIATYhTIlcmvekSIhZGtEf6Yqqs7iGfcYiRPQbAA8z53NwyV0a5Om4KM7rZJ9nC5X2ZVdtZOPxWvckXPqhuiFH7ZTpg4KwMUKYLqCMHBFCYEAkvM34mVwdA0zreyby/zH29jNYqq/C6kwCqbikHfioK0US0ERPH2unZVTqJOZ2RKVeMM1XTZwfCxTHpxZgU+B76EdlgJXqkIi/dL0u5gg0Vu53reATJqAYhXgB+G74oR5Dt2znkK2sKt25eS7ialjfr0CeAXiOQ4Ec9XNjx8iXwlhlLFCc9OKCiJDuHqBd5OeX7a6irXCxhBLDNwqjFaUiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n678ulV8XlEnKhnu74bQdUXlVWlP4s7lMu7hHiyOxJo=;
 b=xqLo57Y5Bc/QTRUiYv3kBqocfwg1eBr306tPMQdvesxOTrg/ChqS1KcTXtP+eR6KF5oS3y1OBc0KWcka1MoSLbeEISy8n53fYFw3qBMFm6LYlj7Q6BOmLa6pWN88hZPRY1zuEUU12p57zuK9zNZ6NlGy+MLxAxBoEw4VH5Yq8uo=
Received: from MN2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:d4::32)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:27 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::36) by MN2PR04CA0019.outlook.office365.com
 (2603:10b6:208:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Wed,
 10 Sep 2025 05:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:26 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:25 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:22 -0700
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
Date: Wed, 10 Sep 2025 13:22:14 +0800
Message-ID: <20250910052620.2884581-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 6191d3c7-1242-49a8-26c6-08ddf02aba97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EDBzM9YI+FGotxtZn0lsmq/IqDuvT9sCL6Z1zFRRm8mPBdl3HZTQbW4ZUbWZ?=
 =?us-ascii?Q?slIEUcHgqT7AGHqmZ+F0cQCdF+/fLd5n+oyDO0oNTAwlOBeENS5rDrh13l3Q?=
 =?us-ascii?Q?OLEm0GsQRLZIRxzdTRyuiRRplF7OmOOrWfe+SOJxQYKdm8ux6eM0b5qIim7T?=
 =?us-ascii?Q?Mnou4XuPP9nZUbTr5ZMjMmupCJwB0bSpWYsQuMdz3Lrx2ovum143R3IrYA2C?=
 =?us-ascii?Q?DU4CnIrLphTd5aM5nRgB9QU2ui1YaMooYP+R+4f4g6AhC6/Nx5meyDCBfoKV?=
 =?us-ascii?Q?9S1k8/gYraJ8u5f/iXD8JE+3If2NPPb1MEcQkdpWAxUXXdFGmf01WmqOU6n1?=
 =?us-ascii?Q?6oaL0pGZ2ZcoGZ/nwaBMlGaZsrwfehuLA0aibWGKicz/1qH1lYwTRGMZfEB9?=
 =?us-ascii?Q?Ch4CfRiLtRid3MRI5xqKuZRfPaBjqwvAb5aRcKjcyKWjn3ok4VEOy7knzzs3?=
 =?us-ascii?Q?bboSZY4dbf8F01m5P4mUo5mh+bhv2bz+Es08CDjT1nkFeB+rKrk9J3UBuF6a?=
 =?us-ascii?Q?oN4frRnH/l5BXcj9raiuZBsFQ/gf4zghqSJWOV+wEL2WAj0RMIFEPoBMJyJV?=
 =?us-ascii?Q?uOmry5oNP7cjYedeEi1FRKtehl/Xl7qRfO2w2a+156Av93EUMfzeLVgcX+RC?=
 =?us-ascii?Q?tZVgRR+lO9QqdpjXFBRZygJlrbXpsYi7MOMUWLGYJ6iDWFlGX7UB24XgKZWD?=
 =?us-ascii?Q?zkZLwK9xKYicZuSBVizvclAeX0FL4uD3bsjz+WvEQoc87fQGfsSnmVFT1uvV?=
 =?us-ascii?Q?p9J504WC5PhC8+L80FFgZ/2pdt2PGAChP130t7iiN6eBN4r4yN21POz6I85Y?=
 =?us-ascii?Q?p67pFX0v8ITN6cGU9TYta/THmntASM1FjaKu88An3C0i9HvfUUd2k+UkH6Sr?=
 =?us-ascii?Q?sAcAEj4eNdzemUTJrCBfgN/aVxvDBNaoqAT0OfC278hglDsiTagbxDh+HyJH?=
 =?us-ascii?Q?oloBOA4dpm9k9au3U3Vl09CLjfHKRgB1SzrUF6MVhlSP+A+s/hnhbX5VBXpg?=
 =?us-ascii?Q?MugpM9tIHVhyQ3BjyBebpAFR8o4J19mh6U2ygWfygVU7tIiXBluMkKPrxa8Z?=
 =?us-ascii?Q?Myk894/EMMJ75cHhEM783NK/CYSy9A0330RYZPxO4EhJ9OtR80UJXG2wu3dm?=
 =?us-ascii?Q?dgjgxLQ95IEHUopwVwiM0Vqr4vOLZM7Ak0AlgVY9CG1rNPf4AvBKuE1DQM7N?=
 =?us-ascii?Q?yGBjOAl9pSvwNHO2KiFXrT0bIsziS0wLBHva3ZrVVtVt0864m3qoIg9kwrs4?=
 =?us-ascii?Q?LpQd0sxIw+bmdQINfjj4Dbe0Dxjt+RBO95S3cR3GOv+JSAKd5pR7XhtDVnY0?=
 =?us-ascii?Q?PyFRRnbWdtrkL/H68a2JNf6emhfAY8K//THwvz+9RBTUiIMrjaITbaopmFc8?=
 =?us-ascii?Q?CuhPh1weCyY4r6cWTi/BrcmzSSk5Ttpv4wjQAv2TrFsfFYByt66Hp475ZQNL?=
 =?us-ascii?Q?Q18FBO7bVvv+Ykm7xyTRGdVaIjDruFNzUiCP8AbnnKKXutDVv24R+/z4RnCJ?=
 =?us-ascii?Q?cWTykR8JtCDdSzK5z2nMfjSz61NIE+p5gRTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:26.5791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6191d3c7-1242-49a8-26c6-08ddf02aba97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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

