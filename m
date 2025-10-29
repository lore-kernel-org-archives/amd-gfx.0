Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85632CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 18:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311EA10E162;
	Wed, 29 Oct 2025 18:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azK2wFlt";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F07A10E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 18:14:05 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-290aaff26c1so231895ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761761645; x=1762366445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adNQ/qV5F+oE2BT3bdy3A02449jZb7vSfsDpu1ZxqbA=;
 b=azK2wFltL4pQ0eMdK3qHbIQDaiwmO2rBL8Ws9dtqKLIb9SariO2CKLUhwjVrojqCHX
 9x4PvLUn1iBq/Stw80nOySY/Qa+e1+KxAEM1bzhBa3wpodmJ7uMA4b2wcIGRbN47F6GP
 PQYmz8ndIgigYSbnG9uDvCkzmntqvSCPFHBtcHHaSP8+HBKgSXOO4B8UEl95IYnWtG+1
 UcNs2PvF/5PSX9VgKzaQt+10yT1xOxv4VqpuIB93wtRfSMdLAI0uG1U1AYlMMX90CEtM
 bIa7xQtUofdvsg/ht/ZtOgWtATjHy5VK7IvNbnhKmXT9bh+rU6thuxKv8wXCdIcSuc1X
 QtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761645; x=1762366445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adNQ/qV5F+oE2BT3bdy3A02449jZb7vSfsDpu1ZxqbA=;
 b=BvPnwWHZOJMv1Pxj/ohYXqETCUDT7H9oovnlxvwlCo1hdNLXCusIeuYv6U/pA4xnK9
 8L010CuXqtjOpJKq1WpXfDRis/K0XAZ99JkDSZWAK4UraR+aRpPcQfq650XDz+ATJMqh
 ohvtiOyN/FXtA87oHb3mSo2NZhFOHyQRBQIhtXAjSlApV5uWKvuASK6KVSQzVYyM93/D
 fpfxozlGKWGcvMqnWWynKQmam2ITKZLRZjNNwa0R2/oHDNpPtGqibkvYaasYVdgUs/iI
 tP6ZV+H42Bd8h+aJQwUtFmzeHj+jm+M9BS30czDzDemnCNHjvOCvYoyz8sIlvfmZCCHl
 zWvw==
X-Gm-Message-State: AOJu0YxzJc1XohYV91nH3mtMD2WxT9m077Dh1cKLE/cqIfbcy7/MoqiL
 5ux9MYxQ8jNDmSE/TRyqFuloAZW3MjU93IIg0TZDBDzF+AIpR/LiRLCz0mVZb5VEuVeMe/C11Bd
 n8BiWv53B46V6+ZmI0hOFKQp4ahtIxYI=
X-Gm-Gg: ASbGncveuoDOlZCnAc4gavwLjGcrGFM9lJD7TLUhMS/OhT5dN1u/8VCBu6YsjRP0s5W
 kJ9NQC13xp1bIjuMgNX65AP9qTSJGTGYNe7GbXG/ahqbrPwzQAhWEUTxdiVvRcH6cqqMjtsLZ7i
 lvy1AAMPHeN/Jb36/Lzv4f66ICKB7Z94JJ14/pR8eCUhEYxBxl/1hbeJ3lXr5rrTqBOqK4I0M/F
 wN/zm5fX/0T3NbJx/52f0BuvEgUT3bPZwkB8S6aFrAseqRfLdR/2JGsWxMl
X-Google-Smtp-Source: AGHT+IHgmCS4JX3t3uB2xRtWyn8rjIjKgxi/4dW34cR46Tx6gILXujmbiixxVjqW9QSB2wutpeBE1USs6LqYbfZK7pQ=
X-Received: by 2002:a17:903:2f85:b0:27e:e96a:4bf with SMTP id
 d9443c01a7336-294dee178a1mr24769835ad.2.1761761644373; Wed, 29 Oct 2025
 11:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
 <20251024094445.3090110-2-Jesse.Zhang@amd.com>
