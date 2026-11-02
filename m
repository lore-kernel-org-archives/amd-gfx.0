Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C78606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0V0bGJ+Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A0E10EC1B;
	Mon,  2 Nov 2026 08:25:28 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9238E10EC17
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 08:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xU2aPUgDFDAZJVeiQD8HMMc8ciHo0isUSOXUcbMoTStarTx1jPiK5ZoA1QJxkDLF6dv2+ABI5mczymFmg4KZS+h9u3EsBK0sZw1Jdjh9qKn6C0fLhLsdOBA7J3VTTb9wRVGe2+IPLjN795NTSWLCaN2JTuhW88vcmKw5gbt4YyPe553Y75PfaTpPCU/EVpXXJKGbQY+a1c6OpFMNnL/Saqf7nSByXqXciNJBiMGAxR5MpfxltfOfpY6pVpySboEL2uU4kquTnB51ZBeyIFSnkzLeIjg/EwTPj/r3tqzq+ALB4cTvkIWQeXTOMO3EhKXHDrmRROYjIj4HuiFW0OQJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F5WCAAQGu0Un8CIBlbSIWqd5EUOWTCzq8WuIXwTosw=;
 b=X1K71WdEccwnABGdkvVE+WLlMkLll1LDM2xa4YOcNZ3EVZ8q4lzhOd1c/cv9japTmqFW3UJowJ944AHLYABGweEcBHRneR5oW9X1Pic8I7O0bVftgPhO++dCWpoQKGFxAS3n9bnob5XRbZXapLrUt8edpVIFRzjR94+xEPPbVco1jyeQzaJ+5KkPQKcil2ozMCl9yvbag0ZG9mu8eLRv5TRQNq55S99oJ5pGRwoOa8Xlxtmu05fMsrFPtgWetbObpewQJq1CZoB5YPMxoN2stOH37o6E/5cphbnekrSHt5gDcgFKlbacvrW4f5xH4sqRMi0jIIul56e9D8jtQrS0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F5WCAAQGu0Un8CIBlbSIWqd5EUOWTCzq8WuIXwTosw=;
 b=0V0bGJ+QwjJlj2PuLLj2JDpAAK8Ksyk7D8GnwxUT1wAKizjHA75JjibGQO3vWoastPQg/beLLTviIS9fVtiEgUWLROKg2lHh/mDWDnfrdkG5pJ2BgJwkXnFvjBZLmQ8T3IYPW6NfQ7GWdXK5mlk3A/QcTEfnrGvvPIstAV+amlM=
