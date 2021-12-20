Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08360C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 19:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAE211A1D7;
	Mon, 20 Dec 2021 19:25:15 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AF811A1D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 19:25:14 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 x19-20020a9d7053000000b0055c8b39420bso13817404otj.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tnDU5fZO7dWd8G6xW0M16I+f4i3WH7k1uM9qzFeh7IM=;
 b=B2hUoiF5LmLve0eUtevV/ZWGKddViZsO3WSnfc2Q/OW35BNi71As+bmnsouynVy8Tc
 ejUTZmHmde3GJEKW03/UdsFaAUef84cuMT/oxNXSL58UonP61KZ8sUtoSJqWIvTvIDVg
 GJzblR/XrxeqhRp7UVh4W89C5h6jfaGiSOMJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tnDU5fZO7dWd8G6xW0M16I+f4i3WH7k1uM9qzFeh7IM=;
 b=zLuIebDDcWLJdDMpqXQ3d4WwAQEUw3Lek9PQReGndOdW2Z8MOXu0FN/B72SfvBpnVo
 rfmhASn09aqYkOWlz9iU+ambOGo/yNEUr3f3o+5MEhjSaSoX4BZWORsBvjYYZb/Maa2D
 10xwy7/bJDaBoeIB7+WL/IE4Twe5pBp4wl0LjFzVIY3uKr+gRTuzTIbrnny+7+m+mbXo
 CoxfdkddDHvbFwHurnM63OwsiQPDkOqfUVuGkY5tz8m1jB4z3Ms4NeS7BJq2JrI3S0kP
 rdeyBnFTeb5GKxuJh3Lha+vD1WXwAhCfD35v1VErTPC7aUnbWOEkO63zOUOSTBzx/x8s
 iLQQ==
X-Gm-Message-State: AOAM5302mcWoVB5s65R6UmVncgGLPm10vKSxfGwnafVs31+eEO/JOvjc
 JtzQxPXrehuz8CkQv8EDdegURW2ujHcq2auRai41kw==
X-Google-Smtp-Source: ABdhPJwWZZs2K7aNc2Q7dfVWJm48zE7Wpuci4+5g99v1EIEGAfYcrpEHUOm4LcOkYaThA4khk0HcQxJGWhTPSWxQwhM=
X-Received: by 2002:a9d:7d89:: with SMTP id j9mr11974824otn.239.1640028313519; 
 Mon, 20 Dec 2021 11:25:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 Dec 2021 20:25:02 +0100
Message-ID: <CAKMK7uGAbE_t=D+5=F0mH3gzLOO8CCmqO8ofQ4HN8vS2RCK8Gg@mail.gmail.com>
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <harry.wentland@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Imre Deak <imre.deak@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding more amdgpu folks.

Smells like this runtime pm leak is papering over an issue in the
amdgpu driver. Other bug reports are also only about amdgpu.ko it
seems, would an unconditional pm_runtime_get_sync() in
amdgpu_pci_probe() also work? If you do it before the
drm_aperture_remove_conflicting_pci_framebuffers() which throws out
efifb it should be equivalent to the efifb revert.

That would avoid the revert for everyone else, but revert's fine too
imo this close to holidays. I don't think actually fixing this rpm fun
in a late -rc is realistic, these tend to be very gnarly.
-Daniel

On Mon, Dec 20, 2021 at 6:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So my lovely eldest daughter came back from NYC for xmas, and two days
> later was informed that she had been in contact with somebody who
> tested positive. And sure enough, so did she.
>
> I'm all vaxxed up and boostered, and feeling fine with just a slightly
> sore throat and no other symptoms, but I did test positive too a few
> days after that. And as a result I'm distancing in my office. It turns
> out that is not so hugely different from my normal life.
>
> One difference *is* that I now have an inflatable mattress and am
> sleeping here by my desktop, and as a result last night I noticed that
> my monitors didn't go to sleep. I had to turn them off manually to get
> the backlight to go away.
>
> So this morning I start to search for the reason, and find this listed
> by the regression bot, and sure enough, reverting commit 55285e21f045
> ("fbdev/efifb: Release PCI device's runtime PM ref during FB destroy")
> makes it all work again.
>
> I've reverted it in my private testing tree, in the hope that somebody
> figures out the actual real cause. But if that doesn't happen, I
> expect to revert it in my main git tree too before rc7.
>
> So this is mainly just a heads-up. I'm not seeing anything interesting
> in the kernel logs, apart from the usual unending stream of
>
>   [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
>   [drm] UVD and UVD ENC initialized successfully.
>   [drm] VCE initialized successfully.
>   [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
>   [drm] UVD and UVD ENC initialized successfully.
>   [drm] VCE initialized successfully.
>
> that happens randomly (sometimes every minute, sometimes hours apart)
> with or without that commit.
>
> This is some random Radeon card with two monitors attached (PCI ID
> 1002:67df rev e7, subsystem ID 1da2:e353).
>
> The symptoms are exactly as reported elsewhere:
>
>       https://lore.kernel.org/linux-fbdev/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/
>       https://linux-regtracking.leemhuis.info/regzbot/regression/8a27c986-4767-bd29-2073-6c4ffed49bba@jetfuse.net/
>       https://bugzilla.kernel.org/show_bug.cgi?id=215203
>
> ie I can lock my desktop, wait a few seconds, see the "No signal,
> enabling power management" on my monitors, but when that actually
> happens, the desktop lockscreen just comes right back.
>
> I suspect/assume that the screen off event triggers some status event
> on the GPU side, and now some pm logic then just wakes things right up
> again.
>
>                Linus



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
