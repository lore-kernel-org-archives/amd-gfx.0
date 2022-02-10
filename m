Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F072C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 16:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB23A10E89E;
	Thu, 10 Feb 2022 16:00:01 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD7610E89E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 16:00:00 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id u13so6357409oie.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xAZ8hSQabdWVfDqV6C9G4XbP0GJRPNaaTYG8EG4DVs0=;
 b=Y45L+buD/2L6ldNskQzavPL07YTEuG3lHWzBb73xFSOV1wflIXo5g0QFGMTvKKOdOZ
 W7ia5wvBKzSJ1USv2OI3fwtp0Co0k0vyYa1hP6uaMz1FfuZxZ0uzMdH6Zc4eFa28yFHP
 wdZe12+jlCugCrf6OyAXEkvYKWoFJqvKGTw0LqBg8ekx+nwfIjlbSNUij+aXcRMx77ig
 LYM1xnoW68vIFVT3SvO25HPStkT57WbasS6q4tHyySiGKzaYS//ECseiZ8OCJ5W1R+kx
 3+InYmdRueI4o7tcyV2XiqpjGRLAcZyhpnMZ67J9CByAOWvywQKX5LH77B5sjkxDKabn
 5uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xAZ8hSQabdWVfDqV6C9G4XbP0GJRPNaaTYG8EG4DVs0=;
 b=Y2DVFLthsdZCB9GEdtKVEoCALDOvLsXloipbK34097UeZKinxFRag7lIaJdZ8ACl5q
 9jZC5m1eWC6bl1zIsmm3wUR1m6KhHTjYLiwcFGiVfUBl8aJKjivWIuQsg1dQrH8xsf/x
 tQ4vwIjROFMk+J18WFSkOCUKZNbpDhJ2z/NGkHdrPFGrDFvhlVZFLTfhKTO3nhtB2WfJ
 yvOLUMyHgceUgxWEhF+X7y25sN3eaBd8cUzJ+Y4aeV7phLxOdKnXEhL2lnJC/ELO7HU6
 +u8lDlLczcJZh1LgIiRltwZUA3X+MJaf2yfKuhlaQKpeyMdUmTokA63lZlsriaYE/lhr
 bwRA==
X-Gm-Message-State: AOAM532uBsKM10NqyeOG5SZGB02e9lsYULALg+qLu089y2yBD14k3VQ5
 oi3hDBl0X2vD97xwajVIkuqJGE8MKrM+C1Iqgwk=
X-Google-Smtp-Source: ABdhPJwt1/Jj1tgI7lUYP5sHwhQxaLxpz9qzPb9LqRHiGIP1m5p35goDqz6EziXZEVWLWA6PxmHYL3f8t6B5Cqh4iXg=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr1270427oiw.132.1644508799628; 
 Thu, 10 Feb 2022 07:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
 <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
 <d2a93513-c199-c4f4-7564-da58f3bb2120@amd.com>
 <2c30cea6-7db0-92e9-b884-5967a9b95bd7@amd.com>
 <ef597684-c5e7-cea5-a502-ab1434b0094d@gmail.com>
 <3c2e5ce5-5535-017f-0ffa-a89e219050f4@amd.com>
