Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E21A60D07
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E21A60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C4189CF6;
	Mon,  1 Nov 2021 20:14:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA23389CF6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 20:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNrbeBbX1knAiiPWlCXok3su36rvCrbNXEhMiO5rFqPvQ9hEcubHGFH2EWzDbSQiy2aTRkU4nsWrFZTDn8Ru6TUGzAn0h3UT3urET90kOlAjto2qsw7Xt1Ygh0E+HtYFlEcPq/LmS4225SRRLAyBFN0NYAYF5WrvqjBjf3AFAFuX3MNZZsi9FCTEde8O/975tVs9XGKZP5xsyOAjxUWxRZn3Yr6CbSHWT8/Z/hFRs50uJh+X5YQWO4byIAx2ZPPJQY1F/aElfeDPtvXE3D5qwaZkD+29/VJ9UYjlC1pIrzZbHFnGIZve2idLfshKN/VdxZHPNB56010DgW1ciEKi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phdLL3FJhdkcT/2/aJjyCLfndk8C10vGBm4S+fTUMeE=;
 b=YveH/Ccep8KB+Qcs6iygLrPSwpkvBOgpfxlWBvGM84MPVU7wpTjG+ZkYvRM2eQ5VGY+CULrf4/Ngw0Dp2i7XGBAomeaCv9VrwQrNrYttD3sJ1JbnhLADxp5sCkqsTJfneOTJmTvfTpszDAiaEvTSGzDGQNb0skmfuK1n4rpApCnOD1r09evvbVtGwRt+er4yjwnb29Melha1BDx30WP3dUCNuo237Yww547ZYQjVOaHda2vluoa7ZweE9DTZnZ6hAyMY/qH/6dmNldsx9AA7wJQKDQqcIfPv4tmdUWDCSo51Ewf5YTrVoXQLYP7HhOyF2F4TBhFoiNu30Quqdxve4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phdLL3FJhdkcT/2/aJjyCLfndk8C10vGBm4S+fTUMeE=;
 b=lfTS37bUCu98uH/y+bC10pHCWv0YV8lMThCryypwaurmAJSb4HNRWy47vEynaUNSTnb2Ejv9l9t6pacw1gRyaIJe34nqbT1k7XTnLXeAS5OglgeA3LiX66CEffMRjZbivfJH+0ctGP5ro6DbMpq1KXC4dzeB+/TCU+JSxoQfyAM=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 20:14:31 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::4e) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Mon, 1 Nov 2021 20:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 20:14:31 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 15:14:31 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or removing
Date: Mon, 1 Nov 2021 16:14:21 -0400
Message-ID: <20211101201421.1689492-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0354cc1b-10bd-4e58-3f1a-08d99d743717
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2815A198EF29BECF12665C52858A9@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teniexwjQO20sMritVaA92txRFh2gVYm6PBiCq5bJLzxSg87sOpmutQf7wrSOeUWAUSzmUXmWnctXPuf4AsfoTCx4lUixNN7xQ/rC55MxYVg/tulJ1NRLRKoyBIA8F/cqKe6f49pruUEiQwylxvhBApdi+REpiUZso9Vh3xwHL0BpJRedQX2P2Y+/AsAJ/g4mtrKWlbB1sF/aWw8Rhw6C7Fd2kexBVtnEVM6GHuuQfXflQsPjiNGIFj211Rhs/NsT5ZEJM3uEeLfyWQiyN/p5faOKXDF/TEbwGaopE9QTAAOaxPkFrMptwMER2t9exT2uvsppGEgbSFVT4VhfV9Dw/wjhNpALrnNxYvbMnwrnsq+canxaZf6zSrr+4G1oxm5wMWWcp6oXfTwA5jKEjSS95vPH32xrQ7ylC6/WsdVPne828APAMB5bkoOuLv8qcGMRjUCLxEUz9mbJExRaBX04eg9LlquPAlGQLRMFW5KNawI67hqyIuWdza0RqdvjY0Dz41YvNvVr9JyYZ4Ou8DqvLhwdAb0HJum57WZKqjE5JvF9LtBa5GgMQQpk4jPKCobrDuKLR1aHzuzPBAr4buVTbXKjq+Taqv/DQvE73x4AbzQG7St59phFbcIgAXDuhosWx8/aX240LUcZXM+wj/pTGeGFK6wLak+WAfqNw2vyzMAWbCKZSDzT/ZdfB/J+ndc8bKg5kO+jgRyYm/a9OMe+CU9u7kvvKM2bE7KMaXkLeM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(26005)(36860700001)(6916009)(70586007)(6666004)(426003)(70206006)(1076003)(16526019)(186003)(8676002)(4326008)(2616005)(44832011)(86362001)(508600001)(7696005)(336012)(8936002)(316002)(47076005)(36756003)(82310400003)(2906002)(83380400001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 20:14:31.5233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0354cc1b-10bd-4e58-3f1a-08d99d743717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BOs need to be reserved before they are added or removed, so ensure that
they are reserved during kfd_mem_attach and kfd_mem_detach

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 61784bbfd7fd..8d30ccd70800 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -798,14 +798,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		}
 
 		/* Add BO to VM internal data structures */
+		ret = amdgpu_bo_reserve(bo[i], false);
+		if (ret) {
+			pr_debug("Unable to reserve BO during memory attach");
+			goto unwind;
+		}
 		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
+		amdgpu_bo_unreserve(bo[i]);
 		if (unlikely(!attachment[i]->bo_va)) {
 			ret = -ENOMEM;
 			pr_err("Failed to add BO object to VM. ret == %d\n",
 			       ret);
 			goto unwind;
 		}
-
 		attachment[i]->va = va;
 		attachment[i]->pte_flags = get_pte_flags(adev, mem);
 		attachment[i]->adev = adev;
@@ -821,7 +826,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		if (!attachment[i])
 			continue;
 		if (attachment[i]->bo_va) {
+			amdgpu_bo_reserve(bo[i], true);
 			amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
+			amdgpu_bo_unreserve(bo[i]);
 			list_del(&attachment[i]->list);
 		}
 		if (bo[i])
@@ -1700,12 +1707,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
 		mem->va + bo_size * (1 + mem->aql_queue));
 
-	ret = unreserve_bo_and_vms(&ctx, false, false);
-
 	/* Remove from VM internal data structures */
 	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
 		kfd_mem_detach(entry);
 
+	ret = unreserve_bo_and_vms(&ctx, false, false);
+
 	/* Free the sync object */
 	amdgpu_sync_free(&mem->sync);
 
-- 
2.25.1

