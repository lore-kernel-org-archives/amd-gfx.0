Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4326C10E3B8;
	Tue, 10 May 2022 15:12:25 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AB510E3B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:12:23 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id w123so8296652oiw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y0cBq3tASWSwH0fkvDLUImVmBh95WylU/Z2xBuhToaI=;
 b=UggKL4JwPk+lipvDvaq3Ns39mfJHynpW1wZDTZfoyTKfBs+SqhAr3T+f+ApZycY/Zo
 wM/ISa/pUOqStq5F2bQccofqkIiKdIwqKEUNI+CTgcEKi2pvJ+axt3b4TtHCYuVh6eUS
 UNx0i3RuYMlnm/Dstw45bzeh0sVWx4f90Qb8c5DoCmFyQ1y5TIEwziFH3tpZf8cgxrRe
 hZDI0tKrVUFYajYowwN/WH+5FpS4KgFIN785MOHSD7MqkbCcGp5HoY1335Rvjza7yIZv
 BkELeYNrHhHIX00IeGUsOq4x4ZuAaMaQV6Ju9z8+O6AwpuBrYSAR+LZ6Rp+yUejRSZx0
 drIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y0cBq3tASWSwH0fkvDLUImVmBh95WylU/Z2xBuhToaI=;
 b=HviU5VCeioDzBCchUUmw06oqIs4dRqmFXrrzPCpoSvH0BaqbN7NKi+NoFY4Z/sOFnB
 A7rKXhHqOUefFvQ1os+OouJ1V8ybWuy4CHbzhx+0zUMBaZDTMB82gmP7VaPQYUqbYloh
 FyzQyvXNVDn/SyHFPwtavOlpZN6V0E+XpuJxZpJPUJf6bzIK/c+jGALik12X3oZRPNAr
 ksJkaaaBorcf3z5qPFUGh5pnSRyxFio9hGmxjbHMK6uZD+8Vw1EQZ0TRnDizxs2vcyXH
 ZOdwBWN965fWnV40jzNBxvCnA0UEOZ0rBdJrO1++kEUNZglWJfxBvLQCqiVMlwqJ5P8l
 2SlQ==
X-Gm-Message-State: AOAM532O/gDh979RDgN5+GRHzruatu5Ao5VUWE372e2pzNE6gSklvnwt
 75qv1R7DVSbsW/mbgx+B4fvj7B2gEmi5PY8ZAU8=
X-Google-Smtp-Source: ABdhPJyr/rhgHd25lqucohsXTvTPHaPGSAs6nB+Q6jxNMmFijyUdvpnX+FmeasS+bgPxiKmjD6xeuLrKUb1NJMQfQJ8=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr257591oiw.253.1652195543297; Tue, 10
 May 2022 08:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <CADnq5_OkTfJO0KWRpfeoTZpXxU5Doi4Uw0xaHGVLxRVgdCKT2g@mail.gmail.com>
 <3ccd38e7-2877-2b75-940b-0c41102084dd@amd.com>
In-Reply-To: <3ccd38e7-2877-2b75-940b-0c41102084dd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 11:12:12 -0400
Message-ID: <CADnq5_MrUOC60fPcpnne9AATRMUHCSGrfDg5mctziFYFYqXbtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <arunpravin.paneerselvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 11:08 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.05.22 um 16:42 schrieb Alex Deucher:
> > On Tue, May 10, 2022 at 7:36 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> We still need to calculate a virtual start address for the resource to
> >> aid checking of it is visible or not.
> > Does this fix a known issue or is it just something you noticed?
>
> Just something I've noticed. Judging from the bug reports we get large
> BAR systems are so common by now that only a few people are left where
> that actually matters.
>

If you add that to the commit message, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Christian.
>
> >
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-----=
--
> >>   1 file changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_vram_mgr.c
> >> index 49e4092f447f..51d9d3a4456c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> >> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resour=
ce_manager *man,
> >>                          list_splice_tail(trim_list, &vres->blocks);
> >>          }
> >>
> >> -       list_for_each_entry(block, &vres->blocks, link)
> >> -               vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> >> +       vres->base.start =3D 0;
> >> +       list_for_each_entry(block, &vres->blocks, link) {
> >> +               unsigned long start;
> >>
> >> -       block =3D amdgpu_vram_mgr_first_block(&vres->blocks);
> >> -       if (!block) {
> >> -               r =3D -EINVAL;
> >> -               goto error_fini;
> >> -       }
> >> +               start =3D amdgpu_vram_mgr_block_start(block) +
> >> +                       amdgpu_vram_mgr_block_size(block);
> >> +               start >>=3D PAGE_SHIFT;
> >>
> >> -       vres->base.start =3D amdgpu_vram_mgr_block_start(block) >> PAG=
E_SHIFT;
> >> +               if (start > vres->base.num_pages)
> >> +                       start -=3D vres->base.num_pages;
> >> +               else
> >> +                       start =3D 0;
> >> +               vres->base.start =3D max(vres->base.start, start);
> >> +
> >> +               vis_usage +=3D amdgpu_vram_mgr_vis_size(adev, block);
> >> +       }
> >>
> >>          if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
> >>                  vres->base.placement |=3D TTM_PL_FLAG_CONTIGUOUS;
> >> --
> >> 2.25.1
> >>
>
