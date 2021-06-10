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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F64EC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66886613D8
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66886613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5D96EDE4;
	Thu, 10 Jun 2021 20:57:45 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F0B6EDE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:57:44 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 x22-20020a4a62160000b0290245cf6b7feeso198821ooc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YflqCpp+RqDCJD7POJjwxRRm0sVLRAMVmmss4CpoDS8=;
 b=CQcosOpQHfLFKH8ONj1h7Rwb+vV1WvNSZgX8QYzbqYUjn9ThTGshxXpycBAcjM6Nyy
 I72aBhQSvO/MCOS8nHacCkEhHc69FeI02ygIVVirOy5LAIpZK9qtNTJZ3/2nnts1YfeE
 3iGaYtIW5vOIBsZbzYvX6w0uKMqAu/K1ppQl3rZF8lMWPatjt45o3hdJR7wm+eBsgWqF
 ZjXDrva3QwkrBHctvQsflziyVjABLTDT4J9n8ZINbyfDzKaRId6gGBTQJkIrQttTtSok
 5PpEIs2jErbFLkN8W8ocdgohSEez9+iNbE72/usjbTTWrovLs4cN9VC8zHJ792z0q/TV
 k31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YflqCpp+RqDCJD7POJjwxRRm0sVLRAMVmmss4CpoDS8=;
 b=eNk9GaizY6hAmgwd9QBKyyMH/idi7UxWndS+nRjm3ZNiJ3U81xBlijOJfjOaNBdGJ7
 jhoMM4BPHQJ6iOrrAWCGyPryiNcICvmfkKeAfA1tEnTKxRkHEKt4v/BCVPG7oF5vrGU+
 wc39mfmgAnx03/wL3Jal75zZprVc2C2vxzYN0n8zlZXVy2UAfWk1jCRdAZ2sElwlJpkQ
 680oFZ7fYtXhFALFldji8kcjkePOBHojfbI+CPVmwVEyq/Kd+ND6CFbhvTpd/okzQA8i
 7uHXFKzRMfdlg3C9HxkCOG2Aw64ImRDqeq2xqnmKk8VDP7DP/R4BrM/j0KxwafgjoEs0
 s8fg==
X-Gm-Message-State: AOAM531r5WVnCLw75IItVgG0WbDylWkprN8isZiEN6ygCjVIAQXiZQPc
 37Zc4RsSEhjtHijHo3rbCAKoG8QNL/ouJGybfdhj/oMuTS4=
X-Google-Smtp-Source: ABdhPJyRzXEZdPZ7hfpYvSAn//Iwq/1d2UTcc3PoGys+WXM29twgBSQ6F2k2nE1zbZp8sYqPmRJuYME8o/3xD/O38IU=
X-Received: by 2002:a4a:a283:: with SMTP id h3mr383776ool.90.1623358664096;
 Thu, 10 Jun 2021 13:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-22-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-22-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:57:33 -0400
