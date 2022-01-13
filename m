Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 12:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669CE10F9CB;
	Thu, 13 Jan 2022 12:06:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C0710F9CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 12:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB+IQK/d2CyyiP1cHYbmiYRq2vN4SZzXP7FGzDX6nrQswDhGdnRQeQM/ozxAKsUb/aR8eSHd/Vwtiuv0w06ghcfuBStUi5/xdff0jq4l+GS57X1VXPPHmTu8ccvRJR5QfozNhIBf4B9oh/3J08emUXZGa8do9eSqkXljcjttTc5S66NMZG3iJJfYduA4LjvNhtOit4WBPHWkBNJp4F6vunxrvDiWoSpi0TqcofNVcq5nxABoIumEaoVn3QFv24f3Gd6Mx5gmHrNVNupUyZrxfFparAo3xAfe2isdTHVN2sp2vV4cI0m97FA4wNwKAUPSFjPdwSUQzFOhpTJ7UOohwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nsOKcECFyxRPlNMO4O6xnd3eKPQ97HYjPE2mh3QxlM=;
 b=kBDSAwxh4+NwVi5DbZIb2XYyW3u6wNKSMgObbBCAde+b5FJYiEmdN8vzCUKNB6k/+o4okozIfjIt6WfvtAiPL1SCjvfUb16Z7s3tbvMkZTIlw+o1MRVE6V43GRwJGUzXNJ87pVUpGRaEWgwd0t07EL/CxqNqnKmLelBNIvs1MzXW7RxxEx5pK96LZRcALUC1WcGGcrvWwNsXbbvnGmEv+Ls8Vp9ywB6sDfk+/lIWdkZPB7hDuJbWDiQOd+5mLII0xSItc/F4zN96Y26rVvefD7JEc8svWYwAfrha+Jws3XxAkkPkbjzsVFKYb94mo3BS00joHaIQERgXV//MfeyB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nsOKcECFyxRPlNMO4O6xnd3eKPQ97HYjPE2mh3QxlM=;
 b=oxs4mUwowm/rCyUj5kZtdC9699YIKKZc39kt+W4++RBf6uTi2XYcsp4T9uzel2BW49/KaONTRRSgbooXytHic6hammlMqmC+frT9cgscDNeFYjY5hYsUHgUUjPYrz0rebzgU/5OeWB/HrqT6vtDzbqimxL7EfRaB+EdKelA9tj4=
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 12:06:53 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::8f) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 13 Jan 2022 12:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 12:06:53 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 06:06:51 -0600
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: move bo_va ref counting to internal funcs
Date: Thu, 13 Jan 2022 13:06:35 +0100
Message-ID: <20220113120635.7475-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 389e7543-5294-4cd3-389f-08d9d68d3034
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250988C53EC8E4F2F0D4DB58B539@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47XMxVthn4+87fFmrfMCdCJAp06IGbpkJzXf1hJLKAD0HK+feGAKXlFzDyFfp8jnB+NXbOPGO6Z/8wDwGl0kf2OeS+6NKVmh+xpzVQpnZptUY7dEkPQKVsex1+NCbzCFs4uhmcqUlC5FPee8rEOTz+qJi6gKGfeNr6DwgxopLo7CEC/TtP/t+AA5djAc3OWtjgilz38BJHks58qeh+vgc8sPGGYm0sK7DlOz+WZhpcpnMEQJLe5PV/TEfQiazefVWulrRTzlTV2AGS0PCZ1j02rxzzqP9YRutw6u3k6rs2BTeYKtRGeBd+t5HdCC0Mh7VYwgv0ZgYLIfhmdNcXHftZIE9b1RPcR0V0MOtrVOqXE7dTAIBmf/Zfc8IrndvMcsIMZJWIko/E+ODPIzm+7bqEYjT8WokzlBascHu4ZOc9nthOhpDT6XjSDj70dFRtD3pT+jb/qLTJz3cBiM1/RqKmytmBqlnwmzDPfax5j7oi6vOuLo05RhjVBxzC5DrryhG7ul6yGViuBMQtJ3xAJWM+1Iol+i/k8qO99vsiROM7rZ070Quth6Ov/sRcVsrcAI5754pl6tSpnRzHiNPeF7QaVmbtufclwVhoWhvZu1JXAYv8+WXDyCLNYQBsK6ZWmsnRhCycrm6EYwbotH5rgQoCQSBnRan7GeETsvwbl+QGYNc6ABi/4okpLj7/NgjJcIUc5D9WejR0805FoLTWRXyL9QXYuqqvL0ZI+ctgYR+jfzndVcpMCmSTIwkcL+5pqdM7AKRgHK4ajmgnqzZBxeVcNY3HxISeXZg60QW5MOyIJEEKtBbCRLIjSDThfE3lwfPEmPTEIy/O5XmB7OamTC+Pvsb0sr9sJHxvBC/ZSMz5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(54906003)(316002)(336012)(36860700001)(36756003)(186003)(16526019)(426003)(7696005)(356005)(2906002)(86362001)(508600001)(82310400004)(81166007)(40460700001)(6916009)(5660300002)(83380400001)(8936002)(26005)(70586007)(2616005)(1076003)(8676002)(6666004)(44832011)(4326008)(47076005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 12:06:53.6159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e7543-5294-4cd3-389f-08d9d68d3034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GEM code should not deal with struct amdgpu_bo_va's ref_count.
Move ref counting to amdgpu_vm.c.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 38 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4a11a2f4fa73..691f0a879c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -176,12 +176,9 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	if (r)
 		return r;
 
-	bo_va = amdgpu_vm_bo_find(vm, abo);
-	if (!bo_va) {
-		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
-	} else {
-		++bo_va->ref_count;
-	}
+	if (!amdgpu_vm_bo_get(vm, abo))
+		amdgpu_vm_bo_add(adev, vm, abo);
+
 	amdgpu_bo_unreserve(abo);
 	return 0;
 }