In-Reply-To: <3c2e5ce5-5535-017f-0ffa-a89e219050f4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Feb 2022 10:59:48 -0500
Message-ID: <CADnq5_NQrLD88EbLY7WJqf_TZgErmKk_zFr5RX3Vfug_nNTfow@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 9:11 AM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
>
>
> On 2/10/2022 3:05 PM, Christian K=C3=B6nig wrote:
> > Am 10.02.22 um 14:18 schrieb Sharma, Shashank:
> >>
> >>
> >> On 2/10/2022 8:38 AM, Christian K=C3=B6nig wrote:
> >>> Am 10.02.22 um 08:34 schrieb Somalapuram, Amaranath:
> >>>>
> >>>> On 2/10/2022 12:39 PM, Christian K=C3=B6nig wrote:
> >>>>> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
> >>>>>>
> >>>>>> On 2/9/2022 1:17 PM, Christian K=C3=B6nig wrote:
> >>>>>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
> >>>>>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
> >>>>>>>> <Amaranath.Somalapuram@amd.com> wrote:
> >>>>>>>>> Dump the list of register values to trace event on GPU reset.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Somalapuram Amaranath
> >>>>>>>>> <Amaranath.Somalapuram@amd.com>
> >>>>>>>>> ---
> >>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
> >>>>>>>>> ++++++++++++++++++++-
> >>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19
> >>>>>>>>> +++++++++++++++++++
> >>>>>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> index 1e651b959141..057922fb7e37 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct
> >>>>>>>>> amdgpu_device *adev,
> >>>>>>>>>          return r;
> >>>>>>>>>   }
> >>>>>>>>>
> >>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> >>>>>>>>> +{
> >>>>>>>>> +       int i;
> >>>>>>>>> +       uint32_t reg_value[128];
> >>>>>>>>> +
> >>>>>>>>> +       for (i =3D 0; adev->reset_dump_reg_list[i] !=3D 0; i++)=
 {
> >>>>>>>>> +               if (adev->asic_type >=3D CHIP_NAVI10)
> >>>>>>>> This check should be against CHIP_VEGA10.  Also, this only
> >>>>>>>> allows for
> >>>>>>>> GC registers.  If we wanted to dump other registers, we'd need a
> >>>>>>>> different macro.  Might be better to just use RREG32 here for
> >>>>>>>> everything and then encode the full offset using
> >>>>>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to
> >>>>>>>> think
> >>>>>>>> about how to handle gfxoff in this case.  gfxoff needs to be
> >>>>>>>> disabled
> >>>>>>>> or we'll hang the chip if we try and read GC or SDMA registers v=
ia
> >>>>>>>> MMIO which will adversely affect the hang signature.
> >>>>>>>
> >>>>>>> Well this should execute right before a GPU reset, so I think it
> >>>>>>> shouldn't matter if we hang the chip or not as long as the read
> >>>>>>> comes back correctly (I remember a very long UVD debug session
> >>>>>>> because of this).
> >>>>>>>
> >>>>>>> But in general I agree, we should just use RREG32() here and
> >>>>>>> always encode the full register offset.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Christian.
> >>>>>>>
> >>>>>> Can I use something like this:
> >>>>>>
> >>>>>> +                       reg_value[i] =3D
> >>>>>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
> >>>>>> + [adev->reset_dump_reg_list[i][1]]
> >>>>>> + [adev->reset_dump_reg_list[i][2]])
> >>>>>> +                                 + adev->reset_dump_reg_list[i][3=
]);
> >>>>>>
> >>>>>> ip --> adev->reset_dump_reg_list[i][0]
> >>>>>>
> >>>>>> inst --> adev->reset_dump_reg_list[i][1]
> >>>>>>
> >>>>>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
> >>>>>>
> >>>>>> reg --> adev->reset_dump_reg_list[i][3]
> >>>>>
> >>>>> No, that won't work.
> >>>>>
> >>>>> What you need to do is to use the full 32bit address of the
> >>>>> register. Userspace can worry about figuring out which ip,
> >>>>> instance, base and reg to resolve into that address.
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>> Thanks Christian.
> >>>>
> >>>> should I consider using gfxoff like below code or not required:
> >>>> amdgpu_gfx_off_ctrl(adev, false);
> >>>> amdgpu_gfx_off_ctrl(adev, true);
> >>>
> >>> That's a really good question I can't fully answer.
> >>>
> >>> I think we don't want that because the GPU is stuck when the dump is
> >>> made, but better let Alex comment as well.
> >>>
> >>> Regards,
> >>> Christian.
> >>
> >>
> >> I had a quick look at the function amdgpu_gfx_off_ctrl, and it locks
> >> this mutex internally:
> >> mutex_lock(&adev->gfx.gfx_off_mutex);
> >>
> >> and the reference state is tracked in:
> >> adev->gfx.gfx_off_state
> >>
> >> We can do something like this maybe:
> >> - If (adev->gfx_off_state =3D=3D 0) {
> >>   trylock(gfx_off_mutex)
> >>   read_regs_now;
> >>   unlock_mutex();
> >> }
> >>
> >> How does it sounds ?
> >
> > As far as I know that won't work. GFX_off is only disabled intentionall=
y
> > in very few places.
> >
> > So we will probably never get a register trace with that.
> >
>
> Ok, I don't know much about this feature, but due to the name I was
> udner the impression that gfx_off will be mostly disabled. But if it is
> hardly ever disabled, we need more infomrmation about it first, like
> when is this disabled and why ?
>
> Alex ?

