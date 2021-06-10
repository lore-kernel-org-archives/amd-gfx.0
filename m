Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B450C48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D17C613E7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D17C613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46326EDF7;
	Thu, 10 Jun 2021 21:10:08 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB266EDF7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:10:08 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so1144925otl.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fzDcVQVkCFZ3/QHtqdfZwnEizHbe3e5hI7UGfuUIUT4=;
 b=pkU2zzzoqrB64jYxJbW1E2gwoE+xzS9NrGmT8meC2mUXmJtgBeiUS+yNb2tYR5dz6g
 TnrzpyRycVtdOo4okC9bRBkDYh9cOfigCWaNOLf2W9RTg4pOJyHfeGflHVNMc9OYAWiD
 r+Edi2YMvZsBQusfciOMrpNZ2jiKgW0cQW+U3qHI6n7PKQyPX66waH72DUnj8pXUj+dq
 7q/MH2c33mPWzxwSS3fvDqECz7bObB5aIDPxPwk33sJ9dockrdHy+hkA5phfKmFbfFaa
 4soHgj5Y6PV1zeF4g9EKTfuTYunmU+xWat7gbnhULga7zjs5h4T78UJ9h6J4WFHklvc7
 ukRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fzDcVQVkCFZ3/QHtqdfZwnEizHbe3e5hI7UGfuUIUT4=;
 b=Sy67aoPEfp/a8ufqi5B+4ifiglv9FzTry+SUi/EqzXx4aA8b59cVfmTxHjBPKHjaMp
 2ccRzwH11UJRrnFMqMG1Cf/xyhesMMWhWXd12FVMtliILcHiPSw8dYFUxWq1iHxkAX3A
 z97AriuUukewTgdZZJQ8XC1uSbaMg9cBdukhvqXjWcHvMPB5qhMu8HTj+OdCDYVetDJB
 90a1Xg1/P9VZFqS0xI4SCLFjzvUPI1E0oUDGFzUDrdSz3Lj6OI6u8qXWYw6nDsbY0vXR
 gqh/zcBZiWBxXxZfwXHgoHekyjzpo9pNhk+4SJJxb8W/qX6+KwzYOR2lldJ1l5Ti9QOH
 AFMA==
X-Gm-Message-State: AOAM533xE/H0bFIKELRc3qay16xHSxdNktR7kqB3+PFMrAD/vZvUBJGq
 7hXouegS+KV2ul39ntqI8MdS6nWbrVYDaBVNkdY=
X-Google-Smtp-Source: ABdhPJy0hYth7dEP+GqvVN+IGPoiOXTiNjFFBGtPnh4oIMisthFsoQf0xGMIspQuj3eyGYqz6bguKVyhuDYlQOiV/Fs=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr267276otr.23.1623359407764; 
 Thu, 10 Jun 2021 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-32-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-32-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:09:56 -0400
Message-ID: <CADnq5_PHKomZNbHdHAwFreggJ29=abv97iFfRWEwc_prnePg7A@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amdgpu: Fix width of I2C address
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> The I2C address is kept as a 16-bit quantity in
> the kernel. The I2C_TAR::I2C_TAR field is 10-bit
> wide.
>
> Fix the width of the I2C address for Vega20 from 8
> bits to 16 bits to accommodate the full spectrum
> of I2C address space.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index e403ba556e5590..65035256756679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -111,12 +111,15 @@ static void smu_v11_0_i2c_set_clock(struct i2c_adapter *control)
>         WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_SDA_HOLD, 20);
>  }
>
> -static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, uint8_t address)
> +static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, u16 address)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>
> -       /* We take 7-bit addresses raw */
> -       WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, (address & 0xFF));
> +       /* The IC_TAR::IC_TAR field is 10-bits wide.
> +        * It takes a 7-bit or 10-bit addresses as an address,
> +        * i.e. no read/write bit--no wire format, just the address.
> +        */
> +       WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TAR, address & 0x3FF);
>  }
>
>  static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
> @@ -215,8 +218,8 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
>   * Returns 0 on success or error.
>   */
>  static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
> -                                 uint8_t address, uint8_t *data,
> -                                 uint32_t numbytes, uint32_t i2c_flag)
> +                                      u16 address, u8 *data,
> +                                      u32 numbytes, u32 i2c_flag)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         uint32_t bytes_sent, reg, ret = 0;
> @@ -225,7 +228,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>         bytes_sent = 0;
>
>         DRM_DEBUG_DRIVER("I2C_Transmit(), address = %x, bytes = %d , data: ",
> -                (uint16_t)address, numbytes);
> +                        address, numbytes);
>
>         if (drm_debug_enabled(DRM_UT_DRIVER)) {
>                 print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
> @@ -318,8 +321,8 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>   * Returns 0 on success or error.
>   */
>  static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
> -                                uint8_t address, uint8_t *data,
> -                                uint32_t numbytes, uint8_t i2c_flag)
> +                                     u16 address, u8 *data,
> +                                     u32 numbytes, u32 i2c_flag)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>         uint32_t bytes_received, ret = I2C_OK;
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
