Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94EEE7718E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23AC10F077;
	Fri, 20 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEVBmWK1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C231B10F07C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBP7hWowJy4GFblyDZKOd0K584yFEkYHlJqtYCnGoqhR9uXWUDkbQYcUVeTJvFGbEbWtApR+aoDjpZA1b+6WE5B82J7DGu10laBYvBQhO8EgRNSUQk9n4ydwTcM6UKe5L1EqLfWvlkDHQSrtuCgXs/xBjaexjekhvCBh1unsQf0UGdbuH2cEp0anqtEPvjdl5orUoSuqNoieUOB6hYjisxS6q8qrJBpekVQnTsO7mHXjj5cH/alMR++f4ZGGLDc0ibhjo879nkQs5r5+IgAs8GtheqyAXhZvTJ7yDdERH8/92/f35ZcI1Xlti6NSY2X/uV8v0J11xfvVcDYMXL7yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwkuiD3ETnRS79Dm1Fnxl9xrVj4CfAXakE/TaI2hl04=;
 b=loCdFPHadUllQFT22jUkGjMfdN5JP8udBxSVPVAnK3uX0K8LYI5unhlQiGzQvXoQYRzpjNLXo4W2b2Ln7CjkuJRKY5w1V5V1hE/2sQd1lkcqkz3/qlGiwdU+1VlafK2Lt6KtEU8mAwI+hfdKfBbKTlOjOyGHghkq+65ATk3oJ8QSGbaM1JH8UZDhLSU4nqmGypm2OIpIyE37+ggrlyxDE/jU6mB2+3pyAvvEgx/8Ns37a1LhmwjSYUNgxogp5+YlZzGLPQuKFJ0nUKVosfRF4QetCW4LAEBVD8bMj5WDT63TpoUL2xXxYlPaqLMYPQ8RvaWo4JWOiszezUiVGPI5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwkuiD3ETnRS79Dm1Fnxl9xrVj4CfAXakE/TaI2hl04=;
 b=mEVBmWK1m8vcvlk9c1JB5N0KaazJuGJIi0gFYDxczms6BVQA90s85gEWyIrJ8m6yIFGpf80LBDEaSlprQ0M5LEcma4+EVn09CEIrGdsjZEd8TctW4KphJDJM4Cm2GiNtKvJ4tiOptZDybghfZ/QmY5HO7uWl6/Tm82sK9aIMgmk=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 21:51:19 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::8b) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Fri,
 20 Dec 2024 21:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:17 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:16 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Karthi
 Kandasamy" <karthi.kandasamy@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 16/28] drm/amd/display: Update dc_tiling_info union to
 structure
