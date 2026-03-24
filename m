Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5588FF532D0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 04:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B6110E1C9;
	Tue, 24 Mar 2026 04:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wBSA2QP8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B769010E01F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 04:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdU4FePnr2T9dXR/tVjWRzmQ6p8fLOAD2Be5UGDXxxQZq8lHJ5+ip5+7onzzP0Mx/w6NO2unNl5oZ7nYs7CRZrAwYERb1XoSixiCi9h6VOXD10KklxtwkX9k1Km+SNLJnds6gw/D0FgEkznkf/tv+SPth1+teDtKVFol8Molxps7i0aE7Mgewa29AmS2grGM/QdSW7BvsEvSs1pXtxRVT1yTf3f0e7DbBlW9tRCUg0CXyHVFXfMEoWskcOQGgJl6PD2WCPL/3FTP5GhZRInkiq7PhDKM4AXAFqxhGk8j7kAlkh+BGguHD7L3zWlMMQwZ/VCevRliOZCIqHO51xgEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpzsSXx9qTWP1wDNcCFhDygEmVG4yI4wHzrg9bZB0wo=;
 b=rDqVB0+9OHGZW+a1/pTuc/eoF2KPNC01aZHiDbgMclfNzezqmtIpbCo5Z8TcchX47Yt6kXpbxb6l/KOClMzNM55TVX0Q7rw8NdQVHvMIu9X4zFv/sRce9poj2dvkfomyrO4DxQN3PGewzWGW1bRqOoPXTzY+KAg5oD9ccTvm8y2nJYw+JB5kQQt341HvEzOGo4W6/8txE0+pKYFMOIH+EHwkCqA+XaKQAAnNuM4b1ghV052/beTkuVUWPzqvAg10ESmQf1rFDFWxafNRqg3gZwhh7TRujwqMAmDkZpwCVKBbgl6d5/77MYZnhP9rbRLcwcHkxp22lADFoltK7n4vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpzsSXx9qTWP1wDNcCFhDygEmVG4yI4wHzrg9bZB0wo=;
 b=wBSA2QP8R8RycPMoa5NKLrMBHJfhwRiGn4Tcwa+IHyhs6SEsYnsNrKz56DgaYqO1sGD/Qr82oq85CaR0+0Qi6sF0jAvTJONprqrMnOScURZtuhx55AfY8qhuTZm3z+L3vF8PTJ5QbDUpM20Kk16OEs7S+ya7Ni9YkqUQuw5yvxo=
Received: from SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::20)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 04:36:37 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::cd) by SA1P222CA0074.outlook.office365.com
 (2603:10b6:806:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 04:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 04:36:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 23:36:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
Date: Tue, 24 Mar 2026 10:06:00 +0530
Message-ID: <20260324043600.2075763-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f05963-d67c-42a0-232a-08de895eef69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BtDOGgrUK9vn1TEZE1CsN/ox+yQCQzH4JncifF7TC39g0O7QdY2ALJEk2teBZfTPW7L+z7WL6SjmfeQnn0fypvWIGJ17YuNiG9LjzhN+M1jGjKfy93OfPQfKt4F6B0N2NC5V4hz1IsIeAeVtmAZbwyzWY8CtH/2JdX2thHnrGTiM+1DurxYzS/Qh5zr+SQrLLxsTmHKrJ3JAv7gFCuIulU6kH2h6h6GNTFnFgHEDhWdFpqUuL/eHzS6qdX5lvCbl6LJV6SfxSn3KjhURPkQ4cUtEiU+jXjakbBTU0g28VV3z/Sr5EQpElI37wqecv2ShERtIbRypOieXvLaKOxcQkc1SFuZGdSlJXtfXxfDhs7v4jnrTR/wAsLqWt1say9B1YLdLTcjNYrmLnuHJBeL3KkywZWdbRZEjq/xzkebvgX3IrnnnkcNz5uwCpXLXQ729ovUQKPoPorlYLpJ5yCGLF8LrD4jTAz+UrQ2YYEBSQskHXF7fQgSEolnXijppAjtja+U7a7QujTm1tHOpRf408QBt/9drTttVsiZHeaKNP48Dy/NkQeMjooTRfZuR9eLR8TivP1LQWAmU87/TrTQk+g1NL1DwQCdLFLpJJtTHkNhPSQv4xERK2Oh2rcRYTHvLg6mIJ5gKkXezGtycTVVgdDuvFrRDBxVT8pAQiuUUhyqafbCWTjQi1DdeAcA/fHX5Nb9ZEPbOrzls/kZXHj/d3LtmJ88U3eymeGWA2VqlRJPmx4dglrEYmNaZtBEEE/mAeFHjIH2bywqpTKJpQc8uvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xxd1Rkad6gwDgeEFE26AVIjOMHr+mHaayOgKrgvrPRvMeLAfCiwKuYZChkQ7irp1u6hRcZs4YrfG59ZzHvjS0R6xjIqOslDvycrHkcEVnj7piok9a/yERa6I02WXL7g3ZpWeowz/yEs4frUPwHXWuJQypqTz85/shi9yoSWX9EdvlgtXN9Wwme8WPW/iBYQT+dIDFYvXuzL2lyt6lPdzMmpRyyCK1Jn4MoyZ0zWyfVmgQOJYmOPDBxrLBn59ySdPIR5xxgZFOSa2KphmaMwD7NSy4oHHZzj+nmZaXFdix3TJLi/Kw2ngt07IH8bO+aAgn6JYz+f79XHK3qnzIIotlgiQaQOtajqHxvzBpuyeAkYcdsMWNlUsEcv40a1Bn5utc9jCH+X6deMEeul4oBaAZnhUlZQ0+G4fCegmMe/DyWkmW26cYI0gbaZXQiRby2bA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:36:36.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f05963-d67c-42a0-232a-08de895eef69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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

amdgpu_gem_va_ioctl() sets bo_va to NULL for VA clear operations,
because CLEAR works on a VM address range and not on a specific BO.

However, the code still calls amdgpu_gem_va_update_vm() with this
NULL bo_va. That helper expects a valid bo_va and dereferences it.

This can lead to a NULL pointer dereference, as seen in amd_bo IGT.

Fix this by skipping the BO-VA update helper for CLEAR operations
and using vm->last_update instead.

Other operations (MAP, UNMAP, REPLACE) are unchanged.

Fixes the below:
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 98276b55ad3c..a07d00f1127b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -967,8 +967,13 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	    (!adev->debug_vm || timeline_syncobj)) {
 		struct dma_fence *fence;
 
-		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-						args->operation);
+		if (args->operation == AMDGPU_VA_OP_CLEAR)
+			fence = dma_fence_get(fpriv->vm.last_update);
+		else
+			fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm,
+							bo_va,
+							args->operation);
+
 		if (timeline_syncobj) {
 			if (!args->vm_timeline_point) {
 				/* Replace the existing fence when no point is given. */
-- 
2.34.1

