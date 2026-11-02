Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D922606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L2wsbQxE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C32710E41D;
	Mon,  2 Nov 2026 08:22:42 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF57510E41D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 08:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtJ8FiacAeitYxmZv87++6O3lOQcc8TD9qCZVPpxJaqeKVPV+ECGIRNAygsnqGIp2YljW+aaQCXHFC+qo6pK+/lOAwiXuvJsMAUA/+nt0FAUEGZAe6ow5W3Jb4mD1XgVenwWrGn1cGWW41pREWpJHHTt+RS87Tn/Q2nYQPT0Aa9qou4hATW8j7/vjrukCbsRro8O24VGeVshW+GrNhB+0IKIDMFkYh03ijdWWj3/YVIQ+/cgZp7ycSQlLkmCCbA5D+GLBATQVBLsKGKBSwDojsUB+lJkaZzAbsf/NtHS2x/6QwfIc64ULUaLXSd+DMoEKlwK3FB7f4+E1eKl2D9ycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crp1s1Jj6wq28PJOs/qAIq3n2AgJE+o5BTuwQjrf2EY=;
 b=OOjXhZpZjhmL5rCJz2eLENrvjmrC6kVDH85d5g9yfvIdgB0q6fc+7qAVfUPYIvl3FGwFjISmWmulqpLkIvmJoaAm5Lm8HkdfrQXebA/JEcLKCD+KMrzkcol0uCScRyd65VY4fMLGS9QmavPBXmYvW1wma2BcBR/yhfka35erjuu1lWwUDh1RrY57Tj54kLIeJmumn+Ufp9dVD6e3QVxzgh5T76saIT4f692WzUF+lhJkHrH4tXcRY3rkhIw6pGwmR6CD2loHezU3elR22aS3gUPwayn6OTJKiX9SPlbP/pUzolWl7T9hnk2NvZ0WT4Vi8LFR6mUoRI/oxmcjd0WH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crp1s1Jj6wq28PJOs/qAIq3n2AgJE+o5BTuwQjrf2EY=;
 b=L2wsbQxEA6Eoi+n5RAS7pb4YJnOXlHvbi92xVWQC4WZaNoiP2tsrgTPGgTD436duVWyY4FVe8EqaJ197uAmDpvisJ5NlFoVO+kLHJkT2kdGKpPWyV4Y2Hd38Lizh1JyKW2zuT89vdEaG2fmS+NxILC82TguAwAoGMil3cYIW1HM=
Received: from SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:22:31 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::9c) by SJ0PR05CA0075.outlook.office365.com
 (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 08:22:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:22:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 02:22:30 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 02:22:29 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: drop the dma-buf reference when a KFD import
 fails
Date: Mon, 2 Nov 2026 16:21:11 +0800
Message-ID: <20261102082228.2149111-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ef520b-69da-43fd-5487-08df38ba7063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|10067099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261009223027099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: s5vsexpp0oxVS7yRXrpwKxyWZ8bzHldG+xXE/MQcuR5xE90PfeMCkCo8Fn8jLBf7alf+SRCYSMwhRmWP+oBdv+pqXxyz60Sd7GzkIg4tqj6w8zZn33nEJGv0EGcA9hj1cnSsDzt9SU606O26BR7g8F6fzkTmdOERWywgQ7SJ1XtkoVSQwas/MusDHqmXm/hWvsrA7th5nvccMbfKqcrHc2zGONm2V4rh0Aokr1E7dzL5q6RRgiAowpaAQNbprO2tysjyFVR/EyGKeucl//QGYMS7jCt0ykOv7RHjW8rui7ylEKQLshkiEPyfERRQBKQhqXGNozsyCDL2C238BcGbg9hXXryOH7iZT2o3b0TAWhNN0S6+WwyUQsOOMQwB/7KjC6nZNg3ymMCJPYp9/XeL7w9vRCmwoGq2N14OgDMl0CEPiVMt7kA1fpztcl1bVIqo5VY0+A/sOJStYst/cyc3V7G6lwDjfogjLjssyeeLotF0B/jelFg0qUWMZS9pXVGMijqIjG3tLxK3c8yQZ/hw8Ap7UND7eyxnrRZA1/n0XN//TFUk+0yaVmmOCL1BxDE2N6Qex71LaXFO6BqxzA4jVedSCQKek0xbz4l5ULJ+lLAhW/wrV3LTQaHj4Ft/gZti75xAPgVfbeKjnlzQY8rwyA9PhL6DLoaO83Nw2GO32JXB+T5T/BRVSXDvbTCepLTFIwcS92vmK/tcChPYvgaKWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LYVZbkWxnwLP27gqMCImcUThYSy40wRBYTl9/6Bv4Eqs3jGS/ift6AikoJIq9ZZQCQ5a0nIIghpEdLEWhyVrJ6JTncLRCvzh8BBRjCYAtsqLocxxTg59s+S5hoUJleU/xBYSTBv01FQ4fMTQgcsy4j8iPRupQixczSGqUEtfwhKxbcQd0mfnPL/H1xb6aWnK0GbY67DZ0B6OYbAobnPhJ4+dhzbvf7aiXUfyhFESbUvxwy3jGM9VAy9k22DFSAnW2/ZYRa8zdsQB3UE8j0W9w251yV7KIogDm7/rj4vPnFQxtMkGw7jLRjbcm9NKW8DrwG9X5c+i4MgCEjnzYylh6kGOlliPaltluy1zoCcprYCYNtBaMeTB+2FhiXRZK504hP0nM5t1/PFTfztrn1XetNl1l7PfZ1vuONbzwLlQpwt0ZhoVBPOHN++ww3HKvAv1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:22:30.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ef520b-69da-43fd-5487-08df38ba7063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

import_obj_create() takes a reference on the dma-buf for the new kgd_mem,
but the error path after validating the BO doesn't drop it. Since the
validation reserves the BO interruptibly, an import failing with
-ERESTARTSYS leaks the exported BO with its memory, and keeps the module
in use.

Importing a 64 MiB VRAM BO in a loop while getting SIGUSR1
every 20 us and another thread changes the BO's mappings:

  INFO: 171821 imports, VRAM used before 65 MiB, after 129 MiB
  modprobe: FATAL: Module amdgpu is in use.

Drop the reference, and free the sync object and the mutex of the kgd_mem
as well. With that VRAM usage returns to 65 MiB after the same test.

Fixes: 0e2e7c5b3d71 ("drm/amdgpu: Attach eviction fence on alloc")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c399b85731b4..2f8a5e7d3f78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2475,6 +2475,9 @@ static int import_obj_create(struct amdgpu_device *adev,
 
 err_remove_mem:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+	amdgpu_sync_free(&(*mem)->sync);
+	mutex_destroy(&(*mem)->lock);
+	dma_buf_put(dma_buf);
 	drm_vma_node_revoke(&obj->vma_node, drm_priv);
 err_free_mem:
 	kfree(*mem);
-- 
2.50.1

