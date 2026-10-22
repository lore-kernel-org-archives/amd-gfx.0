Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E62606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TUqNJx7r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3311210E443;
	Thu, 22 Oct 2026 15:37:45 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3A010E443
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:37:39 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-990a56e5878so40855241.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683458; cv=none;
 d=google.com; s=arc-20260327;
 b=E3VseFhxP2yXHtsAK2ZljyqEnGwCSaVDiZM6sCwiqjG3k18k952GXN8ygBYC+2MDWT
 eW+LCuyGNAhswTdeG50UQIbZbCDvn8RmSZBLC8h28+vjTwPa9low3n3xbwhQsT7NF8zn
 hW9/TXHOry/en82GZ8/e+aZfbpF8ZCq2VFIziCOaa7AAdQFaHCCnb+/hR6xCC78MzdmE
 NwksvfK4WnCbvJrXS31LuISUkRQZeOD7vSjMO9B2I+KNC0bt/QG/kcUg9FuvXY0v7GgG
 UJkzFwMBsCBM1AfkpFOSI/Na9lNNbMBm4Urc8yDT7iwOElKiorSan/rUvu4PloGp7Xdl
 33HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=av63CmKpWbIeHToyAoDW6LsjmB2fEO5XXdyKz3lXIOs=;
 fh=ha0IybXjterB+Z+WUE68InDk1auUb5RYFaNgjgSrE9I=;
 b=oHdIujYon58ESzCZOZNSgP5Ht4DQPyDs6sqonYLWVY+HB1QkZv0PCHzv3Z4pIwXlCY
 5b+V7xdbxJyuDt5o4dQTpED6BxpCEScF4bESTnC5cjJmz8Xp/Pn1iVZQ5QXIxrBHRS3u
 S2XOaAQtTdIIoVLI/fRp5vJmyaejM9Eu8PCGVE1DyMJwVjTSZroZrB2fFxYMSq68Fn+d
 e3W3vDj007G3q/fISmXPrp36kIN+HqN/LJs9a2GIhATkw78Js1/37GHBum7aGOdQxxbM
 wkT+TV6k2JPjuK9o5vQ/0c3zLWnAB0zPh2GuhfwJlmFsU01IV4MX9BIo6GMRvRSoF10f
 53Mw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792683458; x=1793288258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=av63CmKpWbIeHToyAoDW6LsjmB2fEO5XXdyKz3lXIOs=;
 b=TUqNJx7rXjmKeZaU7hsVeUy3pBd1uBRi2A/M0Op93Me/ukDjEvajcQUWf9rWHnAYFY
 vxySq7bkUVgoq9XtXh7VEcofJVmOMmbwlrijD6eYIKVMv2Jg3sAjhPA+bpWD+j/DJBgS
 3dX2MiD1+lpv0Yic9MG61fRW1nbaA7xNybob5rNc9FL0pSHOyR+WUZXSkdaVth4sIQ4C
 RjPNg6e1MnlbaYc9aWK9tKpXOboxlaonqOpSG8YmO0QVV0eJlpabQTBzeXY26mureR8Y
 kDnukth9mP/++Yqmp6mXi3j5Fo+h5GfTKamaGd6aQnPeIuiwGgDDDqI5NAGQss8t5ZwL
 1khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683458; x=1793288258;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=av63CmKpWbIeHToyAoDW6LsjmB2fEO5XXdyKz3lXIOs=;
 b=xtBSwJ87MJhc3tuZ23EXoLWG73FicmzsKOMsGIf8oT/F1aoA4I5cbdn/Vs9/fC93/5
 AvazXa9Qowu2BLqMo21sdkgSUqXfLyut6LSSXxSbAOxE2Za0wXLTmzBkIUxpE27yyHiH
 s55lCKQAa1yeHKyGlM4rZsu8JbqfIJedJhnaKgGhhwtieK8MWhEXNSXpqXuSrk/k0DG9
 oemEqRF/lz9gg+yg3rpJz40KGt2gm6sg7/ZCB5E1omEIdCqbcvPqO1RE2jkUNzKYYkan
 7X0H7re6/+HffG3lrWrwr+zsUNGsuKjT+I0C1AR9xE/MyEHri8Yv919WEUBsnHxOxQe4
 7k8Q==
