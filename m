Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC98C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 20:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C4B10EAFC;
	Mon, 13 Jul 2026 20:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVU56IaK";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C8810E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 20:44:11 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cac39b729dso8742795ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783975451; cv=none;
 d=google.com; s=arc-20260327;
 b=WSLNZIGgvqv57p13uc4XxU5q5tLaxgCMnGZMMO5ZXEbQUchk6aBXHi6J6jZdIrmFyu
 JitApJHcovPKfqky1QLmAzYBXvQ6Bhz2bmYCYv4lOUZyNgt6JpXxi9p28C7XdH1udrK2
 XzbRyMeZp69h9zCr/xfHEQjTB7yGoeF55EcPMcohgmWyoQZPn33yUC38j8RMlcQyJbfu
 lxNBHXmW7+fBr0N0HAyI26SvR/szvIwSamOWeEpqYCbCHuCxAiVa5sJWp5jp+mRTAct/
 xQuchhcfgZiSsXJRrC7yK80r6Boi100rvEwYFw7TfDWeNOja5y/GSJJAT1xCmkZbU/Fr
 S+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fvJIMMGeH5CpxhnBMC3YiQouM9VphGJKpbxxSM20rfI=;
 fh=dDS2INNd4jdzjcwUt14ZDE5wwZiXtMeDLLkq52oMk0s=;
 b=rgeV7S46hxJVI/6gVNh77qHD6QmOjXCkQZBez0rclQsXbhF/ykpGBvFVYRal7G65Qv
 nQJyEPRl+4rlUVrdBzovIAOejVPF41CzVD2PigxCP1TtYO9cO6MF405v762M7aXnco7j
 RsLpFyt/PUPMc77WW7MV70PD4dIg9sFR75umxbE5mCfEPxcwrBUgYa/KWaLy38YCm1kr
 ocWHdE5Yj6jgBiQdZPCxpQJCbEPL2a6RdTPShWLtGxv3MlVQPhEU5EWjctdWh8UN2wIt
 IcOeGKZWO+a/+XuwpR45GFJjZruTG46BJ9hd82jQmKqh7MjN2ykAuEb9p+ngcBBEAxDf
 FY2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783975451; x=1784580251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fvJIMMGeH5CpxhnBMC3YiQouM9VphGJKpbxxSM20rfI=;
 b=MVU56IaK71oQN4v/M17IJUoRvOJ28Xr7o9VIEwX2bxFA3NrVZqujt9SqV2cOifuUOb
 qOzyVSIFO19k6eIiG+EfLFkg2Bh2dgn3kAuh32I3HjOpY8PZgQOBjQOKNv9+QdwHOX8l
 BBK0cXv8M9qq+9q4Lu7WyOGPdAT8h3cU+AW5VZpnZJi84/+oDUBiEmg15QsJiW8NMpcf
 E5yyw05YgMllH9Qtzsmk18pumj4j5t0bvz79it2PC/bp5Z6QmAJsiCLb/Dklr9h4odsA
 pZ1J8P1RMYof5Ob3GG1ENoFmuR5Q1fBa4SG8HYo21MKcg5E0/PNGE8ZfErtq4trk4RWF
 XcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783975451; x=1784580251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvJIMMGeH5CpxhnBMC3YiQouM9VphGJKpbxxSM20rfI=;
 b=LaahZGXy7sbAvvu6Xjki7I8gs4f5M2YX7rmNysvCOU86b7LedrtmTCPMtKK35zmjoc
 9w8Qhua1nqFkxG+qhU6UXxLKhxeC47QIt37T9kbc4ucsl/VesOVsyng8pDWl+7Kqc9FO
 5QM251C9oFxFo163rasL/aBM4Vn9fGLV7gkjwn/qBoBcOAmL/boNJs6PL19Q/UcJsr3W
 rfzy5kihERs1M0FyApe7f3uZcioPyLjmN6P4qVHwLc4toy+uPGMp3oYsD/5fVV0V6Q+i
 0vlGIUQh/J0+a72Xl/GSyoZ3aSCpev/siWKCbKKjborj0bQl4KuKOkXQX6RpWX7j45EY
 tCCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrVpLhT0UwKHKWGT47+MSAOUctu4p98g2+BHMLhF4+5t0wwJFvXpnlvoc2vX+Up1eyeScYicXI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpqC55FwCABfQvDvmNKthWBT3+J5ThKdF8+UzrM5MqA8h/uuPN
 4XMzy0XxR5DUWXPbOnZwOLIO1tm5MeRMRndLSTsZWAWmZdstj+vZSJ/LrKlcpQnWR9v1j5zC92/
 Kfm0jnxmsUr+c0+BFqKhZoptMkUMAwXVRUg==
