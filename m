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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA0BC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4DC6100A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4DC6100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F143D6E05F;
	Thu, 10 Jun 2021 21:09:01 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4176E05F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:09:00 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so1062847oth.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eDDFiQwpz/pZBPIeY3ccFORjaHxCoV5zjtqghqzDufI=;
 b=O5HIbEw1EPyTSRNeE8oS6S2gn9G07pf+4ezCZt6OQRLqw8gVSc3NMF1kqUZWfyAXQR
 GicaI716h/L5O2n+UoXK8GtezAtcljw0iPwfUO2aWNFR1w0F6CpFixMo94d6f/gDoTx/
 K/yuqF8s9OxN+GcAltMp0iuTO/qmEn5XN7afVC5qS42thyNmY6j9ce0R/MNN9GBRO3ao
 K0SdNUwm4q27P7UJW0nTzXfnq3MdLuVfvwtNZw3D+hvSaJUSfngZDQA6c7fVEODYl+nA
 SOH54Lcpu9zpzfiU9+NtXhTAZyxMh5pAJOBkUMyZYsZJKcI4aPXG3RyMm3ZHtJrKd0ZC
 YMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eDDFiQwpz/pZBPIeY3ccFORjaHxCoV5zjtqghqzDufI=;
 b=JH6rMY86mpmRVbBlPnjC/EwbjrWe4OKY6YT07GsPhOxplIcd9FXVUYKyrlMNsaZNFq
 /L5vtBceEo+AOOU4w+G6amsoceyXo5MxGtgr6j1DyfFrJJlhp8HgKsvyK39SsTeiun2O
 C1n/RGoZQrwZxliFrRhVzzLKM3k6n2uVAM3X8ApscA5TZ02sj1xvwKsVDjMInp6yh3Wb
 CH8YEPJ93eW7F2bf7rdfU+Td7tekRfZl98tIJ9di9OQK0NOXwanI0FvmsUdq53cykoJi
 Z9Vb2Wy4FDBt10AdDkSUZ30cytlhOUE5Xdamne7BcsaWgP7xXCbpzOe2rnp47q2p9vET
 aWLw==
X-Gm-Message-State: AOAM531/yPp3S7+zB0ATJN6/2fmmZLl+pYizfKunyJkmx0uI5SF85LJV
 fMI2c5UI2aURRo/iRuYwPxwjQowHc2EgFGNdlZg=
X-Google-Smtp-Source: ABdhPJxjtDdb0vmjyeOYGjPXtbub1fA6wSrPlvypeD4mjCZRhKdYglZtFPVsKCRBruIO6ocxmmd8mYotZ48MSeDDX/Q=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr264008otr.23.1623359339918; 
 Thu, 10 Jun 2021 14:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-31-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-31-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:08:48 -0400
