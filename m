Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C15C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 09:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729F010E6E4;
	Tue, 14 Jun 2022 09:05:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664C010E6E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 09:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPy17HmLJ3XHnpRaBXDuGeVA2HuWKNetSgu+7+eNVwI+l7uoSHNh2AFCI4ePu0H4nv73wlqqt5ls1JqLQuc3MBdwpiGeCyN48FSdqE3MrD5qCggBSLrcdagSeVTiGaTisXI8T/KYlBskatyP2R8Koh8KAOo4tbhYGn6FkczQu0ffY1nH6dHlFPJBDimHPXBNYDYNPZZQrWpoBeoPiDALTdZtxFIp+O01PCNjGdzjHFcKRmav7qS6PyYvqC2hckvVJQntfBUYTg7kd/UnS1dDw/O/WdxdzJA0r0hVN9AK5Mi4JJpOzYjXFamrvPTRQNHT/QH9Whv6Mjui713p/aF+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqn5K5k+sBd1XMUt2kpMWvqkKkt0SRVVOa/TjV4tUKo=;
 b=NDSxmEJoI1m2110llnH3tqz3le6/ctNgQoIHt9j3kqltcZp4aG11a1z3OZBucS/oJpmXteyqhOh1Cq8yelUGRI1+SM/ukuS5ttWJrbXBITV4Kgqn2KxHsuF1H8N4TqaZjIyjpnPIKibmUVFqTPPKEcogAOe50pgtZ3LrtNP+DcTaGlkzh+ipmlnivKSol9LgktWh/Xb0W5nx7qNGPKxmjM3E8GAwryq1YdFF81R7TU4irS3QY552YaX3RzjEeqdQC3d5a7ZOMi9KweYV7jESlXSYCpg1ULTg5iuutOnHvJMgjDS3PITY3zI91QeNwpC7zTQoevWL+6crOsW4a2l1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqn5K5k+sBd1XMUt2kpMWvqkKkt0SRVVOa/TjV4tUKo=;
 b=wvlyGUNNKwuj51IY+EL0WsvdQVAdxdZAc25owrEDVys2+jjXG2cGIs0aI3VFrTkqpsuJiMokBMsc/LArSLwXBBxSawAYQgLHf5mHoWgGJ7p7Vde2AI+qpTLj0VeGYorEeZMzrWzlQ8zkt1eyDZdyp436wgQRMcWipJJlAJDQwJ0=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 09:05:17 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::45) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19 via Frontend
 Transport; Tue, 14 Jun 2022 09:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 09:05:17 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 04:05:12 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: simplify vm_validate_pt_pd_bos
Date: Tue, 14 Jun 2022 17:03:07 +0800
Message-ID: <20220614090307.999988-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 378db498-300a-421c-6f7a-08da4de50016
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB370763A1B08A29D6744E8CAAFBAA9@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWFd4ndIakJkZZhAJm2v34U86cTU/K60GRCTaoccXtgVCvoyWH+TcTVJbd35GsqIsSahpxhUElGtSdz7OtjgTqTQBJVx+yQ+emdYEnv+2sxJDJS5SzmmlOeP5/h8f9f3wxKiVbqP6gud/fRPMf73sqZhnmPXb9ue6Ka0Naq6okg/Sue4kN8dx0KytysJXE68im55DMWU7YVd9284MMRFbhnqvHURWglbEOslkgf2sE5mwkwZfLGkPDaBewudkVeIBwizFxVxh3jrHlbjlYQuo1N1wd9dw5ETk2aQHASqaEi9qMzFovXHiQYDSGBygPN8cJcnFcLAg0k9wlIgsIaioOSdG8WPRnKVVeMql/F0keW7i+Hwmao3yMa2kMwv3fnNPeFue0F/5ifd/k2umwZrkBEh9dKRCMEdcys+Y7Z7j9G3GROy40NcPUGq9al/fUn+Jkthyp2tv8zJhcUp6rQE1ui4xqmv20h8Ai28PX4K6ZNSpTJTMVbDR8mYzyk0JDupJg1jG7eIxNoO+NrEF5R1HZjssmc7u9EaVoAuiOsY9+ikq5NK7R8JCkD/JKWqPNVQe3tD0BEVZv/qlJ0W4KesfyNwTfVzAZc6+OJ9Y5EQ8A6fHE1/y7IoYHR3DmOBGD8a5JYWfWACRd9D/TW3kzgCsjWqrzsnszRXUt5dTkJU/v/2nYCKLbxIzg9tT2iPtL0I6dN/es9IcvkBIxo7WZVwRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(47076005)(336012)(426003)(26005)(40460700003)(5660300002)(8936002)(1076003)(16526019)(186003)(2616005)(86362001)(4326008)(316002)(356005)(36756003)(8676002)(54906003)(6916009)(70206006)(70586007)(2906002)(7696005)(81166007)(6666004)(83380400001)(82310400005)(36860700001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 09:05:17.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378db498-300a-421c-6f7a-08da4de50016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We don't need to validate and map root PD specially here,
it would be validated and mapped by amdgpu_vm_validate_pt_bos
if it is evicted.

The special case is when turning a GFX VM to a compute VM,
if vm_update_mode changed, we should make sure root PD gets
mapped. So just map root PD after updating vm->update_funcs
in amdgpu_vm_make_compute whether the vm_update_mode changed
or not.

v3:
 - Add some comments suggested by Christian.

v2:
 - Don't rename vm_validate_pt_pd_bos and make it public.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  8 ++++++++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 50bb590c3306..c9ef242177e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -439,22 +439,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
 		return ret;
 	}
 
-	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
-	if (ret) {
-		pr_err("failed to validate PD\n");
-		return ret;
-	}
-
 	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
 
-	if (vm->use_cpu_for_update) {
-		ret = amdgpu_bo_kmap(pd, NULL);
-		if (ret) {
-			pr_err("failed to kmap PD, ret=%d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 703552f9a6d7..3a6b827e540c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2225,6 +2225,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	} else {
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
+	/*
+	 * Make sure root PD gets mapped. As vm_update_mode could be changed
+	 * when turning a GFX VM into a compute VM.
+	 */
+	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
+	if (r)
+		goto unreserve_bo;
+
 	dma_fence_put(vm->last_update);
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
-- 
2.25.1

