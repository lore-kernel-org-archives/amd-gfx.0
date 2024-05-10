Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7BC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 10:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC25510E3DF;
	Fri, 10 May 2024 10:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cvl40pxe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D2F10E3DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 10:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvihBU8Tfi1rlGfjxEi/1B449q3jitLDavspKgIkdJPebEW8V5EE6tAPfHq5CAIWkp3hrZbPknPQeOUPd6IxFA0RarQSVnzndb1tPiX9KNc0jYOxD8C1Ku4DDMSywUI7SXLaDSP4qCEsu9CKJLeM4eYkcwWRe0+oKl3tqfIw/Bbd4fAOVyZaC4hc8pMv1V9n0MyeQAlISZ4iqgXv4HwHhoOYDg/cSNYdQZ8cfg7EmdaXiDIVie0/4mAz3eAgL4S4Kzj17zle/pEhNoX5gPLEgne8Xp/3CLnmwatH4iTFXf64uJ1mSKVD0MLewiJNE51jforjPNXFzv/0ndezG5jxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=extHykaikJc4qLsjiwJwFgqmGz7v6SKjy2GygzH3/wg=;
 b=WHM5pZegXOmwaotfMwrIanX6bOmX87FLkqLjvB/HD5tYrXN+HfwHZ1XvSsH/0d3XHdG8YHn1HijAW0UEq9GoJg2NZVZTageMTuXE1eYJ6E/urjUVeR+AMLLK1C2o8Wxmdrh399ws9ydULgEJq6AlwMF6uF/97YHLhZdjVn/BdQtjM6yLvsuNUY7I40bNRdPjJH4T8UYxrmX4P3IIFYu4/1GfQ/crDtv10ZET/cGDjDaBm3QO7dAUjAHecfOHGX6qHRB39j1oNeTqW2bsZYOPmFeV/FNdh4OA5aeA4MUhRxFTRm1RQUbHcpwm4LvAxfUmLR9A/R4LuLtzxF/MigDvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=extHykaikJc4qLsjiwJwFgqmGz7v6SKjy2GygzH3/wg=;
 b=Cvl40pxefUGkDRgURa1uj2j+90yyFnMgmw8LnH4wdqnSecr5qupAW3zvEmZDKhBwZNcURFFdrWKSJlzCDEIwNCTbutS1vMV+dqa0ToC8IafiTDuleiRi3vRcqo7p3o/yD2h91dxmltc+FsRcqf5LuKFQygH6bFdj70GjCxOUE/U=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 10:12:36 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::20) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51 via Frontend
 Transport; Fri, 10 May 2024 10:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 10:12:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 05:12:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jerry Zuo <jerry.zuo@amd.com>, Qingqing Zhuo
 <qingqing.zhuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v3] drm/amd/display: Refactor construct_phy function in
 dc/link/link_factory.c
