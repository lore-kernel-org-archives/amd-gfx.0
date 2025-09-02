Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E132ECA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8186410E5D1;
	Tue,  2 Sep 2025 08:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="enoth8Vt";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA9710E5D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:08:52 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so2392260f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756800530; x=1757405330; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lDvuH65pe49On7FHzSQlJ/qbMLhVu1A4BxCd7A6OXBQ=;
 b=enoth8Vt0s/AX4QjnkcN54kaxEmTGOT01lXxuUyTDwVLEwVv82EKSR9A41AaTrT6qH
 1bDQQnGOAlhMwgZoHYfqP8ZTnUw9ozoxisjVFSzlCm9f14GzScVq2Zvz8VID0c9WHM5I
 FOYF7DUSyhNe8+ma26qE4UeiYfPmch48uzDOSWfMiIYzbAzHyYsjftErmPoum93lubRE
 lz55ANLZR9ilyeLgiXde3prfH2wJf86r5Xec1Skv8NvXPzIybqeWTTeBcSKjw+8I38Fo
 3h8Mga/CYS9/nnqPQDaDsKhh0Nk9sRVLVIiPlCJlGCNZJCkQe3v2Ru/4F9W6abl1qmM5
 FtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756800530; x=1757405330;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lDvuH65pe49On7FHzSQlJ/qbMLhVu1A4BxCd7A6OXBQ=;
 b=VG/uYxoFPll3xJZqEgozAaqjUO5y4ruj2Q3/x5Kvd1pi85OMjSmpPluFcXbdJEB00d
 swUseYrgM3vjQoQjrbwy1kb3j7cPu0UqfheohwmgQVxaa/z/h9vKjzEoYfFV3SPPVR7X
 HLy+Zl53NEjcgOS9LX/msmnC7I3SmIK9NP8BCM9TzKqYJYD+qB7W3l7dLWN2i0WJABgK
 C2jo/44kst4SWOibQONABKDYuSkCNrG0YO4jEkyHL1o52CIFlLqkNUNNIWk4k3AWBwj0
 AndDKI5SSkff/KHCWDfeQp2lzB118lWa7M5JKvFQBnobmhgLCwQV5V13GCui7O6IpXk2
 R0xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY09DK4spc/qkiuHu1SyfTO9PUWDEsHUXMoznr51qZ1HR8ennQpQNm407KglbaAG0fQecam0zL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDkoDUGsD/KcBNLe95OFNt1QhQlTGTYC0TvTyQJy1cfa1p+dde
 13BX9xjNV+b++4JZm+UFPXQ8Hq4XBVmhG+QnO4tYRo+jqidNPY2HVLv91O5Hpw==
X-Gm-Gg: ASbGncvIzAJedKvRr3T6827cu+uDT70rTka1ZUxXz23+kRSILPfPoG8OQPjof39fm61
 7SpQ9tE0Ux7JXALaSJp22LrRCp0L/Z+VzXPRORHuJIWjbc78qlHzAJs3YjgQBtdOWwg6CLsIUwx
 tGnS4KEpK2ysXSDK96G+Gvlq8u8Hxc5RtqpMjPfuo4ZYlRIREw14f2lRGlD/Bl8Dk9hxG7ginYg
 l667NV60GRhDwno8I9gdBhr0hsYy+6gzYiSiNv1thtGSo/yeq0ypXVxz0m9dMX5ri/aXsp/mfuM
 oJZGd9P1qTUHDrq0KFVv8EKFU4H4s6TtRNFbQpq5fuFZRquuJpqcGJF8nMA+gbfslw48neu86TN
 yaE9Fpsat6oOHGIU9OWSgBpxEnTniRKEUMbCRxeMkcnhtJR4cli48ehKHZE3qRXKDixLlwXp6gc
 tQbbZi/mfQub42E8s6QekAKNQssPdh5TQ9wxTyPh7QNAF6Ehq4FsNGD9CYxAmTMOhH5gP11RDHl
 fWvWLN27ao=
X-Google-Smtp-Source: AGHT+IFJ6KWczu3WEa0xQo9drqJDfCOTIuDMxzijxXuMZjryBDnAs2EjueNkpawGsLs2Aw0TT7RQew==
X-Received: by 2002:a05:6000:2408:b0:3d1:61f0:d264 with SMTP id
 ffacd0b85a97d-3d1e05b8de7mr8606073f8f.54.1756800530482; 
 Tue, 02 Sep 2025 01:08:50 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add504sm18377133f8f.30.2025.09.02.01.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 01:08:50 -0700 (PDT)
Message-ID: <a88429569645421c3659182a256ac38f3181f08b.camel@gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: Clarify that BO size is in bytes in
 comments
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 10:08:49 +0200
In-Reply-To: <b9c170d0-cbab-434c-a781-e0f5d379be83@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-2-timur.kristof@gmail.com>
 <b9c170d0-cbab-434c-a781-e0f5d379be83@amd.com>
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

On Tue, 2025-09-02 at 08:43 +0200, Christian K=C3=B6nig wrote:
> On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > To avoid confusion with dwords.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 122a88294883..9ffadc029ef8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -220,7 +220,7 @@ void amdgpu_bo_placement_from_domain(struct
> > amdgpu_bo *abo, u32 domain)
> > =C2=A0 * amdgpu_bo_create_reserved - create reserved BO for kernel use
> > =C2=A0 *
> > =C2=A0 * @adev: amdgpu device object
> > - * @size: size for the new BO
> > + * @size: size for the new BO in bytes
>=20
> That is actually incorrect. The size is in arbitrary units.
>=20
> For OA and GWS it is the number of HW engines they represent, for GDS
> it is in bytes and for VRAM and GTT it is in bytes but rounded up to
> a page size.
>=20

Can you point me to the part of the code where this is actually
determined?

If it's that complicated, then I think the function could definitely
benefit from more documentation. All I could find was that both
ttm_resource::size and drm_gem_object::size are documented to be in
bytes.


>=20
> > =C2=A0 * @align: alignment for the new BO
> > =C2=A0 * @domain: where to place it
> > =C2=A0 * @bo_ptr: used to initialize BOs in structures
> > @@ -317,7 +317,7 @@ int amdgpu_bo_create_reserved(struct
> > amdgpu_device *adev,
> > =C2=A0 * amdgpu_bo_create_kernel - create BO for kernel use
> > =C2=A0 *
> > =C2=A0 * @adev: amdgpu device object
> > - * @size: size for the new BO
> > + * @size: size for the new BO in bytes
> > =C2=A0 * @align: alignment for the new BO
> > =C2=A0 * @domain: where to place it
> > =C2=A0 * @bo_ptr:=C2=A0 used to initialize BOs in structures
