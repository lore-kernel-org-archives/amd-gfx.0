Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A7606A335
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BZsHK204
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0972510F84D;
	Tue, 17 Nov 2026 17:17:38 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E77010F847
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc/CWrQOmS+d+10hJN4kTLMibhtxUp03XGrLdF0JgJTKLaZeUIoF2gCbPsN7SGNdDTrM6e+CdAKIgn2LavJxwSfSDNcm8anLtpnanUAcuXuUxZU+SuoAvKZyZIitqob1uMqvfZrB0MdbqDMNQYsSyYiMmyF6Nd3KDpoex4Nq+ITcGrn52OZ3c1SHUtVCTB8Wra3/UgJI8OFgTNRvFE/pNgnn3zSVvnGGVgLko4Vw2Kubbk5rQuaP2Pp6Kw7G133/Br4AVQ7KOMJw8m1B2LhtPXgPTyvUeeiB7cMqfq0rUx5lgIWuYLlFdO4EXPcENqxFy4zOFomPhA9gXvxiRDE28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAaQxxc4GPMZ5lLoYTQyc2NHhr3KvUrjTtBrJTKrFmY=;
 b=BG8UfWlDe32QFTG7+la+HbmDhTuH5k1LDBNerILoqWKs/MRCKAA/b3APQXFFE+o6iDXWgjWdgtFbXO7zr0uLAV1uXnzo3knKguT9hLfWInnrZPcvSfPWdSrDFBAtP5n0KCVDBQSmV0M7W/f59sm2deAymyG/F2BA+V3i8MDvvCf8V/kgCGVT8FjzctNbng5eHWoWTBDkA7V/vTx9oIcN3CjgkUjajS3QLYEMBkxGM7OtB/jBUzr2SrNeVRnIMAd4aBNYY/OPCwEXl+VmbpO0tBs7+W45pkeaIXKefsX1M6K7+Rq5J7tahRORBg9QkG/vnjq/bR9ge0irJTtaOPeZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAaQxxc4GPMZ5lLoYTQyc2NHhr3KvUrjTtBrJTKrFmY=;
 b=BZsHK204KFqYWNbXSUzoJJotsuqkPSBjK53RCTxHz+258+fXJ3/qkkeMHdu4WODdfO7YtMz0cIxgw0Xya7bUw3stosCfroJEYeIlRvmrZH9OQRF9FG+9R0Rx7u6woM6ubH/cagKTStLP3pR89dS39fNJTejgiy7fcoV2fRlqjtk=
