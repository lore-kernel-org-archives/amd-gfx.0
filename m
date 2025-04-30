Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EF2C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7986C10E703;
	Wed, 30 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="daPOvyId";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A3710E703
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta0+xhQwGlrd/hbrOnwKjYE6MR3gvRNdAWAOOQlKKlIPZBtOzMJlUsR9XzvTC2bikQ/AraKeKYYwNB9Paq1ujn+9o++xs+V2ymE9SnWmXf8fbe8xay5Cb3e13SZ+gLXqRlQQ49rvht3y8UJlwGPWdZXw6zVzOYPyVBAzJ7W0TGxLcRCsOyPIz9Q/h/ht50DeyUjxlksqrJU2kgp6oEQdSwM34hHhUcchY5Pd1eWROGU1YxmjlF9LRw53IQWLu+1byT8NBe6TGmkg6wQxdnsx/UXTlaKE/4JgSohYloYpiRM0UYLhPt/8BpQhbBvyV/aXSIH0UoPX8MMDyg3j4KhsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acUB+9ZqcGCvAFoBVIZznnPhu3trlTaJHx4EEYhK5mQ=;
 b=rPnnprUcDgWkYrFgWyacVYbMqEZr4D2psennSgLPhW05RbD8wl0K2OInal5/NMsUvIctkSj7n193S0kWG3QPiG/VIZcHbLQ9/z9h1LPXMbUqM2wlBWO2mZVZXIYVz69lNmeByLKFMSqcBYIMZz+SgUM1oIScYv7Rl1QsN18vAldDUM5Rz3SYFTZ0GqjIxAK+Ewn7J1uvDcGPGfxOgMYlS8GuPYEzRWezDUItprnwRCNcA2TKeLBJf+UUCY7jg3Ecl02nU5Kw2bdO6c7cp7EWN0DHd/m1Lzqm805r+mmqxiwXgxjMfKGv17/0rUh3srlkXY+Otw94OJ5b7kyoRu79Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acUB+9ZqcGCvAFoBVIZznnPhu3trlTaJHx4EEYhK5mQ=;
 b=daPOvyIdgqT0SkwFOHs6b6WRfV47OfljirQ8lsZgRuGfiE9BU8dMjEwi9JlVJL+ed1HZevNCQoJMWEKQpwiN1zx3M8r+Yr4ZHcy6MXEkoIJFYJHL8Fojv4Sd2Xo5ZJblqjqZicIH0pEWQv5qBycX5emFinW2Zq2fKKzMDKNc7os=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 08:26:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::3d) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 08:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:09 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:08 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0
