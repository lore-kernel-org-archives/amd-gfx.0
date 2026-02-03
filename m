Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404C1E8784A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 17:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D927A10E732;
	Tue,  3 Feb 2026 17:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j2FfYuI9";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA8B10E725
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIgxXoY5kRyB/MKEeQtqjJaOUlmSky7nWHe5hthFuo64qsPO+ikYOImxUjR3t4Xl8FjFFGKvjopRHyot+Dh+MGSffRC/aVNE5rn7WXDcCK9SVRJkwEsWlGsjLXk1L1UvcMRhpCZukV9bonVjBIaLD3wG1bvDArG3o8BsbJ5o0W949Q7RSP69mHZDGLjEj0dXPavsK69vJsiYynzmlbC5P4WYlDliW9A/I5l0LfORQZpxSVUiP8xb8IwJTu5JkoP+WVcYRvAOdOQg0aujNhKjHjurlhKhKdnCAObZLGEdOgLg3eFt2ZnWfC7cnPRtjVGXaZhr0zrDX6izX+UBmabC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1rM5fX17mjQzBST9iQ9YfVfSFx1Dv0YhsJvlY8RZJ0=;
 b=qRq7nHZazstZCfPHWJe0SH9TLdHb/qXEvve2/bbEdFNy1c8cwiO/2o9DPCCJoapvHSu3heU3zF57zmuchtYUOo9mLFyIm6g3MtvOklvQQ/79y9DAnSfzSoEBcH1AY0hmSfJ5NZs6XpO9zslaMxK/DTsF/aE6aSJaXZVeONMbrl0vrscEMTBJ7vNVUL0IyaVlWQvkkBvydaM9Aa2z036vbwnmV67SEmZTMTJm093T1BxoZFYCv/IwS3DuyNCX7BH9mPk1tATOzLTglCWCx3fcScbooULRDSYxhTOCHvOp8Z+bsG+ThXQZ+Rb84wqTzSHY2GBiAvbfAVfQk4xuomhRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1rM5fX17mjQzBST9iQ9YfVfSFx1Dv0YhsJvlY8RZJ0=;
 b=j2FfYuI9k3f2/1+pRY/NTC3fDcwwA9iMYzb7NGXuuZvzbJtsjCuYwEqi3rY8ygS2iIuLn4LZHn0GFssUgkDLngKqnl97H3RLZ/ObPZs5BmQsYO0jzLgHGmbfvGJw0kY/yyvem5OhRVuOq6NZiR6waYLNXKn6RwJpS4svVOJEWsA=
