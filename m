Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F65EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BF020707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlNQ0HAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BF020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6676E03A;
	Wed, 27 May 2020 22:35:31 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636406E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 22:35:30 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id q11so13738520wrp.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mSe7OSC9k55KR/gPQLXrzUAj79YEMC5f+2GwATpTyhU=;
 b=mlNQ0HAb+orwFZkuEM3vGovwlpiTGliHHis+8zMxlPK3v/VvkUzw9Jl2k0jA6IBOeK
 tu4DgGr4dcIFLvIj74UArvPPjC5UP5cLxcNOzE5j8zeHe8w8Y7bGsEq2C3fvw75fMsb2
 j2mnyK1L9TKYbKs8Nuj6bNUG9TF4fHLIoct1ogDYx53y+gYtv3w//v9bAKXy50RiSspE
 UQd6qF2co+UxxhYs+IPx2uYotovRKyi24ajyFzwz6sy5o3qP0FiGjLIDC+Ax2tAxonQs
 tmVyPb4kmdiZjBE/xJptsmPi3MdQ+AOilZHPWyIA8VSsAJh4lMV6rcRcyhfwySZXNypM
 sjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mSe7OSC9k55KR/gPQLXrzUAj79YEMC5f+2GwATpTyhU=;
 b=lUPEkN6/ZDfQzIYLbW3KG2Z6O/fBvrIsafYtvqBwcYhH5XDoSjaxSL9mHRB8veTlmT
 Jp7wcEDfWAl7BLLeArY2agmb5AvdUeeTEK/Hpfw2sgZym8+teAq6TkVlM5gQozwKV8dP
 b4T/zCzXDtdC/6BHL4pJwZLwfjeQ5roaRoP4ZhVG0gK046myd/U7umqBEv2pWnaODtHx
 kt6y1PhDKH8tz5GCZsUCAuV8KuAFnNkEc/RMzbbVEHWGNzBpWvL9zglgORG+83mm6EhF
 dwxVmVNdCqXkZ0nV+ztYxgtCFEoug7y+Lsyb4+UKP2c3j40pz2B5SaogvqQpNmld1rBX
 bBjg==
X-Gm-Message-State: AOAM530B8dOOcoIHWIPe9hgBD886GECYMj2Fnmga7pkeBcv6uIKNCBUM
 bKB4yflc2745D4sWBbsr27uYhPVenlztv7RBbsI=
X-Google-Smtp-Source: ABdhPJwKUigU09YsijgBFAVNrYN2SF/D2hdO4gtRTacTNOPolYmV2syRvgvBYJr/ZIKIyg9L5PLbCPMAbcbrOmuQGrI=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr471488wrs.374.1590618928980;
 Wed, 27 May 2020 15:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
 <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
 <cbba4d03-b4a2-1357-b5ba-1caf01a25f4f@amd.com>
 <DM6PR12MB4545A28C450D9C717F0870AAF3B60@DM6PR12MB4545.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2005280123530.18802@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2005280123530.18802@monopod.intra.ispras.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2020 18:35:17 -0400
