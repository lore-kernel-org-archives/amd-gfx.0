Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBACCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 22:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C810D10EA61;
	Wed, 27 May 2026 22:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="otPdcT9R";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3477F10EA61
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 22:23:48 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1363f6f7535so195327c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 15:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779920627; cv=none;
 d=google.com; s=arc-20240605;
 b=BYc3VISSbhPBcJImcmSbBXhVtWjLq7xGGAAgfIa0ZgoSUirtqVdw2jSffkmw3kgA2Q
 MzkmfVLqSHJxK6hEwwTmNOaB08EzTgGjsn87jM4qTVt1TfXUptISNstpxu67GbYYKENl
 5mlD752cQ1LsplL7DpYd5l5DJPS1B1Le8EI67TgSrvxY6yaHrzBb29fOeVOD8L2u+okQ
 uZKrKnnHiAP9Q9RK+3tlZplP+iku627FyZLTXZFsIRkyGmypqFZOKI7t6oWD77hDYFge
 z6mgR89UCmUBCKBtTRlag2hUy+njYFXPFsEvyh7Gy/ukyvqU5B6ecGR+c9yOcX9eaOHQ
 oPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2S6T6JFTYfO4qLXMlJbt2H1xShcXzkhXu4IFYF12j+g=;
 fh=CvdlUNhDMQkRf5ohNfelp85qHZugB2BWKycDaFs5YjY=;
 b=UlLz3tI3WUGKYyFIsdGZIhNtDhCOqHaCbl3QaRsHeVH+OoPeZVLoXOitY0D6UeS4XI
 FFSWpvNh1FO2Vbo47GeFMcxDVnfC9Z6YG2YBhrSIIV1aSgnmSBzf3YtXuQpvc45OE6Tq
 XzenVubYDVwQ4wFr7XSrhabL803pl3UOuIdq9xW2wUYiHQn8BuQV+L4hNrI8Zaw8R+zW
 ciJaSH4TzsfD1CnMcS5m6CBl6F13hr7fbpxhEnsAmF44d4HRssMYjYxpm3Kq+2oQt9qy
 2d93UNZSu+GBzsODCyVw+ARllIdBwlgBcTOdZscmCZ8dFHOfnTkCQ/rF+gcJ0gDUPtls
 VqFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779920627; x=1780525427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2S6T6JFTYfO4qLXMlJbt2H1xShcXzkhXu4IFYF12j+g=;
 b=otPdcT9RL1V3yUcvPFlw1haMAL2n6MYZ73rtmGD7oPXPN3xi94KyVKlQfTtfPrZWAK
 0VFy+JQZnIr2v6PCUm3Nca0OmId1l01Pqp3c5ZMORJAxIr/4AEc9Oyb6Un6bWeYg5+Ht
 7Cx8PZIeJoG/t2nDiL3KkMPI1xo4htq4FM2IUImh88y4ZMx7VcleX17u2td+0jTboMc8
 BZWMljSddJK7FprRGyjGYypHx17l1iD4AFnPC5yZQFXt3a/iYd9p5CKJQcCjwoyg2iVO
 65Ytbp2vKHC0QRtZ+FjfhsRKO0gEdKMZMQXtHs7n+bsHTYXYRTGh9a+CO/F0o/3Gn+k0
 n/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779920627; x=1780525427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2S6T6JFTYfO4qLXMlJbt2H1xShcXzkhXu4IFYF12j+g=;
 b=V0PImtFSuVdwW7UsvAbGNbGq+KjTtzh+mVjvC3fCLQaqmW/Orm/cy5HQkc2naaOucv
 yiU/UBFkNvIzlt+1IXvlrTsmUCkSTvWl7CV6P7QpkL8guQo1j9JYXM0MFWitDTpx9hsw
 AwD7Ai3pohhBVVdYZXKtcVHOF/i3sCkmWf6BYb9neJ1jd39HFqlvi+i4aThLjYYx/3pi
 elbL55GkZA6FB+aA0Z9+HdC96EwAzH+xLatwMbfh5OC6nAfdex8JZQHGvnjys8xsOmHY
 u+GfAboBvekFAZ6M1ccTqsUErIhEtGLfr/jlPP8jY/xYALBxaT3dejmfFfMI+z06z1Ol
 CRkA==
