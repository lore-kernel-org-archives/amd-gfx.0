Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD1BC2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0445710EB19;
	Thu, 20 Jun 2024 16:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="heAlpHvy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CED10EB19
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N40s4V/OjFiVb/11t+4bCJTwr48zJRMd/IVT39awx5kS3zMJ+A/iUJ1W1Zi8IxS7kTLDlYX23sU5CkXAwecxQ9VH8oZG3+0Jrqsqj2W8fGmZM4LWpuxKB5uIB4GMZb80hmyWtVAGCmNM6ZEHeEXCqYVtCPbqp2iopnYIk2WgjXOCYhBbOGAJAFaTr1N0Oti8JD+e5R2dQ5t+JIH6S+80uxtaHUwsaMW6O3dFD5PrXDFfvA4xxT42vUrSj1O7yspWgvQSO6HV07J3MPJVHfdr8PPlPrx2mDKZ9kX+SYwZdThC8uW/aMOyKwrn3WTsfO8UHK1E2q0MEO0E/ZuQDEdPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3fM7NqYDbagThrMYKGMvdlApqDruibbSHBRdEaNplg=;
 b=cW66dnWSuXfz5ntGpThD2SoPcJs5UB1ir6gunGJIO4n1i477L3Oc8moz3Elnd5ziZGE+H9gTqElAD0hyxi75+NX6OIGRCGVM+kdR8A3QPGHqJeJRgK+xbUdunyBi3HUF68rONetSf60LW1tB9gMhR5J3vqMFMOgSPb6rwzvR3+KYCLDk43x1mZpWILjW39VlQRQA/vK+Wyv04WyLRMLtZqSvW1v4ZlzLQHcjpZbqCp6zUoeIs3dZ39mH/ZjKqs4G0Au3jPSLugFkiR4jHHxy/luKRFDIrK2PPBEspAcDHoKLhcT06OnEyiR1pgoNfUdnqQi982YJxqFChwt1hd+cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3fM7NqYDbagThrMYKGMvdlApqDruibbSHBRdEaNplg=;
 b=heAlpHvy3oo4zUE2W9Oyrn4nHTFEEJUUWUAnJOWZlXyNs2SpNhsrHOHT+hicDbXBeOBXFmY00Iw9niZczEfeAeHPbFRzvWB1kQwNpsz1U9Z1G06LhgD5Ji+zfq8qR90gMcc570FCd8f+BOoLwVUNkbRsv3y2EO/lZPZjLtnRnU8=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 16:18:56 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::6c) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:18:56 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:18:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ryan Seto <ryanseto@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 28/39] drm/amd/display: Add HW cursor visual confirm
