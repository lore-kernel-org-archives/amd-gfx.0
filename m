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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF2C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF19C613B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 20:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF19C613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561666EDD3;
	Thu, 10 Jun 2021 20:25:18 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8836A6EDD6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 20:25:17 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 n17-20020a4ae1d10000b029024a49ea822bso188858oot.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AMA9hCnxGrbpSsVjVpfVEXFpbog8yaB2qB25Z0THrIE=;
 b=ITt/RkSk5WoM8CJzMvLbTKxWL0A5ENV0J2BPIb31mF4Y661mY9IIq7krAp9YVcA+M8
 BVDVkMFqRo/sa3SLW+QeTlgqTXkjgMgv5EMaeb/18v9a9LnwSNhNwUlN51f/kKhpBvyt
 ujUaJRS75Cj7oxx1hTTlD8bL0swwe8HSAYKFEUwTiDPUvHFVEqKWa1D7F4YPlSXY7/dR
 F2CtitAK6TwQj5QmuUllgtXenlLxHPmbf8Pu/90+g3FO4yaHzuzT0yPSZHnStZxMsjKA
 Ffv7beywMdhZoGmHwz9wLeKGWxtxXra9/k3DTU4UbbKIgsL1lKKMcLzSschRpsUnLvCZ
 hWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AMA9hCnxGrbpSsVjVpfVEXFpbog8yaB2qB25Z0THrIE=;
 b=eNjabYMFYTzkQ8eW56+db7l3XGZNLc4HhGGVaErd1rMc3uDoyDyel4cxeZexnPalqn
 ZvGor6nZ98jGGL6vw+aPSAr+8c5GV4wuntsxj3iT9GD4x/o+AsvzPPMX3Nwl4ZBXcj5D
 uJUo92J0li5Iy2WdvzBmOL4Ni2pa+iNiEAv7c4cBge9xbAuGRlJTUZaM9TrrYwdn8G6P
 wn4Q+ALn3O0224HT7mA/OMqG7fvA6XKgpvzaDt2XBQ5D5yM9nvS4e3MtIJJ6wXosrGxs
 Ql7u7BhxXP+pj5UjDCb2Zn8MuibxzaF4sCNtGJmtZjo5dyl9A2tipjVSa4RDLZ1yHNLz
 r8ng==
X-Gm-Message-State: AOAM5305FPGMm1WAr7b+3qVEZVOPieArCiynM5b1ooiuYFZ9LApOprWF
 TdCLug/mz11DS6udatt/L+hRlatrTC9BYeV7wDs=
X-Google-Smtp-Source: ABdhPJxVMitZGbwopVIlc+EWfxZiViiFO/NgCAUzSB9IxYVLvF5dI/AIRhn5bq9S2MUE96hAdjFCchFZiIs4iYR+bv0=
X-Received: by 2002:a4a:a283:: with SMTP id h3mr308315ool.90.1623356716871;
 Thu, 10 Jun 2021 13:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-17-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-17-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 16:25:06 -0400
