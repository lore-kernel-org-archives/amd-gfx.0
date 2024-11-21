Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CB6D6ED29
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED33210E93E;
	Thu, 21 Nov 2024 13:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNjhNOZ5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE91A10E93D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j28IMvw8/nwiu+TYAQXBTa0d86FTuykURDDnNkoq7DpdbTYxbkF+/sLce0CfTnh71/sPtvxgKdpMeNuGk/mxD2DPwx8JuAlbfg3zvIPxjoYpEE5kCslQDKiPZmXvBAlWiXnexZXZwdH6/Hz5LoKZmVpyJ2M9XiKgXCWIOzT7Q/6f2qE0v8Zr42QbZfv3M7hWobfNYJFikUwVJeAYiGaakAh492DW1tJd5Ihm7DCikrv7bVgcC+Ic0hGVzK7nHZa8H3RtV9H7CLAbrXQbg+DS7OzZ7iiCTFHawwUKdthUeEvazj+MObkiveEZYm+wjegErVdOEcIKsitU7Hg1aX4Aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3Y619e2AJKQD8S9f9kjYGMuLeR2mwuvaTZfgW2yLR4=;
 b=dZGIxnCyMwwXfEoVZKmAl354+nZre3dZB07KOvkEyh4OXajyP1tAalR9nfwgFnkNaBf8cGXw1a56+UqRL1n3D1SXK0h8irZp0ZDpRaDUwTxeQfzNWWZvWVQcFmNrt+Wnf9X6jiLAsj4X3cpsECNvARZtegpNgc1rtGpJCCXTX16zf3SgcqfR6VkIw+tyw91BZcx1xwU0nYFPGHqhBeRsrjtKKyJ3s9npx9RVzmiA8LV9/TMymyI/uH2aqFaTtTrJAhNttGOq0n47Cgnv2y1pmTF9REO0fwJGtqzoTSDTza3b+Tiw+c7ubc69N7/hZcrFb8jK2HspV7fyTta3FTeYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3Y619e2AJKQD8S9f9kjYGMuLeR2mwuvaTZfgW2yLR4=;
 b=CNjhNOZ5LXlRKjkgiJHBWiAP20Kj79QxKqi9mqWIBnaZUtQ3EfLPKqcZ7gaN2inbMn/96pb+S+Zm5nGLQCU1bTjmHHTS/huNFBgqylz2Kb6sdWGc2gtd9nj87TKTAtNUCTlA9ot/InEEd7lkEzFrlw8cCCPG9T9u495B5c2lfKo=
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 13:11:36 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ec) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:30 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, Somalapuram Amaranath
 <Amaranath.Somalapuram@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: enable userqueue support for GFX12
