Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8AC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1766126A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B1766126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5843289346;
	Mon, 23 Aug 2021 13:30:26 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D3689346
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 13:30:24 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 l7-20020a0568302b0700b0051c0181deebso4587118otv.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qIO7uHmwXCzhN13BcVRmpkhoYqWBweDJh+FZr4KaBTo=;
 b=u+JXgWINjYWuP2mwkJRVwJdLY/OYqxw0LJD72xCOmCN+ETYK0wnN3G6L/yrjyEM9Q2
 fqioeWHwFqPXJnNVCwcDKPxWZaxUvtCMBI+eKVTml3aHjuvGD+QLrYCxAoi22CvqCVfh
 NOs0kgxEYEus85JuSYxueolBL2U8hAaWTWoXzleeopgadLdDvpuz1w/SS52xgPhsH/FG
 3F9OigUugHCDGWnKz/DwYH19XNaMrQAcWPzobm5DMetUGel1pOQqjx1IYPmWVml2CInI
 OEi2MfrgQ0ETeR3mzR5Kyprtp3iJwlnoUih5VMBaEywEfbjntmUdZ9weL/VDQZLpTPVK
 lpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qIO7uHmwXCzhN13BcVRmpkhoYqWBweDJh+FZr4KaBTo=;
 b=rP6PUdaMophSdDKHc7clWpkuvjz2+zDmlrqn8A8OOuQ5a6TAOOzrv0LZAOdgov2W3K
 dxFHO86xnCQ/eIMbmnv79IIZSGI7cdMo9oJccISoPakTGqfAptz/ttcNts7P1BHlvooa
 bP8m1Hu9VADikBU+8/KpONWzM+SFQikZK6vO6+Smlh50lxk5BIKB4Tv1UODUQ0R8WOqW
 6wNjHW1x9/hPmriCjKPic+TzmtIW1xTnrS+0H4/S5Vuod9ZqSiC0DyuUpMz45lKGw7Dt
 XWXGfyP8nhvd4dndvnZjrzttX4wXFNc52SotC3WSXkXfXqADKTJ2UPUySzKSAJ2rRHVK
 51Ug==
X-Gm-Message-State: AOAM533SCEscELEoE34AuSzy/47/dfwbBH8cH0O+39hWG9fFBNERABcb
 3D8KI/g6sYHjWKBHmWgOj+R9HNUsZCXYuBRikX4=
X-Google-Smtp-Source: ABdhPJwu7b+bo24RNYpmW4RJdl51BnWd0zmaCq+S/41P2HAkqJjV137B6rdPkONG+O5AWWzJcEbthFGkmiOW0D+DC5Y=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr14514248otf.311.1629725424237; 
 Mon, 23 Aug 2021 06:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819030859.1470753-1-evan.quan@amd.com>
 <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
 <BL1PR12MB5349E230CC22C6031E03DE9097C09@BL1PR12MB5349.namprd12.prod.outlook.com>
 <DM6PR12MB261971EBCF452097AA846F00E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_MfMi34f0HgurMYaxbGa1+J75fyiN5ZJ6m_4r-=PQOh8w@mail.gmail.com>
 <DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Aug 2021 09:30:13 -0400
Message-ID: <CADnq5_OFfFb8jgC+wnEmBwv1UbtC_z2u6A9zgvjAW9NHN1WRPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Leo" <Leo.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
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

