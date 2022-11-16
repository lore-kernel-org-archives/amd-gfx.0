Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A89CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 20:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D6A10E500;
	Wed, 16 Nov 2022 20:59:08 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAF710E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 20:59:06 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 o140-20020a4a2c92000000b0049effb01130so2687221ooo.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 12:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vIjAmoKpFfkKiKh5yF/uXeNP0im1wPHqjPNG7q7uVZQ=;
 b=oCGHCIRlW9Kp74EB0AoC1SkKXkPTy7OtiSZ7rsMcBT25SyLGd0w1AGqHi9F+kk918i
 IwVbkab28f0bJIYwsopwVhz4W3L6g/80eOS5w14WG1nx7F/ceESUZK1RkIcWLs54Q/d7
 /EC26pWsAPMiDyQDwvSWM8CTR/H7cyaARq09cknb7Tv4ueNo7L9H38JpOLVYcZ+dMU8W
 yxytgEr51l+7G3euDxzVZ02ICI/fUKJZ/ucCViSIF26j1uLy8TDKjTvqrLWal1JU+LRQ
 wPzVNkR/QGJRK+gR9npDpElTP2iRsD7fpR9tChvCckr+L02uDu0c6HUrMOx9mXUwopQa
 1DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vIjAmoKpFfkKiKh5yF/uXeNP0im1wPHqjPNG7q7uVZQ=;
 b=qDhwnuHFjtFeZabbubzWSyBTPGyGelp6h1AUh+hD4yz6xuIl9YDI+acfETEwVOOxNz
 WpGau/VelTLCDYKthxDi26aRgf8sQgSNOyVD7iyDZAS0emtzsQWlSv0pS3c64rtn9Quu
 3BbLfuer8rhps/9qgq2ZiE8Apss374a2gZBtX1+KiE9Qqq6Qmp1cY412tLZ3VRcfCaMu
 oIotbQ6t3z3HOlbApy3Fe0Fk+hQ6ov6OU9x42gwezrCadCETWpiZJ/hK7pjubKFzPsYs
 /R+PoPC8t/eqYxBefTWfz7x2QpuOjKMeil/TTuUwxGUJI+jmPfaF3YRLrzPIOTKx48/q
 mtIg==
X-Gm-Message-State: ANoB5plKU4BzW3B+eVU5cwlqIp4EvcxzEeFSYoU8VklOVoKXri+sNvhy
 zDeFxAtc22NlxIiNYHJGsR6hm4RiGY5jnR+mkhc=
X-Google-Smtp-Source: AA0mqf6LJZY8sAhVXYyCq3T6ilKQq6WFpV+OtxmNRDZCzKD9NvPQFXQy93+hkmfDW2URVJF5qL8rEK0LvKCxs4s4lbI=
X-Received: by 2002:a4a:cf08:0:b0:498:ce46:9fb1 with SMTP id
 l8-20020a4acf08000000b00498ce469fb1mr10660722oos.97.1668632345384; Wed, 16
 Nov 2022 12:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20221116194838.15315-1-luben.tuikov@amd.com>
 <20221116194838.15315-4-luben.tuikov@amd.com>
In-Reply-To: <20221116194838.15315-4-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Nov 2022 15:58:53 -0500
Message-ID: <CADnq5_PoKyEHKLWXjWtgB-LeAUocRGYKtWJmv7OhqzJeWtA95A@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Read IPMI data for product information
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 16, 2022 at 2:49 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Read and interpret IPMI data to get the product name, product model, and
> product serial number.

Patches 1,2,4 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
for patch 3:
It's not clear from the commit message what this change is doing.  Is
this just a rewrite/cleanup of the existing FRU parsing or is there a
bug fix in here related to the rest of this series?

Alex

