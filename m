Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57992606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJJ/10li
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804B410FC53;
	Wed, 28 Oct 2026 13:00:08 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B9310FAD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:48:03 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so297058266b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 02:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180881; cv=none;
 d=google.com; s=arc-20260327;
 b=LcERnvd5aTmy4DfLZKSyEEw9nAPvhBoq/z5fF0iKabERiiNX0zSoRHC2+yqhfp4tkT
 Ch1jy54V3R5P5DUEYSZ8UN7Bfh5v3uZ+k5IVuJLW3DrkhtQFHWCCnk05jlSI+8tUEUVh
 aCOWUF+Ff5HdQSuKHtPEZdQJVdU6FVaaW5hY3W/V+X76VBYDzKP4/t2BM8I/kuwRJB/b
 h0pak60WJpFcArZ+B0sCg8jddrrdDOM62Nszpl3Ltge1i7HJAullopHwSTHXzAj9u5Uq
 90mWUUGOMFkoiDoVI17Fk4ZeMu5ZphPpPBN5vWjFCKz0KcvZvwfsOB9fbsg381se01Pi
 5MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 fh=3fN+tSA1JlVKEOTSjnKW4m8BFk7k5HKEh5i5KtsBtv4=;
 b=QXq+6aAjwYFFcARdrfQoVG4poE9dDtUq+PamUVlAr9W7TLJ5kYySEOoMHXJNmsUXII
 ONYgKWaL99TYFg7oOrKfMWmHFDAfvLw6uIY/2CnYcWD1fuIXqTW+1skbXP87iSP/umqD
 n0Eb4uXBEYvd9Ho9c7ZPdxZ+0jlmKp+TcKc1moEqzwPaTyUYuyfEv9yBvwiynVRmG0wv
 8LQrUYM/YS1vS2y8aWsvgcdUlHDXqDxPm5aHLvgQIxXat3tmPAw2Cbh+59so2j+V26oM
 9ffyTgd5Ldewgbg14FGKKwU1QXz1QU2lTWlL+MB/jeAKL/usrkjqULfV1uPODj0aXFGF
 FiQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 b=TJJ/10liITcaeE8H9+Yv1GLk575lJThMYiulDUHGJlXnyhb2D1SNbVi5EnDB2Kt0tO
 EfHCFnMg4CWPv/CSpnMP61xnFPNYLiKYFGSgiI6p5o5M498TLPHwk/J8PQ0kULTql5ku
 Dz4+2zQxO9KguHfrYnNyBRIkIKGbi6poqqpNQEO7Y853JHiJ+ZV01P55yz5cHuJaw2BA
 Q5zMiS1b3MqgRzMQRTENFLE6+qhvBwzYRH09oArAKSo+4DiFXr445pIjRep3ZgCDS2tA
 2gGjkl3iIaKlbfa3ue4yJKiwvAnglqe0SKvcGejaTMQJZSQDyu2x+cPIOzRhzPfKeZBt
 pfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180881; x=1793785681;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
 b=cnsaTx3u6VLauMAWttO7hqMCPaPXi0pAtSkOVrEZVU8bCQvv+wAc+hKu6EOrV/kG+Y
 Y/xzcxkaSGBOBD+JBK0PJ060pALMTRIBxeCzED2zzeCWjE/dVhBdK3KLnxi6jyYVMm4w
 TgNDXkYApUU9+u4gtVTJFxX94FeRckHoUNWMkXNh8maoRl4ddg8xGHnA6RKSKNV0x4Nm
 uaDWruDry/sb7gpIHX7EECyNv1jGsAowQQUpaW7fyF2VqX/4BzemYnCwjp6NjESC2DUw
 W9s/5vkMPNKl2BD776xRS5H9nDSP71a/Du0SLeCymxGcIinc1DpYgfwQSNKByrlnB7F3
 ODJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8GlGxr8MJeebp+bf5j1HAP2eSo4Tj7sQtpYNKEAso7VOF/Rgc/viNmK6p4Qa4TntkjBREzRKm@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjLq89SszjUb1uUSo1Aejq6CoBQliliyWTYqIoT2xdUxWX7EAJ
 pWB3dWGzS4m0sABITX9aX9uaWkEBvR40l7GO/ztqEoAHmNtS7gxRD1uSQfIaOXMaiGCbdP6/zCN
 KNliD052HZggPgD7O+QUJlgZFqjIsMnw=
X-Gm-Gg: AYBFou1LRJQ4QsmVLad/e5S/2krvzPqVif/KXtP14GFpO3fHIXovzHgf7AlWlK6muxE
 GXMzuWm9AlCtqJCJgJ4Huo1byXWIiIN2gvIQjvCi2uhcBNbYygTw7haBlAMXYCkyGrqZgAKvWJs
 2pKouvcjqg/wGQqnXiXC11QLMkc4WHKE5F6LHIkQCuSKfpv5AZQWGroIPClMeG3CcFQ8BQhDOgh
 iimgBbbBolMRP+ePZMbdAECBc1qiPgG4SidgJN9TNKBaUmk/IFrtyQVXo3em0jYMGxiXA2xaQaR
 r12Pwu1jgti1MRMwmgFur2MS+S3D7AHBT0YwSy6YMHbb9qb/5LzzKxpCXC1NqkGh3CpLn9NHdnJ
 T31nFT5ei2nHnI3BF72tO0ERNdKhWsf0XRkvunRt0R9HUDlLIF6Z4XPXALF1qjT/soIaAKniC17
 3TlEj/xnKn62DDNabsiOPTFr0UcAgaioXbdT6kigRmvdYbhi8+O1UI8FoAkgRbML7c3c2M79eIs
 jDDn6n8qoNA4BSjI739YmzZLQ==
X-Received: by 2002:a17:907:86a5:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c49c6357d34mr69949566b.18.1793180881026; Wed, 28 Oct 2026
 02:48:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:47:24 +0200
X-Gm-Features: AclHuK-8N84O0Y9k-BLOPVpeywTja7886uZe3ugxN4eM-96m__IvC7bzZgS0MkU
Message-ID: <CAHp75Vedr5J1WJMrAkBjRSLKA_zf1kt3GD6UhjzLcy9vowxnaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.
>
> Add spaces after the commas in the __nonnull_args() argument list to
> follow the usual coding style (according to checkpatch).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
