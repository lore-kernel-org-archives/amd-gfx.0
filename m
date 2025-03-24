Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DB4C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 14:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E4210E415;
	Mon, 24 Mar 2025 14:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwZNnXTV";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C871E10E2FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:14:03 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301317939a0so1343409a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742825643; x=1743430443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niO1fvOSFS6JO0IeTlDHRDS6Z70pNdIZMtogJL0yLU8=;
 b=VwZNnXTVSMjAN2SQH9YaFK6Og4gjyy3kkn7R94AAIA1hQsUiMF4vykJ2dF3NVDKVu5
 T+6FAzW7Kl9SH9iucvhqji0JxXSfyhiwYa2N2gfmLkzWRii2KnIuDH72JFX2KLEmHZmW
 seBX7u9S1OJJFMCi1rRwfN8GA2qk7+o6CLOyHofI02Whr0dEpvlju/BSGH9ylVaEydWn
 2QDkgoXl4mzISa9ux04uymmuzxd+dPF5MbZavIQoV1YvAGbT4t52X7TD8s2m90bZh5yH
 QIQagn9zVxn1g34EmS/A38j8xNkN2LmBSInan34l0NxUaOuq0qNtY6ncZqF4EYCW3Dkg
 5jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825643; x=1743430443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niO1fvOSFS6JO0IeTlDHRDS6Z70pNdIZMtogJL0yLU8=;
 b=CHRGbsMsfStWx9MQ/CMl+lwX/3iynN/YEOEt9uD5xDun6Dacnpy73MjZdrlA70F32c
 V4bt41AI2eqa+6f29Y2BfWUVIcOIXr52jJBiba62BBu/WiAqB/B+4gAP7zn33BLfgQTB
 qtTJiW4CJYGUzt/9Avycx/h0GJ9tUldUcu2s1EaUIpBwvMHATDdQZehGD0PR7jMRCymw
 w7XpofnPHoUWQlkQo+daTyFyxDe1iTnR+HuhqMwtIquvbCK0bVyBExC6osVimQFHIacW
 h6uEXVGU7BG5FGXKuggs6sjeOoJw7oI1LxqGFhVIE1bLfCJceFe0tUEdqLE6fqSQvYmA
 kzpg==
X-Gm-Message-State: AOJu0YwJSa8ZMHf9+jlwMg9o/XvMuK/qgXG9knKLfgSrWBmzSpl1ywe9
 2VIFs3ro+1SCNLOqR9Uo2qQB4xPKNRVOUIgqNq7nDcnSlqSU0VUBVhn5Q4ADxSxOhk0yAC+TgFl
 dFqcsI6cH91s3heGO1qrGmd31ETyUJQ==
X-Gm-Gg: ASbGnctE29i8YVg4MY/z+OYINfZc5GGiTDGkwyi8MrAWtvdUQOuM7A+xDlPYU0s03GR
 zzkFS0hIHwGZGrqCGT3jFt4Pox9EdSu5r77FNd/mYhEQT5WLo/X2lkT5zOXzA21qF2DQWTnQOmK
 85oI70KXrMrLmznKApCccSlIdsAQ==
X-Google-Smtp-Source: AGHT+IESWqEZWpRSJILuhf1chHr9wMzo5DDQDLeE5dlkiTpsP4LkVmdIgRjXrfHczpN0F2EfN3MP16Hi1W0P4SVX3R8=
X-Received: by 2002:a17:90b:2250:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3030fd37008mr7990572a91.0.1742825642735; Mon, 24 Mar 2025
 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
In-Reply-To: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 10:13:50 -0400
X-Gm-Features: AQ5f1JoWxqGZTdKeTrkSHYNzQQ5-Ua1IOJ8V1h9kO9OTHbCjQVF2E9nBK3Uql2c
Message-ID: <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add GFXOFF auto-tunning algorithm
To: Sergey Kovalenko <seryoga.engineering@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 24, 2025 at 5:06=E2=80=AFAM Sergey Kovalenko
<seryoga.engineering@gmail.com> wrote:
>
> Predict an optimal delay to enable GFXOFF for the next interval
> based on the request count:
> - less than 15 requests per second - zero delay
> - less than 25 requests per second - default delay
> - 25 and more requests per second - don't enable GFXOFF
>
> The algorithm allows maintaining low power consumption in idle,
> as well as using the full GPU power under load by eliminating
> hundreds of extra GFXOFF ON/OFF switches.

