Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10FBC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECD610E206;
	Wed, 12 Feb 2025 19:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lq+MO8T6";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E690010E206
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:41:59 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fbf706c9cbso33106a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739389319; x=1739994119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws92tmwEL8A0j/kJoT87+t4r4Is26k5JjWDJNyIaFBs=;
 b=Lq+MO8T68Eu6FMkZeia6m71Up1OA3lh2GPP5JvWImwjFKfZv7IfX6w4UuNNDtCz62/
 Ywwp0zo9PpHhHyzYiXeLy/b8LXsdeEZtScLNYsWsR4xExwH2orDk0nP7ADG96JlBis2f
 7PbF40kCSzZeyeOOLLBb0T/2RJWCMQKIJ1gN9CYO4cVNceR7a29sy88zvFgPTH1F2hs7
 6T/tLOTfZ26tv4TgUaQTKbtfQ4YX0bFBN8zxy6YYiPVkFWyLmjes3daq7mG+VdCUI1v7
 MDG9k30WFEZBNNxnrMkM3/aINWpDgoarkivHx7wQWcRLG2msRvZ21Uh71NUqYdUujKaq
 vMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739389319; x=1739994119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws92tmwEL8A0j/kJoT87+t4r4Is26k5JjWDJNyIaFBs=;
 b=YCTViL01TG2DQ5ZUxXUyR9/iDoLYW60L7mB+kTeFAoS6WH4bdxk7Ke2SJ+cMSzKdTZ
 wzP1wdcl1pMXBsU7btlX+RsQ5cYWZqWLsvSqUXQ5kNpAhskuNk7vkVGiXM2mjHJO8DyW
 6Neui84w04EnC6a+tSeOO/U/xgzLiB/xJQ6MPImRpN97MyL4JVfh8m/AZs4TMzXX8XF7
 dcanW5ZfVhLwBxr1huPJYhNiaiBtFPqserSN17ka7DAgJuzEZ/UuU122wU+oZ8RTuotu
 vl7R6ENS0r3K+gE20+S8j+foi0z2+sM80+YASoZ/6KmH0GTRkuC0EbxXLTvkcVIzQK5v
 BD6g==
X-Gm-Message-State: AOJu0Yx5pnI2u7sBr/YXZsPMY3fJuhmpodSsQZtiri7FuaUfLDpbubVA
 XwMqNSL1NdXpzdSOjpQU12Jh0RCU47iFIf+k7FBac8fnIV8fDOaynRV+lTgFvMcgtTYzKr1SQlA
 +iUQNkuib+h12cm1mnDbAc5JmTbiNu1Sd
X-Gm-Gg: ASbGncvN/K7sc0adk4FVxn2p6yw8Q8Qm42+yTNCBjTtNf89jsstgPIpUkIY9uFzDf8d
 b2mrDRp2ddtxjoTa83z7JtAoJGlfvYEx8QzGBmwdymZVsq6BzmQFndCaumq139gbw6/AAMtqP
X-Google-Smtp-Source: AGHT+IEPhmYNVvKDlV9e4ub9vRTFySEv/D9wlIiJtP/DpMC8+Oatoqex0HZgKFLTqTsqhlGqc8AFAdaFI8CFXhuZ9hg=
X-Received: by 2002:a17:90b:4c04:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fbf5ad930cmr2726869a91.0.1739389319343; Wed, 12 Feb 2025
 11:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
In-Reply-To: <20250211051454.2811943-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:41:47 -0500
X-Gm-Features: AWEUYZm5AbwUzNuKCG1DYiaXvLkHmMmsCo5XjkF1MjudKYbffQhiOA-OQzoTBLY
Message-ID: <CADnq5_NpzPFVK1tHKnwp7zAqNijL3ndehAwqssXetOxzUaGWdQ@mail.gmail.com>
Subject: Re: [PATCH 1/4 v6] drm/amdgpu/kfd: Add shared SDMA reset
 functionality with callback support
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 felix.kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>
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

