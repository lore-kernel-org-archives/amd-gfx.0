Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D941C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 16:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A954910E0AC;
	Thu, 20 Feb 2025 16:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzhD1JWN";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1AB10E0AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 16:19:28 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fc317ea4b3so281645a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740068368; x=1740673168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIMOPEx/ux46Va6ZsOw8n34PxD8qwDCcwd7+gW8YoZA=;
 b=ZzhD1JWNONHIBHJR6JwOUj+Pq8dquVSj+W/VdPyf9IXkN7Vk/by9QKe+gCC8F9WGaM
 Mkwn4CoCo272kXVdiEyY1EPQd4wn/pVotf1gagg/Yvoq2a8yJW8TGFLJjT0y1vw9PHdq
 8GFJPSG5sMzeekgcsxdxbwVuaj6r8ds9a2I24W6y3zyt/rVe1E1NIhhE5XW9bLiGhnV1
 N9n0YAmONXZAwN8XpZvCIXDQqR2OT1SobFXucGFeptL0RB3TdAxPKb9AoHJJ6Osx9G/Z
 sZlJ3kP/ZqmDgExc+nT9xuSZRiUZjy59jEGt599DcvTvmbCK40uZ3VmCmFao5v558BoY
 MOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068368; x=1740673168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIMOPEx/ux46Va6ZsOw8n34PxD8qwDCcwd7+gW8YoZA=;
 b=qYC168Kphh3Xa3e/ZNN+Ytbln5KYrp5c9ehT9Ql3Qb+Nn9PJC2Yxa4vVQvFxNDN8tI
 pJm0cvIJrgGAljsQxeFOcpg8wnO/ScRznI5y3hmxDcAnLWErNOwoxJf46JacrJI+z4uh
 LfgYqeJfNYEnaOhzIg2RpUkIHyV+OZdKXOPIXFLs4arL148zto5wBv4/MtQPKPIsajhW
 HeGwJWENCVjlwsW/bJScffm64lsizp23l3iTIpjB5S2o3TQp8Iy3EsivibzkNcWtm3c6
 0SYcm9hJddQmbWbgRLPgVN0TfasB9MpV7ak6QMuurDFNyJFAICZ6dltII/VWZqsdwj8j
 jlOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+C4qd6YaK4OR01XuBNl/68aZrw+d9J1MBopPfLk6aFuendf7bjliyjbUw4Es7eS1YBnH3ZsFH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxw4udzuYmp4TQpAsXxBRXzLnRnap3i2Iiu3NZYRGsAmQz1H67E
 0cWwcc6XySAF/PPZj3REgS/0nU4lT51fNi+BW1Jjj67iWP0w8nblldyYQjFhcDiygt0qKpfYsTJ
 w/YobfZZRNchHo8H1UFnsAblNBBQ=
X-Gm-Gg: ASbGncsWjRnoU4z5sfEF1ym5ayQykXiwGuTfEaySimNQw/cO+/+eNPNuXXqWKnsJcf6
 tnp7TTRU9eyQ7qi5HE5thdSAk6mzRjFFWHhywJcLnt0Z+AkZp3kfhNGrrm7UDjdCHAOqPY7UZ
X-Google-Smtp-Source: AGHT+IGUgv6eKZeQXdFodZxi7WiOGRXNVmy5yJo/lRDUsX3Gh9jXYoYjJ3Dc4EMKsmtyBLcM/DZEttYCkqWGcUd3/+8=
X-Received: by 2002:a17:90b:3a8f:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fc40d126a3mr14098420a91.1.1740068367506; Thu, 20 Feb 2025
 08:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20250219090509.3559015-1-jesse.zhang@amd.com>
 <ebab1f3e-2f87-49e8-9801-6477febc09ba@amd.com>
 <18614773-70dc-49ca-b475-e903e23b8c40@amd.com>
In-Reply-To: <18614773-70dc-49ca-b475-e903e23b8c40@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Feb 2025 11:19:15 -0500
X-Gm-Features: AWEUYZkgUe4JJ3QHgWoaUGrkxUmwOncx0VRbWU7Iltn763o4-eLNC7PK_L6soF0
Message-ID: <CADnq5_OdhKtXM9yLdKV82zsW0WoambemjDxODnRkNBQ9X+BvAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, jesse.zhang@amd.com,
 amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>
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

On Thu, Feb 20, 2025 at 5:08=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.02.25 um 06:41 schrieb Lazar, Lijo:
> > On 2/19/2025 2:35 PM, jesse.zhang@amd.com wrote:
> >> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
> >>
> >> - Modify the VM invalidation engine allocation logic to handle SDMA pa=
ge rings.
> >>   SDMA page rings now share the VM invalidation engine with SDMA gfx r=
ings instead of
> >>   allocating a separate engine. This change ensures efficient resource=
 management and
