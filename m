Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999A4C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 16:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F5A10EB64;
	Fri,  7 Feb 2025 16:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N72JAPL2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4798910EB64
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 16:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9Cy/8lzrDa0ztXF+Z5l+uC1FJAEKyXtmjqlPSRXKekYLkn1YyNeyxdf42FVjFIWmsPa3yWCx0pd6Iy3q+gXr9+wL6PWe8h82eq8rNWD6QR/4vE/1SHvDx6hk0BDhIdcUxiedM3WXvGhFg6LmQ1T1M0j9nDECGyqdj7Kpjnt4rU84QKFjWnF5TcSEMn4AK0KIdW+l78sL9sh2RxKp0we9lCFCiM32gbdE5vd1+hYl0IJm5/6iKyjkLkseNp4KldrLcIO6ISdEJ2f1/YjOJbdVpM8HSuPOwkSSUgy7Dc1uyeSJPK91wFgGEw/pOVOO0Eam7c/eRN7wZnKfVFGOq74Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcrPmO7NipI2ROoZE18rsY+sr1TCOdOqjO3xkiKJUbY=;
 b=abzb+tWOUJN1QxtZius+UQru2lhygbB+aw5WaeZSRfyvj3dgLPMu5BVwyErWJzOYzlljZAo2Ksbw9w1GkBFBV4uy1sESrkGbwsry4cH9HxGju9ghwiuK2Y35N+vl+/VqS9fxVgbrw9SMFr2CyxeBcAbwUTDMtx5KJW5pVUoDB84yDE1Lfvcd/8zcWWjZYZnMVXvGTyt2MWSd/uumCLbQzsbqNEqSBcJrxn17rYY5j4tvr6sxu8r0GjUdqQ3aJG971X2DavMal5vKBQz8BHsqzoFg2QaAAzsq9oE3PoujXNd0gR7Zzok3Lg6A33AQGN/i+UaB9L6uLoDwyMNqIYknVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcrPmO7NipI2ROoZE18rsY+sr1TCOdOqjO3xkiKJUbY=;
 b=N72JAPL2LDgNedKLB74SEoAE9MDkMkm3osVVTsbrMHD6s2SP0JwxO6Wpw1JUi4YDN2sK8xpst4XkVt28BXPv+IYdRMJFj8gWbzGeX/YY1qIxxVKCFWHPCu/HjmE19iaiNAj4W+ZsmwHLiK5023XPQKYKZlUluhHPZqilxvacHX0=
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 16:10:53 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::92) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 16:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 16:10:52 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 10:10:51 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
Date: Fri, 7 Feb 2025 11:10:36 -0500
Message-ID: <20250207161036.60910-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b782995-2a9b-42c2-81bb-08dd4791fed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YMj81TNZhO/ApNqLS+3YQh8GkYBetVC0LvXJdjp3lf3DrxUv9xHzB5DQJSsK?=
 =?us-ascii?Q?r6DLQZmb+2H8Ovft5B2ntNZfUlRp8OoREs1+a92T3QynhN08PEO0WYvruoWE?=
 =?us-ascii?Q?aJuIzoytfB9AbdtcNQjvb4zLKvtFk3Z/U/9qHyeX7np4lGmiknzsddL+nXGb?=
 =?us-ascii?Q?YbsjJsPcR+z0K+PQI5iG+O6KEq7R/L7VZCMGkAA/8tk0YD4BJhUjAtOOVoVi?=
 =?us-ascii?Q?RPBdPViXllNccQM0K2CZA1rVYrVfeMLQ6v22eP6tLenxmyClYJlH1d62PLeu?=
 =?us-ascii?Q?cZRs+mY1nDTsuj7ZqD2zlZGlFVGP267593FdmSuxvn7WL99m21/j1Ajom2NM?=
 =?us-ascii?Q?DfhT9V+JrVyEFT2FpP9ksPBp1asp/uTGCa9IF0u2MFfJbgJpC/btCOlFiRrs?=
 =?us-ascii?Q?eWHM4MULLtVqVqY0ofgLN86FE5uLxQf/5w4Jm1jNBZjeX9/owad+DtJ05Puv?=
 =?us-ascii?Q?17Y+/sKQgW7pMrSx4pnZ9Nr1t/lsbuaZEd2yGBmhjBWU+3BuMUyV261xa2Oc?=
 =?us-ascii?Q?GGSAXZERNEVa7pcfCo3nssFWFnVH/LQov9jw0c2ki9PWEkdCeSumUY4ekk+y?=
 =?us-ascii?Q?pVvqyMFcfYIm4CksbpAIaAu21sLLJi2PnlEkh5fPc9SRD6Q2Zjj2qbzOO2To?=
 =?us-ascii?Q?3p9YVK7vbvYJphbCJ0iWUH1KdnVlz77pEE1Ex+KKTg4Vl0njozXD5htwpipY?=
 =?us-ascii?Q?a3swjGbmMZwobdNpapgEttu0ek3IDsFfXhqt52LDjtnZx4Qn3Q7fSTb8nSBl?=
 =?us-ascii?Q?7sNsbgaZoXEtYN9wyE7eCNLx1GYK6RkruDPIiW++QRAqOLwyGxlWVeRI2EvS?=
 =?us-ascii?Q?l4pd4c8Fxycaj0CgpwCXbqdCZO06BRLa8QFUuPh0UYfAPpBLTG28IUAFAkg1?=
 =?us-ascii?Q?HxGDBxfB5B1lnudYCfjr+LVaUi5XRseGQNCM6yit3ESIrg37z0Ry3vH6muI/?=
 =?us-ascii?Q?lfzcoPSx9+BgpjsZCpeKnc6rgOfndQ+9zuoSDpMSZIzaefClCJk61KAko4cY?=
 =?us-ascii?Q?jGf7z5tQXDaoXWoFj8P7ioU9UFIGAI5G72vzUO2gAohRp9EJF3BHLOqsFqVx?=
 =?us-ascii?Q?Jj4EjluTRDMcNftjg48H5pQGlYduor31wnPWYJdxKvbt8HwDlq3ga9Ln/Pll?=
 =?us-ascii?Q?lTHj5munnqQgGgGF1DyxhmE1OBOv9xjlaoHFNjMAIrrYvffspD24+nWZmvZd?=
 =?us-ascii?Q?v5uUpszKv95qtUq3ZlecA4M1AOddbyHh25DDxSnzWYssi92e43ekZXfSyr0i?=
 =?us-ascii?Q?nt1UidYzZHLq7++DOZZjfvyKwDyYAcsKFRju51ex2dFIjUyLy+DoMkf4Jm+H?=
 =?us-ascii?Q?phM5S5G+97WQyck75U5+jp9+R3vfPDW+zINtu3Yrg71EljA3phlt8x2bulTk?=
 =?us-ascii?Q?MrQ3685H8Kmi4x2h2UeuffARqVGhcfz7nlety+hmFlKMlVMB4Dyu6jNjGT/M?=
 =?us-ascii?Q?HOS5W+WoKxUJ14/mID1LQHDwzqs1lBpRqsuG6JtWlbgELlaDfgwWQSaaKRKZ?=
 =?us-ascii?Q?JY12QCuEJR/p3E0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 16:10:52.6972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b782995-2a9b-42c2-81bb-08dd4791fed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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

