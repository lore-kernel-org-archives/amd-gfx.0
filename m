Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C77C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 18:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838B611A6CE;
	Thu, 19 May 2022 18:37:45 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A5E11A6CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 18:37:44 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 b4-20020a056830104400b0060adcc8a299so2332870otp.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x8t83VXWbxUXZGYr20RKqWLBN18NVbx5d/OEP7KjhdU=;
 b=Y6XlzujLVeVB8gGE8PtCHKwwAj/EiI7GVP2NDze2Ub1Xq8FOIGpU6X27NGhRAkI5ZG
 nUEb4F4mudiinxZaHbgkaWwmIUvzdQcdmC9tDqNNr1bhJu1QmiKEP26kD3W3WRAdoxjU
 61btQl96fVyE2iN/4FZuTutKuIGkFeg6sS4euGPSOh8zgliGUSfsYs5zillKZzMRlubz
 F7y+BdUP+OsNcItji7js7ffrxvqB8cBRVqZoU1vI4KQ5+kN29ITwkoBtZcBWm8lNZrbP
 gIDzzwgqwZDNhWBFNb32rxGCnREDyXH+2MCBQzvCfQeDKjQIEpWrQtmwWmLPvqTc+VRd
 Hoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x8t83VXWbxUXZGYr20RKqWLBN18NVbx5d/OEP7KjhdU=;
 b=IgnzmMxsLD39wSnZfltto++EX7G09gbNYmqGDyZGh40G9pLlFFx+ZJcflsQuMzsL08
 InMhYwoiOusfH1bXP7ErM7yXUMCypaG4bg7jRuqdjyqJlP8y2THJIutR3GrbgkMDAo9m
 wuoIuY7BfuK69vx2y0zEm518l6c4WT6cHE5S2eVCGIc60kkxpPt1B5jFJR+EYmdyPxIA
 jYW0hvbX3hwG/rW+2QssoGC1qAUN7ZbjuDYrJtli9q5Her9r9HvjYAYsT+jjwT6qheyq
 /bsmMn9Fwq5uctLTx9oJe86bz1O5wSbSo3jEMRLbA+Nvn0ljji0XClNkpB+eqEEUIvKf
 r1PQ==
X-Gm-Message-State: AOAM531zdSJuljwcKyG0SHM38gQHyiJHTyDe8hPz0BQxHa3VTgwdSfka
 ydXm/7DezAibu7p4/wa8tPAfJUVUEpj8MGkzFJY=
X-Google-Smtp-Source: ABdhPJwt6eaptv957hCxb+p3DbLCMrbRFBNj8baM+kuaEEh2iDApSNGDf4h4VZ/6AijhC5bS+n/SC1nBWCPTkgsI/4I=
X-Received: by 2002:a9d:6017:0:b0:60a:e99c:6065 with SMTP id
 h23-20020a9d6017000000b0060ae99c6065mr1051282otj.357.1652985463410; Thu, 19
 May 2022 11:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <70b6b8a7-1fbd-79a6-975c-9aa0d1445514@amd.com>
In-Reply-To: <70b6b8a7-1fbd-79a6-975c-9aa0d1445514@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 May 2022 14:37:32 -0400
Message-ID: <CADnq5_O0sbS_muw1ktN0x+AdHm9A5n-UkFt0HFpGJdJ3vaAD2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
To: Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 19, 2022 at 1:15 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
>
> Am 2022-05-19 um 10:34 schrieb Alex Deucher:
> > The current somewhat strange logic is in place because certain
> > GL unit tests for large textures can cause problems with the
> > OOM killer since there is no way to link this memory to a
> > process.  The problem is this limit is often too low for many
> > modern games on systems with more memory so limit the logic to
> > systems with less than 8GB of main memory.  For systems with 8
> > or more GB of system memory, set the GTT size to 3/4 of system
> > memory.
>
> Well, I've been railing against this limit for years, and was always
> told it's unchangeable for reasons. So we found other ways to use more
> system memory in ROCm. Good to see that I'm no longer the only one who
> thinks this GTT limit is a problem.
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

After further discussions with Marek, I just sent a v2 to simplify this further.

Alex


>
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++-----
> >   1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 4b9ee6e27f74..daa0babcf869 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
> >        * or whatever the user passed on module init */
> >       if (amdgpu_gtt_size == -1) {
> > +             const u64 eight_GB = 8192ULL * 1024 * 1024;
> >               struct sysinfo si;
> > +             u64 total_memory, default_gtt_size;
> >
> >               si_meminfo(&si);
> > -             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> > -                            adev->gmc.mc_vram_size),
> > -                            ((uint64_t)si.totalram * si.mem_unit * 3/4));
> > -     }
> > -     else
> > +             total_memory = (u64)si.totalram * si.mem_unit;
> > +             default_gtt_size = total_memory * 3 / 4;
> > +             /* This somewhat strange logic is in place because certain GL unit
> > +              * tests for large textures can cause problems with the OOM killer
> > +              * since there is no way to link this memory to a process.
> > +              * The problem is this limit is often too low for many modern games
> > +              * on systems with more memory so limit the logic to systems with
> > +              * less than 8GB of main memory.
> > +              */
> > +             if (total_memory < eight_GB) {
> > +                     gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> > +                                        adev->gmc.mc_vram_size),
> > +                                    default_gtt_size);
> > +             } else {
> > +                     gtt_size = default_gtt_size;
> > +             }
> > +     } else {
> >               gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> > +     }
> >
> >       /* Initialize GTT memory pool */
> >       r = amdgpu_gtt_mgr_init(adev, gtt_size);
