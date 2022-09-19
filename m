Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB1ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B0810E0ED;
	Mon, 19 Sep 2022 17:16:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C55E10E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfvoDFXN+GhCAcU47m7j60d7kjkh7EB7OieSjG/ZFrr2uiR6fmpWnu+26vp6qPlpOp3A2F7bgKTOJetH1RQn06shlOAAPwvJZMMI5eQQZNRvsdTILd30FFMHOMjVsmxLIcwyFI49L3ha8+GHWFxzaW/mIPvEnLgeEC3+4U0EZ8kZLf3e0W79/8BD8Ke6hzyk+9RIsjnaRDbsxueLMpaZivYLetZh5T2kEDczoGqSEP9iCWjbeOSe9/G8IlOPvtG9R0GFx+NEw5rUMH3bBklJ4wK67WFU1nrACtoN8lx7JGZctbujPWBwewKaDVkNeLnS/65+TYPL/XT5KxkehkyaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+imlb42vobc3LsAsNib7dNDv6tv//teJSqpjpndAZI=;
 b=Y4mPJ2vPxODBuMnsx2d095nljTGL+c46J5cfYZ0ZPROZ3unMelVeSQg7y1lU4HBdpMx8vIqSHl98cnIX4vYhsjNr/lSeh7zTfxQkRk9i5XPugwAsxxL6qC6Hk2ZmCyRWS2yivplMFXsqAmROn7ZXULWRkDPBZQf1iY7vWL8b/V18lfHBmGKPzPM7ZURKLv5W4oj4JJ37N4yLKXLevvvskh6xJYKppBR8IqnOSckgnPFjhCoZFQNlTNgRFlSvMDEUh9spUrcogE4Oi5C08e5DboHsyWNVC0Ksf324gE4wXMbuYoSRL/w54mjL8IIB1arvISIyNOtbMcRw7010MclZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+imlb42vobc3LsAsNib7dNDv6tv//teJSqpjpndAZI=;
 b=3aA9qLMREE05rFbem4XV553gA29Tn9qUT9o9HbScDqJ4qcBobksruMWFRTBk2o1rzdZpAwvED4mJ5nQjBNUvUIuEs3lG9HqMpIqI14eofUIdFvi89M6bMIk/j2iqVHLA3GwZtlrbJijWr8x8uqnEhaTtn04eTiyoWKrb1UhxeEw=
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 19 Sep
 2022 17:16:26 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::8e) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/7] drm/amdgpu: Use vm status_lock to protect vm evicted
 list
Date: Mon, 19 Sep 2022 13:15:51 -0400
Message-ID: <20220919171553.11286-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 27867d90-e68e-4929-ae8c-08da9a62af2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybdZoWtjRNQ4XZnHoIjBsKWFZnnWQ5dNDIyQn1ZQ6a1pp6SmSYHVurAEwWJsHmtuDAb/9stkVkEA//r2s4XSMM9W5/E04uTLNWSRO1k8NM/wbyu3uu4oSkIUF8ls8sg8QeaH+Qe8NBwevp0u94x9aGX0XCCKZrMdSuC1I1MLMGOXw/TAYdIrusHPtoLX6+0cNPc3y5milWnopyGUioozJXoZhLzNSp2lfC6VECBbO13/APfSesHvLi11+bW9fstMqglhYFmgyyV9JsA7+O7BHGAIgjL98uG3x2T+/AeOTTZgFjgN2vDcp8bfzpPJCMwoAz5J7K1j44lig3y5ZsU/KEfeZV21K2uPyIIdfUIIzI1YTQdTRqFptBUE1d5LXr0jlKuGQxBU+jleHggana/K/W2k0Ft8vetTlFnqh8UCVK0FETEkUF7/HSOAtJZUr3jhLjIKLyAgLFlTfY2C+cQRmnBs+SIEMZugrkjq30y2e6yt3mYT8ejIYFH8sLWqLASNrRHbBCIHnBEB6A+H0Eav5Vivj3hesi918oVH/Ld8jzazSJztEQ6J3cVRcjRnanQPi45ZGQVLLoMQ50mW6xNWu7WaKuGIVSWoXDWhFPolZNxG9Nx31WSc0SUj9YB+xWiR/hhoopU7/kPN1GC+cAqsoTd0xpjhaVgqGYZbFw4f7g1L+yEBt9D5npVpvdVGNVwv0SGptQolCwBH8dwa8Wr/ZtCrbcZwAvl928buDmWISZwVWni+BE5/EQJxkZviYKyLzp+gOcfhHeVheF78DzxOV3mPoxUXp3Oc9H3vWRTRELf3sXSJR94rr3dp+FNFDfCa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(2906002)(54906003)(47076005)(5660300002)(36756003)(6666004)(4326008)(36860700001)(70206006)(6916009)(26005)(86362001)(81166007)(8936002)(478600001)(336012)(186003)(70586007)(82310400005)(2616005)(40480700001)(356005)(7696005)(8676002)(83380400001)(16526019)(426003)(82740400003)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:26.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27867d90-e68e-4929-ae8c-08da9a62af2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 168875115538..b2e96682b9bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -183,10 +183,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 	struct amdgpu_bo *bo = vm_bo->bo;
 
 	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -370,12 +372,20 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			      int (*validate)(void *p, struct amdgpu_bo *bo),
 			      void *param)
 {
-	struct amdgpu_vm_bo_base *bo_base, *tmp;
+	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_bo *shadow;
+	struct amdgpu_bo *bo;
 	int r;
 
-	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
-		struct amdgpu_bo *bo = bo_base->bo;
-		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->evicted)) {
+		bo_base = list_first_entry(&vm->evicted,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
+
+		bo = bo_base->bo;
+		shadow = amdgpu_bo_shadowed(bo);
 
 		r = validate(param, bo);
 		if (r)
@@ -392,7 +402,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
+		spin_lock(&vm->status_lock);
 	}
+	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -413,13 +425,18 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
+	bool empty;
 	bool ret;
 
 	amdgpu_vm_eviction_lock(vm);
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	return ret && list_empty(&vm->evicted);
+	spin_lock(&vm->status_lock);
+	empty = list_empty(&vm->evicted);
+	spin_unlock(&vm->status_lock);
+
+	return ret && empty;
 }
 
 /**
-- 
2.35.1