X-Gm-Message-State: AOJu0YyejIEJZex/2Fgq0fDvo052tTOgzDqA+EvMVyCRj1mxv8Kddpf4
 +UzTGnwruk1G9AoFofMMKE4Zt7NgQ7I5uR8c2FmvZ+KaPpFFGqlgjxC7DhQepKjpb1gaBbnzYMg
 7tbruvDC9BchUZDVY9GOHFCE5KZZUFm8=
X-Gm-Gg: Acq92OHG633yxO+ITRZJ/ZF4oOyV4TH5oI+pvfwKAy6aF16wJsXdm+sUVH0uRI2jo5E
 bDwr3BzaPgtr9HGLfpA6Xw/SmBwxxCOe5mj7/y3vNYu3O2KoLSkgi6GDzbOpgBbqMa0UJux90Jp
 ylkZmhYt0JDu+vCyXSoGIhbUwP8jyap9+mS1zKfKWaMAWD4FHEs94JnZCbFWSS6ffeaJ44ajM57
 byq5GRToIF/1XdMYPqHVxBCNIDrctpk9EU7pmdkzmRQbcD141N2XafiBptU5ZD7u5AwVmSoHgfs
 PxP6Vbn+q895AxEMebvWTzyVq0i3p8yKYkHKLe3OPyNnD+ink3H1rUO1qtWtlyUqSW31jw0r+Lb
 atys6
X-Received: by 2002:a05:7022:4a4:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-1377cff29f0mr134789c88.7.1779920627323; Wed, 27 May 2026
 15:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260527131931.1133797-1-donettom@linux.ibm.com>
 <10065023.eNJFYEL58v@timur-max>
In-Reply-To: <10065023.eNJFYEL58v@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2026 18:23:35 -0400
X-Gm-Features: AVHnY4IiPtr19XPrsqPNXGQpXZmBriIcQA1zeA_ZnCJ4dvNuy2bkpYEs0byF5Xs
Message-ID: <CADnq5_Ntgzpd_6E=6pgF3zmLSYv=be=baRJCir-JoK+-xSqCZw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K
 page size systems
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, Donet Tom <donettom@linux.ibm.com>,
 David.YatSin@amd.com, 
 Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>, 
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Wed, May 27, 2026 at 10:34=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2026. m=C3=A1jus 27., szerda 15:19:31 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Donet Tom wrote:
> > When mapping VRAM pages into the GART page table,
> > amdgpu_gart_map_vram_range() assumes that the system page size is the
> > same as the GPU page size.
> >
> > On systems with non-4K page sizes, multiple GPU pages can exist within
> > a single CPU page. As a result, the mappings are created incorrectly
> > because fewer page table entries are programmed than required.
> >
> > Fix this by programming the mappings correctly for non-4K page size
> > systems.
> >
> > Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v=
2)")
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > ---
>
> Thank you! The fix looks good to me.
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
>
> > v2 -> v3
> > - Addressed Christian's review comments and added the Reviewed-by tag.
> >
> > v2 -
> > https://lore.kernel.org/all/20260527111750.1084088-1-donettom@linux.ibm=
.com
> > / v1 -
> > https://lore.kernel.org/all/20260522112838.1311531-1-donettom@linux.ibm=
.com
> > / ---
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c index b6f849d51c2e..c4c21dbb=
bdbf
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > @@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct amdgpu_devic=
e
> > *adev, uint64_t pa, uint64_t start_page, uint64_t num_pages,
> >                               uint64_t flags, void *dst)
> >  {
> > -     u32 i, idx;
> > +     u32 i, j, t, idx;
> > +     u64 page_base;
> >
> >       /* The SYSTEM flag indicates the pages aren't in VRAM. */
> >       WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
> > @@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct amdgpu_devi=
ce
> > *adev, uint64_t pa, if (!drm_dev_enter(adev_to_drm(adev), &idx))
> >               return;
> >
> > -     for (i =3D 0; i < num_pages; ++i) {
> > -             amdgpu_gmc_set_pte_pde(adev, dst,
> > -                     start_page + i, pa + AMDGPU_GPU_PAGE_SIZE *
> i, flags);
> > +     page_base =3D pa;
> > +     for (i =3D 0, t =3D 0; i < num_pages; i++) {
> > +             for (j =3D 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++)
> {
> > +                     amdgpu_gmc_set_pte_pde(adev, dst, start_page
> + t, page_base, flags);
> > +                     page_base +=3D AMDGPU_GPU_PAGE_SIZE;
> > +             }
> >       }
> >
> >       drm_dev_exit(idx);
>
>
>
>