Date: Fri, 20 Dec 2024 16:48:43 -0500
Message-ID: <20241220214855.2608618-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1a8ac6-678b-4927-a816-08dd21406f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mzNazdz7qp60nhkT7eQBs7mjtLJhfUBsycjighLNQCSAgTrx8ZAvOnhjXSSu?=
 =?us-ascii?Q?uHY3bimX8JLXrVbR7EITsk61aW4G+xTFyhAV+wPHQZcthgUd630eu/BBs4Wd?=
 =?us-ascii?Q?RI7T0XGI9xtuZM5l8YDhuWxm2phkDCKm8YAn9Z6qYUBu35DVGisrbc7uel4j?=
 =?us-ascii?Q?9m6mBvInrXLTUYygPeKvtn8JPMWhEME3/yNXop6InfKPa1rVIEQYcuxCsalI?=
 =?us-ascii?Q?JsjZVLxfyRZwkGhOpJp4YOuP2A7+I3QAsa+kuKUkSAbN20RCFq2oHI8CbNgO?=
 =?us-ascii?Q?hBsBMocbb2nKoKekaAR9CUh/ewrZkEDeATYasCR+nUj3tPxs3HicBUF9f9rr?=
 =?us-ascii?Q?KdoSn87DVqElp7XNG1ebv0CK2RRewFuo+wh2fSA5rSEGhwB9ePQgcAea1G1q?=
 =?us-ascii?Q?OXIhsqn3zj4q/RNCUIeL7Y7dFZIXm8f963UsUGcdYiJKUqxIVS3DbNvqgcs6?=
 =?us-ascii?Q?HkGsdL+O27RRuluncd60PuFu5iB4NoK8IWOfYmKSCKBSFXsnOK0aOI8p0zyJ?=
 =?us-ascii?Q?gl6bB+DeLlnl43JQgQtDmO2gS8zKDiW8zgso35llFm3BqRDcm/nXFhYds6WK?=
 =?us-ascii?Q?ZJZuToFEGjDdLFIhnBWuEHVhl/2wj1MG3BzA8j3xkdwWss1TjHaf1Pqj7wvc?=
 =?us-ascii?Q?RXdsGgv1TO9PGID90pRHP5dZJ5uCTdhmP7BawpqtWQy0pJkBLqTvofx9gyaX?=
 =?us-ascii?Q?FNSTFypIe7Z76UFtlmzonDTWsjLZkwPOPSKMs/N0Z69HmDpllRZ/+FrMt2mL?=
 =?us-ascii?Q?z7BQpfSm/SO1w+Db5shVtzcJQSegXyy9bGYL3xxH3ya+5FZieKMreqROHjJK?=
 =?us-ascii?Q?Vta8vWhP1B+xWX11W/wiKV+S1kbApUF6fohqoFcfOhgAP8LNX372bsLxfgQd?=
 =?us-ascii?Q?L58BVNaPN359ek8nBvF/okx5wGZD2Tee3wbn5wPCbMEtLtt5t/ynwE0lplQ4?=
 =?us-ascii?Q?p6nIOGD90AGdjzo1APe6srG6ekztkxCDsf6Y+Yvo1iLJNDfBuOPcD9D96d2A?=
 =?us-ascii?Q?6LR3TIzm2hLgR7+O6qRIoM3FdEMseb4r49SL0xZr6ui4EEMU7+HHagonBPf+?=
 =?us-ascii?Q?HDbW0Puud5TdZsQDTA3IyMB5uCmBvgJHgBL6zlOrH03cUT7siUEPvvtrnf24?=
 =?us-ascii?Q?kWxOXGDOs4Ss5MlUJqdbv0KnDj61hmAog312aS7uHZ1oajTuO4r768N6ApAk?=
 =?us-ascii?Q?1pWCzxVEc1B5ZhNxSmRD1tQ/D0VaEezrBeJ9jDVzQ3eWBnA2UOXUmxh/GdNd?=
 =?us-ascii?Q?OZek1RZimkWujyEBsjhIQuzDPrviZZm7CZx2lrvx/Z7Mf+ylpAdzzOsAY/Lz?=
 =?us-ascii?Q?gGHNhk3bZxHVq3t6jHS/U829yPb7pLFCfsVEbiuLIwzquyitspgl9y7Galbf?=
 =?us-ascii?Q?HPhIeclKaEK2xZ0HtvmNSQUSt5M9Xjzf5Y+UaH8mGgKXsZtkU6LuAnf36fiS?=
 =?us-ascii?Q?EWwaykRdCynWJ7aMNNJ+dD9rzqseOdIYupX65rPI0n4/wVAOkLDaFiNbfKVb?=
 =?us-ascii?Q?EcS9XZHnEGU3Ipo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:18.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a8ac6-678b-4927-a816-08dd21406f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[WHY]
The `dc_tiling_info` union previously did not have a field to
specify the active GFX format, assuming only one format would
be used per DCN version. from DCN4+, support for switching
between different GFX formats is introduced, requiring a way
to track which format is currently in use.

[HOW]
Updated the `dc_tiling_info` union to include a new field that
explicitly indicates the currently used GFX format.
This allows the system to determine the active GFX format
and take the correct programming path accordingly.

[Description]
The union `dc_tiling_info` has been updated to support multiple
GFX formats by adding a new field for identifying the active format.
This update ensures that the correct programming path is followed
based on the selected format. All references to `dc_tiling_info`
in the codebase have been updated to reflect the new structure.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 176 ++++++++++--------
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  10 +-
 .../display/dc/dce110/dce110_mem_input_v.c    |   8 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   2 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |   2 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   4 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   4 +-
 20 files changed, 136 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1ec4e4b9ea94..db8c55cc865e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -177,7 +177,7 @@ static unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
 
-static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
+static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_info *tiling_info,
 							     uint64_t tiling_flags)
 {
 	/* Fill GFX8 params */
@@ -210,7 +210,7 @@ static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(union dc_tiling_inf
 }
 
 static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-							      union dc_tiling_info *tiling_info)
+							      struct dc_tiling_info *tiling_info)
 {
 	/* Fill GFX9 params */
 	tiling_info->gfx9.num_pipes =
@@ -231,7 +231,7 @@ static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgp
 }
 
 static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-								union dc_tiling_info *tiling_info,
