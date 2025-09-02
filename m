Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0B1CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F40710E66C;
	Tue,  2 Sep 2025 11:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZiYcDkn";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592C910E66C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:28:37 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3d3ff4a4d6fso1743893f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756812516; x=1757417316; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bEUNJ4HkbdIdtJyNKtzFLMMsN3dmK7hRZ462+FqnOW4=;
 b=OZiYcDknYm7xcTmZgaBOyHS6tiUUW3R852z3ovTy0ty7THYFCQJyt7bYSvpPSuo5z9
 Ct/lJ8F4duclMrZrHlZF7NRH5QzxTO4g1Syn+G+Yz02x1k96PiB86c0i20HpKVjg6oTz
 iQf0ctrEpaDHUBmAuyCGenrp87Wa7Js11TREiJwl0tvlbCk9/RM1SJ4WAMOCXQd/JG6i
 fff6gOdCdUqrLTkys+XTj8SBPE9SVyRHmqKLkmXgaXL4bJLQO7N71qg9eF8Iu4egzBGp
 KfpnU5VrYi7IIN02F9F8EiK3IV9OrEC7lJolevyNQcQWcWRQETvGQR8KKE7XsON6xtod
 vzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756812516; x=1757417316;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEUNJ4HkbdIdtJyNKtzFLMMsN3dmK7hRZ462+FqnOW4=;
 b=U+C1l5/wggIaTYA+l1zBRm+7F56OPAxHH1dynSYGsIQ70hUg7bF3l7m+Su0X0X6zq0
 sWLAJR4CN7wh+DEVTDkrepF1jqsQTzqTkzCE5h2yntXKlZTvmVZkKIkS+osPWaQy2MAw
 Rn6a1kCOBESv+0hja29fy7LPjzhR68M8N+M5QugfovmFtwKeChkBhMw8463Ph7oDGtOL
 2IA3CCDgk2XyOcehwqmNzNu4WjYIH3CTcSMtopU15nLzA9/xpC6Zh9HVgcQqEx9dbzkl
 0R0XL+LjXC0fmO79ehf3lbGnXNU09WserQ7OvkQJecbTFnP/KC1v2qHevdkYwnEpGzW8
 hYmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmC40cG3C1LaFvPSqvBjZlK6gSsfYJxJHAnlA0wnuqBbGTFMnezAkyxyFOKbOELadeA0d0TVUJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6pYvZbrj/rEJ7G457tQjUmNHBrGAQSxPb2U45a+lhRkJo8gwu
 5cVdqchUJPZzcGabguYsqgFIf5UOMbXnqxMcEjI8lnrGqFBrtbTnzRTm
X-Gm-Gg: ASbGncs4inUsaM02JOX5Lba7qWfo27pagcZqaNampGCRgqRQvXTAgHVLwWvkOHEpohH
 SM9yJ8lfdRIBF4kT5igdrAZqIVle39mR6EItlS1nDJ1lIASJVMu6OVAnfcDkxLldHAlbU4Qt3eq
 zqq1UmvG4nd+fnYmfBaTEb7+o8bvTm36wX5i5Jymwxz7qe1oAzvXmfUItHNltpH5Ct2v4lIYjds
 G7NLahKPBhzb5mFbt0lAkIrAVMJaX3FM9prdg4yPYSf5Fm1LhfKEUZkdBhqm46gLNoBd3J9eyAt
 ksgEpyuHota3YEb/JgR2tTMo3MTijtqAVxZmFfz2XrvHia+b9qaxfqjaq3OrLk2XQZpFj4JwUvx
 jPYRvYVjtZmN51u8NJ8tzL6+bvuAIRiKrvggQaQSL7VZaxkaZGDEbLJufqH50toCkpRmRBYozb+
 pUtgdbFuvZfC+RnQB3nXVAPOSx97p5g9u+rLwb3OARk5RSTz+UC9xp1zaCkd35vg==
X-Google-Smtp-Source: AGHT+IFtlyQcdtiXWA203C3gb1DBiG4ulFlvrR8Pqn+BrEPbJBWvYTJhZuXLVOI9g9INs5qZ521IFg==
X-Received: by 2002:a05:6000:420a:b0:3d8:9bf9:7c0b with SMTP id
 ffacd0b85a97d-3d89bf9810fmr4095648f8f.47.1756812515393; 
 Tue, 02 Sep 2025 04:28:35 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add504sm19096541f8f.30.2025.09.02.04.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 04:28:34 -0700 (PDT)
