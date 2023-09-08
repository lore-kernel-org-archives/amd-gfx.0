Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C99BEE7FF3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 13:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F8010E8A5;
	Fri,  8 Sep 2023 13:15:22 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E2910E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 13:15:21 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5733789a44cso1165620eaf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Sep 2023 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694178921; x=1694783721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7U8qO6FblB3Xh7Y5LZMVzAca3mJRapmSDjZuIZFtq0Q=;
 b=EoSrkLITGyPEqK8sx3U7m1Yov9WSuEMftR02CDhn/2cqYX50C9yjtEsk+45r3MyMQr
 oGK/XBpjNKcJ9V8xRc1Wh793WXgUq5ZJ5PglcPcV32q+rvw0HBELjm34YbAFK9LyXWVq
 XopKPXhVyZY09NPRNKFdK4XGm2Uf4SPMN3q10804UlSDK1U/RuNgDz2r1STdbfwRMo5T
 fbOLhtbtNW8RBPm6lDWdDm2yjAtO1t7Bxkh0U8ECeDaujACUc7mv7CTJnJAjFs3Jrinr
 scP+on6BJyzabBE7fWpMPkOemFrjiGNjflJoMpAvXwWZREFrQoOI+dKRmylzpMx5aL1F
 Cl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694178921; x=1694783721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7U8qO6FblB3Xh7Y5LZMVzAca3mJRapmSDjZuIZFtq0Q=;
 b=amyIeCmY/s9FmQSBE6IDwrxN3L+86ufzQdG74W32kYZELa2R/DEEyuxXPtiFgb/x4E
 XwJDqp2GZYskmofYY/cM9QhZ9agllUaxb17BO+Rl1sE7ya1V73qdjKpBjKcsl1gztdUu
 HSQenopsbLx364TEO7fGxH/2oeIhNfYteOA70EZ5iGP7vJENtKif01mBnBquG4XXmfEl
 m+j35PX+YzlLnsYr8AZL/bV8xzFnq6yhPxeZePzrssT82nw27/4z0H3Wwp5VAFEIorQj
 LlqMIbclTTMJd9eHqXiyBhpZkSuJQ0zF47QjwWXvN2hjptPWo17tyTTAGlCxkQeq1uAA
 9+BA==
X-Gm-Message-State: AOJu0YwLyj6hgf3LbfR6Rv63nKba7p9W5cQCDjV4/ecfyo+4XrdHu0zr
 X5+dy2wTiYjkSgVmabtXR/ZMpxecE8vaUUh8Ntg6EDZ0
X-Google-Smtp-Source: AGHT+IGlet7Aa+GKlOqoTJjp1na6PunSKcsZpsOE5CMI2bhGzPTAkAPohbcSKdQsx6WykpMJAqKO8640SNJM687YXN8=
X-Received: by 2002:a05:6870:fba9:b0:1bb:5892:2f76 with SMTP id
 kv41-20020a056870fba900b001bb58922f76mr2747762oab.4.1694178920786; Fri, 08
 Sep 2023 06:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230908103942.995604-1-lijo.lazar@amd.com>
In-Reply-To: <20230908103942.995604-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Sep 2023 09:15:09 -0400
Message-ID: <CADnq5_O_=xh+fbK6AjEV3pgZjmNKz5+-dDXqBCZJPhpkDgFR4g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Restore partition mode after reset
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 7:05=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> On a full device reset, PSP FW gets unloaded. Hence restore the
> partition mode by placing a new request.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 28 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  2 +-
>  4 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5f32e8d4f3d3..5d2b6a7c5f6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5115,6 +5115,11 @@ int amdgpu_do_asic_reset(struct list_head *device_=
list_handle,
>                                 if (r)
>                                         return r;
>
> +                               r =3D amdgpu_xcp_restore_partition_mode(
> +                                       tmp_adev->xcp_mgr);
> +                               if (r)
> +                                       goto out;
> +
>                                 r =3D amdgpu_device_ip_resume_phase2(tmp_=
adev);
>                                 if (r)
>                                         goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index 565a1fa436d4..2b99eed5ba19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -163,16 +163,11 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr,=
 int num_xcps, int mode)
>         return 0;
>  }
>
> -int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int=
 mode)
> +static int __amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp=
_mgr,
> +                                             int mode)
>  {
>         int ret, curr_mode, num_xcps =3D 0;
>
> -       if (!xcp_mgr || mode =3D=3D AMDGPU_XCP_MODE_NONE)
> -               return -EINVAL;
> -
> -       if (xcp_mgr->mode =3D=3D mode)
> -               return 0;
> -
>         if (!xcp_mgr->funcs || !xcp_mgr->funcs->switch_partition_mode)
>                 return 0;
>
> @@ -201,6 +196,25 @@ int amdgpu_xcp_switch_partition_mode(struct amdgpu_x=
cp_mgr *xcp_mgr, int mode)
>         return ret;
>  }
>
> +int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int=
 mode)
> +{
> +       if (!xcp_mgr || mode =3D=3D AMDGPU_XCP_MODE_NONE)
> +               return -EINVAL;
> +
> +       if (xcp_mgr->mode =3D=3D mode)
> +               return 0;
> +
> +       return __amdgpu_xcp_switch_partition_mode(xcp_mgr, mode);
> +}
> +
> +int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
> +{
> +       if (!xcp_mgr || xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
> +               return 0;
> +
> +       return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode)=
;
> +}
> +
>  int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 =
flags)
>  {
>         int mode;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.h
> index 9a1036aeec2a..90138bc5f03d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -129,6 +129,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, i=
nt init_mode,
>  int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mo=
de);
>  int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 =
flags);
>  int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int=
 mode);
> +int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr);
>  int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
>                              enum AMDGPU_XCP_IP_BLOCK ip, int instance);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm=
/amd/amdgpu/aqua_vanjaram.c
> index d0fc62784e82..3f715e7fe1a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -500,7 +500,7 @@ static int aqua_vanjaram_switch_partition_mode(struct=
 amdgpu_xcp_mgr *xcp_mgr,
>                 return -EINVAL;
>         }
>
> -       if (adev->kfd.init_complete)
> +       if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
>                 flags |=3D AMDGPU_XCP_OPS_KFD;
>
>         if (flags & AMDGPU_XCP_OPS_KFD) {
> --
> 2.25.1
>
