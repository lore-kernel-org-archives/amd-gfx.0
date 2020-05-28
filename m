Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C5C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 20:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF2D207BC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZeD8KmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF2D207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB58D6E5D1;
	Thu, 28 May 2020 20:29:16 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D8B6E5CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 20:29:15 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id x13so694320wrv.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uS32AB5B2zZI1U/1RAkbDyfG/s65BLewVv6mBNaNOEQ=;
 b=LZeD8KmFIKuMRX+dOhxOB61KSSFKSuAkmr5z6mt4msQHAJA7iVE4hM/FmM+Lam7lRX
 z90iy2KjegzyXbgSVw/JhbqV9NRsyyBADO7QQx0WBiXeBHXGQ+/UNx5jpSvxZK5jRNik
 LbrInwuYPiH9n1AqjKgnyLcyQn/Yp2aR2W/vAa15oK6wd4UKh2gcojb1ELEdFBnjUURa
 1zGPmmSNo3eBOnF4OGaP/sFtTnFoCWq+Fc8lLq01P+i1X9msvAmyaIpp0RIiusVRr/SS
 9pFCGposIRa+LGIU9I+V49uNAtxli+Ov0kAHEl1I7NoFOvpn+Lnzu8iBcz4Ba6zLNXzr
 TS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uS32AB5B2zZI1U/1RAkbDyfG/s65BLewVv6mBNaNOEQ=;
 b=R8bjRCsptOtlTdh4w1RvyQEhUmcoEGqPlDPMvTfVWNB30rpIB/RWZV1IjhEdGFyyO0
 56UJNQrfCTfnA+L7MziZb+7Oue/cXAV5Q3wWz/VkZCGWJpiZ0XQXiKnhiCX2yFhIs0+R
 KCvn5YJjhBwYriP6yYmyWFBaYDPThkb3DPBrqjAU2YdA21DWziaSzWU+B4YiVsksHZRZ
 8wN3tzel/ETNZJ/ZkxB2pXjfuNfNQaBRjIKNbMyyScFoNcLuWfYc1TdSIFJAWJi0rKFG
 nUR4rrAWf3tz2sbKnEai0ZIz0Xk1eYaXJSxSoKR0QwRGP2sISTo8pT512N/A77ctRzaD
 zOmg==
X-Gm-Message-State: AOAM532qZwJElZo3SNtNUZ5SOglEWVcXnpCtAko1/ZJCWBOnLwLzLkj5
 1gK9DLdBHvZxzIfgCFc7gqcI9KG0CVwxe/DYnWlX9w==
X-Google-Smtp-Source: ABdhPJy3PTxp39YZ8vrPVIVutvK9qT7NNf4Sk+IK2TTU2u3cWnHxqt1/oAWaW0Q4RPHwQQaWt1V99yvafy8I41O4ObI=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr5020291wrp.111.1590697754157; 
 Thu, 28 May 2020 13:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <91667893.917091.1590651127476.ref@mail.yahoo.com>
 <91667893.917091.1590651127476@mail.yahoo.com>
In-Reply-To: <91667893.917091.1590651127476@mail.yahoo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2020 16:29:02 -0400
Message-ID: <CADnq5_N_3QepQBn9cHq5yk3og6tGFNRgV1Rye+0Z0B+7B3okPw@mail.gmail.com>
Subject: Re: using amdgpu headless (no monitor)
To: Ian Rogers <gruffhacker-insta@yahoo.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 28, 2020 at 3:47 AM Ian Rogers <gruffhacker-insta@yahoo.com> wrote:
>
> Hi,
>
> Why can't virtual_display be used along with a physical display?
>

We've never had a use case to mix the two.

> I see from here: https://bugzilla.kernel.org/show_bug.cgi?id=203339 that the intention of the virtual_display module option is to allow for virtual displays and purposely disable physical/real displays.
> Is there a technical limitation that required this?
>

It was easier to implement them separately because they are self
contained and we don't have to deal with any interactions or
dependencies between real and fake elements of the display pipeline.

> I ask because I want to be able to run a system that is sometimes headless and sometimes not.  And I'd like to be able to access a current X session (either logged in or at the login greeter) both remotely (say via VNC) and locally via the physical display (when it is plugged in).without having to reboot or lose that X session.
>
> However I've noticed that (at least with a Ryzen 3 3200G with Radeon Vega 8) an X session does not login successfully when accessed remotely if there is no monitor connected.
> I assume this is caused by something in the amdgpu driver but I haven't been able to figure out what.

It's your display manager (X, mutter, kwin, etc.).  They generally
won't start if they doesn't detect a monitor.  You might be able to
force one via whatever configuration mechanism is provided by your
environment.

> So I was hoping that perhaps a solution would involve using virtual_display, but that won't work as it's currently designed because of it disabling the physical display.
>
> But maybe I've gone down the wrong track and there is another solution.  I've tried using the xorg dummy driver in addition to amdgpu, but when doing so, I can never get a physical display working.
> This is an Ubuntu 20.04 system with kernel 5.4.0.
>
> I can provide lots more detail on what I've tried and my config where needed.
>
> Thanks much
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
