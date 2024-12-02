Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE61E69E99
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C1110E195;
	Mon,  2 Dec 2024 21:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6C7q+Ia";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD7110E872
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 21:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfOMPrF22jb8Ae2PdA5lqY1UcRHcUBeclzV4fslMw0RDQ7iKtBe+sMrko3AnkJz6rkemhLUsxEsZVeaJ++13/+cZSofmKVw277AIgOcLlIDbk9Wsvv8A93XaxFlKC3esmaF2Qr10ZYTsxjb7UHDyJWEGot73xMkG1Oe6JH2zylN1qixZrpF251nAoM2jlPLXYYz1otIffFDvy5pHi7pw0AT6TQA/8YdHGthHx80tKDfiwnrSTfyaQ1YvWYlIjZyuXfoHFCCsPYBTZ77cLGP+o8ki9ebbop7qBCuGCE/pFQP8p6oKF7Y+B31iyLDYAGM827LaIupl4y46XzdQ6BwAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz2nJ0hhSxWFn0XU4FaG85P7uePqxT3Kx5ExYnGSK8Q=;
 b=NH/HPyAx597rzXPj4CwmjvHxEiagq9137mW+wLKsbQ9eVJe0If0DThIyikO+/4rLGnO3gRqc9T5U4xOTazFwiFPgBVjH2C5zIKmKCiXB4kqSLainuuHD4YcTKjgFlE1LPQFv5/UU0OPu+BkaMZll3Lm6ndyYO75KlnoijHVYRu9VVCcv79tSbsFDOqYbBayLtPOS1X5zR/disWjixDC+CJMrN2cJ7vahetC3MST5QryPvmwXHxhxu5rPV9D9ykKcJQPOk4zqSSXrgSJyNHk/YJophwdUl7K3lf0ckV4C7E3Lr9CI1g5D+a0cwxN5qBzL3+fcb5SGkPJbD6iaHxur/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz2nJ0hhSxWFn0XU4FaG85P7uePqxT3Kx5ExYnGSK8Q=;
 b=y6C7q+IaROxSJePDq0UOP9QGsuHN04hQaQufHw8BxpoRXC0xpvH8IF18PLa3nsMAP1mUVn8tmRSwRH4pm9GxSMJXBIh5bieltDL2zISF5S7OY+Sj1vsDwWOqjZ1ENkEY4kAHuwwM5R+2Hcv3/UVx+Fo7k6auXYvhNkX+ToGrLlA=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 21:50:22 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::4f) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 21:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 21:50:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 15:50:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdkfd: udpate the cwsr area size for gfx950
