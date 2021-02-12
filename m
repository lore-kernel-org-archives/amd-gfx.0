Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050AC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 05:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E87C64E38
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 05:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E87C64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42936E512;
	Fri, 12 Feb 2021 05:32:35 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC4E6E512
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 05:32:34 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id f3so5108922oiw.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RMfTAVPNol6WeuqEsiUBYFZXzrKBGhv/dOhUfN1HmT0=;
 b=oZYNxdFZSJnMzd8AroydNUvpsU+ku1vubkg6MBu5w6dSyY6MYa8P+prB1unmZRmcc3
 trsSsdwar+oFXuFSige+C5lNPA1zqVHHG5/fr9915GFf8YuNKdGD1zhZzn0Y7GoQUScv
 S3rom1+gMd5LZ3OGqBrvaXK1gzqlUKH/3ORdeMKpMz6u8+5ktVmI0U4QTL7zWS7Ri89a
 TsPeNxYCfvQ74WGT3VQUehulRigaX2w7C8P15ob+/VOpLOw4ngv73JzNMfdVAyZMRrYI
 yDNGiXcQYo7gpLVQXHWhyEJWk0G+3SkpLfHLgjCby3/JpPCsLP2M0Cw4Rmq1Ivy+iBk5
 V56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RMfTAVPNol6WeuqEsiUBYFZXzrKBGhv/dOhUfN1HmT0=;
 b=CTte8+dmcqPhSFndqVdXOO7PZgJGHy/eHHA2zEpOcv2ZnZqeQ/pg21ZZx+VJGBlnzg
 AXw16wG44p4znuMZ+F0QDanVfQMZWvjoMJK4XHAjpY/lIVkSMfYWrLuLWVWBrIC5thz5
 3ohmSD3/e9hbV5HMNVu3nvwgGLuxAI1d68f0KJVNJE70yDFdnjm4Cad4CovjbWCU253d
 a424xV3P+FoV9TEfvHGiH01vjfwgxIM7YTxopKW1CqdTUm27OOEWK+ydxBDpmhdGeB/s
 rF9YV+XtTjBh+kqUQJ0erVqRP5DUbCzDoosfbFdrzaYNzAzO/FtUzkfnllK7bcgnS7NU
 NiKw==
X-Gm-Message-State: AOAM530nVS6guD8Z9N3FwwPvAaSTXynlKjm6TWO4Brtw8eOCV0QH9U+8
 7AvW0Z+0LdiamGed4sTISmLFV9Eq2GQ8T15V6SE=
X-Google-Smtp-Source: ABdhPJwdhtIhPzdDyu606V0MZG5AcNwv6zZh7T2xJy/aku0eIWLUKH+MLxxLERfyKp5MdC9UQDG4r1cC6sG2q41PStA=
X-Received: by 2002:aca:c786:: with SMTP id x128mr821035oif.120.1613107953886; 
 Thu, 11 Feb 2021 21:32:33 -0800 (PST)
MIME-Version: 1.0
References: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
 <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
 <CADnq5_NdULq_V79O01UprBdfL1V=dUsvTjXS5jaGv=bJB66J_Q@mail.gmail.com>
 <CAEsyxyjmHfnc-w1jsJAxL8Zw5W1R9AiiUYd1-taKxX3Q3BfWfA@mail.gmail.com>
In-Reply-To: <CAEsyxyjmHfnc-w1jsJAxL8Zw5W1R9AiiUYd1-taKxX3Q3BfWfA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Feb 2021 00:32:23 -0500
Message-ID: <CADnq5_NpZdTRBfvUxFy=7Z5OSDUJKmiE++U2jsnLHM6BJ4FAfA@mail.gmail.com>
Subject: Re: Why no spatial dithering to 10 bit depth on DCE?
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 11, 2021 at 4:12 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> On Wed, Feb 10, 2021 at 10:36 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner
>> <mario.kleiner.de@gmail.com> wrote:
>> >
>> > Resending this one as well, in the hope of some clarification or background information.
>> >
>>
>
> Thanks Alex.
>
>> I suspect this may have been a limitation from DCE11.0 (E.g.,
>> carrizo/stoney APUs).  They had some bandwidth limitations with
>> respect to high bit depth IIRC.  I suspect it should be fine on the
>> relevant dGPUs.  The code was probably originally added for the APUs
>
>
> That sounds as if it would make sense for me to try to submit a patch to you that restricts this limitation to DCE 11.0 only?

I suspect older DCE 8.x APUs have similar limitations.  Although it
may only be an issue with multiple monitors or something like that.  I
don't remember the details.  @Harry Wentland do you remember?

>
> All i can say is during my testing with DCE-8.3 over HDMI and DCE-11.2 over DP under amdvlk with fp16 mode and ouptut_bpc set to 10 bpc, ie. dithering down from 12 bpc to 10 bpc, i didn't notice any problems when hacking this out, and photometer measurements showed good improvements of luminance reproduction with dithering.
>
>> and just never updated or the changes were accidentally lost when we
>> consolidated the DCE code.  Unfortunately, there are not a lot of apps
>> that work properly in Linux with >8 bits per channel.
>>
>
> Mine does ;-). As does apparently the Kodi media player. And at least Gnome/X11 works now, whereas KDE's Kwin/X11 used to work nicely, but regressed. And amdvlk does have fp16 support now since a while ago, so that's one way to get high precision without disturbing conventional desktop apps. I'll probably look into Mesa's Vulkan/WSI for 10 bpc / fp16 sometime this year if nobody beats me to it.
>

Sounds good.

Alex

> -mario
>
>
>> Alex
>>
>>
>> > Thanks,
>> > -mario
>> >
>> > On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner <mario.kleiner.de@gmail.com> wrote:
>> >>
>> >> Hi Harry and Nicholas,
>> >>
>> >> I'm still on an extended quest to squeeze as much HDR out of Linux + your hw as possible, although the paid contract with Vesa has officially ended by now, and stumbled over this little conundrum:
>> >>
>> >> DC's set_spatial_dither() function (see link below) has this particular comment:
>> >> "/* no 10bpc on DCE11*/" followed by code that skips dithering setup if the target output depth is 10 bpc:
>> >>
>> >> https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219
>> >>
>> >> I couldn't find any hint in the commit messages towards the reason, so why is that?
>> >>
>> >> This gets in the way if one has a HDR-10 monitor with 10 bit native output depth connected and wants to output a fp16 framebuffer and retain some of the > 10 bit linear precision by use of spatial dithering down to 10 bit. One only gets the same precision as a 10 bpc unorm fb. Also the routine is called for all DCE's, not only DCE11, so it affects all of them.
>> >>
>> >> The same restrictions don't exist in the old kms code for amdgpu-kms and radeon-kms. I added a mmio hack to Psychtoolbox to go behind the drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial dithering down to 10 bpc anyway to circumvent this limitation. My photometer measurements on fp16 framebuffers feeding into 10 bit output show that I get a nice looking response consistent with dithering to 10 bpc properly working on DCE. Also i don't see any visual artifacts in displayed pictures, so the hw seems to be just fine. This on DCE-11.2, and more lightly tested on DCE-8.3.
>> >>
>> >> So i wonder if this is some leftover from some hw bringup, or if there is a good reason for it being there? Maybe it could be removed or made more specific to some problematic asic?
>> >>
>> >> Thanks for any insights you could provide. Stay safe,
>> >> -mario
>> >>
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