Date: Thu, 21 Nov 2024 14:10:54 +0100
Message-ID: <20241121131055.535-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: b256e3b1-b675-42e2-0367-08dd0a2e06eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cRSyvsLkz6cRyoOE+nouo26K7YjrTcmcgShAwsp+bSaqt0OBSWDrLE8CyWYB?=
 =?us-ascii?Q?sC32Mytf8eVt7+jSYbvNdt21fUoxLKx2qb2urq6FU4i6ZBcT5mP3nCaVx7YR?=
 =?us-ascii?Q?lDt3A7FdDeGGPcvoYbzOsGtMpTw5bp8WEjK2tqgnrn2RNmjSw5GeBvyWyEbs?=
 =?us-ascii?Q?pY75saoldurCkUZbYR3BI0bkRQ+dZNMnV9OXZWiyb9vLNIeXTyIJycFy0v68?=
 =?us-ascii?Q?5EnoMHGL1oyiqEPa5ziNF/RdoKXVu4OJ9bsE9iaa9sMhNz0HgUMx7sRmZYaR?=
 =?us-ascii?Q?LLf/lUnW1JQnH0YNFbfZfOZ31IRI6c0I/YACSmV8kOvxSLzg8uoHJ0gEpxxi?=
 =?us-ascii?Q?3gqcr5yv5Ijy5lkOf+UlRJubRb1nwa/6mEJRwpU9iv/MDYFeyfFQRyhRby7V?=
 =?us-ascii?Q?zV/zeLrW8eQ8pnKjIWlgFscFAo0yc+93CK2VxsuUfOYWJL1zOWvTQOzMPqWw?=
 =?us-ascii?Q?pNRdt+P/vTtcgXOZ/kSec2kU7TgvGbrCPGdvWtnlYzy6jhQVide5ETMPETwf?=
 =?us-ascii?Q?KRZLqOjmjt4jcJA0PNCMSQG7gVK9s0Q1oBCschleWHU5KnN+pPgocKA7G3Fq?=
 =?us-ascii?Q?yEgRCwQNSSRwsf9gHubTE7lZH8jhPNS3YhkNHH63F2TeAfTcchTy9D3Y1VkS?=
 =?us-ascii?Q?Iesds/nwwO7CHCI9ebiG0N3luIgfKCQp22N0tv5fs2y/IFtkXuFmcrXcGkxI?=
 =?us-ascii?Q?CuKQ4YRRkANEv/ALMR8uRSk7QeSt2+GotGqWEJCBz3ng9k4Vo5eIZdRjTPIU?=
 =?us-ascii?Q?sS6y0vtd438CVgqnynC4tP5espn5srTTEujUh8h8xhiwpKXOCj4oWd0cie65?=
 =?us-ascii?Q?j0+IBIW0bwOgPOK2g5CSlbJuIb0emSo5sDW7knSXi1pVsaPkremRauiu41NF?=
 =?us-ascii?Q?CibKdJxPoPcvRSB/TyXZKG245TtwP2wy1JrViftDfiLDmCd/nmq4F0Z4ZfF8?=
 =?us-ascii?Q?djvnOrIfjLx2BUymGirdL27RNhVJuwXXH7gkzhEjI9v+xTsG7kTLikQ4cI2W?=
 =?us-ascii?Q?D4GFu1cgNrZiUjVjPZj92KI8BU0LuKHgLLfRVcjy6xbys0bx2agrBnyYHSF+?=
 =?us-ascii?Q?KV7Gxiq2c5XATyFeQ+DVr9kc3pcpcf6KxoJEATzHgM7yeYvTeI6Y7EpULB0h?=
 =?us-ascii?Q?L7CAlakSmEC8qdxQ5nivppOw+hSWchPFKVw+WnaZO4rOGu+O+F2DHr7azTrY?=
 =?us-ascii?Q?xSGS3rwwAUKvjcgZfD3DmGgRYhfMPy4159jOyhXGMrk03F3ZehSPIXPZcDie?=
 =?us-ascii?Q?GFmb3cV2BWB58Le8whOci47DH2yS5v9Vj9g2H1e776P0dvshI667zABPz/nc?=
 =?us-ascii?Q?6RMQPbtQuLYleNkLlTce9tpV7JIFrcEMck1gcWp1I9b2sh9S2ZvNGw4azj/f?=
 =?us-ascii?Q?25+/zEBJBvIWK0LaZgaNXOIMPq99+uFGgaLPIzefUFQFq9Ls5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:35.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b256e3b1-b675-42e2-0367-08dd0a2e06eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

v2: rebase on proposed changes (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3a7532db9b8a..b151a75cf88c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -46,6 +46,7 @@
 #include "gfx_v12_0.h"
 #include "nbif_v6_3_1.h"
 #include "mes_v12_0.h"
+#include "mes_userqueue.h"
 
 #define GFX12_NUM_GFX_RINGS	1
 #define GFX12_MEC_HPD_SIZE	2048
@@ -1364,6 +1365,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+#endif
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index fc9cb989aa6b..e243223c480f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -42,6 +42,7 @@
 #include "sdma_common.h"
 #include "sdma_v7_0.h"
 #include "v12_structs.h"
+#include "mes_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
@@ -1326,6 +1327,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+#endif
+
+
 	return r;
 }
 
-- 
2.46.2

