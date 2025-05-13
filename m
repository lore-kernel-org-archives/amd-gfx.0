Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25AAC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E85510E387;
	Tue, 13 May 2025 11:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pUIzY3m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B552510E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL1k8xL8Jy8PjRPDxx6L9R79PP+ImXooMhbfZzffvQu/jDwjmgJBwVKAHuN+q2o9dB5W0tSnYtHivTGJ89aFoQTX6mkMKXULJZEoNLrY4CuVOO9sPjZzthtOqke+DobVHbEMIJD6bkFfGPKQhukwBSUDMfI69Z8jcsgyJUBbaf/pbzeIk+K4lV/2/3EVaNFuOQosOJXhf37He5gql/09wXGegnywq6vNDUfYJCrkRiAiiDnp5kNWiWbYV52F5agEymrV8CgJOnQxLCVMMyVTC+CJnGfuEAFwUO4EOWH8rZgy72wiEsG7bl41oPQQ/0+kgC8pdKHxlA775K56aZySZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEx+IVz6RX8JGQEO3iVqpNBAQLgvocqLLlQW3J1zcLo=;
 b=cCWlmmSokq4757QDZ2HCFFrWj5bZWAe/Vs0IG6+V7iwWoS/Ma5Vzdj1jEhD8f354b6LVer6nd4kI0nXCMQ/utV057ygBhLgULVgFTIf9pnw3HQmXoD/K1FSkDmxycXY6cgkwxerUNCFqlCS6hJ2f8haR0dvwmxHXKE0NtIGG9zvSS5dHvftevvVVq0yiPZ5hodh9vcUCGEdEKP6pnx30bSP3RgPanpPk4fnMCDyYLAicKOsZ3tFmhqAzRcBDcqVubRb5aHVIRvBbOdHq/BHLW3TOpKxBYf00VaRy3QPPh/onpDsAWD598YMByjaS9lQVEJj/+2elqKmoMAxdbZNdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEx+IVz6RX8JGQEO3iVqpNBAQLgvocqLLlQW3J1zcLo=;
 b=2pUIzY3mDjfXRPqYvBBcSu+0aiaB6TjRsY6rEqI5QLr9avvP7mWumD8LZJM44MUR2oGOZ9K1lCz+evWkrFpJ8T2l0jnND+k12MK/tbVLebjlQcTa45W0c3hikN4dAXQY2dvZCRQN3+4G1ntYYi+0cJyJk8aIWYZ8nR2DQvGVmNw=
