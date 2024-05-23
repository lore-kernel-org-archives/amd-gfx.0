Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABEC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0419510EB75;
	Thu, 23 May 2024 19:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liruktzG";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23AF10EB75
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:46:20 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2bf5e177ebdso59958a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716493580; x=1717098380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Speq0hkz8yv/tYTF27hGAJJ6ifqa/HvQuNgK9fsIyCI=;
 b=liruktzGUwB+zMLGffWSPKbZkfyVH723cG5mewOIoWGe2mMIy0w6Rm/jV7Yo6SGSI6
 643m3/LIphVbfY2h0YgaCfXhERhvrWEaqjgPVE2SuIeNdwIaTp2e5DA1W1ZntMqiZm8i
 ok1+dXtSa8QAVsOQYhySRTjuLfOzL7G1tJwu6tJxXTuoxFWohgPd79L/rn8/KVM4yYFh
 fw+SzN0XJbsq93XX8MlQTlJmsbPuSStP8AuHeKOQx1zoNUMCVaCmLUKdaUap7w/mHjh0
 7uvAivrfNE8UHNYmgy3+E79VIGrsRYoJBtQokxHAkuUaGQo86owrjMQvShDD3gOidHZT
 MxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716493580; x=1717098380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Speq0hkz8yv/tYTF27hGAJJ6ifqa/HvQuNgK9fsIyCI=;
 b=faVzNmurZ8Nuc451AhV+PLRnEmErFoSKqrQLRIc16Kn91ol2Yi8wwPWIMUJ9wxUFP+
 nz2wOZWzyBnxOxHkIAiVsJDlwAsmOQggM9q3XMCCfvIiFqT6x/iG6SXugbRQn35+3AST
 HmOTq7qAqGKfbUeYLk+xZp/BDDC0kZQnNgwz2FvI37mlJ/dd5nW3ydYscNUy4mJuFu9K
 /EZ3bfdT6M0ZQwBTVNYfMn46+OPSs8eT3voEDDT+D3xaQ7DUieK6Vriwnqrr+dckr6F8
 pEVuYUqYknDzN+BnHXrdFN+EB7KQrv+kq3Ft3X8fUBmuITsMUC+G6tUIMz3/uaodVgXS
 PELA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUppWvTHCi2JyHiEgQvxr18BoPO7RCBuAG07boNGrrXupT44cvLH+jQB4cwV9cG2FFD4XEYj24ihf3f5UXmu8aILMY709tfFrUsvsqGQ==
X-Gm-Message-State: AOJu0Yz5MA+j0+h1+TZO3cz+tK/srN91QuVVBjo4XEkrP9NsIMnB2+vf
 2Lc9+CjKSioUF387z7mpQk6Kx3QyDl/87FWQ8MAb6z+U+OZiLuBAVjBwoTchHwyhdHY7xMnWnH5
 ug98NGOiuCFtGYGdgota9RM93eCeANs60
X-Google-Smtp-Source: AGHT+IE9kM4gBoeftDOonUYJBvh4xRdD+oH63INcHquUgMeH7tUbGaHT2onNQaS5QajvnziZEp41bz/gyabbDUxA6l0=
X-Received: by 2002:a17:90a:f98c:b0:2bd:69a4:b886 with SMTP id
 98e67ed59e1d1-2bf5ef1b8femr192713a91.26.1716493579832; Thu, 23 May 2024
 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240510225909.1957238-1-alexander.deucher@amd.com>
 <CADnq5_NK=KDkrwZ7HQHnZsNj56V3hySQjKXwY6nr6=WUMxJKbw@mail.gmail.com>
 <CY8PR12MB709958A4EC3F0E253B0CCB2B8CF42@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB709958A4EC3F0E253B0CCB2B8CF42@CY8PR12MB7099.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 15:46:06 -0400
Message-ID: <CADnq5_MgyXC7MCwOvQnevkHdm=9tQDcmfLpXu+VK_q4nvfX2-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop MES 10.1 support v2
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
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

On Thu, May 23, 2024 at 3:38=E2=80=AFPM Kasiviswanathan, Harish
<Harish.Kasiviswanathan@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> File mes_api_def.h can also be removed. This is defined for gfx10.
> One minor comment inline.
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Thursday, May 23, 2024 2:46 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: drop MES 10.1 support v2
>
> Ping?
>
> On Fri, May 10, 2024 at 7:37=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > It was an enablement vehicle for MES 11 and was never
> > productized.  Remove it.

done.

