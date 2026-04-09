Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E4F364AB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 18:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507D510E860;
	Thu,  9 Apr 2026 18:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Moh2z+8i";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24CB10E862
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 18:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlxUZhEk1nKOTOEIGoY0MjZ/cCpoiWcEV+TtAsg11R4TMw3xA/BSdbRadzO1li4DoFdlfY6WvqPTOgyOQdpIGdA8uUbmoRLX1OaM74UhqpYUcxoMyqMl8Vwlc3lrUa2X0sHJxkqhxBNYpI5R12/tk2vQWgecaDvyTgIhj7ajZ0N++Q3rBBNlByAVizvl/h2Nw8Jo169z7pGprfs+IT8VhBpEC16dXioUFmVYqqA4QihiRZBnndSc86reyo9OETp+x3JvOPiGtfqQUXA5j+8Y+qEgMnU9Fwae7hMg+HdAQxkCOpWCf8ehiLMs/mlsRtF+B6eP7ZHQ8IEP81NESNxMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJbQmBy6pfyk+qUCGYzoAsLSVdBGUrgburUlAIOHo3Y=;
 b=Hnxw92EO/Keh5nud1OyjkS+cEuyIFBgO92sZ5kKit00ME94GZQ1plNnH9C8/cX3lXblyVplPxa7NqWgw3l5tejTt+4EuzFAj15HbZdXsiq6ni9EVEgTuWwR73iuJE+sgC4S/sVrOF8+d9M3a5yOJqwaGGUgJ69mucvn0iMM0wmbTsxXnzFHIAzMpzkZOdHRBPnY/Dw08STH/JjVNEybYmNU2v8INzg8pBWqrnFC9E1TPupuuv0ZBFthuQ5ScIOOr/NGvpAct1vCvnehNIZOdk7hR+6O07CquXcmRxY8xHsWzFX9ZRy96y/JkrgIE850YszzJOEu+R61tnASb7iZY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJbQmBy6pfyk+qUCGYzoAsLSVdBGUrgburUlAIOHo3Y=;
 b=Moh2z+8iko84di3gk5GlZittLDx9ni4S7s7rTBdzBSlNqVN3+M6lOz1GZpS1FM2HOy/WD7/nSjvsvGxnDx9hqlYvcDMgiUSY5FeBE+eqi3IAX6geRoq0Fue726VVzzNlGjzWCYPFzLhRKSZn/Isi2d9wY2rUF+cNTuCDX+7+I3g=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.33; Thu, 9 Apr 2026 18:07:00 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::83) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 18:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 18:06:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 13:06:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 13:06:58 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 13:06:58 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Aurabindo.Pillai@amd.com>, <alex.hung@amd.com>,
 <Chuanyu.Tseng@amd.com>, Roman Li <Roman.Li@amd.com>, Linus Probert
 <linus.probert@gmail.com>
Subject: [PATCH] drm/amd/display: Remove redundant includes from DC
Date: Thu, 9 Apr 2026 14:06:54 -0400
Message-ID: <20260409180654.1628589-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 32356652-6de3-415f-dfa8-08de9662cb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wiz5uEgxHQv20Lyhgo8QEjQxmZ8x98BF16MC7Y7EAwYr9fDKRP0ZGPKLGwPx4qv+Kamp10bLCWkm3JlBfHxKPAbiqHrKvQk9OYj4GY2FUBsllmdJqxRbMDEcvkIazJ1dDWHvDrI1f6ZEe/Sdu19zAozlp0ScgqIiI16EMpAPUHJRW/KKmsk03UHRcJktYxriib5ruE9wZvhIceWDwuLWTInlm3Vvf6BxNe5d3wUi6dTZ557n4/u83cBOZ8tu6Xs+FppCbF3/x5sst2XC7Qh7Vupv37XKTLYYN3IKuV/t7Uo/mLQenUp03i0fo7UA9qesawKmjv7nwPN+jQ31gUEE29iwhNlFb7KECPMLmTps4K+iAZc9sYYMJC4K2JrH6i/tfvW7PDSS0DfQ/Kn1z2HEKtwQ5KIAPIhjHf7Hf0KveNdAu6pRSFaf0/P8IP9d8N0h3Bl5Sk1kpoz+ez5/5bLQc6V8B6lytZF61BQhi6EqWHIFqA4DMPOqBi4+NSlfQexOdFsAmUok+X4Ye6uoDRYaMvBseqAzd3PusFcEP3jId5Tu2VB4bwRK/JFaXWU+CMll3ieJTJzwgINPdFKgCW0lLJZEtGwZMkYwSmeyfQni8UjUYDqbZ3O+Vh5EzYv1u9vv3xY6q6f/Ww3VIwt3j4SBBvgA5M04GE9YmIjaPWqhBhahhDRjQKrT5DdZOAi0Iq7mug5hySBwAv1ExTH/Q21exqgt0OCMoSBSREftFmEQeqPzpvKknqiznolIoAuLTF7/aKc7mKRzWqSPZ/cT21WchQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M68L9lJoTXWekfH6ViUIdt+FH9ee4wJ+XO+e9jL1WW3pGdfRD3NOnDfOYvlkXPjGUT9cHK/CJQDdppk+vOqOKaVq5kTSOwGovam86VH/3Ad94HTvdq6wQ7fCfzoUZSt0AKAYVQjHIQOpDSMCivhe9MKvRNZ41J38M3inczaQZzX9YtcQKqeJYXQzNMWlYCjajaoLcjoJmK3hJWjCnyVJf78QVC7G/lS1wD9kGVJ2c0zQbl9UXb1cFQ7bcNHUUdo6u75GIa43ZeIDN2+2yld6IeUg2F4elNw9UrmNscLtwVnj03POEOfA0Q10ZtOzxiRkJ6zoboiZpzGsEGcBdsi99wRHKwaoTyVIn7NMSaGiRDYOLbSMwyk1BsPXXkSC3rtLQKpPKiu62otAwfW2bwdQWV5N18LcGzTpo0DCvnkUgPN+k47E44/1ReQHw2CnHFXs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:06:59.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32356652-6de3-415f-dfa8-08de9662cb46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The explicit include of linux/array_size.h in Display Core (DC) is
redundant. The ARRAY_SIZE macro is already provided by dm_services.h
(via os_types.h) which DC includes.

[How]
Remove the unnecessary #include <linux/array_size.h> from
dc_hw_sequencer.c and dce_clock_source.c.

Fixes: 1e29080bfb8a ("drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE")
CC: Linus Probert <linus.probert@gmail.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 952968ecd46e..7333f5905330 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/array_size.h>
-
 #include "dm_services.h"
 #include "core_types.h"
 #include "timing_generator.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index eaeca4b4a042..321a012268b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/array_size.h>
-
 #include "dm_services.h"
 
 
-- 
2.34.1

