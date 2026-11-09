Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E1606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DmT0fhoa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A9A10E1F0;
	Mon,  9 Nov 2026 02:24:33 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FA810E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 02:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNaxUfNhwQ6PAosgJ9dQ7MgcTyD7iRil6/IQVOI3nGVVFtF7u91FGTBaY8kt6T8xgoWSTIyevOO1N41kN9Gg+QqgaHd45c07NIK+UYAB3oYkl5Q1LuzLXfuGXjEMr8ZvZyW+zMvOInCJuzrpM3kPK1bI3q69mDXCmFPT3EYv52Q6qqixCEKw6VqZYhHE0L6zHaUEKJ7xBalHGDl96C+X7Vw0Yr6wF/39gR+O7FAG/5jwb5wMj5+wu9FQ9BhExdQBwD1qQdkB5JDNi9QuO+PmD94bfDVKzb7olWLzVGdgWE/0vSRM/8v2mZetOa2a4pk5XbhPKLyDNLQ86z0bjIukxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSA9qJQ5bWSfRrqT74nQ33A+lVKjMLwUDxQbBrexfBY=;
 b=J+NUgKZ3JWPZliAJJWcT3DwUhGVS/p8cgEVOfRFJHNzI54/xttaAJcPPQwKWcIMc2Kk4rQ7bg5dDVqua83Is/A9wRtacYXO9hjw3V7Ci+gv5XAh+cLFMy6Bh4MIUhJ4jYB/DkU+4TtZY2XX7s2AWqRnuHUxZA2OZbzxqEuoNHnKItQWHGmXjs5gw7uuTkiXvQGtqJQStL1J9l/S/tZ77izyJ6juO+nx+V2VgM1NP329lEHtJZYgvBZM23ZeCLZ2l2+WJudc/0Ien4E6R9H8bWelHnFf7h0B0udD9bCmYMN5PwkpTzoqAj3eCcLbsXPVxhBg20LXwD3ojfTouXTmu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSA9qJQ5bWSfRrqT74nQ33A+lVKjMLwUDxQbBrexfBY=;
 b=DmT0fhoaoLPonomAl6F7ZqUvjR4VKur1evTFekMpij+mqgVq36+rYDIrCE+N3zmuuVku6T2dlLvqQiDDpRqEh3NNuLYsYQS3YWBbXKJFHy6s9+vhXFukQ7AtwZaZ4MSa2UjrtDBi3+amNvUSqorzGylYkfpxNJCKV54TUjnMEjk=
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:24:23 +0000
Received: from CH3PEPF0002457C.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::18) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 02:24:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0002457C.mail.protection.outlook.com (10.167.252.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 02:24:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 20:24:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 20:24:21 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 8 Nov 2026 20:24:20 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: don't take a per VM kernel BO for a page table
Date: Mon, 9 Nov 2026 10:23:59 +0800
Message-ID: <20261109022419.2677141-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457C:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce7aea7-7b9d-4ebb-717c-08df3e08911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: b3xiMO3Nwu/2MVmLPW9fTCLu2Cs2Q48et4AC6sRa13qq6P8JVXUqBShy8g+28Zxw8pkdK5c+NTfunMCuG6iLvoa/SD+q914lU4iSnPWGD7wcDIjJjYGwFgst5oNNV/XUOtx2ySVpxSpvFrHOxOFkb42S8UeTMXXB+2qn4Sw8THdCDq/BMs6OFgWoTWhz4qBp/20daiz57h7LKXJDueI/h2OdE2YijpOd00GuDLHd4Skdl8rqEe8FGg+Y4Yc5uF9qpSEzhtZ6F42e17u252KEGgB2vaLLtH0jIorHfr7vtLRr4Pgh9vjOMFTF+4tThs+cahPvO1Hiu+wwxa2ldyMOhR52XiFgkfa1savFjKntmFqaP4tAY+CmATrh/rc/kQnC7X/LD+SDU6XC9iUPrxPhqTbCfGEOfCdO801+T9Uiys5nI3TbxDhhcI9Uo19fPNpnc8UJZ1xu7H6iAgUj0SxswnquviurBtCe0AMDDw+6Phw68h2MBTwFdn9f5Vdw1AMajovVGMTuRwkkUoULhACGGLkkfMp4j6zBTbU2oI2tF6gASY6ePSIY9gjFLrBozdOotZfGOYnG+snpoobVxFaxOaBDIUuTNHy0nXQ5cVFsbvs3WvQlHXMdnOJUkAP0tDHdp6f8x6eZ0/aQOv9Gfxf1o5N49RIF/it58AMsSErBIu4q6y1U1N6j+Vtdb6r0LdD3xMh2VlaMjUH6N7lpOZKWEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sT8gmDcfFpXi+Jr8KszCbLlG9BvvuE+sf69u0ao51ps4RlNc2YyXPSF+9PUscERPKSdO1vDP9mPu/p1pC0bElwTd+bEAo/n4IyCk5YQ4cdS43vQbbXHTsvK9kXAXAbR314xK+GvSwvglm5OmqS0T31QfB/NtLJV0yQGQ2lDDstrIgxgm5BKFDWkle+Pp6mIIl7jq8pd58lbdgMko1I3W3hKQb26mS7qqp0om5blGYT8isxMO51AssDp/hGJqXgqNmqyc8Qlj+FTH0HgY1dDNQtPwS+6IisABhDU+82fzUx//3UiXxMSoFn75Ui35Y54DdoxoaLoda+hbOYl0sW3rX0mKE6qdOpiG+Nz2VeSN6AumvFy3Wj8zSAp2HOyRww3YX17uZ7WyCZAOaykiGYza5yn861HyjidrhQC7AvjKVvsQPx8e5tui2hi5X1eUQULs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:24:22.4487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce7aea7-7b9d-4ebb-717c-08df3e08911b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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

amdgpu_vm_bo_lock_lists() puts every BO which shares the resv of the
root PD and is a ttm_bo_type_kernel BO on the page table lists. The
CWSR TMA BO which amdgpu_cwsr_alloc() creates for every opened render
node is such a BO, so it is treated as a page table: after a VRAM
losing reset its bo_va moves to the page tables needing an update, and
amdgpu_vm_update_pdes() tries to write its PDE. It has no parent page
directory, so that fails, and fails again on every following
submission of the file.

On navi48, submitting on a render node, then amdgpu_gpu_recover and
submitting again, also with a new context:

  amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
  amdgpu 0000:03:00.0: GPU reset(1) succeeded!
  WARNING: amdgpu_vm_pt.c:671 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#0: vmreinit/2629
  Call Trace:
   amdgpu_vm_update_pdes+0x262/0x5e0 [amdgpu]
   amdgpu_cs_ioctl+0x35c9/0x7a00 [amdgpu]
   drm_ioctl_kernel+0x180/0x320 [drm]
   drm_ioctl+0x530/0xcb0 [drm]

and every command submission fails with -EINVAL from then on.

Don't look at the BO type. Give the PDs and PTs, which
amdgpu_bo_create_vm() creates, a destroy function of their own and tell
them by it, like the user and SVM BOs are told by theirs. The TMA BO
stays a kernel BO which userspace can't mmap.

v2: Keep the TMA BO a kernel BO, userspace must not be able to mmap it
    (Christian). Instead let the creator of the vm_bo tell whether it is
    a PD/PT, with a page_table flag in struct amdgpu_vm_bo_base next to
    the other bools, so the struct doesn't grow. Fixes the commit that
    added the TMA BO.
v3: Drop the flag, give the PDs/PTs a destroy function of their own and
    identify them by it, like the user and SVM BOs (Christian).

Fixes: 8a93aae9896b ("drm/amdgpu: Add CWSR infrastructure for user queues")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6aa895f63aea..d4651f2d437c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -71,6 +71,12 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	kvfree(bo);
 }
 
