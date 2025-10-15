Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E989DCCD194
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 13:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7BA10E7DC;
	Wed, 15 Oct 2025 13:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lytehikd";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50B410E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 13:24:10 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b63117fb83dso257792a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760534650; x=1761139450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxP7xm/0t1n0K/RpsTaxNAFFlX/QsRVFiqFhu507jEw=;
 b=LytehikdNFIILvLf/cTx+CuKXXdJf7B1yoyZCzBN+qFDMPOstG6SsW1bygvL+HZLM7
 Pt1pcCLI9cQ49xorOl4GXwtYK5B9Htm59AZuGJ0zGRGClAlVsrjXg9UEHrsCSIcGyvOM
 4I8+TD7Po6RRy9pXSdthkiAxZpd6fPo1ADUKFgiIUckpYMXjH2yPKHv2xOWt6qKE9DNv
 7HJWHTaTgcm4Hzbkn7vhcbtkZ2qMRq8jrPLodi+HJyT8vP52xh6yHhIJAI99bzgFjFD7
 /noJKLQpeaL6/oFtM/o3/omy9rFtIrNRiYjrRV6flDA0DXe0ON5KXcli2aChTwnEK88q
 s8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760534650; x=1761139450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxP7xm/0t1n0K/RpsTaxNAFFlX/QsRVFiqFhu507jEw=;
 b=r4ThnbQDAwB+VTf5w0BuupOUwwFx8JyQCtLOELNTX7MUic50bX16E6N0I9kEE6V+q9
 QPpnk9miHkEkRYbiFJLB3l+mcy6iprukXU0dzPG6kZFzA9LNKdfvGx3jhp8lONHMJsRZ
 Dib/b+0r70zCiYvba9OsZDu/lVMtuvgg2VyT9hFppCyTV1kgWsX1K0uo7ZYAYhT1225A
 xzMKFkcDrBo1wA7y0uTQOfx0zp7hzrcCKkJTspQmuFMm00wNn+yP07B4HCYmna7OhwiR
 3YNg9I6/R0QiLakk/sncrSPwPPisvtldmNopoZwaJWghflBlcw+egfH5VaNm6ceiMsq9
 6lug==
X-Gm-Message-State: AOJu0YzWkZg7fgVFbjXfhTKRbKIUxALGpayH2xK6on0V3rMQaUBlnZQB
 qgfyqt7lanm1F/YWU/EpKXDNQ4xAFhr7VCUN0w7nRYjIOqQNfafuoJGve9pGmJszTRvVs5FOL6Q
 kw91DEDo/MJDxV7n9FfkD/68vRuj1B34=
X-Gm-Gg: ASbGncsgeLHZQNOgpfuZfYgnaMH8ngHb8z85mZodBUzf55Nu4Ibnj8U/OT60BQsLJH+
 J0oBPIYEGpmTYKxWKHLDs5XwuCR/mBhdGjQAlqhjX4SIlKQMcXpsiuViirXCO/faDKfiEwfdcrH
 TeGSSJ78Ooz0t/qiPteYXyL8hTrPjwkkZevzVFnFnt/bfrz2jpV8QwUFTjSAqxohYiXhuGxuYtF
 G5Ekpg/cpwUJgJCrqMI+6ywKjDz/e3+sW3I
X-Google-Smtp-Source: AGHT+IEOhv5KKyKa6+tLES1W9XuFg7QFTWepXaXF5NazX8weSZuLACD0q448lc1co9Qk7RyCEwNp3qZLiuETSUMw7PA=
X-Received: by 2002:a17:902:d506:b0:267:af07:652f with SMTP id
 d9443c01a7336-290273369aemr190666615ad.10.1760534649778; Wed, 15 Oct 2025
 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251014201346.9422-1-yunru.pan@amd.com>
 <20251014201346.9422-5-yunru.pan@amd.com>
In-Reply-To: <20251014201346.9422-5-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 09:23:57 -0400
X-Gm-Features: AS18NWC3frsOpLRcOHL3HrO3X0pM_xxzsV6XLUVa4yTSHWjSnm4ovKW6LVWrGjA
Message-ID: <CADnq5_PzPsmUQbq_cFirORJ4LK19pXmE0F6rga8+x-mud+j3aw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
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

On Tue, Oct 14, 2025 at 4:14=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote=
:
>
> 1. Added VF logic in amdgpu_virt to init IP discovery using the offsets f=
rom dynamic(v2) critical regions;
> 2. Added VF logic in amdgpu_virt to init bios image using the offsets fro=
m dynamic(v2) critical regions;
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 36 ++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 63 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
>  4 files changed, 111 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 00e96419fcda..5960ab1be4d8 100644
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
> @@ -114,18 +115,35 @@ static bool amdgpu_read_bios_from_vram(struct amdgp=
u_device *adev)
>
>         adev->bios =3D NULL;
>         vram_base =3D pci_resource_start(adev->pdev, 0);
> -       bios =3D ioremap_wc(vram_base, size);
> -       if (!bios)
> -               return false;
> +
> +       /* For SR-IOV, if dynamic critical region is enabled,
> +       * the vbios image is put at a dynamic offset of VRAM in the VF.
> +       * If dynamic critical region is disabled, follow the same seq as =
on baremetal.
> +       */
> +       if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_en=
abled)) {
> +               bios =3D ioremap_wc(vram_base, size);
> +               if (!bios)
> +                               return false;
> +       }
>
>         adev->bios =3D kmalloc(size, GFP_KERNEL);
>         if (!adev->bios) {
> -               iounmap(bios);
> -               return false;
> +                       if (bios)
> +                               iounmap(bios);
> +                       return false;
>         }
> +
> +       if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enab=
led) {
> +               if (amdgpu_virt_get_dynamic_data_info(adev,
> +                                       AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,=
 adev->bios, &size))
> +                       return false;
> +       }
> +
>         adev->bios_size =3D size;
> -       memcpy_fromio(adev->bios, bios, size);
> -       iounmap(bios);
> +       if (bios) {
> +               memcpy_fromio(adev->bios, bios, size);
> +               iounmap(bios);
> +       }

