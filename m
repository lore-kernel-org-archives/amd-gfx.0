Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A79C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 06:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E9C10E0EB;
	Mon, 12 Aug 2024 06:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2p2jHvzQ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863C510E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 06:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/XmjmgDggrTU3OETspKSEtbYqSupBdW/SNjWZTvmwPMUkZ2SA5VSLYr6APIh7sG6FctIDW1o1seBHJtuxgKaWWuVtdz8PV14LDM7y5hqPmPZlXp0wgQIesAhQr7qUZzVB18e/CfyAl9IxVVUcS4Zh/wplxDWoMq0fG/h1v4eAKrPQ1bnEDIlqOzSROeQgkilVXuDik9vxbPOiebQbZjWtyyFRP/N8+y7Pdd6SlVTCIFWOr6cAUl57E/Cfqpo6/1QwVilE4UYUF2MqbfgpkCifXZMSrAwq0puQp1S6jPrbw3eH2AKkisNVUGiDxEzez2QJbBozav4loyPBvxq8cQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w6PJoul5eShV7Oceh076cFtRenN7W0/CXkD2oCUDhk=;
 b=DSgGYlEQm07P0shgC0m4Rzo9QjMzdAGEokw4iRgBuCUTTlo3kcbO1Ytt2puQ1nKafxrp4nDwMywA19lZBX9EiWV4H0OviNz11en4z2ulmJZ/fEy4T7dbkD//eIMosEBcAYAsTlHuHLxFWNJHu2VERVHES+BEbtSTWyuzECPdtmunXaN6ryswqWAKhLcP4JFyVKWrk+Q7pAymfB8CyS7JxV6eVooIchecuAJTtSCGM2w3MjKKp6Q4TQshFUOANmRM8j+hc8rRkx5zuD/mTT1BIiFWUpAAA3CL9+tmV1MlKFUhw4TrDnuSe1ufY54Df2pDz7NQB3LQ4wtRU97fnQPMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w6PJoul5eShV7Oceh076cFtRenN7W0/CXkD2oCUDhk=;
 b=2p2jHvzQzShrS1ZiSj6kuekz6BNlGhbWRRikVeugNlJXev5g+XMUcbdKRroQtWwNN+npZqbqq2uM6XM+bcNwEcMyhZGOWWGiBFOue+bCUU0WAghxb+faj7JPMtdbzmhz3TUJx0R/1nXhhW3fTFyubhfIv/zCu6QG2+HvjUquZ2A=