Message-ID: <CADnq5_OuQsuAgLX-q4tUZ0eQtchRE2AZVGTo1UQ+OVegORqANA@mail.gmail.com>
Subject: Re: [PATCH 16/40] drm/amd/pm: SMU I2C: Return number of messages
 processed
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
> Fix from number of processed bytes to number of
> processed I2C messages.
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 43 +++++++++++--------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 +++++++++++--------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 +++++++++++--------
>  3 files changed, 75 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 235e83e9f0feb7..409299a608e1b3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1913,9 +1913,8 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       u16 bytes_to_transfer, remaining_bytes, msg_bytes;
> -       u16 available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c;
> +       short available_bytes = MAX_SW_I2C_COMMANDS;
> +       int i, j, r, c, num_done = 0;
>         u8 slave;
>
>         /* only support a single slave addr per transaction */
> @@ -1923,8 +1922,15 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>         for (i = 0; i < num; i++) {
>                 if (slave != msgs[i].addr)
>                         return -EINVAL;
> -               bytes_to_transfer += min(msgs[i].len, available_bytes);
> -               available_bytes -= bytes_to_transfer;
> +
> +               available_bytes -= msgs[i].len;
> +               if (available_bytes >= 0) {
> +                       num_done++;
> +               } else {
> +                       /* This message and all the follwing won't be processed */
> +                       available_bytes += msgs[i].len;
> +                       break;
> +               }
>         }
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -1934,24 +1940,28 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
>         req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = bytes_to_transfer;
> +       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
>                                 cmd->CmdConfig |= I2C_CMD_WRITE;
>                                 cmd->RegisterAddr = msg->buf[j];
>                         }
> -                       if (!remaining_bytes)
> +
> +                       /*
> +                        * Insert STOP if we are at the last byte of either last
> +                        * message for the transaction or the client explicitly
> +                        * requires a STOP at this particular message.
> +                        */
> +                       if ((j == msg->len -1 ) &&
> +                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
>
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> @@ -1964,21 +1974,18 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (msg[i].flags & I2C_M_RD)
>                                 msg->buf[j] = cmd->Data;
>                 }
>         }
> -       r = bytes_to_transfer;
> +       r = num_done;
>
>  fail:
>         kfree(req);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index b94c5a1d3eb756..4010b891f25678 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2708,9 +2708,8 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       u16 bytes_to_transfer, remaining_bytes, msg_bytes;
> -       u16 available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c;
> +       short available_bytes = MAX_SW_I2C_COMMANDS;
> +       int i, j, r, c, num_done = 0;
>         u8 slave;
>
>         /* only support a single slave addr per transaction */
> @@ -2718,8 +2717,15 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         for (i = 0; i < num; i++) {
>                 if (slave != msgs[i].addr)
>                         return -EINVAL;
> -               bytes_to_transfer += min(msgs[i].len, available_bytes);
> -               available_bytes -= bytes_to_transfer;
> +
> +               available_bytes -= msgs[i].len;
> +               if (available_bytes >= 0) {
> +                       num_done++;
> +               } else {
> +                       /* This message and all the follwing won't be processed */
> +                       available_bytes += msgs[i].len;
> +                       break;
> +               }
>         }
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -2729,24 +2735,28 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
>         req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = bytes_to_transfer;
> +       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
>                                 cmd->CmdConfig |= I2C_CMD_WRITE;
>                                 cmd->RegisterAddr = msg->buf[j];
>                         }
> -                       if (!remaining_bytes)
> +
> +                       /*
> +                        * Insert STOP if we are at the last byte of either last
> +                        * message for the transaction or the client explicitly
> +                        * requires a STOP at this particular message.
> +                        */
> +                       if ((j == msg->len -1 ) &&
> +                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
>
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> @@ -2759,21 +2769,18 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (msg[i].flags & I2C_M_RD)
>                                 msg->buf[j] = cmd->Data;
>                 }
>         }
> -       r = bytes_to_transfer;
> +       r = num_done;
>
>  fail:
>         kfree(req);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 2fa667a86c1a54..d5b750d84112fa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3396,9 +3396,8 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       u16 bytes_to_transfer, remaining_bytes, msg_bytes;
> -       u16 available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c;
> +       short available_bytes = MAX_SW_I2C_COMMANDS;
> +       int i, j, r, c, num_done = 0;
>         u8 slave;
>
>         /* only support a single slave addr per transaction */
> @@ -3406,8 +3405,15 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>         for (i = 0; i < num; i++) {
>                 if (slave != msgs[i].addr)
>                         return -EINVAL;
> -               bytes_to_transfer += min(msgs[i].len, available_bytes);
> -               available_bytes -= bytes_to_transfer;
> +
> +               available_bytes -= msgs[i].len;
> +               if (available_bytes >= 0) {
> +                       num_done++;
> +               } else {
> +                       /* This message and all the follwing won't be processed */
> +                       available_bytes += msgs[i].len;
> +                       break;
> +               }
>         }
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
> @@ -3417,24 +3423,28 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
>         req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = bytes_to_transfer;
> +       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
>                                 cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
>                                 cmd->ReadWriteData = msg->buf[j];
>                         }
> -                       if (!remaining_bytes)
> +
> +                       /*
> +                        * Insert STOP if we are at the last byte of either last
> +                        * message for the transaction or the client explicitly
> +                        * requires a STOP at this particular message.
> +                        */
> +                       if ((j == msg->len -1 ) &&
> +                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
>
>                         if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> @@ -3447,21 +3457,18 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       remaining_bytes = bytes_to_transfer;
>         c = 0;
> -       for (i = 0; i < num; i++) {
> +       for (i = 0; i < num_done; i++) {
>                 struct i2c_msg *msg = &msgs[i];
>
> -               msg_bytes = min(msg->len, remaining_bytes);
> -               for (j = 0; j < msg_bytes; j++) {
> +               for (j = 0; j < msg->len; j++) {
>                         SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
>
> -                       remaining_bytes--;
>                         if (msg[i].flags & I2C_M_RD)
>                                 msg->buf[j] = cmd->ReadWriteData;
>                 }
>         }
> -       r = bytes_to_transfer;
> +       r = num_done;
>
>  fail:
>         kfree(req);
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
