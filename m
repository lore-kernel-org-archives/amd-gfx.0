Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA21606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MoGLboM2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC1610E762;
	Fri, 30 Oct 2026 07:22:43 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5940E10E762
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jof3Oxj2NPk/ZxP/nr9+DwQELmFzTUqxveS3hYU1UyZgeKG9TQdV/J07XZNDA8bI1DzrL0d7GtZdh0oslNPqsELCS1J3w/cyW3zSFwqyUEfnck3pg5pfmLAPcLTCBf9y3uDuBkPHHy7I7z6wzgQq9k8CHYO9/oAUANCgjt+GcBxBssgFzbVIAoN7IOSFBw/b+oPTYm5b+YtqWDolTmfXEeHbHNO8OSTDEF16SMwIjHMfq4LBiw9gYDY2BUjaVMqJgXhellSHkkvA/tzT+ptY34blP3Emkcsd4sz2jykeeBgLgRl2C8vtzhNZ5Bzinfc34LBduCgM7sEX3bZHn/igfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHcwJF30AA3QNTX8uWLQLSbG8WL9D+095HG5Ja1uOHY=;
 b=fzQJFBZiJO7HJHAVOVSax/0NOYb0PP0NFvCCHyFhdR9FI3Y1SUYze3acLP88m8bIxBTiW8E6bRBhE3/MszjBDsxTeMLj6LhCvJ2+xXfF/3heU7LZlZ9RuAMHgGZdjiCAHn4/5FS6brAFePRtHnH2cIBOIOaGisfGWlQkZUORLbssF7Krhfy/1p/sWyy+r4+Xs5Gw9cugBKvvaBKg4RePk8LmOmJr9AdVBo0vbmQEL9w20oGTFzJEaF7OIsG3G600gSt5Jdw1rxtjoV/Vb9FyId2BL5bUzvpMZJvgH/lNsAZwatnL2YN8xT8ON/FmyHSDVSPIdkhVBJ1qHhTPr8yYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHcwJF30AA3QNTX8uWLQLSbG8WL9D+095HG5Ja1uOHY=;
 b=MoGLboM2pQKLXh77v94l2X5DzuGJMVzFnFeqEyM7CZ2ItWFnGPc1T8LNIyxGjU1cohwNyTQ1MSVx4YjKq8ogRfaC7DADGbr+vmeHO8Q4T6BD6o4MKLYshSQfNcBhuCjokSr9VNyywytvOrtNm84/UISU6vd2j13VnanIA59uRU4=
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 07:22:32 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::3a) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 30 Oct 2026 07:22:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:22:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:22:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: program the SH_MEM registers of the SPM VMID
Date: Fri, 30 Oct 2026 15:20:23 +0800
Message-ID: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ecc3db-2680-496f-a1c7-08df3656901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: a6aUAwzjDSPr4PVaFgUxoL/uvDxyVPhT3uD8aPSkfvw8EBK2L6rVGanSeWOFkDxR4h0F8UTOQxSBqDh4mdFlnviW+Dhrd117oNJzCZOHXYyktJxGkh1ADIBYBk4hYA09dueABs+ksbwbk2GnmItYp40Kh4pXzq4bwcWgA0OcJ3Pci+uwQspizWzu4oZx6WdLLabbdPeNJReBuGprJRVOFpN9/A3YEuxspICCZv30gQQfVwHI31orrfeQyOcArIm9V8smVJo9vGsBgKv7CYW3ji7eRR3F6vzEqzcb44YeXhmbh89xHafgE5hFUsKnK5kSIb7Cs6k67OJLFjkqgYFcwjgGHLqfl+nWd7ntHKTFfLE7ihqP7Qcyaexb3Wt2gZJJsgp56/YW0dtqs7VIhTWSMNrB+eXGDkysXO0Fi8CtoMp+OU5srpiS2pnlS40LttbdSVN7O2Y2H+41Jk5QttAyUYzs5ugztLXVbGOID8V16kM4fh7SjsGe6oSzbDpe+7DxGQ1YvIQ4nEWQ9Vms/9JCPB0Yfx/DYbu0nCZkmnv+bNVAxJL93WsWaHxDDuThuBcVfPI8ivIgg2hg4GcgLSM0A024Iqj3aVbrKqBnasNSC5o9mgHH3wQwNaygwCJzuHUYpA+qi9nL1SdJLC/op6jP0JJ9dVRPQiwkZhDSQEpZSpcnt+DrPFpRmJHEFCbEheqVzrXBUER7v0LJ7Tcf7MDUuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sojqGPx7EzEoJq1LMMgBPvAKa3RZtdwnVf6tKU87wyITd3S8CYE3GkHGzvA6vHOQZ8qJNzYH/KLOTwiC7hzrYYLQCo3Sv4aL3FYT1H6EXf8gFEr1q/TqWTs2FFZGc8rb4sNoIiK1CEud9fL6G8YPWgRBhFxPimHsk7ATlBvghv9CrvjgnM+7wDXgRk/kME/3sA1H400+1fV0SiwZ7RzWretNDptleMtNRwG8ERX1FUkFLBnla3M8pVmeqT3nQfsJlRucq7wlyT+YTL6VFdfiQVxEFDDulPwDQt4fR4C+0rVsRQqsPO6ZiecTyTmr1N8pBCMIMoP28Pw22Yi0J23oZ3ZFiR1sZlJFDsZdqTqZnu+9ZcW0DMGf+jHn4Gc0rpePrgEiYkcBs9z+Nx+HCuIRnu68hGaojI8krN/kFgr5H8v5huW9rZCbXlVPwmLLxxjb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:22:32.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ecc3db-2680-496f-a1c7-08df3656901c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
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

