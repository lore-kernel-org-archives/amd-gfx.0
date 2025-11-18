Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97464CEDDA4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA6F10E4F8;
	Tue, 18 Nov 2025 16:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1OGM+qE";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C6510E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:50:43 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b9da0ae5763so465151a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763484643; x=1764089443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMBStLbmVj9D7fO/BG5wvPc03//LUMNICQd5R8DxF60=;
 b=N1OGM+qEGWSG59fxwyBGQghr9XjJuLbBuWRtmR9X2fuRVZRWtg55yLpo3vBY0ezREw
 5cFu8+cumqgl2j5fo4QvDHmYcA/7FnKldrCPAGYTMD/1lvSara08JDYXZsaQi2nL2Puz
 aMy4TYVTzOndbo9Npx7IepTHSlIKQcyf/OC8hFmPm8yXHhlgGWV5ArBZWSvqvz/SiomG
 jUYR66M3ZBAZs+uCYY3TAvkklRBqId9lrOQt/puKNYbSmZV5vICVgNbmjdUq8xGK9N2t
 GGujK4aLu7TFnwO/7wKZT2Wq6GLVyHcOpOljAx65HzGT2v4qHtjtA/RNxYZKmEIb1vti
 g4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763484643; x=1764089443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LMBStLbmVj9D7fO/BG5wvPc03//LUMNICQd5R8DxF60=;
 b=E0m82qxD+EC0wXF4mgx4IRFUqddE8B7BvHlbkISnF/HTEs39h+YcZXLEyXh9qqFAaM
 eIPBR577giQMQrAQhRz0O701J2dwsIG7TszYiEqyQKb9IGL4qlMVSUboxQdy5oJypfQs
 jcJzqrU2yVAaOBriBWXLbnP+9RWBgRH1cqfaJFC0DopwQ6TpinVxlmJ5eFJbr481x4Bz
 YOpx/7FIBxFLScYuJTqlpnSk3Y5rdFYkf7O4DP8Dw11ZDcAwY+s6MfkDvp2HfwI4Rusd
 kOFc9F1YO5RueK8CUHIKbTL4JwVBkxNX3qeWPCXvdPUcfbJ2swW9r89UnrBocZ3ObX7q
 HmwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3rP8kQ7CDYKj5xJnMUUBRs2pA3G3SsH+z9uXGOvlZ7ez1ivZY24Xmpsw0KHKulSxVBoouSQmq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxebqzNa3PX81kfcOvUDDe05kqEh5I9unNhTSnWcDniBzXug7KB
 VRnHOeX7V9o9Lx+pbQEeQ+enaD+Q8VNfGLzUKpwd4QjLJVIyrVU+nqb1xAEaOr7Y7KLtq3ZOkx8
 jfWHlgLqfoYh1EHEt6nmXmPRDEyvzkmDUXA==
X-Gm-Gg: ASbGncunTZupHflzihTYQXiX5oEL9RjrtdpYcwP8yyjPx9eN4FH00a9llpVzapV6Jab
 09AP/Z6GjBXQuVGUgzk2D2zOq12MJLXI/00IQNOnDRN2L8wFUXrqMhJH/J8Jbd/y3ZCw/ENzdot
 2EWoJsUPl7+y8Gcn+LAZsS2YMJTDokndxNqiQG8uaZjfFb0nfU+oE4RiUKYiet7umCefkVQBWLC
 s2AQQnDVlW4im8aJWCEjPE+4kTDiskGfqBBWke8bNycZHrvpS10dDsgjpjq8u0d0QF6IHygRyB7
 N9h5eg==
X-Google-Smtp-Source: AGHT+IH/B47gWp6ECTKeYV9s1ojU3nBgKBpd50KZtt0ruvLygZs6cKnfaLlNR7nSDQtxmKJDvFijU4D9EfJilZylvzE=
X-Received: by 2002:a05:7022:6885:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-11b4120a7cemr6364576c88.3.1763484643100; Tue, 18 Nov 2025
 08:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
 <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
 <CADnq5_PcVD-VVmx=83Mbv2+CTyJyXf5UmR2GB6OVahBK2ACAoA@mail.gmail.com>
 <84aa5815-4e33-43d0-91b0-c1f2bec06cc8@amd.com>
In-Reply-To: <84aa5815-4e33-43d0-91b0-c1f2bec06cc8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Nov 2025 11:50:30 -0500
X-Gm-Features: AWmQ_bkwvUoW0X846E3l828Khz29Wpm8q9a2SNYEEiT0m4_-BXOieXQu0l_PiRk
Message-ID: <CADnq5_MFS+4m77rKLhVffgp+K=VO8NoWO2iTSxvVw9ooyBY9Sw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Li, Chong(Alan)" <Chong.Li@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Horace" <Horace.Chen@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 18, 2025 at 9:57=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/18/25 15:43, Alex Deucher wrote:
> > On Tue, Nov 18, 2025 at 5:49=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Hi Chong,
> >>
> >> yeah and exactly that argumentation is not correct.
> >>
> >> We have to guarantee a min minimum response time and that is what the =
timeout is all about.
> >>
> >> And it doesn't matter if the available HW time is split between 1,2,4 =
or 8 virtual functions. The minimum reponse time we need to guarantee is st=
ill the same, it's just that the available HW time is lowered.
> >>
> >> So as long as we don't have an explicit customer request which asks fo=
r longer default timeouts this change is rejected.
> >
> > I think the change makes sense.  It needs to be longer to compensate
> > for the world switch latency.  0.5 seconds of runtime is probably too
> > short for many larger workloads.
>
> The calculation that you have a 0.5 second timeout because the HW is shar=
ed among 4 VF doesn't make sense.
>
> It's just that each VF has 1/4 of the calculation power of the PF, but we=
 also don't increase the timeout for slower physical HW either.
