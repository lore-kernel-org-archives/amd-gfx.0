Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09FE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DA210E266;
	Mon,  9 Oct 2023 14:43:41 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507F410E14A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:43:39 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1dd2e65ed59so2244964fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696862618; x=1697467418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOUmIWqYfHPFKFRacLmM/JD1SEwoH1ZSyndCvvS2Ef0=;
 b=i1FkQI25+BPIcFQh2eFFV2kIJ7XENVgIU837ytIlvH6uv5sjxmJulWl4ildJ2Y6BF6
 bHtIktAWGa1IbRuweH09RWY9mdtuzJmVVTWHhp8gF84aWgQQYuhFcJYV3m++04p5h0Hz
 HcyyEWxzNDKqLFpGqioan1U30Frbc4amF7TswJJa7mFUpjJ9zuJWJ+zVpldo1POqfQ9w
 SaODiOndCWO8rjtR8++d3cW0I/M27yiewals63VDk2sREbQZW6azXFb/TRT5NjsYTb2F
 Kk/IaokUB9nQkjpShssxSWgMpghzh6ufW7KX6xP5ZDRyCGkSw55gemSsKnh5XY2YAIJR
 z4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862618; x=1697467418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOUmIWqYfHPFKFRacLmM/JD1SEwoH1ZSyndCvvS2Ef0=;
 b=rlNLYchbtlnIUVh4t5VjWhVR2HFoCzjVf8IcPcUIfnGPkgUAwIo3XnetUSb3Xku+Ed
 ZgoaLvPLjQFvfvvWVHvQLweaFgWYFx2cHGL/gIHlyPppL+yKRt0mcftDRogVM2Z2g/iB
 yPDqRjPPVcyz+fSZIrtU/bhOotdfXSAvjSgG5+Ip5EbtMTTjGVWrI6B6ulSdPnrh1SGR
 F8vVP7ZVLm8xFj7hL9eVfaxQJWQxPkQNK3C27aOB2A26PEnnomGpCfcuLt6SRuznPPgf
 Xu8oHQnuIvisYj/1A2xjZFpzrCRhnaAgrsjerPbavb22PjKmadpPAZd504GI9zrX9yJz
 IkDg==
X-Gm-Message-State: AOJu0YzeDlv2tYE7eZlPkPlsnS7evRiH+Q9Y1Py6WZM92/Icmx8tKxzo
 WRuO5tOywHLt+76WWaybqEjWVuF4Y59omtRKk6bbQHQF46A=
X-Google-Smtp-Source: AGHT+IEzdFnYv//bV9ZA5Eo9aL9JfZw0CGTEaLnGS2uW+JzJFvKUYJr4hmFzvLLINVP/hICNjRUiPB4b/OUnlRztTWk=
X-Received: by 2002:a05:6870:d695:b0:1d0:f5bd:6e9 with SMTP id
 z21-20020a056870d69500b001d0f5bd06e9mr14859834oap.22.1696862618331; Mon, 09
 Oct 2023 07:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-4-mario.limonciello@amd.com>
In-Reply-To: <20231006185026.5536-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:43:27 -0400
Message-ID: <CADnq5_NstquveGiCcJL86GOggPWyYCWU5sn+gBvw5DWMesC-NA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] drm/amd: Split up UVD suspend into prepare and
 suspend steps
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 6, 2023 at 3:07=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> amdgpu_uvd_suspend() allocates memory and copies objects into that
> allocated memory.  This fails under memory pressure.  Instead move
> majority of this code into a prepare step when swap can still be
> allocated.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * New patch
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  9 +++++++++
>  7 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index b7441654e6fa..a53c4ba8b3fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -418,12 +418,11 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *ad=
ev)
>         return 0;
>  }
>
> -int amdgpu_uvd_suspend(struct amdgpu_device *adev)
> +int amdgpu_uvd_prepare(struct amdgpu_device *adev)

amdgpu_uvd_prepare_suspend() so it's more obvious what this is for.
Other than that, looks good to me.

Alex

