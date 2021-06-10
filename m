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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFEC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2336100A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2336100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2F46E4EA;
	Thu, 10 Jun 2021 21:25:35 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB736E4EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:25:33 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 v27-20020a056830091bb02903cd67d40070so1151506ott.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mnN6tFcz2uAlNtY8fkoQEqdDdpUxxnZX/MQhJmjUMYA=;
 b=Jfu+aRxkmW9vo5Wie35jGRx8DKstnlt+awgafu9bqMIzIYwh0tS1Pi2JJALlOaU1Bs
 4u44fF6XZMhsx2Q3be7v3W0tzzllcVFa0KVKSpKDAHNjsLCx+mFFe3XkXaefWi4EpLdt
 AlfLbZ4y1KKx+pVI/JdIRBWVetigDg3ScZsPh+kqrchEz5xs5JVTRB/VNUZHocLHKqVw
 QAfQ43r3lAlnYdQjYK5Li12h9L/a5GJUEb+GJDVmMoCuyvYRhe/gAbMKaH0BqHQH0m4V
 3cQ6MGuqfE0Ztu8Xn9g/h/OUJdqG2rmEi5DY7sWQQQY9qi6g9TGfww81SUfuYIEBqRb3
 JxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mnN6tFcz2uAlNtY8fkoQEqdDdpUxxnZX/MQhJmjUMYA=;
 b=rWlFdUXWZW6EqEMQhjnwNZTCKsawRQxN1i5Uxj+3hq2Bbm5JoZPzjkq5e7aptZ2Plu
 NcGfpwJM8jufcCoPkc6rIXPA5V6xD+ZEVsHIBtHVLW72Ivvpzz0L1esjB1GrQMSFa6PS
 cKnKE0i/3XpmAw3FlvfdweZIXQFFj3YmRaTxMICqgf8mGSqAWToAoYFP2G/WPIm3jrHJ
 VRoxe2OvHsVrc0GOpXmEe5Yoi//PLCIBWzr2lsMNHn2NN+mMzIzrccwXY/ELo28kJkjp
 pKWmULEEtSVHeg1euWv3aP5R2PhKethXHxGdFaaPgOGChQ3mztpKxO9p7wKX1YHJYLP4
 qKqQ==
X-Gm-Message-State: AOAM5303zQEmQiSJWVocgWGft6jVM+b9XzqT14+JVRStg+4VdOuW/WBo
 pNxmXpwBYJ79yxTws7RJACGqAMFA0QhCSkLEwYt++ynX0x4=
X-Google-Smtp-Source: ABdhPJyoQsP5QwbfK7FSr/vOmVO5MQ2EQrk603/k9p1ULYZ2NaVE37fo7YuYaHLhvf4EIEdlFSLcj+DABaWUj7g9968=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr348990otk.132.1623360333117;
 Thu, 10 Jun 2021 14:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-41-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-41-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:25:22 -0400
Message-ID: <CADnq5_N8uuapdsrALPrLQYJ48qR05y1wMxTPn=FB8Z849=v3EA@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amdgpu: Use a single loop
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

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> In smu_v11_0_i2c_transmit() use a single loop to
> transmit bytes, instead of two nested loops.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 72 ++++++++++------------
>  1 file changed, 34 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 7f48ee020bc03e..751ea2517c4380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -243,49 +243,45 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
>         /* Clear status bits */
>         smu_v11_0_i2c_clear_status(control);
>
> -
>         timeout_counter = jiffies + msecs_to_jiffies(20);
>
>         while (numbytes > 0) {
>                 reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
> -               if (REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
> -                       do {
> -                               reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT, data[bytes_sent]);
> -
> -                               /* Final message, final byte, must
> -                                * generate a STOP, to release the
> -                                * bus, i.e. don't hold SCL low.
> -                                */
> -                               if (numbytes == 1 && i2c_flag & I2C_M_STOP)
> -                                       reg = REG_SET_FIELD(reg,
> -                                                           CKSVII2C_IC_DATA_CMD,
> -                                                           STOP, 1);
> -
> -                               if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
> -                                       reg = REG_SET_FIELD(reg,
> -                                                           CKSVII2C_IC_DATA_CMD,
> -                                                           RESTART, 1);
> -
> -                               /* Write */
> -                               reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
> -                               WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
> -
> -                               /* Record that the bytes were transmitted */
> -                               bytes_sent++;
> -                               numbytes--;
> -
> -                               reg = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_STATUS);
> -
> -                       } while (numbytes &&  REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF));
> -               }
> +               if (!REG_GET_FIELD(reg, CKSVII2C_IC_STATUS, TFNF)) {
> +                       /*
> +                        * We waited for too long for the transmission
> +                        * FIFO to become not-full.  Exit the loop
> +                        * with error.
> +                        */
> +                       if (time_after(jiffies, timeout_counter)) {
> +                               ret |= I2C_SW_TIMEOUT;
> +                               goto Err;
> +                       }
> +               } else {
> +                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, DAT,
> +                                           data[bytes_sent]);
>
> -               /*
> -                * We waited too long for the transmission FIFO to become not-full.
> -                * Exit the loop with error.
> -                */
> -               if (time_after(jiffies, timeout_counter)) {
> -                       ret |= I2C_SW_TIMEOUT;
> -                       goto Err;
> +                       /* Final message, final byte, must generate a
> +                        * STOP to release the bus, i.e. don't hold
> +                        * SCL low.
> +                        */
> +                       if (numbytes == 1 && i2c_flag & I2C_M_STOP)
> +                               reg = REG_SET_FIELD(reg,
> +                                                   CKSVII2C_IC_DATA_CMD,
> +                                                   STOP, 1);
> +
> +                       if (bytes_sent == 0 && i2c_flag & I2C_X_RESTART)
> +                               reg = REG_SET_FIELD(reg,
> +                                                   CKSVII2C_IC_DATA_CMD,
> +                                                   RESTART, 1);
> +
> +                       /* Write */
> +                       reg = REG_SET_FIELD(reg, CKSVII2C_IC_DATA_CMD, CMD, 0);
> +                       WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_DATA_CMD, reg);
> +
> +                       /* Record that the bytes were transmitted */
> +                       bytes_sent++;
> +                       numbytes--;
>                 }
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