Commit 02232367be23 ("drm/amdgpu: add spm_vmid and exclude it from the
MES, KFD and kq pools") took the SPM VMID out of the kernel queue and the
user queue VMID masks, and since commit 8a9263fc8812 ("drm/amdgpu: use
dedicated SPM VMID from the reserved path") the kernel queue jobs of a VM
with a reserved VMID run on it. The gfx constants_init() only programs
SH_MEM_CONFIG and SH_MEM_BASES for VMID 0 and the kernel queue mask
though, and init_compute_vmid() for the user queue mask, so the SPM VMID
keeps the reset defaults: no unaligned access mode and no apertures.

On navi48 VMID 15 has SH_MEM_CONFIG 0xc000 and SH_MEM_BASES 0 while the
other graphics VMIDs have 0xc00c and 0x20001000. A shader storing a dword
to an address with a byte offset of 1 writes it there in a normal
process, but at the dword aligned address in one which reserved a VMID,
e.g. for profiling with SPM:

  $ umr -i 0 -sb 0 0 0 15 -r '*.*.regSH_MEM_CONFIG'
  gfx1201.regSH_MEM_CONFIG => 0x0000c000
  $ amd_uapi_regression --run-subtest reserved-vmid-unaligned-store
  unaligned store: 0x0000000000002a00 normally, 0x000000000000002a with a reserved VMID

Add amdgpu_vmid_kq_mask() for VMID 0 and the kernel queue VMIDs of a
hub, including the SPM VMID on the GFXHUB, and walk it in
for_each_vmid_and_zero(), so the constants_init() of all gfx generations
program the SPM VMID like the other kernel queue VMIDs. The mask is only
used for the register initialization, the VMID allocation pool stays
unchanged.

v2: split out of the SPM VMID series, the per generation consolidation
    of the SH_MEM initialization follows (Alex)
    build the walked mask with amdgpu_vmid_kq_mask(), which the consolidation reuses

Fixes: 8a9263fc8812 ("drm/amdgpu: use dedicated SPM VMID from the reserved path")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index c134000eecfd..3b73c7b4b117 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -36,23 +36,37 @@
 #define AMDGPU_NUM_VMID	16
 
 /**
- * for_each_vmid_and_zero - iterate over VMID 0 plus every VMID set in a hub's
- *                          vmid_mask
+ * amdgpu_vmid_kq_mask - VMIDs the kernel queues of a hub run on
+ * @adev:	struct amdgpu_device *
+ * @hub:	vmhub index into adev->vm_manager.id_mgr[]
+ *
+ * VMID 0, the VMIDs of the hub's kernel queue pool and, on the GFXHUB, the
+ * dedicated SPM VMID, which is kept out of the pool but runs the kernel queue
+ * jobs of the VM reserving it. Only builds a mask for the register
+ * initialization, the VMID allocation pool is not changed.
+ */
+#define amdgpu_vmid_kq_mask(adev, hub)					\
+	((adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0) |	\
+	 ((hub) == AMDGPU_GFXHUB(0) && (adev)->vm_manager.spm_vmid ?	\
+	  BIT((adev)->vm_manager.spm_vmid) : 0))
+
+/**
+ * for_each_vmid_and_zero - iterate over VMID 0 and the kernel queue VMIDs of
+ *                          a hub
  * @vmid:	loop cursor (int / unsigned int)
  * @adev:	struct amdgpu_device *
  * @hub:	vmhub index into adev->vm_manager.id_mgr[]
  *
- * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking
- * the result with for_each_set_bit(). Used by the gfx_v*_constants_init()
- * paths which must always touch VMID 0 (system) in addition to the regular
- * VMIDs owned by the hub.
+ * Iterate over VMID 0 and the hub's kernel-queue pool, including the
+ * dedicated SPM VMID on GFXHUB, see amdgpu_vmid_kq_mask(). Used by the
+ * gfx_v*_constants_init() paths which must always touch VMID 0 (system) in
+ * addition to the VMIDs the kernel queues of the hub run on.
  *
  * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e.
  * vmid_mask[] being a 1-element bitmap.
  */
 #define for_each_vmid_and_zero(vmid, adev, hub)				\
-	for (unsigned long __vmid_mask =				\
-		(adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0);	\
+	for (unsigned long __vmid_mask = amdgpu_vmid_kq_mask(adev, hub);	\
 	     __vmid_mask; __vmid_mask = 0)				\
 		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
 
-- 
2.50.1

