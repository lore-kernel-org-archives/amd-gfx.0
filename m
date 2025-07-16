Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E88C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 07:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A75310E71D;
	Thu, 17 Jul 2025 07:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="worHfRV8";
	dkim-atps=neutral
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C3910E667
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 16:18:01 +0000 (UTC)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-4ab5310daedso1346701cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752682680; x=1753287480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ir9Dm1iVDlHTBwvNdOyXbTQs6IQAHDlj1oD0nETDHQY=;
 b=worHfRV8M9G/m4wci5C+ufU5SMdjMlNCVKC4jfsU0ZjDv+kYCDPXP4kuq6RMY0RC2t
 YhGOxii/LQ5NlMXbL6sSTHt+gGNZOeZX22Abfw1/XGGp+QqMD4rCZfW/KSMOfK2b1Y+S
 z1MhUH+hhGEvc9Tgjix4GmgpykUb5NGQL72G3G/ODQr+2rxgbnfJl5BVhqabkcIHBQ23
 8q0qYbVhYA7W9rEPq/smrOAdnASBEogcEPfV1SoiVNn3tkHf760l18ZEGgsXpqT0upN3
 TX2JqR61/rXHCnz4WKuGPiZ+gUJWDPmmnSV28iXowch4aGoc2ndz5EY5XALQGVRdpNiV
 UYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752682680; x=1753287480;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ir9Dm1iVDlHTBwvNdOyXbTQs6IQAHDlj1oD0nETDHQY=;
 b=tFFfKbXyX0/hFuyovzCGai9bFetNWeFAhLGZbLZWsyTWGKJQNHnPxGtHBPXAApKKGJ
 4+X8j5gjLaSf8yGwDG2Fu3IrMvfoX67wrzkOZ5iEiZ0tCm7hAQHoW2snKlWkbTpGPkVA
 F8BGnhPBp/emcIDZ3XBntqLHeScXRQAcn+m21b/8dQDIy8AzIGL8EJQpnX0dntHzukU1
 V7fve14ghlaZM4tyz99t1zlPJx7bumsXKkIVd/KhWdHObSDzAbk9n+2AoVBq80kaVS8d
 7Eflti7aI7W4q9jiHjpyiIUHEZo6y3cjwAk43f8J4SxLD5d2vHkB1TMIRkUNFEHbJ3CQ
 gJeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxlC63rkltADAbmz73bkqQIZtJDlOZjVXABxvJXjB/m4REhJMbfettUy9rgJ2GvtXSaoxftPun@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOjgRMlH797Dvy3bNf2EBNtVIwvhRazbOzt3X3G8EFnYeXi3np
 TC4CBa7yqiRb20HRpDvHEPMTzDmG9468G8PXIKmfzHmctlmeNcdOzGY6LZzFJfvr+nlBgtxsH6p
 Tg7UaFmhYtA==
X-Google-Smtp-Source: AGHT+IG9kv7zcxxXhqHYD61hjoxEfyvcBYEDFuMJtskgL4tPmm+bSRk8+1YujdpUvyDf2JW2/N9qNordXZz0
X-Received: from qts19.prod.google.com ([2002:a05:622a:a913:b0:4aa:bba4:8012])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f0a:0:b0:4ab:6964:7845
 with SMTP id d75a77b69052e-4ab93de8a60mr49263361cf.51.1752682679790; Wed, 16
 Jul 2025 09:17:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 16:17:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716161753.231145-1-bgeffon@google.com>
Subject: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
From: Brian Geffon <bgeffon@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
 Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Jul 2025 07:38:58 +0000
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

Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
allowed for newer ASICs to mix GTT and VRAM, this change also noted that
some older boards, such as Stoney and Carrizo do not support this.
It appears that at least one additional ASIC does not support this which
is Raven.

We observed this issue when migrating a device from a 5.4 to 6.6 kernel
and have confirmed that Raven also needs to be excluded from mixing GTT
and VRAM.

Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1+
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 73403744331a..5d7f13e25b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu=
_device *adev,
 					    uint32_t domain)
 {
 	if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
-	    ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D CHI=
P_STONEY))) {
+	    ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D CHI=
P_STONEY) ||
+	     (adev->asic_type =3D=3D CHIP_RAVEN))) {
 		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
 		if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
 			domain =3D AMDGPU_GEM_DOMAIN_GTT;
--=20
2.50.0.727.gbf7dc18ff4-goog