Date: Thu, 20 Jun 2024 10:11:34 -0600
Message-ID: <20240620161145.2489774-29-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b581a6-1e4c-4598-9ebf-08dc9144af36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0qYJvbXShkZ3VMCeiM+OTdNToc0SlqFE1Q+XmRW1wMMkBhOJkCH4vTRAvIt9?=
 =?us-ascii?Q?5ISoXd3A1jCkKu/owP0kMAH21hh8Pv4E/xbsUt2gAjVJ8ffyUX5idjaw2uCD?=
 =?us-ascii?Q?2RO7VipH6/D5VxW+vDAKqhTYdcFY7cpB9sikBSCWxkyTeitCDsSvZ3T43Uwc?=
 =?us-ascii?Q?5LZQVxC5oy+hupkWVtdIgDyng99m9xlNVT07+lQ2UWle+42rbCx8Mi8sBawr?=
 =?us-ascii?Q?8/gki3h9ToYmlmVEiLfCKiO/VsEGrcPNKMPsCcvUQQwFRfn9lYOnIySJeoUq?=
 =?us-ascii?Q?mGIqoFzLBhB5i/JPMhMRGRF87M9mMrESwuXl+G5Eh+a+B3roPtKin6pThji1?=
 =?us-ascii?Q?0kEsniuQIjZm5ZcPKJcIGNQDh+7F9mnoo1TQzojzCcTWs0HvgCgKf1NMmNmr?=
 =?us-ascii?Q?FBaUmrcJQ8rRumuEAO1yBnMEkaK5lsZmnfRENyHK5KL42sDIrHV8lx+i6a/O?=
 =?us-ascii?Q?x2AeJ9gv5+NYHvlT+1VA6uXGB1/77vhoH/Wk2gGzo44f9hxb04O9JlxUlUBl?=
 =?us-ascii?Q?k60zH1sMeJXe8r0E5vStzr+xGwB/2+/tKCPRmJd2DoIrahmU3KOrSRCTx3oH?=
 =?us-ascii?Q?xuD/7PUAyLUOYJdM61dk9sQGpcl5nknNKxWBR6HooxO8ebt/awtwWGDDee4S?=
 =?us-ascii?Q?15zfLN7w/MF7zP7hZPmzXKoAz20vYGb9COEXB8kOfONN1kUfcGEPsIa4WPJf?=
 =?us-ascii?Q?zwrPkfUZkDArd6UwH4ivQu5PihWqAmILaC96PKrlo0aQlcoa8AWC8sWShhXX?=
 =?us-ascii?Q?64DLW17zrABRixjZA9q2VLTcMAhhV1+UHSpp0pA/1v1w+4b4fTs5Ouq84Mhk?=
 =?us-ascii?Q?k/h0FLeZlFioAW4pnCJYXEbYHiwiEdT/UM9m5yvx4Jg5DuAfHFAPgSHX7D8t?=
 =?us-ascii?Q?7qUz3WvsOFsGLfBdFMUHTtSxnucs5vWgo3CFX1+hVSf+Of5GbzRoGrICQLmu?=
 =?us-ascii?Q?HnMptsveb+6eEJN/2ihnsngSrrbH8T7ALWJhhc+BNAm7UpCgiE5+6i/tfaDK?=
 =?us-ascii?Q?gEvp6g3M1i3fn75RViEe/Gt7exOcrBkPzWCbbF8DngxEiuo3kt3/HDwy9dnk?=
 =?us-ascii?Q?OgWV1rrhvGwaNshqrDn4nKUdAJPVApbC37fyBnziSzpaSzaUamGv96HLZ39h?=
 =?us-ascii?Q?f6jzJbJqCzHuoJXvyH/DJXbHzJnisIJI68w5JX8d+q0mbt9M4MkWzv7kIQBB?=
 =?us-ascii?Q?AYOiawTPaACU386yos21Jf4+QAHHf6vRM+Dv7c3M3O9R2m1L2vo4KEJ2vyGy?=
 =?us-ascii?Q?hpBwef/v/qOSSDEjMC8m+tEFJ9sT8NO+BL0EtffjKVNIL+WuufQTIJWKAxB9?=
 =?us-ascii?Q?9lRUIrBOnMtLgMA8/UbcHwhhXgGJ/eORVMTWBnVz/lRpYU3MrHYcUWMCTXRF?=
 =?us-ascii?Q?ZTf6E2RGvDjE2rUZOeUT3CpXNlrGdZ6q/ciVy9Hlvuc+zul/2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:18:56.2382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b581a6-1e4c-4598-9ebf-08dc9144af36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

From: Ryan Seto <ryanseto@amd.com>

[WHY]
Added HW cursor visual confirm

[HOW]
Added visual confirm logic when programming cursor positions.
HW is programmed on cursor updates since cursor can change without flips.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 29 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9b24f448ce50..de0633f98158 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -416,6 +416,35 @@ bool dc_stream_program_cursor_position(
 		if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
 			dc_allow_idle_optimizations(dc, true);
 
+		/* apply/update visual confirm */
+		if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR) {
+			/* update software state */
+			uint32_t color_value = MAX_TG_COLOR_VALUE;
+			int i;
+
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+				/* adjust visual confirm color for all pipes with current stream */
+				if (stream == pipe_ctx->stream) {
+					if (stream->cursor_position.enable) {
+						pipe_ctx->visual_confirm_color.color_r_cr = color_value;
+						pipe_ctx->visual_confirm_color.color_g_y = 0;
+						pipe_ctx->visual_confirm_color.color_b_cb = 0;
+					} else {
+						pipe_ctx->visual_confirm_color.color_r_cr = 0;
+						pipe_ctx->visual_confirm_color.color_g_y = 0;
+						pipe_ctx->visual_confirm_color.color_b_cb = color_value;
+					}
+
+					/* programming hardware */
+					if (pipe_ctx->plane_state)
+						dc->hwss.update_visual_confirm_color(dc, pipe_ctx,
+								pipe_ctx->plane_res.hubp->mpcc_id);
+				}
+			}
+		}
+
 		return true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e0334b573f2d..64241de70f15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -476,6 +476,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SUBVP = 14,
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 	VISUAL_CONFIRM_FAMS2 = 19,
+	VISUAL_CONFIRM_HW_CURSOR = 20,
 };
 
 enum dc_psr_power_opts {
-- 
2.34.1

