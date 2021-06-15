Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F845C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBA86128B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA86128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAF4897F0;
	Tue, 15 Jun 2021 18:48:28 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81121897F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 18:48:27 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id d19so15248289oic.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Nu+0ISM0+gEwSzU/ZxJ39ADyyqA27ZPG71hA+NeldM=;
 b=Fv6EtwWuJiP2mnO9YX/YLzj3Kkz1fFeJ4KcaW3flZATTbWJUxjZ1jFvMUnmLVIj7Ad
 eXYCRmfpGvxF83UP7aUbR865tjufCPC8+TingCNH9Fe1NKCzXoljp7Of91Tmi9n1n59x
 /wLmIawajn5pWThyu5Dz0ebKHQk0bWbe3ps4rBSEJF06tiZ97fhhsFXQlXv5/KOxR4YX
 +VGwtzjn+eYTZNK6eo0vde8uikA6iEmYBLNcY2CA+y9b/ehEV8/nHP0ebFw2RH931E6J
 5niuBTrqOgzhDIYaB/WaYGl1gdHTdYNgScL65moOw+97DwAubhpnA07rcHYxJcwhWOb3
 ZJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Nu+0ISM0+gEwSzU/ZxJ39ADyyqA27ZPG71hA+NeldM=;
 b=gHkEeP97L7l4yiw0n3FbXOG5RDx0hXHzDrT1Sj5yF+DMH0dLA1lG9l03G2JmIVl65T
 ojLh0FETrIX5TsSGA9ka4YhcjylIB5g2/p/fJtBL9VG1T65l/rtsKmabKB2Kkmmum38b
 aks2efr19dMa6BH/Ta9kCMqLcTvluMy8hp8GMMifSC3h8/8InKzofCndKLVRtd/iY+d9
 cXYEVGguXZAoRdLS4JC6Jx5tARsOWUVqwpllmDjJW2vRE9d+HO4plOa3X5Y5zNFzfR1i
 tGpfn2C7NtFzM9LDpyiNlCsYDbrdG8sK/VpEmy4DdjS9IZP3rCvXS8beIFf+Ijh8X33a
 sCGA==
X-Gm-Message-State: AOAM532lY1YlYI+t1z/gTIIf1wzEJZYUPTvA4JN2GDinauJXQWx42TjO
 9/tKEGDQnPa/rrgVeGv9pL3XMaSFJwguofGBaPs=
X-Google-Smtp-Source: ABdhPJyMdFfZdAsGVhEQGI1xy6ScIoC7qNQmrlS+cPhxY5V6XZiXBSffCV+XN7sMkMYeiFbM4b9E5cowa8nM1uoquno=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr4038215oic.5.1623782906887; 
 Tue, 15 Jun 2021 11:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210614174632.20818-1-luben.tuikov@amd.com>
 <20210614174632.20818-21-luben.tuikov@amd.com>
In-Reply-To: <20210614174632.20818-21-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jun 2021 14:48:16 -0400
Message-ID: <CADnq5_OggnBqWkX_y5g=MZuiA-CYFREjCXR1wGJdvEx4vS2SFQ@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amdgpu: EEPROM respects I2C quirks
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

On Mon, Jun 14, 2021 at 1:47 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Consult the i2c_adapter.quirks table for
> the maximum read/write data length per bus
> transaction. Do not exceed this transaction
> limit.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 80 +++++++++++++++++-----
>  1 file changed, 64 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 7fdb5bd2fc8bc8..94aeda1c7f8ca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -32,20 +32,9 @@
>
>  #define EEPROM_OFFSET_SIZE 2
>
> -/**
> - * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
> - * @i2c_adap: pointer to the I2C adapter to use
> - * @slave_addr: I2C address of the slave device
> - * @eeprom_addr: EEPROM address from which to read/write
> - * @eeprom_buf: pointer to data buffer to read into/write from
> - * @buf_size: the size of @eeprom_buf
> - * @read: True if reading from the EEPROM, false if writing
> - *
> - * Returns the number of bytes read/written; -errno on error.
> - */
> -int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> -                      u16 slave_addr, u16 eeprom_addr,
> -                      u8 *eeprom_buf, u16 buf_size, bool read)
> +static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> +                               u16 slave_addr, u16 eeprom_addr,
> +                               u8 *eeprom_buf, u16 buf_size, bool read)
>  {
>         u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
>         struct i2c_msg msgs[] = {
> @@ -65,8 +54,8 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>         u16 len;
>
>         r = 0;
> -       for (len = 0; buf_size > 0;
> -            buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
> +       for ( ; buf_size > 0;
> +             buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>                 /* Set the EEPROM address we want to write to/read from.
>                  */
>                 msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
> @@ -120,3 +109,62 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>
>         return r < 0 ? r : eeprom_buf - p;
>  }
> +
> +/**
> + * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
> + * @i2c_adap: pointer to the I2C adapter to use
> + * @slave_addr: I2C address of the slave device
> + * @eeprom_addr: EEPROM address from which to read/write
> + * @eeprom_buf: pointer to data buffer to read into/write from
> + * @buf_size: the size of @eeprom_buf
> + * @read: True if reading from the EEPROM, false if writing
> + *
> + * Returns the number of bytes read/written; -errno on error.
> + */
> +int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> +                      u16 slave_addr, u16 eeprom_addr,
> +                      u8 *eeprom_buf, u16 buf_size, bool read)
> +{
> +       const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
> +       u16 limit;
> +
> +       if (!quirks)
> +               limit = 0;
> +       else if (read)
> +               limit = quirks->max_read_len;
> +       else
> +               limit = quirks->max_write_len;
> +
> +       if (limit == 0) {
> +               return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
> +                                           eeprom_buf, buf_size, read);
> +       } else if (limit <= EEPROM_OFFSET_SIZE) {
> +               dev_err_ratelimited(&i2c_adap->dev,
> +                                   "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
> +                                   eeprom_addr, buf_size,
> +                                   read ? "read" : "write", EEPROM_OFFSET_SIZE);
> +               return -EINVAL;
> +       } else {
> +               u16 ps; /* Partial size */
> +               int res = 0, r;
> +
> +               /* The "limit" includes all data bytes sent/received,
> +                * which would include the EEPROM_OFFSET_SIZE bytes.
> +                * Account for them here.
> +                */
> +               limit -= EEPROM_OFFSET_SIZE;
> +               for ( ; buf_size > 0;
> +                     buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
> +                       ps = min(limit, buf_size);
> +
> +                       r = __amdgpu_eeprom_xfer(i2c_adap,
> +                                                slave_addr, eeprom_addr,
> +                                                eeprom_buf, ps, read);
> +                       if (r < 0)
> +                               return r;
> +                       res += r;
> +               }
> +
> +               return res;
> +       }
> +}
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
