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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A3DC48BE8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4C36128B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 18:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4C36128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D33D89C03;
	Tue, 15 Jun 2021 18:47:59 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A54889C03
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 18:47:59 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 5-20020a9d01050000b02903c700c45721so15299655otu.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CBdPPXt79u4KyW4casKIHBTE/W9aK2FcwSSl3e1rEbM=;
 b=dbdTF/78bM9w80QF9JKKC456JB2nkgF4RiLrHDnL20YLEmSrGMlXVWuQadRgNFQPy9
 AxcVNERZC4qLuVMNcIHKWTJMj3YBSwLaIvPIWqb8lGATqKfPKVi6nSlqVOnJwiDlShy/
 hfYEbtuAMo9wk+0kH72fcDxjdq1kZNeN5GWFR532ZKqZMSWHOIg4MvV2XkrHa3g5z/YL
 bVoFuTBbaF51xzgQom1TDqOyQpyG3pQe67AUo949nvY7cedLKtxYc1lomYWmjeHm7JPJ
 ZydJIPdtXNpyV2ITVyL4fc9iMb5PVIgnj+Vk7W+A00+G91Oo1DRbgcbHfOO1vuMf7kS/
 NATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CBdPPXt79u4KyW4casKIHBTE/W9aK2FcwSSl3e1rEbM=;
 b=sp+slLMJkFrCRMFTCaPX6aGvj2nvqQS4y4O7zYQ7ywG7E1zXHil76dujB/lJo3x2pj
 O8w8QhML+AsV4v3gRCHWYcaGVhXQ+daAoTJuAdW82I9AJeOBpQopm8A5rmrxlPmYpZo1
 aueiZgfHDm8qw9xTtnjjI+WplQGt3CG9kahWA5KgUuMAvH6SmiWmrCF99oBXy/dj7Zs3
 17bsSaUZHFrAh3Mjp9K8AM97EL2obSmjKf7hnzkgmOyCzmmT2U9bWzqp2yJzrGB2iaJA
 3BgLPIZyWpfQxcoua42DubsQJw3VnO6CWknICYMZtDP6K2u8fu4ZmTVucAxYrVmwHgdm
 8eag==
X-Gm-Message-State: AOAM533GaY5St7mx+E8Le4l/uboxOdaCpJHrajVqI372/lUJaorWFSJf
 F4ne8IlrKDOlDaVeO+r33K7zE93pgZ9MoC92GCc=
X-Google-Smtp-Source: ABdhPJzVeDthMRYFjgavksyZDHg1/aeN8oj2nIidFyUNR0olkCW6qZvoET4+Rx7vpKDk7QgpkONPvJyypJ5rmkjkqmU=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr511793otu.311.1623782878248; 
 Tue, 15 Jun 2021 11:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210614174632.20818-1-luben.tuikov@amd.com>
 <20210614174632.20818-41-luben.tuikov@amd.com>
