Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC99F54AB0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D595B10E6F1;
	Tue, 24 Mar 2026 13:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ys7zFUm7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264B210E6D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdY+kzT/nR2xwEOuKqurFb9PFi+OH5UI++Itg3namOHsKrypXe1ve3YaaZ5K+An3J9TV5h80cdyWip959GVzQmTvUvmwINXfhjNIecUpAGIGXRIjYEjW6gLNmiuxouWL1KKC7DYIWRw/qNF8th2YYUI+eqeS0kUcGCBhFSLO61DiGavy2WjSbkcM9NASlGLaJ4jWgB6d6fFGkF9HA9/83Lscemj/LUmx9ll7SWIH3Q8ootKEpUVzR+CbY2WlPeNFgcPTRH0KUIJxqBAonVZWQpPcF3iP2CjffRoxnffUKcTj61RjLs1JKsR3Ba02umqBdKJA9zYmwJIaorE1pQ61/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQZNtcCaBC5dcTz8nOw0/REyRE/0j1usvpnCCxR+9EA=;
 b=Uwm8y7yZF36xbHUyMgBzwdZMmYB93GyqwQgRaD3zFAMtGsQr3b6WPkUuQkDIVoYIsuTayuMzPFmZzSARZvCO9j2tg2/+9Muhnm+gyvuWwdtTGcqeWjY+qvAwssnezI4Pimz1uDMpHsUYxKv4W7U9cyD3GDhkDAbTa4LgTAUUEfgcUn8D1YQZhUIIgrmE0x50T0nqV12tehNothmv5QWPkmDQ2b4suDbBJ+JTfndodB2Wux7z9gzzQrP19SbhVKWzC3SDCrDxyylRlc5Y7+X7HsZQb1xxrN7MrqtE4Ib4r2/gboNvJCkyYyRO+Sdd224Z1CqmxLENCvMYd+NqtV+eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQZNtcCaBC5dcTz8nOw0/REyRE/0j1usvpnCCxR+9EA=;
 b=Ys7zFUm7tDLzocJolakJTI1Dmf7TavkPGJgI9aLNhEwE/jyn4JR5VnHrI6Ri5dmogFpfiez03KNSkFPg+YMDrsuHWW8HRoVAGPED7cYxjIGC2nDmBwQCJ84gLCG+NbmMzct44P736KPg8deTGRsoAH8jQ5nNhxU5j89o3PzQGK8=
