Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4910C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CB110E7C7;
	Wed,  4 Jun 2025 19:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MuLe1fmf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8D310E7C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/qZGTVqTETi3rIX9x9FAilLDtVpC5oi7fwKta8/i6pYX86Vm9FHsJDFYzjTMeHBc8OipeydAbknjeP3vrRh/OzwbxD5eoVTEcIwHmLWvm/2VXQY9NFJF+d7Ep6Bwb3Zj3cHJWl5kYv4M9gulS8CCT85GnCChLuMG+FONe1VWrTAEScIyD0hMw/ewKtJugMlK5EnE6xraqDfY5VV9I7fbRWrSBBwX8hJSzxuHC663ROocFxscaCxiFcUv+2tkzbiSukmJE465PlQpuZX9g7ETkRGU/faAYx7kPU5UhnhjjvAYbYDKvHIGQFgoMSc3gPVKbNOK6T30IKwxSPPcRqITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYl3cCaTxYPjp747iFODkKb5Bb6jjDSI6Fr0+HB81Nk=;
 b=mf6iTJIMcVkjvrg5sTG/1Uk3DVpC7BspC+LISTTOo621yPXrk974VS1pFKQzecKsLzdICZAzZSIOxe5iEwIyf3i/g+ViYCFeepEWSfp7GkQvbelA/VWQvdo4eihP2cL73FGRzs7U+4ZB20kxCFG5pJ/ZEJkH9fHNWZO4iWlEvd3P6mJo9UtbPcMUPP58kxV+0QGGBNV03wGpMZkZvcoJwieRaqAHqN1f7ziv8DEQsqXk/xpA8db1koecT+cleTCU8PvGN1rmSCSQQmHhA3TxlMRkPTrDB6O6pE4tsqgUY/gJOHltn7tK+bSfv6htMNoC8QABj933pQsC9Yi+JabqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYl3cCaTxYPjp747iFODkKb5Bb6jjDSI6Fr0+HB81Nk=;
 b=MuLe1fmfPvGij13s4pZXAheMmccbGiRx4Jy5lbwXzr93mLCDvW0WDbbdnlZa1kmVclFRJqja0w6My1Jljzz7HfgdcQsS2hbbLltpVnUx1NQ9hjRt5Fdk/toHakgv2j2+/RB4vewbdMOWswOUfTaT6j3pSlz8TmXVHWrQzHyODXM=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 4 Jun
 2025 19:40:03 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a8) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:40:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:40:00 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Brendan Steve Leder
 <BrendanSteve.Leder@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 12/23] drm/amd/display: Add custom segmentation support
Date: Wed, 4 Jun 2025 12:43:23 -0600
Message-ID: <20250604193659.2462225-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c5cfad-f9cf-4720-1f57-08dda39f9995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m8f3mwDwg0FO0n7qg24RWj/YCssOggLhd78GRkcsu4VKGaFJHB62LxBvLqom?=
 =?us-ascii?Q?EVoTw86Yxhb0ks1vwrS40OtQVuPPFxyr+EvCgVCWz6ZC5Q0MTaUjpux9ww4K?=
 =?us-ascii?Q?AiVwX+OorIxqamzZcBPRxEzO0HdpMDamS7Kilh1RI4MwsbQ4vq6EtND/uM8M?=
 =?us-ascii?Q?RhXfR6ImanRuY3xAGQJKJlyIa1Egoox3bKDzvFwUUmkNk+Y65yWImEIwyOR/?=
 =?us-ascii?Q?AE2FI4M+MGA11FHS+1Dk9X1YqTnyGHK8j/wAtzivkQNhOEKLRkGkVxtfRvIn?=
 =?us-ascii?Q?PsOvMcj3AL8WotbW6bOLeW7azrkT1h4kMWVDQYLWzYmXL2c3MrD8h2x4V46z?=
 =?us-ascii?Q?vdIkeEIFSZ4M5JZT8Qs0zQhXivYz0J0dZi1Dlf2s+OtUV2vX0A463TZd7Pc4?=
 =?us-ascii?Q?JqJXJ68Sob/XQ+nFWoYwnGoVCCwiIj3J3TIUZCwerBBcY+o7tOw76UGgKbeB?=
 =?us-ascii?Q?Pc5Avvedrx0li897JIqwazgFucY4dEK36a0t2iBYKvwgFMyBxd8vxMfUpB6o?=
 =?us-ascii?Q?RlbI7srxQdKXIyR1bcmlWDOdy7b37IGoyPN/FytH0b7l9D+2YrQO/tzyUosl?=
 =?us-ascii?Q?JN9WHVGFWNuiloIaMPkgGJsARpsK9Z7JpNSTVFdQXFExo2gTqx5yyI79INAV?=
 =?us-ascii?Q?osXRbh84J0NL5gl8eHQ2Bjf1OzjmYp23kIG4ybuDCkg153zZ0oKU6yk9OZmb?=
 =?us-ascii?Q?7ZhulpxqvrC/WgFWnTMo4lvuPl0VW/KfftrI6TxGTMUCS3BWKatpyfh8PlCi?=
 =?us-ascii?Q?gS6xnZH4NiYB99gtUJETPKkSZbHVxfCy4wTCr+Ge0Rr/rbW57X0oIhasCsaf?=
 =?us-ascii?Q?GPNxtO/ezTR6k7OmKaSwif7wTKqVIxW9IN3gTCKvOCdjv2JxhMhdKlCVPlyT?=
 =?us-ascii?Q?CqE0yvRjHHyxO254TkWNe/T/1iiI+Yh+jQC879GcHGDNVEyiTsfaPPryAJI5?=
 =?us-ascii?Q?BaOSy6KGmePwNP8jGmBcFPvJA4r9UQEZ2GbWyjUCDG30plTf17INhRKAWuay?=
 =?us-ascii?Q?zpFkfA6EM1ADObPYbjQqfmeQCPA0vGeOFT8COgq2iKtEQNBi+wSt+y+gQH3l?=
 =?us-ascii?Q?ocXHmqHlvjmNYyrgkeJmk1k8sLt3sQQkFduh+AJqbIWCpOeEYYCpehjw1yQX?=
 =?us-ascii?Q?nf4cVuVN9HRTJou2Jv3dLwsQoIH262fyhxxTR6FI7JsKkF185s3vhijuNMRd?=
 =?us-ascii?Q?nAajakUQMiCk9X3dV18twShRrbhwd0n+22jxYJLeScjyFW7wiBtT6x9w5auX?=
 =?us-ascii?Q?9Yt4UCZ1CUdZt1/y+WmJI0o1ZEP/TIcXl56grXA6kk9X4Q2S72sky+YqFafP?=
 =?us-ascii?Q?N6xvDdLAvJEKEEFDqIf2OC/PEi6Y4FQMYRKNRcJQMKT583RQs7CqtuKxa8KO?=
 =?us-ascii?Q?XOfggisYmtT88ZF/QIB75sWR4dpbigeuWw5xoahWwHn1X68Odwlc0gx3m6oJ?=
 =?us-ascii?Q?Wj5PFzaV1fKbpH2DY15CePAx+UK9spoKxbaBdkKee3LE74OmwUkaraia+szf?=
 =?us-ascii?Q?sRZo48wG6xf5Hp/henE8/HZ38MaYqG/mpvge?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:40:02.7481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c5cfad-f9cf-4720-1f57-08dda39f9995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07
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