On Mon, Aug 23, 2021 at 3:59 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 20, 2021 10:23 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, James <James.Zhu@amd.com>;
> > amd-gfx@lists.freedesktop.org; Liu, Leo <Leo.Liu@amd.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > UVD/VCE on suspend
> >
> > On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > Sent: Thursday, August 19, 2021 10:36 PM
> > > To: Zhu, James <James.Zhu@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > > If that is done  =E2=80=93
> > >
> > >
> > >
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +                                                      AMD_PG_STATE_G=
ATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +
> > > + AMD_CG_STATE_GATE);
> > >
> > >
> > >
> > > Usual order is CG followed by PG. It comes in the else part, so less =
likely to
> > happen. Nice to fix for code correctness purpose.
> > >
> > > [Quan, Evan] Thanks Lijo. Make sense to me. However, actually these c=
ode
> > were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c.
> > Same logic was used there. So, maybe @Zhu, James or @Liu, Leo can share
> > some insights about this.
> > >
> >
> > It looks like it is wrong there as well.  We should be gating the clock=
s before
> > the power.  The order is also wrong in amdgpu_uvd_ring_begin_use().  We
> > need to ungate the power before the clocks
> [Quan, Evan] I created a patch for this. But during the verification, I g=
ot the errors below
> [   87.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   88.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   89.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   90.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   91.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   92.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   93.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   94.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   95.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   96.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [   96.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
giving up!!!
> [   96.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]] *ERR=
OR* set_powergating_state of IP block <uvd_v6_0> failed -1
> [   97.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *=
ERROR* IB test failed on uvd (-110).
> [   98.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *=
ERROR* IB test failed on uvd_enc0 (-110).
> [   99.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *=
ERROR* IB test failed on uvd_enc1 (-110).
> [   99.857784] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ER=
ROR* ib ring test failed (-110).
>
> After checking the related source code roughly. It seems the underlaying =
implementation of -> set_powergating_state(e.g.  uvd_v6_0_set_powergating_s=
tate ) performs more jobs than just power gating. And I guess maybe some of=
 those jobs needs to be performed after -> set_clockgating_state. James and=
 Leo may comment more.
>

Ok.  Thanks for checking.  I have no objections to the patch as is.
We can address the ordering questions later.

Alex


> BR
> Evan
> >
> > Alex
> >
> >
> > >
> > >
> > > BR
> > >
> > > Evan
> > >
> > >
> > >
> > > Thanks,
> > >
> > > Lijo
> > >
> > >
> > >
> > > From: Zhu, James <James.Zhu@amd.com>
> > > Sent: Thursday, August 19, 2021 7:49 PM
> > > To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Pan, Xinhui
> > > <Xinhui.Pan@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >
> > >
> > > Why not move changes into hw_fini?
> > >
> > >
> > >
> > > Best Regards!
> > >
> > >
> > >
> > > James Zhu
> > >
> > > ________________________________
> > >
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > > Evan Quan <evan.quan@amd.com>
> > > Sent: Wednesday, August 18, 2021 11:08 PM
> > > To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> > > <Guchun.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> > > <Evan.Quan@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> > > Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > > UVD/VCE on suspend
> > >
> > >
> > >
> > > Perform proper cleanups on UVD/VCE suspend: powergate enablement,
> > > clockgating enablement and dpm disablement. This can fix some hangs
> > > observed on suspending when UVD/VCE still using(e.g. issue
> > > "pm-suspend" when video is still playing).
> > >
> > > Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24
> > ++++++++++++++++++++++++
> > > drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23
> > +++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > index 4eebf973a065..d0fc6ec18c29 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > > @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
> > >          int r;
> > >          struct amdgpu_device *adev =3D (struct amdgpu_device *)handl=
e;
> > >
> > > +       /*
> > > +        * Proper cleanups before halting the HW engine:
> > > +        *   - cancel the delayed idle work
> > > +        *   - enable powergating
> > > +        *   - enable clockgating
> > > +        *   - disable dpm
> > > +        *
> > > +        * TODO: to align with the VCN implementation, move the
> > > +        * jobs for clockgating/powergating/dpm setting to
> > > +        * ->set_powergating_state().
> > > +        */
> > > +       cancel_delayed_work_sync(&adev->uvd.idle_work);
> > > +
> > > +       if (adev->pm.dpm_enabled) {
> > > +               amdgpu_dpm_enable_uvd(adev, false);
> > > +       } else {
> > > +               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> > > +               /* shutdown the UVD block */
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +                                                      AMD_PG_STATE_G=
ATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_UVD,
> > > +                                                      AMD_CG_STATE_G=
ATE);
> > > +       }
> > > +
> > >          r =3D uvd_v6_0_hw_fini(adev);
> > >          if (r)
> > >                  return r;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > index 6d9108fa22e0..a594ade5d30a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > > @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
> > >          int r;
> > >          struct amdgpu_device *adev =3D (struct amdgpu_device *)handl=
e;
> > >
> > > +       /*
> > > +        * Proper cleanups before halting the HW engine:
> > > +        *   - cancel the delayed idle work
> > > +        *   - enable powergating
> > > +        *   - enable clockgating
> > > +        *   - disable dpm
> > > +        *
> > > +        * TODO: to align with the VCN implementation, move the
> > > +        * jobs for clockgating/powergating/dpm setting to
> > > +        * ->set_powergating_state().
> > > +        */
> > > +       cancel_delayed_work_sync(&adev->vce.idle_work);
> > > +
> > > +       if (adev->pm.dpm_enabled) {
> > > +               amdgpu_dpm_enable_vce(adev, false);
> > > +       } else {
> > > +               amdgpu_asic_set_vce_clocks(adev, 0, 0);
> > > +               amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > > +                                                      AMD_PG_STATE_G=
ATE);
> > > +               amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > > +                                                      AMD_CG_STATE_G=
ATE);
> > > +       }
> > > +
> > >          r =3D vce_v3_0_hw_fini(adev);
> > >          if (r)
> > >                  return r;
> > > --
> > > 2.29.0