>

But in this case, it doesn't actually reflect the GPU time spent on
the job, it only reflects a percentage of it so it's not really an
apples to apples comparison with non-SR-IOV.  That said, from a wall
clock perspective, it does reflect the time spent even if you only got
a percentage of that time.

Alex

> The timeout is there to guarantee a certain response time and that comes =
from both customer requirements as well as requirements of the Linux memory=
 management.
>
> And at least the memory management doesn't care if you have a virtual fun=
ction or physical hardware, you have to complete all operations in a certai=
n time or otherwise the system can run into a panic during low memory situa=
tions.
>
> What could be is that we have customers who don't care about OOM situatio=
ns and want this longer timeout, but that is then on their own risk.
>
> We certainly shouldn't increase the timeout to something unreasonable jus=
t because some CI system is failing.
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >> On 11/18/25 11:08, Li, Chong(Alan) wrote:
> >>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>
> >>> Hi, Christian.
> >>>
> >>> what I mean is:
> >>> in sriov mode, when customer need limit timeout value ,
> >>> they should set the "lockup_timeout" according to the vf number they =
load.
> >>>
> >>>
> >>> Why:
> >>>
> >>> The real timeout value in sriov for each vf is " lockup_timeout / vf_=
number",
> >>>
> >>> As you said they want to limit the timeout to 2s,
> >>> when customer load 8vf, they should set the "lockup_timeout" to 16s, =
 4vf need set "lockup_timeout" to 8s.
> >>>
> >>>
> >>> (After we test, when value "lockup_timeout" set to 2s, the 4vf mode c=
an't work as each vf only get 0.5s)
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> Thanks,
> >>> Chong.
> >>>
> >>>
> >>>
> >>> -----Original Message-----
> >>> From: Koenig, Christian <Christian.Koenig@amd.com>
> >>> Sent: Tuesday, November 18, 2025 5:31 PM
> >>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> >>> Cc: Chen, Horace <Horace.Chen@amd.com>
> >>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds=
 timeout is not enough for sdma job
> >>>
> >>> Hi Chong,
> >>>
> >>> that is not a valid justification.
> >>>
> >>> What customer requirement is causing this SDMA timeout?
> >>>
> >>> When it is just your CI system then change the CI system.
> >>>
> >>> As long as you can't come up with a customer requirement this change =
is rejected.
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>> On 11/18/25 10:29, Li, Chong(Alan) wrote:
> >>>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>>
> >>>> Hi, Christian.
> >>>>
> >>>> In multiple vf mode( in our CI environment the vf number is 4), the =
timeout value is shared across all vfs.
> >>>> After timeout value change to 2s, each vf only get 0.5s, cause sdma =
ring timeout and trigger gpu reset.
> >>>>
> >>>>
> >>>> Thanks,
> >>>> Chong.
> >>>>
> >>>> -----Original Message-----
> >>>> From: Koenig, Christian <Christian.Koenig@amd.com>
> >>>> Sent: Tuesday, November 18, 2025 4:34 PM
> >>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.or=
g
> >>>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 second=
s timeout is not enough for sdma job
> >>>>
> >>>> Clear NAK to this patch.
> >>>>
> >>>> It is explicitely requested by customers that we only have a 2 secon=
d timeout.
> >>>>
> >>>> So you need a very good explanation to have that changed for SRIOV.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>> On 11/17/25 07:53, chong li wrote:
> >>>>> Signed-off-by: chong li <chongli2@amd.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
> >>>>>  2 files changed, 9 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> index 69c29f47212d..4ab755eb5ec1 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_se=
ttings(struct amdgpu_device *adev)
> >>>>>       int index =3D 0;
> >>>>>       long timeout;
> >>>>>       int ret =3D 0;
> >>>>> +     long timeout_default;
> >>>>>
> >>>>> -     /* By default timeout for all queues is 2 sec */
> >>>>> +     if (amdgpu_sriov_vf(adev))
> >>>>> +             timeout_default =3D msecs_to_jiffies(10000);
> >>>>> +     else
> >>>>> +             timeout_default =3D msecs_to_jiffies(2000);
> >>>>> +     /* By default timeout for all queues is 10 sec in sriov, 2 se=
c not in sriov*/
> >>>>>       adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_ti=
meout =3D
> >>>>> -             adev->video_timeout =3D msecs_to_jiffies(2000);
> >>>>> +             adev->video_timeout =3D timeout_default;
> >>>>>
> >>>>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> >>>>>               return 0;
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_drv.c
> >>>>> index f508c1a9fa2c..43bdd6c1bec2 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, a=
mdgpu_svm_default_granularity, uint
> >>>>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
> >>>>>   * Negative values mean infinity.
> >>>>>   *
> >>>>> - * By default(with no lockup_timeout settings), the timeout for al=
l queues is 2000.
> >>>>> + * By default(with no lockup_timeout settings), the timeout for al=
l queues is 10000 in sriov, 2000 not in sriov.
> >>>>>   */
> >>>>>  MODULE_PARM_DESC(lockup_timeout,
> >>>>> -              "GPU lockup timeout in ms (default: 2000. 0: keep de=
fault value. negative: infinity timeout), format: [single value for all] or=
 [GFX,Compute,SDMA,Video].");
> >>>>> +              "GPU lockup timeout in ms (default: 10000 in sriov, =
2000 not in sriov. 0: keep default value. negative: infinity timeout), form=
at: [single value for all] or [GFX,Compute,SDMA,Video].");
> >>>>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
> >>>>>                   sizeof(amdgpu_lockup_timeout), 0444);
> >>>>>
> >>>>
> >>>
> >>
>
