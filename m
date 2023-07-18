Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9785EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 19:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2410E3BF;
	Tue, 18 Jul 2023 19:37:38 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0784310E3BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 19:37:35 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b059dd7c0cso4886607fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689709055; x=1692301055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXYV2LrmwdgtVcvo2bUR7sIktRV2M70B/xwbzrcgMHM=;
 b=XPG9bfdZvDyplUjQ3uxoP/3DnFh+J7w3JUqDTrbE0XiXvgxkVPjfAU76VOkRbDW5Wf
 bI6XBCEEodGxWhw8gACFnqnA9nR0h2Vw7D7E4vmqW9vdCuRef9Mx1N2O1PCqPrulK0Vi
 UCWLP/sKq41J/nfkCOg/6yBuThU68+7KAndlEaLEffq5lZ/asMtGW3h1oq7+jjI8qV64
 ZG9+sLnFeOqFVNZI0K3ub1wc5taagY4b6sLAx6oHLhqwi29oQtfuUgXcTAqLmhJUmS9U
 F178VsogMcuhUw2W2bvbxDzJ/IJoCh8tw8XEIkgFNky4AJJS8cTEndkdQ+M5oH9mlR2B
 csEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689709055; x=1692301055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXYV2LrmwdgtVcvo2bUR7sIktRV2M70B/xwbzrcgMHM=;
 b=Uq7sKmLhmK69dmS+WrX9FFZI/sV5OV+EYl0q0plKUjrgVVfIRFkdpxpkKosxjaawAQ
 TQcNLX8nS7iMjabdqXu0H193nlagRtrs64kkTcJ+6x0quq3Z0hZeelErgNthggta+OKQ
 x/fzw7P9rPTBQ7TThTDjxC5ggGR65j8j/ejdx9GBGUXrf1k1s+5mQ+EYIm+WErs5jG8n
 D4Ymti5Pqsny2EzJubkw+Tn+TvIEXtKiwXFLonPkzgyDXfAYp0W7i+bMZptQcVeNBzQ2
 t2PlBPpTFd4ZnojRATq+Mzyy20v5pS2lUy8BUndTPUylai1VCcesKUHh5wIc3xWg0OUf
 rWSQ==
X-Gm-Message-State: ABy/qLarS3WDlA/oqPTmH6JTqQ0EFIKebAJfflVBg0C8KukZOUJiRIJp
 HG5iCh8vlGn1mx0AN7rmSMvVAUPSysPw1Chuutw=
X-Google-Smtp-Source: APBJJlGToIMBLg13/uPtsP07bsg3WfE+YhLc2EMSLPtgOUUFAE5O+wczNT1Mwo4AWQas6RjPPryp/6OIqeIKDY9B8hM=
X-Received: by 2002:a05:6870:8a09:b0:1b7:5f2f:85fe with SMTP id
 p9-20020a0568708a0900b001b75f2f85femr18962781oaq.48.1689709054783; Tue, 18
 Jul 2023 12:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230718180258.17737-1-mario.limonciello@amd.com>
