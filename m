Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C5ECFC5EC
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 18:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C0810E11B;
	Thu, 10 Oct 2024 18:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eb+PKxt6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4250B10E102
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 18:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tszVlReHyEw0l7G7qJ66Fi/YMZ91IDqAQ5o7mAwce+AMfXRFCR6572YthAbyT/BTa0jkS0nnhrc4mlPL6wFS5X2xknNeX+2ZX6n6Ps7D1JXzCwEzEn98KpBnzLY0o5U2W9HKIUjDr5vuF3/cux5oPcsEkG/HfaKtJz6mihkSxpTiHkqB0s54bVModrT21v0VJWVLXRKajjm2QN+GNTx9YvJzIz6i7K5lCbxzp3fvZgpHGHll864JrbzJqPeJ6DOkkX7mXcKB3NAJCyGGHsKfKGZer11kGTvpp8MVbFMG4zoZnZYRBjQ5rgbFPBEv9W2/mxZs6k35n5tQuki7MeGIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Livfs9pELN6pl6yvcGIevgNf6jlC/agY9MVo97B+sQ=;
 b=e9XoBL29BP3G/W6zU/PJq2PwRnPR6SeteI8980gpoi5i8xisOMLrcfjOqlfaDBENoRxD9W5Gu0BeIab+Li5Q816KiiFvZkeTQo1eXsT3Pjyz52Y4P3qmZj/1HXlKxxjCQweBQWDfmEPKmoiPpIMY5BTVBDqCofYUtchbcFeBoj+/CV7PksLa4FSiLm36GsgYOi9zNKtfjzyCkFNLLpl026vzhlybex32NWM5HuK/ZJMqxE0TPN0FtsZ/uUAHvJrn8D/heMztwKZsVb1YE9HYILK0v+nZCsTIea1D96kb1T7p3oNwA6iAdVSjd5xTI8tGEVXFdjvC45g3ELNVjXqs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Livfs9pELN6pl6yvcGIevgNf6jlC/agY9MVo97B+sQ=;
 b=eb+PKxt6LK1l3qgbLLPUJdxnMqWPjJ/RbWKR+XWfpa22l2grwRjy1CMokt92rBiEBJY+trH3CgHaFPI49vcu0XwRBG/JYs97hn+zjlfZxcgK0DRAXP9ag/A7aEd5Aixaabz0/p8ehhZlKIGc7DTlIQfHTUC63H5EXibheZKMXQY=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:08:37 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::57) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 18:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 18:08:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 13:08:35 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12
Date: Thu, 10 Oct 2024 20:08:06 +0200
Message-ID: <20241010180806.834-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: de47dc11-75b6-459b-f2a8-08dce9569008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a+mYTIiVbZwMYKMbEsXXQOSRTh0C4IKxbp0c8oXxlIEyfz3dSGgWN4Rtj1Ci?=
 =?us-ascii?Q?DfHBD5Lj0Ch7rD+yFUFgutcBpFrgqTJfioyYsik9KV2qeCkCwW+8BvqbbgYu?=
 =?us-ascii?Q?QXGn6pC/nQUVBWyJbM7A4wn0dZPLu0Fog6oLi36lNHGg7iR75avPyOemhX2T?=
 =?us-ascii?Q?TBS6mcW9Re51UZ5PWDW12cGXPYFY7TCtpRYOxH0wWHLWOE3drCAtQyeOrs0K?=
 =?us-ascii?Q?qM2YXGB1kBnLAHvL8H2r7/xZIGJqNnqpvdYmFQMe/E+GtmrwTfU4x9KU1mZy?=
 =?us-ascii?Q?5sEtr4USv/9UIlmcFwX3vxc8nx3vdMsvM9H7UjmMk0jGoOZOAAshp2ROEksM?=
 =?us-ascii?Q?u5eyrsuuf4t91EucVxdl37gc/pUvfhEibXinx/tC7FrPXOKEnD/bKNT3FyrW?=
 =?us-ascii?Q?G7pcDkvcF+n0GPHmvRjO8jjC/vjUrtX1DnCFbhtvYL5nyD3bcLYvr+mh1fCt?=
 =?us-ascii?Q?DRNDpOvBESa7N0p60YpRE2bWeikdQMv8XymzCZI4UL4c5FkAsymaEr93vqTj?=
 =?us-ascii?Q?iB5ly/qJkcWPXRCm1sbcTFZcI7K4ldBAUS5OtlN1l+qjJ4F2dlRgS11aSuzw?=
 =?us-ascii?Q?zVKeEKsHe10Z0KRMyr3ObTvVT5MP45T1uAjSajxkmhk2V0zGw9tHc4p7ET0u?=
 =?us-ascii?Q?sTK0a94w60hMoqP/R5BRiB3m4h47ZawvS/VMoYMPZ6YkVWpWHloVws+9jR0l?=
 =?us-ascii?Q?qAcfmAQ5vltVxh0brFeuuSpfH4bVXw5Y0xJnCHVqjK2kpc7ot1TESOBzn1rC?=
 =?us-ascii?Q?V1D6FhIvpbVuQ2pUFWOHHYO5TirLkWGmAHWxeqKtkagBTt8KWruc6iMw7RXK?=
 =?us-ascii?Q?UzoPnbSyJgzQP1L+DHNjhzvtmRlGyoo9qhIVxJrZpq4sq8g2789gPtfHnrx4?=
 =?us-ascii?Q?lbPHSgNqnlhq9hddlxGvVv4D5jYCLBuLUfklgEacO6MX9q6F4TEEXkDRLit7?=
 =?us-ascii?Q?lqOhyk6P04qQocy+R2awcUSNatELFaE04Bcj8YRm/8jNRb484LIj8d4k1GEK?=
 =?us-ascii?Q?RFY/th+KUhDi0r/P3iYak0+3yiTGpbHvuwMxmVgFdA2OJU+GM4DJ3D0jAA0X?=
 =?us-ascii?Q?XdUL5CPDtE6En3xiEkDd0vflSMybjM0MbsAZzoCDH4CarO5xBF3TjHE5u5yY?=
 =?us-ascii?Q?iTAh1E21deizzSdekWEnDj47EQjQB2dIva671U4snP6dZV7BdybdUtTdNu0Z?=
 =?us-ascii?Q?acygKsde5Mh11YuLNEoLcFG3nxVJfT/mFGKJ/ZjSQ5l034ewX2AzBIDeOt51?=
 =?us-ascii?Q?qoW1RjSeRwj1/MazSXmtp1OqMjD1SEG/N2f84vwcwoyex/h8xv9cYlaLKVs7?=
 =?us-ascii?Q?A96vnXBSxAXz1wVuKICsPpHFjEVxSM9WbAsYvap+vCbqyJHIw6XPw1faCM0l?=
 =?us-ascii?Q?g8CmKt2jNu9cdaQbsZIjIeJ8yhPu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:08:37.1170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de47dc11-75b6-459b-f2a8-08dce9569008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241
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

From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>

This patch enables Usermode queue support across GFX, Compute
and SDMA IPs on GFX12/SDMA7. It typically reuses Navi3X userqueue
IP functions to create and destroy MQDs.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..d511996c374d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include "gfx_v12_0.h"
 #include "nbif_v6_3_1.h"
 #include "mes_v12_0.h"
+#include "mes_v11_0_userqueue.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 24f24974ac1d..badcf38bb8b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -42,6 +42,7 @@
 #include "sdma_common.h"
 #include "sdma_v7_0.h"
 #include "v12_structs.h"
+#include "mes_v11_0_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
@@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
+#endif
+
+
 	return r;
 }
 
-- 
2.46.2

