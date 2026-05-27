Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D695CD6E53
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AE010ED23;
	Thu, 28 May 2026 07:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="sH2EcK75";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C7C10E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779899381; x=1780504181; i=natalie.vock@gmx.de;
 bh=9MN4wbfYytWDQ+7/ZGMWUPyjjDjXrVbbk5tQjyxUFT4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sH2EcK751Rbr2hk1K3JIRvd5ycr+PmGPqYyYZ3coPZdHsXu2m+HC48HvimOQXxFk
 cp+AEVH7HqEmjs88wK0lBdGq5ZDBKUQqPILClg4LRVu0XjYZ5aE5YSrqkIwgieIdp
 AT++5Dy064GkqjRs4yq83hgtXaYYiJacAF+0lpTVVToWVfss5nBAFSSUZ2EZiciWH
 WUvDTlYKaDpUEMjJIf/FASFB7RNDZFCglnpcFusPRNFwYsWZsO68zaxRIN9Maq41z
 VVEvaZE88i+3DfewJDaGX0oM1tckRIeFIPKIygzUyuE8pk5sWexg9PX+RwA/FGGcP
 iLRTNMGHfSghTLDk0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1x29aV1r38-00mqws; Wed, 27
 May 2026 18:29:41 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Only set bo->moved when the BO was actually
 moved
Date: Wed, 27 May 2026 18:29:17 +0200
Message-ID: <20260527162918.9585-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+att9BKFwOeYguqgSLHfcosHYmjGGHJ1MpOUqi/lOwGoPYvJzAA
 ef70m/8ZH9SBfcNW53u2oeNDBViqeNSfheNZ5ZAdJeFJ8L6j9wDVBk9XctoBzU4wBNVm0hJ
 CqvJQzhNq7OVrnWlC8Kftk0fMxkG7ZHPI+JRvnkH9Kr0eiBYRt0ox8zXDIudxx0jpAsgBhT
 oaKF1gGgBTtyBPcN0osPA==
UI-OutboundReport: notjunk:1;M01:P0:tOJtZjYAMs8=;lze/SsfFLNrIPoKiXs4/vrweJ12
 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
 eIP3UfoALH9CAGnGpk=
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

The "moved" VM state is a bit unfortunately named, because BOs can end
up in this state without being physically moved. While we need to
invalidate every mapping when BOs are physically moved, in some other
cases like PRT binds/unbinds there is no need to refresh mappings except
those affected by the bind.

Full invalidation of all BO mappings manifested as severe regressions in
PRT bind performance, which this patch fixes. The offending patch is
53f0235c0284 ("drm/amdgpu: restructure VM state machine v4") in the
amd-staging-drm-next tree, although it has not yet propagated anywhere
else.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index beaf0aef6f474..969716b3e67e4 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -214,11 +214,13 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo=
_base *vm_bo)
  * amdgpu_vm_bo_moved - vm_bo is moved
  *
  * @vm_bo: vm_bo which is moved
+ * @moved: true if the BO physically changed locations, i.e. all previous
+ *         mappings are invalid
  *
  * State for vm_bo objects meaning the underlying BO was moved but the ne=
w
  * location not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool move=
d)
 {
 	struct amdgpu_vm_bo_status *lists;
 	struct amdgpu_bo *bo =3D vm_bo->bo;
@@ -232,7 +234,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_bas=
e *vm_bo)
 		vm_bo->moved =3D false;
 		list_move(&vm_bo->vm_status, &lists->idle);
 	} else {
-		vm_bo->moved =3D true;
+		if (moved)
+			vm_bo->moved =3D true;
 		list_move(&vm_bo->vm_status, &lists->moved);
 	}
 	amdgpu_vm_bo_unlock_lists(vm_bo);
@@ -425,7 +428,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *=
base,
 	 */
 	if (bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
-		amdgpu_vm_bo_moved(base);
+		amdgpu_vm_bo_moved(base, true);
 	else
 		amdgpu_vm_bo_evicted(base);
 }
@@ -597,7 +600,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_moved(bo_base, false);
 	}
=20
 	/*
@@ -614,7 +617,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_moved(bo_base, false);
 	}
=20
 	if (!ticket)
@@ -634,7 +637,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_moved(bo_base, false);
=20
 		/* It's a bit inefficient to always jump back to the start, but
 		 * we would need to re-structure the KFD for properly fixing
@@ -1782,7 +1785,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 		amdgpu_vm_prt_get(adev);
=20
 	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
-		amdgpu_vm_bo_moved(&bo_va->base);
+		amdgpu_vm_bo_moved(&bo_va->base, false);
=20
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
@@ -2091,7 +2094,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !before->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&before->bo_va->base);
+			amdgpu_vm_bo_moved(&before->bo_va->base, false);
 	} else {
 		kfree(before);
 	}
@@ -2106,7 +2109,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device=
 *adev,
=20
 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !after->bo_va->base.moved)
-			amdgpu_vm_bo_moved(&after->bo_va->base);
+			amdgpu_vm_bo_moved(&after->bo_va->base, false);
 	} else {
 		kfree(after);
 	}
@@ -2280,7 +2283,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
ool evicted)
=20
 		if (bo_base->moved)
 			continue;
-		amdgpu_vm_bo_moved(bo_base);
+		amdgpu_vm_bo_moved(bo_base, true);
 	}
 }
=20
=2D-=20
2.54.0

