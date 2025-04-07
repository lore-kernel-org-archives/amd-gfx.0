Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2FFC369A1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EEA10E567;
	Mon,  7 Apr 2025 20:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gD5FjmoG";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52FF10E566
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:06:34 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso833658a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056394; x=1744661194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8kFLH8TPxPONXykroppuRDrHZSb3y2SsvZ6KoaB9jw=;
 b=gD5FjmoGl5gogp4B1Ul5AXW3tY077kkQTAH0/qwJloZtqalzshdGzwCF6cduz7aoQ1
 qLIBeVjVJwrH6HCMjFu9kNenrQbj1VWJWHe10P1m5YGQwJQ3e4GZkbszpWmxkvQRfnks
 XercJLQebKJWtEyDNm41dX9Ov6yjvMeSUvWAZykId65EuLwB3Vo4ZdtIkjjSECMkX5iN
 PkxNqqDNVQlzmHJvCkQnH4ZwiaJQJuXgfw6sTLSaZ0drWuR2nhBvr/ezZOusxcF0hs53
 1Gvc7/5i3SK6QkpVcVKYmks79sbjT0nViinnKGSGElhtpMbierDPSvZEZNj2HZamwOtN
 T5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056394; x=1744661194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8kFLH8TPxPONXykroppuRDrHZSb3y2SsvZ6KoaB9jw=;
 b=dWtpTPOSDx8rVi4OwGxj7LHLF/uWxyvp6fT9HAd6Gt04GWpncL1/ROtxZ944l0bLBU
 BkNDSY99YC+q8SK05KRy4/+FC33kQ2vA/m1w4NlZHJq/izmGkoPIubEopMhlOZomhrdc
 prHITweyWMYe4ACs5eD0XdUUC+6lLA5C7htRWqmPoIMyJ2Yxr3P4ia5GheNAx6I+hjof
 CydkD2LDBqhcU9YxNv6zZVXbmwv6wJ/v0wp2LX9ZhAH0HHWfE0leLzRGSUEjfzI4ah9W
 is8ceeiywQ8bXEJgjyC9SCpvKlTtIS/FRQKTdFfzF4wKK9OvrocCavo2W6uZMd86QRI7
 L9pw==
X-Gm-Message-State: AOJu0YzltGoewOZiwDGLMxknw221Zhzz1kkB+8udDjvlEGEVWzog1TmQ
 bN+UZMGSFwjY6WgdhoSZfHqm8SApqGERBYqpzbLYdVcMCY8Zak7eGto2V2DdHRDKMj4lv3v4/H2
 AFT/0viUeCy4eVbvDit2kZwdN9LM=
X-Gm-Gg: ASbGnctrF3fnoofLzs2q1+2KA5Dyk33RXJhkiUsnX7BQG+3skHmAh2T4OiJlQUkdAmZ
 pGiDgy0xVdPgfuFNWzjeO6/6cYTrL8gZhTHqsBb0RTK3pO5EfhrrNfxuwHrR1PrHLErZbghCoPE
 MusSbbBZhISfXEE3a4diTiZrSHZA==
X-Google-Smtp-Source: AGHT+IFTIFaAtd9dHB2pOR9khhWuOUFVBaSz+dDQNpbxur6fjzwM4A4SnvlIuduoBLo4QAo7QIDgwWApK/cyWBvxhJc=
X-Received: by 2002:a17:90b:1d8b:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-306a48ff28amr6930941a91.3.1744056394085; Mon, 07 Apr 2025
 13:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
 <20250402091406.1641643-7-jesse.zhang@amd.com>
In-Reply-To: <20250402091406.1641643-7-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 16:06:22 -0400
X-Gm-Features: ATxdqUEHsxumHFqYYypHOO40UhiqufeJNOPROvxG5zfWKE1n9K3yq5cUfwEFpxY
Message-ID: <CADnq5_Oc6w9bApPZYgnWhQMoYnax3ECGGVbXSuOao46wN=HXPg@mail.gmail.com>
Subject: Re: [v3 7/7] drm/amd/amdgpu: Remove deprecated SDMA reset callback
 mechanism
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

