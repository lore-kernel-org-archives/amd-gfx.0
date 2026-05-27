Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B00CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F76E10ED18;
	Thu, 28 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="SFu5Gb2I";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A2E10E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779899381; x=1780504181; i=natalie.vock@gmx.de;
 bh=sOFqDTPXwDOLjcIlwli44fdutsy4RP/IlKsjRnSTrb4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SFu5Gb2Iqa6ht/U22dW4SwQx31+vGyt3don/mdLkZiebKjyMJD0ehksRRhaKixSJ
 9wQhmYD3PJ0H1DERUP8uuwDCJIb4Myv8adQAAHmw+YdR7q1FN+blI79pyFuaYBfPB
 RwztterJmQLqHVKSe1cIv+ZwMZA/0x5Hsgt1DHk8J6Qsc6qK47J6sXj8sCxYYDfTP
 hNbTTPhmREmusCSS9jSsBcDDh9S1VvEZDKa84/A18LP18FxgQXmVQcyqo3YbIZXN3
 Hbb7wcDM4hVQbhrPTu7hMIGUxiJHQjIwjSWGjg0x9CuPEp/KqCR2djUO2KcI3yBHb
 871kzvgv5/LxpfFGgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1xHuDY2bPp-016zKj; Wed, 27
 May 2026 18:29:41 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Rename moved state to needs_update
Date: Wed, 27 May 2026 18:29:18 +0200
Message-ID: <20260527162918.9585-2-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527162918.9585-1-natalie.vock@gmx.de>
References: <20260527162918.9585-1-natalie.vock@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FPTncFvyhAPA0Wqokg6RqWouJ1g9vYTLHziYghdo4tyX1uvnPdv
 DH26uorTxt2IOB+6D7/ktA14qV0l8nnikAPqEJZq9qGnx1thX7nFbcu7VbC5pP+xvsXAQ1b
 R9SFaes4sLwl0m2dei0yTkRM3MGuA4ASHKFxrygfD36RvU02Q54NuEq3DHsMBGpz3mcBmWQ
 Wcl+kDgJosx9duji0G/iA==
UI-OutboundReport: notjunk:1;M01:P0:ppqXiOJN8DQ=;49Kdm0KtbHyosZwK6RW6UjFlSia
 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
 4KX4QkLNQb6B9U9P2k=
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:41 +0000
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

This state can be reached via other means than physical moves, like PRT
bindings. Make the name match the actual purpose of the state.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 55 ++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  9 +++--
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 969716b3e67e4..36f6c0c36f5e9 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -142,7 +142,7 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *=
vm)
 static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
 {
 	INIT_LIST_HEAD(&lists->evicted);
-	INIT_LIST_HEAD(&lists->moved);
+	INIT_LIST_HEAD(&lists->needs_update);
 	INIT_LIST_HEAD(&lists->idle);
 }
=20
@@ -211,16 +211,17 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo=
_base *vm_bo)
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 /**
- * amdgpu_vm_bo_moved - vm_bo is moved
+ * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
  *
- * @vm_bo: vm_bo which is moved
+ * @vm_bo: vm_bo which is out of date
  * @moved: true if the BO physically changed locations, i.e. all previous
  *         mappings are invalid
  *
- * State for vm_bo objects meaning the underlying BO was moved but the ne=
w
- * location not yet reflected in the page tables.
+ * State for vm_bo objects meaning the underlying BO had mapping changes =
(move, PRT bind/unbind)
+ * but the new location is not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool move=
d)
+static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo,
+				      bool moved)
 {
 	struct amdgpu_vm_bo_status *lists;
 	struct amdgpu_bo *bo =3D vm_bo->bo;
@@ -236,7 +237,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_bas=
e *vm_bo, bool moved)
 	} else {
 		if (moved)
 			vm_bo->moved =3D true;
-		list_move(&vm_bo->vm_status, &lists->moved);
+		list_move(&vm_bo->vm_status, &lists->needs_update);
 	}
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
@@ -270,11 +271,12 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_ba=
se *vm_bo)
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	amdgpu_vm_assert_locked(vm);
-	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
-	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
+	list_splice_init(&vm->kernel.idle, &vm->kernel.needs_update);
+	list_splice_init(&vm->always_valid.idle,
+			 &vm->always_valid.needs_update);
=20
 	spin_lock(&vm->individual_lock);
-	list_splice_init(&vm->individual.idle, &vm->individual.moved);
+	list_splice_init(&vm->individual.idle, &vm->individual.needs_update);
 	spin_unlock(&vm->individual_lock);
 }
=20
@@ -428,7 +430,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *=
base,
 	 */
 	if (bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
-		amdgpu_vm_bo_moved(base, true);
+		amdgpu_vm_bo_needs_update(base, true);
 	else
 		amdgpu_vm_bo_evicted(base);
 }
