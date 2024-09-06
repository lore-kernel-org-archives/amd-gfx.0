Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F3CE7B1B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCE510E037;
	Fri,  6 Sep 2024 14:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="avuXU8sK";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D8910E037
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:07:54 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-a8a91c8cdd5so6644666b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725631673; x=1726236473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+z1FhHpV3RVEEnpdmeLHJ2cAcGKM5cp3Uzy7pAwH3c=;
 b=avuXU8sKRryF3uGoGYDI3etBAJo6yeeTRIxVykkoO5TVW+Srhk0S5YVFp6YRSCXwDQ
 A82p3EHO8clhgsewmRTre3ZZ88xrdiePRT5xwyoyPFzmkWOjuSnwi4A53fl5/3Rw6SRs
 LKh2vMrSJFZ6KRhh3hzN9Fb12MGwiI/P8tpaSPYkzH8k4aUwTBxkbcixlByRoPT+gccS
 xjK3tJvrHjOQ/AJXssOvLNhqAJb5RWpVvLaB72R7XhLnqh6LLdrr9VE/JcqrM/lAEHA4
 bdJGZy8OoLyDU4OHDQvZcoAD79vBa7plivSWBNcwcXkp9KO0j8N+migsTnBWRbDwbV5F
 1vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725631673; x=1726236473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+z1FhHpV3RVEEnpdmeLHJ2cAcGKM5cp3Uzy7pAwH3c=;
 b=QNUSdRYaWokO9fNSh3vc53PmQMA+c0AJxFKNwsdgEgj9LY8uScTipgUwwbGYi9reWB
 Ljv2nMSkLi/75bJFl0LJ73rBgBPoVTcSACWckwBKv7RJyW1b/3ZafffKP3iiPdl0Dngy
 m4/zlQu7mspFwdHWIoJQzJDLYkUOyowsKdW0VmRrqnPSgx/9vhTVeRAnWrB25BboyVcL
 t3KXF3kNjJzH3bvGt9Kz7yqTjF00T5+vFi61BVTZfjmpBErMmUe7N6uyWhN8OTnSS4XT
 cqbBIfJ1CfrvcBdT+R8/6t+mVZADmMOg5JxWfnkW+b57+0Z/lh6MIf31J3r1kH6pvnvW
 4eSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf8u4fVG1wv6bkZFbBii2Qpui5mf3/NwfCgP+XMRP6QdM/xhJW6Wf5Q/nVfQ9jpH7/z2fNwb9c@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVCo+1pmnbxVK9Nluho/7st2GoOuoGVjEkHCGWMoclGQfQDu1z
 3WfGke+TFkiNZPs5jlXnMWTNZ1QtJ3tj/qD8TbodoDV2EHeT1Cmr17tUAU9KKao54RCdAgb46TY
 uGKJ4R3n/Usym5huQbsDpPJSiAXc=
X-Google-Smtp-Source: AGHT+IENPMs90SutWH9pFcGMS2KG6j2nLYxhn06Zc65aZbqro6XyaS+cEGMGBPL9TnXEg7znCCzrakO32uxuPsEombw=
X-Received: by 2002:a17:907:3f22:b0:a8a:811e:3fd5 with SMTP id
 a640c23a62f3a-a8a885f95f7mr88357066b.4.1725631672627; Fri, 06 Sep 2024
 07:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240829172645.1678920-1-alexander.deucher@amd.com>
 <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
In-Reply-To: <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 6 Sep 2024 10:07:16 -0400
Message-ID: <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Can you also bump the DRM version, so that userspace knows when to
skip its own clear?

Also, clearing with SDMA takes up to 33 times more time (=3D is up to
97% slower) than clearing with compute.

Marek

On Thu, Aug 29, 2024 at 2:23=E2=80=AFPM Paneer Selvam, Arunpravin
<arunpravin.paneerselvam@amd.com> wrote:
>
> this will fix performance issues,
> Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> On 8/29/2024 10:56 PM, Alex Deucher wrote:
>
> This adds allocation latency, but aligns better with user
> expectations.  The latency should improve with the drm buddy
> clearing patches that Arun has been working on.
>
> In addition this fixes the high CPU spikes seen when doing
> wipe on release.
>
> v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Reviewed-by: Michel D=C3=A4nzer <mdaenzer@redhat.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 1f149c9e2177..8794661b0bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, v=
oid *data,
>   return -EINVAL;
>   }
>
> + /* always clear VRAM */
> + flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;
> +
>   /* create a gem object to contain this object in */
>   if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>      AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
>
>