Received: from BN9PR03CA0131.namprd03.prod.outlook.com (2603:10b6:408:fe::16)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:17:22 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::6c) by BN9PR03CA0131.outlook.office365.com
 (2603:10b6:408:fe::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Tue,
 17 Nov 2026 17:17:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:17:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:17:19 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:17:10 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 James Lin <pinglei.lin@amd.com>
Subject: [PATCH 30/33] drm/amd/display: Add RGBA8888 surface pixel format
 support
Date: Tue, 17 Nov 2026 05:51:07 +0800
Message-ID: <20261116215641.2800595-31-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: d5df8086-bdeb-4cea-78ac-08df44cea3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|261009223027099003|13003099007|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022113327099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: dNrXV1PsTeaHwq0eFyn1mSzlk+8q0yb0VrmlJxUUO32T8q1N8K4rM946dOLCVjcidMWnaFrOlE7ZnyEdNeYTeo40SbbiOIES4OM9IgW+cXYgdrXV/H6/sRTzPoCekDZcI9iZaVIUiHgSZt9CEemutCjN5Pj9CPlavOub9BiAd9G9en2pfaBiGLaQxqGbxrF+HUzxEDRRLaaousYjPf4pciAkhB6YyOKbxGKNb24xCYSzaTjEHsOnGixDhRSoPZQu1N5FDXFvB+Yev7668W3GiIf1ZWi8n0fC3ZGtijImQfFOdNlea27MJDH/BtWotTgeB1TvON3L5le84jwX+Vd+8D4+UURWMjjnsvwyz/0W87tATXP4gX0aVWZJbhap8ESeKCBRdfBbH3BilWgmUNWM0p8Hdsa+lqQz0CIm4aQkTwLU9y81xaPPuACv+m5G54QwHP1lSFNWMM6pGkilUZSnlhewPXo/Hp2741rFdFKhfvwvJfmq+t7OVj5s8zn1ZdNLx4c23SOFKfSV+ozqPgX6OtuRr/QrfW/4aElXBxMl15Nvs7DvSlMk1XV5zQYykOS0QW3O0TcELgGt95GqKley6AqlCfXzNbXIvZkLw2Hng/b7mmsTWL65Kb+ZP8Duv3j6trxq7jiNRLKHD1q0AEeK7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022113327099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6HFnOemLdeq5thBlUT82kPy9MDURLztcAJvmzV46L4roCVPOWxkLr07stdJz07gu6fQqGtjUXRoYiw37LLeIy8+D0Ax6jJRVGYNfwxqX7lG+VkiGccOsZfFZ5lIpFdQ7jmup/LQf8P6BclZwR8qI70VpLg3/VKmo0OxptntohfCfsIsYE8Hh4d299Tb3Guw7yjcNvlNrneqAiJQrpQqxJs8OB4qM6HT6qnqZWIKubEogB2kQQR4O3LkzQdqfoLWdHOQ9Lxo8SIo9v11FXzcQWNMXaQCCCNhfy+6KFyvA8k+tcqtWxZ5wbGjaOis6Q2JZSZFn+4NvoeXV8jsgDaRusA8N/LftC0ixXeOEdA2AuBI9OlIsUZfSF8XoAQ6Vucar9Cm3ORC5Ra2kyuXzggC1a297jWMfIVmhAz81MWrJEyjdh0tzGfuPUVMuwNctAidZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:17:20.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5df8086-bdeb-4cea-78ac-08df44cea3a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harry Wentland <harry.wentland@amd.com>

[why]
amdgpu_dm advertises DRM_FORMAT_RGBA8888 for its planes, but DC has no
matching surface pixel format, so fill_dc_plane_info_and_addr()
rejects the format with -EINVAL. KWin modesets then fail with
"Unsupported screen format RA24 little-endian".

[how]
- Add SURFACE_PIXEL_FORMAT_GRPH_RGBA8888 to the surface_pixel_format
  enum.
- Map DRM_FORMAT_RGBA8888 to the new format in amdgpu_dm.
- Program the dedicated RGBA8888 encoding (value 9) in HUBP and DPP
  for all DCN generations. Unlike ABGR8888, there is no red/blue
  crossbar swap.
- Treat RGBA8888 as a 32bpp graphics format in bandwidth,
  bytes-per-pixel, DCC, and format-class helpers, the same as
  ARGB8888.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5339

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            | 3 +++
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c            | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c            | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                 | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c           | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c         | 1 +
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c | 1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c       | 4 ++++
 drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c          | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 1 +
 25 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29d7c87a94ef..b6b67f730415 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3105,6 +3105,9 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 	case DRM_FORMAT_ARGB8888:
 		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
 		break;
+	case DRM_FORMAT_RGBA8888:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_RGBA8888;
+		break;
 	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_ARGB2101010:
 		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010;
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index 1b8e843020d6..1ff1a6c23c65 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -2853,6 +2853,7 @@ static void populate_initial_data(
 			break;
 		case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 		case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+		case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 		case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 		case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
@@ -2957,6 +2958,7 @@ static void populate_initial_data(
 				break;
 			case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 			case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+			case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 			case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 			case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 			case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b09490c84438..ec11a79811e7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -808,6 +808,9 @@ static enum dc_pixel_format convert_pixel_format_to_dalsurface(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		dal_pixel_format = PIXEL_FORMAT_ARGB8888;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		dal_pixel_format = PIXEL_FORMAT_ARGB8888;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 		dal_pixel_format = PIXEL_FORMAT_ARGB2101010;
 		break;
@@ -5905,6 +5908,7 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format)
 		return 16;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 387d2ebb2b7c..a361f5d9af50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -176,6 +176,8 @@ enum surface_pixel_format {
 	SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
 	/*32 bpp swaped*/
 	SURFACE_PIXEL_FORMAT_GRPH_ABGR8888,
+	/*32 bpp, alpha in LSB*/
+	SURFACE_PIXEL_FORMAT_GRPH_RGBA8888,
 
 	SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010,
 	/*swaped*/
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 168c2d0a5eaa..08cde29a4a7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -593,6 +593,7 @@ static void program_grph_pixel_format(
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 		grph_depth = 2;
 		grph_format = 0;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 095869912c09..9d781d12d669 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -381,6 +381,7 @@ static void program_pixel_format(
 			break;
 		case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 		case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+		case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 			grph_depth = 2;
 			grph_format = 0;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 2ad4a2635683..ec25a76dc3f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -231,6 +231,7 @@ static enum dcn_bw_defs tl_pixel_format_to_bw_defs(enum surface_pixel_format for
 		return dcn_bw_rgb_sub_16;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index de420cdf1514..1156027198a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -344,6 +344,9 @@ void dpp1_cnv_setup (
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
index 0f3b1717563b..5bf86b3cc388 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c
@@ -143,6 +143,9 @@ static void dpp2_cnv_setup (
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
index a2079db62f63..37a877f5b3e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c
@@ -87,6 +87,9 @@ static void dpp201_cnv_setup(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 3db10019fa84..58260e0a2172 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -337,6 +337,9 @@ void dpp3_cnv_setup (
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 7a3a7678c71a..379fe0f5531a 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -99,6 +99,9 @@ void dpp401_dpp_setup(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
index 2ce0694e3725..b0c1545fe3ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
@@ -159,6 +159,9 @@ static void dpp42_dpp_setup(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
index 5382fc656169..8857b7b33ab9 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
@@ -131,6 +131,9 @@ void dpp50_dpp_setup(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index dfdbc539ac42..210e6658ac61 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -63,6 +63,9 @@ void dpp60_dpp_setup(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		pixel_format = 8;
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		pixel_format = 9;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		pixel_format = 10;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index faad1c6f4509..238824369e00 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -761,6 +761,7 @@ static bool hubbub1_dcc_support_pixel_format(
 		return true;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 		*bytes_per_element = 4;
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 464fc5924a56..6cfcce7bb48f 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -147,6 +147,7 @@ bool hubbub2_dcc_support_pixel_format(
 		return true;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index c18457c779de..cc3fda2c470c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -672,6 +672,7 @@ bool hubbub401_dcc_support_pixel_format(
 		return true;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 2a4be0c7a724..4723a390297c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -272,6 +272,10 @@ void hubp1_program_pixel_format(
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 8);
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 9);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 79a429814061..e82bb43be001 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -473,6 +473,10 @@ void hubp2_program_pixel_format(
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 8);
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 9);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index c879f4901c7d..69b5d41c959e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -94,6 +94,10 @@ void hubp35_program_pixel_format(
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 8);
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 9);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 0c8a23cef1e0..b70fc7c1c80d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -78,6 +78,10 @@ static void hubp42_program_pixel_format(
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 8);
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 9);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
index ceea0b766f5b..2aef6f239dc7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
@@ -264,6 +264,10 @@ static void hubp50_program_pixel_format(
 		REG_UPDATE(DCSURF_SURFACE_CONFIG,
 				SURFACE_PIXEL_FORMAT, 8);
 		break;
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
+		REG_UPDATE(DCSURF_SURFACE_CONFIG,
+				SURFACE_PIXEL_FORMAT, 9);
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
index 0f44577572fb..9b8d4d1a2cbe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
@@ -228,6 +228,7 @@ bool dce_use_lut(enum surface_pixel_format format)
 	switch (format) {
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 		return true;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index a08ceaeda91c..363961f700d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -271,6 +271,7 @@ static void dce110_prescale_params(struct ipp_prescale_params *prescale_params,
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBA8888:
 		prescale_params->scale = 0x2020;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
-- 
2.43.0

