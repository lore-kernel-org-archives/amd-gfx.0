Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A427D2F7F3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38DB10E7A3;
	Thu, 17 Oct 2024 06:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+q6k1eU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2222B10E7A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg+958Gq4juSxTrOumCusSHTWUr2G5Q0VfTm3y1GoGpAwAmQPeJnSSKe3AeIGw5635U8p6K8vmxYc4y1gTvHN7IEbudpce20n+ysr6yul8/QU72dhXmKvpeeTIlxZ3TrAv96XaU0O9gFdhcNSmvRFqBxRbzwgvm7kXlV9oxlI9n1GTqsKswuTVszzR3rcgk3H2cExvVF/Ufz3VYKXHt+3y71VLl4dl7aj0uYFcsgSw4rW57Eh129i3CPqPC7kZd67BsiYiqSBozED8+LYW2swdbz0YfK/CLv7sizCiH+Da3hBWTKKPzx4NXJdT2eWmdfYnnOCxW0yNSvObwQ9bNRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owqkMbMAbXKDET9G44MsjuDJgLf0MSQAPUwGJn4usbI=;
 b=yMVe2+XYirIRkdofLZFvgOiWm28HM9WG8Njwcs1a/Va8lvmHpOy+MCbj6yuChJnLRegRIVwu54qlN3vR4GjhV1xfqfbPR7aNUI9YujhyIDLOK45BOWEJY+MuXu5U9VIFwyXoxy5rFNxqvuW4HhBnwU0TbSKlMNdmggJ3kGUFfwEZjB06G+k+3IBvfOwyFT2H8u8ovUWEg0uy5i4C14v4zWQXr+V5cn0nm0iLY+eWy5i+wMcjc8Fb7eYd93J6KS9xBlahja+EvXhd5t7qAEbzaIyCDLQ2297WlL6YHzSV/eYDuaCG9vvaOwaJg1LQ24sM8pakh3G0AzDWfjmWoz8XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owqkMbMAbXKDET9G44MsjuDJgLf0MSQAPUwGJn4usbI=;
 b=2+q6k1eUZtsm3moVah8SvJuqdnSR5N7/kTrtx5DuLw+hM4KutJEvPJxEh4UljvzgunDzUhNRAxmSpjEEXRXN9GvQYuuv0LuE2oyUcbigu+3BoUd2HifNXYyG8bWfpezKtxmq5Vsp8HH0UwKdipS//6ZGS5pWN80nXsIgs6OxxV0=
