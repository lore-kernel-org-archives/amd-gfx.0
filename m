Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45F606A33E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a6K8k3Id
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4189F10E8F8;
	Thu, 26 Nov 2026 02:11:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C8510E8F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 02:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7T8nZ/f2VW0gbSP7GEyQi9iUsay6lyTaPOqzjIAv7C6mlT2h4DwI1VVniO70bpQ1AHCtiD8szJLFHpka3GKuWAtdw4Ohak+Q9sbfo3STElMNpcA6bk6eULyPUCf9ooYLihVs1Nhvs4BJHT1/eVlATGCTz0DsNQe31hTXOlx6iFfn+VOB5wm5WTaVDyMtKSLUxlJHfoJ0EzkM6V5f+zOAUvXEu/dYjJ/fKwoReiMfPoN59VJsxky9OOjXIu9spEYWYII/6YUvbc8aBZBy64Nzu/1tqejJPEsbBBX+zZwPmcDsUtaEv18IIVpDKQcOE2YFwpqFsa6WhrGYOqEYb05Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0kT7moWp3JPwjekTphUsxMgfarmOmP20nAWQjwGQPg=;
 b=yEG2cHk+9PFTNA53t035Fe35cZK5zQLviNDDvTpDit8jBu52Ji4exOsiwiBvqiBbUTALuqaPCRwysIRnkuNhA2qaFnExY8F+++jdqRiO5ROP8xvs6Hu2dmejHxh2XtTxyfcqmwwF/oNyJOnNqVpaGqqnYxRnPBxY254iphrSOxuIBgnlNfxpBnxJ7rMjcQq21ZENwtvj0L2LYnnuycOR2WVCaJogZwP1syoaraYr5s7ySrl8Zz9AMFKkBGPtPWoG7d4BaksTerTRC13llZ9V0hgcRad9MnIEFAwZNeonkjINolweHLvVh8ywV/kdhkOnOGlDvrFvDafebstIV0UM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0kT7moWp3JPwjekTphUsxMgfarmOmP20nAWQjwGQPg=;
 b=a6K8k3IdhEaQL4lFvMiYTkmpr8vKURAi61pOqP5uAoiF0BHrMxSoVzAI+/JtuRTe7qGV1bs0DPum0OJWsRXD6ChqvVniaBWO8YGneQ4lqBXKxJFhb2lLip8ntCiCLPkawVvc9MvQeRq/oXLQCw4TNzuT15JAl6F0Ol+KKo4/f/E=
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 02:11:32 +0000
Received: from DM3PEPF000265AD.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::5a) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 02:11:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265AD.mail.protection.outlook.com (10.167.23.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 02:11:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 20:11:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 20:11:31 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 20:11:30 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 1/2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
Date: Thu, 26 Nov 2026 10:11:02 +0800
Message-ID: <20261126021124.3809452-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AD:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a66751-fd94-4641-a982-08df4b6296e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261022075727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VG6JwO3M7475EQuyoskpk6bwb9gCZMEhVHP2PseKpDThemEXQYwaMetJAwhc8/vd4F72UV5YnxHLAcq7ymJPPzQk6JY6pKhPp7Os9sdGovhxxKL2MmVMtAfrLxDILaGQlUS+eFPdGf/4yMc6cvGS8VqNt96JPNdoONTKzviPBhe62zYAuGy5CcP+I+YbB5B9/SD/mLJMOLqactdiYmeCzI7b+DUwi/bqy0DcbDXIOLjFEPPvlUrz29rGVyEhLjrsyXaMXSRwzC3Fe4WJ7+zOlj19/mzLE9RvjR4sLpyQ7bY17JzAK5q7QUh1WPgD9zWrjQz15n9vGikenbzbgNPVQrl1Ycj5X7hnXdSjSguSCRxsJoyMzvuwPCUysAKCgW0V2dRr15B92tCTd2mqTHHIB8oxAJi6zVGFNe/3rZdjYmvfJHDfGzpsjwODaht3QvsC566SLgnN5BjJ1vQfVP978O4avEFDrxlTIOEXa4NtaWtUpnTRuA7rtQX3Fk7HCgZeW54AOnTHNHZU6XvqvLxGBwBQATDhKEFEzzRKHtgdRe++rlPTylBbX6YHSgd98EZVBhj8pneFjug4bvl59JEcsBU8gA2f1TPKCqIkgu7MTyGs8I8xINTFsCxpgIIp/XfxYLG4/zh2pB+b8MoTF/GiqVhIYIvYFLEEZ7VOu/3luf/gyhBHqa5LpTMAiWdAthV/R2wBxwNFtwyZ91WCLls4jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022075727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BAdLZxl6gRut8uBYDGu7Ei/2TMyJhLtN9edYt7qoZlSOOsVtp9vm04OJaimAJYHpSaXuJt6WNBTCaxwSHmCyTrSImxDZKBKKMFX2Oy50CUzVjsonhRjOST7Kb0/FUpZBYpgzk4vFLpyhYTtuiQPcXA+Q0VMkl3vszZy5GG5ncL4aKqanOUJH9t/BkMqGIFz2dWEXx7Mae1CuJo7yddDb56B2fKC+5FazFodBkCeE2DjgHCZhqWbqD6vnHQK7c6tQTkQKmoE/kdnhdPKXyHxcG/qL12zI2srUMiDzP9hyIXO5dS+ReJU5Q9FbfiX5KiEGnGjCL6uuqX0bLS9eTB9I1VAIoqq3/s01TBU86M+I10bOHXKPEWcHXb4Hnk3TVbFyDlQSds5zxmU6EHJS0LzrGvacAdKz1PSy2J/2GwqDa3NaTH/lvXw9BzITITH/EUyZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:11:31.9353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a66751-fd94-4641-a982-08df4b6296e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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

The userptr MMU notifier walks bo->vm_bo under notifier_lock, but
amdgpu_vm_bo_del() removes and frees entries with only the BO and VM
reservations held. Concurrent invalidation can access a freed bo_va.

On Navi48, racing userptr BO close with MADV_DONTNEED triggers:

  BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update
   amdgpu_vm_bo_invalidate
   amdgpu_hmm_invalidate_gfx
   __mmu_notifier_invalidate_range_start
   zap_vma_range_batched
   madvise_vma_behavior

  Freed by:
   kfree
   amdgpu_vm_bo_del
   amdgpu_gem_object_close
   drm_gem_close_ioctl

Take notifier_lock when unlinking userptr bo_vas to serialize with
the notifier.

Fixes: 1c824497d8ac ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea8672451d98..87b06daff892 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2279,10 +2279,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	if (bo) {
+		/*
+		 * The MMU notifier of a userptr walks bo->vm_bo under the
+		 * notifier_lock, it can't take the BO reservation.
+		 */
+		bool userptr = amdgpu_ttm_tt_is_userptr(bo->tbo.ttm);
+
 		dma_resv_assert_held(bo->tbo.base.resv);
 		if (amdgpu_vm_is_bo_always_valid(vm, bo))
 			ttm_bo_set_bulk_move(&bo->tbo, NULL);
 
+		if (userptr)
+			mutex_lock(&adev->notifier_lock);
 		for (base = &bo_va->base.bo->vm_bo; *base;
 		     base = &(*base)->next) {
 			if (*base != &bo_va->base)
@@ -2292,6 +2300,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			*base = bo_va->base.next;
 			break;
 		}
+		if (userptr)
+			mutex_unlock(&adev->notifier_lock);
 	}
 
 	spin_lock(&vm->individual_lock);
-- 
2.50.1

