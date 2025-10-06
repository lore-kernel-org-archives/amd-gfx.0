Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7355CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 12:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED4010E07E;
	Mon,  6 Oct 2025 12:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jE5urtPz";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07E010E07E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 12:47:12 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-27ec3db6131so7839535ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Oct 2025 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759754832; x=1760359632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/caIWG/RnNzXerzdtPcB5zaJS4D+y7F1hlGQTZ0EyI=;
 b=jE5urtPz8rH2wzGocbGfBu4Wuax3JcJQYlzBJ/LGiDb5b1l3AvKDHtH4u1UC+yWYyr
 rmWpa+dB+bapjTqSmKMjg6Il0zNPw9jc4FPPYZ2bOp8SykGq4TsGQPrSS4EhXW8l9d1+
 h966JDbFdHeG8yKs8tZTo29oQZJ3aYOiSK7NLVmxpDsRJTB4feGJbVJzzk6L2tSYkmxm
 T+MbwVpIOR9Fsd+CfOiIftZ2Q74WxQv2e59MR5Bed8x787FJFer/i8fnJUwmWk1RU7Ao
 3ot33ydIxIvlfbbg1qd7F3L3pPn1Wtv9O/JuFmFDnTC+3fh/zodTY/QnBU7ShEFsxwWM
 O3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759754832; x=1760359632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/caIWG/RnNzXerzdtPcB5zaJS4D+y7F1hlGQTZ0EyI=;
 b=tvRB+60N5mEcO0hvEMhk93d83wuBKN37lf0NrS+hWg9HnrIdwKt2aL4dX5fIcWu9Mo
 SxAFCHevjoz6fqNpUGBbWSmOiJs93R6TyfUJ1fCN2w2m77aHl2ldefxuTryWeJA4eVO6
 yotUlRuRSQoSZyD/xK1pe+qcQHQ55XnoCGlFkyTmTAZxH7Zo/MqjKFTJCrwJhVCLkeXs
 /WnWO2mDOOtii3Jgr4AqsY3SXWjj3giZVwYZvuxttqPr2buENvL8ud2862YuOnXxH/q9
 DlIvgLoAht3zfRXcjS34yuzSr6/ZISLqC5RAq9O4bzJzvEQo1T4Cm3E8fWLRN/CoxRgS
 W2YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfZaNnC2N2gr98xfPWhVj6nmriDDUOlJmQS1j+f3E+QK9RQiH8kUZm0lGohQx2JAt7J+5HWlkc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhpyGsFR+gPKMsoexOgT9dUgcCj6pShooAKIyDOqCCLHrsm/wo
 whg3eq0Kll/Kdqs3HkSviq355/5OxkR+xEELqq20WnEPMHoAleHQXogqUsGx5Zb13kunFNFxOd2
 WVMRFQlVyNioIxwrutQdizV2xIdWBMzf7Mw==
X-Gm-Gg: ASbGnct890S2C9R4pxhOc75zqOXiJcEZxHnu4i3InVJSIV4Uabrq/nGtpKgIo0yD3fY
 +M0scqaE0ADYmDtfIf+7y72U7MgO31ZZh0Mz9MKIr/fNh2DquuqaUNcSlxx0Zs9ka0zlORRnj/W
 7fdnOfvMUyp/ZL6RfyOHqtj5QeoZ4y5Oy51wtMD0sah8cIIbEsE8bwj6LU3eKqGhLi3nJX51WpB
 sHlsJfXykZE6CuaicMz5g4zC5jC1xIOLJV36QOlsjow8fNNXK4C
X-Google-Smtp-Source: AGHT+IFHlR3rViKW4MOnfWODCq6zhLSmBttSNW2U2+vIku7yC4LX+4NKbsBBRnJTW7KYTkb67LK9mtPtAFP0rWfSW4Q=
X-Received: by 2002:a17:902:c403:b0:27e:f02a:b280 with SMTP id
 d9443c01a7336-28e9a65bd1cmr78881945ad.5.1759754831882; Mon, 06 Oct 2025
 05:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250925130322.1633-1-christian.koenig@amd.com>
