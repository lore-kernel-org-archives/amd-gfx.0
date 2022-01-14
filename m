Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E26DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3485810E202;
	Fri, 14 Jan 2022 20:30:56 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B84010E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:30:55 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 g1-20020a9d6481000000b00592d01f2b6eso7360133otl.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+p3lqSTHik3APVakaHQkUXMhdJii4QpyzHrr5zA48KQ=;
 b=KjfeYuv84OnYWKMuX0AjxhKrKnsa3p0f5+LmTfngclhfpF8IaE0lYjC0BHEefYgJyM
 TKTluEAPn75QYowHet384jjWqvitZGkJRFiQicmjI0MPVFpJQgFNOjzFXAa4PQ2i6GbV
 3CF/LWcuOh+pZLo7Prqw5qLMezl6B6161AIB0DZHMKwCYm7qtOYA9quFxsUoNypu1W4g
 v2vJn3qECioIDVVE06Be8bsXkkxmh80HKWfpNcvQNPS4bZLJ1A2RYV/b1TfkW+3QV1YX
 fmZmLG5Ti9/+vqjysE+5qyiMwrY1qXcUneGQTEUybGopJl7vHHSUASbJhmJh3DXJYeDe
 HZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+p3lqSTHik3APVakaHQkUXMhdJii4QpyzHrr5zA48KQ=;
 b=HH6uRsy37it+CvzVffwyBZaHHwFApej0NVKLKt+BTAiWZjnGKNb8M8oPdAudhd3ECd
 0fZj/hGcYy/eVB20i3py6sj+8hGKTNBdvcQJ6MslU5+uGyNqfAnlvqoMFtPAvPTqkxEX
 MZVaiwg1bD5na6LO6UtbA3ddRbGbFS9MRPRrrDXUSKS52/d1MR8YACSilJmEOjfjV7jf
 wfka0zv7pFtAUmetZw5KdEHDzOd/hD+/nEudpUpgYVHpmYp7kRlYDOD2TY7AzMKMLcIE
 cTj00JFMclgVk88CBioe9OHIeW1iMEhPSauyd9lj/aQixDXscMHPcnNMEvKU1jWGgXTi
 0Upg==
X-Gm-Message-State: AOAM533F21gsAabYJ7jK75713NMGTaQa8aop5EHwdhon6zXBhd0dLECY
 WDY1RkGDyMF6nt5fEW/0uOgUSt7EvJ76ghInv1w=
X-Google-Smtp-Source: ABdhPJw1KNTpz5f2vlTMcAHDO+rXIxDMaGVNwd1nLEBcV0m3iNepaqY/OkAGjLafsssy05E5vGVjiWXKEVGsE0vBBUc=
X-Received: by 2002:a9d:12f7:: with SMTP id g110mr8340325otg.299.1642192254743; 
 Fri, 14 Jan 2022 12:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
 <BL1PR12MB5157374DD79D0BF24D907DE3E2549@BL1PR12MB5157.namprd12.prod.outlook.com>
 <DM4PR12MB51821F1E18FB484415BACF31EC549@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D99E33BB70EF711EA66FE2549@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157D99E33BB70EF711EA66FE2549@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jan 2022 15:30:43 -0500
