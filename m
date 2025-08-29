Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983AFCA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA8210EBDD;
	Fri, 29 Aug 2025 14:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GjwlCS1j";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A02210EBDD
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:39:15 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b471741b839so388466a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756478354; x=1757083154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0CCcFAbhZqkf6kaSJ1QLgMW22n9afFjavrt6Vdej4c=;
 b=GjwlCS1jsHfkqX1jxNVqDr+sSksKU0TbRCB7+JAQdKEcPaKLktwncepk1MnElUnFgI
 DPUxaghNBPM0nVbT7u8ua9oDMgwJk6CkaYC+C5n+IkaU3CjUyAKN09nVTXP1LQNL2P7U
 9fuGJGXxjbMdAj2uE9zE4jIUIQ4zX3WaeWOYx5wn4BSrJAP9LWEDb2v2QdCoh6Vfvtt2
 oEKHd1uYrHI5iGkOpjAl7Df57vyuOa+UWFQkBybSfi3SpKAbXeaxIUQ5Za8kYAuPVyEF
 YmGVBKYoky1tW8mm/LVxQwz8bmrvQ4B8d3sI2OxtfjbAHhlI/I5bC7Ndz10bzvWfZ6aY
 7yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756478354; x=1757083154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0CCcFAbhZqkf6kaSJ1QLgMW22n9afFjavrt6Vdej4c=;
 b=BM/DIhkn08Z/qViSQt6c2KQRXL4T6sRpgUF1zthcx+WvF1VFpgISuJnBiASV18xibm
 dkIllGso1nQImx+aVmXaVLIRXS30xH0uHo53UeFhBZvqLEL9XUzWdCdmKw/2DxLIvVby
 sCRtrWjyig73lZz044RYbg4nGEDSAP3rAGWbYDHCHBwWzMXgcabc3smxK0IvXiDzJR0C
 9Ee1LsOgZ/kt3N201gqxIc5jTMsOLQGYOzNYd4TVV/AuLnYXBcssQq+MBke8rQ6xwBG0
 A5jxSC7U2uCce3U0SkCu0rDoAUMo+o0ITW/w2XkHeYeHUh3HnSk9b4E0VrzlVKWjfzuG
 6z1w==
X-Gm-Message-State: AOJu0Yweu5w05RjcnzBH+xzYnolTT4cstBv6/oQt9nTO6WdiYqUHCIfK
 YyASzxwaohXdtlBheMRGSF15ln05oTVD63YV4Npf5pMX4q/p/Au38JKUb1x/GatbDOGyZNn8IEb
 fngUPwIMCLJ+5fe/Mmnmd6Z7RwVjQaHU=
X-Gm-Gg: ASbGncuOLjzMzIPkQ3OzPRzGZnhPOpRq5yuk3CRolRqtCPzlXZsT5qHcAzGpVenaBCu
 t3L6a03yxHpK8Ur7oRi7R35wN/y9fJQgxswuLx3K0bXPmqJeFS8LiOqCNJhJ+tbkdQFToNUokgt
 zj6FSTmBXGjPiP0nKoHmrQK8S74Js/oK46YD2Cb8RZcRQ+AW8Cm/Guzlcm6EfkSqikpdOl/BT/W
 wZQMj8=
X-Google-Smtp-Source: AGHT+IEVz7+PiA4W9OBVnDqbFel8Byn3rs7WPjLr+tHQz8pZootDGRs6liIuQbD+gcCS2gzON5mvLLva6hMm6XFohfc=
X-Received: by 2002:a17:903:181:b0:248:8bf9:dc4c with SMTP id
 d9443c01a7336-2491be7d295mr13030355ad.0.1756478354387; Fri, 29 Aug 2025
 07:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250828154828.2263644-1-lijo.lazar@amd.com>
