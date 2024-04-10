Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2C0CD1296
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCED10EA62;
	Wed, 10 Apr 2024 21:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RoGwszjT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E6110EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDBRcx6JPWgaz0NXt4knZZhqivYbmsTFsII5Zretg1im+BAWdISUqV6jk1x74UWTnAgPwk6JPnCMT905XLF226+Efv2T2w9pPekAu8DfO3mwXPSg+bn95rfDTaN6iCGOlJq6QEOnrqK7BRGPJZYYrmV/nUsZPoqMrZ4CrsrgQrF468ES/iMe75yapYoAdoTc5giIqG/dostzuqbQD2AXUoCtqKvtMK+HUqpehr2MzgkoP3NWmAdpfgZEIQIjTJzc33i3wmhmbu+jTTqOSMiGNXhFR+TNlNHbz1aR7eFx4ADIsOvuICpYRQ8Dfr/23T++RvVyz8GmUJTfVmTGynuFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugG4s1V7J8R27QS2G6YhtlO/sm+qg89KSXsq+UAVPoY=;
 b=WDHb4wDk2OUBtRKg6676cGZppVWFua/zE2ZU92EDmlnI04zDz6MgcR4Lv7ix2e/zBBqnpxCGkzh98YjsrdmpR8KkHG4K3seOQ1hyjMuC/KEUxFjNX4mUnVlio6OKAyRr1+eMFaIhFzAqmKrcMcMXqXa5jJxGw0T4T6VJEwx2MT5jkCzhOhoeyoknDgBLeoWw85bZMf2eV3lluadlD2+E2LxO/Z2773vHqPaMEnJkO0yDtFntdgjV2oXUJS746zPrmMLXGXYXkDh/0cxTVPjf8L0hTNvR8c96sK59/2TFcWnY/QfrwSIz8y7Es0GCpcTNnMDcAD7MPrvKy9Spqq87cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugG4s1V7J8R27QS2G6YhtlO/sm+qg89KSXsq+UAVPoY=;
 b=RoGwszjTRYHCGNqsLGS2h4CgQ+hstLL/ATz00ywJ0xRKkJ61klAgXCgYPfR6iHSRkWyUQ1aMV1b0pWa7Yswdw5Z7tEeJg/U3AHf9oVjrSuUDxX0ouXqMhJvnJs+qMS1Zc775K9BAqjXcWWzF1xMJXhkV0n/K/rDFBOLXAOR8cBY=
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:27:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::89) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Samson Tam <samson.tam@amd.com>,
 Jun Lei <jun.lei@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 05/25] drm/amd/display: add support for chroma offset
Date: Wed, 10 Apr 2024 15:25:54 -0600
Message-ID: <20240410212726.1312989-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d93c7f0-deed-406a-022a-08dc59a518b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amxjyqczvpGLaxoHbmt+PSWlh3oc862qCMFmhNcp4SZVO8IH6KdgflBMxrmRsdB23vvZILoTuzGMJSF3IAA3PsMXARl9aDRO88KxGKbtVNbXnS7MkeFLUn7JGyUa2K2Zq7HDQSb/fidbBtW61f+veSGgv8amFSb38glqGsq6Zcq6GeL67bulGOpIXWGUKLoZ0YQkIzkLpjwcZseXsJnTjm/2n5KJ2hXsCFUkEED66lrPfhiXXU3CSQZQZZmMUQK+7R5DkhREy1LeUW3pQatf+gf8OkyrHmM2Ya8G5b3zvyKnUJZCNgvejsJbheYGf2OprSSwHsFwa5gH97tK4jFcgl6eb02U2voKFMxArO7TpVATIPcxpoE1VnBGSNj1aiLHNNwClnstuR+TAcrHKlCbpvS12qs6uNFNwcyp5OgoRuyVaC5BVD2dWlqeHsVX4kH0EG1slgsi8+1pQpIfnnbz9zA+rTXr5gGiVM/hn6A+d0yHgPLCNMriLPl58tyMVkiTwl1YMQpS5AVSCDJWle6y7glB78WIGgXffqF6DNEdVAEw6jcgeNNVn6leeDo0WULClXgsodLLCLvcStgWebyDplDHAyhjOeWXgTiX5a0jiFlrNPiU/SLZuu5XfiUxvFeWcQgrUwFJI82uhz+6FMtRuOZac8yYCqxJYw98bfmTFz6+kjogt2ddRQMIk8MXZuQ8fQ3kDL0EIXUpU5itE+flOZ/NrUu5mHBWvfgLVT2LELQ0r/SCoj2sR9RZ8G+HRkQp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:59.7443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d93c7f0-deed-406a-022a-08dc59a518b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

From: Samson Tam <samson.tam@amd.com>

[Why]
Adding support for chroma subsampling offset (cositing) in scaler
calculations to adjust reference point where we determine post-scaling
chroma value in YUV420 surfaces.

[How]
Add support for cositing options: NONE, LEFT and TOPLEFT Add debug
option force_cositing and set default to TOPLEFT to maintain same
behaviour as without offset support.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h          | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 54534df73e83..188f2d401124 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1003,6 +1003,7 @@ struct dc_debug_options {
 	unsigned int static_screen_wait_frames;
 	bool force_chroma_subsampling_1tap;
 	bool disable_422_left_edge_pixel;
+	unsigned int force_cositing;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
@@ -1285,6 +1286,7 @@ struct dc_plane_state {
 	struct tg_color visual_confirm_color;
 
 	bool is_statically_allocated;
+	enum chroma_cositing cositing;
 };
 
 struct dc_plane_info {
@@ -1303,6 +1305,7 @@ struct dc_plane_info {
 	int  global_alpha_value;
 	bool input_csc_enabled;
 	int layer_index;
+	enum chroma_cositing cositing;
 };
 
 #include "dc_stream.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 465e15f57f93..2ad7f60805f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -738,6 +738,13 @@ enum scanning_type {
 	SCANNING_TYPE_UNDEFINED
 };
 
+enum chroma_cositing {
+	CHROMA_COSITING_NONE,
+	CHROMA_COSITING_LEFT,
+	CHROMA_COSITING_TOPLEFT,
+	CHROMA_COSITING_COUNT
+};
+
 struct dc_crtc_timing_flags {
 	uint32_t INTERLACE :1;
 	uint32_t HSYNC_POSITIVE_POLARITY :1; /* when set to 1,
-- 
2.43.0