Received: from CY8PR11CA0023.namprd11.prod.outlook.com (2603:10b6:930:48::17)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:25:17 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::a7) by CY8PR11CA0023.outlook.office365.com
 (2603:10b6:930:48::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 08:25:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 08:25:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 02:25:17 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 02:25:16 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 2 Nov 2026 02:25:15 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
Date: Mon, 2 Nov 2026 16:23:34 +0800
Message-ID: <20261102082510.2149814-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6f9205-abce-4fca-3337-08df38bad3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|56012099006|5023799004|11063799006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: sf2VUY8tEdFUde+z3utJuWdfPK4GWWaSjDAMtx1zTGJoTqx2tIlqJ3nGhKCX7TQHhThoIhCxqqfy7FDRc9mTe3Yj5vRshwaaxvRW4QLqROYhhe1lExZUSCgglKuOcTdbmRYTxGpI+/CbUvLuo1Ufl3V8eTbtJ//i86x3kAAvssnEpVb1ShN0LxEHwXR2870pVwLUyqqqKLHqtUPdiDFRjFDukpfFzN5Gk+5Lp6iuXjF2i/s28ShvTSfTlZdZqGv2IBpLCWgIq0uIC45Fc8tuiNAZxueeJTaB2KR7w8l0LH4VW20e8Xgia4it8ljIoa33s1DlXq0ahNMdEiieH4actkIUiDNUmGJnX58VY+igHL4Ht+cr+tL4SKtc6vZrCmauyFrseJzbThHG1UhE3urGlPW3dXwAVp79oCSZj37Rw+sKLEzb/5S1NrH07Y0i5G6uiCh/hE1/TRds3k3sWc0t/TOlUJrEO2UfUTxtt+RA5uzYREOJHkbjuISLJnjiFaAgH/JUAa14/llLNy41tioMMewIuIrQ/EKcTI3+3wr6nVDmmpbbCsSFBzndDLoevHZA8NrstYbB8Uy0CYXW6vyihz1wY1PlR5NjyhxpbDYUEx2vEt5QJ9wt6zzhXdk/m13OV8NGOJFK1J+X4kYkVVBvwi2xauCboXta4TteWA95eiUd/JAbrlJLpxcw39OnwTf64McrcmSkZUIDaAtgUx9ZOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dENsl1Z7Hr37UsjBEeWQ+SoDGGh7eYxRHnVc+TRISz1nkiJrhWmTqQrpGPnSzfXv8uCvP9gKd/ZXcPV0cHMcgMxwT0wScI0mIbhxzxXxz+IVPYORjMQFj1xVYSEu9TQiDHu8JkpleRIDJhMPZxZLHUE6c2cgOg3/EvXiNb/TDVh9iDZ4fcohcJ9ZpwQ4b7ES7bokO4FtxzYC0ZIQNlIPL4bDnIxQuS7YpEWr1Y17rJNDNohUJExhZHMZuuKY7gSqrXPXUJCJ6tnBYO/LHDxeDZTs3JfexdxcvQvq+QDkiiUI9MXMxZI2a7fbfAq0K/yymZ6WA6nf/gDxReChUNaO/JlAxoG3sclERjA3aX3Vu74NsB8kfl3vIuwBH/PrrE1jXiClk5pgR9+qLHYS2sayOQw05t3YhD9FqPQh02w/+qhaxrIQN1H155nzkNGGXec9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:25:17.6464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f9205-abce-4fca-3337-08df38bad3b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776
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

amdgpu_vm_bo_reset_state_machine() moves all idle vm_bos to needs_update
so that their mappings are written again, e.g. after a GPU reset lost
VRAM. Since commit 5be7f6720a0f ("drm/amdgpu: Only set bo->moved when
the BO was actually moved") amdgpu_vm_bo_needs_update() no longer sets
the moved flag, so amdgpu_vm_bo_update() writes nothing for the kernel
and always valid BOs. The same applies to vm_bos already on a
needs_update list, e.g. after an AMDGPU_VM_DELAY_UPDATE mapping, where
only the new mapping gets written.

An SDMA write to an always valid BO after a VRAM-losing reset faults:

  amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:7 pasid:9)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000100000000 from client 10

Set the moved flag for all vm_bos on the needs_update lists after moving
the idle ones there; the root PD still goes back to idle.

Fixes: 5be7f6720a0f ("drm/amdgpu: Only set bo->moved when the BO was actually moved")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 65974c0e7a16..2ba33212d507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -271,19 +271,27 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 
 	/*
 	 * Don't use list splice here, we need the special handling for the root
-	 * PD and set the moved flag appropriately.
+	 * PD. All mappings must be written again, also of the vm_bos which are
+	 * already waiting for an update of some of them, e.g. after a map with
+	 * a delayed update, so set the moved flag for everything that needs an
+	 * update.
 	 */
 	amdgpu_vm_assert_locked(vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
 		amdgpu_vm_bo_needs_update(vm_bo);
+	list_for_each_entry(vm_bo, &vm->kernel.needs_update, vm_status)
+		vm_bo->moved = true;
+
 	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
 		amdgpu_vm_bo_needs_update(vm_bo);
+	list_for_each_entry(vm_bo, &vm->always_valid.needs_update, vm_status)
+		vm_bo->moved = true;
 
 	spin_lock(&vm->individual_lock);
-	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
-		vm_bo->moved = true;
+	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status)
 		list_move(&vm_bo->vm_status, &vm->individual.needs_update);
-	}
+	list_for_each_entry(vm_bo, &vm->individual.needs_update, vm_status)
+		vm_bo->moved = true;
 	spin_unlock(&vm->individual_lock);
 }
 
-- 
2.50.1

