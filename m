Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4CC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757CC112963;
	Tue, 12 Mar 2024 09:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jy1XGMg1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C78112963
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkxL20TMyB7f9ReaC++POOa7rGxzY6IyhYnpFBfVAZV/anq/BgwWmyY9RagmkzipTm30C4yktBMdE2MRsvDW123lQsrIixEwYORWJqvO6RFFAe//7v/mKNAhUVv9cDUeaRZDItioYqC7pnfZAo8HSx0IEhHsyzc+0Z9xWUdHgITv59amZAQExSvtWiVfjX1mDxFmhg797B1TihwjtahGKD39S/AWwA7jepaKAC/I7i+ZzbqJ0WG1u0YZPI90OCC39eCrDYjYhwBuk334rTPO9PWkaAEECMWlDLL41bvnxUCR80O8zTt20BSsqqOEQjsTbafl754DVhHQ/2b7lYFgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNySH0ntzdqTR774TTw0nuZ6QIvOZsvTF/UJEopI+gI=;
 b=gd7hqCGlPRIUrBfDct4A56pbX8hRrqgEyGpHbH30UXxCy1EmN/Ch4dMWcm1EAzJ5ys8sfRgG+pTBjywSIoSReN6XT+KBxaPYIwWRpS2Xz7Snlw4HXr5T63nMX3popEOWbqIakbnGyHD17HSuinc5/AoQcocF7K4GcKk4Ts31eZOq9YiQMW0GqM4rXRbs0fDSGq4L8i0kzYsGUvs/nJECy4LEky2+EnaC8tsd9Jb4apUuiLhrgXnQ2mpPTiPmbDaL/pJd4S+A/ZGAbZuE7ArBdqydKcCj9vsYzq+CFrNAJQ0QfwqGzP8P1YStp/eUMOkjQVyWPc+bfYmOWR3mofqmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNySH0ntzdqTR774TTw0nuZ6QIvOZsvTF/UJEopI+gI=;
 b=Jy1XGMg1nrXEubMw4xwlRuMxJsaXOyjJXv7H9N5yTJZM2ghgbqzYmJmZQMviUBCpT8C4zhTEatrva4S8FmfdlldYUT93ghu1orSgC8bD0x2NtF74Cd+0Ygddj0XnUdCI7CLtaZA410gnlHqAQVlUFiulJfuWydhdvMCKy8IY9Ao=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:21:31 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::b5) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:30 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 06/43] drm/amd/display: Add the MALL size in the fallback
 function
Date: Tue, 12 Mar 2024 17:19:59 +0800
Message-ID: <20240312092036.3283319-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 45947619-292f-4a91-8c01-08dc4275cde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9prL4p92vOUfnprrIk3tveAn8ZfgfE9WUQsePgfoDgP9X5Of9UwESpO76x2doBqfvYF4QpbNQU+aBpZw5wx1NH0rSxy2GRlbUKYzCQGN9AVwWJxR1BoL9baOAYe0/P3vAEofGWLOCtYikDSwH+Hx/HKT8gvwlLxzhX48krPXdQrBJGw7PpMN6lwGe6AJLoDeQT43u6kUZ0w4gW1b+XkmFoLMZjib08nMHZ2TKDupHY64x20bvj4eYl9A6jLl3TCI+Bxm0CN5WMPTZWDha8PlpDDVjCGm1nX/xtpaqp9pb/o6SFREGVIu1M4eW/aR6HXFxg10EUT2t2zbKCgW9yihlRAVWQbbD9felWVln+k7+7Pip75xW0cvKVRoodsP4BXzrK46VkaWOv98dJMpi1oRpLoiCYpjeDiBzVMcVc5xQgBWPlSsG7UzdLkkmSQeNcRo9mq8dIeFkXgnHQGAmMwnE3VnQt5DLDozjnADktyQmAHgQbm0IDd5e/N8w+PeIKnwZuGwea0kU2XWJbc9QF1ONw9ttVUynupEoSn9yb15vwAs+bppgMRDWlkPdP/N2nHvE0/CgIVQmOP8ISC+zGp3YAOrZJD9wpAPZO0MWa63WfUO4MNtVZqRU5hBbARDFJoStynJ3zgUsG5IL8BSIwaeJLJs50d6JL3LNGoDs6wVGFtktG3dtbCGajdlFnzNmniXd5XMpwbEQoqMk+vQP8wgj9VHQ0hKGX51LzJiEM9+rldZRw0mOXyPi1g9/6/5U+P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:31.1094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45947619-292f-4a91-8c01-08dc4275cde6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
If the driver has issues retrieving the MALL size for the specific
hardware, it might fail since the current value is set to zero. This
commit addresses this issue by adding a simple constant value to give
the drive a chance to start.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 3 ++-
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ce1754cc1f46..1c657fe4a9bb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2048,7 +2048,8 @@ static bool dcn32_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 4;
-	dc->caps.mall_size_total = 0;
+	/* total size = mall per channel * num channels * 1024 * 1024 */
+	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 
 	dc->caps.cache_line_size = 64;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 296a0a8e7145..6c8129734163 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1697,7 +1697,9 @@ static bool dcn321_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 4;
-	dc->caps.mall_size_total = 0;
+	/* total size = mall per channel * num channels * 1024 * 1024 */
+	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
+
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.cache_line_size = 64;
 	dc->caps.cache_num_ways = 16;
-- 
2.37.3

