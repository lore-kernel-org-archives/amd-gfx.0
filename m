Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EC0D374B1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B459C10EBC9;
	Fri,  5 Dec 2025 21:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqQHTvGi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8EE10EBC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXkRtMiI1ymg7oViuNOH1yS0+LZM87C3JcpfUmJZebyO/9CzO6YMEr6apwhwlDg74vA+fcUl7LpDxkk69plC9gdxoNK9fAnmdCbKJp2FALvySwm3cJ1s6oV6C/Gw1sIBVk3UZeWtsDE6RLU8prSmSgams2uGvYeC9pbBh+l0mvBsdwqN/dYbyrIYgNaUBrFzKzKSDc7l/QOjYdr/lgP+CY+dsE85LZToQ4ArgkrYNXhRflTlLvVLQyobWwvBhmDaujv+0YMZ8xPpSLBeG1aKx1YRi5wEhLdc3DXfR48VfHcMhL2Dkp/8ffEtni31PbWsG5qjPzLIgJ8f7940BGz1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dE4uCG/MGyK72cnjFt+YpqPHIf87xM6GFvL/ySiOgI=;
 b=dXUhB7+5DgFj0fxXxbRbgQoutKjq1Nw4k+FesoKQs+/CUZnUlDeKWYOh38awCu0xXDITaVQPeRP5oNS4QdgAupMV+9aKOosRroG9g4wD8jT1oS9lqlDFYMVhOlozCeK1toWAA3t70ZES285aay+xIrpdjTqSlLcL4kynzi33jZz6xW1VAV3CG9qAZMNDMZumggDuYkt2nwD5ohivJ7NQqom+IoQ7f5WOlT3dbA/oMkHNwohZRgIlsnbhU8AxmHxJGQumIT7oq87d/b+mt4+JKGireuduW1wCfhMovSECyiFm8mvKGwV/EV6+jQ3EiCTew+CZYd0Z/Ca06Dr9JBjMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dE4uCG/MGyK72cnjFt+YpqPHIf87xM6GFvL/ySiOgI=;
 b=kqQHTvGirvfMF3Drk9RD9NImfJWxS0m97JtKA6Qjl58UfRXnC9qcYo5GHGttZSJmTwJiSUbIIArw6SqWl5Jod1su5i3XtuiQe2an81Y2PJkN6grLDgGfkWhrEegkyhXJah7vkAmWg7QCKZUStCglQU2Eh/wv09Sl65ZnRLRyfgM=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 21:49:49 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::e4) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:49 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize xcp manager for soc v1_0
