Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CBCC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B89761930
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B89761930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07C26E2DE;
	Mon, 22 Mar 2021 03:05:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647C76E2E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aphOQWSyxF9gtAOhFy566oSgesnNXYvyrdoRO059t3IWU2Kbxtq3MTVlRcsSQ7qmAa86HfMbdvDE2lK5fFrXPcJLttPbkpj2D5Q++efPEnxm3nTH652IGoBqOUJE5/5h8NnMT35wa4/EiQIYdn0kUdP7xlm7t/XEbIGMuCRJZZlxEbdr0wGsZ/1rNm26noKTlOMJ1WqPqsiYAhorAqlWPAS/wizHveluMoHP9KZ8MdmKzoxjwarWOATbY6JVKnPTWEO5p8xsdpIh81ssGVjFr5X5K9EStlFRjsAd0a1L3ohvAyN2R/4G/cpwKQinkPo/t4IlYhfATPwSha5sdCjOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSc+3RP9oaK9LxjnuxTTCJAPOSVsmkGr3CXtuxxLvjc=;
 b=mBP8MMwoblUtL2Eg0AU/vLo97XPXlpB/AvInvbpPPQ1ahnM1zBmqTGHhDZKTmLnX7vVc6FNwBHhNrN0NXhkwB5uflbOMwD6OOHmkX6AgUz/HmHikVrCvIKZsWaz1z2AQsg3+QETLyVwY6lpDLbQMfPr1ltyRHv2tnm1e2JIZxABduu8LQzMBx+w+DFceK2NUo30d3/z0tmom+Hz8OrguULTORh/ihVjmdMSq6Mn6hJHhbJ4qQrVxGz41fu3YwFxLXYjd3pfNmX7ZIrQ6op+TIec/rLQtAne3Gh/pAJ0tFLr7AlWJmGAqvtQBrj0eUJJUEAkxeyNe85t1zhMa7kUUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSc+3RP9oaK9LxjnuxTTCJAPOSVsmkGr3CXtuxxLvjc=;
 b=cK+C2MdI/KcgaGosNkwzNlXr8FWvLjUQ+gON57UpBoLl6XcVxYQ2DsfCnVGJZadDRKuoNhRiao1q2B3w0P5yYUv3DqRMDWOMTMRjLyBa5/xB5U2d4Gd1Mmc2YEGcwx5vjg76MIwWN+L5vsQ3uDvN9yh4NeXrHCQPSA3yaaBONjY=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 03:05:22 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::f3) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:21 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:20 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdkfd: Add fence tracking
Date: Mon, 22 Mar 2021 11:05:10 +0800
Message-ID: <20210322030510.31607-6-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322030510.31607-1-Roy.Sun@amd.com>
References: <20210322030510.31607-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 160a582f-dac7-40ce-e5e6-08d8ecdf5521
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-Microsoft-Antispam-PRVS: <BL0PR12MB496278E3E8988BED48EC798EFF659@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8KB5FNaBmIskpD9PWYag1MSG1ChV/qMrT8EYEaNOyN7+cOszJv1IuvOB75usR3sUZCwwKZYzrcHbwMNT58JQHXmbBY8LMqX8DmsyU4cBDNohOp17LnDu0GerCtW8sGH8DIvcj3FNZ0DAmDEgmqLQk9/5wMVcP8mAogUkwTMUUTEo+UbhnKZVG34D/7sTojl0AOnVdjeV6IqJHcq9dXj179hAhEsNUUNE+5ILfgh95GdvtFOOMvWGGi0q+MFQpw4wdiYsgOa7om6TcRkUr7jyF+UKIm+IrXRsuZxR9km37FqCaaF0NvSulwW+ZFGsCwA1bAkViE/r36kF2it5AFyXqWzDQad4sP1OofL5qrgx+o/L7ih3+H1rT1GnU4TwGauLjUiKHvGMb7I2HP1GitWHCCOtvKl8VQGSkaoIJThhsZSY/fQcK3Obh6l7gRn6uGzNviX7NCY+ICBz9FFi9Uf0TELbtxOm3ErK/sSq5OgkUyO4RZSE97yQYXlhiMaxWvCJin90ELCccV3s5vNGTjHo1h9IhsD0d6pX7Rsj6PzYW76zr10fBv/7WETJ0d5ipnWZxfULK2aMdCfARq+YVExYXkEMENbqvdyACDryUuaqN7cLA6czrQiws54aBPRtTUeKv26seVSvwJ6BrmcYy4/aDVSWdbx2EMMakdJl1ueoyeIhMEmfDZAduyImyFKbU4t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(186003)(82310400003)(6916009)(36756003)(26005)(5660300002)(54906003)(4326008)(6666004)(336012)(1076003)(86362001)(70206006)(2906002)(70586007)(478600001)(426003)(2616005)(7696005)(8936002)(81166007)(356005)(82740400003)(47076005)(36860700001)(8676002)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:22.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160a582f-dac7-40ce-e5e6-08d8ecdf5521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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
Cc: yehonsun@amd.com, David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add fence tracking for amdgpu resources on gpuvm creation

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e93850f2f3b1..26e84c2d6316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1042,13 +1042,16 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 					  struct dma_fence **ef)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *new_vm;
 	int ret;
 
-	new_vm = kzalloc(sizeof(*new_vm), GFP_KERNEL);
-	if (!new_vm)
+	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
+	if (!fpriv)
 		return -ENOMEM;
 
+	new_vm = &fpriv->vm;
+
 	/* Initialize AMDGPU part of the VM */
 	ret = amdgpu_vm_init(adev, new_vm, AMDGPU_VM_CONTEXT_COMPUTE, pasid);
 	if (ret) {
@@ -1063,12 +1066,14 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid,
 
 	*vm = (void *) new_vm;
 
+	amdgpu_smi_create_proc_node(adev, fpriv, pasid);
+
 	return 0;
 
 init_kfd_vm_fail:
 	amdgpu_vm_fini(adev, new_vm);
 amdgpu_vm_init_fail:
-	kfree(new_vm);
+	kfree(fpriv);
 	return ret;
 }
 
@@ -1142,6 +1147,8 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_vm *avm = (struct amdgpu_vm *)vm;
+	struct amdgpu_fpriv *fpriv =
+		container_of(avm, struct amdgpu_fpriv, vm);
 
 	if (WARN_ON(!kgd || !vm))
 		return;
@@ -1149,8 +1156,10 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 	pr_debug("Destroying process vm %p\n", vm);
 
 	/* Release the VM context */
+	amdgpu_smi_remove_proc_node(adev, fpriv);
+
 	amdgpu_vm_fini(adev, avm);
-	kfree(vm);
+	kfree(fpriv);
 }
 
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct kgd_dev *kgd, void *vm)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