In some ASICs L2 cache info may miss in kfd topology,
because the first bitmap may be empty, that means
the first cu may be inactive, so to find the first
active cu will solve the issue.

v2: Only find the first active cu in the first xcc

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4936697e6fc2..c84010427a6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1665,17 +1665,32 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				int cache_type, unsigned int cu_processor_id,
 				struct kfd_node *knode)
 {
-	unsigned int cu_sibling_map_mask;
+	unsigned int cu_sibling_map_mask = 0;
 	int first_active_cu;
 	int i, j, k, xcc, start, end;
 	int num_xcc = NUM_XCC(knode->xcc_mask);
 	struct kfd_cache_properties *pcache = NULL;
 	enum amdgpu_memory_partition mode;
 	struct amdgpu_device *adev = knode->adev;
+	bool found = false;
 
 	start = ffs(knode->xcc_mask) - 1;
 	end = start + num_xcc;
-	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
+
+	/* To find the bitmap in the first active cu in the first
+	 * xcc, it is based on the assumption that evrey xcc must
+	 * have at least one active cu.
+	 */
+	for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
+		for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
+			if (cu_info->bitmap[start][i % 4][j % 4]) {
+				cu_sibling_map_mask =
+					cu_info->bitmap[start][i % 4][j % 4];
+				found = true;
+			}
+		}
+	}
+
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
-- 
2.34.1

