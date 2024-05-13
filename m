Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D16C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 16:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFC810E880;
	Mon, 13 May 2024 16:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z0t8S9YZ";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C0D10E880
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 16:58:47 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2b2bc7b37bcso4057229a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715619526; x=1716224326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnotypf+m4uOzinUi8VmOh+OqEgLUCpwIFI863jmFYQ=;
 b=Z0t8S9YZRmrQCjBXv1BYPpwwBOGJaeNO66GcPvhnGn6A4jz6uj4e1hFaqayat+Jlv1
 gHS+K/nqOiFGlnhm0G54sSPa0sOxSM5IYXcDwCSryD0kOIiXEqbEqodskVDjOBefvYgX
 k3ZU9QT34euWM27ry3w4ohomHipjSWNxRXtlSE8K4gz3CJ/8RC/vK4oP+znI4gQT9F3L
 4082rlWpOZRT9xdnrG4QDSwx4FokrqEQ5sE/x9YXZ0ZRLUB8IlpHC4dKNT3KD3sJuTwK
 DbL2Z3qOUNBa4mI2HCAWPJu2nojKj8kREmhgnMNgrzJGsLBqt71DM5b02cu5fiuAR2A3
 xQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715619526; x=1716224326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnotypf+m4uOzinUi8VmOh+OqEgLUCpwIFI863jmFYQ=;
 b=jqx7V1qJNy0auPnTzIlLatmUMAOHiMiJ0+jO4zmHbBfBPgjbZ70meYGahYoPg/z/up
 PEHE1UsrK3XS1choFfiqtrUxYqYaVQbIFkWPBrpI79h5sn3F9EfE78T8qSpFqNqm3FC5
 Sm2BpDjCkumIX1dQPYOYDD1ynOQ4Y3e0qIenrTtVeNICFGhcsJdRJpX9jLW7lTPPT31A
 0jrQUGMMZQBnvffA4VrAg03Pkfm8DxJsWtpTwU46NZUan4xKwX8/CiKIooMTvg9S42YY
 4mzyBn5v4Tv9VZaYpS4KARxxcIPHkotU4QiCo8KL4jBAu677WUgu5aUeKmiZAqMMEUW4
 MNtA==
X-Gm-Message-State: AOJu0YylT5QUUFPdgHSFA7sKWIEVFoPFsyUvCwpJminG/4I5NaZAeYtW
 j1b8CMcDdyi/hJbKwAczw/Eg/KMnNuWz8d+SApjH0v1JrbyuE+DfhNeZMVSEXFyg9rrtGymVP+Q
 3PFysP8Prr4wprK67FHly+MAQseOiQQ==
X-Google-Smtp-Source: AGHT+IEdlRmZHnjBP9zACpTNOlyQpcLerc8Jh5CTI1RMXFCPczKd11bIT57WTWAIFyIzuqNoAFb5x3xzSEuV9qhRxFs=
X-Received: by 2002:a17:90a:bd92:b0:2af:8d8:c90a with SMTP id
 98e67ed59e1d1-2b6cc14b8aamr9826596a91.5.1715619526443; Mon, 13 May 2024
 09:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240513100131.113631-1-Frank.Min@amd.com>
 <SA1PR12MB565944EEE174445FB2084490E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
 <SA1PR12MB5659E02A7542DEEB521F1BC6E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659E02A7542DEEB521F1BC6E9E22@SA1PR12MB5659.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 May 2024 12:58:34 -0400
Message-ID: <CADnq5_OMH5FkpDz=mcSuXzN9FGUrw1dYFqe4fdnHdNHgxx=8Ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix getting vram info for gfx12
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
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