Date: Fri, 5 Dec 2025 16:49:25 -0500
Message-ID: <20251205214926.146844-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed7d07-1a44-4424-b471-08de344836ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPmBGgN0caEdT8msmMzsBxiipex11ImylcCTX8QgaNCgJCajpfcZuNC91oEw?=
 =?us-ascii?Q?VaA0dbbbEQRbqg5ztpJx2SXkOe/VX7gdwmv84/femUgkTRPeVP4E2syta0Q3?=
 =?us-ascii?Q?qXmrlOfc9hdD3moMRJ4G7hyFTzyalR0Tqezw0Tdaguab9eLBTkrS/SuO+/FW?=
 =?us-ascii?Q?Lt8bNJcqnyWQqvyig3O2y2tsGGT7O7w81cMjY/Zr1kOz23+FwShwL/fRGWMI?=
 =?us-ascii?Q?cyKh2Wm8Cib9tcix67S7eGRocCKOXgnpVT7eyzQYew5PK7CHCMzoNTNukjvy?=
 =?us-ascii?Q?W2yxtmseb5fN3k6+TjaWtjX/LUs06gbnDZwrREnocW99cPtvXiSsht8gQ/2t?=
 =?us-ascii?Q?9oWI5l/1hAsL4PuQ2BxCaojDTRElhS6YHVEmAbhuioCIDO0rQtvQPeVY2K9E?=
 =?us-ascii?Q?MQlUFL60pdbvk+Fieb3N4VBsA2SZFPFlM6+b7ReBNmebtiCsM8Dp1GZWGBZ+?=
 =?us-ascii?Q?89USGPJbm6sy7Gu7b7eMNGm5Q18IAZ06DtLfUqikOBsxyyIs2nbDU/NtRuSm?=
 =?us-ascii?Q?/S01iwvpjV69PeQPpWZwn99eGPPGjBVE2o5g6go/WvnSt3NXpxcC8xH7BEvU?=
 =?us-ascii?Q?5nmFDmesQD/ki6z0Yc7pXMZJsCsFwBDer7ebKC9kqSusZQN4XLUjfGQySKc9?=
 =?us-ascii?Q?xcCw2NRy7Zm7PoZGs6kaFSEZ0LgxkZy970dRx4M+zBVe+dqcMroqYq4r1g6B?=
 =?us-ascii?Q?HtpNm0YL2v3Ylp7/xh4RSgPpPyk8LRpJBbxJUC6kkXyscP7Bna/2oaG0g7Yp?=
 =?us-ascii?Q?/shg/QqTW5Agps8nhkgu9lKGAZ0ssFMRJT+9nULVLCEo+vVndABN73QWnf89?=
 =?us-ascii?Q?zenpNTT7z2TX5uvpqqYBxEwrugKEwjV8AILk1V6DpSiHExMtvE3Q92zmH14b?=
 =?us-ascii?Q?ODSTNiGLlOOFDyJj5Q9YAGiPjKBZOpog/JCkzeH7QxJFvQJsLkoi8Xu30Nke?=
 =?us-ascii?Q?7YH7OOl6Lw+6v/zUG848RFNxWeoP4Gqi8bwxsawNmjJjrcxinSqDiJlQi8PP?=
 =?us-ascii?Q?6KjfYRkjsY3KqvVZSSICzDymysdPQ5qL6eISKkS+55OMXjQJOhT38ctnX/MR?=
 =?us-ascii?Q?VfYf1+ffGh1t+EZ7RgIu6yaktsBbxLYwDzVG5lYPEzT6CQ6k6l7kVUdbOgmB?=
 =?us-ascii?Q?3q9UHRVV6nXrVOBPI1HqCaLsCtHWvrP6QWX/pT2FubmxU/CDNYqu0r9rtI8S?=
 =?us-ascii?Q?mh9lRY5XyJay5a2pj4S4KJFoaMPgCwrjVYEUEM7vW3MmcjRuI0tKj0ytjClB?=
 =?us-ascii?Q?wLq9VcJm3lPlTswGNJiLRSIlZLA0Qs2b1IgIBvr4P7vSWDkBSer9UGi8nVEZ?=
 =?us-ascii?Q?9eXIcuE7zZNd48TnGurobCAJIwHb4WnBTIKKDsDXuvLSb1YmHUO0OMJ3QnPy?=
 =?us-ascii?Q?rqsR7/i6KcOZoWa89UCHm2h6el/rfwMiyErOwL8C3Pn8UJUBm+B4c7SNNDfH?=
 =?us-ascii?Q?xT3j2wzCwEcF7tR/Yq8pAO7O72FNqIjHm0PqtGfYaArGStVWySWlhxdsZ3Pv?=
 =?us-ascii?Q?3qB5DNEhN2e1qds7PSrhdsknStbAsmS6rAdcJhDFhnituhQZZ6LCCHiBBDYG?=
 =?us-ascii?Q?+qpT2VDeQH6pqDQpkEU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:49.6296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed7d07-1a44-4424-b471-08de344836ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize xcp manager for soc v1_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 803732c11d3f7..66972b8aee505 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -747,10 +747,35 @@ struct amdgpu_xcp_mgr_funcs soc_v1_0_xcp_funcs = {
 #endif
 };
 
+static int soc_v1_0_xcp_mgr_init(struct amdgpu_device *adev)
+{
+	int ret;
+
+	if (amdgpu_sriov_vf(adev))
+		soc_v1_0_xcp_funcs.switch_partition_mode = NULL;
+
+	ret = amdgpu_xcp_mgr_init(adev, AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE,
+				  1, &soc_v1_0_xcp_funcs);
+	if (ret)
+		return ret;
+
+	amdgpu_xcp_update_supported_modes(adev->xcp_mgr);
+	/* TODO: Default memory node affinity init */
+
+	return ret;
+}
+
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 {
+	int ret;
+
+	/*TODO: init soc config */
 	adev->sdma.num_inst_per_xcc = 2;
 
+	ret = soc_v1_0_xcp_mgr_init(adev);
+	if (ret)
+		return ret;
+
 	amdgpu_ip_map_init(adev);
 
 	return 0;
-- 
2.51.1

