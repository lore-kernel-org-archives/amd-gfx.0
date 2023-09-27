Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19956E82CA1
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 15:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7835410E52E;
	Wed, 27 Sep 2023 15:13:44 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE24610E52E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 15:13:42 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3af5b5d7e9eso663622b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695827622; x=1696432422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTDxkNd9D/FOBFvLz/4Nl9ANW0Vpi83tRcj5kr3YqfM=;
 b=mfjL0x7n1dSwy1v/Wy3XAMtQn3A8uORZMvS9ttWhH2lYuUKmZANuhkBJjPr+K3dMc6
 lEYYwtSXXcwbAXALUl3EV6KyOmDxHL2o1EbTv8ldRSKxdZzqaQi3Dzb7JI8PtoGietEz
 uQXx2MVRiOWKlLC/RMWzQyrFNljWr4NOoZu25gy/A9ojc2kkHB+v6SCdv7uhRMRpheyI
 cGGtbQ1HzWcFvtfolzgFt/CuYy/KQWSt7KKSMwYmii0jkUBy5vo0H4w2dgIbMj9/I6py
 FOt5vekCkzHWts/tnTYjbm6XL3wcyjRrj+Ihkjw7QiQy9RSfbbmO3VWcEZf4MF5c3SSw
 56ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827622; x=1696432422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTDxkNd9D/FOBFvLz/4Nl9ANW0Vpi83tRcj5kr3YqfM=;
 b=TniIEKhVT7iz67EaQXQU4w5aorghQ7qbMvUMelITgIyPZ+DTpX/F3CrC/cKcxFXkPe
 X8fdWzftQFBFVqI3/Y15HH9o7IStKqvybXzIf0hm3Pov7h16uiqpoBaL2XTGNUP2LMBu
 HBEy6eTdEaTkre7Eb+p3yfCc+j1Ypn1pM3Zc6fU8fvEvrZFzH7jFHD7SQKsOHnM1S9bA
 BTzdVoa8KVXAYMr6JDDLLYfGbuaaKh902eCq7KpP6+BwhwVLUJ9MKn0UwPcw5yFBJu5Y
 MswDvUUi2LQOOIBd+sInRAkImUZ/lTyclIDPBpUy4G2X71FsB2pAGDmH6eIkNCOvSOnI
 ejOw==
X-Gm-Message-State: AOJu0YyFcP32Bv/qj4oBtJoGh92U6drNZvViCiNXkDG+JEat4RsomIJe
 +MvWld/3G2Mz3UOivADqnr4jfK0qNa2L21bM/mI=
X-Google-Smtp-Source: AGHT+IEY6SRYC3wR4L1bNrQjIvFwhTbmVNXLqQTmOUgpuhsDyk6+osdLBIoWib8Q0xpRiRvX1Yz4ZMZ4UEbfUYM5+f8=
X-Received: by 2002:a05:6870:64ac:b0:1b0:80d0:b895 with SMTP id
 cz44-20020a05687064ac00b001b080d0b895mr2816468oab.12.1695827621920; Wed, 27
 Sep 2023 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230921214019.926691-1-alexander.deucher@amd.com>
 <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
 <2ad761b8-7228-7a00-4514-45464be549f2@gmail.com>
In-Reply-To: <2ad761b8-7228-7a00-4514-45464be549f2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Sep 2023 11:13:30 -0400
Message-ID: <CADnq5_O1sdzUXAog6RLjp00+GB30Zg5M=TQm+nAhdF2Bx4AZWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 27, 2023 at 1:37=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I'm still not happy with moving the GART fixed to the end. We abandoned
> this for good reasons.

We didn't abandon it, there is still code which decides where to put
the gart based on the relative sizes of the address space before and
after vram.  It really comes down to where the vbios decides to put
vram.  If it starts somewhere lower in the future, gart will naturally
end up higher.  Also windows always puts gart above vram.

>
> If we really go this way I would prefer to have this as parameter to the
> amdgpu_gmc_gart_location() function and not in the gmc structure.

I can do that.

Alex

>
> Regards,
> Christian.
>
> Am 26.09.23 um 19:30 schrieb Alex Deucher:
> > Ping on this series?
> >
> > On Thu, Sep 21, 2023 at 5:46=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >> We normally place GART based on the location of VRAM and the
> >> available address space around that, but provide an option
> >> to force a particular location for hardware that needs it.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  8 ++++++++
> >>   2 files changed, 23 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c
> >> index f74a51a93ebb..d1d98488373b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> @@ -287,11 +287,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_devi=
ce *adev, struct amdgpu_gmc *mc)
> >>                  mc->gart_size =3D max(size_bf, size_af);
> >>          }
> >>
> >> -       if ((size_bf >=3D mc->gart_size && size_bf < size_af) ||
> >> -           (size_af < mc->gart_size))
> >> -               mc->gart_start =3D 0;
> >> -       else
> >> +       switch (mc->gart_placement) {
> >> +       case AMDGPU_GART_PLACEMENT_HIGH:
> >>                  mc->gart_start =3D max_mc_address - mc->gart_size + 1=
;
> >> +               break;
> >> +       case AMDGPU_GART_PLACEMENT_LOW:
> >> +               mc->gart_start =3D 0;
> >> +               break;
> >> +       case AMDGPU_GART_PLACEMENT_BEST_FIT:
> >> +       default:
> >> +               if ((size_bf >=3D mc->gart_size && size_bf < size_af) =
||
> >> +                   (size_af < mc->gart_size))
> >> +                       mc->gart_start =3D 0;
> >> +               else
> >> +                       mc->gart_start =3D max_mc_address - mc->gart_s=
ize + 1;
> >> +               break;
> >> +       }
> >>
> >>          mc->gart_start &=3D ~(four_gb - 1);
> >>          mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h
> >> index dd0ede75e5d7..fcef057b9213 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >> @@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
> >>
> >>   #define INVALID_PFN    -1
> >>
> >> +enum amdgpu_gart_placement {
> >> +       AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
> >> +       AMDGPU_GART_PLACEMENT_HIGH,
> >> +       AMDGPU_GART_PLACEMENT_LOW,
> >> +};
> >> +
> >>   struct amdgpu_gmc {
> >>          /* FB's physical address in MMIO space (for CPU to
> >>           * map FB). This is different compared to the agp/
> >> @@ -339,6 +345,8 @@ struct amdgpu_gmc {
> >>          bool flush_tlb_needs_extra_type_0;
> >>          bool flush_tlb_needs_extra_type_2;
> >>          bool flush_pasid_uses_kiq;
> >> +
> >> +       enum amdgpu_gart_placement gart_placement;
> >>   };
> >>
> >>   #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.=
gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
> >> --
> >> 2.41.0
> >>
>
