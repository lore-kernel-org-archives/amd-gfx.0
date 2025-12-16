Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E326D5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3409C10E2A7;
	Tue, 16 Dec 2025 09:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEW3/Hlc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A33D10E2A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxSkXfv4cEHzoDYA5zUIgH4WCsXXgPaXy0Sb+dbQN+24cmbcPA5ycdeEtQZKJxZp0Im2M53JJfvv2OT0AsVnYXN9WJdsIQVt2qgorXn9v3paTDruseeztOJ4yF6loAO9T2QTYo976Em3diDK/8suirJy4AygjFsihoejh9iN/WHxXr2UYX2T5kkhXtvB4n+qEsdb2ThtvGWS2IEI9By6WYl1+fF5yLAv3IkLWPc7h8ZGkE1GPu+lvWOD9Yl5BRcXT9FImUpUmVtZrP32lbd3la/W4LHIP1/FUCV8pLpjPlGp36HBRm0DDCuUbW9257ayYwpXnM91upYSdP6+8dhYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wDSaOBFxbjAUdfN6i+nXKldOC4zFC9IQqfqgaMunvE=;
 b=wYxP+9Bfxd2zlaBH7TglVstqkMdIHV/LFW3owi+ebZONzk3+2IOcqdLpdy/eEwwsnUgUJW+CCz9Hps2+eA6BgLv5IBFxdyjfvu61w2MA6OyS8oGdS0dDFJ39G/oB6rcy7ywid9ry1ehqOgcUBSK9atWYk6hTpC1rYrJ14rCoOJG4BKMGyr3jnoCGIRck7SSrL94LAlij+h6nRb2ENQaOXe0xkk6c9Wf4LxEa8G+bhL72Nie29laUVRyLa9CczN17RDPmfO7xtNOg/o/RirqDhfJ1xRKIvYf2RhwHiQylipgp4ERLJPgO9NpWzUkJESOdkk7KHjal/b/Zsjjz5lfjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wDSaOBFxbjAUdfN6i+nXKldOC4zFC9IQqfqgaMunvE=;
 b=aEW3/HlcSn634DcgUPXuV933nvphrQvK7+jyb+tI2I5Qf1AQx2ubQJEOjFKeSCz+Z8v5voxz1/CqCrWpP9GAxzKtZ/8BH+ESyVhPGe2bpu5lAOYgtO/yirZuOZWP5qvc5yT8Dgzxr+hlQhHpMXb8kvJ3V2B7VAcaOqi0M1Fxlhw=
