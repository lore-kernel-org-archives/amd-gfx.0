Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52072606A33C
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PZdBYGnx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D20610F07E;
	Thu, 19 Nov 2026 18:46:44 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFE710F07E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 18:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIsodSdzCXrtzm9PgIbH0VyfV03j8tX+55CaOMrIOuVYm2nhJf6PMrQ688314bVekjZ1Sha0aR2fXe1eOzmaTr+RccH+TChD1Euft9zTiBkWnipFUr8P82vKjJs00/9TfGioHoMmqAw+o/aB0GPrL9gJz/21ecxa2kvIQ1HfV1f7ajffXdedRhVDwQvZQ+4nkULAILYsOEiQSqXkiHhvQ+y5puX3gAnute2aKHERrbsNIEuRYm0Y9FJHS0/acJJw18BRteWstR5syEmiB/sqr7ZKepoCG+MpjpEPuowPCgUbHANvuEHvh6QE8vVxBBx4LAVT+iUi0NKan7iVWQa1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWYkK/OcI2vEIJ3Mofuf9azRJG32Vf6d5ydOg7koJ48=;
 b=q3Z03327brMZg37yr0PsZ+DbGAsmKFuhL8ga+oEiI8Bvr2yy7YH7luTjauvx9bpsPHQIfIqX+dI7JPJFfoRevC9QfN+g21+uraEs/8w84gN3yEIcB5652QHh8dkk5x50TjVWNhPirfJFROobhGRUh77gAFK88BWw+Rr4HauC0ODNLoWcrM06jPtOa9T0eg/rGv6lzwguHUVhj/zhOdFWMLB4RlZHyKk5gvSfrYbx/dKorJW+2igB/d1itTDBjseOpq8Pcu3BhVLoXNqEv3Gwanmcug7AfSO+cUu28C2vYfk5pQtQk+eWlTVEL62YU0VVn8nuDiFQD/ubJV5NpfqwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWYkK/OcI2vEIJ3Mofuf9azRJG32Vf6d5ydOg7koJ48=;
 b=PZdBYGnxhVgoHva7gqBnKYEzzSYK4KPgrlZLXqQZY/KCT4xL0EVuvaMAVFB58D+CX2zGwtzV2/cAAY6LhP/IMvclQ7yP+a2Q3dr99Ca5nWm5GMXNCFCz+UACWJCfxGxc7H7z8lR7DxrPkE7cWLUBmLmW5CaU9NHWU3xOE59gpBw=
Received: from DSZP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:281::16) by
 IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 18:46:35 +0000