I think it would be cleaner to just have a single conditional in this
function.  E.g.,

if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
 /* handle v2 vbios fetching */
} else {
 /* existing logic */
}

if (!check_atom_bios(adev, size)) {
        amdgpu_bios_release(adev);
            return false;
}

...

>
>         if (!check_atom_bios(adev, size)) {
>                 amdgpu_bios_release(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 73401f0aeb34..e035dba96790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -283,7 +283,7 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>                  * wait for this to complete.  Once the C2PMSG is updated=
, we can
>                  * continue.
>                  */
> -
> +

accidental whitespace change.

Alex

>                 for (i =3D 0; i < 2000; i++) {
>                         msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>                         if (msg & 0x80000000)
> @@ -299,13 +299,28 @@ static int amdgpu_discovery_read_binary_from_mem(st=
ruct amdgpu_device *adev,
>                 vram_size <<=3D 20;
>
>         if (sz_valid) {
> -               uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;
> -               amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> -                                         adev->mman.discovery_tmr_size, =
false);
> +               if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_r=
egn_enabled) {
> +                       /* For SRIOV VFs with dynamic critical region ena=
bled,
> +                        * we will get the IPD binary via below call.
> +                        * If dynamic critical is disabled, fall through =
to normal seq.
> +                        */
> +                       valid_size =3D vram_size;
> +                       if (amdgpu_virt_get_dynamic_data_info(adev,
> +                                               AMD_SRIOV_MSG_IPD_TABLE_I=
D, binary, &valid_size)) {
> +                               ret =3D -EINVAL;
> +                               goto exit;
> +                       }
> +               } else {
> +                       uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET=
;
> +
> +                       amdgpu_device_vram_access(adev, pos, (uint32_t *)=
binary,
> +                                       adev->mman.discovery_tmr_size, fa=
lse);
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
> index 820dab538164..fef4ebb0f879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -940,6 +940,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>         adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].si=
ze_kb =3D
>                 init_data_hdr->bad_page_size_in_kb;
>
> +       /* Validation for critical region info */
> +        if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb=
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
> @@ -958,6 +966,61 @@ int amdgpu_virt_init_critical_region(struct amdgpu_d=
evice *adev)
>         return r;
>  }
>
> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
> +       int data_id, uint8_t *binary, uint64_t *size)
> +{
> +       uint32_t data_offset =3D 0;
> +       uint32_t data_size =3D 0;
> +       enum amd_sriov_msg_table_id_enum data_table_id =3D data_id;
> +       char *data_name;
> +
> +       if (data_table_id >=3D AMD_SRIOV_MSG_MAX_TABLE_ID)
> +               return -EINVAL;
> +
> +       data_offset =3D adev->virt.crit_regn_tbl[data_table_id].offset;
> +       data_size =3D adev->virt.crit_regn_tbl[data_table_id].size_kb << =
10;
> +
> +       switch (data_id) {
> +       case AMD_SRIOV_MSG_IPD_TABLE_ID:
> +               data_name =3D "IPD";
> +               if (!IS_ALIGNED(data_offset, 4) || !IS_ALIGNED(data_size,=
 4)) {
> +                       dev_err(adev->dev, "IP discovery data not aligned=
 to 4 bytes\n");
> +                       return -EINVAL;
> +               }
> +
> +               amdgpu_device_vram_access(adev,
> +                               (uint64_t)data_offset, (uint32_t *)binary=
, data_size, false);
> +               if (!binary)
> +                       return -EINVAL;
> +
> +               if (((uint64_t)data_offset + (uint64_t)data_size) > *size=
)
> +                       return -EINVAL;
> +
> +               *size =3D (uint64_t)data_size;
> +
> +               break;
> +
> +       case AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID:
> +               data_name =3D "BIOS";
> +               if (data_size > *size) {
> +                       dev_err(adev->dev, "Invalid vbios size: 0x%x\n", =
data_size);
> +                       return -EINVAL;
> +               }
> +
> +               amdgpu_device_vram_access(adev,
> +                               (uint64_t)data_offset, (uint32_t *)binary=
, data_size, false);
> +
> +               *size =3D (uint64_t)data_size;
> +               break;
> +       }
> +
> +       dev_info(adev->dev,
> +               "Got %s info from dynamic crit_region_table at offset 0x%=
x with size of 0x%x bytes.\n",
> +               data_name, data_offset, data_size);
> +
> +       return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>         bool is_sriov =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 5c1dce9731e1..a3ae1ff40e84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -440,6 +440,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_dev=
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