Received: from SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:57:34 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::e7) by SA0PR11CA0046.outlook.office365.com
 (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:33 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:30 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Robin Chen
 <robin.chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Add frame skip feature support flag
Date: Tue, 16 Dec 2025 17:56:01 +0800
Message-ID: <20251216095723.39018-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 33444c21-29bd-483f-2e48-08de3c8988fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whXL/TzK+tnaMgELBAXgN1tMPSi+/eHHiScDJRf8mV8mMLx2P4mRJKy3wBaq?=
 =?us-ascii?Q?KHf337wYdmRgnEOa5TjCHpELl2UWj8v+mlVU2XYBqcLepC6h2ILaIoDXFgdA?=
 =?us-ascii?Q?mTl8uLG6zkJBhc+QTIWbNqJ50F50oaNIt7LWGJxWmD+OfV6MXawhrT6vifdQ?=
 =?us-ascii?Q?C+fGfNy3x4Yh7XwiKj6ZZKbIT9aJJfXoD3RNQLSSJA7cgXj1KT804+HrnuVi?=
 =?us-ascii?Q?EkBAkAwhwrSgvRl4TjaknGpNXSTDTnbI5Lnnm2Gk1lu9dSfocapw1X2wJvRk?=
 =?us-ascii?Q?YPykEgziABnq+7VX7thIAlDpdQ2honWTNPLrEsc6KUMftH0Rt5FXNcKmK14O?=
 =?us-ascii?Q?HKm+/b4ykm+lswepp8LA2LeLevJIqzWTtNMXf+rXxI3Ha7PdhHxidmIU+5Bz?=
 =?us-ascii?Q?6BmTjaHKDwFBFwaZ4YxN4h7lic+Yz45FGsddZ8tHMV7imVhmviAvuTpPBJnl?=
 =?us-ascii?Q?8JyiAKwH/LKTecVPd/bf2FocxMB2tWohz5pQThtSRYHL0XWX8ONJsKTJmloJ?=
 =?us-ascii?Q?wqwSy42a1auYYtcyykEOA3c6khCylgtZgYXgFwKLZsZyaEC2CD0FhwSmdZ5D?=
 =?us-ascii?Q?iWRKwU0Qqoe4NxHItn7rxTU6MuLuhiTCOGf2QeidsWyRX+qGlLKbtrw/3VIu?=
 =?us-ascii?Q?kevTOzy+7Oc9B9KuDqsytyKV+IwC9AjGDQW3pR7G2Aqm02lvGdmxLS27LwZG?=
 =?us-ascii?Q?wVUdbuU2El9ioBmiShm9Nad43Fcs8XW6FN1WlSpviBKNm6gF5oHIZ0Elxc6g?=
 =?us-ascii?Q?OCoMBRLW1H06sCuZygB9OOLl9awT7ThlIfuQ/HNO9bDUSzJrUAjfGpffYFD6?=
 =?us-ascii?Q?IgTkt2J4I9AJv1w6xKZxxPNCj/uv8KL9xaA5vMJyEMqgCTsfzaG4BFc6ysBL?=
 =?us-ascii?Q?jPFMFZDouL1Gq5snHMC8hI4mVuNBHv0Yy1s3Hp2FXI5TgtOKmbpjta0GZYZL?=
 =?us-ascii?Q?4zTH/WnDQQDrLwIxGbm3z1fLNo3rPEIn2Yu5VR6NsB+vKVaUqJuqdGCvE+2f?=
 =?us-ascii?Q?9dcabwqLW4spcrSrkW5MlTUcXsLH9O1ejCTN5DlXW+bKV3+QNy5yTGU3kUwX?=
 =?us-ascii?Q?DteYhm3LFEa5ubRZ6SEUYxDCKrAfr3kd+BoZfrYSUQThRXJAK21MYYPqyX9j?=
 =?us-ascii?Q?ROb9rrP2ZaCsisqAwXCgIJoDU9hw3at/pBoMH4LyQ42ezWaFkETUj5YBtenk?=
 =?us-ascii?Q?n0vo18cmQglagtlevCdEPHaa90K3MLwMLjO9uId5pYCyfdhOGuBRBvECJzoJ?=
 =?us-ascii?Q?6Panoif4H4if9MGG0Gb7hAcZQSkHoEczu2CZBsrshDXf8/pZJJzpToTPEl1t?=
 =?us-ascii?Q?Whj8ryIQkltucol4cb92HO9+Pg1EckAsv4IuSF+k2eVRM2GQJdr3RCI+MVHf?=
 =?us-ascii?Q?IQ+qZIRYM0T7en1GUHyg6HxL7bKpePcjzxPt6HQ6HtuMelIXcNCnMUARAFDT?=
 =?us-ascii?Q?RjH3ketG7W9HIQcjoU+Qp8CQQpBy7D/CoFea6lEN7YYAZKP0yXlF8JlK0TWN?=
 =?us-ascii?Q?zdxHUjryAVuzxGMrZkyFBp4VL21c5cnxVC7I+NNzqw/Bba8R9sMZ08OqlB85?=
 =?us-ascii?Q?/M5UBWnJSUpe+7hj4xI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:33.8986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33444c21-29bd-483f-2e48-08de3c8988fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

From: ChunTao Tso <chuntao.tso@amd.com>

[WHY]
The set_replay_frame_skip_number() function should not execute when
the link does not support the Frame Skipping feature.

[HOW]
Add a new field `frame_skip_supported` to struct replay_config to
indicate whether the link supports frame skipping. Check this flag
at the beginning of set_replay_frame_skip_number() and return early
if the feature is not supported.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 2 ++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index cf4bf0faf1cd..455b22350ae8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1185,6 +1185,8 @@ struct replay_config {
 	bool os_request_force_ffu;
 	/* Replay optimization */
 	union replay_optimization replay_optimization;
+	/* Replay sub feature Frame Skipping is supported */
+	bool frame_skip_supported;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index fd139b219bf9..864002b63716 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -984,6 +984,9 @@ void set_replay_frame_skip_number(struct dc_link *link,
 	uint32_t *frame_skip_number_array = NULL;
 	uint32_t frame_skip_number = 0;
 
+	if (false == link->replay_settings.config.frame_skip_supported)
+		return;
+
 	if (link == NULL || flicker_free_refresh_rate_mhz == 0 || coasting_vtotal_refresh_rate_mhz == 0)
 		return;
 
-- 
2.43.0