In-Reply-To: <20251024094445.3090110-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Oct 2025 14:13:52 -0400
X-Gm-Features: AWmQ_bnAj7h-qGzyvxvAwuz1t7TYc-N6RtjVUVrdcPeO4imHqhP9jiB1qJ6W07M
Message-ID: <CADnq5_PMvfkcTcK9EKTc5PwLO3GEJKxOU2rL02CC6LiPKM51OQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Add user queue reset mask support
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Oct 24, 2025 at 5:45=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This commit adds support for tracking and exposing the reset capabilities
> of user mode queues across different IP blocks (GFX, Compute, SDMA).
>
> These changes allow userspace to query the reset capabilities of user
> mode queues and ensure reset operations are only attempted when supported
> by the hardware and driver.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 44 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 13 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 17 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 12 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 34 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     | 24 ++++++++----
>  9 files changed, 163 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d0fb4eb1d7c4..48b21863065e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1182,6 +1182,7 @@ struct amdgpu_device {
>          * Value: struct amdgpu_usermode_queue
>          */
>         struct xarray userq_doorbell_xa;
> +       u32 userq_supported_reset[AMDGPU_RING_TYPE_MAX];

I don't think we need a separate userq_supported_reset array.  Just
use the existing reset masks.  We use the same functionality in both
kernel and userq cases so I don't see a reason to have a separate
tracker.

Alex

>
>         /* df */
>         struct amdgpu_df                df;
> @@ -1612,6 +1613,8 @@ struct dma_fence *amdgpu_device_enforce_isolation(s=
truct amdgpu_device *adev,
>                                                   struct amdgpu_ring *rin=
g,
>                                                   struct amdgpu_job *job)=
;
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> +ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev,
> +                                   int ring_type);
>  ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 8480b72258f2..a0064c5314df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7649,7 +7649,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdg=
pu_ring *ring)
>         if (!ring || !ring->adev)
>                 return size;
>
> -       if (amdgpu_device_should_recover_gpu(ring->adev))
> +       if (amdgpu_device_should_recover_gpu(ring->adev) &&
> +           unlikely(!ring->adev->debug_disable_gpu_ring_reset))
>                 size |=3D AMDGPU_RESET_TYPE_FULL;
>
>         if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
> @@ -7659,6 +7660,20 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amd=
gpu_ring *ring)
>         return size;
>  }
>
> +ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev, int=
 ring_type)
> +{
> +       ssize_t size =3D 0;
> +
> +       if (!adev || !adev->userq_funcs[ring_type])
> +               return size;
> +
> +       if (amdgpu_device_should_recover_gpu(adev) &&
> +           unlikely(!adev->debug_disable_gpu_ring_reset))
> +               size |=3D AMDGPU_RESET_TYPE_FULL;
> +
> +       return size;
> +}
> +
>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
>  {
>         ssize_t size =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 3d24f9cd750a..5597753ec61a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1826,6 +1826,32 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(s=
truct device *dev,
>         return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_re=
set);
>  }
>
> +static ssize_t amdgpu_userq_get_gfx_reset_mask(struct device *dev,
> +                                               struct device_attribute *=
attr,
> +                                               char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AM=
DGPU_HW_IP_GFX]);
> +}
> +
> +static ssize_t amdgpu_userq_get_compute_reset_mask(struct device *dev,
> +                                               struct device_attribute *=
attr,
> +                                               char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AM=
DGPU_HW_IP_COMPUTE]);
> +}
> +
>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>                    NULL, amdgpu_gfx_set_run_cleaner_shader);
>
> @@ -1845,6 +1871,12 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
>  static DEVICE_ATTR(compute_reset_mask, 0444,
>                    amdgpu_gfx_get_compute_reset_mask, NULL);
>
> +static DEVICE_ATTR(gfx_userq_reset_mask, 0444,
> +                  amdgpu_userq_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_userq_reset_mask, 0444,
> +                  amdgpu_userq_get_compute_reset_mask, NULL);
> +
>  static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
> @@ -1928,6 +1960,18 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct=
 amdgpu_device *adev)
