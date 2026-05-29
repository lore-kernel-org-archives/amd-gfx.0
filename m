Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F83CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C58A112EDE;
	Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="IvqSRAbg";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10767112113
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780068673; x=1780673473; i=natalie.vock@gmx.de;
 bh=ikEiaM+ffzO0bTYOUme0nn9X5RRUKqYEItSN+Ht2+RQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IvqSRAbgz4ZDg09D00JweBQRVSjUR0t9cw12+SrFcSfc2Rizm7uiMt7uojQgl3Nj
 9WTkHA2dPYrxX7YpY7TrYzE/VdNPPipotW3jqQo1fw7G1/TwKPHGrS3V2pwnPPL/a
 Hc09f9hoBYkEjhOmFBrZo3V3rD6fWufuiv6xegMaLE/Z+pkYSgmSI0kqZDWSwj1dH
 0IZYy24sBelTfBjmcqfh2gG8ZeezVBq4dxIMrQa6DzHtZ09r7D1Z9GRNTJ1+K1bK8
 UzpqFLBAt8ujQQDeaWXL4nGEwplsd8iOHaUwIAWfrc1dhF1Nf4mYEnZMt63UD1p49
 Zvn/bTt808Yxo5DEFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1xSCeG0r0D-00saFj; Fri, 29
 May 2026 17:31:13 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
Date: Fri, 29 May 2026 17:30:50 +0200
Message-ID: <20260529153051.973261-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NVlBkdn28Rtb/2bb4ihQ7lbI82cugwBL7ePkD2LbVJiCbDKbipM
 nxJsXv2WNLZxqzw7F/mPj2MvD09FV4NaemGvoDtDCiKRu7vNplaKTsHeXCi17LlhsIgj/zW
 +TQ66qRZGLXJrsQGluvUlKJbIZvz8ENc9UtBpnhu4U9tCx3BQFJrDtIsT7HQTcbwl3q94r3
 62+oFhHI3f2l989eB3t3g==
UI-OutboundReport: notjunk:1;M01:P0:yf+WCIJG8rk=;i1AKKv/SdyKd6WrYI0EzEYq4UHL
 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
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
v2: Move setting of vm_bo->moved out of amdgpu_vm_bo_moved (Christian)
v3: Set moved =3D true in a few more places (Christian)
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index b523a7b97d6f1..9ddeb984beff7 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -232,7 +232,6 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_bas=
e *vm_bo)
 		vm_bo->moved =3D false;
 		list_move(&vm_bo->vm_status, &lists->idle);
 	} else {
-		vm_bo->moved =3D true;
 		list_move(&vm_bo->vm_status, &lists->moved);
 	}
 	amdgpu_vm_bo_unlock_lists(vm_bo);
@@ -597,6 +596,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
+		bo_base->moved =3D true;
 		amdgpu_vm_bo_moved(bo_base);
 	}
=20
@@ -614,6 +614,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
+		bo_base->moved =3D true;
 		amdgpu_vm_bo_moved(bo_base);
 	}
=20
@@ -634,6 +635,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
+		bo_base->moved =3D true;
 		amdgpu_vm_bo_moved(bo_base);
=20
 		/* It's a bit inefficient to always jump back to the start, but
@@ -2270,6 +2272,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
ool evicted)
=20
 		if (bo_base->moved)
 			continue;
+		bo_base->moved =3D true;
 		amdgpu_vm_bo_moved(bo_base);
 	}
 }
=2D-=20
2.54.0

