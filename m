Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABDCC88E7B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B316210E290;
	Tue, 15 Sep 2026 13:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gxUQTZv0";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D69A10E290
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:49:47 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab17a810so217055a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480187; cv=none;
 d=google.com; s=arc-20260327;
 b=TEBA3aQCYxX0+hgnI9mVT8T8NWCe2tywhtL55sgojlkV9OiS3Ct4IN9A+AxF+qFODa
 Myse59j9JS7w2V721yco3LluFdmKWAdrHw3iLzkKFUZqST/V4j7DO4urPxwNBgcnlX21
 3TjbMWHYh7GYeNZmacSW4zdkzJJtsjhuFQo324vua3S+QUm+LObUnly/RLCqy+WoMHq9
 zElWLdIOAP/fQ1UUxm/VB1lofSmDz2URPQtWQcrAehd3ToOdqit7u99MmzsFXS4SWZSX
 qG1rTH2FqeKUSqm7WjcmNYTKiNEQwTWsQMXCKecocUfyWP/QzGbKKVaOJneKh61nbcFn
 XmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4j+8aDCdBl0o2Q3vAesRPq2rxXtjc1ufxXMWNRARNow=;
 fh=xwfRFha1EZVuaNmR5rtSDDXNICKaJrYXJoOebhf0Tr8=;
 b=IwtZR+ZghygSKnz8nqdAeZ/IgvKO+eXP1SOZrJPlu+jlTbpJVHg9mYrBnXQLHfVigB
 mQLs4bkK4dviJ7fiju93Y4ADTTKu1eNfdV3Wha93fqP2LBAx1UY9jpbZihWG1VxPlHY9
 PAZFNRxhy54ghmOJxALTG3LOmyCWrUCxmzzhqpu3GifhgW9jswOwQygT5m9Jvp1ijjjB
 cJepgkcVoKLp3zd1u0Krktp+8AdmwzWJ6QjtEpzjbRlU5BgCnEltKBMfAEhF68ITEJfY
 ZDDyDpWx7JNycNaJvZqC1lqlO6ecXBo7LDuD+SOrno3aYzAlHvMAS0DIYINXDyxPuVTC
 XyYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789480187; x=1790084987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4j+8aDCdBl0o2Q3vAesRPq2rxXtjc1ufxXMWNRARNow=;
 b=gxUQTZv0kz3gGcqd6jFqzVceIqg5dVmJtyaq0d1moAzLZ9mztyh7juE2vx0bGaCUvP
 SVwERVMSKHziXnfL6yIhMOBRE/soSz6zl5JMAfmkMCtROLxilZnQJ1V0vv1KvzYVlDU2
 WIMAadc4jAkZ+kXvc/3Tyb8uCTBKzBqmH1c2uA8YAY62yAanZ2cWM5yYpKI+vIgkea/y
 y42UzhbHyra2rAoUg7anqX37J4qMWiFWskf1zgPdI5SFiI9ySD3jHM19g3xFZSWAi/py
 yhy794yY7YwWbeTkhfiF/2h2vkdMxIymGUb8ZqZSWfLn0x/UfcNhcdB/sxUW1VAQ6m1w
 BmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789480187; x=1790084987;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4j+8aDCdBl0o2Q3vAesRPq2rxXtjc1ufxXMWNRARNow=;
 b=qzzrYGvzXqvb+YDBHj3Q+FMY3rzgI+yIOuBjc6tKixiUiQbGS22gjfKrrfu5QunRq7
 nRxaxEJGHA994uT45Pt+MoDxUvmD2nCI+Xzm0vki+muxwL/YWLDRJoy9T3Izru+A/Jxe
 rA5IDrBk8AFxQ+Y7YXpy2vvlOs+3pX17Wyrv3L6JgV1utdo1CseuRqvylL7u+/hRk7Ec
 8oYEksVo21KnfI8a1ZvknYhhZh4AO0rN728taJvTFQIyyVKNY+4nkUb7LHBmpPIu3Z/+
 jsg6z12ik++KqNf8G/2zWesKwMV1kFSCrez5LBI+uVwre5X7tCBSS+qC3ofrbdMulqur
 +wcg==
X-Gm-Message-State: AFuF++ljgsBSai9AbEUI8oaIqUr3jQo6DytEUWpVBUL6cS4fFrh+s8qv
 9AEVbWEpYQvHxBiZafffRGaC1pa3UtOPElrJNxr23W62BG12kX8TjY0CDx7Yo8mtZmliY8Tvxj1
 CZbFNQSkbnyhYA9Urm4kwk4DD05zGpf4=
