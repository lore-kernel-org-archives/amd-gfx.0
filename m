Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BBFC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68C110EAC9;
	Wed, 21 May 2025 15:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgTGXbUR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF7210EAC8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c01DNO60MekOJCNTmIWXhNqC/M9k68BGJX5YsMavWgphppafShylLNten9JnIjKE0k+H4pGGRWCjlQ3zhv5DHfZjChN4fXEzLGD4Y06hIg2ZHbms0DndFU3x0SazySWVmgL6rRMMqn6DssC2TpS0qr15RzWfhdFKCnLjLva+lNJoU1C4zAI5UbwO95PJunTvm95HUFboUNCfpZb7g/83W2BDaKpo8RoFVsv3Ff3S4k1BrLiSnOOq7gDACrkNrdh8Zc5zbt7QupJzJeVbm/1qvc+mlA/B51LZR7TGOIMWSD+mxFSYqsbEVOhH5Js550qoxMjaXWe1eCfFh/iixPZovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgmHfdAjSetqp+Jt6NaaWJMW4dgUjUz7sdELCeTLna0=;
 b=GZ/cvlVHzjTO2mm4+YFd/5tFqN+3Q3A7KlQMJ+EuYC625o8uXdTBY7OgztpM11pIVUPRfpLdlAGYuCfKSaI/WF7cPHMtLM+q61tUyFdlnjv3Xwt2Kxdk7939kvMBYqJ8yT2ZU4r8DSlzljVKp+xccwy1NFRZdXs/BsVhnUhZlACc8qT6heEgkYCY+6qqrySoZzKXrS2t8XYleGZrSlLvTM+s+rWTrViTDnJ1xDq18REUqB3EsrHfUoFsxz0CxyGLSxMXHTgLdP9MNTqWVBIaC5JtwdAZXlGX9lzgJbyqiJCTX8NM9wLdZxrH0jd85mo3gF7SCEEO2J5I8G6d06PJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgmHfdAjSetqp+Jt6NaaWJMW4dgUjUz7sdELCeTLna0=;
 b=QgTGXbURaw2EBZfiUjzHXODoDT3Gks51v00bCUsxcclq2LVDc5NLnaTf/e1+NzjAkg3/Ecu7F7VHILv9G2NqQtvoKgJj1uZsegaHpZ+vRXu6xsqmR3QIbJmmYiLu76IGm1OwOoI4JeJaIMLNjkwkVjGXDr/XPMf+QvPLszQZ7gg=
