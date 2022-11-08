Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B52FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 15:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9A110E48C;
	Tue,  8 Nov 2022 15:38:50 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697A610E496
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 15:38:47 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-13bd19c3b68so16625936fac.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Nov 2022 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QT/0bRogfxXO3eLpuyDHLpCYqggn2av3pdqirgj/64U=;
 b=gXydHcLCXPMOOHZq4tDv1vomRHPEUuhjARtmQhnfMFduBedLvJujUO+e6c3EnSWmkh
 f+gkzd4kB0iiMFbPJNqkY+aRCe0D0PdSakrg3wrYcYf1KCbC9sUNYcuqNcuT21BKQitm
 LWuVrbxksO1CGKyrMIJqBhgNSCm9f6k6zIY3yetq11+7Q9Dmx8yZlLxSJRA0/zs7HoEc
 iuuMjiwdxvCsyY3fUv4Vtglqh8MdQtFbvo+OfoyTWW2Q7+oWlOC+tvsVrn+voyvB95+Y
 vkVNQ1dBBOqyPOUv+WGYnYJBOJDGi0VlYxOkgccLDMVuyKcckWM1hTo62hKYi+0ludJB
 4cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QT/0bRogfxXO3eLpuyDHLpCYqggn2av3pdqirgj/64U=;
 b=Pmr83Vs8+zbeXS/+93YDO3cW++UIuK+uA/b/jQJJiJl0pFff9hBTKtB2iBmogkBByV
 0N2n9z+OlZXzjvOKVVI23Zp3k1mNJOHTZFxN7IjJfNhke1hSwvAshaAzXFA5ZpjDK6m7
 Hg/wHh9dqox0E1aIfn1tX5mNsLT6OYmGjdj7e0KVViDxtVOIQk92o/uqCEuRpLbCpVq5
 1wp2WArxej3/Wg/qGbLjnj45/LV2w0uHucR5FrO1Pru7/aywGotaFPobeh6CzmkEMFeJ
 pSgg6v42uNlD6qgJXqHfiPN3GPSEsOOAJtoGzRdGLYz/GncO2pFeMlK239nwo9Scz8+4
 fwXQ==
X-Gm-Message-State: ACrzQf2cbb5H9ScKyccAoil9lCBgbKK97z3XgEU4MGeGHu+lSgM8X2sS
 65CaYx9WatNWuBaM7JQ1QXfe6RE3tgtzjMJ/YF9O8+Z4
X-Google-Smtp-Source: AMsMyM59v8bzXVJnP0xwaBXKFkp09bNJuvH4axlPORX0eNiiBrW64QzRQ+4Ta07CGdB9D7f9RuFtfeNWuhOdbU1DpK8=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr33869619oao.96.1667921926576; Tue, 08
 Nov 2022 07:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107174411.168459-1-luben.tuikov@amd.com>
In-Reply-To: <20221107174411.168459-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Nov 2022 10:38:34 -0500
Message-ID: <CADnq5_OAhyc5T9mHHVqGcByy-=J=MfkfrToFJeYJeR5Vr1Siuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Decouple RAS EEPROM addresses from chips
To: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 7, 2022 at 12:45 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Abstract RAS I2C EEPROM addresses from chip names, and set their macro
> definition names to the address they set, not the chip they attach
> to. Since most chips either use I2C EEPROM address 0 or 40000h for the RAS
> table start offset, this leaves with only two macro definitions as opposed
> to five, and removes the redundancy of four.
>
> Cc: Candice Li <candice.li@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 23 +++++++++----------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 1bb92a64f24afc..f63bd31e199c8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -51,12 +51,11 @@
>   * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
>   * address memory in a device or a device on the I2C bus, depending on
>   * the status of pins 1-3. See top of amdgpu_eeprom.c.
> + *
> + * The RAS table lives either at address 0 or address 40000h of EEPROM.
>   */
> -#define EEPROM_I2C_MADDR_VEGA20         0x0
> -#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
> -#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
> -#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
> -#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
> +#define EEPROM_I2C_MADDR_0      0x0
> +#define EEPROM_I2C_MADDR_4      0x40000
>
>  /*
>   * The 2 macros bellow represent the actual size in bytes that
> @@ -135,9 +134,9 @@ static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
>         if (strnstr(atom_ctx->vbios_version,
>                     "D342",
>                     sizeof(atom_ctx->vbios_version)))
> -               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS_D342;
> +               control->i2c_address = EEPROM_I2C_MADDR_0;
>         else
> -               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
> +               control->i2c_address = EEPROM_I2C_MADDR_4;
>
>         return true;
>  }
> @@ -148,7 +147,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 0):
>         case IP_VERSION(13, 0, 10):
> -               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
> +               control->i2c_address = EEPROM_I2C_MADDR_4;
>                 return true;
>         default:
>                 return false;
> @@ -180,18 +179,18 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>
>         switch (adev->asic_type) {
>         case CHIP_VEGA20:
> -               control->i2c_address = EEPROM_I2C_MADDR_VEGA20;
> +               control->i2c_address = EEPROM_I2C_MADDR_0;
>                 break;
>
>         case CHIP_ARCTURUS:
>                 return __get_eeprom_i2c_addr_arct(adev, control);
>
>         case CHIP_SIENNA_CICHLID:
> -               control->i2c_address = EEPROM_I2C_MADDR_SIENNA_CICHLID;
> +               control->i2c_address = EEPROM_I2C_MADDR_0;
>                 break;
>
>         case CHIP_ALDEBARAN:
> -               control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
> +               control->i2c_address = EEPROM_I2C_MADDR_0;
>                 break;
>
>         case CHIP_IP_DISCOVERY:
> @@ -203,7 +202,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
>
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 0):
> -               control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
> +               control->i2c_address = EEPROM_I2C_MADDR_4;
>                 break;
>
>         default:
>
> base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
> prerequisite-patch-id: 6ba70460570b30bf3176058b399934e5e79b229e
> --
> 2.38.1
>
