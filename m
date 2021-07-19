Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B1C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 20:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF75610F7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 20:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF75610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBE689C28;
	Mon, 19 Jul 2021 20:51:55 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE3189C28
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 20:51:53 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id a132so11376557oib.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fkLu/wXIFBjD7uf4b9PWPZ2VOKlEIJWvofqOhEUXDaY=;
 b=aZeETijX99z6xnnuKrA2RmOL9HDtrwMZgyrtYU5+of7b5ZSo3DKOaJ8ksDvwWHHMGe
 92gZ/7DkTqnt3OWJdCsFw+ZGJw+phA6SAA2FyhvwBw+pUvStc5G4atsllfNqNvrsvyRj
 DujCvJRK73AEhnJrT9N06B2aC6CEKMFuOnNmF1xyfTQJ7Zawgw7N+SDc/wRxrUqT/bRG
 0zqIXIoWrA89w7yHkJDwAmAFQi/610p2m6a2ynFsLiOpD8poelVweJgg/6QALhNMhcPZ
 IUhCYbRdX1CkKuiSDrJOdCYvTYBSATOb9McZWqRBLtydP1/0vLtJ2f5UwMPgxrJKPJDy
 +1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fkLu/wXIFBjD7uf4b9PWPZ2VOKlEIJWvofqOhEUXDaY=;
 b=hL2w5g+T9u647VFsb1AHmUUohWoVoBwZBeFWdZxid93pG+h1IymjPjlI8v6GtFR7Nq
 Q05/jAkIK//Fyf12X17yd5GR0BS4bv0U9c4NZD+ozXkpLYnGHt8QIvFTPrcDTvcAv0/1
 NmUktJf9NyVcL4aEUU1XGXSCK0DfcxXPZsIirwVF2ovWsg0fMKNVmAzP5dhG7FknP6by
 gTRPYaSoY8XTs1aQzr7hA2Xi3qKda7E+/wqCTHHTXzenBtAGhjb53LI9gjzq0lSS+qBJ
 XOgo0hdGT0Cc+6koza/U21dc4NTOw6NUeX89QgB5bObELacjvz9BWerTHUmMIqus8Dn9
 1R2Q==
X-Gm-Message-State: AOAM533xCkIh9WasPsr57QFC5vWDrbBWiRRMiMoyHWVcuoyeesAGQWvc
 G34wYCV4MB8DQlmw5l09755XnPlFVdM3wwBe324=
X-Google-Smtp-Source: ABdhPJx5LLu8Ytdn9sGtSM5tYRpYyNly66vwBPz1RxAWOW9qow4j1ClIPRsDYOyfHSWls1zg0lIBtFixcrUifuGgTGQ=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr3066764oiw.123.1626727912676; 
 Mon, 19 Jul 2021 13:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210719161637.57819-1-luben.tuikov@amd.com>
In-Reply-To: <20210719161637.57819-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Jul 2021 16:51:41 -0400
Message-ID: <CADnq5_NGMa7yN1Mpb8pYvYZJ-te4vGz4KdFRVxK=_xNSGJeXdQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v4)
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

On Mon, Jul 19, 2021 at 12:16 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
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
> v4: a) Add macros as requested, though redundant, to
>     be removed when SMU consolidates for all
>     ASICs--see comment in code.
>     b) Get out if the SMU code is unknown.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 294 +++++++++++++++++++++----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>  2 files changed, 250 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c902fdf322c1be..9b30737bd541d6 100644
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
> @@ -76,55 +76,264 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>         *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>  }
>
> -int smu_cmn_wait_for_response(struct smu_context *smu)
> +/* Redefine the SMU error codes here.
> + *
> + * Note that these definitions are redundant and should be removed
> + * when the SMU has exported a unified header file containing these
> + * macros, which header file we can just include and use the SMU's
> + * macros. At the moment, these error codes are defined by the SMU
> + * per-ASIC unfortunately, yet we're a one driver for all ASICs.
> + */
> +
> +#define SMU_BUSY           0

This is really a response per se, it's just that the SMU hasn't
updated the response register yet.
Maybe SMU_RESP_NONE

> +#define SMU_GOOD           1
> +#define SMU_CMD_FAIL       0xFF
> +#define SMU_CMD_UNKNOWN    0xFE
> +#define SMU_CMD_BAD_PREREQ 0xFD
> +#define SMU_BUSY_OTHER     0xFC
> +#define SMU_DEBUG_END      0xFB

I'd change the macros to include RESP for consistency E.g.,
#define SMU_RESP_OK           1
#define SMU_RESP_CMD_FAIL       0xFF
etc.

> +
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
> +       case SMU_BUSY:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: I'm not done with your previous command!");
> +               break;
> +       case SMU_GOOD:
> +               /* The SMU executed the command. It completed with a
> +                * successful result.
> +                */
> +               break;
> +       case SMU_CMD_FAIL:
> +               /* The SMU executed the command. It completed with an
> +                * unsuccessful result.
> +                */
> +               break;
> +       case SMU_CMD_UNKNOWN:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: unknown command: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case SMU_CMD_BAD_PREREQ:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case SMU_BUSY_OTHER:
> +               dev_err_ratelimited(adev->dev,
> +                                   "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
> +                                   msg_index, param, message);
> +               break;
> +       case SMU_DEBUG_END:
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
> +       case SMU_BUSY:
> +               /* The SMU is busy--still executing your command.
> +                */
> +               res = -ETIME;
> +               break;
> +       case SMU_GOOD:
> +               res = 0;
> +               break;
> +       case SMU_CMD_FAIL:
> +               /* Command completed successfully, but the command
> +                * status was failure.
> +                */
> +               res = -EIO;
> +               break;
> +       case SMU_CMD_UNKNOWN:
> +               /* Unknown command--ignored by the SMU.
> +                */
> +               res = -EOPNOTSUPP;
> +               break;
> +       case SMU_CMD_BAD_PREREQ:
> +               /* Valid command--bad prerequisites.
> +                */
> +               res = -EIO;

Maybe -EINVAL would be better here to differentiate it from other cases.


> +               break;
> +       case SMU_BUSY_OTHER:
> +               /* The SMU is busy with other commands. The client
> +                * should retry in 10 us.
> +                */
> +               res = -EBUSY;
> +               break;
> +       case SMU_DEBUG_END:
> +               /* Debug message.
> +                */
> +               res = -EIO;

Maybe -EREMOTEIO here as well since this seems more logically grouped
with the default.

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
> +       res = __smu_cmn_reg2errno(smu, reg);
> +       if (reg == SMU_BUSY ||
> +           reg == SMU_BUSY_OTHER ||
> +           res == -EREMOTEIO)
> +               goto Out;
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
> @@ -136,31 +345,24 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
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
> +       res = __smu_cmn_reg2errno(smu, reg);
> +       if (reg == SMU_BUSY ||
> +           reg == SMU_BUSY_OTHER ||
> +           res == -EREMOTEIO) {
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
