Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A879CF8855
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 19:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D4010EA86;
	Fri,  4 Oct 2024 19:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwB8fBsn";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEC410EA86
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 19:15:10 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-7e9f6f5e7f4so34187a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728069310; x=1728674110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHL/667hewoeaBlWTdcoeTncZwYrwFCekM+d7bJ2Njg=;
 b=BwB8fBsnw07oIxHBJFXjtDB/oiRHrnt4upScrBWuRJ5YmTrvqlS0E3l6iGMzJMl2Eu
 N8eCa+xSCDXJKBs3sf39hRS+U3qerADWwMNu0eaT1AwEwJ+8GK3PbUYCIG168oerVQGP
 5ZqHUgexq++dUQGUJP6+zIyXfYPAN6onrrxWCvfgTAkPspPwFdvr2CnesLQSrK8CaAQp
 qKJMRvSwUj6B16ReZ1c4UnidCj/4EEkWnfeMNc4Noj5ggRYpvi+jIeCb3sU0cKKm0nla
 neSEm/kbnPnDpkd1/9L3Tm3MP8vz3l1BMYWzHJqV+7QblRrX3oEnXFvAoP58e/L2/WKn
 19sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728069310; x=1728674110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHL/667hewoeaBlWTdcoeTncZwYrwFCekM+d7bJ2Njg=;
 b=XWAJ23ZqVflzFAT6Y6vv7sfODAAb9b7KURQOimro1RZHAOrvxVOq7mVcC2eSrfheAi
 Fm0O0+296FAKB9rPb6N8r5QazjuoFTTGGLt33hjE/vI3lbXsFN29GTXaSJa/I4NQ2Sa/
 36z/3ObgrsDBYJsUyjtdHWpgY792CFVjn6VDejT1rfMwdwGG7cOzJwapuzur8w+4xK7I
 5SpMpe7eaH/R3qUpKHQfivTbGiYlwme93SeNkY9asbaqOJUkE4mrA+2PK8/dktty0WZn
 xnXpEphboH311ffpC5HVRC0+GKi9id5D3MdWF37XS+7kgORTPMWYUtUfNrsnr59Jd82l
 6sjg==
X-Gm-Message-State: AOJu0YzbzKfyX/9lzcoWSMxjRZdCFkuyyRIr4PecmKDx8WVHue1XwsDv
 RmhRGkT+BSXpo8ekTK3XBTqYVUP6TPtTmFF72XRrtzYsMx6CwU9TW6Qjfe2TeKyto75ycKhJ/+D
 LjrjSOqh7wEbveREeZpRO5yIGNFM=
X-Google-Smtp-Source: AGHT+IHwJUwi+PF4G3Yjnu+riaAH36d1MM2Pi9DOsT67It7BdCiZOm/ot/rn1KBLLsVT1+sTt8ZfpsWMU519tJaSd/Q=
X-Received: by 2002:a05:6a20:840b:b0:1cf:4845:67f with SMTP id
 adf61e73a8af0-1d6dfacdc1emr2903231637.9.1728069309947; Fri, 04 Oct 2024
 12:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-5-boyuan.zhang@amd.com>
In-Reply-To: <20241004184444.435356-5-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 15:14:58 -0400
Message-ID: <CADnq5_ORfYpPigB4z+a0fKbksW8URCsP-Me28yTsE7yg2T72mw@mail.gmail.com>
Subject: Re: [PATCH 04/18] drm/amd/pm: add inst to set_powergating_by_smu
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add an instance parameter to set_powergating_by_smu() function, and
> re-write all amd_pm functions accordingly. Then use the instance to
> call smu_dpm_set_vcn_enable().
>
> v2: remove duplicated functions.
>
> remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
> to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
> logic as before, until further separation in next patch.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
>  5 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 2fa71f68205e..f24bc61df9a7 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -405,7 +405,9 @@ struct amd_pm_funcs {
>         int (*load_firmware)(void *handle);
>         int (*wait_for_fw_loading_complete)(void *handle);
>         int (*set_powergating_by_smu)(void *handle,
> -                               uint32_t block_type, bool gate);
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst);
>         int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
>         int (*set_power_limit)(void *handle, uint32_t n);
>         int (*get_power_limit)(void *handle, uint32_t *limit,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 9dc82f4d7c93..bcedbeec082f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCE:
>         case AMD_IP_BLOCK_TYPE_GFX:
> -       case AMD_IP_BLOCK_TYPE_VCN:
>         case AMD_IP_BLOCK_TYPE_SDMA:
>         case AMD_IP_BLOCK_TYPE_JPEG:
>         case AMD_IP_BLOCK_TYPE_GMC:
> @@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_de=
vice *adev, uint32_t block
>         case AMD_IP_BLOCK_TYPE_VPE:
>                 if (pp_funcs && pp_funcs->set_powergating_by_smu)
>                         ret =3D (pp_funcs->set_powergating_by_smu(
> -                               (adev)->powerplay.pp_handle, block_type, =
gate));
> +                               (adev)->powerplay.pp_handle, block_type, =
gate, 0));
> +               break;
> +       case AMD_IP_BLOCK_TYPE_VCN:
> +               if (pp_funcs && pp_funcs->set_powergating_by_smu) {
> +                       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++=
)
> +                               ret =3D (pp_funcs->set_powergating_by_smu=
(
> +                                       (adev)->powerplay.pp_handle, bloc=
k_type, gate, i));
> +               }
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 2cd6cb991f29..af7da780b58b 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3287,7 +3287,9 @@ static int kv_dpm_read_sensor(void *handle, int idx=
,
>  }
>
>  static int kv_set_powergating_by_smu(void *handle,
> -                               uint32_t block_type, bool gate)
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst)
>  {
>         switch (block_type) {
>         case AMD_IP_BLOCK_TYPE_UVD:
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index f193c77cc141..de5ee1c5503f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1241,7 +1241,9 @@ static void pp_dpm_powergate_sdma(void *handle, boo=
l gate)
>  }
>
>  static int pp_set_powergating_by_smu(void *handle,
> -                               uint32_t block_type, bool gate)
> +                               uint32_t block_type,
> +                               bool gate,
> +                               int inst)
>  {
>         int ret =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 786241fa8d2c..0da84e390d0d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -353,10 +353,10 @@ static int smu_set_mall_enable(struct smu_context *=
smu)
>   */
>  static int smu_dpm_set_power_gate(void *handle,
>                                   uint32_t block_type,
> -                                 bool gate)
> +                                 bool gate,
> +                                 int inst)
>  {
>         struct smu_context *smu =3D handle;
> -       struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
> @@ -373,12 +373,10 @@ static int smu_dpm_set_power_gate(void *handle,
>          */
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       ret =3D smu_dpm_set_vcn_enable(smu, !gate, i);
> -                       if (ret)
> -                               dev_err(smu->adev->dev, "Failed to power =
%s VCN!\n",
> -                                       gate ? "gate" : "ungate");
> -               }
> +               ret =3D smu_dpm_set_vcn_enable(smu, !gate, inst);
> +               if (ret)
> +                       dev_err(smu->adev->dev, "Failed to power %s VCN!\=
n",
> +                               gate ? "gate" : "ungate");

Might want to note the instance in the error message.

Alex

>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
>                 ret =3D smu_gfx_off_control(smu, gate);
> --
> 2.34.1
>
