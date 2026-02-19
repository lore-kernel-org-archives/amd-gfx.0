Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AD6E9A03B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5471210E6FE;
	Thu, 19 Feb 2026 16:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ub7/R1Wk";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35B410E6FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqh62A8WI0b8EPFleQp3ZVK42tbIDThR4Bo8ErSrC+aSCoEVsHvgbx3Dv4Yv2tvK2MAZMg27sAw5aILMJ44D3/YcQRlKmFgBFunBw5VP/iEI42L2MPmDlJzRDbCotHv/G3F0vWI2AdjLF2O4PnVNxaUdePCHzXkZqpdEca8ixFhXTbgVTA3qty89SYIOdVM0d4yCAYdtQe0fA5E9l4HTV1AcV2tFsGEO6E1+UMdLfcCsAjSPyuzI8ecBBB4UwgGu3JvMjQ/nriZhFq7/gLrGL4oIZPl9xoTg6fAwoYwdwR1S8uG9jrjYBTFjKAr2zPR9Q92M6j4p6hOeB01MNgu+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TpuEHMsnFUusxjB93K28fZq0jR1j8JSonad3oEaZUc=;
 b=jXNsSgcSJgPSWvcqn74wrc1va+4i6SXMye8RsIsPkQDFUowcB9ZayWMF3bO/ewquoCDsPQj39uG0Bv9b1Xt8KkHa3yv05NCg7X4cl3Iydsni0Jrs2OT4lAzxXAITtqPGH41PR3CARMmeIaKhvOzzBI+YA/IM6VNPHdGe/8m2Ld/iunUBb2Gj6Fr+FLgIvAwLAUDRva73yMPiMA05Rch0ODxPl7xcRrOPWXT9hq2HRjD3Dyw0u5y/+sRJdKZ38XfCQjXvdHZIuJK7B/YosSM3PPSMwvNLpmWp/P8X6+EdzZN7lckguQQpSfrAZpfJJTBDxzqiHUwpBrrPCogT0mARNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TpuEHMsnFUusxjB93K28fZq0jR1j8JSonad3oEaZUc=;
 b=ub7/R1WkZfcuuluB3X0JBKiphua5wM/54tCTm8wLhdASmSQ/+5lQ5pLV9hIwg9MNoqaH6P5Whlk8W3vLp4/aWLqwI964X+MTNZajY6x7PA/6gyUutD7z0JozP1iS3IpHX7dXvHYTL1709vZ5pg/FxwJOIC+Ddd/Oj9FPvnOSRvA=
