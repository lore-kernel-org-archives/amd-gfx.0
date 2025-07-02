Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD99FC83F04
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 13:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6189B10E6F4;
	Wed,  2 Jul 2025 13:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XT/IwiUy";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371D210E70B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 13:03:28 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31308f52248so953051a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jul 2025 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751461408; x=1752066208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ez51sS6qKooXhOf8HwXW9WlfAu/dUMvpaYbmNvkH78M=;
 b=XT/IwiUyRWVkhCpgSBpOU0EJwYH9IQajyTdkA5EaysNldVZ4LhKUBf+zCTcll1vh1k
 OeuSraz1aFtLSBc7KiHk9CcKIYQrl5kqR4Fev32dsumJe6oB9jmC18idKVX2wtqF8t47
 40igY4YDqSSRx3hkw97e5Ah8+KRsazNV/U9NquIIzBBjD0v52mxz3gHr0LXj5JQcSeY+
 x6SY+LuFYyOCY1X5WS9Uqz7sLqoYgFgP2cUmzPpkOdSX1NkIylFU4PaJdCryILRp8rBe
 L6kQ4TEhnj3BaeOUYdJLWk5zmfNkFWhHshgOn89v5gN81VD3g2pcAlJFmJOhjJ5QKR6g
 BUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751461408; x=1752066208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ez51sS6qKooXhOf8HwXW9WlfAu/dUMvpaYbmNvkH78M=;
 b=OYGHuGM/svnb9DyuBHXvB9SYOGX5v+9xD/EornfRntuFa8HCa2t64iyOagWZm4FMIx
 zBQejEj1O2a3zFpPqbD417LyZFd564VCGNGkOWO6DGhS5sMU3b4H1bw5Rb3gkx1kdHJj
 IE3XpcZsKRHkOBB7d1dDwZ7ANlD2GVUkPRn2ZH7ysYK8WPnTgzBXI+1k3yNKQ0LY0XcW
 zTG91ifrUmEBxabGYknP1sLjibC2wEQaSOTe/m1JYyldL09Auh8K1y1Zv4ppM90ESXtf
 NU/1bcDyS+ZTjGS+M9qyggTgD8SRohgQFZcktK1KwgnoloVpyoho05MOvzKXycNkcED6
 jzLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf6nZqJSouSc1M/MVSANbbC8K3pE8bRaJ5vtnwy+u6m8sat1Mwl2quHHBcDM7EjVJmy/bGM95l@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnJyrgVRfGj/wVT0AWU3h1O8qlnAuCPCAR3MLw+PtJX6TCkztk
 34DbDRQn5r3V8BXmu036OJhmb+dIzM6aJdRCSIpC6HrQIQB4RA4nKEh/hZ9VkqJV7PP8RwVz3Zf
 xLsGEAIhDVBBXp7hVkZ3NrvpR9h070O8=
X-Gm-Gg: ASbGncuy0mwZC1oQFLxhprzaFhhE6pJwt6XvdVH0WAplC8dv5gCYrVAogeC33huD6ox
 4ajOzTMW6f5DYCQ+V3O98NK98jGPYr7Ve2fLX8i5ExiBgvdSDzX3iESqOm8jyjOiYy70/ygLnfa
 p6odXQxZ3QgJ8vFccPZQW0+l0HYWxBmYcD4YQD5gMMkFn9SdVkV2fpIEg=
X-Google-Smtp-Source: AGHT+IH0l+tE+O1EduZepyRuvBCm9uEINCTN5La97YRE2/vxZAzzSZd4wvRYIpu4i36pVgiiZEGK2pCBwv1nvMlsgEc=
X-Received: by 2002:a17:90a:d006:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-31a909a79eamr1676747a91.0.1751461407453; Wed, 02 Jul 2025
 06:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250701152538.5832-1-alexander.deucher@amd.com>
 <DM4PR12MB5152D2C3C56C7F0E8F4B54A7E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152D2C3C56C7F0E8F4B54A7E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jul 2025 09:03:15 -0400
X-Gm-Features: Ac12FXx0oPZaq1BMcTVHxBYdmeI1_pKRXRIJJd56sYMekEnJwqhIMA2y9gmZhko
Message-ID: <CADnq5_Nxvf_e3JYOHpQb375kWr9ZW79ybQwdtf97QD+8kK2M3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings
 via debugfs
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Jul 1, 2025 at 10:08=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Tuesday, July 1, 2025 11:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings v=
ia debugfs
>
> We can disable various queues via debugfs for IGT testing, but in doing s=
o, we race with the kernel for VM updates or buffer moves.
>
> Fixes: d2e3961ae371 ("drm/amdgpu: add amdgpu_sdma_sched_mask debugfs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ++++--------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 8b8a04138711c..4f98d4920f5cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -350,9 +350,8 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *ade=
v)  static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> -       u64 i, num_ring;
> +       u64 num_ring;
>         u64 mask =3D 0;
> -       struct amdgpu_ring *ring, *page =3D NULL;
>
>         if (!adev)
>                 return -ENODEV;
> @@ -372,25 +371,9 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *=
data, u64 val)
>
>         if ((val & mask) =3D=3D 0)
>                 return -EINVAL;
> -
> -       for (i =3D 0; i < adev->sdma.num_instances; ++i) {
> -               ring =3D &adev->sdma.instance[i].ring;
> -               if (adev->sdma.has_page_queue)
> -                       page =3D &adev->sdma.instance[i].page;
> -               if (val & BIT_ULL(i * num_ring))
> -                       ring->sched.ready =3D true;
> -               else
> -                       ring->sched.ready =3D false;
>
>
> Is it possible to change the write ring->sched.ready  via WRITE_ONCE or a=
tomic_set to avoid the race?
> And check val to avoid disabling all sdma queues.
>     /* Get current valid mask (reuses _get logic) */
>     ret =3D amdgpu_debugfs_sdma_sched_mask_get(data, current_mask);
>     if (ret)
>         return ret;
>
>     /* Reject invalid masks */
>     if (val & ~current_mask)
>         return -EINVAL;

There are two things we need to handle.
1. The ring used for BO moves and clears:
adev->mman.buffer_funcs_ring
This would need to be changed to a different SDMA ring if the once
currently assigned is disabled or we'd need to fall back to do copies
and clears with the CPU, but that won't work without large BARs.
2. The VM scheduling entities:
vm->immediate
vm->delayed
We'd need to adjust adev->vm_manager.vm_pte_scheds and
adev->vm_manager.vm_pte_num_scheds to reflect what's currently
disabled and then update the drm sched entity.

Alex

> -
> -               if (page) {
> -                       if (val & BIT_ULL(i * num_ring + 1))
> -                               page->sched.ready =3D true;
> -                       else
> -                               page->sched.ready =3D false;
> -               }
> -       }
> -       /* publish sched.ready flag update effective immediately across s=
mp */
> -       smp_rmb();
> +       /* Just return success here. We can't disable any rings otherwise
> +        * we race with vm udpates or buffer ops.
> +        */
>         return 0;
>  }
>
> --
> 2.50.0
>
