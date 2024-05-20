Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC47C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 13:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB9310E6FE;
	Mon, 20 May 2024 13:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eyYANL3a";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A5C10E6FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 13:05:27 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso75076455ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716210326; x=1716815126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tL+pZOKvBcDJf2ALkLxd4dlq2I/5GCK4qq3MNNBV6Y0=;
 b=eyYANL3aqyqciqaaSOOdJ/XSoxFkh8D1Cae2qZijWraPWI77WJHwQiuUGB2G9IeNKj
 nqtlB2bCC54yWW8gVyD/3lJJbz+dWcLqJi1QqNA9nQWtzFfBLGk1EvueFmgO8dG++qZ9
 BbzrY6ndruLGQjpQgwLGerbZzAcIzPuRLoMSXBrnFHdebBG3iPQydFQBsylmVU6GJtS7
 2XPoXB2fS750QcUedIA5GJKzotbnsOHefgy2GfXsYxm3VgmFksazcTAhZ44gS8Rs2vBS
 7vnDgvE9n+aTahyCsOqvE4YRDoS0CsyXLej/Bt7HPpWGEvLnV6J3diFYDFHCntcD0m+b
 pHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716210326; x=1716815126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tL+pZOKvBcDJf2ALkLxd4dlq2I/5GCK4qq3MNNBV6Y0=;
 b=bcEK6uyWVYX0Gmvi+225IoKI2ITB/j+meH88nTtWm20NO/HyOBsnI2oRh/+8eMvh1v
 ujPxaa8DegDVoqdCfrTSc83Dj1F4gtItqD0mNNV+IErO9gQAyuo+JBeaohl2m/iBluqN
 85CJWLesbGjfVWbNLBdyw+I41ZcaQlJhWzQqI3vSttg1UyiLCjH5yAJIrMezrLOdF24H
 LrjNea1mPbUZ14R+cu2AvirmHtS7s5AphQXsC+X0juaNd+JFBDV5u7Osb13Jr4Db+giR
 dUnFNAdRD8ibDVcGjUpxJatzbsc3PVSG9Sq9d0QUI/l4vU5UV/QfNH/R6/2iKgNY+831
 X7XA==
X-Gm-Message-State: AOJu0YxokvLEqRF1g0CqYmKNCzz03GadGUqagCa7/Ioys+Zq5UZBtzoQ
 kXnHO5s+m4xykQrFJoTi+nB086v6Xpixv82eTTA0DMbnHmeNtIZtB25moZktihWUotY5iyAmuG5
 P+88qzfY07+KU9ugynzlxNaHi4fToBw==
X-Google-Smtp-Source: AGHT+IGmMZ3vb5Vhi/9xWJ2lOfo/u8qNrZqx/ybs2eIdHgA7pvmO297jUnvEUupAolml418fbp/jzd2yfSiSFQW4Crg=
X-Received: by 2002:a17:90a:4418:b0:2ac:5a93:636b with SMTP id
 98e67ed59e1d1-2b6cc34280dmr24464108a91.2.1716210326392; Mon, 20 May 2024
 06:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240520105858.659694-1-li.ma@amd.com>