>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Tested-by: Kent Russell <kent.russell@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 183 ++++++++----------
>  1 file changed, 85 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 9b2ff386b7c4f8..2c38ac7bc643d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -94,39 +94,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
>         }
>  }
>
> -static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
> -                                 unsigned char *buf, size_t buf_size)
> -{
> -       int ret;
> -       u8 size;
> -
> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
> -       if (ret < 1) {
> -               DRM_WARN("FRU: Failed to get size field");
> -               return ret;
> -       }
> -
> -       /* The size returned by the i2c requires subtraction of 0xC0 since the
> -        * size apparently always reports as 0xC0+actual size.
> -        */
> -       size = buf[0] & 0x3F;
> -       size = min_t(size_t, size, buf_size);
> -
> -       ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
> -                                buf, size);
> -       if (ret < 1) {
> -               DRM_WARN("FRU: Failed to get data field");
> -               return ret;
> -       }
> -
> -       return size;
> -}
> -
>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  {
> -       unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
> -       u32 addrptr, fru_addr;
> +       unsigned char buf[8], *pia;
> +       u32 addr, fru_addr;
>         int size, len;
> +       u8 csum;
>
>         if (!is_fru_eeprom_supported(adev, &fru_addr))
>                 return 0;
> @@ -137,88 +110,102 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>                 return -ENODEV;
>         }
>
> -       /* There's a lot of repetition here. This is due to the FRU having
> -        * variable-length fields. To get the information, we have to find the
> -        * size of each field, and then keep reading along and reading along
> -        * until we get all of the data that we want. We use addrptr to track
> -        * the address as we go
> -        */
> -
> -       /* The first fields are all of size 1-byte, from 0-7 are offsets that
> -        * contain information that isn't useful to us.
> -        * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
> -        * and the language field, so just start from 0xb, manufacturer size
> -        */
> -       addrptr = fru_addr + 0xb;
> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
> -       if (size < 1) {
> -               DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
> -               return -EINVAL;
> +       /* Read the IPMI Common header */
> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr, buf,
> +                                sizeof(buf));
> +       if (len != 8) {
> +               DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
> +               return len < 0 ? len : -EIO;
>         }
>
> -       /* Increment the addrptr by the size of the field, and 1 due to the
> -        * size field being 1 byte. This pattern continues below.
> -        */
> -       addrptr += size + 1;
> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
> -       if (size < 1) {
> -               DRM_ERROR("Failed to read FRU product name, ret:%d", size);
> -               return -EINVAL;
> +       if (buf[0] != 1) {
> +               DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0]);
> +               return -EIO;
>         }
>
> -       len = size;
> -       if (len >= AMDGPU_PRODUCT_NAME_LEN) {
> -               DRM_WARN("FRU Product Name is larger than %d characters. This is likely a mistake",
> -                               AMDGPU_PRODUCT_NAME_LEN);
> -               len = AMDGPU_PRODUCT_NAME_LEN - 1;
> -       }
> -       memcpy(adev->product_name, buf, len);
> -       adev->product_name[len] = '\0';
> -
> -       addrptr += size + 1;
> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
> -       if (size < 1) {
> -               DRM_ERROR("Failed to read FRU product number, ret:%d", size);
> -               return -EINVAL;
> +       for (csum = 0; len > 0; len--)
> +               csum += buf[len - 1];
> +       if (csum) {
> +               DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x", csum);
> +               return -EIO;
>         }
>
> -       len = size;
> -       /* Product number should only be 16 characters. Any more,
> -        * and something could be wrong. Cap it at 16 to be safe
> -        */
> -       if (len >= sizeof(adev->product_number)) {
> -               DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
> -               len = sizeof(adev->product_number) - 1;
> -       }
> -       memcpy(adev->product_number, buf, len);
> -       adev->product_number[len] = '\0';
> +       /* Get the offset to the Product Info Area (PIA). */
> +       addr = buf[4] * 8;
> +       if (!addr)
> +               return 0;
>
> -       addrptr += size + 1;
> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
> +       /* Get the absolute address to the PIA. */
> +       addr += fru_addr;
>
> -       if (size < 1) {
> -               DRM_ERROR("Failed to read FRU product version, ret:%d", size);
> -               return -EINVAL;
> +       /* Read the header of the PIA. */
> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf, 3);
> +       if (len != 3) {
> +               DRM_ERROR("Couldn't read the Product Info Area header: %d", len);
> +               return len < 0 ? len : -EIO;
>         }
>
> -       addrptr += size + 1;
> -       size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
> +       if (buf[0] != 1) {
> +               DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf[0]);
> +               return -EIO;
> +       }
>
> -       if (size < 1) {
> -               DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
> -               return -EINVAL;
> +       size = buf[1] * 8;
> +       pia = kzalloc(size, GFP_KERNEL);
> +       if (!pia)
> +               return -ENOMEM;
> +
> +       /* Read the whole PIA. */
> +       len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
> +       if (len != size) {
> +               kfree(pia);
> +               DRM_ERROR("Couldn't read the Product Info Area: %d", len);
> +               return len < 0 ? len : -EIO;
>         }
>
> -       len = size;
> -       /* Serial number should only be 16 characters. Any more,
> -        * and something could be wrong. Cap it at 16 to be safe
> -        */
> -       if (len >= sizeof(adev->serial)) {
> -               DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
> -               len = sizeof(adev->serial) - 1;
> +       for (csum = 0; size > 0; size--)
> +               csum += pia[size - 1];
> +       if (csum) {
> +               DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
> +               return -EIO;
>         }
> -       memcpy(adev->serial, buf, len);
> -       adev->serial[len] = '\0';
>
> +       /* Now extract useful information from the PIA.
> +        *
> +        * Skip the Manufacturer Name at [3] and go directly to
> +        * the Product Name field.
> +        */
> +       addr = 3 + 1 + (pia[3] & 0x3F);
> +       if (addr + 1 >= len)
> +               goto Out;
> +       memcpy(adev->product_name, pia + addr + 1,
> +              min_t(size_t,
> +                    sizeof(adev->product_name),
> +                    pia[addr] & 0x3F));
> +       adev->product_name[sizeof(adev->product_name) - 1] = '\0';
> +
> +       /* Go to the Product Part/Model Number field. */
> +       addr += 1 + (pia[addr] & 0x3F);
> +       if (addr + 1 >= len)
> +               goto Out;
> +       memcpy(adev->product_number, pia + addr + 1,
> +              min_t(size_t,
> +                    sizeof(adev->product_number),
> +                    pia[addr] & 0x3F));
> +       adev->product_number[sizeof(adev->product_number) - 1] = '\0';
> +
> +       /* Go to the Product Version field. */
> +       addr += 1 + (pia[addr] & 0x3F);
> +
> +       /* Go to the Product Serial Number field. */
> +       addr += 1 + (pia[addr] & 0x3F);
> +       if (addr + 1 >= len)
> +               goto Out;
> +       memcpy(adev->serial, pia + addr + 1, min_t(size_t,
> +                                                  sizeof(adev->serial),
> +                                                  pia[addr] & 0x3F));
> +       adev->serial[sizeof(adev->serial) - 1] = '\0';
> +Out:
> +       kfree(pia);
>         return 0;
>  }
> --
> 2.38.1
>