Received: from CH2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:610:4c::34)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 13 May
 2025 11:24:57 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::54) by CH2PR10CA0024.outlook.office365.com
 (2603:10b6:610:4c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Tue,
 13 May 2025 11:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:24:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:24:55 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:24:51 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Tomasz Siemek
 <Tomasz.Siemek@amd.com>, Charlene Liu <charlene.liu@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Swapnil Patel <swapnil.patel@amd.com>
Subject: [PATCH 01/11] drm/amd/display: Extend dc_plane_get_status with flags
Date: Tue, 13 May 2025 19:24:29 +0800
Message-ID: <20250513112439.2295366-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: f67f95e8-c475-4f1b-0de0-08dd9210c9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/2/g9LnpsDmpERXGCVVQIon0eDcY3S+Gn6tyPKClGgZyKNd1yHldJ2YfbcE?=
 =?us-ascii?Q?NRN8dCjSbc/01Ivb2Man+8ijaTeCKjwMsT4LMfY0vQ1ZGHD9KPRxS0erafkT?=
 =?us-ascii?Q?ROSBGYpDz8i0CNWk9D3uX5OMGFIKqZHQRpA9udDM2Fs/N+MEZGb6FsX6lXKN?=
 =?us-ascii?Q?V9+qd60w/0ZsZSSbbcOZj2HEAF9iqF+FfEbhy0i5jhSQQRY6UIthrJTpdVel?=
 =?us-ascii?Q?n38GHRJLbcPsjkBugnMaFO/SLMyXNXDlKs8wMTF/KpNHSyzGmZL07O8lQawJ?=
 =?us-ascii?Q?2yzUIbmJRLiUs8oHp7YjsVEGvytTJmG9SCRVFalrHgzSVrKq76PfZvTw7xYE?=
 =?us-ascii?Q?Yt9Uxw2/DtUhTab/0FhgJ9Qy1oOSzLkAuZYrloB22ojykZEq+WOllOC/jL8Y?=
 =?us-ascii?Q?A1cWtWPsP5pCRakqan3o4yOz6V6X2tAbO1rsQffI8h8MJ3ZivKApSwbupGPt?=
 =?us-ascii?Q?YSX8ckx7SRRDcCRgu1M0a4vNg/XFM4kSWqe7twIf5nH9MeXfaHyFhVehzCwG?=
 =?us-ascii?Q?70+4zCQxQYehtLLQZqoDUeCiJZJn9WVKZYKi8tPZpXlN/ANqu+quhapkszKL?=
 =?us-ascii?Q?hS4DNmwT3XvLZXm3yhhu9/ctQ4lLCUFMblOkCiKpbgE73xIqv9CUFl7+cVUo?=
 =?us-ascii?Q?g42k+uq8NEogbYT2jxa/8c4BhERjco2nOwAqi0jJy/bXgqDf01J5G/TE6fpV?=
 =?us-ascii?Q?nO1HeKw3Y0Y3lTkPpD7v3FwditAta3z69FOmwRxgMxy3mVmePts5+F2MaUc2?=
 =?us-ascii?Q?Gt9pO6I5EQmiRqWbq5gQOY4mrzV4iqz6wfOSRgNQ9O31LGMLt1xHlVg0ym8z?=
 =?us-ascii?Q?p33n41LlLexfhaqCR7Rc9i+oqmVdjBg9Py1uH+E3Tj1QHPLUyF9h9kpTBRMN?=
 =?us-ascii?Q?MmZZM1kzklRUjAX2xDVZ6uSZycPxiMvSvwWTOidBi/INWtHzVBeu+eLRozFk?=
 =?us-ascii?Q?NIR+uhBJSmXLgeOqh9gSSwSvLUjoK6EXwWQOu/hbq3dfpmQg6UudVoXNi/Z6?=
 =?us-ascii?Q?mIanaP2iHHAB85OFhbOHI8dablw4sO0zGXSePsJYnJqNFELlaF/fRKDOBUNX?=
 =?us-ascii?Q?zMhi81K2g91uUddJMwfZe8kQi2nkbKTm5O3QVgsykr3yigj5gWC99Ck+Gms9?=
 =?us-ascii?Q?csX4hOdXnVK9lPvCYFD6oj9nVblgnbn5FC65uBjub933KVzIMqk22lc45idX?=
 =?us-ascii?Q?7c7RRFE50qAhDaUAcnAdygAIxyf1IpQNvElur/Y758RKiQs1TNhzvjlFskmo?=
 =?us-ascii?Q?fskUrRv9ccbLnlabuK7/KD4FSK2tm5OvSvJuZJ4vEgq0iu/ov32r9h/6EhN6?=
 =?us-ascii?Q?un6WRgFDSMY07BmATu68zjwiyQz3g4zuQdcbXqEZvTKnIej7XB1/ftPLzpqM?=
 =?us-ascii?Q?m4yx1ZdIlXpzvJO93cxHf5lnr2NKzV5qSTbrsDk2uRrFzdrLXHCz+eWFmQat?=
 =?us-ascii?Q?PD8w5DKHYdPtxEJTqDSSK/1RuwSb76e5MgfWaxZ36ATdBonlxaHnP6osY+ci?=
 =?us-ascii?Q?pO8IBBRNiZCr4TX+s4S69ZXOwKVyqdXzrFrY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:24:55.6959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67f95e8-c475-4f1b-0de0-08dd9210c9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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

From: Tomasz Siemek <Tomasz.Siemek@amd.com>

[WHY]
dc_plane_get_status may be used for reading other plane properties
in the future.

[HOW]
Provide API for choosing plane properties to read.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Signed-off-by: Tomasz Siemek <Tomasz.Siemek@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c |  8 +++++---
 drivers/gpu/drm/amd/display/dc/dc_plane.h        | 10 +++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index e98500665af3..922f23557f5d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -109,7 +109,8 @@ struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
  *****************************************************************************
  */
 const struct dc_plane_status *dc_plane_get_status(
-		const struct dc_plane_state *plane_state)
+		const struct dc_plane_state *plane_state,
+		union dc_plane_status_update_flags flags)
 {
 	const struct dc_plane_status *plane_status;
 	struct dc  *dc;
@@ -136,7 +137,7 @@ const struct dc_plane_status *dc_plane_get_status(
 		if (pipe_ctx->plane_state != plane_state)
 			continue;
 
-		if (pipe_ctx->plane_state)
+		if (pipe_ctx->plane_state && flags.bits.address)
 			pipe_ctx->plane_state->status.is_flip_pending = false;
 
 		break;
@@ -151,7 +152,8 @@ const struct dc_plane_status *dc_plane_get_status(
 		if (pipe_ctx->plane_state != plane_state)
 			continue;
 
-		dc->hwss.update_pending_status(pipe_ctx);
+		if (flags.bits.address)
+			dc->hwss.update_pending_status(pipe_ctx);
 	}
 
 	return plane_status;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index 8fe385f52b18..14feb843e694 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -28,9 +28,17 @@
 
 #include "dc_hw_types.h"
 
+union dc_plane_status_update_flags {
+	struct {
+		uint32_t address : 1;
+	} bits;
+	uint32_t raw;
+};
+
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc);
 const struct dc_plane_status *dc_plane_get_status(
-		const struct dc_plane_state *plane_state);
+		const struct dc_plane_state *plane_state,
+		union dc_plane_status_update_flags flags);
 void dc_plane_state_retain(struct dc_plane_state *plane_state);
 void dc_plane_state_release(struct dc_plane_state *plane_state);
 
-- 
2.34.1

