Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95498C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A1010E55A;
	Wed, 28 May 2025 02:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5ZR+NGV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB0010E559
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8cKyGmJt0zPHc8XkdkvD/d+aFXxaAGboNlnI+HztzaU2ZNc5QBpf7B4dgsgazrWS47aUdQx04dQyToMLXz0vt61057XXf7nK5O3kbkVwQXhyza/wJKu4VVwhWoFPyIP3NSbFjIrDUq/CiKDuW9QHJ52L8wLafdQsJhVJnlK84VPsDD/bAIR7YkWsK7KL0EbowIf7xr7DhTBlj41FeQp1Aa+uO4ULrPVw5tm7j+IeA9FO9G8OfBWCnm9GlnZppzka0+tDmrLKD1aW0DhiNeA7Zp4MAWtpEhSJV7fKb7elI8klBmSJV36z8qHMDXp8J6a5JrENeFtaG2L7x/SA4ULow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PLyzcd00hMdmD0Lea/2KONfGlOrLuwThA3m4PfbBJE=;
 b=iSZEW+lp/FqN63YrVu5+6TZdSbwHTkXmoQzs/eJwN2k6KCgVU+Fcp0sXr/lN1aPboloYOy0mwpm85JxQ9yeTzgjwAQjob2ZyuUFr717mylgAPQTBm5YNNeIYI4JR7SU9OJcxYDPVxFFULu2cw+duPfE0YX7e6yFq+CSC8ccb8ztfI1bNTJ6qG08j+4w/wLaSFCKAjPbo9TiiokLb6rWVeW2vRZ3hruCVuuxSHJVbBtOHfCXmK614huuLj6SY0iVEr81wO9jhyVDe++bNsQoDw7jMJwEG9XzFIcp6jmpyFn2pyYX3M2w+t4jHPJyoxYDZRBwvJaE4r/5WuuNhIATg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PLyzcd00hMdmD0Lea/2KONfGlOrLuwThA3m4PfbBJE=;
 b=S5ZR+NGVeHY7T6+GAGFoipyfp10JKVv6C+CU104upcT/wisyfNQ4rSoPqtVUO6v0co9/jZPd56hlcqEmk4bpO72Fyjmev5fsJghvYIlgY75upBmb7dgvjKAaKqHWFA9ME+y2EkmFDqH3YbnJLNDncLhF2OhiwmlCO3pWXJiySZs=
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 02:53:41 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::b1) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:40 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Move vmalloc include to header file
Date: Wed, 28 May 2025 10:49:10 +0800
Message-ID: <20250528025204.79578-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 378c2d22-b17c-422e-c3cb-08dd9d92da6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1hzdOuXWdhdbD/Z7cz7Ehslw9cwHvVsuK+FkAZCiH0vBtIVZcvmd5d8284pr?=
 =?us-ascii?Q?TLagfnQG6xTblh8Lmosv99icNRprRmAyCVvHiViNNgak/lCvJaeDwN0gqHAa?=
 =?us-ascii?Q?as5PJL9TK57rUZnHC2AohUKNPL/J3wIRSQNRCSOZic0smGuTsM9Re3bFAt42?=
 =?us-ascii?Q?FFn4AZSRr2R2odr7RYmpjxZWVU3e6TykSG41ORt5TLySJagmk7+ZCS0TAICG?=
 =?us-ascii?Q?jCQKtzm9ZCeaUvjfwhC9Dfh5DxapxOaLGGP3xmMYqUgkdk+/nhlzXfeszjhV?=
 =?us-ascii?Q?aBZarVzeqpC0qnG9MPHjslWVbjg3C6iUYJ2DDcwFza6rDgKMyo2nhkxvKqPX?=
 =?us-ascii?Q?90UormjJdWIQDMWDYZK/ZAT7akQrdqifysIgMTSVmlQHn25TIOXw/J9qUE8I?=
 =?us-ascii?Q?9JQMmRyS8peTWXK+tYP322D0phktcyalY9mvOB8cXzERJCkeFC8KF1Q1z0Fi?=
 =?us-ascii?Q?qUwio3LNcwirOZx3r1YUzIPVKujQY9sy2fTn7ISPuNz6knIoYrTrfY5+y81R?=
 =?us-ascii?Q?hxWRso8ge1sUt6ETeKckxOcpyIypLxNJltLn/hRYDTCB1oCxH5l2ejFeDfd0?=
 =?us-ascii?Q?Px1V+sgW/FaVFAQPjeNxhV9nWx1OMSPZ55mijjEM2SegR3MkZGpgcUlCv376?=
 =?us-ascii?Q?y4ZG/9m3HidUohWxHl+D3ZjKO1ENpkue2E6+Rk8q3DEhSomZXfMyTtIeLx8l?=
 =?us-ascii?Q?DlIHaV5RYWVfwl0563a3FrmBfheJ7gzp3Xr4kPGBJzgOfq9VAMhz/LrU3420?=
 =?us-ascii?Q?S45YkJg9TTAhvcpsJpzi9rbon6KSLifXv3WJWN1QoDLi3SlVDhOGG2JChrHg?=
 =?us-ascii?Q?cv+iooeg7RChL0hmu9jqsQHg2/7x6hKjV6SEhKTbm179zCepUkUESPxxVHlr?=
 =?us-ascii?Q?pm2K60ajN9b8SQGi6LsbDw0wu5zktsrYD1DcaJ2gTZMGY7HQJDia5y/cUAZJ?=
 =?us-ascii?Q?ulH0HS27eOsOJ6UOJ0/mnrOTOZjgqjf9qAtjsNTmKOnAhCHcgYOeypYXMrjL?=
 =?us-ascii?Q?xM7qg0T7DupcflDs+kve5Z+8p6VIxwuRXwNi8tO1R8fhGbygeydtMW+BY7DT?=
 =?us-ascii?Q?tDB3rHw3jqwjA9beEOGX/Gl/N8e4+W9MvIYkivcmhGTyg9ZoYULXR1SqCLYf?=
 =?us-ascii?Q?S9O/bOv1ABE+j4d95lxTknpQkrTxgWRNYvwD7aegP5YWEJKfICIrp9gb1W4L?=
 =?us-ascii?Q?cD+Uwmryr8r9JFUV65+loD6OTxnqtAgIGvqYIuQQzVw8OClu7bZcSj5Wp2uV?=
 =?us-ascii?Q?1wpNs7YReZVduMlzGTvKirgPMFAB0doub0X3VDibJP/ZbOnvEKd4GSSAGY33?=
 =?us-ascii?Q?8c+qdgoieT0d3uUBhUTjJ5aeqA+IIbvhh+sZ5NIP1HS8GznBCd26j5XafVaM?=
 =?us-ascii?Q?hFcQE47NygTXc+CVwf/W3+0ipiOMkLf8FkQ9FfgHtvk4B80selSctcmb2VoB?=
 =?us-ascii?Q?VMugG+ROVyrnfbnRfcFe2b1hMwnOIlhOVrnn+wG6tj40Zo8vZIfg4HDIJhB0?=
 =?us-ascii?Q?9sEUG6tx8DccrF2fC8IHLhl2iAgLB5h/IA+9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:41.0865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378c2d22-b17c-422e-c3cb-08dd9d92da6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Move vmalloc.h include code to header file.

Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 2 --
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c        | 2 --
 drivers/gpu/drm/amd/display/dc/os_types.h                 | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 208d3651b6ba..c8e78a8d1539 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -2,8 +2,6 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
-#include <linux/vmalloc.h>
-
 #include "dml2_internal_types.h"
 #include "dml_top.h"
 #include "dml2_core_dcn4_calcs.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 525b7d04bf84..a90aeecd3b50 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -24,8 +24,6 @@
  *
  */
 
-#include <linux/vmalloc.h>
-
 #include "display_mode_core.h"
 #include "dml2_internal_types.h"
 #include "dml2_utils.h"
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index f2ba76c1e0c0..782316348941 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -31,6 +31,7 @@
 #include <linux/kgdb.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 #include <asm/byteorder.h>
 
-- 
2.43.0

