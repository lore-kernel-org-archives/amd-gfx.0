Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5E606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LAGFP51u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A661125A9;
	Thu, 19 Nov 2026 15:54:37 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0409B1125A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 15:54:32 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-5733c4c1ee3so52762b6e.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 07:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795103671; cv=none;
 d=google.com; s=arc-20260327;
 b=rOBUaf6kdQ9UplJdLr9HFtzlKORRcPWDGHPLi0N6hVGGFHQJB9rYHOokfIVCxegO65
 QA67agGihBP9uK2GjJW3GBFq+W3B8jJMiIo+xj8TfhbZnc9wPixOZOHPxL2xXb3ysrA4
 rIvU1t2hY/JNHy3h38AemtoVYzJZ0B7nrUIdjqLYClvvFxdWMaGFOx/dCKw31qckwcGL
 J8olgH6aI5Q6DyvbMBOpHbAiruilIoYtvTdE4PeeSqZJxRU7MPBBJeOWKDMotBwU9NC5
 zM5Ak8eYUv4X8JvpzPNLu4b0IYT1uXi6s5Zg1qfvzwRN0qyWh+osv5LOn6cCBGyeuLOu
 q0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fVczm6uy7VWgg/ALL5B/7H0RzqhbcPHINkpLoQNoKLY=;
 fh=PKmEbByw3sntl+aZtdSagYyKwlOC/TELxfoDvi/cqnE=;
 b=I0/r/B0u3pyAC99R/yGLEYvTDIY3I4HktBp1LzYHrYZmITjX8Jd6FUEUVXrQkaOy/U
 PEHi3OXQxI42zXuw1oc4UC1vMen21S1DVX/E6eRXHktkuVNLfoV+6prXyBGBpcAQicAE
 fpG7yR/ILIpt5rPp/XzFms5BE+pun9gXFdW5pXcQvqkiLE3PHXdNTW13sKKigA5845Rr
 EG+eXP2K8WlqRinTvv6NeQY+qmzjIqR7ohi1osxs/njVJUJ1dbOYLQT/1MP+BQLAXTNR
 WAa2hKNhFGqMrpaD1Fyb0Qh5JAmtcCa5lslv0ZH8EkshVHBOcbXRS6+BEAa2U3MiZoeA
 9wTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795103671; x=1795708471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fVczm6uy7VWgg/ALL5B/7H0RzqhbcPHINkpLoQNoKLY=;
 b=LAGFP51uK0M6jLVXRXUq3I8VrJRhGUsR/AyGWG21PY49rUrcO2567fWRyWTLLszCn7
 Me/XtqfC3PJ3DURjk4vtfRHzsF9VF/b0edEnQBiDOOBpHI9a/iHRojyTJvsXIYeekTC+
 UYVCETn8RWUSGkTQd0dClVM806XhfIcTBb+tmQ1lWNsDRtBDGrda2bTDxcTrI7nExz/A
 El9kXc+ZvrUHWCZ2qc+lZP5/9QaZOfKx6l0xnLBtDmQ16ee2Z7qG51FyN7JV7BkOR1q1
 00bT2LEYhF+O6vTWG9tE2yS6tL59gOgA3CiBsDLZOx3R3dHZKMCOyjQ2AXcp+nPL2l51
 yaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103671; x=1795708471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fVczm6uy7VWgg/ALL5B/7H0RzqhbcPHINkpLoQNoKLY=;
 b=i4bB+a+kdTlqR4HTxZwiULOECFKllBPEkfblT7NRO9GGtVi9lM9uoUdcFnvg+4zWTb
 wAo68QevNm0GGhEIi01XwMqXB88wnJjkR9GXG2C11uP3QPLCR5E7RTQt6to4QZyqh6UG
 BG4ndpbguCI984dR0xjOw2KlceBpLQ5WsGsXAE9TPxZcA097pcn4ka4hcIZnxAKZFMYK
 hiUz7azEZZ+roy0MJxFWLYGxh4ew6hGQ+GrVd2H9RXKNXU93mNgjpo2EN5GebJmO2IsJ
 9wnGzcSnsJPiwrMFnd3mDVt0KZTj8TiKhDt7mMmJRJsyP59f5atvc6uR7CcevBtPk8U0
 /CVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGBfuRW8G7ZgXaSlGrmuy4g3yUBwsMJ+OiT5qJke+BU7vgfV5Tgl6pEwEy1x3oYSqJTfAmjqOKL@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HfudUb2DXkTgiyqMpcGTB3aly9lYevDNTa1d2WDyBgTSCxP4I
 L+ZAqqLzXmIeHpITKV8UKPyLkwFkpBcf4L5/WwXGgyA1zSsgjKI4KGOjnzFaMsxxOSBzd1Fa4NF
 gkmsx64IH8lG4i7f3XDWU613X3TnXx/k=