gfxoff is enabled most of the time.  The only times we disable it are
for certain features (reading gfx or sdma MMIO registers, using SQTT,
etc.).  The two main cases where it would get disabled are calling the
READ_MMR query to the INFO ioctl and if you change the power state to
a profiling mode (either via sysfs or the context ioctl).  If you
don't disable gfx off and you access a register via MMIO, the GFX
block will hang.  So depending on the the nature of the hang, gfxoff
may or may not be a problem.  E.g., if the hang is caused by VCN or
some power management thing gfxoff may still kick in and power down
the gfx block.  If the gfx block itself is hung, then most likely
gfxoff would not be active since the gfx block is active (and hung).
So if we didn't disable gfxoff and it is active, and then we try and
read the registers, we'll hang the gfx block.  That's probably fine
since we'll be reseting the GPU anyway, but it will mean any registers
in the dump will be worthless.

Alex

>
> - Shashank
>
> > Regards,
> > Christian.
> >
> >>
> >> - Shashank
> >>>
> >>>>
> >>>>
> >>>> Regards,
> >>>>
> >>>> S.Amarnath
> >>>>>>
> >>>>>> which requires 4 values in user space for each register.
> >>>>>>
> >>>>>> using any existing macro like RREG32_SOC15** will not be able to
> >>>>>> pass proper argument from user space (like ip##_HWIP or
> >>>>>> reg##_BASE_IDX)
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>>> + reg_value[i] =3D RREG32_SOC15_IP(GC,
> >>>>>>>>> adev->reset_dump_reg_list[i]);
> >>>>>>>>> +               else
> >>>>>>>>> +                       reg_value[i] =3D
> >>>>>>>>> RREG32(adev->reset_dump_reg_list[i]);
> >>>>>>>>> +       }
> >>>>>>>>> +
> >>>>>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list,
> >>>>>>>>> reg_value, i);
> >>>>>>>>> +
> >>>>>>>>> +       return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle=
,
> >>>>>>>>>                           struct amdgpu_reset_context
> >>>>>>>>> *reset_context)
> >>>>>>>>>   {
> >>>>>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct
> >>>>>>>>> list_head *device_list_handle,
> >>>>>>>>> tmp_adev->gmc.xgmi.pending_reset =3D false;
> >>>>>>>>>                                  if
> >>>>>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
> >>>>>>>>>                                          r =3D -EALREADY;
> >>>>>>>>> -                       } else
> >>>>>>>>> +                       } else {
> >>>>>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
> >>>>>>>>>                                  r =3D amdgpu_asic_reset(tmp_ad=
ev);
> >>>>>>>>> +                       }
> >>>>>>>>>
> >>>>>>>>>                          if (r) {
> >>>>>>>>> dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for
> >>>>>>>>> drm dev, %s",
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >>>>>>>>> index d855cb53c7e0..3fe33de3564a 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >>>>>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
> >>>>>>>>>                        __entry->seqno)
> >>>>>>>>>   );
> >>>>>>>>>
> >>>>>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
> >>>>>>>>> +           TP_PROTO(long *address, uint32_t *value, int length=
),
> >>>>>>>>> +           TP_ARGS(address, value, length),
> >>>>>>>>> +           TP_STRUCT__entry(
> >>>>>>>>> +                            __array(long, address, 128)
> >>>>>>>>> +                            __array(uint32_t, value, 128)
> >>>>>>>>> +                            __field(int, len)
> >>>>>>>>> +                            ),
> >>>>>>>>> +           TP_fast_assign(
> >>>>>>>>> + memcpy(__entry->address, address, 128);
> >>>>>>>>> +                          memcpy(__entry->value, value, 128);
> >>>>>>>>> +                          __entry->len =3D length;
> >>>>>>>>> +                          ),
> >>>>>>>>> +           TP_printk("amdgpu register dump offset: %s value:
> >>>>>>>>> %s ",
> >>>>>>>>> + __print_array(__entry->address, __entry->len, 8),
> >>>>>>>>> + __print_array(__entry->value, __entry->len, 8)
> >>>>>>>>> +                    )
> >>>>>>>>> +);
> >>>>>>>>> +
> >>>>>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
> >>>>>>>>>   #endif
> >>>>>>>>>
> >>>>>>>>> --
> >>>>>>>>> 2.25.1
> >>>>>>>>>
> >>>>>>>
> >>>>>
> >>>
> >
