Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEDCD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906DA10FA3F;
	Fri, 29 May 2026 07:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="kRMTP41I";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6656410F300
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779980463; x=1780585263; i=natalie.vock@gmx.de;
 bh=vfjbRckWTF4qCcIcmISDDQROqglYqdHnyMblnobInRE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kRMTP41ITlyZOTPzYugstzI+a4dLXzT5zu2dkuT3EW9YJ8MLeO5+c0rRb7kcr/XA
 tJUWzvbTkdhc6tQSQClZs6RRx9mUo6yT4pAIHUk4hhLWCvCXYAY4LWThJv1MN1SUz
 RftIEs3g3txHRdiP0UgzujMBv/145OpwaGgrZAivczXA5n7ZoMY1Y0GP8R6rc7/aB
 MokR4oMHgtQLqE5kzG11vWTafJ5L2xvw4PIeGL/Y1JKWcpq+b5WlvnFd7619jZ8br
 k4VszCq1Ohre7BSMU1RBl2DykN+RzcQy+jCQ/6TsUiu5nUY5BGCJo388nx/7Tz+b1
 bk/vWVws+3iuNf8IVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1wh6qZ2giL-00VPAG; Thu, 28
 May 2026 17:01:02 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: Rename moved state to needs_update
Date: Thu, 28 May 2026 17:00:47 +0200
Message-ID: <20260528150047.78576-2-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528150047.78576-1-natalie.vock@gmx.de>
References: <20260528150047.78576-1-natalie.vock@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BAUqLHG5dc6A/fPQg0sZ6krI1MN5MbAzzEl1Ua3ohPTO29oep+r
 muLy7oM9M2fLcBWdrQJ9mHuTxU65YP0hUKiPZflucBk30EKuVNB/kOEHJsA2W0dXBZEPDFg
 ltwY/U2czp9NHOAa/55w+Y9Y5NF+DQq0+EIOWc8SUpoOjbgIhfsUz25uNLt5wsze7zPPs+X
 G8YZl0BByKLlYP+XskrAg==
UI-OutboundReport: notjunk:1;M01:P0:INA9GKZw6UU=;9UV5z1aKoS/Vz4+BpbZxCpFLa9j
 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
X-Mailman-Approved-At: Fri, 29 May 2026 07:44:33 +0000
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
index 05064a9c9f9f6..420d97a50ef2d 100644
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
@@ -596,7 +597,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
=20
 	/*
@@ -613,7 +614,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
=20
 	if (!ticket)
@@ -633,7 +634,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
=20
 		/* It's a bit inefficient to always jump back to the start, but
 		 * we would need to re-structure the KFD for properly fixing
@@ -967,7 +968,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
=20
 	amdgpu_vm_assert_locked(vm);
=20
-	if (list_empty(&vm->kernel.moved))
+	if (list_empty(&vm->kernel.needs_update))
 		return 0;
=20
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -983,7 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
=20
-	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
+	list_for_each_entry(entry, &vm->kernel.needs_update, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |=3D entry->moved;
=20
@@ -999,7 +1000,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
=20
-	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
+	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
+				 vm_status)
 		amdgpu_vm_bo_idle(entry);
=20
 error:
@@ -1612,7 +1614,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
v,
 	bool clear, unlock;
 	int r;
=20
-	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
+	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
 				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r =3D amdgpu_vm_bo_update(adev, bo_va, NULL, false, false);
@@ -1621,8 +1623,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ade=
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
@@ -1781,7 +1783,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 		amdgpu_vm_prt_get(adev);
=20
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
-		amdgpu_vm_bo_moved(&bo_va->base);
+		amdgpu_vm_bo_needs_update(&bo_va->base);
=20
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
@@ -2090,7 +2092,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !before->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&before->bo_va->base);
+			amdgpu_vm_bo_needs_update(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
@@ -2105,7 +2107,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !after->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&after->bo_va->base);
+			amdgpu_vm_bo_needs_update(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
@@ -2280,7 +2282,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
ool evicted)
 		if (bo_base->moved)
 			continue;
 		bo_base->moved =3D true;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base);
 	}
 }
=20
@@ -3074,7 +3076,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
seq_file *m,
=20
 	id =3D 0;
 	seq_puts(m, "\tMoved BOs:\n");
-	list_for_each_entry(base, &lists->moved, vm_status) {
+	list_for_each_entry(base, &lists->needs_update, vm_status) {
 		if (!base->bo)
 			continue;
=20
@@ -3083,7 +3085,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct =
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