In-Reply-To: <20240520105858.659694-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 May 2024 09:05:14 -0400
Message-ID: <CADnq5_PYHD2zjTytmcrCLgaet+Z4g3zBaQU0ZCMxyTPYjFdqWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: add intergrated info v2.3 table
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 yifan1.zhang@amd.com, tim.huang@amd.com, jesse.zhang@amd.com, lang.yu@amd.com, 
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, May 20, 2024 at 7:07=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> [Why]
> The vram width value is 0.
> Because the integratedsysteminfo table in VBIOS has updated to 2.3.
>
> [Solution]
> Driver needs a new intergrated info v2.3 table too.
> Then the vram width value will be correct.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 15 ++++++
>  drivers/gpu/drm/amd/include/atomfirmware.h    | 47 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 6fe84151332e..f932bec6e534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -212,6 +212,7 @@ union igp_info {
>         struct atom_integrated_system_info_v1_11 v11;
>         struct atom_integrated_system_info_v1_12 v12;
>         struct atom_integrated_system_info_v2_1 v21;
> +       struct atom_integrated_system_info_v2_3 v23;
>  };
>
>  union umc_info {
> @@ -366,6 +367,20 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devi=
ce *adev,
>                                         if (vram_type)
>                                                 *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
>                                         break;
> +                               case 3:
> +                                       mem_channel_number =3D igp_info->=
v23.umachannelnumber;
> +                                       if (!mem_channel_number)
> +                                               mem_channel_number =3D 1;
> +                                       mem_type =3D igp_info->v23.memory=
type;
> +                                       if (mem_type =3D=3D LpDdr5MemType=
)
> +                                               mem_channel_width =3D 32;
> +                                       else
> +                                               mem_channel_width =3D 64;
> +                                       if (vram_width)
> +                                               *vram_width =3D mem_chann=
el_number * mem_channel_width;
> +                                       if (vram_type)
> +                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> +                                       break;
>                                 default:
>                                         return -EINVAL;
>                                 }
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index af3eebb4c9bc..8c031bb675a5 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -1657,6 +1657,53 @@ struct atom_integrated_system_info_v2_2
>         uint32_t  reserved4[189];
>  };
>
> +struct uma_carveout_option
> +{
> +  char       optionName[29];        //max length of string is 28chars + =
'\0'. Current design is for "minimum", "Medium", "High". This makes entire =
struct size 64bits
> +  uint8_t    memoryCarvedGb;        //memory carved out with setting
> +  uint8_t    memoryRemainingGb;     //memory remaining on system
> +  union
> +  {
> +      struct _flags
> +      {
> +          uint8_t Auto     : 1;
> +          uint8_t Custom   : 1;
> +          uint8_t Reserved : 6;
> +      } flags;
> +      uint8_t all8;
> +  } uma_carveout_option_flags;
> +};
> +
> +struct atom_integrated_system_info_v2_3
> +{
> +  struct atom_common_table_header table_header;
> +  uint32_t vbios_misc; // enum of atom_system_vbiosmisc_def
> +  uint32_t gpucapinfo; // enum of atom_system_gpucapinf_def
> +  uint32_t system_config;
> +  uint32_t cpucapinfo;
> +  uint16_t gpuclk_ss_percentage; // unit of 0.001%,   1000 mean 1%
> +  uint16_t gpuclk_ss_type;
> +  uint16_t dpphy_override;  // bit vector, enum of atom_sysinfo_dpphy_ov=
erride_def
> +  uint8_t memorytype;       // enum of atom_dmi_t17_mem_type_def, APU me=
mory type indication.
> +  uint8_t umachannelnumber; // number of memory channels
> +  uint8_t htc_hyst_limit;
> +  uint8_t htc_tmp_limit;
> +  uint8_t reserved1; // dp_ss_control
> +  uint8_t gpu_package_id;
> +  struct edp_info_table edp1_info;
> +  struct edp_info_table edp2_info;
> +  uint32_t reserved2[8];
> +  struct atom_external_display_connection_info extdispconninfo;
> +  uint8_t                      UMACarveoutVersion;
> +  uint8_t                      UMACarveoutIndexMax;
> +  uint8_t                      UMACarveoutTypeDefault;
> +  uint8_t                      UMACarveoutIndexDefault;
> +  uint8_t                      UMACarveoutType;           //Auto or Cust=
om
> +  uint8_t                      UMACarveoutIndex;
> +  struct uma_carveout_option   UMASizeControlOption[20];
> +  uint8_t reserved3[110];
> +};
> +
>  // system_config
>  enum atom_system_vbiosmisc_def{
>    INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT =3D 0x01,
> --
> 2.25.1
>
