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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF0AC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F23A6139A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F23A6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A9D8800A;
	Thu, 10 Jun 2021 20:18:39 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328348800A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:18:38 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w127so3435791oig.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iiEpJlqaVQGXwJ/fpfYOiwVbdqtBAotWJNCNmzcIvQ8=;
 b=V32q0J+et6QZ/0YJCg3D62T8+vhRNHC6DxnCaNl5SW9oP2N+mlApJpruUn/wAQvCqi
 bFHGJGfeP0CHsZoDof5P/2fMmXkZ7B2tnTmfpBQ8C+D915C7a8LSAmky/ptAlDvITVRs
 gPfPFjYag2KxXhsSkko9JHyg4m1/6ftmj2xyzQ0xMRWrWFPFJN992Wg9VZDzKJGayx4N
 Q3aMGMqNKTIQGmbetoz8oH0vmqjBOCU18ST/QDy8lj618hTZjbP9ZgPF+LLGd95qYAFw
 1UqSNCnOtZRLEPEGywltcT3t+CtXmcYRWDlGAShyanQ0YCClh+P/sx5pD1993O+qHKcT
 iD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iiEpJlqaVQGXwJ/fpfYOiwVbdqtBAotWJNCNmzcIvQ8=;
 b=InJPhn2BoQOcnjCw+Ti9CCSbMQAW1H0qCPQ/TXPGJsp6HO3qY2aZem5iTNXZlCfuwR
 LoKMZKUl1Vf+atfxr24kI0W8ZANL4b7HYitkE9SGbRBwkyPVIBNsuhTDs9CNXE+Da6MB
 +pRRD0Qnp97IoQmxJitIPNt+CEhIa5Or/Urq+ztsPIR/uNSY0DgX2a4V1ttRtv5Klw7+
 9XgKtM+kFYHsc00zRsCK6sNmLRoKIgbFnd338jI1efxiAErSLIvSpO+m/sgSh7SRPvrT
 h6JsE3TbKwgwqzo2ewNvW3Zwz9T2tP/qBMFqx6iB0rCfaEucu6KP51hRhll90QG/TzWX
 vdEw==
X-Gm-Message-State: AOAM530uvz2rinhFX1yyAJto5NqI1XWDOCVcUqh8R9ymdluvX7H785I9
 uMhPdrYKksIUo0FPmaMMrUfAuws+gfnzqI0ca+w=
X-Google-Smtp-Source: ABdhPJxIESSzkVjSosMJzuXyD7rZJRxyVsXabGrlIoIffrSnoP6FS5D97LRyaJy2O8iqTA7hYa51z/KLL+eOwVvtf3U=
X-Received: by 2002:a05:6808:14c9:: with SMTP id
 f9mr177669oiw.120.1623356317350; 
 Thu, 10 Jun 2021 13:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-14-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-14-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:18:26 -0400
Message-ID: <CADnq5_O2XmSkq1qgRv1qjR6c-Ui_qQUdE5BRsJo45oFt71Fiqw@mail.gmail.com>
Subject: Re: [PATCH 13/40] dmr/amdgpu: Add RESTART handling also to
 smu_v11_0_i2c (VG20)
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
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
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Also generilize the code to accept and translate to
> HW bits any I2C relvent flags both for read and write.
>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index 3193d566f4f87e..5a90d9351b22eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -530,13 +530,11 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
>  /***************************** I2C GLUE ****************************/
>
>  static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
> -                                       struct i2c_msg *msg)
> +                                       struct i2c_msg *msg, uint32_t i2c_flag)
>  {
> -       uint32_t  ret = 0;
> +       uint32_t  ret;
>
> -       /* Now read data starting with that address */
> -       ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len,
> -                                   I2C_RESTART);
> +       ret = smu_v11_0_i2c_receive(control, msg->addr, msg->buf, msg->len, i2c_flag);
>
>         if (ret != I2C_OK)
>                 DRM_ERROR("ReadData() - I2C error occurred :%x", ret);
> @@ -545,12 +543,11 @@ static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
>  }
>
>  static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
> -                                       struct i2c_msg *msg)
> +                                       struct i2c_msg *msg, uint32_t i2c_flag)
>  {
>         uint32_t  ret;
>
> -       /* Send I2C_NO_STOP unless requested to stop. */
> -       ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, ((msg->flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
> +       ret = smu_v11_0_i2c_transmit(control, msg->addr, msg->buf, msg->len, i2c_flag);
>
>         if (ret != I2C_OK)
>                 DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
> @@ -601,12 +598,17 @@ static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
>         smu_v11_0_i2c_init(i2c_adap);
>
>         for (i = 0; i < num; i++) {
> +               uint32_t i2c_flag = ((msgs[i].flags & I2C_M_NOSTART) ? 0 : I2C_RESTART) ||
> +                                   (((msgs[i].flags & I2C_M_STOP) ? 0 : I2C_NO_STOP));
> +
>                 if (msgs[i].flags & I2C_M_RD)
>                         ret = smu_v11_0_i2c_read_data(i2c_adap,
> -                                                     msgs + i);
> +                                                     msgs + i,
> +                                                     i2c_flag);
>                 else
>                         ret = smu_v11_0_i2c_write_data(i2c_adap,
> -                                                      msgs + i);
> +                                                      msgs + i,
> +                                                      i2c_flag);
>
>                 if (ret != I2C_OK) {
>                         num = -EIO;
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