@@ -600,7 +602,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
-		amdgpu_vm_bo_moved(bo_base, false);
+		amdgpu_vm_bo_needs_update(bo_base, false);
 	}
=20
 	/*
@@ -617,7 +619,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base, false);
+		amdgpu_vm_bo_needs_update(bo_base, false);
 	}
=20
 	if (!ticket)
@@ -637,7 +639,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base, false);
+		amdgpu_vm_bo_needs_update(bo_base, false);
=20
 		/* It's a bit inefficient to always jump back to the start, but
 		 * we would need to re-structure the KFD for properly fixing
@@ -971,7 +973,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
=20
 	amdgpu_vm_assert_locked(vm);
=20
-	if (list_empty(&vm->kernel.moved))
+	if (list_empty(&vm->kernel.needs_update))
 		return 0;
=20
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -987,7 +989,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
=20
-	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
+	list_for_each_entry(entry, &vm->kernel.needs_update, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |=3D entry->moved;
=20
@@ -1003,7 +1005,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
=20
-	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
+	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
+				 vm_status)
 		amdgpu_vm_bo_idle(entry);
=20
 error:
@@ -1616,7 +1619,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 	bool clear, unlock;
 	int r;
=20
-	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
+	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
 				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r =3D amdgpu_vm_bo_update(adev, bo_va, NULL, false, false);
@@ -1625,8 +1628,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 	}
=20
 	spin_lock(&vm->individual_lock);
-	while (!list_empty(&vm->individual.moved)) {
-		bo_va =3D list_first_entry(&vm->individual.moved,
+	while (!list_empty(&vm->individual.needs_update)) {
+		bo_va =3D list_first_entry(&vm->individual.needs_update,
 					 typeof(*bo_va), base.vm_status);
 		resv =3D bo_va->base.bo->tbo.base.resv;
 		spin_unlock(&vm->individual_lock);
@@ -1785,7 +1788,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 		amdgpu_vm_prt_get(adev);
=20
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
-		amdgpu_vm_bo_moved(&bo_va->base, false);
+		amdgpu_vm_bo_needs_update(&bo_va->base, false);
=20
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
@@ -2094,7 +2097,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !before->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&before->bo_va->base, false);
+			amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
 	} else {
 		kfree(before);
 	}
@@ -2109,7 +2112,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !after->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&after->bo_va->base, false);
+			amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
 	} else {
 		kfree(after);
 	}
@@ -2283,7 +2286,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
ool evicted)
=20
 		if (bo_base->moved)
 			continue;
-		amdgpu_vm_bo_moved(bo_base, true);
+		amdgpu_vm_bo_needs_update(bo_base, true);
 	}
 }
=20
@@ -3077,7 +3080,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
seq_file *m,
=20
 	id =3D 0;
 	seq_puts(m, "\tMoved BOs:\n");
-	list_for_each_entry(base, &lists->moved, vm_status) {
+	list_for_each_entry(base, &lists->needs_update, vm_status) {
 		if (!base->bo)
 			continue;
=20
@@ -3086,7 +3089,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
seq_file *m,
=20
 	id =3D 0;
 	seq_puts(m, "\tIdle BOs:\n");
-	list_for_each_entry(base, &lists->moved, vm_status) {
+	list_for_each_entry(base, &lists->needs_update, vm_status) {
 		if (!base->bo)
 			continue;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.h
index d3f3852f1ebae..e6ad79b09042f 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -212,7 +212,8 @@ struct amdgpu_vm_bo_base {
 	 * protected by vm BO being reserved */
 	bool				shared;
=20
-	/* protected by the BO being reserved */
+	/* if the BO was moved and all mappings are invalid
+	 * protected by the BO being reserved */
 	bool				moved;
 };
=20
@@ -220,14 +221,14 @@ struct amdgpu_vm_bo_base {
  * The following status lists contain amdgpu_vm_bo_base objects for
  * either PD/PTs, per VM BOs or BOs with individual resv object.
  *
- * The state transits are: evicted -> moved -> idle
+ * The state transits are: evicted -> needs_update -> idle
  */
 struct amdgpu_vm_bo_status {
 	/* BOs evicted which need to move into place again */
 	struct list_head		evicted;
=20
-	/* BOs which moved but new location hasn't been updated in the PDs/PTs *=
/
-	struct list_head		moved;
+	/* BOs whose mappings changed but PDs/PTs haven't been updated */
+	struct list_head needs_update;
=20
 	/* BOs done with the state machine and need no further action */
 	struct list_head		idle;
=2D-=20
2.54.0

