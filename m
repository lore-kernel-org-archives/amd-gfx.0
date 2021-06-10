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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124BC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AE7613FF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AE7613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3DF6EDDA;
	Thu, 10 Jun 2021 20:43:46 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85436EDDA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:43:45 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 j11-20020a9d738b0000b02903ea3c02ded8so1019921otk.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WhScQd6v4SmdvoDHUwZkP5V1sv6e/Ubr84UMpvlJUv4=;
 b=hGMzvexQGy3saAx7z+nErB3w1LuiHZTXJesu3EmldfwcWKmSqV/DUKUHl+yyEO6vvm
 Y+9dlG+x5COsA1cFZVr0GZ/w1S9pT1Nz3O6PE4d1Cm8ThAUiNOQG9T6XjFgHbns2MbKF
 f0XczxQugw7KLGuuS2DAbFY57bEUtZ3X+ekHjJjeiJFUVIAvZcmC/IwYEM0mi5btQwFQ
 EKgKKJ4YQWH6mB/qOtZGZkL3jPQd2dZMaow8MdSIbmo6x+56LlC0XyP8NAFMZXMBW6Ce
 wApG4GG0lc1drAw3XyrMxkuhWF9S88gdMlHZXEn5aVjwrMsexAAbCrsOV3ymVSg0BX6+
 JPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WhScQd6v4SmdvoDHUwZkP5V1sv6e/Ubr84UMpvlJUv4=;
 b=Isq5CMk26aMBudNUsO+G0pPHQWHa1Z1FtXJwitiuCQzfhw52oYgl735N17M6iTA/P8
 C53GVUA/8Matrspk7/i+YkIa1BVq9xIgRbguyzDIO7XQDL4t9qkT6eKndrPE3W4yjZ5n
 d1HxEk+esLiDp3ff88eJxnRiFBSoTa94642db5i6y5K0cccl1wHDYbAuoWYAgT6TExNL
 lSZVgjytpFpZtt0d+ALODlnm6EF5XH/jelyixwsHp9d0NoTE11LE+ALbLHmGYX8BTr7L
 HS61siCl6OA0HytQgi7Lc96OMpD9RceIS4VhWqrhgCf87PRAUZ7dqiNmpgJsbeEIBA3D
 pC2Q==
X-Gm-Message-State: AOAM530U2uY/cjLRl1BX+ofzFKyMnwsxNAINPcijZdYUzBWL8kJ883ot
 0A3/7GWcU4jPP7tLSV1Xt89nFZYWrurUJ236nXs4WQNSo+Y=
X-Google-Smtp-Source: ABdhPJwaHl9/g2dYEhX+mVmimheFGRu7PIVS3P4Tn3WsI6C4aWbz1q+wAyfwY9YCHXDjmyKLukJ0kfoL86sOczmaJB4=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr198984otr.23.1623357825033; 
 Thu, 10 Jun 2021 13:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-19-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-19-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:43:34 -0400
