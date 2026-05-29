Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1CCD6E5E
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D69112EDF;
	Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="U3f99kvO";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5965A11211D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780068673; x=1780673473; i=natalie.vock@gmx.de;
 bh=HFZfTPMizrvdsPLuqadco6dkFbZelMBMBT3a/lOPspo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=U3f99kvOgblhqjjMp1/zIi0CZguJlJ74CUoe/NfSzaSnXY6l3WRZ4oelLmshlJdR
 JDUsK+pikYrZrWDBuSVIqI01ipLkPG0Q13XHBYk5aJGaVUidUiiajBnWtk7ln0WfR
 vVtu0Zcd4JH2M0Ok10vi2mHcM9JqN/lYqqES0yfJcShLRlu0ijU3/zd08tRKw6kYw
 ek7/OwqlcHLJ0gaqtcg29iyD3Hj4L3d9Gd49EiC/pj3IO643G9PZLlo6N2Uh2hzF3
 4S9xRaH/cUFV+Zw+hh6ix7yDEXKqJiRWFixdFJlOBUn7xRfRyxxVT4wJShAQ/mma+
 2QbVfqiWM8hQ+exsiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1x7DtM1kSz-00eNK7; Fri, 29
 May 2026 17:31:13 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/2] drm/amdgpu: Rename moved state to needs_update
Date: Fri, 29 May 2026 17:30:51 +0200
Message-ID: <20260529153051.973261-2-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529153051.973261-1-natalie.vock@gmx.de>
References: <20260529153051.973261-1-natalie.vock@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Reik4em6DPezVh5jTd9MIm0lY9+25PREV48CtF4B9Bb0/3ryUPJ
 xR1lR4rS0ZJYvZQboMipW0DI83XF4yaVIlCzP/L6X+vxaQbh7xgFJ3Hk+3vaGeEdVdx2cIM
 TKxocWJ1csHMIM2+YM1UMC5irXqBEu+H/sjjoTfxMOVhBJYPhbR0IxwC/AlbRfYmm3EIfHN
 lErPsKdOuZYNnJ7Mym6SQ==
UI-OutboundReport: notjunk:1;M01:P0:p1AgDKUo/QI=;MgDfga1CIU37RwbDC7RZKlUR8Nf
 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
 B1Bd76yRep5jhVetAj1Q81ceg0as7toyJsO5xIH
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 54 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  9 +++--
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 9ddeb984beff7..506268fca901f 100644
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
@@ -211,14 +211,14 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo=
_base *vm_bo)
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 /**
- * amdgpu_vm_bo_moved - vm_bo is moved
+ * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
  *
- * @vm_bo: vm_bo which is moved
+ * @vm_bo: vm_bo which is out of date
  *
- * State for vm_bo objects meaning the underlying BO was moved but the ne=
w
- * location not yet reflected in the page tables.
+ * State for vm_bo objects meaning the underlying BO had mapping changes =
(move, PRT bind/unbind)
+ * but the new location is not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
 {
 	struct amdgpu_vm_bo_status *lists;
 	struct amdgpu_bo *bo =3D vm_bo->bo;
@@ -232,7 +232,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_bas=
e *vm_bo)
 		vm_bo->moved =3D false;
 		list_move(&vm_bo->vm_status, &lists->idle);
 	} else {
-		list_move(&vm_bo->vm_status, &lists->moved);
+		list_move(&vm_bo->vm_status, &lists->needs_update);
 	}
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
@@ -266,11 +266,12 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_ba=
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
@@ -424,7 +425,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *=
base,
 	 */
 	if (bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
-		amdgpu_vm_bo_moved(base);
+		amdgpu_vm_bo_needs_update(base);
 	else
 		amdgpu_vm_bo_evicted(base);
 }
@@ -597,7 +598,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
 		bo_base->moved =3D true;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
=20
 	/*
@@ -615,7 +616,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		bo_base->moved =3D true;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
=20
 	if (!ticket)
@@ -636,7 +637,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		bo_base->moved =3D true;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
=20
 		/* It's a bit inefficient to always jump back to the start, but
 		 * we would need to re-structure the KFD for properly fixing
@@ -970,7 +971,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
=20
 	amdgpu_vm_assert_locked(vm);
=20
-	if (list_empty(&vm->kernel.moved))
+	if (list_empty(&vm->kernel.needs_update))
 		return 0;
=20
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -986,7 +987,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
=20
-	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
+	list_for_each_entry(entry, &vm->kernel.needs_update, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |=3D entry->moved;
=20
@@ -1002,7 +1003,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
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
@@ -1605,7 +1607,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 	bool clear, unlock;
 	int r;
=20
-	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
+	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
 				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
@@ -1614,8 +1616,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
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
@@ -1774,7 +1776,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 		amdgpu_vm_prt_get(adev);
=20
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
-		amdgpu_vm_bo_moved(&bo_va->base);
+		amdgpu_vm_bo_needs_update(&bo_va->base);
=20
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
@@ -2083,7 +2085,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !before->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&before->bo_va->base);
+			amdgpu_vm_bo_needs_update(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
@@ -2098,7 +2100,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !after->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&after->bo_va->base);
+			amdgpu_vm_bo_needs_update(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
@@ -2273,7 +2275,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
ool evicted)
 		if (bo_base->moved)
 			continue;
 		bo_base->moved =3D true;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
 }
=20
@@ -3067,7 +3069,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
seq_file *m,
=20
 	id =3D 0;
 	seq_puts(m, "\tMoved BOs:\n");
-	list_for_each_entry(base, &lists->moved, vm_status) {
+	list_for_each_entry(base, &lists->needs_update, vm_status) {
 		if (!base->bo)
 			continue;
=20
@@ -3076,7 +3078,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
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
index cc096c005e348..2e01a51d5e41a 100644
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