>  {
>         unsigned int size;
>         void *ptr;
>         int i, j, idx;
> -       bool in_ras_intr =3D amdgpu_ras_intr_triggered();
>
>         cancel_delayed_work_sync(&adev->uvd.idle_work);
>
> @@ -452,7 +451,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>
>                 if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>                         /* re-write 0 since err_event_athub will corrupt =
VCPU buffer */
> -                       if (in_ras_intr)
> +                       if (amdgpu_ras_intr_triggered())
>                                 memset(adev->uvd.inst[j].saved_bo, 0, siz=
e);
>                         else
>                                 memcpy_fromio(adev->uvd.inst[j].saved_bo,=
 ptr, size);
> @@ -461,7 +460,12 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
>                 }
>         }
>
> -       if (in_ras_intr)
> +       return 0;
> +}
> +
> +int amdgpu_uvd_suspend(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_ras_intr_triggered())
>                 DRM_WARN("UVD VCPU state may lost due to RAS ERREVENT_ATH=
UB_INTERRUPT\n");
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.h
> index 9f89bb7cd60b..72228425e021 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -74,6 +74,7 @@ struct amdgpu_uvd {
>  int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>  int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
> +int amdgpu_uvd_prepare(struct amdgpu_device *adev);
>  int amdgpu_uvd_suspend(struct amdgpu_device *adev);
>  int amdgpu_uvd_resume(struct amdgpu_device *adev);
>  int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index 5534c769b655..869e9948fa36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -706,6 +706,14 @@ static int uvd_v3_1_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int uvd_v3_1_prepare(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       return amdgpu_uvd_prepare(adev);
> +
> +}
> +
>  static int uvd_v3_1_suspend(void *handle)
>  {
>         int r;
> @@ -806,6 +814,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs =
=3D {
>         .sw_fini =3D uvd_v3_1_sw_fini,
>         .hw_init =3D uvd_v3_1_hw_init,
>         .hw_fini =3D uvd_v3_1_hw_fini,
> +       .prepare =3D uvd_v3_1_prepare,
>         .suspend =3D uvd_v3_1_suspend,
>         .resume =3D uvd_v3_1_resume,
>         .is_idle =3D uvd_v3_1_is_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index c108b8381795..e589c17af371 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -220,6 +220,14 @@ static int uvd_v4_2_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int uvd_v4_2_prepare(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       return amdgpu_uvd_prepare(adev);
> +
> +}
> +
>  static int uvd_v4_2_suspend(void *handle)
>  {
>         int r;
> @@ -756,6 +764,7 @@ static const struct amd_ip_funcs uvd_v4_2_ip_funcs =
=3D {
>         .sw_fini =3D uvd_v4_2_sw_fini,
>         .hw_init =3D uvd_v4_2_hw_init,
>         .hw_fini =3D uvd_v4_2_hw_fini,
> +       .prepare =3D uvd_v4_2_prepare,
>         .suspend =3D uvd_v4_2_suspend,
>         .resume =3D uvd_v4_2_resume,
>         .is_idle =3D uvd_v4_2_is_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index d7e31e48a2b8..65aa23bc2d91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -218,6 +218,14 @@ static int uvd_v5_0_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int uvd_v5_0_prepare(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       return amdgpu_uvd_prepare(adev);
> +
> +}
> +
>  static int uvd_v5_0_suspend(void *handle)
>  {
>         int r;
> @@ -863,6 +871,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs =
=3D {
>         .sw_fini =3D uvd_v5_0_sw_fini,
>         .hw_init =3D uvd_v5_0_hw_init,
>         .hw_fini =3D uvd_v5_0_hw_fini,
> +       .prepare =3D uvd_v5_0_prepare,
>         .suspend =3D uvd_v5_0_suspend,
>         .resume =3D uvd_v5_0_resume,
>         .is_idle =3D uvd_v5_0_is_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 5fe872f4bea7..a4035aeb973b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -542,6 +542,14 @@ static int uvd_v6_0_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int uvd_v6_0_prepare(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       return amdgpu_uvd_prepare(adev);
> +
> +}
> +
>  static int uvd_v6_0_suspend(void *handle)
>  {
>         int r;
> @@ -1528,6 +1536,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs =
=3D {
>         .sw_fini =3D uvd_v6_0_sw_fini,
>         .hw_init =3D uvd_v6_0_hw_init,
>         .hw_fini =3D uvd_v6_0_hw_fini,
> +       .prepare =3D uvd_v6_0_prepare,
>         .suspend =3D uvd_v6_0_suspend,
>         .resume =3D uvd_v6_0_resume,
>         .is_idle =3D uvd_v6_0_is_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 86d1d46e1e5e..3228bf1a379c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -612,6 +612,14 @@ static int uvd_v7_0_hw_fini(void *handle)
>         return 0;
>  }
>
> +static int uvd_v7_0_prepare(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       return amdgpu_uvd_prepare(adev);
> +
> +}
> +
>  static int uvd_v7_0_suspend(void *handle)
>  {
>         int r;
> @@ -1787,6 +1795,7 @@ const struct amd_ip_funcs uvd_v7_0_ip_funcs =3D {
>         .sw_fini =3D uvd_v7_0_sw_fini,
>         .hw_init =3D uvd_v7_0_hw_init,
>         .hw_fini =3D uvd_v7_0_hw_fini,
> +       .prepare =3D uvd_v7_0_prepare,
>         .suspend =3D uvd_v7_0_suspend,
>         .resume =3D uvd_v7_0_resume,
>         .is_idle =3D NULL /* uvd_v7_0_is_idle */,
> --
> 2.34.1
>