Message-ID: <CADnq5_Nc1iqpt1V6VvqU95=VmxSVFUkju_4JEw8WBvsZF2wFjw@mail.gmail.com>
Subject: Re: [PATCH 18/40] drm/amdgpu: Fix Vega20 I2C to be agnostic (v2)
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
> Teach Vega20 I2C to be agnostic. Allow addressing
> different devices while the master holds the bus.
> Set STOP as per the controller's specification.
>
> v2: Qualify generating ReSTART before the 1st byte
>     of the message, when set by the caller, as
>     those functions are separated, as caught by
>     Andrey G.
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c |   4 +-
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 105 +++++++++++++--------
>  2 files changed, 69 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index fe0e9b0c4d5a38..d02ea083a6c69b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -41,10 +41,10 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>                 },
>                 {
>                         .addr = slave_addr,
> -                       .flags = read ? I2C_M_RD: 0,
> +                       .flags = read ? I2C_M_RD : 0,
>                         .len = bytes,
>                         .buf = eeprom_buf,
> -               }
> +               },
>         };
>         int r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 5a90d9351b22eb..b8d6d308fb06a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -41,9 +41,7 @@
>  #define I2C_SW_TIMEOUT        8
>  #define I2C_ABORT             0x10
>
> -/* I2C transaction flags */
> -#define I2C_NO_STOP    1
> -#define I2C_RESTART    2
> +#define I2C_X_RESTART         BIT(31)
>
>  #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>
> @@ -205,9 +203,6 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
>         return ret;
>  }
>
> -
> -
> -
>  /**
>   * smu_v11_0_i2c_transmit - Send a block of data over the I2C bus to a slave device.
>   *
> @@ -252,21 +247,22 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>                 reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
>                 if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
>                         do {
> -                               reg = 0;
> -                               /*
> -                                * Prepare transaction, no need to set RESTART. I2C engine will send
> -                                * START as soon as it sees data in TXFIFO
> -                                */
> -                               if (bytes_sent == 0)
> -                                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
> -                                                           (i2c_flag & I2C_RESTART) ? 1 : 0);
>                                 reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
>
> -                               /* determine if we need to send STOP bit or not */
> -                               if (numbytes == 1)
> -                                       /* Final transaction, so send stop unless I2C_NO_STOP */
> -                                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
> -                                                           (i2c_flag & I2C_NO_STOP) ? 0 : 1);
> +                               /* Final message, final byte, must
> +                                * generate a STOP, to release the
> +                                * bus, i.e. don't hold SCL low.
> +                                */
> +                               if (numbytes == 1 && i2c_flag & I2C_M_STOP)
> +                                       reg = REG_SET_FIELD(reg,
> +                                                           CKSVII2C_IC_DATA_CMD,
> +                                                           STOP, 1);
> +
> +                               if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
> +                                       reg = REG_SET_FIELD(reg,
> +                                                           CKSVII2C_IC_DATA_CMD,
> +                                                           RESTART, 1);
> +
>                                 /* Write */
>                                 reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
>                                 WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
> @@ -341,23 +337,21 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
>
>                 smu_v11_0_i2c_clear_status(control);
>
> -
>                 /* Prepare transaction */
> -
> -               /* Each time we disable I2C, so this is not a restart */
> -               if (bytes_received == 0)
> -                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, RESTART,
> -                                           (i2c_flag & I2C_RESTART) ? 1 : 0);
> -
>                 reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, 0);
>                 /* Read */
>                 reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 1);
>
> -               /* Transmitting last byte */
> -               if (numbytes == 1)
> -                       /* Final transaction, so send stop if requested */
> -                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, STOP,
> -                                           (i2c_flag & I2C_NO_STOP) ? 0 : 1);
> +               /* Final message, final byte, must generate a STOP
> +                * to release the bus, i.e. don't hold SCL low.
> +                */
> +               if (numbytes == 1 && i2c_flag & I2C_M_STOP)
> +                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
> +                                           STOP, 1);
> +
> +               if (bytes_received == 0 && i2c_flag & I2C_X_RESTART)
> +                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD,
> +                                           RESTART, 1);
>
>                 WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
>
> @@ -591,23 +585,59 @@ static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
>  };
>
>  static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                             struct i2c_msg *msgs, int num)
> +                             struct i2c_msg *msg, int num)
>  {
>         int i, ret;
> +       u16 addr, dir;
>
>         smu_v11_0_i2c_init(i2c_adap);
>
> +       /* From the client's point of view, this sequence of
> +        * messages-- the array i2c_msg *msg, is a single transaction
> +        * on the bus, starting with START and ending with STOP.
> +        *
> +        * The client is welcome to send any sequence of messages in
> +        * this array, as processing under this function here is
> +        * striving to be agnostic.
> +        *
> +        * Record the first address and direction we see. If either
> +        * changes for a subsequent message, generate ReSTART. The
> +        * DW_apb_i2c databook, v1.21a, specifies that ReSTART is
> +        * generated when the direction changes, with the default IP
> +        * block parameter settings, but it doesn't specify if ReSTART
> +        * is generated when the address changes (possibly...). We
> +        * don't rely on the default IP block parameter settings as
> +        * the block is shared and they may change.
> +        */
> +       if (num > 0) {
> +               addr = msg[0].addr;
> +               dir  = msg[0].flags & I2C_M_RD;
> +       }
> +
>         for (i = 0; i < num; i++) {
> -               uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
> -                                   (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
> +               u32 i2c_flag = 0;
>
> -               if (msgs[i].flags & I2C_M_RD)
> +               if (msg[i].addr != addr || (msg[i].flags ^ dir) & I2C_M_RD) {
> +                       addr = msg[i].addr;
> +                       dir  = msg[i].flags & I2C_M_RD;
> +                       i2c_flag |= I2C_X_RESTART;
> +               }
> +
> +               if (i == num - 1) {
> +                       /* Set the STOP bit on the last message, so
> +                        * that the IP block generates a STOP after
> +                        * the last byte of the message.
> +                        */
> +                       i2c_flag |= I2C_M_STOP;
> +               }
> +
> +               if (msg[i].flags & I2C_M_RD)
>                         ret = smu_v11_0_i2c_read_data(i2c_adap,
> -                                                     msgs + i,
> +                                                     msg + i,
>                                                       i2c_flag);
>                 else
>                         ret = smu_v11_0_i2c_write_data(i2c_adap,
> -                                                      msgs + i,
> +                                                      msg + i,
>                                                        i2c_flag);
>
>                 if (ret != I2C_OK) {
> @@ -625,7 +655,6 @@ static u32 smu_v11_0_i2c_func(struct i2c_adapter *adap)
>         return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>
> -
>  static const struct i2c_algorithm smu_v11_0_i2c_algo = {
>         .master_xfer = smu_v11_0_i2c_xfer,
>         .functionality = smu_v11_0_i2c_func,
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
