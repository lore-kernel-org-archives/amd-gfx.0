Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5A9CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B87110E49F;
	Mon, 13 Oct 2025 16:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PHhGuXch";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4720910E49C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7BFwBLeRbrncWxmekeQG2HSR8kw5tm4g2Si+OxeIio5a3+SS1dBdmiUoCXNCYi4k0S6deln14lPBhB4wgx9l5zydZByKZ8xtYQgXDn4TNRwG4VFxd+8wEFmZzzhkk+5IMJZ90yG9rP1sC59jS1a/fg9h0vsE6NO5fZNg+05zjnSEcIYqevPsTghuSKTKiBNnfqkPA9lLn6CCgpm4KLzAEvMNZvUD8/XV48BN2xF9QDr06gBjAgeTZEZosU1D626RJkp9Gr2uRlYcWqKvYIjO7gQqbRrL2l1ypIvc2B3J3wdm7MOt9XngRQ+8MvSLPXNrPsc9LpM/C1mNR281l36bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNgCEVlI9VavxfjmiNzFaPxKwHLG9A3gMdnyIV/kjmw=;
 b=Pxma04sNYDJTQqKs6ku334jTciRoN5YjiBd5vqUr2fexyU58Ue/FvbK+FZsZ2DhIyuSs+dgo7U1YhKWIAzTJhEXXF12h2z5fjo+E6pn60zMvkMAJEPiw1/nZygLj1JccfGPb4TTuT+2eJ6dBhUyx8982rdPhnuDk82p/lqTyjhgol2iHs3UP5jgaFqFr3236OZT5s5eKUL7nbancXPMpAc6Bn0k9DHi0671MSlLIC6rymqcEzynDy4HxhnAyXEEO3KDw/DSf3kwFuVM7AW89UluLkKGIbrG32BIrKLS9hXTc8MH9Rl4inrgZ0H9YPlRqRQ+b/0y5ttYEMDfmGL8DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNgCEVlI9VavxfjmiNzFaPxKwHLG9A3gMdnyIV/kjmw=;
 b=PHhGuXchRWI6CSsVHg6+2o7iaBjS1bKkizUQHDeIm57+LrNOp6apoApqXxSZcFmyuEFCSqz1vzhOgkKayDzW8PVuA1mhAwbYekcePbHwMKBZDst66E2xaM1J2xVoPt7U5CslWztrqR1CpUxL8uzM/NGNFnBnXc6MeWi/70XTIGA=
