Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D5DC5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D3A10F361;
	Fri, 14 Aug 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RP2YuF1g";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B2410F361
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 07:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGY4h7mDEuqcndEasPw/vbL1puYSeIUSxbiFYjOXQOcZpx21TVo+Wv+RU1ClnAveJ+/TzIx5gxIbZ4ep0a8PWs4I9aXnbnjqrMVtU+JEoEpk1CRh2FnKFS8QtJN66wMAfINCA9n0sBwfewDW/657C+ZmLQx8olXN24RzyLaldg4m2hQyQBG60+xp/9sGS6S4HI+DKZz00dIV2odNlPoEAoqYr7krqhf3t4bIAqAzXeurwWLe5V0xEz62rwslZHcWj7cPi97fD9K4EuQrvCIDigr0XFqVChkkCmPQT73scMPlelB3O4u5u8z2XhEe/DrQBSpjBpP5h5Dy8VzO+T43OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JLH8359FLMq0XGulvYjRZLG/tqqZs1UIVhScuExOsc=;
 b=YF8VD86bj5Tcd30APNMLiycANas8YlWnuuXKEx4fLHRPUGvtczt5/wvlWcYb+yOEStCe+XPWTnyRVMLXaEgFssMUV/p7OommRnI/lJLFJdCIBvYDRzi3UOmfpFxFr2HScWbmMzO1GeabEHdgrAARD9f3V+9kL+aYklc552OVSAU8DuAg9/06sSjZnpWYQnv/kzLyoSbdrpDaaQfprAR8wlZc/wnxqVA1/t0dZLQDVAL4gY6Xt40YsztkJf4xhXH8pqkU8G0BVRs463wEcQEgTSuahWPuE1m8UbHpQ885yGTvF+xlotbVAsG8eBxuHT9BQPJngf8KIcLNK+wsZS42lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JLH8359FLMq0XGulvYjRZLG/tqqZs1UIVhScuExOsc=;
 b=RP2YuF1gt3SpJxtq67+8CGesW2NMqJF8hYazTyHdsjGy6dzB6t1ZyVdHKiZ/6cyaT71EQ9elcp0s0i+4PqdTh46a3IsC8+9Vjnj1w317wzB9osWpNp89tdJbBX/rvNrrCUO0UKBgC2DanW3fLo2bjsr3iuGxBJkgdCGLglu24m0=