Message-ID: <CADnq5_Pa7bQMrwVJ0-gRZAWq=wKbkv93xaQ3kBBGdtnJpiNOmw@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/pm: Simplify managed I2C transfer functions
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
> Now that we have an I2C quirk table for
> SMU-managed I2C controllers, the I2C core does the
> checks for us, so we don't need to do them, and so
> simplify the managed I2C transfer functions.
>
> Also, for Arcturus and Navi10, fix setting the
> command type from "cmd->CmdConfig" to "cmd->Cmd".
> The latter is what appears to be taking in
> the enumeration I2C_CMD_... as an integer,
> not a bit-flag.
>
> For Sienna, the "Cmd" field seems to have been
> eliminated, and command type and flags all live in
> the "CmdConfig" field--this is left untouched.
>
> Fix: Detect and add changing of direction
> bit-flag, as this is necessary for the SMU to
> detect the direction change in the 1-d array of
> data it gets.
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
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 78 ++++++++-----------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 78 ++++++++-----------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 76 ++++++++----------
>  3 files changed, 95 insertions(+), 137 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index de8d7513042966..0db79a5236e1f1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1907,31 +1907,14 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>  }
>
>  static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                            struct i2c_msg *msgs, int num)
> +                            struct i2c_msg *msg, int num_msgs)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       short available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c, num_done = 0;
> -       u8 slave;
> -
> -       /* only support a single slave addr per transaction */
> -       slave = msgs[0].addr;
> -       for (i = 0; i < num; i++) {
> -               if (slave != msgs[i].addr)
> -                       return -EINVAL;
> -
> -               available_bytes -= msgs[i].len;
> -               if (available_bytes >= 0) {
> -                       num_done++;
> -               } else {
> -                       /* This message and all the follwing won't be processed */
> -                       available_bytes += msgs[i].len;
> -                       break;
> -               }
> -       }
> +       int i, j, r, c;
> +       u16 dir;
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
>         if (!req)
> @@ -1939,33 +1922,38 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
> -       req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
> -
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> +       req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
> +       dir = msg[0].flags & I2C_M_RD;
>
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
>
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
> -                               cmd->CmdConfig |= I2C_CMD_WRITE;
> -                               cmd->RegisterAddr = msg->buf[j];
> +                               cmd->Cmd = I2C_CMD_WRITE;
> +                               cmd->RegisterAddr = msg[i].buf[j];
> +                       }
> +
> +                       if ((dir ^ msg[i].flags) & I2C_M_RD) {
> +                               /* The direction changes.
> +                                */
> +                               dir = msg[i].flags & I2C_M_RD;
> +                               cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
>                         }
>
> +                       req->NumCmds++;
> +
>                         /*
>                          * Insert STOP if we are at the last byte of either last
>                          * message for the transaction or the client explicitly
>                          * requires a STOP at this particular message.
>                          */
> -                       if ((j == msg->len -1 ) &&
> -                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
> +                       if ((j == msg[i].len - 1) &&
> +                           ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
> +                               cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -
> -                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> -                               cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
> +                       }
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> @@ -1974,22 +1962,20 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> -
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               if (!(msg[i].flags & I2C_M_RD)) {
> +                       c += msg[i].len;
> +                       continue;
> +               }
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
>
> -                       if (msg[i].flags & I2C_M_RD)
> -                               msg->buf[j] = cmd->Data;
> +                       msg[i].buf[j] = cmd->Data;
>                 }
>         }
> -       r = num_done;
> -
> +       r = num_msgs;
>  fail:
>         kfree(req);
> -
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 1b8cd3746d0ebc..2acf54967c6ab1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2702,31 +2702,14 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>  }
>
>  static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                          struct i2c_msg *msgs, int num)
> +                          struct i2c_msg *msg, int num_msgs)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       short available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c, num_done = 0;
> -       u8 slave;
> -
> -       /* only support a single slave addr per transaction */
> -       slave = msgs[0].addr;
> -       for (i = 0; i < num; i++) {
> -               if (slave != msgs[i].addr)
> -                       return -EINVAL;
> -
> -               available_bytes -= msgs[i].len;
> -               if (available_bytes >= 0) {
> -                       num_done++;
> -               } else {
> -                       /* This message and all the follwing won't be processed */
> -                       available_bytes += msgs[i].len;
> -                       break;
> -               }
> -       }
> +       int i, j, r, c;
> +       u16 dir;
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
>         if (!req)
> @@ -2734,33 +2717,38 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
> -       req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
> +       req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
> +       dir = msg[0].flags & I2C_M_RD;
>
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> -
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
>
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
> -                               cmd->CmdConfig |= I2C_CMD_WRITE;
> -                               cmd->RegisterAddr = msg->buf[j];
> +                               cmd->Cmd = I2C_CMD_WRITE;
> +                               cmd->RegisterAddr = msg[i].buf[j];
> +                       }
> +
> +                       if ((dir ^ msg[i].flags) & I2C_M_RD) {
> +                               /* The direction changes.
> +                                */
> +                               dir = msg[i].flags & I2C_M_RD;
> +                               cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
>                         }
>
> +                       req->NumCmds++;
> +
>                         /*
>                          * Insert STOP if we are at the last byte of either last
>                          * message for the transaction or the client explicitly
>                          * requires a STOP at this particular message.
>                          */
> -                       if ((j == msg->len -1 ) &&
> -                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
> +                       if ((j == msg[i].len - 1) &&
> +                           ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
> +                               cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -
> -                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> -                               cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
> +                       }
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> @@ -2769,22 +2757,20 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> -
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               if (!(msg[i].flags & I2C_M_RD)) {
> +                       c += msg[i].len;
> +                       continue;
> +               }
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
>
> -                       if (msg[i].flags & I2C_M_RD)
> -                               msg->buf[j] = cmd->Data;
> +                       msg[i].buf[j] = cmd->Data;
>                 }
>         }
> -       r = num_done;
> -
> +       r = num_msgs;
>  fail:
>         kfree(req);
> -
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b38127f8009d3d..44ca3b3f83f4d9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3390,31 +3390,14 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
>  }
>
>  static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
> -                                  struct i2c_msg *msgs, int num)
> +                                  struct i2c_msg *msg, int num_msgs)
>  {
>         struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
>         struct smu_table_context *smu_table = &adev->smu.smu_table;
>         struct smu_table *table = &smu_table->driver_table;
>         SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
> -       short available_bytes = MAX_SW_I2C_COMMANDS;
> -       int i, j, r, c, num_done = 0;
> -       u8 slave;
> -
> -       /* only support a single slave addr per transaction */
> -       slave = msgs[0].addr;
> -       for (i = 0; i < num; i++) {
> -               if (slave != msgs[i].addr)
> -                       return -EINVAL;
> -
> -               available_bytes -= msgs[i].len;
> -               if (available_bytes >= 0) {
> -                       num_done++;
> -               } else {
> -                       /* This message and all the follwing won't be processed */
> -                       available_bytes += msgs[i].len;
> -                       break;
> -               }
> -       }
> +       int i, j, r, c;
> +       u16 dir;
>
>         req = kzalloc(sizeof(*req), GFP_KERNEL);
>         if (!req)
> @@ -3422,33 +3405,38 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>
>         req->I2CcontrollerPort = 1;
>         req->I2CSpeed = I2C_SPEED_FAST_400K;
> -       req->SlaveAddress = slave << 1; /* 8 bit addresses */
> -       req->NumCmds = MAX_SW_I2C_COMMANDS - available_bytes;;
> +       req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
> +       dir = msg[0].flags & I2C_M_RD;
>
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> -
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
>
>                         if (!(msg[i].flags & I2C_M_RD)) {
>                                 /* write */
>                                 cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
> -                               cmd->ReadWriteData = msg->buf[j];
> +                               cmd->ReadWriteData = msg[i].buf[j];
> +                       }
> +
> +                       if ((dir ^ msg[i].flags) & I2C_M_RD) {
> +                               /* The direction changes.
> +                                */
> +                               dir = msg[i].flags & I2C_M_RD;
> +                               cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
>                         }
>
> +                       req->NumCmds++;
> +
>                         /*
>                          * Insert STOP if we are at the last byte of either last
>                          * message for the transaction or the client explicitly
>                          * requires a STOP at this particular message.
>                          */
> -                       if ((j == msg->len -1 ) &&
> -                           ((i == num_done - 1) || (msg[i].flags & I2C_M_STOP)))
> +                       if ((j == msg[i].len - 1) &&
> +                           ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
> +                               cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
>                                 cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
> -
> -                       if ((j == 0) && !(msg[i].flags & I2C_M_NOSTART))
> -                               cmd->CmdConfig |= CMDCONFIG_RESTART_BIT;
> +                       }
>                 }
>         }
>         mutex_lock(&adev->smu.mutex);
> @@ -3457,22 +3445,20 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>         if (r)
>                 goto fail;
>
> -       c = 0;
> -       for (i = 0; i < num_done; i++) {
> -               struct i2c_msg *msg = &msgs[i];
> -
> -               for (j = 0; j < msg->len; j++) {
> -                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c++];
> +       for (c = i = 0; i < num_msgs; i++) {
> +               if (!(msg[i].flags & I2C_M_RD)) {
> +                       c += msg[i].len;
> +                       continue;
> +               }
> +               for (j = 0; j < msg[i].len; j++, c++) {
> +                       SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
>
> -                       if (msg[i].flags & I2C_M_RD)
> -                               msg->buf[j] = cmd->ReadWriteData;
> +                       msg[i].buf[j] = cmd->ReadWriteData;
>                 }
>         }
> -       r = num_done;
> -
> +       r = num_msgs;
>  fail:
>         kfree(req);
> -
>         return r;
>  }
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