Received: from CYXPR03CA0029.namprd03.prod.outlook.com (2603:10b6:930:d2::13)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 16:14:17 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::83) by CYXPR03CA0029.outlook.office365.com
 (2603:10b6:930:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:17 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:09 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/userq: fix SDMA and compute validation properly
Date: Mon, 13 Oct 2025 12:13:52 -0400
Message-ID: <20251013161352.1628044-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013161352.1628044-1-alexander.deucher@amd.com>
References: <20251013161352.1628044-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: d670f99c-2a2c-4fd4-b926-08de0a738f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LjyNCNOBkyN0rVoSkeEfNWh1dQBQWuHVtNCp3w1qwaV4O1onySqTt13vfgfK?=
 =?us-ascii?Q?6CGm1fNaLchj/GROQny1btbhTAJlAmd1tf/e+hbY5az+XH6aQPr0/pqCuYUF?=
 =?us-ascii?Q?/HmhoNc7octXWnwQhsT0hcRhkBDS9kHH66Tb0FMFBKsd/G5B8IFl8+pqdNgP?=
 =?us-ascii?Q?OcgyfBx//1P4FCm16IPviyoD5OA48QPO5EujYjZfntSlld9kLVcWF707ootA?=
 =?us-ascii?Q?+pY9/xQpR1u3VS4F28EC59m2jIqYAuRyULBze4gd5JA7vheNbyM2aJeMqdow?=
 =?us-ascii?Q?LaA6MRkKXEKNVjqhRh2JyFu/dXUC0WNp0yqeki1nrMc/z7Iiq1KIQXkqtCCh?=
 =?us-ascii?Q?BMY0sUS7MPPs0MrX9RG8BTz1zDfQeJaK9Tbw79HJkUHvhNwtwOrT7bcVo5PJ?=
 =?us-ascii?Q?vA00GFJbFDiFuCAA3nz3zXSi/wlI2lPjVfszSicLyjX7kxs+hKipLNkCdwtC?=
 =?us-ascii?Q?AflYGctLpyLYX8cz2dn4BpwLvK3JYqH+zniKc0eXFCi2VNzh1ILuW3FUykmF?=
 =?us-ascii?Q?oFpcaXmpR4Q2MfeTd3lNUskNtiHWMU6SwhL07R91eL/0c6lEWxsKA6+g6tiG?=
 =?us-ascii?Q?jTRDaQMgzaTtwn0pBJ6+aorRHfn93EEBUluRX4Z/sxJe5HRaidLvInHikewY?=
 =?us-ascii?Q?C1JaMJqXsM/WmF09OylsqDeb7PztVr3fk0NJJXXxRniv5jaMMXLdIz+1tLMS?=
 =?us-ascii?Q?2bVU5I/eUdAbpy9apaiZb1e9aY8Jorni4IDFBtS0vgYDQc1U2yPLRDJJiOLA?=
 =?us-ascii?Q?/HHipyMLb/EzvQPdbpu2EjuyyO16p9lEor4VE4dUMJKyKS9j7xfD2YUY6gkZ?=
 =?us-ascii?Q?mOR6SKTL1EfTOqd+FYrAKIDHXCwC3eXI49rRY6CFzkh65yhHr4Lj9Lr/55OS?=
 =?us-ascii?Q?mHRpbhC9ClSRmMX1MkxqKQzcgUtPe6CRxUVCbJml8lJLama02AIvW5JZv3wx?=
 =?us-ascii?Q?NF6KvuCZe7rXtVAh5cNuo15UtHlxxm4hdAY3h031jH2iQ87yGrRzI9OpOO4L?=
 =?us-ascii?Q?E1nl0FBT5fy+K5TmEyo3ISFlWAURHBIxCJ+HC7G11ZKFp+Wyd1nESxQw2nU1?=
 =?us-ascii?Q?+eD2plGI0rJhv4wwqCBlcC05hmbLfVCZKw53yCvEa3AFpGhR+y8ymq8JIyk8?=
 =?us-ascii?Q?DE2fdVzWnJG73oawsncsK10MGw+DtNXJWtRSA+tGErEwUKFTqseMeFwgMA21?=
 =?us-ascii?Q?olC6JMzHRCU3pNfFvZ5Pgg/H4WczpUbRswol1SK9kiJhY0tX7CSxsDElrLIU?=
 =?us-ascii?Q?fOJf+oIxEUCJh3hqcNSiGkyN6rvBb/7+Kuq+4Vf4dkgegBrSUBRoTUYtxxw9?=
 =?us-ascii?Q?wmR6mxQz0zgpl/gYWBkJZnDMKC+oMYcg/LASNMooBp3nIXF+65ZIuBEyKJXL?=
 =?us-ascii?Q?s8uG8Ra1YbYaWjxzDnb1pr27W9dK+Z/7E50OYhO44CUfGa3A3el1ttdOhFe/?=
 =?us-ascii?Q?36SgQ0+GJ4/QYLC6kvzJ0+CoK2h4xhFOt/0Ph1iTO2IWZkC0FqgLmsDLfWeC?=
 =?us-ascii?Q?PfSOWaO+BP21yg/6XECJJHF+jzbJP56Z40SaaHJIM27IIyR+QK05OBNRR6R4?=
 =?us-ascii?Q?Em0zBpPWofCkA7wi5D0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:17.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d670f99c-2a2c-4fd4-b926-08de0a738f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

The CSA and EOP buffers have different alignement requirements.
Replace the hardcoded sizes with proper queries to the IPs.

v2: verify callbacks (Prike)

Reviewed-by: Prike Liang <Prike.Liang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f5aa83ff57f35..bf6ee6697271a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -281,6 +281,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+		} else {
+			r = -EINVAL;
+			goto free_mqd;
+		}
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -296,7 +304,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
-						   2048);
+						   shadow_info.eop_size);
 		if (r)
 			goto free_mqd;
 
@@ -348,6 +356,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
+		struct amdgpu_sdma_csa_info csa;
+
+		if (adev->sdma.get_csa_info) {
+			adev->sdma.get_csa_info(adev, &csa);
+		} else {
+			r = -EINVAL;
+			goto free_mqd;
+		}
 
 		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
@@ -362,7 +378,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
-						   32);
+						   csa.size);
 		if (r)
 			goto free_mqd;
 
-- 
2.51.0

