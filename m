Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E08C83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378D620B80
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/22yGEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378D620B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CF06E053;
	Wed, 29 Apr 2020 15:48:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A0A6E053
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 15:47:59 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d15so3151084wrx.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nl5AzzUzfTdhg1mHlIElmuD4Tx4QKCT7uS5quGgMP68=;
 b=Y/22yGEwCTktzDgBxYn4qiD69fwdOl1JK2oztbwNpwouFrM2Yd8JVCy1CfcMHvA94L
 SxElDT2In37M2PgIe/7oZU7CP0zHUQtFrUSHfwm0Kw9j0XMWzy6tsGQOPvQSAPJGXkqs
 /GdeNrMHVOOQIMYR2bLsUKz14hVdvwOlIscuJEoT0cwjrXAcf7uCV408YbBjLSOuu7QP
 EKM3ifJTCwcltb5OXm/KaZeVXBAV65MppVSAXgT6o06qtPURLq8UD84S/ngH9EKRwMug
 wrxROl/OW+68Bf1lFEKSQVj0EbLdExYjAMlJCmw3HhEEht6EoI3tKz2+4nSjuXRf1mqI
 Nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nl5AzzUzfTdhg1mHlIElmuD4Tx4QKCT7uS5quGgMP68=;
 b=b1NLnby7B7krF3eDYhKYOm//jmJX6ZV0A43AiOCbRgzl8rxzUJFkF+H1813DZQm2cU
 /IIPog57Wydv4Gx5N+6mklP/k2cwXsEJQSx94MjbnPb4NCBty+HrGpZ/eyX00mvjbMgE
 aStjoaLP0vuYjDvqDRiAI8TFiRidj4mvg/V4t2yK5dqU1pRMSNvXzGx9oO2UERl4tguF
 Bd1Omb3wqbwwA6qWRynYjfkeAHCKwCDg5hpB7JiVfFKmY5BHpA7RCI1KpnyP0B1LqZws
 WevzzyofL9B7anBy2H0IxYaHfTNah7f+z8si9Gueju1jk77EeDfQf3rnT0kJP/0zSIoc
 3Oqg==
X-Gm-Message-State: AGi0PubXKJWAzUK3YgqSaEYzuTnQ0AZtj0wTuAOVvIQbObcn1sP8iOER
 EmVf1mINg5VCMq6Cda8SYXAHUwLQoW7li/CFbZU=
X-Google-Smtp-Source: APiQypKlZkfeVyprlnMk0JpJ4qRsS9JSbcJqDw8Hnr5PxEkZ9H2RD17LHTSdj/LatXAHPM2UQ0XKqDLxCcxDuAh90sE=
X-Received: by 2002:adf:f844:: with SMTP id d4mr39213645wrq.362.1588175278191; 
 Wed, 29 Apr 2020 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <MN2PR12MB4488E4909C1488FB507E0BF5F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <s5ho8rdnems.wl-tiwai@suse.de>
 <PSXP216MB04387BF6B5F8DA84749E5D6F80AF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CADnq5_M=QEqxuCKjb_qZvFSvwM5eLEFfsepxYYXoouFoe5bn7A@mail.gmail.com>
 <s5h4kt4ojrf.wl-tiwai@suse.de>
 <CADnq5_MMQ5_MjEg=bkJJGMJP53RjB3yxvOW0nUDeWxzg3Q0pVQ@mail.gmail.com>
 <s5hv9lkm49n.wl-tiwai@suse.de>
 <PSXP216MB043899DC52E6C6BF728D77CD80AC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <s5ha72ulp2y.wl-tiwai@suse.de>
 <PSXP216MB043822350CDE9E7EEA37730880AD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043822350CDE9E7EEA37730880AD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2020 11:47:47 -0400