@@ -218,7 +215,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		return;
 	}
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_rmv(adev, bo_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b23cb463b106..9d60de6a6697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1290,16 +1290,49 @@ struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo)
 {
 	struct amdgpu_vm_bo_base *base;
+	struct amdgpu_bo_va *bo_va = NULL;
 
 	for (base = bo->vm_bo; base; base = base->next) {
 		if (base->vm != vm)
 			continue;
 
-		return container_of(base, struct amdgpu_bo_va, base);
+		bo_va = container_of(base, struct amdgpu_bo_va, base);
 	}
-	return NULL;
+
+	if (bo_va && bo_va->ref_count <= 0)
+		return NULL;
+
+	return bo_va;
 }
 
+/**
+ * amdgpu_vm_bo_get - find the bo_va for a specific vm & bo and increase
+ * the ref_count
+ *
+ * @vm: requested vm
+ * @bo: requested buffer object
+ *
+ * Find @bo inside the requested vm.
+ * Search inside the @bos vm list for the requested vm
+ * Returns the found bo_va with +1 ref_count or NULL if none is found
+ *
+ * Object has to be reserved!
+ *
+ * Returns:
+ * Found bo_va or NULL.
+ */
+struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
+				      struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(vm, bo);
+
+	if (bo_va)
+		++bo_va->ref_count;
+
+	return bo_va;
+}
+
+
 /**
  * amdgpu_vm_map_gart - Resolve gart mapping of addr
  *
@@ -2704,6 +2737,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 	if (bo && bo_va->is_xgmi)
 		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
 
+	--bo_va->ref_count;
 	kfree(bo_va);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 85fcfb8c5efd..6d936fb1b934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -415,6 +415,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
+struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
+				       struct amdgpu_bo *bo);
 struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 				      struct amdgpu_vm *vm,
 				      struct amdgpu_bo *bo);
-- 
2.33.1

