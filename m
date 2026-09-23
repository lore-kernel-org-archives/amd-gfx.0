Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC18C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069CC10F155;
	Wed, 23 Sep 2026 19:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dv+WX5LV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A3A10F14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIvSdmsOQfOB9w2uvar7pVFw8lWYekqlS2iX8UA7ySmg8kGn507zFaB74N6m1AwYlXY0wtsGg8dnuCsIm7gkTdMfmUDkOWJ9/IP81PWC4rgu//LxhDhkoDBY8WwGhGemvZxlzLEsP9oeAeE+8XR2f7X/xHpOWcCP4lRhTMfGRDPnMFWSy3W6KYdNk2LoqeozKkY9u2GRRLokBbAOOmnNjAZxNbHql4dned9YyHsLziYhUpRoPYguoCaWzvExs7n5l78c5vnZWv6XST0pwkb+IWF6+Q2ZKFH4KYQzzXrFrN2qG8xuiCFQ7jPqqGLuulsGAk0caSxPE6ysG5klfpSO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvyCWhahIn/yw3JjActmSLY5e+n+hyTPRkjMDGTKn/M=;
 b=VFKG78csaUwBmGOHqTnz7Qfr315XaIcvLHRWpQCaOC353AziHmZr21RxQ5Mogs4EAYvVue1nbok5wKcJla2bLUmK8yjS+7g88n3ZxjqkDIU6lMKjnEF9GPX/u+iDdcQzexERfPHP6O2HzGsBVHBoZT7hBoJ/Pd8d57zcOYOBPDgaTSfqSDQHyisLcAwPYnKQODVJMIjhN9DX7pUrQ872OT85KTlcu9Slc3KzO7d2ZyN9vL8X8EPzCvbSp5LNM00kfKsZTF0XkeEcqDZzHErZrZJCp3jci6+jSEj8p2SRENqcyoudTWgYXSN83ERozddzG7DpVqTnB9MuVQSXqSVigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvyCWhahIn/yw3JjActmSLY5e+n+hyTPRkjMDGTKn/M=;
 b=dv+WX5LVvS/ph7C1N6Tt2oLLkYY8t1O+4HAr3essMQJLdiEU9daf+tlCFVsoSZFnfZOLSy45QL0mXPCEemgo/ATcWBepCDyOxw8joa2NSumOU9qDDrDhrPW7tG2DrLdouOGqTvqkQ3Wr+9fXiWbnJdijcViWyYGOBLwUjPb7dQg=
Received: from SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::11)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:34:27 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::c) by SA9P223CA0006.outlook.office365.com
 (2603:10b6:806:26::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 19:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:26 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 08/10] drm/amdgpu: drop vm->generation initalization and
 root PD clearing
Date: Wed, 23 Sep 2026 15:33:44 -0400
Message-ID: <20260923193346.2292597-9-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: c51701e0-ed9c-42e3-c2c8-08df19a9ae08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: re3kh8W8ctirJn33+/m0a82SC+pQHLfdAiRhe3j3tH0cIBEKxhlqdM4vCTyHp2NEd/jYPi3ReVHQER8WTKgXIsrP+afQDOHLO2CpaFlzbEujghZvlOJ6b2IhDmOR4AHxKMjAUrbO5MM1jiXADYFGWJ2Ml3W83iZ/m6k47fpXiYDQTo3OWlbQfjdYh6IZRoyRkTD1KFLC7oBCFW7hDRUVgr8GPPap35Czsok0iqgc/FXoYlzRLtCZ7IOuviV6nWHUZTY8wmxX5B9Gjjb+bXDEp7Js74dC/Z5OBi3QUxCOJQAcrkK0FS2/a4q4/wojz08TwqA5EBTgk85rLm0Gc0fuzgFvRXdINZHQ/ZW+m/G6S1pmB4BNTdAOSdsMNI7HSM3nB39/wJLYXYe2jytmHBBcjVdIzJtrMYg8GWKfC67fj4OMdCVqwpOb4ivPG83SmwFxBDo12tx1Oy9JZmF0JL2y8LzMmKEeLEzCJc/NOzaBMFcQCdmMmEKrexdWi8euC2dAJ8Fi9Casrf9A3vMmKDnf9IyAJ4zm5kB2j/LC0M9J9LGI3QNljO+4ljit4DaTUY9HBWRy/doeowiifqMMkAbgkp30BbUmOZULMuE5n9yJcqFsQUwcbwC2MLS/u/nEubf5BoLRTcFmpF8IBOmGuIacV5urtIjwLQpcfG2Z3pKP7px6TWyj0+8EriOcjChwESUwYJ1KRef6A5ZiulkTYEnZpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JFLqLZTpK+UYtvTnkHKSm55JfDhVb0yHJckwmMPEiIoGQ5Prukq0AJSVOCidKD4sfpFi+BKQkc5Of3vV5/vLH9jMsu8VT6ZevUbMTpXnSr0MHtH+TmCwXB6tTd9MD7vllxh5HNX8gsO2LXYQK0BbhgAERin75FT+YgPFP5TJC+4DUindIZIhVdp8+p/KXUsDjf+sojt/dIrczokgPbyzTFMVpYJ4Tp4B6j5srPMJ/N/+yWH7K2gGPvvaeNY8GXHXCIJyWA6uUparacEuUUaTAIZCyIXE4AkxwjKMNsj4lVhHGvafzbfREGJXSGNWOACnylEOBUlRhzuWJ7qyMk8KIE6GvLAOX3nVWDwGKQWnH3awmer8252zVYWg296rK+o9RYJujwBFjtaLNa8mH3TNC4xGUnsPKPzg3Lc3yzR3MvkhgSzJRqqiDqhnUeyBiEPG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:26.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51701e0-ed9c-42e3-c2c8-08df19a9ae08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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

Dropping these should allow the GPU to clear the root PD only when it is
required. Further testing may be required to verify this.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde5459469..1c3d3603af60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2640,7 +2640,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2663,10 +2662,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
-	if (r)
-		goto error_free_root;
-
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
-- 
2.55.0