> >
> > v2: drop additional checks in the GFX10 code.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Makefile           |    1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   20 -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  281 +---
> >  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        | 1190 -----------------
> >  drivers/gpu/drm/amd/amdgpu/mes_v10_1.h        |   29 -
> >  drivers/gpu/drm/amd/amdgpu/nv.c               |    1 -
> >  6 files changed, 71 insertions(+), 1451 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> >  delete mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index de7b76327f5ba..6e1237a97a91e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -187,7 +187,6 @@ amdgpu-y +=3D \
> >  # add MES block
> >  amdgpu-y +=3D \
> >         amdgpu_mes.o \
> > -       mes_v10_1.o \
> >         mes_v11_0.o \
> >         mes_v12_0.o
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 824dd5b57d0d3..47e45e1700326 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -94,7 +94,6 @@
> >  #include "vcn_v4_0_5.h"
> >  #include "jpeg_v4_0_5.h"
> >  #include "amdgpu_vkms.h"
> > -#include "mes_v10_1.h"
> >  #include "mes_v11_0.h"
> >  #include "mes_v12_0.h"
> >  #include "smuio_v11_0.h"
> > @@ -2215,25 +2214,6 @@ static int amdgpu_discovery_set_mm_ip_blocks(str=
uct amdgpu_device *adev)
> >  static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *ad=
ev)
> >  {
> >         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 1, 10):
> > -       case IP_VERSION(10, 1, 1):
> > -       case IP_VERSION(10, 1, 2):
> > -       case IP_VERSION(10, 1, 3):
> > -       case IP_VERSION(10, 1, 4):
> > -       case IP_VERSION(10, 3, 0):
> > -       case IP_VERSION(10, 3, 1):
> > -       case IP_VERSION(10, 3, 2):
> > -       case IP_VERSION(10, 3, 3):
> > -       case IP_VERSION(10, 3, 4):
> > -       case IP_VERSION(10, 3, 5):
> > -       case IP_VERSION(10, 3, 6):
> > -               if (amdgpu_mes) {
> > -                       amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_=
block);
> > -                       adev->enable_mes =3D true;
> > -                       if (amdgpu_mes_kiq)
> > -                               adev->enable_mes_kiq =3D true;
> > -               }
> > -               break;
> >         case IP_VERSION(11, 0, 0):
> >         case IP_VERSION(11, 0, 1):
> >         case IP_VERSION(11, 0, 2):
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index fcb0fbd1a1122..21208bbcd70ef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -3664,14 +3664,8 @@ static void gfx10_kiq_unmap_queues(struct amdgpu=
_ring *kiq_ring,
> >                                    enum amdgpu_unmap_queues_action acti=
on,
> >                                    u64 gpu_addr, u64 seq)
> >  {
> > -       struct amdgpu_device *adev =3D kiq_ring->adev;
> >         uint32_t eng_sel =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_=
GFX ? 4 : 0;
> >
> > -       if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
> > -               amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_a=
ddr, seq);
> > -               return;
> > -       }
> > -
> >         amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> >         amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, nu=
m_Q: 1 */
> >                           PACKET3_UNMAP_QUEUES_ACTION(action) |
> > @@ -3929,33 +3923,18 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >
> >         memset(&ib, 0, sizeof(ib));
> >
> > -       if (ring->is_mes_queue) {
> > -               uint32_t padding, offset;
> > -
> > -               offset =3D amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX=
_IB_OFFS);
> > -               padding =3D amdgpu_mes_ctx_get_offs(ring,
> > -                                                 AMDGPU_MES_CTX_PADDIN=
G_OFFS);
> > -
> > -               ib.gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, =
offset);
> > -               ib.ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, offse=
t);
> > -
> > -               gpu_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, pad=
ding);
> > -               cpu_ptr =3D amdgpu_mes_ctx_get_offs_cpu_addr(ring, padd=
ing);
> > -               *cpu_ptr =3D cpu_to_le32(0xCAFEDEAD);
> > -       } else {
> > -               r =3D amdgpu_device_wb_get(adev, &index);
> > -               if (r)
> > -                       return r;
> > +       r =3D amdgpu_device_wb_get(adev, &index);
> > +       if (r)
> > +               return r;
> >
> > -               gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> > -               adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > -               cpu_ptr =3D &adev->wb.wb[index];
> > +       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> > +       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > +       cpu_ptr =3D &adev->wb.wb[index];
> >
> > -               r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRE=
CT, &ib);
> > -               if (r) {
> > -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", =
r);
> > -                       goto err1;
> > -               }
> > +       r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib)=
;
> > +       if (r) {
> > +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> > +               goto err1;
> >         }
> >
> >         ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > @@ -3982,12 +3961,10 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >         else
> >                 r =3D -EINVAL;
> >  err2:
> > -       if (!ring->is_mes_queue)
> > -               amdgpu_ib_free(adev, &ib, NULL);
> > +       amdgpu_ib_free(adev, &ib, NULL);
> >         dma_fence_put(f);
> >  err1:
> > -       if (!ring->is_mes_queue)
> > -               amdgpu_device_wb_free(adev, index);
> > +       amdgpu_device_wb_free(adev, index);
> >         return r;
> >  }
> >
> > @@ -4735,18 +4712,16 @@ static int gfx_v10_0_sw_init(void *handle)
> >                 }
> >         }
> >
> > -       if (!adev->enable_mes_kiq) {
> > -               r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
> > -               if (r) {
> > -                       DRM_ERROR("Failed to init KIQ BOs!\n");
> > -                       return r;
> > -               }
> > -
> > -               r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
> > -               if (r)
> > -                       return r;
> > +       r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
> > +       if (r) {
> > +               DRM_ERROR("Failed to init KIQ BOs!\n");
> > +               return r;
> >         }
> >
> > +       r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
> > +       if (r)
> > +               return r;
> > +
> >         r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mq=
d), 0);
> >         if (r)
> >                 return r;
> > @@ -4800,10 +4775,8 @@ static int gfx_v10_0_sw_fini(void *handle)
> >
> >         amdgpu_gfx_mqd_sw_fini(adev, 0);
> >
> > -       if (!adev->enable_mes_kiq) {
> > -               amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
> > -               amdgpu_gfx_kiq_fini(adev, 0);
> > -       }
> > +       amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
> > +       amdgpu_gfx_kiq_fini(adev, 0);
> >
> >         gfx_v10_0_pfp_fini(adev);
> >         gfx_v10_0_ce_fini(adev);
> > @@ -7012,10 +6985,7 @@ static int gfx_v10_0_cp_resume(struct amdgpu_dev=
ice *adev)
> >                         return r;
> >         }
> >
> > -       if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
> > -               r =3D amdgpu_mes_kiq_hw_init(adev);
> > -       else
> > -               r =3D gfx_v10_0_kiq_resume(adev);
> > +       r =3D gfx_v10_0_kiq_resume(adev);
> >         if (r)
> >                 return r;
> >
> > @@ -8327,45 +8297,17 @@ static u64 gfx_v10_0_ring_get_wptr_gfx(struct a=
mdgpu_ring *ring)
> >  static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > -       uint32_t *wptr_saved;
> > -       uint32_t *is_queue_unmap;
> > -       uint64_t aggregated_db_index;
> > -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
> > -       uint64_t wptr_tmp;
> > -
> > -       if (ring->is_mes_queue) {
> > -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> > -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_siz=
e +
> > -                                             sizeof(uint32_t));
> > -               aggregated_db_index =3D
> > -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> > -                       AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
> > -
> > -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> > -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tm=
p);
> > -               *wptr_saved =3D wptr_tmp;
> > -               /* assume doorbell always being used by mes mapped queu=
e */
> > -               if (*is_queue_unmap) {
> > -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> > -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> > -               } else {
> > -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> >
> > -                       if (*is_queue_unmap)
> > -                               WDOORBELL64(aggregated_db_index, wptr_t=
mp);
> > -               }
> > +       if (ring->use_doorbell) {
> > +               /* XXX check if swapping is necessary on BE */
> > +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > +                            ring->wptr);
> > +               WDOORBELL64(ring->doorbell_index, ring->wptr);
> >         } else {
> > -               if (ring->use_doorbell) {
> > -                       /* XXX check if swapping is necessary on BE */
> > -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                                    ring->wptr);
> > -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -               } else {
> > -                       WREG32_SOC15(GC, 0, mmCP_RB0_WPTR,
> > -                                    lower_32_bits(ring->wptr));
> > -                       WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI,
> > -                                    upper_32_bits(ring->wptr));
> > -               }
> > +               WREG32_SOC15(GC, 0, mmCP_RB0_WPTR,
> > +                            lower_32_bits(ring->wptr));
> > +               WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI,
> > +                            upper_32_bits(ring->wptr));
> >         }
> >  }
> >
> > @@ -8390,42 +8332,13 @@ static u64 gfx_v10_0_ring_get_wptr_compute(stru=
ct amdgpu_ring *ring)
> >  static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > -       uint32_t *wptr_saved;
> > -       uint32_t *is_queue_unmap;
> > -       uint64_t aggregated_db_index;
> > -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size=
;
> > -       uint64_t wptr_tmp;
> > -
> > -       if (ring->is_mes_queue) {
> > -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> > -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_siz=
e +
> > -                                             sizeof(uint32_t));
> > -               aggregated_db_index =3D
> > -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> > -                       AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
> > -
> > -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> > -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tm=
p);
> > -               *wptr_saved =3D wptr_tmp;
> > -               /* assume doorbell always used by mes mapped queue */
> > -               if (*is_queue_unmap) {
> > -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> > -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> > -               } else {
> > -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> >
> > -                       if (*is_queue_unmap)
> > -                               WDOORBELL64(aggregated_db_index, wptr_t=
mp);
> > -               }
> > +       if (ring->use_doorbell) {
> > +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > +                            ring->wptr);
> > +               WDOORBELL64(ring->doorbell_index, ring->wptr);
> >         } else {
> > -               /* XXX check if swapping is necessary on BE */
> > -               if (ring->use_doorbell) {
> > -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                                    ring->wptr);
> > -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -               } else {
> > -                       BUG(); /* only DOORBELL method supported on gfx=
10 now */
> > -               }
> > +               BUG(); /* only DOORBELL method supported on gfx10 now *=
/
> >         }
> >  }
> >
> > @@ -8484,10 +8397,6 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct am=
dgpu_ring *ring,
> >                                     (!amdgpu_sriov_vf(ring->adev) && fl=
ags & AMDGPU_IB_PREEMPTED) ? true : false);
> >         }
> >
> > -       if (ring->is_mes_queue)
> > -               /* inherit vmid from mqd */
> > -               control |=3D 0x400000;
> > -
> >         amdgpu_ring_write(ring, header);
> >         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> >         amdgpu_ring_write(ring,
> > @@ -8507,10 +8416,6 @@ static void gfx_v10_0_ring_emit_ib_compute(struc=
t amdgpu_ring *ring,
> >         unsigned int vmid =3D AMDGPU_JOB_GET_VMID(job);
> >         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid <=
< 24);
> >
> > -       if (ring->is_mes_queue)
> > -               /* inherit vmid from mqd */
> > -               control |=3D 0x40000000;
> > -
> >         /* Currently, there is a high possibility to get wave ID mismat=
ch
> >          * between ME and GDS, leading to a hw deadlock, because ME gen=
erates
> >          * different wave IDs than the GDS expects. This situation happ=
ens
> > @@ -8568,8 +8473,7 @@ static void gfx_v10_0_ring_emit_fence(struct amdg=
pu_ring *ring, u64 addr,
> >         amdgpu_ring_write(ring, upper_32_bits(addr));
> >         amdgpu_ring_write(ring, lower_32_bits(seq));
> >         amdgpu_ring_write(ring, upper_32_bits(seq));
> > -       amdgpu_ring_write(ring, ring->is_mes_queue ?
> > -                        (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FL=
AG) : 0);
> > +       amdgpu_ring_write(ring, 0);
> >  }
> >
> >  static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring=
)
> > @@ -8597,10 +8501,7 @@ static void gfx_v10_0_ring_invalidate_tlbs(struc=
t amdgpu_ring *ring,
> >  static void gfx_v10_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
> >                                          unsigned int vmid, uint64_t pd=
_addr)
> >  {
> > -       if (ring->is_mes_queue)
> > -               gfx_v10_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
>
> gfx_v10_0_ring_invalidate_tlbs : function can be removed.

It's still used by gfx10_kiq_invalidate_tlbs()

Alex

>
> > -       else
> > -               amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> > +       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> >
> >         /* compute doesn't have PFP */
> >         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> > @@ -8751,19 +8652,9 @@ static void gfx_v10_0_ring_emit_ce_meta(struct a=
mdgpu_ring *ring, bool resume)
> >
> >         cnt =3D (sizeof(ce_payload) >> 2) + 4 - 2;
> >
> > -       if (ring->is_mes_queue) {
> > -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> > -                                 gfx[0].gfx_meta_data) +
> > -                       offsetof(struct v10_gfx_meta_data, ce_payload);
> > -               ce_payload_gpu_addr =3D
> > -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> > -               ce_payload_cpu_addr =3D
> > -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> > -       } else {
> > -               offset =3D offsetof(struct v10_gfx_meta_data, ce_payloa=
d);
> > -               ce_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + =
offset;
> > -               ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offse=
t;
> > -       }
> > +       offset =3D offsetof(struct v10_gfx_meta_data, ce_payload);
> > +       ce_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offset;
> > +       ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
> >
> >         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
> >         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
> > @@ -8789,28 +8680,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct =
amdgpu_ring *ring, bool resume)
> >         void *de_payload_cpu_addr;
> >         int cnt;
> >
> > -       if (ring->is_mes_queue) {
> > -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> > -                                 gfx[0].gfx_meta_data) +
> > -                       offsetof(struct v10_gfx_meta_data, de_payload);
> > -               de_payload_gpu_addr =3D
> > -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> > -               de_payload_cpu_addr =3D
> > -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> > -
> > -               offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> > -                                 gfx[0].gds_backup) +
> > -                       offsetof(struct v10_gfx_meta_data, de_payload);
> > -               gds_addr =3D amdgpu_mes_ctx_get_offs_gpu_addr(ring, off=
set);
> > -       } else {
> > -               offset =3D offsetof(struct v10_gfx_meta_data, de_payloa=
d);
> > -               de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + =
offset;
> > -               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offse=
t;
> > +       offset =3D offsetof(struct v10_gfx_meta_data, de_payload);
> > +       de_payload_gpu_addr =3D amdgpu_csa_vaddr(ring->adev) + offset;
> > +       de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + offset;
> >
> > -               gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> > -                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
> > -                                PAGE_SIZE);
> > -       }
> > +       gds_addr =3D ALIGN(amdgpu_csa_vaddr(ring->adev) +
> > +                        AMDGPU_CSA_SIZE - adev->gds.gds_size,
> > +                        PAGE_SIZE);
> >
> >         de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
> >         de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);
> > @@ -9062,49 +8938,34 @@ static int gfx_v10_0_eop_irq(struct amdgpu_devi=
ce *adev,
> >         int i;
> >         u8 me_id, pipe_id, queue_id;
> >         struct amdgpu_ring *ring;
> > -       uint32_t mes_queue_id =3D entry->src_data[0];
> >
> >         DRM_DEBUG("IH: CP EOP\n");
> >
> > -       if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_=
FLAG)) {
> > -               struct amdgpu_mes_queue *queue;
> > -
> > -               mes_queue_id &=3D AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> > -
> > -               spin_lock(&adev->mes.queue_id_lock);
> > -               queue =3D idr_find(&adev->mes.queue_id_idr, mes_queue_i=
d);
> > -               if (queue) {
> > -                       DRM_DEBUG("process mes queue id =3D %d\n", mes_=
queue_id);
> > -                       amdgpu_fence_process(queue->ring);
> > -               }
> > -               spin_unlock(&adev->mes.queue_id_lock);
> > -       } else {
> > -               me_id =3D (entry->ring_id & 0x0c) >> 2;
> > -               pipe_id =3D (entry->ring_id & 0x03) >> 0;
> > -               queue_id =3D (entry->ring_id & 0x70) >> 4;
> > +       me_id =3D (entry->ring_id & 0x0c) >> 2;
> > +       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> > +       queue_id =3D (entry->ring_id & 0x70) >> 4;
> >
> > -               switch (me_id) {
> > -               case 0:
> > -                       if (pipe_id =3D=3D 0)
> > -                               amdgpu_fence_process(&adev->gfx.gfx_rin=
g[0]);
> > -                       else
> > -                               amdgpu_fence_process(&adev->gfx.gfx_rin=
g[1]);
> > -                       break;
> > -               case 1:
> > -               case 2:
> > -                       for (i =3D 0; i < adev->gfx.num_compute_rings; =
i++) {
> > -                               ring =3D &adev->gfx.compute_ring[i];
> > -                               /* Per-queue interrupt is supported for=
 MEC starting from VI.
> > -                                * The interrupt can only be enabled/di=
sabled per pipe instead
> > -                                * of per queue.
> > -                                */
> > -                               if ((ring->me =3D=3D me_id) &&
> > -                                   (ring->pipe =3D=3D pipe_id) &&
> > -                                   (ring->queue =3D=3D queue_id))
> > -                                       amdgpu_fence_process(ring);
> > -                       }
> > -                       break;
> > +       switch (me_id) {
> > +       case 0:
> > +               if (pipe_id =3D=3D 0)
> > +                       amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> > +               else
> > +                       amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
> > +               break;
> > +       case 1:
> > +       case 2:
> > +               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > +                       ring =3D &adev->gfx.compute_ring[i];
> > +                       /* Per-queue interrupt is supported for MEC sta=
rting from VI.
> > +                        * The interrupt can only be enabled/disabled p=
er pipe instead
> > +                        * of per queue.
> > +                        */
> > +                       if ((ring->me =3D=3D me_id) &&
> > +                           (ring->pipe =3D=3D pipe_id) &&
> > +                           (ring->queue =3D=3D queue_id))
> > +                               amdgpu_fence_process(ring);
> >                 }
> > +               break;
> >         }
> >
> >         return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v10_1.c
> > deleted file mode 100644
> > index 013aa690299ec..0000000000000
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > +++ /dev/null
> > @@ -1,1190 +0,0 @@
> > -/*
> > - * Copyright 2019 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > - * copy of this software and associated documentation files (the "Soft=
ware"),
> > - * to deal in the Software without restriction, including without limi=
tation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > - * and/or sell copies of the Software, and to permit persons to whom t=
he
> > - * Software is furnished to do so, subject to the following conditions=
:
> > - *
> > - * The above copyright notice and this permission notice shall be incl=
uded in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - */
> > -
> > -#include <linux/firmware.h>
> > -#include <linux/module.h>
> > -#include "amdgpu.h"
> > -#include "amdgpu_reset.h"
> > -#include "soc15_common.h"
> > -#include "nv.h"
> > -#include "gc/gc_10_1_0_offset.h"
> > -#include "gc/gc_10_1_0_sh_mask.h"
> > -#include "gc/gc_10_1_0_default.h"
> > -#include "v10_structs.h"
> > -#include "mes_api_def.h"
> > -
> > -#define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid               0x2820
> > -#define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid_BASE_IDX      1
> > -#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid             0x4ca1
> > -#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid_BASE_IDX    1
> > -
> > -MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
> > -MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes.bin");
> > -MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes1.bin");
> > -
> > -static int mes_v10_1_hw_fini(void *handle);
> > -static int mes_v10_1_kiq_hw_init(struct amdgpu_device *adev);
> > -
> > -#define MES_EOP_SIZE   2048
> > -
> > -static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
> > -{
> > -       struct amdgpu_device *adev =3D ring->adev;
> > -
> > -       if (ring->use_doorbell) {
> > -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> > -                            ring->wptr);
> > -               WDOORBELL64(ring->doorbell_index, ring->wptr);
> > -       } else {
> > -               BUG();
> > -       }
> > -}
> > -
> > -static u64 mes_v10_1_ring_get_rptr(struct amdgpu_ring *ring)
> > -{
> > -       return *ring->rptr_cpu_addr;
> > -}
> > -
> > -static u64 mes_v10_1_ring_get_wptr(struct amdgpu_ring *ring)
> > -{
> > -       u64 wptr;
> > -
> > -       if (ring->use_doorbell)
> > -               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_add=
r);
> > -       else
> > -               BUG();
> > -       return wptr;
> > -}
> > -
> > -static const struct amdgpu_ring_funcs mes_v10_1_ring_funcs =3D {
> > -       .type =3D AMDGPU_RING_TYPE_MES,
> > -       .align_mask =3D 1,
> > -       .nop =3D 0,
> > -       .support_64bit_ptrs =3D true,
> > -       .get_rptr =3D mes_v10_1_ring_get_rptr,
> > -       .get_wptr =3D mes_v10_1_ring_get_wptr,
> > -       .set_wptr =3D mes_v10_1_ring_set_wptr,
> > -       .insert_nop =3D amdgpu_ring_insert_nop,
> > -};
> > -
> > -static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes =
*mes,
> > -                                                   void *pkt, int size=
,
> > -                                                   int api_status_off)
> > -{
> > -       int ndw =3D size / 4;
> > -       signed long r;
> > -       union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
> > -       struct MES_API_STATUS *api_status;
> > -       struct amdgpu_device *adev =3D mes->adev;
> > -       struct amdgpu_ring *ring =3D &mes->ring;
> > -       unsigned long flags;
> > -
> > -       BUG_ON(size % 4 !=3D 0);
> > -
> > -       spin_lock_irqsave(&mes->ring_lock, flags);
> > -       if (amdgpu_ring_alloc(ring, ndw)) {
> > -               spin_unlock_irqrestore(&mes->ring_lock, flags);
> > -               return -ENOMEM;
> > -       }
> > -
> > -       api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_stat=
us_off);
> > -       api_status->api_completion_fence_addr =3D mes->ring.fence_drv.g=
pu_addr;
> > -       api_status->api_completion_fence_value =3D ++mes->ring.fence_dr=
v.sync_seq;
> > -
> > -       amdgpu_ring_write_multiple(ring, pkt, ndw);
> > -       amdgpu_ring_commit(ring);
> > -       spin_unlock_irqrestore(&mes->ring_lock, flags);
> > -
> > -       DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
> > -
> > -       r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
> > -                                     adev->usec_timeout);
> > -       if (r < 1) {
> > -               DRM_ERROR("MES failed to response msg=3D%d\n",
> > -                         x_pkt->header.opcode);
> > -
> > -               while (halt_if_hws_hang)
> > -                       schedule();
> > -
> > -               return -ETIMEDOUT;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int convert_to_mes_queue_type(int queue_type)
> > -{
> > -       if (queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
> > -               return MES_QUEUE_TYPE_GFX;
> > -       else if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
> > -               return MES_QUEUE_TYPE_COMPUTE;
> > -       else if (queue_type =3D=3D AMDGPU_RING_TYPE_SDMA)
> > -               return MES_QUEUE_TYPE_SDMA;
> > -       else
> > -               BUG();
> > -       return -1;
> > -}
> > -
> > -static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
> > -                                 struct mes_add_queue_input *input)
> > -{
> > -       struct amdgpu_device *adev =3D mes->adev;
> > -       union MESAPI__ADD_QUEUE mes_add_queue_pkt;
> > -       struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> > -       uint32_t vm_cntx_cntl =3D hub->vm_cntx_cntl;
> > -
> > -       memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
> > -
> > -       mes_add_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > -       mes_add_queue_pkt.header.opcode =3D MES_SCH_API_ADD_QUEUE;
> > -       mes_add_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> > -
> > -       mes_add_queue_pkt.process_id =3D input->process_id;
> > -       mes_add_queue_pkt.page_table_base_addr =3D input->page_table_ba=
se_addr;
> > -       mes_add_queue_pkt.process_va_start =3D input->process_va_start;
> > -       mes_add_queue_pkt.process_va_end =3D input->process_va_end;
> > -       mes_add_queue_pkt.process_quantum =3D input->process_quantum;
> > -       mes_add_queue_pkt.process_context_addr =3D input->process_conte=
xt_addr;
> > -       mes_add_queue_pkt.gang_quantum =3D input->gang_quantum;
> > -       mes_add_queue_pkt.gang_context_addr =3D input->gang_context_add=
r;
> > -       mes_add_queue_pkt.inprocess_gang_priority =3D
> > -               input->inprocess_gang_priority;
> > -       mes_add_queue_pkt.gang_global_priority_level =3D
> > -               input->gang_global_priority_level;
> > -       mes_add_queue_pkt.doorbell_offset =3D input->doorbell_offset;
> > -       mes_add_queue_pkt.mqd_addr =3D input->mqd_addr;
> > -       mes_add_queue_pkt.wptr_addr =3D input->wptr_addr;
> > -       mes_add_queue_pkt.queue_type =3D
> > -               convert_to_mes_queue_type(input->queue_type);
> > -       mes_add_queue_pkt.paging =3D input->paging;
> > -       mes_add_queue_pkt.vm_context_cntl =3D vm_cntx_cntl;
> > -       mes_add_queue_pkt.gws_base =3D input->gws_base;
> > -       mes_add_queue_pkt.gws_size =3D input->gws_size;
> > -       mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
> > -
> > -       return mes_v10_1_submit_pkt_and_poll_completion(mes,
> > -                       &mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
> > -                       offsetof(union MESAPI__ADD_QUEUE, api_status));
> > -}
> > -
> > -static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
> > -                                    struct mes_remove_queue_input *inp=
ut)
> > -{
> > -       union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
> > -
> > -       memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
> > -
> > -       mes_remove_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > -       mes_remove_queue_pkt.header.opcode =3D MES_SCH_API_REMOVE_QUEUE=
;
> > -       mes_remove_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS=
;
> > -
> > -       mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset=
;
> > -       mes_remove_queue_pkt.gang_context_addr =3D input->gang_context_=
addr;
> > -
> > -       return mes_v10_1_submit_pkt_and_poll_completion(mes,
> > -                       &mes_remove_queue_pkt, sizeof(mes_remove_queue_=
pkt),
> > -                       offsetof(union MESAPI__REMOVE_QUEUE, api_status=
));
> > -}
> > -
> > -static int mes_v10_1_unmap_legacy_queue(struct amdgpu_mes *mes,
> > -                                struct mes_unmap_legacy_queue_input *i=
nput)
> > -{
> > -       union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
> > -
> > -       memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
> > -
> > -       mes_remove_queue_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > -       mes_remove_queue_pkt.header.opcode =3D MES_SCH_API_REMOVE_QUEUE=
;
> > -       mes_remove_queue_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS=
;
> > -
> > -       mes_remove_queue_pkt.doorbell_offset =3D input->doorbell_offset=
;
> > -       mes_remove_queue_pkt.gang_context_addr =3D 0;
> > -
> > -       mes_remove_queue_pkt.pipe_id =3D input->pipe_id;
> > -       mes_remove_queue_pkt.queue_id =3D input->queue_id;
> > -
> > -       if (input->action =3D=3D PREEMPT_QUEUES_NO_UNMAP) {
> > -               mes_remove_queue_pkt.preempt_legacy_gfx_queue =3D 1;
> > -               mes_remove_queue_pkt.tf_addr =3D input->trail_fence_add=
r;
> > -               mes_remove_queue_pkt.tf_data =3D
> > -                       lower_32_bits(input->trail_fence_data);
> > -       } else {
> > -               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
> > -                       mes_remove_queue_pkt.unmap_legacy_gfx_queue =3D=
 1;
> > -               else
> > -                       mes_remove_queue_pkt.unmap_kiq_utility_queue =
=3D 1;
> > -       }
> > -
> > -       return mes_v10_1_submit_pkt_and_poll_completion(mes,
> > -                       &mes_remove_queue_pkt, sizeof(mes_remove_queue_=
pkt),
> > -                       offsetof(union MESAPI__REMOVE_QUEUE, api_status=
));
> > -}
> > -
> > -static int mes_v10_1_suspend_gang(struct amdgpu_mes *mes,
> > -                                 struct mes_suspend_gang_input *input)
> > -{
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_resume_gang(struct amdgpu_mes *mes,
> > -                                struct mes_resume_gang_input *input)
> > -{
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
> > -{
> > -       union MESAPI__QUERY_MES_STATUS mes_status_pkt;
> > -
> > -       memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
> > -
> > -       mes_status_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > -       mes_status_pkt.header.opcode =3D MES_SCH_API_QUERY_SCHEDULER_ST=
ATUS;
> > -       mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> > -
> > -       return mes_v10_1_submit_pkt_and_poll_completion(mes,
> > -                       &mes_status_pkt, sizeof(mes_status_pkt),
> > -                       offsetof(union MESAPI__QUERY_MES_STATUS, api_st=
atus));
> > -}
> > -
> > -static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
> > -{
> > -       int i;
> > -       struct amdgpu_device *adev =3D mes->adev;
> > -       union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
> > -
> > -       memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
> > -
> > -       mes_set_hw_res_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> > -       mes_set_hw_res_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC;
> > -       mes_set_hw_res_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> > -
> > -       mes_set_hw_res_pkt.vmid_mask_mmhub =3D mes->vmid_mask_mmhub;
> > -       mes_set_hw_res_pkt.vmid_mask_gfxhub =3D mes->vmid_mask_gfxhub;
> > -       mes_set_hw_res_pkt.gds_size =3D adev->gds.gds_size;
> > -       mes_set_hw_res_pkt.paging_vmid =3D 0;
> > -       mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr =3D mes->sch_ctx_gpu_ad=
dr;
> > -       mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =3D
> > -               mes->query_status_fence_gpu_addr;
> > -
> > -       for (i =3D 0; i < MAX_COMPUTE_PIPES; i++)
> > -               mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
> > -                       mes->compute_hqd_mask[i];
> > -
> > -       for (i =3D 0; i < MAX_GFX_PIPES; i++)
> > -               mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D mes->gfx_hqd_mas=
k[i];
> > -
> > -       for (i =3D 0; i < MAX_SDMA_PIPES; i++)
> > -               mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes->sdma_hqd_m=
ask[i];
> > -
> > -       for (i =3D 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
> > -               mes_set_hw_res_pkt.aggregated_doorbells[i] =3D
> > -                       mes->aggregated_doorbells[i];
> > -
> > -       for (i =3D 0; i < 5; i++) {
> > -               mes_set_hw_res_pkt.gc_base[i] =3D adev->reg_offset[GC_H=
WIP][0][i];
> > -               mes_set_hw_res_pkt.mmhub_base[i] =3D
> > -                       adev->reg_offset[MMHUB_HWIP][0][i];
> > -               mes_set_hw_res_pkt.osssys_base[i] =3D
> > -                       adev->reg_offset[OSSSYS_HWIP][0][i];
> > -       }
> > -
> > -       mes_set_hw_res_pkt.disable_reset =3D 1;
> > -       mes_set_hw_res_pkt.disable_mes_log =3D 1;
> > -       mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
> > -
> > -       return mes_v10_1_submit_pkt_and_poll_completion(mes,
> > -                       &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt)=
,
> > -                       offsetof(union MESAPI_SET_HW_RESOURCES, api_sta=
tus));
> > -}
> > -
> > -static void mes_v10_1_init_aggregated_doorbell(struct amdgpu_mes *mes)
> > -{
> > -       struct amdgpu_device *adev =3D mes->adev;
> > -       uint32_t data;
> > -
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL1);
> > -       data &=3D ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
> > -                 CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
> > -                 CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
> > -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_L=
OW] <<
> > -               CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
> > -       data |=3D 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL1, data);
> > -
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL2);
> > -       data &=3D ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
> > -                 CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
> > -                 CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
> > -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_N=
ORMAL] <<
> > -               CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
> > -       data |=3D 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL2, data);
> > -
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL3);
> > -       data &=3D ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
> > -                 CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
> > -                 CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
> > -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_M=
EDIUM] <<
> > -               CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
> > -       data |=3D 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL3, data);
> > -
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL4);
> > -       data &=3D ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
> > -                 CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
> > -                 CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
> > -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_H=
IGH] <<
> > -               CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
> > -       data |=3D 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL4, data);
> > -
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL5);
> > -       data &=3D ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
> > -                 CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
> > -                 CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
> > -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_R=
EALTIME] <<
> > -               CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
> > -       data |=3D 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_MES_DOORBELL_CONTROL5, data);
> > -
> > -       data =3D 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_GFX_CONTROL, data);
> > -}
> > -
> > -static const struct amdgpu_mes_funcs mes_v10_1_funcs =3D {
> > -       .add_hw_queue =3D mes_v10_1_add_hw_queue,
> > -       .remove_hw_queue =3D mes_v10_1_remove_hw_queue,
> > -       .unmap_legacy_queue =3D mes_v10_1_unmap_legacy_queue,
> > -       .suspend_gang =3D mes_v10_1_suspend_gang,
> > -       .resume_gang =3D mes_v10_1_resume_gang,
> > -};
> > -
> > -static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev,
> > -                                          enum admgpu_mes_pipe pipe)
> > -{
> > -       int r;
> > -       const struct mes_firmware_header_v1_0 *mes_hdr;
> > -       const __le32 *fw_data;
> > -       unsigned fw_size;
> > -
> > -       mes_hdr =3D (const struct mes_firmware_header_v1_0 *)
> > -               adev->mes.fw[pipe]->data;
> > -
> > -       fw_data =3D (const __le32 *)(adev->mes.fw[pipe]->data +
> > -                  le32_to_cpu(mes_hdr->mes_ucode_offset_bytes));
> > -       fw_size =3D le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
> > -
> > -       r =3D amdgpu_bo_create_reserved(adev, fw_size,
> > -                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> > -                                     &adev->mes.ucode_fw_obj[pipe],
> > -                                     &adev->mes.ucode_fw_gpu_addr[pipe=
],
> > -                                     (void **)&adev->mes.ucode_fw_ptr[=
pipe]);
> > -       if (r) {
> > -               dev_err(adev->dev, "(%d) failed to create mes fw bo\n",=
 r);
> > -               return r;
> > -       }
> > -
> > -       memcpy(adev->mes.ucode_fw_ptr[pipe], fw_data, fw_size);
> > -
> > -       amdgpu_bo_kunmap(adev->mes.ucode_fw_obj[pipe]);
> > -       amdgpu_bo_unreserve(adev->mes.ucode_fw_obj[pipe]);
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_allocate_ucode_data_buffer(struct amdgpu_device *=
adev,
> > -                                               enum admgpu_mes_pipe pi=
pe)
> > -{
> > -       int r;
> > -       const struct mes_firmware_header_v1_0 *mes_hdr;
> > -       const __le32 *fw_data;
> > -       unsigned fw_size;
> > -
> > -       mes_hdr =3D (const struct mes_firmware_header_v1_0 *)
> > -               adev->mes.fw[pipe]->data;
> > -
> > -       fw_data =3D (const __le32 *)(adev->mes.fw[pipe]->data +
> > -                  le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
> > -       fw_size =3D le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
> > -
> > -       r =3D amdgpu_bo_create_reserved(adev, fw_size,
> > -                                     64 * 1024, AMDGPU_GEM_DOMAIN_GTT,
> > -                                     &adev->mes.data_fw_obj[pipe],
> > -                                     &adev->mes.data_fw_gpu_addr[pipe]=
,
> > -                                     (void **)&adev->mes.data_fw_ptr[p=
ipe]);
> > -       if (r) {
> > -               dev_err(adev->dev, "(%d) failed to create mes data fw b=
o\n", r);
> > -               return r;
> > -       }
> > -
> > -       memcpy(adev->mes.data_fw_ptr[pipe], fw_data, fw_size);
> > -
> > -       amdgpu_bo_kunmap(adev->mes.data_fw_obj[pipe]);
> > -       amdgpu_bo_unreserve(adev->mes.data_fw_obj[pipe]);
> > -
> > -       return 0;
> > -}
> > -
> > -static void mes_v10_1_free_ucode_buffers(struct amdgpu_device *adev,
> > -                                        enum admgpu_mes_pipe pipe)
> > -{
> > -       amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
> > -                             &adev->mes.data_fw_gpu_addr[pipe],
> > -                             (void **)&adev->mes.data_fw_ptr[pipe]);
> > -
> > -       amdgpu_bo_free_kernel(&adev->mes.ucode_fw_obj[pipe],
> > -                             &adev->mes.ucode_fw_gpu_addr[pipe],
> > -                             (void **)&adev->mes.ucode_fw_ptr[pipe]);
> > -}
> > -
> > -static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
> > -{
> > -       uint32_t pipe, data =3D 0;
> > -
> > -       if (enable) {
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RES=
ET, 1);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL,
> > -                            MES_PIPE1_RESET, adev->enable_mes_kiq ? 1 =
: 0);
> > -               WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
> > -
> > -               mutex_lock(&adev->srbm_mutex);
> > -               for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > -                       if (!adev->enable_mes_kiq &&
> > -                           pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> > -                               continue;
> > -
> > -                       nv_grbm_select(adev, 3, pipe, 0, 0);
> > -                       WREG32_SOC15(GC, 0, mmCP_MES_PRGRM_CNTR_START,
> > -                            (uint32_t)(adev->mes.uc_start_addr[pipe]) =
>> 2);
> > -               }
> > -               nv_grbm_select(adev, 0, 0, 0, 0);
> > -               mutex_unlock(&adev->srbm_mutex);
> > -
> > -               /* clear BYPASS_UNCACHED to avoid hangs after interrupt=
. */
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_DC_OP_CNTL);
> > -               data =3D REG_SET_FIELD(data, CP_MES_DC_OP_CNTL,
> > -                                    BYPASS_UNCACHED, 0);
> > -               WREG32_SOC15(GC, 0, mmCP_MES_DC_OP_CNTL, data);
> > -
> > -               /* unhalt MES and activate pipe0 */
> > -               data =3D REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE=
, 1);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACT=
IVE,
> > -                                    adev->enable_mes_kiq ? 1 : 0);
> > -               WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
> > -               udelay(100);
> > -       } else {
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACT=
IVE, 0);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACT=
IVE, 0);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL,
> > -                                    MES_INVALIDATE_ICACHE, 1);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RES=
ET, 1);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RES=
ET,
> > -                                    adev->enable_mes_kiq ? 1 : 0);
> > -               data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_HALT, 1);
> > -               WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
> > -       }
> > -}
> > -
> > -/* This function is for backdoor MES firmware */
> > -static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
> > -                                   enum admgpu_mes_pipe pipe)
> > -{
> > -       int r;
> > -       uint32_t data;
> > -
> > -       mes_v10_1_enable(adev, false);
> > -
> > -       if (!adev->mes.fw[pipe])
> > -               return -EINVAL;
> > -
> > -       r =3D mes_v10_1_allocate_ucode_buffer(adev, pipe);
> > -       if (r)
> > -               return r;
> > -
> > -       r =3D mes_v10_1_allocate_ucode_data_buffer(adev, pipe);
> > -       if (r) {
> > -               mes_v10_1_free_ucode_buffers(adev, pipe);
> > -               return r;
> > -       }
> > -
> > -       WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_CNTL, 0);
> > -
> > -       mutex_lock(&adev->srbm_mutex);
> > -       /* me=3D3, pipe=3D0, queue=3D0 */
> > -       nv_grbm_select(adev, 3, pipe, 0, 0);
> > -
> > -       /* set ucode start address */
> > -       WREG32_SOC15(GC, 0, mmCP_MES_PRGRM_CNTR_START,
> > -                    (uint32_t)(adev->mes.uc_start_addr[pipe]) >> 2);
> > -
> > -       /* set ucode fimrware address */
> > -       WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_LO,
> > -                    lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
> > -       WREG32_SOC15(GC, 0, mmCP_MES_IC_BASE_HI,
> > -                    upper_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
> > -
> > -       /* set ucode instruction cache boundary to 2M-1 */
> > -       WREG32_SOC15(GC, 0, mmCP_MES_MIBOUND_LO, 0x1FFFFF);
> > -
> > -       /* set ucode data firmware address */
> > -       WREG32_SOC15(GC, 0, mmCP_MES_MDBASE_LO,
> > -                    lower_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
> > -       WREG32_SOC15(GC, 0, mmCP_MES_MDBASE_HI,
> > -                    upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
> > -
> > -       /* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
> > -       WREG32_SOC15(GC, 0, mmCP_MES_MDBOUND_LO, 0x3FFFF);
> > -
> > -       /* invalidate ICACHE */
> > -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 3, 0):
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna=
_Cichlid);
> > -               break;
> > -       default:
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
> > -               break;
> > -       }
> > -       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0=
);
> > -       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACH=
E, 1);
> > -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 3, 0):
> > -               WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid,=
 data);