X-Gm-Gg: AfdE7cl41Y5KV+8shizb8eFzFVrZqjmO7sYoV7NveICcmSBPFk+bgykqTUwszc1xsU+
 XmDxn24Yc6aHk+JcYTVxDs/oUUmKP4ffLqDMwDQJjKWuOGqQlPyD4xctsO4na6OajA2CKJ6Z2Jo
 q1uOqC0CYPZ3aIAq1TWe9D3ZE25SDPOVUgtb5rT4f+crla5WF8OkRJnXid5U09ob1fJpR5EmDa0
 vAi5fsy12rJlXkqkmxaFxMi4Bi5xQBF5tXbT92P8XOVdO7p3Jvrf8Hj5tov5E/I09kEAhJkI+6f
 ELJ4BCuq7kwQt/n9MfnZ3Zg7KBm0wyLNK+zcrJYpCzY3Rcv3dV0YQXAGhIE=
X-Received: by 2002:a17:903:b85:b0:2c0:db23:4a6 with SMTP id
 d9443c01a7336-2ce9e2a0fb6mr80167275ad.1.1783975450878; Mon, 13 Jul 2026
 13:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
 <20260713162722.3349626-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260713162722.3349626-4-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 16:43:57 -0400
X-Gm-Features: AVVi8CcqALRWkKAP50MB7UTKwCp-ar0APMsPAOyTu3l28ztqJEcwIZnV6mnGwuA
Message-ID: <CADnq5_MNJf9OpyjTSeH=vuAhGx_1Ok0FwsVPkYYi_tt6pj+Gow@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jul 13, 2026 at 12:34=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Signal GPU_RESET EVENTFD subscriptions after successful GPU reset
> completion.
>
> GPU reset notifications allow userspace to observe that GPU recovery has
> completed and the device is operational again.
>
> GPU_RESET is a device-scoped event, so no queue object is used. All
> processes that subscribed to GPU_RESET on the device are notified.
>
> EVENTFD remains notification-only.
>
> v2:
> - Move GPU_RESET EVENTFD signaling to the path that confirms a real
>   GPU hardware reset occurred.
> - Notify only after successful hardware reset completion.
> - Do not signal reset-skip or recovery-only paths.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..15aaceae13d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5390,15 +5390,43 @@ static void amdgpu_device_halt_activities(struct =
amdgpu_device *adev,
>         }
>  }
>
> +/*
> + * Signal GPU_RESET EVENTFD subscriptions for all open DRM files.
> + *
> + * GPU reset is a device-wide event rather than being associated with a
> + * specific user queue. Notify every process that subscribed to the
> + * GPU_RESET event on this device.
> + */
> +static void amdgpu_device_eventfd_signal_gpu_reset(struct amdgpu_device =
*adev)
> +{
> +       struct drm_device *ddev =3D adev_to_drm(adev);
> +       struct drm_file *file;
> +
> +       mutex_lock(&ddev->filelist_mutex);
> +
> +       list_for_each_entry(file, &ddev->filelist, lhead) {
> +               struct amdgpu_fpriv *fpriv =3D file->driver_priv;
> +
> +               if (fpriv)
> +                       amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
> +                                             DRM_AMDGPU_EVENT_TYPE_GPU_R=
ESET,
> +                                             NULL);
> +       }
> +
> +       mutex_unlock(&ddev->filelist_mutex);
> +}
> +
>  static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>                               struct list_head *device_list,
>                               struct amdgpu_reset_context *reset_context)
>  {
>         struct amdgpu_device *tmp_adev =3D NULL;
> +       bool need_full_reset, skip_hw_reset;
>         int retry_limit =3D AMDGPU_MAX_RETRY_LIMIT;
>         int r =3D 0;
>
> -retry: /* Rest of adevs pre asic reset from XGMI hive. */
> +retry:
> +       /* Rest of adevs pre asic reset from XGMI hive. */
>         list_for_each_entry(tmp_adev, device_list, reset_list) {
>                 r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_contex=
t);
>                 /*TODO Should we stop ?*/
> @@ -5430,10 +5458,30 @@ static int amdgpu_device_asic_reset(struct amdgpu=
_device *adev,
>                 }
>                 if (r)
>                         adev->asic_reset_res =3D r;
> +               else
> +                       amdgpu_device_eventfd_signal_gpu_reset(adev);
>         } else {
> +               /*
> +                * Save the reset decision before amdgpu_do_asic_reset(),
> +                * which may clear AMDGPU_NEED_FULL_RESET before returnin=
g.
> +                */
> +               need_full_reset =3D
> +                       test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->=
flags);
> +               skip_hw_reset =3D
> +                       test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->fl=
ags);
> +
>                 r =3D amdgpu_do_asic_reset(device_list, reset_context);
>                 if (r && r =3D=3D -EAGAIN)
>                         goto retry;
> +
> +               /*
> +                * Notify only after a real hardware reset completed.
> +                * Do not notify recovery-only or reset-skip paths.
> +                */
> +               if (!r && need_full_reset && !skip_hw_reset) {
> +                       list_for_each_entry(tmp_adev, device_list, reset_=
list)
> +                               amdgpu_device_eventfd_signal_gpu_reset(tm=
p_adev);
> +               }
>         }
>
>         list_for_each_entry(tmp_adev, device_list, reset_list) {
> @@ -5530,7 +5578,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_=
device *adev,
>         }
>  }
>
> -
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> --
> 2.34.1
>
