Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15023CD98E4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C0210E767;
	Mon, 15 Jun 2026 23:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ON0u/A5F";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2527410E6DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXYWSLFMwZI2+DgxsQHMx8oynvOx2Nw6vUjS0Xl0RcqSv+G4lfUlccGi56ZYbErJAFneHW0+8QvXIJtQWIDHPmiNOY+8o29ZImMJfmdDnkhlwoyKKoGX4CmeHh5VdL+jlEl6kUtIQ0k1A4LaoQFzZfHHtVY7emVHPWYwElnGFDbyIMpYlnyXrB56NE9PFJ1wWuPIuHY1Pswk821r3k9ypN3ZJ833YbswlIlXPHFjySE1Kfx/I6IB1ACJ+Ai7p9F10/u4xEw6PA1Lr4jKi1Jx7Vx3d+tfzC+7V+gMGJ/lVUEM+mIaBsSx1TktmDY53uVwFXiXfWjMOWBf3PdGVLpG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tswllfqmqv1jBT3Y84R8XobdnSoVJRoBYdTFam2muk8=;
 b=Z8iqg+Q0YhQZnpWsx+W7wEVIoSF+fcoas140W+dbE4F6Vfw7+dMwyRhWQqqMCNbDyUInP+tLmGWzf15hjc3OGe3t5BxcELZV89mT4tGDS2QUbcVTiM7ljpbVYMWWXwyxkvmDtI56dmMQlpqx/hT/a8Ad6gXRHnW7hmbI+rezsYE801VamLkLwbkvtuLX3QGmfh9gspieawOIB8Kfox0/onKS1Szjfu0G4cXxCLBEDiVj+KVtkRHmUXvgipAvRdUa+dO0eKhrAiHtbctHis3Q+AceBcewkuweKPNJ3Hvgs4+8HVqGhzGiAiXWMt3laLGK3ZBObVik3TQb2vmZRscqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tswllfqmqv1jBT3Y84R8XobdnSoVJRoBYdTFam2muk8=;
 b=ON0u/A5Fzmq5V6BQRlOoI25QLLyRyQXMww43FeFmq8vVIiPeizAK4RnDdpZe4I6yDXey3DRlAcgTqiyxhPpD84weBzZiNpmFahBjy5MJZOHDG8zs1fj0+WE4ucjAK6TGUIzpOcTQlvkEYHnUi4kF1QnxrV4kOkMd/ceC41wOO6g=
Received: from SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) by DM4PR12MB5769.namprd12.prod.outlook.com
 (2603:10b6:8:60::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:56 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::d) by SN6PR2101CA0004.outlook.office365.com
 (2603:10b6:805:106::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:56:54 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/43] drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:07 -0400
Message-ID: <20260615235645.737189-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: eef3594c-1c97-4dbe-9b09-08decb39c778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u2wjP5gCOBw3hd6dsyvA09vTv/LCdDVJGebzM46kB1IDbRZmNtxBOm7L8m8tDMO1WUfQa1jwByaVmNVfDM86t6my1H/LlELzMse7L5GZX93mRnAlV8N4HUYE8eV2se19eHxvpfXkxfIQmxq3e+bDnDGa212rJxfGqfc7G8QzfrqKL4gAEHO7ZSOogVzXWX+dPWuPnsJJIki6QjAuo/jqIS5t5KNeY+KgoOpa0q8fUvs/+lEIrzrbp8Z1vK/KvidihHnP3eQCN1Afb4LokpIT53LkkddkuKqM265WEFZshgCahLPv2Ns9sZKhh9alawuyhD+1lQmwdXS31+bwzPu2EGgo08perPNJRI7RsiaPnUTKbMdjzsnnLgJ9f4SspQ2Qbn6t5QU2zuLYnQW/CMi+NxwVCtP25efdN8K7Vcf8he8yBNyL2A7kY+558nXVpeGA8BjDZ6yQzygpsjvhDEvtB0A5gM1TvDBwhFRjSSnLwcHU0eA0p7zIhkkyx7HGpArwE6Cq4CmC6XdB+6sAQV9DEcgCAKodHzbsMOjDCMlw/Q6YSzHeeuAFXKI6NrhwOmxIK8Das02hKZ+OXfISg48sCAMw5+ata7ImJQLPBaR/WFx3iYCtUFMXZIaFQabNUWIcx6Mx2g7rdMTH6iPOa/d2SjpzMlaJ6BynB1l0YCGzAHGOeLHzNi9WVdr7CxP0AwO6svweCW75Uiiy+xvHYaLgb78MirqbmJu7Vvyabm2Id98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kurrdYlYzb61HjRy+DEfO0Rp631hU/8iq5gvEOtSqjeoha7zqCdzegRPr9zi2/DCoPsCzqr92pJ7K1DhaL+wG+nSqQ/LbsAy6FxgsND7T715NmFsE6FQZI2AcMC+qpdD+mTg1GjxDoEY47TPgAoMJsgD7s+SW4rcUCHeaMZxqmVnHF8MuPjqnzPwAhM1Hh2G1EParrN8HANaLHf5FIy42+COaJdnRhDNUE0xoDzprZPJL1altSGpSMFoOvVbyVabhsDXmOqUralA6dFZAKOnxxszmg5CKhwtjS1Lxmgm5qGJWU/jTuS7uolaHGn6lE1S6rEsIN6j2pnpJG88Tw2wZ3CWiDNArVDVs0ogg3HP4wSKpDiZMiqCmQg6gh4cs3rrN8u5JL/+jqUiEWRf/niC3Bpx6ZZ1pJVg6LZSVNTEqlsllZ3nRgg1kdXqjd5Aj+Nn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:55.2680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef3594c-1c97-4dbe-9b09-08decb39c778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7c3e96b7766d2..ec6f3f2e934c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -546,7 +546,7 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			   WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -6024,7 +6024,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -6059,7 +6059,7 @@ static void gfx_v11_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -6092,9 +6092,9 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -6148,9 +6148,6 @@ static void gfx_v11_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-- 
2.54.0

