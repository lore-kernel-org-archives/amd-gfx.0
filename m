Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E958606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bJ7/fzDJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073CE1127C0;
	Fri, 13 Nov 2026 20:30:25 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0AD1127C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 20:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEDQsPIOSFUTkFSplhsd1Iuh0n02CW+zwIKILiO7ZIoM5FM25gT5CYrnD99a67Y3ot9C9DE6pA4ZEZeRSCjk1zUWKhD+/o4iXQSlB6U8zr2nL3fXtfnv3pL8FkHxZ9Tq3sBv6x6p2jRoCt2sgacCLFx5DzPAkA+cW1u19O47UQg/hQE69nJvOz6KAJS0HZdhwnM1TaLkUHEs3vnBfK8wmiNkO5B5pDs5V18AzUiAyfk6je7cs08uVN3b1GAT1Wg5qBJpc/KhkTh4ExmPS9CGQqyAaPQ5tdPwP/JXuO2PbcG4dIsFHOcuttWouuBj0RBUzntujrEU7z+YPp2uQIBeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I7INyQBLlSh5RvYiQEaWBr04mw+z92oZ1S2BPcXXpA=;
 b=pGeGR9HZyGlQFhCe7hhZyHOKxcUZSORWpi97fbTeSuzAs4qudlbQagcSyq9nVN/6+6AdzErL+wJF6UlDaoZNsKSPot8QgayiZvpFgqBAHc81kMhZSIAIsJdZee+CPbitOy9J3VQuoAcNRx4HHDayfcdH5dXkUecEMYC56va5R2i1nJHfbU3VuRRKmlJ57jJvdFTN4SQVmHm4t/XKfIGxpOouSA+fjfUuDYbldGehMwb8tLpuJHdXzT7i6EG2kUZH5wQU4en9ttAmPYkU2SzMTQWPahLujglA0MgSRnk2XbNMngIKpx8ueyuz4ktIH/6o1gAKclY0vNeZE+uwylFTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I7INyQBLlSh5RvYiQEaWBr04mw+z92oZ1S2BPcXXpA=;
 b=bJ7/fzDJGb403BDhccATj0TbzFlJYaI8lfmqnqqaqTC6zG1dZfQ/D9Rj4eTDQd6Hp+ypM5M0WM3Czk6HD5OKYGHTOHnbTIjNkTIRmfZSFOjPYEXGxZ4R7jK2tFNZxTX5VQt1UqjovEESHMB5Hz442J62unJJ4eQj1Vpc7+r/waQ=
Received: from DS3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::10) by
 CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:29:53 +0000
