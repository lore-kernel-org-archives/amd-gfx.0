Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E88C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 14:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2416410E3F2;
	Tue,  9 Jan 2024 14:26:19 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBCA10E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 14:26:18 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-204b216e4easo605777fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1704810377; x=1705415177; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkWw4ZEPhn/RA2BlxDwB9HorpzABpBY74GPOYZgVgUs=;
 b=B73NqqpNPmy8/QS/tki8pSwRERcq/9ME/O+IvmyFDxDcqz/Xebr4oZRDx6Di4KcRq+
 RedJZJ22OEyddM1aKjsvklVeRHLFu5raXi/1lCKFjlQBBeFWTV8NsgSX/FSSf9lgLBHW
 TlFgsPNCgaJTPMZgtSkbeDxm4l2Se611G0css=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810377; x=1705415177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkWw4ZEPhn/RA2BlxDwB9HorpzABpBY74GPOYZgVgUs=;
 b=FyQST2YzkzLueYWW+sLyZmLHFPJ4SqsXVyYtoweVbjGsCDsA8irDGxW5sag60dODKa
 IrSAf+j5ktRUpv0a4yuWFDPy8C5IPCwsjSE/Ma/724wgT6TmXXAQRkMww4eoVsqNwBdL
 wNsaQeyd4UZt8hiqbzsyN/6ZUtZMLIirO5xaQVZSxVO7mM71u+vYYA3AYFHra/+O6aO3
 +538RAxEufzy0UKT5sovOldJyJ7n/95WXaLjuLvYspmXTQmu7Il8FkKvi+4zue7Gwcbh
 1Rz7YRE4xTmQ6odc3zkYD7R6qPE5cva5TtTMZNRRb4aqmpAnGElaZH6ZrAzFhYvAQqwR
 mkJQ==
X-Gm-Message-State: AOJu0YxCHBp9cMQcH+Se64CP4IF1xeYoGIabWLwIcubiV8N/4ODo0iXr
 PXfFLdc9NsB0zNZg6F/+8Eftkni/SZsSH4XC68yTt5FSv9TZvA==
X-Google-Smtp-Source: AGHT+IFoyOBDF4eTqkMVNjvv6k2tBCgQgbggpYuSNP+obMp3jOTEU8YeU124VBFxafDYOZB4D1T0U4Y2tV+iPPIR+jI=
X-Received: by 2002:a05:6870:c115:b0:204:9066:c34f with SMTP id
 f21-20020a056870c11500b002049066c34fmr10264521oad.5.1704810377214; Tue, 09
 Jan 2024 06:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20231207180225.439482-1-alexander.deucher@amd.com>
 <20231207180225.439482-3-alexander.deucher@amd.com>
 <5b231151-45fe-4d65-a9c2-63973267bdba@gmail.com>
 <d2f7c614-228d-490c-9317-8eab0d87ee28@linux.intel.com>
 <ZZ1CGUyMjoN9PkOI@phenom.ffwll.local>
 <1373ca5e-a04a-470f-9b0e-0a7b9e8aa7a7@linux.intel.com>
