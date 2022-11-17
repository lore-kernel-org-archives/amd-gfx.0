Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9933AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 03:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC0F10E524;
	Thu, 17 Nov 2022 03:37:49 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C0210E524
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 03:37:46 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-12c8312131fso823501fac.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ARKmibeOSIoq6in/JgXa9LUJnWNoGGxOOUZECJ1VC4=;
 b=JmCG2Il7iYixPOHZt4t59UNYofXQdVnCKk2Wlv8mqcWx2uxRMMWuogMZE3U7Ie1S1q
 Xz9NVGYL7N6QDfjWz23zlcvH7GYxl/ijLNEWH4RYwCAxNblnJnVBsE3q6fCETmEDj15h
 p7YbJChzss9WCqLwrnD7a7NKHRVXFTkZmoXp5+ZQ3YNatqyBF2LKL5QrT4LQVGQi8Iy+
 uxIVODBx2Hfcp7VqwWtmxpgrXSPUeE5QLnqGQ9R4v8YUvsDjDOJfMBStvRpcwCqlOXbY
 rV7tuErSP7m2jaVqtV3D3oU0YXTSOIi/8JJSeAJAXjbV3YiwcZwGmntYonnktBH2sg+N
 IErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ARKmibeOSIoq6in/JgXa9LUJnWNoGGxOOUZECJ1VC4=;
 b=n2fgazPqEGG/ctpvmpV53JtWfiTGu4WE7kl1S86j41fMEfGiLLys4rAAZgPce+CJEZ
 jpKsHF2PY5HJVTzCz2fVNVazP6Y6uPRovFmgVQ9nCYMWrXdbbCspZROZJT+Bp2g8GL2a
 HSXGd3FExEBIHKRKhXsiXI4BBL75K2JpAhrLzmw1Q35FUJGw3qp69GUDQ+Dsv0g72PKd
 QuSTETJotgtgRnQQfgt7i20d9qvE1utvo0yVYsyd0RMbYrnEHxRm17jNwuZCAFLpT2Zt
 PJ+w5/ZkuteRksxM8Mu/0Z8gySkbRDTdNZmXNJULN8luDvCwYyirVKoPkuSSnfPpm0kG
 wHrw==
X-Gm-Message-State: ANoB5pnMrb2XdRO2xHbqVJLgSpP+VzajnVC3oMhEzGngSXhycK9x3vy9
 6nfxN57kIgVDffmuTdXvdcxGlR96z3/QWpf1jZU=
X-Google-Smtp-Source: AA0mqf56ocP7sX1t01HOg1p4Rrc9bLCOnwpaLoNmy/mISA6jpmZLy0hlF6mLmwB5MIrZcdev4ELnbM1nvJDL/3iY+1A=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr3539927oab.46.1668656265797; Wed, 16
 Nov 2022 19:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20221117012406.33268-1-luben.tuikov@amd.com>
 <20221117012406.33268-4-luben.tuikov@amd.com>
In-Reply-To: <20221117012406.33268-4-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Nov 2022 22:37:34 -0500
Message-ID: <CADnq5_O++udgD+N6XeuU5azzjWfQTy=_D3j2fRXH-oafMhwVGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Interpret IPMI data for product
 information (v2)
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

On Wed, Nov 16, 2022 at 8:25 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Don't assume FRU MCU memory locations for the FRU data fields, or their sizes,
> instead reading and interpret the IPMI data, as stipulated in the IPMI spec
> version 1.0 rev 1.2.
>
> Extract the Product Name, Product Part/Model Number, and the Product Serial
> Number by interpreting the IPMI data.
>
> Check the checksums of the stored IPMI data to make sure we don't read and
> give corrupted data back the the user.
>
> Eliminate small I2C reads, and instead read the whole Product Info Area in one
> go, and then extract the information we're seeking from it.
>
> Eliminates a whole function, making this file smaller.
>
> v2: Clarify changes in the commit message.

Thanks for clarifying, Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Tested-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Kent Russell <kent.russell@amd.com>
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