Message-ID: <CADnq5_MCQ7xHY=yhNtRW=ze0LRPzxuu-Mm7pD4kFa5R52UrGSw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
To: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Takashi Iwai <tiwai@suse.com>, Lukas Wunner <lukas@wunner.de>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 29, 2020 at 11:27 AM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> On Wed, Apr 29, 2020 at 09:37:41AM +0200, Takashi Iwai wrote:
> > On Tue, 28 Apr 2020 16:48:45 +0200,
> > Nicholas Johnson wrote:
> > >
> > > > > > >
> > > > > > > FWIW, I have a fiji board in a desktop system and it worked fine when
> > > > > > > this code was enabled.
> > > > > >
> > > > > > Is the new DC code used for Fiji boards?  IIRC, the audio component
> > > > > > binding from amdgpu is enabled only for DC, and without the audio
> > > > > > component binding the runtime PM won't be linked up, hence you can't
> > > > > > power up GPU from the audio side access automatically.
> > > > > >
> > > > >
> > > > > Yes, DC is enabled by default for all cards with runtime pm enabled.
> > > >
> > > > OK, thanks, I found that amdgpu got bound via component in the dmesg
> > > > output, too:
> > > >
> > > > [   21.294927] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> > > >
> > > > This is the place soon after amdgpu driver gets initialized.
> > > > Then we see later another initialization phase:
> > > >
> > > > [   26.904127] rfkill: input handler enabled
> > > > [   37.264152] [drm] PCIE GART of 1024M enabled (table at 0x000000F400000000).
> > > >
> > > > here shows 10 seconds between them.  Then, it complained something:
> > > >
> > > >
> > > > [   37.363287] [drm] UVD initialized successfully.
> > > > [   37.473340] [drm] VCE initialized successfully.
> > > > [   37.477942] amdgpu 0000:08:00.0: [drm] Cannot find any crtc or sizes
> > >
> > > The above would be me hitting WindowsKey+P to change screens, but with
> > > no DisplayPort attached to Fiji, hence it unable to find crtc.
> > >
> > > >
> > > > ... and go further, and hitting HD-audio error:
> > > >
> > > That would be me having attached the DisplayPort and done WindowsKey+P
> > > again.
> > >
> > > > [   38.936624] [drm] fb mappable at 0x4B0696000
> > > > [   38.936626] [drm] vram apper at 0x4B0000000
> > > > [   38.936626] [drm] size 33177600
> > > > [   38.936627] [drm] fb depth is 24
> > > > [   38.936627] [drm]    pitch is 15360
> > > > [   38.936673] amdgpu 0000:08:00.0: fb1: amdgpudrmfb frame buffer device
> > > > [   40.092223] snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching to polling mode: last cmd=0x00170500
> > > >
> > > > After this point, HD-audio communication was screwed up.
> > > >
> > > > This lastcmd in the above message is AC_SET_POWER_STATE verb for the
> > > > root node to D0, so the very first command to power up the codec.
> > > > The rest commands are also about the power up of each node, so the
> > > > whole error indicate that the power up at runtime resume failed.
> > > >
> > > > So, this looks to me as if the device gets runtime-resumed at the bad
> > > > moment?
> > > It does. However, this is not going to be easy to pin down.
> > >
> > > I moved from Arch to Ubuntu, and it behaves differently. I cannot
> > > trigger the bug in Ubuntu. Plus, it puts the GPUs asleep, even if
> > > attached at boot, unlike Arch. I will continue to try to trigger it. But
> > > even if this is a problem with the Linux distribution, it should not be
> > > able to trigger a kernel mode bug, so we should persist with finding it.
> >
> > Sure, that's a bug to be fixed.
> >
> > This made me thinking what happens if we load the HD-audio driver very
> > late.  Could you try to blacklist snd-hda-intel module, then load it
> > manually after plugging the DP monitor and activating it?
> Attached dmesg-blacklist-*
>
> It is interesting. If I enable the monitor with the module unloaded, and
> then load the module, I cannot trigger the bug, even if disabling the
> monitor, waiting for GPU to sleep, and then waking again.
>
> Even if I wake monitor up, put to sleep again, and then insmod when
> sleeping, it does not cause bug when waking again.
>
> Is there anything special about the first time the monitor is used?
>

What do you mean by used?  Do you mean plugged in to the GPU or used
in the GUI?  It might be easier to debug this without a GUI involved.
Can you try this at runlevel 3 or something equivalent for your
distro?

When the GPU is powered up, the driver gets an interrupt when a
display is hotplugged and generates an event and userspace
applications can listen for these events.  When the GPU is powered
down, there's no interrupt.  I think most GUIs poll GPUs periodically
to handle this case so they can detect a new display even when the GPU
is off.  Maybe we are getting some sort of race here.  GUI queries GPU
driver, causes GPU to wake up, checks attached displays, GPU driver
resets runtime pm timer.  GPU goes back to sleep.  The detection
updates the ELD data which causes the HDA driver to wake up.  It
assumes the hw is on and tries to query it.  In the meantime, the GPU
has already powered everything down again.

Alex

> >
> > Also, could you track who called the problematic power-up sequence,
> > e.g. by adding WARN_ON_ONCE()?
> Attached dmesg-warning
>
> >
> > Last but not least, please check /proc/asound/card1/eld#* files (there
> > are both card0 and card1 or such that contain eld#* files, and one is
> > for i915 and another for amdgpu) before and after plugging.  This
> > shows whether the audio connection was recognized or not.
> Before plugging: card not yet attached, so the sysfs for that card not
> yet created
>
> After plugging (and insmod snd-hda-intel.ko):
> codec#0  codec#2  eld#2.0  eld#2.1  eld#2.2  eld#2.3  eld#2.4  eld#2.5  eld#2.6  eld#2.7  eld#2.8  id  pcm0c  pcm0p  pcm10p  pcm3p  pcm7p  pcm8p  pcm9p
>
> Regards,
> Nicholas
>
> >
> >
> > thanks,
> >
> > Takashi
> >
> > --- a/sound/hda/hdac_controller.c
> > +++ b/sound/hda/hdac_controller.c
> > @@ -224,6 +224,7 @@ void snd_hdac_bus_update_rirb(struct hdac_bus *bus)
> >                       dev_err_ratelimited(bus->dev,
> >                               "spurious response %#x:%#x, last cmd=%#08x\n",
> >                               res, res_ex, bus->last_cmd[addr]);
> > +                     WARN_ON_ONCE(1);
> >               }
> >       }
> >  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
