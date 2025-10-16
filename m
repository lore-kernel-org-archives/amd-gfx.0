Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41489CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 13:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE5310E9DD;
	Thu, 16 Oct 2025 13:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSULMJHB";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806FD10E9DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 13:06:55 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-28d18e933a9so1172765ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760620015; x=1761224815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=241S2AA8w8DeDVu2QuIFSgISdu4E2MrhfMJfmTMFh9c=;
 b=mSULMJHB7wl6M3iRs68r2j9QJeyhY5z0+tLOXerj62V62YaAEjIOsMao/mh/gfJOXY
 TwYmsGXKKH7Lhsrc/Laqz1gTIrlUiOc31LlONwQ7fWGABXKnJ/QCERAXEIPoJVrePMK7
 l5913gRObmjV33csKbDiSTzNuss9gkytQpEiICP14/nISv2Vn1nbHiNyZ96vCd0krEdW
 NvL1lnvGyUYz3g3xAC/KQ+HwldeTpGD134upDpS01NJOSP/WE410hvUYH83ociiqhA88
 N3bysaRyXBYZ9NI1WtPgYaMRwe+wKLsTwtNqV3P0AZivUl4iDhTjO/sel7v87Ag1wUmC
 Dy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760620015; x=1761224815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=241S2AA8w8DeDVu2QuIFSgISdu4E2MrhfMJfmTMFh9c=;
 b=ECxM8fTLCmfUMVf/TPBb5TMOetmOMq1wcMlPhP2DV4QyyJd+IwD/dHoCDSQGqPvO17
 SBd0uddlMMAx/o9WSPWiDXy+2CAN3Ur4njtHZaZlp8p3AQAVp9hIg/QFXCGnSs8iL4q9
 AkYIsj8gOsYgXvnMIkHpXsiHurnOm6pFkHGi8dNWKLMQL59642wgym92ImlY5efMpGlX
 y5l55gLYNPR15JAxHxOTzlTECtWhNiNaRW9FJ4hntem7zW/S/CqTIKB+6acch+2cbcoM
 T0ReZCj/R+7QDlaQF3oEtDur++GgZYuGvHeoXZxeckbx7pPsM7y/lkphXpZAqzF7o3wd
 43ZA==
X-Gm-Message-State: AOJu0YyH0PiMxWmBxyOYYBOEUqfkyJ7c1Cb3FuUmTv8wZ/BSzsCwsPbL
 cEpQziax8xdhEzmRI7QYke4cJUuhYVhSgrFheTpKLQmzugIVYQmTuAXV/gErdq14i1zp1mDablo
 MQo8YaeKCNXdm01a8IkgwDllHh0b3e1U=
X-Gm-Gg: ASbGncs6GbajXdkrfUZwx98e6NbtaNFFAO0TaSfxbeOS4Fs5274LWBvHnVD1+RJthHC
 mwwZIKhXHDvT3xshCPt9E4ycnBFdp91nLKtrQDLrNeuPivZFqDs8Q51/RUrJfRs2JmSCzGF1/pQ
 6cEnkHgEmUUWLkPpxqG2amS/oWjJIF+WimgIPHU6dB/gWD3eeGfXx11dTAaV7R4QK1PzmJzC0nL
 CZOLNv3WmZ0R95HULg8HTWwNjrPfsoW7O1LytxFVZvX1ePeJy+sUDLJQadY
X-Google-Smtp-Source: AGHT+IGPRslfOjFbbVd/6wvggMb/BEzzZB9liW6CsVLZvw/0COvjifbJrc77D3XJJXaYopir6PeFHk68KdPIo+dlJj0=
X-Received: by 2002:a17:902:c94c:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-2902723ca5dmr232806765ad.3.1760620014806; Thu, 16 Oct 2025
 06:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-4-yunru.pan@amd.com>
In-Reply-To: <20251015214848.11580-4-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2025 09:06:43 -0400
X-Gm-Features: AS18NWBZxg3atsHOPelcyw_hZa6I--4KZjeeyIcVJ9BiU_BoJcVpTvh_jhOpbdA
Message-ID: <CADnq5_MYkn6_WhPhG7y1+9_kPYWEUsPBWZ-fZ+S6+r7j2G4nyA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com, Jeffrey.Chan@amd.com
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

