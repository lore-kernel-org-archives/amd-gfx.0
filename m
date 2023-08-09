Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9A1C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 13:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1076610E0B9;
	Wed,  9 Aug 2023 13:38:33 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E321B10E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 13:38:30 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a6f3ef3155so5317247b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691588310; x=1692193110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dQbzo8agGxYvvNGoV5RVHvvC2CVz5pXcZdvcuh2hEs=;
 b=sbODj9OzVYXn/0ciinqNcVhhqCnQf2eGruUBv7BsSSvj0FV/wTwQdK5PLpIDAuKUln
 YQGfv8rkg9GD7O/szrmf59ciFYctu6n352JZPmEOuPNn1VQ/pEXQkieV6Ul7LG8igVmo
 7MiOgIY4P9pr1IHBaDW4/B/t1BAvJSwODlwEqNv40XHCuKqNvUxt5CUhgkcWvwVk0JFQ
 G6wcS0KrpTG7PerShffL4aXT7iCl8a+IigAbWq2NeNXQuqZg3pN92SZci60b2M1RY4CH
 Q3g9RpFXIrinMfu2qEug7TLV3fa3vX4tbzbPeEC6EGCWrB1NQJa7lPYp3sCrth1adP3z
 fViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691588310; x=1692193110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dQbzo8agGxYvvNGoV5RVHvvC2CVz5pXcZdvcuh2hEs=;
 b=dLZX0OT1v/KaboVWB5pWlFbZjGTZiXXtHsaXPVGbmakGRXjHgOnHErbIE0z3oIiDOT
 u8eU9t19TdB3qjYh/tTrIQHOFEHy20B35bODjrp0E/a3aWc3vHDISpnsXg/+8nPBL8Mo
 yIl9bo/ipOWmyNZ9ch7MpdWQFKPYq7nxLcJW33/T626mwhv03VDfu9p2WeUbl6CtOg7q
 7NmGdIxqtsvzgAaoPRpHN1RVM60YRCh6BZdhFnbyWzP+TmznreEyE8SPx1NY5Hs5jArm
 REjsxBXPb8wLJdq1AXOVjvwfyVdhQgmqbH5yqa0gHHowetCdp9qXU4+Ds1kNOoYWsoes
 aYfQ==
X-Gm-Message-State: AOJu0YxrChQI1BUcdjOP88IrvFaEV6dnCC7Cb/HZA1My/M5frUAnzW+H
 rMGWHN1B1BFxD/ZSS0vEOLj0Bf5/+BfwUjI5Gec=
X-Google-Smtp-Source: AGHT+IENQ2CWK72lmQE12sXUxX41hhYGDamgD/pdE0IRaS2hat/ivEaqO7ty+dBWwgKmttG2PAr8zENEdKxJPNeKFvo=
X-Received: by 2002:aca:650a:0:b0:3a7:4dd0:d4db with SMTP id
 m10-20020aca650a000000b003a74dd0d4dbmr2627451oim.11.1691588310039; Wed, 09
 Aug 2023 06:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230712155245.2940715-1-alexander.deucher@amd.com>
In-Reply-To: <20230712155245.2940715-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 09:38:18 -0400
Message-ID: <CADnq5_N34NX8q=qSv6s-ntz1JFRyxzS5Q80um-TTNs0VR8pgGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: expand runpm parameter
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Jul 12, 2023 at 11:53=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Allow the user to specify -2 as auto enabled with displays.
>
> By default we don't enter runtime suspend when there are
> displays attached because it does not work well in some
> desktop environments due to the driver sending hotplug
> events on resume in case any new displays were attached
> while the GPU was powered down.  Some users still want
> this functionality though, so this lets you enable it.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2428
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 37 +++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 721f3c6160bcb..33e370d998a87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -350,8 +350,9 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
>   * Override for runtime power management control for dGPUs. The amdgpu d=
river can dynamically power down
>   * the dGPUs when they are idle if supported. The default is -1 (auto en=
able).
>   * Setting the value to 0 disables this functionality.
> + * Setting the value to -2 is auto enabled with power down when displays=
 are attached.
>   */
> -MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with BAMACO, =
1 =3D force enable with BACO, 0 =3D disable, -1 =3D auto)");
> +MODULE_PARM_DESC(runpm, "PX runtime pm (2 =3D force enable with BAMACO, =
1 =3D force enable with BACO, 0 =3D disable, -1 =3D auto, -2 =3D autowith d=
isplays)");
>  module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>
>  /**
> @@ -2657,24 +2658,26 @@ static int amdgpu_runtime_idle_check_display(stru=
ct device *dev)
>                 struct drm_connector_list_iter iter;
>                 int ret =3D 0;
>
> -               /* XXX: Return busy if any displays are connected to avoi=
d
> -                * possible display wakeups after runtime resume due to
> -                * hotplug events in case any displays were connected whi=
le
> -                * the GPU was in suspend.  Remove this once that is fixe=
d.
> -                */
> -               mutex_lock(&drm_dev->mode_config.mutex);
> -               drm_connector_list_iter_begin(drm_dev, &iter);
> -               drm_for_each_connector_iter(list_connector, &iter) {
> -                       if (list_connector->status =3D=3D connector_statu=
s_connected) {
> -                               ret =3D -EBUSY;
> -                               break;
> +               if (amdgpu_runtime_pm !=3D -2) {
> +                       /* XXX: Return busy if any displays are connected=
 to avoid
> +                        * possible display wakeups after runtime resume =
due to
> +                        * hotplug events in case any displays were conne=
cted while
> +                        * the GPU was in suspend.  Remove this once that=
 is fixed.
> +                        */
> +                       mutex_lock(&drm_dev->mode_config.mutex);
> +                       drm_connector_list_iter_begin(drm_dev, &iter);
> +                       drm_for_each_connector_iter(list_connector, &iter=
) {
> +                               if (list_connector->status =3D=3D connect=
or_status_connected) {
> +                                       ret =3D -EBUSY;
> +                                       break;
> +                               }
>                         }
> -               }
> -               drm_connector_list_iter_end(&iter);
> -               mutex_unlock(&drm_dev->mode_config.mutex);
> +                       drm_connector_list_iter_end(&iter);
> +                       mutex_unlock(&drm_dev->mode_config.mutex);
>
> -               if (ret)
> -                       return ret;
> +                       if (ret)
> +                               return ret;
> +               }
>
>                 if (adev->dc_enabled) {
>                         struct drm_crtc *crtc;
> --
> 2.41.0
>