>                         return r;
>         }
>
> +       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> +               r =3D device_create_file(adev->dev, &dev_attr_gfx_userq_r=
eset_mask);
> +               if (r)
> +                       return r;
> +       }
> +
> +       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> +               r =3D device_create_file(adev->dev, &dev_attr_compute_use=
rq_reset_mask);
> +               if (r)
> +                       return r;
> +       }
> +
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 8b8a04138711..2fb288b2bfc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -471,6 +471,21 @@ static ssize_t amdgpu_get_sdma_reset_mask(struct dev=
ice *dev,
>  static DEVICE_ATTR(sdma_reset_mask, 0444,
>                    amdgpu_get_sdma_reset_mask, NULL);
>
> +static ssize_t amdgpu_get_sdma_userq_reset_mask(struct device *dev,
> +                                               struct device_attribute *=
attr,
> +                                               char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return amdgpu_show_reset_mask(buf, adev->userq_supported_reset[AM=
DGPU_HW_IP_DMA]);
> +}
> +static DEVICE_ATTR(sdma_userq_reset_mask, 0444,
> +                  amdgpu_get_sdma_userq_reset_mask, NULL);
> +
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>  {
>         int r =3D 0;
> @@ -484,6 +499,12 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_=
device *adev)
>                         return r;
>         }
>
> +       if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
> +               r =3D device_create_file(adev->dev, &dev_attr_sdma_userq_=
reset_mask);
> +               if (r)
> +                       return r;
> +       }
> +
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 188de848c229..15ae72e2d679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -47,6 +47,16 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
> +                                         int ring_type,
> +                                         int reset_type)
> +{
> +    if (ring_type < 0 || ring_type >=3D AMDGPU_RING_TYPE_MAX)
> +        return false;
> +
> +    return (adev->userq_supported_reset[ring_type] & reset_type) !=3D 0;
> +}
> +
>  static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
>  {
>         if (amdgpu_device_should_recover_gpu(adev)) {
> @@ -94,6 +104,9 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_use=
rq_mgr *uq_mgr)
>                 int ring_type =3D queue_types[i];
>                 const struct amdgpu_userq_funcs *funcs =3D adev->userq_fu=
ncs[ring_type];
>
> +               if (!amdgpu_userq_is_reset_type_supported(adev, ring_type=
, AMDGPU_RESET_TYPE_PER_QUEUE))
> +                               continue;
> +
>                 if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
>                     funcs && funcs->detect_and_reset) {
>                         r =3D funcs->detect_and_reset(adev, ring_type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 252517ce5d5a..82b7c365d720 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1815,6 +1815,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>         adev->gfx.compute_supported_reset =3D
>                 amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0=
]);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =3D
> +                       amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_=
IP_GFX);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =3D
> +                       amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_I=
P_COMPUTE);
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(11, 0, 0):
>         case IP_VERSION(11, 0, 2):
> @@ -1824,12 +1829,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                     !amdgpu_sriov_vf(adev)) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_a=
nd_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
GFX] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->dete=
ct_and_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
COMPUTE] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
>                 }
>                 break;
>         default:
>                 if (!amdgpu_sriov_vf(adev)) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_a=
nd_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
GFX] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->dete=
ct_and_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
COMPUTE] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
>                 }
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 35d5a7e99a7c..c5ac42a30789 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1543,6 +1543,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>         adev->gfx.compute_supported_reset =3D
>                 amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0=
]);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =3D
> +               amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_GFX);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =3D
> +               amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_IP_COMPUT=
E);
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(12, 0, 0):
>         case IP_VERSION(12, 0, 1):
> @@ -1551,6 +1556,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                     !amdgpu_sriov_vf(adev)) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]->detect_a=
nd_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
GFX] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]->dete=
ct_and_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
COMPUTE] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +
>                 }
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index db6e41967f12..8850eaf8d2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1349,19 +1349,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         return r;
>         }
>
> -       adev->sdma.supported_reset =3D
> -               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
> -       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> -       case IP_VERSION(6, 0, 0):
> -       case IP_VERSION(6, 0, 2):
> -       case IP_VERSION(6, 0, 3):
> -               if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> -                   !amdgpu_sriov_vf(adev))
> -                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> -               break;
> -       default:
> -               break;
> -       }
>
>         if (amdgpu_sdma_ras_sw_init(adev)) {
>                 dev_err(adev->dev, "Failed to initialize sdma ras block!\=
n");
> @@ -1412,6 +1399,27 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 break;
>         }
>
> +       adev->sdma.supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =3D
> +               amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_DMA);
> +
> +       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> +       case IP_VERSION(6, 0, 0):
> +       case IP_VERSION(6, 0, 2):
> +       case IP_VERSION(6, 0, 3):
> +               if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> +                   !amdgpu_sriov_vf(adev)) {
> +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> +                       if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
> +                           adev->userq_funcs[AMDGPU_HW_IP_DMA]->detect_a=
nd_reset)
> +                               adev->userq_supported_reset[AMDGPU_HW_IP_=
DMA] |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +
> +               }
> +               break;
> +       default:
> +               break;
> +       }
>         r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index 326ecc8d37d2..9de46ac8b1db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1335,14 +1335,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         return r;
>         }
>
> -       adev->sdma.supported_reset =3D
> -               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
> -       if (!amdgpu_sriov_vf(adev))
> -               adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUE=
UE;
> -
> -       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> -       if (r)
> -               return r;
>         /* Allocate memory for SDMA IP Dump buffer */
>         ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
>         if (ptr)
> @@ -1360,6 +1352,22 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 break;
>         }
>
> +       adev->sdma.supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
> +       adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =3D
> +               amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_DMA);
> +
> +       if (!amdgpu_sriov_vf(adev)) {
> +               adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUE=
UE;
> +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
> +                   adev->userq_funcs[AMDGPU_HW_IP_DMA]->detect_and_reset=
)
> +                       adev->userq_supported_reset[AMDGPU_HW_IP_DMA] |=
=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +
> +       }
> +       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> +       if (r)
> +               return r;
> +
>         return r;
>  }
>
> --
> 2.49.0
>
