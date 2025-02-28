Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB1C282D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5485E10ED34;
	Fri, 28 Feb 2025 19:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mwxeLnM";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCEE710ED30
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYroP2hxUXnl7ejc5B4hJ0EzYKLs5JkNlLDRtp6h+teDnKwZ5kO8rLaUupNvawz3WMhSDMcgrWEmB98pBF26DENBq51XZco988NK8DZqbSUosXmAIoZbonTrmGpYekaWkNhAJmI2raouTFlcmiULWA5Z+of2V8FbVjgEe9wfOnyjm+jiSOCb7gwwmloSfsEDA/tbfEnuGtUokOzmxvPEt4cwzmaB1rY7tm+gBcz+5jkP/BYXYE0pxp14APtE+FgaKGWLkT57pbvVNjIWtZ/wygOKDwPx0BAF0BKYl48TpWmdsppIE2z6OJFxF92MXqdUCGf0430ApxCvEqcBuiL9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hcaV37WuywXxumHzIlBwOfTahH+9qeVQQBsnvc8H5k=;
 b=mk/l+AMsFFKxZ2oWA/hAwi5kX1oqweT6JHWoqMVhg1YB9CeM0Wg7zx9Gg+OSrJrI1DnMzzIIw4C5P2OatjLpYNawKjGIj89GiFeY7qFzj9V1dWLI/ieQ3f96yOlVXdAlGT/Ffocux8B3IT+z6wVWazJ1xq/R8dYtQf1qC39GGK+sVi3y5JVRfohsfF+/UAt7WslgALo0BabW20KL0R1TdEOvWbu/z6Ts1y5kxv0Jiolw6q5ZovrJ5c/tG8ZkUnl1EIiaxAXowwXEkkLwo3NSrYmAeWd/gZoGBitxhaQd7cLgl6gsLHrMURjXGkXaW9Bm0JYl2M0MTMwTKE9TavBYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hcaV37WuywXxumHzIlBwOfTahH+9qeVQQBsnvc8H5k=;
 b=4mwxeLnMRedVh5JjS2bsNCy0EpG4CTO29gJq6DFNfSvuxD42vP46x06PLtOMriEQMV36NrpKuU717kfHNWjBb4nE1mtyqIXCayf0GlgyXPyI3dpHCNog9IjkDurBWTKDZYqPA6G+cIG1/kBkuOSnU+48jzg8a+gOXEdGMHINszk=
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:54:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::28) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 19:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:54:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:54:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/Kconfig: fix wording of DRM_AMDGPU_NAVI3X_USERQ
Date: Fri, 28 Feb 2025 14:54:08 -0500
Message-ID: <20250228195411.2530147-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228195411.2530147-1-alexander.deucher@amd.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a1c38b-c410-4bef-d0ba-08dd5831b3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BCIyXWb+F2FsXAMDo+EY35WxYN9B0RKXrncat0w8Jlg7y0Hzn4HBi+Q/CN5s?=
 =?us-ascii?Q?UsNaPTV+yXg5NnHvnBwDe0KfrGmFbLXDKcmX3hGB2MQThxtczqlbNChdQi++?=
 =?us-ascii?Q?g0D+7mh516frNygBfozs5EuECfZdnskPsGWnBZaA/5wmojzCnP00+WMV88Iy?=
 =?us-ascii?Q?TFqpTBXLqDHypUow2q4QstA53IdOEWVYupT9+DjhB3Fjp0GR0by9nD/ldSy7?=
 =?us-ascii?Q?O/o2Br5tTXrSb9K/yUyX4l0enS5jWeqZAzPM012tXyB1CD39pfDTKbaxCQA1?=
 =?us-ascii?Q?tgG8ZZiyCmDuUFTQHnDIrUP52YQvwV5qMr6G0/7MmaHrRwc7GdaDr81epWLs?=
 =?us-ascii?Q?5BuO7ieMxI5jRUAdN/VkEXVeP621II1r0hsa7eQS0SVNZNAEZY8g3NdT3bV9?=
 =?us-ascii?Q?3JrgZ0QupDwFLXfMj+mbd1f7wB3Zv5OXP3ywSASXYeJGleHQGz4VU+9Vs/9z?=
 =?us-ascii?Q?hgRJlG5JRtSnlyMRQt20wFOHehcbm0bm8p/0zcICkK2IC8BBBst22WZ1cEuq?=
 =?us-ascii?Q?6cK+1LW28i6pfK63P9IPtpUSveqKhP9cx4YGaktAKoYRTnm1Pbd+PPe41Y2V?=
 =?us-ascii?Q?Z6wYodJoueWCN9gL0+bfYYOcMEf9M3Vi4f5QeLvWyHTGBLRfMwFdghWsQvCs?=
 =?us-ascii?Q?WZJs5K520rwiqcl5t0RAjWuQaFh8igTK8uNkS96rG+B2U2J4OwApm+gSrXEL?=
 =?us-ascii?Q?akDoCagjbtKUriQ0o238HUTTRSt2CIiCNrLr9CsluKybl3o6Og7xg4hmozFv?=
 =?us-ascii?Q?AQiu8Mu7Ca1tO7IDTzmCW5KWZcTJvV6puG9GNFr2uNg4GYYoCsaObXEr8cf2?=
 =?us-ascii?Q?hc2Z/kWHcgSR4g2K42jTYxknqJbWeykwuPG897+4dDLvCKPxVAYsXE9TR9of?=
 =?us-ascii?Q?XuojlbPQRfnhWm3DYQ3OeJ6HrwbwoTW8gnjpFdyJMpRe/fdU+pqdOxN36v1h?=
 =?us-ascii?Q?S6GIUKnO30Da7ODnvFg8Jxni7Tb3wAzFZkDA4PqfwohkdpzdT/WKl7oUtmUm?=
 =?us-ascii?Q?HYB8aqX3eyMDbysc5EDELp0GK7qSJ6OuHZLRWV329jxJjT1xzvm9bYW2WQg2?=
 =?us-ascii?Q?ElSo/6X1at1a/XWP0ZmHdmfIKjaHhMPo0IZMmKEnk9oNBtwF0x6IKdYT4R0F?=
 =?us-ascii?Q?xcPaDof70MN2Azu4dFfvZpiO3NVwWNdz8F1pPsN3Rff9697+cvLWmXMnkgd/?=
 =?us-ascii?Q?zUK2+Px5dvFfULRyixVF/C8LV+xPFSaEZIHMz8mYYP3fiTKaGavP6qVS7nA+?=
 =?us-ascii?Q?5DK+rixIUUdnPUXwLn7egcC1IgCwOn/F1+UZLn7pz1JVNrwSozvt/CfOR3Kp?=
 =?us-ascii?Q?bgZSxHsUsft31MHKb63yMmpEzfS1vzoFOIPGxO4zmsBulFnJi3+23miv3zJG?=
 =?us-ascii?Q?u9vbDXE27I7baUBPUfDVB59ViJNF2owfVQapw58dFfsiPCMpsg8bHw7QXOma?=
 =?us-ascii?Q?fO0xoS/lnkUQzTrZQ7Q6ioWYdTy9Zg9XbqOr7xY6rW0ILbZUVDGWmVW+AdiC?=
 =?us-ascii?Q?tm42VakbiUNfs/4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:54:25.1741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a1c38b-c410-4bef-d0ba-08dd5831b3fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
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

The feature is not navi3x specific at this point.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 6703bd832e2e8..a614320114796 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -96,13 +96,13 @@ config DRM_AMDGPU_WERROR
 	  Only enable this if you are warning code for amdgpu.ko.
 
 config DRM_AMDGPU_NAVI3X_USERQ
-	bool "Enable Navi 3x gfx usermode queues"
+	bool "Enable amdgpu usermode queues"
 	depends on DRM_AMDGPU
 	depends on BROKEN
 	default n
 	help
 	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
-          workload submission. This feature is experimental and supported on Navi 3X only.
+          workload submission. This feature is experimental and supported on GFX11+.
 
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
-- 
2.48.1

