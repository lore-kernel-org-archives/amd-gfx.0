Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76E606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mgOrfs8Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA6D1122C3;
	Thu, 26 Nov 2026 10:20:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD16B1122C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 10:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieYokbHJP+sER/KjQMgvu4qzzFi7DinUHxlLcKPyjIojKsT0a+SwssbMRQ5rBx1eENj4RO/WV9y18HKRHdZxXQ84uOBqS5wp9Ax9KPDHhfS+W0uHeGHub51Hn01q0ft8rZFVpvoK+5tNv2hZgspMDmiioRdmFHql+/Q2uOOcu+w1m2v7+rFedN57JpZWj9MT6G/eR06EkoaHnfnonemcVvA/9wzWDE6Wx4Jt/i2l/NA99ba6R8odbY2SuBsvDIbv8rOOcf3f3OgKx7juDic7u24mnd8re9tCEpKbGwNv2+A1uPOAKeczgqcKKoGe8TmUz+V46D4HEq2VUjcccXFHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOg4ArnD7PPA/R8mxbPcCnBJNwljYVhcbr5Ih/jvxZc=;
 b=ifN9BcLdKl3zml37mCc+DZIqpQNGQFHIiRF9+0GltIjZchmLKsQgDwkvax+7VG6A2hOkwZgpkjEJiW9JZhpM5HK4ptC4WX648uaiproKHQZnohviQup/BIrXO7zV71FBfqkdVUpR8pFPBlMuod8lvNkPmXuJHC7aZppvHulJSCOA1K+FfZxZn3hVMyTBi6Rd2G5f4B65zfgll3Uzdw1IOa2dMt7RzrEwVautBoLlMsHXhdmKEtRTVUXhRGsHWmPWk3BtHYTSwtIyoerbz1oMYn8toBoTBH+vFPOSU5A/OgTjgMaUksr+/YaPIZuAHHa9s950Sg05Xa+wKk8Dy4C/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOg4ArnD7PPA/R8mxbPcCnBJNwljYVhcbr5Ih/jvxZc=;
 b=mgOrfs8YgfHTyYyIe0hjZ3NgFMGEDAB/NXb793XF73LzahvwS1bOKy4vUWxJoY6DSb1oDgm6HMGzgTkiqQXIk903ZExbT+MOJnqPutVdvXgoHdENlQwtC64NX5myjOj4ICMHg2lgpDARZ66ynf5xrZeY0fAo3oYoFQQHOcfYOiA=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 10:19:49 +0000
Received: from CH3PEPF0002457F.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::39) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 10:19:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0002457F.mail.protection.outlook.com (10.167.252.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 10:19:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 04:19:49 -0600
Received: from dev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 04:19:47 -0600
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Mukul.Joshi@amd.com>, <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH] drm/amdgpu: keep the address of cleared PDEs with translate
 further
Date: Thu, 26 Nov 2026 18:19:46 +0800
Message-ID: <20261126101946.2651048-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457F:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: e3851cfa-accd-4783-61f6-08df4ba6cda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: Nqk/gnM7s/nxrc+OM5X2h9B1E1r1fHuSaN/CjyqwwTKHXfsSOZJusxyCWbsydxFTFVf91vr7lkxrfj8pl+uSW00XcDnnyWdfEKXnD1AGVhA+S3fSdjpI8nL309VGwkwyP5//KlzRQyIuL65jmRlZhYRsYi0ep4f0oh6cN1UDVq+KWDsCLyo8Ff+1C5/eFqfTD2T9z1IoGTiGFL708IUoOT0UWlIz2rIztkJkHiBqJRcLAytCy4zd+XhbC/TMdnkeYk+mBkSMC7ZGaY+yfrjWoX4+Z/HvdXl13ALalki1cGTiho1xDYg1DwOr5ckYjgcQfWO4j1eP7q9TUME1eS4XFSMXCvWPalre+mznp6YOWm657W5KceS0HpceT4GI6P7XdPWuj6esmVNA8Od4QnDmQjTEnHjfFPZxMBuft0/tnuIejqd+k++cEuOdv2ZbjaL90jz2+veo8fhqcVsk8bWk28CJqGItRV7rMZbSVEm7l4Svxs2bgQcv093MwEAOm4i2HPRoOnzW0wNR7w6Ln2PECYsGEoYkhRfHKu5X/o4haT3jo/+NOM9G569oNhwe4EOOwT9DrZk4s0Ybb/sCE37WkzCBFTf/rGFgutphDmA14VE26cn2qhqI2bLr5H5s4b5wTktkxcHyG7sAGoGEK3Xwb1fvDh6xIUWKSsqWQnIHqGMjTulYKYK5hl+Y4lSeLtTYGFkOhIM5rgmFTMPrJ/e1SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +hMNSJslF5ZVDNf3Y9YLpcUt4zpHJ+KmiAJKEIQ6UqXVS2+C6IuJfWyoImMQz3taHM/jXYMe95AqKvpPNtTHQXKIWZk0GOnwzAVEh6u8JHHQa2qVcfqhJ11uW0lFd31N7JA1QtqsEjKnjDGdQtP6Ubyj7iVqegr8DuTqhTl6thqcFPUk61NEhVHfUq1VBIBBoQT4U0v5jpaOSG+w1SCWcda/lFgVm10VY4pfE/5+2IDOxQTcC0BwbmEFchLS99aH+eM5I5sqS1UmlwqzFS+//myrytivQnIZ2AmLYungkEAsJ0L6DaoLN3YLGSCaRgJdLP0niI1euIYPrcWmiC9YXh0iCqNM2of6w2wNSnnhlXTuWJdYtd5CdL9ebfZhbzs5JeZbluDB/KUKCoWGnz4fpAXpv+07obXwMMbXmYwzEufXvaoTIEz+gmit1SeS56sv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:19:49.6176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3851cfa-accd-4783-61f6-08df4ba6cda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

