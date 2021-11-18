Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE743C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE69461AE2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE69461AE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D6F6EC56;
	Thu, 18 Nov 2021 14:06:43 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1AC6EC52
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:06:42 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 v30-20020a4a315e000000b002c52d555875so2448326oog.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 06:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IyZ4NlF/8WDsQ3o+4xkHsq8vD5MvjqMciSbfcZFjABs=;
 b=W155b8KgKfSSIiZOCSosgjYesuteWUASgq5RV0aG5gpd+numrjQ/KwXHVAjPNCsbIg
 7aRPKP37P6h0Y/JE6bkiWiKVVESau2O7pLcOYsH+lQLrSz9cKsDDFh8moY9VuxCXtfoM
 g/zJafgF2qo/HofZ5MD4hhSUmbt7K+cxEAnlWCKwanBKhgAhcmobXvpjDa8tUi3rRcgg
 AC3ijiwS1B5VLqYh16+hkMa6Ef+E+mPw4kY9mHBAdS0ppi6YBCMSFhXaW9IGcq84y9te
 STMbe4zbx19qHKbvWkoUYP1lYm1B0+Zc0/EnMm8ldGSGmDgGIMLZ2O+WxSeNUt3+CrlD
 ts8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IyZ4NlF/8WDsQ3o+4xkHsq8vD5MvjqMciSbfcZFjABs=;
 b=yFM24io2mT8DYYMC1B4dixxvu7lP3sq8FWX00oNgDArLmMAjym2zq3nUNvb38NBkHg
 LXYKvDjvV2/X8FJRoRDOqot0W5PdI2ZKVCa8bXwgrq7Q864qXhOVo7p/4OGmMImxv+Qz
 8HYqREc+piwGwKperdsJeLnNyDNqa5hN5bbJWji5djP+1lkpkHfOTEaOFTnBq2snjjoo
 3R6havpQy9/C3xg69HmkbxNyz/Omsen5X6VfkukBeGZa8rqg1Cy2CT57gzX6zoSHwfyP
 xKib1fKGxa7EcJwQ0EMtIGd+jSxsGcI8u3tbzKhpmo1sgeSwJmK1TZL4kYllEUy+a6zx
 kD4A==
X-Gm-Message-State: AOAM533q6QaBz9NJ1TJBB3l3u8KZkh5OUkA4XBJifD7Fw9iwSjF4KPov
 tHmUFXwtwzVTZ3Asfs9UbPJEQRnA2qvXxDcqm4s=
X-Google-Smtp-Source: ABdhPJykI1mT4paCnh8MrS3KiBnpTQQiMiCl4wTZD0TFxoyYdYvqxDZNPlGcxCXJZgF/yQRjAvnWbwdeTKdWFQzAyQI=
X-Received: by 2002:a4a:dd93:: with SMTP id h19mr13266578oov.73.1637244401247; 
 Thu, 18 Nov 2021 06:06:41 -0800 (PST)
MIME-Version: 1.0
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Nov 2021 09:06:30 -0500
Message-ID: <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Thursday, November 18, 2021 4:01 PM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
> > aborted
> >
> >
> >
> > On 11/18/2021 12:32 PM, Prike Liang wrote:
> > > Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
> > > suspend to keep AMDGPU in a clean reset state and that can avoid
> > > re-initialize device improperly error.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
> > +++++++++++++++++++
> > >   3 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index b85b67a..8bd9833 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -1053,6 +1053,7 @@ struct amdgpu_device {
> > >     bool                            in_s3;
> > >     bool                            in_s4;
> > >     bool                            in_s0ix;
> > > +   bool                            pm_completed;
> >
> > PM framework maintains separate flags, why not use the same?
> >
> >          dev->power.is_suspended =3D false;
> >          dev->power.is_noirq_suspended =3D false;
> >          dev->power.is_late_suspended =3D false;
> >
>
> Thanks for pointing it out and I miss that flag. In this case we can use =
the PM flag is_noirq_suspended for checking AMDGPU device whether is finish=
ed suspend.
>
> > BTW, Alex posted a patch which does similar thing, though it tries rese=
t if
> > suspend fails.
> >
> > https://lore.kernel.org/all/DM6PR12MB26195F8E099407B4B6966FEBE4999@
> > DM6PR12MB2619.namprd12.prod.outlook.com/
> >
> > If that reset also failed, then no point in another reset, or keep it a=
s part of
> > resume.
> >
>
> Alex's patch seems always do the ASIC reset at the end of AMDGPU device, =
but that may needn't on the normal AMDGPU device suspend. However, this pat=
ch shows that can handle the system suspend aborted after AMDGPU suspend ca=
se well, so now seems we only need take care suspend abort case here.
>

Yeah, I was thinking we'd take this patch rather than mine to minimize
the number of resets.

Alex


> > Thanks,
> > Lijo
> >
> > >
> > >     atomic_t                        in_gpu_reset;
> > >     enum pp_mp1_state               mp1_state;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index ec42a6f..a12ed54 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
> > *dev, bool fbcon)
> > >     if (adev->in_s0ix)
> > >             amdgpu_gfx_state_change_set(adev,
> > sGpuChangeState_D0Entry);
> > >
> > > +   if (!adev->pm_completed) {
> > > +           dev_warn(adev->dev, "suspend aborted will do asic reset\n=
");
> > > +           amdgpu_asic_reset(adev);
> > > +   }
> > >     /* post card */
> > >     if (amdgpu_device_need_post(adev)) {
> > >             r =3D amdgpu_device_asic_init(adev); diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index eee3cf8..9f90017 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
> > device *dev)
> > >     return r;
> > >   }
> > >
> > > +/*
> > > + * Actually the PM suspend whether is completed should be confirmed
> > > + * by checking the sysfs
> > > +sys/power/suspend_stats/failed_suspend.However,
> > > + * in this function only check the AMDGPU device whether is suspende=
d
> > > + * completely in the system-wide suspend process.
> > > + */
> > > +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
> > > +   struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > > +   struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > +
> > > +   dev_dbg(dev, "amdgpu suspend completely.\n");
> > > +   adev->pm_completed =3D true;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >   static int amdgpu_pmops_resume(struct device *dev)
> > >   {
> > >     struct drm_device *drm_dev =3D dev_get_drvdata(dev); @@ -2181,6
> > > +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
> > >     r =3D amdgpu_device_resume(drm_dev, true);
> > >     if (amdgpu_acpi_is_s0ix_active(adev))
> > >             adev->in_s0ix =3D false;
> > > +   adev->pm_completed =3D false;
> > >     return r;
> > >   }
> > >
> > > @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
> > =3D {
> > >     .runtime_suspend =3D amdgpu_pmops_runtime_suspend,
> > >     .runtime_resume =3D amdgpu_pmops_runtime_resume,
> > >     .runtime_idle =3D amdgpu_pmops_runtime_idle,
> > > +   .suspend_noirq =3D amdgpu_pmops_noirq_suspend,
> > >   };
> > >
> > >   static int amdgpu_flush(struct file *f, fl_owner_t id)
> > >
