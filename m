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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034FC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC29A600D1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC29A600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8910B6E40B;
	Wed, 14 Jul 2021 15:23:09 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D586E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:23:07 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 75-20020a9d08510000b02904acfe6bcccaso2809450oty.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t/70aUZl7wF0XrwLQYvQslgIqmNiJsagBa03nLuBLn4=;
 b=WR0hPQ39bq2KkcFEfQTk8ZqdoUMXvuoT9s+utrPu1uQDXdWeNAbHei2ex/p7tCbFP3
 YVRGpVZCGJAygezQN+1H1XYPm5Op9YhcOcFetnSUE2h8FAg5Av7zFvTlD8eUT8da7GI4
 vrzGq7Xaz81DtiYNoiF0suURZUIO9LjQnrGQ+3Yg6rSrscmh6dojh5ECuv55YTBeD2zw
 94aH0H7nhJdMWDQC7nPMgFGKz+US7LjOei2yIcQLDA+pwvi27QFIORHjq6OTLnoW6Mas
 Ml/TbFswDp5MTsZxEz2J4VuE6a8JyY/9QJk0zLgfJSuRLgc2QhFoHIENFWRTDK9WMHAw
 tyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t/70aUZl7wF0XrwLQYvQslgIqmNiJsagBa03nLuBLn4=;
 b=RCMLjeyKRKhHi0+W4QmzIfoYvKkubrrUZEWrEU6Wzzz+Q8zVeGGYSqFDVoLvxFHpLh
 xLeVbVx+wG8ablsve9Q0ye9P/iTNDnLOCkPb+gPEcEMfV/fNXFN8gBPJQNuPu+Js6d4d
 Gsmvi3D9iKM4mLl0p54sGr6k5qhJaiUcsV4DaI5wdnatnidDpHayz6qXp9u2B9HLugMi
 LuNVNAIMk+MeLN60fEt6XvOvhcg/A2v/nQPzYSTo9D+eF6aHpzVh6RZu/gWwxUvmvBPr
 zX+MeD6hYf+MUz3v+8Oq/wStpNyiiFQZr9lybUgpAwp4UHdd1U9MQgVnGVyi/HHr1I14
 RcIQ==
X-Gm-Message-State: AOAM533whD7Kr+3a35z5a9kgHM5NbEmDQLpmfg4udq1pFXhXSyO9lIoD
 GyJjTw2OIp7kzpU2EpWesyfU2ExmRos0x5CehNU=
X-Google-Smtp-Source: ABdhPJwvw6NqOHSZp/YVmbqdkZ/IoKHIUKMDinF/COe7BDS3loM3nN04Iay3sPWNZXk+Gld972yHY3gRQo2Gjig5NyA=
X-Received: by 2002:a05:6830:14cd:: with SMTP id
 t13mr8650385otq.23.1626276187285; 
 Wed, 14 Jul 2021 08:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
 <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 11:22:56 -0400
Message-ID: <CADnq5_Nqx8JOUj2imXddGTxLCULSxunH6Oy_a2v20gyeMj6udQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Baluja, Aaron" <Aaron.Baluja@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Alimucaj,
 Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 13, 2021 at 10:01 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Tuikov, Luben <Luben.Tuikov@amd.com>
