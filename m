Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1176FCEDD9B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 14:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606AF10E4D5;
	Tue, 18 Nov 2025 14:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q4j6ue7M";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E7B10E4D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 14:44:06 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-bc2c9a771b5so491746a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763477045; x=1764081845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQpwi3Cs0HkS8bWfje3kkey8rsq6JEQVyZx2XUd+Zy8=;
 b=Q4j6ue7M3X8Q1HJjZYzYgUvit3MFZal2iOC2/G59+Pwsi8hvdwJ+klkskbKITpxjXy
 8h5NnxG9l5akyQZ9Mgfxt8b9MkNaBnIFQjSL9W/lmzHYngzIVbvEVgSNQSczaZ4vvTAq
 e9vv++BPg42agcHnYHMtnHjhGPb2XeKjcAEWhjwXSxgFKlbk07Hh/XYoVSRpJdRi+One
 Cy26zI75t3+qDI6BR3vB9PovZVMBnUnTh49ZpMcmel3Be7w2MvTu9s7WwtnrWlHnT+4p
 WZmQFn6auHxiuypJaBXjenOa6/NgjgAW6Gz5R9ae40dmSwd3sx+YOdfzhQFry8r43XI0
 lHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477045; x=1764081845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bQpwi3Cs0HkS8bWfje3kkey8rsq6JEQVyZx2XUd+Zy8=;
 b=wKGZOYk8p4pKZVz2SvhjBfoGv5+4ysjrSPz7XXiKxAUaoppmFWbJ4Pod6kcscP/wmb
 7h2u5pwr5savyID4TROxcsulP+ArJTaYZs08N3mcF0mWwG2CK76mDm2q4zsLM/z8grCr
 nNuS2/QiOPdr8Hcu87IEtl2/uVL3PzW1mn/ljoPAYiMySSqOP1OutgSlXGGiSxZ75cyz
 iZGoA9ZycMKmoo2oHI/sfdgCn9B9qhFZUMdIFbbdhd3BStc3OyGh+vldiya89rnQtk+v
 QgX/CKmicLuMe2zvPF3GuUHZYT0PrQ9WzUu/U/tY002iJ/S03kBkaBv7OsdpnSBCyaHL
 qg5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT0Q2EGMAgERtNJdZ7APnrEgwKxRsNmxkxTFRs4t4nqT3/HPzQt9FjN4bf7/vaZJJlVp/Tryyb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjIv8/8JZYPJZnqqsv8TD+R4IAZ/j6v/gVNZOkvLOBhn1ItKQX
 oOerjB9FKTZRRoxRb1Tw/cj/CCVpUj6quEcnKyj3Y9IG6I+gcIRD0c4kEI+wr8rjfabxN42anH/
 1mYdEYdzfGEwHLIEG2Bsvm/JrCMlOIOU=
X-Gm-Gg: ASbGncuKvJoTkVmEChZvzgvknuY+9kcR3ifwfWRHUaM5PEr3/xsH9XKE6be/w5FxjdM
 FWITS2nbszfKYwxaLAAc30r9vlmNb6U84ZzfFVlVmcpqqKmuG+w1QxE+qj1EmhgmIAVOJe29inB
 MHccLxXH6ypawMbm0p3kp4j80AxosndEGXLa6LqTjlp4v38k5USqKNtcJTMcaW/0SdYMmlrtjrC
 vlj9PZ/o949a5xt7FX+EjQsCyNQ7Y2H1Vfk5OXJAA4lXbdL/jFQVaoWcC7U
X-Google-Smtp-Source: AGHT+IF4XObM1UkzU10C/4F0qAI4mbGgpIO4Ys/SE46CLgFpn3qL+xGIjQuFRULub+qAtIFAQt9/QRvi/K3fLiVg82U=
X-Received: by 2002:a05:7022:6885:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-11b4120a7cemr6235892c88.3.1763477045419; Tue, 18 Nov 2025
 06:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
 <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
In-Reply-To: <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Nov 2025 09:43:54 -0500
X-Gm-Features: AWmQ_bkBQzue9kfBxNCC4NsX6YSz-gDr2GZ4isFe1T483bhi-k25rbGgCaE9hqY
Message-ID: <CADnq5_PcVD-VVmx=83Mbv2+CTyJyXf5UmR2GB6OVahBK2ACAoA@mail.gmail.com>
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

On Tue, Nov 18, 2025 at 5:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Chong,
>
> yeah and exactly that argumentation is not correct.
>
> We have to guarantee a min minimum response time and that is what the tim=
eout is all about.
>
> And it doesn't matter if the available HW time is split between 1,2,4 or =
8 virtual functions. The minimum reponse time we need to guarantee is still=
 the same, it's just that the available HW time is lowered.
