Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7FC54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD1210EA0D;
	Fri, 13 Jan 2023 14:57:25 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B679E10EA0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 14:57:23 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-15b9c93848dso14241612fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhVDQTTXtSQ6BxMIT+bnPOa36PNjhng8Gf5+BHqXVcU=;
 b=Z5qX4BVVtw6A50/wh7FRkRul6lLdnPdfl4zJMKpKABoaelV3oYR1vHg3kAUiems+mp
 0mNymWGe7FsIRMrD9f5VHM+Sh9Ek7t/YhRoehBSPwA2drSTP9C++Kb4PJY2joD783Jd/
 5Ff8Qqq9YmMFSdUv0tFYk9yh6/+M4t26FzuldiCbZZPYCBHiRssIP7hbtCrzMAOszW7N
 jabNQ23zVR7Qyz9GTPESYSZa32TTJPogOpqnAJmOSbkZPXPBiBXsdpxwQxm70tcey9NC
 AH2lWTHSXRGgnUgkLTdeKaqLUdHBpitkeoNaUoAVW2CrNFoWn+FhSnjwoIdOIlgcPRg7
 Byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhVDQTTXtSQ6BxMIT+bnPOa36PNjhng8Gf5+BHqXVcU=;
 b=Y93DzUmpAcdG4CPo/QnlUKki0y7n8PiOxtOjgtXAKJuCfXAK8C5qTZJE4fp4UC7ywB
 C6sEIwGz06ERONgw7T2/cBL3PAIJ1RD1BKRYUXsxkWzoaOUjwppzZZ/PDieZPctmMRhz
 nWU/HNAPYKG5dso5n0kDY3zqB9PEDkg8JkND/GiJmIr5x8r7URTVfp8XR9oBq2QVRQAW
 71BaN5Fdioh7abOy9M8uKKsqjPnag9XRYK1K1fVzIn4mqN/1dzvJEckz5FK8bVHWujUp
 PaQDU0xsbPg8PfTgME4TkLmvcTPMUqoj/7AI9Sp2w4zAeDBD1Ed+aDxAc4TvHeH38qUW
 dViQ==
X-Gm-Message-State: AFqh2koy+XLf5NcokM53uDVjLzl66WVMefwaegAcQ9L1qOfspnLIlAD4
 HgCPFrsap862HbylP/KCsCUC+Ds9gikGZzQ0aA60S4l7
X-Google-Smtp-Source: AMrXdXth3M1VQj9d2kMHaGvXy8UAbXLa7m/1SxLLRcW0atOe84ZnxacG21Md3wzaK55/p1G89zR/DuMpS1UNhcEpHQ4=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr3222520oab.96.1673621842964; Fri, 13
 Jan 2023 06:57:22 -0800 (PST)
MIME-Version: 1.0
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
In-Reply-To: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 09:57:11 -0500
Message-ID: <CADnq5_Nx2H+ywnFZmwix8tRc3mk54Nw=4L60ibtWybiO0CJZuw@mail.gmail.com>
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
To: Braiam <braiamp@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 9:47 AM Braiam <braiamp@gmail.com> wrote:
>
> Hi,
>
> I have two monitors with the current following configuration:
>
> Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
> DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
> right x axis y axis) 597mm x 336mm
>    2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
> 143.97   120.00    74.97
> [snip]
> DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
> axis y axis) 597mm x 336mm
>    2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
> 50.01    48.01   144.00   119.99    99.99
> [snip]
> HDMI-A-0 disconnected (normal left inverted right x axis y axis)
> HDMI-A-1 disconnected (normal left inverted right x axis y axis)
> DVI-D-0 disconnected (normal left inverted right x axis y axis)
>
> The pp_profile_mode:
>
> NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
> SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
>   0   BOOTUP_DEFAULT:        -                -                -
>          -                -                -
>   1 3D_FULL_SCREEN *:        0              100               30
>         10               60               25
>   2     POWER_SAVING:       10                0               30
>          -                -                -
>   3            VIDEO:        -                -                -
>         10               16               31
>   4               VR:        0               11               50
>          0              100               10
>   5          COMPUTE:        0                5               30
>          -                -                -
>   6           CUSTOM:        -                -                -
>          -                -                -
>
> I have set their refresh rate to 72.01 which is a mode equal for both,
> and the MCLK wasn't downclocked either. They are branded HP and
> Scepter. Using a vtty doesn't help either.
>
> Is having the exact same monitor really required? If not, how can I
> check what is causing
> the memory clock to be pegged that high?

It depends what GPU you have.  Older ones can only reclock memory
during the vertical blanking period assuming it's long enough as the
whole reclocking process takes a certain amount of time.  If it
doesn't happen during the blanking period you will get visible
glitches on the screen when the reclock happens.  If the vertical
blanking period is not long enough or if the vblank periods are not
aligned when using multiple monitors, the driver doesn't reclock.  The
mode lines (not just the refresh rate) have to be the exact same for
the vblanks to line up when using multiple monitors.  Your best bet is
to take the mode line you want to use from one monitor and apply it to
the other monitor.  Newer GPUs have more flexibility and can reclock
memory in more situations, but there are still some monitors where the
timing may not work out.

What GPU do you have?

Alex
