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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C8C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1806D613E7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1806D613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9916EDE0;
	Thu, 10 Jun 2021 20:53:36 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F266EDE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:53:35 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so1099823otl.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QMUvovOplzcZ+kqNC49U9mz56XN3aCFhrwvxumPXDCU=;
 b=QIw5SN7b+gDDbeFmzlsBWc/72f7aOrMaqkJc8Rhkl8fYAOAU2V3xjl2XYewazDKLAy
 fyqWoG/NCfek5iBRH+AuZ+0uIcitYERWFFD0zf6qocWNT1b/XuDD7D/e579n3iX1omEF
 Y/9rEXAzP5AtGieEkp3q0LiLPf6RLjHWHpvxUqV5qCezJPvRBq+4X4YMfJYqv1sy/syF
 LE9snsY/KviTVJvMfXVRjpOyj+/eSXxOlAJLqmyAjO8DR62xib2B9h/cg+kO96bUcAzN
 cBx4Fxw18eFlkrQF/WpDBq6T2LQw9UwdFj8CqlArh42+z3xtG5yEigcnJdSFkt/zZ9a9
 TDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QMUvovOplzcZ+kqNC49U9mz56XN3aCFhrwvxumPXDCU=;
 b=VGTGejf/qCGseKR6oZyfq6vuhOR3fhoP0IdOHYpZBHE8IH5DwjCt0pGIcVkp6dj/Pz
 3Glta7gxbptsHf6IfR+tAlcZdxC8nnCwa2zInqKxfmF79XPizLlTQoUrx7GeFQdwMzzC
 mDg3ifPSzdP0pIr0VUEF+yMqu90fBCqe7vRla18nTgipBA5iaatcLgHgIP/N9fsfl+PG
 azorvT01Id8klTNtlv9Kwncetwu0wj2O2uHXsaXmLg/G+9lu5Ue1y66ldNrIZ+nmf+t+
 JdpYVQtf7yKcKRixrBTL29IU0Tn92inM2Ht4FGNPGOnfyB9ZLv78DE1y7sdzUhMPXz0q
 CCsg==
X-Gm-Message-State: AOAM530m8nsxS3d1l4NYU1FdqmLutMlrym+WemCFCbYkJFlcf+IKlSjZ
 r1+Y98pgJfe+Zg+zVdgC0vXf2fvyribArfs/vO3dVE8UFe0=
X-Google-Smtp-Source: ABdhPJz6JphD76Is+LMSUbLNFtZVMf03HGl5AAHvJVrcv2NlyFYC3gPRwdzXE4lA0JUcfouX5gvLhxQOIOmj0nr2gAY=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr215344otu.311.1623358415175; 
 Thu, 10 Jun 2021 13:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-20-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-20-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:53:24 -0400
Message-ID: <CADnq5_MBYBQJ+bOn_Qieyp_gF2cHzgUxy73GQhdMfJNT-nsGFw@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amdgpu: Fixes to the AMDGPU EEPROM driver
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