On Wed, Apr 2, 2025 at 5:15=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch removes the deprecated SDMA reset callback mechanism, which wa=
s previously used to register pre-reset and post-reset callbacks for SDMA e=
ngine resets.
>  The callback mechanism has been replaced with a more direct and efficien=
t approach using `stop_queue` and `start_queue` functions in the ring's fun=
ction table.
>
> The SDMA reset callback mechanism allowed KFD and AMDGPU to register pre-=
reset and post-reset functions for handling SDMA engine resets.
> However, this approach added unnecessary complexity and was no longer nee=
ded after the introduction of the `stop_queue` and `start_queue` functions =
in the ring's function table.
>
> 1. **Remove Callback Mechanism**:
>    - Removed the `amdgpu_sdma_register_on_reset_callbacks` function and i=
ts associated data structures (`sdma_on_reset_funcs`).
>    - Removed the callback registration logic from the SDMA v4.4.2 initial=
ization code.
>
> 2. **Clean Up Related Code**:
>    - Removed the `sdma_v4_4_2_set_engine_reset_funcs` function, which was=
 used to register the callbacks.
>    - Removed the `sdma_v4_4_2_engine_reset_funcs` structure, which contai=
ned the pre-reset and post-reset callback functions.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 24 ------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ----------
>  3 files changed, 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 26d7c0aca9a8..e8c7aadf9923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -531,30 +531,6 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_dev=
ice *adev, struct amdgpu_rin
>                 return false;
>  }
>
> -/**
> - * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbac=
ks
> - * @funcs: Pointer to the callback structure containing pre_reset and po=
st_reset functions
> - *
> - * This function allows KFD and AMDGPU to register their own callbacks f=
or handling
> - * pre-reset and post-reset operations for engine reset. These are neede=
d because engine
> - * reset will stop all queues on that engine.
> - */
> -void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs)
> -{
> -       if (!funcs)
> -               return;
> -
> -       /* Ensure the reset_callback_list is initialized */
> -       if (!adev->sdma.reset_callback_list.next) {
> -               INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> -       }
> -       /* Initialize the list node in the callback structure */
> -       INIT_LIST_HEAD(&funcs->list);
> -
> -       /* Add the callback structure to the global list */
> -       list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
> -}
> -
>  static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instan=
ce_id)
>  {
>         u32 soft_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 47d56fd0589f..419531cc8207 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -103,13 +103,6 @@ struct amdgpu_sdma_ras {
>         struct amdgpu_ras_block_object ras_block;
>  };
>
> -struct sdma_on_reset_funcs {
> -       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id=
);
> -       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_i=
d);
> -       /* Linked list node to store this structure in a list; */
> -       struct list_head list;
> -};
> -
>  struct amdgpu_sdma {
>         struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
>         struct amdgpu_irq_src   trap_irq;
> @@ -170,7 +163,6 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> -void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs);
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index a8330504692d..059b03d2aeef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgp=
u_device *adev);
>  static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
> -static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v);
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
>
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
> @@ -1351,7 +1350,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_=
block *ip_block)
>         sdma_v4_4_2_set_vm_pte_funcs(adev);
>         sdma_v4_4_2_set_irq_funcs(adev);
>         sdma_v4_4_2_set_ras_funcs(adev);
> -       sdma_v4_4_2_set_engine_reset_funcs(adev);
>
>         return 0;
>  }
> @@ -1740,14 +1738,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu=
_ring *ring)
>         return sdma_v4_4_2_inst_start(adev, inst_mask, true);
>  }
>
> -static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs =3D {
> -};
> -
> -static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v)
> -{
> -       amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_engine=
_reset_funcs);
> -}
> -
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> --
> 2.25.1
>
