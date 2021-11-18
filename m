Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F57C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2526128C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA2526128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E7F6E922;
	Thu, 18 Nov 2021 14:25:33 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCAC6E922
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:25:32 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 v15-20020a9d604f000000b0056cdb373b82so11177738otj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 06:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K5cS8DuuzCfgwlCmvzOXyRqDw9Sji1WX6wcOGd+Qb9I=;
 b=J5Qg5LdAWBWh5mBpdBRj9lU35Xq2Lf9RRgMLMABXJDM/8g+0z9g1BAt6HhSs+SO2Ou
 mcvfddn+6R4tfe+x21OeJGn7VVn4O3NhqjLRntm3vYZNsmY915g45V6OCurxD8SngjjP
 aFT/xtVFKIvvCU5XH9fL1H2kg45KBibcXJsBwD+pbuZMj2mNtGDefYdYACKrNDTI9y7Q
 Ym62jHytejlrXxoGCSGygt+EX6OQBNEzWz878DhErZBn1z6PD+gVhz9t0eUb1dDTzjlA
 kRxd3TxI0A2C2ulQyaF9+er8kgZtmfUo/XPAwH3/FakAU99Z+7lyIQ/Zz9P+A1be4hVk
 VQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K5cS8DuuzCfgwlCmvzOXyRqDw9Sji1WX6wcOGd+Qb9I=;
 b=4oD2lmtcXw3QcZ09qY7rble/4GaUwcTlcAAYKQpt9o8LPsr4ffoCjIrY0A5+86Jx4q
 ZS1El5tnlO8YMjhcgMGfmnIPMyOY+HD05lCPIPmy7gRH3ZfOMYkBh9F4dInjxwH4GQG3
 SX1ehR8ek7x0Winb22IejKhCvXYO/pW0aloKbyj17uuYEiGO7ZFrRcZGBa0xOp2pYcb1
 S1bm4se89mo+RAm2cj4m9NmNwUjysmcsLUil78Q+5+Mr4F9cTJ4eokupCdQwSLes71VA
 TzZiA8iIV3Dtfh2SArCt0lpJgvjMKmDeL0n2CG/n9tKnGnaEQ7MXp1m/IFzg5T6ZAMfE
 sUpQ==
X-Gm-Message-State: AOAM531fZ5+GjG+tXL/tqbKKHYqrBYoC2sxdadpfHxhnc8n0OCgnaThB
 VSbuhcEmJtpQBnJpNX61/u07swaaxLsV1Mwcph4=
X-Google-Smtp-Source: ABdhPJzTOLy8g7PPeUAjQX8ZxUfRRXbtTS74Ibk9bcqAKFeKUx6F2UvZHW5Y9bAHFIEnAjobzBNnKr52s7redLFNLdQ=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr22095908otn.299.1637245531295; 
 Thu, 18 Nov 2021 06:25:31 -0800 (PST)
MIME-Version: 1.0
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
In-Reply-To: <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Nov 2021 09:25:18 -0500
Message-ID: <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 9:15 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 11/18/2021 7:41 PM, Christian K=C3=B6nig wrote:
> > Am 18.11.21 um 15:09 schrieb Lazar, Lijo:
> >> On 11/18/2021 7:36 PM, Alex Deucher wrote:
> >>> On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com>
> >>> wrote:
> >>>>
> >>>> [Public]
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>>> Sent: Thursday, November 18, 2021 4:01 PM
> >>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
> >>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> >>>>> <Ray.Huang@amd.com>
> >>>>> Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspe=
nd
> >>>>> aborted
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 11/18/2021 12:32 PM, Prike Liang wrote:
> >>>>>> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
> >>>>>> suspend to keep AMDGPU in a clean reset state and that can avoid
> >>>>>> re-initialize device improperly error.
> >>>>>>
> >>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> >>>>>> ---
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
> >>>>> +++++++++++++++++++
> >>>>>>    3 files changed, 24 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> index b85b67a..8bd9833 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
> >>>>>>      bool                            in_s3;
> >>>>>>      bool                            in_s4;
> >>>>>>      bool                            in_s0ix;
> >>>>>> +   bool                            pm_completed;
> >>>>>
> >>>>> PM framework maintains separate flags, why not use the same?
> >>>>>
> >>>>>           dev->power.is_suspended =3D false;
> >>>>>           dev->power.is_noirq_suspended =3D false;
> >>>>>           dev->power.is_late_suspended =3D false;
> >>>>>
> >>>>
> >>>> Thanks for pointing it out and I miss that flag. In this case we can
> >>>> use the PM flag is_noirq_suspended for checking AMDGPU device
> >>>> whether is finished suspend.
> >>>>
> >>>>> BTW, Alex posted a patch which does similar thing, though it tries
> >>>>> reset if
> >>>>> suspend fails.
> >>>>>
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flore.kernel.org%2Fall%2FDM6PR12MB26195F8E099407B4B6966FEBE4999%40&amp;data=
=3D04%7C01%7Clijo.lazar%40amd.com%7C79c861fcfccc4f2cc45d08d9aa9d61f0%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637728415203834017%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000&amp;sdata=3DgGnctl8rlNTj6o02hlE06og3RCA%2BQP37B3ejsZSxPdM%3D&amp;rese=
rved=3D0
> >>>>>
> >>>>> DM6PR12MB2619.namprd12.prod.outlook.com/
> >>>>>
> >>>>> If that reset also failed, then no point in another reset, or keep
> >>>>> it as part of
> >>>>> resume.
> >>>>>
> >>>>
> >>>> Alex's patch seems always do the ASIC reset at the end of AMDGPU
> >>>> device, but that may needn't on the normal AMDGPU device suspend.
> >>>> However, this patch shows that can handle the system suspend aborted
> >>>> after AMDGPU suspend case well, so now seems we only need take care
> >>>> suspend abort case here.
> >>>>
> >>>
> >>> Yeah, I was thinking we'd take this patch rather than mine to minimiz=
e
> >>> the number of resets.
> >>>
> >>
> >> Wondering if suspend fails whether there is a need to call resume. It
> >> may not get to resume() to do a reset, that needs to be checked.
> >
> > I would rather do it so that we reset the ASIC during resume when we
> > detect that the hardware is in a bad state.
> >
> > This way it should also work with things like kexec and virtualization.
>
> I was thinking from the power framework perspective. If the device's
> suspend() callback returns failure, why would the framework needs to
> call a resume() on that device.