On Wed, Oct 15, 2025 at 5:56=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> 1. Added VF logic in amdgpu_virt to init IP discovery using the offsets f=
rom dynamic(v2) critical regions;
> 2. Added VF logic in amdgpu_virt to init bios image using the offsets fro=
m dynamic(v2) critical regions;
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 34 ++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 37 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
>  4 files changed, 83 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 00e96419fcda..070fd61f8463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -96,11 +96,12 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>   * part of the system bios.  On boot, the system bios puts a
>   * copy of the igp rom at the start of vram if a discrete card is
>   * present.
> - * For SR-IOV, the vbios image is also put in VRAM in the VF.
> + * For SR-IOV, if dynamic critical region is not enabled,
> + * the vbios image is also put at the start of VRAM in the VF.
>   */
>  static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>  {
> -       uint8_t __iomem *bios;
> +       uint8_t __iomem *bios =3D NULL;
>         resource_size_t vram_base;
>         resource_size_t size =3D 256 * 1024; /* ??? */
>
> @@ -114,18 +115,33 @@ static bool amdgpu_read_bios_from_vram(struct amdgp=
u_device *adev)
>
>         adev->bios =3D NULL;
>         vram_base =3D pci_resource_start(adev->pdev, 0);
> -       bios =3D ioremap_wc(vram_base, size);
> -       if (!bios)
> -               return false;
>
>         adev->bios =3D kmalloc(size, GFP_KERNEL);
> -       if (!adev->bios) {
> -               iounmap(bios);
> +       if (!adev->bios)
>                 return false;
> +
> +       /* For SRIOV with dynamic critical region is enabled,
> +        * the vbios image is put at a dynamic offset of VRAM in the VF.
> +        * If dynamic critical region is disabled, follow the existing lo=
gic as on baremetal.
> +        */
> +       if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enab=
led) {
> +               if (amdgpu_virt_get_dynamic_data_info(adev,
> +                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->b=
ios, &size)) {
> +                       amdgpu_bios_release(adev);
> +                       return false;
> +               }
> +       } else {
> +               bios =3D ioremap_wc(vram_base, size);
> +               if (!bios) {
> +                       amdgpu_bios_release(adev);
> +                       return false;
> +               }
> +
> +               memcpy_fromio(adev->bios, bios, size);
> +               iounmap(bios);
>         }
> +
>         adev->bios_size =3D size;
> -       memcpy_fromio(adev->bios, bios, size);
> -       iounmap(bios);
>
>         if (!check_atom_bios(adev, size)) {
>                 amdgpu_bios_release(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 4e75334f3b3a..1809deb86797 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -303,14 +303,29 @@ static int amdgpu_discovery_read_binary_from_mem(st=
ruct amdgpu_device *adev,
>          * then it is not required to be reserved.
>          */
>         if (sz_valid) {
> -               uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;
> -               amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> -                                         adev->discovery.size, false);
> -               adev->discovery.reserve_tmr =3D true;
> +               if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_r=
egn_enabled) {
> +                       /* For SRIOV VFs with dynamic critical region ena=
bled,
> +                        * we will get the IPD binary via below call.
> +                        * If dynamic critical is disabled, fall through =
to normal seq.
> +                        */
> +                       if (amdgpu_virt_get_dynamic_data_info(adev,
> +                                               AMD_SRIOV_MSG_IPD_TABLE_I=
D, binary,
> +                                               (uint64_t *)&adev->mman.d=
iscovery_tmr_size)) {

I think this is adev->discovery.size now after Lijo's latest changes.
@Lazar, Lijo I think we can remove adev->mman.discovery_tmr_size.
It's no longer used by anything.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                               ret =3D -EINVAL;
> +                               goto exit;
> +                       }
> +               } else {
> +                       uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET=
;
> +
> +                       amdgpu_device_vram_access(adev, pos, (uint32_t *)=
binary,
> +                                       adev->discovery.size, false);
> +                       adev->discovery.reserve_tmr =3D true;
> +               }
>         } else {
>                 ret =3D amdgpu_discovery_read_binary_from_sysmem(adev, bi=
nary);
>         }
>
> +exit:
>         if (ret)
>                 dev_err(adev->dev,
>                         "failed to read discovery info from memory, vram =
size read: %llx",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 12659990abe0..15157ed5df29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -999,6 +999,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>                 goto out;
>         }
>
> +       /* Validation for critical region info */
> +       if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
> DISCOVERY_TMR_SIZE) {
> +               dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
> +                               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IP=
D_TABLE_ID].size_kb);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
>         /* reserved memory starts from crit region base offset with the s=
ize of 5MB */
>         adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit_regn.of=
fset;
>         adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.size_kb <<=
 10;
> @@ -1017,6 +1025,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu=
_device *adev)
>         return r;
>  }
>
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +       int data_id, uint8_t *binary, uint64_t *size)
> +{
> +       uint32_t data_offset =3D 0;
> +       uint32_t data_size =3D 0;
> +       enum amd_sriov_msg_table_id_enum data_table_id =3D data_id;
> +
> +       if (data_table_id >=3D AMD_SRIOV_MSG_MAX_TABLE_ID)
> +               return -EINVAL;
> +
> +       data_offset =3D adev->virt.crit_regn_tbl[data_table_id].offset;
> +       data_size =3D adev->virt.crit_regn_tbl[data_table_id].size_kb << =
10;
> +
> +       /* Validate on input params */
> +       if (!binary || !size || *size < (uint64_t)data_size)
> +               return -EINVAL;
> +
> +       /* Proceed to copy the dynamic content */
> +       amdgpu_device_vram_access(adev,
> +                       (uint64_t)data_offset, (uint32_t *)binary, data_s=
ize, false);
> +       *size =3D (uint64_t)data_size; // update the size as out param.
> +
> +       dev_dbg(adev->dev,
> +               "Got %s info from dynamic crit_region_table at offset 0x%=
x with size of 0x%x bytes.\n",
> +               amdgpu_virt_dynamic_crit_table_name[data_id], data_offset=
, data_size);
> +
> +       return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>         bool is_sriov =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 8d03a8620de9..2a13cc892a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -442,6 +442,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_dev=
ice *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>
>  int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +       int data_id, uint8_t *binary, uint64_t *size);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
> --
> 2.34.1
>
