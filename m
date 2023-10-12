Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D25CCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 16:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3F410E151;
	Thu, 12 Oct 2023 16:37:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D6110E151
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 16:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXEe8TIEx8slSg3FwrNKADcsGJiAt5eQ6WLSUAovp4bMrLtvBzBl29adxnQnM3N3pLVPfxA58oMYUZoTHYRlBDFY0g7PLBo+X0IGesPRXVMJTlHKGQfamxrOggjiL5yy0fMfyLp6M7nwDMZE6TdP0AAoAHjpOU50/VE+rDjfBfjrIL0MPzxYeiz0vhF4oNCbxNRl2tzpgv99JRVe3HLoFypgmMoTiz/Pm7d9/iAw4oZCWeXKjF12TyzEJwz19Yr7TuUPpDNg6NgtwiTXLZmfKLOsmSnVKQYjeUNtpzGlaqcdnd6UC8j1WcIsZBjCed80anctgkMakMcp3ORI8+TBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9d+e/tGiz3NkKjtMqf5auYLlnBmhyaJu41s3K7uztU=;
 b=K/VhKbNO05mPHPcLIt+S3By9DCVfrMv0havbQoVaKuFOI3iNoKSM4zAkmtswu8osj+wkbeoRFwKAPOQBS0hrklvwaUQSNsxrzlTOH6VtKIH+hih7jKAY/SYUbzG9dKfCfjmLxGM+YUD3mWRNvMBLR/1LeYUo/YzH1GD8ciy87Wtag0hvnZzibJQ1tqoi8b+eM5TDNJvf6yJEE5Vm23WztnBuZnFI+7lnz0afyTM1dZhUhydg1PTb0UgB+hNUep1h/KtWx2QEs+i4Y9sHMlw+d7fFnYnn5qasYGGs3cEZNl9Ckk1rqckiku9rQ5RZumvDkxUZ37qxXep1Us+Wc1Y1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9d+e/tGiz3NkKjtMqf5auYLlnBmhyaJu41s3K7uztU=;
 b=qD+MdzhodnTB9HeGZr369MMGEuUmY1sogMAEFh8HJd8gfGTn8eAH01VZMY5BCVNgKqCyAFpiSaj/VtK92l8DswZ1TBfQ7pKZewYb3gymSNgw6d6x9/BN1tsdMqTBFqzS+5DjnzDI9Tk2+mBPxsSudNXbU5q28vBGTNxzIovUaec=
Received: from CH2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:610:60::23)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 16:37:36 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::8d) by CH2PR14CA0013.outlook.office365.com
 (2603:10b6:610:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 16:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 16:37:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 11:37:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 11:37:35 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 12 Oct 2023 11:37:29 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Correctly use bo_va->ref_count in compute VMs
Date: Thu, 12 Oct 2023 11:34:02 -0500
Message-ID: <20231012163402.24058-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0010ea4c-9cf3-4a68-b7db-08dbcb418a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tI43GapefC8ifsyZn+c9pIT2HhMrWPUvdSOBZjV0OGwSOeIdQB15hggeTRa7oScJvyWTjlqI08kFKbABprO2U9QLg/auuTk5P8wks82JzCzVhj+kyhkcoxYoG3zhjIJy5f/yiGdA37XiNyJDHmxX91bvrKWrifOVDKWNhG15z4cHxPhyGZdIeGSSTZjOH3SODsLtqPS/ktMCsCkRbF5tMald/IOwPNqzr6nKQkJkW6IPGtjA/HLsFYDNrSfUgXWUsobCfA2KWII9MPVlH1rULX65uY4aonGde2Hw3Y5fEK1jvnxt9uahD42fWUCvTtewE1YBlG9zG6bN2EbtuKvC3v6uLw7ymRh+EZHEpwlscv22umjrTsyF5unIIWH2X3rp3xyy0QGW/0F/fW9pAzRvHtXOHVSuC9z6K+FsGFmBdx5NpV1COAEIiUvbAErhidFrKxyqJl1tofKw1F3TX8bhr4FUjdTxspzJPGuYKLMxGZq3LU+OpSaoulWTZYL9F+m5XIERc4xPGea0LipdCpva+S1kOi/q+QdkIFj9yMy77M62BcyRuvQOqDelE0QO+px+t/Cy/ONgUXvlNx2UQOilz4O/MXjL51OBx6cg2HF4+2lWwvookucewgKBj2lmLKkG59vX086WQPkdSwWezN2ly4XG02FeuGdAyfBSyvaYvhKCLeIXEcLpKmO/VQUuPdVGSr7zhJsZ5MtP8B9AZ6QKtpreaNhWM6YzAKgjZ2ErZHkwTDDzAFweTzawEsc06eNSqcdpirvPDD/qCZm3CxAVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(8936002)(4326008)(40480700001)(40460700003)(2906002)(36756003)(8676002)(70586007)(2616005)(1076003)(82740400003)(26005)(356005)(7696005)(83380400001)(81166007)(6666004)(336012)(5660300002)(478600001)(426003)(54906003)(36860700001)(66574015)(70206006)(316002)(6916009)(41300700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:37:35.9345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010ea4c-9cf3-4a68-b7db-08dbcb418a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Ramesh
 Errabolu <Ramesh.Errabolu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This is needed to correctly handle BOs imported into compute VM from gfx.
Both kfd and gfx should use same bo_va and set bo_va->ref_count correctly
when map the Bos into same VM, otherwise we may trigger kernel general
protection when iterate mappings over bo_va's valids or invalids list.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Tested-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a15e59abe70a..c1ec93cc50ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -832,6 +832,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	uint64_t va = mem->va;
 	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
 	struct amdgpu_bo *bo[2] = {NULL, NULL};
+	struct amdgpu_bo_va *bo_va;
 	bool same_hive = false;
 	int i, ret;
 
@@ -919,7 +920,13 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			pr_debug("Unable to reserve BO during memory attach");
 			goto unwind;
 		}
-		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
+		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
+		if (!bo_va)
+			bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
+		else
+			++bo_va->ref_count;
+		attachment[i]->bo_va = bo_va;
+
 		amdgpu_bo_unreserve(bo[i]);
 		if (unlikely(!attachment[i]->bo_va)) {
 			ret = -ENOMEM;
@@ -943,7 +950,8 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			continue;
 		if (attachment[i]->bo_va) {
 			amdgpu_bo_reserve(bo[i], true);
-			amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
+			if (--attachment[i]->bo_va->ref_count == 0)
+				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
 			amdgpu_bo_unreserve(bo[i]);
 			list_del(&attachment[i]->list);
 		}
-- 
2.25.1