From: Brendan Steve Leder <BrendanSteve.Leder@amd.com>

[WHY]
Add support for uneven segmentation size

[HOW]
Currently width + x_start is automatically calculated using
slice index + dividing stream into equally sized segments.
Add override variables for dst_rect width and x

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Brendan Steve Leder <BrendanSteve.Leder@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c    | 17 +++++++++++------
 .../gpu/drm/amd/display/dc/sspl/dc_spl_types.h  |  2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index d5f3bcb68d53..55b929ca7982 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -196,7 +196,12 @@ static struct spl_rect calculate_mpc_slice_in_timing_active(
 	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
 	struct spl_rect mpc_rec;
 
-	if (use_recout_width_aligned) {
+	if (spl_in->basic_in.custom_width != 0) {
+		mpc_rec.width = spl_in->basic_in.custom_width;
+		mpc_rec.x = spl_in->basic_in.custom_x;
+		mpc_rec.height = plane_clip_rec->height;
+		mpc_rec.y = plane_clip_rec->y;
+	} else if (use_recout_width_aligned) {
 		mpc_rec.width = recout_width_align;
 		if ((mpc_rec.width * (mpc_slice_idx + 1)) > plane_clip_rec->width) {
 			mpc_rec.width = plane_clip_rec->width % recout_width_align;
@@ -219,7 +224,7 @@ static struct spl_rect calculate_mpc_slice_in_timing_active(
 	/* extra pixels in the division remainder need to go to pipes after
 	 * the extra pixel index minus one(epimo) defined here as:
 	 */
-	if (mpc_slice_idx > epimo) {
+	if (mpc_slice_idx > epimo && spl_in->basic_in.custom_width == 0) {
 		mpc_rec.x += mpc_slice_idx - epimo - 1;
 		mpc_rec.width += 1;
 	}
@@ -252,10 +257,10 @@ static struct spl_rect calculate_odm_slice_in_timing_active(struct spl_in *spl_i
 
 		odm_rec.x = odm_slice_width * odm_slice_idx;
 		odm_rec.width = is_last_odm_slice ?
-				/* last slice width is the reminder of h_active */
-				h_active - odm_slice_width * (odm_slice_count - 1) :
-				/* odm slice width is the floor of h_active / count */
-				odm_slice_width;
+			/* last slice width is the reminder of h_active */
+			h_active - odm_slice_width * (odm_slice_count - 1) :
+			/* odm slice width is the floor of h_active / count */
+			odm_slice_width;
 		odm_rec.y = 0;
 		odm_rec.height = v_active;
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 36a284305a70..23d254dea18f 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -460,6 +460,8 @@ struct basic_in	{
 	enum spl_color_space color_space;	//	Color Space
 	unsigned int max_luminance;	//	Max Luminance TODO: Is determined in dc_hw_sequencer.c is_sdr
 	bool film_grain_applied;	//	Film Grain Applied // TODO: To check from where to get this?
+	int custom_width; // Width for non-standard segmentation - used when != 0
+	int custom_x;     // Start x for non-standard segmentation - used when custom_width != 0
 };
 
 // Basic output information
-- 
2.43.0

