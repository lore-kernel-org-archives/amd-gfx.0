Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43216CDB465
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 23:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38A310E2B9;
	Wed, 11 Oct 2023 23:37:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7431810E2B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 23:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCicTfTqigVR7DLWVYEcgsxF1oZ5hkp6TuNo/x0z1i8uQsXN8hgDcSF7Aah18SQNLuGOHDPR5GmE1YgZbeIGEw07+H1aXAl5qQXJuBSFMRcXu0NNCP6kRz/IajKbs64fYuhTEGWjcmMT8mIbHwwBGz+ju1inRAmLebH/m9mXxgk/naPTSTTQV/mAyq4IvPbB31mRhCjl/P1+HzflHknIZX2ZgDdo4itjFIR+WbQ7LAH5+AxaBNY1IVofdIo+cWc4Sudnte28rltspTbIdYW7aeUpTCT5+iJaXmb+xrSaoaxalPjanZBhSPgTr9B8pbtaWjIIr0h1zpRP6DXyktN6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r6CK/+hR3YHguGxR2lFWUFFOqlVQEFhoFcGdvAVatQ=;
 b=WMZvfi3+wvoHJwQYydeFmWUc1/gq52udT7zfvo335iYPFo+nZ0U5d/jzCekMaDqTBn7HQkps39RqFcuiUi3bWE7zaSuRIHVwzV2KehyaSLPkxK5jmhLl1G1Ra+oyUtm/NyVlYTUHQY19RnmPWL1wVed0NqxxwqtB9Vhq4KYIPkSg3FBuesD/YRu03QOPo81D7Hc+Bc/4DJAhUjbvCx8m87aze2l57PdB7aWLyfJ0R/pVmK8HKmloxi+kwuAxe/s0hPco8y+93BargN+5o7KKD4cEGt0dBJswkOnfZOXciK/18lyB5uN7McBkDfoWsME7bzP7ccGXkIE11McHt3DegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r6CK/+hR3YHguGxR2lFWUFFOqlVQEFhoFcGdvAVatQ=;
 b=AZI7zyHbsAzK9vgIn/0eMgONY5+rp805KRyzPdYH4zmffGKhORVt04NEeP/nZwgXEVRG+Xn/Qv+U9wGAkuGr05p61g7ib9FLvVDBsGRM9XE1XUd5al35dSLMIsVwa8gB0VOfCFVtWPeIg8b1n9GYNzkqmVhZ2PALG6UoKDQvfDw=
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:36:58 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::66) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44 via Frontend
 Transport; Wed, 11 Oct 2023 23:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 23:36:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 18:36:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 16:36:56 -0700
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 11 Oct 2023 18:36:51 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Find bo_va before create it when map bo into compute VM
Date: Wed, 11 Oct 2023 18:36:30 -0500
Message-ID: <20231011233630.32205-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bb8c0f-ea54-4d19-3f11-08dbcab2f573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzU4yPZB/hmFOdI9uvWAJAdNM87h3qGqT8j+o47/WeFV+8FDze4ggHZss/T16vvXYDC8OkptA/IEwlHTsd9OvtxzuV3WkcmeQr1mmSCs9fLbS/EE0oWZxvlqXmjxc6FB3GFLCUmDdubRXzG4mD/rdjXEL0K0gVZOI0f2s4/lOHUrxLOB9+YTwxKX0A8MoJ5ohY8TfG7sO9aGJZ3bIkrqqs7fSdlyW7YpFJC+Ifsrwg1UbdRkGt0hy6Ld/IUI9FKPY7aOMQxXIC5AIacoKDdGtSohCrh94SQPZh7JMeoAxmo3JH2g2aMTdZXqkx/UMwh00ITt9Cm52dj3dUoXTxt2HWQdgY4rWRVSaFhVuuRRUCnsngHkssat/HcgW3x0isWZ0EqpHjWegKGpx/rVM4kHr7FnxD3umGIVa89g+VDRr5W2Ra2S82KMm2l81xhmsG/Qi2XL6V/mQU47zYti9mNscbvasJTnN0GJl9IPtf94T3BrbN5u/2cbSXt88lOObChjhxxqq9jYr5yoTKrwt4cq4vkD+qY0q8jKu7vWyaqNu12eZ2a0tYbkQhCmjyn7tdGwHo8vBRau9bu1AtL9gEALLDtNpoOFLlkIS9JTSq4jKvxEyS6i16k8U6C9YZ4oxvJXKIZ87dl1n85DhnXuld18T7zvE/gSHIRacRufrgJD7FVB3uaZqE5VSFod1g3mws9rZrllGfncUhEMmf8pLT/koDwBHHorYYQWWr/e3ggURypXVb6qxRMMRDGpt89Eb+nxg+WYkJ4MLN9ey7MW07MUig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(1076003)(26005)(2616005)(336012)(7696005)(426003)(40460700003)(36756003)(86362001)(356005)(40480700001)(81166007)(82740400003)(2906002)(4326008)(6666004)(83380400001)(66574015)(47076005)(8676002)(478600001)(54906003)(5660300002)(8936002)(6916009)(316002)(70586007)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:36:57.2610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bb8c0f-ea54-4d19-3f11-08dbcab2f573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This is needed to correctly handle BOs imported into compute VM from gfx.
Both kfd and gfx should use same bo_va when map the Bos into same VM, otherwise
we may trigger kernel general protection when iterate mappings from bo_va.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reviewed-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
Tested-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
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

