Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F2C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 20:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C73613D0
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 20:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C73613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7856E9D4;
	Fri, 16 Jul 2021 20:29:39 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8626E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 20:29:39 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id u11so12380226oiv.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HTkL/t4zq404X3g6OrKzpnQdJ8mwV7tbkywq40TxRjE=;
 b=I3zgj0DuUQ7+CmJXEXYvzB1J+Rio9HMiTGnuAXeqZKZ9j+pn2XfKNYj3yT8nKaZ0/l
 s/UdrjkdDyAwz87kGPeGrRZF8JGYROabbSeNbl/vg66mLScUCNgX/IhJxEx8QD4fZCCX
 OCvociZyEzEAruQS0nrLZo5zC04bVDKdyw1LCq35qXb+O80qKRaaiqcec0z/iKzdOT+F
 xn5bIZSFrPeslRzI1oOm6u49pjMVTOqaweB1yB3+kmcXKDuM6asHQcpaGom4zDwC5/wl
 iLh0DR+uworuKdqfhQDfKuYdY4CcUggNj489vBs4khcAz4p0PeTyau/pM7DLuhipzngq
 ep3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HTkL/t4zq404X3g6OrKzpnQdJ8mwV7tbkywq40TxRjE=;
 b=A4I9TJDMDhtzdwhWOqR6MNaNdETpszluvi1FuaRik5whzyhLdniKH6MQwIgU26HPj+
 5I6vIVzpXDwuSMICJyUBT0OUuGc2pt46OIfjQgMex//QglhlPtIRsX+4WVFevsBAIsiE
 Yj0QskpEUhgKxYk/KaY9RqIVt6OrOHanxY00xMod4iJFeN/2V2JDehi3Y6nVo+Ze4ClI
 wKth37wOXVdgZzBqCvelwar4vBnx0sGE9eq3KDVp+IS6JjNWbSmR21Y7626oUXiSeodo
 NEVid4fTzph3gGLWBYtSkM8wXObvDL6uzhPNX2cMnE+GNagzBTcIOPpovevdQvbfQ+Js
 dJ/Q==
X-Gm-Message-State: AOAM533tIaM5aLREYvc9oLAmVWHkCzMu4Al6uKkiaNlH8Ltb+ND4Si5N
 isI5za98safmhvBH+EABbnFuSCX3Pg/HZrzSmVk=
X-Google-Smtp-Source: ABdhPJzVrV7KHPRTeeU00PELHU1FvBLBeYkBUQEhDT8XsrE5oavzVbQDVopIxIigGgMZS8f83yGxzeMOSaAuNse1i40=
X-Received: by 2002:aca:ac15:: with SMTP id v21mr13005835oie.5.1626467378353; 
 Fri, 16 Jul 2021 13:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210714175817.20473-1-luben.tuikov@amd.com>
In-Reply-To: <20210714175817.20473-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jul 2021 16:29:27 -0400
Message-ID: <CADnq5_PKcnOnehkZ_MMXKTcV1A=75joijo_iqrJMfjtnACrw-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v3)
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Evan Quan <evan.quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 14, 2021 at 1:58 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> This fixes a bug which if we probe a non-existing
> I2C device, and the SMU returns 0xFF, from then on
> we can never communicate with the SMU, because the
> code before this patch reads and interprets 0xFF
> as a terminal error, and thus we never write 0
> into register 90 to clear the status (and
> subsequently send a new command to the SMU.)
>
> It is not an error that the SMU returns status
> 0xFF. This means that the SMU executed the last
> command successfully (execution status), but the
> command result is an error of some sort (execution
> result), depending on what the command was.
>
> When doing a status check of the SMU, before we
> send a new command, the only status which
> precludes us from sending a new command is 0--the
> SMU hasn't finished executing a previous command,
> and 0xFC--the SMU is busy.
>
> This bug was seen as the following line in the
> kernel log,
>
> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
>
> when subsequent SMU commands, not necessarily
> related to I2C, were sent to the SMU.
>
> This patch fixes this bug.
>
> v2: Add a comment to the description of
> __smu_cmn_poll_stat() to explain why we're NOT
> defining the SMU FW return codes as macros, but
> are instead hard-coding them. Such a change, can
> be followed up by a subsequent patch.
>
> v3: The changes are,
> a) Add comments to break labels in
>    __smu_cmn_reg2errno().
>
> b) When an unknown/unspecified/undefined result is
>    returned back from the SMU, map that to
>    -EREMOTEIO, to distinguish failure at the SMU
>    FW.
>
> c) Add kernel-doc to
>    smu_cmn_send_msg_without_waiting(),
>    smu_cmn_wait_for_response(),
>    smu_cmn_send_smc_msg_with_param().
>
> d) In smu_cmn_send_smc_msg_with_param(), since we
>    wait for completion of the command, if the
>    result of the completion is
>    undefined/unknown/unspecified, we print that to
>    the kernel log.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 274 ++++++++++++++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>  2 files changed, 230 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c902fdf322c1be..dde10c51daa106 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -55,7 +55,7 @@
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  #type
> -static const char* __smu_message_names[] = {
> +static const char * const __smu_message_names[] = {
>         SMU_MESSAGE_TYPES
>  };
>
> @@ -76,55 +76,246 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>         *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>  }
>
> -int smu_cmn_wait_for_response(struct smu_context *smu)
> +/**
> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> + * smu: a pointer to SMU context
> + *
> + * Returns the status of the SMU, which could be,
> + *    0, the SMU is busy with your previous command;
> + *    1, execution status: success, execution result: success;
> + * 0xFF, execution status: success, execution result: failure;
> + * 0xFE, unknown command;
> + * 0xFD, valid command, but bad (command) prerequisites;
> + * 0xFC, the command was rejected as the SMU is busy;
> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> + *
> + * The values here are not defined by macros, because I'd rather we
> + * include a single header file which defines them, which is
> + * maintained by the SMU FW team, so that we're impervious to firmware
> + * changes. At the moment those values are defined in various header
> + * files, one for each ASIC, yet here we're a single ASIC-agnostic
> + * interface. Such a change can be followed-up by a subsequent patch.
> + */