+/* A function of its own, the page tables are told apart by it */
+static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
+{
+	amdgpu_bo_destroy(tbo);
+}
+
 static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
@@ -94,6 +100,7 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 {
 	if (bo->destroy == &amdgpu_bo_destroy ||
+	    bo->destroy == &amdgpu_bo_vm_destroy ||
 	    bo->destroy == &amdgpu_bo_user_destroy ||
 	    bo->destroy == &svm_range_bo_destroy)
 		return true;
@@ -101,6 +108,20 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 	return false;
 }
 
+/**
+ * amdgpu_bo_is_vm_bo - check if the buffer object is a page directory or table
+ * @bo: buffer object to be checked
+ *
+ * Uses the destroy function amdgpu_bo_create_vm() sets for the object.
+ *
+ * Returns:
+ * true if the object is a PD or PT of a VM, false if not.
+ */
+bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo)
+{
+	return bo->tbo.destroy == &amdgpu_bo_vm_destroy;
+}
+
 /**
  * amdgpu_bo_placement_from_domain - set buffer's placement
  * @abo: &amdgpu_bo buffer object whose placement is to be set
@@ -813,6 +834,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	 * num of amdgpu_vm_pt entries.
 	 */
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
+	bp->destroy = &amdgpu_bo_vm_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 2e6a8e6f577a..8e67a8e60572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -254,6 +254,7 @@ static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
 }
 
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
+bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo);
 void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 
 int amdgpu_bo_create(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a2814830dd2b..d5d9e2587661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -162,7 +162,7 @@ amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
 		/* No extra locking needed, protected by the root PD resv lock */
 		amdgpu_vm_assert_locked(vm);
 
-		if (bo->tbo.type == ttm_bo_type_kernel)
+		if (amdgpu_bo_is_vm_bo(bo))
 			return &vm->kernel;
 
 		return &vm->always_valid;
-- 
2.50.1