+								struct dc_tiling_info *tiling_info,
 								uint64_t modifier)
 {
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
@@ -261,7 +261,7 @@ static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amd
 static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 					const enum surface_pixel_format format,
 					const enum dc_rotation_angle rotation,
-					const union dc_tiling_info *tiling_info,
+					const struct dc_tiling_info *tiling_info,
 					const struct dc_plane_dcc_param *dcc,
 					const struct dc_plane_address *address,
 					const struct plane_size *plane_size)
@@ -308,7 +308,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 								     const enum surface_pixel_format format,
 								     const enum dc_rotation_angle rotation,
 								     const struct plane_size *plane_size,
-								     union dc_tiling_info *tiling_info,
+								     struct dc_tiling_info *tiling_info,
 								     struct dc_plane_dcc_param *dcc,
 								     struct dc_plane_address *address)
 {
@@ -358,7 +358,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 								      const enum surface_pixel_format format,
 								      const enum dc_rotation_angle rotation,
 								      const struct plane_size *plane_size,
-								      union dc_tiling_info *tiling_info,
+								      struct dc_tiling_info *tiling_info,
 								      struct dc_plane_dcc_param *dcc,
 								      struct dc_plane_address *address)
 {
@@ -834,7 +834,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const enum surface_pixel_format format,
 			     const enum dc_rotation_angle rotation,
 			     const uint64_t tiling_flags,
-			     union dc_tiling_info *tiling_info,
+			     struct dc_tiling_info *tiling_info,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
 			     struct dc_plane_address *address,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 2eef13b1c05a..615d2ab2b803 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -47,7 +47,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 				 const enum surface_pixel_format format,
 				 const enum dc_rotation_angle rotation,
 				 const uint64_t tiling_flags,
-				 union dc_tiling_info *tiling_info,
+				 struct dc_tiling_info *tiling_info,
 				 struct plane_size *plane_size,
 				 struct dc_plane_dcc_param *dcc,
 				 struct dc_plane_address *address,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9c7c3f4a94f1..4742a4ad19bd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2555,7 +2555,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc *dc,
 
 
 	if (memcmp(&u->plane_info->tiling_info, &u->surface->tiling_info,
-			sizeof(union dc_tiling_info)) != 0) {
+			sizeof(struct dc_tiling_info)) != 0) {
 		update_flags->bits.swizzle_change = 1;
 		elevate_update_type(&update_type, UPDATE_TYPE_MED);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 363fbb64b1a9..063f853160d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1306,7 +1306,7 @@ struct dc_plane_state {
 	struct rect clip_rect;
 
 	struct plane_size plane_size;
-	union dc_tiling_info tiling_info;
+	struct dc_tiling_info tiling_info;
 
 	struct dc_plane_dcc_param dcc;
 
@@ -1377,7 +1377,7 @@ struct dc_plane_state {
 
 struct dc_plane_info {
 	struct plane_size plane_size;
-	union dc_tiling_info tiling_info;
+	struct dc_tiling_info tiling_info;
 	struct dc_plane_dcc_param dcc;
 	enum surface_pixel_format format;
 	enum dc_rotation_angle rotation;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 8a6e3dfa4230..5ac55601a6da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -341,89 +341,101 @@ enum swizzle_mode_addr3_values {
 	DC_ADDR3_SW_UNKNOWN = DC_ADDR3_SW_MAX
 };
 
-union dc_tiling_info {
-
-	struct {
-		/* Specifies the number of memory banks for tiling
-		 *	purposes.
-		 * Only applies to 2D and 3D tiling modes.
-		 *	POSSIBLE VALUES: 2,4,8,16
-		 */
-		unsigned int num_banks;
-		/* Specifies the number of tiles in the x direction
-		 *	to be incorporated into the same bank.
-		 * Only applies to 2D and 3D tiling modes.
-		 *	POSSIBLE VALUES: 1,2,4,8
-		 */
-		unsigned int bank_width;
-		unsigned int bank_width_c;
-		/* Specifies the number of tiles in the y direction to
-		 *	be incorporated into the same bank.
-		 * Only applies to 2D and 3D tiling modes.
-		 *	POSSIBLE VALUES: 1,2,4,8
-		 */
-		unsigned int bank_height;
-		unsigned int bank_height_c;
-		/* Specifies the macro tile aspect ratio. Only applies
-		 * to 2D and 3D tiling modes.
-		 */
-		unsigned int tile_aspect;
-		unsigned int tile_aspect_c;
-		/* Specifies the number of bytes that will be stored
-		 *	contiguously for each tile.
-		 * If the tile data requires more storage than this
-		 *	amount, it is split into multiple slices.
-		 * This field must not be larger than
-		 *	GB_ADDR_CONFIG.DRAM_ROW_SIZE.
-		 * Only applies to 2D and 3D tiling modes.
-		 * For color render targets, TILE_SPLIT >= 256B.
-		 */
-		enum tile_split_values tile_split;
-		enum tile_split_values tile_split_c;
-		/* Specifies the addressing within a tile.
-		 *	0x0 - DISPLAY_MICRO_TILING
-		 *	0x1 - THIN_MICRO_TILING
-		 *	0x2 - DEPTH_MICRO_TILING
-		 *	0x3 - ROTATED_MICRO_TILING
-		 */
-		enum tile_mode_values tile_mode;
-		enum tile_mode_values tile_mode_c;
-		/* Specifies the number of pipes and how they are
-		 *	interleaved in the surface.
-		 * Refer to memory addressing document for complete
-		 *	details and constraints.
-		 */
-		unsigned int pipe_config;
-		/* Specifies the tiling mode of the surface.
-		 * THIN tiles use an 8x8x1 tile size.
-		 * THICK tiles use an 8x8x4 tile size.
-		 * 2D tiling modes rotate banks for successive Z slices
-		 * 3D tiling modes rotate pipes and banks for Z slices
-		 * Refer to memory addressing document for complete
-		 *	details and constraints.
-		 */
-		enum array_mode_values array_mode;
-	} gfx8;
+enum dc_gfxversion {
+	DcGfxVersion7 = 0,
+	DcGfxVersion8,
+	DcGfxVersion9,
+	DcGfxVersion10,
+	DcGfxVersion11,
+	DcGfxAddr3,
+	DcGfxVersionUnknown
+};
+
+ struct dc_tiling_info {
+	unsigned int gfxversion;     // Specifies which part of the union to use. Must use DalGfxVersion enum
+	union {
+		struct {
+			/* Specifies the number of memory banks for tiling
+			 *	purposes.
+			 * Only applies to 2D and 3D tiling modes.
+			 *	POSSIBLE VALUES: 2,4,8,16
+			 */
+			unsigned int num_banks;
+			/* Specifies the number of tiles in the x direction
+			 *	to be incorporated into the same bank.
+			 * Only applies to 2D and 3D tiling modes.
+			 *	POSSIBLE VALUES: 1,2,4,8
+			 */
+			unsigned int bank_width;
+			unsigned int bank_width_c;
+			/* Specifies the number of tiles in the y direction to
+			 *	be incorporated into the same bank.
+			 * Only applies to 2D and 3D tiling modes.
+			 *	POSSIBLE VALUES: 1,2,4,8
+			 */
+			unsigned int bank_height;
+			unsigned int bank_height_c;
+			/* Specifies the macro tile aspect ratio. Only applies
+			 * to 2D and 3D tiling modes.
+			 */
+			unsigned int tile_aspect;
+			unsigned int tile_aspect_c;
+			/* Specifies the number of bytes that will be stored
+			 *	contiguously for each tile.
+			 * If the tile data requires more storage than this
+			 *	amount, it is split into multiple slices.
+			 * This field must not be larger than
+			 *	GB_ADDR_CONFIG.DRAM_ROW_SIZE.
+			 * Only applies to 2D and 3D tiling modes.
+			 * For color render targets, TILE_SPLIT >= 256B.
+			 */
+			enum tile_split_values tile_split;
+			enum tile_split_values tile_split_c;
+			/* Specifies the addressing within a tile.
+			 *	0x0 - DISPLAY_MICRO_TILING
+			 *	0x1 - THIN_MICRO_TILING
+			 *	0x2 - DEPTH_MICRO_TILING
+			 *	0x3 - ROTATED_MICRO_TILING
+			 */
+			enum tile_mode_values tile_mode;
+			enum tile_mode_values tile_mode_c;
+			/* Specifies the number of pipes and how they are
+			 *	interleaved in the surface.
+			 * Refer to memory addressing document for complete
+			 *	details and constraints.
+			 */
+			unsigned int pipe_config;
+			/* Specifies the tiling mode of the surface.
+			 * THIN tiles use an 8x8x1 tile size.
+			 * THICK tiles use an 8x8x4 tile size.
+			 * 2D tiling modes rotate banks for successive Z slices
+			 * 3D tiling modes rotate pipes and banks for Z slices
+			 * Refer to memory addressing document for complete
+			 *	details and constraints.
+			 */
+			enum array_mode_values array_mode;
+		} gfx8;
 
-	struct {
-		enum swizzle_mode_values swizzle;
-		unsigned int num_pipes;
-		unsigned int max_compressed_frags;
-		unsigned int pipe_interleave;
-
-		unsigned int num_banks;
-		unsigned int num_shader_engines;
-		unsigned int num_rb_per_se;
-		bool shaderEnable;
-
-		bool meta_linear;
-		bool rb_aligned;
-		bool pipe_aligned;
-		unsigned int num_pkrs;
-	} gfx9;/*gfx9, gfx10 and above*/
-	struct {
-		enum swizzle_mode_addr3_values swizzle;
-	} gfx_addr3;/*gfx with addr3 and above*/
+		struct {
+			enum swizzle_mode_values swizzle;
+			unsigned int num_pipes;
+			unsigned int max_compressed_frags;
+			unsigned int pipe_interleave;
+
+			unsigned int num_banks;
+			unsigned int num_shader_engines;
+			unsigned int num_rb_per_se;
+			bool shaderEnable;
+
+			bool meta_linear;
+			bool rb_aligned;
+			bool pipe_aligned;
+			unsigned int num_pkrs;
+		} gfx9;/*gfx9, gfx10 and above*/
+		struct {
+			enum swizzle_mode_addr3_values swizzle;
+		} gfx_addr3;/*gfx with addr3 and above*/
+	};
 };
 
 /* Rotation angle */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index ebd174be5786..1c2009e38aa1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -98,7 +98,7 @@ static enum mi_bits_per_pixel get_mi_bpp(
 }
 
 static enum mi_tiling_format get_mi_tiling(
-		union dc_tiling_info *tiling_info)
+		struct dc_tiling_info *tiling_info)
 {
 	switch (tiling_info->gfx8.array_mode) {
 	case DC_ARRAY_1D_TILED_THIN1:
@@ -133,7 +133,7 @@ static bool is_vert_scan(enum dc_rotation_angle rotation)
 static void dce_mi_program_pte_vm(
 		struct mem_input *mi,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		enum dc_rotation_angle rotation)
 {
 	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
@@ -430,7 +430,7 @@ static void dce120_mi_program_display_marks(struct mem_input *mi,
 }
 
 static void program_tiling(
-	struct dce_mem_input *dce_mi, const union dc_tiling_info *info)
+	struct dce_mem_input *dce_mi, const struct dc_tiling_info *info)
 {
 	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
 		REG_UPDATE_6(GRPH_CONTROL,
@@ -650,7 +650,7 @@ static void dce_mi_clear_tiling(
 static void dce_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
@@ -670,7 +670,7 @@ static void dce_mi_program_surface_config(
 static void dce60_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation, /* not used in DCE6 */
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 8a3fbf95c48f..2c43c2422638 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -162,7 +162,7 @@ static void enable(struct dce_mem_input *mem_input110)
 
 static void program_tiling(
 	struct dce_mem_input *mem_input110,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
 	uint32_t value = 0;
@@ -523,7 +523,7 @@ static const unsigned int dvmm_Hw_Setting_Linear[4][9] = {
 
 /* Helper to get table entry from surface info */
 static const unsigned int *get_dvmm_hw_setting(
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		enum surface_pixel_format format,
 		bool chroma)
 {
@@ -563,7 +563,7 @@ static const unsigned int *get_dvmm_hw_setting(
 static void dce_mem_input_v_program_pte_vm(
 		struct mem_input *mem_input,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		enum dc_rotation_angle rotation)
 {
 	struct dce_mem_input *mem_input110 = TO_DCE_MEM_INPUT(mem_input);
@@ -636,7 +636,7 @@ static void dce_mem_input_v_program_pte_vm(
 static void dce_mem_input_v_program_surface_config(
 	struct mem_input *mem_input,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index f0ba944553df..8364c9f9231a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -140,7 +140,7 @@ void hubp1_vready_workaround(struct hubp *hubp,
 
 void hubp1_program_tiling(
 	struct hubp *hubp,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
@@ -549,7 +549,7 @@ void hubp1_dcc_control(struct hubp *hubp, bool enable,
 void hubp1_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index 631350cd4f2e..a85dc3be786f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -706,7 +706,7 @@ struct dcn10_hubp {
 void hubp1_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
@@ -739,7 +739,7 @@ void hubp1_program_rotation(
 
 void hubp1_program_tiling(
 	struct hubp *hubp,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format);
 
 void hubp1_dcc_control(struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 200194544bf0..c74f6a3313a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -310,7 +310,7 @@ void hubp2_setup_interdependent(
  */
 static void hubp2_program_tiling(
 	struct dcn20_hubp *hubp2,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
 	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
@@ -550,7 +550,7 @@ void hubp2_program_pixel_format(
 void hubp2_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 7fd9240868c3..6968087a3605 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -382,7 +382,7 @@ void hubp2_program_pixel_format(
 void hubp2_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
index d910e4a54c34..65c628078ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -42,7 +42,7 @@
 static void hubp201_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 3b16c3cda2c3..12b282ed7067 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -318,7 +318,7 @@ bool hubp3_program_surface_flip_and_addr(
 
 void hubp3_program_tiling(
 	struct dcn20_hubp *hubp2,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
 	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
@@ -411,7 +411,7 @@ void hubp3_dmdata_set_attributes(
 void hubp3_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index cfb01bf340a1..b7d7adf0b58c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -264,7 +264,7 @@ bool hubp3_program_surface_flip_and_addr(
 void hubp3_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
@@ -280,7 +280,7 @@ void hubp3_setup(
 
 void hubp3_program_tiling(
 		struct dcn20_hubp *hubp2,
-		const union dc_tiling_info *info,
+		const struct dc_tiling_info *info,
 		const enum surface_pixel_format pixel_format);
 
 void hubp3_dcc_control(struct hubp *hubp, bool enable,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index eb62042dfafc..faf37febc6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -172,7 +172,7 @@ void hubp35_program_pixel_format(
 void hubp35_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
index 586b43aa5834..d913f80b3130 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.h
@@ -65,7 +65,7 @@ void hubp35_program_pixel_format(
 void hubp35_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 09f730cfbf8e..d38e3f3a1107 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -532,7 +532,7 @@ void hubp401_dcc_control(struct hubp *hubp,
 
 void hubp401_program_tiling(
 	struct dcn20_hubp *hubp2,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
 	/* DCSURF_ADDR_CONFIG still shows up in reg spec, but does not need to be programmed for DCN4x
@@ -580,7 +580,7 @@ void hubp401_program_size(
 void hubp401_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 9b200a55bf9d..9e2cf8b5e344 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -290,7 +290,7 @@ void hubp401_dcc_control(struct hubp *hubp,
 
 void hubp401_program_tiling(
 	struct dcn20_hubp *hubp2,
-	const union dc_tiling_info *info,
+	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format);
 
 void hubp401_program_size(
@@ -302,7 +302,7 @@ void hubp401_program_size(
 void hubp401_program_surface_config(
 	struct hubp *hubp,
 	enum surface_pixel_format format,
-	union dc_tiling_info *tiling_info,
+	struct dc_tiling_info *tiling_info,
 	struct plane_size *plane_size,
 	enum dc_rotation_angle rotation,
 	struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index d0878fc0cc94..93529dc196c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -165,7 +165,7 @@ struct hubp_funcs {
 	void (*hubp_program_pte_vm)(
 		struct hubp *hubp,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		enum dc_rotation_angle rotation);
 
 	void (*hubp_set_vm_system_aperture_settings)(
@@ -179,7 +179,7 @@ struct hubp_funcs {
 	void (*hubp_program_surface_config)(
 		struct hubp *hubp,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		struct plane_size *plane_size,
 		enum dc_rotation_angle rotation,
 		struct dc_plane_dcc_param *dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index 4f5d102455ca..42fbc70f7056 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -150,7 +150,7 @@ struct mem_input_funcs {
 	void (*mem_input_program_pte_vm)(
 		struct mem_input *mem_input,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		enum dc_rotation_angle rotation);
 
 	void (*mem_input_set_vm_system_aperture_settings)(
@@ -164,7 +164,7 @@ struct mem_input_funcs {
 	void (*mem_input_program_surface_config)(
 		struct mem_input *mem_input,
 		enum surface_pixel_format format,
-		union dc_tiling_info *tiling_info,
+		struct dc_tiling_info *tiling_info,
 		struct plane_size *plane_size,
 		enum dc_rotation_angle rotation,
 		struct dc_plane_dcc_param *dcc,
-- 
2.34.1

