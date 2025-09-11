Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB9FCAC593
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8C710E387;
	Thu, 11 Sep 2025 14:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ltnHer8/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7194B10E386
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIqOSeq+yFSLSsh25Tqtmm7MnsPX3OmXTQXIBwfcFHz0oA0jTblDyB3FGiy2rS1EaBHWCvSzATJewLW8kqaR4NES04U8Ouyn8akBzPAKd7jFHOkMuyPBPQgFp+xC1b4n+ozxkh4r7CXAlPUFOht0KA7UF4NnQme4V/GqcaO7JF78Z5B1uDzkkxRyaPfaazVNMqSYlnQ+dOyFQ2PFDCVgWUqnlRTZUBqN5xzbj9A3BjxB3ML6hNDeV7SFWUBo/nfrZmJNdWEPwMn4BLvhOiXYvN2Hi6b3RUM4fU1n4WPjTCDKUJoF7A/gnOWt7OCC/wxdvzdEjwq6aaTTDThc9ZL1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJmBq3YEOg07jNWyyxK+aFSrzKL4H0WrzQD0XFuRVI=;
 b=E5MOrVin3a9xC6bCp5Mf7vVaqQ4snBkuV+V9fTmI5EGu/aV7Wg4dnZ2UQmci6OhDVxJy6oiShOjGqUq4mFbEjOtcH+eBDR3H5FWIrKoRj/vFAmNI6eTrX/DVSxSSJJxpmbZwkB9w78F1Kb4LPd93KUVhuOoW+0GbyljdFDDjR4qQegg54L8LPYcBLomWH2kMEGXGr36lE6zLiWeKhVx3+Si1BHxysAQd4FunEdubkkjRHQcxHYCj2cm8D5Mvo1xvzeM0yHRVnJLD0lEYpE1TN5IvGOxRC4LMLL10VGOil5CqV6Ow1OPz2/u8u027kydkRqZz4HuVaAjermGXPtG67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VJmBq3YEOg07jNWyyxK+aFSrzKL4H0WrzQD0XFuRVI=;
 b=ltnHer8/3C2OFoCAax9ZGns0+9piyk6c5LKKhtI2cLpC6lmsnKvfRhPifiibADFHaippcEtubHznxzWb/miWMXK/+kciyeDR7Ou6QL8GRUwDllJTdYcngwPWoqo5uV0D63rGqkyQSYaY6sZOQyTyrfJUbCz8YDC6HI45qJkwSdo=
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Thu, 11 Sep
 2025 14:46:30 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::26) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 07:46:27 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 10:46:14 -0400
