Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB98C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 21:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE97613F5
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 21:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE97613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2605E6E8ED;
	Tue, 20 Apr 2021 21:25:22 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6CA6E8DD;
 Tue, 20 Apr 2021 21:25:20 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 i26-20020a9d625a0000b02902a2119f7613so329567otk.10; 
 Tue, 20 Apr 2021 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+94cd/jX9sjDc89stbH05qMt3apklq+Yobx3TwJ2KJw=;
 b=KayuPQnJClOx7SM+PA/ikbJmWWeVZQ3AHc/Gkw2ZgmSgRSuhjGdYbkFUyAkh7bOZAI
 PYWleZGj6bNHtoNmMh0ymLJlCT5A0cwZ8kz1BqDTWqGenWmjLC7VtQIdMh1ImLLl/MSp
 FIP2ixfRj1kGzzxXL9TD0Amm+/0Fo6/GUGidgONU8+S3DvG0fY3gjJG8G47MhUdM/NdJ
 K406CydUhI/RK8Q8SLB4dq44knKEhnMXNx3Gql92D/H2xZNG3ZznraXOrSzG8RLDOtNw
 U0D9Qfux1R1gLu+ZHi7siK6oJ+VgE0rh18hJTC5v38+abqf9lCbBX2rnsq82FfgzkTyQ
 XWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+94cd/jX9sjDc89stbH05qMt3apklq+Yobx3TwJ2KJw=;
 b=VaBP5XzjPKmIZb2IPt2Rd9h9t73KatkMJGto9ZaQ0ZHI0SArDGLPnXgwUEuu/LckSZ
 aHNeWrjW0Atiy0tun4cbO5j14WP2HLCmk+T04kZ/jlrrozLg4BR3nAGTmBzGA5yxeWeT
 zuds/GnQxWiPt1/zLV4x/G0C7PXz5yXwkN/RigXOjrz3Ol0WB28dCmu0bsSP00Vv9FiH
 Sir1kxu0thM2AEfTlcBgXLsVssUqrLdjihsOh32dVn1otgttbS/4El6cdeENfuxoJ4OV
 kKMr/6siwZb5PONNNHfcAmxmQ9CWJW9LOR3Sin3e8kwbzM6LgTAn5HROgzrg4t1eE3Jk
 1WWw==
X-Gm-Message-State: AOAM533CTwEp83t12NPHm/jucYNplE9+P9MhNxtmGQLvmQ8i7JpzjBvb
 03ZTgv8B6E7WChaVM0PGbZ/N9fKO5rYsu8I7E2o=
X-Google-Smtp-Source: ABdhPJyEBWlFxv39cCh3Ez/LGgDffyoElnokJUk8cIivV3xK6XxgEqMrnr1nVRtkJRUWiMnZ09qy7OgulHhQi+5fbP0=
X-Received: by 2002:a05:6830:15d3:: with SMTP id
 j19mr11040215otr.23.1618953920151; 
 Tue, 20 Apr 2021 14:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210319210317.32369-1-mario.kleiner.de@gmail.com>
 <CAEsyxygq1k4pTT-8ASuJn=rSzHBXyhy5jRStoBVmniR2B_MrJg@mail.gmail.com>
In-Reply-To: <CAEsyxygq1k4pTT-8ASuJn=rSzHBXyhy5jRStoBVmniR2B_MrJg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Apr 2021 17:25:09 -0400
Message-ID: <CADnq5_OtKZ3=pZR_F4zx2Bz1zvEzuxb4fQU41c-XTBT8-H4Byw@mail.gmail.com>
Subject: Re: 16 bpc fixed point (RGBA16) framebuffer support for core and AMD.
To: Mario Kleiner <mario.kleiner.de@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 16, 2021 at 12:29 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Friendly ping to the AMD people. Nicholas, Harry, Alex, any feedback?
> Would be great to get this in sooner than later.
>

No objections from me.

Alex


> Thanks and have a nice weekend,
> -mario
>
> On Fri, Mar 19, 2021 at 10:03 PM Mario Kleiner
> <mario.kleiner.de@gmail.com> wrote:
> >
> > Hi,
> >
> > this patch series adds the fourcc's for 16 bit fixed point unorm
> > framebuffers to the core, and then an implementation for AMD gpu's
> > with DisplayCore.
> >
> > This is intended to allow for pageflipping to, and direct scanout of,
> > Vulkan swapchain images in the format VK_FORMAT_R16G16B16A16_UNORM.
> > I have patched AMD's GPUOpen amdvlk OSS driver to enable this format
> > for swapchains, mapping to DRM_FORMAT_XBGR16161616:
> > Link: https://github.com/kleinerm/pal/commit/a25d4802074b13a8d5f7edc96ae45469ecbac3c4
> >
> > My main motivation for this is squeezing every bit of precision
> > out of the hardware for scientific and medical research applications,
> > where fp16 in the unorm range is limited to ~11 bpc effective linear
> > precision in the upper half [0.5;1.0] of the unorm range, although
> > the hardware could do at least 12 bpc.
> >
> > It has been successfully tested on AMD RavenRidge (DCN-1), and with
> > Polaris11 (DCE-11.2). Up to two displays were active on RavenRidge
> > (DP 2560x1440@144Hz + HDMI 2560x1440@120Hz), the maximum supported
> > on my hw, both running at 10 bpc DP output depth.
> >
> > Up to three displays were active on the Polaris (DP 2560x1440@144Hz +
> > 2560x1440@100Hz USB-C DP-altMode-to-HDMI converter + eDP 2880x1800@60Hz
> > Apple Retina panel), all running at 10 bpc output depth.
> >
> > No malfunctions, visual artifacts or other oddities were observed
> > (apart from an adventureous mess of cables and adapters on my desk),
> > suggesting it works.
> >
> > I used my automatic photometer measurement procedure to verify the
> > effective output precision of 10 bpc DP native signal + spatial
> > dithering in the gpu as enabled by the amdgpu driver. Results show
> > the expected 12 bpc precision i hoped for -- the current upper limit
> > for AMD display hw afaik.
> >
> > So it seems to work in the way i hoped :).
> >
> > Some open questions wrt. AMD DC, to be addressed in this patch series, or follow up
> > patches if neccessary:
> >
> > - For the atomic check for plane scaling, the current patch will
> > apply the same hw limits as for other rgb fixed point fb's, e.g.,
> > for 8 bpc rgb8. Is this correct? Or would we need to use the fp16
> > limits, because this is also a 64 bpp format? Or something new
> > entirely?
> >
> > - I haven't added the new fourcc to the DCC tables yet. Should i?
> >
> > - I had to change an assert for DCE to allow 36bpp linebuffers (patch 4/5).
> > It looks to me as if that assert was inconsistent with other places
> > in the driver where COLOR_DEPTH121212 is supported, and looking at
> > the code, the change seems harmless. At least on DCE-11.2 the change
> > didn't cause any noticeable (by myself) or measurable (by my equipment)
> > problems on any of the 3 connected displays.
> >
> > - Related to that change, while i needed to increase lb pixelsize to 36bpp
> > to get > 10 bpc effective precision on DCN, i didn't need to do that
> > on DCE. Also no change of lb pixelsize was needed on either DCN or DCe
> > to get > 10 bpc precision for fp16 framebuffers, so something seems to
> > behave differently for floating point 16 vs. fixed point 16. This all
> > seems to suggest one could leave lb pixelsize at the old 30 bpp value
> > on at least DCE-11.2 and still get the > 10 bpc precision if one wanted
> > to avoid the changes of patch 4/5.
> >
> > Thanks,
> > -mario
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
