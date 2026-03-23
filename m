Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE58F483E5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF10110E430;
	Mon, 23 Mar 2026 19:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kN/+Mr3B";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABB010E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:04:16 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1277863a912so416342c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292656; cv=none;
 d=google.com; s=arc-20240605;
 b=bq6yX8B927Ze+gH89rDaBHBeBdXRk+X4Hbc05/Z0ak2LxxOTUc+Z0eP5sIA5X6tgwY
 X/lBpgqoWVTm/+mLUskm0/kZHfSzaHwGF+qmjfNXLKfbXwGQqr6MqeYyBWnT+a1nDCBH
 +ARuywwYQ6oi/soq4aa8QTekIw2sLmqEZt7o2qrgEROzyvD1I1ZBfcyltH6GCNFCKs8i
 kcVfbIVptvr10NtVcB3eZmCGgbdvAtIbSD27JXw3mKnqCVpf1JfwUqptayCwordfTpE5
 wgkGzF/4+bUp8FX2AdeHMxLUyYMHaqkZQ2F512aLy5ZTBgO6uX2xMtYNTJr+4T0FjEj7
 qpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q3O1kxJg/OcajjjrwWl8URPDba0yAe/AInn5lFJgJq0=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=FvJuIBeEla4DetgqgtwP9M/Lk6Jo7b2daoxVrl8isqP3bjmLpJYSkAycnyrSjf4HbX
 m5T6MZK9QdDfIO2easJE0g7e8WOaJNcopEwhtJVl1LSRYUCl8J7rlAHoVf8vE81ZAeIL
 nboSIj2DVBzFiRvxSKYmSFhom694b/HOTfLOSnADnsVcYnjfQhhWXQ4fQgGjWMtQy1bj
 t+ZlMNUtqzWQzzzGK/lbwcVXnIQnkJVkRYJh6uKQOx1ULlvn4pFiRKvsF8FjSf1wz3dR
 +4VmYd6NaJ5A0TNvHA84Qra4lxMHxX/sdsp79VvPkXziyXNBuARg9+JwK9suXlpbYl4P
 QVKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774292656; x=1774897456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3O1kxJg/OcajjjrwWl8URPDba0yAe/AInn5lFJgJq0=;
 b=kN/+Mr3BSpm3tVETYHtqQbgvS8rvR7uNbSFdTOm3PspEUZJshCGumqqALXSBMpzAGL
 62XjYW+srF/g8N5a+7Nj5KAc79IWJBwOLp1BYlS2Ew8C/LnN5kL1ByoL6F9ftEhDoND0
 kLmFnrieIfqgUYid01VFXya5fD6pja02G3vKbpXHdaF9YrgGnGeRsu7zcWaBrHF674vJ
 RgTWRX0dkoSLCrclYBguNtbdmYZQBC8hGmAEhtlpmq7+TkMny7+7WdJf4LlX2Op2MO1j
 0tY8CENQKbOCyDknizprcAArDEHxnHapMZfokRXpFH9C/bGRXH4I93PRdT71WoUsgtkT
 DV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774292656; x=1774897456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3O1kxJg/OcajjjrwWl8URPDba0yAe/AInn5lFJgJq0=;
 b=tNli06KH0q0gwUSoOHYTuE72XRsmLvS/FSpvif3oxKi9N0lJiX4X27LYeNpTV8WPu5
 3rG3BNJrfG8i00yDBn/X0RKL0K2l7NW/7mh1e3ibLszOIiXLoaKnlBHvE2d5Ok70zyXy
 0AgF6sd6YpPkeo25f6wQRlA6O7RmkhKakNyeuuD+K8Q6tBiUiY/8aVaQnadRq2Ui+i3v
 FHIYtFg3+dynf0lNcvN/Hpz9QdJFHEvN9CniCR62av6KiqvwX8NUfY4PKGqZ6Bu58TOY
 5t2arCC2JrVQWlT8StNjq/deLSpd69DN1/w0JHBQ8x606prDKaEg6W6yKyF3+O16YY3V
 IERQ==
X-Gm-Message-State: AOJu0YzMM8mllNjaTGsI/1eogNobG0+9RaLE4uOI18kPW3zr2W27j2vC
 GWfVKGfk7meIjPaTTJ/2fZS5hrMpcA0ckXt/G9YEqBs7SlQ6HiXLkkl4PfvJFMGBtReY/gL7M1B
 rCfWrNUmgbdoUeqS9XwWrhBlFJEtJsJk=