X-Gm-Gg: AYBFou2kfxAjT3MsuQIKpNjWQsSwnCneK3Qo+/4tg3TIIPFUXH8gVRJb1z+CocgiCbz
 o53/ZyfblqerrEzoXcGsNBF/iJ72cug9zeIn7PxcxJ0YJeLnO4dgsMr/FFazQDdbOXaTDmqWGKC
 M+zzzZwDxsc27O228/Sne8Sj7Uuv2BXSTZaMePdXlxirSmNJ7wo/7XJmS4AuvnYKIjs8MMjNv8M
 vmKFwhTOLQmk4XLPI9pBGqJCIzTNbMA8XLcFEli2fAuKrxw+UOeJQ1xI5jI8Wz8Aapp6DVb5X3P
 Pw8Pw3EsnX/kW1ez3b7Byi1OBVflmhG0o6KVoaL33w809+jKhrVnjFb73b5AfArlmmul18AZtP5
 XJ5GKYSnMatYeXQCh2y02iBOS+s7iYz1Rnp1+KuvPQCtSjJSVNWIpwHa7a3rjxXHYENTSPcppUH
 v1vhjPFhMGAc7vtBjmZu6aN/0+IIG3ug3/F9JXVtssbuPK3mLlclGcbeoYB/Y=
X-Received: by 2002:a05:6808:1383:b0:549:e9e3:9460 with SMTP id
 5614622812f47-57a025ed532mr615438b6e.0.1795103671053; Thu, 19 Nov 2026
 07:54:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
 <20261119095652.3510341-2-Jesse.Zhang@amd.com>
 <6cd1af3d-4647-4cdf-a351-b65effdfab48@amd.com>
In-Reply-To: <6cd1af3d-4647-4cdf-a351-b65effdfab48@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 10:54:19 -0500
X-Gm-Features: AclHuK-nZj8PUWBHoZPXFCXEovtOV6xhTSK3Qm6mkXJoyGJzHzrY4i_wIMQue7k
Message-ID: <CADnq5_OmSYu9GN=hcXYD4VLztb0BnBG1nGyLANz9v_gX-3GbiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Sunil Khatri <sunil.khatri@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 9:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 11/19/26 10:56, Jesse Zhang wrote:
> > The error path of amdgpu_vm_init() frees the root PD, which clears
> > vm->root.bo, and then unreserves vm->root.bo. On navi48, with an
> > allocation after reserving the root PD failing through failslab while
> > opening the render node:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
dffffc000000005e: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: null-ptr-deref in range [0x00000000000002f0-0x00000000000002f7=
]
> >   RIP: 0010:amdgpu_vm_init+0xa9f/0x1480 [amdgpu]
> >    amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]
> >    drm_file_alloc+0x58f/0xac0 [drm]
> >    drm_open_helper+0x1b3/0x4b0 [drm]
> >
> > Unreserve it through root_bo, which still holds a reference. With this
> > and the entity fix 4842 opens with allocations failing in turn don't
> > oops anymore.
> >
> > Fixes: 8473bfdcb5b1 ("drm/amdgpu: fix error handling in amdgpu_vm_init"=
)
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>
> That is already fixed with:
>
> commit 26401a4999f1596a515b2e704e7066ac09306488
> Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Date:   Wed Oct 7 14:46:57 2026 +0200
>
>     drm/exec: don't immediately add prelocked obj to array of locked objs
>

If this is missing from ASDN, feel free to cherry-pick.

Alex

>
> Regards,
> Christian
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 8cc5964f29c0..272eac0ef317 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2718,8 +2718,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
> >       return 0;
> >
> >  error_free_root:
> > +     /* This clears vm->root.bo, root_bo keeps the BO alive */
> >       amdgpu_vm_pt_free_root(adev, vm);
> > -     amdgpu_bo_unreserve(vm->root.bo);
> > +     amdgpu_bo_unreserve(root_bo);
> >       amdgpu_bo_unref(&root_bo);
> >
> >  error_free_delayed:
>
