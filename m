Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C1BC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7581510F20F;
	Thu,  2 Jul 2026 08:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="j240Lp46";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AB010EF04
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782905638; x=1783510438; i=natalie.vock@gmx.de;
 bh=0G5IKpbt84pxHoOIL9jbgJa+SVs+TmfkWyCjKYKWuXc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j240Lp46wiAUHTa3WPRoN9Yf3xp44wmPWVElwL6cVNstYW3IvbqEE8Q+/IN9QRdt
 D1mhsJYAhcZGHsJExeEGmQkhhuQ0UMR7DPVn2Ni/cCa02b+pbYIm+aUIfUGKyaL4g
 a+LuA1XpNMFG19OowqeTz0KpzeQTjyJAUUOzlwThosNqxd0Ywpvv/pkdyJNvZH1O4
 EV2rFJETSYxRVCDTzhGE3n2IN1rMND2sXunprhcFBZ82KTnciEHwH1tCurbso0qwA
 GvPFzjnev3W+QFG609reA8mpqdWKZFgKZ1IPKMfwq8TH6qe5psUndAH/iUe4O+GEt
 5drRyEPMuAryo9EP+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1wnecw1ltQ-003JIw; Wed, 01
 Jul 2026 13:33:58 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Remove superfluous re-validation of CS BOs
Date: Wed,  1 Jul 2026 13:33:40 +0200
Message-ID: <20260701113340.466177-2-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701113340.466177-1-natalie.vock@gmx.de>
References: <20260701113340.466177-1-natalie.vock@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:goKYSA1Ixhd+NpSgs1hx/6ePvm5TFIe5YofKNid9xPgN9oNfbwA
 G7X9Gek1GFEi8+nD+0Dkq84OdGzg+MbFnF33sSPlFlGazWc3m4xTvThdtxDtgTFKfWXXOgZ
 ej8d6xzZoUMSTOOJMvYReRzhvxMakK4a2f8OmRqiceERPY62dVRWIP435nQ8ZuggSCjzg+T
 FfZWR3pogj8UZ0TdTWBHg==
UI-OutboundReport: notjunk:1;M01:P0:m6/0ZjLgaZI=;NTYMijoH/5QAI3mtzng2Iao9vhk
 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
X-Mailman-Approved-At: Thu, 02 Jul 2026 08:07:22 +0000
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

The root cause of the mentioned test regressions was a sync issue due to
missing/wrong locking of VM status-related fields. It is fixed now, so
the FIXME can go.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_cs.c
index 6e5db173f6462..4c72162ec331e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1139,26 +1139,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
 			return r;
 	}
=20
-	/* FIXME: In theory this loop shouldn't be needed any more when
-	 * amdgpu_vm_handle_moved handles all moved BOs that are reserved
-	 * with p->ticket. But removing it caused test regressions, so I'm
-	 * leaving it here for now.
-	 */
-	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
-		bo_va =3D e->bo_va;
-		if (bo_va =3D=3D NULL)
-			continue;
-
-		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
-		if (r)
-			return r;
-
-		r =3D amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
-				      GFP_KERNEL);
-		if (r)
-			return r;
-	}
-
 	r =3D amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
 	if (r)
 		return r;
=2D-=20
2.54.0

