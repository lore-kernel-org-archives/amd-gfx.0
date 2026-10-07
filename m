Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCECA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D468F10E61C;
	Wed,  7 Oct 2026 17:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5Shy5eW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2366110E61C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCn2xZReN2ObQKN2se8g48sMk0Lexl5ydsqaqxq+s0s+QJIoKvlFoz7VkryotOjYYWpTbcL53TSDJlUhJukh6qgzkviuQXj0//CQPUY4O3b3Yt/QXJTDnRrgFpN4cB85h2+x3UAhPEFuedc7UUJDWWB2sVtq5RrwqEq1GXsAOU/snRt/IHoL1zhQPjZnY+gZmROpLh/kEhD+R6SEzc2/BNjOeiIWKpNpfESftLaAqZH1Y440F9NpMpMW5mBzIppeUc78S5i5NhGzEpsrX1cIrpXBAXAbTV+f6wmOdXg89J+I0sd+SyIxs/9KCj5+3EGswBIzqRBxYf3j6ZxjaijIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+U8LT1BTsE8PW+6omuXY4STHKXqH/Mhek9A2jZiPgY=;
 b=lkXJHAqPFxoDRX2iFQe9pogYt8gRQ5IUGNa60JOVBJsSS7nDWU1PvnFCigSh5xhyDZ9NyFQPKgI7XNaQj39s85HIr9z7tBh1PRTreGKXliKWS5JM6K3hTO5z5YGpYfbAxtCzImz/IsrevvSLL1HluuAg5TVdCK7Nv2PVOO5teCGTsYeYyzo8MwvZ57FEJaRYpIh5MYm/01W86qqcE9iiQjYTpB3GScv1YSoyLZykOs/NejWOW3ifTUJHxjs1XnSQlRgXQJwAK7HGwUhqKAaUiV8mq803Ho6SZI4idiOdu+igypcNfqaZY9jZah2QFVAzP67lnOE07A/AHXoklLGN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+U8LT1BTsE8PW+6omuXY4STHKXqH/Mhek9A2jZiPgY=;
 b=d5Shy5eWUcsMekbBzwkz1stWf+mRCuyxVvCo4X7XP6kYEDfFlSWZmFnoj9IFk9F+z76Vs3PsGFIk4HUH2EB3IBswqSruz5FjSMlkH50AI5HJ2UzOJCLGBdDcQBlf+bVQM0KhncrUYiCryUxJE2D78ZIufAkyA1d2z9v2H29SRuI=
Received: from SJ2P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::16)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 17:04:31 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::8c) by SJ2P221CA0012.outlook.office365.com
 (2603:10b6:a03:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:26 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:25 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 06/19] drm/amd/display: Directly include compiler_attributes.h
Date: Wed, 7 Oct 2026 12:59:39 -0400
Message-ID: <20261007170412.1898315-7-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a3d436-5953-431d-3a60-08df24950e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wCUqinfZUaFAhzUV9GlORC1jWqaFreQKgNChoby+3KWVvnigzjmCDhgUWvN48HSqbJUfD8QtmFKl6kPMFigLgKCcWkSgwAtDVehB/7c/3jzCEwGxFzqjGpfqSIewHoVey1KIZaLvJhzYq8XIozzpBg2kLmy9G2eAt/Y1GVmOT2nTQbUqM+4u0Jglrd2kNMKEjsiTbvGY5Kb47IsOwBENhxrJwG5OTvfhFgZVYcmehqM2QjJUfrHhWG+AQnnRNBZtEhCTBOnHlCwgE94nf+GiGxanb8eKJlqvpcUM7RGXdp2LIUcTB9v/FbU6ncD+wHc9lkJzinglI1ngGWsFLASdcCLdj5KMnFwDI8Y2mOWiXw3vBVZtMy6et6xkbEMVlBDcrT89rzNR3tYeqW9Lvuht1xwa9aeSJ24DC/egSTV4zjVKbsX2kV2MlXLSfBPlOPdYVN3pnLCWBA4r9q84Jz1OTagA1hG0sVW2swSzXPLScGh32Q/6bJMZwabgrsaxXv6iiaADX1UsXs7Oqqkm39MRMeYEIiH30NuczsWFfPw60xj3HeM+ojtF0ag3QxCsdE2B3WoImQ1IjmevMHCSc6sEsSzVHHYmXy9fESiaRqOYvrTuVUJagcw7AnSuOHLqj+XkPNa6T7G78/9K3CvSkMmt9A0lWexT715+5CZhV9Sy0bbX09VAt4Wgc/yBHW5yWmtiLNJ24FUfUE9tMosv9Vjb+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fNXL9q/sqD7hAmkY3RVvCxybggi8E91KIE6+A5VNYz7EXLJQntlJLU3zjOPoaq2pO7TDWGMOa0dxF+Teqt1PdmTfcvuQxRZFvBIzYARak4P04i2ISWVw9JJNYkf1AAak6xOu4b6rb6o/DUCme799rfiohfZG8euEsqfdlNUB+WSFp1B7gzw8pxv4qLsd6f7CXbObS6I0oSdxEneb++r5CYCbobcS8k+cW61eHarza9iMbqSfNRBsHQDizo7qRbJATLseaJ9dgxQyZeRlM1pLEAlnUUM7KVsEwDnpjGdlUl5JmStAuw4H5tNv+cw3GSPW3U26vPnoSohAeLV17M2B9nY2S4ehHrjoeSWXIAUM9tihKTefBUfSV5sI65kJNZAQSbBM5+4H8l0wDLmkOCa1hBxBUhJEV7JElwOLKSj8W5rW65BcIs8tEoIrDjO+7TMN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:31.3977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a3d436-5953-431d-3a60-08df24950e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why & How]
External improvements will allow DC to directly include Linux Kernel
headers without the os_types.h proxy. As a test, dc_memory_pool can
directly include compiler_attributes.h for __must_check and _aligned.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h | 2 ++
 drivers/gpu/drm/amd/display/dc/os_types.h       | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
index 8a5a72f4cc88..e3db3a43550f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
@@ -17,6 +17,7 @@
 #include "dc_memory_pool.h"
 
 #include <linux/atomic.h>
+#include <linux/compiler_attributes.h>
 
 enum {
 	DC_MEMORY_POOL_SENTINEL = -1,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
index 0ec305813d66..e0d3beb60ef4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.h
@@ -19,6 +19,8 @@
 
 #include "os_types.h"
 
+#include <linux/compiler_attributes.h>
+
 /**
  * Non-resizable lock-free memory pool with fixed capacity.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 27d4a96b958f..339372293a98 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -27,7 +27,6 @@
 #ifndef _OS_TYPES_H_
 #define _OS_TYPES_H_
 
-#include <linux/compiler_attributes.h>
 #include <linux/slab.h>
 #include <linux/kgdb.h>
 #include <linux/delay.h>
-- 
2.43.0