In-Reply-To: <20210614174632.20818-41-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jun 2021 14:47:47 -0400
Message-ID: <CADnq5_ODNk4TiUPwCRS6rpnYwVPr3PQ4H_fnC9nf6KsPT7wJ_Q@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amdgpu: Correctly disable the I2C IP block
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 14, 2021 at 1:47 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On long transfers to the EEPROM device,
> i.e. write, it is observed that the driver aborts
> the transfer.
>
> The reason for this is that the driver isn't
> patient enough--the IC_STATUS register's contents
> is 0x27, which is MST_ACTIVITY | TFE | TFNF |
> ACTIVITY. That is, while the transmission FIFO is
> empty, we, the I2C master device, are still
> driving the bus.
>
> Implement the correct procedure to disable
> the block, as described in the DesignWare I2C
> Databook, section 3.8.3 Disabling DW_apb_i2c on
> page 56. Now there are no premature aborts on long
> data transfers.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 80 +++++++++++++++++-----
>  1 file changed, 62 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 751ea2517c4380..7d74d6204d8d0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -54,12 +54,48 @@ static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
>         WREG32_SOC15(SMUIO, 0, mmSMUIO_PWRMGT, reg);
>  }
>
> +/* The T_I2C_POLL_US is defined as follows:
> + *
> + * "Define a timer interval (t_i2c_poll) equal to 10 times the
> + *  signalling period for the highest I2C transfer speed used in the
> + *  system and supported by DW_apb_i2c. For instance, if the highest
> + *  I2C data transfer mode is 400 kb/s, then t_i2c_poll is 25 us."  --
> + * DesignWare DW_apb_i2c Databook, Version 1.21a, section 3.8.3.1,
> + * page 56, with grammar and syntax corrections.
> + *
> + * Vcc for our device is at 1.8V which puts it at 400 kHz,
> + * see Atmel AT24CM02 datasheet, section 8.3 DC Characteristics table, page 14.
> + *
> + * The procedure to disable the IP block is described in section
> + * 3.8.3 Disabling DW_apb_i2c on page 56.
> + */
> +#define I2C_SPEED_MODE_FAST     2
> +#define T_I2C_POLL_US           25
> +#define I2C_MAX_T_POLL_COUNT    1000
>
> -static void smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
> +static int smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
>
>         WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE, enable ? 1 : 0);
> +
> +       if (!enable) {
> +               int ii;
> +
> +               for (ii = I2C_MAX_T_POLL_COUNT; ii > 0; ii--) {
> +                       u32 en_stat = RREG32_SOC15(SMUIO,
> +                                                  0,
> +                                                  mmCKSVII2C_IC_ENABLE_STATUS);
> +                       if (REG_GET_FIELD(en_stat, CKSVII2C_IC_ENABLE_STATUS, IC_EN))
> +                               udelay(T_I2C_POLL_US);
> +                       else
> +                               return I2C_OK;
> +               }
> +
> +               return I2C_ABORT;
> +       }
> +
> +       return I2C_OK;
>  }
>
>  static void smu_v11_0_i2c_clear_status(struct i2c_adapter *control)
> @@ -81,8 +117,13 @@ static void smu_v11_0_i2c_configure(struct i2c_adapter *control)
>         reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_RESTART_EN, 1);
>         reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_10BITADDR_MASTER, 0);
>         reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_10BITADDR_SLAVE, 0);
> -       /* Standard mode */
> -       reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MAX_SPEED_MODE, 2);
> +       /* The values of IC_MAX_SPEED_MODE are,
> +        * 1: standard mode, 0 - 100 Kb/s,
> +        * 2: fast mode, <= 400 Kb/s, or fast mode plus, <= 1000 Kb/s,
> +        * 3: high speed mode, <= 3.4 Mb/s.
> +        */
> +       reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MAX_SPEED_MODE,
> +                           I2C_SPEED_MODE_FAST);
>         reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_MASTER_MODE, 1);
>
>         WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_CON, reg);
> @@ -404,7 +445,6 @@ static void smu_v11_0_i2c_abort(struct i2c_adapter *control)
>         DRM_DEBUG_DRIVER("I2C_Abort() Done.");
>  }
>
> -
>  static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> @@ -416,7 +456,6 @@ static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
>         reg_ic_enable_status = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
>         reg_ic_enable = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
>
> -
>         if ((REG_GET_FIELD(reg_ic_enable, CKSVII2C_IC_ENABLE, ENABLE) == 0) &&
>             (REG_GET_FIELD(reg_ic_enable_status, CKSVII2C_IC_ENABLE_STATUS, IC_EN) == 1)) {
>                 /*
> @@ -446,6 +485,8 @@ static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
>
>  static void smu_v11_0_i2c_init(struct i2c_adapter *control)
>  {
> +       int res;
> +
>         /* Disable clock gating */
>         smu_v11_0_i2c_set_clock_gating(control, false);
>
> @@ -453,7 +494,9 @@ static void smu_v11_0_i2c_init(struct i2c_adapter *control)
>                 DRM_WARN("I2C busy !");
>
>         /* Disable I2C */
> -       smu_v11_0_i2c_enable(control, false);
> +       res = smu_v11_0_i2c_enable(control, false);
> +       if (res != I2C_OK)
> +               smu_v11_0_i2c_abort(control);
>
>         /* Configure I2C to operate as master and in standard mode */
>         smu_v11_0_i2c_configure(control);
> @@ -466,21 +509,22 @@ static void smu_v11_0_i2c_init(struct i2c_adapter *control)
>  static void smu_v11_0_i2c_fini(struct i2c_adapter *control)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(control);
> -       uint32_t reg_ic_enable_status, reg_ic_enable;
> +       u32 status, enable, en_stat;
> +       int res;
>
> -       smu_v11_0_i2c_enable(control, false);
> +       res = smu_v11_0_i2c_enable(control, false);
> +       if (res != I2C_OK) {
> +               status  = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
> +               enable  = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
> +               en_stat = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
>
> -       /* Double check if disabled, else force abort */
> -       reg_ic_enable_status = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE_STATUS);
> -       reg_ic_enable = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE);
> -
> -       if ((REG_GET_FIELD(reg_ic_enable, CKSVII2C_IC_ENABLE, ENABLE) == 0) &&
> -           (REG_GET_FIELD(reg_ic_enable_status,
> -                          CKSVII2C_IC_ENABLE_STATUS, IC_EN) == 1)) {
> -               /*
> -                * Nobody is using I2C engine, but engine remains active because
> -                * someone missed to send STOP
> +               /* Nobody is using the I2C engine, yet it remains
> +                * active, possibly because someone missed to send
> +                * STOP.
>                  */
> +               DRM_DEBUG_DRIVER("Aborting from fini: status:0x%08x "
> +                                "enable:0x%08x enable_stat:0x%08x",
> +                                status, enable, en_stat);
>                 smu_v11_0_i2c_abort(control);
>         }
>
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