Commit 37a0bad677a7 ("drm/amdgpu: Update PTE flags with TF enabled")
made gmc_v9_0_get_vm_pde() set bit 12 in the address of an invalid PDB0
entry, because with translate further consecutive invalid entries which
read as 0 are considered a fault.

amdgpu_vm_pt_clear_flags() drops that address and amdgpu_vm_pt_clear()
writes 0 instead. Return both the address and the flags to the caller
and write the address again.

Fixes: 6250a8342784 ("drm/amdgpu: fix cleared PDE/PTE flag generation")
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 36 ++++++++++-------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a6d389c08524f..8f1e0bc7d65ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -346,31 +346,26 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
 	     amdgpu_vm_pt_continue_dfs((start), (entry));			\
 	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor)))
 
-/* Return the flags used for cleared PDEs/PTES */
-static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
-					struct amdgpu_vm *vm,
-					unsigned int level)
+/* Set @addr and @flags for cleared PDEs/PTEs */
+static void amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
+				     struct amdgpu_vm *vm,
+				     unsigned int level, uint64_t *addr,
+				     uint64_t *flags)
 {
-	uint64_t flags;
-
 	if (adev->asic_type < CHIP_VEGA10)
-		return 0;
+		return;
 
 	if (level != AMDGPU_VM_PTB) {
-		uint64_t value = 0;
-
-		flags = AMDGPU_PDE_PTE_FLAG(adev);
+		*flags |= AMDGPU_PDE_PTE_FLAG(adev);
 		if (vm->is_npa)
-			flags |= adev->gmc.noretry_flags;
-		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
+			*flags |= adev->gmc.noretry_flags;
+		amdgpu_gmc_get_vm_pde(adev, level, addr, flags);
 	} else if (vm->is_npa) {
-		flags = adev->gmc.noretry_flags;
+		*flags |= adev->gmc.noretry_flags;
 	} else {
 		/* Workaround for fault priority problem on GMC9 */
-		flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
+		*flags |= AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
 	}
-
-	return flags;
 }
 
 /**
@@ -395,7 +390,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *ancestor = &vmbo->bo;
 	struct amdgpu_bo *bo = &vmbo->bo;
 	unsigned int entries;
-	uint64_t flags;
+	uint64_t value = 0, flags = 0;
 	int r, idx;
 
 	/* Figure out our place in the hierarchy */
@@ -430,8 +425,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
-	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
+	amdgpu_vm_pt_clear_flags(adev, vm, level, &value, &flags);
+	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, value,
+				     flags);
 	if (r)
 		goto exit;
 
@@ -724,7 +720,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 
 	} else if (!(flags & AMDGPU_PTE_VALID) &&
 		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
-		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level);
+		amdgpu_vm_pt_clear_flags(adev, params->vm, level, &addr, &flags);
 	}
 
 	/*
-- 
2.34.1

