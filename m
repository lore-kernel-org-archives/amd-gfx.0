Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E29CC00140
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 03:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954A110F1A0;
	Fri, 29 Jul 2022 03:16:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FF510FD2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 03:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1ZBy6Ec4K8KwstV7AJBo5nqbevbiK6qg9eoQgyazM+QXjij5TpEOB1bPgQyWMvxvHzzwWEbWSqg5pIHZBWFu4GB1sgroFWCqKmzmz9sidWePDazC5WhDmoH7OZsIYb3BlsTLCIMbKzPDZ+Sab0cB/B5zJ2tTJaJK0RMFtolmf+L/Z6m64MMw/VFfenobQFehTz443SNF4l7x76fLGcKuEpE2b2IplVJlI/JliUCl5hNhevVNkQJT0Aq8cdikIHJDiiBip6biI0+/Yz4almWL3WC84Ek8t/K6tdrBj2cy9sd7cJ9DxS5Sp3r3l6p4dxiix8Orye5Q1l42Ngl6Y8+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z/7eWwDeoY99sTXIjritZiiyYvkBVwTvm++CdjLA0c=;
 b=Uhs7EE6gFsOhl3got3VQEkX+vRNxDQC70ZUTSVVdV+nRv6XSrY4Fg3cim/zS37mDGTlxINIi9Aw44S/r5XQs3ZLpfBtV0Yw8kppfaghyFQmlMb18Zg4juX/G0UchpdPJO5T6KsmDj4OBnaSdnmTGsan/RGqn7jI3UXlyTgFYxddCqn92Y+N9KwpfX/C5xThPhBy28Kx+wB4GM+EEak0bv8vbXngwJ1z1oGjSrbaygIiNmXoFDY8w6Av5cySX8LYZB+u2kJFOr+SVg9qGpe0/CreK6PN/xSRtesas2Yj9BHNl1kNLPzfgH7qzhzsyFaiA3izIIvyiW/xXZAVFZwCAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z/7eWwDeoY99sTXIjritZiiyYvkBVwTvm++CdjLA0c=;
 b=xNbWpKpd2bWxgMdujXg2jcr9m0uDbnvZ3aetcrBFsPMkZ9txY/jbz+OW8V/hELODMnMELt3fREwNnmEOW4PIwAz3wLKInCWXJ+ZYF7XVkxBqrS0NAQmIxK4euJSAEJR8Zq8zjxaMzJ2hYw9YhojNw/KqA8sOC76SCOsrVwPbIsI=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Fri, 29 Jul 2022 03:16:33 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::e5) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Fri, 29 Jul 2022 03:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 03:16:33 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 22:16:32 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Remove rounding from vram allocation path
Date: Thu, 28 Jul 2022 20:16:11 -0700
Message-ID: <20220729031612.120310-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 376c581f-649a-4769-a5eb-08da7110bd4e
X-MS-TrafficTypeDiagnostic: DM4PR12MB6448:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vM8u/p05Dh8htQQSeIBuNxz3HCYxMuzBQB3zreeWZ9QuDxf09/A6akvkhTMfBZecepgH0E0bflWTc47+877ajv/pVmYiWywgZ72X/dsQNyABkoPcGM2ALnQ8189MW2Md3tQHJIrjT/BDXD79Beh7Ybb5Vz09TKmm6HRlJTViUoTavVzK4oRNp3RY/A7eJcsYm/L7DDOXNYcMEgQc9BFio9PkmilTXWyYCd/SbsOWzLPuDZaPL5P6wA6VytduuG4HslcupgxbO6ZZEmP1LOnsk0uZJamZPIq3hFdw9eBeQW6djaMhQqrzPdrxZ88bdD/TrcxxDTqbhbSndGv3HNLYrgILy9X7dgrBE8IJXT9zoHz/6BCT97OFhVgdgjCIamNT2ekJo3UKmUVfupOnV1fJDc7ZhRur/OBpHy3g/kxCe+nLKwHStlqYX2XA0EP382fQ8QddDFc6SbmfF9+evqs7htVGnQOuKom/25bSvcjtFlmuDuVWtcB2Lm+wsVERAsciNvAjkiSmKFrM/AynGvEYGsfU1b0gxaNYlNAhNdbc8mFJF/0I2l0CWdqGibYiCoyCGSTgBzp3zUymSxHfjTx1Poeb2yZeJ0TjCY11P0ElQbdSfLRnMMCxyZUYWxcqDwwMPAnwEcc6BMR69YhqRvZl1z0yglAq7RkKw9Ysh/iqSeWaSaaS627+S37WelVK8VzXoqx1enhD71mvjioLhNzPyhY4mojunNuA/HNrDcs6bE7QIYuTA+mIEAa2c6g1IzDuylxc9wy1dBCYlKiEQ6COAmZX92TMffEYpsyoH2HSBZ3p4D/W6jVCG2u90aPzMILGhPM6gRxu1IG5DHg64u/FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(40470700004)(2906002)(86362001)(81166007)(426003)(186003)(2616005)(336012)(16526019)(47076005)(44832011)(316002)(82310400005)(1076003)(5660300002)(8936002)(4326008)(8676002)(70586007)(36756003)(40480700001)(70206006)(83380400001)(41300700001)(40460700003)(6666004)(478600001)(54906003)(6916009)(82740400003)(26005)(356005)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 03:16:33.4872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376c581f-649a-4769-a5eb-08da7110bd4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rounding up allocations in the allocation path caused test regressions,
so now just round in the availability path.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 043a808c88a3..014a594899fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -40,10 +40,10 @@
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
 
 /*
- * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
+ * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
  * BO chunk
  */
-#define VRAM_ALLOCATION_ALIGN (1 << 21)
+#define VRAM_AVAILABLITY_ALIGN (1 << 21)
 
 /* Impose limit on how much memory KFD can use */
 static struct {
@@ -149,7 +149,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 * to avoid fragmentation caused by 4K allocations in the tail
 		 * 2M BO chunk.
 		 */
-		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		vram_needed = size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = size;
 	} else if (!(alloc_flag &
@@ -198,7 +198,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		adev->kfd.vram_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -1642,7 +1642,6 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
 	size_t available;
-
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 	available = adev->gmc.real_vram_size
 		- adev->kfd.vram_used
@@ -1650,7 +1649,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
-	return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
+	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
 }
 
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
-- 
2.34.1