X-Gm-Gg: ATEYQzwRZVyxXngJG3cwP7AHwYisAYN5QQkf5eZNw5CAak00a5WZl/qrXQKqz7Y4lqd
 F7xic3OeZWLP2U5qFz6iCuyg6B2JGqdrjQeGE6xmZgxL4KfC0i673qG9nHyO87j/iDZrpGVuIAe
 fReKHv+8FHNLZrdVYByORigFUjYgSVWFdLqsV/L4usyf+OYdX8B4uNTSfpNARHkbtX6GnpaBqI3
 TUJ7y9Pw9XRxPFpA4CDmil7vk8k/X6v6xQ9szn2o/0dojve+IqtqdlQNhNCwQPY/Tr4+qzfntxv
 xy/FiuVkxNlXieBU1EAsaR+vZ2RT6ujoPFIc0RBBbos4MINydy8p5T3QjpnAZPHSYqGK4UqJytf
 5a16p
X-Received: by 2002:a05:7022:e0e:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-12a726c1d26mr2572391c88.5.1774292655581; Mon, 23 Mar 2026
 12:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-3-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-3-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:04:04 -0400
X-Gm-Features: AaiRm528t02FLXRMONC8nrZg0cacahMy1nXtPExx_Y711DYfwnWKnBRplhZ3Lmo
Message-ID: <CADnq5_OxDUYro8TqWQFuJ1qE9MRwoC1j6=ac_D1moP2Mfss+4Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: Fixup boost mes detect hang array size
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
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

On Fri, Mar 20, 2026 at 4:09=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> When allocate the hung queues memory, we need to take the number of
> queues into account for the worst hang case.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 33 +++++++++++++++++++------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0d4c77c1b4b5..b68bf4a9cb40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -103,7 +103,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pip=
e,
>
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
> -       int i, r, num_pipes;
> +       int i, r, num_pipes, num_queues =3D 0;
>         u32 total_vmid_mask, reserved_vmid_mask;
>         int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
: 1;
>         u32 gfx_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pip=
e_per_me,
> @@ -159,7 +159,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 adev->mes.compute_hqd_mask[i] =3D compute_hqd_mask;
>         }
>
> -       num_pipes =3D adev->sdma.num_instances;
> +       num_pipes =3D adev->sdma.num_inst_per_xcc;
>         if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
>                 dev_warn(adev->dev, "more SDMA pipes than supported by ME=
S! (%d vs %d)\n",
>                          num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
> @@ -216,8 +216,27 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>         if (r)
>                 goto error_doorbell;
>
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 0, 0)=
) {

Is this 12.0 and higher or 12.1 and higher?

Alex

> +               /* When queue/pipe reset is done in MES instead of in the
> +                * driver, MES passes hung queues information to the driv=
er in
> +                * hung_queue_hqd_info. Calculate required space to store=
 this
> +                * information.
> +                */
> +               for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[=
i]);
> +
> +               for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.compute_hqd_m=
ask[i]);
> +
> +               for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +                       num_queues +=3D hweight32(adev->mes.sdma_hqd_mask=
[i]) * num_xcc;
> +
> +               adev->mes.hung_queue_hqd_info_offset =3D num_queues;
> +               adev->mes.hung_queue_db_array_size =3D num_queues * 2;
> +       }
> +
>         if (adev->mes.hung_queue_db_array_size) {
> -               for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> +               for (i =3D 0; i < AMDGPU_MAX_MES_PIPES; i++) {
>                         r =3D amdgpu_bo_create_kernel(adev,
>                                                     adev->mes.hung_queue_=
db_array_size * sizeof(u32),
>                                                     PAGE_SIZE,
> @@ -264,10 +283,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>                               &adev->mes.event_log_cpu_addr);
>
>         for (i =3D 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
> -               amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_=
obj[i],
> -                                     &adev->mes.hung_queue_db_array_gpu_=
addr[i],
> -                                     &adev->mes.hung_queue_db_array_cpu_=
addr[i]);
> -
> +               if (adev->mes.hung_queue_db_array_gpu_obj[i])
> +                        amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_a=
rray_gpu_obj[i],
> +                                        &adev->mes.hung_queue_db_array_g=
pu_addr[i],
> +                                        &adev->mes.hung_queue_db_array_c=
pu_addr[i]);
>                 if (adev->mes.sch_ctx_ptr[i])
>                         amdgpu_device_wb_free(adev, adev->mes.sch_ctx_off=
s[i]);
>                 if (adev->mes.query_status_fence_ptr[i])
> --
> 2.43.0
>
