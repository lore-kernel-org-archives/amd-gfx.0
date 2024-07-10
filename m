Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285FBC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD18C10E8AE;
	Wed, 10 Jul 2024 19:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P2JsbowZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0E710E8AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSJFpPqfWcqw1L4eVQGiIuU25ydNPMEYSGCkIFos0kEtei9YYtuFLyVdkhHp1Th/UjX6mHYsmeou3iR0tSDa7d6w10KWkQwfJZuDirTrcO64Qm3RpxOs4hEYvm5wcLEIr7U6R1G01HVS6sq5xr7JOta6jVemcpNaYu6AuWoJU7uce42n5YCqSUHBYDQyypdHozbj3Ijr4p9y6jqdBBU/PuyQswMIsgWyDR0HXCQk13dKqbZiBCOihww6iPDaLBbWDkaUnmlOqhmf9j04e0Lfmd/hEMEx7Bb8rgFSsqICqLp8o0R+sKby4beFaJUGDTsJIia0OuPW+yANCDodtL0EuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaKzj7UaDn8zlvzR4I9Wejh0jPtlrI8wYFY2JkDiC0M=;
 b=JoiMN+qkWwplM8FsYsiLu51laHTAcYK5YkMLsFSmswWbYjH/nDyjeX4Kses+TB8AWjerrGH0BwRJSpr+Q85KsdfTVtolzRY5gD6X5MH9z/bMbNXD2ZIGDgOnwv0omwSC7RGpjxQ30A6fyEdlvqw7/zaxFkzgvAsCywK2kbtY7osApSU9in2puv48dlnnkjLXC3VI3sfVsrzi3S+mMPdtP+nWwMTym4pM241HKfBFIJWVNpAs9jvtvgkzJ54GyoxENnhbjAnhQY+GgFtA8DM6bS3SU/VI0N+2WjJPjdG1tQ4Xwub4ky/lE0phdX/1jZnDCBmyWFwHO56RC+JWqlHFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaKzj7UaDn8zlvzR4I9Wejh0jPtlrI8wYFY2JkDiC0M=;
 b=P2JsbowZqGmUgrDMlF5h0QOtmqpZ8lzu6nTya0hVoyVRyhKA/8Y6wKmB8zO4/hbQnZITQ9fRsP/9pSJcUwo2cVCZ1BgrR6U+31N886Jir/ScIDlDi/qB69cb3Iev7paOZMM6pVGOeJUpU5uJSZfZgSSkqh5dDIb9k+EmTiT4WhI=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:38:37 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::20) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:33 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:28 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 18/50] drm/amd/display: Check null-initialized variables
