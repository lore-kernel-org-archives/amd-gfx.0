Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF704C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8990364EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8990364EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372D06E970;
	Wed, 10 Feb 2021 21:36:48 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870E66E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 21:36:47 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id e5so3249105otb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rV95dSvxBZSUB84JY1kAZKTq0gQWBQUuMY5nKD2rv08=;
 b=YlUG+3+K2MNRIVo2wBH7+nd5uHAnlrgi24HwUFqbqbpfjzlmg9uKUn9LBsQbFFUd3w
 5UaNlx/wyzXQGLNWRbFGLwYRsP85jBPXTYsPgYlUqBPSo2f3rwS/1vyPbdwxE2xqhjDK
 /LG9oXP7/AY3XYH3hr2D7wv2y6ojUE5euvnhAd+AcCyKQ5liXrO6ZVd6yFSzAcNA7PnV
 GdY1z9jpULhTEV6S+tO2y3i87TvwPbM8rX/MhIqvoqdr7j5elWMIf7B6ul+Oag5P8mKD
 AdwjaeucM/SAQ0n4bKU/nknIGYwPAkwx5HzylvKPFbzYW9XfOa1XrhBR1v/N/0sDiiSc
 P49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rV95dSvxBZSUB84JY1kAZKTq0gQWBQUuMY5nKD2rv08=;
 b=AK11W/VvIZvvkU+4gL6morXB+VV9g6DnCdt6tGqK9u5ZQy50AKUlLAaJ4d343sT2Ib
 Bq73qFI8jOIQEeKphcxWsO6x0Ccv/P4fM6mPdMFzBPe9W26SLSapXiL/Z++27sB36Kzq
 NM+5fWzCjrQygSDo6A9s2knq4BbRC44khmIul0N/G7B1AHzK3Vh4lEj8OttCJEkfETDz
 wIUrhZ8/3UDFBLPujDkDTzHHwixVhTyW5sB4LPZRhel60vKhzKbxU10MsSld/JXzHVdV
 QyVKj7p+622B23/5kBanZQcMBzsgV3ohXPj+Worc8+Sh/U7zM0elnro+dlOJFVMtDi/u
 xkvg==
X-Gm-Message-State: AOAM532hKU4+zaBP0ZQMVGQoMQv/IwHJ2+jNc/lL2c6UHo+v4piVsfIs
 mDpMkk80f/fUiXnZnC1XYo5XcW/hS6grZpbrV/s=
X-Google-Smtp-Source: ABdhPJzQSM4GuBgVchanYdqlyi18Nrt+60H5aQGmbTQvKJmotw/VeoEZI9t+e+IieQrU438CUQqf1yV716jjOF+46kk=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr3798695otg.132.1612993006838; 
 Wed, 10 Feb 2021 13:36:46 -0800 (PST)
MIME-Version: 1.0
References: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
 <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
In-Reply-To: <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Feb 2021 16:36:35 -0500
Message-ID: <CADnq5_NdULq_V79O01UprBdfL1V=dUsvTjXS5jaGv=bJB66J_Q@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Resending this one as well, in the hope of some clarification or background information.
>

I suspect this may have been a limitation from DCE11.0 (E.g.,
carrizo/stoney APUs).  They had some bandwidth limitations with
respect to high bit depth IIRC.  I suspect it should be fine on the
relevant dGPUs.  The code was probably originally added for the APUs
and just never updated or the changes were accidentally lost when we
consolidated the DCE code.  Unfortunately, there are not a lot of apps
that work properly in Linux with >8 bits per channel.

Alex


> Thanks,
> -mario
>
> On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner <mario.kleiner.de@gmail.com> wrote:
>>
>> Hi Harry and Nicholas,
>>
>> I'm still on an extended quest to squeeze as much HDR out of Linux + your hw as possible, although the paid contract with Vesa has officially ended by now, and stumbled over this little conundrum:
>>
>> DC's set_spatial_dither() function (see link below) has this particular comment:
>> "/* no 10bpc on DCE11*/" followed by code that skips dithering setup if the target output depth is 10 bpc:
>>
>> https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219
>>
>> I couldn't find any hint in the commit messages towards the reason, so why is that?
>>
>> This gets in the way if one has a HDR-10 monitor with 10 bit native output depth connected and wants to output a fp16 framebuffer and retain some of the > 10 bit linear precision by use of spatial dithering down to 10 bit. One only gets the same precision as a 10 bpc unorm fb. Also the routine is called for all DCE's, not only DCE11, so it affects all of them.
>>
>> The same restrictions don't exist in the old kms code for amdgpu-kms and radeon-kms. I added a mmio hack to Psychtoolbox to go behind the drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial dithering down to 10 bpc anyway to circumvent this limitation. My photometer measurements on fp16 framebuffers feeding into 10 bit output show that I get a nice looking response consistent with dithering to 10 bpc properly working on DCE. Also i don't see any visual artifacts in displayed pictures, so the hw seems to be just fine. This on DCE-11.2, and more lightly tested on DCE-8.3.
>>
>> So i wonder if this is some leftover from some hw bringup, or if there is a good reason for it being there? Maybe it could be removed or made more specific to some problematic asic?
>>
>> Thanks for any insights you could provide. Stay safe,
>> -mario
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
