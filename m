Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFBCC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 08:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCC810E0EF;
	Fri,  7 Mar 2025 08:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="E6aySNj1";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E16C10E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741280805; x=1741885605; i=natalie.vock@gmx.de;
 bh=j9W5TGLvqk6m4cXrqBaE1HMLdbn+/qKKXTzhSUZJDwk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E6aySNj1wX4EP+Gh6IfFAmYCkIo9+xcK0g7NEsGrP7RpMrY0k0pDAEgoVhMtmjKd
 uZiSmKxj04sfhIDlHUlajLSI7XubsTZocL8U6tGW+YKRJ6L2ISyrrI6qHx8FHpMON
 QWQROdXFCKs2Gvo8OOjPWeWeneOX96580Ph+Xscxqd0QJsxeCuecAQctK1yB08UMZ
 3VtnDZT4zPn71E9d+67v2OPM7+ep25uByiwfXk9tjKOxyJi38weq7AhfOmeE+43uL
 Tnxc9EwQ8m2mwCwiZSNipgx8M73klv39RMT2GS3Ra5zUHF0pt9alTl1gmGQWLcZpS
 Jp5T0UJiS6iGSvOSgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([109.91.201.165]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIdeX-1u4GxD0s1V-001WHQ; Thu, 06 Mar 2025 18:01:22 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ivan Avdeev <1@provod.gl>
Subject: [PATCH] drm/amdgpu: Allow buffers that don't fit GTT into VRAM
Date: Thu,  6 Mar 2025 18:01:18 +0100
Message-ID: <20250306170118.40238-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JsaQ88HZquaVdbnUHa10QzjlU+mHIn54ye+fuHu6ceSb6SMX/tZ
 FjpT0n+mfW2/G7pT3LCk5B/craPbpUxHmLGAAsK5BGvz2p4EwGc6DBeZIero01U78YHNsS8
 CC9VJQSpiAVfKTfpObQNCfNhBtU8HjmiXWJYJ7ddgoSt2j/C88FFgjbc/4P6LxR/288UirU
 E8C3ThQm2NGyf77PSIS6w==
UI-OutboundReport: notjunk:1;M01:P0:weZ14UVTxCA=;liWwxk/NOFfXd5S2PM+IB+FjK52
 3l9a1d7n/CdQIZCXQhxnj6LJCUGBeyT9bWXTmolKUPXrI3FYE1rWl0ZnCScMy5aUO7yk7a/p+
 B+rpEaK3U70gBeTGCdLge/YRexJKU3X5ZuFiQekBCIcnQtO9mRPenLwgWeoy5e8j1VfNXYSAx
 8B3V1Qebe/D2nvKNns4x4gI9MlyppALYOXdCOARPNQ4hK0wAWAVwgWLxsuKXbKQdgkbFS+C+h
 Uox+iQQ3KdGVdRHeiQZmREkSgGhGyuerbsfNG8l3YHdNoICXCixfd+mWC0EZwZdBCsZPIbCt1
 d8Ueqt9EV7XqjfXX3vdpTij/h46sf7YwfBQyUzRDTYJdaIRAVCzhxRWnPsrk6vDFM63fVY6eN
 E9f4jZMaV8GlwWSgXG5YKcbz4S/3JgOGfCtb0HgF0cafrBHGsjsi6U7wMfPD0MrI/XfTX9xJK
 +jG0fiy2Rg8JPKnwgEagHCS1kCrMYQxQG1u3y9whHh2r5P+OIRUdNdixXnFnimvf5kAG2ktkb
 R37oFP6vJrBvcIK/Wyz2f2+4QD0ED5cD12WbbidAkJZJskT/eBh5xVuSkKYZACmm9jku8lQya
 hpHAgasKDKurGTABCh7vMSIoiNOllYuSbH/PQ+trLjTJfGsSfJIrqbhVegoVQLfuuRjjz7TJg
 6VoucF8KSOSw7NxC4ZqSvZLXqy+QF90w0issLqfPTGOU7FyP0aId2y9X5GsE33OXFPsV66apT
 3SZMmAx9fJF9BBfusqkT+QxEJXuHEfnGfqoql88KrIBs8ddMrUVZ99gJjA2rRKXFrKeHAf9E4
 d1MOCpceQXHsCKgDeyDKT6z0335Dwi0kk+c31sgxuTQc36hpprFIV3K26TC0MFfuhuTdIzz0N
 LGZDHVRnEf/FzBldN8CP2fiKejgbaMxG3BwewOnw+T0zve9Ir3JT3brjzjvYXxxE3nJr2wKfv
 71VIVDxRwCkRBqqk9ic/5/fQi2hHEvfKlXQ2MZeqvwpdHLoa7WdrPsJe50bu2SJoZRmUhkN2L
 9wdQvQmySYhPxJI2bkXuNCzJVJVaCauBg32xvUZJcSDf7j3u0XGPkKQdEeISukFfGQkFfammO
 4SoRvxd4/jd72xMouY/GEcuEllcNOAJnA9uvNGXNBihxXXTNr1bt3n/uZF+tTOPAvc5U0IsJj
 YGbD5aMVmx/Ya4WAZvu1cGBN6DTCXUnrsAE+rhvp2M2jBNcnLw1q9GuIJePWIgU1azb23DFLW
 FXkNQfkO/esD/609H0w+ZBbMofu0yqTFUX0FX9XralEYaCzP123RqN/fOsf0zl5rUQVm4ftGH
 Ik+SF2ShOReI+PmqxBCnEwrYGmTjSai1r2M+S/OQTaulLx9/mN1l7shmPZ+zKjwf06x97Xo/9
 aNUEOpc/Y76mOZyyyCTcrXcoEgCNh+Y4ljfekSKkwTmXZi7Ze2IrucNxNQ
X-Mailman-Approved-At: Fri, 07 Mar 2025 08:50:35 +0000
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

When userspace requests buffers to be placed into GTT | VRAM, it is
requesting the buffer to be placed into either of these domains. If the
buffer fits into VRAM but does not fit into GTT, then let the buffer
reside in VRAM instead of failing allocation entirely.

Reported-by: Ivan Avdeev <1@provod.gl>
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
This originally came up in https://gitlab.freedesktop.org/mesa/mesa/-/issu=
es/12713:
The crux of the issue is that some applications expect they can allocate
buffers up to the size of VRAM - however, some setups have a
smaller-than-VRAM GTT region. RADV always sets VRAM | GTT for all buffer
allocations, so this causes amdgpu to reject the allocation entirely
because it cannot fit into GTT, even though it could fit into VRAM.

In my opinion, this check doesn't make sense: It is completely valid
behavior for the kernel to always keep a VRAM | GTT buffer in VRAM.
The only case where buffers larger than the GTT size are special is that
they cannot be evicted to GTT (or swapped out), but the kernel already
allows VRAM-only buffers to be larger than GTT, and those cannot be
swapped out either. With the check removed, VRAM | GTT buffers larger
than GTT behave exactly like VRAM-only buffers larger than GTT.

The patch adding this check seems to have added it in a v2 - however I
was unable to find any public discussion around the patch with reasoning
in favor of this check.
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_object.c
index d09db052e282d..b5e5fea091bf1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -555,27 +555,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu_de=
vice *adev,
 {
 	struct ttm_resource_manager *man =3D NULL;

-	/*
-	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT.
-	 */
-	if (domain & AMDGPU_GEM_DOMAIN_GTT)
-		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
-		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	else
+	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_=
DOORBELL */
+	if (!(domain & (AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM)))
 		return true;

-	if (!man) {
-		if (domain & AMDGPU_GEM_DOMAIN_GTT)
+	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+		if (size < man->size)
+			return true;
+	}
+	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+		if (!man) {
 			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized")=
;
-		return false;
+			return false;
+		}
+		if (size < man->size)
+			return true;
 	}

-	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_=
DOORBELL */
-	if (size < man->size)
-		return true;
-
 	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->siz=
e);
 	return false;
 }
=2D-
2.48.1