> > -               break;
> > -       default:
> > -               WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
> > -               break;
> > -       }
> > -
> > -       /* prime the ICACHE. */
> > -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 3, 0):
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna=
_Cichlid);
> > -               break;
> > -       default:
> > -               data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL);
> > -               break;
> > -       }
> > -       data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1=
);
> > -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 3, 0):
> > -               WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid,=
 data);
> > -               break;
> > -       default:
> > -               WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL, data);
> > -               break;
> > -       }
> > -
> > -       nv_grbm_select(adev, 0, 0, 0, 0);
> > -       mutex_unlock(&adev->srbm_mutex);
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_allocate_eop_buf(struct amdgpu_device *adev,
> > -                                     enum admgpu_mes_pipe pipe)
> > -{
> > -       int r;
> > -       u32 *eop;
> > -
> > -       r =3D amdgpu_bo_create_reserved(adev, MES_EOP_SIZE, PAGE_SIZE,
> > -                             AMDGPU_GEM_DOMAIN_GTT,
> > -                             &adev->mes.eop_gpu_obj[pipe],
> > -                             &adev->mes.eop_gpu_addr[pipe],
> > -                             (void **)&eop);
> > -       if (r) {
> > -               dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
> > -               return r;
> > -       }
> > -
> > -       memset(eop, 0, adev->mes.eop_gpu_obj[pipe]->tbo.base.size);
> > -
> > -       amdgpu_bo_kunmap(adev->mes.eop_gpu_obj[pipe]);
> > -       amdgpu_bo_unreserve(adev->mes.eop_gpu_obj[pipe]);
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
> > -{
> > -       struct v10_compute_mqd *mqd =3D ring->mqd_ptr;
> > -       uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
> > -       uint32_t tmp;
> > -
> > -       memset(mqd, 0, sizeof(*mqd));
> > -
> > -       mqd->header =3D 0xC0310800;
> > -       mqd->compute_pipelinestat_enable =3D 0x00000001;
> > -       mqd->compute_static_thread_mgmt_se0 =3D 0xffffffff;
> > -       mqd->compute_static_thread_mgmt_se1 =3D 0xffffffff;
> > -       mqd->compute_static_thread_mgmt_se2 =3D 0xffffffff;
> > -       mqd->compute_static_thread_mgmt_se3 =3D 0xffffffff;
> > -       mqd->compute_misc_reserved =3D 0x00000003;
> > -
> > -       eop_base_addr =3D ring->eop_gpu_addr >> 8;
> > -
> > -       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> > -       tmp =3D mmCP_HQD_EOP_CONTROL_DEFAULT;
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
> > -                       (order_base_2(MES_EOP_SIZE / 4) - 1));
> > -
> > -       mqd->cp_hqd_eop_base_addr_lo =3D lower_32_bits(eop_base_addr);
> > -       mqd->cp_hqd_eop_base_addr_hi =3D upper_32_bits(eop_base_addr);
> > -       mqd->cp_hqd_eop_control =3D tmp;
> > -
> > -       /* disable the queue if it's active */
> > -       ring->wptr =3D 0;
> > -       mqd->cp_hqd_pq_rptr =3D 0;
> > -       mqd->cp_hqd_pq_wptr_lo =3D 0;
> > -       mqd->cp_hqd_pq_wptr_hi =3D 0;
> > -
> > -       /* set the pointer to the MQD */
> > -       mqd->cp_mqd_base_addr_lo =3D ring->mqd_gpu_addr & 0xfffffffc;
> > -       mqd->cp_mqd_base_addr_hi =3D upper_32_bits(ring->mqd_gpu_addr);
> > -
> > -       /* set MQD vmid to 0 */
> > -       tmp =3D mmCP_MQD_CONTROL_DEFAULT;
> > -       tmp =3D REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
> > -       mqd->cp_mqd_control =3D tmp;
> > -
> > -       /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI =
*/
> > -       hqd_gpu_addr =3D ring->gpu_addr >> 8;
> > -       mqd->cp_hqd_pq_base_lo =3D lower_32_bits(hqd_gpu_addr);
> > -       mqd->cp_hqd_pq_base_hi =3D upper_32_bits(hqd_gpu_addr);
> > -
> > -       /* set the wb address whether it's enabled or not */
> > -       wb_gpu_addr =3D ring->rptr_gpu_addr;
> > -       mqd->cp_hqd_pq_rptr_report_addr_lo =3D wb_gpu_addr & 0xfffffffc=
;
> > -       mqd->cp_hqd_pq_rptr_report_addr_hi =3D
> > -               upper_32_bits(wb_gpu_addr) & 0xffff;
> > -
> > -       /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_M=
ASK=3D1 */
> > -       wb_gpu_addr =3D ring->wptr_gpu_addr;
> > -       mqd->cp_hqd_pq_wptr_poll_addr_lo =3D wb_gpu_addr & 0xfffffff8;
> > -       mqd->cp_hqd_pq_wptr_poll_addr_hi =3D upper_32_bits(wb_gpu_addr)=
 & 0xffff;
> > -
> > -       /* set up the HQD, this is similar to CP_RB0_CNTL */
> > -       tmp =3D mmCP_HQD_PQ_CONTROL_DEFAULT;
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
> > -                           (order_base_2(ring->ring_size / 4) - 1));
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
> > -                           ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - =
1) << 8));
> > -#ifdef __BIG_ENDIAN
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
> > -#endif
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1=
);
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, =
0);
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, NO_UPDATE_RPTR, 1=
);
> > -       mqd->cp_hqd_pq_control =3D tmp;
> > -
> > -       /* enable doorbell? */
> > -       tmp =3D 0;
> > -       if (ring->use_doorbell) {
> > -               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                                   DOORBELL_OFFSET, ring->doorbell_ind=
ex);
> > -               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                                   DOORBELL_EN, 1);
> > -               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                                   DOORBELL_SOURCE, 0);
> > -               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                                   DOORBELL_HIT, 0);
> > -       }
> > -       else
> > -               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                                   DOORBELL_EN, 0);
> > -       mqd->cp_hqd_pq_doorbell_control =3D tmp;
> > -
> > -       mqd->cp_hqd_vmid =3D 0;
> > -       /* activate the queue */
> > -       mqd->cp_hqd_active =3D 1;
> > -       mqd->cp_hqd_persistent_state =3D mmCP_HQD_PERSISTENT_STATE_DEFA=
ULT;
> > -       mqd->cp_hqd_ib_control =3D mmCP_HQD_IB_CONTROL_DEFAULT;
> > -       mqd->cp_hqd_iq_timer =3D mmCP_HQD_IQ_TIMER_DEFAULT;
> > -       mqd->cp_hqd_quantum =3D mmCP_HQD_QUANTUM_DEFAULT;
> > -
> > -       tmp =3D mmCP_HQD_GFX_CONTROL_DEFAULT;
> > -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_E=
N, 1);
> > -       /* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
> > -       mqd->cp_hqd_suspend_cntl_stack_offset =3D tmp;
> > -
> > -       amdgpu_device_flush_hdp(ring->adev, NULL);
> > -       return 0;
> > -}
> > -
> > -#if 0
> > -static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
> > -{
> > -       struct v10_compute_mqd *mqd =3D ring->mqd_ptr;
> > -       struct amdgpu_device *adev =3D ring->adev;
> > -       uint32_t data =3D 0;
> > -
> > -       mutex_lock(&adev->srbm_mutex);
> > -       nv_grbm_select(adev, 3, ring->pipe, 0, 0);
> > -
> > -       /* set CP_HQD_VMID.VMID =3D 0. */
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_HQD_VMID);
> > -       data =3D REG_SET_FIELD(data, CP_HQD_VMID, VMID, 0);
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_VMID, data);
> > -
> > -       /* set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_EN=3D0 */
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL);
> > -       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> > -                            DOORBELL_EN, 0);
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);
> > -
> > -       /* set CP_MQD_BASE_ADDR/HI with the MQD base address */
> > -       WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr_l=
o);
> > -       WREG32_SOC15(GC, 0, mmCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_add=
r_hi);
> > -
> > -       /* set CP_MQD_CONTROL.VMID=3D0 */
> > -       data =3D RREG32_SOC15(GC, 0, mmCP_MQD_CONTROL);
> > -       data =3D REG_SET_FIELD(data, CP_MQD_CONTROL, VMID, 0);
> > -       WREG32_SOC15(GC, 0, mmCP_MQD_CONTROL, 0);
> > -
> > -       /* set CP_HQD_PQ_BASE/HI with the ring buffer base address */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE, mqd->cp_hqd_pq_base_lo);
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI, mqd->cp_hqd_pq_base_hi=
);
> > -
> > -       /* set CP_HQD_PQ_RPTR_REPORT_ADDR/HI */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR,
> > -                    mqd->cp_hqd_pq_rptr_report_addr_lo);
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
> > -                    mqd->cp_hqd_pq_rptr_report_addr_hi);
> > -
> > -       /* set CP_HQD_PQ_CONTROL */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_CONTROL, mqd->cp_hqd_pq_control=
);
> > -
> > -       /* set CP_HQD_PQ_WPTR_POLL_ADDR/HI */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
> > -                    mqd->cp_hqd_pq_wptr_poll_addr_lo);
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
> > -                    mqd->cp_hqd_pq_wptr_poll_addr_hi);
> > -
> > -       /* set CP_HQD_PQ_DOORBELL_CONTROL */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
> > -                    mqd->cp_hqd_pq_doorbell_control);
> > -
> > -       /* set CP_HQD_PERSISTENT_STATE.PRELOAD_SIZE=3D0x53 */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_PERSISTENT_STATE, mqd->cp_hqd_pers=
istent_state);
> > -
> > -       /* set CP_HQD_ACTIVE.ACTIVE=3D1 */
> > -       WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, mqd->cp_hqd_active);
> > -
> > -       nv_grbm_select(adev, 0, 0, 0, 0);
> > -       mutex_unlock(&adev->srbm_mutex);
> > -}
> > -#endif
> > -
> > -static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
> > -{
> > -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
> > -       int r;
> > -
> > -       if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
> > -               return -EINVAL;
> > -
> > -       r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
> > -       if (r) {
> > -               DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> > -               return r;
> > -       }
> > -
> > -       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
> > -
> > -       return amdgpu_ring_test_helper(kiq_ring);
> > -}
> > -
> > -static int mes_v10_1_queue_init(struct amdgpu_device *adev)
> > -{
> > -       int r;
> > -
> > -       r =3D mes_v10_1_mqd_init(&adev->mes.ring);
> > -       if (r)
> > -               return r;
> > -
> > -       r =3D mes_v10_1_kiq_enable_queue(adev);
> > -       if (r)
> > -               return r;
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_ring_init(struct amdgpu_device *adev)
> > -{
> > -       struct amdgpu_ring *ring;
> > -
> > -       ring =3D &adev->mes.ring;
> > -
> > -       ring->funcs =3D &mes_v10_1_ring_funcs;
> > -
> > -       ring->me =3D 3;
> > -       ring->pipe =3D 0;
> > -       ring->queue =3D 0;
> > -
> > -       ring->ring_obj =3D NULL;
> > -       ring->use_doorbell =3D true;
> > -       ring->doorbell_index =3D adev->doorbell_index.mes_ring0 << 1;
> > -       ring->eop_gpu_addr =3D adev->mes.eop_gpu_addr[AMDGPU_MES_SCHED_=
PIPE];
> > -       ring->no_scheduler =3D true;
> > -       sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring-=
>queue);
> > -
> > -       return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
> > -                               AMDGPU_RING_PRIO_DEFAULT, NULL);
> > -}
> > -
> > -static int mes_v10_1_kiq_ring_init(struct amdgpu_device *adev)
> > -{
> > -       struct amdgpu_ring *ring;
> > -
> > -       spin_lock_init(&adev->gfx.kiq[0].ring_lock);
> > -
> > -       ring =3D &adev->gfx.kiq[0].ring;
> > -
> > -       ring->me =3D 3;
> > -       ring->pipe =3D 1;
> > -       ring->queue =3D 0;
> > -
> > -       ring->adev =3D NULL;
> > -       ring->ring_obj =3D NULL;
> > -       ring->use_doorbell =3D true;
> > -       ring->doorbell_index =3D adev->doorbell_index.mes_ring1 << 1;
> > -       ring->eop_gpu_addr =3D adev->mes.eop_gpu_addr[AMDGPU_MES_KIQ_PI=
PE];
> > -       ring->no_scheduler =3D true;
> > -       sprintf(ring->name, "mes_kiq_%d.%d.%d",
> > -               ring->me, ring->pipe, ring->queue);
> > -
> > -       return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
> > -                               AMDGPU_RING_PRIO_DEFAULT, NULL);
> > -}
> > -
> > -static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
> > -                                enum admgpu_mes_pipe pipe)
> > -{
> > -       int r, mqd_size =3D sizeof(struct v10_compute_mqd);
> > -       struct amdgpu_ring *ring;
> > -
> > -       if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> > -               ring =3D &adev->gfx.kiq[0].ring;
> > -       else if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
> > -               ring =3D &adev->mes.ring;
> > -       else
> > -               BUG();
> > -
> > -       if (ring->mqd_obj)
> > -               return 0;
> > -
> > -       r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM |
> > -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_o=
bj,
> > -                                   &ring->mqd_gpu_addr, &ring->mqd_ptr=
);
> > -       if (r) {
> > -               dev_warn(adev->dev, "failed to create ring mqd bo (%d)"=
, r);
> > -               return r;
> > -       }
> > -       memset(ring->mqd_ptr, 0, mqd_size);
> > -
> > -       /* prepare MQD backup */
> > -       adev->mes.mqd_backup[pipe] =3D kmalloc(mqd_size, GFP_KERNEL);
> > -       if (!adev->mes.mqd_backup[pipe]) {
> > -               dev_warn(adev->dev,
> > -                        "no memory to create MQD backup for ring %s\n"=
,
> > -                        ring->name);
> > -               return -ENOMEM;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_sw_init(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -       int pipe, r;
> > -
> > -       adev->mes.funcs =3D &mes_v10_1_funcs;
> > -       adev->mes.kiq_hw_init =3D &mes_v10_1_kiq_hw_init;
> > -
> > -       r =3D amdgpu_mes_init(adev);
> > -       if (r)
> > -               return r;
> > -
> > -       for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > -               if (!adev->enable_mes_kiq && pipe =3D=3D AMDGPU_MES_KIQ=
_PIPE)
> > -                       continue;
> > -
> > -               r =3D mes_v10_1_allocate_eop_buf(adev, pipe);
> > -               if (r)
> > -                       return r;
> > -
> > -               r =3D mes_v10_1_mqd_sw_init(adev, pipe);
> > -               if (r)
> > -                       return r;
> > -       }
> > -
> > -       if (adev->enable_mes_kiq) {
> > -               r =3D mes_v10_1_kiq_ring_init(adev);
> > -               if (r)
> > -                       return r;
> > -       }
> > -
> > -       r =3D mes_v10_1_ring_init(adev);
> > -       if (r)
> > -               return r;
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_sw_fini(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -       int pipe;
> > -
> > -       amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
> > -       amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
> > -
> > -       for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > -               kfree(adev->mes.mqd_backup[pipe]);
> > -
> > -               amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
> > -                                     &adev->mes.eop_gpu_addr[pipe],
> > -                                     NULL);
> > -               amdgpu_ucode_release(&adev->mes.fw[pipe]);
> > -       }
> > -
> > -       amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
> > -                             &adev->gfx.kiq[0].ring.mqd_gpu_addr,
> > -                             &adev->gfx.kiq[0].ring.mqd_ptr);
> > -
> > -       amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
> > -                             &adev->mes.ring.mqd_gpu_addr,
> > -                             &adev->mes.ring.mqd_ptr);
> > -
> > -       amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
> > -       amdgpu_ring_fini(&adev->mes.ring);
> > -
> > -       amdgpu_mes_fini(adev);
> > -       return 0;
> > -}
> > -
> > -static void mes_v10_1_kiq_setting(struct amdgpu_ring *ring)
> > -{
> > -       uint32_t tmp;
> > -       struct amdgpu_device *adev =3D ring->adev;
> > -
> > -       /* tell RLC which is KIQ queue */
> > -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > -       case IP_VERSION(10, 3, 0):
> > -       case IP_VERSION(10, 3, 2):
> > -       case IP_VERSION(10, 3, 1):
> > -       case IP_VERSION(10, 3, 4):
> > -               tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_=
Cichlid);
> > -               tmp &=3D 0xffffff00;
> > -               tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->q=
ueue);
> > -               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid,=
 tmp);
