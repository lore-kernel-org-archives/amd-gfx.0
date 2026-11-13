Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80B606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0o/CxIrh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6C10EC59;
	Fri, 13 Nov 2026 15:50:27 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2F5112640
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHkJOgJERJJ9M+V7MtWGcOoqTJnpPyGW6UdLgF3X/jv7fGcwEwh9BNxZ7xUdUvxXN8y1ATHhw2FjpVlGe9bQuzjG/+whj764ZLlZJoWNa2VjHU5tesLVrntsCJi8XyXIRPNHz8DrCEkZWtocX1+cvh/5XHN7rgbandbrC9SeZEY3jIR7NEiqhYDt+lFOqv+C2lS19hFyW2lvsGQRBZGfPQy6SLLXmQn7CCtEoQomtCx+vp6kY55K4AWcXjExNbP7Eg0nw3PluGas4ibqCkfyoTEW7wVQt6RlJgEQjeevm6TuS45xfV1+0hu5afebh6A0RcmK39xZhWZwGzzFKcRA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i7E2JDVmEGngnYs6TGDcR0lVbxJQ1KGMxAaS5DYfro=;
 b=odfgUrfDHcMyOwGzPO3D/hUZppE0wbXLxpBfUiKKod5plBcz0L2/+PF1HPVM9XAGEmL8mhygCjBWkC3FcYJ38TT0TH3ySfq2Lrv6qpVHGerUZz6rKdYYy666Kz0rUsLaxqHgvsKgxGst/h1ycQ0vgHjmz5YEEeLFFCaslGnD++1UWmILj7eqasUrOkZ6HAphMyalchlCSa+ce/SFm4dz2fLQKwtpBA48JtP+nchjRRIhdvgHDFYeU8MHJfvPw+aga1CusoFZCYlsZ8inEq4M2jSXVWZLYv76P1alME5SZkYSZ6ceXXzbVyQNornp5YEofo9NniKQPP24IYp7VLKEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i7E2JDVmEGngnYs6TGDcR0lVbxJQ1KGMxAaS5DYfro=;
 b=0o/CxIrh7+8D9w9tu/07dApse5Iu05HxwVSnPD6PE3ECnHXaZL5JYP8CHTyx5hHyQNkvsMGx9OqLfbMjGXWnusLFYAjnWn/gzDq/o12e5uEB/kpyJa5zgjKB9kQXTiFQyAoDOWdmLVnMwmzeWFPkJHiI/qIN1E0uD+LVEFPVHO8=
Received: from CY5PR19CA0001.namprd19.prod.outlook.com (2603:10b6:930:15::15)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 15:50:13 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:15:cafe::3f) by CY5PR19CA0001.outlook.office365.com
 (2603:10b6:930:15::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 15:50:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:50:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:07 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 09:50:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: reemit RLC SPM register in ring
 reemit"
Date: Fri, 13 Nov 2026 10:49:53 -0500
Message-ID: <20261113154954.1865439-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113154954.1865439-1-alexander.deucher@amd.com>
References: <20261113154954.1865439-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: da266f57-1f73-4b97-133e-08df419dce15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: y8A0aso4U5EhP0ceIL/yhUGVrzdg5vJX13ENIksgSSH5cC/eKCKIKYEpz06SUnWoTvehBCiPmtLaazdbgP3XKm3UY/XnbU8p1xI/1lCjYaGeOv/R5lWm2nODykBZsOd+eGAB/RsSjQGx0+xBQf3bziyx9QjHczw2ntfDudOolbcGk38mb9euk+0BVJ7HxdEhOgbTwHJaudEzSMe3tD94AOyv6reE5GbHgdEeIDbnfdgn6KYT75Nc5pnKt4JaL89R25FGj3qLnsyy5wpx04Vt8H0YhHFspfnVQhSkoa6+mJgcbK3gJ+0LCuaQF3kF0ivgWvithDwKrekUT8uL+WP2QCI0zqPZhnG1ufG1sFGmr+qi0GJdE9ypDMye8i6GcVEKm2XwtkzCVUA2hN4kUJIRCtBu6D67v+SVp7rkUbaKg32N3dnhJPJ3Nq8exTfGJ9v6jgrQ8CKydJbT9X9Lq6D5nRYWVvnd+db+EbnPmvQ27RiDoe3tn4M7cg++MKINlZK05ep7mZdV0CthBt2NDSsWMdErHt1wIt0vE0jI2/zu7TnsgdxGmUIcs2CAqqXiBISYLeGZiH32MCMiUDavyWK74V9pU2FrTL08powbzmQjFGIB28rklZrTT6xZKZwGvx4eRvkRTDeiMMJ85r30ecK6Jh8EKjebUlXocwvV0vrXi63FbFhXsHTixpDacYUiaUyY74+BX+EoGz++YMEGG/x9NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oi7YnxZvOkjJEoCoOtORXKo7FT5MPjlKQQnNO0js53N9FBtwxYL3V9v/aEIH7I29RakzjL92MjgSCmesk2Y4RdeoAuitP41TYVKoDwTZM9DLTNV+3coJakLy2YDosQQqOL6ZwAuYYntFR3ACY432e29Ro1XAFOO6l0y2gjcQ5VQN96OC2CIrPZ3HInvFUG8sQR3PaDjUASfy4DxJnp2nEymECxlzrxD9AYMbc2jEZ+LfGvfal1xO+caNxtwTpeX6CrENld2gt2UBeWGrbfucd/1i3aMQe3LiWwztoTGNbtIFpd33smzjOUvmqwU2/By1a+Pbxq7LODCBkbyE6olheneWBq6tfxYioJ1O/el6fkRZ8xnmm6QW+RjkLIRYCEKmIqeE6PGb5zltd32M+9+ds6ISclMafl3AvfW24pe40882D79kDCDh6fY/Ood2cKXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:50:13.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da266f57-1f73-4b97-133e-08df419dce15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

This reverts commit 8a4dfdc0d2adfc362ec310ff70526e79ff8377b6.

This causes flakiness in gfx11 CI tests.  Revert.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 324d25c77897a..c3f56253d3b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -715,9 +715,6 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence)
 {
-	bool emit_spm_needed = ring->adev->gfx.rlc.funcs->update_spm_vmid &&
-		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
-		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
@@ -749,9 +746,6 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	}
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
-	if (emit_spm_needed)
-		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id,
-							   ring->adev->vm_manager.spm_vmid);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
-- 
2.56.0