On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> * When reading from the EEPROM device, there is no
>   device limitation on the number of bytes
>   read--they're simply sequenced out. Thus, read
>   the whole data requested in one go.
>
> * When writing to the EEPROM device, there is a
>   256-byte page limit to write to before having to
>   generate a STOP on the bus, as well as the
>   address written to mustn't cross over the page
>   boundary (it actually rolls over). Maximize the
>   data written to per bus acquisition.
>
> * Return the number of bytes read/written, or -errno.
>
> * Add kernel doc.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 96 +++++++++++++++-------
>  1 file changed, 68 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index d02ea083a6c69b..7fdb5bd2fc8bc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -24,59 +24,99 @@
>  #include "amdgpu_eeprom.h"
>  #include "amdgpu.h"
>
> -#define EEPROM_OFFSET_LENGTH 2
> +/* AT24CM02 has a 256-byte write page size.
> + */
> +#define EEPROM_PAGE_BITS   8
> +#define EEPROM_PAGE_SIZE   (1U << EEPROM_PAGE_BITS)
> +#define EEPROM_PAGE_MASK   (EEPROM_PAGE_SIZE - 1)
> +
> +#define EEPROM_OFFSET_SIZE 2
>
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
>  int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                        u16 slave_addr, u16 eeprom_addr,
> -                      u8 *eeprom_buf, u16 bytes, bool read)
> +                      u8 *eeprom_buf, u16 buf_size, bool read)
>  {
> -       u8 eeprom_offset_buf[2];
> -       u16 bytes_transferred;
> +       u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
>         struct i2c_msg msgs[] = {
>                 {
>                         .addr = slave_addr,
>                         .flags = 0,
> -                       .len = EEPROM_OFFSET_LENGTH,
> +                       .len = EEPROM_OFFSET_SIZE,
>                         .buf = eeprom_offset_buf,
>                 },
>                 {
>                         .addr = slave_addr,
>                         .flags = read ? I2C_M_RD : 0,
> -                       .len = bytes,
> -                       .buf = eeprom_buf,
>                 },
>         };
> +       const u8 *p = eeprom_buf;
>         int r;
> +       u16 len;
> +
> +       r = 0;
> +       for (len = 0; buf_size > 0;
> +            buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
> +               /* Set the EEPROM address we want to write to/read from.
> +                */
> +               msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
> +               msgs[0].buf[1] = eeprom_addr & 0xff;
>
> -       msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
> -       msgs[0].buf[1] = (eeprom_addr & 0xff);
> +               if (!read) {
> +                       /* Write the maximum amount of data, without
> +                        * crossing the device's page boundary, as per
> +                        * its spec. Partial page writes are allowed,
> +                        * starting at any location within the page,
> +                        * so long as the page boundary isn't crossed
> +                        * over (actually the page pointer rolls
> +                        * over).
> +                        *
> +                        * As per the AT24CM02 EEPROM spec, after
> +                        * writing into a page, the I2C driver MUST
> +                        * terminate the transfer, i.e. in
> +                        * "i2c_transfer()" below, with a STOP
> +                        * condition, so that the self-timed write
> +                        * cycle begins. This is implied for the
> +                        * "i2c_transfer()" abstraction.
> +                        */
> +                       len = min(EEPROM_PAGE_SIZE - (eeprom_addr &
> +                                                     EEPROM_PAGE_MASK),
> +                                 (u32)buf_size);
> +               } else {
> +                       /* Reading from the EEPROM has no limitation
> +                        * on the number of bytes read from the EEPROM
> +                        * device--they are simply sequenced out.
> +                        */
> +                       len = buf_size;
> +               }
> +               msgs[1].len = len;
> +               msgs[1].buf = eeprom_buf;
>
> -       while (msgs[1].len) {
>                 r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
> -               if (r <= 0)
> -                       return r;
> +               if (r < ARRAY_SIZE(msgs))
> +                       break;
>
> -               /* Only for write data */
> -               if (!msgs[1].flags)
> -                       /*
> -                        * According to EEPROM spec there is a MAX of 10 ms required for
> -                        * EEPROM to flush internal RX buffer after STOP was issued at the
> -                        * end of write transaction. During this time the EEPROM will not be
> -                        * responsive to any more commands - so wait a bit more.
> +               if (!read) {
> +                       /* According to the AT24CM02 EEPROM spec the
> +                        * length of the self-writing cycle, tWR, is
> +                        * 10 ms.
>                          *
>                          * TODO Improve to wait for first ACK for slave address after
>                          * internal write cycle done.
>                          */
>                         msleep(10);
> -
> -
> -               bytes_transferred = r - EEPROM_OFFSET_LENGTH;
> -               eeprom_addr += bytes_transferred;
> -               msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
> -               msgs[0].buf[1] = (eeprom_addr & 0xff);
> -               msgs[1].buf += bytes_transferred;
> -               msgs[1].len -= bytes_transferred;
> +               }
>         }
>
> -       return 0;
> +       return r < 0 ? r : eeprom_buf - p;
>  }
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