On Mon, May 13, 2024 at 11:32=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wro=
te:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> gfx12 query video mem channel/type/width from umc_info of atom list, so f=
ix it accordingly.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 263 ++++++++++--------
>  1 file changed, 148 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index a6d64bdbbb14..6fe84151332e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -289,7 +289,6 @@ static int convert_atom_mem_type_to_vram_type(struct =
amdgpu_device *adev,
>         return vram_type;
>  }
>
> -
>  int
>  amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>                                   int *vram_width, int *vram_type,
> @@ -300,6 +299,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
>         u16 data_offset, size;
>         union igp_info *igp_info;
>         union vram_info *vram_info;
> +       union umc_info *umc_info;
>         union vram_module *vram_module;
>         u8 frev, crev;
>         u8 mem_type;
> @@ -311,10 +311,16 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_dev=
ice *adev,
>         if (adev->flags & AMD_IS_APU)
>                 index =3D get_index_into_master_table(atom_master_list_of=
_data_tables_v2_1,
>                                                     integratedsysteminfo)=
;
> -       else
> -               index =3D get_index_into_master_table(atom_master_list_of=
_data_tables_v2_1,
> -                                                   vram_info);
> -
> +       else {
> +               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +               case IP_VERSION(12, 0, 0):
> +               case IP_VERSION(12, 0, 1):
> +                       index =3D get_index_into_master_table(atom_master=
_list_of_data_tables_v2_1, umc_info);
> +                       break;
> +               default:
> +                       index =3D get_index_into_master_table(atom_master=
_list_of_data_tables_v2_1, vram_info);
> +               }
> +       }
>         if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>                                           index, &size,
>                                           &frev, &crev, &data_offset)) {
> @@ -368,123 +374,150 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_d=
evice *adev,
>                                 return -EINVAL;
>                         }
>                 } else {
> -                       vram_info =3D (union vram_info *)
> -                               (mode_info->atom_context->bios + data_off=
set);
> -                       module_id =3D (RREG32(adev->bios_scratch_reg_offs=
et + 4) & 0x00ff0000) >> 16;
> -                       if (frev =3D=3D 3) {
> -                               switch (crev) {
> -                               /* v30 */
> -                               case 0:
> -                                       vram_module =3D (union vram_modul=
e *)vram_info->v30.vram_module;
> -                                       mem_vendor =3D (vram_module->v30.=
dram_vendor_id) & 0xF;
> -                                       if (vram_vendor)
> -                                               *vram_vendor =3D mem_vend=
or;
> -                                       mem_type =3D vram_info->v30.memor=
y_type;
> -                                       if (vram_type)
> -                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> -                                       mem_channel_number =3D vram_info-=
>v30.channel_num;
> -                                       mem_channel_width =3D vram_info->=
v30.channel_width;
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * (1 << mem_channel_width);
> -                                       break;
> -                               default:
> -                                       return -EINVAL;
> -                               }
> -                       } else if (frev =3D=3D 2) {
> -                               switch (crev) {
> -                               /* v23 */
> -                               case 3:
> -                                       if (module_id > vram_info->v23.vr=
am_module_num)
> -                                               module_id =3D 0;
> -                                       vram_module =3D (union vram_modul=
e *)vram_info->v23.vram_module;
> -                                       while (i < module_id) {
> -                                               vram_module =3D (union vr=
am_module *)
> -                                                       ((u8 *)vram_modul=
e + vram_module->v9.vram_module_size);
> -                                               i++;
> -                                       }
> -                                       mem_type =3D vram_module->v9.memo=
ry_type;
> -                                       if (vram_type)
> -                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> -                                       mem_channel_number =3D vram_modul=
e->v9.channel_num;
> -                                       mem_channel_width =3D vram_module=
->v9.channel_width;
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * (1 << mem_channel_width);
> -                                       mem_vendor =3D (vram_module->v9.v=
ender_rev_id) & 0xF;
> -                                       if (vram_vendor)
> -                                               *vram_vendor =3D mem_vend=
or;
> -                                       break;
> -                               /* v24 */
> -                               case 4:
> -                                       if (module_id > vram_info->v24.vr=
am_module_num)
> -                                               module_id =3D 0;
> -                                       vram_module =3D (union vram_modul=
e *)vram_info->v24.vram_module;
> -                                       while (i < module_id) {
> -                                               vram_module =3D (union vr=
am_module *)
> -                                                       ((u8 *)vram_modul=
e + vram_module->v10.vram_module_size);
> -                                               i++;
> +                       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +                       case IP_VERSION(12, 0, 0):
> +                       case IP_VERSION(12, 0, 1):
> +                               umc_info =3D (union umc_info *)(mode_info=
->atom_context->bios +
> +data_offset);
> +
> +                               if (frev =3D=3D 4) {
> +                                       switch (crev) {
> +                                       case 0:
> +                                               mem_channel_number =3D le=
32_to_cpu(umc_info->v40.channel_num);
> +                                               mem_type =3D le32_to_cpu(=
umc_info->v40.vram_type);
> +                                               mem_channel_width =3D le3=
2_to_cpu(umc_info->v40.channel_width);
> +                                               mem_vendor =3D RREG32(ade=
v->bios_scratch_reg_offset + 4) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               break;
> +                                       default:
> +                                               return -EINVAL;
>                                         }
> -                                       mem_type =3D vram_module->v10.mem=
ory_type;
> -                                       if (vram_type)
> -                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> -                                       mem_channel_number =3D vram_modul=
e->v10.channel_num;
> -                                       mem_channel_width =3D vram_module=
->v10.channel_width;
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * (1 << mem_channel_width);
> -                                       mem_vendor =3D (vram_module->v10.=
vender_rev_id) & 0xF;
> -                                       if (vram_vendor)
> -                                               *vram_vendor =3D mem_vend=
or;
> -                                       break;
> -                               /* v25 */
> -                               case 5:
> -                                       if (module_id > vram_info->v25.vr=
am_module_num)
> -                                               module_id =3D 0;
> -                                       vram_module =3D (union vram_modul=
e *)vram_info->v25.vram_module;
> -                                       while (i < module_id) {
> -                                               vram_module =3D (union vr=
am_module *)
> -                                                       ((u8 *)vram_modul=
e + vram_module->v11.vram_module_size);
> -                                               i++;
> +                               } else
> +                                       return -EINVAL;
> +                               break;
> +                       default:
> +                               vram_info =3D (union vram_info *)
> +                                       (mode_info->atom_context->bios + =
data_offset);
> +
> +                               module_id =3D (RREG32(adev->bios_scratch_=
reg_offset + 4) & 0x00ff0000) >> 16;
> +                               if (frev =3D=3D 3) {
> +                                       switch (crev) {
> +                                       /* v30 */
> +                                       case 0:
> +                                               vram_module =3D (union vr=
am_module *)vram_info->v30.vram_module;
> +                                               mem_vendor =3D (vram_modu=
le->v30.dram_vendor_id) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               mem_type =3D vram_info->v=
30.memory_type;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               mem_channel_number =3D vr=
am_info->v30.channel_num;
> +                                               mem_channel_width =3D vra=
m_info->v30.channel_width;
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               break;
> +                                       default:
> +                                               return -EINVAL;
>                                         }
> -                                       mem_type =3D vram_module->v11.mem=
ory_type;
> -                                       if (vram_type)
> -                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> -                                       mem_channel_number =3D vram_modul=
e->v11.channel_num;
> -                                       mem_channel_width =3D vram_module=
->v11.channel_width;
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * (1 << mem_channel_width);
> -                                       mem_vendor =3D (vram_module->v11.=
vender_rev_id) & 0xF;
> -                                       if (vram_vendor)
> -                                               *vram_vendor =3D mem_vend=
or;
> -                                       break;
> -                               /* v26 */
> -                               case 6:
> -                                       if (module_id > vram_info->v26.vr=
am_module_num)
> -                                               module_id =3D 0;
> -                                       vram_module =3D (union vram_modul=
e *)vram_info->v26.vram_module;
> -                                       while (i < module_id) {
> -                                               vram_module =3D (union vr=
am_module *)
> -                                                       ((u8 *)vram_modul=
e + vram_module->v9.vram_module_size);
> -                                               i++;
> +                               } else if (frev =3D=3D 2) {
> +                                       switch (crev) {
> +                                       /* v23 */
> +                                       case 3:
> +                                               if (module_id > vram_info=
->v23.vram_module_num)
> +                                                       module_id =3D 0;
> +                                               vram_module =3D (union vr=
am_module *)vram_info->v23.vram_module;
> +                                               while (i < module_id) {
> +                                                       vram_module =3D (=
union vram_module *)
> +                                                               ((u8 *)vr=
am_module + vram_module->v9.vram_module_size);
> +                                                       i++;
> +                                               }
> +                                               mem_type =3D vram_module-=
>v9.memory_type;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               mem_channel_number =3D vr=
am_module->v9.channel_num;
> +                                               mem_channel_width =3D vra=
m_module->v9.channel_width;
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               mem_vendor =3D (vram_modu=
le->v9.vender_rev_id) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               break;
> +                                       /* v24 */
> +                                       case 4:
> +                                               if (module_id > vram_info=
->v24.vram_module_num)
> +                                                       module_id =3D 0;
> +                                               vram_module =3D (union vr=
am_module *)vram_info->v24.vram_module;
> +                                               while (i < module_id) {
> +                                                       vram_module =3D (=
union vram_module *)
> +                                                               ((u8 *)vr=
am_module + vram_module->v10.vram_module_size);
> +                                                       i++;
> +                                               }
> +                                               mem_type =3D vram_module-=
>v10.memory_type;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               mem_channel_number =3D vr=
am_module->v10.channel_num;
> +                                               mem_channel_width =3D vra=
m_module->v10.channel_width;
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               mem_vendor =3D (vram_modu=
le->v10.vender_rev_id) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               break;
> +                                       /* v25 */
> +                                       case 5:
> +                                               if (module_id > vram_info=
->v25.vram_module_num)
> +                                                       module_id =3D 0;
> +                                               vram_module =3D (union vr=
am_module *)vram_info->v25.vram_module;
> +                                               while (i < module_id) {
> +                                                       vram_module =3D (=
union vram_module *)
> +                                                               ((u8 *)vr=
am_module + vram_module->v11.vram_module_size);
> +                                                       i++;
> +                                               }
> +                                               mem_type =3D vram_module-=
>v11.memory_type;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               mem_channel_number =3D vr=
am_module->v11.channel_num;
> +                                               mem_channel_width =3D vra=
m_module->v11.channel_width;
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               mem_vendor =3D (vram_modu=
le->v11.vender_rev_id) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               break;
> +                                       /* v26 */
> +                                       case 6:
> +                                               if (module_id > vram_info=
->v26.vram_module_num)
> +                                                       module_id =3D 0;
> +                                               vram_module =3D (union vr=
am_module *)vram_info->v26.vram_module;
> +                                               while (i < module_id) {
> +                                                       vram_module =3D (=
union vram_module *)
> +                                                               ((u8 *)vr=
am_module + vram_module->v9.vram_module_size);
> +                                                       i++;
> +                                               }
> +                                               mem_type =3D vram_module-=
>v9.memory_type;
> +                                               if (vram_type)
> +                                                       *vram_type =3D co=
nvert_atom_mem_type_to_vram_type(adev, mem_type);
> +                                               mem_channel_number =3D vr=
am_module->v9.channel_num;
> +                                               mem_channel_width =3D vra=
m_module->v9.channel_width;
> +                                               if (vram_width)
> +                                                       *vram_width =3D m=
em_channel_number * (1 << mem_channel_width);
> +                                               mem_vendor =3D (vram_modu=
le->v9.vender_rev_id) & 0xF;
> +                                               if (vram_vendor)
> +                                                       *vram_vendor =3D =
mem_vendor;
> +                                               break;
> +                                       default:
> +                                               return -EINVAL;
>                                         }
> -                                       mem_type =3D vram_module->v9.memo=
ry_type;
> -                                       if (vram_type)
> -                                               *vram_type =3D convert_at=
om_mem_type_to_vram_type(adev, mem_type);
> -                                       mem_channel_number =3D vram_modul=
e->v9.channel_num;
> -                                       mem_channel_width =3D vram_module=
->v9.channel_width;
> -                                       if (vram_width)
> -                                               *vram_width =3D mem_chann=
el_number * (1 << mem_channel_width);
> -                                       mem_vendor =3D (vram_module->v9.v=
ender_rev_id) & 0xF;
> -                                       if (vram_vendor)
> -                                               *vram_vendor =3D mem_vend=
or;
> -                                       break;
> -                               default:
> +                               } else {
> +                                       /* invalid frev */
>                                         return -EINVAL;
>                                 }
> -                       } else {
> -                               /* invalid frev */
> -                               return -EINVAL;
>                         }
>                 }
> -
>         }
>
>         return 0;
> --
> 2.34.1
>