Received: from PH8PR07CA0040.namprd07.prod.outlook.com (2603:10b6:510:2cf::26)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 06:56:28 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::79) by PH8PR07CA0040.outlook.office365.com
 (2603:10b6:510:2cf::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Thu, 17 Oct 2024 06:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:56:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 01:56:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Add hpd_source index check for
 DCE60/80/100/110/112/120 link encoders
Date: Thu, 17 Oct 2024 12:26:12 +0530
Message-ID: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ca0be8-e2c8-4569-5386-08dcee78d278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CwSQRTkp5buEI9JhT5rE4Mc9L47yQQc/2qQCFvaacFFuj5KLATLb0/1yfkYh?=
 =?us-ascii?Q?k78E3D7LZFTrgi70Ge9LSko7j2tQ0LkV4r9MDQVsdYtVNOxsEqvBJx4yWpe1?=
 =?us-ascii?Q?+fsLQQcyQQs8gcUkrHSPmaai3xQ3MvM4K3hPMDxnHr1pBEZrtzJOfcq0kP1/?=
 =?us-ascii?Q?HlcsD0CLdNO4GE+vnhOQEqE8RJpgOHsRXc1wUOkJgvDp7cV1dAHxvMqpTQQ5?=
 =?us-ascii?Q?v2KwMCp9akMuGatfOMQ7u/l73rlOfiaZQYkqPT97bF+/IQ3bguHCaw8328iD?=
 =?us-ascii?Q?MaTt7s0JYFaDWmjSwVZjv6TnLA49QTfqtNSzySsfyvOqf4jYHbCkA6infdHI?=
 =?us-ascii?Q?Qcdqjry4mal7P0f/z15WmWWyoJJIoj49Sj6+1BABUr5qOkFM0UBz3XB1UPGf?=
 =?us-ascii?Q?XYNemFmGyptJUqVKAxI4zv89/eHdEt264njopKnjuviwJFghiUfE3kZF7O6B?=
 =?us-ascii?Q?I+4riVGwHwAk4QooC5Th4iLsemSwT+6He0blk8yRYwrcdTcEDEvIN4bb9JkS?=
 =?us-ascii?Q?8I8Nchwv8QDbuWSaTCeyy6E7KgsFGHp7RZPI6mcYsAIuDcSM+03bPNYEuT26?=
 =?us-ascii?Q?9GtiB+i0Z2y2W/IF4AuXXidXw1DJSXv5dhiGj+0rLmkazXaRK/FER0e0AUYK?=
 =?us-ascii?Q?ighdjUK/GE8XTg+gAsEgs/nx2wj8SXwuGCyQ4JLaCxzaadccDsy5l95SuH0J?=
 =?us-ascii?Q?n5f7NbgcU8doLKzV2XNfJGTGSZHHk8l1lncOvL/6SVkLW+DIlmS1z7RpO4YL?=
 =?us-ascii?Q?Sytmy+cOQMzlaPrOREDWoaCBoCoe9yejIPWySYWYX/hrtdtzjgRe0+U5RLls?=
 =?us-ascii?Q?FX4b6H+55Gole7O+HXt9XSER+wKAXFLDBnNhtc9AXqJcah4JFo2hV2qKumD5?=
 =?us-ascii?Q?MGvAfKkhNOoQ6Yvu2s3++yODtvpzEG7sm3PUtT8JzCIU2iPM9fYJS+y8yG9l?=
 =?us-ascii?Q?fHUvSJRs6UDsdkirl13EPVzXX9XDjHf5N1CKNVjEgwgtDLCzZrg4pN8xWhNy?=
 =?us-ascii?Q?EchoyVihyOdlJ8kNjjwCK0rDJz5F6h6Musji47JrLk+QDbKxi83OR5XIdITo?=
 =?us-ascii?Q?WwfJdAywQyYreYzpg3JaYU+CBdGhyjxryxkwHlhTl/WNPxQep6bqhVTkOATK?=
 =?us-ascii?Q?3F2YWzW54X9ut3OIXs45XyTJe00CFdD4gNiLOg4E8SIESWTdM/xWith3/fWr?=
 =?us-ascii?Q?sFhU98B1oI105GfdR3P6hplB1j3IqWNOG3AU81oZwcTNEOGcEe59NAg2h7Lx?=
 =?us-ascii?Q?QkmAWZGCa8ERZg3Kr7RVK038R58BmFRPOqwfBTLS+qhvoemiX4o10opJT+SD?=
 =?us-ascii?Q?V4MwtnlQoNZHHXh8bvatAjLyv+wgyDuZwEiRPKz/tD0OLa9XfyVrfG+i8eIk?=
 =?us-ascii?Q?5xt02tERa00ITLlr4PBFArFE0g1qOASGt0HuPRtlvjae1c2OLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:56:27.1698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca0be8-e2c8-4569-5386-08dcee78d278
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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

This patch adds a boundary check for the hpd_source index during the
link encoder creation process for all DCExxx IP's. The check ensures
that the index is within the valid range of the link_enc_hpd_regs array
to prevent out-of-bounds access.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c           | 2 +-
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f7514466..889f314cac65 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -717,7 +717,7 @@ static struct link_encoder *dce60_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 53a5f4cb648c..e698543ec937 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -623,7 +623,7 @@ static struct link_encoder *dce100_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 91da5cf85b69..035c6cfdaee5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -668,7 +668,7 @@ static struct link_encoder *dce110_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 162856c523e4..480a50967385 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -629,7 +629,7 @@ static struct link_encoder *dce112_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 621825a51f46..c63c59623433 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -706,7 +706,7 @@ static struct link_encoder *dce120_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a73d3c6ef425..3d5113f010bb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -723,7 +723,7 @@ static struct link_encoder *dce80_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110)
+	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1