In-Reply-To: <20250925130322.1633-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Oct 2025 08:47:00 -0400
X-Gm-Features: AS18NWC0Ha6lxnhw-c6C-swQseZBvPxmOTUwBoZ1gtyMojXc05ZhBeG9FvzWa_I
Message-ID: <CADnq5_PXQYgU0Vfdt05-PU_W9=QB-=LFNNQ5df_QeaGECVOAUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reduce queue timeout to 2 seconds
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Sep 25, 2025 at 9:19=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> There has been multiple complains that 10 seconds are usually to long.
>
> The original requirement for longer timeout came from compute tests on
> AMDVLK, since that is no longer a topic reduce the timeout back to 2
> seconds for all queues.
>
> While at it also remove any special handling for compute queues under
> SRIOV or pass through.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++----
>  2 files changed, 48 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a77000c2e0bb..ceb3c616292c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4278,58 +4278,53 @@ static int amdgpu_device_get_job_timeout_settings=
(struct amdgpu_device *adev)
>         long timeout;
>         int ret =3D 0;
>
> -       /*
> -        * By default timeout for jobs is 10 sec
> -        */
> -       adev->compute_timeout =3D adev->gfx_timeout =3D msecs_to_jiffies(=
10000);
> -       adev->sdma_timeout =3D adev->video_timeout =3D adev->gfx_timeout;
> +       /* By default timeout for all queues is 2 sec */
> +       adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_timeou=
t =3D
> +               adev->video_timeout =3D msecs_to_jiffies(2000);
>
> -       if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
> -               while ((timeout_setting =3D strsep(&input, ",")) &&
> -                               strnlen(timeout_setting, AMDGPU_MAX_TIMEO=
UT_PARAM_LENGTH)) {
> -                       ret =3D kstrtol(timeout_setting, 0, &timeout);
> -                       if (ret)
> -                               return ret;
> +       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> +               return 0;
>
> -                       if (timeout =3D=3D 0) {
> -                               index++;
> -                               continue;
> -                       } else if (timeout < 0) {
> -                               timeout =3D MAX_SCHEDULE_TIMEOUT;
> -                               dev_warn(adev->dev, "lockup timeout disab=
led");
> -                               add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL=
_OK);
> -                       } else {
> -                               timeout =3D msecs_to_jiffies(timeout);
> -                       }
> +       while ((timeout_setting =3D strsep(&input, ",")) &&
> +              strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))=
 {
> +               ret =3D kstrtol(timeout_setting, 0, &timeout);
> +               if (ret)
> +                       return ret;
>
> -                       switch (index++) {
> -                       case 0:
> -                               adev->gfx_timeout =3D timeout;
> -                               break;
> -                       case 1:
> -                               adev->compute_timeout =3D timeout;
> -                               break;
> -                       case 2:
> -                               adev->sdma_timeout =3D timeout;
> -                               break;
> -                       case 3:
> -                               adev->video_timeout =3D timeout;
> -                               break;
> -                       default:
> -                               break;
> -                       }
> +               if (timeout =3D=3D 0) {
> +                       index++;
> +                       continue;
> +               } else if (timeout < 0) {
> +                       timeout =3D MAX_SCHEDULE_TIMEOUT;
> +                       dev_warn(adev->dev, "lockup timeout disabled");
> +                       add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> +               } else {
> +                       timeout =3D msecs_to_jiffies(timeout);
>                 }
> -               /*
> -                * There is only one value specified and
> -                * it should apply to all non-compute jobs.
> -                */
> -               if (index =3D=3D 1) {
> -                       adev->sdma_timeout =3D adev->video_timeout =3D ad=
ev->gfx_timeout;
> -                       if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(a=
dev))
> -                               adev->compute_timeout =3D adev->gfx_timeo=
ut;
> +
> +               switch (index++) {
> +               case 0:
> +                       adev->gfx_timeout =3D timeout;
> +                       break;
> +               case 1:
> +                       adev->compute_timeout =3D timeout;
> +                       break;
> +               case 2:
> +                       adev->sdma_timeout =3D timeout;
> +                       break;
> +               case 3:
> +                       adev->video_timeout =3D timeout;
> +                       break;
> +               default:
> +                       break;
>                 }
>         }
>
> +       /* When only one value specified apply it to all queues. */
> +       if (index =3D=3D 1)
> +               adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdm=
a_timeout =3D
> +                       adev->video_timeout =3D timeout;
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..fe45dd1d979e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -353,22 +353,17 @@ module_param_named(svm_default_granularity, amdgpu_=
svm_default_granularity, uint
>   * DOC: lockup_timeout (string)
>   * Set GPU scheduler timeout value in ms.
>   *
> - * The format can be [Non-Compute] or [GFX,Compute,SDMA,Video]. That is =
there can be one or
> - * multiple values specified. 0 and negative values are invalidated. The=
y will be adjusted
> - * to the default timeout.
> + * The format can be [single value] for setting all timeouts at once or
> + * [GFX,Compute,SDMA,Video] to set individual timeouts.
> + * Negative values mean infinity.
>   *
> - * - With one value specified, the setting will apply to all non-compute=
 jobs.
> - * - With multiple values specified, the first one will be for GFX.
> - *   The second one is for Compute. The third and fourth ones are
> - *   for SDMA and Video.
> - *
> - * By default(with no lockup_timeout settings), the timeout for all jobs=
 is 10000.
> + * By default(with no lockup_timeout settings), the timeout for all queu=
es is 2000.
>   */
>  MODULE_PARM_DESC(lockup_timeout,
> -                "GPU lockup timeout in ms (default: 10000 for all jobs. =
"
> -                "0: keep default value. negative: infinity timeout), for=
mat: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
> -                "for passthrough or sriov [all jobs] or [GFX,Compute,SDM=
A,Video].");
> -module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu=
_lockup_timeout), 0444);
> +                "GPU lockup timeout in ms (default: 2000 for all queues.=
 "
> +                "0: keep default value. negative: infinity timeout), for=
mat: [single value for all] or [GFX,Compute,SDMA,Video].");
> +module_param_string(lockup_timeout, amdgpu_lockup_timeout,
> +                   sizeof(amdgpu_lockup_timeout), 0444);
>
>  /**
>   * DOC: dpm (int)
> --
> 2.43.0
>
