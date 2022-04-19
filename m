Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5EFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 15:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE6E10EF02;
	Tue, 19 Apr 2022 15:01:34 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BB110EEAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 15:01:33 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id s16so6397499oie.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZMTfofCe4LNBjLRYE1jbQ9Sdtnu5GEOaVtNyBNd7MF0=;
 b=PkqHptqdlpH5hzHMzB5o+IBahzBxaOr+XxuTTR05czLUA4LkW4Ah5KfVK4vHAQTOB7
 s1JxMkpkFHqz/PyD6YAcF9JrvrP0FxQ4VDFxiiC20RFS3sfWhnwMZ/EUx9sXBSAdfPPt
 0PcC9tT55J325e+A2ePq7IRdIHojzhvClVjuFXIsmz5y6skmailda46WyhNahvtkzCmV
 teWYZoCy6cohhw4lnYwNiogKK130cJaWp1Vzz2ZHh8psPYbQmUsS+DOAWlkEPQ3zPZgF
 A1zTXEEvO8eJdEGw4whfopvVbBQ0L/wGhVODF7Ns3VUG7pB37FQdU7R4PsOBw4DdhN6L
 9sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZMTfofCe4LNBjLRYE1jbQ9Sdtnu5GEOaVtNyBNd7MF0=;
 b=Be4AIeVva+kRqe2uGumHmh4A0sL6lftDSSh3+ZAUoUcGVo4PepmVXUqbiBVG7By551
 XEU703QaUIKHEFkM/jJv9kzBXAAKwO68JXulujS7ue29aHlM6SpJXOXUXJlpq03dz1QN
 DEyey0wvl+imR1TDO4S6kBbN0ChQ1KH4tloGfALqHxRRi7Og5axYmGUBHHhIa5MqQx6a
 RxU5QzLcZhfcDqqZQfkZ22EpbAaZMMRhOMSvdyMVC0J+MzjAHgq68Hf28SszT+mPBFqE
 z2Ff5qlPBcaeK7yejOYRIIMIx2UB3wydNvzCL7v1xFULGqv/MRmNbDCxICt3JJ4OsJb2
 Ktqw==
X-Gm-Message-State: AOAM532jed+HpjkPlSzBDxy6nBsOAfbL/yAb83Pe214ogcaZQJkFn4LM
 IcGjI7Y2lt+nX5jjJ7hugDWNfM8d+flw1IJW2y8=
X-Google-Smtp-Source: ABdhPJzaKEIbOIpcvDjpOFVKuYJTb5aNx0ss3/+tWUnP5t4wFkr2fMnZ68L9z20SKlmg7wE5KWsZVhkg64A6cYCJEqg=
X-Received: by 2002:aca:3d88:0:b0:321:141:ce0b with SMTP id
 k130-20020aca3d88000000b003210141ce0bmr9026626oia.200.1650380492766; Tue, 19
 Apr 2022 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141915.122157-1-christian.koenig@amd.com>
 <CADnq5_Oy2LZ_dbYVYsi+UrQNpCGx+LPWeUcT2_D=-rWgeptuXQ@mail.gmail.com>
 <a488a14f-1b92-357a-419f-54b02e8e369c@amd.com>
In-Reply-To: <a488a14f-1b92-357a-419f-54b02e8e369c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Apr 2022 11:01:21 -0400
Message-ID: <CADnq5_O9YJ3swH6ckp_=5RX7sNiKfMdYKa5OtutVWYwPwYJn5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove pointless ttm_eu usage from vkms
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
 Ryan Taylor <Ryan.Taylor@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 19, 2022 at 10:55 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 19.04.22 um 16:49 schrieb Alex Deucher:
> > On Tue, Apr 19, 2022 at 10:19 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> We just need to reserve the BO here, no need for using ttm_eu.
> > Can you include a more detailed description as to why it's not
> > necessary?
>
> Well the logic in ttm_eu is for reserving multiple buffers.

With the commit message fixed up to include that detail, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> > Most of this code was copied from radeon originally.  Does
> > radeon need a similar cleanup?
>
> Most likely yes.
>
> Christian.
>
> >
> > Alex
> >
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 32 +++++++++++++---------=
--
> >>   1 file changed, 17 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vkms.c
> >> index 5224d9a39737..576849e95296 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> >> @@ -302,9 +302,6 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane=
 *plane,
> >>          struct drm_gem_object *obj;
> >>          struct amdgpu_device *adev;
> >>          struct amdgpu_bo *rbo;
> >> -       struct list_head list;
> >> -       struct ttm_validate_buffer tv;
> >> -       struct ww_acquire_ctx ticket;
> >>          uint32_t domain;
> >>          int r;
> >>
> >> @@ -316,18 +313,19 @@ static int amdgpu_vkms_prepare_fb(struct drm_pla=
ne *plane,
> >>          obj =3D new_state->fb->obj[0];
> >>          rbo =3D gem_to_amdgpu_bo(obj);
> >>          adev =3D amdgpu_ttm_adev(rbo->tbo.bdev);
> >> -       INIT_LIST_HEAD(&list);
> >>
> >> -       tv.bo =3D &rbo->tbo;
> >> -       tv.num_shared =3D 1;
> >> -       list_add(&tv.head, &list);
> >> -
> >> -       r =3D ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
> >> +       r =3D amdgpu_bo_reserve(rbo, true);
> >>          if (r) {
> >>                  dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
> >>                  return r;
> >>          }
> >>
> >> +       r =3D dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
> >> +       if (r) {
> >> +               dev_err(adev->dev, "allocating fence slot failed (%d)\=
n", r);
> >> +               goto error_unlock;
> >> +       }
> >> +
> >>          if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> >>                  domain =3D amdgpu_display_supported_domains(adev, rbo=
->flags);
> >>          else
> >> @@ -337,25 +335,29 @@ static int amdgpu_vkms_prepare_fb(struct drm_pla=
ne *plane,
> >>          if (unlikely(r !=3D 0)) {
> >>                  if (r !=3D -ERESTARTSYS)
> >>                          DRM_ERROR("Failed to pin framebuffer with err=
or %d\n", r);
> >> -               ttm_eu_backoff_reservation(&ticket, &list);
> >> -               return r;
> >> +               goto error_unlock;
> >>          }
> >>
> >>          r =3D amdgpu_ttm_alloc_gart(&rbo->tbo);
> >>          if (unlikely(r !=3D 0)) {
> >> -               amdgpu_bo_unpin(rbo);
> >> -               ttm_eu_backoff_reservation(&ticket, &list);
> >>                  DRM_ERROR("%p bind failed\n", rbo);
> >> -               return r;
> >> +               goto error_unpin;
> >>          }
> >>
> >> -       ttm_eu_backoff_reservation(&ticket, &list);
> >> +       amdgpu_bo_unreserve(rbo);
> >>
> >>          afb->address =3D amdgpu_bo_gpu_offset(rbo);
> >>
> >>          amdgpu_bo_ref(rbo);
> >>
> >>          return 0;
> >> +
> >> +error_unpin:
> >> +       amdgpu_bo_unpin(rbo);
> >> +
> >> +error_unlock:
> >> +       amdgpu_bo_unreserve(rbo);
> >> +       return r;
> >>   }
> >>
> >>   static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
> >> --
> >> 2.25.1
> >>
>