Received: from SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 13:57:35 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::4a) by SA9PR13CA0069.outlook.office365.com
 (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 13:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 13:57:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 24 Mar 2026 08:57:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
Date: Tue, 24 Mar 2026 19:27:10 +0530
Message-ID: <20260324135710.2079864-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: cc550fba-bab5-4534-9a8c-08de89ad4c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: w3hyU4VAmpiHyTicVn4S6JrgblAUIvF9UyIjin93x9EJzLBupf3T9qbaEpWk6CGdM+95lkCfHTeH980PPwu/X3SgtSWxrghCtby5OZgNfPOyIpA32DeIw2wvySiXPQlf+KBuTAHU+vy9CwjULvAvvHMdfRdMkwgrVHnbyZygrW2iidWj0megX1xwkpwKyqDQXD/LzYPVyEO12ladjszz4Iqg9Ixi/NAcHhZJPoL5aSCLvuQDGfMDul9m0Njxg2wqOoWryI+XrItIEODGO50sCMc+VxitK2m7XaFWzJBN0ziWETpYGsB6kl7nj/sNxzAj2emqfDAYhRPB8+8geAjUkwej8D5R3xMOcyeaUBJpvWiEwMI7fOiKZl4dAP/76JFD/zNvnBxSwdPn9kfl2ARJrR9Fo+QWL2CMttPfX/uxWHPzZ27QYE/wcbg6JenezZPbhBj61vAR9M1UObcjngPVlbvZP7Kb2Ryl4rNyW96Fc+Om8u43OUt4KEA8A19TLX1ZQ9wSDSSihsrRhy+oTJDlFuWDIE7fO+YQtRx+IvmK8lDGHm/eBDt4tq4wEfftuXbOCLOMdb2mFgoXLkyR7NR0E7tN7ZZJsrRKc3mgqZ2L4GYxDU6HAFI9VXllSRM4AGweMPe3nzHgutFDmQEiRkEbyS6gnqqAsXi6g8b+L4VJeS8PjQwoHAcLGWtiUMSsZUYAo5guUvtxKGocnviKVkDXM5LFAQaZsCrrSg6zHKTJG1F0NnDc1f/gocpiF4gdlYkn+bBpqws64QDSWV4lWBIe8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OwwPVP+tp7Ekx3qEVAIenxXRkcHqzwD7u3m6QPUY3t5GZL9wD5l4bnC72DOaBG9UHWLBnR6BVyZwnL8D/Jxf2NhxeqsCwov22+vaBI4o51KdlAXlRQSUSTsV6lTcWgdLarXT19bxXl/l47YxNrf82ZJKxPoEHssj+cNx9RNn44ZavA1mOKCT4m42jKJa/vprRy4d1FrfrRJbQhNurIOhHpvF5MGSWDYEOr0cLEGRoWVT4WN205xAru8b6KmHZBxjO3dBgV/p40pMjbeZIkQXsnHrlwxOCr2vppu8z1zhd9NOvzDrwbTdU7DM4XoQkJSECuJA/zRzl98OgXKt8EpjJ+IO4dqXBimisi2sCbdfRmrw6OboRIx88qu7sFo6hL1WdUV+yW7Qqqfl/t64yyZ/f4FikInMwoXk9JDoW5z2950LbuppRHllEP5INUsfAW89
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 13:57:33.9124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc550fba-bab5-4534-9a8c-08de89ad4c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

amdgpu_gem_va_ioctl() can call amdgpu_gem_va_update_vm() with
bo_va == NULL for AMDGPU_VA_OP_CLEAR.

CLEAR operates on a VM address range and is not associated with a
specific BO. In this case, the update helper should perform only
VM-level updates and must not access BO-specific fields.

Currently, bo_va may be dereferenced in the MAP/REPLACE handling
paths without explicitly guarding against NULL, which can lead to
a NULL pointer dereference when CLEAR is processed.

Fix this by making amdgpu_gem_va_update_vm() explicitly handle
bo_va == NULL:
- Guard BO-specific accesses with bo_va checks
- Warn if MAP/REPLACE ever reaches the helper with NULL bo_va
- Keep VM update path unchanged for CLEAR

This keeps CLEAR on the common update path while ensuring safe
handling of NULL bo_va.

Crash signature:
[  325.716062] [IGT] amd_bo: executing
[  325.779102] ==================================================================
[  325.786483] BUG: KASAN: null-ptr-deref in amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
[  325.795105] Write of size 4 at addr 0000000000000000 by task amd_bo/7893
[  325.801997]
[  325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1 PREEMPT(voluntary)
[  325.803602] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
[  325.803606] Call Trace:
[  325.803609]  <TASK>
[  325.803612]  dump_stack_lvl+0x64/0x80
[  325.803623]  kasan_report+0xb8/0xf0
[  325.803631]  ? amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
[  325.804427]  kasan_check_range+0x105/0x1b0
[  325.804432]  amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
[  325.805229]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu]
[  325.806022]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
[  325.806815]  ? __pfx___drm_dev_dbg+0x10/0x10 [drm]
[  325.806894]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
[  325.807686]  drm_ioctl_kernel+0x13d/0x2b0 [drm]
[  325.807767]  ? __pfx_file_has_perm+0x10/0x10
[  325.807777]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  325.807857]  drm_ioctl+0x4be/0xae0 [drm]
[  325.807936]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
[  325.808728]  ? __pfx_sock_write_iter+0x10/0x10
[  325.808737]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  325.808816]  ? ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
[  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
[  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0
[  325.808835]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu]
[  325.809622]  __x64_sys_ioctl+0x139/0x1c0
[  325.809630]  do_syscall_64+0x64/0x880
[  325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  325.809645] RIP: 0033:0x7f205fd12e1d
[  325.809650] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[  325.809654] RSP: 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f205fd12e1d
[  325.809663] RDX: 00007ffe9032b5b0 RSI: 00000000c0406448 RDI: 0000000000000006
[  325.809665] RBP: 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e
[  325.809668] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0406448
[  325.809670] R13: 0000000000000006 R14: 0000000000001000 R15: 0000000000000001
[  325.809675]  </TASK>
[  325.809678] ==================================================================

Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b0ba2bdaf43a..145cb222d5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -759,9 +759,15 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	/* For MAP/REPLACE we also need to update the BO mappings. */
+    /* For MAP/REPLACE we also need to update the BO mappings.
+     * CLEAR operates on the VM address range only and can come in with
+     * bo_va == NULL.
+     */
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
+		if (WARN_ON_ONCE(!bo_va))
+			goto error;
+
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
@@ -772,7 +778,8 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	if ((operation == AMDGPU_VA_OP_MAP ||
+	if (bo_va &&
+	    (operation == AMDGPU_VA_OP_MAP ||
 	     operation == AMDGPU_VA_OP_REPLACE) &&
 	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
 
-- 
2.34.1