Might be nice to add generic SMU defines for these just to help code
readability.  While reviewing the patch, I kept having to refer back
to the comment to remember what the error codes meant.  Other than
that, this looks pretty good to me.  I'm trying to decide if we should
do some limited retries in the send_msg function itself if the SMU
returns -EBUSY or if we should just leave that up to the callers.
Would be good to get some feedback from Evan and Lijo too as they know
this code better than I do.

I presume you have a patch for i2c to handle the -EIO case when
probing a non-existent i2c device? Or is that already handled?

Alex


> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> -       uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> +       int timeout = adev->usec_timeout * 20;
> +       u32 reg;
>
> -       for (i = 0; i < timeout; i++) {
> -               cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> -               if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> -                       return cur_value;
> +       for ( ; timeout > 0; timeout--) {
> +               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +               if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> +                       break;
>
>                 udelay(1);
>         }
>
> -       /* timeout means wrong logic */
> -       if (i == timeout)
> -               return -ETIME;
> -
> -       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +       return reg;
>  }
>
> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -                                    uint16_t msg, uint32_t param)
> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> +                                     u32 reg_c2pmsg_90,
> +                                     int msg_index,
> +                                     u32 param,
> +                                     enum smu_message_type msg)
>  {
>         struct amdgpu_device *adev = smu->adev;
> -       int ret;
> +       const char *message = smu_get_message_name(smu, msg);
>
> -       ret = smu_cmn_wait_for_response(smu);
> -       if (ret != 0x1) {
> -               dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
> -                      "SMU may be not in the right state!\n", ret);
> -               if (ret != -ETIME)
> -                       ret = -EIO;
> -               return ret;
> +       switch (reg_c2pmsg_90) {
> +       case 0:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: I'm not done with your previous command!");
> +               break;
> +       case 1:
> +               /* The SMU executed the command. It completed with a
> +                * successful result.
> +                */
> +               break;
> +       case 0xFF:
> +               /* The SMU executed the command. It completed with a
> +                * unsuccessful result.
> +                */
> +               break;
> +       case 0xFE:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: unknown command: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case 0xFD:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case 0xFC:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case 0xFB:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: I'm debugging!");
> +               break;
> +       default:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
> +                                   reg_c2pmsg_90, msg_index, param, message);
> +               break;
> +       }
> +}
> +
> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
> +{
> +       int res;
> +
> +       switch (reg_c2pmsg_90) {
> +       case 0:
> +               /* The SMU is busy--still executing your command.
> +                */
> +               res = -ETIME;
> +               break;
> +       case 1:
> +               res = 0;
> +               break;
> +       case 0xFF:
> +               /* Command completed successfully, but the command
> +                * status was failure.
> +                */
> +               res = -EIO;
> +               break;
> +       case 0xFE:
> +               /* Unknown command--ignored by the SMU.
> +                */
> +               res = -EOPNOTSUPP;
> +               break;
> +       case 0xFD:
> +               /* Valid command--bad prerequisites.
> +                */
> +               res = -EIO;
> +               break;
> +       case 0xFC:
> +               /* The SMU is busy with other commands. The client
> +                * should retry in 10 us.
> +                */
> +               res = -EBUSY;
> +               break;
> +       case 0xFB:
> +               /* Debug message.
> +                */
> +               res = -EIO;
> +               break;
> +       default:
> +               /* Unknown result from the SMU.
> +                */
> +               res = -EREMOTEIO;
> +               break;
>         }
>
> +       return res;
> +}
> +
> +static void __smu_cmn_send_msg(struct smu_context *smu,
> +                              u16 msg,
> +                              u32 param)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +
>         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> +}
>
> -       return 0;
> +/**
> + * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
> + * @smu: pointer to an SMU context
> + * @msg_index: message index
> + * @param: message parameter to send to the SMU
> + *
> + * Send a message to the SMU with the parameter passed. Do not wait
> + * for status/result of the message, thus the "without_waiting".
> + *
> + * Return 0 on success, -errno on error if we weren't able to _send_
> + * the message for some reason. See __smu_cmn_reg2errno() for details
> + * of the -errno.
> + */
> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> +                                    uint16_t msg_index,
> +                                    uint32_t param)
> +{
> +       u32 reg;
> +       int res;
> +
> +       if (smu->adev->in_pci_err_recovery)
> +               return 0;
> +
> +       mutex_lock(&smu->message_lock);
> +       reg = __smu_cmn_poll_stat(smu);
> +       if (reg == 0 || reg == 0xFC) {
> +               res = __smu_cmn_reg2errno(smu, reg);
> +               goto Out;
> +       }
> +       __smu_cmn_send_msg(smu, msg_index, param);
> +       res = 0;
> +Out:
> +       mutex_unlock(&smu->message_lock);
> +       return res;
>  }
>
> +/**
> + * smu_cmn_wait_for_response -- wait for response from the SMU
> + * @smu: pointer to an SMU context
> + *
> + * Wait for status from the SMU.
> + *
> + * Return 0 on success, -errno on error, indicating the execution
> + * status and result of the message being waited for. See
> + * __smu_cmn_reg2errno() for details of the -errno.
> + */
> +int smu_cmn_wait_for_response(struct smu_context *smu)
> +{
> +       u32 reg;
> +
> +       reg = __smu_cmn_poll_stat(smu);
> +       return __smu_cmn_reg2errno(smu, reg);
> +}
> +
> +/**
> + * smu_cmn_send_smc_msg_with_param -- send a message with parameter
> + * @smu: pointer to an SMU context
> + * @msg: message to send
> + * @param: parameter to send to the SMU
> + * @read_arg: pointer to u32 to return a value from the SMU back
> + *            to the caller
> + *
> + * Send the message @msg with parameter @param to the SMU, wait for
> + * completion of the command, and return back a value from the SMU in
> + * @read_arg pointer.
> + *
> + * Return 0 on success, -errno on error, if we weren't able to send
> + * the message or if the message completed with some kind of
> + * error. See __smu_cmn_reg2errno() for details of the -errno.
> + *
> + * If we weren't able to send the message to the SMU, we also print
> + * the error to the standard log.
> + *
> + * Command completion status is printed only if the -errno is
> + * -EREMOTEIO, indicating that the SMU returned back an
> + * undefined/unknown/unspecified result. All other cases are
> + * well-defined, not printed, but instead given back to the client to
> + * decide what further to do.
> + *
> + * The return value, @read_arg is read back regardless, to give back
> + * more information to the client, which on error would most likely be
> + * @param, but we can't assume that. This also eliminates more
> + * conditionals.
> + */
>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>                                     enum smu_message_type msg,
>                                     uint32_t param,
>                                     uint32_t *read_arg)
>  {
> -       struct amdgpu_device *adev = smu->adev;
> -       int ret = 0, index = 0;
> +       int res, index;
> +       u32 reg;
>
>         if (smu->adev->in_pci_err_recovery)
>                 return 0;
> @@ -136,31 +327,22 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>                 return index == -EACCES ? 0 : index;
>
>         mutex_lock(&smu->message_lock);
> -       ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
> -       if (ret)
> -               goto out;
> -
> -       ret = smu_cmn_wait_for_response(smu);
> -       if (ret != 0x1) {
> -               if (ret == -ETIME) {
> -                       dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
> -                               smu_get_message_name(smu, msg), index, param);
> -               } else {
> -                       dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
> -                               smu_get_message_name(smu, msg), index, param,
> -                               ret);
> -                       ret = -EIO;
> -               }
> -               goto out;
> +       reg = __smu_cmn_poll_stat(smu);
> +       if (reg == 0 || reg == 0xFC) {
> +               res = __smu_cmn_reg2errno(smu, reg);
> +               __smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +               goto Out;
>         }
> -
> +       __smu_cmn_send_msg(smu, (uint16_t) index, param);
> +       reg = __smu_cmn_poll_stat(smu);
> +       res = __smu_cmn_reg2errno(smu, reg);
> +       if (res == -EREMOTEIO)
> +               __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>         if (read_arg)
>                 smu_cmn_read_arg(smu, read_arg);
> -
> -       ret = 0; /* 0 as driver return value */
> -out:
> +Out:
>         mutex_unlock(&smu->message_lock);
> -       return ret;
> +       return res;
>  }
>
>  int smu_cmn_send_smc_msg(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 9add5f16ff562a..16993daa2ae042 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -27,7 +27,8 @@
>
>  #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -                                    uint16_t msg, uint32_t param);
> +                                    uint16_t msg_index,
> +                                    uint32_t param);
>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>                                     enum smu_message_type msg,
>                                     uint32_t param,
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