X-Gm-Gg: AYBFou1PVhELcJzw3sQ2VWW7wqj9UGR/KJkOY+rbnelHCFRaTEYHMw9lVqb0Hvu9zts
 k27XxqwJ9mOllbY1AJpDoLV+rhNQu+FZidkVvaVEPnWeNuNqOTvAz+VnRvQrh+1PkcJZuSo35mY
 4Iol3JwI6X5y6nzcn/9xtZOrbB6zpYtcSLT3PEfu5rIYfF2RSrte0F5MeBVRmVzVKjIJO1XiIzS
 T8RKOgHEwfon8MUi4MKIMHnBioei99ygrz9+etHPxnl8qdUywsNcfr6DYYQ1PiF22GylMHTJJFN
 Ix63emVSGWtfGBnMWG3DmSTYA7ZKM9RA4wUJ+D3AuBIakiVL9asTu6KH4lnmGN2dE2hmZM5ddxz
 3zk7SJBSaeqOn+iFLJpC9e3bf2eaimZQa5qyyKBWKcQ==
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39dec1aa1cbmr9880214a91.4.1789480186775; Tue, 15 Sep 2026
 06:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
 <20260915114934.60326-2-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260915114934.60326-2-tvrtko.ursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 09:49:33 -0400
X-Gm-Features: AcwNN1XRTlvlc-sLEwGA1GZj32LVplrlsGMbE3LUy3PRzBlmfF_35wXpxmeKKOc
Message-ID: <CADnq5_Nfig8Lkfa8V1Y7=X2d_ifsd48FVgcFKCzy5YFGMceT5g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm/amdgpu: Add SDMA ring init helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

Applied the series.  Thanks!  Will let you know if there are any CI failure=
s.

Alex

