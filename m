Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C5BF53D65
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4514910E246;
	Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3RKOO5G";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD3D10E246
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 15:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdQlv16SQSY5YQg9wd98eD0pIn+aaw17aiaMEOaoZu5qFqpj5TNosHibruh5uyS5w+do/RGzd4W0iw2uIU/a9tZc/IqaTyCNyrb7t3c6bmDGUAfDdkv/qAuE1eD/Bol7Bd1eywpJkli1nuS/ckpIngaPpe++Mc5lOWWECZjPugHpn4Naj0lbvsiaShyR9STFrQAk69se0f6oRM7ypP7z4laJYkTkoEy293t+sWCG7uDnI1JWDS7es6YaXz7fILVIpWGbVYzAN+2wR2L8idXwp8ww1Zja0vmMT5Ze+KdZGc12NKYtSlDD0k8h08OuYze71iVPeQdwF6LCu2ifKTArAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5KeRBIenCq4hiF6purdoTY6QQsActlXIr2CbGdR8Zo=;
 b=tp0xA9OAnYr4Qp8hCwAcCHykLByyCpntLby6/EBgopENLPXdBBcPx4Up8pS6cLtNWW4nrYGpBGLAcTf+DPLLBpm8Cg/TOicZexWE1Z4ilAjUB74r+iF0aQhZJ+5aKnjEdIFuZ62CwZzmatJtjjX429+H0VIzBMb8hsIdHWF2Xm0gG6kkTPM7H6akZfPmNIagMvdIrgScHh4WS6NlHtgb863+quyDn988OLLw+k0Fdq3BTPVSnwWFujfnX4LHc7k1ofDcmsf6AoCbGbXJj+wAANhmTEPlljEuliBqstACaXKBMYdLKO+pl6j916dkV6d8dbooEnG9BzLjK5YZivm5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5KeRBIenCq4hiF6purdoTY6QQsActlXIr2CbGdR8Zo=;
 b=L3RKOO5GlVZuD5ex6jRYwAnub2XplB/MzI3axCuwD2hPCG9k0oRKO5Xq4ri5SORaXa9Cmu9fQFIOkaFNOkeKfq0aYa7uImKhUONouTJLMZ8TzHVm7+eW8BYYSLgndWaDuQQp1z1Ia2naggz7LXh+HjTOlfoDdycxuIebdCCyjas=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:16:50 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::7a) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 15:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 15:16:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 10:16:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 10:16:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 10:16:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: rework how we handle TLB fences
Date: Mon, 16 Mar 2026 11:16:36 -0400
Message-ID: <20260316151636.1122226-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 354d2465-b6fb-4c53-42ea-08de836f0c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: J65A4MynSevo4N8g+HEsBSvuDJlaeOTSPD41jiu1GK67khhwZLxLG1W++WkVAeZBut+wjyjJT+qHnn2oFoZwh1R3aErohb70ZDimaKlNsWqUmg1xmkwFmDl6BYhZswlBaf2LiIq8t0+Dt8OrmpdqIHkdaDXuzXddfhgojYlD6Rzo35BJ1K1qntjwGROprxcf9gKFRwTVz+Vogps+gyZFZ/Fm14puRyOZr2nkWwjHbkUnQVZ/VLT0lVkRk7E+YhIJONElQduZLW+iWPrPra69eeS4aQdrOr5clinSvkqGIL5ot1rRVDC9ivXITO8Ua4OPam+MrvX2jAHn4FS+qQFaXJ1poi69BhqCFZVuELjfarRWswF68azRcefEbmyjhPGu8KBbe1aoge2wT/2Jy/cArpiF9qXSEnbVzLS92rM5H2BqABC7cElMilplmAYcoQwARu7KA2DNiq4wZ3VTonRRQ5TwFzkTtv14X3yJl+NOKqBh4ee1d0zsaqNsI1DO5idfthVMb6vycX1FAdtNVfNwvay/jcjwAoDSHDCWZYUQWvjVnItGySi1rF2rVWXvVTcrHujHdvAYNkfDy2ZNmiUrSgL/4Isri+eunWMhfGoBZ3gTMMZiEDTnDw/lXy6f5cfjrUqrYBBgRwva8MKxCeG7TQ7kM+aFhHHE+YA/sfTJ3t9bV4gzcJ4S13JKB+awGlb1Upd4RXaegEvMfO+qr1xlQrwbQDZD4iXXKmXXLlGYB+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t4OXKjiO4iykdANoe6KllmeAHCC7vKU0mT9+xVf3ilcbhXUp4sG6cd22z4bkOcelum1EcJxfMo8r4J7FwdPtwMcNkyCM8/jWYnHOusiSRKI0TDJqdl50unhfhcrOAo7Ydf2DWSbcvSsRDpPGXbHzg7LzX/ZKtefNXBsO7xI6swkmG2F05L85dhw+8QkizUgAubAdy6rhd6oafIHSxowrVpbbZ/yt6/kz9G1k6oD1+9TjLrki8BWVuPgpg5jRA5HX89Ur2HM50IHmRMkxAhdBPDQ+Gd/uCZBcknWowKRAMWoGI8Laj1JS646Czr6/FtFKjjLrn94/ekeqwXGBQZg/IM8IwjrBL2OeXQZ6rTapvXKoPbnq4vWWZMwQDmmymBNeARnreYV2xNzgKKFJoMlku8/X20h5BIRZ8iasVEVB7Rm2u57hOu7vpu5qFpsGyEry
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:16:49.8838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354d2465-b6fb-4c53-42ea-08de836f0c02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
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

Add a new VM flag to indicate whether or not we need
a TLB fence.  Userqs (KFD or KGD) require a TLB fence.
A TLB fence is not strictly required for kernel queues,
but it shouldn't hurt.  That said, enabling this
unconditionally should be fine, but it seems to tickle
some issues in KIQ/MES.  Only enable them for KFD,
or when KGD userq queues are enabled (currently via module
parameter).

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4749
Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
Cc: Christian König <christian.koenig@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b6..497464f50ea7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1041,7 +1041,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked) {
+	if (!params->unlocked && vm->need_tlb_fence) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
@@ -2573,6 +2573,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
+	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
 
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
@@ -2710,6 +2711,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_update);
 	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
+	vm->need_tlb_fence = true;
 
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ae9449d5b00cd..25d176d1350ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -444,6 +444,8 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
+	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
+	bool			need_tlb_fence;
 
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
-- 
2.53.0