Date: Fri, 10 May 2024 15:42:05 +0530
Message-ID: <20240510101205.1913092-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429083038.232958-1-srinivasan.shanmugam@amd.com>
References: <20240429083038.232958-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e56f97-72c6-4dee-1f1c-08dc70d9b4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3czdXFILzMzSEF6ZFlHbENKUnRRNnNIbU82NFZmUEIzcmRIOG4xUkVobklM?=
 =?utf-8?B?VmpUWjZKTUpudUJZT0RBdGhVdUR5NFpqQ2pOU2RiRmYyNEZLQ1JBM1JpWVgr?=
 =?utf-8?B?STFuaW81SkVRWGEvcnc3SnVrZnNmKzdSR2E0eDlMVFFUZUIybEtQVG1tT0Np?=
 =?utf-8?B?b1BJNnJVakxwaXk3d004TWdVOXRrVkh4cndvaUcvSVpuZkRzOE80NEZZU2lk?=
 =?utf-8?B?N1hQSzhqRG9xSmJaL2F0bXREcDBqUkNPejhTUUd0Sm1sYUYraEtVQkNPNXhq?=
 =?utf-8?B?WDBWTytadXVPSnRISDFzWDlPdm5CWVZTM1dNYk1OdWZOcmw2UUo0QUdnTGNX?=
 =?utf-8?B?dndNQ0VSUHl3bFFmaXpMdlBnbTdJeDVNTitSV3gwTHBMQms1ck5sMU1Bc29C?=
 =?utf-8?B?REdibnVVSDFEdkFKblhqVW9xc3V3ZFpCSklrbEN4VVUxZGFybGMyUDRESGdZ?=
 =?utf-8?B?U2JVSllodUpHOUlNTVFNMGFYOXpGRG5md2VoNGxSOWJUVmpRb3c2TUpvYVpy?=
 =?utf-8?B?VXZpUmdIUjZQZDNsMGd0aWdZcklzVk8vc01UM1MvMU1CMEhVbjdjMzhNMmll?=
 =?utf-8?B?UEZ6N2gyOWRGRXVEb2ZDVUxuQ0pXMVJNYWhaS25VWEY2S3gxQXpqdXp6NmFN?=
 =?utf-8?B?SENSSitvRE9Yd3ladjVTQlprRmhMclhDRDJ3d0Q4a2JMa2NudmFiemp4WlhG?=
 =?utf-8?B?VDdmSWhOVlJRbmh0VGVFRjhpcGJHWVl1dVFBd2N3VmZUWk9VblhSMVR2TE1X?=
 =?utf-8?B?bDVVNDlENEp4bDRMMFo0aG9LYnRnVDg5YStzaFdNNlRHZ08rMW1vQUJKMnlW?=
 =?utf-8?B?RDBacE1KVmF0THUwQ1NMLzd4NW1vR0VnS2Y1dmo0bTRKaUc2U1N0Nk8wam8w?=
 =?utf-8?B?d1RVRXp2SGs0N084cUVnK1RwdW5oN0xJR1FlUU0xRG1BRFFKY3U2VVhhZWM4?=
 =?utf-8?B?TUhQZEtpaEpNdXBDR05aMEI3MmxmYkdyKy9ZQUdhMkp1b21FV0tkTjFFTWV2?=
 =?utf-8?B?VVU5MXBtbkYvSjdiSkZUWVlRVDlSTWlZVGQzNDByK0JWcXU3akI0aUZyZTNv?=
 =?utf-8?B?UXVBdWZyNmtTM0ZkalM4QUFsUDE0eCtBcGVwT3RXUDNSMGRjRFdUM0p1aTRi?=
 =?utf-8?B?aUJNZlYzZy95UzRONkxPUmZiWHkvZEEyRHZUYzB0eXpWY01QcmcybFlCbTRM?=
 =?utf-8?B?bURVbUUvc1dZQVd6ZUR5emNwU2c4S1Y4SHNxV1BLUjdFSnRRS01jcCtSYmkw?=
 =?utf-8?B?c3FBdVBKVzZ2d2htWFNsamdwU2FkcUN5R3B6dlBDOHFTRVNiMmQ1dXd0SnNC?=
 =?utf-8?B?bWIvQ0hNcEVxcG5KTGhDQjgyVkRDL2hzd1l6SG5keEE2cTNUZkZBMzk3bm5U?=
 =?utf-8?B?cW42Z3d4SXBLTmNPYTFseVE2bDdwRXNkTm9hSm1ScW9PRUY5Wm92ck1TbnRD?=
 =?utf-8?B?V2JlUnVGSjJQZTVzODVyU25qc2ZsdldHblJER2NYRDAzdUM5c2dtK2U1SnJi?=
 =?utf-8?B?R0RNZlVhM3FFbXVjOFRjUDVVWGJZMGNIYytyKzZtN28yQ01SU0pvWm1nREJ1?=
 =?utf-8?B?OUdscFNyN3VGK0hOcWJRUlhWY3Ridm9sSS9HVUUvZnpvNVpwNHE0Mk9HU2hD?=
 =?utf-8?B?MWJQaFJLQXBzc1lUNnFnVFlBU1pLU3N1WmRSZVVvUlhQTk56eWIrMEt3N1Rn?=
 =?utf-8?B?RWNsQ2gyWlY1OUlITlMzMnNzZW9jemRZV1FtVlhORXdiNXhYM0ZJbE4zc1hq?=
 =?utf-8?B?U0E0enZzS1o0ZmZKVTdzMGVVY3lVdUtBbTdtNTQrMFI4M2hDdExYUzlhS3Fo?=
 =?utf-8?B?RTMwdmh4bXJ4K3dDTllSWHJMcFpjUGpzaVZxNlo3RU4yOGQzSFJicWtoQjF3?=
 =?utf-8?Q?2XTU905tRQtac?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:12:32.2703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e56f97-72c6-4dee-1f1c-08dc70d9b4d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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

This commit modifies the construct_phy function to handle the case where
`bios->integrated_info` is NULL and to address a compiler warning about
a large stack allocation.