Received: from BN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:e6::12)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 06:59:39 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::28) by BN0PR03CA0007.outlook.office365.com
 (2603:10b6:408:e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Mon, 12 Aug 2024 06:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 06:59:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 01:59:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 01:59:38 -0500
Received: from sam-builder.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 Aug 2024 01:59:37 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Date: Mon, 12 Aug 2024 14:59:28 +0800
Message-ID: <20240812065929.1842802-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a45d9d8-5e03-481f-b9b7-08dcba9c55a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UggyW63UwBHL+40m2aREzx1KAHmPz48EAoOvLNg12ZFOQKFaIVuI9/zYvSNL?=
 =?us-ascii?Q?VwCtubHD4thzR58Qm1lkCArhKBIpzrJSw1H2SgVd5Wm1HlI0RSFwnNK1PgBD?=
 =?us-ascii?Q?uZpqcHxkbLq7xzFF8KvXAOzetGbSCtW25Xael4BlXSiuRPGR0sKGa3vQD+kM?=
 =?us-ascii?Q?TozU/PMS5KqDvHSPUx1fYA1+sUaeHhE/wgNfaZqjspvXSsKDfMYw7CpgE1Ck?=
 =?us-ascii?Q?/PQYUi/lqjj6HlehU2pz7Zzam8LhyAEYuFITVSXotm5yp5/3EGSRx4A8FZeA?=
 =?us-ascii?Q?Z62m7Buhu5nmzDPdq6DDkwkL/X1eDj075YsT3Glih8MugZycrTd05bDMcipP?=
 =?us-ascii?Q?Iu2dsdpzlSvmx/AJfWlB8x//LCjC4idANVYTUjf+0bY8EtckBX1uBn1r52s8?=
 =?us-ascii?Q?psiICdiPB9DlZwZ0bpr+JyxVNs8VHcaBc7ALL/SRGmwNl02aLIEzdpYkUOOy?=
 =?us-ascii?Q?1R9GCbhpgi4HY7PBqvH1MyCQTLZUkI0UM1IXkmixqfYDZfq4CwV9O01M7QIc?=
 =?us-ascii?Q?OQe45KiW6wMq+Wwys5ipt5FkRYc9VD6BXr2GhF4PmTZeggM79va+4iq0c1l8?=
 =?us-ascii?Q?gmyFaAGfCrUxOHAVZO+F52w3pktUefXEeSX2XZotcDXI5NUa3l2/MqoKi/16?=
 =?us-ascii?Q?OqqjsQy7ix5zY/qSr2Z0WpDa9gGb5nwUZDp7EBFSw04lPppZ7AK4hegSL4rn?=
 =?us-ascii?Q?I06o9YL5t20bq8ddNSyvx3pOq4lxtvRBP/CrE02l1e66UahuCffaVCYB/gLL?=
 =?us-ascii?Q?3eWiOLCQbudFlV8WiOcmTD0RcUmt4A+hLeSYKwYyhanMoh9twLXlU0n5z5q+?=
 =?us-ascii?Q?ZvBXTQxnPeVhz2uqA6MatSEIrr0OV8WUT4p721NmQVRCKct67bJOt5NwEf9B?=
 =?us-ascii?Q?9LDI/QyF4kjHxLn9YchWhEeli1+1AG7G9FiKlG3pllKkDZcClzMsypSZzrU0?=
 =?us-ascii?Q?AvsBcqY/aOoH0ZeVMcJhx/eYyfd8kFXwxYgydv8XHhQegglSDPeK1GBTHJrQ?=
 =?us-ascii?Q?r3rHNN63SI9MQCFIvnw9U/OtVxrHCViQVQFBKKxP41IK+N/RhYx6hVVx20NV?=
 =?us-ascii?Q?7T2s6MxndU9LS4nFPO/qfYlq+FK2sk6rnI153EONGrPGwATepLFimozbENR2?=
 =?us-ascii?Q?+GkonGbrsz4Nk9ahdOmohJOd4bP4+8D5WOnMC3cwOPEjzjPxuJDa7DoV6s1z?=
 =?us-ascii?Q?I9H9yrPphbBHKUGk0T8R/SVNU2L5U1HO64+mfkKTFUZA6pigYvlzbqrh/k0W?=
 =?us-ascii?Q?2MvqUHeejim50xvP8tSrt2Mk0OSVUKqL/nqjjeHDJ5YCrGc1cXrjZvimLKmI?=
 =?us-ascii?Q?m57tVM/g2yDVPqS2vu6M7Qeju7XICQbrvX+fMKB2oszPJhCAVp0CLHCR87xH?=
 =?us-ascii?Q?9kwobPU9LkkZbq/HqMUXDNGl7427u6X9XfCOu7PQriaXhSQEf9tshezZbGWm?=
 =?us-ascii?Q?u+UMNjv7QoLYAGg3UDiQ80OngroAG0/9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 06:59:39.3535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a45d9d8-5e03-481f-b9b7-08dcba9c55a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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

Ptrace access VRAM bo will first try sdma access in
amdgpu_ttm_access_memory_sdma(), if fails, it will fallback to mmio
access.

Since ptrace only access 8 bytes at a time and
amdgpu_ttm_access_memory_sdma() only allow PAGE_SIZE bytes access,
it returns fail.
On SRIOV, mmio access will also fail as MM_INDEX/MM_DATA register write
is blocked for security reasons.

The fix is just change len check in amdgpu_ttm_access_memory_sdma() so
that len in (0, PAGE_SIZE] are allowed. This will not only fix the ptrace
test case on SRIOV, but also improve the access performance when the
access length is < PAGE_SIZE.
len > PAGE_SIZE case support is not needed as larger size will be break
into chunks of PAGE_SIZE len max in mem_rw().

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5daa05e23ddf..a6e90eada367 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1486,7 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	unsigned int num_dw;
 	int r, idx;
 
-	if (len != PAGE_SIZE)
+	if (len > PAGE_SIZE)
 		return -EINVAL;
 
 	if (!adev->mman.sdma_access_ptr)
@@ -1514,7 +1514,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 		swap(src_addr, dst_addr);
 
 	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
-				PAGE_SIZE, 0);
+				len, 0);
 
 	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
 	WARN_ON(job->ibs[0].length_dw > num_dw);
-- 
2.25.1

