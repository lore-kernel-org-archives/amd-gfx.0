Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E51CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 19:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C05210ECB2;
	Fri, 10 Dec 2021 19:50:24 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479DD10EC9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 19:50:22 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id t19so14696658oij.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bEpB3ZCKGyxS8qAFwsnSAPIju7ZYtd1Vha92PPLX1bk=;
 b=haKz9C+ebWgTUVTC1h60xY+XTXAybLY8lO/cauMd1bUy7HmeL3A+rkue4AyJHa6xqx
 LzjYOWwTY5R/vc5lU3G6qdl0W5ASAOrAF/Kt8/w+9HiMEKprX7i1sq0D58kA7ZLio01r
 K5N1Z2K/PTtw0I7u35VGB6qrKM1DjC4x4d3BLGT3WcdLuDWlkoy2AU2gLBTywg/RMuRR
 9FJZL4MX0W433nYlzL8MSMingNXWLTdITdnGgY+Ar/qId+lbOByVst6fKOEqxQutOg4d
 UMz53u0tuQp4Ku3iNAeDwCSoD491rqbPBm6xIrcuXuUVsY9RbPAXBslKKjuoZu0QmqRP
 w/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bEpB3ZCKGyxS8qAFwsnSAPIju7ZYtd1Vha92PPLX1bk=;
 b=Vz0uffkowjkItW2bJVyTKv2fJS+rCDLsTTSvFvVGmXt0v6xDsQTrKtNuVt+2h96P74
 aqrLjAqGZJXMHd0e4ulF+jM0QHpGPDXYyerbUaKHhct8Qlw7JUm4SN0iaDC/bIIfipSg
 3eA48vDji7aRiLrizoNYw5iQNn5JKm86gZWmZ8D6W2I9gsIufp2DvJcKWxOcea8eri8v
 fNj/W7FvaYa1Z91PVSgxgf9q5yLiJMF9KED/IriDATZIs4dujawUHGj6bUZ3DrkfsPgF
 YxJ2Hf4VPY0pKAFd9zHqKWbXHnMTnoP3adq/5CIx0QHO6KUfmyl22F95tbaLRwd+xgmR
 Pslg==
X-Gm-Message-State: AOAM533iktmfelQQWZ9LLptabb/QgTaenIJ+tUmCEm6dHUgtYktYzN1q
 oDxVV0KCqQxZ3QwCvsVLFbESBn8vAtArVk7ubZw=
X-Google-Smtp-Source: ABdhPJz+0L9dqi5ET/kgIo4iCA+O5LajryZHhsvmM0MQVe8ESIIceT28epezPlfZVhkpWYM9j4NtyPuqjAyydiI+WuQ=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr14196960oib.120.1639165821538; 
 Fri, 10 Dec 2021 11:50:21 -0800 (PST)
MIME-Version: 1.0
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <DM6PR12MB2619D53D25DD05BC41D5A4A5E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D53D25DD05BC41D5A4A5E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 14:50:10 -0500
Message-ID: <CADnq5_NimkOY-WBKQyzkD8HFupYs0XY_inPHe1-dSpmReXKP2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
To: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gong,
 Curry" <Curry.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 10, 2021 at 11:06 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Curry,
>
> Some nitpicks below. With them fixed, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> @Deucher, Alexander this should be able address the issue reported by https://gitlab.freedesktop.org/drm/amd/-/issues/1828. Can you help to confirm this?

Yes, the patch works according to the reporter.

Alex

>
> BR
> Evan
> > -----Original Message-----
> > From: chen gong <curry.gong@amd.com>
> > Sent: Friday, December 10, 2021 7:42 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>; Quan,
> > Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Gong, Curry <Curry.Gong@amd.com>
> > Subject: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
> > powergating is explicitly enabled
> >
> > Play a video on the raven (or PCO, raven2) platform, and then do the S3
> > test. When resume, the following error will be reported:
> >
> > amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
> > ring
> > vcn_dec test failed (-110)
> > [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> > block
> > <vcn_v1_0> failed -110
> > amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> > PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
> >
> > [why]
> > When playing the video: The power state flag of the vcn block is set to
> > POWER_STATE_ON.
> >
> > When doing suspend: There is no change to the power state flag of the
> > vcn block, it is still POWER_STATE_ON.
> >
> > When doing resume: Need to open the power gate of the vcn block and set
> > the power state flag of the VCN block to POWER_STATE_ON.
> > But at this time, the power state flag of the vcn block is already
> > POWER_STATE_ON. The power status flag check in the "8f2cdef
> > drm/amd/pm:
> > avoid duplicate powergate/ungate setting" patch will return the
> > amdgpu_dpm_set_powergating_by_smu function directly.
> > As a result, the gate of the power was not opened, causing the
> > subsequent ring test to fail.
> Better to update this as some descriptions  below:
> adev-> vcn.idle_work will be triggered when the VCN ring idle for 1S. And we rely on it to do the VCN gate(power down).
> However, if the VCN ring is still using on suspend kicked, there will be no chance for adev->vcn.idle_work to do the VCN gate.
> That will make driver wrongly treat VCN as ungated(power on) and prevent further VCN ungate(power on) operation(which is actually needed) on resume.
> >
> > [how]
> > In the suspend function of the vcn block, explicitly change the power
> > state flag of the vcn block to POWER_STATE_OFF.
> Maybe some descriptions as below is better:
> Manually do the VCN gate(power down) in the suspend routine if adev->vcn.idle_work does not(have no chance) do that.
> >
> > Signed-off-by: chen gong <curry.gong@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index d54d720..d73676b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
> >  {
> >       int r;
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     bool cancel_success;
> This seems not a good naming since the cancel always succeed. The difference is whether the idle_work get actually executed.
>  Better to rename it as "idle_work_unexecuted" or just "vcn_not_gated"?
> > +
> > +     cancel_success = cancel_delayed_work_sync(&adev-
> > >vcn.idle_work);
> > +     if (cancel_success) {
> > +             if (adev->pm.dpm_enabled)
> > +                     amdgpu_dpm_enable_uvd(adev, false);
> > +     }
> >
> >       r = vcn_v1_0_hw_fini(adev);
> >       if (r)
> > --
> > 2.7.4