Date: Mon, 2 Dec 2024 16:49:52 -0500
Message-ID: <20241202214952.1125211-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202214952.1125211-1-alexander.deucher@amd.com>
References: <20241202214952.1125211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca727e3-88b3-4a14-826c-08dd131b5254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+bPUqo9RT6UYsYSe6gJAY6edyG5wbYmmBHxLAfuSJhPNBvsvUNSeGy6xCuVQ?=
 =?us-ascii?Q?WRrUi3JPZt+aDSIBE8aKm0uzrP2K3iHEywxxz/lDxtu6aUYS2tvMdI8BgF9c?=
 =?us-ascii?Q?+eDdUDu7EQ0gfom8pD4KXZcUMmj2eUkESwI0G2VIdIMKTsiAtP08T9qJeU38?=
 =?us-ascii?Q?18qD+Dp1dJkXvgF2DU0YvXCIlIVLjJTYBOPEjkJeYeXrqr0PwuMHC7Op17B1?=
 =?us-ascii?Q?W8QnET1HfXEBVfGKSgLMOvXC53f/+KL65S/yOvB8WO/LiV6YJ6BV3iEkBV5T?=
 =?us-ascii?Q?BTJ4uwcDwKl0/rWQdZyL5E8ZxmqUslDrg+8BNAIVz03unc03N6iCriWGmT4+?=
 =?us-ascii?Q?cwYuyrzbaJFf3DnYPKe3mVYZWxjEdO1NJhJf2c6Z7Okgnqvjx0WpcTDz1gVM?=
 =?us-ascii?Q?ErSCVu+wopbyJsfR8Ytc431jyG+nKWG4aEMcSyD9tsjhvWBcE1G6y2QuiFrw?=
 =?us-ascii?Q?UECiBUddHL+KG+HYAMqeycSCHSWK/Sfew/FkOrrTd6amyHShgPcNHYehXcjd?=
 =?us-ascii?Q?BVfwjGD3SEQBYScXoFAnSlVh+B5fqZqEVEL7pNdRcHEOLQ+lxXNjs8Vyb1v7?=
 =?us-ascii?Q?J3GHf/C6wvfnI8OgkGFBv7fCysGo1K6mcHABaVKmKhYCZdWXl8Icr1Wz8HqL?=
 =?us-ascii?Q?2hbdSQNwOQl/XU2dLvkx1ldnxeeCK22sYoX5O3f1Vb+GW4X3cBSPd21YxPR7?=
 =?us-ascii?Q?gjUlznk/VOlGSMKB/3gwA5ylyza7C36VhLb6BG5M2S4dShbeLMHE0vSvjFgw?=
 =?us-ascii?Q?ff7DKluUL78CuvBZQnqcDSRLH7QReenQUBSHzhYXwMXCa/sPzHBcSYSwPfVC?=
 =?us-ascii?Q?XNIQRvUajXOXxl73Avp3W7QEpLZbz2KT8GRfEir/5JczKKlu9hAhFM9WF2kP?=
 =?us-ascii?Q?qeK+6znAJZt0cMkVY4AJaqjT2O0GhqcI8gD1IcEB6ZbFiasRULKuPS4yTDIE?=
 =?us-ascii?Q?ypeqZM7kZhuKz4qDO0NpE7v1QVXgrEoJJ/s7xMrKzW0Gzqf0SFubRi15DLeh?=
 =?us-ascii?Q?8cVCK/Ycb9SVAVOlEV8fpfq/1uWC+VpMPiZVD6m4CTf0pvbwoU2gTT3acgE4?=
 =?us-ascii?Q?/cEJ2XYPQHjHhYJdtSG5eBVoNsp2eKHBGScIlhHiK79WVNHOWqnIia+fXuu4?=
 =?us-ascii?Q?loEfBt1TTh8qAMATEetN1CkAF/WnpLVwr6KDasKpzz6OZCZJPH9I/R47zkEw?=
 =?us-ascii?Q?Jai2p+9tyDE4jFP5QEYge3JkrE9UtzDGeP683Mu2S8AU+GhZNP7u3kv6eXw0?=
 =?us-ascii?Q?QyGlGzIqRLY4MK4tNAN6BeuLqy+2v5tNmAgo98atgRJr88eZAPZPKRspAlqQ?=
 =?us-ascii?Q?lJBQjhNZQBJNXvASmdNsfP10jZQ8NnhfRzDtwxZERM71zu0uYmRy6PpEPVaj?=
 =?us-ascii?Q?yqvU/nm+82WzwIsA5fTPcpz+7ocnaBtSYoVm07Lv4BBHMrJBA65RjjaDWIjV?=
 =?us-ascii?Q?3VXVPYQ98oaZfvWtnhzxKkvIByeKMrEF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:50:22.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca727e3-88b3-4a14-826c-08dd131b5254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

From: Le Ma <le.ma@amd.com>

Update cwsr area size for gfx950 to fit the new user queue buffer validation.
The size of LDS calculation is referred from gfx950 thunk implementation.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ad29634f8b44c..ecccd7adbab4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -394,7 +394,8 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 
 	if ((gfxv / 100 * 100) == 90400 ||	/* GFX_VERSION_AQUA_VANJARAM */
 	    gfxv == 90010 ||			/* GFX_VERSION_ALDEBARAN */
-	    gfxv == 90008)			/* GFX_VERSION_ARCTURUS */
+	    gfxv == 90008 ||			/* GFX_VERSION_ARCTURUS */
+	    gfxv == 90500)
 		vgpr_size = 0x80000;
 	else if (gfxv == 110000 ||		/* GFX_VERSION_PLUM_BONITO */
 		 gfxv == 110001 ||		/* GFX_VERSION_WHEAT_NAS */
@@ -405,9 +406,10 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 	return vgpr_size;
 }
 
-#define WG_CONTEXT_DATA_SIZE_PER_CU(gfxv)	\
+#define WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props)	\
 	(kfd_get_vgpr_size_per_cu(gfxv) + SGPR_SIZE_PER_CU +\
-	 LDS_SIZE_PER_CU + HWREG_SIZE_PER_CU)
+	 (((gfxv) == 90500) ? (props->lds_size_in_kb << 10) : LDS_SIZE_PER_CU) +\
+	 HWREG_SIZE_PER_CU)
 
 #define CNTL_STACK_BYTES_PER_WAVE(gfxv)	\
 	((gfxv) >= 100100 ? 12 : 8)	/* GFX_VERSION_NAVI10*/
@@ -431,7 +433,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
 		    : cu_num * 32;
 
-	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv), PAGE_SIZE);
+	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
 	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
 	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
 			       PAGE_SIZE);
-- 
2.47.0