>
> So as long as we don't have an explicit customer request which asks for l=
onger default timeouts this change is rejected.

I think the change makes sense.  It needs to be longer to compensate
for the world switch latency.  0.5 seconds of runtime is probably too
short for many larger workloads.

Alex

>
> Regards,
> Christian.
>
> On 11/18/25 11:08, Li, Chong(Alan) wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi, Christian.
> >
> > what I mean is:
> > in sriov mode, when customer need limit timeout value ,
> > they should set the "lockup_timeout" according to the vf number they lo=
ad.
> >
> >
> > Why:
> >
> > The real timeout value in sriov for each vf is " lockup_timeout / vf_nu=
mber",
> >
> > As you said they want to limit the timeout to 2s,
> > when customer load 8vf, they should set the "lockup_timeout" to 16s,  4=
vf need set "lockup_timeout" to 8s.
> >
> >
> > (After we test, when value "lockup_timeout" set to 2s, the 4vf mode can=
't work as each vf only get 0.5s)
> >
> >
> >
> >
> >
> > Thanks,
> > Chong.
> >
> >
> >
> > -----Original Message-----
> > From: Koenig, Christian <Christian.Koenig@amd.com>
> > Sent: Tuesday, November 18, 2025 5:31 PM
> > To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Chen, Horace <Horace.Chen@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds t=
imeout is not enough for sdma job
> >
> > Hi Chong,
> >
> > that is not a valid justification.
> >
> > What customer requirement is causing this SDMA timeout?
> >
> > When it is just your CI system then change the CI system.
> >
> > As long as you can't come up with a customer requirement this change is=
 rejected.
> >
> > Regards,
> > Christian.
> >
> > On 11/18/25 10:29, Li, Chong(Alan) wrote:
> >> [AMD Official Use Only - AMD Internal Distribution Only]
> >>
> >> Hi, Christian.
> >>
> >> In multiple vf mode( in our CI environment the vf number is 4), the ti=
meout value is shared across all vfs.
> >> After timeout value change to 2s, each vf only get 0.5s, cause sdma ri=
ng timeout and trigger gpu reset.
> >>
> >>
> >> Thanks,
> >> Chong.
> >>
> >> -----Original Message-----
> >> From: Koenig, Christian <Christian.Koenig@amd.com>
> >> Sent: Tuesday, November 18, 2025 4:34 PM
> >> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds =
timeout is not enough for sdma job
> >>
> >> Clear NAK to this patch.
> >>
> >> It is explicitely requested by customers that we only have a 2 second =
timeout.
> >>
> >> So you need a very good explanation to have that changed for SRIOV.
> >>
> >> Regards,
> >> Christian.
> >>
> >> On 11/17/25 07:53, chong li wrote:
> >>> Signed-off-by: chong li <chongli2@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
> >>>  2 files changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 69c29f47212d..4ab755eb5ec1 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_sett=
ings(struct amdgpu_device *adev)
> >>>       int index =3D 0;
> >>>       long timeout;
> >>>       int ret =3D 0;
> >>> +     long timeout_default;
> >>>
> >>> -     /* By default timeout for all queues is 2 sec */
> >>> +     if (amdgpu_sriov_vf(adev))
> >>> +             timeout_default =3D msecs_to_jiffies(10000);
> >>> +     else
> >>> +             timeout_default =3D msecs_to_jiffies(2000);
> >>> +     /* By default timeout for all queues is 10 sec in sriov, 2 sec =
not in sriov*/
> >>>       adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_time=
out =3D
> >>> -             adev->video_timeout =3D msecs_to_jiffies(2000);
> >>> +             adev->video_timeout =3D timeout_default;
> >>>
> >>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> >>>               return 0;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> >>> index f508c1a9fa2c..43bdd6c1bec2 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amd=
gpu_svm_default_granularity, uint
> >>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
> >>>   * Negative values mean infinity.
> >>>   *
> >>> - * By default(with no lockup_timeout settings), the timeout for all =
queues is 2000.
> >>> + * By default(with no lockup_timeout settings), the timeout for all =
queues is 10000 in sriov, 2000 not in sriov.
> >>>   */
> >>>  MODULE_PARM_DESC(lockup_timeout,
> >>> -              "GPU lockup timeout in ms (default: 2000. 0: keep defa=
ult value. negative: infinity timeout), format: [single value for all] or [=
GFX,Compute,SDMA,Video].");
> >>> +              "GPU lockup timeout in ms (default: 10000 in sriov, 20=
00 not in sriov. 0: keep default value. negative: infinity timeout), format=
: [single value for all] or [GFX,Compute,SDMA,Video].");
> >>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
> >>>                   sizeof(amdgpu_lockup_timeout), 0444);
> >>>
> >>
> >
>
