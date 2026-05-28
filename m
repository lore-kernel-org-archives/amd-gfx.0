Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD315CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688E910FA39;
	Fri, 29 May 2026 07:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="KVtLvW+H";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE58210F313
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779980463; x=1780585263; i=natalie.vock@gmx.de;
 bh=0KNGuoZlIor7oCypj1V9BMobtf6jjD0Z+BjoRLhLsOc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KVtLvW+H9pQMcYiuoam1vu5TVyovhSvbn1lCZYW8EFSZ1k0mCvHaAxtFIifEIJgu
 N/klOMmRaZQ3yYc8Wg5ZThFRbaS/AHNwXJFJdpfbZMlpSluT3eCElVPTMW9dYwgET
 a53/lC8Qlwd8otqIy7lx2FR9hAPSgrJgrrsucS0r9UWSiWp7lOm9ep10/jmqptOA9
 1B75V5LSPDpfhacARO/tFn79IHtlybdz4GlLsLK6Ip9O6tDa8lylfR8xnKqBmyKj0
 wdhXdqwepBqUMntUZ7yBaKHPjWsaeOm2nsu6cbDDpGmT6OEwYmqDEVYxLBxVsJIYS
 dC2IipZR2mQHVk4bCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1xSrme1nbm-00sJJf; Thu, 28
 May 2026 17:01:02 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
Date: Thu, 28 May 2026 17:00:46 +0200
Message-ID: <20260528150047.78576-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5aJ0JOXY5uybeQFrVS5wtpTRfj0EQP1OCeFWHK2Xcd+TVr297HU
 HZzDVbRvx6AmAclxxJMxvQ5Ojzd/wkY0qZuJPatQzxJ4wU2d3+oy3iTNtp4swiv43MNbjI5
 UBux+avVaV5pFakLlC1cqPojWIcbsqs4uKzVwo4PZN3ogjO/n+27bBV9M7lENQQcavxsVxn
 oa2x/+t/5NN/MCIYvAGyg==
UI-OutboundReport: notjunk:1;M01:P0:Rbge3XAhnF8=;8vO5JzwJc5iK2uJ3MNQ2YW9bLW0
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index beaf0aef6f474..05064a9c9f9f6 100644
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
@@ -2280,6 +2279,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, b=
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