In-Reply-To: <20250828154828.2263644-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Aug 2025 10:39:02 -0400
X-Gm-Features: Ac12FXyuWyaqOeJ200nx-qg27fO2DG_JPFN6_s_L5nL_DBIGIcPTjZXl9dsqBtQ
Message-ID: <CADnq5_OMB0SdGTqdv9rcHjsH6kbZeeo_KqGHg5P4cqspDRTunA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios build number interface
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Thu, Aug 28, 2025 at 11:49=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Fetch VBIOS build number from atom rom image. Add a sysfs interface to
> read the build number.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 33 ++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/atom.c            | 22 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/atom.h            |  2 ++
>  3 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index e476e45b996a..9dfdc08cc887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1816,16 +1816,43 @@ static ssize_t amdgpu_atombios_get_vbios_version(=
struct device *dev,
>         return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
>  }
>
> +static ssize_t amdgpu_atombios_get_vbios_build(struct device *dev,
> +                                              struct device_attribute *a=
ttr,
> +                                              char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct atom_context *ctx =3D adev->mode_info.atom_context;
> +
> +       return sysfs_emit(buf, "%s\n", ctx->build_num);
> +}
> +
>  static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_versio=
n,
>                    NULL);
> +static DEVICE_ATTR(vbios_build, 0444, amdgpu_atombios_get_vbios_build, N=
ULL);
>
>  static struct attribute *amdgpu_vbios_version_attrs[] =3D {
> -       &dev_attr_vbios_version.attr,
> -       NULL
> +       &dev_attr_vbios_version.attr, &dev_attr_vbios_build.attr, NULL
>  };
>
> +static umode_t amdgpu_vbios_version_attrs_is_visible(struct kobject *kob=
j,
> +                                                    struct attribute *at=
tr,
> +                                                    int index)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       struct atom_context *ctx =3D adev->mode_info.atom_context;
> +
> +       if (attr =3D=3D &dev_attr_vbios_build.attr && !strlen(ctx->build_=
num))
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
>  const struct attribute_group amdgpu_vbios_version_attr_group =3D {
> -       .attrs =3D amdgpu_vbios_version_attrs
> +       .attrs =3D amdgpu_vbios_version_attrs,
> +       .is_visible =3D amdgpu_vbios_version_attrs_is_visible,
>  };
>
>  int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 427b073de2fc..1c994d0cc50b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1494,6 +1494,27 @@ static void atom_get_vbios_version(struct atom_con=
text *ctx)
>         }
>  }
>
> +static void atom_get_vbios_build(struct atom_context *ctx)
> +{
> +       unsigned char *atom_rom_hdr;
> +       unsigned char *str;
> +       uint16_t base;
> +
> +       base =3D CU16(ATOM_ROM_TABLE_PTR);
> +       atom_rom_hdr =3D CSTR(base);
> +
> +       str =3D CSTR(CU16(base + ATOM_ROM_CFG_PTR));
> +       /* Skip config string */
> +       while (str < atom_rom_hdr && *str++)
> +               ;
> +       /* Skip change list string */
> +       while (str < atom_rom_hdr && *str++)
> +               ;
> +
> +       if ((str + STRLEN_NORMAL) < atom_rom_hdr)
> +               strscpy(ctx->build_num, str, STRLEN_NORMAL);
> +}
> +
>  struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s)
>  {
>         int base;
> @@ -1554,6 +1575,7 @@ struct atom_context *amdgpu_atom_parse(struct card_=
info *card, void *bios)
>         atom_get_vbios_pn(ctx);
>         atom_get_vbios_date(ctx);
>         atom_get_vbios_version(ctx);
> +       atom_get_vbios_build(ctx);
>
>         return ctx;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index b807f6639a4c..825ff28731f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -37,6 +37,7 @@ struct drm_device;
>  #define ATOM_ROM_MAGIC         "ATOM"
>  #define ATOM_ROM_MAGIC_PTR     4
>
> +#define ATOM_ROM_CFG_PTR 0xC
>  #define ATOM_ROM_MSG_PTR       0x10
>  #define ATOM_ROM_CMD_PTR       0x1E
>  #define ATOM_ROM_DATA_PTR      0x20
> @@ -151,6 +152,7 @@ struct atom_context {
>         uint32_t version;
>         uint8_t vbios_ver_str[STRLEN_NORMAL];
>         uint8_t date[STRLEN_NORMAL];
> +       uint8_t build_num[STRLEN_NORMAL];
>  };
>
>  extern int amdgpu_atom_debug;
> --
> 2.49.0
>