Message-ID: <CADnq5_OEbL8Q9R1VmvAG295TDA0sWyXNhFUmQdOx_RPmM-ueRg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 14, 2022 at 1:47 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > > >
> > > > >
> > > > >> I think the revert is fine once we figure out where we're missing calls to:
> > > > >>
> > > > >>          .optimize_pwr_state = dcn21_optimize_pwr_state,
> > > > >>          .exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
> > > > >>
> > > > >> These are already part of dc_link_detect, so I suspect there's another
> > > > interface
> > > > >> in DC that should be using these.
> > > > >>
> > > > >> I think the best way to debug this is to revert the patch locally and add a
> > > stack
> > > > >> dump when DMCUB hangs our times out.
> > > > > OK so I did this on top of amd-staging-drm-next with my v5 patch (this
> > > revert in
> > > > place)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > > > b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > > > > index 9280f2abd973..0bd32f82f3db 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > > > > +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> > > > > @@ -789,8 +789,10 @@ enum dmub_status
> > > > dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
> > > > >          // Execute command
> > > > >          status = dmub_srv_cmd_execute(dmub);
> > > > >
> > > > > -       if (status != DMUB_STATUS_OK)
> > > > > +       if (status != DMUB_STATUS_OK) {
> > > > > +               ASSERT(0);
> > > > >                  return status;
> > > > > +       }
> > > > >
> > > > >          // Wait for DMUB to process command
> > > > >          status = dmub_srv_wait_for_idle(dmub, 100000);
> > > > >
> > > > >> That way you can know where the PHY was trying to be accessed
> > > without the
> > > > >> refclk being on.
> > > > >>
> > > > >> We had a similar issue in DCN31 which didn't require a W/A like DCN21.
> > > > >>
> > > > >> I'd like to hold off on merging this until that hang is verified as gone.
> > > > >>
> > > > > Then I took a RN laptop running DMUB 0x01010019 and disabled eDP, and
> > > > confirmed
> > > > > no CRTC was configured but plugged in an HDMI cable:
> > > > >
> > > > > connector[78]: eDP-1
> > > > >          crtc=(null)
> > > > >          self_refresh_aware=0
> > > > > connector[85]: HDMI-A-1
> > > > >          crtc=crtc-1
> > > > >          self_refresh_aware=0
> > > > >
> > > > > I triggered 100 hotplugs like this:
> > > > >
> > > > > #!/bin/bash
> > > > > for i in {0..100..1}
> > > > > do
> > > > >      echo 1 | tee /sys/kernel/debug/dri/0/HDMI-A-1/trigger_hotplug
> > > > >      sleep 3
> > > > > done
> > > > >
> > > > > Unfortunately, no hang or traceback to be seen (and HDMI continues to
> > > work).
> > > > > I also manually pulled the plug a handful of times I don't know the
> > > specifics
> > > > that Lillian had the
> > > > > failure though, so this might not be a good enough check.
> > > > >
> > > > > I'll try to upgrade DMUB to 0x101001c (the latest version) and double
> > > check
> > > > that as well.
> > > >
> > > > I applied patch v5 and the above ASSERT patch, on top of both Linux
> > > > 5.16-rc8 and 5.16.
> > > >
> > > > Result: no problems with suspend/resume, 16+ cycles.
> > > >
> > > > As far as the hang goes:
> > > >
> > > > I plugged in an HDMI cable connected to my TV, and configured Gnome to
> > > > use the external display only.
> > > >
> > > > connectors from /sys/kernel/debug/dri/0/state:
> > > >
> > > > connector[78]: eDP-1
> > > >      crtc=(null)
> > > >      self_refresh_aware=0
> > > > connector[85]: HDMI-A-1
> > > >      crtc=crtc-1
> > > >      self_refresh_aware=0
> > > > connector[89]: DP-1
> > > >      crtc=(null)
> > > >      self_refresh_aware=0
> > > >
> > > > I manually unplugged/plugged the HDMI cable 16+ times, and also ran:
> > > >
> > > > $ sudo sh -c 'for ((i=0;i<100;i++)); do echo 1 | tee
> > > > /sys/kernel/debug/dri/0/HDMI-A-1/trigger_hotplug; sleep 3; done'
> > > >
> > > > The system did not hang, and I saw no kernel log output from the ASSERT.
> > > >
> > > > I also tried a USB-C dock with an HDMI port, with the same results,
> > > > though there are other issues with this (perhaps worthy of other bug
> > > > reports).
> > > >
> > > > Is there some reason to use amd-staging-drm-next for this test?
> > > >
> > > > I don't use the HDMI connection much and I have never experienced a
> > > hang
> > > > with HDMI in the first place. Can someone send a link to an
> > > > issue/discussion where this hang is being discussed?
> > > >
> > > > HW: HP ENVY x360 Convertible 15-ds1xxx, AMD Ryzen 7 4700U with
> > > Radeon
> > > > Graphics
> > > > OS/Desktop: Arch Linux, Gnome 41.3 (Wayland)
> > > > FW: linux-firmware-git 20211229.57d6b95-1, DMUB version=0x0101001C
> > > >
> > >
> > > Nicholas,
> > >
> > > We've got a handful of people now (myself included) who have done a
> > > bunch of
> > > physical and software triggered hotplugs on a variety of ports on top of both
> > > amd-staging-drm-next and 5.16 and not seeing any hangs.  Given this is
> > > lingering
> > > on 5.16, are you amenable to it and letting Lillian dig further after she returns
> > > on
> > > the specific case that she had problems with to see if we're missing anything
> > > else?
> > >
> > > Thanks,
> >
> > I think it was observed during HDMI compliance testing or frequent HDCP
> > enter/exit on Chrome, I don't remember the details off the top of my head. The
> > system would completely lock up under those conditions.
> >
> > I'm not familiar with the urgency of the request for your specific issue, but if you
> > feel that the tradeoff is worth it then you can go ahead and revert for now.
> >
> > Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> >
> > Regards,
> > Nicholas Kazlauskas
>
> Thanks.  Alex, when this pulls in can you add CC for stable so we get it in 5.16.1 too?

Yes, will do.

Alex