I still don't understand what problem this is solving.  This already
happens with the way the code works now.  If there are a lot of
requests to toggle gfxoff, the worker thread to allow it again gets
cancelled and scheduled again, extending the time it's disallowed.

Alex


Alex

>
> Test configuration:
> - Ryzen 5 2500U
> - Ryzen 5 3400G
> - Chromium 134.0.6998.88 Arch Linux
> - Mesa 1:24.3.4-1
> - KDE Plasma 6.3.2
>
> GFXOFF enable requests per second:
> | Test                                                | min | max |
> |-----------------------------------------------------|-----|-----|
> | System idle                                         |   0 |  64 |
> | Web browsing                                        |   0 | 127 |
> | WebGL aquarium                                      |  10 | 236 |
> | Heavy load: glxgears + vkcube + resizing + flipping |  39 | 677 |
>
> Test results, Ryzen 5 2500U:
> | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1 |
> |-----------------------------|----------------------|------------------|
> | System idle (PkgWatt)       |               ~0.74W |          ~1.25W  |
> | glxgears (vblank_mode=3D0)    |     ~7300 fps, ~7.3W | ~7300 fps, ~7.3W=
 |
> | WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fps, ~9.8W |
>
> Test results, Ryzen 5 3400G:
> | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1 |
> |-----------------------------|----------------------|------------------|
> | System idle (PkgWatt)       |                ~3.8W |           ~4.3W  |
> | glxgears (vblank_mode=3D0)    |            ~7200 fps |        ~7200 fps=
 |
> | WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 fps, 47W |
>
> Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> Tested-by: Liam Fleming <fleming.squared@proton.me>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
>   2 files changed, 67 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c1f35ded684e..5e23b956e0bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device
> *adev, int xcc_id)
>    * 3. other client can cancel their request of disable gfx off feature
>    * 4. other client should not send request to enable gfx off feature
> before disable gfx off feature.
>    */
> -
>   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>   {
> -       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> -
>         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                 return;
>
>         mutex_lock(&adev->gfx.gfx_off_mutex);
>
>         if (enable) {
> -               /* If the count is already 0, it means there's an imbalan=
ce bug
> somewhere.
> -                * Note that the bug may be in a different caller than th=
e one which
> triggers the
> -                * WARN_ON_ONCE.
> -                */
> -               if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count =3D=3D 0))
> +               /* This case covers multiple calls from parallel threads =
*/
> +               if (!adev->gfx.gfx_off_req_count)
>                         goto unlock;
>
> -               adev->gfx.gfx_off_req_count--;
> +               /* Process only if req_count =3D=3D 0 and GFXOFF is disab=
led */
> +               if (--adev->gfx.gfx_off_req_count || adev->gfx.gfx_off_st=
ate)
> +                       goto unlock;
> +
> +               /* If going to s2idle, no need to wait */
> +               if (adev->in_s0ix) {
> +                       if (!amdgpu_dpm_set_powergating_by_smu(
> +                                   adev, AMD_IP_BLOCK_TYPE_GFX, true, 0)=
)
> +                               adev->gfx.gfx_off_state =3D true;
> +
> +                       /* Reset delay flag */
> +                       adev->gfx.gfx_off_use_delay =3D 0;
> +                       goto unlock;
> +               }
>
> -               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> -                   !adev->gfx.gfx_off_state) {
> -                       /* If going to s2idle, no need to wait */
> -                       if (adev->in_s0ix) {
> -                               if (!amdgpu_dpm_set_powergating_by_smu(ad=
ev,
> -                                               AMD_IP_BLOCK_TYPE_GFX, tr=
ue, 0))
> -                                       adev->gfx.gfx_off_state =3D true;
> +               ++adev->gfx.gfx_off_counter;
> +
> +               uint64_t now =3D get_jiffies_64();
> +               uint64_t delta =3D
> +                       jiffies_to_msecs(now - adev->gfx.gfx_off_timestam=
p);
> +
> +               if (delta >=3D 1000u) {
> +                       /*
> +                        * Predict the optimal delay for the next interva=
l
> +                        * based on the current number of requests:
> +                        * <15 - idle, no delay
> +                        * <25 - light/medium load, default delay
> +                        * 25 and more - high load, GFXOFF disabled
> +                        */
> +                       if (adev->gfx.gfx_off_counter < 15u) {
> +                               adev->gfx.gfx_off_use_delay =3D 0;
> +                       } else if (adev->gfx.gfx_off_counter < 25u) {
> +                               adev->gfx.gfx_off_use_delay =3D 1;
>                         } else {
> -                               schedule_delayed_work(&adev->gfx.gfx_off_=
delay_work,
> -                                             delay);
> +                               adev->gfx.gfx_off_use_delay =3D 2;
>                         }
> +
> +                       adev->gfx.gfx_off_counter =3D 0;
> +                       adev->gfx.gfx_off_timestamp =3D now;
>                 }
> +
> +               /* Don't schedule gfxoff under heavy load */
> +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> +                       goto unlock;
> +
> +               schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
> +                                     adev->gfx.gfx_off_use_delay ?
> +                                             GFX_OFF_DELAY_ENABLE :
> +                                             GFX_OFF_NO_DELAY);
>         } else {
> -               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> -                       cancel_delayed_work_sync(&adev->gfx.gfx_off_delay=
_work);
> +               /* GFXOFF was enabled when req_count =3D=3D 0 */
> +               if (++adev->gfx.gfx_off_req_count !=3D 1)
> +                       goto unlock;
>
> -                       if (adev->gfx.gfx_off_state &&
> -                           !amdgpu_dpm_set_powergating_by_smu(adev, AMD_=
IP_BLOCK_TYPE_GFX,
> false, 0)) {
> -                               adev->gfx.gfx_off_state =3D false;
> +               /* Nothing to do if the work wasn't scheduled */
> +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> +                       goto unlock;
>
> -                               if (adev->gfx.funcs->init_spm_golden) {
> -                                       dev_dbg(adev->dev,
> -                                               "GFXOFF is disabled, re-i=
nit SPM golden settings\n");
> -                                       amdgpu_gfx_init_spm_golden(adev);
> -                               }
> +               cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
> +
> +               if (adev->gfx.gfx_off_state &&
> +                   !amdgpu_dpm_set_powergating_by_smu(
> +                           adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
> +                       adev->gfx.gfx_off_state =3D false;
> +
> +                       if (adev->gfx.funcs->init_spm_golden) {
> +                               dev_dbg(adev->dev,
> +                                       "GFXOFF is disabled, re-init SPM =
golden settings\n");
> +                               amdgpu_gfx_init_spm_golden(adev);
>                         }
>                 }
> -
> -               adev->gfx.gfx_off_req_count++;
>         }
>
>   unlock:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 8b5bd63b5773..38fd445a353b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -430,7 +430,10 @@ struct amdgpu_gfx {
>         /* gfx off */
>         bool                            gfx_off_state;      /* true: enab=
led,
> false: disabled */
>         struct mutex                    gfx_off_mutex;      /* mutex to
> change gfxoff state */
> +       uint64_t                        gfx_off_timestamp;  /* gfxoff ena=
ble call timestamp */
> +       uint32_t                        gfx_off_use_delay;  /* flag to ch=
oose the delay range */
>         uint32_t                        gfx_off_req_count;  /* default 1,
> enable gfx off: dec 1, disable gfx off: add 1 */
> +       uint32_t                        gfx_off_counter;    /* count of g=
fxoff enable calls */
>         struct delayed_work             gfx_off_delay_work; /* async work=
 to
> set gfx block off */
>         uint32_t                        gfx_off_residency;  /* last logge=
d
> residency */
>         uint64_t                        gfx_off_entrycount; /* count of t=
imes
> GPU has get into GFXOFF state */
> --
> 2.49.0
