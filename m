Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A822C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29498600D1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29498600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D536E40C;
	Wed, 14 Jul 2021 15:19:54 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E966E40C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:19:53 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 o72-20020a9d224e0000b02904bb9756274cso2836248ota.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f/T2bHjhaQJS8pf5N+kcuAZzoha2r6zJfcRtqYM8Kr4=;
 b=KIJBSW3QRrBbulRuJSrPMnv85l/fNJn5aiQZQHAQzEdP5Rf0fhw6MTx2WMzh8W9cKs
 ghzg3Zl+/AkXpyj77DwM5PHC99Zfdvi+h2AoBJRKc9KMpYskwWW/1ClRyVKEkEe46Cxp
 5d2ROFupVg0lbNCCNOJphCUe6po2ss/34+LZG5AeNlSfSrIDnTbjLWJ8urH2vM8xH20w
 R939BZeWSnSGLV6L5BdT9QVRw2zmXlN+83y+eMj8Pyp9mSZVXLeapP0ApMYJr53gvh7Z
 PVfBh3KRfqlu41U3SAzkTktuttnPZXmT6Q6s9eljsgvn+AcIxg8RBirnswgcIYvPwBXL
 HcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f/T2bHjhaQJS8pf5N+kcuAZzoha2r6zJfcRtqYM8Kr4=;
 b=aBvYWCn8riqTlW5IFtSK+zCAPbvFhkj5pb1eEdmZ7swzXYhoQedowzcTQ6w47gy4Uq
 WD9nfjSD+Zgdv7PTZsSe7SqnO9kwoPKemeyqb/7Ps8a9IAHv8YQhdtW90DBcCmc1XKzY
 BQ8Pkta7mpwUnw3ADem7wmq+/w0pnx3Ge9lDbiQjMy6P8LnFTb4LkCYCwT+LtihboD7p
 EqYTuhiiN3CC9nPMVzd6nwT+jO4nzS0PcGBKAssFpMXJp0yJm80C9xCrIuOQfn2yEp8s
 vT6h9JghWmVToCXr+wlsvS0q6HZb0ki+bOg7vieChaATrEmUFlWKBQfCE7b4AiqQE0iq
 AfYg==
X-Gm-Message-State: AOAM533xnw4hTVoozzt+iV5VfGODIpdwphFh34cQAmvHI8zx9JUFNQIG
 3ayhi53aJzJijiIjdAaENB1Svr387/4nLdWPmPQ=
X-Google-Smtp-Source: ABdhPJxQQ3vXCmc++GmM9EK/4tQWJWzQRtFG8+t9e7xjNmNuhI/+mKch7brSonXzJWs5oBw913EYz6SDSJ8Bn03glyo=
X-Received: by 2002:a9d:2482:: with SMTP id z2mr5944822ota.132.1626275992697; 
 Wed, 14 Jul 2021 08:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
In-Reply-To: <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 11:19:41 -0400
Message-ID: <CADnq5_MH4p2kWz5DX3oi0=rRGOGxo23FyDtfgCW-8aGm4AKD6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 12, 2021 at 10:56 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 7/12/2021 9:00 PM, Luben Tuikov wrote:
> > This fixes a bug which if we probe a non-existing
> > I2C device, and the SMU returns 0xFF, from then on
> > we can never communicate with the SMU, because the
> > code before this patch reads and interprets 0xFF
> > as a terminal error, and thus we never write 0
> > into register 90 to clear the status (and
> > subsequently send a new command to the SMU.)
> >
> > It is not an error that the SMU returns status
> > 0xFF. This means that the SMU executed the last
> > command successfully (execution status), but the
> > command result is an error of some sort (execution
> > result), depending on what the command was.
> >
> > When doing a status check of the SMU, before we
> > send a new command, the only status which
> > precludes us from sending a new command is 0--the
> > SMU hasn't finished executing a previous command,
> > and 0xFC--the SMU is busy.
> >
> > This bug was seen as the following line in the
> > kernel log,
> >
> > amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
> >
> > when subsequent SMU commands, not necessarily
> > related to I2C, were sent to the SMU.
> >
> > This patch fixes this bug.
> >
> > Cc: Alex Deucher <Alexander.Deucher@amd.com>
> > Cc: Evan Quan <evan.quan@amd.com>
> > Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196 +++++++++++++++++++------
> >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
> >   2 files changed, 152 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index c902fdf322c1be..775eb50a2e49a6 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -55,7 +55,7 @@
> >
> >   #undef __SMU_DUMMY_MAP
> >   #define __SMU_DUMMY_MAP(type)       #type
> > -static const char* __smu_message_names[] = {
> > +static const char * const __smu_message_names[] = {
> >       SMU_MESSAGE_TYPES
> >   };
> >
> > @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context *smu,
> >       *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
> >   }
> >
> > -int smu_cmn_wait_for_response(struct smu_context *smu)
> > +/**
> > + * __smu_cmn_poll_stat -- poll for a status from the SMU
> > + * smu: a pointer to SMU context
> > + *
> > + * Returns the status of the SMU, which could be,
> > + * 0, the SMU is busy with your previous command;
> > + * 1,    execution status: success, execution result: success;
> > + * 0xFF, execution status: success, execution result: failure;
> > + * 0xFE, unknown command;
> > + * 0xFD, valid command, but bad (command) prerequisites;
> > + * 0xFC, the command was rejected as the SMU is busy;
> > + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> > + */
>
> These are the response codes defined in header (0xFB is somehow missing)
> // SMU Response Codes:
> #define PPSMC_Result_OK                    0x1
> #define PPSMC_Result_Failed                0xFF
> #define PPSMC_Result_UnknownCmd            0xFE
> #define PPSMC_Result_CmdRejectedPrereq     0xFD
> #define PPSMC_Result_CmdRejectedBusy       0xFC
>
> It's better to use #defines for these, usually we follow a convention
> like SMU_