Received: from CY5PEPF00000E7B.namprd02.prod.outlook.com
 (2603:10b6:5:281:cafe::31) by DSZP220CA0018.outlook.office365.com
 (2603:10b6:5:281::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Thu,
 19 Nov 2026 18:46:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E7B.mail.protection.outlook.com (10.167.247.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 18:46:34 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 12:46:30 -0600
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yangp@amd.com>
Subject: [PATCH v3] drm/amdgpu: clear root PT after setting vm->is_npa = true
Date: Thu, 19 Nov 2026 13:46:20 -0500
Message-ID: <20261119184620.1090706-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7B:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: ced76686-63ec-40c0-2f85-08df466d6f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|6133799003|261026121527099003|56012099006|11063799006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|10067099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: vUCb7Tv1XgTF/F2ZiPiVC/wLjYGRgzNcb+K01hCKRss6rU07nxKq/LJsCsapP34cs2JpwvkQ8VuTdQ0+f/z0Gt7bnLw4hf/cPYE3oONKdmhz5T0bu1Mzok3ecTv7MMaNJzitdw/GeILKhM0YqNFlGqp/DwX//ErbueAvX6qdWRjpOqq9CVOpgY0ZlHCZF7tOMcObrjA0FRL7GLfYbTxgugEAEw00895AOFf577ixn2dPGSmkiAnRG7Joy4ItIMhnapBgc0yZ/XTzPrYyKnb7fHDGt9jN961154MYZP4o6YiG0rpEmF4ENCwRNMnRH6c+KLf2Z3CH/+XMy9390HQv/zLrBSYHweOfWdUnXWHtoAAOVSvW1w3W3Z6xhQ9dJUM6NY47nPFp9oDCSFIuzKYPFgUrSEpkKmM2sdUM5dO7mrwVYKUYrRhMFOGX1O6WOsPXlIadMjNFJPjlTO/ettmDYWf3/QQHI1IvK37Rtez8zoBHez0cBvhCg+L/sHwgoIK+kp2TCSpUviIzhpzI+d0IxRLzesaz2OjlpB7ftUXVg5ELCiGTMavFqMIYG9WFb3vfq54mPTuWDfEFbNSBaSl0xoA1k/Wp3INt9ti9DJi6YftE6vP82OIi1tbg0kjOzj89HprrL6zLYNR8t/S8q/maGf2E6Nli35TWAwmoWYGcFyKQpWIMZgUQAqZPjqaMjh40ytkKSNLXvEGkY4y8QjuIig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(6133799003)(261026121527099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: auWOEfYerrUDkEBOoKctftRkwzDU5qO4kNDhtosTOA0zNIf/qd8eiZ4kdx/l7Za7DN3CL72akI9WL2ZOp4v1vIsyTwEUpiPBMf0O4106JlT0vhgs4WBMod35fjR33ZnpwcC9WEbajAJcLVuDefIpx9my+swGYT2+98YHmKauUYGrR4hh5CaA3DW/2sjDEWOmiSRw1LDtFIgt8Sd36z8nqJFoIuWL6UA+hxPjYKUJycmvGsQSz0zC5A7pFGtqK2etn0Awp8FtpIHtjbp4KBZCiT3KkNwkY/IcUmBh4FeW2UeQ/J9AkevbJdOWEVVR478zWHocVGbVcs8BfgcWcTiOyBHP0LsdFe06ZpcSDAmv5Fs3GC1W2qPtsU3ahcsqhwyb3lkLLXMWMx0vcUV8pIk5EyvIYomP6ShZKJ/gqu9gguRCUVllWFi6+66uVm8v6zr+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:46:34.6805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced76686-63ec-40c0-2f85-08df466d6f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E7B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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
break existing mappings.

Remove the redundant second setting of vm->is_npa = true.

v2:
- Add the WARN_ON sanity check regarding an empty VM (Felix)
- Change the return handling to only set vm->is_npa = true upon a
  successful pin (Felix)
- Add the heavy weight TLB flush after the root PT clear (Philip)

v3:
- Remove TLB flush (Felix)
- Move WARN_ON sanity check to start to return early (Christian)
- Reserve fence slots for amdgpu_vm_pt_clear() and amdgpu_bo_pin()
  by replacing amdgpu_bo_reserve with amdgpu_vm_lock_pd()
  (Christian)
- Use goto error handling rather than calling return when applicable

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 36 ++++++++++++++++++++------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..d9e3916feea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2820,23 +2820,43 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
  */
 int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	int r = amdgpu_vm_make_compute(adev, vm);
+	struct drm_exec exec;
+	int r;
 
+	/* Check if VM mappings are empty, clearing would break existing mapping */
+	if (WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root)))
+		return -EINVAL;
+
+	r = amdgpu_vm_make_compute(adev, vm);
 	if (r)
-		return r;
-	vm->is_npa = true;
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
+		goto error;
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto error_unlock;
+	}
+
 	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
-	amdgpu_bo_unreserve(vm->root.bo);
 	if (r)
-		return r;
+		goto error_unlock;
 
 	vm->is_npa = true;
+	r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
+	if (r)
+		goto error_unlock;
+
+	drm_exec_fini(&exec);
 	vm->need_tlb_fence = false;
 
 	return 0;
+
+error_unlock:
+	drm_exec_fini(&exec);
+error:
+	return r;
 }
 
 static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
-- 
2.56.0

