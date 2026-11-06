Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B09606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n/ZwI/7p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE99D10E0EE;
	Fri,  6 Nov 2026 07:26:42 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2CE10E0EE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 07:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIWGX+ad5GZiK95rgT3g9HNDU1Et1QEA4R+lQNQifwkbd7PmlF5XNi/mdkHrezvnBkHz3CHI8KrKI2WdT3a+nrIenGgQmyR2z+x2VMqXnMF7XLyE51n5xmftCcW9pWW6k1fKPtYi7bkCJ1lUWnpWkpTS4vPKmgx4OwCQQhGuVjXjoJt21T9mcADkqQ4Crc/FZcPR1xbZ8Y2ytHyQLX7wHy9Kxrfyib0mFmN50WhxR4w/0GNB7x+3AofWVsrwnZaxKy/wBOZxkW0tYLbWvaEUp5cxDqhcf7nPqj/DHvyiBdIYZcZ5T+ZXNGj/HiGLr3hbc9iO7zCxJtzoSJG3l0pqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kJB6f7nW8pSUWQDFH6VMEHIX+2dzb3Px1ZdvYw98/g=;
 b=A426UbaSZ3JktMOROXaNvaw1pwaMH4A7+ZlLiPhq8DaSTwiBbjetBIh1m3JjjdGwUsErieYHum3rP7MDAcnT2CoC4wlgbX+nSbXrnAaQ3wBpgrSS9nT9pAu3aIdwYu9cvg3Dloq9LAEfkjqb2ZfMNBe59McovbeekHCUHaBwEVCx7Si885eIu/OtHPflxFWJbNlLX9CwM6+xXh/lhYDQjbjgUYAa2Y0fV5KA24/CGSQO903puSbbsC8RtNYGPplV6tnjpU3Ntlub4BhMKMvR3uEUuqao679IjxjpgI2VCnqzU9+qZlqg/N7wdTq91zZhsPOzWcjgKkd2nSh+oq8bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kJB6f7nW8pSUWQDFH6VMEHIX+2dzb3Px1ZdvYw98/g=;
 b=n/ZwI/7pmHXuAAUN1IQZt5e0B7WnA0njHVF1gfqNnhn8/4E8xdS6gSg6KtQQkAGtY5Vt1Y7XEuNeysm9UnFMfIcrsNIKJAMo345a1MT98nYQPEUzED2gEc6Bpl1Pnl5nhxKkvHEWERnlFoQIWP6peZITut41b4JYw9UibY7ZFcA=
Received: from CH0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:610:b3::35)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:26:31 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::93) by CH0PR03CA0060.outlook.office365.com
 (2603:10b6:610:b3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 07:26:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 07:26:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 01:26:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 01:26:29 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 01:26:28 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: don't create the CWSR TMA BO as a kernel BO
Date: Fri, 6 Nov 2026 15:25:57 +0800
Message-ID: <20261106072627.1449709-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c3070c-cd98-4ecb-7138-08df3bd746e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Feh/Ob1NZEAhWUG46++FTC6fgC/XFK+Xtd3TS8jVVrtQxYue03aVziK/N1H7MtVp/II50Vcw1vEAab6KGYrZ8e7gAR5dYzzmWKXLb22MLOXsh30AwVfRAqiVwSQGPnOGi+XcxFtg8voZQDTHC8xkz/EMe0dS3M/KSPqzY80gzSp0xCzeAPdkD4ojbltJWNLtZWmFKpAnslBBNzd3jTXlDgOj8q2pdkSbnj6gL8WwufHBpVbdmL1t7BLQhPmZ4Rv28ARLumvZO3g+HrYl+jxpNm4D6+Um/QxIPDQPWfL5+dmyxQ4bSqZC8VVR3aaSSeQjLRaRMD1FMcoQPXS/y22a2n0GqMMSkTE/8Fc8XBOwGI3Z9ltjctVwHOHbD0Xr/p7OJVxHROJ+akwz63FSXvbdDg1+LS7+YsnpfPN3s2/ynY2iRDsLA5i0ChcVYvuWiYf9b4mnTaIoqzUjpabaw18nsJsvPPZRynNbMEt2BMNcz79+qnRMyXxf392M8tSaYtgIxrmvzd2KjAwBzWQEd1ailmDyCf+q3P2SkUChXiIuWlzuQYxpD1TYrXwxB7/71aj1+ENOcnTfUuaTpkmLeo7+WVEZzCuEPZcJUmH3QyUr08sMEQXt1rXL3MTYSZMKpEDYmgk18DsFDzJSXEWUGpfECn2tHSmaJ9MZoqUmtDBryb6uSopmPWRaIQIdJkcEWiIq4wk0hQ634du52di5++QrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: idrK5/L12FNtlX8qnk0ZFjOZgT4YYNBSf3uPDte5NbnnQz8d3M6nNMtOXwm4HnJDVM5w5CWBFPUPCq2kuX2BIktyT+gvESL4QkQLRxTPAKKh0whJJZh3a+NLviiw7W4tuJn5Kx2erSmQGHvpcDsi12NE+2nIBk1zVbyxTzHiAboWJyNEyW84bGcWv4vWvAJYR0ySX25C9EZ4OM1ejV1eCCATpwnlVpBERAJRkzujUyDw77RsaN3HCX+KXeq5Y6m4fGokMjgK8726+uFro5uUAgkLB4LYVcUv890KzHLqtP/D/2Jc3vw9w/XJ8SaemtYT8AIOuL9kegpbBvXe2oJfJ8ycdi3Le1wDbLyZrNWqJ6MnlXEdGySs0WRhLzIq8AYGTTfspJbxiExjG8XCcb4hKd4b/eCVvtUv6zRPE4fiORkqU+kYez4ci3q7zdVtg32Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 07:26:30.2659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c3070c-cd98-4ecb-7138-08df3bd746e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_cwsr_alloc() creates the TMA BO of every opened render node with
the resv of the VM root PD and as ttm_bo_type_kernel. The VM puts kernel
BOs which share its resv on its page table lists, so the TMA BO is
treated as a page table: after a VRAM losing reset its bo_va moves to
the page tables needing an update, and amdgpu_vm_update_pdes() tries to
write its PDE. It has no parent page directory, so that fails, and fails
again on every following submission of the file.

On navi31, submitting on a render node, then amdgpu_gpu_recover and
submitting again, also with a new context:

  amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
  amdgpu 0000:03:00.0: GPU reset(1) succeeded!
  WARNING: amdgpu_vm_pt.c:664 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#3: vmreinit/2728

and every command submission fails with -EINVAL from then on.

Create the TMA BO as a device BO, a per VM BO like the other ones.
With that the submissions after the reset complete.

Fixes: 8a93aae9896b ("drm/amdgpu: Add CWSR infrastructure for user queues")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index daca0a1ac990..52ae77a08ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -433,7 +433,11 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
 		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	bp.type = ttm_bo_type_kernel;
+	/*
+	 * Not ttm_bo_type_kernel: the VM takes kernel BOs sharing its resv
+	 * for page tables.
+	 */
+	bp.type = ttm_bo_type_device;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 	bp.resv = vm->root.bo->tbo.base.resv;
 
-- 
2.50.1