Received: from CH0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:76::29)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 07:33:52 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::22) by CH0PR04CA0024.outlook.office365.com
 (2603:10b6:610:76::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 07:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 07:33:51 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 02:33:48 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Prerona Ghosh <Prerona.Ghosh@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: bind BOs when the eviction fence is attached
Date: Fri, 14 Aug 2026 15:33:35 +0800
Message-ID: <20260814073335.2552543-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bb2932-9d57-4f9c-2566-08def9d662f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: hyCY9K0My/uyytJLSc3BfDt4NJ9X+//0Z47N7/hR+v/HQFLV3VFl9XHzZn+BZofRwPGv18EDEmZvsClEuFizpzxIAGf/K044DvMO/KBZA0oVxo4K0Q5CkXuzkNPfAFweCo8o7bgNrKJqeslnNkx8SFhLQEUyXd4rCyd8cV1Yw5P0rbXMQVbmY3A+UnQvbS9vgMtubpIUFFeWM4FPeOWBA2twzLTCsirAHwELuISirEY7Cw1XVBDu2KwKmvFTMqYqd3jIpXvMofEg3Z/YczuiWXCAJS2ggDXosxXyZNH9Lc6nu3+2njpelH8hJMbi8DxVg0IrCFKv9hBbjWD4oHvY2wIj/fidITwvNXkuMSwGKfpd7KPC3ScP+gYuVf+/iv0gYlFQ4b1jVdHif4uAq2wVP1/mriFjUzlv/ItgDdVPTXWj7WGWhVS1bL0LBd67AAh/ZInO/Ia6DtTNE8UayDhEHMBQtNjjU1muvYZJnAqbS3rT22CQkHOD/+Cbkx3ysseIrSsJtfF0dDmhGpv1IlK0loYpGvC5W7HCaaqFgbKH8gxM9A5u1EeMnuZdfpd5dd8IaMkkrxvAX+QhxP2nOiK68IZMBstP4DSp4jd8nVMG9Ji2Nz5TPqj9cXwXbSW0nNV3txnbI2cYc5N3asmwPXEJWqPCBtvzjgY+zKFvTV9UPMb/G7JsF2NxgBKEM8TUKXz+2FJWfZIFtsVgS++gXMdSHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4TXS06oYvXYLwVnHwX4oashG3UzhMZvI0GILm/ehRT+IJFTE2lX5RhycA+mGezhvmlBEc80EY1IR1DU0DDxtKomtPEkF8q681vRBDErgXbnJKAy9SFs44gWiVvgLCc72lX/rUOaaq6TUeYdncpW02VBK79GWflQ2nwUUHypofz9pI8WcC+rVXEqlshFUXQsOTKIGTu1xDBt2S+PoIg8PlM06ECIPB4Fu6NGqz5rWXepr5wib0XvtP6v8ZRmioCJHf4lGZJmp8iYE3Ty8q/l4nJwKsdkkZRWyqB5j3C/uTWP/o0PvB2Guo9iPUVa49BdaLj+iLEYTfSYjTEqF7DRdmL2j+/RGKRmOMofLqPFdkQOrcg3qP/IAfhr6Se56hcK2MNG9eZrVZRhdhLPeut2vq1DDT842E+DphEJiKabJHKQawSI2X1EK5v5pvFSfxlrK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:33:51.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb2932-9d57-4f9c-2566-08def9d662f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

DMA-buf imports are created in TTM_PL_SYSTEM and land on the VM idle
list, so neither amdgpu_vm_validate() nor amdgpu_userq_bo_validate()
ever binds them. Only the BO list of a command submission does, and a VM
using user queues never runs amdgpu_cs. AMDGPU_GEM_VA then programs PTEs
from a TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALID, and the
first GPU access faults.

amdgpu_evf_mgr_attach_fence() is supposed to cover exactly that case
from amdgpu_gem_object_open(), but it validates only when the current
eviction fence is unsignaled. At open time that is normally not true:
amdgpu_evf_mgr_init() installs the stub fence, which is permanently
signaled, and a real fence only appears once amdgpu_evf_mgr_rearm() runs
from the resume worker. So an import opened before the client creates
its first user queue - or between an eviction and the resume - is left
unbound. Natively created BOs hide the problem because amdgpu_bo_create()
already validated them into their domain.

Validate unconditionally and keep the signaled check only for adding the
fence, which is all it was needed for. A BO that cannot be bound now
fails the ioctl rather than handing out a handle that only maps to
faulting PTEs.

v3: validate inside amdgpu_gem_object_open (Christian)
v4: fix amdgpu_evf_mgr_attach_fence itself instead (Christian)

Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:claude-opus-5.0
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..69a7f573134f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -101,16 +101,15 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	struct dma_resv *resv = bo->tbo.base.resv;
 	int ret;
 
-	if (!dma_fence_is_signaled(ev_fence)) {
-
-		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (!ret)
-			dma_resv_add_fence(resv, ev_fence,
-					   DMA_RESV_USAGE_BOOKKEEP);
-	} else {
-		ret = 0;
-	}
+	/*
+	 * Validate even when the fence is already signaled: DMA-buf imports are
+	 * created in TTM_PL_SYSTEM and this is the only place a VM using user
+	 * queues binds them.
+	 */
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (!ret && !dma_fence_is_signaled(ev_fence))
+		dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
 
 	dma_fence_put(ev_fence);
 	return ret;
-- 
2.43.0

