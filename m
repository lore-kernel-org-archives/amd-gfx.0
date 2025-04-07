Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9CC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 19:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7606210E55E;
	Mon,  7 Apr 2025 19:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWUjfrlN";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCCD10E55E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 19:59:40 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so1333540a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744055980; x=1744660780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA84x798yCDXhBBPxqhIb5PifpB65TAVIdRdl7R+NkQ=;
 b=TWUjfrlN055/nbNaNrk+UdxVAMIqF0z0DizafmxwoiouJzcweZFmfqdTYBmU/8OQNN
 MstagavG237lb87YFMn0j1/OtRuY2Je1IH7Ku5VMbdCVcljjYEsiO68nZyfyN8HE5KoG
 v2P9y9ci6nZRY8/ODiDMZHTOcw3vPdDLNrKb5e4GKsoBicts63DnVcICoTpf5UV/6W/d
 LdHTnfBHT4rk+oOG8qzun1WKtW7+QtjHplEgi3UK+Q5JVU1b5gTlAkJ0hXt07U+hqgqd
 b7i2erRNWVApJ9j3enmuzeEoJAUA1qllWAOXmD01IJ5WpcEz8aGcs2n89KM4fxBY13N7
 BAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744055980; x=1744660780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WA84x798yCDXhBBPxqhIb5PifpB65TAVIdRdl7R+NkQ=;
 b=VFaj/cUBrvpeVm0Jewcm3b0G5e0i8MnSjFpqUq/G+qjq5JCCW1JRKcI9YMz+X0ogDN
 UmTYiYbvJZcd9+VeNIbBY1DG71AxZL8vA3aO1V8ID44tQj36W7C8C19asm8U1XTE5zal
 hYi6U36oHOpEXQY87PDIOjdIZnPML/EgrGMJUa9Tm4BTK33YNXlhTQWe882jgiZvTbCT
 ceDJf6C3qbA8zwmue6GZei8QsGwEPlchCNXtMG/z0Ly2+EGnaXATgZ59rXE3eVf6uznB
 B08+b3PKi8Nq9OJUrZGXrXL6SfcTPt66OyXgSWq+Yrg5oqT9RggW6v8zYavEmja1SY1u
 YKUw==
X-Gm-Message-State: AOJu0YwFODO3SpBzjh9EADUYr6nseKqNIFOiAcPNbp5xQjS84IFm5DIH
 qufrv0ssbl4VEkjCe+PRADc8y4yBZBqwS8MXPrQvNds25G6F0ahgVVtaWfCu0qBbfU3VtYNqLhR
 jR2eZbKxgxYk0Z98k6S3pBcnWgIuhfn1n
X-Gm-Gg: ASbGncvbgVaMBs+A6OFKa37sz0TaxnfYc8+bLgXDrWg62U2Ga8CqAyX2AdnmdnQ9S/U
 8cKiBuYEMTNhJhAtQ3fEYIBVOkolXIBY7/KvqKOsPi3p4yGHiT+UqSoKqU93KpX0GnVDNMODnVD
 fPCEAJV4sRgPD32DmFJwuA8zordA==
X-Google-Smtp-Source: AGHT+IHqx1ojLRnBXrKe9BDqkBH3hXyv3VPqiNAOmkZ6c5lAB8Q2/s9skAOpbaQ/Mbebe8FcT5jyvkvLl9osCfDgHlE=
X-Received: by 2002:a17:90b:1648:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-306a4975f51mr7040387a91.4.1744055979875; Mon, 07 Apr 2025
 12:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 15:59:28 -0400
X-Gm-Features: ATxdqUHPCySi_5z-mGl89vrxQwJ_mW4aM65-NfZq4F9KnNdJkzKe20rO18E68DE
Message-ID: <CADnq5_Pr+_Bt8H=Qu4DwH0GOCs6Giu89DKMxGwBJv5rX+i7K=g@mail.gmail.com>
Subject: Re: [v3 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Wed, Apr 2, 2025 at 5:28=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> Since KFD no longer registers its own callbacks for SDMA resets, and only=
 KGD uses the reset mechanism,
> we can simplify the SDMA reset flow by directly calling the ring's `stop_=
queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its ev=
entual deprecation.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdm=
a_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are cal=
led directly during the reset process.
>
> 2. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codeba=
se for the eventual removal of the dynamic callback registration mechanism.
>
> v2: Update stop_queue/start_queue function paramters to use ring pointer =
instead of device/instance(Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 13 ++++-----
>  3 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 615c3d5c5a8d..23ea221e26de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>         void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>         void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>         int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +       int (*stop_queue)(struct amdgpu_ring *ring);
> +       int (*start_queue)(struct amdgpu_ring *ring);

Since this is specific to SDMA, maybe it would be cleaner to add these
to struct amdgpu_sdma_instance.  And if so, maybe rename it since it's
specific to kernel queues.  E.g.,
       int (*stop_kernel_queue)(struct amdgpu_ring *ring);
       int (*start_kernel_queue)(struct amdgpu_ring *ring);
Unless you think we may need it for other engines in the future which
only support engine level soft resets.

Alex


>         void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>         bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 0a9893fee828..b51fe644940f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -558,16 +558,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct=
 amdgpu_device *adev, struct
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id)
>  {
> -       struct sdma_on_reset_funcs *funcs;
>         int ret =3D 0;
>         struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
>         struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> @@ -589,18 +583,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id)
>                 page_sched_stopped =3D true;
>         }
>
> -       /* Invoke all registered pre_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->pre_reset) {
> -                       ret =3D funcs->pre_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "beforeReset callback failed for instance=
 %u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (gfx_ring->funcs->stop_queue)
> +               gfx_ring->funcs->stop_queue(gfx_ring);
>
>         /* Perform the SDMA reset for the specified instance */
>         ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> @@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id)
>                 goto exit;
>         }
>
> -       /* Invoke all registered post_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->post_reset) {
> -                       ret =3D funcs->post_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "afterReset callback failed for instance =
%u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (gfx_ring->funcs->start_queue)
> +               gfx_ring->funcs->start_queue(gfx_ring);
>
>  exit:
>         /* Restart the scheduler's work queue for the GFX and page rings
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..a8330504692d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1678,11 +1678,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>         return r;
>  }
>
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  {
>         u32 inst_mask;
>         uint64_t rptr;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 instance_id =3D GET_INST(SDMA0, ring->me);
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1715,11 +1716,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_d=
evice *adev, uint32_t instance_
>         return 0;
>  }
>
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
>         int i;
>         u32 inst_mask;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> +       struct amdgpu_device *adev =3D ring->adev;
>
>         inst_mask =3D 1 << ring->me;
>         udelay(50);
> @@ -1740,8 +1741,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_=
device *adev, uint32_t instan
>  }
>
>  static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs =3D {
> -       .pre_reset =3D sdma_v4_4_2_stop_queue,
> -       .post_reset =3D sdma_v4_4_2_restore_queue,
>  };
>
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v)
> @@ -2143,6 +2142,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>         .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
>         .reset =3D sdma_v4_4_2_reset_queue,
> +       .stop_queue =3D sdma_v4_4_2_stop_queue,
> +       .start_queue =3D sdma_v4_4_2_restore_queue,
>         .is_guilty =3D sdma_v4_4_2_ring_is_guilty,
>  };
>
> --
> 2.25.1
>