> > -               tmp |=3D 0x80;
> > -               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid,=
 tmp);
> > -               break;
> > -       default:
> > -               tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
> > -               tmp &=3D 0xffffff00;
> > -               tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->q=
ueue);
> > -               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
> > -               tmp |=3D 0x80;
> > -               WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
> > -               break;
> > -       }
> > -}
> > -
> > -static int mes_v10_1_kiq_hw_init(struct amdgpu_device *adev)
> > -{
> > -       int r =3D 0;
> > -
> > -       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
> > -               r =3D mes_v10_1_load_microcode(adev, AMDGPU_MES_KIQ_PIP=
E);
> > -               if (r) {
> > -                       DRM_ERROR("failed to load MES kiq fw, r=3D%d\n"=
, r);
> > -                       return r;
> > -               }
> > -
> > -               r =3D mes_v10_1_load_microcode(adev, AMDGPU_MES_SCHED_P=
IPE);
> > -               if (r) {
> > -                       DRM_ERROR("failed to load MES fw, r=3D%d\n", r)=
;
> > -                       return r;
> > -               }
> > -       }
> > -
> > -       mes_v10_1_enable(adev, true);
> > -
> > -       mes_v10_1_kiq_setting(&adev->gfx.kiq[0].ring);
> > -
> > -       r =3D mes_v10_1_queue_init(adev);
> > -       if (r)
> > -               goto failure;
> > -
> > -       return r;
> > -
> > -failure:
> > -       mes_v10_1_hw_fini(adev);
> > -       return r;
> > -}
> > -
> > -static int mes_v10_1_hw_init(void *handle)
> > -{
> > -       int r;
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -       if (!adev->enable_mes_kiq) {
> > -               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRE=
CT) {
> > -                       r =3D mes_v10_1_load_microcode(adev,
> > -                                            AMDGPU_MES_SCHED_PIPE);
> > -                       if (r) {
> > -                               DRM_ERROR("failed to MES fw, r=3D%d\n",=
 r);
> > -                               return r;
> > -                       }
> > -               }
> > -
> > -               mes_v10_1_enable(adev, true);
> > -       }
> > -
> > -       r =3D mes_v10_1_queue_init(adev);
> > -       if (r)
> > -               goto failure;
> > -
> > -       r =3D mes_v10_1_set_hw_resources(&adev->mes);
> > -       if (r)
> > -               goto failure;
> > -
> > -       mes_v10_1_init_aggregated_doorbell(&adev->mes);
> > -
> > -       r =3D mes_v10_1_query_sched_status(&adev->mes);
> > -       if (r) {
> > -               DRM_ERROR("MES is busy\n");
> > -               goto failure;
> > -       }
> > -
> > -       /*
> > -        * Disable KIQ ring usage from the driver once MES is enabled.
> > -        * MES uses KIQ ring exclusively so driver cannot access KIQ ri=
ng
> > -        * with MES enabled.
> > -        */
> > -       adev->gfx.kiq[0].ring.sched.ready =3D false;
> > -       adev->mes.ring.sched.ready =3D true;
> > -
> > -       return 0;
> > -
> > -failure:
> > -       mes_v10_1_hw_fini(adev);
> > -       return r;
> > -}
> > -
> > -static int mes_v10_1_hw_fini(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -       adev->mes.ring.sched.ready =3D false;
> > -
> > -       mes_v10_1_enable(adev, false);
> > -
> > -       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
> > -               mes_v10_1_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE)=
;
> > -               mes_v10_1_free_ucode_buffers(adev, AMDGPU_MES_SCHED_PIP=
E);
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_1_suspend(void *handle)
> > -{
> > -       int r;
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -       r =3D amdgpu_mes_suspend(adev);
> > -       if (r)
> > -               return r;
> > -
> > -       return mes_v10_1_hw_fini(adev);
> > -}
> > -
> > -static int mes_v10_1_resume(void *handle)
> > -{
> > -       int r;
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -       r =3D mes_v10_1_hw_init(adev);
> > -       if (r)
> > -               return r;
> > -
> > -       return amdgpu_mes_resume(adev);
> > -}
> > -
> > -static int mes_v10_0_early_init(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -       int pipe, r;
> > -
> > -       for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
> > -               if (!adev->enable_mes_kiq && pipe =3D=3D AMDGPU_MES_KIQ=
_PIPE)
> > -                       continue;
> > -               r =3D amdgpu_mes_init_microcode(adev, pipe);
> > -               if (r)
> > -                       return r;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int mes_v10_0_late_init(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -       if (!amdgpu_in_reset(adev))
> > -               amdgpu_mes_self_test(adev);
> > -
> > -       return 0;
> > -}
> > -
> > -static const struct amd_ip_funcs mes_v10_1_ip_funcs =3D {
> > -       .name =3D "mes_v10_1",
> > -       .early_init =3D mes_v10_0_early_init,
> > -       .late_init =3D mes_v10_0_late_init,
> > -       .sw_init =3D mes_v10_1_sw_init,
> > -       .sw_fini =3D mes_v10_1_sw_fini,
> > -       .hw_init =3D mes_v10_1_hw_init,
> > -       .hw_fini =3D mes_v10_1_hw_fini,
> > -       .suspend =3D mes_v10_1_suspend,
> > -       .resume =3D mes_v10_1_resume,
> > -       .dump_ip_state =3D NULL,
> > -       .print_ip_state =3D NULL,
> > -};
> > -
> > -const struct amdgpu_ip_block_version mes_v10_1_ip_block =3D {
> > -       .type =3D AMD_IP_BLOCK_TYPE_MES,
> > -       .major =3D 10,
> > -       .minor =3D 1,
> > -       .rev =3D 0,
> > -       .funcs =3D &mes_v10_1_ip_funcs,
> > -};
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h b/drivers/gpu/drm/a=
md/amdgpu/mes_v10_1.h
> > deleted file mode 100644
> > index 9afd6ddb01e9c..0000000000000
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
> > +++ /dev/null
> > @@ -1,29 +0,0 @@
> > -/*
> > - * Copyright 2019 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > - * copy of this software and associated documentation files (the "Soft=
ware"),
> > - * to deal in the Software without restriction, including without limi=
tation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > - * and/or sell copies of the Software, and to permit persons to whom t=
he
> > - * Software is furnished to do so, subject to the following conditions=
:
> > - *
> > - * The above copyright notice and this permission notice shall be incl=
uded in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - */
> > -
> > -#ifndef __MES_V10_1_H__
> > -#define __MES_V10_1_H__
> > -
> > -extern const struct amdgpu_ip_block_version mes_v10_1_ip_block;
> > -
> > -#endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 7e30a89fe03ef..4938e6b340e9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -59,7 +59,6 @@
> >  #include "vcn_v3_0.h"
> >  #include "jpeg_v3_0.h"
> >  #include "amdgpu_vkms.h"
> > -#include "mes_v10_1.h"
> >  #include "mxgpu_nv.h"
> >  #include "smuio_v11_0.h"
> >  #include "smuio_v11_0_6.h"
> > --
> > 2.45.0
> >