Received: from DM3PEPF000265B0.namprd02.prod.outlook.com
 (2603:10b6:8:45f:cafe::86) by DS3P220CA0008.outlook.office365.com
 (2603:10b6:8:45f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 20:29:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B0.mail.protection.outlook.com (10.167.23.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 20:29:53 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 14:29:52 -0600
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yangp@amd.com>
Subject: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa = true
Date: Fri, 13 Nov 2026 15:29:44 -0500
Message-ID: <20261113202944.3006069-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B0:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 194c5288-c044-4a2b-bb88-08df41c4dfc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|261009223027099003|261022075727099003|56012099006|261026140227099003|10067099003|11063799006|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: GQRJeyxkqWVJeKHKOZsQiU6SqI2Lnh1n65WaH4AOh7rr8wD9jKCvJxD80Puzj5BtSdkiOeYTix83fwaAxE/diZEbA+kB31rBku1zkqTXQoQZWkr5USZD+8uVt6hGgmtHV9TJMKmbPwn1Z5rrt6ZflPNX/mB+rlwe3cI2jKFsYwdJf+BbUwjbGU1s13jyl7uvny6urFJ8rgnDby/uSZCyIu8AgGdzChsoc6DPETsqwuvkDMhYBVafMzS3sNRIQRtzyII43mF7jr25s8QQIOKlo5NdjP2iG7RwahbWA0gpR5oSnsQ04gw6fgT9x1F3/e5abBz34jjhAq+p1hqN6/BOGWSaEby3pQg9nAQDwz7mlsTX6PvR30zgrxAJz78VhRzezqHt7PmZy0L9e9Ycnhiw+nh3LJTEu4SycCMFLojq2AR1zAFPIiaIpYbxnRWDfsZoBBQEAF4QBEwbFrB20lExT4EwcaLmvAtrbM3IDHe3pUV4W9EflN/qmTk0l2OvfbIOSsvajWxfzGwwzqxCL3LcHgtRg4U/gWox3hV87/AXtfTx5ycUtS3vfg3N9jwKi3qBJtelMXEZW+vu6PMnryQNTa9w+mwQZu1PeTd4WAw7XrtJU0wk5mJvZ6PqPficvjN+RiiLWHTdxsbAmdB5eGjY93l4zIy+H+MS92ISkpkz5g1+4o9h4Qagqaw6Y1+njx4uH3bKm4zDodv2tpplqmlIiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(261022075727099003)(56012099006)(261026140227099003)(10067099003)(11063799006)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51Dl4sMYycVzKt2MWP4u4QILQyVzhet4Nw9QBnZDKnhH42BJy4TaNn9upfLkMsEaN9r0BfYM5xlEk5z6b6Ih81bUECl8gfKlkpOu4kj519LIWxNJSMZJT2tBq9idflvbP+qQ3DAIptvsbMjoCrQQJV3sAt+dnCtM6Y2djJV4k5h9+hI7Ld4ZtqA/SpX3bzORISuEybLGIpdcAfnVmzu3tbyLVB8zvyhjnuoBLXzzmcVPK4koHLsLzxDwBgwiU2Nv/NrVjMGJpDgjfvSMvcdUgR09JvDMMC/WBPBHuIAxoGidZl5NveRv7NqQEEGpCrjCEOUNmb9RQKVImfo8dcxUOrvIqFaK2cF3PDdinAlf2TiaIqOBq4UNGoLm92BEWGzS6D6Pjf7Ez9j5W5i4TwlHKdFJQsoe0uQ/S+jnUhkkI5wWHhPCB9vvDki/nzIg6nW+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:29:53.2493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194c5288-c044-4a2b-bb88-08df41c4dfc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
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

Previously, the root PT was never cleared after setting vm->is_npa =
true within amdgpu_vm_make_npa(). This resulted in the flag
adev->gmc.no_retry_flags to never be applied for the NPA VMs.

Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
been pinned/validated. This allows the root PT of the NPA VM to be
cleared with the correct value.

If the pinning or reservation of the bo failed, the vm->is_npa flag will
no longer remain as true. This is to avoid conditionals outside of
amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
the VM is a correctly initialized NPA VM.

Warn if the VM already has mappings, since clearing the root PT will
break existing mappings. Do a heavy weight TLB flush after the root PT
clear to avoid any stale translations being left behind from a previous
table.

Remove the redundant second setting of vm->is_npa = true.

v2:
- Add the WARN_ON sanity check regarding an empty VM. (Felix)
- Change the return handling to only set vm->is_npa = true upon a
  successful pin (Felix)
- Add the heavy weight TLB flush after the root PT clear (Philip)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..c7187e0f99b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  */
 int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	int r = amdgpu_vm_make_compute(adev, vm);
+	int r;
 
+	r = amdgpu_vm_make_compute(adev, vm);
 	if (r)
 		return r;
-	vm->is_npa = true;
+
 	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
 		return r;
 	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (!r) {
+		/* Check if VM mappings are empty, clearing would break existing mapping */
+		WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));
+		vm->is_npa = true;
+		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
+		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+	}
 	amdgpu_bo_unreserve(vm->root.bo);
 	if (r)
 		return r;
 
-	vm->is_npa = true;
 	vm->need_tlb_fence = false;
 
 	return 0;
-- 
2.56.0