Message-ID: <CADnq5_MbP6j4Rq_0xxYPBp16mxtyzn1t7MEbpWdq1Mnh53bUnw@mail.gmail.com>
Subject: Re: Flaky brightness on Renoir
To: Alexander Monakov <amonakov@ispras.ru>
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Chiu, Michael" <Michael.Chiu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 27, 2020 at 6:30 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> Hey,
>
> note that the driver does not call dmcu_load_iram on Renoir, as dm_late_init has
>
>     /* todo will enable for navi10 */
>     if (adev->asic_type <= CHIP_RAVEN) {
>         ret = dmcu_load_iram(dmcu, params);
>
> and there's no other callsite for dmcu_load_iram.
>
> Why is it necessary anyway? The driver seems to have perfectly working direct
> programming for PWM registers, so why the extra complications with brightness
> control via a microcontroller middleman?

The display guys can correct me if I'm wrong, but I believe it's
mainly for power savings.  I.e., the microcontroller can dynamically
adjust the backlight levels and gamma to save power while still having
the same apparent brightness.

Alex

>
> Thanks.
> Alexander
>
> On Wed, 20 May 2020, Koo, Anthony wrote:
>
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > It's touching around that area, but just the endian-ness change itself would not cause the boot-to-boot variation observed here. But it could cause broken backlight behavior.
> >
> > I also don't know what driver is being tested, so I don't know other details like whether we are using DMUB on this system.
> > But in general, I would try to check out whether those parameters look like they are loaded correctly.
> >
> > Thanks,
> > Anthony
> >
> > -----Original Message-----
> > From: Wentland, Harry <Harry.Wentland@amd.com>
> > Sent: Wednesday, May 20, 2020 6:08 PM
> > To: Koo, Anthony <Anthony.Koo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov <amonakov@ispras.ru>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>
> > Subject: Re: Flaky brightness on Renoir
> >
> > On 2020-05-20 6:03 p.m., Koo, Anthony wrote:
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Hi Harry,
> > >
> > > It does sound like a firmware issue.
> > > I think we will need to do some investigation here. I would be curious if this is a driver regression or just never worked (not sure how new the driver being tested is).
> > >
> > > This point below seems to indicate the firmware might be using some uninitialized values in some if its calculations.
> > > Typically these value would be things like backlight characteristic curves that are passed to the firmware via a table generated in the power helpers file, and programmed in our dc code.
> >
> > Do you think this could be related to Wyatt's endian-ness fixes?
> >
> > Harry
> >
> > > I'm not 100% sure this is the problem, but it could be something we can take a look at from dmcu_load_iram.
> > >>> There's a bugreport on the tracker from a person with the same
> > >>> laptop model as mine that says that the threshold may vary from boot to boot.
> > >
> > > Thanks,
> > > Anthony
> > >
> > > -----Original Message-----
> > > From: Wentland, Harry <Harry.Wentland@amd.com>
> > > Sent: Wednesday, May 20, 2020 5:53 PM
> > > To: Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov
> > > <amonakov@ispras.ru>; Kazlauskas, Nicholas
> > > <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>;
> > > Koo, Anthony <Anthony.Koo@amd.com>
> > > Subject: Re: Flaky brightness on Renoir
> > >
> > > We've seen similar problems internally.
> > >
> > > Michael, does this "fix" your issue?
> > >
> > > Anthony, looks like smooth_brightness is problematic on (some) renoir systems. Thoughts?
> > >
> > > Thanks,
> > > Harry
> > >
> > > On 2020-05-20 5:47 p.m., Alex Deucher wrote:
> > >> Adding some display people.
> > >>
> > >> On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> > >>>
> > >>> Hello,
> > >>>
> > >>> I have a laptop with the recent Renoir SoC. Screen brightness is
> > >>> controlled via the amdgpu driver. Unfortunately it doesn't work
> > >>> properly: brightness doesn't go below a certain threshold. In one
> > >>> experiment I've found the threshold to be about 95 (of 255), which
> > >>> is quite high.
> > >>>
> > >>> There's a bugreport on the tracker from a person with the same
> > >>> laptop model as mine that says that the threshold may vary from boot to boot.
> > >>>
> > >>> So far I was able to find a workaround: avoiding
> > >>> dmcu_set_backlight_level like in the patch below gives more reliable
> > >>> backlight control (but at the expense of breaking "actual_brightness"
> > >>> sysfs file, because it reads from DMCU registers).
> > >>>
> > >>> What might be the problem and can I help investigate this further?
> > >>> Would really like to see this work properly.
> > >>>
> > >>> Alexander
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> > >>> b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> > >>> index b8a3fc505c9b..3274b0d15893 100644
> > >>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> > >>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> > >>> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
> > >>>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
> > >>>
> > >>>         /* If DMCU is in reset state, DMCU is uninitialized */
> > >>> -       if (use_smooth_brightness)
> > >>> +       if (0 && use_smooth_brightness)
> > >>>                 dmcu_set_backlight_level(abm_dce,
> > >>>                                 backlight_pwm_u16_16,
> > >>>                                 frame_ramp,
> > >>> _______________________________________________
> > >>> amd-gfx mailing list
> > >>> amd-gfx@lists.freedesktop.org
> > >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