The device's suspend callback succeeds, but some other device or event
in the system causes the overall suspend to abort.  As such the GPU is
never powered off by the platform so it's left in a partially
initialized state.  The system then calls the resume() callbacks for
all of the devices that were previously suspended to bring them back
to a working system.  GPU reset is just a convenient way to get the
device back into a known good state.  Unfortunately, I'm not sure if
there is a good way to detect whether the GPU is in a known good state
or not until we try and re-init the IPs and at that point the IPs are
not fully initialized so it's complex to try and unwind that, reset,
and try again.  It's probably easiest to just reset the GPU on resume
all the time.  If the GPU was powered down, the reset should work fine
since we are resetting a GPU that just came out of reset.  If the GPU
was not powered down, the reset will put the GPU into a known good
state.

Alex

>
> Thanks,
> Lijo
>
> >
> > Regards,
> > Christian.
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>
> >>> Alex
> >>>
> >>>
> >>>>> Thanks,
> >>>>> Lijo
> >>>>>
> >>>>>>
> >>>>>>      atomic_t                        in_gpu_reset;
> >>>>>>      enum pp_mp1_state               mp1_state;
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> index ec42a6f..a12ed54 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
> >>>>> *dev, bool fbcon)
> >>>>>>      if (adev->in_s0ix)
> >>>>>>              amdgpu_gfx_state_change_set(adev,
> >>>>> sGpuChangeState_D0Entry);
> >>>>>>
> >>>>>> +   if (!adev->pm_completed) {
> >>>>>> +           dev_warn(adev->dev, "suspend aborted will do asic
> >>>>>> reset\n");
> >>>>>> +           amdgpu_asic_reset(adev);
> >>>>>> +   }
> >>>>>>      /* post card */
> >>>>>>      if (amdgpu_device_need_post(adev)) {
> >>>>>>              r =3D amdgpu_device_asic_init(adev); diff --git
> >>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> index eee3cf8..9f90017 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
> >>>>> device *dev)
> >>>>>>      return r;
> >>>>>>    }
> >>>>>>
> >>>>>> +/*
> >>>>>> + * Actually the PM suspend whether is completed should be confirm=
ed
> >>>>>> + * by checking the sysfs
> >>>>>> +sys/power/suspend_stats/failed_suspend.However,
> >>>>>> + * in this function only check the AMDGPU device whether is
> >>>>>> suspended
> >>>>>> + * completely in the system-wide suspend process.
> >>>>>> + */
> >>>>>> +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
> >>>>>> +   struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>>>>> +   struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >>>>>> +
> >>>>>> +   dev_dbg(dev, "amdgpu suspend completely.\n");
> >>>>>> +   adev->pm_completed =3D true;
> >>>>>> +
> >>>>>> +   return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>    static int amdgpu_pmops_resume(struct device *dev)
> >>>>>>    {
> >>>>>>      struct drm_device *drm_dev =3D dev_get_drvdata(dev); @@ -2181=
,6
> >>>>>> +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
> >>>>>>      r =3D amdgpu_device_resume(drm_dev, true);
> >>>>>>      if (amdgpu_acpi_is_s0ix_active(adev))
> >>>>>>              adev->in_s0ix =3D false;
> >>>>>> +   adev->pm_completed =3D false;
> >>>>>>      return r;
> >>>>>>    }
> >>>>>>
> >>>>>> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
> >>>>> =3D {
> >>>>>>      .runtime_suspend =3D amdgpu_pmops_runtime_suspend,
> >>>>>>      .runtime_resume =3D amdgpu_pmops_runtime_resume,
> >>>>>>      .runtime_idle =3D amdgpu_pmops_runtime_idle,
> >>>>>> +   .suspend_noirq =3D amdgpu_pmops_noirq_suspend,
> >>>>>>    };
> >>>>>>
> >>>>>>    static int amdgpu_flush(struct file *f, fl_owner_t id)
> >>>>>>
> >
