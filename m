Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE3DCCF9E3
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Oct 2025 16:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA4B10E29D;
	Sat, 25 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JEOtow9O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CC010E29E
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Oct 2025 16:10:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B1136031C;
 Sat, 25 Oct 2025 16:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA61C4CEF5;
 Sat, 25 Oct 2025 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761408617;
 bh=XH2q5GZrzfVuIRCAT+9nku9R8Fm0t346LvkGNzGgLVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JEOtow9ObNM6ge+gkK8cZXe4TjZWYXDmWoC2vaMWeZ+2RNSm0I7j7bN8vTRba3V+w
 TM3AzEe+heBVvOwvt28JX6ttNFZp08M6ivnKOcx7AZ64c4ecpqZQKTbqH782trDgG+
 RiVys4HlR9rvsSNFiLL0OcW5NpbVb7WNZctJFbyC7vNhxQsv7tTK41UPkeyV1zVEHw
 nLuSdZ3bYlnDJbNRPILYmIVNsC1ihcgO5En8JbDN6Vt4gm2xrCR7JywtgsX+N6xIp+
 w3ocU9By/xZOFr0O39TiDEjIC2Mpk57P31Gf9GZLufUDjFmavy/DrgMaM+1yl6ciuQ
 3DKx20rSctraw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Heng Zhou <Heng.Zhou@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.17-6.12] drm/amdgpu: fix nullptr err of
 vm_handle_moved
Date: Sat, 25 Oct 2025 11:54:18 -0400
Message-ID: <20251025160905.3857885-27-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Heng Zhou <Heng.Zhou@amd.com>

[ Upstream commit 859958a7faefe5b7742b7b8cdbc170713d4bf158 ]

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately before
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
Reviewed-by: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- Bug impact: The commit fixes a real, user-visible NULL pointer
  dereference during KFD process BO restore. In the KFD restore path,
  PRT (partial resident texture) mappings live in `fpriv->prt_va`, which
  is a VM mapping with no backing BO. This mapping can appear in the
  VM’s “moved/invalidated” lists, and `amdgpu_vm_handle_moved()` will
  then dereference `bo_va->base.bo`, causing a NULL deref. Specifically,
  `amdgpu_vm_handle_moved()` dereferences `bo_va->base.bo` in the
  invalidated loop to fetch the reservation object:
  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1608 and
  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1618. That’s unsafe for PRT VA
  since its BO is always NULL.

- Why the bug exists: `fpriv->prt_va` is created with a NULL BO (as
  intended) at drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:1428, which sets
  up a special VA mapping without a BO: it calls `amdgpu_vm_bo_add(adev,
  &fpriv->vm, NULL)`. Consequently, any generic handling that assumes
  `bo_va->base.bo` is non-NULL can crash if the PRT VA ends up in the
  VM’s invalidation or movement queues.

- What the change does: The patch updates the PRT mapping before calling
  the generic VM “handle moved” pass, ensuring the PRT VA is not present
  in those lists when the code that assumes a non-NULL BO runs.
  - Before: In the restore path, after validating PDs/PTs, the code
    directly calls `amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket)`
    for all VMs (drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2992).
  - After: It first derives `fpriv` from the VM, then explicitly updates
    `fpriv->prt_va` with `amdgpu_vm_bo_update(adev, fpriv->prt_va,
    false)` before calling `amdgpu_vm_handle_moved()` (as per the diff).
    This mirrors how command submission already handles PRT VA before
    calling handle_moved (see
    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1149–1191).
  - Rationale: `amdgpu_vm_bo_update()` safely supports `bo_va->base.bo
    == NULL` (PRT case) and moves the mapping’s state to “done” without
    dereferencing a BO, see
    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1245–1390. It uses the VM’s
    fence (`vm->last_update`) instead of a BO fence when `bo == NULL`,
    and it moves the mapping out of the invalidated/moved state via
    `amdgpu_vm_bo_done(&bo_va->base)`.

- Safety and minimality:
  - The fix is small, localized to
    `amdgpu_amdkfd_gpuvm_restore_process_bos()`
    (drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2986–3004 region),
    with no architectural changes.
  - It follows an established pattern already present in the CS path:
    `amdgpu_cs` updates `fpriv->prt_va` before
    `amdgpu_vm_handle_moved()`
    (drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1149–1191).
  - It operates while PD/PTs are already reserved via the DRM
    exec/ticket path, matching the expectations of both
    `amdgpu_vm_bo_update()` and `amdgpu_vm_handle_moved()`.
  - The additional log message changes (`pr_debug` → `dev_dbg` with PID)
    are non-functional and low risk.

- Stable tree criteria:
  - Fixes a real crash (NULL deref), so it’s an important bug fix.
  - Change is small and contained to the AMDGPU KFD restore path.
  - No new features or API changes; no architectural rework.
  - Regression risk is low, because it matches the existing, proven
    sequence used in command submission code.
  - Touches a critical subsystem (AMDGPU), but the pattern is already
    used elsewhere, reducing risk.

- Applicability across stable branches:
  - This is relevant for stable kernels that have the KFD restore path
    structured like the one in your 6.17 workspace (with “Update
    mappings not managed by KFD” and the call to
    `amdgpu_vm_handle_moved()` within
    `amdgpu_amdkfd_gpuvm_restore_process_bos` at
    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2986–3004).
  - Older long-term branches (e.g., 5.4 in your `$CVEKERNELTREE`) have a
    different implementation of the restore path and do not invoke
    `amdgpu_vm_handle_moved()` there (see
    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1952 in that tree).
    For those, this exact backport is not applicable or needed.

Conclusion: This is a correct, minimal, and safe bug fix preventing a
NULL pointer crash in the KFD eviction-restore path and mirrors existing
correct handling in CS paths. It should be backported to stable trees
that have this KFD restore flow.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 902eac2c685f3..30d4a47535882 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2993,9 +2993,22 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		struct amdgpu_device *adev = amdgpu_ttm_adev(
 			peer_vm->root.bo->tbo.bdev);
 
+		struct amdgpu_fpriv *fpriv =
+			container_of(peer_vm, struct amdgpu_fpriv, vm);
+
+		ret = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+		if (ret) {
+			dev_dbg(adev->dev,
+				"Memory eviction: handle PRT moved failed, pid %8d. Try again.\n",
+				pid_nr(process_info->pid));
+			goto validate_map_fail;
+		}
+
 		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
 		if (ret) {
-			pr_debug("Memory eviction: handle moved failed. Try again\n");
+			dev_dbg(adev->dev,
+				"Memory eviction: handle moved failed, pid %8d. Try again.\n",
+				pid_nr(process_info->pid));
 			goto validate_map_fail;
 		}
 	}
-- 
2.51.0