Received: from PH8PR07CA0048.namprd07.prod.outlook.com (2603:10b6:510:2cf::19)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.31; Wed, 21 May 2025 15:29:50 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::70) by PH8PR07CA0048.outlook.office365.com
 (2603:10b6:510:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 15:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/gfx10: adjust ring reset sequences
Date: Wed, 21 May 2025 11:29:23 -0400
Message-ID: <20250521152923.401945-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1a7be9-ea43-4c47-f1a8-08dd987c5376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5BJqjLtcK32Owno5PROLjGX2NTijtf2lQ/HzxcfdyDSMsxfGXrOABX4PWjVu?=
 =?us-ascii?Q?KNr5E266C/oN9DNG42+MDrCa++14YzvHtFVC98FzjfqRB3GcHrT6IXELl4A6?=
 =?us-ascii?Q?HoA3HrPYFcbrqampMt6TNE8cIvnCjMBHjFPEb1p5A46jIhRnweiVODvZBLhB?=
 =?us-ascii?Q?AjW/FlEqlscie5aauJLWpBaqPsOD/BrA0QU0V7i5D8v9bzNWDMdecTs/BLEE?=
 =?us-ascii?Q?uHp22Rl8d8eMDXC3dHGs9ioCE7kbWbUTlecpUx41AA5aMaX7/E79tnNlYIQI?=
 =?us-ascii?Q?Cr6nA6U5Vdkcej1fX0Cum7+fuWG+KulOg/I7i1If+VyfDaS6EfUfdza5aVCX?=
 =?us-ascii?Q?JY4rExEX89T5VcmU2CA/FCdyWZtONvR1AQcRKRalyCjoxvRaeQH7Pv+jSVLG?=
 =?us-ascii?Q?fQxms+DUOYLTO7y2F/0uL3QQUpcXnwcVMhg8tlANWvx8C1iuMDtZhMuWanSk?=
 =?us-ascii?Q?IpeZQp0ExNbn7/4YlHkUi3veqbhfS6u1oUdf3Yzp2uU7JCmYBVyhflwRPGIc?=
 =?us-ascii?Q?1KxSgBEBjt7A3l/8ZmXnzixg6G9CG7TBPA6rsJXIU4B1hkwMRZgywSBc8a1N?=
 =?us-ascii?Q?WuIej/anMUsGSZTSUat0WYtMUDuSArKERd7B+0zQ0QLXuOrTP4gU4Dn+3r0L?=
 =?us-ascii?Q?ScMy44s0UZV5WiS6fVGhH3RxWR4PaxSEtnvKqJEj/5RdntFH9/9LVNSQzn8d?=
 =?us-ascii?Q?HZ0HNmMv2k26gtNfuISZBsS4gSgwpnk1dsGXrfn/ssyr3VYjnXdwfXbmwIiC?=
 =?us-ascii?Q?AvsVOEli0G2V+mA0GAjaOQdrekjCcOKRnrtDUxe1v5lVV7QvycGu3Lk7yPYx?=
 =?us-ascii?Q?gvcoq9N1CUBxZNjtsz+jqZ+8YtLU2zvGaLMlwQQRZzheS3sn6M/SxunNDUpn?=
 =?us-ascii?Q?igE3/ij4o0n/55YSLrwRK0Hf+OaZ0Nl2w2eGsFUXJLbbtCxkYCcNO7xFWv1b?=
 =?us-ascii?Q?DYjJVeRNp6hmil5Ib/mTy5ZzVbnD3sIR5KG5DBfDnxLtonzGxeIZtt85x5bh?=
 =?us-ascii?Q?Ki/aE9xX+k73Y+nCvdCUM09jGddWigPPyvYTBqJqFQx67OT4B9H9gxpkPGd7?=
 =?us-ascii?Q?nZwD5aJRC1I4gLqm+rBby/4vFM7S6pf9wdfP3txH2oZwYTWV4epmISLtYF40?=
 =?us-ascii?Q?xFJTxqAuaSTAV4t3ouE3oPLVQMyGyp5o6ZlCu6CkK9KrsY27TVcJJZ6kLL10?=
 =?us-ascii?Q?/XfcWiDgooepzjIugRliE0lEqxE7ftu1LRhU0YBE5Gvlq341FoMd2nSsSZfx?=
 =?us-ascii?Q?s+Sov1z02oEoTrBok9LO21t3ZFqIRSE94fQdATiwJ+8J4ic+Wz2TMuWVaO/r?=
 =?us-ascii?Q?QgEApVla67VJsGt5P4WHbJK9yhog90vq3qu8IKnUJYNTsYFqmaGKjV189647?=
 =?us-ascii?Q?UtXCory0bBJXeM4WffMXGVywEdEcyG1/INkUsQujBg4XWOn/9Z41Sr+Ld+j4?=
 =?us-ascii?Q?TlE25/SJnptbAxaGKjfFfP2J3R1KBGhtKmAiZk+mEuEuhpk1ATuhu0eUTzax?=
 =?us-ascii?Q?3nlARMATeHzNW97GQNY7UQlQvYDrRz0Tc0zS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:49.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1a7be9-ea43-4c47-f1a8-08dd987c5376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

Write the fence after we reset the ring and use an IB
test to validate the reset.  This is safe since we
have enforce isolation legacy enabled by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index eb838cd946bee..b55f0d3869fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8722,6 +8722,7 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -8731,7 +8732,8 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -9584,7 +9586,13 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9656,7 +9664,13 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