On Tue, Feb 11, 2025 at 12:22=E2=80=AFAM Jesse.zhang@amd.com
<jesse.zhang@amd.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces shared SDMA reset functionality between AMDGPU and =
KFD.
> The implementation includes the following key changes:
>
> 1. Added `amdgpu_sdma_reset_queue`:
>    - Resets a specific SDMA queue by instance ID.
>    - Invokes registered pre-reset and post-reset callbacks to allow KFD a=
nd AMDGPU
>      to save/restore their state during the reset process.
>
> 2. Added `amdgpu_set_on_reset_callbacks`:
>    - Allows KFD and AMDGPU to register callback functions for pre-reset a=
nd
>      post-reset operations.
>    - Callbacks are stored in a global linked list and invoked in the corr=
ect order
>      during SDMA reset.
>
> This patch ensures that both AMDGPU and KFD can handle SDMA reset events
> gracefully, with proper state saving and restoration. It also provides a =
flexible
> callback mechanism for future extensions.
>
> v2: fix CamelCase and put the SDMA helper into amdgpu_sdma.c (Alex)
> v3: rename the `amdgpu_register_on_reset_callbacks` function to
>       `amdgpu_sdma_register_on_reset_callbacks`
>     move global reset_callback_list to struct amdgpu_sdma (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 72 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 11 ++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
>  3 files changed, 84 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 174badca27e7..19c8be7d72e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -460,3 +460,75 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu=
_device *adev)
>                         device_remove_file(adev->dev, &dev_attr_sdma_rese=
t_mask);
>         }
>  }
> +
> +/**
> + * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbac=
ks

Maybe rename this amdgpu_sdma_register_engine_on_reset_callbacks()

> + * @funcs: Pointer to the callback structure containing pre_reset and po=
st_reset functions
> + *
> + * This function allows KFD and AMDGPU to register their own callbacks f=
or handling
> + * pre-reset and post-reset operations. The callbacks are added to a glo=
bal list.

Consider rewording to something like:

This function allows KFD and AMDGPU to register their own callbacks for han=
dling
pre-reset and post-reset operations for engine reset.  These are
needed because engine
reset will stop all queues on that engine.

> + */
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs)
> +{
> +       if (!funcs)
> +               return;
> +
> +       /* Initialize the list node in the callback structure */
> +       INIT_LIST_HEAD(&funcs->list);
> +
> +       /* Add the callback structure to the global list */
> +       list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
> +}
> +
> +/**
> + * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
> + * @adev: Pointer to the AMDGPU device
> + * @instance_id: ID of the SDMA engine instance to reset
> + *
> + * This function performs the following steps:
> + * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> + * 2. Resets the specified SDMA engine instance.
> + * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to restore their state.
> + *
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id)

Maybe rename this?  amdgpu_sdma_reset_engine()?  I'm ok either way if
you feel strongly.

> +{
> +       struct sdma_on_reset_funcs *funcs;
> +       int ret;
> +
> +       /* Invoke all registered pre_reset callbacks */
> +       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> +               if (funcs->pre_reset) {
> +                       ret =3D funcs->pre_reset(adev, instance_id);
> +                       if (ret) {
> +                               dev_err(adev->dev,
> +                               "beforeReset callback failed for instance=
 %u: %d\n",
> +                                       instance_id, ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       /* Perform the SDMA reset for the specified instance */
> +       ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> +       if (ret) {
> +               dev_err(adev->dev, "Failed to reset SDMA instance %u\n", =
instance_id);
> +               return ret;
> +       }
> +
> +       /* Invoke all registered post_reset callbacks */
> +       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> +               if (funcs->post_reset) {
> +                       ret =3D funcs->post_reset(adev, instance_id);
> +                       if (ret) {
> +                               dev_err(adev->dev,
> +                               "afterReset callback failed for instance =
%u: %d\n",
> +                                       instance_id, ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 5f60736051d1..fbb8b04ef2cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -98,6 +98,13 @@ struct amdgpu_sdma_ras {
>         struct amdgpu_ras_block_object ras_block;
>  };
>
> +struct sdma_on_reset_funcs {

struct sdma_engine_on_reset_funcs {

> +       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id=
);
> +       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_i=
d);
> +       /* Linked list node to store this structure in a list; */
> +       struct list_head list;
> +};
> +
>  struct amdgpu_sdma {
>         struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
>         struct amdgpu_irq_src   trap_irq;
> @@ -118,6 +125,7 @@ struct amdgpu_sdma {
>         struct amdgpu_sdma_ras  *ras;
>         uint32_t                *ip_dump;
>         uint32_t                supported_reset;
> +       struct list_head        reset_callback_list;

engine_reset_callback_list

>  };
>
>  /*
> @@ -157,6 +165,9 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> +void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs);
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id);
> +
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_f=
uncs->emit_fill_buffer((ib), (s), (d), (b))
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 5e0066cd6c51..64c163dd708f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1477,7 +1477,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
>         if (r)
>                 return r;
> -
> +       INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
>         return r;
>  }
>
> --
> 2.25.1
>
