Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC44DC54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D6110EA15;
	Fri, 13 Jan 2023 15:09:52 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEBF10EA18
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:05:06 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id s8so7687494qkj.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 07:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uVrK1cyxYV/072COOLGKft9M2+XTzGZUJIv8QdAx04g=;
 b=diXi2Kj3sCn6cGao3w7W9xxAY4xJR+frVq0nca0vwpI7SH6fzzHphD37CLuAnPRBdv
 ebnNzl4cW8PIHTyJJz8yHoAhXx+noI0l7Fpk/gO7VoY/4UNZUAf9GoRnpIIj+BhanuNA
 qkk0t8PJkawToo8m/5IJeE94pT6Z7U9SD1LPPdQci9lmKSP0mO0Iv+uhL1utxcPb1esU
 2hSGNl5p1wE8Lnzl+QhhMG/Foqkdt7tcdxP0EWAJnAIBvSZYZthOsqh5KQsou/006o10
 hS30L7d17fgjp3Yowh3fVZKD43JiNuUNnSlYjrtEqzW3/7vJrll4NUfTyhJ/gkzzppjT
 jtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uVrK1cyxYV/072COOLGKft9M2+XTzGZUJIv8QdAx04g=;
 b=0IQMaPNy3ZukYVg5pWpO0RwsmDLBeshBs0fwWR4ZCZURc9i6eddPYQrYEA5TbNGxYl
 jVlkShf4oiIlAQO2pqPeW+i7zfthosYBBi/DDIdvkgrhkrnmek/euAcnqfKoDI5MXGrq
 JIZ0bgWZK8dYR+thtKGYJpkEpWEktXEzUlounP1cR225FGq6jJo5Sgmt/tGsDu/H0qvo
 Vr8/HC32JqExii1BcNORYFkWwEgWmD+nMYg+2iMgN9/fyjHoh4rtPkVEG88TZQFoEHjD
 wN1I/3yfBlFQXcd2dDrZkaPW1Yja+ZAfttHVJ4fH3tsDBWaszU8x0/wuexn+BGgg1EPd
 cWrA==
X-Gm-Message-State: AFqh2kpDc+milb6Na7hSyNtYOdjg5mEsYDkiJ3uwnF6lPaI2W894KkL6
 oz3POYyugWCTgwWHtkbiv58O2uSSTJO+oLdfCLw=
X-Google-Smtp-Source: AMrXdXuRpHbCrepUL1bu7kUIGygGY5t4qsbs0nd3yfUN5y4mPdD4RkSnv6rQIKfjxB+umxAgYtBh8mDuZevh3fj8XYw=
X-Received: by 2002:a05:620a:6d8:b0:706:219b:d3de with SMTP id
 24-20020a05620a06d800b00706219bd3demr69365qky.34.1673622305418; Fri, 13 Jan
 2023 07:05:05 -0800 (PST)
MIME-Version: 1.0
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
 <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
In-Reply-To: <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
From: Braiam <braiamp@gmail.com>
Date: Fri, 13 Jan 2023 11:04:55 -0400
Message-ID: <CAG=7Bt8xY_SHQwNCDgFCSNczBPxjUwjf_yvR_Ox-_XS+DVuJxA@mail.gmail.com>
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 13 Jan 2023 15:09:50 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD RX 590. Forgot to include it. How do I know the blanking period?
Would variable refresh rate mess up with that?

On Fri, Jan 13, 2023 at 10:57 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 9:47 AM Braiam <braiamp@gmail.com> wrote:
> >
> > Hi,
> >
> > I have two monitors with the current following configuration:
> >
> > Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
> > DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
> > right x axis y axis) 597mm x 336mm
> >    2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
> > 143.97   120.00    74.97
> > [snip]
> > DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
> > axis y axis) 597mm x 336mm
> >    2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
> > 50.01    48.01   144.00   119.99    99.99
> > [snip]
> > HDMI-A-0 disconnected (normal left inverted right x axis y axis)
> > HDMI-A-1 disconnected (normal left inverted right x axis y axis)
> > DVI-D-0 disconnected (normal left inverted right x axis y axis)
> >
> > The pp_profile_mode:
> >
> > NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
> > SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
> >   0   BOOTUP_DEFAULT:        -                -                -
> >          -                -                -
> >   1 3D_FULL_SCREEN *:        0              100               30
> >         10               60               25
> >   2     POWER_SAVING:       10                0               30
> >          -                -                -
> >   3            VIDEO:        -                -                -
> >         10               16               31
> >   4               VR:        0               11               50
> >          0              100               10
> >   5          COMPUTE:        0                5               30
> >          -                -                -
> >   6           CUSTOM:        -                -                -
> >          -                -                -
> >
> > I have set their refresh rate to 72.01 which is a mode equal for both,
> > and the MCLK wasn't downclocked either. They are branded HP and
> > Scepter. Using a vtty doesn't help either.
> >
> > Is having the exact same monitor really required? If not, how can I
> > check what is causing
> > the memory clock to be pegged that high?
>
> It depends what GPU you have.  Older ones can only reclock memory
> during the vertical blanking period assuming it's long enough as the
> whole reclocking process takes a certain amount of time.  If it
> doesn't happen during the blanking period you will get visible
> glitches on the screen when the reclock happens.  If the vertical
> blanking period is not long enough or if the vblank periods are not
> aligned when using multiple monitors, the driver doesn't reclock.  The
> mode lines (not just the refresh rate) have to be the exact same for
> the vblanks to line up when using multiple monitors.  Your best bet is
> to take the mode line you want to use from one monitor and apply it to
> the other monitor.  Newer GPUs have more flexibility and can reclock
> memory in more situations, but there are still some monitors where the
> timing may not work out.
>
> What GPU do you have?
>
> Alex



-- 
Braiam