Received: from BL1PR13CA0440.namprd13.prod.outlook.com (2603:10b6:208:2c3::25)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 16:02:41 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::c9) by BL1PR13CA0440.outlook.office365.com
 (2603:10b6:208:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 16:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:02:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Feb
 2026 10:02:40 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/sdma7.0: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:23 -0500
Message-ID: <20260219160224.1976043-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6754cc79-ced7-4b86-4c7c-08de6fd04f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6GckQ907XwHHqi28h5W170cdcIIvVKCRNgh9/01u6+cSmzerb62PGWv5U96N?=
 =?us-ascii?Q?qhsJWjoRcMyM+INCtkUqCwcecgjD30/btvo6gOwvAGT6a7putsNWfZbaglz7?=
 =?us-ascii?Q?L7ks+QrwsD2Azmlo4mWaS/07STH6CIZisF8kNSlJYu+iHLU+yOZjc3i5wzDq?=
 =?us-ascii?Q?kQ90JIe7d8S5HEqL5xBR2AWTqfKfJfYGyoRh9APZPjCMpvpFo0xo17WFjTqC?=
 =?us-ascii?Q?MZ+JITORDPBoMq48n1VvgSS3d4IbzJQbBmGDgLAdzeRIYoEH/Ta7aFTyX87X?=
 =?us-ascii?Q?wTs8NscL7YQLE5/QTs8x1ppUzpDEEoYomkPLP0nvWJLQIjhgzigBaa02srjl?=
 =?us-ascii?Q?m0EWDR7pOed/t2NZVEoIiqBVXRBq/46EdD5rclPk9C7GyEmHO8l5p1orKqGV?=
 =?us-ascii?Q?bH4tcaaPy/GhJ7WgiQE9/flhdwFxxTuD69WK6AWR+UABtdqwkLuVyIpZZu3D?=
 =?us-ascii?Q?1fhmAQkGU0iPIQSQBBF0INC6XzGLImsOZpy2EKIk40/3AuBdxJcpg9xYcMFk?=
 =?us-ascii?Q?20Z2GF4NMk155/UURVrd9LSYXYsZXqgPMl585Yy1jbq361UwQCB0MDzfE+gx?=
 =?us-ascii?Q?wp9tHvk1g8DdFp8i5pnGaQ/CiJOIIRGW60eifgKxKsl+eUyAqoXa2HMwXyfG?=
 =?us-ascii?Q?gL0foPj+VImDVIz/pkLbmfxr+aC7esSvaPZbde1BWDFFp4/x/oO9KggBnOVW?=
 =?us-ascii?Q?t4l4KlTn/A8sLf83x18KXMiILwWsEDXCyi1HVNJUvsw7JttcjoYzoN81Zlqo?=
 =?us-ascii?Q?F1TFb3BN3ny3b8uN+a9pgP/0DvoxiQ3lICl5wdt3kFh2f+/Xq6VSUdqsm7DS?=
 =?us-ascii?Q?IBEiP2F1Yk/VaaGPoM7GUMMIm33g7fd1mv7GDBsFy+Hqi1BQKgXa5X69DYrb?=
 =?us-ascii?Q?akQi7Jngzqiu8X/uTZIF4igm3chqoyotycGS86K7zZZaj0RYdZl200r+uRqp?=
 =?us-ascii?Q?5DI/vW7DxooxrkkAAMP6oNTUrTdvBhmxn+UFmTJhPb1/zK6MYRShYUqsWrWz?=
 =?us-ascii?Q?n94c8TN5/chWlSWUJn/sVcMLsMSRBZ4lT9hHNvjRQYvGq+4m6qsYiHl7bvXe?=
 =?us-ascii?Q?f+ydCvMzT6uPtIFErSuI0+FZX/uv6sLooI0UrUYkfZHKD0c+gurbGIHUw+M7?=
 =?us-ascii?Q?NTbtR0TV5zs6OkjjqX7SgbEUd3iprxzAKhbak63lRSldoKmYB+GGgZKCqPsB?=
 =?us-ascii?Q?C19L7aqzooZEkTYY3W0ZSidziubcOJYSQh2yMhD54xpZ7QQmIwy7t1YBgc9i?=
 =?us-ascii?Q?BdVmq+PcuWZW0981H5LCVdg8hXLY6MUVmK/ZpHmFWil6pKu6SyEWmXkc/oMK?=
 =?us-ascii?Q?7rUOviGpGiXN6h96G9el7JCdItQ2kqW5Di5zm5Ch/YRlalpUlDQ3m7Y1VgYm?=
 =?us-ascii?Q?hz4JGV69euZWjlrf6UXmYmjsAoIS80BFb4YX6TPTYagcI0wi8Kcp9OTuFqXs?=
 =?us-ascii?Q?h/7fVTHGwQjocEdMpy4PtYXga4tJMwvu8bN9waEbwjLD7hoaX3eyk9rBnCA0?=
 =?us-ascii?Q?8kwC+dyFnosZlbbkJP9tfRQ+vRki8YSZDYtZ3eCveK13njoKsTbT8cJLuXoo?=
 =?us-ascii?Q?0a5xjYVY1+G7UCSiaJOY2giqBj66sQjMrPIFmgiwVLetMpT6ogxkhiN7Flho?=
 =?us-ascii?Q?ANC9y6mGMoP2mAE6oq/PMVcAWJJF2UhB+JKa0EgC9orcVWN3sfA3qkFtZfvN?=
 =?us-ascii?Q?ef5YZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g6cs6lHFIKTlk4MBQATvkGwF+e6h25kjvQ0ajsNlStBqwVZiOc+WNgPVvvp5Jl3nmYoJdi1j1EydtKXc9Hy+uIgrGn6hSD072TC2Y6UPzkodCCVyg5+FDMGXaYDa6FGGh8u4zR+Qpswpwks4xnriaSMEav0wqMR3UGuSvPVwxoOueJoPtoVmn0LxGhRUd7xxcfwIzOAg1jBX7YyveOp7kmDXLrN9Ca9/59F/HTObbACbODKgW7BPgT5MuaahFQ7sc7HHngzPLmjZwWlrCDJyGNmm7soUrY1v0hx2VmvFd/TtE7rIrnp/mXl9zCzppq/qgGc1F/QCVFhedF8XmGAmC+NarWyyIzMGrIen2AzPFdLPjou5eNA4wr1YJ9rRFd3VbPjCBD91kcKjxoMObSO4mETCEBCvmAFp1RMhQQvCyLuECQmirXkLNmjqrQIOuy1F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:40.7556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6754cc79-ced7-4b86-4c7c-08de6fd04f54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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

v2: fix harder, use shifts to make it more obvious

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index f938be0524cd1..5679a94d0815e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1835,10 +1835,10 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
 	.emit_copy_buffer = sdma_v7_0_emit_copy_buffer,
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
 };
-- 
2.53.0