X-Gm-Message-State: AFq9FYI3Ml4VgXUuK0oHDT216eaU7xp+enP3C9AwKEhYEMDOQSLH1UnU
 KbOlivBmWDmYdCfJ5r7wiec3D3xCsNkLn3p2jjueGvPjtIg/mtMskyymQJEfJOoFPkmj7+PJBv9
 /0vC2AtX3YVikkgO37GbmITbPehiU8UA=
X-Gm-Gg: AYBFou0pzNIj90fwiXmYdnX1FBKLUyB13kKV/TndXR8id15YszEb775m5FoNx++IpI6
 +sTzYp4gTHQ9WaFSegErYwJnQOFxs3RfnWMSO4rRhWhn466uKB/WY9fXbldZsYPzGDbaHZgeWhj
 s2lsisVVOsG+Kji3vOaP2H1IYwbpJpKrV8+d6g0Sp26zfZxZVo5ZPJkeowFj2fFJr6kFciCnt8Y
 wjBuJ0zzljxCdHnThZBHKvGYl+HWw6D9nJSpbzGfbhVjF/qXq86Ij1PUNdUai+H6PgMAPLovn+w
 kYW9VHhllg0QfEsoy65K1VOsCqqHz5HyaX9R2W15R2extXZ6FIl78nupesCXYfWU/Px3PU/Mnwv
 /PdRnOHpdKfTeafAipN4YLMA1PqaQLPxDiVDnoPQvxTM+vPy4SAzugBhgiKRJXIAa1v25KNb3cV
 G5JA6laK9YXHkzzYcaxkuTV/0=
X-Received: by 2002:a05:6102:3c92:b0:7cc:174b:f7b7 with SMTP id
 ada2fe7eead31-7cc922532e5mr1832956137.0.1792683457943; Thu, 22 Oct 2026
 08:37:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022014728.84081-1-amber.lin@amd.com>
 <20261022014728.84081-3-amber.lin@amd.com>
In-Reply-To: <20261022014728.84081-3-amber.lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:37:25 -0400
X-Gm-Features: AclHuK83akIvC3xONbSNjNx6oioAV_4udN8Fsgz1grKY956fQl3Nhe1hOwKncAc
Message-ID: <CADnq5_M9RjS6jVXctWeAtCaSPoKs95pXCJ3zGo5rXKrreMPtvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Add xcp to reset_mes_compute function
To: Amber Lin <amber.lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, 
 alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 9:56=E2=80=AFPM Amber Lin <amber.lin@amd.com> wrote=
