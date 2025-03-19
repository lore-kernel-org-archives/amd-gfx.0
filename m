Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5A8C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C02010E549;
	Wed, 19 Mar 2025 16:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QEfdG8Td";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C8010E549
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1uXFrctpn5GqvSbjVMx2jyoxQWGOj0GbHjmtp+9y2yS7/oTpEWK7XuvpvJ5fOQc0RHk8sJSjEOCAcgAAQyMCo8BCyLRuf40bbniVL5K/cReZ5VjmKLi5I+ydDlITnUlK4lyfkcp1OMoBaRhZQCv7Neg7IyhG8IwXqery6+VbcTcUoHst8e/Go9SrC8sSlnRMCuN5LynDehbTrJwuhrFPSUH3SGQ9AHZOhITKsWeqqKMDepTMO+PsHv/lv3i5QYtur5ZWb0fV4mIVnq65as+LGxHPF9ejjn6yFSGlyDBkVbRUNP+FfxsoqaoYAbFI1Hmu+w0SLSxJ/8ClwSdIkEOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8pqhAJ2PJJpwh3qiHnPRGhnv/8LP5zkt/SkR27lwCg=;
 b=m+nzl7nyialKlzKwm3OeG7bE4C92sBS+iZiL2QRtRlj5SD4E8H9289kynA9+QE2hVMk33XMVr7s8kMjQMlV0QMBpkKHU6oeTc+NEccTlHtH+JMx4MsD3Wfw5vZtjUNxRd84Y4vL2Hv3j3U9iYR5GiDb7YrAzn+kn5DVFmoNDbSwUtr9OP3d35z3lMJWVR56ZZPSrpXjoGrOqGuPh8VQDF+CkraaPjZkRK3/khgFXHEz+/7ifeVr93Qo/+TRcKCVuVRvajJ2J7Lf3KMLCqFMdXGYz6wWfxMloCEkt0pZuNJTXfwCWn9+vK+/vcuDRpYisBvKJ1h6ki4vTjDmzQB9HIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8pqhAJ2PJJpwh3qiHnPRGhnv/8LP5zkt/SkR27lwCg=;
 b=QEfdG8Tdsoa3CiFXd6vzfWbVXyDJ83nJJDlJiNml+dJEQyxAVX+raV0sDO7Da4u0YbxT8VSk7SnXJQsLF5+OuMRuW9zo9CXdj3leJKSjv7ZNZ0FNG5xnFwaW2wx0Uzh1+FpDgSFY3zgTtS8ZZDMdWMnXeIVgoCbFx3RNloVBrjo=
Received: from CH2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:610:54::14)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:22:44 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::80) by CH2PR11CA0004.outlook.office365.com
 (2603:10b6:610:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx9: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:23 -0400
Message-ID: <20250319162225.3775315-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bdeb64-b8c1-4fc8-f191-08dd670246f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LTTnPG2jUQOVBfgFZmVmaoGBxfjeMTxa+F8foKZfQ3RI31jyxQxREGPrAoCg?=
 =?us-ascii?Q?h90shsXt8sKk+XCOUPhOZyMtb0PXxqH8PZOTvLKMLLrOQAKULUjbiotXOppV?=
 =?us-ascii?Q?AEBz1QXPmGndR1Mm4606HpdwmeJP9BoAXBqr2gOz0sZtvtS/HuUu9sf62xXw?=
 =?us-ascii?Q?bI4tDfVhy8rLmoyzoz40m2fNXSvv60TqeXIE0aWTmSOaZP4Ij9v2simQvimg?=
 =?us-ascii?Q?F6kUqYjFtIoTKoICuXvvK9ucZhbwFqNDC8hCT9V2xh54D86qKZQoGLZAJRWd?=
 =?us-ascii?Q?M20bP0n0wLGaRXwk6D416/3NRdVjARnXDBizjcqY/6+Gxd4d5V56GNIcv4uB?=
 =?us-ascii?Q?S6xcdX5dyTAwZAq7IG1AHFyzaA0m8oS+i2Gcm42mmcVAZY9O7SEUu/KMDO0T?=
 =?us-ascii?Q?ilNE3HdmD4bvkijMgvpTzihYeYkZ3ud0J+AA7+j+y9MZuQ4jxRM74l7bGdhJ?=
 =?us-ascii?Q?MoKcCmX4Dv6I6qFb7CRq1XxAzvq8JoZ7BqfWdcEJnVse3Q6ltGEFQlGFmKwp?=
 =?us-ascii?Q?EYZrNsGMhv2uqgwjgA7CEZQi9oyyv99QqCvZtyeSOmoCeqv+D55ZeQUOM7Pd?=
 =?us-ascii?Q?BwXjkU/aYPnQUwN0pnzypmbI/jTwev5D1xsFBFMDTGY85TuLHW6tswi2kVwB?=
 =?us-ascii?Q?HDi2EddBSuUYUwh8NXbF+nCt1xeCMITrAJ7E7drcdvCWZT8dG4gPTE4Npg/2?=
 =?us-ascii?Q?44dYy4o+FNMSA6iQkhABoosVkIKZ5fgPVhG0TMMJOCjZCcnXRYpK+sYl5aqc?=
 =?us-ascii?Q?awwqe+a8dmsSJEzrL00Wf17ENH4cm/SFI8GgSuTxHjCdE0FI4/5LBu2KJXeC?=
 =?us-ascii?Q?fHcbhcEgmYPo3DJKpwoGY3VQNlJekPuHriO+cCUuHkNPuntWbo71vKmtfqq/?=
 =?us-ascii?Q?GWR5qWAaT94yCJbJfew8CQ11LE7bXlZ2dqswPAbnBABXpYwpzz95FnVBz2Fw?=
 =?us-ascii?Q?KHKIhmJrbQOE3eYiRcui4UpwF1+b2KddZb5LiPSjr79ABFNGmj9J9CB5TTNo?=
 =?us-ascii?Q?VcGYU83SmkHI1KR5BanWjMCGBOS5n8bPr6MwUykQhxdNz1AxMVpprSZKIcLy?=
 =?us-ascii?Q?JXx2UKlYN/KHzT2ahbSfQgclfClyGHtTCiltMJePpFxAxK4snnXJx62P7H6U?=
 =?us-ascii?Q?jEC9FlSzc+m2V/TU3Cw2YgHDDIISqFGj9AQ110JDRgqGpRc9uStSpxPxh0nx?=
 =?us-ascii?Q?YBe5kLnqhNASKlDMkrN2aioqc3XB7xbr+3G+THEn54j0tMB7YyGXVRqa3YlP?=
 =?us-ascii?Q?HlWICFP3+LXKKj50vpU9IFH3YafjzESASyAZ9xNIgSFqcBAgLbNAQn51y8ii?=
 =?us-ascii?Q?X6hYeuc8/ucy+IEyF+uU3/coTiLht4D9c9PG+DEFOO/+IFt3Tf1h7ewRHJmu?=
 =?us-ascii?Q?nb4UAgfhi81g5VhrUGteB/Gdu6PltF0CA63cpwS3mGrVNU5L07uxX9pDb5bc?=
 =?us-ascii?Q?TIT8zt7Ao9FfOzMlvOd8DxMcyWsnw8Gsxd8Wrp1pgmT6qi9PwKFBzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:43.3906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bdeb64-b8c1-4fc8-f191-08dd670246f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1080e9198ad9d..2d3054b305722 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1648,8 +1648,6 @@ static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