On Tue, Sep 15, 2026 at 8:06=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> Consolidate one part of the SDMA ring initialization with a new
> amdgpu_sdma_ring_init() helper.
>
> Only code which is completely IP version agnostic is moved to the helper.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> v2:
>  - Use va args to consolidate even better.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 13 ++-----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++---------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 +-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  8 ++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 10 +++-------
>  11 files changed, 39 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index fbac732f3e01..7d975c1680a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include <linux/firmware.h>
> +#include <linux/stdarg.h>
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> @@ -37,6 +38,23 @@
>   * GPU SDMA IP block helpers function.
>   */
>
> +int __printf(4, 5)
> +amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ri=
ng,
> +                     unsigned int instance, const char *fmt, ...)
> +{
> +       va_list args;
> +
> +       ring->ring_obj =3D NULL;
> +
> +       va_start(args, fmt);
> +       vsnprintf(ring->name, sizeof(ring->name), fmt, args);
> +       va_end(args);
> +
> +       return amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
> +                               AMDGPU_SDMA_IRQ_INSTANCE0 + instance,
> +                               AMDGPU_RING_PRIO_DEFAULT, NULL);
> +}
> +
>  struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct a=
mdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 671cfbb67b7a..0a692804bc53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -158,6 +158,10 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> +int __printf(4, 5)
> +amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ri=
ng,
> +                     unsigned int instance, const char *fmt, ...);
> +
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id,
>                              bool caller_handles_kernel_queues);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index 657ef6c93c61..11e118a4aee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -865,13 +865,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block =
*ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D false;
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    (i =3D=3D 0) ? AMDGPU_SDMA_IRQ_INSTA=
NCE0 :
> -                                    AMDGPU_SDMA_IRQ_INSTANCE1,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index 9478dd034aff..87743fe6ae44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1146,7 +1146,6 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 if (!amdgpu_sriov_vf(adev)) {
>                         ring->use_doorbell =3D true;
>                         ring->doorbell_index =3D adev->doorbell_index.sdm=
a_engine[i];
> @@ -1154,11 +1153,7 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         ring->use_pollmem =3D true;
>                 }
>
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    (i =3D=3D 0) ? AMDGPU_SDMA_IRQ_INSTA=
NCE0 :
> -                                    AMDGPU_SDMA_IRQ_INSTANCE1,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 9d7d919a5aa1..e77e29855c68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1858,7 +1858,6 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>
>                 DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
> @@ -1878,16 +1877,12 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 else
>                         ring->vm_hub =3D AMDGPU_MMHUB0(0);
>
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>
>                 if (adev->sdma.has_page_queue) {
>                         ring =3D &adev->sdma.instance[i].page;
> -                       ring->ring_obj =3D NULL;
>                         ring->use_doorbell =3D true;
>
>                         /* paging queue use same doorbell index/routing a=
s gfx queue
> @@ -1915,11 +1910,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         else
>                                 ring->vm_hub =3D AMDGPU_MMHUB0(0);
>
> -                       sprintf(ring->name, "page%d", i);
> -                       r =3D amdgpu_ring_init(adev, ring, 1024,
> -                                            &adev->sdma.trap_irq,
> -                                            AMDGPU_SDMA_IRQ_INSTANCE0 + =
i,
> -                                            AMDGPU_RING_PRIO_DEFAULT, NU=
LL);
> +                       r =3D amdgpu_sdma_ring_init(adev, ring, i, "page%=
d", i);
>                         if (r)
>                                 return r;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 461f8b220a3e..2bed58e983be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1484,7 +1484,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 adev->sdma.instance[i].funcs =3D &sdma_v4_4_2_sdma_funcs;
>
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 aid_id =3D adev->sdma.instance[i].aid_id;
>
> @@ -1495,18 +1494,13 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_b=
lock *ip_block)
>                 ring->doorbell_index =3D adev->doorbell_index.sdma_engine=
[i] << 1;
>                 ring->vm_hub =3D AMDGPU_MMHUB0(aid_id);
>                 ring->no_user_submission =3D adev->sdma.no_user_submissio=
n;
> -
> -               sprintf(ring->name, "sdma%d.%d", aid_id,
> -                               i % adev->sdma.num_inst_per_aid);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d.%d", a=
id_id,
> +                                         i % adev->sdma.num_inst_per_aid=
);
>                 if (r)
>                         return r;
>
>                 if (adev->sdma.has_page_queue) {
>                         ring =3D &adev->sdma.instance[i].page;
> -                       ring->ring_obj =3D NULL;
>                         ring->use_doorbell =3D true;
>
>                         /* doorbell index of page queue is assigned right=
 after
> @@ -1515,13 +1509,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_bl=
ock *ip_block)
>                         ring->doorbell_index =3D
>                                 (adev->doorbell_index.sdma_engine[i] + 1)=
 << 1;
>                         ring->vm_hub =3D AMDGPU_MMHUB0(aid_id);
> -
> -                       sprintf(ring->name, "page%d.%d", aid_id,
> -                                       i % adev->sdma.num_inst_per_aid);
> -                       r =3D amdgpu_ring_init(adev, ring, 1024,
> -                                            &adev->sdma.trap_irq,
> -                                            AMDGPU_SDMA_IRQ_INSTANCE0 + =
i,
> -                                            AMDGPU_RING_PRIO_DEFAULT, NU=
LL);
> +                       r =3D amdgpu_sdma_ring_init(adev, ring, i, "page%=
d.%d",
> +                                                 aid_id,
> +                                                 i % adev->sdma.num_inst=
_per_aid);
>                         if (r)
>                                 return r;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 97fee70dc2f6..fa25d1508404 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1411,7 +1411,6 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>                 adev->sdma.instance[i].funcs =3D &sdma_v5_0_sdma_funcs;
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>
>                 DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
> @@ -1422,11 +1421,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         : (adev->doorbell_index.sdma_engine[1] << 1); // =
get DWORD offset
>
>                 ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    (i =3D=3D 0) ? AMDGPU_SDMA_IRQ_INSTA=
NCE0 :
> -                                    AMDGPU_SDMA_IRQ_INSTANCE1,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 35cdf6c149f8..8d0ffad0284a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1331,7 +1331,6 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>                 adev->sdma.instance[i].funcs =3D &sdma_v5_2_sdma_funcs;
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->me =3D i;
>
> @@ -1342,10 +1341,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         (adev->doorbell_index.sdma_engine[i] << 1); //get=
 DWORD offset
>
>                 ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap=
_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 303fd7d1b7c8..b28934739d32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1335,7 +1335,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->me =3D i;
>                 ring->no_user_submission =3D adev->sdma.no_user_submissio=
n;
> @@ -1347,11 +1346,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         (adev->doorbell_index.sdma_engine[i] << 1); // ge=
t DWORD offset
>
>                 ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024,
> -                                    &adev->sdma.trap_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index d5552f206e4d..4503bae1d48c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1319,7 +1319,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->me =3D i;
>                 ring->no_user_submission =3D adev->sdma.no_user_submissio=
n;
> @@ -1331,11 +1330,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         (adev->doorbell_index.sdma_engine[i] << 1); // ge=
t DWORD offset
>
>                 ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -               sprintf(ring->name, "sdma%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 1024,
> -                                    &adev->sdma.trap_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d", i);
>                 if (r)
>                         return r;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index 0f30eb503c2a..f33b0dc17c50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1305,7 +1305,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->me =3D i;
>                 ring->no_user_submission =3D adev->sdma.no_user_submissio=
n;
> @@ -1323,12 +1322,9 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         (adev->doorbell_index.sdma_engine[i] << 1); // ge=
t DWORD offset
>
>                 ring->vm_hub =3D AMDGPU_GFXHUB(xcc_id);
> -               sprintf(ring->name, "sdma%d.%d", xcc_id,
> -                               GET_INST(SDMA0, i) % adev->sdma.num_inst_=
per_xcc);
> -               r =3D amdgpu_ring_init(adev, ring, 1024,
> -                                    &adev->sdma.trap_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -                                    AMDGPU_RING_PRIO_DEFAULT, NULL);
> +               r =3D amdgpu_sdma_ring_init(adev, ring, i, "sdma%d.%d", x=
cc_id,
> +                                         GET_INST(SDMA0, i) %
> +                                         adev->sdma.num_inst_per_xcc);
>                 if (r)
>                         return r;
>         }
> --
> 2.55.0
>