Message-ID: <20250911144614.3338953-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911144614.3338953-1-alexander.deucher@amd.com>
References: <20250911144614.3338953-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 628c4f1f-e09d-4b58-7159-08ddf141fe50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BC8lZrRCRVQxeG3k1F03zlP7/Fl4jzqECIIwKnvLdE25kZtmmB8KP4hucHJ9?=
 =?us-ascii?Q?3SZxufL4s007K0z2KJYBoN4Xofmf3EWjnidDA4Mzme5L6bzAEr1wqyCkzaOv?=
 =?us-ascii?Q?1CIqeYuT9hdm3rV9yrh/kjiNXKmhW14skzc/1ZS2xZEU0wp2CgY3iz/BuvAz?=
 =?us-ascii?Q?DQkwWEMOXUBB4MB3SJq/oBrcTXbw675qHlMrSG4tq/Z8U37nXtLMFXG4Jvxl?=
 =?us-ascii?Q?qgnKACJMUPkkOCg6DuaaceqOq7nr/dnR2wJ9qMQpvJI42xAqEDINiS2DyNS+?=
 =?us-ascii?Q?X95F/EM+8kQmfYYiZH2kOQzqBcunMv5sYqB9QOSDaeE1ZQx/xJiDVALoJS8u?=
 =?us-ascii?Q?1sQyBkJMhmKXUIV3brPXcli8BXfD7EbJ0ExeXfUvqEtusxf5qAQfgIfmJ8Cd?=
 =?us-ascii?Q?PAQ1sLMPuAElQbJ7cH+tcOW5HTmrVspeHcZLAyj7oTYrjKL0W0wSOtaHD8H2?=
 =?us-ascii?Q?mA6ZH2FBVSaAnOQ0H/AxZjQ2MG6KDzFYVOrO6rD4veJZrwaUwda5nTS9hBMY?=
 =?us-ascii?Q?UxrRPk4CqbmMghmQzTPk5EpN1FN+H/5nf6HuA2+zUzTbF6HElvDCy8C6BT30?=
 =?us-ascii?Q?NDlOXdwQIYehJbjQ7MMsePCxual87XCFXx10jYtXAnXSqohN5Dw59PidtmGP?=
 =?us-ascii?Q?e9AlQTvgXYzlY2H93DMvX0a85YIRTr1P80Y6bSCRHeO/3JBsyVoc+I2Ds15o?=
 =?us-ascii?Q?UhX86VcdnBjM/Kyr2Nn2Qv5cm9dTXodjXgKEm50rOZYJKKfL9UIh/egArKcD?=
 =?us-ascii?Q?c44HPSxzNyGMiMPbELm0nm7DAW9yffRRh4Pi7GLPHdX30JPyDf+x2GVL+eda?=
 =?us-ascii?Q?pZ9+ClpMqg/sJDo9HJZjNeOSeXzbpFRtkqq7Si+QJslFNhLY16rxbdsOljFU?=
 =?us-ascii?Q?KWiZagbC5DMQ/h8HY+ANmEDrViekLYfL189KF2WsTgLY+Zrk0osi/ZsOipJk?=
 =?us-ascii?Q?b+1IbegSW1OyHpoPD5qSH4ki5q+UuD4ahNHFsEreII/6QJNeFHkGccFGs31C?=
 =?us-ascii?Q?8B30kjFq1FF1hi/03tMt7BZ9SbhH9ewnBQj+EnfSqeJV1o0TCV/mIyQswFAD?=
 =?us-ascii?Q?G08pRdCh5gq34zUq6Ll15CcRdCm5OdgI8BV6frkSzeOGUq3iQ/J258N5g/dx?=
 =?us-ascii?Q?ASgKK0vu/h1UlCKzArT0c7kN7bAnczMU8Sdk9qoyE3eDv29CYbNY6aDqUCMZ?=
 =?us-ascii?Q?0uN/ZqufdWWNmdaswtH36ZT/2q6hX5cVmhclQOoVUXVCxh+2nA0SQgEXx3DZ?=
 =?us-ascii?Q?8BHyyMFwKSqVS0PkkEn5nPQ6e54v0N33IGb+NHPCkFNIHsTkfbI8/twtsUwV?=
 =?us-ascii?Q?Syhozfa/U3RoLGUzivRz45qpM/tzdLgTrXFRee4t8ML7uCZP+pyxSltlAXpt?=
 =?us-ascii?Q?Vq4wd1ZCBoWTxQdueRDQQT5d799f4cHCpV2ebh6yhkszDwq9fU5+3zXu5KQ+?=
 =?us-ascii?Q?ZVWQyx1tnK7sRYrXLwmXDx+0OWxPk5WUaVBiGY/t7A7rpJHTxu6A0NPvroPx?=
 =?us-ascii?Q?iQQ7elMWR7USZIMfo0OYzWytLdiNHr4mcLL8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:46:29.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628c4f1f-e09d-4b58-7159-08ddf141fe50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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

SDMA 7.0 has increased transfer limits.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 326ecc8d37d21..39e11e51b66a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1816,10 +1816,10 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 0x4000000,
 	.copy_num_dw = 8,
 	.emit_copy_buffer = sdma_v7_0_emit_copy_buffer,
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 0x4000000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
 };
-- 
2.51.0