In-Reply-To: <20230718180258.17737-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jul 2023 15:37:23 -0400
Message-ID: <CADnq5_NomXrigsQwYTFMy_uN6Tui_aKLwZF98JebL_7vOto3Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Avoid reading the VBIOS part number twice
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 18, 2023 at 2:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The VBIOS part number is read both in amdgpu_atom_parse() as well
> as in atom_get_vbios_pn() and stored twice in the `struct atom_context`
> structure. Remove the first unnecessary read and move the `pr_info`
> line from that read into the second.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 20 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  8 ++++----
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/atom.c             | 13 ++----------
>  drivers/gpu/drm/amd/amdgpu/atom.h             |  2 --
>  7 files changed, 22 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index f4e3c133a16ca..dce9e7d5e4ec6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(st=
ruct device *dev,
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct atom_context *ctx =3D adev->mode_info.atom_context;
>
> -       return sysfs_emit(buf, "%s\n", ctx->vbios_version);
> +       return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
>  }
>
>  static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_versio=
n,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 4620c4712ce32..c9f16eab0f3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -60,10 +60,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_dev=
ice *adev, u32 *fru_addr)
>         switch (adev->asic_type) {
>         case CHIP_VEGA20:
>                 /* D161 and D163 are the VG20 server SKUs */
> -               if (strnstr(atom_ctx->vbios_version, "D161",
> -                           sizeof(atom_ctx->vbios_version)) ||
> -                   strnstr(atom_ctx->vbios_version, "D163",
> -                           sizeof(atom_ctx->vbios_version))) {
> +               if (strnstr(atom_ctx->vbios_pn, "D161",
> +                           sizeof(atom_ctx->vbios_pn)) ||
> +                   strnstr(atom_ctx->vbios_pn, "D163",
> +                           sizeof(atom_ctx->vbios_pn))) {
>                         if (fru_addr)
>                                 *fru_addr =3D FRU_EEPROM_MADDR_6;
>                         return true;
> @@ -72,16 +72,16 @@ static bool is_fru_eeprom_supported(struct amdgpu_dev=
ice *adev, u32 *fru_addr)
>                 }
>         case CHIP_ALDEBARAN:
>                 /* All Aldebaran SKUs have an FRU */
> -               if (!strnstr(atom_ctx->vbios_version, "D673",
> -                            sizeof(atom_ctx->vbios_version)))
> +               if (!strnstr(atom_ctx->vbios_pn, "D673",
> +                            sizeof(atom_ctx->vbios_pn)))
>                         if (fru_addr)
>                                 *fru_addr =3D FRU_EEPROM_MADDR_6;
>                 return true;
>         case CHIP_SIENNA_CICHLID:
> -               if (strnstr(atom_ctx->vbios_version, "D603",
> -                           sizeof(atom_ctx->vbios_version))) {
> -                       if (strnstr(atom_ctx->vbios_version, "D603GLXE",
> -                                   sizeof(atom_ctx->vbios_version))) {
> +               if (strnstr(atom_ctx->vbios_pn, "D603",
> +                           sizeof(atom_ctx->vbios_pn))) {
> +                       if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
> +                                   sizeof(atom_ctx->vbios_pn))) {
>                                 return false;
>                         } else {
>                                 if (fru_addr)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index cca5a495611f3..46844082762a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1719,7 +1719,7 @@ static int amdgpu_debugfs_firmware_info_show(struct=
 seq_file *m, void *unused)
>         seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\=
n",
>                    fw_info.feature, fw_info.ver);
>
> -       seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
> +       seq_printf(m, "VBIOS version: %s\n", ctx->vbios_pn);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 8aaa427f8c0f6..5055c14d6b426 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2440,10 +2440,10 @@ static void amdgpu_ras_get_quirks(struct amdgpu_d=
evice *adev)
>         if (!ctx)
>                 return;
>
> -       if (strnstr(ctx->vbios_version, "D16406",
> -                   sizeof(ctx->vbios_version)) ||
> -               strnstr(ctx->vbios_version, "D36002",
> -                       sizeof(ctx->vbios_version)))
> +       if (strnstr(ctx->vbios_pn, "D16406",
> +                   sizeof(ctx->vbios_pn)) ||
> +               strnstr(ctx->vbios_pn, "D36002",
> +                       sizeof(ctx->vbios_pn)))
>                 adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_BLOCK__GFX);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 0648dfe559afc..4287743e12124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -194,9 +194,9 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_devic=
e *adev,
>                 /* VEGA20 and ARCTURUS */
>                 if (adev->asic_type =3D=3D CHIP_VEGA20)
>                         control->i2c_address =3D EEPROM_I2C_MADDR_0;
> -               else if (strnstr(atom_ctx->vbios_version,
> +               else if (strnstr(atom_ctx->vbios_pn,
>                                  "D342",
> -                                sizeof(atom_ctx->vbios_version)))
> +                                sizeof(atom_ctx->vbios_pn)))
>                         control->i2c_address =3D EEPROM_I2C_MADDR_0;
>                 else
>                         control->i2c_address =3D EEPROM_I2C_MADDR_4;
> @@ -205,8 +205,8 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_devic=
e *adev,
>                 control->i2c_address =3D EEPROM_I2C_MADDR_0;
>                 return true;
>         case IP_VERSION(13, 0, 2):
> -               if (strnstr(atom_ctx->vbios_version, "D673",
> -                           sizeof(atom_ctx->vbios_version)))
> +               if (strnstr(atom_ctx->vbios_pn, "D673",
> +                           sizeof(atom_ctx->vbios_pn)))
>                         control->i2c_address =3D EEPROM_I2C_MADDR_4;
>                 else
>                         control->i2c_address =3D EEPROM_I2C_MADDR_0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 5f610e9a5f0f8..edbb862c1025a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1438,6 +1438,8 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
>
>                 ctx->vbios_pn[count] =3D 0;
>         }
> +
> +       pr_info("ATOM BIOS: %s\n", ctx->vbios_pn);
>  }
>
>  static void atom_get_vbios_version(struct atom_context *ctx)
> @@ -1460,7 +1462,6 @@ struct atom_context *amdgpu_atom_parse(struct card_=
info *card, void *bios)
>         int base;
>         struct atom_context *ctx =3D
>             kzalloc(sizeof(struct atom_context), GFP_KERNEL);
> -       char *str;
>         struct _ATOM_ROM_HEADER *atom_rom_header;
>         struct _ATOM_MASTER_DATA_TABLE *master_table;
>         struct _ATOM_FIRMWARE_INFO *atom_fw_info;
> @@ -1502,16 +1503,6 @@ struct atom_context *amdgpu_atom_parse(struct card=
_info *card, void *bios)
>                 return NULL;
>         }
>
> -       idx =3D CU16(ATOM_ROM_PART_NUMBER_PTR);
> -       if (idx =3D=3D 0)
> -               idx =3D 0x80;
> -
> -       str =3D CSTR(idx);
> -       if (*str !=3D '\0') {
> -               pr_info("ATOM BIOS: %s\n", str);
> -               strscpy(ctx->vbios_version, str, sizeof(ctx->vbios_versio=
n));
> -       }
> -
>         atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
>         if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
>                 master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdg=
pu/atom.h
> index 0c18398245206..55bf99d5288d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -33,7 +33,6 @@ struct drm_device;
>  #define ATOM_ATI_MAGIC_PTR     0x30
>  #define ATOM_ATI_MAGIC         " 761295520"
>  #define ATOM_ROM_TABLE_PTR     0x48
> -#define ATOM_ROM_PART_NUMBER_PTR       0x6E
>
>  #define ATOM_ROM_MAGIC         "ATOM"
>  #define ATOM_ROM_MAGIC_PTR     4
> @@ -143,7 +142,6 @@ struct atom_context {
>         int io_mode;
>         uint32_t *scratch;
>         int scratch_size_bytes;
> -       char vbios_version[20];
>
>         uint8_t name[STRLEN_LONG];
>         uint8_t vbios_pn[STRLEN_LONG];
> --
> 2.34.1
>