In-Reply-To: <1373ca5e-a04a-470f-9b0e-0a7b9e8aa7a7@linux.intel.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 9 Jan 2024 15:26:06 +0100
Message-ID: <CAKMK7uHs0gxVEE8D1g+14KDZOtN53J32SaCn8NONBr8cVw8AqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add shared fdinfo stats
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 9 Jan 2024 at 14:25, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 09/01/2024 12:54, Daniel Vetter wrote:
> > On Tue, Jan 09, 2024 at 09:30:15AM +0000, Tvrtko Ursulin wrote:
> >>
> >> On 09/01/2024 07:56, Christian K=C3=B6nig wrote:
> >>> Am 07.12.23 um 19:02 schrieb Alex Deucher:
> >>>> Add shared stats.  Useful for seeing shared memory.
> >>>>
> >>>> v2: take dma-buf into account as well
> >>>>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> Cc: Rob Clark <robdclark@gmail.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++++++
> >>>>    3 files changed, 21 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> index 5706b282a0c7..c7df7fa3459f 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> @@ -97,6 +97,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
> >>>> struct drm_file *file)
> >>>>               stats.requested_visible_vram/1024UL);
> >>>>        drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
> >>>>               stats.requested_gtt/1024UL);
> >>>> +    drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> >>>> stats.vram_shared/1024UL);
> >>>> +    drm_printf(p, "drm-shared-gtt:\t%llu KiB\n",
> >>>> stats.gtt_shared/1024UL);
> >>>> +    drm_printf(p, "drm-shared-cpu:\t%llu KiB\n",
> >>>> stats.cpu_shared/1024UL);
> >>>> +
> >>>>        for (hw_ip =3D 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> >>>>            if (!usage[hw_ip])
> >>>>                continue;
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>> index d79b4ca1ecfc..1b37d95475b8 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>> @@ -1287,25 +1287,36 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *=
bo,
> >>>>                  struct amdgpu_mem_stats *stats)
> >>>>    {
> >>>>        uint64_t size =3D amdgpu_bo_size(bo);
> >>>> +    struct drm_gem_object *obj;
> >>>>        unsigned int domain;
> >>>> +    bool shared;
> >>>>        /* Abort if the BO doesn't currently have a backing store */
> >>>>        if (!bo->tbo.resource)
> >>>>            return;
> >>>> +    obj =3D &bo->tbo.base;
> >>>> +    shared =3D (obj->handle_count > 1) || obj->dma_buf;
> >>>
> >>> I still think that looking at handle_count is the completely wrong
> >>> approach, we should really only look at obj->dma_buf.
> >>
> >> Yeah it is all a bit tricky with the handle table walk. I don't think =
it is
> >> even possible to claim it is shared with obj->dma_buf could be the sam=
e
> >> process creating say via udmabuf and importing into drm. It is a wild
> >> scenario yes, but it could be private memory in that case. Not sure wh=
ere it
> >> would leave us if we said this is just a limitation of a BO based trac=
king.
> >>
> >> Would adding a new category "imported" help?
> >>
> >> Hmm or we simply change drm-usage-stats.rst:
> >>
> >> """
> >> - drm-shared-<region>: <uint> [KiB|MiB]
> >>
> >> The total size of buffers that are shared with another file (ie. have =
more
> >> than than a single handle).
> >> """
> >>
> >> Changing ie into eg coule be get our of jail free card to allow the
> >> "(obj->handle_count > 1) || obj->dma_buf;" condition?
> >>
> >> Because of the shared with another _file_ wording would cover my wild
> >> udmabuf self-import case. Unless there are more such creative private =
import
> >> options.
> >
> > Yeah I think clarifying that we can only track sharing with other fd an=
d
> > have no idea whether this means sharing with another process or not is
> > probably simplest. Maybe not exactly what users want, but still the
> > roughly best-case approximation we can deliver somewhat cheaply.
> >
> > Also maybe time for a drm_gem_buffer_object_is_shared() helper so we do=
n't
> > copypaste this all over and then end up in divergent conditions? I'm
> > guessing that there's going to be a bunch of drivers which needs this
> > little helper to add drm-shared-* stats to their fdinfo ...
>
> Yeah I agree that works and i915 would need to use the helper too.
>
> I would only suggest to name it so the meaning of shared is obviously
> only about the fdinfo memory stats and no one gets a more meaningful
> idea about its semantics.
>
> We have drm_show_memory_stats and drm_print_memory_stats exported so
> perhaps something like drm_object_is_shared_for_memory_stats,
> drm_object_is_memory_stats_shared, drm_memory_stats_object_is_shared?
>
> And s/ie/eg/ in the above quoted drm-usage-stats.rst.

Ack on making it clear this helper would be for fdinfo memory stats
only. Sounds like a good idea to stop people from finding really
creative uses ...
-Sima

>
> Regards,
>
> Tvrtko
>
> >
> > Cheers, Sima
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>> +
> >>>>        domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_ty=
pe);
> >>>>        switch (domain) {
> >>>>        case AMDGPU_GEM_DOMAIN_VRAM:
> >>>>            stats->vram +=3D size;
> >>>>            if (amdgpu_bo_in_cpu_visible_vram(bo))
> >>>>                stats->visible_vram +=3D size;
> >>>> +        if (shared)
> >>>> +            stats->vram_shared +=3D size;
> >>>>            break;
> >>>>        case AMDGPU_GEM_DOMAIN_GTT:
> >>>>            stats->gtt +=3D size;
> >>>> +        if (shared)
> >>>> +            stats->gtt_shared +=3D size;
> >>>>            break;
> >>>>        case AMDGPU_GEM_DOMAIN_CPU:
> >>>>        default:
> >>>>            stats->cpu +=3D size;
> >>>> +        if (shared)
> >>>> +            stats->cpu_shared +=3D size;
> >>>>            break;
> >>>>        }
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>>> index d28e21baef16..0503af75dc26 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>>> @@ -138,12 +138,18 @@ struct amdgpu_bo_vm {
> >>>>    struct amdgpu_mem_stats {
> >>>>        /* current VRAM usage, includes visible VRAM */
> >>>>        uint64_t vram;
> >>>> +    /* current shared VRAM usage, includes visible VRAM */
> >>>> +    uint64_t vram_shared;
> >>>>        /* current visible VRAM usage */
> >>>>        uint64_t visible_vram;
> >>>>        /* current GTT usage */
> >>>>        uint64_t gtt;
> >>>> +    /* current shared GTT usage */
> >>>> +    uint64_t gtt_shared;
> >>>>        /* current system memory usage */
> >>>>        uint64_t cpu;
> >>>> +    /* current shared system memory usage */
> >>>> +    uint64_t cpu_shared;
> >>>>        /* sum of evicted buffers, includes visible VRAM */
> >>>>        uint64_t evicted_vram;
> >>>>        /* sum of evicted buffers due to CPU access */
> >>>
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
