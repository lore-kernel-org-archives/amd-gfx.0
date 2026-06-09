Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7628ECD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA6410E818;
	Wed, 10 Jun 2026 08:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="I6WceBb+";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5BA10E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 15:32:04 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso3035968f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2026 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781019123; x=1781623923;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8s7Qwnb7/jxBSgOlg8nCSNxOUU5XDQ7ABL6iYYnpM8=;
 b=I6WceBb+zMbVDMTx7sVNDyfDMd/8/LN8oSV48iUmUCkNCcbMquaQH9byt/jX7DbTJP
 +4zbE9NFN9ZSOqx6S4LwGkSfk8NByj65K/QtB8O9Z14US10rzDkrwePryQII/TxqG9ZJ
 2Z4VhQJxbiU6woNU+ONdBFcyrjPCNn+KMB4CNRlH1VAeoyoiNIbYhq05+bHYr2fUIiQk
 30ptIfG8mC/QONe9FtiGTRffRWYpRPYQ1o54TCZenqAyEqtfJ49+bIm3vpVXGK1mtONZ
 Vksx9QQm0cXNn9dcP/JO4kDnVhyW6JNYmjdvbdtX0N3tL6WM3g8XYsE86VDymc70meSu
 uvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019123; x=1781623923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8s7Qwnb7/jxBSgOlg8nCSNxOUU5XDQ7ABL6iYYnpM8=;
 b=AQPXmP/lTh8Hh07yK3DaC5oBAPdCv4VweuS7q0kq4meETTQHQilb+hbBG+6aEPET+9
 dbm6d9Vxpr62WAeIoWAtW8uSNeJTSvBFUKlckS3DPnd9SRJ574dJPiBoCuQj0s8P5Ej0
 e/SCwT8ikTiDtaMsigO0LUPIwkM0FaDFtLE0KGeKob/oGgOJCC6CWUQqVkxpn4PHfIM6
 j6CFTK51np/yjk/N2kOENnc6FYgA6RBsz3DqZpm7MjR85BrjX0EKnQOwHZdITdIZVZax
 euXy9IH2N10O+Zhy+UDHtRjyEEMQjoi35M54C+H0rCAopjUuwdUc+d1oog71/EMS8gM4
 3XPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NvtAxmZHF8JO/21kKLa5a6yGwHNlS6aJEJhdeBLHJn6ENnMZC87m9J5YIjt/bsL/Uujz7ptgE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPIwQnLloarwXKG4o3hnjUJ3vb7hhJ0PIboXIJz7Jc5bnTZv6/
 Wr21vjh63QFvBFTf06ESFJSHFTKdF3WNjdW6fmeiI5CcuJcOzdBtKWNE0BZ5ZESrk4I=
X-Gm-Gg: Acq92OERxCFFFe0ZNnH52t3CYjlMi+UkMjSNqZ8wsqcSJTxGa2uvOhEGWVCbV+RBX9d
 ee7ktnkH/RL8B86xwnDLXtZ8LchQWuaP7rly36nKl7Cf7KbPIt8XRjip7ry8QiVlUIYS1ircora
 VZKoNrzKd5lA3RLicKjGH3bt1x9tYgHGOB0CdddtwZxVSIOb4oe9ETtVY6ZjT1LzymdZHmVBuzB
 ZtY0B2jOyoTrK1saDYuSBLBZ4FxjAA8q8BSXde+4r20P81wITJlgQ6y2yUb5VnOhxTQdp1d4v5E
 etPMa/8QttAz2c70OOeuBroaKOUUhIKZI1iiQgdZmBkWuYLxzfg+DfRi3CAd7sDUSdGPPWy8UDJ
 KqozsSu68zam0mLxj8E68PeHUTNZ1kFaCNqu3Y9E1/KrcKR0pL7omRWSl3CSvVfQVuvxHKxNnpY
 uEnd4mEFI3tIdXhtqrjGl+0gKXy9Bs6zVJO6hfpyVvJtgt0aFAcM/x+3eWNejud9j1fxYXAE3qC
 OWmBqIjxfKdEhpRS7WvRrNN6Q==
X-Received: by 2002:a05:6000:4609:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-460323444d8mr28986691f8f.40.1781019123266; 
 Tue, 09 Jun 2026 08:32:03 -0700 (PDT)
Received: from localhost
 (p200300f65f47db045b0dbdd314d8a71f.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:5b0d:bdd3:14d8:a71f])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f344762sm67967138f8f.23.2026.06.09.08.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:32:02 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:32:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Kees Cook <kees@kernel.org>,
 =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
Message-ID: <aigx2xn-59FmGw63@monoceros>
References: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="orjnrmynt4uzf4h5"
Content-Disposition: inline
In-Reply-To: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
X-Mailman-Approved-At: Wed, 10 Jun 2026 08:41:55 +0000
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


--orjnrmynt4uzf4h5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 04:47:03PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
>=20
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect amdgpu_dev_coredump.o.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Is this patch still on someone's radar?

Best regards
Uwe

--orjnrmynt4uzf4h5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooMe0ACgkQj4D7WH0S
/k7C6AgAk5oykrj4mKghFtxQ6MLq7XvvDTtDyq6p1wIJK4mHnUAQbHKuGi0FRi/8
hmCko49bG+cT/A3VenZlq5ELpaPU0ve5+GsOaiGwUJ9LCSvGRRIst42AVcastH8f
ev7B6v5WopQxxY2DUrA+k1MiQSkS+23vNy4bnWq7DnR7Ao4+8NXamZbqluIdp4b+
C0JDIPX+idjM9u5CwJDQyJyluDQiZ2ucc0SplXzocf+qT1+dTKshcYprC4IZa9b9
Aw+mvPDiVzKZWSPtDpgCOGRZrtX5b5cRPzMLT4+A90OeNO0RvxX+KL81GcQg3tOH
miEughCuvcVaS4xTYiILVCgK48uPTg==
=Wrer
-----END PGP SIGNATURE-----

--orjnrmynt4uzf4h5--