> > Sent: Wednesday, July 14, 2021 1:36 AM
> > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Alimucaj, Andi
> > <Anduil.Alimucaj@amd.com>; Baluja, Aaron <Aaron.Baluja@amd.com>
> > Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
> >
> > On 2021-07-13 3:07 a.m., Quan, Evan wrote:
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >> -----Original Message-----
> > >> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> > >> Sent: Monday, July 12, 2021 11:31 PM
> > >> To: amd-gfx@lists.freedesktop.org
> > >> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> > >> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > >> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
> > >>
> > >> This fixes a bug which if we probe a non-existing I2C device, and the
> > >> SMU returns 0xFF,
> > > [Quan, Evan] Do we have to probe I2C device via issuing commands to SMU
> > and check existence via SMU response?
> >
> > Yes, yes we do.
> >
> > > Is there other more friendly way?
> >
> > No, there isn't.
> >
> > > >from then on
> > >> we can never communicate with the SMU, because the code before this
> > >> patch reads and interprets 0xFF as a terminal error, and thus we
> > >> never write 0 into register 90 to clear the status (and subsequently
> > >> send a new command to the SMU.)
> > >>
> > >> It is not an error that the SMU returns status 0xFF. This means that
> > >> the SMU executed the last command successfully (execution status),
> > >> but the command result is an error of some sort (execution result),
> > >> depending on what the command was.
> > >>
> > >> When doing a status check of the SMU, before we send a new command,
> > >> the only status which precludes us from sending a new command is
> > >> 0--the SMU hasn't finished executing a previous command, and
> > >> 0xFC--the SMU is busy.
> > >>
> > >> This bug was seen as the following line in the kernel log,
> > >>
> > >> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the
> > >> right state!
> > > [Quan, Evan] This was designed to prevent failure scenario from ruin.
> > > Via this, we can prevent those SMU command/response related registers
> > overwritten.
> > > Then PMFW team can known which command invoked the first error.
> >
> > Sorry, this is not correct.
> >
> > The interface cannot block valid access to the SMU firmware, just because a
> > command executed successfully, but with a failed result, i.e. set a clock
> > frequency to such-and-such frequency was executed successfully by the
> > SMU, but the frequency wasn't able to be set as required--the SMU IS NOT
> > BLOCKED, but can execute more commands.
> [Quan, Evan]
> 1. First of all, if the response from SMU is not 1, it means SMU must detected something wrong.
> We(driver) should properly handle that. I do not think it's a good idea to silently ignore that and proceed more commands.
> 2. Please be noticed that many commands(SMU messages) have dependence with each other. It means even if the further command
> can be executed "successfully", it may be not executed in the expected way.
> >
> > If the PMFW team wants to know which command invoked "the first error",
> > they can check this explicitly, they can call smu_cmn_wait_for_response(),
> > just like the reset code does--see the reset code.
> [Quan, Evan] Per my knowledge gained during co-work with PMFW team, they expect no further driver-smu interaction(driver stops issuing command)
>  when something went wrong. As they highly rely on SMU internal statistics for their debugging and further interaction may ruin them.
> >
> > The way commit fcb1fe9c9e0031 modified the code, it blocks access to the
> > SMU for various other users of the SMU, not least of which is the I2C.
> [Quan, Evan] I'm wondering can we just list the I2C case as an exception. I means for the SMU command related with I2C we always assume the response is 1.
> For other commands, we just leave them as they are.

Maybe we need to just bubble this up to the callers and let each one
handle it as appropriate.  I don't think just throwing up our hands on
any error is the right thing to do.  The i2c case is a good example.
In other cases, we could probably just retry the transaction or just
ignore the error.

Alex


