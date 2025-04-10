Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B0BC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7E810E05A;
	Thu, 10 Apr 2025 18:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6JHBkBm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B11A10E05A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7vDAR7tlsY5+tS989XpQ9qNKjw0jusK5+jfubpm2YHh+emV7IFsdE/JJH3tTW1tq2Uwogxi+kLv4a8jsnA/ZC+G7qD23Ne6CnWFgUAzBJOV4B1JCEx/wAkk/OWmmoJmv6JakdYpflfBu5Ld2aSoly9RYY2VI5VjdTobuXC2n85HDvLrK2U3xAPZtLMS49/813zsASzeRCQdmqFjP6gXiJ4c2TRc2cpyZ8BAPfXuJwZTY8EMdjLNEkSGYlLktzDKZcreo4qWGC9QZmcKUKHRH4jSJY1kFXtOsbyRN0GCios5BL+R8PUGX1bMeJ8IzF9QLUk/W5k5olzgJzD/tlhkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdGMjHFYAPyI8CG3uvaTaSu4PTrIha1Us20dLRbyn7A=;
 b=MARaeOR3JcXClHkx7bmiDE9FAvLIaRN4hF8J9Y/Jvqh1Yi5TFOx/7LL58JFn3zApVi4a9hFaqwlTWt9dEKQxIc+Cy6BF94GnnKro/72X/SEOyJL/CZPiEUSIwmGbMS0N73pddTk9AW1DBR5H0QVFaWXaJIoaZhLW1akMITRVebqOxSD1Zv40S1WjS311ORPKj3R6T1YpMSbTKVGDdj6v/YZxr3Qgle7GllJmGT9pg2jhCF+gl7PXM7Q07GYHgeoeUKmpjGO4xEzQzMEwB/iI16qzBJJsc1cjWEzbQHs3BsjPYsyDkZo1tolCkkiunWiE8ERDGen43m56E/bxgTI/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdGMjHFYAPyI8CG3uvaTaSu4PTrIha1Us20dLRbyn7A=;
 b=P6JHBkBm4HMCmEoGP0ELIqX1DUZq+b1IHaGPI4xJej5ayBDlbKRWxeYLV73skidVbQ3TXK+S7Jcij37aPe9Q2FU3YYAFJf/ujXuKDYzfoMtlSZCyALXuJhYPZ5YBygTPbFi7hPy3RSA++apkfyyXeB+xHP69iWd/0EhD+/P+YQ8=
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:18:16 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::77) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:18:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:18:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq/mes: remove unused header
Date: Thu, 10 Apr 2025 14:18:00 -0400
Message-ID: <20250410181800.2303400-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bc30f2-f99c-442d-4ba6-08dd785c1000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cGcqiyZrMAUrCq+yqgaocJcb1pWvXRYWufIiQVvbXDdVPZ9QjDi9QzlzaaZp?=
 =?us-ascii?Q?WGsNYKC+MsM9uZB2AJ8weG/RFRdD7efU/bWs/XwIsb/z8uMkkNTr0/RhrPeY?=
 =?us-ascii?Q?u8AJwuxYj3veuTXgKfCVGWV1HSl9MQ2FQNYt08q+G3BJrFM5tLRV8MTBkpDx?=
 =?us-ascii?Q?wvoItkZpW9X/2ziEzRKkyj5+uQKg28bEfoIUyPwbkDwTK7lzbOAhsMrklYuC?=
 =?us-ascii?Q?il5ZgWqcrMwIRcDSCxeCiygtwPUVAbyDnaZc/p2lPqQljZ9wfYHl2dFgizYF?=
 =?us-ascii?Q?HvZ4ZeTpLq9fu5+C8ZNTK/kDeatNlQQ2CtTsbmFbI0f1hF7tnw/96kUek7sI?=
 =?us-ascii?Q?Nor4rjUw14Rbrq9kWcR0OYdv+hgzt3KTDPoj0WVf728lh8Bgzjf+aPzwO+sB?=
 =?us-ascii?Q?9LCXMc4MgW6owaYnSn2nWkp/QeOcDARjeJgoqK+xrdtGenw6Rcofun6bcclW?=
 =?us-ascii?Q?1JwO4e947xIxqelodeNTD7BBZHTbEzCr/4MI+6CFq+ucMcUin9yt/GVL48W4?=
 =?us-ascii?Q?M79zaedkamcT7J0xv20aPBaywxqvutw8CbpUEjI/d/9EmGh5JJReUCaeOkaG?=
 =?us-ascii?Q?/MRSunGiDVpSHibC8sHeMMNH8TtRXRxJfEPPVkmia6zcoHmHNLwMsRT49wx4?=
 =?us-ascii?Q?KGKXci9/P2/p5uj1icDB6zyB0rZhA+NSUqwzJ3cc1Rzz24D0j8GS38Bqo3nF?=
 =?us-ascii?Q?DEdPyXcgDf5Y+F21la93VrhED7B/dRuW/o9rw+xqpr/5aWChLq+CzN4H7i4f?=
 =?us-ascii?Q?ryX0gmhA5M6cFa4q7bEYpGlaI1Z5pMTpEzJ9+Spdrnwn5shuPGHFwRyLx30L?=
 =?us-ascii?Q?gTWWD0+cJqDe6MP1m/qE00wQ/tw+wXgzoAUsKAvYzqTJ3t8MrzTwSKgVlwgk?=
 =?us-ascii?Q?grCMExA2Ejam+uKAiSUQrPCEbYwGu+gOhsQ4ZFu1e898k7+rQzppHvYxGcip?=
 =?us-ascii?Q?uhTzN9GxZZdConKg345lXzGUSrpB2GtIYyMl0llHe5XLXcEvQOqZm9bX7JkT?=
 =?us-ascii?Q?5xY1rIk4z8RsRb3CcLjkQ5fRZlIGukvmnQbA+1c2Ba/xWArkORgt3vzYPdyN?=
 =?us-ascii?Q?2agNJxFWpevgcQpR8OtP1q9AXqKkFtPRFmnCaBpT3ubBy6zQu1FbhN4xLabx?=
 =?us-ascii?Q?TTPIVSzvNGZsLyJrz3x2IsHmDIupeL/LEv2joMEX3/mGgf4fvOxaL0mwg650?=
 =?us-ascii?Q?sQfqOcOCgxOLquP/Rg2+k1KYZE2gFv7jPtnTVn/tY42nfn2bpsuCAvpTCxbz?=
 =?us-ascii?Q?qEUTuFNgmuap59emvTO5NZUo9SK8WVE+jarR3+peJsV7jwya3WX/tm+OrzYj?=
 =?us-ascii?Q?NE90sxYfoGe3Q9w+8hJ2sEk8K2hoFIx7ln9NOa2uKQzY4sKdW1vRzXHN7VKr?=
 =?us-ascii?Q?OrK+tvsWZPn+iHXYSfYJQyYMW7okrLJy9GJUBX/xO9wdu9Gvmb1zpR1aZqMp?=
 =?us-ascii?Q?YV8mxLu+385I3TqHL50FGhIgugNmCFhxbXz+vVinlB/CkOmQ3EFb/L5r1neL?=
 =?us-ascii?Q?2IJX1V0jdzUjyArSrzSBnRbfUzKBufF42trV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:18:15.6788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc30f2-f99c-442d-4ba6-08dd785c1000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

This is unused so remove it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index abd32415d7343..e3c3fc160b799 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -25,7 +25,6 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
-#include "v11_structs.h"
 #include <linux/pm_runtime.h>
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
-- 
2.49.0