Received: from SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:05:16 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::49) by SJ0PR13CA0026.outlook.office365.com
 (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 17:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 17:05:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:16 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:15 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 09:05:15 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/sdma5: enable queue resets unconditionally
Date: Tue, 3 Feb 2026 12:05:04 -0500
Message-ID: <20260203170506.21205-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a316eb-1e36-4bdf-1067-08de63466751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gk73oDtWrYKmDoykyqa5scMXnvXHY63PolqjTwin7RWOuFvHX3d0A9aV1TR9?=
 =?us-ascii?Q?dnAN3Y42KtzMDrmuHyVJNUFIUui5J/N7Gd5ZiO8mx/rf0EDDhyfomqkGgI6t?=
 =?us-ascii?Q?/6RDfkki9yjIFPyklaF+BOd38w+MIboNFlKrxJUeZGgm5J2e4QsiOChX725b?=
 =?us-ascii?Q?WfFf+zcCulFJOaJmwR2cfRMR6b0UxDJy0iF56g3p5CxsjtFa487hEU8qGsyh?=
 =?us-ascii?Q?F579S4lSsrzjVKHEK6ZwtCByKwPS8WY9xHjQazPV6T9q3bwzr0uN9GXcHF6m?=
 =?us-ascii?Q?IOskDHbMsXRBWOrnB0T4HaFTOMZQQCdFEhhVArpU4m/ykZUnby5yi5WJgask?=
 =?us-ascii?Q?PDPMRGvR3Q2fFybkFmJoVrD14knWnazu9OvGfjzCObFbBSVwQR3R0ZrFnEp4?=
 =?us-ascii?Q?axXkfkN4E7L9tNN4mWtBkfILEf3q/Lw71NW5QJWEFIBDXLjqxi9GmXKmcLVF?=
 =?us-ascii?Q?GCVfQ3jP+JEkKDzK3s1rlIL9bqnnPC5Bfl5rWq2eINjoSUWCw0iA6czgsBXF?=
 =?us-ascii?Q?EpxxbavlxYC16tgk2tfSGzkE1WOP5FxnSmfKiaNg+hX3KPQ7I8hSgmToPd+X?=
 =?us-ascii?Q?OqhgmM1N0DGWcpxSiTvhotO/WbxDfWcTPbZomRysT2KxoWop78vm2PXp4hcs?=
 =?us-ascii?Q?T7NWjarcztkna+7H+CHKzs4qkDYRWYxVp4M5r/A8TqWom1hbfT14JxA1ZEwT?=
 =?us-ascii?Q?njBWS/hI6nmMh7ks0DLhhzCvZLudZPbehriZ72sM2miPL+y/Z/3UVyGKU03e?=
 =?us-ascii?Q?MLihtL997I5Mjzq5HvCm4WIRu2Hv0l7bUy2u7dqQZDs564U5Hw86Q4/89xkv?=
 =?us-ascii?Q?wp3r7yKKrHVXqxFxbWXuW+Dz2tAeerDo6dM6DqKZsJkPD5p+AMG/lh2L2xcC?=
 =?us-ascii?Q?R2ckAMsr4tJTbSeI2oflHHWfXqwSbOZdIK55Y9GeR+1IkoRJkApaRVz5gPe0?=
 =?us-ascii?Q?4zbd+czsNrBIUjR76ilRnGZjk1ohw6q96U7qkTVU1oWOCLJOri0ZkLoZwB+/?=
 =?us-ascii?Q?yigq6Mv2AtadA1RsOWaAyAfmCvE/wufhnNhr1dHZ8BcmCrTjGKjUgFlQPtOn?=
 =?us-ascii?Q?kF3NWvZ3v+8HbOk+iDoMdsmgXp1jL9oWJyYHwR8PRilDmgDg5gaIDxDsuxod?=
 =?us-ascii?Q?vUJtOirRYGRYb6czQTFOIpGJlqVMwhbrpTiHx1wOQt5qDQrrJg37U0psanz3?=
 =?us-ascii?Q?Z7gIOVrKolVfaXfEHoAc01UeOp1ttjmUzxrqLGA7OWC0yamCE1f8+VAzPgrx?=
 =?us-ascii?Q?RiSW/eJmMQ4+1tOZo8fVxdFaJ3qJMRxIukRN/rR5oOTS+GWmkmR1vSSLi9Oi?=
 =?us-ascii?Q?xaj2cmHoluZohtZVI7/2Kc40WaEqdWUgdnQRH22Z8ouTKNKdyiW9ESIhiEqm?=
 =?us-ascii?Q?6BXloVbCNcJsAkY1ZlT3iTIu9s/YX8rT+jhogt967BFAKl/1p0INWQ1pGEsu?=
 =?us-ascii?Q?3XQ1EB2G4cUBgAQhTEuaS5bAEVVKnB/aLug35SAqQhINIlsgdE5ms65Wq5y3?=
 =?us-ascii?Q?wLS8t8yVwgs/npjVAEQJ1/RVUs4U979FPEt4CRkgWuvfn+aySleglZ96gcXw?=
 =?us-ascii?Q?P5SyeTQZ30n+LgOOl8gjH/xPSpJJRW2Y/QiNJQei8z0agSmq/nosGao7zus0?=
 =?us-ascii?Q?VK70S6+mZXmNKT8Ld6tx/Ga6l2B2+1SRBQ6INwIkHtpdnyQ2FD1eYfhPXzgg?=
 =?us-ascii?Q?aMIAEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xrFQcpNlulST+qgam3tMRrygYZtex6VY8khMGSb/JYElWCtPX6Dv0xsU3jVqIuWAo2e1ilWC3faGg9s8/jKcZydz9dBr6IJa5dJSE5/brGWTYWij6HQANiih0sVr9sbrPuOIMHJgVWxgv3JIa40sWqbv0OOpw2apDWuHLqRsGYH/slzG8UmyqaF2k3v5RqrL3nCMJmVC721EBKxO3oMwF5Y7y1OlhdMuj9qQ65cmTFP+IXV9NqY9mpOYtXaGswwir5Bv67cwtp7eutrXbZ2fxDFNv3x1hWzqq08+ZA0WeZlcX2Ky97lizfnzqPLTm+AcFSypG3xxqjJFgGMi6y57KUUFzTgIiiLMyS1uozBMj7l2uuyk//Nww53sJSh3suast1A8yNb91IJDqrEQ4Na7GnObNKJCm4Wv5Xyo9/5lYlpqkdtv3jsYM1ZzoFNFTftf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:05:16.4648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a316eb-1e36-4bdf-1067-08de63466751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

There is no firmware version dependency.

Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index edb1e4d3f9292..afc22843f7940 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1427,18 +1427,9 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(5, 0, 0):
-	case IP_VERSION(5, 0, 2):
-	case IP_VERSION(5, 0, 5):
-		if ((adev->sdma.instance[0].fw_version >= 35) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	default:
-		break;
-	}
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
-- 
2.52.0

