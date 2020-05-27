Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6891C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475E720707
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475E720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AED89B05;
	Wed, 27 May 2020 22:33:10 +0000 (UTC)
Received: from smtp.ispras.ru (winnie.ispras.ru [83.149.199.91])
 by gabe.freedesktop.org (Postfix) with ESMTP id 383CD8999A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 22:30:35 +0000 (UTC)
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
 by smtp.ispras.ru (Postfix) with ESMTP id 91AB3201D0;
 Thu, 28 May 2020 01:30:32 +0300 (MSK)
Date: Thu, 28 May 2020 01:30:32 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: "Koo, Anthony" <Anthony.Koo@amd.com>
Subject: RE: Flaky brightness on Renoir
In-Reply-To: <DM6PR12MB4545A28C450D9C717F0870AAF3B60@DM6PR12MB4545.namprd12.prod.outlook.com>
Message-ID: <alpine.LNX.2.20.13.2005280123530.18802@monopod.intra.ispras.ru>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
 <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
 <cbba4d03-b4a2-1357-b5ba-1caf01a25f4f@amd.com>
 <DM6PR12MB4545A28C450D9C717F0870AAF3B60@DM6PR12MB4545.namprd12.prod.outlook.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 27 May 2020 22:33:09 +0000
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Chiu, Michael" <Michael.Chiu@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey,

note that the driver does not call dmcu_load_iram on Renoir, as dm_late_init has

    /* todo will enable for navi10 */
    if (adev->asic_type <= CHIP_RAVEN) {
	ret = dmcu_load_iram(dmcu, params);

and there's no other callsite for dmcu_load_iram.

Why is it necessary anyway? The driver seems to have perfectly working direct
programming for PWM registers, so why the extra complications with brightness
control via a microcontroller middleman?

Thanks.
Alexander

On Wed, 20 May 2020, Koo, Anthony wrote:

> [AMD Official Use Only - Internal Distribution Only]
> 
> It's touching around that area, but just the endian-ness change itself would not cause the boot-to-boot variation observed here. But it could cause broken backlight behavior.
> 
> I also don't know what driver is being tested, so I don't know other details like whether we are using DMUB on this system.
> But in general, I would try to check out whether those parameters look like they are loaded correctly.
> 
> Thanks,
> Anthony
> 
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com>
> Sent: Wednesday, May 20, 2020 6:08 PM
> To: Koo, Anthony <Anthony.Koo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov <amonakov@ispras.ru>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>
> Subject: Re: Flaky brightness on Renoir
> 
> On 2020-05-20 6:03 p.m., Koo, Anthony wrote:
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi Harry,
> >
> > It does sound like a firmware issue.
> > I think we will need to do some investigation here. I would be curious if this is a driver regression or just never worked (not sure how new the driver being tested is).
> >
> > This point below seems to indicate the firmware might be using some uninitialized values in some if its calculations.
> > Typically these value would be things like backlight characteristic curves that are passed to the firmware via a table generated in the power helpers file, and programmed in our dc code.
> 
> Do you think this could be related to Wyatt's endian-ness fixes?
> 
> Harry
> 
> > I'm not 100% sure this is the problem, but it could be something we can take a look at from dmcu_load_iram.
> >>> There's a bugreport on the tracker from a person with the same
> >>> laptop model as mine that says that the threshold may vary from boot to boot.
> >
> > Thanks,
> > Anthony
> >
> > -----Original Message-----
> > From: Wentland, Harry <Harry.Wentland@amd.com>
> > Sent: Wednesday, May 20, 2020 5:53 PM
> > To: Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov
> > <amonakov@ispras.ru>; Kazlauskas, Nicholas
> > <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>;
> > Koo, Anthony <Anthony.Koo@amd.com>
> > Subject: Re: Flaky brightness on Renoir
> >
> > We've seen similar problems internally.
> >
> > Michael, does this "fix" your issue?
> >
> > Anthony, looks like smooth_brightness is problematic on (some) renoir systems. Thoughts?
> >
> > Thanks,
> > Harry
> >
> > On 2020-05-20 5:47 p.m., Alex Deucher wrote:
> >> Adding some display people.
> >>
> >> On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> >>>
> >>> Hello,
> >>>
> >>> I have a laptop with the recent Renoir SoC. Screen brightness is
> >>> controlled via the amdgpu driver. Unfortunately it doesn't work
> >>> properly: brightness doesn't go below a certain threshold. In one
> >>> experiment I've found the threshold to be about 95 (of 255), which
> >>> is quite high.
> >>>
> >>> There's a bugreport on the tracker from a person with the same
> >>> laptop model as mine that says that the threshold may vary from boot to boot.
> >>>
> >>> So far I was able to find a workaround: avoiding
> >>> dmcu_set_backlight_level like in the patch below gives more reliable
> >>> backlight control (but at the expense of breaking "actual_brightness"
> >>> sysfs file, because it reads from DMCU registers).
> >>>
> >>> What might be the problem and can I help investigate this further?
> >>> Would really like to see this work properly.
> >>>
> >>> Alexander
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> >>> b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> >>> index b8a3fc505c9b..3274b0d15893 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> >>> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
> >>>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
> >>>
> >>>         /* If DMCU is in reset state, DMCU is uninitialized */
> >>> -       if (use_smooth_brightness)
> >>> +       if (0 && use_smooth_brightness)
> >>>                 dmcu_set_backlight_level(abm_dce,
> >>>                                 backlight_pwm_u16_16,
> >>>                                 frame_ramp,
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