We could do a MAP_RESULT() macro like we do with the messages, etc. to
make them per asic, but that may be overkill as I think these result
codes have been the same across asics for a long time.

Alex

>
> Ex:
>         #define SMU_RESP_RESULT_OK 0x1
>
>
> > +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
> >   {
> >       struct amdgpu_device *adev = smu->adev;
> > -     uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> > +     int timeout = adev->usec_timeout * 20;
> > +     u32 reg;
> >
> > -     for (i = 0; i < timeout; i++) {
> > -             cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> > -             if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> > -                     return cur_value;
> > +     for ( ; timeout > 0; timeout--) {
> > +             reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> > +             if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> > +                     break;
> >
> >               udelay(1);
> >       }
> >
> > -     /* timeout means wrong logic */
> > -     if (i == timeout)
> > -             return -ETIME;
> > -
> > -     return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> > +     return reg;
> >   }
> >
> > -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > -                                  uint16_t msg, uint32_t param)
> > +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> > +                                   u32 reg_c2pmsg_90,
>
> Instead of using reg/regname in function, it would be better to name it
> as smu_cmn_resp/smu_resp or similar to make it clear that we are
> decoding smu response.
>
> > +                                   int msg_index,
> > +                                   u32 param,
> > +                                   enum smu_message_type msg)
> >   {
> >       struct amdgpu_device *adev = smu->adev;
> > -     int ret;
> > +     const char *message = smu_get_message_name(smu, msg);
> >
> > -     ret = smu_cmn_wait_for_response(smu);
> > -     if (ret != 0x1) {
> > -             dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
> > -                    "SMU may be not in the right state!\n", ret);
> > -             if (ret != -ETIME)
> > -                     ret = -EIO;
> > -             return ret;
> > +     switch (reg_c2pmsg_90) {
> > +     case 0:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: I'm not done with your previous command!");
> > +             break;
> > +     case 1:
> > +             /* The SMU executed the command. It completed with a
> > +              * successful result.
> > +              */
> > +             break;
> > +     case 0xFF:
> > +             /* The SMU executed the command. It completed with a
> > +              * unsuccessful result.
> > +              */
> > +             break;
> > +     case 0xFE:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: unknown command: index:%d param:0x%08X message:%s",
> > +                                 msg_index, param, message);
> > +             break;
> > +     case 0xFD:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
> > +                                 msg_index, param, message);
> > +             break;
> > +     case 0xFC:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
> > +                                 msg_index, param, message);
> > +             break;
> > +     case 0xFB:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: I'm debugging!");
> > +             break;
> > +     default:
> > +             dev_err_ratelimited(adev->dev,
> > +                                 "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
> > +                                 reg_c2pmsg_90, msg_index, param, message);
> > +             break;
> > +     }
> > +}
> > +
> > +static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
>
> Same comment on naming - resp2errno?
> > +{
> > +     int res;
> > +
> > +     switch (reg_c2pmsg_90) {
> > +     case 0:
> > +             res = -ETIME;
> > +             break;
> > +     case 1:
> > +             res = 0;
> > +             break;
> > +     case 0xFF:
> > +             res = -EIO;
> > +             break;
> > +     case 0xFE:
> > +             res = -EOPNOTSUPP;
> > +             break;
> > +     case 0xFD:
> > +             res = -EIO;
> > +             break;
> > +     case 0xFC:
> > +             res = -EBUSY;
> > +             break;
> > +     case 0xFB:
> > +             res = -EIO;
> > +             break;
> > +     default:
> > +             res = -EIO;
> > +             break;
> >       }
> >
> > +     return res;
> > +}
> > +
> > +static void __smu_cmn_send_msg(struct smu_context *smu,
> > +                            u16 msg,
> > +                            u32 param)
> > +{
> > +     struct amdgpu_device *adev = smu->adev;
> > +
> >       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> >       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> >       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> > +}
> >
> > -     return 0;
> > +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > +                                  uint16_t msg_index,
> > +                                  uint32_t param)
> > +{
> > +     u32 reg;
> > +     int res;
> > +
> > +     if (smu->adev->in_pci_err_recovery)
> > +             return 0;
> > +
> > +     mutex_lock(&smu->message_lock);
> > +     reg = __smu_cmn_poll_stat(smu);
> > +     if (reg == 0 || reg == 0xFC) {
>
> The problem with 0xFC check is it could be the response of a previous
> message. It could mean that FW was busy when the prev message was sent,
> not now.
>
> There is a default case (value not in any of the predefined error
> codes), that should be considered here also. That happens sometimes and
> usually that means FW is in undefined state.
>
>
> > +             res = __smu_cmn_reg2errno(smu, reg);
> > +             goto Out;
>
> Label naming style, lower case?.
>
> > +     }
> > +     __smu_cmn_send_msg(smu, msg_index, param);
> > +     res = 0;
> > +Out:
> > +     mutex_unlock(&smu->message_lock);
> > +     return res;
> > +}
> > +
> > +int smu_cmn_wait_for_response(struct smu_context *smu)
> > +{
> > +     u32 reg;
> > +
> > +     reg = __smu_cmn_poll_stat(smu);
> > +     return __smu_cmn_reg2errno(smu, reg);
> >   }
> >
> >   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> > @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >                                   uint32_t param,
> >                                   uint32_t *read_arg)
> >   {
> > -     struct amdgpu_device *adev = smu->adev;
> > -     int ret = 0, index = 0;
> > +     int res, index;
> > +     u32 reg;
> >
> >       if (smu->adev->in_pci_err_recovery)
> >               return 0;
> > @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >               return index == -EACCES ? 0 : index;
> >
> >       mutex_lock(&smu->message_lock);
> > -     ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
> > -     if (ret)
> > -             goto out;
> > -
> > -     ret = smu_cmn_wait_for_response(smu);
> > -     if (ret != 0x1) {
> > -             if (ret == -ETIME) {
> > -                     dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
> > -                             smu_get_message_name(smu, msg), index, param);
> > -             } else {
> > -                     dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
> > -                             smu_get_message_name(smu, msg), index, param,
> > -                             ret);
> > -                     ret = -EIO;
> > -             }
> > -             goto out;
> > +     reg = __smu_cmn_poll_stat(smu);
> > +     if (reg == 0 || reg == 0xFC) {
>
> Same comments as for without_waiting case.
>
> > +             res = __smu_cmn_reg2errno(smu, reg);
> > +             __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>
> This precheck fail print is missing in without_waiting message.
>
> > +             goto Out; >     }
> > -
> > +     __smu_cmn_send_msg(smu, (uint16_t) index, param);
> > +     reg = __smu_cmn_poll_stat(smu);
> > +     res = __smu_cmn_reg2errno(smu, reg);
>
> Using smu_cmn_wait_for_response instead of these two makes the intent
> clearer - that we are waiting for the response.
>
> We need a print here as well if the message has failed.
>
> Thanks,
> Lijo
>
> >       if (read_arg)
> >               smu_cmn_read_arg(smu, read_arg);
> > -
> > -     ret = 0; /* 0 as driver return value */
> > -out:
> > +Out:
> >       mutex_unlock(&smu->message_lock);
> > -     return ret;
> > +     return res;
> >   }
> >
> >   int smu_cmn_send_smc_msg(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > index 9add5f16ff562a..16993daa2ae042 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > @@ -27,7 +27,8 @@
> >
> >   #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
> >   int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > -                                  uint16_t msg, uint32_t param);
> > +                                  uint16_t msg_index,
> > +                                  uint32_t param);
> >   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >                                   enum smu_message_type msg,
> >                                   uint32_t param,
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