>
> BR
> Evan
> >
> > Regards,
> > Luben
> >
> > >
> > > BR
> > > Evan
> > >> when subsequent SMU commands, not necessarily related to I2C, were
> > >> sent to the SMU.
> > >>
> > >> This patch fixes this bug.
> > >>
> > >> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> > >> Cc: Evan Quan <evan.quan@amd.com>
> > >> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
> > >> before issuing message")
> > >> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > >> ---
> > >>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
> > >> +++++++++++++++++++------
> > >>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
> > >>  2 files changed, 152 insertions(+), 47 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > >> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > >> index c902fdf322c1be..775eb50a2e49a6 100644
> > >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > >> @@ -55,7 +55,7 @@
> > >>
> > >>  #undef __SMU_DUMMY_MAP
> > >>  #define __SMU_DUMMY_MAP(type)     #type
> > >> -static const char* __smu_message_names[] = {
> > >> +static const char * const __smu_message_names[] = {
> > >>    SMU_MESSAGE_TYPES
> > >>  };
> > >>
> > >> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct
> > smu_context
> > >> *smu,
> > >>    *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);  }
> > >>
> > >> -int smu_cmn_wait_for_response(struct smu_context *smu)
> > >> +/**
> > >> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> > >> + * smu: a pointer to SMU context
> > >> + *
> > >> + * Returns the status of the SMU, which could be,
> > >> + * 0, the SMU is busy with your previous command;
> > >> + * 1,    execution status: success, execution result: success;
> > >> + * 0xFF, execution status: success, execution result: failure;
> > >> + * 0xFE, unknown command;
> > >> + * 0xFD, valid command, but bad (command) prerequisites;
> > >> + * 0xFC, the command was rejected as the SMU is busy;
> > >> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> > >> + */
> > >> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
> > >>  {
> > >>    struct amdgpu_device *adev = smu->adev;
> > >> -  uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> > >> +  int timeout = adev->usec_timeout * 20;
> > >> +  u32 reg;
> > >>
> > >> -  for (i = 0; i < timeout; i++) {
> > >> -          cur_value = RREG32_SOC15(MP1, 0,
> > >> mmMP1_SMN_C2PMSG_90);
> > >> -          if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> > >> -                  return cur_value;
> > >> +  for ( ; timeout > 0; timeout--) {
> > >> +          reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> > >> +          if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> > >> +                  break;
> > >>
> > >>            udelay(1);
> > >>    }
> > >>
> > >> -  /* timeout means wrong logic */
> > >> -  if (i == timeout)
> > >> -          return -ETIME;
> > >> -
> > >> -  return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> > >> +  return reg;
> > >>  }
> > >>
> > >> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > >> -                               uint16_t msg, uint32_t param)
> > >> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> > >> +                                u32 reg_c2pmsg_90,
> > >> +                                int msg_index,
> > >> +                                u32 param,
> > >> +                                enum smu_message_type msg)
> > >>  {
> > >>    struct amdgpu_device *adev = smu->adev;
> > >> -  int ret;
> > >> +  const char *message = smu_get_message_name(smu, msg);
> > >>
> > >> -  ret = smu_cmn_wait_for_response(smu);
> > >> -  if (ret != 0x1) {
> > >> -          dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
> > >> "
> > >> -                 "SMU may be not in the right state!\n", ret);
> > >> -          if (ret != -ETIME)
> > >> -                  ret = -EIO;
> > >> -          return ret;
> > >> +  switch (reg_c2pmsg_90) {
> > >> +  case 0:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: I'm not done with your previous
> > >> command!");
> > >> +          break;
> > >> +  case 1:
> > >> +          /* The SMU executed the command. It completed with a
> > >> +           * successful result.
> > >> +           */
> > >> +          break;
> > >> +  case 0xFF:
> > >> +          /* The SMU executed the command. It completed with a
> > >> +           * unsuccessful result.
> > >> +           */
> > >> +          break;
> > >> +  case 0xFE:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: unknown command: index:%d
> > >> param:0x%08X message:%s",
> > >> +                              msg_index, param, message);
> > >> +          break;
> > >> +  case 0xFD:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: valid command, bad prerequisites:
> > >> index:%d param:0x%08X message:%s",
> > >> +                              msg_index, param, message);
> > >> +          break;
> > >> +  case 0xFC:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: I'm very busy for your command:
> > >> index:%d param:0x%08X message:%s",
> > >> +                              msg_index, param, message);
> > >> +          break;
> > >> +  case 0xFB:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: I'm debugging!");
> > >> +          break;
> > >> +  default:
> > >> +          dev_err_ratelimited(adev->dev,
> > >> +                              "SMU: response:0x%08X for index:%d
> > >> param:0x%08X message:%s?",
> > >> +                              reg_c2pmsg_90, msg_index, param,
> > >> message);
> > >> +          break;
> > >> +  }
> > >> +}
> > >> +
> > >> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
> > >> reg_c2pmsg_90)
> > >> +{
> > >> +  int res;
> > >> +
> > >> +  switch (reg_c2pmsg_90) {
> > >> +  case 0:
> > >> +          res = -ETIME;
> > >> +          break;
> > >> +  case 1:
> > >> +          res = 0;
> > >> +          break;
> > >> +  case 0xFF:
> > >> +          res = -EIO;
> > >> +          break;
> > >> +  case 0xFE:
> > >> +          res = -EOPNOTSUPP;
> > >> +          break;
> > >> +  case 0xFD:
> > >> +          res = -EIO;
> > >> +          break;
> > >> +  case 0xFC:
> > >> +          res = -EBUSY;
> > >> +          break;
> > >> +  case 0xFB:
> > >> +          res = -EIO;
> > >> +          break;
> > >> +  default:
> > >> +          res = -EIO;
> > >> +          break;
> > >>    }
> > >>
> > >> +  return res;
> > >> +}
> > >> +
> > >> +static void __smu_cmn_send_msg(struct smu_context *smu,
> > >> +                         u16 msg,
> > >> +                         u32 param)
> > >> +{
> > >> +  struct amdgpu_device *adev = smu->adev;
> > >> +
> > >>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> > >>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
> > >>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> > >> +}
> > >>
> > >> -  return 0;
> > >> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > >> +                               uint16_t msg_index,
> > >> +                               uint32_t param)
> > >> +{
> > >> +  u32 reg;
> > >> +  int res;
> > >> +
> > >> +  if (smu->adev->in_pci_err_recovery)
> > >> +          return 0;
> > >> +
> > >> +  mutex_lock(&smu->message_lock);
> > >> +  reg = __smu_cmn_poll_stat(smu);
> > >> +  if (reg == 0 || reg == 0xFC) {
> > >> +          res = __smu_cmn_reg2errno(smu, reg);
> > >> +          goto Out;
> > >> +  }
> > >> +  __smu_cmn_send_msg(smu, msg_index, param);
> > >> +  res = 0;
> > >> +Out:
> > >> +  mutex_unlock(&smu->message_lock);
> > >> +  return res;
> > >> +}
> > >> +
> > >> +int smu_cmn_wait_for_response(struct smu_context *smu) {
> > >> +  u32 reg;
> > >> +
> > >> +  reg = __smu_cmn_poll_stat(smu);
> > >> +  return __smu_cmn_reg2errno(smu, reg);
> > >>  }
> > >>
> > >>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> > @@
> > >> -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
> > >> smu_context *smu,
> > >>                                uint32_t param,
> > >>                                uint32_t *read_arg)
> > >>  {
> > >> -  struct amdgpu_device *adev = smu->adev;
> > >> -  int ret = 0, index = 0;
> > >> +  int res, index;
> > >> +  u32 reg;
> > >>
> > >>    if (smu->adev->in_pci_err_recovery)
> > >>            return 0;
> > >> @@ -136,31 +251,20 @@ int
> > smu_cmn_send_smc_msg_with_param(struct
> > >> smu_context *smu,
> > >>            return index == -EACCES ? 0 : index;
> > >>
> > >>    mutex_lock(&smu->message_lock);
> > >> -  ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
> > >> param);
> > >> -  if (ret)
> > >> -          goto out;
> > >> -
> > >> -  ret = smu_cmn_wait_for_response(smu);
> > >> -  if (ret != 0x1) {
> > >> -          if (ret == -ETIME) {
> > >> -                  dev_err(adev->dev, "message: %15s (%d) \tparam:
> > >> 0x%08x is timeout (no response)\n",
> > >> -                          smu_get_message_name(smu, msg), index,
> > >> param);
> > >> -          } else {
> > >> -                  dev_err(adev->dev, "failed send message: %15s (%d)
> > >> \tparam: 0x%08x response %#x\n",
> > >> -                          smu_get_message_name(smu, msg), index,
> > >> param,
> > >> -                          ret);
> > >> -                  ret = -EIO;
> > >> -          }
> > >> -          goto out;
> > >> +  reg = __smu_cmn_poll_stat(smu);
> > >> +  if (reg == 0 || reg == 0xFC) {
> > >> +          res = __smu_cmn_reg2errno(smu, reg);
> > >> +          __smu_cmn_reg_print_error(smu, reg, index, param, msg);
> > >> +          goto Out;
> > >>    }
> > >> -
> > >> +  __smu_cmn_send_msg(smu, (uint16_t) index, param);
> > >> +  reg = __smu_cmn_poll_stat(smu);
> > >> +  res = __smu_cmn_reg2errno(smu, reg);
> > >>    if (read_arg)
> > >>            smu_cmn_read_arg(smu, read_arg);
> > >> -
> > >> -  ret = 0; /* 0 as driver return value */
> > >> -out:
> > >> +Out:
> > >>    mutex_unlock(&smu->message_lock);
> > >> -  return ret;
> > >> +  return res;
> > >>  }
> > >>
> > >>  int smu_cmn_send_smc_msg(struct smu_context *smu, diff --git
> > >> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > >> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > >> index 9add5f16ff562a..16993daa2ae042 100644
> > >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > >> @@ -27,7 +27,8 @@
> > >>
> > >>  #if defined(SWSMU_CODE_LAYER_L2) ||
> > defined(SWSMU_CODE_LAYER_L3)
> > >> || defined(SWSMU_CODE_LAYER_L4)
> > >>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> > >> -                               uint16_t msg, uint32_t param);
> > >> +                               uint16_t msg_index,
> > >> +                               uint32_t param);
> > >>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> > >>                                enum smu_message_type msg,
> > >>                                uint32_t param,
> > >> --
> > >> 2.32.0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