Message-ID: <13e253fc039210ab4fba4e25c473660e499f8c46.camel@gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: Clarify that BO size is in bytes in
 comments
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 13:28:34 +0200
In-Reply-To: <1e04ba11-424a-444d-9bf6-42b78c79c8df@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-2-timur.kristof@gmail.com>
 <b9c170d0-cbab-434c-a781-e0f5d379be83@amd.com>
 <a88429569645421c3659182a256ac38f3181f08b.camel@gmail.com>
 <1e04ba11-424a-444d-9bf6-42b78c79c8df@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-09-02 at 13:10 +0200, Christian K=C3=B6nig wrote:
> On 02.09.25 10:08, Timur Krist=C3=B3f wrote:
> > On Tue, 2025-09-02 at 08:43 +0200, Christian K=C3=B6nig wrote:
> > > On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > > > To avoid confusion with dwords.
> > > >=20
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
> > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > index 122a88294883..9ffadc029ef8 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > @@ -220,7 +220,7 @@ void amdgpu_bo_placement_from_domain(struct
> > > > amdgpu_bo *abo, u32 domain)
> > > > =C2=A0 * amdgpu_bo_create_reserved - create reserved BO for kernel
> > > > use
> > > > =C2=A0 *
> > > > =C2=A0 * @adev: amdgpu device object
> > > > - * @size: size for the new BO
> > > > + * @size: size for the new BO in bytes
> > >=20
> > > That is actually incorrect. The size is in arbitrary units.
> > >=20
> > > For OA and GWS it is the number of HW engines they represent, for
> > > GDS
> > > it is in bytes and for VRAM and GTT it is in bytes but rounded up
> > > to
> > > a page size.
> > >=20
> >=20
> > Can you point me to the part of the code where this is actually
> > determined?
>=20
> See amdgpu_bo_create():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Note that GDS/GWS/OA alloca=
tes 1 page per byte/resource.
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bp->domain & (AMDGPU_GEM_D=
OMAIN_GWS |
> AMDGPU_GEM_DOMAIN_OA)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* GWS and OA don't need any alignment. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page_align =3D bp->byte_align;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 size <<=3D PAGE_SHIFT;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (bp->domain & AMDGPU=
_GEM_DOMAIN_GDS) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Both size and alignment must be a multiple of 4.
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page_align =3D ALIGN(bp->byte_align, 4);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 size =3D ALIGN(size, 4) << PAGE_SHIFT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Memory should be aligned at least to a page size.
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 page_align =3D ALIGN(bp->byte_align, PAGE_SIZE) >>
> PAGE_SHIFT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 size =3D ALIGN(size, PAGE_SIZE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> The GDS/GWS/OA handling here is actually a hack I'm trying to remove
> for years. It's just that GEM/TTM assumes that all BOs are PAGE_SIZE
> based objects and so we have to do this tricky workaround.
>=20
> > If it's that complicated, then I think the function could
> > definitely
> > benefit from more documentation. All I could find was that both
> > ttm_resource::size and drm_gem_object::size are documented to be in
> > bytes.
>=20
> IIRC we have actually documented that quite extensively. I'm just not
> sure of hand where, @Alex?
>=20
> Maybe the UAPI? Probably best to add a reference to that to the
> functions creating a kernel BO.

Thanks Christian.

If this is already documented, then I agree it's best to refer to the
pre-existing docs. I'll do that (once we figure out where it is).

>=20
> Regards,
> Christian.
>=20
> >=20
> >=20
> > >=20
> > > > =C2=A0 * @align: alignment for the new BO
> > > > =C2=A0 * @domain: where to place it
> > > > =C2=A0 * @bo_ptr: used to initialize BOs in structures
> > > > @@ -317,7 +317,7 @@ int amdgpu_bo_create_reserved(struct
> > > > amdgpu_device *adev,
> > > > =C2=A0 * amdgpu_bo_create_kernel - create BO for kernel use
> > > > =C2=A0 *
> > > > =C2=A0 * @adev: amdgpu device object
> > > > - * @size: size for the new BO
> > > > + * @size: size for the new BO in bytes
> > > > =C2=A0 * @align: alignment for the new BO
> > > > =C2=A0 * @domain: where to place it
> > > > =C2=A0 * @bo_ptr:=C2=A0 used to initialize BOs in structures
