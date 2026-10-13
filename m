Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0018CC6B18
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9C010F634;
	Tue, 13 Oct 2026 08:49:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBAF10F629
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:49:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D8nc5G972425; Tue, 13 Oct 2026 14:19:38 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D8nc6n972414;
 Tue, 13 Oct 2026 14:19:38 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 03/14] drm/amdgpu: use dedicated SPM VMID from the reserved
 path
Date: Tue, 13 Oct 2026 14:19:26 +0530
Message-Id: <20261013084937.972181-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013084937.972181-1-sunil.khatri@amd.com>
References: <20261013084937.972181-1-sunil.khatri@amd.com>
MIME-Version: 1.0
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

Use the spm vmid which is dedicated for the SPM only and update
the function paths accordingly.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 30 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index ed1efde29a9a5..0eac7695f5587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -551,9 +551,12 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = -ENOENT;
 		goto unlock;
 	}
-	/* Remove from normal round robin handling */
-	id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
-	list_del_init(&id->list);
+	if (!adev->vm_manager.spm_vmid) {
+		r = -ENOENT;
+		goto unlock;
+	}
+
+	id = &id_mgr->ids[adev->vm_manager.spm_vmid];
 	vm->reserved_vmid[vmhub] = id;
 	id_mgr->reserved_vmid = true;
 	mutex_unlock(&id_mgr->lock);
@@ -577,8 +580,6 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_lock(&id_mgr->lock);
 	if (vm->reserved_vmid[vmhub]) {
-		list_add(&vm->reserved_vmid[vmhub]->list,
-			&id_mgr->ids_lru);
 		vm->reserved_vmid[vmhub] = NULL;
 		id_mgr->reserved_vmid = false;
 	}
@@ -628,6 +629,14 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
 			amdgpu_vmid_reset(adev, i, j);
 	}
+
+	/*
+	 * The SPM VMID is not part of the normal kernel pool, reset it
+	 * anyway in case it is used with kernel queues.
+	 */
+	if (adev->vm_manager.spm_vmid)
+		for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)
+			amdgpu_vmid_reset(adev, i, adev->vm_manager.spm_vmid);
 }
 
 /**
@@ -712,6 +721,17 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
 		}
 	}
+
+	/*
+	 * The SPM VMID is not part of the normal kernel pool, create its
+	 * sync anyway in case it is used with kernel queues.
+	 */
+	if (adev->vm_manager.spm_vmid) {
+		unsigned int spm_vmid = adev->vm_manager.spm_vmid;
+
+		for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)
+			amdgpu_sync_create(&adev->vm_manager.id_mgr[i].ids[spm_vmid].active);
+	}
 }
 
 /**
-- 
2.34.1