Upon examination, it was found that the local `integrated_info`
structure was just used to copy values which is large and was being
declared directly on the stack which could potentially lead to
performance issues. This commit changes the code to use
`bios->integrated_info` directly, which avoids the need for a large
stack allocation.

The function now checks if `bios->integrated_info` is NULL before
entering a for loop that uses it. If `bios->integrated_info` is NULL,
the function skips the for loop and continues executing the rest of the
code. This ensures that the function behaves correctly when
`bios->integrated_info` is NULL and improves compatibility with dGPUs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c: In function ‘construct_phy’:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:743:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Wenjing Liu <wenjing.liu@amd.com>
---
v3:
 - Directly used bios->integrated_info instead of integrated_info to
   avoid large copying (Wenjing)

 .../drm/amd/display/dc/link/link_factory.c    | 67 ++++++++++---------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 2c3f5d662285..8073fdae9cb1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -456,7 +456,6 @@ static bool construct_phy(struct dc_link *link,
 	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
 	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
-	struct integrated_info info = { 0 };
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
@@ -671,42 +670,44 @@ static bool construct_phy(struct dc_link *link,
 		break;
 	}
 
-	if (bios->integrated_info)
-		info = *bios->integrated_info;
-
-	/* Look for channel mapping corresponding to connector and device tag */
-	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
-		struct external_display_path *path =
-			&info.ext_disp_conn_info.path[i];
-
-		if (path->device_connector_id.enum_id == link->link_id.enum_id &&
-		    path->device_connector_id.id == link->link_id.id &&
-		    path->device_connector_id.type == link->link_id.type) {
-			if (link->device_tag.acpi_device != 0 &&
-			    path->device_acpi_enum == link->device_tag.acpi_device) {
-				link->ddi_channel_mapping = path->channel_mapping;
-				link->chip_caps = path->caps;
-				DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X", link->ddi_channel_mapping.raw);
-				DC_LOG_DC("BIOS object table - chip_caps: %d", link->chip_caps);
-			} else if (path->device_tag ==
-				   link->device_tag.dev_id.raw_device_tag) {
-				link->ddi_channel_mapping = path->channel_mapping;
-				link->chip_caps = path->caps;
-				DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X", link->ddi_channel_mapping.raw);
-				DC_LOG_DC("BIOS object table - chip_caps: %d", link->chip_caps);
-			}
+	if (bios->integrated_info) {
+		/* Look for channel mapping corresponding to connector and device tag */
+		for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
+			struct external_display_path *path =
+				&bios->integrated_info->ext_disp_conn_info.path[i];
+
+			if (path->device_connector_id.enum_id == link->link_id.enum_id &&
+			    path->device_connector_id.id == link->link_id.id &&
+			    path->device_connector_id.type == link->link_id.type) {
+				if (link->device_tag.acpi_device != 0 &&
+				    path->device_acpi_enum == link->device_tag.acpi_device) {
+					link->ddi_channel_mapping = path->channel_mapping;
+					link->chip_caps = path->caps;
+					DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X",
+						  link->ddi_channel_mapping.raw);
+					DC_LOG_DC("BIOS object table - chip_caps: %d",
+						  link->chip_caps);
+				} else if (path->device_tag ==
+					   link->device_tag.dev_id.raw_device_tag) {
+					link->ddi_channel_mapping = path->channel_mapping;
+					link->chip_caps = path->caps;
+					DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X",
+						  link->ddi_channel_mapping.raw);
+					DC_LOG_DC("BIOS object table - chip_caps: %d",
+						  link->chip_caps);
+				}
+
+				if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
+					link->bios_forced_drive_settings.VOLTAGE_SWING =
+						(bios->integrated_info->ext_disp_conn_info.fixdpvoltageswing & 0x3);
+					link->bios_forced_drive_settings.PRE_EMPHASIS =
+						((bios->integrated_info->ext_disp_conn_info.fixdpvoltageswing >> 2) & 0x3);
+				}
 
-			if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
-				link->bios_forced_drive_settings.VOLTAGE_SWING =
-						(info.ext_disp_conn_info.fixdpvoltageswing & 0x3);
-				link->bios_forced_drive_settings.PRE_EMPHASIS =
-						((info.ext_disp_conn_info.fixdpvoltageswing >> 2) & 0x3);
+				break;
 			}
-
-			break;
 		}
 	}
-
 	if (bios->funcs->get_atom_dc_golden_table)
 		bios->funcs->get_atom_dc_golden_table(bios);
 
-- 
2.34.1

