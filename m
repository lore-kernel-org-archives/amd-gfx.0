Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79099C25B46
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 19:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0739F10E18A;
	Mon, 23 Oct 2023 19:52:25 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E574F10E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 19:52:22 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e58a522e41so2528042fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698090742; x=1698695542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/HMddwCHqS2Zo5AnIJmEw1AvJ2DKbZ1DlnF/U64m/w=;
 b=ILvZKkh4FgUaaHAA80hkb92+NdLJeKTbrXdF+syE7JzlpAIICULiBedpMjbYQ423xd
 ivXmZ/ZaFCuF3EFFH99BB4Y9mUiA6OCD4d/6gOL+/2hIpGnVuAaY0grF+7aIJdFaQItk
 5JB3fCQDpng9TbKgQ5cxRAbg1W1DSjxblsuUWBtZpeQI2toSedyDkpn2VJbM7TWQXFWp
 NBw8JsqEEfzbxqkfolHjE8XGWD99x1AywCOzrrnUvju0BSaYMr99yHqaqGng4SLHsIn9
 SIz1q8niIWD5l1jyFrJzTadDNc4ZiMZEWo1zt7DTDM4koZB9YS/KUTrxbCkMbXoV/Syp
 PEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698090742; x=1698695542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/HMddwCHqS2Zo5AnIJmEw1AvJ2DKbZ1DlnF/U64m/w=;
 b=a89BbAFQnxc1oh/3utybgZszH1jS9AcoeDLYee2WSSzaH3pyczA2JYTznfqiDzTQUU
 Hb8v1LqCcHBlihonT+MLni9Hh0TDhtJhctgVUV2dOKj8A7URy/K8ji8sYNgZJzzKomRC
 WHqSGLo5W4Bi9Lp7542q4NgaiB4yOVW/dbNY64ZK8mKs3wPzbLPuYloVZPvwpm4gKNRE
 sf4uyf4nIdrbB7KwL9ITE5gvyJvET+qy46E6pGbA1zHk8kOGga1Ekj14aHmddoW7bCOu
 CnPE7Q3qJ5VxBWdOkv+rx22Q2myNQhYQsbQYEO6cI3fM0qiNDvtPMNtFyEnqtKBY/kpS
 XVjw==
X-Gm-Message-State: AOJu0YwZpwcSkasyViRFuK2zjWAlTvzKdbh7aQxOSiE+PpZ35yVr1/DX
 AMPFoYSC84H2/b+9dTbP/mhoLtyXIgfs7Qzxerg=
X-Google-Smtp-Source: AGHT+IEZndW2A/VlzaysXY1b5F299Qwdr4aGSeA7YVev0Xtx7RQiE9nvSwSl6OZDsHEpRD6Pv0eJNCTU231Qarx0Aqg=
X-Received: by 2002:a05:6871:a215:b0:1e9:e975:4413 with SMTP id
 vu21-20020a056871a21500b001e9e9754413mr10897868oab.27.1698090741947; Mon, 23
 Oct 2023 12:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231020151422.349394-1-lijo.lazar@amd.com>