Date: Wed, 30 Apr 2025 16:25:50 +0800
Message-ID: <20250430082550.60109-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: ee862fa5-3f97-4163-17b3-08dd87c0a94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?31VKs6yq/XTUPmUcZBs/24h4q1s04UOSj43zWwyEacPozB9KQL3negrFBQCp?=
 =?us-ascii?Q?+64DLfxwLnZUfafcPea2wMm/CHYPDaTmaP5KHp49zhtd0hb07rR5nmujsE88?=
 =?us-ascii?Q?Vu3Y58Yk/V2G0MbTh06tjsnM6/dFKoMADs58/py+IraJwGlVoNN8T/Vy6XqL?=
 =?us-ascii?Q?g5QrNzJXkBjswNhHPjTTlN9ZrKgY5w6dOzAbyHo8MOH1abS9pXDfDEIpR7TM?=
 =?us-ascii?Q?aAfxaQZnQgPk3vxhSA6cN9RSsblDeeqXuRYP9qhwxCQJeixwWBAzeoL7xdeq?=
 =?us-ascii?Q?jbL2aflnoQLm4VvZH9UpMZR/lvIpxlCq0Yv4W7gV36FGdVIKBTncetcX+L2A?=
 =?us-ascii?Q?uNsGkS5Y4SQOXl24+w8e874tYP2nTocy8jlNjBlOxz7vbrIKGexgkGk46GEs?=
 =?us-ascii?Q?yhHl5+mRyxPlXatIERmoRUCiMqATzaFDpBzkOi74lP580htDEBpPvQlGBp0W?=
 =?us-ascii?Q?CqCNVVijZbYWGp/41CT7mp5zYSZHWdaYIatBEBbrN7SyF89qOlToJL9i8ggv?=
 =?us-ascii?Q?OWj3KR4qA9H9HwZ87xiClEJ0+D9ZG1SEXGIXdIoXQliLDx6cI27O+0+K9cGN?=
 =?us-ascii?Q?rLKgtYc9jQBuYlVhWjHma2Pf/EZxa57HF/jLV5nurZoxY1A4TO+d0io+OGt+?=
 =?us-ascii?Q?q1MEBXc8L/RQhEZ1nrsZkgF1yThOWS6xUP5Dp+o7NUySL+yk+kpIenS5mvQF?=
 =?us-ascii?Q?UqHpvZ75xv9h/PH/wacWtc7vRDhAcKnWEYGPT+RHFfUTOJ5PBaYZzaJru4Fz?=
 =?us-ascii?Q?1HKzEZ9OwZgKGHfbA1aW/Lo6YCt9m1dmJ7GvQqIJzmUbO15VKDifNwpLgjYV?=
 =?us-ascii?Q?zml1BKaZB7hwmvwyS79OwXM70g/+AEjUJKHSLMyA+EsYmLr6otBFGjuogtHj?=
 =?us-ascii?Q?hW/RklF5epAAlalJ7e1nXdiN8GrWNwipMFC5079PHccTqIyXWzMEoMS1e6Vv?=
 =?us-ascii?Q?/YuMo63aoGJdwcmapDRdU0pXDu6HkyiFC+UTLaUe1i12nq9u/Lbunkf1lzWI?=
 =?us-ascii?Q?G0JTtFtTn+GTCfreVtD2d+la2uHop4J/y7ce3QnoQeYyN9bBvOJrgSiq16bG?=
 =?us-ascii?Q?nPF9OR3JDXEQX57hVycqu1APCpoIikmVoFLzE3UxAGKINXGnbg8aPRB0NI6F?=
 =?us-ascii?Q?xwPPR9I0z4nG+WIZUSjVZpxSYtkgQzQTXOyYuhwBbQS0zmFYj8Ympb9lG81X?=
 =?us-ascii?Q?JK5x6wL8QHG+ioPLT5OnwC/RGEQPEfY4abQ8YZKhpvW6c1HwZT6W0Kvg7rMh?=
 =?us-ascii?Q?ZTmZ78Pg8v7NwNVdqjb/xg/ys4VAJpCDgwdMo0s8ZNGJf7P/hUrPRAkGLZ8r?=
 =?us-ascii?Q?SYxRqFMPMK7xvClsA3PjNUTpObBYJmFj0XUFFX9llm/VAKRssNZSgwUGHkGd?=
 =?us-ascii?Q?L4B0OIaTjkSZz+i0p5O4o2SmpqzoHypZqsXPw+fc1xG0Rd+/Dqbo3kdiVw0x?=
 =?us-ascii?Q?PX6PfUdRMsfOYN2rjPyNbi5WVBUD5wRDoAel18MLRxxDs9JRDp6VBFJoRr4U?=
 =?us-ascii?Q?MZBmfaT+PsAB5kJqrnc893nATMizdOm8rjqf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:09.9806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee862fa5-3f97-4163-17b3-08dd87c0a94e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Set vram type and vendor so we can take different actions per the type.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 464015fc2012..ac21197bf0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,6 +64,7 @@
 
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "atom.h"
 
 /* add these here since we already include dce12 headers and these are for DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
@@ -2075,6 +2076,11 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 {
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
 	adev->gmc.vram_width = 128 * 64;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+		adev->gmc.vram_vendor = SAMSUNG;
+	}
 }
 
 static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
-- 
2.34.1

