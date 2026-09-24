Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A279C98324
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D9710F73E;
	Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qR0GwdYn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C19910F734
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0eWxwjSfljlpGYsNtpeWC8Egmna6xaOPAWV1N4blWV0V4RMmptE+H1kNVBgPFjknKo/ktmXj3zApEdJUOQMQlT0oy9gcFYdfptWUgeWWAo75kuMI6jXEripKSQkkK98pJELti7e0ONHTWy7FhD+t5mY/1L1ho2+FGh4vuopituIoqa+YRrE+4U7SFqjm5bMflBXvNKaHF9iGr8pGpZ3NJ/pFnfXDCtz2X5L/Jv6CTtzIeyVc+P5ZuSiJOfbSV3GL9hWtDX2hM9IV0prY0YtyGVR131RblHgyTXgw6fS0NmH3F430CTz9MVlyARtD/4//De54OOcHTkV2nQIrbjYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWdROqgqziETnqvkkz9Fq9uvElQPGZ/QFdv5Y8Z49hU=;
 b=He05fN3JRrO/9NO90V0BBUwHG3Mnd5r3qHn45ujmK7LvUDRp1zh3dxSDtQaFSXA8SPsyKoU9fPH+EZgd706+xivGe6erHuXX/YoNSMEtv4P8VWiCr39MhmSIi4sEzINC7r96tiAjJWuqAGkOV4GRB5ysKenXPqF38QZ9P2GDiFc+aJ85xgO7HgoIcuQPaeWDyG3Grvkf8n7GtgW6OZ1eDknv/p6QX87LZSJvrtFutoU2IeDIOdCue0NSap5hgawMjqUp+JUFfRxQ0N5udp8keXaZndXCZDlljgaeYJOYxS9bGqreLyrn4j8KlM6JgSg0gTabgkg6XWWuBqh/5VNJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWdROqgqziETnqvkkz9Fq9uvElQPGZ/QFdv5Y8Z49hU=;
 b=qR0GwdYn2MXum4nToM7VFNbqZuBJDwvA6uIv5DciDnYa+pOFhTJFI7r6Y3JKYoIu2dmRbOOssB/nqP/nbbUpqA2f2BdYiBERr1o8PHdh44/pj9oUtmipd9U4IjA2UVb0nyJBfcPqjslxKMEcn34ppmJl+Lqehc5PEeTAA0V4RJQ=
Received: from PH8P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::9)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 18:46:44 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::36) by PH8P221CA0004.outlook.office365.com
 (2603:10b6:510:2d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:43 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:24 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 32/34] drm/amd/display: Don't round up cursor width to nearest
 64
Date: Thu, 24 Sep 2026 14:45:45 -0400
Message-ID: <20260924184824.596894-33-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a74c35f-6c42-412f-c824-08df1a6c2ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: KuQXDO2mfeOHHKrhQyxGQ4wQmJbU5np3vElWPGHQAa7BEPt7jKktYcU1oVPnhdU+eTxTQ9EGDGAcDz5ER7EwXWrdJZMN/SslT2eJIP6j0ywEijasWeaCiJraPoann2Bowhl2uvtYlqSByH7U0+DSFF95+8mRvSlUrVB5VE7KCFyFRjllnJNayvq7XRCpLMZQ1KZ0vnzVbIZpScAIqfApXRMjIDJBAyikl6m2Aqbpuamdesvz/dlVovVCAeuJgDjAhFWq8h9ZfZhyg6pNU7Zo3EQw0dQMKt7Y303DRCDedMG4nfPoXOKdgfMrmEe3yao1RqxK8tJJFxVDzfCddBw9AfvB6tYu68qfLumX0sWy63z87ad6V6qW47AhTngcHcWm9g/ImeHk+o6F7rHmgP88gYjtl8HvUgVtHL/uXz5clqP9tdsZOg01EnuZJbtUUjjiVBeEeGczAHOhEcni3zCKbAy+Asr/QU4sYO+YIKO/SMwXch5dMTYB2S7d1fjJ+pj2uTtGn24/IsayoT2xk0ldaOHIC2QERpALU8fg/xMls3+ORwkL6pD5kcFJYtbpsZ47oVFD7IrcznWjWp+7sf7pWiYaMIGRWZdTwIay0ABDN4b//l/O5UNkFgqlbKti+4t/80bxVGmkb1+ct1eeO5wl/tfiaibDJtdAVoNOmCqQzuoOY7omJQXAehzjdZaiC1jJp5neClIo/NNhro6D9T/jKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wV3DMaiSHy4f8siJT1+04QXaO8CFqxrHgDaFVDhEvqji9iyZcunPx3noHSOO9G7+wcZvyFE28wGhfpuAwq8/oiWAHMeWzJGfR2cfIpKM/iF/ISUwqFfrj3ynYI5mABEaXry1kGKrkiQoJL3FYeTtUVbE75c72vldCGjwPZ9+LpB1NZVawsebC3JzYJ7DrjL+43cXVxTYgJ44LeqsUhhYbDkY80vjyswibo4FZ5XU4oCrFYyCWAwJ0XGSTPk764eLJR6f81u4p8mz3EP+/7vtIzctzSv2Nw8r5RE5sDxxAvUR1rj10fenQIwfGyLfHhD6xIOKsO0JceCSu0Kh9EWKSrtjX2YyETqOznLpVG/irq942A6Jfpx98cv0dI3JAJX9iY1Tv7xJL7EqvBhQ6eDqgEjf9kiQFX2LNvMHBGpqRq0Eg0mcj6qTRIbx6O08/GQC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:43.7190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74c35f-6c42-412f-c824-08df1a6c2ddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Rounding up cursor width was only used to calculate total size in
previous generations. Do not use the rounded up cursor width in
hardware programming.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
index 4af60e473bd9..7c2ff310ea99 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
@@ -189,9 +189,6 @@ void hubp60_cursor_set_attributes(
 	enum cursor_lines_per_chunk lpc = hubp2_get_lines_per_chunk(
 		attr->width, attr->color_format);
 
-	//Round cursor width up to next multiple of 64
-	uint32_t cursor_width = ((attr->width + 63) / 64) * 64;
-
 	hubp->curs_attr = *attr;
 
 	if (!hubp->cursor_offload) {
@@ -201,7 +198,7 @@ void hubp60_cursor_set_attributes(
 			CURSOR_SURFACE_ADDRESS, attr->address.low_part);
 
 		REG_UPDATE_2(CURSOR_SIZE,
-			CURSOR_WIDTH, cursor_width,
+			CURSOR_WIDTH, attr->width,
 			CURSOR_HEIGHT, attr->height);
 
 		REG_UPDATE_4(CURSOR_CONTROL,
-- 
2.53.0