:
>
> Add xcp parameter to amdgpu_gfx_reset_mes_compute() so on an ASIC that
> supports compute partitioning, we can identify the partition's node ID an=
d
> its master XCC. Pass this master XCC ID to MES when calling MES for
> suspend, detecting hung queues, and resume.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 17 +++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c   |  2 +-
>  6 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0c1c8ae822d4..ef34f7b02d0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2470,6 +2470,7 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_d=
evice *adev,
>  }
>
>  int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +                                struct amdgpu_xcp *xcp,
>                                  struct amdgpu_ring *ring,
>                                  struct amdgpu_fence *guilty_fence,
>                                  struct amdgpu_usermode_queue *uq,
> @@ -2486,6 +2487,14 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_dev=
ice *adev,
>         struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_=
RINGS + 1];
>         int n_deferred =3D 0;
>         int ring_err;
> +       uint32_t xcc_mask, xcc_id =3D 0, xcp_id =3D 0;
> +
> +       if (xcp) {
> +               amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &xcc_mas=
k);
> +               /* master xcc in the partition */
> +               xcc_id =3D ffs(xcc_mask) - 1;
> +               xcp_id =3D xcp->id;
> +       }
>
>         guard(mutex)(&adev->gfx.mec.reset_mutex);
>         /* stop the drm schedulers for all compute queues */
> @@ -2493,7 +2502,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>         /* suspend all will determine which queues are hung.
>          * reset detect will return the array of bad queue doorbells
>          */
> -       r =3D amdgpu_mes_suspend(adev, 0);
> +       r =3D amdgpu_mes_suspend(adev, xcc_id);
>         /* if suspend all success, it should no hang queue */
>         if (!r) {
>                 dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", x=
cc_id);
> @@ -2503,7 +2512,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>                 goto fence_reset;
>         }
>         r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_T=
YPE_COMPUTE,
> -                                                   true, &num_hung, adev=
->gfx.mec.mes_hung_db_array, 0);
> +                                                   true, &num_hung, adev=
->gfx.mec.mes_hung_db_array, xcc_id);
>         if (r) {
>                 dev_dbg(adev->dev, "MES fails on detecting hung queues\n"=
);
>                 goto out;
> @@ -2551,7 +2560,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>                         n_deferred++;
>                 }
>                 /* reset any KFD queues */
> -               r =3D amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, =
pipe, queue,
> +               r =3D amdgpu_amdkfd_reset_mes_queue(adev, xcp_id, queue_t=
ype, pipe, queue,
>                                                   adev->gfx.mec.mes_hung_=
db_array[i]);
>                 if (r)
>                         goto out;
> @@ -2582,7 +2591,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>
>  out:
>         /* resume all will enable the non-hung queues */
> -       amdgpu_mes_resume(adev, 0);
> +       amdgpu_mes_resume(adev, xcc_id);
>
>         /* Now CP is running again =E2=80=94 replay backed-up commands an=
d ring
>          * doorbells on each reset queue.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..26bbec8f92e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,7 @@ bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *a=
dev, int xcc_id);
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>  int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +                                struct amdgpu_xcp *xcp,
>                                  struct amdgpu_ring *ring,
>                                  struct amdgpu_fence *guilty_fence,
>                                  struct amdgpu_usermode_queue *uq,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..7dfe6e83f8ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -153,7 +153,7 @@ static void amdgpu_userq_hang_detect_work(struct work=
_struct *work)
>                 int r;
>
>                 if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
> -                       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NU=
LL,
> +                       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NU=
LL, NULL,
>                                                          queue, NULL, NUL=
L);
>                 else
>                         r =3D userq_funcs->reset(queue);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 315dfd806d56..fdc0620ca67f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6932,7 +6932,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *=
ring,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>
> -       return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, N=
ULL, NULL, NULL);
> +       return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fe=
nce, NULL, NULL, NULL);
>  }
>
>  static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct dr=
m_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index d334fb805020..ec5ec1fd8b9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5254,7 +5254,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *=
ring,
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>
> -       return amdgpu_gfx_reset_mes_compute(adev, ring, timedout_fence, N=
ULL, NULL, NULL);
> +       return amdgpu_gfx_reset_mes_compute(adev, NULL, ring, timedout_fe=
nce, NULL, NULL, NULL);
>  }
>
>  static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ce67e56efa8c..0eb4081a5740 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -506,7 +506,7 @@ static int reset_queues_mes(struct device_queue_manag=
er *dqm, struct queue *q)
>         queue_input.remove_queue_after_reset =3D false;
>         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>         /* pass the known bad queue info to the reset function */
> -       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_h=
ung, &queue_input);
> +       r =3D amdgpu_gfx_reset_mes_compute(adev, dqm->dev->xcp, NULL, NUL=
L, NULL, &num_hung, &queue_input);
>         if (r)
>                 goto fail;
>         pdd =3D kfd_get_process_device_data(q->device, q->process);
> --
> 2.43.0
>