Date: Wed, 10 Jul 2024 15:36:35 -0400
Message-ID: <20240710193707.43754-19-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 981a9070-ba73-4b4d-3890-08dca117e3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RXp2HLc7MJG4yxBg3vKEA6/IpYWEKv5ZlJY7oeia9cSYwawt4XQ1T8S9zv4M?=
 =?us-ascii?Q?EOYrl89rAqBpC+eJmivNAN8HKqwVoDidkwWTKtDnOhdkqEQJ+rBRNeepw0zz?=
 =?us-ascii?Q?u1QoH8SsDLAFAEqStX/mvTZf3up9mEUAVfrEsg/PqUKzTLmaxtXTiIBxe1AY?=
 =?us-ascii?Q?Nzf8PNYFT9/MkNEJzShYVVwSb5IABT8vwHXq1FDvGMgxY55m2OM22sMPhSZn?=
 =?us-ascii?Q?vVkKDS0VdN1/9xGii0rci3Jlr2KknZB1WZAHIMHpr5SoA2zslYNZi4uyxJHR?=
 =?us-ascii?Q?zPNf9e/yKgCRf89OVSTrdbAv2w9zu9YIbgRxUgj2DTIWtrK5vI616SDF0dvw?=
 =?us-ascii?Q?3DtjmSEjyRc6SYXHa9yqdYFgIjpiIu/1nbFvhlzf9cqp7xbS0IWxFBWM2qUE?=
 =?us-ascii?Q?0gQ8169sSCzoYDbeeUMumdFOO9uWrlBBZHWH+spDc/yqaH8N8D3icR1bSLws?=
 =?us-ascii?Q?u1j77wzf9bjLnUgOzK6nd5BStrrsQjHMi7yjdJN5FhZp88u6I6dvAOnaYnPv?=
 =?us-ascii?Q?hm4MBfnZhr5UgjCoSV5bkxyvLIF6mFExy/KXJb4TeZ3DztwkKl81DdRJ+DH3?=
 =?us-ascii?Q?1FRDKwx1QwEJEYortxCSX9ekln0CiG8XzFtsg97JDVU09SUJ3E6FGIEP0AJf?=
 =?us-ascii?Q?IeaGTVffMphVsGsSjs4PCf6PhXwTDyX6canu1Yv829tOPdIQvFVu+EC5Wt+8?=
 =?us-ascii?Q?V7eTJ1QWVFQkcCOAh1e+2qP55wYb8PxjYVCotVJIImJN2gynx8SZ7L48IQX0?=
 =?us-ascii?Q?EaPWm77hkyKi35mS8WHmdW2ahwiqEIZ5gWdQ4mzsH11tMOnXwAZOt1ybpAi9?=
 =?us-ascii?Q?H5AFHwNiZzdMlvDawYScEEe4z+QAuQY1rmJg7VoTY/lByxkyu6BMTnN3ZXZz?=
 =?us-ascii?Q?m6PQeCAkTml2ekB4JBj9DlH8x9UzKY2rSJTBLXt2AKfkMbfIgAXce1UvUPNd?=
 =?us-ascii?Q?3KKLiaDVzhAbjwFOXhtS3KKuWbttEIG2cvRoPYhxZ0T7wwr/8iKVziNL+n+i?=
 =?us-ascii?Q?ITVHpuqEqxD0y9Ub0LXpgtl57V/gsSkS/euWgwe+7vNqGvgdjkwDe2LEbb6e?=
 =?us-ascii?Q?zh0wKOzgvrQovSssdXPwaiEdCO+OvCib9Sha5o3AQzBABIeO5mm/gKpe02Bl?=
 =?us-ascii?Q?okHf3Nu4exl8gzFASmT0Guj8imd3B4XaH39FAsyrKuo+yiW/0sdLCyk/LOFl?=
 =?us-ascii?Q?F6Xx6QiCHEeyJwuy1msp2Sr1N1y8SN4P8yE90C0qI/QuFE8QpV3OGPo2j0n5?=
 =?us-ascii?Q?Pu5d6q2FGiRN3c/KSop1Sx9W+wpryScr3hQ49Q2CpMZQB19Ajtz8VIvZ5R06?=
 =?us-ascii?Q?YNsck8PRXil6JnUmwRbucfGiTnRLVlEiHJN2sxhlhzHb1Opfo/aaCg97BdTg?=
 =?us-ascii?Q?vHWTCEpE9JPryxSUksl2dCPU2SyDJqczYT5NIsZB6PbrJ8bt8DDel53ITugX?=
 =?us-ascii?Q?s5ez8D0Rg9JG8zcx9dlJ2FurR4AN4l/6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:35.6503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a9070-ba73-4b4d-3890-08dca117e3e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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

[WHAT & HOW]
drr_timing and subvp_pipe are initialized to null and they are not
always assigned new values. It is necessary to check for null before
dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9d399c4ce957..4cb0227bdd27 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -871,8 +871,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 	 * and the max of (VBLANK blanking time, MALL region)).
 	 */
-	if (stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
-			subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
+	if (drr_timing &&
+	    stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
+	    subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
 		schedulable = true;
 
 	return schedulable;
@@ -937,7 +938,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	if (found) {
+	if (found && subvp_pipe) {
 		phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &phantom_stream->timing;
-- 
2.34.1