Message-ID: <CADnq5_NekaJnWkYZGZBFj0ReAxzm8xRDfqcQRQMoZ8anmZkJBw@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amdgpu: I2C EEPROM full memory addressing
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
> * "eeprom_addr" is now 32-bit wide.
> * Remove "slave_addr" from the I2C EEPROM driver
>   interface. The I2C EEPROM Device Type Identifier
>   is fixed at 1010b, and the rest of the bits
>   of the Device Address Byte/Device Select Code,
>   are memory address bits, where the first three
>   of those bits are the hardware selection bits.
>   All this is now a 19-bit address and passed
>   as "eeprom_addr". This abstracts the I2C bus
>   for EEPROM devices for this I2C EEPROM driver.
>   Now clients only pass the 19-bit EEPROM memory
>   address, to the I2C EEPROM driver, as the 32-bit
>   "eeprom_addr", from which they want to read from
>   or write to.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 88 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h |  4 +-
>  2 files changed, 72 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 94aeda1c7f8ca0..a5a87affedabf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -24,7 +24,7 @@
>  #include "amdgpu_eeprom.h"
>  #include "amdgpu.h"
>
> -/* AT24CM02 has a 256-byte write page size.
> +/* AT24CM02 and M24M02-R have a 256-byte write page size.
>   */
>  #define EEPROM_PAGE_BITS   8
>  #define EEPROM_PAGE_SIZE   (1U << EEPROM_PAGE_BITS)
> @@ -32,20 +32,72 @@
>
>  #define EEPROM_OFFSET_SIZE 2
>
> -static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> -                               u16 slave_addr, u16 eeprom_addr,
> +/* EEPROM memory addresses are 19-bits long, which can
> + * be partitioned into 3, 8, 8 bits, for a total of 19.
> + * The upper 3 bits are sent as part of the 7-bit
> + * "Device Type Identifier"--an I2C concept, which for EEPROM devices
> + * is hard-coded as 1010b, indicating that it is an EEPROM
> + * device--this is the wire format, followed by the upper
> + * 3 bits of the 19-bit address, followed by the direction,
> + * followed by two bytes holding the rest of the 16-bits of
> + * the EEPROM memory address. The format on the wire for EEPROM
> + * devices is: 1010XYZD, A15:A8, A7:A0,
> + * Where D is the direction and sequenced out by the hardware.
> + * Bits XYZ are memory address bits 18, 17 and 16.
> + * These bits are compared to how pins 1-3 of the part are connected,
> + * depending on the size of the part, more on that later.
> + *
> + * Note that of this wire format, a client is in control
> + * of, and needs to specify only XYZ, A15:A8, A7:0, bits,
> + * which is exactly the EEPROM memory address, or offset,
> + * in order to address up to 8 EEPROM devices on the I2C bus.
> + *
> + * For instance, a 2-Mbit I2C EEPROM part, addresses all its bytes,
> + * using an 18-bit address, bit 17 to 0 and thus would use all but one bit of
> + * the 19 bits previously mentioned. The designer would then not connect
> + * pins 1 and 2, and pin 3 usually named "A_2" or "E2", would be connected to
> + * either Vcc or GND. This would allow for up to two 2-Mbit parts on
> + * the same bus, where one would be addressable with bit 18 as 1, and
> + * the other with bit 18 of the address as 0.
> + *
> + * For a 2-Mbit part, bit 18 is usually known as the "Chip Enable" or
> + * "Hardware Address Bit". This bit is compared to the load on pin 3
> + * of the device, described above, and if there is a match, then this
> + * device responds to the command. This way, you can connect two
> + * 2-Mbit EEPROM devices on the same bus, but see one contiguous
> + * memory from 0 to 7FFFFh, where address 0 to 3FFFF is in the device
> + * whose pin 3 is connected to GND, and address 40000 to 7FFFFh is in
> + * the 2nd device, whose pin 3 is connected to Vcc.
> + *
> + * This addressing you encode in the 32-bit "eeprom_addr" below,
> + * namely the 19-bits "XYZ,A15:A0", as a single 19-bit address. For
> + * instance, eeprom_addr = 0x6DA01, is 110_1101_1010_0000_0001, where
> + * XYZ=110b, and A15:A0=DA01h. The XYZ bits become part of the device
> + * address, and the rest of the address bits are sent as the memory
> + * address bytes.
> + *
> + * That is, for an I2C EEPROM driver everything is controlled by
> + * the "eeprom_addr".
> + *
> + * P.S. If you need to write, lock and read the Identification Page,
> + * (M24M02-DR device only, which we do not use), change the "7" to
> + * "0xF" in the macro below, and let the client set bit 20 to 1 in
> + * "eeprom_addr", and set A10 to 0 to write into it, and A10 and A1 to
> + * 1 to lock it permanently.
> + */
> +#define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 7))
> +
> +static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>                                 u8 *eeprom_buf, u16 buf_size, bool read)
>  {
>         u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
>         struct i2c_msg msgs[] = {
>                 {
> -                       .addr = slave_addr,
>                         .flags = 0,
>                         .len = EEPROM_OFFSET_SIZE,
>                         .buf = eeprom_offset_buf,
>                 },
>                 {
> -                       .addr = slave_addr,
>                         .flags = read ? I2C_M_RD : 0,
>                 },
>         };
> @@ -58,6 +110,8 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>               buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>                 /* Set the EEPROM address we want to write to/read from.
>                  */
> +               msgs[0].addr = MAKE_I2C_ADDR(eeprom_addr);
> +               msgs[1].addr = msgs[0].addr;
>                 msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
>                 msgs[0].buf[1] = eeprom_addr & 0xff;
>
> @@ -71,7 +125,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                          * over).
>                          *
>                          * As per the AT24CM02 EEPROM spec, after
> -                        * writing into a page, the I2C driver MUST
> +                        * writing into a page, the I2C driver should
>                          * terminate the transfer, i.e. in
>                          * "i2c_transfer()" below, with a STOP
>                          * condition, so that the self-timed write
> @@ -91,17 +145,20 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                 msgs[1].len = len;
>                 msgs[1].buf = eeprom_buf;
>
> +               /* This constitutes a START-STOP transaction.
> +                */
>                 r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
>                 if (r < ARRAY_SIZE(msgs))
>                         break;
>
>                 if (!read) {
> -                       /* According to the AT24CM02 EEPROM spec the
> -                        * length of the self-writing cycle, tWR, is
> -                        * 10 ms.
> +                       /* According to EEPROM specs the length of the
> +                        * self-writing cycle, tWR (tW), is 10 ms.
>                          *
> -                        * TODO Improve to wait for first ACK for slave address after
> -                        * internal write cycle done.
> +                        * TODO: Use polling on ACK, aka Acknowledge
> +                        * Polling, to minimize waiting for the
> +                        * internal write cycle to complete, as it is
> +                        * usually smaller than tWR (tW).
>                          */
>                         msleep(10);
>                 }
> @@ -113,7 +170,6 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>  /**
>   * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
>   * @i2c_adap: pointer to the I2C adapter to use
> - * @slave_addr: I2C address of the slave device
>   * @eeprom_addr: EEPROM address from which to read/write
>   * @eeprom_buf: pointer to data buffer to read into/write from
>   * @buf_size: the size of @eeprom_buf
> @@ -121,8 +177,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>   *
>   * Returns the number of bytes read/written; -errno on error.
>   */
> -int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> -                      u16 slave_addr, u16 eeprom_addr,
> +int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>                        u8 *eeprom_buf, u16 buf_size, bool read)
>  {
>         const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
> @@ -136,7 +191,7 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                 limit = quirks->max_write_len;
>
>         if (limit == 0) {
> -               return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
> +               return __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
>                                             eeprom_buf, buf_size, read);
>         } else if (limit <= EEPROM_OFFSET_SIZE) {
>                 dev_err_ratelimited(&i2c_adap->dev,
> @@ -157,8 +212,7 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                       buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
>                         ps = min(limit, buf_size);
>
> -                       r = __amdgpu_eeprom_xfer(i2c_adap,
> -                                                slave_addr, eeprom_addr,
> +                       r = __amdgpu_eeprom_xfer(i2c_adap, eeprom_addr,
>                                                  eeprom_buf, ps, read);
>                         if (r < 0)
>                                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> index 9301e5678910ad..417472be2712e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
> @@ -26,9 +26,7 @@
>
>  #include <linux/i2c.h>
>
> -int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
> -                      u16 slave_addr, u16 eeprom_addr,
> +int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>                        u8 *eeprom_buf, u16 bytes, bool read);
>
> -
>  #endif
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
