Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C4C5321D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916A710E4DD;
	Tue, 20 Aug 2024 06:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jMUp8oBv";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E3010E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 00:10:38 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so3814480a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724112637; x=1724717437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpNi7y25NOW9WpJ91nTcbryv9DTCk2XWRVVNUYkHi5I=;
 b=jMUp8oBv55Ve9Bn/GZ6AMECRPgql1fGslgSlx5rpP2NT9uBQuFFqP0625XXFIqfQ3S
 NRFMZkiqhW/m0l/4e/qXDBNi/LiCx05slCJwScR/DDJuD/yH8Vm09ufAJctvnJO1kPpl
 AMTFZrpofTAIjS32jLGJyZiBH0HUVNRWkMF6irckItsCjabcWVU4+5sJWSyYS2BxRBsI
 HkRKg3xNUeYjjbSKCF99v84FuWUObMUKpZnjbG+R8Rkox/siAukqzuMiaWSrPut1ydGD
 okpbbkvcJhElW2XFzP86/ZssG1dOqDXvP6Uh26aKE8EtRKTz/7/Egq+mEja9i0dnj3MO
 SpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112637; x=1724717437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpNi7y25NOW9WpJ91nTcbryv9DTCk2XWRVVNUYkHi5I=;
 b=nDTaKk5qU2l49xeag/VkKwgbhNUNeGMNY/T89yeUPDYHTnqVhUu4Fgz7fK6X2jWGQP
 Q2VAbMYcXteWf9knK2BSeGAgOA+lyJlCzAMU5cc0X621kTHgydBsF0lJFIO3BN+O8M0F
 qTag58eRLCbrmN12KSCU+u4Qx7Bei+GCMycSBCxwSxgDAf8FYhCjhLOyJF366w8zkTdB
 ZT/n2j1PDN5PpHAiIhZHRRI3Qo285k6Sz/MQkz3hp68imJ/LklXTCmcCH8YiKLD36vtf
 433PUaNoMUmoMH/taPAo4KdsVKKBNj5rjGOMzCtV8QZrX0D3snGCWNIuXkGepYsyypJU
 yiYg==
X-Gm-Message-State: AOJu0YxpKg4TvAx8CfD4807/mK1AnviIdpHPthJPr/pTKaFYLSTQhEE3
 Z3jaGZJ+tZFOdDFMPnMvdstC2BvkqnnBf0zdPcbH6vaxBU0cvRxgimgGB3m+sl46jn6bLb6S7CH
 bHHnoaGQHoXnpC+awdJYy5IUJi6yEcQ==
X-Google-Smtp-Source: AGHT+IH4K+qd+VWfj7HEDQ0l3vE2wBR/2/uYZ0o6c24pxMkDttI+unACJkeclICdLaQtCe8NK9vg3RxqATAx+RHhMms=
X-Received: by 2002:a05:6402:350d:b0:5be:feb0:ade6 with SMTP id
 4fb4d7f45d1cf-5befeb0af2amr2448293a12.6.1724112636271; Mon, 19 Aug 2024
 17:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
 <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
In-Reply-To: <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
From: Andrew Worsley <amworsley@gmail.com>
Date: Tue, 20 Aug 2024 10:10:24 +1000
Message-ID: <CA+Y=x3mOqUnRR8kbgcmB=-mrrggHHeF3xLJBVMyhse1b9aZNoQ@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Aug 2024 06:59:42 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 20 Aug 2024 at 00:13, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 19, 2024 at 9:55=E2=80=AFAM Andrew Worsley <amworsley@gmail.c=
om> wrote:
> >
> > The v6.11-rc4 linux hangs during amdgpu start up where as the v6.10.0
> > is fine. I had to take a photo of the screen (see attachment) from
.....
> > amdgpu 0000:c1:00.0: Direct firmware load for
> > amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> > amdgpu 0000:c1:00.0: amdgpu: try to fall back to amdgpu/gc_11_0_1_mes.b=
in
>
> -2 is -ENOENT which means the driver was not able to find the
> firmware.  I suspect you either didn't include the firmware in your
> kernel image (if you are building the driver in), or didn't include
> the firmware in your initrd (if the driver was built as a module).

  I wondered that but as the exact same message occurs on v6.10 and it's fi=
ne I
don't think that is the problem. See below

 The other question is why does it hang? - No other messages or anything.
I was thinking it switched to another frame buffer and crashed and
couldn't display the message?

I guess I could try and get the netconsole going to capture the crash?

> Alex
>
> >
> >   *** Hangs with this displayed on the console ****
> >     - have to power off computer to recover
> >
> > Perfectly successful boot with v6.10.0 kernel :
> >
.....
> > [    2.502588] amdgpu 0000:c1:00.0: [drm:jpeg_v4_0_early_init
> > [amdgpu]] JPEG decode is enabled in VM mode
> > [    2.503426] amdgpu 0000:c1:00.0: Direct firmware load for
> > amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> > [    2.504043] [drm] try to fall back to amdgpu/gc_11_0_1_mes.bin
> > [    2.505117] Console: switching to colour dummy device 80x25
> > [    2.505144] amdgpu 0000:c1:00.0: vgaarb: deactivate vga console
> > [    2.505147] amdgpu 0000:c1:00.0: amdgpu: Trusted Memory Zone (TMZ)
> > feature enabled
....