In-Reply-To: <20231020151422.349394-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Oct 2023 15:52:10 -0400
Message-ID: <CADnq5_PWOF-SoRWuvHcx9Yt2=FgV_0diVq58W1nDr3O8OdcZjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
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
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Oct 21, 2023 at 8:02=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> PCI domain/segment information of xccs is available through ACPI DSM
> methods. Consider that also while looking for devices.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 2bca37044ad0..d62e49758635 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {
>  struct amdgpu_acpi_dev_info {
>         struct list_head list;
>         struct list_head xcc_list;
> -       uint16_t bdf;
> +       uint32_t sbdf;
>         uint16_t supp_xcp_mode;
>         uint16_t xcp_mode;
>         uint16_t mem_mode;
> @@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handl=
e handle,
>  #endif
>  }
>
> -static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
> +static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)
>  {
>         struct amdgpu_acpi_dev_info *acpi_dev;
>
> @@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get=
_dev(u16 bdf)
>                 return NULL;
>
>         list_for_each_entry(acpi_dev, &amdgpu_acpi_dev_list, list)
> -               if (acpi_dev->bdf =3D=3D bdf)
> +               if (acpi_dev->sbdf =3D=3D sbdf)
>                         return acpi_dev;
>
>         return NULL;
>  }
>
>  static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
> -                               struct amdgpu_acpi_xcc_info *xcc_info, u1=
6 bdf)
> +                               struct amdgpu_acpi_xcc_info *xcc_info, u3=
2 sbdf)
>  {
>         struct amdgpu_acpi_dev_info *tmp;
>         union acpi_object *obj;
> @@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,
>
>         INIT_LIST_HEAD(&tmp->xcc_list);
>         INIT_LIST_HEAD(&tmp->list);
> -       tmp->bdf =3D bdf;
> +       tmp->sbdf =3D sbdf;
>
>         obj =3D acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_gu=
id, 0,
>                                       AMD_XCC_DSM_GET_SUPP_MODE, NULL,
> @@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_=
dev_info **dev_info,
>
>         DRM_DEBUG_DRIVER(
>                 "New dev(%x): Supported xcp mode: %x curr xcp_mode : %x m=
em mode : %x, tmr base: %llx tmr size: %llx  ",
> -               tmp->bdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mod=
e,
> +               tmp->sbdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mo=
de,
>                 tmp->tmr_base, tmp->tmr_size);
>         list_add_tail(&tmp->list, &amdgpu_acpi_dev_list);
>         *dev_info =3D tmp;
> @@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_=
dev_info **dev_info,
>  }
>
>  static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_inf=
o,
> -                                   u16 *bdf)
> +                                   u32 *sbdf)
>  {
>         union acpi_object *obj;
>         acpi_status status;
> @@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_=
acpi_xcc_info *xcc_info,
>         xcc_info->phy_id =3D (obj->integer.value >> 32) & 0xFF;
>         /* xcp node of this xcc [47:40] */
>         xcc_info->xcp_node =3D (obj->integer.value >> 40) & 0xFF;
> +       /* PF domain of this xcc [31:16] */
> +       *sbdf =3D (obj->integer.value) & 0xFFFF0000;
>         /* PF bus/dev/fn of this xcc [63:48] */
> -       *bdf =3D (obj->integer.value >> 48) & 0xFFFF;
> +       *sbdf |=3D (obj->integer.value >> 48) & 0xFFFF;
>         ACPI_FREE(obj);
>         obj =3D NULL;
>
> @@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
>         struct acpi_device *acpi_dev;
>         char hid[ACPI_ID_LEN];
>         int ret, id;
> -       u16 bdf;
> +       u32 sbdf;
>
>         INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
>         xa_init(&numa_info_xa);
> @@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)
>                 xcc_info->handle =3D acpi_device_handle(acpi_dev);
>                 acpi_dev_put(acpi_dev);
>
> -               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &bdf);
> +               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &sbdf);
>                 if (ret) {
>                         kfree(xcc_info);
>                         continue;
>                 }
>
> -               dev_info =3D amdgpu_acpi_get_dev(bdf);
> +               dev_info =3D amdgpu_acpi_get_dev(sbdf);
>
>                 if (!dev_info)
> -                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info,=
 bdf);
> +                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info,=
 sbdf);
>
>                 if (ret =3D=3D -ENOMEM)
>                         return ret;
> @@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device=
 *adev, u64 *tmr_offset,
>                              u64 *tmr_size)
>  {
>         struct amdgpu_acpi_dev_info *dev_info;
> -       u16 bdf;
> +       u32 sbdf;
>
>         if (!tmr_offset || !tmr_size)
>                 return -EINVAL;
>
> -       bdf =3D pci_dev_id(adev->pdev);
> -       dev_info =3D amdgpu_acpi_get_dev(bdf);
> +       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
> +       sbdf |=3D pci_dev_id(adev->pdev);
> +       dev_info =3D amdgpu_acpi_get_dev(sbdf);
>         if (!dev_info)
>                 return -ENOENT;
>
> @@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device=
 *adev, int xcc_id,
>  {
>         struct amdgpu_acpi_dev_info *dev_info;
>         struct amdgpu_acpi_xcc_info *xcc_info;
> -       u16 bdf;
> +       u32 sbdf;
>
>         if (!numa_info)
>                 return -EINVAL;
>
> -       bdf =3D pci_dev_id(adev->pdev);
> -       dev_info =3D amdgpu_acpi_get_dev(bdf);
> +       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
> +       sbdf |=3D pci_dev_id(adev->pdev);
> +       dev_info =3D amdgpu_acpi_get_dev(sbdf);
>         if (!dev_info)
>                 return -ENOENT;
>
> --
> 2.25.1
>