> >>   avoids the issue of insufficient VM invalidation engines.
> >>
> >> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
> >>   Use spin_lock and spin_unlock to ensure thread safety and prevent ra=
ce conditions
> >>   during TLB flush operations. This improves the stability and reliabi=
lity of the driver,
> >>   especially in multi-threaded environments.
> >>
> >> V3: replace the sdma ring check with a function `amdgpu_sdma_is_shared=
_inv_eng`
> >>  to Check if a ring is an SDMA ring that shares a VM invalidation engi=
ne
> >>
> >> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> >> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
> >>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 ++
> >>  4 files changed, 28 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c
> >> index cb914ce82eb5..8ccc3fb34940 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >> @@ -601,8 +601,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_=
device *adev)
> >>                      return -EINVAL;
> >>              }
> >>
> >> +    if(amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> >> +            /* Do not allocate a separate VM invalidation engine for =
SDMA page rings.
> >> +             * Shared VM invalid engine with sdma gfx ring.
> >> +             */
> >> +            ring->vm_inv_eng =3D inv_eng - 1;
> > This kind of logic has an implicit assumption that SDMA IP does
> > something like
> >
> > for each inst
> >       init sdma ring
> >       init page ring
> >
> > If the IP does something like init page ring/init sdma ring or init sdm=
a
> > ring of all instances followed by init page ring of all instances, this
> > doesn't work.
> >
> > The other thing is this is not readable. There is no clear way to know
> > what this thing is really doing. That is why it's better to explicitly
> > express what the logic is doing so that it's maintainable in future.
>
> What guarantees that the SDMA gfx ring isn't interrupted by the paging ri=
ng while doing an invalidation?
>
> In other words as far as I can see it is perfectly possible that the SDMA=
 gfx ring grabs the semaphore, is interrupted by the SDMA paging ring and t=
hen in turn also waits for the semaphore.
>
> This would mean a deadlock inside the SDMA.
>
> As far as I can see what you try to do here is a no-go.

SDMA is single threaded.  Only one queue will execute at any given
time as such there is only one inv eng for the entire engine (assuming
the use of the inv eng is limited to one packet).

Alex

>
> Regards,
> Christian.
>
> >
> > Thanks,
> > Lijo
> >
> >> +    } else {
> >>              ring->vm_inv_eng =3D inv_eng - 1;
> >>              vm_inv_engs[vmhub] &=3D ~(1 << ring->vm_inv_eng);
> >> +    }
> >>
> >>              dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u=
\n",
> >>                       ring->name, ring->vm_inv_eng, ring->vm_hub);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sdma.c
> >> index 8de214a8ba6d..159ebd9ee62f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> >> @@ -503,6 +503,24 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amd=
gpu_device *adev)
> >>      }
> >>  }
> >>
> >> +/**
> >> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring tha=
t shares a VM invalidation engine
> >> +* @adev: Pointer to the AMDGPU device structure
> >> +* @ring: Pointer to the ring structure to check
> >> +*
> >> +* This function checks if the given ring is an SDMA ring that shares =
a VM invalidation engine.
> >> +* It returns true if the ring is such an SDMA ring, false otherwise.
> >> +*/
> >> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct=
 amdgpu_ring* ring)
> >> +{
> >> +    int i =3D ring->me;
> >> +
> >> +    if (!adev->sdma.has_page_queue || i >=3D adev->sdma.num_instances=
)
> >> +            return false;
> >> +
> >> +    return (ring =3D=3D &adev->sdma.instance[i].ring);
> >> +}
> >> +
> >>  /**
> >>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset call=
backs
> >>   * @funcs: Pointer to the callback structure containing pre_reset and=
 post_reset functions
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sdma.h
> >> index 7effc2673466..da3ec6655be7 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> >> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *=
adev);
> >>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
> >>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
> >>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> >> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct=
 amdgpu_ring* ring);
> >>  #endif
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c
> >> index 2aa87fdf715f..2599da8677da 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(stru=
ct amdgpu_ring *ring,
> >>       * to WA the Issue
> >>       */
> >>
> >> +    spin_lock(&adev->gmc.invalidate_lock);
> >>      /* TODO: It needs to continue working on debugging with semaphore=
 for GFXHUB as well. */
> >>      if (use_semaphore)
> >>              /* a read return value of 1 means semaphore acuqire */
> >> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(stru=
ct amdgpu_ring *ring,
> >>              amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
> >>                                    hub->eng_distance * eng, 0);
> >>
> >> +    spin_unlock(&adev->gmc.invalidate_lock);
> >>      return pd_addr;
> >>  }
> >>
>
